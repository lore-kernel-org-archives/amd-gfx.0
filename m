Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31EC7C282EC
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Mar 2025 12:52:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B6D9A10E17C;
	Tue, 11 Mar 2025 12:52:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DDFYYBXu";
	dkim-atps=neutral
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com
 [209.85.216.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B3AC10E17C
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Mar 2025 12:52:30 +0000 (UTC)
Received: by mail-pj1-f44.google.com with SMTP id
 98e67ed59e1d1-2fd02536660so1426878a91.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Mar 2025 05:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741697550; x=1742302350; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VrM9lAE5LDsdaG1FqHRP+u97/OPQylh7pt4ohcOzo0E=;
 b=DDFYYBXuMNoC5mrE3dTMfinCqytccWXnnBlyJNMA51T4m6j8am9MczMecIOkjbReNh
 OkVbV9FHA90eNChZhcsu8rQh1q+ztGmyoOd2DivUCkAF/besRsbaFvHOAFuQ4Sy4qRTw
 ygK0uYzndgiaqebT5X7OQ59Feodt4SkiLmaEiQQZ1kIwdfoY3cGGrioHCM+ObTamAwR5
 xPNZv5sHLRS9g+r1Dsu474DIQrjEg14HiSTUN4BA8rH3RCF3TlCLJRzXYHCwN3wA0yeH
 3JFAplpz5FgBYkm7Az/PBdlIJsViwJuI8VFKZa+E96H1PumUaBhF5cvGxSSYPKYeevnk
 v0DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741697550; x=1742302350;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VrM9lAE5LDsdaG1FqHRP+u97/OPQylh7pt4ohcOzo0E=;
 b=h3Ls3MaLfNS3OlHQuMdLUhJ4h+3BbkOq2FC3E39W9ZTshuuW6Iak3GGZH12dBB9XkU
 L18dZxKWbI/UBFhMOzpGrO24Wa9hgArVa+Nnxk5AFhoa+VzvJnOqptM//xVxkC9kM1cv
 xQ/iP0YzKNJykZ/ePBPGj+K4O0hcbxMlmj19qcSgcEZdAK3zCLB2h7s5wl2RlJzE7U1z
 xs0ctejL07KFfp9k6Yii2kQIzyd0U9nK/VMpENsmPQDtdaa//2RVubuMae27SkPcVLuu
 +daw5almpxNlBwl/rPs1SlJXgVDvi4XjwREFne45ps6MzRuHAQOTrovoyBYFAqLKBb+/
 /Zcw==
X-Gm-Message-State: AOJu0YyXVtdIQgK5D7bFOnXoPQGbVQiXVg9nxMUFsX4JiY2YIZ+zfJvn
 QSX0clwyPjJdVlU22qIXlJlhGrd+KJ6qMgdcy7Lrljfw/pQvS81T/JcmfIzPDXdgFxueU8ZUjJn
 DTbkPr2lYBGp73b0Rbdp/c5KfaObd9g==
X-Gm-Gg: ASbGnctsrx+UQ3Zy/5VIk7gqDcfE27ocaosBl1nN9zxcmBQmnPjQhVYW5JldKtWS8MY
 6hv/AWRPQ2avUPOX4bpvQgGpIEcd3W1S5zgzOB+w+mnXhcLaPVtxpkd9RZIV69wDF4sd1W0bnnr
 8rcmS8VXcqcu63L5xmspg9Bgmvpw==
X-Google-Smtp-Source: AGHT+IFky3hh4Jry3N+BTcSQiP0oRUc8X6CmHlM8zZ4I/4xSY4VZKQnTTgxqPd+1gLztiTIKdGZhmzVShLXzATO0uI4=
X-Received: by 2002:a17:90b:4c51:b0:2ff:5540:bb48 with SMTP id
 98e67ed59e1d1-300ff94c15dmr1756579a91.8.1741697549561; Tue, 11 Mar 2025
 05:52:29 -0700 (PDT)
MIME-Version: 1.0
References: <20250311004552.167172-1-shaoyun.liu@amd.com>
In-Reply-To: <20250311004552.167172-1-shaoyun.liu@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 11 Mar 2025 08:52:17 -0400
X-Gm-Features: AQ5f1JqzyPWpXK31dmPYMpkmbdZe0zV9k3AoMgQLu9GVgQOHlcQZ56IhtFBOMZc
Message-ID: <CADnq5_MicpWsXHULd7qePpyP6BYXczkPJO7JibZJSQ_ADTQo-g@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/amdgpu: Fix MES init sequence
To: Shaoyun Liu <shaoyun.liu@amd.com>
Cc: amd-gfx@lists.freedesktop.org
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

On Mon, Mar 10, 2025 at 8:53=E2=80=AFPM Shaoyun Liu <shaoyun.liu@amd.com> w=
rote:
>
> When MES is been used , the set_hw_resource_1 API is required to
> initialize MES internal context correctly
>
> Signed-off-by: Shaoyun Liu <shaoyun.liu@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h  |  6 +--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c |  9 ++--
>  drivers/gpu/drm/amd/amdgpu/mes_v11_0.c   | 59 ++++++++++++------------
>  drivers/gpu/drm/amd/amdgpu/mes_v12_0.c   | 43 ++++++++---------
>  4 files changed, 57 insertions(+), 60 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_mes.h
> index 4391b3383f0c..78362a838212 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> @@ -143,9 +143,9 @@ struct amdgpu_mes {
>         const struct amdgpu_mes_funcs   *funcs;
>
>         /* mes resource_1 bo*/
> -       struct amdgpu_bo    *resource_1;
> -       uint64_t            resource_1_gpu_addr;
> -       void                *resource_1_addr;
> +       struct amdgpu_bo    *resource_1[AMDGPU_MAX_MES_PIPES];
> +       uint64_t            resource_1_gpu_addr[AMDGPU_MAX_MES_PIPES];
> +       void                *resource_1_addr[AMDGPU_MAX_MES_PIPES];
>
>  };
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_virt.c
> index ab7e73d0e7b1..0bb8cbe0dcc0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> @@ -614,10 +614,11 @@ static int amdgpu_virt_write_vf2pf_data(struct amdg=
pu_device *adev)
>         vf2pf_info->decode_usage =3D 0;
>
>         vf2pf_info->dummy_page_addr =3D (uint64_t)adev->dummy_page_addr;
> -       vf2pf_info->mes_info_addr =3D (uint64_t)adev->mes.resource_1_gpu_=
addr;
> -
> -       if (adev->mes.resource_1) {
> -               vf2pf_info->mes_info_size =3D adev->mes.resource_1->tbo.b=
ase.size;
> +       if (amdgpu_sriov_is_mes_info_enable(adev)) {
> +               vf2pf_info->mes_info_addr =3D
> +                       (uint64_t)(adev->mes.resource_1_gpu_addr[0] + AMD=
GPU_GPU_PAGE_SIZE);
> +               vf2pf_info->mes_info_size =3D
> +                       adev->mes.resource_1[0]->tbo.base.size - AMDGPU_G=
PU_PAGE_SIZE;
>         }
>         vf2pf_info->checksum =3D
>                 amd_sriov_msg_checksum(
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd=
/amdgpu/mes_v11_0.c
> index a569d09a1a74..9cec2bb2f9ca 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> @@ -751,10 +751,13 @@ static int mes_v11_0_set_hw_resources_1(struct amdg=
pu_mes *mes)
>         mes_set_hw_res_pkt.header.opcode =3D MES_SCH_API_SET_HW_RSRC_1;
>         mes_set_hw_res_pkt.header.dwsize =3D API_FRAME_SIZE_IN_DWORDS;
>         mes_set_hw_res_pkt.enable_mes_info_ctx =3D 1;
> -       mes_set_hw_res_pkt.mes_info_ctx_mc_addr =3D mes->resource_1_gpu_a=
ddr;
> -       mes_set_hw_res_pkt.mes_info_ctx_size =3D MES11_HW_RESOURCE_1_SIZE=
;
> -       mes_set_hw_res_pkt.cleaner_shader_fence_mc_addr =3D
> -               mes->resource_1_gpu_addr + MES11_HW_RESOURCE_1_SIZE;
> +
> +       mes_set_hw_res_pkt.cleaner_shader_fence_mc_addr =3D mes->resource=
_1_gpu_addr[0];
> +       if (amdgpu_sriov_is_mes_info_enable(adev)) {
> +               mes_set_hw_res_pkt.mes_info_ctx_mc_addr =3D
> +                       mes->resource_1_gpu_addr[0] + AMDGPU_GPU_PAGE_SIZ=
E;
> +               mes_set_hw_res_pkt.mes_info_ctx_size =3D MES11_HW_RESOURC=
E_1_SIZE;
> +       }
>
>         return mes_v11_0_submit_pkt_and_poll_completion(mes,
>                         &mes_set_hw_res_pkt, sizeof(mes_set_hw_res_pkt),
> @@ -1392,7 +1395,7 @@ static int mes_v11_0_mqd_sw_init(struct amdgpu_devi=
ce *adev,
>  static int mes_v11_0_sw_init(struct amdgpu_ip_block *ip_block)
>  {
>         struct amdgpu_device *adev =3D ip_block->adev;
> -       int pipe, r;
> +       int pipe, r, bo_size;
>
>         adev->mes.funcs =3D &mes_v11_0_funcs;
>         adev->mes.kiq_hw_init =3D &mes_v11_0_kiq_hw_init;
> @@ -1427,19 +1430,21 @@ static int mes_v11_0_sw_init(struct amdgpu_ip_blo=
ck *ip_block)
>         if (r)
>                 return r;
>
> -       if (amdgpu_sriov_is_mes_info_enable(adev) ||
> -           adev->gfx.enable_cleaner_shader) {
> -               r =3D amdgpu_bo_create_kernel(adev,
> -                                           MES11_HW_RESOURCE_1_SIZE + AM=
DGPU_GPU_PAGE_SIZE,
> -                                           PAGE_SIZE,
> -                                           AMDGPU_GEM_DOMAIN_VRAM,
> -                                           &adev->mes.resource_1,
> -                                           &adev->mes.resource_1_gpu_add=
r,
> -                                           &adev->mes.resource_1_addr);
> -               if (r) {
> -                       dev_err(adev->dev, "(%d) failed to create mes res=
ource_1 bo\n", r);
> -                       return r;
> -               }
> +       bo_size =3D AMDGPU_GPU_PAGE_SIZE;
> +       if (amdgpu_sriov_is_mes_info_enable(adev))
> +               bo_size +=3D MES11_HW_RESOURCE_1_SIZE;
> +
> +       /* Only needed for AMDGPU_MES_SCHED_PIPE on MES 11*/
> +       r =3D amdgpu_bo_create_kernel(adev,
> +                                   bo_size,
> +                                   PAGE_SIZE,
> +                                   AMDGPU_GEM_DOMAIN_VRAM,
> +                                   &adev->mes.resource_1[0],
> +                                   &adev->mes.resource_1_gpu_addr[0],
> +                                   &adev->mes.resource_1_addr[0]);
> +       if (r) {
> +               dev_err(adev->dev, "(%d) failed to create mes resource_1 =
bo\n", r);
> +               return r;
>         }
>
>         return 0;
> @@ -1450,11 +1455,8 @@ static int mes_v11_0_sw_fini(struct amdgpu_ip_bloc=
k *ip_block)
>         struct amdgpu_device *adev =3D ip_block->adev;
>         int pipe;
>
> -       if (amdgpu_sriov_is_mes_info_enable(adev) ||
> -           adev->gfx.enable_cleaner_shader) {
> -               amdgpu_bo_free_kernel(&adev->mes.resource_1, &adev->mes.r=
esource_1_gpu_addr,
> -                                     &adev->mes.resource_1_addr);
> -       }
> +       amdgpu_bo_free_kernel(&adev->mes.resource_1[0], &adev->mes.resour=
ce_1_gpu_addr[0],
> +                             &adev->mes.resource_1_addr[0]);
>
>         for (pipe =3D 0; pipe < AMDGPU_MAX_MES_PIPES; pipe++) {
>                 kfree(adev->mes.mqd_backup[pipe]);
> @@ -1643,13 +1645,10 @@ static int mes_v11_0_hw_init(struct amdgpu_ip_blo=
ck *ip_block)
>         if (r)
>                 goto failure;
>
> -       if (amdgpu_sriov_is_mes_info_enable(adev) ||
> -           adev->gfx.enable_cleaner_shader) {
> -               r =3D mes_v11_0_set_hw_resources_1(&adev->mes);
> -               if (r) {
> -                       DRM_ERROR("failed mes_v11_0_set_hw_resources_1, r=
=3D%d\n", r);
> -                       goto failure;
> -               }
> +       r =3D mes_v11_0_set_hw_resources_1(&adev->mes);
> +       if (r) {
> +               DRM_ERROR("failed mes_v11_0_set_hw_resources_1, r=3D%d\n"=
, r);
> +               goto failure;
>         }
>
>         r =3D mes_v11_0_query_sched_status(&adev->mes);
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd=
/amdgpu/mes_v12_0.c
> index 96336652d14c..61e07a4f7168 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
> @@ -687,7 +687,7 @@ static int mes_v12_0_set_hw_resources_1(struct amdgpu=
_mes *mes, int pipe)
>         mes_set_hw_res_1_pkt.header.dwsize =3D API_FRAME_SIZE_IN_DWORDS;
>         mes_set_hw_res_1_pkt.mes_kiq_unmap_timeout =3D 0xa;
>         mes_set_hw_res_1_pkt.cleaner_shader_fence_mc_addr =3D
> -               mes->resource_1_gpu_addr;
> +               mes->resource_1_gpu_addr[pipe];
>
>         return mes_v12_0_submit_pkt_and_poll_completion(mes, pipe,
>                         &mes_set_hw_res_1_pkt, sizeof(mes_set_hw_res_1_pk=
t),
> @@ -1528,23 +1528,22 @@ static int mes_v12_0_sw_init(struct amdgpu_ip_blo=
ck *ip_block)
>                 if (r)
>                         return r;
>
> -               if (!adev->enable_uni_mes && pipe =3D=3D AMDGPU_MES_KIQ_P=
IPE)
> +               if (!adev->enable_uni_mes && pipe =3D=3D AMDGPU_MES_KIQ_P=
IPE) {
>                         r =3D mes_v12_0_kiq_ring_init(adev);
> -               else
> +               }
> +               else {
>                         r =3D mes_v12_0_ring_init(adev, pipe);
> -               if (r)
> -                       return r;
> -       }
> -
> -       if (adev->enable_uni_mes) {
> -               r =3D amdgpu_bo_create_kernel(adev, AMDGPU_GPU_PAGE_SIZE,=
 PAGE_SIZE,
> -                                           AMDGPU_GEM_DOMAIN_VRAM,
> -                                           &adev->mes.resource_1,
> -                                           &adev->mes.resource_1_gpu_add=
r,
> -                                           &adev->mes.resource_1_addr);
> -               if (r) {
> -                       dev_err(adev->dev, "(%d) failed to create mes res=
ource_1 bo\n", r);
> -                       return r;
> +                       if (r)
> +                               return r;
> +                       r =3D amdgpu_bo_create_kernel(adev, AMDGPU_GPU_PA=
GE_SIZE, PAGE_SIZE,
> +                                                   AMDGPU_GEM_DOMAIN_VRA=
M,
> +                                                   &adev->mes.resource_1=
[pipe],
> +                                                   &adev->mes.resource_1=
_gpu_addr[pipe],
> +                                                   &adev->mes.resource_1=
_addr[pipe]);
> +                       if (r) {
> +                               dev_err(adev->dev, "(%d) failed to create=
 mes resource_1 bo pipe[%d]\n", r, pipe);
> +                               return r;
> +                       }
>                 }
>         }
>
> @@ -1556,12 +1555,11 @@ static int mes_v12_0_sw_fini(struct amdgpu_ip_blo=
ck *ip_block)
>         struct amdgpu_device *adev =3D ip_block->adev;
>         int pipe;
>
> -       if (adev->enable_uni_mes)
> -               amdgpu_bo_free_kernel(&adev->mes.resource_1,
> -                                     &adev->mes.resource_1_gpu_addr,
> -                                     &adev->mes.resource_1_addr);
> -
>         for (pipe =3D 0; pipe < AMDGPU_MAX_MES_PIPES; pipe++) {
> +               amdgpu_bo_free_kernel(&adev->mes.resource_1[pipe],
> +                                     &adev->mes.resource_1_gpu_addr[pipe=
],
> +                                     &adev->mes.resource_1_addr[pipe]);
> +
>                 kfree(adev->mes.mqd_backup[pipe]);
>
>                 amdgpu_bo_free_kernel(&adev->mes.eop_gpu_obj[pipe],
> @@ -1760,8 +1758,7 @@ static int mes_v12_0_hw_init(struct amdgpu_ip_block=
 *ip_block)
>         if (r)
>                 goto failure;
>
> -       if (adev->enable_uni_mes)
> -               mes_v12_0_set_hw_resources_1(&adev->mes, AMDGPU_MES_SCHED=
_PIPE);
> +       mes_v12_0_set_hw_resources_1(&adev->mes, AMDGPU_MES_SCHED_PIPE);
>
>         mes_v12_0_init_aggregated_doorbell(&adev->mes);
>
> --
> 2.34.1
>
