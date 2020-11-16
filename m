Return-Path: <SRS0=8n1M=EW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE08BC55ABD
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Nov 2020 19:38:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 729A220825
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Nov 2020 19:38:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fj99Tpte"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 729A220825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2142B6E0F3;
	Mon, 16 Nov 2020 19:38:07 +0000 (UTC)
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com
 [IPv6:2a00:1450:4864:20::342])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC1176E0F1;
 Mon, 16 Nov 2020 19:38:05 +0000 (UTC)
Received: by mail-wm1-x342.google.com with SMTP id a3so377979wmb.5;
 Mon, 16 Nov 2020 11:38:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=Ru267PQGlQsOc+0AqYwg/UBJuZfw/k56sykTs1YsbnQ=;
 b=Fj99Tpte9Q1UICmja9Nwy7ObhrnkwQVm9spuX2zXK7spMDHVLHkadP0+EaqpSpEkod
 Ql8MuBX5Pm3J86jaJu83VjxE7foZ6lhCQSEwOX9erdmv30heTB8/7UBEBfHGyCUdXxYM
 7SeGhwN2cG3jvj1uaxueXH0Kq6otpQlOQuFYroEXF7kyeOgXdx22D7oMquz94KWLOSZm
 0fnJci+Wkc78wFGlBh/DD5w70oE8UicZj+IoMpYaCgNm1QN97PpT3wFW/CgJA6Ts9oLt
 nsSOMr4+2WtHytySQohMMB7iJLaO5vFeVs0o1OAknSMyPfwNoMfzMJYQ7xnu9PNKmVYj
 hBRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Ru267PQGlQsOc+0AqYwg/UBJuZfw/k56sykTs1YsbnQ=;
 b=tnm4CgQcOK8VzwS3s+XmJEMjl7W+5gBAjJ1pAWLbqFj17hhhDTDa7piaCrTdqkBFHj
 5BPqMjEtEQ/KbBc5LYW9VeXuoBRx2uJAfzVJ6U19CsvwT1r9FpCFTs9VDJZ45TpaLkrC
 FtEbzJtWabc5v7AhEYrclP2Cu6Ys8llIrrfzyFTjB+jSDjBv6P0VkCMw1iHeDCNtGt2U
 vckXj4IA0wFiWGPebQSdANkqEnKiLo98vaHcBU/av6KFHQhEt13WvjhxD/09iKuN1k1/
 T7B7WeUML/yDaeKoQ/I60Lgr2rhwbfLzrNmL22rYklMvH+ogcgg27rF1bPy4Gd8N5fs3
 VseA==
X-Gm-Message-State: AOAM531j/YrTFaXz4MoE7wYq+vOKA29JpeDMjiKB5IKBBCVAPhQU80Mo
 fE4+RWNX/b9DJ4FazaZNkI7LdzEKXnoecMf4jo4=
X-Google-Smtp-Source: ABdhPJyMgacwGcd6wHE/yIyAqYEiQMiFccSiB9vSGlLV/9TGRb68+QG4qy5jDO+PYPEM/kBTSoIrKEzfMnTOtCHaBUg=
X-Received: by 2002:a7b:c157:: with SMTP id z23mr498985wmi.70.1605555484652;
 Mon, 16 Nov 2020 11:38:04 -0800 (PST)
MIME-Version: 1.0
References: <20201116173005.1825880-1-lee.jones@linaro.org>
 <20201116173005.1825880-8-lee.jones@linaro.org>
