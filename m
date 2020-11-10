Return-Path: <SRS0=ErGV=EQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E53AC388F7
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Nov 2020 22:08:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15761207D3
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Nov 2020 22:08:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jEHvWPHu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15761207D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B8DA893E8;
	Tue, 10 Nov 2020 22:08:55 +0000 (UTC)
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com
 [IPv6:2a00:1450:4864:20::342])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1BDF4893E8;
 Tue, 10 Nov 2020 22:08:54 +0000 (UTC)
Received: by mail-wm1-x342.google.com with SMTP id a65so4702712wme.1;
 Tue, 10 Nov 2020 14:08:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=W/G1cCKiChHWAMYc3JRK1M6ntm3rFjLembXKLShlhjI=;
 b=jEHvWPHultoa+XlSxa6GFBJtx/Qp4byqG0fkbQf03ZlkKLmHTauy1n04ojprn0LjD7
 AqjVJD9NAWrabIVHV0GXdLKuJp92lPRC5srbI2D4E/7e1FRBXoKrhpZAVjHn21ZvdPgS
 fOzCj45HiC2oJV9hrDcVbrF7B9PZxeFuDC2MY/orooI08UpqBYBv3XE6b9HwI6ReKWuN
 JpqUGDY3BZZRDwa9/eHdDZz11aNpCO/oHrBatIPLHGiAQ2rLJVZ3LbtZIKhXVTw1tDEX
 AdOQrOx33vTKFSB9ixCB51OYBUhmkkxUu+lFBmgVQrkdbV1Ovi9J3KW2CmoGJfHuMKsX
 Hz8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=W/G1cCKiChHWAMYc3JRK1M6ntm3rFjLembXKLShlhjI=;
 b=b5uoHWS8gKJVrGFWzJrlCD0dzgjPhzh/u9qDPwfAj1FJQ7mLWAlOgzXJNzvntIoNKS
 zT/UQTxx2FtoOZ9mDou3vHTsHSDz1h3wm4YbHyzHCpfFmpsXP627g0bsjp715Hu6imxo
 WdhehnfE/sqE1Mb1CzxzrcbwmHmVuC7Ik3pti/p77xueoNJdRFK1DyuCDGH1t7YuEVB2
 F7N12p3ZSK+ikaoTeuDDwF2462cltjdX9giJJFHuxwgLhteuIzeWfPUo60Zia54BRYmP
 Z5QSaSgRYN6aqJ6YYJ3B/6udeYK1Zg7VIbw7WNoez3XuJZZ/vIN0u2eXbMbVldP5gn0x
 PEZQ==
X-Gm-Message-State: AOAM532EcveOkilQfckIBymSR20W48BhfTShrPsg6iYW7WzvbVvtksoj
 i+CfOLZ73WDtEX1A+vtfgV5ipEmF0T6EJwXKhnY=
X-Google-Smtp-Source: ABdhPJx34oGTHXB74qraONACHcaotZfbZfG/di5YV/g/5I4xjs1LA59YzHGShOOwna0bWMj0j+kNFCziDgNUvDa0Zn0=
X-Received: by 2002:a1c:6302:: with SMTP id x2mr273459wmb.56.1605046132845;
 Tue, 10 Nov 2020 14:08:52 -0800 (PST)
MIME-Version: 1.0
References: <20201109211855.3340030-1-lee.jones@linaro.org>
 <20201109211855.3340030-7-lee.jones@linaro.org>
In-Reply-To: <20201109211855.3340030-7-lee.jones@linaro.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 10 Nov 2020 17:08:41 -0500
Message-ID: <CADnq5_Oo6Y3M-dVewXFxKRYooYfpDPLhxHQhXrWt9y759uXjsg@mail.gmail.com>
Subject: Re: [PATCH 06/20] drm/radeon/radeon_connectors: Strip out set but
 unused variable 'ret'
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

