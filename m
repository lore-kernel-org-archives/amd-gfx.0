Return-Path: <SRS0=XGul=4Q=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88FFCC3F2D3
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Feb 2020 13:08:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69C582067C
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Feb 2020 13:08:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69C582067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DF03F6F448;
	Fri, 28 Feb 2020 13:08:24 +0000 (UTC)
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3BE546F445;
 Fri, 28 Feb 2020 13:08:23 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 28 Feb 2020 05:08:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,496,1574150400"; d="scan'208";a="411397329"
Received: from unknown (HELO [10.249.39.174]) ([10.249.39.174])
 by orsmga005.jf.intel.com with ESMTP; 28 Feb 2020 05:08:18 -0800
Subject: Re: [Mesa-dev] [Intel-gfx] gitlab.fd.o financial situation and impact
 on services
To: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>,
 Erik Faye-Lund <erik.faye-lund@collabora.com>,
 Daniel Stone <daniel@fooishbar.org>
References: <CAKMK7uHHK2SsCfpmZwEUyTJJHsoccKoadoko3cEBOoYDFkmeAw@mail.gmail.com>
 <CAPM=9txcGPvFdSzMtYZXyqLKnWyacSMuHdoXdV63M53fLFVFpw@mail.gmail.com>
 <b398161ff7d0268454413058dc6c194cf93f5990.camel@collabora.com>
 <ece8ebe3-40ec-2457-02da-4fef19cbe8f6@intel.com>
 <6d2ec570f957b4504fb70e0b1f0632712a99dc0c.camel@collabora.com>
 <CAPj87rO7BuKQj2Kei3T7RdkFq5=TiuShBvtrPU2sn0iqMfXSTg@mail.gmail.com>
 <6761e107fda6af2f70f0a11784e182dfbc61cb0e.camel@collabora.com>
 <8915813c-ec74-6b1c-6021-bb67219174a0@daenzer.net>
From: Lionel Landwerlin <lionel.g.landwerlin@intel.com>
Organization: Intel Corporation (UK) Ltd. - Co. Reg. #1134945 - Pipers Way,
 Swindon SN3 1RJ
