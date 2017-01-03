From: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Subject: Re: [PATCH 11/23] drm/amdgpu: implement context save area(CSA) feature
Date: Tue, 3 Jan 2017 15:30:56 +0100
Message-ID: <a3d544d8-8d9e-a6a8-1779-bf37d0cf28cf@vodafone.de>
References: <1481991405-30422-1-git-send-email-Xiangliang.Yu@amd.com>
 <1481991405-30422-12-git-send-email-Xiangliang.Yu@amd.com>
 <CADnq5_P1hOrd7Vk1G01Gj7aM1RjkyhgLGWV6CnTu9mvrGhtxsg@mail.gmail.com>
 <BY2PR12MB00547F38C7E612AE3A4D027184900@BY2PR12MB0054.namprd12.prod.outlook.com>
 <CY4PR12MB1701351D6DCEA18714735B3DEB900@CY4PR12MB1701.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1290484405=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CY4PR12MB1701351D6DCEA18714735B3DEB900-rpdhrqHFk05QaJCA3gGb3wdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Yu, Xiangliang" <Xiangliang.Yu-5C7GfCeVMHo@public.gmane.org>, "Liu, Monk" <Monk.Liu-5C7GfCeVMHo@public.gmane.org>, Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "dl.SRDC_SW_GPUVirtualization" <dl.SRDC_SW_GPUVirtualization-5C7GfCeVMHo@public.gmane.org>, amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

This is a multi-part message in MIME format.
--===============1290484405==
Content-Type: multipart/alternative;
 boundary="------------F23A1F81410AA5D80B4D0444"

This is a multi-part message in MIME format.
--------------F23A1F81410AA5D80B4D0444
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

NAK on that whole approach. We previously had similar handling in radeon 
for the temporary IB buffer and it was a pain to support correctly.

The main problem is that you might then have a mismatch between the 
housekeeping structures in the VM and what is really in the page tables 
/ page directory.

Additional a concrete problem is that you simply assume that the PD and 
PTs are present when the VM is created, but that might not be correct 
under memory pressure. In this case the code below will just fail miserable.

I suggest that you go a step back and fully implement the support for 
the CSA for each context and not just a quick hack like this. If I 
remember our internal discussion correctly Monk already had promising 
locking patches for this for the general preemption support.

Regards,
Christian.

