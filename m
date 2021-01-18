Return-Path: <SRS0=twpl=GV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B888C433DB
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Jan 2021 12:04:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35B4B229C6
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Jan 2021 12:04:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35B4B229C6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD4A489998;
	Mon, 18 Jan 2021 12:04:12 +0000 (UTC)
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A23189998
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Jan 2021 12:04:11 +0000 (UTC)
Received: from [192.168.0.6] (ip5f5aed26.dynamic.kabel-deutschland.de
 [95.90.237.38])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id 84DFA20645D6D;
 Mon, 18 Jan 2021 13:04:09 +0100 (CET)
Subject: Re: [PATCH 16/16] drm/amd/display: 3.2.119
To: Anson Jacob <Anson.Jacob@amd.com>
References: <20210115172714.126866-1-Anson.Jacob@amd.com>
 <20210115172714.126866-17-Anson.Jacob@amd.com>
From: Paul Menzel <pmenzel@molgen.mpg.de>
Message-ID: <02c8ba4b-98a0-2e6e-3190-e7cd8c914b1f@molgen.mpg.de>
Date: Mon, 18 Jan 2021 13:04:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210115172714.126866-17-Anson.Jacob@amd.com>
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
Cc: Aric Cyr <Aric.Cyr@amd.com>, Eryk.Brol@amd.com, Sunpeng.Li@amd.com,
 Bhawanpreet.Lakha@amd.com, Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 amd-gfx@lists.freedesktop.org, Aurabindo.Pillai@amd.com,
 Harry.Wentland@amd.com, bindu.r@amd.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

RGVhciBBbnNvbiwgZGVhciBBcmljLAoKCkFtIDE1LjAxLjIxIHVtIDE4OjI3IHNjaHJpZWIgQW5z
b24gSmFjb2I6Cj4gRnJvbTogQXJpYyBDeXIgPGFyaWMuY3lyQGFtZC5jb20+Cj4gCj4gU2lnbmVk
LW9mZi1ieTogQXJpYyBDeXIgPGFyaWMuY3lyQGFtZC5jb20+Cj4gUmV2aWV3ZWQtYnk6IEFyaWMg
Q3lyIDxBcmljLkN5ckBhbWQuY29tPgo+IEFja2VkLWJ5OiBBbnNvbiBKYWNvYiA8YW5zb24uamFj
b2JAYW1kLmNvbT4KPiAtLS0KPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kYy5o
IHwgMiArLQo+ICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0p
Cgpb4oCmXQoKSSB0aGluaywgSSBhc2sgZm9yIHRoaXMgaW4gdGhlIHBhc3QsIGJ1dCBjb3VsZCB5
b3UgcGxlYXNlIHdyaXRlIAp1bmRlcnN0YW5kYWJsZSBjb21taXQgbWVzc2FnZXM/IEhhdmluZyBh
IG51bWJlciBhcyB0aGUgc3VtbWFyeSBsZWF2ZXMgYSAKbG90IG9mIHJvb20gZm9yIGltcHJvdmVt
ZW50LgoKCktpbmQgcmVnYXJkcywKClBhdWwKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVl
ZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5m
by9hbWQtZ2Z4Cg==
