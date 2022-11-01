Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 977F1C433FE
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Nov 2022 22:10:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A25DE10E42A;
	Tue,  1 Nov 2022 22:09:59 +0000 (UTC)
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com
 [IPv6:2607:f8b0:4864:20::1035])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B83410E427
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Nov 2022 21:54:17 +0000 (UTC)
Received: by mail-pj1-x1035.google.com with SMTP id
 v4-20020a17090a088400b00212cb0ed97eso206803pjc.5
 for <amd-gfx@lists.freedesktop.org>; Tue, 01 Nov 2022 14:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=GA8q7YVJ2PrEh80a5RzqM/oJzGj5JG0NgG09XRsMdqg=;
 b=JkZ+NC3LNfYR65ttedUVvXPCnV5s6itLxeP+NXZl9F+Hf2bi7IyxEl7/jUySG1Xjhe
 JqrcWbR3x+hL6Zr6k+XJrs31lcGRbWs9g5gNYujB0mhay/HUyNl68ZnjyhG6g1xE/v67
 ReYOIHvuBeyDa/kXn0GjMwwiX+LBbz10PDs/Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GA8q7YVJ2PrEh80a5RzqM/oJzGj5JG0NgG09XRsMdqg=;
 b=KZ020h6wJmFtxm+dkQEWUv3dCZ910ycizo/fl6tRFWoqfRpV4/3TLYKVPDBNnSLb3w
 rKNRAjD2oJekO53yRa8QSKzU3IpzWrt4DbS/65xADrxNmO+Q0rFNozYzJAEMAQqPI1eU
 zDth02gKhLobK+xt7qnyCfty0X+enBfGgkfbQ3PK61BcjygGDCwohIyJZzVYgy7aqSOr
 hA1CNPfU0ogz7ZmWbjgODkxGdbbFkhXeLALEpFw7pyKsjjgLKz7/b8c3CK3vpHTrYnlB
 gsvQKIehltW0Lo5WbKS5TTm5Zjtafi6+6019Lsn+EgR1GyTOcf/V0e4vW6i0s+w97tcJ
 LCWg==
X-Gm-Message-State: ACrzQf24W2BCC0W2CqzOmn4lhoN5goL4FECOFV89CyBYZxgIXSvVi+ze
 K85piSQ/UIYSzZsR2mxAEebBIg==
X-Google-Smtp-Source: AMsMyM5OvRjW3oHM3Bghe5cW2+FRx8fyhjBnToJnwrbr0Jg8a5Y/wWRZYIgidp7GwXYqel1nldMV0g==
X-Received: by 2002:a17:903:200b:b0:186:892f:9f0b with SMTP id
 s11-20020a170903200b00b00186892f9f0bmr21292591pla.56.1667339657068; 
 Tue, 01 Nov 2022 14:54:17 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
 by smtp.gmail.com with ESMTPSA id
 w18-20020a170902e89200b0017f92246e4dsm6817494plg.181.2022.11.01.14.54.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Nov 2022 14:54:16 -0700 (PDT)
Date: Tue, 1 Nov 2022 14:54:15 -0700
From: Kees Cook <keescook@chromium.org>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH v2] [next] drm/radeon: Replace one-element array with
 flexible-array member
Message-ID: <202211011443.7BDB243D8D@keescook>
References: <Y1trhRE3nK5iAY6q@mail.google.com>
 <Y1yetX1CHsr+fibp@mail.google.com>
 <CADnq5_Mod90O=tN26+Yi74WPYxpVtss+LG_+_HZyFv2EtzR+MA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADnq5_Mod90O=tN26+Yi74WPYxpVtss+LG_+_HZyFv2EtzR+MA@mail.gmail.com>
X-Mailman-Approved-At: Tue, 01 Nov 2022 22:09:58 +0000
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
Cc: Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>, "Pan,
 Xinhui" <Xinhui.Pan@amd.com>, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 David Airlie <airlied@gmail.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 linux-hardening@vger.kernel.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Nov 01, 2022 at 10:42:14AM -0400, Alex Deucher wrote:
> On Fri, Oct 28, 2022 at 11:32 PM Paulo Miguel Almeida
> <paulo.miguel.almeida.rodenas@gmail.com> wrote:
> >
> > One-element arrays are deprecated, and we are replacing them with
> > flexible array members instead. So, replace one-element array with
> > flexible-array member in struct _ATOM_FAKE_EDID_PATCH_RECORD and
> > refactor the rest of the code accordingly.
> >
> > It's worth mentioning that doing a build before/after this patch results
> > in no binary output differences.
> >
> > This helps with the ongoing efforts to tighten the FORTIFY_SOURCE
> > routines on memcpy() and help us make progress towards globally
> > enabling -fstrict-flex-arrays=3 [1].
> 
> This seems like a worthy goal, and I'm not opposed to the patch per
> se, but it seems a bit at odds with what this header represents.
> atombios.h represents the memory layout of the data stored in the ROM
> on the GPU.  This changes the memory layout of that ROM.  We can work

It doesn't though. Or maybe I'm misunderstanding what you mean.

> around that in the driver code, but if someone were to take this
> header to try and write some standalone tool or use it for something
> else in the kernel, it would not reflect reality.

Does the ROM always only have a single byte there? This seems unlikely
given the member "ucFakeEDIDLength" (and the code below).

The problem on the kernel side is that the code just before the patch
context in drivers/gpu/drm/amd/amdgpu/atombios_encoders.c will become
a problem soon:

        if (fake_edid_record->ucFakeEDIDLength) {
                struct edid *edid;
                int edid_size =
                        max((int)EDID_LENGTH, (int)fake_edid_record->ucFakeEDIDLength);
                edid = kmalloc(edid_size, GFP_KERNEL);
                if (edid) {
                        memcpy((u8 *)edid, (u8 *)&fake_edid_record->ucFakeEDIDString[0],
                               fake_edid_record->ucFakeEDIDLength);

                        if (drm_edid_is_valid(edid)) {
	...

the memcpy() from "fake_edid_record->ucFakeEDIDString" will eventually
start to WARN, since the size of that field will be seen as a single byte
under -fstrict-flex-arrays. At this moment, no, there's neither source
bounds checking nor -fstrict-flex-arrays, but we're trying to clean up
everything we can find now so that we don't have to do this all again
later. :)

-Kees

P.S. Also this could be shorter with fewer casts:

                struct edid *edid;
                u8 edid_size =
                        max_t(u8, EDID_LENGTH, fake_edid_record->ucFakeEDIDLength);
                edid = kmemdup(fake_edid_record->ucFakeEDIDString, edid_size, GFP_KERNEL);
                if (edid) {
                        if (drm_edid_is_valid(edid)) {
                                adev->mode_info.bios_hardcoded_edid = edid;
	...

-- 
Kees Cook
