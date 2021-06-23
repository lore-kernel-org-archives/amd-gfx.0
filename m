Return-Path: <SRS0=KKXi=LR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 854E8C4743C
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Jun 2021 12:46:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53A2061076
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Jun 2021 12:46:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53A2061076
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0AF3589BF0;
	Wed, 23 Jun 2021 12:46:12 +0000 (UTC)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E60C389BF0
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Jun 2021 12:46:10 +0000 (UTC)
Received: by mail-ej1-x634.google.com with SMTP id hq39so3829411ejc.5
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Jun 2021 05:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=AiJ7n5jgIIGKj4kPqdng10seB2rg3KprMh2B94LZxdk=;
 b=X6Os4eNm3Eiv2g8Sfv1E1O/H2zHx+8SDZPYoFER1wnOGz6M+qI0889rZzXlBifMOoQ
 dtd/lYXEE6u65a/VtAfnhUgh3LRe5xiH5ZapVBdezdHFobnXJgtz5csjvW8XgiWD1fXP
 Jzhf1dIKLH3BEBANTC5UxXXlx9LGYh9U9Pgyxu6JW7aO+MBZxZxAzhGq4K1rByiH6AlP
 1I76CdQt68x+0Li/gb1Bn5RMLn2YUqgvt5eQP8+7dvPis4lsiUUmvgE5BxhjPQ1ny8O7
 CfMEQDyQsLeejz1DCPEkqbLg2h3UnXyXFrNz5r3ShVmiymEIh6gp+8tGDgD/I1m5pKQG
 8KBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=AiJ7n5jgIIGKj4kPqdng10seB2rg3KprMh2B94LZxdk=;
 b=r/bi8JmXwO3Jy1dCydsPXArCVesAHk/k1k9vGGimCuMRLzEBpPFao8cioRPVJwVmVN
 Dpyw74DQ1cUrCAe39YrrBOrfrouW9XkfbBK88dppdVocGxuEuEZgRQYxxog5bqdyTOki
 ouIQwjoMBhzCeEzR5H1D7v0npsoqcTmROTB/hw7/9WNqFM1K4orA6dGU78CCCqW7Yq19
 RgrwIDkVIqNZ+qN0H4x/UeS7oKwo3WvJt56aXzzKGUCla3ggR+HzEpESBjObEanQ1766
 o3eSSFDp2lOLQSmtX+Tfeg0kjmCv3SCSzkZd0kGnt/XRtAVVxgh2TobhfXaVrCzzU0vB
 6x3A==
X-Gm-Message-State: AOAM53177TSnp5rWYuPTSc8sG+WxK0UQOr8aTeXAVQWH2dQYZbzqnLFh
 7JEygWvAiNMvkhpzr9a87KA=
X-Google-Smtp-Source: ABdhPJxVLU4AipbFldMLjGWMxhIHFfd78FxM/BcM0Tvh8SuwGBxhC1Pylu4qwnXv/MJuLGWVsYhhXw==
X-Received: by 2002:a17:906:bcf4:: with SMTP id
 op20mr9458561ejb.327.1624452369505; 
 Wed, 23 Jun 2021 05:46:09 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:871f:87e2:f394:e667?
 ([2a02:908:1252:fb60:871f:87e2:f394:e667])
 by smtp.gmail.com with ESMTPSA id y10sm7143892ejm.76.2021.06.23.05.46.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Jun 2021 05:46:09 -0700 (PDT)
