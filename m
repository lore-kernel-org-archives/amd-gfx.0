Return-Path: <SRS0=RLY9=KO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DA69C433B4
	for <amd-gfx@archiver.kernel.org>; Wed, 19 May 2021 08:48:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E82B611AD
	for <amd-gfx@archiver.kernel.org>; Wed, 19 May 2021 08:48:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E82B611AD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daenzer.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DDE756E19C;
	Wed, 19 May 2021 08:48:51 +0000 (UTC)
Received: from netline-mail3.netline.ch (mail.netline.ch [148.251.143.180])
 by gabe.freedesktop.org (Postfix) with ESMTP id 160FA6E19C
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 May 2021 08:48:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by netline-mail3.netline.ch (Postfix) with ESMTP id 3581820201B;
 Wed, 19 May 2021 10:48:49 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at netline-mail3.netline.ch
Received: from netline-mail3.netline.ch ([127.0.0.1])
 by localhost (netline-mail3.netline.ch [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id 7xF7pv-4cqrt; Wed, 19 May 2021 10:48:48 +0200 (CEST)
Received: from thor (24.99.2.85.dynamic.wline.res.cust.swisscom.ch
 [85.2.99.24])
 by netline-mail3.netline.ch (Postfix) with ESMTPA id 834CC20201A;
 Wed, 19 May 2021 10:48:48 +0200 (CEST)
Received: from [::1] by thor with esmtp (Exim 4.94.2)
 (envelope-from <michel@daenzer.net>)
 id 1ljHsl-000gkg-IX; Wed, 19 May 2021 10:48:47 +0200
To: Alex Deucher <alexdeucher@gmail.com>
References: <a4ba9456-812b-5280-75fd-6dd66d1f9718@riseup.net>
 <22c25fa6-b3eb-b778-8598-3ce1947a3d0b@daenzer.net>
 <CADnq5_OVjssNi2niLZQs-TOyN5T5EFOnpwmpmbvHRgh_M0B=wg@mail.gmail.com>
From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>
Subject: Re: AMDGPU error: "[drm:amdgpu_dm_atomic_commit_tail [amdgpu]]
 *ERROR* Waiting for fences timed out!"
Message-ID: <7a9f2682-559d-57ec-4879-b1e6f743c375@daenzer.net>
Date: Wed, 19 May 2021 10:48:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <CADnq5_OVjssNi2niLZQs-TOyN5T5EFOnpwmpmbvHRgh_M0B=wg@mail.gmail.com>
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

T24gMjAyMS0wNS0xOSAxMjowNSBhLm0uLCBBbGV4IERldWNoZXIgd3JvdGU6Cj4gT24gVHVlLCBN
YXkgMTgsIDIwMjEgYXQgMTA6MTEgQU0gTWljaGVsIETDpG56ZXIgPG1pY2hlbEBkYWVuemVyLm5l
dD4gd3JvdGU6Cj4+Cj4+IE9uIDIwMjEtMDUtMTcgMTE6MzMgYS5tLiwgeGdxdCB3cm90ZToKPj4+
IEhlbGxvIQo+Pj4KPj4+IEkgcnVuIGEgQU1EIGxhcHRvcCAiODFOQyBMZW5vdm8gSWRlYVBhZCBT
MzQwLTE1QVBJIiAtIEFNRCBSeXplbiA1IDM1MDBVIHdpdGggUmFkZW9uIFZlZ2EgOCBHcmFwaGlj
cy4KPj4+IFJlY2VudGx5IHNvbWUgYnJlYWthZ2VzIHN0YXJ0ZWQgaGFwcGVuaW5nIGZvciBtZS4g
SW4gYWJvdXQgMWggYWZ0ZXIgYm9vdC11cCB3aGlsZSB1c2luZyBhIEtERSBkZXNrdG9wIG1hY2hp
bmUgR1VJIHdvdWxkIGZyZWV6ZS4gU29tZXRpbWVzIGl0IHdvdWxkIGJlIHBvc3NpYmxlIHRvIG1v
dmUgdGhlIG1vdXNlIGJ1dCB0aGUgcmVzdCB3aWxsIGJlIGZyb3plbi4gU2NyZWVuIG1heSBzdGFy
dCBibGlua2luZyBvciBnbyBibGFjay4KPj4+Cj4+PiBJJ20gbm90IHN1cmUgaWYgdGhpcyBpcyBt
eSBrZXJuZWwsIGZpcm13YXJlIG9yIHRoZSBoYXJkd2FyZS4KPj4+IEkgZG9uJ3QgdW5kZXJzdGFu
ZHMgZG1lc2cgdGhhdCdzIHdoeSBJJ20gZ3Vlc3NpbmcsIGJ1dCBJIHRoaW5rIGl0IGlzIHRoZSBm
aXJtd2FyZSBzaW5jZSB0aGlzIGJlaGF2aW9yIHN0YXJ0ZWQgYXJvdW5kIDIwMjEtMDUtMTUuCj4+
PiBGcm9tIG15IFBvcnRhZ2UgbG9ncyBJIHNlZSB0aGF0IEkgdXBkYXRlZCBteSBmaXJtd2FyZSBv
biAyMDIxLTA1LTE0IGF0IDE4OjE2OjA2Lgo+Pj4gU28gYnJlYWthZ2VzIHN0YXJ0ZWQgd2l0aCBt
eSBrZXJuZWw6IDUuMTAuMjcgYW5kIEZXOiAyMDIxMDUxMS4KPj4+IEFmdGVyIGJyZWFrYWdlIEkg
anVtcGVkIHRvIGEgb2xkZXIga2VybmVsIDUuNC45NyBhbmQgY29tcGlsZWQgNS4xMi40LiBJIGRp
ZG4ndCBub3RpY2UgYSBicmVha2FnZSBvbiA1LjQuOTcgYnV0IHN5c3RlbSByYW4gfjQwIG1pbnV0
ZXMuCj4+PiBTbyBJIGJvb3RlZCB0byBuZXdseSBjb21waWxlZCA1LjEyLjQgd2hlcmUgSSB3YXMg
fjFoIGFuZCBpdCBicm9rZS4KPj4+IEFmdGVyIHRoYXQgSSBib290ZWQgdG8gNS40Ljk3IGFnYWlu
IGFuZCBkb3duZ3JhZGVkIG15IEZXLgo+Pj4gV2hpbGUgSSdtIHdyaXRpbmcgdGhpcyBJJ20gYm9v
dGVkIHRvIGtlcm5lbDogNS4xMi40IHdpdGggRlc6IDIwMjEwMzE1Lgo+Pj4KPj4+IEkgYWxzbyBk
ZXNjcmliZWQgbXkgc2l0dWF0aW9uIG9uIHRoZSBHZW50b28gYnVnemlsbGE6IGh0dHBzOi8vYnVn
cy5nZW50b28ub3JnLzc5MDU2Ngo+Pj4KPj4+ICJkbWVzZy5sb2ciIGF0dGFjaGVkIGhlcmUgaXMg
ZnJvbSB0aGUgdGltZSBtYWNoaW5lIHJ1biBmaW5lIChhdCB0aGUgbW9tZW50KTsgImVycm9yc19z
YXRfbWF5XzE1XzA3MjgyNV9wbV9jZXN0XzIwMjEubG9nIiBpcyBhIGRtZXNnIGxvZyBmcm9tIHRo
ZSB0aW1lIHN5c3RlbSBicm9rZQo+Pj4KPj4+IENhbiBJIGdldCBhbnkgaGVscCB3aXRoIHRoaXM/
IFdoYXQgYXJlIHRoZSBuZXh0IHN0ZXBzIEkgc2hvdWxkIHRha2U/IEFueSBvdGhlciBmaWxlcyBJ
IHNob3VsZCBwcm92aWRlPwo+Pgo+PiBJJ3ZlIGhpdCBzaW1pbGFyIGhhbmdzIHdpdGggYSBMZW5v
dm8gVGhpbmtQYWQgRTU5NSAoUnl6ZW4gNyAzNzAwVSAvIFBpY2Fzc28gLyBSQVZFTiAweDEwMDI6
MHgxNUQ4IDB4MTdBQToweDUxMjQgMHhDMSkuIEknbSBhbHNvIHN1c3BlY3RpbmcgdGhlbSB0byBi
ZSBmaXJ3YXJlIHJlbGF0ZWQuIFRoZSBoYW5ncyBvY2N1cnJlZCB3aXRoIGZpcm13YXJlIGZyb20g
dGhlIEFNRCAyMC41MCByZWxlYXNlLiBJJ20gY3VycmVudGx5IHJ1bm5pbmcgd2l0aCBmaXJtd2Fy
ZSBmcm9tIHRoZSAyMC40MCByZWxlYXNlLCBubyBoYW5nIGluIGFsbW9zdCAyIHdlZWtzICh0aGUg
aGFuZ3MgaGFwcGVuZWQgd2l0aGluIDEtMiBkYXlzIGFmdGVyIGJvb3QpLgo+IAo+IENhbiB5b3Ug
bmFycm93IGRvd24gd2hpY2ggZmlybXdhcmUocykgY2F1c2UgdGhlIHByb2JsZW0/CgpJJ2xsIHRy
eSwgYnV0IG5vdGUgSSdtIG5vdCByZWFsbHkgc3VyZSB5ZXQgbXkgaGFuZ3Mgd2VyZSByZWxhdGVk
IHRvIGZpcm13YXJlIChvbmx5KS4gQW55d2F5LCBJJ2xsIHRyeSBuYXJyb3dpbmcgaXQgZG93bi4K
CgotLSAKRWFydGhsaW5nIE1pY2hlbCBEw6RuemVyICAgICAgICAgICAgICAgfCAgICAgICAgICAg
ICAgIGh0dHBzOi8vcmVkaGF0LmNvbQpMaWJyZSBzb2Z0d2FyZSBlbnRodXNpYXN0ICAgICAgICAg
ICAgIHwgICAgICAgICAgICAgTWVzYSBhbmQgWCBkZXZlbG9wZXIKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdm
eEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFp
bG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
