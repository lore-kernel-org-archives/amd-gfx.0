Return-Path: <SRS0=d4Si=JU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51CC9C43460
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Apr 2021 17:53:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0C496144D
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Apr 2021 17:53:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0C496144D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8EB5A6E160;
	Fri, 23 Apr 2021 17:53:42 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 960556E162
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Apr 2021 17:53:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1619200420;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iMN2vr30yb/ELiIJb3jXFJDgM9IBXB6WS94R3EgBst0=;
 b=LOzDmXtlB0GZvyIp05Or2uEemnPfQrB9ratMHHjLlqa1jLt7bG1RusQP18P7HOdr/q4rG1
 XAHl2vuP5EKUUARrS7XmYJk4uPYUn+GWa/DyasXs58reF7RTspfvpTr0nX9PY2yzE50ouR
 TfLkSm2fkCzeuVx/vhhuC7z2EqNucIE=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-197-lCt125UnOs6cForECiz1aw-1; Fri, 23 Apr 2021 13:53:38 -0400
X-MC-Unique: lCt125UnOs6cForECiz1aw-1
Received: by mail-qk1-f198.google.com with SMTP id
 r123-20020a378f810000b029028244d5f023so15104481qkd.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Apr 2021 10:53:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
 :references:organization:user-agent:mime-version
 :content-transfer-encoding;
 bh=iMN2vr30yb/ELiIJb3jXFJDgM9IBXB6WS94R3EgBst0=;
 b=PCrznfnQBJ8ZWXOr+RILKiSBbSO1jGu0CyAFbjF3eh5Wjgg/+FR3ly+rqAjPOukW9E
 ALfUyjDYAQlIBlAPh6QDfA44YycrbuWO81gw/8D5Ew9hKgoZElrCeHQS+NPyK4Y4RwI/
 0PujGhi1wooJHHxqkN6dY6yz1f06ryMoyZ1hpUnEq3+yoVK690vdYXs6X/Wo/BlvG7hK
 6OTV1c32loLvxtr69T1mVe9+Y27JpIlUmHUwoT+g5R/mjAAUHaRq9AZeFboIuAB3PxL7
 QE6h8w4AKs+PElV+MsLJWBxXoswfZwiR5nNlewRvbW3fGGPR/PpCXCSGu/ryhCU4zWaV
 43vA==
X-Gm-Message-State: AOAM532e0qc4uNuU/vfSZx8FPK3OwTgB6k1nlWKhzkSxuTkrIbgZy6UD
 VSh+xgHtr1ii7GjBNwUveTO/Q51oAiW3FiPQEzZkqCnx2vtRHFI8it8sgCj1+q6GBl0qJ2S/mY7
 cYGPD//z2NvZyhN00hC2ROqLqdQ==
X-Received: by 2002:a0c:dc11:: with SMTP id s17mr5457288qvk.18.1619200415940; 
 Fri, 23 Apr 2021 10:53:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxTUVUlVfoiWl//W0HjPD0d13jw9avPkrwnpeZvBDIw6oqnKzSgsucO2i02vJ5q3mqdmlhTGw==
X-Received: by 2002:a0c:dc11:: with SMTP id s17mr5457242qvk.18.1619200415744; 
 Fri, 23 Apr 2021 10:53:35 -0700 (PDT)
Received: from Ruby.lyude.net (pool-108-49-102-102.bstnma.fios.verizon.net.
 [108.49.102.102])
 by smtp.gmail.com with ESMTPSA id c5sm4715913qkl.7.2021.04.23.10.53.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Apr 2021 10:53:35 -0700 (PDT)
Message-ID: <cb7339fe172f31c615d824b56a709d2df6b79bb7.camel@redhat.com>
Subject: Re: [PATCH v3 03/20] drm/dp: Move i2c init to drm_dp_aux_init, add
 __must_check and fini
From: Lyude Paul <lyude@redhat.com>
To: Thierry Reding <treding@nvidia.com>
Date: Fri, 23 Apr 2021 13:53:33 -0400
In-Reply-To: <YILABCrcMb5MksxD@orome.fritz.box>
References: <20210419225523.184856-1-lyude@redhat.com>
 <20210419225523.184856-4-lyude@redhat.com> <YH4PPbY1qqF2NtrN@intel.com>
 <56a931c9f284ee6a23583eb3dc59de4afaa60e93.camel@redhat.com>
 <2e211a6623664714af1d180eadcd74aa7ef417db.camel@redhat.com>
 <17aa145e4cfa3d8852f7411067c5c37bff771b16.camel@redhat.com>
 <YILABCrcMb5MksxD@orome.fritz.box>
Organization: Red Hat
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33)
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=lyude@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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
 nouveau@lists.freedesktop.org,
 Guido =?ISO-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Oleg Vasilev <oleg.vasilev@intel.com>, dri-devel@lists.freedesktop.org,
 Meenakshikumar Somasundaram <meenakshikumar.somasundaram@amd.com>,
 Andrzej Hajda <a.hajda@samsung.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>,
 Thierry Reding <thierry.reding@gmail.com>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Sam Ravnborg <sam@ravnborg.org>,
 Ville =?ISO-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>,
 Tomi Valkeinen <tomi.valkeinen@ti.com>,
 Parshuram Thombare <pthombar@cadence.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Michal Simek <michal.simek@xilinx.com>, amd-gfx@lists.freedesktop.org,
 Jonathan Hunter <jonathanh@nvidia.com>, Luben Tuikov <luben.tuikov@amd.com>,
 Ben Skeggs <bskeggs@redhat.com>, Swapnil Jakhade <sjakhade@cadence.com>,
 Harry Wentland <harry.wentland@amd.com>, Imre Deak <imre.deak@intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, Jonas Karlman <jonas@kwiboo.se>,
 Leo Li <sunpeng.li@amd.com>, intel-gfx@lists.freedesktop.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Jani Nikula <jani.nikula@linux.intel.com>, Joe Perches <joe@perches.com>,
 Yuti Amonkar <yamonkar@cadence.com>, Maxime Ripard <mripard@kernel.org>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Mikita Lipski <mikita.lipski@amd.com>,
 Sean Paul <sean@poorly.run>, Navid Emamdoost <navid.emamdoost@gmail.com>,
 Jernej Skrabec <jernej.skrabec@siol.net>, Chris Park <Chris.Park@amd.com>,
 Eryk Brol <eryk.brol@amd.com>, Hyun Kwon <hyun.kwon@xilinx.com>,
 Robert Foss <robert.foss@linaro.org>, Julia Lawall <Julia.Lawall@inria.fr>,
 Rob Clark <robdclark@gmail.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, 2021-04-23 at 14:39 +0200, Thierry Reding wrote:
> 
> I'm curious: how is a DP AUX adapter reference count going to solve the
> issue of potentially registering devices too early (i.e. before the DRM
> is registered)?
> 
> Is it because registering too early could cause a reference count
> problem if somebody get a hold of the DP AUX adapter before the parent
> DRM device is around?

Well currently the problem is that we kind of want to avoid setting up the i2c
adapter before the DRM driver is registered with userspace, but it's not
really possible to do that if we need the core device struct for the ddc
adapter initialized so that tegra can call get_device() on it in
drivers/gpu/drm/tegra/sor.c. So my thought is instead of calling get_device()
on the ddc adapter that the AUX channel provides, why not just call it on the
actual platform device that implements the AUX channel instead? I think this
should work pretty nicely while still preventing the platform device for the
AUX channel from disappearing before the SOR has disappeared.


> 
> Thierry

-- 
Cheers,
 Lyude Paul (she/her)
 Software Engineer at Red Hat

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
