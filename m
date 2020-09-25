Return-Path: <SRS0=B05q=DC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3479DC4363D
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Sep 2020 15:52:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26FD421741
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Sep 2020 15:52:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26FD421741
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daenzer.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9AD766ED2A;
	Fri, 25 Sep 2020 15:52:54 +0000 (UTC)
Received: from netline-mail3.netline.ch (mail.netline.ch [148.251.143.178])
 by gabe.freedesktop.org (Postfix) with ESMTP id A7DAD6ED2A
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Sep 2020 15:52:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by netline-mail3.netline.ch (Postfix) with ESMTP id 70E2F2A6042;
 Fri, 25 Sep 2020 17:52:52 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at netline-mail3.netline.ch
Received: from netline-mail3.netline.ch ([127.0.0.1])
 by localhost (netline-mail3.netline.ch [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id M_3XALOikWGc; Fri, 25 Sep 2020 17:52:52 +0200 (CEST)
Received: from thor (212.174.63.188.dynamic.wline.res.cust.swisscom.ch
 [188.63.174.212])
 by netline-mail3.netline.ch (Postfix) with ESMTPSA id B8D8D2A6016;
 Fri, 25 Sep 2020 17:52:51 +0200 (CEST)
Received: from localhost ([::1]) by thor with esmtp (Exim 4.94)
 (envelope-from <michel@daenzer.net>)
 id 1kLq1n-000DUk-7r; Fri, 25 Sep 2020 17:52:51 +0200
To: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, amd-gfx@lists.freedesktop.org
References: <20200925145455.2398170-1-Rodrigo.Siqueira@amd.com>
 <20200925145455.2398170-8-Rodrigo.Siqueira@amd.com>
From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>
Subject: Re: [PATCH 7/9] drm/amd/display: Revert check for flip pending before
 locking pipes
Message-ID: <c03bb7fd-09a3-4f1e-b0a5-e7b49d7fc630@daenzer.net>
Date: Fri, 25 Sep 2020 17:52:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.2
MIME-Version: 1.0
In-Reply-To: <20200925145455.2398170-8-Rodrigo.Siqueira@amd.com>
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
Cc: Aric Cyr <Aric.Cyr@amd.com>, Eryk.Brol@amd.com, Sunpeng.Li@amd.com,
 Bhawanpreet.Lakha@amd.com, qingqing.zhuo@amd.com, Aurabindo.Pillai@amd.com,
 Harry.Wentland@amd.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gMjAyMC0wOS0yNSA0OjU0IHAubS4sIFJvZHJpZ28gU2lxdWVpcmEgd3JvdGU6Cj4gRnJvbTog
QXJpYyBDeXIgPGFyaWMuY3lyQGFtZC5jb20+Cj4gCj4gVGhpcyByZXZlcnRzIGNvbW1pdCBlODJk
OGVhZTllODFhZjI0MzI1NmY3MGJlYzU5M2JhZWQ1MGIwYmRiLgoKRXZlcnkgcmV2ZXJ0IHNob3Vs
ZCBleHBsYWluIGluIHRoZSBjb21taXQgbG9nIHdoeSB0aGUgY2hhbmdlIGlzIGJlaW5nIApyZXZl
cnRlZC4gKFlvdXIgZnV0dXJlIHNlbHZlcyBtaWdodCB0aGFuayB5b3UgZm9yIHRoYXQgc29tZWRh
eSA6KQoKCi0tIApFYXJ0aGxpbmcgTWljaGVsIETDpG56ZXIgICAgICAgICAgICAgICB8ICAgICAg
ICAgICAgICAgaHR0cHM6Ly9yZWRoYXQuY29tCkxpYnJlIHNvZnR3YXJlIGVudGh1c2lhc3QgICAg
ICAgICAgICAgfCAgICAgICAgICAgICBNZXNhIGFuZCBYIGRldmVsb3BlcgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAph
bWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
