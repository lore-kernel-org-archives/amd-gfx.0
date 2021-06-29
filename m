Return-Path: <SRS0=w1A1=LX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 002A8C11F66
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Jun 2021 14:17:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A51B761DB3
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Jun 2021 14:17:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A51B761DB3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 246C06E89D;
	Tue, 29 Jun 2021 14:17:53 +0000 (UTC)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B7B36E883;
 Tue, 29 Jun 2021 14:17:49 +0000 (UTC)
Received: by mail-ot1-x334.google.com with SMTP id
 t24-20020a9d7f980000b029046f4a1a5ec4so908793otp.1; 
 Tue, 29 Jun 2021 07:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=ca9b/RJBp6vFH4Z8SWl5H4/Izby04wi57Lwxa0JLyrs=;
 b=LJcaYPROk5PS/GO/KmuD4NNz/hB69mF5BLuqEZWjNJWkR5tss9yy9ob8LNmQ0LpHx1
 T4l5ruxUNJFzXKNKUranp6fvbr8bOuweBUVqf2n95m5si7ScYTzb9eueYMIxKM5Hr+Lr
 S6aL7we9LHKVCL5ydwi2O/GZMoFkOoil/SS2VmTT+U+fscM2Ha+KkT9h2gUP3MszFcqr
 k4Tk2mF6jo2Z66LFTKa4FaPa2z8hPSrDBkGmea7ufgDwLTt0d0sgAIMIBRKpea0LGo0D
 nS46tCP0MwkKsNKZfuIKLq2YBilWRgI+ywIim2+1pgg981yp4r/twiVowE88w9Nceb4D
 0grg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=ca9b/RJBp6vFH4Z8SWl5H4/Izby04wi57Lwxa0JLyrs=;
 b=j/1zuczGSoYju5s10P0ZvG/6M7BlaQp9jUPjjvaSA4/9L/9Y2fPeXpI5m/LPIQFEfM
 7W/9cI4xpdLXFusCGAJlLvs6RduHBKmEXCkc/P8Z2abloT03uI2DKlCKtIzSUeAOR8jX
 HtIjBJMMmyUPO5BwAEcR+c1EbzZZ9VmI5S6S8KDQkWdw9CPeBmx1p8nQo+kdiejZSUuO
 INBj9SLAPQT5JfR57hqDvcNleGKh0saLw2i3ltxSG0XeiQpShuRnUtVZaMW9hSN2s86D
 VvQU3tus5oqHJyElo1MSBnNt5thYOMfw2X1KXStLHFCuzMZCQMvEUZblhoq3MmwKuiof
 96iA==
X-Gm-Message-State: AOAM530O7bM5VdG47aKF2LFatbM2+M89sRB6C/V4BKC5dxldVPoTkjpe
 WtyOIYoyq/zVrQJbH4XDxSx7ql58V4f3hcp7nho=
X-Google-Smtp-Source: ABdhPJw2CJEKzgyewXcuEZEPTcfsz3H8f6me+j7nAF4nXArSiuFEdABdhNogjc6cwbt9NfbqjiN/eba0bUuDjcZfZyg=
X-Received: by 2002:a05:6830:33ef:: with SMTP id
 i15mr4672446otu.311.1624976269048; 
 Tue, 29 Jun 2021 07:17:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210629114455.12963-1-jingxiangfeng@huawei.com>
 <5ff91e15-6014-bc72-40ca-3fa8b834f692@amd.com>
In-Reply-To: <5ff91e15-6014-bc72-40ca-3fa8b834f692@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 29 Jun 2021 10:17:38 -0400
Message-ID: <CADnq5_P0whWU-j3ZasO2hUYLWQEy7v=2jtc7hOisfgALu84xsw@mail.gmail.com>
Subject: Re: [PATCH -next] drm/radeon: Add the missed drm_gem_object_put() in
 radeon_user_framebuffer_create()
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
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
Cc: Dave Airlie <airlied@linux.ie>, LKML <linux-kernel@vger.kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Jing Xiangfeng <jingxiangfeng@huawei.com>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 Daniel Vetter <daniel@ffwll.ch>, "Deucher,
 Alexander" <alexander.deucher@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QXBwbGllZC4gIFRoYW5rcyEKCkFsZXgKCk9uIFR1ZSwgSnVuIDI5LCAyMDIxIGF0IDc6NDIgQU0g
