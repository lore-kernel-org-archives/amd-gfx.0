Return-Path: <SRS0=uNvg=ZG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACE13C432C3
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Nov 2019 14:56:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88D50206F0
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Nov 2019 14:56:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88D50206F0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4AB6C6EB5C;
	Thu, 14 Nov 2019 14:56:24 +0000 (UTC)
Received: from huawei.com (szxga07-in.huawei.com [45.249.212.35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD7896E22C;
 Thu, 14 Nov 2019 12:29:15 +0000 (UTC)
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 5D8EFEE254581B469C02;
 Thu, 14 Nov 2019 20:29:14 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.439.0; Thu, 14 Nov 2019
 20:29:03 +0800
From: zhengbin <zhengbin13@huawei.com>
To: <harry.wentland@amd.com>, <sunpeng.li@amd.com>,
 <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
 <David1.Zhou@amd.com>, <airlied@linux.ie>, <daniel@ffwll.ch>,
 <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>
Subject: [PATCH 2/4] drm/amd/display: remove set but not used variable 'bp' in
 bios_parser2.c
Date: Thu, 14 Nov 2019 20:36:25 +0800
Message-ID: <1573734987-119703-3-git-send-email-zhengbin13@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1573734987-119703-1-git-send-email-zhengbin13@huawei.com>
References: <1573734987-119703-1-git-send-email-zhengbin13@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
X-Mailman-Approved-At: Thu, 14 Nov 2019 14:56:23 +0000
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
Message-ID: <20191114123625.8j1zy92ByyyLR2spUMpoK4UVcagzcx8jMmYH3oq1cMk@z>

Rml4ZXMgZ2NjICctV3VudXNlZC1idXQtc2V0LXZhcmlhYmxlJyB3YXJuaW5nOgoKZHJpdmVycy9n
cHUvZHJtL2FtZC9kaXNwbGF5L2RjL2Jpb3MvYmlvc19wYXJzZXIyLmM6IEluIGZ1bmN0aW9uIGJp
b3NfZ2V0X2JvYXJkX2xheW91dF9pbmZvOgpkcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMv
Ymlvcy9iaW9zX3BhcnNlcjIuYzoxODI2OjIyOiB3YXJuaW5nOiB2YXJpYWJsZSBicCBzZXQgYnV0
IG5vdCB1c2VkIFstV3VudXNlZC1idXQtc2V0LXZhcmlhYmxlXQoKSXQgaXMgaW50cm9kdWNlZCBi
eSBjb21taXQgMWVlZWRiY2MyMGQ2ICgiZHJtL2FtZC9kaXNwbGF5OgpnZXQgYm9hcmQgbGF5b3V0
IGZvciBlZGlkIGVtdWxhdGlvbiIpLCBidXQgbmV2ZXIgdXNlZCwKc28gcmVtb3ZlIGl0LgoKUmVw
b3J0ZWQtYnk6IEh1bGsgUm9ib3QgPGh1bGtjaUBodWF3ZWkuY29tPgpTaWduZWQtb2ZmLWJ5OiB6
aGVuZ2JpbiA8emhlbmdiaW4xM0BodWF3ZWkuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQv
ZGlzcGxheS9kYy9iaW9zL2Jpb3NfcGFyc2VyMi5jIHwgMiAtLQogMSBmaWxlIGNoYW5nZWQsIDIg
ZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2Rj
L2Jpb3MvYmlvc19wYXJzZXIyLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvYmlv
cy9iaW9zX3BhcnNlcjIuYwppbmRleCA2ZTI5YmE4Li45ZGM4ZDRlIDEwMDY0NAotLS0gYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvYmlvcy9iaW9zX3BhcnNlcjIuYworKysgYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvYmlvcy9iaW9zX3BhcnNlcjIuYwpAQCAtMTgzOCw3
ICsxODM4LDYgQEAgc3RhdGljIGVudW0gYnBfcmVzdWx0IGJpb3NfZ2V0X2JvYXJkX2xheW91dF9p
bmZvKAogCXN0cnVjdCBib2FyZF9sYXlvdXRfaW5mbyAqYm9hcmRfbGF5b3V0X2luZm8pCiB7CiAJ
dW5zaWduZWQgaW50IGk7Ci0Jc3RydWN0IGJpb3NfcGFyc2VyICpicDsKIAllbnVtIGJwX3Jlc3Vs
dCByZWNvcmRfcmVzdWx0OwoKIAljb25zdCB1bnNpZ25lZCBpbnQgc2xvdF9pbmRleF90b192Ymlv
c19pZFtNQVhfQk9BUkRfU0xPVFNdID0gewpAQCAtMTg0Nyw3ICsxODQ2LDYgQEAgc3RhdGljIGVu
dW0gYnBfcmVzdWx0IGJpb3NfZ2V0X2JvYXJkX2xheW91dF9pbmZvKAogCQkwLCAwCiAJfTsKCi0J
YnAgPSBCUF9GUk9NX0RDQihkY2IpOwogCWlmIChib2FyZF9sYXlvdXRfaW5mbyA9PSBOVUxMKSB7
CiAJCURDX0xPR19ERVRFQ1RJT05fRURJRF9QQVJTRVIoIkludmFsaWQgYm9hcmRfbGF5b3V0X2lu
Zm9cbiIpOwogCQlyZXR1cm4gQlBfUkVTVUxUX0JBRElOUFVUOwotLQoyLjcuNAoKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxp
c3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3Rv
cC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
