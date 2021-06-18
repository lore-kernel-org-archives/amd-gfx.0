Return-Path: <SRS0=S25v=LM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B1FCC48BDF
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Jun 2021 16:50:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF932613E2
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Jun 2021 16:50:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF932613E2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daenzer.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4017F6EA3F;
	Fri, 18 Jun 2021 16:50:22 +0000 (UTC)
Received: from netline-mail3.netline.ch (mail.netline.ch [148.251.143.180])
 by gabe.freedesktop.org (Postfix) with ESMTP id 6ABB16EA3F
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Jun 2021 16:50:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by netline-mail3.netline.ch (Postfix) with ESMTP id 6CDE520201D;
 Fri, 18 Jun 2021 18:50:18 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at netline-mail3.netline.ch
Received: from netline-mail3.netline.ch ([127.0.0.1])
 by localhost (netline-mail3.netline.ch [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id cucM8Us7qrYg; Fri, 18 Jun 2021 18:50:17 +0200 (CEST)
Received: from thor (24.99.2.85.dynamic.wline.res.cust.swisscom.ch
 [85.2.99.24])
 by netline-mail3.netline.ch (Postfix) with ESMTPA id CED0620201C;
 Fri, 18 Jun 2021 18:50:17 +0200 (CEST)
Received: from localhost ([::1]) by thor with esmtp (Exim 4.94.2)
 (envelope-from <michel@daenzer.net>)
 id 1luHhA-000B5m-GA; Fri, 18 Jun 2021 18:50:16 +0200
To: =?UTF-8?Q?=c5=81ukasz_Bartosik?= <lb@semihalf.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Christian Koenig <christian.koenig@amd.com>
References: <20210617081843.26987-1-lb@semihalf.com>
 <99e54dc1-d73c-1cef-a062-f46bcff3a74e@daenzer.net>
 <CAK8ByeJWnXAbJVDtmMAfW1hQ6SzzfTUiK96pTU1=cQxVCNQJCw@mail.gmail.com>
From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>
Subject: Re: [PATCH v1] drm/amdgpu: fix framebuffer memory use after free
Message-ID: <07f1504f-1c89-b6be-c5ea-760e2bd85d82@daenzer.net>
Date: Fri, 18 Jun 2021 18:50:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAK8ByeJWnXAbJVDtmMAfW1hQ6SzzfTUiK96pTU1=cQxVCNQJCw@mail.gmail.com>
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

T24gMjAyMS0wNi0xOCAxMDo0NiBhLm0uLCDFgXVrYXN6IEJhcnRvc2lrIHdyb3RlOgo+IGN6dy4s
IDE3IGN6ZSAyMDIxIG8gMTY6MTggTWljaGVsIETDpG56ZXIgPG1pY2hlbEBkYWVuemVyLm5ldD4g
bmFwaXNhxYIoYSk6Cj4+Cj4+IE9uIDIwMjEtMDYtMTcgMTA6MTggYS5tLiwgTHVrYXN6IEJhcnRv
c2lrIHdyb3RlOgo+Pj4gV2l0aCBvcHRpb24gQ09ORklHX0RFQlVHX0xJU1QgZW5hYmxlZCB0aGUg
a2VybmVsIGxvZ3Mgc2hvdyBsaXN0X2FkZAo+Pj4gY29ycnVwdGlvbiB3YXJuaW5nLiBUaGUgd2Fy
bmluZyBvcmlnaW5hdGVzIGZyb20gZHJtX2ZyYW1lYnVmZmVyX2luaXQoKQo+Pj4gZnVuY3Rpb24g
d2hpY2ggYWRkcyBmcmFtZWJ1ZmZlciB0byBhIGZyYW1lYnVmZmVycyBsaXN0IGFuZCBpcyBjYWxs
ZWQgYnkKPj4+IGFtZGdwdV9kaXNwbGF5X2dlbV9mYl92ZXJpZnlfYW5kX2luaXQoKS4KPj4+IElm
IGFtZGdwdV9kaXNwbGF5X2dlbV9mYl92ZXJpZnlfYW5kX2luaXQoKSBlbmNvdW50ZXJzIGFuIGVy
cm9yIGFmdGVyCj4+PiBjYWxsaW5nIGRybV9mcmFtZWJ1ZmZlcl9pbml0KCkgdGhlbiBmcmFtZWJ1
ZmZlciBtZW1vcnkgaXMgcmVsZWFzZWQKPj4+IGluIGFtZGdwdV9kaXNwbGF5X3VzZXJfZnJhbWVi
dWZmZXJfY3JlYXRlKCkgd2l0aG91dCByZW1vdmluZyBmcmFtZWJ1ZmZlcgo+Pj4gZnJvbSB0aGUg
bGlzdCB3aGVyZSBpdCB3YXMgYWRkZWQuIFJldXNlIG9mIHRoYXQgbWVtb3J5IGJ5IGFueSBvdGhl
cgo+Pj4gcGFydHkgY2F1c2UgY29ycnVwdGlvbiBvZiB0aGUgZnJhbWVidWZmZXJzIGxpbmtlZCBs
aXN0LiBUaGlzIGZpeCByZW1vdmVzCj4+PiBmcmFtZWJ1ZmZlciBmcm9tIHRoZSBsaW5rZWQgbGlz
dCBhbmQgdW5yZWdpc3RlcnMgaXQgaW4gY2FzZSBvZiBmYWlsdXJlLgo+Pj4KPj4+IFsuLi5dCj4+
Pgo+Pj4gRml4ZXM6IDZlZWQ5NWIwMGI0NSAoImRybS9hbWQvZGlzcGxheTogU3RvcmUgdGlsaW5n
X2ZsYWdzIGluIHRoZSBmcmFtZWJ1ZmZlci4iKQo+Pgo+PiBJIGRpZG4ndCByZWFsaXplIHRoZXJl
IHdhcyBhbHJlYWR5IGFuIGlzc3VlIGJlZm9yZSBmMjU4OTA3ZmRkODM1ZSAiZHJtL2FtZGdwdTog
VmVyaWZ5IGJvIHNpemUgY2FuIGZpdCBmcmFtZWJ1ZmZlciBzaXplIG9uIGluaXQuIi4gTG9va2lu
ZyBhdAo+PiB0aGUgR2l0IGhpc3RvcnkgYWdhaW4sIEkgYWdyZWUgdGhlcmUncyBhbHJlYWR5IGF0
IGxlYXN0IGEgdGhlb3JldGljYWwgaXNzdWUgaW4gNS4xMSwgdGhvdWdoIEkgc3VzcGVjdCBpdCdz
IGhhcmRlciB0byBoaXQgaW4gcHJhY3RpY2UuCj4+Cj4+Cj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rpc3BsYXkuYyBiL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV9kaXNwbGF5LmMKPj4+IGluZGV4IGMxMzk4NWZiMzViZS4uOTMzMTkw
MjgxYjkxIDEwMDY0NAo+Pj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X2Rpc3BsYXkuYwo+Pj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rp
c3BsYXkuYwo+Pj4gQEAgLTEwODUsMTQgKzEwODUsMTcgQEAgaW50IGFtZGdwdV9kaXNwbGF5X2dl
bV9mYl92ZXJpZnlfYW5kX2luaXQoCj4+PiAgICAgICAgICAgICAgICAgICAgICAgICAgIG1vZGVf
Y21kLT5tb2RpZmllclswXSk7Cj4+Pgo+Pj4gICAgICAgICAgICAgICByZXQgPSAtRUlOVkFMOwo+
Pj4gLSAgICAgICAgICAgICBnb3RvIGVycjsKPj4+ICsgICAgICAgICAgICAgZ290byBlcnJfZmJf
Y2xlYW51cDsKPj4+ICAgICAgIH0KPj4+Cj4+PiAgICAgICByZXQgPSBhbWRncHVfZGlzcGxheV9m
cmFtZWJ1ZmZlcl9pbml0KGRldiwgcmZiLCBtb2RlX2NtZCwgb2JqKTsKPj4+ICAgICAgIGlmIChy
ZXQpCj4+PiAtICAgICAgICAgICAgIGdvdG8gZXJyOwo+Pj4gKyAgICAgICAgICAgICBnb3RvIGVy
cl9mYl9jbGVhbnVwOwo+Pj4KPj4+ICAgICAgIHJldHVybiAwOwo+Pj4gK2Vycl9mYl9jbGVhbnVw
Ogo+Pj4gKyAgICAgZHJtX2ZyYW1lYnVmZmVyX3VucmVnaXN0ZXJfcHJpdmF0ZSgmcmZiLT5iYXNl
KTsKPj4+ICsgICAgIGRybV9mcmFtZWJ1ZmZlcl9jbGVhbnVwKCZyZmItPmJhc2UpOwo+Pj4gIGVy
cjoKPj4+ICAgICAgIGRybV9kYmdfa21zKGRldiwgIkZhaWxlZCB0byB2ZXJpZnkgYW5kIGluaXQg
Z2VtIGZiOiAlZFxuIiwgcmV0KTsKPj4+ICAgICAgIHJmYi0+YmFzZS5vYmpbMF0gPSBOVUxMOwo+
Pj4KPj4KPj4gVGhlcmUncyBhIHNpbWlsYXIgaXNzdWUgaW4gYW1kZ3B1X2Rpc3BsYXlfZ2VtX2Zi
X2luaXQuIGh0dHBzOi8vcGF0Y2h3b3JrLmZyZWVkZXNrdG9wLm9yZy9wYXRjaC80Mzk1NDIvIGZp
eGVzIHRoYXQgYXMgd2VsbCwgYW5kIHNlZW1zIHNpbXBsZXIgKHRob3VnaCBJJ20gYmlhc2VkIG9i
dmlvdXNseSA6KS4KPiAKPiBJIGFncmVlIHlvdXIgcGF0Y2ggaXMgc2ltcGxlciBhbmQgY292ZXJz
IG1vcmUgY2FzZXMsIGJ1dCBJTUhPIG15Cj4gYXBwcm9hY2ggd2l0aCBleHBsaWNpdCBmcmFtZWJ1
ZmZlciBjbGVhbnVwIGhhcyB0aGUgYWR2YW50YWdlCj4gdGhhdCBpdCB3aWxsIGJlIGhhcmQgdG8g
bWlzcyBpbiBjYXNlIG9mIGZ1dHVyZSBjb2RlIHJlb3JnYW5pemF0aW9ucyBpbgo+IHRoYXQgYXJl
YS4KCkZhaXIgZW5vdWdoLgoKRldJVywgSSB3ZW50IHRoZSAiY2FsbCBkcm1fZnJhbWVidWZmZXJf
aW5pdCBsYXN0IiByb3V0ZSBiZWNhdXNlIGl0IG1hdGNoZXMgd2hhdCBhbGwgb3RoZXIgZHJpdmVy
cyBkbyBBRkFJQ1QuCgoKLS0gCkVhcnRobGluZyBNaWNoZWwgRMOkbnplciAgICAgICAgICAgICAg
IHwgICAgICAgICAgICAgICBodHRwczovL3JlZGhhdC5jb20KTGlicmUgc29mdHdhcmUgZW50aHVz
aWFzdCAgICAgICAgICAgICB8ICAgICAgICAgICAgIE1lc2EgYW5kIFggZGV2ZWxvcGVyCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGlu
ZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRl
c2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
