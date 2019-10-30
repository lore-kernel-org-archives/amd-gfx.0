From: "Yin, Tianci (Rico)" <Tianci.Yin-5C7GfCeVMHo@public.gmane.org>
Subject: Re: amd-gfx Digest, Vol 41, Issue 390
Date: Wed, 30 Oct 2019 07:47:01 +0000
Message-ID: <DM5PR12MB2535C7FD718B072B97C0589B95600@DM5PR12MB2535.namprd12.prod.outlook.com>
References: <mailman.3171.1572386492.6695.amd-gfx@lists.freedesktop.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0695744425=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <mailman.3171.1572386492.6695.amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
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
To: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

--===============0695744425==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM5PR12MB2535C7FD718B072B97C0589B95600DM5PR12MB2535namp_"

--_000_DM5PR12MB2535C7FD718B072B97C0589B95600DM5PR12MB2535namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[PATCH] drm/amdgpu/gmc10: properly set BANK_SELECT and FRAGMENT_SIZE

Reviewed-by: Tianci Yin <tianci.yin-5C7GfCeVMHo@public.gmane.org>

________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of amd-gfx-=
request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org <amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Sent: Wednesday, October 30, 2019 6:01
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Subject: amd-gfx Digest, Vol 41, Issue 390

Send amd-gfx mailing list submissions to
        amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

To subscribe or unsubscribe via the World Wide Web, visit
        https://lists.freedesktop.org/mailman/listinfo/amd-gfx
or, via email, send a message with subject or body 'help' to
        amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

You can reach the person managing the list at
        amd-gfx-owner-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

When replying, please edit your Subject line so it is more specific
than "Re: Contents of amd-gfx digest..."


Today's Topics:

   1. Re: [PATCH v2 14/15] drm/amdgpu: Use mmu_range_notifier
      instead of hmm_mirror (Jason Gunthorpe)
   2. [PATCH] drm/amdgpu: remove PT BOs when unmapping
      (Huang, JinHuiEric)
   3. [PATCH] drm/amdgpu/renoir: move gfxoff handling into gfx9
      module (Alex Deucher)
   4. [PATCH] drm/amdgpu/gmc10: properly set BANK_SELECT and
      FRAGMENT_SIZE (Alex Deucher)
   5. 21:9 monitor resolution incorrect since 4.14 kernel (Neil Mayhew)


----------------------------------------------------------------------

Message: 1
Date: Tue, 29 Oct 2019 19:25:48 +0000
From: Jason Gunthorpe <jgg-VPRAkNaXOzVWk0Htik3J/w@public.gmane.org>
To: "Yang, Philip" <Philip.Yang-5C7GfCeVMHo@public.gmane.org>
Cc: "linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org" <linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org>, Jerome Glisse
        <jglisse-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Ralph Campbell <rcampbell-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, John
        Hubbard <jhubbard-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "Kuehling, Felix"
        <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>, Juergen Gross <jgross-IBi9RG/b67k@public.gmane.org>, "Zhou,
        David(ChunMing)" <David1.Zhou-5C7GfCeVMHo@public.gmane.org>, Mike Marciniszyn
        <mike.marciniszyn-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Stefano Stabellini
        <sstabellini-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Oleksandr Andrushchenko
        <oleksandr_andrushchenko-uRwfk40T5oI@public.gmane.org>, "linux-rdma-u79uwXL29TY76Z2rM5mHXA@public.gmane.org"
        <linux-rdma-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "nouveau-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org"
        <nouveau-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Dennis Dalessandro
        <dennis.dalessandro-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org"
        <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Christoph Hellwig
        <hch-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org"
        <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Deucher, Alexander"
        <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "xen-devel-GuqFBffKawtpuQazS67q72D2FQJk+8+b@public.gmane.org"
        <xen-devel-GuqFBffKawtpuQazS67q72D2FQJk+8+b@public.gmane.org>, Boris Ostrovsky
        <boris.ostrovsky-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>, Petr Cvek <petrcvekcz-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>, Ben Skeggs
        <bskeggs-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v2 14/15] drm/amdgpu: Use mmu_range_notifier
        instead of hmm_mirror
Message-ID: <20191029192544.GU22766-VPRAkNaXOzVWk0Htik3J/w@public.gmane.org>
Content-Type: text/plain; charset=3D"us-ascii"

On Tue, Oct 29, 2019 at 07:22:37PM +0000, Yang, Philip wrote:
> Hi Jason,
>
> I did quick test after merging amd-staging-drm-next with the
> mmu_notifier branch, which includes this set changes. The test result
> has different failures, app stuck intermittently, GUI no display etc. I
> am understanding the changes and will try to figure out the cause.

Thanks! I'm not surprised by this given how difficult this patch was
to make. Let me know if I can assist in any way

Please ensure to run with lockdep enabled.. Your symptops sounds sort
of like deadlocking?

Regards,
Jason


------------------------------

Message: 2
Date: Tue, 29 Oct 2019 20:06:41 +0000
From: "Huang, JinHuiEric" <JinHuiEric.Huang-5C7GfCeVMHo@public.gmane.org>
To: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "Huang, JinHuiEric" <JinHuiEric.Huang-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH] drm/amdgpu: remove PT BOs when unmapping
Message-ID:
        <1572379585-1401-1-git-send-email-JinhuiEric.Huang-5C7GfCeVMHo@public.gmane.org>
Content-Type: text/plain; charset=3D"iso-8859-1"

