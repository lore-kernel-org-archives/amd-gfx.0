Return-Path: <SRS0=IWiu=JT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBC5AC433ED
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Apr 2021 17:19:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5320A613CE
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Apr 2021 17:19:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5320A613CE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B87CE6E532;
	Thu, 22 Apr 2021 17:18:59 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F97B6E532
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Apr 2021 17:18:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1619111938;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LfDSNIXXrzz4FbE4CwlcLSSxDEOGT/2JNoxma+lfpdU=;
 b=UtpaNfrFa2wvBFM0CwL2XSuzHz6TPzwp3vlM2uiqUblbBNWP0Tl0eVaeIZfiSnPImPAgaA
 yl5HzPVUvIxQtvo1B8HLZsRJd/xR9of4Q1tvs1xRRXBOuniJuyuDOMPu+jk06hWcNMktJt
 TVvdn1rW9GhV5Ts9efECkSh9ec8nZyc=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-12-1leW14fdOByrlhIuD7ToEQ-1; Thu, 22 Apr 2021 13:18:13 -0400
X-MC-Unique: 1leW14fdOByrlhIuD7ToEQ-1
Received: by mail-qv1-f69.google.com with SMTP id
 p2-20020ad452e20000b0290177fba4b9d5so16313560qvu.6
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Apr 2021 10:18:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
 :references:organization:user-agent:mime-version
 :content-transfer-encoding;
 bh=LfDSNIXXrzz4FbE4CwlcLSSxDEOGT/2JNoxma+lfpdU=;
 b=QjU0O+r8c0eXC5R6eDgIujgSO/NAVcxDCxf280jzWkx8vFuR5hWcXxpdVVyVrgPYxc
 SdvN8GusEMSfE3xWLJDwkd7+B+kOjeAXbC+rOlMB8bQ6qo7aq2wLXeupCWcJNPYl4lSL
 Nk7bsvLVWl+ed+R55v/6Sv6WDH4Unsjxfp8MT8hB9KXT+SAemOQZPDa42OCs+suvwf/3
 zqcdEnIrfxxP3M34G1vFNgsOSq191FEvLk9fuBohIQAFivJLohDsoQ2kUy31OFEgAxde
 jmaRHe9kV5S54M45QNSAnhI8mfHUPqmh7fgzpJYSq0JB4fDKRZO9K6eaJL3NTtxZEzYO
 S2Uw==
X-Gm-Message-State: AOAM533DcKTZiF3REwaSKvPPtmOY5SBBnp4Wurdwd3nnTxpRlrlHQZYc
 ua17VrhyC4wdgh0RFKoFpX2kqQdN3h2wmmMnRaSe03Xw3frPsHDZUVfT6et2mhbmMwgCX9pVrKS
 B2iYzn/kreKqF4IfxuO+cSdfabA==
X-Received: by 2002:a37:9547:: with SMTP id x68mr4649695qkd.474.1619111892936; 
 Thu, 22 Apr 2021 10:18:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxL+wipZ8wslP+tJgr/etmf17aGBKnIbho/C7QbmqdQYxpKccy8EwWdn+YgrbEvV+9kokVRew==
X-Received: by 2002:a37:9547:: with SMTP id x68mr4649649qkd.474.1619111892722; 
 Thu, 22 Apr 2021 10:18:12 -0700 (PDT)
Received: from Ruby.lyude.net (pool-108-49-102-102.bstnma.fios.verizon.net.
 [108.49.102.102])
 by smtp.gmail.com with ESMTPSA id v4sm2561004qto.50.2021.04.22.10.18.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Apr 2021 10:18:12 -0700 (PDT)
Message-ID: <56a931c9f284ee6a23583eb3dc59de4afaa60e93.camel@redhat.com>
Subject: Re: [PATCH v3 03/20] drm/dp: Move i2c init to drm_dp_aux_init, add
 __must_check and fini
From: Lyude Paul <lyude@redhat.com>
To: Ville =?ISO-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>, 
 Thierry Reding <thierry.reding@gmail.com>
Date: Thu, 22 Apr 2021 13:18:09 -0400
In-Reply-To: <YH4PPbY1qqF2NtrN@intel.com>
References: <20210419225523.184856-1-lyude@redhat.com>
 <20210419225523.184856-4-lyude@redhat.com> <YH4PPbY1qqF2NtrN@intel.com>
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
 Sam Ravnborg <sam@ravnborg.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>,
 Parshuram Thombare <pthombar@cadence.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Michal Simek <michal.simek@xilinx.com>, amd-gfx@lists.freedesktop.org,
 Jonathan Hunter <jonathanh@nvidia.com>, Luben Tuikov <luben.tuikov@amd.com>,
 Ben Skeggs <bskeggs@redhat.com>, Swapnil Jakhade <sjakhade@cadence.com>,
 Thierry Reding <treding@nvidia.com>, Harry Wentland <harry.wentland@amd.com>,
 Imre Deak <imre.deak@intel.com>, Daniel Vetter <daniel@ffwll.ch>,
 Jonas Karlman <jonas@kwiboo.se>, Leo Li <sunpeng.li@amd.com>,
 intel-gfx@lists.freedesktop.org,
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
 Thomas Zimmermann <tzimmermann@suse.de>,
 Alex Deucher <alexander.deucher@amd.com>,
 Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gVHVlLCAyMDIxLTA0LTIwIGF0IDAyOjE2ICswMzAwLCBWaWxsZSBTeXJqw6Rsw6Qgd3JvdGU6
Cj4gCj4gVGhlIGluaXQgdnMuIHJlZ2lzdGVyIHNwbGl0IGlzIGludGVudGlvbmFsLiBSZWdpc3Rl
cmluZyB0aGUgdGhpbmcKPiBhbmQgYWxsb3dpbmcgdXNlcnNwYWNlIGFjY2VzcyB0byBpdCBiZWZv
cmUgdGhlIHJlc3Qgb2YgdGhlIGRyaXZlcgo+IGlzIHJlYWR5IGlzbid0IHBhcnRpY3VsYXJseSBn
cmVhdC4gRm9yIGEgd2hpbGUgbm93IHdlJ3ZlIHRyaWVkIHRvCj4gbW92ZSB0b3dhcmRzIGFuIGFy
Y2hpdGVjdHVyZSB3aGVyZSB0aGUgZHJpdmVyIGlzIGZ1bGx5IGluaXRpYWx6aWVkCj4gYmVmb3Jl
IGFueXRoaW5nIGdldHMgZXhwb3NlZCB0byB1c2Vyc3BhY2UuCgpZZWFoLXRoYW5rIHlvdSBmb3Ig
cG9pbnRpbmcgdGhpcyBvdXQuIFRoaWVycnkgLSBkbyB5b3UgdGhpbmsgdGhlcmUncyBhbgphbHRl
cm5hdGUgc29sdXRpb24gd2UgY291bGQgZ28gd2l0aCBpbiBUZWdyYSB0byBmaXggdGhlIGdldF9k
ZXZpY2UoKSBpc3N1ZQp0aGF0IHdvdWxkbid0IHJlcXVpcmUgdXMgdHJ5aW5nIHRvIGV4cG9zZSB0
aGUgaTJjIGFkYXB0ZXIgZWFybHk/Cgo+IAoKLS0gCkNoZWVycywKIEx5dWRlIFBhdWwgKHNoZS9o
ZXIpCiBTb2Z0d2FyZSBFbmdpbmVlciBhdCBSZWQgSGF0CgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxp
c3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2FtZC1nZngK