T24gTW9uLCBOb3YgOSwgMjAyMCBhdCA0OjE5IFBNIExlZSBKb25lcyA8bGVlLmpvbmVzQGxpbmFy
by5vcmc+IHdyb3RlOgo+Cj4gRml4ZXMgdGhlIGZvbGxvd2luZyBXPTEga2VybmVsIGJ1aWxkIHdh
cm5pbmcocyk6Cj4KPiAgZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fY29ubmVjdG9ycy5j
OiBJbiBmdW5jdGlvbiDigJhyYWRlb25fc2V0dXBfbXN0X2Nvbm5lY3RvcuKAmToKPiAgZHJpdmVy
cy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fY29ubmVjdG9ycy5jOjI1NzQ6Nzogd2FybmluZzogdmFy
aWFibGUg4oCYcmV04oCZIHNldCBidXQgbm90IHVzZWQgWy1XdW51c2VkLWJ1dC1zZXQtdmFyaWFi
bGVdCj4KPiBDYzogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgo+IENj
OiAiQ2hyaXN0aWFuIEvDtm5pZyIgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KPiBDYzogRGF2
aWQgQWlybGllIDxhaXJsaWVkQGxpbnV4LmllPgo+IENjOiBEYW5pZWwgVmV0dGVyIDxkYW5pZWxA
ZmZ3bGwuY2g+Cj4gQ2M6IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4gQ2M6IGRyaS1k
ZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPiBTaWduZWQtb2ZmLWJ5OiBMZWUgSm9uZXMgPGxl
ZS5qb25lc0BsaW5hcm8ub3JnPgoKQXBwbGllZC4gIFRoYW5rcyEKCkFsZXgKCj4gLS0tCj4gIGRy
aXZlcnMvZ3B1L2RybS9yYWRlb24vcmFkZW9uX2Nvbm5lY3RvcnMuYyB8IDQgKy0tLQo+ICAxIGZp
bGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDMgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fY29ubmVjdG9ycy5jIGIvZHJpdmVycy9n
cHUvZHJtL3JhZGVvbi9yYWRlb25fY29ubmVjdG9ycy5jCj4gaW5kZXggZTMwODM0NDM0NDQyNS4u
NjA3YWQ1NjIwYmQ5OSAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVv
bl9jb25uZWN0b3JzLmMKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVvbl9jb25u
ZWN0b3JzLmMKPiBAQCAtMjU3MSwxMyArMjU3MSwxMSBAQCB2b2lkIHJhZGVvbl9zZXR1cF9tc3Rf
Y29ubmVjdG9yKHN0cnVjdCBkcm1fZGV2aWNlICpkZXYpCj4gICAgICAgICAgICAgICAgIHJldHVy
bjsKPgo+ICAgICAgICAgbGlzdF9mb3JfZWFjaF9lbnRyeShjb25uZWN0b3IsICZkZXYtPm1vZGVf
Y29uZmlnLmNvbm5lY3Rvcl9saXN0LCBoZWFkKSB7Cj4gLSAgICAgICAgICAgICAgIGludCByZXQ7
Cj4gLQo+ICAgICAgICAgICAgICAgICByYWRlb25fY29ubmVjdG9yID0gdG9fcmFkZW9uX2Nvbm5l
Y3Rvcihjb25uZWN0b3IpOwo+Cj4gICAgICAgICAgICAgICAgIGlmIChjb25uZWN0b3ItPmNvbm5l
Y3Rvcl90eXBlICE9IERSTV9NT0RFX0NPTk5FQ1RPUl9EaXNwbGF5UG9ydCkKPiAgICAgICAgICAg
ICAgICAgICAgICAgICBjb250aW51ZTsKPgo+IC0gICAgICAgICAgICAgICByZXQgPSByYWRlb25f
ZHBfbXN0X2luaXQocmFkZW9uX2Nvbm5lY3Rvcik7Cj4gKyAgICAgICAgICAgICAgIHJhZGVvbl9k
cF9tc3RfaW5pdChyYWRlb25fY29ubmVjdG9yKTsKPiAgICAgICAgIH0KPiAgfQo+IC0tCj4gMi4y
NS4xCj4KPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+
IGRyaS1kZXZlbCBtYWlsaW5nIGxpc3QKPiBkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
Cj4gaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9kcmktZGV2
ZWwKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdm
eCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0
cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
