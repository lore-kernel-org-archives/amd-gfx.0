Return-Path: <SRS0=BT7C=ID=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0526DC433DB
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Mar 2021 09:24:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3904F64FD6
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Mar 2021 09:24:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3904F64FD6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daenzer.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C3F686EB2B;
	Fri,  5 Mar 2021 09:24:44 +0000 (UTC)
Received: from netline-mail3.netline.ch (mail.netline.ch [148.251.143.178])
 by gabe.freedesktop.org (Postfix) with ESMTP id A30346EB2B
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Mar 2021 09:24:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by netline-mail3.netline.ch (Postfix) with ESMTP id A131B2A6045;
 Fri,  5 Mar 2021 10:24:42 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at netline-mail3.netline.ch
Received: from netline-mail3.netline.ch ([127.0.0.1])
 by localhost (netline-mail3.netline.ch [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id qYRfMUL0xRe2; Fri,  5 Mar 2021 10:24:42 +0100 (CET)
Received: from thor (24.99.2.85.dynamic.wline.res.cust.swisscom.ch
 [85.2.99.24])
 by netline-mail3.netline.ch (Postfix) with ESMTPSA id 275C92A6042;
 Fri,  5 Mar 2021 10:24:42 +0100 (CET)
Received: from localhost ([::1]) by thor with esmtp (Exim 4.94)
 (envelope-from <michel@daenzer.net>)
 id 1lI6hN-0009ee-Gy; Fri, 05 Mar 2021 10:24:41 +0100
To: "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>,
 Daniel Vetter <daniel@ffwll.ch>
References: <I5B1EIA88M4W0bSuy9DLTgt70QGefRznp9IdJ14Cco@cp7-web-042.plabs.ch>
 <326ccbf2-8752-2fa2-b757-6811b90ecb8b@daenzer.net>
 <CAKMK7uE1+Y_agt=YCMf7OS6X-QjhAXsPO+3asWsahda11ev-eQ@mail.gmail.com>
 <e7661e4b-a99c-5be7-9912-421ac3e61ff0@daenzer.net>
 <94a2e9cd-8a14-984d-71a7-3671d7c352ab@amd.com>
 <5d62d002-faa4-ea6b-c55e-2b297e8e1b5c@daenzer.net>
 <19062958-ff28-0f1e-d891-9c030a88ecb0@amd.com>
From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>
Subject: Re: [PATCH 3/6] amd/display: fail on cursor plane without an
 underlying plane
Message-ID: <0fef827c-7aff-28bb-efda-70460cb658eb@daenzer.net>
Date: Fri, 5 Mar 2021 10:24:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <19062958-ff28-0f1e-d891-9c030a88ecb0@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Simon Ser <contact@emersion.fr>,
 Harry Wentland <hwentlan@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gMjAyMS0wMy0wNCA3OjI2IHAubS4sIEthemxhdXNrYXMsIE5pY2hvbGFzIHdyb3RlOgo+IE9u
IDIwMjEtMDMtMDQgMTA6MzUgYS5tLiwgTWljaGVsIETDpG56ZXIgd3JvdGU6Cj4+IE9uIDIwMjEt
MDMtMDQgNDowOSBwLm0uLCBLYXpsYXVza2FzLCBOaWNob2xhcyB3cm90ZToKPj4+IE9uIDIwMjEt
MDMtMDQgNDowNSBhLm0uLCBNaWNoZWwgRMOkbnplciB3cm90ZToKPj4+PiBPbiAyMDIxLTAzLTAz
IDg6MTcgcC5tLiwgRGFuaWVsIFZldHRlciB3cm90ZToKPj4+Pj4gT24gV2VkLCBNYXIgMywgMjAy
MSBhdCA1OjUzIFBNIE1pY2hlbCBEw6RuemVyIDxtaWNoZWxAZGFlbnplci5uZXQ+Cj4+Pj4+IHdy
b3RlOgo+Pj4+Pj4KPj4+Pj4+IE1vcmVvdmVyLCBpbiB0aGUgc2FtZSBzY2VuYXJpbyBwbHVzIGFu
IG92ZXJsYXkgcGxhbmUgZW5hYmxlZCB3aXRoIGEKPj4+Pj4+IEhXIGN1cnNvciBjb21wYXRpYmxl
IGZvcm1hdCwgaWYgdGhlIEZCIGJvdW5kIHRvIHRoZSBvdmVybGF5IHBsYW5lIGlzCj4+Pj4+PiBk
ZXN0cm95ZWQsIHRoZSBjb21tb24gRFJNIGNvZGUgd2lsbCBhdHRlbXB0IHRvIGRpc2FibGUgdGhl
IG92ZXJsYXkKPj4+Pj4+IHBsYW5lLCBidXQgZG1fY2hlY2tfY3J0Y19jdXJzb3Igd2lsbCByZWpl
Y3QgdGhhdCBub3cuIEkgY2FuJ3QKPj4+Pj4+IHJlbWVtYmVyCj4+Pj4+PiBleGFjdGx5IHdoYXQg
dGhlIHJlc3VsdCBpcywgYnV0IEFGQUlSIGl0J3Mgbm90IHByZXR0eS4KPj4+Pj4KPj4+Pj4gQ1JU
QyBnZXRzIGRpc2FibGVkIGluc3RlYWQuIFRoYXQncyB3aHkgd2Ugd2VudCB3aXRoIHRoZSAiYWx3
YXlzCj4+Pj4+IHJlcXVpcmUgcHJpbWFyeSBwbGFuZSIgaGFjay4gSSB0aGluayB0aGUgb25seSBz
b2x1dGlvbiBoZXJlIHdvdWxkIGJlCj4+Pj4+IHRvIGVuYWJsZSB0aGUgcHJpbWFyeSBwbGFuZSAo
YnV0IG5vdCBpbiB1c2Vyc3BhY2UtdmlzaWJsZSBzdGF0ZSwgc28KPj4+Pj4gdGhpcyBuZWVkcyB0
byBiZSBkb25lIGluIHRoZSBkYyBkZXJpdmVkIHN0YXRlIG9iamVjdHMgb25seSkgdGhhdCBzY2Fu
cwo+Pj4+PiBvdXQgYmxhY2sgYW55IHRpbWUgd2UncmUgaW4gc3VjaCBhIHNpdHVhdGlvbiB3aXRo
IGN1cnNvciB3aXRoIG5vCj4+Pj4+IHBsYW5lcy4KPj4+Pgo+Pj4+IFRoaXMgaXMgYWJvdXQgYSBz
Y2VuYXJpbyBkZXNjcmliZWQgYnkgTmljaG9sYXMgZWFybGllcjoKPj4+Pgo+Pj4+IEN1cnNvciBQ
bGFuZSAtIEFSR0I4ODg4Cj4+Pj4KPj4+PiBPdmVybGF5IFBsYW5lIC0gQVJHQjg4ODggRGVza3Rv
cC9VSSB3aXRoIGN1dG91dCBmb3IgdmlkZW8KPj4+Pgo+Pj4+IFByaW1hcnkgUGxhbmUgLSBOVjEy
IHZpZGVvCj4+Pj4KPj4+PiBBbmQgZGVzdHJveWluZyB0aGUgRkIgYm91bmQgdG8gdGhlIG92ZXJs
YXkgcGxhbmUuIFRoZSBmYWxsYmFjayB0bwo+Pj4+IGRpc2FibGUKPj4+PiB0aGUgQ1JUQyBpbiBh
dG9taWNfcmVtb3ZlX2ZiIG9ubHkga2lja3MgaW4gZm9yIHRoZSBwcmltYXJ5IHBsYW5lLCBzbyBp
dAo+Pj4+IHdvdWxkbid0IGluIHRoaXMgY2FzZSBhbmQgd291bGQgZmFpbC4gV2hpY2ggd291bGQg
aW4gdHVybiB0cmlnZ2VyIHRoZQo+Pj4+IFdBUk4gaW4gZHJtX2ZyYW1lYnVmZmVyX3JlbW92ZSAo
YW5kIGxlYXZlIHRoZSBvdmVybGF5IHBsYW5lIHNjYW5uaW5nCj4+Pj4gb3V0Cj4+Pj4gZnJvbSBm
cmVlZCBtZW1vcnk/KS4KPj4+Pgo+Pj4+Cj4+Pj4gVGhlIGNsZWFuZXN0IHNvbHV0aW9uIG1pZ2h0
IGJlIG5vdCB0byBhbGxvdyBhbnkgZm9ybWF0cyBpbmNvbXBhdGlibGUKPj4+PiB3aXRoCj4+Pj4g
dGhlIEhXIGN1cnNvciBmb3IgdGhlIHByaW1hcnkgcGxhbmUuCj4+Pgo+Pj4gTGVnYWN5IFggdXNl
cnNwYWNlIGRvZXNuJ3QgdXNlIG92ZXJsYXlzIGJ1dCBDaHJvbWUgT1MgZG9lcy4KPj4+Cj4+PiBU
aGlzIHdvdWxkIHJlZ3Jlc3MgQ2hyb21lT1MgTVBPIHN1cHBvcnQgYmVjYXVzZSBpdCByZWxpZXMg
b24gdGhlIE5WMTIKPj4+IHZpZGVvIHBsYW5lIGJlaW5nIG9uIHRoZSBib3R0b20uCj4+Cj4+IENv
dWxkIGl0IHVzZSB0aGUgTlYxMiBvdmVybGF5IHBsYW5lIGJlbG93IHRoZSBBUkdCIHByaW1hcnkg
cGxhbmU/Cj4gCj4gUGxhbmUgb3JkZXJpbmcgd2FzIHByZXZpb3VzbHkgdW5kZWZpbmVkIGluIERS
TSBzbyB3ZSBoYXZlIHVzZXJzcGFjZSB0aGF0Cj4gYXNzdW1lcyBvdmVybGF5cyBhcmUgb24gdG9w
LgoKVGhleSBjYW4gc3RpbGwgYmUgYnkgZGVmYXVsdD8KCj4gVG9kYXkgd2UgaGF2ZSB0aGUgei1v
cmRlciBwcm9wZXJ0eSBpbiBEUk0gdGhhdCBkZWZpbmVzIHdoZXJlIGl0IGlzIGluCj4gdGhlIHN0
YWNrLCBzbyB0ZWNobmljYWxseSBpdCBjb3VsZCBidXQgd2UnZCBhbHNvIGJlIHJlZ3Jlc3Npbmcg
ZXhpc3RpbmcKPiBiZWhhdmlvciBvbiBDaHJvbWUgT1MgdG9kYXkuCgpUaGF0J3MgdW5mb3J0dW5h
dGUsIGJ1dCBtaWdodCBiZSB0aGUgbGVhc3QgYmFkIGNob2ljZSBvdmVyYWxsLgoKQlRXLCBkb2Vz
bid0IENocm9tZSBPUyB0cnkgdG8gZGlzYWJsZSB0aGUgQVJHQiBvdmVybGF5IHBsYW5lIHdoaWxl
IHRoZXJlIGFyZSBubyBVSSBlbGVtZW50cyB0byBkaXNwbGF5PyBJZiBpdCBkb2VzLCB0aGlzIHNl
cmllcyBtaWdodCBicmVhayBpdCBhbnl3YXkgKGlmIHRoZSBjdXJzb3IgcGxhbmUgY2FuIGJlIGVu
YWJsZWQgd2hpbGUgdGhlIEFSR0Igb3ZlcmxheSBwbGFuZSBpcyBvZmYpLgoKCj4+PiBXaGVuIENo
cm9tZU9TIGRpc2FibGVzIE1QTyBpdCBkb2Vzbid0IGRvIGl0IHBsYW5lIGJ5IHBsYW5lLCBpdCBk
b2VzIGl0Cj4+PiBpbiBvbmUgZ28gZnJvbSBOVjEyK0FSR0I4ODg4IC0+IEFSR0I4ODg4OC4KPj4K
Pj4gRXZlbiBzbywgd2UgY2Fubm90IGV4cGVjdCBhbGwgdXNlciBzcGFjZSB0byBkbyB0aGUgc2Ft
ZSwgYW5kIHdlIGNhbm5vdAo+PiBhbGxvdyBhbnkgdXNlciBzcGFjZSB0byB0cmlnZ2VyIGEgV0FS
TiBhbmQgc2Nhbm91dCBmcm9tIGZyZWVkIG1lbW9yeS4KPiAKPiBUaGUgV0FSTiBkb2Vzbid0IHRy
aWdnZXIgYmVjYXVzZSB0aGVyZSdzIHN0aWxsIGEgcmVmZXJlbmNlIG9uIHRoZSBGQiAtCgpUaGUg
V0FSTiB0cmlnZ2VycyBpZiBhdG9taWNfcmVtb3ZlX2ZiIHJldHVybnMgYW4gZXJyb3IsIHdoaWNo
IGlzIHRoZSBjYXNlIGlmIGl0IGNhbid0IGRpc2FibGUgYW4gb3ZlcmxheSBwbGFuZS4gSSBhY3R1
YWxseSBoaXQgdGhpcyB3aXRoIElHVCB0ZXN0cyB3aGlsZSB3b3JraW5nIG9uIGI4MzZhMjc0Yjc5
NyAiZHJtL2FtZGdwdS9kYzogUmVxdWlyZSBwcmltYXJ5IHBsYW5lIHRvIGJlIGVuYWJsZWQgd2hl
bmV2ZXIgdGhlIENSVEMgaXMiIChJIGluaXRpYWxseSB0cmllZCBhbGxvd2luZyB0aGUgY3Vyc29y
IHBsYW5lIHRvIGJlIGVuYWJsZWQgdG9nZXRoZXIgd2l0aCBhbiBvdmVybGF5IHBsYW5lIHdoaWxl
IHRoZSBwcmltYXJ5IHBsYW5lIGlzIG9mZikuCgo+IHRoZSByZWZlcmVuY2UgaGVsZCBieSBEUk0g
c2luY2UgaXQncyBzdGlsbCBzY2FubmluZyBvdXQgdGhlIG92ZXJsYXkuCj4gVXNlcnNwYWNlIGNh
bid0IHJlY2xhaW0gdGhpcyBtZW1vcnkgd2l0aCBhbm90aGVyIGJ1ZmZlciBhbGxvY2F0aW9uCj4g
YmVjYXVzZSBpdCdzIHN0aWxsIGluIHVzZS4KCkdvb2QgcG9pbnQsIHNvIGF0IGxlYXN0IHRoZXJl
J3Mgbm8gc2Nhbm91dCBvZiBmcmVlZCBtZW1vcnkuIEV2ZW4gc28sIHRoZSBvdmVybGF5IHBsYW5l
IGNvbnRpbnVlcyBkaXNwbGF5aW5nIGNvbnRlbnRzIHdoaWNoIHVzZXIgc3BhY2UgYXBwYXJlbnRs
eSBkb2Vzbid0IHdhbnQgdG8gYmUgZGlzcGxheWVkIGFueW1vcmUuCgoKPiBJdCdzIGEgbGl0dGxl
IG9kZCB0aGF0IGEgZGlzYWJsZSBjb21taXQgY2FuIGZhaWwsIGJ1dCBJIGRvbid0IHRoaW5rCj4g
dGhlcmUncyBhbnl0aGluZyBpbiBEUk0gY29yZSB0aGF0IHNwZWNpZmllcyB0aGF0IHRoaXMgY2Fu
J3QgaGFwcGVuIGZvcgo+IHBsYW5lcy4KCkknZCBzYXkgaXQncyBtb3JlIHRoYW4ganVzdCBhIGxp
dHRsZSBvZGQuIDopIEJlaW5nIHVuYWJsZSB0byBkaXNhYmxlIGFuIG92ZXJsYXkgcGxhbmUgc2Vl
bXMgdmVyeSBzdXJwcmlzaW5nLCBhbmQgY291bGQgbWFrZSBpdCB0cmlja3kgZm9yIHVzZXIgc3Bh
Y2UgKG5vdCB0byBtZW50aW9uIGNvcmUgRFJNIGNvZGUgbGlrZSBhdG9taWNfcmVtb3ZlX2ZiKSB0
byBmaW5kIGEgc29sdXRpb24uCgpJJ2Qgc3VnZ2VzdCB0aGUgYW1kZ3B1IERNIGNvZGUgc2hvdWxk
IHJhdGhlciB2aXJ0dWFsaXplIHRoZSBLTVMgQVBJIHBsYW5lcyBzb21laG93IHN1Y2ggdGhhdCBh
biBvdmVybGF5IHBsYW5lIGNhbiBhbHdheXMgYmUgZGlzYWJsZWQuIFdoaWxlIHRoaXMgbWlnaHQg
aW5jdXIgc29tZSBzaG9ydC10ZXJtIHBhaW4sIGl0IHdpbGwgbGlrZWx5IHNhdmUgbW9yZSBwYWlu
IG92ZXJhbGwgaW4gdGhlIGxvbmcgdGVybS4KCgotLSAKRWFydGhsaW5nIE1pY2hlbCBEw6RuemVy
ICAgICAgICAgICAgICAgfCAgICAgICAgICAgICAgIGh0dHBzOi8vcmVkaGF0LmNvbQpMaWJyZSBz
b2Z0d2FyZSBlbnRodXNpYXN0ICAgICAgICAgICAgIHwgICAgICAgICAgICAgTWVzYSBhbmQgWCBk
ZXZlbG9wZXIKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
YW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6
Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
