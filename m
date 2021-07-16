Return-Path: <SRS0=OLwD=MI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1C99C12002
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Jul 2021 07:20:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78E23613DF
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Jul 2021 07:20:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78E23613DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2CA2D6E92C;
	Fri, 16 Jul 2021 07:20:26 +0000 (UTC)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F9F46E92C
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Jul 2021 07:20:25 +0000 (UTC)
Received: by mail-wr1-x42f.google.com with SMTP id r11so10882242wro.9
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Jul 2021 00:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=tugm+L6sQlo7Xs9UnyYT+5ID2rVJCeZ7I/w8+tVOxGM=;
 b=pXFs0oQZEDS+O/HhkhV3dPf31Y4qzKFDtv208z5WadB9+JbLkmwond/l11QwhYdedo
 hX6JNRUaA5xRIod0JBCJv5oIMyuEhBaW7PkisCLs1vT6bp5WaiJCXqv4a9Tq5+7kvUTs
 MUSi88qfoE4E/Ip1Wfu+Zvf/Gj0S/BVrVwkE3EmJnRbeTXrn3qTXF8syoYOw6tf5094O
 mtc0ouX+2z3/9AC8QhIM0IkaXXbIkZVM3AN0lZIxXX8W+kCKTVfEGeivlNoj7KAdY9nX
 sR5+zeVUxf31b+N6J5ai3bcCk01QbonqoBAXUDYfDDWpU8ushUvdyQo8r6FzA5sTJ56e
 JBtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=tugm+L6sQlo7Xs9UnyYT+5ID2rVJCeZ7I/w8+tVOxGM=;
 b=t0g5Z6YXqfCTC8PLG/7I/OU6gOVpCsHdci6Dlmjf0sRvPAVMqupbXKdKGcA4PVeL6P
 t0Ejz5TXSnsJVPbfQWNBVXxT1hpj/0biPrjEtoRQ6Py1OqoZSg1J/AgsZcoECZfREU2+
 /cIFKDKyUr8cYKU2JZPCJtJsVJzzVpWxCoEfgm39TU551dSz2GBCSrJlUFVGlON6kzW0
 8OzoTjg5bEciyzklzG0IqnCvpyRKkScmC3o8mQzx3j8A0lD8CQybYrTm5S4awFPtQC9C
 FLBF4Lv+tsh9wh7sSg5HsFH83CBj4NZelLH5Q2jbDlpe6phPs5dKYv0rZz9N8kY5pkka
 9iJA==
X-Gm-Message-State: AOAM531ADF/+FcV+1rpJkhZ7WiMxlKC0dRhipK1uPzQaIXUnCzcnWfyT
 QRZDotxoq/OY37LhF9llA5Ga2R9C4xc=
X-Google-Smtp-Source: ABdhPJwHYHZXH58pIng2QkIjkC68+CEV/gCO1Ct3qgQSRhAjqA4j1c53XEQF70e+TXMnfYt4VzUClw==
X-Received: by 2002:adf:f305:: with SMTP id i5mr10428823wro.122.1626420023887; 
 Fri, 16 Jul 2021 00:20:23 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:e013:2fad:8ece:8234?
 ([2a02:908:1252:fb60:e013:2fad:8ece:8234])
 by smtp.gmail.com with ESMTPSA id j3sm4228974wms.30.2021.07.16.00.20.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Jul 2021 00:20:23 -0700 (PDT)
Subject: Re: [PATCH 1/5] drm/amdgpu: Fix a printing message
To: Oak Zeng <Oak.Zeng@amd.com>, amd-gfx@lists.freedesktop.org
References: <1626399273-21347-1-git-send-email-Oak.Zeng@amd.com>
 <1626399273-21347-2-git-send-email-Oak.Zeng@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <16314a0c-dcc7-639b-15c5-d760830034f5@gmail.com>
