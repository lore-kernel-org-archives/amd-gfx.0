Return-Path: <SRS0=EvZE=24=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEE0FC33C8C
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jan 2020 12:47:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AED0D207E0
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jan 2020 12:47:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JydHYSrP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AED0D207E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 701546E05D;
	Tue,  7 Jan 2020 12:47:10 +0000 (UTC)
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com
 [IPv6:2a00:1450:4864:20::341])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 40A7D6E05D
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Jan 2020 12:47:09 +0000 (UTC)
Received: by mail-wm1-x341.google.com with SMTP id d73so18800236wmd.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 07 Jan 2020 04:47:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=pzz2Q84kQE3AQVmE+keWPa4OabhtVmzEjjJ07soD1IY=;
 b=JydHYSrPGV6q7KItJfr0MqEZT6M2QkYimcn1KApHoON+y25WgE7eLdjkZHNiEkOYvW
 pIXA5Lil0VjOr4ZOE3CBnqjKxtaibPhOCY9/oG/IOoEQgL084e7taOzAM8EAdJciiaDf
 rKqTgqHQyRNz5XXkFLMSNx1F1jF4/OXnt+tuFBXnm8qfewEWdiqw9BrQOkJKPkTaIa7d
 R8LSXTPYC8rOMvpEJC57j7Fpgq1J5LaNrBesstjTExbWNYBztTzcGE1a/gWDjP/+d9IM
 OS+hixjkn5zZs3b0k/MY1MQiROqe3fMhWr5tHwT5kJZIUwkLEJR2qfgkEIt57ie4PXiG
 DBlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=pzz2Q84kQE3AQVmE+keWPa4OabhtVmzEjjJ07soD1IY=;
 b=Z6BdhLls1ThQd6uIw5yRQwvyxdwQymkOrQPyYn+Ncyp59POsia4c1I+HrKXczY7gGm
 v1U48CAs5bBiqh5WeJVKuuhZS3hab/iVM0u0fZ4XTS6j35YiOZg9bMEZTygV+TNh0/Rz
 wNlv0Lz7dxFxWZdnGsjmYUNWhLGYGeqzCqQpm91J4Ahpl+CtZ5+g+8w2HS/tuBzl94wv
 YeRQFtfZCHdegbp+PH8WmWVElSHXjm0jOz3s0/bd5UPlrLgQXCFmttcmNY/5mjXuxR8a
 HBNrCAg6idEoyMggiSAubug0F6lUVPV77VD4LMxLzvkR6sh+zNtzzIwVbciw+yXDFWma
 RzbA==
X-Gm-Message-State: APjAAAWmPG32OItfoOWkbuIaHsvooEuXXMvp5AN6oMYZFznayyzZgcJ2
 CmqET8+XQ5QeE1h3xHeAkuYqcof4
X-Google-Smtp-Source: APXvYqyQDL070u45ZSWnpOHqnjqanHe+xYXVMwuqv5u1GhzEGucmFXHmQjf90xC/gc3LLrLjpRQWDg==
X-Received: by 2002:a1c:de09:: with SMTP id v9mr9718745wmg.170.1578401227441; 
 Tue, 07 Jan 2020 04:47:07 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id o194sm27267451wme.45.2020.01.07.04.47.06
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 07 Jan 2020 04:47:06 -0800 (PST)
Subject: Re: [PATCH 08/12] drm/amdgpu: rework synchronization of VM updates
To: Felix Kuehling <felix.kuehling@amd.com>, Alex.Sierra@amd.com,
 Philip.Yang@amd.com, amd-gfx@lists.freedesktop.org
References: <20200106150335.1738-1-christian.koenig@amd.com>
 <20200106150335.1738-9-christian.koenig@amd.com>
 <a16551a5-2626-a964-c803-3639bbe1aabb@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <238daa73-b347-794f-d48e-6f02ea6cb957@gmail.com>
Date: Tue, 7 Jan 2020 13:47:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <a16551a5-2626-a964-c803-3639bbe1aabb@amd.com>
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

