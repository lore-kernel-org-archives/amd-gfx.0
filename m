Return-Path: <SRS0=w1A1=LX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94711C11F66
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Jun 2021 10:53:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DF4061DC7
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Jun 2021 10:53:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DF4061DC7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 186156E840;
	Tue, 29 Jun 2021 10:53:11 +0000 (UTC)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 715606E840
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Jun 2021 10:53:09 +0000 (UTC)
Received: by mail-ej1-x631.google.com with SMTP id gn32so35664389ejc.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Jun 2021 03:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=kLpx4nzT87zEK18Rx96zoUgnnFUnlk1jHABFcShBOIc=;
 b=JWhVJlxmcHeX8/uIvb9xwUixqwJEuVZ01/jIBG5CzVeMBVQdRuP3gKIY/Jo1jZry7N
 QmbVireuB6EdejTTFkZ0yBoPVzGZgmLBygr01BGaYKhOfRHKtKIjmDkTY8r6m5VDsZMX
 ezniNtRVCq4AlxzO5gK2ve2GozPJ+zyItsEAmHnhc0FHfHWdddY47LdbtPR91yxJ1ksQ
 evokslKm3NcJ60bAp/OnicJiZUyAwO6Y9mbChHY+arT8rt6rCciKVmxvllm/joYWNbK3
 pFcd72D4LXW0+7Aan5ONXK4DnpysAEGKCVMvWKr2NkC3j4Y+kf/ZTiip8oiHTDhS49sq
 NVZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=kLpx4nzT87zEK18Rx96zoUgnnFUnlk1jHABFcShBOIc=;
 b=Uv6/mGCwSne0RrYHgPOGeVWjdXAcqeWFSTDJ6QqX+c+cNpFnJmhSdfuTYFzzh6gIgw
 HUxiy5PwQw2dpQZBJQZqkPHX+mjvbX+5trDdqEsWqDaD8yF+ux48CAWrHhNoVRut3ZAU
 ZqlyfkPV3U6U3JU3JrU066i9q6pXWgHm02ROyOJOHey/mJ0eAXOuFXYpt9RIb4L3AIDz
 HCeZ3sg1yzEWNuvNNuRVOff0cnkD/DtL+PbcrGMTQXCEA7E474fwcKs/DEFpA2NfGmRn
 Ivr+vKfqzA6WSadLOCUwmebvk+v+2q+pXXeD2IP8W/KO2K7Dyh9L1Fut1wXavL+qOjKc
 K21A==
X-Gm-Message-State: AOAM532h/ASnQJU1szBcQFycSao5wl7ASAo/L6JGHOeO1yn5+io4322E
 8h2khCFVU7oBgTiIf+XupbN3HyTKwI4=
X-Google-Smtp-Source: ABdhPJwcXxfgusBEaJEEWYdKIwP64raRtTKJn6eKGBT554y8S9dKGv4qWo/iBat+dKlhpybepZVevA==
X-Received: by 2002:a17:906:474e:: with SMTP id
 j14mr30212022ejs.9.1624963988052; 
 Tue, 29 Jun 2021 03:53:08 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:acb7:5516:6a55:2bf5?
 ([2a02:908:1252:fb60:acb7:5516:6a55:2bf5])
 by smtp.gmail.com with ESMTPSA id h19sm9427607edt.87.2021.06.29.03.53.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Jun 2021 03:53:07 -0700 (PDT)
