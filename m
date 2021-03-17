Return-Path: <SRS0=2fSF=IP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62155C433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Mar 2021 11:37:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2671A64F6A
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Mar 2021 11:37:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2671A64F6A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daenzer.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA1146E0D9;
	Wed, 17 Mar 2021 11:37:05 +0000 (UTC)
Received: from netline-mail3.netline.ch (mail.netline.ch [148.251.143.178])
 by gabe.freedesktop.org (Postfix) with ESMTP id 963BA6E0D9
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Mar 2021 11:37:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by netline-mail3.netline.ch (Postfix) with ESMTP id 7A69A2A6042;
 Wed, 17 Mar 2021 12:37:03 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at netline-mail3.netline.ch
Received: from netline-mail3.netline.ch ([127.0.0.1])
 by localhost (netline-mail3.netline.ch [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id uFL5DsX_-bQM; Wed, 17 Mar 2021 12:37:02 +0100 (CET)
Received: from thor (24.99.2.85.dynamic.wline.res.cust.swisscom.ch
 [85.2.99.24])
 by netline-mail3.netline.ch (Postfix) with ESMTPSA id 6010A2A6016;
 Wed, 17 Mar 2021 12:37:02 +0100 (CET)
Received: from [::1] by thor with esmtp (Exim 4.94)
 (envelope-from <michel@daenzer.net>)
 id 1lMUU1-001nxN-Kw; Wed, 17 Mar 2021 12:37:01 +0100
Subject: Re: [PATCH] drm/amd/display: Allow idle optimization based on vblank.
To: Bindu Ramamurthy <bindu.r@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210316234952.254296-1-bindu.r@amd.com>
From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>
Message-ID: <2a8218f2-9df9-d5c3-3a88-7e930a8c8524@daenzer.net>
Date: Wed, 17 Mar 2021 12:37:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210316234952.254296-1-bindu.r@amd.com>
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
Cc: alexander.deucher@amd.com, kenneth.feng@amd.com, tao.zhou1@amd.com,
 Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gMjAyMS0wMy0xNyAxMjo0OSBhLm0uLCBCaW5kdSBSYW1hbXVydGh5IHdyb3RlOgo+IFtXaHld
Cj4gaWRsZSBvcHRpbWl6YXRpb24gd2FzIGJlaW5nIGRpc2FibGVkIGFmdGVyIGNvbW1pdC4KPiAK
PiBbSG93XQo+IGNoZWNrIHZibGFuayBjb3VudCBmb3IgZGlzcGxheSBvZmYgYW5kIGVuYWJsZSBp
ZGxlIG9wdGltaXphdGlvbiBiYXNlZCBvbiB0aGlzIGNvdW50Lgo+IAo+IFNpZ25lZC1vZmYtYnk6
IEJpbmR1IFJhbWFtdXJ0aHkgPGJpbmR1LnJAYW1kLmNvbT4KPiAtLS0KPiAgZHJpdmVycy9ncHUv
ZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG0uYyB8IDcgKysrKystLQo+ICAxIGZp
bGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQo+IAo+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbS5jIGIv
ZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG0uYwo+IGluZGV4
IDU1M2UzOWY5NTM4Yy4uNTZhNTUxNDNhZDJkIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtLmMKPiArKysgYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbS5jCj4gQEAgLTk4Nyw3ICs5ODcsNyBA
QCBzdGF0aWMgdm9pZCBldmVudF9tYWxsX3N0dXR0ZXIoc3RydWN0IHdvcmtfc3RydWN0ICp3b3Jr
KQo+ICAKPiAgCWlmICh2Ymxhbmtfd29yay0+ZW5hYmxlKQo+ICAJCWRtLT5hY3RpdmVfdmJsYW5r
X2lycV9jb3VudCsrOwo+IC0JZWxzZQo+ICsJZWxzZSBpZihkbS0+YWN0aXZlX3ZibGFua19pcnFf
Y291bnQpCj4gIAkJZG0tPmFjdGl2ZV92YmxhbmtfaXJxX2NvdW50LS07CgpUaGUgY29tbWl0IGxv
ZyBzaG91bGQgZXhwbGFpbiB3aHkgdGhpcyBwYXJ0IGlzIG5lZWRlZC4KCgotLSAKRWFydGhsaW5n
IE1pY2hlbCBEw6RuemVyICAgICAgICAgICAgICAgfCAgICAgICAgICAgICAgIGh0dHBzOi8vcmVk
aGF0LmNvbQpMaWJyZSBzb2Z0d2FyZSBlbnRodXNpYXN0ICAgICAgICAgICAgIHwgICAgICAgICAg
ICAgTWVzYSBhbmQgWCBkZXZlbG9wZXIKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVz
a3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9h
bWQtZ2Z4Cg==
