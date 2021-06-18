Return-Path: <SRS0=S25v=LM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 454D3C48BE8
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Jun 2021 20:38:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F06DA6124C
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Jun 2021 20:38:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F06DA6124C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9088B6EA98;
	Fri, 18 Jun 2021 20:38:06 +0000 (UTC)
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com
 [IPv6:2607:f8b0:4864:20::230])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D4A3B6EA98;
 Fri, 18 Jun 2021 20:38:05 +0000 (UTC)
Received: by mail-oi1-x230.google.com with SMTP id s23so11881062oiw.9;
 Fri, 18 Jun 2021 13:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=NzQpDhklEQ/5JlkHM/IA/NZF6AkpVhxvXEzA5dRQIjI=;
 b=p70oAnIs6IQq6Ii4vFXv91weYphLY4hkgeFYkNdbJQZ26R/K66sFhdHxqJs4SAkro0
 XaRrirrgceTLhhbdLevolozfeNf2idvkRPM5qqIN5qRf0p+iD0jxmIPVMrPemAhpovbb
 wu34ka+hGc7vqvV6Er3UrxFku3iCwBrRCtC1yYbfYrx0t7KeI2R9TMZ2GRYvZ/pzbtGz
 ctMc97NUhOkBMxgNGPTyslklR/Ggvl8MDJIIK3/HrUAoaR/O1KNlVA3V9YxKHNq4oVLZ
 SUqFtUqA7F+cGhOfTpGCB4mz5f4MFTfnD9yB3qabg5qAmtyB2+3v3cBC7ZziZ1UaXr62
 Pabw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=NzQpDhklEQ/5JlkHM/IA/NZF6AkpVhxvXEzA5dRQIjI=;
 b=XWmsiephK2ihP2FRb0vmvp2acIbYusBUe49L2HMjuFRXzIcKvGteofzQFLsWeXSlHt
 946vgkGlZSHWO0qqqVvrEDDnrPDt5zMe3NeQL1PVpRJxNvTm1+ZUBJfOBfdnaXHnMkHz
 MI3DSiaNFl1/QxjxEyVzEbDykEGVd8RgT6ItWhPcjwujhp59Eaxx2lmhpvHYeYgd5zNb
 e9PKWpMWjQBPMiUwBNwIRswIiW3/rjuEBOpaOOG7f1qTV7R+FsJnErW4064+5C21IrsJ
 zUwQqCZob4+jYT5xlEDCgDfxWZi0rTbWWv0SvlKPlmWMe69MxiL+F6PBJy55x4NtswXe
 jH8w==
X-Gm-Message-State: AOAM531h0BdgvfmqckxHxpRv6VLt/pMyI9JP96LP1VblOLarUyb7sCZD
 5rnbsjrHCmfkbQlw4H+/s/bbcrNq/e0JPVx463I=
X-Google-Smtp-Source: ABdhPJwPkOTpTcBJLf0vMYnm7L/iRZoDmTGcxgxVQ2BTrNe/wrDM7fXiHCbU+D1ce1/UDivRGWO3a/Ma2FItssBnnk0=
X-Received: by 2002:a05:6808:999:: with SMTP id
 a25mr8503622oic.123.1624048685292; 
 Fri, 18 Jun 2021 13:38:05 -0700 (PDT)
MIME-Version: 1.0
References: <1623979403-50239-1-git-send-email-zhangshaokun@hisilicon.com>
 <f934cbe6-369d-a7ad-ac03-3c8dcc6526a2@amd.com>
In-Reply-To: <f934cbe6-369d-a7ad-ac03-3c8dcc6526a2@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 18 Jun 2021 16:37:54 -0400
Message-ID: <CADnq5_MBP_ATmZuNrhLTeOCOkXH1SYet7NmdJcTYCKe6Wa34xg@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Remove the repeated dpp1_full_bypass
 declaration
To: Harry Wentland <harry.wentland@amd.com>
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
Cc: Shaokun Zhang <zhangshaokun@hisilicon.com>, Leo Li <sunpeng.li@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Applied.  Thanks!

On Fri, Jun 18, 2021 at 9:48 AM Harry Wentland <harry.wentland@amd.com> wrote:
>
>
>
> On 2021-06-17 9:23 p.m., Shaokun Zhang wrote:
> > Function 'dpp1_full_bypass' is declared twice, so remove the repeated
> > declaration and unnessary blank line.
> >
> > Cc: Harry Wentland <harry.wentland@amd.com>
> > Cc: Leo Li <sunpeng.li@amd.com>
> > Cc: Alex Deucher <alexander.deucher@amd.com>
> > Signed-off-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
>
> Reviewed-by: Harry Wentland <harry.wentland@amd.com>
>
> Harry
>
> > ---
> >  drivers/gpu/drm/amd/display/dc/dcn10/dcn10_dpp.h | 2 --
> >  1 file changed, 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_dpp.h b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_dpp.h
> > index 9a1f40eb5c47..71b3a6949001 100644
> > --- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_dpp.h
> > +++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_dpp.h
> > @@ -1497,8 +1497,6 @@ void dpp1_cnv_setup (
> >               enum dc_color_space input_color_space,
> >               struct cnv_alpha_2bit_lut *alpha_2bit_lut);
> >
> > -void dpp1_full_bypass(struct dpp *dpp_base);
> > -
> >  void dpp1_dppclk_control(
> >               struct dpp *dpp_base,
> >               bool dppclk_div,
> >
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
