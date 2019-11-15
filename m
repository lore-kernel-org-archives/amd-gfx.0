Return-Path: <SRS0=FndT=ZH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65DD1C432C3
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Nov 2019 16:52:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E3812072A
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Nov 2019 16:52:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E3812072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 066E06E99D;
	Fri, 15 Nov 2019 16:52:37 +0000 (UTC)
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A46C6E99D
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Nov 2019 16:52:36 +0000 (UTC)
Received: by mail-wr1-x444.google.com with SMTP id n1so11687818wra.10
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Nov 2019 08:52:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=R9s7MfIzvjPu1zF+F9Ph0HSFGZ2qUCcb6DL62GKi9Oo=;
 b=Tp1PR+mmZMSOV6p0lZb72ybL634eGSrHdOelSnfr8i5Y+RYLzpAdaArKuEnbj0jPSF
 PWAQBGlU2UE2h2lcSPtC6ZlYzutCRkZveF3dqJ1a/paK/G59/iAbXcyorAlPWCHtwhJX
 XgILTPf2I8UoL0P1N1NEg6lNlC+mYegFIoTpHE/ekzSPsmZqN14jsgfusvBRC8QVy+Iq
 YpZoObDX+iuEFH4Zqmduz2QZwDCTee74u9WTVBWbgn9p7pBsIkMQiPKwdITk2O13aFwr
 IKLyV0T8MjJByconC6ntcEUZEbLieOyyx05zUA/RwH5xCHLUWTvFjkHoEQacpaB3koxq
 KBrQ==
X-Gm-Message-State: APjAAAXrr4T9tUjwAIdUQ0NxXGghz9o9427MP0k3uzF0PeO7MdJml0q9
 vD7zO9VEFosJj25FUMP838nf/KoVSnHEBiNgLj0=
X-Google-Smtp-Source: APXvYqwIaTWmSGtdDz8LGTD8OnEKnbqhC0iM6kvucxGWf/citdvlTD0kM4qUXy7h/s/1l31040ehyK9qSh5wEyXNoRA=
X-Received: by 2002:adf:fb0b:: with SMTP id c11mr16931325wrr.50.1573836754804; 
 Fri, 15 Nov 2019 08:52:34 -0800 (PST)
MIME-Version: 1.0
References: <20191114164148.2304223-1-alexander.deucher@amd.com>
 <20191114164148.2304223-2-alexander.deucher@amd.com>
 <93CD6C6F-21F7-4BCA-AC65-FDC37AF896E3@amd.com>
In-Reply-To: <93CD6C6F-21F7-4BCA-AC65-FDC37AF896E3@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 15 Nov 2019 11:52:23 -0500
Message-ID:
 <CADnq5_McjfD_ZJHa_RFzfRuxFzjSkG7C1S1VhtYNPHH_f9MViA@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amdgpu: disable gfxoff when using register read
 interface
To: "Yuan, Xiaojie" <Xiaojie.Yuan@amd.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc;
 bh=R9s7MfIzvjPu1zF+F9Ph0HSFGZ2qUCcb6DL62GKi9Oo=;
 b=eUsIRUgVQKBkfmlTvGhpGrI6IIICeh5HisaHIxJ3JiDFP1+3elPrOoe+0F392y+uvI
 1rRXy6x5KPIxxgQtG8FCcq1UULss27/IjQIlPCzU2vXpNMlO2xWl83IoQo+zdTeMZKQO
 kbHKscPaIVrBz9YuIth3ujovD9YkwfgTJKNsGfhmSmmu0i8uRCbNspuupDyvBqViLB7r
 6C2RU/jftmFfu1cP0axOt9/VaGlmYDsHzfNNe9hfoOmZqpITQg6mmfJFI9dlzr32HeoA
 bMYlmo+7t1jLr+I99vGJUfPzN8Ho5ha63EKoX3sZiUzMGDIylkmPv013vWGKngoA5gI0
 1JOQ==
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191115165223.4ga9KkKopfKrlyGLaU2_UZK2cUG0Uk2g4eA994zm2LU@z>

