Return-Path: <SRS0=+iNy=ZD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26154C43331
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Nov 2019 08:09:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0213A20818
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Nov 2019 08:09:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0213A20818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 004746E856;
	Mon, 11 Nov 2019 08:09:43 +0000 (UTC)
Received: from huawei.com (szxga06-in.huawei.com [45.249.212.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 984176E849;
 Mon, 11 Nov 2019 03:38:44 +0000 (UTC)
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 0F3277047B31B4743B1;
 Mon, 11 Nov 2019 11:38:41 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.439.0; Mon, 11 Nov 2019
 11:38:32 +0800
From: zhengbin <zhengbin13@huawei.com>
To: <rex.zhu@amd.com>, <evan.quan@amd.com>, <alexander.deucher@amd.com>,
 <christian.koenig@amd.com>, <David1.Zhou@amd.com>, <airlied@linux.ie>,
 <daniel@ffwll.ch>, <amd-gfx@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amd/powerplay: remove set but not used variable 'data'
Date: Mon, 11 Nov 2019 11:45:56 +0800
Message-ID: <1573443956-76489-3-git-send-email-zhengbin13@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1573443956-76489-1-git-send-email-zhengbin13@huawei.com>
References: <1573443956-76489-1-git-send-email-zhengbin13@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.90.53.225]
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
Cc: zhengbin13@huawei.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191111034556.Vp28esk1uNkR3ZPq7zzA2S1yd7HDYEWqxXNJ74FYE_8@z>

Rml4ZXMgZ2NjICctV3VudXNlZC1idXQtc2V0LXZhcmlhYmxlJyB3YXJuaW5nOgoKZHJpdmVycy9n
cHUvZHJtL2FtZC9wb3dlcnBsYXkvaHdtZ3IvdmVnYTEwX2h3bWdyLmM6IEluIGZ1bmN0aW9uIHZl
Z2ExMF9nZXRfcGVyZm9ybWFuY2VfbGV2ZWw6CmRyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5
L2h3bWdyL3ZlZ2ExMF9od21nci5jOjUyMTc6MjM6IHdhcm5pbmc6IHZhcmlhYmxlIGRhdGEgc2V0
IGJ1dCBub3QgdXNlZCBbLVd1bnVzZWQtYnV0LXNldC12YXJpYWJsZV0KCidkYXRhJyBpcyBpbnRy
b2R1Y2VkIGJ5IGNvbW1pdCBmNjg4YjYxNGI2NDMgKCJkcm0vYW1kL3BwOgpJbXBsZW1lbnQgZ2V0
X3BlcmZvcm1hbmNlX2xldmVsIGZvciBsZWdhY3kgZGdwdSIpLCBidXQgbmV2ZXIgdXNlZCwKc28g
cmVtb3ZlIGl0LgoKUmVwb3J0ZWQtYnk6IEh1bGsgUm9ib3QgPGh1bGtjaUBodWF3ZWkuY29tPgpT
aWduZWQtb2ZmLWJ5OiB6aGVuZ2JpbiA8emhlbmdiaW4xM0BodWF3ZWkuY29tPgotLS0KIGRyaXZl
cnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2h3bWdyL3ZlZ2ExMF9od21nci5jIHwgMiAtLQogMSBm
aWxlIGNoYW5nZWQsIDIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9wb3dlcnBsYXkvaHdtZ3IvdmVnYTEwX2h3bWdyLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L3Bvd2VycGxheS9od21nci92ZWdhMTBfaHdtZ3IuYwppbmRleCBhNGE3Zjg1Li43NzZlNjMyIDEw
MDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9od21nci92ZWdhMTBfaHdt
Z3IuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9od21nci92ZWdhMTBfaHdt
Z3IuYwpAQCAtNTI1MiwxMyArNTI1MiwxMSBAQCBzdGF0aWMgaW50IHZlZ2ExMF9nZXRfcGVyZm9y
bWFuY2VfbGV2ZWwoc3RydWN0IHBwX2h3bWdyICpod21nciwgY29uc3Qgc3RydWN0IHBwXwogCQkJ
CVBITV9QZXJmb3JtYW5jZUxldmVsICpsZXZlbCkKIHsKIAljb25zdCBzdHJ1Y3QgdmVnYTEwX3Bv
d2VyX3N0YXRlICpwczsKLQlzdHJ1Y3QgdmVnYTEwX2h3bWdyICpkYXRhOwogCXVpbnQzMl90IGk7
CgogCWlmIChsZXZlbCA9PSBOVUxMIHx8IGh3bWdyID09IE5VTEwgfHwgc3RhdGUgPT0gTlVMTCkK
IAkJcmV0dXJuIC1FSU5WQUw7CgotCWRhdGEgPSBod21nci0+YmFja2VuZDsKIAlwcyA9IGNhc3Rf
Y29uc3RfcGh3X3ZlZ2ExMF9wb3dlcl9zdGF0ZShzdGF0ZSk7CgogCWkgPSBpbmRleCA+IHBzLT5w
ZXJmb3JtYW5jZV9sZXZlbF9jb3VudCAtIDEgPwotLQoyLjcuNAoKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdm
eEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFp
bG1hbi9saXN0aW5mby9hbWQtZ2Z4
