Return-Path: <SRS0=ehRF=6E=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32EF7C3815B
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Apr 2020 16:15:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1524206F6
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Apr 2020 16:15:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1524206F6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daenzer.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 761256E7D5;
	Mon, 20 Apr 2020 16:15:52 +0000 (UTC)
Received: from netline-mail3.netline.ch (mail.netline.ch [148.251.143.178])
 by gabe.freedesktop.org (Postfix) with ESMTP id 3565E6E7D5
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Apr 2020 16:15:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by netline-mail3.netline.ch (Postfix) with ESMTP id 7410F2A6046;
 Mon, 20 Apr 2020 18:15:50 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at netline-mail3.netline.ch
Received: from netline-mail3.netline.ch ([127.0.0.1])
 by localhost (netline-mail3.netline.ch [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id WYa4GgqFGmIP; Mon, 20 Apr 2020 18:15:50 +0200 (CEST)
Received: from thor (252.80.76.83.dynamic.wline.res.cust.swisscom.ch
 [83.76.80.252])
 by netline-mail3.netline.ch (Postfix) with ESMTPSA id 312BE2A6016;
 Mon, 20 Apr 2020 18:15:50 +0200 (CEST)
Received: from localhost ([::1]) by thor with esmtp (Exim 4.93)
 (envelope-from <michel@daenzer.net>)
 id 1jQZ5J-001piv-Gq; Mon, 20 Apr 2020 18:15:49 +0200
Subject: Re: Reg. Adaptive Sync feature in xf86-video-amdgpu
To: uday kiran pichika <udaykiran.pichika@gmail.com>
References: <CAGcx_0Z4Lz4x5xxahtQJwaysGcQz9frLctYMg3z1Num3y+LUyw@mail.gmail.com>
 <ab5fd92f-c0e3-8647-80e7-00d4ad397582@daenzer.net>
 <CAGcx_0ZoYz9jJQCWceTkN_X0dGdc+fTEaZytEx152SNLavAPRQ@mail.gmail.com>
From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>
Message-ID: <71874997-8503-27eb-b16e-bad70472041c@daenzer.net>
Date: Mon, 20 Apr 2020 18:15:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAGcx_0ZoYz9jJQCWceTkN_X0dGdc+fTEaZytEx152SNLavAPRQ@mail.gmail.com>
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
Cc: amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gMjAyMC0wNC0yMCA2OjA0IHAubS4sIHVkYXkga2lyYW4gcGljaGlrYSB3cm90ZToKPiAKPiBF
dmVuIGluIGFtZGdwdV9wcmVzZW50X2ZsaXAoKSwgdGhlcmUgaXMgYSBjaGVjawo+IGZvciBhbWRn
cHVfd2luZG93X2hhc192YXJpYWJsZV9yZWZyZXNoKCkgd2hpY2ggYWN0dWFsbHkgY2hlY2tzIHdo
ZXRoZXIKPiB3aW5kb3cgaGFzIGEgdmFyaWFibGVfcmVmcmVzaCBwcm9wZXJ0eSBzZXQgZnJvbSB0
aGUgTUVTQSBvciBub3QgPyB0aGlzCj4gY2hlY2sgaXMgZmFpbGluZyBpbiBteSBjYXNlIGFuZCBu
ZXZlciBjYWxscyBhbWRncHVfcHJlc2VudF9zZXRfc2NyZWVuX3Zyci4KClRoaXMgc2hvdWxkIGJl
IHNldCBieQoKCWdldF93aW5kb3dfcHJpdih3aW5kb3cpLT52YXJpYWJsZV9yZWZyZXNoID0gdmFy
aWFibGVfcmVmcmVzaDsKCmluIGFtZGdwdV92cnJfcHJvcGVydHlfdXBkYXRlLgoKCj4gSXMgdGhl
cmUgYW55IHdheSB0aGF0IGkgY2FuIGNoZWNrIHdoZXRoZXIgTUVTQSBpcyBzZXR0aW5nIHRoaXMg
cHJvcGVydHkgPwo+IAo+IFRvIG15IHVuZGVyc3RhbmRpbmcsIE1FU0Egd2lsbCBzZXQgdGhpcyBw
cm9wZXJ0eSB0byB0cnVlIG9yIGZhbHNlIGJhc2VkIG9uCj4gd2hldGhlciBhcHBsaWNhdGlvbiBp
cyBydW5uaW5nIGluIEZ1bGwgc2NyZWVuIG1vZGUgb3IgaW4gbm9ybWFsIG1vZGUuCgpNZXNhIGFs
d2F5cyBzZXRzIHRoZSB3aW5kb3cgcHJvcGVydHkgYnkgZGVmYXVsdCwgdW5sZXNzIHRoZSBkcmlj
b25mCm9wdGlvbiAiYWRhcHRpdmVfc3luYyIgaXMgZGlzYWJsZWQsIGUuZy4gdmlhIHRoZSBhcHBs
aWNhdGlvbiBibGFja2xpc3QKaW4gL3Vzci9zaGFyZS9kcmlyYy5kLzAwLW1lc2EtZGVmYXVsdHMu
Y29uZiAobW9zdGx5IGZvciBjb21wb3NpdG9ycyAvCmJyb3dzZXJzIC8gdmlkZW8gcGxheWVycyku
CgoKLS0gCkVhcnRobGluZyBNaWNoZWwgRMOkbnplciAgICAgICAgICAgICAgIHwgICAgICAgICAg
ICAgICBodHRwczovL3JlZGhhdC5jb20KTGlicmUgc29mdHdhcmUgZW50aHVzaWFzdCAgICAgICAg
ICAgICB8ICAgICAgICAgICAgIE1lc2EgYW5kIFggZGV2ZWxvcGVyCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1n
ZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21h
aWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
