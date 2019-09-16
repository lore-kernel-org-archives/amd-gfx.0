From: Jason Gunthorpe <jgg@mellanox.com>
Subject: [GIT PULL] Please pull hmm related changes
Date: Mon, 16 Sep 2019 16:23:57 +0000
Message-ID: <20190916162350.GA19191@ziepe.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Content-ID: <F2BA21788EEDCB45B74193F50B0DE9A2@eurprd05.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Dan Williams <dan.j.williams@intel.com>, Christoph Hellwig <hch@lst.de>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Kuehling, Felix" <Felix.Kuehling@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>, Dimitri Sivanich <sivanich@hpe.com>, "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: amd-gfx.lists.freedesktop.org

Hi Linus,

Continuing on the cleanup theme from last merge window, here is
another set of hmm and closely related patches that are largely
cleanups and bug fixes without any particularly notable functional
change.

The diffstat below covers a wide section of the kernel, but a lot of
this is caused by Christoph's series to revise the page walker
API. After discussion we opted to put that series into this tree to
avoid conflicts/etc.

Otherwise this is a pleasant reduction in LOC.

Although we continue to try to get reviews, we once again have not got
too many Acks from core mm people. However the users of these APIs
have again contributed a fair number of acks, reviews and tests.

I am aware of no conflicts this cycle, however Andrew has several
smaller patches queued waiting on changes in here.

Included is a branch shared with rdma.git fixing up ODP enough to
allow the get/put transformation.

For next merge window I already see there are patches posted to add a
test suite for hmm_range_fault() and fix bugs, I am working on a
series to harmonize the mmu notifier & interval tree pattern, and also
to get ODP using hmm_range_fault(). I think we will need to do this
tree at least one more time.

Thanks,
Jason

The following changes since commit 27b7fb1ab7bfad45f5702ff0c78a4822a41b1456=
:

  RDMA/mlx5: Fix MR npages calculation for IB_ACCESS_HUGETLB (2019-08-20 13=
:44:43 -0400)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linu=
s-hmm

for you to fetch changes up to 62974fc389b364d8af70e044836362222bd3ae53:

  libnvdimm: Enable unit test infrastructure compile checks (2019-09-07 04:=
28:05 -0300)

----------------------------------------------------------------
hmm related patches for 5.4

This is more cleanup and consolidation of the hmm APIs and the very
strongly related mmu_notifier interfaces. Many places across the tree
using these interfaces are touched in the process. Beyond that a cleanup
to the page walker API and a few memremap related changes round out the
series:

- General improvement of hmm_range_fault() and related APIs, more
  documentation, bug fixes from testing, API simplification &
  consolidation, and unused API removal

- Simplify the hmm related kconfigs to HMM_MIRROR and DEVICE_PRIVATE, and
  make them internal kconfig selects

- Hoist a lot of code related to mmu notifier attachment out of drivers by
  using a refcount get/put attachment idiom and remove the convoluted
  mmu_notifier_unregister_no_release() and related APIs.

- General API improvement for the migrate_vma API and revision of its only
  user in nouveau

- Annotate mmu_notifiers with lockdep and sleeping region debugging

Two series unrelated to HMM or mmu_notifiers came along due to
dependencies:

- Allow pagemap's memremap_pages family of APIs to work without providing
  a struct device

- Make walk_page_range() and related use a constant structure for function
  pointers

----------------------------------------------------------------
Christoph Hellwig (35):
      nouveau: return -EBUSY when hmm_range_wait_until_valid fails
      mm/hmm: remove the legacy hmm_pfn_* APIs
      mm/hmm: replace the block argument to hmm_range_fault with a flags va=
