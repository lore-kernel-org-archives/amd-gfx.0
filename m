Return-Path: <SRS0=/AY/=LL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7C9EC2B9F4
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Jun 2021 14:18:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DAA7A613A9
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Jun 2021 14:18:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAA7A613A9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daenzer.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A73D26E8C8;
	Thu, 17 Jun 2021 14:18:31 +0000 (UTC)
Received: from netline-mail3.netline.ch (mail.netline.ch [148.251.143.180])
 by gabe.freedesktop.org (Postfix) with ESMTP id DB83D6E8C8
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Jun 2021 14:18:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by netline-mail3.netline.ch (Postfix) with ESMTP id 81EEA20201B;
 Thu, 17 Jun 2021 16:18:29 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at netline-mail3.netline.ch
Received: from netline-mail3.netline.ch ([127.0.0.1])
 by localhost (netline-mail3.netline.ch [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id MohyGeKJQuLu; Thu, 17 Jun 2021 16:18:29 +0200 (CEST)
Received: from thor (24.99.2.85.dynamic.wline.res.cust.swisscom.ch
 [85.2.99.24])
 by netline-mail3.netline.ch (Postfix) with ESMTPA id EF35720201A;
 Thu, 17 Jun 2021 16:18:28 +0200 (CEST)
Received: from localhost ([::1]) by thor with esmtp (Exim 4.94.2)
 (envelope-from <michel@daenzer.net>)
 id 1ltsqh-0002lm-U4; Thu, 17 Jun 2021 16:18:27 +0200
To: Lukasz Bartosik <lb@semihalf.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Christian Koenig <christian.koenig@amd.com>
References: <20210617081843.26987-1-lb@semihalf.com>
From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>
Subject: Re: [PATCH v1] drm/amdgpu: fix framebuffer memory use after free
Message-ID: <99e54dc1-d73c-1cef-a062-f46bcff3a74e@daenzer.net>
Date: Thu, 17 Jun 2021 16:18:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210617081843.26987-1-lb@semihalf.com>
Content-Language: en-CA
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
Cc: upstream@semihalf.com, amd-gfx@lists.freedesktop.org,
 Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gMjAyMS0wNi0xNyAxMDoxOCBhLm0uLCBMdWthc3ogQmFydG9zaWsgd3JvdGU6Cj4gV2l0aCBv
cHRpb24gQ09ORklHX0RFQlVHX0xJU1QgZW5hYmxlZCB0aGUga2VybmVsIGxvZ3Mgc2hvdyBsaXN0
X2FkZAo+IGNvcnJ1cHRpb24gd2FybmluZy4gVGhlIHdhcm5pbmcgb3JpZ2luYXRlcyBmcm9tIGRy
bV9mcmFtZWJ1ZmZlcl9pbml0KCkKPiBmdW5jdGlvbiB3aGljaCBhZGRzIGZyYW1lYnVmZmVyIHRv
IGEgZnJhbWVidWZmZXJzIGxpc3QgYW5kIGlzIGNhbGxlZCBieQo+IGFtZGdwdV9kaXNwbGF5X2dl
bV9mYl92ZXJpZnlfYW5kX2luaXQoKS4KPiBJZiBhbWRncHVfZGlzcGxheV9nZW1fZmJfdmVyaWZ5
X2FuZF9pbml0KCkgZW5jb3VudGVycyBhbiBlcnJvciBhZnRlcgo+IGNhbGxpbmcgZHJtX2ZyYW1l
YnVmZmVyX2luaXQoKSB0aGVuIGZyYW1lYnVmZmVyIG1lbW9yeSBpcyByZWxlYXNlZAo+IGluIGFt
ZGdwdV9kaXNwbGF5X3VzZXJfZnJhbWVidWZmZXJfY3JlYXRlKCkgd2l0aG91dCByZW1vdmluZyBm
cmFtZWJ1ZmZlcgo+IGZyb20gdGhlIGxpc3Qgd2hlcmUgaXQgd2FzIGFkZGVkLiBSZXVzZSBvZiB0
aGF0IG1lbW9yeSBieSBhbnkgb3RoZXIKPiBwYXJ0eSBjYXVzZSBjb3JydXB0aW9uIG9mIHRoZSBm
cmFtZWJ1ZmZlcnMgbGlua2VkIGxpc3QuIFRoaXMgZml4IHJlbW92ZXMKPiBmcmFtZWJ1ZmZlciBm
cm9tIHRoZSBsaW5rZWQgbGlzdCBhbmQgdW5yZWdpc3RlcnMgaXQgaW4gY2FzZSBvZiBmYWlsdXJl
Lgo+IAo+IFsuLi5dCj4gCj4gRml4ZXM6IDZlZWQ5NWIwMGI0NSAoImRybS9hbWQvZGlzcGxheTog
U3RvcmUgdGlsaW5nX2ZsYWdzIGluIHRoZSBmcmFtZWJ1ZmZlci4iKQoKSSBkaWRuJ3QgcmVhbGl6
ZSB0aGVyZSB3YXMgYWxyZWFkeSBhbiBpc3N1ZSBiZWZvcmUgZjI1ODkwN2ZkZDgzNWUgImRybS9h
bWRncHU6IFZlcmlmeSBibyBzaXplIGNhbiBmaXQgZnJhbWVidWZmZXIgc2l6ZSBvbiBpbml0LiIu
IExvb2tpbmcgYXQgCnRoZSBHaXQgaGlzdG9yeSBhZ2FpbiwgSSBhZ3JlZSB0aGVyZSdzIGFscmVh
ZHkgYXQgbGVhc3QgYSB0aGVvcmV0aWNhbCBpc3N1ZSBpbiA1LjExLCB0aG91Z2ggSSBzdXNwZWN0
IGl0J3MgaGFyZGVyIHRvIGhpdCBpbiBwcmFjdGljZS4KCgo+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGlzcGxheS5jIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X2Rpc3BsYXkuYwo+IGluZGV4IGMxMzk4NWZiMzViZS4uOTMzMTkwMjgx
YjkxIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kaXNw
bGF5LmMKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGlzcGxheS5j
Cj4gQEAgLTEwODUsMTQgKzEwODUsMTcgQEAgaW50IGFtZGdwdV9kaXNwbGF5X2dlbV9mYl92ZXJp
ZnlfYW5kX2luaXQoCj4gIAkJCSAgICBtb2RlX2NtZC0+bW9kaWZpZXJbMF0pOwo+ICAKPiAgCQly
ZXQgPSAtRUlOVkFMOwo+IC0JCWdvdG8gZXJyOwo+ICsJCWdvdG8gZXJyX2ZiX2NsZWFudXA7Cj4g
IAl9Cj4gIAo+ICAJcmV0ID0gYW1kZ3B1X2Rpc3BsYXlfZnJhbWVidWZmZXJfaW5pdChkZXYsIHJm
YiwgbW9kZV9jbWQsIG9iaik7Cj4gIAlpZiAocmV0KQo+IC0JCWdvdG8gZXJyOwo+ICsJCWdvdG8g
ZXJyX2ZiX2NsZWFudXA7Cj4gIAo+ICAJcmV0dXJuIDA7Cj4gK2Vycl9mYl9jbGVhbnVwOgo+ICsJ
ZHJtX2ZyYW1lYnVmZmVyX3VucmVnaXN0ZXJfcHJpdmF0ZSgmcmZiLT5iYXNlKTsKPiArCWRybV9m
cmFtZWJ1ZmZlcl9jbGVhbnVwKCZyZmItPmJhc2UpOwo+ICBlcnI6Cj4gIAlkcm1fZGJnX2ttcyhk
ZXYsICJGYWlsZWQgdG8gdmVyaWZ5IGFuZCBpbml0IGdlbSBmYjogJWRcbiIsIHJldCk7Cj4gIAly
ZmItPmJhc2Uub2JqWzBdID0gTlVMTDsKPiAKClRoZXJlJ3MgYSBzaW1pbGFyIGlzc3VlIGluIGFt
ZGdwdV9kaXNwbGF5X2dlbV9mYl9pbml0LiBodHRwczovL3BhdGNod29yay5mcmVlZGVza3RvcC5v
cmcvcGF0Y2gvNDM5NTQyLyBmaXhlcyB0aGF0IGFzIHdlbGwsIGFuZCBzZWVtcyBzaW1wbGVyICh0
aG91Z2ggSSdtIGJpYXNlZCBvYnZpb3VzbHkgOikuCgoKTmVpdGhlciBwYXRjaCBjYW4gYmUgdHJp
dmlhbGx5IGNoZXJyeSBwaWNrZWQgZm9yIGZpeGluZyB0aGUgaXNzdWUgaW4gNS4xMS81LjEyIGR1
ZSB0byBmMjU4OTA3ZmRkODM1ZS4KCgotLSAKRWFydGhsaW5nIE1pY2hlbCBEw6RuemVyICAgICAg
ICAgICAgICAgfCAgICAgICAgICAgICAgIGh0dHBzOi8vcmVkaGF0LmNvbQpMaWJyZSBzb2Z0d2Fy
ZSBlbnRodXNpYXN0ICAgICAgICAgICAgIHwgICAgICAgICAgICAgTWVzYSBhbmQgWCBkZXZlbG9w
ZXIKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdm
eCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0
cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
