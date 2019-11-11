Return-Path: <SRS0=+iNy=ZD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41972C43331
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Nov 2019 14:11:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E096204EC
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Nov 2019 14:11:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E096204EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E13196E1F6;
	Mon, 11 Nov 2019 14:11:48 +0000 (UTC)
Received: from huawei.com (unknown [45.249.212.191])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3AC056E915;
 Mon, 11 Nov 2019 13:34:52 +0000 (UTC)
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 312FB89CD03CBF2F7C3C;
 Mon, 11 Nov 2019 21:34:39 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.439.0; Mon, 11 Nov 2019
 21:34:30 +0800
From: YueHaibing <yuehaibing@huawei.com>
To: <harry.wentland@amd.com>, <sunpeng.li@amd.com>,
 <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
 <David1.Zhou@amd.com>, <airlied@linux.ie>, <daniel@ffwll.ch>,
 <Bhawanpreet.Lakha@amd.com>, <Jun.Lei@amd.com>, <David.Francis@amd.com>,
 <Dmytro.Laktyushkin@amd.com>, <nicholas.kazlauskas@amd.com>,
 <martin.leung@amd.com>, <Chris.Park@amd.com>
Subject: [PATCH -next] drm/amd/display: Fix old-style declaration
Date: Mon, 11 Nov 2019 20:28:01 +0800
Message-ID: <20191111122801.18584-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
X-Mailman-Approved-At: Mon, 11 Nov 2019 14:11:47 +0000
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
Cc: YueHaibing <yuehaibing@huawei.com>, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191111122801.qPSjPG75fqYv_gKh9sjkuGy55gY7BtgTSFlcHD2ilqU@z>

Rml4IGEgYnVpbGQgd2FybmluZzoKCmRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1Ly4uL2Rpc3Bs
YXkvZGMvY29yZS9kYy5jOjc1OjE6CiB3YXJuaW5nOiAnc3RhdGljJyBpcyBub3QgYXQgYmVnaW5u
aW5nIG9mIGRlY2xhcmF0aW9uIFstV29sZC1zdHlsZS1kZWNsYXJhdGlvbl0KClNpZ25lZC1vZmYt
Ynk6IFl1ZUhhaWJpbmcgPHl1ZWhhaWJpbmdAaHVhd2VpLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9k
cm0vYW1kL2Rpc3BsYXkvZGMvY29yZS9kYy5jIHwgMiArLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5z
ZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9kaXNwbGF5L2RjL2NvcmUvZGMuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9j
b3JlL2RjLmMKaW5kZXggMWZkYmExMy4uMGQ4YzY2MyAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUv
ZHJtL2FtZC9kaXNwbGF5L2RjL2NvcmUvZGMuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rp
c3BsYXkvZGMvY29yZS9kYy5jCkBAIC02OSw3ICs2OSw3IEBACiAjZGVmaW5lIERDX0xPR0dFUiBc
CiAJZGMtPmN0eC0+bG9nZ2VyCiAKLWNvbnN0IHN0YXRpYyBjaGFyIERDX0JVSUxEX0lEW10gPSAi
cHJvZHVjdGlvbi1idWlsZCI7CitzdGF0aWMgY29uc3QgY2hhciBEQ19CVUlMRF9JRFtdID0gInBy
b2R1Y3Rpb24tYnVpbGQiOwogCiAvKioKICAqIERPQzogT3ZlcnZpZXcKLS0gCjIuNy40CgoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWls
aW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVl
ZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
