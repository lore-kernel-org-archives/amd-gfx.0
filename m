Return-Path: <SRS0=2jl+=GO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E6A8C433E0
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Jan 2021 11:52:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90231224BD
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Jan 2021 11:52:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90231224BD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daenzer.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 08DDB89F3C;
	Mon, 11 Jan 2021 11:52:14 +0000 (UTC)
Received: from netline-mail3.netline.ch (mail.netline.ch [148.251.143.178])
 by gabe.freedesktop.org (Postfix) with ESMTP id 960AB89E59
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Jan 2021 11:52:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by netline-mail3.netline.ch (Postfix) with ESMTP id E14F22A6042;
 Mon, 11 Jan 2021 12:52:11 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at netline-mail3.netline.ch
Received: from netline-mail3.netline.ch ([127.0.0.1])
 by localhost (netline-mail3.netline.ch [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id 5rk8souwyV3d; Mon, 11 Jan 2021 12:52:11 +0100 (CET)
Received: from thor (24.99.2.85.dynamic.wline.res.cust.swisscom.ch
 [85.2.99.24])
 by netline-mail3.netline.ch (Postfix) with ESMTPSA id AE1122A6016;
 Mon, 11 Jan 2021 12:52:11 +0100 (CET)
Received: from localhost ([::1]) by thor with esmtp (Exim 4.94)
 (envelope-from <michel@daenzer.net>)
 id 1kyvkC-000YB6-De; Mon, 11 Jan 2021 12:52:11 +0100
Subject: Re: [PATCH v2] drm/amdgpu:Limit the resolution for virtual_display
From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>
To: "Deng, Emily" <Emily.Deng@amd.com>, Alex Deucher <alexdeucher@gmail.com>
References: <20210107032927.660772-1-Emily.Deng@amd.com>
 <BY5PR12MB4115BE023BAF8FE53E2070158FAE0@BY5PR12MB4115.namprd12.prod.outlook.com>
 <CADnq5_N0hYURmnApHxhk3xmY426jyRNCBn97JoNxAq8t3f=Ojw@mail.gmail.com>
 <BY5PR12MB411578DED560A6B45727AA2C8FAB0@BY5PR12MB4115.namprd12.prod.outlook.com>
 <e6fe7c66-6033-9556-dcac-cb5970ce87fe@daenzer.net>
Message-ID: <e21ec168-a4e5-2280-e3bc-42ee11c4476c@daenzer.net>
Date: Mon, 11 Jan 2021 12:52:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <e6fe7c66-6033-9556-dcac-cb5970ce87fe@daenzer.net>
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gMjAyMS0wMS0xMSAxMjo1MCBwLm0uLCBNaWNoZWwgRMOkbnplciB3cm90ZToKPiBPbiAyMDIx
LTAxLTExIDU6NTUgYS5tLiwgRGVuZywgRW1pbHkgd3JvdGU6Cj4+IFtBTUQgT2ZmaWNpYWwgVXNl
IE9ubHkgLSBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0KPj4KPj4gWWVzLCBpdCBqdXN0IHdv
bid0IHJlcG9ydCBiaWdnZXIgdGhhbiAxNjM4NCBtb2RlIHRvIHVzZXIgbW9kZSwgYXMgaXQgCj4+
IHdvbid0IHdvcmsgcHJvcGVybHkuCj4gCj4gLi4uIHdpdGggWG9yZyAvIGdsYW1vci4gSXQgZG9l
c24ndCBhZmZlY3Qgb3RoZXIgdXNlci1zcGFjZS4KCkxldCBtZSByZXBocmFzZTogVGhpcyB3b3Vs
ZCBhcnRpZmljaWFsbHkgbGltaXQgb3RoZXIgdXNlci1zcGFjZS4KCgotLSAKRWFydGhsaW5nIE1p
Y2hlbCBEw6RuemVyICAgICAgICAgICAgICAgfCAgICAgICAgICAgICAgIGh0dHBzOi8vcmVkaGF0
LmNvbQpMaWJyZSBzb2Z0d2FyZSBlbnRodXNpYXN0ICAgICAgICAgICAgIHwgICAgICAgICAgICAg
TWVzYSBhbmQgWCBkZXZlbG9wZXIKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3Rv
cC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQt
Z2Z4Cg==
