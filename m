Return-Path: <SRS0=xWtd=E6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B646C2D0E4
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Nov 2020 16:19:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93BF1206B7
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Nov 2020 16:19:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i4zQwZN2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93BF1206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E280A6E4AF;
	Tue, 24 Nov 2020 16:19:25 +0000 (UTC)
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com
 [IPv6:2a00:1450:4864:20::342])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D3FF6E4AD;
 Tue, 24 Nov 2020 16:19:24 +0000 (UTC)
Received: by mail-wm1-x342.google.com with SMTP id a3so3442513wmb.5;
 Tue, 24 Nov 2020 08:19:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=7HGiO0DgR9eXvqkxA8eOYyORP/pAS/lYW6lSD1i1EXI=;
 b=i4zQwZN2jbnV5TFiUsIybhPvEcn/SA4ob58frZNxSiSy8XYTfX0yCfngM6U73z+HRz
 Gak74tqXM8qCD7Jd6g/scdbe2T5/TXFAT0vEAsWBgfqxMm+S25fDyCbAmaDlVcsuENCi
 6emutj2AKoonRuyv9grPOHSI8hKmlc0gEsxe9U/7roehsl93sG3ictaVRAb9UWGeGUUq
 iC3NPw14YdoC40jf3DB8GrViRyaLFKRx3vBy8t3cvwlT9zqpIQTvvwbfwZagvH9mT7fJ
 +2pmZf1Js4B30E7eKKApgLDjKxZ269DlcdliYuVgparSy/qX3NHW4BXpNFIFgBJeKlWb
 B5XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=7HGiO0DgR9eXvqkxA8eOYyORP/pAS/lYW6lSD1i1EXI=;
 b=qyr3fT/oY0gZFfVdHoGj4xISOItRIZ+OZDKER6uQGOYqMtNuAnYkM/AbSsc6E76u1s
 yGbMvCUvKCGqHmOR4st8yMoBCWuHujEMcFoPyqVYZXbFxZkYK75Avb6N4aBDjvFUuWzs
 tPzGpoWpqilcYRE4qRAadmn4BeZtSN0MMJD831ybdj7VslYTlgLi5ZXRNbjM+dSq8pVp
 MMH+m9QgTWtUc9iY3NIuCqQznEpAEzvD8Cbo8xuCkTU7IjxgKn+unx7ik2Yctf1iBPZU
 xo6uLaU8HdFCBbW2mNyDf/TwZx7keS4EpOJ5iJPhYnZpn0hJ2N2TfwrnijkeicPHiGwH
 A4Cg==
X-Gm-Message-State: AOAM5336kZ9TcRBLWfsmpD+gu6ZX0YtKLzVx0Xdajd94DkHc93Wjcf4W
 cNzqAzeVi446XG9tqK6JUrEMPoIlSCicz1OXYeY=
X-Google-Smtp-Source: ABdhPJwGyYag4yGAiHq/SMaLo1AA1wmaXzNEGygYbvFDgDJscO523CXblf6N8wr/xd8P8i/MgAybqmvp+cnzQyuQwCQ=
X-Received: by 2002:a1c:1c3:: with SMTP id 186mr5127721wmb.39.1606234763015;
 Tue, 24 Nov 2020 08:19:23 -0800 (PST)
MIME-Version: 1.0
References: <20201123111919.233376-1-lee.jones@linaro.org>
 <20201123111919.233376-34-lee.jones@linaro.org>
In-Reply-To: <20201123111919.233376-34-lee.jones@linaro.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 24 Nov 2020 11:19:12 -0500
Message-ID: <CADnq5_Nt3pi9F1fGF24ZWk2rE_Hk+g2-dNhQrCcoKMxNizFLCg@mail.gmail.com>
Subject: Re: [PATCH 33/40] drm/amd/amdgpu/cik_sdma: Add one and remove another
 function param description
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
 "moderated list:DMA BUFFER SHARING FRAMEWORK" <linaro-mm-sig@lists.linaro.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 linux-media <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gTW9uLCBOb3YgMjMsIDIwMjAgYXQgNjoyMCBBTSBMZWUgSm9uZXMgPGxlZS5qb25lc0BsaW5h
