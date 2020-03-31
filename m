Return-Path: <SRS0=uap9=5Q=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4108C43331
	for <amd-gfx@archiver.kernel.org>; Tue, 31 Mar 2020 13:41:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76A352071A
	for <amd-gfx@archiver.kernel.org>; Tue, 31 Mar 2020 13:41:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="re7E2lvf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76A352071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D6B76E31D;
	Tue, 31 Mar 2020 13:41:58 +0000 (UTC)
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20::343])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DAE466E31D
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 Mar 2020 13:41:56 +0000 (UTC)
Received: by mail-wm1-x343.google.com with SMTP id e9so2702433wme.4
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 Mar 2020 06:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=zE6/nqOIDGOgEJMjfGmk+ts+Xpj9l3XK0E5adgkM8/w=;
 b=re7E2lvfnuvdY4b5t1cspD9U7hobUBkGiJdRkYrN2wKB8muVGxWHp7Pip5Qxp77Uy0
 m3QURP/aseSkuk5adm7vtN51T6yadCl4OJ+VBR5E3R0SELtCC9nbF02NA4yu2QARiWQp
 89Qj6XLmCbcnUN6vEq8DPF7anlj4QqRLv2idCkBNfuEDJ4/sFAWRfmsGdjdocwQ+xrCT
 O52xqjLcOp6d1Jxb82ZPLu/JRDS30g6c8JrFItAgZiis6KpzZs77LnroBSJ3YVZ79ud4
 oPWDL78f36OZ+Sdj+F/pcPm4857MQKfPxYUUte3IubG9sxyYMuoAp2vjPcwlE10gIE2i
 WQ2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=zE6/nqOIDGOgEJMjfGmk+ts+Xpj9l3XK0E5adgkM8/w=;
 b=rEkiVGZ5MsQApb3cxVoa0SxMd83y08Hzwm/fswbJpL6VVAMib6sFAJumyB99mgi+g9
 NOiSpsUQ5DkiZN+o0uvyp9j3AfX4owuQBXrTYq55YpU8mW6Epz5rI0XasgWLI3k7qia3
 QJr9LX99kgdJ/gu1yjUYxhSDYIVY6RMcbtsAzFPoItJ961Dg5ADhtgHhGEPCgb9J/DYY
 M2VPeVi4YB/gZW5sxilVKjuPJPQRe6J76SlBwqRdFVBdIzO4qJ3FXJY+8qDDML60cWIT
 FjLriw7ZJpt5H9oD/vSleMSRrCd3mheL98CsbNT6ny6v01QzjqXV/nhP3HJMJV7cAfhc
 yw1w==
X-Gm-Message-State: ANhLgQ05pe8AP3E+usr8bkR8/7s+OAIjN0jKIQMCrwgX0ZjdAB1gJ71R
 zRKRIjGTmeQtG0giJHDs1qEF+K+LPUerVtPqUJpyeA7p
X-Google-Smtp-Source: ADFU+vubF3lxAmy3yiQn0Xt7+kHmwNdN5jjgHW5ng4pY4us9bdcWTsfkXg4VtEqBCHjWWcDZX6+DooLfJ1E82TibXXQ=
X-Received: by 2002:a05:600c:3d1:: with SMTP id
 z17mr3616754wmd.56.1585662115554; 
 Tue, 31 Mar 2020 06:41:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200331101016.2960-1-Yuxian.Dai@amd.com>
In-Reply-To: <20200331101016.2960-1-Yuxian.Dai@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 31 Mar 2020 09:41:44 -0400
Message-ID: <CADnq5_OfZKpAxCPQ5jJ3Xq=4vJYaq7OnpBHpocODOmAYE+9Lhw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/powerplay: using the FCLK DPM table to set the
 MCLK for DPM states consist of three entities :FCLK, UCLK,
 MEMCLK all these three clk change together , MEMCLK from FCLK.
To: Yuxian Dai <Yuxian.Dai@amd.com>
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
Cc: "yuxiadai@amd.com" <yuxiadai@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Mar 31, 2020 at 6:10 AM Yuxian Dai <Yuxian.Dai@amd.com> wrote:
>
> From: "yuxiadai@amd.com" <yuxiadai@amd.com>

Your patch title is too long; it is basically the whole patch
description rather than just a title.  Please split it up between the
title and descriptions.  E.g.,

drm/amdgpu/powerplay: fix MCLK DPM handling for renoir

Using the FCLK DPM table to set the MCLK for DPM states consist of
three entities:
FCLK
UCLK
MEMCLK
All these three clk change together, MEMCLK from FCLK, so use the fclk
frequency.

With that fixed, patch is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

>
> Change-Id: Ia45f3069fc7ae56db495cb5a3865e2c50c550774
> Signed-off-by: Yuxian Dai <Yuxian.Dai@amd.com>
> ---
>  drivers/gpu/drm/amd/powerplay/renoir_ppt.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/powerplay/renoir_ppt.h b/drivers/gpu/drm/amd/powerplay/renoir_ppt.h
> index 2a390ddd37dd..89cd6da118a3 100644
> --- a/drivers/gpu/drm/amd/powerplay/renoir_ppt.h
> +++ b/drivers/gpu/drm/amd/powerplay/renoir_ppt.h
> @@ -37,7 +37,7 @@ extern void renoir_set_ppt_funcs(struct smu_context *smu);
>                         freq = table->SocClocks[dpm_level].Freq;        \
>                         break;                                          \
>                 case SMU_MCLK:                                          \
> -                       freq = table->MemClocks[dpm_level].Freq;        \
> +                       freq = table->FClocks[dpm_level].Freq;  \
>                         break;                                          \
>                 case SMU_DCEFCLK:                                       \
>                         freq = table->DcfClocks[dpm_level].Freq;        \
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
