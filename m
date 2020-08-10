Return-Path: <SRS0=gp3V=BU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D6E3C433DF
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Aug 2020 21:15:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 599FC20716
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Aug 2020 21:15:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k4HUFyf+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 599FC20716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F16589973;
	Mon, 10 Aug 2020 21:15:58 +0000 (UTC)
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1CF1089973;
 Mon, 10 Aug 2020 21:15:57 +0000 (UTC)
Received: by mail-wr1-x444.google.com with SMTP id z18so9488129wrm.12;
 Mon, 10 Aug 2020 14:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=+iG0rPie0hGjlqBkimyNljZ85YQMu0uvsdwoC84m+No=;
 b=k4HUFyf+BceKxHAdT4A8JrLP35Ktd/vLhR11JAVViOn3b5YEPr+PgGF4NDrE0X0F9g
 EtK3inRncxd4qoQQ3dca8VQxl194uuWnR4aESyHwGOrzPUF+SGTxZMMBzHK0VgomCBHw
 BOrG4uelEGMS63t5DCMz2ktzxSS9oTdzbLtFunyu723WtYerYLD8uzXQBqMMreUDOVCd
 meue7f70Q/12rN3oOYL2WONEZkCVM1Q7VkOjuyYzbVJ3Yf3dQzcVEU5Q8Yzj35KrkWni
 dj/UQHKDGJ6/Js4Ul4BXGu4INFqr6aUdZBuYSIL0MkJMyKeG0gRBe8wrc3mgwWkI/N5u
 vg4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=+iG0rPie0hGjlqBkimyNljZ85YQMu0uvsdwoC84m+No=;
 b=rR6wZ+K5llUrcXqWYAn9PAUNY/f8RSLlXtbMJpo1J+2m2u42EV6Bj0nHSzSNHPnXh9
 Ns3N6Chh80C1TYiTVlAmDHlVWsOoD9ZRI7NpNczbxltzaFXNwor4MmQd3V1NKBs+aqBk
 W9jr+AO0TBhmtbGJhy4emLof2AgU+rG4fUuL8gA/Pc4auAXz56O1lC0uqWauOXr1h0Yu
 BGwTEHFIez7z4UBR3OdFhQFeODH0Pq8Xd3B6FQ2Pc6FGebh2l7D9HHhztZwB2t34Yjrl
 uIYzppvRhat5jY1/q0F0zbbzq4OS+mQBsPMeWNSFks4Rrd+uxbwTsPw0z41o871SARad
 9PdA==
X-Gm-Message-State: AOAM532VfjhJQRT1Z8ZZAdZwepjmtTpLT86Wd4GZkCI1CclATExo8OEa
 3CKDWH/L1f6T/Puvf+QiqRLOkSklkUoifFroPPg=
X-Google-Smtp-Source: ABdhPJyo9VaZLguZx1FF1wevl9ZhOdjkbjDW75ZekxD0csEl1es3BieqGxzgri3k5dRW/9uzGQhPDjZyl33aMhozIyU=
X-Received: by 2002:adf:a351:: with SMTP id d17mr26017853wrb.111.1597094155668; 
 Mon, 10 Aug 2020 14:15:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200809203406.751971-1-christophe.jaillet@wanadoo.fr>
 <20200810154213.GM1793@kadam>
 <8c414dd7-4a80-6ff2-03de-5340fb0d9c61@wanadoo.fr>
In-Reply-To: <8c414dd7-4a80-6ff2-03de-5340fb0d9c61@wanadoo.fr>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 10 Aug 2020 17:15:44 -0400
Message-ID: <CADnq5_NURN9_ONyXoLd5gMK6mTxotRZiP7N27UC1n_RNpQKimA@mail.gmail.com>
Subject: Re: [PATCH] drm: amdgpu: Use the correct size when allocating memory
To: "Marion & Christophe JAILLET" <christophe.jaillet@wanadoo.fr>
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
Cc: "Messinger, Ori" <Ori.Messinger@amd.com>, Dave Airlie <airlied@linux.ie>,
 Bernard Zhao <bernard@vivo.com>, kernel-janitors@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 Christian Koenig <christian.koenig@amd.com>,
 Colton Lewis <colton.w.lewis@protonmail.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, Daniel Vetter <daniel@ffwll.ch>,
 "Deucher, Alexander" <alexander.deucher@amd.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Dan Carpenter <dan.carpenter@oracle.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QXBwbGllZCBhbmQgdXBkYXRlZCB0aGUgY29tbWl0IG1lc3NhZ2UgdG8gcmVmbGVjdCB0aGUgc2l6
