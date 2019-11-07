Return-Path: <SRS0=ouc1=Y7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A0A8C5DF61
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Nov 2019 12:03:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3AA692187F
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Nov 2019 12:03:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AA692187F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 02D036E433;
	Thu,  7 Nov 2019 12:03:34 +0000 (UTC)
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C8A766E433;
 Thu,  7 Nov 2019 12:03:32 +0000 (UTC)
Received: by mail-wr1-x442.google.com with SMTP id r10so2746834wrx.3;
 Thu, 07 Nov 2019 04:03:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=EeTeFiFJLsbSsb6XGZUqrfgOgX2RV9Kt8D/cgqTJUMQ=;
 b=oxxO2ImKUlGrdQ9gx8uySlUrXNRXm6dAHKbqf5Qqbthz+SJ104LyGRzmKlwSt+jtak
 zpwbFA5iAxBynVpKy2+3pv6WcYqByU0EQ0D7625lR1RWNKyoGHNMG48GHE8ISTA4+Y69
 HaDafJzD33KjEvJFQMymh+G+O/DWq9W/sEmKN5ibo1FU/u4ejPMkJPEqYj7MDljA1T8P
 XyZJiyhIqRLxGAeucod6gVZZ5EI5+BW9hkPZMWosQgr6k2ILtMt10FGXVp1viWM/pjx5
 1C+9y4NyxR6U0mGMSy4a6VY9vpdSU0f+CFS+4UCI7Duj1KtjE0Sb7SbrAn9AmukxwOBn
 nq5w==
X-Gm-Message-State: APjAAAXWxzvDGRkdyImZO8iUVxdTBVKw1/MLK5zXKh8di5hHdg8t11zT
 npI50os7lswGVI/FLAJZ/8s=
X-Google-Smtp-Source: APXvYqwT3DV2EKlRTYPua0XZkd67jKwwWgJRwaOB3yIELbfVVqwwWkiuONxb3DIuQG7bA4NVE4NTFA==
X-Received: by 2002:adf:d1a3:: with SMTP id w3mr2699071wrc.9.1573128211487;
 Thu, 07 Nov 2019 04:03:31 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id g11sm1779815wmh.27.2019.11.07.04.03.30
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 07 Nov 2019 04:03:31 -0800 (PST)
Subject: Re: [PATCH 2/2] drm/radeon: finally fix the racy VMA setup
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
To: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 Alex Deucher <alexander.deucher@amd.com>
References: <20191107120118.2825-1-christian.koenig@amd.com>
 <20191107120118.2825-2-christian.koenig@amd.com>
Message-ID: <2f51742d-a89c-c1a7-2df9-86158bc5b3d4@gmail.com>
Date: Thu, 7 Nov 2019 13:03:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191107120118.2825-2-christian.koenig@amd.com>
Content-Language: en-US
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20161025;
 h=subject:from:to:references:message-id:date:user-agent:mime-version
 :in-reply-to:content-transfer-encoding:content-language;
 bh=EeTeFiFJLsbSsb6XGZUqrfgOgX2RV9Kt8D/cgqTJUMQ=;
 b=hgZaptTRCRrGrtuEEPuz172u521MmVio9O1cYGhIHXFM3rAx+jUp4avdhKdWoOJbHo
 l9BRyeLTlYONcqYQGCeqvv0uuA88zaVeL6Wz1k/4fKQHNiG0yTv236z7fmOBNmJFdu+Y
 kJkdkeVa3BYzkH124cGK2bYixB4ZiD6TbbkJ39u4nCXBKU9OwlQLYUSNHO3wZjpz51Wa
 i+gpOrvoppcii3p/kAKHhMapDjlxcTEgiXJZnB4vlU8Ag/TDo83wVH4jBlztau7vh8+E
 9pd7JYWrkEaAyFaPObCZUU2GJulr1C1tdFtNl1dS6+/G8LYvwsTEaS5yHgfyZ5tK0+7o
 bK8A==
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191107120329.aocvuUvXAZZz23sF9smzuYg8NpuleDVaBljiIUvaRng@z>

