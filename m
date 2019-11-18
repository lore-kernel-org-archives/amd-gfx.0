Return-Path: <SRS0=5Use=ZK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B64AEC432C3
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Nov 2019 08:37:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7AE28206A4
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Nov 2019 08:37:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AE28206A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E5C396E0A2;
	Mon, 18 Nov 2019 08:37:09 +0000 (UTC)
Received: from huawei.com (szxga04-in.huawei.com [45.249.212.190])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C5DD76E059;
 Mon, 18 Nov 2019 07:56:47 +0000 (UTC)
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 53A43BAD1F679704F9BA;
 Mon, 18 Nov 2019 15:56:39 +0800 (CST)
Received: from localhost.localdomain (10.90.53.225) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.439.0; Mon, 18 Nov 2019 15:56:31 +0800
From: Chen Wandun <chenwandun@huawei.com>
To: <evan.quan@amd.com>, <alexander.deucher@amd.com>,
 <amd-gfx@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 <dri-devel@lists.freedesktop.org>
Subject: [PATCH v2] drm/amd/powerplay: return errno code to caller when error
 occur
Date: Mon, 18 Nov 2019 16:03:34 +0800
Message-ID: <1574064214-109525-1-git-send-email-chenwandun@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1573875799-83572-1-git-send-email-chenwandun@huawei.com>
References: <1573875799-83572-1-git-send-email-chenwandun@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
X-Mailman-Approved-At: Mon, 18 Nov 2019 08:37:06 +0000
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
Cc: chenwandun@huawei.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191118080334.0nMu8f5lmqt4hEKzaBWZ_ef_Pr9y63ou5tSyz-mOBNQ@z>

cmV0dXJuIGVycm5vIGNvZGUgdG8gY2FsbGVyIHdoZW4gZXJyb3Igb2NjdXIsIGFuZCBtZWFud2hp
bGUKcmVtb3ZlIGdjYyAnLVd1bnVzZWQtYnV0LXNldC12YXJpYWJsZScgd2FybmluZy4KCmRyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1Ly4uL3Bvd2VycGxheS9zbXVtZ3IvdmVnYW1fc211bWdyLmM6
IEluIGZ1bmN0aW9uIHZlZ2FtX3BvcHVsYXRlX3NtY19ib290X2xldmVsOgpkcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS8uLi9wb3dlcnBsYXkvc211bWdyL3ZlZ2FtX3NtdW1nci5jOjEzNjQ6Njog
d2FybmluZzogdmFyaWFibGUgcmVzdWx0IHNldCBidXQgbm90IHVzZWQgWy1XdW51c2VkLWJ1dC1z
ZXQtdmFyaWFibGVdCgpTaWduZWQtb2ZmLWJ5OiBDaGVuIFdhbmR1biA8Y2hlbndhbmR1bkBodWF3
ZWkuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L3NtdW1nci92ZWdhbV9z
bXVtZ3IuYyB8IDUgKysrKysKIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKykKCmRpZmYg
LS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9zbXVtZ3IvdmVnYW1fc211bWdy
LmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9zbXVtZ3IvdmVnYW1fc211bWdyLmMK
aW5kZXggMjA2OGViMC4uNTA4OTZlOSAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9w
b3dlcnBsYXkvc211bWdyL3ZlZ2FtX3NtdW1nci5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
cG93ZXJwbGF5L3NtdW1nci92ZWdhbV9zbXVtZ3IuYwpAQCAtMTM3MSwxMSArMTM3MSwxNiBAQCBz
dGF0aWMgaW50IHZlZ2FtX3BvcHVsYXRlX3NtY19ib290X2xldmVsKHN0cnVjdCBwcF9od21nciAq
aHdtZ3IsCiAJcmVzdWx0ID0gcGhtX2ZpbmRfYm9vdF9sZXZlbCgmKGRhdGEtPmRwbV90YWJsZS5z
Y2xrX3RhYmxlKSwKIAkJCWRhdGEtPnZiaW9zX2Jvb3Rfc3RhdGUuc2Nsa19ib290dXBfdmFsdWUs
CiAJCQkodWludDMyX3QgKikmKHRhYmxlLT5HcmFwaGljc0Jvb3RMZXZlbCkpOworCWlmIChyZXN1
bHQpCisJCXJldHVybiByZXN1bHQ7CiAKIAlyZXN1bHQgPSBwaG1fZmluZF9ib290X2xldmVsKCYo
ZGF0YS0+ZHBtX3RhYmxlLm1jbGtfdGFibGUpLAogCQkJZGF0YS0+dmJpb3NfYm9vdF9zdGF0ZS5t
Y2xrX2Jvb3R1cF92YWx1ZSwKIAkJCSh1aW50MzJfdCAqKSYodGFibGUtPk1lbW9yeUJvb3RMZXZl
bCkpOwogCisJaWYgKHJlc3VsdCkKKwkJcmV0dXJuIHJlc3VsdDsKKwogCXRhYmxlLT5Cb290VmRk
YyAgPSBkYXRhLT52Ymlvc19ib290X3N0YXRlLnZkZGNfYm9vdHVwX3ZhbHVlICoKIAkJCVZPTFRB
R0VfU0NBTEU7CiAJdGFibGUtPkJvb3RWZGRjaSA9IGRhdGEtPnZiaW9zX2Jvb3Rfc3RhdGUudmRk
Y2lfYm9vdHVwX3ZhbHVlICoKLS0gCjIuNy40CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZy
ZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2FtZC1nZng=