lue
      mm/hmm: merge hmm_range_snapshot into hmm_range_fault
      amdgpu: remove -EAGAIN handling for hmm_range_fault
      amdgpu: don't initialize range->list in amdgpu_hmm_init_range
      nouveau: pass struct nouveau_svmm to nouveau_range_fault
      mm/hmm: remove the unused vma argument to hmm_range_dma_unmap
      mm/hmm: remove superfluous arguments from hmm_range_register
      mm/hmm: remove the page_shift member from struct hmm_range
      mm/hmm: remove the mask variable in hmm_vma_walk_hugetlb_entry
      mm/hmm: don't abuse pte_index() in hmm_vma_handle_pmd
      mm/hmm: only define hmm_vma_walk_pud if needed
      mm/hmm: cleanup the hmm_vma_handle_pmd stub
      mm/hmm: cleanup the hmm_vma_walk_hugetlb_entry stub
      mm/hmm: allow HMM_MIRROR on all architectures with MMU
      mm/hmm: make HMM_MIRROR an implicit option
      mm: turn migrate_vma upside down
      nouveau: reset dma_nr in nouveau_dmem_migrate_alloc_and_copy
      nouveau: factor out device memory address calculation
      nouveau: factor out dmem fence completion
      nouveau: remove a few function stubs
      nouveau: simplify nouveau_dmem_migrate_to_ram
      nouveau: simplify nouveau_dmem_migrate_vma
      mm: remove the unused MIGRATE_PFN_ERROR flag
      mm: remove the unused MIGRATE_PFN_DEVICE flag
      mm: remove CONFIG_MIGRATE_VMA_HELPER
      resource: add a not device managed request_free_mem_region variant
      memremap: remove the dev field in struct dev_pagemap
      memremap: don't use a separate devm action for devmap_managed_enable_=
get
      memremap: provide a not device managed memremap_pages
      mm/mmu_notifiers: remove the __mmu_notifier_invalidate_range_start/en=
d exports
      mm: split out a new pagewalk.h header from mm.h
      pagewalk: separate function pointers from iterator data
      pagewalk: use lockdep_assert_held for locking validation

Dan Williams (1):
      libnvdimm: Enable unit test infrastructure compile checks

Daniel Vetter (6):
      mm/mmu_notifiers: check if mmu notifier callbacks are allowed to fail
      mm/mmu_notifiers: add a lockdep map for invalidate_range_start/end
      mm/mmu_notifiers: prime lockdep
      mm/mmu_notifiers: annotate with might_sleep()
      kernel.h: Add non_block_start/end()
      mm, notifier: Catch sleeping/blocking for !blockable

Jason Gunthorpe (27):
      mm/hmm: comment on VM_FAULT_RETRY semantics in handle_mm_fault
      mm/mmu_notifiers: hoist do_mmu_notifier_register down_write to the ca=
ller
      mm/mmu_notifiers: do not speculatively allocate a mmu_notifier_mm
      mm/mmu_notifiers: add a get/put scheme for the registration
      misc/sgi-gru: use mmu_notifier_get/put for struct gru_mm_struct
      hmm: use mmu_notifier_get/put for 'struct hmm'
      drm/radeon: use mmu_notifier_get/put for struct radeon_mn
      drm/amdkfd: fix a use after free race with mmu_notifer unregister
      drm/amdkfd: use mmu_notifier_put
      Merge 'notifier_get_put' into hmm.git
      RDMA/odp: Use the common interval tree library instead of generic
      RDMA/odp: Iterate over the whole rbtree directly
      RDMA/odp: Make it clearer when a umem is an implicit ODP umem
      RMDA/odp: Consolidate umem_odp initialization
      RDMA/odp: Make the three ways to create a umem_odp clear
      RDMA/odp: Split creating a umem_odp from ib_umem_get
      RDMA/odp: Provide ib_umem_odp_release() to undo the allocs
      RDMA/odp: Check for overflow when computing the umem_odp end
      RDMA/odp: Use kvcalloc for the dma_list and page_list
      RDMA/mlx5: Use ib_umem_start instead of umem.address
      RDMA/mlx5: Use odp instead of mr->umem in pagefault_mr
      Merge branch 'odp_fixes' into hmm.git
      RDMA/odp: use mmu_notifier_get/put for 'struct ib_ucontext_per_mm'
      RDMA/odp: remove ib_ucontext from ib_umem
      mm/mmu_notifiers: remove unregister_no_release
      csky: add missing brackets in a macro for tlb.h
      drm/radeon: guard against calling an unpaired radeon_mn_unregister()

Moni Shoua (1):
      RDMA/core: Make invalidate_range a device operation

Ralph Campbell (6):
      mm/hmm: replace hmm_update with mmu_notifier_range
      mm/hmm: a few more C style and comment clean ups
      mm/hmm: remove hugetlbfs check in hmm_vma_walk_pmd
      mm/hmm: remove hmm_range vma
      mm/hmm: hmm_range_fault() NULL pointer bug
      mm/hmm: hmm_range_fault() infinite loop

