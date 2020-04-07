Return-Path: <SRS0=Z8oe=5X=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD065C2BA16
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Apr 2020 08:33:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 337BF206C0
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Apr 2020 08:33:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 337BF206C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daenzer.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EFC076E5CE;
	Tue,  7 Apr 2020 08:33:45 +0000 (UTC)
Received: from netline-mail3.netline.ch (mail.netline.ch [148.251.143.178])
 by gabe.freedesktop.org (Postfix) with ESMTP id 324CD6E5CE
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Apr 2020 08:33:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by netline-mail3.netline.ch (Postfix) with ESMTP id 568962A6045;
 Tue,  7 Apr 2020 10:33:44 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at netline-mail3.netline.ch
Received: from netline-mail3.netline.ch ([127.0.0.1])
 by localhost (netline-mail3.netline.ch [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id L87-aT5O-lf9; Tue,  7 Apr 2020 10:33:44 +0200 (CEST)
Received: from thor (252.80.76.83.dynamic.wline.res.cust.swisscom.ch
 [83.76.80.252])
 by netline-mail3.netline.ch (Postfix) with ESMTPSA id DE89C2A6042;
 Tue,  7 Apr 2020 10:33:43 +0200 (CEST)
Received: from [::1] by thor with esmtp (Exim 4.93)
 (envelope-from <michel@daenzer.net>)
 id 1jLjfz-000Y75-AP; Tue, 07 Apr 2020 10:33:43 +0200
Subject: Re: [PATCH 30/36] drm/amd/display: Avoid create MST prop after
 registration
To: Alex Deucher <alexdeucher@gmail.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
References: <20200405204115.683559-1-Rodrigo.Siqueira@amd.com>
 <20200405204115.683559-31-Rodrigo.Siqueira@amd.com>
 <e6066d48-7666-50b6-c3c7-0e910b4ba3d4@daenzer.net>
 <20200406184421.ez2tll7llob3s6pb@outlook.office365.com>
 <CADnq5_NBpsW5ZnfiFM3ttmLHPZ7-nZP7AhE098W8Zz=YaOhszQ@mail.gmail.com>
 <20200406185223.abr6gn7onveknnyv@outlook.office365.com>
 <CADnq5_P9ZLo0U-x7TL7REgacRk7ostRqbxV0WT6wa94Dod6t7w@mail.gmail.com>
From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>
Message-ID: <35162aee-91ec-7164-f79e-5d77a5552912@daenzer.net>
Date: Tue, 7 Apr 2020 10:33:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CADnq5_P9ZLo0U-x7TL7REgacRk7ostRqbxV0WT6wa94Dod6t7w@mail.gmail.com>
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
Cc: "Leo \(Sunpeng\) Li" <Sunpeng.Li@amd.com>, "Wentland,
 Harry" <Harry.Wentland@amd.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>,
 "Jerry \(Fangzhi\) Zuo" <Jerry.Zuo@amd.com>, Hersen Wu <hersenxs.wu@amd.com>,
 Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gMjAyMC0wNC0wNiA4OjU0IHAubS4sIEFsZXggRGV1Y2hlciB3cm90ZToKPiBPbiBNb24sIEFw
ciA2LCAyMDIwIGF0IDI6NTIgUE0gUm9kcmlnbyBTaXF1ZWlyYQo+IDxSb2RyaWdvLlNpcXVlaXJh
QGFtZC5jb20+IHdyb3RlOgo+Pgo+PiBPaywgSSdsbCBqdXN0IHB1c2ggdGhlIHBhdGNoIHRvIG91
ciByZXBvc2l0b3J5Lgo+IAo+IFNvdW5kcyBnb29kLiAgUGxlYXNlIG5vdGUgdGhlIG90aGVyIGlz
c3VlIE1pY2hlbCBtZW50aW9uZWQgYmVsb3cuICBXZQo+IG5lZWQgYSBmaXggZm9yIHRoYXQgYXMg
d2VsbCBmb3IgNS43LgoKVGhhdCdsbCBiZSBncmVhdCwgdGhhbmtzIQoKCi0tIApFYXJ0aGxpbmcg
TWljaGVsIETDpG56ZXIgICAgICAgICAgICAgICB8ICAgICAgICAgICAgICAgaHR0cHM6Ly9yZWRo
YXQuY29tCkxpYnJlIHNvZnR3YXJlIGVudGh1c2lhc3QgICAgICAgICAgICAgfCAgICAgICAgICAg
ICBNZXNhIGFuZCBYIGRldmVsb3BlcgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNr
dG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Ft
ZC1nZngK
