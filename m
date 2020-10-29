Return-Path: <SRS0=FRS3=EE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DB54C56202
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Oct 2020 13:17:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C32A5207DE
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Oct 2020 13:17:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C32A5207DE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0541A6ECBC;
	Thu, 29 Oct 2020 13:17:02 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C16D16E8AC;
 Thu, 29 Oct 2020 11:48:09 +0000 (UTC)
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
 by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4CMNx14k5pz15NWj;
 Thu, 29 Oct 2020 19:48:05 +0800 (CST)
Received: from linux-lmwb.huawei.com (10.175.103.112) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.487.0; Thu, 29 Oct 2020 19:47:55 +0800
From: Zou Wei <zou_wei@huawei.com>
To: <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
 <airlied@linux.ie>, <daniel@ffwll.ch>
Subject: [PATCH -next] drm/amdgpu/swsmu: Remove unused static struct
 'navi10_i2c_algo'
Date: Thu, 29 Oct 2020 19:59:54 +0800
Message-ID: <1603972794-64534-1-git-send-email-zou_wei@huawei.com>
X-Mailer: git-send-email 2.6.2
MIME-Version: 1.0
X-Originating-IP: [10.175.103.112]
X-CFilter-Loop: Reflected
X-Mailman-Approved-At: Thu, 29 Oct 2020 13:17:01 +0000
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
Cc: Zou Wei <zou_wei@huawei.com>, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Rml4ZXMgdGhlIGZvbGxvd2luZyBXPTEga2VybmVsIGJ1aWxkIHdhcm5pbmcocyk6Cgpkcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS8uLi9wbS9zd3NtdS9zbXUxMS9uYXZpMTBfcHB0LmM6MjUyNzoz
NToKd2FybmluZzog4oCYbmF2aTEwX2kyY19hbGdv4oCZIApkZWZpbmVkIGJ1dCBub3QgdXNlZCBb
LVd1bnVzZWQtY29uc3QtdmFyaWFibGU9XQogc3RhdGljIGNvbnN0IHN0cnVjdCBpMmNfYWxnb3Jp
dGhtIG5hdmkxMF9pMmNfYWxnbyA9IHsKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBefn5+fn5+fn5+fn5+fn4KClJlcG9ydGVkLWJ5OiBIdWxrIFJvYm90IDxodWxrY2lAaHVhd2Vp
LmNvbT4KU2lnbmVkLW9mZi1ieTogWm91IFdlaSA8em91X3dlaUBodWF3ZWkuY29tPgotLS0KIGRy
aXZlcnMvZ3B1L2RybS9hbWQvcG0vc3dzbXUvc211MTEvbmF2aTEwX3BwdC5jIHwgNiAtLS0tLS0K
IDEgZmlsZSBjaGFuZ2VkLCA2IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvcG0vc3dzbXUvc211MTEvbmF2aTEwX3BwdC5jIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9wbS9zd3NtdS9zbXUxMS9uYXZpMTBfcHB0LmMKaW5kZXggZWYxYTYyZS4uYmVjNjNmMiAxMDA2
NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9zd3NtdS9zbXUxMS9uYXZpMTBfcHB0LmMK
KysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9zd3NtdS9zbXUxMS9uYXZpMTBfcHB0LmMKQEAg
LTI1MjMsMTIgKzI1MjMsNiBAQCBzdGF0aWMgdTMyIG5hdmkxMF9pMmNfZnVuYyhzdHJ1Y3QgaTJj
X2FkYXB0ZXIgKmFkYXApCiAJcmV0dXJuIEkyQ19GVU5DX0kyQyB8IEkyQ19GVU5DX1NNQlVTX0VN
VUw7CiB9CiAKLQotc3RhdGljIGNvbnN0IHN0cnVjdCBpMmNfYWxnb3JpdGhtIG5hdmkxMF9pMmNf
YWxnbyA9IHsKLQkubWFzdGVyX3hmZXIgPSBuYXZpMTBfaTJjX3hmZXIsCi0JLmZ1bmN0aW9uYWxp
dHkgPSBuYXZpMTBfaTJjX2Z1bmMsCi19OwotCiBzdGF0aWMgc3NpemVfdCBuYXZpMTBfZ2V0X2dw
dV9tZXRyaWNzKHN0cnVjdCBzbXVfY29udGV4dCAqc211LAogCQkJCSAgICAgIHZvaWQgKip0YWJs
ZSkKIHsKLS0gCjIuNi4yCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9y
ZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
