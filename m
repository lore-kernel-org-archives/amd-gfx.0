Return-Path: <SRS0=+iNy=ZD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A91A8C43331
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Nov 2019 17:35:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86420214DB
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Nov 2019 17:35:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86420214DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 410BD6E996;
	Mon, 11 Nov 2019 17:35:26 +0000 (UTC)
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB97C6E996;
 Mon, 11 Nov 2019 17:35:24 +0000 (UTC)
Received: by mail-wr1-x442.google.com with SMTP id i10so15560343wrs.7;
 Mon, 11 Nov 2019 09:35:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=6Hr0XZ+W95Fq8mqP7g5xaelC6Vx3m15yqOwH0Jnse00=;
 b=MwczHsIO88S1yislvKPAN/5f/6c0QQ8IgsS8/k989fmdonSD41g11ihJlPuR2ESH6S
 aqM6fkUWYog8F64nOJk+6K/gXwKYQMzsszjiZp1kK2P+w5KUIU72wmBuHhnaM9ZKkBeh
 yoZFL+4FxP2gVlSVmmOviPoQ7a6dZ9HJ2LoTKgRw5oQjsLw9tkmkJVuf2GNgcdGWGwKL
 Fr3iwM8GIsL6AVshTaNwVJRSD3sGJn4k525t+LmLj8N1ioyvtCfRPme9g2p/zTUqJfAO
 hov/7XyHaZnVJS5FA8tJ9RXuFjOGfjaq5xCGCy6jwz/M55vLXnVGa6DhpqrFodVEUUNu
 LQ9Q==
X-Gm-Message-State: APjAAAWgnlW+H759E7BIRDknZ5pDOm9W/mYVfUnaZAEvtMWjo1CZIBbS
 kxqS+f1hvRuRFPBo9enOrTqz1/UD279zckE/Do04aA==
X-Google-Smtp-Source: APXvYqweEiabjLuuO8H9HV68rYsXJ4G5OK+vh51GktRkh2PtT8iyT8F9Kc+znoIEOavWyTstNfVv2xS3Cb9ocnbXU8Q=
X-Received: by 2002:adf:fb0b:: with SMTP id c11mr22736594wrr.50.1573493723544; 
 Mon, 11 Nov 2019 09:35:23 -0800 (PST)
MIME-Version: 1.0
References: <20191109154921.223093-1-colin.king@canonical.com>
 <0700f347-8590-7ab7-411d-0ae08fe9263d@amd.com>
In-Reply-To: <0700f347-8590-7ab7-411d-0ae08fe9263d@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 11 Nov 2019 12:35:10 -0500
Message-ID:
 <CADnq5_MKFh3v+qnjO-bmpepTc_XTgEKTomP0PLRJu==_UBTkZA@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: remove duplicated comparison expression
To: "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc;
 bh=6Hr0XZ+W95Fq8mqP7g5xaelC6Vx3m15yqOwH0Jnse00=;
 b=e2Ew9GMfSUxRzx7YWxu6vGIT1uYNAUiOY9ivjlvAsecN6phDGzODfdsbD3pacZtgIq
 1TKhZPVClxclFXrKxi25zD6ZguKi/bxPme4O5nqEjs9Q/EuaddiWwchMpHQb4ojeFI/W
 +Z8KsqOocqbBsBqH/WUX8mpC/R2cj9PNBzLMkYizXe+M9L/QoTtzf4sJIFvMn3IUVcS8
 1EPUUP/83jBAkAMU+kWNau2TxKgnEBfFfMdmTTvesmByRZfObnz5YIBcC1VOeqr71tgR
 /dL6GhxmlSceWOMaL0mWSis4LnTwXehs8BaBwdsQw9+50FGstcjrZ07Acb24dJ41ZJhT
 i2jA==
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
Cc: David Zhou <David1.Zhou@amd.com>, Charlene Liu <Charlene.Liu@amd.com>,
 Leo Li <sunpeng.li@amd.com>, kernel-janitors@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, David Airlie <airlied@linux.ie>,
 Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 Colin King <colin.king@canonical.com>, Harry Wentland <harry.wentland@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191111173510.eogtaAf2fBdqWcqT5RmNFmiglaSI4Hpn5EDlOViZYCw@z>

