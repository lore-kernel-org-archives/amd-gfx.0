Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F8ECC7619A
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Mar 2023 20:54:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E1FDA10E059;
	Thu, 30 Mar 2023 20:54:53 +0000 (UTC)
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com
 [IPv6:2607:f8b0:4864:20::c2f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 18F6A10E059
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Mar 2023 20:54:53 +0000 (UTC)
Received: by mail-oo1-xc2f.google.com with SMTP id
 j4-20020a4adf44000000b0053e8b5524abso459859oou.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Mar 2023 13:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20210112; t=1680209692;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kOoOeP0ZTXO6lAB3+EoaAQ25WS1Xoly/Oyz2vl9YNkg=;
 b=p/js7yYdgdb/sTG5RCFAoGoSU+oZu5yxOqF5YmQXAsAR3gIcy/AXE4PWTe+Np7/5K6
 oyr5xJWsYah99lxAq102wyHrVo9JpfJtG5O1y38AJRRQhCNjcaVKbXkwOdl5Qll0LClS
 NKryJM0asHHzWiRXG0PzV7wXeXKxcXybh0/luDJ/P55uesREjHSULvDWx73nZj15dgKF
 Zkvo0fQz++m9s9lRkBZ4S0W/q5mcSOaJXzw0G+e3iWUxqYZfPZfRvjhXKMJqbCSTIkxH
 aOg1mcK5ooifOwWxrdJ+OyeXWCFr5y405BQznZD2k0PLZAVC2HFFEuD6YTrH0BcPVamp
 c/1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1680209692;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kOoOeP0ZTXO6lAB3+EoaAQ25WS1Xoly/Oyz2vl9YNkg=;
 b=E6vOFv99S3mmQXWfDVcJQ8pkxS+dbXPnYoYprKEmF+OE2CwSzFoCtHWgz+OkrYIRsQ
 yKF6lm1Ac4DOox57IIYnuW+Jvc7G6N/FOySZcJx1EVJ9NvcWUtPsPt3F8xhkFWEpdIz1
 ImzV1pb5Fpbhw+iH2v3eKub9JIKV53J24eng1GYUPypyQL6Cj4k3FwuE8Zwx+VGGE5qE
 HrEitavwx2Ql7gjTbwDytE1tfTBOzYqtBLErKE3w8oiflH3WJxrdNKdte0qydfZ8fY8V
 OwhaiVu3zNbXcQ7dF3pk/dJXjWlT3WdzLZNRlrY1fNRxfE8+vaHdHzYhvzOzHnBsPyvN
 JXvQ==
X-Gm-Message-State: AAQBX9fAXNjjzQ3OQfsgyGqQCNfYFvy5wCxJsx7shQVoR3mI2vHrtmZ0
 x22ObhwVjqzfFaZxQ5JaZj/BE0uzjmRgg/QV7RE=
X-Google-Smtp-Source: AKy350arwCWv0KPEbsSNAAQWBsjL+zjNFf2LtkiW7J/JQC8FcHEN3+NqhItu54dNBJbFniVJnZQaQGEc6xXXNEDAWrI=
X-Received: by 2002:a4a:a28a:0:b0:53f:136a:13d0 with SMTP id
 h10-20020a4aa28a000000b0053f136a13d0mr532310ool.0.1680209692086; Thu, 30 Mar
 2023 13:54:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230329154753.1261-1-shashank.sharma@amd.com>
 <20230329154753.1261-14-shashank.sharma@amd.com>
In-Reply-To: <20230329154753.1261-14-shashank.sharma@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 30 Mar 2023 16:54:41 -0400
Message-ID: <CADnq5_Ow4ehDKQEdkqndkXFq093-1k5GwPLAvurBzBb2ejvfjA@mail.gmail.com>
Subject: Re: [PATCH 13/16] drm/amdgpu: use doorbell manager for kfd process
 doorbells
To: Shashank Sharma <shashank.sharma@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Mukul Joshi <mukul.joshi@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>,
 Christian Koenig <christian.koenig@amd.com>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Mar 29, 2023 at 11:48=E2=80=AFAM Shashank Sharma
<shashank.sharma@amd.com> wrote:
>
> This patch:
> - adds a new doorbell manager object in kfd pdd structure.
> - allocates doorbells for a process while creating its pdd.
> - frees the doorbells with pdd destroy.
> - uses direct doorbell manager API for doorbell indexing.
> - removes previous calls to allocate process doorbells as
>   its not required anymore.
>
> PS: This patch ensures that we don't break the existing KFD
>     functionality, but now KFD userspace library must also
>     move to creating doorbell pages as AMDGPU GEM objects
>     using libdrm functions in userspace. The reference code
>     for the same is available with AMDGPU Usermode queue
>     libdrm MR. Once this is done, we will not need this
>     patch.
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian Koenig <christian.koenig@amd.com>
> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      | 13 ----
>  .../drm/amd/amdkfd/kfd_device_queue_manager.c | 16 ++---
>  drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c     | 59 +++++++++----------
>  drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  8 +--
>  drivers/gpu/drm/amd/amdkfd/kfd_process.c      | 26 ++++----
>  .../amd/amdkfd/kfd_process_queue_manager.c    | 16 ++---
>  6 files changed, 58 insertions(+), 80 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/a=
md/amdkfd/kfd_chardev.c
> index 6d291aa6386b..0e40756417e5 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -327,12 +327,6 @@ static int kfd_ioctl_create_queue(struct file *filep=
, struct kfd_process *p,
>                 goto err_bind_process;
>         }
>
> -       if (!pdd->doorbell_index &&
> -           kfd_alloc_process_doorbells(dev, &pdd->doorbell_index) < 0) {
> -               err =3D -ENOMEM;
> -               goto err_alloc_doorbells;
> -       }
> -
>         /* Starting with GFX11, wptr BOs must be mapped to GART for MES t=
o determine work
>          * on unmapped queues for usermode queue oversubscription (no agg=
regated doorbell)
>          */
> @@ -410,7 +404,6 @@ static int kfd_ioctl_create_queue(struct file *filep,=
 struct kfd_process *p,
>         if (wptr_bo)
>                 amdgpu_amdkfd_free_gtt_mem(dev->adev, wptr_bo);
>  err_wptr_map_gart:
> -err_alloc_doorbells:
>  err_bind_process:
>  err_pdd:
>         mutex_unlock(&p->mutex);
> @@ -2163,12 +2156,6 @@ static int criu_restore_devices(struct kfd_process=
 *p,
>                         ret =3D PTR_ERR(pdd);
>                         goto exit;
>                 }
> -
> -               if (!pdd->doorbell_index &&
> -                   kfd_alloc_process_doorbells(pdd->dev, &pdd->doorbell_=
index) < 0) {
> -                       ret =3D -ENOMEM;
> -                       goto exit;
> -               }
>         }
>
>         /*
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/driv=
ers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index ecb4c3abc629..5827db9b18a8 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -362,7 +362,7 @@ static int allocate_doorbell(struct qcm_process_devic=
e *qpd,
>                 /* For CP queues on SOC15 */
>                 if (restore_id) {
>                         /* make sure that ID is free  */
> -                       if (__test_and_set_bit(*restore_id, qpd->doorbell=
_bitmap))
> +                       if (__test_and_set_bit(*restore_id, qpd->proc_doo=
rbells.doorbell_bitmap))
>                                 return -EINVAL;
>
>                         q->doorbell_id =3D *restore_id;
> @@ -370,20 +370,20 @@ static int allocate_doorbell(struct qcm_process_dev=
ice *qpd,
>                         /* or reserve a free doorbell ID */
>                         unsigned int found;
>
> -                       found =3D find_first_zero_bit(qpd->doorbell_bitma=
p,
> -                                               KFD_MAX_NUM_OF_QUEUES_PER=
_PROCESS);
> +                       found =3D find_first_zero_bit(qpd->proc_doorbells=
.doorbell_bitmap,
> +                                                   KFD_MAX_NUM_OF_QUEUES=
_PER_PROCESS);
>                         if (found >=3D KFD_MAX_NUM_OF_QUEUES_PER_PROCESS)=
 {
>                                 pr_debug("No doorbells available");
>                                 return -EBUSY;
>                         }
> -                       set_bit(found, qpd->doorbell_bitmap);
> +                       set_bit(found, qpd->proc_doorbells.doorbell_bitma=
p);
>                         q->doorbell_id =3D found;
>                 }
>         }
>
> -       q->properties.doorbell_off =3D
> -               kfd_get_doorbell_dw_offset_in_bar(dev, qpd_to_pdd(qpd),
> -                                         q->doorbell_id);
> +       q->properties.doorbell_off =3D amdgpu_doorbell_index_on_bar(dev->=
adev,
> +                                                                 qpd->pr=
oc_doorbells.bo,
> +                                                                 q->door=
bell_id);
>         return 0;
>  }
>
> @@ -398,7 +398,7 @@ static void deallocate_doorbell(struct qcm_process_de=
vice *qpd,
>             q->properties.type =3D=3D KFD_QUEUE_TYPE_SDMA_XGMI)
>                 return;
>
> -       old =3D test_and_clear_bit(q->doorbell_id, qpd->doorbell_bitmap);
> +       old =3D test_and_clear_bit(q->doorbell_id, qpd->proc_doorbells.do=
orbell_bitmap);
>         WARN_ON(!old);
>  }
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c b/drivers/gpu/drm/=
amd/amdkfd/kfd_doorbell.c
> index df259f2cc58a..7d29653bff81 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c
> @@ -228,46 +228,41 @@ uint64_t kfd_get_number_elems(struct kfd_dev *kfd)
>
>  phys_addr_t kfd_get_process_doorbells(struct kfd_process_device *pdd)
>  {
> -       if (!pdd->doorbell_index) {
> -               int r =3D kfd_alloc_process_doorbells(pdd->dev,
> -                                                   &pdd->doorbell_index)=
;
> -               if (r < 0)
> -                       return 0;
> -       }
> +       struct amdgpu_device *adev =3D pdd->dev->adev;
>
> -       return pdd->dev->doorbell_base +
> -               pdd->doorbell_index * kfd_doorbell_process_slice(pdd->dev=
);
> +       /* Return base of the first doorbell of this process */
> +       return adev->doorbell.base + pdd->qpd.proc_doorbells.start * size=
of(uint32_t);
>  }
>
> -int kfd_alloc_process_doorbells(struct kfd_dev *kfd, unsigned int *doorb=
ell_index)
> +int kfd_alloc_process_doorbells(struct kfd_dev *kfd, struct kfd_process_=
device *pdd)
>  {
> -       int r =3D 0;
> -
> -       if (!kfd->shared_resources.enable_mes)
> -               r =3D ida_simple_get(&kfd->doorbell_ida, 1,
> -                                  kfd->max_doorbell_slices, GFP_KERNEL);
> -       else
> -               r =3D amdgpu_mes_alloc_process_doorbells(
> -                               (struct amdgpu_device *)kfd->adev,
> -                               doorbell_index);
> -
> -       if (r > 0)
> -               *doorbell_index =3D r;
> +       int r;
> +       struct qcm_process_device *qpd =3D &pdd->qpd;
> +       struct amdgpu_doorbell_obj *proc_doorbells =3D &qpd->proc_doorbel=
ls;
> +
> +       /* Allocate bitmap for dynamic doorbell allocation */
> +       proc_doorbells->doorbell_bitmap =3D bitmap_zalloc(KFD_MAX_NUM_OF_=
QUEUES_PER_PROCESS,
> +                                                       GFP_KERNEL);
> +       if (!proc_doorbells->doorbell_bitmap) {
> +               DRM_ERROR("Failed to allocate process doorbell bitmap\n")=
;
> +               return -ENOMEM;
> +       }
>
> -       if (r < 0)
> -               pr_err("Failed to allocate process doorbells\n");
> +       /* Allocate doorbells for this process from the PCI BAR */
> +       proc_doorbells->size =3D kfd_doorbell_process_slice(kfd);
> +       r =3D amdgpu_doorbell_alloc_page(kfd->adev, proc_doorbells);

Same thing here as the previous patch.  Just call
amdgpu_bo_create_kernel(..DOORBELL..) and store the bo in the process
structure.

Alex

> +       if (r) {
> +               DRM_ERROR("Failed to allocate process doorbells\n");
> +               return r;
> +       }
>
>         return r;
>  }
>
> -void kfd_free_process_doorbells(struct kfd_dev *kfd, unsigned int doorbe=
ll_index)
> +void kfd_free_process_doorbells(struct kfd_dev *kfd, struct kfd_process_=
device *pdd)
>  {
> -       if (doorbell_index) {
> -               if (!kfd->shared_resources.enable_mes)
> -                       ida_simple_remove(&kfd->doorbell_ida, doorbell_in=
dex);
> -               else
> -                       amdgpu_mes_free_process_doorbells(
> -                                       (struct amdgpu_device *)kfd->adev=
,
> -                                       doorbell_index);
> -       }
> +       struct amdgpu_doorbell_obj *proc_doorbells =3D &pdd->qpd.proc_doo=
rbells;
> +
> +       bitmap_free(proc_doorbells->doorbell_bitmap);
> +       amdgpu_doorbell_free_page(kfd->adev, proc_doorbells);
>  }
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/=
amdkfd/kfd_priv.h
> index 0ed33416c35f..c97ed8e7e02d 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -658,8 +658,8 @@ struct qcm_process_device {
>         uint64_t ib_base;
>         void *ib_kaddr;
>
> -       /* doorbell resources per process per device */
> -       unsigned long *doorbell_bitmap;
> +       /* physical doorbell pages */
> +       struct amdgpu_doorbell_obj proc_doorbells;
>  };
>
>  /* KFD Memory Eviction */
> @@ -1006,9 +1006,9 @@ unsigned int kfd_get_doorbell_dw_offset_in_bar(stru=
ct kfd_dev *kfd,
>                                         unsigned int doorbell_id);
>  phys_addr_t kfd_get_process_doorbells(struct kfd_process_device *pdd);
>  int kfd_alloc_process_doorbells(struct kfd_dev *kfd,
> -                               unsigned int *doorbell_index);
> +                                struct kfd_process_device *pdd);
>  void kfd_free_process_doorbells(struct kfd_dev *kfd,
> -                               unsigned int doorbell_index);
> +                                struct kfd_process_device *pdd);
>  /* GTT Sub-Allocator */
>
>  int kfd_gtt_sa_allocate(struct kfd_dev *kfd, unsigned int size,
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/a=
md/amdkfd/kfd_process.c
> index 51b1683ac5c1..68d0310c2d53 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> @@ -1037,10 +1037,9 @@ static void kfd_process_destroy_pdds(struct kfd_pr=
ocess *p)
>                         free_pages((unsigned long)pdd->qpd.cwsr_kaddr,
>                                 get_order(KFD_CWSR_TBA_TMA_SIZE));
>
> -               bitmap_free(pdd->qpd.doorbell_bitmap);
>                 idr_destroy(&pdd->alloc_idr);
>
> -               kfd_free_process_doorbells(pdd->dev, pdd->doorbell_index)=
;
> +               kfd_free_process_doorbells(pdd->dev, pdd);
>
>                 if (pdd->dev->shared_resources.enable_mes)
>                         amdgpu_amdkfd_free_gtt_mem(pdd->dev->adev,
> @@ -1449,15 +1448,11 @@ static int init_doorbell_bitmap(struct qcm_proces=
s_device *qpd,
>         unsigned int i;
>         int range_start =3D dev->shared_resources.non_cp_doorbells_start;
>         int range_end =3D dev->shared_resources.non_cp_doorbells_end;
> +       struct amdgpu_doorbell_obj *proc_doorbells =3D &qpd->proc_doorbel=
ls;
>
>         if (!KFD_IS_SOC15(dev))
>                 return 0;
>
> -       qpd->doorbell_bitmap =3D bitmap_zalloc(KFD_MAX_NUM_OF_QUEUES_PER_=
PROCESS,
> -                                            GFP_KERNEL);
> -       if (!qpd->doorbell_bitmap)
> -               return -ENOMEM;
> -
>         /* Mask out doorbells reserved for SDMA, IH, and VCN on SOC15. */
>         pr_debug("reserved doorbell 0x%03x - 0x%03x\n", range_start, rang=
e_end);
>         pr_debug("reserved doorbell 0x%03x - 0x%03x\n",
> @@ -1466,9 +1461,9 @@ static int init_doorbell_bitmap(struct qcm_process_=
device *qpd,
>
>         for (i =3D 0; i < KFD_MAX_NUM_OF_QUEUES_PER_PROCESS / 2; i++) {
>                 if (i >=3D range_start && i <=3D range_end) {
> -                       __set_bit(i, qpd->doorbell_bitmap);
> +                       __set_bit(i, proc_doorbells->doorbell_bitmap);
>                         __set_bit(i + KFD_QUEUE_DOORBELL_MIRROR_OFFSET,
> -                                 qpd->doorbell_bitmap);
> +                                 proc_doorbells->doorbell_bitmap);
>                 }
>         }
>
> @@ -1499,9 +1494,15 @@ struct kfd_process_device *kfd_create_process_devi=
ce_data(struct kfd_dev *dev,
>         if (!pdd)
>                 return NULL;
>
> +       retval =3D kfd_alloc_process_doorbells(dev, pdd);
> +       if (retval) {
> +               pr_err("failed to allocate process doorbells\n");
> +               goto err_free_pdd;
> +       }
> +
>         if (init_doorbell_bitmap(&pdd->qpd, dev)) {
>                 pr_err("Failed to init doorbell for process\n");
> -               goto err_free_pdd;
> +               goto err_free_db;
>         }
>
>         pdd->dev =3D dev;
> @@ -1529,7 +1530,7 @@ struct kfd_process_device *kfd_create_process_devic=
e_data(struct kfd_dev *dev,
>                                                 false);
>                 if (retval) {
>                         pr_err("failed to allocate process context bo\n")=
;
> -                       goto err_free_pdd;
> +                       goto err_free_db;
>                 }
>                 memset(pdd->proc_ctx_cpu_ptr, 0, AMDGPU_MES_PROC_CTX_SIZE=
);
>         }
> @@ -1541,6 +1542,9 @@ struct kfd_process_device *kfd_create_process_devic=
e_data(struct kfd_dev *dev,
>
>         return pdd;
>
> +err_free_db:
> +       kfd_free_process_doorbells(pdd->dev, pdd);
> +
>  err_free_pdd:
>         kfree(pdd);
>         return NULL;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/dri=
vers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> index 5137476ec18e..693688d789d3 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> @@ -348,13 +348,11 @@ int pqm_create_queue(struct process_queue_manager *=
pqm,
>                 /* Return the doorbell offset within the doorbell page
>                  * to the caller so it can be passed up to user mode
>                  * (in bytes).
> -                * There are always 1024 doorbells per process, so in cas=
e
> -                * of 8-byte doorbells, there are two doorbell pages per
> -                * process.
> +                * relative doorbell index =3D Absolute doorbell index -
> +                * absolute index of first doorbell in the page.
>                  */
> -               *p_doorbell_offset_in_process =3D
> -                       (q->properties.doorbell_off * sizeof(uint32_t)) &
> -                       (kfd_doorbell_process_slice(dev) - 1);
> +               *p_doorbell_offset_in_process =3D (q->properties.doorbell=
_off
> +                                               - pdd->qpd.proc_doorbells=
.start) * sizeof(uint32_t);
>
>         pr_debug("PQM After DQM create queue\n");
>
> @@ -858,12 +856,6 @@ int kfd_criu_restore_queue(struct kfd_process *p,
>                 goto exit;
>         }
>
> -       if (!pdd->doorbell_index &&
> -           kfd_alloc_process_doorbells(pdd->dev, &pdd->doorbell_index) <=
 0) {
> -               ret =3D -ENOMEM;
> -               goto exit;
> -       }
> -
>         /* data stored in this order: mqd, ctl_stack */
>         mqd =3D q_extra_data;
>         ctl_stack =3D mqd + q_data->mqd_size;
> --
> 2.40.0
>
