Return-Path: <SRS0=ysjs=55=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5005C2BA19
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Apr 2020 17:47:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97A872063A
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Apr 2020 17:47:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97A872063A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4482A6E0E1;
	Mon, 13 Apr 2020 17:47:50 +0000 (UTC)
X-Greylist: delayed 401 seconds by postgrey-1.36 at gabe;
 Mon, 13 Apr 2020 17:38:46 UTC
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A6E7E89F43;
 Mon, 13 Apr 2020 17:38:46 +0000 (UTC)
Received: from [192.168.1.6] (x4d0d8c93.dyn.telefonica.de [77.13.140.147])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id D4604206442E6;
 Mon, 13 Apr 2020 19:32:03 +0200 (CEST)
Subject: Re: [regression 5.7-rc1] System does not power off, just halts
From: Paul Menzel <pmenzel@molgen.mpg.de>
To: Prike Liang <Prike.Liang@amd.com>, Alex Deucher <alexander.deucher@amd.com>
References: <f4eaf0ca-6cd6-c224-9205-bf64ca533ff5@molgen.mpg.de>
Message-ID: <dcc4851e-0ab5-683a-2cf2-687d64a3c9da@molgen.mpg.de>
Date: Mon, 13 Apr 2020 19:32:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <f4eaf0ca-6cd6-c224-9205-bf64ca533ff5@molgen.mpg.de>
Content-Language: en-US
X-Mailman-Approved-At: Mon, 13 Apr 2020 17:47:49 +0000
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
Cc: regressions@leemhuis.info, David Airlie <airlied@linux.ie>,
 dri-devel@lists.freedesktop.org, x86@kernel.org,
 LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org,
 Huang Rui <ray.huang@amd.com>, amd-gfx@lists.freedesktop.org,
 Daniel Vetter <daniel@ffwll.ch>, Mengbing Wang <Mengbing.Wang@amd.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

RGVhciBQcmlrZSwgZGVhciBBbGV4LCBkZWFyIExpbnV4IGZvbGtzLAoKCkFtIDEzLjA0LjIwIHVt
IDEwOjQ0IHNjaHJpZWIgUGF1bCBNZW56ZWw6Cgo+IEEgcmVncmVzc2lvbiBiZXR3ZWVuIGNhdXNl
cyBhIHN5c3RlbSB3aXRoIHRoZSBBTUQgYm9hcmQgTVNJIEIzNTBNIE1PUlRBUiAKPiAoTVMtN0Ez
Nykgd2l0aCBhbiBBTUQgUnl6ZW4gMyAyMjAwRyBub3QgdG8gcG93ZXIgb2ZmIGFueSBtb3JlIGJ1
dCBqdXN0IAo+IHRvIGhhbHQuCj4gCj4gVGhlIHJlZ3Jlc3Npb24gaXMgaW50cm9kdWNlZCBpbiA5
ZWJlNTQyMmFkNmMuLmIwMzIyMjdjNjI5My4gSSBhbSBpbiB0aGUgCj4gcHJvY2VzcyB0byBiaXNl
Y3QgdGhpcywgYnV0IG1heWJlIHNvbWVib2R5IGFscmVhZHkgaGFzIGFuIGlkZWEuCgpJIGZvdW5k
IHRoZSBFYXN0ZXIgZWdnOgoKPiBjb21taXQgNDg3ZWNhMTFhMzIxZWYzM2JjZjRjYTVhZGIzYzBj
NDk1NGRiMWI1OAo+IEF1dGhvcjogUHJpa2UgTGlhbmcgPFByaWtlLkxpYW5nQGFtZC5jb20+Cj4g
RGF0ZTogICBUdWUgQXByIDcgMjA6MjE6MjYgMjAyMCArMDgwMAo+IAo+ICAgICBkcm0vYW1kZ3B1
OiBmaXggZ2Z4IGhhbmcgZHVyaW5nIHN1c3BlbmQgd2l0aCB2aWRlbyBwbGF5YmFjayAodjIpCj4g
ICAgIAo+ICAgICBUaGUgc3lzdGVtIHdpbGwgYmUgaGFuZyB1cCBkdXJpbmcgUzMgc3VzcGVuZCBi
ZWNhdXNlIG9mIFNNVSBpcyBwZW5kaW5nCj4gICAgIGZvciBHQyBub3QgcmVzcG9zZSB0aGUgcmVn
aXN0ZXIgQ1BfSFFEX0FDVElWRSBhY2Nlc3MgcmVxdWVzdC5UaGlzIGlzc3VlCj4gICAgIHJvb3Qg
Y2F1c2Ugb2YgYWNjZXNzaW5nIHRoZSBHQyByZWdpc3RlciB1bmRlciBlbnRlciBHRlggQ0dHUEcg
YW5kIGNhbgo+ICAgICBiZSBmaXhlZCBieSBkaXNhYmxlIEdGWCBDR1BHIGJlZm9yZSBwZXJmb3Jt
IHN1c3BlbmQuCj4gICAgIAo+ICAgICB2MjogVXNlIGRpc2FibGUgdGhlIEdGWCBDR1BHIGluc3Rl
YWQgb2YgUkxDIHNhZmUgbW9kZSBndWFyZC4KPiAgICAgCj4gICAgIFNpZ25lZC1vZmYtYnk6IFBy
aWtlIExpYW5nIDxQcmlrZS5MaWFuZ0BhbWQuY29tPgo+ICAgICBUZXN0ZWQtYnk6IE1lbmdiaW5n
IFdhbmcgPE1lbmdiaW5nLldhbmdAYW1kLmNvbT4KPiAgICAgUmV2aWV3ZWQtYnk6IEh1YW5nIFJ1
aSA8cmF5Lmh1YW5nQGFtZC5jb20+Cj4gICAgIFNpZ25lZC1vZmYtYnk6IEFsZXggRGV1Y2hlciA8
YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KPiAgICAgQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5v
cmcKCkl0IHJldmVydHMgY2xlYW5seSBvbiB0b3Agb2YgNS43LXJjMSwgYW5kIHRoaXMgZml4ZXMg
dGhlIGlzc3VlLgoKR3JlZywgcGxlYXNlIGRvIG5vdCBhcHBseSB0aGlzIHRvIHRoZSBzdGFibGUg
c2VyaWVzLiBUaGUgY29tbWl0IG1lc3NhZ2UgCmRvZXNu4oCZdCBldmVuIHJlZmVyZW5jZSBhIGlz
c3VlL2J1ZyByZXBvcnQsIGFuZCBkb2VzbuKAmXQgZ2l2ZSBhIGRldGFpbGVkIApwcm9ibGVtIGRl
c2NyaXB0aW9uLiBXaGF0IHN5c3RlbSBpcyBpdD8KCkRhdmUsIEFsZXgsIGhvdyB0byBwcm9jZWVk
PyBSZXZlcnQ/IEkgY3JlYXRlZCBpc3N1ZSAxMDk0IFsxXS4KCgpLaW5kIHJlZ2FyZHMsCgpQYXVs
CgoKWzFdOiBodHRwczovL2dpdGxhYi5mcmVlZGVza3RvcC5vcmcvZHJtL2FtZC8tL2lzc3Vlcy8x
MDk0Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1n
ZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
