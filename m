Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7835C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Feb 2022 14:09:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D30A710E5B4;
	Tue, 15 Feb 2022 14:09:11 +0000 (UTC)
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com
 [IPv6:2607:f8b0:4864:20::d2c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1967910E46D
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Feb 2022 13:05:35 +0000 (UTC)
Received: by mail-io1-xd2c.google.com with SMTP id m185so23672845iof.10
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Feb 2022 05:05:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=PaZVevCVWnJLVjvrHlW/dnI5NADyeCbLBAp7MlyZJEs=;
 b=TDZSGSZDOR6tESGKMffWCPAQg0pmlp4Qd/GfZoTuMP4o9VEdBnDeiiE6GGqWBPQsgN
 qd+VnUyyPezL+pBRqSdBPDVYO2zc+Rl12fctv8JMQmtfQHTIFV1VisAraOidRtzcv7az
 h+RdY2hixZ3rguGFXADmEsNVOk97TpExpsPCM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=PaZVevCVWnJLVjvrHlW/dnI5NADyeCbLBAp7MlyZJEs=;
 b=MYnnbgS6LE8Nd4zQNJqlN2QhZoCMsTWvqOELNUwm+Cl5drIU3gE56pnhK0YqQVsAr8
 aN36wRMthmvaPTaTrlo6E/09PJ6uCZhYjCzOhjPmvFEcffK6JLQMEy8fU1omFgJZ6Iw5
 2q48GV8i9NHLIbuMPrjBaqmkfiRpmGQrTBH1T7LzFy4BCtVfhe7+2udHSVKr6ArecO8T
 Rio1wQrGQ+W7sW4RWRIcnHkC4H5mpYX4K37LbbTo/oj5/7MBkNxC9BHUqlubFcwnWchs
 VSD+SKzT0abgbMTnFzfARQ6fUlj7cS8kNHRKae01L8cSplox8j4FeI+sWBFDHd7e9n3E
 ZHAw==
X-Gm-Message-State: AOAM532eEmX+DcsSZaxrDwYfxfm7G/yCC5QeM136HGtb8NcSGcUnP8Dt
 xgWgmVqc42GB+DEnCMuTACr7dGcNWkPiANSz0Niy1g==
X-Google-Smtp-Source: ABdhPJxtJIM9RHnfQcz4LMCrnzRwoEV55yIyUKbwloRDyJHYmE4ariqr/kbm/w8QO90RNrUQBhZreEm0Z7T5jqeF5Iw=
X-Received: by 2002:a05:6638:3785:: with SMTP id
 w5mr2736567jal.210.1644930334003; 
 Tue, 15 Feb 2022 05:05:34 -0800 (PST)
MIME-Version: 1.0
References: <20220208084234.1684930-1-hsinyi@chromium.org>
 <CACvgo53u01BK_D0ZssV+gCepjxSz23Nr5Dy1qXeaAoJuu6VCFQ@mail.gmail.com>
In-Reply-To: <CACvgo53u01BK_D0ZssV+gCepjxSz23Nr5Dy1qXeaAoJuu6VCFQ@mail.gmail.com>
From: Hsin-Yi Wang <hsinyi@chromium.org>
Date: Tue, 15 Feb 2022 21:05:08 +0800
Message-ID: <CAJMQK-gvhsk3U7QK9B-28kJ4fKbO8UB01i-_rMMe_GT2pM74gg@mail.gmail.com>
Subject: Re: [Intel-gfx] [PATCH v8 1/3] gpu: drm: separate panel orientation
 property creating and value setting
To: Emil Velikov <emil.l.velikov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Tue, 15 Feb 2022 14:09:09 +0000
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
Cc: Maxime Ripard <mripard@kernel.org>, Chun-Kuang Hu <chunkuang.hu@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 devicetree <devicetree@vger.kernel.org>, David Airlie <airlied@linux.ie>,
 Simon Ser <contact@emersion.fr>,
 Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
 "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
 amd-gfx mailing list <amd-gfx@lists.freedesktop.org>,
 Matthias Brugger <matthias.bgg@gmail.com>, Rob Herring <robh+dt@kernel.org>,
 linux-mediatek@lists.infradead.org,
 ML dri-devel <dri-devel@lists.freedesktop.org>,
 Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 Harry Wentland <harry.wentland@amd.com>,
 LAKML <linux-arm-kernel@lists.infradead.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Feb 15, 2022 at 8:04 PM Emil Velikov <emil.l.velikov@gmail.com> wrote:
>
> Greetings everyone,
>
> Padron for joining in so late o/
>
> On Tue, 8 Feb 2022 at 08:42, Hsin-Yi Wang <hsinyi@chromium.org> wrote:
> >
> > drm_dev_register() sets connector->registration_state to
> > DRM_CONNECTOR_REGISTERED and dev->registered to true. If
> > drm_connector_set_panel_orientation() is first called after
> > drm_dev_register(), it will fail several checks and results in following
> > warning.
> >
> > Add a function to create panel orientation property and set default value
> > to UNKNOWN, so drivers can call this function to init the property earlier
> > , and let the panel set the real value later.
> >
>
> The warning illustrates a genuine race condition, where userspace will
> read the old/invalid property value/state. So this patch masks away
> the WARNING without addressing the actual issue.
> Instead can we fix the respective drivers, so that no properties are
> created after drm_dev_register()?
>
1. How about the proposal in previous version:
v7 https://patchwork.kernel.org/project/linux-mediatek/patch/20220208073714.1540390-1-hsinyi@chromium.org/
we separate property creation
(drm_connector_init_panel_orientation_property) and value setting
(drm_connector_set_panel_orientation). This is also similar to some of
other optional properties are created, eg. vrr_capable.

And drm drivers have to make sure that if they want to use this
property, they have to create it before drm_dev_register(). For
example, in the 2nd patch, mtk_drm sets the property before calling
drm_dev_register().

2. I'm not sure how to handle the case that if user space tries to
read the property before the proper value is set. Currently drm
creates this property and the panels[1] will set the correct value
parsed from DT. If userspace calls before the panel sets the correct
value, it will get unknown (similar to the illustration you mentioned
below). Do you think that the drm should be responsible for parsing
the value if the panel provides it? In this way it's guaranteed that
the value is set when the property is created.

[1] https://elixir.bootlin.com/linux/latest/A/ident/drm_connector_set_panel_orientation

> Longer version:
> As we look into drm_dev_register() it's in charge of creating the
> dev/sysfs nodes (et al). Note that connectors cannot disappear at
> runtime.
> For panel orientation, we are creating an immutable connector
> properly, meaning that as soon as drm_dev_register() is called we must
> ensure that the property is available (if applicable) and set to the
> correct value.
>
> For illustration, consider the following scenario:
>  - DRM modules are loaded late - are not built-in and not part of
> initrd (or there's no initrd)
>  - kernel boots
>  - plymouth/similar user-space component kicks in before the
> driver/module is loaded
>  - module gets loaded, drm_dev_register() kicks in populating /dev/dri/card0
>  - plymouth opens the dev node and reads DRM_MODE_PANEL_ORIENTATION_UNKNOWN
>  - module updates the orientation property
>
> Thanks
> Emil
