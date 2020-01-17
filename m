Return-Path: <SRS0=QkQq=3G=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F18BC33C9E
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Jan 2020 18:47:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3264E20730
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Jan 2020 18:47:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QtnSUtEJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3264E20730
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE1996F8AB;
	Fri, 17 Jan 2020 18:47:05 +0000 (UTC)
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F2486F8AB
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Jan 2020 18:47:05 +0000 (UTC)
Received: by mail-wr1-x444.google.com with SMTP id t2so23726079wrr.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Jan 2020 10:47:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=YnyM8R39P/eCQ05KW7ucaKJEPxPyO7cRkyunQR2bZqg=;
 b=QtnSUtEJK9vRO1E7RVZZ1urIoKX9zBW50l9rhMB6bS4xFbxC3EB06JaTZke/zWK9M6
 JC80DbVicZ+pXvXfVIzifOks5ZxcQa4sgEPSjLbA1QLjmNQZFGx4KRlZk8b1iLilL8h2
 J/A/d//mcfGoy7r1XLjD+llLzfEU3OdqrtiArCU1Uw6CbNXmTsDM4WfLm9SFAULcNkeR
 CaldWB19eFzP1RNjl1lnHhLdBov/RSCGeOiWX5e1fizzQHXF+7XfVjmTzVCktaCFYGEn
 OVhopu5RQPeIqTT5j054sVgX6PxRkc2JT6wmuhr/SU21E7hSLpD6TUnJr19zL0G9KKHo
 5IzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=YnyM8R39P/eCQ05KW7ucaKJEPxPyO7cRkyunQR2bZqg=;
 b=oK3eD3AxOPHFiZ0qLwjOWq8s3ZoHkZG4QgJMb1UtjsyhTRbDmJ2xFPKeGTGsbk/BeT
 D+OoMJ79JFRVO9rBEN6q8YJIJCZ/61WypuViRNSht50YbxqLqgHDmf+4cn2oPsdDzCaL
 N1etlGS5Lb+utKQWzJMV6x3FurubQkC8uH2JSp9UHhzgkCUmYd5xB1wpBSWc2BazVes1
 RybugIR86hw/QIZ3Eh2z+Ok4Sm6AEsXVZd27lDjmSuv8dk929SpWKOS2hPD7EURLCSFd
 RPEiVTd1g+kaP+fo9Zi18GilQQWzrmQWr6a+tESKDgE2iBPlfl7d6Xha3yeVuZITXFke
 Q8Tw==
X-Gm-Message-State: APjAAAX87kU1d+gHWFG0pWFlwjFwqeYpVlWF/NSRZdtV59AlWdqaToEN
 F5kgQkIiDQvvyrADfP9JWV1cSi1p
X-Google-Smtp-Source: APXvYqzfV3epCso+HUQrHV/k7mCH8aSko5uhW1LPMkQckkzN9K8+rpU9azvcG41VUsbiPMPlHwPyWg==
X-Received: by 2002:adf:d183:: with SMTP id v3mr4785119wrc.180.1579286823594; 
 Fri, 17 Jan 2020 10:47:03 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id u16sm8667795wmj.41.2020.01.17.10.47.00
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 17 Jan 2020 10:47:03 -0800 (PST)
Subject: Re: [PATCH] drm/amdgpu: add coreboot workaround for KV/KB
To: Felix Kuehling <felix.kuehling@amd.com>, christian.koenig@amd.com,
 fredrik.bruhn@unibap.com, amd-gfx@lists.freedesktop.org
References: <20200116130907.22410-1-christian.koenig@amd.com>
 <c5aa1227-adc0-f7d0-1786-deec7ca681c1@amd.com>
 <3c1b6bea-d5bc-0532-9805-2eb2c1003653@gmail.com>
 <2f992eda-75c8-570b-fc77-584ad4959168@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <b2b1b2b2-e99d-5941-4670-786034fbcc56@gmail.com>
Date: Fri, 17 Jan 2020 19:46:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <2f992eda-75c8-570b-fc77-584ad4959168@amd.com>
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

