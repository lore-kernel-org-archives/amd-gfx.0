Return-Path: <SRS0=tLpO=ZT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3544C432C3
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Nov 2019 17:42:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 963952071E
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Nov 2019 17:42:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 963952071E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3BA796E3F9;
	Wed, 27 Nov 2019 17:42:47 +0000 (UTC)
Received: from huawei.com (szxga04-in.huawei.com [45.249.212.190])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E00326E503;
 Wed, 27 Nov 2019 09:26:32 +0000 (UTC)
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 6F114B967A4AB323AEC8;
 Wed, 27 Nov 2019 17:26:31 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.439.0; Wed, 27 Nov 2019
 17:26:21 +0800
From: zhengbin <zhengbin13@huawei.com>
To: <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
 <David1.Zhou@amd.com>, <airlied@linux.ie>, <daniel@ffwll.ch>,
 <rex.zhu@amd.com>, <evan.quan@amd.com>, <amd-gfx@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>
Subject: [PATCH 5/5] drm/amd/powerplay: Remove unneeded variable 'ret' in
 amdgpu_smu.c
Date: Wed, 27 Nov 2019 17:33:42 +0800
Message-ID: <1574847222-51515-6-git-send-email-zhengbin13@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1574847222-51515-1-git-send-email-zhengbin13@huawei.com>
References: <1574847222-51515-1-git-send-email-zhengbin13@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
X-Mailman-Approved-At: Wed, 27 Nov 2019 17:42:39 +0000
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
Message-ID: <20191127093342.75gnwOrnRiAqS6GGG2RyPxKZte7ZcVB_lc0McphAsWQ@z>

Rml4ZXMgY29jY2ljaGVjayB3YXJuaW5nOgoKZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkv
YW1kZ3B1X3NtdS5jOjExOTI6NS04OiBVbm5lZWRlZCB2YXJpYWJsZTogInJldCIuIFJldHVybiAi
MCIgb24gbGluZSAxMTk1CmRyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2FtZGdwdV9zbXUu
YzoxOTQ1OjUtODogVW5uZWVkZWQgdmFyaWFibGU6ICJyZXQiLiBSZXR1cm4gIjAiIG9uIGxpbmUg
MTk2MQoKUmVwb3J0ZWQtYnk6IEh1bGsgUm9ib3QgPGh1bGtjaUBodWF3ZWkuY29tPgpTaWduZWQt
b2ZmLWJ5OiB6aGVuZ2JpbiA8emhlbmdiaW4xM0BodWF3ZWkuY29tPgotLS0KIGRyaXZlcnMvZ3B1
L2RybS9hbWQvcG93ZXJwbGF5L2FtZGdwdV9zbXUuYyB8IDggKysrLS0tLS0KIDEgZmlsZSBjaGFu
Z2VkLCAzIGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvYW1kZ3B1X3NtdS5jIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9wb3dlcnBsYXkvYW1kZ3B1X3NtdS5jCmluZGV4IDM2MDAxYTQuLjk4NjkxZDQgMTAwNjQ0Ci0t
LSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2FtZGdwdV9zbXUuYworKysgYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9hbWRncHVfc211LmMKQEAgLTExODksMTAgKzExODks
OSBAQCBzdGF0aWMgaW50IHNtdV9mcmVlX21lbW9yeV9wb29sKHN0cnVjdCBzbXVfY29udGV4dCAq
c211KQogewogCXN0cnVjdCBzbXVfdGFibGVfY29udGV4dCAqc211X3RhYmxlID0gJnNtdS0+c211
X3RhYmxlOwogCXN0cnVjdCBzbXVfdGFibGUgKm1lbW9yeV9wb29sID0gJnNtdV90YWJsZS0+bWVt
b3J5X3Bvb2w7Ci0JaW50IHJldCA9IDA7CgogCWlmIChtZW1vcnlfcG9vbC0+c2l6ZSA9PSBTTVVf
TUVNT1JZX1BPT0xfU0laRV9aRVJPKQotCQlyZXR1cm4gcmV0OworCQlyZXR1cm4gMDsKCiAJYW1k
Z3B1X2JvX2ZyZWVfa2VybmVsKCZtZW1vcnlfcG9vbC0+Ym8sCiAJCQkgICAgICAmbWVtb3J5X3Bv
b2wtPm1jX2FkZHJlc3MsCkBAIC0xMjAwLDcgKzExOTksNyBAQCBzdGF0aWMgaW50IHNtdV9mcmVl
X21lbW9yeV9wb29sKHN0cnVjdCBzbXVfY29udGV4dCAqc211KQoKIAltZW1zZXQobWVtb3J5X3Bv
b2wsIDAsIHNpemVvZihzdHJ1Y3Qgc211X3RhYmxlKSk7CgotCXJldHVybiByZXQ7CisJcmV0dXJu
IDA7CiB9Cgogc3RhdGljIGludCBzbXVfc3RhcnRfc21jX2VuZ2luZShzdHJ1Y3Qgc211X2NvbnRl
eHQgKnNtdSkKQEAgLTE5NDIsNyArMTk0MSw2IEBAIGludCBzbXVfd3JpdGVfd2F0ZXJtYXJrc190
YWJsZShzdHJ1Y3Qgc211X2NvbnRleHQgKnNtdSkKIGludCBzbXVfc2V0X3dhdGVybWFya3NfZm9y
X2Nsb2NrX3JhbmdlcyhzdHJ1Y3Qgc211X2NvbnRleHQgKnNtdSwKIAkJc3RydWN0IGRtX3BwX3dt
X3NldHNfd2l0aF9jbG9ja19yYW5nZXNfc29jMTUgKmNsb2NrX3JhbmdlcykKIHsKLQlpbnQgcmV0
ID0gMDsKIAlzdHJ1Y3Qgc211X3RhYmxlICp3YXRlcm1hcmtzID0gJnNtdS0+c211X3RhYmxlLnRh
Ymxlc1tTTVVfVEFCTEVfV0FURVJNQVJLU107CiAJdm9pZCAqdGFibGUgPSB3YXRlcm1hcmtzLT5j
cHVfYWRkcjsKCkBAIC0xOTU4LDcgKzE5NTYsNyBAQCBpbnQgc211X3NldF93YXRlcm1hcmtzX2Zv
cl9jbG9ja19yYW5nZXMoc3RydWN0IHNtdV9jb250ZXh0ICpzbXUsCgogCW11dGV4X3VubG9jaygm
c211LT5tdXRleCk7CgotCXJldHVybiByZXQ7CisJcmV0dXJuIDA7CiB9CgogY29uc3Qgc3RydWN0
IGFtZF9pcF9mdW5jcyBzbXVfaXBfZnVuY3MgPSB7Ci0tCjIuNy40CgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQt
Z2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
