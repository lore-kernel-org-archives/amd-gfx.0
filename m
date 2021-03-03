Return-Path: <SRS0=hRd6=IB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E541FC433E0
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Mar 2021 16:53:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B37AC64ECF
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Mar 2021 16:53:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B37AC64ECF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daenzer.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6883E6E40D;
	Wed,  3 Mar 2021 16:53:53 +0000 (UTC)
Received: from netline-mail3.netline.ch (mail.netline.ch [148.251.143.178])
 by gabe.freedesktop.org (Postfix) with ESMTP id 05FD66E40D
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Mar 2021 16:53:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by netline-mail3.netline.ch (Postfix) with ESMTP id 317A02A6045;
 Wed,  3 Mar 2021 17:53:51 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at netline-mail3.netline.ch
Received: from netline-mail3.netline.ch ([127.0.0.1])
 by localhost (netline-mail3.netline.ch [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id X8tiGdbw2YAD; Wed,  3 Mar 2021 17:53:50 +0100 (CET)
Received: from thor (24.99.2.85.dynamic.wline.res.cust.swisscom.ch
 [85.2.99.24])
 by netline-mail3.netline.ch (Postfix) with ESMTPSA id B46F52A6042;
 Wed,  3 Mar 2021 17:53:50 +0100 (CET)
Received: from localhost ([::1]) by thor with esmtp (Exim 4.94)
 (envelope-from <michel@daenzer.net>)
 id 1lHUkw-00201H-4G; Wed, 03 Mar 2021 17:53:50 +0100
To: Simon Ser <contact@emersion.fr>, Daniel Vetter <daniel@ffwll.ch>
References: <I5B1EIA88M4W0bSuy9DLTgt70QGefRznp9IdJ14Cco@cp7-web-042.plabs.ch>
From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>
Subject: Re: [PATCH 3/6] amd/display: fail on cursor plane without an
 underlying plane
Message-ID: <326ccbf2-8752-2fa2-b757-6811b90ecb8b@daenzer.net>
Date: Wed, 3 Mar 2021 17:53:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <I5B1EIA88M4W0bSuy9DLTgt70QGefRznp9IdJ14Cco@cp7-web-042.plabs.ch>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Harry Wentland <hwentlan@amd.com>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 amd-gfx@lists.freedesktop.org
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gMjAyMS0wMi0xOSA3OjU4IHAubS4sIFNpbW9uIFNlciB3cm90ZToKPiBNYWtlIHN1cmUgdGhl
cmUncyBhbiB1bmRlcmx5aW5nIHBpcGUgdGhhdCBjYW4gYmUgdXNlZCBmb3IgdGhlCj4gY3Vyc29y
Lgo+IAo+IFNpZ25lZC1vZmYtYnk6IFNpbW9uIFNlciA8Y29udGFjdEBlbWVyc2lvbi5mcj4KPiBD
YzogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgo+IENjOiBIYXJyeSBX
ZW50bGFuZCA8aHdlbnRsYW5AYW1kLmNvbT4KPiBDYzogTmljaG9sYXMgS2F6bGF1c2thcyA8bmlj
aG9sYXMua2F6bGF1c2thc0BhbWQuY29tPgo+IC0tLQo+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9k
aXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG0uYyB8IDcgKysrKysrLQo+ICAgMSBmaWxlIGNoYW5n
ZWQsIDYgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQo+IAo+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbS5jIGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG0uYwo+IGluZGV4IGFjYmUxNTM3
ZTdjZi4uYTVkNjAxMDQwNWJmIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlz
cGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtLmMKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rp
c3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbS5jCj4gQEAgLTkyMjYsOSArOTIyNiwxNCBAQCBzdGF0
aWMgaW50IGRtX2NoZWNrX2NydGNfY3Vyc29yKHN0cnVjdCBkcm1fYXRvbWljX3N0YXRlICpzdGF0
ZSwKPiAgIAl9Cj4gICAKPiAgIAluZXdfY3Vyc29yX3N0YXRlID0gZHJtX2F0b21pY19nZXRfbmV3
X3BsYW5lX3N0YXRlKHN0YXRlLCBjcnRjLT5jdXJzb3IpOwo+IC0JaWYgKCFuZXdfY3Vyc29yX3N0
YXRlIHx8ICFuZXdfdW5kZXJseWluZ19zdGF0ZSB8fCAhbmV3X2N1cnNvcl9zdGF0ZS0+ZmIpCj4g
KwlpZiAoIW5ld19jdXJzb3Jfc3RhdGUgfHwgIW5ld19jdXJzb3Jfc3RhdGUtPmZiKQo+ICAgCQly
ZXR1cm4gMDsKPiAgIAo+ICsJaWYgKCFuZXdfdW5kZXJseWluZ19zdGF0ZSB8fCAhbmV3X3VuZGVy
bHlpbmdfc3RhdGUtPmZiKSB7Cj4gKwkJZHJtX2RiZ19hdG9taWMoY3J0Yy0+ZGV2LCAiQ3Vyc29y
IHBsYW5lIGNhbid0IGJlIGVuYWJsZWQgd2l0aG91dCB1bmRlcmx5aW5nIHBsYW5lXG4iKTsKPiAr
CQlyZXR1cm4gLUVJTlZBTDsKPiArCX0KPiArCj4gICAJY3Vyc29yX3NjYWxlX3cgPSBuZXdfY3Vy
c29yX3N0YXRlLT5jcnRjX3cgKiAxMDAwIC8KPiAgIAkJCSAobmV3X2N1cnNvcl9zdGF0ZS0+c3Jj
X3cgPj4gMTYpOwo+ICAgCWN1cnNvcl9zY2FsZV9oID0gbmV3X2N1cnNvcl9zdGF0ZS0+Y3J0Y19o
ICogMTAwMCAvCj4gCgpIb3VzdG9uLCB3ZSBoYXZlIGEgcHJvYmxlbSBJJ20gYWZyYWlkLiBBZGRp
bmcgRGFuaWVsLgoKCklmIHRoZSBwcmltYXJ5IHBsYW5lIGlzIGVuYWJsZWQgd2l0aCBhIGZvcm1h
dCB3aGljaCBpc24ndCBjb21wYXRpYmxlIHdpdGggdGhlIEhXIGN1cnNvciwgYW5kIG5vIG92ZXJs
YXkgcGxhbmUgaXMgZW5hYmxlZCwgdGhlIHNhbWUgaXNzdWVzIGFzIGRlc2NyaWJlZCBpbiBiODM2
YTI3NGI3OTcgImRybS9hbWRncHUvZGM6IFJlcXVpcmUgcHJpbWFyeSBwbGFuZSB0byBiZSBlbmFi
bGVkIHdoZW5ldmVyIHRoZSBDUlRDIGlzIiBjYW4gYWdhaW4gb2NjdXI6CgoKKiBUaGUgbGVnYWN5
IGN1cnNvciBpb2N0bCBmYWlscyB3aXRoIEVJTlZBTCBmb3IgYSBub24tMCBjdXJzb3IgRkIgSUQK
CiAgICh3aGljaCBlbmFibGVzIHRoZSBjdXJzb3IgcGxhbmUpLgoKKiBJZiB0aGUgY3Vyc29yIHBs
YW5lIGlzIGVuYWJsZWQgKGUuZy4gdXNpbmcgdGhlIGxlZ2FjeSBjdXJzb3IgaW9jdGwKICAgZHVy
aW5nIERQTVMgb2ZmKSwgY2hhbmdpbmcgdGhlIGxlZ2FjeSBEUE1TIHByb3BlcnR5CiAgdmFsdWUg
ZnJvbSBvZmYgdG8KICAgb24gZmFpbHMgd2l0aCBFSU5WQUwuCgoKTW9yZW92ZXIsIGluIHRoZSBz
YW1lIHNjZW5hcmlvIHBsdXMgYW4gb3ZlcmxheSBwbGFuZSBlbmFibGVkIHdpdGggYSBIVyBjdXJz
b3IgY29tcGF0aWJsZSBmb3JtYXQsIGlmIHRoZSBGQiBib3VuZCB0byB0aGUgb3ZlcmxheSBwbGFu
ZSBpcyBkZXN0cm95ZWQsIHRoZSBjb21tb24gRFJNIGNvZGUgd2lsbCBhdHRlbXB0IHRvIGRpc2Fi
bGUgdGhlIG92ZXJsYXkgcGxhbmUsIGJ1dCBkbV9jaGVja19jcnRjX2N1cnNvciB3aWxsIHJlamVj
dCB0aGF0IG5vdy4gSSBjYW4ndCByZW1lbWJlciBleGFjdGx5IHdoYXQgdGhlIHJlc3VsdCBpcywg
YnV0IEFGQUlSIGl0J3Mgbm90IHByZXR0eS4KCgotLSAKRWFydGhsaW5nIE1pY2hlbCBEw6RuemVy
ICAgICAgICAgICAgICAgfCAgICAgICAgICAgICAgIGh0dHBzOi8vcmVkaGF0LmNvbQpMaWJyZSBz
b2Z0d2FyZSBlbnRodXNpYXN0ICAgICAgICAgICAgIHwgICAgICAgICAgICAgTWVzYSBhbmQgWCBk
ZXZlbG9wZXIKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
YW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6
Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