The issue is PT BOs are not freed when unmapping VA,
which causes vram usage accumulated is huge in some
memory stress test, such as kfd big buffer stress test.
Function amdgpu_vm_bo_update_mapping() is called by both
amdgpu_vm_bo_update() and amdgpu_vm_clear_freed(). The
solution is replacing amdgpu_vm_bo_update_mapping() in
amdgpu_vm_clear_freed() with removing PT BOs function
to save vram usage.

Change-Id: Ic24e35bff8ca85265b418a642373f189d972a924
Signed-off-by: Eric Huang <JinhuiEric.Huang-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 56 +++++++++++++++++++++++++++++-=
----
 1 file changed, 48 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/a=
mdgpu/amdgpu_vm.c
index 0f4c3b2..8a480c7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -1930,6 +1930,51 @@ static void amdgpu_vm_prt_fini(struct amdgpu_device =
*adev, struct amdgpu_vm *vm)
 }

 /**
+ * amdgpu_vm_remove_ptes - free PT BOs
+ *
+ * @adev: amdgpu device structure
+ * @vm: amdgpu vm structure
+ * @start: start of mapped range
+ * @end: end of mapped entry
+ *
+ * Free the page table level.
+ */
+static int amdgpu_vm_remove_ptes(struct amdgpu_device *adev,
+               struct amdgpu_vm *vm, uint64_t start, uint64_t end)
+{
+       struct amdgpu_vm_pt_cursor cursor;
+       unsigned shift, num_entries;
+
+       amdgpu_vm_pt_start(adev, vm, start, &cursor);
+       while (cursor.level < AMDGPU_VM_PTB) {
+               if (!amdgpu_vm_pt_descendant(adev, &cursor))
+                       return -ENOENT;
+       }
+
+       while (cursor.pfn < end) {
+               amdgpu_vm_free_table(cursor.entry);
+               num_entries =3D amdgpu_vm_num_entries(adev, cursor.level - =
1);
+
+               if (cursor.entry !=3D &cursor.parent->entries[num_entries -=
 1]) {
+                       /* Next ptb entry */
+                       shift =3D amdgpu_vm_level_shift(adev, cursor.level =
- 1);
+                       cursor.pfn +=3D 1ULL << shift;
+                       cursor.pfn &=3D ~((1ULL << shift) - 1);
+                       cursor.entry++;
+               } else {
+                       /* Next ptb entry in next pd0 entry */
+                       amdgpu_vm_pt_ancestor(&cursor);
+                       shift =3D amdgpu_vm_level_shift(adev, cursor.level =
- 1);
+                       cursor.pfn +=3D 1ULL << shift;
+                       cursor.pfn &=3D ~((1ULL << shift) - 1);
+                       amdgpu_vm_pt_descendant(adev, &cursor);
+               }
+       }
+
+       return 0;
+}
+
+/**
  * amdgpu_vm_clear_freed - clear freed BOs in the PT
  *
  * @adev: amdgpu_device pointer
@@ -1949,7 +1994,6 @@ int amdgpu_vm_clear_freed(struct amdgpu_device *adev,
                           struct dma_fence **fence)
 {
         struct amdgpu_bo_va_mapping *mapping;
-       uint64_t init_pte_value =3D 0;
         struct dma_fence *f =3D NULL;
         int r;

@@ -1958,13 +2002,10 @@ int amdgpu_vm_clear_freed(struct amdgpu_device *ade=
v,
                         struct amdgpu_bo_va_mapping, list);
                 list_del(&mapping->list);

-               if (vm->pte_support_ats &&
-                   mapping->start < AMDGPU_GMC_HOLE_START)
-                       init_pte_value =3D AMDGPU_PTE_DEFAULT_ATC;
+               r =3D amdgpu_vm_remove_ptes(adev, vm,
+                               (mapping->start + 0x1ff) & (~0x1ffll),
+                               (mapping->last + 1) & (~0x1ffll));

-               r =3D amdgpu_vm_bo_update_mapping(adev, vm, false, NULL,
-                                               mapping->start, mapping->la=
st,
-                                               init_pte_value, 0, NULL, &f=
);
                 amdgpu_vm_free_mapping(adev, vm, mapping, f);
                 if (r) {
                         dma_fence_put(f);
@@ -1980,7 +2021,6 @@ int amdgpu_vm_clear_freed(struct amdgpu_device *adev,
         }

         return 0;
-
 }

 /**
--
2.7.4



------------------------------

Message: 3
Date: Tue, 29 Oct 2019 16:10:31 -0400
From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH] drm/amdgpu/renoir: move gfxoff handling into gfx9
        module
Message-ID: <20191029201031.1514210-1-alexander.deucher-5C7GfCeVMHo@public.gmane.org>

To properly handle the option parsing ordering.

Signed-off-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 6 ++++++
 drivers/gpu/drm/amd/amdgpu/soc15.c    | 5 -----
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/am=
dgpu/gfx_v9_0.c
index 9fe95e7693d5..b2b3eb75c48c 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -1051,6 +1051,12 @@ static void gfx_v9_0_check_if_need_gfxoff(struct amd=
gpu_device *adev)
                             !adev->gfx.rlc.is_rlc_v2_1))
                         adev->pm.pp_feature &=3D ~PP_GFXOFF_MASK;

+               if (adev->pm.pp_feature & PP_GFXOFF_MASK)
+                       adev->pg_flags |=3D AMD_PG_SUPPORT_GFX_PG |
+                               AMD_PG_SUPPORT_CP |
+                               AMD_PG_SUPPORT_RLC_SMU_HS;
+               break;
+       case CHIP_RENOIR:
                 if (adev->pm.pp_feature & PP_GFXOFF_MASK)
                         adev->pg_flags |=3D AMD_PG_SUPPORT_GFX_PG |
                                 AMD_PG_SUPPORT_CP |
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgp=
u/soc15.c
index 16c5bb75889f..25e69ea74a41 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -1263,11 +1263,6 @@ static int soc15_common_early_init(void *handle)
                                  AMD_PG_SUPPORT_VCN |
                                  AMD_PG_SUPPORT_VCN_DPG;
                 adev->external_rev_id =3D adev->rev_id + 0x91;
-
-               if (adev->pm.pp_feature & PP_GFXOFF_MASK)
-                       adev->pg_flags |=3D AMD_PG_SUPPORT_GFX_PG |
-                               AMD_PG_SUPPORT_CP |
-                               AMD_PG_SUPPORT_RLC_SMU_HS;
                 break;
         default:
                 /* FIXME: not supported yet */
