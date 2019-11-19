Return-Path: <SRS0=44+a=ZL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3917C432C3
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Nov 2019 20:06:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 823B022440
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Nov 2019 20:06:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 823B022440
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 550E56E393;
	Tue, 19 Nov 2019 20:06:16 +0000 (UTC)
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20::343])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8969E6E393
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Nov 2019 20:06:15 +0000 (UTC)
Received: by mail-wm1-x343.google.com with SMTP id b11so4597418wmb.5
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Nov 2019 12:06:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=X+3HlQzncSincetRz0ySrYNUYEbKe9+IW9Gm8e3/lt0=;
 b=T8zNeCiMfr6jQ1ymKi+Zp1dpuBJd5ciZp77vbYeEVZx2vwOpAPSx9N4cM9w/Fhtpax
 FFq7OfeFAXM4ATnC5fW8WIxSDJMbQxdDD47Cvn5bp/TAVNKZjHbziXSM+uOn7D3YH7L4
 3/q90wbNjioRBsRlnMyIdISef6d9HrGvb1LnyP37Rp7dDasIFbar3U9ynQR2ekF1l2e+
 1z2VgFIR6whR9Ok4es3oj96qwBA42ICsMj2M2sy7thxna2Go2Ik21Rx5hLuz4k2sd1ab
 WEEDA2Yl6U2RWnMa3n/xVM7G/u+kHlEYeb8Hlpu7pOIdbDyFC111zG/mKnakYXCUaDV+
 mVXQ==
X-Gm-Message-State: APjAAAXnP64ERFOzZm3HIlgSjxInzFvb5tF5zcqxx3uYiKLcovpr1dpg
 qKUcoh4DLtWKQk66nArDDLl4tfXm
X-Google-Smtp-Source: APXvYqzDKFYwhAzsXnYUuuo42fC5aIf8IxRPjN5H97HyYV0+GaqYGAsNo5PkNnkG0g8pOUXFNv6xDw==
X-Received: by 2002:a05:600c:cf:: with SMTP id
 u15mr8279855wmm.60.1574193973837; 
 Tue, 19 Nov 2019 12:06:13 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id c144sm4357651wmd.1.2019.11.19.12.06.13
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 19 Nov 2019 12:06:13 -0800 (PST)
Subject: Re: [PATCH 2/2] amd/amdgpu: force to trigger a no-retry-fault after a
 retry-fault
To: Felix Kuehling <felix.kuehling@amd.com>, Alex Sierra
 <alex.sierra@amd.com>, amd-gfx@lists.freedesktop.org
References: <20191119163754.4966-1-alex.sierra@amd.com>
 <20191119163754.4966-2-alex.sierra@amd.com>
 <2b96848e-cf45-b558-e453-8a73de83d4a3@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <e66f018f-2492-f323-a8fc-3919d658aadd@gmail.com>
Date: Tue, 19 Nov 2019 21:06:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <2b96848e-cf45-b558-e453-8a73de83d4a3@amd.com>
Content-Language: en-US
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20161025;
 h=reply-to:subject:to:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=X+3HlQzncSincetRz0ySrYNUYEbKe9+IW9Gm8e3/lt0=;
 b=hqT6PYc/sjEXZVOsniOrcoNA1sfuEeM+RMzIzgxeu+L6vQK3LfJaxp/q1hwNCV8AYU
 jTjR5q/xnNEv47rEWAYMZ6LaDdkAzgnyDFVGpyqp3hEs5QeEhId3xVBQYDY9LpqlmKyr
 bI6RaKHSqGYzCq2FTqmtpXPCf97/jTytnDKhjtS8Gs4CQ6ku9A1kSRhSoblAYVmqqD5J
 sQK4M+PG/nmklamGZLvQfYDntMRALhDurpeaDWyvTd7jpyVjhXuKjyo8tmb6GngLL9je
 F0vAkNGWJnBT4EF4EQ1fFMgceV0tNuWyZVfW/CTWDeUIpMq3AxwXz2Ca6aWwkQUjmyXW
 Mk7g==
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
Message-ID: <20191119200611.p_P4bDAvRByeswhbM1NM3lA_UwVVBemXgnjlfJMISy8@z>

