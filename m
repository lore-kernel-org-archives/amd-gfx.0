Return-Path: <SRS0=ehRF=6E=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69142C3815B
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Apr 2020 14:44:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F370D206D5
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Apr 2020 14:44:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F370D206D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daenzer.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ACC6A6E5A4;
	Mon, 20 Apr 2020 14:44:18 +0000 (UTC)
Received: from netline-mail3.netline.ch (mail.netline.ch [148.251.143.178])
 by gabe.freedesktop.org (Postfix) with ESMTP id 38E136E5A9
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Apr 2020 14:44:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by netline-mail3.netline.ch (Postfix) with ESMTP id 477FD2A6045;
 Mon, 20 Apr 2020 16:44:16 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at netline-mail3.netline.ch
Received: from netline-mail3.netline.ch ([127.0.0.1])
 by localhost (netline-mail3.netline.ch [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id CYQ2zTuUVl9M; Mon, 20 Apr 2020 16:44:16 +0200 (CEST)
Received: from thor (252.80.76.83.dynamic.wline.res.cust.swisscom.ch
 [83.76.80.252])
 by netline-mail3.netline.ch (Postfix) with ESMTPSA id F33192A6016;
 Mon, 20 Apr 2020 16:44:15 +0200 (CEST)
Received: from [::1] by thor with esmtp (Exim 4.93)
 (envelope-from <michel@daenzer.net>)
 id 1jQXeh-001ozu-EM; Mon, 20 Apr 2020 16:44:15 +0200
Subject: Re: Reg. Adaptive Sync feature in xf86-video-amdgpu
To: uday kiran pichika <udaykiran.pichika@gmail.com>
References: <CAGcx_0Z4Lz4x5xxahtQJwaysGcQz9frLctYMg3z1Num3y+LUyw@mail.gmail.com>
From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>
Message-ID: <ab5fd92f-c0e3-8647-80e7-00d4ad397582@daenzer.net>
Date: Mon, 20 Apr 2020 16:44:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAGcx_0Z4Lz4x5xxahtQJwaysGcQz9frLctYMg3z1Num3y+LUyw@mail.gmail.com>
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
Cc: amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gMjAyMC0wNC0yMCA2OjEyIGEubS4sIHVkYXkga2lyYW4gcGljaGlrYSB3cm90ZToKPiBIZWxs
byBUZWFtLAo+IAo+IEknbSB3b3JraW5nIG9uIGFkZGluZyBBZGFwdGl2ZSBTeW5jIGZlYXR1cmUg
aW4gWHNlcnZlci9tb2Rlc2V0dGluZy4gV2hlbgo+IHVuZGVyc3RhbmRpbmcgdGhlIGV4aXN0aW5n
IEFNRCdzIGltcGxlbWVudGF0aW9uLCBJJ3ZlIGZldyBkb3VidHMgcmVnYXJkaW5nCj4gdGhlIHZy
ciBwcm9wZXJ0eSBiZWluZyBzZXQgb24gdGhlIFdpbmRvdyBmcm9tIE1FU0EuCj4gCj4gSSBoYXZl
IG1hZGUgdGhlIG1vZGlmaWNhdGlvbnMgaW4geHNlcnZlci9tb2Rlc2V0dGluZyBidXQgd2hlbiBp
IGxhdW5jaCB0aGUKPiBhcHBsaWNhdGlvbihET1RBMiksIGJlbG93IGNvbmRpdGlvbiBnZXRzIGZh
aWxlZAo+IGh0dHBzOi8vZ2l0bGFiLmZyZWVkZXNrdG9wLm9yZy94b3JnL2RyaXZlci94Zjg2LXZp
ZGVvLWFtZGdwdS8tL2Jsb2IvbWFzdGVyL3NyYy9hbWRncHVfa21zLmMjTDExMAoKQlRXLCBvbmUg
c2hvdWxkIGFsd2F5cyB1c2UgYSBzcGVjaWZpYyBHaXQgY29tbWl0IGZvciB0aGlzIGtpbmQgb2YK
cmVmZXJlbmNlLCBvdGhlcndpc2UgaXQgd2lsbCB0ZW5kIHRvIHBvaW50IHRvIHVucmVsYXRlZCBj
b2RlIG9yIGV2ZW4KbmlydmFuYSBhcyB0aW1lIHBhc3Nlcy4KCgo+IEFzIHBlciB0aGUgY29kZSwg
aSBoYWQgYSBjb25mdXNpb24gdGhhdCB0aGlzIGNvbmRpdGlvbiB3aWxsIG5ldmVyIG1ldC4KPiAK
PiAqSSBoYWQgYW5hbHlzZWQgdGhlIGNvZGUgYW5kIGhlcmUgaXMgdGhlIGFuYWx5c2lzIG1hZGUg
d2hlbiB0aGUgZmxpcAo+IGhhcHBlbnMgaW4geHNlcnZlciBXaGVuIGZ1bGwgc2NyZWVuIGdhbWlu
ZyBhcHBsaWNhdGlvbiBpcyBvcGVuZWQsCj4gdmFyaWFibGVfcmVmcmVzaCBwcm9wZXJ0eSBpcyBi
ZWluZyBzZXQgaW4gTUVTQSBhbmQgeHNlcnZlciB3aWxsIGdldAo+IG5vdGlmaWVkIHdpdGggYW1k
Z3B1X2NoYW5nZV9wcm9wZXJ0eSgpIG1ldGhvZChTYW1lIG1ldGhvZCB3ZSByZWdpc3RlcmVkCj4g
d2l0aCB0aGUgY2xpZW50IGR1cmluZyBBTURHUFVTY3JlZW5Jbml0X0tNUygpKS4gKgo+IAo+ICpC
ZWxvdyBhY3Rpb25zIHdpbGwgaGFwcGVuIGluIG1zX2NoYW5nZV9wcm9wZXJ0eSgpICoKPiAKPiAq
MS4gQ3JlYXRlIExvY2FsIFdpbmRvd1B0ciBhbmQgY29weSB0aGUgZGF0YSBmcm9tIFN0dWZmLT53
aW5kb3cgdG8gdGhpcwo+IFdpbmRvd1B0cioKPiAKPiAqMi4gQ2FsbCBhbWRncHVfdnJyX3Byb3Bl
cnR5X3VwZGF0ZSgpIGJhc2VkIG9uIHRoZSBwcm9wZXJ0eSBzZXQgaW4gU3R1ZmYgYnkKPiBwYXNz
aW5nIHRoZSBXaW5kb3dQdHIgdG8gaXQuKgo+IAo+ICogICAgYS4gUmVhZCBQcml2YXRlIEtleXMg
Zm9yIFdpbmRvd1B0ciBpbiBhbWRncHVfdnJyX3Byb3BlcnR5X3VwZGF0ZSgpLiAqCj4gCj4gKiAg
ICBiLiBDb21wYXJlIGluZm8tPmZsaXBfd2luZG93IGFuZCB0aGlzIFdpbmRvd1B0ciBhbmQgbWFr
ZSBhIGNhbGwgdG8KPiBhbWRncHVfcHJlc2VudF9zZXRfc2NyZWVuX3ZycigpLiAg4oaSIEJ1dCB0
aGlzIG1ldGhvZCB3aWxsIG5ldmVyIGdldHMgY2FsbGVkCj4gZHVlIHRvIHRoZSBjb25kaXRpb24g
bWlzbWF0Y2ggZXZlcnkgdGltZS4gV2h5ID8gKgo+IAo+ICpXaHkgPyoKPiAKPiAqaW5mby0+Zmxp
cF93aW5kb3cgZ2V0cyB1cGRhdGVkIHdpdGggd2luZG93IChXaW5kb3dQdHIpCj4gaW4gYW1kZ3B1
X3ByZXNlbnRfY2hlY2tfZmxpcCgpIHdoZW4gYW1kZ3B1X3ByZXNlbnRfZmxpcCgpIG1ldGhvZCBn
ZXRzCj4gY2FsbGVkIGZyb20gRElYLiBUaGlzIHBvaW50ZXIgd2lsbCBuZXZlciBzYW1lIGFzIHRo
ZSBXaW5kb3dQdHIgY3JlYXRlZCBpbgo+IGFtZGdwdV9jaGFuZ2VfcHJvcGVydHkoKSBhbmQgdmFy
aWFibGVfcmVmcmVzaCBmbGFnIGlzIGJlaW5nIHNldCBmb3IgaW4KPiBhbWRncHVfY2hhbmdlX3By
b3BlcnR5KCkgV2luZG93UHRyIG9ubHkuICoKPiAKPiBDYW4gIHlvdSBwbGVhc2UgaGVscCBtZSBp
biB1bmRlcnN0YW5kaW5nIG9uIHRoaXMgPwoKVGhpcyBjb2RlIGluIGFtZGdwdV92cnJfcHJvcGVy
dHlfdXBkYXRlIGlzIGZvciB0aGUgY2FzZSB3aGVuIHRoZQpDaGFuZ2VQcm9wZXJ0eSByZXF1ZXN0
IGlzIGNhbGxlZCBmb3IgYSB3aW5kb3cgd2hpY2ggaXMgYWxyZWFkeSBmbGlwcGluZy4KCkluIHRo
ZSBjYXNlIHlvdSdyZSBsb29raW5nIGF0LCB0aGUgd2luZG93IG9ubHkgc3RhcnRzIGZsaXBwaW5n
IGxhdGVyLAphbmQgdGhlIEtNUyBwcm9wZXJ0eSBpcyBlbmFibGVkIGZyb20gYW1kZ3B1X3ByZXNl
bnRfZmxpcCA9PgphbWRncHVfcHJlc2VudF9zZXRfc2NyZWVuX3Zyci4KCgotLSAKRWFydGhsaW5n
IE1pY2hlbCBEw6RuemVyICAgICAgICAgICAgICAgfCAgICAgICAgICAgICAgIGh0dHBzOi8vcmVk
aGF0LmNvbQpMaWJyZSBzb2Z0d2FyZSBlbnRodXNpYXN0ICAgICAgICAgICAgIHwgICAgICAgICAg
ICAgTWVzYSBhbmQgWCBkZXZlbG9wZXIKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVz
a3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9h
bWQtZ2Z4Cg==
