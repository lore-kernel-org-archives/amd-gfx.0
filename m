Return-Path: <SRS0=Nkia=FE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F0B0C63777
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Nov 2020 23:51:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2616207BB
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Nov 2020 23:51:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MhcYx68p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2616207BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2DC5989D53;
	Mon, 30 Nov 2020 23:51:48 +0000 (UTC)
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com
 [IPv6:2607:f8b0:4864:20::241])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE6CF8972D;
 Mon, 30 Nov 2020 23:51:46 +0000 (UTC)
Received: by mail-oi1-x241.google.com with SMTP id x16so429175oic.3;
 Mon, 30 Nov 2020 15:51:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=dqtZVKDF+iOHb6i9HnsWKEOoMGpzp8HRWPSLoRBVdcI=;
 b=MhcYx68pv85thC3M2kbt6MwMV2rnoK8Jym2ftuEvJnOcSk+CdTsi3LDJUQpvn3eUDZ
 vRXkTuOoUk/s8nIODWCZ/11lZF/zyl1qxHrA3rU9AkQBgsdSTWFkjV/pNG+NTCUyuuYm
 YCT4W+S4o91XwIptI0ezXBboSFTQWwaxlwy8RUfSegR3Hcu2v4Iu60aYejdJak8NpVcP
 85UMA8ZYw6Ercnn5M7kVMnnOr6Qm1bFlbvK2odoFZcRn3vXD/za9Gnybajb+RmDHAzOp
 wreHXc5cL8BnrENuHw8dPMRWAoE5U1qoxvhDrjjTsdxSLoDw6WTYof5f30t2IFGoax9n
 atWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=dqtZVKDF+iOHb6i9HnsWKEOoMGpzp8HRWPSLoRBVdcI=;
 b=ngmqPIgo4BeVvsinaVZtvKA+8MH2dGgMjzCC3kE9qxpdmtMbq2ddfgkSdW/qCpl1De
 qvVInNhPB7VFi9rjTffWnLVRSuuQahuAilo2u4DJuRPV69NnUqoN+6bwC14vA9lkqNDC
 7I2d1JubqePh8d1ulFHkP1b6invZpYOvifPkJIVQnt4XPqlvCYbKtePj7mLvJ50Yl9fo
 kdFzyte2+4VYTOcq18NZAiFr3Q0DSD12Q98tIH5/4hJ4kzfkPqDSy0y3VQfRo/t8GnjQ
 QY1hzuKryxd4c/NYnCvhNLoy/d/x9VYrZQ485CBIp7O+zZdbiIOcXJo/zf3wCxCEUvB9
 Msgw==
X-Gm-Message-State: AOAM532/qSc8uSCtLxfXXEhF1WPP65aCgVZKTDvyHhFpapVBseLkcuI+
 eR7Y+3zoJsVQVT5IngVI7CE8w1Gh/2PWuQlQusQ=
X-Google-Smtp-Source: ABdhPJxNbLaWtxU5KsFyyPyYENrktI33lsyQ8g6VQKzB5NZEqc8up8dmIs2gDA6INhVOZD+ex3RL6AdLHEUBsE77RBY=
X-Received: by 2002:a54:4608:: with SMTP id p8mr5127oip.5.1606780306154; Mon,
 30 Nov 2020 15:51:46 -0800 (PST)
MIME-Version: 1.0
References: <20201126134240.3214176-1-lee.jones@linaro.org>
 <20201126134240.3214176-28-lee.jones@linaro.org>
In-Reply-To: <20201126134240.3214176-28-lee.jones@linaro.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 30 Nov 2020 18:51:34 -0500
Message-ID: <CADnq5_PgX6b24aEntKQccUzD=CkQpf2pz09rwLebeYsnB3gd-Q@mail.gmail.com>
Subject: Re: [PATCH 27/40] drm/amd/pm/powerplay/hwmgr/hwmgr: Move
 'vega20_hwmgr_init()'s prototype to shared header
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
 Alex Deucher <alexander.deucher@amd.com>, Evan Quan <evan.quan@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gVGh1LCBOb3YgMjYsIDIwMjAgYXQgODo0MyBBTSBMZWUgSm9uZXMgPGxlZS5qb25lc0BsaW5h
