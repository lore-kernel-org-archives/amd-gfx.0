Return-Path: <SRS0=yskd=HN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E33C7C433DB
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Feb 2021 12:29:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C05064DC3
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Feb 2021 12:29:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C05064DC3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD6536EE1B;
	Thu, 11 Feb 2021 12:29:55 +0000 (UTC)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 785526EE1B
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Feb 2021 12:29:54 +0000 (UTC)
Received: by mail-ed1-x533.google.com with SMTP id s3so6733935edi.7
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Feb 2021 04:29:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=XQ8CYBt5oApppjYWDVdOBCUgLjOHY0QXJ5Fax3nrvAw=;
 b=gc/SldSuUiPW1gtrQ3vpcC5zvTIDMOXvhdoVCl+8xEuR9X6pw3lJvUCB6JBX7FarNS
 Aq7KYP3aUi1oSTM1kzxPuq/BFVDnahE5cZugxi9iPnHUDHDvoW7/ddMw+ZkaaqAaidK9
 NAkZQRaWlsO3PXnWN/GB05JVVQn6YHWH5vYcnETWaO0P64heV8NeY8KRhvrSswl+Ikl0
 sSn5my4fOn+OUS6kQUxP8NTsKag46z06rIbf601kdxee0cqoeUx7izfrgdcPE9e3Ux0v
 Cr1p8w9twd58U/MdC3Nr7ypxkOK8EOL3xswKZ35GBPbEYh+5slkNsBCMOlhLgrSDKaQC
 YDyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=XQ8CYBt5oApppjYWDVdOBCUgLjOHY0QXJ5Fax3nrvAw=;
 b=Z+c7NT9dWM91ooTltkfjE9KxDov27mXozESTKAA1XH0zeO5e++qk+5V3y70zoZEKcF
 xXlM3DJkTGImG+e0dzZ339b4e3S0mTzEzsUPDfWpPJ69WgKLcGvdbpfpCOVkVDzJb6i1
 F1FvsV7vliWAuY00BkgdQL4zHh/+3D87I8tF5KtOdUg/YmZg+SzOnIUTApFgSp5jcWJD
 kLA7pWcgaSuf3O4mccCsTQYii+13ORzk0NvoPbpaw33GXSGiJemBJnCf1AzRA7ClRf3K
 KD3cfnV6xrg+L7apsoKwqVwnFXK+iq0WTNogOHW5DiTsgfzXSTqNG2Kb8w3FXLzYtGxG
 mW6w==
X-Gm-Message-State: AOAM531X14KQ05Jz8fGXJzv2ipym2htcktJ0LHZtDCJcm4qYRCzYy86V
 nPWV7NgShxkV3SzS6B9NcqZy+2xYvj1GAA==
X-Google-Smtp-Source: ABdhPJyMqAb5N+KSPpGT3nqvP+r+RweeM3Pok8+JuKUXHdhsSvOSSJLgEpW35qV5v20/97XoW/leXQ==
X-Received: by 2002:a05:6402:d05:: with SMTP id
 eb5mr7992507edb.143.1613046593183; 
 Thu, 11 Feb 2021 04:29:53 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:f390:5f07:f58d:f83a?
 ([2a02:908:1252:fb60:f390:5f07:f58d:f83a])
 by smtp.gmail.com with ESMTPSA id jg33sm3892297ejc.103.2021.02.11.04.29.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Feb 2021 04:29:52 -0800 (PST)
Subject: Re: [PATCH 2/2] drm/radeon: cleanup debugfs
To: Nirmoy Das <nirmoy.das@amd.com>, Christian.Koenig@amd.com
References: <20210211122607.36991-1-nirmoy.das@amd.com>
 <20210211122607.36991-2-nirmoy.das@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <fd98ac0a-d17a-6495-aa97-77d1a2af3328@gmail.com>
