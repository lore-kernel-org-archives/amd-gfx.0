Return-Path: <SRS0=njeu=7F=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57774C433E0
	for <amd-gfx@archiver.kernel.org>; Sat, 23 May 2020 10:17:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C330920727
	for <amd-gfx@archiver.kernel.org>; Sat, 23 May 2020 10:17:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C330920727
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daenzer.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A55C6E1F1;
	Sat, 23 May 2020 10:17:12 +0000 (UTC)
Received: from netline-mail3.netline.ch (mail.netline.ch [148.251.143.178])
 by gabe.freedesktop.org (Postfix) with ESMTP id 119A66E1F1
 for <amd-gfx@lists.freedesktop.org>; Sat, 23 May 2020 10:17:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by netline-mail3.netline.ch (Postfix) with ESMTP id 494722A604A;
 Sat, 23 May 2020 12:17:10 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at netline-mail3.netline.ch
Received: from netline-mail3.netline.ch ([127.0.0.1])
 by localhost (netline-mail3.netline.ch [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id GtU81RKjU99D; Sat, 23 May 2020 12:17:10 +0200 (CEST)
Received: from thor (252.80.76.83.dynamic.wline.res.cust.swisscom.ch
 [83.76.80.252])
 by netline-mail3.netline.ch (Postfix) with ESMTPSA id 10BB92A6048;
 Sat, 23 May 2020 12:17:10 +0200 (CEST)
Received: from localhost ([::1]) by thor with esmtp (Exim 4.93)
 (envelope-from <michel@daenzer.net>)
 id 1jcRDJ-0009kp-5h; Sat, 23 May 2020 12:17:09 +0200
Subject: Re: slow rx 5600 xt fps
To: Javad Karabi <karabijavad@gmail.com>, Alex Deucher <alexdeucher@gmail.com>
References: <CAEOHGOm=g_VGa5939Qi_HEXAfuUKuy3tXURx9TKg+n==dUDqPQ@mail.gmail.com>
 <CAEOHGOkbu5jy_1_bUD4H0U89YEc_9zOxsSdyZqmtqZNsdOyDkg@mail.gmail.com>
 <CAEOHGOkRYXZWN-20VagBEFFywRT=26xphP3JQeQD4AJuxxzg+Q@mail.gmail.com>
 <CADnq5_Nc+eoCKsQrHA-u0d7trv=MM=5iKv5G1R3TMCyot40OjA@mail.gmail.com>
 <CAEOHGOk-YO_B3gS7WayrBEAO4oxrUAGtR0o9ZzW8ehOypuc1YA@mail.gmail.com>
 <CADnq5_M2R93S6aQn8XtrC_JdHhB=ajC17D780koNvdnDFbWCpA@mail.gmail.com>
 <CAEOHGO=Tgook7i5R5Ucxn3Pg4ovZe+Fak5rntZ2P+UuwDJ+-Vg@mail.gmail.com>
 <CADnq5_Mef-FCri1_wriYgvmnkTNQpxaUfba9_hLSB-yVQHU9cQ@mail.gmail.com>
 <CAEOHGOm+ooti4JX6OD2zd7rOxbAVn1yQ22TwgS0hmiy8Ssf-Kg@mail.gmail.com>
 <CADnq5_O-u_dX84-=y8itZzsrxGLtboBaT5jPY4izzqSjwVtiqg@mail.gmail.com>
 <CAEOHGOmoyyiOSmTPP21mhavJ-qzgPSnWiLb9VFz4z9aSwao3Aw@mail.gmail.com>
 <CADnq5_P9pBvnHjeTDdcocQi1HnK4d6h-a+gsjpgfZ_zEjpDH3g@mail.gmail.com>
 <CAEOHGOmSDy2LRzexvUwqc8R4D5XWHmOO_r+9uh7To6BaH6ik6g@mail.gmail.com>
 <CAEOHGOkFBatRPaskkYv_c84sf-opOFTAi=j=NPj-qOePtdXYXg@mail.gmail.com>
From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>
Message-ID: <dc6af43c-07bb-e334-79f7-80b4cb5135a8@daenzer.net>
Date: Sat, 23 May 2020 12:17:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CAEOHGOkFBatRPaskkYv_c84sf-opOFTAi=j=NPj-qOePtdXYXg@mail.gmail.com>
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gMjAyMC0wNS0yMyAxMjo0OCBhLm0uLCBKYXZhZCBLYXJhYmkgd3JvdGU6Cj4gCj4gYWxzbywg
dGhlIHdob2xlIHRoaW5nIGFib3V0ICJtb25pdG9yIHVwZGF0aW5nIG9uY2UgZXZlcnkgMyBzZWNv
bmRzIgo+IHdoZW4gaSBjbG9zZSB0aGUgbGlkIGlzIGJlY2F1c2UgbXV0dGVyIHdpbGwgZ28gZG93
biB0byAxZnBzIHdoZW4gaXQKPiBkZXRlY3RzIHRoYXQgdGhlIGxpZCBpcyBjbG9zZWQuCgpYb3Jn
J3MgUHJlc2VudCBleHRlbnNpb24gY29kZSBlbmRzIHVwIGRvaW5nIHRoYXQgKGJlY2F1c2UgaXQg
aGFzIG5vCnN1cHBvcnQgZm9yIHNlY29uZGFyeSBHUFVzKSwgbm90IG11dHRlci4KCgotLSAKRWFy
dGhsaW5nIE1pY2hlbCBEw6RuemVyICAgICAgICAgICAgICAgfCAgICAgICAgICAgICAgIGh0dHBz
Oi8vcmVkaGF0LmNvbQpMaWJyZSBzb2Z0d2FyZSBlbnRodXNpYXN0ICAgICAgICAgICAgIHwgICAg
ICAgICAgICAgTWVzYSBhbmQgWCBkZXZlbG9wZXIKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5m
cmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0
aW5mby9hbWQtZ2Z4Cg==
