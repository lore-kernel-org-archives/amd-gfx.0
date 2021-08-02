Return-Path: <SRS0=SMOw=MZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 237D4C4338F
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Aug 2021 08:31:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D887761057
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Aug 2021 08:31:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D887761057
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 935FB6E3D0;
	Mon,  2 Aug 2021 08:31:29 +0000 (UTC)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C333A897FD
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Aug 2021 08:31:28 +0000 (UTC)
Received: by mail-ej1-x62e.google.com with SMTP id oz16so29570235ejc.7
 for <amd-gfx@lists.freedesktop.org>; Mon, 02 Aug 2021 01:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=date:from:to:cc:subject:message-id:mail-followup-to:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to; bh=2KQi/PpUB7Y3JmHg1rJxCNCGs8vvEPZaQqU4vBqqxj0=;
 b=HgHrrIbB878oj98KI0co1g6r02tGSh9g7VKDedPS39+9jjWZi3bKmqEcp8zzSZzf8l
 CUIHisZ21o1fOMQj4SMZXwh2N3t32A4U9UWUcRJwVyN5wkDb9r3t86E6Z9tO9F1/gRZv
 /Grst0h8i/kmjiopPhS0osukh5NAaw1iQR0RM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id
 :mail-followup-to:references:mime-version:content-disposition
 :content-transfer-encoding:in-reply-to;
 bh=2KQi/PpUB7Y3JmHg1rJxCNCGs8vvEPZaQqU4vBqqxj0=;
 b=IiN5X639CPr7PSXLnDS+I5RFNXMHWL0g2c6dF+9zfNO2EMzpkCxz5gt0B9EFbUd4P9
 nEn/B6/QoTOe1CNKDkQrLnmMoQ5A1pApOYeFCf2LD3ex4zOXLU8ckRx7Fqgm82AQfURl
 SK8ksC2ohWbLRiRxzWStUMzujqKh32KrJWHxDc3IBE1e00THmqHxdJ17o0J+ZsphPOAW
 zHFUupRbChyFmhFlhNVddS4noiEAAODoAgHI6gFmn+//5VwK1NerNvo+HrHCykpZOslJ
 SDwip1TJfHQy+WV95GoLGShg5Alp32FNq6T6x+ZNVBcezNsi771XnOgFMva+VjC1pAh7
 62LQ==
X-Gm-Message-State: AOAM5319OjawBx0aG7sPQ3tFvrSx9Ovb7fw2gn2I8Aqh5ojYOgNGTPg0
 fGkSYOoOlKOTN8sKO5D93csCqg==
X-Google-Smtp-Source: ABdhPJxQFaOHuhoAlTk/8r4Zhkzk4Wm3gRp+HcSLY10IzWI3V+1UMipvcAfeq6ZIhAqRFodwmjs63A==
X-Received: by 2002:a17:906:32d6:: with SMTP id
 k22mr14107178ejk.228.1627893087250; 
 Mon, 02 Aug 2021 01:31:27 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
 by smtp.gmail.com with ESMTPSA id v8sm3078590ejy.79.2021.08.02.01.31.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Aug 2021 01:31:26 -0700 (PDT)
Date: Mon, 2 Aug 2021 10:31:24 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Cc: Zhenneng Li <lizhenneng@kylinos.cn>,
 Alex Deucher <alexander.deucher@amd.com>,
 "Pan, Xinhui" <Xinhui.Pan@amd.com>, David Airlie <airlied@linux.ie>,
 Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/radeon: Update pitch for page flip
Message-ID: <YQetXMaASz/F2EyS@phenom.ffwll.local>
Mail-Followup-To: Christian =?iso-8859-1?Q?K=F6nig?=
 <christian.koenig@amd.com>, 
 Zhenneng Li <lizhenneng@kylinos.cn>,
 Alex Deucher <alexander.deucher@amd.com>,
 "Pan, Xinhui" <Xinhui.Pan@amd.com>, David Airlie <airlied@linux.ie>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20210802074310.1526526-1-lizhenneng@kylinos.cn>
 <e6e77cfb-4e6b-c30e-ae7c-ac84b82c9a75@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e6e77cfb-4e6b-c30e-ae7c-ac84b82c9a75@amd.com>
