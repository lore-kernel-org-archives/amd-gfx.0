Return-Path: <SRS0=vyzA=7C=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11E37C433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 20 May 2020 16:19:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4D6620671
	for <amd-gfx@archiver.kernel.org>; Wed, 20 May 2020 16:19:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P4xOTLVw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4D6620671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 776666E86E;
	Wed, 20 May 2020 16:19:12 +0000 (UTC)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD9A36E86E;
 Wed, 20 May 2020 16:19:11 +0000 (UTC)
Received: by mail-wr1-x42a.google.com with SMTP id e16so3747237wra.7;
 Wed, 20 May 2020 09:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=UZQyO6wUN78xsnrAA8Q7OkzUUHrat4dBv3TIz/ABuHA=;
 b=P4xOTLVw6x0j3/Z44G5FyuMJPCSr5Syso5a+PsDnFn73u3uTO0IFo+KOFP10vBoe0y
 FLvDK432SkeC3N4MONovCMuWzI7334zck56gp8Ft1VcFC69Rn3Q5MiOgfKRbn7EZ+wjE
 NjDJz33ToPErafwxq36cpMhNylvosNlxGxX+Kac6Co2EbmcGPnrChDivC98cYR1F3kYA
 8d/xoQkM8QjuVA+6JWB+t7DUR9YTDofzqgQVUhxblmPSLAPxAo53PnZI8Iye6kdQhrNP
 a6+CkVo1SbwBz3fEyGEocOdH9H/B1sgIH1Gbfu1cC7I1V+Za32iQW5l876YkxKF81Ln0
 ysLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=UZQyO6wUN78xsnrAA8Q7OkzUUHrat4dBv3TIz/ABuHA=;
 b=pfueJwAAuhxk+Tz/qByjBI4ws0rlFmVAHCoAaMerWVc37s92LD3QiHd3T19eSKtOq/
 d/H2D3szx02cYRGggkUA3fd39uMjjmrRlcEV0am+QJgCJiNi86GUcY4H50Zl1SNFjMmm
 8l/4uNMfUr/T28C2UtSaeXi/DXbeUdrgZPjHeBdX64eQxxks9UTn1feYQwvCXeY22iRq
 wB5i3dUoF+L0qLHxMXtfSHkl/uZy2cOvj9pd+5xItauLOToBO6OhXK7Do11AJ40Y7KFl
 Uc6ktl59sanIMlI0sq8cViAy3iUrl8nvUXio/S2Iyof9+uDvfWQmbxNeOGOqgRy1l/yr
 PQwg==
X-Gm-Message-State: AOAM5314FUSoWOl8Auu80/oMyLUP3cz9Lg2SJGfzMvSIj07tz9ns8csB
 5GdqTb9ChBR3+v9Ea1ma6ZT6CVfaL/4RtLwMRqk=
X-Google-Smtp-Source: ABdhPJyKyc9jStG810KcUZRcuZPeVRUbCzKmHEB3oAqAoYmd2m6dQY0r0hErdmuiPf0CbkvMgfKPHI0ZFJPWjlTHQzE=
X-Received: by 2002:a05:6000:14b:: with SMTP id
 r11mr5142640wrx.124.1589991550479; 
 Wed, 20 May 2020 09:19:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200513110313.12979-1-christian.koenig@amd.com>
 <9d784383-905e-59af-b17c-923c92474ece@gmail.com>