QXBwbGllZC4gIFRoYW5rcyEKCkFsZXgKCk9uIE1vbiwgTm92IDExLCAyMDE5IGF0IDg6MzggQU0g
S2F6bGF1c2thcywgTmljaG9sYXMKPG5pY2hvbGFzLmthemxhdXNrYXNAYW1kLmNvbT4gd3JvdGU6
Cj4KPiBPbiAyMDE5LTExLTA5IDEwOjQ5IGEubS4sIENvbGluIEtpbmcgd3JvdGU6Cj4gPiBGcm9t
OiBDb2xpbiBJYW4gS2luZyA8Y29saW4ua2luZ0BjYW5vbmljYWwuY29tPgo+ID4KPiA+IFRoZXJl
IGlzIGNvbXBhcmlzb24gZXhwcmVzc2lvbiB0aGF0IGlzIGR1cGxpY2F0ZWQgYW5kIGhlbmNlIG9u
ZQo+ID4gb2YgdGhlIGV4cHJlc3Npb25zIGNhbiBiZSByZW1vdmVkLiAgUmVtb3ZlIGl0Lgo+ID4K
PiA+IEFkZHJlc3Nlcy1Db3Zlcml0eTogKCJTYW1lIG9uIGJvdGggc2lkZXMiKQo+ID4gRml4ZXM6
IDEyZTJiMmQ0YzY1ZiAoImRybS9hbWQvZGlzcGxheTogYWRkIGRjYyBwcm9ncmFtbWluZyBmb3Ig
ZHVhbCBwbGFuZSIpCj4gPiBTaWduZWQtb2ZmLWJ5OiBDb2xpbiBJYW4gS2luZyA8Y29saW4ua2lu
Z0BjYW5vbmljYWwuY29tPgo+Cj4gUmV2aWV3ZWQtYnk6IE5pY2hvbGFzIEthemxhdXNrYXMgPG5p
Y2hvbGFzLmthemxhdXNrYXNAYW1kLmNvbT4KPgo+IFRoYW5rcyEKPgo+IE5pY2hvbGFzIEthemxh
dXNrYXMKPgo+ID4gLS0tCj4gPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9jb3Jl
L2RjLmMgfCAxIC0KPiA+ICAgMSBmaWxlIGNoYW5nZWQsIDEgZGVsZXRpb24oLSkKPiA+Cj4gPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2NvcmUvZGMuYyBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9jb3JlL2RjLmMKPiA+IGluZGV4IDFmZGJhMTNi
M2QwZi4uMWZhMjU1ZTA3N2QwIDEwMDY0NAo+ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9k
aXNwbGF5L2RjL2NvcmUvZGMuYwo+ID4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5
L2RjL2NvcmUvZGMuYwo+ID4gQEAgLTE0OTEsNyArMTQ5MSw2IEBAIHN0YXRpYyBlbnVtIHN1cmZh
Y2VfdXBkYXRlX3R5cGUgZ2V0X3BsYW5lX2luZm9fdXBkYXRlX3R5cGUoY29uc3Qgc3RydWN0IGRj
X3N1cmZhCj4gPiAgICAgICB9Cj4gPgo+ID4gICAgICAgaWYgKHUtPnBsYW5lX2luZm8tPnBsYW5l
X3NpemUuc3VyZmFjZV9waXRjaCAhPSB1LT5zdXJmYWNlLT5wbGFuZV9zaXplLnN1cmZhY2VfcGl0
Y2gKPiA+IC0gICAgICAgICAgICAgICAgICAgICB8fCB1LT5wbGFuZV9pbmZvLT5wbGFuZV9zaXpl
LnN1cmZhY2VfcGl0Y2ggIT0gdS0+c3VyZmFjZS0+cGxhbmVfc2l6ZS5zdXJmYWNlX3BpdGNoCj4g
PiAgICAgICAgICAgICAgICAgICAgICAgfHwgdS0+cGxhbmVfaW5mby0+cGxhbmVfc2l6ZS5jaHJv
bWFfcGl0Y2ggIT0gdS0+c3VyZmFjZS0+cGxhbmVfc2l6ZS5jaHJvbWFfcGl0Y2gpIHsKPiA+ICAg
ICAgICAgICAgICAgdXBkYXRlX2ZsYWdzLT5iaXRzLnBsYW5lX3NpemVfY2hhbmdlID0gMTsKPiA+
ICAgICAgICAgICAgICAgZWxldmF0ZV91cGRhdGVfdHlwZSgmdXBkYXRlX3R5cGUsIFVQREFURV9U
WVBFX01FRCk7Cj4gPgo+Cj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KPiBhbWQtZ2Z4IG1haWxpbmcgbGlzdAo+IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0
b3Aub3JnCj4gaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9h
bWQtZ2Z4Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFt
ZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8v
bGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
