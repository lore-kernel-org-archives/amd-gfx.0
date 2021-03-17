Return-Path: <SRS0=2fSF=IP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F7D2C433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Mar 2021 15:18:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE53564F73
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Mar 2021 15:18:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE53564F73
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F8AD6E5D1;
	Wed, 17 Mar 2021 15:18:03 +0000 (UTC)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3BD0F6E5C3
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Mar 2021 15:18:02 +0000 (UTC)
Received: by mail-ed1-x532.google.com with SMTP id u4so2716595edv.9
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Mar 2021 08:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=3pPE2ekJo6BCDeRFtq+Wgf9EVfGsXhF54UQb644G1Y4=;
 b=VxaJ/rzWGy9OY1SGUXbfYFuVzkIe9R+mU8IFfcZWG1PVZaP8oeiqmfw2/YfrhEKCrh
 EOx6dMNuYH1N5hgzYJMA3Og9X6HpslU21vA5CL2g9B2OgRlZWGdfZGJ8vkrTt2L5DF7C
 cToAHxfEXoa0d1zDVUBeY9px4GYb/ez8gylutaZPGm5PZKFwYJbU44aqCGQxljy1L46k
 1BKYjxFnF8KzLQIY1fhmV3wK8xFjgAm7y3UoOenpgWiWUFGcW1Sa9X/RPKpA/fFGYEig
 Cy1k9RWQlSk+fniI881Obj8kzaLa/H4BYAjagAscJPhUJf0Gmjb2gzsO8Vj3zGyLlvd5
 4vXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=3pPE2ekJo6BCDeRFtq+Wgf9EVfGsXhF54UQb644G1Y4=;
 b=rdX11/awkru6hyvXGguHg9jzxJuG/5slymTao1P/NFrTIfV+9AD4CI4qqnhcDWh041
 rfyxUur7lMOEeaEbB22S0CJ/1iAmcKmK+TKQDFSt0iVwWhKA1DTjwd/Nan0FCqiM4k8A
 wdums7BmLsD/zSz7gE48SAfoJWhZIAlkXo82ZBX87QZf+IgEjFADuNfi6X4uILAw24HH
 w93yTnkM9/Nb4jWZX9sgg/WJmUnB1no2m3QHsNWHSNXhxopBQiGdIlcfM9s2Ys8R6RS9
 eXmzu1hkDVA7Q8vQiVf6XXUPji39hSZjPyqVLGE1LcmUk49yvos0SdK3m8+3gey9HEIi
 qy4A==
X-Gm-Message-State: AOAM531WjRqCrfR8XDTXRpAYvWC9lysFvq+2R+nNV/AKLp8ZbQkQHhk5
 C458JXxet/4TguREC360Ijk=
X-Google-Smtp-Source: ABdhPJwnVIQbZAYToHudxego+RPWAg8dFIubIWENOzn1Ss6iuCaAovxNicH4V1kFMkcNZ8w+FR2aIw==
X-Received: by 2002:a05:6402:5203:: with SMTP id
 s3mr43147844edd.79.1615994280977; 
 Wed, 17 Mar 2021 08:18:00 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:ccdd:b6ca:11e:5cc5?
 ([2a02:908:1252:fb60:ccdd:b6ca:11e:5cc5])
 by smtp.gmail.com with ESMTPSA id lm24sm11611327ejb.53.2021.03.17.08.18.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Mar 2021 08:18:00 -0700 (PDT)
