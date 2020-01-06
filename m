Return-Path: <SRS0=Ai3v=23=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3B7DC33C8C
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Jan 2020 20:22:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83D702072C
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Jan 2020 20:22:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ugS4okPq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83D702072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 359DA6E513;
	Mon,  6 Jan 2020 20:22:00 +0000 (UTC)
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com
 [IPv6:2a00:1450:4864:20::344])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7120F6E513
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Jan 2020 20:21:58 +0000 (UTC)
Received: by mail-wm1-x344.google.com with SMTP id 20so16723118wmj.4
 for <amd-gfx@lists.freedesktop.org>; Mon, 06 Jan 2020 12:21:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=IjuKcvMEkV59798oBXrf/3VnV7Titen+2HRlYjs5cGY=;
 b=ugS4okPqWLPRBll1TN8FN31FovsUBXjcxxRmb3Op/dSx2hdiIfBV2zVzR7eazQiRAh
 q/aKBOrDvJmIx7j+nkffa36emEWiZOPSR+CXhcfh7WR9xVrION3bbfkrejECMirWOSO3
 tC6mhNDKvS+ySbkBHlopuqV1EEkgNjNBTnB/wC1aZ+zJP5mn/VNXSmJ6o5Opu39fq9uD
 xg9mUxIxG0jJ12/oLhagiSnOOKfHyCddwxpCdzlw4VdbCXFeU/8iv5U2iU8QeuYgNkJM
 soJNf0zNwQvhazLL4hwAATkk5ilXYR4FJilNSXLJPIREdqjA72w2BsVeAXcVvZHnEZrU
 tMEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=IjuKcvMEkV59798oBXrf/3VnV7Titen+2HRlYjs5cGY=;
 b=Vcr4deYxh8AmTeQDagsLyZD2yvtLOdMQTAnGCIiPP4ab9lcnAXzpdlJS4pRSTHk6t7
 aSHiayGDdeXiZ59T4MVmeVs65Q1iZ+adDXLy1MF7v9s9tekWns1zuA4hlYGluioQHbFS
 Qad5iQg+DFSpWpq335XcRasWP63okcZ+XB5O3tD7x9b22BZtskGvTDyLZTWXUp+U3yw1
 uscTuMV5OWMzqBaEHRim5fmLYZE7NswVaNPKyQJwe6v2m0w3BdIESchSY+JLHxN3l9yq
 XfzwGK0tIt+ZYULe6TG4PxI1yuq85puWpQy7l84h6Xa74cVkwqoO4su42s1rEBxtvULf
 rmBw==
X-Gm-Message-State: APjAAAWDB0J+Bsm6rRll3nMWk+pg3A4QDZXgvnkeooV+zsfi3KRqK9Qz
 pMvR/BHHz5VaMWHVPu0/+Ss=
X-Google-Smtp-Source: APXvYqx23w7VMwhfQJqnuRXAbz8TEFPNb2JA/xLpiGa5ZuRe+ZAo+/85/tBS0dA5AlNAzNavjdvNEw==
X-Received: by 2002:a1c:6755:: with SMTP id b82mr35403304wmc.126.1578342117133; 
 Mon, 06 Jan 2020 12:21:57 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id e8sm73774439wrt.7.2020.01.06.12.21.56
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 06 Jan 2020 12:21:56 -0800 (PST)
Subject: Re: [PATCH 2/2] drm/amdgpu/gmc10: use common invalidation engine
 helper
To: Felix Kuehling <felix.kuehling@amd.com>,
 Alex Deucher <alexdeucher@gmail.com>, amd-gfx@lists.freedesktop.org
References: <20200106183506.692030-1-alexander.deucher@amd.com>
 <20200106183506.692030-2-alexander.deucher@amd.com>
 <d3d6accb-bc1b-5543-219a-2dbdcedfe997@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <5da03f58-2003-ef65-173a-ebcb17e51467@gmail.com>
Date: Mon, 6 Jan 2020 21:21:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <d3d6accb-bc1b-5543-219a-2dbdcedfe997@amd.com>
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

