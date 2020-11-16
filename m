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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93A16C4742C
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Nov 2020 20:21:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B06F217A0
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Nov 2020 20:21:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pbiobcev"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B06F217A0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE8D56EA6E;
	Mon, 16 Nov 2020 20:20:59 +0000 (UTC)
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com
 [IPv6:2a00:1450:4864:20::443])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AFF656EA6B;
 Mon, 16 Nov 2020 20:20:57 +0000 (UTC)
Received: by mail-wr1-x443.google.com with SMTP id p1so20181957wrf.12;
 Mon, 16 Nov 2020 12:20:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=NktH7Z54pEU5BvQhLkdETJG3SnKmMNuAIzk3OHG5KlE=;
 b=pbiobcevGF9sFk5btvIswim0/5GASvSokBSAuq6xLyWSMTsbj+jIWfgrOaSp6PeStH
 UVMFnnpupm01eyG088X0P/KAcbaS/ejNkqzFiw+r1r2AXCv8xjQF1BLaFKf2Ujhj2AgU
 yWJqQNo6nq5MtF083N2DUK2UPvK7zs2lDiz9bMCHyWvZz0v5tYdo+u7v/994S0KkHbow
 HXVGKQYma2gYl58v5BlUzv7zfBjYnmQjNozOEsOhmOglTSDCOPsZdboABDFSCQCHJpNL
 qHC1xDaO6IqxHdu7Q51i1JA6HXNz7d0ZzuZr9sQPbm1kTIhmNW4V8YNGaPCmvN9kVO3k
 lDXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=NktH7Z54pEU5BvQhLkdETJG3SnKmMNuAIzk3OHG5KlE=;
 b=U4to0OlUJ6bWuj/XFc2GbcD2PWPUEAns8PN9SBKd9U7HaG/7xdGjPr/tRdaM1wgflG
 JsMKZwaB8A6fVPrXYasnJNecP6EfqQ4UCTPYEQ8cHLaSYMFq3mQ4RKxshlP/xl3iLIx6
 zyVI/I1CIdw0bDAuXszqfQCeKW9BXG/Vs3Pc4pGmNS4mrqvwvrnX71FHuqqvr3NfW+BO
 tqIW9iB8XD0+FpA5HxXnW86ijIBhEws9t+zf/mHMWSQcy7gQlok0ypYj7Bd16m4teZfK
 Dg9R9yld71gjpJ1U0pKJtjuLhySut9lb7REZALXJ1JE7Th2/MGeSPMSvAHRS5Ri5JKBQ
 KGQA==
X-Gm-Message-State: AOAM530K8jcQ4WjvAa8laYwjHD1K/Px033HPtRrL0FV2qROMFH7qFXtQ
 nSUom8hG+3TME1EGVVzY5OG9cvQ49kU6MsazawI=
X-Google-Smtp-Source: ABdhPJwG/0W9HleQrUvotIm+i7WOV+4+i795t6wQ5NhJgGafSov+skWSGFjW2Q9MBy3QSMUskHH4OyeeRWTiliX0aq8=
X-Received: by 2002:adf:9144:: with SMTP id j62mr4543129wrj.419.1605558056462; 
 Mon, 16 Nov 2020 12:20:56 -0800 (PST)
MIME-Version: 1.0
References: <20201116173700.1830487-1-lee.jones@linaro.org>
 <20201116173700.1830487-28-lee.jones@linaro.org>
