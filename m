Return-Path: <SRS0=7mEa=IH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48672C433DB
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Mar 2021 08:59:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6CBE64E75
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Mar 2021 08:59:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6CBE64E75
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daenzer.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7863B6E1E0;
	Tue,  9 Mar 2021 08:59:40 +0000 (UTC)
Received: from netline-mail3.netline.ch (mail.netline.ch [148.251.143.178])
 by gabe.freedesktop.org (Postfix) with ESMTP id BD18D6E1E0
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Mar 2021 08:59:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by netline-mail3.netline.ch (Postfix) with ESMTP id A2BA92A6045;
 Tue,  9 Mar 2021 09:59:36 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at netline-mail3.netline.ch
Received: from netline-mail3.netline.ch ([127.0.0.1])
 by localhost (netline-mail3.netline.ch [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id SXMTTW-yPi5e; Tue,  9 Mar 2021 09:59:36 +0100 (CET)
Received: from thor (24.99.2.85.dynamic.wline.res.cust.swisscom.ch
 [85.2.99.24])
 by netline-mail3.netline.ch (Postfix) with ESMTPSA id D24E12A6016;
 Tue,  9 Mar 2021 09:59:35 +0100 (CET)
Received: from localhost ([::1]) by thor with esmtp (Exim 4.94)
 (envelope-from <michel@daenzer.net>)
 id 1lJYDH-000eG6-4t; Tue, 09 Mar 2021 09:59:35 +0100
To: "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>,
 Daniel Vetter <daniel@ffwll.ch>
References: <I5B1EIA88M4W0bSuy9DLTgt70QGefRznp9IdJ14Cco@cp7-web-042.plabs.ch>
 <326ccbf2-8752-2fa2-b757-6811b90ecb8b@daenzer.net>
 <CAKMK7uE1+Y_agt=YCMf7OS6X-QjhAXsPO+3asWsahda11ev-eQ@mail.gmail.com>
 <e7661e4b-a99c-5be7-9912-421ac3e61ff0@daenzer.net>
 <94a2e9cd-8a14-984d-71a7-3671d7c352ab@amd.com>
 <5d62d002-faa4-ea6b-c55e-2b297e8e1b5c@daenzer.net>
 <19062958-ff28-0f1e-d891-9c030a88ecb0@amd.com>
 <0fef827c-7aff-28bb-efda-70460cb658eb@daenzer.net>
 <CAKMK7uGq7YZLXbbCjasQOiUaCXGO5ZSoUcKa5JrtyGTW=Mu7qw@mail.gmail.com>
 <c3855456-e209-3e08-f351-c4231ddf48c7@amd.com>
From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>
Subject: Re: [PATCH 3/6] amd/display: fail on cursor plane without an
 underlying plane
Message-ID: <b8eb4a18-42b4-06bc-4244-b0ee7d4eadab@daenzer.net>
Date: Tue, 9 Mar 2021 09:59:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <c3855456-e209-3e08-f351-c4231ddf48c7@amd.com>
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

T24gMjAyMS0wMy0wOCA5OjM4IHAubS4sIEthemxhdXNrYXMsIE5pY2hvbGFzIHdyb3RlOgo+IE9u
IDIwMjEtMDMtMDggMzoxOCBwLm0uLCBEYW5pZWwgVmV0dGVyIHdyb3RlOgo+PiBPbiBGcmksIE1h
ciA1LCAyMDIxIGF0IDEwOjI0IEFNIE1pY2hlbCBEw6RuemVyIDxtaWNoZWxAZGFlbnplci5uZXQ+
IHdyb3RlOgo+Pj4KPj4+IE9uIDIwMjEtMDMtMDQgNzoyNiBwLm0uLCBLYXpsYXVza2FzLCBOaWNo
b2xhcyB3cm90ZToKPj4+Pgo+Pj4+IEl0J3MgYSBsaXR0bGUgb2RkIHRoYXQgYSBkaXNhYmxlIGNv
bW1pdCBjYW4gZmFpbCwgYnV0IEkgZG9uJ3QgdGhpbmsKPj4+PiB0aGVyZSdzIGFueXRoaW5nIGlu
IERSTSBjb3JlIHRoYXQgc3BlY2lmaWVzIHRoYXQgdGhpcyBjYW4ndCBoYXBwZW4gZm9yCj4+Pj4g
cGxhbmVzLgo+Pj4KPj4+IEknZCBzYXkgaXQncyBtb3JlIHRoYW4ganVzdCBhIGxpdHRsZSBvZGQu
IDopIEJlaW5nIHVuYWJsZSB0byBkaXNhYmxlCj4+PiBhbiBvdmVybGF5IHBsYW5lIHNlZW1zIHZl
cnkgc3VycHJpc2luZywgYW5kIGNvdWxkIG1ha2UgaXQgdHJpY2t5IGZvcgo+Pj4gdXNlciBzcGFj
ZSAobm90IHRvIG1lbnRpb24gY29yZSBEUk0gY29kZSBsaWtlIGF0b21pY19yZW1vdmVfZmIpIHRv
Cj4+PiBmaW5kIGEgc29sdXRpb24uCj4+Pgo+Pj4gSSdkIHN1Z2dlc3QgdGhlIGFtZGdwdSBETSBj
b2RlIHNob3VsZCByYXRoZXIgdmlydHVhbGl6ZSB0aGUgS01TIEFQSQo+Pj4gcGxhbmVzIHNvbWVo
b3cgc3VjaCB0aGF0IGFuIG92ZXJsYXkgcGxhbmUgY2FuIGFsd2F5cyBiZSBkaXNhYmxlZC4KPj4+
IFdoaWxlIHRoaXMgbWlnaHQgaW5jdXIgc29tZSBzaG9ydC10ZXJtIHBhaW4sIGl0IHdpbGwgbGlr
ZWx5IHNhdmUgbW9yZQo+Pj4gcGFpbiBvdmVyYWxsIGluIHRoZSBsb25nIHRlcm0uCj4+Cj4+IFll
YWggSSB0aGluayB0aGlzIGFtZCBkYyBjdXJzb3IgcHJvYmxlbSBpcyB0aGUgZmlyc3QgY2FzZSB3
aGVyZQo+PiByZW1vdmluZyBhIHBsYW5lIGNhbiBtYWtlIHRoaW5ncyB3b3JzZS4KPj4KPj4gU2lu
Y2UgdGhlIGh3IGlzIHdoYXQgaXQgaXMsIGNhbid0IHdlIHB1dCBhIHRyYW5zcGFyZW50IHBsYW5l
IHdpdGgKPj4gY3Vyc29yIGNvbXBhdGlibGUgZm9ybWF0IGluIGZvciB0aGUgY2FzZSB3aGVyZSBz
dHVmZiB3b3VsZCBmYWlsPyBTbwo+PiBub3QgZnVsbHkgdmlydHVhbGl6ZSB0aGUgcGxhbmVzIChz
aW5jZSBJIGRvbid0IHNlZSBob3cgdGhhdCBoZWxwcyksCj4+IGJ1dCBqdXN0IGtlZXBpbmcgdGhl
IHBsYW5lIGdvaW5nIHVuZGVybmVhdGggaXQgYWxsLgoKV2hhdCB5b3UgZGVzY3JpYmUgaXMgb25l
IHdheSB0byAidmlydHVhbGl6ZSB0aGUgS01TIEFQSSBwbGFuZXMiLCBzaW5jZSB0aGVpciBzdGF0
ZSB3b3VsZCBubyBsb25nZXIgZGlyZWN0bHkgY29ycmVzcG9uZCB0byBIVyBzdGF0ZS4KCgo+PiBJ
IHRoaW5rIHRoYXQncyBhbHNvIHdoYXQgVmlsbGUgZGlkIGZvciBpOTE1L2dlbjIsIHdoaWNoIGhh
cyB0aGUKPj4gcmVxdWlyZW1lbnQgdGhhdCB0aGUgcHJpbWFyeSBwbGFuZSBtdXN0IGFsd2F5cyBi
ZSBvbiBpaXJjLgo+Pgo+PiBPZmMgc2luY2UgYW1kIGRpc3BsYXkgZG9lc24ndCBnbyB0aHJvdWdo
IHBhZ2V0YWJsZXMgdGhpcyBuZWVkcyBzb21lCj4+IHZyYW0sIGJ1dCBtYXliZSB5b3UgY2FuIHVz
ZSB0aGUgc2NhbGVycyB0byBtYWtlIHRoZSByZXF1aXJlbWVudCBhIGJpdAo+PiBsZXNzIGRyYXN0
aWMuCj4gCj4gVGhlIGN1cnNvciBmcmFtZWJ1ZmZlciB3b3VsZCBoYXZlIHRvIGJlIHVzZWQgYXMg
dGhlIHBpcGUncyBwcmltYXJ5Cj4gZnJhbWVidWZmZXIgaW4gdGhpcyBjYXNlIGJlY2F1c2UgdGhl
IGhhcmR3YXJlIGhhcyBub3RoaW5nIHVuZGVybmVhdGggdG8KPiBzY2FuIG91dCBhbG9uZyB3aXRo
IGl0Lgo+IAo+IEknbSBub3Qgc3VyZSB0aGUgYXRvbWljIGFzeW5jIHVwZGF0ZSBpbnRlcmZhY2Ug
d291bGQgd29yayB3ZWxsIGluIHRoZQo+IHZpcnR1YWxpemF0aW9uIGNhc2UgaWYgd2UgaGFkIHRv
IGZhbGxiYWNrIGZyb20gdXNpbmcgdGhlIHJlZ3VsYXIgY3Vyc29yCj4gcHJvZ3JhbW1pbmcgdG8g
dXNpbmcgZnVsbCBwaXBlIHByb2dyYW1taW5nLgo+IAo+IFRoaXMgd291bGQgYnVybiBleHRyYSBw
b3dlciBmcm9tIHRoZSBzZWNvbmRhcnkgcGlwZSBidXQgaXQgd291bGQgYWxzbwo+IGFkZCBjdXJz
b3Igc3R1dHRlcmluZyBpbnRvIHRoZSBtaXggYmVjYXVzZSBhc3luYyB1cGRhdGVzIHdvdWxkIGJl
IGJsb2NrZWQuCgpXaHkgY2FuJ3QgdGhlIERNIGNvZGUga2VlcCB0aGUgb3ZlcmxheSBwbGFuZSBl
bmFibGVkIGluIERDLCBhbmQgbWFrZSBpdCBzY2FuIG91dCBmcm9tIGEgbWluaW1hbCBidWZmZXIg
d2hpY2ggYXBwZWFycyBmdWxseSB0cmFuc3BhcmVudCwgYXMgc3VnZ2VzdGVkIGJ5IERhbmllbCAo
YW5kIHlvdXJzIHRydWx5IGJlZm9yZSk/CgoKPiBNeSBwcmVmZXJlbmNlIHdvdWxkIGJlIHRvIGNv
bnRpbnVlIHRvIHJlamVjdCB0aGUgY29tbWl0cyBhbmQgbm90Cj4gaW1wbGVtZW50IHRoZSBmYWxs
YmFjayBwYXRoIGJlY2F1c2Ugb2YgaG93IHN1Ym9wdGltYWwgdGhlIHdob2xlIHRoaW5nCj4gaXMs
IGJ1dCB0aGlzIHdob2xlIHRoaW5nIGlzIGp1c3Qga2luZCBvZiBhIG1lc3MuCgpJdCBpcyBpbmRl
ZWQuIExldCdzIGtlZXAgdGhlIG1lc3MgY29udGFpbmVkIGFzIG11Y2ggYXMgcG9zc2libGUsIGlu
c3RlYWQgb2YgaW5mbGljdGluZyBpdCBvbiB0aGUgd2hvbGUgYXRvbWljIEtNUyBlY29zeXN0ZW0u
CgoKLS0gCkVhcnRobGluZyBNaWNoZWwgRMOkbnplciAgICAgICAgICAgICAgIHwgICAgICAgICAg
ICAgICBodHRwczovL3JlZGhhdC5jb20KTGlicmUgc29mdHdhcmUgZW50aHVzaWFzdCAgICAgICAg
ICAgICB8ICAgICAgICAgICAgIE1lc2EgYW5kIFggZGV2ZWxvcGVyCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1n
ZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21h
aWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
