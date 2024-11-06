Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E941CD44D78
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Nov 2024 15:09:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 881FD10E701;
	Wed,  6 Nov 2024 15:09:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TMBjgGuu";
	dkim-atps=neutral
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com
 [209.85.216.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A359110E701
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Nov 2024 15:09:09 +0000 (UTC)
Received: by mail-pj1-f51.google.com with SMTP id
 98e67ed59e1d1-2e2b71fd16fso650242a91.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 06 Nov 2024 07:09:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730905749; x=1731510549; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RcCS2OzNMIFj0tQXlR2yWEQQQiq9IGbwSM17dk4VgOs=;
 b=TMBjgGuuLypAidlr1drK+PW4HvS1POm3Z4PmQ0Heldr/L3j0xDNLs0uoFXe9Vgtem9
 mlVoXIhwHGdcHFIHPVIZN4mPxoDSbwmYGn2dZs8rXhqdWzKrv2QasJW5nynessrRE3RH
 /R0kAk2sJ4tj42t3y1J689OyFe96/UqxmnSlqpk1OqPJLlL44TzBDDXZspitu4d9hJuj
 5hzehPSduotMDYADYZCTJDrZMAcHZgo/ZnFhl7IVPTzIIyHgOSzShbQjFn6+5yULE9sN
 fmkH4pjyMpbwz6wB8BbR84I151BJX6iZWAm7yxzlt/YyTBBhduTg4HvIVMhhIEXH3i7z
 hrUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730905749; x=1731510549;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RcCS2OzNMIFj0tQXlR2yWEQQQiq9IGbwSM17dk4VgOs=;
 b=ehZQH3/gyQvxvrmTCcslkf4FdzdztsSCk7VvB4QBxmHRN9lC4fxbX6G1uIqPATd2Rr
 XkHLBa1bBZ9LORAAk9pcTAJMuKyliEUOR/BjoCLymKrs8/Zg99GXTIwHDooZ/0Gi16cD
 iq6kF+pEgWb8yDf4KSSuc/2KqmVByFX8HTi+2I3SD2XON/6+eJxUu0gfdas6z71tZs9q
 A7PGTCtxa1FZ2CcquG3CZk+UHpET15fDmOoh7HJlfcfeNizvf9JWmSs/zpLYA+QXqDUV
 dCEoGAy4Gg1NjT7KSiZXiEw+rMvG9r2xcy2nMXrZLGOL8xw9SARxXnDIquAKsvfN6Svp
 rnbA==
X-Gm-Message-State: AOJu0Yxs2g7sG8cGkYUoyq1aol5NQ4UMG6OclsnSa3fjBAJMy6J3tw42
 YbrSCfjm8024G4IoL5zdfGvI1UpxwgMJHe2Z77SM37+UU9xDoYXH+n4ukNAiWksewAgLkangSrQ
 Ojwtw4Ldjg/nV+INE/ef/kpIdfkC0Dg==
X-Google-Smtp-Source: AGHT+IETWFURk/Ui7bQqlVheq4DbCed5cB3pZ/m8Uky5jY4B8mLE7VZzKJEoslUomVGkKD0FYs2+AVzodCjK9or6ZB4=
X-Received: by 2002:a17:90b:1286:b0:2e1:f0ee:f41 with SMTP id
 98e67ed59e1d1-2e8f1051e0emr18950180a91.2.1730905748961; Wed, 06 Nov 2024
 07:09:08 -0800 (PST)
MIME-Version: 1.0
References: <20241106063322.2443403-1-Victor.Zhao@amd.com>
In-Reply-To: <20241106063322.2443403-1-Victor.Zhao@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 6 Nov 2024 10:08:57 -0500
Message-ID: <CADnq5_OL8oBNvUnvbeyTzPxZ=8kZ15sXUvLVgkoCdDt9def8EQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/amdgpu: allow function to allocate normal GTT
 memory
To: Victor Zhao <Victor.Zhao@amd.com>
Cc: amd-gfx@lists.freedesktop.org, monk.liu@amd.com, christian.koenig@amd.com, 
 philip.yang@amd.com, felix.kuehling@amd.com, Gang Ba <gaba@amd.com>
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

On Wed, Nov 6, 2024 at 1:49=E2=80=AFAM Victor Zhao <Victor.Zhao@amd.com> wr=
ote:
>
> From: Gang Ba <gaba@amd.com>
>
> amdgpu_amdkfd_alloc_gtt_mem currently allocates USWC memory.
> It uses write-combining for CPU access, which is slow for reading.
> Add a new parameter to amdgpu_amdkfd_alloc_gtt_mem to allocate
> normal GTT memory.
>
> Signed-off-by: Gang Ba <gaba@amd.com>
> Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
> Signed-off-by: Victor Zhao <Victor.Zhao@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c             | 7 +++++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h             | 2 +-
>  drivers/gpu/drm/amd/amdkfd/kfd_device.c                | 2 +-
>  drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c  | 2 +-
>  drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c        | 2 +-
>  drivers/gpu/drm/amd/amdkfd/kfd_process.c               | 2 +-
>  drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c | 2 +-
>  7 files changed, 11 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_amdkfd.c
> index 713be49540d4..acb762855c24 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> @@ -294,7 +294,7 @@ void amdgpu_amdkfd_gpu_reset(struct amdgpu_device *ad=
ev)
>
>  int amdgpu_amdkfd_alloc_gtt_mem(struct amdgpu_device *adev, size_t size,
>                                 void **mem_obj, uint64_t *gpu_addr,
> -                               void **cpu_ptr, bool cp_mqd_gfx9)
> +                               void **cpu_ptr, bool cp_mqd_gfx9, bool is=
_uswc_mode)
>  {
>         struct amdgpu_bo *bo =3D NULL;
>         struct amdgpu_bo_param bp;
> @@ -305,7 +305,10 @@ int amdgpu_amdkfd_alloc_gtt_mem(struct amdgpu_device=
 *adev, size_t size,
>         bp.size =3D size;
>         bp.byte_align =3D PAGE_SIZE;
>         bp.domain =3D AMDGPU_GEM_DOMAIN_GTT;
> -       bp.flags =3D AMDGPU_GEM_CREATE_CPU_GTT_USWC;
> +       if (is_uswc_mode)
> +               bp.flags =3D AMDGPU_GEM_CREATE_CPU_GTT_USWC;
> +       else
> +               bp.flags =3D 0;
>         bp.type =3D ttm_bo_type_kernel;
>         bp.resv =3D NULL;
>         bp.bo_ptr_size =3D sizeof(struct amdgpu_bo);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_amdkfd.h
> index 4b80ad860639..745121e0dd8e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> @@ -234,7 +234,7 @@ int amdgpu_amdkfd_bo_validate_and_fence(struct amdgpu=
_bo *bo,
>  /* Shared API */
>  int amdgpu_amdkfd_alloc_gtt_mem(struct amdgpu_device *adev, size_t size,
>                                 void **mem_obj, uint64_t *gpu_addr,
> -                               void **cpu_ptr, bool mqd_gfx9);
> +                               void **cpu_ptr, bool mqd_gfx9, bool is_us=
wc_mode);
>  void amdgpu_amdkfd_free_gtt_mem(struct amdgpu_device *adev, void **mem_o=
bj);
>  int amdgpu_amdkfd_alloc_gws(struct amdgpu_device *adev, size_t size,
>                                 void **mem_obj);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/am=
d/amdkfd/kfd_device.c
> index 956198da7859..1f1d79ac5e6c 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> @@ -779,7 +779,7 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
>         if (amdgpu_amdkfd_alloc_gtt_mem(
>                         kfd->adev, size, &kfd->gtt_mem,
>                         &kfd->gtt_start_gpu_addr, &kfd->gtt_start_cpu_ptr=
,
> -                       false)) {
> +                       false, true)) {
>                 dev_err(kfd_device, "Could not allocate %d bytes\n", size=
);
>                 goto alloc_gtt_mem_failure;
>         }
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/driv=
ers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index 38c19dc8311d..9672542578d4 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -2783,7 +2783,7 @@ static int allocate_hiq_sdma_mqd(struct device_queu=
e_manager *dqm)
>
>         retval =3D amdgpu_amdkfd_alloc_gtt_mem(dev->adev, size,
>                 &(mem_obj->gtt_mem), &(mem_obj->gpu_addr),
> -               (void *)&(mem_obj->cpu_ptr), false);
> +               (void *)&(mem_obj->cpu_ptr), false, true);
>
>         return retval;
>  }
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c b/drivers/gp=
u/drm/amd/amdkfd/kfd_mqd_manager_v9.c
> index 84e8ea3a8a0c..c9882f1d4419 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
> @@ -140,7 +140,7 @@ static struct kfd_mem_obj *allocate_mqd(struct kfd_no=
de *node,
>                         NUM_XCC(node->xcc_mask),
>                         &(mqd_mem_obj->gtt_mem),
>                         &(mqd_mem_obj->gpu_addr),
> -                       (void *)&(mqd_mem_obj->cpu_ptr), true);
> +                       (void *)&(mqd_mem_obj->cpu_ptr), true, true);
>
>                 if (retval) {
>                         kfree(mqd_mem_obj);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/a=
md/amdkfd/kfd_process.c
> index 6bab6fc6a35d..e1d8fd11d2b1 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> @@ -1639,7 +1639,7 @@ struct kfd_process_device *kfd_create_process_devic=
e_data(struct kfd_node *dev,
>                                                 &pdd->proc_ctx_bo,
>                                                 &pdd->proc_ctx_gpu_addr,
>                                                 &pdd->proc_ctx_cpu_ptr,
> -                                               false);
> +                                               false, true);
>                 if (retval) {
>                         dev_err(dev->adev->dev,
>                                 "failed to allocate process context bo\n"=
);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/dri=
vers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> index c76db22a1000..3a3be0e19fb9 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> @@ -260,7 +260,7 @@ static int init_user_queue(struct process_queue_manag=
er *pqm,
>                                                 &(*q)->gang_ctx_bo,
>                                                 &(*q)->gang_ctx_gpu_addr,
>                                                 &(*q)->gang_ctx_cpu_ptr,
> -                                               false);
> +                                               false, true);
>                 if (retval) {
>                         pr_err("failed to allocate gang context bo\n");
>                         goto cleanup;
> --
> 2.34.1
>