Subject: Re: [PATCH] drm/amdgpu: Set ttm caching flags during bo allocation
To: Oak Zeng <Oak.Zeng@amd.com>, amd-gfx@lists.freedesktop.org
References: <1624922136-15220-1-git-send-email-Oak.Zeng@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <4389dc51-cca9-ab84-51ca-801aed5f5de0@gmail.com>
Date: Tue, 29 Jun 2021 12:53:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <1624922136-15220-1-git-send-email-Oak.Zeng@amd.com>
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
Cc: Felix.Kuehling@amd.com, James.Zhu@amd.com, christian.koenig@amd.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMjkuMDYuMjEgdW0gMDE6MTUgc2NocmllYiBPYWsgWmVuZzoKPiBUaGUgdHRtIGNhY2hpbmcg
ZmxhZ3MgKHR0bV9jYWNoZWQsIHR0bV93cml0ZV9jb21iaW5lZCBldGMpIGFyZQo+IHVzZWQgdG8g
ZGV0ZXJtaW5lIGEgYnVmZmVyIG9iamVjdCdzIG1hcHBpbmcgYXR0cmlidXRlcyBpbiBib3RoCj4g
Q1BVIHBhZ2UgdGFibGUgYW5kIEdQVSBwYWdlIHRhYmxlICh3aGVuIHRoYXQgYnVmZmVyIGlzIGFs
c28KPiBhY2Nlc3NlZCBieSBHUFUpLiBDdXJyZW50bHkgdGhlIHR0bSBjYWNoaW5nIGZsYWdzIGFy
ZSBzZXQgaW4KPiBmdW5jdGlvbiBhbWRncHVfdHRtX2lvX21lbV9yZXNlcnZlIHdoaWNoIGlzIGNh
bGxlZCBkdXJpbmcKPiBEUk1fQU1ER1BVX0dFTV9NTUFQIGlvY3RsLiBUaGlzIGhhcyBhIHByb2Js
ZW0gc2luY2UgdGhlIEdQVQo+IG1hcHBpbmcgb2YgdGhlIGJ1ZmZlciBvYmplY3QgKGlvY3RsIERS
TV9BTURHUFVfR0VNX1ZBKSBjYW4KPiBoYXBwZW4gZWFybGllciB0aGFuIHRoZSBtbWFwIHRpbWUs
IHRodXMgdGhlIEdQVSBwYWdlIHRhYmxlCj4gdXBkYXRlIGNvZGUgY2FuJ3QgcGljayB1cCB0aGUg
cmlnaHQgdHRtIGNhY2hpbmcgZmxhZ3MgdG8KPiBkZWNpZGUgdGhlIHJpZ2h0IEdQVSBwYWdlIHRh
YmxlIGF0dHJpYnV0ZXMuCj4KPiBUaGlzIHBhdGNoIG1vdmVzIHRoZSB0dG0gY2FjaGluZyBmbGFn
cyBzZXR0aW5nIHRvIGZ1bmN0aW9uCj4gYW1kZ3B1X3ZyYW1fbWdyX25ldyAtIHRoaXMgZnVuY3Rp
b24gaXMgY2FsbGVkIGR1cmluZyB0aGUKPiBmaXJzdCBzdGVwIG9mIGEgYnVmZmVyIG9iamVjdCBj
cmVhdGUgKGVnLCBEUk1fQU1ER1BVX0dFTV9DUkVBVEUpCj4gc28gdGhlIGxhdGVyIGJvdGggQ1BV
IGFuZCBHUFUgbWFwcGluZyBmdW5jdGlvbiBjYWxscyB3aWxsCj4gcGljayB1cCB0aGlzIGZsYWcg
Zm9yIENQVS9HUFUgcGFnZSB0YWJsZSBzZXQgdXAuCj4KPiBTaWduZWQtb2ZmLWJ5OiBPYWsgWmVu
ZyA8T2FrLlplbmdAYW1kLmNvbT4KPiBTdWdnZXN0ZWQtYnk6IENocmlzdGlhbiBLb2VuaWcgPENo
cmlzdGlhbi5Lb2VuaWdAYW1kLmNvbT4KClJldmlld2VkLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxj
aHJpc3RpYW4ua29lbmlnQGFtZC5jb20+Cgo+IC0tLQo+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X3R0bS5jICAgICAgfCA0IC0tLS0KPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV92cmFtX21nci5jIHwgNSArKysrKwo+ICAgMiBmaWxlcyBjaGFuZ2VkLCA1
IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3R0bS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X3R0bS5jCj4gaW5kZXggNjI5NzM2My4uOTNhY2Y2ZiAxMDA2NDQKPiAtLS0gYS9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdHRtLmMKPiArKysgYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdHRtLmMKPiBAQCAtNjA3LDEwICs2MDcsNiBAQCBzdGF0
aWMgaW50IGFtZGdwdV90dG1faW9fbWVtX3Jlc2VydmUoc3RydWN0IHR0bV9kZXZpY2UgKmJkZXYs
Cj4gICAKPiAgIAkJbWVtLT5idXMub2Zmc2V0ICs9IGFkZXYtPmdtYy5hcGVyX2Jhc2U7Cj4gICAJ
CW1lbS0+YnVzLmlzX2lvbWVtID0gdHJ1ZTsKPiAtCQlpZiAoYWRldi0+Z21jLnhnbWkuY29ubmVj
dGVkX3RvX2NwdSkKPiAtCQkJbWVtLT5idXMuY2FjaGluZyA9IHR0bV9jYWNoZWQ7Cj4gLQkJZWxz
ZQo+IC0JCQltZW0tPmJ1cy5jYWNoaW5nID0gdHRtX3dyaXRlX2NvbWJpbmVkOwo+ICAgCQlicmVh
azsKPiAgIAlkZWZhdWx0Ogo+ICAgCQlyZXR1cm4gLUVJTlZBTDsKPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZyYW1fbWdyLmMgYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfdnJhbV9tZ3IuYwo+IGluZGV4IGE1MmUxN2UuLjZjYjY2ZWIg
MTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZyYW1fbWdy
LmMKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdnJhbV9tZ3IuYwo+
IEBAIC00NTQsNiArNDU0LDExIEBAIHN0YXRpYyBpbnQgYW1kZ3B1X3ZyYW1fbWdyX25ldyhzdHJ1
Y3QgdHRtX3Jlc291cmNlX21hbmFnZXIgKm1hbiwKPiAgIAlpZiAoaSA9PSAxKQo+ICAgCQltZW0t
PnBsYWNlbWVudCB8PSBUVE1fUExfRkxBR19DT05USUdVT1VTOwo+ICAgCj4gKwlpZiAoYWRldi0+
Z21jLnhnbWkuY29ubmVjdGVkX3RvX2NwdSkKPiArCQltZW0tPmJ1cy5jYWNoaW5nID0gdHRtX2Nh
Y2hlZDsKPiArCWVsc2UKPiArCQltZW0tPmJ1cy5jYWNoaW5nID0gdHRtX3dyaXRlX2NvbWJpbmVk
Owo+ICsKPiAgIAlhdG9taWM2NF9hZGQodmlzX3VzYWdlLCAmbWdyLT52aXNfdXNhZ2UpOwo+ICAg
CW1lbS0+bW1fbm9kZSA9IG5vZGVzOwo+ICAgCXJldHVybiAwOwoKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdm
eEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFp
bG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
