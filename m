Return-Path: <SRS0=Ro4j=7H=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8734DC433DF
	for <amd-gfx@archiver.kernel.org>; Mon, 25 May 2020 09:13:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E58A2073B
	for <amd-gfx@archiver.kernel.org>; Mon, 25 May 2020 09:13:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E58A2073B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daenzer.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C3EBC89BF3;
	Mon, 25 May 2020 09:13:31 +0000 (UTC)
Received: from netline-mail3.netline.ch (mail.netline.ch [148.251.143.178])
 by gabe.freedesktop.org (Postfix) with ESMTP id 565D389BF3
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 May 2020 09:13:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by netline-mail3.netline.ch (Postfix) with ESMTP id 603C72A6042;
 Mon, 25 May 2020 11:13:29 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at netline-mail3.netline.ch
Received: from netline-mail3.netline.ch ([127.0.0.1])
 by localhost (netline-mail3.netline.ch [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id ITOLNTx3-air; Mon, 25 May 2020 11:13:29 +0200 (CEST)
Received: from thor (252.80.76.83.dynamic.wline.res.cust.swisscom.ch
 [83.76.80.252])
 by netline-mail3.netline.ch (Postfix) with ESMTPSA id B21BB2A6016;
 Mon, 25 May 2020 11:13:28 +0200 (CEST)
Received: from localhost ([::1]) by thor with esmtp (Exim 4.93)
 (envelope-from <michel@daenzer.net>)
 id 1jd9Ak-000Osa-SJ; Mon, 25 May 2020 11:13:26 +0200
Subject: Re: [PATCH] drm/amd/display: Make BREAK_TO_DEBUGGER() a debug print
To: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
References: <20200522180326.5325-1-nicholas.kazlauskas@amd.com>
From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>
Message-ID: <c5ac1dd7-27c1-ea41-9e92-0fb4dc7caeb2@daenzer.net>
Date: Mon, 25 May 2020 11:13:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200522180326.5325-1-nicholas.kazlauskas@amd.com>
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
Cc: Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>, amd-gfx@lists.freedesktop.org,
 Harry Wentland <harry.wentland@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gMjAyMC0wNS0yMiA4OjAzIHAubS4sIE5pY2hvbGFzIEthemxhdXNrYXMgd3JvdGU6Cj4gW1do
eV0KPiBXYXJuaW5ncyBpbiB0aGUga2VybmVsIGFyZSBnZW5lcmFsbHkgdHJlYXRlZCBhcyBlcnJv
cnMuCj4gCj4gVGhlIEJSRUFLX1RPX0RFQlVHR0VSIG1hY3JvIGlzIG5vdCBhIGNyaXRpY2FsIGVy
cm9yIG9yIHdhcm5pbmcsIGJ1dAo+IHJhdGhlciBpbnRlbmRlZCBmb3IgZGV2ZWxvcGVyIHVzZSB0
byBoZWxwIGludmVzdGlnYXRlIGJlaGF2aW9yIGFuZAo+IHNlcXVlbmNlcyBmb3Igb3RoZXIgaXNz
dWVzLgo+IAo+IFdlIGRvIHN0aWxsIG1ha2UgdXNlIG9mIERDX0VSUk9SL0FTU0VSVCgwKSBpbiB2
YXJpb3VzIHBsYWNlcyBpbiB0aGUKPiBjb2RlIGZvciB0aGluZ3MgdGhhdCBhcmUgZ2VudWluZSBp
c3N1ZXMuCj4gCj4gU2luY2UgbW9zdCBkZXZlbG9wZXJzIGRvbid0IGFjdHVhbGx5IEtHREIgd2hp
bGUgZGVidWdnaW5nIHRoZSBrZXJuZWwKPiB0aGVzZSBlc3NlbnRpYWxseSB3b3VsZCBoYXZlIG5v
IHZhbHVlIG9uIHRoZWlyIG93biBzaW5jZSB0aGUgS0dEQgo+IGJyZWFrcG9pbnQgd291bGRuJ3Qg
dHJpZ2dlciAtIEFTU0VSVCgwKSB3YXMgdXNlZCBhcyBhIHNob3J0Y3V0IHRvIGdldAo+IGEgc3Rh
Y2t0cmFjZS4KPiAKPiBbSG93XQo+IFR1cm4gaXQgaW50byBhIERSTV9ERUJVR19EUklWRVIgcHJp
bnQgaW5zdGVhZC4gV2UgdW5mb3J0dW5hdGVseSBsb3NlCj4gdGhlIHN0YWNrdHJhY2UsIGJ1dCB3
ZSBzdGlsbCBkbyByZXRhaW4gc29tZSBvZiB0aGUgdXNlZnVsIGRlYnVnCj4gaW5mb3JtYXRpb24g
dGhpcyBvZmZlcnMgYnkgaGF2aW5nIGF0IGxlYXN0IHRoZSBmdW5jdGlvbiBhbmQgbGluZQo+IG51
bWJlciBsb2dnYWJsZS4KPiAKPiBJZiBLR0RCIGlzIHN1cHBvcnRlZCBpbiB0aGUga2VybmVsIHRo
aXMgd2lsbCBzdGlsbCB0cmlnZ2VyIGEgcmVhbAo+IGJyZWFrcG9pbnQgYXMgd2VsbC4KCk5vdCBz
dXJlIHRoaXMgbWFrZXMgc2Vuc2Ugbm93IHRoYXQgV0FSTl9PTl9PTkNFIGlzIHVzZWQgZm9yIEFT
U0VSVCgpLgpUaGUgbmFtZSAiQlJFQUtfVE9fREVCVUdHRVIiIGltcGxpZXMgdGhhdCBzb21ldGhp
bmcgdW5leHBlY3RlZCBoYXBwZW5lZAp3aGljaCBuZWVkcyB0byBiZSBpbnZlc3RpZ2F0ZWQsIHNv
IGhhdmluZyBhIGJhY2t0cmFjZSBzZWVtcyBpbXBvcnRhbnQgdG8gbWUuCgoKLS0gCkVhcnRobGlu
ZyBNaWNoZWwgRMOkbnplciAgICAgICAgICAgICAgIHwgICAgICAgICAgICAgICBodHRwczovL3Jl
ZGhhdC5jb20KTGlicmUgc29mdHdhcmUgZW50aHVzaWFzdCAgICAgICAgICAgICB8ICAgICAgICAg
ICAgIE1lc2EgYW5kIFggZGV2ZWxvcGVyCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRl
c2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8v
YW1kLWdmeAo=
