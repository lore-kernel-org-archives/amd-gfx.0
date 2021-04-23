Return-Path: <SRS0=d4Si=JU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D315AC433B4
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Apr 2021 04:11:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86CC0611AE
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Apr 2021 04:11:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86CC0611AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E2D46EB39;
	Fri, 23 Apr 2021 04:11:15 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E7B316EB3B
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Apr 2021 04:11:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1619151072;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UEsttLkpBkpq2SJNDxCdn4ntrP1/pMb5ophnX8OcNHQ=;
 b=anYwAMcb46SASDoZpyKMlMWHKr/qIBryvcIWntskBHQ1/0xvPAbf2Kskj7dGFMZadvTXiQ
 jhEfSxn0vUnXumq4FOyoqYczqtNDd31L2NFT/M4XjJUMCk1+T/F4e2h3BInQ/qdTHnbgaZ
 7gSDatMHyULglsXWFY4nF/YYCnCSei8=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-383-j7mRWKxkN-OhzcbXh4VJ5w-1; Fri, 23 Apr 2021 00:11:11 -0400
X-MC-Unique: j7mRWKxkN-OhzcbXh4VJ5w-1
Received: by mail-qt1-f198.google.com with SMTP id
 i7-20020ac84f470000b02901b944d49e13so9070412qtw.7
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Apr 2021 21:11:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
 :references:organization:user-agent:mime-version
 :content-transfer-encoding;
 bh=UEsttLkpBkpq2SJNDxCdn4ntrP1/pMb5ophnX8OcNHQ=;
 b=Q1triVrPCmsxmQ77LQ+YlySfvgITOFNOrVaEsaHZtsJdJ7gKgzgSm39wSv2e7wur0A
 Wmds7sRAzcyA1VSqBswvBYnpj/8GsVzzE53mIlKvSoJ2HdSiBq9EZzeSEv3e8mmIfjcX
 0GjwQh/YlHBXajh2Drol7fW4m+5tDd6Tj3bR858PevuFqOrAuhgCxTh2uMpaedoY7w1K
 /TN+ATOqs6FUaHSg02SMGX7Yh2l98mJx2tMes01ymemYj/TgLFoQRT+Cavr1TM+7p9qc
 NJmAFt1lXL1KhIU6Qyu5Xz4D7U80JYVpKAY1dw3zny4s8UuG+4JOvaWurZKu2cQdyipr
 Mqjg==
X-Gm-Message-State: AOAM531r5ROZya/MRcI2EU64Zf4k2QXoaKJ8+rvrakqAF48BxSQtqCU2
 dxHBHDKMc4oOscR5bcudwo9ryUysYh8ZJ7ylEPHs6/t8eMfgxRCrla3wHEVvxWMFgHL9OhMuCr7
 9KQcGpce0SH7s0l/BeAn/IWMTfw==
X-Received: by 2002:a05:620a:759:: with SMTP id
 i25mr2051959qki.193.1619151070442; 
 Thu, 22 Apr 2021 21:11:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJylBePZmlCk3b2HVjreUYqrF7R043bNOhqz9vj7MTklILGEdtzIHic9P0aNqf5EMN/2bwB8Yg==
X-Received: by 2002:a05:620a:759:: with SMTP id
 i25mr2051902qki.193.1619151070183; 
 Thu, 22 Apr 2021 21:11:10 -0700 (PDT)
Received: from Ruby.lyude.net (pool-108-49-102-102.bstnma.fios.verizon.net.
 [108.49.102.102])
 by smtp.gmail.com with ESMTPSA id f22sm3495254qkm.134.2021.04.22.21.11.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Apr 2021 21:11:09 -0700 (PDT)
Message-ID: <17aa145e4cfa3d8852f7411067c5c37bff771b16.camel@redhat.com>
Subject: Re: [PATCH v3 03/20] drm/dp: Move i2c init to drm_dp_aux_init, add
 __must_check and fini
From: Lyude Paul <lyude@redhat.com>
To: Ville =?ISO-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>, 
 Thierry Reding <thierry.reding@gmail.com>
Date: Fri, 23 Apr 2021 00:11:06 -0400
In-Reply-To: <2e211a6623664714af1d180eadcd74aa7ef417db.camel@redhat.com>
References: <20210419225523.184856-1-lyude@redhat.com>
 <20210419225523.184856-4-lyude@redhat.com> <YH4PPbY1qqF2NtrN@intel.com>
 <56a931c9f284ee6a23583eb3dc59de4afaa60e93.camel@redhat.com>
 <2e211a6623664714af1d180eadcd74aa7ef417db.camel@redhat.com>
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

