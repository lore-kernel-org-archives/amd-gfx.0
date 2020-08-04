Return-Path: <SRS0=+8vs=BO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39656C433E1
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Aug 2020 08:38:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D828E2076C
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Aug 2020 08:37:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D828E2076C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daenzer.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E3F46E178;
	Tue,  4 Aug 2020 08:37:59 +0000 (UTC)
Received: from netline-mail3.netline.ch (mail.netline.ch [148.251.143.178])
 by gabe.freedesktop.org (Postfix) with ESMTP id 31B016E178
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Aug 2020 08:37:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by netline-mail3.netline.ch (Postfix) with ESMTP id 4AF712A6042;
 Tue,  4 Aug 2020 10:37:57 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at netline-mail3.netline.ch
Received: from netline-mail3.netline.ch ([127.0.0.1])
 by localhost (netline-mail3.netline.ch [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id YNrYJ1BFhChH; Tue,  4 Aug 2020 10:37:57 +0200 (CEST)
Received: from thor (212.174.63.188.dynamic.wline.res.cust.swisscom.ch
 [188.63.174.212])
 by netline-mail3.netline.ch (Postfix) with ESMTPSA id F37202A6016;
 Tue,  4 Aug 2020 10:37:56 +0200 (CEST)
Received: from [::1] by thor with esmtp (Exim 4.94)
 (envelope-from <michel@daenzer.net>)
 id 1k2sSK-0008AG-3M; Tue, 04 Aug 2020 10:37:56 +0200
Subject: Re: Enabling AMDGPU by default for SI & CIK
To: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
References: <CAP+8YyHwMPPTiPAEs0CV+K+NSWtQmKQ-1hL0CmoGvUjA=P_1+Q@mail.gmail.com>
From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>
Message-ID: <6964a9dc-00dc-6e72-f3ad-b4c80c49ec68@daenzer.net>
Date: Tue, 4 Aug 2020 10:37:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CAP+8YyHwMPPTiPAEs0CV+K+NSWtQmKQ-1hL0CmoGvUjA=P_1+Q@mail.gmail.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, "Koenig,
 Christian" <christian.koenig@amd.com>,
 amd-gfx mailing list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gMjAyMC0wOC0wMyAxOjQ1IGEubS4sIEJhcyBOaWV1d2VuaHVpemVuIHdyb3RlOgo+IEhpIGFs
bCwKPiAKPiBOb3cgdGhhdCB3ZSBoYXZlIHJlY2VudGx5IG1hZGUgc29tZSBwcm9ncmVzcyBvbiBn
ZXR0aW5nIGZlYXR1cmUgcGFyaXR5Cj4gd2l0aCB0aGUgUmFkZW9uIGRyaXZlciBmb3IgU0ksIEkn
bSB3b25kZXJpbmcgd2hhdCBpdCB3b3VsZCB0YWtlIHRvCj4gbWFrZSBBTURHUFUgdGhlIGRlZmF1
bHQgZHJpdmVyIGZvciB0aGVzZSBnZW5lcmF0aW9ucy4KPiAKPiBBcyBmYXIgYXMgSSB1bmRlcnN0
YW5kIEFNREdQVSBoYXMgaGFkIHRoZXNlIGZlYXR1cmVzIGZvciBDSUsgZm9yIGEKPiB3aGlsZSBh
bHJlYWR5IGJ1dCBpdCBpcyBzdGlsbCBub3QgdGhlIGRlZmF1bHQgZHJpdmVyLiBXaGF0IHdvdWxk
IGl0Cj4gdGFrZSB0byBtYWtlIGl0IHRoZSBkZWZhdWx0PyBXaGF0IGlzIG1pc3NpbmcgYW5kL29y
IGJyb2tlbj8KClRoZSBtYWluIGJsb2NrZXJzIEknbSBhd2FyZSBvZiBmb3IgQ0lLIGFyZToKCjEp
IExhY2sgb2YgYW5hbG9ndWUgY29ubmVjdG9yIHN1cHBvcnQgd2l0aCBEQwoyKSBMYWNrIG9mIEhE
TUkvRFAgYXVkaW8gc3VwcG9ydCB3aXRob3V0IERDCgoKMSkgbWF5IGFwcGx5IHRvIFNJIGFzIHdl
bGwuCgoKLS0gCkVhcnRobGluZyBNaWNoZWwgRMOkbnplciAgICAgICAgICAgICAgIHwgICAgICAg
ICAgICAgICBodHRwczovL3JlZGhhdC5jb20KTGlicmUgc29mdHdhcmUgZW50aHVzaWFzdCAgICAg
ICAgICAgICB8ICAgICAgICAgICAgIE1lc2EgYW5kIFggZGV2ZWxvcGVyCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFt
ZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
L21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
