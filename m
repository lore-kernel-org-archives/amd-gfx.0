Return-Path: <SRS0=ehRF=6E=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C9DDC3815B
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Apr 2020 16:48:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 666D0205C9
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Apr 2020 16:48:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 666D0205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daenzer.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B49F6E819;
	Mon, 20 Apr 2020 16:48:49 +0000 (UTC)
Received: from netline-mail3.netline.ch (mail.netline.ch [148.251.143.178])
 by gabe.freedesktop.org (Postfix) with ESMTP id E511D6E819
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Apr 2020 16:48:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by netline-mail3.netline.ch (Postfix) with ESMTP id 55D0F2A6042;
 Mon, 20 Apr 2020 18:48:47 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at netline-mail3.netline.ch
Received: from netline-mail3.netline.ch ([127.0.0.1])
 by localhost (netline-mail3.netline.ch [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id 6HjR3y_3WVhV; Mon, 20 Apr 2020 18:48:47 +0200 (CEST)
Received: from thor (252.80.76.83.dynamic.wline.res.cust.swisscom.ch
 [83.76.80.252])
 by netline-mail3.netline.ch (Postfix) with ESMTPSA id 0BB022A6016;
 Mon, 20 Apr 2020 18:48:47 +0200 (CEST)
Received: from localhost ([::1]) by thor with esmtp (Exim 4.93)
 (envelope-from <michel@daenzer.net>)
 id 1jQZbC-001ptP-II; Mon, 20 Apr 2020 18:48:46 +0200
Subject: Re: Reg. Adaptive Sync feature in xf86-video-amdgpu
To: uday kiran pichika <udaykiran.pichika@gmail.com>
References: <CAGcx_0Z4Lz4x5xxahtQJwaysGcQz9frLctYMg3z1Num3y+LUyw@mail.gmail.com>
 <ab5fd92f-c0e3-8647-80e7-00d4ad397582@daenzer.net>
 <CAGcx_0ZoYz9jJQCWceTkN_X0dGdc+fTEaZytEx152SNLavAPRQ@mail.gmail.com>
 <71874997-8503-27eb-b16e-bad70472041c@daenzer.net>
 <CAGcx_0aAbMviGJMtZP3jSpLr8OayUDMOwFkUd70j=SY-qmbGyg@mail.gmail.com>
From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>
Message-ID: <1e659586-2ba8-6791-01b6-30c69f211d82@daenzer.net>
Date: Mon, 20 Apr 2020 18:48:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAGcx_0aAbMviGJMtZP3jSpLr8OayUDMOwFkUd70j=SY-qmbGyg@mail.gmail.com>
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

T24gMjAyMC0wNC0yMCA2OjQ1IHAubS4sIHVkYXkga2lyYW4gcGljaGlrYSB3cm90ZToKPiBPbiBN
b24sIEFwciAyMCwgMjAyMCBhdCA5OjQ1IFBNIE1pY2hlbCBEw6RuemVyIDxtaWNoZWxAZGFlbnpl
ci5uZXQ+IHdyb3RlOgo+PiBPbiAyMDIwLTA0LTIwIDY6MDQgcC5tLiwgdWRheSBraXJhbiBwaWNo
aWthIHdyb3RlOgo+Pj4KPj4+IEV2ZW4gaW4gYW1kZ3B1X3ByZXNlbnRfZmxpcCgpLCB0aGVyZSBp
cyBhIGNoZWNrCj4+PiBmb3IgYW1kZ3B1X3dpbmRvd19oYXNfdmFyaWFibGVfcmVmcmVzaCgpIHdo
aWNoIGFjdHVhbGx5IGNoZWNrcyB3aGV0aGVyCj4+PiB3aW5kb3cgaGFzIGEgdmFyaWFibGVfcmVm
cmVzaCBwcm9wZXJ0eSBzZXQgZnJvbSB0aGUgTUVTQSBvciBub3QgPyB0aGlzCj4+PiBjaGVjayBp
cyBmYWlsaW5nIGluIG15IGNhc2UgYW5kIG5ldmVyIGNhbGxzCj4+IGFtZGdwdV9wcmVzZW50X3Nl
dF9zY3JlZW5fdnJyLgo+Pgo+PiBUaGlzIHNob3VsZCBiZSBzZXQgYnkKPj4KPj4gICAgICAgICBn
ZXRfd2luZG93X3ByaXYod2luZG93KS0+dmFyaWFibGVfcmVmcmVzaCA9IHZhcmlhYmxlX3JlZnJl
c2g7Cj4+Cj4+IGluIGFtZGdwdV92cnJfcHJvcGVydHlfdXBkYXRlLgo+Pgo+IAo+IEkgYW1kZ3B1
X3Zycl9wcm9wZXJ0eV91cGRhdGUgbWV0aG9kIGdldHMgY2FsbGVkIGZyb20gYW1kZ3B1X2NoYW5n
ZV9wcm9wZXJ0eQo+IHdoZW4gdGhlIHByb3BlcnR5IGlzIGJlaW5nIGFkZGVkIHRvIHRoZSB3aW5k
b3cuIHRob3VnaCB2YXJpYWJsZV9yZWZyZXNoCj4gcHJvcGVydHkgaXMgdXBkYXRpbmcgZnJvbSB0
aGUgYmVsb3cgY2FsbCwgdGhpcyB3aW5kb3cgaXMgbm90IHNhbWUgYXMgdGhlCj4gb25lKGluZm8t
PmZsaXBfd2luZG93KSBpbiBhbWRncHVfcHJlc2VudF9mbGlwLgo+ICpnZXRfd2luZG93X3ByaXYo
d2luZG93KSotPnZhcmlhYmxlX3JlZnJlc2ggPSB2YXJpYWJsZV9yZWZyZXNoOwoKVGhlbiBpdCdz
IHByb2JhYmx5IG5vdCB0aGUgYXBwbGljYXRpb24ncyB3aW5kb3cgd2hpY2ggaXMgcGFnZSBmbGlw
cGluZywKYnV0IGUuZy4gdGhlIGNvbXBvc2l0b3Incy4gTWFrZSBzdXJlIHlvdXIgY29tcG9zaXRv
ciBzdXBwb3J0cwp1bnJlZGlyZWN0aW5nIGZ1bGxzY3JlZW4gd2luZG93cy4KCgo+IENvdWxkIHlv
dSBwbGVhc2UgbGV0IG1lIGtub3cgeW91IElSQyBJRCB0byBoYXZlIGEgY2hhdCBpbiB0aGF0IGZv
ciBtb3JlCj4gaW5mb3JtYXRpb24uCgpJJ20gTXJDb29wZXIgb24gSVJDLgoKCi0tIApFYXJ0aGxp
bmcgTWljaGVsIETDpG56ZXIgICAgICAgICAgICAgICB8ICAgICAgICAgICAgICAgaHR0cHM6Ly9y
ZWRoYXQuY29tCkxpYnJlIHNvZnR3YXJlIGVudGh1c2lhc3QgICAgICAgICAgICAgfCAgICAgICAg
ICAgICBNZXNhIGFuZCBYIGRldmVsb3BlcgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVk
ZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2FtZC1nZngK
