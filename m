Return-Path: <SRS0=J3+H=CZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88660C433E2
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Sep 2020 03:34:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4FD320731
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Sep 2020 03:34:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4FD320731
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F354D6E250;
	Wed, 16 Sep 2020 03:34:21 +0000 (UTC)
Received: from huawei.com (szxga07-in.huawei.com [45.249.212.35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 94A4C6E25E
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Sep 2020 01:03:03 +0000 (UTC)
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 133C0BC8F5F0FC6E1F39;
 Wed, 16 Sep 2020 09:02:56 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.487.0; Wed, 16 Sep 2020
 09:02:50 +0800
From: Ye Bin <yebin10@huawei.com>
To: <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
 <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/display: Remove set but used 'temp'
Date: Wed, 16 Sep 2020 09:08:58 +0800
Message-ID: <20200916010858.83903-1-yebin10@huawei.com>
X-Mailer: git-send-email 2.16.2.dirty
MIME-Version: 1.0
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
X-Mailman-Approved-At: Wed, 16 Sep 2020 03:34:20 +0000
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
Cc: Ye Bin <yebin10@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QWRkcmVzc2VzIHRoZSBmb2xsb3dpbmcgZ2NjIHdhcm5pbmcgd2l0aCAibWFrZSBXPTEiOgoKSW4g
ZmlsZSBpbmNsdWRlZCBmcm9tIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1Ly4uL2Rpc3BsYXkv
ZG11Yi9zcmMvLi4vZG11Yl9zcnYuaDo2NzowLAoJZnJvbSBkcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS8uLi9kaXNwbGF5L2RtdWIvc3JjL2RtdWJfZGNuMjEuYzoyNjoKZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvLi4vZGlzcGxheS9kbXViL3NyYy8uLi9pbmMvZG11Yl9jbWQuaDogSW4gZnVu
Y3Rpb24g4oCYZG11Yl9yYl9mbHVzaF9wZW5kaW5n4oCZOgpkcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS8uLi9kaXNwbGF5L2RtdWIvc3JjLy4uL2luYy9kbXViX2NtZC5oOjc5NToxMjogd2Fybmlu
ZzogdmFyaWFibGUg4oCYdGVtcOKAmSBzZXQgYnV0IG5vdCB1c2VkCiBbLVd1bnVzZWQtYnV0LXNl
dC12YXJpYWJsZV0KICAgIHVpbnQ2NF90IHRlbXA7CiAgICAgICAgICAgICAgICBeCkluIGZpbGUg
aW5jbHVkZWQgZnJvbSBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS8uLi9kaXNwbGF5L2RtdWIv
c3JjLy4uL2RtdWJfc3J2Lmg6Njc6MCwKICAgICAgICAgICAgICAgICBmcm9tIGRyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1Ly4uL2Rpc3BsYXkvZG11Yi9zcmMvZG11Yl9kY24zMC5jOjI2Ogpkcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS8uLi9kaXNwbGF5L2RtdWIvc3JjLy4uL2luYy9kbXViX2Nt
ZC5oOiBJbiBmdW5jdGlvbiDigJhkbXViX3JiX2ZsdXNoX3BlbmRpbmfigJk6CmRyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1Ly4uL2Rpc3BsYXkvZG11Yi9zcmMvLi4vaW5jL2RtdWJfY21kLmg6Nzk1
OjEyOiB3YXJuaW5nOiB2YXJpYWJsZSDigJh0ZW1w4oCZIHNldCBidXQgbm90IHVzZWQKWy1XdW51
c2VkLWJ1dC1zZXQtdmFyaWFibGVdCiAgIHVpbnQ2NF90IHRlbXA7CgpSZXBvcnRlZC1ieTogSHVs
ayBSb2JvdCA8aHVsa2NpQGh1YXdlaS5jb20+ClNpZ25lZC1vZmYtYnk6IFllIEJpbiA8eWViaW4x
MEBodWF3ZWkuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kbXViL2luYy9k
bXViX2NtZC5oIHwgNCArLS0tCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDMgZGVs
ZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RtdWIv
aW5jL2RtdWJfY21kLmggYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZG11Yi9pbmMvZG11
Yl9jbWQuaAppbmRleCBkN2U3ZjJlZGE5MmYuLmUzMjgyOGZmYzNlMCAxMDA2NDQKLS0tIGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RtdWIvaW5jL2RtdWJfY21kLmgKKysrIGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RtdWIvaW5jL2RtdWJfY21kLmgKQEAgLTc5MSwxMiArNzkx
LDEwIEBAIHN0YXRpYyBpbmxpbmUgdm9pZCBkbXViX3JiX2ZsdXNoX3BlbmRpbmcoY29uc3Qgc3Ry
dWN0IGRtdWJfcmIgKnJiKQogCiAJd2hpbGUgKHJwdHIgIT0gd3B0cikgewogCQl1aW50NjRfdCB2
b2xhdGlsZSAqZGF0YSA9ICh1aW50NjRfdCB2b2xhdGlsZSAqKXJiLT5iYXNlX2FkZHJlc3MgKyBy
cHRyIC8gc2l6ZW9mKHVpbnQ2NF90KTsKLQkJLy91aW50NjRfdCB2b2xhdGlsZSAqcCA9ICh1aW50
NjRfdCB2b2xhdGlsZSAqKWRhdGE7Ci0JCXVpbnQ2NF90IHRlbXA7CiAJCWludCBpOwogCiAJCWZv
ciAoaSA9IDA7IGkgPCBETVVCX1JCX0NNRF9TSVpFIC8gc2l6ZW9mKHVpbnQ2NF90KTsgaSsrKQot
CQkJdGVtcCA9ICpkYXRhKys7CisJCQkqZGF0YSsrOwogCiAJCXJwdHIgKz0gRE1VQl9SQl9DTURf
U0laRTsKIAkJaWYgKHJwdHIgPj0gcmItPmNhcGFjaXR5KQotLSAKMi4xNi4yLmRpcnR5CgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxp
bmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVk
ZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
