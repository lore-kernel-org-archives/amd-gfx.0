Return-Path: <SRS0=0i2d=KW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DBDFC47089
	for <amd-gfx@archiver.kernel.org>; Thu, 27 May 2021 02:32:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CB07610C7
	for <amd-gfx@archiver.kernel.org>; Thu, 27 May 2021 02:32:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CB07610C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF2F66E8B7;
	Thu, 27 May 2021 02:32:43 +0000 (UTC)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA49E6E8B7;
 Thu, 27 May 2021 02:32:42 +0000 (UTC)
Received: by mail-ej1-x62e.google.com with SMTP id z16so4958313ejr.4;
 Wed, 26 May 2021 19:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=TV+wC0WFoKchEerG4axbdcV4seO64TyW3pbGdwqfpJc=;
 b=iTyPMYOsNLuaTnfQk1SALHo6QRQMwdVAV+cufxsffWt1Jj0Q5/72gy2hsqXz/Lw5CP
 p3w7/9fXwr/8klthDTc9Bn4/0Eug57QRh/SIiM1ka2aEQb75p1Eb5kGpvnHTF8NG0bJd
 swnXJjG2C8A9cAoohGjA8clmbCEyTUgwDcqn65dRZtBJYY8LOOy0f1r6cqoGtFGpwWSk
 scWTRIaZ9dePGAwX2cLiUTmuKht3RkmNskxtfH945xzd6LrgmkEs8CDr2RJrOQFpxAdg
 W/1c23Ul4vuBr1LUwpM2pRxHlfH43xBsB/bWIVzz7DC3uNZc6sG7ts+XYgcvc5ViRJ/6
 5nLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=TV+wC0WFoKchEerG4axbdcV4seO64TyW3pbGdwqfpJc=;
 b=knzOT/wbTyB5sgrG6Ggu5q7lsSqbENRG1BUpuju084TiovFcmHfkU+MoL7jgSvZNed
 Y103koxIO7YVgFXDdbZrekYez0StIlGcev/0iJjmD+YhaL8bdDQY4jXFA2PNJT5FzWE1
 tbE9qNj0H1vDQeshANisAcFOQhXzmrDOORTLIlkvv6oMmXV8aWjY6lM8Z83m6tRDKmz+
 o42N/DmCVJPHuLCPKuJkoUXPpRTUjRIMk8MEhtEmKbl4dhZib411FY9TNl75kkfmOwCU
 33bX2/BXdhUvW5bytQm8z5pEyIsPhpxTSYKXuq8Tz3gpFnTBq9A8zccuYHBEzXI5cqd2
 Ywcw==
X-Gm-Message-State: AOAM530S5/0rT1lszvm8izbZTpecL7//7Xryd/u1fHT9yBsdk07p7kXo
 vFAQzUSV3fb9n5d4BVD0FcgrKOzA2LV3S7sAxZE=
X-Google-Smtp-Source: ABdhPJwLwL4Noh/s/BkOlp186Rrpkjoiiy23P/QOFO3PvNKzg5ao/zNlA6EJBqpA3nwvgDt3HRBPA9WGsmXWUUqpUIE=
X-Received: by 2002:a17:906:4704:: with SMTP id
 y4mr1397988ejq.68.1622082761433; 
 Wed, 26 May 2021 19:32:41 -0700 (PDT)
MIME-Version: 1.0
References: <20210516121315.30321-1-tzimmermann@suse.de>
 <057a9a16-3ed7-b159-22d7-33f1dc523d14@suse.de>
In-Reply-To: <057a9a16-3ed7-b159-22d7-33f1dc523d14@suse.de>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 26 May 2021 22:32:30 -0400
Message-ID: <CADnq5_PaOmQAw-X7+RtBThg_e74uuzoiqrDUguksLVOWkKUnNw@mail.gmail.com>
Subject: Re: [PATCH 0/4] drm: Finally retire struct drm_format_name_buf
To: Thomas Zimmermann <tzimmermann@suse.de>
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Sakari Ailus <sakari.ailus@linux.intel.com>, Dave Airlie <airlied@linux.ie>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 Daniel Vetter <daniel@ffwll.ch>, "Deucher,
 Alexander" <alexander.deucher@amd.com>,
 Christian Koenig <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QWNrZWQtYnk6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KZm9yIHRo
