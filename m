Return-Path: <SRS0=nWm5=BC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDE72C433E0
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Jul 2020 13:45:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 616D5207BB
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Jul 2020 13:45:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 616D5207BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 037276E201;
	Thu, 23 Jul 2020 13:45:02 +0000 (UTC)
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E70E96E1D2
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Jul 2020 13:44:22 +0000 (UTC)
Received: from [141.14.220.45] (g45.guest.molgen.mpg.de [141.14.220.45])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id 10D452002EE2B;
 Thu, 23 Jul 2020 15:44:21 +0200 (CEST)
Subject: Re: [PATCH v3 3/3] drm/amdgpu: Change type of module param
 `ppfeaturemask` to hexint
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Alex Deucher <alexander.deucher@amd.com>
References: <20200703142939.28663-1-pmenzel@molgen.mpg.de>
 <20200703142939.28663-3-pmenzel@molgen.mpg.de>
 <50e7239f-9fab-8484-7aec-085acc5ec658@amd.com>
From: Paul Menzel <pmenzel@molgen.mpg.de>
Message-ID: <7e5b2284-0549-185c-4afd-f7d193e2faf9@molgen.mpg.de>
Date: Thu, 23 Jul 2020 15:44:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <50e7239f-9fab-8484-7aec-085acc5ec658@amd.com>
Content-Language: en-US
X-Mailman-Approved-At: Thu, 23 Jul 2020 13:45:01 +0000
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
Cc: linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

RGVhciBMaW51cywgZGVhciBDaHJpc3RpYW4sCgoKQW0gMDMuMDcuMjAgdW0gMTc6Mjkgc2Nocmll
YiBDaHJpc3RpYW4gS8O2bmlnOgo+IEFtIDAzLjA3LjIwIHVtIDE2OjI5IHNjaHJpZWIgUGF1bCBN
ZW56ZWw6Cj4+IFRoZSBuZXdseSBhZGRlZCBoZXhpbnQgaGVscGVyIGlzIG1vcmUgY29udmVuaWVu
dCBmb3IgYml0bWFza3MuCj4+Cj4+IEJlZm9yZToKPj4KPj4gwqDCoMKgwqAgJCBtb3JlIC9zeXMv
bW9kdWxlL2FtZGdwdS9wYXJhbWV0ZXJzL3BwZmVhdHVyZW1hc2sKPj4gwqDCoMKgwqAgNDI5NDk1
MDkxMQo+Pgo+PiBBZnRlcjoKPj4KPj4gwqDCoMKgwqAgJCBtb3JlIC9zeXMvbW9kdWxlL2FtZGdw
dS9wYXJhbWV0ZXJzL3BwZmVhdHVyZW1hc2sKPj4gwqDCoMKgwqAgMHhmZmZmYmZmZgo+Pgo+PiBD
YzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPj4gQ2M6IGxpbnV4LWtlcm5lbEB2Z2Vy
Lmtlcm5lbC5vcmcKPj4gU2lnbmVkLW9mZi1ieTogUGF1bCBNZW56ZWwgPHBtZW56ZWxAbW9sZ2Vu
Lm1wZy5kZT4KPiAKPiBSZXZpZXdlZC1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtv
ZW5pZ0BhbWQuY29tPiBmb3IgdGhpcyBvbmUuCj4gCj4gRmVlbCBmcmVlIHRvIGFkZCBteSBBY2tl
ZC1ieSB0byB0aGUgb3RoZXIgdHdvLCBidXQgSSdtIG5vdCBmYW1pbGlhciAKPiBlbm91Z2ggd2l0
aCB0aGUgY29kZSB0byByZXZpZXcgdGhvc2UuCgpUaGFuayB5b3UuIFNvcnJ5IGZvciBiZWluZyBp
Z25vcmFudCwgYnV0IHdoYXQgaXMgdGhlIHdheSBmb3J3YXJkPwoKCktpbmQgcmVnYXJkcywKClBh
dWwKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdm
eCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0
cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