SGV5IEFsZXgsCgphbnkgb2JqZWN0aW9ucyB0aGF0IEkgbWVyZ2UgdGhvc2UgdHdvIHBhdGNoZXMg
dGhyb3VnaCBkcm0tbWlzYy1uZXh0PwoKSXQncyBhIGNsZWFudXAgSSB3YW50ZWQgdG8gZG8gZm9y
IHllYXJzIGFuZCBUaG9tYXMgZmluYWxseSBmaXhlZCB1cCBUVE0gCmZvciB0aGlzLgoKQ2hlZXJz
LApDaHJpc3RpYW4uCgpBbSAwNy4xMS4xOSB1bSAxMzowMSBzY2hyaWViIENocmlzdGlhbiBLw7Zu
aWc6Cj4gRnJvbTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2tvZW5pZy5sZWljaHR6dW1lcmtlbkBnbWFp
bC5jb20+Cj4KPiBGaW5hbGx5IGNsZWFuIHVwIHRoZSBWTUEgc2V0dXAgZm9yIHJhZGVvbiBub3cg
dGhhdCBUVE0gZXhwb3J0cyB0aGUKPiBuZWNlc3NhcnkgZnVuY3Rpb25zLgo+Cj4gTm8gZnVuY3Rp
b25hbCBjaGFuZ2UsIGJ1dCBvbmx5IGNvbXBpbGUgdGVzdGVkLgo+Cj4gU2lnbmVkLW9mZi1ieTog
Q2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgo+IFJldmlld2VkLWJ5
OiBIdWFuZyBSdWkgPHJheS5odWFuZ0BhbWQuY29tPgo+IC0tLQo+ICAgZHJpdmVycy9ncHUvZHJt
L3JhZGVvbi9yYWRlb25fdHRtLmMgfCAyOSArKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLQo+
ICAgMSBmaWxlIGNoYW5nZWQsIDE0IGluc2VydGlvbnMoKyksIDE1IGRlbGV0aW9ucygtKQo+Cj4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vcmFkZW9uX3R0bS5jIGIvZHJpdmVy
cy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fdHRtLmMKPiBpbmRleCAwOThiYzlmNDBiOTguLjkxOTkz
YTIzM2NiMCAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVvbl90dG0u
Ywo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vcmFkZW9uX3R0bS5jCj4gQEAgLTg4MSw5
ICs4ODEsNiBAQCB2b2lkIHJhZGVvbl90dG1fc2V0X2FjdGl2ZV92cmFtX3NpemUoc3RydWN0IHJh
ZGVvbl9kZXZpY2UgKnJkZXYsIHU2NCBzaXplKQo+ICAgCW1hbi0+c2l6ZSA9IHNpemUgPj4gUEFH
RV9TSElGVDsKPiAgIH0KPiAgIAo+IC1zdGF0aWMgc3RydWN0IHZtX29wZXJhdGlvbnNfc3RydWN0
IHJhZGVvbl90dG1fdm1fb3BzOwo+IC1zdGF0aWMgY29uc3Qgc3RydWN0IHZtX29wZXJhdGlvbnNf
c3RydWN0ICp0dG1fdm1fb3BzID0gTlVMTDsKPiAtCj4gICBzdGF0aWMgdm1fZmF1bHRfdCByYWRl
b25fdHRtX2ZhdWx0KHN0cnVjdCB2bV9mYXVsdCAqdm1mKQo+ICAgewo+ICAgCXN0cnVjdCB0dG1f
YnVmZmVyX29iamVjdCAqYm87Cj4gQEAgLTg5MSwzNCArODg4LDM2IEBAIHN0YXRpYyB2bV9mYXVs
dF90IHJhZGVvbl90dG1fZmF1bHQoc3RydWN0IHZtX2ZhdWx0ICp2bWYpCj4gICAJdm1fZmF1bHRf
dCByZXQ7Cj4gICAKPiAgIAlibyA9IChzdHJ1Y3QgdHRtX2J1ZmZlcl9vYmplY3QgKil2bWYtPnZt
YS0+dm1fcHJpdmF0ZV9kYXRhOwo+IC0JaWYgKGJvID09IE5VTEwpIHsKPiArCWlmIChibyA9PSBO
VUxMKQo+ICAgCQlyZXR1cm4gVk1fRkFVTFRfTk9QQUdFOwo+IC0JfQo+ICsKPiAgIAlyZGV2ID0g
cmFkZW9uX2dldF9yZGV2KGJvLT5iZGV2KTsKPiAgIAlkb3duX3JlYWQoJnJkZXYtPnBtLm1jbGtf
bG9jayk7Cj4gLQlyZXQgPSB0dG1fdm1fb3BzLT5mYXVsdCh2bWYpOwo+ICsJcmV0ID0gdHRtX2Jv
X3ZtX2ZhdWx0KHZtZik7Cj4gICAJdXBfcmVhZCgmcmRldi0+cG0ubWNsa19sb2NrKTsKPiAgIAly
ZXR1cm4gcmV0Owo+ICAgfQo+ICAgCj4gK3N0YXRpYyBzdHJ1Y3Qgdm1fb3BlcmF0aW9uc19zdHJ1
Y3QgcmFkZW9uX3R0bV92bV9vcHMgPSB7Cj4gKwkuZmF1bHQgPSByYWRlb25fdHRtX2ZhdWx0LAo+
ICsJLm9wZW4gPSB0dG1fYm9fdm1fb3BlbiwKPiArCS5jbG9zZSA9IHR0bV9ib192bV9jbG9zZSwK
PiArCS5hY2Nlc3MgPSB0dG1fYm9fdm1fYWNjZXNzCj4gK307Cj4gKwo+ICAgaW50IHJhZGVvbl9t
bWFwKHN0cnVjdCBmaWxlICpmaWxwLCBzdHJ1Y3Qgdm1fYXJlYV9zdHJ1Y3QgKnZtYSkKPiAgIHsK
PiAgIAlpbnQgcjsKPiAgIAlzdHJ1Y3QgZHJtX2ZpbGUgKmZpbGVfcHJpdiA9IGZpbHAtPnByaXZh
dGVfZGF0YTsKPiAgIAlzdHJ1Y3QgcmFkZW9uX2RldmljZSAqcmRldiA9IGZpbGVfcHJpdi0+bWlu
b3ItPmRldi0+ZGV2X3ByaXZhdGU7Cj4gICAKPiAtCWlmIChyZGV2ID09IE5VTEwpIHsKPiArCWlm
IChyZGV2ID09IE5VTEwpCj4gICAJCXJldHVybiAtRUlOVkFMOwo+IC0JfQo+ICsKPiAgIAlyID0g
dHRtX2JvX21tYXAoZmlscCwgdm1hLCAmcmRldi0+bW1hbi5iZGV2KTsKPiAtCWlmICh1bmxpa2Vs
eShyICE9IDApKSB7Cj4gKwlpZiAodW5saWtlbHkociAhPSAwKSkKPiAgIAkJcmV0dXJuIHI7Cj4g
LQl9Cj4gLQlpZiAodW5saWtlbHkodHRtX3ZtX29wcyA9PSBOVUxMKSkgewo+IC0JCXR0bV92bV9v
cHMgPSB2bWEtPnZtX29wczsKPiAtCQlyYWRlb25fdHRtX3ZtX29wcyA9ICp0dG1fdm1fb3BzOwo+
IC0JCXJhZGVvbl90dG1fdm1fb3BzLmZhdWx0ID0gJnJhZGVvbl90dG1fZmF1bHQ7Cj4gLQl9Cj4g
Kwo+ICAgCXZtYS0+dm1fb3BzID0gJnJhZGVvbl90dG1fdm1fb3BzOwo+ICAgCXJldHVybiAwOwo+
ICAgfQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1k
LWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9s
aXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
