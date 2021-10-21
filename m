Return-Path: <SRS0=oZ58=PJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CE4DC433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Oct 2021 02:29:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28BF9611EF
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Oct 2021 02:29:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 28BF9611EF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A9FC66EA57;
	Thu, 21 Oct 2021 02:29:19 +0000 (UTC)
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 45AC76EA57
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Oct 2021 02:29:18 +0000 (UTC)
Received: by mail-oi1-x22b.google.com with SMTP id t4so12042378oie.5
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Oct 2021 19:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Ye8R+XJR6yQ+ldeXC7NVBQCQZie864iPk99v3k95t+E=;
 b=IKyi8oIaV/48PTgxYDLzmLpsFE9c5xyTA0Fc1+JxeT0hT3Sw5IjeIPTXE8s8YsK0di
 kj3A7ZJPK1AZNFe0QJCoQzzP7TYWmKzRefDQuMtG2qtHcnneiYneAGYlr5ojLxCiKLlR
 HpxsQzbD2ue+eTF52QbBBq2qvxdZgqo+exH05HvOTqtkV4Vb9gQe0kd5Ah6mmfk12/G2
 bljiGPUOhjUU/Bd2jB+oyCOaPsVPV6ws/XdiQkJOzDCLstI2v4l4KDwjVgAbIHf+Dt93
 Qb2oAQR2Q9xmdxpWfo36fEy34NaXbrSaWBm8tnXQKi67LefCBsXVoQOR/khAiDoiIzuZ
 XM1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Ye8R+XJR6yQ+ldeXC7NVBQCQZie864iPk99v3k95t+E=;
 b=c/98iN2mWBYBoyxoRBLGuVU8UGmvcbNGM++xqi2f9TkMJJ59a+RzWaRiOac9uQKJir
 HBZOcAWo9fvw2ympOLM2AA3QNbl5hGYOVOHDcmwUuqdsBQaKItNVmhlMAlzWNMZRVVyF
 BQFRspmzyZEJR/XjLWq4p1mM3oCgzPseM56E6OPDltfGWku8ndaxqlx7FwN7w0Ug/M6v
 xNbvK2six1rU0JZeRLUPhvnHSFfRZpY/zpUBfv0pXGCfWKqsrCf8WGDvURLCFB3Wjd3C
 r6GBBcmIVK1dLAEmDMrXjQDeKU336+lQVBnWfAUYUOVmrio0VSXrW4LjxCrRePDh/pMh
 O73A==
X-Gm-Message-State: AOAM531PvapGj2hNU/+oT3E9Rx4V66VLer5Am7G/w7oqeBrapYgqOPYl
 CtDqJ4Yd/mvdei1yYq43+0I6vNmDsr8sW5J0hk0=
X-Google-Smtp-Source: ABdhPJxCIiKBkdfUzVnJMOWNBBnhz1+mHeM43KY9JL7UnoR15c+GF8a+sGkG2aLxYk/tcNpPQOhmh5pBln7a59/IavI=
X-Received: by 2002:aca:d6d2:: with SMTP id n201mr2039680oig.120.1634783357584; 
 Wed, 20 Oct 2021 19:29:17 -0700 (PDT)
MIME-Version: 1.0
References: <20211021022724.576045-1-ray.huang@amd.com>
In-Reply-To: <20211021022724.576045-1-ray.huang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 20 Oct 2021 22:29:06 -0400
Message-ID: <CADnq5_NdtvuxWKXN5ok=B9K+EgzPA7yf2BKj1eKCL=Vn=dTakA@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amdgpu: remove grbm cam index/data operations for
 gfx v10
To: Huang Rui <ray.huang@amd.com>
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Alex Deucher <alexander.deucher@amd.com>, 
 Hawking Zhang <Hawking.Zhang@amd.com>, Lang Yu <Lang.Yu@amd.com>
Content-Type: text/plain; charset="UTF-8"
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

