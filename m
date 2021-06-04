Return-Path: <SRS0=YIqZ=K6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40CF2C07E94
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Jun 2021 13:09:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E6A9613D8
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Jun 2021 13:09:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E6A9613D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daenzer.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C8D348919B;
	Fri,  4 Jun 2021 13:09:07 +0000 (UTC)
Received: from netline-mail3.netline.ch (mail.netline.ch [148.251.143.180])
 by gabe.freedesktop.org (Postfix) with ESMTP id AB2198919B
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Jun 2021 13:09:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by netline-mail3.netline.ch (Postfix) with ESMTP id 705F320201D;
 Fri,  4 Jun 2021 15:09:05 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at netline-mail3.netline.ch
Received: from netline-mail3.netline.ch ([127.0.0.1])
 by localhost (netline-mail3.netline.ch [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id H1HksiXyB_pL; Fri,  4 Jun 2021 15:09:00 +0200 (CEST)
Received: from thor (24.99.2.85.dynamic.wline.res.cust.swisscom.ch
 [85.2.99.24])
 by netline-mail3.netline.ch (Postfix) with ESMTPA id 7B0DB20201A;
 Fri,  4 Jun 2021 15:09:00 +0200 (CEST)
Received: from [::1] by thor with esmtp (Exim 4.94.2)
 (envelope-from <michel@daenzer.net>)
 id 1lp9ZL-0004hk-EH; Fri, 04 Jun 2021 15:08:59 +0200
To: Alex Deucher <alexdeucher@gmail.com>
References: <a4ba9456-812b-5280-75fd-6dd66d1f9718@riseup.net>
 <22c25fa6-b3eb-b778-8598-3ce1947a3d0b@daenzer.net>
 <CADnq5_OVjssNi2niLZQs-TOyN5T5EFOnpwmpmbvHRgh_M0B=wg@mail.gmail.com>
 <7a9f2682-559d-57ec-4879-b1e6f743c375@daenzer.net>
 <CADnq5_O+FjF0R0OEMyPZ-hzg7d2Fx87NBUjax8_XLF4b71oKmg@mail.gmail.com>
 <7ecaff42-68e4-7566-0da1-fa3475fcacb3@daenzer.net>
 <CADnq5_MEFyQA6s7+4FKKq3qT_6i2ue=n5+CswPpB3H5Kt3ybuw@mail.gmail.com>
From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>
Subject: Re: AMDGPU error: "[drm:amdgpu_dm_atomic_commit_tail [amdgpu]]
 *ERROR* Waiting for fences timed out!"
Message-ID: <65f5567e-4c5c-6e20-a379-e7182bcacb1f@daenzer.net>
Date: Fri, 4 Jun 2021 15:08:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <CADnq5_MEFyQA6s7+4FKKq3qT_6i2ue=n5+CswPpB3H5Kt3ybuw@mail.gmail.com>
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

T24gMjAyMS0wNi0wNCAyOjMzIHAubS4sIEFsZXggRGV1Y2hlciB3cm90ZToKPiBPbiBGcmksIEp1
biA0LCAyMDIxIGF0IDM6NDcgQU0gTWljaGVsIETDpG56ZXIgPG1pY2hlbEBkYWVuemVyLm5ldD4g
d3JvdGU6Cj4+Cj4+IE9uIDIwMjEtMDUtMTkgMzo1NyBwLm0uLCBBbGV4IERldWNoZXIgd3JvdGU6
Cj4+PiBPbiBXZWQsIE1heSAxOSwgMjAyMSBhdCA0OjQ4IEFNIE1pY2hlbCBEw6RuemVyIDxtaWNo
ZWxAZGFlbnplci5uZXQ+IHdyb3RlOgo+Pj4+Cj4+Pj4gT24gMjAyMS0wNS0xOSAxMjowNSBhLm0u
LCBBbGV4IERldWNoZXIgd3JvdGU6Cj4+Pj4+IE9uIFR1ZSwgTWF5IDE4LCAyMDIxIGF0IDEwOjEx
IEFNIE1pY2hlbCBEw6RuemVyIDxtaWNoZWxAZGFlbnplci5uZXQ+IHdyb3RlOgo+Pj4+Pj4KPj4+
Pj4+IE9uIDIwMjEtMDUtMTcgMTE6MzMgYS5tLiwgeGdxdCB3cm90ZToKPj4+Pj4+PiBIZWxsbyEK
Pj4+Pj4+Pgo+Pj4+Pj4+IEkgcnVuIGEgQU1EIGxhcHRvcCAiODFOQyBMZW5vdm8gSWRlYVBhZCBT
MzQwLTE1QVBJIiAtIEFNRCBSeXplbiA1IDM1MDBVIHdpdGggUmFkZW9uIFZlZ2EgOCBHcmFwaGlj
cy4KPj4+Pj4+PiBSZWNlbnRseSBzb21lIGJyZWFrYWdlcyBzdGFydGVkIGhhcHBlbmluZyBmb3Ig
bWUuIEluIGFib3V0IDFoIGFmdGVyIGJvb3QtdXAgd2hpbGUgdXNpbmcgYSBLREUgZGVza3RvcCBt
YWNoaW5lIEdVSSB3b3VsZCBmcmVlemUuIFNvbWV0aW1lcyBpdCB3b3VsZCBiZSBwb3NzaWJsZSB0
byBtb3ZlIHRoZSBtb3VzZSBidXQgdGhlIHJlc3Qgd2lsbCBiZSBmcm96ZW4uIFNjcmVlbiBtYXkg
c3RhcnQgYmxpbmtpbmcgb3IgZ28gYmxhY2suCj4+Pj4+Pj4KPj4+Pj4+PiBJJ20gbm90IHN1cmUg
aWYgdGhpcyBpcyBteSBrZXJuZWwsIGZpcm13YXJlIG9yIHRoZSBoYXJkd2FyZS4KPj4+Pj4+PiBJ
IGRvbid0IHVuZGVyc3RhbmRzIGRtZXNnIHRoYXQncyB3aHkgSSdtIGd1ZXNzaW5nLCBidXQgSSB0
aGluayBpdCBpcyB0aGUgZmlybXdhcmUgc2luY2UgdGhpcyBiZWhhdmlvciBzdGFydGVkIGFyb3Vu
ZCAyMDIxLTA1LTE1Lgo+Pj4+Pj4+IEZyb20gbXkgUG9ydGFnZSBsb2dzIEkgc2VlIHRoYXQgSSB1
cGRhdGVkIG15IGZpcm13YXJlIG9uIDIwMjEtMDUtMTQgYXQgMTg6MTY6MDYuCj4+Pj4+Pj4gU28g
YnJlYWthZ2VzIHN0YXJ0ZWQgd2l0aCBteSBrZXJuZWw6IDUuMTAuMjcgYW5kIEZXOiAyMDIxMDUx
MS4KPj4+Pj4+PiBBZnRlciBicmVha2FnZSBJIGp1bXBlZCB0byBhIG9sZGVyIGtlcm5lbCA1LjQu
OTcgYW5kIGNvbXBpbGVkIDUuMTIuNC4gSSBkaWRuJ3Qgbm90aWNlIGEgYnJlYWthZ2Ugb24gNS40
Ljk3IGJ1dCBzeXN0ZW0gcmFuIH40MCBtaW51dGVzLgo+Pj4+Pj4+IFNvIEkgYm9vdGVkIHRvIG5l
d2x5IGNvbXBpbGVkIDUuMTIuNCB3aGVyZSBJIHdhcyB+MWggYW5kIGl0IGJyb2tlLgo+Pj4+Pj4+
IEFmdGVyIHRoYXQgSSBib290ZWQgdG8gNS40Ljk3IGFnYWluIGFuZCBkb3duZ3JhZGVkIG15IEZX
Lgo+Pj4+Pj4+IFdoaWxlIEknbSB3cml0aW5nIHRoaXMgSSdtIGJvb3RlZCB0byBrZXJuZWw6IDUu
MTIuNCB3aXRoIEZXOiAyMDIxMDMxNS4KPj4+Pj4+Pgo+Pj4+Pj4+IEkgYWxzbyBkZXNjcmliZWQg
bXkgc2l0dWF0aW9uIG9uIHRoZSBHZW50b28gYnVnemlsbGE6IGh0dHBzOi8vYnVncy5nZW50b28u
b3JnLzc5MDU2Ngo+Pj4+Pj4+Cj4+Pj4+Pj4gImRtZXNnLmxvZyIgYXR0YWNoZWQgaGVyZSBpcyBm
cm9tIHRoZSB0aW1lIG1hY2hpbmUgcnVuIGZpbmUgKGF0IHRoZSBtb21lbnQpOyAiZXJyb3JzX3Nh
dF9tYXlfMTVfMDcyODI1X3BtX2Nlc3RfMjAyMS5sb2ciIGlzIGEgZG1lc2cgbG9nIGZyb20gdGhl
IHRpbWUgc3lzdGVtIGJyb2tlCj4+Pj4+Pj4KPj4+Pj4+PiBDYW4gSSBnZXQgYW55IGhlbHAgd2l0
aCB0aGlzPyBXaGF0IGFyZSB0aGUgbmV4dCBzdGVwcyBJIHNob3VsZCB0YWtlPyBBbnkgb3RoZXIg
ZmlsZXMgSSBzaG91bGQgcHJvdmlkZT8KPj4+Pj4+Cj4+Pj4+PiBJJ3ZlIGhpdCBzaW1pbGFyIGhh
bmdzIHdpdGggYSBMZW5vdm8gVGhpbmtQYWQgRTU5NSAoUnl6ZW4gNyAzNzAwVSAvIFBpY2Fzc28g
LyBSQVZFTiAweDEwMDI6MHgxNUQ4IDB4MTdBQToweDUxMjQgMHhDMSkuIEknbSBhbHNvIHN1c3Bl
Y3RpbmcgdGhlbSB0byBiZSBmaXJ3YXJlIHJlbGF0ZWQuIFRoZSBoYW5ncyBvY2N1cnJlZCB3aXRo
IGZpcm13YXJlIGZyb20gdGhlIEFNRCAyMC41MCByZWxlYXNlLiBJJ20gY3VycmVudGx5IHJ1bm5p
bmcgd2l0aCBmaXJtd2FyZSBmcm9tIHRoZSAyMC40MCByZWxlYXNlLCBubyBoYW5nIGluIGFsbW9z
dCAyIHdlZWtzICh0aGUgaGFuZ3MgaGFwcGVuZWQgd2l0aGluIDEtMiBkYXlzIGFmdGVyIGJvb3Qp
Lgo+Pj4+Pgo+Pj4+PiBDYW4geW91IG5hcnJvdyBkb3duIHdoaWNoIGZpcm13YXJlKHMpIGNhdXNl
IHRoZSBwcm9ibGVtPwo+Pj4+Cj4+Pj4gSSdsbCB0cnksIGJ1dCBub3RlIEknbSBub3QgcmVhbGx5
IHN1cmUgeWV0IG15IGhhbmdzIHdlcmUgcmVsYXRlZCB0byBmaXJtd2FyZSAob25seSkuIEFueXdh
eSwgSSdsbCB0cnkgbmFycm93aW5nIGl0IGRvd24uCj4+Pgo+Pj4gVGhhbmtzLiAgRG9lcyB0aGlz
IHBhdGNoIGhlbHA/Cj4+PiBodHRwczovL3BhdGNod29yay5mcmVlZGVza3RvcC5vcmcvcGF0Y2gv
NDMzNzAxLwo+Pgo+PiBVbmZvcnR1bmF0ZWx5IG5vdC4gQWZ0ZXIgbm8gaGFuZ3MgZm9yIHR3byB3
ZWVrcyB3aXRoIG9sZGVyIGZpcm13YXJlLCBJIGp1c3QgZ290IGEgaGFuZyBhZ2FpbiB3aXRoaW4g
YSBkYXkgd2l0aCBuZXdlciBmaXJtd2FyZSBhbmQgYSBrZXJuZWwgd2l0aCB0aGlzIGZpeC4KPj4K
Pj4KPj4gSSdsbCB0cnkgYW5kIG5hcnJvdyBkb3duIHdoaWNoIGZpcm13YXJlIHRyaWdnZXJzIGl0
IG5vdy4gRG9lcyBQaWNhc3NvIHVzZSB0aGUgcGljYXNzb18qLmJpbiBvbmVzIG9ubHksIG9yIG90
aGVycyBhcyB3ZWxsPwo+IAo+IFRoZSBwaWNhc3NvIG9uZXMgYW5kIHJhdmVuX2RtY3UuYmluLgoK
VGhhbmtzLiByYXZlbl9kbWN1LmJpbiBoYXNuJ3QgY2hhbmdlZCwgc28gSSdtIHRyeWluZyB0byBi
aXNlY3QgdGhlIDggUGljYXNzbyBvbmVzIHdoaWNoIGhhdmUgY2hhbmdlZDoKCnBpY2Fzc29fYXNk
LmJpbgpwaWNhc3NvX2NlLmJpbgpwaWNhc3NvX21lLmJpbgpwaWNhc3NvX21lYzIuYmluCnBpY2Fz
c29fbWVjLmJpbgpwaWNhc3NvX3BmcC5iaW4KcGljYXNzb19zZG1hLmJpbgpwaWNhc3NvX3Zjbi5i
aW4KCgotLSAKRWFydGhsaW5nIE1pY2hlbCBEw6RuemVyICAgICAgICAgICAgICAgfCAgICAgICAg
ICAgICAgIGh0dHBzOi8vcmVkaGF0LmNvbQpMaWJyZSBzb2Z0d2FyZSBlbnRodXNpYXN0ICAgICAg
ICAgICAgIHwgICAgICAgICAgICAgTWVzYSBhbmQgWCBkZXZlbG9wZXIKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1k
LWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcv
bWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
