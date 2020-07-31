Return-Path: <SRS0=+arJ=BK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AB33C433E0
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jul 2020 02:01:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 301782083E
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jul 2020 02:01:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 301782083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=woland.xyz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D21216E986;
	Fri, 31 Jul 2020 02:01:20 +0000 (UTC)
X-Greylist: delayed 91213 seconds by postgrey-1.36 at gabe;
 Fri, 31 Jul 2020 00:31:27 UTC
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050::465:202])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F9B36E980
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Jul 2020 00:31:27 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:105:465:1:1:0])
 (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4BHp9n0WHmzQlGw;
 Fri, 31 Jul 2020 02:31:25 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
 by spamfilter06.heinlein-hosting.de (spamfilter06.heinlein-hosting.de
 [80.241.56.125]) (amavisd-new, port 10030)
 with ESMTP id DvcR4IbsJizd; Fri, 31 Jul 2020 02:31:20 +0200 (CEST)
Date: Fri, 31 Jul 2020 02:31:17 +0200
From: =?utf-8?B?UGF3ZcWC?= Gronowski <me@woland.xyz>
To: Matt Coffin <mcoffin13@gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Fix regression in adjusting power
 table/profile
Message-ID: <20200731003117.GA20523@tower>
References: <20200729231106.GA6598@tower>
 <CADnq5_NQ9Oo85cV49+3pcQZTrBBc5HvoV_MQ_-wAmPhuzhq6uA@mail.gmail.com>
 <91bb8e22-9a8d-6b17-f40c-ab7a09a60fa8@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <91bb8e22-9a8d-6b17-f40c-ab7a09a60fa8@gmail.com>
X-MBO-SPAM-Probability: 0
X-Rspamd-Score: -3.28 / 15.00 / 15.00
X-Rspamd-Queue-Id: 8E95617F1
X-Rspamd-UID: ab77ca
X-Mailman-Approved-At: Fri, 31 Jul 2020 02:01:19 +0000
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
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

SGVsbG8gTWF0dCwKClRoYW5rIHlvdSBmb3IgeW91ciB0ZXN0aW5nLiBJdCBzZWVtcyB0aGF0IG15
IGdwdSAoUlggNTcwKSBkb2VzIG5vdCBzdXBwb3J0IHRoZQp2YyBzZXR0aW5nIHNvIEkgY2FuIG5v
dCBleGFjdGx5IHJlcHJvZHVjZSB0aGUgaXNzdWUuIEhvd2V2ZXIgSSBkaWQgdHJhY2UgdGhlCmNv
ZGUgcGF0aCB0aGUgdGVzdCBjYXNlIHRha2VzIGFuZCBpdCBzZWVtcyB0byBjb3JyZWN0bHkgcGFz
cyB0aHJvdWdoIHRoZSB3aGlsZQpsb29wIHRoYXQgcGFyc2VzIHRoZSBpbnB1dCBhbmQgZmFpbHMg
b25seSBpbiBhbWRncHVfZHBtX29kbl9lZGl0X2RwbV90YWJsZS4KVGhlICdwYXJhbWV0ZXInIGFy
cmF5IGlzIHBvcHVsYXRlZCB0aGUgc2FtZSB3YXkgYXMgdGhlIG9yaWdpbmFsIGNvZGUgZGlkLiBT
aW5jZQp0aGUgYW1kZ3B1X2RwbV9vZG5fZWRpdF9kcG1fdGFibGUgaXMgcmVhY2hlZCwgSSB0aGlu
ayB0aGF0IHlvdXIgcHJvYmxlbSBpcwp1bmZvcnR1bmF0ZWx5IGNhdXNlZCBieSBzb21ldGhpbmcg
ZWxzZS4KCgpQYXdlxYIgR3Jvbm93c2tpCgpPbiBUaHUsIEp1bCAzMCwgMjAyMCBhdCAwODo0OTo0
MUFNIC0wNjAwLCBNYXR0IENvZmZpbiB3cm90ZToKPiBIZWxsbyBhbGwsIEkganVzdCBkaWQgc29t
ZSB0ZXN0aW5nIHdpdGggdGhpcyBhcHBsaWVkLCBhbmQgd2hpbGUgaXQgbm8KPiBsb25nZXIgcmV0
dXJucyAtRUlOVkFMLCBydW5uaW5nIGBzdWRvIHNoIC1jICdlY2hvICJ2YyAyIDIxNTAgMTE5NSIg
Pgo+IC9zeXMvY2xhc3MvZHJtL2NhcmQxL2RldmljZS9wcF9vZF9jbGtfdm9sdGFnZSdgIHJlc3Vs
dHMgaW4gYHNoYCBzcGlraW5nCj4gdG8sIGFuZCBzdGF5aW5nIGF0IDEwMCUgQ1BVIHVzYWdlLCB3
aXRoIG5vIGluZGljYXRpbmcgaW5mb3JtYXRpb24gaW4KPiBgZG1lc2dgIGZyb20gdGhlIGtlcm5l
bC4KPiAKPiBJdCBhcHBlYXJlZCB0byB3b3JrIGF0IGxlYXN0IE9OQ0UsIGJ1dCBwb3RlbnRpYWxs
eSBub3QgYWZ0ZXIuCj4gCj4gVGhpcyBpcyBub3QgdW5pcXVlIHRvIE5hdmksIGFuZCBjYXVzZWQg
dGhlIHByb2JsZW0gb24gYSBQT0xBUklTMTAgY2FyZAo+IGFzIHdlbGwuCj4gCj4gU29ycnkgZm9y
IHRoZSBiYWQgbmV3cywgYW5kIHRoYW5rcyBmb3IgYW55IGluc2lnaHQgeW91IG1heSBoYXZlLAo+
IE1hdHQgQ29mZmluCj4gCj4gT24gNy8yOS8yMCA4OjUzIFBNLCBBbGV4IERldWNoZXIgd3JvdGU6
Cj4gPiBPbiBXZWQsIEp1bCAyOSwgMjAyMCBhdCAxMDoyMCBQTSBQYXdlxYIgR3Jvbm93c2tpIDxt
ZUB3b2xhbmQueHl6PiB3cm90ZToKPiA+Pgo+ID4+IFJlZ3Jlc3Npb24gd2FzIGludHJvZHVjZWQg
aW4gY29tbWl0IDM4ZTBjODlhMTlmZAo+ID4+ICgiZHJtL2FtZGdwdTogRml4IE5VTEwgZGVyZWZl
cmVuY2UgaW4gZHBtIHN5c2ZzIGhhbmRsZXJzIikgd2hpY2gKPiA+PiBtYWRlIHRoZSBzZXRfcHBf
b2RfY2xrX3ZvbHRhZ2UgYW5kIHNldF9wcF9wb3dlcl9wcm9maWxlX21vZGUgcmV0dXJuCj4gPj4g
LUVJTlZBTCBmb3IgcHJldmlvdXNseSB2YWxpZCBpbnB1dC4gVGhpcyB3YXMgY2F1c2VkIGJ5IGFu
IGVtcHR5Cj4gPj4gc3RyaW5nIChzdGFydGluZyBhdCB0aGUgXDAgY2hhcmFjdGVyKSBiZWluZyBw
YXNzZWQgdG8gdGhlIGtzdHJ0b2wuCj4gPj4KPiA+PiBTaWduZWQtb2ZmLWJ5OiBQYXdlxYIgR3Jv
bm93c2tpIDxtZUB3b2xhbmQueHl6Pgo+ID4gCj4gPiBBcHBsaWVkLiAgVGhhbmtzIQo+ID4gCj4g
PiBBbGV4Cj4gPiAKPiA+PiAtLS0KPiA+PiAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X3BtLmMgfCA5ICsrKysrKystLQo+ID4+ICAxIGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRpb25z
KCspLCAyIGRlbGV0aW9ucygtKQo+ID4+Cj4gPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV9wbS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X3BtLmMKPiA+PiBpbmRleCBlYmI4YTI4ZmYwMDIuLmNiZjYyM2ZmMDNiZCAxMDA2NDQKPiA+
PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcG0uYwo+ID4+ICsrKyBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9wbS5jCj4gPj4gQEAgLTc3OCwxMiAr
Nzc4LDE0IEBAIHN0YXRpYyBzc2l6ZV90IGFtZGdwdV9zZXRfcHBfb2RfY2xrX3ZvbHRhZ2Uoc3Ry
dWN0IGRldmljZSAqZGV2LAo+ID4+ICAgICAgICAgICAgICAgICB0bXBfc3RyKys7Cj4gPj4gICAg
ICAgICB3aGlsZSAoaXNzcGFjZSgqKyt0bXBfc3RyKSk7Cj4gPj4KPiA+PiAtICAgICAgIHdoaWxl
ICgoc3ViX3N0ciA9IHN0cnNlcCgmdG1wX3N0ciwgZGVsaW1pdGVyKSkgIT0gTlVMTCkgewo+ID4+
ICsgICAgICAgd2hpbGUgKChzdWJfc3RyID0gc3Ryc2VwKCZ0bXBfc3RyLCBkZWxpbWl0ZXIpKSAm
JiAqc3ViX3N0cikgewo+ID4+ICAgICAgICAgICAgICAgICByZXQgPSBrc3RydG9sKHN1Yl9zdHIs
IDAsICZwYXJhbWV0ZXJbcGFyYW1ldGVyX3NpemVdKTsKPiA+PiAgICAgICAgICAgICAgICAgaWYg
KHJldCkKPiA+PiAgICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4gLUVJTlZBTDsKPiA+PiAg
ICAgICAgICAgICAgICAgcGFyYW1ldGVyX3NpemUrKzsKPiA+Pgo+ID4+ICsgICAgICAgICAgICAg
ICBpZiAoIXRtcF9zdHIpCj4gPj4gKyAgICAgICAgICAgICAgICAgICAgICAgYnJlYWs7Cj4gPj4g
ICAgICAgICAgICAgICAgIHdoaWxlIChpc3NwYWNlKCp0bXBfc3RyKSkKPiA+PiAgICAgICAgICAg
ICAgICAgICAgICAgICB0bXBfc3RyKys7Cj4gPj4gICAgICAgICB9Cj4gPj4gQEAgLTE2MzUsMTEg
KzE2MzcsMTQgQEAgc3RhdGljIHNzaXplX3QgYW1kZ3B1X3NldF9wcF9wb3dlcl9wcm9maWxlX21v
ZGUoc3RydWN0IGRldmljZSAqZGV2LAo+ID4+ICAgICAgICAgICAgICAgICAgICAgICAgIGkrKzsK
PiA+PiAgICAgICAgICAgICAgICAgbWVtY3B5KGJ1Zl9jcHksIGJ1ZiwgY291bnQtaSk7Cj4gPj4g
ICAgICAgICAgICAgICAgIHRtcF9zdHIgPSBidWZfY3B5Owo+ID4+IC0gICAgICAgICAgICAgICB3
aGlsZSAoKHN1Yl9zdHIgPSBzdHJzZXAoJnRtcF9zdHIsIGRlbGltaXRlcikpICE9IE5VTEwpIHsK
PiA+PiArICAgICAgICAgICAgICAgd2hpbGUgKChzdWJfc3RyID0gc3Ryc2VwKCZ0bXBfc3RyLCBk
ZWxpbWl0ZXIpKSAmJiAqc3ViX3N0cikgewo+ID4+ICAgICAgICAgICAgICAgICAgICAgICAgIHJl
dCA9IGtzdHJ0b2woc3ViX3N0ciwgMCwgJnBhcmFtZXRlcltwYXJhbWV0ZXJfc2l6ZV0pOwo+ID4+
ICAgICAgICAgICAgICAgICAgICAgICAgIGlmIChyZXQpCj4gPj4gICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICByZXR1cm4gLUVJTlZBTDsKPiA+PiAgICAgICAgICAgICAgICAgICAgICAg
ICBwYXJhbWV0ZXJfc2l6ZSsrOwo+ID4+ICsKPiA+PiArICAgICAgICAgICAgICAgICAgICAgICBp
ZiAoIXRtcF9zdHIpCj4gPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBicmVhazsK
PiA+PiAgICAgICAgICAgICAgICAgICAgICAgICB3aGlsZSAoaXNzcGFjZSgqdG1wX3N0cikpCj4g
Pj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB0bXBfc3RyKys7Cj4gPj4gICAgICAg
ICAgICAgICAgIH0KPiA+PiAtLQo+ID4+IDIuMjUuMQo+ID4+Cj4gPj4gX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KPiA+PiBhbWQtZ2Z4IG1haWxpbmcgbGlz
dAo+ID4+IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4gPj4gaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cj4gPiBfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+ID4gYW1kLWdmeCBtYWlsaW5nIGxp
c3QKPiA+IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4gPiBodHRwczovL2xpc3RzLmZy
ZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngKPiA+IAo+IAoKCgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcg
bGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNr
dG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