--
2.23.0



------------------------------

Message: 4
Date: Tue, 29 Oct 2019 17:15:44 -0400
From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH] drm/amdgpu/gmc10: properly set BANK_SELECT and
        FRAGMENT_SIZE
Message-ID: <20191029211544.1534432-1-alexander.deucher-5C7GfCeVMHo@public.gmane.org>

These were not aligned for optimal performance for GPUVM.

Signed-off-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c | 9 +++++++++
 drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c  | 9 +++++++++
 2 files changed, 18 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c b/drivers/gpu/drm/amd=
/amdgpu/gfxhub_v2_0.c
index b601c6740ef5..b4f32d853ca1 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
@@ -155,6 +155,15 @@ static void gfxhub_v2_0_init_cache_regs(struct amdgpu_=
device *adev)
         WREG32_SOC15(GC, 0, mmGCVM_L2_CNTL2, tmp);

         tmp =3D mmGCVM_L2_CNTL3_DEFAULT;
+       if (adev->gmc.translate_further) {
+               tmp =3D REG_SET_FIELD(tmp, GCVM_L2_CNTL3, BANK_SELECT, 12);
+               tmp =3D REG_SET_FIELD(tmp, GCVM_L2_CNTL3,
+                                   L2_CACHE_BIGK_FRAGMENT_SIZE, 9);
+       } else {
+               tmp =3D REG_SET_FIELD(tmp, GCVM_L2_CNTL3, BANK_SELECT, 9);
+               tmp =3D REG_SET_FIELD(tmp, GCVM_L2_CNTL3,
+                                   L2_CACHE_BIGK_FRAGMENT_SIZE, 6);
+       }
         WREG32_SOC15(GC, 0, mmGCVM_L2_CNTL3, tmp);

         tmp =3D mmGCVM_L2_CNTL4_DEFAULT;
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c b/drivers/gpu/drm/amd/=
amdgpu/mmhub_v2_0.c
index 2eea702de8ee..945533634711 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
@@ -142,6 +142,15 @@ static void mmhub_v2_0_init_cache_regs(struct amdgpu_d=
evice *adev)
         WREG32_SOC15(MMHUB, 0, mmMMVM_L2_CNTL2, tmp);

         tmp =3D mmMMVM_L2_CNTL3_DEFAULT;
+       if (adev->gmc.translate_further) {
+               tmp =3D REG_SET_FIELD(tmp, MMVM_L2_CNTL3, BANK_SELECT, 12);
+               tmp =3D REG_SET_FIELD(tmp, MMVM_L2_CNTL3,
+                                   L2_CACHE_BIGK_FRAGMENT_SIZE, 9);
+       } else {
+               tmp =3D REG_SET_FIELD(tmp, MMVM_L2_CNTL3, BANK_SELECT, 9);
+               tmp =3D REG_SET_FIELD(tmp, MMVM_L2_CNTL3,
+                                   L2_CACHE_BIGK_FRAGMENT_SIZE, 6);
+       }
         WREG32_SOC15(MMHUB, 0, mmMMVM_L2_CNTL3, tmp);

         tmp =3D mmMMVM_L2_CNTL4_DEFAULT;
--
2.23.0



------------------------------

Message: 5
Date: Tue, 29 Oct 2019 16:01:29 -0600
From: Neil Mayhew <neil_mayhew-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Subject: 21:9 monitor resolution incorrect since 4.14 kernel
Message-ID:
        <32e595a2-fdc1-7b13-2e33-c2b8752c60f2-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Type: text/plain; charset=3D"utf-8"

I have a 21:9 ultrawide monitor connected to an RX 570 with the amdgpu
driver. I'm still using the 4.14 kernel since with later kernels I can't
get the driver to allow use of the full resolution of 2560x1080 and I'm
limited to regular HD, ie 1920x1080. The latest kernel I've tried is
5.4-rc2. My distro is NixOS unstable-small. I have two other monitors
(16:9 and 16:10) connected to the same graphics card.

Is there anything I can do to work around this or try to fix it? I had a
look at the driver sources but couldn't find where the mode is set. I'm
happy to try things if someone can point me in the right direction, even
if it's just to gather better info for a bug report. Using such an old
kernel is becoming really inconvenient.

Some additional info about the situation on 4.14 that may or may not help:

1. The resolution is limited with Wayland but not with X11

2. When the system boots up the resolution is square and the image is
squished horizontally with many columns dropped, both during the boot
process and at the gdm login screen. It's not until after I log with X11
that the resolution is set correctly.

3. The output of xrandr --props is below.

TIA for any help.

--Neil

