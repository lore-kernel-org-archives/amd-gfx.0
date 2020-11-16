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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11EDFC55ABD
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Nov 2020 20:20:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6E7321D7E
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Nov 2020 20:20:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g41vqogo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6E7321D7E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B685689CCE;
	Mon, 16 Nov 2020 20:20:02 +0000 (UTC)
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20::343])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 974E089CBC;
 Mon, 16 Nov 2020 20:20:00 +0000 (UTC)
Received: by mail-wm1-x343.google.com with SMTP id a65so540249wme.1;
 Mon, 16 Nov 2020 12:20:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=iA5dlnSoNb3uY2ZyJuel3kYTh8E9e4NCsI1Von4rwMA=;
 b=g41vqogoXVnc/TjsoLfo5fHFZhbeZK7HACsF3AfFKsJ9umJ3ct8PGWivO4xuO6wNPO
 zhwL4+7pt5q4Z1JiznJZLMcgRlrJqpdwlITdb9RivVST3miOGPzSDkXS/SacL/JUh4LO
 ntSsFBya6HbQnpSmFmLtfNmpv/vtQDiDeX6wqLBqEdeJvOQnDzEGEmmEypnBrJc6GBSN
 qjDAzNrmL1+6hDtg3GOogiV8G9aklnOyeEQs0cE+cLgCu4AI/QjXSbaxK0CS+VQlmmqA
 SB1pXeTuOzUsy4SiVCt1G8p1JkkJNKi4evckukDZYyC73rZLsdFMcr7JOrHIigcKZbcx
 wnIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=iA5dlnSoNb3uY2ZyJuel3kYTh8E9e4NCsI1Von4rwMA=;
 b=Qa1xrMtJ9HLKs3QrA+hlGpL/wgIX4W2K/RCVJC+FQ2gJvMfuatVDYP0+G6zcnwGnDL
 RSTwCFGLAiLlXqdyNVDyJGTm/UmHJ3YruX9NdmVA78krNTNgqnbTZ36m0YU5M2HIg99L
 rdamDtVGSJvhlgVUucT9yGy0uvZ7BGo2hjuiqmhDxnT9hCBoB5OhTtig1PV+0jNg4TCc
 CXHMhae59Y0UXHt+0sngyZZ09u4lPYtjdQA6iM4S4Gb5pCMgvC9e8AzXeGjRrrCLaGbY
 w8QsfbnZAXYX1IzNbqnyVrM8vg7cEUb+zn6BLeXIvwRMqWDzhVwfECA13eaG3N0gOmqN
 SDEg==
X-Gm-Message-State: AOAM5329533Y0sSnw2028BFN4SSpxy8HRHBNdHKymsm4WY0eJjfAVD3k
 57wP3K5xsUCiVphu+z7WUMOeIm6ZB5twpiF9VWM=
X-Google-Smtp-Source: ABdhPJxiy17mMdsqlfud+cq+tyycu+S0dU0362+y4CzP+m/8yq9B8aFtwH5zXLft48CsTrr7c8sPpzq/iu49bQ1PCSw=
X-Received: by 2002:a7b:c157:: with SMTP id z23mr644263wmi.70.1605557999351;
 Mon, 16 Nov 2020 12:19:59 -0800 (PST)
MIME-Version: 1.0
References: <20201116173700.1830487-1-lee.jones@linaro.org>
 <20201116173700.1830487-27-lee.jones@linaro.org>
In-Reply-To: <20201116173700.1830487-27-lee.jones@linaro.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 16 Nov 2020 15:19:48 -0500
Message-ID: <CADnq5_PaEEgG69pni8+z3CfpX2d1AOkPB3m4OXuAZ+EnU3sFXw@mail.gmail.com>
Subject: Re: [PATCH 26/43] drm/radeon/radeon_atombios: Move
 'radeon_add_atom_encoder()'s prototype to shared header
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

