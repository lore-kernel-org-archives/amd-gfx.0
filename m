Return-Path: <SRS0=YLFm=YS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 459F2CA9EBC
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Oct 2019 16:06:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25C0B21D81
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Oct 2019 16:06:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25C0B21D81
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daenzer.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9FF5A6EAE6;
	Fri, 25 Oct 2019 16:06:30 +0000 (UTC)
Received: from netline-mail3.netline.ch (mail.netline.ch [148.251.143.178])
 by gabe.freedesktop.org (Postfix) with ESMTP id 472346EADF;
 Fri, 25 Oct 2019 16:06:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by netline-mail3.netline.ch (Postfix) with ESMTP id 295582A6046;
 Fri, 25 Oct 2019 18:06:28 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at netline-mail3.netline.ch
Received: from netline-mail3.netline.ch ([127.0.0.1])
 by localhost (netline-mail3.netline.ch [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id O_7KpgKi-kVj; Fri, 25 Oct 2019 18:06:27 +0200 (CEST)
Received: from thor (116.245.63.188.dynamic.wline.res.cust.swisscom.ch
 [188.63.245.116])
 by netline-mail3.netline.ch (Postfix) with ESMTPSA id A1E0B2A6045;
 Fri, 25 Oct 2019 18:06:27 +0200 (CEST)
Received: from localhost ([::1]) by thor with esmtp (Exim 4.92.3)
 (envelope-from <michel@daenzer.net>)
 id 1iO26c-0005b1-Qh; Fri, 25 Oct 2019 18:06:26 +0200
Subject: Re: [PATCH] drm/radeon: Handle workqueue allocation failure
To: Will Deacon <will@kernel.org>
References: <20191025110450.10474-1-will@kernel.org>
From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>
Message-ID: <5d6a88a2-2719-a859-04df-10b0d893ff39@daenzer.net>
Date: Fri, 25 Oct 2019 18:06:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191025110450.10474-1-will@kernel.org>
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
Message-ID: <20191025160626.0olxXcoe9tBUIVOlP9Gz6SC-OP_zMg1XeewkGG0PWFQ@z>

T24gMjAxOS0xMC0yNSAxOjA0IHAubS4sIFdpbGwgRGVhY29uIHdyb3RlOgo+IEluIHRoZSBoaWdo
bHkgdW5saWtlbHkgZXZlbnQgdGhhdCB3ZSBmYWlsIHRvIGFsbG9jYXRlIHRoZSAicmFkZW9uLWNy
dGMiCj4gd29ya3F1ZXVlLCB3ZSBzaG91bGQgYmFpbCBjbGVhbmx5IHJhdGhlciB0aGFuIGJsaW5k
bHkgbWFyY2ggb24gd2l0aCBhCj4gTlVMTCBwb2ludGVyIGluc3RhbGxlZCBmb3IgdGhlICdmbGlw
X3F1ZXVlJyBmaWVsZCBvZiB0aGUgJ3JhZGVvbl9jcnRjJwo+IHN0cnVjdHVyZS4KPiAKPiBUaGlz
IHdhcyByZXBvcnRlZCBwcmV2aW91c2x5IGJ5IE5pY29sYXMsIGJ1dCBJIGRvbid0IHRoaW5rIGhp
cyBmaXggd2FzCj4gY29ycmVjdDoKCk5laXRoZXIgaXMgdGhpcyBvbmUgSSdtIGFmcmFpZC4gU2Vl
IG15IGZlZWRiYWNrIG9uCmh0dHBzOi8vcGF0Y2h3b3JrLmZyZWVkZXNrdG9wLm9yZy9wYXRjaC8z
MzE1MzQvIC4KCgotLSAKRWFydGhsaW5nIE1pY2hlbCBEw6RuemVyICAgICAgICAgICAgICAgfCAg
ICAgICAgICAgICAgIGh0dHBzOi8vcmVkaGF0LmNvbQpMaWJyZSBzb2Z0d2FyZSBlbnRodXNpYXN0
ICAgICAgICAgICAgIHwgICAgICAgICAgICAgTWVzYSBhbmQgWCBkZXZlbG9wZXIKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxp
c3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3Rv
cC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
