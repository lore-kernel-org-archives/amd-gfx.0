Return-Path: <SRS0=0KW4=ZY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67B0AC432C0
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Dec 2019 21:33:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42A37206DC
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Dec 2019 21:33:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42A37206DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 09F456E34B;
	Mon,  2 Dec 2019 21:33:08 +0000 (UTC)
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20::343])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E2206E34B
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Dec 2019 21:33:06 +0000 (UTC)
Received: by mail-wm1-x343.google.com with SMTP id p17so1173468wmi.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 02 Dec 2019 13:33:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=h9rE0HfXd5VBnT5IPwEh7vnBDkLHSM1C6+mKoSnlqYo=;
 b=do9UijQV1B21WMMuS2/QYqm20mZnUZTB4epobbw2G1xl4dGvT7VCdDIfaNBz7jUH/T
 bfG84pso2rYYT/FNDGiUE4fgldrprKbJSgfrQDtO45N1VvfdVQDnpnSqJqF0KtFc+zvi
 S1E9kn19pEKS1lIE5UKntQk4Chj5ypIT39f/EeALhYNyM58apt8eNS+DZ0KVaGlwFngi
 WyrdJ393WM4xDqYJ2ZPKAAUE8PtFH367sUGfgSrN5P1km+WaG3hbw0F4KLJ05OibAj+Y
 QVoQY+5d5sSM4mlf3o+IVzEc1qUNt51Cq1e+WsSitGsoOgeBiFXJQlgjHsoSKw4MQ1Vc
 8o8g==
X-Gm-Message-State: APjAAAXG/kWaUJA9dDMYGtILT2FwUDGHRzKjPD/j3Vaa1/qZn0/WOW+1
 sQQP325ElrUgG0IxwzA1Wi6twvym1t2j2rm90k0qQg==
X-Google-Smtp-Source: APXvYqzZbx6dc+7Q0JCTSNtYQAekXjNkaSEkyc9nMkE/r6fVMT5CupbIBHByry1bYzi+r+cfKmgnKCOka+3TPxno5+w=
X-Received: by 2002:a7b:c95a:: with SMTP id i26mr1280049wml.67.1575322385095; 
 Mon, 02 Dec 2019 13:33:05 -0800 (PST)
