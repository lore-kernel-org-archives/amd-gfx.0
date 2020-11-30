Return-Path: <SRS0=Nkia=FE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E186C63777
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Nov 2020 23:16:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C30E8206E0
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Nov 2020 23:16:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pmy0R54X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C30E8206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 576F4897B5;
	Mon, 30 Nov 2020 23:16:18 +0000 (UTC)
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com
 [IPv6:2607:f8b0:4864:20::344])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 71672897B5;
 Mon, 30 Nov 2020 23:16:17 +0000 (UTC)
Received: by mail-ot1-x344.google.com with SMTP id k3so13023591otp.12;
 Mon, 30 Nov 2020 15:16:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=WoziKHC+v4Z3OAENXM/ouuGFrIDPeNU+vHY9PKFX1EM=;
 b=Pmy0R54X8eY3knO6XtefsNf8EC9w4xiJxLjtgN5Tp6Vhq/RY8OyUihEHnHGfSTxzqX
 JPqwtrF2ZdRDapeZMAiWyQ2Dysy9uI1WoxNHoGszY5iXvKvUOx9GQOWAjMUpo6IITdBN
 ynHDBk2ntelaAUmkczLDpSO1I/niJf8Ceg1taGPQ/xhpMZisbzpqjHKkZ2zHilkTH9iR
 9dtmLZfbWbJvFDVkHnBwmxkvr/xzSLiyMrzAPUpvqBv47gNYJyyhy2eJYrLkwhO8mEjA
 lLQeoC5TWcxbRPXziaOI8q63Omvxx0xhgDyJHnYjThuDwMFby1GNLfD+ZCElOvyeUXKT
 qskw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=WoziKHC+v4Z3OAENXM/ouuGFrIDPeNU+vHY9PKFX1EM=;
 b=d+Ds2Sj93HtImiUDH6nsaSasw99muzd/W2kXdP8ajO1CKblfyYCtyqbCJlKIog1D2b
 cuIbiQG1uhVbIqS7bR6Ab7w87Jxh8v03cEIgzE+vmAW1nYm24BZBHFoyiqWB4s8oUrRk
 IMXTS95YARsFN2YV9ukEVuYEF0mft+gRSGNP2bROYFcR2D0wKGE1RAuRs6kNRh1ZJ5oO
 v8C3VMamfXAu+Pcp5eYIh0zzlQRcNUXzqQcTkwN9ue7pUK27N5WP60zkC0n4kAMX64XJ
 CTqEiZc9ADzTeie2CmYWvXWY5DauOXdbnvZHLaQrJeoAKk8rGjkjyV1AIfIf2G9t9T7A
 rubQ==
X-Gm-Message-State: AOAM533Nd59TrQcscZEEjP09AQZZvpfTi1R5728HhhFKomjYB3gOc9v7
 ik2bFGS/fVD/5ucfvQ6+Xsrj5fKhmTc+dZKNC84=
X-Google-Smtp-Source: ABdhPJzppF+6OtMTgVzZ9oC0mWh6FYFcWr0qeCVxeAKLpnIGdZmnV2XdLi5F60mTJbI9WFpvP4nD9Tj8gx2MTKQXwEA=
X-Received: by 2002:a9d:4713:: with SMTP id a19mr19346501otf.132.1606778176787; 
 Mon, 30 Nov 2020 15:16:16 -0800 (PST)
MIME-Version: 1.0
References: <20201126134240.3214176-1-lee.jones@linaro.org>
 <20201126134240.3214176-5-lee.jones@linaro.org>
In-Reply-To: <20201126134240.3214176-5-lee.jones@linaro.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 30 Nov 2020 18:16:05 -0500
Message-ID: <CADnq5_P3Rc+UVH1wwgb0xNN4YkhqzBucZK=EMYOdfPt3FccFZA@mail.gmail.com>
Subject: Re: [PATCH 04/40] drm/amd/pm/powerplay/smumgr/iceland_smumgr: Make
 function called by reference static
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
 Huang Rui <ray.huang@amd.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Alex Deucher <alexander.deucher@amd.com>, Evan Quan <evan.quan@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gVGh1LCBOb3YgMjYsIDIwMjAgYXQgODo0MyBBTSBMZWUgSm9uZXMgPGxlZS5qb25lc0BsaW5h