In-Reply-To: <20201116173005.1825880-8-lee.jones@linaro.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 16 Nov 2020 14:37:53 -0500
Message-ID: <CADnq5_MtKsXUf3d5z3m4x+HwPYt5yDpbAvgN0W__m+fbbKuxVA@mail.gmail.com>
Subject: Re: [PATCH 07/43] drm/radeon/radeon_legacy_encoders: Move
 'radeon_add_legacy_encoder's prototype to shared location
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
Cc: David Airlie <airlied@linux.ie>, LKML <linux-kernel@vger.kernel.org>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 "moderated list:DMA BUFFER SHARING FRAMEWORK" <linaro-mm-sig@lists.linaro.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 linux-media <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gTW9uLCBOb3YgMTYsIDIwMjAgYXQgMTI6MzAgUE0gTGVlIEpvbmVzIDxsZWUuam9uZXNAbGlu
YXJvLm9yZz4gd3JvdGU6Cj4KPiBGaXhlcyB0aGUgZm9sbG93aW5nIFc9MSBrZXJuZWwgYnVpbGQg
d2FybmluZyhzKToKPgo+ICBkcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVvbl9sZWdhY3lfZW5j
b2RlcnMuYzoxNzQ2OjE6IHdhcm5pbmc6IG5vIHByZXZpb3VzIHByb3RvdHlwZSBmb3Ig4oCYcmFk
ZW9uX2FkZF9sZWdhY3lfZW5jb2RlcuKAmSBbLVdtaXNzaW5nLXByb3RvdHlwZXNdCj4gIDE3NDYg
fCByYWRlb25fYWRkX2xlZ2FjeV9lbmNvZGVyKHN0cnVjdCBkcm1fZGV2aWNlICpkZXYsIHVpbnQz
Ml90IGVuY29kZXJfZW51bSwgdWludDMyX3Qgc3VwcG9ydGVkX2RldmljZSkKPiAgfCBefn5+fn5+
fn5+fn5+fn5+fn5+fn5+fn5+Cj4KPiBDYzogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hl
ckBhbWQuY29tPgo+IENjOiAiQ2hyaXN0aWFuIEvDtm5pZyIgPGNocmlzdGlhbi5rb2VuaWdAYW1k
LmNvbT4KPiBDYzogRGF2aWQgQWlybGllIDxhaXJsaWVkQGxpbnV4LmllPgo+IENjOiBEYW5pZWwg
VmV0dGVyIDxkYW5pZWxAZmZ3bGwuY2g+Cj4gQ2M6IFN1bWl0IFNlbXdhbCA8c3VtaXQuc2Vtd2Fs
QGxpbmFyby5vcmc+Cj4gQ2M6IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4gQ2M6IGRy
aS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPiBDYzogbGludXgtbWVkaWFAdmdlci5rZXJu
ZWwub3JnCj4gQ2M6IGxpbmFyby1tbS1zaWdAbGlzdHMubGluYXJvLm9yZwo+IFNpZ25lZC1vZmYt
Ynk6IExlZSBKb25lcyA8bGVlLmpvbmVzQGxpbmFyby5vcmc+CgpBcHBsaWVkLiAgVGhhbmtzIQoK
QWxleAoKPiAtLS0KPiAgZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fYXRvbWJpb3MuYyAg
ICAgICAgfCA2ICstLS0tLQo+ICBkcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVvbl9jb21iaW9z
LmMgICAgICAgICB8IDYgKy0tLS0tCj4gIGRyaXZlcnMvZ3B1L2RybS9yYWRlb24vcmFkZW9uX2xl
Z2FjeV9lbmNvZGVycy5oIHwgMiArKwo+ICAzIGZpbGVzIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygr
KSwgMTAgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL3JhZGVv
bi9yYWRlb25fYXRvbWJpb3MuYyBiL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vcmFkZW9uX2F0b21i
aW9zLmMKPiBpbmRleCA3MWJmMmVkMTcyNjk3Li5jYzgwNjUxYjI1NzczIDEwMDY0NAo+IC0tLSBh
L2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vcmFkZW9uX2F0b21iaW9zLmMKPiArKysgYi9kcml2ZXJz
L2dwdS9kcm0vcmFkZW9uL3JhZGVvbl9hdG9tYmlvcy5jCj4gQEAgLTM1LDE2ICszNSwxMiBAQAo+
ICAjaW5jbHVkZSAiYXRvbS1iaXRzLmgiCj4gICNpbmNsdWRlICJyYWRlb25fYXNpYy5oIgo+ICAj
aW5jbHVkZSAicmFkZW9uX2F0b21iaW9zLmgiCj4gKyNpbmNsdWRlICJyYWRlb25fbGVnYWN5X2Vu
Y29kZXJzLmgiCj4KPiAgZXh0ZXJuIHZvaWQKPiAgcmFkZW9uX2FkZF9hdG9tX2VuY29kZXIoc3Ry
dWN0IGRybV9kZXZpY2UgKmRldiwgdWludDMyX3QgZW5jb2Rlcl9lbnVtLAo+ICAgICAgICAgICAg
ICAgICAgICAgICAgIHVpbnQzMl90IHN1cHBvcnRlZF9kZXZpY2UsIHUxNiBjYXBzKTsKPgo+IC0v
KiBmcm9tIHJhZGVvbl9sZWdhY3lfZW5jb2Rlci5jICovCj4gLWV4dGVybiB2b2lkCj4gLXJhZGVv
bl9hZGRfbGVnYWN5X2VuY29kZXIoc3RydWN0IGRybV9kZXZpY2UgKmRldiwgdWludDMyX3QgZW5j
b2Rlcl9lbnVtLAo+IC0gICAgICAgICAgICAgICAgICAgICAgICAgdWludDMyX3Qgc3VwcG9ydGVk
X2RldmljZSk7Cj4gLQo+ICB1bmlvbiBhdG9tX3N1cHBvcnRlZF9kZXZpY2VzIHsKPiAgICAgICAg
IHN0cnVjdCBfQVRPTV9TVVBQT1JURURfREVWSUNFU19JTkZPIGluZm87Cj4gICAgICAgICBzdHJ1
Y3QgX0FUT01fU1VQUE9SVEVEX0RFVklDRVNfSU5GT18yIGluZm9fMjsKPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fY29tYmlvcy5jIGIvZHJpdmVycy9ncHUvZHJt
L3JhZGVvbi9yYWRlb25fY29tYmlvcy5jCj4gaW5kZXggZDNjMDRkZjdlNzVkNy4uZmYyMTM1MDU5
YzA3MSAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVvbl9jb21iaW9z
LmMKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVvbl9jb21iaW9zLmMKPiBAQCAt
MzEsNiArMzEsNyBAQAo+ICAjaW5jbHVkZSA8ZHJtL3JhZGVvbl9kcm0uaD4KPgo+ICAjaW5jbHVk
ZSAicmFkZW9uLmgiCj4gKyNpbmNsdWRlICJyYWRlb25fbGVnYWN5X2VuY29kZXJzLmgiCj4gICNp
bmNsdWRlICJhdG9tLmgiCj4KPiAgI2lmZGVmIENPTkZJR19QUENfUE1BQwo+IEBAIC00MCwxMSAr
NDEsNiBAQAo+ICAjaW5jbHVkZSA8YXNtL3Byb20uaD4KPiAgI2VuZGlmIC8qIENPTkZJR19QUENf
UE1BQyAqLwo+Cj4gLS8qIGZyb20gcmFkZW9uX2xlZ2FjeV9lbmNvZGVyLmMgKi8KPiAtZXh0ZXJu
IHZvaWQKPiAtcmFkZW9uX2FkZF9sZWdhY3lfZW5jb2RlcihzdHJ1Y3QgZHJtX2RldmljZSAqZGV2
LCB1aW50MzJfdCBlbmNvZGVyX2VudW0sCj4gLSAgICAgICAgICAgICAgICAgICAgICAgICB1aW50
MzJfdCBzdXBwb3J0ZWRfZGV2aWNlKTsKPiAtCj4gIC8qIG9sZCBsZWdhY3kgQVRJIEJJT1Mgcm91
dGluZXMgKi8KPgo+ICAvKiBDT01CSU9TIHRhYmxlIG9mZnNldHMgKi8KPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fbGVnYWN5X2VuY29kZXJzLmggYi9kcml2ZXJz
L2dwdS9kcm0vcmFkZW9uL3JhZGVvbl9sZWdhY3lfZW5jb2RlcnMuaAo+IGluZGV4IGE4MGIzODc1
NTlkNGQuLmY0Yzc0MzIyNjdlNjcgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL3JhZGVv
bi9yYWRlb25fbGVnYWN5X2VuY29kZXJzLmgKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vcmFkZW9u
L3JhZGVvbl9sZWdhY3lfZW5jb2RlcnMuaAo+IEBAIC0zMCw1ICszMCw3IEBACj4KPiAgdm9pZCBy
YWRlb25fbGVnYWN5X2JhY2tsaWdodF9pbml0KHN0cnVjdCByYWRlb25fZW5jb2RlciAqcmFkZW9u
X2VuY29kZXIsCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCBkcm1f
Y29ubmVjdG9yICpkcm1fY29ubmVjdG9yKTsKPiArdm9pZCByYWRlb25fYWRkX2xlZ2FjeV9lbmNv
ZGVyKHN0cnVjdCBkcm1fZGV2aWNlICpkZXYsIHVpbnQzMl90IGVuY29kZXJfZW51bSwKPiArICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgdWludDMyX3Qgc3VwcG9ydGVkX2RldmljZSk7Cj4K
PiAgI2VuZGlmICAgICAgICAgICAgICAgICAgICAgICAgIC8qIF9fUkFERU9OX0xFR0FDWV9FTkNP
REVSU19IX18gKi8KPiAtLQo+IDIuMjUuMQo+Cj4gX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KPiBkcmktZGV2ZWwgbWFpbGluZyBsaXN0Cj4gZHJpLWRldmVs
QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+IGh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21h
aWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRl
c2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8v
YW1kLWdmeAo=