MIME-Version: 1.0
References: <20191128114605.5240-1-pierre-eric.pelloux-prayer@amd.com>
In-Reply-To: <20191128114605.5240-1-pierre-eric.pelloux-prayer@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 2 Dec 2019 16:32:53 -0500
Message-ID: <CADnq5_M+p7tYmYsQd61jvkE5E8NF84bM+eMGNZM6EeRPFbwVXg@mail.gmail.com>
Subject: Re: [PATCH] drm/amgdpu: add cache flush workaround to gfx8 emit_fence
To: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc;
 bh=h9rE0HfXd5VBnT5IPwEh7vnBDkLHSM1C6+mKoSnlqYo=;
 b=X5UBVEFV/fIVoPZMpl27BsliJ4aPYBOSiJqVkFXy5UbH90PeAxq4sjTUylY4GNPZ7F
 dI52SqpxSA64w+N2yCOUUFwEF0MqitTFDaTpY9JI5VcVDWMrkW1Qpmfbrf3looV/QYP9
 FYN+rzbM9YzNk6tAhZCQZSGieVJPW5jgHWrdHKw0HHHOYGlIrons3sdavmy3n00Etmni
 2sfXQM4IsGa5HHOMQQhfyuaf3CRfm1eCxGpNsEf63tHQPLq9xfXlsbLfGTKJUBJL5yxr
 kOgUnbechPjRNX/D03x/ArudPI+VXUjf2mPdUTbeqzEGyzSOdie9ko/aRM0AMRkVAwVK
 GOPA==
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gVGh1LCBOb3YgMjgsIDIwMTkgYXQgNjo0NyBBTSBQaWVycmUtRXJpYyBQZWxsb3V4LVByYXll
cgo8cGllcnJlLWVyaWMucGVsbG91eC1wcmF5ZXJAYW1kLmNvbT4gd3JvdGU6Cj4KPiBUaGUgc2Ft
ZSB3b3JrYXJvdW5kIGlzIHVzZWQgZm9yIGdmeDcuCj4gQm90aCBQQUwgYW5kIE1lc2EgdXNlIGl0
IGZvciBnZng4IHRvbywgc28gcG9ydCB0aGlzIGNvbW1pdCB0bwo+IGdmeF92OF8wX3JpbmdfZW1p
dF9mZW5jZV9nZnguCj4KPiBTaWduZWQtb2ZmLWJ5OiBQaWVycmUtRXJpYyBQZWxsb3V4LVByYXll
ciA8cGllcnJlLWVyaWMucGVsbG91eC1wcmF5ZXJAYW1kLmNvbT4KClJldmlld2VkLWJ5OiBBbGV4
IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+Cgo+IC0tLQo+ICBkcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9nZnhfdjhfMC5jIHwgMjIgKysrKysrKysrKysrKysrKysrKy0tLQo+
ICAxIGZpbGUgY2hhbmdlZCwgMTkgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkKPgo+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjhfMC5jIGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y4XzAuYwo+IGluZGV4IDgwYjc5NTgzZGZmZS4uZGNk
NzQ3YmVmMzkxIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92
OF8wLmMKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjhfMC5jCj4gQEAg
LTYxODMsNyArNjE4MywyMyBAQCBzdGF0aWMgdm9pZCBnZnhfdjhfMF9yaW5nX2VtaXRfZmVuY2Vf
Z2Z4KHN0cnVjdCBhbWRncHVfcmluZyAqcmluZywgdTY0IGFkZHIsCj4gICAgICAgICBib29sIHdy
aXRlNjRiaXQgPSBmbGFncyAmIEFNREdQVV9GRU5DRV9GTEFHXzY0QklUOwo+ICAgICAgICAgYm9v
bCBpbnRfc2VsID0gZmxhZ3MgJiBBTURHUFVfRkVOQ0VfRkxBR19JTlQ7Cj4KPiAtICAgICAgIC8q
IEVWRU5UX1dSSVRFX0VPUCAtIGZsdXNoIGNhY2hlcywgc2VuZCBpbnQgKi8KPiArICAgICAgIC8q
IFdvcmthcm91bmQgZm9yIGNhY2hlIGZsdXNoIHByb2JsZW1zLiBGaXJzdCBzZW5kIGEgZHVtbXkg
RU9QCj4gKyAgICAgICAgKiBldmVudCBkb3duIHRoZSBwaXBlIHdpdGggc2VxIG9uZSBiZWxvdy4K
PiArICAgICAgICAqLwo+ICsgICAgICAgYW1kZ3B1X3Jpbmdfd3JpdGUocmluZywgUEFDS0VUMyhQ
QUNLRVQzX0VWRU5UX1dSSVRFX0VPUCwgNCkpOwo+ICsgICAgICAgYW1kZ3B1X3Jpbmdfd3JpdGUo
cmluZywgKEVPUF9UQ0wxX0FDVElPTl9FTiB8Cj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgRU9QX1RDX0FDVElPTl9FTiB8Cj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgRU9QX1RDX1dCX0FDVElPTl9FTiB8Cj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgRVZFTlRfVFlQRShDQUNIRV9GTFVTSF9BTkRfSU5WX1RTX0VWRU5UKSB8Cj4gKyAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgRVZFTlRfSU5ERVgoNSkpKTsKPiArICAgICAgIGFtZGdw
dV9yaW5nX3dyaXRlKHJpbmcsIGFkZHIgJiAweGZmZmZmZmZjKTsKPiArICAgICAgIGFtZGdwdV9y
aW5nX3dyaXRlKHJpbmcsICh1cHBlcl8zMl9iaXRzKGFkZHIpICYgMHhmZmZmKSB8Cj4gKyAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBEQVRBX1NFTCgxKSB8IElOVF9TRUwoMCkpOwo+ICsg
ICAgICAgYW1kZ3B1X3Jpbmdfd3JpdGUocmluZywgbG93ZXJfMzJfYml0cyhzZXEgLSAxKSk7Cj4g
KyAgICAgICBhbWRncHVfcmluZ193cml0ZShyaW5nLCB1cHBlcl8zMl9iaXRzKHNlcSAtIDEpKTsK
PiArCj4gKyAgICAgICAvKiBUaGVuIHNlbmQgdGhlIHJlYWwgRU9QIGV2ZW50IGRvd24gdGhlIHBp
cGU6Cj4gKyAgICAgICAgKiBFVkVOVF9XUklURV9FT1AgLSBmbHVzaCBjYWNoZXMsIHNlbmQgaW50
ICovCj4gICAgICAgICBhbWRncHVfcmluZ193cml0ZShyaW5nLCBQQUNLRVQzKFBBQ0tFVDNfRVZF
TlRfV1JJVEVfRU9QLCA0KSk7Cj4gICAgICAgICBhbWRncHVfcmluZ193cml0ZShyaW5nLCAoRU9Q
X1RDTDFfQUNUSU9OX0VOIHwKPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBFT1Bf
VENfQUNUSU9OX0VOIHwKPiBAQCAtNjkyNiw3ICs2OTQyLDcgQEAgc3RhdGljIGNvbnN0IHN0cnVj
dCBhbWRncHVfcmluZ19mdW5jcyBnZnhfdjhfMF9yaW5nX2Z1bmNzX2dmeCA9IHsKPiAgICAgICAg
ICAgICAgICAgNSArICAvKiBDT05EX0VYRUMgKi8KPiAgICAgICAgICAgICAgICAgNyArICAvKiBQ
SVBFTElORV9TWU5DICovCj4gICAgICAgICAgICAgICAgIFZJX0ZMVVNIX0dQVV9UTEJfTlVNX1dS
RUcgKiA1ICsgOSArIC8qIFZNX0ZMVVNIICovCj4gLSAgICAgICAgICAgICAgIDggKyAgLyogRkVO
Q0UgZm9yIFZNX0ZMVVNIICovCj4gKyAgICAgICAgICAgICAgIDEyICsgIC8qIEZFTkNFIGZvciBW
TV9GTFVTSCAqLwo+ICAgICAgICAgICAgICAgICAyMCArIC8qIEdEUyBzd2l0Y2ggKi8KPiAgICAg
ICAgICAgICAgICAgNCArIC8qIGRvdWJsZSBTV0lUQ0hfQlVGRkVSLAo+ICAgICAgICAgICAgICAg
ICAgICAgICAgdGhlIGZpcnN0IENPTkRfRVhFQyBqdW1wIHRvIHRoZSBwbGFjZSBqdXN0Cj4gQEAg
LTY5MzgsNyArNjk1NCw3IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgYW1kZ3B1X3JpbmdfZnVuY3Mg
Z2Z4X3Y4XzBfcmluZ19mdW5jc19nZnggPSB7Cj4gICAgICAgICAgICAgICAgIDMxICsgLyogREVf
TUVUQSAqLwo+ICAgICAgICAgICAgICAgICAzICsgLyogQ05UWF9DVFJMICovCj4gICAgICAgICAg
ICAgICAgIDUgKyAvKiBIRFBfSU5WTCAqLwo+IC0gICAgICAgICAgICAgICA4ICsgOCArIC8qIEZF
TkNFIHgyICovCj4gKyAgICAgICAgICAgICAgIDEyICsgMTIgKyAvKiBGRU5DRSB4MiAqLwo+ICAg
ICAgICAgICAgICAgICAyLCAvKiBTV0lUQ0hfQlVGRkVSICovCj4gICAgICAgICAuZW1pdF9pYl9z
aXplID0gNCwgLyogZ2Z4X3Y4XzBfcmluZ19lbWl0X2liX2dmeCAqLwo+ICAgICAgICAgLmVtaXRf
aWIgPSBnZnhfdjhfMF9yaW5nX2VtaXRfaWJfZ2Z4LAo+IC0tCj4gMi4yNC4wLnJjMAo+Cj4gX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KPiBhbWQtZ2Z4IG1h
aWxpbmcgbGlzdAo+IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4gaHR0cHM6Ly9saXN0
cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFt
ZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
L21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
