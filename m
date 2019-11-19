Return-Path: <SRS0=44+a=ZL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37DA0C432C0
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Nov 2019 09:53:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1726520857
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Nov 2019 09:53:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1726520857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F5836F480;
	Tue, 19 Nov 2019 09:53:57 +0000 (UTC)
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20::343])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B4816F47D
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Nov 2019 09:53:55 +0000 (UTC)
Received: by mail-wm1-x343.google.com with SMTP id 8so2760817wmo.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Nov 2019 01:53:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=S9eyyXC7SdZ4HrsQQ3QmoPzRkZhzCv+qcy1dQ8ZAci8=;
 b=f2QJ2+PlIMq5K49MVdvQD25r7rXIu7YTagVwdnz2NPU+6qkjmIc97Me7kx9ZUGEtIY
 wIp/piUvATSeyOlWtalR6mX15xf2+ifY7wRzZLPdYczvbUGmhsRB2JiINSARmruIGIJK
 LNtTSU0NgOrMAT6QtxnsnRN1HVNCcC3/qBZEVBM+XboTmO5gRxL8zU0NadAOZXCUokox
 s4M+TYv3ojW+s4cSC4HqD6PeUr+mYxiO1Yxgi8CPDT/qMj5/csQdfNB6j994s9K24q//
 oTHhwBh9Emk3b1NZ3HKwuKIOTKnosf9CAq/ZeeCARYtcxcGcGdUQozkuQmxZPdeTVm4x
 TCyQ==
X-Gm-Message-State: APjAAAXAimOFVtUvPuu8msHFo0iuy4qbiKMUQstyxegKKvWhiYcAoJ20
 T/Ik9s0jEe++TekEmwNhXYL+5ubl
X-Google-Smtp-Source: APXvYqwXz4e1ktKNUEvwT4MdVhJjIydD6LAEV37/MTVoR1z0u3DsGQogXik2PsI8ARkETwutdkTOlw==
X-Received: by 2002:a1c:dd45:: with SMTP id u66mr4363744wmg.12.1574157234000; 
 Tue, 19 Nov 2019 01:53:54 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id j2sm26825887wrt.61.2019.11.19.01.53.52
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 19 Nov 2019 01:53:53 -0800 (PST)
Subject: Re: [PATCH 2/3] drm/amdgpu: invalidate semphore workaround in
 amdgpu_virt
To: "Changfeng.Zhu" <changfeng.zhu@amd.com>, Christian.Koenig@amd.com,
 Jack.Xiao@amd.com, Tao.Zhou1@amd.com, Ray.Huang@amd.com,
 Xinmei.Huang@amd.com, amd-gfx@lists.freedesktop.org
References: <20191119091247.4596-1-changfeng.zhu@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <b6f82599-cf5e-48f7-e295-10b5fcb8a8c9@gmail.com>
Date: Tue, 19 Nov 2019 10:53:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191119091247.4596-1-changfeng.zhu@amd.com>
Content-Language: en-US
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20161025;
 h=reply-to:subject:to:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=S9eyyXC7SdZ4HrsQQ3QmoPzRkZhzCv+qcy1dQ8ZAci8=;
 b=OCJP9EqWrB2id7jGQmtlFO4Olafg7Cp+ujqx2fdaBPclBbalTE5K0dWOfirCLjJw+O
 pAp89Bers2tUdyXku07MkRhoPcON4ImxKDUKczxPIaSIYhgw/Ykjw0/0fICLwBfWgxJw
 KvzxabtPlVyfAYYS45xLL7taF26P5M7yma90d9XSNreM9cuMdNMhuBKcWVyKn4ZYxy2m
 OPE961xJUYnEKlbrAjlp808INaS2FoXMuL89Wkhiw9UogllMQ/S5aKtZvhv8lT8+/Oe+
 cXK1tpD8Lb5F06Qsd9foAWzIZbP0SqXL+1EcHGC2aBB6VLj1iq7C9LzA+KQaOwg4a301
 8Zxg==
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.23
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
Message-ID: <20191119095352.59WPAZvtywXkE72336WqnJk6nHq8gDcxzvdiisaCLB8@z>

