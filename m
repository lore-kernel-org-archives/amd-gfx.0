Return-Path: <SRS0=Zv7j=A2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A3E4C433E2
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jul 2020 13:24:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E84520578
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jul 2020 13:24:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vU539rXU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E84520578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3FBC76EA92;
	Wed, 15 Jul 2020 13:24:59 +0000 (UTC)
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com
 [IPv6:2a00:1450:4864:20::342])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2CBA76EA94
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jul 2020 13:24:58 +0000 (UTC)
Received: by mail-wm1-x342.google.com with SMTP id o2so5843478wmh.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jul 2020 06:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=FNO8IdqHoxeBEn1J8B6k/u9rZh0LO899T4OzxdGB28E=;
 b=vU539rXUJaUA4O7ntvlzRxJdyB2vMZ+IJA7btTcxQ5E36VqIsNO89vtu/EXOO7b0gs
 P7k8dZZjsOxlAZ5N3+Ak+HRjq9EhT+O1xw8n3Y05OR0bD3VKUNR90XngKSYx0sBp9SHg
 N/G6AP74gEtdXevculP1f/VlqbZEngM7N+trUAXXKSqD1wGHJItS8EipavBreZrQeLlI
 y/mjZsBVvsRvpX2Mp0qw/c8Y4AoyFbBaR5OuR1wRurzk+mEOTyBDmGGIpqOlJuE1XtUY
 01i/lMV8OrGNHs5Cpiw78/DXlY2FkHubzc3aFlwikw2mM2Ta8+wzos0QZ0SMkDWInK67
 3XlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=FNO8IdqHoxeBEn1J8B6k/u9rZh0LO899T4OzxdGB28E=;
 b=XKk68IrGZCwixpMrvs9JhYwjW0PHbZ0jgXbySVX8IAF+Ltnk1qz1/xgslw3PXDib58
 UjT4HnGHnah/ZkGijpp9wvo+sC0d3xSm4tyEtCezJcf3zAjBnRAza223XLunmhH9rYYL
 hO4MMvfEqzW2jxBHizsiEFhWt3FhXBEj8doZTMYq0boVwqocKzUSYU3lyoRo3XAvqhkW
 CoQ+pjXQjSemiYMZ/TSW7Ohbd3eBN7oi9mLVwLmy5eVkppAWzevLXyDjIFr8adHv5WGw
 QQZfwyrNvQvJSkl6Vl5ja6DsWkemBqvWehTj95J5v2Atvj6Q2MvK+NqfFeLY5sSw8plu
 s55w==
X-Gm-Message-State: AOAM532m6Xugc5wKZ56es1ewKQ8QBALR59hJ5iCuFQAabhOaF6HcQnk4
 Uv9YCbPvMe/1191NUTYX/onF5h5oDEVVVJKP5Ag=
X-Google-Smtp-Source: ABdhPJwDfg2fJ859Z6EhKMYAXPItWDeyEGb/e8bAdKx3z9keAFigjIu+hyEr816V04hO+FNqe+4cC18yEgXMtBBpe5g=
X-Received: by 2002:a1c:5ac3:: with SMTP id o186mr8642023wmb.39.1594819496798; 
 Wed, 15 Jul 2020 06:24:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200714182353.2164930-1-alexander.deucher@amd.com>
 <20200714182353.2164930-2-alexander.deucher@amd.com>
 <6609b826-c7ce-398a-e3a8-d146797063c9@gmail.com>
