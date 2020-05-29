Return-Path: <SRS0=sMqH=7L=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87056C433E1
	for <amd-gfx@archiver.kernel.org>; Fri, 29 May 2020 09:56:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2792F20776
	for <amd-gfx@archiver.kernel.org>; Fri, 29 May 2020 09:56:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2792F20776
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daenzer.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C27056E8B4;
	Fri, 29 May 2020 09:56:07 +0000 (UTC)
Received: from netline-mail3.netline.ch (mail.netline.ch [148.251.143.178])
 by gabe.freedesktop.org (Postfix) with ESMTP id AC8516E8B4
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 May 2020 09:56:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by netline-mail3.netline.ch (Postfix) with ESMTP id A11FC2A6042;
 Fri, 29 May 2020 11:56:05 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at netline-mail3.netline.ch
Received: from netline-mail3.netline.ch ([127.0.0.1])
 by localhost (netline-mail3.netline.ch [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id Gl_F7KtVrfNa; Fri, 29 May 2020 11:56:05 +0200 (CEST)
Received: from thor (212.174.63.188.dynamic.wline.res.cust.swisscom.ch
 [188.63.174.212])
 by netline-mail3.netline.ch (Postfix) with ESMTPSA id 0C3D62A6016;
 Fri, 29 May 2020 11:56:04 +0200 (CEST)
Received: from localhost ([::1]) by thor with esmtp (Exim 4.93)
 (envelope-from <michel@daenzer.net>)
 id 1jebkB-0008Gf-KJ; Fri, 29 May 2020 11:56:03 +0200
Subject: Re: [PATCH] drm/amdgpu/pm: don't bail for in_suspend
To: Alex Deucher <alexdeucher@gmail.com>
References: <20200527225158.27756-1-alexander.deucher@amd.com>
From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>
Message-ID: <adf54b19-f620-29e1-0802-cfebb01d4548@daenzer.net>
Date: Fri, 29 May 2020 11:56:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20200527225158.27756-1-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gMjAyMC0wNS0yOCAxMjo1MSBhLm0uLCBBbGV4IERldWNoZXIgd3JvdGU6Cj4gT3RoZXJ3aXNl
IHdlIGRpc2FibGUgc3lzZnMvZGVidWdmcyBhY2Nlc3Mgd2l0aCBydW50aW1lIHBtLgo+IAo+IEZp
eGVzOiBmN2M4ZDg1M2IwMjlkZiAoImRybS9hbWRncHUvcG06IHJldHVybiBhbiBlcnJvciBkdXJp
bmcgR1BVIHJlc2V0IG9yIHN1c3BlbmQiKQo+IFNpZ25lZC1vZmYtYnk6IEFsZXggRGV1Y2hlciA8
YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KPiAtLS0KPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X3BtLmMgfCAxMTQgKysrKysrKysrKysrLS0tLS0tLS0tLS0tLQo+ICAxIGZp
bGUgY2hhbmdlZCwgNTcgaW5zZXJ0aW9ucygrKSwgNTcgZGVsZXRpb25zKC0pCj4gCj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9wbS5jIGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3BtLmMKPiBpbmRleCA4MDg4ODRhYWYzNmQuLjc3NWUz
ODljOWExMyAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
cG0uYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9wbS5jCj4gQEAg
LTE2Myw3ICsxNjMsNyBAQCBzdGF0aWMgc3NpemVfdCBhbWRncHVfZ2V0X3Bvd2VyX2RwbV9zdGF0
ZShzdHJ1Y3QgZGV2aWNlICpkZXYsCj4gIAllbnVtIGFtZF9wbV9zdGF0ZV90eXBlIHBtOwo+ICAJ
aW50IHJldDsKPiAgCj4gLQlpZiAoYWRldi0+aW5fZ3B1X3Jlc2V0IHx8IGFkZXYtPmluX3N1c3Bl
bmQpCj4gKwlpZiAoYWRldi0+aW5fZ3B1X3Jlc2V0KQo+ICAJCXJldHVybiAtRVBFUk07Cj4gIAo+
ICAJcmV0ID0gcG1fcnVudGltZV9nZXRfc3luYyhkZGV2LT5kZXYpOwo+IEBAIC0xOTksNyArMTk5
LDcgQEAgc3RhdGljIHNzaXplX3QgYW1kZ3B1X3NldF9wb3dlcl9kcG1fc3RhdGUoc3RydWN0IGRl
dmljZSAqZGV2LAo+ICAJZW51bSBhbWRfcG1fc3RhdGVfdHlwZSAgc3RhdGU7Cj4gIAlpbnQgcmV0
Owo+ICAKPiAtCWlmIChhZGV2LT5pbl9ncHVfcmVzZXQgfHwgYWRldi0+aW5fc3VzcGVuZCkKPiAr
CWlmIChhZGV2LT5pbl9ncHVfcmVzZXQpCj4gIAkJcmV0dXJuIC1FUEVSTTsKPiAgCj4gIAlpZiAo
c3RybmNtcCgiYmF0dGVyeSIsIGJ1Ziwgc3RybGVuKCJiYXR0ZXJ5IikpID09IDApCgpNaWdodCBi
ZSB3b3J0aCBtb3ZpbmcgdGhpcyBjaGVjayBpbnRvIGEgaGVscGVyIGZ1bmN0aW9uOyB0aGF0IHdv
dWxkIG1ha2UKc2ltaWxhciBjaGFuZ2VzIGVhc2llciBpbiB0aGUgZnV0dXJlLiA6KSBDYW4gYmUg
YSBzZXBhcmF0ZSBjaGFuZ2UsIG9mCmNvdXJzZS4KCgotLSAKRWFydGhsaW5nIE1pY2hlbCBEw6Ru
emVyICAgICAgICAgICAgICAgfCAgICAgICAgICAgICAgIGh0dHBzOi8vcmVkaGF0LmNvbQpMaWJy
ZSBzb2Z0d2FyZSBlbnRodXNpYXN0ICAgICAgICAgICAgIHwgICAgICAgICAgICAgTWVzYSBhbmQg
WCBkZXZlbG9wZXIKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0
cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
