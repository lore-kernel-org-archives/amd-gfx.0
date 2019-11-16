Return-Path: <SRS0=bOP+=ZI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D3CEC33C8C
	for <amd-gfx@archiver.kernel.org>; Sat, 16 Nov 2019 16:25:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27131214DE
	for <amd-gfx@archiver.kernel.org>; Sat, 16 Nov 2019 16:25:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27131214DE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C5646E180;
	Sat, 16 Nov 2019 16:25:07 +0000 (UTC)
Received: from huawei.com (szxga05-in.huawei.com [45.249.212.191])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F6E08957B;
 Sat, 16 Nov 2019 03:36:39 +0000 (UTC)
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 459D3232D7737EC5CC9D;
 Sat, 16 Nov 2019 11:36:33 +0800 (CST)
Received: from localhost.localdomain (10.90.53.225) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.439.0; Sat, 16 Nov 2019 11:36:27 +0800
From: Chen Wandun <chenwandun@huawei.com>
To: <alexander.deucher@amd.com>, <evan.quan@amd.com>,
 <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>
Subject: [PATCH] drm/amd/powerplay: remove variable 'result' set but not used
Date: Sat, 16 Nov 2019 11:43:19 +0800
Message-ID: <1573875799-83572-1-git-send-email-chenwandun@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
X-Mailman-Approved-At: Sat, 16 Nov 2019 16:25:06 +0000
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
Message-ID: <20191116034319.u-6hQJ_XxXSchpMYhhXrAa0avn89ESc3F5l1KQ0ngWg@z>

Rml4ZXMgZ2NjICctV3VudXNlZC1idXQtc2V0LXZhcmlhYmxlJyB3YXJuaW5nOgoKZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvLi4vcG93ZXJwbGF5L3NtdW1nci92ZWdhbV9zbXVtZ3IuYzogSW4g
ZnVuY3Rpb24gdmVnYW1fcG9wdWxhdGVfc21jX2Jvb3RfbGV2ZWw6CmRyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1Ly4uL3Bvd2VycGxheS9zbXVtZ3IvdmVnYW1fc211bWdyLmM6MTM2NDo2OiB3YXJu
aW5nOiB2YXJpYWJsZSByZXN1bHQgc2V0IGJ1dCBub3QgdXNlZCBbLVd1bnVzZWQtYnV0LXNldC12
YXJpYWJsZV0KClNpZ25lZC1vZmYtYnk6IENoZW4gV2FuZHVuIDxjaGVud2FuZHVuQGh1YXdlaS5j
b20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvc211bWdyL3ZlZ2FtX3NtdW1n
ci5jIHwgMTMgKysrKysrLS0tLS0tLQogMSBmaWxlIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKSwg
NyBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxh
eS9zbXVtZ3IvdmVnYW1fc211bWdyLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9z
bXVtZ3IvdmVnYW1fc211bWdyLmMKaW5kZXggMjA2OGViMC4uZmFkNzhiZiAxMDA2NDQKLS0tIGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvc211bWdyL3ZlZ2FtX3NtdW1nci5jCisrKyBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L3NtdW1nci92ZWdhbV9zbXVtZ3IuYwpAQCAt
MTM2MSwyMCArMTM2MSwxOSBAQCBzdGF0aWMgaW50IHZlZ2FtX3BvcHVsYXRlX3NtY191dmRfbGV2
ZWwoc3RydWN0IHBwX2h3bWdyICpod21nciwKIHN0YXRpYyBpbnQgdmVnYW1fcG9wdWxhdGVfc21j
X2Jvb3RfbGV2ZWwoc3RydWN0IHBwX2h3bWdyICpod21nciwKIAkJc3RydWN0IFNNVTc1X0Rpc2Ny
ZXRlX0RwbVRhYmxlICp0YWJsZSkKIHsKLQlpbnQgcmVzdWx0ID0gMDsKIAlzdHJ1Y3Qgc211N19o
d21nciAqZGF0YSA9IChzdHJ1Y3Qgc211N19od21nciAqKShod21nci0+YmFja2VuZCk7CiAKIAl0
YWJsZS0+R3JhcGhpY3NCb290TGV2ZWwgPSAwOwogCXRhYmxlLT5NZW1vcnlCb290TGV2ZWwgPSAw
OwogCiAJLyogZmluZCBib290IGxldmVsIGZyb20gZHBtIHRhYmxlICovCi0JcmVzdWx0ID0gcGht
X2ZpbmRfYm9vdF9sZXZlbCgmKGRhdGEtPmRwbV90YWJsZS5zY2xrX3RhYmxlKSwKLQkJCWRhdGEt
PnZiaW9zX2Jvb3Rfc3RhdGUuc2Nsa19ib290dXBfdmFsdWUsCi0JCQkodWludDMyX3QgKikmKHRh
YmxlLT5HcmFwaGljc0Jvb3RMZXZlbCkpOworCXBobV9maW5kX2Jvb3RfbGV2ZWwoJihkYXRhLT5k
cG1fdGFibGUuc2Nsa190YWJsZSksCisJCQkgICAgZGF0YS0+dmJpb3NfYm9vdF9zdGF0ZS5zY2xr
X2Jvb3R1cF92YWx1ZSwKKwkJCSAgICAodWludDMyX3QgKikmKHRhYmxlLT5HcmFwaGljc0Jvb3RM
ZXZlbCkpOwogCi0JcmVzdWx0ID0gcGhtX2ZpbmRfYm9vdF9sZXZlbCgmKGRhdGEtPmRwbV90YWJs
ZS5tY2xrX3RhYmxlKSwKLQkJCWRhdGEtPnZiaW9zX2Jvb3Rfc3RhdGUubWNsa19ib290dXBfdmFs
dWUsCi0JCQkodWludDMyX3QgKikmKHRhYmxlLT5NZW1vcnlCb290TGV2ZWwpKTsKKwlwaG1fZmlu
ZF9ib290X2xldmVsKCYoZGF0YS0+ZHBtX3RhYmxlLm1jbGtfdGFibGUpLAorCQkJICAgIGRhdGEt
PnZiaW9zX2Jvb3Rfc3RhdGUubWNsa19ib290dXBfdmFsdWUsCisJCQkgICAgKHVpbnQzMl90ICop
Jih0YWJsZS0+TWVtb3J5Qm9vdExldmVsKSk7CiAKIAl0YWJsZS0+Qm9vdFZkZGMgID0gZGF0YS0+
dmJpb3NfYm9vdF9zdGF0ZS52ZGRjX2Jvb3R1cF92YWx1ZSAqCiAJCQlWT0xUQUdFX1NDQUxFOwot
LSAKMi43LjQKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBz
Oi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
