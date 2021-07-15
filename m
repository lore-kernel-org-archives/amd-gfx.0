Return-Path: <SRS0=bMdI=MH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C8D3C1B08C
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Jul 2021 15:51:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D0AA613E4
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Jul 2021 15:51:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D0AA613E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daenzer.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 06B796E87F;
	Thu, 15 Jul 2021 15:51:38 +0000 (UTC)
Received: from netline-mail3.netline.ch (mail.netline.ch [148.251.143.180])
 by gabe.freedesktop.org (Postfix) with ESMTP id 555436E87F;
 Thu, 15 Jul 2021 15:51:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by netline-mail3.netline.ch (Postfix) with ESMTP id 1AE5920201E;
 Thu, 15 Jul 2021 17:51:35 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at netline-mail3.netline.ch
Received: from netline-mail3.netline.ch ([127.0.0.1])
 by localhost (netline-mail3.netline.ch [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id sx6L0055-jNz; Thu, 15 Jul 2021 17:51:34 +0200 (CEST)
Received: from thor (24.99.2.85.dynamic.wline.res.cust.swisscom.ch
 [85.2.99.24])
 by netline-mail3.netline.ch (Postfix) with ESMTPA id 76FC820201D;
 Thu, 15 Jul 2021 17:51:34 +0200 (CEST)
Received: from [::1] by thor with esmtp (Exim 4.94.2)
 (envelope-from <michel@daenzer.net>)
 id 1m43e1-0002oe-9T; Thu, 15 Jul 2021 17:51:25 +0200
To: Alex Deucher <alexdeucher@gmail.com>, Sam Ravnborg <sam@ravnborg.org>
References: <20210714220858.5553-1-alexander.deucher@amd.com>
 <YO+++Tj94RRjVqwV@ravnborg.org>
 <CADnq5_Oj1Totqe=fGeF3AeQsodR9_6ki7EChs3CmJzC7txMu1A@mail.gmail.com>
From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>
Subject: Re: [pull] amdgpu, amdkfd drm-fixes-5.14
Message-ID: <7e831a9a-5365-552a-0f14-7b43847302fb@daenzer.net>
Date: Thu, 15 Jul 2021 17:51:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CADnq5_Oj1Totqe=fGeF3AeQsodR9_6ki7EChs3CmJzC7txMu1A@mail.gmail.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Daniel Vetter <daniel.vetter@ffwll.ch>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gMjAyMS0wNy0xNSA0OjA3IHAubS4sIEFsZXggRGV1Y2hlciB3cm90ZToKPiBPbiBUaHUsIEp1
bCAxNSwgMjAyMSBhdCAxMjo1MiBBTSBTYW0gUmF2bmJvcmcgPHNhbUByYXZuYm9yZy5vcmc+IHdy
b3RlOgo+PiBPbiBXZWQsIEp1bCAxNCwgMjAyMSBhdCAwNjowODo1OFBNIC0wNDAwLCBBbGV4IERl
dWNoZXIgd3JvdGU6Cj4+PiBIaSBEYXZlLCBEYW5pZWwsCj4+Pgo+Pj4gRml4ZXMgZm9yIDUuMTQu
ICBUaGUgYmlnIGNoYW5nZSBoZXJlIGlzIHVuaWZ5aW5nIHRoZSBTTVUxMyBjb2RlLiAgVGhpcyB3
YXMKPj4+IG5ldyBjb2RlIGFkZGVkIGluIDUuMTQgdG8gc3VwcG9ydCBZZWxsb3cgQ2FycCwgYnV0
IHdlJ3ZlIHNpbmNlIGNsZWFuZWQgaXQKPj4+IHVwIGFuZCByZW1vdmVkIGEgbG90IG9mIGR1cGxp
Y2F0aW9uLCBzbyBiZXR0ZXIgdG8gbWVyZ2UgaXQgbm93IHRvIGZhY2lsaXRhdGUKPj4+IGFueSBi
dWcgZml4ZXMgaW4gdGhlIGZ1dHVyZSB0aGF0IG5lZWQgdG8gZ28gYmFjayB0byB0aGlzIGtlcm5l
bCB2aWEgc3RhYmxlLgo+Pj4gT25seSBhZmZlY3RzIFllbGxvdyBDYXJwIHdoaWNoIGlzIG5ldyBm
b3IgNS4xNCBhbnl3YXkgc28gbm90IG11Y2ggY2hhbmNlIGZvcgo+Pj4gcmVncmVzc2lvbnMuICBU
aGUgcmVzdCBpcyBqdXN0IHN0YW5kYXJkIGJ1ZyBmaXhlcy4KPj4KPj4gVGhpcyBwdWxsIHNlZW1z
IG5vdCB0byBpbmNsdWRlIGFueSBmaXhlcyBmb3IgdGhlIFc9MSB3YXJuaW5ncyB0aGF0Cj4+IGhh
cyBjcmVwdCBpbiBhZ2Fpbi4gSXQgd291bGQgYmUgbmljZSBpZiB0aGUgYW1kZ3B1IGNvdWxkIGJl
IHdhcm5pbmcgZnJlZQo+PiBhZ2FpbiwgdGhpcyB3b3VsZCBtYXliZSBtb3RpdmF0ZSB0aGUgb3Ro
ZXJzIHRvIGZpeCB0aGVpcnMgdG9vIHNvIHdlCj4+IGNvdWxkIGtlZXAgbW9zdC9hbGwgb2YgZHJp
dmVycy9ncHUvIGZyZWUgb2YgVz0xIHdhcm5pbmdzLgo+IAo+IFdlIGhhdmVuJ3QgcmVhbGx5IGJl
ZW4gbW9uaXRvcmluZyB0aGUgVz0xIHN0dWZmIHRoYXQgY2xvc2VseS4gIEknbGwKPiBzZWUgd2hh
dCB3ZSBjYW4gZG8gZ29pbmcgZm9yd2FyZC4KCklNSE8ga2VlcGluZyB0aGUgVz0xIGJ1aWxkIGNs
ZWFuIGlzbid0IHJlYWxpc3RpYyB3aXRob3V0IGVuZm9yY2luZyBpdCBpbiBDSS4KCgotLSAKRWFy
dGhsaW5nIE1pY2hlbCBEw6RuemVyICAgICAgICAgICAgICAgfCAgICAgICAgICAgICAgIGh0dHBz
Oi8vcmVkaGF0LmNvbQpMaWJyZSBzb2Z0d2FyZSBlbnRodXNpYXN0ICAgICAgICAgICAgIHwgICAg
ICAgICAgICAgTWVzYSBhbmQgWCBkZXZlbG9wZXIKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5m
cmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0
aW5mby9hbWQtZ2Z4Cg==
