Return-Path: <SRS0=PoT7=EI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F07A9C2D0A3
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Nov 2020 18:53:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82E8D2225E
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Nov 2020 18:53:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TvhbUcHS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82E8D2225E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D22386E50C;
	Mon,  2 Nov 2020 18:53:32 +0000 (UTC)
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com
 [IPv6:2a00:1450:4864:20::443])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA2B56E56D
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Nov 2020 18:53:31 +0000 (UTC)
Received: by mail-wr1-x443.google.com with SMTP id a9so15807458wrg.12
 for <amd-gfx@lists.freedesktop.org>; Mon, 02 Nov 2020 10:53:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=XOj8gFfm1ideDIiibSULGbthlGkHZJtNJ/8uVVbPAsw=;
 b=TvhbUcHSRKd14qowEd1+TuDhSnES34TXLbmPujaiKgLTwOjgFNfAG8/b0CEPzwvjf2
 wvUw+dC3Dku+QnhgaLBGSh7CxhCV0Cg14TvYWeJoQoECxJ4nQpFcLgd3dcxtRitbVAON
 qPE2yDT/nGlN8fEEJuoUcsMTHoeWMzRnp6rBfxCMqp4/XnjFPhW2z/c7XcKDg4f6JKh/
 Dhu4DbOS9LFuedxsQEbmYHNZTKZq8u8NhUNuZIl85DGHuqiXDvcQJ7LZGrSnWmcIkWxi
 FnpJUPj6Vf77nkCPZOl8jdq2M4gqEfPik0x/ncy10Ray0cuYUtlLl8r1nxr9IeqqKKYL
 RczQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=XOj8gFfm1ideDIiibSULGbthlGkHZJtNJ/8uVVbPAsw=;
 b=GxkKRCLlwWLrKBDAKawi0AUZNh/NL5Rp1EYfzJsm7Q1B0rCv/KpYZgR4Vufi3M7hGb
 W9Q62ETfyhWo389QpHTBVysJkFLtLBnqzMd0sXooqfhw5v1M8+Rgo3/KGbpqfxHTUztv
 bKlJELlasr/ve9f7kBA6GHqFW+GasH+1EXGBtxp5VsKovphxeRzTdoXIK/N7i9JFStzt
 pIhpKta5EEXXiCr+isYejdqYHosPkDvY67tdf2FtzoYW5unYrQEH6oGQM6J0ySQwGi3w
 VyK/XAomfrY06+SxslvMMJNP/i2ihz8ebneH7bLm+fnaokiYYq8nBdE3c54V5qdXljzx
 dYvA==
X-Gm-Message-State: AOAM5319aDoWBiPsdZ5yc60yCwuQSodZc0s3ECiChUIvgnR63dMSTnO2
 HLb3e69a2itw2/s/VOz375xx+Lfk0O+5lZk8uSs=
X-Google-Smtp-Source: ABdhPJylU11CSLdQ95TxEQdLoEgwez0ofhqzCcFdVR2dxwiZB+UiJ0bEQ+3ZcihLcPrXAqbUlqQzvWnxsmMd/kQq05Y=
X-Received: by 2002:adf:f246:: with SMTP id b6mr21630733wrp.111.1604343210537; 
 Mon, 02 Nov 2020 10:53:30 -0800 (PST)
MIME-Version: 1.0
References: <20201102113353.1422-1-christian.koenig@amd.com>
 <20201102113353.1422-2-christian.koenig@amd.com>
In-Reply-To: <20201102113353.1422-2-christian.koenig@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 2 Nov 2020 13:53:18 -0500
Message-ID: <CADnq5_PfY=f9gC6pEu-xzO_Z-Z1ggnW5UrR56oh9e4z96MYNBA@mail.gmail.com>
Subject: Re: [PATCH 2/3] drm/amdgpu: enabled software IH ring for Vega
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
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
Cc: "Kuehling, Felix" <felix.kuehling@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gTW9uLCBOb3YgMiwgMjAyMCBhdCA2OjM0IEFNIENocmlzdGlhbiBLw7ZuaWcKPGNrb2VuaWcu
bGVpY2h0enVtZXJrZW5AZ21haWwuY29tPiB3cm90ZToKPgo+IFNlZW1zIGxpa2Ugd2Ugd29uJ3Qg
Z2V0IHRoZSBoYXJkd2FyZSBJSDEvMiByaW5ncyBvbiBWZWdhMjAgd29ya2luZy4KPgo+IFNpZ25l
ZC1vZmYtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KPiAt
LS0KPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvdmVnYTEwX2loLmMgfCA3ICsrKysrKysK
PiAgMSBmaWxlIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3ZlZ2ExMF9paC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvdmVnYTEwX2loLmMKPiBpbmRleCA0MDdjNjA5M2MyZWMuLmNlZjYxZGQ0NmEzNyAxMDA2
NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS92ZWdhMTBfaWguYwo+ICsrKyBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3ZlZ2ExMF9paC5jCj4gQEAgLTkxLDYgKzkxLDkg
QEAgc3RhdGljIHZvaWQgdmVnYTEwX2loX2VuYWJsZV9pbnRlcnJ1cHRzKHN0cnVjdCBhbWRncHVf
ZGV2aWNlICphZGV2KQo+ICAgICAgICAgICAgICAgICB9Cj4gICAgICAgICAgICAgICAgIGFkZXYt
PmlycS5paDIuZW5hYmxlZCA9IHRydWU7Cj4gICAgICAgICB9Cj4gKwo+ICsgICAgICAgaWYgKGFk
ZXYtPmlycS5paF9zb2Z0LnJpbmdfc2l6ZSkKPiArICAgICAgICAgICAgICAgYWRldi0+aXJxLmlo
X3NvZnQuZW5hYmxlZCA9IHRydWU7Cj4gIH0KPgo+ICAvKioKPiBAQCAtNjA2LDYgKzYwOSwxMCBA
QCBzdGF0aWMgaW50IHZlZ2ExMF9paF9zd19pbml0KHZvaWQgKmhhbmRsZSkKPiAgICAgICAgIGFk
ZXYtPmlycS5paDIudXNlX2Rvb3JiZWxsID0gdHJ1ZTsKPiAgICAgICAgIGFkZXYtPmlycS5paDIu
ZG9vcmJlbGxfaW5kZXggPSAoYWRldi0+ZG9vcmJlbGxfaW5kZXguaWggKyAyKSA8PCAxOwo+Cj4g
KyAgICAgICByID0gYW1kZ3B1X2loX3JpbmdfaW5pdChhZGV2LCAmYWRldi0+aXJxLmloX3NvZnQs
IFBBR0VfU0laRSwgdHJ1ZSk7Cj4gKyAgICAgICBpZiAocikKPiArICAgICAgICAgICAgICAgcmV0
dXJuIHI7Cj4gKwoKU2hvdWxkIHdlIG9ubHkgZW5hYmxlIHRoaXMgb24gdmVnYTIwPwoKQWxleAoK
Cj4gICAgICAgICByID0gYW1kZ3B1X2lycV9pbml0KGFkZXYpOwo+Cj4gICAgICAgICByZXR1cm4g
cjsKPiAtLQo+IDIuMjUuMQo+Cj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KPiBhbWQtZ2Z4IG1haWxpbmcgbGlzdAo+IGFtZC1nZnhAbGlzdHMuZnJlZWRl
c2t0b3Aub3JnCj4gaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5m
by9hbWQtZ2Z4Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBz
Oi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
