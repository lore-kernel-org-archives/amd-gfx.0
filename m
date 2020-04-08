Return-Path: <SRS0=b+Zp=5Y=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA96FC2D0EA
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Apr 2020 13:51:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7F4420692
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Apr 2020 13:51:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WDHXOqvZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7F4420692
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3ED308864B;
	Wed,  8 Apr 2020 13:51:18 +0000 (UTC)
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com
 [IPv6:2a00:1450:4864:20::443])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 82A7D6EA6B;
 Wed,  8 Apr 2020 13:51:17 +0000 (UTC)
Received: by mail-wr1-x443.google.com with SMTP id f13so1323359wrm.13;
 Wed, 08 Apr 2020 06:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=/tPMGOVxxu7gWnAkyAjcxvHIvt1p1HmTew0NR/J3RdY=;
 b=WDHXOqvZOibaC9lxlcVSUTX2VuV12na33nT8qhfsVPQxehSnNzZzgOTCw2eTfJTW20
 7gnrGZpwurvjpgQmARI4Q7f8RxHKGbIVffID/QIVRIxWboGQX8YNNiGKlz4Bppg8iExk
 tYSygixJnIvike436u6jMERmKPFg+f8s0eTuqEJl49QqtLu817E6LFhmqAes4LLT/F5U
 7UXZzCaudW/EcxNFVbCPyRPEKM/c7fO3uRf3OUIdxyEPF2y/6MQMCp3S+/OFrlYqkrcx
 FTgbv6+To0tk5PQHF8fHP3arq0XkFWWleRW+nnskVtUR8tLTF1kRkm9FX4/6NEd6xEuM
 nSgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=/tPMGOVxxu7gWnAkyAjcxvHIvt1p1HmTew0NR/J3RdY=;
 b=Nr6HsswrnI86E7pO+3+gBVtZnHaQAvZO6/vp5o2AGL5rD1SAMGaXNEJBMyis2TX0jP
 baG6NF7u1osTvo50cABJmVd1ILveCeq0W2LU7G1/S2mzn8mX2Ye7OxYkf9RIMyGarrGP
 ZB5PayPq9n9+4n7/LdPHwNwGtc+Cdcj0AY7FTWXXcK1akHDAubUxA2//K+snCdOjSzwx
 QoiGqlzAZ5dOnW7H7UWxrUWp+2ET/SeLT9IRKsKCK3KuTMQ3Hy8lOJQv8JJSmH7ahnX2
 GsQxocoDnHNFMJ5RzVBAU9D3BuycNEnnsm6D9Vrk/jtepVkk3ut3PgSLVDer/g9peeGK
 uEtw==
X-Gm-Message-State: AGi0PuYqzmnXq3oaR4TTEfcRDANCEQJDutuFBPFNEe7P7aYd46QrnaOf
 wD7IwdoiC4wkO5xS51GuBAL1AQc12AWxftgZWd0=
X-Google-Smtp-Source: APiQypIRgHhvwDJYgFcFIUnBYS60RAJSyoAqG9n9yEsAZW2pgncWHEd8hza+cXwvOiYnIl4d7m2wLP8d1sGoK/k5/5U=
X-Received: by 2002:adf:ce83:: with SMTP id r3mr8626945wrn.419.1586353876246; 
 Wed, 08 Apr 2020 06:51:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200207195058.2354-1-alexander.deucher@amd.com>
 <76de444d-529d-cce7-8c1a-97053686029c@suse.de>