T24gVGh1LCAyMDIxLTA0LTIyIGF0IDE4OjMzIC0wNDAwLCBMeXVkZSBQYXVsIHdyb3RlOgo+IE9L
IC0gdGFsa2VkIHdpdGggVmlsbGUgYSBiaXQgb24gdGhpcyBhbmQgZGlkIHNvbWUgb2YgbXkgb3du
IHJlc2VhcmNoLCBJCj4gYWN0dWFsbHkgdGhpbmsgdGhhdCBtb3ZpbmcgaTJjIHRvIGRybV9kcF9h
dXhfaW5pdCgpIGlzIHRoZSByaWdodCBkZWNpc2lvbgo+IGZvcgo+IHRoZSB0aW1lIGJlaW5nLiBU
aGUgcmVhc29uaW5nIGJlaGluZCB0aGlzIGJlaW5nIHRoYXQgYXMgc2hvd24gYnkgbXkgcHJldmlv
dXMKPiB3b3JrIG9mIGZpeGluZyBkcml2ZXJzIHRoYXQgY2FsbCBkcm1fZHBfYXV4X3JlZ2lzdGVy
KCkgdG9vIGVhcmx5IC0gaXQgc2VlbXMKPiBsaWtlIHRoZXJlJ3MgYWxyZWFkeSBiZWVuIGRyaXZl
cnMgdGhhdCBoYXZlIGJlZW4gd29ya2luZyBqdXN0IGZpbmUgd2l0aAo+IHNldHRpbmcgdXAgdGhl
IGkyYyBkZXZpY2UgYmVmb3JlIERSTSByZWdpc3RyYXRpb24uIAo+IAo+IEluIHRoZSBmdXR1cmUs
IGl0J2QgcHJvYmFibHkgYmUgYmV0dGVyIGlmIHdlIGNhbiBzcGxpdCB1cCBpMmNfYWRkX2FkYXB0
ZXIoKQo+IGludG8gYW4gaW5pdCBhbmQgcmVnaXN0ZXIgZnVuY3Rpb24gLSBidXQgd2UnbGwgaGF2
ZSB0byB0YWxrIHdpdGggdGhlIGkyYwo+IG1haW50YWluZXJzIHRvIHNlZSBpZiB0aGlzIGlzIGFj
Y2VwdGFibGUgdy8gdGhlbQoKQWN0dWFsbHkgLSBJIHRoaW5rIGFkZGluZyB0aGUgYWJpbGl0eSB0
byByZWZjb3VudCBkcCBhdXggYWRhcHRlcnMgbWlnaHQgYmUgYQpiZXR0ZXIgc29sdXRpb24gc28g
SSdtIGdvaW5nIHRvIHRyeSB0aGF0IQoKPiAKPiBPbiBUaHUsIDIwMjEtMDQtMjIgYXQgMTM6MTgg
LTA0MDAsIEx5dWRlIFBhdWwgd3JvdGU6Cj4gPiBPbiBUdWUsIDIwMjEtMDQtMjAgYXQgMDI6MTYg
KzAzMDAsIFZpbGxlIFN5cmrDpGzDpCB3cm90ZToKPiA+ID4gCj4gPiA+IFRoZSBpbml0IHZzLiBy
ZWdpc3RlciBzcGxpdCBpcyBpbnRlbnRpb25hbC4gUmVnaXN0ZXJpbmcgdGhlIHRoaW5nCj4gPiA+
IGFuZCBhbGxvd2luZyB1c2Vyc3BhY2UgYWNjZXNzIHRvIGl0IGJlZm9yZSB0aGUgcmVzdCBvZiB0
aGUgZHJpdmVyCj4gPiA+IGlzIHJlYWR5IGlzbid0IHBhcnRpY3VsYXJseSBncmVhdC4gRm9yIGEg
d2hpbGUgbm93IHdlJ3ZlIHRyaWVkIHRvCj4gPiA+IG1vdmUgdG93YXJkcyBhbiBhcmNoaXRlY3R1
cmUgd2hlcmUgdGhlIGRyaXZlciBpcyBmdWxseSBpbml0aWFsemllZAo+ID4gPiBiZWZvcmUgYW55
dGhpbmcgZ2V0cyBleHBvc2VkIHRvIHVzZXJzcGFjZS4KPiA+IAo+ID4gWWVhaC10aGFuayB5b3Ug
Zm9yIHBvaW50aW5nIHRoaXMgb3V0LiBUaGllcnJ5IC0gZG8geW91IHRoaW5rIHRoZXJlJ3MgYW4K
PiA+IGFsdGVybmF0ZSBzb2x1dGlvbiB3ZSBjb3VsZCBnbyB3aXRoIGluIFRlZ3JhIHRvIGZpeCB0
aGUgZ2V0X2RldmljZSgpIGlzc3VlCj4gPiB0aGF0IHdvdWxkbid0IHJlcXVpcmUgdXMgdHJ5aW5n
IHRvIGV4cG9zZSB0aGUgaTJjIGFkYXB0ZXIgZWFybHk/Cj4gPiAKPiA+ID4gCj4gPiAKPiAKCi0t
IApDaGVlcnMsCiBMeXVkZSBQYXVsIChzaGUvaGVyKQogU29mdHdhcmUgRW5naW5lZXIgYXQgUmVk
IEhhdAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1k
LWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9s
aXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