Date: Thu, 11 Feb 2021 13:29:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210211122607.36991-2-nirmoy.das@amd.com>
Content-Language: en-US
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
Cc: amd-gfx@lists.freedesktop.org
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMTEuMDIuMjEgdW0gMTM6MjYgc2NocmllYiBOaXJtb3kgRGFzOgo+IFJlbW92ZSB1bm5lY2Vz
c2FyeSBkZWJ1Z2ZzIGRlbnRyaWVzIGFuZCBhbHNvIHJhZGVvbl90dG1fZGVidWdmc19maW5pKCkK
PiBhcyBkcm1fZGVidWdmc19jbGVhbnVwKCkgd2lsbCByZWN1cnNpdmVseSByZW1vdmUgZGVidWdm
cyBmaWxlcy4KPgo+IFNpZ25lZC1vZmYtYnk6IE5pcm1veSBEYXMgPG5pcm1veS5kYXNAYW1kLmNv
bT4KClJldmlld2VkLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5j
b20+Cgo+IC0tLQo+ICAgZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb24uaCAgICAgfCAgNSAt
LS0tLQo+ICAgZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fdHRtLmMgfCAyNCArKysrKy0t
LS0tLS0tLS0tLS0tLS0tLS0KPiAgIDIgZmlsZXMgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspLCAy
NCBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3Jh
ZGVvbi5oIGIvZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb24uaAo+IGluZGV4IGY5ZjU1MDc4
NDU5MC4uMmMwZTNlN2MyOTRkIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24v
cmFkZW9uLmgKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVvbi5oCj4gQEAgLTQ1
NCwxMSArNDU0LDYgQEAgc3RydWN0IHJhZGVvbl9zdXJmYWNlX3JlZyB7Cj4gICBzdHJ1Y3QgcmFk
ZW9uX21tYW4gewo+ICAgCXN0cnVjdCB0dG1fYm9fZGV2aWNlCQliZGV2Owo+ICAgCWJvb2wJCQkJ
aW5pdGlhbGl6ZWQ7Cj4gLQo+IC0jaWYgZGVmaW5lZChDT05GSUdfREVCVUdfRlMpCj4gLQlzdHJ1
Y3QgZGVudHJ5CQkJKnZyYW07Cj4gLQlzdHJ1Y3QgZGVudHJ5CQkJKmd0dDsKPiAtI2VuZGlmCj4g
ICB9Owo+ICAgCj4gICBzdHJ1Y3QgcmFkZW9uX2JvX2xpc3Qgewo+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVvbl90dG0uYyBiL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24v
cmFkZW9uX3R0bS5jCj4gaW5kZXggNDZiZjgzNTI4NGY0Li45ZDE1NmIxMmQyNGMgMTAwNjQ0Cj4g
LS0tIGEvZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fdHRtLmMKPiArKysgYi9kcml2ZXJz
L2dwdS9kcm0vcmFkZW9uL3JhZGVvbl90dG0uYwo+IEBAIC01NSw3ICs1NSw2IEBACj4gICAjaW5j
bHVkZSAicmFkZW9uX3R0bS5oIgo+ICAgCj4gICBzdGF0aWMgaW50IHJhZGVvbl90dG1fZGVidWdm
c19pbml0KHN0cnVjdCByYWRlb25fZGV2aWNlICpyZGV2KTsKPiAtc3RhdGljIHZvaWQgcmFkZW9u
X3R0bV9kZWJ1Z2ZzX2Zpbmkoc3RydWN0IHJhZGVvbl9kZXZpY2UgKnJkZXYpOwo+ICAgCj4gICBz
dHJ1Y3QgcmFkZW9uX2RldmljZSAqcmFkZW9uX2dldF9yZGV2KHN0cnVjdCB0dG1fYm9fZGV2aWNl
ICpiZGV2KQo+ICAgewo+IEBAIC03OTMsNyArNzkyLDcgQEAgdm9pZCByYWRlb25fdHRtX2Zpbmko
c3RydWN0IHJhZGVvbl9kZXZpY2UgKnJkZXYpCj4gICAKPiAgIAlpZiAoIXJkZXYtPm1tYW4uaW5p
dGlhbGl6ZWQpCj4gICAJCXJldHVybjsKPiAtCXJhZGVvbl90dG1fZGVidWdmc19maW5pKHJkZXYp
Owo+ICsKPiAgIAlpZiAocmRldi0+c3RvbGVuX3ZnYV9tZW1vcnkpIHsKPiAgIAkJciA9IHJhZGVv
bl9ib19yZXNlcnZlKHJkZXYtPnN0b2xlbl92Z2FfbWVtb3J5LCBmYWxzZSk7Cj4gICAJCWlmIChy
ID09IDApIHsKPiBAQCAtMTAwOSwxMiArMTAwOCwxMSBAQCBzdGF0aWMgaW50IHJhZGVvbl90dG1f
ZGVidWdmc19pbml0KHN0cnVjdCByYWRlb25fZGV2aWNlICpyZGV2KQo+ICAgCXN0cnVjdCBkcm1f
bWlub3IgKm1pbm9yID0gcmRldi0+ZGRldi0+cHJpbWFyeTsKPiAgIAlzdHJ1Y3QgZGVudHJ5ICpy
b290ID0gbWlub3ItPmRlYnVnZnNfcm9vdDsKPiAgIAo+IC0JcmRldi0+bW1hbi52cmFtID0gZGVi
dWdmc19jcmVhdGVfZmlsZSgicmFkZW9uX3ZyYW0iLCBTX0lGUkVHIHwgU19JUlVHTywKPiAtCQkJ
CQkgICAgICByb290LCByZGV2LAo+IC0JCQkJCSAgICAgICZyYWRlb25fdHRtX3ZyYW1fZm9wcyk7
Cj4gKwlkZWJ1Z2ZzX2NyZWF0ZV9maWxlKCJyYWRlb25fdnJhbSIsIFNfSUZSRUcgfCBTX0lSVUdP
LCByb290LCByZGV2LAo+ICsJCQkgICAgJnJhZGVvbl90dG1fdnJhbV9mb3BzKTsKPiAgIAo+IC0J
cmRldi0+bW1hbi5ndHQgPSBkZWJ1Z2ZzX2NyZWF0ZV9maWxlKCJyYWRlb25fZ3R0IiwgU19JRlJF
RyB8IFNfSVJVR08sCj4gLQkJCQkJICAgICByb290LCByZGV2LCAmcmFkZW9uX3R0bV9ndHRfZm9w
cyk7Cj4gKwlkZWJ1Z2ZzX2NyZWF0ZV9maWxlKCJyYWRlb25fZ3R0IiwgU19JRlJFRyB8IFNfSVJV
R08sIHJvb3QsIHJkZXYsCj4gKwkJCSAgICAmcmFkZW9uX3R0bV9ndHRfZm9wcyk7Cj4gICAKPiAg
IAljb3VudCA9IEFSUkFZX1NJWkUocmFkZW9uX3R0bV9kZWJ1Z2ZzX2xpc3QpOwo+ICAgCj4gQEAg
LTEwMjksMTUgKzEwMjcsMyBAQCBzdGF0aWMgaW50IHJhZGVvbl90dG1fZGVidWdmc19pbml0KHN0
cnVjdCByYWRlb25fZGV2aWNlICpyZGV2KQo+ICAgCXJldHVybiAwOwo+ICAgI2VuZGlmCj4gICB9
Cj4gLQo+IC1zdGF0aWMgdm9pZCByYWRlb25fdHRtX2RlYnVnZnNfZmluaShzdHJ1Y3QgcmFkZW9u
X2RldmljZSAqcmRldikKPiAtewo+IC0jaWYgZGVmaW5lZChDT05GSUdfREVCVUdfRlMpCj4gLQo+
IC0JZGVidWdmc19yZW1vdmUocmRldi0+bW1hbi52cmFtKTsKPiAtCXJkZXYtPm1tYW4udnJhbSA9
IE5VTEw7Cj4gLQo+IC0JZGVidWdmc19yZW1vdmUocmRldi0+bW1hbi5ndHQpOwo+IC0JcmRldi0+
bW1hbi5ndHQgPSBOVUxMOwo+IC0jZW5kaWYKPiAtfQoKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0
cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9s
aXN0aW5mby9hbWQtZ2Z4Cg==