QW0gMTkuMTEuMTkgdW0gMTc6NDUgc2NocmllYiBGZWxpeCBLdWVobGluZzoKPiBPbiAyMDE5LTEx
LTE5IDExOjM3LCBBbGV4IFNpZXJyYSB3cm90ZToKPj4gT25seSBmb3IgdGhlIGRlYnVnZ2VyIHVz
ZSBjYXNlLgo+Pgo+PiBbd2h5XQo+PiBBdm9pZCBlbmRsZXNzIHRyYW5zbGF0aW9uIHJldHJpZXMs
IGFmdGVyIGFuIGludmFsaWQgYWRkcmVzcyBhY2Nlc3MgaGFzCj4+IGJlZW4gaXNzdWVkIHRvIHRo
ZSBHUFUuIEluc3RlYWQsIHRoZSB0cmFwIGhhbmRsZXIgaXMgZm9yY2VkIHRvIGVudGVyIGJ5Cj4+
IGdlbmVyYXRpbmcgYSBuby1yZXRyeS1mYXVsdC4KPj4gQSBzX3RyYXAgaW5zdHJ1Y3Rpb24gaXMg
aW5zZXJ0ZWQgaW4gdGhlIGRlYnVnZ2VyIGNhc2UgdG8gbGV0IHRoZSB3YXZlIHRvCj4+IGVudGVy
IHRyYXAgaGFuZGxlciB0byBzYXZlIGNvbnRleHQuCj4+Cj4+IFtob3ddCj4+IEludGVudGlvbmFs
bHkgdXNpbmcgYW4gaW52YWxpZCBmbGFnIGNvbWJpbmF0aW9uIChGIGFuZCBQIHNldCBhdCB0aGUg
c2FtZQo+PiB0aW1lKSB0byB0cmlnZ2VyIGEgbm8tcmV0cnktZmF1bHQsIGFmdGVyIGEgcmV0cnkt
ZmF1bHQgaGFwcGVucy4gVGhpcyBpcwo+PiBvbmx5IHZhbGlkIHVuZGVyIGNvbXB1dGUgY29udGV4
dC4KPj4KPj4gQ2hhbmdlLUlkOiBJNDE4MGMzMGUyNjMxZGMwNDAxY2JkNjE3MWY4YTY3NzZlNDcz
M2M5YQo+PiBTaWduZWQtb2ZmLWJ5OiBBbGV4IFNpZXJyYSA8YWxleC5zaWVycmFAYW1kLmNvbT4K
Pgo+IFRoaXMgY29tbWl0IGFkZHMgc29tZSB1bm5lY2Vzc2FyeSBlbXB0eSBsaW5lcy4gU2VlIGlu
bGluZS4gV2l0aCB0aGF0IAo+IGZpeGVkLCB0aGUgc2VyaWVzIGlzCj4KPiBSZXZpZXdlZC1ieTog
RmVsaXggS3VlaGxpbmcgPEZlbGl4Lkt1ZWhsaW5nQGFtZC5jb20+CgpJIGFjdHVhbGx5IGxpa2Ug
dGhlIGVtcHR5IGxpbmVzLCBuaWNlbHkgZW1waGFzZXMgdGhhdCBhIG5ldyBibG9jayBzdGFydHMu
CgpNYXliZSBub3RlIGluIHRoZSBjb2RlIGNvbW1lbnQgdGhhdCB0aGUgZmxhZ3MgY29tYmluYXRp
b24gaXMgCmludGVudGlvbmFsbHkgaW52YWxpZCBhcyB3ZWxsLgoKQnV0IGVpdGhlciB3YXkgdGhl
IHNlcmllcyBpcyBSZXZpZXdlZC1ieTogQ2hyaXN0aWFuIEvDtm5pZyAKPGNocmlzdGlhbi5rb2Vu
aWdAYW1kLmNvbT4uCgpSZWdhcmRzLApDaHJpc3RpYW4uCgo+Cj4gUGxlYXNlIGFsc28gZ2l2ZSBD
aHJpc3RpYW4gYSBjaGFuY2UgdG8gcmV2aWV3Lgo+Cj4gVGhhbmtzLAo+IMKgIEZlbGl4Cj4KPj4g
LS0tCj4+IMKgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jIHwgOSArKysr
KysrKy0KPj4gwqAgMSBmaWxlIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigt
KQo+Pgo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Zt
LmMgCj4+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMKPj4gaW5kZXgg
ZDUxYWM4NzcxYWUwLi5jZDM2MTk1ZmY4YmUgMTAwNjQ0Cj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jCj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV92bS5jCj4+IEBAIC0zMjAyLDExICszMjAyLDE4IEBAIGJvb2wgYW1kZ3B1X3Zt
X2hhbmRsZV9mYXVsdChzdHJ1Y3QgCj4+IGFtZGdwdV9kZXZpY2UgKmFkZXYsIHVuc2lnbmVkIGlu
dCBwYXNpZCwKPj4gwqDCoMKgwqDCoCBmbGFncyA9IEFNREdQVV9QVEVfVkFMSUQgfCBBTURHUFVf
UFRFX1NOT09QRUQgfAo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgQU1ER1BVX1BURV9TWVNURU07Cj4+
IMKgIC3CoMKgwqAgaWYgKGFtZGdwdV92bV9mYXVsdF9zdG9wID09IEFNREdQVV9WTV9GQVVMVF9T
VE9QX05FVkVSKSB7Cj4+ICvCoMKgwqAgaWYgKHZtLT5pc19jb21wdXRlX2NvbnRleHQpIHsKPj4g
K8KgwqDCoMKgwqDCoMKgIC8qIFNldHRpbmcgUFRFIGZsYWdzIHRvIHRyaWdnZXIgYSBuby1yZXRy
eS1mYXVsdMKgICovCj4+ICvCoMKgwqDCoMKgwqDCoCBmbGFncyA9IEFNREdQVV9QVEVfRVhFQ1VU
QUJMRSB8IEFNREdQVV9QREVfUFRFIHwKPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgQU1ER1BV
X1BURV9URjsKPj4gK8KgwqDCoMKgwqDCoMKgIHZhbHVlID0gMDsKPj4gKwo+IFVubmVjZXNzYXJ5
IGJsYW5rIGxpbmUuCj4+ICvCoMKgwqAgfSBlbHNlIGlmIChhbWRncHVfdm1fZmF1bHRfc3RvcCA9
PSBBTURHUFVfVk1fRkFVTFRfU1RPUF9ORVZFUikgewo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgLyog
UmVkaXJlY3QgdGhlIGFjY2VzcyB0byB0aGUgZHVtbXkgcGFnZSAqLwo+PiDCoMKgwqDCoMKgwqDC
oMKgwqAgdmFsdWUgPSBhZGV2LT5kdW1teV9wYWdlX2FkZHI7Cj4+IMKgwqDCoMKgwqDCoMKgwqDC
oCBmbGFncyB8PSBBTURHUFVfUFRFX0VYRUNVVEFCTEUgfCBBTURHUFVfUFRFX1JFQURBQkxFIHwK
Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgQU1ER1BVX1BURV9XUklURUFCTEU7Cj4+ICsK
PiBVbm5lY2Vzc2FyeSBibGFuayBsaW5lLgo+PiDCoMKgwqDCoMKgIH0gZWxzZSB7Cj4+IMKgwqDC
oMKgwqDCoMKgwqDCoCAvKiBMZXQgdGhlIGh3IHJldHJ5IHNpbGVudGx5IG9uIHRoZSBQVEUgKi8K
Pj4gwqDCoMKgwqDCoMKgwqDCoMKgIHZhbHVlID0gMDsKPiBfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwo+IGFtZC1nZnggbWFpbGluZyBsaXN0Cj4gYW1kLWdm
eEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPiBodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL2FtZC1nZngKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRl
c2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8v
YW1kLWdmeA==