QW0gMTcuMDEuMjAgdW0gMTg6MDcgc2NocmllYiBGZWxpeCBLdWVobGluZzoKPiBPbiAyMDIwLTAx
LTE3IDM6MTcgYS5tLiwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToKPj4gQW0gMTcuMDEuMjAgdW0g
MDM6MDEgc2NocmllYiBGZWxpeCBLdWVobGluZzoKPj4+IE9uIDIwMjAtMDEtMTYgODowOSwgQ2hy
aXN0aWFuIEvDtm5pZyB3cm90ZToKPj4+PiBDb3JlYm9vdCBzZWVtcyB0byBoYXZlIGEgcHJvYmxl
bSBjb3JyZWN0bHkgc2V0dGluZyB1cCBhY2Nlc3MgdG8gdGhlIAo+Pj4+IHN0b2xlbiBWUkFNCj4+
Pj4gb24gS1YvS0IuIFVzZSB0aGUgZGlyZWN0IGFjY2VzcyBvbmx5IHdoZW4gbmVjZXNzYXJ5Lgo+
Pj4KPj4+IEknbSBub3Qgc3VyZSB3aGF0IHlvdSBtZWFuIGJ5ICJuZWNlc3NhcnkiLgo+Pgo+PiBO
ZWNlc3NhcnkgZm9yIGJldHRlciBwZXJmb3JtYW5jZS4KPgo+IFJpZ2h0LiBTbyB5b3VyIHBhdGNo
IGRlc2NyaXB0aW9uIHNheXMgdGhhdCBzb21ldGltZXMgYmV0dGVyIAo+IHBlcmZvcm1hbmNlIGlz
IG5vdCBuZWNlc3NhcnkuCgpXZWxsIHdoYXQgSSB3YW50IHRvIHNheSBpcyB0aGF0IGl0IGlzIG5v
dCBuZWNlc3NhcnkgZm9yIGJldHRlciAKcGVyZm9ybWFuY2UuIElmIEZCIGlzIHNtYWxsIGVub3Vn
aCB3ZSBjYW4gdXNlIHRoZSBCQVIgYXMgd2VsbC4KCj4gVGhlIGNyaXRlcmlhIGlzIGJhc2VkIG9u
IHRoZSBzaXplIG9mIHRoZSBCQVIsIHdoaWNoIGRvZXNuJ3QgcmVhbGx5IAo+IGhhdmUgYW55dGhp
bmcgdG8gZG8gd2l0aCBwZXJmb3JtYW5jZS4KCldoeT8gTW9zdCBvZiB0aGUgcGVyZm9ybWFuY2Ug
Z2FpbiBjb21lcyBmcm9tIG5vdCBzaHVmZmxpbmcgYXJvdW5kIFZSQU0gCmJ1ZmZlcnMgZm9yIENQ
VSBhY2Nlc3MgYW55IG1vcmUuCgpBZGRpdGlvbmFsIHRvIHRoYXQgdGhlcmUgaXMgYSByZWR1Y3Rp
b24gaW4gbGF0ZW5jeSB3aGVuIGFjY2Vzc2luZyB0aGUgClZSQU0sIGJ1dCB0aGF0IHVzdWFsbHkg
ZG9lc24ndCBtYXR0ZXIgZm9yIHBlcmZvcm1hbmNlLgoKPgo+Cj4+Cj4+Pgo+Pj4+Cj4+Pj4gU2ln
bmVkLW9mZi1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgo+
Pj4+IC0tLQo+Pj4+IMKgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dtY192N18wLmMgfCAz
ICsrLQo+Pj4+IMKgIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24o
LSkKPj4+Pgo+Pj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nbWNf
djdfMC5jIAo+Pj4+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ21jX3Y3XzAuYwo+Pj4+
IGluZGV4IDE5ZDViMTMzZTFkNy4uOWRhOTU5NmEzNjM4IDEwMDY0NAo+Pj4+IC0tLSBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dtY192N18wLmMKPj4+PiArKysgYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9nbWNfdjdfMC5jCj4+Pj4gQEAgLTM4MSw3ICszODEsOCBAQCBzdGF0aWMg
aW50IGdtY192N18wX21jX2luaXQoc3RydWN0IAo+Pj4+IGFtZGdwdV9kZXZpY2UgKmFkZXYpCj4+
Pj4gwqDCoMKgwqDCoCBhZGV2LT5nbWMuYXBlcl9zaXplID0gcGNpX3Jlc291cmNlX2xlbihhZGV2
LT5wZGV2LCAwKTsKPj4+PiDCoCDCoCAjaWZkZWYgQ09ORklHX1g4Nl82NAo+Pj4+IC3CoMKgwqAg
aWYgKGFkZXYtPmZsYWdzICYgQU1EX0lTX0FQVSkgewo+Pj4+ICvCoMKgwqAgaWYgKGFkZXYtPmZs
YWdzICYgQU1EX0lTX0FQVSAmJgo+Pj4+ICvCoMKgwqDCoMKgwqDCoCBhZGV2LT5nbWMucmVhbF92
cmFtX3NpemUgPiBhZGV2LT5nbWMuYXBlcl9zaXplKSB7Cj4+Pgo+Pj4gQ1BVIGFjY2VzcyB0byB0
aGUgd2hvbGUgVlJBTSBpc24ndCByZWFsbHkgbmVjZXNzYXJ5LiBJIHRob3VnaHQgdGhlIAo+Pj4g
bWFpbiBtb3RpdmF0aW9uIGZvciBhY2Nlc3NpbmcgRkIgZGlyZWN0bHkgb24gQVBVcyB3YXMgYmV0
dGVyIAo+Pj4gcGVyZm9ybWFuY2UuIFlvdSdyZSBkaXNhYmxpbmcgdGhhdCBvcHRpbWl6YXRpb24g
b24gYWxsIEFQVXMgd2hlcmUgCj4+PiB0aGUgRkIgaXMgc21hbGxlciB0aGFuIHRoZSBhcGVydHVy
ZSBzaXplLgo+Pgo+PiBDb3JyZWN0LCB5ZXMuIEZvciBzb21lIHJlYXNvbiBjb3JlYm9vdCBzZWVt
cyB0byBleHBsaWNpdGx5IHNldHVwIHRoZSAKPj4gbWVtb3J5IHVzZWQgZm9yIHRoZSBGQiBhcyB3
cml0ZS1wcm90ZWN0ZWQuCj4+Cj4+IFRoZSBHUFUgY2FuIHN0aWxsIHJlYWQvd3JpdGUgaXQgbm9y
bWFsbHkgY2F1c2UgaXQgaWdub3JlcyB0aGF0IAo+PiBwcm90ZWN0aW9uLCBidXQgdGhlIENQVSBj
YW4ndCBjaGFuZ2UgdGhlIEZCIG1lbW9yeSBhbnkgbW9yZSB3aXRoIHRoYXQgCj4+IHNldHVwLgo+
Cj4gQ2FuIHdlIHRlc3Qgd2hldGhlciB3cml0aW5nIHRvIEZCIHdvcmtzIGFuZCBtYWtlIHRoZSBk
ZWNpc2lvbiBiYXNlZCBvbiAKPiB0aGF0PwoKVGhvdWdodCBhYm91dCB0aGF0IGFzIHdlbGwuIEJ1
dCBpdCBpcyBjb21wbGljYXRlZCB0byBpbXBsZW1lbnQgYW5kIHdlIAp3b3VsZCBuZWVkIHRvIHRl
c3QgdGhlIHdob2xlIEZCIHRvIGJlIHN1cmUgYW5kIHRoYXQgY291bGQgdGFrZSBhIHdoaWxlLgoK
Q2hyaXN0aWFuLgoKPgo+IFRoYW5rcywKPiDCoCBGZWxpeAo+Cj4+Cj4+IE5vIGlkZWEgd2h5IHRo
ZXkgZG8gdGhpcywgbW9zdCBsaWtlbHkganVzdCBhbiBvdmVyIGNvbnNlcnZhdGl2ZSAKPj4gcHJv
dGVjdGlvbiBvZiBhIHJlc2VydmVkIGFyZWEgb2YgbWVtb3J5Lgo+Pgo+PiBSZWdhcmRzLAo+PiBD
aHJpc3RpYW4uCj4+Cj4+Pgo+Pj4gUmVnYXJkcywKPj4+IMKgIEZlbGl4Cj4+Pgo+Pj4KPj4+PiDC
oMKgwqDCoMKgwqDCoMKgwqAgYWRldi0+Z21jLmFwZXJfYmFzZSA9ICgodTY0KVJSRUczMihtbU1D
X1ZNX0ZCX09GRlNFVCkpIDw8IAo+Pj4+IDIyOwo+Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBhZGV2
LT5nbWMuYXBlcl9zaXplID0gYWRldi0+Z21jLnJlYWxfdnJhbV9zaXplOwo+Pj4+IMKgwqDCoMKg
wqAgfQo+Pj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
Pj4+IGFtZC1nZnggbWFpbGluZyBsaXN0Cj4+PiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9y
Zwo+Pj4gaHR0cHM6Ly9uYW0xMS5zYWZlbGlua3MucHJvdGVjdGlvbi5vdXRsb29rLmNvbS8/dXJs
PWh0dHBzJTNBJTJGJTJGbGlzdHMuZnJlZWRlc2t0b3Aub3JnJTJGbWFpbG1hbiUyRmxpc3RpbmZv
JTJGYW1kLWdmeCZhbXA7ZGF0YT0wMiU3QzAxJTdDZmVsaXgua3VlaGxpbmclNDBhbWQuY29tJTdD
ZDU5NDkwZjBlN2Y1NDdkM2EzZmMwOGQ3OWIyNWJlZDQlN0MzZGQ4OTYxZmU0ODg0ZTYwOGUxMWE4
MmQ5OTRlMTgzZCU3QzAlN0MwJTdDNjM3MTQ4NDU4NzU5NjU4NjE3JmFtcDtzZGF0YT1Ubzlmc0VI
dlE0ZG9rWktTd1RaUTdWOExJUkVBJTJCajU4b3V2YVVWdEhmcEklM0QmYW1wO3Jlc2VydmVkPTAg
Cj4+Pgo+Pgo+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
Cj4gYW1kLWdmeCBtYWlsaW5nIGxpc3QKPiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+
IGh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAoK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
