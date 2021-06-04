Return-Path: <SRS0=YIqZ=K6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7F5AC07E94
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Jun 2021 08:08:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 981896140C
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Jun 2021 08:08:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 981896140C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 62E9D6F5CE;
	Fri,  4 Jun 2021 08:08:31 +0000 (UTC)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ABC566F5D5;
 Fri,  4 Jun 2021 08:08:29 +0000 (UTC)
Received: by mail-ej1-x62d.google.com with SMTP id og14so7857986ejc.5;
 Fri, 04 Jun 2021 01:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=x1leB78G46naHPzZJQXi/DCDYCAszkWEJfdXDpTHiWk=;
 b=arlNWd6gloEwocm2HbsItwvL1nS9tcJVgvXvPIOMAiWKxtomOtF1q98J+CYx9r9bgl
 VzfYndH/HnOWNbBdnVgVBnOTg3HWlBmMzDul5bJhJ0TA2inT9M8aYTC/ZMAofPoiycAg
 r025XB4KsguNwMsqdHrB6XA+HQZOBkTreC3C38qBqzygKATTqCoUbhfgSfhHx6gX2yfl
 ylJpKtnS6Skc1I9pgbeAckmnQulBudEf6lvjhPnbWHYn09XAi1fTmMSzCTkOJ7dmHJVt
 YPe/fbGJbIU9OMsCrGAOez42AlqgFKOB/mVrui9+vDadL/Fs5beVrkVMFi37SsQetsyP
 pwCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=x1leB78G46naHPzZJQXi/DCDYCAszkWEJfdXDpTHiWk=;
 b=WKBbc0Xrqs6thXdsIw5DSyZ3JbbnQB5Gq2P1QYQkkt/KO8fN0ufp7CTsoEBPUnd8nu
 oTYwcx4o5mSXBPbuyT/eiwlrL/wLFKYJ4HKnTM428U+NMk32iar1Rt6ECmvGWpWvLtcq
 0PfdXxPFs+6pae8/10wiFtp2vbSF4ozZWY6iVEjgMkLI6FkRbaKEhxdRUInXWNWrGjKQ
 UK/ZIQByR3e4yZgjJTEQsmoOW84vmlArjPS1nz1dPaNp1Wsp9O/5kI6uqzFWz2C20IfW
 zbpHtkIE5UdQUX+1LbiIvOU45MQxE+So5vIrFEs6Kej7mD8Ollsz/eqfdtB+xgYQu0n2
 s2wA==
X-Gm-Message-State: AOAM533bq5fpg6NMir5T0L4bMzDETz3JzzNbfcAAwnRZ/F7LkYSO+2N9
 0Bey5HOtQsfuUCB4WN+Gt+giiDfeGFg=
X-Google-Smtp-Source: ABdhPJw6hx3rF9XTeQTb6a6rLhWG+YpMeSd9gPcge8+kszFV+U+TsxRIrbvzO8SdE98hT9vtTTqS3w==
X-Received: by 2002:a17:906:b191:: with SMTP id
 w17mr3111041ejy.200.1622794108428; 
 Fri, 04 Jun 2021 01:08:28 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:7b4b:873a:17b5:b581?
 ([2a02:908:1252:fb60:7b4b:873a:17b5:b581])
 by smtp.gmail.com with ESMTPSA id di16sm2812246edb.62.2021.06.04.01.08.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Jun 2021 01:08:27 -0700 (PDT)
Subject: Re: [PATCH v3 2/2] radeon: use memcpy_to/fromio for UVD fw upload
To: Chen Li <chenli@uniontech.com>
References: <87o8cnfr3s.wl-chenli@uniontech.com>
 <87im2ufhyz.wl-chenli@uniontech.com>
 <0689a006-a0a2-698a-12d8-cb11156e469a@gmail.com>
 <877djacbfx.wl-chenli@uniontech.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <c4941cb6-8c40-aad1-e61a-2786ba1ab225@gmail.com>
Date: Fri, 4 Jun 2021 10:08:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <877djacbfx.wl-chenli@uniontech.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 dri-devel@lists.freedesktop.org
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

