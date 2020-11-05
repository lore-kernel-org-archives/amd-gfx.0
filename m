Return-Path: <SRS0=AVpe=EL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25600C4741F
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Nov 2020 18:15:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5AF920709
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Nov 2020 18:15:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="IyWaPau7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5AF920709
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D4E66EDD9;
	Thu,  5 Nov 2020 18:15:09 +0000 (UTC)
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com
 [IPv6:2607:f8b0:4864:20::342])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 187AD6EDDB
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Nov 2020 18:15:08 +0000 (UTC)
Received: by mail-ot1-x342.google.com with SMTP id b2so2296234ots.5
 for <amd-gfx@lists.freedesktop.org>; Thu, 05 Nov 2020 10:15:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=2lVJy0oZJ1HKj/RNi/yGkNbXnVBFsYr/3+ED5ZMQfKw=;
 b=IyWaPau7ZYEzIkgrk5Vh4h4G9HhBgXbnf18iSExSSwD8Va8GOuKADUz4CytksalbiW
 MzScsBKf5oiY2HuZ1YhHj0f7X2yZf4RR6/ROIepItR8F8D/GCz6dcRvPz2s9Pv5dXK3q
 wNxzRh7wgI7g0lSub9uEkZLBBMgnB7KSZ/94o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=2lVJy0oZJ1HKj/RNi/yGkNbXnVBFsYr/3+ED5ZMQfKw=;
 b=Sntu9UykqOVsCZcp11UX4BMJkVIxoEaiqxdrIOkQVXzZE7KIFtjHo6f3T+j4wQQpQ6
 c+XAWbSi+nti7c5K41xA6bDx961NvlAuEB4VjI4k370Nle3iAaw8kcF8SRPMZoLSuraa
 s80nAgwGDZ7aHW0yBf+gwK+/tIRlkk1SYzrb16haZi8kouptQN2HBz2WVFfRbsNepQIL
 6tt+Ubn/ipBKTBHZkQoKDHlfpW2/G+yCgii5Ws5W226mFgifAqmbjaPTnGV0YZ9t1JR0
 mGZ9brTXZ0DGrcY8kVaLeHhKiPo24Tsfxvqzfc0+qjjdimqNZTK2hPq5yXaEr1QpoEAI
 CDIg==
X-Gm-Message-State: AOAM531FNn6/e17a114kM3CORC+qKcN0vq1uEZ7uFvNn8ykX7bXSsHlS
 JXXehoEyGseyQ5uHJfMhAdwCa3ksae4tmC7d1VizpA==
X-Google-Smtp-Source: ABdhPJz6LySZvQ0VpbbSmLJZyloCrKQbelizcXBsEwRVJaITj+vGbbcw3XfkOTnXZG1mD1JdtddL+vEJaCj1UVIENNw=
X-Received: by 2002:a9d:3b4:: with SMTP id f49mr2710790otf.188.1604600105882; 
 Thu, 05 Nov 2020 10:15:05 -0800 (PST)
MIME-Version: 1.0
References: <20201105144517.1826692-1-lee.jones@linaro.org>
 <20201105164841.GH485884@ulmo> <20201105181053.GP4488@dell>
