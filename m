Return-Path: <SRS0=mZ+C=IR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC251C433DB
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Mar 2021 10:31:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05AE164F6B
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Mar 2021 10:31:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05AE164F6B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daenzer.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B49A96E9D3;
	Fri, 19 Mar 2021 10:31:24 +0000 (UTC)
Received: from netline-mail3.netline.ch (mail.netline.ch [148.251.143.178])
 by gabe.freedesktop.org (Postfix) with ESMTP id F2C706E9D3
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Mar 2021 10:31:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by netline-mail3.netline.ch (Postfix) with ESMTP id C81FE2A6042;
 Fri, 19 Mar 2021 11:31:22 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at netline-mail3.netline.ch
Received: from netline-mail3.netline.ch ([127.0.0.1])
 by localhost (netline-mail3.netline.ch [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id M7CCx5BtpPd4; Fri, 19 Mar 2021 11:31:22 +0100 (CET)
Received: from thor (24.99.2.85.dynamic.wline.res.cust.swisscom.ch
 [85.2.99.24])
 by netline-mail3.netline.ch (Postfix) with ESMTPA id 4A6F62A6016;
 Fri, 19 Mar 2021 11:31:22 +0100 (CET)
Received: from localhost ([::1]) by thor with esmtp (Exim 4.94)
 (envelope-from <michel@daenzer.net>)
 id 1lNCPZ-0007Ku-Fm; Fri, 19 Mar 2021 11:31:21 +0100
Subject: Re: [PATCH] drm/amd/display: Allow idle optimization based on vblank.
To: "R, Bindu" <Bindu.R@amd.com>,
 "Lakha, Bhawanpreet" <Bhawanpreet.Lakha@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20210316234952.254296-1-bindu.r@amd.com>
 <2a8218f2-9df9-d5c3-3a88-7e930a8c8524@daenzer.net>
 <MW3PR12MB4554B23D18EFB926B9EAFF05F96A9@MW3PR12MB4554.namprd12.prod.outlook.com>
 <DM6PR12MB42677FABD0BB51F870CD9DF4F5689@DM6PR12MB4267.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>
Message-ID: <d28b97df-8bc8-88cb-68aa-d0bd7adc611c@daenzer.net>
Date: Fri, 19 Mar 2021 11:31:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <DM6PR12MB42677FABD0BB51F870CD9DF4F5689@DM6PR12MB4267.namprd12.prod.outlook.com>
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhou1,
 Tao" <Tao.Zhou1@amd.com>, "Feng, Kenneth" <Kenneth.Feng@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gMjAyMS0wMy0xOSAxOjQ0IGEubS4sIFIsIEJpbmR1IHdyb3RlOgo+IAo+IOKAi0hpIEFsbCwK
PiDCoMKgIFRoYW5rcyBmb3IgdGhlIGlucHV0cywgaGF2ZSB1cGRhdGVkIHRoZSBwYXRjaCB0byBp
bmNsdWRlIHRoZXNlIGNoYW5nZXMuCgpVcGRhdGVkIHdoZXJlPyBJIGNhbid0IGZpbmQgYW4gdXBk
YXRlZCBwYXRjaC4KCgotLSAKRWFydGhsaW5nIE1pY2hlbCBEw6RuemVyICAgICAgICAgICAgICAg
fCAgICAgICAgICAgICAgIGh0dHBzOi8vcmVkaGF0LmNvbQpMaWJyZSBzb2Z0d2FyZSBlbnRodXNp
YXN0ICAgICAgICAgICAgIHwgICAgICAgICAgICAgTWVzYSBhbmQgWCBkZXZlbG9wZXIKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5n
IGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVz
a3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
