Return-Path: <SRS0=ZBu5=Z3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39F07C43603
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Dec 2019 13:50:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15B222464E
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Dec 2019 13:50:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15B222464E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE22B6E02F;
	Thu,  5 Dec 2019 13:50:12 +0000 (UTC)
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com
 [IPv6:2a00:1450:4864:20::443])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F3996E02F
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Dec 2019 13:50:11 +0000 (UTC)
Received: by mail-wr1-x443.google.com with SMTP id a15so3656503wrf.9
 for <amd-gfx@lists.freedesktop.org>; Thu, 05 Dec 2019 05:50:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=2CGDFZMyh3g3xuVqQ/SMu987x7Ks5uut4WH8UIOEahw=;
 b=iZDaD1/fBgfUn8x9wncLk+r534fubOYWlVGoM1zV5dBvgvKEb60rw1MIxTjCTyoK/7
 lzCVWh9F1erozzBz0L0Qj4hKRav+dcne7+BZoIlqrecEk/JvWK54L97IC2feTlN93I5F
 oN1ap3C9xLJVOe4VibCLHQHU7UFRzmnWTJP8hZBWcbdO06IrPSHLyIyTsaavp4wMC5sE
 tx8VQJqzod/khsjFZzmdVVzNjNlsLzQDUfWhCJUfF/ZBlV/WhipUKdBAZWsi6Vf3e6H5
 N1deXMWmsV3rFak5vqcbYwjW4fw9ZWQCyt31Pm3iy064S13hRgEFkMndjIMRMU3NgVIh
 C9zg==
X-Gm-Message-State: APjAAAXKWENG3+1d2AiOcOSzKkGa8+bRdJZzLZVn96TXazlNj86xt97X
 xkCnjBNMOw6Qq0TmakDHbi7Pfsn7QkSjNjxgEKSJ1w==
X-Google-Smtp-Source: APXvYqxyJBYPpMP8VqPErEKK69254qaffcpnQMtSNaKRQM2QVv/VqkEV1mwNPIfM3xDhzzi4UWt7iy+7YHHDtydif94=
X-Received: by 2002:a5d:46c7:: with SMTP id g7mr6465374wrs.11.1575553810019;
 Thu, 05 Dec 2019 05:50:10 -0800 (PST)
MIME-Version: 1.0
References: <20191205072557.20915-1-xiaojie.yuan@amd.com>
In-Reply-To: <20191205072557.20915-1-xiaojie.yuan@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 5 Dec 2019 08:49:58 -0500
Message-ID: <CADnq5_MkqO15OGK_LZyR3HA=nt0Zvc2tCk0wj8xf=zbhYWZoMQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: rename a leftover DCN1_0 kconfig
To: Xiaojie Yuan <xiaojie.yuan@amd.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc;
 bh=2CGDFZMyh3g3xuVqQ/SMu987x7Ks5uut4WH8UIOEahw=;
 b=VSiyIiAfH4MZx9czqj/Y2G6yi+In2JYKqafX78PysD2Xd0lH4ughHRudGx9htrWsFg
 yaORqcyldAEehDKwTX8+Uf2PfbSPI3WxVzeAuBe49hehfY6I/R1JALEOFLorPyT+taM2
 AOe3qA/w8BjD47hg9e9abufsRV6abfw6UfPIVCqVQx+EgYWD7SWb2x8vGi5bxsIFjtSq
 APkhkwl8qJDBeIChsVIuTwqSXVgIDTSMubjEXQY/OdWmFO7bGsWbZnetIL7kKQ1D26ne
 aMA9MeXVmzWH083LofTsvTZxtlmMK1UJ24CbSPLwT/AEOFX/FPVXY2PKa6so7kg8Vtam
 onZQ==
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Cc: "Wentland, Harry" <harry.wentland@amd.com>,
 Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gVGh1LCBEZWMgNSwgMjAxOSBhdCAyOjI2IEFNIFhpYW9qaWUgWXVhbiA8eGlhb2ppZS55dWFu
QGFtZC5jb20+IHdyb3RlOgo+Cj4gRml4ZXM6IGI4NmExYWEzNmE5MiAoImRybS9hbWQvZGlzcGxh
eTogcmVuYW1lIERDTjFfMCBrY29uZmlnIHRvIERDTiIpCj4gU2lnbmVkLW9mZi1ieTogWGlhb2pp
ZSBZdWFuIDx4aWFvamllLnl1YW5AYW1kLmNvbT4KClJldmlld2VkLWJ5OiBBbGV4IERldWNoZXIg
PGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+Cgo+IC0tLQo+ICBkcml2ZXJzL2dwdS9kcm0vYW1k
L2Rpc3BsYXkvZGMvY29yZS9kYy5jIHwgMiArLQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRp
b24oKyksIDEgZGVsZXRpb24oLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L2Rpc3BsYXkvZGMvY29yZS9kYy5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2Nv
cmUvZGMuYwo+IGluZGV4IDI2NDVkMjBlOGM0Yy4uNTczYzIwZDI1ZTU4IDEwMDY0NAo+IC0tLSBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9jb3JlL2RjLmMKPiArKysgYi9kcml2ZXJz
L2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvY29yZS9kYy5jCj4gQEAgLTIxODEsNyArMjE4MSw3IEBA
IHN0YXRpYyB2b2lkIGNvbW1pdF9wbGFuZXNfZm9yX3N0cmVhbShzdHJ1Y3QgZGMgKmRjLAo+ICAg
ICAgICAgfQo+ICAgICAgICAgaWYgKGRjLT5od3NzLnByb2dyYW1fZnJvbnRfZW5kX2Zvcl9jdHgg
JiYgdXBkYXRlX3R5cGUgIT0gVVBEQVRFX1RZUEVfRkFTVCkgewo+ICAgICAgICAgICAgICAgICBk
Yy0+aHdzcy5wcm9ncmFtX2Zyb250X2VuZF9mb3JfY3R4KGRjLCBjb250ZXh0KTsKPiAtI2lmZGVm
IENPTkZJR19EUk1fQU1EX0RDX0RDTjFfMAo+ICsjaWZkZWYgQ09ORklHX0RSTV9BTURfRENfRENO
Cj4gICAgICAgICAgICAgICAgIGlmIChkYy0+ZGVidWcudmFsaWRhdGVfZG1sX291dHB1dCkgewo+
ICAgICAgICAgICAgICAgICAgICAgICAgIGZvciAoaSA9IDA7IGkgPCBkYy0+cmVzX3Bvb2wtPnBp
cGVfY291bnQ7IGkrKykgewo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc3RydWN0
IHBpcGVfY3R4IGN1cl9waXBlID0gY29udGV4dC0+cmVzX2N0eC5waXBlX2N0eFtpXTsKPiAtLQo+
IDIuMjAuMQo+Cj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KPiBhbWQtZ2Z4IG1haWxpbmcgbGlzdAo+IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
Cj4gaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZngg
bWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
