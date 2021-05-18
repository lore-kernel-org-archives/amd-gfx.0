Return-Path: <SRS0=uqvu=KN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B33D6C433ED
	for <amd-gfx@archiver.kernel.org>; Tue, 18 May 2021 14:11:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B08A61185
	for <amd-gfx@archiver.kernel.org>; Tue, 18 May 2021 14:11:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B08A61185
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daenzer.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 503956EB8B;
	Tue, 18 May 2021 14:11:15 +0000 (UTC)
Received: from netline-mail3.netline.ch (mail.netline.ch [148.251.143.180])
 by gabe.freedesktop.org (Postfix) with ESMTP id 771826E954
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 May 2021 14:11:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by netline-mail3.netline.ch (Postfix) with ESMTP id 175C120201B;
 Tue, 18 May 2021 16:11:12 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at netline-mail3.netline.ch
Received: from netline-mail3.netline.ch ([127.0.0.1])
 by localhost (netline-mail3.netline.ch [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id BGZfZQ2ZPd6X; Tue, 18 May 2021 16:11:11 +0200 (CEST)
Received: from thor (24.99.2.85.dynamic.wline.res.cust.swisscom.ch
 [85.2.99.24])
 by netline-mail3.netline.ch (Postfix) with ESMTPA id 9649A20201A;
 Tue, 18 May 2021 16:11:11 +0200 (CEST)
Received: from [::1] by thor with esmtp (Exim 4.94.2)
 (envelope-from <michel@daenzer.net>)
 id 1lj0R5-000aSu-Uq; Tue, 18 May 2021 16:11:03 +0200
To: xgqt <xgqt@riseup.net>
References: <a4ba9456-812b-5280-75fd-6dd66d1f9718@riseup.net>
From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>
Subject: Re: AMDGPU error: "[drm:amdgpu_dm_atomic_commit_tail [amdgpu]]
 *ERROR* Waiting for fences timed out!"
Message-ID: <22c25fa6-b3eb-b778-8598-3ce1947a3d0b@daenzer.net>
Date: Tue, 18 May 2021 16:10:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <a4ba9456-812b-5280-75fd-6dd66d1f9718@riseup.net>
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

T24gMjAyMS0wNS0xNyAxMTozMyBhLm0uLCB4Z3F0IHdyb3RlOgo+IEhlbGxvIQo+IAo+IEkgcnVu
IGEgQU1EIGxhcHRvcCAiODFOQyBMZW5vdm8gSWRlYVBhZCBTMzQwLTE1QVBJIiAtIEFNRCBSeXpl
biA1IDM1MDBVIHdpdGggUmFkZW9uIFZlZ2EgOCBHcmFwaGljcy4KPiBSZWNlbnRseSBzb21lIGJy
ZWFrYWdlcyBzdGFydGVkIGhhcHBlbmluZyBmb3IgbWUuIEluIGFib3V0IDFoIGFmdGVyIGJvb3Qt
dXAgd2hpbGUgdXNpbmcgYSBLREUgZGVza3RvcCBtYWNoaW5lIEdVSSB3b3VsZCBmcmVlemUuIFNv
bWV0aW1lcyBpdCB3b3VsZCBiZSBwb3NzaWJsZSB0byBtb3ZlIHRoZSBtb3VzZSBidXQgdGhlIHJl
c3Qgd2lsbCBiZSBmcm96ZW4uIFNjcmVlbiBtYXkgc3RhcnQgYmxpbmtpbmcgb3IgZ28gYmxhY2su
Cj4gCj4gSSdtIG5vdCBzdXJlIGlmIHRoaXMgaXMgbXkga2VybmVsLCBmaXJtd2FyZSBvciB0aGUg
aGFyZHdhcmUuCj4gSSBkb24ndCB1bmRlcnN0YW5kcyBkbWVzZyB0aGF0J3Mgd2h5IEknbSBndWVz
c2luZywgYnV0IEkgdGhpbmsgaXQgaXMgdGhlIGZpcm13YXJlIHNpbmNlIHRoaXMgYmVoYXZpb3Ig
c3RhcnRlZCBhcm91bmQgMjAyMS0wNS0xNS4KPiBGcm9tIG15IFBvcnRhZ2UgbG9ncyBJIHNlZSB0
aGF0IEkgdXBkYXRlZCBteSBmaXJtd2FyZSBvbiAyMDIxLTA1LTE0IGF0IDE4OjE2OjA2Lgo+IFNv
IGJyZWFrYWdlcyBzdGFydGVkIHdpdGggbXkga2VybmVsOiA1LjEwLjI3IGFuZCBGVzogMjAyMTA1
MTEuCj4gQWZ0ZXIgYnJlYWthZ2UgSSBqdW1wZWQgdG8gYSBvbGRlciBrZXJuZWwgNS40Ljk3IGFu
ZCBjb21waWxlZCA1LjEyLjQuIEkgZGlkbid0IG5vdGljZSBhIGJyZWFrYWdlIG9uIDUuNC45NyBi
dXQgc3lzdGVtIHJhbiB+NDAgbWludXRlcy4KPiBTbyBJIGJvb3RlZCB0byBuZXdseSBjb21waWxl
ZCA1LjEyLjQgd2hlcmUgSSB3YXMgfjFoIGFuZCBpdCBicm9rZS4KPiBBZnRlciB0aGF0IEkgYm9v
dGVkIHRvIDUuNC45NyBhZ2FpbiBhbmQgZG93bmdyYWRlZCBteSBGVy4KPiBXaGlsZSBJJ20gd3Jp
dGluZyB0aGlzIEknbSBib290ZWQgdG8ga2VybmVsOiA1LjEyLjQgd2l0aCBGVzogMjAyMTAzMTUu
Cj4gCj4gSSBhbHNvIGRlc2NyaWJlZCBteSBzaXR1YXRpb24gb24gdGhlIEdlbnRvbyBidWd6aWxs
YTogaHR0cHM6Ly9idWdzLmdlbnRvby5vcmcvNzkwNTY2Cj4gCj4gImRtZXNnLmxvZyIgYXR0YWNo
ZWQgaGVyZSBpcyBmcm9tIHRoZSB0aW1lIG1hY2hpbmUgcnVuIGZpbmUgKGF0IHRoZSBtb21lbnQp
OyAiZXJyb3JzX3NhdF9tYXlfMTVfMDcyODI1X3BtX2Nlc3RfMjAyMS5sb2ciIGlzIGEgZG1lc2cg
bG9nIGZyb20gdGhlIHRpbWUgc3lzdGVtIGJyb2tlCj4gCj4gQ2FuIEkgZ2V0IGFueSBoZWxwIHdp
dGggdGhpcz8gV2hhdCBhcmUgdGhlIG5leHQgc3RlcHMgSSBzaG91bGQgdGFrZT8gQW55IG90aGVy
IGZpbGVzIEkgc2hvdWxkIHByb3ZpZGU/CgpJJ3ZlIGhpdCBzaW1pbGFyIGhhbmdzIHdpdGggYSBM
ZW5vdm8gVGhpbmtQYWQgRTU5NSAoUnl6ZW4gNyAzNzAwVSAvIFBpY2Fzc28gLyBSQVZFTiAweDEw
MDI6MHgxNUQ4IDB4MTdBQToweDUxMjQgMHhDMSkuIEknbSBhbHNvIHN1c3BlY3RpbmcgdGhlbSB0
byBiZSBmaXJ3YXJlIHJlbGF0ZWQuIFRoZSBoYW5ncyBvY2N1cnJlZCB3aXRoIGZpcm13YXJlIGZy
b20gdGhlIEFNRCAyMC41MCByZWxlYXNlLiBJJ20gY3VycmVudGx5IHJ1bm5pbmcgd2l0aCBmaXJt
d2FyZSBmcm9tIHRoZSAyMC40MCByZWxlYXNlLCBubyBoYW5nIGluIGFsbW9zdCAyIHdlZWtzICh0
aGUgaGFuZ3MgaGFwcGVuZWQgd2l0aGluIDEtMiBkYXlzIGFmdGVyIGJvb3QpLgoKCi0tIApFYXJ0
aGxpbmcgTWljaGVsIETDpG56ZXIgICAgICAgICAgICAgICB8ICAgICAgICAgICAgICAgaHR0cHM6
Ly9yZWRoYXQuY29tCkxpYnJlIHNvZnR3YXJlIGVudGh1c2lhc3QgICAgICAgICAgICAgfCAgICAg
ICAgICAgICBNZXNhIGFuZCBYIGRldmVsb3BlcgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZy
ZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2FtZC1nZngK