In-Reply-To: <20201105181053.GP4488@dell>
From: Daniel Vetter <daniel@ffwll.ch>
Date: Thu, 5 Nov 2020 19:14:54 +0100
Message-ID: <CAKMK7uEyW_KJ1qC3gLASDe4Qyk_5UMr+yCu7VVVdAq+Z0J6RwQ@mail.gmail.com>
Subject: Re: [PATCH 00/19] [Set 1] Rid W=1 warnings from GPU
To: Lee Jones <lee.jones@linaro.org>
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
Cc: Neil Armstrong <narmstrong@baylibre.com>, David Airlie <airlied@linux.ie>,
 Linus Walleij <linus.walleij@linaro.org>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 Andrzej Hajda <a.hajda@samsung.com>, Huang Rui <ray.huang@amd.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Gareth Hughes <gareth@valinux.com>, Fabio Estevam <festevam@gmail.com>,
 Sumit Semwal <sumit.semwal@linaro.org>, Sam Ravnborg <sam@ravnborg.org>,
 David Francis <David.Francis@amd.com>, Jingoo Han <jg1.han@samsung.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, Rob Clark <rob.clark@linaro.org>,
 Tomi Valkeinen <tomi.valkeinen@ti.com>, NXP Linux Team <linux-imx@nxp.com>,
 "open list:DMA BUFFER SHARING FRAMEWORK" <linux-media@vger.kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>, Jonas Karlman <jonas@kwiboo.se>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 "moderated list:DMA BUFFER SHARING FRAMEWORK" <linaro-mm-sig@lists.linaro.org>,
 linux-tegra <linux-tegra@vger.kernel.org>, Nirmoy Das <nirmoy.aiemd@gmail.com>,
 Jernej Skrabec <jernej.skrabec@siol.net>, Jason Yan <yanaijie@huawei.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Thierry Reding <thierry.reding@gmail.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Alex Deucher <alexander.deucher@amd.com>, Shawn Guo <shawnguo@kernel.org>,
 Christian Koenig <christian.koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Nov 5, 2020 at 7:10 PM Lee Jones <lee.jones@linaro.org> wrote:
>
> On Thu, 05 Nov 2020, Thierry Reding wrote:
>
> > On Thu, Nov 05, 2020 at 02:44:58PM +0000, Lee Jones wrote:
> > > This set is part of a larger effort attempting to clean-up W=1
> > > kernel builds, which are currently overwhelmingly riddled with
> > > niggly little warnings.
> > >
> > > There are 5000 warnings to work through.
> > >
> > > It will take a couple more sets.
> > >
> > > Lee Jones (19):
> > >   gpu: host1x: bus: Add missing description for 'driver'
> > >   gpu: ipu-v3: ipu-di: Strip out 2 unused 'di_sync_config' entries
> > >   gpu: drm: imx: ipuv3-plane: Mark 'crtc_state' as __always_unused
> > >   gpu: drm: omapdrm: omap_irq: Fix a couple of doc-rot issues
> > >   gpu: drm: selftests: test-drm_mm: Mark 'hole_end' as always_unused
> > >   gpu: drm: scheduler: sched_main: Provide missing description for
> > >     'sched' paramter
> > >   gpu: drm: scheduler: sched_entity: Demote non-conformant kernel-doc
> > >     headers
> > >   gpu: drm: omapdrm: dss: dsi: Rework and remove a few unused variables
> > >   gpu: drm: selftests: test-drm_framebuffer: Remove set but unused
> > >     variable 'fb'
> > >   gpu: drm: ttm: ttm_bo: Fix one function header - demote lots of
> > >     kernel-doc abuses
> > >   gpu: drm: panel: panel-simple: Fix 'struct panel_desc's header
> > >   gpu: drm: bridge: analogix: analogix_dp_reg: Remove unused function
> > >     'analogix_dp_write_byte_to_dpcd'
> > >   gpu: drm: ttm: ttm_tt: Demote kernel-doc header format abuses
> > >   gpu: drm: selftests: test-drm_dp_mst_helper: Place 'struct
> > >     drm_dp_sideband_msg_req_body' onto the heap
> > >   gpu: drm: radeon: radeon_drv: Remove unused variable 'ret'
> > >   gpu: drm: panel: panel-ilitek-ili9322: Demote non-conformant
> > >     kernel-doc header
> > >   gpu: drm: radeon: radeon_device: Fix a bunch of kernel-doc
> > >     misdemeanours
> > >   gpu: drm: amd: amdgpu: amdgpu: Mark global variables as __maybe_unused
> > >   gpu: drm: bridge: analogix: analogix_dp_reg: Remove unused function
> > >     'analogix_dp_start_aux_transaction'
> >
> > As commented on the other patches, the subject prefixes on most of these
> > look wrong, but it's generally a nice cleanup.
>
> The prefixes are automated.  I'll add this to my list of awkward
> subsystems and go through them all manually again tomorrow. :D

tbh for autmoation they look really good :-)

I'd say if you replace the intermediate ": " with just a / you'll be
perfectly in style for drivers/gpu. But really I think it's ok as-is,
imo no need to change since this is a giantic tree wide effort.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
