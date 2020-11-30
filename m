Return-Path: <SRS0=Nkia=FE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C99B0C64E90
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Nov 2020 23:43:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59C96207BB
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Nov 2020 23:43:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D9R/CGP4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59C96207BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C25FC89C82;
	Mon, 30 Nov 2020 23:43:56 +0000 (UTC)
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com
 [IPv6:2607:f8b0:4864:20::244])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E024289C97;
 Mon, 30 Nov 2020 23:43:55 +0000 (UTC)
Received: by mail-oi1-x244.google.com with SMTP id x16so410493oic.3;
 Mon, 30 Nov 2020 15:43:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=LXttFR72uW7whiX6VrfKE+K9RR9Zk3Wvbi+Z+4eAetM=;
 b=D9R/CGP4Px1Xn7cMko+I3qT6mRaKmAMgRKWxsj2zLmKb3B/28Q+TspnkNw/YwgDC6k
 toleJ0+nSYCF5oam61Q49JLJY7Rv3WDJ664+AC6dMEwZsuDLZ+qTAW12K+Y7g3FgMr4G
 OwAt1/ymJ6IH2bB991JtQAncr/X+5ZtAkIs95ZkEcqc8FZeAcFmtxxzGhx244nVDk3VW
 OM4ST7qeOVijmgU5V1is89vLlsatdkWwTYWAtsXZxVgUnj+Ws8qy6qmLJ52iZRrTQX2G
 Kc9zC6yub/djuUBy4VZqY62G9cYV5ThGF5PVuQmW8gEqmMLAyH3VlWFznRr08WVJ4GaJ
 m5VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=LXttFR72uW7whiX6VrfKE+K9RR9Zk3Wvbi+Z+4eAetM=;
 b=VhV7rMQHUOtEYX5rIsaDB9yzupT2UmvZS6G4mAd1SM5i4mIpSKW2xxcUOcMn8TyBrf
 J9HCaHq731tngB1SPvttxfCYDjNzsPf3UMnSm9c9KNRVlFblg9bEuj3yi3JPuDSWfwL9
 +tKegUJzsRywd00T9USB5u1+E5L0CGfhCrx8QXuNdWRsxdHe8Rrfec3mJRYsc4ugL2x9
 u4ERL4o1/CeDEoMDEe7m6hrVr0fYwfnoahgfiCxS7kWdKjPI88uFOeDpeuoy/JVUX4wG
 88i992W5MDjVq+7jQX2kU1JN8EVo/2RgCmmMONFQkWG+mC4lIpsfXF8AMuHuPqTOmSAM
 hHnQ==
X-Gm-Message-State: AOAM533TeJO5nLeahsEl/DEOv+H3XDqO+4cqX2++9ELaTGDXxIEkHjfy
 uQQOcVdmi4dYNPLqfJobHP1s8P0Qz72nFnG2EUQ=
X-Google-Smtp-Source: ABdhPJyaOIUx4tWcs6D/2KE4+hR0XI6fT/rG4XVdfQIE2xAxgyK7JHwIcN+SBDXvHDQSfFuWtyFgFkDoaiSuNqxPwX8=
X-Received: by 2002:aca:f50e:: with SMTP id t14mr171348oih.123.1606779835345; 
 Mon, 30 Nov 2020 15:43:55 -0800 (PST)
MIME-Version: 1.0
References: <20201126134240.3214176-1-lee.jones@linaro.org>
 <20201126134240.3214176-21-lee.jones@linaro.org>
In-Reply-To: <20201126134240.3214176-21-lee.jones@linaro.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 30 Nov 2020 18:43:44 -0500
Message-ID: <CADnq5_M0N1OfM73AHZpOLRBAaSw66XYu_Kx5M=8oi+vH-7BAYw@mail.gmail.com>
Subject: Re: [PATCH 20/40] drm/amd/pm/powerplay/hwmgr/vega10_processpptables:
 Make function invoked by reference static
