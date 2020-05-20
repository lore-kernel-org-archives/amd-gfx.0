Return-Path: <SRS0=vyzA=7C=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EB0EC433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 20 May 2020 18:25:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04FD120671
	for <amd-gfx@archiver.kernel.org>; Wed, 20 May 2020 18:25:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lUIyRGqQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04FD120671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9996F6E881;
	Wed, 20 May 2020 18:25:30 +0000 (UTC)
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E8B476E881;
 Wed, 20 May 2020 18:25:28 +0000 (UTC)
Received: by mail-wr1-x442.google.com with SMTP id j5so4201309wrq.2;
 Wed, 20 May 2020 11:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=eo5b5Se1PSc+moZJJbYXSgJ+J/ZLwfHiAKwCJ3IRv2g=;
 b=lUIyRGqQJwAX5lPMNTKe5zE7DSioAUBS7Qoev22rUtbOYnnd5+tPPa1nfpRe2cBkGS
 GibQkb+MaIhZ+EmzDyXJe254ILbfOLz/Yq+eGpTaOD7nmhLc+SJQgfu/Np2ZM6HSlzBL
 0W9RYG+He6jQOoGe1TTpdWbE+soWCcQuiWP1HcROjbcqjI5o+5jmtrSjcAo2Y9UxFXJp
 N+kCPLdYqKUmdkTECOz4C1S7xjeQhEKu/49AMU1Tt96w1A/GcuppAHSy+ED/Km1kT+Ku
 GRSKMem2OcIPhJU2KypAUXpEX9InYCLm5jVBFf3SDe96tERhV6gwk1d0KCcaL/Lzc0sZ
 GhQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=eo5b5Se1PSc+moZJJbYXSgJ+J/ZLwfHiAKwCJ3IRv2g=;
 b=NfdDVT32nVsEy3Q8f21xWTEDkpV6o/akm7GXbyvU/lgb8taVdUkLtiMKDjaaXZqTyF
 yQxZhImEfcz/NBHDjgt5/KUuT3pP+vWybNIpiPS7xZB4NC18bjT+/HfQPYLl4sNIrHdc
 ZLEf/oo/GKYP+gA/zwI+Zx5zkSEHFzxMiUIKU7zP/JE23Ao1WFpIFBldsLz0LTIt3FM6
 7yOZVywZD6Am3hjfZHDAuRSAAfpCGOuh7Cqs0oHyyCjxfhaxgOUGQo1QjZ88Wj2f/mb8
 JCoDfltIZLZfAA/JTFW0hYJCDfrn1+xQ4PlmCQmLVrRuOsEFWLraWvav4WNxU0CkDIIW
 f/YA==
X-Gm-Message-State: AOAM530V0HX0T51rsHE9ABKl3PbVMni83gk7g9XSkrKH6W3QIk7XIyxg
 V3TpkrRAMqJSaVLYj4oG6gZwVbKaosESsvAxVck=
X-Google-Smtp-Source: ABdhPJwwNH9GyngZ86V++iCPkPEabkBknCVgBVrDATleJ7ReCJbvrjjWRUOeftgiuvN1mLs1JOGgy3eznBMpVtsNVSk=
X-Received: by 2002:a05:6000:14b:: with SMTP id
 r11mr5592972wrx.124.1589999127661; 
 Wed, 20 May 2020 11:25:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200515051924.12331-1-mario.kleiner.de@gmail.com>
 <20200515051924.12331-3-mario.kleiner.de@gmail.com>
 <7ab95258-02a9-fd39-6806-e6e81ddc295c@amd.com>
In-Reply-To: <7ab95258-02a9-fd39-6806-e6e81ddc295c@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 20 May 2020 14:25:16 -0400
Message-ID: <CADnq5_MJzLC4q8MU9GTmVLzN1kHxy9m15nm3WwsCoPUb-0d2WA@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amd/display: Enable fp16 also on DCE-11.0 -
 DCE-12.
To: Harry Wentland <hwentlan@amd.com>
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
Cc: "Deucher, Alexander" <alexander.deucher@amd.com>,
 Mario Kleiner <mario.kleiner.de@gmail.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>, "Kazlauskas,
 Nicholas" <nicholas.kazlauskas@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, May 20, 2020 at 12:39 PM Harry Wentland <hwentlan@amd.com> wrote:
>
> On 2020-05-15 1:19 a.m., Mario Kleiner wrote:
> > Testing on a Polaris11 gpu with DCE-11.2 suggests that it
> > seems to work fine there, so optimistically enable it for
> > DCE-11 and later.
> >
> > Signed-off-by: Mario Kleiner <mario.kleiner.de@gmail.com>
> > ---
> >  drivers/gpu/drm/amd/display/dc/dce110/dce110_resource.c | 2 +-
> >  drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c | 2 +-
> >  drivers/gpu/drm/amd/display/dc/dce120/dce120_resource.c | 2 +-
> >  3 files changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_resource.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_resource.c
> > index 9597fc79d7fa..a043ddae5149 100644
> > --- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_resource.c
> > +++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_resource.c
> > @@ -410,7 +410,7 @@ static const struct dc_plane_cap plane_cap = {
> >               .pixel_format_support = {
> >                               .argb8888 = true,
> >                               .nv12 = false,
> > -                             .fp16 = false
> > +                             .fp16 = true
>
> Carrizo (DCE 11.0) has a HW bug where FP16 scaling doesn't work. I
> recommend we leave it off here.

I'll drop this hunk for upstream.

Alex

>
> Harry
>
> >               },
> >
> >               .max_upscale_factor = {
> > diff --git a/drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c b/drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c
> > index 4a7796de2ff5..51b3fe502670 100644
> > --- a/drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c
> > +++ b/drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c
> > @@ -411,7 +411,7 @@ static const struct dc_plane_cap plane_cap = {
> >       .pixel_format_support = {
> >                       .argb8888 = true,
> >                       .nv12 = false,
> > -                     .fp16 = false
> > +                     .fp16 = true
> >       },
> >
> >       .max_upscale_factor = {
> > diff --git a/drivers/gpu/drm/amd/display/dc/dce120/dce120_resource.c b/drivers/gpu/drm/amd/display/dc/dce120/dce120_resource.c
> > index 9a9764cbd78d..8f362e8c1787 100644
> > --- a/drivers/gpu/drm/amd/display/dc/dce120/dce120_resource.c
> > +++ b/drivers/gpu/drm/amd/display/dc/dce120/dce120_resource.c
> > @@ -516,7 +516,7 @@ static const struct dc_plane_cap plane_cap = {
> >       .pixel_format_support = {
> >                       .argb8888 = true,
> >                       .nv12 = false,
> > -                     .fp16 = false
> > +                     .fp16 = true
> >       },
> >
> >       .max_upscale_factor = {
> >
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
