Return-Path: <SRS0=ysjs=55=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C4B3C352B6
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Apr 2020 14:06:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2DAB02075E
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Apr 2020 14:06:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DAB02075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC9A289C8D;
	Mon, 13 Apr 2020 14:06:46 +0000 (UTC)
Received: from huawei.com (szxga07-in.huawei.com [45.249.212.35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A608889C1C;
 Mon, 13 Apr 2020 14:06:29 +0000 (UTC)
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id DAA1B5009B9C567DB427;
 Mon, 13 Apr 2020 22:06:25 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.487.0; Mon, 13 Apr 2020
 22:06:17 +0800
From: Jason Yan <yanaijie@huawei.com>
To: <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
 <David1.Zhou@amd.com>, <airlied@linux.ie>, <daniel@ffwll.ch>,
 <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>
Subject: [PATCH] drm/radeon: remove defined but not used 'dte_data_tahiti_le'
Date: Mon, 13 Apr 2020 22:32:45 +0800
Message-ID: <20200413143245.23107-1-yanaijie@huawei.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
X-Mailman-Approved-At: Mon, 13 Apr 2020 14:06:45 +0000
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
Cc: Hulk Robot <hulkci@huawei.com>, Jason Yan <yanaijie@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Rml4IHRoZSBmb2xsb3dpbmcgZ2NjIHdhcm5pbmc6Cgpkcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3Np
X2RwbS5jOjI1NTozMzogd2FybmluZzog4oCYZHRlX2RhdGFfdGFoaXRpX2xl4oCZCmRlZmluZWQg
YnV0IG5vdCB1c2VkIFstV3VudXNlZC1jb25zdC12YXJpYWJsZT1dCiBzdGF0aWMgY29uc3Qgc3Ry
dWN0IHNpX2R0ZV9kYXRhIGR0ZV9kYXRhX3RhaGl0aV9sZSA9CgpSZXBvcnRlZC1ieTogSHVsayBS
b2JvdCA8aHVsa2NpQGh1YXdlaS5jb20+ClNpZ25lZC1vZmYtYnk6IEphc29uIFlhbiA8eWFuYWlq
aWVAaHVhd2VpLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3NpX2RwbS5jIHwgMTgg
LS0tLS0tLS0tLS0tLS0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgMTggZGVsZXRpb25zKC0pCgpkaWZm
IC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9zaV9kcG0uYyBiL2RyaXZlcnMvZ3B1L2Ry
bS9yYWRlb24vc2lfZHBtLmMKaW5kZXggMmNiODVkYmU3MjhmLi5hMTY3ZTFjMzZkMjQgMTAwNjQ0
Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vc2lfZHBtLmMKKysrIGIvZHJpdmVycy9ncHUv
ZHJtL3JhZGVvbi9zaV9kcG0uYwpAQCAtMjUyLDI0ICsyNTIsNiBAQCBzdGF0aWMgY29uc3Qgc3Ry
dWN0IHNpX2R0ZV9kYXRhIGR0ZV9kYXRhX3RhaGl0aSA9CiAJZmFsc2UKIH07CiAKLXN0YXRpYyBj
b25zdCBzdHJ1Y3Qgc2lfZHRlX2RhdGEgZHRlX2RhdGFfdGFoaXRpX2xlID0KLXsKLQl7IDB4MUU4
NDgwLCAweDdBMTIwMCwgMHgyMTYwRUMwLCAweDM5Mzg3MDAsIDAgfSwKLQl7IDB4N0QsIDB4N0Qs
IDB4NEU0LCAweEIwMCwgMCB9LAotCTB4NSwKLQkweEFGQzgsCi0JMHg2NCwKLQkweDMyLAotCTEs
Ci0JMCwKLQkweDEwLAotCXsgMHg3OCwgMHg3QywgMHg4MiwgMHg4OCwgMHg4RSwgMHg5NCwgMHg5
QSwgMHhBMCwgMHhBNiwgMHhBQywgMHhCMCwgMHhCNCwgMHhCOCwgMHhCQywgMHhDMCwgMHhDNCB9
LAotCXsgMHgzOTM4NzAwLCAweDM5Mzg3MDAsIDB4MzkzODcwMCwgMHgzOTM4NzAwLCAweDM5Mzg3
MDAsIDB4MzkzODcwMCwgMHgzOTM4NzAwLCAweDM5Mzg3MDAsIDB4MzkzODcwMCwgMHgzOTM4NzAw
LCAweDM5Mzg3MDAsIDB4MzkzODcwMCwgMHgzOTM4NzAwLCAweDM5Mzg3MDAsIDB4MzkzODcwMCwg
MHgzOTM4NzAwIH0sCi0JeyAweDJBRjgsIDB4MkFGOCwgMHgyOUJCLCAweDI3RjksIDB4MjYzNywg
MHgyNDc1LCAweDIyQjMsIDB4MjBGMSwgMHgxRjJGLCAweDFENkQsIDB4MTczNCwgMHgxNDE0LCAw
eDEwRjQsIDB4REQ0LCAweEFCNCwgMHg3OTQgfSwKLQk4NSwKLQl0cnVlCi19OwotCiBzdGF0aWMg
Y29uc3Qgc3RydWN0IHNpX2R0ZV9kYXRhIGR0ZV9kYXRhX3RhaGl0aV9wcm8gPQogewogCXsgMHgx
RTg0ODAsIDB4M0QwOTAwLCAweDk4OTY4MCwgMHgyNjI1QTAwLCAweDAgfSwKLS0gCjIuMjEuMQoK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
