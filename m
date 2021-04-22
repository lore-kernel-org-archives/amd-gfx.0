Return-Path: <SRS0=IWiu=JT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95632C43461
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Apr 2021 22:33:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3ED5061421
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Apr 2021 22:33:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3ED5061421
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E5D136EAD9;
	Thu, 22 Apr 2021 22:33:52 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 88EB26EAD4
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Apr 2021 22:33:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1619130830;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=f/vRB79wkOkQwRN4IMQD6uSpNtDOh8JtWPvQm40S7Z8=;
 b=BNpuWTEd8p4AZO5O2i+V9fLpLxPxJWtEg1PTXBuLKQ2xXp5a/b0i7F2nwTIVVScpIp1V8F
 9zcqzSGjWSgeiw5OdLor7wmIVG61qhxLYCdqPmUsecLsYYN8pqyXDwGZ4pfDCfWUR9AUk3
 LTLIeRUg3qtWjWKN6cIFMeSlj9keFQI=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-68-PNtAHQfTM_qzdF-F22VUbQ-1; Thu, 22 Apr 2021 18:33:48 -0400
X-MC-Unique: PNtAHQfTM_qzdF-F22VUbQ-1
Received: by mail-qt1-f198.google.com with SMTP id
 a15-20020a05622a02cfb02901b5e54ac2e5so13238681qtx.4
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Apr 2021 15:33:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
 :references:organization:user-agent:mime-version
 :content-transfer-encoding;
 bh=f/vRB79wkOkQwRN4IMQD6uSpNtDOh8JtWPvQm40S7Z8=;
 b=UgR2Hv9AEFUAZ9qo/z7dsSK9Em1nXTWoEJJl6va0BWyxgubNb7qVL7C3tfUUGVDkLk
 W5dMuzeTiGJuDzKiyrNUrsZgFy5LM0TP2f5/pwkGW1Iau1eq2JvVqPLLXw7Xysi+sQlu
 Y2h9mULuq0zjlARmLRxze3lPQteX0G4Hbq8wepUqtrgzcMKk1UWWKvQsg2LG9oUphTlI
 4vWdhutF8CIqhUb4MAStTmt0yKs3W4yzFIjSoKOfMP76E3+yU1w4SG4WKLPZ2pcrc0ic
 F8n0rolQdJDcdR0ABcLflBvU3GZMF1SDr561FQ5nCa9cZwwJmL4u0xmJ9RA+3hP2zuNy
 ooQA==
X-Gm-Message-State: AOAM531l3kMDKfcxB8L6s4dXV+SnSV2vDSr6P74EvGS06mpLeYpYSgRH
 0U792LqG+wGYFCCxmXUN5ZDDrv88O0B6BsozPRzBdQ4TJUWODyr4n1lHBpB9P3XmXMVPqE7Mqlb
 tXowC+kcCaCeRJaxeisvHzQHIWQ==
X-Received: by 2002:ad4:4947:: with SMTP id o7mr881605qvy.18.1619130828613;
 Thu, 22 Apr 2021 15:33:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz02Kh6a2SHHB692u3GqETh7EMROD4F/lD1uak4N1xfhj+PZRZ3m979UGgrkSpKy+qKyYfYag==
X-Received: by 2002:ad4:4947:: with SMTP id o7mr881548qvy.18.1619130828362;
 Thu, 22 Apr 2021 15:33:48 -0700 (PDT)
Received: from Ruby.lyude.net (pool-108-49-102-102.bstnma.fios.verizon.net.
 [108.49.102.102])
 by smtp.gmail.com with ESMTPSA id j185sm3229184qke.1.2021.04.22.15.33.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Apr 2021 15:33:47 -0700 (PDT)
Message-ID: <2e211a6623664714af1d180eadcd74aa7ef417db.camel@redhat.com>
Subject: Re: [PATCH v3 03/20] drm/dp: Move i2c init to drm_dp_aux_init, add
 __must_check and fini
From: Lyude Paul <lyude@redhat.com>
To: Ville =?ISO-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>, 
 Thierry Reding <thierry.reding@gmail.com>
Date: Thu, 22 Apr 2021 18:33:44 -0400
In-Reply-To: <56a931c9f284ee6a23583eb3dc59de4afaa60e93.camel@redhat.com>
References: <20210419225523.184856-1-lyude@redhat.com>
 <20210419225523.184856-4-lyude@redhat.com> <YH4PPbY1qqF2NtrN@intel.com>
 <56a931c9f284ee6a23583eb3dc59de4afaa60e93.camel@redhat.com>
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
 Maxime Ripard <mripard@kernel.org>, Joe Perches <joe@perches.com>,
 Yuti Amonkar <yamonkar@cadence.com>, Jani Nikula <jani.nikula@linux.intel.com>,
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

