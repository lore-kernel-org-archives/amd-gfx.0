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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84825C55ABD
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Nov 2020 23:38:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0423E20781
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Nov 2020 23:38:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hs2n0APq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0423E20781
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C72589D39;
	Tue, 10 Nov 2020 23:38:38 +0000 (UTC)
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com
 [IPv6:2a00:1450:4864:20::341])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF26589D2F;
 Tue, 10 Nov 2020 23:38:36 +0000 (UTC)
Received: by mail-wm1-x341.google.com with SMTP id a65so140143wme.1;
 Tue, 10 Nov 2020 15:38:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=ZutQPrufGfr7YlLgQNj0QvrwUThkZK+ztyYTltmNCZk=;
 b=hs2n0APqvWN+vmIUcsnQpZ142iKWzIjoNZGyhMuos07ct2uGqr8Hss/f+FOu8VQ0kp
 VdbD5rRvv3lZoMXG/LQpxvaDMFq147lNPqcqyHJ3MUj4220I+hmy+yrDobjn/tTmmGOl
 rRLWYHVRY7OiPIZPm2m3NMJUX1VKUIryRPGd+aKNzYYhOBOA2MVct4DWuXdaU6itKfrS
 B6+v/T3y8c+okBb4yqlMaKNK3V39ohV9cWO899AsPSfF8Vw/mKCzISMTXhBny0WG5sl3
 AnRKkM53FfRuO4zMZMxVmZoAdNrhBRfimulwtAUi0dD8TC9n+rmPf+8itYDM2HWwty9U
 mkPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=ZutQPrufGfr7YlLgQNj0QvrwUThkZK+ztyYTltmNCZk=;
 b=ALDJjzPVAWVA1IlV+/iKMBpO/CXO3h2hrTsDmpR5vG2hnteO1Y/uGaHL32IcoeewMw
 QxQPUI8LFe8w+kqa0Se58eqGyT4e0KmXBDYctZs1jDRCd13JEYUGRpDwaGyCMV1TOYp8
 eoD5YDAPl7rBL6zexKv6NsK47YmBZCgVToGwCstpeq7V+OnGaIfgSOhL03NXqyRZoZ7P
 CtM3t5AFJP18r0aqHCVi/DNBOrPJjKfxzUsqghYh8rDYtd0lGdcmFqkcmmB1q+H9P4ay
 b2NpANzjDOZpEUokAeDyP378clYSJcJfefP016YJHD2J6jio7H3WDSI1prgFRRFDsfGI
 dE7A==
X-Gm-Message-State: AOAM531ZCqlL54HH5TXG3QVS7TCnPSAvFZd/uVEpcqEqJ2By65wsS/0t
 yXGCkirR5uxtQDs7yb175pIMjxEbnouFQ+zp1VJziJbr
X-Google-Smtp-Source: ABdhPJy2m8bHEXbEVMkU51+jmBCoJ3ggpUW+m6uPbCFn43PxxjQc7bBA0BDypg535Bs9DNR7IaGJu8PAqgXGp2NSnQQ=
X-Received: by 2002:a1c:46c6:: with SMTP id t189mr554021wma.79.1605051515558; 
 Tue, 10 Nov 2020 15:38:35 -0800 (PST)
MIME-Version: 1.0
References: <20201110193112.988999-1-lee.jones@linaro.org>
 <20201110193112.988999-7-lee.jones@linaro.org>
