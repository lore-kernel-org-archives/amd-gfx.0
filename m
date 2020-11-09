Return-Path: <SRS0=C2iJ=EP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2A34C5517A
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Nov 2020 19:50:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B8FB2074F
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Nov 2020 19:50:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bybJ1v3l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B8FB2074F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 09F65892E0;
	Mon,  9 Nov 2020 19:50:50 +0000 (UTC)
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com
 [IPv6:2a00:1450:4864:20::443])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3FBE9892E0;
 Mon,  9 Nov 2020 19:50:48 +0000 (UTC)
Received: by mail-wr1-x443.google.com with SMTP id o15so2256069wru.6;
 Mon, 09 Nov 2020 11:50:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=7UsYe46mocZoiCW+LF/Ym4Xr19zPlHHTun9MNgIDCa8=;
 b=bybJ1v3lnBrzYGFpKlM8KIAAxeZO8q1Oj7X8NR+yivBgB3ixHhbgfh46GvZw5Y0dw7
 R8ihdHrEF3VsPyVSczQs4CAjGr4WkHKZ60Pv8DXtW66G6KXcT58C2irteDqxc1Aqh/wl
 Yol11CKM3Qe9MlcKppFvLjC7pfs38gbMYpfl+awnoULIWf33EGa7hXtfpRZFnDPWu7pj
 C5ncll0eVyXlN4yFDmpfth2nkGZgRUMJkpmUWxVXdyADslDIR/lPs7tx+/0qTbI4sGVu
 9kCyUxOI1uqm1Mot8d942RRhA8Kr54/1FWeghNbwxFPc3IivlhHE6lWhFgATSgYK9V2D
 UnsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=7UsYe46mocZoiCW+LF/Ym4Xr19zPlHHTun9MNgIDCa8=;
 b=jgMrqRialgrVgXkddZfhTB+3HoScBcsnN9x0iBeYdiW8oZoRGFiGQYuHiCQOvcFmOq
 QQBNZP19pvQQqouKr9aQzblzTLmOimRPuQxsP801Mk1IbjRdBFn8AVwo4675yuR+Cur8
 qrH1sh91+Zl6+qwQ+hAKUQD2sW8a5JTTymG38HTbLn5KBkH/p0qBou1qj5DJVoLhQ8oC
 TYYcQ5KA20obrBPLzrmFVmHkxqFlIoI6+lTHg5IVIl8JzKHZPbtyDU6+NtJEBppHVvq4
 n1uezh60G2JsPaTmVclxpeCom3e7WT+mz2Zq3YTXQNQzxeKXxrHrZmehb7a0PGiZUuZG
 FNwA==
X-Gm-Message-State: AOAM533vudunyQoSMgupfZK4a/QP9+Ypplb1lhk99mNqwETwkL99pfAt
 58kBjeeHEdQ5dVt73/Lb9EpawrbfGEUKIeRsFFNlFh+WykA=
X-Google-Smtp-Source: ABdhPJy4DoOooRT9xNcJhrIB9gh/ZyN3Y3XCDpxRFi0KiF8dwateu7LjMMrJAFMH6yt7UiqG83IN4HHaYGrXoQHc54I=
X-Received: by 2002:adf:e9c9:: with SMTP id l9mr21010982wrn.124.1604951446950; 
 Mon, 09 Nov 2020 11:50:46 -0800 (PST)
MIME-Version: 1.0
References: <20201106214949.2042120-1-lee.jones@linaro.org>
 <20201106214949.2042120-18-lee.jones@linaro.org>
