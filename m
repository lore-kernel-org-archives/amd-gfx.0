Return-Path: <SRS0=P3OX=CR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BAAEC433E2
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Sep 2020 11:37:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EEAC521532
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Sep 2020 11:37:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="TRI4o8zL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEAC521532
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B26D6E5CA;
	Tue,  8 Sep 2020 11:37:18 +0000 (UTC)
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A95956E7D9
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Sep 2020 11:37:17 +0000 (UTC)
Received: by mail-wr1-x442.google.com with SMTP id m6so18780890wrn.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 08 Sep 2020 04:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=date:from:to:cc:subject:message-id:mail-followup-to:references
 :mime-version:content-disposition:in-reply-to;
 bh=I/sh0hf7RWpKTkHRG2sXo6X29i3mK1fyatkLVFjwPyY=;
 b=TRI4o8zL814YHGA/D/zYMJIAaCIYqFZ0mIpUDMLZUZN87cVGkWukeoAQibFqRSdTi0
 6pbezBxBfFFSAjRUKWB8QJP5CHgs93NHYtFiS1nIDp648nb0kIv2ZVQ/RTs1fTwlNaec
 GPg0wCc5jkN3j+ma2gtmxo4nY/EYhDvIrUWKQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id
 :mail-followup-to:references:mime-version:content-disposition
 :in-reply-to;
 bh=I/sh0hf7RWpKTkHRG2sXo6X29i3mK1fyatkLVFjwPyY=;
 b=ryy2dQ7yvgayMKkGE+o6e3Hzw5hEH1MWvtlubz7gMslAoiYcJo/idddl7L+rUqH3xH
 fPp08/IZNBkRDCmIf6pEBwc/umH/7WF4CGoaVJVzfXenX2jhejHX91rSogsWdqIRX1uG
 vfuomCz+9BCfIvk/ccCYmt+iqs5HG1Ef6YeTMEl2zpnSCLkeqErI0cDtY+2ckq0Jgn0m
 29660l0yhVudDHLOQwpnwtOHCs85nfKINLZRPJ6Yc+JLkgZZUpO/Z1ikL37nMCuOb99L
 LG8I6icIc0SSMNjxYXBQmdvpfSUfxNZoAHiLdWU8V6aDwb8JPokk2T9ogEZayUNdviso
 2oaw==
X-Gm-Message-State: AOAM532TSq+9zF+k7YVEV7+lPTPFqk1lwz76kEfvU4qwkPo86mmBAqGj
 j7gvSEwhD/pG5SR0Qh55xhtbfg==
X-Google-Smtp-Source: ABdhPJyF2qwliIvI/LNW3ilYwO975TKwRXyUs29RK60LvcJNYZwaiKnp5x/7ZaLEGFTKwLjPhYZ/og==
X-Received: by 2002:adf:fd01:: with SMTP id e1mr24749831wrr.44.1599565035147; 
 Tue, 08 Sep 2020 04:37:15 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
 by smtp.gmail.com with ESMTPSA id e18sm39103291wra.36.2020.09.08.04.37.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2020 04:37:14 -0700 (PDT)
Date: Tue, 8 Sep 2020 13:37:12 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH v4 1/1] drm: allow limiting the scatter list size.
Message-ID: <20200908113712.GL2352366@phenom.ffwll.local>
Mail-Followup-To: Gerd Hoffmann <kraxel@redhat.com>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 David Airlie <airlied@linux.ie>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Lucas Stach <l.stach@pengutronix.de>,
 Russell King <linux+etnaviv@armlinux.org.uk>,
 Christian Gmeiner <christian.gmeiner@gmail.com>,
 Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
 Ben Skeggs <bskeggs@redhat.com>, Sandy Huang <hjc@rock-chips.com>,
 Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>,
 Thierry Reding <thierry.reding@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
 "open list:RADEON and AMDGPU DRM DRIVERS" <amd-gfx@lists.freedesktop.org>,
 open list <linux-kernel@vger.kernel.org>,
 "moderated list:DRM DRIVERS FOR VIVANTE GPU IP"
 <etnaviv@lists.freedesktop.org>, 
 "open list:DRM DRIVER FOR MSM ADRENO GPU" <linux-arm-msm@vger.kernel.org>,
 "open list:DRM DRIVER FOR MSM ADRENO GPU" <freedreno@lists.freedesktop.org>,
 "open list:DRM DRIVER FOR NVIDIA GEFORCE/QUADRO GPUS"
 <nouveau@lists.freedesktop.org>, 
 "moderated list:ARM/Rockchip SoC support"
 <linux-arm-kernel@lists.infradead.org>, 
 "open list:ARM/Rockchip SoC support" <linux-rockchip@lists.infradead.org>,
 "open list:DRM DRIVERS FOR NVIDIA TEGRA" <linux-tegra@vger.kernel.org>,
 "moderated list:DRM DRIVERS FOR XEN" <xen-devel@lists.xenproject.org>
