Return-Path: <SRS0=oeKV=KJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 510F5C433ED
	for <amd-gfx@archiver.kernel.org>; Fri, 14 May 2021 14:14:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7518613FB
	for <amd-gfx@archiver.kernel.org>; Fri, 14 May 2021 14:14:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7518613FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A21A66E1E8;
	Fri, 14 May 2021 14:14:08 +0000 (UTC)
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com
 [IPv6:2607:f8b0:4864:20::234])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A0A36E1E8
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 May 2021 14:14:06 +0000 (UTC)
Received: by mail-oi1-x234.google.com with SMTP id j75so28520637oih.10
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 May 2021 07:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=EnTToeGXTXAPJIwub1GiCH6dZ/faTuwOEUYAYPhIiAQ=;
 b=E/2Cfl30ctF1Jpt3WRBQGS6RSBf6+JOZ74xejOVtx9ZW0H7D639GRd12MRxI1hKToA
 He3YMt0DQjAbxj2+asslq15Rq6ZcGiJok9UiuvJPMP2FO0L9PkJ0OE+YXnnVFftOT82Y
 /WJunxtdOnmUliGglHEgM4rFKkJwFVpCXn80gVRZkEHukJ3u8nUnoxUgiDFyt/36gm6P
 MkaRyE/5+gERyLxpzqaWnYAnAs9xJa9+VxCCZj4qwJof/1BMvfAo9aEQQHVu+xySNnq0
 EnS/nWNq9QzdNhyQe826yYRcdQ2EWPjLBHHxWMi5lRxGJ96oRV8xpR5o368doe2U+7BN
 zwTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=EnTToeGXTXAPJIwub1GiCH6dZ/faTuwOEUYAYPhIiAQ=;
 b=tZhh1gbOAgG8HaOd5GltptFWmtDjMF6ZXrtLCSDTuQozRnp5MXGdnhZCiC0U1UkzSI
 nUyLaSGHTKm81b0bXcUYn3FgMRva4pcD8fTxVxQ6UA1be9OgUZlGtNWGTdoijvDfaT+y
 NzGJiCzL/BCtvLII65FQ0X7gIrkpqKXifg62USExrVFKncuOgDbleZ8oHjr4PATwQAsu
 UijH7iAbl78c2FgcjROEdiT/Z3LKwysIk7jAbE3dmGXlRB3hnzjieewU5smhkJizQgPk
 uKtim0wppHtqfZXzdcVDZLfO3YU3IDiHtiq0jKtzBogYZypTCxIqwkvThiZqkjZIhEr9
 Xpeg==
X-Gm-Message-State: AOAM532xBBzFAjk0XIP60lAUqS3uoBuim18wnAtLybfFXOB0XsfIOMvm
 nMUd3y9BQu7dtRcITUorBVh84XFk9dWkCxb3fUM=
X-Google-Smtp-Source: ABdhPJwUNGlNbbjAWO4YPXCIe+r/HkfSHMhHhMdfgcecUXAnZS7+cFIMRL460L2l3V0G6G5dgUrliuM1+w6Ld9WAvvU=
X-Received: by 2002:a05:6808:206:: with SMTP id l6mr6733276oie.5.1621001646012; 
 Fri, 14 May 2021 07:14:06 -0700 (PDT)
MIME-Version: 1.0
References: <20210514081944.16849-1-changfeng.zhu@amd.com>
In-Reply-To: <20210514081944.16849-1-changfeng.zhu@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 14 May 2021 10:13:55 -0400
Message-ID: <CADnq5_P4tvpTkmzpn=7V8qvfvy3aiR3WO967UObKKacJzQro9w@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: disable 3DCGCG on picasso/raven1 to avoid
 compute hang