Yang, Philip (1):
      mm/hmm: fix hmm_range_fault()'s handling of swapped out pages

 Documentation/vm/hmm.rst                 |  73 +----
 arch/csky/include/asm/tlb.h              |   8 +-
 arch/openrisc/kernel/dma.c               |  23 +-
 arch/powerpc/mm/book3s64/subpage_prot.c  |  12 +-
 arch/s390/mm/gmap.c                      |  35 +--
 drivers/gpu/drm/amd/amdgpu/Kconfig       |   4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c  |   2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c   |  15 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c  |  31 +-
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h    |   3 -
 drivers/gpu/drm/amd/amdkfd/kfd_process.c |  88 +++---
 drivers/gpu/drm/nouveau/Kconfig          |   5 +-
 drivers/gpu/drm/nouveau/nouveau_dmem.c   | 456 +++++++++------------------
 drivers/gpu/drm/nouveau/nouveau_dmem.h   |  11 -
 drivers/gpu/drm/nouveau/nouveau_drm.c    |   3 +
 drivers/gpu/drm/nouveau/nouveau_svm.c    |  23 +-
 drivers/gpu/drm/radeon/radeon.h          |   3 -
 drivers/gpu/drm/radeon/radeon_device.c   |   2 -
 drivers/gpu/drm/radeon/radeon_drv.c      |   2 +
 drivers/gpu/drm/radeon/radeon_mn.c       | 156 +++------
 drivers/infiniband/Kconfig               |   1 +
 drivers/infiniband/core/device.c         |   1 +
 drivers/infiniband/core/umem.c           |  54 +---
 drivers/infiniband/core/umem_odp.c       | 524 +++++++++++++++------------=
----
 drivers/infiniband/core/uverbs_cmd.c     |   5 -
 drivers/infiniband/core/uverbs_main.c    |   1 +
 drivers/infiniband/hw/mlx5/main.c        |   9 -
 drivers/infiniband/hw/mlx5/mem.c         |  13 -
 drivers/infiniband/hw/mlx5/mr.c          |  38 ++-
 drivers/infiniband/hw/mlx5/odp.c         |  88 +++---
 drivers/misc/sgi-gru/grufile.c           |   1 +
 drivers/misc/sgi-gru/grutables.h         |   2 -
 drivers/misc/sgi-gru/grutlbpurge.c       |  84 ++---
 drivers/nvdimm/Kconfig                   |  12 +
 drivers/nvdimm/Makefile                  |   4 +
 fs/proc/task_mmu.c                       |  80 ++---
 include/linux/hmm.h                      | 125 ++------
 include/linux/ioport.h                   |   2 +
 include/linux/kernel.h                   |  23 +-
 include/linux/memremap.h                 |   3 +-
 include/linux/migrate.h                  | 120 ++-----
 include/linux/mm.h                       |  46 ---
 include/linux/mm_types.h                 |   6 -
 include/linux/mmu_notifier.h             |  59 +++-
 include/linux/pagewalk.h                 |  66 ++++
 include/linux/sched.h                    |   4 +
 include/rdma/ib_umem.h                   |   2 +-
 include/rdma/ib_umem_odp.h               |  58 ++--
 include/rdma/ib_verbs.h                  |   7 +-
 kernel/fork.c                            |   1 -
 kernel/resource.c                        |  45 ++-
 kernel/sched/core.c                      |  19 +-
 mm/Kconfig                               |  20 +-
 mm/hmm.c                                 | 490 +++++++++------------------=
--
 mm/madvise.c                             |  42 +--
 mm/memcontrol.c                          |  25 +-
 mm/mempolicy.c                           |  17 +-
 mm/memremap.c                            | 105 ++++---
 mm/migrate.c                             | 276 ++++++++--------
 mm/mincore.c                             |  17 +-
 mm/mmu_notifier.c                        | 263 ++++++++++++----
 mm/mprotect.c                            |  26 +-
 mm/page_alloc.c                          |   2 +-
 mm/pagewalk.c                            | 126 ++++----
 tools/testing/nvdimm/test/iomap.c        |   1 -
 65 files changed, 1684 insertions(+), 2184 deletions(-)
 create mode 100644 include/linux/pagewalk.h