Am 20.12.2016 um 06:43 schrieb Yu, Xiangliang:
>
> Thank monk’s detail expanation.
>
> And I think this patch is only support virtualization world switch, 
> not touch whole amdpgu preemption.
>
> Thanks!
>
> Xiangliang Yu
>
> *From:*Liu, Monk
> *Sent:* Tuesday, December 20, 2016 11:58 AM
> *To:* Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>; Yu, Xiangliang 
> <Xiangliang.Yu-5C7GfCeVMHo@public.gmane.org>
> *Cc:* amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>; 
> dl.SRDC_SW_GPUVirtualization <dl.SRDC_SW_GPUVirtualization-5C7GfCeVMHo@public.gmane.org>
> *Subject:* 答复: [PATCH 11/23] drm/amdgpu: implement context save 
> area(CSA) feature
>
> the CSA is used for world switch, and each amdgpu device should have 
> one and only one CSA,
>
> and this CSA will pined, and mapped to each virtual memory /process.
>
> CP/RLCV will use this CSA buffer when preemption occurred, and will 
> write some hardware status into this CSA buffer, within the current 
> IB's context (that's why need do mapping for each virtual memory on CSA)
>
> BR Monk
>
> ------------------------------------------------------------------------
>
> *发件人**:*Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org 
> <mailto:alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>>
> *发送时间**:*2016年12月20日7:20:09
> *收件人**:*Yu, Xiangliang
> *抄送**:*amd-gfx list; dl.SRDC_SW_GPUVirtualization; Liu, Monk
> *主题**:*Re: [PATCH 11/23] drm/amdgpu: implement context save area(CSA) 
> feature
>
> On Sat, Dec 17, 2016 at 11:16 AM, Xiangliang Yu <Xiangliang.Yu-5C7GfCeVMHo@public.gmane.org 
> <mailto:Xiangliang.Yu-5C7GfCeVMHo@public.gmane.org>> wrote:
> > CSA is need by world switch. This patch implement CSA feature and
> > bind it to each VM, so hardware can save the state into the area
> > and restore it when running again.
> >
> > Signed-off-by: Monk Liu <Monk.Liu-5C7GfCeVMHo@public.gmane.org <mailto:Monk.Liu-5C7GfCeVMHo@public.gmane.org>>
> > Signed-off-by: Xiangliang Yu <Xiangliang.Yu-5C7GfCeVMHo@public.gmane.org 
> <mailto:Xiangliang.Yu-5C7GfCeVMHo@public.gmane.org>>
>
> Isn't the CSA actually for preemption?  Preemption is useful outside
> of the VF case as well so it should be untangled from the mxgpu code
> so it can be utilized independently.
>
> Alex
>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h |  14 +++
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c   |   8 ++
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h   |   4 +
> >  drivers/gpu/drm/amd/mxgpu/amd_mxgpu.h    |  12 ++
> >  drivers/gpu/drm/amd/mxgpu/mxgpu_csa.c    | 209 
> +++++++++++++++++++++++++++++++
> >  5 files changed, 247 insertions(+)
> >  create mode 100644 drivers/gpu/drm/amd/mxgpu/mxgpu_csa.c
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> > index 8ee70f8..dff1248 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> > @@ -24,6 +24,8 @@
> >  #ifndef AMDGPU_VIRT_H
> >  #define AMDGPU_VIRT_H
> >
> > +struct amdgpu_vm;
> > +
> >  #define AMDGPU_SRIOV_CAPS_SRIOV_VBIOS  (1 << 0) /* vBIOS is sr-iov 
> ready */
> >  #define AMDGPU_SRIOV_CAPS_ENABLE_IOV   (1 << 1) /* sr-iov is 
> enabled on this GPU */
> >  #define AMDGPU_SRIOV_CAPS_IS_VF        (1 << 2) /* this GPU is a 
> virtual function */
> > @@ -33,6 +35,14 @@ struct amdgpu_virtualization {
> >         uint32_t virtual_caps;
> >  };
> >
> > +struct amdgpu_csa {
> > +       struct amdgpu_bo_va             *va;
> > +       struct ttm_validate_buffer      tv;
> > +       uint64_t reserved_top;
> > +       uint64_t                        csa_addr;
> > +       uint64_t                        gds_addr;
> > +};
> > +
> >  #define amdgpu_sriov_enabled(adev) \
> >  ((adev)->virtualization.virtual_caps & AMDGPU_SRIOV_CAPS_ENABLE_IOV)
> >
> > @@ -55,4 +65,8 @@ static inline bool is_virtual_machine(void)
> >  }
> >
> >  int amd_xgpu_set_ip_blocks(struct amdgpu_device *adev);
> > +
> > +/* Context Save Area functions */
> > +int amdgpu_vm_map_csa(struct amdgpu_device *adev, struct amdgpu_vm 
> *vm);
> > +void amdgpu_vm_unmap_csa(struct amdgpu_device *adev, struct 
> amdgpu_vm *vm);
> >  #endif
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> > index d05546e..98540d9 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> > @@ -1539,6 +1539,8 @@ int amdgpu_vm_init(struct amdgpu_device *adev, 
> struct amdgpu_vm *vm)
> >         pd_size = amdgpu_vm_directory_size(adev);
> >         pd_entries = amdgpu_vm_num_pdes(adev);
> >
> > +       vm->csa.reserved_top = AMDGPU_VA_RESERVED_SIZE;
> > +
> >         /* allocate page table array */
> >         vm->page_tables = drm_calloc_large(pd_entries, sizeof(struct 
> amdgpu_vm_pt));
> >         if (vm->page_tables == NULL) {
> > @@ -1576,6 +1578,10 @@ int amdgpu_vm_init(struct amdgpu_device 
> *adev, struct amdgpu_vm *vm)
> >         vm->last_eviction_counter = atomic64_read(&adev->num_evictions);
> >         amdgpu_bo_unreserve(vm->page_directory);
> >
> > +       r = amdgpu_vm_map_csa(adev, vm);
> > +       if (r)
> > +               goto error_free_page_directory;
> > +
> >         return 0;
> >
> >  error_free_page_directory:
> > @@ -1606,6 +1612,8 @@ void amdgpu_vm_fini(struct amdgpu_device 
> *adev, struct amdgpu_vm *vm)
> >         struct amdgpu_bo_va_mapping *mapping, *tmp;
> >         int i;
> >
> > +       amdgpu_vm_unmap_csa(adev, vm);
> > +
> >         amd_sched_entity_fini(vm->entity.sched, &vm->entity);
> >
> >         if (!RB_EMPTY_ROOT(&vm->va)) {
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> > index 42a629b..d90630a 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> > @@ -29,6 +29,7 @@
> >  #include "gpu_scheduler.h"
> >  #include "amdgpu_sync.h"
> >  #include "amdgpu_ring.h"
> > +#include "amdgpu_virt.h"
> >
> >  struct amdgpu_bo_va;
> >  struct amdgpu_job;
> > @@ -109,6 +110,9 @@ struct amdgpu_vm {
> >         /* Scheduler entity for page table updates */
> >         struct amd_sched_entity entity;
> >
> > +       /* Context Save Area */
> > +       struct amdgpu_csa       csa;
> > +
> >         /* client id */
> >         u64                     client_id;
> >  };
> > diff --git a/drivers/gpu/drm/amd/mxgpu/amd_mxgpu.h 
> b/drivers/gpu/drm/amd/mxgpu/amd_mxgpu.h
> > index 6ab13bc..a25e07f 100644
> > --- a/drivers/gpu/drm/amd/mxgpu/amd_mxgpu.h
> > +++ b/drivers/gpu/drm/amd/mxgpu/amd_mxgpu.h
> > @@ -26,12 +26,24 @@
> >
> >  #include "amdgpu.h"
> >
> > +/* xgpu structures */
> > +struct amd_xgpu_csa {
> > +       struct amdgpu_bo            *robj;
> > +       uint64_t                    gpu_addr;
> > +       uint64_t                    gds_addr;
> > +       int32_t                     size;
> > +};
> > +
> >  struct amd_xgpu {
> >         struct amdgpu_device    *adev;
> >         struct mutex            lock;
> > +       struct amd_xgpu_csa     sa;
> >         u32                     reg_val_offs;
> >  };
> >
> >  extern int amd_xgpu_alloc(struct amdgpu_device *adev);
> >  extern void amd_xgpu_free(struct amd_xgpu *xgpu);
> > +
> > +extern int xgpu_allocate_csa(struct amd_xgpu *xgpu);
> > +extern void xgpu_destroy_csa(struct amd_xgpu_csa *csa);
> >  #endif
> > diff --git a/drivers/gpu/drm/amd/mxgpu/mxgpu_csa.c 
> b/drivers/gpu/drm/amd/mxgpu/mxgpu_csa.c
> > new file mode 100644
> > index 0000000..246a747
> > --- /dev/null
> > +++ b/drivers/gpu/drm/amd/mxgpu/mxgpu_csa.c
> > @@ -0,0 +1,209 @@
> > +/*
> > + * Copyright 2016 Advanced Micro Devices, Inc.
> > + *
> > + * Permission is hereby granted, free of charge, to any person 
> obtaining a
> > + * copy of this software and associated documentation files (the 
> "Software"),
> > + * to deal in the Software without restriction, including without 
> limitation
> > + * the rights to use, copy, modify, merge, publish, distribute, 
> sublicense,
> > + * and/or sell copies of the Software, and to permit persons to 
> whom the
> > + * Software is furnished to do so, subject to the following conditions:
> > + *
> > + * The above copyright notice and this permission notice shall be 
> included in
> > + * all copies or substantial portions of the Software.
> > + *
> > + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, 
> EXPRESS OR
> > + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF 
> MERCHANTABILITY,
> > + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO 
> EVENT SHALL
> > + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, 
> DAMAGES OR
> > + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR 
> OTHERWISE,
> > + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE 
> USE OR
> > + * OTHER DEALINGS IN THE SOFTWARE.
> > + *
> > + * Authors: Xiangliang.Yu-5C7GfCeVMHo@public.gmane.org <mailto:Xiangliang.Yu-5C7GfCeVMHo@public.gmane.org>
> > + * Monk.Liu-5C7GfCeVMHo@public.gmane.org <mailto:Monk.Liu-5C7GfCeVMHo@public.gmane.org>
> > + *
> > + */
> > +#include "amd_mxgpu.h"
> > +#include "vid.h"
> > +
> > +static int xgpu_init_csa(struct amdgpu_device *adev, struct 
> amd_xgpu_csa *sa)
> > +{
> > +       int r, size;
> > +       void *ptr;
> > +
> > +       /* meta data (4k) + gds-gfx (4k)*/
> > +       size = PAGE_SIZE + adev->gds.mem.gfx_partition_size;
> > +
> > +       r = amdgpu_bo_create(adev, size, PAGE_SIZE, true,
> > +                            AMDGPU_GEM_DOMAIN_GTT,
> > + AMDGPU_GEM_CREATE_CPU_GTT_USWC,
> > +                            NULL, NULL, &sa->robj);
> > +       if (r) {
> > +               dev_err(adev->dev, "(%d) failed to allocate csa 
> bo\n", r);
> > +               return r;
> > +       }
> > +
> > +       r = amdgpu_bo_reserve(sa->robj, true);
> > +       if (unlikely(r != 0))
> > +               goto error_free;
> > +
> > +       r = amdgpu_bo_pin(sa->robj, AMDGPU_GEM_DOMAIN_GTT, 
> &sa->gpu_addr);
> > +       if (r)
> > +               goto error_unreserve;
> > +
> > +       r = amdgpu_bo_kmap(sa->robj, &ptr);
> > +       if (r)
> > +               goto error_unpin;
> > +
> > +       memset(ptr, 0, size);
> > +       amdgpu_bo_unreserve(sa->robj);
> > +
> > +       sa->size = size;
> > +       sa->gds_addr = sa->gpu_addr + PAGE_SIZE;
> > +
> > +       return 0;
> > +
> > +error_unpin:
> > +       amdgpu_bo_unpin(sa->robj);
> > +error_unreserve:
> > +       amdgpu_bo_unreserve(sa->robj);
> > +error_free:
> > +       amdgpu_bo_unref(&sa->robj);
> > +       return r;
> > +}
> > +
> > +int xgpu_allocate_csa(struct amd_xgpu *xgpu)
> > +{
> > +       struct amdgpu_device *adev = xgpu->adev;
> > +       struct amd_xgpu_csa *sa = &xgpu->sa;
> > +
> > +       return xgpu_init_csa(adev, sa);
> > +}
> > +
> > +void xgpu_destroy_csa(struct amd_xgpu_csa *sa)
> > +{
> > +       amdgpu_bo_reserve(sa->robj, true);
> > +       amdgpu_bo_unpin(sa->robj);
> > +       amdgpu_bo_unreserve(sa->robj);
> > +       amdgpu_bo_unref(&sa->robj);
> > +       sa->gpu_addr = 0;
> > +       sa->gds_addr = 0;
> > +}
> > +
> > +static int xgpu_vm_map_csa(struct amdgpu_device *adev, struct 
> amdgpu_vm *vm,
> > +                          struct amd_xgpu_csa *sa)
> > +{
> > +       int r;
> > +       uint64_t vaddr;
> > +       struct ww_acquire_ctx ticket;
> > +       struct list_head list, duplicates;
> > +       struct amdgpu_bo_list_entry pd;
> > +       struct amdgpu_bo_va *bo_va;
> > +
> > +       INIT_LIST_HEAD(&list);
> > +       INIT_LIST_HEAD(&duplicates);
> > +       INIT_LIST_HEAD(&vm->csa.tv.head);
> > +       vm->csa.tv.bo = &sa->robj->tbo;
> > +       vm->csa.tv.shared = true;
> > +
> > +       list_add(&vm->csa.tv.head, &list);
> > +       amdgpu_vm_get_pd_bo(vm, &list, &pd);
> > +
> > +       spin_lock(&vm->status_lock);
> > +       vm->csa.reserved_top -= sa->size;
> > +       vaddr = vm->csa.reserved_top;
> > +       spin_unlock(&vm->status_lock);
> > +
> > +       r = ttm_eu_reserve_buffers(&ticket, &list, true, &duplicates);
> > +       if (r) {
> > +               DRM_ERROR("failed to reserve global CSA 
> buffer(%d).\n", r);
> > +               return r;
> > +       }
> > +
> > +       bo_va = amdgpu_vm_bo_add(adev, vm, sa->robj);
> > +       if (!bo_va) {
> > +               DRM_ERROR("failed to create bo_va for global CSA 
> buffer.\n");
> > +               return -ENOMEM;
> > +       }
> > +
> > +
> > +       r = amdgpu_vm_bo_map(adev, bo_va, vaddr, 0, sa->size,
> > +                            AMDGPU_PTE_READABLE | 
> AMDGPU_PTE_WRITEABLE |
> > + AMDGPU_PTE_EXECUTABLE);
> > +       if (r) {
> > +               DRM_ERROR("failed to do bo_map on global CSA 
> buffer(%d).\n", r);
> > +               amdgpu_vm_bo_rmv(adev, bo_va);
> > + ttm_eu_backoff_reservation(&ticket, &list);
> > +               kfree(bo_va);
> > +               return r;
> > +       }
> > +
> > +       ttm_eu_backoff_reservation(&ticket, &list);
> > +       amdgpu_gem_va_update_vm(adev, bo_va, AMDGPU_VA_OP_MAP);
> > +
> > +       vm->csa.va = bo_va;
> > +       vm->csa.csa_addr = vaddr;
> > +       vm->csa.gds_addr = vaddr + PAGE_SIZE;
> > +
> > +       return 0;
> > +}
> > +
> > +int amdgpu_vm_map_csa(struct amdgpu_device *adev, struct amdgpu_vm *vm)
> > +{
> > +       struct amd_xgpu *xgpu = (struct amd_xgpu *)adev->priv_data;
> > +       struct amd_xgpu_csa *sa = NULL;
> > +
> > +       if (!xgpu)
> > +               return 0;
> > +
> > +       sa = &xgpu->sa;
> > +
> > +       return xgpu_vm_map_csa(adev, vm, sa);
> > +}
> > +
> > +static void xgpu_vm_unmap_csa(struct amdgpu_device *adev, struct 
> amdgpu_vm *vm,
> > +                             struct amd_xgpu_csa *sa)
> > +{
> > +       int r;
> > +       struct ww_acquire_ctx ticket;
> > +       struct list_head list, duplicates;
> > +       struct amdgpu_bo_list_entry pd;
> > +
> > +       if (!vm->csa.va)
> > +               return;
> > +
> > +       INIT_LIST_HEAD(&list);
> > +       INIT_LIST_HEAD(&duplicates);
> > +       list_add(&vm->csa.tv.head, &list);
> > +       amdgpu_vm_get_pd_bo(vm, &list, &pd);
> > +
> > +       r = ttm_eu_reserve_buffers(&ticket, &list, true, &duplicates);
> > +       if (r) {
> > +               DRM_ERROR("failed to reserve global CSA 
> buffer(%d).\n", r);
> > +               return;
> > +       }
> > +
> > +       amdgpu_vm_bo_rmv(adev, vm->csa.va);
> > +       /* maybe we don't need to do real clearing for the vm will 
> die soon */
> > +       r = amdgpu_vm_clear_freed(adev, vm);
> > +       if (r) {
> > +               DRM_ERROR("failed to clear global CSA bo(%d).\n", r);
> > +               return;
> > +       }
> > +
> > +       ttm_eu_backoff_reservation(&ticket, &list);
> > +       vm->csa.va = NULL;
> > +       vm->csa.csa_addr = vm->csa.gds_addr = 0;
> > +}
> > +
> > +void amdgpu_vm_unmap_csa(struct amdgpu_device *adev, struct 
> amdgpu_vm *vm)
> > +{
> > +       struct amd_xgpu *xgpu = (struct amd_xgpu *)adev->priv_data;
> > +       struct amd_xgpu_csa *sa = NULL;
> > +
> > +       if (!xgpu)
> > +               return;
> > +
> > +       sa = &xgpu->sa;
> > +       xgpu_vm_unmap_csa(adev, vm, sa);
> > +}
> > --
> > 2.7.4
> >
> > _______________________________________________
> > amd-gfx mailing list
> > amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
> > https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>
>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx



--------------F23A1F81410AA5D80B4D0444
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta content="text/html; charset=utf-8" http-equiv="Content-Type">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    <div class="moz-cite-prefix">NAK on that whole approach. We
      previously had similar handling in radeon for the temporary IB
      buffer and it was a pain to support correctly.<br>
      <br>
      The main problem is that you might then have a mismatch between
      the housekeeping structures in the VM and what is really in the
      page tables / page directory.<br>
      <br>
      Additional a concrete problem is that you simply assume that the
      PD and PTs are present when the VM is created, but that might not
      be correct under memory pressure. In this case the code below will
      just fail miserable.<br>
      <br>
      I suggest that you go a step back and fully implement the support
      for the CSA for each context and not just a quick hack like this.
      If I remember our internal discussion correctly Monk already had
      promising locking patches for this for the general preemption
      support.<br>
      <br>
      Regards,<br>
      Christian.<br>
      <br>
      Am 20.12.2016 um 06:43 schrieb Yu, Xiangliang:<br>
    </div>
    <blockquote
cite="mid:CY4PR12MB1701351D6DCEA18714735B3DEB900-rpdhrqHFk05QaJCA3gGb3wdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org"
      type="cite">
      <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
      <meta name="Generator" content="Microsoft Word 15 (filtered
        medium)">
      <!--[if !mso]><style>v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style><![endif]-->
      <style><!--
/* Font Definitions */
@font-face
	{font-family:宋体;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"\@宋体";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:宋体;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:purple;
	text-decoration:underline;}
p
	{mso-style-priority:99;
	margin:0in;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:宋体;}
p.emailquote, li.emailquote, div.emailquote
	{mso-style-name:emailquote;
	margin-top:0in;
	margin-right:0in;
	margin-bottom:0in;
	margin-left:1.0pt;
	margin-bottom:.0001pt;
	border:none;
	padding:0in;
	font-size:12.0pt;
	font-family:宋体;}
span.EmailStyle19
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:#1F497D;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.25in 1.0in 1.25in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext="edit" spidmax="1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext="edit">
<o:idmap v:ext="edit" data="1" />
</o:shapelayout></xml><![endif]-->
      <div class="WordSection1">
        <p class="MsoNormal"><span
style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:#1F497D">Thank
            monk’s detail expanation.<o:p></o:p></span></p>
        <p class="MsoNormal"><span
style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:#1F497D">And
            I think this patch is only support virtualization world
            switch, not touch whole amdpgu preemption.
            <o:p></o:p></span></p>
        <p class="MsoNormal"><span
style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:#1F497D"><o:p> </o:p></span></p>
        <p class="MsoNormal"><span
style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:#1F497D">Thanks!<o:p></o:p></span></p>
        <p class="MsoNormal"><span
style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:#1F497D">Xiangliang
            Yu<o:p></o:p></span></p>
        <p class="MsoNormal"><span
style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:#1F497D"><o:p> </o:p></span></p>
        <div style="border:none;border-left:solid blue 1.5pt;padding:0in
          0in 0in 4.0pt">
          <div>
            <div style="border:none;border-top:solid #E1E1E1
              1.0pt;padding:3.0pt 0in 0in 0in">
              <p class="MsoNormal"><b><span
                    style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif">From:</span></b><span
style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif">
                  Liu, Monk
                  <br>
                  <b>Sent:</b> Tuesday, December 20, 2016 11:58 AM<br>
                  <b>To:</b> Alex Deucher <a class="moz-txt-link-rfc2396E" href="mailto:alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">&lt;alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;</a>;
                  Yu, Xiangliang <a class="moz-txt-link-rfc2396E" href="mailto:Xiangliang.Yu-5C7GfCeVMHo@public.gmane.org">&lt;Xiangliang.Yu-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
                  <b>Cc:</b> amd-gfx list
                  <a class="moz-txt-link-rfc2396E" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">&lt;amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt;</a>;
                  dl.SRDC_SW_GPUVirtualization
                  <a class="moz-txt-link-rfc2396E" href="mailto:dl.SRDC_SW_GPUVirtualization-5C7GfCeVMHo@public.gmane.org">&lt;dl.SRDC_SW_GPUVirtualization-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
                  <b>Subject:</b> </span><span style="font-size:11.0pt"
                  lang="ZH-CN">答复</span><span
                  style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif">:
                  [PATCH 11/23] drm/amdgpu: implement context save
                  area(CSA) feature<o:p></o:p></span></p>
            </div>
          </div>
          <p class="MsoNormal"><o:p> </o:p></p>
          <div>
            <div id="x_divtagdefaultwrapper">
              <p><span
                  style="font-family:&quot;Calibri&quot;,sans-serif;color:black">the
                  CSA is used for world switch, and each amdgpu device
                  should have one and only one CSA,<o:p></o:p></span></p>
              <p><span
                  style="font-family:&quot;Calibri&quot;,sans-serif;color:black">and
                  this CSA will pined, and mapped to each virtual memory
                  /process.<o:p></o:p></span></p>
              <p><span
                  style="font-family:&quot;Calibri&quot;,sans-serif;color:black"><o:p> </o:p></span></p>
              <p><span
                  style="font-family:&quot;Calibri&quot;,sans-serif;color:black">CP/RLCV
                  will use this CSA buffer when preemption occurred, and
                  will write some hardware status into this CSA buffer,
                  within the current IB's context (that's why need do
                  mapping for each virtual memory on CSA)<o:p></o:p></span></p>
              <p><span
                  style="font-family:&quot;Calibri&quot;,sans-serif;color:black"><o:p> </o:p></span></p>
              <p><span
                  style="font-family:&quot;Calibri&quot;,sans-serif;color:black">BR
                  Monk<o:p></o:p></span></p>
            </div>
            <div class="MsoNormal" style="text-align:center"
              align="center">
              <hr width="98%" align="center" size="2">
            </div>
            <div id="x_divRplyFwdMsg">
              <p class="MsoNormal"><b><span
                    style="font-size:11.0pt;color:black" lang="ZH-CN">发件人</span></b><b><span
style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:black">:</span></b><span
style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:black">
                  Alex Deucher &lt;<a moz-do-not-send="true"
                    href="mailto:alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;<br>
                </span><b><span style="font-size:11.0pt;color:black"
                    lang="ZH-CN">发送时间</span></b><b><span
style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:black">:</span></b><span
style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:black">
                  2016</span><span style="font-size:11.0pt;color:black"
                  lang="ZH-CN">年</span><span
style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:black">12</span><span
                  style="font-size:11.0pt;color:black" lang="ZH-CN">月</span><span
style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:black">20</span><span
                  style="font-size:11.0pt;color:black" lang="ZH-CN">日</span><span
style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:black">
                  7:20:09<br>
                </span><b><span style="font-size:11.0pt;color:black"
                    lang="ZH-CN">收件人</span></b><b><span
style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:black">:</span></b><span
style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:black">
                  Yu, Xiangliang<br>
                </span><b><span style="font-size:11.0pt;color:black"
                    lang="ZH-CN">抄送</span></b><b><span
style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:black">:</span></b><span
style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:black">
                  amd-gfx list; dl.SRDC_SW_GPUVirtualization; Liu, Monk<br>
                </span><b><span style="font-size:11.0pt;color:black"
                    lang="ZH-CN">主题</span></b><b><span
style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:black">:</span></b><span
style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:black">
                  Re: [PATCH 11/23] drm/amdgpu: implement context save
                  area(CSA) feature</span> <o:p></o:p></p>
              <div>
                <p class="MsoNormal"> <o:p></o:p></p>
              </div>
            </div>
          </div>
          <div>
            <p class="MsoNormal"><span style="font-size:10.0pt">On Sat,
                Dec 17, 2016 at 11:16 AM, Xiangliang Yu &lt;<a
                  moz-do-not-send="true"
                  href="mailto:Xiangliang.Yu-5C7GfCeVMHo@public.gmane.org"><a class="moz-txt-link-abbreviated" href="mailto:Xiangliang.Yu-5C7GfCeVMHo@public.gmane.org">Xiangliang.Yu-5C7GfCeVMHo@public.gmane.org</a></a>&gt;
                wrote:<br>
                &gt; CSA is need by world switch. This patch implement
                CSA feature and<br>
                &gt; bind it to each VM, so hardware can save the state
                into the area<br>
                &gt; and restore it when running again.<br>
                &gt;<br>
                &gt; Signed-off-by: Monk Liu &lt;<a
                  moz-do-not-send="true" href="mailto:Monk.Liu-5C7GfCeVMHo@public.gmane.org"><a class="moz-txt-link-abbreviated" href="mailto:Monk.Liu-5C7GfCeVMHo@public.gmane.org">Monk.Liu-5C7GfCeVMHo@public.gmane.org</a></a>&gt;<br>
                &gt; Signed-off-by: Xiangliang Yu &lt;<a
                  moz-do-not-send="true"
                  href="mailto:Xiangliang.Yu-5C7GfCeVMHo@public.gmane.org"><a class="moz-txt-link-abbreviated" href="mailto:Xiangliang.Yu-5C7GfCeVMHo@public.gmane.org">Xiangliang.Yu-5C7GfCeVMHo@public.gmane.org</a></a>&gt;<br>
                <br>
                Isn't the CSA actually for preemption?  Preemption is
                useful outside<br>
                of the VF case as well so it should be untangled from
                the mxgpu code<br>
                so it can be utilized independently.<br>
                <br>
                Alex<br>
                <br>
                &gt; ---<br>
                &gt;  drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h |  14 +++<br>
                &gt;  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c   |   8 ++<br>
                &gt;  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h   |   4 +<br>
                &gt;  drivers/gpu/drm/amd/mxgpu/amd_mxgpu.h    |  12 ++<br>
                &gt;  drivers/gpu/drm/amd/mxgpu/mxgpu_csa.c    | 209
                +++++++++++++++++++++++++++++++<br>
                &gt;  5 files changed, 247 insertions(+)<br>
                &gt;  create mode 100644
                drivers/gpu/drm/amd/mxgpu/mxgpu_csa.c<br>
                &gt;<br>
                &gt; diff --git
                a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
                b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h<br>
                &gt; index 8ee70f8..dff1248 100644<br>
                &gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h<br>
                &gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h<br>
                &gt; @@ -24,6 +24,8 @@<br>
                &gt;  #ifndef AMDGPU_VIRT_H<br>
                &gt;  #define AMDGPU_VIRT_H<br>
                &gt;<br>
                &gt; +struct amdgpu_vm;<br>
                &gt; +<br>
                &gt;  #define AMDGPU_SRIOV_CAPS_SRIOV_VBIOS  (1 &lt;&lt;
                0) /* vBIOS is sr-iov ready */<br>
                &gt;  #define AMDGPU_SRIOV_CAPS_ENABLE_IOV   (1 &lt;&lt;
                1) /* sr-iov is enabled on this GPU */<br>
                &gt;  #define AMDGPU_SRIOV_CAPS_IS_VF        (1 &lt;&lt;
                2) /* this GPU is a virtual function */<br>
                &gt; @@ -33,6 +35,14 @@ struct amdgpu_virtualization {<br>
                &gt;         uint32_t virtual_caps;<br>
                &gt;  };<br>
                &gt;<br>
                &gt; +struct amdgpu_csa {<br>
                &gt; +       struct amdgpu_bo_va             *va;<br>
                &gt; +       struct ttm_validate_buffer      tv;<br>
                &gt; +       uint64_t                       
                reserved_top;<br>
                &gt; +       uint64_t                        csa_addr;<br>
                &gt; +       uint64_t                        gds_addr;<br>
                &gt; +};<br>
                &gt; +<br>
                &gt;  #define amdgpu_sriov_enabled(adev) \<br>
                &gt;  ((adev)-&gt;virtualization.virtual_caps &amp;
                AMDGPU_SRIOV_CAPS_ENABLE_IOV)<br>
                &gt;<br>
                &gt; @@ -55,4 +65,8 @@ static inline bool
                is_virtual_machine(void)<br>
                &gt;  }<br>
                &gt;<br>
                &gt;  int amd_xgpu_set_ip_blocks(struct amdgpu_device
                *adev);<br>
                &gt; +<br>
                &gt; +/* Context Save Area functions */<br>
                &gt; +int amdgpu_vm_map_csa(struct amdgpu_device *adev,
                struct amdgpu_vm *vm);<br>
                &gt; +void amdgpu_vm_unmap_csa(struct amdgpu_device
                *adev, struct amdgpu_vm *vm);<br>
                &gt;  #endif<br>
                &gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
                b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c<br>
                &gt; index d05546e..98540d9 100644<br>
                &gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c<br>
                &gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c<br>
                &gt; @@ -1539,6 +1539,8 @@ int amdgpu_vm_init(struct
                amdgpu_device *adev, struct amdgpu_vm *vm)<br>
                &gt;         pd_size = amdgpu_vm_directory_size(adev);<br>
                &gt;         pd_entries = amdgpu_vm_num_pdes(adev);<br>
                &gt;<br>
                &gt; +       vm-&gt;csa.reserved_top =
                AMDGPU_VA_RESERVED_SIZE;<br>
                &gt; +<br>
                &gt;         /* allocate page table array */<br>
                &gt;         vm-&gt;page_tables =
                drm_calloc_large(pd_entries, sizeof(struct
                amdgpu_vm_pt));<br>
                &gt;         if (vm-&gt;page_tables == NULL) {<br>
                &gt; @@ -1576,6 +1578,10 @@ int amdgpu_vm_init(struct
                amdgpu_device *adev, struct amdgpu_vm *vm)<br>
                &gt;         vm-&gt;last_eviction_counter =
                atomic64_read(&amp;adev-&gt;num_evictions);<br>
                &gt;         amdgpu_bo_unreserve(vm-&gt;page_directory);<br>
                &gt;<br>
                &gt; +       r = amdgpu_vm_map_csa(adev, vm);<br>
                &gt; +       if (r)<br>
                &gt; +               goto error_free_page_directory;<br>
                &gt; +<br>
                &gt;         return 0;<br>
                &gt;<br>
                &gt;  error_free_page_directory:<br>
                &gt; @@ -1606,6 +1612,8 @@ void amdgpu_vm_fini(struct
                amdgpu_device *adev, struct amdgpu_vm *vm)<br>
                &gt;         struct amdgpu_bo_va_mapping *mapping, *tmp;<br>
                &gt;         int i;<br>
                &gt;<br>
                &gt; +       amdgpu_vm_unmap_csa(adev, vm);<br>
                &gt; +<br>
                &gt;         amd_sched_entity_fini(vm-&gt;entity.sched,
                &amp;vm-&gt;entity);<br>
                &gt;<br>
                &gt;         if (!RB_EMPTY_ROOT(&amp;vm-&gt;va)) {<br>
                &gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
                b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h<br>
                &gt; index 42a629b..d90630a 100644<br>
                &gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h<br>
                &gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h<br>
                &gt; @@ -29,6 +29,7 @@<br>
                &gt;  #include "gpu_scheduler.h"<br>
                &gt;  #include "amdgpu_sync.h"<br>
                &gt;  #include "amdgpu_ring.h"<br>
                &gt; +#include "amdgpu_virt.h"<br>
                &gt;<br>
                &gt;  struct amdgpu_bo_va;<br>
                &gt;  struct amdgpu_job;<br>
                &gt; @@ -109,6 +110,9 @@ struct amdgpu_vm {<br>
                &gt;         /* Scheduler entity for page table updates
                */<br>
                &gt;         struct amd_sched_entity entity;<br>
                &gt;<br>
                &gt; +       /* Context Save Area */<br>
                &gt; +       struct amdgpu_csa       csa;<br>
                &gt; +<br>
                &gt;         /* client id */<br>
                &gt;         u64                     client_id;<br>
                &gt;  };<br>
                &gt; diff --git a/drivers/gpu/drm/amd/mxgpu/amd_mxgpu.h
                b/drivers/gpu/drm/amd/mxgpu/amd_mxgpu.h<br>
                &gt; index 6ab13bc..a25e07f 100644<br>
                &gt; --- a/drivers/gpu/drm/amd/mxgpu/amd_mxgpu.h<br>
                &gt; +++ b/drivers/gpu/drm/amd/mxgpu/amd_mxgpu.h<br>
                &gt; @@ -26,12 +26,24 @@<br>
                &gt;<br>
                &gt;  #include "amdgpu.h"<br>
                &gt;<br>
                &gt; +/* xgpu structures */<br>
                &gt; +struct amd_xgpu_csa {<br>
                &gt; +       struct amdgpu_bo            *robj;<br>
                &gt; +       uint64_t                    gpu_addr;<br>
                &gt; +       uint64_t                    gds_addr;<br>
                &gt; +       int32_t                     size;<br>
                &gt; +};<br>
                &gt; +<br>
                &gt;  struct amd_xgpu {<br>
                &gt;         struct amdgpu_device    *adev;<br>
                &gt;         struct mutex            lock;<br>
                &gt; +       struct amd_xgpu_csa     sa;<br>
                &gt;         u32                     reg_val_offs;<br>
                &gt;  };<br>
                &gt;<br>
                &gt;  extern int amd_xgpu_alloc(struct amdgpu_device
                *adev);<br>
                &gt;  extern void amd_xgpu_free(struct amd_xgpu *xgpu);<br>
                &gt; +<br>
                &gt; +extern int xgpu_allocate_csa(struct amd_xgpu
                *xgpu);<br>
                &gt; +extern void xgpu_destroy_csa(struct amd_xgpu_csa
                *csa);<br>
                &gt;  #endif<br>
                &gt; diff --git a/drivers/gpu/drm/amd/mxgpu/mxgpu_csa.c
                b/drivers/gpu/drm/amd/mxgpu/mxgpu_csa.c<br>
                &gt; new file mode 100644<br>
                &gt; index 0000000..246a747<br>
                &gt; --- /dev/null<br>
                &gt; +++ b/drivers/gpu/drm/amd/mxgpu/mxgpu_csa.c<br>
                &gt; @@ -0,0 +1,209 @@<br>
                &gt; +/*<br>
                &gt; + * Copyright 2016 Advanced Micro Devices, Inc.<br>
                &gt; + *<br>
                &gt; + * Permission is hereby granted, free of charge,
                to any person obtaining a<br>
                &gt; + * copy of this software and associated
                documentation files (the "Software"),<br>
                &gt; + * to deal in the Software without restriction,
                including without limitation<br>
                &gt; + * the rights to use, copy, modify, merge,
                publish, distribute, sublicense,<br>
                &gt; + * and/or sell copies of the Software, and to
                permit persons to whom the<br>
                &gt; + * Software is furnished to do so, subject to the
                following conditions:<br>
                &gt; + *<br>
                &gt; + * The above copyright notice and this permission
                notice shall be included in<br>
                &gt; + * all copies or substantial portions of the
                Software.<br>
                &gt; + *<br>
                &gt; + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT
                WARRANTY OF ANY KIND, EXPRESS OR<br>
                &gt; + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE
                WARRANTIES OF MERCHANTABILITY,<br>
                &gt; + * FITNESS FOR A PARTICULAR PURPOSE AND
                NONINFRINGEMENT.  IN NO EVENT SHALL<br>
                &gt; + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE
                FOR ANY CLAIM, DAMAGES OR<br>
                &gt; + * OTHER LIABILITY, WHETHER IN AN ACTION OF
                CONTRACT, TORT OR OTHERWISE,<br>
                &gt; + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE
                SOFTWARE OR THE USE OR<br>
                &gt; + * OTHER DEALINGS IN THE SOFTWARE.<br>
                &gt; + *<br>
                &gt; + * Authors: <a moz-do-not-send="true"
                  href="mailto:Xiangliang.Yu-5C7GfCeVMHo@public.gmane.org">Xiangliang.Yu-5C7GfCeVMHo@public.gmane.org</a><br>
                &gt; + *         <a moz-do-not-send="true"
                  href="mailto:Monk.Liu-5C7GfCeVMHo@public.gmane.org">Monk.Liu-5C7GfCeVMHo@public.gmane.org</a><br>
                &gt; + *<br>
                &gt; + */<br>
                &gt; +#include "amd_mxgpu.h"<br>
                &gt; +#include "vid.h"<br>
                &gt; +<br>
                &gt; +static int xgpu_init_csa(struct amdgpu_device
                *adev, struct amd_xgpu_csa *sa)<br>
                &gt; +{<br>
                &gt; +       int r, size;<br>
                &gt; +       void *ptr;<br>
                &gt; +<br>
                &gt; +       /* meta data (4k) + gds-gfx (4k)*/<br>
                &gt; +       size = PAGE_SIZE +
                adev-&gt;gds.mem.gfx_partition_size;<br>
                &gt; +<br>
                &gt; +       r = amdgpu_bo_create(adev, size, PAGE_SIZE,
                true,<br>
                &gt; +                            AMDGPU_GEM_DOMAIN_GTT,<br>
                &gt; +                           
                AMDGPU_GEM_CREATE_CPU_GTT_USWC,<br>
                &gt; +                            NULL, NULL,
                &amp;sa-&gt;robj);<br>
                &gt; +       if (r) {<br>
                &gt; +               dev_err(adev-&gt;dev, "(%d) failed
                to allocate csa bo\n", r);<br>
                &gt; +               return r;<br>
                &gt; +       }<br>
                &gt; +<br>
                &gt; +       r = amdgpu_bo_reserve(sa-&gt;robj, true);<br>
                &gt; +       if (unlikely(r != 0))<br>
                &gt; +               goto error_free;<br>
                &gt; +<br>
                &gt; +       r = amdgpu_bo_pin(sa-&gt;robj,
                AMDGPU_GEM_DOMAIN_GTT, &amp;sa-&gt;gpu_addr);<br>
                &gt; +       if (r)<br>
                &gt; +               goto error_unreserve;<br>
                &gt; +<br>
                &gt; +       r = amdgpu_bo_kmap(sa-&gt;robj, &amp;ptr);<br>
                &gt; +       if (r)<br>
                &gt; +               goto error_unpin;<br>
                &gt; +<br>
                &gt; +       memset(ptr, 0, size);<br>
                &gt; +       amdgpu_bo_unreserve(sa-&gt;robj);<br>
                &gt; +<br>
                &gt; +       sa-&gt;size = size;<br>
                &gt; +       sa-&gt;gds_addr = sa-&gt;gpu_addr +
                PAGE_SIZE;<br>
                &gt; +<br>
                &gt; +       return 0;<br>
                &gt; +<br>
                &gt; +error_unpin:<br>
                &gt; +       amdgpu_bo_unpin(sa-&gt;robj);<br>
                &gt; +error_unreserve:<br>
                &gt; +       amdgpu_bo_unreserve(sa-&gt;robj);<br>
                &gt; +error_free:<br>
                &gt; +       amdgpu_bo_unref(&amp;sa-&gt;robj);<br>
                &gt; +       return r;<br>
                &gt; +}<br>
                &gt; +<br>
                &gt; +int xgpu_allocate_csa(struct amd_xgpu *xgpu)<br>
                &gt; +{<br>
                &gt; +       struct amdgpu_device *adev = xgpu-&gt;adev;<br>
                &gt; +       struct amd_xgpu_csa *sa = &amp;xgpu-&gt;sa;<br>
                &gt; +<br>
                &gt; +       return xgpu_init_csa(adev, sa);<br>
                &gt; +}<br>
                &gt; +<br>
                &gt; +void xgpu_destroy_csa(struct amd_xgpu_csa *sa)<br>
                &gt; +{<br>
                &gt; +       amdgpu_bo_reserve(sa-&gt;robj, true);<br>
                &gt; +       amdgpu_bo_unpin(sa-&gt;robj);<br>
                &gt; +       amdgpu_bo_unreserve(sa-&gt;robj);<br>
                &gt; +       amdgpu_bo_unref(&amp;sa-&gt;robj);<br>
                &gt; +       sa-&gt;gpu_addr = 0;<br>
                &gt; +       sa-&gt;gds_addr = 0;<br>
                &gt; +}<br>
                &gt; +<br>
                &gt; +static int xgpu_vm_map_csa(struct amdgpu_device
                *adev, struct amdgpu_vm *vm,<br>
                &gt; +                          struct amd_xgpu_csa *sa)<br>
                &gt; +{<br>
                &gt; +       int r;<br>
                &gt; +       uint64_t vaddr;<br>
                &gt; +       struct ww_acquire_ctx ticket;<br>
                &gt; +       struct list_head list, duplicates;<br>
                &gt; +       struct amdgpu_bo_list_entry pd;<br>
                &gt; +       struct amdgpu_bo_va *bo_va;<br>
                &gt; +<br>
                &gt; +       INIT_LIST_HEAD(&amp;list);<br>
                &gt; +       INIT_LIST_HEAD(&amp;duplicates);<br>
                &gt; +       INIT_LIST_HEAD(&amp;vm-&gt;csa.tv.head);<br>
                &gt; +       vm-&gt;csa.tv.bo =
                &amp;sa-&gt;robj-&gt;tbo;<br>
                &gt; +       vm-&gt;csa.tv.shared = true;<br>
                &gt; +<br>
                &gt; +       list_add(&amp;vm-&gt;csa.tv.head,
                &amp;list);<br>
                &gt; +       amdgpu_vm_get_pd_bo(vm, &amp;list,
                &amp;pd);<br>
                &gt; +<br>
                &gt; +       spin_lock(&amp;vm-&gt;status_lock);<br>
                &gt; +       vm-&gt;csa.reserved_top -= sa-&gt;size;<br>
                &gt; +       vaddr = vm-&gt;csa.reserved_top;<br>
                &gt; +       spin_unlock(&amp;vm-&gt;status_lock);<br>
                &gt; +<br>
                &gt; +       r = ttm_eu_reserve_buffers(&amp;ticket,
                &amp;list, true, &amp;duplicates);<br>
                &gt; +       if (r) {<br>
                &gt; +               DRM_ERROR("failed to reserve global
                CSA buffer(%d).\n", r);<br>
                &gt; +               return r;<br>
                &gt; +       }<br>
                &gt; +<br>
                &gt; +       bo_va = amdgpu_vm_bo_add(adev, vm,
                sa-&gt;robj);<br>
                &gt; +       if (!bo_va) {<br>
                &gt; +               DRM_ERROR("failed to create bo_va
                for global CSA buffer.\n");<br>
                &gt; +               return -ENOMEM;<br>
                &gt; +       }<br>
                &gt; +<br>
                &gt; +<br>
                &gt; +       r = amdgpu_vm_bo_map(adev, bo_va, vaddr, 0,
                sa-&gt;size,<br>
                &gt; +                            AMDGPU_PTE_READABLE |
                AMDGPU_PTE_WRITEABLE |<br>
                &gt; +                           
                AMDGPU_PTE_EXECUTABLE);<br>
                &gt; +       if (r) {<br>
                &gt; +               DRM_ERROR("failed to do bo_map on
                global CSA buffer(%d).\n", r);<br>
                &gt; +               amdgpu_vm_bo_rmv(adev, bo_va);<br>
                &gt; +              
                ttm_eu_backoff_reservation(&amp;ticket, &amp;list);<br>
                &gt; +               kfree(bo_va);<br>
                &gt; +               return r;<br>
                &gt; +       }<br>
                &gt; +<br>
                &gt; +       ttm_eu_backoff_reservation(&amp;ticket,
                &amp;list);<br>
                &gt; +       amdgpu_gem_va_update_vm(adev, bo_va,
                AMDGPU_VA_OP_MAP);<br>
                &gt; +<br>
                &gt; +       vm-&gt;csa.va = bo_va;<br>
                &gt; +       vm-&gt;csa.csa_addr = vaddr;<br>
                &gt; +       vm-&gt;csa.gds_addr = vaddr + PAGE_SIZE;<br>
                &gt; +<br>
                &gt; +       return 0;<br>
                &gt; +}<br>
                &gt; +<br>
                &gt; +int amdgpu_vm_map_csa(struct amdgpu_device *adev,
                struct amdgpu_vm *vm)<br>
                &gt; +{<br>
                &gt; +       struct amd_xgpu *xgpu = (struct amd_xgpu
                *)adev-&gt;priv_data;<br>
                &gt; +       struct amd_xgpu_csa *sa = NULL;<br>
                &gt; +<br>
                &gt; +       if (!xgpu)<br>
                &gt; +               return 0;<br>
                &gt; +<br>
                &gt; +       sa = &amp;xgpu-&gt;sa;<br>
                &gt; +<br>
                &gt; +       return xgpu_vm_map_csa(adev, vm, sa);<br>
                &gt; +}<br>
                &gt; +<br>
                &gt; +static void xgpu_vm_unmap_csa(struct amdgpu_device
                *adev, struct amdgpu_vm *vm,<br>
                &gt; +                             struct amd_xgpu_csa
                *sa)<br>
                &gt; +{<br>
                &gt; +       int r;<br>
                &gt; +       struct ww_acquire_ctx ticket;<br>
                &gt; +       struct list_head list, duplicates;<br>
                &gt; +       struct amdgpu_bo_list_entry pd;<br>
                &gt; +<br>
                &gt; +       if (!vm-&gt;csa.va)<br>
                &gt; +               return;<br>
                &gt; +<br>
                &gt; +       INIT_LIST_HEAD(&amp;list);<br>
                &gt; +       INIT_LIST_HEAD(&amp;duplicates);<br>
                &gt; +       list_add(&amp;vm-&gt;csa.tv.head,
                &amp;list);<br>
                &gt; +       amdgpu_vm_get_pd_bo(vm, &amp;list,
                &amp;pd);<br>
                &gt; +<br>
                &gt; +       r = ttm_eu_reserve_buffers(&amp;ticket,
                &amp;list, true, &amp;duplicates);<br>
                &gt; +       if (r) {<br>
                &gt; +               DRM_ERROR("failed to reserve global
                CSA buffer(%d).\n", r);<br>
                &gt; +               return;<br>
                &gt; +       }<br>
                &gt; +<br>
                &gt; +       amdgpu_vm_bo_rmv(adev, vm-&gt;csa.va);<br>
                &gt; +       /* maybe we don't need to do real clearing
                for the vm will die soon */<br>
                &gt; +       r = amdgpu_vm_clear_freed(adev, vm);<br>
                &gt; +       if (r) {<br>
                &gt; +               DRM_ERROR("failed to clear global
                CSA bo(%d).\n", r);<br>
                &gt; +               return;<br>
                &gt; +       }<br>
                &gt; +<br>
                &gt; +       ttm_eu_backoff_reservation(&amp;ticket,
                &amp;list);<br>
                &gt; +       vm-&gt;csa.va = NULL;<br>
                &gt; +       vm-&gt;csa.csa_addr = vm-&gt;csa.gds_addr =
                0;<br>
                &gt; +}<br>
                &gt; +<br>
                &gt; +void amdgpu_vm_unmap_csa(struct amdgpu_device
                *adev, struct amdgpu_vm *vm)<br>
                &gt; +{<br>
                &gt; +       struct amd_xgpu *xgpu = (struct amd_xgpu
                *)adev-&gt;priv_data;<br>
                &gt; +       struct amd_xgpu_csa *sa = NULL;<br>
                &gt; +<br>
                &gt; +       if (!xgpu)<br>
                &gt; +               return;<br>
                &gt; +<br>
                &gt; +       sa = &amp;xgpu-&gt;sa;<br>
                &gt; +       xgpu_vm_unmap_csa(adev, vm, sa);<br>
                &gt; +}<br>
                &gt; --<br>
                &gt; 2.7.4<br>
                &gt;<br>
                &gt; _______________________________________________<br>
                &gt; amd-gfx mailing list<br>
                &gt; <a moz-do-not-send="true"
                  href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
                &gt; <a moz-do-not-send="true"
                  href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a><o:p></o:p></span></p>
          </div>
        </div>
      </div>
      <br>
      <fieldset class="mimeAttachmentHeader"></fieldset>
      <br>
      <pre wrap="">_______________________________________________
amd-gfx mailing list
<a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>
<a class="moz-txt-link-freetext" href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a>
</pre>
    </blockquote>
    <p><br>
    </p>
  </body>
</html>

--------------F23A1F81410AA5D80B4D0444--

--===============1290484405==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1290484405==--