In-Reply-To: <20201110193112.988999-7-lee.jones@linaro.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 10 Nov 2020 18:38:24 -0500
Message-ID: <CADnq5_M89n3R8SLWxcMpVnsTLurgZFqB9-p2g_XrST5_4=F=Pg@mail.gmail.com>
Subject: Re: [PATCH 06/30] drm/radeon/trinity_dpm: Remove some defined but
 never used arrays
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
YXJuaW5nKHMpOgo+Cj4gIGRyaXZlcnMvZ3B1L2RybS9yYWRlb24vdHJpbml0eV9kcG0uYzoxNDY6
MTg6IHdhcm5pbmc6IOKAmHRyaW5pdHlfc3lzbHNfZGVmYXVsdOKAmSBkZWZpbmVkIGJ1dCBub3Qg
dXNlZCBbLVd1bnVzZWQtY29uc3QtdmFyaWFibGU9XQo+ICBkcml2ZXJzL2dwdS9kcm0vcmFkZW9u
L3RyaW5pdHlfZHBtLmM6MTMxOjE4OiB3YXJuaW5nOiDigJh0cmluaXR5X21nY2dfc2hsc19kaXNh
Ymxl4oCZIGRlZmluZWQgYnV0IG5vdCB1c2VkIFstV3VudXNlZC1jb25zdC12YXJpYWJsZT1dCj4g
IGRyaXZlcnMvZ3B1L2RybS9yYWRlb24vdHJpbml0eV9kcG0uYzoxMjA6MTg6IHdhcm5pbmc6IOKA
mHRyaW5pdHlfbWdjZ19zaGxzX2VuYWJsZeKAmSBkZWZpbmVkIGJ1dCBub3QgdXNlZCBbLVd1bnVz
ZWQtY29uc3QtdmFyaWFibGU9XQo+Cj4gQ2M6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNo
ZXJAYW1kLmNvbT4KPiBDYzogIkNocmlzdGlhbiBLw7ZuaWciIDxjaHJpc3RpYW4ua29lbmlnQGFt
ZC5jb20+Cj4gQ2M6IERhdmlkIEFpcmxpZSA8YWlybGllZEBsaW51eC5pZT4KPiBDYzogRGFuaWVs
IFZldHRlciA8ZGFuaWVsQGZmd2xsLmNoPgo+IENjOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZwo+IENjOiBkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4gU2lnbmVkLW9mZi1i
eTogTGVlIEpvbmVzIDxsZWUuam9uZXNAbGluYXJvLm9yZz4KCkFwcGxpZWQuICBUaGFua3MhCgpB
bGV4Cgo+IC0tLQo+ICBkcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3RyaW5pdHlfZHBtLmMgfCA0NCAt
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCj4gIDEgZmlsZSBjaGFuZ2VkLCA0NCBkZWxldGlv
bnMoLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3RyaW5pdHlfZHBt
LmMgYi9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3RyaW5pdHlfZHBtLmMKPiBpbmRleCA0ZDkzYjg0
YWE3Mzk3Li5lMDA1YzE4YWFjMDBlIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9yYWRl
b24vdHJpbml0eV9kcG0uYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vdHJpbml0eV9k
cG0uYwo+IEBAIC0xMTYsNTUgKzExNiwxMSBAQCBzdGF0aWMgY29uc3QgdTMyIHRyaW5pdHlfbWdj
Z19zaGxzX2RlZmF1bHRbXSA9Cj4gICAgICAgICAweDAwMDA5MjIwLCAweDAwMDkwMDA4LCAweGZm
ZmZmZmZmLAo+ICAgICAgICAgMHgwMDAwOTI5NCwgMHgwMDAwMDAwMCwgMHhmZmZmZmZmZgo+ICB9
Owo+IC0KPiAtc3RhdGljIGNvbnN0IHUzMiB0cmluaXR5X21nY2dfc2hsc19lbmFibGVbXSA9Cj4g
LXsKPiAtICAgICAgIC8qIFJlZ2lzdGVyLCBWYWx1ZSwgTWFzayAqLwo+IC0gICAgICAgMHgwMDAw
ODAyYywgMHhjMDAwMDAwMCwgMHhmZmZmZmZmZiwKPiAtICAgICAgIDB4MDAwMDA4ZjgsIDB4MDAw
MDAwMDAsIDB4ZmZmZmZmZmYsCj4gLSAgICAgICAweDAwMDAwOGZjLCAweDAwMDAwMDAwLCAweDAw
MDEzM0ZGLAo+IC0gICAgICAgMHgwMDAwMDhmOCwgMHgwMDAwMDAwMSwgMHhmZmZmZmZmZiwKPiAt
ICAgICAgIDB4MDAwMDA4ZmMsIDB4MDAwMDAwMDAsIDB4RTAwQjAzRkMsCj4gLSAgICAgICAweDAw
MDA5MTUwLCAweDk2OTQ0MjAwLCAweGZmZmZmZmZmCj4gLX07Cj4gLQo+IC1zdGF0aWMgY29uc3Qg
dTMyIHRyaW5pdHlfbWdjZ19zaGxzX2Rpc2FibGVbXSA9Cj4gLXsKPiAtICAgICAgIC8qIFJlZ2lz
dGVyLCBWYWx1ZSwgTWFzayAqLwo+IC0gICAgICAgMHgwMDAwODAyYywgMHhjMDAwMDAwMCwgMHhm
ZmZmZmZmZiwKPiAtICAgICAgIDB4MDAwMDkxNTAsIDB4MDA2MDAwMDAsIDB4ZmZmZmZmZmYsCj4g
LSAgICAgICAweDAwMDAwOGY4LCAweDAwMDAwMDAwLCAweGZmZmZmZmZmLAo+IC0gICAgICAgMHgw
MDAwMDhmYywgMHhmZmZmZmZmZiwgMHgwMDAxMzNGRiwKPiAtICAgICAgIDB4MDAwMDA4ZjgsIDB4
MDAwMDAwMDEsIDB4ZmZmZmZmZmYsCj4gLSAgICAgICAweDAwMDAwOGZjLCAweGZmZmZmZmZmLCAw
eEUwMEIwM0ZDCj4gLX07Cj4gICNlbmRpZgo+Cj4gICNpZm5kZWYgVFJJTklUWV9TWVNMU19TRVFV
RU5DRQo+ICAjZGVmaW5lIFRSSU5JVFlfU1lTTFNfU0VRVUVOQ0UgIDEwMAo+Cj4gLXN0YXRpYyBj
b25zdCB1MzIgdHJpbml0eV9zeXNsc19kZWZhdWx0W10gPQo+IC17Cj4gLSAgICAgICAvKiBSZWdp
c3RlciwgVmFsdWUsIE1hc2sgKi8KPiAtICAgICAgIDB4MDAwMDU1ZTgsIDB4MDAwMDAwMDAsIDB4
ZmZmZmZmZmYsCj4gLSAgICAgICAweDAwMDBkMGJjLCAweDAwMDAwMDAwLCAweGZmZmZmZmZmLAo+
IC0gICAgICAgMHgwMDAwZDhiYywgMHgwMDAwMDAwMCwgMHhmZmZmZmZmZiwKPiAtICAgICAgIDB4
MDAwMDE1YzAsIDB4MDAwYzE0MDEsIDB4ZmZmZmZmZmYsCj4gLSAgICAgICAweDAwMDAyNjRjLCAw
eDAwMGMwNDAwLCAweGZmZmZmZmZmLAo+IC0gICAgICAgMHgwMDAwMjY0OCwgMHgwMDBjMDQwMCwg
MHhmZmZmZmZmZiwKPiAtICAgICAgIDB4MDAwMDI2NTAsIDB4MDAwYzA0MDAsIDB4ZmZmZmZmZmYs
Cj4gLSAgICAgICAweDAwMDAyMGI4LCAweDAwMGMwNDAwLCAweGZmZmZmZmZmLAo+IC0gICAgICAg
MHgwMDAwMjBiYywgMHgwMDBjMDQwMCwgMHhmZmZmZmZmZiwKPiAtICAgICAgIDB4MDAwMDIwYzAs
IDB4MDAwYzBjODAsIDB4ZmZmZmZmZmYsCj4gLSAgICAgICAweDAwMDBmNGEwLCAweDAwMDAwMGMw
LCAweGZmZmZmZmZmLAo+IC0gICAgICAgMHgwMDAwZjRhNCwgMHgwMDY4MGZmZiwgMHhmZmZmZmZm
ZiwKPiAtICAgICAgIDB4MDAwMDJmNTAsIDB4MDAwMDA0MDQsIDB4ZmZmZmZmZmYsCj4gLSAgICAg
ICAweDAwMDAwNGM4LCAweDAwMDAwMDAxLCAweGZmZmZmZmZmLAo+IC0gICAgICAgMHgwMDAwNjQx
YywgMHgwMDAwMDAwMCwgMHhmZmZmZmZmZiwKPiAtICAgICAgIDB4MDAwMDBjN2MsIDB4MDAwMDAw
MDAsIDB4ZmZmZmZmZmYsCj4gLSAgICAgICAweDAwMDA2ZGZjLCAweDAwMDAwMDAwLCAweGZmZmZm
ZmZmCj4gLX07Cj4gLQo+ICBzdGF0aWMgY29uc3QgdTMyIHRyaW5pdHlfc3lzbHNfZGlzYWJsZVtd
ID0KPiAgewo+ICAgICAgICAgLyogUmVnaXN0ZXIsIFZhbHVlLCBNYXNrICovCj4gLS0KPiAyLjI1
LjEKPgo+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4g
ZHJpLWRldmVsIG1haWxpbmcgbGlzdAo+IGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcK
PiBodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2RyaS1kZXZl
bApfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4
IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3Rz
LmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
