Return-Path: <SRS0=OLW4=ZZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF986C432C0
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Dec 2019 17:12:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5719F20637
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Dec 2019 17:12:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5719F20637
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daenzer.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CDC936E856;
	Tue,  3 Dec 2019 17:12:36 +0000 (UTC)
Received: from netline-mail3.netline.ch (mail.netline.ch [148.251.143.178])
 by gabe.freedesktop.org (Postfix) with ESMTP id 34AEE6E856;
 Tue,  3 Dec 2019 17:12:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by netline-mail3.netline.ch (Postfix) with ESMTP id F36C72A6048;
 Tue,  3 Dec 2019 18:12:34 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at netline-mail3.netline.ch
Received: from netline-mail3.netline.ch ([127.0.0.1])
 by localhost (netline-mail3.netline.ch [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id YS3KumpVu6I8; Tue,  3 Dec 2019 18:12:34 +0100 (CET)
Received: from thor (116.245.63.188.dynamic.wline.res.cust.swisscom.ch
 [188.63.245.116])
 by netline-mail3.netline.ch (Postfix) with ESMTPSA id 85A7F2A6045;
 Tue,  3 Dec 2019 18:12:34 +0100 (CET)
Received: from localhost ([::1]) by thor with esmtp (Exim 4.93-RC4)
 (envelope-from <michel@daenzer.net>)
 id 1icBiz-001LX2-Hx; Tue, 03 Dec 2019 18:12:33 +0100
Subject: Re: [PATCH] drm/radeon: fix r1xx/r2xx register checker for POT
 textures
To: Alex Deucher <alexdeucher@gmail.com>
References: <20191126144310.23717-1-alexander.deucher@amd.com>
From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>
Message-ID: <ff4c26e0-dec1-0784-24fa-53fbe3eea739@daenzer.net>
Date: Tue, 3 Dec 2019 18:12:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191126144310.23717-1-alexander.deucher@amd.com>
Content-Language: en-CA
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Cc: Alex Deucher <alexander.deucher@amd.com>, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gMjAxOS0xMS0yNiAzOjQzIHAubS4sIEFsZXggRGV1Y2hlciB3cm90ZToKPiBTaGlmdCBhbmQg
bWFzayB3ZXJlIHJldmVyc2VkLiAgTm90aWNlZCBieSBjaGFuY2UuCj4gCj4gU2lnbmVkLW9mZi1i
eTogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgo+IC0tLQo+ICBkcml2
ZXJzL2dwdS9kcm0vcmFkZW9uL3IxMDAuYyB8IDQgKystLQo+ICBkcml2ZXJzL2dwdS9kcm0vcmFk
ZW9uL3IyMDAuYyB8IDQgKystLQo+ICAyIGZpbGVzIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwg
NCBkZWxldGlvbnMoLSkKPiAKPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9y
MTAwLmMgYi9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3IxMDAuYwo+IGluZGV4IDcwODlkZmM4YzJh
OS4uMWNjZWU0ZTU4ODBlIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vcjEw
MC5jCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yMTAwLmMKPiBAQCAtMTgyNiw4ICsx
ODI2LDggQEAgc3RhdGljIGludCByMTAwX3BhY2tldDBfY2hlY2soc3RydWN0IHJhZGVvbl9jc19w
YXJzZXIgKnAsCj4gIAkJCXRyYWNrLT50ZXh0dXJlc1tpXS51c2VfcGl0Y2ggPSAxOwo+ICAJCX0g
ZWxzZSB7Cj4gIAkJCXRyYWNrLT50ZXh0dXJlc1tpXS51c2VfcGl0Y2ggPSAwOwo+IC0JCQl0cmFj
ay0+dGV4dHVyZXNbaV0ud2lkdGggPSAxIDw8ICgoaWR4X3ZhbHVlID4+IFJBREVPTl9UWEZPUk1B
VF9XSURUSF9TSElGVCkgJiBSQURFT05fVFhGT1JNQVRfV0lEVEhfTUFTSyk7Cj4gLQkJCXRyYWNr
LT50ZXh0dXJlc1tpXS5oZWlnaHQgPSAxIDw8ICgoaWR4X3ZhbHVlID4+IFJBREVPTl9UWEZPUk1B
VF9IRUlHSFRfU0hJRlQpICYgUkFERU9OX1RYRk9STUFUX0hFSUdIVF9NQVNLKTsKPiArCQkJCQkJ
dHJhY2stPnRleHR1cmVzW2ldLndpZHRoID0gMSA8PCAoKGlkeF92YWx1ZSAmIFJBREVPTl9UWEZP
Uk1BVF9XSURUSF9NQVNLKSA+PiBSQURFT05fVFhGT1JNQVRfV0lEVEhfU0hJRlQpOwoKSW5kZW50
YXRpb24gbG9va3Mgb2ZmIGZvciB0aGlzIGxpbmUuIFdpdGggdGhhdCBmaXhlZCwKClJldmlld2Vk
LWJ5OiBNaWNoZWwgRMOkbnplciA8bWRhZW56ZXJAcmVkaGF0LmNvbT4KCgotLSAKRWFydGhsaW5n
IE1pY2hlbCBEw6RuemVyICAgICAgICAgICAgICAgfCAgICAgICAgICAgICAgIGh0dHBzOi8vcmVk
aGF0LmNvbQpMaWJyZSBzb2Z0d2FyZSBlbnRodXNpYXN0ICAgICAgICAgICAgIHwgICAgICAgICAg
ICAgTWVzYSBhbmQgWCBkZXZlbG9wZXIKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVz
a3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9h
bWQtZ2Z4
