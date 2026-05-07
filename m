Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0348ACD3439
	for <amd-gfx@archiver.kernel.org>; Thu,  7 May 2026 15:05:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B33C10E036;
	Thu,  7 May 2026 15:05:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ierdXCmG";
	dkim-atps=neutral
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com
 [74.125.82.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 13A6710E036
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 May 2026 15:05:41 +0000 (UTC)
Received: by mail-dy1-f177.google.com with SMTP id
 5a478bee46e88-2f114d129c0so73382eec.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 07 May 2026 08:05:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778166340; cv=none;
 d=google.com; s=arc-20240605;
 b=GGmz49L1fBs5xiv2T6yUi0XRr1PWT62q5gyjWpsJLmsbSy17pmZ5yoSilyD78VchXg
 YYdhSnD+2sk5yHqlX8/KiLEVLwKX7aHx/7tjfocyLI8q2zzXbnYQKYXMm7lrRhJHFnAO
 nvIBEEQg9mCzHFCVplUoxaA7qLZAQ2lYtml6je9emZsa4IT9r11XJF5Ssa94uZH5xv8T
 /nJRiy4dEVU0toTQMz4sv+H1n6M+LDWAWPJkcLtnNBDxDnYN11iEhuwocBwFmEHVFi0C
 Reb0Q/S/y2ab1941pBqY7EpsJ/2C35Las2twYaQLxK+mh2YJRK982YF5VRcCkgTBhHNx
 lY1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=PsH8VqDWzZPK7yTjCv/ij1jc5NmqkmBDnHjehs27bfo=;
 fh=iTMj5WIaNh+mRRQuOoTZX6ZVyyfkVHvCGltwIUKcskY=;
 b=HIek5jzGrM/li1h0dfDOHlzVLAslUvriHh5RlJU+UrhWkTxI5ZG6ZtvCPtPShvSLp7
 NJ9TEo472pjI0EvqHd7gpTKaSylcsKxwfVlT47taRVMtfqS7vMz3Pw7Ar0h6Kj4MCdrV
 huLSgtoCJGdmZykeSdP0E1U3MG2VMZXiQtsSAriTEU9AadLFSPb7K1LiqQtnKSqDshGP
 dvN+G1n93m1mPsATzdq2KX2nQZiL7e3Ij5Uw3atA3mOLp5m0W8W2GC7wMCJp/8pOVO6W
 nwAPkEN+HlTdtzMxQJC52pdGkKJ6897qFI/ri+e6IOzpwsoOieJaJUGU07ZqmNax6xIv
 5rRA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778166340; x=1778771140; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PsH8VqDWzZPK7yTjCv/ij1jc5NmqkmBDnHjehs27bfo=;
 b=ierdXCmG49Iw2h3WuaR6fYeCWobmJXJMbccXzah0WY3ytsQ/k1atKZxvq1wQvYnxaC
 N3h64NMOEGgsdBt5oQ0k6y9FIcz2Y16wRjnPE1RtVIJgyErY/bEXpbBT/dji+Fd5az8W
 Ff559HIE7QIZ2ENvx5ZNqLN30iPAq7hyzY3GPRGScNvUwvaoItiWucEzsuHzEluaW9Dr
 qGXXSJGpmM+O2/d/c+5WMtzVVE5FcwPUkndb0Iv5zbez5J67D/L1BjSz1lLYJGtX/eDp
 zRVrWwpP+Np+A0TBV+ZwG3yFF/KowOTJVzr1h5YJwtlIsyGx1JNOker37Nr0Xy6HDY7l
 N8Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778166340; x=1778771140;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PsH8VqDWzZPK7yTjCv/ij1jc5NmqkmBDnHjehs27bfo=;
 b=Bb6P0OdjKGWS3s01rdcsOwZ3Pc4kpRfbbrVUMBnAnwirk0F1ByboCHyF87ZgTBkODB
 fr70+l8Z6zfX1yDQjXClCfz0tl8B+9GFHnbG487H4xV8AQnjv9Mtd5TjJ/pB/bb1XoSt
 +nvUNBHI0O9mi9Ytim3UZKrfeuqVVLmnLR6a8VQTxkXszDcn8o3Ccp7DYydoqObmYik9
 JNR9zGjnLaK10eCRRmxfr2wls09vzm5qAPnA6MVOChWr8CSgYQJD3MzYeMEoW5fjyWf3
 haIzwQ5qpcNxMZbJq3+41WDvbTw1AfX3lCjSj9ExzzdOv3ge9z+dlvnPVcBDc9fFQp7P
 tOlQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+pXw3ySQZbJNA2HfFdeQQUk7pcj358d7OFhwxqT8Ff1AO2HtE7825q8t30B/rdgp+jyqSqmuw2@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxvZLYQy/PSoYHifRWzS+eFuB5lYPFATarRm8iMBbhLuPJfNBuF
 ot2QMN2cXYd3S49W95sGO1cPYWNmnq6ncJRcIXsE0WHCNdUeHKQUi1Vc6a4msaiHKZvX0SHf6DR
 5ix7biPZZONE46FvwRaDdwgSxwsUECYAwSw==
X-Gm-Gg: AeBDieugzHR8XXdghjG2OEkI+IZ23zQPiThUtyywQqTiEy+ZP2dligq27cfmvU+InyH
 1Mvktg7NP6ldH50pPO5ymH/SJ/KVvpeeBd31+rUYAUS/hnO1lsUoO9JNZp33VglLm430lDtUtqh
 OLmuSCg+yxTERydajmAjIQ0x9XHCVGjGOd6bhxBdoBRqhzsRS0F2e02lohud6MB64kxRh7fOxGR
 6RKtsfuWtTpFwgIE9UhAbmTTAl5pNhUooMWtrMbvf2P7hMKRCB7qYnHRv5p/O54yDteIhf5GK5k
 yQmzwQT8u8dyLLO17UK7kjpexJnZvO4nc/Z+SgICmA5iVaJFUBjiADUQSjElrc4ZCZ3+ubkWiVD
 XixIp
X-Received: by 2002:a05:7301:1296:b0:2c4:ec89:bdb with SMTP id
 5a478bee46e88-2f59ce946c2mr1470161eec.2.1778166339682; Thu, 07 May 2026
 08:05:39 -0700 (PDT)
MIME-Version: 1.0
References: <20260507140934.1001909-1-yifan1.zhang@amd.com>
 <d1e60cfa-2e93-48ff-9af6-72366aba7e06@amd.com>
In-Reply-To: <d1e60cfa-2e93-48ff-9af6-72366aba7e06@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 7 May 2026 11:05:27 -0400
X-Gm-Features: AVHnY4K2KgMLSu_hgUqmRLjxZ9Xz21k5NP4DLuc8D8a6BRp8DoBoHT-uQE2QwRQ
Message-ID: <CADnq5_P=UYFyxiFaxj2YQdfyaJCSYhHHT9shk4LxfPa+XMV-7Q@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: unmap all user mappings of framebuffer and
 doorbell before mode1 reset
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Yifan Zhang <yifan1.zhang@amd.com>, amd-gfx@lists.freedesktop.org, 
 "Kuehling, Felix" <Felix.Kuehling@amd.com>, Philipp Stanner <phasta@kernel.org>,
 "Honglei1.Huang@amd.com" <honghuan@amd.com>, Alexander.Deucher@amd.com,
 Perry.Yuan@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, May 7, 2026 at 10:54=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> On 5/7/26 16:09, Yifan Zhang wrote:
> > During Mode 1 reset, the ASIC undergoes a reset cycle and becomes tempo=
rarily
> > inaccessible via PCIe. Any attempt to access framebuffer or MMIO regist=
ers during
> > this window can result in uncompleted PCIe transactions, leading to NMI=
 panics or
> > system hangs.
> >
> > To prevent this, Unmap all of the applications mappings of the framebuf=
fer
> > and doorbell BARs before mode1 reset. Also prevent new mappings from co=
ming in
> > during the reset process.
>
> I think putting the inode into the kfd_dev would break userspace, so that=
 is a no-go and needs a different solution.
>
> But apart from that the patch looks like what I suggested before.
>
> Question is since when does that issue exists? Previously we didn't had t=
o take care of that.

It's always existed, I guess generally there are not often CPU
accesses to VRAM during a reset.  It depends on the platform and what
level of PCIe error handling it enables.

Alex

>
> Regards,
> Christian.
>
> >
> > Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h      |  1 +
> >  .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c    | 12 ++++++++++++
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c      |  7 ++++++-
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c         | 17 +++++++++++++++--
> >  drivers/gpu/drm/amd/amdkfd/kfd_chardev.c        | 10 ++++++++++
> >  drivers/gpu/drm/amd/amdkfd/kfd_priv.h           |  3 +++
> >  6 files changed, 47 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_amdkfd.h
> > index 2bf6a31c194d..5333e052d56d 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> > @@ -360,6 +360,7 @@ int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_d=
evice *adev,
> >               uint64_t size, u32 alloc_flag, int8_t xcp_id);
> >  void amdgpu_amdkfd_unreserve_mem_limit(struct amdgpu_device *adev,
> >               uint64_t size, u32 alloc_flag, int8_t xcp_id);
> > +void amdgpu_amdkfd_clear_kfd_mapping(struct amdgpu_device *adev);
> >
> >  u64 amdgpu_amdkfd_xcp_memory_size(struct amdgpu_device *adev, int xcp_=
id);
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers=
/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> > index 7c01492e69dd..3ac2bd86c08b 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> > @@ -139,6 +139,18 @@ void amdgpu_amdkfd_reserve_system_mem(uint64_t siz=
e)
> >       kfd_mem_limit.system_mem_used +=3D size;
> >  }
> >
> > +void amdgpu_amdkfd_clear_kfd_mapping(struct amdgpu_device *adev)
> > +{
> > +     if (adev->kfd.dev && adev->kfd.dev->inode &&
> > +             adev->kfd.dev->inode->i_mapping) {
> > +             unmap_mapping_range(adev->kfd.dev->inode->i_mapping,
> > +                     KFD_MMAP_TYPE_DOORBELL, kfd_doorbell_process_slic=
e(adev->kfd.dev), 1);
> > +             unmap_mapping_range(adev->kfd.dev->inode->i_mapping,
> > +                     KFD_MMAP_TYPE_MMIO, PAGE_SIZE, 1);
> > +     }
> > +}
> > +
> > +
> >  /* Estimate page table size needed to represent a given memory size
> >   *
> >   * With 4KB pages, we need one 8 byte PTE for each 4KB of memory
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_device.c
> > index 073f632f295a..c67936d1fb0d 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > @@ -5019,7 +5019,6 @@ int amdgpu_device_mode1_reset(struct amdgpu_devic=
e *adev)
> >
> >       /* disable BM */
> >       pci_clear_master(adev->pdev);
> > -
> >       if (amdgpu_dpm_is_mode1_reset_supported(adev)) {
> >               dev_info(adev->dev, "GPU smu mode1 reset\n");
> >               ret =3D amdgpu_dpm_mode1_reset(adev);
> > @@ -5840,6 +5839,12 @@ int amdgpu_device_gpu_recover(struct amdgpu_devi=
ce *adev,
> >       /* We need to lock reset domain only once both for XGMI and singl=
e device */
> >       amdgpu_device_recovery_get_reset_lock(adev, &device_list);
> >
> > +     /* unmap all the mappings of doorbell and framebuffer to prevent =
user space from
> > +      * accessing them
> > +      */
> > +     unmap_mapping_range(adev->ddev.anon_inode->i_mapping, 0, 0, 1);
> > +     amdgpu_amdkfd_clear_kfd_mapping(adev);
> > +
> >       amdgpu_device_halt_activities(adev, job, reset_context, &device_l=
ist,
> >                                     hive, need_emergency_restart);
> >       if (need_emergency_restart)
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_gem.c
> > index 0071d6957828..1dd343f0219f 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> > @@ -46,6 +46,7 @@
> >  #include "amdgpu_hmm.h"
> >  #include "amdgpu_xgmi.h"
> >  #include "amdgpu_vm.h"
> > +#include "amdgpu_reset.h"
> >
> >  static int
> >  amdgpu_gem_add_input_fence(struct drm_file *filp,
> > @@ -118,13 +119,21 @@ amdgpu_gem_update_timeline_node(struct drm_file *=
filp,
> >  static vm_fault_t amdgpu_gem_fault(struct vm_fault *vmf)
> >  {
> >       struct ttm_buffer_object *bo =3D vmf->vma->vm_private_data;
> > +     struct amdgpu_device *adev =3D amdgpu_ttm_adev(bo->bdev);
> >       struct drm_device *ddev =3D bo->base.dev;
> >       vm_fault_t ret;
> >       int idx;
> >
> > +     /* Prevent new mappings from coming in during reset */
> > +
> > +     if (!down_read_trylock(&adev->reset_domain->sem))
> > +             return VM_FAULT_SIGSEGV;
> > +
> >       ret =3D ttm_bo_vm_reserve(bo, vmf);
> > -     if (ret)
> > +     if (ret) {
> > +             up_read(&adev->reset_domain->sem);
> >               return ret;
> > +     }
> >
> >       if (drm_dev_enter(ddev, &idx)) {
> >               ret =3D amdgpu_bo_fault_reserve_notify(bo);
> > @@ -140,11 +149,15 @@ static vm_fault_t amdgpu_gem_fault(struct vm_faul=
t *vmf)
> >       } else {
> >               ret =3D ttm_bo_vm_dummy_page(vmf, vmf->vma->vm_page_prot)=
;
> >       }
> > -     if (ret =3D=3D VM_FAULT_RETRY && !(vmf->flags & FAULT_FLAG_RETRY_=
NOWAIT))
> > +     if (ret =3D=3D VM_FAULT_RETRY && !(vmf->flags & FAULT_FLAG_RETRY_=
NOWAIT)) {
> > +             up_read(&adev->reset_domain->sem);
> >               return ret;
> > +     }
> >
> >  unlock:
> >       dma_resv_unlock(bo->base.resv);
> > +     up_read(&adev->reset_domain->sem);
> > +
> >       return ret;
> >  }
> >
> > diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm=
/amd/amdkfd/kfd_chardev.c
> > index 84b9bde7f371..d5bf5ba73ca0 100644
> > --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> > +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> > @@ -130,11 +130,21 @@ void kfd_chardev_exit(void)
> >  static int kfd_open(struct inode *inode, struct file *filep)
> >  {
> >       struct kfd_process *process;
> > +     struct kfd_node *node;
> >       bool is_32bit_user_mode;
> > +     int i;
> >
> >       if (iminor(inode) !=3D 0)
> >               return -ENODEV;
> >
> > +     /* Save inode in kfd_dev for unmap_mapping_range */
> > +     for (i =3D 0; kfd_topology_enum_kfd_devices(i, &node) =3D=3D 0; i=
++) {
> > +             if (node && node->kfd && !node->kfd->inode) {
> > +                     node->kfd->inode =3D inode;
> > +                     break;
> > +             }
> > +     }
> > +
> >       is_32bit_user_mode =3D in_compat_syscall();
> >
> >       if (is_32bit_user_mode) {
> > diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/am=
d/amdkfd/kfd_priv.h
> > index a6ff1db477f9..bfdd7d3bc7cb 100644
> > --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> > +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> > @@ -373,6 +373,9 @@ struct kfd_dev {
> >
> >       struct workqueue_struct *ih_wq;
> >
> > +     /* kfd inode */
> > +     struct inode *inode;
> > +
> >       /* Kernel doorbells for KFD device */
> >       struct amdgpu_bo *doorbells;
> >
>
