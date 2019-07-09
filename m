From: Jason Gunthorpe <jgg@mellanox.com>
Subject: [GIT PULL] Please pull hmm changes
Date: Tue, 9 Jul 2019 19:24:21 +0000
Message-ID: <20190709192418.GA13677@ziepe.ca>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="yrj/dFKFPuw6o+aM"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: Dan Williams <dan.j.williams@intel.com>, Christoph Hellwig <hch@lst.de>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Kuehling, Felix" <Felix.Kuehling@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>, "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: amd-gfx.lists.freedesktop.org

--yrj/dFKFPuw6o+aM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

As was discussed some time ago here are the mostly -mm patches related
to hmm functions. In agreement with Andrew we split this out from
quilt into a git topic branch so it can be shared between the DRM and
RDMA git trees. However, this cycle did not see dependencies with work
in DRM or RDMA that required a topic merge. I expect that work will
start to get ready next cycle and we will see a need for a cross-tree
topic merge then.

I'm sending it early as it is now a dependency for several patches in
mm's quilt.

This has been an exciting topic branch for conflicts, you'll need the
below simple resolution in the merge commit to make it compile
(lockdep_assert_held_exclusive() was renamed to
lockdep_assert_held_write())

Otherwise, for reference to all parties, here is how the conflicts were
handled:

- Several small patches from -mm quilt were moved to this tree to simplify
  conflict management, only Ira's 'fix release_pages()' patch was not hmm
  related.

