Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13EA8C4345F
	for <amd-gfx@archiver.kernel.org>; Wed,  1 May 2024 21:36:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 611B8112477;
	Wed,  1 May 2024 21:36:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gPj1lcXD";
	dkim-atps=neutral
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com
 [209.85.215.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 88A78112477
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 May 2024 21:36:52 +0000 (UTC)
Received: by mail-pg1-f178.google.com with SMTP id
 41be03b00d2f7-618a51c8c29so141325a12.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 01 May 2024 14:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1714599412; x=1715204212; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2OyykHjfsyv7q8BZYBDyht8iCMNCGWRqol37YI8bTSc=;
 b=gPj1lcXDHdwVXwccXlwuzfBOk3smCrYyaJULrPIteDm/ZoheEn04zyJPTQ3yougtty
 8vgdEBUAC64mU1Zk1/0DVW19BoX+eiS+7PDzNc8HHDMOpemT6Ohp6NTonK+3epNiKWvy
 fWVyuhZp910hx7bQUykSCYGONWU7ABjm1lDFeLCX6U3EA3oWftkXUVo9I0aRb3ikknJz
 3eAf4kYH2Ws2qOZP8ZDECfRPBlGQx6cM8SwEJuH6OaYZGOcv6c9MXpF+PeZHDjgtZyBs
 cKjH1CsJmmerKgTSBYBNgSDhDGHe7j+Q0AD/p7cn2v68ek0oLIm+MwPNnTsv0v+ndoRE
 Auag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714599412; x=1715204212;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2OyykHjfsyv7q8BZYBDyht8iCMNCGWRqol37YI8bTSc=;
 b=P4tm7fM7PIHi/lK4taoxXTy32bjguvNL8E+PNCZ4dLhirZEMLRq5uiUW7TtYzyAgQj
 KrQY3XzDCXika8e6r0+X1ja6CSa5DMA71tPzCR75aNTDn9UZhP9UjEKrPRtYvc2euIue
 8U2wGu2FhT2I02SzzUDuovUk+d1sR9Qagjh2wZfnIcquHJM/Eu4opvFIGTxUOoKCFZhA
 7s9isliZTNPNVgiJdJR90osB9pfsYUEcxMz2kbVAi9uTQ5TsxVlxvGKU1oWz8y8DMZQt
 SazYyQlZVD4GlwUyl0OGqbMCCFa1Dgyslzmvr1X7bYpFtvKdwTI8qdSkPGsHOeoJ2NLI
 KZDQ==
X-Gm-Message-State: AOJu0YxbUS2UdUEdwOB+bUvGZzCVqq20zOdpSE6p9xnCfTmfkuAi75FC
 sFV7mijw2n1Gq5Mu/h4A16a7QTX28xmrxLz/PrCitGuU4eGUwcWr7cT/c2/cNHoEJ/4nwVISosr
 oWx4O1kxbPudlT7lYT3ZhEz5d7cgHbCWO
X-Google-Smtp-Source: AGHT+IFudZSS+1tBZ5P2w3A6UbLR7+TNW1lYM5vbDJ1hwY0VFvZq8FrORaqbKpZOcRxco9Z1w2SjKAzl8/kR8Ig3jfY=
X-Received: by 2002:a17:90b:124b:b0:2b0:763b:370e with SMTP id
 gx11-20020a17090b124b00b002b0763b370emr1245489pjb.18.1714599411781; Wed, 01
 May 2024 14:36:51 -0700 (PDT)
MIME-Version: 1.0
References: <20240426134810.1250-1-shashank.sharma@amd.com>
 <20240426134810.1250-9-shashank.sharma@amd.com>
In-Reply-To: <20240426134810.1250-9-shashank.sharma@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 1 May 2024 17:36:40 -0400
Message-ID: <CADnq5_NcuAT643x5tUe34fJUT0QG7f3WEwmf6VyL8VeLnsQo+A@mail.gmail.com>
Subject: Re: [PATCH v9 08/14] drm/amdgpu: map wptr BO into GART
To: Shashank Sharma <shashank.sharma@amd.com>
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

On Fri, Apr 26, 2024 at 9:57=E2=80=AFAM Shashank Sharma <shashank.sharma@am=
d.com> wrote:
>
> To support oversubscription, MES FW expects WPTR BOs to
> be mapped into GART, before they are submitted to usermode
> queues. This patch adds a function for the same.
>
> V4: fix the wptr value before mapping lookup (Bas, Christian).
>
> V5: Addressed review comments from Christian:
>     - Either pin object or allocate from GART, but not both.
>     - All the handling must be done with the VM locks held.
>
> V7: Addressed review comments from Christian:
>     - Do not take vm->eviction_lock
>     - Use amdgpu_bo_gpu_offset to get the wptr_bo GPU offset
>
> V8: Rebase
> V9: Changed the function names from gfx_v11* to mes_v11*
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian Koenig <christian.koenig@amd.com>
> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
> Signed-off-by: Arvind Yadav <arvind.yadav@amd.com>
> ---
>  .../gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c  | 77 +++++++++++++++++++
>  .../gpu/drm/amd/include/amdgpu_userqueue.h    |  1 +
>  2 files changed, 78 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c b/drivers/g=
pu/drm/amd/amdgpu/mes_v11_0_userqueue.c
> index 8d2cd61af26b..37b80626e792 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c
> @@ -30,6 +30,74 @@
>  #define AMDGPU_USERQ_PROC_CTX_SZ PAGE_SIZE
>  #define AMDGPU_USERQ_GANG_CTX_SZ PAGE_SIZE
>
> +static int
> +mes_v11_0_map_gtt_bo_to_gart(struct amdgpu_device *adev, struct amdgpu_b=
o *bo)
> +{
> +       int ret;
> +
> +       ret =3D amdgpu_bo_reserve(bo, true);
> +       if (ret) {
> +               DRM_ERROR("Failed to reserve bo. ret %d\n", ret);
> +               goto err_reserve_bo_failed;
> +       }
> +
> +       ret =3D amdgpu_ttm_alloc_gart(&bo->tbo);
> +       if (ret) {
> +               DRM_ERROR("Failed to bind bo to GART. ret %d\n", ret);
> +               goto err_map_bo_gart_failed;
> +       }
> +
> +       amdgpu_bo_unreserve(bo);
> +       bo =3D amdgpu_bo_ref(bo);
> +
> +       return 0;
> +
> +err_map_bo_gart_failed:
> +       amdgpu_bo_unreserve(bo);
> +err_reserve_bo_failed:
> +       return ret;
> +}
> +
> +static int
> +mes_v11_0_create_wptr_mapping(struct amdgpu_userq_mgr *uq_mgr,
> +                             struct amdgpu_usermode_queue *queue,
> +                             uint64_t wptr)
> +{
> +       struct amdgpu_device *adev =3D uq_mgr->adev;
> +       struct amdgpu_bo_va_mapping *wptr_mapping;
> +       struct amdgpu_vm *wptr_vm;
> +       struct amdgpu_userq_obj *wptr_obj =3D &queue->wptr_obj;
> +       int ret;
> +
> +       wptr_vm =3D queue->vm;
> +       ret =3D amdgpu_bo_reserve(wptr_vm->root.bo, false);
> +       if (ret)
> +               return ret;
> +
> +       wptr &=3D AMDGPU_GMC_HOLE_MASK;
> +       wptr_mapping =3D amdgpu_vm_bo_lookup_mapping(wptr_vm, wptr >> PAG=
E_SHIFT);
> +       amdgpu_bo_unreserve(wptr_vm->root.bo);
> +       if (!wptr_mapping) {
> +               DRM_ERROR("Failed to lookup wptr bo\n");
> +               return -EINVAL;
> +       }
> +
> +       wptr_obj->obj =3D wptr_mapping->bo_va->base.bo;
> +       if (wptr_obj->obj->tbo.base.size > PAGE_SIZE) {
> +               DRM_ERROR("Requested GART mapping for wptr bo larger than=
 one page\n");
> +               return -EINVAL;
> +       }
> +
> +       ret =3D mes_v11_0_map_gtt_bo_to_gart(adev, wptr_obj->obj);
> +       if (ret) {
> +               DRM_ERROR("Failed to map wptr bo to GART\n");
> +               return ret;
> +       }
> +
> +       queue->wptr_obj.gpu_addr =3D amdgpu_bo_gpu_offset_no_check(wptr_o=
bj->obj);

The wptr virtual address from the user may not be at offset 0 from the
start of the object.  We should add the offset to the base vmid0 GPU
address.

Alex

> +       return 0;
> +}
> +
>  static int mes_v11_0_userq_map(struct amdgpu_userq_mgr *uq_mgr,
>                                struct amdgpu_usermode_queue *queue,
>                                struct amdgpu_mqd_prop *userq_props)
> @@ -61,6 +129,7 @@ static int mes_v11_0_userq_map(struct amdgpu_userq_mgr=
 *uq_mgr,
>         queue_input.queue_size =3D userq_props->queue_size >> 2;
>         queue_input.doorbell_offset =3D userq_props->doorbell_index;
>         queue_input.page_table_base_addr =3D amdgpu_gmc_pd_addr(queue->vm=
->root.bo);
> +       queue_input.wptr_mc_addr =3D queue->wptr_obj.gpu_addr;
>
>         amdgpu_mes_lock(&adev->mes);
>         r =3D adev->mes.funcs->add_hw_queue(&adev->mes, &queue_input);
> @@ -187,6 +256,13 @@ static int mes_v11_0_userq_mqd_create(struct amdgpu_=
userq_mgr *uq_mgr,
>                 goto free_mqd;
>         }
>
> +       /* FW expects WPTR BOs to be mapped into GART */
> +       r =3D mes_v11_0_create_wptr_mapping(uq_mgr, queue, userq_props->w=
ptr_gpu_addr);
> +       if (r) {
> +               DRM_ERROR("Failed to create WPTR mapping\n");
> +               goto free_ctx;
> +       }
> +
>         /* Map userqueue into FW using MES */
>         r =3D mes_v11_0_userq_map(uq_mgr, queue, userq_props);
>         if (r) {
> @@ -216,6 +292,7 @@ mes_v11_0_userq_mqd_destroy(struct amdgpu_userq_mgr *=
uq_mgr,
>                             struct amdgpu_usermode_queue *queue)
>  {
>         mes_v11_0_userq_unmap(uq_mgr, queue);
> +       amdgpu_bo_unref(&queue->wptr_obj.obj);
>         amdgpu_userqueue_destroy_object(uq_mgr, &queue->fw_obj);
>         kfree(queue->userq_prop);
>         amdgpu_userqueue_destroy_object(uq_mgr, &queue->mqd);
> diff --git a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h b/drivers/gpu=
/drm/amd/include/amdgpu_userqueue.h
> index 643f31474bd8..ffe8a3d73756 100644
> --- a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
> +++ b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
> @@ -45,6 +45,7 @@ struct amdgpu_usermode_queue {
>         struct amdgpu_vm        *vm;
>         struct amdgpu_userq_obj mqd;
>         struct amdgpu_userq_obj fw_obj;
> +       struct amdgpu_userq_obj wptr_obj;
>  };
>
>  struct amdgpu_userq_funcs {
> --
> 2.43.2
>