Date: Fri, 16 Jul 2021 09:20:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <1626399273-21347-2-git-send-email-Oak.Zeng@amd.com>
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
Cc: feifei.xu@amd.com, Felix.Kuehling@amd.com, leo.liu@amd.com,
 hawking.zhang@amd.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMTYuMDcuMjEgdW0gMDM6MzQgc2NocmllYiBPYWsgWmVuZzoKPiBUaGUgcHJpbnRpbmcgbWVz
c2FnZSAiUFNQIGxvYWRpbmcgVkNOIGZpcm13YXJlIiBpcyBtaXMtbGVhZGluZyBiZWNhdXNlCj4g
cGVvcGxlIG1pZ2h0IHRoaW5rIGRyaXZlciBpcyBsb2FkaW5nIFZDTiBmaXJtd2FyZS4gQWN0dWFs
bHkgd2hlbiB0aGlzCj4gbWVzc2FnZSBpcyBwcmludGVkLCBkcml2ZXIgaXMganVzdCBwcmVwYXJp
bmcgc29tZSBWQ04gdWNvZGUsIG5vdCBsb2FkaW5nCj4gVkNOIGZpcm13YXJlIHlldC4gVGhlIGFj
dHVhbCBWQ04gZmlybXdhcmUgbG9hZGluZyB3aWxsIGJlIGluIHRoZSBQU1AgYmxvY2sKPiBod19p
bml0LiBGaXggdGhlIHByaW50aW5nIG1lc3NhZ2UKPgo+IFNpZ25lZC1vZmYtYnk6IE9hayBaZW5n
IDxPYWsuWmVuZ0BhbWQuY29tPgoKUmV2aWV3ZWQtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlz
dGlhbi5rb2VuaWdAYW1kLmNvbT4gZm9yIHBhdGNoICMxIGFuZCAjMi4KCkFja2VkLWJ5OiBDaHJp
c3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+IGZvciB0aGUgcmVzdCBvZiB0
aGUgCnNlcmllcy4KClJlZ2FyZHMsCkNocmlzdGlhbi4KCj4gLS0tCj4gICBkcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS92Y25fdjFfMC5jIHwgMiArLQo+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvdmNuX3YyXzAuYyB8IDIgKy0KPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3Zj
bl92Ml81LmMgfCAyICstCj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS92Y25fdjNfMC5j
IHwgMiArLQo+ICAgNCBmaWxlcyBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25z
KC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvdmNuX3YxXzAu
YyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3Zjbl92MV8wLmMKPiBpbmRleCAyODRiYjQy
Li4xMjFlZTlmIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3Zjbl92
MV8wLmMKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS92Y25fdjFfMC5jCj4gQEAg
LTExOSw3ICsxMTksNyBAQCBzdGF0aWMgaW50IHZjbl92MV8wX3N3X2luaXQodm9pZCAqaGFuZGxl
KQo+ICAgCQlhZGV2LT5maXJtd2FyZS51Y29kZVtBTURHUFVfVUNPREVfSURfVkNOXS5mdyA9IGFk
ZXYtPnZjbi5mdzsKPiAgIAkJYWRldi0+ZmlybXdhcmUuZndfc2l6ZSArPQo+ICAgCQkJQUxJR04o
bGUzMl90b19jcHUoaGRyLT51Y29kZV9zaXplX2J5dGVzKSwgUEFHRV9TSVpFKTsKPiAtCQlEUk1f
SU5GTygiUFNQIGxvYWRpbmcgVkNOIGZpcm13YXJlXG4iKTsKPiArCQlkZXZfaW5mbyhhZGV2LT5k
ZXYsICJXaWxsIHVzZSBQU1AgdG8gbG9hZCBWQ04gZmlybXdhcmVcbiIpOwo+ICAgCX0KPiAgIAo+
ICAgCXIgPSBhbWRncHVfdmNuX3Jlc3VtZShhZGV2KTsKPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvdmNuX3YyXzAuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L3Zjbl92Ml8wLmMKPiBpbmRleCA4YWY1NjdjLi5mNDY4NmU5IDEwMDY0NAo+IC0tLSBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3Zjbl92Ml8wLmMKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS92Y25fdjJfMC5jCj4gQEAgLTEyMiw3ICsxMjIsNyBAQCBzdGF0aWMgaW50IHZj
bl92Ml8wX3N3X2luaXQodm9pZCAqaGFuZGxlKQo+ICAgCQlhZGV2LT5maXJtd2FyZS51Y29kZVtB
TURHUFVfVUNPREVfSURfVkNOXS5mdyA9IGFkZXYtPnZjbi5mdzsKPiAgIAkJYWRldi0+ZmlybXdh
cmUuZndfc2l6ZSArPQo+ICAgCQkJQUxJR04obGUzMl90b19jcHUoaGRyLT51Y29kZV9zaXplX2J5
dGVzKSwgUEFHRV9TSVpFKTsKPiAtCQlEUk1fSU5GTygiUFNQIGxvYWRpbmcgVkNOIGZpcm13YXJl
XG4iKTsKPiArCQlkZXZfaW5mbyhhZGV2LT5kZXYsICJXaWxsIHVzZSBQU1AgdG8gbG9hZCBWQ04g
ZmlybXdhcmVcbiIpOwo+ICAgCX0KPiAgIAo+ICAgCXIgPSBhbWRncHVfdmNuX3Jlc3VtZShhZGV2
KTsKPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvdmNuX3YyXzUuYyBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3Zjbl92Ml81LmMKPiBpbmRleCA4ODhiMTdkLi5l
MGMwYzM3IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3Zjbl92Ml81
LmMKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS92Y25fdjJfNS5jCj4gQEAgLTE1
Miw3ICsxNTIsNyBAQCBzdGF0aWMgaW50IHZjbl92Ml81X3N3X2luaXQodm9pZCAqaGFuZGxlKQo+
ICAgCQkJYWRldi0+ZmlybXdhcmUuZndfc2l6ZSArPQo+ICAgCQkJCUFMSUdOKGxlMzJfdG9fY3B1
KGhkci0+dWNvZGVfc2l6ZV9ieXRlcyksIFBBR0VfU0laRSk7Cj4gICAJCX0KPiAtCQlEUk1fSU5G
TygiUFNQIGxvYWRpbmcgVkNOIGZpcm13YXJlXG4iKTsKPiArCQlkZXZfaW5mbyhhZGV2LT5kZXYs
ICJXaWxsIHVzZSBQU1AgdG8gbG9hZCBWQ04gZmlybXdhcmVcbiIpOwo+ICAgCX0KPiAgIAo+ICAg
CXIgPSBhbWRncHVfdmNuX3Jlc3VtZShhZGV2KTsKPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvdmNuX3YzXzAuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3Zj
bl92M18wLmMKPiBpbmRleCBjMzU4MGRlLi5hMWJiZTMzIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L3Zjbl92M18wLmMKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS92Y25fdjNfMC5jCj4gQEAgLTE1OCw3ICsxNTgsNyBAQCBzdGF0aWMgaW50IHZjbl92
M18wX3N3X2luaXQodm9pZCAqaGFuZGxlKQo+ICAgCQkJYWRldi0+ZmlybXdhcmUuZndfc2l6ZSAr
PQo+ICAgCQkJCUFMSUdOKGxlMzJfdG9fY3B1KGhkci0+dWNvZGVfc2l6ZV9ieXRlcyksIFBBR0Vf
U0laRSk7Cj4gICAJCX0KPiAtCQlEUk1fSU5GTygiUFNQIGxvYWRpbmcgVkNOIGZpcm13YXJlXG4i
KTsKPiArCQlkZXZfaW5mbyhhZGV2LT5kZXYsICJXaWxsIHVzZSBQU1AgdG8gbG9hZCBWQ04gZmly
bXdhcmVcbiIpOwo+ICAgCX0KPiAgIAo+ICAgCXIgPSBhbWRncHVfdmNuX3Jlc3VtZShhZGV2KTsK
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZngg
bWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
