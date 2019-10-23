Return-Path: <SRS0=+G2B=YQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B818CA9EB6
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Oct 2019 15:23:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB6F52173B
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Oct 2019 15:23:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB6F52173B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daenzer.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D2F26EB07;
	Wed, 23 Oct 2019 15:23:35 +0000 (UTC)
Received: from netline-mail3.netline.ch (mail.netline.ch [148.251.143.178])
 by gabe.freedesktop.org (Postfix) with ESMTP id 39B8D6EB07
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Oct 2019 15:23:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by netline-mail3.netline.ch (Postfix) with ESMTP id 4768A2A6046;
 Wed, 23 Oct 2019 17:23:33 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at netline-mail3.netline.ch
Received: from netline-mail3.netline.ch ([127.0.0.1])
 by localhost (netline-mail3.netline.ch [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id OqNDKGsWEwjQ; Wed, 23 Oct 2019 17:23:32 +0200 (CEST)
Received: from thor (116.245.63.188.dynamic.wline.res.cust.swisscom.ch
 [188.63.245.116])
 by netline-mail3.netline.ch (Postfix) with ESMTPSA id D78D02A6045;
 Wed, 23 Oct 2019 17:23:32 +0200 (CEST)
Received: from localhost ([::1]) by thor with esmtp (Exim 4.92.2)
 (envelope-from <michel@daenzer.net>)
 id 1iNIU0-0000uH-9V; Wed, 23 Oct 2019 17:23:32 +0200
Subject: Re: [PATCH 18/37] drm/amd/display: Allow inverted gamma
To: sunpeng.li@amd.com
References: <20191017191329.11857-1-sunpeng.li@amd.com>
 <20191017191329.11857-19-sunpeng.li@amd.com>
From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>
Message-ID: <82b4b639-d1c7-c26c-cb84-4c41bb16cb41@daenzer.net>
Date: Wed, 23 Oct 2019 17:23:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191017191329.11857-19-sunpeng.li@amd.com>
Content-Language: en-CA
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Cc: Krunoslav Kovac <Krunoslav.Kovac@amd.com>, Reza Amini <Reza.Amini@amd.com>,
 Aidan Yang <Aidan.Yang@amd.com>, amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191023152332.l1vr0wmGqP3ssu3oYkEUWLYr_lBAehp3pn7MJwF9n2c@z>

T24gMjAxOS0xMC0xNyA5OjEzIHAubS4sIHN1bnBlbmcubGlAYW1kLmNvbSB3cm90ZToKPiBGcm9t
OiBBaWRhbiBZYW5nIDxBaWRhbi5ZYW5nQGFtZC5jb20+Cj4gCj4gW3doeV0KPiBUaGVyZSdzIGEg
dXNlIGNhc2UgZm9yIGludmVydGVkIGdhbW1hCj4gYW5kIGl0J3MgYmVlbiBjb25maXJtZWQgdGhh
dCBuZWdhdGl2ZSBzbG9wZXMgYXJlIG9rLgo+IAo+IFtob3ddCj4gUmVtb3ZlIGNvZGUgZm9yIGJs
b2NraW5nIG5vbi1tb25vdG9uaWNhbGx5IGluY3JlYXNpbmcgZ2FtbWEKPiAKPiBTaWduZWQtb2Zm
LWJ5OiBBaWRhbiBZYW5nIDxBaWRhbi5ZYW5nQGFtZC5jb20+Cj4gUmV2aWV3ZWQtYnk6IEtydW5v
c2xhdiBLb3ZhYyA8S3J1bm9zbGF2LktvdmFjQGFtZC5jb20+Cj4gQWNrZWQtYnk6IExlbyBMaSA8
c3VucGVuZy5saUBhbWQuY29tPgo+IEFja2VkLWJ5OiBSZXphIEFtaW5pIDxSZXphLkFtaW5pQGFt
ZC5jb20+CgpEb2VzIHRoaXMgZml4IGh0dHBzOi8vYnVncy5mcmVlZGVza3RvcC5vcmcvMTEwNjc3
ID8gSWYgc28sIGl0IHNob3VsZCBiZQpyZWZlcmVuY2VkIGluIHRoZSBjb21taXQgbG9nLCBhbmQg
dGhlIHJlcG9ydCByZXNvbHZlZCBvbmNlIHRoaXMgbGFuZHMgaW4KZHJtLW5leHQgb3IgTGludXMn
IHRyZWUuCgoKLS0gCkVhcnRobGluZyBNaWNoZWwgRMOkbnplciAgICAgICAgICAgICAgIHwgICAg
ICAgICAgICAgICBodHRwczovL3JlZGhhdC5jb20KTGlicmUgc29mdHdhcmUgZW50aHVzaWFzdCAg
ICAgICAgICAgICB8ICAgICAgICAgICAgIE1lc2EgYW5kIFggZGV2ZWxvcGVyCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0
CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Au
b3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
