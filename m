Return-Path: <SRS0=tLpO=ZT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1839C432C0
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Nov 2019 18:05:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 983AE20871
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Nov 2019 18:05:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 983AE20871
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9572E6E566;
	Wed, 27 Nov 2019 18:05:02 +0000 (UTC)
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20::343])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BFE196E566
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Nov 2019 18:05:00 +0000 (UTC)
Received: by mail-wm1-x343.google.com with SMTP id s14so1830507wmh.4
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Nov 2019 10:05:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=9oVHy1y6RMaXWx6nU2J1vEuaN6G88wEXawp2NVxMucI=;
 b=EFl6SRiQUBRQP690mRn2ymnlXCMQprD6hLxY3jo8bVyXTqsYBO9t80XHBFxknEw2s8
 Ryqw6XzDV39GU6oZmPJkD8S/jD78uLnVRsPveOGTjSHznGqDHqb7crTrj5yz5l50tSop
 I31UN/vGY5yf0Nmx3lhnlydEyXefVtKfK29KF5xg8ok29CerJAgKD2Mw8RyvTMw0vRBu
 fO80jKWdTr3RNaPgUVHrLLQLA16zhWvW2lJN5jc56Lgk898f0jxOJWIO+bY0ooVHHKeV
 ksuhbL9cVgWE/kppj+KykvK5wRevSxR3Ccd5loc4e8yol3nru28UIzNsxI8o+coiEdaq
 2Zag==
X-Gm-Message-State: APjAAAUpi1HTVJVJjy20bjMeOh5XlzPJCuFhQKgGg/1B1lTSh2olfz3R
 yBQ5rdaSops14JMViMcd3xGgYA==
X-Google-Smtp-Source: APXvYqwQk1tQ3L18EL1jtC6TFapG+FIqwV5i5Br/M2nn3V+am3ZpP9qRw1hUII3+e6ChLWhHvPHXxA==
X-Received: by 2002:a1c:6144:: with SMTP id v65mr5773584wmb.53.1574877899321; 
 Wed, 27 Nov 2019 10:04:59 -0800 (PST)
Received: from phenom.ffwll.local (212-51-149-96.fiber7.init7.net.
 [212.51.149.96])
 by smtp.gmail.com with ESMTPSA id i71sm22076577wri.68.2019.11.27.10.04.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Nov 2019 10:04:58 -0800 (PST)
Date: Wed, 27 Nov 2019 19:04:56 +0100
From: Daniel Vetter <daniel@ffwll.ch>
To: Emil Velikov <emil.l.velikov@gmail.com>
Subject: Re: [PATCH 5/5] drm: drop DRM_AUTH from PRIME_TO/FROM_HANDLE ioctls
Message-ID: <20191127180456.GD406127@phenom.ffwll.local>
References: <20191101130313.8862-1-emil.l.velikov@gmail.com>
 <20191101130313.8862-5-emil.l.velikov@gmail.com>
 <20191127084104.1ceb1f62@collabora.com>
 <CACvgo52UB-sAv55_kREgHbRsg6b5KXv7At0TbgUPdc0e1E+QaA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CACvgo52UB-sAv55_kREgHbRsg6b5KXv7At0TbgUPdc0e1E+QaA@mail.gmail.com>
X-Operating-System: Linux phenom 5.3.0-2-amd64 
User-Agent: Mutt/1.12.2 (2019-09-21)
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ffwll.ch; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=9oVHy1y6RMaXWx6nU2J1vEuaN6G88wEXawp2NVxMucI=;
 b=cWLAvMr0OaCzZhcTtzR8ZeRddCAZd8SK+k+kIQY9Q1+UWZwGG9r3UIbV/pIywTOwA1
 cz3nEvl1ddptFY8aqmpntvBV0zFiQV/2Xbs2KSoG9WweVcmooxBNqVo8vNac6Iq6y7oJ
 z+4Eo2DqLCe3Qgd8jTlMehaTFO+3DfppRWvQ0=
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Boris Brezillon <boris.brezillon@collabora.com>, Sean Paul <sean@poorly.run>,
 ML dri-devel <dri-devel@lists.freedesktop.org>,
 amd-gfx mailing list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191127180456.sA_vCHMukgBWynch8tYrMU98Wm_t1wNKjDghukQ-lP8@z>