T0sgLSB0YWxrZWQgd2l0aCBWaWxsZSBhIGJpdCBvbiB0aGlzIGFuZCBkaWQgc29tZSBvZiBteSBv
d24gcmVzZWFyY2gsIEkKYWN0dWFsbHkgdGhpbmsgdGhhdCBtb3ZpbmcgaTJjIHRvIGRybV9kcF9h
dXhfaW5pdCgpIGlzIHRoZSByaWdodCBkZWNpc2lvbiBmb3IKdGhlIHRpbWUgYmVpbmcuIFRoZSBy
ZWFzb25pbmcgYmVoaW5kIHRoaXMgYmVpbmcgdGhhdCBhcyBzaG93biBieSBteSBwcmV2aW91cwp3
b3JrIG9mIGZpeGluZyBkcml2ZXJzIHRoYXQgY2FsbCBkcm1fZHBfYXV4X3JlZ2lzdGVyKCkgdG9v
IGVhcmx5IC0gaXQgc2VlbXMKbGlrZSB0aGVyZSdzIGFscmVhZHkgYmVlbiBkcml2ZXJzIHRoYXQg
aGF2ZSBiZWVuIHdvcmtpbmcganVzdCBmaW5lIHdpdGgKc2V0dGluZyB1cCB0aGUgaTJjIGRldmlj
ZSBiZWZvcmUgRFJNIHJlZ2lzdHJhdGlvbi4gCgpJbiB0aGUgZnV0dXJlLCBpdCdkIHByb2JhYmx5
IGJlIGJldHRlciBpZiB3ZSBjYW4gc3BsaXQgdXAgaTJjX2FkZF9hZGFwdGVyKCkKaW50byBhbiBp
bml0IGFuZCByZWdpc3RlciBmdW5jdGlvbiAtIGJ1dCB3ZSdsbCBoYXZlIHRvIHRhbGsgd2l0aCB0
aGUgaTJjCm1haW50YWluZXJzIHRvIHNlZSBpZiB0aGlzIGlzIGFjY2VwdGFibGUgdy8gdGhlbQoK
T24gVGh1LCAyMDIxLTA0LTIyIGF0IDEzOjE4IC0wNDAwLCBMeXVkZSBQYXVsIHdyb3RlOgo+IE9u
IFR1ZSwgMjAyMS0wNC0yMCBhdCAwMjoxNiArMDMwMCwgVmlsbGUgU3lyasOkbMOkIHdyb3RlOgo+
ID4gCj4gPiBUaGUgaW5pdCB2cy4gcmVnaXN0ZXIgc3BsaXQgaXMgaW50ZW50aW9uYWwuIFJlZ2lz
dGVyaW5nIHRoZSB0aGluZwo+ID4gYW5kIGFsbG93aW5nIHVzZXJzcGFjZSBhY2Nlc3MgdG8gaXQg
YmVmb3JlIHRoZSByZXN0IG9mIHRoZSBkcml2ZXIKPiA+IGlzIHJlYWR5IGlzbid0IHBhcnRpY3Vs
YXJseSBncmVhdC4gRm9yIGEgd2hpbGUgbm93IHdlJ3ZlIHRyaWVkIHRvCj4gPiBtb3ZlIHRvd2Fy
ZHMgYW4gYXJjaGl0ZWN0dXJlIHdoZXJlIHRoZSBkcml2ZXIgaXMgZnVsbHkgaW5pdGlhbHppZWQK
PiA+IGJlZm9yZSBhbnl0aGluZyBnZXRzIGV4cG9zZWQgdG8gdXNlcnNwYWNlLgo+IAo+IFllYWgt
dGhhbmsgeW91IGZvciBwb2ludGluZyB0aGlzIG91dC4gVGhpZXJyeSAtIGRvIHlvdSB0aGluayB0
aGVyZSdzIGFuCj4gYWx0ZXJuYXRlIHNvbHV0aW9uIHdlIGNvdWxkIGdvIHdpdGggaW4gVGVncmEg
dG8gZml4IHRoZSBnZXRfZGV2aWNlKCkgaXNzdWUKPiB0aGF0IHdvdWxkbid0IHJlcXVpcmUgdXMg
dHJ5aW5nIHRvIGV4cG9zZSB0aGUgaTJjIGFkYXB0ZXIgZWFybHk/Cj4gCj4gPiAKPiAKCi0tIApD
aGVlcnMsCiBMeXVkZSBQYXVsIChzaGUvaGVyKQogU29mdHdhcmUgRW5naW5lZXIgYXQgUmVkIEhh
dAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdm
eCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0
cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
