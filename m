Return-Path: <SRS0=EB5G=BJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19B71C433E0
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jul 2020 11:48:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF5BF20838
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jul 2020 11:48:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vJ3UftjO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF5BF20838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC8BF6E1B9;
	Thu, 30 Jul 2020 11:48:57 +0000 (UTC)
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com
 [IPv6:2a00:1450:4864:20::543])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 57EA56E1B9
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jul 2020 11:48:56 +0000 (UTC)
Received: by mail-ed1-x543.google.com with SMTP id bs17so958360edb.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jul 2020 04:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=D5WuxvwvY4n2gozu6LJ4y96kVJ9eFfZPgImcF3mo7L4=;
 b=vJ3UftjO9sxQ5Hp+XVPrSxLU4oIxKBTviEtFWscjY/dlZ96puYHoohiXht+P59rNVP
 shhXLcpgeh5z1NBG0S3+hClNlX+QU3HWm8JWyoumCCBDT9uXPlpSa/9us8iYZyVcXHlT
 Fy9rI7sMZxVYDHH4qN494efy9mSUoOqRzuwQdBMDMEI6nIfvpYVpRdE7MxTLax0Xnt/E
 RmpHEd14EwIvVODdfBLob7uWJVMidYYD1NJrvKA/k5Ko7mdAtEJLMeZpBb5v3+apHO0a
 EuIddyLXXvLn99sjCNNNP3s9xnjOG7x19vNPhWbxUBa/bMygZRKuQFBhSa7G4SF0CDdJ
 CabQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=D5WuxvwvY4n2gozu6LJ4y96kVJ9eFfZPgImcF3mo7L4=;
 b=Yeoe3TR+zxpsEre/RFoa6Zv9URM7S1UeF2WHJDsQUsaWvngtrX1tzHP1PLX12KOy3e
 73PRTs7zdnrbpi42SwkN6IFNRnP7CvYHkFWFy0F6zDlbnHDQJ876O36a9GoGqaI8JdVm
 UZbtrZ8n2SPyMqzbMB1d4E5xZNtBODRbB/t7Zn0RH6VCHqFnmh5nuGLKwNkbSJ9PknAy
 EQISV924pCoYtUS5/Z+143ZGB9uU10K/g8sC5wd65ii3XZWwrkLL21UY4BfQHOgIPO8j
 8lW+Fc4P0kreFrZPbZk3RahguTmdGsx7GGsPtpFIlny22p81kzcIQN+w9wtCosxR4t7y
 2C+A==
X-Gm-Message-State: AOAM533zSPYCOrooMnrIUlPk1DCob4Ly7liGNKkvpXHN4UXCkplCIb0Q
 tc/of+MjH/JcVj6jixuFpgNqD7zZ
X-Google-Smtp-Source: ABdhPJyAGY9YTrkqawfxD/dHuE43uIGt7defoNBGJITTi7AcM69HpvpVNfAee1cvUVIaexPX1ixnOQ==
X-Received: by 2002:aa7:db08:: with SMTP id t8mr2330362eds.36.1596109734624;
 Thu, 30 Jul 2020 04:48:54 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id s4sm5581918ejx.94.2020.07.30.04.48.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Jul 2020 04:48:50 -0700 (PDT)
Subject: Re: [PATCH] drm/amdgpu: new ids flag for tmz
To: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 christian.koenig@amd.com, amd-gfx@lists.freedesktop.org
References: <20200730102500.23479-1-pierre-eric.pelloux-prayer@amd.com>
 <b3a50466-04e1-29ef-b0f2-90d26a282805@gmail.com>
 <1cc3c73c-9f02-9e84-d1e6-03b96c83e9ca@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <c1c953a6-dcd5-f01c-b7d0-f624ffac043f@gmail.com>
Date: Thu, 30 Jul 2020 13:48:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1cc3c73c-9f02-9e84-d1e6-03b96c83e9ca@amd.com>
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

