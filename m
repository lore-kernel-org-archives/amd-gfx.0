Return-Path: <SRS0=YjM5=4P=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39039C11D3D
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Feb 2020 15:29:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09B402469F
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Feb 2020 15:29:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g5uJTwid"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09B402469F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC6876E045;
	Thu, 27 Feb 2020 15:29:01 +0000 (UTC)
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20::343])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E4426E045
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Feb 2020 15:29:00 +0000 (UTC)
Received: by mail-wm1-x343.google.com with SMTP id a9so3937620wmj.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Feb 2020 07:29:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=iF2h1LG+EFZ8BiHcH/ixFWaE+GGPfuVZsPYgamUz+9U=;
 b=g5uJTwidUK1N3MLuOFxNPrW3fFy9ptUsx5rY4pb8Ps9pZa64yEFqzKew8U5/vnlmwh
 0QUF5EvvUVpkgJGiWE/wbXcSQ6ig78r8UBXDmjL29m3LCCU+sNiFA3LmdBL/Pchw/JzO
 inQtBLGSGM9eKhpCljDYd+KzAQF4ZCEkrdCLaH6jdr+qhJYHLzONtcT8URTGekC/ZMTw
 B05pYMc95CsqtBOIodWlxU+WofG2o4n0EbUU3UYG/7KofYGABq8htQnZb1vrQw+JXX4A
 Vovm60lG8DLYhcZ/Pb3/kpxi86wiJ6AxEGC1SiKBY4vlncvYBBFbJ0QBoSTzB9ZvYV+n
 bVFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=iF2h1LG+EFZ8BiHcH/ixFWaE+GGPfuVZsPYgamUz+9U=;
 b=rTK4yf56/FkZ/QQfBlsYuIg87GTaWbaPWf8Se69pRlxtWTznpRMN4QzCgnoHiKgKHG
 mOR0BInOyGQYmahsSRp58ZHqYCyIiEg86H9fPz5W9aLAyCOwuOnLPxmwl8f18BiJuv3B
 4Vpj+3RrzzSEuVmOP9Kcc1euwAUCVdY8bmQNp/V1mPsGcTRYyoqEm5s8TkPffxdfCUpE
 DnetdRykYu1MG5HhDVnEnRiP/qngzofYyxc4dPDpbA0iDTu4HkXIy4w3WzI9ca9zXobo
 EJ1M/1z6Z6hjyNEOoBrAC1s5bpWRxJWmKfGu97ORpOBZMtKJufTlRYYUyIOj8zM+qwve
 e/5w==
X-Gm-Message-State: APjAAAXHSWmbBifPuZAzVNck8AadU6Uk3jKxMOdFcTd/y4IBGaxi+h4B
 I+TJYs5mbsEXb3M5HMHfVF746sLc
X-Google-Smtp-Source: APXvYqwQ5QY1XUXg7xXXJLAvju3SFOrD3L6x0rlroBRZMXW8psd8Xnutfge3gGr3BoD9HQ7/janBkg==
X-Received: by 2002:a1c:2b44:: with SMTP id r65mr80553wmr.72.1582817338609;
 Thu, 27 Feb 2020 07:28:58 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id a5sm8133114wmb.37.2020.02.27.07.28.56
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 27 Feb 2020 07:28:58 -0800 (PST)
Subject: Re: [PATCH] drm/amdgpu: stop allocating PDs/PTs with the eviction
 lock held
To: Felix Kuehling <felix.kuehling@amd.com>, alex.sierra@amd.com,
 amd-gfx@lists.freedesktop.org
References: <20200212151426.14197-1-christian.koenig@amd.com>
 <7f0c6e3e-be75-3fa8-a5e7-d8ae6bf0dba5@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <eaf782de-e45d-70df-9211-69a96f8ccd80@gmail.com>
Date: Thu, 27 Feb 2020 16:28:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <7f0c6e3e-be75-3fa8-a5e7-d8ae6bf0dba5@amd.com>
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

