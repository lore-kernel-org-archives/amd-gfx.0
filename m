Return-Path: <SRS0=4PMp=2I=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 489DCC43603
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Dec 2019 09:58:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 248F02072B
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Dec 2019 09:58:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 248F02072B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daenzer.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B54266E2A9;
	Wed, 18 Dec 2019 09:58:46 +0000 (UTC)
X-Greylist: delayed 384 seconds by postgrey-1.36 at gabe;
 Wed, 18 Dec 2019 09:58:45 UTC
Received: from netline-mail3.netline.ch (mail.netline.ch [148.251.143.178])
 by gabe.freedesktop.org (Postfix) with ESMTP id B4FAC6E2A9
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Dec 2019 09:58:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by netline-mail3.netline.ch (Postfix) with ESMTP id E484C2A6046;
 Wed, 18 Dec 2019 10:52:19 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at netline-mail3.netline.ch
Received: from netline-mail3.netline.ch ([127.0.0.1])
 by localhost (netline-mail3.netline.ch [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id svgeRHm0o1zt; Wed, 18 Dec 2019 10:52:19 +0100 (CET)
Received: from thor (252.80.76.83.dynamic.wline.res.cust.swisscom.ch
 [83.76.80.252])
 by netline-mail3.netline.ch (Postfix) with ESMTPSA id 03FF42A6045;
 Wed, 18 Dec 2019 10:52:18 +0100 (CET)
Received: from localhost ([::1]) by thor with esmtp (Exim 4.93)
 (envelope-from <michel@daenzer.net>)
 id 1ihW0A-000x6B-5f; Wed, 18 Dec 2019 10:52:18 +0100
Subject: Re: [PATCH 2/3] gpu: drm: dead code elimination
To: Pan Zhang <zhangpan26@huawei.com>, hushiyuan@huawei.com,
 alexander.deucher@amd.com, christian.koenig@amd.com, David1.Zhou@amd.com,
 airlied@linux.ie, daniel@ffwll.ch, ray.huang@amd.com, irmoy.das@amd.com,
 sam@ravnborg.org
References: <1576641000-14772-1-git-send-email-zhangpan26@huawei.com>
From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>
Message-ID: <484b831b-671a-12f4-8259-1cb6b75e93e3@daenzer.net>
Date: Wed, 18 Dec 2019 10:52:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <1576641000-14772-1-git-send-email-zhangpan26@huawei.com>
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
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gMjAxOS0xMi0xOCA0OjUwIGEubS4sIFBhbiBaaGFuZyB3cm90ZToKPiB0aGlzIHNldCBhZGRz
IHN1cHBvcnQgZm9yIHJlbW92YWwgb2YgZ3B1IGRybSBkZWFkIGNvZGUuCj4gCj4gcGF0Y2gyOgo+
IGBudW1fZW50cmllc2AgaXMgYSBkYXRhIG9mIHVuc2lnbmVkIHR5cGUoY29tcGlsZXJzIGFsd2F5
cyB0cmVhdCBhcyB1bnNpZ25lZCBpbnQpIGFuZCBTSVpFX01BWCA9PSB+MCwKPiAKPiBzbyB0aGVy
ZSBpcyBhIGltcG9zc2libGUgY29uZGl0aW9uOgo+ICcobnVtX2VudHJpZXMgPiAoKH4wKSAtIDU2
KSAvIDcyKSA9PiAobWF4KDAtdTMyKSA+IDI1NjIwNDc3ODgwMTUyMTU0OSknLgoKV2hpbGUgdGhp
cyBsb29rcyBjb3JyZWN0IGZvciA2NC1iaXQsIHdoZXJlIHNpemVfdCBpcyB1bnNpZ25lZCBsb25n
LCBvbgozMi1iaXQgaXQncyB1bnNpZ25lZCBpbnQsIGluIHdoaWNoIGNhc2UgdGhpcyBpc24ndCBk
ZWFkIGNvZGUuCgoKPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X2JvX2xpc3QuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9ib19saXN0
LmMKPiBpbmRleCA4NWIwNTE1Li4xMGE3ZjMwIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV9ib19saXN0LmMKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfYm9fbGlzdC5jCj4gQEAgLTcxLDEwICs3MSw2IEBAIGludCBhbWRncHVf
Ym9fbGlzdF9jcmVhdGUoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsIHN0cnVjdCBkcm1fZmls
ZSAqZmlscCwKPiAgCXVuc2lnbmVkIGk7Cj4gIAlpbnQgcjsKPiAgCj4gLQlpZiAobnVtX2VudHJp
ZXMgPiAoU0laRV9NQVggLSBzaXplb2Yoc3RydWN0IGFtZGdwdV9ib19saXN0KSkKPiAtCQkJCS8g
c2l6ZW9mKHN0cnVjdCBhbWRncHVfYm9fbGlzdF9lbnRyeSkpCj4gLQkJcmV0dXJuIC1FSU5WQUw7
Cj4gLQo+ICAJc2l6ZSA9IHNpemVvZihzdHJ1Y3QgYW1kZ3B1X2JvX2xpc3QpOwo+ICAJc2l6ZSAr
PSBudW1fZW50cmllcyAqIHNpemVvZihzdHJ1Y3QgYW1kZ3B1X2JvX2xpc3RfZW50cnkpOwo+ICAJ
bGlzdCA9IGt2bWFsbG9jKHNpemUsIEdGUF9LRVJORUwpOwo+IAoKCi0tIApFYXJ0aGxpbmcgTWlj
aGVsIETDpG56ZXIgICAgICAgICAgICAgICB8ICAgICAgICAgICAgICAgaHR0cHM6Ly9yZWRoYXQu
Y29tCkxpYnJlIHNvZnR3YXJlIGVudGh1c2lhc3QgICAgICAgICAgICAgfCAgICAgICAgICAgICBN
ZXNhIGFuZCBYIGRldmVsb3BlcgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1n
ZngK
