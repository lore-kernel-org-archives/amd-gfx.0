Return-Path: <SRS0=anlk=IC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05B5FC433DB
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Mar 2021 15:35:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB1AA64EEE
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Mar 2021 15:35:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB1AA64EEE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daenzer.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 79B156E4BB;
	Thu,  4 Mar 2021 15:35:41 +0000 (UTC)
Received: from netline-mail3.netline.ch (mail.netline.ch [148.251.143.178])
 by gabe.freedesktop.org (Postfix) with ESMTP id B41BA6E4BB
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Mar 2021 15:35:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by netline-mail3.netline.ch (Postfix) with ESMTP id 8B6CE2A6045;
 Thu,  4 Mar 2021 16:35:39 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at netline-mail3.netline.ch
Received: from netline-mail3.netline.ch ([127.0.0.1])
 by localhost (netline-mail3.netline.ch [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id lvXjVJ2HEncb; Thu,  4 Mar 2021 16:35:39 +0100 (CET)
Received: from thor (24.99.2.85.dynamic.wline.res.cust.swisscom.ch
 [85.2.99.24])
 by netline-mail3.netline.ch (Postfix) with ESMTPSA id E73B22A6042;
 Thu,  4 Mar 2021 16:35:38 +0100 (CET)
Received: from [::1] by thor with esmtp (Exim 4.94)
 (envelope-from <michel@daenzer.net>)
 id 1lHq0n-0004GG-UZ; Thu, 04 Mar 2021 16:35:37 +0100
To: "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>,
 Daniel Vetter <daniel@ffwll.ch>
References: <I5B1EIA88M4W0bSuy9DLTgt70QGefRznp9IdJ14Cco@cp7-web-042.plabs.ch>
 <326ccbf2-8752-2fa2-b757-6811b90ecb8b@daenzer.net>
 <CAKMK7uE1+Y_agt=YCMf7OS6X-QjhAXsPO+3asWsahda11ev-eQ@mail.gmail.com>
 <e7661e4b-a99c-5be7-9912-421ac3e61ff0@daenzer.net>
 <94a2e9cd-8a14-984d-71a7-3671d7c352ab@amd.com>
From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>
Subject: Re: [PATCH 3/6] amd/display: fail on cursor plane without an
 underlying plane
Message-ID: <5d62d002-faa4-ea6b-c55e-2b297e8e1b5c@daenzer.net>
Date: Thu, 4 Mar 2021 16:35:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <94a2e9cd-8a14-984d-71a7-3671d7c352ab@amd.com>
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

T24gMjAyMS0wMy0wNCA0OjA5IHAubS4sIEthemxhdXNrYXMsIE5pY2hvbGFzIHdyb3RlOgo+IE9u
IDIwMjEtMDMtMDQgNDowNSBhLm0uLCBNaWNoZWwgRMOkbnplciB3cm90ZToKPj4gT24gMjAyMS0w
My0wMyA4OjE3IHAubS4sIERhbmllbCBWZXR0ZXIgd3JvdGU6Cj4+PiBPbiBXZWQsIE1hciAzLCAy
MDIxIGF0IDU6NTMgUE0gTWljaGVsIETDpG56ZXIgPG1pY2hlbEBkYWVuemVyLm5ldD4gd3JvdGU6
Cj4+Pj4KPj4+PiBNb3Jlb3ZlciwgaW4gdGhlIHNhbWUgc2NlbmFyaW8gcGx1cyBhbiBvdmVybGF5
IHBsYW5lIGVuYWJsZWQgd2l0aCBhCj4+Pj4gSFcgY3Vyc29yIGNvbXBhdGlibGUgZm9ybWF0LCBp
ZiB0aGUgRkIgYm91bmQgdG8gdGhlIG92ZXJsYXkgcGxhbmUgaXMKPj4+PiBkZXN0cm95ZWQsIHRo
ZSBjb21tb24gRFJNIGNvZGUgd2lsbCBhdHRlbXB0IHRvIGRpc2FibGUgdGhlIG92ZXJsYXkKPj4+
PiBwbGFuZSwgYnV0IGRtX2NoZWNrX2NydGNfY3Vyc29yIHdpbGwgcmVqZWN0IHRoYXQgbm93LiBJ
IGNhbid0IHJlbWVtYmVyCj4+Pj4gZXhhY3RseSB3aGF0IHRoZSByZXN1bHQgaXMsIGJ1dCBBRkFJ
UiBpdCdzIG5vdCBwcmV0dHkuCj4+Pgo+Pj4gQ1JUQyBnZXRzIGRpc2FibGVkIGluc3RlYWQuIFRo
YXQncyB3aHkgd2Ugd2VudCB3aXRoIHRoZSAiYWx3YXlzCj4+PiByZXF1aXJlIHByaW1hcnkgcGxh
bmUiIGhhY2suIEkgdGhpbmsgdGhlIG9ubHkgc29sdXRpb24gaGVyZSB3b3VsZCBiZQo+Pj4gdG8g
ZW5hYmxlIHRoZSBwcmltYXJ5IHBsYW5lIChidXQgbm90IGluIHVzZXJzcGFjZS12aXNpYmxlIHN0
YXRlLCBzbwo+Pj4gdGhpcyBuZWVkcyB0byBiZSBkb25lIGluIHRoZSBkYyBkZXJpdmVkIHN0YXRl
IG9iamVjdHMgb25seSkgdGhhdCBzY2Fucwo+Pj4gb3V0IGJsYWNrIGFueSB0aW1lIHdlJ3JlIGlu
IHN1Y2ggYSBzaXR1YXRpb24gd2l0aCBjdXJzb3Igd2l0aCBubwo+Pj4gcGxhbmVzLgo+Pgo+PiBU
aGlzIGlzIGFib3V0IGEgc2NlbmFyaW8gZGVzY3JpYmVkIGJ5IE5pY2hvbGFzIGVhcmxpZXI6Cj4+
Cj4+IEN1cnNvciBQbGFuZSAtIEFSR0I4ODg4Cj4+Cj4+IE92ZXJsYXkgUGxhbmUgLSBBUkdCODg4
OCBEZXNrdG9wL1VJIHdpdGggY3V0b3V0IGZvciB2aWRlbwo+Pgo+PiBQcmltYXJ5IFBsYW5lIC0g
TlYxMiB2aWRlbwo+Pgo+PiBBbmQgZGVzdHJveWluZyB0aGUgRkIgYm91bmQgdG8gdGhlIG92ZXJs
YXkgcGxhbmUuIFRoZSBmYWxsYmFjayB0byBkaXNhYmxlCj4+IHRoZSBDUlRDIGluIGF0b21pY19y
ZW1vdmVfZmIgb25seSBraWNrcyBpbiBmb3IgdGhlIHByaW1hcnkgcGxhbmUsIHNvIGl0Cj4+IHdv
dWxkbid0IGluIHRoaXMgY2FzZSBhbmQgd291bGQgZmFpbC4gV2hpY2ggd291bGQgaW4gdHVybiB0
cmlnZ2VyIHRoZQo+PiBXQVJOIGluIGRybV9mcmFtZWJ1ZmZlcl9yZW1vdmUgKGFuZCBsZWF2ZSB0
aGUgb3ZlcmxheSBwbGFuZSBzY2FubmluZyBvdXQKPj4gZnJvbSBmcmVlZCBtZW1vcnk/KS4KPj4K
Pj4KPj4gVGhlIGNsZWFuZXN0IHNvbHV0aW9uIG1pZ2h0IGJlIG5vdCB0byBhbGxvdyBhbnkgZm9y
bWF0cyBpbmNvbXBhdGlibGUgd2l0aAo+PiB0aGUgSFcgY3Vyc29yIGZvciB0aGUgcHJpbWFyeSBw
bGFuZS4KPiAKPiBMZWdhY3kgWCB1c2Vyc3BhY2UgZG9lc24ndCB1c2Ugb3ZlcmxheXMgYnV0IENo
cm9tZSBPUyBkb2VzLgo+IAo+IFRoaXMgd291bGQgcmVncmVzcyBDaHJvbWVPUyBNUE8gc3VwcG9y
dCBiZWNhdXNlIGl0IHJlbGllcyBvbiB0aGUgTlYxMgo+IHZpZGVvIHBsYW5lIGJlaW5nIG9uIHRo
ZSBib3R0b20uCgpDb3VsZCBpdCB1c2UgdGhlIE5WMTIgb3ZlcmxheSBwbGFuZSBiZWxvdyB0aGUg
QVJHQiBwcmltYXJ5IHBsYW5lPwoKCj4gV2hlbiBDaHJvbWVPUyBkaXNhYmxlcyBNUE8gaXQgZG9l
c24ndCBkbyBpdCBwbGFuZSBieSBwbGFuZSwgaXQgZG9lcyBpdAo+IGluIG9uZSBnbyBmcm9tIE5W
MTIrQVJHQjg4ODggLT4gQVJHQjg4ODg4LgoKRXZlbiBzbywgd2UgY2Fubm90IGV4cGVjdCBhbGwg
dXNlciBzcGFjZSB0byBkbyB0aGUgc2FtZSwgYW5kIHdlIGNhbm5vdAphbGxvdyBhbnkgdXNlciBz
cGFjZSB0byB0cmlnZ2VyIGEgV0FSTiBhbmQgc2Nhbm91dCBmcm9tIGZyZWVkIG1lbW9yeS4KCgot
LSAKRWFydGhsaW5nIE1pY2hlbCBEw6RuemVyICAgICAgICAgICAgICAgfCAgICAgICAgICAgICAg
IGh0dHBzOi8vcmVkaGF0LmNvbQpMaWJyZSBzb2Z0d2FyZSBlbnRodXNpYXN0ICAgICAgICAgICAg
IHwgICAgICAgICAgICAgTWVzYSBhbmQgWCBkZXZlbG9wZXIKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBs
aXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1h
bi9saXN0aW5mby9hbWQtZ2Z4Cg==
