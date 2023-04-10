Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD26CC77B61
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Apr 2023 00:02:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F2F010E1EC;
	Mon, 10 Apr 2023 00:02:21 +0000 (UTC)
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com
 [IPv6:2607:f8b0:4864:20::b29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B9ABF10E1EC
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Apr 2023 00:02:18 +0000 (UTC)
Received: by mail-yb1-xb29.google.com with SMTP id i20so6873839ybg.10
 for <amd-gfx@lists.freedesktop.org>; Sun, 09 Apr 2023 17:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=basnieuwenhuizen.nl; s=google; t=1681084938; x=1683676938;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QCc5t0ZhcNRsKVj+23EBV1WLlxsZn6x3bJmyPIZqAyw=;
 b=a4fSdMDtVA8TgqOaC6zDZ758U+xrlhHleO7GbdCTuPdOgoP4A2L0c/0lFUqJjvlghX
 RL38IwTyQoFWmB2TmdnXWW7fQAz+PxPMOJJwkVg4MyCR1WKwmDCoiWlxQTqgIWWp/9GM
 w55NTtWR05BP/XmAlo5kOM/1aEiv56JwCqUrHrX12L9DTXhrtCphJIZSZyGfRPL+oV5J
 +eN2Wi1ZH9E2UgX5UasQY5NdWELyYQCiIf6p5vvXdZ2XNDYqo91rJQHAHXrknLTZU7K7
 zibGY8dpWs6mpyJHOvOXxRs2mBG7YybW6FN8QOEyF92kXsi6yDvj/XjdeSw08/orvOVO
 aKEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1681084938; x=1683676938;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QCc5t0ZhcNRsKVj+23EBV1WLlxsZn6x3bJmyPIZqAyw=;
 b=7FCcda9OJ/vixZwOBbTrzk6x4FmBkv0jkbBtNn1N+59wDbeMhTBBd2LYZ+VSU9Sz5A
 iIDoQGZEFx9//+cgngcDPM7ynzBE+wz4Z8unhfPEtlNJDd8OOtUlXHpR4vLyIBDKfsPD
 QrfRdq5nuV8rXlKTG+mmxMdEvWttQuHotqbLKK9AFfLaAAYQRaGBwTgk2ZLnqruLhX73
 ixkMoCOLu2pAJTVGKlnVtlsueyKw/fwqA9JLRhUlGUa0Ruj17IICy/IVSfooWfheRMd/
 wLGmbJjDLhK1WrElw+BO1XzKhlVRKYmAJezIPes78oT4PCNyX2HoQk3Y0k6QjLmo+xr6
 i2hw==
X-Gm-Message-State: AAQBX9dLwfKMJ1ZQRBNQxEdRDR2sTMLgRriJCgT8kVP2TH4Tu/eeAspD
 JUvZIvDhYSgyOACBY5/fH3gpKjYfclfL1vVRs1uBdA==
X-Google-Smtp-Source: AKy350bxCY8y+g8jAocpwvcLe9OPJjMnNnsPKhq6ZVIg6D+rfMMCqi4mSuOOlbzhfrKqaSvGqofj6DyFCZHjqyOQ6bI=
X-Received: by 2002:a25:7397:0:b0:b8b:fe5f:2eaa with SMTP id
 o145-20020a257397000000b00b8bfe5f2eaamr2863847ybc.2.1681084937762; Sun, 09
 Apr 2023 17:02:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230329160445.1300-1-shashank.sharma@amd.com>
 <20230329160445.1300-9-shashank.sharma@amd.com>
In-Reply-To: <20230329160445.1300-9-shashank.sharma@amd.com>
From: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Date: Mon, 10 Apr 2023 02:00:06 +0200
Message-ID: <CAP+8YyEDqyJxUHP4xJ9zjJ5BcCKeF0bH8ibjh-y+hp8SyiVgzw@mail.gmail.com>
Subject: Re: [PATCH v3 8/9] drm/amdgpu: map wptr BO into GART
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>, Arvind Yadav <arvind.yadav@amd.com>,
 Christian Koenig <christian.koenig@amd.com>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Mar 29, 2023 at 6:05=E2=80=AFPM Shashank Sharma <shashank.sharma@am=
d.com> wrote:
>
> From: Arvind Yadav <arvind.yadav@amd.com>
>
> To support oversubscription, MES expects WPTR BOs to be mapped
> to GART, before they are submitted to usermode queues.
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian Koenig <christian.koenig@amd.com>
> Cc: Shashank Sharma <shashank.sharma@amd.com>
> Signed-off-by: =EF=BF=BCArvind Yadav <arvind.yadav@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 89 +++++++++++++++++++
>  .../drm/amd/amdgpu/amdgpu_userqueue_gfx_v11.c |  1 +
>  .../gpu/drm/amd/include/amdgpu_userqueue.h    |  1 +
>  3 files changed, 91 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_userqueue.c
> index 5672efcbcffc..7409a4ae55da 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> @@ -43,6 +43,89 @@ amdgpu_userqueue_find(struct amdgpu_userq_mgr *uq_mgr,=
 int qid)
>      return idr_find(&uq_mgr->userq_idr, qid);
>  }
>
> +static int
> +amdgpu_userqueue_map_gtt_bo_to_gart(struct amdgpu_device *adev, struct a=
mdgpu_bo *bo)
> +{
> +    int ret;
> +
> +    ret =3D amdgpu_bo_reserve(bo, true);
> +    if (ret) {
> +        DRM_ERROR("Failed to reserve bo. ret %d\n", ret);
> +        goto err_reserve_bo_failed;
> +    }
> +
> +    ret =3D amdgpu_bo_pin(bo, AMDGPU_GEM_DOMAIN_GTT);
> +    if (ret) {
> +        DRM_ERROR("Failed to pin bo. ret %d\n", ret);
> +        goto err_pin_bo_failed;
> +    }
> +
> +    ret =3D amdgpu_ttm_alloc_gart(&bo->tbo);
> +    if (ret) {
> +        DRM_ERROR("Failed to bind bo to GART. ret %d\n", ret);
> +        goto err_map_bo_gart_failed;
> +    }
> +
> +
> +    amdgpu_bo_unreserve(bo);
> +    bo =3D amdgpu_bo_ref(bo);
> +
> +    return 0;
> +
> +err_map_bo_gart_failed:
> +    amdgpu_bo_unpin(bo);
> +err_pin_bo_failed:
> +    amdgpu_bo_unreserve(bo);
> +err_reserve_bo_failed:
> +
> +    return ret;
> +}
> +
> +
> +static int
> +amdgpu_userqueue_create_wptr_mapping(struct amdgpu_device *adev,
> +                                    struct drm_file *filp,
> +                                    struct amdgpu_usermode_queue *queue)
> +{
> +    struct amdgpu_bo_va_mapping *wptr_mapping;
> +    struct amdgpu_vm *wptr_vm;
> +    struct amdgpu_bo *wptr_bo =3D NULL;
> +    uint64_t wptr =3D queue->userq_prop.wptr_gpu_addr;
> +    int ret;
> +
> +    wptr_vm =3D queue->vm;
> +    ret =3D amdgpu_bo_reserve(wptr_vm->root.bo, false);
> +    if (ret)
> +        goto err_wptr_map_gart;
> +
> +    wptr_mapping =3D amdgpu_vm_bo_lookup_mapping(wptr_vm, wptr >> PAGE_S=
HIFT);
> +    amdgpu_bo_unreserve(wptr_vm->root.bo);
> +    if (!wptr_mapping) {
> +        DRM_ERROR("Failed to lookup wptr bo\n");
> +        ret =3D -EINVAL;
> +        goto err_wptr_map_gart;
> +    }

This triggers for wptr BOs mapped to the high half of address space,
may need some mangling wrt the top bits?

> +
> +    wptr_bo =3D wptr_mapping->bo_va->base.bo;
> +    if (wptr_bo->tbo.base.size > PAGE_SIZE) {
> +        DRM_ERROR("Requested GART mapping for wptr bo larger than one pa=
ge\n");
> +        ret =3D -EINVAL;
> +        goto err_wptr_map_gart;
> +    }
> +
> +    ret =3D amdgpu_userqueue_map_gtt_bo_to_gart(adev, wptr_bo);
> +    if (ret) {
> +        DRM_ERROR("Failed to map wptr bo to GART\n");
> +        goto err_wptr_map_gart;
> +    }
> +
> +    queue->wptr_mc_addr =3D wptr_bo->tbo.resource->start << PAGE_SHIFT;
> +    return 0;
> +
> +err_wptr_map_gart:
> +    return ret;
> +}
> +
>  static int amdgpu_userqueue_create(struct drm_file *filp, union drm_amdg=
pu_userq *args)
>  {
>      struct amdgpu_usermode_queue *queue;
> @@ -82,6 +165,12 @@ static int amdgpu_userqueue_create(struct drm_file *f=
ilp, union drm_amdgpu_userq
>          goto free_queue;
>      }
>
> +    r =3D amdgpu_userqueue_create_wptr_mapping(uq_mgr->adev, filp, queue=
);
> +    if (r) {
> +        DRM_ERROR("Failed to map WPTR (0x%llx) for userqueue\n", queue->=
userq_prop.wptr_gpu_addr);
> +        goto free_queue;
> +    }
> +
>      r =3D uq_mgr->userq_funcs[queue->queue_type]->mqd_create(uq_mgr, que=
ue);
>      if (r) {
>          DRM_ERROR("Failed to create/map userqueue MQD\n");
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue_gfx_v11.c b/driv=
ers/gpu/drm/amd/amdgpu/amdgpu_userqueue_gfx_v11.c
> index 1627641a4a4e..274e78826334 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue_gfx_v11.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue_gfx_v11.c
> @@ -58,6 +58,7 @@ amdgpu_userq_gfx_v11_map(struct amdgpu_userq_mgr *uq_mg=
r,
>      queue_input.queue_size =3D queue->userq_prop.queue_size >> 2;
>      queue_input.doorbell_offset =3D queue->userq_prop.doorbell_index;
>      queue_input.page_table_base_addr =3D amdgpu_gmc_pd_addr(queue->vm->r=
oot.bo);
> +    queue_input.wptr_mc_addr =3D queue->wptr_mc_addr;
>
>      amdgpu_mes_lock(&adev->mes);
>      r =3D adev->mes.funcs->add_hw_queue(&adev->mes, &queue_input);
> diff --git a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h b/drivers/gpu=
/drm/amd/include/amdgpu_userqueue.h
> index 8b62ef77cd26..eaab7cf5fff6 100644
> --- a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
> +++ b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
> @@ -38,6 +38,7 @@ struct amdgpu_usermode_queue {
>         int queue_type;
>         uint64_t flags;
>         uint64_t doorbell_handle;
> +       uint64_t wptr_mc_addr;
>         uint64_t proc_ctx_gpu_addr;
>         uint64_t gang_ctx_gpu_addr;
>         uint64_t gds_ctx_gpu_addr;
> --
> 2.40.0
>
