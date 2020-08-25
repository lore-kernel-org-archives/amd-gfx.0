Return-Path: <SRS0=LR/f=CD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54D48C433DF
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Aug 2020 14:55:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 309D42075F
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Aug 2020 14:55:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 309D42075F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daenzer.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 78B036E566;
	Tue, 25 Aug 2020 14:55:32 +0000 (UTC)
Received: from netline-mail3.netline.ch (mail.netline.ch [148.251.143.178])
 by gabe.freedesktop.org (Postfix) with ESMTP id 2CFBC6E42B;
 Tue, 25 Aug 2020 14:55:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by netline-mail3.netline.ch (Postfix) with ESMTP id 230AD2A6042;
 Tue, 25 Aug 2020 16:55:30 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at netline-mail3.netline.ch
Received: from netline-mail3.netline.ch ([127.0.0.1])
 by localhost (netline-mail3.netline.ch [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id kODSs_kEuStS; Tue, 25 Aug 2020 16:55:29 +0200 (CEST)
Received: from thor (212.174.63.188.dynamic.wline.res.cust.swisscom.ch
 [188.63.174.212])
 by netline-mail3.netline.ch (Postfix) with ESMTPSA id 7C3372A6016;
 Tue, 25 Aug 2020 16:55:29 +0200 (CEST)
Received: from [::1] by thor with esmtp (Exim 4.94)
 (envelope-from <michel@daenzer.net>)
 id 1kAaMC-000Yv0-Tj; Tue, 25 Aug 2020 16:55:28 +0200
Subject: Re: [PATCH] drm/amdgpu/dc: Require primary plane to be enabled
 whenever the CRTC is
To: Pekka Paalanen <ppaalanen@gmail.com>,
 "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>
References: <20200821165758.1106210-1-michel@daenzer.net>
 <58dc5ed0-307e-74c9-1a8b-1e998be04900@amd.com>
 <91391bb3-a855-1a29-2d2e-a31856c99946@daenzer.net>
 <20200824104327.559503f7@eldfell>
From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>
Message-ID: <b8bc3e37-d9b3-2aeb-8580-f265f1b8c830@daenzer.net>
Date: Tue, 25 Aug 2020 16:55:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200824104327.559503f7@eldfell>
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
Cc: Leo Li <sunpeng.li@amd.com>, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

LS0tLS1CRUdJTiBQR1AgU0lHTkVEIE1FU1NBR0UtLS0tLQpIYXNoOiBTSEExCgpPbiAyMDIwLTA4
LTI0IDk6NDMgYS5tLiwgUGVra2EgUGFhbGFuZW4gd3JvdGU6Cj4gT24gU2F0LCAyMiBBdWcgMjAy
MCAxMTo1OToyNiArMDIwMCBNaWNoZWwgRMOkbnplcgo+IDxtaWNoZWxAZGFlbnplci5uZXQ+IHdy
b3RlOgo+PiBPbiAyMDIwLTA4LTIxIDg6MDcgcC5tLiwgS2F6bGF1c2thcywgTmljaG9sYXMgd3Jv
dGU6Cj4+PiBPbiAyMDIwLTA4LTIxIDEyOjU3IHAubS4sIE1pY2hlbCBEw6RuemVyIHdyb3RlOgo+
Pj4+IEZyb206IE1pY2hlbCBEw6RuemVyIDxtZGFlbnplckByZWRoYXQuY29tPgo+Pj4+Cj4+Pj4g
RG9uJ3QgY2hlY2sgZHJtX2NydGNfc3RhdGU6OmFjdGl2ZSBmb3IgdGhpcyBlaXRoZXIsIHBlciBp
dHMKPj4+PiBkb2N1bWVudGF0aW9uIGluIGluY2x1ZGUvZHJtL2RybV9jcnRjLmg6Cj4+Pj4KPj4+
PiAqIEhlbmNlIGRyaXZlcnMgbXVzdCBub3QgY29uc3VsdCBAYWN0aXZlIGluIHRoZWlyIHZhcmlv
dXMgKgo+Pj4+ICZkcm1fbW9kZV9jb25maWdfZnVuY3MuYXRvbWljX2NoZWNrIGNhbGxiYWNrIHRv
IHJlamVjdCBhbgo+Pj4+IGF0b21pYyAqIGNvbW1pdC4KPj4+Pgo+Pj4+IFRoZSBhdG9taWMgaGVs
cGVycyBkaXNhYmxlIHRoZSBDUlRDIGFzIG5lZWRlZCBmb3IgZGlzYWJsaW5nCj4+Pj4gdGhlIHBy
aW1hcnkgcGxhbmUuCj4+Pj4KPj4+PiBUaGlzIHByZXZlbnRzIGF0IGxlYXN0IHRoZSBmb2xsb3dp
bmcgcHJvYmxlbXMgaWYgdGhlIHByaW1hcnkKPj4+PiBwbGFuZSBnZXRzIGRpc2FibGVkIChlLmcu
IGR1ZSB0byBkZXN0cm95aW5nIHRoZSBGQiBhc3NpZ25lZAo+Pj4+IHRvIHRoZSBwcmltYXJ5IHBs
YW5lLCBhcyBoYXBwZW5zIGUuZy4gd2l0aCBtdXR0ZXIgaW4gV2F5bGFuZAo+Pj4+IG1vZGUpOgo+
Pj4+Cj4+Pj4gKiBUb2dnbGluZyBDUlRDIGFjdGl2ZSB0byAxIGZhaWxlZCBpZiB0aGUgY3Vyc29y
IHBsYW5lIHdhcwo+Pj4+IGVuYWJsZWQgKGUuZy4gdmlhIGxlZ2FjeSBEUE1TIHByb3BlcnR5ICYg
Y3Vyc29yIGlvY3RsKS4gKgo+Pj4+IEVuYWJsaW5nIHRoZSBjdXJzb3IgcGxhbmUgZmFpbGVkLCBl
LmcuIHZpYSB0aGUgbGVnYWN5IGN1cnNvcgo+Pj4+IGlvY3RsLgo+Pj4KPj4+IFdlIHByZXZpb3Vz
bHkgaGFkIHRoZSByZXF1aXJlbWVudCB0aGF0IHRoZSBwcmltYXJ5IHBsYW5lIG11c3QKPj4+IGJl
IGVuYWJsZWQgYnV0IHNvbWUgdXNlcnNwYWNlIGV4cGVjdHMgdGhhdCB0aGV5IGNhbiBlbmFibGUK
Pj4+IGp1c3QgdGhlIG92ZXJsYXkgcGxhbmUgd2l0aG91dCBhbnl0aGluZyBlbHNlLgo+Pj4KPj4+
IEkgdGhpbmsgdGhlIGNocm9tdWl1bW9zIGF0b21pY3Rlc3QgdmFsaWRhdGVzIHRoYXQgdGhpcyB3
b3Jrcwo+Pj4gYXMgd2VsbDoKPj4+Cj4+PiBTbyBpcyBEUk0gZ29pbmcgZm9yd2FyZCB0aGVuIHdp
dGggdGhlIGV4cGVjdGF0aW9uIHRoYXQgdGhpcyBpcwo+Pj4gd3JvbmcgYmVoYXZpb3IgZnJvbSB1
c2Vyc3BhY2U/Cj4+Pgo+Pj4gV2UgcmVxdWlyZSBhdCBsZWFzdCBvbmUgcGxhbmUgdG8gYmUgZW5h
YmxlZCB0byBkaXNwbGF5IGEKPj4+IGN1cnNvciwgYnV0IGl0IGRvZXNuJ3QgbmVjZXNzYXJpbHkg
bmVlZCB0byBiZSB0aGUgcHJpbWFyeS4KPj4KPj4gSXQncyBhICJwaWNrIHlvdXIgcG9pc29uIiBz
aXR1YXRpb246Cj4+Cj4+IDEpIEN1cnJlbnRseSB0aGUgY2hlY2tzIGFyZSBpbnZhbGlkIChhdG9t
aWNfY2hlY2sgbXVzdCBub3QKPj4gZGVjaWRlIGJhc2VkIG9uIGRybV9jcnRjX3N0YXRlOjphY3Rp
dmUpLCBhbmQgaXQncyBlYXN5IGZvciBsZWdhY3kKPj4gS01TIHVzZXJzcGFjZSB0byBhY2NpZGVu
dGFsbHkgaGl0IGVycm9ycyB0cnlpbmcgdG8gZW5hYmxlL21vdmUKPj4gdGhlIGN1cnNvciBvciBz
d2l0Y2ggRFBNUyBvZmYg4oaSIG9uLgo+Pgo+PiAyKSBBY2N1cmF0ZWx5IHJlamVjdGluZyBvbmx5
IGF0b21pYyBzdGF0ZXMgd2hlcmUgdGhlIGN1cnNvcgo+PiBwbGFuZSBpcyBlbmFibGVkIGJ1dCBh
bGwgb3RoZXIgcGxhbmVzIGFyZSBvZmYgd291bGQgYnJlYWsgdGhlCj4+IEtNUyBoZWxwZXIgY29k
ZSwgd2hpY2ggY2FuIG9ubHkgZGVhbCB3aXRoIHRoZSAiQ1JUQyBvbiAmIHByaW1hcnkKPj4gcGxh
bmUgb2ZmIGlzIG5vdCBhbGxvd2VkIiBjYXNlIHNwZWNpZmljYWxseS4KPj4KPj4gMykgVGhpcyBw
YXRjaCBhZGRyZXNzZXMgMSkgJiAyKSBidXQgbWF5IGJyZWFrIGV4aXN0aW5nIGF0b21pYwo+PiB1
c2Vyc3BhY2Ugd2hpY2ggd2FudHMgdG8gZW5hYmxlIGFuIG92ZXJsYXkgcGxhbmUgd2hpbGUgZGlz
YWJsaW5nCj4+IHRoZSBwcmltYXJ5IHBsYW5lLgo+Pgo+Pgo+PiBJIGRvIHRoaW5rIGluIHByaW5j
aXBsZSBhdG9taWMgdXNlcnNwYWNlIGlzIGV4cGVjdGVkIHRvIGhhbmRsZQo+PiBjYXNlIDMpIGFu
ZCBsZWF2ZSB0aGUgcHJpbWFyeSBwbGFuZSBlbmFibGVkLgo+Cj4gSGksCj4KPiBteSBvcGluaW9u
IGFzIGEgdXNlcnNwYWNlIGRldmVsb3BlciBpcyB0aGF0IGVuYWJsaW5nIGEgQ1JUQwo+IHdpdGhv
dXQgYSBwcmltYXJ5IHBsYW5lIGhhcyB0cmFkaXRpb25hbGx5IG5vdCB3b3JrZWQsIHNvIHVzZXJz
cGFjZQo+IGNhbm5vdCAqcmVseSogb24gaXQgZXZlciB3b3JraW5nLiBJIHRoaW5rIGxlZ2FjeSBL
TVMgQVBJIGRvZXMgbm90Cj4gZXZlbiBhbGxvdyB0byBleHByZXNzIHRoYXQgcmVhbGx5LCBvciBo
YXMgYnVpbHQtaW4gYXNzdW1wdGlvbnMgdGhhdAo+IGl0IGRvZXNuJ3Qgd29yayAtIHlvdSBjYW4g
Y2FsbCB0aGUgbGVnYWN5IGN1cnNvciBpb2N0bHMsIHRoZXkKPiBkb24ndCBmYWlsLCBidXQgYWxz
byB0aGUgQ1JUQyByZW1haW5zIG9mZi4gQ29ycmVjdCBtZSBpZiB0aGlzIGlzCj4gbm90IHRydWUu
Cj4KPiBBdG9taWMgdXNlcnNwYWNlIE9UT0ggaXMgcmVxdWlyZWQgdG8gdGVzdCB0aGUgc3RyYW5n
ZSAoYW5kIGFsbCEpCj4gY2FzZXMgbGlrZSB0aGlzIHRvIHNlZSBpZiB0aGV5IHdvcmsgb3Igbm90
LCBhbmQgY2Fycnkgb24gd2l0aCBhCj4gZmFsbGJhY2sgaWYgdGhleSBkb24ndC4gVXNlcnNwYWNl
IHRoYXQgd2FudHMgdG8gdXNlIGEgQ1JUQyB3aXRob3V0Cj4gYSBwcmltYXJ5IHBsYW5lIGxpa2Vs
eSBuZWVkcyBvdGhlciBDUlRDIHByb3BlcnRpZXMgYXMgd2VsbCwgbGlrZQo+IGJhY2tncm91bmQg
Y29sb3IuCj4KPiBJIHdvdWxkIGd1ZXNzIHRoYXQgd2hlbiB0d28gcmVncmVzc2lvbnMgY29uZmxp
Y3QsIHRoZSBvbGRlcgo+IHVzZXJzcGFjZSB3b3VsZCB3aW4uIEhlbmNlIGxlZ2FjeSBLTVMgdXNp
bmcgTXV0dGVyIHNob3VsZCBrZWVwCj4gd29ya2luZywgd2hpbGUgYXRvbWljIHVzZXJzcGFjZSBp
cyBsZWZ0IHdpdGggaW5jcmVhc2VkIHBvd2VyCj4gY29uc3VtcHRpb24uIE5vdCB1c2luZyBhIGhh
cmR3YXJlIGN1cnNvciAoTXV0dGVyKSBpcyBtdWNoIG1vcmUKPiBlYXNpbHkgYW4gZW5kLXVzZXIg
dmlzaWJsZSByZWdyZXNzaW9uIHRoYW4gc2xpZ2h0bHkgc2hvcnRlcgo+IGJhdHRlcnkgbGlmZS4K
Pgo+IEF0b21pYyB0ZXN0IGNvbW1pdHMgYXJlIGFsbG93ZWQgdG8gZmFpbCBhdCBhbnkgdGltZSBm
b3IgYW55IHJlYXNvbgo+IGFuZCBzb21ldGhpbmcgdGhhdCBwcmV2aW91c2x5IHdvcmtlZCBjYW4g
ZmFpbCBvbiB0aGUgbmV4dCBmcmFtZSBvcgo+IG9uIHRoZSBuZXh0IGtlcm5lbCwgYXMgZmFyIGFz
IEkgdW5kZXJzdGFuZC4KCkFsbCBvZiB0aGlzIGJhc2ljYWxseSBtYXRjaGVzIG15IHVuZGVyc3Rh
bmRpbmcuCgoKPiBTb3VuZHMgbGlrZSB0aGUgaGVscGVycyB5b3UgcmVmZXIgdG8gYXJlIGluYWRl
cXVhdGUgZm9yIHlvdXIgY2FzZS4KPiBDYW4ndCB5b3UgZml4IHRoZSBoZWxwZXJzIGluIHRoZSBs
b25nIHJ1biBhbmQgbGFuZCB0aGlzIHBhdGNoIGFzIGFuCj4gaW1tZWRpYXRlIGZpeD8KCkknZCBy
YXRoZXIgbGVhdmUgd29ya2luZyBvbiB0aG9zZSBoZWxwZXJzIHRvIEtNUyBkZXZlbG9wZXJzLiA6
KQoKCi0gLS0gCkVhcnRobGluZyBNaWNoZWwgRMOkbnplciAgICAgICAgICAgICAgIHwgICAgICAg
ICAgICAgICBodHRwczovL3JlZGhhdC5jb20KTGlicmUgc29mdHdhcmUgZW50aHVzaWFzdCAgICAg
ICAgICAgICB8ICAgICAgICAgICAgIE1lc2EgYW5kIFggZGV2ZWxvcGVyCi0tLS0tQkVHSU4gUEdQ
IFNJR05BVFVSRS0tLS0tCgppRjBFQVJFQ0FCMFdJUVN3bjY4MXZwRkZJWmdKVVJSYWdhK09hdHV5
QUFVQ1gwVW1YQUFLQ1JCYWdhK09hdHV5CkFJZU5BSm9DOVVnT3JGK3FCcTA4dU95amFWN1ZmcCtQ
Z0FDZlNwM25YQjN1bjNMVVpReHJ2YXhNQU9OK2VJcz0KPVBiZDIKLS0tLS1FTkQgUEdQIFNJR05B
VFVSRS0tLS0tCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBz
Oi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
