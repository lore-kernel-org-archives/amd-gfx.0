Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18B68C282DE
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Mar 2025 21:09:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF92610E04C;
	Mon, 10 Mar 2025 21:09:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PKFJIJm0";
	dkim-atps=neutral
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com
 [209.85.216.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8257510E04C
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Mar 2025 21:09:21 +0000 (UTC)
Received: by mail-pj1-f51.google.com with SMTP id
 98e67ed59e1d1-2ff6b9a7f91so1217311a91.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Mar 2025 14:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741640961; x=1742245761; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ihwg3CtJRL/T8elOzuWYPSSnbDHI43b9LXtJZBCodc4=;
 b=PKFJIJm0v1Yt/dEN3YuJ3aXwWWl2yu4V3NEOQCHdUIhifhY1VxK32HRw7pm4JcartC
 f78Om9fPt0YoukMJvjeFCu33iG6QFUy4V5YKkjj0GRCZbq50/CYhrAwEzHVAd/gYKigc
 XVfVu8ki4MCv8A6iJifV1tbZm6DbHaYkeoKDswcZ0Qq0ZtJJriqH6mVuyDvZWBNoo82F
 Pmn0XnDY1TBO3tWu02X1JOPRf8z7oJm9+M9d7DOOQuKgGxpASsNaPOjCU60s1sq4ZP3I
 C7ajjxrpAgyo714ieJo6BLDTgo3DOxUnAevIf4vJMIe6jmB7Wsy0GjEEYsW+4Qu5yLUE
 YaAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741640961; x=1742245761;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ihwg3CtJRL/T8elOzuWYPSSnbDHI43b9LXtJZBCodc4=;
 b=FvQJQTC882fGs+yWi/DDOOnS4d6cG6fSOfLvSEhYxUtxDrOWDi8cBtfbwljEPXV4mw
 +zF0g95HbiZKOEk49WPEJtGBXhVAG5s3QpE9L4rGavPBiv13hMkk5Vqn1wlih3G1E6qj
 Fyav4ma7E571/PlsIBth501jHbsGqfPQONWDkRRfdMr0ywtzHh4fELkJBRXSoLyKserj
 GaGxUYuC1+hDJEc7EcXm7R8T++6VNvvhVvPpeb7hrmSVa999A1f5Z8v41MRIRMnfltkM
 1beZwvoLzumIJLZ4ICF/4EwC1FlunleOOOrJm05FB3y/ZlIf2GrxKsu/fG3WyoauXuNK
 C6XQ==
X-Gm-Message-State: AOJu0Yxp0rJefjnMl87chN4S+TZ0mNfZSZtp1FBIHi/23C7vTrOdMLu9
 Tp6Tn3FHddv4aWJ0Jq6U2F+AvEXtt1IT72Lk2U90xcCgKthfPiYCRwsohWoRdgYQSxYW5v41UJ6
 JdWWEhgH6bVRRgHm6MJt6qyFKNr7CVj0t
X-Gm-Gg: ASbGncsCosvom5qQoPrN9K/I2yjRJbuRD5NVEBCvaSMaD04AUQsgHjVmuEBaGnJSJvU
 uCT7JX1cTMInpFWYUwbWQ04Y2fK5LA2jVroSIv/wDeSnAyEI4579Z0SoNnsrAYSppjnl8euFQ4L
 iOcQUqYspp32UwMYqIdh1ljZwwBg==
X-Google-Smtp-Source: AGHT+IGOxwligRsu5GPhEYgFEPm3ePd3l5E3tVLYvxbWuxNeTZtrCjxUFG06FSOEP/I+2MjdLf/flUjNtjTtHrkNZ4s=
X-Received: by 2002:a17:90b:4a4f:b0:2fe:b2ea:30f0 with SMTP id
 98e67ed59e1d1-300a575a10cmr6251330a91.4.1741640960941; Mon, 10 Mar 2025
 14:09:20 -0700 (PDT)
MIME-Version: 1.0
References: <20250310170037.62136-1-shaoyun.liu@amd.com>
In-Reply-To: <20250310170037.62136-1-shaoyun.liu@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 10 Mar 2025 17:09:09 -0400
X-Gm-Features: AQ5f1Jp0vH5Wh_YZTIHeHSMfDyVRkIA40R-ZJ0_jsIiT-nwgZDo2WfRkrgZIQ_s
Message-ID: <CADnq5_PJLSKY91LQG0L1SjLA-OONcNHuF-42Ds_rUDh+nWC=9g@mail.gmail.com>
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

On Mon, Mar 10, 2025 at 1:58=E2=80=AFPM Shaoyun Liu <shaoyun.liu@amd.com> w=
rote:
>
> When MES is been used , the set_hw_resource_1 API is required to
> initialize MES internal context correctly
>
> Signed-off-by: Shaoyun Liu <shaoyun.liu@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h  |  6 +--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c |  6 +--
>  drivers/gpu/drm/amd/amdgpu/mes_v11_0.c   | 52 +++++++++++-------------
>  drivers/gpu/drm/amd/amdgpu/mes_v12_0.c   | 40 ++++++++----------
>  4 files changed, 48 insertions(+), 56 deletions(-)
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
> index ab7e73d0e7b1..980dfb8935b6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> @@ -614,10 +614,10 @@ static int amdgpu_virt_write_vf2pf_data(struct amdg=
pu_device *adev)
>         vf2pf_info->decode_usage =3D 0;
>
>         vf2pf_info->dummy_page_addr =3D (uint64_t)adev->dummy_page_addr;
> -       vf2pf_info->mes_info_addr =3D (uint64_t)adev->mes.resource_1_gpu_=
addr;
> +       vf2pf_info->mes_info_addr =3D (uint64_t)adev->mes.resource_1_gpu_=
addr[0];
>
> -       if (adev->mes.resource_1) {
> -               vf2pf_info->mes_info_size =3D adev->mes.resource_1->tbo.b=
ase.size;
> +       if (adev->mes.resource_1[0]) {
> +               vf2pf_info->mes_info_size =3D adev->mes.resource_1[0]->tb=
o.base.size;
>         }
>         vf2pf_info->checksum =3D
>                 amd_sriov_msg_checksum(
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd=
/amdgpu/mes_v11_0.c
> index a569d09a1a74..299f17868822 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> @@ -751,10 +751,10 @@ static int mes_v11_0_set_hw_resources_1(struct amdg=
pu_mes *mes)
>         mes_set_hw_res_pkt.header.opcode =3D MES_SCH_API_SET_HW_RSRC_1;
>         mes_set_hw_res_pkt.header.dwsize =3D API_FRAME_SIZE_IN_DWORDS;
>         mes_set_hw_res_pkt.enable_mes_info_ctx =3D 1;
> -       mes_set_hw_res_pkt.mes_info_ctx_mc_addr =3D mes->resource_1_gpu_a=
ddr;
> +       mes_set_hw_res_pkt.mes_info_ctx_mc_addr =3D mes->resource_1_gpu_a=
ddr[0];
>         mes_set_hw_res_pkt.mes_info_ctx_size =3D MES11_HW_RESOURCE_1_SIZE=
;
>         mes_set_hw_res_pkt.cleaner_shader_fence_mc_addr =3D
> -               mes->resource_1_gpu_addr + MES11_HW_RESOURCE_1_SIZE;
> +               mes->resource_1_gpu_addr[0] + MES11_HW_RESOURCE_1_SIZE;

This offset here will need to be adjusted if MES11_HW_RESOURCE_1_SIZE
depends on SR-IOV.  See below.

>
>         return mes_v11_0_submit_pkt_and_poll_completion(mes,
>                         &mes_set_hw_res_pkt, sizeof(mes_set_hw_res_pkt),
> @@ -1392,7 +1392,7 @@ static int mes_v11_0_mqd_sw_init(struct amdgpu_devi=
ce *adev,
>  static int mes_v11_0_sw_init(struct amdgpu_ip_block *ip_block)
>  {
>         struct amdgpu_device *adev =3D ip_block->adev;
> -       int pipe, r;
> +       int pipe, r, bo_size;
>
>         adev->mes.funcs =3D &mes_v11_0_funcs;
>         adev->mes.kiq_hw_init =3D &mes_v11_0_kiq_hw_init;
> @@ -1427,19 +1427,21 @@ static int mes_v11_0_sw_init(struct amdgpu_ip_blo=
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
> +       if (amdgpu_sriov_is_mes_info_enable(adev)
> +               bo_size +=3D MES11_HW_RESOURCE_1_SIZE;

if you make the size depend on amdgpu_sriov_is_mes_info_enable(), it
will break the address for
mes_set_hw_res_pkt.cleaner_shader_fence_mc_addr above when SR-IOV is
not enabled.

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
> @@ -1450,11 +1452,8 @@ static int mes_v11_0_sw_fini(struct amdgpu_ip_bloc=
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
> @@ -1643,13 +1642,10 @@ static int mes_v11_0_hw_init(struct amdgpu_ip_blo=
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
> index 96336652d14c..abe8592170b2 100644
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
> @@ -1530,21 +1530,19 @@ static int mes_v12_0_sw_init(struct amdgpu_ip_blo=
ck *ip_block)
>
>                 if (!adev->enable_uni_mes && pipe =3D=3D AMDGPU_MES_KIQ_P=
IPE)
>                         r =3D mes_v12_0_kiq_ring_init(adev);
> -               else
> +               else {

Per kernel coding style, the top part of this if clause needs {} if
you add them to the else half.

Alex

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
> @@ -1556,12 +1554,11 @@ static int mes_v12_0_sw_fini(struct amdgpu_ip_blo=
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
> @@ -1760,8 +1757,7 @@ static int mes_v12_0_hw_init(struct amdgpu_ip_block=
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
