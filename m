Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41D23CCD1BF
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Oct 2025 20:31:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC33F10E1E8;
	Thu, 23 Oct 2025 20:31:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OwgUkbSb";
	dkim-atps=neutral
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com
 [209.85.215.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2CC6810E1E8
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Oct 2025 20:31:37 +0000 (UTC)
Received: by mail-pg1-f174.google.com with SMTP id
 41be03b00d2f7-b5509894ee9so128377a12.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Oct 2025 13:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761251497; x=1761856297; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Wjn3hWIqsLxmsHhsMv8c4bRPc8G1LWQ4+39JoiEeLkc=;
 b=OwgUkbSb4KUDsvCAT9NHCPHUget3tw9oT2ZAIjO7hq/ckCL/tz7xxTGC9kakrIDU6H
 4/k4AMq4qiUHdHS7aQBL1SV8DR2xGr0oFzUd5DeXBOwcJtdTJ9C3UJIZX2Xj7jMrJtW/
 aT9CWLfnqjjNQwaiZMEskK9PItcsIPEbqBsgUJDxvkW1vhxYO2dZ1V8nnJezIlpg9amJ
 Wcpw8VGwL4WliO6woGHjK6apUHiOsg55RaLyiqgbjeF1pMbAExyc6Njwv5GCMDrveWuc
 lMFbeLaxq6Y1bwCKcbanr17lNocUj1QOpI3HQ7J/ceAFfLLX/NElqGVRDudDC9efWdOn
 80Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761251497; x=1761856297;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Wjn3hWIqsLxmsHhsMv8c4bRPc8G1LWQ4+39JoiEeLkc=;
 b=RR/MX5vR95eRcmOYvVM5bjFO8ujVtNeBwRSEXWcL+FoWh2YIeIchqTlubr7QTJDX9s
 +ebd2u7GkdPfpixmnHfBdtC7atiJTD3qgd3e8ZWJcayv1lFc4dapDAUECmARHj/U3WtT
 ezFPI0OkAiHXhMURBYFXaE3fLyaEgf2NPvOz16yYNCs63m+cI/JA4YQJ2OWenpnShcmO
 X5Tl1EqZN/yFutWBCN/z8DiPK9O+WULAvZc26/ZBaIdr1oVs+QH1wlPDbcZtup9RqPgw
 AZlZZjlQIJgvv/TXtpgrlGdscoycpejWud6ZIzMbtxrS1afW1PiVC3nzsvHn5fBbnf9m
 qCew==
X-Gm-Message-State: AOJu0YxBXzHBQicEoRjDmsgkALyHD0q4doNe/aXZM4K5nAXZj7ycJzLX
 aRIzuIEgmFw+PSTQIjxeJ8wvcze6cqgsC68q5403R3S3c7D59mXYneQNqJRPG+oVySoz+pSAnyi
 jq5I1hncEdY+ZifDFPLGc2TF+TVjg17k=
X-Gm-Gg: ASbGncu2LMQWDwcC5xU3LCuqSsjx0EFoXOsw3RIvZD5GzSfXBOYUOyoUc58LHk85rjP
 JS4CyydwKbqPaV/7ucbEr+pjcbdk9x5elDKA5oOuhPqhRCcU+BKqaTXKxL9r1JmgN2APVFP1YVZ
 S4l3Gqa9S96SBdkmFa3XY2aJXPmpwAk7TRcyUVMmF+j90UlswQ9Rxc4lsxxtemo6jO5N3vz3GLw
 II3YO68D92NbaW+C2nBgyWiWnZy7wnqKwdK3YbZJArwF7NMjviK3dUwMzXp
X-Google-Smtp-Source: AGHT+IHFKWzl2vgdWSOH5LcHV+pKv3haczhvmJdIl7gfm7d42QGOShOHWnYvk3QOsrKbJjT3f6sDvLt9/xXzepApTg0=
X-Received: by 2002:a17:903:244a:b0:290:c5c5:57eb with SMTP id
 d9443c01a7336-292d3e56fe3mr72850735ad.3.1761251496425; Thu, 23 Oct 2025
 13:31:36 -0700 (PDT)
MIME-Version: 1.0
References: <20251015010922.1983385-1-Jesse.Zhang@amd.com>
In-Reply-To: <20251015010922.1983385-1-Jesse.Zhang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 23 Oct 2025 16:31:25 -0400
X-Gm-Features: AS18NWBP2v3q844PBhkqKNTcBZ780WGOYMEBfYlQFxeczzkbEC46TN3xSmW8J5c
Message-ID: <CADnq5_N5AEb+jTdqTM83_yszxc9bp0n2roiemB3N3enaoc5fxA@mail.gmail.com>
Subject: Re: [PATCH v8 1/2] drm/amdgpu: Convert amdgpu userqueue management
 from IDR to XArray
To: "Jesse.Zhang" <Jesse.Zhang@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com, 
 Christian Koenig <christian.koenig@amd.com>
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

On Tue, Oct 14, 2025 at 9:26=E2=80=AFPM Jesse.Zhang <Jesse.Zhang@amd.com> w=
rote:
>
> This commit refactors the AMDGPU userqueue management subsystem to replac=
e
> IDR (ID Allocation) with XArray for improved performance, scalability, an=
d
> maintainability. The changes address several issues with the previous IDR
> implementation and provide better locking semantics.
>
> Key changes:
>
> 1. **Global XArray Introduction**:
>    - Added `userq_doorbell_xa` to `struct amdgpu_device` for global queue=
 tracking
>    - Uses doorbell_index as key for efficient global lookup
>    - Replaces the previous `userq_mgr_list` linked list approach
>
> 2. **Per-process XArray Conversion**:
>    - Replaced `userq_idr` with `userq_mgr_xa` in `struct amdgpu_userq_mgr=
`
>    - Maintains per-process queue tracking with queue_id as key
>    - Uses XA_FLAGS_ALLOC for automatic ID allocation
>
> 3. **Locking Improvements**:
>    - Removed global `userq_mutex` from `struct amdgpu_device`
>    - Replaced with fine-grained XArray locking using XArray's internal sp=
inlocks
>
> 4. **Runtime Idle Check Optimization**:
>    - Updated `amdgpu_runtime_idle_check_userq()` to use xa_empty
>
> 5. **Queue Management Functions**:
>    - Converted all IDR operations to equivalent XArray functions:
>      - `idr_alloc()` =E2=86=92 `xa_alloc()`
>      - `idr_find()` =E2=86=92 `xa_load()`
>      - `idr_remove()` =E2=86=92 `xa_erase()`
>      - `idr_for_each()` =E2=86=92 `xa_for_each()`
>
> Benefits:
> - **Performance**: XArray provides better scalability for large numbers o=
f queues
> - **Memory Efficiency**: Reduced memory overhead compared to IDR
> - **Thread Safety**: Improved locking semantics with XArray's internal sp=
inlocks
>
> v2: rename userq_global_xa/userq_xa to userq_doorbell_xa/userq_mgr_xa
>     Remove xa_lock and use its own lock.
>
> v3: Set queue->userq_mgr =3D uq_mgr in amdgpu_userq_create()
> v4: use xa_store_irq (Christian)
>     hold the read side of the reset lock while creating/destroying queues=
 and the manager data structure. (Chritian)
>
> Suggested-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h           |   8 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |   3 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |  16 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c     | 151 +++++++++---------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h     |   8 +-
>  .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   |   4 +-
>  drivers/gpu/drm/amd/amdgpu/mes_userqueue.c    |  22 ++-
>  7 files changed, 101 insertions(+), 111 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/am=
dgpu/amdgpu.h
> index d9bd1d71552e..3d71da46b471 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1174,6 +1174,12 @@ struct amdgpu_device {
>          * queue fence.
>          */
>         struct xarray                   userq_xa;
> +       /**
> +        * @userq_doorbell_xa: Global user queue map (doorbell index =E2=
=86=92 queue)
> +        * Key: doorbell_index (unique global identifier for the queue)
> +        * Value: struct amdgpu_usermode_queue
> +        */
> +       struct xarray userq_doorbell_xa;
>
>         /* df */
>         struct amdgpu_df                df;
> @@ -1307,8 +1313,6 @@ struct amdgpu_device {
>          */
>         bool                            apu_prefer_gtt;
>
> -       struct list_head                userq_mgr_list;
> -       struct mutex                    userq_mutex;
>         bool                            userq_halt_for_enforce_isolation;
>         struct amdgpu_uid *uid_info;
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_device.c
> index 0d5585bc3b04..5d9fd2cabc58 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -4533,7 +4533,6 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>         mutex_init(&adev->gfx.userq_sch_mutex);
>         mutex_init(&adev->gfx.workload_profile_mutex);
>         mutex_init(&adev->vcn.workload_profile_mutex);
> -       mutex_init(&adev->userq_mutex);
>
>         amdgpu_device_init_apu_flags(adev);
>
> @@ -4561,7 +4560,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>
>         INIT_LIST_HEAD(&adev->pm.od_kobj_list);
>
> -       INIT_LIST_HEAD(&adev->userq_mgr_list);
> +       xa_init(&adev->userq_doorbell_xa);
>
>         INIT_DELAYED_WORK(&adev->delayed_init_work,
>                           amdgpu_device_delayed_init_work_handler);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_drv.c
> index bebf2ebc4f34..e8909abcf9c0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -2772,22 +2772,8 @@ static int amdgpu_runtime_idle_check_userq(struct =
device *dev)
>         struct pci_dev *pdev =3D to_pci_dev(dev);
>         struct drm_device *drm_dev =3D pci_get_drvdata(pdev);
>         struct amdgpu_device *adev =3D drm_to_adev(drm_dev);
> -       struct amdgpu_usermode_queue *queue;
> -       struct amdgpu_userq_mgr *uqm, *tmp;
> -       int queue_id;
> -       int ret =3D 0;
> -
> -       mutex_lock(&adev->userq_mutex);
> -       list_for_each_entry_safe(uqm, tmp, &adev->userq_mgr_list, list) {
> -               idr_for_each_entry(&uqm->userq_idr, queue, queue_id) {
> -                       ret =3D -EBUSY;
> -                       goto done;
> -               }
> -       }
> -done:
> -       mutex_unlock(&adev->userq_mutex);
>
> -       return ret;
> +       return xa_empty(&adev->userq_doorbell_xa) ? 0 : -EBUSY;
>  }
>
>  static int amdgpu_pmops_runtime_suspend(struct device *dev)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_userq.c
> index 153d64bc3dcd..1e3a1013eb71 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -30,6 +30,7 @@
>  #include "amdgpu_vm.h"
>  #include "amdgpu_userq.h"
>  #include "amdgpu_userq_fence.h"
> +#include "amdgpu_reset.h"
>
>  u32 amdgpu_userq_get_supported_ip_mask(struct amdgpu_device *adev)
>  {
> @@ -277,19 +278,27 @@ amdgpu_userq_cleanup(struct amdgpu_userq_mgr *uq_mg=
r,
>         struct amdgpu_device *adev =3D uq_mgr->adev;
>         const struct amdgpu_userq_funcs *uq_funcs =3D adev->userq_funcs[q=
ueue->queue_type];
>
> +       /* Wait for mode-1 reset to complete */
> +       down_read(&adev->reset_domain->sem);
> +
>         /* Drop the userq reference. */
>         amdgpu_userq_buffer_vas_list_cleanup(adev, queue);
>         uq_funcs->mqd_destroy(uq_mgr, queue);
>         amdgpu_userq_fence_driver_free(queue);
> -       idr_remove(&uq_mgr->userq_idr, queue_id);
> +       /* Use interrupt-safe locking since IRQ handlers may access these=
 XArrays */
> +       xa_erase_irq(&uq_mgr->userq_mgr_xa, (unsigned long)queue_id);
> +       xa_erase_irq(&adev->userq_doorbell_xa, queue->doorbell_index);
> +       queue->userq_mgr =3D NULL;
>         list_del(&queue->userq_va_list);
>         kfree(queue);
> +
> +       up_read(&adev->reset_domain->sem);
>  }
>
>  static struct amdgpu_usermode_queue *
>  amdgpu_userq_find(struct amdgpu_userq_mgr *uq_mgr, int qid)
>  {
> -       return idr_find(&uq_mgr->userq_idr, qid);
> +       return xa_load(&uq_mgr->userq_mgr_xa, qid);
>  }
>
>  void
> @@ -550,8 +559,9 @@ amdgpu_userq_create(struct drm_file *filp, union drm_=
amdgpu_userq *args)
>         struct amdgpu_db_info db_info;
>         char *queue_name;
>         bool skip_map_queue;
> +       u32 qid;
>         uint64_t index;
> -       int qid, r =3D 0;
> +       int r =3D 0;
>         int priority =3D
>                 (args->in.flags & AMDGPU_USERQ_CREATE_FLAGS_QUEUE_PRIORIT=
Y_MASK) >>
>                 AMDGPU_USERQ_CREATE_FLAGS_QUEUE_PRIORITY_SHIFT;
> @@ -574,7 +584,6 @@ amdgpu_userq_create(struct drm_file *filp, union drm_=
amdgpu_userq *args)
>          *
>          * This will also make sure we have a valid eviction fence ready =
to be used.
>          */
> -       mutex_lock(&adev->userq_mutex);
>         amdgpu_userq_ensure_ev_fence(&fpriv->userq_mgr, &fpriv->evf_mgr);
>
>         uq_funcs =3D adev->userq_funcs[args->in.ip_type];
> @@ -637,15 +646,27 @@ amdgpu_userq_create(struct drm_file *filp, union dr=
m_amdgpu_userq *args)
>                 goto unlock;
>         }
>
> -       qid =3D idr_alloc(&uq_mgr->userq_idr, queue, 1, AMDGPU_MAX_USERQ_=
COUNT, GFP_KERNEL);
> -       if (qid < 0) {
> +       /* Wait for mode-1 reset to complete */
> +       down_read(&adev->reset_domain->sem);
> +       r =3Dxa_err(xa_store_irq(&adev->userq_doorbell_xa, index, queue, =
GFP_KERNEL));
> +       if (r) {
> +               kfree(queue);
> +               up_read(&adev->reset_domain->sem);
> +               goto unlock;
> +       }
> +
> +       r =3D xa_alloc(&uq_mgr->userq_mgr_xa, &qid, queue, XA_LIMIT(1, AM=
DGPU_MAX_USERQ_COUNT), GFP_KERNEL);
> +       if (r) {
>                 drm_file_err(uq_mgr->file, "Failed to allocate a queue id=
\n");
>                 amdgpu_userq_fence_driver_free(queue);
>                 uq_funcs->mqd_destroy(uq_mgr, queue);
>                 kfree(queue);
>                 r =3D -ENOMEM;
> +               up_read(&adev->reset_domain->sem);
>                 goto unlock;
>         }
> +       up_read(&adev->reset_domain->sem);
> +       queue->userq_mgr =3D uq_mgr;
>
>         /* don't map the queue if scheduling is halted */
>         if (adev->userq_halt_for_enforce_isolation &&
> @@ -658,7 +679,7 @@ amdgpu_userq_create(struct drm_file *filp, union drm_=
amdgpu_userq *args)
>                 r =3D amdgpu_userq_map_helper(uq_mgr, queue);
>                 if (r) {
>                         drm_file_err(uq_mgr->file, "Failed to map Queue\n=
");
> -                       idr_remove(&uq_mgr->userq_idr, qid);
> +                       xa_erase(&uq_mgr->userq_mgr_xa, qid);
>                         amdgpu_userq_fence_driver_free(queue);
>                         uq_funcs->mqd_destroy(uq_mgr, queue);
>                         kfree(queue);
> @@ -681,7 +702,6 @@ amdgpu_userq_create(struct drm_file *filp, union drm_=
amdgpu_userq *args)
>
>  unlock:
>         mutex_unlock(&uq_mgr->userq_mutex);
> -       mutex_unlock(&adev->userq_mutex);
>
>         return r;
>  }
> @@ -779,11 +799,11 @@ static int
>  amdgpu_userq_restore_all(struct amdgpu_userq_mgr *uq_mgr)
>  {
>         struct amdgpu_usermode_queue *queue;
> -       int queue_id;
> +       unsigned long queue_id;
>         int ret =3D 0, r;
>
>         /* Resume all the queues for this process */
> -       idr_for_each_entry(&uq_mgr->userq_idr, queue, queue_id) {
> +       xa_for_each(&uq_mgr->userq_mgr_xa, queue_id, queue) {
>
>                 if (!amdgpu_userq_buffer_vas_mapped(queue)) {
>                         drm_file_err(uq_mgr->file,
> @@ -942,11 +962,11 @@ static int
>  amdgpu_userq_evict_all(struct amdgpu_userq_mgr *uq_mgr)
>  {
>         struct amdgpu_usermode_queue *queue;
> -       int queue_id;
> +       unsigned long queue_id;
>         int ret =3D 0, r;
>
>         /* Try to unmap all the queues in this process ctx */
> -       idr_for_each_entry(&uq_mgr->userq_idr, queue, queue_id) {
> +       xa_for_each(&uq_mgr->userq_mgr_xa, queue_id, queue) {
>                 r =3D amdgpu_userq_preempt_helper(uq_mgr, queue);
>                 if (r)
>                         ret =3D r;
> @@ -961,9 +981,10 @@ static int
>  amdgpu_userq_wait_for_signal(struct amdgpu_userq_mgr *uq_mgr)
>  {
>         struct amdgpu_usermode_queue *queue;
> -       int queue_id, ret;
> +       unsigned long queue_id;
> +       int ret;
>
> -       idr_for_each_entry(&uq_mgr->userq_idr, queue, queue_id) {
> +       xa_for_each(&uq_mgr->userq_mgr_xa, queue_id, queue) {
>                 struct dma_fence *f =3D queue->last_fence;
>
>                 if (!f || dma_fence_is_signaled(f))
> @@ -1016,44 +1037,30 @@ int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr=
 *userq_mgr, struct drm_file *f
>                           struct amdgpu_device *adev)
>  {
>         mutex_init(&userq_mgr->userq_mutex);
> -       idr_init_base(&userq_mgr->userq_idr, 1);
> +       xa_init_flags(&userq_mgr->userq_mgr_xa, XA_FLAGS_ALLOC);
>         userq_mgr->adev =3D adev;
>         userq_mgr->file =3D file_priv;
>
> -       mutex_lock(&adev->userq_mutex);
> -       list_add(&userq_mgr->list, &adev->userq_mgr_list);
> -       mutex_unlock(&adev->userq_mutex);
> -
>         INIT_DELAYED_WORK(&userq_mgr->resume_work, amdgpu_userq_restore_w=
orker);
>         return 0;
>  }
>
>  void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr *userq_mgr)
>  {
> -       struct amdgpu_device *adev =3D userq_mgr->adev;
>         struct amdgpu_usermode_queue *queue;
> -       struct amdgpu_userq_mgr *uqm, *tmp;
> -       uint32_t queue_id;
> +       unsigned long queue_id;
>
>         cancel_delayed_work_sync(&userq_mgr->resume_work);
>
> -       mutex_lock(&adev->userq_mutex);
>         mutex_lock(&userq_mgr->userq_mutex);
> -       idr_for_each_entry(&userq_mgr->userq_idr, queue, queue_id) {
> +       xa_for_each(&userq_mgr->userq_mgr_xa, queue_id, queue) {
>                 amdgpu_userq_wait_for_last_fence(userq_mgr, queue);
>                 amdgpu_userq_unmap_helper(userq_mgr, queue);
>                 amdgpu_userq_cleanup(userq_mgr, queue, queue_id);
>         }
>
> -       list_for_each_entry_safe(uqm, tmp, &adev->userq_mgr_list, list) {
> -               if (uqm =3D=3D userq_mgr) {
> -                       list_del(&uqm->list);
> -                       break;
> -               }
> -       }
> -       idr_destroy(&userq_mgr->userq_idr);
> +       xa_destroy(&userq_mgr->userq_mgr_xa);
>         mutex_unlock(&userq_mgr->userq_mutex);
> -       mutex_unlock(&adev->userq_mutex);
>         mutex_destroy(&userq_mgr->userq_mutex);
>  }
>
> @@ -1061,25 +1068,23 @@ int amdgpu_userq_suspend(struct amdgpu_device *ad=
ev)
>  {
>         u32 ip_mask =3D amdgpu_userq_get_supported_ip_mask(adev);
>         struct amdgpu_usermode_queue *queue;
> -       struct amdgpu_userq_mgr *uqm, *tmp;
> -       int queue_id;
> +       struct amdgpu_userq_mgr *uqm;
> +       unsigned long queue_id;
>         int r;
>
>         if (!ip_mask)
>                 return 0;
>
> -       guard(mutex)(&adev->userq_mutex);
> -       list_for_each_entry_safe(uqm, tmp, &adev->userq_mgr_list, list) {
> +       xa_for_each(&adev->userq_doorbell_xa, queue_id, queue) {
> +               uqm =3D queue->userq_mgr;
>                 cancel_delayed_work_sync(&uqm->resume_work);
>                 guard(mutex)(&uqm->userq_mutex);
> -               idr_for_each_entry(&uqm->userq_idr, queue, queue_id) {
> -                       if (adev->in_s0ix)
> -                               r =3D amdgpu_userq_preempt_helper(uqm, qu=
eue);
> -                       else
> -                               r =3D amdgpu_userq_unmap_helper(uqm, queu=
e);
> -                       if (r)
> -                               return r;
> -               }
> +               if (adev->in_s0ix)
> +                       r =3D amdgpu_userq_preempt_helper(uqm, queue);
> +               else
> +                       r =3D amdgpu_userq_unmap_helper(uqm, queue);
> +               if (r)
> +                       return r;
>         }
>         return 0;
>  }
> @@ -1088,24 +1093,22 @@ int amdgpu_userq_resume(struct amdgpu_device *ade=
v)
>  {
>         u32 ip_mask =3D amdgpu_userq_get_supported_ip_mask(adev);
>         struct amdgpu_usermode_queue *queue;
> -       struct amdgpu_userq_mgr *uqm, *tmp;
> -       int queue_id;
> +       struct amdgpu_userq_mgr *uqm;
> +       unsigned long queue_id;
>         int r;
>
>         if (!ip_mask)
>                 return 0;
>
> -       guard(mutex)(&adev->userq_mutex);
> -       list_for_each_entry_safe(uqm, tmp, &adev->userq_mgr_list, list) {
> +       xa_for_each(&adev->userq_doorbell_xa, queue_id, queue) {
> +               uqm =3D queue->userq_mgr;
>                 guard(mutex)(&uqm->userq_mutex);
> -               idr_for_each_entry(&uqm->userq_idr, queue, queue_id) {
> -                       if (adev->in_s0ix)
> -                               r =3D amdgpu_userq_restore_helper(uqm, qu=
eue);
> -                       else
> -                               r =3D amdgpu_userq_map_helper(uqm, queue)=
;
> -                       if (r)
> -                               return r;
> -               }
> +               if (adev->in_s0ix)
> +                       r =3D amdgpu_userq_restore_helper(uqm, queue);
> +               else
> +                       r =3D amdgpu_userq_map_helper(uqm, queue);
> +               if (r)
> +                       return r;
>         }
>
>         return 0;
> @@ -1116,33 +1119,31 @@ int amdgpu_userq_stop_sched_for_enforce_isolation=
(struct amdgpu_device *adev,
>  {
>         u32 ip_mask =3D amdgpu_userq_get_supported_ip_mask(adev);
>         struct amdgpu_usermode_queue *queue;
> -       struct amdgpu_userq_mgr *uqm, *tmp;
> -       int queue_id;
> +       struct amdgpu_userq_mgr *uqm;
> +       unsigned long queue_id;
>         int ret =3D 0, r;
>
>         /* only need to stop gfx/compute */
>         if (!(ip_mask & ((1 << AMDGPU_HW_IP_GFX) | (1 << AMDGPU_HW_IP_COM=
PUTE))))
>                 return 0;
>
> -       mutex_lock(&adev->userq_mutex);
>         if (adev->userq_halt_for_enforce_isolation)
>                 dev_warn(adev->dev, "userq scheduling already stopped!\n"=
);
>         adev->userq_halt_for_enforce_isolation =3D true;
> -       list_for_each_entry_safe(uqm, tmp, &adev->userq_mgr_list, list) {
> +       xa_for_each(&adev->userq_doorbell_xa, queue_id, queue) {
> +               uqm =3D queue->userq_mgr;
>                 cancel_delayed_work_sync(&uqm->resume_work);
>                 mutex_lock(&uqm->userq_mutex);
> -               idr_for_each_entry(&uqm->userq_idr, queue, queue_id) {
> -                       if (((queue->queue_type =3D=3D AMDGPU_HW_IP_GFX) =
||
> -                            (queue->queue_type =3D=3D AMDGPU_HW_IP_COMPU=
TE)) &&
> -                           (queue->xcp_id =3D=3D idx)) {
> -                               r =3D amdgpu_userq_preempt_helper(uqm, qu=
eue);
> -                               if (r)
> -                                       ret =3D r;
> -                       }
> +               if (((queue->queue_type =3D=3D AMDGPU_HW_IP_GFX) ||
> +                    (queue->queue_type =3D=3D AMDGPU_HW_IP_COMPUTE)) &&
> +                   (queue->xcp_id =3D=3D idx)) {
> +                       r =3D amdgpu_userq_preempt_helper(uqm, queue);
> +                       if (r)
> +                               ret =3D r;
>                 }
>                 mutex_unlock(&uqm->userq_mutex);
>         }
> -       mutex_unlock(&adev->userq_mutex);
> +
>         return ret;
>  }
>
> @@ -1151,21 +1152,20 @@ int amdgpu_userq_start_sched_for_enforce_isolatio=
n(struct amdgpu_device *adev,
>  {
>         u32 ip_mask =3D amdgpu_userq_get_supported_ip_mask(adev);
>         struct amdgpu_usermode_queue *queue;
> -       struct amdgpu_userq_mgr *uqm, *tmp;
> -       int queue_id;
> +       struct amdgpu_userq_mgr *uqm;
> +       unsigned long queue_id;
>         int ret =3D 0, r;
>
>         /* only need to stop gfx/compute */
>         if (!(ip_mask & ((1 << AMDGPU_HW_IP_GFX) | (1 << AMDGPU_HW_IP_COM=
PUTE))))
>                 return 0;
>
> -       mutex_lock(&adev->userq_mutex);
>         if (!adev->userq_halt_for_enforce_isolation)
>                 dev_warn(adev->dev, "userq scheduling already started!\n"=
);
>         adev->userq_halt_for_enforce_isolation =3D false;
> -       list_for_each_entry_safe(uqm, tmp, &adev->userq_mgr_list, list) {
> +       xa_for_each(&adev->userq_doorbell_xa, queue_id, queue) {
> +               uqm =3D queue->userq_mgr;
>                 mutex_lock(&uqm->userq_mutex);
> -               idr_for_each_entry(&uqm->userq_idr, queue, queue_id) {
>                         if (((queue->queue_type =3D=3D AMDGPU_HW_IP_GFX) =
||
>                              (queue->queue_type =3D=3D AMDGPU_HW_IP_COMPU=
TE)) &&
>                             (queue->xcp_id =3D=3D idx)) {
> @@ -1173,10 +1173,9 @@ int amdgpu_userq_start_sched_for_enforce_isolation=
(struct amdgpu_device *adev,
>                                 if (r)
>                                         ret =3D r;
>                         }
> -               }
>                 mutex_unlock(&uqm->userq_mutex);
>         }
> -       mutex_unlock(&adev->userq_mutex);
> +
>         return ret;
>  }
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_userq.h
> index 036d8dd585cd..09da0617bfa2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> @@ -96,11 +96,15 @@ struct amdgpu_userq_funcs {
>
>  /* Usermode queues for gfx */
>  struct amdgpu_userq_mgr {
> -       struct idr                      userq_idr;
> +       /**
> +        * @userq_mgr_xa: Per-process user queue map (queue ID =E2=86=92 =
queue)
> +        * Key: queue_id (unique ID within the process's userq manager)
> +        * Value: struct amdgpu_usermode_queue
> +        */
> +       struct xarray                   userq_mgr_xa;
>         struct mutex                    userq_mutex;
>         struct amdgpu_device            *adev;
>         struct delayed_work             resume_work;
> -       struct list_head                list;
>         struct drm_file                 *file;
>  };
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gp=
u/drm/amd/amdgpu/amdgpu_userq_fence.c
> index 761bad98da3e..2aeeaa954882 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> @@ -537,7 +537,7 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev,=
 void *data,
>         }
>
>         /* Retrieve the user queue */
> -       queue =3D idr_find(&userq_mgr->userq_idr, args->queue_id);
> +       queue =3D xa_load(&userq_mgr->userq_mgr_xa, args->queue_id);
>         if (!queue) {
>                 r =3D -ENOENT;
>                 goto put_gobj_write;
> @@ -899,7 +899,7 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, v=
oid *data,
>                  */
>                 num_fences =3D dma_fence_dedup_array(fences, num_fences);
>
> -               waitq =3D idr_find(&userq_mgr->userq_idr, wait_info->wait=
q_id);
> +               waitq =3D xa_load(&userq_mgr->userq_mgr_xa, wait_info->wa=
itq_id);
>                 if (!waitq) {
>                         r =3D -EINVAL;
>                         goto free_fences;
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm=
/amd/amdgpu/mes_userqueue.c
> index 829129ad7bd1..b8486b0d0d69 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> @@ -205,9 +205,9 @@ static int mes_userq_detect_and_reset(struct amdgpu_d=
evice *adev,
>         int db_array_size =3D amdgpu_mes_get_hung_queue_db_array_size(ade=
v);
>         struct mes_detect_and_reset_queue_input input;
>         struct amdgpu_usermode_queue *queue;
> -       struct amdgpu_userq_mgr *uqm, *tmp;
>         unsigned int hung_db_num =3D 0;
> -       int queue_id, r, i;
> +       unsigned long queue_id;
> +       int r, i;
>         u32 db_array[4];
>
>         if (db_array_size > 4) {
> @@ -227,16 +227,14 @@ static int mes_userq_detect_and_reset(struct amdgpu=
_device *adev,
>         if (r) {
>                 dev_err(adev->dev, "Failed to detect and reset queues, er=
r (%d)\n", r);
>         } else if (hung_db_num) {
> -               list_for_each_entry_safe(uqm, tmp, &adev->userq_mgr_list,=
 list) {
> -                       idr_for_each_entry(&uqm->userq_idr, queue, queue_=
id) {
> -                               if (queue->queue_type =3D=3D queue_type) =
{
> -                                       for (i =3D 0; i < hung_db_num; i+=
+) {
> -                                               if (queue->doorbell_index=
 =3D=3D db_array[i]) {
> -                                                       queue->state =3D =
AMDGPU_USERQ_STATE_HUNG;
> -                                                       atomic_inc(&adev-=
>gpu_reset_counter);
> -                                                       amdgpu_userq_fenc=
e_driver_force_completion(queue);
> -                                                       drm_dev_wedged_ev=
ent(adev_to_drm(adev), DRM_WEDGE_RECOVERY_NONE, NULL);
> -                                               }
> +               xa_for_each(&adev->userq_doorbell_xa, queue_id, queue) {
> +                       if (queue->queue_type =3D=3D queue_type) {
> +                               for (i =3D 0; i < hung_db_num; i++) {
> +                                       if (queue->doorbell_index =3D=3D =
db_array[i]) {
> +                                               queue->state =3D AMDGPU_U=
SERQ_STATE_HUNG;
> +                                               atomic_inc(&adev->gpu_res=
et_counter);
> +                                               amdgpu_userq_fence_driver=
_force_completion(queue);
> +                                               drm_dev_wedged_event(adev=
_to_drm(adev), DRM_WEDGE_RECOVERY_NONE, NULL);
>                                         }
>                                 }
>                         }
> --
> 2.49.0
>