- DRM introduced a new users of the hmm_range_register() API. We worked
  with AMDGPU to ensure that their new user could use the revised API via
  the below trivial merge fixup with DRM:

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -783,7 +783,7 @@ int amdgpu_ttm_tt_get_user_pages(struct ttm_tt *ttm, struct page **pages)
                                0 : range->flags[HMM_PFN_WRITE];
        range->pfn_flags_mask = 0;
        range->pfns = pfns;
 -     hmm_range_register(range, mm, start,
 +     hmm_range_register(range, mirror, start,
                           start + ttm->num_pages * PAGE_SIZE, PAGE_SHIFT);

   retry:

- ARM64 has a patch series going through -mm with a trivial
  conflict ("Devmap cleanups + arm64 support"), Andrew has re-applied this
  in quilt onto linux-next and will send it

- The memreap sub-section changes in -mm has 5 hunk conflict with the
  memremap changes here. Andrew reapplied Dan's series ontop of
  Christoph's series in linux-next and will send it.

The tag for-linus-hmm-merged with my merge resolution to your tree is
also available to pull.

Thanks,
Jason

diff --cc mm/hmm.c
index d48b9283725a90,f702a3895d05d8..e1eedef129cf5c
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@@ -42,16 -54,11 +42,16 @@@ static const struct mmu_notifier_ops hm
   */
  static struct hmm *hmm_get_or_create(struct mm_struct *mm)
  {
 -	struct hmm *hmm = mm_get_hmm(mm);
 -	bool cleanup = false;
 +	struct hmm *hmm;

- 	lockdep_assert_held_exclusive(&mm->mmap_sem);
 -	if (hmm)
 -		return hmm;
++	lockdep_assert_held_write(&mm->mmap_sem);
 +
 +	/* Abuse the page_table_lock to also protect mm->hmm. */
 +	spin_lock(&mm->page_table_lock);
 +	hmm = mm->hmm;
 +	if (mm->hmm && kref_get_unless_zero(&mm->hmm->kref))
 +		goto out_unlock;
 +	spin_unlock(&mm->page_table_lock);

  	hmm = kmalloc(sizeof(*hmm), GFP_KERNEL);
  	if (!hmm)
@@@ -245,8 -277,8 +245,8 @@@ static const struct mmu_notifier_ops hm
   */
  int hmm_mirror_register(struct hmm_mirror *mirror, struct mm_struct *mm)
  {
- 	lockdep_assert_held_exclusive(&mm->mmap_sem);
++	lockdep_assert_held_write(&mm->mmap_sem);
 +
  	/* Sanity check */
  	if (!mm || !mirror || !mirror->ops)
  		return -EINVAL;

The following changes since commit 6fbc7275c7a9ba97877050335f290341a1fd8dbf:

  Linux 5.2-rc7 (2019-06-30 11:25:36 +0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus-hmm

for you to fetch changes up to cc5dfd59e375f4d0f2b64643723d16b38b2f2d78:

  Merge branch 'hmm-devmem-cleanup.4' into rdma.git hmm (2019-07-02 15:10:45 -0300)

----------------------------------------------------------------
HMM patches for 5.3

Improvements and bug fixes for the hmm interface in the kernel:

- Improve clarity, locking and APIs related to the 'hmm mirror' feature
  merged last cycle. In linux-next we now see AMDGPU and nouveau to be
  using this API.

- Remove old or transitional hmm APIs. These are hold overs from the past
  with no users, or APIs that existed only to manage cross tree conflicts.
  There are still a few more of these cleanups that didn't make the merge
  window cut off.

- Improve some core mm APIs:
  * export alloc_pages_vma() for driver use
  * refactor into devm_request_free_mem_region() to manage
    DEVICE_PRIVATE resource reservations
  * refactor duplicative driver code into the core dev_pagemap
    struct

- Remove hmm wrappers of improved core mm APIs, instead have drivers use
  the simplified API directly

- Remove DEVICE_PUBLIC

- Simplify the kconfig flow for the hmm users and core code

----------------------------------------------------------------
Christoph Hellwig (24):
      mm: remove the unused ARCH_HAS_HMM_DEVICE Kconfig option
      mm: remove the struct hmm_device infrastructure
      mm: remove MEMORY_DEVICE_PUBLIC support
      mm: don't clear ->mapping in hmm_devmem_free
      mm: export alloc_pages_vma
      mm: factor out a devm_request_free_mem_region helper
      memremap: validate the pagemap type passed to devm_memremap_pages
      memremap: move dev_pagemap callbacks into a separate structure
      memremap: pass a struct dev_pagemap to ->kill and ->cleanup
      memremap: lift the devmap_enable manipulation into devm_memremap_pages
      memremap: add a migrate_to_ram method to struct dev_pagemap_ops
      memremap: remove the data field in struct dev_pagemap
      memremap: replace the altmap_valid field with a PGMAP_ALTMAP_VALID flag
      memremap: provide an optional internal refcount in struct dev_pagemap
      device-dax: use the dev_pagemap internal refcount
      PCI/P2PDMA: use the dev_pagemap internal refcount
      nouveau: use alloc_page_vma directly
      nouveau: use devm_memremap_pages directly
      mm: remove hmm_vma_alloc_locked_page
      mm: remove hmm_devmem_add
      mm: simplify ZONE_DEVICE page private data
      mm: sort out the DEVICE_PRIVATE Kconfig mess
      mm: remove the HMM config option
      mm: don't select MIGRATE_VMA_HELPER from HMM_MIRROR

Ira Weiny (1):
      mm/swap: fix release_pages() when releasing devmap pages

Jason Gunthorpe (15):
      mm/hmm.c: suppress compilation warnings when CONFIG_HUGETLB_PAGE is not set
      mm/hmm: fix use after free with struct hmm in the mmu notifiers
      mm/hmm: Use hmm_mirror not mm as an argument for hmm_range_register
      mm/hmm: Hold a mmgrab from hmm to mm
      mm/hmm: Simplify hmm_get_or_create and make it reliable
      mm/hmm: Remove duplicate condition test before wait_event_timeout
      mm/hmm: Do not use list*_rcu() for hmm->ranges
      mm/hmm: Hold on to the mmget for the lifetime of the range
      mm/hmm: Use lockdep instead of comments
      mm/hmm: Remove racy protection against double-unregistration
      mm/hmm: Poison hmm_range during unregister
      mm/hmm: Remove confusing comment and logic from hmm_release
      mm/hmm: Fix error flows in hmm_invalidate_range_start
      Merge tag 'v5.2-rc7' into rdma.git hmm
      Merge branch 'hmm-devmem-cleanup.4' into rdma.git hmm

Kuehling, Felix (1):
      mm/hmm: Only set FAULT_FLAG_ALLOW_RETRY for non-blocking

Philip Yang (1):
      mm/hmm: support automatic NUMA balancing

Ralph Campbell (2):
      mm/hmm: update HMM documentation
      mm/hmm: clean up some coding style and comments

 Documentation/vm/hmm.rst               | 166 ++++------
 arch/powerpc/mm/mem.c                  |  10 +-
 arch/x86/mm/init_64.c                  |   8 +-
 drivers/dax/dax-private.h              |   4 -
 drivers/dax/device.c                   |  41 +--
 drivers/dax/pmem/core.c                |   2 +-
 drivers/gpu/drm/nouveau/Kconfig        |   6 +-
 drivers/gpu/drm/nouveau/nouveau_dmem.c | 103 +++---
 drivers/gpu/drm/nouveau/nouveau_svm.c  |   2 +-
 drivers/nvdimm/pfn_devs.c              |   3 +-
 drivers/nvdimm/pmem.c                  |  51 ++-
 drivers/pci/p2pdma.c                   |  52 +--
 fs/proc/task_mmu.c                     |   2 +-
 include/linux/hmm.h                    | 302 ++---------------
 include/linux/ioport.h                 |   3 +-
 include/linux/memremap.h               |  75 +++--
 include/linux/mm.h                     |  28 +-
 include/linux/mm_types.h               |   4 +-
 include/linux/swapops.h                |  15 -
 kernel/fork.c                          |   1 -
 kernel/memremap.c                      | 194 ++++++-----
 kernel/resource.c                      |  39 +++
 mm/Kconfig                             |  50 +--
 mm/Makefile                            |   2 +-
 mm/gup.c                               |   7 -
 mm/hmm.c                               | 587 ++++++++-------------------------
 mm/madvise.c                           |   2 +-
 mm/memcontrol.c                        |  13 +-
 mm/memory-failure.c                    |   6 +-
 mm/memory.c                            |  49 +--
 mm/memory_hotplug.c                    |   6 +-
 mm/mempolicy.c                         |   1 +
 mm/migrate.c                           |  28 +-
 mm/page_alloc.c                        |  13 +-
 mm/swap.c                              |  13 +-
 tools/testing/nvdimm/test/iomap.c      |  57 +++-
 36 files changed, 619 insertions(+), 1326 deletions(-)
(diffstat from tag for-linus-hmm-merged)

--yrj/dFKFPuw6o+aM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfB7FMLh+8QxL+6i3OG33FX4gmxoFAl0k6d0ACgkQOG33FX4g
mxq20Q/8DrfL9SYcFLlYTVetA9I3X6v8TP1MrW6YiswZlosJUP5m4PXf8Xo74YVG
HvqUrn2zYJn1LV9Fm/vabkJRv9edOXCsaMrahYumaRzn4GOMSa5bYe4cOcqnOB6U
d0aHEb67Y2aq3QKiwmT5m69jEc7T4217pM79t/zWpAm5/QPlCfqYNsMbOF9ocqDi
mw9IZBTNEe4blIPzupS4o3TZBT+8zCGSJ+mduzZZ34r+lAOSFaCrjihzAxalN1+3
tMuh4D8m8JAmB/EaozXeihvpRj2RN45ySsDT3njf9Qcgx7zbVpw1CPHgFC13gQau
nPHv1IpIMTD9WyzsB7m5s7Tx/rT0U3Ux7/6CALYh0WNE3aSBu6kscPqiSf1tj8C1
sN7iaGsQow2ZQnuszmPFhJPzo0aV8x1TD59AaoA9ezBy2OQf9RDbabv9ho/SD8Sy
G0mh//KIcWkdiPJhnZq9OOEH8k6b6IRuQM0XCjWq821TFGx+aRtVwaw5qwanFmY8
wQOlFyLxv13CZkN6YMfiuZ7DMVHnfcDJfyR6UMHUkPkOXRbCccZyPuA2pP0AB6nO
Gzsc8032R5NuceC87tGY4ViktvV0s4W6ofTrxxAutYtSv2/Imbe6PWvzaTI8UJC3
33Gqnn26RFr5wTbehg3TMFqmfy1zCpyY01WG56fBeASfvqKaR9w=
=njDZ
-----END PGP SIGNATURE-----

--yrj/dFKFPuw6o+aM--
