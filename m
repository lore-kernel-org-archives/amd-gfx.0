Return-Path: <SRS0=dvhx=GP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E077FC433DB
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Jan 2021 22:02:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B9CF221F5
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Jan 2021 22:02:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B9CF221F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0862189686;
	Tue, 12 Jan 2021 22:02:45 +0000 (UTC)
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com
 [IPv6:2607:f8b0:4864:20::22d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 93B4089686;
 Tue, 12 Jan 2021 22:02:44 +0000 (UTC)
Received: by mail-oi1-x22d.google.com with SMTP id w124so4005109oia.6;
 Tue, 12 Jan 2021 14:02:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=dQg8a7px4gZR/qy/5yROX2E3vzwuloy80ww+ooRg+oY=;
 b=V7MK5RWBjVPhkzQI5Ciohny7aSt5wuWIMAAdlUUAxUTdpdXE84xltsebu9uePExYVs
 Sh0kSGjpmpOg0/RXJf5Lf5LIbM88Y7eUDVp6U97Aa2IMUcw1JJt09uCkJbTaXQYTPnfp
 5rE5R3mY4yU/VQInfxYJzMANn07IIDE8vL1be0STAbzmEjyMtfOErw8IYjlAfimVZEhE
 S8X+35i8kSmcJ6MsEIpU0tbO/nV2NR2WcTqSgY3qn6H/puQXpwr0t60uw+sjGeC56UJS
 4G7gAPdST3PASQoWGEi2LJMXsXS44k+QSVfZSq0Hy98yWgpiQjo17TOAovzqUXzuBtHS
 GstA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=dQg8a7px4gZR/qy/5yROX2E3vzwuloy80ww+ooRg+oY=;
 b=CgLR4QVbvqjTgmXsspdw0uPn+cJURDSfp6XcnwtcwDeURPBqgduzGdzkWeo/mPPar8
 DWl9o/Vw8ocuNEVqBvMmxxNhqPqN1iVT/YGSyt5SMBOB+L1YDibfU7+xTKSLjUEZ3rIJ
 9p6lXhi1eWkC9HLNQQYxbYFGDxWaEkJkXavPcvlEXTf5XLHJWDXf9L14TkaRSViFlJ0R
 WxX9TxUz9aI1stGaoA7Q4s2OI1mLLynShLYph/MCIIzD0i+jq563PThCgPF1lHw7EIC2
 VgppSpLHI4rmBq50n3ubyXjLwhYkosELiDSGMK/yC0nbb4zh9FY6DfUNbZ7G+CNnZ5fh
 rixA==
X-Gm-Message-State: AOAM531GhsSN8EUyLkRZvkkuUwsx3QmTt+IqxajZvmPCJMTw6Ltv5AO+
 cDdajDA+fxaQfavzkWsIL8XMNNHRj8Eg8nujqmw=
X-Google-Smtp-Source: ABdhPJww3KSAQqBOT3L9pjJDFilmrp/0IWHhhvANV0yloyuHZIb//XmTUxkQdJt4V8X3WGRRvr++pagt9iZf6RpnxMY=
X-Received: by 2002:aca:6202:: with SMTP id w2mr737362oib.5.1610488963899;
 Tue, 12 Jan 2021 14:02:43 -0800 (PST)
MIME-Version: 1.0
References: <20210111191926.3688443-1-lee.jones@linaro.org>
 <20210111191926.3688443-8-lee.jones@linaro.org>
In-Reply-To: <20210111191926.3688443-8-lee.jones@linaro.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 12 Jan 2021 17:02:33 -0500
Message-ID: <CADnq5_OAU8-hzqV3iEg7ees3vRv6Uh1tYaA+FJQE3TDK_ZL4Eg@mail.gmail.com>
Subject: Re: [PATCH 07/40] drm/amd/display/dc/irq/irq_service: Make local
 function static
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
Cc: Leo Li <sunpeng.li@amd.com>, Mauro Rossi <issor.oruam@gmail.com>,
 LKML <linux-kernel@vger.kernel.org>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 David Airlie <airlied@linux.ie>, amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gTW9uLCBKYW4gMTEsIDIwMjEgYXQgMjoxOSBQTSBMZWUgSm9uZXMgPGxlZS5qb25lc0BsaW5h
cm8ub3JnPiB3cm90ZToKPgo+IEZpeGVzIHRoZSBmb2xsb3dpbmcgVz0xIGtlcm5lbCBidWlsZCB3
YXJuaW5nKHMpOgo+Cj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1Ly4uL2Rpc3BsYXkvZGMv
aXJxL2lycV9zZXJ2aWNlLmM6ODI6MzE6IHdhcm5pbmc6IG5vIHByZXZpb3VzIHByb3RvdHlwZSBm
b3Ig4oCYZmluZF9pcnFfc291cmNlX2luZm/igJkgWy1XbWlzc2luZy1wcm90b3R5cGVzXQo+Cj4g
Q2M6IEhhcnJ5IFdlbnRsYW5kIDxoYXJyeS53ZW50bGFuZEBhbWQuY29tPgo+IENjOiBMZW8gTGkg
PHN1bnBlbmcubGlAYW1kLmNvbT4KPiBDYzogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hl
ckBhbWQuY29tPgo+IENjOiAiQ2hyaXN0aWFuIEvDtm5pZyIgPGNocmlzdGlhbi5rb2VuaWdAYW1k
LmNvbT4KPiBDYzogRGF2aWQgQWlybGllIDxhaXJsaWVkQGxpbnV4LmllPgo+IENjOiBEYW5pZWwg
VmV0dGVyIDxkYW5pZWxAZmZ3bGwuY2g+Cj4gQ2M6IE1hdXJvIFJvc3NpIDxpc3Nvci5vcnVhbUBn
bWFpbC5jb20+Cj4gQ2M6IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4gQ2M6IGRyaS1k
ZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPiBTaWduZWQtb2ZmLWJ5OiBMZWUgSm9uZXMgPGxl
ZS5qb25lc0BsaW5hcm8ub3JnPgoKQXBwbGllZC4gIFRoYW5rcyEKCkFsZXgKCj4gLS0tCj4gIGRy
aXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9pcnEvaXJxX3NlcnZpY2UuYyB8IDIgKy0KPiAg
MSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCj4KPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2lycS9pcnFfc2VydmljZS5jIGIv
ZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2lycS9pcnFfc2VydmljZS5jCj4gaW5kZXgg
NmJmMjdiZGU4NzI0MC4uNWYyNDViZGU1NGZmNyAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL2Rpc3BsYXkvZGMvaXJxL2lycV9zZXJ2aWNlLmMKPiArKysgYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL2Rpc3BsYXkvZGMvaXJxL2lycV9zZXJ2aWNlLmMKPiBAQCAtNzksNyArNzksNyBAQCB2
b2lkIGRhbF9pcnFfc2VydmljZV9kZXN0cm95KHN0cnVjdCBpcnFfc2VydmljZSAqKmlycV9zZXJ2
aWNlKQo+ICAgICAgICAgKmlycV9zZXJ2aWNlID0gTlVMTDsKPiAgfQo+Cj4gLWNvbnN0IHN0cnVj
dCBpcnFfc291cmNlX2luZm8gKmZpbmRfaXJxX3NvdXJjZV9pbmZvKAo+ICtzdGF0aWMgY29uc3Qg
c3RydWN0IGlycV9zb3VyY2VfaW5mbyAqZmluZF9pcnFfc291cmNlX2luZm8oCj4gICAgICAgICBz
dHJ1Y3QgaXJxX3NlcnZpY2UgKmlycV9zZXJ2aWNlLAo+ICAgICAgICAgZW51bSBkY19pcnFfc291
cmNlIHNvdXJjZSkKPiAgewo+IC0tCj4gMi4yNS4xCj4KPiBfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwo+IGRyaS1kZXZlbCBtYWlsaW5nIGxpc3QKPiBkcmkt
ZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4gaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5v
cmcvbWFpbG1hbi9saXN0aW5mby9kcmktZGV2ZWwKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5m
cmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0
aW5mby9hbWQtZ2Z4Cg==