References: <20200907112425.15610-1-kraxel@redhat.com>
 <20200907112425.15610-2-kraxel@redhat.com>
 <CAKMK7uGjT73rh=9iuCKAXvC_CaOuygm8PgOQgofkTgH7wRysFw@mail.gmail.com>
 <20200908054858.um34wojjv6uhi7d3@sirius.home.kraxel.org>
 <20200908085544.GI2352366@phenom.ffwll.local>
 <20200908100253.b22sff23737l77bo@sirius.home.kraxel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200908100253.b22sff23737l77bo@sirius.home.kraxel.org>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
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
Cc: Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>,
 David Airlie <airlied@linux.ie>,
 "open list:DRM DRIVER FOR NVIDIA GEFORCE/QUADRO GPUS"
 <nouveau@lists.freedesktop.org>, dri-devel <dri-devel@lists.freedesktop.org>,
 Sandy Huang <hjc@rock-chips.com>, Thierry Reding <thierry.reding@gmail.com>,
 Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
 "open list:RADEON and AMDGPU DRM DRIVERS" <amd-gfx@lists.freedesktop.org>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 "open list:ARM/Rockchip SoC support" <linux-rockchip@lists.infradead.org>,
 Ben Skeggs <bskeggs@redhat.com>, Russell King <linux+etnaviv@armlinux.org.uk>,
 "moderated list:DRM DRIVERS FOR XEN" <xen-devel@lists.xenproject.org>,
 "open list:DRM DRIVER FOR MSM ADRENO GPU" <linux-arm-msm@vger.kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 "moderated list:DRM DRIVERS FOR VIVANTE GPU IP"
 <etnaviv@lists.freedesktop.org>, Maxime Ripard <mripard@kernel.org>,
 Christian Gmeiner <christian.gmeiner@gmail.com>,
 "open list:DRM DRIVERS FOR NVIDIA TEGRA" <linux-tegra@vger.kernel.org>,
 Sean Paul <sean@poorly.run>, "moderated list:ARM/Rockchip SoC support"
 <linux-arm-kernel@lists.infradead.org>,
 open list <linux-kernel@vger.kernel.org>, Rob Clark <robdclark@gmail.com>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Alex Deucher <alexander.deucher@amd.com>,
 "open list:DRM DRIVER FOR MSM ADRENO GPU" <freedreno@lists.freedesktop.org>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 Lucas Stach <l.stach@pengutronix.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Sep 08, 2020 at 12:02:53PM +0200, Gerd Hoffmann wrote:
> > > > The comments I've found suggest very much not ... Or is that all very
> > > > old stuff only that no one cares about anymore?
> > > 
> > > I think these days it is possible to override dma_ops per device, which
> > > in turn allows virtio to deal with the quirks without the rest of the
> > > kernel knowing about these details.
> > > 
> > > I also think virtio-gpu can drop the virtio_has_dma_quirk() checks, just
> > > use the dma api path unconditionally and depend on virtio core having
> > > setup dma_ops in a way that it JustWorks[tm].  I'll look into that next.
> > 
> > The comment above vring_use_dma_api() suggests that this has not yet
> > happened, that's why I'm asking.
> 
> Hmm, wading through the code, seems it indeed happen yet, even though my
> testing didn't show any issues.  Probably pure luck because devices and
> cpus have the same memory view on x86.  Guess I need to try this on
> ppc64 to see it actually failing ...
> 
> So dropping the virtio_has_dma_quirk() checks isn't going to fly.
> 
> Using dma_max_mapping_size() should be fine though.  It might use a
> lower limit than needed for virtio, but it should not break things.

Makes sense. On this patch here:

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

And I guess would be good if virtio pushes a bit more towards using the
dma api abstraction fully so we can get rid of these hacks. Virtio feels
like a driver that really should be using dma-api and not dig around
behind it because "it' makes stuff 0.5% faster" or so, since being
virtualized it's already not the king of speed anyway :-)

Cheers, Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
