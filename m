Return-Path: <SRS0=M7yn=F4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57B5CC433E0
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Dec 2020 22:44:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12C212225E
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Dec 2020 22:44:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12C212225E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 58F5389BFD;
	Thu, 24 Dec 2020 22:44:12 +0000 (UTC)
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD1D489BFD
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Dec 2020 22:44:11 +0000 (UTC)
Received: from [192.168.1.11]
 (dynamic-089-014-200-038.89.14.pool.telefonica.de [89.14.200.38])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id 443AE2000C03F;
 Thu, 24 Dec 2020 23:44:10 +0100 (CET)
Subject: Re: [PATCH] drm/amdgpu: reduce the full access time by about 50ms
To: Peng Zhou <PengJu.Zhou@amd.com>
References: <20201224060434.18144-1-PengJu.Zhou@amd.com>
From: Paul Menzel <pmenzel@molgen.mpg.de>
Message-ID: <d35f603a-dbbe-fba4-c1c5-79b4f00e3ccd@molgen.mpg.de>
Date: Thu, 24 Dec 2020 23:44:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20201224060434.18144-1-PengJu.Zhou@amd.com>
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
Cc: Alexander Deucher <Alexander.Deucher@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

RGVhciBQZW5nIEp1LAoKClRoYW5rIHlvdSBmb3IgeW91ciBwYXRjaC4KCkFtIDI0LjEyLjIwIHVt
IDA3OjA0IHNjaHJpZWIgcGVuZ3pob3U6CgpDb3VsZCB5b3UgcGxlYXNlIGNvbmZpZ3VyZSB5b3Vy
IG5hbWUgaW4gZ2l0OgoKICAgICBnaXQgY29uZmlnIC0tZ2xvYmFsIHVzZXIubmFtZSAiUGVuZyBa
aG91IiAjIG9yIFBlbmcgSnUgWmhvdQoKQWxzbywgcGxlYXNlIG1lbnRpb24gUFNQIGluIHNvbWUg
d2F5IGluIHRoZSBnaXQgY29tbWl0IG1lc3NhZ2Ugc3VtbWFyeS4gCk1heWJlOgoKID4gZHJtL2Ft
ZGdwdTogUmVkdWNlIGRlbGF5IGluIFBTUCBjb21tYW5kIHN1Ym1pdCBieSDigKYKCj4gVGhlIGZ1
bmN0aW9uIG1zbGVlcCgxKSBjYW4gYmUgZGVsYXkgdG8gMTArIG1zIHNvbWV0aW1lcywKPiB3aGlj
aCBjb250cmlidXRlcyBhIGJpZyBkZWxheSBkdXJpbmcgdGhlIGZ1bGwgYWNjZXNzIHRpbWUuCgpE
byB5b3UgaGF2ZSB0aGUgTGludXggbG9nIG1lc3NhZ2VzIHdpdGggdGltZXN0YW1wcywgd2hlcmUg
dGhlIGRlbGF5IGNhbiAKYmUgc2Vlbj8KCj4gQ2hhbmdpbmcgbXNsZWVwKDEpIHRvIHVzbGVlcF9y
YW5nZSgxMCwgMTAwKQo+IGFuZCBpdCBjYW4gcmVkdWNlIGFib3V0IDUwbXMgZGVsYXkgZHVyaW5n
IGZ1bGwgYWNjZXNzIHRpbWUuCgooUGxlYXNlIHdyYXAgbGluZXMgYWZ0ZXIgNzUgY2hhcmFjdGVy
cy4pCgpgdXNsZWVwX3JhbmdlKDEwLCAxMDApYCBpcyAxMDAgzrxzIHdoaWNoIGlzIGxlc3MgdGhl
biAxIG1zICg9IDEuMDAwIM68cykuIApXaGF0IGRhdGFzaGVldCBzcGVjaWZpZXMgdGhlIG5lZWRl
ZCBkZWxheXM/Cgo+IFNpZ25lZC1vZmYtYnk6IHBlbmd6aG91IDxQZW5nSnUuWmhvdUBhbWQuY29t
Pgo+IENoYW5nZS1JZDogSTE1MWEwN2M1NTA2OGQ1YzQyOTU1M2VmMGU2NjY4ZjAyNGMwYzBmM2QK
PiAtLS0KPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9wc3AuYyB8IDIgKy0K
PiAgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQo+IAo+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcHNwLmMgYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcHNwLmMKPiBpbmRleCA1MjNkMjJkYjA5NGIu
LmVmNjkwNTE2ODFjZiAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfcHNwLmMKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcHNw
LmMKPiBAQCAtMjgyLDcgKzI4Miw3IEBAIHBzcF9jbWRfc3VibWl0X2J1ZihzdHJ1Y3QgcHNwX2Nv
bnRleHQgKnBzcCwKPiAgIAkJcmFzX2ludHIgPSBhbWRncHVfcmFzX2ludHJfdHJpZ2dlcmVkKCk7
Cj4gICAJCWlmIChyYXNfaW50cikKPiAgIAkJCWJyZWFrOwo+IC0JCW1zbGVlcCgxKTsKPiArCQl1
c2xlZXBfcmFuZ2UoMTAsIDEwMCk7CgpXaXRoIGB0aW1lb3V0ID0gMjAwMGAsIHRoaXMgd2FzIGEg
bWF4aW11bSBvZiB0d28gc2Vjb25kcyAob3IgZXZlbiAyMCAKc2Vjb25kcyBqdWRnaW5nIGZyb20g
eW91ciBjb21taXQgbWVzc2FnZSkuIFdpdGggeW91ciBjaGFuZ2UgaXQgc2VlbXMgdGhlIAp3YWl0
aW5nIHRpbWUgaXMgcmVkdWNlZCB0byAwLjIgc2Vjb25kcy4KCkkgZG8gbm90IHVuZGVyc3RhbmQs
IGhvdyB5b3UgcmVhY2ggNTAgbXMgaW4gdGhlIGNvbW1pdCBtZXNzYWdlIHRpdGxlPyAKT25seSBp
ZiB0aGUgbXNsZWVwIHdvdWxkIHRha2UgNTAgbXMsIHdoaWNoIGlzIHVubGlrZWx5LgoKPiAgIAkJ
YW1kZ3B1X2FzaWNfaW52YWxpZGF0ZV9oZHAocHNwLT5hZGV2LCBOVUxMKTsKPiAgIAl9CgpJdOKA
mXMgZ3JlYXQgdG8gc2VlIHRoZXNlIGtpbmQgb2Ygb3B0aW1pemF0aW9ucywgYXMgYW1kZ3B1IHRh
a2VzIDQwMCBtcyB0byAKbG9hZCBvbiBteSBzeXN0ZW0uCgpJbiBhIGZvbGxvd3VwIHRoZSBsb2dn
aW5nIHNob3VsZCBiZSBpbXByb3ZlZCB0b28uIE1heWJlLCBwcmludCBhIAp3YXJuaW5nLCBzaG91
bGQgaXQgdGFrZSBsb25nZXIgdGhhbiBmaXZlIG1pbGxpc2Vjb25kcy4KCkkgdGVzdGVkIHRoYXQg
aXQgc3RpbGwgYm9vdHMgb24gbXkgTVNJIEIzNTBNIE1PUlRBUiAoTVMtN0EzNykgd2l0aCBBTUQg
ClJ5emVuIDMgMjIwMEcsIGJ1dCBjb3VsZG7igJl0IGRldGVybWluZSBpZiB0aGUgcGF0Y2ggaW1w
cm92ZWQgdGhlIGJvb3QgCnRpbWUgaW4gYW55d2F5IGR1ZSB0byBhYnNlbnQgbG9nZ2luZy4KCgpL
aW5kIHJlZ2FyZHMsCgpQYXVsCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Au
b3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdm
eAo=
