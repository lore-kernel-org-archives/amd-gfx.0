Return-Path: <SRS0=L2kD=ME=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15884C07E99
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Jul 2021 08:36:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24AB861003
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Jul 2021 08:36:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24AB861003
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daenzer.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C166689B60;
	Mon, 12 Jul 2021 08:36:47 +0000 (UTC)
Received: from netline-mail3.netline.ch (mail.netline.ch [148.251.143.180])
 by gabe.freedesktop.org (Postfix) with ESMTP id D88D289B60
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Jul 2021 08:36:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by netline-mail3.netline.ch (Postfix) with ESMTP id E4A5D20201D;
 Mon, 12 Jul 2021 10:36:44 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at netline-mail3.netline.ch
Received: from netline-mail3.netline.ch ([127.0.0.1])
 by localhost (netline-mail3.netline.ch [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id oH9pgYYYCVaL; Mon, 12 Jul 2021 10:36:44 +0200 (CEST)
Received: from thor (24.99.2.85.dynamic.wline.res.cust.swisscom.ch
 [85.2.99.24])
 by netline-mail3.netline.ch (Postfix) with ESMTPA id 9C25620201C;
 Mon, 12 Jul 2021 10:36:44 +0200 (CEST)
Received: from localhost ([::1]) by thor with esmtp (Exim 4.94.2)
 (envelope-from <michel@daenzer.net>)
 id 1m2rQh-000a5Q-IV; Mon, 12 Jul 2021 10:36:43 +0200
To: Ketsui <esgwpl@gmail.com>
References: <YOqiQmAUTBWjbVb6@mainframe.localdomain>
From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>
Subject: Re: AMDGPU error: "[drm:amdgpu_dm_atomic_commit_tail [amdgpu]]
 *ERROR* Waiting for fences timed out!"
Message-ID: <e89834cd-a51b-a756-2fec-0dc0a3865d38@daenzer.net>
Date: Mon, 12 Jul 2021 10:36:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YOqiQmAUTBWjbVb6@mainframe.localdomain>
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

T24gMjAyMS0wNy0xMSA5OjQ4IGEubS4sIEtldHN1aSB3cm90ZToKPj4gU28gZmFyLCBzbyBnb29k
OyBubyBoYW5nIGluIGEgd2Vlay4gSSdsbCB0cnkgdGhlIHJlc3Qgb2YgdGhlIG5ldyBmaXJtd2Fy
ZSBhcyB3ZWxsIG5vdywgd2lsbCBmb2xsb3cgdXAgaWYgdGhlcmUncyBhIGhhbmcgYWdhaW4uCj4g
Cj4gSSd2ZSBub3RpY2VkIHRoYXQgdGhlIFZNX0wyX1BST1RFQ1RJT05fRkFVTFRfU1RBVFVTIGVy
cm9yIGRvZXNuJ3QgYWx3YXlzIHJlc3VsdCBpbiBhIGhhbmcsIGxvb2tpbmcgdGhyb3VnaCBteSBq
b3VybmFsIEkgY2FuIHNlZQo+IG1heWJlIGEgZG96ZW4gb2YgdGhlbSBzcHJlYWQgb3V0IGFjcm9z
cyBtdWx0aXBsZSBib290cyBidXQgbXkgc3lzdGVtIG9ubHkgYmVjYW1lIG5vbi1mdW5jdGlvbmFs
IGxpa2UgdHdvIHRpbWVzIHNvIGZhciAoSSBrbm93Cj4gYmVjYXVzZSBJIGhhdmUgdGhlIGRtZXNn
IHdoZW4gdGhlIGhhbmdzIGhhcHBlbmVkIHNhdmVkLCB5b3UgY2FuIGZpbmQgdGhlbSBhdHRhY2hl
ZCB0byB0aGlzIG1haWwpLgo+IAo+IFRvIG1ha2UgbXlzZWxmIGNsZWFyLCBJIGhhdmVuJ3QgYWN0
dWFsbHkgaGFkIGEgaGFuZyB0b28gd2l0aCB0aGUgbmV3IGZpcm13YXJlcyBldmVuIHRob3VnaCB0
aGVzZSBtZXNzYWdlcyBzdGlsbCBhcHBlYXIgb24gbXkgZG1lc2csCj4gc29ycnkgaWYgbXkgZmVl
ZGJhY2sgZ2F2ZSB0aGUgd3JvbmcgaW1wcmVzc2lvbi4KCkknbSBjb3VudGluZyBzb2Z0IHJlY292
ZXJlZCBoYW5ncyBhcyBoYW5ncyBmb3IgdGhlIHB1cnBvc2Ugb2YgdGhpcyBpc3N1ZS4gSS5lLiB3
aGVuIEkgd3JpdGUgIm5vIGhhbmciIEkgbWVhbiBubyBzb2Z0IHJlY292ZXJlZCBvbmVzIGVpdGhl
ci4gSWYgSSBoaXQgYSBzb2Z0IHJlY292ZXJlZCBoYW5nLCBJIGNvbnNpZGVyIHRoYXQgc2V0dXAg
YmFkLgoKCi0tIApFYXJ0aGxpbmcgTWljaGVsIETDpG56ZXIgICAgICAgICAgICAgICB8ICAgICAg
ICAgICAgICAgaHR0cHM6Ly9yZWRoYXQuY29tCkxpYnJlIHNvZnR3YXJlIGVudGh1c2lhc3QgICAg
ICAgICAgICAgfCAgICAgICAgICAgICBNZXNhIGFuZCBYIGRldmVsb3BlcgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAph
bWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
