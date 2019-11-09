Return-Path: <SRS0=+iNy=ZD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E209CC43331
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Nov 2019 08:09:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C17A320818
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Nov 2019 08:09:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C17A320818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 895316E84F;
	Mon, 11 Nov 2019 08:09:42 +0000 (UTC)
Received: from huawei.com (szxga05-in.huawei.com [45.249.212.191])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 959416E190;
 Sat,  9 Nov 2019 09:36:14 +0000 (UTC)
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id A5CC64BCAAA38E2D3A36;
 Sat,  9 Nov 2019 17:36:11 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.439.0; Sat, 9 Nov 2019
 17:36:05 +0800
From: YueHaibing <yuehaibing@huawei.com>
To: <harry.wentland@amd.com>, <sunpeng.li@amd.com>,
 <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
 <David1.Zhou@amd.com>, <airlied@linux.ie>, <daniel@ffwll.ch>,
 <Bhawanpreet.Lakha@amd.com>, <Jun.Lei@amd.com>, <Anthony.Koo@amd.com>,
 <Zhan.Liu@amd.com>
Subject: [PATCH -next] drm/amd/display: remove set but not used variable 'bpc'
Date: Sat, 9 Nov 2019 17:35:38 +0800
Message-ID: <20191109093538.23964-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
X-Mailman-Approved-At: Mon, 11 Nov 2019 08:09:41 +0000
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
Message-ID: <20191109093538.j2FpJgSZhv0wYZQDZNpb8d6pSzmLNP3kUa1VVRtKfhg@z>

Rml4ZXMgZ2NjICctV3VudXNlZC1idXQtc2V0LXZhcmlhYmxlJyB3YXJuaW5nOgoKZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvLi4vZGlzcGxheS9kYy9jb3JlL2RjX2xpbmsuYzogSW4gZnVuY3Rp
b24gZ2V0X3Bibl9mcm9tX3RpbWluZzoKZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvLi4vZGlz
cGxheS9kYy9jb3JlL2RjX2xpbmsuYzoyMzY0OjExOiB3YXJuaW5nOgogdmFyaWFibGUgYnBjIHNl
dCBidXQgbm90IHVzZWQgWy1XdW51c2VkLWJ1dC1zZXQtdmFyaWFibGVdCgpJdCBpcyBub3QgdXNl
ZCBzaW5jZSBjb21taXQgZTQ5ZjY5MzYzYWRmICgiZHJtL2FtZC9kaXNwbGF5OiB1c2UKcHJvcGVy
IGZvcm11bGEgdG8gY2FsY3VsYXRlIGJhbmR3aWR0aCBmcm9tIHRpbWluZyIpCgpTaWduZWQtb2Zm
LWJ5OiBZdWVIYWliaW5nIDx5dWVoYWliaW5nQGh1YXdlaS5jb20+Ci0tLQogZHJpdmVycy9ncHUv
ZHJtL2FtZC9kaXNwbGF5L2RjL2NvcmUvZGNfbGluay5jIHwgMiAtLQogMSBmaWxlIGNoYW5nZWQs
IDIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5
L2RjL2NvcmUvZGNfbGluay5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2NvcmUv
ZGNfbGluay5jCmluZGV4IGJkYzhiZTMuLjUzMzk0ZTIgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvZGlzcGxheS9kYy9jb3JlL2RjX2xpbmsuYworKysgYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL2Rpc3BsYXkvZGMvY29yZS9kY19saW5rLmMKQEAgLTI2NTMsMTMgKzI2NTMsMTEgQEAgc3Rh
dGljIGludCBnZXRfY29sb3JfZGVwdGgoZW51bSBkY19jb2xvcl9kZXB0aCBjb2xvcl9kZXB0aCkK
IAogc3RhdGljIHN0cnVjdCBmaXhlZDMxXzMyIGdldF9wYm5fZnJvbV90aW1pbmcoc3RydWN0IHBp
cGVfY3R4ICpwaXBlX2N0eCkKIHsKLQl1aW50MzJfdCBicGM7CiAJdWludDY0X3Qga2JwczsKIAlz
dHJ1Y3QgZml4ZWQzMV8zMiBwZWFrX2ticHM7CiAJdWludDMyX3QgbnVtZXJhdG9yOwogCXVpbnQz
Ml90IGRlbm9taW5hdG9yOwogCi0JYnBjID0gZ2V0X2NvbG9yX2RlcHRoKHBpcGVfY3R4LT5zdHJl
YW1fcmVzLnBpeF9jbGtfcGFyYW1zLmNvbG9yX2RlcHRoKTsKIAlrYnBzID0gZGNfYmFuZHdpZHRo
X2luX2ticHNfZnJvbV90aW1pbmcoJnBpcGVfY3R4LT5zdHJlYW0tPnRpbWluZyk7CiAKIAkvKgot
LSAKMi43LjQKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRw
czovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
