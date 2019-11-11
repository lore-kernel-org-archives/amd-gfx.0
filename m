Return-Path: <SRS0=+iNy=ZD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0691FC43331
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Nov 2019 22:39:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7E4621872
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Nov 2019 22:39:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7E4621872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A95B6E31E;
	Mon, 11 Nov 2019 22:39:51 +0000 (UTC)
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com
 [IPv6:2a00:1450:4864:20::342])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 769DB6E0A2;
 Mon, 11 Nov 2019 22:39:49 +0000 (UTC)
Received: by mail-wm1-x342.google.com with SMTP id l1so1027012wme.2;
 Mon, 11 Nov 2019 14:39:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=kLZzRK49xDavb9wz9Sf4AjD14pe2l4fvkbkWyRvqJ9M=;
 b=OpxQOId96gRgNLU5WGoK5T1kBV5SevaR0jjwE2chi/c1aIEbdWGLw7p4aa/gu6XxY0
 rw9SxI2nczh3HNp6glkREX0ch94W5lGemCwxqB9pbytA10YzBt4aVwKFzxg8+ERiFbYw
 Cxs0ms0v2fGF+zY9A4pTmyK9kOCXulhXXgn52vMOXk7brQQHIE2HdkjCPKf0EmX267R2
 zYDAfq9eleqvhM982fdRKjg5pFblvznDbGqf77aV9LAUr+m0LyViV9bbabYon2KUexfc
 JlmK2OJA72jNrCwGihwYeRCgMaYgdPOXTeFI87owJFtFfZNuvKWKV78n/ptm5KoWelXs
 pRXg==
X-Gm-Message-State: APjAAAXsv+DaVndnBlUyUIEAgG0D+pTaN4vj6ccwSCRXfYfXtxaARu62
 EQGX9KPTqNjywuDJ33fh7Xx0vdUIhBM0BfwwibU=
X-Google-Smtp-Source: APXvYqz+tmuJK+8UMO293AmQSmsTISo+DNCWj9/FOQWAl3qhe7Xq8Jc6y5Cy2acisbs754yH/eX41FMkrx0gHYnlKHc=
X-Received: by 2002:a1c:41c2:: with SMTP id o185mr1037425wma.34.1573511988047; 
 Mon, 11 Nov 2019 14:39:48 -0800 (PST)
MIME-Version: 1.0
References: <20191111172543.GA31748@embeddedor>
 <b5b41653-3536-b0f0-2f49-2c010370ec99@amd.com>
 <cf7d4cfe-be29-39d8-8a5e-bac217475597@embeddedor.com>
In-Reply-To: <cf7d4cfe-be29-39d8-8a5e-bac217475597@embeddedor.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 11 Nov 2019 17:39:34 -0500
Message-ID:
 <CADnq5_NmfCaQ=6to+ng81=qV0mp7Vo-ugKPTF__5JMAmjP13Kw@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Fix unsigned variable compared to less
 than zero
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc;
 bh=kLZzRK49xDavb9wz9Sf4AjD14pe2l4fvkbkWyRvqJ9M=;
 b=VZXuhxfCsYqJHeAAZWi8U4wsj49O2BkOkmkDNoQod5eOhXrb0FI6MPWtiONK3lEHIC
 g6EgrDgHM4QqZWIG1URCW42d7CaCrN/dTtkea5oO3HRXepParhfR+8mTgj+SUhB5SlsD
 cpUat5dlYyBH/Nn5g/Jhc22m++/wA4M0LInFkqytUm3CoUi0Yxcsy45ybiRGJWBRMI2t
 y60LN80clF+fH2hFqNLvnYKd2jd6Iwf86ZmKY+VHhQj8GS5qU6SlVR+0qDEyggoLishn
 4N2jfW8fYOulcywjy1p69/IHUErRea8Vc3YugI4Qi0mE6fktdQjMW3MYugVNHmzgmM+M
 JVeA==
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
Cc: "David \(ChunMing\) Zhou" <David1.Zhou@amd.com>,
 Mikita Lipski <mikita.lipski@amd.com>, Leo Li <sunpeng.li@amd.com>,
 LKML <linux-kernel@vger.kernel.org>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 David Airlie <airlied@linux.ie>, amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 Mikita Lipski <mlipski@amd.com>, Harry Wentland <harry.wentland@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191111223934.Tif59YSeMpjeX9tcPYjn0KjYrLEAZmkMaEa4miioXhQ@z>