X-Operating-System: Linux phenom 5.10.0-7-amd64 
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

On Mon, Aug 02, 2021 at 10:12:47AM +0200, Christian König wrote:
> Am 02.08.21 um 09:43 schrieb Zhenneng Li:
> > When primary bo is updated, crtc's pitch may
> > have not been updated, this will lead to show
> > disorder content when user changes display mode,
> > we update crtc's pitch in page flip to avoid
> > this bug.
> > This refers to amdgpu's pageflip.
> 
> Alex is the expert to ask about that code, but I'm not sure if that is
> really correct for the old hardware.
> 
> As far as I know the crtc's pitch should not change during a page flip, but
> only during a full mode set.
> 
> So could you elaborate a bit more how you trigger this?

legacy page_flip ioctl only verifies that the fb->format stays the same.
It doesn't check anything else (afair never has), this is all up to
drivers to verify.

Personally I'd say add a check to reject this, since testing this and
making sure it really works everywhere is probably a bit much on this old
hw.
-Daniel

> 
> Thanks,
> Christian.
> 
> > 
> > Cc: Alex Deucher <alexander.deucher@amd.com>
> > Cc: "Christian König" <christian.koenig@amd.com>
> > Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>
> > Cc: David Airlie <airlied@linux.ie>
> > Cc: Daniel Vetter <daniel@ffwll.ch>
> > Cc: amd-gfx@lists.freedesktop.org
> > Cc: dri-devel@lists.freedesktop.org
> > Cc: linux-kernel@vger.kernel.org
> > Signed-off-by: Zhenneng Li <lizhenneng@kylinos.cn>
> > ---
> >   drivers/gpu/drm/radeon/evergreen.c | 8 +++++++-
> >   1 file changed, 7 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/gpu/drm/radeon/evergreen.c b/drivers/gpu/drm/radeon/evergreen.c
> > index 36a888e1b179..eeb590d2dec2 100644
> > --- a/drivers/gpu/drm/radeon/evergreen.c
> > +++ b/drivers/gpu/drm/radeon/evergreen.c
> > @@ -28,6 +28,7 @@
> >   #include <drm/drm_vblank.h>
> >   #include <drm/radeon_drm.h>
> > +#include <drm/drm_fourcc.h>
> >   #include "atom.h"
> >   #include "avivod.h"
> > @@ -1414,10 +1415,15 @@ void evergreen_page_flip(struct radeon_device *rdev, int crtc_id, u64 crtc_base,
> >   			 bool async)
> >   {
> >   	struct radeon_crtc *radeon_crtc = rdev->mode_info.crtcs[crtc_id];
> > +	struct drm_framebuffer *fb = radeon_crtc->base.primary->fb;
> > -	/* update the scanout addresses */
> > +	/* flip at hsync for async, default is vsync */
> >   	WREG32(EVERGREEN_GRPH_FLIP_CONTROL + radeon_crtc->crtc_offset,
> >   	       async ? EVERGREEN_GRPH_SURFACE_UPDATE_H_RETRACE_EN : 0);
> > +	/* update pitch */
> > +	WREG32(EVERGREEN_GRPH_PITCH + radeon_crtc->crtc_offset,
> > +	       fb->pitches[0] / fb->format->cpp[0]);
> > +	/* update the scanout addresses */
> >   	WREG32(EVERGREEN_GRPH_PRIMARY_SURFACE_ADDRESS_HIGH + radeon_crtc->crtc_offset,
> >   	       upper_32_bits(crtc_base));
> >   	WREG32(EVERGREEN_GRPH_PRIMARY_SURFACE_ADDRESS + radeon_crtc->crtc_offset,
> > 
> > No virus found
> > 		Checked by Hillstone Network AntiVirus
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
