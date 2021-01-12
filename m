Return-Path: <SRS0=dvhx=GP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,TVD_SPACE_RATIO,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 372E1C433E0
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Jan 2021 22:15:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB76023122
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Jan 2021 22:14:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB76023122
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A1DD8997A;
	Tue, 12 Jan 2021 22:14:57 +0000 (UTC)
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com
 [IPv6:2607:f8b0:4864:20::233])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A11C8992E;
 Tue, 12 Jan 2021 22:14:56 +0000 (UTC)
Received: by mail-oi1-x233.google.com with SMTP id 9so7716oiq.3;
 Tue, 12 Jan 2021 14:14:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=mgU5jkLsPTxf7PjvzoVb968S/d/btYMMsecHfiFbgnQ=;
 b=SLfTxXfiNSmIywoBUgkSSVTP7YVFGG2QGXJT22GiWycCWedrsEUjcZ5K/MQzjx+ycI
 T7EXLjC4Eg2Px3Hk4JYmemIN8ROwHpXlnsQxomhQND0quXx0XQBSBqXKelj4IDypCqMW
 okmMo3Xqq1gF5tYkB8Zq3G6ruThIOvkQjleIq/mJX4CLKtkIifaQEiSjq5f2dcvYuU4y
 0mlSJQNb4NTcw4PfCi57r/qQICtx0Hwq6t3tIulFNvu8aAv711ryGoJuHkatBdYJ/l6j
 BX2HcGjiuDGvNdUzDyzp6IFimXbyqe5PqChLfBXif+acOH8wSZ4NPXROcgjXhKjxDb8p
 tomQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=mgU5jkLsPTxf7PjvzoVb968S/d/btYMMsecHfiFbgnQ=;
 b=PrX5pDg+UtML+8+EkknJPLaWV0J4eSv8L1RPv+tJaDDitxSuQtmX54cuKtohaP1cOm
 qWw3Nad2Isq2ffr5WljTgeAQtCavkr36YnLfWOXp5Z/8bi4w95rcfMtN1WHNe6s3X8f3
 rHphcNSkwiM6NKD9fiYlJspArWHCMmdfVa50qaKelOKqWWyvMsuP2FVQOQJgFuM1Iqvr
 StonWj8FroBZZa5dl5AwgbVRefcUaFG0P/8Y22n1PdNfhf4prc9iUt+J/ChLczRs+7r9
 3+kiXQGwrKnOUcpFksbjBGcVmqF8cADQYdjKJvgwdbtxB50jLUkeeIveBgXI/Ugm30p2
 Iy5A==
X-Gm-Message-State: AOAM533aWusaXpvO4qfGfJbYYJX8/uxKJXhsC2bddrRlG23eI6zSy/aI
 duQ9Sk8GgkAQVGAojhY4bAgh2ph6BW7btUHsBU90+gJh
X-Google-Smtp-Source: ABdhPJzNkqC3YkrL9KY0P3P5EnFnUOd5nlAzmlvic7hUx5DKSOy0ZUhYY/iGLcG/F4erX5sLzTr0o8N+AQFxWt10MZs=
X-Received: by 2002:aca:4f97:: with SMTP id d145mr785715oib.123.1610489695373; 
 Tue, 12 Jan 2021 14:14:55 -0800 (PST)
MIME-Version: 1.0
References: <20210111191926.3688443-1-lee.jones@linaro.org>
 <20210111191926.3688443-17-lee.jones@linaro.org>