SGkgRmVsaXgsCgpzbyBjb21pbmcgYmFjayB0byB0aGlzIGFmdGVyIHR3byB3ZWVrcyBvZiBkaXN0
cmFjdGlvbi4KCkFtIDE0LjAyLjIwIHVtIDIyOjEyIHNjaHJpZWIgRmVsaXggS3VlaGxpbmc6Cj4g
Tm93IHlvdSBhbGxvdyBldmljdGlvbiBvZiBwYWdlIHRhYmxlcyB3aGlsZSB5b3UgYWxsb2NhdGUg
cGFnZSB0YWJsZXMuIAo+IElzbid0IHRoZSB3aG9sZSBwb2ludCBvZiB0aGUgZXZpY3Rpb24gbG9j
ayB0byBwcmV2ZW50IHBhZ2UgdGFibGUgCj4gZXZpY3Rpb25zIHdoaWxlIG1hbmlwdWxhdGluZyBw
YWdlIHRhYmxlcz8KPgo+IE9yIGRvZXMgdGhpcyBvbmx5IGFwcGx5IHRvIFBURSBpbnZhbGlkYXRp
b25zIHdoaWNoIG5ldmVyIGFsbG9jYXRlZCAKPiBtZW1vcnk/IElzIHRoYXQgdGhlIG9ubHkgY2Fz
ZSB0aGF0IGRvZXNuJ3QgcmVzZXJ2ZSBwYWdlIHRhYmxlcz8KClllcywgZXhhY3RseS4gV2UgZXNz
ZW50aWFsbHkgaGF2ZSB0byBkaXN0aW5jdCB0d28gY2FzZXMgaGVyZToKCjEuIFdlIGFyZSB2YWxp
ZGF0aW5nIFBURXMgYW5kIHNvIGV2ZW50dWFsbHkgbmVlZCB0byBhbGxvY2F0ZSBwYWdlIHRhYmxl
cy4KIMKgwqDCoCBGb3IgdGhpcyB0aGUgcm9vdCBQRCBpcyByZXNlcnZlZCBhbmQgd2UgYWN0dWFs
bHkga25vdyB0aGF0IHRoZSBWTSAKY2FuJ3QgYmUgZXZpY3RlZC4KIMKgwqDCoCBCdXQgd2Ugc3Rp
bGwgbmVlZCB0byBob2xkIHRoZSBsb2NrIHdoaWxlIHB1c2hpbmcgdGhlIGFjdHVhbCB1cGRhdGVz
IAp0aGUgaGFyZHdhcmUgdG8gbWFrZSBzdXJlIHdlIGRvbid0IG1lc3MgdXAgdGhlIGRhdGEgc3Ry
dWN0dXJlcyB3aXRoIApjb25jdXJyZW50IGludmFsaWRhdGlvbnMuCgoyLiBXZSBhcmUgaW52YWxp
ZGF0aW5nIFBURXMuCiDCoMKgwqAgSGVyZSB3ZSBtaWdodCBvciBtaWdodCBub3QgaGF2ZSB0aGUg
cm9vdCBQRCByZXNlcnZlZCBhbmQgc28gbmVlZCB0byAKbWFrZSBzdXJlIHRoYXQgbm9ib2R5IGlz
IGV2aWN0aW5nIHBhZ2UgdGFibGVzIHdoaWxlIHdlIGFyZSBpbnZhbGlkYXRpbmcuCgpRdWl0ZSBh
IGNvbXBsaWNhdGVkIGRhbmNlLCBidXQgb2YgaGFuZCBJIGFsc28gZG9uJ3Qgc2VlIG11Y2ggb3Ro
ZXIgY2hvaWNlLgoKUmVnYXJkcywKQ2hyaXN0aWFuLgoKPgo+IFJlZ2FyZHMsCj4gwqAgRmVsaXgK
Pgo+IE9uIDIwMjAtMDItMTIgMTA6MTQgYS5tLiwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToKPj4g
V2UgbmVlZCB0byBtYWtlIHN1cmUgdG8gbm90IGFsbG9jYXRlIFBEcy9QVHMgd2hpbGUgaG9sZGlu
Zwo+PiB0aGUgZXZpY3Rpb24gbG9jayBvciBvdGhlcndpc2Ugd2Ugd2lsbCBydW4gaW50byBsb2Nr
IGludmVyc2lvbgo+PiBpbiB0aGUgTU0gYXMgc29vbiBhcyB3ZSBlbmFibGUgdGhlIE1NVSBub3Rp
Zmllci4KPj4KPj4gU2lnbmVkLW9mZi1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtv
ZW5pZ0BhbWQuY29tPgo+PiAtLS0KPj4gwqAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X3ZtLmMgfCAzMSArKysrKysrKysrKysrKysrKysrKystLS0tLQo+PiDCoCAxIGZpbGUgY2hh
bmdlZCwgMjUgaW5zZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMoLSkKPj4KPj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jIAo+PiBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jCj4+IGluZGV4IDc3YzQwMDY3NWI3OS4uZTdhYjBj
MWUyNzkzIDEwMDY0NAo+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
dm0uYwo+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYwo+PiBA
QCAtODk3LDI3ICs4OTcsNDIgQEAgc3RhdGljIGludCBhbWRncHVfdm1fYWxsb2NfcHRzKHN0cnVj
dCAKPj4gYW1kZ3B1X2RldmljZSAqYWRldiwKPj4gwqDCoMKgwqDCoCBzdHJ1Y3QgYW1kZ3B1X3Zt
X3B0ICplbnRyeSA9IGN1cnNvci0+ZW50cnk7Cj4+IMKgwqDCoMKgwqAgc3RydWN0IGFtZGdwdV9i
b19wYXJhbSBicDsKPj4gwqDCoMKgwqDCoCBzdHJ1Y3QgYW1kZ3B1X2JvICpwdDsKPj4gK8KgwqDC
oCBib29sIG5lZWRfZW50cmllczsKPj4gwqDCoMKgwqDCoCBpbnQgcjsKPj4gwqAgLcKgwqDCoCBp
ZiAoY3Vyc29yLT5sZXZlbCA8IEFNREdQVV9WTV9QVEIgJiYgIWVudHJ5LT5lbnRyaWVzKSB7Cj4+
ICvCoMKgwqAgbmVlZF9lbnRyaWVzID0gY3Vyc29yLT5sZXZlbCA8IEFNREdQVV9WTV9QVEIgJiYg
IWVudHJ5LT5lbnRyaWVzOwo+PiArwqDCoMKgIGlmICghbmVlZF9lbnRyaWVzICYmIGVudHJ5LT5i
YXNlLmJvKQo+PiArwqDCoMKgwqDCoMKgwqAgcmV0dXJuIDA7Cj4+ICsKPj4gK8KgwqDCoCAvKiBX
ZSBuZWVkIHRvIG1ha2Ugc3VyZSB0aGF0IHdlIGRvbid0IGFsbG9jYXRlIFBEcy9QVHMgd2hpbGUg
Cj4+IGhvbGRpbmcgdGhlCj4+ICvCoMKgwqDCoCAqIGV2aWN0aW9uIGxvY2sgb3Igd2UgcnVuIGlu
dG8gbG9jayByZWN1cnNpb24gaW4gdGhlIE1NLgo+PiArwqDCoMKgwqAgKi8KPj4gK8KgwqDCoCBh
bWRncHVfdm1fZXZpY3Rpb25fdW5sb2NrKHZtKTsKPj4gKwo+PiArwqDCoMKgIGlmIChuZWVkX2Vu
dHJpZXMpIHsKPj4gwqDCoMKgwqDCoMKgwqDCoMKgIHVuc2lnbmVkIG51bV9lbnRyaWVzOwo+PiDC
oCDCoMKgwqDCoMKgwqDCoMKgwqAgbnVtX2VudHJpZXMgPSBhbWRncHVfdm1fbnVtX2VudHJpZXMo
YWRldiwgY3Vyc29yLT5sZXZlbCk7Cj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBlbnRyeS0+ZW50cmll
cyA9IGt2bWFsbG9jX2FycmF5KG51bV9lbnRyaWVzLAo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzaXplb2YoKmVudHJ5LT5lbnRyaWVzKSwKPj4g
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgR0ZQX0tF
Uk5FTCB8IF9fR0ZQX1pFUk8pOwo+PiAtwqDCoMKgwqDCoMKgwqAgaWYgKCFlbnRyeS0+ZW50cmll
cykKPj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIC1FTk9NRU07Cj4+ICvCoMKgwqDC
oMKgwqDCoCBpZiAoIWVudHJ5LT5lbnRyaWVzKSB7Cj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IHIgPSAtRU5PTUVNOwo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBnb3RvIGVycm9yX2xvY2s7
Cj4+ICvCoMKgwqDCoMKgwqDCoCB9Cj4+IMKgwqDCoMKgwqAgfQo+PiDCoCAtwqDCoMKgIGlmIChl
bnRyeS0+YmFzZS5ibykKPj4gLcKgwqDCoMKgwqDCoMKgIHJldHVybiAwOwo+PiArwqDCoMKgIGlm
IChlbnRyeS0+YmFzZS5ibykgewo+PiArwqDCoMKgwqDCoMKgwqAgciA9IDA7Cj4+ICvCoMKgwqDC
oMKgwqDCoCBnb3RvIGVycm9yX2xvY2s7Cj4+ICvCoMKgwqAgfQo+PiDCoCDCoMKgwqDCoMKgIGFt
ZGdwdV92bV9ib19wYXJhbShhZGV2LCB2bSwgY3Vyc29yLT5sZXZlbCwgZGlyZWN0LCAmYnApOwo+
PiDCoCDCoMKgwqDCoMKgIHIgPSBhbWRncHVfYm9fY3JlYXRlKGFkZXYsICZicCwgJnB0KTsKPj4g
K8KgwqDCoCBhbWRncHVfdm1fZXZpY3Rpb25fbG9jayh2bSk7Cj4+IMKgwqDCoMKgwqAgaWYgKHIp
Cj4+IC3CoMKgwqDCoMKgwqDCoCByZXR1cm4gcjsKPj4gK8KgwqDCoMKgwqDCoMKgIGdvdG8gZXJy
b3JfZnJlZV9wdDsKPj4gwqAgwqDCoMKgwqDCoCAvKiBLZWVwIGEgcmVmZXJlbmNlIHRvIHRoZSBy
b290IGRpcmVjdG9yeSB0byBhdm9pZAo+PiDCoMKgwqDCoMKgwqAgKiBmcmVlaW5nIHRoZW0gdXAg
aW4gdGhlIHdyb25nIG9yZGVyLgo+PiBAQCAtOTM2LDYgKzk1MSwxMCBAQCBzdGF0aWMgaW50IGFt
ZGdwdV92bV9hbGxvY19wdHMoc3RydWN0IAo+PiBhbWRncHVfZGV2aWNlICphZGV2LAo+PiDCoMKg
wqDCoMKgIGFtZGdwdV9ib191bnJlZigmcHQpOwo+PiDCoMKgwqDCoMKgIGVudHJ5LT5iYXNlLmJv
ID0gTlVMTDsKPj4gwqDCoMKgwqDCoCByZXR1cm4gcjsKPj4gKwo+PiArZXJyb3JfbG9jazoKPj4g
K8KgwqDCoCBhbWRncHVfdm1fZXZpY3Rpb25fbG9jayh2bSk7Cj4+ICvCoMKgwqAgcmV0dXJuIHI7
Cj4+IMKgIH0KPj4gwqAgwqAgLyoqCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNr
dG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Ft
ZC1nZngK
