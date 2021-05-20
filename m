Return-Path: <SRS0=8Dg8=KP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84950C433ED
	for <amd-gfx@archiver.kernel.org>; Thu, 20 May 2021 19:07:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 424D061244
	for <amd-gfx@archiver.kernel.org>; Thu, 20 May 2021 19:07:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 424D061244
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6261D6F4CF;
	Thu, 20 May 2021 19:07:37 +0000 (UTC)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 373B86F4CF;
 Thu, 20 May 2021 19:07:36 +0000 (UTC)
Received: by mail-oi1-x232.google.com with SMTP id d21so17364506oic.11;
 Thu, 20 May 2021 12:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=tivSZul1r1F6cXTIGetorCc6IvXldYG9DGcrI+56/Vo=;
 b=KwOehk5T3VqGA6Vo0ut4YB3Lvw6MJynXVG9O7X6y6tafaD5A3b+cyRT09CMWB5ErqJ
 ySAG2N+us1IkTFxsPRq7CKazXy7KkUhI/O2f0P9vIQXHZYikaPzqmiwlGLfY+37bLtt1
 kh4/T4dNaZKd42Bi5nLC2gEnVjOWV5G72A6//9A3RCXE9ZpPV9lEN3ULn8uUzb2GSqKw
 1ULAHwJ7UxoGuMqC71u7y/+lEGb98Ml/G0nKzaqJesmr5tJ8rAVwLbw3Ks8heMMOPsTC
 g2DFuRKJNok+bRi+tIuQPft0S5zqYbIpXtUCQs52AcHxPbKh+4I466KGMdDb+DtG4AAs
 YB0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=tivSZul1r1F6cXTIGetorCc6IvXldYG9DGcrI+56/Vo=;
 b=TtQocdgvAgsQ7L9CTIJPiOXelbwU/EJaNNSHqd0Sdz0xdUFw4VbKHGNRXNSucUsWor
 kQVcE/rG6btUnUT+o8r083q037LYseqC37abuTfu+nKa+4hXCiUxUV67KctaGuPP3TkC
 81ncsmV3Q+B554G0ZJkKLbxEPivmfATJbGaamRb7rtq4nVfIKj0pxkBAXhwuda6Qtd2s
 eoRIdlVIBeO2aEPQqT3L0hxksf7UVcgvB4Bk8QP7TtgPuCxmYzMft643ZICHvruOL5Q/
 BuEZdlvlE0QP/d5lLEYNsnr5bJvU+fOULCuBfKxAsKhCK627Kz6yT9CtGuEN/Yjk1GJf
 CuLg==
X-Gm-Message-State: AOAM530PkLHu+hPo/357fd41HiIeLUOuosGVadVN4karWV/HBkGHadZF
 xb7LF6qhw/kbvTe2+5WiUfaIMUYVCmrAx4d58mU=
X-Google-Smtp-Source: ABdhPJzgJB1LgjuwXSwFitmQBsumwTKZiFfIShZ0oIJEvDs0+pTtwXmxx/z6zQxihaCTMwdvsqGQPWV4riB11PMv/LI=
X-Received: by 2002:a05:6808:1592:: with SMTP id
 t18mr2452836oiw.123.1621537655443; 
 Thu, 20 May 2021 12:07:35 -0700 (PDT)
MIME-Version: 1.0
References: <20210520120248.3464013-1-lee.jones@linaro.org>
 <20210520120248.3464013-4-lee.jones@linaro.org>
 <16b0f3a3-92a8-074c-f926-fba832060a71@amd.com>
In-Reply-To: <16b0f3a3-92a8-074c-f926-fba832060a71@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 20 May 2021 15:07:24 -0400
Message-ID: <CADnq5_O4Uu4yVKLKSoeVFZVyA7XJdMEjdiUdaQm0zHOacLM7iw@mail.gmail.com>
Subject: Re: [PATCH 03/38] drm/radeon/radeon_cs: Fix incorrectly documented
 function 'radeon_cs_parser_fini'
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
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
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 "moderated list:DMA BUFFER SHARING FRAMEWORK" <linaro-mm-sig@lists.linaro.org>,
 Jerome Glisse <glisse@freedesktop.org>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 Lee Jones <lee.jones@linaro.org>, Sumit Semwal <sumit.semwal@linaro.org>,
 linux-media <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QXBwbGllZC4gIFRoYW5rcyEKCkFsZXgKCk9uIFRodSwgTWF5IDIwLCAyMDIxIGF0IDg6MDQgQU0g
