Return-Path: <SRS0=Uo0t=KY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC0F0C4708E
	for <amd-gfx@archiver.kernel.org>; Sat, 29 May 2021 10:20:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71C6C6103E
	for <amd-gfx@archiver.kernel.org>; Sat, 29 May 2021 10:20:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71C6C6103E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3119E6F3F5;
	Sat, 29 May 2021 10:20:45 +0000 (UTC)
X-Greylist: delayed 1155 seconds by postgrey-1.36 at gabe;
 Sat, 29 May 2021 09:38:13 UTC
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C4B46E10D
 for <amd-gfx@lists.freedesktop.org>; Sat, 29 May 2021 09:38:13 +0000 (UTC)
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.55])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4FsbZM0vpbzYpVW;
 Sat, 29 May 2021 17:18:19 +0800 (CST)
Received: from dggema762-chm.china.huawei.com (10.1.198.204) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Sat, 29 May 2021 17:21:00 +0800
Received: from huawei.com (10.175.127.227) by dggema762-chm.china.huawei.com
 (10.1.198.204) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Sat, 29
 May 2021 17:20:59 +0800
From: Yu Kuai <yukuai3@huawei.com>
To: <harry.wentland@amd.com>, <sunpeng.li@amd.com>,
 <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
 <Xinhui.Pan@amd.com>, <airlied@linux.ie>, <daniel@ffwll.ch>
Subject: [PATCH] drm/amd/display: fix gcc set but not used warning of variable
 'link_bandwidth_kbps'
Date: Sat, 29 May 2021 17:30:21 +0800
Message-ID: <20210529093021.3135273-1-yukuai3@huawei.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggema762-chm.china.huawei.com (10.1.198.204)
X-CFilter-Loop: Reflected
X-Mailman-Approved-At: Sat, 29 May 2021 10:20:31 +0000
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
Cc: yukuai3@huawei.com, yi.zhang@huawei.com, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

YXBwbHlfZHNjX3BvbGljeV9mb3Jfc3RyZWFtKCkgd2lsbCBvbmx5IGJlIHVzZWQgaWYKJ0NPTkZJ
R19EUk1fQU1EX0RDX0RDTicgaXMgZW5hYmxlZCwgdGh1cyB0aGUgZnVuY3Rpb24gY2FuIGJlCmRl
Y2xhcmVkIGluc2lkZSB0aGUgaWZkZWZpbmUgbWFyY28uCgpGaXggZ2NjIHdhcm5pbmc6CmRyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1Ly4uL2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbS5jOjU1
Nzc6MTE6IHdhcm5pbmc6CiB2YXJpYWJsZSDigJhsaW5rX2JhbmR3aWR0aF9rYnBz4oCZIHNldCBi
dXQgbm90IHVzZWQgWy1XdW51c2VkLWJ1dC1zZXQtdmFyaWFibGVdCgpTaWduZWQtb2ZmLWJ5OiBZ
dSBLdWFpIDx5dWt1YWkzQGh1YXdlaS5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNw
bGF5L2FtZGdwdV9kbS9hbWRncHVfZG0uYyB8IDIgKy0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2Vy
dGlvbigrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQv
ZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3Bs
YXkvYW1kZ3B1X2RtL2FtZGdwdV9kbS5jCmluZGV4IGYwYWRmZGEzMjIxMy4uZjdhNWU1YjQ4ZWE2
IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdw
dV9kbS5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1
X2RtLmMKQEAgLTU1NjksNiArNTU2OSw3IEBAIHN0YXRpYyB2b2lkIHVwZGF0ZV9kc2NfY2Fwcyhz
dHJ1Y3QgYW1kZ3B1X2RtX2Nvbm5lY3RvciAqYWNvbm5lY3RvciwKIAl9CiB9CiAKKyNpZiBkZWZp
bmVkKENPTkZJR19EUk1fQU1EX0RDX0RDTikKIHN0YXRpYyB2b2lkIGFwcGx5X2RzY19wb2xpY3lf
Zm9yX3N0cmVhbShzdHJ1Y3QgYW1kZ3B1X2RtX2Nvbm5lY3RvciAqYWNvbm5lY3RvciwKIAkJCQkJ
CQkJCQlzdHJ1Y3QgZGNfc2luayAqc2luaywgc3RydWN0IGRjX3N0cmVhbV9zdGF0ZSAqc3RyZWFt
LAogCQkJCQkJCQkJCXN0cnVjdCBkc2NfZGVjX2RwY2RfY2FwcyAqZHNjX2NhcHMpCkBAIC01NTc4
LDcgKzU1NzksNiBAQCBzdGF0aWMgdm9pZCBhcHBseV9kc2NfcG9saWN5X2Zvcl9zdHJlYW0oc3Ry
dWN0IGFtZGdwdV9kbV9jb25uZWN0b3IgKmFjb25uZWN0b3IsCiAKIAlsaW5rX2JhbmR3aWR0aF9r
YnBzID0gZGNfbGlua19iYW5kd2lkdGhfa2JwcyhhY29ubmVjdG9yLT5kY19saW5rLAogCQkJCQkJ
CWRjX2xpbmtfZ2V0X2xpbmtfY2FwKGFjb25uZWN0b3ItPmRjX2xpbmspKTsKLSNpZiBkZWZpbmVk
KENPTkZJR19EUk1fQU1EX0RDX0RDTikKIAkvKiBTZXQgRFNDIHBvbGljeSBhY2NvcmRpbmcgdG8g
ZHNjX2Nsb2NrX2VuICovCiAJZGNfZHNjX3BvbGljeV9zZXRfZW5hYmxlX2RzY193aGVuX25vdF9u
ZWVkZWQoCiAJCWFjb25uZWN0b3ItPmRzY19zZXR0aW5ncy5kc2NfZm9yY2VfZW5hYmxlID09IERT
Q19DTEtfRk9SQ0VfRU5BQkxFKTsKLS0gCjIuMjUuNAoKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0
cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9s
aXN0aW5mby9hbWQtZ2Z4Cg==
