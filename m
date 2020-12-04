Return-Path: <SRS0=65vk=FI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23AA9C4361A
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Dec 2020 13:37:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D2E022795
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Dec 2020 13:37:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D2E022795
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daenzer.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C7D376E17A;
	Fri,  4 Dec 2020 13:37:09 +0000 (UTC)
Received: from netline-mail3.netline.ch (mail.netline.ch [148.251.143.178])
 by gabe.freedesktop.org (Postfix) with ESMTP id 6AEB46E17A
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Dec 2020 13:37:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by netline-mail3.netline.ch (Postfix) with ESMTP id 9F24A2A6045;
 Fri,  4 Dec 2020 14:37:07 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at netline-mail3.netline.ch
Received: from netline-mail3.netline.ch ([127.0.0.1])
 by localhost (netline-mail3.netline.ch [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id elihuZZq_5TS; Fri,  4 Dec 2020 14:37:07 +0100 (CET)
Received: from thor (212.174.63.188.dynamic.wline.res.cust.swisscom.ch
 [188.63.174.212])
 by netline-mail3.netline.ch (Postfix) with ESMTPSA id 289132A6016;
 Fri,  4 Dec 2020 14:37:07 +0100 (CET)
Received: from [::1] by thor with esmtp (Exim 4.94)
 (envelope-from <michel@daenzer.net>)
 id 1klBGt-0009KX-2i; Fri, 04 Dec 2020 14:37:06 +0100
Subject: Re: [PATCH] drm/amd: print error on convert_tiling_flags_to_modifier
 failure
To: Simon Ser <contact@emersion.fr>
References: <j1fYvGbEZdykS0AhDWeyCo79c5aqNmrQBIuTcljx8@cp3-web-016.plabs.ch>
 <71eb00a6-d442-8ff4-394f-554e5f5d020f@daenzer.net>
 <xrH38go5_dtuCm3o7suU4QZ54y1NxgeqLjS4XTn-6rXD-907wQqCNNSw_XV7qlwt8tm9lUgOJo6-MQTxoyQyLDQaGCHHoLBxPIdAfLzh9xU=@emersion.fr>
From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>
Message-ID: <9dde4390-9052-7c9a-c8da-72f163407274@daenzer.net>
Date: Fri, 4 Dec 2020 14:37:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <xrH38go5_dtuCm3o7suU4QZ54y1NxgeqLjS4XTn-6rXD-907wQqCNNSw_XV7qlwt8tm9lUgOJo6-MQTxoyQyLDQaGCHHoLBxPIdAfLzh9xU=@emersion.fr>
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
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gMjAyMC0xMi0wNCAxOjAxIHAubS4sIFNpbW9uIFNlciB3cm90ZToKPiBPbiBGcmlkYXksIERl
Y2VtYmVyIDQsIDIwMjAgMTI6NTIgUE0sIE1pY2hlbCBEw6RuemVyIDxtaWNoZWxAZGFlbnplci5u
ZXQ+IHdyb3RlOgo+IAo+PiBUaGlzIHNob3VsZCBiZSBlaXRoZXIgYSBkZWJ1Z2dpbmcgbWVzc2Fn
ZSBkaXNhYmxlZCBieSBkZWZhdWx0LCBvcgo+PiByYXRlLWxpbWl0ZWQgc29tZWhvdywgb3IgdXNl
ci1zcGFjZSBjYW4gc3BhbSBkbWVzZy4KPiAKPiBIbS4gSSBqdXN0IG1pbWlja2VkIHdoYXQgYW1k
Z3B1X2Rpc3BsYXlfdXNlcl9mcmFtZWJ1ZmZlcl9jcmVhdGUgaXMKPiBkb2luZyBoZXJlOgo+IAo+
ICAgICAgZGV2X2VycigmZGV2LT5wZGV2LT5kZXYsICJObyBHRU0gb2JqZWN0IGFzc29jaWF0ZWQg
dG8gaGFuZGxlIDB4JTA4WCwgIgo+ICAgICAgICAgICAgICAiY2FuJ3QgY3JlYXRlIGZyYW1lYnVm
ZmVyXG4iLCBtb2RlX2NtZC0+aGFuZGxlc1swXSk7Cj4gCj4gQnV0IHllYWggRFJNX0RFQlVHX0tN
UyB3b3VsZCBwcm9iYWJseSBiZSBtb3JlIGFwcHJvcHJpYXRlIGhlcmUuIE1heWJlCj4gbWFrZXMg
c2Vuc2UgdG8gY2hhbmdlIGRldl9lcnIgdG8gRFJNX0RFQlVHX0tNUyBpbgo+IGFtZGdwdV9kaXNw
bGF5X3VzZXJfZnJhbWVidWZmZXJfY3JlYXRlIGFzIHdlbGw/IEkgYmVsaWV2ZSB1c2VyLXNwYWNl
Cj4gY2FuIHRyaWdnZXIgdGhhdCBvbmUgYXQgd2lsbCB0b28uCgpUaGVyZSBhcmUgcHJvYmFibHkg
bWFueSBtb3JlIGJhZCBleGFtcGxlcyBpbiBleGlzdGluZyBjb2RlLiBUaGUgCmltcG9ydGFudCB0
aGluZyBpcyBub3QgdG8gYWRkIG1vcmUuIDopCgoKLS0gCkVhcnRobGluZyBNaWNoZWwgRMOkbnpl
ciAgICAgICAgICAgICAgIHwgICAgICAgICAgICAgICBodHRwczovL3JlZGhhdC5jb20KTGlicmUg
c29mdHdhcmUgZW50aHVzaWFzdCAgICAgICAgICAgICB8ICAgICAgICAgICAgIE1lc2EgYW5kIFgg
ZGV2ZWxvcGVyCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBz
Oi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
