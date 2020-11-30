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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B8BFC63777
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Nov 2020 23:51:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD4A3207BB
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Nov 2020 23:51:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ttnDYv3O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD4A3207BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4FC978972D;
	Mon, 30 Nov 2020 23:51:00 +0000 (UTC)
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com
 [IPv6:2607:f8b0:4864:20::243])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE3C88972D;
 Mon, 30 Nov 2020 23:50:59 +0000 (UTC)
Received: by mail-oi1-x243.google.com with SMTP id o25so16237873oie.5;
 Mon, 30 Nov 2020 15:50:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=2ca7PVpfytP1aPxU/j7JaxFmM8F00V9fbvYGUUacr9k=;
 b=ttnDYv3OBicGp7V380L+l24bkmTquhvYef/qfRDSGKWmiY+SU7cvfUHG2Y++y+zFWz
 WnXKyBGE9yXnU/2/EVgnUcNjOjfXcFqjjUezT+t8QqOCJ7ZGnW/qg46I8c96lJC4fij5
 xjImTsd7cAdGTUjdtlrv/xNrClp1HqVkxDt/19aCERWkQvRp9LnsZ1McxuHaosDgaNO7
 YhZNowI/EuQLS83lXRQVY5BnPv0QFIMsFUCNxox+zMMmHnBtldVVclzUsSc8kMbYKhvI
 zyt8bl2z0Dxlti/o9V3PHFs5/XGt0cq9MvTS6xtRTqH642BCnyYbBz90aykczzN4WdJk
 C03A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=2ca7PVpfytP1aPxU/j7JaxFmM8F00V9fbvYGUUacr9k=;
 b=iRM8CftXgnphNJk6B6btbIoYNxcB8zq+tj8dQ9xK4UUBCdbCHjOGhRl8NjKzvHEi4p
 R0kmvOALNVp1ESetq0W50yGV8a+w1ybPJ/Bt/eCXaWLOlNHi7ktFXTdTq6RN0Ma4DQbt
 8wuKMOhjsvFlZVl17NX5BOPBoD5gZtI3v5ziuG3yI7xdFm4csc2RVXd0nUOSOfeu3bSd
 VVG+6ZG8VXDxYQtiUmVxHvC0jBSqfVf1hV1ue88GUIZX8t+MHgKLFP8IvXdFByGzhHZp
 yTjjLAk/iCugBI2KQXfIiYZC17K4eTeFnsb1KM7KgyqMUkpQhd41feHJcHQyo393wUdG
 WWLQ==
X-Gm-Message-State: AOAM531RKIMs+pmIlJzOLR8GgKArJxQKFVtMaVBp8+OL8foX5x9OLf5j
 D+2+37kcbG4v/abeN4fcuUOvdKb3elfkYmbDgr4=
X-Google-Smtp-Source: ABdhPJwsEAd+N0VpI7gu+4CCxBbJl4uiCP5TmE/VOSPicY6NcrNiAgVV26fqk/OXYwVj8lmQ07kr1SowZ/1KcZ4cCCA=
X-Received: by 2002:aca:f50e:: with SMTP id t14mr188996oih.123.1606780259177; 
 Mon, 30 Nov 2020 15:50:59 -0800 (PST)
MIME-Version: 1.0
References: <20201126134240.3214176-1-lee.jones@linaro.org>
 <20201126134240.3214176-27-lee.jones@linaro.org>