Subject: Re: [PATCH 1/2] drm/amdgpu: free pasid early before converting a vm
To: Nirmoy Das <nirmoy.das@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210623122506.7397-1-nirmoy.das@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <6f06653a-f638-94e4-5d95-8e4590e69535@gmail.com>
Date: Wed, 23 Jun 2021 14:46:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210623122506.7397-1-nirmoy.das@amd.com>
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
Cc: Felix.Kuehling@amd.com, Christian.Koenig@amd.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMjMuMDYuMjEgdW0gMTQ6MjUgc2NocmllYiBOaXJtb3kgRGFzOgo+IFZNIGNvZGUgc2hvdWxk
IG5vdCBiZSByZXNwb25zaWJsZSBmb3IgZnJlZWluZyBwYXNpZCBhcyBwYXNpZAo+IGdldHMgYWxs
b2NhdGVkIG91dHNpZGUgb2YgVk0gY29kZSwgYmVmb3JlIGluaXRpYWxpemluZyBhIHZtLgo+Cj4g
U2lnbmVkLW9mZi1ieTogTmlybW95IERhcyA8bmlybW95LmRhc0BhbWQuY29tPgoKUmV2aWV3ZWQt
Ynk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KCj4gLS0tCj4g
ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYW1ka2ZkX2dwdXZtLmMgfCA2ICsr
KysrKwo+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMgICAgICAgICAg
IHwgNSAtLS0tLQo+ICAgMiBmaWxlcyBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKyksIDUgZGVsZXRp
b25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X2FtZGtmZF9ncHV2bS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtm
ZF9ncHV2bS5jCj4gaW5kZXggZjk2NTk4Mjc5NTkzLi40MmUyMmIxZmRmZWUgMTAwNjQ0Cj4gLS0t
IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtmZF9ncHV2bS5jCj4gKysr
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtmZF9ncHV2bS5jCj4gQEAg
LTEyODcsNiArMTI4NywxMiBAQCBpbnQgYW1kZ3B1X2FtZGtmZF9ncHV2bV9hY3F1aXJlX3Byb2Nl
c3Nfdm0oc3RydWN0IGtnZF9kZXYgKmtnZCwKPiAgIAlpZiAoYXZtLT5wcm9jZXNzX2luZm8pCj4g
ICAJCXJldHVybiAtRUlOVkFMOwo+ICAgCj4gKwkvKiBGcmVlIHRoZSBvcmlnaW5hbCBhbWRncHUg
YWxsb2NhdGVkIHBhc2lkLAo+ICsJICogd2lsbCBiZSByZXBsYWNlZCB3aXRoIGtmZCBhbGxvY2F0
ZWQgcGFzaWQKPiArCSAqLwo+ICsJaWYgKGF2bS0+cGFzaWQpCj4gKwkJYW1kZ3B1X3Bhc2lkX2Zy
ZWUoYXZtLT5wYXNpZCk7Cj4gKwo+ICAgCS8qIENvbnZlcnQgVk0gaW50byBhIGNvbXB1dGUgVk0g
Ki8KPiAgIAlyZXQgPSBhbWRncHVfdm1fbWFrZV9jb21wdXRlKGFkZXYsIGF2bSwgcGFzaWQpOwo+
ICAgCWlmIChyZXQpCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV92bS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMKPiBpbmRl
eCA2Mzk3NWJkYThlNzYuLmJlODQxZDYyYTFkNCAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV92bS5jCj4gQEAgLTMwOTQsMTEgKzMwOTQsNiBAQCBpbnQgYW1kZ3B1X3ZtX21h
a2VfY29tcHV0ZShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwgc3RydWN0IGFtZGdwdV92bSAq
dm0sCj4gICAJCXNwaW5fbG9ja19pcnFzYXZlKCZhZGV2LT52bV9tYW5hZ2VyLnBhc2lkX2xvY2ss
IGZsYWdzKTsKPiAgIAkJaWRyX3JlbW92ZSgmYWRldi0+dm1fbWFuYWdlci5wYXNpZF9pZHIsIHZt
LT5wYXNpZCk7Cj4gICAJCXNwaW5fdW5sb2NrX2lycXJlc3RvcmUoJmFkZXYtPnZtX21hbmFnZXIu
cGFzaWRfbG9jaywgZmxhZ3MpOwo+IC0KPiAtCQkvKiBGcmVlIHRoZSBvcmlnaW5hbCBhbWRncHUg
YWxsb2NhdGVkIHBhc2lkCj4gLQkJICogV2lsbCBiZSByZXBsYWNlZCB3aXRoIGtmZCBhbGxvY2F0
ZWQgcGFzaWQKPiAtCQkgKi8KPiAtCQlhbWRncHVfcGFzaWRfZnJlZSh2bS0+cGFzaWQpOwo+ICAg
CQl2bS0+cGFzaWQgPSAwOwo+ICAgCX0KPiAgIAoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5m
cmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0
aW5mby9hbWQtZ2Z4Cg==
