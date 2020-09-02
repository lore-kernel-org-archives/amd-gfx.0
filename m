Return-Path: <SRS0=4FJE=CL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2CD9C433E2
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Sep 2020 13:28:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83EBA207D3
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Sep 2020 13:28:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Vtbq+LTV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83EBA207D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 33F886E4C9;
	Wed,  2 Sep 2020 13:28:02 +0000 (UTC)
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5BC726E4A2
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Sep 2020 11:29:42 +0000 (UTC)
Received: by mail-wr1-x442.google.com with SMTP id t10so4000142wrv.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 02 Sep 2020 04:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=DRdg4lDZzKfGv+sVCvvFW5qNZj4PdeMoeoXDHIqu9+Q=;
 b=Vtbq+LTVNo68gOj/uCEqTpS7m6mQ9vEi+Oonu3JkUaFWQ9sFxuUY0oNita+QhdKEL5
 NvqxqZIinPMbg28rNDfln5qP8DEyHOMTcITWgIfdwsGCfQl12VXtVGIHHEcizLslisaQ
 kAmuha4b0PUsQLgh31JP+Jnqa0nF0Iw4lmkTOedjHsVg4C+nkSm8W6+Z3ylNnJLu9usG
 6TjuI1igFN2Zh6fOnYMB5wzeMsSjgQPi5aU7QkdKniNN6FSZPHZinrU/L8UYGhSHetxb
 D/umW6TzVj87kCeCWqe8v5K4pxpm103n/fGF+VL+7Cr4r2PTH0VePzXEv77KJvSFMZd9
 NBzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=DRdg4lDZzKfGv+sVCvvFW5qNZj4PdeMoeoXDHIqu9+Q=;
 b=k1HXt9aNXizO/Xi9AWk+OeUyTSsU1aVbk9tuzn1TfQD/1yh6Vrg6CFjYmc3PC7yg/G
 GFQ8t0iZ5gAESRJX+IrKfe2UMFdLih8kTwZm6DN2RMssQxaaeL6MnIdcDzGL3/R4X1hp
 Ov8hyauouOfU+Q+7K7fnJsuAfP+03W/87UFQu5g8tRtk3LpGrvKOi9tB96oGwjpKcITB
 OWQ71p8g+K6emEN8mKIOPQybkeaeF2ZjvXiRAVctjty13liu7nhBLTLKqNgmHEfP75De
 qzyHYva94Gb9ccrOnUxBhrdzFl9ZDKCnv0OgyFCSfopDrkbeP7is/RULir568RoU34Ya
 QNwQ==
X-Gm-Message-State: AOAM5329E2ajNdnxiEUQov7c0Rhtz/q31FpgleDnCbnIZOK0BLZrOxct
 CoSAmmmA4mVlwJa/HNU8RDozIQ==
X-Google-Smtp-Source: ABdhPJxpR43l7DicQVi3TBCBkSijmT/uTZDoOFSaDV0lH6CI8svVBIKpdjWvqT0V1L0zUsnU9WARIw==
X-Received: by 2002:a5d:6404:: with SMTP id z4mr4585153wru.423.1599046180907; 
 Wed, 02 Sep 2020 04:29:40 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net.
 [86.9.19.6])
 by smtp.gmail.com with ESMTPSA id g143sm5858835wme.0.2020.09.02.04.29.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2020 04:29:40 -0700 (PDT)
Date: Wed, 2 Sep 2020 12:29:37 +0100
From: Daniel Thompson <daniel.thompson@linaro.org>
To: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v2 0/24] backlight: add init macros and accessors
Message-ID: <20200902112937.u6spv5rgjqcaiaex@holly.lan>
References: <20200823104532.1024798-1-sam@ravnborg.org>
 <CACRpkdaQ9bYrvVdBtz_7=juG175G+WRXbebfkt61tGqtGGoH5Q@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CACRpkdaQ9bYrvVdBtz_7=juG175G+WRXbebfkt61tGqtGGoH5Q@mail.gmail.com>