To: changzhu <changfeng.zhu@amd.com>
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
Cc: Huang Rui <Ray.Huang@amd.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, May 14, 2021 at 4:20 AM <changfeng.zhu@amd.com> wrote:
>
> From: changzhu <Changfeng.Zhu@amd.com>
>
> From: Changfeng <Changfeng.Zhu@amd.com>
>
> There is problem with 3DCGCG firmware and it will cause compute test
> hang on picasso/raven1. It needs to disable 3DCGCG in driver to avoid
> compute hang.
>
> Change-Id: Ic7d3c7922b2b32f7ac5193d6a4869cbc5b3baa87
> Signed-off-by: Changfeng <Changfeng.Zhu@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

WIth this applied, can we re-enable the additional compute queues?

Alex

> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 10 +++++++---
>  drivers/gpu/drm/amd/amdgpu/soc15.c    |  2 --
>  2 files changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index 22608c45f07c..feaa5e4a5538 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -4947,7 +4947,7 @@ static void gfx_v9_0_update_3d_clock_gating(struct amdgpu_device *adev,
>         amdgpu_gfx_rlc_enter_safe_mode(adev);
>
>         /* Enable 3D CGCG/CGLS */
> -       if (enable && (adev->cg_flags & AMD_CG_SUPPORT_GFX_3D_CGCG)) {
> +       if (enable) {
>                 /* write cmd to clear cgcg/cgls ov */
>                 def = data = RREG32_SOC15(GC, 0, mmRLC_CGTT_MGCG_OVERRIDE);
>                 /* unset CGCG override */
> @@ -4959,8 +4959,12 @@ static void gfx_v9_0_update_3d_clock_gating(struct amdgpu_device *adev,
>                 /* enable 3Dcgcg FSM(0x0000363f) */
>                 def = RREG32_SOC15(GC, 0, mmRLC_CGCG_CGLS_CTRL_3D);
>
> -               data = (0x36 << RLC_CGCG_CGLS_CTRL_3D__CGCG_GFX_IDLE_THRESHOLD__SHIFT) |
> -                       RLC_CGCG_CGLS_CTRL_3D__CGCG_EN_MASK;
> +               if (adev->cg_flags & AMD_CG_SUPPORT_GFX_3D_CGCG)
> +                       data = (0x36 << RLC_CGCG_CGLS_CTRL_3D__CGCG_GFX_IDLE_THRESHOLD__SHIFT) |
> +                               RLC_CGCG_CGLS_CTRL_3D__CGCG_EN_MASK;
> +               else
> +                       data = 0x0 << RLC_CGCG_CGLS_CTRL_3D__CGCG_GFX_IDLE_THRESHOLD__SHIFT;
> +
>                 if (adev->cg_flags & AMD_CG_SUPPORT_GFX_3D_CGLS)
>                         data |= (0x000F << RLC_CGCG_CGLS_CTRL_3D__CGLS_REP_COMPANSAT_DELAY__SHIFT) |
>                                 RLC_CGCG_CGLS_CTRL_3D__CGLS_EN_MASK;
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
> index 4b660b2d1c22..080e715799d4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc15.c
> +++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
> @@ -1393,7 +1393,6 @@ static int soc15_common_early_init(void *handle)
>                         adev->cg_flags = AMD_CG_SUPPORT_GFX_MGCG |
>                                 AMD_CG_SUPPORT_GFX_MGLS |
>                                 AMD_CG_SUPPORT_GFX_CP_LS |
> -                               AMD_CG_SUPPORT_GFX_3D_CGCG |
>                                 AMD_CG_SUPPORT_GFX_3D_CGLS |
>                                 AMD_CG_SUPPORT_GFX_CGCG |
>                                 AMD_CG_SUPPORT_GFX_CGLS |
> @@ -1413,7 +1412,6 @@ static int soc15_common_early_init(void *handle)
>                                 AMD_CG_SUPPORT_GFX_MGLS |
>                                 AMD_CG_SUPPORT_GFX_RLC_LS |
>                                 AMD_CG_SUPPORT_GFX_CP_LS |
> -                               AMD_CG_SUPPORT_GFX_3D_CGCG |
>                                 AMD_CG_SUPPORT_GFX_3D_CGLS |
>                                 AMD_CG_SUPPORT_GFX_CGCG |
>                                 AMD_CG_SUPPORT_GFX_CGLS |
> --
> 2.17.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
