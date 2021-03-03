Return-Path: <SRS0=hRd6=IB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87C95C433DB
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Mar 2021 19:17:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D69C964ED7
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Mar 2021 19:17:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D69C964ED7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5FA1A8992E;
	Wed,  3 Mar 2021 19:17:38 +0000 (UTC)
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com
 [IPv6:2607:f8b0:4864:20::22d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D7940898CE
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Mar 2021 19:17:37 +0000 (UTC)
Received: by mail-oi1-x22d.google.com with SMTP id i21so24932502oii.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 03 Mar 2021 11:17:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=vmFFr4PFdhM0fQdJ7CNgLi0k16crc3xIPnCxeFk1Ffg=;
 b=i2QX8NYjbZMTI3ogkfR9FL3MprxywkFcLE3l28H+jKLP8cLtoLAdJ8ScYT2qZcBUa7
 +7fnlaQ4bvsbVk9FaxQ+mFqwruw7/8pDNa/YoO8gyGz/eSkSdrOsm2aRGK2XgIjdB+HR
 zx8gEas3ehoRaZ26JmxblDIXF/1RdhFFG0ifc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=vmFFr4PFdhM0fQdJ7CNgLi0k16crc3xIPnCxeFk1Ffg=;
 b=Z6TqujZEx3A/YUAyyaUL2ykeQdFYHNybgdF0R08I1Uy/B1HDWWS9+ayRvIilq1SrtJ
 /vxZlG3ajl1aDsDakziTtHGY1HqU8NNAx72Yweft5jug0k7QMiZGZzEprB7UuU26Rog+
 mE/5vnxixr042D7N59l/P1Fmxd2umKRxXO5fX20T7Q8Of+EneAZX+YnDGqnRUsfp3oy1
 fHhAvhNiolIDFgIkvxOWo76ZzK9lJjtF6tqppME01MlGYT9xbb4wCojxkjZcqK4A75ej
 iAYBO5nW2MhiRGFaaTdRCLqz6FnDgFaqLVSOoRmZra5t4yXTTlTiXpt6GIc4hLlL1nvO
 zk5A==
X-Gm-Message-State: AOAM531W3bRRmdUbD1WzqraQcQMc65ViuttpCdYnoKcD1wj1BNdC+Rue
 PZhyfUxMh58Bg++mJSgp2laEUPyn8wJvLPhQuElWFw==
X-Google-Smtp-Source: ABdhPJyyoPQOdq2ecs93cQSGkKbuISrthW6hkw62IMBMoZcO7asUfommZcZGMgHYw7wrm10KYY18wcBvlP8dS9wn86U=
X-Received: by 2002:aca:dad4:: with SMTP id r203mr292024oig.14.1614799057241; 
 Wed, 03 Mar 2021 11:17:37 -0800 (PST)
MIME-Version: 1.0
References: <I5B1EIA88M4W0bSuy9DLTgt70QGefRznp9IdJ14Cco@cp7-web-042.plabs.ch>
 <326ccbf2-8752-2fa2-b757-6811b90ecb8b@daenzer.net>
In-Reply-To: <326ccbf2-8752-2fa2-b757-6811b90ecb8b@daenzer.net>
From: Daniel Vetter <daniel@ffwll.ch>
Date: Wed, 3 Mar 2021 20:17:26 +0100
Message-ID: <CAKMK7uE1+Y_agt=YCMf7OS6X-QjhAXsPO+3asWsahda11ev-eQ@mail.gmail.com>
Subject: Re: [PATCH 3/6] amd/display: fail on cursor plane without an
 underlying plane
To: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel@daenzer.net>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Simon Ser <contact@emersion.fr>,
 Harry Wentland <hwentlan@amd.com>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gV2VkLCBNYXIgMywgMjAyMSBhdCA1OjUzIFBNIE1pY2hlbCBEw6RuemVyIDxtaWNoZWxAZGFl
bnplci5uZXQ+IHdyb3RlOgo+Cj4gT24gMjAyMS0wMi0xOSA3OjU4IHAubS4sIFNpbW9uIFNlciB3
cm90ZToKPiA+IE1ha2Ugc3VyZSB0aGVyZSdzIGFuIHVuZGVybHlpbmcgcGlwZSB0aGF0IGNhbiBi
ZSB1c2VkIGZvciB0aGUKPiA+IGN1cnNvci4KPiA+Cj4gPiBTaWduZWQtb2ZmLWJ5OiBTaW1vbiBT
ZXIgPGNvbnRhY3RAZW1lcnNpb24uZnI+Cj4gPiBDYzogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIu
ZGV1Y2hlckBhbWQuY29tPgo+ID4gQ2M6IEhhcnJ5IFdlbnRsYW5kIDxod2VudGxhbkBhbWQuY29t
Pgo+ID4gQ2M6IE5pY2hvbGFzIEthemxhdXNrYXMgPG5pY2hvbGFzLmthemxhdXNrYXNAYW1kLmNv
bT4KPiA+IC0tLQo+ID4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2Ft
ZGdwdV9kbS5jIHwgNyArKysrKystCj4gPiAgIDEgZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMo
KyksIDEgZGVsZXRpb24oLSkKPiA+Cj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG0uYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlz
cGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtLmMKPiA+IGluZGV4IGFjYmUxNTM3ZTdjZi4uYTVkNjAx
MDQwNWJmIDEwMDY0NAo+ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdw
dV9kbS9hbWRncHVfZG0uYwo+ID4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2Ft
ZGdwdV9kbS9hbWRncHVfZG0uYwo+ID4gQEAgLTkyMjYsOSArOTIyNiwxNCBAQCBzdGF0aWMgaW50
IGRtX2NoZWNrX2NydGNfY3Vyc29yKHN0cnVjdCBkcm1fYXRvbWljX3N0YXRlICpzdGF0ZSwKPiA+
ICAgICAgIH0KPiA+Cj4gPiAgICAgICBuZXdfY3Vyc29yX3N0YXRlID0gZHJtX2F0b21pY19nZXRf
bmV3X3BsYW5lX3N0YXRlKHN0YXRlLCBjcnRjLT5jdXJzb3IpOwo+ID4gLSAgICAgaWYgKCFuZXdf
Y3Vyc29yX3N0YXRlIHx8ICFuZXdfdW5kZXJseWluZ19zdGF0ZSB8fCAhbmV3X2N1cnNvcl9zdGF0
ZS0+ZmIpCj4gPiArICAgICBpZiAoIW5ld19jdXJzb3Jfc3RhdGUgfHwgIW5ld19jdXJzb3Jfc3Rh
dGUtPmZiKQo+ID4gICAgICAgICAgICAgICByZXR1cm4gMDsKPiA+Cj4gPiArICAgICBpZiAoIW5l
d191bmRlcmx5aW5nX3N0YXRlIHx8ICFuZXdfdW5kZXJseWluZ19zdGF0ZS0+ZmIpIHsKPiA+ICsg
ICAgICAgICAgICAgZHJtX2RiZ19hdG9taWMoY3J0Yy0+ZGV2LCAiQ3Vyc29yIHBsYW5lIGNhbid0
IGJlIGVuYWJsZWQgd2l0aG91dCB1bmRlcmx5aW5nIHBsYW5lXG4iKTsKPiA+ICsgICAgICAgICAg
ICAgcmV0dXJuIC1FSU5WQUw7Cj4gPiArICAgICB9Cj4gPiArCj4gPiAgICAgICBjdXJzb3Jfc2Nh
bGVfdyA9IG5ld19jdXJzb3Jfc3RhdGUtPmNydGNfdyAqIDEwMDAgLwo+ID4gICAgICAgICAgICAg
ICAgICAgICAgICAobmV3X2N1cnNvcl9zdGF0ZS0+c3JjX3cgPj4gMTYpOwo+ID4gICAgICAgY3Vy
c29yX3NjYWxlX2ggPSBuZXdfY3Vyc29yX3N0YXRlLT5jcnRjX2ggKiAxMDAwIC8KPiA+Cj4KPiBI
b3VzdG9uLCB3ZSBoYXZlIGEgcHJvYmxlbSBJJ20gYWZyYWlkLiBBZGRpbmcgRGFuaWVsLgo+Cj4K
PiBJZiB0aGUgcHJpbWFyeSBwbGFuZSBpcyBlbmFibGVkIHdpdGggYSBmb3JtYXQgd2hpY2ggaXNu
J3QgY29tcGF0aWJsZSB3aXRoIHRoZSBIVyBjdXJzb3IsIGFuZCBubyBvdmVybGF5IHBsYW5lIGlz
IGVuYWJsZWQsIHRoZSBzYW1lIGlzc3VlcyBhcyBkZXNjcmliZWQgaW4gYjgzNmEyNzRiNzk3ICJk
cm0vYW1kZ3B1L2RjOiBSZXF1aXJlIHByaW1hcnkgcGxhbmUgdG8gYmUgZW5hYmxlZCB3aGVuZXZl
ciB0aGUgQ1JUQyBpcyIgY2FuIGFnYWluIG9jY3VyOgo+Cj4KPiAqIFRoZSBsZWdhY3kgY3Vyc29y
IGlvY3RsIGZhaWxzIHdpdGggRUlOVkFMIGZvciBhIG5vbi0wIGN1cnNvciBGQiBJRAo+Cj4gICAg
KHdoaWNoIGVuYWJsZXMgdGhlIGN1cnNvciBwbGFuZSkuCj4KPiAqIElmIHRoZSBjdXJzb3IgcGxh
bmUgaXMgZW5hYmxlZCAoZS5nLiB1c2luZyB0aGUgbGVnYWN5IGN1cnNvciBpb2N0bAo+ICAgIGR1
cmluZyBEUE1TIG9mZiksIGNoYW5naW5nIHRoZSBsZWdhY3kgRFBNUyBwcm9wZXJ0eQo+ICAgdmFs
dWUgZnJvbSBvZmYgdG8KPiAgICBvbiBmYWlscyB3aXRoIEVJTlZBTC4KCmF0b21pY19jaGVjayBz
aG91bGQgc3RpbGwgYmUgcnVuIHdoZW4gdGhlIGNydGMgaXMgb2ZmLCBzbyB0aGUgbGVnYWN5CmN1
cnNvciBpb2N0bCBzaG91bGQgZmFpbCB3aGVuIGRwbXMgb2ZmIGluIHRoaXMgY2FzZSBhbHJlYWR5
LiBBbmQgdGhlbgp0aGUgZHBtcyBvbiBjYWxsIHNob3VsZCBzdGlsbCBzdWNjZWVkLgoKYXRvbWlj
X2NoZWNrIHNob3VsZCBuZXZlciBoYXZlIGRpZmZlcmVudCBzdGF0ZSBjaGVja3MgZGVwZW5kaW5n
IHVwb24KY3J0Y19zdGF0ZS0+YWN0aXZlLgoKPiBNb3Jlb3ZlciwgaW4gdGhlIHNhbWUgc2NlbmFy
aW8gcGx1cyBhbiBvdmVybGF5IHBsYW5lIGVuYWJsZWQgd2l0aCBhIEhXIGN1cnNvciBjb21wYXRp
YmxlIGZvcm1hdCwgaWYgdGhlIEZCIGJvdW5kIHRvIHRoZSBvdmVybGF5IHBsYW5lIGlzIGRlc3Ry
b3llZCwgdGhlIGNvbW1vbiBEUk0gY29kZSB3aWxsIGF0dGVtcHQgdG8gZGlzYWJsZSB0aGUgb3Zl
cmxheSBwbGFuZSwgYnV0IGRtX2NoZWNrX2NydGNfY3Vyc29yIHdpbGwgcmVqZWN0IHRoYXQgbm93
LiBJIGNhbid0IHJlbWVtYmVyIGV4YWN0bHkgd2hhdCB0aGUgcmVzdWx0IGlzLCBidXQgQUZBSVIg
aXQncyBub3QgcHJldHR5LgoKQ1JUQyBnZXRzIGRpc2FibGVkIGluc3RlYWQuIFRoYXQncyB3aHkg
d2Ugd2VudCB3aXRoIHRoZSAiYWx3YXlzCnJlcXVpcmUgcHJpbWFyeSBwbGFuZSIgaGFjay4gSSB0
aGluayB0aGUgb25seSBzb2x1dGlvbiBoZXJlIHdvdWxkIGJlCnRvIGVuYWJsZSB0aGUgcHJpbWFy
eSBwbGFuZSAoYnV0IG5vdCBpbiB1c2Vyc3BhY2UtdmlzaWJsZSBzdGF0ZSwgc28KdGhpcyBuZWVk
cyB0byBiZSBkb25lIGluIHRoZSBkYyBkZXJpdmVkIHN0YXRlIG9iamVjdHMgb25seSkgdGhhdCBz
Y2FucwpvdXQgYmxhY2sgYW55IHRpbWUgd2UncmUgaW4gc3VjaCBhIHNpdHVhdGlvbiB3aXRoIGN1
cnNvciB3aXRoIG5vCnBsYW5lcy4gQXQgbGVhc3QgYXNzdW1pbmcgSSdtIHVuZGVyc3RhbmRpbmcg
dGhlIGh3IGNvbnN0cmFpbnRzCmNvcnJlY3RseSBoZXJlLiBPdGhlcndpc2UgSSdtIG5vdCByZWFs
bHkgc2VlaW5nIGhvdyB0aGlzIHdvdWxkIHdvcmsKb3RoZXJ3aXNlIGZvciB1c2Vyc3BhY2Ugd2l0
aG91dCBzb21lIGJpZyBzdXJwcmlzZXMuCi1EYW5pZWwKLS0gCkRhbmllbCBWZXR0ZXIKU29mdHdh
cmUgRW5naW5lZXIsIEludGVsIENvcnBvcmF0aW9uCmh0dHA6Ly9ibG9nLmZmd2xsLmNoCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGlu
ZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRl
c2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
