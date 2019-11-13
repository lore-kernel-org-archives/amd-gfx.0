Return-Path: <SRS0=4UxD=ZF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B580C43331
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Nov 2019 14:12:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C1A2222CA
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Nov 2019 14:12:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C1A2222CA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A0EBE6ED38;
	Wed, 13 Nov 2019 14:12:15 +0000 (UTC)
Received: from huawei.com (szxga05-in.huawei.com [45.249.212.191])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B4346E0D9;
 Wed, 13 Nov 2019 12:37:27 +0000 (UTC)
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id D8149C0EE21B8436B52B;
 Wed, 13 Nov 2019 20:37:20 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.439.0; Wed, 13 Nov 2019
 20:37:12 +0800
From: yu kuai <yukuai3@huawei.com>
To: <alexander.deucher@amd.com>, <Felix.Kuehling@amd.com>,
 <christian.koenig@amd.com>, <David1.Zhou@amd.com>, <airlied@linux.ie>,
 <daniel@ffwll.ch>, <Rex.Zhu@amd.com>, <evan.quan@amd.com>
Subject: [PATCH 7/7] drm/amd/powerplay: remove set but not used variable
 'us_mvdd'
Date: Wed, 13 Nov 2019 20:44:34 +0800
Message-ID: <1573649074-72589-8-git-send-email-yukuai3@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1573649074-72589-1-git-send-email-yukuai3@huawei.com>
References: <1573649074-72589-1-git-send-email-yukuai3@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
X-Mailman-Approved-At: Wed, 13 Nov 2019 14:12:08 +0000
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
Cc: yi.zhang@huawei.com, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, zhengbin13@huawei.com,
 dri-devel@lists.freedesktop.org, yukuai3@huawei.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191113124434.dTGHu6Z2ReddXQ0LMqJjtOYjeOKsB6BZ5X7_ABZgXq8@z>

Rml4ZXMgZ2NjICctV3VudXNlZC1idXQtc2V0LXZhcmlhYmxlJyB3YXJuaW5nOgoKZHJpdmVycy9n
cHUvZHJtL2FtZC9wb3dlcnBsYXkvc211bWdyL3ZlZ2FtX3NtdW1nci5jOiBJbgpmdW5jdGlvbiDi
gJh2ZWdhbV9wb3B1bGF0ZV9zbWNfYWNwaV9sZXZlbOKAmToKZHJpdmVycy9ncHUvZHJtL2FtZC9w
b3dlcnBsYXkvc211bWdyL3ZlZ2FtX3NtdW1nci5jOjExMTc6MTE6Cndhcm5pbmc6IHZhcmlhYmxl
ICd1c19tdmRkJyBzZXQgYnV0IG5vdCB1c2VkIFstV3VudXNlZC1idXQtc2V0LXZhcmlhYmxlXQoK
SXQgaXMgbmV2ZXIgdXNlZCwgc28gY2FuIGJlIHJlbW92ZWQuCgpGaXhlczogYWM3ODIyYjAwMjZm
ICgiZHJtL2FtZC9wb3dlcnBsYXk6IGFkZCBzbXVtZ3Igc3VwcG9ydCBmb3IgVkVHQU0gKHYyKSIp
ClNpZ25lZC1vZmYtYnk6IHl1IGt1YWkgPHl1a3VhaTNAaHVhd2VpLmNvbT4KLS0tCiBkcml2ZXJz
L2dwdS9kcm0vYW1kL3Bvd2VycGxheS9zbXVtZ3IvdmVnYW1fc211bWdyLmMgfCAxMiAtLS0tLS0t
LS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCAxMiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9zbXVtZ3IvdmVnYW1fc211bWdyLmMgYi9kcml2ZXJz
L2dwdS9kcm0vYW1kL3Bvd2VycGxheS9zbXVtZ3IvdmVnYW1fc211bWdyLmMKaW5kZXggYWUxOGZi
Yy4uMjA2OGViMCAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvc211
bWdyL3ZlZ2FtX3NtdW1nci5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L3Nt
dW1nci92ZWdhbV9zbXVtZ3IuYwpAQCAtMTExNCw3ICsxMTE0LDYgQEAgc3RhdGljIGludCB2ZWdh
bV9wb3B1bGF0ZV9zbWNfYWNwaV9sZXZlbChzdHJ1Y3QgcHBfaHdtZ3IgKmh3bWdyLAogCQkJKHN0
cnVjdCBwaG1fcHB0X3YxX2luZm9ybWF0aW9uICopKGh3bWdyLT5wcHRhYmxlKTsKIAlTTUlPX1Bh
dHRlcm4gdm9sX2xldmVsOwogCXVpbnQzMl90IG12ZGQ7Ci0JdWludDE2X3QgdXNfbXZkZDsKIAog
CXRhYmxlLT5BQ1BJTGV2ZWwuRmxhZ3MgJj0gflBQU01DX1NXU1RBVEVfRkxBR19EQzsKIApAQCAt
MTE2OCwxNyArMTE2Nyw2IEBAIHN0YXRpYyBpbnQgdmVnYW1fcG9wdWxhdGVfc21jX2FjcGlfbGV2
ZWwoc3RydWN0IHBwX2h3bWdyICpod21nciwKIAkJCSJpbiBDbG9jayBEZXBlbmRlbmN5IFRhYmxl
IiwKIAkJCSk7CiAKLQl1c19tdmRkID0gMDsKLQlpZiAoKFNNVTdfVk9MVEFHRV9DT05UUk9MX05P
TkUgPT0gZGF0YS0+bXZkZF9jb250cm9sKSB8fAotCQkJKGRhdGEtPm1jbGtfZHBtX2tleV9kaXNh
YmxlZCkpCi0JCXVzX212ZGQgPSBkYXRhLT52Ymlvc19ib290X3N0YXRlLm12ZGRfYm9vdHVwX3Zh
bHVlOwotCWVsc2UgewotCQlpZiAoIXZlZ2FtX3BvcHVsYXRlX212ZGRfdmFsdWUoaHdtZ3IsCi0J
CQkJZGF0YS0+ZHBtX3RhYmxlLm1jbGtfdGFibGUuZHBtX2xldmVsc1swXS52YWx1ZSwKLQkJCQkm
dm9sX2xldmVsKSkKLQkJCXVzX212ZGQgPSB2b2xfbGV2ZWwuVm9sdGFnZTsKLQl9Ci0KIAlpZiAo
IXZlZ2FtX3BvcHVsYXRlX212ZGRfdmFsdWUoaHdtZ3IsIDAsICZ2b2xfbGV2ZWwpKQogCQl0YWJs
ZS0+TWVtb3J5QUNQSUxldmVsLk1pbk12ZGQgPSBQUF9IT1NUX1RPX1NNQ19VTCh2b2xfbGV2ZWwu
Vm9sdGFnZSk7CiAJZWxzZQotLSAKMi43LjQKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGlu
Zm8vYW1kLWdmeA==
