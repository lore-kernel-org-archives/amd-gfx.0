Return-Path: <SRS0=9uSV=II=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7FBDC433DB
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Mar 2021 17:21:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC32864E56
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Mar 2021 17:21:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC32864E56
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daenzer.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A2886E21C;
	Wed, 10 Mar 2021 17:21:07 +0000 (UTC)
Received: from netline-mail3.netline.ch (mail.netline.ch [148.251.143.178])
 by gabe.freedesktop.org (Postfix) with ESMTP id 96E6D6E21C
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Mar 2021 17:21:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by netline-mail3.netline.ch (Postfix) with ESMTP id 96BA12A6045;
 Wed, 10 Mar 2021 18:21:04 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at netline-mail3.netline.ch
Received: from netline-mail3.netline.ch ([127.0.0.1])
 by localhost (netline-mail3.netline.ch [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id mZZR7gIKGeNt; Wed, 10 Mar 2021 18:21:04 +0100 (CET)
Received: from thor (24.99.2.85.dynamic.wline.res.cust.swisscom.ch
 [85.2.99.24])
 by netline-mail3.netline.ch (Postfix) with ESMTPSA id 5EE432A6016;
 Wed, 10 Mar 2021 18:21:04 +0100 (CET)
Received: from [::1] by thor with esmtp (Exim 4.94)
 (envelope-from <michel@daenzer.net>)
 id 1lK2W2-000oM1-0M; Wed, 10 Mar 2021 18:20:58 +0100
To: Simon Ser <contact@emersion.fr>
References: <20210310145019.2877-1-contact@emersion.fr>
From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>
Subject: Re: [PATCH v2 0/5] amd/display: improve atomic cursor checks
Message-ID: <a4fe57bf-33f2-43f5-0170-2135c6a919df@daenzer.net>
Date: Wed, 10 Mar 2021 18:20:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210310145019.2877-1-contact@emersion.fr>
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
Cc: amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gMjAyMS0wMy0xMCAzOjUwIHAubS4sIFNpbW9uIFNlciB3cm90ZToKPiBDaGFuZ2VzIGluIHYy
OiBkcm9wICJhbWQvZGlzcGxheTogZmFpbCBvbiBjdXJzb3IgcGxhbmUgd2l0aG91dCBhbgo+IHVu
ZGVybHlpbmcgcGxhbmUiLiBUaGlzIHJldGFpbnMgdGhlIGN1cnJlbnQgYmVoYXZpb3IgaW5zdGVh
ZC4KClBhdGNoZXMgMiAmIDMgKGFuZCBwb3NzaWJseSA0PyBub3Qgc3VyZSkgd291bGQgc3RpbGwg
Y2F1c2UgdGhlIHNhbWUgaXNzdWUgaW4gdGhlIHNjZW5hcmlvIGRpc2N1c3NlZCBpbiBmb2xsb3ct
dXBzIHRvIHRoZSBkcm9wcGVkIHBhdGNoIChkaXNhYmxpbmcgYW4gQVJHQiBvdmVybGF5IHBsYW5l
IHdpdGggYSBZVVYgcHJpbWFyeSBwbGFuZSBhbmQgdGhlIGN1cnNvciBwbGFuZSBlbmFibGVkKSwg
d291bGRuJ3QgdGhleT8KCgotLSAKRWFydGhsaW5nIE1pY2hlbCBEw6RuemVyICAgICAgICAgICAg
ICAgfCAgICAgICAgICAgICAgIGh0dHBzOi8vcmVkaGF0LmNvbQpMaWJyZSBzb2Z0d2FyZSBlbnRo
dXNpYXN0ICAgICAgICAgICAgIHwgICAgICAgICAgICAgTWVzYSBhbmQgWCBkZXZlbG9wZXIKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWls
aW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVl
ZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
