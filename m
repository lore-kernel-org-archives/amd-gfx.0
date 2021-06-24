Return-Path: <SRS0=QFXE=LS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16498C48BDF
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Jun 2021 10:51:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5AB3E613DA
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Jun 2021 10:51:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AB3E613DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daenzer.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A5746EB56;
	Thu, 24 Jun 2021 10:51:20 +0000 (UTC)
Received: from netline-mail3.netline.ch (mail.netline.ch [148.251.143.180])
 by gabe.freedesktop.org (Postfix) with ESMTP id 822396EB56
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Jun 2021 10:51:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by netline-mail3.netline.ch (Postfix) with ESMTP id 8909B20201B;
 Thu, 24 Jun 2021 12:51:17 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at netline-mail3.netline.ch
Received: from netline-mail3.netline.ch ([127.0.0.1])
 by localhost (netline-mail3.netline.ch [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id zqR8GFn5qbLC; Thu, 24 Jun 2021 12:51:17 +0200 (CEST)
Received: from thor (24.99.2.85.dynamic.wline.res.cust.swisscom.ch
 [85.2.99.24])
 by netline-mail3.netline.ch (Postfix) with ESMTPA id D0A4220201A;
 Thu, 24 Jun 2021 12:51:16 +0200 (CEST)
Received: from localhost ([::1]) by thor with esmtp (Exim 4.94.2)
 (envelope-from <michel@daenzer.net>)
 id 1lwMx0-00025S-R7; Thu, 24 Jun 2021 12:51:15 +0200
From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>
To: Alex Deucher <alexdeucher@gmail.com>
References: <a4ba9456-812b-5280-75fd-6dd66d1f9718@riseup.net>
 <22c25fa6-b3eb-b778-8598-3ce1947a3d0b@daenzer.net>
 <CADnq5_OVjssNi2niLZQs-TOyN5T5EFOnpwmpmbvHRgh_M0B=wg@mail.gmail.com>
 <7a9f2682-559d-57ec-4879-b1e6f743c375@daenzer.net>
 <CADnq5_O+FjF0R0OEMyPZ-hzg7d2Fx87NBUjax8_XLF4b71oKmg@mail.gmail.com>
 <7ecaff42-68e4-7566-0da1-fa3475fcacb3@daenzer.net>
 <CADnq5_MEFyQA6s7+4FKKq3qT_6i2ue=n5+CswPpB3H5Kt3ybuw@mail.gmail.com>
 <65f5567e-4c5c-6e20-a379-e7182bcacb1f@daenzer.net>
Subject: Re: AMDGPU error: "[drm:amdgpu_dm_atomic_commit_tail [amdgpu]]
 *ERROR* Waiting for fences timed out!"
Message-ID: <c2b9b42d-55e1-fa5d-8e10-ea474fcd9221@daenzer.net>
Date: Thu, 24 Jun 2021 12:51:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <65f5567e-4c5c-6e20-a379-e7182bcacb1f@daenzer.net>
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

T24gMjAyMS0wNi0wNCAzOjA4IHAubS4sIE1pY2hlbCBEw6RuemVyIHdyb3RlOgo+IE9uIDIwMjEt
MDYtMDQgMjozMyBwLm0uLCBBbGV4IERldWNoZXIgd3JvdGU6Cj4+IE9uIEZyaSwgSnVuIDQsIDIw
MjEgYXQgMzo0NyBBTSBNaWNoZWwgRMOkbnplciA8bWljaGVsQGRhZW56ZXIubmV0PiB3cm90ZToK
Pj4+Cj4+PiBPbiAyMDIxLTA1LTE5IDM6NTcgcC5tLiwgQWxleCBEZXVjaGVyIHdyb3RlOgo+Pj4+
IE9uIFdlZCwgTWF5IDE5LCAyMDIxIGF0IDQ6NDggQU0gTWljaGVsIETDpG56ZXIgPG1pY2hlbEBk
YWVuemVyLm5ldD4gd3JvdGU6Cj4+Pj4+Cj4+Pj4+IE9uIDIwMjEtMDUtMTkgMTI6MDUgYS5tLiwg
QWxleCBEZXVjaGVyIHdyb3RlOgo+Pj4+Pj4gT24gVHVlLCBNYXkgMTgsIDIwMjEgYXQgMTA6MTEg
QU0gTWljaGVsIETDpG56ZXIgPG1pY2hlbEBkYWVuemVyLm5ldD4gd3JvdGU6Cj4+Pj4+Pj4KPj4+
Pj4+PiBPbiAyMDIxLTA1LTE3IDExOjMzIGEubS4sIHhncXQgd3JvdGU6Cj4+Pj4+Pj4+IEhlbGxv
IQo+Pj4+Pj4+Pgo+Pj4+Pj4+PiBJIHJ1biBhIEFNRCBsYXB0b3AgIjgxTkMgTGVub3ZvIElkZWFQ
YWQgUzM0MC0xNUFQSSIgLSBBTUQgUnl6ZW4gNSAzNTAwVSB3aXRoIFJhZGVvbiBWZWdhIDggR3Jh
cGhpY3MuCj4+Pj4+Pj4+IFJlY2VudGx5IHNvbWUgYnJlYWthZ2VzIHN0YXJ0ZWQgaGFwcGVuaW5n
IGZvciBtZS4gSW4gYWJvdXQgMWggYWZ0ZXIgYm9vdC11cCB3aGlsZSB1c2luZyBhIEtERSBkZXNr
dG9wIG1hY2hpbmUgR1VJIHdvdWxkIGZyZWV6ZS4gU29tZXRpbWVzIGl0IHdvdWxkIGJlIHBvc3Np
YmxlIHRvIG1vdmUgdGhlIG1vdXNlIGJ1dCB0aGUgcmVzdCB3aWxsIGJlIGZyb3plbi4gU2NyZWVu
IG1heSBzdGFydCBibGlua2luZyBvciBnbyBibGFjay4KPj4+Pj4+Pj4KPj4+Pj4+Pj4gSSdtIG5v
dCBzdXJlIGlmIHRoaXMgaXMgbXkga2VybmVsLCBmaXJtd2FyZSBvciB0aGUgaGFyZHdhcmUuCj4+
Pj4+Pj4+IEkgZG9uJ3QgdW5kZXJzdGFuZHMgZG1lc2cgdGhhdCdzIHdoeSBJJ20gZ3Vlc3Npbmcs
IGJ1dCBJIHRoaW5rIGl0IGlzIHRoZSBmaXJtd2FyZSBzaW5jZSB0aGlzIGJlaGF2aW9yIHN0YXJ0
ZWQgYXJvdW5kIDIwMjEtMDUtMTUuCj4+Pj4+Pj4+IEZyb20gbXkgUG9ydGFnZSBsb2dzIEkgc2Vl
IHRoYXQgSSB1cGRhdGVkIG15IGZpcm13YXJlIG9uIDIwMjEtMDUtMTQgYXQgMTg6MTY6MDYuCj4+
Pj4+Pj4+IFNvIGJyZWFrYWdlcyBzdGFydGVkIHdpdGggbXkga2VybmVsOiA1LjEwLjI3IGFuZCBG
VzogMjAyMTA1MTEuCj4+Pj4+Pj4+IEFmdGVyIGJyZWFrYWdlIEkganVtcGVkIHRvIGEgb2xkZXIg
a2VybmVsIDUuNC45NyBhbmQgY29tcGlsZWQgNS4xMi40LiBJIGRpZG4ndCBub3RpY2UgYSBicmVh
a2FnZSBvbiA1LjQuOTcgYnV0IHN5c3RlbSByYW4gfjQwIG1pbnV0ZXMuCj4+Pj4+Pj4+IFNvIEkg
Ym9vdGVkIHRvIG5ld2x5IGNvbXBpbGVkIDUuMTIuNCB3aGVyZSBJIHdhcyB+MWggYW5kIGl0IGJy
b2tlLgo+Pj4+Pj4+PiBBZnRlciB0aGF0IEkgYm9vdGVkIHRvIDUuNC45NyBhZ2FpbiBhbmQgZG93
bmdyYWRlZCBteSBGVy4KPj4+Pj4+Pj4gV2hpbGUgSSdtIHdyaXRpbmcgdGhpcyBJJ20gYm9vdGVk
IHRvIGtlcm5lbDogNS4xMi40IHdpdGggRlc6IDIwMjEwMzE1Lgo+Pj4+Pj4+Pgo+Pj4+Pj4+PiBJ
IGFsc28gZGVzY3JpYmVkIG15IHNpdHVhdGlvbiBvbiB0aGUgR2VudG9vIGJ1Z3ppbGxhOiBodHRw
czovL2J1Z3MuZ2VudG9vLm9yZy83OTA1NjYKPj4+Pj4+Pj4KPj4+Pj4+Pj4gImRtZXNnLmxvZyIg
YXR0YWNoZWQgaGVyZSBpcyBmcm9tIHRoZSB0aW1lIG1hY2hpbmUgcnVuIGZpbmUgKGF0IHRoZSBt
b21lbnQpOyAiZXJyb3JzX3NhdF9tYXlfMTVfMDcyODI1X3BtX2Nlc3RfMjAyMS5sb2ciIGlzIGEg
ZG1lc2cgbG9nIGZyb20gdGhlIHRpbWUgc3lzdGVtIGJyb2tlCj4+Pj4+Pj4+Cj4+Pj4+Pj4+IENh
biBJIGdldCBhbnkgaGVscCB3aXRoIHRoaXM/IFdoYXQgYXJlIHRoZSBuZXh0IHN0ZXBzIEkgc2hv
dWxkIHRha2U/IEFueSBvdGhlciBmaWxlcyBJIHNob3VsZCBwcm92aWRlPwo+Pj4+Pj4+Cj4+Pj4+
Pj4gSSd2ZSBoaXQgc2ltaWxhciBoYW5ncyB3aXRoIGEgTGVub3ZvIFRoaW5rUGFkIEU1OTUgKFJ5
emVuIDcgMzcwMFUgLyBQaWNhc3NvIC8gUkFWRU4gMHgxMDAyOjB4MTVEOCAweDE3QUE6MHg1MTI0
IDB4QzEpLiBJJ20gYWxzbyBzdXNwZWN0aW5nIHRoZW0gdG8gYmUgZmlyd2FyZSByZWxhdGVkLiBU
aGUgaGFuZ3Mgb2NjdXJyZWQgd2l0aCBmaXJtd2FyZSBmcm9tIHRoZSBBTUQgMjAuNTAgcmVsZWFz
ZS4gSSdtIGN1cnJlbnRseSBydW5uaW5nIHdpdGggZmlybXdhcmUgZnJvbSB0aGUgMjAuNDAgcmVs
ZWFzZSwgbm8gaGFuZyBpbiBhbG1vc3QgMiB3ZWVrcyAodGhlIGhhbmdzIGhhcHBlbmVkIHdpdGhp
biAxLTIgZGF5cyBhZnRlciBib290KS4KPj4+Pj4+Cj4+Pj4+PiBDYW4geW91IG5hcnJvdyBkb3du
IHdoaWNoIGZpcm13YXJlKHMpIGNhdXNlIHRoZSBwcm9ibGVtPwo+Pj4+Pgo+Pj4+PiBJJ2xsIHRy
eSwgYnV0IG5vdGUgSSdtIG5vdCByZWFsbHkgc3VyZSB5ZXQgbXkgaGFuZ3Mgd2VyZSByZWxhdGVk
IHRvIGZpcm13YXJlIChvbmx5KS4gQW55d2F5LCBJJ2xsIHRyeSBuYXJyb3dpbmcgaXQgZG93bi4K
Pj4+Pgo+Pj4+IFRoYW5rcy4gIERvZXMgdGhpcyBwYXRjaCBoZWxwPwo+Pj4+IGh0dHBzOi8vcGF0
Y2h3b3JrLmZyZWVkZXNrdG9wLm9yZy9wYXRjaC80MzM3MDEvCj4+Pgo+Pj4gVW5mb3J0dW5hdGVs
eSBub3QuIEFmdGVyIG5vIGhhbmdzIGZvciB0d28gd2Vla3Mgd2l0aCBvbGRlciBmaXJtd2FyZSwg
SSBqdXN0IGdvdCBhIGhhbmcgYWdhaW4gd2l0aGluIGEgZGF5IHdpdGggbmV3ZXIgZmlybXdhcmUg
YW5kIGEga2VybmVsIHdpdGggdGhpcyBmaXguCj4+Pgo+Pj4KPj4+IEknbGwgdHJ5IGFuZCBuYXJy
b3cgZG93biB3aGljaCBmaXJtd2FyZSB0cmlnZ2VycyBpdCBub3cuIERvZXMgUGljYXNzbyB1c2Ug
dGhlIHBpY2Fzc29fKi5iaW4gb25lcyBvbmx5LCBvciBvdGhlcnMgYXMgd2VsbD8KPj4KPj4gVGhl
IHBpY2Fzc28gb25lcyBhbmQgcmF2ZW5fZG1jdS5iaW4uCj4gCj4gVGhhbmtzLiByYXZlbl9kbWN1
LmJpbiBoYXNuJ3QgY2hhbmdlZCwgc28gSSdtIHRyeWluZyB0byBiaXNlY3QgdGhlIDggUGljYXNz
byBvbmVzIHdoaWNoIGhhdmUgY2hhbmdlZDoKPiAKPiBwaWNhc3NvX2FzZC5iaW4KPiBwaWNhc3Nv
X2NlLmJpbgo+IHBpY2Fzc29fbWUuYmluCj4gcGljYXNzb19tZWMyLmJpbgo+IHBpY2Fzc29fbWVj
LmJpbgo+IHBpY2Fzc29fcGZwLmJpbgo+IHBpY2Fzc29fc2RtYS5iaW4KPiBwaWNhc3NvX3Zjbi5i
aW4KClRoaW5ncyBhcmUgcG9pbnRpbmcgdG8gcGljYXNzb19zZG1hLmJpbi4gSSdtIGN1cnJlbnRs
eSBydW5uaW5nIHdpdGggb25seSB0aGF0IG9uZSByZXZlcnRlZCB0byBsaW51eC1maXJtd2FyZSAy
MDIxMDMxNSwgYW5kIGhhdmVuJ3QgZ290IGFueSBoYW5ncyBmb3IgYSB3ZWVrLgoKTm90ZSB0aGF0
IEkndmUgcHJldmlvdXNseSBnb25lIGZvciBhIHdlZWsgd2l0aG91dCBhIGhhbmcgZXZlbiB3aXRo
IGZpcm13YXJlIHdoaWNoIGhhZCBodW5nIGJlZm9yZS4gU28gdGhlcmUncyBzdGlsbCBhIHNtYWxs
IGNoYW5jZSB0aGF0IEknbSBqdXN0IG9uIGFub3RoZXIgbHVja3kgcnVuLgoKVGhhdCBzYWlkLCBQ
aWVycmUtRXJpYyBoYXMgYWxzbyBob21lZCBpbiBvbiByYXZlbl9zZG1hLmJpbiBmb3Igc2ltaWxh
ciBoYW5ncywgYW5kIHJldmVydGluZyB0byBvbGRlciBmaXJtd2FyZSBzZWVtcyB0byBoYXZlIGhl
bHBlZCBtdWx0aXBsZSBwZW9wbGUgb24gYnVnIHJlcG9ydHMuCgpTbywgSSB0aGluayBpdCBtYWtl
cyBzZW5zZSBmb3IgeW91IGd1eXMgdG8gc3RhcnQgbG9va2luZyBmb3Igd2hhdCBjb3VsZCBiZSBn
b2luZyB3cm9uZyB3aXRoIHRoZSBQaWNhc3NvL1JhdmVuIFNETUEgZmlybXdhcmUgZnJvbSAyMC41
MC4gT25lIHRoaW5nIEkgbm90aWNlZCBpcyB0aGF0IHRoZSBTRE1BIGZpcm13YXJlIGZyb20gMjAu
NTAgYWR2ZXJ0aXNlcyB0aGUgc2FtZSBmZWF0dXJlIHZlcnNpb24sIGJ1dCBhICpsb3dlciogZmly
bXdhcmUgdmVyc2lvbiB0aGFuIHRoZSBvbmUgZnJvbSAxOC41MC4gU28gaXQgbWlnaHQgYmUgd29y
dGggZG91YmxlLWNoZWNraW5nIHRoYXQgdGhlcmUgd2Fzbid0IGFuIGFjY2lkZW50YWwgZG93bmdy
YWRlIHRvIHNvbWUgb2xkZXIgdmVyc2lvbi4KCgotLSAKRWFydGhsaW5nIE1pY2hlbCBEw6RuemVy
ICAgICAgICAgICAgICAgfCAgICAgICAgICAgICAgIGh0dHBzOi8vcmVkaGF0LmNvbQpMaWJyZSBz
b2Z0d2FyZSBlbnRodXNpYXN0ICAgICAgICAgICAgIHwgICAgICAgICAgICAgTWVzYSBhbmQgWCBk
ZXZlbG9wZXIKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
YW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6
Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