Screen 0: minimum 320 x 200, current 6160 x 1080, maximum 16384 x 16384
DP-1 connected primary 2560x1080+1920+0 (normal left inverted right x
axis y axis) 798mm x 334mm
    _MUTTER_PRESENTATION_OUTPUT: 0
    EDID:
        00ffffffffffff001e6df9765de80500
        091c010380502278eaca95a6554ea126
        0f5054256b807140818081c0a9c0b300
        d1c08100d1cfcd4600a0a0381f403020
        3a001e4e3100001a003a801871382d40
        582c4500132a2100001e000000fd0038
        4b1e5a18000a202020202020000000fc
        004c4720554c545241574944450a01b5
        02031af12309070747100403011f1312
        8301000065030c0010008c0ad08a20e0
        2d10103e96001e4e31000018295900a0
        a038274030203a001e4e3100001a0000
        00000000000000000000000000000000
        00000000000000000000000000000000
        0000000000ff003830394e544b464244
        3136350a0000000000000000000000a4
    dither: off
        supported: off, on
    audio: auto
        supported: off, on, auto
    scaling mode: None
        supported: None, Full, Center, Full aspect
    underscan vborder: 0
        range: (0, 128)
    underscan hborder: 0
        range: (0, 128)
    underscan: off
        supported: off, on, auto
    coherent: 1
        range: (0, 1)
    link-status: Good
        supported: Good, Bad
    CONNECTOR_ID: 48
        supported: 48
    non-desktop: 0
        supported: 0, 1
   2560x1080     59.98 +  74.99*
   1920x1080     74.99    59.96    50.00    59.99    59.94    59.93
   1680x1050     59.95    59.88

[etc.]
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <https://lists.freedesktop.org/archives/amd-gfx/attachments/20191029/4=
71e1fcb/attachment.html>

------------------------------

Subject: Digest Footer

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

------------------------------

End of amd-gfx Digest, Vol 41, Issue 390
****************************************

--_000_DM5PR12MB2535C7FD718B072B97C0589B95600DM5PR12MB2535namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<!--[if !mso]><style>v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style><![endif]--><style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:"Times New Roman",serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:purple;
	text-decoration:underline;}
p.msonormal0, li.msonormal0, div.msonormal0
	{mso-style-name:msonormal;
	margin:0cm;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:"Times New Roman",serif;}
