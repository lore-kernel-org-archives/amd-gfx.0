Return-Path: <SRS0=jB5Z=EB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EA70C4363A
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Oct 2020 11:03:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 655BD2224A
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Oct 2020 11:03:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 655BD2224A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daenzer.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C95486E02B;
	Mon, 26 Oct 2020 11:03:50 +0000 (UTC)
Received: from netline-mail3.netline.ch (mail.netline.ch [148.251.143.178])
 by gabe.freedesktop.org (Postfix) with ESMTP id C99756E02B
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Oct 2020 11:03:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by netline-mail3.netline.ch (Postfix) with ESMTP id B0E252A6042;
 Mon, 26 Oct 2020 12:03:48 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at netline-mail3.netline.ch
Received: from netline-mail3.netline.ch ([127.0.0.1])
 by localhost (netline-mail3.netline.ch [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id jp4ezO7Q-qV7; Mon, 26 Oct 2020 12:03:48 +0100 (CET)
Received: from thor (212.174.63.188.dynamic.wline.res.cust.swisscom.ch
 [188.63.174.212])
 by netline-mail3.netline.ch (Postfix) with ESMTPSA id 5CBCB2A6016;
 Mon, 26 Oct 2020 12:03:47 +0100 (CET)
Received: from [::1] by thor with esmtp (Exim 4.94)
 (envelope-from <michel@daenzer.net>)
 id 1kX0Hy-000TLP-K6; Mon, 26 Oct 2020 12:03:46 +0100
To: "Alex Xu (Hello71)" <alex_y_xu@yahoo.ca>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 alexander.deucher@amd.com, Harry Wentland <harry.wentland@amd.com>,
 Leo Li <sunpeng.li@amd.com>, amd-gfx@lists.freedesktop.org
References: <1603684905.h43s1t0y05.none.ref@localhost>
 <1603684905.h43s1t0y05.none@localhost>
From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>
Subject: Re: amdgpu crashes on OOM
Message-ID: <81568253-518f-43b7-6b20-432f7dbd6c2b@daenzer.net>
Date: Mon, 26 Oct 2020 12:03:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.3
MIME-Version: 1.0
In-Reply-To: <1603684905.h43s1t0y05.none@localhost>
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
Cc: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gMjAyMC0xMC0yNiA1OjI5IGEubS4sIEFsZXggWHUgKEhlbGxvNzEpIHdyb3RlOgo+IEhpLAo+
IAo+IEkgZnJlcXVlbnRseSBlbmNvdW50ZXIgT09NIG9uIG15IHN5c3RlbSwgbW9zdGx5IGR1ZSB0
byBteSBvd24gZmF1bHQuCj4gUmVjZW50bHksIEkgbm90aWNlZCB0aGF0IG5vdCBvbmx5IGRvZXMg
YSBzd2FwIHN0b3JtIGhhcHBlbiBhbmQgT09NCj4ga2lsbGVyIGdldHMgaW52b2tlZCwgYnV0IHRo
ZSBncmFwaGljcyBvdXRwdXQgZnJlZXplcyBwZXJtYW5lbnRseS4KPiBDaGVja2luZyB0aGUga2Vy
bmVsIG1lc3NhZ2VzLCBJIHNlZToKPiAKPiBrd29ya2VyL3UyNDo0OiBwYWdlIGFsbG9jYXRpb24g
ZmFpbHVyZTogb3JkZXI6NSwgbW9kZToweDQwZGMwKEdGUF9LRVJORUx8X19HRlBfQ09NUHxfX0dG
UF9aRVJPKSwgbm9kZW1hc2s9KG51bGwpCj4gQ1BVOiA2IFBJRDogMjc5NDY5IENvbW06IGt3b3Jr
ZXIvdTI0OjQgVGFpbnRlZDogRyAgICAgICAgVyAgICAgICAgIDUuOS4wLTE0NzMyLWcyMGIxYWRi
NjBjZjYgIzIKPiBIYXJkd2FyZSBuYW1lOiBUbyBCZSBGaWxsZWQgQnkgTy5FLk0uIFRvIEJlIEZp
bGxlZCBCeSBPLkUuTS4vQjQ1MCBQcm80LCBCSU9TIFA0LjIwIDA2LzE4LzIwMjAKPiBXb3JrcXVl
dWU6IGV2ZW50c191bmJvdW5kIGNvbW1pdF93b3JrCj4gQ2FsbCBUcmFjZToKPiAgID8gZHVtcF9z
dGFjaysweDU3LzB4NmEKPiAgID8gd2Fybl9hbGxvYy5jb2xkKzB4NjkvMHhjZAo+ICAgPyBfX2Fs
bG9jX3BhZ2VzX2RpcmVjdF9jb21wYWN0KzB4ZmIvMHgxMTYKPiAgID8gX19hbGxvY19wYWdlc19z
bG93cGF0aC5jb25zdHByb3AuMCsweDljMi8weGMxNAo+ICAgPyBfX2FsbG9jX3BhZ2VzX25vZGVt
YXNrKzB4MTQzLzB4MTY3Cj4gICA/IGttYWxsb2Nfb3JkZXIrMHgyNC8weDY0Cj4gICA/IGRjX2Ny
ZWF0ZV9zdGF0ZSsweDFhLzB4NGQKPiAgID8gYW1kZ3B1X2RtX2F0b21pY19jb21taXRfdGFpbCsw
eDFiMTkvMHgyMjdkCgpMb29rcyBsaWtlIGRjX2NyZWF0ZV9zdGF0ZSBzaG91bGQgdXNlIGt2emFs
bG9jIGluc3RlYWQgb2Yga3phbGxvYyAKKGRjX3N0YXRlX2ZyZWUgYWxyZWFkeSB1c2VzIGt2ZnJl
ZSkuCgpvcmRlcjo1IG1lYW5zIGl0J3MgdHJ5aW5nIHRvIGFsbG9jYXRlIDMyIHBoeXNpY2FsbHkg
Y29udGlndW91cyBwYWdlcywgCndoaWNoIGNhbiBiZSBoYXJkIHRvIGZ1bGZpbGwgZXZlbiB3aXRo
IGxvd2VyIG1lbW9yeSBwcmVzc3VyZS4KCgotLSAKRWFydGhsaW5nIE1pY2hlbCBEw6RuemVyICAg
ICAgICAgICAgICAgfCAgICAgICAgICAgICAgIGh0dHBzOi8vcmVkaGF0LmNvbQpMaWJyZSBzb2Z0
d2FyZSBlbnRodXNpYXN0ICAgICAgICAgICAgIHwgICAgICAgICAgICAgTWVzYSBhbmQgWCBkZXZl
bG9wZXIKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1k
LWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9s
aXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