QW0gMzAuMDcuMjAgdW0gMTI6NTkgc2NocmllYiBQaWVycmUtRXJpYyBQZWxsb3V4LVByYXllcjoK
PiBIaSBDaHJpc3RpYW4sCj4KPiBPbiAzMC8wNy8yMDIwIDEyOjMwLCBDaHJpc3RpYW4gS8O2bmln
IHdyb3RlOgo+PiBBbSAzMC4wNy4yMCB1bSAxMjoyNSBzY2hyaWViIFBpZXJyZS1FcmljIFBlbGxv
dXgtUHJheWVyOgo+Pj4gQWxsb3dzIFVNRCB0byBrbm93IGlmIFRNWiBpcyBzdXBwb3J0ZWQgYW5k
IGVuYWJsZWQuCj4+PiBUaGlzIGNvbW1pdCBhbHNvIGJ1bXBzIEtNU19EUklWRVJfTUlOT1Igc28g
VU1EIGtub3dzIGlmIGl0IGNhbiByZWx5IG9uCj4+PiBBTURHUFVfSURTX0ZMQUdTX1RNWi4KPj4+
IC0tLQo+Pj4gUGF0Y2ggZm9yIHVzaW5nIGl0IGluIE1lc2EgaXMgYXQgaHR0cHM6Ly9naXRsYWIu
ZnJlZWRlc2t0b3Aub3JnL21lc2EvbWVzYS8tL21lcmdlX3JlcXVlc3RzLzYwNDkKPj4+IChhYy9n
cHVfaW5mbzogYWRkIGRldGVjdGlvbiBvZiBUTVogc3VwcG9ydCkuCj4+Pgo+Pj4gUGllcnJlLUVy
aWMKPj4+Cj4+PiAgwqAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rydi5jIHwg
MyArKy0KPj4+ICDCoCBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfa21zLmMgfCAy
ICsrCj4+PiAgwqAgaW5jbHVkZS91YXBpL2RybS9hbWRncHVfZHJtLmjCoMKgwqDCoMKgwqDCoMKg
wqDCoCB8IDEgKwo+Pj4gIMKgIDMgZmlsZXMgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspLCAxIGRl
bGV0aW9uKC0pCj4+Pgo+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV9kcnYuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kcnYuYwo+
Pj4gaW5kZXggNjI5MWY1ZjBkMjIzLi42ZGNhYjI1OTE0Y2YgMTAwNjQ0Cj4+PiAtLS0gYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZHJ2LmMKPj4+ICsrKyBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kcnYuYwo+Pj4gQEAgLTg4LDkgKzg4LDEwIEBACj4+PiAg
wqDCoCAqIC0gMy4zNy4wIC0gTDIgaXMgaW52YWxpZGF0ZWQgYmVmb3JlIFNETUEgSUJzLCBuZWVk
ZWQgZm9yIGNvcnJlY3RuZXNzCj4+PiAgwqDCoCAqIC0gMy4zOC4wIC0gQWRkIEFNREdQVV9JQl9G
TEFHX0VNSVRfTUVNX1NZTkMKPj4+ICDCoMKgICogLSAzLjM5LjAgLSBETUFCVUYgaW1wbGljaXQg
c3luYyBkb2VzIGEgZnVsbCBwaXBlbGluZSBzeW5jCj4+PiArICogLSAzLjQwLjAgLSBBZGQgQU1E
R1BVX0lEU19GTEFHU19UTVoKPj4+ICDCoMKgICovCj4+PiAgwqAgI2RlZmluZSBLTVNfRFJJVkVS
X01BSk9SwqDCoMKgIDMKPj4+IC0jZGVmaW5lIEtNU19EUklWRVJfTUlOT1LCoMKgwqAgMzkKPj4+
ICsjZGVmaW5lIEtNU19EUklWRVJfTUlOT1LCoMKgwqAgNDAKPj4gSSBkb24ndCB0aGluayB3ZSBu
ZWVkIHRoaXMuIFVudXNlZCBpZHNfZmxhZ3Mgc2hvdWxkIGJlIHplcm8gb24gb2xkZXIga2VybmVs
cy4KPiBJZiB3ZSBkb24ndCBpbmNyZWFzZSBLTVNfRFJJVkVSX01JTk9SIHRoZW46Cj4KPiAgICAg
aWRzX2ZsYWdzICYgQU1ER1BVX0lEU19GTEFHU19UTVogPT0gMAo+Cj4gaGFzIDIgbWVhbmluZ3M6
Cj4gICAgLSBUTVogaXMgbm90IGVuYWJsZWQKPiAgICAtIG9yIFRNWiBtaWdodCBiZSBlbmFibGVk
IGJ1dCBpdCdzIG5vdCByZXBvcnRlZCBieSB0aGUga2VybmVsCgpBaCEgWWVhaCB0aGF0J3MgYSBn
b29kIGFyZ3VtZW50LgoKV2UgbmVlZCB0byBub3RlIHRoYXQgaW4gdGhlIGNvbW1pdCBtZXNzYWdl
LgoKQW5kIG1heWJlIGNhbGwgdGhlIGZsYWcgVE1aX0VOQUJMRUQgdG8gbWFrZSBjbGVhciB3aGF0
IHRoaXMgaXMgZ29vZCBmb3IuCgpUaGFua3MsCkNocmlzdGlhbi4KCj4KPiBJZiB5b3UgcHJlZmVy
IG5vdCBidW1waW5nIEtNU19EUklWRVJfTUlOT1IgdGhhdCdzIGZpbmUgdGhvdWdoLiBNZXNhIGNh
biBjaGVjayBpZiBUTVogaXMgcmVhbGx5Cj4gZGlzYWJsZWQgYnkgdHJ5aW5nIHRvIGFsbG9jYXRl
IGEgVE1aIGJ1ZmZlci4KPgo+IFRoYW5rcywKPiBQaWVycmUtRXJpYwo+Cj4+IFRoYXQncyB3aHkg
d2UgaGF2ZSB0aGlzIGluIHRoZSBmaXJzdCBwbGFjZS4KPj4KPj4gQ2hyaXN0aWFuLgo+Pgo+Pj4g
IMKgICNkZWZpbmUgS01TX0RSSVZFUl9QQVRDSExFVkVMwqDCoMKgIDAKPj4+ICDCoCDCoCBpbnQg
YW1kZ3B1X3ZyYW1fbGltaXQgPSAwOwo+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV9rbXMuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV9rbXMuYwo+Pj4gaW5kZXggZWViYmUyMTAzZTMyLi5kOTJlZTMwYmMwNmMgMTAwNjQ0Cj4+PiAt
LS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfa21zLmMKPj4+ICsrKyBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9rbXMuYwo+Pj4gQEAgLTczNiw2ICs3MzYs
OCBAQCBzdGF0aWMgaW50IGFtZGdwdV9pbmZvX2lvY3RsKHN0cnVjdCBkcm1fZGV2aWNlICpkZXYs
IHZvaWQgKmRhdGEsIHN0cnVjdCBkcm1fZmlsZQo+Pj4gIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIGRldl9pbmZvLmlkc19mbGFncyB8PSBBTURHUFVfSURTX0ZMQUdTX0ZVU0lPTjsKPj4+ICDC
oMKgwqDCoMKgwqDCoMKgwqAgaWYgKGFtZGdwdV9tY2JwIHx8IGFtZGdwdV9zcmlvdl92ZihhZGV2
KSkKPj4+ICDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBkZXZfaW5mby5pZHNfZmxhZ3MgfD0g
QU1ER1BVX0lEU19GTEFHU19QUkVFTVBUSU9OOwo+Pj4gK8KgwqDCoMKgwqDCoMKgIGlmIChhZGV2
LT5nbWMudG16X2VuYWJsZWQpCj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBkZXZfaW5mby5p
ZHNfZmxhZ3MgfD0gQU1ER1BVX0lEU19GTEFHU19UTVo7Cj4+PiAgwqAgwqDCoMKgwqDCoMKgwqDC
oMKgIHZtX3NpemUgPSBhZGV2LT52bV9tYW5hZ2VyLm1heF9wZm4gKiBBTURHUFVfR1BVX1BBR0Vf
U0laRTsKPj4+ICDCoMKgwqDCoMKgwqDCoMKgwqAgdm1fc2l6ZSAtPSBBTURHUFVfVkFfUkVTRVJW
RURfU0laRTsKPj4+IGRpZmYgLS1naXQgYS9pbmNsdWRlL3VhcGkvZHJtL2FtZGdwdV9kcm0uaCBi
L2luY2x1ZGUvdWFwaS9kcm0vYW1kZ3B1X2RybS5oCj4+PiBpbmRleCA3NjVhOTRlYzQ0MjAuLmI4
MjZmMmQ2ZWZlMSAxMDA2NDQKPj4+IC0tLSBhL2luY2x1ZGUvdWFwaS9kcm0vYW1kZ3B1X2RybS5o
Cj4+PiArKysgYi9pbmNsdWRlL3VhcGkvZHJtL2FtZGdwdV9kcm0uaAo+Pj4gQEAgLTY3Niw2ICs2
NzYsNyBAQCBzdHJ1Y3QgZHJtX2FtZGdwdV9jc19jaHVua19kYXRhIHsKPj4+ICDCoMKgICovCj4+
PiAgwqAgI2RlZmluZSBBTURHUFVfSURTX0ZMQUdTX0ZVU0lPTsKgwqDCoMKgwqDCoMKgwqAgMHgx
Cj4+PiAgwqAgI2RlZmluZSBBTURHUFVfSURTX0ZMQUdTX1BSRUVNUFRJT07CoMKgwqDCoCAweDIK
Pj4+ICsjZGVmaW5lIEFNREdQVV9JRFNfRkxBR1NfVE1awqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAw
eDQKPj4+ICDCoCDCoCAvKiBpbmRpY2F0ZSBpZiBhY2NlbGVyYXRpb24gY2FuIGJlIHdvcmtpbmcg
Ki8KPj4+ICDCoCAjZGVmaW5lIEFNREdQVV9JTkZPX0FDQ0VMX1dPUktJTkfCoMKgwqDCoMKgwqDC
oCAweDAwCj4+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
Cj4+IGFtZC1nZnggbWFpbGluZyBsaXN0Cj4+IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
Cj4+IGh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdm
eAo+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4gYW1k
LWdmeCBtYWlsaW5nIGxpc3QKPiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+IGh0dHBz
Oi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAoKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5n
IGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVz
a3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
