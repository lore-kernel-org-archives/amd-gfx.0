Return-Path: <SRS0=dANk=CK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 602F1C433E2
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Sep 2020 08:56:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F797206EB
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Sep 2020 08:56:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F797206EB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daenzer.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 998636E484;
	Tue,  1 Sep 2020 08:56:46 +0000 (UTC)
Received: from netline-mail3.netline.ch (mail.netline.ch [148.251.143.178])
 by gabe.freedesktop.org (Postfix) with ESMTP id 63B786E41B;
 Tue,  1 Sep 2020 08:56:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by netline-mail3.netline.ch (Postfix) with ESMTP id 263EB2A6042;
 Tue,  1 Sep 2020 10:56:44 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at netline-mail3.netline.ch
Received: from netline-mail3.netline.ch ([127.0.0.1])
 by localhost (netline-mail3.netline.ch [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id npbGqGs0Zm_X; Tue,  1 Sep 2020 10:56:43 +0200 (CEST)
Received: from thor (212.174.63.188.dynamic.wline.res.cust.swisscom.ch
 [188.63.174.212])
 by netline-mail3.netline.ch (Postfix) with ESMTPSA id 5A8C22A6016;
 Tue,  1 Sep 2020 10:56:43 +0200 (CEST)
Received: from [::1] by thor with esmtp (Exim 4.94)
 (envelope-from <michel@daenzer.net>)
 id 1kD25t-000euF-12; Tue, 01 Sep 2020 10:56:42 +0200
Subject: Re: [PATCH] drm/amdgpu/dc: Require primary plane to be enabled
 whenever the CRTC is
To: Daniel Vetter <daniel@ffwll.ch>
References: <20200821165758.1106210-1-michel@daenzer.net>
 <58dc5ed0-307e-74c9-1a8b-1e998be04900@amd.com>
 <91391bb3-a855-1a29-2d2e-a31856c99946@daenzer.net>
 <20200824104327.559503f7@eldfell>
 <b8bc3e37-d9b3-2aeb-8580-f265f1b8c830@daenzer.net>
 <20200901075719.GX2352366@phenom.ffwll.local>
From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>
Message-ID: <52d558d2-3277-716f-6386-b8b90e6f41d3@daenzer.net>
Date: Tue, 1 Sep 2020 10:56:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200901075719.GX2352366@phenom.ffwll.local>
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
Cc: Leo Li <sunpeng.li@amd.com>, Pekka Paalanen <ppaalanen@gmail.com>,
 dri-devel@lists.freedesktop.org, "Kazlauskas,
 Nicholas" <nicholas.kazlauskas@amd.com>, amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gMjAyMC0wOS0wMSA5OjU3IGEubS4sIERhbmllbCBWZXR0ZXIgd3JvdGU6Cj4gT24gVHVlLCBB
dWcgMjUsIDIwMjAgYXQgMDQ6NTU6MjhQTSArMDIwMCwgTWljaGVsIETDpG56ZXIgd3JvdGU6Cj4+
IE9uIDIwMjAtMDgtMjQgOTo0MyBhLm0uLCBQZWtrYSBQYWFsYW5lbiB3cm90ZToKPj4gCj4+PiBT
b3VuZHMgbGlrZSB0aGUgaGVscGVycyB5b3UgcmVmZXIgdG8gYXJlIGluYWRlcXVhdGUgZm9yIHlv
dXIgY2FzZS4KPj4+IENhbid0IHlvdSBmaXggdGhlIGhlbHBlcnMgaW4gdGhlIGxvbmcgcnVuIGFu
ZCBsYW5kIHRoaXMgcGF0Y2ggYXMgYW4KPj4+IGltbWVkaWF0ZSBmaXg/Cj4+IAo+PiBJJ2QgcmF0
aGVyIGxlYXZlIHdvcmtpbmcgb24gdGhvc2UgaGVscGVycyB0byBLTVMgZGV2ZWxvcGVycy4gOikK
PiAKPiBJIHRob3VnaHQgdGhlIGlzc3VlIGlzIHRoZSBybWZiIGlvY3RsIHRyaWNrZXJ5LCB3aGlj
aCBoYXMgdGhpcyBhc3N1bXB0aW9uCj4gZnVsbHkgYmFja2VkIGluLiBUaGUgd2lnZ2xlIHJvb20g
aW4gdGhlcmUgZm9yIHNlbWFudGljIGNoYW5nZXMgaXMgaWlyYwo+IHByZXR0eSBtdWNoIG5pbCwg
aXQgdG9vayB1cyBhIHBpbGUgb2YgcGF0Y2hlcyB0byBqdXN0IGdldCB0byB0aGUgY3VycmVudAo+
IHN0YXRlLiBTbyBpdCdzIG5vdCBoZWxwZXIgY29kZSwgaXQncyBjb3JlIGxlZ2FjeSBpb2N0bCBj
b2RlIGZvciBhdG9taWMKPiBkcml2ZXJzLgoKTXkgYmFkLiBTaG91bGQgSSByZXNwaW4gd2l0aCBh
biBhbWVuZGVkIGNvbW1pdCBsb2c/CgoKLS0gCkVhcnRobGluZyBNaWNoZWwgRMOkbnplciAgICAg
ICAgICAgICAgIHwgICAgICAgICAgICAgICBodHRwczovL3JlZGhhdC5jb20KTGlicmUgc29mdHdh
cmUgZW50aHVzaWFzdCAgICAgICAgICAgICB8ICAgICAgICAgICAgIE1lc2EgYW5kIFggZGV2ZWxv
cGVyCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1n
ZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