T24gV2VkLCBOb3YgMjcsIDIwMTkgYXQgMDQ6Mjc6MjlQTSArMDAwMCwgRW1pbCBWZWxpa292IHdy
b3RlOgo+IE9uIFdlZCwgMjcgTm92IDIwMTkgYXQgMDc6NDEsIEJvcmlzIEJyZXppbGxvbgo+IDxi
b3Jpcy5icmV6aWxsb25AY29sbGFib3JhLmNvbT4gd3JvdGU6Cj4gPgo+ID4gSGkgRW1pbCwKPiA+
Cj4gPiBPbiBGcmksICAxIE5vdiAyMDE5IDEzOjAzOjEzICswMDAwCj4gPiBFbWlsIFZlbGlrb3Yg
PGVtaWwubC52ZWxpa292QGdtYWlsLmNvbT4gd3JvdGU6Cj4gPgo+ID4gPiBGcm9tOiBFbWlsIFZl
bGlrb3YgPGVtaWwudmVsaWtvdkBjb2xsYWJvcmEuY29tPgo+ID4gPgo+ID4gPiBBcyBtZW50aW9u
ZWQgYnkgQ2hyaXN0aWFuLCBmb3IgZHJpdmVycyB3aGljaCBzdXBwb3J0IG9ubHkgcHJpbWFyeSBu
b2Rlcwo+ID4gPiB0aGlzIGNoYW5nZXMgdGhlIHJldHVybmVkIGVycm9yIGZyb20gLUVBQ0NFUyBp
bnRvIC1FT1BOT1RTVVBQLy1FTk9TWVMuCj4gPgo+ID4gQXJlIHlvdSBzdXJlIHRoaXMgaXMgdHJ1
ZSBmb3IgTU9ERVNFVC1vbmx5IG5vZGVzICh0aG9zZSB0aGF0IGRvIG5vdAo+ID4gaGF2ZSB0aGUg
UkVOREVSIGNhcCBzZXQpIGltcGxlbWVudGluZyAtPntmZF90b19oYW5kbGUsaGFuZGxlX3RvX2Zk
fSgpPwo+ID4gU2hvdWxkbid0IHRoZSBpc19hdXRoZW50aWNhdGVkKCkgY2hlY2sgc3RpbGwgYmUg
ZG9uZSBpbiB0aGF0IGNhc2U/Cj4gPgo+IFRoYW5rcyBmb3IgY2F0Y2hpbmcgdGhpcy4gSnVzdCBz
ZW50IG91dCB2Miwgd2hpY2ggSSBzaG91bGQgYWRkcmVzcyB0aGUgY29uY2Vybi4KCldoeSBkbyB3
ZSBuZWVkIHRoaXMgYWRkaXRpb25hbCBjaGVjayBpbiB2Mj8gV2hhdCBjYW4gZ28gd3Jvbmcgb24g
bW9kZXNldApkcml2ZXJzIGlmIG5vbi1hdXRoZW50aWNhdGVkIGxlZ2FjeSB0aGluZ3MgY2FuIHVz
ZSB0aGlzPyBtb2Rlc2V0LW9ubHkKZHJpdmVycyBoYXZlIGFsbCB0aGVpciByZXNvdXJjZXMgc2Vn
cmVnYXRlZCBieSB0aGUgZHJtIGNvcmUgKGRybV9mYiwKbW1hcHMsIGJ1ZmZlciBsaXN0cyksIHNv
IHRoZXJlJ3MgcmVhbGx5IG5vIGFjY2VzcyBsaW1pdGF0aW9ucyB0aGF0IGNhbiBnbwp3cm9uZyBo
ZXJlLgotRGFuaWVsCi0tIApEYW5pZWwgVmV0dGVyClNvZnR3YXJlIEVuZ2luZWVyLCBJbnRlbCBD
b3Jwb3JhdGlvbgpodHRwOi8vYmxvZy5mZndsbC5jaApfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3Rz
LmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2FtZC1nZng=
