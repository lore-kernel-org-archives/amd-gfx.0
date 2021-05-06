Return-Path: <SRS0=uqaI=KB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C312C433ED
	for <amd-gfx@archiver.kernel.org>; Thu,  6 May 2021 10:39:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B896E61176
	for <amd-gfx@archiver.kernel.org>; Thu,  6 May 2021 10:39:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B896E61176
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 63AE06E0A8;
	Thu,  6 May 2021 10:39:04 +0000 (UTC)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 73CEC6E0A8
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 May 2021 10:39:03 +0000 (UTC)
Received: by mail-ej1-x636.google.com with SMTP id u21so7500826ejo.13
 for <amd-gfx@lists.freedesktop.org>; Thu, 06 May 2021 03:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-transfer-encoding:content-language;
 bh=z3Yrxi9DtOdIBXhMOWJISzzsFt7rF62uoSm4dshCxYM=;
 b=rfcf1t1s5UB7cgfVCTmpPnX5Eaips7ZTgp1Y/yCsyvidJ3S0mttcvVeSiRLDElO2oT
 eLdzq3JIt9gGDLmQU8WyZJ1nhnaYprmb/c2XQfIw47OGaqGiIcFw5IQ9qSd8hN8MM5FW
 72izYg44iOBJ33AXQu+bBM4tmLoFkBUwOg82tYYObGkfbUeLtcvewbrIncmbOnT/Gg/r
 9RXpkf8ctlKHLFEYDrXK4XiunuJjjsqT6YXdX41X0izE9MtkPRMVdG2Iycd27/fistvX
 Ol0S1kGQtI7rW4PbXj9W9q3tSgIfnMwhpYdrMnJNMcoSCZzYTj5IEBOuLan1YtMwFQfw
 tW3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=z3Yrxi9DtOdIBXhMOWJISzzsFt7rF62uoSm4dshCxYM=;
 b=alRTDT2DOxxtd5nCdvGIbCt2V/7wCBcOEt979+Cb7IS+/acPBkg3N1e4P4HwwezSI8
 hATdbpUNq+7SBdGr9K4P5QFTI5K2mSgcFgDGNvaGxebBGZyY8T5TjBCch4mkPnZMTPQH
 UDK5H0BZ4M2hf5YkJexawOhbuB4yY7IB4usRWL6rjT92lGAT/e6uIDiDj7x5jW5HKCby
 rZVK7roTMZeHQoGf8/zZ5Qlw76dWmS82PrXD0VuT/mZrk1diRKYC3Q3m2PvuqxAP3L7l
 XhM5/1msbQzqH4HQL5gkOHK67Tos931iskVSXzT6Z5/43ITBDndxCZl9on89SUZW0T85
 UqOQ==
X-Gm-Message-State: AOAM532DjHrovxLi3+5ClrkrFy9jrtbL8zNKwuA7YvUUx3HWciuA1akM
 1MVxgpE70WgGw46IfwWJnDtEsKt9FBM=
X-Google-Smtp-Source: ABdhPJwOtyaZ+Ax98uzir1ixyZaf2CUeeCdtVR3kHuQTj2XGnXs10Eq7Df6jJXTUMdGzOdBmFpD/eg==
X-Received: by 2002:a17:906:9141:: with SMTP id
 y1mr3804619ejw.111.1620297542203; 
 Thu, 06 May 2021 03:39:02 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:fdb4:699a:b8d0:6ae9?
 ([2a02:908:1252:fb60:fdb4:699a:b8d0:6ae9])
 by smtp.gmail.com with ESMTPSA id b8sm1357550edu.41.2021.05.06.03.39.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 May 2021 03:39:01 -0700 (PDT)
Subject: Re: [PATCH] drm/amdgpu: fix the fence leak
To: Roy Sun <Roy.Sun@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210506091453.4541-1-Roy.Sun@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <cb6deb4a-06c7-6e34-a484-ca161dbe714b@gmail.com>
Date: Thu, 6 May 2021 12:39:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210506091453.4541-1-Roy.Sun@amd.com>
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

QW0gMDYuMDUuMjEgdW0gMTE6MTQgc2NocmllYiBSb3kgU3VuOgo+IHJlbGVhc2UgdGhlIHVucmVs
ZWFzZWQgZmVuY2VzCgpBIGJpdCBiZXR0ZXIgZGVzY3JpcHRpb24gd2hhdCdzIGdvaW5nIHdyb25n
IGhlcmUgd291bGQgYmUgbmljZS4KCj4KPiBTaWduZWQtb2ZmLWJ5OiBSb3kgU3VuIDxSb3kuU3Vu
QGFtZC5jb20+CgpSZXZpZXdlZC1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5p
Z0BhbWQuY29tPgoKPiAtLS0KPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9j
dHguYyB8IDggKysrKysrLS0KPiAgIDEgZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKyksIDIg
ZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X2N0eC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2N0eC5jCj4g
aW5kZXggMDFmZTYwZmVkY2JlLi41OWI2NjI5NDdkZGUgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2N0eC5jCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X2N0eC5jCj4gQEAgLTY2OSwxMSArNjY5LDE1IEBAIHZvaWQgYW1kZ3B1
X2N0eF9mZW5jZV90aW1lKHN0cnVjdCBhbWRncHVfY3R4ICpjdHgsIHN0cnVjdCBhbWRncHVfY3R4
X2VudGl0eSAqY2VuCj4gICAJCWlmICghZmVuY2UpCj4gICAJCQljb250aW51ZTsKPiAgIAkJc19m
ZW5jZSA9IHRvX2RybV9zY2hlZF9mZW5jZShmZW5jZSk7Cj4gLQkJaWYgKCFkbWFfZmVuY2VfaXNf
c2lnbmFsZWQoJnNfZmVuY2UtPnNjaGVkdWxlZCkpCj4gKwkJaWYgKCFkbWFfZmVuY2VfaXNfc2ln
bmFsZWQoJnNfZmVuY2UtPnNjaGVkdWxlZCkpIHsKPiArCQkJZG1hX2ZlbmNlX3B1dChmZW5jZSk7
Cj4gICAJCQljb250aW51ZTsKPiArCQl9Cj4gICAJCXQxID0gc19mZW5jZS0+c2NoZWR1bGVkLnRp
bWVzdGFtcDsKPiAtCQlpZiAodDEgPj0gbm93KQo+ICsJCWlmICh0MSA+PSBub3cpIHsKPiArCQkJ
ZG1hX2ZlbmNlX3B1dChmZW5jZSk7Cj4gICAJCQljb250aW51ZTsKPiArCQl9Cj4gICAJCWlmIChk
bWFfZmVuY2VfaXNfc2lnbmFsZWQoJnNfZmVuY2UtPmZpbmlzaGVkKSAmJgo+ICAgCQkJc19mZW5j
ZS0+ZmluaXNoZWQudGltZXN0YW1wIDwgbm93KQo+ICAgCQkJKnRvdGFsICs9IGt0aW1lX3N1Yihz
X2ZlbmNlLT5maW5pc2hlZC50aW1lc3RhbXAsIHQxKTsKCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlz
dHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4v
bGlzdGluZm8vYW1kLWdmeAo=
