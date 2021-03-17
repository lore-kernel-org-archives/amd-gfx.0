Return-Path: <SRS0=2fSF=IP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECEBCC433DB
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Mar 2021 08:41:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D49564ED2
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Mar 2021 08:41:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D49564ED2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daenzer.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D493F6E4F3;
	Wed, 17 Mar 2021 08:41:00 +0000 (UTC)
Received: from netline-mail3.netline.ch (mail.netline.ch [148.251.143.178])
 by gabe.freedesktop.org (Postfix) with ESMTP id C80826E4F3
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Mar 2021 08:40:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by netline-mail3.netline.ch (Postfix) with ESMTP id 2F57A2A6042;
 Wed, 17 Mar 2021 09:40:58 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at netline-mail3.netline.ch
Received: from netline-mail3.netline.ch ([127.0.0.1])
 by localhost (netline-mail3.netline.ch [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id BsNSFyusWOYV; Wed, 17 Mar 2021 09:40:57 +0100 (CET)
Received: from thor (24.99.2.85.dynamic.wline.res.cust.swisscom.ch
 [85.2.99.24])
 by netline-mail3.netline.ch (Postfix) with ESMTPSA id C50632A6016;
 Wed, 17 Mar 2021 09:40:57 +0100 (CET)
Received: from [::1] by thor with esmtp (Exim 4.94)
 (envelope-from <michel@daenzer.net>)
 id 1lMRjd-001mn1-6H; Wed, 17 Mar 2021 09:40:57 +0100
To: Simon Ser <contact@emersion.fr>, Sefa Eyeoglu <contact@scrumplex.net>
References: <20210316215006.18769-1-contact@scrumplex.net>
 <BXflth5n3xasxoEuCG2MmbmwEVxpajiLTSqLdyoFxMsugaQUqpvAvZENKxcrhoHY1z0D0NkWBxQa83qUOm8Eg5EOLUhbWoQ7P7y5iblbLwg=@emersion.fr>
From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>
Subject: Re: [PATCH] drm/amd/display: check fb of primary plane
Message-ID: <ba88fbc4-d293-3594-5822-1bc5026e8f69@daenzer.net>
Date: Wed, 17 Mar 2021 09:40:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <BXflth5n3xasxoEuCG2MmbmwEVxpajiLTSqLdyoFxMsugaQUqpvAvZENKxcrhoHY1z0D0NkWBxQa83qUOm8Eg5EOLUhbWoQ7P7y5iblbLwg=@emersion.fr>
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gMjAyMS0wMy0xNyA5OjI5IGEubS4sIFNpbW9uIFNlciB3cm90ZToKPiBPbiBUdWVzZGF5LCBN
YXJjaCAxNnRoLCAyMDIxIGF0IDEwOjUwIFBNLCBTZWZhIEV5ZW9nbHUgPGNvbnRhY3RAc2NydW1w
bGV4Lm5ldD4gd3JvdGU6Cj4gCj4+IFNvbWV0aW1lcyB0aGUgcHJpbWFyeSBwbGFuZSBtaWdodCBu
b3QgYmUgaW5pdGlhbGl6ZWQgKHlldCksIHdoaWNoCj4+IGNhdXNlcyBkbV9jaGVja19jcnRjX2N1
cnNvciB0byBkaXZpZGUgYnkgemVyby4KPj4gQXBwYXJlbnRseSBhIHdlaXJkIHN0YXRlIGJlZm9y
ZSBhIFMzLXN1c3BlbmQgY2F1c2VzIHRoZSBhZm9yZW1lbnRpb25lZAo+PiBkaXZpZGUtYnktemVy
byBlcnJvciB3aGVuIHJlc3VtaW5nIGZyb20gUzMuICBUaGlzIHdhcyBleHBsYWluZWQgaW4KPj4g
YnVnIDIxMjI5MyBvbiBCdWd6aWxsYS4KPj4KPj4gVG8gYXZvaWQgdGhpcyBkaXZpZGUtYnktemVy
byBlcnJvciB3ZSBjaGVjayBpZiB0aGUgcHJpbWFyeSBwbGFuZSdzIGZiCj4+IGlzbid0IE5VTEwu
ICBJZiBpdCdzIE5VTEwgdGhlIHNyY193IGFuZCBzcmNfaCBhdHRyaWJ1dGVzIHdpbGwgYmUgMCwK
Pj4gd2hpY2ggd291bGQgY2F1c2UgYSBkaXZpZGUtYnktemVyby4KPj4KPj4gVGhpcyBmaXhlcyBC
dWd6aWxsYSByZXBvcnQgMjEyMjkzCj4+IGh0dHBzOi8vYnVnemlsbGEua2VybmVsLm9yZy9zaG93
X2J1Zy5jZ2k/aWQ9MjEyMjkzCj4+Cj4+IEZpeGVzOiAxMmY0ODQ5YTFjZmQ2OWYzICgiZHJtL2Ft
ZC9kaXNwbGF5OiBjaGVjayBjdXJzb3Igc2NhbGluZyIpCj4+IFNpZ25lZC1vZmYtYnk6IFNlZmEg
RXllb2dsdSA8Y29udGFjdEBzY3J1bXBsZXgubmV0Pgo+IAo+IFRoYW5rcyBmb3IgdGhlIGZpeCEg
SW4gdGhlb3J5IHdlIHNob3VsZCByZXR1cm4gLUVJTlZBTCBoZXJlLCBiZWNhdXNlIHdlIGNhbid0
Cj4gZW5hYmxlIHRoZSBjdXJzb3IgcGxhbmUgd2l0aG91dCB0aGUgcHJpbWFyeSBwbGFuZS4gQnV0
IHRoYXQgd291bGQgYnJlYWsgdGhlCj4gbGVnYWN5IEFQSSB0cmFuc2xhdGlvbiBsYXllciBpbiBE
Uk0gY29yZSwgd2hpY2ggZXhwZWN0cyB0aGF0IHBsYW5lcyBjYW4gYWx3YXlzCj4gYmUgZGlzYWJs
ZWQgaW5kaXZpZHVhbGx5LgoKVGhlIGNvcmUgRFJNIGNvZGUgY2FuIGRlYWwgd2l0aCBiZWluZyB1
bmFibGUgdG8gZW5hYmxlIHRoZSBDUlRDIHdoaWxlIHRoZSBwcmltYXJ5IHBsYW5lIGlzIGRpc2Fi
bGVkLiBJZiB5b3UgaGF2ZSBldmlkZW5jZSB0byB0aGUgY29udHJhcnksIEknZCBsaWtlIHRvIHNl
ZSBpdC4KCgotLSAKRWFydGhsaW5nIE1pY2hlbCBEw6RuemVyICAgICAgICAgICAgICAgfCAgICAg
ICAgICAgICAgIGh0dHBzOi8vcmVkaGF0LmNvbQpMaWJyZSBzb2Z0d2FyZSBlbnRodXNpYXN0ICAg
ICAgICAgICAgIHwgICAgICAgICAgICAgTWVzYSBhbmQgWCBkZXZlbG9wZXIKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QK
YW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5v
cmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