T24gTW9uLCBOb3YgMTYsIDIwMjAgYXQgMTI6MzggUE0gTGVlIEpvbmVzIDxsZWUuam9uZXNAbGlu
YXJvLm9yZz4gd3JvdGU6Cj4KPiBGaXhlcyB0aGUgZm9sbG93aW5nIFc9MSBrZXJuZWwgYnVpbGQg
d2FybmluZyhzKToKPgo+ICBkcml2ZXJzL2dwdS9kcm0vcmFkZW9uL2F0b21iaW9zX2VuY29kZXJz
LmM6MjcyMToxOiB3YXJuaW5nOiBubyBwcmV2aW91cyBwcm90b3R5cGUgZm9yIOKAmHJhZGVvbl9h
ZGRfYXRvbV9lbmNvZGVy4oCZIFstV21pc3NpbmctcHJvdG90eXBlc10KPiAgMjcyMSB8IHJhZGVv
bl9hZGRfYXRvbV9lbmNvZGVyKHN0cnVjdCBkcm1fZGV2aWNlICpkZXYsCj4gIHwgXn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn4KPgo+IENjOiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFt
ZC5jb20+Cj4gQ2M6ICJDaHJpc3RpYW4gS8O2bmlnIiA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29t
Pgo+IENjOiBEYXZpZCBBaXJsaWUgPGFpcmxpZWRAbGludXguaWU+Cj4gQ2M6IERhbmllbCBWZXR0
ZXIgPGRhbmllbEBmZndsbC5jaD4KPiBDYzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcK
PiBDYzogZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+IFNpZ25lZC1vZmYtYnk6IExl
ZSBKb25lcyA8bGVlLmpvbmVzQGxpbmFyby5vcmc+CgpBcHBsaWVkLiAgVGhhbmtzIQoKQWxleAoK
PiAtLS0KPiAgZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fYXRvbWJpb3MuYyB8IDQgLS0t
LQo+ICBkcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVvbl9hdG9tYmlvcy5oIHwgNCArKysrCj4g
IDIgZmlsZXMgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQo+Cj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vcmFkZW9uX2F0b21iaW9zLmMgYi9kcml2
ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVvbl9hdG9tYmlvcy5jCj4gaW5kZXggY2M4MDY1MWIyNTc3
My4uYmU5NmQ5YjY0ZTQzYiAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3Jh
ZGVvbl9hdG9tYmlvcy5jCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fYXRv
bWJpb3MuYwo+IEBAIC0zNywxMCArMzcsNiBAQAo+ICAjaW5jbHVkZSAicmFkZW9uX2F0b21iaW9z
LmgiCj4gICNpbmNsdWRlICJyYWRlb25fbGVnYWN5X2VuY29kZXJzLmgiCj4KPiAtZXh0ZXJuIHZv
aWQKPiAtcmFkZW9uX2FkZF9hdG9tX2VuY29kZXIoc3RydWN0IGRybV9kZXZpY2UgKmRldiwgdWlu
dDMyX3QgZW5jb2Rlcl9lbnVtLAo+IC0gICAgICAgICAgICAgICAgICAgICAgIHVpbnQzMl90IHN1
cHBvcnRlZF9kZXZpY2UsIHUxNiBjYXBzKTsKPiAtCj4gIHVuaW9uIGF0b21fc3VwcG9ydGVkX2Rl
dmljZXMgewo+ICAgICAgICAgc3RydWN0IF9BVE9NX1NVUFBPUlRFRF9ERVZJQ0VTX0lORk8gaW5m
bzsKPiAgICAgICAgIHN0cnVjdCBfQVRPTV9TVVBQT1JURURfREVWSUNFU19JTkZPXzIgaW5mb18y
Owo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVvbl9hdG9tYmlvcy5o
IGIvZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fYXRvbWJpb3MuaAo+IGluZGV4IGI3Yzc2
OTIwZmViN2QuLmE4OTVhNzAwMmMzZDMgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL3Jh
ZGVvbi9yYWRlb25fYXRvbWJpb3MuaAo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vcmFk
ZW9uX2F0b21iaW9zLmgKPiBAQCAtMjgsMTAgKzI4LDE0IEBACj4gICNpZm5kZWYgX19SQURFT05f
QVRPTUJJT1NfSF9fCj4gICNkZWZpbmUgX19SQURFT05fQVRPTUJJT1NfSF9fCj4KPiArc3RydWN0
IGRybV9kZXZpY2U7Cj4gIHN0cnVjdCBkcm1fZGlzcGxheV9tb2RlOwo+ICBzdHJ1Y3QgcmFkZW9u
X2RldmljZTsKPgo+ICBib29sIHJhZGVvbl9hdG9tX2dldF90dl90aW1pbmdzKHN0cnVjdCByYWRl
b25fZGV2aWNlICpyZGV2LCBpbnQgaW5kZXgsCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBzdHJ1Y3QgZHJtX2Rpc3BsYXlfbW9kZSAqbW9kZSk7Cj4gK3ZvaWQgcmFkZW9uX2FkZF9h
dG9tX2VuY29kZXIoc3RydWN0IGRybV9kZXZpY2UgKmRldiwgdWludDMyX3QgZW5jb2Rlcl9lbnVt
LAo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgdWludDMyX3Qgc3VwcG9ydGVkX2Rldmlj
ZSwgdTE2IGNhcHMpOwo+ICsKPgo+ICAjZW5kaWYgICAgICAgICAgICAgICAgICAgICAgICAgLyog
X19SQURFT05fQVRPTUJJT1NfSF9fICovCj4gLS0KPiAyLjI1LjEKPgo+IF9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4gZHJpLWRldmVsIG1haWxpbmcgbGlz
dAo+IGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPiBodHRwczovL2xpc3RzLmZyZWVk
ZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2RyaS1kZXZlbApfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4
QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2FtZC1nZngK
