Return-Path: <SRS0=p2a1=3E=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33759C32771
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jan 2020 16:34:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05EEF206D7
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jan 2020 16:34:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="llVjC4VV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05EEF206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B956F6EA42;
	Wed, 15 Jan 2020 16:34:13 +0000 (UTC)
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com
 [IPv6:2a00:1450:4864:20::344])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 37C7D6EA42
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jan 2020 16:34:13 +0000 (UTC)
Received: by mail-wm1-x344.google.com with SMTP id p17so612387wma.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jan 2020 08:34:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=C+d4b+BeBtSwCjAOEl4jTqXfttER6zcdKx8goBsv0+k=;
 b=llVjC4VVJOV82mQ7IEfZFf8CWtdU/33ks2PA29p90fKcyPZkfE+mVoQLggBmBnSYRv
 XSLE88CEtNTQiGVtM7GnEuN35pGyjBdurCKDfugaTppjnw+aaKLvxhqSeibzTdBWpBAA
 hNhqgHywE0u0gc9g3UvCGXNz3p1zwtLMjhJY8TOhz8IIL5Xyv1MbcbmSQsKJq0pPDSn9
 K5ArdouA9QqszK5fXl/nfB6+apFYY2hBGQ9lgrWlA1J0BiPXeLe7bFwpSH3mBYa0BaBv
 UzV+YAgE6HT8nwEULehcbGG20SCCheRK+cX7qUh4GlAjGmC4bP9DuABtCPkFCjq4wzCf
 wltA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=C+d4b+BeBtSwCjAOEl4jTqXfttER6zcdKx8goBsv0+k=;
 b=BJo5cNfDgqIKh76wbxuYLP9e7qbiKsGT90tLLP3oUdG7qk6z0+x5QjHtroKOzcJd3k
 MF9Bi0UxBFndyoqxNUIaMlSgNfF/h1C+tqk3Yn+xlM2tRyZhew9/os88D7ouiSuwmCMO
 wI00UnbyH+4vOXzNaPz08PKjfjX5TDTvuGNb6+RJr0mhYSENqADggggtPJptyWuHNn6h
 EtYLbz5VE5mXhbuMBh3KybbSTHEiIw/nLe8gsym01qsIZBQJ7TYVfieZNJnxW92OEHg4
 udHrX277f0lwytOhjz2bOxzUojQJ/PWbKmnbpWKUtkrnyd6c2vt6s5aBlFW4/9bb6tah
 4V8w==
X-Gm-Message-State: APjAAAXVxLFEixWxnjup/Oli851FU09gVF3w3eWj8ORvbZNiuHducdx4
 GkBiHF3A4W08kTkTMSXpNTeg/3SdQF5h967xKbcscQ==
X-Google-Smtp-Source: APXvYqyAI/S9k/ynxN/BHpgTcZfv+uvM5e8JEQm9TE8AzrS5ppxAPs5rbMf13aCWK3vug+omYd7guN2ZROPzB+oO4+g=
X-Received: by 2002:a05:600c:2406:: with SMTP id 6mr787451wmp.30.1579106051887; 
 Wed, 15 Jan 2020 08:34:11 -0800 (PST)
MIME-Version: 1.0
References: <1579072065-10883-1-git-send-email-ray.huang@amd.com>
 <0045cca4-5197-285c-3808-6c5c5b6eb3e4@amd.com>
 <20200115074856.GA20818@jenkins-Celadon-RN>
 <5388eafe-77ca-45bf-40d7-7947e28c6249@amd.com>
In-Reply-To: <5388eafe-77ca-45bf-40d7-7947e28c6249@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 15 Jan 2020 11:33:59 -0500
Message-ID: <CADnq5_Nn5YqCHQvvub44ho+oTpDpc9FTy2J4jhuWv=ohGeJROw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: fill the alignment for secure buffer
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
Cc: "Pelloux-prayer, Pierre-eric" <Pierre-eric.Pelloux-prayer@amd.com>, "Liu,
 Aaron" <Aaron.Liu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 Huang Rui <ray.huang@amd.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Wentland,
 Harry" <Harry.Wentland@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gV2VkLCBKYW4gMTUsIDIwMjAgYXQgNTozNCBBTSBDaHJpc3RpYW4gS8O2bmlnCjxjaHJpc3Rp