Subject: Re: [PATCH V2] radeon: use kvcalloc for relocs and chunks
To: Chen Li <chenli@uniontech.com>, amd-gfx@lists.freedesktop.org,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
References: <87wnu5eszm.wl-chenli@uniontech.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <0145c9dc-26ec-8145-ff3f-44c7376ae121@gmail.com>
Date: Wed, 17 Mar 2021 16:17:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <87wnu5eszm.wl-chenli@uniontech.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMTcuMDMuMjEgdW0gMTU6NDggc2NocmllYiBDaGVuIExpOgo+Cj4ga3ZtYWxsb2NfYXJyYXkg
KyBfX0dGUF9aRVJPIGlzIHRoZSBzYW1lIHdpdGgga3ZjYWxsb2MuCj4KPiBBcyBmb3IgcC0+Y2h1
bmtzLCBpdCB3aWxsIGJlIHVzZWQgaW46Cj4gYGBgCj4gaWYgKGliX2NodW5rLT5rZGF0YSkKPiAJ
CW1lbWNweShwYXJzZXItPmliLnB0ciwgaWJfY2h1bmstPmtkYXRhLCBpYl9jaHVuay0+bGVuZ3Ro
X2R3ICogNCk7Cj4gYGBgCj4KPiBJZiBjaHVua3MgZG9lc24ndCB6ZXJvIG91dCB3aXRoIF9fR0ZQ
X1pFUk8sIGl0IG1heSBwb2ludCB0byBzb21ld2hlcmUgZWxzZSwgZS5nLiwKPiBgYGAKPiBVbmFi
bGUgdG8gaGFuZGxlIGtlcm5lbCBwYWdpbmcgcmVxdWVzdCBhdCB2aXJ0dWFsIGFkZHJlc3MgMDAw
MDAwMDAwMDAxMDAwMAo+IC4uLgo+IHBjIGlzIGF0IG1lbWNweSsweDg0LzB4MjUwCj4gcmEgaXMg
YXQgcmFkZW9uX2NzX2lvY3RsKzB4MzY4LzB4YjkwIFtyYWRlb25dCj4gYGBgCj4KPiBhZnRlciBh
bGxvY2F0aW5nIGNodW5rcyB3aXRoIF9fR0ZQX0tFUk5FTC9rdmNhbGxvYywgdGhpcyBidWcgaXMg
Zml4ZWQuCj4gRml4ZXM6IDNmY2I0ZjAxZGVlZCAoImRybS9yYWRlb246IFVzZSBrdm1hbGxvYyBm
b3IgQ1MgY2h1bmtzIikKPiBTaWduZWQtb2ZmLWJ5OiBDaGVuIExpIDxjaGVubGlAdW5pb250ZWNo
LmNvbT4KClJldmlld2VkLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFt
ZC5jb20+Cgo+IC0tLQo+Cj4gY2hhbmdlbG9nOgo+ICAgIHYxLT52MjogYWRkIEZpeGVzOiB0YWcK
Pgo+ICAgZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fY3MuYyB8IDYgKysrLS0tCj4gICAx
IGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQo+Cj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vcmFkZW9uX2NzLmMgYi9kcml2ZXJzL2dwdS9k
cm0vcmFkZW9uL3JhZGVvbl9jcy5jCj4gaW5kZXggZmI3MzZlZjlmOWFhLi4wNTk0MzE2ODljMmQg
MTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fY3MuYwo+ICsrKyBi
L2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vcmFkZW9uX2NzLmMKPiBAQCAtOTMsOCArOTMsOCBAQCBz
dGF0aWMgaW50IHJhZGVvbl9jc19wYXJzZXJfcmVsb2NzKHN0cnVjdCByYWRlb25fY3NfcGFyc2Vy
ICpwKQo+ICAgCXAtPmRtYV9yZWxvY19pZHggPSAwOwo+ICAgCS8qIEZJWE1FOiB3ZSBhc3N1bWUg
dGhhdCBlYWNoIHJlbG9jcyB1c2UgNCBkd29yZHMgKi8KPiAgIAlwLT5ucmVsb2NzID0gY2h1bmst
Pmxlbmd0aF9kdyAvIDQ7Cj4gLQlwLT5yZWxvY3MgPSBrdm1hbGxvY19hcnJheShwLT5ucmVsb2Nz
LCBzaXplb2Yoc3RydWN0IHJhZGVvbl9ib19saXN0KSwKPiAtCQkJR0ZQX0tFUk5FTCB8IF9fR0ZQ
X1pFUk8pOwo+ICsJcC0+cmVsb2NzID0ga3ZjYWxsb2MocC0+bnJlbG9jcywgc2l6ZW9mKHN0cnVj
dCByYWRlb25fYm9fbGlzdCksCj4gKwkJCUdGUF9LRVJORUwpOwo+ICAgCWlmIChwLT5yZWxvY3Mg
PT0gTlVMTCkgewo+ICAgCQlyZXR1cm4gLUVOT01FTTsKPiAgIAl9Cj4gQEAgLTI5OSw3ICsyOTks
NyBAQCBpbnQgcmFkZW9uX2NzX3BhcnNlcl9pbml0KHN0cnVjdCByYWRlb25fY3NfcGFyc2VyICpw
LCB2b2lkICpkYXRhKQo+ICAgCX0KPiAgIAlwLT5jc19mbGFncyA9IDA7Cj4gICAJcC0+bmNodW5r
cyA9IGNzLT5udW1fY2h1bmtzOwo+IC0JcC0+Y2h1bmtzID0ga3ZtYWxsb2NfYXJyYXkocC0+bmNo
dW5rcywgc2l6ZW9mKHN0cnVjdCByYWRlb25fY3NfY2h1bmspLCBHRlBfS0VSTkVMKTsKPiArCXAt
PmNodW5rcyA9IGt2Y2FsbG9jKHAtPm5jaHVua3MsIHNpemVvZihzdHJ1Y3QgcmFkZW9uX2NzX2No
dW5rKSwgR0ZQX0tFUk5FTCk7Cj4gICAJaWYgKHAtPmNodW5rcyA9PSBOVUxMKSB7Cj4gICAJCXJl
dHVybiAtRU5PTUVNOwo+ICAgCX0KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0
b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1k
LWdmeAo=
