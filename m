From: Oded Gabbay <oded.gabbay-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] drm/radeon: deprecate and remove KFD interface
Date: Wed, 1 Nov 2017 10:31:51 +0200
Message-ID: <CAFCwf11GZkKNEnR=_+NZcDxoujAXcj4GJ=JLNzNfShJBx97vDg@mail.gmail.com>
References: <1509369381-16062-1-git-send-email-deathsimple@vodafone.de>
 <CAFCwf10G5014KcMG+_Zz9_RaUh+JH8cMdgHD_accH40ZciFydw@mail.gmail.com>
 <56f7a613-7815-6916-2739-a9cb935a2018@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0148892310=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <56f7a613-7815-6916-2739-a9cb935a2018-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>, amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0148892310==
Content-Type: multipart/alternative; boundary="001a114551d8dab128055ce7b5a9"

--001a114551d8dab128055ce7b5a9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

ok, taken to -next.

On Tue, Oct 31, 2017 at 4:56 PM, Christian K=C3=B6nig <
ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:

> Am 31.10.2017 um 11:44 schrieb Oded Gabbay:
>
>> Don't have any strong objection, but I just want to ask if current
>> users can just move to using amdgpu on KV and their current usermode
>> stack will work as usual.
>>
>
> Yes, I think so.
>
> btw, are there any "current users" that you are aware of ?
>>
>
> Not the slightest idea, but from Felix comments at least the current user
> mode stack + old kernel won't work.
>
> Regards,
> Christian.
>
>
>
>>
>> On Mon, Oct 30, 2017 at 3:16 PM, Christian K=C3=B6nig
>> <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org> wrote:
>>
>>> From: Christian K=C3=B6nig <christian.koenig-5C7GfCeVMHo@public.gmane.org>
>>>
>>> To quote Felix: "For testing KV with current user mode stack, please us=
e
>>> amdgpu. I don't expect this to work with radeon and I'm not planning to
>>> spend
>>> any effort on making radeon work with a current user mode stack."
>>>
>>> Only compile tested, but should be straight forward.
>>>
>>> Signed-off-by: Christian K=C3=B6nig <christian.koenig-5C7GfCeVMHo@public.gmane.org>
>>> ---
>>>   drivers/gpu/drm/amd/amdkfd/Kconfig  |   2 +-
>>>   drivers/gpu/drm/radeon/Makefile     |   3 +-
>>>   drivers/gpu/drm/radeon/cik.c        |  14 +-
>>>   drivers/gpu/drm/radeon/cikd.h       |   2 -
>>>   drivers/gpu/drm/radeon/radeon.h     |   3 -
>>>   drivers/gpu/drm/radeon/radeon_drv.c |  10 -
>>>   drivers/gpu/drm/radeon/radeon_kfd.c | 901
>>> ------------------------------------
>>>   drivers/gpu/drm/radeon/radeon_kfd.h |  47 --
>>>   drivers/gpu/drm/radeon/radeon_kms.c |   7 -
>>>   9 files changed, 4 insertions(+), 985 deletions(-)
>>>   delete mode 100644 drivers/gpu/drm/radeon/radeon_kfd.c
>>>   delete mode 100644 drivers/gpu/drm/radeon/radeon_kfd.h
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/Kconfig
>>> b/drivers/gpu/drm/amd/amdkfd/Kconfig
>>> index e13c67c..bc5a294 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/Kconfig
>>> +++ b/drivers/gpu/drm/amd/amdkfd/Kconfig
>>> @@ -4,6 +4,6 @@
>>>
>>>   config HSA_AMD
>>>          tristate "HSA kernel driver for AMD GPU devices"
>>> -       depends on (DRM_RADEON || DRM_AMDGPU) && AMD_IOMMU_V2 && X86_64
>>> +       depends on DRM_AMDGPU && AMD_IOMMU_V2 && X86_64
>>>          help
>>>            Enable this if you want to use HSA features on AMD GPU
>>> devices.
>>> diff --git a/drivers/gpu/drm/radeon/Makefile
>>> b/drivers/gpu/drm/radeon/Makefile
>>> index be16c63..cf3e598 100644
>>> --- a/drivers/gpu/drm/radeon/Makefile
>>> +++ b/drivers/gpu/drm/radeon/Makefile
>>> @@ -102,8 +102,7 @@ radeon-y +=3D \
>>>   radeon-y +=3D \
>>>          radeon_vce.o \
>>>          vce_v1_0.o \
>>> -       vce_v2_0.o \
>>> -       radeon_kfd.o
>>> +       vce_v2_0.o
>>>
>>>   radeon-$(CONFIG_VGA_SWITCHEROO) +=3D radeon_atpx_handler.o
>>>   radeon-$(CONFIG_ACPI) +=3D radeon_acpi.o
>>> diff --git a/drivers/gpu/drm/radeon/cik.c b/drivers/gpu/drm/radeon/cik.=
c
>>> index 3cb6c55..898f9a0 100644
>>> --- a/drivers/gpu/drm/radeon/cik.c
>>> +++ b/drivers/gpu/drm/radeon/cik.c
>>> @@ -33,7 +33,6 @@
>>>   #include "cik_blit_shaders.h"
>>>   #include "radeon_ucode.h"
>>>   #include "clearstate_ci.h"
>>> -#include "radeon_kfd.h"
>>>
>>>   #define SH_MEM_CONFIG_GFX_DEFAULT \
>>>          ALIGNMENT_MODE(SH_MEM_ALIGNMENT_MODE_UNALIGNED)
>>> @@ -5684,10 +5683,9 @@ int cik_vm_init(struct radeon_device *rdev)
>>>          /*
>>>           * number of VMs
>>>           * VMID 0 is reserved for System
>>> -        * radeon graphics/compute will use VMIDs 1-7
>>> -        * amdkfd will use VMIDs 8-15
>>> +        * radeon graphics/compute will use VMIDs 1-15
>>>           */
>>> -       rdev->vm_manager.nvm =3D RADEON_NUM_OF_VMIDS;
>>> +       rdev->vm_manager.nvm =3D 16;
>>>          /* base offset of vram pages */
>>>          if (rdev->flags & RADEON_IS_IGP) {
>>>                  u64 tmp =3D RREG32(MC_VM_FB_OFFSET);
>>> @@ -7589,9 +7587,6 @@ int cik_irq_process(struct radeon_device *rdev)
>>>                  /* wptr/rptr are in bytes! */
>>>                  ring_index =3D rptr / 4;
>>>
>>> -               radeon_kfd_interrupt(rdev,
>>> -                               (const void *)
>>> &rdev->ih.ring[ring_index]);
>>> -
>>>                  src_id =3D  le32_to_cpu(rdev->ih.ring[ring_index]) &
>>> 0xff;
>>>                  src_data =3D le32_to_cpu(rdev->ih.ring[ring_index + 1]=
)
>>> & 0xfffffff;
>>>                  ring_id =3D le32_to_cpu(rdev->ih.ring[ring_index + 2])=
 &
>>> 0xff;
>>> @@ -8486,10 +8481,6 @@ static int cik_startup(struct radeon_device *rde=
v)
>>>          if (r)
>>>                  return r;
>>>
>>> -       r =3D radeon_kfd_resume(rdev);
>>> -       if (r)
>>> -               return r;
>>> -
>>>          return 0;
>>>   }
>>>
>>> @@ -8538,7 +8529,6 @@ int cik_resume(struct radeon_device *rdev)
>>>    */
>>>   int cik_suspend(struct radeon_device *rdev)
>>>   {
>>> -       radeon_kfd_suspend(rdev);
>>>          radeon_pm_suspend(rdev);
>>>          radeon_audio_fini(rdev);
>>>          radeon_vm_manager_fini(rdev);
>>> diff --git a/drivers/gpu/drm/radeon/cikd.h
>>> b/drivers/gpu/drm/radeon/cikd.h
>>> index e210154..cda16fc 100644
>>> --- a/drivers/gpu/drm/radeon/cikd.h
>>> +++ b/drivers/gpu/drm/radeon/cikd.h
>>> @@ -30,8 +30,6 @@
>>>   #define CIK_RB_BITMAP_WIDTH_PER_SH     2
>>>   #define HAWAII_RB_BITMAP_WIDTH_PER_SH  4
>>>
>>> -#define RADEON_NUM_OF_VMIDS    8
>>> -
>>>   /* DIDT IND registers */
>>>   #define DIDT_SQ_CTRL0                                     0x0
>>>   #       define DIDT_CTRL_EN                               (1 << 0)
>>> diff --git a/drivers/gpu/drm/radeon/radeon.h
>>> b/drivers/gpu/drm/radeon/radeon.h
>>> index ec63bc5..d94741b 100644
>>> --- a/drivers/gpu/drm/radeon/radeon.h
>>> +++ b/drivers/gpu/drm/radeon/radeon.h
>>> @@ -2456,9 +2456,6 @@ struct radeon_device {
>>>          u64 vram_pin_size;
>>>          u64 gart_pin_size;
>>>
>>> -       /* amdkfd interface */
>>> -       struct kfd_dev          *kfd;
>>> -
>>>          struct mutex    mn_lock;
>>>          DECLARE_HASHTABLE(mn_hash, 7);
>>>   };
>>> diff --git a/drivers/gpu/drm/radeon/radeon_drv.c
>>> b/drivers/gpu/drm/radeon/radeon_drv.c
>>> index f4becad..31dd04f 100644
>>> --- a/drivers/gpu/drm/radeon/radeon_drv.c
>>> +++ b/drivers/gpu/drm/radeon/radeon_drv.c
>>> @@ -43,7 +43,6 @@
>>>   #include <drm/drm_fb_helper.h>
>>>
>>>   #include <drm/drm_crtc_helper.h>
>>> -#include "radeon_kfd.h"
>>>
>>>   /*
>>>    * KMS wrapper.
>>> @@ -338,14 +337,6 @@ static int radeon_pci_probe(struct pci_dev *pdev,
>>>   {
>>>          int ret;
>>>
>>> -       /*
>>> -        * Initialize amdkfd before starting radeon. If it was not
>>> loaded yet,
>>> -        * defer radeon probing
>>> -        */
>>> -       ret =3D radeon_kfd_init();
>>> -       if (ret =3D=3D -EPROBE_DEFER)
>>> -               return ret;
>>> -
>>>          if (vga_switcheroo_client_probe_defer(pdev))
>>>                  return -EPROBE_DEFER;
>>>
>>> @@ -645,7 +636,6 @@ static int __init radeon_init(void)
>>>
>>>   static void __exit radeon_exit(void)
>>>   {
>>> -       radeon_kfd_fini();
>>>          pci_unregister_driver(pdriver);
>>>          radeon_unregister_atpx_handler();
>>>   }
>>> diff --git a/drivers/gpu/drm/radeon/radeon_kfd.c
>>> b/drivers/gpu/drm/radeon/radeon_kfd.c
>>> deleted file mode 100644
>>> index 385b4d7..0000000
>>> --- a/drivers/gpu/drm/radeon/radeon_kfd.c
>>> +++ /dev/null
>>> @@ -1,901 +0,0 @@
>>> -/*
>>> - * Copyright 2014 Advanced Micro Devices, Inc.
>>> - *
>>> - * Permission is hereby granted, free of charge, to any person
>>> obtaining a
>>> - * copy of this software and associated documentation files (the
>>> "Software"),
>>> - * to deal in the Software without restriction, including without
>>> limitation
>>> - * the rights to use, copy, modify, merge, publish, distribute,
>>> sublicense,
>>> - * and/or sell copies of the Software, and to permit persons to whom t=
he
>>> - * Software is furnished to do so, subject to the following conditions=
:
>>> - *
>>> - * The above copyright notice and this permission notice shall be
>>> included in
>>> - * all copies or substantial portions of the Software.
>>> - *
>>> - * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
>>> EXPRESS OR
>>> - * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
>>> MERCHANTABILITY,
>>> - * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT
>>> SHALL
>>> - * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM,
>>> DAMAGES OR
>>> - * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWIS=
E,
>>> - * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE =
OR
>>> - * OTHER DEALINGS IN THE SOFTWARE.
>>> - */
>>> -
>>> -#include <linux/module.h>
>>> -#include <linux/fdtable.h>
>>> -#include <linux/uaccess.h>
>>> -#include <drm/drmP.h>
>>> -#include "radeon.h"
>>> -#include "cikd.h"
>>> -#include "cik_reg.h"
>>> -#include "radeon_kfd.h"
>>> -#include "radeon_ucode.h"
>>> -#include <linux/firmware.h>
>>> -#include "cik_structs.h"
>>> -
>>> -#define CIK_PIPE_PER_MEC       (4)
>>> -
>>> -static const uint32_t watchRegs[MAX_WATCH_ADDRESSES *
>>> ADDRESS_WATCH_REG_MAX] =3D {
>>> -       TCP_WATCH0_ADDR_H, TCP_WATCH0_ADDR_L, TCP_WATCH0_CNTL,
>>> -       TCP_WATCH1_ADDR_H, TCP_WATCH1_ADDR_L, TCP_WATCH1_CNTL,
>>> -       TCP_WATCH2_ADDR_H, TCP_WATCH2_ADDR_L, TCP_WATCH2_CNTL,
>>> -       TCP_WATCH3_ADDR_H, TCP_WATCH3_ADDR_L, TCP_WATCH3_CNTL
>>> -};
>>> -
>>> -struct kgd_mem {
>>> -       struct radeon_bo *bo;
>>> -       uint64_t gpu_addr;
>>> -       void *cpu_ptr;
>>> -};
>>> -
>>> -
>>> -static int alloc_gtt_mem(struct kgd_dev *kgd, size_t size,
>>> -                       void **mem_obj, uint64_t *gpu_addr,
>>> -                       void **cpu_ptr);
>>> -
>>> -static void free_gtt_mem(struct kgd_dev *kgd, void *mem_obj);
>>> -
>>> -static uint64_t get_vmem_size(struct kgd_dev *kgd);
>>> -static uint64_t get_gpu_clock_counter(struct kgd_dev *kgd);
>>> -
>>> -static uint32_t get_max_engine_clock_in_mhz(struct kgd_dev *kgd);
>>> -
>>> -static int alloc_pasid(unsigned int bits);
>>> -static void free_pasid(unsigned int pasid);
>>> -
>>> -static uint16_t get_fw_version(struct kgd_dev *kgd, enum
>>> kgd_engine_type type);
>>> -
>>> -/*
>>> - * Register access functions
>>> - */
>>> -
>>> -static void kgd_program_sh_mem_settings(struct kgd_dev *kgd, uint32_t
>>> vmid,
>>> -               uint32_t sh_mem_config, uint32_t sh_mem_ape1_base,
>>> -               uint32_t sh_mem_ape1_limit, uint32_t sh_mem_bases);
>>> -
>>> -static int kgd_set_pasid_vmid_mapping(struct kgd_dev *kgd, unsigned
>>> int pasid,
>>> -                                       unsigned int vmid);
>>> -
>>> -static int kgd_init_pipeline(struct kgd_dev *kgd, uint32_t pipe_id,
>>> -                               uint32_t hpd_size, uint64_t
>>> hpd_gpu_addr);
>>> -static int kgd_init_interrupts(struct kgd_dev *kgd, uint32_t pipe_id);
>>> -static int kgd_hqd_load(struct kgd_dev *kgd, void *mqd, uint32_t
>>> pipe_id,
>>> -                       uint32_t queue_id, uint32_t __user *wptr,
>>> -                       uint32_t wptr_shift, uint32_t wptr_mask,
>>> -                       struct mm_struct *mm);
>>> -static int kgd_hqd_sdma_load(struct kgd_dev *kgd, void *mqd);
>>> -static bool kgd_hqd_is_occupied(struct kgd_dev *kgd, uint64_t
>>> queue_address,
>>> -                               uint32_t pipe_id, uint32_t queue_id);
>>> -
>>> -static int kgd_hqd_destroy(struct kgd_dev *kgd, void *mqd, uint32_t
>>> reset_type,
>>> -                               unsigned int timeout, uint32_t pipe_id,
>>> -                               uint32_t queue_id);
>>> -static bool kgd_hqd_sdma_is_occupied(struct kgd_dev *kgd, void *mqd);
>>> -static int kgd_hqd_sdma_destroy(struct kgd_dev *kgd, void *mqd,
>>> -                               unsigned int timeout);
>>> -static int kgd_address_watch_disable(struct kgd_dev *kgd);
>>> -static int kgd_address_watch_execute(struct kgd_dev *kgd,
>>> -                                       unsigned int watch_point_id,
>>> -                                       uint32_t cntl_val,
>>> -                                       uint32_t addr_hi,
>>> -                                       uint32_t addr_lo);
>>> -static int kgd_wave_control_execute(struct kgd_dev *kgd,
>>> -                                       uint32_t gfx_index_val,
>>> -                                       uint32_t sq_cmd);
>>> -static uint32_t kgd_address_watch_get_offset(struct kgd_dev *kgd,
>>> -                                       unsigned int watch_point_id,
>>> -                                       unsigned int reg_offset);
>>> -
>>> -static bool get_atc_vmid_pasid_mapping_valid(struct kgd_dev *kgd,
>>> uint8_t vmid);
>>> -static uint16_t get_atc_vmid_pasid_mapping_pasid(struct kgd_dev *kgd,
>>> -                                                       uint8_t vmid);
>>> -static void write_vmid_invalidate_request(struct kgd_dev *kgd, uint8_t
>>> vmid);
>>> -
>>> -static const struct kfd2kgd_calls kfd2kgd =3D {
>>> -       .init_gtt_mem_allocation =3D alloc_gtt_mem,
>>> -       .free_gtt_mem =3D free_gtt_mem,
>>> -       .get_vmem_size =3D get_vmem_size,
>>> -       .get_gpu_clock_counter =3D get_gpu_clock_counter,
>>> -       .get_max_engine_clock_in_mhz =3D get_max_engine_clock_in_mhz,
>>> -       .alloc_pasid =3D alloc_pasid,
>>> -       .free_pasid =3D free_pasid,
>>> -       .program_sh_mem_settings =3D kgd_program_sh_mem_settings,
>>> -       .set_pasid_vmid_mapping =3D kgd_set_pasid_vmid_mapping,
>>> -       .init_pipeline =3D kgd_init_pipeline,
>>> -       .init_interrupts =3D kgd_init_interrupts,
>>> -       .hqd_load =3D kgd_hqd_load,
>>> -       .hqd_sdma_load =3D kgd_hqd_sdma_load,
>>> -       .hqd_is_occupied =3D kgd_hqd_is_occupied,
>>> -       .hqd_sdma_is_occupied =3D kgd_hqd_sdma_is_occupied,
>>> -       .hqd_destroy =3D kgd_hqd_destroy,
>>> -       .hqd_sdma_destroy =3D kgd_hqd_sdma_destroy,
>>> -       .address_watch_disable =3D kgd_address_watch_disable,
>>> -       .address_watch_execute =3D kgd_address_watch_execute,
>>> -       .wave_control_execute =3D kgd_wave_control_execute,
>>> -       .address_watch_get_offset =3D kgd_address_watch_get_offset,
>>> -       .get_atc_vmid_pasid_mapping_pasid =3D
>>> get_atc_vmid_pasid_mapping_pasid,
>>> -       .get_atc_vmid_pasid_mapping_valid =3D
>>> get_atc_vmid_pasid_mapping_valid,
>>> -       .write_vmid_invalidate_request =3D write_vmid_invalidate_reques=
t,
>>> -       .get_fw_version =3D get_fw_version
>>> -};
>>> -
>>> -static const struct kgd2kfd_calls *kgd2kfd;
>>> -
>>> -int radeon_kfd_init(void)
>>> -{
>>> -       int ret;
>>> -
>>> -#if defined(CONFIG_HSA_AMD_MODULE)
>>> -       int (*kgd2kfd_init_p)(unsigned, const struct kgd2kfd_calls**);
>>> -
>>> -       kgd2kfd_init_p =3D symbol_request(kgd2kfd_init);
>>> -
>>> -       if (kgd2kfd_init_p =3D=3D NULL)
>>> -               return -ENOENT;
>>> -
>>> -       ret =3D kgd2kfd_init_p(KFD_INTERFACE_VERSION, &kgd2kfd);
>>> -       if (ret) {
>>> -               symbol_put(kgd2kfd_init);
>>> -               kgd2kfd =3D NULL;
>>> -       }
>>> -
>>> -#elif defined(CONFIG_HSA_AMD)
>>> -       ret =3D kgd2kfd_init(KFD_INTERFACE_VERSION, &kgd2kfd);
>>> -       if (ret)
>>> -               kgd2kfd =3D NULL;
>>> -
>>> -#else
>>> -       ret =3D -ENOENT;
>>> -#endif
>>> -
>>> -       return ret;
>>> -}
>>> -
>>> -void radeon_kfd_fini(void)
>>> -{
>>> -       if (kgd2kfd) {
>>> -               kgd2kfd->exit();
>>> -               symbol_put(kgd2kfd_init);
>>> -       }
>>> -}
>>> -
>>> -void radeon_kfd_device_probe(struct radeon_device *rdev)
>>> -{
>>> -       if (kgd2kfd)
>>> -               rdev->kfd =3D kgd2kfd->probe((struct kgd_dev *)rdev,
>>> -                       rdev->pdev, &kfd2kgd);
>>> -}
>>> -
>>> -void radeon_kfd_device_init(struct radeon_device *rdev)
>>> -{
>>> -       int i, queue, pipe, mec;
>>> -
>>> -       if (rdev->kfd) {
>>> -               struct kgd2kfd_shared_resources gpu_resources =3D {
>>> -                       .compute_vmid_bitmap =3D 0xFF00,
>>> -                       .num_pipe_per_mec =3D 4,
>>> -                       .num_queue_per_pipe =3D 8
>>> -               };
>>> -
>>> -               bitmap_zero(gpu_resources.queue_bitmap, KGD_MAX_QUEUES)=
;
>>> -
>>> -               for (i =3D 0; i < KGD_MAX_QUEUES; ++i) {
>>> -                       queue =3D i % gpu_resources.num_queue_per_pipe;
>>> -                       pipe =3D (i / gpu_resources.num_queue_per_pipe)
>>> -                               % gpu_resources.num_pipe_per_mec;
>>> -                       mec =3D (i / gpu_resources.num_queue_per_pipe)
>>> -                               / gpu_resources.num_pipe_per_mec;
>>> -
>>> -                       if (mec =3D=3D 0 && pipe > 0)
>>> -                               set_bit(i, gpu_resources.queue_bitmap);
>>> -               }
>>> -
>>> -               radeon_doorbell_get_kfd_info(rdev,
>>> -                               &gpu_resources.doorbell_physi
>>> cal_address,
>>> -                               &gpu_resources.doorbell_aperture_size,
>>> -                               &gpu_resources.doorbell_start_offset);
>>> -
>>> -               kgd2kfd->device_init(rdev->kfd, &gpu_resources);
>>> -       }
>>> -}
>>> -
>>> -void radeon_kfd_device_fini(struct radeon_device *rdev)
>>> -{
>>> -       if (rdev->kfd) {
>>> -               kgd2kfd->device_exit(rdev->kfd);
>>> -               rdev->kfd =3D NULL;
>>> -       }
>>> -}
>>> -
>>> -void radeon_kfd_interrupt(struct radeon_device *rdev, const void
>>> *ih_ring_entry)
>>> -{
>>> -       if (rdev->kfd)
>>> -               kgd2kfd->interrupt(rdev->kfd, ih_ring_entry);
>>> -}
>>> -
>>> -void radeon_kfd_suspend(struct radeon_device *rdev)
>>> -{
>>> -       if (rdev->kfd)
>>> -               kgd2kfd->suspend(rdev->kfd);
>>> -}
>>> -
>>> -int radeon_kfd_resume(struct radeon_device *rdev)
>>> -{
>>> -       int r =3D 0;
>>> -
>>> -       if (rdev->kfd)
>>> -               r =3D kgd2kfd->resume(rdev->kfd);
>>> -
>>> -       return r;
>>> -}
>>> -
>>> -static int alloc_gtt_mem(struct kgd_dev *kgd, size_t size,
>>> -                       void **mem_obj, uint64_t *gpu_addr,
>>> -                       void **cpu_ptr)
>>> -{
>>> -       struct radeon_device *rdev =3D (struct radeon_device *)kgd;
>>> -       struct kgd_mem **mem =3D (struct kgd_mem **) mem_obj;
>>> -       int r;
>>> -
>>> -       BUG_ON(kgd =3D=3D NULL);
>>> -       BUG_ON(gpu_addr =3D=3D NULL);
>>> -       BUG_ON(cpu_ptr =3D=3D NULL);
>>> -
>>> -       *mem =3D kmalloc(sizeof(struct kgd_mem), GFP_KERNEL);
>>> -       if ((*mem) =3D=3D NULL)
>>> -               return -ENOMEM;
>>> -
>>> -       r =3D radeon_bo_create(rdev, size, PAGE_SIZE, true,
>>> RADEON_GEM_DOMAIN_GTT,
>>> -                               RADEON_GEM_GTT_WC, NULL, NULL,
>>> &(*mem)->bo);
>>> -       if (r) {
>>> -               dev_err(rdev->dev,
>>> -                       "failed to allocate BO for amdkfd (%d)\n", r);
>>> -               return r;
>>> -       }
>>> -
>>> -       /* map the buffer */
>>> -       r =3D radeon_bo_reserve((*mem)->bo, true);
>>> -       if (r) {
>>> -               dev_err(rdev->dev, "(%d) failed to reserve bo for
>>> amdkfd\n", r);
>>> -               goto allocate_mem_reserve_bo_failed;
>>> -       }
>>> -
>>> -       r =3D radeon_bo_pin((*mem)->bo, RADEON_GEM_DOMAIN_GTT,
>>> -                               &(*mem)->gpu_addr);
>>> -       if (r) {
>>> -               dev_err(rdev->dev, "(%d) failed to pin bo for amdkfd\n"=
,
>>> r);
>>> -               goto allocate_mem_pin_bo_failed;
>>> -       }
>>> -       *gpu_addr =3D (*mem)->gpu_addr;
>>> -
>>> -       r =3D radeon_bo_kmap((*mem)->bo, &(*mem)->cpu_ptr);
>>> -       if (r) {
>>> -               dev_err(rdev->dev,
>>> -                       "(%d) failed to map bo to kernel for amdkfd\n",
>>> r);
>>> -               goto allocate_mem_kmap_bo_failed;
>>> -       }
>>> -       *cpu_ptr =3D (*mem)->cpu_ptr;
>>> -
>>> -       radeon_bo_unreserve((*mem)->bo);
>>> -
>>> -       return 0;
>>> -
>>> -allocate_mem_kmap_bo_failed:
>>> -       radeon_bo_unpin((*mem)->bo);
>>> -allocate_mem_pin_bo_failed:
>>> -       radeon_bo_unreserve((*mem)->bo);
>>> -allocate_mem_reserve_bo_failed:
>>> -       radeon_bo_unref(&(*mem)->bo);
>>> -
>>> -       return r;
>>> -}
>>> -
>>> -static void free_gtt_mem(struct kgd_dev *kgd, void *mem_obj)
>>> -{
>>> -       struct kgd_mem *mem =3D (struct kgd_mem *) mem_obj;
>>> -
>>> -       BUG_ON(mem =3D=3D NULL);
>>> -
>>> -       radeon_bo_reserve(mem->bo, true);
>>> -       radeon_bo_kunmap(mem->bo);
>>> -       radeon_bo_unpin(mem->bo);
>>> -       radeon_bo_unreserve(mem->bo);
>>> -       radeon_bo_unref(&(mem->bo));
>>> -       kfree(mem);
>>> -}
>>> -
>>> -static uint64_t get_vmem_size(struct kgd_dev *kgd)
>>> -{
>>> -       struct radeon_device *rdev =3D (struct radeon_device *)kgd;
>>> -
>>> -       BUG_ON(kgd =3D=3D NULL);
>>> -
>>> -       return rdev->mc.real_vram_size;
>>> -}
>>> -
>>> -static uint64_t get_gpu_clock_counter(struct kgd_dev *kgd)
>>> -{
>>> -       struct radeon_device *rdev =3D (struct radeon_device *)kgd;
>>> -
>>> -       return rdev->asic->get_gpu_clock_counter(rdev);
>>> -}
>>> -
>>> -static uint32_t get_max_engine_clock_in_mhz(struct kgd_dev *kgd)
>>> -{
>>> -       struct radeon_device *rdev =3D (struct radeon_device *)kgd;
>>> -
>>> -       /* The sclk is in quantas of 10kHz */
>>> -       return rdev->pm.dpm.dyn_state.max_clock_voltage_on_ac.sclk /
>>> 100;
>>> -}
>>> -
>>> -/*
>>> - * PASID manager
>>> - */
>>> -static DEFINE_IDA(pasid_ida);
>>> -
>>> -static int alloc_pasid(unsigned int bits)
>>> -{
>>> -       int pasid =3D -EINVAL;
>>> -
>>> -       for (bits =3D min(bits, 31U); bits > 0; bits--) {
>>> -               pasid =3D ida_simple_get(&pasid_ida,
>>> -                                      1U << (bits - 1), 1U << bits,
>>> -                                      GFP_KERNEL);
>>> -               if (pasid !=3D -ENOSPC)
>>> -                       break;
>>> -       }
>>> -
>>> -       return pasid;
>>> -}
>>> -
>>> -static void free_pasid(unsigned int pasid)
>>> -{
>>> -       ida_simple_remove(&pasid_ida, pasid);
>>> -}
>>> -
>>> -static inline struct radeon_device *get_radeon_device(struct kgd_dev
>>> *kgd)
>>> -{
>>> -       return (struct radeon_device *)kgd;
>>> -}
>>> -
>>> -static void write_register(struct kgd_dev *kgd, uint32_t offset,
>>> uint32_t value)
>>> -{
>>> -       struct radeon_device *rdev =3D get_radeon_device(kgd);
>>> -
>>> -       writel(value, (void __iomem *)(rdev->rmmio + offset));
>>> -}
>>> -
>>> -static uint32_t read_register(struct kgd_dev *kgd, uint32_t offset)
>>> -{
>>> -       struct radeon_device *rdev =3D get_radeon_device(kgd);
>>> -
>>> -       return readl((void __iomem *)(rdev->rmmio + offset));
>>> -}
>>> -
>>> -static void lock_srbm(struct kgd_dev *kgd, uint32_t mec, uint32_t pipe=
,
>>> -                       uint32_t queue, uint32_t vmid)
>>> -{
>>> -       struct radeon_device *rdev =3D get_radeon_device(kgd);
>>> -       uint32_t value =3D PIPEID(pipe) | MEID(mec) | VMID(vmid) |
>>> QUEUEID(queue);
>>> -
>>> -       mutex_lock(&rdev->srbm_mutex);
>>> -       write_register(kgd, SRBM_GFX_CNTL, value);
>>> -}
>>> -
>>> -static void unlock_srbm(struct kgd_dev *kgd)
>>> -{
>>> -       struct radeon_device *rdev =3D get_radeon_device(kgd);
>>> -
>>> -       write_register(kgd, SRBM_GFX_CNTL, 0);
>>> -       mutex_unlock(&rdev->srbm_mutex);
>>> -}
>>> -
>>> -static void acquire_queue(struct kgd_dev *kgd, uint32_t pipe_id,
>>> -                               uint32_t queue_id)
>>> -{
>>> -       uint32_t mec =3D (++pipe_id / CIK_PIPE_PER_MEC) + 1;
>>> -       uint32_t pipe =3D (pipe_id % CIK_PIPE_PER_MEC);
>>> -
>>> -       lock_srbm(kgd, mec, pipe, queue_id, 0);
>>> -}
>>> -
>>> -static void release_queue(struct kgd_dev *kgd)
>>> -{
>>> -       unlock_srbm(kgd);
>>> -}
>>> -
>>> -static void kgd_program_sh_mem_settings(struct kgd_dev *kgd, uint32_t
>>> vmid,
>>> -                                       uint32_t sh_mem_config,
>>> -                                       uint32_t sh_mem_ape1_base,
>>> -                                       uint32_t sh_mem_ape1_limit,
>>> -                                       uint32_t sh_mem_bases)
>>> -{
>>> -       lock_srbm(kgd, 0, 0, 0, vmid);
>>> -
>>> -       write_register(kgd, SH_MEM_CONFIG, sh_mem_config);
>>> -       write_register(kgd, SH_MEM_APE1_BASE, sh_mem_ape1_base);
>>> -       write_register(kgd, SH_MEM_APE1_LIMIT, sh_mem_ape1_limit);
>>> -       write_register(kgd, SH_MEM_BASES, sh_mem_bases);
>>> -
>>> -       unlock_srbm(kgd);
>>> -}
>>> -
>>> -static int kgd_set_pasid_vmid_mapping(struct kgd_dev *kgd, unsigned
>>> int pasid,
>>> -                                       unsigned int vmid)
>>> -{
>>> -       /*
>>> -        * We have to assume that there is no outstanding mapping.
>>> -        * The ATC_VMID_PASID_MAPPING_UPDATE_STATUS bit could be 0
>>> -        * because a mapping is in progress or because a mapping
>>> finished and
>>> -        * the SW cleared it.
>>> -        * So the protocol is to always wait & clear.
>>> -        */
>>> -       uint32_t pasid_mapping =3D (pasid =3D=3D 0) ? 0 : (uint32_t)pas=
id |
>>> -                                       ATC_VMID_PASID_MAPPING_VALID_
>>> MASK;
>>> -
>>> -       write_register(kgd, ATC_VMID0_PASID_MAPPING +
>>> vmid*sizeof(uint32_t),
>>> -                       pasid_mapping);
>>> -
>>> -       while (!(read_register(kgd, ATC_VMID_PASID_MAPPING_UPDATE_STATU=
S)
>>> &
>>> -                                                               (1U <<
>>> vmid)))
>>> -               cpu_relax();
>>> -       write_register(kgd, ATC_VMID_PASID_MAPPING_UPDATE_STATUS, 1U <<
>>> vmid);
>>> -
>>> -       /* Mapping vmid to pasid also for IH block */
>>> -       write_register(kgd, IH_VMID_0_LUT + vmid * sizeof(uint32_t),
>>> -                       pasid_mapping);
>>> -
>>> -       return 0;
>>> -}
>>> -
>>> -static int kgd_init_pipeline(struct kgd_dev *kgd, uint32_t pipe_id,
>>> -                               uint32_t hpd_size, uint64_t hpd_gpu_add=
r)
>>> -{
>>> -       /* nothing to do here */
>>> -       return 0;
>>> -}
>>> -
>>> -static int kgd_init_interrupts(struct kgd_dev *kgd, uint32_t pipe_id)
>>> -{
>>> -       uint32_t mec;
>>> -       uint32_t pipe;
>>> -
>>> -       mec =3D (pipe_id / CIK_PIPE_PER_MEC) + 1;
>>> -       pipe =3D (pipe_id % CIK_PIPE_PER_MEC);
>>> -
>>> -       lock_srbm(kgd, mec, pipe, 0, 0);
>>> -
>>> -       write_register(kgd, CPC_INT_CNTL,
>>> -                       TIME_STAMP_INT_ENABLE | OPCODE_ERROR_INT_ENABLE=
);
>>> -
>>> -       unlock_srbm(kgd);
>>> -
>>> -       return 0;
>>> -}
>>> -
>>> -static inline uint32_t get_sdma_base_addr(struct cik_sdma_rlc_register=
s
>>> *m)
>>> -{
>>> -       uint32_t retval;
>>> -
>>> -       retval =3D m->sdma_engine_id * SDMA1_REGISTER_OFFSET +
>>> -                       m->sdma_queue_id * KFD_CIK_SDMA_QUEUE_OFFSET;
>>> -
>>> -       pr_debug("kfd: sdma base address: 0x%x\n", retval);
>>> -
>>> -       return retval;
>>> -}
>>> -
>>> -static inline struct cik_mqd *get_mqd(void *mqd)
>>> -{
>>> -       return (struct cik_mqd *)mqd;
>>> -}
>>> -
>>> -static inline struct cik_sdma_rlc_registers *get_sdma_mqd(void *mqd)
>>> -{
>>> -       return (struct cik_sdma_rlc_registers *)mqd;
>>> -}
>>> -
>>> -static int kgd_hqd_load(struct kgd_dev *kgd, void *mqd, uint32_t
>>> pipe_id,
>>> -                       uint32_t queue_id, uint32_t __user *wptr,
>>> -                       uint32_t wptr_shift, uint32_t wptr_mask,
>>> -                       struct mm_struct *mm)
>>> -{
>>> -       uint32_t wptr_shadow, is_wptr_shadow_valid;
>>> -       struct cik_mqd *m;
>>> -
>>> -       m =3D get_mqd(mqd);
>>> -
>>> -       is_wptr_shadow_valid =3D !get_user(wptr_shadow, wptr);
>>> -
>>> -       acquire_queue(kgd, pipe_id, queue_id);
>>> -       write_register(kgd, CP_MQD_BASE_ADDR, m->cp_mqd_base_addr_lo);
>>> -       write_register(kgd, CP_MQD_BASE_ADDR_HI, m->cp_mqd_base_addr_hi=
);
>>> -       write_register(kgd, CP_MQD_CONTROL, m->cp_mqd_control);
>>> -
>>> -       write_register(kgd, CP_HQD_PQ_BASE, m->cp_hqd_pq_base_lo);
>>> -       write_register(kgd, CP_HQD_PQ_BASE_HI, m->cp_hqd_pq_base_hi);
>>> -       write_register(kgd, CP_HQD_PQ_CONTROL, m->cp_hqd_pq_control);
>>> -
>>> -       write_register(kgd, CP_HQD_IB_CONTROL, m->cp_hqd_ib_control);
>>> -       write_register(kgd, CP_HQD_IB_BASE_ADDR,
>>> m->cp_hqd_ib_base_addr_lo);
>>> -       write_register(kgd, CP_HQD_IB_BASE_ADDR_HI,
>>> m->cp_hqd_ib_base_addr_hi);
>>> -
>>> -       write_register(kgd, CP_HQD_IB_RPTR, m->cp_hqd_ib_rptr);
>>> -
>>> -       write_register(kgd, CP_HQD_PERSISTENT_STATE,
>>> -                       m->cp_hqd_persistent_state);
>>> -       write_register(kgd, CP_HQD_SEMA_CMD, m->cp_hqd_sema_cmd);
>>> -       write_register(kgd, CP_HQD_MSG_TYPE, m->cp_hqd_msg_type);
>>> -
>>> -       write_register(kgd, CP_HQD_ATOMIC0_PREOP_LO,
>>> -                       m->cp_hqd_atomic0_preop_lo);
>>> -
>>> -       write_register(kgd, CP_HQD_ATOMIC0_PREOP_HI,
>>> -                       m->cp_hqd_atomic0_preop_hi);
>>> -
>>> -       write_register(kgd, CP_HQD_ATOMIC1_PREOP_LO,
>>> -                       m->cp_hqd_atomic1_preop_lo);
>>> -
>>> -       write_register(kgd, CP_HQD_ATOMIC1_PREOP_HI,
>>> -                       m->cp_hqd_atomic1_preop_hi);
>>> -
>>> -       write_register(kgd, CP_HQD_PQ_RPTR_REPORT_ADDR,
>>> -                       m->cp_hqd_pq_rptr_report_addr_lo);
>>> -
>>> -       write_register(kgd, CP_HQD_PQ_RPTR_REPORT_ADDR_HI,
>>> -                       m->cp_hqd_pq_rptr_report_addr_hi);
>>> -
>>> -       write_register(kgd, CP_HQD_PQ_RPTR, m->cp_hqd_pq_rptr);
>>> -
>>> -       write_register(kgd, CP_HQD_PQ_WPTR_POLL_ADDR,
>>> -                       m->cp_hqd_pq_wptr_poll_addr_lo);
>>> -
>>> -       write_register(kgd, CP_HQD_PQ_WPTR_POLL_ADDR_HI,
>>> -                       m->cp_hqd_pq_wptr_poll_addr_hi);
>>> -
>>> -       write_register(kgd, CP_HQD_PQ_DOORBELL_CONTROL,
>>> -                       m->cp_hqd_pq_doorbell_control);
>>> -
>>> -       write_register(kgd, CP_HQD_VMID, m->cp_hqd_vmid);
>>> -
>>> -       write_register(kgd, CP_HQD_QUANTUM, m->cp_hqd_quantum);
>>> -
>>> -       write_register(kgd, CP_HQD_PIPE_PRIORITY,
>>> m->cp_hqd_pipe_priority);
>>> -       write_register(kgd, CP_HQD_QUEUE_PRIORITY,
>>> m->cp_hqd_queue_priority);
>>> -
>>> -       write_register(kgd, CP_HQD_IQ_RPTR, m->cp_hqd_iq_rptr);
>>> -
>>> -       if (is_wptr_shadow_valid)
>>> -               write_register(kgd, CP_HQD_PQ_WPTR, wptr_shadow);
>>> -
>>> -       write_register(kgd, CP_HQD_ACTIVE, m->cp_hqd_active);
>>> -       release_queue(kgd);
>>> -
>>> -       return 0;
>>> -}
>>> -
>>> -static int kgd_hqd_sdma_load(struct kgd_dev *kgd, void *mqd)
>>> -{
>>> -       struct cik_sdma_rlc_registers *m;
>>> -       uint32_t sdma_base_addr;
>>> -
>>> -       m =3D get_sdma_mqd(mqd);
>>> -       sdma_base_addr =3D get_sdma_base_addr(m);
>>> -
>>> -       write_register(kgd,
>>> -                       sdma_base_addr + SDMA0_RLC0_VIRTUAL_ADDR,
>>> -                       m->sdma_rlc_virtual_addr);
>>> -
>>> -       write_register(kgd,
>>> -                       sdma_base_addr + SDMA0_RLC0_RB_BASE,
>>> -                       m->sdma_rlc_rb_base);
>>> -
>>> -       write_register(kgd,
>>> -                       sdma_base_addr + SDMA0_RLC0_RB_BASE_HI,
>>> -                       m->sdma_rlc_rb_base_hi);
>>> -
>>> -       write_register(kgd,
>>> -                       sdma_base_addr + SDMA0_RLC0_RB_RPTR_ADDR_LO,
>>> -                       m->sdma_rlc_rb_rptr_addr_lo);
>>> -
>>> -       write_register(kgd,
>>> -                       sdma_base_addr + SDMA0_RLC0_RB_RPTR_ADDR_HI,
>>> -                       m->sdma_rlc_rb_rptr_addr_hi);
>>> -
>>> -       write_register(kgd,
>>> -                       sdma_base_addr + SDMA0_RLC0_DOORBELL,
>>> -                       m->sdma_rlc_doorbell);
>>> -
>>> -       write_register(kgd,
>>> -                       sdma_base_addr + SDMA0_RLC0_RB_CNTL,
>>> -                       m->sdma_rlc_rb_cntl);
>>> -
>>> -       return 0;
>>> -}
>>> -
>>> -static bool kgd_hqd_is_occupied(struct kgd_dev *kgd, uint64_t
>>> queue_address,
>>> -                               uint32_t pipe_id, uint32_t queue_id)
>>> -{
>>> -       uint32_t act;
>>> -       bool retval =3D false;
>>> -       uint32_t low, high;
>>> -
>>> -       acquire_queue(kgd, pipe_id, queue_id);
>>> -       act =3D read_register(kgd, CP_HQD_ACTIVE);
>>> -       if (act) {
>>> -               low =3D lower_32_bits(queue_address >> 8);
>>> -               high =3D upper_32_bits(queue_address >> 8);
>>> -
>>> -               if (low =3D=3D read_register(kgd, CP_HQD_PQ_BASE) &&
>>> -                               high =3D=3D read_register(kgd,
>>> CP_HQD_PQ_BASE_HI))
>>> -                       retval =3D true;
>>> -       }
>>> -       release_queue(kgd);
>>> -       return retval;
>>> -}
>>> -
>>> -static bool kgd_hqd_sdma_is_occupied(struct kgd_dev *kgd, void *mqd)
>>> -{
>>> -       struct cik_sdma_rlc_registers *m;
>>> -       uint32_t sdma_base_addr;
>>> -       uint32_t sdma_rlc_rb_cntl;
>>> -
>>> -       m =3D get_sdma_mqd(mqd);
>>> -       sdma_base_addr =3D get_sdma_base_addr(m);
>>> -
>>> -       sdma_rlc_rb_cntl =3D read_register(kgd,
>>> -                                       sdma_base_addr +
>>> SDMA0_RLC0_RB_CNTL);
>>> -
>>> -       if (sdma_rlc_rb_cntl & SDMA_RB_ENABLE)
>>> -               return true;
>>> -
>>> -       return false;
>>> -}
>>> -
>>> -static int kgd_hqd_destroy(struct kgd_dev *kgd, void *mqd, uint32_t
>>> reset_type,
>>> -                               unsigned int timeout, uint32_t pipe_id,
>>> -                               uint32_t queue_id)
>>> -{
>>> -       uint32_t temp;
>>> -
>>> -       acquire_queue(kgd, pipe_id, queue_id);
>>> -       write_register(kgd, CP_HQD_PQ_DOORBELL_CONTROL, 0);
>>> -
>>> -       write_register(kgd, CP_HQD_DEQUEUE_REQUEST, reset_type);
>>> -
>>> -       while (true) {
>>> -               temp =3D read_register(kgd, CP_HQD_ACTIVE);
>>> -               if (temp & 0x1)
>>> -                       break;
>>> -               if (timeout =3D=3D 0) {
>>> -                       pr_err("kfd: cp queue preemption time out
>>> (%dms)\n",
>>> -                               temp);
>>> -                       release_queue(kgd);
>>> -                       return -ETIME;
>>> -               }
>>> -               msleep(20);
>>> -               timeout -=3D 20;
>>> -       }
>>> -
>>> -       release_queue(kgd);
>>> -       return 0;
>>> -}
>>> -
>>> -static int kgd_hqd_sdma_destroy(struct kgd_dev *kgd, void *mqd,
>>> -                               unsigned int timeout)
>>> -{
>>> -       struct cik_sdma_rlc_registers *m;
>>> -       uint32_t sdma_base_addr;
>>> -       uint32_t temp;
>>> -
>>> -       m =3D get_sdma_mqd(mqd);
>>> -       sdma_base_addr =3D get_sdma_base_addr(m);
>>> -
>>> -       temp =3D read_register(kgd, sdma_base_addr + SDMA0_RLC0_RB_CNTL=
);
>>> -       temp =3D temp & ~SDMA_RB_ENABLE;
>>> -       write_register(kgd, sdma_base_addr + SDMA0_RLC0_RB_CNTL, temp);
>>> -
>>> -       while (true) {
>>> -               temp =3D read_register(kgd, sdma_base_addr +
>>> -
>>>  SDMA0_RLC0_CONTEXT_STATUS);
>>> -               if (temp & SDMA_RLC_IDLE)
>>> -                       break;
>>> -               if (timeout =3D=3D 0)
>>> -                       return -ETIME;
>>> -               msleep(20);
>>> -               timeout -=3D 20;
>>> -       }
>>> -
>>> -       write_register(kgd, sdma_base_addr + SDMA0_RLC0_DOORBELL, 0);
>>> -       write_register(kgd, sdma_base_addr + SDMA0_RLC0_RB_RPTR, 0);
>>> -       write_register(kgd, sdma_base_addr + SDMA0_RLC0_RB_WPTR, 0);
>>> -       write_register(kgd, sdma_base_addr + SDMA0_RLC0_RB_BASE, 0);
>>> -
>>> -       return 0;
>>> -}
>>> -
>>> -static int kgd_address_watch_disable(struct kgd_dev *kgd)
>>> -{
>>> -       union TCP_WATCH_CNTL_BITS cntl;
>>> -       unsigned int i;
>>> -
>>> -       cntl.u32All =3D 0;
>>> -
>>> -       cntl.bitfields.valid =3D 0;
>>> -       cntl.bitfields.mask =3D ADDRESS_WATCH_REG_CNTL_DEFAULT_MASK;
>>> -       cntl.bitfields.atc =3D 1;
>>> -
>>> -       /* Turning off this address until we set all the registers */
>>> -       for (i =3D 0; i < MAX_WATCH_ADDRESSES; i++)
>>> -               write_register(kgd,
>>> -                               watchRegs[i * ADDRESS_WATCH_REG_MAX +
>>> -                                       ADDRESS_WATCH_REG_CNTL],
>>> -                               cntl.u32All);
>>> -
>>> -       return 0;
>>> -}
>>> -
>>> -static int kgd_address_watch_execute(struct kgd_dev *kgd,
>>> -                                       unsigned int watch_point_id,
>>> -                                       uint32_t cntl_val,
>>> -                                       uint32_t addr_hi,
>>> -                                       uint32_t addr_lo)
>>> -{
>>> -       union TCP_WATCH_CNTL_BITS cntl;
>>> -
>>> -       cntl.u32All =3D cntl_val;
>>> -
>>> -       /* Turning off this watch point until we set all the registers =
*/
>>> -       cntl.bitfields.valid =3D 0;
>>> -       write_register(kgd,
>>> -                       watchRegs[watch_point_id * ADDRESS_WATCH_REG_MA=
X
>>> +
>>> -                               ADDRESS_WATCH_REG_CNTL],
>>> -                       cntl.u32All);
>>> -
>>> -       write_register(kgd,
>>> -                       watchRegs[watch_point_id * ADDRESS_WATCH_REG_MA=
X
>>> +
>>> -                               ADDRESS_WATCH_REG_ADDR_HI],
>>> -                       addr_hi);
>>> -
>>> -       write_register(kgd,
>>> -                       watchRegs[watch_point_id * ADDRESS_WATCH_REG_MA=
X
>>> +
>>> -                               ADDRESS_WATCH_REG_ADDR_LO],
>>> -                       addr_lo);
>>> -
>>> -       /* Enable the watch point */
>>> -       cntl.bitfields.valid =3D 1;
>>> -
>>> -       write_register(kgd,
>>> -                       watchRegs[watch_point_id * ADDRESS_WATCH_REG_MA=
X
>>> +
>>> -                               ADDRESS_WATCH_REG_CNTL],
>>> -                       cntl.u32All);
>>> -
>>> -       return 0;
>>> -}
>>> -
>>> -static int kgd_wave_control_execute(struct kgd_dev *kgd,
>>> -                                       uint32_t gfx_index_val,
>>> -                                       uint32_t sq_cmd)
>>> -{
>>> -       struct radeon_device *rdev =3D get_radeon_device(kgd);
>>> -       uint32_t data;
>>> -
>>> -       mutex_lock(&rdev->grbm_idx_mutex);
>>> -
>>> -       write_register(kgd, GRBM_GFX_INDEX, gfx_index_val);
>>> -       write_register(kgd, SQ_CMD, sq_cmd);
>>> -
>>> -       /*  Restore the GRBM_GFX_INDEX register  */
>>> -
>>> -       data =3D INSTANCE_BROADCAST_WRITES | SH_BROADCAST_WRITES |
>>> -               SE_BROADCAST_WRITES;
>>> -
>>> -       write_register(kgd, GRBM_GFX_INDEX, data);
>>> -
>>> -       mutex_unlock(&rdev->grbm_idx_mutex);
>>> -
>>> -       return 0;
>>> -}
>>> -
>>> -static uint32_t kgd_address_watch_get_offset(struct kgd_dev *kgd,
>>> -                                       unsigned int watch_point_id,
>>> -                                       unsigned int reg_offset)
>>> -{
>>> -       return watchRegs[watch_point_id * ADDRESS_WATCH_REG_MAX +
>>> reg_offset]
>>> -               / 4;
>>> -}
>>> -
>>> -static bool get_atc_vmid_pasid_mapping_valid(struct kgd_dev *kgd,
>>> uint8_t vmid)
>>> -{
>>> -       uint32_t reg;
>>> -       struct radeon_device *rdev =3D (struct radeon_device *) kgd;
>>> -
>>> -       reg =3D RREG32(ATC_VMID0_PASID_MAPPING + vmid*4);
>>> -       return reg & ATC_VMID_PASID_MAPPING_VALID_MASK;
>>> -}
>>> -
>>> -static uint16_t get_atc_vmid_pasid_mapping_pasid(struct kgd_dev *kgd,
>>> -                                                       uint8_t vmid)
>>> -{
>>> -       uint32_t reg;
>>> -       struct radeon_device *rdev =3D (struct radeon_device *) kgd;
>>> -
>>> -       reg =3D RREG32(ATC_VMID0_PASID_MAPPING + vmid*4);
>>> -       return reg & ATC_VMID_PASID_MAPPING_PASID_MASK;
>>> -}
>>> -
>>> -static void write_vmid_invalidate_request(struct kgd_dev *kgd, uint8_t
>>> vmid)
>>> -{
>>> -       struct radeon_device *rdev =3D (struct radeon_device *) kgd;
>>> -
>>> -       return WREG32(VM_INVALIDATE_REQUEST, 1 << vmid);
>>> -}
>>> -
>>> -static uint16_t get_fw_version(struct kgd_dev *kgd, enum
>>> kgd_engine_type type)
>>> -{
>>> -       struct radeon_device *rdev =3D (struct radeon_device *) kgd;
>>> -       const union radeon_firmware_header *hdr;
>>> -
>>> -       BUG_ON(kgd =3D=3D NULL || rdev->mec_fw =3D=3D NULL);
>>> -
>>> -       switch (type) {
>>> -       case KGD_ENGINE_PFP:
>>> -               hdr =3D (const union radeon_firmware_header *)
>>> rdev->pfp_fw->data;
>>> -               break;
>>> -
>>> -       case KGD_ENGINE_ME:
>>> -               hdr =3D (const union radeon_firmware_header *)
>>> rdev->me_fw->data;
>>> -               break;
>>> -
>>> -       case KGD_ENGINE_CE:
>>> -               hdr =3D (const union radeon_firmware_header *)
>>> rdev->ce_fw->data;
>>> -               break;
>>> -
>>> -       case KGD_ENGINE_MEC1:
>>> -               hdr =3D (const union radeon_firmware_header *)
>>> rdev->mec_fw->data;
>>> -               break;
>>> -
>>> -       case KGD_ENGINE_MEC2:
>>> -               hdr =3D (const union radeon_firmware_header *)
>>> -
>>>  rdev->mec2_fw->data;
>>> -               break;
>>> -
>>> -       case KGD_ENGINE_RLC:
>>> -               hdr =3D (const union radeon_firmware_header *)
>>> rdev->rlc_fw->data;
>>> -               break;
>>> -
>>> -       case KGD_ENGINE_SDMA1:
>>> -       case KGD_ENGINE_SDMA2:
>>> -               hdr =3D (const union radeon_firmware_header *)
>>> -
>>>  rdev->sdma_fw->data;
>>> -               break;
>>> -
>>> -       default:
>>> -               return 0;
>>> -       }
>>> -
>>> -       if (hdr =3D=3D NULL)
>>> -               return 0;
>>> -
>>> -       /* Only 12 bit in use*/
>>> -       return hdr->common.ucode_version;
>>> -}
>>> diff --git a/drivers/gpu/drm/radeon/radeon_kfd.h
>>> b/drivers/gpu/drm/radeon/radeon_kfd.h
>>> deleted file mode 100644
>>> index 9df1fea..0000000
>>> --- a/drivers/gpu/drm/radeon/radeon_kfd.h
>>> +++ /dev/null
>>> @@ -1,47 +0,0 @@
>>> -/*
>>> - * Copyright 2014 Advanced Micro Devices, Inc.
>>> - *
>>> - * Permission is hereby granted, free of charge, to any person
>>> obtaining a
>>> - * copy of this software and associated documentation files (the
>>> "Software"),
>>> - * to deal in the Software without restriction, including without
>>> limitation
>>> - * the rights to use, copy, modify, merge, publish, distribute,
>>> sublicense,
>>> - * and/or sell copies of the Software, and to permit persons to whom t=
he
>>> - * Software is furnished to do so, subject to the following conditions=
:
>>> - *
>>> - * The above copyright notice and this permission notice shall be
>>> included in
>>> - * all copies or substantial portions of the Software.
>>> - *
>>> - * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
>>> EXPRESS OR
>>> - * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
>>> MERCHANTABILITY,
>>> - * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT
>>> SHALL
>>> - * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM,
>>> DAMAGES OR
>>> - * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWIS=
E,
>>> - * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE =
OR
>>> - * OTHER DEALINGS IN THE SOFTWARE.
>>> - */
>>> -
>>> -/*
>>> - * radeon_kfd.h defines the private interface between the
>>> - * AMD kernel graphics drivers and the AMD KFD.
>>> - */
>>> -
>>> -#ifndef RADEON_KFD_H_INCLUDED
>>> -#define RADEON_KFD_H_INCLUDED
>>> -
>>> -#include <linux/types.h>
>>> -#include "kgd_kfd_interface.h"
>>> -
>>> -struct radeon_device;
>>> -
>>> -int radeon_kfd_init(void);
>>> -void radeon_kfd_fini(void);
>>> -
>>> -void radeon_kfd_suspend(struct radeon_device *rdev);
>>> -int radeon_kfd_resume(struct radeon_device *rdev);
>>> -void radeon_kfd_interrupt(struct radeon_device *rdev,
>>> -                       const void *ih_ring_entry);
>>> -void radeon_kfd_device_probe(struct radeon_device *rdev);
>>> -void radeon_kfd_device_init(struct radeon_device *rdev);
>>> -void radeon_kfd_device_fini(struct radeon_device *rdev);
>>> -
>>> -#endif /* RADEON_KFD_H_INCLUDED */
>>> diff --git a/drivers/gpu/drm/radeon/radeon_kms.c
>>> b/drivers/gpu/drm/radeon/radeon_kms.c
>>> index dfee8f7..cde037f 100644
>>> --- a/drivers/gpu/drm/radeon/radeon_kms.c
>>> +++ b/drivers/gpu/drm/radeon/radeon_kms.c
>>> @@ -34,8 +34,6 @@
>>>   #include <linux/slab.h>
>>>   #include <linux/pm_runtime.h>
>>>
>>> -#include "radeon_kfd.h"
>>> -
>>>   #if defined(CONFIG_VGA_SWITCHEROO)
>>>   bool radeon_has_atpx(void);
>>>   #else
>>> @@ -68,8 +66,6 @@ void radeon_driver_unload_kms(struct drm_device *dev)
>>>                  pm_runtime_forbid(dev->dev);
>>>          }
>>>
>>> -       radeon_kfd_device_fini(rdev);
>>> -
>>>          radeon_acpi_fini(rdev);
>>>
>>>          radeon_modeset_fini(rdev);
>>> @@ -174,9 +170,6 @@ int radeon_driver_load_kms(struct drm_device *dev,
>>> unsigned long flags)
>>>                                  "Error during ACPI methods call\n");
>>>          }
>>>
>>> -       radeon_kfd_device_probe(rdev);
>>> -       radeon_kfd_device_init(rdev);
>>> -
>>>          if (radeon_is_px(dev)) {
>>>                  pm_runtime_use_autosuspend(dev->dev);
>>>                  pm_runtime_set_autosuspend_delay(dev->dev, 5000);
>>> --
>>> 2.7.4
>>>
>>> _______________________________________________
>>> amd-gfx mailing list
>>> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>>> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>>>
>> _______________________________________________
>> amd-gfx mailing list
>> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>>
>
>
>

--001a114551d8dab128055ce7b5a9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_default" style=3D"font-size:small">ok,=
 taken to -next.</div></div><div class=3D"gmail_extra"><br><div class=3D"gm=
ail_quote">On Tue, Oct 31, 2017 at 4:56 PM, Christian K=C3=B6nig <span dir=
=3D"ltr">&lt;<a href=3D"mailto:ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" target=3D"=
_blank">ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;</span> wrote:<br><blockquo=
te class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc so=
lid;padding-left:1ex"><span class=3D"">Am 31.10.2017 um 11:44 schrieb Oded =
Gabbay:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
Don&#39;t have any strong objection, but I just want to ask if current<br>
users can just move to using amdgpu on KV and their current usermode<br>
stack will work as usual.<br>
</blockquote>
<br></span>
Yes, I think so.<span class=3D""><br>
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
btw, are there any &quot;current users&quot; that you are aware of ?<br>
</blockquote>
<br></span>
Not the slightest idea, but from Felix comments at least the current user m=
ode stack + old kernel won&#39;t work.<br>
<br>
Regards,<br>
Christian.<div class=3D"HOEnZb"><div class=3D"h5"><br>
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
<br>
<br>
On Mon, Oct 30, 2017 at 3:16 PM, Christian K=C3=B6nig<br>
&lt;<a href=3D"mailto:deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org" target=3D"_blank">deathsimpl=
e@vodafone.de</a>&gt; wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
From: Christian K=C3=B6nig &lt;<a href=3D"mailto:christian.koenig-5C7GfCeVMHo@public.gmane.org" =
target=3D"_blank">christian.koenig-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
<br>
To quote Felix: &quot;For testing KV with current user mode stack, please u=
se<br>
amdgpu. I don&#39;t expect this to work with radeon and I&#39;m not plannin=
g to spend<br>
any effort on making radeon work with a current user mode stack.&quot;<br>
<br>
Only compile tested, but should be straight forward.<br>
<br>
Signed-off-by: Christian K=C3=B6nig &lt;<a href=3D"mailto:christian.koenig@=
amd.com" target=3D"_blank">christian.koenig-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
---<br>
=C2=A0 drivers/gpu/drm/amd/amdkfd/Kco<wbr>nfig=C2=A0 |=C2=A0 =C2=A02 +-<br>
=C2=A0 drivers/gpu/drm/radeon/Makefil<wbr>e=C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=
=A03 +-<br>
=C2=A0 drivers/gpu/drm/radeon/cik.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 14 +=
-<br>
=C2=A0 drivers/gpu/drm/radeon/cikd.h=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=
=A02 -<br>
=C2=A0 drivers/gpu/drm/radeon/radeon.<wbr>h=C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=
=A03 -<br>
=C2=A0 drivers/gpu/drm/radeon/radeon_<wbr>drv.c |=C2=A0 10 -<br>
=C2=A0 drivers/gpu/drm/radeon/radeon_<wbr>kfd.c | 901 ---------------------=
---------<wbr>------<br>
=C2=A0 drivers/gpu/drm/radeon/radeon_<wbr>kfd.h |=C2=A0 47 --<br>
=C2=A0 drivers/gpu/drm/radeon/radeon_<wbr>kms.c |=C2=A0 =C2=A07 -<br>
=C2=A0 9 files changed, 4 insertions(+), 985 deletions(-)<br>
=C2=A0 delete mode 100644 drivers/gpu/drm/radeon/radeon_<wbr>kfd.c<br>
=C2=A0 delete mode 100644 drivers/gpu/drm/radeon/radeon_<wbr>kfd.h<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdkfd/K<wbr>config b/drivers/gpu/drm/amd/=
amdkfd/K<wbr>config<br>
index e13c67c..bc5a294 100644<br>
--- a/drivers/gpu/drm/amd/amdkfd/K<wbr>config<br>
+++ b/drivers/gpu/drm/amd/amdkfd/K<wbr>config<br>
@@ -4,6 +4,6 @@<br>
<br>
=C2=A0 config HSA_AMD<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tristate &quot;HSA kernel driver for AMD =
GPU devices&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0depends on (DRM_RADEON || DRM_AMDGPU) &amp;&amp=
; AMD_IOMMU_V2 &amp;&amp; X86_64<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0depends on DRM_AMDGPU &amp;&amp; AMD_IOMMU_V2 &=
amp;&amp; X86_64<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0help<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Enable this if you want to use HSA=
 features on AMD GPU devices.<br>
diff --git a/drivers/gpu/drm/radeon/Makef<wbr>ile b/drivers/gpu/drm/radeon/=
Makef<wbr>ile<br>
index be16c63..cf3e598 100644<br>
--- a/drivers/gpu/drm/radeon/Makef<wbr>ile<br>
+++ b/drivers/gpu/drm/radeon/Makef<wbr>ile<br>
@@ -102,8 +102,7 @@ radeon-y +=3D \<br>
=C2=A0 radeon-y +=3D \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0radeon_vce.o \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vce_v1_0.o \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0vce_v2_0.o \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0radeon_kfd.o<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0vce_v2_0.o<br>
<br>
=C2=A0 radeon-$(CONFIG_VGA_SWITCHEROO<wbr>) +=3D radeon_atpx_handler.o<br>
=C2=A0 radeon-$(CONFIG_ACPI) +=3D radeon_acpi.o<br>
diff --git a/drivers/gpu/drm/radeon/cik.c b/drivers/gpu/drm/radeon/cik.c<br=
>
index 3cb6c55..898f9a0 100644<br>
--- a/drivers/gpu/drm/radeon/cik.c<br>
+++ b/drivers/gpu/drm/radeon/cik.c<br>
@@ -33,7 +33,6 @@<br>
=C2=A0 #include &quot;cik_blit_shaders.h&quot;<br>
=C2=A0 #include &quot;radeon_ucode.h&quot;<br>
=C2=A0 #include &quot;clearstate_ci.h&quot;<br>
-#include &quot;radeon_kfd.h&quot;<br>
<br>
=C2=A0 #define SH_MEM_CONFIG_GFX_DEFAULT \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ALIGNMENT_MODE(SH_MEM_ALIGNME<wbr>NT_MODE=
_UNALIGNED)<br>
@@ -5684,10 +5683,9 @@ int cik_vm_init(struct radeon_device *rdev)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/*<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * number of VMs<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * VMID 0 is reserved for System<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 * radeon graphics/compute will use VMIDs 1-7<b=
r>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 * amdkfd will use VMIDs 8-15<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 * radeon graphics/compute will use VMIDs 1-15<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0rdev-&gt;vm_manager.nvm =3D RADEON_NUM_OF_VMIDS=
;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0rdev-&gt;vm_manager.nvm =3D 16;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* base offset of vram pages */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (rdev-&gt;flags &amp; RADEON_IS_IGP) {=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0u64 tmp =3D R=
REG32(MC_VM_FB_OFFSET);<br>
@@ -7589,9 +7587,6 @@ int cik_irq_process(struct radeon_device *rdev)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* wptr/rptr =
are in bytes! */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ring_index =
=3D rptr / 4;<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0radeon_kfd_interrup=
t(rdev,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(const void *) &amp;rdev-&gt;ih.ring[=
ring_index]);<br>
-<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0src_id =3D=C2=
=A0 le32_to_cpu(rdev-&gt;ih.ring[ring<wbr>_index]) &amp; 0xff;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0src_data =3D =
le32_to_cpu(rdev-&gt;ih.ring[ring<wbr>_index + 1]) &amp; 0xfffffff;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ring_id =3D l=
e32_to_cpu(rdev-&gt;ih.ring[ring<wbr>_index + 2]) &amp; 0xff;<br>
@@ -8486,10 +8481,6 @@ static int cik_startup(struct radeon_device *rdev)<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (r)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return r;<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0r =3D radeon_kfd_resume(rdev);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (r)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return r;<br>
-<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
=C2=A0 }<br>
<br>
@@ -8538,7 +8529,6 @@ int cik_resume(struct radeon_device *rdev)<br>
=C2=A0 =C2=A0*/<br>
=C2=A0 int cik_suspend(struct radeon_device *rdev)<br>
=C2=A0 {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0radeon_kfd_suspend(rdev);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0radeon_pm_suspend(rdev);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0radeon_audio_fini(rdev);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0radeon_vm_manager_fini(rdev);<br>
diff --git a/drivers/gpu/drm/radeon/cikd.<wbr>h b/drivers/gpu/drm/radeon/ci=
kd.<wbr>h<br>
index e210154..cda16fc 100644<br>
--- a/drivers/gpu/drm/radeon/cikd.<wbr>h<br>
+++ b/drivers/gpu/drm/radeon/cikd.<wbr>h<br>
@@ -30,8 +30,6 @@<br>
=C2=A0 #define CIK_RB_BITMAP_WIDTH_PER_SH=C2=A0 =C2=A0 =C2=A02<br>
=C2=A0 #define HAWAII_RB_BITMAP_WIDTH_PER_SH=C2=A0 4<br>
<br>
-#define RADEON_NUM_OF_VMIDS=C2=A0 =C2=A0 8<br>
-<br>
=C2=A0 /* DIDT IND registers */<br>
=C2=A0 #define DIDT_SQ_CTRL0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A00x0<br>
=C2=A0 #=C2=A0 =C2=A0 =C2=A0 =C2=A0define DIDT_CTRL_EN=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0(1 &lt;&lt; 0)<br>
diff --git a/drivers/gpu/drm/radeon/radeo<wbr>n.h b/drivers/gpu/drm/radeon/=
radeo<wbr>n.h<br>
index ec63bc5..d94741b 100644<br>
--- a/drivers/gpu/drm/radeon/radeo<wbr>n.h<br>
+++ b/drivers/gpu/drm/radeon/radeo<wbr>n.h<br>
@@ -2456,9 +2456,6 @@ struct radeon_device {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0u64 vram_pin_size;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0u64 gart_pin_size;<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0/* amdkfd interface */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0struct kfd_dev=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 *kfd;<br>
-<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct mutex=C2=A0 =C2=A0 mn_lock;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0DECLARE_HASHTABLE(mn_hash, 7);<br>
=C2=A0 };<br>
diff --git a/drivers/gpu/drm/radeon/radeo<wbr>n_drv.c b/drivers/gpu/drm/rad=
eon/radeo<wbr>n_drv.c<br>
index f4becad..31dd04f 100644<br>
--- a/drivers/gpu/drm/radeon/radeo<wbr>n_drv.c<br>
+++ b/drivers/gpu/drm/radeon/radeo<wbr>n_drv.c<br>
@@ -43,7 +43,6 @@<br>
=C2=A0 #include &lt;drm/drm_fb_helper.h&gt;<br>
<br>
=C2=A0 #include &lt;drm/drm_crtc_helper.h&gt;<br>
-#include &quot;radeon_kfd.h&quot;<br>
<br>
=C2=A0 /*<br>
=C2=A0 =C2=A0* KMS wrapper.<br>
@@ -338,14 +337,6 @@ static int radeon_pci_probe(struct pci_dev *pdev,<br>
=C2=A0 {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int ret;<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0/*<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 * Initialize amdkfd before starting radeon. If=
 it was not loaded yet,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 * defer radeon probing<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D radeon_kfd_init();<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret =3D=3D -EPROBE_DEFER)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
-<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (vga_switcheroo_client_probe_d<wbr>efe=
r(pdev))<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EPROB=
E_DEFER;<br>
<br>
@@ -645,7 +636,6 @@ static int __init radeon_init(void)<br>
<br>
=C2=A0 static void __exit radeon_exit(void)<br>
=C2=A0 {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0radeon_kfd_fini();<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pci_unregister_driver(<wbr>pdriver);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0radeon_unregister_atpx_handle<wbr>r();<br=
>
=C2=A0 }<br>
diff --git a/drivers/gpu/drm/radeon/radeo<wbr>n_kfd.c b/drivers/gpu/drm/rad=
eon/radeo<wbr>n_kfd.c<br>
deleted file mode 100644<br>
index 385b4d7..0000000<br>
--- a/drivers/gpu/drm/radeon/radeo<wbr>n_kfd.c<br>
+++ /dev/null<br>
@@ -1,901 +0,0 @@<br>
-/*<br>
- * Copyright 2014 Advanced Micro Devices, Inc.<br>
- *<br>
- * Permission is hereby granted, free of charge, to any person obtaining a=
<br>
- * copy of this software and associated documentation files (the &quot;Sof=
tware&quot;),<br>
- * to deal in the Software without restriction, including without limitati=
on<br>
- * the rights to use, copy, modify, merge, publish, distribute, sublicense=
,<br>
- * and/or sell copies of the Software, and to permit persons to whom the<b=
r>
- * Software is furnished to do so, subject to the following conditions:<br=
>
- *<br>
- * The above copyright notice and this permission notice shall be included=
 in<br>
- * all copies or substantial portions of the Software.<br>
- *<br>
- * THE SOFTWARE IS PROVIDED &quot;AS IS&quot;, WITHOUT WARRANTY OF ANY KIN=
D, EXPRESS OR<br>
- * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY=
,<br>
- * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.=C2=A0 IN NO EVENT=
 SHALL<br>
- * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES O=
R<br>
- * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,<b=
r>
- * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR<b=
r>
- * OTHER DEALINGS IN THE SOFTWARE.<br>
- */<br>
-<br>
-#include &lt;linux/module.h&gt;<br>
-#include &lt;linux/fdtable.h&gt;<br>
-#include &lt;linux/uaccess.h&gt;<br>
-#include &lt;drm/drmP.h&gt;<br>
-#include &quot;radeon.h&quot;<br>
-#include &quot;cikd.h&quot;<br>
-#include &quot;cik_reg.h&quot;<br>
-#include &quot;radeon_kfd.h&quot;<br>
-#include &quot;radeon_ucode.h&quot;<br>
-#include &lt;linux/firmware.h&gt;<br>
-#include &quot;cik_structs.h&quot;<br>
-<br>
-#define CIK_PIPE_PER_MEC=C2=A0 =C2=A0 =C2=A0 =C2=A0(4)<br>
-<br>
-static const uint32_t watchRegs[MAX_WATCH_ADDRESSES * ADDRESS_WATCH_REG_MA=
X] =3D {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0TCP_WATCH0_ADDR_H, TCP_WATCH0_ADDR_L, TCP_WATCH=
0_CNTL,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0TCP_WATCH1_ADDR_H, TCP_WATCH1_ADDR_L, TCP_WATCH=
1_CNTL,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0TCP_WATCH2_ADDR_H, TCP_WATCH2_ADDR_L, TCP_WATCH=
2_CNTL,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0TCP_WATCH3_ADDR_H, TCP_WATCH3_ADDR_L, TCP_WATCH=
3_CNTL<br>
-};<br>
-<br>
-struct kgd_mem {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0struct radeon_bo *bo;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0uint64_t gpu_addr;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0void *cpu_ptr;<br>
-};<br>
-<br>
-<br>
-static int alloc_gtt_mem(struct kgd_dev *kgd, size_t size,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0void **mem_obj, uint64_t *gpu_addr,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0void **cpu_ptr);<br>
-<br>
-static void free_gtt_mem(struct kgd_dev *kgd, void *mem_obj);<br>
-<br>
-static uint64_t get_vmem_size(struct kgd_dev *kgd);<br>
-static uint64_t get_gpu_clock_counter(struct kgd_dev *kgd);<br>
-<br>
-static uint32_t get_max_engine_clock_in_mhz(st<wbr>ruct kgd_dev *kgd);<br>
-<br>
-static int alloc_pasid(unsigned int bits);<br>
-static void free_pasid(unsigned int pasid);<br>
-<br>
-static uint16_t get_fw_version(struct kgd_dev *kgd, enum kgd_engine_type t=
ype);<br>
-<br>
-/*<br>
- * Register access functions<br>
- */<br>
-<br>
-static void kgd_program_sh_mem_settings(st<wbr>ruct kgd_dev *kgd, uint32_t=
 vmid,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t sh_mem_con=
fig, uint32_t sh_mem_ape1_base,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t sh_mem_ape=
1_limit, uint32_t sh_mem_bases);<br>
-<br>
-static int kgd_set_pasid_vmid_mapping(str<wbr>uct kgd_dev *kgd, unsigned i=
nt pasid,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned =
int vmid);<br>
-<br>
-static int kgd_init_pipeline(struct kgd_dev *kgd, uint32_t pipe_id,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t hpd_size, uint64_t hpd_gpu_a=
ddr);<br>
-static int kgd_init_interrupts(struct kgd_dev *kgd, uint32_t pipe_id);<br>
-static int kgd_hqd_load(struct kgd_dev *kgd, void *mqd, uint32_t pipe_id,<=
br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0uint32_t queue_id, uint32_t __user *wptr,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0uint32_t wptr_shift, uint32_t wptr_mask,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0struct mm_struct *mm);<br>
-static int kgd_hqd_sdma_load(struct kgd_dev *kgd, void *mqd);<br>
-static bool kgd_hqd_is_occupied(struct kgd_dev *kgd, uint64_t queue_addres=
s,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t pipe_id, uint32_t queue_id);=
<br>
-<br>
-static int kgd_hqd_destroy(struct kgd_dev *kgd, void *mqd, uint32_t reset_=
type,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int timeout, uint32_t pipe_i=
d,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t queue_id);<br>
-static bool kgd_hqd_sdma_is_occupied(struc<wbr>t kgd_dev *kgd, void *mqd);=
<br>
-static int kgd_hqd_sdma_destroy(struct kgd_dev *kgd, void *mqd,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int timeout);<br>
-static int kgd_address_watch_disable(stru<wbr>ct kgd_dev *kgd);<br>
-static int kgd_address_watch_execute(stru<wbr>ct kgd_dev *kgd,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned =
int watch_point_id,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t =
cntl_val,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t =
addr_hi,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t =
addr_lo);<br>
-static int kgd_wave_control_execute(struc<wbr>t kgd_dev *kgd,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t =
gfx_index_val,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t =
sq_cmd);<br>
-static uint32_t kgd_address_watch_get_offset(s<wbr>truct kgd_dev *kgd,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned =
int watch_point_id,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned =
int reg_offset);<br>
-<br>
-static bool get_atc_vmid_pasid_mapping_val<wbr>id(struct kgd_dev *kgd, uin=
t8_t vmid);<br>
-static uint16_t get_atc_vmid_pasid_mapping_pas<wbr>id(struct kgd_dev *kgd,=
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint8_t vmid);<br>
-static void write_vmid_invalidate_request(<wbr>struct kgd_dev *kgd, uint8_=
t vmid);<br>
-<br>
-static const struct kfd2kgd_calls kfd2kgd =3D {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0.init_gtt_mem_allocation =3D alloc_gtt_mem,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0.free_gtt_mem =3D free_gtt_mem,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0.get_vmem_size =3D get_vmem_size,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0.get_gpu_clock_counter =3D get_gpu_clock_counte=
r,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0.get_max_engine_clock_in_mhz =3D get_max_engine=
_clock_in_mhz,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0.alloc_pasid =3D alloc_pasid,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0.free_pasid =3D free_pasid,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0.program_sh_mem_settings =3D kgd_program_sh_mem=
_settings,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0.set_pasid_vmid_mapping =3D kgd_set_pasid_vmid_=
mapping,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0.init_pipeline =3D kgd_init_pipeline,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0.init_interrupts =3D kgd_init_interrupts,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0.hqd_load =3D kgd_hqd_load,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0.hqd_sdma_load =3D kgd_hqd_sdma_load,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0.hqd_is_occupied =3D kgd_hqd_is_occupied,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0.hqd_sdma_is_occupied =3D kgd_hqd_sdma_is_occup=
ied,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0.hqd_destroy =3D kgd_hqd_destroy,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0.hqd_sdma_destroy =3D kgd_hqd_sdma_destroy,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0.address_watch_disable =3D kgd_address_watch_di=
sable,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0.address_watch_execute =3D kgd_address_watch_ex=
ecute,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0.wave_control_execute =3D kgd_wave_control_exec=
ute,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0.address_watch_get_offset =3D kgd_address_watch=
_get_offset,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0.get_atc_vmid_pasid_mapping_p<wbr>asid =3D get_=
atc_vmid_pasid_mapping_pas<wbr>id,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0.get_atc_vmid_pasid_mapping_v<wbr>alid =3D get_=
atc_vmid_pasid_mapping_val<wbr>id,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0.write_vmid_invalidate_<wbr>request =3D write_v=
mid_invalidate_request,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0.get_fw_version =3D get_fw_version<br>
-};<br>
-<br>
-static const struct kgd2kfd_calls *kgd2kfd;<br>
-<br>
-int radeon_kfd_init(void)<br>
-{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0int ret;<br>
-<br>
-#if defined(CONFIG_HSA_AMD_MODULE)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0int (*kgd2kfd_init_p)(unsigned, const struct kg=
d2kfd_calls**);<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0kgd2kfd_init_p =3D symbol_request(kgd2kfd_init)=
;<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (kgd2kfd_init_p =3D=3D NULL)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -ENOENT;<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D kgd2kfd_init_p(KFD_INTERFACE_V<wbr>ERSI=
ON, &amp;kgd2kfd);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0symbol_put(kgd2kfd_=
init);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0kgd2kfd =3D NULL;<b=
r>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
-<br>
-#elif defined(CONFIG_HSA_AMD)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D kgd2kfd_init(KFD_INTERFACE_VER<wbr>SION=
, &amp;kgd2kfd);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0kgd2kfd =3D NULL;<b=
r>
-<br>
-#else<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D -ENOENT;<br>
-#endif<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
-}<br>
-<br>
-void radeon_kfd_fini(void)<br>
-{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (kgd2kfd) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0kgd2kfd-&gt;exit();=
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0symbol_put(kgd2kfd_=
init);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
-}<br>
-<br>
-void radeon_kfd_device_probe(struct radeon_device *rdev)<br>
-{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (kgd2kfd)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rdev-&gt;kfd =3D kg=
d2kfd-&gt;probe((struct kgd_dev *)rdev,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0rdev-&gt;pdev, &amp;kfd2kgd);<br>
-}<br>
-<br>
-void radeon_kfd_device_init(struct radeon_device *rdev)<br>
-{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0int i, queue, pipe, mec;<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (rdev-&gt;kfd) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct kgd2kfd_shar=
ed_resources gpu_resources =3D {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0.compute_vmid_bitmap =3D 0xFF00,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0.num_pipe_per_mec =3D 4,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0.num_queue_per_pipe =3D 8<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0};<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bitmap_zero(gpu_res=
ources.que<wbr>ue_bitmap, KGD_MAX_QUEUES);<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for (i =3D 0; i &lt=
; KGD_MAX_QUEUES; ++i) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0queue =3D i % gpu_resources.num_queue_per_pi<wbr>pe;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0pipe =3D (i / gpu_resources.num_queue_per_pi<wbr>pe)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0% gpu_resources.num_pipe_per_mec<wbr>=
;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0mec =3D (i / gpu_resources.num_queue_per_pi<wbr>pe)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/ gpu_resources.num_pipe_per_mec<wbr>=
;<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0if (mec =3D=3D 0 &amp;&amp; pipe &gt; 0)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0set_bit(i, gpu_resources.queue_bitmap=
);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0radeon_doorbell_get=
_kfd_info(<wbr>rdev,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;gpu_resources.doorbell_physi<wbr=
>cal_address,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;gpu_resources.doorbell_apert<wbr=
>ure_size,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;gpu_resources.doorbell_<wbr>star=
t_offset);<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0kgd2kfd-&gt;device_=
init(rdev-&gt;kf<wbr>d, &amp;gpu_resources);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
-}<br>
-<br>
-void radeon_kfd_device_fini(struct radeon_device *rdev)<br>
-{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (rdev-&gt;kfd) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0kgd2kfd-&gt;device_=
exit(rdev-&gt;kf<wbr>d);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rdev-&gt;kfd =3D NU=
LL;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
-}<br>
-<br>
-void radeon_kfd_interrupt(struct radeon_device *rdev, const void *ih_ring_=
entry)<br>
-{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (rdev-&gt;kfd)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0kgd2kfd-&gt;interru=
pt(rdev-&gt;kfd, ih_ring_entry);<br>
-}<br>
-<br>
-void radeon_kfd_suspend(struct radeon_device *rdev)<br>
-{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (rdev-&gt;kfd)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0kgd2kfd-&gt;suspend=
(rdev-&gt;kfd);<br>
-}<br>
-<br>
-int radeon_kfd_resume(struct radeon_device *rdev)<br>
-{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0int r =3D 0;<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (rdev-&gt;kfd)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0r =3D kgd2kfd-&gt;r=
esume(rdev-&gt;kfd);<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0return r;<br>
-}<br>
-<br>
-static int alloc_gtt_mem(struct kgd_dev *kgd, size_t size,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0void **mem_obj, uint64_t *gpu_addr,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0void **cpu_ptr)<br>
-{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0struct radeon_device *rdev =3D (struct radeon_d=
evice *)kgd;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0struct kgd_mem **mem =3D (struct kgd_mem **) me=
m_obj;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0int r;<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0BUG_ON(kgd =3D=3D NULL);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0BUG_ON(gpu_addr =3D=3D NULL);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0BUG_ON(cpu_ptr =3D=3D NULL);<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0*mem =3D kmalloc(sizeof(struct kgd_mem), GFP_KE=
RNEL);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if ((*mem) =3D=3D NULL)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -ENOMEM;<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0r =3D radeon_bo_create(rdev, size, PAGE_SIZE, t=
rue, RADEON_GEM_DOMAIN_GTT,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0RADEON_GEM_GTT_WC, NULL, NULL, &amp;(=
*mem)-&gt;bo);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (r) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_err(rdev-&gt;de=
v,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0&quot;failed to allocate BO for amdkfd (%d)\n&quot;, r);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return r;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0/* map the buffer */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0r =3D radeon_bo_reserve((*mem)-&gt;bo, true);<b=
r>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (r) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_err(rdev-&gt;de=
v, &quot;(%d) failed to reserve bo for amdkfd\n&quot;, r);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto allocate_mem_r=
eserve_bo_failed<wbr>;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0r =3D radeon_bo_pin((*mem)-&gt;bo, RADEON_GEM_D=
OMAIN_GTT,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;(*mem)-&gt;gpu_addr);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (r) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_err(rdev-&gt;de=
v, &quot;(%d) failed to pin bo for amdkfd\n&quot;, r);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto allocate_mem_p=
in_bo_failed;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0*gpu_addr =3D (*mem)-&gt;gpu_addr;<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0r =3D radeon_bo_kmap((*mem)-&gt;bo, &amp;(*mem)=
-&gt;cpu_ptr);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (r) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_err(rdev-&gt;de=
v,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0&quot;(%d) failed to map bo to kernel for amdkfd\n&quot;, r);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto allocate_mem_k=
map_bo_failed;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0*cpu_ptr =3D (*mem)-&gt;cpu_ptr;<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0radeon_bo_unreserve((*mem)-&gt;b<wbr>o);<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
-<br>
-allocate_mem_kmap_bo_failed:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0radeon_bo_unpin((*mem)-&gt;bo);<br>
-allocate_mem_pin_bo_failed:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0radeon_bo_unreserve((*mem)-&gt;b<wbr>o);<br>
-allocate_mem_reserve_bo_faile<wbr>d:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0radeon_bo_unref(&amp;(*mem)-&gt;bo);<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0return r;<br>
-}<br>
-<br>
-static void free_gtt_mem(struct kgd_dev *kgd, void *mem_obj)<br>
-{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0struct kgd_mem *mem =3D (struct kgd_mem *) mem_=
obj;<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0BUG_ON(mem =3D=3D NULL);<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0radeon_bo_reserve(mem-&gt;bo, true);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0radeon_bo_kunmap(mem-&gt;bo);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0radeon_bo_unpin(mem-&gt;bo);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0radeon_bo_unreserve(mem-&gt;bo);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0radeon_bo_unref(&amp;(mem-&gt;bo));<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0kfree(mem);<br>
-}<br>
-<br>
-static uint64_t get_vmem_size(struct kgd_dev *kgd)<br>
-{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0struct radeon_device *rdev =3D (struct radeon_d=
evice *)kgd;<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0BUG_ON(kgd =3D=3D NULL);<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0return rdev-&gt;mc.real_vram_size;<br>
-}<br>
-<br>
-static uint64_t get_gpu_clock_counter(struct kgd_dev *kgd)<br>
-{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0struct radeon_device *rdev =3D (struct radeon_d=
evice *)kgd;<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0return rdev-&gt;asic-&gt;get_gpu_clock_coun<wbr=
>ter(rdev);<br>
-}<br>
-<br>
-static uint32_t get_max_engine_clock_in_mhz(st<wbr>ruct kgd_dev *kgd)<br>
-{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0struct radeon_device *rdev =3D (struct radeon_d=
evice *)kgd;<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0/* The sclk is in quantas of 10kHz */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0return rdev-&gt;pm.dpm.dyn_state.max_clo<wbr>ck=
_voltage_on_ac.sclk / 100;<br>
-}<br>
-<br>
-/*<br>
- * PASID manager<br>
- */<br>
-static DEFINE_IDA(pasid_ida);<br>
-<br>
-static int alloc_pasid(unsigned int bits)<br>
-{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0int pasid =3D -EINVAL;<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0for (bits =3D min(bits, 31U); bits &gt; 0; bits=
--) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pasid =3D ida_simpl=
e_get(&amp;pasid_ida,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 1U &lt;&lt; (bi=
ts - 1), 1U &lt;&lt; bits,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 GFP_KERNEL);<br=
>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (pasid !=3D -ENO=
SPC)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0break;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0return pasid;<br>
-}<br>
-<br>
-static void free_pasid(unsigned int pasid)<br>
-{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0ida_simple_remove(&amp;pasid_ida, pasid);<br>
-}<br>
-<br>
-static inline struct radeon_device *get_radeon_device(struct kgd_dev *kgd)=
<br>
-{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0return (struct radeon_device *)kgd;<br>
-}<br>
-<br>
-static void write_register(struct kgd_dev *kgd, uint32_t offset, uint32_t =
value)<br>
-{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0struct radeon_device *rdev =3D get_radeon_devic=
e(kgd);<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0writel(value, (void __iomem *)(rdev-&gt;rmmio +=
 offset));<br>
-}<br>
-<br>
-static uint32_t read_register(struct kgd_dev *kgd, uint32_t offset)<br>
-{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0struct radeon_device *rdev =3D get_radeon_devic=
e(kgd);<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0return readl((void __iomem *)(rdev-&gt;rmmio + =
offset));<br>
-}<br>
-<br>
-static void lock_srbm(struct kgd_dev *kgd, uint32_t mec, uint32_t pipe,<br=
>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0uint32_t queue, uint32_t vmid)<br>
-{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0struct radeon_device *rdev =3D get_radeon_devic=
e(kgd);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t value =3D PIPEID(pipe) | MEID(mec) | V=
MID(vmid) | QUEUEID(queue);<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0mutex_lock(&amp;rdev-&gt;srbm_mutex)<wbr>;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0write_register(kgd, SRBM_GFX_CNTL, value);<br>
-}<br>
-<br>
-static void unlock_srbm(struct kgd_dev *kgd)<br>
-{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0struct radeon_device *rdev =3D get_radeon_devic=
e(kgd);<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0write_register(kgd, SRBM_GFX_CNTL, 0);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0mutex_unlock(&amp;rdev-&gt;srbm_mute<wbr>x);<br=
>
-}<br>
-<br>
-static void acquire_queue(struct kgd_dev *kgd, uint32_t pipe_id,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t queue_id)<br>
-{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t mec =3D (++pipe_id / CIK_PIPE_PER_MEC)=
 + 1;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t pipe =3D (pipe_id % CIK_PIPE_PER_MEC);=
<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0lock_srbm(kgd, mec, pipe, queue_id, 0);<br>
-}<br>
-<br>
-static void release_queue(struct kgd_dev *kgd)<br>
-{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0unlock_srbm(kgd);<br>
-}<br>
-<br>
-static void kgd_program_sh_mem_settings(st<wbr>ruct kgd_dev *kgd, uint32_t=
 vmid,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t =
sh_mem_config,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t =
sh_mem_ape1_base,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t =
sh_mem_ape1_limit,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t =
sh_mem_bases)<br>
-{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0lock_srbm(kgd, 0, 0, 0, vmid);<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0write_register(kgd, SH_MEM_CONFIG, sh_mem_confi=
g);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0write_register(kgd, SH_MEM_APE1_BASE, sh_mem_ap=
e1_base);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0write_register(kgd, SH_MEM_APE1_LIMIT, sh_mem_a=
pe1_limit);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0write_register(kgd, SH_MEM_BASES, sh_mem_bases)=
;<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0unlock_srbm(kgd);<br>
-}<br>
-<br>
-static int kgd_set_pasid_vmid_mapping(str<wbr>uct kgd_dev *kgd, unsigned i=
nt pasid,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned =
int vmid)<br>
-{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0/*<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 * We have to assume that there is no outstandi=
ng mapping.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 * The ATC_VMID_PASID_MAPPING_UPDATE_<wbr>STATU=
S bit could be 0<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 * because a mapping is in progress or because =
a mapping finished and<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 * the SW cleared it.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 * So the protocol is to always wait &amp; clea=
r.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t pasid_mapping =3D (pasid =3D=3D 0) ? 0=
 : (uint32_t)pasid |<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ATC_VMID_=
PASID_MAPPING_VALID_<wbr>MASK;<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0write_register(kgd, ATC_VMID0_PASID_MAPPING + v=
mid*sizeof(uint32_t),<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0pasid_mapping);<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0while (!(read_register(kgd, ATC_VMID_PASID_MAPP=
ING_UPDATE_<wbr>STATUS) &amp;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0(1U &lt;&lt; vmid)))<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cpu_relax();<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0write_register(kgd, ATC_VMID_PASID_MAPPING_UPDA=
TE_<wbr>STATUS, 1U &lt;&lt; vmid);<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0/* Mapping vmid to pasid also for IH block */<b=
r>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0write_register(kgd, IH_VMID_0_LUT + vmid * size=
of(uint32_t),<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0pasid_mapping);<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
-}<br>
-<br>
-static int kgd_init_pipeline(struct kgd_dev *kgd, uint32_t pipe_id,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t hpd_size, uint64_t hpd_gpu_a=
ddr)<br>
-{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0/* nothing to do here */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
-}<br>
-<br>
-static int kgd_init_interrupts(struct kgd_dev *kgd, uint32_t pipe_id)<br>
-{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t mec;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t pipe;<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0mec =3D (pipe_id / CIK_PIPE_PER_MEC) + 1;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0pipe =3D (pipe_id % CIK_PIPE_PER_MEC);<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0lock_srbm(kgd, mec, pipe, 0, 0);<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0write_register(kgd, CPC_INT_CNTL,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0TIME_STAMP_INT_ENABLE | OPCODE_ERROR_INT_ENABLE);<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0unlock_srbm(kgd);<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
-}<br>
-<br>
-static inline uint32_t get_sdma_base_addr(struct cik_sdma_rlc_registers *m=
)<br>
-{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t retval;<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0retval =3D m-&gt;sdma_engine_id * SDMA1_REGISTE=
R_OFFSET +<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0m-&gt;sdma_queue_id * KFD_CIK_SDMA_QUEUE_OFFSET;<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0pr_debug(&quot;kfd: sdma base address: 0x%x\n&q=
uot;, retval);<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0return retval;<br>
-}<br>
-<br>
-static inline struct cik_mqd *get_mqd(void *mqd)<br>
-{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0return (struct cik_mqd *)mqd;<br>
-}<br>
-<br>
-static inline struct cik_sdma_rlc_registers *get_sdma_mqd(void *mqd)<br>
-{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0return (struct cik_sdma_rlc_registers *)mqd;<br=
>
-}<br>
-<br>
-static int kgd_hqd_load(struct kgd_dev *kgd, void *mqd, uint32_t pipe_id,<=
br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0uint32_t queue_id, uint32_t __user *wptr,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0uint32_t wptr_shift, uint32_t wptr_mask,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0struct mm_struct *mm)<br>
-{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t wptr_shadow, is_wptr_shadow_valid;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0struct cik_mqd *m;<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0m =3D get_mqd(mqd);<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0is_wptr_shadow_valid =3D !get_user(wptr_shadow,=
 wptr);<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0acquire_queue(kgd, pipe_id, queue_id);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0write_register(kgd, CP_MQD_BASE_ADDR, m-&gt;cp_=
mqd_base_addr_lo);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0write_register(kgd, CP_MQD_BASE_ADDR_HI, m-&gt;=
cp_mqd_base_addr_hi);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0write_register(kgd, CP_MQD_CONTROL, m-&gt;cp_mq=
d_control);<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0write_register(kgd, CP_HQD_PQ_BASE, m-&gt;cp_hq=
d_pq_base_lo);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0write_register(kgd, CP_HQD_PQ_BASE_HI, m-&gt;cp=
_hqd_pq_base_hi);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0write_register(kgd, CP_HQD_PQ_CONTROL, m-&gt;cp=
_hqd_pq_control);<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0write_register(kgd, CP_HQD_IB_CONTROL, m-&gt;cp=
_hqd_ib_control);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0write_register(kgd, CP_HQD_IB_BASE_ADDR, m-&gt;=
cp_hqd_ib_base_addr_lo);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0write_register(kgd, CP_HQD_IB_BASE_ADDR_HI, m-&=
gt;cp_hqd_ib_base_addr_hi);<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0write_register(kgd, CP_HQD_IB_RPTR, m-&gt;cp_hq=
d_ib_rptr);<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0write_register(kgd, CP_HQD_PERSISTENT_STATE,<br=
>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0m-&gt;cp_hqd_persistent_state);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0write_register(kgd, CP_HQD_SEMA_CMD, m-&gt;cp_h=
qd_sema_cmd);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0write_register(kgd, CP_HQD_MSG_TYPE, m-&gt;cp_h=
qd_msg_type);<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0write_register(kgd, CP_HQD_ATOMIC0_PREOP_LO,<br=
>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0m-&gt;cp_hqd_atomic0_preop_lo);<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0write_register(kgd, CP_HQD_ATOMIC0_PREOP_HI,<br=
>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0m-&gt;cp_hqd_atomic0_preop_hi);<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0write_register(kgd, CP_HQD_ATOMIC1_PREOP_LO,<br=
>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0m-&gt;cp_hqd_atomic1_preop_lo);<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0write_register(kgd, CP_HQD_ATOMIC1_PREOP_HI,<br=
>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0m-&gt;cp_hqd_atomic1_preop_hi);<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0write_register(kgd, CP_HQD_PQ_RPTR_REPORT_ADDR,=
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0m-&gt;cp_hqd_pq_rptr_report_<wbr>addr_lo);<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0write_register(kgd, CP_HQD_PQ_RPTR_REPORT_ADDR_=
HI,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0m-&gt;cp_hqd_pq_rptr_report_<wbr>addr_hi);<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0write_register(kgd, CP_HQD_PQ_RPTR, m-&gt;cp_hq=
d_pq_rptr);<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0write_register(kgd, CP_HQD_PQ_WPTR_POLL_ADDR,<b=
r>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0m-&gt;cp_hqd_pq_wptr_poll_addr_l<wbr>o);<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0write_register(kgd, CP_HQD_PQ_WPTR_POLL_ADDR_HI=
,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0m-&gt;cp_hqd_pq_wptr_poll_addr_h<wbr>i);<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0write_register(kgd, CP_HQD_PQ_DOORBELL_CONTROL,=
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0m-&gt;cp_hqd_pq_doorbell_<wbr>control);<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0write_register(kgd, CP_HQD_VMID, m-&gt;cp_hqd_v=
mid);<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0write_register(kgd, CP_HQD_QUANTUM, m-&gt;cp_hq=
d_quantum);<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0write_register(kgd, CP_HQD_PIPE_PRIORITY, m-&gt=
;cp_hqd_pipe_priority);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0write_register(kgd, CP_HQD_QUEUE_PRIORITY, m-&g=
t;cp_hqd_queue_priority);<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0write_register(kgd, CP_HQD_IQ_RPTR, m-&gt;cp_hq=
d_iq_rptr);<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (is_wptr_shadow_valid)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0write_register(kgd,=
 CP_HQD_PQ_WPTR, wptr_shadow);<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0write_register(kgd, CP_HQD_ACTIVE, m-&gt;cp_hqd=
_active);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0release_queue(kgd);<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
-}<br>
-<br>
-static int kgd_hqd_sdma_load(struct kgd_dev *kgd, void *mqd)<br>
-{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0struct cik_sdma_rlc_registers *m;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t sdma_base_addr;<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0m =3D get_sdma_mqd(mqd);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0sdma_base_addr =3D get_sdma_base_addr(m);<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0write_register(kgd,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0sdma_base_addr + SDMA0_RLC0_VIRTUAL_ADDR,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0m-&gt;sdma_rlc_virtual_addr);<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0write_register(kgd,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0sdma_base_addr + SDMA0_RLC0_RB_BASE,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0m-&gt;sdma_rlc_rb_base);<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0write_register(kgd,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0sdma_base_addr + SDMA0_RLC0_RB_BASE_HI,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0m-&gt;sdma_rlc_rb_base_hi);<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0write_register(kgd,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0sdma_base_addr + SDMA0_RLC0_RB_RPTR_ADDR_LO,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0m-&gt;sdma_rlc_rb_rptr_addr_lo);<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0write_register(kgd,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0sdma_base_addr + SDMA0_RLC0_RB_RPTR_ADDR_HI,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0m-&gt;sdma_rlc_rb_rptr_addr_hi);<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0write_register(kgd,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0sdma_base_addr + SDMA0_RLC0_DOORBELL,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0m-&gt;sdma_rlc_doorbell);<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0write_register(kgd,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0sdma_base_addr + SDMA0_RLC0_RB_CNTL,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0m-&gt;sdma_rlc_rb_cntl);<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
-}<br>
-<br>
-static bool kgd_hqd_is_occupied(struct kgd_dev *kgd, uint64_t queue_addres=
s,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t pipe_id, uint32_t queue_id)<=
br>
-{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t act;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0bool retval =3D false;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t low, high;<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0acquire_queue(kgd, pipe_id, queue_id);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0act =3D read_register(kgd, CP_HQD_ACTIVE);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (act) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0low =3D lower_32_bi=
ts(queue_address &gt;&gt; 8);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0high =3D upper_32_b=
its(queue_address &gt;&gt; 8);<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (low =3D=3D read=
_register(kgd, CP_HQD_PQ_BASE) &amp;&amp;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0high =3D=3D read_register(kgd, CP_HQD=
_PQ_BASE_HI))<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0retval =3D true;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0release_queue(kgd);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0return retval;<br>
-}<br>
-<br>
-static bool kgd_hqd_sdma_is_occupied(struc<wbr>t kgd_dev *kgd, void *mqd)<=
br>
-{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0struct cik_sdma_rlc_registers *m;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t sdma_base_addr;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t sdma_rlc_rb_cntl;<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0m =3D get_sdma_mqd(mqd);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0sdma_base_addr =3D get_sdma_base_addr(m);<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0sdma_rlc_rb_cntl =3D read_register(kgd,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sdma_base=
_addr + SDMA0_RLC0_RB_CNTL);<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (sdma_rlc_rb_cntl &amp; SDMA_RB_ENABLE)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return true;<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0return false;<br>
-}<br>
-<br>
-static int kgd_hqd_destroy(struct kgd_dev *kgd, void *mqd, uint32_t reset_=
type,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int timeout, uint32_t pipe_i=
d,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t queue_id)<br>
-{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t temp;<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0acquire_queue(kgd, pipe_id, queue_id);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0write_register(kgd, CP_HQD_PQ_DOORBELL_CONTROL,=
 0);<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0write_register(kgd, CP_HQD_DEQUEUE_REQUEST, res=
et_type);<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0while (true) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0temp =3D read_regis=
ter(kgd, CP_HQD_ACTIVE);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (temp &amp; 0x1)=
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0break;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (timeout =3D=3D =
0) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0pr_err(&quot;kfd: cp queue preemption time out (%dms)\n&quot;,<br=
>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0temp);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0release_queue(kgd);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0return -ETIME;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0msleep(20);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0timeout -=3D 20;<br=
>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0release_queue(kgd);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
-}<br>
-<br>
-static int kgd_hqd_sdma_destroy(struct kgd_dev *kgd, void *mqd,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int timeout)<br>
-{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0struct cik_sdma_rlc_registers *m;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t sdma_base_addr;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t temp;<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0m =3D get_sdma_mqd(mqd);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0sdma_base_addr =3D get_sdma_base_addr(m);<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0temp =3D read_register(kgd, sdma_base_addr + SD=
MA0_RLC0_RB_CNTL);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0temp =3D temp &amp; ~SDMA_RB_ENABLE;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0write_register(kgd, sdma_base_addr + SDMA0_RLC0=
_RB_CNTL, temp);<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0while (true) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0temp =3D read_regis=
ter(kgd, sdma_base_addr +<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0SDMA0_RLC0_CONTEXT_STATUS);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (temp &amp; SDMA=
_RLC_IDLE)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0break;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (timeout =3D=3D =
0)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0return -ETIME;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0msleep(20);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0timeout -=3D 20;<br=
>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0write_register(kgd, sdma_base_addr + SDMA0_RLC0=
_DOORBELL, 0);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0write_register(kgd, sdma_base_addr + SDMA0_RLC0=
_RB_RPTR, 0);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0write_register(kgd, sdma_base_addr + SDMA0_RLC0=
_RB_WPTR, 0);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0write_register(kgd, sdma_base_addr + SDMA0_RLC0=
_RB_BASE, 0);<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
-}<br>
-<br>
-static int kgd_address_watch_disable(stru<wbr>ct kgd_dev *kgd)<br>
-{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0union TCP_WATCH_CNTL_BITS cntl;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int i;<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0cntl.u32All =3D 0;<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0cntl.bitfields.valid =3D 0;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0cntl.bitfields.mask =3D ADDRESS_WATCH_REG_CNTL_=
DEFAULT<wbr>_MASK;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0cntl.bitfields.atc =3D 1;<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0/* Turning off this address until we set all th=
e registers */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0for (i =3D 0; i &lt; MAX_WATCH_ADDRESSES; i++)<=
br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0write_register(kgd,=
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0watchRegs[i * ADDRESS_WATCH_REG_MAX +=
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ADDRESS_W=
ATCH_REG_CNTL],<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cntl.u32All);<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
-}<br>
-<br>
-static int kgd_address_watch_execute(stru<wbr>ct kgd_dev *kgd,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned =
int watch_point_id,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t =
cntl_val,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t =
addr_hi,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t =
addr_lo)<br>
-{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0union TCP_WATCH_CNTL_BITS cntl;<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0cntl.u32All =3D cntl_val;<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0/* Turning off this watch point until we set al=
l the registers */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0cntl.bitfields.valid =3D 0;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0write_register(kgd,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0watchRegs[watch_point_id * ADDRESS_WATCH_REG_MAX +<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ADDRESS_WATCH_REG_CNTL],<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0cntl.u32All);<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0write_register(kgd,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0watchRegs[watch_point_id * ADDRESS_WATCH_REG_MAX +<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ADDRESS_WATCH_REG_ADDR_HI],<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0addr_hi);<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0write_register(kgd,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0watchRegs[watch_point_id * ADDRESS_WATCH_REG_MAX +<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ADDRESS_WATCH_REG_ADDR_LO],<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0addr_lo);<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0/* Enable the watch point */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0cntl.bitfields.valid =3D 1;<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0write_register(kgd,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0watchRegs[watch_point_id * ADDRESS_WATCH_REG_MAX +<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ADDRESS_WATCH_REG_CNTL],<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0cntl.u32All);<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
-}<br>
-<br>
-static int kgd_wave_control_execute(struc<wbr>t kgd_dev *kgd,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t =
gfx_index_val,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t =
sq_cmd)<br>
-{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0struct radeon_device *rdev =3D get_radeon_devic=
e(kgd);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t data;<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0mutex_lock(&amp;rdev-&gt;grbm_idx_mu<wbr>tex);<=
br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0write_register(kgd, GRBM_GFX_INDEX, gfx_index_v=
al);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0write_register(kgd, SQ_CMD, sq_cmd);<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0/*=C2=A0 Restore the GRBM_GFX_INDEX register=C2=
=A0 */<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0data =3D INSTANCE_BROADCAST_WRITES | SH_BROADCA=
ST_WRITES |<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0SE_BROADCAST_WRITES=
;<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0write_register(kgd, GRBM_GFX_INDEX, data);<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0mutex_unlock(&amp;rdev-&gt;grbm_idx_<wbr>mutex)=
;<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
-}<br>
-<br>
-static uint32_t kgd_address_watch_get_offset(s<wbr>truct kgd_dev *kgd,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned =
int watch_point_id,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned =
int reg_offset)<br>
-{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0return watchRegs[watch_point_id * ADDRESS_WATCH=
_REG_MAX + reg_offset]<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/ 4;<br>
-}<br>
-<br>
-static bool get_atc_vmid_pasid_mapping_val<wbr>id(struct kgd_dev *kgd, uin=
t8_t vmid)<br>
-{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t reg;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0struct radeon_device *rdev =3D (struct radeon_d=
evice *) kgd;<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0reg =3D RREG32(ATC_VMID0_PASID_MAPPING + vmid*4=
);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0return reg &amp; ATC_VMID_PASID_MAPPING_VALID_M=
<wbr>ASK;<br>
-}<br>
-<br>
-static uint16_t get_atc_vmid_pasid_mapping_pas<wbr>id(struct kgd_dev *kgd,=
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint8_t vmid)<br>
-{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t reg;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0struct radeon_device *rdev =3D (struct radeon_d=
evice *) kgd;<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0reg =3D RREG32(ATC_VMID0_PASID_MAPPING + vmid*4=
);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0return reg &amp; ATC_VMID_PASID_MAPPING_PASID_M=
<wbr>ASK;<br>
-}<br>
-<br>
-static void write_vmid_invalidate_request(<wbr>struct kgd_dev *kgd, uint8_=
t vmid)<br>
-{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0struct radeon_device *rdev =3D (struct radeon_d=
evice *) kgd;<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0return WREG32(VM_INVALIDATE_REQUEST, 1 &lt;&lt;=
 vmid);<br>
-}<br>
-<br>
-static uint16_t get_fw_version(struct kgd_dev *kgd, enum kgd_engine_type t=
ype)<br>
-{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0struct radeon_device *rdev =3D (struct radeon_d=
evice *) kgd;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0const union radeon_firmware_header *hdr;<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0BUG_ON(kgd =3D=3D NULL || rdev-&gt;mec_fw =3D=
=3D NULL);<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0switch (type) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0case KGD_ENGINE_PFP:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0hdr =3D (const unio=
n radeon_firmware_header *) rdev-&gt;pfp_fw-&gt;data;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0case KGD_ENGINE_ME:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0hdr =3D (const unio=
n radeon_firmware_header *) rdev-&gt;me_fw-&gt;data;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0case KGD_ENGINE_CE:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0hdr =3D (const unio=
n radeon_firmware_header *) rdev-&gt;ce_fw-&gt;data;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0case KGD_ENGINE_MEC1:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0hdr =3D (const unio=
n radeon_firmware_header *) rdev-&gt;mec_fw-&gt;data;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0case KGD_ENGINE_MEC2:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0hdr =3D (const unio=
n radeon_firmware_header *)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rdev-&gt;mec2_fw-&gt;data;<=
br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0case KGD_ENGINE_RLC:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0hdr =3D (const unio=
n radeon_firmware_header *) rdev-&gt;rlc_fw-&gt;data;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0case KGD_ENGINE_SDMA1:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0case KGD_ENGINE_SDMA2:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0hdr =3D (const unio=
n radeon_firmware_header *)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rdev-&gt;sdma_fw-&gt;data;<=
br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0default:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (hdr =3D=3D NULL)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0/* Only 12 bit in use*/<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0return hdr-&gt;common.ucode_version;<br>
-}<br>
diff --git a/drivers/gpu/drm/radeon/radeo<wbr>n_kfd.h b/drivers/gpu/drm/rad=
eon/radeo<wbr>n_kfd.h<br>
deleted file mode 100644<br>
index 9df1fea..0000000<br>
--- a/drivers/gpu/drm/radeon/radeo<wbr>n_kfd.h<br>
+++ /dev/null<br>
@@ -1,47 +0,0 @@<br>
-/*<br>
- * Copyright 2014 Advanced Micro Devices, Inc.<br>
- *<br>
- * Permission is hereby granted, free of charge, to any person obtaining a=
<br>
- * copy of this software and associated documentation files (the &quot;Sof=
tware&quot;),<br>
- * to deal in the Software without restriction, including without limitati=
on<br>
- * the rights to use, copy, modify, merge, publish, distribute, sublicense=
,<br>
- * and/or sell copies of the Software, and to permit persons to whom the<b=
r>
- * Software is furnished to do so, subject to the following conditions:<br=
>
- *<br>
- * The above copyright notice and this permission notice shall be included=
 in<br>
- * all copies or substantial portions of the Software.<br>
- *<br>
- * THE SOFTWARE IS PROVIDED &quot;AS IS&quot;, WITHOUT WARRANTY OF ANY KIN=
D, EXPRESS OR<br>
- * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY=
,<br>
- * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.=C2=A0 IN NO EVENT=
 SHALL<br>
- * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES O=
R<br>
- * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,<b=
r>
- * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR<b=
r>
- * OTHER DEALINGS IN THE SOFTWARE.<br>
- */<br>
-<br>
-/*<br>
- * radeon_kfd.h defines the private interface between the<br>
- * AMD kernel graphics drivers and the AMD KFD.<br>
- */<br>
-<br>
-#ifndef RADEON_KFD_H_INCLUDED<br>
-#define RADEON_KFD_H_INCLUDED<br>
-<br>
-#include &lt;linux/types.h&gt;<br>
-#include &quot;kgd_kfd_interface.h&quot;<br>
-<br>
-struct radeon_device;<br>
-<br>
-int radeon_kfd_init(void);<br>
-void radeon_kfd_fini(void);<br>
-<br>
-void radeon_kfd_suspend(struct radeon_device *rdev);<br>
-int radeon_kfd_resume(struct radeon_device *rdev);<br>
-void radeon_kfd_interrupt(struct radeon_device *rdev,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0const void *ih_ring_entry);<br>
-void radeon_kfd_device_probe(struct radeon_device *rdev);<br>
-void radeon_kfd_device_init(struct radeon_device *rdev);<br>
-void radeon_kfd_device_fini(struct radeon_device *rdev);<br>
-<br>
-#endif /* RADEON_KFD_H_INCLUDED */<br>
diff --git a/drivers/gpu/drm/radeon/radeo<wbr>n_kms.c b/drivers/gpu/drm/rad=
eon/radeo<wbr>n_kms.c<br>
index dfee8f7..cde037f 100644<br>
--- a/drivers/gpu/drm/radeon/radeo<wbr>n_kms.c<br>
+++ b/drivers/gpu/drm/radeon/radeo<wbr>n_kms.c<br>
@@ -34,8 +34,6 @@<br>
=C2=A0 #include &lt;linux/slab.h&gt;<br>
=C2=A0 #include &lt;linux/pm_runtime.h&gt;<br>
<br>
-#include &quot;radeon_kfd.h&quot;<br>
-<br>
=C2=A0 #if defined(CONFIG_VGA_SWITCHEROO)<br>
=C2=A0 bool radeon_has_atpx(void);<br>
=C2=A0 #else<br>
@@ -68,8 +66,6 @@ void radeon_driver_unload_kms(struc<wbr>t drm_device *dev=
)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pm_runtime_fo=
rbid(dev-&gt;dev);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0radeon_kfd_device_fini(rdev);<br>
-<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0radeon_acpi_fini(rdev);<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0radeon_modeset_fini(rdev);<br>
@@ -174,9 +170,6 @@ int radeon_driver_load_kms(struct drm_device *dev, unsi=
gned long flags)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;Error during ACPI method=
s call\n&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0radeon_kfd_device_probe(rdev)<wbr>;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0radeon_kfd_device_init(rdev);<br>
-<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (radeon_is_px(dev)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pm_runtime_us=
e_autosuspend(de<wbr>v-&gt;dev);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pm_runtime_se=
t_autosuspend_de<wbr>lay(dev-&gt;dev, 5000);<br>
--<br>
2.7.4<br>
<br>
______________________________<wbr>_________________<br>
amd-gfx mailing list<br>
<a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" target=3D"_blank">amd-gfx@=
lists.freedesktop.org</a><br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" rel=3D"n=
oreferrer" target=3D"_blank">https://lists.freedesktop.org/<wbr>mailman/lis=
tinfo/amd-gfx</a><br>
</blockquote>
______________________________<wbr>_________________<br>
amd-gfx mailing list<br>
<a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" target=3D"_blank">amd-gfx@=
lists.freedesktop.org</a><br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" rel=3D"n=
oreferrer" target=3D"_blank">https://lists.freedesktop.org/<wbr>mailman/lis=
tinfo/amd-gfx</a><br>
</blockquote>
<br>
<br>
</div></div></blockquote></div><br></div>

--001a114551d8dab128055ce7b5a9--

--===============0148892310==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0148892310==--