T24gRnJpLCBOb3YgMTUsIDIwMTkgYXQgMTE6NDYgQU0gWXVhbiwgWGlhb2ppZSA8WGlhb2ppZS5Z
dWFuQGFtZC5jb20+IHdyb3RlOgo+Cj4gSGkgQWxleCwKPgo+IElNSE8sIGRyaXZlciBzZW5kaW5n
IERpc2FsbG93X0dmeG9mZiBtZXNzYWdlIHRvIFNNVSBkb2Vzbid0IG1lYW4gZ2Z4IGJsb2NrIHdp
bGwgYmUgaW1tZWRpYXRlbHkgcG93ZXJlZCB1cCwgc28gSSdtIG5vdCBzdXJlIE1NSU8gcmVnaXN0
ZXIgYWNjZXNzIHdpbGwgYmUgc3VjY2Vzc2Z1bCB3aXRoaW4gdGhpcyB0aW1lIHdpbmRvdyhtYXli
ZSBHUkJNIGFjY2VzcyB3aWxsIGJlIHBlbmRpbmcgdW50aWwgZ2Z4IGJsb2NrIGlzIHBvd2VyZWQg
dXA/KQo+Cj4gSWYgeW91IGFyZSBub3QgaW4gYSBodXJyeSB0byBjb21taXQgdGhpcyBmaXgsIEkg
Y2FuIHZlcmlmeSBvbiBteSBOYXZpIGJvYXJkcyBuZXh0IE1vbmRheS4KClRoYXQgd291bGQgYmUg
Z3JlYXQuICBNYXliZSB3ZSBjYW4gYWRkIGEgZGVsYXkgaW4gdGhhdCBmdW5jdGlvbiB0bwp0YWtl
IHRoYXQgaW50byBhY2NvdW50PwoKVGhhbmtzIQoKQWxleAoKPgo+IEJSLAo+IFhpYW9qaWUKPgo+
ID4gT24gTm92IDE1LCAyMDE5LCBhdCAxMjo0NCBBTSwgQWxleCBEZXVjaGVyIDxhbGV4ZGV1Y2hl
ckBnbWFpbC5jb20+IHdyb3RlOgo+ID4KPiA+IFdoZW4gZ2Z4b2ZmIGlzIGVuYWJsZWQsIGFjY2Vz
c2luZyBnZnggcmVnaXN0ZXJzIHZpYSBNTUlPCj4gPiBjYW4gbGVhZCB0byBhIGhhbmcuCj4gPgo+
ID4gQnVnOiBodHRwczovL2J1Z3ppbGxhLmtlcm5lbC5vcmcvc2hvd19idWcuY2dpP2lkPTIwNTQ5
Nwo+ID4gU2lnbmVkLW9mZi1ieTogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQu
Y29tPgo+ID4gLS0tCj4gPiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfa21zLmMg
fCA2ICsrKysrLQo+ID4gMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlv
bigtKQo+ID4KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfa21zLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfa21zLmMKPiA+IGlu
ZGV4IDZkZGVhNzYwN2FkMC4uNWYzYjNhNzA1YjI5IDEwMDY0NAo+ID4gLS0tIGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2ttcy5jCj4gPiArKysgYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfa21zLmMKPiA+IEBAIC02NTksMTUgKzY1OSwxOSBAQCBzdGF0aWMg
aW50IGFtZGdwdV9pbmZvX2lvY3RsKHN0cnVjdCBkcm1fZGV2aWNlICpkZXYsIHZvaWQgKmRhdGEs
IHN0cnVjdCBkcm1fZmlsZQo+ID4gICAgICAgICAgICByZXR1cm4gLUVOT01FTTsKPiA+ICAgICAg
ICBhbGxvY19zaXplID0gaW5mby0+cmVhZF9tbXJfcmVnLmNvdW50ICogc2l6ZW9mKCpyZWdzKTsK
PiA+Cj4gPiAtICAgICAgICBmb3IgKGkgPSAwOyBpIDwgaW5mby0+cmVhZF9tbXJfcmVnLmNvdW50
OyBpKyspCj4gPiArICAgICAgICBhbWRncHVfZ2Z4X29mZl9jdHJsKGFkZXYsIGZhbHNlKTsKPiA+
ICsgICAgICAgIGZvciAoaSA9IDA7IGkgPCBpbmZvLT5yZWFkX21tcl9yZWcuY291bnQ7IGkrKykg
ewo+ID4gICAgICAgICAgICBpZiAoYW1kZ3B1X2FzaWNfcmVhZF9yZWdpc3RlcihhZGV2LCBzZV9u
dW0sIHNoX251bSwKPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgaW5mby0+cmVhZF9t
bXJfcmVnLmR3b3JkX29mZnNldCArIGksCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICZyZWdzW2ldKSkgewo+ID4gICAgICAgICAgICAgICAgRFJNX0RFQlVHX0tNUygidW5hbGxvd2Vk
IG9mZnNldCAlI3hcbiIsCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgaW5mby0+cmVhZF9t
bXJfcmVnLmR3b3JkX29mZnNldCArIGkpOwo+ID4gICAgICAgICAgICAgICAga2ZyZWUocmVncyk7
Cj4gPiArICAgICAgICAgICAgICAgIGFtZGdwdV9nZnhfb2ZmX2N0cmwoYWRldiwgdHJ1ZSk7Cj4g
PiAgICAgICAgICAgICAgICByZXR1cm4gLUVGQVVMVDsKPiA+ICAgICAgICAgICAgfQo+ID4gKyAg
ICAgICAgfQo+ID4gKyAgICAgICAgYW1kZ3B1X2dmeF9vZmZfY3RybChhZGV2LCB0cnVlKTsKPiA+
ICAgICAgICBuID0gY29weV90b191c2VyKG91dCwgcmVncywgbWluKHNpemUsIGFsbG9jX3NpemUp
KTsKPiA+ICAgICAgICBrZnJlZShyZWdzKTsKPiA+ICAgICAgICByZXR1cm4gbiA/IC1FRkFVTFQg
OiAwOwo+ID4gLS0KPiA+IDIuMjMuMAo+ID4KPiA+IF9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCj4gPiBhbWQtZ2Z4IG1haWxpbmcgbGlzdAo+ID4gYW1kLWdm
eEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPiA+IGh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
L21haWxtYW4vbGlzdGluZm8vYW1kLWdmeApfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVk
ZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2FtZC1nZng=
