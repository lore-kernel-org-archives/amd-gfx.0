Return-Path: <SRS0=CFk9=K2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D07DAC47080
	for <amd-gfx@archiver.kernel.org>; Mon, 31 May 2021 19:40:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FF8661260
	for <amd-gfx@archiver.kernel.org>; Mon, 31 May 2021 19:40:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FF8661260
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4DD5A6E05F;
	Mon, 31 May 2021 19:40:56 +0000 (UTC)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE9526E05F
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 May 2021 19:40:54 +0000 (UTC)
Received: by mail-ej1-x630.google.com with SMTP id jt22so18154437ejb.7
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 May 2021 12:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-transfer-encoding:content-language;
 bh=gA5k1AngqWRSBHRtkyQ8wIganBssCjHUIX0BmzOlL6g=;
 b=bsHOPelLOy8FGEZZGcVMikQZmPbTmycaBlGvy8SmlwHMnarzsKZ2o/vjP0msx+yAPT
 4Jg4C6Kq5ALR9mlVnKI/g7Fy29DwkP4S/RVDZtDn5mkrOjFz6q0m7USsXk491Bu4dDoY
 eWCDG49bO9BU3Tpv0RDiNo+5xHfLbMSdFkbPvozh7XajmwqzSVqv46dmPprVeVZwKqTE
 5FJWxITlbAPkBBQyQRd5EW+4WM4I1xlveco94YUt1o+CRumHRUp7AAbyC2uxUsO8xyrw
 RTw0BVbzxvdbuDaD8RgiMe+d4uIDfT9rSGqYc4xI3WQCO4sTxGBH96hWR3tP310gWJxJ
 ap5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=gA5k1AngqWRSBHRtkyQ8wIganBssCjHUIX0BmzOlL6g=;
 b=rxSW3bZftGxt867uQWD+zveP7o6aF6y+8kp4zdmmqESxYdNupsPXNeJVD/EVA1qxoL
 CkM/QTs4emAVBNuCCZUw2oTimi8KOCZpW+MiQpMb8jdMBHWUuKoyqKSJvZJf9rJ+Tin+
 wCiFhlt3bpEHmojMHeVw8pC1hH/JfmU0PqRJij+dUSRknb+mC/3sMKP7jDsDHg+Nz3xk
 GQy5ygxcJ/b1H40c1G+N86KjdV9dMjbjd6XjY4XbNa2g9wR3dESOZvkoqFQjXSG+4C2F
 VOjp8zMjcxvKkYKVyTJnd9ed4Hck2OgOrAXAIVXvTsCpU6HPhNnmU+kTgjHS8JhNxa7U
 JWxg==
X-Gm-Message-State: AOAM530YwxxWQoN0fA6rrXJtmJDgFu7gqKnFbHAdjMWttST4pImEbH2b
 gxaJVNa6B7WpMIo38g4U1BdITJ1Tpq8=
X-Google-Smtp-Source: ABdhPJwMw1JnAmV3zW10VCRXWH37PH5VVVe+vXNVTHyoqF2qPEcFTULw8NTdQdR4OzZn704bKWLr9w==
X-Received: by 2002:a17:907:c1c:: with SMTP id
 ga28mr25218168ejc.320.1622490053589; 
 Mon, 31 May 2021 12:40:53 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:b94:4956:bad4:7c81?
 ([2a02:908:1252:fb60:b94:4956:bad4:7c81])
 by smtp.gmail.com with ESMTPSA id k4sm3131389edr.64.2021.05.31.12.40.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 31 May 2021 12:40:53 -0700 (PDT)
Subject: Re: [PATCH] drm/amdgpu: Don't flush HDP on A+A
To: Eric Huang <jinhuieric.huang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210531155106.496427-1-jinhuieric.huang@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <20c45da4-7763-63c5-2e0b-8bc23847c83c@gmail.com>
Date: Mon, 31 May 2021 21:40:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210531155106.496427-1-jinhuieric.huang@amd.com>
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

