Return-Path: <SRS0=sE/Q=OU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B272CC433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Sep 2021 14:12:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78EF561268
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Sep 2021 14:12:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 78EF561268
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D380899F2;
	Thu, 30 Sep 2021 14:12:34 +0000 (UTC)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CCDC389996
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Sep 2021 14:12:32 +0000 (UTC)
Received: by mail-ot1-x32c.google.com with SMTP id
 e66-20020a9d2ac8000000b0054da8bdf2aeso5211906otb.12
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Sep 2021 07:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=I8OiS86lOBsiaFssvtlEX4SKkA4CHhF5h1V16Hyw27I=;
 b=FKQmNmvJTtEmosYKq8ZHpVTokplS0iQu7ymYFxEdNpe+ZFCDYh+KDD1SOa34INbo0L
 aZuDupcTw4xujTyj3TLo1TVVzJmD8U+u55+qBumOJjSCa8MG1rf1tQH2EhqgK2QBG28x
 Ytos/9JjAE/ZwbmA64X/BnvxR0z8hb90UTJstznXLzIBAsGRjk5ctYw6tqDBFZiKnRKK
 bgiSyq5FXNdIwVaKaTQKS2uTvUJrI8F1juqWarqOP5skaDNMN/LfaraPY/1JcgwZUqXi
 bj2p6+owtyUuI25sDLU23Z5DxBb/yc8qmM741I1tEFw0p+APAC4IQ7NqmNjQ7T57w2Sg
 4ORA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=I8OiS86lOBsiaFssvtlEX4SKkA4CHhF5h1V16Hyw27I=;
 b=bGMpXTdpGrICr7GoyAyzeDi6twlXjvLBP+2E+9jdgWtVde34zOIDkH33v3B6zVX3ly
 OkFGYYSR5ZY55r6Fhdfga1skSb8mBPkYC0OTygS9u28GOy2dSZfr1XSI6OkpKNKQBNQG
 owshx8a+hdQWCRVbpyOC9z0uKWvIlFqyxfZ0AL/ulEq34Oo7FQcrHkDsmdvg580qyTh8
 IBP86cUzpwIGg2k3dFnkM9nY+mI6vlGL4Tl4tLYqhwVG0syAaoEo+NfE88ZfOCiusPSx
 3PShLoSp7/WbLYV0V8w4iX8fzzb2bRTbTcWyzsG4vQDT4ByjrQVakHGmD6e9Lf2gn7Do
 wR+A==
X-Gm-Message-State: AOAM530PDndxg9yGHv8Rf5G1QKRMrR91fDDWw14xVO3marH4DoA3lRGC
 zyvzUiYf9upGD8Vf/vUP4CR7XNfCYYBj4PH7Xd4Jg2ZF
X-Google-Smtp-Source: ABdhPJx1KwZPUFeVWgz8gNQPI5SxgN6IZJStBA21xhaTB38H1h4yr2WyjQmAd3pvYz6g0cfo4ft7EebRgUN9rqkEUL8=
X-Received: by 2002:a05:6830:1bc6:: with SMTP id
 v6mr5343260ota.299.1633011152016; 
 Thu, 30 Sep 2021 07:12:32 -0700 (PDT)
MIME-Version: 1.0
References: <CH0PR12MB520112519F74BF4E6F2A9FAE9EA79@CH0PR12MB5201.namprd12.prod.outlook.com>
 <CAHbf0-FbZqpR=F1eteqtNo6X45ZvBNP-2FF4oEg_0W0+7Mu2gg@mail.gmail.com>
 <CADnq5_MQao2NuE3+oQXzvyk8=3Wuu8g-aD=usKr0p++4NpEMYA@mail.gmail.com>
 <CADnq5_OZFdXQLOsaN+1QB=mg-t0GSrZ_XkaLEjBPBdB3rF5YLA@mail.gmail.com>
In-Reply-To: <CADnq5_OZFdXQLOsaN+1QB=mg-t0GSrZ_XkaLEjBPBdB3rF5YLA@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 30 Sep 2021 10:12:20 -0400
Message-ID: <CADnq5_NPe2Qq6bXifsFis5tfe=2Uh4nwOZ4RubfhezkvcPucZg@mail.gmail.com>
Subject: Re: [PATCH 02/02 v2] drm/amd/display: add cyan_skillfish display
 support
To: Mike Lothian <mike@fireburn.co.uk>
Cc: "Liu, Zhan" <Zhan.Liu@amd.com>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Liu,
 Charlene" <Charlene.Liu@amd.com>, 
 "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Wentland,
 Harry" <Harry.Wentland@amd.com>, 
 "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>
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

On Thu, Sep 30, 2021 at 10:10 AM Alex Deucher <alexdeucher@gmail.com> wrote:
>
> On Wed, Sep 29, 2021 at 10:00 PM Alex Deucher <alexdeucher@gmail.com> wrote:
> >
> > On Wed, Sep 29, 2021 at 7:23 PM Mike Lothian <mike@fireburn.co.uk> wrote:
> > >
> > > Hi
> > >
> > > This patch is causing a failure for me when building with clang:
> > >
> > >
> > > Enable DCN201 support in DC (DRM_AMD_DC_DCN201) [Y/n/?] (NEW) y
> > > Enable HDCP support in DC (DRM_AMD_DC_HDCP) [Y/n/?] y
> > > AMD DC support for Southern Islands ASICs (DRM_AMD_DC_SI) [N/y/?] n
> > > Enable secure display support (DRM_AMD_SECURE_DISPLAY) [Y/n/?] y
> > >  DESCEND objtool
> > >  CALL    scripts/atomic/check-atomics.sh
> > >  CALL    scripts/checksyscalls.sh
> > >  CHK     include/generated/compile.h
> > >  UPD     kernel/config_data
> > >  GZIP    kernel/config_data.gz
> > >  CC      kernel/configs.o
> > >  AR      kernel/built-in.a
> > >  CC      drivers/gpu/drm/amd/amdgpu/../display/dc/clk_mgr/clk_mgr.o
> > >  CC      drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_optc.o
> > > clang-12: error: unknown argument: '-mpreferred-stack-boundary=4'
> > > make[4]: *** [scripts/Makefile.build:278:
> > > drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_optc.o] Error 1
> > > make[4]: *** Waiting for unfinished jobs....
> > > make[3]: *** [scripts/Makefile.build:540: drivers/gpu/drm/amd/amdgpu] Error 2
> > > make[2]: *** [scripts/Makefile.build:540: drivers/gpu/drm] Error 2
> > > make[1]: *** [scripts/Makefile.build:540: drivers/gpu] Error 2
> > > make: *** [Makefile:1868: drivers] Error 2
> >
> > The Makefiles for the new stuff added probably need to be fixed up for
> > clang like the other Makefiles.  I can take a look tomorrow.
>
> I don't see anything off in the Makefiles.  Can you try with a clean tree?
>

Nevermind, Harry found it.  patch on the list.

Alex
