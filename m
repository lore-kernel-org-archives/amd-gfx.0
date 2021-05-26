Return-Path: <SRS0=Zxj3=KV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C470FC47088
	for <amd-gfx@archiver.kernel.org>; Wed, 26 May 2021 02:24:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86DCC6142B
	for <amd-gfx@archiver.kernel.org>; Wed, 26 May 2021 02:24:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86DCC6142B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 200726EB62;
	Wed, 26 May 2021 02:24:35 +0000 (UTC)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 23CE56EB61;
 Wed, 26 May 2021 02:24:33 +0000 (UTC)
Received: by mail-ot1-x32f.google.com with SMTP id
 i14-20020a9d624e0000b029033683c71999so19431164otk.5; 
 Tue, 25 May 2021 19:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=8/0UlIoa5BxVLTVf3fq7Bs3VS9aphKLm905opuNfYBg=;
 b=JeFb6Z+IEgbcvkYetzS4rF18s1kdEJhNaPsyXpKwCuJmX/sVsvAE42bLuxU6lPslKC
 kOvwWhHEcGBr0ql0pbQiL4jETjilgtEf6N3uk+z05suyEbmnaVBjgempZZbvBEjdJnP1
 a0bIHyqUH9AgZRskX3eUPgn0eozBbua3ONQasfXlGCKJxZRJE6fmNYZ6BeEcv7zaWM0b
 7eOSrJcOpc92LzuB3O7ED+7w0si9c7v3+OXzyDKqngYTZB0CV+sL+u5RvDIXo0o6UHCR
 X9e/QgzP3sVk59a5EbK2MW3loT34RFAP7P3yO+k8zZKGGY8MqgGHTK3ec3zpmx4u2mzu
 UIHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=8/0UlIoa5BxVLTVf3fq7Bs3VS9aphKLm905opuNfYBg=;
 b=VvfgF6pM2pF+0s+u62HEAgVf/MbWy0nj2vctCZsLWn1SSvUdg/qfJNE8u0+g7/zrFq
 qf/EZLXijc77FLTnPRrfFww07ff/+Mg2kD7mk5sUp6f4noa7ANm9m7zeoWAtkbNIshDV
 4FuM865+fd+RBF9b9s1pEGhzrqkcVTeoF2RJLKbZ4BGa3WVrVRW4W+O4HZ45CC+1mNVI
 kn4bW3Y2E+CTF5d61QZRADOTEB3bJMYNfQKZYcScPuzxB8DyXXxrNvkBobaxC8mjQvFT
 qOkLMLI/gZAhr7IvtSpu8D1RFZDN1IGvH495VI4ZqEBN5AUDnI9mi+qYQuUXlWKlC9aR
 rEwA==
X-Gm-Message-State: AOAM53322OraYrjPSnrgEkFXeEpfoYXvhh9Euf+c9CMW+v9ZqDSh/N0y
 WPa+05XrNM/B5sE8sLq97wF1O/6mklriWSOVqmZMYI7M
X-Google-Smtp-Source: ABdhPJw50VYgqV7PLoQ6GPPAq/UEjsBpe0xm6uzc8jArabsew4i+7bf4hP6L92Oz4AvOTkT+1L5E20PXLMIeydAId74=
X-Received: by 2002:a9d:57cd:: with SMTP id q13mr519904oti.23.1621995872545;
 Tue, 25 May 2021 19:24:32 -0700 (PDT)
