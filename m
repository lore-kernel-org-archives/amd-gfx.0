Return-Path: <SRS0=mGSI=DF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74F8AC2D0A8
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Sep 2020 20:32:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E38912080A
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Sep 2020 20:32:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RfaOXYDQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E38912080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4405B89E59;
	Mon, 28 Sep 2020 20:32:46 +0000 (UTC)
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com
 [IPv6:2a00:1450:4864:20::443])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 53A4589E59
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Sep 2020 20:32:45 +0000 (UTC)
Received: by mail-wr1-x443.google.com with SMTP id e16so2790007wrm.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Sep 2020 13:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=AY/xYXYTnDSqeOYQ0hq5T0QGCFhtcMryz7YPw/IC+FI=;
 b=RfaOXYDQzM0HX4Xqekbudqgk5YOIQ3NdMgh2AV7m4TXSHCwDe+Xd1A46GG3PP2jhuk
 QhJO5NCf/yg1GbGaSLmLv7H3xVkfEtEoiIWB0m2lSBUGO+Ttvh6EgSO0BxlIbc6Ae/5+
 wtJBdPI4ypbq2z8x2M4gnyfwjNyzkBAQfQwgVtpjGVdS678JXqsf9GahpH2ADxjFURYC
 nvzmTFYJE9ykS4hdKvltHA7/w447LJ0uEzntVV5ltkn5+x/UCDmIg6VP8zCQPlAVtH9K
 sIz0bE+IB5SECZudQ/J6Vv2KixJD+11Bycralz8/+W/4ECVbzkX3UQbS4t8WBl5/ylLq
 oOpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=AY/xYXYTnDSqeOYQ0hq5T0QGCFhtcMryz7YPw/IC+FI=;
 b=a/sYahwW/9QHG66O2tz5bfrENtPPRD7W1uPmUt7iuyZ3sOED4bjnGGlocv96Ws+hIQ
 YpgAq4Kyrt513AlJxuoZgFQ9nxz392muHUCY63tQ81kGBzsjuj5KXHgoQpyOTQesanqU
 +YKBDNnChOa2IMR3dvjF/ToA+prdMX1UMUSAwWPlJpC98q2kMyusozy7GfhsWvxxRP2+
 LmC5+f8pf7Mmiu+OSzKNYJ1sKJWg7GcJQUsdwweXShRgIFSRupFD/63mxcUEZz0FHVnR
 m1BungQdz8M1gAKWpGapdSq/08OUHhoCVrmVRv8BlA8FDPI3J3YfnG79EDc6bw8rnHFd
 2zKA==
X-Gm-Message-State: AOAM530T7jnI4ck2Gg/62BGFX6BJ5iDfdeqXrxYST7kNC7TkS2osYsIP
 SZU9Cvg/RhXewulBfOvljNUgJKfW4ioUfp/Cob4=
X-Google-Smtp-Source: ABdhPJyUDnmI/dLlDiQ/yHiRycGLqTUAU4Uns6hsDI9iCVONjHWz2o+f8nbnFPYHZHAyZ7Fwlc8BjR9tf57mQqlyuBw=
X-Received: by 2002:adf:dd82:: with SMTP id x2mr233145wrl.419.1601325163973;
 Mon, 28 Sep 2020 13:32:43 -0700 (PDT)
MIME-Version: 1.0
References: <7cc7d590-f713-2060-6bac-37bed0df618a@ettle.org.uk>
 <CADnq5_OEzoEP93+MsGN1tspy0OrxVTkujKUhs+6LryVApvERkw@mail.gmail.com>
 <286845a3-4903-c169-aa36-1eb986492ea3@ettle.org.uk>
 <CADnq5_O8Wzddr3LryTuQ5Jqc5yt51wqkxv6zbSbr0_RBSQCA4g@mail.gmail.com>
 <967f82b1-cf5b-473b-c9b3-d9f9df588cc7@amd.com>
 <ad59a8c59d52c40a89b7b4fd032df043e0747f27.camel@ettle.org.uk>
 <6583647a-7147-4f5b-0412-d3be77ca7fe2@gmail.com>
 <aa941ec6-994e-30c0-74fc-0d13734204bf@amd.com>
 <4e81ba76607f5919a6a1b9210b15f10668fb704b.camel@ettle.org.uk>
In-Reply-To: <4e81ba76607f5919a6a1b9210b15f10668fb704b.camel@ettle.org.uk>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 28 Sep 2020 16:32:32 -0400
Message-ID: <CADnq5_MffJ5_0fjkJW+k9_OCDkocrMOQm=NS8gS93HDSB9AZ8g@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/dc: Pixel encoding DRM property and module
 parameter
To: James Ettle <james@ettle.org.uk>
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
Cc: Harry Wentland <harry.wentland@amd.com>, "Siqueira,
 Rodrigo" <Rodrigo.Siqueira@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Christian Koenig <christian.koenig@amd.com>, Harry Wentland <hwentlan@amd.com>,
 "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Sep 28, 2020 at 4:24 PM James Ettle <james@ettle.org.uk> wrote:
>
> On Mon, 2020-09-28 at 16:12 -0400, Kazlauskas, Nicholas wrote:
> >
> > The problem with the module parameters is that it'd be applying a
> > default to every DRM connector. No way to specify different defaults
> > per
> > DRM connector, nor do we know the full connector set at driver
> > initialization. The list is dynamic and can change when you
> > plug/unplug
> > MST displays.
>
> I just want to point out that the module parameter does support
> connector-specific values, e.g.
>
>   amdgpu.pixel_encoding=HDMI-A-1:rgb
>
> should only affect the connector named HDMI-A-1 (unless I've coded it
> wrong -- I don't have enough video ports to test it thoroughly). If
> there's no such-named connector the parameter should be ignored. In
> contrast with no named connector given, e.g.
>
>   amdgpu.pixel_encoding=rgb
>
> should match any connector. Multiple connectors can be given comma-
> separated. I admit the solution here is crude -- it just stores the
> string and rescans it when required.

Yes, but module parameters global for all devices claimed by that
driver.  E.g., if you have a system with 2 or 3 AMD GPUs in it, that
will be applied to all of them.  I think if we want to be able to set
KMS properties on the kernel command line, we should add the
functionality to the drm core so it works for all drivers and
properties.  We already have this for basic modesetting.

Alex
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