cm8ub3JnPiB3cm90ZToKPgo+IEZpeGVzIHRoZSBmb2xsb3dpbmcgVz0xIGtlcm5lbCBidWlsZCB3
YXJuaW5nKHMpOgo+Cj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1Ly4uL3BtL3Bvd2VycGxh
eS9od21nci92ZWdhMjBfaHdtZ3IuYzo0NDAzOjU6IHdhcm5pbmc6IG5vIHByZXZpb3VzIHByb3Rv
dHlwZSBmb3Ig4oCYdmVnYTIwX2h3bWdyX2luaXTigJkgWy1XbWlzc2luZy1wcm90b3R5cGVzXQo+
ICA0NDAzIHwgaW50IHZlZ2EyMF9od21ncl9pbml0KHN0cnVjdCBwcF9od21nciAqaHdtZ3IpCj4g
IHwgXn5+fn5+fn5+fn5+fn5+fn4KPgo+IENjOiBFdmFuIFF1YW4gPGV2YW4ucXVhbkBhbWQuY29t
Pgo+IENjOiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+Cj4gQ2M6ICJD
aHJpc3RpYW4gS8O2bmlnIiA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgo+IENjOiBEYXZpZCBB
aXJsaWUgPGFpcmxpZWRAbGludXguaWU+Cj4gQ2M6IERhbmllbCBWZXR0ZXIgPGRhbmllbEBmZnds
bC5jaD4KPiBDYzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPiBDYzogZHJpLWRldmVs
QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+IFNpZ25lZC1vZmYtYnk6IExlZSBKb25lcyA8bGVlLmpv
bmVzQGxpbmFyby5vcmc+CgpBcHBsaWVkLiAgVGhhbmtzIQoKQWxleAoKPiAtLS0KPiAgZHJpdmVy
cy9ncHUvZHJtL2FtZC9wbS9pbmMvaHdtZ3IuaCAgICAgICAgICAgICB8IDEgKwo+ICBkcml2ZXJz
L2dwdS9kcm0vYW1kL3BtL3Bvd2VycGxheS9od21nci9od21nci5jIHwgMSAtCj4gIDIgZmlsZXMg
Y2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKPgo+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL2dwdS9kcm0vYW1kL3BtL2luYy9od21nci5oIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9w
bS9pbmMvaHdtZ3IuaAo+IGluZGV4IDQ5OWYyNTIwYjFhYTMuLjQ5MDM3MWJkMjUyMDEgMTAwNjQ0
Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9pbmMvaHdtZ3IuaAo+ICsrKyBiL2RyaXZl
cnMvZ3B1L2RybS9hbWQvcG0vaW5jL2h3bWdyLmgKPiBAQCAtODMxLDUgKzgzMSw2IEBAIGludCBo
d21ncl9oYW5kbGVfdGFzayhzdHJ1Y3QgcHBfaHdtZ3IgKmh3bWdyLAo+ICBpbnQgc211N19pbml0
X2Z1bmN0aW9uX3BvaW50ZXJzKHN0cnVjdCBwcF9od21nciAqaHdtZ3IpOwo+ICBpbnQgc211OF9p
bml0X2Z1bmN0aW9uX3BvaW50ZXJzKHN0cnVjdCBwcF9od21nciAqaHdtZ3IpOwo+ICBpbnQgdmVn
YTEyX2h3bWdyX2luaXQoc3RydWN0IHBwX2h3bWdyICpod21ncik7Cj4gK2ludCB2ZWdhMjBfaHdt
Z3JfaW5pdChzdHJ1Y3QgcHBfaHdtZ3IgKmh3bWdyKTsKPgo+ICAjZW5kaWYgLyogX0hXTUdSX0hf
ICovCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vcG93ZXJwbGF5L2h3bWdy
L2h3bWdyLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3Bvd2VycGxheS9od21nci9od21nci5j
Cj4gaW5kZXggNDlmOGEzMzFlYjAyZS4uNmE3ZGU4Yjg5OGZhZiAxMDA2NDQKPiAtLS0gYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL3BtL3Bvd2VycGxheS9od21nci9od21nci5jCj4gKysrIGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9wbS9wb3dlcnBsYXkvaHdtZ3IvaHdtZ3IuYwo+IEBAIC00Nyw3ICs0Nyw2
IEBAIGV4dGVybiBjb25zdCBzdHJ1Y3QgcHBfc211bWdyX2Z1bmMgc211MTBfc211X2Z1bmNzOwo+
ICBleHRlcm4gY29uc3Qgc3RydWN0IHBwX3NtdW1ncl9mdW5jIHZlZ2EyMF9zbXVfZnVuY3M7Cj4K
PiAgZXh0ZXJuIGludCB2ZWdhMTBfaHdtZ3JfaW5pdChzdHJ1Y3QgcHBfaHdtZ3IgKmh3bWdyKTsK
PiAtZXh0ZXJuIGludCB2ZWdhMjBfaHdtZ3JfaW5pdChzdHJ1Y3QgcHBfaHdtZ3IgKmh3bWdyKTsK
PiAgZXh0ZXJuIGludCBzbXUxMF9pbml0X2Z1bmN0aW9uX3BvaW50ZXJzKHN0cnVjdCBwcF9od21n
ciAqaHdtZ3IpOwo+Cj4gIHN0YXRpYyBpbnQgcG9sYXJpc19zZXRfYXNpY19zcGVjaWFsX2NhcHMo
c3RydWN0IHBwX2h3bWdyICpod21ncik7Cj4gLS0KPiAyLjI1LjEKPgo+IF9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4gZHJpLWRldmVsIG1haWxpbmcgbGlz
dAo+IGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPiBodHRwczovL2xpc3RzLmZyZWVk
ZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2RyaS1kZXZlbApfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4
QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2FtZC1nZngK
