Return-Path: <SRS0=b/N7=3C=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57822C33CAD
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jan 2020 12:12:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BB6F207FD
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jan 2020 12:12:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MieMf47n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BB6F207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D3DD96E083;
	Mon, 13 Jan 2020 12:12:57 +0000 (UTC)
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 161066E083
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jan 2020 12:12:57 +0000 (UTC)
Received: by mail-wr1-x442.google.com with SMTP id c9so8303909wrw.8
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jan 2020 04:12:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=Wpjn5KcT/9Do72+9nQQOPrGmHRl/ThBu4g7im1/SV6Y=;
 b=MieMf47nC7kJhVhkqGovEBfs0mQWzTOfJexoE36/JV/78g+muybAGFXPeYWflhrkmg
 qibKbCAOVRxOjzV3T4541O+9d1zI2YF9udx6Zldv3r/+zwg139y1GQ90zmeKStBDOPQ8
 P2r3TdwVC0WF7StkNrMhxiuVuWr5NhmtdFOxNEjWZ1EHeRZR0qMcU3bH3vVGEVcjoVzM
 5HH4HSf9NFw0p5XrwR9zIrFkM0yrG4+Xhal6WK6jbALi6lwVUr0UsGvyL432GW1WSvKx
 Dx3f7yHTjkGecThlXMWcYQTpVQgBeebLgas78nEKftuTM/0FOwaHu0cUHrzoDo82/V5H
 2YSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=Wpjn5KcT/9Do72+9nQQOPrGmHRl/ThBu4g7im1/SV6Y=;
 b=ISTaIAs74a+EaiH00xgOF9IJSXOm5HRSu2HtHj7b+3LO0orCkb4Lwcsc3qB2CwH5hx
 9qRonQdmjqjqh4fiTogvweVGH52/57AiTnSMj2IMzjEIpLRKyk4xlieTgLNx9TG41lgx
 Ra+UbV8p3gt4O8MegDZWRLt2Q8UFti/c5pAysUB8XS9CbU3HfizCGBntWgaKNA2q5LJ9
 zAc+tVouM0HypdOjuuweAb4t3jolTWetQB78cQw2/Qwe62JC9ShGCE0B7DctHIBOcMFE
 hrHWlbwDqfS0NcA7svIfQt3R9ZQ5Y/mK0434TUOdKKgJYl9nESLXvCsoDvYHb7ZHjwYl
 7u1Q==
X-Gm-Message-State: APjAAAXo7TWC+LphteMWv1Gg18xaFCCrgB909fUEZc/B3kbD6JwoC+Re
 6A4msnAVT5YQEiD9HY0OTuMO5ABh
X-Google-Smtp-Source: APXvYqxu4lVtYbeAqDQMuTMxj6XtxYRKwj4ma4f2cB+3x7QStbdnylfyxvqhq6dWLLycjoCywvcE+Q==
X-Received: by 2002:adf:f311:: with SMTP id i17mr18188652wro.81.1578917575579; 
 Mon, 13 Jan 2020 04:12:55 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id u8sm14043611wmm.15.2020.01.13.04.12.54
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 13 Jan 2020 04:12:55 -0800 (PST)
Subject: Re: [PATCH 4/7] drm/amdgpu: replace kcq enable function on gfx_v9
To: Alex Sierra <alex.sierra@amd.com>, amd-gfx@lists.freedesktop.org
References: <20200111183938.126310-1-alex.sierra@amd.com>
 <20200111183938.126310-4-alex.sierra@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <40841ba1-d4e1-288e-5765-79136e59502d@gmail.com>
