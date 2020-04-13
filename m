Return-Path: <SRS0=ysjs=55=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8480FC2BA19
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Apr 2020 09:31:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5AB8720692
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Apr 2020 09:31:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AB8720692
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0EE0589F53;
	Mon, 13 Apr 2020 09:31:28 +0000 (UTC)
Received: from huawei.com (szxga05-in.huawei.com [45.249.212.191])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ECE016E1B2;
 Mon, 13 Apr 2020 07:56:32 +0000 (UTC)
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id ED46456310CE144570DA;
 Mon, 13 Apr 2020 15:56:26 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.487.0; Mon, 13 Apr 2020
 15:56:20 +0800
From: Jason Yan <yanaijie@huawei.com>
To: <harry.wentland@amd.com>, <sunpeng.li@amd.com>,
 <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
 <David1.Zhou@amd.com>, <airlied@linux.ie>, <daniel@ffwll.ch>,
 <Tony.Cheng@amd.com>, <Anthony.Koo@amd.com>, <yanaijie@huawei.com>,
 <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>
Subject: [PATCH] drm/amd/display: code clean up in dce80_hw_sequencer.c
Date: Mon, 13 Apr 2020 16:22:49 +0800
Message-ID: <20200413082249.23271-1-yanaijie@huawei.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
X-Mailman-Approved-At: Mon, 13 Apr 2020 09:31:27 +0000
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
Cc: Hulk Robot <hulkci@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Rml4IHRoZSBmb2xsb3dpbmcgZ2NjIHdhcm5pbmc6Cgpkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS8uLi9kaXNwbGF5L2RjL2RjZTgwL2RjZTgwX2h3X3NlcXVlbmNlci5jOjQzOjQ2Ogp3YXJuaW5n
OiDigJhyZWdfb2Zmc2V0c+KAmSBkZWZpbmVkIGJ1dCBub3QgdXNlZCBbLVd1bnVzZWQtY29uc3Qt
dmFyaWFibGU9XQogc3RhdGljIGNvbnN0IHN0cnVjdCBkY2U4MF9od19zZXFfcmVnX29mZnNldHMg
cmVnX29mZnNldHNbXSA9IHsKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIF5+fn5+fn5+fn5+CgpSZXBvcnRlZC1ieTogSHVsayBSb2JvdCA8aHVsa2NpQGh1YXdl
aS5jb20+ClNpZ25lZC1vZmYtYnk6IEphc29uIFlhbiA8eWFuYWlqaWVAaHVhd2VpLmNvbT4KLS0t
CiAuLi4vYW1kL2Rpc3BsYXkvZGMvZGNlODAvZGNlODBfaHdfc2VxdWVuY2VyLmMgfCAyOCAtLS0t
LS0tLS0tLS0tLS0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgMjggZGVsZXRpb25zKC0pCgpkaWZmIC0t
Z2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjZTgwL2RjZTgwX2h3X3NlcXVl
bmNlci5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjZTgwL2RjZTgwX2h3X3Nl
cXVlbmNlci5jCmluZGV4IDg5MzI2MWM4MTg1NC4uZDJjZWViZGJkZjUxIDEwMDY0NAotLS0gYS9k
cml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNlODAvZGNlODBfaHdfc2VxdWVuY2VyLmMK
KysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjZTgwL2RjZTgwX2h3X3NlcXVl
bmNlci5jCkBAIC0zNiwzNCArMzYsNiBAQAogI2luY2x1ZGUgImRjZS9kY2VfOF8wX2QuaCIKICNp
bmNsdWRlICJkY2UvZGNlXzhfMF9zaF9tYXNrLmgiCiAKLXN0cnVjdCBkY2U4MF9od19zZXFfcmVn
X29mZnNldHMgewotCXVpbnQzMl90IGNydGM7Ci19OwotCi1zdGF0aWMgY29uc3Qgc3RydWN0IGRj
ZTgwX2h3X3NlcV9yZWdfb2Zmc2V0cyByZWdfb2Zmc2V0c1tdID0gewotewotCS5jcnRjID0gKG1t
Q1JUQzBfQ1JUQ19HU0xfQ09OVFJPTCAtIG1tQ1JUQ19HU0xfQ09OVFJPTCksCi19LAotewotCS5j
cnRjID0gKG1tQ1JUQzFfQ1JUQ19HU0xfQ09OVFJPTCAtIG1tQ1JUQ19HU0xfQ09OVFJPTCksCi19
LAotewotCS5jcnRjID0gKG1tQ1JUQzJfQ1JUQ19HU0xfQ09OVFJPTCAtIG1tQ1JUQ19HU0xfQ09O
VFJPTCksCi19LAotewotCS5jcnRjID0gKG1tQ1JUQzNfQ1JUQ19HU0xfQ09OVFJPTCAtIG1tQ1JU
Q19HU0xfQ09OVFJPTCksCi19LAotewotCS5jcnRjID0gKG1tQ1JUQzRfQ1JUQ19HU0xfQ09OVFJP
TCAtIG1tQ1JUQ19HU0xfQ09OVFJPTCksCi19LAotewotCS5jcnRjID0gKG1tQ1JUQzVfQ1JUQ19H
U0xfQ09OVFJPTCAtIG1tQ1JUQ19HU0xfQ09OVFJPTCksCi19Ci19OwotCi0jZGVmaW5lIEhXX1JF
R19DUlRDKHJlZywgaWQpXAotCShyZWcgKyByZWdfb2Zmc2V0c1tpZF0uY3J0YykKLQogLyoqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioKICAqIFByaXZhdGUgZGVmaW5pdGlvbnMKICAqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKiovCi0tIAoyLjIxLjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0
b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1k
LWdmeAo=
