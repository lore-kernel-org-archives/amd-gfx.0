From: Jason Gunthorpe <jgg-VPRAkNaXOzVWk0Htik3J/w@public.gmane.org>
Subject: [GIT PULL] Please pull hmm changes
Date: Mon, 25 Nov 2019 20:42:52 +0000
Message-ID: <20191125204248.GA2485@ziepe.ca>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1264124676=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Content-Language: en-US
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Help: <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=subscribe>
Errors-To: amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Sender: "amd-gfx" <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
To: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Cc: Ralph Campbell <rcampbell-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, "Kuehling, Felix" <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>, "dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>, "linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org" <linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Daniel Vetter <daniel-/w4YWyX8dFk@public.gmane.org>, "Deucher,
 Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "linux-rdma-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-rdma-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

--===============1264124676==
Content-Language: en-US
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mYCpIKhGyMATD0i+"

--mYCpIKhGyMATD0i+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Here is this batch of hmm updates, I think we are nearing the end of this
project for now, although I suspect there will be some more patches related to
hmm_range_fault() in the next cycle.

You will probably be most interested in the patch "mm/mmu_notifier: add an
interval tree notifier". The approach here largely pre-exists in the various
drivers, but is honestly kind of complex/ugly. No better idea was found, I'm
hoping putting it all in one place will help improve this over the long
term. At least many bugs were squashed and lines of code eliminated while
consolidating.

Already i915 GPU has posted a series for the next window that also needs this
same approach.

There are two small conflicts I know of, the first is RDMA related with -rc,
the second is a one liner updating a deleted comment in GPU. Both can be
solved by using the hmm.git side of the conflict.

All the big driver changes have been acked and/or tested by their respective
maintainers.

Regards,
Jason

The following changes since commit d6d5df1db6e9d7f8f76d2911707f7d5877251b02:

  Linux 5.4-rc5 (2019-10-27 13:19:19 -0400)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus-hmm

for you to fetch changes up to 93f4e735b6d98ee4b7a1252d81e815a983e359f2:

  mm/hmm: remove hmm_range_dma_map and hmm_range_dma_unmap (2019-11-23 19:56:45 -0400)

----------------------------------------------------------------
hmm related patches for 5.5

This is another round of bug fixing and cleanup. This time the focus is on
the driver pattern to use mmu notifiers to monitor a VA range. This code
is lifted out of many drivers and hmm_mirror directly into the
mmu_notifier core and written using the best ideas from all the driver
implementations.

This removes many bugs from the drivers and has a very pleasing
diffstat. More drivers can still be converted, but that is for another
cycle.

- A shared branch with RDMA reworking the RDMA ODP implementation

- New mmu_interval_notifier API. This is focused on the use case of
  monitoring a VA and simplifies the process for drivers

- A common seq-count locking scheme built into the mmu_interval_notifier
  API usable by drivers that call get_user_pages() or hmm_range_fault()
  with the VA range

- Conversion of mlx5 ODP, hfi1, radeon, nouveau, AMD GPU, and Xen GntDev
  drivers to the new API. This deletes a lot of wonky driver code.

- Two improvements for hmm_range_fault(), from testing done by Ralph

----------------------------------------------------------------
Christoph Hellwig (1):
      mm/hmm: remove hmm_range_dma_map and hmm_range_dma_unmap

Jason Gunthorpe (30):
      RDMA/mlx5: Use SRCU properly in ODP prefetch
      RDMA/mlx5: Split sig_err MR data into its own xarray
      RDMA/mlx5: Use a dedicated mkey xarray for ODP
      RDMA/mlx5: Delete struct mlx5_priv->mkey_table
      RDMA/mlx5: Rework implicit_mr_get_data
      RDMA/mlx5: Lift implicit_mr_alloc() into the two routines that call it
      RDMA/mlx5: Set the HW IOVA of the child MRs to their place in the tree
      RDMA/mlx5: Split implicit handling from pagefault_mr
      RDMA/mlx5: Use an xarray for the children of an implicit ODP
      RDMA/mlx5: Reduce locking in implicit_mr_get_data()
      RDMA/mlx5: Avoid double lookups on the pagefault path
      RDMA/mlx5: Rework implicit ODP destroy
      RDMA/mlx5: Do not store implicit children in the odp_mkeys xarray
      RDMA/mlx5: Do not race with mlx5_ib_invalidate_range during create and destroy
      RDMA/odp: Remove broken debugging call to invalidate_range
      Merge branch 'odp_rework' into hmm.git
      mm/mmu_notifier: define the header pre-processor parts even if disabled
      mm/mmu_notifier: add an interval tree notifier
      mm/hmm: allow hmm_range to be used with a mmu_interval_notifier or hmm_mirror
      mm/hmm: define the pre-processor related parts of hmm.h even if disabled
      RDMA/odp: Use mmu_interval_notifier_insert()
      RDMA/hfi1: Use mmu_interval_notifier_insert for user_exp_rcv
      drm/radeon: use mmu_interval_notifier_insert
      nouveau: use mmu_notifier directly for invalidate_range_start
      nouveau: use mmu_interval_notifier instead of hmm_mirror
      drm/amdgpu: Call find_vma under mmap_sem
      drm/amdgpu: Use mmu_interval_insert instead of hmm_mirror
      drm/amdgpu: Use mmu_interval_notifier instead of hmm_mirror
      mm/hmm: remove hmm_mirror and related
      xen/gntdev: use mmu_interval_notifier_insert