Tm8gaWRlYSBlaXRoZXIgd2h5IHRoYXQgd2FzIGRvbmUuCgpBbnl3YXkgcGF0Y2ggaXMgQWNrZWQt
Ynk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4uCgpSZWdhcmRz
LApDaHJpc3RpYW4uCgpBbSAwNi4wMS4yMCB1bSAyMDoxNiBzY2hyaWViIEZlbGl4IEt1ZWhsaW5n
Ogo+IFRoaXMgcGF0Y2ggaXMKPgo+IEFja2VkLWJ5OiBGZWxpeCBLdWVobGluZyA8RmVsaXguS3Vl
aGxpbmdAYW1kLmNvbT4KPgo+IEkgZG9uJ3QgcmVhbGx5IGtub3cgd2h5IHRoZSBtYXNrIHdhcyBk
aWZmZXJlbnQgb24gR0ZYdjEwLiBJIHN1c3BlY3QgaXQgCj4gd2FzIGxhemluZXNzL3NpbXBsaWNp
dHkgb2Ygbm90IGhhdmluZyB0aGUgZ2FwIGF0IGVuZ2luZXMgMiwzLiBJZiB3ZSAKPiBkb24ndCBo
YXZlIGFzIG1hbnkgcmluZ3Mgb24gR0ZYdjEwIEFTSUNzIHdlIHByb2JhYmx5IGRvbid0IG5lZWQg
Cj4gZW5naW5lcyAwLDEuCj4KPiBSZWdhcmRzLAo+IMKgIEZlbGl4Cj4KPiBPbiAyMDIwLTAxLTA2
IDE6MzUgcC5tLiwgQWxleCBEZXVjaGVyIHdyb3RlOgo+PiBSYXRoZXIgdGhhbiBvcGVuIGNvZGlu
ZyBpdC7CoCBUaGlzIGFsc28gY2hhbmdlcyB0aGUgZnJlZSBtYXNrcwo+PiB0byBiZXR0ZXIgcmVm
bGVjdCB0aGUgdXNhZ2UgYnkgb3RoZXIgY29tcG9uZW50cy4KPj4KPj4gU2lnbmVkLW9mZi1ieTog
QWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgo+PiAtLS0KPj4KPj4gV2Ug
YWx3YXlzIHN0YXJ0ZWQgYXQgaW52YWxpZGF0aW9uIGVuZ2luZSA0IG9uIGdtYzEwLsKgIFdhcyB0
aGVyZSBhCj4+IHJlYXNvbiBmb3IgdGhhdD/CoCBJIHdvdWxkIGhhdmUgZmlndXJlZCBpdCB3b3Vs
ZCBmb2xsb3cgdGhlIHNhbWUKPj4gbW9kZWwgYXMgb2xkZXIgYXNpY3MuwqAgSSBjYW4gbWFrZSB0
aGlzIG1vcmUgZmxleGlhYmxlIGlmIHNvLgo+Pgo+Pgo+PiDCoCBkcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfZ21jLmMgfMKgIDIgKy0KPj4gwqAgZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvZ21jX3YxMF8wLmPCoCB8IDE5ICsrKystLS0tLS0tLS0tLS0tLS0KPj4gwqAgMiBmaWxl
cyBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDE2IGRlbGV0aW9ucygtKQo+Pgo+PiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dtYy5jIAo+PiBiL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nbWMuYwo+PiBpbmRleCBkNjkwMWIyNzQ3OTAu
LjU4ODRhYjU5MDQ4NiAxMDA2NDQKPj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X2dtYy5jCj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9n
bWMuYwo+PiBAQCAtMzM1LDcgKzMzNSw3IEBAIHZvaWQgYW1kZ3B1X2dtY19yYXNfZmluaShzdHJ1
Y3QgYW1kZ3B1X2RldmljZSAqYWRldikKPj4gwqAgfQo+PiDCoCDCoMKgwqDCoMKgIC8qCj4+IC3C
oMKgwqDCoCAqIFRoZSBsYXRlc3QgZW5naW5lIGFsbG9jYXRpb24gb24gZ2Z4OSBpczoKPj4gK8Kg
wqDCoMKgICogVGhlIGxhdGVzdCBlbmdpbmUgYWxsb2NhdGlvbiBvbiBnZng5LzEwIGlzOgo+PiDC
oMKgwqDCoMKgwqAgKiBFbmdpbmUgMiwgMzogZmlybXdhcmUKPj4gwqDCoMKgwqDCoMKgICogRW5n
aW5lIDAsIDEsIDR+MTY6IGFtZGdwdSByaW5nLAo+PiDCoMKgwqDCoMKgwqAgKsKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHN1YmplY3QgdG8gY2hhbmdlIHdoZW4gcmluZyBu
dW1iZXIgY2hhbmdlcwo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
Z21jX3YxMF8wLmMgCj4+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ21jX3YxMF8wLmMK
Pj4gaW5kZXggZjU3MjUzMzZhNWYyLi5kYTk3NjVmZjQ1ZDYgMTAwNjQ0Cj4+IC0tLSBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dtY192MTBfMC5jCj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2dtY192MTBfMC5jCj4+IEBAIC01NjQsMjIgKzU2NCwxMSBAQCBzdGF0aWMg
aW50IGdtY192MTBfMF9lYXJseV9pbml0KHZvaWQgKmhhbmRsZSkKPj4gwqAgc3RhdGljIGludCBn
bWNfdjEwXzBfbGF0ZV9pbml0KHZvaWQgKmhhbmRsZSkKPj4gwqAgewo+PiDCoMKgwqDCoMKgIHN0
cnVjdCBhbWRncHVfZGV2aWNlICphZGV2ID0gKHN0cnVjdCBhbWRncHVfZGV2aWNlICopaGFuZGxl
Owo+PiAtwqDCoMKgIHVuc2lnbmVkIHZtX2ludl9lbmdbQU1ER1BVX01BWF9WTUhVQlNdID0geyA0
LCA0IH07Cj4+IC3CoMKgwqAgdW5zaWduZWQgaTsKPj4gLQo+PiAtwqDCoMKgIGZvcihpID0gMDsg
aSA8IGFkZXYtPm51bV9yaW5nczsgKytpKSB7Cj4+IC3CoMKgwqDCoMKgwqDCoCBzdHJ1Y3QgYW1k
Z3B1X3JpbmcgKnJpbmcgPSBhZGV2LT5yaW5nc1tpXTsKPj4gLcKgwqDCoMKgwqDCoMKgIHVuc2ln
bmVkIHZtaHViID0gcmluZy0+ZnVuY3MtPnZtaHViOwo+PiAtCj4+IC3CoMKgwqDCoMKgwqDCoCBy
aW5nLT52bV9pbnZfZW5nID0gdm1faW52X2VuZ1t2bWh1Yl0rKzsKPj4gLcKgwqDCoMKgwqDCoMKg
IGRldl9pbmZvKGFkZXYtPmRldiwgInJpbmcgJXUoJXMpIHVzZXMgVk0gaW52IGVuZyAldSBvbiBo
dWIgCj4+ICV1XG4iLAo+PiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJpbmctPmlkeCwgcmlu
Zy0+bmFtZSwgcmluZy0+dm1faW52X2VuZywKPj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBy
aW5nLT5mdW5jcy0+dm1odWIpOwo+PiAtwqDCoMKgIH0KPj4gK8KgwqDCoCBpbnQgcjsKPj4gwqAg
LcKgwqDCoCAvKiBFbmdpbmUgMTcgaXMgdXNlZCBmb3IgR0FSVCBmbHVzaGVzICovCj4+IC3CoMKg
wqAgZm9yKGkgPSAwOyBpIDwgQU1ER1BVX01BWF9WTUhVQlM7ICsraSkKPj4gLcKgwqDCoMKgwqDC
oMKgIEJVR19PTih2bV9pbnZfZW5nW2ldID4gMTcpOwo+PiArwqDCoMKgIHIgPSBhbWRncHVfZ21j
X2FsbG9jYXRlX3ZtX2ludl9lbmcoYWRldik7Cj4+ICvCoMKgwqAgaWYgKHIpCj4+ICvCoMKgwqDC
oMKgwqDCoCByZXR1cm4gcjsKPj4gwqAgwqDCoMKgwqDCoCByZXR1cm4gYW1kZ3B1X2lycV9nZXQo
YWRldiwgJmFkZXYtPmdtYy52bV9mYXVsdCwgMCk7Cj4+IMKgIH0KPiBfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+IGFtZC1nZnggbWFpbGluZyBsaXN0Cj4g
YW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPiBodHRwczovL2xpc3RzLmZyZWVkZXNrdG9w
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngKCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlz
dGluZm8vYW1kLWdmeAo=
