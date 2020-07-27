Return-Path: <SRS0=eP35=BG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D6F2C433E0
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Jul 2020 18:12:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01D4020714
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Jul 2020 18:12:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rvXZRTq8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01D4020714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8BA4789E8C;
	Mon, 27 Jul 2020 18:12:12 +0000 (UTC)
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com
 [IPv6:2a00:1450:4864:20::443])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6956889E8C;
 Mon, 27 Jul 2020 18:12:11 +0000 (UTC)
Received: by mail-wr1-x443.google.com with SMTP id a15so15803160wrh.10;
 Mon, 27 Jul 2020 11:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=n+cjMJexAD4hVslCLfZxYw0xSj4v32Cg73ix8mAo6lQ=;
 b=rvXZRTq8JQeLezn3Y8PtrvIvpSkDiBHveZhfRmIRsSBeDJZnjKqBGy+QWwELGHHK9h
 IcMm8HWjNIwnu3YVdbwj7AmtnCfpAhFZ+Rpc4w8N91b/7XRDjPtMUQxHAY+v6x5JU1nS
 3XcXWMQ8Z6v41HCiM/COJFtN8CNp79O9B+gMY9IdeHjA7WwIXl3acZ7NJYKKF2pW6le1
 9956/PiAmuH96Npac+3FjCpIR1YH8sTu6ZSf+wTE+16ZZ4Wm2B1q9cjwtZTrnH27vFLU
 Os2LTJRtUv0ccsrNI3bsAmwtod5CkcmTpMeDKKx+aTuxVAdxyuvYtKYrRed634svN5W2
 SgpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=n+cjMJexAD4hVslCLfZxYw0xSj4v32Cg73ix8mAo6lQ=;
 b=gyjzUvE+H9QeMGnVOt8VSGVRaE3OE3qO+2IBMbEkZt9xt4B3QtBhsl9iEs268fO/i7
 zgjtp2+ZMG3j6iO4FNuceFzdNpuFBtvpSvcKAGFUlvWuDfr5cxjSvy4XlE4wGOaNaatk
 HEVX6dkwDgXkxmzr6ASCu2IJsu7ZkLqhGebU2bdsjCuLlDR+2fUmJ/dCODFbq2yFJ9nG
 F9NP0fhiwQKYuwswHiEGaj5ra84hSJaMQgOMqvHZLO7QJLlW9lujvpS4kiYwOftTQOL0
 GImSJsO/sjO8d0OmEE9G/KYbJRDl7YV7f9o88znCIULHCpt8p4DxT95SXejoemnaP7BT
 C4fw==
X-Gm-Message-State: AOAM533ebV9KoMqp7uy0TkKqddXqk+Y3/kbTORMdipi/qdz61ZkJqRm7
 EDB5LV51LiUJWbtF03ArrOCahueztm4WQ0l9WHY=
X-Google-Smtp-Source: ABdhPJwFtDW1X9++0RKW78h+dwtCDaX++VHQCmLYontPEXnwlgS2w9CTdMWsfkGtAl4r3B+vtG4bXra770bQd6VRpaY=
X-Received: by 2002:adf:a351:: with SMTP id d17mr21027063wrb.111.1595873530004; 
 Mon, 27 Jul 2020 11:12:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200727103436.50793-1-christophe.jaillet@wanadoo.fr>
 <898acaf6-9975-40b1-1104-586b64689ccd@gmail.com>
In-Reply-To: <898acaf6-9975-40b1-1104-586b64689ccd@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 27 Jul 2020 14:11:58 -0400
Message-ID: <CADnq5_OqdUxSKv21pg9o=a_dwyW7-j3URy+BYHrS+ubzuA-7NQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/radeon: avoid a useless memset
To: Christian Koenig <christian.koenig@amd.com>
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
Cc: Dave Airlie <airlied@linux.ie>, kernel-janitors@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 Daniel Vetter <daniel@ffwll.ch>, "Deucher,
 Alexander" <alexander.deucher@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QXBwbGllZC4gIFRoYW5rcyEKCkFsZXgKCk9uIE1vbiwgSnVsIDI3LCAyMDIwIGF0IDk6NDEgQU0g
Q2hyaXN0aWFuIEvDtm5pZwo8Y2tvZW5pZy5sZWljaHR6dW1lcmtlbkBnbWFpbC5jb20+IHdyb3Rl
Ogo+Cj4gQW0gMjcuMDcuMjAgdW0gMTI6MzQgc2NocmllYiBDaHJpc3RvcGhlIEpBSUxMRVQ6Cj4g
PiBBdm9pZCBhIG1lbXNldCBhZnRlciBhIGNhbGwgdG8gJ2RtYV9hbGxvY19jb2hlcmVudCgpJy4K
PiA+IFRoaXMgaXMgdXNlbGVzcyBzaW5jZQo+ID4gY29tbWl0IDUxOGEyZjE5MjVjMyAoImRtYS1t
YXBwaW5nOiB6ZXJvIG1lbW9yeSByZXR1cm5lZCBmcm9tIGRtYV9hbGxvY18qIikKPiA+Cj4gPiBT
aWduZWQtb2ZmLWJ5OiBDaHJpc3RvcGhlIEpBSUxMRVQgPGNocmlzdG9waGUuamFpbGxldEB3YW5h
ZG9vLmZyPgo+Cj4gUmV2aWV3ZWQtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2Vu
aWdAYW1kLmNvbT4KPgo+ID4gLS0tCj4gPiAgIGRyaXZlcnMvZ3B1L2RybS9yYWRlb24vcmFkZW9u
X2dhcnQuYyB8IDEgLQo+ID4gICAxIGZpbGUgY2hhbmdlZCwgMSBkZWxldGlvbigtKQo+ID4KPiA+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVvbl9nYXJ0LmMgYi9kcml2
ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVvbl9nYXJ0LmMKPiA+IGluZGV4IGI3Y2UyNTRlNTY2My4u
MzgwOGE3NTMxMjdiIDEwMDY0NAo+ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRl
b25fZ2FydC5jCj4gPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVvbl9nYXJ0LmMK
PiA+IEBAIC04NSw3ICs4NSw2IEBAIGludCByYWRlb25fZ2FydF90YWJsZV9yYW1fYWxsb2Moc3Ry
dWN0IHJhZGVvbl9kZXZpY2UgKnJkZXYpCj4gPiAgICAgICB9Cj4gPiAgICNlbmRpZgo+ID4gICAg
ICAgcmRldi0+Z2FydC5wdHIgPSBwdHI7Cj4gPiAtICAgICBtZW1zZXQoKHZvaWQgKilyZGV2LT5n
YXJ0LnB0ciwgMCwgcmRldi0+Z2FydC50YWJsZV9zaXplKTsKPiA+ICAgICAgIHJldHVybiAwOwo+
ID4gICB9Cj4gPgo+Cj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KPiBhbWQtZ2Z4IG1haWxpbmcgbGlzdAo+IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Au
b3JnCj4gaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQt
Z2Z4Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1n
ZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
