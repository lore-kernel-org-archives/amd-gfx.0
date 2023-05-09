Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66264C77B75
	for <amd-gfx@archiver.kernel.org>; Tue,  9 May 2023 16:53:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C03D010E3A1;
	Tue,  9 May 2023 16:53:03 +0000 (UTC)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5DA0B10E3A0
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 May 2023 16:53:01 +0000 (UTC)
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-50bc570b4a3so11454389a12.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 09 May 2023 09:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=froggi.es; s=google; t=1683651179; x=1686243179;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=kCSph6RPin0zDIowWuB4TbGOKDvCrFa8+qjOjCD0AQ4=;
 b=bgLHKdztA0Ur7FCUZ9YOsYhFLxYrBT6I8hQLzWmJMKYsmvHSK7RAep9JO4Uec582rt
 yfWJ7w3icpPTDLlo4Q/9I1/CL7cVlBb4ktsxhCECciEQUInOOOIeiNw+fkyZnouCrWAi
 unFFng4n6RY8Wa0FN2Sad3kx9WRKldxQnsoCJfig+WC/33IXG3icw2OkYfJdaeZMNLdV
 oN32xi4AOFUDqeMg62xOV9QI4yWBIBJZyF7pu55yx9vKqip5vE7/fcG+e+onBhONBZQ2
 /CFFGRNkW/+V1KnK3U8ul5lJHZKIalTeiLjY+W+Bz0eUa932FgTLXNa6kfV94MkxNciq
 4q3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1683651179; x=1686243179;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kCSph6RPin0zDIowWuB4TbGOKDvCrFa8+qjOjCD0AQ4=;
 b=clnjdF507RmHIQzfLovklkfz6Wz80JFzo9zddCKaIpNrFCx3JZsqUgq1Ue6GZhzWjt
 MAcxUNisT70xiXrXZfmeLU7I62hp86xZnQS82y+TXHvD7IijxVzpG+erh4Ju8PjT41BZ
 j+cDzMooQ9zZhVGqwWcZVzvJ7uSWxW0Am8o8yRSzt74yHRP+81WGur/SnyI/jIn9E+dR
 x0lX7KoopoqpamSXLUyT9TPuVA430C15MUm9GQhXnQSRQxVmnyteMwKLethi8UrpiPeA
 MCs6RzLbIAnIxBoyABrcZ47nkM5R3f2MHh4Bp1cVFpjHsRS94rk1CcQhwKjxjP5uVwk/
 OnXg==
X-Gm-Message-State: AC+VfDx45J9OS8Gydrh2OjfDz89u12vxbrWdba9h5Xi2Dzy+z4wFg+v7
 L1OHL8NBotYZK0ZJd1Qa/ARqa4aae1FE88rZ3qk/NA==
X-Google-Smtp-Source: ACHHUZ4YlFj73/y7wqqAibWxww81w4v76opgy9ewBq6NOW0La7GEnHmTx+ZD6gFf8zsVDFwmkiEY/478DC4l5ouHyS8=
X-Received: by 2002:aa7:d50a:0:b0:50b:d4e8:317f with SMTP id
 y10-20020aa7d50a000000b0050bd4e8317fmr12139312edq.13.1683651179673; Tue, 09
 May 2023 09:52:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230423141051.702990-1-mwen@igalia.com>
 <20230423141051.702990-4-mwen@igalia.com>
 <613b2431-7d05-fb44-25d7-dba59e5eca3c@amd.com>
 <20230509162353.7hak3fda43fim3ho@mail.igalia.com>
In-Reply-To: <20230509162353.7hak3fda43fim3ho@mail.igalia.com>
From: Joshua Ashton <joshua@froggi.es>
Date: Tue, 9 May 2023 16:52:48 +0000
Message-ID: <CAEZNXZARW1uxYz1G2gGt-U2VDCaXBZNNAK-UsXuMeHVufU5YLA@mail.gmail.com>
Subject: Re: [RFC PATCH 03/40] drm/amd/display: introduce Steam Deck color
 features to AMD display driver
To: Melissa Wen <mwen@igalia.com>
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
Cc: Sebastian Wick <sebastian.wick@redhat.com>,
 Shashank Sharma <Shashank.Sharma@amd.com>, sunpeng.li@amd.com,
 airlied@gmail.com, Xinhui.Pan@amd.com,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, Xaver Hugl <xaver.hugl@gmail.com>,
 dri-devel@lists.freedesktop.org,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 Alex Hung <alex.hung@amd.com>, amd-gfx@lists.freedesktop.org, daniel@ffwll.ch,
 Alex Deucher <alexander.deucher@amd.com>,
 Harry Wentland <harry.wentland@amd.com>, christian.koenig@amd.com,
 linux-kernel@vger.kernel.org, sungjoon.kim@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

I think the idea is that we wouldn't have a config option so it
doesn't inherently become linux kernel uAPI?

Then we can just build our SteamOS kernels with that definiton set.

On Tue, 9 May 2023 at 16:26, Melissa Wen <mwen@igalia.com> wrote:
>
> On 05/08, Harry Wentland wrote:
> > On 4/23/23 10:10, Melissa Wen wrote:
> > > We are enabling a large set of color calibration features to enhance KMS
> > > color mgmt but these properties are specific of AMD display HW, and
> > > cannot be provided by other vendors. Therefore, set a config option to
> > > enable AMD driver-private properties used on Steam Deck color mgmt
> > > pipeline.
> > >
> > > Co-developed-by: Joshua Ashton <joshua@froggi.es>
> > > Signed-off-by: Joshua Ashton <joshua@froggi.es>
> > > Signed-off-by: Melissa Wen <mwen@igalia.com>
> > > ---
> > >  drivers/gpu/drm/amd/display/Kconfig | 6 ++++++
> > >  1 file changed, 6 insertions(+)
> > >
> > > diff --git a/drivers/gpu/drm/amd/display/Kconfig b/drivers/gpu/drm/amd/display/Kconfig
> > > index 06b438217c61..c45a8deb1098 100644
> > > --- a/drivers/gpu/drm/amd/display/Kconfig
> > > +++ b/drivers/gpu/drm/amd/display/Kconfig
> > > @@ -53,5 +53,11 @@ config DRM_AMD_SECURE_DISPLAY
> > >              of crc of specific region via debugfs.
> > >              Cooperate with specific DMCU FW.
> > >
> > > +config STEAM_DECK
> > > +   bool "Enable color calibration features for Steam Deck"
> > > +   depends on DRM_AMD_DC
> > > +   help
> > > +     Choose this option if you want to use AMDGPU features for broader
> > > +     color management support on Steam Deck.
> > >
> >
> > If we can drop this (i.e. don't offer a CONFIG_ option to allow enablement of
> > the uAPI, but build with -DCONFIG_STEAM_DECK) it would go a long way to keep
> > us from requiring to support this forever.
>
> I see, I'll follow this path. Still on that, I've changed
> CONFIG_STEAM_DECK (too generic) to CONFIG_DRM_AMD_COLOR_STEAMDECK.
> Does it sound better?
>
> Thanks,
>
> Melissa
>
> >
> > Harry
> >
> > >  endmenu
> >
> >