Message-ID: <800a567b-c00d-dcc3-0ea2-7ea61a0cd4b6@intel.com>
Date: Fri, 28 Feb 2020 15:08:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <8915813c-ec74-6b1c-6021-bb67219174a0@daenzer.net>
Content-Language: en-US
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
 Mesa Dev <mesa-dev@lists.freedesktop.org>, Dave Airlie <airlied@gmail.com>,
 gstreamer-devel@lists.freedesktop.org
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gMjgvMDIvMjAyMCAxMzo0NiwgTWljaGVsIETDpG56ZXIgd3JvdGU6Cj4gT24gMjAyMC0wMi0y
OCAxMjowMiBwLm0uLCBFcmlrIEZheWUtTHVuZCB3cm90ZToKPj4gT24gRnJpLCAyMDIwLTAyLTI4
IGF0IDEwOjQzICswMDAwLCBEYW5pZWwgU3RvbmUgd3JvdGU6Cj4+PiBPbiBGcmksIDI4IEZlYiAy
MDIwIGF0IDEwOjA2LCBFcmlrIEZheWUtTHVuZAo+Pj4gPGVyaWsuZmF5ZS1sdW5kQGNvbGxhYm9y
YS5jb20+IHdyb3RlOgo+Pj4+IE9uIEZyaSwgMjAyMC0wMi0yOCBhdCAxMTo0MCArMDIwMCwgTGlv
bmVsIExhbmR3ZXJsaW4gd3JvdGU6Cj4+Pj4+IFllYWgsIGNoYW5nZXMgb24gdnVsa2FuIGRyaXZl
cnMgb3IgYmFja2VuZCBjb21waWxlcnMgc2hvdWxkIGJlCj4+Pj4+IGZhaXJseQo+Pj4+PiBzYW5k
Ym94ZWQuCj4+Pj4+Cj4+Pj4+IFdlIGFsc28gaGF2ZSB0b29scyB0aGF0IG9ubHkgd29yayBmb3Ig
aW50ZWwgc3R1ZmYsIHRoYXQgc2hvdWxkCj4+Pj4+IG5ldmVyCj4+Pj4+IHRyaWdnZXIgYW55dGhp
bmcgb24gb3RoZXIgcGVvcGxlJ3MgSFcuCj4+Pj4+Cj4+Pj4+IENvdWxkIHNvbWV0aGluZyBiZSB3
b3JrZWQgb3V0IHVzaW5nIHRoZSB0YWdzPwo+Pj4+IEkgdGhpbmsgc28hIFdlIGhhdmUgdGhlIHBy
ZS1kZWZpbmVkIGVudmlyb25tZW50IHZhcmlhYmxlCj4+Pj4gQ0lfTUVSR0VfUkVRVUVTVF9MQUJF
TFMsIGFuZCB3ZSBjYW4gZG8gdmFyaWFibGUgY29uZGl0aW9uczoKPj4+Pgo+Pj4+IGh0dHBzOi8v
ZG9jcy5naXRsYWIuY29tL2VlL2NpL3lhbWwvI29ubHl2YXJpYWJsZXNleGNlcHR2YXJpYWJsZXMK
Pj4+Pgo+Pj4+IFRoYXQgc291bmRzIGxpa2UgYSBwcmV0dHkgbmVhdCBtaWRkbGUtZ3JvdW5kIHRv
IG1lLiBJIGp1c3QgaG9wZQo+Pj4+IHRoYXQKPj4+PiBuZXcgcGlwZWxpbmVzIGFyZSB0cmlnZ2Vy
ZWQgaWYgbmV3IGxhYmVscyBhcmUgYWRkZWQsIGJlY2F1c2Ugbm90Cj4+Pj4gZXZlcnlvbmUgaXMg
YWxsb3dlZCB0byBzZXQgbGFiZWxzLCBhbmQgc29tZXRpbWVzIHBlb3BsZSBmb3JnZXQuLi4KPj4+
IFRoZXJlJ3MgYWxzbyB0aGlzIHdoaWNoIGlzIHNvbWV3aGF0IG1vcmUgcm9idXN0Ogo+Pj4gaHR0
cHM6Ly9naXRsYWIuZnJlZWRlc2t0b3Aub3JnL21lc2EvbWVzYS9tZXJnZV9yZXF1ZXN0cy8yNTY5
Cj4+IEknbSBub3Qgc3VyZSBpdCdzIG1vcmUgcm9idXN0LCBidXQgeWVhaCB0aGF0IGEgdXNlZnVs
IHRvb2wgdG9vLgo+Pgo+PiBUaGUgcmVhc29uIEknbSBza2VwdGljYWwgYWJvdXQgdGhlIHJvYnVz
dG5lc3MgaXMgdGhhdCB3ZSdsbCBtaXNzCj4+IHRlc3RpbmcgaWYgdGhpcyBtaXNzZXMgYSBwYXRo
Lgo+IFN1cmVseSBtaXNzaW5nIGEgcGF0aCB3aWxsIGJlIGxlc3MgbGlrZWx5IC8gb2Z0ZW4gdG8g
aGFwcGVuIGNvbXBhcmVkIHRvCj4gYW4gTVIgbWlzc2luZyBhIGxhYmVsLiAoVXNlcnMgd2hpY2gg
YXJlbid0IG1lbWJlcnMgb2YgdGhlIHByb2plY3QgY2FuJ3QKPiBldmVuIHNldCBsYWJlbHMgZm9y
IGFuIE1SKQo+Cj4KU291bmRzIGxpa2UgYSBnb29kIGFsdGVybmF0aXZlIHRvIHRhZ3MuCgoKLUxp
b25lbAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1k
LWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9s
aXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
