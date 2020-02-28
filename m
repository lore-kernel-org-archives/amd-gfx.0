Return-Path: <SRS0=XGul=4Q=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 305FCC3F2D2
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Feb 2020 11:46:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E753246AA
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Feb 2020 11:46:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E753246AA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daenzer.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF00D6F426;
	Fri, 28 Feb 2020 11:46:40 +0000 (UTC)
Received: from netline-mail3.netline.ch (mail.netline.ch [148.251.143.178])
 by gabe.freedesktop.org (Postfix) with ESMTP id 4CDBD6F423;
 Fri, 28 Feb 2020 11:46:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by netline-mail3.netline.ch (Postfix) with ESMTP id 8DF5E2A6046;
 Fri, 28 Feb 2020 12:46:38 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at netline-mail3.netline.ch
Received: from netline-mail3.netline.ch ([127.0.0.1])
 by localhost (netline-mail3.netline.ch [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id rNCXxpm2Hb5o; Fri, 28 Feb 2020 12:46:38 +0100 (CET)
Received: from thor (252.80.76.83.dynamic.wline.res.cust.swisscom.ch
 [83.76.80.252])
 by netline-mail3.netline.ch (Postfix) with ESMTPSA id 1C7EF2A6016;
 Fri, 28 Feb 2020 12:46:38 +0100 (CET)
Received: from localhost ([::1]) by thor with esmtp (Exim 4.93)
 (envelope-from <michel@daenzer.net>)
 id 1j7e6H-000A76-JB; Fri, 28 Feb 2020 12:46:37 +0100
Subject: Re: [Mesa-dev] [Intel-gfx] gitlab.fd.o financial situation and impact
 on services
To: Erik Faye-Lund <erik.faye-lund@collabora.com>,
 Daniel Stone <daniel@fooishbar.org>
References: <CAKMK7uHHK2SsCfpmZwEUyTJJHsoccKoadoko3cEBOoYDFkmeAw@mail.gmail.com>
 <CAPM=9txcGPvFdSzMtYZXyqLKnWyacSMuHdoXdV63M53fLFVFpw@mail.gmail.com>
 <b398161ff7d0268454413058dc6c194cf93f5990.camel@collabora.com>
 <ece8ebe3-40ec-2457-02da-4fef19cbe8f6@intel.com>
 <6d2ec570f957b4504fb70e0b1f0632712a99dc0c.camel@collabora.com>
 <CAPj87rO7BuKQj2Kei3T7RdkFq5=TiuShBvtrPU2sn0iqMfXSTg@mail.gmail.com>
 <6761e107fda6af2f70f0a11784e182dfbc61cb0e.camel@collabora.com>
From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>
Message-ID: <8915813c-ec74-6b1c-6021-bb67219174a0@daenzer.net>
Date: Fri, 28 Feb 2020 12:46:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <6761e107fda6af2f70f0a11784e182dfbc61cb0e.camel@collabora.com>
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
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>,
 intel-gfx <intel-gfx@lists.freedesktop.org>,
 "X.Org development" <xorg-devel@lists.x.org>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 wayland <wayland-devel@lists.freedesktop.org>,
 "X.Org Foundation Board" <board@foundation.x.org>,
 Xorg Members List <members@x.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Mesa Dev <mesa-dev@lists.freedesktop.org>,
 Lionel Landwerlin <lionel.g.landwerlin@intel.com>,
 Dave Airlie <airlied@gmail.com>, gstreamer-devel@lists.freedesktop.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gMjAyMC0wMi0yOCAxMjowMiBwLm0uLCBFcmlrIEZheWUtTHVuZCB3cm90ZToKPiBPbiBGcmks
IDIwMjAtMDItMjggYXQgMTA6NDMgKzAwMDAsIERhbmllbCBTdG9uZSB3cm90ZToKPj4gT24gRnJp
LCAyOCBGZWIgMjAyMCBhdCAxMDowNiwgRXJpayBGYXllLUx1bmQKPj4gPGVyaWsuZmF5ZS1sdW5k
QGNvbGxhYm9yYS5jb20+IHdyb3RlOgo+Pj4gT24gRnJpLCAyMDIwLTAyLTI4IGF0IDExOjQwICsw
MjAwLCBMaW9uZWwgTGFuZHdlcmxpbiB3cm90ZToKPj4+PiBZZWFoLCBjaGFuZ2VzIG9uIHZ1bGth
biBkcml2ZXJzIG9yIGJhY2tlbmQgY29tcGlsZXJzIHNob3VsZCBiZQo+Pj4+IGZhaXJseQo+Pj4+
IHNhbmRib3hlZC4KPj4+Pgo+Pj4+IFdlIGFsc28gaGF2ZSB0b29scyB0aGF0IG9ubHkgd29yayBm
b3IgaW50ZWwgc3R1ZmYsIHRoYXQgc2hvdWxkCj4+Pj4gbmV2ZXIKPj4+PiB0cmlnZ2VyIGFueXRo
aW5nIG9uIG90aGVyIHBlb3BsZSdzIEhXLgo+Pj4+Cj4+Pj4gQ291bGQgc29tZXRoaW5nIGJlIHdv
cmtlZCBvdXQgdXNpbmcgdGhlIHRhZ3M/Cj4+Pgo+Pj4gSSB0aGluayBzbyEgV2UgaGF2ZSB0aGUg
cHJlLWRlZmluZWQgZW52aXJvbm1lbnQgdmFyaWFibGUKPj4+IENJX01FUkdFX1JFUVVFU1RfTEFC
RUxTLCBhbmQgd2UgY2FuIGRvIHZhcmlhYmxlIGNvbmRpdGlvbnM6Cj4+Pgo+Pj4gaHR0cHM6Ly9k
b2NzLmdpdGxhYi5jb20vZWUvY2kveWFtbC8jb25seXZhcmlhYmxlc2V4Y2VwdHZhcmlhYmxlcwo+
Pj4KPj4+IFRoYXQgc291bmRzIGxpa2UgYSBwcmV0dHkgbmVhdCBtaWRkbGUtZ3JvdW5kIHRvIG1l
LiBJIGp1c3QgaG9wZQo+Pj4gdGhhdAo+Pj4gbmV3IHBpcGVsaW5lcyBhcmUgdHJpZ2dlcmVkIGlm
IG5ldyBsYWJlbHMgYXJlIGFkZGVkLCBiZWNhdXNlIG5vdAo+Pj4gZXZlcnlvbmUgaXMgYWxsb3dl
ZCB0byBzZXQgbGFiZWxzLCBhbmQgc29tZXRpbWVzIHBlb3BsZSBmb3JnZXQuLi4KPj4KPj4gVGhl
cmUncyBhbHNvIHRoaXMgd2hpY2ggaXMgc29tZXdoYXQgbW9yZSByb2J1c3Q6Cj4+IGh0dHBzOi8v
Z2l0bGFiLmZyZWVkZXNrdG9wLm9yZy9tZXNhL21lc2EvbWVyZ2VfcmVxdWVzdHMvMjU2OQo+IAo+
IEknbSBub3Qgc3VyZSBpdCdzIG1vcmUgcm9idXN0LCBidXQgeWVhaCB0aGF0IGEgdXNlZnVsIHRv
b2wgdG9vLgo+IAo+IFRoZSByZWFzb24gSSdtIHNrZXB0aWNhbCBhYm91dCB0aGUgcm9idXN0bmVz
cyBpcyB0aGF0IHdlJ2xsIG1pc3MKPiB0ZXN0aW5nIGlmIHRoaXMgbWlzc2VzIGEgcGF0aC4KClN1
cmVseSBtaXNzaW5nIGEgcGF0aCB3aWxsIGJlIGxlc3MgbGlrZWx5IC8gb2Z0ZW4gdG8gaGFwcGVu
IGNvbXBhcmVkIHRvCmFuIE1SIG1pc3NpbmcgYSBsYWJlbC4gKFVzZXJzIHdoaWNoIGFyZW4ndCBt
ZW1iZXJzIG9mIHRoZSBwcm9qZWN0IGNhbid0CmV2ZW4gc2V0IGxhYmVscyBmb3IgYW4gTVIpCgoK
LS0gCkVhcnRobGluZyBNaWNoZWwgRMOkbnplciAgICAgICAgICAgICAgIHwgICAgICAgICAgICAg
ICBodHRwczovL3JlZGhhdC5jb20KTGlicmUgc29mdHdhcmUgZW50aHVzaWFzdCAgICAgICAgICAg
ICB8ICAgICAgICAgICAgIE1lc2EgYW5kIFggZGV2ZWxvcGVyCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhA
bGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxt
YW4vbGlzdGluZm8vYW1kLWdmeAo=
