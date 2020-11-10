Return-Path: <SRS0=ErGV=EQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B93D2C388F7
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Nov 2020 22:52:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4031F2054F
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Nov 2020 22:52:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nZZ1N8Xh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4031F2054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B615C89207;
	Tue, 10 Nov 2020 22:52:51 +0000 (UTC)
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20::343])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C9E089167;
 Tue, 10 Nov 2020 22:52:50 +0000 (UTC)
Received: by mail-wm1-x343.google.com with SMTP id a65so4845467wme.1;
 Tue, 10 Nov 2020 14:52:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=BTUC8FGVFqMBk4snTGanieGNzV4iLNTVLOe0fp5iFJw=;
 b=nZZ1N8XhJjaYvDaWcKRrmJOA182Qv5EYevTAHwGaTVKT3oZungrBofi5oWopQUQiDY
 gH+Wx0ePJdMx+iXnjJAJMvqIYxZ6/sPgQASoeKy9U95dp6Ikk5DiyLN63Pz95pWJpjd2
 4eNvQWGNyvmFftw3a1qxnOTwrpuPWJfzlF9GzwglKDdvPg+B27/P/jm+wzXHHM4tyuRf
 1937y9nx4THLF3zXB+TwDVfNmPhfAbQUpUmb5E33gKZW6JgC9DeguacX36PW+49sYqdH
 6Xx+BssWUhachCYdtiQlMMb+VLrwpyeDZz4VcRH7NkZ+/z03P28H7idE58FF4ZPEG3VP
 bu1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=BTUC8FGVFqMBk4snTGanieGNzV4iLNTVLOe0fp5iFJw=;
 b=uC2S5Uzg5Ebgo1rMWI0BiOQshgNyDykNrQdqPKu7u7DiQuiK+C8kQJDHMTMUKk1BlJ
 6cDWoxnDTjjAN0pzUG7b2zM6ql89aqEWPvDH0GxHJRc4FSYRvZeTbzTAxymihhL1B/A9
 LLuQ99O5Et5stsR29anZ+qQ0SSrCNuxd+40+/H9Z5gyMX4KkysJJzxwXUzPV3Ir6NdaH
 OYoO6Q9V3tr3/0cmXNzRccNwi8Xqr7O1R1zVMdJNh8q42cNMujKoHRoXxNkUG1GejPGh
 5p016iMEF6vP8y4x5PRI8vG8pdiKLhPCdmdW1faDUIqzIahcBMO6mGy6pYeLzHuT+3L+
 eF6Q==
X-Gm-Message-State: AOAM531buE8kKVQT1IOk7fCrM7Ke/8Qhkz+HcbXuPqtyf20/t8Plywxw
 cG2CKjVBtQdQL5AQ1BWEVd3F7BuJHO2HXwzIDgU=
X-Google-Smtp-Source: ABdhPJxYIo1s9wv4msja3saUKvR3ou3NcBd36aXO0rfsTLFYntEjLMAkd2UWAOlzziavsGn3nfAcxctDilUGRad18RM=
X-Received: by 2002:a1c:1c3:: with SMTP id 186mr377724wmb.39.1605048768842;
 Tue, 10 Nov 2020 14:52:48 -0800 (PST)
MIME-Version: 1.0
References: <20201110193112.988999-1-lee.jones@linaro.org>
 <20201110193112.988999-2-lee.jones@linaro.org>
In-Reply-To: <20201110193112.988999-2-lee.jones@linaro.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 10 Nov 2020 17:52:37 -0500
Message-ID: <CADnq5_MMDnk7fvoOv8poVvCx1EVGQ0XvujHG=fBwR5XgSO+qww@mail.gmail.com>
Subject: Re: [PATCH 01/30] drm/radeon/evergreen: Add comment for
 'evergreen_page_flip()'s 'async' param
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

