Return-Path: <SRS0=Ip1/=KM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3D4AC43460
	for <amd-gfx@archiver.kernel.org>; Mon, 17 May 2021 19:40:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75F596128E
	for <amd-gfx@archiver.kernel.org>; Mon, 17 May 2021 19:40:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75F596128E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 788AF6EA67;
	Mon, 17 May 2021 19:40:00 +0000 (UTC)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 21D766EA65;
 Mon, 17 May 2021 19:39:59 +0000 (UTC)
Received: by mail-ej1-x629.google.com with SMTP id b25so10936002eju.5;
 Mon, 17 May 2021 12:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=38ziZcYcZr57KsHEyvHZhQV5MTnxcJn5y4DdrSJQiwY=;
 b=QEu511/bsk+JD0G5PmN5tLFhHqljFLF/7D5v/wslkHlrRvVQsuPwtv3myKNMgQDyCN
 uVq9XOP2RU+7Zo2jIzsn3hoiMa4YVW9YWgpH4ExrUHrUTQyKLSCvW78cgmhZpYTnpdUX
 IuKqzQSQ3unrumnWX6h5sLExuzRc3C1Hgu/uOdpToyPraYs6vW0/dvoqLVbomOSYqvml
 TuCBk8eaSVWYCDDqGAmHiNkCNIFCBvAV+6xIsVQubqziCgLACIV+Oi8JU6DKkZ5YN7LG
 58Rk+zQ+0NzdyJWmeGlh8Bfddl28vKw2GQrzXswX9rH3xnPkxRhEf/g9KKBK1iCl8vqu
 dV7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=38ziZcYcZr57KsHEyvHZhQV5MTnxcJn5y4DdrSJQiwY=;
 b=OWO6n5ojf7Otkjqy1G3ZJIcR6kJVLLFm2tUR/zOuAsWZ9Uz7AQq8oUSvPVUzPj47Z0
 KVHZEBj9TQlyFCHdOc2Y1hHxv7URN5QSyPGBjrCTGaTZXZukYqE51pOvcL/yQhQE6K1z
 lROlLJSw+nZKLQkFqkRGJGjtcMyTg6JeoNJVDewmn6wyn8z3sDAz1pArzedZfpPOD/Z8
 F19gMjGLgplVPVW8Ami37IcCtKiTPh+/oCt6gMe6D0Jh7vFY8OxaChaR5p7m2mQSo2fa
 l0yaE3ujZfppdc7uv5nrukCWDyyhIa3UpSPfUVPbV+1jYW3r7Sh/q96WN+/rLHJp32Me
 DtzQ==
X-Gm-Message-State: AOAM5310gFpmwj7wqb8+TeJ5Zf+c/rVSY/D59WwDSO+0lzZuRPycKS6Q
 aQzp4aD699ZDCLv6DKPgOk4=
X-Google-Smtp-Source: ABdhPJwwxfd2fPAJc2OXSfYAbVpwpof6Ye0W4UuLSzuIf3R7gbpdKVyI0Ez/ieb3VCy7w6My8thk4A==
X-Received: by 2002:a17:906:fa90:: with SMTP id
 lt16mr1555668ejb.411.1621280397777; 
 Mon, 17 May 2021 12:39:57 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:bd86:58d9:7c79:a095?
 ([2a02:908:1252:fb60:bd86:58d9:7c79:a095])
 by smtp.gmail.com with ESMTPSA id z12sm5356339edq.77.2021.05.17.12.39.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 May 2021 12:39:57 -0700 (PDT)
Subject: Re: [PATCH v7 12/16] drm/amdgpu: Fix hang on device removal.
To: Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 linux-pci@vger.kernel.org, daniel.vetter@ffwll.ch, Harry.Wentland@amd.com
References: <20210512142648.666476-1-andrey.grodzovsky@amd.com>
 <20210512142648.666476-13-andrey.grodzovsky@amd.com>
 <0e13e0fb-5cf8-30fa-6ed8-a0648f8fe50b@amd.com>
 <a589044b-8dac-e573-e864-4093e24574a3@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <356d03bf-e221-86b1-f133-83def9d956bd@gmail.com>
Date: Mon, 17 May 2021 21:39:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <a589044b-8dac-e573-e864-4093e24574a3@amd.com>
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
Cc: Alexander.Deucher@amd.com, gregkh@linuxfoundation.org, ppaalanen@gmail.com,
 helgaas@kernel.org, Felix.Kuehling@amd.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

