Return-Path: <SRS0=9beK=BA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1F42C433E6
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jul 2020 08:47:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75B7B20B1F
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jul 2020 08:47:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=shipmail.org header.i=@shipmail.org header.b="cfyygOmS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75B7B20B1F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=shipmail.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F414D6E50C;
	Tue, 21 Jul 2020 08:47:22 +0000 (UTC)
Received: from ste-pvt-msa1.bahnhof.se (ste-pvt-msa1.bahnhof.se
 [213.80.101.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B0B846E43B;
 Tue, 21 Jul 2020 08:47:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTP id D68C23FA36;
 Tue, 21 Jul 2020 10:47:18 +0200 (CEST)
Authentication-Results: ste-pvt-msa1.bahnhof.se; dkim=pass (1024-bit key;
 unprotected) header.d=shipmail.org header.i=@shipmail.org header.b=cfyygOmS; 
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Received: from ste-pvt-msa1.bahnhof.se ([127.0.0.1])
 by localhost (ste-pvt-msa1.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xxeMSWhjAfgq; Tue, 21 Jul 2020 10:47:17 +0200 (CEST)
Received: from mail1.shipmail.org (h-205-35.A357.priv.bahnhof.se
 [155.4.205.35]) (Authenticated sender: mb878879)
 by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTPA id 7D82A3F9E7;
 Tue, 21 Jul 2020 10:47:15 +0200 (CEST)
Received: from localhost.localdomain (h-205-35.A357.priv.bahnhof.se
 [155.4.205.35])
 by mail1.shipmail.org (Postfix) with ESMTPSA id CC59B36014B;
 Tue, 21 Jul 2020 10:47:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
 t=1595321234; bh=hkvhvfi+JM5OBDtRUXrbQuN3JiHLZIObnsH22OCtN8w=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=cfyygOmSajTjenzL9cXVdGG96y6lgmTbUKCjVuFw82RLrwHeoGBU5cn0KXg8YsS8h
 YKNgp4ieMf+U+RCdhVHHVDMnwiUl/E1dxMV0R8mgb7kxAM5+y+xKebL1Yf3BX4g1hl
 4HmPvZMeCBWn3jekYn0VjQxbnQfT37gTupSD2Mdo=
Subject: Re: [Linaro-mm-sig] [PATCH 1/2] dma-buf.rst: Document why indefinite
 fences are a bad idea
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Daniel Vetter <daniel@ffwll.ch>
References: <20200707201229.472834-4-daniel.vetter@ffwll.ch>
 <20200709123339.547390-1-daniel.vetter@ffwll.ch>
 <93b673b7-bb48-96eb-dc2c-bd4f9304000e@shipmail.org>
 <20200721074157.GB3278063@phenom.ffwll.local>
 <3603bb71-318b-eb53-0532-9daab62dce86@amd.com>
From: =?UTF-8?Q?Thomas_Hellstr=c3=b6m_=28Intel=29?= <thomas_os@shipmail.org>
Message-ID: <57a5eb9d-b74f-8ce4-7199-94e911d9b68b@shipmail.org>
Date: Tue, 21 Jul 2020 10:47:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <3603bb71-318b-eb53-0532-9daab62dce86@amd.com>
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
Cc: Daniel Stone <daniels@collabora.com>, linux-rdma@vger.kernel.org,
 Daniel Vetter <daniel.vetter@ffwll.ch>,
 Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 DRI Development <dri-devel@lists.freedesktop.org>,
 linaro-mm-sig@lists.linaro.org, Steve Pronovost <spronovo@microsoft.com>,
 amd-gfx@lists.freedesktop.org, Jason Ekstrand <jason@jlekstrand.net>,
 Jesse Natalie <jenatali@microsoft.com>,
 Daniel Vetter <daniel.vetter@intel.com>,
 Thomas Hellstrom <thomas.hellstrom@intel.com>,
 Mika Kuoppala <mika.kuoppala@intel.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>, linux-media@vger.kernel.org
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Ck9uIDcvMjEvMjAgOTo0NSBBTSwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToKPiBBbSAyMS4wNy4y
MCB1bSAwOTo0MSBzY2hyaWViIERhbmllbCBWZXR0ZXI6Cj4+IE9uIE1vbiwgSnVsIDIwLCAyMDIw
IGF0IDAxOjE1OjE3UE0gKzAyMDAsIFRob21hcyBIZWxsc3Ryw7ZtIChJbnRlbCkgCj4+IHdyb3Rl
Ogo+Pj4gSGksCj4+Pgo+Pj4gT24gNy85LzIwIDI6MzMgUE0sIERhbmllbCBWZXR0ZXIgd3JvdGU6
Cj4+Pj4gQ29tZXMgdXAgZXZlcnkgZmV3IHllYXJzLCBnZXRzIHNvbWV3aGF0IHRlZGlvdXMgdG8g
ZGlzY3VzcywgbGV0J3MKPj4+PiB3cml0ZSB0aGlzIGRvd24gb25jZSBhbmQgZm9yIGFsbC4KPj4+
Pgo+Pj4+IFdoYXQgSSdtIG5vdCBzdXJlIGFib3V0IGlzIHdoZXRoZXIgdGhlIHRleHQgc2hvdWxk
IGJlIG1vcmUgZXhwbGljaXQgaW4KPj4+PiBmbGF0IG91dCBtYW5kYXRpbmcgdGhlIGFtZGtmZCBl
dmljdGlvbiBmZW5jZXMgZm9yIGxvbmcgcnVubmluZyBjb21wdXRlCj4+Pj4gd29ya2xvYWRzIG9y
IHdvcmtsb2FkcyB3aGVyZSB1c2Vyc3BhY2UgZmVuY2luZyBpcyBhbGxvd2VkLgo+Pj4gQWx0aG91
Z2ggKGluIG15IGh1bWJsZSBvcGluaW9uKSBpdCBtaWdodCBiZSBwb3NzaWJsZSB0byBjb21wbGV0
ZWx5IAo+Pj4gdW50YW5nbGUKPj4+IGtlcm5lbC1pbnRyb2R1Y2VkIGZlbmNlcyBmb3IgcmVzb3Vy
Y2UgbWFuYWdlbWVudCBhbmQgZG1hLWZlbmNlcyB1c2VkIAo+Pj4gZm9yCj4+PiBjb21wbGV0aW9u
LSBhbmQgZGVwZW5kZW5jeSB0cmFja2luZyBhbmQgbGlmdCBhIGxvdCBvZiByZXN0cmljdGlvbnMg
Cj4+PiBmb3IgdGhlCj4+PiBkbWEtZmVuY2VzLCBpbmNsdWRpbmcgcHJvaGliaXRpbmcgaW5maW5p
dGUgb25lcywgSSB0aGluayB0aGlzIG1ha2VzIAo+Pj4gc2Vuc2UKPj4+IGRlc2NyaWJpbmcgdGhl
IGN1cnJlbnQgc3RhdGUuCj4+IFllYWggSSB0aGluayBhIGZ1dHVyZSBwYXRjaCBuZWVkcyB0byB0
eXBlIHVwIGhvdyB3ZSB3YW50IHRvIG1ha2UgdGhhdAo+PiBoYXBwZW4gKGZvciBzb21lIGNyb3Nz
IGRyaXZlciBjb25zaXN0ZW5jeSkgYW5kIHdoYXQgbmVlZHMgdG8gYmUKPj4gY29uc2lkZXJlZC4g
U29tZSBvZiB0aGUgbmVjZXNzYXJ5IHBhcnRzIGFyZSBhbHJlYWR5IHRoZXJlICh3aXRoIGxpa2Ug
dGhlCj4+IHByZWVtcHRpb24gZmVuY2VzIGFtZGtmZCBoYXMgYXMgYW4gZXhhbXBsZSksIGJ1dCBJ
IHRoaW5rIHNvbWUgY2xlYXIgZG9jcwo+PiBvbiB3aGF0J3MgcmVxdWlyZWQgZnJvbSBib3RoIGh3
LCBkcml2ZXJzIGFuZCB1c2Vyc3BhY2Ugd291bGQgYmUgcmVhbGx5Cj4+IGdvb2QuCj4KPiBJJ20g
Y3VycmVudGx5IHdyaXRpbmcgdGhhdCB1cCwgYnV0IHByb2JhYmx5IHN0aWxsIG5lZWQgYSBmZXcg
ZGF5cyBmb3IgCj4gdGhpcy4KCkdyZWF0ISBJIHB1dCBkb3duIHNvbWUgKHZlcnkpIGluaXRpYWwg
dGhvdWdodHMgYSBjb3VwbGUgb2Ygd2Vla3MgYWdvIApidWlsZGluZyBvbiBldmljdGlvbiBmZW5j
ZXMgZm9yIHZhcmlvdXMgaGFyZHdhcmUgY29tcGxleGl0eSBsZXZlbHMgaGVyZToKCmh0dHBzOi8v
Z2l0bGFiLmZyZWVkZXNrdG9wLm9yZy90aG9tYXNoL2RvY3MvLS9ibG9iL21hc3Rlci9VbnRhbmds
aW5nJTIwZG1hLWZlbmNlJTIwYW5kJTIwbWVtb3J5JTIwYWxsb2NhdGlvbi5vZHQKCi9UaG9tYXMK
CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4
IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3Rz
LmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
