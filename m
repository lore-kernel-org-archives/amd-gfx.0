Return-Path: <SRS0=EB5G=BJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81DCBC433E0
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jul 2020 02:53:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43B4822B48
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jul 2020 02:53:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W6Ux5yvl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43B4822B48
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB8BA6E849;
	Thu, 30 Jul 2020 02:53:50 +0000 (UTC)
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 76BED6E849
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jul 2020 02:53:50 +0000 (UTC)
Received: by mail-wr1-x444.google.com with SMTP id r2so18343004wrs.8
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Jul 2020 19:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=4x57gKgP9W2oGRQQI31pPcgaOfoVTq0OdHqLAYoMiBQ=;
 b=W6Ux5yvl7P3DKuURoz+oKM5IUQEbYphgmsn5tFejhRUd4/uM237JomA4RrVIlQ9B56
 eE+3VwMKwxmce/V/xaomYuRrGT8n78RNQdL0FUtmC0W3aoUa8oxzpViQD+9h7x1x5EV9
 juVnETOehotAuuCrWzIEaQ0zaXa7qJ5AW89LkArqE1vzG5ywa+UWmJxDJEW9TO5Zimx9
 z2an869aXDmsCDawFs3U4L47KTZ8eRcTCpGWXnR2RaAvWaQEOcdGHZIIOl7axlB4x80L
 0kBD/PhywgxmtCn61zF2x5C9poqxYg3f5FW9Zmy1ZL6Vef9kvtMVxi3vLdbAgJw1jLP9
 W1cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=4x57gKgP9W2oGRQQI31pPcgaOfoVTq0OdHqLAYoMiBQ=;
 b=ckRzen0zYEWNI5nUwUPKl7c5LoyPCAkt/paSMR/Yk5U8TUCvRUdUxu0uHAld8QGFfJ
 CSpX/2XYq1rpEHCUfh0jDKjYbpkrrezFqzdETu2OgrwA5HWhpjPBHgrOAnr5h9O1xmii
 ms8EjQoxn+DgScX7Y5Olr2A69HnrQA8nsCUhPlxSYQaIkxUSWk3fSv9cEDgj/2qSR7ai
 gcaUVB48TmH5f1xmUsQSsMBRgNMeRNMEWp2ilJpBPJ7cfByGl49bpaGhT5VnH3cp0rxE
 Dmq4xFtBwfRLT1DVGofbGmCljlpKD9l1a3qqw17MTcnp+fiuOoxFKe6WoTnjmo4gRXej
 UOEw==
X-Gm-Message-State: AOAM533IN7ZmtFqbwi4BEpF0pQQtILGGxsrmJlwOT86YmrtFqwcKki7m
 7OPZ1IMgmh8B98XSPVJ467osHTZScxrxddHGyTzhsA==
X-Google-Smtp-Source: ABdhPJzblB7kZgbeiJyRbuJZRNlJQLiQc4QLI84Q24qYGXusTuckxwqMp3ttC+LZoVxy8NWXyXZQ028eHTboisB2mek=
X-Received: by 2002:adf:e805:: with SMTP id o5mr33822717wrm.419.1596077629028; 
 Wed, 29 Jul 2020 19:53:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200729231106.GA6598@tower>
In-Reply-To: <20200729231106.GA6598@tower>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 29 Jul 2020 22:53:37 -0400
Message-ID: <CADnq5_NQ9Oo85cV49+3pcQZTrBBc5HvoV_MQ_-wAmPhuzhq6uA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Fix regression in adjusting power
 table/profile
