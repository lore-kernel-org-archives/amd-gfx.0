Return-Path: <SRS0=dvhx=GP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,TVD_SPACE_RATIO,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB9E8C433E0
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Jan 2021 22:03:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76176221F5
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Jan 2021 22:03:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76176221F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 028DA89686;
	Tue, 12 Jan 2021 22:03:33 +0000 (UTC)
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com
 [IPv6:2607:f8b0:4864:20::236])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E601489686;
 Tue, 12 Jan 2021 22:03:31 +0000 (UTC)
Received: by mail-oi1-x236.google.com with SMTP id s2so4030004oij.2;
 Tue, 12 Jan 2021 14:03:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=/H028Wwjfvv9ucACM/DZ/rVBlomdfpbrk8WUZizz2Vs=;
 b=aHzNGV51B70g68q+osW4guQZlA2SPBmfpEfOkq7fZkXQoakwzlr6xu6YhmCMjJnjkM
 VtqaetZFw7ntjVk3o8watdpn0CN9ObBziXNCLskyRTcv3ylwFfov+alT8XTKxCsbdm7k
 30NfnkHx0zYv8zD2AIpj0jLPRkt4W9Wor2BAIbgaPWwRMWHsh4xit369viFPJ9GYuRcM
 0cd5LBcwNAYsQt5AFcp4xqa87LhvbXLukxjkG3nXDUAGYQicqCUo/J9aZy4KsUrH5g8x
 WlGyqSIaUV9liOnpvvUzHrW3WtEDSor/Re56fdaUbgg0fRWxgsHhqBfaW0j5NB9ivZ19
 6uqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=/H028Wwjfvv9ucACM/DZ/rVBlomdfpbrk8WUZizz2Vs=;
 b=ku3A4xOYyJeMEncPwmZUMZKkyNIbk5vqu1cHPwCLgFI0sv5FGEFXNS3MFS9P3+jYwr
 c0hXfoHDZkAwXh3Qr5ZIN5E4bexOlIyKxn8mPGZElGoGCbkxYbP8JuhNPGDK1xv17a4h
 tDp8wNBgCBSGXN7unU33mC/og13Mt3aESGP72ILJ0bccE7xJZRDffkFEu9S2bU4WNge6
 Ugq/ojfctMfKyk7lsss5o/F6NMh6EDeIYTfyb7gPpwra5jXJ1TLFxxkt9avcA+JfMGct
 y9fMbQbY4vvm2nTWNXZXEtNMc4Z1s7DWqUJU4buWYlomeDlIM/KHiW/fwGm1rENsKouf
 rB4g==
X-Gm-Message-State: AOAM533ifDN/Zu31w7gca/ngYCfULDVCuvkqUNBQAIqG8o1tjIln/LpH
 uT98IkRBQIAycbqUKlKplxr5DJbRrmQz4NbUW/PqSqeB
X-Google-Smtp-Source: ABdhPJwKnqQekjYfdmWGfwn2owS4YfLiNSbIsA3whxDogbBuG2uZywR7fQBh87ZLY3GC3QoavsICftjeeyBcrFoVQo0=
X-Received: by 2002:aca:4f97:: with SMTP id d145mr760461oib.123.1610489011339; 
 Tue, 12 Jan 2021 14:03:31 -0800 (PST)
MIME-Version: 1.0
References: <20210111191926.3688443-1-lee.jones@linaro.org>
 <20210111191926.3688443-9-lee.jones@linaro.org>
In-Reply-To: <20210111191926.3688443-9-lee.jones@linaro.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 12 Jan 2021 17:03:20 -0500
Message-ID: <CADnq5_PD_eocbg8-bfdrrF_GDOSeakZfj6dc4JGU+D9puo_beQ@mail.gmail.com>
Subject: Re: [PATCH 08/40] drm/amd/display/dc/gpio/diagnostics/hw_factory_diag:
 Fix struct declared inside parameter list error
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

