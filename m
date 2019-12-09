Return-Path: <SRS0=Fyns=Z7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F24DBC43603
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Dec 2019 14:11:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF1C720726
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Dec 2019 14:11:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF1C720726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 86D1D6E45E;
	Mon,  9 Dec 2019 14:11:21 +0000 (UTC)
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 36E9F6E45E
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Dec 2019 14:11:20 +0000 (UTC)
Received: by mail-wr1-x442.google.com with SMTP id q10so16345904wrm.11
 for <amd-gfx@lists.freedesktop.org>; Mon, 09 Dec 2019 06:11:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=dWDV5bloSY1V8imvQgadGmbq8x5hKh1veDr6LGXRMA8=;
 b=WDPDhZ+N6yJNGRaKSuLQejydseH5HKpNYYisuVAZeWveln41lOcYvmX10VuSyXrUPe
 Jz1GbkSQ2UY7xXzfddk9gq3iFxK0j8Xc9SP3Js4CBxl6+INMmA84ocJOGwwFYvS54fzl
 54Z2rodw5FcpF2UkgYvSH3A35kGRpet7BvwwFARnntsUIFq5e9YXv26lDeVKoegDT2nq
 3YZdxdie/uk/OKUW8diaLFiRvyQpbpmnnceg2Z8rgHajeoCW3OXqXN3kshOM1BJvjS9W
 yekzTi1VxaMeS3P2M/b7YF3ysh1si4GeZqcE0eTEx+S54v5gQskxDFVk4WVnv+mzfGX3
 Rpgw==
X-Gm-Message-State: APjAAAV7Ndvbonm3MmaGRAKeWPRgKjN+cAz+55YU7DEWOlNth828ZDrF
 Lv5GVE1fNVD//j0Jo5EIddKurOXo8Mxzm4IGD9+FYw==
X-Google-Smtp-Source: APXvYqxeVrutzKVKtHNtC5lxOYAB8wP6TPFUhaxnxVehoD4oA688YDtDSE8T1+5YvM/xn0P+9bs/3ZqIIgVftvMTWjE=
X-Received: by 2002:a5d:6886:: with SMTP id h6mr2400952wru.154.1575900678574; 
 Mon, 09 Dec 2019 06:11:18 -0800 (PST)
