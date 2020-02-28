Return-Path: <SRS0=XGul=4Q=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37627C3F2D2
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Feb 2020 10:05:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BDFB9246A2
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Feb 2020 10:05:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDFB9246A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daenzer.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6BFB4890EF;
	Fri, 28 Feb 2020 10:05:20 +0000 (UTC)
Received: from netline-mail3.netline.ch (mail.netline.ch [148.251.143.178])
 by gabe.freedesktop.org (Postfix) with ESMTP id 0664E890EF
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Feb 2020 10:05:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by netline-mail3.netline.ch (Postfix) with ESMTP id 1C0792A6046;
 Fri, 28 Feb 2020 11:05:18 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at netline-mail3.netline.ch
Received: from netline-mail3.netline.ch ([127.0.0.1])
 by localhost (netline-mail3.netline.ch [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id fAz-rJ3gawAP; Fri, 28 Feb 2020 11:05:17 +0100 (CET)
Received: from thor (252.80.76.83.dynamic.wline.res.cust.swisscom.ch
 [83.76.80.252])
 by netline-mail3.netline.ch (Postfix) with ESMTPSA id 1A6AA2A6016;
 Fri, 28 Feb 2020 11:05:17 +0100 (CET)
Received: from localhost ([::1]) by thor with esmtp (Exim 4.93)
 (envelope-from <michel@daenzer.net>)
 id 1j7cWC-0008e5-Gp; Fri, 28 Feb 2020 11:05:16 +0100
Subject: Re: [PATCH] drm/amd/display: Use after free in dmub_psr_destroy()
To: Dan Carpenter <dan.carpenter@oracle.com>,
 Harry Wentland <harry.wentland@amd.com>, Wyatt Wood <wyatt.wood@amd.com>
References: <20200228080436.rmsqe3ytmxi3bwxn@kili.mountain>
From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>
Message-ID: <cba36257-8562-d14a-da9b-cc38076d350f@daenzer.net>
Date: Fri, 28 Feb 2020 11:05:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200228080436.rmsqe3ytmxi3bwxn@kili.mountain>
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
Cc: "David \(ChunMing\) Zhou" <David1.Zhou@amd.com>,
 Leo Li <sunpeng.li@amd.com>, kernel-janitors@vger.kernel.org,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, amd-gfx@lists.freedesktop.org,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
 Alex Deucher <alexander.deucher@amd.com>,
 Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gMjAyMC0wMi0yOCA5OjIyIGEubS4sIERhbiBDYXJwZW50ZXIgd3JvdGU6Cj4gVGhlc2UgbGlu
ZXMgbmVlZCB0byBiZSByZS1vcmRlcmVkIHNvIHRoYXQgd2UgZG9uJ3QgZGVyZWZlcmVuY2UgImRt
dWIiCj4gYWZ0ZXIgd2UganVzdCBmcmVlZCBpdC4KPiAKPiBGaXhlczogNGMxYTEzMzVkZmUwICgi
ZHJtL2FtZC9kaXNwbGF5OiBEcml2ZXJzaWRlIGNoYW5nZXMgdG8gc3VwcG9ydCBQU1IgaW4gRE1D
VUIiKQo+IFNpZ25lZC1vZmYtYnk6IERhbiBDYXJwZW50ZXIgPGRhbi5jYXJwZW50ZXJAb3JhY2xl
LmNvbT4KPiAtLS0KPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjZS9kbXViX3Bz
ci5jIHwgMiArLQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24o
LSkKPiAKPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjZS9k
bXViX3Bzci5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjZS9kbXViX3Bzci5j
Cj4gaW5kZXggMmM5MzJjMjlmMWY5Li5kYzg1OGIxNTJjNmUgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjZS9kbXViX3Bzci5jCj4gKysrIGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjZS9kbXViX3Bzci5jCj4gQEAgLTIzNSw2ICsyMzUsNiBA
QCBzdHJ1Y3QgZG11Yl9wc3IgKmRtdWJfcHNyX2NyZWF0ZShzdHJ1Y3QgZGNfY29udGV4dCAqY3R4
KQo+ICAgKi8KPiAgdm9pZCBkbXViX3Bzcl9kZXN0cm95KHN0cnVjdCBkbXViX3BzciAqKmRtdWIp
Cj4gIHsKPiAtCWtmcmVlKGRtdWIpOwo+ICAJKmRtdWIgPSBOVUxMOwo+ICsJa2ZyZWUoZG11Yik7
Cj4gIH0KPiAKCk1heWJlCgoJa2ZyZWUoKmRtdWIpOwoKd2FzIGludGVuZGVkIGluc3RlYWQ/CgoK
QWN0dWFsbHksIHRoaXMgZnVuY3Rpb24gYW5kIG90aGVycyBpbiB0aGlzIGZpbGUgc2VlbSBjb21w
bGV0ZWx5IHVudXNlZD8KCgotLSAKRWFydGhsaW5nIE1pY2hlbCBEw6RuemVyICAgICAgICAgICAg
ICAgfCAgICAgICAgICAgICAgIGh0dHBzOi8vcmVkaGF0LmNvbQpMaWJyZSBzb2Z0d2FyZSBlbnRo
dXNpYXN0ICAgICAgICAgICAgIHwgICAgICAgICAgICAgTWVzYSBhbmQgWCBkZXZlbG9wZXIKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWls
aW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVl
ZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
