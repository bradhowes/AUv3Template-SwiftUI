#include "__NAME___Kernel.hpp"

void ___NAME___Kernel_retain(__NAME___Kernel* _Nonnull obj) noexcept
{
  obj->instrusiveReferenceCountedRetain();
}

void ___NAME___Kernel_release(__NAME___Kernel* _Nonnull obj) noexcept
{
  obj->instrusiveReferenceCountedRelease();
}
