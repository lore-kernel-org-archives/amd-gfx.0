Return-Path: <SRS0=FndT=ZH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEA67C432C3
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Nov 2019 14:56:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9017620740
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Nov 2019 14:56:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9017620740
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 307396E62E;
	Fri, 15 Nov 2019 14:56:00 +0000 (UTC)
Received: from huawei.com (szxga06-in.huawei.com [45.249.212.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C6B56E53E;
 Fri, 15 Nov 2019 12:05:50 +0000 (UTC)
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id C9DE1C77C573A40A9CDD;
 Fri, 15 Nov 2019 20:05:46 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.439.0; Fri, 15 Nov 2019
 20:05:37 +0800
From: zhengbin <zhengbin13@huawei.com>
To: <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
 <David1.Zhou@amd.com>, <airlied@linux.ie>, <daniel@ffwll.ch>,
 <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>
Subject: [PATCH 2/6] drm/radeon: remove set but not used variable
 'backbias_response_time'
Date: Fri, 15 Nov 2019 20:12:56 +0800
Message-ID: <1573819980-54523-3-git-send-email-zhengbin13@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1573819980-54523-1-git-send-email-zhengbin13@huawei.com>
References: <1573819980-54523-1-git-send-email-zhengbin13@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
X-Mailman-Approved-At: Fri, 15 Nov 2019 14:55:58 +0000
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
Message-ID: <20191115121256.K3GmgtvUiY7kfR0gGg5Dy7oJnQCaDGFOxnOYzvx0KfI@z>

Rml4ZXMgZ2NjICctV3VudXNlZC1idXQtc2V0LXZhcmlhYmxlJyB3YXJuaW5nOgoKZHJpdmVycy9n
cHUvZHJtL3JhZGVvbi9zaV9kcG0uYzogSW4gZnVuY3Rpb24gc2lfcHJvZ3JhbV9yZXNwb25zZV90
aW1lczoKZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9zaV9kcG0uYzozNjQwOjI5OiB3YXJuaW5nOiB2
YXJpYWJsZSBiYWNrYmlhc19yZXNwb25zZV90aW1lIHNldCBidXQgbm90IHVzZWQgWy1XdW51c2Vk
LWJ1dC1zZXQtdmFyaWFibGVdCgpJdCBpcyBpbnRyb2R1Y2VkIGJ5IGNvbW1pdCBhOWU2MTQxMDky
MWIgKCJkcm0vcmFkZW9uL2ttczoKYWRkIGRwbSBzdXBwb3J0IGZvciBTSSAodjcpIiksIGJ1dCBu
ZXZlciB1c2VkLCBzbyByZW1vdmUgaXQuCgpSZXBvcnRlZC1ieTogSHVsayBSb2JvdCA8aHVsa2Np
QGh1YXdlaS5jb20+ClNpZ25lZC1vZmYtYnk6IHpoZW5nYmluIDx6aGVuZ2JpbjEzQGh1YXdlaS5j
b20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9zaV9kcG0uYyB8IDMgKy0tCiAxIGZpbGUg
Y2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJp
dmVycy9ncHUvZHJtL3JhZGVvbi9zaV9kcG0uYyBiL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vc2lf
ZHBtLmMKaW5kZXggYTBiMzgyYS4uODE0OGE3OCAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJt
L3JhZGVvbi9zaV9kcG0uYworKysgYi9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3NpX2RwbS5jCkBA
IC0zNjQwLDE0ICszNjQwLDEzIEBAIHN0YXRpYyBpbnQgc2lfbm90aWZ5X3NtY19kaXNwbGF5X2No
YW5nZShzdHJ1Y3QgcmFkZW9uX2RldmljZSAqcmRldiwKCiBzdGF0aWMgdm9pZCBzaV9wcm9ncmFt
X3Jlc3BvbnNlX3RpbWVzKHN0cnVjdCByYWRlb25fZGV2aWNlICpyZGV2KQogewotCXUzMiB2b2x0
YWdlX3Jlc3BvbnNlX3RpbWUsIGJhY2tiaWFzX3Jlc3BvbnNlX3RpbWUsIGFjcGlfZGVsYXlfdGlt
ZSwgdmJpX3RpbWVfb3V0OworCXUzMiB2b2x0YWdlX3Jlc3BvbnNlX3RpbWUsIGFjcGlfZGVsYXlf
dGltZSwgdmJpX3RpbWVfb3V0OwogCXUzMiB2ZGRjX2RseSwgYWNwaV9kbHksIHZiaV9kbHk7CiAJ
dTMyIHJlZmVyZW5jZV9jbG9jazsKCiAJc2lfd3JpdGVfc21jX3NvZnRfcmVnaXN0ZXIocmRldiwg
U0lfU01DX1NPRlRfUkVHSVNURVJfbXZkZF9jaGdfdGltZSwgMSk7CgogCXZvbHRhZ2VfcmVzcG9u
c2VfdGltZSA9ICh1MzIpcmRldi0+cG0uZHBtLnZvbHRhZ2VfcmVzcG9uc2VfdGltZTsKLQliYWNr
Ymlhc19yZXNwb25zZV90aW1lID0gKHUzMilyZGV2LT5wbS5kcG0uYmFja2JpYXNfcmVzcG9uc2Vf
dGltZTsKCiAJaWYgKHZvbHRhZ2VfcmVzcG9uc2VfdGltZSA9PSAwKQogCQl2b2x0YWdlX3Jlc3Bv
bnNlX3RpbWUgPSAxMDAwOwotLQoyLjcuNAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVl
ZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5m
by9hbWQtZ2Z4