QW0gMzEuMDUuMjEgdW0gMTc6NTEgc2NocmllYiBFcmljIEh1YW5nOgo+IFdpdGggWEdNSSBjb25u
ZWN0aW9uIGZsdXNoaW5nIEhEUCBvbiBQQ0llIGlzIHVubmVjZXNzYXJ5LAo+IGl0IGlzIGFsc28g
dG8gb3B0aW1pemUgbWVtb3J5IGFsbG9jYXRpb24gbGF0ZW5jeS4KCldlbGwgdGhhdCdzIGNsb3Nl
ciB0byB3aGF0IEkgaGFkIGluIG1pbmQsIGJ1dCBub3QgMTAwJSBjb3JyZWN0LgoKU2VlIHRoZSBj
b2RlIGluIGFtZGdwdV9pYl9zY2hlZHVsZSgpIGFzIHdlbGw6Cgo+ICNpZmRlZiBDT05GSUdfWDg2
XzY0Cj4gwqDCoMKgwqDCoMKgwqAgaWYgKCEoYWRldi0+ZmxhZ3MgJiBBTURfSVNfQVBVKSkKPiAj
ZW5kaWYKPiDCoMKgwqDCoMKgwqDCoCB7Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IGlmIChyaW5nLT5mdW5jcy0+ZW1pdF9oZHBfZmx1c2gpCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBhbWRncHVfcmluZ19lbWl0X2hkcF9mbHVzaChyaW5n
KTsKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZWxzZQo+IMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYW1kZ3B1X2FzaWNfZmx1c2hfaGRwKGFk
ZXYsIHJpbmcpOwo+IMKgwqDCoMKgwqDCoMKgIH0KCkkgc3VnZ2VzdCB0byB1bmlmeSB0aGUgY29k
ZSBoZXJlIGFzIHdlbGwuCgpBbmQgaW4gZ2VuZXJhbCBzdHVmZiBsaWtlIHRoYXQgc2hvdWxkIGJl
IGluIHRoZSBjb21tb24gY29kZSwgc28gdGhhdCB3ZSAKY2FuIGhhdmUgdGhlIHNhbWUgaGFuZGxp
bmcgaW5kZXBlbmRlbnQgb2YgdGhlIGhhcmR3YXJlIGdlbmVyYXRpb24uCgpDaHJpc3RpYW4uCgo+
Cj4gU2lnbmVkLW9mZi1ieTogRXJpYyBIdWFuZyA8amluaHVpZXJpYy5odWFuZ0BhbWQuY29tPgo+
IC0tLQo+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2hkcC5oIHwgMSArCj4g
ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nbWNfdjlfMC5jICAgfCAxICsKPiAgIGRyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2hkcF92NF8wLmMgICB8IDMgKysrCj4gICAzIGZpbGVzIGNo
YW5nZWQsIDUgaW5zZXJ0aW9ucygrKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV9oZHAuaCBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV9oZHAuaAo+IGluZGV4IDdlYzk5ZDU5MTU4NC4uMWNhMjNmMmY1MWQyIDEwMDY0NAo+IC0tLSBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9oZHAuaAo+ICsrKyBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9oZHAuaAo+IEBAIC00NCw2ICs0NCw3IEBAIHN0cnVj
dCBhbWRncHVfaGRwIHsKPiAgIAlzdHJ1Y3QgcmFzX2NvbW1vbl9pZgkJCSpyYXNfaWY7Cj4gICAJ
Y29uc3Qgc3RydWN0IGFtZGdwdV9oZHBfZnVuY3MJCSpmdW5jczsKPiAgIAljb25zdCBzdHJ1Y3Qg
YW1kZ3B1X2hkcF9yYXNfZnVuY3MJKnJhc19mdW5jczsKPiArCWJvb2wJbm9fZmx1c2g7Cj4gICB9
Owo+ICAgCj4gICBpbnQgYW1kZ3B1X2hkcF9yYXNfbGF0ZV9pbml0KHN0cnVjdCBhbWRncHVfZGV2
aWNlICphZGV2KTsKPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ21j
X3Y5XzAuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dtY192OV8wLmMKPiBpbmRleCAy
NzQ5NjIxZDVmNjMuLjZlMWVhYjYxNTkxNCAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9nbWNfdjlfMC5jCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
Z21jX3Y5XzAuYwo+IEBAIC0xMjIzLDYgKzEyMjMsNyBAQCBzdGF0aWMgaW50IGdtY192OV8wX2Vh
cmx5X2luaXQodm9pZCAqaGFuZGxlKQo+ICAgCQlhZGV2LT5nbWMueGdtaS5zdXBwb3J0ZWQgPSB0
cnVlOwo+ICAgCQlhZGV2LT5nbWMueGdtaS5jb25uZWN0ZWRfdG9fY3B1ID0KPiAgIAkJCWFkZXYt
PnNtdWlvLmZ1bmNzLT5pc19ob3N0X2dwdV94Z21pX3N1cHBvcnRlZChhZGV2KTsKPiArCQlhZGV2
LT5oZHAubm9fZmx1c2ggPSBhZGV2LT5nbWMueGdtaS5jb25uZWN0ZWRfdG9fY3B1Owo+ICAgCX0K
PiAgIAo+ICAgCWdtY192OV8wX3NldF9nbWNfZnVuY3MoYWRldik7Cj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2hkcF92NF8wLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9oZHBfdjRfMC5jCj4gaW5kZXggNzRiOTBjYzJiZjQ4Li5lMWIyZmFjZTg2NTYgMTAw
NjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvaGRwX3Y0XzAuYwo+ICsrKyBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2hkcF92NF8wLmMKPiBAQCAtNDAsNiArNDAsOSBA
QAo+ICAgc3RhdGljIHZvaWQgaGRwX3Y0XzBfZmx1c2hfaGRwKHN0cnVjdCBhbWRncHVfZGV2aWNl
ICphZGV2LAo+ICAgCQkJCXN0cnVjdCBhbWRncHVfcmluZyAqcmluZykKPiAgIHsKPiArCWlmIChh
ZGV2LT5oZHAubm9fZmx1c2gpCj4gKwkJcmV0dXJuOwo+ICsKPiAgIAlpZiAoIXJpbmcgfHwgIXJp
bmctPmZ1bmNzLT5lbWl0X3dyZWcpCj4gICAJCVdSRUczMl9OT19LSVEoKGFkZXYtPnJtbWlvX3Jl
bWFwLnJlZ19vZmZzZXQgKyBLRkRfTU1JT19SRU1BUF9IRFBfTUVNX0ZMVVNIX0NOVEwpID4+IDIs
IDApOwo+ICAgCWVsc2UKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
Cmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
