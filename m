Return-Path: <SRS0=oJVB=J2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A790C433B4
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Apr 2021 11:29:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27BAE6142A
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Apr 2021 11:29:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27BAE6142A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E8E46EE37;
	Thu, 29 Apr 2021 11:29:01 +0000 (UTC)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BEE376EE27
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Apr 2021 11:28:59 +0000 (UTC)
Received: by mail-ed1-x532.google.com with SMTP id d14so14287215edc.12
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Apr 2021 04:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-transfer-encoding:content-language;
 bh=ZBujG5sKNYYZ2v4jL2F9AkFg8o13ICR6zmFAd1+6vcY=;
 b=fn5lnWke4TV1z1+A1qarO8+CEGPjk+TTxhdIbt4k9keBAU8m1ZUPdWIW683IVpkXvK
 5FWqD/II6q1siJ9LZ1bPq8K8B2lTn8nX/veNn036jvQRPWpT9+1T0LcorKKGd0j1oATk
 HoJPoParY6KtBjZsGfdQzeddC2JFZNA/6mk9iw5w4anAc3qmfZZNMB/zAHJ9yxXrhH/L
 JCSirgWkIVgC/+DvrcV+7QfEG//tKVc1jh6lzSs/mEAyGUzGCwofnQKq7P05MLDnC5Jk
 vrYtJWGYzvJuimPdM5hIgxFySg1b032bZ7owkfarAVQqor6tLlWDtL2g3ZPuxnrWOHZM
 ST1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=ZBujG5sKNYYZ2v4jL2F9AkFg8o13ICR6zmFAd1+6vcY=;
 b=medfv160eVBGdB339hAHh/63ErLeb/+WE40go00h3JRmHDPjmwO2l/0ZBRhjT+yw8L
 U6lmShK1sm70QvKAW+IOG7FIGKYeObvPk9/iQugJaaMSbOHC/gn3UgoifVuv55lsZBj8
 2AvgeuF2yrzHsL3IUHjUbX8iVKwHFF1U5tb5et1bIOpN18U+UYBUtG+fvWJqTysVzdfl
 Sqek/0SehgdhMwPj/YSR3cNrYV9VrqcKr73Z6m2pgSJqYMiucYm6Hf4OuznwI7jeYWQh
 YeXq20C2CyusK2QtFj3P0vgZN5+6O8vd3r4icTjsWyV1e9mTBfYx0Z+5MUJukEfqZp1q
 QcBA==
X-Gm-Message-State: AOAM532Z9HnUAx7dzR3rqbSGgCSqNGEC//1GtrcSXd4M98Ag9srBPL0v
 tARMD8lx9C5m5jdUkC+WennHYMHbj+I=
X-Google-Smtp-Source: ABdhPJzTGavrMWaZiMK2QxGnFQO7HfISv2krnp7yNUhn/vjVGoqQj4jQaiOaPHnrc4uO8YoSAouysQ==
X-Received: by 2002:aa7:ce8f:: with SMTP id y15mr1874697edv.148.1619695738380; 
 Thu, 29 Apr 2021 04:28:58 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:8299:a26e:a76a:ba4?
 ([2a02:908:1252:fb60:8299:a26e:a76a:ba4])
 by smtp.gmail.com with ESMTPSA id r18sm1630036ejd.106.2021.04.29.04.28.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Apr 2021 04:28:57 -0700 (PDT)
Subject: Re: [PATCH v2 12/12] drm/amdgpu: Refine the error report when flush
 tlb.
To: Peng Ju Zhou <PengJu.Zhou@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210429102644.31172-1-PengJu.Zhou@amd.com>
 <20210429102644.31172-12-PengJu.Zhou@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <ec0ac02e-565d-39f4-ea91-f4f59e8efbb7@gmail.com>
Date: Thu, 29 Apr 2021 13:28:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210429102644.31172-12-PengJu.Zhou@amd.com>
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