In-Reply-To: <6609b826-c7ce-398a-e3a8-d146797063c9@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 15 Jul 2020 09:24:44 -0400
Message-ID: <CADnq5_MzQSLfdm2_z=2rtd90WbaDGGzv2g+Gkr0hxeXeydmshw@mail.gmail.com>
Subject: Re: [PATCH 01/42] drm/amdgpu: expand to add multiple trap event irq id
To: Christian Koenig <christian.koenig@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Huang Rui <ray.huang@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gV2VkLCBKdWwgMTUsIDIwMjAgYXQgNToyMSBBTSBDaHJpc3RpYW4gS8O2bmlnCjxja29lbmln
LmxlaWNodHp1bWVya2VuQGdtYWlsLmNvbT4gd3JvdGU6Cj4KPiBBbSAxNC4wNy4yMCB1bSAyMDoy
MyBzY2hyaWViIEFsZXggRGV1Y2hlcjoKPiA+IEZyb206IEh1YW5nIFJ1aSA8cmF5Lmh1YW5nQGFt
ZC5jb20+Cj4gPgo+ID4gU2llbm5hX2NpY2hsaWQgaGFzIGZvdXIgc2RtYSBpbnN0YW5jZXMsIGJ1
dCBvdGhlciBjaGlwcyBkb24ndC4KPiA+IFNvIHdlIG5lZWQgZXhwYW5kIHRvIGFkZCBtdWx0aXBs
ZSB0cmFwIGV2ZW50IGlycSBpZCBpbiBzZG1hCj4gPiB2NS4yLgo+ID4KPiA+IFNpZ25lZC1vZmYt
Ynk6IEh1YW5nIFJ1aSA8cmF5Lmh1YW5nQGFtZC5jb20+Cj4gPiBSZXZpZXdlZC1ieTogQWxleCBE
ZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgo+ID4gU2lnbmVkLW9mZi1ieTogQWxl
eCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgo+Cj4gUmV2aWV3ZWQtYnk6IENo
cmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KPgo+IEJ1dCBzaWRlIHF1
ZXN0aW9uIHdoeSBkbyB3ZSBoYXZlIHRoZSBfU2llbm5hX0NpY2hsaWQgcG9zdGZpeCBvbiB0aGUg
ZGVmaW5lPwoKSSBzdXNwZWN0IHdoZW4gaXQgd2FzIG9yaWdpbmFsbHkgYWRkZWQgaXQgd2FzIHNw
ZWNpZmljIHRvIHNpZW5uYQpjaWNobGlkLCBidXQgaXQgc2hvdWxkIGJlIGRyb3BwZWQgc2luY2Ug
aXQncyBnZW5lcmljLgoKQWxleAoKCj4KPiBDaHJpc3RpYW4uCj4KPiA+IC0tLQo+ID4gICBkcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zZG1hX3Y1XzIuYyB8IDY3ICsrKysrKysrKysrKysrKyst
LS0tLS0tLS0tCj4gPiAgIDEgZmlsZSBjaGFuZ2VkLCA0MSBpbnNlcnRpb25zKCspLCAyNiBkZWxl
dGlvbnMoLSkKPiA+Cj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
c2RtYV92NV8yLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zZG1hX3Y1XzIuYwo+ID4g
aW5kZXggODI0ZjNlMjNjM2Q5Li5kZTgzNDIyODNmZGIgMTAwNjQ0Cj4gPiAtLS0gYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9zZG1hX3Y1XzIuYwo+ID4gKysrIGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvc2RtYV92NV8yLmMKPiA+IEBAIC0xMTY1LDYgKzExNjUsNDAgQEAgc3RhdGlj
IGludCBzZG1hX3Y1XzJfZWFybHlfaW5pdCh2b2lkICpoYW5kbGUpCj4gPiAgICAgICByZXR1cm4g
MDsKPiA+ICAgfQo+ID4KPiA+ICtzdGF0aWMgdW5zaWduZWQgc2RtYV92NV8yX3NlcV90b19pcnFf
aWQoaW50IHNlcV9udW0pCj4gPiArewo+ID4gKyAgICAgc3dpdGNoIChzZXFfbnVtKSB7Cj4gPiAr
ICAgICBjYXNlIDA6Cj4gPiArICAgICAgICAgICAgIHJldHVybiBTT0MxNV9JSF9DTElFTlRJRF9T
RE1BMDsKPiA+ICsgICAgIGNhc2UgMToKPiA+ICsgICAgICAgICAgICAgcmV0dXJuIFNPQzE1X0lI
X0NMSUVOVElEX1NETUExOwo+ID4gKyAgICAgY2FzZSAyOgo+ID4gKyAgICAgICAgICAgICByZXR1
cm4gU09DMTVfSUhfQ0xJRU5USURfU0RNQTI7Cj4gPiArICAgICBjYXNlIDM6Cj4gPiArICAgICAg
ICAgICAgIHJldHVybiBTT0MxNV9JSF9DTElFTlRJRF9TRE1BM19TaWVubmFfQ2ljaGxpZDsKPiA+
ICsgICAgIGRlZmF1bHQ6Cj4gPiArICAgICAgICAgICAgIGJyZWFrOwo+ID4gKyAgICAgfQo+ID4g
KyAgICAgcmV0dXJuIC1FSU5WQUw7Cj4gPiArfQo+ID4gKwo+ID4gK3N0YXRpYyB1bnNpZ25lZCBz
ZG1hX3Y1XzJfc2VxX3RvX3RyYXBfaWQoaW50IHNlcV9udW0pCj4gPiArewo+ID4gKyAgICAgc3dp
dGNoIChzZXFfbnVtKSB7Cj4gPiArICAgICBjYXNlIDA6Cj4gPiArICAgICAgICAgICAgIHJldHVy
biBTRE1BMF81XzBfX1NSQ0lEX19TRE1BX1RSQVA7Cj4gPiArICAgICBjYXNlIDE6Cj4gPiArICAg
ICAgICAgICAgIHJldHVybiBTRE1BMV81XzBfX1NSQ0lEX19TRE1BX1RSQVA7Cj4gPiArICAgICBj
YXNlIDI6Cj4gPiArICAgICAgICAgICAgIHJldHVybiBTRE1BMl81XzBfX1NSQ0lEX19TRE1BX1RS
QVA7Cj4gPiArICAgICBjYXNlIDM6Cj4gPiArICAgICAgICAgICAgIHJldHVybiBTRE1BM181XzBf
X1NSQ0lEX19TRE1BX1RSQVA7Cj4gPiArICAgICBkZWZhdWx0Ogo+ID4gKyAgICAgICAgICAgICBi
cmVhazsKPiA+ICsgICAgIH0KPiA+ICsgICAgIHJldHVybiAtRUlOVkFMOwo+ID4gK30KPiA+ICsK
PiA+ICAgc3RhdGljIGludCBzZG1hX3Y1XzJfc3dfaW5pdCh2b2lkICpoYW5kbGUpCj4gPiAgIHsK
PiA+ICAgICAgIHN0cnVjdCBhbWRncHVfcmluZyAqcmluZzsKPiA+IEBAIC0xMTcyLDMyICsxMjA2
LDEzIEBAIHN0YXRpYyBpbnQgc2RtYV92NV8yX3N3X2luaXQodm9pZCAqaGFuZGxlKQo+ID4gICAg
ICAgc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYgPSAoc3RydWN0IGFtZGdwdV9kZXZpY2UgKilo
YW5kbGU7Cj4gPgo+ID4gICAgICAgLyogU0RNQSB0cmFwIGV2ZW50ICovCj4gPiAtICAgICByID0g
YW1kZ3B1X2lycV9hZGRfaWQoYWRldiwgU09DMTVfSUhfQ0xJRU5USURfU0RNQTAsCj4gPiAtICAg
ICAgICAgICAgICAgICAgICAgICAgICAgU0RNQTBfNV8wX19TUkNJRF9fU0RNQV9UUkFQLAo+ID4g
LSAgICAgICAgICAgICAgICAgICAgICAgICAgICZhZGV2LT5zZG1hLnRyYXBfaXJxKTsKPiA+IC0g
ICAgIGlmIChyKQo+ID4gLSAgICAgICAgICAgICByZXR1cm4gcjsKPiA+IC0KPiA+IC0gICAgIC8q
IFNETUEgdHJhcCBldmVudCAqLwo+ID4gLSAgICAgciA9IGFtZGdwdV9pcnFfYWRkX2lkKGFkZXYs
IFNPQzE1X0lIX0NMSUVOVElEX1NETUExLAo+ID4gLSAgICAgICAgICAgICAgICAgICAgICAgICAg
IFNETUExXzVfMF9fU1JDSURfX1NETUFfVFJBUCwKPiA+IC0gICAgICAgICAgICAgICAgICAgICAg
ICAgICAmYWRldi0+c2RtYS50cmFwX2lycSk7Cj4gPiAtICAgICBpZiAocikKPiA+IC0gICAgICAg
ICAgICAgcmV0dXJuIHI7Cj4gPiAtCj4gPiAtICAgICAvKiBTRE1BIHRyYXAgZXZlbnQgKi8KPiA+
IC0gICAgIHIgPSBhbWRncHVfaXJxX2FkZF9pZChhZGV2LCBTT0MxNV9JSF9DTElFTlRJRF9TRE1B
MiwKPiA+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICBTRE1BMl81XzBfX1NSQ0lEX19TRE1B
X1RSQVAsCj4gPiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgJmFkZXYtPnNkbWEudHJhcF9p
cnEpOwo+ID4gLSAgICAgaWYgKHIpCj4gPiAtICAgICAgICAgICAgIHJldHVybiByOwo+ID4gLQo+
ID4gLSAgICAgLyogU0RNQSB0cmFwIGV2ZW50ICovCj4gPiAtICAgICByID0gYW1kZ3B1X2lycV9h
ZGRfaWQoYWRldiwgU09DMTVfSUhfQ0xJRU5USURfU0RNQTNfU2llbm5hX0NpY2hsaWQsCj4gPiAt
ICAgICAgICAgICAgICAgICAgICAgICAgICAgU0RNQTNfNV8wX19TUkNJRF9fU0RNQV9UUkFQLAo+
ID4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICZhZGV2LT5zZG1hLnRyYXBfaXJxKTsKPiA+
IC0gICAgIGlmIChyKQo+ID4gLSAgICAgICAgICAgICByZXR1cm4gcjsKPiA+ICsgICAgIGZvciAo
aSA9IDA7IGkgPCBhZGV2LT5zZG1hLm51bV9pbnN0YW5jZXM7IGkrKykgewo+ID4gKyAgICAgICAg
ICAgICByID0gYW1kZ3B1X2lycV9hZGRfaWQoYWRldiwgc2RtYV92NV8yX3NlcV90b19pcnFfaWQo
aSksCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzZG1hX3Y1XzJfc2Vx
X3RvX3RyYXBfaWQoaSksCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAm
YWRldi0+c2RtYS50cmFwX2lycSk7Cj4gPiArICAgICAgICAgICAgIGlmIChyKQo+ID4gKyAgICAg
ICAgICAgICAgICAgICAgIHJldHVybiByOwo+ID4gKyAgICAgfQo+ID4KPiA+ICAgICAgIHIgPSBz
ZG1hX3Y1XzJfaW5pdF9taWNyb2NvZGUoYWRldik7Cj4gPiAgICAgICBpZiAocikgewo+Cl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGlu
ZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRl
c2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
