Return-Path: <SRS0=BBBq=HF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDC29C433DB
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Feb 2021 09:07:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5409B64E34
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Feb 2021 09:07:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5409B64E34
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D5003892B1;
	Wed,  3 Feb 2021 09:07:34 +0000 (UTC)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 69DA0892B1
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Feb 2021 09:07:33 +0000 (UTC)
Received: by mail-ed1-x52b.google.com with SMTP id y18so8614887edw.13
 for <amd-gfx@lists.freedesktop.org>; Wed, 03 Feb 2021 01:07:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=Klp20eWeo0RemMsgQfHSZxHf94X3AvDILU9V+yD88fE=;
 b=BIa8gDz7QMnVCa6n4PmrS1zYPE9QqmpSstb66KaNJgWhK956HwO7Bux/vzAhqo9Dr5
 flMYefr4tXxCe0jya1RmSZBJovRgdlggzOpwGcNPv2Mc+qPXOoSW5Vf+gVFVpf8adC2K
 p/u8uqgvVSADER57OqogBXYExbXfgSikXqfk/wFwKml0sDU5gWCgB8OeRtwDxTORzOCG
 fuSphXDMDzecM0zydFPHPJMTYXPv+rrVpe1aMG4rmi3WmcCjmCzGjsAbHKm5HMmVKDhD
 6tl/GqftpbSDL9PhIkzoJSh5jPziWOk3o9L4WCUjoIXD5xOgKMstkgeC1ScBMoueaWXl
 1m0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=Klp20eWeo0RemMsgQfHSZxHf94X3AvDILU9V+yD88fE=;
 b=Qi48NXzelvWVJvIrOMdZY5llqYBzJz9V9Bz2ZLTamT9zv0k76ADlnLIynJed2q//Rz
 kcw+E/QbyoZ+FCe7Cp/LVmRqMxEg3UlALHmlhyPGuHTFpwMJKyVvyNIhXN5wm8V5nNzc
 X3t/sKrgvvXiMm5CJydkv7DjaAiGczsyj+XqnkmaPJo3wF1O8oC5sPHv1YlFEYGTp3ZD
 sqd3rGso2B35US0ozazp7oGZ7uHhN1+QFNJRWdWrSmx0k6XpnWr2qT74QNVUsH5xFwpy
 6mgKw90vhwBfHzjFgIvTqtyz4VAzWWL3ho+tVtzG9IZZcuswNz9HpVf01o3vMoeFPgWW
 T3LQ==
X-Gm-Message-State: AOAM5339ES78snspXbkkT3ynpV2OMiEoAcLdDXKOuvtnR9a7YikBYbnl
 nHpmI5tmAHDHNEa35C7diXE=
X-Google-Smtp-Source: ABdhPJzKEEEmdPm5gl8mWBOOH0pbNdPieeg9GAD3CGoz2qX7Kr33cERN2qfMBaSNGRFT26yo2rt3Tg==
X-Received: by 2002:a05:6402:104e:: with SMTP id
 e14mr1992139edu.316.1612343252161; 
 Wed, 03 Feb 2021 01:07:32 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id j9sm557101edr.25.2021.02.03.01.07.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Feb 2021 01:07:31 -0800 (PST)
