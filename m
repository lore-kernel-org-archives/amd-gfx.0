Return-Path: <SRS0=KKXi=LR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 558C7C4743C
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Jun 2021 06:53:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24D0361003
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Jun 2021 06:53:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24D0361003
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daenzer.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DA81F6E25B;
	Wed, 23 Jun 2021 06:53:37 +0000 (UTC)
Received: from netline-mail3.netline.ch (mail.netline.ch [148.251.143.180])
 by gabe.freedesktop.org (Postfix) with ESMTP id 9F88E6E25B
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Jun 2021 06:53:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by netline-mail3.netline.ch (Postfix) with ESMTP id A84B520201B;
 Wed, 23 Jun 2021 08:53:35 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at netline-mail3.netline.ch
Received: from netline-mail3.netline.ch ([127.0.0.1])
 by localhost (netline-mail3.netline.ch [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id HR9byqvK2Iwt; Wed, 23 Jun 2021 08:53:35 +0200 (CEST)
Received: from thor (24.99.2.85.dynamic.wline.res.cust.swisscom.ch
 [85.2.99.24])
 by netline-mail3.netline.ch (Postfix) with ESMTPA id 6776220201A;
 Wed, 23 Jun 2021 08:53:35 +0200 (CEST)
Received: from localhost ([::1]) by thor with esmtp (Exim 4.94.2)
 (envelope-from <michel@daenzer.net>)
 id 1lvwlS-000kJm-JL; Wed, 23 Jun 2021 08:53:34 +0200
Subject: Re: [PATCH V3 1/7] drm/amdgpu: correct tcp harvest setting
To: "Lazar, Lijo" <lijo.lazar@amd.com>, "Quan, Evan" <Evan.Quan@amd.com>
References: <20210621070040.494336-1-evan.quan@amd.com>
 <c4550aab-23b3-fcf9-5fc1-7c129743adb3@amd.com>
 <DM6PR12MB2619DA78289C9BC237FF772AE4099@DM6PR12MB2619.namprd12.prod.outlook.com>
 <CH0PR12MB5348A92078FAAEB0F132A78D97099@CH0PR12MB5348.namprd12.prod.outlook.com>
 <7486e471-4ff9-bfe1-947a-d726b2eadc2d@daenzer.net>
 <71eeee2c-fae7-17b9-f33d-5bb3191fed28@amd.com>
From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>
Message-ID: <99bf255b-b9ed-4809-8129-dbbd8388d7e7@daenzer.net>
Date: Wed, 23 Jun 2021 08:53:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <71eeee2c-fae7-17b9-f33d-5bb3191fed28@amd.com>
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gMjAyMS0wNi0yMiAxMjo0MCBwLm0uLCBMYXphciwgTGlqbyB3cm90ZToKPiBPbiA2LzIyLzIw
MjEgMjo0OSBQTSwgTWljaGVsIETDpG56ZXIgd3JvdGU6Cj4+IE9uIDIwMjEtMDYtMjIgODowOCBh
Lm0uLCBMYXphciwgTGlqbyB3cm90ZToKPj4+IFtQdWJsaWNdCj4+Pgo+Pj4gQUZBSUssIHRoYXQg
ZXhwcmVzc2lvbiBpcyBsZWdhbCAoc29tZSBjb2RlIGFuYWx5emVyIG1heSB3YXJuIG9uIHZhbHVl
IG9mIDQqbWF4X3dncF9wZXJfc2gpOyBzaW1pbGFyIGtpbmQgaXMgdXNlZCBpbiByb3RhdGUgc2hp
ZnQgb3BlcmF0aW9ucy4KPj4KPj4gVGhlIGRlZmF1bHQgdHlwZSBmb3IgY29uc3RhbnRzIGluIEMg
aXMgaW50LCBzbyAweGZmZmZmZmZmIGlzIGEgMzItYml0IHNpZ25lZCBpbnRlZ2VyLgo+IAo+IFBy
b2JhYmx5IG5vdCBhcyBwZXIgc2VjdGlvbiA2LjQuNC4KPiAKPiAiVGhlIHR5cGUgb2YgYW4gaW50
ZWdlciBjb25zdGFudCBpcyB0aGUgZmlyc3Qgb2YgdGhlIGNvcnJlc3BvbmRpbmcgbGlzdCBpbiB3
aGljaCBpdHMgdmFsdWUgY2FuIGJlIHJlcHJlc2VudGVkLiIKPiAKPiBJdCBpcyBhIGhleGFkZWNp
bWFsIGNvbnN0YW50IGFuZCB0aGUgZmlyc3QgdG8gZml0IHRoaXMgdmFsdWUgaXMgdW5zaWduZWQg
aW50LgoKQWgsIGluZGVlZCwgdGhhbmtzLgoKCi0tIApFYXJ0aGxpbmcgTWljaGVsIETDpG56ZXIg
ICAgICAgICAgICAgICB8ICAgICAgICAgICAgICAgaHR0cHM6Ly9yZWRoYXQuY29tCkxpYnJlIHNv
ZnR3YXJlIGVudGh1c2lhc3QgICAgICAgICAgICAgfCAgICAgICAgICAgICBNZXNhIGFuZCBYIGRl
dmVsb3BlcgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwph
bWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczov
L2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
