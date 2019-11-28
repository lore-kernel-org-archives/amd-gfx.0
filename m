Return-Path: <SRS0=UwKb=ZU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAD40C432C0
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Nov 2019 08:40:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99DC1216F4
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Nov 2019 08:40:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99DC1216F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 623F86E789;
	Thu, 28 Nov 2019 08:40:43 +0000 (UTC)
Received: from huawei.com (szxga07-in.huawei.com [45.249.212.35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E15816E5EA;
 Thu, 28 Nov 2019 02:24:31 +0000 (UTC)
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id F3C7A9A82D09B260C99F;
 Thu, 28 Nov 2019 10:24:26 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.439.0; Thu, 28 Nov 2019
 10:24:19 +0800
From: zhengbin <zhengbin13@huawei.com>
To: <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
 <David1.Zhou@amd.com>, <airlied@linux.ie>, <daniel@ffwll.ch>,
 <harry.wentland@amd.com>, <sunpeng.li@amd.com>,
 <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>
Subject: [PATCH 4/4] drm/amd/display: Remove unneeded semicolon in
 display_rq_dlg_calc_21.c
Date: Thu, 28 Nov 2019 10:31:40 +0800
Message-ID: <1574908300-126787-5-git-send-email-zhengbin13@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1574908300-126787-1-git-send-email-zhengbin13@huawei.com>
References: <1574908300-126787-1-git-send-email-zhengbin13@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
X-Mailman-Approved-At: Thu, 28 Nov 2019 08:40:40 +0000
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
Cc: zhengbin13@huawei.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191128023140.VM9CX9A2qBXOarvPHTrGvfabX-O49ruADsROk7zte80@z>

Rml4ZXMgY29jY2ljaGVjayB3YXJuaW5nOgoKZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2Rj
L2RtbC9kY24yMS9kaXNwbGF5X3JxX2RsZ19jYWxjXzIxLmM6MTUyNToxNDQtMTQ1OiBVbm5lZWRl
ZCBzZW1pY29sb24KZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RtbC9kY24yMS9kaXNw
bGF5X3JxX2RsZ19jYWxjXzIxLmM6MTUyNjoxNDItMTQzOiBVbm5lZWRlZCBzZW1pY29sb24KClJl
cG9ydGVkLWJ5OiBIdWxrIFJvYm90IDxodWxrY2lAaHVhd2VpLmNvbT4KU2lnbmVkLW9mZi1ieTog
emhlbmdiaW4gPHpoZW5nYmluMTNAaHVhd2VpLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1k
L2Rpc3BsYXkvZGMvZG1sL2RjbjIxL2Rpc3BsYXlfcnFfZGxnX2NhbGNfMjEuYyB8IDQgKystLQog
MSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKCmRpZmYgLS1n
aXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZG1sL2RjbjIxL2Rpc3BsYXlfcnFf
ZGxnX2NhbGNfMjEuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kbWwvZGNuMjEv
ZGlzcGxheV9ycV9kbGdfY2FsY18yMS5jCmluZGV4IGE0YjEwM2UuLmU2MGFmMzggMTAwNjQ0Ci0t
LSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kbWwvZGNuMjEvZGlzcGxheV9ycV9k
bGdfY2FsY18yMS5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kbWwvZGNu
MjEvZGlzcGxheV9ycV9kbGdfY2FsY18yMS5jCkBAIC0xNTIyLDggKzE1MjIsOCBAQCBzdGF0aWMg
dm9pZCBkbWxfcnFfZGxnX2dldF9kbGdfcGFyYW1zKAoKIAlkaXNwX2RsZ19yZWdzLT5yZWZjeWNf
cGVyX3ZtX2dyb3VwX3ZibGFuayAgID0gZ2V0X3JlZmN5Y19wZXJfdm1fZ3JvdXBfdmJsYW5rKG1v
ZGVfbGliLCBlMmVfcGlwZV9wYXJhbSwgbnVtX3BpcGVzLCBwaXBlX2lkeCkgKiByZWZjbGtfZnJl
cV9pbl9taHo7CiAJZGlzcF9kbGdfcmVncy0+cmVmY3ljX3Blcl92bV9ncm91cF9mbGlwICAgICA9
IGdldF9yZWZjeWNfcGVyX3ZtX2dyb3VwX2ZsaXAobW9kZV9saWIsIGUyZV9waXBlX3BhcmFtLCBu
dW1fcGlwZXMsIHBpcGVfaWR4KSAqIHJlZmNsa19mcmVxX2luX21oejsKLQlkaXNwX2RsZ19yZWdz
LT5yZWZjeWNfcGVyX3ZtX3JlcV92YmxhbmsgICAgID0gZ2V0X3JlZmN5Y19wZXJfdm1fcmVxX3Zi
bGFuayhtb2RlX2xpYiwgZTJlX3BpcGVfcGFyYW0sIG51bV9waXBlcywgcGlwZV9pZHgpICogcmVm
Y2xrX2ZyZXFfaW5fbWh6OzsKLQlkaXNwX2RsZ19yZWdzLT5yZWZjeWNfcGVyX3ZtX3JlcV9mbGlw
ICAgICAgID0gZ2V0X3JlZmN5Y19wZXJfdm1fcmVxX2ZsaXAobW9kZV9saWIsIGUyZV9waXBlX3Bh
cmFtLCBudW1fcGlwZXMsIHBpcGVfaWR4KSAqIHJlZmNsa19mcmVxX2luX21oejs7CisJZGlzcF9k
bGdfcmVncy0+cmVmY3ljX3Blcl92bV9yZXFfdmJsYW5rICAgICA9IGdldF9yZWZjeWNfcGVyX3Zt
X3JlcV92YmxhbmsobW9kZV9saWIsIGUyZV9waXBlX3BhcmFtLCBudW1fcGlwZXMsIHBpcGVfaWR4
KSAqIHJlZmNsa19mcmVxX2luX21oejsKKwlkaXNwX2RsZ19yZWdzLT5yZWZjeWNfcGVyX3ZtX3Jl
cV9mbGlwICAgICAgID0gZ2V0X3JlZmN5Y19wZXJfdm1fcmVxX2ZsaXAobW9kZV9saWIsIGUyZV9w
aXBlX3BhcmFtLCBudW1fcGlwZXMsIHBpcGVfaWR4KSAqIHJlZmNsa19mcmVxX2luX21oejsKCiAJ
Ly8gQ2xhbXAgdG8gbWF4IGZvciBub3cKIAlpZiAoZGlzcF9kbGdfcmVncy0+cmVmY3ljX3Blcl92
bV9ncm91cF92YmxhbmsgPj0gKHVuc2lnbmVkIGludClkbWxfcG93KDIsIDIzKSkKLS0KMi43LjQK
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZngg
bWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
