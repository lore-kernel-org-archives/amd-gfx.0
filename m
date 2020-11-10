Return-Path: <SRS0=ErGV=EQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62C6BC55ABD
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Nov 2020 21:54:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E094220781
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Nov 2020 21:54:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ay84fKoh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E094220781
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9408D89CAF;
	Tue, 10 Nov 2020 21:54:20 +0000 (UTC)
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com
 [IPv6:2a00:1450:4864:20::344])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0EF7389C84;
 Tue, 10 Nov 2020 21:54:19 +0000 (UTC)
Received: by mail-wm1-x344.google.com with SMTP id 19so3155762wmf.1;
 Tue, 10 Nov 2020 13:54:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=PYSQECYWsGYFKrZqUDhKu6w9mUnPdTNDs/R0kOX8Gp8=;
 b=Ay84fKohhNeoetn7A1noz1LMP4/JcivNMei/bL7dpmVlkC7lxjY/gPzlsJ6p8MHLjp
 HjYrSz7EKgmgvAwjdlrMwhD+Uw/N2Y2jR1CUd9vEq33NojI6kzrccb1qcsVY6e5yE5Wz
 Js6WovvWsJ6pBKS/Ue1Pl8P4fqV56u2U7e6003O6CASOJCpB8dviZwJOFPmZJdXLDALJ
 RN0cLUGO9Igynqamo4zCbKTgJVuicwWnX5mKPOtovl5caU53+K9a17vcyOGaPjq92/eh
 ofRD2UInpTnvO5Vrk3ZAL9U9g0FBW9+eviQaWwk2JoiW8SykVqhxfgjCxf0jVgbci+na
 vKAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=PYSQECYWsGYFKrZqUDhKu6w9mUnPdTNDs/R0kOX8Gp8=;
 b=l/Ib9HvuyMULru2jXXmxsEsIXDxPYQgkLQWVrYrI5Fo6Uax4oVw7yVuI/7Pu4CaCsU
 5I6aAXbDE65SlUWPklpmoMmQn8a2q7Dx3ffcT4RwNzcziOAg8kyxBxjyNbobsR+C1uUE
 YXaC7s5yFVGtNu5zP2JWWEsWHy603RXfvshD8XJen2UMF8qGldJ4nKIgzp+zXJFa0Mzc
 yfwzx5ApuXHBYo3Av9BT9eRFN0ZNFMoljSrID1kdeCAl8CGo3HCt5MurVfwkghD829dE
 jde49ITyGoXz6QjnqyYNAl7WAm8m6KIXvI+dH02Gg1sKCjcbY0N0RDojQ1H+Tzz5NvmH
 7syQ==
X-Gm-Message-State: AOAM530nJTMSLgIvdm9qWypT1SaqGsqkV6yCi5uuoNwcR/eQKNnHfU9a
 9b+XS5A6rMt83vsZSrd3WLHavc2ADzsSzxjUAtc=
X-Google-Smtp-Source: ABdhPJxf8qsJ98ELnSkIJQvo2S+iZQzFm0f6lInecTgvStPVrRxEgQySGqNRmNxwdcvwALGGfJ7EpXnbXGMFhtPwpto=
X-Received: by 2002:a1c:46c6:: with SMTP id t189mr172513wma.79.1605045257699; 
 Tue, 10 Nov 2020 13:54:17 -0800 (PST)
MIME-Version: 1.0
References: <20201106214949.2042120-1-lee.jones@linaro.org>
 <20201106214949.2042120-7-lee.jones@linaro.org>
In-Reply-To: <20201106214949.2042120-7-lee.jones@linaro.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 10 Nov 2020 16:54:05 -0500
Message-ID: <CADnq5_NoRGAd+mgZT8i47-U-CnxO=bWD83FVKs0rNnKEoCYxYA@mail.gmail.com>
Subject: Re: [PATCH 06/19] drm/radeon/atom: Move prototype into shared location
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

