Return-Path: <SRS0=sE/Q=OU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59490C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Sep 2021 14:10:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 240A1619F5
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Sep 2021 14:10:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 240A1619F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 633826E40D;
	Thu, 30 Sep 2021 14:10:53 +0000 (UTC)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 377426E40D
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Sep 2021 14:10:52 +0000 (UTC)
Received: by mail-ot1-x333.google.com with SMTP id
 l16-20020a9d6a90000000b0053b71f7dc83so7403468otq.7
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Sep 2021 07:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=jxJYAEg41OYhNZMSNUY1eZAVBT8EpxEJB/ULJSPBTgA=;
 b=j0W1pJFSfo58sgiWkuMkJBgzVjoluTpdqcwtyqGVb4b9stSp89pnFmwCl/cAdhVGxK
 5tzkIW3wkkTgMddhfcNHFLbJJOn906wzJ+Rc1XDDHTSdv0daGdKDxAL54wLiCP2nYD/9
 naDboGDXdsl6ZhXtVW8nhW4Ibb3jUUhTqyT71PDijC9fZw3oGpIWywX4VkFLlwDDvc+c
 quHCbMYNtS4chIY82Pebrre1EQSwqN2BJpgNYJkqS1ipZqC6RHRK0Nqi6F+iVfEsjty/
 blr9rq1mKb4taLSS4zks/ZmYuxhwnBtPvp5v7r7ElQJdBBzRGZHIWMEWUNqLTz1S8moL
 gr9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=jxJYAEg41OYhNZMSNUY1eZAVBT8EpxEJB/ULJSPBTgA=;
 b=6JSQy15EGwGYJ8l9/Ru5OCPBdmRn1xK0cHlX9sn7nvsoqWtKnkUR5rkajYRU6CD2/r
 npy2Pz/3zPKtrK203PcpUkGSnqKdMqMF+WMC4gtghi26k0Yc/giwgUecMcpmjugpvAxR
 HdyzIeruNj43hZKSF4hi9e4YIB0OJMrh378k2eqEP0YymbxL6yb6Aknk/2oWqj9vrnvr
 49LtyOE1j6HwLPlZejJSrajMogfg2mBJrIhn9KnyBloDLfFi5YjOUFNszmJ7v9nvi3lL
 M9wChkBz69NYWUJevdd/BO4Q3gonidon4qQ7WzpmVYmZ1gi21/2RcTHHDuQnK7NWfVkG
 1I1w==
X-Gm-Message-State: AOAM530YxzCR/YBUxdeV3zJXkeu1U2qPlAkFy0Qjx6c0BlVQqpm+vB/3
 X1PYaTeAHrzFXzm7IJ0EWPYeYz8di8KQJ/sAxXA=
X-Google-Smtp-Source: ABdhPJysv7pAbxhSudZ585gT9KvWk5OtCyYq6Qk5987lrmzVE2c9yv1vtqyfR9xtN1e7M28SLFvAH/wBUzU+AUDnrBo=
X-Received: by 2002:a9d:6d14:: with SMTP id o20mr5562664otp.357.1633011051297; 
 Thu, 30 Sep 2021 07:10:51 -0700 (PDT)
MIME-Version: 1.0
References: <CH0PR12MB520112519F74BF4E6F2A9FAE9EA79@CH0PR12MB5201.namprd12.prod.outlook.com>
 <CAHbf0-FbZqpR=F1eteqtNo6X45ZvBNP-2FF4oEg_0W0+7Mu2gg@mail.gmail.com>
 <CADnq5_MQao2NuE3+oQXzvyk8=3Wuu8g-aD=usKr0p++4NpEMYA@mail.gmail.com>
In-Reply-To: <CADnq5_MQao2NuE3+oQXzvyk8=3Wuu8g-aD=usKr0p++4NpEMYA@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 30 Sep 2021 10:10:40 -0400
Message-ID: <CADnq5_OZFdXQLOsaN+1QB=mg-t0GSrZ_XkaLEjBPBdB3rF5YLA@mail.gmail.com>
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

On Wed, Sep 29, 2021 at 10:00 PM Alex Deucher <alexdeucher@gmail.com> wrote:
>
> On Wed, Sep 29, 2021 at 7:23 PM Mike Lothian <mike@fireburn.co.uk> wrote:
> >
> > Hi
> >
> > This patch is causing a failure for me when building with clang:
> >
> >
> > Enable DCN201 support in DC (DRM_AMD_DC_DCN201) [Y/n/?] (NEW) y
> > Enable HDCP support in DC (DRM_AMD_DC_HDCP) [Y/n/?] y
> > AMD DC support for Southern Islands ASICs (DRM_AMD_DC_SI) [N/y/?] n
> > Enable secure display support (DRM_AMD_SECURE_DISPLAY) [Y/n/?] y
> >  DESCEND objtool
> >  CALL    scripts/atomic/check-atomics.sh
> >  CALL    scripts/checksyscalls.sh
> >  CHK     include/generated/compile.h
> >  UPD     kernel/config_data
> >  GZIP    kernel/config_data.gz
> >  CC      kernel/configs.o
> >  AR      kernel/built-in.a
> >  CC      drivers/gpu/drm/amd/amdgpu/../display/dc/clk_mgr/clk_mgr.o
> >  CC      drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_optc.o
> > clang-12: error: unknown argument: '-mpreferred-stack-boundary=4'
> > make[4]: *** [scripts/Makefile.build:278:
> > drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_optc.o] Error 1
> > make[4]: *** Waiting for unfinished jobs....
> > make[3]: *** [scripts/Makefile.build:540: drivers/gpu/drm/amd/amdgpu] Error 2
> > make[2]: *** [scripts/Makefile.build:540: drivers/gpu/drm] Error 2
> > make[1]: *** [scripts/Makefile.build:540: drivers/gpu] Error 2
> > make: *** [Makefile:1868: drivers] Error 2
>
> The Makefiles for the new stuff added probably need to be fixed up for
> clang like the other Makefiles.  I can take a look tomorrow.

I don't see anything off in the Makefiles.  Can you try with a clean tree?

Alex
