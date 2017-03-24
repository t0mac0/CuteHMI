#ifndef DATABLOCK_HPP
#define DATABLOCK_HPP

#include "internal/common.hpp"

#include <utils/NonCopyable.hpp>

#include <memory>

namespace cutehmi {
namespace base {

/**
 * Data block. This class provides basic functionality for the derived classes, which allows them to be chained together.
 * This functionality is similar to singly linked list. Each DataBlock object can have a DataBlock child appended to it.
 *
 * <principle id="cutehmi.base.DataBlock.determined_destruction_order">
 * Child objects are destroyed in the reverse order as they were appended.
 * </principle>
 */
class CUTEHMI_BASE_API DataBlock:
	public utils::NonCopyable
{
	template <typename BLOCK>
	struct Iterator;

	public:
		typedef Iterator<DataBlock> iterator;
		typedef Iterator<const DataBlock> const_iterator;

		/**
		 * Default constructor.
		 */
		DataBlock();

		virtual ~DataBlock() = default;

		/**
		 * Child data block.
		 * @return child data block or @p nullptr.
		 */
		DataBlock * child() const;

		/**
		 * Append data block. Data block is appended to the last child in the chain.
		 * @param block data block to be appended.
		 *
		 * @note this class is not intended to be used with long data chains. The amount of time used by append operation is linearly
		 * proportional to the size of the chain; O(n) in terms of algorithmic complexity.
		 */
		void append(std::unique_ptr<DataBlock> block);

		/**
		 * Count blocks in the chain.
		 * @return number of blocks appended to the current block.
		 */
		int count() const;

		iterator begin();

		const_iterator begin() const;

		iterator end();

		const_iterator end() const;

	protected:
		DataBlock(DataBlock && other) = default;

		DataBlock & operator =(DataBlock && other) = default;

	private:
		struct Members
		{
			//<principle_ref id="cutehmi.base.DataBlock.determined_destruction_order">
			std::unique_ptr<DataBlock> child;
			//</principle_ref>
		};

		template <typename BLOCK>
		struct Iterator :
			public std::iterator<std::forward_iterator_tag, BLOCK, std::ptrdiff_t>
		{
			typedef std::iterator<std::forward_iterator_tag, BLOCK, std::ptrdiff_t> Parent;

			typedef typename Parent::value_type value_type;
			typedef typename Parent::reference reference;
			typedef typename Parent::difference_type difference_type;
			typedef typename Parent::pointer pointer;
			typedef typename Parent::iterator_category iterator_category;

			// std::forward_iterator_tag
			Iterator();

			/**
			 * Constructor.
			 * @param block data block.
			 */
			Iterator(BLOCK * block);

			// std::forward_iterator_tag
			reference operator *() const;

			// std::forward_iterator_tag
			pointer operator ->() const;

			// std::forward_iterator_tag
			Iterator & operator ++();

			// std::forward_iterator_tag
			Iterator operator ++(int);

			// std::forward_iterator_tag
			bool operator ==(const Iterator & other) const;

			// std::forward_iterator_tag
			bool operator !=(const Iterator & other) const;

			private:
				BLOCK * m_me;
		};

		std::unique_ptr<Members> m;
};

template <typename BLOCK>
DataBlock::Iterator<BLOCK>::Iterator():
	m_me(nullptr)
{
}

template <typename BLOCK>
DataBlock::Iterator<BLOCK>::Iterator(BLOCK * block):
	m_me(block)
{
}

template <typename BLOCK>
typename DataBlock::Iterator<BLOCK>::reference DataBlock::Iterator<BLOCK>::operator *() const
{
	Q_ASSERT(m_me != nullptr);

	return *m_me;
}

template <typename BLOCK>
typename DataBlock::Iterator<BLOCK>::pointer DataBlock::Iterator<BLOCK>::operator ->() const
{
	Q_ASSERT(m_me != nullptr);

	return m_me;
}

template <typename BLOCK>
DataBlock::Iterator<BLOCK> & DataBlock::Iterator<BLOCK>::operator ++()
{
	Q_ASSERT(m_me != nullptr);

	m_me = m_me->child();

	return *this;
}

template <typename BLOCK>
DataBlock::Iterator<BLOCK> DataBlock::Iterator<BLOCK>::operator ++(int)
{
	Iterator<BLOCK> copy(*this);
	++(*this);
	return copy;
}

template <typename BLOCK>
bool DataBlock::Iterator<BLOCK>::operator ==(const Iterator & other) const
{
	return other.m_me == m_me;
}

template <typename BLOCK>
bool DataBlock::Iterator<BLOCK>::operator !=(const Iterator & other) const
{
	return other.m_me != m_me;
}

}
}

#endif // DATABLOCK_HPP