Date: Mon, 13 Jan 2020 13:12:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200111183938.126310-4-alex.sierra@amd.com>
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMTEuMDEuMjAgdW0gMTk6Mzkgc2NocmllYiBBbGV4IFNpZXJyYToKPiBbV2h5XQo+IFRoZXJl
J3MgYSBIVy1pbmRwZW5kZW50IGZ1bmN0aW9uIHRoYXQgZW5hYmxlcyBrY3EuIFRoaXMgZnVuY3Rp
b24gdXNlcwo+IHRoZSBraXFfcG00X2Z1bmNzIGltcGxlbWVudGF0aW9uLgo+Cj4gW0hvd10KPiBM
b2NhbCBrY3EgZW5hYmxlIGZ1bmN0aW9uIHJlbW92ZWQgYW5kIHJlcGxhY2UgaXQgYnkgdGhlIGdl
bmVyaWMga2NxCj4gZW5hYmxlIHVuZGVyIGFtZGdwdV9nZngKPgo+IENoYW5nZS1JZDogSTc3MDli
ZGJhOTM3NDJjMjM0OTQxYTU5MzZjODJlYjY3ZTM0NjA3N2MKPiBTaWduZWQtb2ZmLWJ5OiBBbGV4
IFNpZXJyYSA8YWxleC5zaWVycmFAYW1kLmNvbT4KCkFja2VkLWJ5OiBDaHJpc3RpYW4gS8O2bmln
IDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+Cgo+IC0tLQo+ICAgZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvZ2Z4X3Y5XzAuYyB8IDcwICstLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQo+ICAg
MSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCA2OSBkZWxldGlvbnMoLSkKPgo+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjlfMC5jIGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y5XzAuYwo+IGluZGV4IDViZTZmYWI1NWI3My4uNzIxOWVh
Y2FkOWNlIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92OV8w
LmMKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjlfMC5jCj4gQEAgLTMy
NTIsNzQgKzMyNTIsNiBAQCBzdGF0aWMgdm9pZCBnZnhfdjlfMF9raXFfc2V0dGluZyhzdHJ1Y3Qg
YW1kZ3B1X3JpbmcgKnJpbmcpCj4gICAJV1JFRzMyX1NPQzE1X1JMQyhHQywgMCwgbW1STENfQ1Bf
U0NIRURVTEVSUywgdG1wKTsKPiAgIH0KPiAgIAo+IC1zdGF0aWMgaW50IGdmeF92OV8wX2tpcV9r
Y3FfZW5hYmxlKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQo+IC17Cj4gLQlzdHJ1Y3QgYW1k
Z3B1X3JpbmcgKmtpcV9yaW5nID0gJmFkZXYtPmdmeC5raXEucmluZzsKPiAtCXVpbnQ2NF90IHF1
ZXVlX21hc2sgPSAwOwo+IC0JaW50IHIsIGk7Cj4gLQo+IC0JZm9yIChpID0gMDsgaSA8IEFNREdQ
VV9NQVhfQ09NUFVURV9RVUVVRVM7ICsraSkgewo+IC0JCWlmICghdGVzdF9iaXQoaSwgYWRldi0+
Z2Z4Lm1lYy5xdWV1ZV9iaXRtYXApKQo+IC0JCQljb250aW51ZTsKPiAtCj4gLQkJLyogVGhpcyBz
aXR1YXRpb24gbWF5IGJlIGhpdCBpbiB0aGUgZnV0dXJlIGlmIGEgbmV3IEhXCj4gLQkJICogZ2Vu
ZXJhdGlvbiBleHBvc2VzIG1vcmUgdGhhbiA2NCBxdWV1ZXMuIElmIHNvLCB0aGUKPiAtCQkgKiBk
ZWZpbml0aW9uIG9mIHF1ZXVlX21hc2sgbmVlZHMgdXBkYXRpbmcgKi8KPiAtCQlpZiAoV0FSTl9P
TihpID49IChzaXplb2YocXVldWVfbWFzaykqOCkpKSB7Cj4gLQkJCURSTV9FUlJPUigiSW52YWxp
ZCBLQ1EgZW5hYmxlZDogJWRcbiIsIGkpOwo+IC0JCQlicmVhazsKPiAtCQl9Cj4gLQo+IC0JCXF1
ZXVlX21hc2sgfD0gKDF1bGwgPDwgaSk7Cj4gLQl9Cj4gLQo+IC0JciA9IGFtZGdwdV9yaW5nX2Fs
bG9jKGtpcV9yaW5nLCAoNyAqIGFkZXYtPmdmeC5udW1fY29tcHV0ZV9yaW5ncykgKyA4KTsKPiAt
CWlmIChyKSB7Cj4gLQkJRFJNX0VSUk9SKCJGYWlsZWQgdG8gbG9jayBLSVEgKCVkKS5cbiIsIHIp
Owo+IC0JCXJldHVybiByOwo+IC0JfQo+IC0KPiAtCS8qIHNldCByZXNvdXJjZXMgKi8KPiAtCWFt
ZGdwdV9yaW5nX3dyaXRlKGtpcV9yaW5nLCBQQUNLRVQzKFBBQ0tFVDNfU0VUX1JFU09VUkNFUywg
NikpOwo+IC0JYW1kZ3B1X3Jpbmdfd3JpdGUoa2lxX3JpbmcsIFBBQ0tFVDNfU0VUX1JFU09VUkNF
U19WTUlEX01BU0soMCkgfAo+IC0JCQkgIFBBQ0tFVDNfU0VUX1JFU09VUkNFU19RVUVVRV9UWVBF
KDApKTsJLyogdm1pZF9tYXNrOjAgcXVldWVfdHlwZTowIChLSVEpICovCj4gLQlhbWRncHVfcmlu
Z193cml0ZShraXFfcmluZywgbG93ZXJfMzJfYml0cyhxdWV1ZV9tYXNrKSk7CS8qIHF1ZXVlIG1h
c2sgbG8gKi8KPiAtCWFtZGdwdV9yaW5nX3dyaXRlKGtpcV9yaW5nLCB1cHBlcl8zMl9iaXRzKHF1
ZXVlX21hc2spKTsJLyogcXVldWUgbWFzayBoaSAqLwo+IC0JYW1kZ3B1X3Jpbmdfd3JpdGUoa2lx
X3JpbmcsIDApOwkvKiBnd3MgbWFzayBsbyAqLwo+IC0JYW1kZ3B1X3Jpbmdfd3JpdGUoa2lxX3Jp
bmcsIDApOwkvKiBnd3MgbWFzayBoaSAqLwo+IC0JYW1kZ3B1X3Jpbmdfd3JpdGUoa2lxX3Jpbmcs
IDApOwkvKiBvYWMgbWFzayAqLwo+IC0JYW1kZ3B1X3Jpbmdfd3JpdGUoa2lxX3JpbmcsIDApOwkv
KiBnZHMgaGVhcCBiYXNlOjAsIGdkcyBoZWFwIHNpemU6MCAqLwo+IC0JZm9yIChpID0gMDsgaSA8
IGFkZXYtPmdmeC5udW1fY29tcHV0ZV9yaW5nczsgaSsrKSB7Cj4gLQkJc3RydWN0IGFtZGdwdV9y
aW5nICpyaW5nID0gJmFkZXYtPmdmeC5jb21wdXRlX3JpbmdbaV07Cj4gLQkJdWludDY0X3QgbXFk
X2FkZHIgPSBhbWRncHVfYm9fZ3B1X29mZnNldChyaW5nLT5tcWRfb2JqKTsKPiAtCQl1aW50NjRf
dCB3cHRyX2FkZHIgPSBhZGV2LT53Yi5ncHVfYWRkciArIChyaW5nLT53cHRyX29mZnMgKiA0KTsK
PiAtCj4gLQkJYW1kZ3B1X3Jpbmdfd3JpdGUoa2lxX3JpbmcsIFBBQ0tFVDMoUEFDS0VUM19NQVBf
UVVFVUVTLCA1KSk7Cj4gLQkJLyogUV9zZWw6MCwgdm1pZDowLCB2aWRtZW06IDEsIGVuZ2luZTow
LCBudW1fUToxKi8KPiAtCQlhbWRncHVfcmluZ193cml0ZShraXFfcmluZywgLyogUV9zZWw6IDAs
IHZtaWQ6IDAsIGVuZ2luZTogMCwgbnVtX1E6IDEgKi8KPiAtCQkJCSAgUEFDS0VUM19NQVBfUVVF
VUVTX1FVRVVFX1NFTCgwKSB8IC8qIFF1ZXVlX1NlbCAqLwo+IC0JCQkJICBQQUNLRVQzX01BUF9R
VUVVRVNfVk1JRCgwKSB8IC8qIFZNSUQgKi8KPiAtCQkJCSAgUEFDS0VUM19NQVBfUVVFVUVTX1FV
RVVFKHJpbmctPnF1ZXVlKSB8Cj4gLQkJCQkgIFBBQ0tFVDNfTUFQX1FVRVVFU19QSVBFKHJpbmct
PnBpcGUpIHwKPiAtCQkJCSAgUEFDS0VUM19NQVBfUVVFVUVTX01FKChyaW5nLT5tZSA9PSAxID8g
MCA6IDEpKSB8Cj4gLQkJCQkgIFBBQ0tFVDNfTUFQX1FVRVVFU19RVUVVRV9UWVBFKDApIHwgLypx
dWV1ZV90eXBlOiBub3JtYWwgY29tcHV0ZSBxdWV1ZSAqLwo+IC0JCQkJICBQQUNLRVQzX01BUF9R
VUVVRVNfQUxMT0NfRk9STUFUKDApIHwgLyogYWxsb2MgZm9ybWF0OiBhbGxfb25fb25lX3BpcGUg
Ki8KPiAtCQkJCSAgUEFDS0VUM19NQVBfUVVFVUVTX0VOR0lORV9TRUwoMCkgfCAvKiBlbmdpbmVf
c2VsOiBjb21wdXRlICovCj4gLQkJCQkgIFBBQ0tFVDNfTUFQX1FVRVVFU19OVU1fUVVFVUVTKDEp
KTsgLyogbnVtX3F1ZXVlczogbXVzdCBiZSAxICovCj4gLQkJYW1kZ3B1X3Jpbmdfd3JpdGUoa2lx
X3JpbmcsIFBBQ0tFVDNfTUFQX1FVRVVFU19ET09SQkVMTF9PRkZTRVQocmluZy0+ZG9vcmJlbGxf
aW5kZXgpKTsKPiAtCQlhbWRncHVfcmluZ193cml0ZShraXFfcmluZywgbG93ZXJfMzJfYml0cyht
cWRfYWRkcikpOwo+IC0JCWFtZGdwdV9yaW5nX3dyaXRlKGtpcV9yaW5nLCB1cHBlcl8zMl9iaXRz
KG1xZF9hZGRyKSk7Cj4gLQkJYW1kZ3B1X3Jpbmdfd3JpdGUoa2lxX3JpbmcsIGxvd2VyXzMyX2Jp
dHMod3B0cl9hZGRyKSk7Cj4gLQkJYW1kZ3B1X3Jpbmdfd3JpdGUoa2lxX3JpbmcsIHVwcGVyXzMy
X2JpdHMod3B0cl9hZGRyKSk7Cj4gLQl9Cj4gLQo+IC0JciA9IGFtZGdwdV9yaW5nX3Rlc3RfaGVs
cGVyKGtpcV9yaW5nKTsKPiAtCWlmIChyKQo+IC0JCURSTV9FUlJPUigiS0NRIGVuYWJsZSBmYWls
ZWRcbiIpOwo+IC0KPiAtCXJldHVybiByOwo+IC19Cj4gLQo+ICAgc3RhdGljIGludCBnZnhfdjlf
MF9tcWRfaW5pdChzdHJ1Y3QgYW1kZ3B1X3JpbmcgKnJpbmcpCj4gICB7Cj4gICAJc3RydWN0IGFt
ZGdwdV9kZXZpY2UgKmFkZXYgPSByaW5nLT5hZGV2Owo+IEBAIC0zNzI2LDcgKzM2NTgsNyBAQCBz
dGF0aWMgaW50IGdmeF92OV8wX2tjcV9yZXN1bWUoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYp
Cj4gICAJCQlnb3RvIGRvbmU7Cj4gICAJfQo+ICAgCj4gLQlyID0gZ2Z4X3Y5XzBfa2lxX2tjcV9l
bmFibGUoYWRldik7Cj4gKwlyID0gYW1kZ3B1X2dmeF9lbmFibGVfa2NxKGFkZXYpOwo+ICAgZG9u
ZToKPiAgIAlyZXR1cm4gcjsKPiAgIH0KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRl
c2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8v
YW1kLWdmeAo=