In-Reply-To: <20201106214949.2042120-18-lee.jones@linaro.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 9 Nov 2020 14:50:35 -0500
Message-ID: <CADnq5_Nys7igVo3sgzK0D4hnm=RHMrEM7Xty80jGROu_sy5svA@mail.gmail.com>
Subject: Re: [PATCH 17/19] drm/radeon/radeon_kms: Fix misnaming of
 'radeon_info_ioctl's dev param
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
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gRnJpLCBOb3YgNiwgMjAyMCBhdCA0OjUwIFBNIExlZSBKb25lcyA8bGVlLmpvbmVzQGxpbmFy
by5vcmc+IHdyb3RlOgo+Cj4gRml4ZXMgdGhlIGZvbGxvd2luZyBXPTEga2VybmVsIGJ1aWxkIHdh
cm5pbmcocyk6Cj4KPiAgZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fa21zLmM6MjI2OiB3
YXJuaW5nOiBGdW5jdGlvbiBwYXJhbWV0ZXIgb3IgbWVtYmVyICdkZXYnIG5vdCBkZXNjcmliZWQg
aW4gJ3JhZGVvbl9pbmZvX2lvY3RsJwo+ICBkcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVvbl9r
bXMuYzoyMjY6IHdhcm5pbmc6IEV4Y2VzcyBmdW5jdGlvbiBwYXJhbWV0ZXIgJ3JkZXYnIGRlc2Ny
aXB0aW9uIGluICdyYWRlb25faW5mb19pb2N0bCcKPgo+IENjOiBBbGV4IERldWNoZXIgPGFsZXhh
bmRlci5kZXVjaGVyQGFtZC5jb20+Cj4gQ2M6ICJDaHJpc3RpYW4gS8O2bmlnIiA8Y2hyaXN0aWFu
LmtvZW5pZ0BhbWQuY29tPgo+IENjOiBEYXZpZCBBaXJsaWUgPGFpcmxpZWRAbGludXguaWU+Cj4g
Q2M6IERhbmllbCBWZXR0ZXIgPGRhbmllbEBmZndsbC5jaD4KPiBDYzogYW1kLWdmeEBsaXN0cy5m
cmVlZGVza3RvcC5vcmcKPiBDYzogZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+IFNp
Z25lZC1vZmYtYnk6IExlZSBKb25lcyA8bGVlLmpvbmVzQGxpbmFyby5vcmc+Cj4gLS0tCj4gIGRy
aXZlcnMvZ3B1L2RybS9yYWRlb24vcmFkZW9uX2ttcy5jIHwgMiArLQo+ICAxIGZpbGUgY2hhbmdl
ZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L2dwdS9kcm0vcmFkZW9uL3JhZGVvbl9rbXMuYyBiL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vcmFk
ZW9uX2ttcy5jCj4gaW5kZXggMGQ4ZmJhYmZmY2VhZC4uMjFjMjA2Nzk1YzM2NCAxMDA2NDQKPiAt
LS0gYS9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVvbl9rbXMuYwo+ICsrKyBiL2RyaXZlcnMv
Z3B1L2RybS9yYWRlb24vcmFkZW9uX2ttcy5jCj4gQEAgLTIxMyw3ICsyMTMsNyBAQCBzdGF0aWMg
dm9pZCByYWRlb25fc2V0X2ZpbHBfcmlnaHRzKHN0cnVjdCBkcm1fZGV2aWNlICpkZXYsCj4gIC8q
Kgo+ICAgKiByYWRlb25faW5mb19pb2N0bCAtIGFuc3dlciBhIGRldmljZSBzcGVjaWZpYyByZXF1
ZXN0Lgo+ICAgKgo+IC0gKiBAcmRldjogcmFkZW9uIGRldmljZSBwb2ludGVyCj4gKyAqIEBkZXY6
IHJhZGVvbiBkZXZpY2UgcG9pbnRlcgoKVGhpcyBzaG91bGQgYmU6CisgKiBAZGV2OiBkcm0gZGV2
aWNlIHBvaW50ZXIKCkFsZXgKCj4gICAqIEBkYXRhOiByZXF1ZXN0IG9iamVjdAo+ICAgKiBAZmls
cDogZHJtIGZpbHAKPiAgICoKPiAtLQo+IDIuMjUuMQo+Cj4gX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KPiBkcmktZGV2ZWwgbWFpbGluZyBsaXN0Cj4gZHJp
LWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+IGh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Au
b3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlz
dGluZm8vYW1kLWdmeAo=