QW0gMjkuMDQuMjEgdW0gMTI6MjYgc2NocmllYiBQZW5nIEp1IFpob3U6Cj4gdGhlcmUgYXJlIDIg
aHVicyB0byBmbHVzaCBpbiB0aGUgZ21jLCB0byBtYWtlIGl0IGVhc2llcgo+IHRvIGRlYnVnIHdo
ZW4gaHViIGZsdXNoIGZhaWxlZCwgcmVmaW5lIHRoZSBsb2dzLgoKTkFLLCB3ZSBjYW4gaGF2ZSBt
b3JlIHRoYW4ganVzdCB0aGUgdHdvIGh1YnMuCgpTZWUgZ21jX3Y5XzBfcHJvY2Vzc19pbnRlcnJ1
cHQ6CgogwqDCoMKgwqDCoMKgwqAgaWYgKGVudHJ5LT5jbGllbnRfaWQgPT0gU09DMTVfSUhfQ0xJ
RU5USURfVk1DKSB7CiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaHViX25hbWUgPSAi
bW1odWIwIjsKIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBodWIgPSAmYWRldi0+dm1o
dWJbQU1ER1BVX01NSFVCXzBdOwogwqDCoMKgwqDCoMKgwqAgfSBlbHNlIGlmIChlbnRyeS0+Y2xp
ZW50X2lkID09IFNPQzE1X0lIX0NMSUVOVElEX1ZNQzEpIHsKIMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBodWJfbmFtZSA9ICJtbWh1YjEiOwogwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIGh1YiA9ICZhZGV2LT52bWh1YltBTURHUFVfTU1IVUJfMV07CiDCoMKgwqDCoMKgwqDC
oCB9IGVsc2UgewogwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGh1Yl9uYW1lID0gImdm
eGh1YjAiOwogwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGh1YiA9ICZhZGV2LT52bWh1
YltBTURHUFVfR0ZYSFVCXzBdOwogwqDCoMKgwqDCoMKgwqAgfQoKTWF5YmUgcHV0IHRoZSBuYW1l
IGludG8gdGhlIGh1YiBzdHJ1Y3R1cmUgYXMgd2VsbC4KCkNocmlzdGlhbi4KCgo+Cj4gU2lnbmVk
LW9mZi1ieTogUGVuZyBKdSBaaG91IDxQZW5nSnUuWmhvdUBhbWQuY29tPgo+IC0tLQo+ICAgZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ21jX3YxMF8wLmMgfCAzICsrLQo+ICAgMSBmaWxlIGNo
YW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQo+Cj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dtY192MTBfMC5jIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvZ21jX3YxMF8wLmMKPiBpbmRleCBjMjU1NDExMTI2NjMuLjMzY2Q0ODc3NDFmNyAx
MDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nbWNfdjEwXzAuYwo+ICsr
KyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dtY192MTBfMC5jCj4gQEAgLTI5Nyw3ICsy
OTcsOCBAQCBzdGF0aWMgdm9pZCBnbWNfdjEwXzBfZmx1c2hfdm1faHViKHN0cnVjdCBhbWRncHVf
ZGV2aWNlICphZGV2LCB1aW50MzJfdCB2bWlkLAo+ICAgCWlmIChpIDwgYWRldi0+dXNlY190aW1l
b3V0KQo+ICAgCQlyZXR1cm47Cj4gICAKPiAtCURSTV9FUlJPUigiVGltZW91dCB3YWl0aW5nIGZv
ciBWTSBmbHVzaCBBQ0shXG4iKTsKPiArCURSTV9FUlJPUigiVGltZW91dCB3YWl0aW5nIGZvciBW
TSBmbHVzaCBodWI6ICVzIVxuIiwKPiArCQkgIHZtaHViID09IEFNREdQVV9HRlhIVUJfMCA/ICJn
ZnhodWIiIDogIm1taHViIik7Cj4gICB9Cj4gICAKPiAgIC8qKgoKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdm
eEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFp
bG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
