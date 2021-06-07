Return-Path: <SRS0=JNIh=LB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD036C47082
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jun 2021 14:29:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5114610FC
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jun 2021 14:29:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5114610FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 68B2F6E8B8;
	Mon,  7 Jun 2021 14:29:50 +0000 (UTC)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 411DD6E8B8
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Jun 2021 14:29:50 +0000 (UTC)
Received: by mail-wm1-x32a.google.com with SMTP id o127so10180357wmo.4
 for <amd-gfx@lists.freedesktop.org>; Mon, 07 Jun 2021 07:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-transfer-encoding:content-language;
 bh=uPngbvj/Ei+ENSwr9WPvjp7pLjpPakTyvVpjTCuXIAQ=;
 b=m+hRzsBpAawHRwpSJhDIT19HVuEPmBjHQc2E7dURSmdS46Lkkf2ynVmIhHil0GtIAx
 kp4ou8zrMbM/Sd6kn8zQrXeISSMsP27tvoGvTQVJFGdf8MTPfYfUr4IPDn5GfPXP9AvI
 xeRIEIbbYvohkINGBgwkS982PJUi0HWA9MXYTK4CxvhHUHbpna7uflohRlfaj+NlV0H1
 KZgKgnL8H0r4nfMSpxC5vCICwUDCjDPGhF/g+xzxzXGmIwd2kv7nMjOhDD8ra7szcZot
 hWVXgtfpb/G3mby7L+EWc4KbI98PjZ8lpkynovQrqLi+lXDmm5DlRPe8yk9bx1rl4D5d
 IY3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=uPngbvj/Ei+ENSwr9WPvjp7pLjpPakTyvVpjTCuXIAQ=;
 b=FrrGv8XtdZ0xebu77uc+1k1+WTLfv5QkN2zIWSf0YgcI0hfoNROgb3zTYCJ21PeVwo
 dDZr0PT8pf4dv+W0Rmxw02O7SPHbGGgoh9IdTs5oU4aQyKcZ9DSvdkP5MsV32yMkUYAi
 6IDsMi1KbaVbYkBkUU+MopupulaCV2ReICoNMNiaDajbwSPyC/dRBFzwozWeHOWqNx9E
 etGbA3F+Dl+SArA9M0DoTvH3+8cWK/yGRcd/RS0PnFCSWfveTY7zbiekv7PAEgtsBdwR
 Yu7P72sRIAu8/Dw3rBxn7h9GZH/RxS7uGVdL0Qg2s7/R/Q1Xejkpp7vVJGW1FJKFAz59
 gatw==
X-Gm-Message-State: AOAM533JhdIwqYPrT3wwDtJK5s8dF3WzDui096iKf/t5ynSBcZLnySZX
 62D/jry/gxi3efSo+pgrD6rT3IV+uFw=
X-Google-Smtp-Source: ABdhPJwdqBtX5hR24mx8qOKTu9Y7ehWiToOfQGXHARHJxjoOBd9UsbO+RH732sUAxKXO7jj9WiOzUg==
X-Received: by 2002:a1c:a484:: with SMTP id n126mr17325909wme.34.1623076189035; 
 Mon, 07 Jun 2021 07:29:49 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:ce67:4e4d:875d:ffeb?
 ([2a02:908:1252:fb60:ce67:4e4d:875d:ffeb])
 by smtp.gmail.com with ESMTPSA id t9sm9671049wmq.14.2021.06.07.07.29.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Jun 2021 07:29:48 -0700 (PDT)
Subject: Re: [PATCH] drm/amdgpu: Fix warning of Function parameter or member
 not described
To: Eric Huang <jinhuieric.huang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210607142159.68860-1-jinhuieric.huang@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <2a3bc4a8-356d-5570-46d6-ad5a5d4c9d5b@gmail.com>
Date: Mon, 7 Jun 2021 16:29:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210607142159.68860-1-jinhuieric.huang@amd.com>
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

CgpBbSAwNy4wNi4yMSB1bSAxNjoyMSBzY2hyaWViIEVyaWMgSHVhbmc6Cj4gQWRkIHRoZSBwYXJh
bWV0ZXIgdGFibGVfZnJlZWQgZGVzY3JpcHRpb24gb24gZnVuY3Rpb24gZGVzY3JpcHRpb24uCj4K
PiBTaWduZWQtb2ZmLWJ5OiBFcmljIEh1YW5nIDxqaW5odWllcmljLmh1YW5nQGFtZC5jb20+CgpS
ZXZpZXdlZC1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgoK
PiAtLS0KPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jIHwgMSArCj4g
ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV92bS5jCj4gaW5kZXggYjRmMTg5YWI2NzJlLi45ZGIxYjY0ZDE2ZDkgMTAwNjQ0
Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMKPiArKysgYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYwo+IEBAIC0xODIzLDYgKzE4MjMs
NyBAQCB2b2lkIGFtZGdwdV92bV9nZXRfbWVtb3J5KHN0cnVjdCBhbWRncHVfdm0gKnZtLCB1aW50
NjRfdCAqdnJhbV9tZW0sCj4gICAgKiBAYWRldjogYW1kZ3B1X2RldmljZSBwb2ludGVyCj4gICAg
KiBAYm9fdmE6IHJlcXVlc3RlZCBCTyBhbmQgVk0gb2JqZWN0Cj4gICAgKiBAY2xlYXI6IGlmIHRy
dWUgY2xlYXIgdGhlIGVudHJpZXMKPiArICogQHRhYmxlX2ZyZWVkOiByZXR1cm4gdHJ1ZSBpZiBw
YWdlIHRhYmxlIGlzIGZyZWVkCj4gICAgKgo+ICAgICogRmlsbCBpbiB0aGUgcGFnZSB0YWJsZSBl
bnRyaWVzIGZvciBAYm9fdmEuCj4gICAgKgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVl
ZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5m
by9hbWQtZ2Z4Cg==
