Return-Path: <SRS0=YLFm=YS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87409CA9EBC
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Oct 2019 16:20:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 524182070B
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Oct 2019 16:20:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 524182070B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daenzer.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E9C746EAF5;
	Fri, 25 Oct 2019 16:20:03 +0000 (UTC)
Received: from netline-mail3.netline.ch (mail.netline.ch [148.251.143.178])
 by gabe.freedesktop.org (Postfix) with ESMTP id DB0D06EAF5;
 Fri, 25 Oct 2019 16:20:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by netline-mail3.netline.ch (Postfix) with ESMTP id 210712A6046;
 Fri, 25 Oct 2019 18:20:02 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at netline-mail3.netline.ch
Received: from netline-mail3.netline.ch ([127.0.0.1])
 by localhost (netline-mail3.netline.ch [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id cDFWOZDoYXzC; Fri, 25 Oct 2019 18:20:01 +0200 (CEST)
Received: from thor (116.245.63.188.dynamic.wline.res.cust.swisscom.ch
 [188.63.245.116])
 by netline-mail3.netline.ch (Postfix) with ESMTPSA id CC4982A6045;
 Fri, 25 Oct 2019 18:20:01 +0200 (CEST)
Received: from localhost ([::1]) by thor with esmtp (Exim 4.92.3)
 (envelope-from <michel@daenzer.net>)
 id 1iO2Jl-0005jU-GJ; Fri, 25 Oct 2019 18:20:01 +0200
Subject: Re: [PATCH] drm/radeon: Handle workqueue allocation failure
To: Will Deacon <will@kernel.org>
References: <20191025110450.10474-1-will@kernel.org>
 <5d6a88a2-2719-a859-04df-10b0d893ff39@daenzer.net>
 <20191025161804.GA12335@willie-the-truck>
From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>
Message-ID: <e2f87ecc-0a8e-253d-107c-5cf6486c4b6a@daenzer.net>
Date: Fri, 25 Oct 2019 18:20:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191025161804.GA12335@willie-the-truck>
Content-Language: en-CA
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
Cc: amd-gfx@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Nicolas Waisman <nico@semmle.com>, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191025162001.qq-r51wQC5m8SqQaZOrBIb14t1Q1pSi8aVDoaBmIDJo@z>

T24gMjAxOS0xMC0yNSA2OjE4IHAubS4sIFdpbGwgRGVhY29uIHdyb3RlOgo+IE9uIEZyaSwgT2N0
IDI1LCAyMDE5IGF0IDA2OjA2OjI2UE0gKzAyMDAsIE1pY2hlbCBEw6RuemVyIHdyb3RlOgo+PiBP
biAyMDE5LTEwLTI1IDE6MDQgcC5tLiwgV2lsbCBEZWFjb24gd3JvdGU6Cj4+PiBJbiB0aGUgaGln
aGx5IHVubGlrZWx5IGV2ZW50IHRoYXQgd2UgZmFpbCB0byBhbGxvY2F0ZSB0aGUgInJhZGVvbi1j
cnRjIgo+Pj4gd29ya3F1ZXVlLCB3ZSBzaG91bGQgYmFpbCBjbGVhbmx5IHJhdGhlciB0aGFuIGJs
aW5kbHkgbWFyY2ggb24gd2l0aCBhCj4+PiBOVUxMIHBvaW50ZXIgaW5zdGFsbGVkIGZvciB0aGUg
J2ZsaXBfcXVldWUnIGZpZWxkIG9mIHRoZSAncmFkZW9uX2NydGMnCj4+PiBzdHJ1Y3R1cmUuCj4+
Pgo+Pj4gVGhpcyB3YXMgcmVwb3J0ZWQgcHJldmlvdXNseSBieSBOaWNvbGFzLCBidXQgSSBkb24n
dCB0aGluayBoaXMgZml4IHdhcwo+Pj4gY29ycmVjdDoKPj4KPj4gTmVpdGhlciBpcyB0aGlzIG9u
ZSBJJ20gYWZyYWlkLiBTZWUgbXkgZmVlZGJhY2sgb24KPj4gaHR0cHM6Ly9wYXRjaHdvcmsuZnJl
ZWRlc2t0b3Aub3JnL3BhdGNoLzMzMTUzNC8gLgo+IAo+IFRoYW5rcy4gQWx0aG91Z2ggSSBhZ3Jl
ZSB3aXRoIHlvdSB3cnQgdGhlIG9yaWdpbmFsIHBhdGNoLCBJIGRvbid0IHRoaW5rCj4gdGhlIHdv
cmtxdWV1ZSBhbGxvY2F0aW9uIGZhaWx1cmUgaXMgZGlzdGluZ3Vpc2hhYmxlIGZyb20gdGhlIENS
VEMgYWxsb2NhdGlvbgo+IGZhaWx1cmUgd2l0aCBteSBwYXRjaC4gQXJlIHlvdSBzYXlpbmcgdGhh
dCB0aGUgZXJyb3IgcGF0aCB0aGVyZSBpcyBicm9rZW4KPiB0b28/CgpUaGUgZHJpdmVyIHdvbid0
IGFjdHVhbGx5IHdvcmsgaWYgcmFkZW9uX2NydGNfaW5pdCBiYWlscyBzaWxlbnRseSwgaXQnbGwK
anVzdCBmYWxsIG92ZXIgYXQgc29tZSBsYXRlciBwb2ludC4KCgotLSAKRWFydGhsaW5nIE1pY2hl
bCBEw6RuemVyICAgICAgICAgICAgICAgfCAgICAgICAgICAgICAgIGh0dHBzOi8vcmVkaGF0LmNv
bQpMaWJyZSBzb2Z0d2FyZSBlbnRodXNpYXN0ICAgICAgICAgICAgIHwgICAgICAgICAgICAgTWVz
YSBhbmQgWCBkZXZlbG9wZXIKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5v
cmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