Q2hyaXN0aWFuIEvDtm5pZwo8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPiB3cm90ZToKPgo+IEFt
IDIwLjA1LjIxIHVtIDE0OjAyIHNjaHJpZWIgTGVlIEpvbmVzOgo+ID4gRml4ZXMgdGhlIGZvbGxv
d2luZyBXPTEga2VybmVsIGJ1aWxkIHdhcm5pbmcocyk6Cj4gPgo+ID4gICBkcml2ZXJzL2dwdS9k
cm0vcmFkZW9uL3JhZGVvbl9jcy5jOjQxNzogd2FybmluZzogZXhwZWN0aW5nIHByb3RvdHlwZSBm
b3IgY3NfcGFyc2VyX2ZpbmkoKS4gUHJvdG90eXBlIHdhcyBmb3IgcmFkZW9uX2NzX3BhcnNlcl9m
aW5pKCkgaW5zdGVhZAo+ID4KPiA+IENjOiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVy
QGFtZC5jb20+Cj4gPiBDYzogIkNocmlzdGlhbiBLw7ZuaWciIDxjaHJpc3RpYW4ua29lbmlnQGFt
ZC5jb20+Cj4gPiBDYzogRGF2aWQgQWlybGllIDxhaXJsaWVkQGxpbnV4LmllPgo+ID4gQ2M6IERh
bmllbCBWZXR0ZXIgPGRhbmllbEBmZndsbC5jaD4KPiA+IENjOiBTdW1pdCBTZW13YWwgPHN1bWl0
LnNlbXdhbEBsaW5hcm8ub3JnPgo+ID4gQ2M6IEplcm9tZSBHbGlzc2UgPGdsaXNzZUBmcmVlZGVz
a3RvcC5vcmc+Cj4gPiBDYzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPiA+IENjOiBk
cmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4gPiBDYzogbGludXgtbWVkaWFAdmdlci5r
ZXJuZWwub3JnCj4gPiBDYzogbGluYXJvLW1tLXNpZ0BsaXN0cy5saW5hcm8ub3JnCj4gPiBTaWdu
ZWQtb2ZmLWJ5OiBMZWUgSm9uZXMgPGxlZS5qb25lc0BsaW5hcm8ub3JnPgo+Cj4gUmV2aWV3ZWQt
Ynk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KPgo+ID4gLS0t
Cj4gPiAgIGRyaXZlcnMvZ3B1L2RybS9yYWRlb24vcmFkZW9uX2NzLmMgfCAyICstCj4gPiAgIDEg
ZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQo+ID4KPiA+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVvbl9jcy5jIGIvZHJpdmVycy9ncHUv
ZHJtL3JhZGVvbi9yYWRlb25fY3MuYwo+ID4gaW5kZXggNDgxNjI1MDFjMWVlNi4uODBhM2JlZTkz
M2Q2ZCAxMDA2NDQKPiA+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vcmFkZW9uX2NzLmMK
PiA+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vcmFkZW9uX2NzLmMKPiA+IEBAIC00MDUs
NyArNDA1LDcgQEAgc3RhdGljIGludCBjbXBfc2l6ZV9zbWFsbGVyX2ZpcnN0KHZvaWQgKnByaXYs
IGNvbnN0IHN0cnVjdCBsaXN0X2hlYWQgKmEsCj4gPiAgIH0KPiA+Cj4gPiAgIC8qKgo+ID4gLSAq
IGNzX3BhcnNlcl9maW5pKCkgLSBjbGVhbiBwYXJzZXIgc3RhdGVzCj4gPiArICogcmFkZW9uX2Nz
X3BhcnNlcl9maW5pKCkgLSBjbGVhbiBwYXJzZXIgc3RhdGVzCj4gPiAgICAqIEBwYXJzZXI6IHBh
cnNlciBzdHJ1Y3R1cmUgaG9sZGluZyBwYXJzaW5nIGNvbnRleHQuCj4gPiAgICAqIEBlcnJvcjog
IGVycm9yIG51bWJlcgo+ID4gICAgKiBAYmFja29mZjogICAgICAgIGluZGljYXRvciB0byBiYWNr
b2ZmIHRoZSByZXNlcnZhdGlvbgo+Cj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KPiBhbWQtZ2Z4IG1haWxpbmcgbGlzdAo+IGFtZC1nZnhAbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnCj4gaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0
aW5mby9hbWQtZ2Z4Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0
dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
