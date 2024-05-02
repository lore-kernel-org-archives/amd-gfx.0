Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 599A0C4345F
	for <amd-gfx@archiver.kernel.org>; Thu,  2 May 2024 13:46:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB80410FA99;
	Thu,  2 May 2024 13:46:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VBZSzsYC";
	dkim-atps=neutral
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com
 [209.85.214.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D304F10FBDB
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 May 2024 13:46:37 +0000 (UTC)
Received: by mail-pl1-f170.google.com with SMTP id
 d9443c01a7336-1e65a1370b7so73829375ad.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 02 May 2024 06:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1714657597; x=1715262397; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q6j2lVm/mULcvrUuuryQC/y3wWW/vZ6YLg+Ce7X7FjM=;
 b=VBZSzsYCZq7Rw5L8HAAHAuPxescuEByQTrKrbUiJXzBYoiP3VPokoDLZYa1O8OkPte
 WxdpsjEv2aVV01s1TdwKhK4XJewEhFBFiL3Kr8TfgMnL6GkCMnEBxNyXeJ+4eBIo5MrJ
 HX0N1EByeSSlumYxCWJbnfWk2UCxNNw3YR8o1RGdI4LoeIIIV2TVy0EnvD2W5nVmkLR4
 rIYyk631p+ATa/U87z7wHAppkRwInFspZbY/AoQcFCfoHHFHgYKkd0yjrpIsBywI+Rrx
 mafkhQXSau5I0g44W/NUQ01V8skbc93x/OcOaNqJv4cOGZ2NYnfckT2DgqFXI7b0qSNZ
 tJgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714657597; x=1715262397;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=q6j2lVm/mULcvrUuuryQC/y3wWW/vZ6YLg+Ce7X7FjM=;
 b=oCCMQ6GO3jsEjlzSA21pNzMrweErhuwRjn5Xx0ghdHHNSi2Q/JyS4apAlb757QyMxd
 SN5ZkeienNIpQakLvMiIQbFQRy3eWXlJn8Gkg2TwSoAH78GRF7DRHXCBuWX7QjBnO0e1
 5M7inl8VjwcR5vjZcYWYn82GBxFUg73Qrsap5meX09UmhbXVmA5a5shbCJNuqGhDpMnj
 OFP0NKkVYMQtMdHCMIOXOhwUrhnphLtbcTF46PU9pfHB0SHUiZjVZTbbIoawG9RtjF2g
 bqIZurpuF+0ZBhVzIkCM4lf8Zuyg4LSiO1O9c6EVOd9vaBy/Sd9f9Dt3xa4RJGRePXdt
 CVqQ==
X-Gm-Message-State: AOJu0YyvoUNOkGtQOAlLX07wsgjKOodqpXZZYpqfhwDl/kiuQkLQ4lXC
 d2aCYpHFDfqOQqSZiQox3VO7hXyGJPaL/TT4u7XKdJ0n4+1d6D5jiCQlUoOczS3gI9ePkACUpXp
 wN3UEVXyZDP81Ph+MT/XVPgg6Q10=
X-Google-Smtp-Source: AGHT+IF8W9qGqJfvnRSDX7YV/A5In72p/7jI6d0ZGOZzbdQkzfcvkmoLlv5mAbosBfhaCluNmdAQecim1ft+6mdS9lw=
X-Received: by 2002:a17:90a:fa16:b0:2a2:930c:9a8f with SMTP id
 cm22-20020a17090afa1600b002a2930c9a8fmr2068721pjb.32.1714657597051; Thu, 02
 May 2024 06:46:37 -0700 (PDT)
MIME-Version: 1.0
References: <20240426134810.1250-1-shashank.sharma@amd.com>
 <20240426134810.1250-9-shashank.sharma@amd.com>
 <CADnq5_NcuAT643x5tUe34fJUT0QG7f3WEwmf6VyL8VeLnsQo+A@mail.gmail.com>
 <53cfb00e-c41d-7ec7-561e-370cba54748e@amd.com>
In-Reply-To: <53cfb00e-c41d-7ec7-561e-370cba54748e@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 2 May 2024 09:46:25 -0400
Message-ID: <CADnq5_NFh8R=NSryj-iYkNzhq1n7jiLEzFtJJJc2d=XjZ79r3Q@mail.gmail.com>
Subject: Re: [PATCH v9 08/14] drm/amdgpu: map wptr BO into GART
To: "Sharma, Shashank" <shashank.sharma@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Arvind Yadav <arvind.yadav@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>,
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

On Thu, May 2, 2024 at 1:31=E2=80=AFAM Sharma, Shashank <shashank.sharma@am=
d.com> wrote:
>
>
> On 01/05/2024 23:36, Alex Deucher wrote:
> > On Fri, Apr 26, 2024 at 9:57=E2=80=AFAM Shashank Sharma <shashank.sharm=
a@amd.com> wrote:
> >> To support oversubscription, MES FW expects WPTR BOs to
> >> be mapped into GART, before they are submitted to usermode
> >> queues. This patch adds a function for the same.
> >>
> >> V4: fix the wptr value before mapping lookup (Bas, Christian).
> >>
> >> V5: Addressed review comments from Christian:
> >>      - Either pin object or allocate from GART, but not both.
> >>      - All the handling must be done with the VM locks held.
> >>
> >> V7: Addressed review comments from Christian:
> >>      - Do not take vm->eviction_lock
> >>      - Use amdgpu_bo_gpu_offset to get the wptr_bo GPU offset
> >>
> >> V8: Rebase
> >> V9: Changed the function names from gfx_v11* to mes_v11*
> >>
> >> Cc: Alex Deucher <alexander.deucher@amd.com>
> >> Cc: Christian Koenig <christian.koenig@amd.com>
> >> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
> >> Signed-off-by: Arvind Yadav <arvind.yadav@amd.com>
> >> ---
> >>   .../gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c  | 77 +++++++++++++++++=
++
> >>   .../gpu/drm/amd/include/amdgpu_userqueue.h    |  1 +
> >>   2 files changed, 78 insertions(+)
> >>
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c b/driver=
s/gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c
> >> index 8d2cd61af26b..37b80626e792 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c
> >> @@ -30,6 +30,74 @@
> >>   #define AMDGPU_USERQ_PROC_CTX_SZ PAGE_SIZE
> >>   #define AMDGPU_USERQ_GANG_CTX_SZ PAGE_SIZE
> >>
> >> +static int
> >> +mes_v11_0_map_gtt_bo_to_gart(struct amdgpu_device *adev, struct amdgp=
u_bo *bo)
> >> +{
> >> +       int ret;
> >> +
> >> +       ret =3D amdgpu_bo_reserve(bo, true);
> >> +       if (ret) {
> >> +               DRM_ERROR("Failed to reserve bo. ret %d\n", ret);
> >> +               goto err_reserve_bo_failed;
> >> +       }
> >> +
> >> +       ret =3D amdgpu_ttm_alloc_gart(&bo->tbo);
> >> +       if (ret) {
> >> +               DRM_ERROR("Failed to bind bo to GART. ret %d\n", ret);
> >> +               goto err_map_bo_gart_failed;
> >> +       }
> >> +
> >> +       amdgpu_bo_unreserve(bo);
> >> +       bo =3D amdgpu_bo_ref(bo);
> >> +
> >> +       return 0;
> >> +
> >> +err_map_bo_gart_failed:
> >> +       amdgpu_bo_unreserve(bo);
> >> +err_reserve_bo_failed:
> >> +       return ret;
> >> +}
> >> +
> >> +static int
> >> +mes_v11_0_create_wptr_mapping(struct amdgpu_userq_mgr *uq_mgr,
> >> +                             struct amdgpu_usermode_queue *queue,
> >> +                             uint64_t wptr)
> >> +{
> >> +       struct amdgpu_device *adev =3D uq_mgr->adev;
> >> +       struct amdgpu_bo_va_mapping *wptr_mapping;
> >> +       struct amdgpu_vm *wptr_vm;
> >> +       struct amdgpu_userq_obj *wptr_obj =3D &queue->wptr_obj;
> >> +       int ret;
> >> +
> >> +       wptr_vm =3D queue->vm;
> >> +       ret =3D amdgpu_bo_reserve(wptr_vm->root.bo, false);
> >> +       if (ret)
> >> +               return ret;
> >> +
> >> +       wptr &=3D AMDGPU_GMC_HOLE_MASK;
> >> +       wptr_mapping =3D amdgpu_vm_bo_lookup_mapping(wptr_vm, wptr >> =
PAGE_SHIFT);
> >> +       amdgpu_bo_unreserve(wptr_vm->root.bo);
> >> +       if (!wptr_mapping) {
> >> +               DRM_ERROR("Failed to lookup wptr bo\n");
> >> +               return -EINVAL;
> >> +       }
> >> +
> >> +       wptr_obj->obj =3D wptr_mapping->bo_va->base.bo;
> >> +       if (wptr_obj->obj->tbo.base.size > PAGE_SIZE) {
> >> +               DRM_ERROR("Requested GART mapping for wptr bo larger t=
han one page\n");
> >> +               return -EINVAL;
> >> +       }
> >> +
> >> +       ret =3D mes_v11_0_map_gtt_bo_to_gart(adev, wptr_obj->obj);
> >> +       if (ret) {
> >> +               DRM_ERROR("Failed to map wptr bo to GART\n");
> >> +               return ret;
> >> +       }
> >> +
> >> +       queue->wptr_obj.gpu_addr =3D amdgpu_bo_gpu_offset_no_check(wpt=
r_obj->obj);
> > The wptr virtual address from the user may not be at offset 0 from the
> > start of the object.  We should add the offset to the base vmid0 GPU
> > address.
>
> can you please elaborate a bit here ? wptr_obj->obj is already mapped to
> gart, do we still need this ?

The location that the MES will poll needs to be the same as the
location that the UMD will be writing to.  E.g., if you allocate the
BO and then map it into user space at location 0x5000 in the user's
GPU virtual address space and then the user uses 0x5008 as the wptr
address, we need to make sure that we are polling in MES at vmid0
virtual address + 0x8.  If you map the BO at 0x2000 in the vmid0
address space, you need to make sure to point the firmware to 0x2008.

Alex

>
> - Shashank
>
> >
> > Alex
> >
> >> +       return 0;
> >> +}
> >> +
> >>   static int mes_v11_0_userq_map(struct amdgpu_userq_mgr *uq_mgr,
> >>                                 struct amdgpu_usermode_queue *queue,
> >>                                 struct amdgpu_mqd_prop *userq_props)
> >> @@ -61,6 +129,7 @@ static int mes_v11_0_userq_map(struct amdgpu_userq_=
mgr *uq_mgr,
> >>          queue_input.queue_size =3D userq_props->queue_size >> 2;
> >>          queue_input.doorbell_offset =3D userq_props->doorbell_index;
> >>          queue_input.page_table_base_addr =3D amdgpu_gmc_pd_addr(queue=
->vm->root.bo);
> >> +       queue_input.wptr_mc_addr =3D queue->wptr_obj.gpu_addr;
> >>
> >>          amdgpu_mes_lock(&adev->mes);
> >>          r =3D adev->mes.funcs->add_hw_queue(&adev->mes, &queue_input)=
;
> >> @@ -187,6 +256,13 @@ static int mes_v11_0_userq_mqd_create(struct amdg=
pu_userq_mgr *uq_mgr,
> >>                  goto free_mqd;
> >>          }
> >>
> >> +       /* FW expects WPTR BOs to be mapped into GART */
> >> +       r =3D mes_v11_0_create_wptr_mapping(uq_mgr, queue, userq_props=
->wptr_gpu_addr);
> >> +       if (r) {
> >> +               DRM_ERROR("Failed to create WPTR mapping\n");
> >> +               goto free_ctx;
> >> +       }
> >> +
> >>          /* Map userqueue into FW using MES */
> >>          r =3D mes_v11_0_userq_map(uq_mgr, queue, userq_props);
> >>          if (r) {
> >> @@ -216,6 +292,7 @@ mes_v11_0_userq_mqd_destroy(struct amdgpu_userq_mg=
r *uq_mgr,
> >>                              struct amdgpu_usermode_queue *queue)
> >>   {
> >>          mes_v11_0_userq_unmap(uq_mgr, queue);
> >> +       amdgpu_bo_unref(&queue->wptr_obj.obj);
> >>          amdgpu_userqueue_destroy_object(uq_mgr, &queue->fw_obj);
> >>          kfree(queue->userq_prop);
> >>          amdgpu_userqueue_destroy_object(uq_mgr, &queue->mqd);
> >> diff --git a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h b/drivers/=
gpu/drm/amd/include/amdgpu_userqueue.h
> >> index 643f31474bd8..ffe8a3d73756 100644
> >> --- a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
> >> +++ b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
> >> @@ -45,6 +45,7 @@ struct amdgpu_usermode_queue {
> >>          struct amdgpu_vm        *vm;
> >>          struct amdgpu_userq_obj mqd;
> >>          struct amdgpu_userq_obj fw_obj;
> >> +       struct amdgpu_userq_obj wptr_obj;
> >>   };
> >>
> >>   struct amdgpu_userq_funcs {
> >> --
> >> 2.43.2
> >>
