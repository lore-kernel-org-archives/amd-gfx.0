Return-Path: <SRS0=sNMb=MA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B4BDC07E9C
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Jul 2021 16:14:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F05C61945
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Jul 2021 16:14:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F05C61945
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daenzer.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C61F96E8EC;
	Thu,  8 Jul 2021 16:13:59 +0000 (UTC)
Received: from netline-mail3.netline.ch (mail.netline.ch [148.251.143.180])
 by gabe.freedesktop.org (Postfix) with ESMTP id E7C306E8EC
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Jul 2021 16:13:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by netline-mail3.netline.ch (Postfix) with ESMTP id B3B9320201B;
 Thu,  8 Jul 2021 18:13:57 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at netline-mail3.netline.ch
Received: from netline-mail3.netline.ch ([127.0.0.1])
 by localhost (netline-mail3.netline.ch [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id s9aUCG8NXl5o; Thu,  8 Jul 2021 18:13:57 +0200 (CEST)
Received: from thor (24.99.2.85.dynamic.wline.res.cust.swisscom.ch
 [85.2.99.24])
 by netline-mail3.netline.ch (Postfix) with ESMTPA id 249C320201A;
 Thu,  8 Jul 2021 18:13:57 +0200 (CEST)
Received: from [::1] by thor with esmtp (Exim 4.94.2)
 (envelope-from <michel@daenzer.net>)
 id 1m1Wey-001D4n-3A; Thu, 08 Jul 2021 18:13:56 +0200
From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 Alex Deucher <alexdeucher@gmail.com>
References: <a4ba9456-812b-5280-75fd-6dd66d1f9718@riseup.net>
 <22c25fa6-b3eb-b778-8598-3ce1947a3d0b@daenzer.net>
 <CADnq5_OVjssNi2niLZQs-TOyN5T5EFOnpwmpmbvHRgh_M0B=wg@mail.gmail.com>
 <7a9f2682-559d-57ec-4879-b1e6f743c375@daenzer.net>
 <CADnq5_O+FjF0R0OEMyPZ-hzg7d2Fx87NBUjax8_XLF4b71oKmg@mail.gmail.com>
 <7ecaff42-68e4-7566-0da1-fa3475fcacb3@daenzer.net>
 <CADnq5_MEFyQA6s7+4FKKq3qT_6i2ue=n5+CswPpB3H5Kt3ybuw@mail.gmail.com>
 <65f5567e-4c5c-6e20-a379-e7182bcacb1f@daenzer.net>
 <c2b9b42d-55e1-fa5d-8e10-ea474fcd9221@daenzer.net>
 <BL1PR12MB514478C04EC9E42F39F9C8BDF7039@BL1PR12MB5144.namprd12.prod.outlook.com>
 <5e2067cd-62fe-d3c5-ea0d-69393b0d7883@daenzer.net>
Subject: Re: AMDGPU error: "[drm:amdgpu_dm_atomic_commit_tail [amdgpu]]
 *ERROR* Waiting for fences timed out!"
Message-ID: <7f461adc-8868-0b76-cedb-d8be8d527218@daenzer.net>
Date: Thu, 8 Jul 2021 18:13:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <5e2067cd-62fe-d3c5-ea0d-69393b0d7883@daenzer.net>
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
Cc: xgqt <xgqt@riseup.net>, amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gMjAyMS0wNi0yOSAxMjozNiBwLm0uLCBNaWNoZWwgRMOkbnplciB3cm90ZToKPiBPbiAyMDIx
LTA2LTI4IDc6MTYgcC5tLiwgRGV1Y2hlciwgQWxleGFuZGVyIHdyb3RlOgo+Pgo+PiBUaGFua3Mg
Zm9yIG5hcnJvd2luZyB0aGlzIGRvd24uwqAgVGhlcmUgaXMgbmV3IFBDTyBTRE1BIGZpcm13YXJl
IGF2YWlsYWJsZSAoYXR0YWNoZWQpLsKgIENhbiB5b3UgdHJ5IGl0Pwo+IAo+IFN1cmUsIEknbGwg
dHJ5IGl0LCB0aGFua3MuCgpTbyBmYXIsIHNvIGdvb2Q7IG5vIGhhbmcgaW4gYSB3ZWVrLiBJJ2xs
IHRyeSB0aGUgcmVzdCBvZiB0aGUgbmV3IGZpcm13YXJlIGFzIHdlbGwgbm93LCB3aWxsIGZvbGxv
dyB1cCBpZiB0aGVyZSdzIGEgaGFuZyBhZ2Fpbi4KCgotLSAKRWFydGhsaW5nIE1pY2hlbCBEw6Ru
emVyICAgICAgICAgICAgICAgfCAgICAgICAgICAgICAgIGh0dHBzOi8vcmVkaGF0LmNvbQpMaWJy
ZSBzb2Z0d2FyZSBlbnRodXNpYXN0ICAgICAgICAgICAgIHwgICAgICAgICAgICAgTWVzYSBhbmQg
WCBkZXZlbG9wZXIKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0
cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