span.EmailStyle19
	{mso-style-type:personal-compose;
	font-family:"Calibri",sans-serif;
	color:black;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 72.0pt 72.0pt 72.0pt;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"ZH-CN" link=3D"blue" vlink=3D"purple">
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt;font-=
family:&quot;Calibri&quot;,sans-serif;color:black">[PATCH] drm/amdgpu/gmc10=
: properly set BANK_SELECT and FRAGMENT_SIZE</span><span lang=3D"EN-US" sty=
le=3D"font-family:&quot;Calibri&quot;,sans-serif;color:black"><o:p></o:p></=
span></p>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Cali=
bri&quot;,sans-serif;color:black"><o:p>&nbsp;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Cali=
bri&quot;,sans-serif;color:black">Reviewed-by: Tianci Yin &lt;tianci.yin@am=
d.com&gt;<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Cali=
bri&quot;,sans-serif;color:black"><o:p>&nbsp;</o:p></span></p>
</div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center"><span=
 lang=3D"EN-US">
<hr size=3D"2" width=3D"98%" align=3D"center">
</span></div>
<div id=3D"divRplyFwdMsg">
<p class=3D"MsoNormal"><b><span lang=3D"EN-US" style=3D"font-size:11.0pt;fo=
nt-family:&quot;Calibri&quot;,sans-serif;color:black">From:</span></b><span=
 lang=3D"EN-US" style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,s=
ans-serif;color:black"> amd-gfx &lt;amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&g=
t;
 on behalf of amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org &lt;amd-gfx-request@lis=
ts.freedesktop.org&gt;<br>
<b>Sent:</b> Wednesday, October 30, 2019 6:01<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org &lt;amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&=
gt;<br>
<b>Subject:</b> amd-gfx Digest, Vol 41, Issue 390</span><span lang=3D"EN-US=
"> <o:p>
</o:p></span></p>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;<o:p></o:p></span></p>
</div>
</div>
<div>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt">Send=
 amd-gfx mailing list submissions to<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br=
>
<br>
To subscribe or unsubscribe via the World Wide Web, visit<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <a href=3D"https://lists.freedes=
ktop.org/mailman/listinfo/amd-gfx">https://lists.freedesktop.org/mailman/li=
stinfo/amd-gfx</a><br>
or, via email, send a message with subject or body 'help' to<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amd-gfx-request-PD4FTy7X32lNgt0PjOBp9w@public.gmane.org=
p.org<br>
<br>
You can reach the person managing the list at<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amd-gfx-owner-PD4FTy7X32lNgt0PjOBp9/rsn8yoX9R0@public.gmane.org=
org<br>
<br>
When replying, please edit your Subject line so it is more specific<br>
than &quot;Re: Contents of amd-gfx digest...&quot;<br>
<br>
<br>
Today's Topics:<br>
<br>
&nbsp;&nbsp; 1. Re: [PATCH v2 14/15] drm/amdgpu: Use mmu_range_notifier<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; instead of hmm_mirror (Jason Gunthorpe)<br>
&nbsp;&nbsp; 2. [PATCH] drm/amdgpu: remove PT BOs when unmapping<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (Huang, JinHuiEric)<br>
&nbsp;&nbsp; 3. [PATCH] drm/amdgpu/renoir: move gfxoff handling into gfx9<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; module (Alex Deucher)<br>
&nbsp;&nbsp; 4. [PATCH] drm/amdgpu/gmc10: properly set BANK_SELECT and<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; FRAGMENT_SIZE (Alex Deucher)<br>
&nbsp;&nbsp; 5. 21:9 monitor resolution incorrect since 4.14 kernel (Neil M=
ayhew)<br>
<br>
<br>
----------------------------------------------------------------------<br>
<br>
Message: 1<br>
Date: Tue, 29 Oct 2019 19:25:48 &#43;0000<br>
From: Jason Gunthorpe &lt;jgg-VPRAkNaXOzVWk0Htik3J/w@public.gmane.org&gt;<br>
To: &quot;Yang, Philip&quot; &lt;Philip.Yang-5C7GfCeVMHo@public.gmane.org&gt;<br>
Cc: &quot;linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org&quot; &lt;linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org&gt;, Jerome Gliss=
e<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt;jglisse-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org&gt;, Ralp=
h Campbell &lt;rcampbell-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org&gt;, John<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Hubbard &lt;jhubbard-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org&=
gt;, &quot;Kuehling, Felix&quot;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt;Felix.Kuehling-5C7GfCeVMHo@public.gmane.org&gt;, =
Juergen Gross &lt;jgross-IBi9RG/b67k@public.gmane.org&gt;, &quot;Zhou,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; David(ChunMing)&quot; &lt;David1=
.Zhou-5C7GfCeVMHo@public.gmane.org&gt;, Mike Marciniszyn<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt;mike.marciniszyn-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org&g=
t;, Stefano Stabellini<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt;sstabellini-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org&gt;, =
Oleksandr Andrushchenko<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt;oleksandr_andrushchenko@epam=
.com&gt;, &quot;linux-rdma-u79uwXL29TY76Z2rM5mHXA@public.gmane.org&quot;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt;linux-rdma-u79uwXL29TY76Z2rM5mHXA@public.gmane.org&g=
t;, &quot;nouveau-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&quot;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt;nouveau-PD4FTy7X32lNgt0PjOBp9/EVdHwE84te@public.gmane.org=
g&gt;, Dennis Dalessandro<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt;dennis.dalessandro-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org=
&gt;, &quot;amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&quot;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt;amd-gfx-PD4FTy7X32lNgt0PjOBp9/EVdHwE84te@public.gmane.org=
g&gt;, Christoph Hellwig<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt;hch-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org&gt;, &quot=
;dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&quot;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt;dri-devel-PD4FTy7X32lNgt0PjOBp9/rsn8yoX9R0@public.gmane.org=
org&gt;, &quot;Deucher, Alexander&quot;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt;Alexander.Deucher-5C7GfCeVMHo@public.gmane.org&gt=
;, &quot;xen-devel-GuqFBffKawtpuQazS67q72D2FQJk+8+b@public.gmane.org&quot;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt;xen-devel-GuqFBffKawtpuQazS67q7+46SIhDJjyZ@public.gmane.org=
rg&gt;, Boris Ostrovsky<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt;boris.ostrovsky-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org&g=
t;, Petr Cvek &lt;petrcvekcz-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;Koenig, Christian&quot; &l=
t;Christian.Koenig-5C7GfCeVMHo@public.gmane.org&gt;, Ben Skeggs<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt;bskeggs-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org&gt;<br>
Subject: Re: [PATCH v2 14/15] drm/amdgpu: Use mmu_range_notifier<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; instead of hmm_mirror<br>
Message-ID: &lt;20191029192544.GU22766-VPRAkNaXOzVWk0Htik3J/w@public.gmane.org&gt;<br>
Content-Type: text/plain; charset=3D&quot;us-ascii&quot;<br>
<br>
On Tue, Oct 29, 2019 at 07:22:37PM &#43;0000, Yang, Philip wrote:<br>
&gt; Hi Jason,<br>
&gt; <br>
&gt; I did quick test after merging amd-staging-drm-next with the <br>
&gt; mmu_notifier branch, which includes this set changes. The test result =
<br>
&gt; has different failures, app stuck intermittently, GUI no display etc. =
I <br>
&gt; am understanding the changes and will try to figure out the cause.<br>
<br>
Thanks! I'm not surprised by this given how difficult this patch was<br>
to make. Let me know if I can assist in any way<br>
<br>
Please ensure to run with lockdep enabled.. Your symptops sounds sort<br>
of like deadlocking?<br>
<br>
Regards,<br>
Jason<br>
<br>
<br>
------------------------------<br>
<br>
Message: 2<br>
Date: Tue, 29 Oct 2019 20:06:41 &#43;0000<br>
From: &quot;Huang, JinHuiEric&quot; &lt;JinHuiEric.Huang-5C7GfCeVMHo@public.gmane.org&gt;<br>
To: &quot;amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&quot; &lt;amd-gfx-PD4FTy7X32lNgt0PjOBp93gSJqDPrsil@public.gmane.org=
.org&gt;<br>
Cc: &quot;Huang, JinHuiEric&quot; &lt;JinHuiEric.Huang-5C7GfCeVMHo@public.gmane.org&gt;<br>
Subject: [PATCH] drm/amdgpu: remove PT BOs when unmapping<br>
Message-ID:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt;1572379585-1401-1-git-send-e=
mail-JinhuiEric.Huang-5C7GfCeVMHo@public.gmane.org&gt;<br>
Content-Type: text/plain; charset=3D&quot;iso-8859-1&quot;<br>
<br>
The issue is PT BOs are not freed when unmapping VA,<br>
which causes vram usage accumulated is huge in some<br>
memory stress test, such as kfd big buffer stress test.<br>
Function amdgpu_vm_bo_update_mapping() is called by both<br>
amdgpu_vm_bo_update() and amdgpu_vm_clear_freed(). The<br>
solution is replacing amdgpu_vm_bo_update_mapping() in<br>
amdgpu_vm_clear_freed() with removing PT BOs function<br>
to save vram usage.<br>
<br>
Change-Id: Ic24e35bff8ca85265b418a642373f189d972a924<br>
Signed-off-by: Eric Huang &lt;JinhuiEric.Huang-5C7GfCeVMHo@public.gmane.org&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 56 &#43;&#43;&#43;&#43;&#43;=
&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;=
&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;-----<br>
&nbsp;1 file changed, 48 insertions(&#43;), 8 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/a=
mdgpu/amdgpu_vm.c<br>
index 0f4c3b2..8a480c7 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c<br>
@@ -1930,6 &#43;1930,51 @@ static void amdgpu_vm_prt_fini(struct amdgpu_dev=
ice *adev, struct amdgpu_vm *vm)<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;/**<br>
&#43; * amdgpu_vm_remove_ptes - free PT BOs<br>
&#43; *<br>
&#43; * @adev: amdgpu device structure<br>
&#43; * @vm: amdgpu vm structure<br>
&#43; * @start: start of mapped range<br>
&#43; * @end: end of mapped entry<br>
&#43; *<br>
&#43; * Free the page table level.<br>
&#43; */<br>
&#43;static int amdgpu_vm_remove_ptes(struct amdgpu_device *adev,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; struct amdgpu_vm *vm, uint64_t start, uint64_t end)<br>
&#43;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_vm_pt_cursor cursor=
;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned shift, num_entries;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_vm_pt_start(adev, vm, star=
t, &amp;cursor);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; while (cursor.level &lt; AMDGPU_V=
M_PTB) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; if (!amdgpu_vm_pt_descendant(adev, &amp;cursor))<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -ENOE=
NT;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; while (cursor.pfn &lt; end) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; amdgpu_vm_free_table(cursor.entry);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; num_entries =3D amdgpu_vm_num_entries(adev, cursor.level - 1=
);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; if (cursor.entry !=3D &amp;cursor.parent-&gt;entries[num_ent=
ries - 1]) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Next ptb =
entry */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; shift =3D am=
dgpu_vm_level_shift(adev, cursor.level - 1);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cursor.pfn &=
#43;=3D 1ULL &lt;&lt; shift;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cursor.pfn &=
amp;=3D ~((1ULL &lt;&lt; shift) - 1);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cursor.entry=
&#43;&#43;;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; } else {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Next ptb =
entry in next pd0 entry */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_vm_pt=
_ancestor(&amp;cursor);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; shift =3D am=
dgpu_vm_level_shift(adev, cursor.level - 1);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cursor.pfn &=
#43;=3D 1ULL &lt;&lt; shift;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cursor.pfn &=
amp;=3D ~((1ULL &lt;&lt; shift) - 1);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_vm_pt=
_descendant(adev, &amp;cursor);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; }<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&#43;}<br>
&#43;<br>
&#43;/**<br>
&nbsp; * amdgpu_vm_clear_freed - clear freed BOs in the PT<br>
&nbsp; *<br>
&nbsp; * @adev: amdgpu_device pointer<br>
@@ -1949,7 &#43;1994,6 @@ int amdgpu_vm_clear_freed(struct amdgpu_device *a=
dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; struct dma_fence **fence)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_bo_va_mappin=
g *mapping;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t init_pte_value =3D 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dma_fence *f =3D NU=
LL;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r;<br>
&nbsp;<br>
@@ -1958,13 &#43;2002,10 @@ int amdgpu_vm_clear_freed(struct amdgpu_device =
*adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struc=
t amdgpu_bo_va_mapping, list);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; list_del(&amp;mapping-&gt;list);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (vm-&gt;pte_support_ats &amp;&amp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mapping-&gt;start &lt; AMDGPU_GMC_HOLE_S=
TART)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; init_pte_value =
=3D AMDGPU_PTE_DEFAULT_ATC;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; r =3D amdgpu_vm_remove_ptes(adev, vm,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (mapping-&gt;start &#43; 0x1ff) &amp; (=
~0x1ffll),<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (mapping-&gt;last &#43; 1) &amp; (~0x1f=
fll));<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; r =3D amdgpu_vm_bo_update_mapping(adev, vm, false, NULL,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mapping-&gt;start, map=
ping-&gt;last,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; init_pte_value, 0, NUL=
L, &amp;f);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; amdgpu_vm_free_mapping(adev, vm, mapping, f);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (r) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dma_f=
ence_put(f);<br>
@@ -1980,7 &#43;2021,6 @@ int amdgpu_vm_clear_freed(struct amdgpu_device *a=
dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
-<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;/**<br>
-- <br>
2.7.4<br>
<br>
<br>
<br>
------------------------------<br>
<br>
Message: 3<br>
Date: Tue, 29 Oct 2019 16:10:31 -0400<br>
From: Alex Deucher &lt;alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;<br>
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
Cc: Alex Deucher &lt;alexander.deucher-5C7GfCeVMHo@public.gmane.org&gt;<br>
Subject: [PATCH] drm/amdgpu/renoir: move gfxoff handling into gfx9<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; module<br>
Message-ID: &lt;20191029201031.1514210-1-alexander.deucher-5C7GfCeVMHo@public.gmane.org&gt;<br>
<br>
To properly handle the option parsing ordering.<br>
<br>
Signed-off-by: Alex Deucher &lt;alexander.deucher-5C7GfCeVMHo@public.gmane.org&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 6 &#43;&#43;&#43;&#43;&#43;&#=
43;<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/soc15.c&nbsp;&nbsp;&nbsp; | 5 -----<br>
&nbsp;2 files changed, 6 insertions(&#43;), 5 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/am=
dgpu/gfx_v9_0.c<br>
index 9fe95e7693d5..b2b3eb75c48c 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c<br>
@@ -1051,6 &#43;1051,12 @@ static void gfx_v9_0_check_if_need_gfxoff(struct=
 amdgpu_device *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; !adev-&gt;gfx.rlc.is_rlc_v2_1))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-=
&gt;pm.pp_feature &amp;=3D ~PP_GFXOFF_MASK;<br>
&nbsp;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; if (adev-&gt;pm.pp_feature &amp; PP_GFXOFF_MASK)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;pg_=
flags |=3D AMD_PG_SUPPORT_GFX_PG |<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMD_PG_SUPPORT_CP |<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMD_PG_SUPPORT_RLC_SMU_HS;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; break;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_RENOIR:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (adev-&gt;pm.pp_feature &amp; PP_GFXOFF_MASK)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-=
&gt;pg_flags |=3D AMD_PG_SUPPORT_GFX_PG |<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMD_PG_SUPPORT_CP |<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgp=
u/soc15.c<br>
index 16c5bb75889f..25e69ea74a41 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/soc15.c<br>
@@ -1263,11 &#43;1263,6 @@ static int soc15_common_early_init(void *handle)=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMD_PG_SUPPORT_VCN |<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMD_PG_SUPPORT_VCN_DPG;<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; adev-&gt;external_rev_id =3D adev-&gt;rev_id &#43; 0x=
91;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (adev-&gt;pm.pp_feature &amp; PP_GFXOFF_MASK)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;pg_flag=
s |=3D AMD_PG_SUPPORT_GFX_PG |<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMD_PG_SUPPORT_CP |<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMD_PG_SUPPORT_RLC_SMU_HS;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; /* FIXME: not supported yet */<br>
-- <br>
2.23.0<br>
<br>
<br>
<br>
------------------------------<br>
<br>
Message: 4<br>
Date: Tue, 29 Oct 2019 17:15:44 -0400<br>
From: Alex Deucher &lt;alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;<br>
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
Cc: Alex Deucher &lt;alexander.deucher-5C7GfCeVMHo@public.gmane.org&gt;<br>
Subject: [PATCH] drm/amdgpu/gmc10: properly set BANK_SELECT and<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; FRAGMENT_SIZE<br>
Message-ID: &lt;20191029211544.1534432-1-alexander.deucher-5C7GfCeVMHo@public.gmane.org&gt;<br>
<br>
These were not aligned for optimal performance for GPUVM.<br>
<br>
Signed-off-by: Alex Deucher &lt;alexander.deucher-5C7GfCeVMHo@public.gmane.org&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c | 9 &#43;&#43;&#43;&#43;&#43=
;&#43;&#43;&#43;&#43;<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c&nbsp; | 9 &#43;&#43;&#43;&#43=
;&#43;&#43;&#43;&#43;&#43;<br>
&nbsp;2 files changed, 18 insertions(&#43;)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c b/drivers/gpu/drm/amd=
/amdgpu/gfxhub_v2_0.c<br>
index b601c6740ef5..b4f32d853ca1 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c<br>
@@ -155,6 &#43;155,15 @@ static void gfxhub_v2_0_init_cache_regs(struct amd=
gpu_device *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(GC, 0, mmGCVM=
_L2_CNTL2, tmp);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp =3D mmGCVM_L2_CNTL3_DE=
FAULT;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;gmc.translate_furthe=
r) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; tmp =3D REG_SET_FIELD(tmp, GCVM_L2_CNTL3, BANK_SELECT, 12);<=
br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; tmp =3D REG_SET_FIELD(tmp, GCVM_L2_CNTL3,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; L2_CACHE_BIGK_F=
RAGMENT_SIZE, 9);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; tmp =3D REG_SET_FIELD(tmp, GCVM_L2_CNTL3, BANK_SELECT, 9);<b=
r>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; tmp =3D REG_SET_FIELD(tmp, GCVM_L2_CNTL3,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; L2_CACHE_BIGK_F=
RAGMENT_SIZE, 6);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(GC, 0, mmGCVM=
_L2_CNTL3, tmp);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp =3D mmGCVM_L2_CNTL4_DE=
FAULT;<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c b/drivers/gpu/drm/amd/=
amdgpu/mmhub_v2_0.c<br>
index 2eea702de8ee..945533634711 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c<br>
@@ -142,6 &#43;142,15 @@ static void mmhub_v2_0_init_cache_regs(struct amdg=
pu_device *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(MMHUB, 0, mmM=
MVM_L2_CNTL2, tmp);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp =3D mmMMVM_L2_CNTL3_DE=
FAULT;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;gmc.translate_furthe=
r) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; tmp =3D REG_SET_FIELD(tmp, MMVM_L2_CNTL3, BANK_SELECT, 12);<=
br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; tmp =3D REG_SET_FIELD(tmp, MMVM_L2_CNTL3,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; L2_CACHE_BIGK_F=
RAGMENT_SIZE, 9);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; tmp =3D REG_SET_FIELD(tmp, MMVM_L2_CNTL3, BANK_SELECT, 9);<b=
r>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; tmp =3D REG_SET_FIELD(tmp, MMVM_L2_CNTL3,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; L2_CACHE_BIGK_F=
RAGMENT_SIZE, 6);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(MMHUB, 0, mmM=
MVM_L2_CNTL3, tmp);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp =3D mmMMVM_L2_CNTL4_DE=
FAULT;<br>
-- <br>
2.23.0<br>
<br>
<br>
<br>
------------------------------<br>
<br>
Message: 5<br>
Date: Tue, 29 Oct 2019 16:01:29 -0600<br>
From: Neil Mayhew &lt;neil_mayhew-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org&gt;<br>
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
Subject: 21:9 monitor resolution incorrect since 4.14 kernel<br>
Message-ID:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt;32e595a2-fdc1-7b13-2e33-c2b8=
752c60f2-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org&gt;<br>
Content-Type: text/plain; charset=3D&quot;utf-8&quot;<br>
<br>
I have a 21:9 ultrawide monitor connected to an RX 570 with the amdgpu<br>
driver. I'm still using the 4.14 kernel since with later kernels I can't<br=
>
get the driver to allow use of the full resolution of 2560x1080 and I'm<br>
limited to regular HD, ie 1920x1080. The latest kernel I've tried is<br>
5.4-rc2. My distro is NixOS unstable-small. I have two other monitors<br>
(16:9 and 16:10) connected to the same graphics card.<br>
<br>
Is there anything I can do to work around this or try to fix it? I had a<br=
>
look at the driver sources but couldn't find where the mode is set. I'm<br>
happy to try things if someone can point me in the right direction, even<br=
>
if it's just to gather better info for a bug report. Using such an old<br>
kernel is becoming really inconvenient.<br>
<br>
Some additional info about the situation on 4.14 that may or may not help:<=
br>
<br>
1. The resolution is limited with Wayland but not with X11<br>
<br>
2. When the system boots up the resolution is square and the image is<br>
squished horizontally with many columns dropped, both during the boot<br>
process and at the gdm login screen. It's not until after I log with X11<br=
>
that the resolution is set correctly.<br>
<br>
3. The output of xrandr --props is below.<br>
<br>
TIA for any help.<br>
<br>
--Neil<br>
<br>
Screen 0: minimum 320 x 200, current 6160 x 1080, maximum 16384 x 16384<br>
DP-1 connected primary 2560x1080&#43;1920&#43;0 (normal left inverted right=
 x<br>
