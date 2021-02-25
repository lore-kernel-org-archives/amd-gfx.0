Return-Path: <SRS0=Rd3N=H3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD0E4C433DB
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Feb 2021 21:31:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E5C764EC4
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Feb 2021 21:31:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E5C764EC4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E67F16E3EE;
	Thu, 25 Feb 2021 21:31:05 +0000 (UTC)
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com
 [IPv6:2607:f8b0:4864:20::c2a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 795DB6E364;
 Thu, 25 Feb 2021 21:31:04 +0000 (UTC)
Received: by mail-oo1-xc2a.google.com with SMTP id e17so1731605oow.4;
 Thu, 25 Feb 2021 13:31:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=6iJBm8mwb9g0tbzXMjQMrV+sZ/dkoZZpwUu4VHqMwWs=;
 b=saAXPMJHPwxOKN9qHujc6Ftk1IhGH00YldtkPbXQx3+a3J1pTSu/Yb2tjmjutFWZhA
 8plWq8Ark/GQeSFOT0SmX0WX1aXZssKwlutFSMSKrHAKq5vZogkhREelec2C/gHuONws
 kqDP0VF2OJ0YyUDcV7kfHLPfr9zKm6IqeFy4MPOaqsXLInh23ohAnn/y1MwPj9grwvlD
 s9gRKC/NGiSUiV84o5AZmM/0O+SGlh0BBCdw2IZkEsxklVT4XQjQNc2cU145ft7uIKCh
 cxTi98cRbe773Fg1YJZgKY3LwBwqRbtqYCUPiajCu5hqKyfdat7rwFAieRk7vmAHz70c
 NVZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=6iJBm8mwb9g0tbzXMjQMrV+sZ/dkoZZpwUu4VHqMwWs=;
 b=NtS7YDwxbXQdXM0sDurIDqww02Y/Qtu/h6VaSOa4aDa6N/9dplq/O7sROloF0R2TyQ
 MW9ft+wuQri5ze8KvYybkD3D1GXMRkDbEkwfbxpgVypqueKsqPyYseBbmsXeeY7igbnA
 GQM2wQm7CZyN2WrLe9J8R1uNvhy7u/ZgjcR2nL4UjYbc6MP6wc80hGP8iT9hrXWZSk9E
 E3nqUHqAhXsJxS/7fdtxa5aFRp1xSzVaVANWmed2qTk8JUA741+FCLFXU/5trHazp7kL
 WP3FjLLi6UKpTUwNuq6T0rmpSygrkWailuvLuHho14NXZNwTAdWZ+LZCvk3T8UNi29z9
 8mlA==
X-Gm-Message-State: AOAM531CWdFTkKEFBZ/mOCIxQonJE4wIpulvaas19Jc2z4V+0ZcYQ/7/
 vBkDY6aniPh1NiwW4bYaZYi95TMwZTRfGKqYVCk=
X-Google-Smtp-Source: ABdhPJwzqcw5WVktyTlPS7c1vX8XU71qqt0U0NU7W3IdGqEL6xrX54Tk5v2JI/V57TOa0LGRExqirx6rzZes2A/Z/4o=
X-Received: by 2002:a4a:88ee:: with SMTP id q43mr3928324ooh.61.1614288663762; 
 Thu, 25 Feb 2021 13:31:03 -0800 (PST)
MIME-Version: 1.0
References: <1614244742-67869-1-git-send-email-jiapeng.chong@linux.alibaba.com>
In-Reply-To: <1614244742-67869-1-git-send-email-jiapeng.chong@linux.alibaba.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 25 Feb 2021 16:30:52 -0500
Message-ID: <CADnq5_OwCB1+uXRoqHfkHp3t6kvY8Emu=pLgoTJ6VkyWPFJDLw@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: remove unnecessary conversion to bool
To: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
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
Cc: "Leo \(Sunpeng\) Li" <sunpeng.li@amd.com>,
 LKML <linux-kernel@vger.kernel.org>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 Dave Airlie <airlied@linux.ie>, amd-gfx list <amd-gfx@lists.freedesktop.org>,
 "Deucher, Alexander" <alexander.deucher@amd.com>, "Wentland,
 Harry" <harry.wentland@amd.com>, Christian Koenig <christian.koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Feb 25, 2021 at 4:19 AM Jiapeng Chong
<jiapeng.chong@linux.alibaba.com> wrote:
>
> Fix the following coccicheck warnings:
>
> ./drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dpp_cm.c:243:67-72:
> WARNING: conversion to bool not needed here.
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>

Applied.  Thanks!

Alex

> ---
>  drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dpp_cm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dpp_cm.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dpp_cm.c
> index 3398540..102f6a0 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dpp_cm.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dpp_cm.c
> @@ -240,7 +240,7 @@ bool dpp3_program_gamcor_lut(
>                 next_mode = LUT_RAM_A;
>
>         dpp3_power_on_gamcor_lut(dpp_base, true);
> -       dpp3_configure_gamcor_lut(dpp_base, next_mode == LUT_RAM_A ? true:false);
> +       dpp3_configure_gamcor_lut(dpp_base, next_mode == LUT_RAM_A);
>
>         if (next_mode == LUT_RAM_B) {
>                 gam_regs.start_cntl_b = REG(CM_GAMCOR_RAMB_START_CNTL_B);
> --
> 1.8.3.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