X-Mailman-Approved-At: Wed, 02 Sep 2020 13:28:00 +0000
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
Cc: Neil Armstrong <narmstrong@baylibre.com>,
 Daniel Vetter <daniel.vetter@ffwll.ch>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
 Chris Wilson <chris@chris-wilson.co.uk>, Andrzej Hajda <a.hajda@samsung.com>,
 Thierry Reding <thierry.reding@gmail.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Sam Ravnborg <sam@ravnborg.org>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
 Manasi Navare <manasi.d.navare@intel.com>, Lee Jones <lee.jones@linaro.org>,
 Konrad Dybcio <konradybcio@gmail.com>, amd-gfx@lists.freedesktop.org,
 Zheng Bin <zhengbin13@huawei.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>,
 Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
 Robert Chiras <robert.chiras@nxp.com>, Vinay Simha BN <simhavcs@gmail.com>,
 Hoegeun Kwon <hoegeun.kwon@samsung.com>,
 =?utf-8?B?UGF3ZcWC?= Chmiel <pawel.mikolaj.chmiel@gmail.com>,
 Jonas Karlman <jonas@kwiboo.se>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Jani Nikula <jani.nikula@linux.intel.com>, Inki Dae <inki.dae@samsung.com>,
 Hans de Goede <hdegoede@redhat.com>, Jyri Sarha <jsarha@ti.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Jernej Skrabec <jernej.skrabec@siol.net>, Jingoo Han <jingoohan1@gmail.com>,
 Philippe CORNU <philippe.cornu@st.com>,
 Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
 Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
 Rob Clark <robdclark@gmail.com>,
 Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Wambui Karuga <wambui.karugax@gmail.com>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Aug 28, 2020 at 11:40:28AM +0200, Linus Walleij wrote:
> On Sun, Aug 23, 2020 at 12:45 PM Sam Ravnborg <sam@ravnborg.org> wrote:
> 
> > The first patch trims backlight_update_status() so it can be called with a NULL
> > backlight_device. Then the caller do not need to add this check just to avoid
> > a NULL reference.
> >
> > The backlight drivers uses several different patterns when registering
> > a backlight:
> >
> > - Register backlight and assign properties later
> > - Define a local backlight_properties variable and use memset
> > - Define a const backlight_properties and assign relevant properties
> >
> > On top of this there was differences in what members was assigned.
> >
> > To align how backlight drivers are initialized introduce following helper macros:
> > - DECLARE_BACKLIGHT_INIT_FIRMWARE()
> > - DECLARE_BACKLIGHT_INIT_PLATFORM()
> > - DECLARE_BACKLIGHT_INIT_RAW()
> >
> > The macros are introduced in patch 2.
> >
> > The backlight drivers used direct access to backlight_properties.
> > Encapsulate these in get/set access operations resulting in following benefits:
> > - The access methods can be called with a NULL pointer so logic around the
> >   access can be made simpler.
> > - The update_brightness and enable_brightness simplifies the users
> > - The code is in most cases more readable with the access operations.
> > - When everyone uses the access methods refactoring in the backlight core is simpler.
> >
> > The get/set operations are introduced in patch 3.
> >
> > The gpio backlight driver received a small overhaul in a set of three patches.
> > The result is a smaller and more readable driver.
> >
> > The remaining patches updates all backlight users in drivers/gpu/drm/*
> > With this patch set all of drivers/gpu/drm/:
> > - All backlight references to FB_BLANK* are gone from drm/*
> > - All direct references to backlight properties are gone
> > - All panel drivers uses the devm_ variant for registering backlight
> >   Daniel Vetter had some concerns with this for future updates,
> >   but we are aligned now and can update if refoctoring demands it
> > - All panel drivers uses the backlight support in drm_panel
> >
> > Individual patches are only sent to the people listed in the patch + a few more.
> > Please check https://lore.kernel.org/dri-devel/ for the full series.
> >
> > v2:
> >   - Documented BACKLIGHT_PROPS as it may be used by drivers
> >   - Dropped backlight_set_power_{on,off}, they were a mistake (Daniel)
> >   - Added backlight_update_brightness() and use it (Daniel)
> >   - Added backlight_enable_brightness() and use it
> >   - Moved remaining drm_panel driver to use backlight support in drm_panel
> >   - gpio backlight driver overhaul
> >
> > The patches are made on top of the for-backlight-next branch at
> > https://git.kernel.org/pub/scm/linux/kernel/git/lee/backlight.git
> > The branch needs v5.8-rc1 backported to build as dev_err_probe()
> > is used.
> >
> > The first 6 patches are candidates for the backlight tree.
> > If they are applied then this should preferably be to an immutable
> > branch we can merge to drm-misc-next where the drm patches shall go.
> >
> > The drm patches has known conflics and shall *not* be applied to the
> > backlight tree, they are included in this patchset to show how the
> > new functions are used.
> >
> > Diffstat for the drm bits alone looks nice:
> >  25 files changed, 243 insertions(+), 460 deletions(-)
> >
> > Feedback welcome!
> 
> Thank you for trying to make backlight easier for developers.
> I am a big supporter of this type of simplifications and
> generalizations, it is what makes DRM great.

+1!

I've reviewed and sent out patch by patch replies for the backlight
patches.

I've eyeballed the drm patches but not reviewed at same depth
and FWIW for all the patches whose subject *doesn't* start with
backlight then:
Acked-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