cm8ub3JnPiB3cm90ZToKPgo+IEZpeGVzIHRoZSBmb2xsb3dpbmcgVz0xIGtlcm5lbCBidWlsZCB3
YXJuaW5nKHMpOgo+Cj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1Ly4uL3BtL3Bvd2VycGxh
eS9zbXVtZ3IvaWNlbGFuZF9zbXVtZ3IuYzoyMDg1OjU6IHdhcm5pbmc6IG5vIHByZXZpb3VzIHBy
b3RvdHlwZSBmb3Ig4oCYaWNlbGFuZF90aGVybWFsX3NldHVwX2Zhbl90YWJsZeKAmSBbLVdtaXNz
aW5nLXByb3RvdHlwZXNdCj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1Ly4uL3BtL3Bvd2Vy
cGxheS9zbXVtZ3IvaWNlbGFuZF9zbXVtZ3IuYzogSW4gZnVuY3Rpb24g4oCYaWNlbGFuZF90aGVy
bWFsX3NldHVwX2Zhbl90YWJsZeKAmToKPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvLi4v
cG0vcG93ZXJwbGF5L3NtdW1nci9pY2VsYW5kX3NtdW1nci5jOjIwOTM6Njogd2FybmluZzogdmFy
aWFibGUg4oCYcmVz4oCZIHNldCBidXQgbm90IHVzZWQgWy1XdW51c2VkLWJ1dC1zZXQtdmFyaWFi
bGVdCj4KPiBDYzogRXZhbiBRdWFuIDxldmFuLnF1YW5AYW1kLmNvbT4KPiBDYzogQWxleCBEZXVj
aGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgo+IENjOiAiQ2hyaXN0aWFuIEvDtm5pZyIg
PGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KPiBDYzogRGF2aWQgQWlybGllIDxhaXJsaWVkQGxp
bnV4LmllPgo+IENjOiBEYW5pZWwgVmV0dGVyIDxkYW5pZWxAZmZ3bGwuY2g+Cj4gQ2M6IEh1YW5n
IFJ1aSA8cmF5Lmh1YW5nQGFtZC5jb20+Cj4gQ2M6IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Au
b3JnCj4gQ2M6IGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPiBTaWduZWQtb2ZmLWJ5
OiBMZWUgSm9uZXMgPGxlZS5qb25lc0BsaW5hcm8ub3JnPgoKQXBwbGllZC4gIFRoYW5rcyEKCkFs
ZXgKCj4gLS0tCj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvcG0vcG93ZXJwbGF5L3NtdW1nci9pY2Vs
YW5kX3NtdW1nci5jIHwgMiArLQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEg
ZGVsZXRpb24oLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3Bvd2Vy
cGxheS9zbXVtZ3IvaWNlbGFuZF9zbXVtZ3IuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vcG93
ZXJwbGF5L3NtdW1nci9pY2VsYW5kX3NtdW1nci5jCj4gaW5kZXggNDMxYWQyZmQzOGRmMS4uNmEw
ZjU4MWRlOTk5YiAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3Bvd2VycGxh
eS9zbXVtZ3IvaWNlbGFuZF9zbXVtZ3IuYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0v
cG93ZXJwbGF5L3NtdW1nci9pY2VsYW5kX3NtdW1nci5jCj4gQEAgLTIwODIsNyArMjA4Miw3IEBA
IHN0YXRpYyBpbnQgaWNlbGFuZF9pbml0X3NtY190YWJsZShzdHJ1Y3QgcHBfaHdtZ3IgKmh3bWdy
KQo+ICAgICAgICAgcmV0dXJuIDA7Cj4gIH0KPgo+IC1pbnQgaWNlbGFuZF90aGVybWFsX3NldHVw
X2Zhbl90YWJsZShzdHJ1Y3QgcHBfaHdtZ3IgKmh3bWdyKQo+ICtzdGF0aWMgaW50IGljZWxhbmRf
dGhlcm1hbF9zZXR1cF9mYW5fdGFibGUoc3RydWN0IHBwX2h3bWdyICpod21ncikKPiAgewo+ICAg
ICAgICAgc3RydWN0IHNtdTdfc211bWdyICpzbXU3X2RhdGEgPSAoc3RydWN0IHNtdTdfc211bWdy
ICopKGh3bWdyLT5zbXVfYmFja2VuZCk7Cj4gICAgICAgICBTTVU3MV9EaXNjcmV0ZV9GYW5UYWJs
ZSBmYW5fdGFibGUgPSB7IEZET19NT0RFX0hBUkRXQVJFIH07Cj4gLS0KPiAyLjI1LjEKPgo+IF9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4gZHJpLWRldmVs
IG1haWxpbmcgbGlzdAo+IGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPiBodHRwczov
L2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2RyaS1kZXZlbApfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcg
bGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNr
dG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
