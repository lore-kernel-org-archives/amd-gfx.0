Return-Path: <SRS0=8n1M=EW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38D3DC4742C
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Nov 2020 15:48:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFAC4207BC
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Nov 2020 15:48:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BnbcE9Zj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFAC4207BC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C27589CDF;
	Mon, 16 Nov 2020 15:48:09 +0000 (UTC)
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com
 [IPv6:2a00:1450:4864:20::344])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E64089CDF
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Nov 2020 15:48:08 +0000 (UTC)
Received: by mail-wm1-x344.google.com with SMTP id p19so175155wmg.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Nov 2020 07:48:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=VSL05/mY14Y/rbi+hFqUqE1PWUsy5MprJl6zxLxesT0=;
 b=BnbcE9ZjvHHTgZdrwFuOkN361TVkaIFYEc6E8vQQnqDfvROQ2Kecw5dCrYVV+dedff
 3RdK8EBzZrjo1oZ7RdnGm2teP7eWIYX9o3ZvReZmj+J61zzDt0FM4myAc12BD55ka02d
 oh3dQm+k/nHUvTQTk3WZyDEJoHyYVwkegK9WN2R7LicRWrxRJSBoc9m6yfAhEqF4guHv
 mbRzVf5qi7IdOYVTlU5gEJkdVtNHy9u0O90BuzJ9Sz72td7D9yVK2xWTLAI4Xzy5Kka0
 ekkFnmVrrdGsbX0ymgonsQMBOkEAZo8Eo8mgwyezHBfFeEJQlsWbA9nR65kMLHkt/knw
 izhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=VSL05/mY14Y/rbi+hFqUqE1PWUsy5MprJl6zxLxesT0=;
 b=I+Hz8ZPvp19FAYvttEOQaG1OntiwNR5Wev4jKwsi5Kg+noJjDVxt3XVUlHQbgZe594
 6uRbzuWA038r8E3L7mRr2jniqpwrGdI3txnuVA9cZ1G8TbNgeHJgeGyQlaqsSWPz7r/v
 cFZL2aCdK4eL/ikrIYaFVesRKfh+lMLzMOpahMhYb6u1MouRynsdxXJbbW5ZErw67pOi
 ZOtTgcYuZNUKpoo4w0pvumGf2lMgA2v5BErTtQUjd8NsaY/L421Nj3M2XtfkgvO2DxhN
 qFcC3rQT7iy9yuBUybZI9afA7nWQzz6Ctlw4U4oDaD02p71mmRbb2aWaAVfvCbLvIoXE
 LSkw==
X-Gm-Message-State: AOAM530ojmTw/PDG4kbgh4ECsEJi+qecBSkRH9zcCwT/51zo2dKDSKRe
 nCyewLoZOhlwh5GN0x9Wm2iz9S2Ekh9sXaOuHSgYpA7a
X-Google-Smtp-Source: ABdhPJzbxp6BysxB4fZbZAyEFGQc/BmLxkgWO3UJxJEV/6SlWBu0E43QaFe86jLc/KJ/YnAkdHgWgfS0DQkLA+KweM8=
X-Received: by 2002:a7b:c015:: with SMTP id c21mr976206wmb.79.1605541686833;
 Mon, 16 Nov 2020 07:48:06 -0800 (PST)
MIME-Version: 1.0
References: <20201116145119.13483-1-Hawking.Zhang@amd.com>
In-Reply-To: <20201116145119.13483-1-Hawking.Zhang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 16 Nov 2020 10:47:55 -0500
Message-ID: <CADnq5_Pc5aqvQpvsRiEkHVQ9LZRhz9ETRbXOBJYSdQaziMw2Gg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: make gfxhub_v1_0 callback functions to be
 static