ZXMuCgpUaGFua3MhCgpBbGV4CgpPbiBNb24sIEF1ZyAxMCwgMjAyMCBhdCAzOjA3IFBNIE1hcmlv
biAmIENocmlzdG9waGUgSkFJTExFVAo8Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI+IHdy
b3RlOgo+Cj4KPiBMZSAxMC8wOC8yMDIwIMOgIDE3OjQyLCBEYW4gQ2FycGVudGVyIGEgw6ljcml0
IDoKPiA+IE9uIFN1biwgQXVnIDA5LCAyMDIwIGF0IDEwOjM0OjA2UE0gKzAyMDAsIENocmlzdG9w
aGUgSkFJTExFVCB3cm90ZToKPiA+PiBXaGVuICcqc2d0JyBpcyBhbGxvY2F0ZWQsIHdlIG11c3Qg
YWxsb2NhdGVkICdzaXplb2YoKipzZ3QpJyBieXRlcyBpbnN0ZWFkCj4gPj4gb2YgJ3NpemVvZigq
c2cpJy4gJ3NnJyAoaS5lLiBzdHJ1Y3Qgc2NhdHRlcmxpc3QpIGlzIHNtYWxsZXIgdGhhbgo+ID4+
ICdzZ3QnIChpLmUgc3RydWN0IHNnX3RhYmxlKSwgc28gdGhpcyBjb3VsZCBsZWFkIHRvIG1lbW9y
eSBjb3JydXB0aW9uLgo+ID4gVGhlIHNpemVvZigqc2cpIGlzIGJpZ2dlciB0aGFuIHNpemVvZigq
KnNndCkgc28gdGhpcyB3YXN0ZXMgbWVtb3J5IGJ1dAo+ID4gaXQgd29uJ3QgbGVhZCB0byBjb3Jy
dXB0aW9uLgo+ID4KPiA+ICAgICAgMTEgIHN0cnVjdCBzY2F0dGVybGlzdCB7Cj4gPiAgICAgIDEy
ICAgICAgICAgIHVuc2lnbmVkIGxvbmcgICBwYWdlX2xpbms7Cj4gPiAgICAgIDEzICAgICAgICAg
IHVuc2lnbmVkIGludCAgICBvZmZzZXQ7Cj4gPiAgICAgIDE0ICAgICAgICAgIHVuc2lnbmVkIGlu
dCAgICBsZW5ndGg7Cj4gPiAgICAgIDE1ICAgICAgICAgIGRtYV9hZGRyX3QgICAgICBkbWFfYWRk
cmVzczsKPiA+ICAgICAgMTYgICNpZmRlZiBDT05GSUdfTkVFRF9TR19ETUFfTEVOR1RICj4gPiAg
ICAgIDE3ICAgICAgICAgIHVuc2lnbmVkIGludCAgICBkbWFfbGVuZ3RoOwo+ID4gICAgICAxOCAg
I2VuZGlmCj4gPiAgICAgIDE5ICB9Owo+ID4KPiA+ICAgICAgNDIgIHN0cnVjdCBzZ190YWJsZSB7
Cj4gPiAgICAgIDQzICAgICAgICAgIHN0cnVjdCBzY2F0dGVybGlzdCAqc2dsOyAgICAgICAgLyog
dGhlIGxpc3QgKi8KPiA+ICAgICAgNDQgICAgICAgICAgdW5zaWduZWQgaW50IG5lbnRzOyAgICAg
ICAgICAgICAvKiBudW1iZXIgb2YgbWFwcGVkIGVudHJpZXMgKi8KPiA+ICAgICAgNDUgICAgICAg
ICAgdW5zaWduZWQgaW50IG9yaWdfbmVudHM7ICAgICAgICAvKiBvcmlnaW5hbCBzaXplIG9mIGxp
c3QgKi8KPiA+ICAgICAgNDYgIH07Cj4gPgo+ID4gcmVnYXJkcywKPiA+IGRhbiBjYXJwZW50ZXIK
Pgo+Cj4gTXkgYmFkLiBJIHJlYWQgJ3N0cnVjdCBzY2F0dGVybGlzdCBzZ2wnICh3aXRob3V0IHRo
ZSAqKQo+IFRoYW5rcyBmb3IgdGhlIGZvbGxvdy11cCwgRGFuLgo+Cj4gRG9lc24ndCBzbWF0Y2gg
Y2F0Y2ggc3VjaCBtaXNtYXRjaD8KPiAoSSd2ZSBub3QgcnVuIHNtYXRjaCBmb3IgYSB3aGlsZSwg
c28gaXQgaXMgbWF5YmUgcmVwb3J0ZWQpCj4KPiBXZWxsLCB0aGUgcHJvcG9zYWwgaXMgc3RpbGwg
dmFsaWQsIGV2ZW4gaWYgaXQgaGFzIGxlc3MgaW1wYWN0IGFzCj4gaW5pdGlhbGx5IHRob3VnaHQu
Cj4KPiBUaHggZm9yIHRoZSByZXZpZXcuCj4KPiBDSgo+Cj4gX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KPiBhbWQtZ2Z4IG1haWxpbmcgbGlzdAo+IGFtZC1n
ZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4gaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcv
bWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRl
c2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8v
YW1kLWdmeAo=