Subject: Re: [PATCH] drm/amdgpu/gmc9: fix mmhub client mapping for arcturus
To: Alex Deucher <alexdeucher@gmail.com>, amd-gfx@lists.freedesktop.org
References: <20210202215445.1505390-1-alexander.deucher@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <e3a8fa5e-6ab7-6662-b9f8-af14021f4ced@gmail.com>
Date: Wed, 3 Feb 2021 10:07:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210202215445.1505390-1-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMDIuMDIuMjEgdW0gMjI6NTQgc2NocmllYiBBbGV4IERldWNoZXI6Cj4gVGhlIGh3IGludGVy
ZmFjZSBjaGFuZ2VkIG9uIGFyY3R1cnVzIHNvIHRoZSBvbGQgbnVtYmVyaW5nCj4gc2NoZW1lIGRv
ZXNuJ3Qgd29yay4KPgo+IFNpZ25lZC1vZmYtYnk6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRl
dWNoZXJAYW1kLmNvbT4KCkFja2VkLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29l
bmlnQGFtZC5jb20+Cgo+IC0tLQo+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ21jX3Y5
XzAuYyB8IDY2ICsrKysrKysrKysrKystLS0tLS0tLS0tLS0tLQo+ICAgMSBmaWxlIGNoYW5nZWQs
IDMyIGluc2VydGlvbnMoKyksIDM0IGRlbGV0aW9ucygtKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dtY192OV8wLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9nbWNfdjlfMC5jCj4gaW5kZXggYWVkZWY5MDE3YzRjLi4zNjg2ZTc3N2M3NmMgMTAwNjQ0
Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ21jX3Y5XzAuYwo+ICsrKyBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dtY192OV8wLmMKPiBAQCAtMjM5LDQ2ICsyMzksNDQg
QEAgc3RhdGljIGNvbnN0IGNoYXIgKm1taHViX2NsaWVudF9pZHNfdmVnYTIwW11bMl0gPSB7Cj4g
ICB9Owo+ICAgCj4gICBzdGF0aWMgY29uc3QgY2hhciAqbW1odWJfY2xpZW50X2lkc19hcmN0dXJ1
c1tdWzJdID0gewo+ICsJWzBdWzBdID0gIkRCR1UxIiwKPiArCVsxXVswXSA9ICJYRFAiLAo+ICAg
CVsyXVswXSA9ICJNUDEiLAo+IC0JWzNdWzBdID0gIk1QMCIsCj4gLQlbMTBdWzBdID0gIlVUQ0wy
IiwKPiAtCVsxM11bMF0gPSAiT1NTIiwKPiAgIAlbMTRdWzBdID0gIkhEUCIsCj4gLQlbMTVdWzBd
ID0gIlNETUEwIiwKPiAtCVszMisxNV1bMF0gPSAiU0RNQTEiLAo+IC0JWzY0KzE1XVswXSA9ICJT
RE1BMiIsCj4gLQlbOTYrMTVdWzBdID0gIlNETUEzIiwKPiAtCVsxMjgrMTVdWzBdID0gIlNETUE0
IiwKPiAtCVsxNjArMTFdWzBdID0gIkpQRUciLAo+IC0JWzE2MCsxMl1bMF0gPSAiVkNOIiwKPiAt
CVsxNjArMTNdWzBdID0gIlZDTlUiLAo+IC0JWzE2MCsxNV1bMF0gPSAiU0RNQTUiLAo+IC0JWzE5
MisxMF1bMF0gPSAiVVRDTDIiLAo+IC0JWzE5MisxMV1bMF0gPSAiSlBFRzEiLAo+IC0JWzE5Misx
Ml1bMF0gPSAiVkNOMSIsCj4gLQlbMTkyKzEzXVswXSA9ICJWQ04xVSIsCj4gLQlbMTkyKzE1XVsw
XSA9ICJTRE1BNiIsCj4gLQlbMjI0KzE1XVswXSA9ICJTRE1BNyIsCj4gKwlbMTcxXVswXSA9ICJK
UEVHIiwKPiArCVsxNzJdWzBdID0gIlZDTiIsCj4gKwlbMTczXVswXSA9ICJWQ05VIiwKPiArCVsy
MDNdWzBdID0gIkpQRUcxIiwKPiArCVsyMDRdWzBdID0gIlZDTjEiLAo+ICsJWzIwNV1bMF0gPSAi
VkNOMVUiLAo+ICsJWzI1Nl1bMF0gPSAiU0RNQTAiLAo+ICsJWzI1N11bMF0gPSAiU0RNQTEiLAo+
ICsJWzI1OF1bMF0gPSAiU0RNQTIiLAo+ICsJWzI1OV1bMF0gPSAiU0RNQTMiLAo+ICsJWzI2MF1b
MF0gPSAiU0RNQTQiLAo+ICsJWzI2MV1bMF0gPSAiU0RNQTUiLAo+ICsJWzI2Ml1bMF0gPSAiU0RN
QTYiLAo+ICsJWzI2M11bMF0gPSAiU0RNQTciLAo+ICsJWzM4NF1bMF0gPSAiT1NTIiwKPiAgIAlb
MF1bMV0gPSAiREJHVTEiLAo+ICAgCVsxXVsxXSA9ICJYRFAiLAo+ICAgCVsyXVsxXSA9ICJNUDEi
LAo+IC0JWzNdWzFdID0gIk1QMCIsCj4gLQlbMTNdWzFdID0gIk9TUyIsCj4gICAJWzE0XVsxXSA9
ICJIRFAiLAo+IC0JWzE1XVsxXSA9ICJTRE1BMCIsCj4gLQlbMzIrMTVdWzFdID0gIlNETUExIiwK
PiAtCVs2NCsxNV1bMV0gPSAiU0RNQTIiLAo+IC0JWzk2KzE1XVsxXSA9ICJTRE1BMyIsCj4gLQlb
MTI4KzE1XVsxXSA9ICJTRE1BNCIsCj4gLQlbMTYwKzExXVsxXSA9ICJKUEVHIiwKPiAtCVsxNjAr
MTJdWzFdID0gIlZDTiIsCj4gLQlbMTYwKzEzXVsxXSA9ICJWQ05VIiwKPiAtCVsxNjArMTVdWzFd
ID0gIlNETUE1IiwKPiAtCVsxOTIrMTFdWzFdID0gIkpQRUcxIiwKPiAtCVsxOTIrMTJdWzFdID0g
IlZDTjEiLAo+IC0JWzE5MisxM11bMV0gPSAiVkNOMVUiLAo+IC0JWzE5MisxNV1bMV0gPSAiU0RN
QTYiLAo+IC0JWzIyNCsxNV1bMV0gPSAiU0RNQTciLAo+ICsJWzE3MV1bMV0gPSAiSlBFRyIsCj4g
KwlbMTcyXVsxXSA9ICJWQ04iLAo+ICsJWzE3M11bMV0gPSAiVkNOVSIsCj4gKwlbMjAzXVsxXSA9
ICJKUEVHMSIsCj4gKwlbMjA0XVsxXSA9ICJWQ04xIiwKPiArCVsyMDVdWzFdID0gIlZDTjFVIiwK
PiArCVsyNTZdWzFdID0gIlNETUEwIiwKPiArCVsyNTddWzFdID0gIlNETUExIiwKPiArCVsyNThd
WzFdID0gIlNETUEyIiwKPiArCVsyNTldWzFdID0gIlNETUEzIiwKPiArCVsyNjBdWzFdID0gIlNE
TUE0IiwKPiArCVsyNjFdWzFdID0gIlNETUE1IiwKPiArCVsyNjJdWzFdID0gIlNETUE2IiwKPiAr
CVsyNjNdWzFdID0gIlNETUE3IiwKPiArCVszODRdWzFdID0gIk9TUyIsCj4gICB9Owo+ICAgCj4g
ICBzdGF0aWMgY29uc3Qgc3RydWN0IHNvYzE1X3JlZ19nb2xkZW4gZ29sZGVuX3NldHRpbmdzX21t
aHViXzFfMF8wW10gPQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcK
aHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