CgpBbSAwNC4wNi4yMSB1bSAwOTo1MyBzY2hyaWViIENoZW4gTGk6Cj4gSSBtZXQgYSBncHUgYWRk
ciBidWcgcmVjZW50bHkgYW5kIHRoZSBrZXJuZWwgbG9nCj4gdGVsbHMgbWUgdGhlIHBjIGlzIG1l
bWNweS9tZW1zZXQgYW5kIGxpbmsgcmVnaXN0ZXIgaXMKPiByYWRlb25fdXZkX3Jlc3VtZS4KPgo+
IEFzIHdlIGtub3csIGluIHNvbWUgYXJjaGl0ZWN0dXJlcywgb3B0aW1pemVkIG1lbWNweS9tZW1z
ZXQKPiBtYXkgbm90IHdvcmsgd2VsbCBvbiBkZXZpY2UgbWVtb3J5LiBUcml2YWwgbWVtY3B5X3Rv
aW8vbWVtc2V0X2lvCj4gY2FuIGZpeCB0aGlzIHByb2JsZW0uCj4KPiBCVFcsIGFtZGdwdSBoYXMg
YWxyZWFkeSBkb25lIGl0IGluOgo+IGNvbW1pdCBiYTBiMjI3NWE2NzggKCJkcm0vYW1kZ3B1OiB1
c2UgbWVtY3B5X3RvL2Zyb21pbyBmb3IgVVZEIGZ3IHVwbG9hZCIpLAo+IHRoYXQncyB3aHkgaXQg
aGFzIG5vIHRoaXMgaXNzdWUgb24gdGhlIHNhbWUgZ3B1IGFuZCBwbGF0Zm9ybS4KPgo+IFNpZ25l
ZC1vZmYtYnk6IENoZW4gTGkgPGNoZW5saUB1bmlvbnRlY2guY29tPgo+IC0tLQo+ICAgZHJpdmVy
cy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fdXZkLmMgfCA2ICsrKystLQo+ICAgMSBmaWxlIGNoYW5n
ZWQsIDQgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVvbl91dmQuYyBiL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24v
cmFkZW9uX3V2ZC5jCj4gaW5kZXggODVhMWYyYzMxNzQ5Li41NWFiZjlhOTYyM2IgMTAwNjQ0Cj4g
LS0tIGEvZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fdXZkLmMKPiArKysgYi9kcml2ZXJz
L2dwdS9kcm0vcmFkZW9uL3JhZGVvbl91dmQuYwo+IEBAIC0yODgsNyArMjg4LDkgQEAgaW50IHJh
ZGVvbl91dmRfcmVzdW1lKHN0cnVjdCByYWRlb25fZGV2aWNlICpyZGV2KQo+ICAgCWlmIChyZGV2
LT51dmQudmNwdV9ibyA9PSBOVUxMKQo+ICAgCQlyZXR1cm4gLUVJTlZBTDsKPiAgIAo+IC0JbWVt
Y3B5KHJkZXYtPnV2ZC5jcHVfYWRkciwgcmRldi0+dXZkX2Z3LT5kYXRhLCByZGV2LT51dmRfZnct
PnNpemUpOwo+ICsJbWVtY3B5X3RvaW8oKHZvaWQgX19pb21lbSAqKXJkZXYtPnV2ZC5jcHVfYWRk
ciwKPiArCQkJCXJkZXYtPnV2ZF9mdy0+ZGF0YSwKPiArCQkJCXJkZXYtPnV2ZF9mdy0+c2l6ZSk7
CgpUaGUgY29kaW5nIHN0eWxlIHN0aWxsIGxvb2tzIHdyb25nIGhlcmUsIGUuZy4gaXQgaXMgaW5k
ZW50ZWQgdG8gZmFyIHRvIAp0aGUgcmlnaHQgYW5kIGRhdGEvc2l6ZSBjYW4gYmUgb24gb25lIGxp
bmUuCgpBcGFydCBmcm9tIHRoYXQgdGhlIHBhdGNoIGlzIFJldmlld2VkLWJ5OiBDaHJpc3RpYW4g
S8O2bmlnIAo8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgoKUmVnYXJkcywKQ2hyaXN0aWFuLgoK
PiAgIAo+ICAgCXNpemUgPSByYWRlb25fYm9fc2l6ZShyZGV2LT51dmQudmNwdV9ibyk7Cj4gICAJ
c2l6ZSAtPSByZGV2LT51dmRfZnctPnNpemU7Cj4gQEAgLTI5Niw3ICsyOTgsNyBAQCBpbnQgcmFk
ZW9uX3V2ZF9yZXN1bWUoc3RydWN0IHJhZGVvbl9kZXZpY2UgKnJkZXYpCj4gICAJcHRyID0gcmRl
di0+dXZkLmNwdV9hZGRyOwo+ICAgCXB0ciArPSByZGV2LT51dmRfZnctPnNpemU7Cj4gICAKPiAt
CW1lbXNldChwdHIsIDAsIHNpemUpOwo+ICsJbWVtc2V0X2lvKCh2b2lkIF9faW9tZW0gKilwdHIs
IDAsIHNpemUpOwo+ICAgCj4gICAJcmV0dXJuIDA7Cj4gICB9CgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4
QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2FtZC1nZngK
