Return-Path: <SRS0=G8as=BB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F27EC433DF
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Jul 2020 14:30:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22C20204EA
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Jul 2020 14:30:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=shipmail.org header.i=@shipmail.org header.b="J9tPxlDO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22C20204EA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=shipmail.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E3A656E822;
	Wed, 22 Jul 2020 14:30:17 +0000 (UTC)
Received: from pio-pvt-msa2.bahnhof.se (pio-pvt-msa2.bahnhof.se [79.136.2.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 79E3B6E822;
 Wed, 22 Jul 2020 14:30:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by pio-pvt-msa2.bahnhof.se (Postfix) with ESMTP id 48E123F4A0;
 Wed, 22 Jul 2020 16:30:13 +0200 (CEST)
Authentication-Results: pio-pvt-msa2.bahnhof.se; dkim=pass (1024-bit key;
 unprotected) header.d=shipmail.org header.i=@shipmail.org header.b=J9tPxlDO; 
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Received: from pio-pvt-msa2.bahnhof.se ([127.0.0.1])
 by localhost (pio-pvt-msa2.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qxFCURGVkHmS; Wed, 22 Jul 2020 16:30:12 +0200 (CEST)
Received: from mail1.shipmail.org (h-205-35.A357.priv.bahnhof.se
 [155.4.205.35]) (Authenticated sender: mb878879)
 by pio-pvt-msa2.bahnhof.se (Postfix) with ESMTPA id 1A2CA3F418;
 Wed, 22 Jul 2020 16:30:08 +0200 (CEST)
Received: from [192.168.0.100] (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
 by mail1.shipmail.org (Postfix) with ESMTPSA id 9A868362551;
 Wed, 22 Jul 2020 16:30:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
 t=1595428209; bh=aSl2HPnj0FsbxHaER8NWcOJP1lNOrY9LWA/Axz0+ARc=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=J9tPxlDOyXydSD3slE2p0eNPxX3EnMvw3rCZ+KeUxQDcoGObCCmP0ZpThy3LkSLvn
 JFDx/0w+cDSwmSJPVlusn15yK+G3RxeKW7CfFJ53qq7wa1RdTrTaRIDyHU/i04o+R3
 QCfhbTQJ1VJwrsAlbklRs6g9PT7fFz7pDrquF7hI=
Subject: Re: [Linaro-mm-sig] [PATCH 1/2] dma-buf.rst: Document why indefinite
 fences are a bad idea
To: christian.koenig@amd.com, Daniel Vetter <daniel.vetter@ffwll.ch>
References: <20200707201229.472834-4-daniel.vetter@ffwll.ch>
 <93b673b7-bb48-96eb-dc2c-bd4f9304000e@shipmail.org>
 <20200721074157.GB3278063@phenom.ffwll.local>
 <3603bb71-318b-eb53-0532-9daab62dce86@amd.com>
 <57a5eb9d-b74f-8ce4-7199-94e911d9b68b@shipmail.org>
 <CAPM=9twUWeenf-26GEvkuKo3wHgS3BCyrva=sNaWo6+=A5qdoQ@mail.gmail.com>
 <805c49b7-f0b3-45dc-5fe3-b352f0971527@shipmail.org>
 <CAKMK7uHhhxBC2MvnNnU9FjxJaWkEcP3m5m7AN3yzfw=wxFsckA@mail.gmail.com>
 <92393d26-d863-aac6-6d27-53cad6854e13@shipmail.org>
 <CAKMK7uF8jpyuCF8uUbEeJUedErxqRGa8JY+RuURg7H1XXWXzkw@mail.gmail.com>
 <8fd999f2-cbf6-813c-6ad4-131948fb5cc5@shipmail.org>
 <CAKMK7uH0rcyepP2hDpNB-yuvNyjee1tPmxWUyefS5j7i-N6Pfw@mail.gmail.com>
 <df5414f5-ac5c-d212-500c-b05c7c78ce84@shipmail.org>
 <CAKMK7uF27SifuvMatuP2kJPTf+LVmVbG098cE2cqorYYo7UHkw@mail.gmail.com>
 <697d1b5e-5d1c-1655-23f8-7a3f652606f3@shipmail.org>
 <CAKMK7uGSkgdJyyvGe8SF_vWfgyaCWn5p0GvZZdLvkxmrS6tYbQ@mail.gmail.com>
 <c742c557-f48f-1591-1d1d-a5181b408a67@gmail.com>
From: =?UTF-8?Q?Thomas_Hellstr=c3=b6m_=28Intel=29?= <thomas_os@shipmail.org>
Message-ID: <a046ea93-b303-17d4-add4-efd0a709cfd2@shipmail.org>
Date: Wed, 22 Jul 2020 16:30:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <c742c557-f48f-1591-1d1d-a5181b408a67@gmail.com>
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
Cc: Daniel Stone <daniels@collabora.com>,
 linux-rdma <linux-rdma@vger.kernel.org>,
 Felix Kuehling <Felix.Kuehling@amd.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 DRI Development <dri-devel@lists.freedesktop.org>,
 "moderated list:DMA BUFFER SHARING FRAMEWORK" <linaro-mm-sig@lists.linaro.org>,
 Steve Pronovost <spronovo@microsoft.com>,
 amd-gfx mailing list <amd-gfx@lists.freedesktop.org>,
 Jason Ekstrand <jason@jlekstrand.net>, Jesse Natalie <jenatali@microsoft.com>,
 Daniel Vetter <daniel.vetter@intel.com>,
 Thomas Hellstrom <thomas.hellstrom@intel.com>,
 Mika Kuoppala <mika.kuoppala@intel.com>, Dave Airlie <airlied@gmail.com>,
 Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
 Linux Media Mailing List <linux-media@vger.kernel.org>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Ck9uIDIwMjAtMDctMjIgMTY6MjMsIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4gQW0gMjIuMDcu
MjAgdW0gMTY6MDcgc2NocmllYiBEYW5pZWwgVmV0dGVyOgo+PiBPbiBXZWQsIEp1bCAyMiwgMjAy
MCBhdCAzOjEyIFBNIFRob21hcyBIZWxsc3Ryw7ZtIChJbnRlbCkKPj4gPHRob21hc19vc0BzaGlw
bWFpbC5vcmc+IHdyb3RlOgo+Pj4gT24gMjAyMC0wNy0yMiAxNDo0MSwgRGFuaWVsIFZldHRlciB3
cm90ZToKPj4+PiBJJ20gcHJldHR5IHN1cmUgdGhlcmUncyBtb3JlIGJ1Z3MsIEkganVzdCBoYXZl
bid0IGhlYXJkIGZyb20gdGhlbSB5ZXQuCj4+Pj4gQWxzbyBkdWUgdG8gdGhlIG9wdC1pbiBuYXR1
cmUgb2YgZG1hLWZlbmNlIHdlIGNhbiBsaW1pdCB0aGUgc2NvcGUgb2YKPj4+PiB3aGF0IHdlIGZp
eCBmYWlybHkgbmF0dXJhbGx5LCBqdXN0IGRvbid0IHB1dCB0aGVtIHdoZXJlIG5vIG9uZSBjYXJl
cwo+Pj4+IDotKSBPZiBjb3Vyc2UgdGhhdCBhbHNvIGhpZGVzIGdlbmVyYWwgbG9ja2luZyBpc3N1
ZXMgaW4gZG1hX2ZlbmNlCj4+Pj4gc2lnbmFsbGluZyBjb2RlLCBidXQgd2VsbCAqc2hydWcqLgo+
Pj4gSG1tLCB5ZXMuIEFub3RoZXIgcG90ZW50aWFsIGJpZyBwcm9ibGVtIHdvdWxkIGJlIGRyaXZl
cnMgdGhhdCB3YW50IHRvCj4+PiB1c2UgZ3B1IHBhZ2UgZmF1bHRzIGluIHRoZSBkbWEtZmVuY2Ug
Y3JpdGljYWwgc2VjdGlvbnMgd2l0aCB0aGUKPj4+IGJhdGNoLWJhc2VkIHByb2dyYW1taW5nIG1v
ZGVsLgo+PiBZZWFoIHRoYXQncyBhIG1hc3NpdmUgY2FuIG9mIHdvcm1zLiBCdXQgbHVja2lseSB0
aGVyZSdzIG5vIHN1Y2ggZHJpdmVyCj4+IG1lcmdlZCBpbiB1cHN0cmVhbSwgc28gaG9wZWZ1bGx5
IHdlIGNhbiB0aGluayBhYm91dCBhbGwgdGhlCj4+IGNvbnN0cmFpbnRzIGFuZCBob3cgdG8gYmVz
dCBhbm5vdGF0ZSZlbmZvcmNlIHRoaXMgYmVmb3JlIHdlIGxhbmQgYW55Cj4+IGNvZGUgYW5kIGhh
dmUgYmlnIHJlZ3JldHMuCj4KPiBEbyB5b3Ugd2FudCBhIGJhZCBuZXdzPyBJIG9uY2UgbWFkZSBh
IHByb3RvdHlwZSBmb3IgdGhhdCB3aGVuIFZlZ2ExMCAKPiBjYW1lIG91dC4KPgo+IEJ1dCB3ZSBh
YmFuZG9uZWQgdGhpcyBhcHByb2FjaCBmb3IgdGhlIHRoZSBiYXRjaCBiYXNlZCBhcHByb2FjaCAK
PiBiZWNhdXNlIG9mIHRoZSBob3JyaWJsZSBwZXJmb3JtYW5jZS4KCkluIGNvbnRleHQgb2YgdGhl
IHByZXZpb3VzIGRpc2N1c3Npb24gSSdkIGNvbnNpZGVyIHRoZSBmYWN0IHRoYXQgaXQncyAKbm90
IHBlcmZvcm1hbnQgaW4gdGhlIGJhdGNoLWJhc2VkIG1vZGVsIGdvb2QgbmV3cyA6KQoKVGhvbWFz
CgoKPgo+IEtGRCBpcyBnb2luZyB0byBzZWUgdGhhdCwgYnV0IHRoaXMgaXMgb25seSB3aXRoIHVz
ZXIgcXVldWVzIGFuZCBubyAKPiBkbWFfZmVuY2UgaW52b2x2ZWQgd2hhdHNvZXZlci4KPgo+IENo
cmlzdGlhbi4KPgo+PiAtRGFuaWVsCj4+Cj4+Cj4+Cj4+IC0tIAo+PiBEYW5pZWwgVmV0dGVyCj4+
IFNvZnR3YXJlIEVuZ2luZWVyLCBJbnRlbCBDb3Jwb3JhdGlvbgo+PiBodHRwOi8vYmxvZy5mZnds
bC5jaAo+PiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+
PiBhbWQtZ2Z4IG1haWxpbmcgbGlzdAo+PiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+
PiBodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