Q2hyaXN0aWFuIEvDtm5pZwo8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPiB3cm90ZToKPgo+IEFt
IDI5LjA2LjIxIHVtIDEzOjQ0IHNjaHJpZWIgSmluZyBYaWFuZ2Zlbmc6Cj4gPiByYWRlb25fdXNl
cl9mcmFtZWJ1ZmZlcl9jcmVhdGUoKSBtaXNzZXMgdG8gY2FsbCBkcm1fZ2VtX29iamVjdF9wdXQo
KSBpbgo+ID4gYW4gZXJyb3IgcGF0aC4gQWRkIHRoZSBtaXNzZWQgZnVuY3Rpb24gY2FsbCB0byBm
aXggaXQuCj4gPgo+ID4gU2lnbmVkLW9mZi1ieTogSmluZyBYaWFuZ2ZlbmcgPGppbmd4aWFuZ2Zl
bmdAaHVhd2VpLmNvbT4KPgo+IEknbSBwcmV0dHkgc3VyZSB0aGF0IEkgYWxyZWFkeSByZXZpZXdl
ZCB0aGUgc2FtZSBwYXRjaCBhIGZldyB3ZWVrcyBhZ28sCj4gYnV0IGl0IGxvb2tzIGxpa2UgaXQg
bmV2ZXIgd2VudCB1cHN0cmVhbS4KPgo+IFJldmlld2VkLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxj
aHJpc3RpYW4ua29lbmlnQGFtZC5jb20+Cj4KPiBNYXliZSBhZGQgQ0M6IHN0YWJsZSBhcyB3ZWxs
Pwo+Cj4gUmVnYXJkcywKPiBDaHJpc3RpYW4uCj4KPiA+IC0tLQo+ID4gICBkcml2ZXJzL2dwdS9k
cm0vcmFkZW9uL3JhZGVvbl9kaXNwbGF5LmMgfCAxICsKPiA+ICAgMSBmaWxlIGNoYW5nZWQsIDEg
aW5zZXJ0aW9uKCspCj4gPgo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24v
cmFkZW9uX2Rpc3BsYXkuYyBiL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vcmFkZW9uX2Rpc3BsYXku
Ywo+ID4gaW5kZXggNjUyYWY3YTEzNGJkLi4xZDAzZWM3NjM2MDQgMTAwNjQ0Cj4gPiAtLS0gYS9k
cml2ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVvbl9kaXNwbGF5LmMKPiA+ICsrKyBiL2RyaXZlcnMv
Z3B1L2RybS9yYWRlb24vcmFkZW9uX2Rpc3BsYXkuYwo+ID4gQEAgLTEzMjUsNiArMTMyNSw3IEBA
IHJhZGVvbl91c2VyX2ZyYW1lYnVmZmVyX2NyZWF0ZShzdHJ1Y3QgZHJtX2RldmljZSAqZGV2LAo+
ID4gICAgICAgLyogSGFuZGxlIGlzIGltcG9ydGVkIGRtYS1idWYsIHNvIGNhbm5vdCBiZSBtaWdy
YXRlZCB0byBWUkFNIGZvciBzY2Fub3V0ICovCj4gPiAgICAgICBpZiAob2JqLT5pbXBvcnRfYXR0
YWNoKSB7Cj4gPiAgICAgICAgICAgICAgIERSTV9ERUJVR19LTVMoIkNhbm5vdCBjcmVhdGUgZnJh
bWVidWZmZXIgZnJvbSBpbXBvcnRlZCBkbWFfYnVmXG4iKTsKPiA+ICsgICAgICAgICAgICAgZHJt
X2dlbV9vYmplY3RfcHV0KG9iaik7Cj4gPiAgICAgICAgICAgICAgIHJldHVybiBFUlJfUFRSKC1F
SU5WQUwpOwo+ID4gICAgICAgfQo+ID4KPgo+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCj4gYW1kLWdmeCBtYWlsaW5nIGxpc3QKPiBhbWQtZ2Z4QGxpc3Rz
LmZyZWVkZXNrdG9wLm9yZwo+IGh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4v
bGlzdGluZm8vYW1kLWdmeApfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9y
ZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