To: Hawking Zhang <Hawking.Zhang@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Kevin Wang <kevin1.wang@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Nov 16, 2020 at 9:51 AM Hawking Zhang <Hawking.Zhang@amd.com> wrote:
>
> Those functions should be invoked through gfxhub.funcs
> pointer.
>
> Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c | 17 +++++++++--------
>  drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.h | 10 +---------
>  2 files changed, 10 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
> index d83577b..6ddd53b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
> @@ -31,13 +31,14 @@
>
>  #include "soc15_common.h"
>
> -u64 gfxhub_v1_0_get_mc_fb_offset(struct amdgpu_device *adev)
> +static u64 gfxhub_v1_0_get_mc_fb_offset(struct amdgpu_device *adev)
>  {
>         return (u64)RREG32_SOC15(GC, 0, mmMC_VM_FB_OFFSET) << 24;
>  }
>
> -void gfxhub_v1_0_setup_vm_pt_regs(struct amdgpu_device *adev, uint32_t vmid,
> -                               uint64_t page_table_base)
> +static void gfxhub_v1_0_setup_vm_pt_regs(struct amdgpu_device *adev,
> +                                        uint32_t vmid,
> +                                        uint64_t page_table_base)
>  {
>         struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_GFXHUB_0];
>
> @@ -275,7 +276,7 @@ static void gfxhub_v1_0_program_invalidation(struct amdgpu_device *adev)
>         }
>  }
>
> -int gfxhub_v1_0_gart_enable(struct amdgpu_device *adev)
> +static int gfxhub_v1_0_gart_enable(struct amdgpu_device *adev)
>  {
>         if (amdgpu_sriov_vf(adev) && adev->asic_type != CHIP_ARCTURUS) {
>                 /*
> @@ -305,7 +306,7 @@ int gfxhub_v1_0_gart_enable(struct amdgpu_device *adev)
>         return 0;
>  }
>
> -void gfxhub_v1_0_gart_disable(struct amdgpu_device *adev)
> +static void gfxhub_v1_0_gart_disable(struct amdgpu_device *adev)
>  {
>         struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_GFXHUB_0];
>         u32 tmp;
> @@ -336,8 +337,8 @@ void gfxhub_v1_0_gart_disable(struct amdgpu_device *adev)
>   * @adev: amdgpu_device pointer
>   * @value: true redirects VM faults to the default page
>   */
> -void gfxhub_v1_0_set_fault_enable_default(struct amdgpu_device *adev,
> -                                         bool value)
> +static void gfxhub_v1_0_set_fault_enable_default(struct amdgpu_device *adev,
> +                                                bool value)
>  {
>         u32 tmp;
>         tmp = RREG32_SOC15(GC, 0, mmVM_L2_PROTECTION_FAULT_CNTL);
> @@ -374,7 +375,7 @@ void gfxhub_v1_0_set_fault_enable_default(struct amdgpu_device *adev,
>         WREG32_SOC15(GC, 0, mmVM_L2_PROTECTION_FAULT_CNTL, tmp);
>  }
>
> -void gfxhub_v1_0_init(struct amdgpu_device *adev)
> +static void gfxhub_v1_0_init(struct amdgpu_device *adev)
>  {
>         struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_GFXHUB_0];
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.h b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.h
> index 0c46672..3174bc5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.h
> +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.h
> @@ -24,14 +24,6 @@
>  #ifndef __GFXHUB_V1_0_H__
>  #define __GFXHUB_V1_0_H__
>
> -int gfxhub_v1_0_gart_enable(struct amdgpu_device *adev);
> -void gfxhub_v1_0_gart_disable(struct amdgpu_device *adev);
> -void gfxhub_v1_0_set_fault_enable_default(struct amdgpu_device *adev,
> -                                         bool value);
> -void gfxhub_v1_0_init(struct amdgpu_device *adev);
> -u64 gfxhub_v1_0_get_mc_fb_offset(struct amdgpu_device *adev);
> -void gfxhub_v1_0_setup_vm_pt_regs(struct amdgpu_device *adev, uint32_t vmid,
> -                               uint64_t page_table_base);
> -
>  extern const struct amdgpu_gfxhub_funcs gfxhub_v1_0_funcs;
> +
>  #endif
> --
> 2.7.4
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
