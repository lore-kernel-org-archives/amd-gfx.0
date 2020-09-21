Return-Path: <SRS0=OtMv=C6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E300C43468
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Sep 2020 14:48:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E291720735
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Sep 2020 14:48:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E291720735
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daenzer.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 814026E135;
	Mon, 21 Sep 2020 14:48:09 +0000 (UTC)
Received: from netline-mail3.netline.ch (mail.netline.ch [148.251.143.178])
 by gabe.freedesktop.org (Postfix) with ESMTP id D81EF6E135;
 Mon, 21 Sep 2020 14:48:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by netline-mail3.netline.ch (Postfix) with ESMTP id CDC412A6045;
 Mon, 21 Sep 2020 16:48:07 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at netline-mail3.netline.ch
Received: from netline-mail3.netline.ch ([127.0.0.1])
 by localhost (netline-mail3.netline.ch [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id n-6O19CCSCnF; Mon, 21 Sep 2020 16:48:07 +0200 (CEST)
Received: from thor (212.174.63.188.dynamic.wline.res.cust.swisscom.ch
 [188.63.174.212])
 by netline-mail3.netline.ch (Postfix) with ESMTPSA id 192B92A6016;
 Mon, 21 Sep 2020 16:48:06 +0200 (CEST)
Received: from localhost ([::1]) by thor with esmtp (Exim 4.94)
 (envelope-from <michel@daenzer.net>)
 id 1kKN6w-000aC1-Sy; Mon, 21 Sep 2020 16:48:05 +0200
To: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20200921144054.2135602-1-sashal@kernel.org>
 <20200921144054.2135602-13-sashal@kernel.org>
From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>
Subject: Re: [PATCH AUTOSEL 5.4 13/15] drm/amdgpu/dc: Require primary plane to
 be enabled whenever the CRTC is
Message-ID: <1ee666b4-f1af-a19f-e03a-fdfc00698d2f@daenzer.net>
Date: Mon, 21 Sep 2020 16:48:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.2
MIME-Version: 1.0
In-Reply-To: <20200921144054.2135602-13-sashal@kernel.org>
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Daniel Vetter <daniel.vetter@ffwll.ch>, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gMjAyMC0wOS0yMSA0OjQwIHAubS4sIFNhc2hhIExldmluIHdyb3RlOgo+IEZyb206IE1pY2hl
bCBEw6RuemVyIDxtZGFlbnplckByZWRoYXQuY29tPgo+IAo+IFsgVXBzdHJlYW0gY29tbWl0IDJm
MjI4YWFiMjFiYmM3NGU5MGUyNjdhNzIxMjE1ZWM4YmU1MWRhZjcgXQo+IAo+IERvbid0IGNoZWNr
IGRybV9jcnRjX3N0YXRlOjphY3RpdmUgZm9yIHRoaXMgZWl0aGVyLCBwZXIgaXRzCj4gZG9jdW1l
bnRhdGlvbiBpbiBpbmNsdWRlL2RybS9kcm1fY3J0Yy5oOgo+IAo+ICAgKiBIZW5jZSBkcml2ZXJz
IG11c3Qgbm90IGNvbnN1bHQgQGFjdGl2ZSBpbiB0aGVpciB2YXJpb3VzCj4gICAqICZkcm1fbW9k
ZV9jb25maWdfZnVuY3MuYXRvbWljX2NoZWNrIGNhbGxiYWNrIHRvIHJlamVjdCBhbiBhdG9taWMK
PiAgICogY29tbWl0Lgo+IAo+IGF0b21pY19yZW1vdmVfZmIgZGlzYWJsZXMgdGhlIENSVEMgYXMg
bmVlZGVkIGZvciBkaXNhYmxpbmcgdGhlIHByaW1hcnkKPiBwbGFuZS4KPiAKPiBUaGlzIHByZXZl
bnRzIGF0IGxlYXN0IHRoZSBmb2xsb3dpbmcgcHJvYmxlbXMgaWYgdGhlIHByaW1hcnkgcGxhbmUg
Z2V0cwo+IGRpc2FibGVkIChlLmcuIGR1ZSB0byBkZXN0cm95aW5nIHRoZSBGQiBhc3NpZ25lZCB0
byB0aGUgcHJpbWFyeSBwbGFuZSwKPiBhcyBoYXBwZW5zIGUuZy4gd2l0aCBtdXR0ZXIgaW4gV2F5
bGFuZCBtb2RlKToKPiAKPiAqIFRoZSBsZWdhY3kgY3Vyc29yIGlvY3RsIHJldHVybmVkIEVJTlZB
TCBmb3IgYSBub24tMCBjdXJzb3IgRkIgSUQKPiAgICAod2hpY2ggZW5hYmxlcyB0aGUgY3Vyc29y
IHBsYW5lKS4KPiAqIElmIHRoZSBjdXJzb3IgcGxhbmUgd2FzIGVuYWJsZWQsIGNoYW5naW5nIHRo
ZSBsZWdhY3kgRFBNUyBwcm9wZXJ0eQo+ICAgIHZhbHVlIGZyb20gb2ZmIHRvIG9uIHJldHVybmVk
IEVJTlZBTC4KPiAKPiB2MjoKPiAqIE1pbm9yIGNoYW5nZXMgdG8gY29kZSBjb21tZW50IGFuZCBj
b21taXQgbG9nLCBwZXIgcmV2aWV3IGZlZWRiYWNrLgo+IAo+IEdpdExhYjogaHR0cHM6Ly9naXRs
YWIuZ25vbWUub3JnL0dOT01FL211dHRlci8tL2lzc3Vlcy8xMTA4Cj4gR2l0TGFiOiBodHRwczov
L2dpdGxhYi5nbm9tZS5vcmcvR05PTUUvbXV0dGVyLy0vaXNzdWVzLzExNjUKPiBHaXRMYWI6IGh0
dHBzOi8vZ2l0bGFiLmdub21lLm9yZy9HTk9NRS9tdXR0ZXIvLS9pc3N1ZXMvMTM0NAo+IFN1Z2dl
c3RlZC1ieTogRGFuaWVsIFZldHRlciA8ZGFuaWVsLnZldHRlckBmZndsbC5jaD4KPiBBY2tlZC1i
eTogRGFuaWVsIFZldHRlciA8ZGFuaWVsLnZldHRlckBmZndsbC5jaD4KPiBSZXZpZXdlZC1ieTog
TmljaG9sYXMgS2F6bGF1c2thcyA8bmljaG9sYXMua2F6bGF1c2thc0BhbWQuY29tPgo+IFNpZ25l
ZC1vZmYtYnk6IE1pY2hlbCBEw6RuemVyIDxtZGFlbnplckByZWRoYXQuY29tPgo+IFNpZ25lZC1v
ZmYtYnk6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KPiBTaWduZWQt
b2ZmLWJ5OiBTYXNoYSBMZXZpbiA8c2FzaGFsQGtlcm5lbC5vcmc+CgpJJ20gYSBiaXQgbmVydm91
cyBhYm91dCB0aGlzIGdldHRpbmcgYmFja3BvcnRlZCBzbyBmYXIgYmFjayBzbyBxdWlja2x5LiAK
SSdkIHByZWZlciB3YWl0aW5nIGZvciA1LjkgZmluYWwgZmlyc3QgYXQgbGVhc3QuCgoKLS0gCkVh
cnRobGluZyBNaWNoZWwgRMOkbnplciAgICAgICAgICAgICAgIHwgICAgICAgICAgICAgICBodHRw
czovL3JlZGhhdC5jb20KTGlicmUgc29mdHdhcmUgZW50aHVzaWFzdCAgICAgICAgICAgICB8ICAg
ICAgICAgICAgIE1lc2EgYW5kIFggZGV2ZWxvcGVyCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlz
dGluZm8vYW1kLWdmeAo=