In-Reply-To: <76de444d-529d-cce7-8c1a-97053686029c@suse.de>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 8 Apr 2020 09:51:05 -0400
Message-ID: <CADnq5_Mz1s5MSeuMM7_hY8kXgrv8=qdQfdhfAEtYZUB88-DASw@mail.gmail.com>
Subject: Re: [PATCH 00/15] amdgpu: remove load and unload callbacks (v3)
To: Thomas Zimmermann <tzimmermann@suse.de>
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
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gV2VkLCBBcHIgOCwgMjAyMCBhdCAzOjM4IEFNIFRob21hcyBaaW1tZXJtYW5uIDx0emltbWVy
bWFubkBzdXNlLmRlPiB3cm90ZToKPgo+IEhpIEFsZXgKPgo+IEFtIDA3LjAyLjIwIHVtIDIwOjUw
IHNjaHJpZWIgQWxleCBEZXVjaGVyOgo+ID4gVGhlc2UgYXJlIGRlcHJlY2F0ZWQgYW5kIHRoZSBk
cm0gd2lsbCBzb29uIHN0YXJ0IHdhcm5pbmcgd2hlbiBkcml2ZXJzIHN0aWxsCj4gPiB1c2UgdGhl
bS4gIEl0IHdhcyBhIGxvbmcgYW5kIHR3aXN0eSByb2FkLCBidXQgc2VlbXMgdG8gd29yay4KPgo+
IEFyZSB5b3UgZ29pbmcgdG8gY29udmVydCByYWRlb24gYXMgd2VsbD8gSXQncyB0aGUgb25seSBy
ZW1haW5pbmcgS01TCj4gZHJpdmVyIHRoYXQgdXNlcyBsb2FkLgoKSXQncyBvbiBteSB0b2RvIGxp
c3QsIGhvcGVmdWxseSB0aGlzIGtlcm5lbCBjeWNsZS4KCkFsZXgKCj4KPiBCZXN0IHJlZ2FyZHMK
PiBUaG9tYXMKPgo+ID4KPiA+IHYyOiBBZGQgYWRkaXRpb25hbCBwYXRjaCAoMTMvMTUpIHdoaWNo
IHNob3VsZCBmaXggdGhlIGNyYXNoIHJlcG9ydGVkIGJ5Cj4gPiBUaG9tYXMgWmltbWVybWFubi4K
PiA+IHYzOiBGaXggZHAgYXV4IHJlZ2lzdHJhdGlvbiBoYXJkZXIsIGFkZCBtaXNzaW5nIGtjb25m
aWcgZ3VhcmQKPiA+Cj4gPiBBbGV4IERldWNoZXIgKDE1KToKPiA+ICAgZHJtL2FtZGdwdTogcmVu
YW1lIGFtZGdwdV9kZWJ1Z2ZzX3ByZWVtcHRfY2xlYW51cAo+ID4gICBkcm0vYW1kZ3B1L3R0bTog
bW92ZSBkZWJ1Z2ZzIGluaXQgaW50byBjb3JlIGFtZGdwdSBkZWJ1Z2ZzCj4gPiAgIGRybS9hbWRn
cHUvcG06IG1vdmUgZGVidWdmcyBpbml0IGludG8gY29yZSBhbWRncHUgZGVidWdmcwo+ID4gICBk
cm0vYW1kZ3B1L3NhOiBtb3ZlIGRlYnVnZnMgaW5pdCBpbnRvIGNvcmUgYW1kZ3B1IGRlYnVnZnMK
PiA+ICAgZHJtL2FtZGdwdS9mZW5jZTogbW92ZSBkZWJ1Z2ZzIGluaXQgaW50byBjb3JlIGFtZGdw
dSBkZWJ1Z2ZzCj4gPiAgIGRybS9hbWRncHUvZ2VtOiBtb3ZlIGRlYnVnZnMgaW5pdCBpbnRvIGNv
cmUgYW1kZ3B1IGRlYnVnZnMKPiA+ICAgZHJtL2FtZGdwdS9yZWdzOiBtb3ZlIGRlYnVnZnMgaW5p
dCBpbnRvIGNvcmUgYW1kZ3B1IGRlYnVnZnMKPiA+ICAgZHJtL2FtZGdwdS9maXJtd2FyZTogbW92
ZSBkZWJ1Z2ZzIGluaXQgaW50byBjb3JlIGFtZGdwdSBkZWJ1Z2ZzCj4gPiAgIGRybS9hbWRncHU6
IGRvbid0IGNhbGwgZHJtX2Nvbm5lY3Rvcl9yZWdpc3RlciBmb3Igbm9uLU1TVCBwb3J0cwo+ID4g
ICBkcm0vYW1kZ3B1L2Rpc3BsYXk6IG1vdmUgZGVidWdmcyBpbml0IGludG8gY29yZSBhbWRncHUg
ZGVidWdmcyAodjIpCj4gPiAgIGRybS9hbWQvZGlzcGxheTogbW92ZSBkcGNkIGRlYnVnZnMgbWVt
YmVycyBzZXR1cAo+ID4gICBkcm0vYW1kZ3B1L2Rpc3BsYXk6IGFkZCBhIGxhdGUgcmVnaXN0ZXIg
Y29ubmVjdG9yIGNhbGxiYWNrCj4gPiAgIGRybS9hbWRncHUvZGlzcGxheTogc3BsaXQgZHAgY29u
bmVjdG9yIHJlZ2lzdHJhdGlvbiAodjIpCj4gPiAgIGRybS9hbWRncHUvcmluZzogbW92ZSBkZWJ1
Z2ZzIGluaXQgaW50byBjb3JlIGFtZGdwdSBkZWJ1Z2ZzCj4gPiAgIGRybS9hbWRncHU6IGRyb3Ag
bGVnYWN5IGRybSBsb2FkIGFuZCB1bmxvYWQgY2FsbGJhY2tzCj4gPgo+ID4gIC4uLi9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X2Nvbm5lY3RvcnMuYyAgICB8IDE3ICsrKystCj4gPiAgZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RlYnVnZnMuYyAgIHwgNjkgKysrKysrKysrKysr
KysrKysrLQo+ID4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZWJ1Z2ZzLmgg
ICB8ICAyICstCj4gPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5j
ICAgIHwgMTcgLS0tLS0KPiA+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZHJ2
LmMgICAgICAgfCAxMyArKystCj4gPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X2ZlbmNlLmMgICAgIHwgIDMgLQo+ID4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV9pYi5jICAgICAgICB8ICA3ICstCj4gPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X29iamVjdC5oICAgIHwgIDEgKwo+ID4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV9wbS5jICAgICAgICB8ICA5ICstLQo+ID4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV9wbS5oICAgICAgICB8ICAyICsKPiA+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfcmluZy5jICAgICAgfCAxNSArLS0tCj4gPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X3JpbmcuaCAgICAgIHwgIDQgKysKPiA+ICBkcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfdHRtLmMgICAgICAgfCAxNCArLS0tCj4gPiAgZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X3R0bS5oICAgICAgIHwgIDMgKwo+ID4gIGRyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2F0b21iaW9zX2RwLmMgICAgICB8IDEwICstLQo+ID4gIGRyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2RjZV92aXJ0dWFsLmMgICAgICB8ICAxIC0KPiA+ICAuLi4vZ3B1L2Ry
bS9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtLmMgfCAyNiArKystLS0tCj4gPiAgLi4u
L2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG1fZGVidWdmcy5jIHwgIDMgKwo+ID4gIC4u
Li9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG1fbXN0X3R5cGVzLmMgICB8IDEzICsrLS0KPiA+
ICAxOSBmaWxlcyBjaGFuZ2VkLCAxNDAgaW5zZXJ0aW9ucygrKSwgODkgZGVsZXRpb25zKC0pCj4g
Pgo+Cj4gLS0KPiBUaG9tYXMgWmltbWVybWFubgo+IEdyYXBoaWNzIERyaXZlciBEZXZlbG9wZXIK
PiBTVVNFIFNvZnR3YXJlIFNvbHV0aW9ucyBHZXJtYW55IEdtYkgKPiBNYXhmZWxkc3RyLiA1LCA5
MDQwOSBOw7xybmJlcmcsIEdlcm1hbnkKPiAoSFJCIDM2ODA5LCBBRyBOw7xybmJlcmcpCj4gR2Vz
Y2jDpGZ0c2bDvGhyZXI6IEZlbGl4IEltZW5kw7ZyZmZlcgo+Cl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhA
bGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxt
YW4vbGlzdGluZm8vYW1kLWdmeAo=