In-Reply-To: <9d784383-905e-59af-b17c-923c92474ece@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 20 May 2020 12:18:59 -0400
Message-ID: <CADnq5_PxUD546E852r918xEc=MddzArLDciBKtJRpuoiC4e-qQ@mail.gmail.com>
Subject: Re: [RFC] Deprecate AGP GART support for Radeon/Nouveau/TTM
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 nouveau <nouveau@lists.freedesktop.org>, debian-powerpc@lists.debian.org,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gV2VkLCBNYXkgMjAsIDIwMjAgYXQgMTA6NDMgQU0gQ2hyaXN0aWFuIEvDtm5pZwo8Y2tvZW5p
Zy5sZWljaHR6dW1lcmtlbkBnbWFpbC5jb20+IHdyb3RlOgo+Cj4gQW0gMTMuMDUuMjAgdW0gMTM6
MDMgc2NocmllYiBDaHJpc3RpYW4gS8O2bmlnOgo+ID4gVW5mb3J0dW5hdGVseSBBR1AgaXMgc3Rp
bGwgdG8gd2lkZWx5IHVzZWQgYXMgd2UgY291bGQganVzdCBkcm9wIHN1cHBvcnQgZm9yIHVzaW5n
IGl0cyBHQVJULgo+ID4KPiA+IE5vdCB1c2luZyB0aGUgQUdQIEdBUlQgYWxzbyBkb2Vzbid0IG1l
YW4gYSBsb3NzIGluIGZ1bmN0aW9uYWxpdHkgc2luY2UgZHJpdmVycyB3aWxsIGp1c3QgZmFsbGJh
Y2sgdG8gdGhlIGRyaXZlciBzcGVjaWZpYyBQQ0kgR0FSVC4KPiA+Cj4gPiBGb3Igbm93IGp1c3Qg
ZGVwcmVjYXRlIHRoZSBjb2RlIGFuZCBkb24ndCBlbmFibGUgdGhlIEFHUCBHQVJUIGluIFRUTSBl
dmVuIHdoZW4gZ2VuZXJhbCBBR1Agc3VwcG9ydCBpcyBhdmFpbGFibGUuCj4KPiBTbyBJJ3ZlIHVz
ZWQgYW4gYW5jaWVudCBzeXN0ZW0gKDMyYml0KSB0byBzZXR1cCBhIHRlc3QgYm94IGZvciB0aGlz
Lgo+Cj4KPiBUaGUgZmlyc3QgR1BVIEkgY291bGQgdGVzdCBpcyBhbiBSVjI4MCAoUmFkZW9uIDky
MDAgUFJPKSB3aGljaCBpcyBlYXNpbHkKPiAxNSB5ZWFycyBvbGQuCj4KPiBXaGF0IGhhcHBlbnMg
aW4gQUdQIG1vZGUgaXMgdGhhdCBnbHhnZWFycyBzaG93cyBhcnRpZmFjdHMgZHVyaW5nCj4gcmVu
ZGVyaW5nIG9uIHRoaXMgc3lzdGVtLgo+Cj4gSW4gUENJIG1vZGUgdGhvc2UgcmVuZGVyaW5nIGFy
dGlmYWN0cyBhcmUgZ29uZSBhbmQgZ2x4Z2VhcnMgc2VlbXMgdG8KPiBkcmF3IGV2ZXJ5dGhpbmcg
Y29ycmVjdGx5IG5vdy4KPgo+IFBlcmZvcm1hbmNlIGlzIG9idmlvdXNseSBub3QgY29tcGFyYWJs
ZSwgY2F1c2UgaW4gQUdQIHdlIGRvbid0IHJlbmRlcgo+IGFsbCB0cmlhbmdsZXMgY29ycmVjdGx5
Lgo+Cj4KPiBUaGUgc2Vjb25kIEdQVSBJIGNvdWxkIHRlc3QgaXMgYW4gUlY2MzAgUFJPIChSYWRl
b24gSEQgMjYwMCBQUk8gQUdQKQo+IHdoaWNoIGlzIG1vcmUgdGhhbiAxMCB5ZWFycyBvbGQuCj4K
PiBBcyBmYXIgYXMgSSBjYW4gdGVsbCB0aGlzIG9uZSB3b3JrcyBpbiBib3RoIEFHUCBhbmQgUENJ
ZSBtb2RlIHBlcmZlY3RseQo+IGZpbmUuCj4KPiBTaW5jZSB0aGlzIGlzIG9ubHkgYSAzMmJpdCBz
eXN0ZW0gSSBjb3VsZG4ndCByZWFsbHkgdGVzdCBhbnkgT3BlbkdMIGdhbWUKPiB0aGF0IHdlbGwu
Cj4KPiBCdXQgZm9yIGdseGdlYXJzIHN3aXRjaGluZyBmcm9tIEFHUCB0byBQQ0llIG1vZGUgc2Vl
bXMgdG8gcmVzdWx0IGluIGEKPiByb3VnaGx5IDUlIHBlcmZvcm1hbmNlIGRyb3AuCj4KPiBUaGUg
c3VycHJpc2luZyByZWFzb24gZm9yIHRoaXMgaXMgbm90IHRoZSBiZXR0ZXIgVExCIHBlcmZvcm1h
bmNlLCBidXQKPiB0aGUgbGFjayBvZiBVU1dDIHN1cHBvcnQgZm9yIHRoZSBQQ0llIEdBUlQgaW4g
cmFkZW9uLgo+Cj4KPiBTbyBpZiBhbnlib2R5IHdhbnRzIHRvIGdldCBoaXMgaGFuZHMgZGlydHkg
YW5kIHNxdWVlemUgYSBiaXQgbW9yZQo+IHBlcmZvcm1hbmNlIG91dCBvZiB0aGUgb2xkIGhhcmR3
YXJlLCBwb3J0aW5nIFVTV0MgZnJvbSBhbWRncHUgdG8gcmFkZW9uCj4gc2hvdWxkbid0IGJlIHRv
IG11Y2ggb2YgYSBwcm9ibGVtLgoKV2UgZG8gc3VwcG9ydCBVU1dDIG9uIHJhZGVvbiwgYWx0aG91
Z2ggSSB0aGluayB3ZSBoYWQgc2VwYXJhdGUgZmxhZ3MKZm9yIGNhY2hlZCBhbmQgV0MuICBUaGF0
IHNhaWQgd2UgaGFkIGEgbG90IG9mIHByb2JsZW1zIHdpdGggV0Mgb24gMzIKYml0IChzZWUgcmFk
ZW9uX2JvX2NyZWF0ZSgpKS4gIFRoZSBvdGhlciBwcm9ibGVtIGlzIHRoYXQsIGF0IGxlYXN0IG9u
CnRoZSByZWFsbHkgb2xkIHJhZGVvbnMsIHRoZSBQQ0kgZ2FydCBkaWRuJ3Qgc3VwcG9ydCBzbm9v
cGVkIGFuZAp1bnNub29wZWQuICBJdCB3YXMgYWx3YXlzIHNub29wZWQuICBJdCB3YXNuJ3QgdW50
aWwgcGNpZSB0aGF0IHRoZSBnYXJ0Cmh3IGdvdCBzdXBwb3J0IGZvciBib3RoLiAgRm9yIEFHUCwg
dGhlIGV4cGVjdGF0aW9uIHdhcyB0aGF0IEFHUApwcm92aWRlZCB0aGUgdW5jYWNoZWQgbWVtb3J5
LgoKPgo+Cj4gU3VtbWluZyBpdCB1cCBJJ20gc3RpbGwgbGVhbmluZyB0b3dhcmRzIGRpc2FibGlu
ZyBBR1AgY29tcGxldGVseSBieQo+IGRlZmF1bHQgZm9yIHJhZGVvbiBhbmQgZGVwcmVjYXRlIGl0
IGluIFRUTSBhcyB3ZWxsLgo+Cj4gVGhvdWdodHM/IEVzcGVjaWFsbHkgQWxleCB3aGF0IGRvIHlv
dSB0aGluay4KCldvcmtzIGZvciBtZS4KCkFsZXgKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5m
cmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0
aW5mby9hbWQtZ2Z4Cg==
