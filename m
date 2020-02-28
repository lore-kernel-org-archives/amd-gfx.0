Return-Path: <SRS0=XGul=4Q=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 050A5C3F2D2
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Feb 2020 11:43:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA4AF246A0
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Feb 2020 11:43:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA4AF246A0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daenzer.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D83746F41F;
	Fri, 28 Feb 2020 11:43:37 +0000 (UTC)
Received: from netline-mail3.netline.ch (mail.netline.ch [148.251.143.178])
 by gabe.freedesktop.org (Postfix) with ESMTP id 979426F41E;
 Fri, 28 Feb 2020 11:43:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by netline-mail3.netline.ch (Postfix) with ESMTP id C26B02A6046;
 Fri, 28 Feb 2020 12:43:34 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at netline-mail3.netline.ch
Received: from netline-mail3.netline.ch ([127.0.0.1])
 by localhost (netline-mail3.netline.ch [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id G_Sddc70SOPf; Fri, 28 Feb 2020 12:43:34 +0100 (CET)
Received: from thor (252.80.76.83.dynamic.wline.res.cust.swisscom.ch
 [83.76.80.252])
 by netline-mail3.netline.ch (Postfix) with ESMTPSA id 6977A2A6016;
 Fri, 28 Feb 2020 12:43:34 +0100 (CET)
Received: from localhost ([::1]) by thor with esmtp (Exim 4.93)
 (envelope-from <michel@daenzer.net>)
 id 1j7e3I-000A50-IZ; Fri, 28 Feb 2020 12:43:32 +0100
Subject: Re: [Mesa-dev] [Intel-gfx] gitlab.fd.o financial situation and impact
 on services
To: Erik Faye-Lund <erik.faye-lund@collabora.com>,
 Dave Airlie <airlied@gmail.com>, Daniel Vetter <daniel.vetter@ffwll.ch>
References: <CAKMK7uHHK2SsCfpmZwEUyTJJHsoccKoadoko3cEBOoYDFkmeAw@mail.gmail.com>
 <CAPM=9txcGPvFdSzMtYZXyqLKnWyacSMuHdoXdV63M53fLFVFpw@mail.gmail.com>
 <b398161ff7d0268454413058dc6c194cf93f5990.camel@collabora.com>
From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>
Message-ID: <a7727f84-ba85-f19d-9823-c7ba04fd1bb8@daenzer.net>
Date: Fri, 28 Feb 2020 12:43:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <b398161ff7d0268454413058dc6c194cf93f5990.camel@collabora.com>
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
Cc: intel-gfx <intel-gfx@lists.freedesktop.org>,
 "X.Org development" <xorg-devel@lists.x.org>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 wayland <wayland-devel@lists.freedesktop.org>,
 "X.Org Foundation Board" <board@foundation.x.org>,
 Xorg Members List <members@x.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Mesa Dev <mesa-dev@lists.freedesktop.org>,
 gstreamer-devel@lists.freedesktop.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gMjAyMC0wMi0yOCAxMDoyOCBhLm0uLCBFcmlrIEZheWUtTHVuZCB3cm90ZToKPiAKPiBXZSBj
b3VsZCBhbHNvIGRvIHN0dWZmIGxpa2UgcmVkdWNpbmcgdGhlIGFtb3VudCBvZiB0ZXN0cyB3ZSBy
dW4gb24gZWFjaAo+IGNvbW1pdCwgYW5kIHB1bnQgc29tZSB0ZXN0aW5nIHRvIGEgcGVyLXdlZWtl
bmQgdGVzdC1ydW4gb3Igc29tZXRpbmcKPiBsaWtlIHRoYXQuIFdlIGRvbid0ICpuZWVkKiB0byBr
bm93IGFib3V0IGV2ZXJ5IHByb2JsZW0gdXAgZnJvbnQsIGp1c3QKPiB0aGUgc3R1ZmYgdGhhdCdz
IGFib3V0IHRvIGJlIHJlbGVhc2VkLCByZWFsbHkuIFRoZSBvdGhlciBzdHVmZiBpcyBqdXN0Cj4g
bmljZSB0byBoYXZlLiBJZiBpdCdzIHRvbyBleHBlbnNpdmUsIEkgd291bGQgc2F5IGRyb3AgaXQu
CgpJIGRvbid0IGFncmVlIHRoYXQgcHJlLW1lcmdlIHRlc3RpbmcgaXMganVzdCBuaWNlIHRvIGhh
dmUuIEEgcHJvYmxlbQp3aGljaCBpcyBvbmx5IGNhdWdodCBhZnRlciBpdCBsYW5kcyBpbiBtYWlu
bGluZSBoYXMgYSBtdWNoIGJpZ2dlciBpbXBhY3QKdGhhbiBvbmUgd2hpY2ggaXMgYWxyZWFkeSBj
YXVnaHQgZWFybGllci4KCgotLSAKRWFydGhsaW5nIE1pY2hlbCBEw6RuemVyICAgICAgICAgICAg
ICAgfCAgICAgICAgICAgICAgIGh0dHBzOi8vcmVkaGF0LmNvbQpMaWJyZSBzb2Z0d2FyZSBlbnRo
dXNpYXN0ICAgICAgICAgICAgIHwgICAgICAgICAgICAgTWVzYSBhbmQgWCBkZXZlbG9wZXIKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWls
aW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVl
ZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