Ralph Campbell (2):
      mm/hmm: allow snapshot of the special zero page
      mm/hmm: make full use of walk_page_range()

 Documentation/vm/hmm.rst                         |  105 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu.h              |    2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c |    9 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c           |   14 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c       |    1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c           |  443 ++--------
 drivers/gpu/drm/amd/amdgpu/amdgpu_mn.h           |   53 --
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h       |   13 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c          |  145 ++--
 drivers/gpu/drm/nouveau/nouveau_svm.c            |  230 +++--
 drivers/gpu/drm/radeon/radeon.h                  |    9 +-
 drivers/gpu/drm/radeon/radeon_mn.c               |  218 +----
 drivers/infiniband/core/device.c                 |    1 -
 drivers/infiniband/core/umem_odp.c               |  341 ++------
 drivers/infiniband/hw/hfi1/file_ops.c            |    2 +-
 drivers/infiniband/hw/hfi1/hfi.h                 |    2 +-
 drivers/infiniband/hw/hfi1/user_exp_rcv.c        |  146 ++--
 drivers/infiniband/hw/hfi1/user_exp_rcv.h        |    3 +-
 drivers/infiniband/hw/mlx5/cq.c                  |   33 +-
 drivers/infiniband/hw/mlx5/devx.c                |    8 +-
 drivers/infiniband/hw/mlx5/main.c                |   17 +-
 drivers/infiniband/hw/mlx5/mlx5_ib.h             |   29 +-
 drivers/infiniband/hw/mlx5/mr.c                  |  142 ++-
 drivers/infiniband/hw/mlx5/odp.c                 | 1004 +++++++++++-----------
 drivers/net/ethernet/mellanox/mlx5/core/main.c   |    4 -
 drivers/net/ethernet/mellanox/mlx5/core/mr.c     |   28 +-
 drivers/xen/gntdev-common.h                      |    8 +-
 drivers/xen/gntdev.c                             |  179 ++--
 include/linux/hmm.h                              |  190 +---
 include/linux/mlx5/driver.h                      |    4 -
 include/linux/mmu_notifier.h                     |  147 +++-
 include/rdma/ib_umem_odp.h                       |   86 +-
 include/rdma/ib_verbs.h                          |    2 -
 kernel/fork.c                                    |    1 -
 mm/Kconfig                                       |    2 +-
 mm/hmm.c                                         |  523 ++---------
 mm/mmu_notifier.c                                |  557 +++++++++++-
 37 files changed, 1912 insertions(+), 2789 deletions(-)

--mYCpIKhGyMATD0i+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfB7FMLh+8QxL+6i3OG33FX4gmxoFAl3cPMYACgkQOG33FX4g
mxqg1Q//QiNnGK2QzlMsyvot0OS7QJ9YGLB9MrJ5pLt6iM7TCVwX5XdxSNNSnqYs
PPrax5JI6HYGvoBrABaGAEzax9o6FXk9r+5OnavY9xUoNG1C9t0lk+9mFfC19fOx
+yNBpP9u3wWSbbQyfoa7fPY/2eR+0d04fcaksnHKdLYtmU90sNAGJXaSRFOs+EW3
lpTHZTzGXiiCYgY15wHKKVQ5P0Bc7sVk8cyFkheNgY/TKa0fXhjNmYEIKjr6Cl/g
KHW/uGeLukWe8qmARwE9CbBEeDY4WS25/qadcstGJvfRJxDlQiRtSnDeATFYUK4L
ZfZ7OvBrau/uKW6ZQyeCUhJJAd4pOnHW+SbXN3ZI3cB427mFL0XMFenGG/ajANoR
fkhq+Ppqx+879B+wZmk1Exr7/7V0SDzQVgXYZQ267RE833V4R3O9VmagZhFz6L5R
dGirANtcrhyhI3a/BZlMwMFLdEND45lxPNIHmHzEr1Qy0wVOoIsilxesb1jxSdyR
8zDmqXP1I38dii0sB5t7HG+go4EuPcYU4CBpx69whpndhxELkd8BKRD6ScQDiWr4
eKx7/rW/6wvfX6sgYaqV6Id/e8Y19RqfL7DYTdfhXEbxXg6YG9MDglKiWR2Bytyr
h9PJ/K8asp+LDdZsSikIMJer+ZBtCbjH7wo1eMonmAUU5sRk09g=
=XrsZ
-----END PGP SIGNATURE-----

--mYCpIKhGyMATD0i+--

--===============1264124676==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============1264124676==--