MIME-Version: 1.0
References: <1621929101-24607-1-git-send-email-zhangshaokun@hisilicon.com>
In-Reply-To: <1621929101-24607-1-git-send-email-zhangshaokun@hisilicon.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 25 May 2021 22:24:21 -0400
Message-ID: <CADnq5_PMJR0zmJpK6ysSOEoxEA93gA87E-jG-T8tFre4ersTjw@mail.gmail.com>
Subject: Re: [PATCH] drm/radeon: remove the repeated declaration
To: Shaokun Zhang <zhangshaokun@hisilicon.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QXBwbGllZC4gIFRoYW5rcyEKCkFsZXgKCk9uIFR1ZSwgTWF5IDI1LCAyMDIxIGF0IDM6NTEgQU0g
U2hhb2t1biBaaGFuZwo8emhhbmdzaGFva3VuQGhpc2lsaWNvbi5jb20+IHdyb3RlOgo+Cj4gRnVu
Y3Rpb24gJ3IzMDBfbWNfd2FpdF9mb3JfaWRsZScgYW5kICdyNjAwX21jX3dhaXRfZm9yX2lkbGUn
Cj4gYXJlIGRlY2xhcmVkIHR3aWNlLCByZW1vdmUgdGhlIHJlcGVhdGVkIGRlY2xhcmF0aW9uLgo+
Cj4gQ2M6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KPiBDYzogIkNo
cmlzdGlhbiBLw7ZuaWciIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+Cj4gU2lnbmVkLW9mZi1i
eTogU2hhb2t1biBaaGFuZyA8emhhbmdzaGFva3VuQGhpc2lsaWNvbi5jb20+Cj4gLS0tCj4gIGRy
aXZlcnMvZ3B1L2RybS9yYWRlb24vcmFkZW9uX2FzaWMuaCB8IDIgLS0KPiAgMSBmaWxlIGNoYW5n
ZWQsIDIgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL3JhZGVv
bi9yYWRlb25fYXNpYy5oIGIvZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fYXNpYy5oCj4g
aW5kZXggMWNmMmE1ZTBkOTFkLi4xZTAwZjZiOTlmOTQgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9n
cHUvZHJtL3JhZGVvbi9yYWRlb25fYXNpYy5oCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL3JhZGVv
bi9yYWRlb25fYXNpYy5oCj4gQEAgLTE4Nyw3ICsxODcsNiBAQCBleHRlcm4gaW50IHJ2MzcwX3Bj
aWVfZ2FydF9pbml0KHN0cnVjdCByYWRlb25fZGV2aWNlICpyZGV2KTsKPiAgZXh0ZXJuIHZvaWQg
cnYzNzBfcGNpZV9nYXJ0X2Zpbmkoc3RydWN0IHJhZGVvbl9kZXZpY2UgKnJkZXYpOwo+ICBleHRl
cm4gaW50IHJ2MzcwX3BjaWVfZ2FydF9lbmFibGUoc3RydWN0IHJhZGVvbl9kZXZpY2UgKnJkZXYp
Owo+ICBleHRlcm4gdm9pZCBydjM3MF9wY2llX2dhcnRfZGlzYWJsZShzdHJ1Y3QgcmFkZW9uX2Rl
dmljZSAqcmRldik7Cj4gLWV4dGVybiBpbnQgcjMwMF9tY193YWl0X2Zvcl9pZGxlKHN0cnVjdCBy
YWRlb25fZGV2aWNlICpyZGV2KTsKPgo+ICAvKgo+ICAgKiByNDIwLHI0MjMscnY0MTAKPiBAQCAt
NDA0LDcgKzQwMyw2IEBAIHZvaWQgcjYwMF9oZG1pX3VwZGF0ZV9BQ1Ioc3RydWN0IGRybV9lbmNv
ZGVyICplbmNvZGVyLCB1aW50MzJfdCBjbG9jayk7Cj4gIHZvaWQgcjYwMF9oZG1pX2F1ZGlvX3dv
cmthcm91bmQoc3RydWN0IGRybV9lbmNvZGVyICplbmNvZGVyKTsKPiAgaW50IHI2MDBfaGRtaV9i
dWZmZXJfc3RhdHVzX2NoYW5nZWQoc3RydWN0IGRybV9lbmNvZGVyICplbmNvZGVyKTsKPiAgdm9p
ZCByNjAwX2hkbWlfdXBkYXRlX2F1ZGlvX3NldHRpbmdzKHN0cnVjdCBkcm1fZW5jb2RlciAqZW5j
b2Rlcik7Cj4gLWludCByNjAwX21jX3dhaXRfZm9yX2lkbGUoc3RydWN0IHJhZGVvbl9kZXZpY2Ug
KnJkZXYpOwo+ICB1MzIgcjYwMF9nZXRfeGNsayhzdHJ1Y3QgcmFkZW9uX2RldmljZSAqcmRldik7
Cj4gIHVpbnQ2NF90IHI2MDBfZ2V0X2dwdV9jbG9ja19jb3VudGVyKHN0cnVjdCByYWRlb25fZGV2
aWNlICpyZGV2KTsKPiAgaW50IHJ2Nnh4X2dldF90ZW1wKHN0cnVjdCByYWRlb25fZGV2aWNlICpy
ZGV2KTsKPiAtLQo+IDIuNy40Cj4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3Rv
cC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQt
Z2Z4Cg==