In-Reply-To: <20201126134240.3214176-27-lee.jones@linaro.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 30 Nov 2020 18:50:47 -0500
Message-ID: <CADnq5_PR73t=pkaVpSydDGG6NO6zedopQhy6jJthQn6RJucL1w@mail.gmail.com>
Subject: Re: [PATCH 26/40] drm/amd/pm/powerplay/hwmgr/hwmgr: Move
 'vega12_hwmgr_init()'s prototype to shared header
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
eS9od21nci92ZWdhMTJfaHdtZ3IuYzoyODYyOjU6IHdhcm5pbmc6IG5vIHByZXZpb3VzIHByb3Rv
dHlwZSBmb3Ig4oCYdmVnYTEyX2h3bWdyX2luaXTigJkgWy1XbWlzc2luZy1wcm90b3R5cGVzXQo+
ICAyODYyIHwgaW50IHZlZ2ExMl9od21ncl9pbml0KHN0cnVjdCBwcF9od21nciAqaHdtZ3IpCj4g
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
bS9pbmMvaHdtZ3IuaAo+IGluZGV4IDM5M2U0ZTc2YTg5NjEuLjQ5OWYyNTIwYjFhYTMgMTAwNjQ0
Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9pbmMvaHdtZ3IuaAo+ICsrKyBiL2RyaXZl
cnMvZ3B1L2RybS9hbWQvcG0vaW5jL2h3bWdyLmgKPiBAQCAtODMwLDUgKzgzMCw2IEBAIGludCBo
d21ncl9oYW5kbGVfdGFzayhzdHJ1Y3QgcHBfaHdtZ3IgKmh3bWdyLAo+Cj4gIGludCBzbXU3X2lu
aXRfZnVuY3Rpb25fcG9pbnRlcnMoc3RydWN0IHBwX2h3bWdyICpod21ncik7Cj4gIGludCBzbXU4
X2luaXRfZnVuY3Rpb25fcG9pbnRlcnMoc3RydWN0IHBwX2h3bWdyICpod21ncik7Cj4gK2ludCB2
ZWdhMTJfaHdtZ3JfaW5pdChzdHJ1Y3QgcHBfaHdtZ3IgKmh3bWdyKTsKPgo+ICAjZW5kaWYgLyog
X0hXTUdSX0hfICovCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vcG93ZXJw
bGF5L2h3bWdyL2h3bWdyLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3Bvd2VycGxheS9od21n
ci9od21nci5jCj4gaW5kZXggNzk5OTA5MWNjYTE2ZS4uNDlmOGEzMzFlYjAyZSAxMDA2NDQKPiAt
LS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3Bvd2VycGxheS9od21nci9od21nci5jCj4gKysr
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9wb3dlcnBsYXkvaHdtZ3IvaHdtZ3IuYwo+IEBAIC00
Nyw3ICs0Nyw2IEBAIGV4dGVybiBjb25zdCBzdHJ1Y3QgcHBfc211bWdyX2Z1bmMgc211MTBfc211
X2Z1bmNzOwo+ICBleHRlcm4gY29uc3Qgc3RydWN0IHBwX3NtdW1ncl9mdW5jIHZlZ2EyMF9zbXVf
ZnVuY3M7Cj4KPiAgZXh0ZXJuIGludCB2ZWdhMTBfaHdtZ3JfaW5pdChzdHJ1Y3QgcHBfaHdtZ3Ig
Kmh3bWdyKTsKPiAtZXh0ZXJuIGludCB2ZWdhMTJfaHdtZ3JfaW5pdChzdHJ1Y3QgcHBfaHdtZ3Ig
Kmh3bWdyKTsKPiAgZXh0ZXJuIGludCB2ZWdhMjBfaHdtZ3JfaW5pdChzdHJ1Y3QgcHBfaHdtZ3Ig
Kmh3bWdyKTsKPiAgZXh0ZXJuIGludCBzbXUxMF9pbml0X2Z1bmN0aW9uX3BvaW50ZXJzKHN0cnVj
dCBwcF9od21nciAqaHdtZ3IpOwo+Cj4gLS0KPiAyLjI1LjEKPgo+IF9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4gZHJpLWRldmVsIG1haWxpbmcgbGlzdAo+
IGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPiBodHRwczovL2xpc3RzLmZyZWVkZXNr
dG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2RyaS1kZXZlbApfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxp
c3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2FtZC1nZngK