T24gRnJpLCBOb3YgNiwgMjAyMCBhdCA0OjUwIFBNIExlZSBKb25lcyA8bGVlLmpvbmVzQGxpbmFy
by5vcmc+IHdyb3RlOgo+Cj4gQm90aCBzb3VyY2UgZmlsZXMgaW5jbHVkZSBhdG9tLmgsIHdoaWNo
IHNlZW1zIGxpa2UgYSByZWFzb25hYmxlCj4gbG9jYXRpb24gdG8gcGxhY2UgYW4gYXRvbSBiYXNl
ZCBmdW5jdGlvbiBpbnRvLgo+Cj4gRml4ZXMgdGhlIGZvbGxvd2luZyBXPTEga2VybmVsIGJ1aWxk
IHdhcm5pbmcocyk6Cj4KPiAgZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fYXRvbWJpb3Mu
YzoxNzkxOjY6IHdhcm5pbmc6IG5vIHByZXZpb3VzIHByb3RvdHlwZSBmb3Ig4oCYcmFkZW9uX2F0
b21fZ2V0X3R2X3RpbWluZ3PigJkgWy1XbWlzc2luZy1wcm90b3R5cGVzXQo+ICAxNzkxIHwgYm9v
bCByYWRlb25fYXRvbV9nZXRfdHZfdGltaW5ncyhzdHJ1Y3QgcmFkZW9uX2RldmljZSAqcmRldiwg
aW50IGluZGV4LAo+ICB8IF5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+Cj4KPiBDYzogQWxleCBE
ZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgo+IENjOiAiQ2hyaXN0aWFuIEvDtm5p
ZyIgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KPiBDYzogRGF2aWQgQWlybGllIDxhaXJsaWVk
QGxpbnV4LmllPgo+IENjOiBEYW5pZWwgVmV0dGVyIDxkYW5pZWxAZmZ3bGwuY2g+Cj4gQ2M6IGFt
ZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4gQ2M6IGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVz
a3RvcC5vcmcKPiBTaWduZWQtb2ZmLWJ5OiBMZWUgSm9uZXMgPGxlZS5qb25lc0BsaW5hcm8ub3Jn
Pgo+IC0tLQo+ICBkcml2ZXJzL2dwdS9kcm0vcmFkZW9uL2F0b20uaCAgICAgICAgICAgICAgfCA2
ICsrKysrKwo+ICBkcml2ZXJzL2dwdS9kcm0vcmFkZW9uL2F0b21iaW9zX2VuY29kZXJzLmMgfCA0
IC0tLS0KPiAgMiBmaWxlcyBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0p
Cj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9hdG9tLmggYi9kcml2ZXJz
L2dwdS9kcm0vcmFkZW9uL2F0b20uaAo+IGluZGV4IDFiZjA2YzkxY2Q5NTkuLmNiOTNiODMxMTRk
YmUgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9hdG9tLmgKPiArKysgYi9k
cml2ZXJzL2dwdS9kcm0vcmFkZW9uL2F0b20uaAo+IEBAIC0xNTQsNiArMTU0LDEyIEBAIGJvb2wg
YXRvbV9wYXJzZV9kYXRhX2hlYWRlcihzdHJ1Y3QgYXRvbV9jb250ZXh0ICpjdHgsIGludCBpbmRl
eCwgdWludDE2X3QgKnNpemUsCj4gIGJvb2wgYXRvbV9wYXJzZV9jbWRfaGVhZGVyKHN0cnVjdCBh
dG9tX2NvbnRleHQgKmN0eCwgaW50IGluZGV4LAo+ICAgICAgICAgICAgICAgICAgICAgICAgICAg
IHVpbnQ4X3QgKmZyZXYsIHVpbnQ4X3QgKmNyZXYpOwo+ICBpbnQgYXRvbV9hbGxvY2F0ZV9mYl9z
Y3JhdGNoKHN0cnVjdCBhdG9tX2NvbnRleHQgKmN0eCk7Cj4gKwo+ICtzdHJ1Y3QgZHJtX2Rpc3Bs
YXlfbW9kZTsKPiArc3RydWN0IHJhZGVvbl9kZXZpY2U7Cj4gK2Jvb2wgcmFkZW9uX2F0b21fZ2V0
X3R2X3RpbWluZ3Moc3RydWN0IHJhZGVvbl9kZXZpY2UgKnJkZXYsIGludCBpbmRleCwKPiArICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCBkcm1fZGlzcGxheV9tb2RlICptb2Rl
KTsKPiArCgpJJ2QgcHJlZmVyIHRvIGFkZCByYWRlb25fYXRvbWJpb3MuaCBmb3IgYWxsIG9mIHRo
ZSBzdHVmZiBleHBvcnRlZCBmcm9tCnJhZGVvbl9hdG9tYmlvcy5jLiAgV2hlbiB5b3UgYWRkIHRo
ZSAuaCBmaWxlLCBwbGVhc2UgdGFrZSB0aGUKY29weXJpZ2h0IGxpY2Vuc2UgZnJvbSB0aGUgLmMg
ZmlsZSB3aGljaCBpbXBsZW1lbnRzIHRoZSBmdW5jdGlvbnMuCgpUaGFua3MsCgpBbGV4Cgo+ICAj
aW5jbHVkZSAiYXRvbS10eXBlcy5oIgo+ICAjaW5jbHVkZSAiYXRvbWJpb3MuaCIKPiAgI2luY2x1
ZGUgIk9iamVjdElELmgiCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vYXRv
bWJpb3NfZW5jb2RlcnMuYyBiL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vYXRvbWJpb3NfZW5jb2Rl
cnMuYwo+IGluZGV4IGNjNWVlMWIzYWY4NGYuLjg1ZjkwM2NhZjEyZTEgMTAwNjQ0Cj4gLS0tIGEv
ZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9hdG9tYmlvc19lbmNvZGVycy5jCj4gKysrIGIvZHJpdmVy
cy9ncHUvZHJtL3JhZGVvbi9hdG9tYmlvc19lbmNvZGVycy5jCj4gQEAgLTI5NiwxMCArMjk2LDYg
QEAgc3RhdGljIHZvaWQgcmFkZW9uX2F0b21fYmFja2xpZ2h0X2V4aXQoc3RydWN0IHJhZGVvbl9l
bmNvZGVyICplbmNvZGVyKQo+Cj4gICNlbmRpZgo+Cj4gLS8qIGV2aWwgYnV0IGluY2x1ZGluZyBh
dG9tYmlvcy5oIGlzIG11Y2ggd29yc2UgKi8KPiAtYm9vbCByYWRlb25fYXRvbV9nZXRfdHZfdGlt
aW5ncyhzdHJ1Y3QgcmFkZW9uX2RldmljZSAqcmRldiwgaW50IGluZGV4LAo+IC0gICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgc3RydWN0IGRybV9kaXNwbGF5X21vZGUgKm1vZGUpOwo+IC0K
PiAgc3RhdGljIGJvb2wgcmFkZW9uX2F0b21fbW9kZV9maXh1cChzdHJ1Y3QgZHJtX2VuY29kZXIg
KmVuY29kZXIsCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBjb25zdCBzdHJ1
Y3QgZHJtX2Rpc3BsYXlfbW9kZSAqbW9kZSwKPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIHN0cnVjdCBkcm1fZGlzcGxheV9tb2RlICphZGp1c3RlZF9tb2RlKQo+IC0tCj4gMi4y
NS4xCj4KPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+
IGRyaS1kZXZlbCBtYWlsaW5nIGxpc3QKPiBkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
Cj4gaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9kcmktZGV2
ZWwKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdm
eCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0
cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