T24gVHVlLCBOb3YgMTAsIDIwMjAgYXQgMjozMSBQTSBMZWUgSm9uZXMgPGxlZS5qb25lc0BsaW5h
cm8ub3JnPiB3cm90ZToKPgo+IEZpeGVzIHRoZSBmb2xsb3dpbmcgVz0xIGtlcm5lbCBidWlsZCB3
YXJuaW5nKHMpOgo+Cj4gIGRyaXZlcnMvZ3B1L2RybS9yYWRlb24vZXZlcmdyZWVuLmM6IEluIGZ1
bmN0aW9uIOKAmGV2ZXJncmVlbl9ncHVfaW5pdOKAmToKPiAgZHJpdmVycy9ncHUvZHJtL3JhZGVv
bi9ldmVyZ3JlZW4uYzoxNDE5OiB3YXJuaW5nOiBGdW5jdGlvbiBwYXJhbWV0ZXIgb3IgbWVtYmVy
ICdhc3luYycgbm90IGRlc2NyaWJlZCBpbiAnZXZlcmdyZWVuX3BhZ2VfZmxpcCcKPgo+IENjOiBB
bGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+Cj4gQ2M6ICJDaHJpc3RpYW4g
S8O2bmlnIiA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgo+IENjOiBEYXZpZCBBaXJsaWUgPGFp
cmxpZWRAbGludXguaWU+Cj4gQ2M6IERhbmllbCBWZXR0ZXIgPGRhbmllbEBmZndsbC5jaD4KPiBD
YzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPiBDYzogZHJpLWRldmVsQGxpc3RzLmZy
ZWVkZXNrdG9wLm9yZwo+IFNpZ25lZC1vZmYtYnk6IExlZSBKb25lcyA8bGVlLmpvbmVzQGxpbmFy
by5vcmc+CgpBcHBsaWVkIHdpdGggbWlub3IgZml4dXBzLiAgVGhhbmtzIQoKQWxleAoKPiAtLS0K
PiAgZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9ldmVyZ3JlZW4uYyB8IDEgKwo+ICAxIGZpbGUgY2hh
bmdlZCwgMSBpbnNlcnRpb24oKykKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vcmFk
ZW9uL2V2ZXJncmVlbi5jIGIvZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9ldmVyZ3JlZW4uYwo+IGlu
ZGV4IDRlYjNmOWJjOGZhOGIuLmM5YTlhODc5NTlmOWUgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9n
cHUvZHJtL3JhZGVvbi9ldmVyZ3JlZW4uYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24v
ZXZlcmdyZWVuLmMKPiBAQCAtMTQxMiw2ICsxNDEyLDcgQEAgdm9pZCBkY2U0X3dhaXRfZm9yX3Zi
bGFuayhzdHJ1Y3QgcmFkZW9uX2RldmljZSAqcmRldiwgaW50IGNydGMpCj4gICAqIEByZGV2OiBy
YWRlb25fZGV2aWNlIHBvaW50ZXIKPiAgICogQGNydGNfaWQ6IGNydGMgdG8gY2xlYW51cCBwYWdl
ZmxpcCBvbgo+ICAgKiBAY3J0Y19iYXNlOiBuZXcgYWRkcmVzcyBvZiB0aGUgY3J0YyAoR1BVIE1D
IGFkZHJlc3MpCj4gKyAqIEBhc3luYzogU2V0IHJldHJhY2UKPiAgICoKPiAgICogVHJpZ2dlcnMg
dGhlIGFjdHVhbCBwYWdlZmxpcCBieSB1cGRhdGluZyB0aGUgcHJpbWFyeQo+ICAgKiBzdXJmYWNl
IGJhc2UgYWRkcmVzcyAoZXZlcmdyZWVuKykuCj4gLS0KPiAyLjI1LjEKPgo+IF9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4gZHJpLWRldmVsIG1haWxpbmcg
bGlzdAo+IGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPiBodHRwczovL2xpc3RzLmZy
ZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2RyaS1kZXZlbApfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQt
Z2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