T24gTW9uLCBKYW4gMTEsIDIwMjEgYXQgMjoxOSBQTSBMZWUgSm9uZXMgPGxlZS5qb25lc0BsaW5h
cm8ub3JnPiB3cm90ZToKPgo+IEZpeGVzIHRoZSBmb2xsb3dpbmcgVz0xIGtlcm5lbCBidWlsZCB3
YXJuaW5nKHMpOgo+Cj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1Ly4uL2Rpc3BsYXkvZGMv
Z3Bpby9kaWFnbm9zdGljcy9od19mYWN0b3J5X2RpYWcuaDozMDo0Mzogd2FybmluZzog4oCYc3Ry
dWN0IGh3X2ZhY3RvcnnigJkgZGVjbGFyZWQgaW5zaWRlIHBhcmFtZXRlciBsaXN0IHdpbGwgbm90
IGJlIHZpc2libGUgb3V0c2lkZSBvZiB0aGlzIGRlZmluaXRpb24gb3IgZGVjbGFyYXRpb24KPiAg
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvLi4vZGlzcGxheS9kYy9ncGlvL2RpYWdub3N0aWNz
L2h3X2ZhY3RvcnlfZGlhZy5oOjMwOjY6IG5vdGU6IHByZXZpb3VzIGRlY2xhcmF0aW9uIG9mIOKA
mGRhbF9od19mYWN0b3J5X2RpYWdfZnBnYV9pbml04oCZIHdhcyBoZXJlCj4gIGRyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1Ly4uL2Rpc3BsYXkvZGMvZ3Bpby9kaWFnbm9zdGljcy9od19mYWN0b3J5
X2RpYWcuaDozMDo0Mzogd2FybmluZzog4oCYc3RydWN0IGh3X2ZhY3RvcnnigJkgZGVjbGFyZWQg
aW5zaWRlIHBhcmFtZXRlciBsaXN0IHdpbGwgbm90IGJlIHZpc2libGUgb3V0c2lkZSBvZiB0aGlz
IGRlZmluaXRpb24gb3IgZGVjbGFyYXRpb24KPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
Li4vZGlzcGxheS9kYy9ncGlvL2RpYWdub3N0aWNzL2h3X2ZhY3RvcnlfZGlhZy5oOjMwOjY6IG5v
dGU6IHByZXZpb3VzIGRlY2xhcmF0aW9uIG9mIOKAmGRhbF9od19mYWN0b3J5X2RpYWdfZnBnYV9p
bml04oCZIHdhcyBoZXJlCj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1Ly4uL2Rpc3BsYXkv
ZGMvZ3Bpby9kaWFnbm9zdGljcy9od19mYWN0b3J5X2RpYWcuaDozMDo0Mzogd2FybmluZzog4oCY
c3RydWN0IGh3X2ZhY3RvcnnigJkgZGVjbGFyZWQgaW5zaWRlIHBhcmFtZXRlciBsaXN0IHdpbGwg
bm90IGJlIHZpc2libGUgb3V0c2lkZSBvZiB0aGlzIGRlZmluaXRpb24gb3IgZGVjbGFyYXRpb24K
PiAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvLi4vZGlzcGxheS9kYy9ncGlvL2RpYWdub3N0
aWNzL2h3X2ZhY3RvcnlfZGlhZy5oOjMwOjY6IG5vdGU6IHByZXZpb3VzIGRlY2xhcmF0aW9uIG9m
IOKAmGRhbF9od19mYWN0b3J5X2RpYWdfZnBnYV9pbml04oCZIHdhcyBoZXJlCj4KPiBDYzogSGFy
cnkgV2VudGxhbmQgPGhhcnJ5LndlbnRsYW5kQGFtZC5jb20+Cj4gQ2M6IExlbyBMaSA8c3VucGVu
Zy5saUBhbWQuY29tPgo+IENjOiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5j
b20+Cj4gQ2M6ICJDaHJpc3RpYW4gS8O2bmlnIiA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgo+
IENjOiBEYXZpZCBBaXJsaWUgPGFpcmxpZWRAbGludXguaWU+Cj4gQ2M6IERhbmllbCBWZXR0ZXIg
PGRhbmllbEBmZndsbC5jaD4KPiBDYzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPiBD
YzogZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+IFNpZ25lZC1vZmYtYnk6IExlZSBK
b25lcyA8bGVlLmpvbmVzQGxpbmFyby5vcmc+CgpBcHBsaWVkLiAgVGhhbmtzIQoKQWxleAoKPiAt
LS0KPiAgLi4uL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZ3Bpby9kaWFnbm9zdGljcy9od19mYWN0
b3J5X2RpYWcuaCAgIHwgMiArKwo+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspCj4K
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2dwaW8vZGlhZ25v
c3RpY3MvaHdfZmFjdG9yeV9kaWFnLmggYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMv
Z3Bpby9kaWFnbm9zdGljcy9od19mYWN0b3J5X2RpYWcuaAo+IGluZGV4IDhhNzRmNmFkYjhlZWUu
LmJmNjhlYjFkOWExZDIgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5
L2RjL2dwaW8vZGlhZ25vc3RpY3MvaHdfZmFjdG9yeV9kaWFnLmgKPiArKysgYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL2Rpc3BsYXkvZGMvZ3Bpby9kaWFnbm9zdGljcy9od19mYWN0b3J5X2RpYWcuaAo+
IEBAIC0yNiw2ICsyNiw4IEBACj4gICNpZm5kZWYgX19EQUxfSFdfRkFDVE9SWV9ESUFHX0ZQR0Ff
SF9fCj4gICNkZWZpbmUgX19EQUxfSFdfRkFDVE9SWV9ESUFHX0ZQR0FfSF9fCj4KPiArc3RydWN0
IGh3X2ZhY3Rvcnk7Cj4gKwo+ICAvKiBJbml0aWFsaXplIEhXIGZhY3RvcnkgZnVuY3Rpb24gcG9p
bnRlcnMgYW5kIHBpbiBpbmZvICovCj4gIHZvaWQgZGFsX2h3X2ZhY3RvcnlfZGlhZ19mcGdhX2lu
aXQoc3RydWN0IGh3X2ZhY3RvcnkgKmZhY3RvcnkpOwo+Cj4gLS0KPiAyLjI1LjEKPgo+IF9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4gZHJpLWRldmVsIG1h
aWxpbmcgbGlzdAo+IGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPiBodHRwczovL2xp
c3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2RyaS1kZXZlbApfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlz
dAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9w
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