YW4ua29lbmlnQGFtZC5jb20+IHdyb3RlOgo+Cj4gQW0gMTUuMDEuMjAgdW0gMDg6NDggc2Nocmll
YiBIdWFuZyBSdWk6Cj4gPiBPbiBXZWQsIEphbiAxNSwgMjAyMCBhdCAwMzo0NTo1MFBNICswODAw
LCBLb2VuaWcsIENocmlzdGlhbiB3cm90ZToKPiA+PiBBbSAxNS4wMS4yMCB1bSAwODowNyBzY2hy
aWViIEh1YW5nIFJ1aToKPiA+Pj4gVGhlIGFsaWdubWVudCBzaG91bGQgbWF0Y2ggdGhlIHBhZ2Ug
c2l6ZSBmb3Igc2VjdXJlIGJ1ZmZlci4KPiA+PiBUaGF0IGlzIHN1cGVyZmx1b3VzLCBidWZmZXIg
YXJlIGFsaWduZWQgdG8gYSBwYWdlIHNpemUgYW55d2F5Lgo+ID4+Cj4gPiBJZiB1c2UgaHVnZSBw
YWdlLCB3aWxsIGJ1ZmZlciBzdGlsbCBiZSBhbGlnbmVkPwo+Cj4gWWVzLCB0aGUgbWluaW11bSBh
bGlnbm1lbnQgaXMgYWx3YXlzIG9uZSBwYWdlLgoKV2UgY2FuIGRyb3AgdGhlIGVtcHR5IGNvZGUg
YmxvY2sgYW5kIFhYWCBjb21tZW50IGhvd2V2ZXIuCgpBbGV4Cgo+Cj4gQ2hyaXN0aWFuLgo+Cj4g
Pgo+ID4gVGhhbmtzLAo+ID4gUmF5Cj4gPgo+ID4+IENocmlzdGlhbi4KPiA+Pgo+ID4+PiBTaWdu
ZWQtb2ZmLWJ5OiBIdWFuZyBSdWkgPHJheS5odWFuZ0BhbWQuY29tPgo+ID4+PiAtLS0KPiA+Pj4g
ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dlbS5jIHwgNyArKysrLS0tCj4g
Pj4+ICAgIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pCj4g
Pj4+Cj4gPj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
Z2VtLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZ2VtLmMKPiA+Pj4gaW5k
ZXggZjM5MDEyZS4uYTAzZWVhZCAxMDA2NDQKPiA+Pj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X2dlbS5jCj4gPj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV9nZW0uYwo+ID4+PiBAQCAtMjYxLDkgKzI2MSwxMCBAQCBpbnQgYW1kZ3B1X2dl
bV9jcmVhdGVfaW9jdGwoc3RydWN0IGRybV9kZXZpY2UgKmRldiwgdm9pZCAqZGF0YSwKPiA+Pj4g
ICAgICAgICAgICAgcmVzdiA9IHZtLT5yb290LmJhc2UuYm8tPnRiby5iYXNlLnJlc3Y7Cj4gPj4+
ICAgICB9Cj4gPj4+Cj4gPj4+IC0gICBpZiAoZmxhZ3MgJiBBTURHUFVfR0VNX0NSRUFURV9FTkNS
WVBURUQpIHsKPiA+Pj4gLSAgICAgICAgICAgLyogWFhYOiBwYWQgb3V0IGFsaWdubWVudCB0byBt
ZWV0IFRNWiByZXF1aXJlbWVudHMgKi8KPiA+Pj4gLSAgIH0KPiA+Pj4gKyAgIC8qIFRNWiByZXF1
aXJlcyB0aGUgc2VjdXJlIGJ1ZmZlciB0byBhbGlnbiB3aXRoIHBhZ2Ugc2l6ZSBhdCBsZWFzdCAq
Lwo+ID4+PiArICAgaWYgKGZsYWdzICYgQU1ER1BVX0dFTV9DUkVBVEVfRU5DUllQVEVEKQo+ID4+
PiArICAgICAgICAgICBhcmdzLT5pbi5hbGlnbm1lbnQgPSByb3VuZHVwKGFyZ3MtPmluLmFsaWdu
bWVudCwKPiA+Pj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBBTURH
UFVfR1BVX1BBR0VfU0laRSk7Cj4gPj4+Cj4gPj4+ICAgICByID0gYW1kZ3B1X2dlbV9vYmplY3Rf
Y3JlYXRlKGFkZXYsIHNpemUsIGFyZ3MtPmluLmFsaWdubWVudCwKPiA+Pj4gICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgKHUzMikoMHhmZmZmZmZmZiAmIGFyZ3MtPmluLmRvbWFpbnMp
LAo+Cj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KPiBh
bWQtZ2Z4IG1haWxpbmcgbGlzdAo+IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4gaHR0
cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGlu
ZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRl
c2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