cm8ub3JnPiB3cm90ZToKPgo+IEZpeGVzIHRoZSBmb2xsb3dpbmcgVz0xIGtlcm5lbCBidWlsZCB3
YXJuaW5nKHMpOgo+Cj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Npa19zZG1hLmM6Mjgy
OiB3YXJuaW5nOiBGdW5jdGlvbiBwYXJhbWV0ZXIgb3IgbWVtYmVyICdmbGFncycgbm90IGRlc2Ny
aWJlZCBpbiAnY2lrX3NkbWFfcmluZ19lbWl0X2ZlbmNlJwo+ICBkcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9jaWtfc2RtYS5jOjI4Mjogd2FybmluZzogRXhjZXNzIGZ1bmN0aW9uIHBhcmFtZXRl
ciAnZmVuY2UnIGRlc2NyaXB0aW9uIGluICdjaWtfc2RtYV9yaW5nX2VtaXRfZmVuY2UnCj4KPiBD
YzogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgo+IENjOiAiQ2hyaXN0
aWFuIEvDtm5pZyIgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KPiBDYzogRGF2aWQgQWlybGll
IDxhaXJsaWVkQGxpbnV4LmllPgo+IENjOiBEYW5pZWwgVmV0dGVyIDxkYW5pZWxAZmZ3bGwuY2g+
Cj4gQ2M6IFN1bWl0IFNlbXdhbCA8c3VtaXQuc2Vtd2FsQGxpbmFyby5vcmc+Cj4gQ2M6IGFtZC1n
ZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4gQ2M6IGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3Rv
cC5vcmcKPiBDYzogbGludXgtbWVkaWFAdmdlci5rZXJuZWwub3JnCj4gQ2M6IGxpbmFyby1tbS1z
aWdAbGlzdHMubGluYXJvLm9yZwo+IFNpZ25lZC1vZmYtYnk6IExlZSBKb25lcyA8bGVlLmpvbmVz
QGxpbmFyby5vcmc+CgpBcHBsaWVkIHdpdGggbWlub3IgY2hhbmdlcy4gIFRoYW5rcyEKCkFsZXgK
Cj4gLS0tCj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Npa19zZG1hLmMgfCA0ICsrLS0K
PiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKPgo+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9jaWtfc2RtYS5jIGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvY2lrX3NkbWEuYwo+IGluZGV4IGYxZTk5NjZlNzI0NGUuLjI4
YTY0ZGU4YWUwZTYgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvY2lr
X3NkbWEuYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Npa19zZG1hLmMKPiBA
QCAtMjcxLDcgKzI3MSw3IEBAIHN0YXRpYyB2b2lkIGNpa19zZG1hX3JpbmdfZW1pdF9oZHBfZmx1
c2goc3RydWN0IGFtZGdwdV9yaW5nICpyaW5nKQo+ICAgKiBAcmluZzogYW1kZ3B1IHJpbmcgcG9p
bnRlcgo+ICAgKiBAYWRkcjogYWRkcmVzcwo+ICAgKiBAc2VxOiBzZXF1ZW5jZSBudW1iZXIKPiAt
ICogQGZlbmNlOiBhbWRncHUgZmVuY2Ugb2JqZWN0Cj4gKyAqIEBmbGFnczogZmVuY2UgcmVsYXRl
ZCBmbGFncwo+ICAgKgo+ICAgKiBBZGQgYSBETUEgZmVuY2UgcGFja2V0IHRvIHRoZSByaW5nIHRv
IHdyaXRlCj4gICAqIHRoZSBmZW5jZSBzZXEgbnVtYmVyIGFuZCBETUEgdHJhcCBwYWNrZXQgdG8g
Z2VuZXJhdGUKPiBAQCAtMjc5LDcgKzI3OSw3IEBAIHN0YXRpYyB2b2lkIGNpa19zZG1hX3Jpbmdf
ZW1pdF9oZHBfZmx1c2goc3RydWN0IGFtZGdwdV9yaW5nICpyaW5nKQo+ICAgKi8KPiAgc3RhdGlj
IHZvaWQgY2lrX3NkbWFfcmluZ19lbWl0X2ZlbmNlKHN0cnVjdCBhbWRncHVfcmluZyAqcmluZywg
dTY0IGFkZHIsIHU2NCBzZXEsCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IHVuc2lnbmVkIGZsYWdzKQo+IC17Cj4gKyAgewo+ICAgICAgICAgYm9vbCB3cml0ZTY0Yml0ID0g
ZmxhZ3MgJiBBTURHUFVfRkVOQ0VfRkxBR182NEJJVDsKPiAgICAgICAgIC8qIHdyaXRlIHRoZSBm
ZW5jZSAqLwo+ICAgICAgICAgYW1kZ3B1X3Jpbmdfd3JpdGUocmluZywgU0RNQV9QQUNLRVQoU0RN
QV9PUENPREVfRkVOQ0UsIDAsIDApKTsKPiAtLQo+IDIuMjUuMQo+Cj4gX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KPiBkcmktZGV2ZWwgbWFpbGluZyBsaXN0
Cj4gZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+IGh0dHBzOi8vbGlzdHMuZnJlZWRl
c2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhA
bGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxt
YW4vbGlzdGluZm8vYW1kLWdmeAo=