WW91IG5lZWQgdG8gbm90ZSB3aG8geW91IGFyZSBwaW5naW5nIGhlcmUuCgpJJ20gc3RpbGwgYXNz
dW1pbmcgeW91IHdhaXQgZm9yIGZlZWRiYWNrIGZyb20gRGFuaWVsLiBPciBzaG91bGQgSSB0YWtl
IGEgCmxvb2s/CgpDaHJpc3RpYW4uCgpBbSAxNy4wNS4yMSB1bSAxNjo0MCBzY2hyaWViIEFuZHJl
eSBHcm9kem92c2t5Ogo+IFBpbmcKPgo+IEFuZHJleQo+Cj4gT24gMjAyMS0wNS0xNCAxMDo0MiBh
Lm0uLCBBbmRyZXkgR3JvZHpvdnNreSB3cm90ZToKPj4gUGluZwo+Pgo+PiBBbmRyZXkKPj4KPj4g
T24gMjAyMS0wNS0xMiAxMDoyNiBhLm0uLCBBbmRyZXkgR3JvZHpvdnNreSB3cm90ZToKPj4+IElm
IHJlbW92aW5nIHdoaWxlIGNvbW1hbmRzIGluIGZsaWdodCB5b3UgY2Fubm90IHdhaXQgdG8gZmx1
c2ggdGhlCj4+PiBIVyBmZW5jZXMgb24gYSByaW5nIHNpbmNlIHRoZSBkZXZpY2UgaXMgZ29uZS4K
Pj4+Cj4+PiBTaWduZWQtb2ZmLWJ5OiBBbmRyZXkgR3JvZHpvdnNreSA8YW5kcmV5Lmdyb2R6b3Zz
a3lAYW1kLmNvbT4KPj4+IC0tLQo+Pj4gwqAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X2ZlbmNlLmMgfCAxNiArKysrKysrKysrLS0tLS0tCj4+PiDCoCAxIGZpbGUgY2hhbmdlZCwg
MTAgaW5zZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMoLSkKPj4+Cj4+PiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2ZlbmNlLmMgCj4+PiBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9mZW5jZS5jCj4+PiBpbmRleCAxZmZiMzZiZDBiMTkuLmZh
MDM3MDJlY2JmYiAxMDA2NDQKPj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV9mZW5jZS5jCj4+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
ZmVuY2UuYwo+Pj4gQEAgLTM2LDYgKzM2LDcgQEAKPj4+IMKgICNpbmNsdWRlIDxsaW51eC9maXJt
d2FyZS5oPgo+Pj4gwqAgI2luY2x1ZGUgPGxpbnV4L3BtX3J1bnRpbWUuaD4KPj4+ICsjaW5jbHVk
ZSA8ZHJtL2RybV9kcnYuaD4KPj4+IMKgICNpbmNsdWRlICJhbWRncHUuaCIKPj4+IMKgICNpbmNs
dWRlICJhbWRncHVfdHJhY2UuaCIKPj4+IEBAIC01MjUsOCArNTI2LDcgQEAgaW50IGFtZGdwdV9m
ZW5jZV9kcml2ZXJfaW5pdChzdHJ1Y3QgCj4+PiBhbWRncHVfZGV2aWNlICphZGV2KQo+Pj4gwqDC
oCAqLwo+Pj4gwqAgdm9pZCBhbWRncHVfZmVuY2VfZHJpdmVyX2ZpbmlfaHcoc3RydWN0IGFtZGdw
dV9kZXZpY2UgKmFkZXYpCj4+PiDCoCB7Cj4+PiAtwqDCoMKgIHVuc2lnbmVkIGksIGo7Cj4+PiAt
wqDCoMKgIGludCByOwo+Pj4gK8KgwqDCoCBpbnQgaSwgcjsKPj4+IMKgwqDCoMKgwqAgZm9yIChp
ID0gMDsgaSA8IEFNREdQVV9NQVhfUklOR1M7IGkrKykgewo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKg
IHN0cnVjdCBhbWRncHVfcmluZyAqcmluZyA9IGFkZXYtPnJpbmdzW2ldOwo+Pj4gQEAgLTUzNSwx
MSArNTM1LDE1IEBAIHZvaWQgYW1kZ3B1X2ZlbmNlX2RyaXZlcl9maW5pX2h3KHN0cnVjdCAKPj4+
IGFtZGdwdV9kZXZpY2UgKmFkZXYpCj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjb250
aW51ZTsKPj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAoIXJpbmctPm5vX3NjaGVkdWxlcikKPj4+
IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGRybV9zY2hlZF9maW5pKCZyaW5nLT5zY2hlZCk7
Cj4+PiAtwqDCoMKgwqDCoMKgwqAgciA9IGFtZGdwdV9mZW5jZV93YWl0X2VtcHR5KHJpbmcpOwo+
Pj4gLcKgwqDCoMKgwqDCoMKgIGlmIChyKSB7Cj4+PiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAv
KiBubyBuZWVkIHRvIHRyaWdnZXIgR1BVIHJlc2V0IGFzIHdlIGFyZSB1bmxvYWRpbmcgKi8KPj4+
ICvCoMKgwqDCoMKgwqDCoCAvKiBZb3UgY2FuJ3Qgd2FpdCBmb3IgSFcgdG8gc2lnbmFsIGlmIGl0
J3MgZ29uZSAqLwo+Pj4gK8KgwqDCoMKgwqDCoMKgIGlmICghZHJtX2Rldl9pc191bnBsdWdnZWQo
JmFkZXYtPmRkZXYpKQo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgciA9IGFtZGdwdV9mZW5j
ZV93YWl0X2VtcHR5KHJpbmcpOwo+Pj4gK8KgwqDCoMKgwqDCoMKgIGVsc2UKPj4+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIHIgPSAtRU5PREVWOwo+Pj4gK8KgwqDCoMKgwqDCoMKgIC8qIG5vIG5l
ZWQgdG8gdHJpZ2dlciBHUFUgcmVzZXQgYXMgd2UgYXJlIHVubG9hZGluZyAqLwo+Pj4gK8KgwqDC
oMKgwqDCoMKgIGlmIChyKQo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYW1kZ3B1X2Zl
bmNlX2RyaXZlcl9mb3JjZV9jb21wbGV0aW9uKHJpbmcpOwo+Pj4gLcKgwqDCoMKgwqDCoMKgIH0K
Pj4+ICsKPj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAocmluZy0+ZmVuY2VfZHJ2LmlycV9zcmMp
Cj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBhbWRncHVfaXJxX3B1dChhZGV2LCByaW5n
LT5mZW5jZV9kcnYuaXJxX3NyYywKPj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCByaW5nLT5mZW5jZV9kcnYuaXJxX3R5cGUpOwo+Pj4KCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBs
aXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0
b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