QXBwbGllZC4gIFRoYW5rcyEKCkFsZXgKCk9uIE1vbiwgTm92IDExLCAyMDE5IGF0IDI6NDQgUE0g
R3VzdGF2byBBLiBSLiBTaWx2YQo8Z3VzdGF2b0BlbWJlZGRlZG9yLmNvbT4gd3JvdGU6Cj4KPgo+
Cj4gT24gMTEvMTEvMTkgMTE6NDYsIE1pa2l0YSBMaXBza2kgd3JvdGU6Cj4gPgo+ID4gVGhhbmtz
IGZvciBjYXRjaGluZyBpdCEKPiA+Cj4KPiBHbGFkIHRvIGhlbHAgb3V0LiA6KQo+Cj4gPiBSZXZp
ZXdlZC1ieTogTWlraXRhIExpcHNraSA8bWlraXRhLmxpcHNraUBhbWQuY29tPgo+ID4KPgo+IFRo
YW5rcwo+IC0tCj4gR3VzdGF2bwo+Cj4gPgo+ID4gT24gMTEuMTEuMjAxOSAxMjoyNSwgR3VzdGF2
byBBLiBSLiBTaWx2YSB3cm90ZToKPiA+PiBDdXJyZW5seSwgdGhlIGVycm9yIGNoZWNrIGJlbG93
IG9uIHZhcmlhYmxlKnZjcGlfc2xvdHMqICBpcyBhbHdheXMKPiA+PiBmYWxzZSBiZWNhdXNlIGl0
IGlzIGEgdWludDY0X3QgdHlwZSB2YXJpYWJsZSwgaGVuY2UsIHRoZSB2YWx1ZXMKPiA+PiB0aGlz
IHZhcmlhYmxlIGNhbiBob2xkIGFyZSBuZXZlciBsZXNzIHRoYW4gemVybzoKPiA+Pgo+ID4+IGRy
aXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtLmM6Cj4gPj4gNDg3
MCAgICAgICAgIGlmIChkbV9uZXdfY29ubmVjdG9yX3N0YXRlLT52Y3BpX3Nsb3RzIDwgMCkgewo+
ID4+IDQ4NzEgICAgICAgICAgICAgICAgIERSTV9ERUJVR19BVE9NSUMoImZhaWxlZCBmaW5kaW5n
IHZjcGkgc2xvdHM6ICVkXG4iLCAoaW50KWRtX25ld19jb25uZWN0b3Jfc3RhdCAgICAgZS0+dmNw
aV9zbG90cyk7Cj4gPj4gNDg3MiAgICAgICAgICAgICAgICAgcmV0dXJuIGRtX25ld19jb25uZWN0
b3Jfc3RhdGUtPnZjcGlfc2xvdHM7Cj4gPj4gNDg3MyAgICAgICAgIH0KPiA+Pgo+ID4+IEZpeCB0
aGlzIGJ5IG1ha2luZyp2Y3BpX3Nsb3RzKiAgb2YgaW50IHR5cGUKPiA+Pgo+ID4+IEFkZHJlc3Nl
cy1Db3Zlcml0eTogMTQ4NzgzOCAoIlVuc2lnbmVkIGNvbXBhcmVkIGFnYWluc3QgMCIpCj4gPj4g
Rml4ZXM6IGI0YzU3OGYwODM3OCAoImRybS9hbWQvZGlzcGxheTogQWRkIE1TVCBhdG9taWMgcm91
dGluZXMiKQo+ID4+IFNpZ25lZC1vZmYtYnk6IEd1c3Rhdm8gQS4gUi4gU2lsdmE8Z3VzdGF2b0Bl
bWJlZGRlZG9yLmNvbT4KPiA+PiAtLS0KPiA+PiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxh
eS9hbWRncHVfZG0vYW1kZ3B1X2RtLmggfCAyICstCj4gPj4gICAxIGZpbGUgY2hhbmdlZCwgMSBp
bnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKPiA+Pgo+ID4+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbS5oIGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG0uaAo+ID4+IGluZGV4IDZkYjA3ZTll
MzNhYi4uYThmYzkwYTkyN2Q2IDEwMDY0NAo+ID4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQv
ZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtLmgKPiA+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbS5oCj4gPj4gQEAgLTQwMyw3ICs0MDMsNyBA
QCBzdHJ1Y3QgZG1fY29ubmVjdG9yX3N0YXRlIHsKPiA+PiAgICAgICBib29sIHVuZGVyc2Nhbl9l
bmFibGU7Cj4gPj4gICAgICAgYm9vbCBmcmVlc3luY19jYXBhYmxlOwo+ID4+ICAgICAgIHVpbnQ4
X3QgYWJtX2xldmVsOwo+ID4+IC0gICAgdWludDY0X3QgdmNwaV9zbG90czsKPiA+PiArICAgIGlu
dCB2Y3BpX3Nsb3RzOwo+ID4+ICAgICAgIHVpbnQ2NF90IHBibjsKPiA+PiAgIH07Cj4gPj4gICAt
LSAyLjIzLjAKPiA+Cj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KPiBhbWQtZ2Z4IG1haWxpbmcgbGlzdAo+IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Au
b3JnCj4gaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQt
Z2Z4Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1n
ZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