To: Lee Jones <lee.jones@linaro.org>
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
Cc: David Airlie <airlied@linux.ie>, LKML <linux-kernel@vger.kernel.org>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Alex Deucher <alexander.deucher@amd.com>, Evan Quan <evan.quan@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gVGh1LCBOb3YgMjYsIDIwMjAgYXQgODo0MyBBTSBMZWUgSm9uZXMgPGxlZS5qb25lc0BsaW5h
cm8ub3JnPiB3cm90ZToKPgo+IEZpeGVzIHRoZSBmb2xsb3dpbmcgVz0xIGtlcm5lbCBidWlsZCB3
YXJuaW5nKHMpOgo+Cj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1Ly4uL3BtL3Bvd2VycGxh
eS9od21nci92ZWdhMTBfcHJvY2Vzc3BwdGFibGVzLmM6MTE0ODo1OiB3YXJuaW5nOiBubyBwcmV2
aW91cyBwcm90b3R5cGUgZm9yIOKAmHZlZ2ExMF9wcF90YWJsZXNfaW5pdGlhbGl6ZeKAmSBbLVdt
aXNzaW5nLXByb3RvdHlwZXNdCj4KPiBDYzogRXZhbiBRdWFuIDxldmFuLnF1YW5AYW1kLmNvbT4K
PiBDYzogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgo+IENjOiAiQ2hy
aXN0aWFuIEvDtm5pZyIgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KPiBDYzogRGF2aWQgQWly
bGllIDxhaXJsaWVkQGxpbnV4LmllPgo+IENjOiBEYW5pZWwgVmV0dGVyIDxkYW5pZWxAZmZ3bGwu
Y2g+Cj4gQ2M6ICJHdXN0YXZvIEEuIFIuIFNpbHZhIiA8Z3VzdGF2b2Fyc0BrZXJuZWwub3JnPgo+
IENjOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+IENjOiBkcmktZGV2ZWxAbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnCj4gU2lnbmVkLW9mZi1ieTogTGVlIEpvbmVzIDxsZWUuam9uZXNAbGlu
YXJvLm9yZz4KCkFwcGxpZWQuICBUaGFua3MhCgpBbGV4Cgo+IC0tLQo+ICBkcml2ZXJzL2dwdS9k
cm0vYW1kL3BtL3Bvd2VycGxheS9od21nci92ZWdhMTBfcHJvY2Vzc3BwdGFibGVzLmMgfCAyICst
Cj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQo+Cj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vcG93ZXJwbGF5L2h3bWdyL3ZlZ2ExMF9w
cm9jZXNzcHB0YWJsZXMuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vcG93ZXJwbGF5L2h3bWdy
L3ZlZ2ExMF9wcm9jZXNzcHB0YWJsZXMuYwo+IGluZGV4IDUzNTQwNGRlNzhhMjAuLjk1Yjk4ODgy
M2Y1MGYgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9wb3dlcnBsYXkvaHdt
Z3IvdmVnYTEwX3Byb2Nlc3NwcHRhYmxlcy5jCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9w
bS9wb3dlcnBsYXkvaHdtZ3IvdmVnYTEwX3Byb2Nlc3NwcHRhYmxlcy5jCj4gQEAgLTExNDUsNyAr
MTE0NSw3IEBAIHN0YXRpYyBpbnQgaW5pdF9kcG1fMl9wYXJhbWV0ZXJzKAo+ICAgICAgICAgcmV0
dXJuIHJlc3VsdDsKPiAgfQo+Cj4gLWludCB2ZWdhMTBfcHBfdGFibGVzX2luaXRpYWxpemUoc3Ry
dWN0IHBwX2h3bWdyICpod21ncikKPiArc3RhdGljIGludCB2ZWdhMTBfcHBfdGFibGVzX2luaXRp
YWxpemUoc3RydWN0IHBwX2h3bWdyICpod21ncikKPiAgewo+ICAgICAgICAgaW50IHJlc3VsdCA9
IDA7Cj4gICAgICAgICBjb25zdCBBVE9NX1ZlZ2ExMF9QT1dFUlBMQVlUQUJMRSAqcG93ZXJwbGF5
X3RhYmxlOwo+IC0tCj4gMi4yNS4xCj4KPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwo+IGRyaS1kZXZlbCBtYWlsaW5nIGxpc3QKPiBkcmktZGV2ZWxAbGlz
dHMuZnJlZWRlc2t0b3Aub3JnCj4gaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1h
bi9saXN0aW5mby9kcmktZGV2ZWwKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3Rv
cC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQt
Z2Z4Cg==
