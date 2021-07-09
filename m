Return-Path: <SRS0=keof=MB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D211C07E99
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Jul 2021 07:52:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E790613B5
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Jul 2021 07:52:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E790613B5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 38DE16E9CB;
	Fri,  9 Jul 2021 07:52:28 +0000 (UTC)
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com
 [IPv6:2607:f8b0:4864:20::c2a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9EC2B6E9CF
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Jul 2021 07:52:27 +0000 (UTC)
Received: by mail-oo1-xc2a.google.com with SMTP id
 o3-20020a4a84c30000b0290251d599f19bso2057652oog.8
 for <amd-gfx@lists.freedesktop.org>; Fri, 09 Jul 2021 00:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=NOW4iU40ZcJNgMOEyt9J2OVtJD6l2MDiLIlc7Opm92I=;
 b=lFPkv5/5O5F32ZCgN9nBu4XOIUICSVrU9hxK2QpZk+1vjWau4urywJVJdF3F17nXhg
 N7sjPhQ7LvnkoowJT7aE7g0spMbwjU8jVDJPs/o8tIujAbKbWi6qYtOZyLivWE4BYOcv
 bZ6s/qpm72ViM/c4L4GPdjeiL49dGBpXWFLSI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=NOW4iU40ZcJNgMOEyt9J2OVtJD6l2MDiLIlc7Opm92I=;
 b=tdHmV67nfgM51Po0bGF+njQjga74wOyDjrGDEgTwlivMG03iU4bMydI12QxZKX7por
 5159qAReE4zZUUJbeS2ap6jSd5CH4EdPUL04x88GBBGP9zSOUtztsmuzbKonQOBq5MLZ
 ThL1ZFQmvSlR8fBTklH6Pz7cBVcwlK0AOuxz3YvF1zoI/pq2HP+YuZShTJLqEObN3L5I
 C+D9TOP7JQQOv6NgIySqzPXYLfqWauYxHo2fbTWAkkbvMqqsUYoo+nl4PPthg+ZnEanR
 KHFzsbg4+37ego7RwtR85p5MMPDryZi6WM7XWx0IvpZX4xssSFPSupfQip4KNMUOBeTH
 FI5g==
X-Gm-Message-State: AOAM532WRbBIE1MKzLjsEEy3DKZ/3kIvX8QomI0TxmCaGrL9RRwHRMb6
 lgSQdeAJrRjeCraUwC8+VJgKNFljQMMjVtlLViqvuw==
X-Google-Smtp-Source: ABdhPJxU4fOisZTk0DY5uSvQ1Q2A9BfOlCOBy7QZFIXMmPR8Wx7ec0t3iOKhqmXK6Q/OfvY8LSi22H1pISgr02ZTcME=
X-Received: by 2002:a4a:9b99:: with SMTP id x25mr26014011ooj.85.1625817146990; 
 Fri, 09 Jul 2021 00:52:26 -0700 (PDT)
MIME-Version: 1.0
References: <20210708193621.2198733-1-alexander.deucher@amd.com>
 <20210708193621.2198733-2-alexander.deucher@amd.com>
 <a25f93e7-8c03-542c-f594-64a7c1fba292@gmail.com>
In-Reply-To: <a25f93e7-8c03-542c-f594-64a7c1fba292@gmail.com>
From: Daniel Vetter <daniel@ffwll.ch>
Date: Fri, 9 Jul 2021 09:52:16 +0200
Message-ID: <CAKMK7uHp8vysDL2DBc-ut_3cYSubsGtgONb1BXhRPwB7oOKbUQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/ttm: Fix COW check
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
 Felix Kuehling <Felix.Kuehling@amd.com>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gRnJpLCBKdWwgOSwgMjAyMSBhdCA4OjM4IEFNIENocmlzdGlhbiBLw7ZuaWcKPGNrb2VuaWcu
bGVpY2h0enVtZXJrZW5AZ21haWwuY29tPiB3cm90ZToKPgo+Cj4KPiBBbSAwOC4wNy4yMSB1bSAy
MTozNiBzY2hyaWViIEFsZXggRGV1Y2hlcjoKPiA+IEZyb206IEZlbGl4IEt1ZWhsaW5nIDxGZWxp
eC5LdWVobGluZ0BhbWQuY29tPgo+ID4KPiA+IEtGRCBUaHVuayBtYXBzIGludmlzaWJsZSBWUkFN
IEJPcyB3aXRoIFBST1RfTk9ORSwgTUFQX1BSSVZBVEUuCj4gPiBpc19jb3dfbWFwcGluZyByZXR1
cm5zIHRydWUgZm9yIHRoZXNlIG1hcHBpbmdzLiBBZGQgYSBjaGVjayBmb3IKPiA+IHZtX2ZsYWdz
ICYgVk1fV1JJVEUgdG8gYXZvaWQgbW1hcCBmYWlsdXJlcyBvbiBwcml2YXRlIHJlYWQtb25seSBv
cgo+ID4gUFJPVF9OT05FIG1hcHBpbmdzLgo+Cj4gSSdtIHByZXR0eSBzdXJlIHRoYXQgdGhpcyBp
cyBub3Qgd29ya2luZyBhcyBleHBlY3RlZC4KPgo+ID4KPiA+IEZpeGVzOiBmOTExNDJjNjIxNjEg
KCJkcm0vdHRtOiBudWtlIFZNX01JWEVETUFQIG9uIEJPIG1hcHBpbmdzIHYzIikKPiA+IFNpZ25l
ZC1vZmYtYnk6IEZlbGl4IEt1ZWhsaW5nIDxGZWxpeC5LdWVobGluZ0BhbWQuY29tPgo+ID4gU2ln
bmVkLW9mZi1ieTogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgo+ID4g
LS0tCj4gPiBkcml2ZXJzL2dwdS9kcm0vdHRtL3R0bV9ib192bS5jIHwgMiArLQo+ID4gICAxIGZp
bGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKPiA+Cj4gPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9ncHUvZHJtL3R0bS90dG1fYm9fdm0uYyBiL2RyaXZlcnMvZ3B1L2RybS90
dG0vdHRtX2JvX3ZtLmMKPiA+IGluZGV4IGY1NmJlNWJjMDg2MS4uYTc1ZTkwYzdkNGFhIDEwMDY0
NAo+ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL3R0bS90dG1fYm9fdm0uYwo+ID4gKysrIGIvZHJp
dmVycy9ncHUvZHJtL3R0bS90dG1fYm9fdm0uYwo+ID4gQEAgLTU1Miw3ICs1NTIsNyBAQCBzdGF0
aWMgY29uc3Qgc3RydWN0IHZtX29wZXJhdGlvbnNfc3RydWN0IHR0bV9ib192bV9vcHMgPSB7Cj4g
PiAgIGludCB0dG1fYm9fbW1hcF9vYmooc3RydWN0IHZtX2FyZWFfc3RydWN0ICp2bWEsIHN0cnVj
dCB0dG1fYnVmZmVyX29iamVjdCAqYm8pCj4gPiAgIHsKPiA+ICAgICAgIC8qIEVuZm9yY2Ugbm8g
Q09XIHNpbmNlIHdvdWxkIGhhdmUgcmVhbGx5IHN0cmFuZ2UgYmVoYXZpb3Igd2l0aCBpdC4gKi8K
PiA+IC0gICAgIGlmIChpc19jb3dfbWFwcGluZyh2bWEtPnZtX2ZsYWdzKSkKPiA+ICsgICAgIGlm
IChpc19jb3dfbWFwcGluZyh2bWEtPnZtX2ZsYWdzKSAmJiAodm1hLT52bV9mbGFncyAmIFZNX1dS
SVRFKSkKPgo+IGlzX2Nvd19tYXBwaW5nKCkgYWxyZWFkeSBjaGVja3MgZm9yIFZNX01BWVdSSVRF
LCBzbyB0aGlzIGhlcmUgc2hvdWxkbid0Cj4gYmUgbmVjZXNzYXJ5LgoKTUFZV1JJVEUgIT0gV1JJ
VEUKCkJ1dCB0aGVuIHlvdSBuZWVkIHRvIG1ha2Ugc3VyZSB5b3UgZG8gY2F0Y2ggbXByb3RlY3Qo
KSBjYWxscyB0byBjYXRjaAp0aGUgY293LCBhbmQgSSdtIG5vdCBzdXJlIHRoYXQncyBldmVuIHBv
c3NpYmxlLiBPdGhlcndpc2UgaXQnbGwgZ28KYm9vbSBhZ2FpbiBvbiB0aGUgcGFnZSByZWZjb3Vu
dC4KLURhbmllbAoKPgo+IENocmlzdGlhbi4KPgo+ID4gICAgICAgICAgICAgICByZXR1cm4gLUVJ
TlZBTDsKPiA+Cj4gPiAgICAgICB0dG1fYm9fZ2V0KGJvKTsKPgoKCi0tIApEYW5pZWwgVmV0dGVy
ClNvZnR3YXJlIEVuZ2luZWVyLCBJbnRlbCBDb3Jwb3JhdGlvbgpodHRwOi8vYmxvZy5mZndsbC5j
aApfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4
IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3Rz
LmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