To: =?UTF-8?Q?Pawe=C5=82_Gronowski?= <me@woland.xyz>
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gV2VkLCBKdWwgMjksIDIwMjAgYXQgMTA6MjAgUE0gUGF3ZcWCIEdyb25vd3NraSA8bWVAd29s
YW5kLnh5ej4gd3JvdGU6Cj4KPiBSZWdyZXNzaW9uIHdhcyBpbnRyb2R1Y2VkIGluIGNvbW1pdCAz
OGUwYzg5YTE5ZmQKPiAoImRybS9hbWRncHU6IEZpeCBOVUxMIGRlcmVmZXJlbmNlIGluIGRwbSBz
eXNmcyBoYW5kbGVycyIpIHdoaWNoCj4gbWFkZSB0aGUgc2V0X3BwX29kX2Nsa192b2x0YWdlIGFu
ZCBzZXRfcHBfcG93ZXJfcHJvZmlsZV9tb2RlIHJldHVybgo+IC1FSU5WQUwgZm9yIHByZXZpb3Vz
bHkgdmFsaWQgaW5wdXQuIFRoaXMgd2FzIGNhdXNlZCBieSBhbiBlbXB0eQo+IHN0cmluZyAoc3Rh
cnRpbmcgYXQgdGhlIFwwIGNoYXJhY3RlcikgYmVpbmcgcGFzc2VkIHRvIHRoZSBrc3RydG9sLgo+
Cj4gU2lnbmVkLW9mZi1ieTogUGF3ZcWCIEdyb25vd3NraSA8bWVAd29sYW5kLnh5ej4KCkFwcGxp
ZWQuICBUaGFua3MhCgpBbGV4Cgo+IC0tLQo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfcG0uYyB8IDkgKysrKysrKy0tCj4gIDEgZmlsZSBjaGFuZ2VkLCA3IGluc2VydGlvbnMo
KyksIDIgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X3BtLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcG0u
Ywo+IGluZGV4IGViYjhhMjhmZjAwMi4uY2JmNjIzZmYwM2JkIDEwMDY0NAo+IC0tLSBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9wbS5jCj4gKysrIGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X3BtLmMKPiBAQCAtNzc4LDEyICs3NzgsMTQgQEAgc3RhdGljIHNz
aXplX3QgYW1kZ3B1X3NldF9wcF9vZF9jbGtfdm9sdGFnZShzdHJ1Y3QgZGV2aWNlICpkZXYsCj4g
ICAgICAgICAgICAgICAgIHRtcF9zdHIrKzsKPiAgICAgICAgIHdoaWxlIChpc3NwYWNlKCorK3Rt
cF9zdHIpKTsKPgo+IC0gICAgICAgd2hpbGUgKChzdWJfc3RyID0gc3Ryc2VwKCZ0bXBfc3RyLCBk
ZWxpbWl0ZXIpKSAhPSBOVUxMKSB7Cj4gKyAgICAgICB3aGlsZSAoKHN1Yl9zdHIgPSBzdHJzZXAo
JnRtcF9zdHIsIGRlbGltaXRlcikpICYmICpzdWJfc3RyKSB7Cj4gICAgICAgICAgICAgICAgIHJl
dCA9IGtzdHJ0b2woc3ViX3N0ciwgMCwgJnBhcmFtZXRlcltwYXJhbWV0ZXJfc2l6ZV0pOwo+ICAg
ICAgICAgICAgICAgICBpZiAocmV0KQo+ICAgICAgICAgICAgICAgICAgICAgICAgIHJldHVybiAt
RUlOVkFMOwo+ICAgICAgICAgICAgICAgICBwYXJhbWV0ZXJfc2l6ZSsrOwo+Cj4gKyAgICAgICAg
ICAgICAgIGlmICghdG1wX3N0cikKPiArICAgICAgICAgICAgICAgICAgICAgICBicmVhazsKPiAg
ICAgICAgICAgICAgICAgd2hpbGUgKGlzc3BhY2UoKnRtcF9zdHIpKQo+ICAgICAgICAgICAgICAg
ICAgICAgICAgIHRtcF9zdHIrKzsKPiAgICAgICAgIH0KPiBAQCAtMTYzNSwxMSArMTYzNywxNCBA
QCBzdGF0aWMgc3NpemVfdCBhbWRncHVfc2V0X3BwX3Bvd2VyX3Byb2ZpbGVfbW9kZShzdHJ1Y3Qg
ZGV2aWNlICpkZXYsCj4gICAgICAgICAgICAgICAgICAgICAgICAgaSsrOwo+ICAgICAgICAgICAg
ICAgICBtZW1jcHkoYnVmX2NweSwgYnVmLCBjb3VudC1pKTsKPiAgICAgICAgICAgICAgICAgdG1w
X3N0ciA9IGJ1Zl9jcHk7Cj4gLSAgICAgICAgICAgICAgIHdoaWxlICgoc3ViX3N0ciA9IHN0cnNl
cCgmdG1wX3N0ciwgZGVsaW1pdGVyKSkgIT0gTlVMTCkgewo+ICsgICAgICAgICAgICAgICB3aGls
ZSAoKHN1Yl9zdHIgPSBzdHJzZXAoJnRtcF9zdHIsIGRlbGltaXRlcikpICYmICpzdWJfc3RyKSB7
Cj4gICAgICAgICAgICAgICAgICAgICAgICAgcmV0ID0ga3N0cnRvbChzdWJfc3RyLCAwLCAmcGFy
YW1ldGVyW3BhcmFtZXRlcl9zaXplXSk7Cj4gICAgICAgICAgICAgICAgICAgICAgICAgaWYgKHJl
dCkKPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHJldHVybiAtRUlOVkFMOwo+ICAg
ICAgICAgICAgICAgICAgICAgICAgIHBhcmFtZXRlcl9zaXplKys7Cj4gKwo+ICsgICAgICAgICAg
ICAgICAgICAgICAgIGlmICghdG1wX3N0cikKPiArICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIGJyZWFrOwo+ICAgICAgICAgICAgICAgICAgICAgICAgIHdoaWxlIChpc3NwYWNlKCp0bXBf
c3RyKSkKPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHRtcF9zdHIrKzsKPiAgICAg
ICAgICAgICAgICAgfQo+IC0tCj4gMi4yNS4xCj4KPiBfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwo+IGFtZC1nZnggbWFpbGluZyBsaXN0Cj4gYW1kLWdmeEBs
aXN0cy5mcmVlZGVza3RvcC5vcmcKPiBodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2FtZC1nZngKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3Rv
cC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQt
Z2Z4Cg==
