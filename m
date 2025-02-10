Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52ED7C02198
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Feb 2025 20:10:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0399E10E3BA;
	Mon, 10 Feb 2025 20:10:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FLGtgdxb";
	dkim-atps=neutral
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com
 [209.85.214.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC52F10E1AC
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Feb 2025 20:10:29 +0000 (UTC)
Received: by mail-pl1-f175.google.com with SMTP id
 d9443c01a7336-218c8ac69faso9925525ad.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Feb 2025 12:10:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1739218229; x=1739823029; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qlhoaRVvycqeoj62Snc4UST4qrD0SrE4CSo3O+Gk3Wg=;
 b=FLGtgdxbROKxuzEvqZVhrLEDqbcOzeXrsV+/9a+SabDvLSh+4YhiMnp4O6SPHi6EPT
 G9LHfjgeAZ3tqIr5hkktjBSmvTU5QUT0q/Ao8u4ar+swwXdSJnB7gSaXH225zAUpO0W1
 b+1gbnczvLWiNnWKX7UN0IrPhkhW1iBk/fBWZZSxZXlwb8FGO2NwsyLSI39M29Wyv2DM
 jKlkoE+RcI04UWtA30l4jC2BrJS3UI4SXW/n2+f/NIURMCobmCt1JrsB2xW+eFF5loIk
 qQRSBBL8LGhmAgtd8k2mMwgA3Nea04nq5lexmofQDfxDZF57nyTlGPQDToZeNH5j2e8z
 K1jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739218229; x=1739823029;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qlhoaRVvycqeoj62Snc4UST4qrD0SrE4CSo3O+Gk3Wg=;
 b=xCN9Bl7ugyAb63TJNOX19GWse/5EUg/MVN3+9O5pwgd+Or/L7UqVRicprvrdsN38R+
 bX31n8tnzK/gE+qd6kIBkiR6KkKbpsa39MIyhWsABMRdwY8rMeoGbgoNanjrDMenYpUb
 KcQh7lHgW9JtMn9Neah+qnwfpefuhzx66p0MmTYERQJux7kVz/5dVgBJEehV4HVUSqHw
 HEK728i43dVi6JpLM5r35+ohh9yEhw8agLjQ9JxKD9LqDptajLpF4l25IfpM+GAYobft
 KbgW/NLzQDxjLt4kuYhda238sCETFKdtH++iGcY9Pgl9bWG+RA071WHDjbz/tatCZSIx
 devg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV7zO58R2Wa1a7mmEhKTR3yu4z2aWrt/59WY47WqWbKoul96cX1yCqcY7REw0gcWh5xmEX6HG4a@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzwKt3iUXh3i/GbkpA0lWAxaYWyReq6iCnFUNRGc9TgOEMzEi42
 DnusnSNuc/nGsdzJBtpJTdGuISV6pcRU2YvetpOptodRohihRZQXPUkdAdgJMG6BOUa7APO+F3F
 p/eVS2ySvDFpJ9bfJsRA1X+eteW8=
X-Gm-Gg: ASbGncsgA/8OWvTokIyzieEOUkx2e6whEBYE+uRQmXhHIsr8PDWr4yyECOQ8c8v1R0v
 D4uLYE5jl3nOnZFAVLL0sgKJirPp7y4CZ319Z+g4RpR20OhYekiNFOK3Nx8AujxYyKI6BzoK+
X-Google-Smtp-Source: AGHT+IEcWPumhdTWo2BlTCBBDsnqnMc2heqKwQjbio/c3BeEZhObuRHnd0IL3jvccEuPK8dVBsTUyGwFkebMUN8Gk2o=
X-Received: by 2002:a17:903:32c7:b0:21f:444:b2c9 with SMTP id
 d9443c01a7336-21f4e10e17dmr87881605ad.0.1739218229188; Mon, 10 Feb 2025
 12:10:29 -0800 (PST)
MIME-Version: 1.0
References: <20250210162755.2488728-1-alexander.deucher@amd.com>
 <20250210162755.2488728-2-alexander.deucher@amd.com>
 <CH0PR12MB53728FDD4853143254B78D77F4F22@CH0PR12MB5372.namprd12.prod.outlook.com>
In-Reply-To: <CH0PR12MB53728FDD4853143254B78D77F4F22@CH0PR12MB5372.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 10 Feb 2025 15:10:17 -0500
X-Gm-Features: AWEUYZmi0G93npNBQDBhAS92CI1_h5dTSjJIN3MAtwQHbvIXyBIlUwA2uu8HnKo
Message-ID: <CADnq5_NF=0f1Pr3w==ivxmYipJHSqYVWk4qBZdS4SPn5RjwvAQ@mail.gmail.com>
Subject: Re: [PATCH V4 2/2] drm/amdgpu/mes: Add cleaner shader fence address
 handling in MES for GFX11
To: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, 
 "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>, "cao,
 lin" <lin.cao@amd.com>, 
 "Chen, JingWen (Wayne)" <JingWen.Chen2@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>
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

On Mon, Feb 10, 2025 at 2:07=E2=80=AFPM Liu, Shaoyun <Shaoyun.Liu@amd.com> =
wrote:
>
> [AMD Official Use Only - AMD Internal Distribution Only]
>
> Might need to update the  commit message since this change don't use the =
write-back memory and  the  package is set_hw_res_1.

Fixed locally.  Thanks.

Alex

>
> Other than that , it looks good to me . And I think we need a similar cha=
nge for gfx12
>
> Regards
> Shaoyun.liu
>
> -----Original Message-----
> From: Deucher, Alexander <Alexander.Deucher@amd.com>
> Sent: Monday, February 10, 2025 11:28 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: SHANMUGAM, SRINIVASAN <SRINIVASAN.SHANMUGAM@amd.com>; cao, lin <lin.c=
ao@amd.com>; Chen, JingWen (Wayne) <JingWen.Chen2@amd.com>; Koenig, Christi=
an <Christian.Koenig@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.co=
m>; Liu, Shaoyun <Shaoyun.Liu@amd.com>
> Subject: [PATCH V4 2/2] drm/amdgpu/mes: Add cleaner shader fence address =
handling in MES for GFX11
>
> From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
>
> This commit introduces enhancements to the handling of the cleaner shader=
 fence in the AMDGPU MES driver:
>
> - The MES (Microcode Execution Scheduler) now sends a PM4 packet to the
>   KIQ (Kernel Interface Queue) to request the cleaner shader, ensuring
>   that requests are handled in a controlled manner and avoiding the
>   race conditions.
> - The CP (Compute Processor) firmware has been updated to use a private
>   bus for accessing specific registers, avoiding unnecessary operations
>   that could lead to issues in VF (Virtual Function) mode.
> - The cleaner shader fence memory address is now set correctly in the
>   `mes_set_hw_res_pkt` structure, allowing for proper synchronization of
>   the cleaner shader execution. This is done by calculating the address
>   using the write-back memory base address and the cleaner fence offset.
>
> Cc: lin cao <lin.cao@amd.com>
> Cc: Jingwen Chen <Jingwen.Chen2@amd.com>
> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Suggested-by: Shaoyun Liu <shaoyun.liu@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/mes_v11_0.c | 17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd=
/amdgpu/mes_v11_0.c
> index e862a3febe2b2..661268172dcf6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> @@ -754,7 +754,7 @@ static int mes_v11_0_set_hw_resources_1(struct amdgpu=
_mes *mes)
>         mes_set_hw_res_pkt.header.dwsize =3D API_FRAME_SIZE_IN_DWORDS;
>         mes_set_hw_res_pkt.enable_mes_info_ctx =3D 1;
>
> -       ret =3D amdgpu_bo_create_kernel(adev, size, PAGE_SIZE,
> +       ret =3D amdgpu_bo_create_kernel(adev, size + AMDGPU_GPU_PAGE_SIZE=
,
> +PAGE_SIZE,
>                                 AMDGPU_GEM_DOMAIN_VRAM,
>                                 &mes->resource_1,
>                                 &mes->resource_1_gpu_addr,
> @@ -765,7 +765,10 @@ static int mes_v11_0_set_hw_resources_1(struct amdgp=
u_mes *mes)
>         }
>
>         mes_set_hw_res_pkt.mes_info_ctx_mc_addr =3D mes->resource_1_gpu_a=
ddr;
> -       mes_set_hw_res_pkt.mes_info_ctx_size =3D mes->resource_1->tbo.bas=
e.size;
> +       mes_set_hw_res_pkt.mes_info_ctx_size =3D size;
> +       mes_set_hw_res_pkt.cleaner_shader_fence_mc_addr =3D
> +               mes->resource_1_gpu_addr + size;
> +
>         return mes_v11_0_submit_pkt_and_poll_completion(mes,
>                         &mes_set_hw_res_pkt, sizeof(mes_set_hw_res_pkt),
>                         offsetof(union MESAPI_SET_HW_RESOURCES_1, api_sta=
tus)); @@ -1632,7 +1635,8 @@ static int mes_v11_0_hw_init(struct amdgpu_ip_=
block *ip_block)
>         if (r)
>                 goto failure;
>
> -       if (amdgpu_sriov_is_mes_info_enable(adev)) {
> +       if (amdgpu_sriov_is_mes_info_enable(adev) ||
> +           adev->gfx.enable_cleaner_shader) {
>                 r =3D mes_v11_0_set_hw_resources_1(&adev->mes);
>                 if (r) {
>                         DRM_ERROR("failed mes_v11_0_set_hw_resources_1, r=
=3D%d\n", r); @@ -1665,10 +1669,13 @@ static int mes_v11_0_hw_init(struct a=
mdgpu_ip_block *ip_block)  static int mes_v11_0_hw_fini(struct amdgpu_ip_bl=
ock *ip_block)  {
>         struct amdgpu_device *adev =3D ip_block->adev;
> -       if (amdgpu_sriov_is_mes_info_enable(adev)) {
> +
> +       if (amdgpu_sriov_is_mes_info_enable(adev) ||
> +           adev->gfx.enable_cleaner_shader) {
>                 amdgpu_bo_free_kernel(&adev->mes.resource_1, &adev->mes.r=
esource_1_gpu_addr,
> -                                       &adev->mes.resource_1_addr);
> +                                     &adev->mes.resource_1_addr);
>         }
> +
>         return 0;
>  }
>
> --
> 2.48.1
>
