Return-Path: <SRS0=hzAD=H7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6DC2C433E0
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Mar 2021 09:37:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BF4A64E22
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Mar 2021 09:37:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BF4A64E22
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=shipmail.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B73D89F33;
	Mon,  1 Mar 2021 09:37:30 +0000 (UTC)
X-Greylist: delayed 429 seconds by postgrey-1.36 at gabe;
 Mon, 01 Mar 2021 09:37:28 UTC
Received: from ste-pvt-msa1.bahnhof.se (ste-pvt-msa1.bahnhof.se
 [213.80.101.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D5C589F33
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Mar 2021 09:37:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTP id 7F9013F3ED;
 Mon,  1 Mar 2021 10:30:17 +0100 (CET)
Authentication-Results: ste-pvt-msa1.bahnhof.se; dkim=pass (1024-bit key;
 unprotected) header.d=shipmail.org header.i=@shipmail.org header.b=pCe4h5hu; 
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Received: from ste-pvt-msa1.bahnhof.se ([127.0.0.1])
 by localhost (ste-pvt-msa1.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BORA2uAGNfPw; Mon,  1 Mar 2021 10:30:16 +0100 (CET)
Received: by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTPA id 40C363F3A1;
 Mon,  1 Mar 2021 10:30:15 +0100 (CET)
Received: from [10.249.254.148] (unknown [192.198.151.43])
 by mail1.shipmail.org (Postfix) with ESMTPSA id 345443600BA;
 Mon,  1 Mar 2021 10:30:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
 t=1614591014; bh=3M80a/1f9JbAl4GxdIuyXLw/uMvexNR7mYhs6+1/djw=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=pCe4h5huN02nxVaL3T3oHruyzP0bsOGK6asZ7NRtWIFz22VF1uGszJNR0T59yh9JT
 2m43J/f5XHtav4eWaJcm8BdiaWbyjKHAFNBnu8KRKPPS62BBNgUmdfwl+MnmgyCu4v
 6bD8ZC7JXxHVw1pZ6RAy+bNEOaJg+UzA8Q0JaMJg=
Subject: Re: [PATCH 17/35] drm/amdkfd: register HMM device private zone
To: Daniel Vetter <daniel@ffwll.ch>
References: <20210107030127.20393-1-Felix.Kuehling@amd.com>
 <20210107030127.20393-18-Felix.Kuehling@amd.com>
 <CAKMK7uEd9KZAmeNd9Z9GF9p0yUButHc+8_PERRuNR79+uqAhbQ@mail.gmail.com>
 <7f837938-3ad8-6ecf-d2b7-952b177cffb8@shipmail.org>
 <YDyswwICD3KmsBrf@phenom.ffwll.local>
From: =?UTF-8?Q?Thomas_Hellstr=c3=b6m_=28Intel=29?= <thomas_os@shipmail.org>
Message-ID: <4439d7b1-3ee3-b697-6edc-48b69f4638b9@shipmail.org>
Date: Mon, 1 Mar 2021 10:30:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <YDyswwICD3KmsBrf@phenom.ffwll.local>
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
Cc: Alex Sierra <alex.sierra@amd.com>, Philip Yang <Philip.Yang@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Ck9uIDMvMS8yMSA5OjU4IEFNLCBEYW5pZWwgVmV0dGVyIHdyb3RlOgo+IE9uIE1vbiwgTWFyIDAx
LCAyMDIxIGF0IDA5OjQ2OjQ0QU0gKzAxMDAsIFRob21hcyBIZWxsc3Ryw7ZtIChJbnRlbCkgd3Jv
dGU6Cj4+IE9uIDMvMS8yMSA5OjMyIEFNLCBEYW5pZWwgVmV0dGVyIHdyb3RlOgo+Pj4gT24gV2Vk
LCBKYW4gMDYsIDIwMjEgYXQgMTA6MDE6MDlQTSAtMDUwMCwgRmVsaXggS3VlaGxpbmcgd3JvdGU6
Cj4+Pj4gRnJvbTogUGhpbGlwIFlhbmcgPFBoaWxpcC5ZYW5nQGFtZC5jb20+Cj4+Pj4KPj4+PiBS
ZWdpc3RlciB2cmFtIG1lbW9yeSBhcyBNRU1PUllfREVWSUNFX1BSSVZBVEUgdHlwZSByZXNvdXJj
ZSwgdG8KPj4+PiBhbGxvY2F0ZSB2cmFtIGJhY2tpbmcgcGFnZXMgZm9yIHBhZ2UgbWlncmF0aW9u
Lgo+Pj4+Cj4+Pj4gU2lnbmVkLW9mZi1ieTogUGhpbGlwIFlhbmcgPFBoaWxpcC5ZYW5nQGFtZC5j
b20+Cj4+Pj4gU2lnbmVkLW9mZi1ieTogRmVsaXggS3VlaGxpbmcgPEZlbGl4Lkt1ZWhsaW5nQGFt
ZC5jb20+Cj4+PiBTbyBtYXliZSBJJ20gZ2V0dGluZyB0aGlzIGFsbCB3cm9uZywgYnV0IEkgdGhp
bmsgdGhhdCB0aGUgY3VycmVudCB0dG0KPj4+IGZhdWx0IGNvZGUgcmVsaWVzIG9uIGRldm1hcCBw
dGUgZW50cmllcyAoZXNwZWNpYWxseSBmb3IgaHVnZXB0ZSBlbnRyaWVzKQo+Pj4gdG8gc3RvcCBn
ZXRfdXNlcl9wYWdlcy4gQnV0IHRoaXMgb25seSB3b3JrcyBpZiB0aGUgcHRlIGhhcHBlbnMgdG8g
bm90Cj4+PiBwb2ludCBhdCBhIHJhbmdlIHdpdGggZGV2bWFwIHBhZ2VzLgo+PiBJIGRvbid0IHRo
aW5rIHRoYXQncyBpbiBUVE0geWV0LCBidXQgdGhlIHByb3Bvc2VkIGZpeCwgeWVzIChzZWUgZW1h
aWwgSSBqdXN0Cj4+IHNlbnQgaW4gYW5vdGhlciB0aHJlYWQpLAo+PiBidXQgb25seSBmb3IgaHVn
ZSBwdGVzLgo+Pgo+Pj4gVGhpcyBwYXRjaCBoZXJlIGNoYW5nZXMgdGhhdCwgYW5kIHNvIHByb2Jh
Ymx5IGJyZWFrcyB0aGlzIGRldm1hcCBwdGUgaGFjawo+Pj4gdHRtIGlzIHVzaW5nPwo+Pj4KPj4+
IElmIEknbSBub3Qgd3JvbmcgaGVyZSB0aGVuIEkgdGhpbmsgd2UgbmVlZCB0byBmaXJzdCBmaXgg
dXAgdGhlIHR0bSBjb2RlIHRvCj4+PiBub3QgdXNlIHRoZSBkZXZtYXAgaGFjayBhbnltb3JlLCBi
ZWZvcmUgYSB0dG0gYmFzZWQgZHJpdmVyIGNhbiByZWdpc3RlciBhCj4+PiBkZXZfcGFnZW1hcC4g
QWxzbyBhZGRpbmcgVGhvbWFzIHNpbmNlIHRoYXQganVzdCBjYW1lIHVwIGluIGFub3RoZXIKPj4+
IGRpc2N1c3Npb24uCj4+IEl0IGRvZXNuJ3QgYnJlYWsgdGhlIHR0bSBkZXZtYXAgaGFjayBwZXIg
c2UsIGJ1dCBpdCBpbmRlZWQgYWxsb3dzIGd1cCB0byB0aGUKPj4gcmFuZ2UgcmVnaXN0ZXJlZCwg
YnV0IGhlcmUncyB3aGVyZSBteSBsYWNrIG9mIHVuZGVyc3RhbmRpbmcgd2h5IHdlIGNhbid0Cj4+
IGFsbG93IGd1cC1pbmcgVFRNIHB0ZXMgaWYgdGhlcmUgaW5kZWVkIGlzIGEgYmFja2luZyBzdHJ1
Y3QtcGFnZT8gQmVjYXVzZQo+PiByZWdpc3RlcmluZyBNRU1PUllfREVWSUNFX1BSSVZBVEUgaW1w
bGllcyB0aGF0LCByaWdodD8KPiBXZSBuZWVkIHRvIGtlZXAgc3VwcG9ydGluZyBidWZmZXIgYmFz
ZWQgbWVtb3J5IG1hbmFnZW1lbnQgZm9yIGFsbCB0aGUKPiBub24tY29tcHV0ZSB1c2Vycy4gQmVj
YXVzZSB0aG9zZSByZXF1aXJlIGVuZC1vZi1iYXRjaCBkbWFfZmVuY2Ugc2VtYW50aWNzLAo+IHdo
aWNoIHByZXZlbnRzIHVzIGZyb20gdXNpbmcgZ3B1IHBhZ2UgZmF1bHRzLCB3aGljaCBtYWtlcyBo
bW0gbm90IHJlYWxseQo+IHdvcmsuCj4KPiBBbmQgZm9yIGJ1ZmZlciBiYXNlZCBtZW1vcnkgbWFu
YWdlciB3ZSBjYW4ndCBoYXZlIGd1cCBwaW4gcmFuZG9tIHBhZ2VzIGluCj4gdGhlcmUsIHRoYXQn
cyBub3QgcmVhbGx5IGhvdyBpdCB3b3Jrcy4gV29yc3QgY2FzZSB0dG0ganVzdCBhc3N1bWVzIGl0
IGNhbgo+IGFjdHVhbGx5IG1vdmUgYnVmZmVycyBhbmQgcmVhbGxvY2F0ZSB0aGVtIGFzIGl0IHNl
ZXMgZml0LCBhbmQgeW91ciBndXAKPiBtYXBwaW5nIChmb3IgZGlyZWN0IGkvbyBvciB3aGF0ZXZl
cikgbm93IHBvaW50cyBhdCBhIHBhZ2Ugb2YgYSBidWZmZXIgdGhhdAo+IHlvdSBkb24ndCBldmVu
IG93biBhbnltb3JlLiBUaGF0J3Mgbm90IGdvb2QuIEhlbmNlIGFsc28gYWxsIHRoZQo+IGRpc2N1
c3Npb25zIGFib3V0IHByZXZlbnRpbmcgZ3VwIGZvciBibyBtYXBwaW5ncyBpbiBnZW5lcmFsLgo+
Cj4gT25jZSB3ZSB0aHJvdyBobW0gaW50byB0aGUgbWl4IHdlIG5lZWQgdG8gYmUgcmVhbGx5IGNh
cmVmdWwgdGhhdCB0aGUgdHdvCj4gd29ybGRzIGRvbid0IGNvbGxpZGUuIFB1cmUgaG1tIGlzIGZp
bmUsIHB1cmUgYm8gbWFuYWdlZCBtZW1vcnkgaXMgZmluZSwKPiBtaXhpbmcgdGhlbSBpcyB0cmlj
a3kuCj4gLURhbmllbAoKSG1tLCBPSyBzbyB0aGVuIHJlZ2lzdGVyaW5nIE1FTU9SWV9ERVZJQ0Vf
UFJJVkFURSBtZWFucyB3ZSBjYW4ndCBzZXQgCnB4eF9kZXZtYXAgYmVjYXVzZSB0aGF0IHdvdWxk
IGFsbG93IGd1cCwgd2hpY2gsIGluIHR1cm4sIG1lYW5zIG5vIGh1Z2UgClRUTSBwdGVzLgoKL1Ro
b21hcwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1k
LWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9s
aXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
