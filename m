Return-Path: <SRS0=3/5X=CT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51FB8C2D0E2
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Sep 2020 07:29:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 124882078B
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Sep 2020 07:29:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 124882078B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B841A6E2EA;
	Thu, 10 Sep 2020 07:29:40 +0000 (UTC)
Received: from huawei.com (szxga06-in.huawei.com [45.249.212.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0792389F4A;
 Thu, 10 Sep 2020 02:34:03 +0000 (UTC)
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 6ED9E922509EC3D6151A;
 Thu, 10 Sep 2020 10:33:59 +0800 (CST)
Received: from localhost (10.174.179.108) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.487.0; Thu, 10 Sep 2020
 10:33:50 +0800
From: YueHaibing <yuehaibing@huawei.com>
To: <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
 <airlied@linux.ie>, <daniel@ffwll.ch>
Subject: [PATCH -next] drm/ttm/agp: Fix Wunused-variable warning
Date: Thu, 10 Sep 2020 10:33:45 +0800
Message-ID: <20200910023345.20428-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
X-Originating-IP: [10.174.179.108]
X-CFilter-Loop: Reflected
X-Mailman-Approved-At: Thu, 10 Sep 2020 07:29:37 +0000
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
Cc: YueHaibing <yuehaibing@huawei.com>, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

SWYgQ09ORklHX0FHUCBpcyBub3Qgc2V0LCBnY2Mgd2FybnM6Cgpkcml2ZXJzL2dwdS9kcm0vcmFk
ZW9uL3JhZGVvbl90dG0uYzogSW4gZnVuY3Rpb24g4oCYcmFkZW9uX3R0bV90dF9iaW5k4oCZOgpk
cml2ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVvbl90dG0uYzo2OTI6MjQ6IHdhcm5pbmc6IHVudXNl
ZCB2YXJpYWJsZSDigJhyZGV24oCZIFstV3VudXNlZC12YXJpYWJsZV0KICBzdHJ1Y3QgcmFkZW9u
X2RldmljZSAqcmRldiA9IHJhZGVvbl9nZXRfcmRldihiZGV2KTsKICAgICAgICAgICAgICAgICAg
ICAgICAgXn5+fgoKTW92ZSBpdCB0byBpZmRlZiBibG9jayB0byBmaXggdGhpcy4KClNpZ25lZC1v
ZmYtYnk6IFl1ZUhhaWJpbmcgPHl1ZWhhaWJpbmdAaHVhd2VpLmNvbT4KLS0tCiBkcml2ZXJzL2dw
dS9kcm0vcmFkZW9uL3JhZGVvbl90dG0uYyB8IDIgKy0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2Vy
dGlvbigrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9yYWRl
b24vcmFkZW9uX3R0bS5jIGIvZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fdHRtLmMKaW5k
ZXggMzFjNjNkMzM5NjI5Li40NDllNzdlYjc1ZjkgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2Ry
bS9yYWRlb24vcmFkZW9uX3R0bS5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vcmFkZW9u
X3R0bS5jCkBAIC02ODksOSArNjg5LDkgQEAgc3RhdGljIGludCByYWRlb25fdHRtX3R0X2JpbmQo
c3RydWN0IHR0bV9ib19kZXZpY2UgKmJkZXYsCiAJCQkgICAgICBzdHJ1Y3QgdHRtX3R0ICp0dG0s
CiAJCQkgICAgICBzdHJ1Y3QgdHRtX3Jlc291cmNlICpib19tZW0pCiB7CisjaWYgSVNfRU5BQkxF
RChDT05GSUdfQUdQKQogCXN0cnVjdCByYWRlb25fZGV2aWNlICpyZGV2ID0gcmFkZW9uX2dldF9y
ZGV2KGJkZXYpOwogCi0jaWYgSVNfRU5BQkxFRChDT05GSUdfQUdQKQogCWlmIChyZGV2LT5mbGFn
cyAmIFJBREVPTl9JU19BR1ApCiAJCXJldHVybiB0dG1fYWdwX2JpbmQodHRtLCBib19tZW0pOwog
I2VuZGlmCi0tIAoyLjE3LjEKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1n
ZngK
