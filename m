Return-Path: <SRS0=bDL0=IJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91786C433E0
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Mar 2021 16:13:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36C7B64FA3
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Mar 2021 16:13:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36C7B64FA3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C63D06EE40;
	Thu, 11 Mar 2021 16:13:18 +0000 (UTC)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C59DF6EE40
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Mar 2021 16:13:16 +0000 (UTC)
Received: by mail-ot1-x336.google.com with SMTP id n23so1982940otq.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Mar 2021 08:13:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=U33Jk6pqovMVEgFCyocOKubRYThoJL3POuXh//1YS2g=;
 b=twmXsPsWXiJJ7XowubXwW4OJkltJMzTSp18s6hBTEKO0uSWc+swir3+pG77U9GOpZj
 3awlcxiCE6B/Q825wGyT00HtzBrfsihrjiFE6K4DEgFSMGmVUk0Pjm2zL1UXox2MW+Um
 nUEUdhrd0ZI9jysyGVjc7QhEy7U79Ge3iQvdAWUS6UK/GNdan/CfyL5GjJbAKR3efXtl
 4g3TJEV3liOtCUNQv8GMElXSGqjTIl+0H25eXm1JHL+jz9oad/ceisADLlQu7AN+br3B
 hqSGeVxQkFL9zIdztZkz3423uDITQeusQclGAG+Uh9Ldmg2KhKUVWiFrf6i93k+HLtAZ
 +M3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=U33Jk6pqovMVEgFCyocOKubRYThoJL3POuXh//1YS2g=;
 b=EPZ45l6yLXxTYULW80WQfRsOX323dvFGiFJBP9gI0Uiz4RgqCDttmioPZjq9Rvce/Y
 7omlaf55AAqwbAkcjCSB0Vp1G1Jags9AQQbAwOcJqQBo2CwUiPhGnkqDPBZga7/l5X7z
 ZhJoChaWhZat74bPGl5MFwa1Mjz2/LeBzIwi4TapV2ADiE/SdWha5hqWZSQAuhUdsOTC
 8qeIOiGXuFWVFqpMkUhGnPNXmqD47vkldF2cIfAmPce8IbxQuXR6mx5fdPINVMnSmU+0
 B0UYjuwYf1XXg80FUqoGrCblHIsV8bSiOO1MgeXPnsMv8Zq2fI7Bk3sCqQZmtKg0ZUPe
 ixSg==
X-Gm-Message-State: AOAM530oV0p8cQGAUmvOTb9IezzjsZ9uuY48hQrNYcNhkrp1M+Akj8fu
 mQFNW1paP+Ut09v8j9rp82mx4GZw2DzhBMY0JUWTZDAh
X-Google-Smtp-Source: ABdhPJweEuga3hgpx+q6LOHWkWGi2NJUG49dfKxEGhO/iAMtp+T6mRUgSbgv0gyjqB6qVXkrxhlGd0p3Ng872wTxmNM=
X-Received: by 2002:a05:6830:408f:: with SMTP id
 x15mr7863317ott.132.1615479196175; 
 Thu, 11 Mar 2021 08:13:16 -0800 (PST)
MIME-Version: 1.0
References: <20210309164635.290413-1-Harish.Kasiviswanathan@amd.com>
In-Reply-To: <20210309164635.290413-1-Harish.Kasiviswanathan@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 11 Mar 2021 11:13:05 -0500
Message-ID: <CADnq5_PF53iaEf6cTozWH6f0GU8Qxd-eCDkATmmpx5fSCpEYUg@mail.gmail.com>
Subject: Re: [PATCH] Revert "drm/amdgpu: During compute disable GFXOFF for
 Sienna_Cichlid"
To: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Mar 9, 2021 at 11:46 AM Harish Kasiviswanathan
<Harish.Kasiviswanathan@amd.com> wrote:
>
> This reverts commit 73bf5cad2696fe3a21f70101821405db839ea18e.
>
> Fixed in newer firmware
>
> Signed-off-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 7 -------
>  1 file changed, 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> index fa27262b5c2a..1c6be53313a8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> @@ -639,13 +639,6 @@ void amdgpu_amdkfd_set_compute_idle(struct kgd_dev *kgd, bool idle)
>  {
>         struct amdgpu_device *adev = (struct amdgpu_device *)kgd;
>
> -       /* Temp workaround to fix the soft hang observed in certain compute
> -        * applications if GFXOFF is enabled.
> -        */
> -       if (adev->asic_type == CHIP_SIENNA_CICHLID) {
> -               pr_debug("GFXOFF is %s\n", idle ? "enabled" : "disabled");
> -               amdgpu_gfx_off_ctrl(adev, idle);
> -       }
>         amdgpu_dpm_switch_power_profile(adev,
>                                         PP_SMC_POWER_PROFILE_COMPUTE,
>                                         !idle);
> --
> 2.25.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