QW0gMTkuMTEuMTkgdW0gMTA6MTIgc2NocmllYiBDaGFuZ2ZlbmcuWmh1Ogo+IEZyb206IGNoYW5n
emh1IDxDaGFuZ2ZlbmcuWmh1QGFtZC5jb20+Cj4KPiBJdCBtYXkgbG9zZSBncHV2bSBpbnZhbGlk
YXRlIGFja25vd2xkZWdlIHN0YXRlIGFjcm9zcyBwb3dlci1nYXRpbmcgb2ZmCj4gY3ljbGUuIFRv
IGF2b2lkIHRoaXMgaXNzdWUgaW4gdmlydCBpbnZhbGlkYXRpb24sIGFkZCBzZW1hcGhvcmUgYWNx
dWlyZQo+IGJlZm9yZSBpbnZhbGlkYXRpb24gYW5kIHNlbWFwaG9yZSByZWxlYXNlIGFmdGVyIGlu
dmFsaWRhdGlvbi4KPgo+IENoYW5nZS1JZDogSWU5ODMwNGU0NzUxNjZiNTNlZWQwMzM0NjJkNzY0
MjNiNmIwZmMyNWIKPiBTaWduZWQtb2ZmLWJ5OiBjaGFuZ3podSA8Q2hhbmdmZW5nLlpodUBhbWQu
Y29tPgoKU3RpbGwgbmVlZHMgbW9yZSBjbGVhbnVwLCBidXQgZm9yIG5vdyB0aGF0IHBhdGNoIGlz
IFJldmlld2VkLWJ5OiAKQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29t
PgoKPiAtLS0KPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92aXJ0LmMgfCAy
MiArKysrKysrKysrKysrKysrKysrKy0tCj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfdmlydC5oIHwgIDMgKystCj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nbWNf
djlfMC5jICAgIHwgIDMgKystCj4gICAzIGZpbGVzIGNoYW5nZWQsIDI0IGluc2VydGlvbnMoKyks
IDQgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X3ZpcnQuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92aXJ0
LmMKPiBpbmRleCBmMDRlYjFhNjQyNzEuLmVlNTc2MTU4NTQ1ZSAxMDA2NDQKPiAtLS0gYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdmlydC5jCj4gKysrIGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZpcnQuYwo+IEBAIC0xMzUsNyArMTM1LDggQEAgdm9pZCBh
bWRncHVfdmlydF9raXFfd3JlZyhzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwgdWludDMyX3Qg
cmVnLCB1aW50MzJfdCB2KQo+ICAgCj4gICB2b2lkIGFtZGdwdV92aXJ0X2tpcV9yZWdfd3JpdGVf
cmVnX3dhaXQoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsCj4gICAJCQkJCXVpbnQzMl90IHJl
ZzAsIHVpbnQzMl90IHJlZzEsCj4gLQkJCQkJdWludDMyX3QgcmVmLCB1aW50MzJfdCBtYXNrKQo+
ICsJCQkJCXVpbnQzMl90IHJlZiwgdWludDMyX3QgbWFzaywKPiArCQkJCQl1aW50MzJfdCBzZW0p
Cj4gICB7Cj4gICAJc3RydWN0IGFtZGdwdV9raXEgKmtpcSA9ICZhZGV2LT5nZngua2lxOwo+ICAg
CXN0cnVjdCBhbWRncHVfcmluZyAqcmluZyA9ICZraXEtPnJpbmc7Cj4gQEAgLTE0NCw5ICsxNDUs
MjYgQEAgdm9pZCBhbWRncHVfdmlydF9raXFfcmVnX3dyaXRlX3JlZ193YWl0KHN0cnVjdCBhbWRn
cHVfZGV2aWNlICphZGV2LAo+ICAgCXVpbnQzMl90IHNlcTsKPiAgIAo+ICAgCXNwaW5fbG9ja19p
cnFzYXZlKCZraXEtPnJpbmdfbG9jaywgZmxhZ3MpOwo+IC0JYW1kZ3B1X3JpbmdfYWxsb2Mocmlu
ZywgMzIpOwo+ICsJYW1kZ3B1X3JpbmdfYWxsb2MocmluZywgNjApOwo+ICsKPiArCS8qCj4gKwkg
KiBJdCBtYXkgbG9zZSBncHV2bSBpbnZhbGlkYXRlIGFja25vd2xkZWdlIHN0YXRlIGFjcm9zcyBw
b3dlci1nYXRpbmcKPiArCSAqIG9mZiBjeWNsZSwgYWRkIHNlbWFwaG9yZSBhY3F1aXJlIGJlZm9y
ZSBpbnZhbGlkYXRpb24gYW5kIHNlbWFwaG9yZQo+ICsJICogcmVsZWFzZSBhZnRlciBpbnZhbGlk
YXRpb24gdG8gYXZvaWQgZW50ZXJpbmcgcG93ZXIgZ2F0ZWQgc3RhdGUKPiArCSAqIHRvIFdBIHRo
ZSBJc3N1ZQo+ICsJICovCj4gKwo+ICsJLyogYSByZWFkIHJldHVybiB2YWx1ZSBvZiAxIG1lYW5z
IHNlbWFwaG9yZSBhY3VxaXJlICovCj4gKwlhbWRncHVfcmluZ19lbWl0X3JlZ193YWl0KHJpbmcs
IHNlbSwgMHgxLCAweDEpOwo+ICsKPiAgIAlhbWRncHVfcmluZ19lbWl0X3JlZ193cml0ZV9yZWdf
d2FpdChyaW5nLCByZWcwLCByZWcxLAo+ICAgCQkJCQkgICAgcmVmLCBtYXNrKTsKPiArCS8qCj4g
KwkgKiBhZGQgc2VtYXBob3JlIHJlbGVhc2UgYWZ0ZXIgaW52YWxpZGF0aW9uLAo+ICsJICogd3Jp
dGUgd2l0aCAwIG1lYW5zIHNlbWFwaG9yZSByZWxlYXNlCj4gKwkgKi8KPiArCWFtZGdwdV9yaW5n
X2VtaXRfd3JlZyhyaW5nLCBzZW0sIDApOwo+ICsKPiAgIAlhbWRncHVfZmVuY2VfZW1pdF9wb2xs
aW5nKHJpbmcsICZzZXEpOwo+ICAgCWFtZGdwdV9yaW5nX2NvbW1pdChyaW5nKTsKPiAgIAlzcGlu
X3VubG9ja19pcnFyZXN0b3JlKCZraXEtPnJpbmdfbG9jaywgZmxhZ3MpOwo+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdmlydC5oIGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZpcnQuaAo+IGluZGV4IGIwYjJiZGM3NTBkZi4uYmRhNmEy
ZjM3ZGMwIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92
aXJ0LmgKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdmlydC5oCj4g
QEAgLTI5NSw3ICsyOTUsOCBAQCB1aW50MzJfdCBhbWRncHVfdmlydF9raXFfcnJlZyhzdHJ1Y3Qg
YW1kZ3B1X2RldmljZSAqYWRldiwgdWludDMyX3QgcmVnKTsKPiAgIHZvaWQgYW1kZ3B1X3ZpcnRf
a2lxX3dyZWcoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsIHVpbnQzMl90IHJlZywgdWludDMy
X3Qgdik7Cj4gICB2b2lkIGFtZGdwdV92aXJ0X2tpcV9yZWdfd3JpdGVfcmVnX3dhaXQoc3RydWN0
IGFtZGdwdV9kZXZpY2UgKmFkZXYsCj4gICAJCQkJCXVpbnQzMl90IHJlZzAsIHVpbnQzMl90IHJy
ZWcxLAo+IC0JCQkJCXVpbnQzMl90IHJlZiwgdWludDMyX3QgbWFzayk7Cj4gKwkJCQkJdWludDMy
X3QgcmVmLCB1aW50MzJfdCBtYXNrLAo+ICsJCQkJCXVpbnQzMl90IHNlbSk7Cj4gICBpbnQgYW1k
Z3B1X3ZpcnRfcmVxdWVzdF9mdWxsX2dwdShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwgYm9v
bCBpbml0KTsKPiAgIGludCBhbWRncHVfdmlydF9yZWxlYXNlX2Z1bGxfZ3B1KHN0cnVjdCBhbWRn
cHVfZGV2aWNlICphZGV2LCBib29sIGluaXQpOwo+ICAgaW50IGFtZGdwdV92aXJ0X3Jlc2V0X2dw
dShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldik7Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2dtY192OV8wLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9n
bWNfdjlfMC5jCj4gaW5kZXggZjI1Y2Q5N2JhNWYyLi4xYWU1OWFmNzgzNmEgMTAwNjQ0Cj4gLS0t
IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ21jX3Y5XzAuYwo+ICsrKyBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2dtY192OV8wLmMKPiBAQCAtNDQ4LDkgKzQ0OCwxMCBAQCBzdGF0
aWMgdm9pZCBnbWNfdjlfMF9mbHVzaF9ncHVfdGxiKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2
LCB1aW50MzJfdCB2bWlkLAo+ICAgCQkJIWFkZXYtPmluX2dwdV9yZXNldCkgewo+ICAgCQl1aW50
MzJfdCByZXEgPSBodWItPnZtX2ludl9lbmcwX3JlcSArIGVuZzsKPiAgIAkJdWludDMyX3QgYWNr
ID0gaHViLT52bV9pbnZfZW5nMF9hY2sgKyBlbmc7Cj4gKwkJdWludDMyX3Qgc2VtID0gaHViLT52
bV9pbnZfZW5nMF9zZW0gKyBlbmc7Cj4gICAKPiAgIAkJYW1kZ3B1X3ZpcnRfa2lxX3JlZ193cml0
ZV9yZWdfd2FpdChhZGV2LCByZXEsIGFjaywgdG1wLAo+IC0JCQkJMSA8PCB2bWlkKTsKPiArCQkJ
CQkJICAgMSA8PCB2bWlkLCBzZW0pOwo+ICAgCQlyZXR1cm47Cj4gICAJfQo+ICAgCgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcg
bGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNr
dG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
