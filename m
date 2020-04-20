Return-Path: <SRS0=ehRF=6E=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61C04C3815B
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Apr 2020 15:45:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31F65206DD
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Apr 2020 15:45:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VtYfkXnX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31F65206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DAFAA6E5D3;
	Mon, 20 Apr 2020 15:45:34 +0000 (UTC)
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6FAD46E5D3
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Apr 2020 15:45:34 +0000 (UTC)
Received: by mail-wr1-x444.google.com with SMTP id k11so12794761wrp.5
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Apr 2020 08:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=usxdzY/5RGl2FYINStu8F2vBVIc5GkxC7V7OYWvXnnc=;
 b=VtYfkXnXfNB7dpVX55+QhdXKGShDfmxs22bNq1lH67UfhfjYr+c/QDHqBpQ2Eh2BWQ
 NodN/ycniPB88KAUDbcvSsQWFnRIpiPLJCQkkZCts9MPhVhFJO+UQKex6YFDEYUWw9fe
 K1+xzF/EMWhJqfbzTTRa7JJLeMZMCpW1qSjnO6MEXkWtOW2w7kUz3KHkJagglm/6Qzdr
 WdQrWKkQF3iTNri4/sONVpJRzZkvmfYnfmFugJ7CfD15QtKSc3nB87IK0aSUpA67g06I
 IlBaVkPiVhOIssPzWRYJtnbjnhOk7FDP7pGiDOu5eM6Nxo4chK9sCkvBVHRoCIV7/wst
 x1TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=usxdzY/5RGl2FYINStu8F2vBVIc5GkxC7V7OYWvXnnc=;
 b=krRcobOTiOeUm3GV72oOGJt6yKQo8q2ZwIh6PAL1EgMr8t9y0Q5XQHJvJEX3PUWw0E
 M2PytuKZULp6bJyQw6S12tFTKAKI5vBLCwrlTvNA9sqxEWpsyfRcOgnMfo0TliyAg/Dl
 nBe3sYLirJth8NHy52T6hG8Ygdjgp+XZSsEMUfqrne19gjLM0sQ5HypoRjakO6MtD5zL
 cuaINZ+hMG7Efjvy56x3qsmbflvBAFnePUFb1vF83xbT0BJAGW97yA9REtARmvXUtQAB
 vPH67nF/q/Dab580n6T9gl1lzY6VWyWgy/cBbYjHxYSE3U5pP2ALLVlCl+3pRIupkUGF
 DImw==
X-Gm-Message-State: AGi0PuatXIJQS2v2d/ULBAJn3eGsodNwAJGUlKavhEn3AQHopELSNkmW
 XNcZcUXRa3o2Bp4Q2Jr8F4Ts40/D
