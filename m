Return-Path: <SRS0=anlk=IC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A458C433E0
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Mar 2021 09:05:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C42064F11
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Mar 2021 09:05:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C42064F11
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daenzer.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 328566E49F;
	Thu,  4 Mar 2021 09:05:08 +0000 (UTC)
Received: from netline-mail3.netline.ch (mail.netline.ch [148.251.143.178])
 by gabe.freedesktop.org (Postfix) with ESMTP id 58C6F6E49F
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Mar 2021 09:05:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by netline-mail3.netline.ch (Postfix) with ESMTP id 98E8A2A6045;
 Thu,  4 Mar 2021 10:05:04 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at netline-mail3.netline.ch
Received: from netline-mail3.netline.ch ([127.0.0.1])
 by localhost (netline-mail3.netline.ch [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id GJkoAbmeOYrN; Thu,  4 Mar 2021 10:05:04 +0100 (CET)
Received: from thor (24.99.2.85.dynamic.wline.res.cust.swisscom.ch
 [85.2.99.24])
 by netline-mail3.netline.ch (Postfix) with ESMTPSA id 13C882A6042;
 Thu,  4 Mar 2021 10:05:04 +0100 (CET)
Received: from localhost ([::1]) by thor with esmtp (Exim 4.94)
 (envelope-from <michel@daenzer.net>)
 id 1lHjup-0028qz-JP; Thu, 04 Mar 2021 10:05:03 +0100
To: Daniel Vetter <daniel@ffwll.ch>
References: <I5B1EIA88M4W0bSuy9DLTgt70QGefRznp9IdJ14Cco@cp7-web-042.plabs.ch>
 <326ccbf2-8752-2fa2-b757-6811b90ecb8b@daenzer.net>
 <CAKMK7uE1+Y_agt=YCMf7OS6X-QjhAXsPO+3asWsahda11ev-eQ@mail.gmail.com>
From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>
Subject: Re: [PATCH 3/6] amd/display: fail on cursor plane without an
 underlying plane
Message-ID: <e7661e4b-a99c-5be7-9912-421ac3e61ff0@daenzer.net>
Date: Thu, 4 Mar 2021 10:05:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <CAKMK7uE1+Y_agt=YCMf7OS6X-QjhAXsPO+3asWsahda11ev-eQ@mail.gmail.com>
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
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gMjAyMS0wMy0wMyA4OjE3IHAubS4sIERhbmllbCBWZXR0ZXIgd3JvdGU6Cj4gT24gV2VkLCBN
YXIgMywgMjAyMSBhdCA1OjUzIFBNIE1pY2hlbCBEw6RuemVyIDxtaWNoZWxAZGFlbnplci5uZXQ+
IHdyb3RlOgo+Pgo+PiBPbiAyMDIxLTAyLTE5IDc6NTggcC5tLiwgU2ltb24gU2VyIHdyb3RlOgo+
Pj4gTWFrZSBzdXJlIHRoZXJlJ3MgYW4gdW5kZXJseWluZyBwaXBlIHRoYXQgY2FuIGJlIHVzZWQg
Zm9yIHRoZQo+Pj4gY3Vyc29yLgo+Pj4KPj4+IFNpZ25lZC1vZmYtYnk6IFNpbW9uIFNlciA8Y29u
dGFjdEBlbWVyc2lvbi5mcj4KPj4+IENjOiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVy
QGFtZC5jb20+Cj4+PiBDYzogSGFycnkgV2VudGxhbmQgPGh3ZW50bGFuQGFtZC5jb20+Cj4+PiBD
YzogTmljaG9sYXMgS2F6bGF1c2thcyA8bmljaG9sYXMua2F6bGF1c2thc0BhbWQuY29tPgo+Pj4g
LS0tCj4+PiAgICBkcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9k
bS5jIHwgNyArKysrKystCj4+PiAgICAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspLCAx
IGRlbGV0aW9uKC0pCj4+Pgo+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlz
cGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkv
YW1kZ3B1X2RtL2FtZGdwdV9kbS5jCj4+PiBpbmRleCBhY2JlMTUzN2U3Y2YuLmE1ZDYwMTA0MDVi
ZiAxMDA2NDQKPj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0v
YW1kZ3B1X2RtLmMKPj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRncHVf
ZG0vYW1kZ3B1X2RtLmMKPj4+IEBAIC05MjI2LDkgKzkyMjYsMTQgQEAgc3RhdGljIGludCBkbV9j
aGVja19jcnRjX2N1cnNvcihzdHJ1Y3QgZHJtX2F0b21pY19zdGF0ZSAqc3RhdGUsCj4+PiAgICAg
ICAgfQo+Pj4KPj4+ICAgICAgICBuZXdfY3Vyc29yX3N0YXRlID0gZHJtX2F0b21pY19nZXRfbmV3
X3BsYW5lX3N0YXRlKHN0YXRlLCBjcnRjLT5jdXJzb3IpOwo+Pj4gLSAgICAgaWYgKCFuZXdfY3Vy
c29yX3N0YXRlIHx8ICFuZXdfdW5kZXJseWluZ19zdGF0ZSB8fCAhbmV3X2N1cnNvcl9zdGF0ZS0+
ZmIpCj4+PiArICAgICBpZiAoIW5ld19jdXJzb3Jfc3RhdGUgfHwgIW5ld19jdXJzb3Jfc3RhdGUt
PmZiKQo+Pj4gICAgICAgICAgICAgICAgcmV0dXJuIDA7Cj4+Pgo+Pj4gKyAgICAgaWYgKCFuZXdf
dW5kZXJseWluZ19zdGF0ZSB8fCAhbmV3X3VuZGVybHlpbmdfc3RhdGUtPmZiKSB7Cj4+PiArICAg
ICAgICAgICAgIGRybV9kYmdfYXRvbWljKGNydGMtPmRldiwgIkN1cnNvciBwbGFuZSBjYW4ndCBi
ZSBlbmFibGVkIHdpdGhvdXQgdW5kZXJseWluZyBwbGFuZVxuIik7Cj4+PiArICAgICAgICAgICAg
IHJldHVybiAtRUlOVkFMOwo+Pj4gKyAgICAgfQo+Pj4gKwo+Pj4gICAgICAgIGN1cnNvcl9zY2Fs
ZV93ID0gbmV3X2N1cnNvcl9zdGF0ZS0+Y3J0Y193ICogMTAwMCAvCj4+PiAgICAgICAgICAgICAg
ICAgICAgICAgICAobmV3X2N1cnNvcl9zdGF0ZS0+c3JjX3cgPj4gMTYpOwo+Pj4gICAgICAgIGN1
cnNvcl9zY2FsZV9oID0gbmV3X2N1cnNvcl9zdGF0ZS0+Y3J0Y19oICogMTAwMCAvCj4+Pgo+Pgo+
PiBIb3VzdG9uLCB3ZSBoYXZlIGEgcHJvYmxlbSBJJ20gYWZyYWlkLiBBZGRpbmcgRGFuaWVsLgo+
Pgo+Pgo+PiBJZiB0aGUgcHJpbWFyeSBwbGFuZSBpcyBlbmFibGVkIHdpdGggYSBmb3JtYXQgd2hp
Y2ggaXNuJ3QgY29tcGF0aWJsZSB3aXRoIHRoZSBIVyBjdXJzb3IsCj4+IGFuZCBubyBvdmVybGF5
IHBsYW5lIGlzIGVuYWJsZWQsIHRoZSBzYW1lIGlzc3VlcyBhcyBkZXNjcmliZWQgaW4gYjgzNmEy
NzRiNzk3Cj4+ICJkcm0vYW1kZ3B1L2RjOiBSZXF1aXJlIHByaW1hcnkgcGxhbmUgdG8gYmUgZW5h
YmxlZCB3aGVuZXZlciB0aGUgQ1JUQyBpcyIgY2FuIGFnYWluIG9jY3VyOgo+Pgo+Pgo+PiAqIFRo
ZSBsZWdhY3kgY3Vyc29yIGlvY3RsIGZhaWxzIHdpdGggRUlOVkFMIGZvciBhIG5vbi0wIGN1cnNv
ciBGQiBJRAo+PiAgICh3aGljaCBlbmFibGVzIHRoZSBjdXJzb3IgcGxhbmUpLgo+Pgo+PiAqIElm
IHRoZSBjdXJzb3IgcGxhbmUgaXMgZW5hYmxlZCAoZS5nLiB1c2luZyB0aGUgbGVnYWN5IGN1cnNv
ciBpb2N0bAo+PiAgIGR1cmluZyBEUE1TIG9mZiksIGNoYW5naW5nIHRoZSBsZWdhY3kgRFBNUyBw
cm9wZXJ0eSB2YWx1ZSBmcm9tIG9mZiB0bwo+PiAgIG9uIGZhaWxzIHdpdGggRUlOVkFMLgo+IAo+
IGF0b21pY19jaGVjayBzaG91bGQgc3RpbGwgYmUgcnVuIHdoZW4gdGhlIGNydGMgaXMgb2ZmLCBz
byB0aGUgbGVnYWN5Cj4gY3Vyc29yIGlvY3RsIHNob3VsZCBmYWlsIHdoZW4gZHBtcyBvZmYgaW4g
dGhpcyBjYXNlIGFscmVhZHkuCgpHb29kIHBvaW50LiBUaGlzIGNvdWxkIGFscmVhZHkgYmUgcHJv
YmxlbWF0aWMgdGhvdWdoLiBFLmcuIG11dHRlciB0cmVhdHMKRUlOVkFMIGZyb20gdGhlIGN1cnNv
ciBpb2N0bCBhcyB0aGUgZHJpdmVyIG5vdCBzdXBwb3J0aW5nIEhXIGN1cnNvcnMgYXQKYWxsLCBz
byBpdCBmYWxscyBiYWNrIHRvIFNXIGN1cnNvciBhbmQgbmV2ZXIgdHJpZXMgdG8gdXNlIHRoZSBI
VyBjdXJzb3IKYWdhaW4uIChJIGRvbid0IHRoaW5rIG11dHRlciBjb3VsZCBoaXQgdGhpcyBwYXJ0
aWN1bGFyIGNhc2Ugd2l0aCBhbgppbmNvbXBhdGlibGUgZm9ybWF0IHRob3VnaCwgYnV0IHRoZXJl
IG1pZ2h0IGJlIG90aGVyIHNpbWlsYXIgdXNlciBzcGFjZSkKCgo+PiBNb3Jlb3ZlciwgaW4gdGhl
IHNhbWUgc2NlbmFyaW8gcGx1cyBhbiBvdmVybGF5IHBsYW5lIGVuYWJsZWQgd2l0aCBhCj4+IEhX
IGN1cnNvciBjb21wYXRpYmxlIGZvcm1hdCwgaWYgdGhlIEZCIGJvdW5kIHRvIHRoZSBvdmVybGF5
IHBsYW5lIGlzCj4+IGRlc3Ryb3llZCwgdGhlIGNvbW1vbiBEUk0gY29kZSB3aWxsIGF0dGVtcHQg
dG8gZGlzYWJsZSB0aGUgb3ZlcmxheQo+PiBwbGFuZSwgYnV0IGRtX2NoZWNrX2NydGNfY3Vyc29y
IHdpbGwgcmVqZWN0IHRoYXQgbm93LiBJIGNhbid0IHJlbWVtYmVyCj4+IGV4YWN0bHkgd2hhdCB0
aGUgcmVzdWx0IGlzLCBidXQgQUZBSVIgaXQncyBub3QgcHJldHR5Lgo+IAo+IENSVEMgZ2V0cyBk
aXNhYmxlZCBpbnN0ZWFkLiBUaGF0J3Mgd2h5IHdlIHdlbnQgd2l0aCB0aGUgImFsd2F5cwo+IHJl
cXVpcmUgcHJpbWFyeSBwbGFuZSIgaGFjay4gSSB0aGluayB0aGUgb25seSBzb2x1dGlvbiBoZXJl
IHdvdWxkIGJlCj4gdG8gZW5hYmxlIHRoZSBwcmltYXJ5IHBsYW5lIChidXQgbm90IGluIHVzZXJz
cGFjZS12aXNpYmxlIHN0YXRlLCBzbwo+IHRoaXMgbmVlZHMgdG8gYmUgZG9uZSBpbiB0aGUgZGMg
ZGVyaXZlZCBzdGF0ZSBvYmplY3RzIG9ubHkpIHRoYXQgc2NhbnMKPiBvdXQgYmxhY2sgYW55IHRp
bWUgd2UncmUgaW4gc3VjaCBhIHNpdHVhdGlvbiB3aXRoIGN1cnNvciB3aXRoIG5vCj4gcGxhbmVz
LgoKVGhpcyBpcyBhYm91dCBhIHNjZW5hcmlvIGRlc2NyaWJlZCBieSBOaWNob2xhcyBlYXJsaWVy
OgoKQ3Vyc29yIFBsYW5lIC0gQVJHQjg4ODgKCk92ZXJsYXkgUGxhbmUgLSBBUkdCODg4OCBEZXNr
dG9wL1VJIHdpdGggY3V0b3V0IGZvciB2aWRlbwoKUHJpbWFyeSBQbGFuZSAtIE5WMTIgdmlkZW8K
CkFuZCBkZXN0cm95aW5nIHRoZSBGQiBib3VuZCB0byB0aGUgb3ZlcmxheSBwbGFuZS4gVGhlIGZh
bGxiYWNrIHRvIGRpc2FibGUKdGhlIENSVEMgaW4gYXRvbWljX3JlbW92ZV9mYiBvbmx5IGtpY2tz
IGluIGZvciB0aGUgcHJpbWFyeSBwbGFuZSwgc28gaXQKd291bGRuJ3QgaW4gdGhpcyBjYXNlIGFu
ZCB3b3VsZCBmYWlsLiBXaGljaCB3b3VsZCBpbiB0dXJuIHRyaWdnZXIgdGhlCldBUk4gaW4gZHJt
X2ZyYW1lYnVmZmVyX3JlbW92ZSAoYW5kIGxlYXZlIHRoZSBvdmVybGF5IHBsYW5lIHNjYW5uaW5n
IG91dApmcm9tIGZyZWVkIG1lbW9yeT8pLgoKClRoZSBjbGVhbmVzdCBzb2x1dGlvbiBtaWdodCBi
ZSBub3QgdG8gYWxsb3cgYW55IGZvcm1hdHMgaW5jb21wYXRpYmxlIHdpdGgKdGhlIEhXIGN1cnNv
ciBmb3IgdGhlIHByaW1hcnkgcGxhbmUuCgoKLS0gCkVhcnRobGluZyBNaWNoZWwgRMOkbnplciAg
ICAgICAgICAgICAgIHwgICAgICAgICAgICAgICBodHRwczovL3JlZGhhdC5jb20KTGlicmUgc29m
dHdhcmUgZW50aHVzaWFzdCAgICAgICAgICAgICB8ICAgICAgICAgICAgIE1lc2EgYW5kIFggZGV2
ZWxvcGVyCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFt
ZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8v
bGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
