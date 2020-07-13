Return-Path: <SRS0=fQkT=AY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1CF4C433E3
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jul 2020 14:20:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FA1D205CB
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jul 2020 14:20:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PH5orvZS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FA1D205CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1420B89BAF;
	Mon, 13 Jul 2020 14:20:58 +0000 (UTC)
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 72E5789BAF
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jul 2020 14:20:56 +0000 (UTC)
Received: by mail-wr1-x441.google.com with SMTP id a6so16760236wrm.4
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jul 2020 07:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=a6bxxFzzuJGmCa68espyiZNh5uUFyTNWWZq680ogJEo=;
 b=PH5orvZS39q9muXWwSvzWP+UY5uZNN/n3r6SHUo736f5TJUePZ1ozy6I2IybdgmIs7
 3/IiUpjHmKGzznOOUwzroJTUcEnMKAwjXFPNn8smWl7oMSJtz7Tuu6VK2VvJBTXh1wvi
 6YdgFKnlMjVMna2r9YhTIvKtPyS35kXavCApR9x/CyUzrmD4ggNCUKXhS5ZuSKOUG4uc
 1XcK7mN/cDSaL/tyzk7tpltalC8T5ITcnaezTRVx/LsD9DFG49p2TYCKizs8DFitVdNM
 c3ysNwkHbNlZqyNZtiBpRGkH+4yYzf8a9Z62D8q+bAEmpFVFI5kX458Us4CNHDrr+1BE
 BJ0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=a6bxxFzzuJGmCa68espyiZNh5uUFyTNWWZq680ogJEo=;
 b=cJLG7uZYXjzP46Rl2nNzIwh76jXcHOjYg+/enRO9cIlhtwtgxm/p2m0sYGGP4ErlWh
 2IXMG/6Se/cYbDW78nIB8CCuj7ZR1kjWMqywB7xodMfEHso1jZiN/R2LWFxgZ4T8hdUA
 5RbjUSlzLzOLJSvwRNszPpP2Qfnr2wfjO8jG/ztyozz7Jvj2F18UZT6R/mOxD/uuLBeF
 FDW6E1dh7ozR75HIRU/1M2BtPZb2diEaOn7QpscAAR68raa+wVt3wHMJAJMhlwgxdc9k
 oUqxEqORnX3CmNzKuZqWKvXMLr4fD2hgiU4Wdcqymnkm1ZiB2NZGatDW/Pkzt4VdQYZG
 N1mg==
X-Gm-Message-State: AOAM532RQDuxHHBeUos99BgYnGyCw1kAV+cW2V3kfCtiAQ2JHdl4wzVU
 54NL1M30/9NzzO9+u+0RVSZ+PzHjQRmhMGfUslE=
X-Google-Smtp-Source: ABdhPJy4aNyYUKpH3rHqgjstPH9PRQdGMgeoZzXBep4e/4+7dXlafxmAEq0PqoaRn4lm2kDv8kyy/uREZWnVGWFKKBw=
X-Received: by 2002:adf:ef89:: with SMTP id d9mr84921734wro.124.1594650055130; 
 Mon, 13 Jul 2020 07:20:55 -0700 (PDT)
MIME-Version: 1.0
References: <1594629261-18409-1-git-send-email-curry.gong@amd.com>
In-Reply-To: <1594629261-18409-1-git-send-email-curry.gong@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 13 Jul 2020 10:20:43 -0400
Message-ID: <CADnq5_N9BqAZTzwV2WFd_edx3vWPWF2gCH_Smozyj9kueeuTDQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/powerplay: Modify SMC message name for setting
 power profile mode
To: chen gong <curry.gong@amd.com>
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

On Mon, Jul 13, 2020 at 4:34 AM chen gong <curry.gong@amd.com> wrote:
>
> I consulted Cai Land(Chuntian.Cai@amd.com), he told me corresponding smc
> message name to fSMC_MSG_SetWorkloadMask() is
> "PPSMC_MSG_ActiveProcessNotify" in firmware code of Renoir.
>
> Strange though it may seem, but it's a fact.

Weird.
Acked-by: Alex Deucher <alexander.deucher@amd.com>

>
> Signed-off-by: chen gong <curry.gong@amd.com>
> ---
>  drivers/gpu/drm/amd/powerplay/renoir_ppt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
> index 5071cfb..4fcb51e 100644
> --- a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
> +++ b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
> @@ -698,7 +698,7 @@ static int renoir_set_power_profile_mode(struct smu_context *smu, long *input, u
>                 return -EINVAL;
>         }
>
> -       ret = smu_send_smc_msg_with_param(smu, SMU_MSG_SetWorkloadMask,
> +       ret = smu_send_smc_msg_with_param(smu, SMU_MSG_ActiveProcessNotify,
>                                     1 << workload_type,
>                                     NULL);
>         if (ret) {
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
