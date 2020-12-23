Return-Path: <SRS0=7Usp=F3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D25C2C433DB
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Dec 2020 18:38:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95DF622287
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Dec 2020 18:38:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95DF622287
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3112789DBC;
	Wed, 23 Dec 2020 18:38:27 +0000 (UTC)
X-Greylist: delayed 597 seconds by postgrey-1.36 at gabe;
 Wed, 23 Dec 2020 18:38:25 UTC
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9DD0889DBC
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Dec 2020 18:38:25 +0000 (UTC)
Received: from [192.168.0.6] (ip5f5ae91b.dynamic.kabel-deutschland.de
 [95.90.233.27])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id 268EE206466DA
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Dec 2020 19:28:26 +0100 (CET)
To: amd-gfx@lists.freedesktop.org
From: Paul Menzel <pmenzel@molgen.mpg.de>
Subject: Seamless boot/fastboot on AMD Raven
Message-ID: <5ebb89e8-b493-54df-3522-12cb65ec05a0@molgen.mpg.de>
Date: Wed, 23 Dec 2020 19:28:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

RGVhciBBTUQgZm9sa3MsCgoKT24gYSBzeXN0ZW0gd2l0aCBBTUQgUnl6ZW4gMyAyMjAwRyBbMV0g
KFJYIFZlZ2EgOCwgUmF2ZW4sIAoweDEwMDI6MHgxNWRkKSwgTGludXggNS4xMCBzdGlsbCBtYWtl
cyBhIG1vZGVzZXQgYmV0d2VlbiBlbnRlcmluZyB0aGUgCkxVS1MgcGFzc3BocmFzZSBhbmQgR0RN
IGdyYXBoaWNhbCBsb2dpbiBtYW5hZ2VyLiBJcyB0aGVyZSBhIHdheSB0byB1c2UgCnRoZSBmaXJt
d2FyZSByZXNvbHV0aW9uLCB3aGljaCBpcyBlZmlmYiBhbHNvIHVzZXM/IEkgdGhpbmssIEFNROKA
mXMgdGVybSAKZm9yIHRoYXQgaXMgKnNlYW1sZXNzIGJvb3QqLCBhbmQgSW50ZWwgY2FsbHMgaXQg
KmZhc3Rib290KiAKKGBpOTE1LmZhc3Rib290PTFgKS4KCgpLaW5kIHJlZ2FyZHMsCgpQYXVsCgoK
WzFdOiBodHRwczovL2VuLndpa2lwZWRpYS5vcmcvd2lraS9MaXN0X29mX0FNRF9SeXplbl9wcm9j
ZXNzb3JzI0FQVXNfMgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpo
dHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
