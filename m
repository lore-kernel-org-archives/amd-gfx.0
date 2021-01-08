Return-Path: <SRS0=yWhT=GL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C620EC433E0
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Jan 2021 09:27:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 277FB23383
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Jan 2021 09:27:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 277FB23383
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 797AE6E7D4;
	Fri,  8 Jan 2021 09:27:56 +0000 (UTC)
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D8316E7D4
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Jan 2021 09:27:55 +0000 (UTC)
Received: from [192.168.0.6] (ip5f5aea6b.dynamic.kabel-deutschland.de
 [95.90.234.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id 2934220647D9E;
 Fri,  8 Jan 2021 10:27:53 +0100 (CET)
Subject: Re: [PATCH] drm/amdgpu: don't limit gtt size on apus
To: Joshua Ashton <joshua@froggi.es>, Alex Deucher <alexdeucher@gmail.com>
References: <20210105220359.1392555-1-joshua@froggi.es>
 <CADnq5_NcKG9H-dK0Kh2ksF8et+fnFkMdsejkg_RWrNeJ1JS4ng@mail.gmail.com>
 <6d6b0ae7-f732-167b-2bc1-6e517f6c8e99@froggi.es>
From: Paul Menzel <pmenzel@molgen.mpg.de>
Message-ID: <be71de87-9709-60fb-8b5d-a00c0f811b0f@molgen.mpg.de>
Date: Fri, 8 Jan 2021 10:27:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <6d6b0ae7-f732-167b-2bc1-6e517f6c8e99@froggi.es>
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
Cc: Christian Koenig <christian.koenig@amd.com>, amd-gfx@lists.freedesktop.org
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

RGVhciBMaW51eCBmb2xrcywKCgpBbSAwNS4wMS4yMSB1bSAyMzozMSBzY2hyaWViIEpvc2h1YSBB
c2h0b246Cj4gT24gMS81LzIxIDEwOjEwIFBNLCBBbGV4IERldWNoZXIgd3JvdGU6Cj4+IE9uIFR1
ZSwgSmFuIDUsIDIwMjEgYXQgNTowNSBQTSBKb3NodWEgQXNodG9uIDxqb3NodWFAZnJvZ2dpLmVz
PiB3cm90ZToKPj4+Cj4+PiBTaW5jZSBjb21taXQgMjQ1NjI1MjM2ODhiICgiUmV2ZXJ0ICJkcm0v
YW1kL2FtZGdwdTogc2V0IGd0dCBzaXplCj4+PiBhY2NvcmRpbmcgdG8gc3lzdGVtIG1lbW9yeSBz
aXplIG9ubHkiIiksIHRoZSBHVFQgc2l6ZSB3YXMgbGltaXRlZCBieQo+Pj4gM0dpQiBvciBWUkFN
IHNpemUuCj4+Cj4+IFRoZSBjb21taXQgaW4gcXVlc3Rpb24gd2FzIHRvIGZpeCBhIGhhbmcgd2l0
aCBjZXJ0YWluIHRlc3RzIG9uIEFQVXMuCj4+IFRoYXQgc2hvdWxkIGJlIHRlc3RlZCBhZ2FpbiBi
ZWZvcmUgd2UgcmUtZW5hYmxlIHRoaXMuwqAgSWYgaXQgaXMgZml4ZWQsCj4+IHdlIHNob3VsZCBq
dXN0IHJldmVydCB0aGUgcmV2ZXJ0IHJhdGhlciB0aGFuIHNwZWNpYWwgY2FzZSBkR1BVcy4KCj4g
SSB0aGluayB0aGUgY29tbWl0IGJlZm9yZSB0aGUgcmV2ZXJ0IChiYTg1MWVlZDg5NWMpIGhhcyBz
b21lIGZ1bmRhbWVudGFsIAo+IHByb2JsZW1zOgoKRm9yIHRoZSByZWNvcmQsIEkgY2Fu4oCZdCBm
aW5kIGNvbW1pdCBiYTg1MWVlZDg5NWMgaW4gbXkgZ2l0IHJlcG9zaXRvcnkuIApJdCBzZWVtcyB0
byBiZSBjb21taXQgNWY5N2ZjMGUwMyBbMV0uIChJIHdvbmRlciBob3cgdGhhdCBoYXBwZW5lZCwg
YnV0IAppdCB3YXMgaW4gMjAxNywgc28gaG9wZWZ1bGx5IHRoZSBwcm9jZXNzZXMgaW1wcm92ZWQu
KQoKPiBJdCB3YXMgYWx3YXlzIHNwZWNpZnlpbmcgbWF4KDNHaUIsIDMvNHRocyBSQU0pIG9mIEdU
VCwgZXZlbiBpZiB0aGF0IAo+IHdvdWxkbid0IGZpdCBpbnRvIHNheSwgMUdpQiBvciAyR2lCIG9m
IGF2YWlsYWJsZSBSQU0uCj4gCj4gTGltaXRpbmcgR1RUIHRvIG1pbihtYXgoM0dpQiwgVlJBTSks
IDMvNHRocyBSQU0pIHNpemUgb24gZEdQVXMgbWFrZXMgCj4gc2Vuc2UgYWxzbyBhbmQgaXMgYSBz
ZW5zaWJsZSBsaW1pdCB0byBhdm9pZCBzaWxseSBzaXR1YXRpb25zIHdpdGggCj4gb3ZlcmFsbG9j
YXRpb24gYW5kIHBvdGVudGlhbCBPT00uCj4gCj4gVGhpcyBwYXRjaCBzb2x2ZXMgYm90aCBvZiB0
aG9zZSBpc3N1ZXMuCgoKS2luZCByZWdhcmRzLAoKUGF1bAoKClsxXTogCmh0dHBzOi8vZ2l0Lmtl
cm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3RvcnZhbGRzL2xpbnV4LmdpdC9jb21t
aXQvP2lkPTVmOTdmYzBlMDMyNTk0MjEyNDU5ZjYzZTljNjIyOWNkNzljY2I2OTcKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxp
c3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3Rv
cC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