In-Reply-To: <20201116173700.1830487-28-lee.jones@linaro.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 16 Nov 2020 15:20:45 -0500
Message-ID: <CADnq5_NqdwT8SGbZCVMFY7kp=rT12ux-EzNPipuVVzVw8vtofQ@mail.gmail.com>
Subject: Re: [PATCH 27/43] drm/radeon/radeon_encoders: Move
 'radeon_atom_backlight_init's prototype to shared header
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
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gTW9uLCBOb3YgMTYsIDIwMjAgYXQgMTI6MzcgUE0gTGVlIEpvbmVzIDxsZWUuam9uZXNAbGlu
YXJvLm9yZz4gd3JvdGU6Cj4KPiBGaXhlcyB0aGUgZm9sbG93aW5nIFc9MSBrZXJuZWwgYnVpbGQg
d2FybmluZyhzKToKPgo+ICBkcml2ZXJzL2dwdS9kcm0vcmFkZW9uL2F0b21iaW9zX2VuY29kZXJz
LmM6MTg2OjY6IHdhcm5pbmc6IG5vIHByZXZpb3VzIHByb3RvdHlwZSBmb3Ig4oCYcmFkZW9uX2F0
b21fYmFja2xpZ2h0X2luaXTigJkgWy1XbWlzc2luZy1wcm90b3R5cGVzXQo+ICAxODYgfCB2b2lk
IHJhZGVvbl9hdG9tX2JhY2tsaWdodF9pbml0KHN0cnVjdCByYWRlb25fZW5jb2RlciAqcmFkZW9u
X2VuY29kZXIsCj4gIHwgXn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn4KPgo+IENjOiBBbGV4IERl
dWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+Cj4gQ2M6ICJDaHJpc3RpYW4gS8O2bmln
IiA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgo+IENjOiBEYXZpZCBBaXJsaWUgPGFpcmxpZWRA
bGludXguaWU+Cj4gQ2M6IERhbmllbCBWZXR0ZXIgPGRhbmllbEBmZndsbC5jaD4KPiBDYzogYW1k
LWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPiBDYzogZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNr
dG9wLm9yZwo+IFNpZ25lZC1vZmYtYnk6IExlZSBKb25lcyA8bGVlLmpvbmVzQGxpbmFyby5vcmc+
CgpBcHBsaWVkLiAgVGhhbmtzIQoKQWxleAoKPiAtLS0KPiAgZHJpdmVycy9ncHUvZHJtL3JhZGVv
bi9yYWRlb25fYXRvbWJpb3MuaCB8IDQgKysrKwo+ICBkcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3Jh
ZGVvbl9lbmNvZGVycy5jIHwgNiArLS0tLS0KPiAgMiBmaWxlcyBjaGFuZ2VkLCA1IGluc2VydGlv
bnMoKyksIDUgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL3Jh
ZGVvbi9yYWRlb25fYXRvbWJpb3MuaCBiL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vcmFkZW9uX2F0
b21iaW9zLmgKPiBpbmRleCBhODk1YTcwMDJjM2QzLi5mZDAzNzU1ZTZmYTJjIDEwMDY0NAo+IC0t
LSBhL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vcmFkZW9uX2F0b21iaW9zLmgKPiArKysgYi9kcml2
ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVvbl9hdG9tYmlvcy5oCj4gQEAgLTI4LDE0ICsyOCwxOCBA
QAo+ICAjaWZuZGVmIF9fUkFERU9OX0FUT01CSU9TX0hfXwo+ICAjZGVmaW5lIF9fUkFERU9OX0FU
T01CSU9TX0hfXwo+Cj4gK3N0cnVjdCBkcm1fY29ubmVjdG9yOwo+ICBzdHJ1Y3QgZHJtX2Rldmlj
ZTsKPiAgc3RydWN0IGRybV9kaXNwbGF5X21vZGU7Cj4gIHN0cnVjdCByYWRlb25fZGV2aWNlOwo+
ICtzdHJ1Y3QgcmFkZW9uX2VuY29kZXI7Cj4KPiAgYm9vbCByYWRlb25fYXRvbV9nZXRfdHZfdGlt
aW5ncyhzdHJ1Y3QgcmFkZW9uX2RldmljZSAqcmRldiwgaW50IGluZGV4LAo+ICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgc3RydWN0IGRybV9kaXNwbGF5X21vZGUgKm1vZGUpOwo+ICB2
b2lkIHJhZGVvbl9hZGRfYXRvbV9lbmNvZGVyKHN0cnVjdCBkcm1fZGV2aWNlICpkZXYsIHVpbnQz
Ml90IGVuY29kZXJfZW51bSwKPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHVpbnQzMl90
IHN1cHBvcnRlZF9kZXZpY2UsIHUxNiBjYXBzKTsKPiArdm9pZCByYWRlb25fYXRvbV9iYWNrbGln
aHRfaW5pdChzdHJ1Y3QgcmFkZW9uX2VuY29kZXIgKnJhZGVvbl9lbmNvZGVyLAo+ICsgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgc3RydWN0IGRybV9jb25uZWN0b3IgKmRybV9jb25uZWN0
b3IpOwo+Cj4KPiAgI2VuZGlmICAgICAgICAgICAgICAgICAgICAgICAgIC8qIF9fUkFERU9OX0FU
T01CSU9TX0hfXyAqLwo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVv
bl9lbmNvZGVycy5jIGIvZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fZW5jb2RlcnMuYwo+
IGluZGV4IGI2MGEzNzNkM2VhZDMuLjQ2NTQ5ZDUxNzllZTkgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVy
cy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fZW5jb2RlcnMuYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2Ry
bS9yYWRlb24vcmFkZW9uX2VuY29kZXJzLmMKPiBAQCAtMzEsMTQgKzMxLDEwIEBACj4gICNpbmNs
dWRlIDxkcm0vcmFkZW9uX2RybS5oPgo+Cj4gICNpbmNsdWRlICJyYWRlb24uaCIKPiArI2luY2x1
ZGUgInJhZGVvbl9hdG9tYmlvcy5oIgo+ICAjaW5jbHVkZSAicmFkZW9uX2xlZ2FjeV9lbmNvZGVy
cy5oIgo+ICAjaW5jbHVkZSAiYXRvbS5oIgo+Cj4gLWV4dGVybiB2b2lkCj4gLXJhZGVvbl9hdG9t
X2JhY2tsaWdodF9pbml0KHN0cnVjdCByYWRlb25fZW5jb2RlciAqcmFkZW9uX2VuY29kZXIsCj4g
LSAgICAgICAgICAgICAgICAgICAgICAgICAgc3RydWN0IGRybV9jb25uZWN0b3IgKmRybV9jb25u
ZWN0b3IpOwo+IC0KPiAtCj4gIHN0YXRpYyB1aW50MzJfdCByYWRlb25fZW5jb2Rlcl9jbG9uZXMo
c3RydWN0IGRybV9lbmNvZGVyICplbmNvZGVyKQo+ICB7Cj4gICAgICAgICBzdHJ1Y3QgZHJtX2Rl
dmljZSAqZGV2ID0gZW5jb2Rlci0+ZGV2Owo+IC0tCj4gMi4yNS4xCj4KPiBfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+IGRyaS1kZXZlbCBtYWlsaW5nIGxp
c3QKPiBkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4gaHR0cHM6Ly9saXN0cy5mcmVl
ZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9kcmktZGV2ZWwKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdm
eEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFp
bG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
