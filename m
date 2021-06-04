Return-Path: <SRS0=YIqZ=K6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CDB8C07E94
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Jun 2021 07:47:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26ECD613AA
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Jun 2021 07:47:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26ECD613AA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daenzer.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C39366F5BE;
	Fri,  4 Jun 2021 07:47:06 +0000 (UTC)
Received: from netline-mail3.netline.ch (mail.netline.ch [148.251.143.180])
 by gabe.freedesktop.org (Postfix) with ESMTP id 109BA6F5BE
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Jun 2021 07:47:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by netline-mail3.netline.ch (Postfix) with ESMTP id 4175620201D;
 Fri,  4 Jun 2021 09:47:05 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at netline-mail3.netline.ch
Received: from netline-mail3.netline.ch ([127.0.0.1])
 by localhost (netline-mail3.netline.ch [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id MvPWjukmCkD7; Fri,  4 Jun 2021 09:47:04 +0200 (CEST)
Received: from thor (24.99.2.85.dynamic.wline.res.cust.swisscom.ch
 [85.2.99.24])
 by netline-mail3.netline.ch (Postfix) with ESMTPA id 1FA3720201C;
 Fri,  4 Jun 2021 09:47:04 +0200 (CEST)
Received: from [::1] by thor with esmtp (Exim 4.94.2)
 (envelope-from <michel@daenzer.net>)
 id 1lp4Xm-0002yn-PC; Fri, 04 Jun 2021 09:47:02 +0200
To: Alex Deucher <alexdeucher@gmail.com>
References: <a4ba9456-812b-5280-75fd-6dd66d1f9718@riseup.net>
 <22c25fa6-b3eb-b778-8598-3ce1947a3d0b@daenzer.net>
 <CADnq5_OVjssNi2niLZQs-TOyN5T5EFOnpwmpmbvHRgh_M0B=wg@mail.gmail.com>
 <7a9f2682-559d-57ec-4879-b1e6f743c375@daenzer.net>
 <CADnq5_O+FjF0R0OEMyPZ-hzg7d2Fx87NBUjax8_XLF4b71oKmg@mail.gmail.com>
From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>
Subject: Re: AMDGPU error: "[drm:amdgpu_dm_atomic_commit_tail [amdgpu]]
 *ERROR* Waiting for fences timed out!"
Message-ID: <7ecaff42-68e4-7566-0da1-fa3475fcacb3@daenzer.net>
Date: Fri, 4 Jun 2021 09:47:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <CADnq5_O+FjF0R0OEMyPZ-hzg7d2Fx87NBUjax8_XLF4b71oKmg@mail.gmail.com>
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

T24gMjAyMS0wNS0xOSAzOjU3IHAubS4sIEFsZXggRGV1Y2hlciB3cm90ZToKPiBPbiBXZWQsIE1h
eSAxOSwgMjAyMSBhdCA0OjQ4IEFNIE1pY2hlbCBEw6RuemVyIDxtaWNoZWxAZGFlbnplci5uZXQ+
IHdyb3RlOgo+Pgo+PiBPbiAyMDIxLTA1LTE5IDEyOjA1IGEubS4sIEFsZXggRGV1Y2hlciB3cm90
ZToKPj4+IE9uIFR1ZSwgTWF5IDE4LCAyMDIxIGF0IDEwOjExIEFNIE1pY2hlbCBEw6RuemVyIDxt
aWNoZWxAZGFlbnplci5uZXQ+IHdyb3RlOgo+Pj4+Cj4+Pj4gT24gMjAyMS0wNS0xNyAxMTozMyBh
Lm0uLCB4Z3F0IHdyb3RlOgo+Pj4+PiBIZWxsbyEKPj4+Pj4KPj4+Pj4gSSBydW4gYSBBTUQgbGFw
dG9wICI4MU5DIExlbm92byBJZGVhUGFkIFMzNDAtMTVBUEkiIC0gQU1EIFJ5emVuIDUgMzUwMFUg
d2l0aCBSYWRlb24gVmVnYSA4IEdyYXBoaWNzLgo+Pj4+PiBSZWNlbnRseSBzb21lIGJyZWFrYWdl
cyBzdGFydGVkIGhhcHBlbmluZyBmb3IgbWUuIEluIGFib3V0IDFoIGFmdGVyIGJvb3QtdXAgd2hp
bGUgdXNpbmcgYSBLREUgZGVza3RvcCBtYWNoaW5lIEdVSSB3b3VsZCBmcmVlemUuIFNvbWV0aW1l
cyBpdCB3b3VsZCBiZSBwb3NzaWJsZSB0byBtb3ZlIHRoZSBtb3VzZSBidXQgdGhlIHJlc3Qgd2ls
bCBiZSBmcm96ZW4uIFNjcmVlbiBtYXkgc3RhcnQgYmxpbmtpbmcgb3IgZ28gYmxhY2suCj4+Pj4+
Cj4+Pj4+IEknbSBub3Qgc3VyZSBpZiB0aGlzIGlzIG15IGtlcm5lbCwgZmlybXdhcmUgb3IgdGhl
IGhhcmR3YXJlLgo+Pj4+PiBJIGRvbid0IHVuZGVyc3RhbmRzIGRtZXNnIHRoYXQncyB3aHkgSSdt
IGd1ZXNzaW5nLCBidXQgSSB0aGluayBpdCBpcyB0aGUgZmlybXdhcmUgc2luY2UgdGhpcyBiZWhh
dmlvciBzdGFydGVkIGFyb3VuZCAyMDIxLTA1LTE1Lgo+Pj4+PiBGcm9tIG15IFBvcnRhZ2UgbG9n
cyBJIHNlZSB0aGF0IEkgdXBkYXRlZCBteSBmaXJtd2FyZSBvbiAyMDIxLTA1LTE0IGF0IDE4OjE2
OjA2Lgo+Pj4+PiBTbyBicmVha2FnZXMgc3RhcnRlZCB3aXRoIG15IGtlcm5lbDogNS4xMC4yNyBh
bmQgRlc6IDIwMjEwNTExLgo+Pj4+PiBBZnRlciBicmVha2FnZSBJIGp1bXBlZCB0byBhIG9sZGVy
IGtlcm5lbCA1LjQuOTcgYW5kIGNvbXBpbGVkIDUuMTIuNC4gSSBkaWRuJ3Qgbm90aWNlIGEgYnJl
YWthZ2Ugb24gNS40Ljk3IGJ1dCBzeXN0ZW0gcmFuIH40MCBtaW51dGVzLgo+Pj4+PiBTbyBJIGJv
b3RlZCB0byBuZXdseSBjb21waWxlZCA1LjEyLjQgd2hlcmUgSSB3YXMgfjFoIGFuZCBpdCBicm9r
ZS4KPj4+Pj4gQWZ0ZXIgdGhhdCBJIGJvb3RlZCB0byA1LjQuOTcgYWdhaW4gYW5kIGRvd25ncmFk
ZWQgbXkgRlcuCj4+Pj4+IFdoaWxlIEknbSB3cml0aW5nIHRoaXMgSSdtIGJvb3RlZCB0byBrZXJu
ZWw6IDUuMTIuNCB3aXRoIEZXOiAyMDIxMDMxNS4KPj4+Pj4KPj4+Pj4gSSBhbHNvIGRlc2NyaWJl
ZCBteSBzaXR1YXRpb24gb24gdGhlIEdlbnRvbyBidWd6aWxsYTogaHR0cHM6Ly9idWdzLmdlbnRv
by5vcmcvNzkwNTY2Cj4+Pj4+Cj4+Pj4+ICJkbWVzZy5sb2ciIGF0dGFjaGVkIGhlcmUgaXMgZnJv
bSB0aGUgdGltZSBtYWNoaW5lIHJ1biBmaW5lIChhdCB0aGUgbW9tZW50KTsgImVycm9yc19zYXRf
bWF5XzE1XzA3MjgyNV9wbV9jZXN0XzIwMjEubG9nIiBpcyBhIGRtZXNnIGxvZyBmcm9tIHRoZSB0
aW1lIHN5c3RlbSBicm9rZQo+Pj4+Pgo+Pj4+PiBDYW4gSSBnZXQgYW55IGhlbHAgd2l0aCB0aGlz
PyBXaGF0IGFyZSB0aGUgbmV4dCBzdGVwcyBJIHNob3VsZCB0YWtlPyBBbnkgb3RoZXIgZmlsZXMg
SSBzaG91bGQgcHJvdmlkZT8KPj4+Pgo+Pj4+IEkndmUgaGl0IHNpbWlsYXIgaGFuZ3Mgd2l0aCBh
IExlbm92byBUaGlua1BhZCBFNTk1IChSeXplbiA3IDM3MDBVIC8gUGljYXNzbyAvIFJBVkVOIDB4
MTAwMjoweDE1RDggMHgxN0FBOjB4NTEyNCAweEMxKS4gSSdtIGFsc28gc3VzcGVjdGluZyB0aGVt
IHRvIGJlIGZpcndhcmUgcmVsYXRlZC4gVGhlIGhhbmdzIG9jY3VycmVkIHdpdGggZmlybXdhcmUg
ZnJvbSB0aGUgQU1EIDIwLjUwIHJlbGVhc2UuIEknbSBjdXJyZW50bHkgcnVubmluZyB3aXRoIGZp
cm13YXJlIGZyb20gdGhlIDIwLjQwIHJlbGVhc2UsIG5vIGhhbmcgaW4gYWxtb3N0IDIgd2Vla3Mg
KHRoZSBoYW5ncyBoYXBwZW5lZCB3aXRoaW4gMS0yIGRheXMgYWZ0ZXIgYm9vdCkuCj4+Pgo+Pj4g
Q2FuIHlvdSBuYXJyb3cgZG93biB3aGljaCBmaXJtd2FyZShzKSBjYXVzZSB0aGUgcHJvYmxlbT8K
Pj4KPj4gSSdsbCB0cnksIGJ1dCBub3RlIEknbSBub3QgcmVhbGx5IHN1cmUgeWV0IG15IGhhbmdz
IHdlcmUgcmVsYXRlZCB0byBmaXJtd2FyZSAob25seSkuIEFueXdheSwgSSdsbCB0cnkgbmFycm93
aW5nIGl0IGRvd24uCj4gCj4gVGhhbmtzLiAgRG9lcyB0aGlzIHBhdGNoIGhlbHA/Cj4gaHR0cHM6
Ly9wYXRjaHdvcmsuZnJlZWRlc2t0b3Aub3JnL3BhdGNoLzQzMzcwMS8KClVuZm9ydHVuYXRlbHkg
bm90LiBBZnRlciBubyBoYW5ncyBmb3IgdHdvIHdlZWtzIHdpdGggb2xkZXIgZmlybXdhcmUsIEkg
anVzdCBnb3QgYSBoYW5nIGFnYWluIHdpdGhpbiBhIGRheSB3aXRoIG5ld2VyIGZpcm13YXJlIGFu
ZCBhIGtlcm5lbCB3aXRoIHRoaXMgZml4LgoKCkknbGwgdHJ5IGFuZCBuYXJyb3cgZG93biB3aGlj
aCBmaXJtd2FyZSB0cmlnZ2VycyBpdCBub3cuIERvZXMgUGljYXNzbyB1c2UgdGhlIHBpY2Fzc29f
Ki5iaW4gb25lcyBvbmx5LCBvciBvdGhlcnMgYXMgd2VsbD8KCgotLSAKRWFydGhsaW5nIE1pY2hl
bCBEw6RuemVyICAgICAgICAgICAgICAgfCAgICAgICAgICAgICAgIGh0dHBzOi8vcmVkaGF0LmNv
bQpMaWJyZSBzb2Z0d2FyZSBlbnRodXNpYXN0ICAgICAgICAgICAgIHwgICAgICAgICAgICAgTWVz
YSBhbmQgWCBkZXZlbG9wZXIKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5v
cmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
Cg==
