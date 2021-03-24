Return-Path: <SRS0=J6fF=IW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0765C433DB
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Mar 2021 10:13:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3ABD619AB
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Mar 2021 10:13:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3ABD619AB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daenzer.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 381726E9A7;
	Wed, 24 Mar 2021 10:13:53 +0000 (UTC)
Received: from netline-mail3.netline.ch (mail.netline.ch [148.251.143.178])
 by gabe.freedesktop.org (Postfix) with ESMTP id 9BA746E9A7;
 Wed, 24 Mar 2021 10:13:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by netline-mail3.netline.ch (Postfix) with ESMTP id 97BB92A6045;
 Wed, 24 Mar 2021 11:13:50 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at netline-mail3.netline.ch
Received: from netline-mail3.netline.ch ([127.0.0.1])
 by localhost (netline-mail3.netline.ch [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id XFM4zYS7LqyR; Wed, 24 Mar 2021 11:13:50 +0100 (CET)
Received: from thor (24.99.2.85.dynamic.wline.res.cust.swisscom.ch
 [85.2.99.24])
 by netline-mail3.netline.ch (Postfix) with ESMTPA id 2EEB92A6016;
 Wed, 24 Mar 2021 11:13:50 +0100 (CET)
Received: from [::1] by thor with esmtp (Exim 4.94)
 (envelope-from <michel@daenzer.net>)
 id 1lP0WL-000jKo-2t; Wed, 24 Mar 2021 11:13:49 +0100
To: Mark Yacoub <markyacoub@google.com>, Alex Deucher <alexdeucher@gmail.com>
References: <20210310161444.1015500-1-markyacoub@chromium.org>
 <CADnq5_P9aYcedOP2qduSz7VN1fCSnmQEtPa+FdjYu9Co7TwPog@mail.gmail.com>
 <CAC0gqY7Y2WxtAZ3GnWmASPYq7ahYTfmPhOHAAX5UjMNS9k098w@mail.gmail.com>
From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>
Subject: Re: [PATCH] drm/amdgpu: Ensure that the modifier requested is
 supported by plane.
Message-ID: <b4070483-5aa5-c712-6435-dcb4a206ca76@daenzer.net>
Date: Wed, 24 Mar 2021 11:13:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <CAC0gqY7Y2WxtAZ3GnWmASPYq7ahYTfmPhOHAAX5UjMNS9k098w@mail.gmail.com>
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
Cc: "Deucher, Alexander" <alexander.deucher@amd.com>,
 Mark Yacoub <markyacoub@chromium.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gMjAyMS0wMy0yMyA0OjMyIHAubS4sIE1hcmsgWWFjb3ViIHdyb3RlOgo+IE9uIFR1ZSwgTWFy
IDIzLCAyMDIxIGF0IDExOjAyIEFNIEFsZXggRGV1Y2hlciA8YWxleGRldWNoZXJAZ21haWwuY29t
PiB3cm90ZToKPj4KPj4gT24gV2VkLCBNYXIgMTAsIDIwMjEgYXQgMTE6MTUgQU0gTWFyayBZYWNv
dWIgPG1hcmt5YWNvdWJAY2hyb21pdW0ub3JnPiB3cm90ZToKPj4+Cj4+PiBGcm9tOiBNYXJrIFlh
Y291YiA8bWFya3lhY291YkBnb29nbGUuY29tPgo+Pj4KPj4+IE9uIGluaXRpYWxpemluZyB0aGUg
ZnJhbWVidWZmZXIsIGNhbGwgZHJtX2FueV9wbGFuZV9oYXNfZm9ybWF0IHRvIGRvIGEKPj4+IGNo
ZWNrIGlmIHRoZSBtb2RpZmllciBpcyBzdXBwb3J0ZWQuIGRybV9hbnlfcGxhbmVfaGFzX2Zvcm1h
dCBjYWxscwo+Pj4gZG1fcGxhbmVfZm9ybWF0X21vZF9zdXBwb3J0ZWQgd2hpY2ggaXMgZXh0ZW5k
ZWQgdG8gdmFsaWRhdGUgdGhhdCB0aGUKPj4+IG1vZGlmaWVyIGlzIG9uIHRoZSBsaXN0IG9mIHRo
ZSBwbGFuZSdzIHN1cHBvcnRlZCBtb2RpZmllcnMuCj4+Pgo+Pj4gVGhlIGJ1ZyB3YXMgY2F1Z2h0
IHVzaW5nIGlndC1ncHUtdG9vbHMgdGVzdDoga21zX2FkZGZiX2Jhc2ljLmFkZGZiMjUtYmFkLW1v
ZGlmaWVyCj4+Pgo+Pj4gVGVzdGVkIG9uIENocm9tZU9TIFpvcmsgYnkgdHVybmluZyBvbiB0aGUg
ZGlzcGxheSwgcnVubmluZyBhbiBvdmVybGF5Cj4+PiB0ZXN0LCBhbmQgcnVubmluZyBhIFlUIHZp
ZGVvLgo+Pj4KPj4+IENjOiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+
Cj4+PiBDYzogQmFzIE5pZXV3ZW5odWl6ZW4gPGJhc0BiYXNuaWV1d2VuaHVpemVuLm5sPgo+Pj4g
U2lnbmVkLW9mZi1ieTogZGVmYXVsdCBhdmF0YXJNYXJrIFlhY291YiA8bWFya3lhY291YkBjaHJv
bWl1bS5vcmc+Cj4+Cj4+IEknbSBub3QgYW4gZXhwZXJ0IHdpdGggbW9kaWZpZXJzIHlldC4gIFdp
bGwgdGhpcyBicmVhayBjaGlwcyB3aGljaAo+PiBkb24ndCBjdXJyZW50bHkgc3VwcG9ydCBtb2Rp
ZmllcnM/Cj4gTm8gaXQgc2hvdWxkbid0LiBXaGVuIHlvdSBkb24ndCBzdXBwb3J0IG1vZGlmaWVy
cyB5ZXQsIHlvdXIgd2lsbAo+IGRlZmF1bHQgdG8gTGluZWFyIE1vZGlmaWVyIChEUk1fRk9STUFU
X01PRF9MSU5FQVIpLAo+IFsuLi5dCk5vIG1vZGlmaWVyIHN1cHBvcnQgZG9lcyBub3QgaW1wbHkg
bGluZWFyLiBJdCdzIGdlbmVyYWxseSBzaWduYWxsZWQgdmlhIERSTV9GT1JNQVRfTU9EX0lOVkFM
SUQsIHdoaWNoIHJvdWdobHkgbWVhbnMgInRpbGluZyBpcyBkZXRlcm1pbmVkIGJ5IGRyaXZlciBz
cGVjaWZpYyBtZWNoYW5pc21zIi4KCgotLSAKRWFydGhsaW5nIE1pY2hlbCBEw6RuemVyICAgICAg
ICAgICAgICAgfCAgICAgICAgICAgICAgIGh0dHBzOi8vcmVkaGF0LmNvbQpMaWJyZSBzb2Z0d2Fy
ZSBlbnRodXNpYXN0ICAgICAgICAgICAgIHwgICAgICAgICAgICAgTWVzYSBhbmQgWCBkZXZlbG9w
ZXIKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdm
eCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0
cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
