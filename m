Return-Path: <SRS0=B7jy=6A=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C440C2BB85
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Apr 2020 09:56:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB8812078B
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Apr 2020 09:56:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB8812078B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daenzer.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E5846E2BD;
	Thu, 16 Apr 2020 09:56:52 +0000 (UTC)
Received: from netline-mail3.netline.ch (mail.netline.ch [148.251.143.178])
 by gabe.freedesktop.org (Postfix) with ESMTP id 6E9F36E2BD
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Apr 2020 09:56:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by netline-mail3.netline.ch (Postfix) with ESMTP id 4F4CC2A6042;
 Thu, 16 Apr 2020 11:56:50 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at netline-mail3.netline.ch
Received: from netline-mail3.netline.ch ([127.0.0.1])
 by localhost (netline-mail3.netline.ch [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id DibL0WAgAd5P; Thu, 16 Apr 2020 11:56:49 +0200 (CEST)
Received: from thor (252.80.76.83.dynamic.wline.res.cust.swisscom.ch
 [83.76.80.252])
 by netline-mail3.netline.ch (Postfix) with ESMTPSA id 6E05D2A6016;
 Thu, 16 Apr 2020 11:56:49 +0200 (CEST)
Received: from localhost ([::1]) by thor with esmtp (Exim 4.93)
 (envelope-from <michel@daenzer.net>)
 id 1jP1GK-001Oxm-EV; Thu, 16 Apr 2020 11:56:48 +0200
Subject: Re: [PATCH] drm/amdgpu: change SH MEM alignment mode for gfx10
To: Likun Gao <likun.gao@amd.com>, =?UTF-8?B?TWFyZWsgT2zFocOhaw==?=
 <maraeo@gmail.com>, Pierre-Eric Pelloux-Prayer <pelloux@gmail.com>
References: <1585909202-1350-1-git-send-email-likun.gao@amd.com>
From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>
Message-ID: <58b63f21-69e7-abd0-8d49-6699e88d172a@daenzer.net>
Date: Thu, 16 Apr 2020 11:56:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <1585909202-1350-1-git-send-email-likun.gao@amd.com>
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
Cc: amd-gfx@lists.freedesktop.org, Hawking Zhang <hawking.zhang@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gMjAyMC0wNC0wMyAxMjoyMCBwLm0uLCBMaWt1biBHYW8gd3JvdGU6Cj4gRnJvbTogTGlrdW4g
R2FvIDxMaWt1bi5HYW9AYW1kLmNvbT4KPiAKPiBDaGFuZ2UgU0hfTUVNX0NPTkZJRyBBbGlnbm1l
bnQgbW9kZSB0byBBdXRvbWF0aWMsIGFzOgo+IDEpT0dMIGZuX2FtZF9jb21wdXRlX3NoYWRlciB3
aWxsIGZhaWxlZCB3aXRoIHVuYWxpZ25lZCBtb2RlLgo+IDIpVGhlIGRlZmF1bHQgYWxpZ25tZW50
IG1vZGUgd2FzIGRlZmluZWQgdG8gYXV0b21hdGljIG9uIGdmeDEwCj4gc3BlY2lmaWNhdGlvbi4K
PiAKPiBTaWduZWQtb2ZmLWJ5OiBMaWt1biBHYW8gPExpa3VuLkdhb0BhbWQuY29tPgo+IC0tLQo+
ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjEwXzAuYyB8IDIgKy0KPiAgMSBmaWxl
IGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCj4gCj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92MTBfMC5jIGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvZ2Z4X3YxMF8wLmMKPiBpbmRleCA1YTY3MzA2Li5kOGYwYzBkIDEwMDY0NAo+
IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92MTBfMC5jCj4gKysrIGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3YxMF8wLmMKPiBAQCAtMjc5LDcgKzI3OSw3IEBA
IHN0YXRpYyBjb25zdCBzdHJ1Y3Qgc29jMTVfcmVnX2dvbGRlbiBnb2xkZW5fc2V0dGluZ3NfZ2Nf
MTBfMV8yX252MTJbXSA9Cj4gIAo+ICAjZGVmaW5lIERFRkFVTFRfU0hfTUVNX0NPTkZJRyBcCj4g
IAkoKFNIX01FTV9BRERSRVNTX01PREVfNjQgPDwgU0hfTUVNX0NPTkZJR19fQUREUkVTU19NT0RF
X19TSElGVCkgfCBcCj4gLQkgKFNIX01FTV9BTElHTk1FTlRfTU9ERV9VTkFMSUdORUQgPDwgU0hf
TUVNX0NPTkZJR19fQUxJR05NRU5UX01PREVfX1NISUZUKSB8IFwKPiArCSAoU0hfTUVNX0FMSUdO
TUVOVF9NT0RFX0RXT1JEIDw8IFNIX01FTV9DT05GSUdfX0FMSUdOTUVOVF9NT0RFX19TSElGVCkg
fCBcCj4gIAkgKFNIX01FTV9SRVRSWV9NT0RFX0FMTCA8PCBTSF9NRU1fQ09ORklHX19SRVRSWV9N
T0RFX19TSElGVCkgfCBcCj4gIAkgKDMgPDwgU0hfTUVNX0NPTkZJR19fSU5JVElBTF9JTlNUX1BS
RUZFVENIX19TSElGVCkpCj4gIAo+IAoKSSBiaXNlY3RlZCBhIGJ1bmNoIG9mIHBpZ2xpdCByZWdy
ZXNzaW9ucyAobW9zdGx5IGhhbGYtZmxvYXQgcmVsYXRlZCwKZS5nLiBkcmF3LXZlcnRpY2VzLWhh
bGYtZmxvYXRfZ2xlczIpIHdpdGggcmFkZW9uc2kgb24gTmF2aSAxMCB0byB0aGlzCmNoYW5nZS4K
CkRvZXMgcmFkZW9uc2kvTExWTSBuZWVkIGNvcnJlc3BvbmRpbmcgY2hhbmdlcz8KCgotLSAKRWFy
dGhsaW5nIE1pY2hlbCBEw6RuemVyICAgICAgICAgICAgICAgfCAgICAgICAgICAgICAgIGh0dHBz
Oi8vcmVkaGF0LmNvbQpMaWJyZSBzb2Z0d2FyZSBlbnRodXNpYXN0ICAgICAgICAgICAgIHwgICAg
ICAgICAgICAgTWVzYSBhbmQgWCBkZXZlbG9wZXIKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5m
cmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0
aW5mby9hbWQtZ2Z4Cg==
