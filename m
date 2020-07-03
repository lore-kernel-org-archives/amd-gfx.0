Return-Path: <SRS0=Hy8X=AR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 691D9C433DF
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Jul 2020 07:47:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 057342073E
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Jul 2020 07:47:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 057342073E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 38B766E32D;
	Mon,  6 Jul 2020 07:47:10 +0000 (UTC)
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 201C56E25C
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Jul 2020 13:52:45 +0000 (UTC)
Received: from [192.168.0.4] (ip5f5af280.dynamic.kabel-deutschland.de
 [95.90.242.128])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id 967DB20225AE1;
 Fri,  3 Jul 2020 15:52:43 +0200 (CEST)
Subject: Re: [PATCH 1/2] moduleparams: Add hex type parameter
To: Linus Torvalds <torvalds@linux-foundation.org>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
References: <20200702140102.26129-1-pmenzel@molgen.mpg.de>
 <7c31d918-c967-5ebb-970e-7f6e913237e8@amd.com>
 <CAHk-=wimBucBdC+tzFEuFJU5X1UFTVWo+AHMvQTSkCcVnTT-ww@mail.gmail.com>
From: Paul Menzel <pmenzel@molgen.mpg.de>
Message-ID: <c9f3e69b-1868-0a1f-e5f8-85db7bebfb4d@molgen.mpg.de>
Date: Fri, 3 Jul 2020 15:52:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=wimBucBdC+tzFEuFJU5X1UFTVWo+AHMvQTSkCcVnTT-ww@mail.gmail.com>
Content-Language: en-US
X-Mailman-Approved-At: Mon, 06 Jul 2020 07:47:09 +0000
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
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 amd-gfx@lists.freedesktop.org
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

RGVhciBMaW51cywgZGVhciBDaHJpc3RpYW4sCgoKQW0gMDIuMDcuMjAgdW0gMjE6NDIgc2Nocmll
YiBMaW51cyBUb3J2YWxkczoKPiBPbiBUaHUsIEp1bCAyLCAyMDIwIGF0IDc6NDIgQU0gQ2hyaXN0
aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPiB3cm90ZToKPj4KPj4gSSdtIGp1
c3Qgbm90IHN1cmUgaG93IHdlbGwgdGhpcyBpcyByZWNlaXZlZCB1cHN0cmVhbSBiZWNhdXNlIGl0
IG9ubHkKPj4gY292ZXJzIHUzMgo+Pgo+PiBPbiB0aGUgb3RoZXIgaGFuZCB0aGF0IGlzIHByb2Jh
Ymx5IGFsc28gdGhlIG1vc3QgdXNlZC4KPiAKPiBOb3QgbmVjZXNzYXJpbHkgdHJ1ZS4gSSdkIGFy
Z3VlIHRoYXQgInVuc2lnbmVkIGxvbmciICBpcyBlcXVhbGx5Cj4gcG9zc2libGUgZm9yIHNvbWUg
Yml0IG1hc2sgKG9yIG90aGVyIGhleC1saWtlbHkpIHR5cGUuCj4gCj4gU28gZG9uJ3QgY2FsbCBp
dCBqdXN0ICJoZXgiLiBDYWxsIGl0ICJoZXhpbnQiICh0aGUgaGV4IGRvZXMgaW1wbHkKPiAidW5z
aWduZWQiLCBJIGZlZWwgLSBzaG93aW5nIGhleCBudW1iZXJzIHdpdGggYSBzaWduIHNvdW5kcyBp
bnNhbmUpLgo+IAo+IFRoYXQgd2F5LCBpZiBzb21lYm9keSBlbmRzIHVwIHdhbnRpbmcgaXQgZm9y
IHVuc2lnbmVkIGxvbmcgdmFsdWVzLAo+IHdlJ3JlIG5vdCBzdHVjay4KCkdvb2QgaWRlYS4gRG9u
LmUKCj4gQW5vdGhlciBvcHRpb24gaXMgdG8ganVzdCBzYXkgdGhhdCBoZXggdmFsdWVzIGFsd2F5
cyBoYXZlIGJpdCBfc2l6ZXNfLgo+IFNvICJoZXgzMiIgYW5kICJoZXg2NCIgd291bGQgYWxzbyBt
YWtlIHNlbnNlIGFzIG5hbWVzIHRvIG1lLgoKSSB3ZW50IGZvciBpbnQgdG8gYmUgY29uc2lzdGVu
dCBpbiB0aGUgbmFtaW5nLCBhbmQga3N0cnRvdWludCBpcyB1c2VkIGluIAp0aGUgbWFjcm8uCgo+
IFdoaWxlIGF0IGl0LCBzaG91bGQgdGhlIGhleCBudW1iZXJzIGFsd2F5cyBiZSBwYWRkZWQgb3V0
IHRvIHRoZSBzaXplPwo+IFRoZSBleGFtcGxlIFBhdWwgdXNlZCBkb2Vzbid0IGhhdmUgdGhhdCBp
c3N1ZSAoaGlnaCBiaXQgYmVpbmcgc2V0KS4KPiAKPiBCYnV0IG9mdGVuIGl0IG1heSBtYWtlIHNl
bnNlIHRvIHNob3cgYSAzMi1iaXQgaGV4IG51bWJlciBhcyAiJSMwOHgiCj4gYmVjYXVzZSBpdCBy
ZWFsbHkgbWFrZXMgdGhpbmdzIGNsZWFyZXIgd2hlbiB5b3UncmUgbG9va2luZyBhdCBoaWdoCj4g
Yml0cywgc2F5Lgo+IAo+IEl0J3MgcmVhbGx5IGhhcmQgdG8gdGVsbCB0aGUgZGlmZmVyZW5jZSBi
ZXR3ZWVuICJqdXN0IGJpdCAyNyBzZXQiIGFuZAo+ICJqdXN0IGJpdCAzMSIgc2V0IG90aGVyd2lz
ZSwgYW5kIHRoYXQncyBub3QgYWxsIHRoYXQgdW5jb21tb24gd2hlbiB0aGUKPiBiaXRtYXNrcyBh
cmUgc3BhcnNlLgoKQWxzbyBnb29kIGlkZWEuIERvbmUuCgpJIGp1c3Qgc2VudCBvdXQgdGhlIHYy
LgoKCktpbmQgcmVnYXJkcywKClBhdWwKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVz
a3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9h
bWQtZ2Z4Cg==
