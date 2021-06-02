Return-Path: <SRS0=QW4G=K4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFEAAC47083
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 09:56:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A360611CC
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 09:56:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A360611CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 157866EBF6;
	Wed,  2 Jun 2021 09:56:25 +0000 (UTC)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7406F895D7
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Jun 2021 09:56:24 +0000 (UTC)
Received: by mail-ej1-x629.google.com with SMTP id a11so2251608ejf.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 02 Jun 2021 02:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=XdoMFtgUPc8mCm8UAXv3ZOqDJKzBDscSsR/9m9zc+tQ=;
 b=p2+0KygCwL5SAuuqDh99EnqFJ9xJKf6rWGuCKE5vcLo+vP+AAdug3+pFqjGN52pYJw
 3OpSPyEFF8bG8w4pG/rhajLMghbcUrL/Dek3QoTth3Rc4Puo74XnXvCaww0t7u0dJbxh
 xf4lZThs7sc9LtVGt6e2J/CCn9OJ7eLFIUb8CMQ5CWBFQkGLNWxxPZaHKfUPAwEE9SK4
 2nl5OPiZLhqziYwT0fjfcOZFdJQtWeA2R7ocpqPoO5+1OTNOH/mM9lkrYYTX9qQzO9Xr
 9ClY8wdWx1Co+xOk/cOu+1+n/YMgdd3SJKE81ojx4j2oYQchedU7sEatqaU8oe3u8vqn
 JiEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=XdoMFtgUPc8mCm8UAXv3ZOqDJKzBDscSsR/9m9zc+tQ=;
 b=JgxwtjVs3QgJ9eK4O9H7yHvMQ21u1eLFThZQLGf8uhTTvKD3o1CzPF5AkYr4Idl7c9
 d9lrZgeZfjs5PmCx1wyZI2QAjMogPVWhkzzZN1EKTxcunx4X8VFCKmXTrtk0Z0ij99wy
 6gUzRrKYhE7AfGk66O4pBpInSc0lASHoGCisIQb+jCAOxa+z0McGBkt4yqInuv5lZAGA
 LEshjDeMG102lQBs2ow3Q9lhhcNTBlvq5VzFZnQaqD1Ic+sFsUGsRYJrzbhWBfPVENdL
 UtqI3eNrvP4rl5gMPHGXqTXsCJulOq6saxwpCFlO7s7NCrGVuBNAnxynlNWK2t2/RmUF
 kR3Q==
X-Gm-Message-State: AOAM532pQB633D1OfAMrXJtiPy1NhEGdJ3NA58QTl2KdKS05ZYLgfEXs
 yIOE2GQPHMry20iBlT/KhHw=
X-Google-Smtp-Source: ABdhPJy+Ki5bOTjfkYm5PcXyoY9h5N939nc5P0cthvwGz3x0wz8Pgo2A6B1kmLd0olB6lVRSmF7r7w==
X-Received: by 2002:a17:907:1c20:: with SMTP id
 nc32mr16897176ejc.21.1622627783161; 
 Wed, 02 Jun 2021 02:56:23 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:cd07:2759:3eec:1d00?
 ([2a02:908:1252:fb60:cd07:2759:3eec:1d00])
 by smtp.gmail.com with ESMTPSA id g4sm995458edw.8.2021.06.02.02.56.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Jun 2021 02:56:22 -0700 (PDT)
Subject: Re: [PATCH] drm/amdgpu: Use drm_dbg_kms for reporting failure to get
 a GEM FB
To: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>,
 amd-gfx@lists.freedesktop.org
References: <20210602095305.41936-1-michel@daenzer.net>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <1cb79c0b-63f4-777d-29f3-552987aeb790@gmail.com>
Date: Wed, 2 Jun 2021 11:56:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210602095305.41936-1-michel@daenzer.net>
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
Cc: Mark Yacoub <markyacoub@google.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

CgpBbSAwMi4wNi4yMSB1bSAxMTo1MyBzY2hyaWViIE1pY2hlbCBEw6RuemVyOgo+IEZyb206IE1p
Y2hlbCBEw6RuemVyIDxtZGFlbnplckByZWRoYXQuY29tPgo+Cj4gZHJtX2VyciBtZWFudCBicm9r
ZW4gdXNlciBzcGFjZSBjb3VsZCBzcGFtIGRtZXNnLgo+Cj4gRml4ZXM6IGYyNTg5MDdmZGQ4MzVl
ICJkcm0vYW1kZ3B1OiBWZXJpZnkgYm8gc2l6ZSBjYW4gZml0IGZyYW1lYnVmZmVyCj4gICAgICAg
ICAgICAgICAgICAgICAgICAgc2l6ZSBvbiBpbml0LiIKPiBTaWduZWQtb2ZmLWJ5OiBNaWNoZWwg
RMOkbnplciA8bWRhZW56ZXJAcmVkaGF0LmNvbT4KClJldmlld2VkLWJ5OiBDaHJpc3RpYW4gS8O2
bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+Cgo+IC0tLQo+ICAgZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X2Rpc3BsYXkuYyB8IDQgKystLQo+ICAgMSBmaWxlIGNoYW5nZWQs
IDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGlzcGxheS5jIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X2Rpc3BsYXkuYwo+IGluZGV4IDgxNzBlMjRjZTM3ZC4uMmE0Y2Q3ZDM3
N2JmIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kaXNw
bGF5LmMKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGlzcGxheS5j
Cj4gQEAgLTEwNTgsNyArMTA1OCw3IEBAIGludCBhbWRncHVfZGlzcGxheV9nZW1fZmJfaW5pdChz
dHJ1Y3QgZHJtX2RldmljZSAqZGV2LAo+ICAgCj4gICAJcmV0dXJuIDA7Cj4gICBlcnI6Cj4gLQlk
cm1fZXJyKGRldiwgIkZhaWxlZCB0byBpbml0IGdlbSBmYjogJWRcbiIsIHJldCk7Cj4gKwlkcm1f
ZGJnX2ttcyhkZXYsICJGYWlsZWQgdG8gaW5pdCBnZW0gZmI6ICVkXG4iLCByZXQpOwo+ICAgCXJm
Yi0+YmFzZS5vYmpbMF0gPSBOVUxMOwo+ICAgCXJldHVybiByZXQ7Cj4gICB9Cj4gQEAgLTEwOTYs
NyArMTA5Niw3IEBAIGludCBhbWRncHVfZGlzcGxheV9nZW1fZmJfdmVyaWZ5X2FuZF9pbml0KAo+
ICAgCj4gICAJcmV0dXJuIDA7Cj4gICBlcnI6Cj4gLQlkcm1fZXJyKGRldiwgIkZhaWxlZCB0byB2
ZXJpZnkgYW5kIGluaXQgZ2VtIGZiOiAlZFxuIiwgcmV0KTsKPiArCWRybV9kYmdfa21zKGRldiwg
IkZhaWxlZCB0byB2ZXJpZnkgYW5kIGluaXQgZ2VtIGZiOiAlZFxuIiwgcmV0KTsKPiAgIAlyZmIt
PmJhc2Uub2JqWzBdID0gTlVMTDsKPiAgIAlyZXR1cm4gcmV0Owo+ICAgfQoKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QK
YW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5v
cmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
