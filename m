Return-Path: <SRS0=vyzA=7C=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A6CAC433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 20 May 2020 21:47:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3928F2072C
	for <amd-gfx@archiver.kernel.org>; Wed, 20 May 2020 21:47:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dkW6jatp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3928F2072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E32E06E8BA;
	Wed, 20 May 2020 21:47:57 +0000 (UTC)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DDD996E8BA
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 May 2020 21:47:56 +0000 (UTC)
Received: by mail-wr1-x430.google.com with SMTP id e16so4648658wra.7
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 May 2020 14:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=8crJC7sErn3BBV4K/WmEekuGwYPUMotFF1D75QTaYlg=;
 b=dkW6jatpqAwxPUMqqZ9yKn+j66DF6mSpLs918u9CESWEG4rVVI2lNyZ/6YRsuwSTc8
 swKbXPI82tUMKCcp4YFrs/n45I0dCRBo+TUBvowmRxpQ6uThdFTEgzVd6KzoXLZGSVxj
 7eAKN7Tj4XdodCC25u9XNbe1RsxQ0KUskbfD7er5ARE3OelPh4VfOkfi7hbijaocsKjo
 EXG+vd3yV3EOGBedXr1XcnQnQt5SiJPxWMdUReWxOkCroZ96Iw474D01b7f+phZQpPVm
 gZy9jifc4fryladF7aOudmSKt2QWls4qOMOFpa+p5EX7hEtw4SWiqd3AmfbdgE0DFMQx
 AZcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=8crJC7sErn3BBV4K/WmEekuGwYPUMotFF1D75QTaYlg=;
 b=J5bCqZ00zAh0+j8BZyTrB5mHU9WXca2PKWRB7qUB6wZ8D6A8HTSDAKZGymYB/bBLUN
 3TZlmolHXTUYhrpbd3FpoOH18Qg4xh0zRViW/n622SWBlTbazptsXEAaFEs3Y0eKOawL
 qiFm3ZYnFbHYv1FDsyY7192f15sZsa2IONKIez+meLUge1db2ieFkL91O4lCdqvFJUdB
 nC9mtg9GJ5Q/ZoWAh2gwJtNtVikUpWqwbpLD29k1LN9tQK1CSpIVqzMFvAMe311IEPGc
 YrTroq3Z4L9toaOOiw+Pp1kpVBAmJPR09UB9Z0fb8U4H3fDHyzhhlBi1XgsZ905HnS/z
 wT7g==
X-Gm-Message-State: AOAM531q8ABBm7NCiG/0eOruC440MXNpRZJwjFIhS6pBX0tWBJ0vuv/B
 ZP9cmdqn/p7zvYhJ6tx8v/auN8xXuSd54v8n6OiCww==
X-Google-Smtp-Source: ABdhPJzd6Ta7YuvkaPt0mCZ0zpY/BsGOdbsbZ2jr1Ra8CGS7Lqz49s5TxdgHdMsKexFtvTdrS9mj155WD0GeMSkAIeE=
X-Received: by 2002:adf:9264:: with SMTP id 91mr5666564wrj.362.1590011275527; 
 Wed, 20 May 2020 14:47:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200520213638.1896-1-amonakov@ispras.ru>
In-Reply-To: <20200520213638.1896-1-amonakov@ispras.ru>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 20 May 2020 17:47:44 -0400
Message-ID: <CADnq5_OmxeZ3yEOGjCjJgOdi_-PTJ-8KhLzz7nnx_yvVLjSe9Q@mail.gmail.com>
Subject: Re: Flaky brightness on Renoir
To: Alexander Monakov <amonakov@ispras.ru>, Harry Wentland <hwentlan@amd.com>, 
 "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>,
 "Leo (Sunpeng) Li" <Sunpeng.Li@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Adding some display people.

On Wed, May 20, 2020 at 5:46 PM Alexander Monakov <amonakov@ispras.ru> wrote:
>
> Hello,
>
> I have a laptop with the recent Renoir SoC. Screen brightness is
> controlled via the amdgpu driver. Unfortunately it doesn't work
> properly: brightness doesn't go below a certain threshold. In one
> experiment I've found the threshold to be about 95 (of 255), which is
> quite high.
>
> There's a bugreport on the tracker from a person with the same laptop
> model as mine that says that the threshold may vary from boot to boot.
>
> So far I was able to find a workaround: avoiding
> dmcu_set_backlight_level like in the patch below gives more reliable
> backlight control (but at the expense of breaking "actual_brightness"
> sysfs file, because it reads from DMCU registers).
>
> What might be the problem and can I help investigate this further? Would
> really like to see this work properly.
>
> Alexander
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_abm.c b/drivers/gpu/drm/amd/display/dc/dce/dce_abm.c
> index b8a3fc505c9b..3274b0d15893 100644
> --- a/drivers/gpu/drm/amd/display/dc/dce/dce_abm.c
> +++ b/drivers/gpu/drm/amd/display/dc/dce/dce_abm.c
> @@ -428,7 +428,7 @@ static bool dce_abm_set_backlight_level_pwm(
>                         backlight_pwm_u16_16, backlight_pwm_u16_16);
>
>         /* If DMCU is in reset state, DMCU is uninitialized */
> -       if (use_smooth_brightness)
> +       if (0 && use_smooth_brightness)
>                 dmcu_set_backlight_level(abm_dce,
>                                 backlight_pwm_u16_16,
>                                 frame_ramp,
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
