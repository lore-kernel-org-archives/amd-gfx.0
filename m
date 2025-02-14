Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EEAEC021A6
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Feb 2025 16:46:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2153110ED0F;
	Fri, 14 Feb 2025 16:46:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LHYb95fa";
	dkim-atps=neutral
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com
 [209.85.216.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5991D10ED0F
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Feb 2025 16:46:49 +0000 (UTC)
Received: by mail-pj1-f45.google.com with SMTP id
 98e67ed59e1d1-2fc383a11cdso104215a91.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Feb 2025 08:46:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1739551609; x=1740156409; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+SyFqMvBpJ2NN12uBgWRkRfvcAANe+9t5u7/fcXvQrI=;
 b=LHYb95fa2OXnlUgwC5ileakvWhl5ef60oG6LhbnMUE1bG3T3szWb7F4rJQe4/+o2LK
 ps0uIIMW+eh6Q+63lSfrVAEnK4A512gpU6BF/SL0nykn+3ABt0/OZvB4tBI/OgQYHKOq
 s63yp6LLoepU8XVGgoVMZkr5g1nHrCG3UKAmJJCh1cYq8vGHghmIQ+2Zdp9x+AVGfgGJ
 8j/NPAfaDQRB4quflNqlkR9EUHhojQtvz/USzWDSh2eTcWURJXH2bXZuZUMGgvdYaYEF
 9JRPDOk3tgQOc46jyyypgG8X3euPX1BO5qPH5NlhuwYqmANEJZa0L0P754V3UnYZ2x30
 bAgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739551609; x=1740156409;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+SyFqMvBpJ2NN12uBgWRkRfvcAANe+9t5u7/fcXvQrI=;
 b=wennSMfMC87voIvDkhs919zW8y3Gc9YZh66NNGcFy/xJNvsNjKXJLysrSC8jKvIvgq
 tXzXQvW+VAI0tejcfb1RsEg18Oj6EJvhBybTAtFpt/BMU+GYBQNABvMnRL9YutB7ra8P
 IH1LDA66p+OPA6JssbPcH6YRDMn/7CPDGrZSH1KLIeiOEZ23C+LeA3gj4JjOYLlw/jAF
 2nZKf9rm8J27is4criAQ6jDmOP4zPT+XSOVQ3D5axhm0agJno2aH8LvAKra6nHGTjZ6x
 oUgb1R2E5Xk1Ymd+flA+03kOPgIT0l6SPIzeLPNw+2E3KHFie6kDiav8ATNMJ5vxqaBV
 9HYg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWMNgE8+QVeIrLnTwBeEyq3tnJLupBnmCFN/9tQjuxrkrbcPlJgf2D3yLVu8ZkA1iSSs27l97MK@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwotLxMlN8MeKRGK4T+ipbgApQmTGdQpPcozlq06KuLo9nNrCLT
 mQVOIJhZIqNVFFp90xzO+oEQf9ULJSQ+qe04p//HnXuicqCBHzZ787FVEG/mo4uWWNkwG2ZQ//m
 rU0k8d+MtD0zi6L4ijDvT24ZW3lU=
X-Gm-Gg: ASbGncvh6V2mR4z19bI8lflLXd8PvSHYoe0fwTi6eS5YT+Ndd0YziPGBF/JYmMp8fcq
 b9WWMsLRbzh64P44bjVMn8MFxf3MiHvqJWdbqBslVwWBMzWEz22Ttc+NulGH0mT/SDp8Z0QwH
X-Google-Smtp-Source: AGHT+IGg50TAos1UrrQOrg3tpahewv95LLeATJUxzbBQUaKkAWe7dXOxDnxZYvw9ukPeouyNSzMvd39ZOJQyVQ0L7Eg=
X-Received: by 2002:a17:90b:1a8f:b0:2fc:3262:9465 with SMTP id
 98e67ed59e1d1-2fc3262a4aamr1567928a91.5.1739551608808; Fri, 14 Feb 2025
 08:46:48 -0800 (PST)
MIME-Version: 1.0
References: <20250214151901.2071738-1-alexander.deucher@amd.com>
 <CH0PR12MB5372736A7B3F87297694A1BBF4FE2@CH0PR12MB5372.namprd12.prod.outlook.com>
In-Reply-To: <CH0PR12MB5372736A7B3F87297694A1BBF4FE2@CH0PR12MB5372.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 14 Feb 2025 11:46:37 -0500
X-Gm-Features: AWEUYZkCcZXq1AzdQA35w3E2MNBL4KbRdVV24cOTLbX4o1FZ2pkhBzD-vNu2Wjw
Message-ID: <CADnq5_P3CmxBt6gAUxGLqJBLSnPByJmiVE7oV9hgW1F0go_EEg@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/amdgpu/mes11: allocate hw_resource_1 buffer once
To: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
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

On Fri, Feb 14, 2025 at 11:42=E2=80=AFAM Liu, Shaoyun <Shaoyun.Liu@amd.com>=
 wrote:
>
> [AMD Official Use Only - AMD Internal Distribution Only]
>
> Looks good to me .
> Reviewed-by: Shaoyun.liu < shaouyun.liu@amd.com>

Thanks, is this for the whole series or just this patch?

Alex

>
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex D=
eucher
> Sent: Friday, February 14, 2025 10:19 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: [PATCH 1/2] drm/amdgpu/mes11: allocate hw_resource_1 buffer once
>
> Allocate the buffer at sw init time so we don't alloc and free it for eve=
ry suspend/resume or reset cycle.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/mes_v11_0.c | 52 +++++++++++++-------------
>  1 file changed, 26 insertions(+), 26 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd=
/amdgpu/mes_v11_0.c
> index 26af0af718b5e..530371e6a7aee 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> @@ -64,6 +64,7 @@ static int mes_v11_0_kiq_hw_fini(struct amdgpu_device *=
adev);
>
>  #define MES_EOP_SIZE   2048
>  #define GFX_MES_DRAM_SIZE      0x80000
> +#define MES11_HW_RESOURCE_1_SIZE (128 * AMDGPU_GPU_PAGE_SIZE)
>
>  static void mes_v11_0_ring_set_wptr(struct amdgpu_ring *ring)  { @@ -743=
,11 +744,6 @@ static int mes_v11_0_set_hw_resources(struct amdgpu_mes *mes)
>
>  static int mes_v11_0_set_hw_resources_1(struct amdgpu_mes *mes)  {
> -       unsigned int hw_rsrc_size =3D 128 * AMDGPU_GPU_PAGE_SIZE;
> -       /* add a page for the cleaner shader fence */
> -       unsigned int alloc_size =3D hw_rsrc_size + AMDGPU_GPU_PAGE_SIZE;
> -       int ret =3D 0;
> -       struct amdgpu_device *adev =3D mes->adev;
>         union MESAPI_SET_HW_RESOURCES_1 mes_set_hw_res_pkt;
>         memset(&mes_set_hw_res_pkt, 0, sizeof(mes_set_hw_res_pkt));
>
> @@ -755,21 +751,10 @@ static int mes_v11_0_set_hw_resources_1(struct amdg=
pu_mes *mes)
>         mes_set_hw_res_pkt.header.opcode =3D MES_SCH_API_SET_HW_RSRC_1;
>         mes_set_hw_res_pkt.header.dwsize =3D API_FRAME_SIZE_IN_DWORDS;
>         mes_set_hw_res_pkt.enable_mes_info_ctx =3D 1;
> -
> -       ret =3D amdgpu_bo_create_kernel(adev, alloc_size, PAGE_SIZE,
> -                               AMDGPU_GEM_DOMAIN_VRAM,
> -                               &mes->resource_1,
> -                               &mes->resource_1_gpu_addr,
> -                               &mes->resource_1_addr);
> -       if (ret) {
> -               dev_err(adev->dev, "(%d) failed to create mes resource_1 =
bo\n", ret);
> -               return ret;
> -       }
> -
>         mes_set_hw_res_pkt.mes_info_ctx_mc_addr =3D mes->resource_1_gpu_a=
ddr;
> -       mes_set_hw_res_pkt.mes_info_ctx_size =3D hw_rsrc_size;
> +       mes_set_hw_res_pkt.mes_info_ctx_size =3D MES11_HW_RESOURCE_1_SIZE=
;
>         mes_set_hw_res_pkt.cleaner_shader_fence_mc_addr =3D
> -               mes->resource_1_gpu_addr + hw_rsrc_size;
> +               mes->resource_1_gpu_addr + MES11_HW_RESOURCE_1_SIZE;
>
>         return mes_v11_0_submit_pkt_and_poll_completion(mes,
>                         &mes_set_hw_res_pkt, sizeof(mes_set_hw_res_pkt), =
@@ -1442,6 +1427,23 @@ static int mes_v11_0_sw_init(struct amdgpu_ip_block =
*ip_block)
>         if (r)
>                 return r;
>
> +       if (amdgpu_sriov_is_mes_info_enable(adev) ||
> +           adev->gfx.enable_cleaner_shader) {
> +               int ret;
> +
> +               ret =3D amdgpu_bo_create_kernel(adev,
> +                                             MES11_HW_RESOURCE_1_SIZE + =
AMDGPU_GPU_PAGE_SIZE,
> +                                             PAGE_SIZE,
> +                                             AMDGPU_GEM_DOMAIN_VRAM,
> +                                             &adev->mes.resource_1,
> +                                             &adev->mes.resource_1_gpu_a=
ddr,
> +                                             &adev->mes.resource_1_addr)=
;
> +               if (ret) {
> +                       dev_err(adev->dev, "(%d) failed to create mes res=
ource_1 bo\n", ret);
> +                       return ret;
> +               }
> +       }
> +
>         return 0;
>  }
>
> @@ -1450,6 +1452,12 @@ static int mes_v11_0_sw_fini(struct amdgpu_ip_bloc=
k *ip_block)
>         struct amdgpu_device *adev =3D ip_block->adev;
>         int pipe;
>
> +       if (amdgpu_sriov_is_mes_info_enable(adev) ||
> +           adev->gfx.enable_cleaner_shader) {
> +               amdgpu_bo_free_kernel(&adev->mes.resource_1, &adev->mes.r=
esource_1_gpu_addr,
> +                                     &adev->mes.resource_1_addr);
> +       }
> +
>         for (pipe =3D 0; pipe < AMDGPU_MAX_MES_PIPES; pipe++) {
>                 kfree(adev->mes.mqd_backup[pipe]);
>
> @@ -1670,14 +1678,6 @@ static int mes_v11_0_hw_init(struct amdgpu_ip_bloc=
k *ip_block)
>
>  static int mes_v11_0_hw_fini(struct amdgpu_ip_block *ip_block)  {
> -       struct amdgpu_device *adev =3D ip_block->adev;
> -
> -       if (amdgpu_sriov_is_mes_info_enable(adev) ||
> -           adev->gfx.enable_cleaner_shader) {
> -               amdgpu_bo_free_kernel(&adev->mes.resource_1, &adev->mes.r=
esource_1_gpu_addr,
> -                                     &adev->mes.resource_1_addr);
> -       }
> -
>         return 0;
>  }
>
> --
> 2.48.1
>