axis y axis) 798mm x 334mm<br>
&nbsp;&nbsp;&nbsp; _MUTTER_PRESENTATION_OUTPUT: 0<br>
&nbsp;&nbsp;&nbsp; EDID:<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; 00ffffffffffff001e6df9765de80500<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; 091c010380502278eaca95a6554ea126<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; 0f5054256b807140818081c0a9c0b300<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; d1c08100d1cfcd4600a0a0381f403020<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; 3a001e4e3100001a003a801871382d40<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; 582c4500132a2100001e000000fd0038<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; 4b1e5a18000a202020202020000000fc<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; 004c4720554c545241574944450a01b5<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; 02031af12309070747100403011f1312<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; 8301000065030c0010008c0ad08a20e0<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; 2d10103e96001e4e31000018295900a0<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; a038274030203a001e4e3100001a0000<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; 00000000000000000000000000000000<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; 00000000000000000000000000000000<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; 0000000000ff003830394e544b464244<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; 3136350a0000000000000000000000a4<br>
&nbsp;&nbsp;&nbsp; dither: off<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; supported: off, on<br>
&nbsp;&nbsp;&nbsp; audio: auto<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; supported: off, on, auto<br>
&nbsp;&nbsp;&nbsp; scaling mode: None<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; supported: None, Full, Center, Full a=
spect<br>
&nbsp;&nbsp;&nbsp; underscan vborder: 0<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; range: (0, 128)<br>
&nbsp;&nbsp;&nbsp; underscan hborder: 0<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; range: (0, 128)<br>
&nbsp;&nbsp;&nbsp; underscan: off<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; supported: off, on, auto<br>
&nbsp;&nbsp;&nbsp; coherent: 1<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; range: (0, 1)<br>
&nbsp;&nbsp;&nbsp; link-status: Good<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; supported: Good, Bad<br>
&nbsp;&nbsp;&nbsp; CONNECTOR_ID: 48<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; supported: 48<br>
&nbsp;&nbsp;&nbsp; non-desktop: 0<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; supported: 0, 1<br>
&nbsp;&nbsp; 2560x1080&nbsp;&nbsp;&nbsp;&nbsp; 59.98 &#43;&nbsp; 74.99*<br>
&nbsp;&nbsp; 1920x1080&nbsp;&nbsp;&nbsp;&nbsp; 74.99&nbsp;&nbsp;&nbsp; 59.9=
6&nbsp;&nbsp;&nbsp; 50.00&nbsp;&nbsp;&nbsp; 59.99&nbsp;&nbsp;&nbsp; 59.94&n=
bsp;&nbsp;&nbsp; 59.93&nbsp;<br>
&nbsp;&nbsp; 1680x1050&nbsp;&nbsp;&nbsp;&nbsp; 59.95&nbsp;&nbsp;&nbsp; 59.8=
8&nbsp;<br>
<br>
[etc.]<br>
-------------- next part --------------<br>
An HTML attachment was scrubbed...<br>
URL: &lt;<a href=3D"https://lists.freedesktop.org/archives/amd-gfx/attachme=
nts/20191029/471e1fcb/attachment.html">https://lists.freedesktop.org/archiv=
es/amd-gfx/attachments/20191029/471e1fcb/attachment.html</a>&gt;<br>
<br>
------------------------------<br>
<br>
Subject: Digest Footer<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://=
lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
<br>
------------------------------<br>
<br>
End of amd-gfx Digest, Vol 41, Issue 390<br>
****************************************<o:p></o:p></span></p>
</div>
</div>
</div>
</body>
</html>

--_000_DM5PR12MB2535C7FD718B072B97C0589B95600DM5PR12MB2535namp_--

--===============0695744425==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============0695744425==--