MIME-Version: 1.0
References: <20191209014218.29887-1-evan.quan@amd.com>
In-Reply-To: <20191209014218.29887-1-evan.quan@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 9 Dec 2019 09:11:06 -0500
Message-ID: <CADnq5_OboC0VsuydrU=BxCYw8M-kBJYbFjyQtjuyGCptbL=Cfw@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/powerplay: clear VBIOS scratchs on baco exit V2
To: Evan Quan <evan.quan@amd.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc;
 bh=dWDV5bloSY1V8imvQgadGmbq8x5hKh1veDr6LGXRMA8=;
 b=VZdGMseOTBRbHjKd7Yw/ff3XKD8nlywTIKUEfCFJOtSGbmI6Q/5kFZPwLROsa7tvPy
 drNutlonG1EvL1FszPqVP+lr0H9/IcKSv4aDKDocFJ5pZZI+bVdsnQlGJb184T3BVUSR
 Qq49mjuBtIzAP1cUfw7dpdiPViSTJBac+CkjRV4Z91oD8fZGG3Dp+e9yb+VBpsCyEqxK
 EGJPz5ErXwsey+YBLYT6EWPrQgKZpB7tNGpGqGVZb/mUWyZAf01S9fNyGO1AS4QqcRiL
 PAxV5pGf/XG+Znwe9UaF4sRrHM8XwnTyX6mU+VcVqe8bSK2A0DP0d0nFEDFQ6U0bpUVq
 LptQ==
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
Cc: "Deucher, Alexander" <alexander.deucher@amd.com>, Zhigang.Luo@amd.com,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Hawking Zhang <hawking.zhang@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gU3VuLCBEZWMgOCwgMjAxOSBhdCA4OjQyIFBNIEV2YW4gUXVhbiA8ZXZhbi5xdWFuQGFtZC5j
b20+IHdyb3RlOgo+Cj4gVGhpcyBpcyBuZWVkZWQgZm9yIGNvbWluZyBhc2ljIGluaXQgb24gcGVy
Zm9ybWluZyBncHUgcmVzZXQuCj4KPiBWMjogdXNlIG5vbi1hc2ljIHNwZWNpZmljIHByb2dyYW1p
bmcgd2F5Cj4KPiBDaGFuZ2UtSWQ6IElmMzY3MWEyNGQyMzllM2QyODg2NjVmYWRhYTJjNDBjODdk
NWRhNDBiCj4gU2lnbmVkLW9mZi1ieTogRXZhbiBRdWFuIDxldmFuLnF1YW5AYW1kLmNvbT4KClJl
dmlld2VkLWJ5OiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+Cgo+IC0t
LQo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9zbXVfdjExXzAuYyB8IDcgKysrKysr
Kwo+ICAxIGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCspCj4KPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvc211X3YxMV8wLmMgYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL3Bvd2VycGxheS9zbXVfdjExXzAuYwo+IGluZGV4IGY1NDY5YWQ0MzkyOS4uNzc4MWQyNDVm
OGVmIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L3NtdV92MTFf
MC5jCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvc211X3YxMV8wLmMKPiBA
QCAtMTY3NiwxMCArMTY3NiwxNyBAQCBpbnQgc211X3YxMV8wX2JhY29fc2V0X3N0YXRlKHN0cnVj
dCBzbXVfY29udGV4dCAqc211LCBlbnVtIHNtdV9iYWNvX3N0YXRlIHN0YXRlKQo+ICAgICAgICAg
ICAgICAgICB9Cj4gICAgICAgICB9IGVsc2Ugewo+ICAgICAgICAgICAgICAgICByZXQgPSBzbXVf
c2VuZF9zbWNfbXNnKHNtdSwgU01VX01TR19FeGl0QmFjbyk7Cj4gKyAgICAgICAgICAgICAgIGlm
IChyZXQpCj4gKyAgICAgICAgICAgICAgICAgICAgICAgZ290byBvdXQ7Cj4gKwo+ICAgICAgICAg
ICAgICAgICBiaWZfZG9vcmJlbGxfaW50cl9jbnRsID0gUkVHX1NFVF9GSUVMRChiaWZfZG9vcmJl
bGxfaW50cl9jbnRsLAo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIEJJRl9ET09SQkVMTF9JTlRfQ05UTCwKPiAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBET09SQkVMTF9JTlRFUlJVUFRfRElTQUJMRSwgMCk7Cj4g
ICAgICAgICAgICAgICAgIFdSRUczMl9TT0MxNShOQklPLCAwLCBtbUJJRl9ET09SQkVMTF9JTlRf
Q05UTCwgYmlmX2Rvb3JiZWxsX2ludHJfY250bCk7Cj4gKwo+ICsgICAgICAgICAgICAgICAvKiBj
bGVhciB2YmlvcyBzY3JhdGNoIDYgYW5kIDcgZm9yIGNvbWluZyBhc2ljIHJlaW5pdCAqLwo+ICsg
ICAgICAgICAgICAgICBXUkVHMzIoYWRldi0+Ymlvc19zY3JhdGNoX3JlZ19vZmZzZXQgKyA2LCAw
KTsKPiArICAgICAgICAgICAgICAgV1JFRzMyKGFkZXYtPmJpb3Nfc2NyYXRjaF9yZWdfb2Zmc2V0
ICsgNywgMCk7Cj4gICAgICAgICB9Cj4gICAgICAgICBpZiAocmV0KQo+ICAgICAgICAgICAgICAg
ICBnb3RvIG91dDsKPiAtLQo+IDIuMjQuMAo+Cj4gX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KPiBhbWQtZ2Z4IG1haWxpbmcgbGlzdAo+IGFtZC1nZnhAbGlz
dHMuZnJlZWRlc2t0b3Aub3JnCj4gaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1h
bi9saXN0aW5mby9hbWQtZ2Z4Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Au
b3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdm
eA==