X-Google-Smtp-Source: APiQypKmlT9aq/TzxS5uBTxcsjHpC4xVZm8qNsGXCnXcX3FOQuT35eiGxbnsDadikqWxxWPWRKeQeg==
X-Received: by 2002:adf:dec9:: with SMTP id i9mr16052755wrn.197.1587397533146; 
 Mon, 20 Apr 2020 08:45:33 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id i17sm1646635wru.39.2020.04.20.08.45.32
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 20 Apr 2020 08:45:32 -0700 (PDT)
Subject: Re: [PATCH] drm/amdgpu: clean up unused variable about ring lru
To: Kevin Wang <kevin1.wang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20200420152706.37360-1-kevin1.wang@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <cf3cefe5-1ff4-81d9-060f-39eb9cef6cd4@gmail.com>
Date: Mon, 20 Apr 2020 17:45:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200420152706.37360-1-kevin1.wang@amd.com>
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
Reply-To: christian.koenig@amd.com
Cc: Alexander.Deucher@amd.com, christian.koenig@amd.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMjAuMDQuMjAgdW0gMTc6Mjcgc2NocmllYiBLZXZpbiBXYW5nOgo+IGNsZWFuIHVwIHVudXNl
ZCB2YXJpYWJsZToKPiAxLiByaW5nX2xydV9saXN0Cj4gMi4gcmluZ19scnVfbGlzdF9sb2NrCj4K
PiByZWxhdGVkLWNvbW1pdDoKPiBkcm0vYW1kZ3B1OiByZW1vdmUgcmluZyBscnUgaGFuZGxpbmcK
Pgo+IFNpZ25lZC1vZmYtYnk6IEtldmluIFdhbmcgPGtldmluMS53YW5nQGFtZC5jb20+CgpSZXZp
ZXdlZC1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgoKRm91
bmQgYnkgYWNjaWRlbnQgb3IgdXNlZCBzb21lIHRvb2w/IEknbSBhc2tpbmcgYmVjYXVzZSBJJ20g
cHJldHR5IHN1cmUgCndlIGhhdmUgbW9yZSBsaWtlIHRob3NlLgoKVGhhbmtzLApDaHJpc3RpYW4u
Cgo+IC0tLQo+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1LmggICAgICAgIHwg
MyAtLS0KPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYyB8IDMg
LS0tCj4gICAyIGZpbGVzIGNoYW5nZWQsIDYgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1LmggYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHUuaAo+IGluZGV4IDk0ZGZmODk5MjQ4ZC4uZThhYjNkZGU2YTY2IDEwMDY0
NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdS5oCj4gKysrIGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1LmgKPiBAQCAtOTUzLDkgKzk1Myw2IEBAIHN0
cnVjdCBhbWRncHVfZGV2aWNlIHsKPiAgIAkvKiBsaW5rIGFsbCBzaGFkb3cgYm8gKi8KPiAgIAlz
dHJ1Y3QgbGlzdF9oZWFkICAgICAgICAgICAgICAgIHNoYWRvd19saXN0Owo+ICAgCXN0cnVjdCBt
dXRleCAgICAgICAgICAgICAgICAgICAgc2hhZG93X2xpc3RfbG9jazsKPiAtCS8qIGtlZXAgYW4g
bHJ1IGxpc3Qgb2YgcmluZ3MgYnkgSFcgSVAgKi8KPiAtCXN0cnVjdCBsaXN0X2hlYWQJCXJpbmdf
bHJ1X2xpc3Q7Cj4gLQlzcGlubG9ja190CQkJcmluZ19scnVfbGlzdF9sb2NrOwo+ICAgCj4gICAJ
LyogcmVjb3JkIGh3IHJlc2V0IGlzIHBlcmZvcm1lZCAqLwo+ICAgCWJvb2wgaGFzX2h3X3Jlc2V0
Owo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNl
LmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMKPiBpbmRleCA3
MWVhNTZlMjIwYWUuLjM4ZWI3MzYwOTFkMCAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfZGV2aWNlLmMKPiBAQCAtMjk5MCw5ICsyOTkwLDYgQEAgaW50IGFtZGdwdV9k
ZXZpY2VfaW5pdChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwKPiAgIAlJTklUX0xJU1RfSEVB
RCgmYWRldi0+c2hhZG93X2xpc3QpOwo+ICAgCW11dGV4X2luaXQoJmFkZXYtPnNoYWRvd19saXN0
X2xvY2spOwo+ICAgCj4gLQlJTklUX0xJU1RfSEVBRCgmYWRldi0+cmluZ19scnVfbGlzdCk7Cj4g
LQlzcGluX2xvY2tfaW5pdCgmYWRldi0+cmluZ19scnVfbGlzdF9sb2NrKTsKPiAtCj4gICAJSU5J
VF9ERUxBWUVEX1dPUksoJmFkZXYtPmRlbGF5ZWRfaW5pdF93b3JrLAo+ICAgCQkJICBhbWRncHVf
ZGV2aWNlX2RlbGF5ZWRfaW5pdF93b3JrX2hhbmRsZXIpOwo+ICAgCUlOSVRfREVMQVlFRF9XT1JL
KCZhZGV2LT5nZnguZ2Z4X29mZl9kZWxheV93b3JrLAoKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0
cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9s
aXN0aW5mby9hbWQtZ2Z4Cg==