ZSBhbWRncHUgY2hhbmdlcy4KCk9uIFdlZCwgTWF5IDI2LCAyMDIxIGF0IDM6MjEgUE0gVGhvbWFz
IFppbW1lcm1hbm4gPHR6aW1tZXJtYW5uQHN1c2UuZGU+IHdyb3RlOgo+Cj4gcGluZyBmb3IgZnVy
dGhlciBhLWJzIC8gci1icwo+Cj4gQW0gMTYuMDUuMjEgdW0gMTQ6MTMgc2NocmllYiBUaG9tYXMg
WmltbWVybWFubjoKPiA+IFRoaXMgaXMgYSBjbGVhbnVwIHBhdGNoc2V0IHRvIHJlbW92ZSBkcm1f
Zm9ybWF0X25hbWVfYnVmIGV0IGFsLiBUaGVyZQo+ID4gYXJlIHR3byBpbnN0YW5jZXMgaW4gZHJp
dmVycyB0aGF0IG5lZWQgdG8gYmUgcmVwbGFjZWQgd2l0aCB0aGUgJTRjYwo+ID4gcHJpbnRrIGZv
cm1hdCBtb2RpZmllci4gUGF0Y2ggMyB3YXMgbGVmdCBvdmVyIGJhY2sgZnJvbSBhbiBlYXJsaWVy
Cj4gPiBwYXRjaHNldC4gWzFdIFBhdGNoIDQgcmVtb3ZlcyBzdHJ1Y3QgZHJtX2Zvcm1hdF9uYW1l
X2J1Zi4KPiA+Cj4gPiBJIGJ1aWx0LXRlc3RlZCB3aXRoIGRybS10aXAuIFRoZSBwYXRjaHNldGNh
biBiZSBtZXJlZCB0aHJvdWdoIGRybS1taXNjLgo+ID4KPiA+IFsxXSBodHRwczovL2xvcmUua2Vy
bmVsLm9yZy9kcmktZGV2ZWwvMjAyMTAyMTYxNTU3MjMuMTcxMDktMS1zYWthcmkuYWlsdXNAbGlu
dXguaW50ZWwuY29tLwo+ID4KPiA+IFNha2FyaSBBaWx1cyAoMSk6Cj4gPiAgICBkcm06IFJlbW92
ZSBkcm1fZ2V0X2Zvcm1hdF9uYW1lKCkKPiA+Cj4gPiBUaG9tYXMgWmltbWVybWFubiAoMyk6Cj4g
PiAgICBkcm0vYW1kZ3B1OiBVc2UgJXA0Y2MgdG8gcHJpbnQgNENDIGZvcm1hdAo+ID4gICAgZHJt
L3NpbXBsZWRybTogVXNlICVwNGNjIHRvIHByaW50IDRDQyBmb3JtYXQKPiA+ICAgIGRybS9mb3Vy
Y2M6IFJlbW92ZSBzdHJ1Y3QgZHJtX2Zvcm1hdF9idWZfbmFtZQo+ID4KPiA+ICAgZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rpc3BsYXkuYyB8ICA3ICsrLS0tLQo+ID4gICBkcml2
ZXJzL2dwdS9kcm0vZHJtX2ZvdXJjYy5jICAgICAgICAgICAgICAgIHwgMjUgLS0tLS0tLS0tLS0t
LS0tLS0tLS0tCj4gPiAgIGRyaXZlcnMvZ3B1L2RybS90aW55L3NpbXBsZWRybS5jICAgICAgICAg
ICAgfCAgNiArKy0tLQo+ID4gICBpbmNsdWRlL2RybS9kcm1fZm91cmNjLmggICAgICAgICAgICAg
ICAgICAgIHwgIDkgLS0tLS0tLS0KPiA+ICAgNCBmaWxlcyBjaGFuZ2VkLCA0IGluc2VydGlvbnMo
KyksIDQzIGRlbGV0aW9ucygtKQo+ID4KPiA+IC0tCj4gPiAyLjMxLjEKPiA+Cj4KPiAtLQo+IFRo
b21hcyBaaW1tZXJtYW5uCj4gR3JhcGhpY3MgRHJpdmVyIERldmVsb3Blcgo+IFNVU0UgU29mdHdh
cmUgU29sdXRpb25zIEdlcm1hbnkgR21iSAo+IE1heGZlbGRzdHIuIDUsIDkwNDA5IE7DvHJuYmVy
ZywgR2VybWFueQo+IChIUkIgMzY4MDksIEFHIE7DvHJuYmVyZykKPiBHZXNjaMOkZnRzZsO8aHJl
cjogRmVsaXggSW1lbmTDtnJmZmVyCj4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVz
a3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9h
bWQtZ2Z4Cg==