In-Reply-To: <20210111191926.3688443-17-lee.jones@linaro.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 12 Jan 2021 17:14:40 -0500
Message-ID: <CADnq5_NOmrELAah=Qt37rLQeW05RCEmmnhLDfNwAh8mpkybJyQ@mail.gmail.com>
Subject: Re: [PATCH 16/40] drm/amd/display/dc/dce120/dce120_timing_generator:
 Demote non-kerneldoc headers
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
Cc: Leo Li <sunpeng.li@amd.com>, LKML <linux-kernel@vger.kernel.org>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 David Airlie <airlied@linux.ie>, amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gTW9uLCBKYW4gMTEsIDIwMjEgYXQgMjoyMCBQTSBMZWUgSm9uZXMgPGxlZS5qb25lc0BsaW5h
cm8ub3JnPiB3cm90ZToKPgo+IEZpeGVzIHRoZSBmb2xsb3dpbmcgVz0xIGtlcm5lbCBidWlsZCB3
YXJuaW5nKHMpOgo+Cj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1Ly4uL2Rpc3BsYXkvZGMv
ZGNlMTIwL2RjZTEyMF90aW1pbmdfZ2VuZXJhdG9yLmM6NjAyOjEzOiB3YXJuaW5nOiDigJhkY2Ux
MjBfdGltaW5nX2dlbmVyYXRvcl9nZXRfcG9zaXRpb27igJkgZGVmaW5lZCBidXQgbm90IHVzZWQg
Wy1XdW51c2VkLWZ1bmN0aW9uXQo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS8uLi9kaXNw
bGF5L2RjL2RjZTEyMC9kY2UxMjBfdGltaW5nX2dlbmVyYXRvci5jOjczOiB3YXJuaW5nOiBDYW5u
b3QgdW5kZXJzdGFuZCAgKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioKPiAgZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvLi4vZGlzcGxheS9kYy9kY2UxMjAvZGNlMTIwX3RpbWluZ19nZW5lcmF0b3IuYzo1
OTM6IHdhcm5pbmc6IENhbm5vdCB1bmRlcnN0YW5kICAqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKgo+Cj4g
Q2M6IEhhcnJ5IFdlbnRsYW5kIDxoYXJyeS53ZW50bGFuZEBhbWQuY29tPgo+IENjOiBMZW8gTGkg
PHN1bnBlbmcubGlAYW1kLmNvbT4KPiBDYzogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hl
ckBhbWQuY29tPgo+IENjOiAiQ2hyaXN0aWFuIEvDtm5pZyIgPGNocmlzdGlhbi5rb2VuaWdAYW1k
LmNvbT4KPiBDYzogRGF2aWQgQWlybGllIDxhaXJsaWVkQGxpbnV4LmllPgo+IENjOiBEYW5pZWwg
VmV0dGVyIDxkYW5pZWxAZmZ3bGwuY2g+Cj4gQ2M6IExlZSBKb25lcyA8bGVlLmpvbmVzQGxpbmFy
by5vcmc+Cj4gQ2M6IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4gQ2M6IGRyaS1kZXZl
bEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPiBTaWduZWQtb2ZmLWJ5OiBMZWUgSm9uZXMgPGxlZS5q
b25lc0BsaW5hcm8ub3JnPgoKQXBwbGllZC4gIFRoYW5rcyEKCkFsZXgKCj4gLS0tCj4gIC4uLi9n
cHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjZTEyMC9kY2UxMjBfdGltaW5nX2dlbmVyYXRvci5jICAg
fCA0ICsrLS0KPiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMo
LSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNlMTIw
L2RjZTEyMF90aW1pbmdfZ2VuZXJhdG9yLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkv
ZGMvZGNlMTIwL2RjZTEyMF90aW1pbmdfZ2VuZXJhdG9yLmMKPiBpbmRleCBlYmM3ZDYxZThiZjM2
Li5kMDJlY2I5ODNjOWNkIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxh
eS9kYy9kY2UxMjAvZGNlMTIwX3RpbWluZ19nZW5lcmF0b3IuYwo+ICsrKyBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvZGlzcGxheS9kYy9kY2UxMjAvZGNlMTIwX3RpbWluZ19nZW5lcmF0b3IuYwo+IEBA
IC02OSw3ICs2OSw3IEBACj4gICNkZWZpbmUgQ1JUQ19SRUdfU0VUXzMocmVnLCBmaWVsZDEsIHZh
bDEsIGZpZWxkMiwgdmFsMiwgZmllbGQzLCB2YWwzKSAgXAo+ICAgICAgICAgICAgICAgICBDUlRD
X1JFR19TRVRfTihyZWcsIDMsIEZEKHJlZyMjX18jI2ZpZWxkMSksIHZhbDEsIEZEKHJlZyMjX18j
I2ZpZWxkMiksIHZhbDIsIEZEKHJlZyMjX18jI2ZpZWxkMyksIHZhbDMpCj4KPiAtLyoqCj4gKy8q
Cj4gICAqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKgo+ICAgKiAgRnVuY3Rpb246IGlzX2luX3ZlcnRpY2Fs
X2JsYW5rCj4gICAqCj4gQEAgLTU4OSw3ICs1ODksNyBAQCBzdGF0aWMgdm9pZCBkY2UxMjBfdGlt
aW5nX2dlbmVyYXRvcl9zZXRfZHJyKAo+ICAgICAgICAgfQo+ICB9Cj4KPiAtLyoqCj4gKy8qCj4g
ICAqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKgo+ICAgKiAgRnVuY3Rpb246IGRjZTEyMF90aW1pbmdfZ2Vu
ZXJhdG9yX2dldF9wb3NpdGlvbgo+ICAgKgo+IC0tCj4gMi4yNS4xCj4KPiBfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+IGRyaS1kZXZlbCBtYWlsaW5nIGxp
c3QKPiBkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4gaHR0cHM6Ly9saXN0cy5mcmVl
ZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9kcmktZGV2ZWwKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdm
eEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFp
bG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