QW0gMDYuMDEuMjAgdW0gMjI6Mzggc2NocmllYiBGZWxpeCBLdWVobGluZzoKPiBPbiAyMDIwLTAx
LTA2IDEwOjAzIGEubS4sIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4+IFtTTklQXQo+PiBAQCAt
MTU1Nyw3ICsxNTU3LDkgQEAgc3RhdGljIGludCBhbWRncHVfdm1fYm9fdXBkYXRlX21hcHBpbmco
c3RydWN0IAo+PiBhbWRncHVfZGV2aWNlICphZGV2LAo+PiDCoCDCoMKgwqDCoMKgIC8qIHN5bmMg
dG8gZXZlcnl0aGluZyBleGNlcHQgZXZpY3Rpb24gZmVuY2VzIG9uIHVubWFwcGluZyAqLwo+Cj4g
SSB0aGluayB0aGlzIGNvbW1lbnQgbmVlZHMgdG8gYmUgdXBkYXRlZC4gU29tZXRoaW5nIGxpa2Ug
IkltcGxpY2l0bHkgCj4gc3luYyB0byBjb21tYW5kIHN1Ym1pc3Npb25zIGluIHRoZSBzYW1lIFZN
IGJlZm9yZSB1bm1hcHBpbmcuIFN5bmMgdG8gCj4gbW92aW5nIGZlbmNlcyBiZWZvcmUgbWFwcGlu
Zy4iCgpHb29kIHBvaW50LCBqdXN0IHVwZGF0ZWQgdGhpcy4KCj4KPgo+PiBbU05JUF0KPj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bV9jcHUuYyAKPj4g
Yi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm1fY3B1LmMKPj4gaW5kZXggNjhi
MDEzYmUzODM3Li4wYmU3MjY2MGRiNGMgMTAwNjQ0Cj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV92bV9jcHUuYwo+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfdm1fY3B1LmMKPj4gQEAgLTQ0LDI2ICs0NCwyMSBAQCBzdGF0aWMgaW50IGFt
ZGdwdV92bV9jcHVfbWFwX3RhYmxlKHN0cnVjdCAKPj4gYW1kZ3B1X2JvICp0YWJsZSkKPj4gwqDC
oCAqIFJldHVybnM6Cj4+IMKgwqAgKiBOZWdhdGl2IGVycm5vLCAwIGZvciBzdWNjZXNzLgo+PiDC
oMKgICovCj4+IC1zdGF0aWMgaW50IGFtZGdwdV92bV9jcHVfcHJlcGFyZShzdHJ1Y3QgYW1kZ3B1
X3ZtX3VwZGF0ZV9wYXJhbXMgKnAsIAo+PiB2b2lkICpvd25lciwKPj4gLcKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIHN0cnVjdCBkbWFfZmVuY2UgKmV4Y2x1c2l2ZSkKPj4gK3N0YXRp
YyBpbnQgYW1kZ3B1X3ZtX2NwdV9wcmVwYXJlKHN0cnVjdCBhbWRncHVfdm1fdXBkYXRlX3BhcmFt
cyAqcCwKPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHN0cnVjdCBkbWFfcmVz
diAqcmVzdiwKPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGVudW0gYW1kZ3B1
X3N5bmNfbW9kZSBzeW5jX21vZGUpCj4+IMKgIHsKPj4gK8KgwqDCoCBzdHJ1Y3QgYW1kZ3B1X3N5
bmMgc3luYzsKPj4gwqDCoMKgwqDCoCBpbnQgcjsKPj4gwqAgLcKgwqDCoCAvKiBXYWl0IGZvciBh
bnkgQk8gbW92ZSB0byBiZSBjb21wbGV0ZWQgKi8KPj4gLcKgwqDCoCBpZiAoZXhjbHVzaXZlKSB7
Cj4+IC3CoMKgwqDCoMKgwqDCoCByID0gZG1hX2ZlbmNlX3dhaXQoZXhjbHVzaXZlLCB0cnVlKTsK
Pj4gLcKgwqDCoMKgwqDCoMKgIGlmICh1bmxpa2VseShyKSkKPj4gLcKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgcmV0dXJuIHI7Cj4+IC3CoMKgwqAgfQo+PiAtCj4+IC3CoMKgwqAgLyogRG9uJ3Qgd2Fp
dCBmb3Igc3VibWlzc2lvbnMgZHVyaW5nIHBhZ2UgZmF1bHQgKi8KPj4gLcKgwqDCoCBpZiAocC0+
ZGlyZWN0KQo+PiArwqDCoMKgIGlmICghcmVzdikKPj4gwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVy
biAwOwo+PiDCoCAtwqDCoMKgIC8qIFdhaXQgZm9yIFBUIEJPcyB0byBiZSBpZGxlLiBQVHMgc2hh
cmUgdGhlIHNhbWUgcmVzdi4gb2JqZWN0Cj4+IC3CoMKgwqDCoCAqIGFzIHRoZSByb290IFBEIEJP
Cj4+IC3CoMKgwqDCoCAqLwo+PiAtwqDCoMKgIHJldHVybiBhbWRncHVfYm9fc3luY193YWl0KHAt
PnZtLT5yb290LmJhc2UuYm8sIG93bmVyLCB0cnVlKTsKPj4gK8KgwqDCoCBhbWRncHVfc3luY19j
cmVhdGUoJnN5bmMpOwo+PiArwqDCoMKgIGFtZGdwdV9zeW5jX3Jlc3YocC0+YWRldiwgJnN5bmMs
IHJlc3YsIHN5bmNfbW9kZSwgcC0+dm0pOwo+PiArwqDCoMKgIHIgPSBhbWRncHVfc3luY193YWl0
KCZzeW5jLCB0cnVlKTsKPj4gK8KgwqDCoCBhbWRncHVfc3luY19mcmVlKCZzeW5jKTsKPgo+IFRo
aXMgbG9va3MgbGlrZSBpdCdzIHByZXR0eSBtdWNoIGR1cGxpY2F0aW5nIGFtZGdwdV9ib19zeW5j
X3dhaXQuIEluIAo+IGZhY3QsIHdoZW4gSSBmaXJzdCB3cm90ZSB0aGF0IGZ1bmN0aW9uIGl0IHdh
cyBtZWFudCBhcyAKPiBhbWRncHVfc3luY193YWl0X3Jlc3YgKGFuZCB0aGUgY29tbWVudCBhYm92
ZSB0aGF0IGZ1bmN0aW9uIHN0aWxsIAo+IGluY29ycmVjdGx5IGhhcyB0aGF0IG5hbWUpLgoKUXVl
c3Rpb24gaXMgd2hlcmUgaXMgdGhlIGJlc3QgcGxhY2UgdG8gcHV0IHRoaXM/IEl0IGRvZXNuJ3Qg
cmVhbGx5IGZpdCAKaW50byBhbWRncHVfc3luYy5jIGJlY2F1c2UgaXQgdXNlcyB0aGUgc3luY29i
amVjdCBhbmQgZG9lc24ndCBpbXBsZW1lbnRzIGl0LgoKQnV0IGlmIHdlIGdpdmUgdGhlIHJlc2Vy
dmF0aW9uIG9iamVjdCBhcyBwYXJhbWV0ZXIgYW1kZ3B1X29iamVjdC5jIApkb2Vzbid0IGZpdHMg
ZWl0aGVyIGFzIHdlbGwuCgpSZWdhcmRzLApDaHJpc3RpYW4uCgo+Cj4gUmVnYXJkcywKPiDCoCBG
ZWxpeAo+Cj4KPj4gK8KgwqDCoCByZXR1cm4gcjsKPj4gwqAgfQo+PiDCoCDCoCAvKioKPj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bV9zZG1hLmMgCj4+
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtX3NkbWEuYwo+PiBpbmRleCAz
YjYxMzE3YzBmMDguLmU3YTM4MzEzNDUyMSAxMDA2NDQKPj4gLS0tIGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X3ZtX3NkbWEuYwo+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfdm1fc2RtYS5jCj4+IEBAIC01OCw5ICs1OCw5IEBAIHN0YXRpYyBpbnQg
YW1kZ3B1X3ZtX3NkbWFfbWFwX3RhYmxlKHN0cnVjdCAKPj4gYW1kZ3B1X2JvICp0YWJsZSkKPj4g
wqDCoCAqIE5lZ2F0aXYgZXJybm8sIDAgZm9yIHN1Y2Nlc3MuCj4+IMKgwqAgKi8KPj4gwqAgc3Rh
dGljIGludCBhbWRncHVfdm1fc2RtYV9wcmVwYXJlKHN0cnVjdCBhbWRncHVfdm1fdXBkYXRlX3Bh
cmFtcyAqcCwKPj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdm9pZCAqb3du
ZXIsIHN0cnVjdCBkbWFfZmVuY2UgKmV4Y2x1c2l2ZSkKPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgc3RydWN0IGRtYV9yZXN2ICpyZXN2LAo+PiArwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBlbnVtIGFtZGdwdV9zeW5jX21vZGUgc3luY19tb2RlKQo+PiDC
oCB7Cj4+IC3CoMKgwqAgc3RydWN0IGFtZGdwdV9ibyAqcm9vdCA9IHAtPnZtLT5yb290LmJhc2Uu
Ym87Cj4+IMKgwqDCoMKgwqAgdW5zaWduZWQgaW50IG5kdyA9IEFNREdQVV9WTV9TRE1BX01JTl9O
VU1fRFc7Cj4+IMKgwqDCoMKgwqAgaW50IHI7Cj4+IMKgIEBAIC03MCwxNyArNzAsMTAgQEAgc3Rh
dGljIGludCBhbWRncHVfdm1fc2RtYV9wcmVwYXJlKHN0cnVjdCAKPj4gYW1kZ3B1X3ZtX3VwZGF0
ZV9wYXJhbXMgKnAsCj4+IMKgIMKgwqDCoMKgwqAgcC0+bnVtX2R3X2xlZnQgPSBuZHc7Cj4+IMKg
IC3CoMKgwqAgLyogV2FpdCBmb3IgbW92ZXMgdG8gYmUgY29tcGxldGVkICovCj4+IC3CoMKgwqAg
ciA9IGFtZGdwdV9zeW5jX2ZlbmNlKCZwLT5qb2ItPnN5bmMsIGV4Y2x1c2l2ZSwgZmFsc2UpOwo+
PiAtwqDCoMKgIGlmIChyKQo+PiAtwqDCoMKgwqDCoMKgwqAgcmV0dXJuIHI7Cj4+IC0KPj4gLcKg
wqDCoCAvKiBEb24ndCB3YWl0IGZvciBhbnkgc3VibWlzc2lvbnMgZHVyaW5nIHBhZ2UgZmF1bHQg
aGFuZGxpbmcgKi8KPj4gLcKgwqDCoCBpZiAocC0+ZGlyZWN0KQo+PiArwqDCoMKgIGlmICghcmVz
dikKPj4gwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiAwOwo+PiDCoCAtwqDCoMKgIHJldHVybiBh
bWRncHVfc3luY19yZXN2KHAtPmFkZXYsICZwLT5qb2ItPnN5bmMsIAo+PiByb290LT50Ym8uYmFz
ZS5yZXN2LAo+PiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIEFNREdQVV9TWU5DX05F
X09XTkVSLCBvd25lcik7Cj4+ICvCoMKgwqAgcmV0dXJuIGFtZGdwdV9zeW5jX3Jlc3YocC0+YWRl
diwgJnAtPmpvYi0+c3luYywgcmVzdiwgc3luY19tb2RlLCAKPj4gcC0+dm0pOwo+PiDCoCB9Cj4+
IMKgIMKgIC8qKgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0
cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