On Wed, Oct 20, 2021 at 10:27 PM Huang Rui <ray.huang@amd.com> wrote:
>
> PSP firmware will be responsible for applying the GRBM CAM remapping in
> the production. And the GRBM_CAM_INDEX / GRBM_CAM_DATA registers will be
> protected by PSP under security policy. So remove it according to the
> new security policy.
>
> Signed-off-by: Huang Rui <ray.huang@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 22 ----------------------
>  1 file changed, 22 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> index 71bb3c0dc1da..df54aa834f9e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -270,25 +270,6 @@ MODULE_FIRMWARE("amdgpu/cyan_skillfish2_mec.bin");
>  MODULE_FIRMWARE("amdgpu/cyan_skillfish2_mec2.bin");
>  MODULE_FIRMWARE("amdgpu/cyan_skillfish2_rlc.bin");
>
> -static const struct soc15_reg_golden golden_settings_gc_10_0[] =
> -{
> -       SOC15_REG_GOLDEN_VALUE(GC, 0, mmGRBM_CAM_INDEX, 0xffffffff, 0x00000000),
> -       /* TA_GRAD_ADJ_UCONFIG -> TA_GRAD_ADJ */
> -       SOC15_REG_GOLDEN_VALUE(GC, 0, mmGRBM_CAM_DATA, 0xffffffff, 0x2544c382),
> -       /* VGT_TF_RING_SIZE_UMD -> VGT_TF_RING_SIZE */
> -       SOC15_REG_GOLDEN_VALUE(GC, 0, mmGRBM_CAM_DATA, 0xffffffff, 0x2262c24e),
> -       /* VGT_HS_OFFCHIP_PARAM_UMD -> VGT_HS_OFFCHIP_PARAM */
> -       SOC15_REG_GOLDEN_VALUE(GC, 0, mmGRBM_CAM_DATA, 0xffffffff, 0x226cc24f),
> -       /* VGT_TF_MEMORY_BASE_UMD -> VGT_TF_MEMORY_BASE */
> -       SOC15_REG_GOLDEN_VALUE(GC, 0, mmGRBM_CAM_DATA, 0xffffffff, 0x226ec250),
> -       /* VGT_TF_MEMORY_BASE_HI_UMD -> VGT_TF_MEMORY_BASE_HI */
> -       SOC15_REG_GOLDEN_VALUE(GC, 0, mmGRBM_CAM_DATA, 0xffffffff, 0x2278c261),
> -       /* VGT_ESGS_RING_SIZE_UMD -> VGT_ESGS_RING_SIZE */
> -       SOC15_REG_GOLDEN_VALUE(GC, 0, mmGRBM_CAM_DATA, 0xffffffff, 0x2232c240),
> -       /* VGT_GSVS_RING_SIZE_UMD -> VGT_GSVS_RING_SIZE */
> -       SOC15_REG_GOLDEN_VALUE(GC, 0, mmGRBM_CAM_DATA, 0xffffffff, 0x2233c241),
> -};
> -
>  static const struct soc15_reg_golden golden_settings_gc_10_1[] =
>  {
>         SOC15_REG_GOLDEN_VALUE(GC, 0, mmCB_HW_CONTROL_4, 0xffffffff, 0x00400014),
> @@ -3809,9 +3790,6 @@ static void gfx_v10_0_init_golden_registers(struct amdgpu_device *adev)
>                                                 (const u32)ARRAY_SIZE(golden_settings_gc_10_3_5));
>                 break;
>         case IP_VERSION(10, 1, 3):
> -               soc15_program_register_sequence(adev,
> -                                               golden_settings_gc_10_0,
> -                                               (const u32)ARRAY_SIZE(golden_settings_gc_10_0));
>                 soc15_program_register_sequence(adev,
>                                                 golden_settings_gc_10_0_cyan_skillfish,
>                                                 (const u32)ARRAY_SIZE(golden_settings_gc_10_0_cyan_skillfish));
> --
> 2.25.1
>
