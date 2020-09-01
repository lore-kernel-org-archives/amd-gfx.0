Return-Path: <SRS0=dANk=CK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F71BC433E6
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Sep 2020 07:07:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91EFA204EC
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Sep 2020 07:07:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91EFA204EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 401936E22D;
	Tue,  1 Sep 2020 07:07:05 +0000 (UTC)
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 232776E22D
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Sep 2020 07:07:04 +0000 (UTC)
Received: from [192.168.0.2] (ip5f5af668.dynamic.kabel-deutschland.de
 [95.90.246.104])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id 1EC5B2002EE2A;
 Tue,  1 Sep 2020 09:07:02 +0200 (CEST)
Subject: Re: [PATCH 1/1] drm/amdgpu: disable gpu-sched load balance for uvd
To: Nirmoy Das <nirmoy.das@amd.com>, amd-gfx@lists.freedesktop.org
References: <20200831104553.10207-1-nirmoy.das@amd.com>
From: Paul Menzel <pmenzel+amd-gfx@molgen.mpg.de>
Message-ID: <83ada1bd-ced4-8422-f90e-502c30477798@molgen.mpg.de>
Date: Tue, 1 Sep 2020 09:07:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200831104553.10207-1-nirmoy.das@amd.com>
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
Cc: Alexander Deucher <Alexander.Deucher@amd.com>,
 Tianci Yin <Tianci.Yin@amd.com>, Leo Liu <Leo.Liu@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

RGVhciBOaXJtb3ksCgoKQW0gMzEuMDguMjAgdW0gMTI6NDUgc2NocmllYiBOaXJtb3kgRGFzOgo+
IFVWRCBkZXBlbmRlbnQgam9icyBzaG91bGQgcnVuIG9uIHRoZSBzYW1lIHVkdiBpbnN0YW5jZS4K
CldoeT8gRGF0YXNoZWV0PyBQZXJmb3JtYW5jZSByZWFzb25zPyBXaGF0IGhhcHBlbnMgaWYgdGhl
eSBkbyBub3QgcnVuIG9uIAp0aGUgVVZEIGluc3RhbmNlPyBBcmUgdGhlcmUgYnVnIHJlcG9ydHM/
CgpJdOKAmWQgYmUgZ3JlYXQgaWYgeW91IGV4dGVuZGVkIHRoZSBjb21taXQgbWVzc2FnZS4KCj4g
VGhpcyBwYXRjaCBkaXNhYmxlcyBncHUgc2NoZWR1bGVyJ3MgbG9hZCBiYWxhbmNlciBmb3IKPiBh
IGNvbnRleHQgd2hpY2ggYmluZHMgam9icyBmcm9tIHNhbWUgdGhlIGNvbnRleHQgdG8gYSB1ZHYK
PiBpbnN0YW5jZS4KPiAKPiBTaWduZWQtb2ZmLWJ5OiBOaXJtb3kgRGFzIDxuaXJtb3kuZGFzQGFt
ZC5jb20+Cj4gLS0tCj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfY3R4LmMg
fCA0ICsrKy0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24o
LSkKPiAKPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2N0
eC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2N0eC5jCj4gaW5kZXggNTkw
MzJjMjZmYzgyLi43Y2QzOThkMjU0OTggMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X2N0eC5jCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X2N0eC5jCj4gQEAgLTExNCw3ICsxMTQsOSBAQCBzdGF0aWMgaW50IGFtZGdwdV9jdHhf
aW5pdF9lbnRpdHkoc3RydWN0IGFtZGdwdV9jdHggKmN0eCwgdTMyIGh3X2lwLAo+ICAgCXNjaGVk
cyA9IGFkZXYtPmdwdV9zY2hlZFtod19pcF1baHdfcHJpb10uc2NoZWQ7Cj4gICAJbnVtX3NjaGVk
cyA9IGFkZXYtPmdwdV9zY2hlZFtod19pcF1baHdfcHJpb10ubnVtX3NjaGVkczsKPiAKPiAtCWlm
IChod19pcCA9PSBBTURHUFVfSFdfSVBfVkNOX0VOQyB8fCBod19pcCA9PSBBTURHUFVfSFdfSVBf
VkNOX0RFQykgewo+ICsJaWYgKGh3X2lwID09IEFNREdQVV9IV19JUF9WQ05fRU5DIHx8Cj4gKwkg
ICAgaHdfaXAgPT0gQU1ER1BVX0hXX0lQX1ZDTl9ERUMgfHwKPiArCSAgICBod19pcCA9PSBBTURH
UFVfSFdfSVBfVVZEKSB7Cj4gICAJCXNjaGVkID0gZHJtX3NjaGVkX3BpY2tfYmVzdChzY2hlZHMs
IG51bV9zY2hlZHMpOwo+ICAgCQlzY2hlZHMgPSAmc2NoZWQ7Cj4gICAJCW51bV9zY2hlZHMgPSAx
OwoKCktpbmQgcmVnYXJkcywKClBhdWwKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVz
a3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9h
bWQtZ2Z4Cg==
