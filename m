Return-Path: <SRS0=CFk9=K2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70206C47082
	for <amd-gfx@archiver.kernel.org>; Mon, 31 May 2021 08:17:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31912610C8
	for <amd-gfx@archiver.kernel.org>; Mon, 31 May 2021 08:17:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31912610C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B31FD6E87A;
	Mon, 31 May 2021 08:17:26 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF9C96E454;
 Mon, 31 May 2021 02:04:56 +0000 (UTC)
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.57])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Ftdlx3Fv6zWqmj;
 Mon, 31 May 2021 10:00:13 +0800 (CST)
Received: from dggema762-chm.china.huawei.com (10.1.198.204) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Mon, 31 May 2021 10:04:51 +0800
Received: from huawei.com (10.175.127.227) by dggema762-chm.china.huawei.com
 (10.1.198.204) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Mon, 31
 May 2021 10:04:50 +0800
From: Yu Kuai <yukuai3@huawei.com>
To: <harry.wentland@amd.com>, <sunpeng.li@amd.com>,
 <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
 <Xinhui.Pan@amd.com>, <airlied@linux.ie>, <daniel@ffwll.ch>
Subject: [PATCH V2] drm/amd/display: fix gcc set but not used warning of
 variable 'link_bandwidth_kbps'
Date: Mon, 31 May 2021 10:14:11 +0800
Message-ID: <20210531021411.469090-1-yukuai3@huawei.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20210529093021.3135273-1-yukuai3@huawei.com>
References: <20210529093021.3135273-1-yukuai3@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggema762-chm.china.huawei.com (10.1.198.204)
X-CFilter-Loop: Reflected
X-Mailman-Approved-At: Mon, 31 May 2021 08:17:26 +0000
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
dSBLdWFpIDx5dWt1YWkzQGh1YXdlaS5jb20+Ci0tLQpjaGFuZ2VzIGluIFYyOgogLSBmaXggdGhh
dCBmb3JnZXR0aW5nIHRvIGNoYW5nZSBwb3NpdGlvbiBvZiAnI2VuZGlmJwogZHJpdmVycy9ncHUv
ZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG0uYyB8IDQgKystLQogMSBmaWxlIGNo
YW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbS5jIGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG0uYwppbmRleCBhMjgwY2FkN2M0
Y2EuLmMyYWU4OGFmNzBjZCAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5
L2FtZGdwdV9kbS9hbWRncHVfZG0uYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkv
YW1kZ3B1X2RtL2FtZGdwdV9kbS5jCkBAIC01NTY5LDYgKzU1NjksNyBAQCBzdGF0aWMgdm9pZCB1
cGRhdGVfZHNjX2NhcHMoc3RydWN0IGFtZGdwdV9kbV9jb25uZWN0b3IgKmFjb25uZWN0b3IsCiAJ
fQogfQogCisjaWYgZGVmaW5lZChDT05GSUdfRFJNX0FNRF9EQ19EQ04pCiBzdGF0aWMgdm9pZCBh
cHBseV9kc2NfcG9saWN5X2Zvcl9zdHJlYW0oc3RydWN0IGFtZGdwdV9kbV9jb25uZWN0b3IgKmFj
b25uZWN0b3IsCiAJCQkJCQkJCQkJc3RydWN0IGRjX3NpbmsgKnNpbmssIHN0cnVjdCBkY19zdHJl
YW1fc3RhdGUgKnN0cmVhbSwKIAkJCQkJCQkJCQlzdHJ1Y3QgZHNjX2RlY19kcGNkX2NhcHMgKmRz
Y19jYXBzKQpAQCAtNTU3OCw3ICs1NTc5LDYgQEAgc3RhdGljIHZvaWQgYXBwbHlfZHNjX3BvbGlj
eV9mb3Jfc3RyZWFtKHN0cnVjdCBhbWRncHVfZG1fY29ubmVjdG9yICphY29ubmVjdG9yLAogCiAJ
bGlua19iYW5kd2lkdGhfa2JwcyA9IGRjX2xpbmtfYmFuZHdpZHRoX2ticHMoYWNvbm5lY3Rvci0+
ZGNfbGluaywKIAkJCQkJCQlkY19saW5rX2dldF9saW5rX2NhcChhY29ubmVjdG9yLT5kY19saW5r
KSk7Ci0jaWYgZGVmaW5lZChDT05GSUdfRFJNX0FNRF9EQ19EQ04pCiAJLyogU2V0IERTQyBwb2xp
Y3kgYWNjb3JkaW5nIHRvIGRzY19jbG9ja19lbiAqLwogCWRjX2RzY19wb2xpY3lfc2V0X2VuYWJs
ZV9kc2Nfd2hlbl9ub3RfbmVlZGVkKAogCQlhY29ubmVjdG9yLT5kc2Nfc2V0dGluZ3MuZHNjX2Zv
cmNlX2VuYWJsZSA9PSBEU0NfQ0xLX0ZPUkNFX0VOQUJMRSk7CkBAIC01NjA5LDggKzU2MDksOCBA
QCBzdGF0aWMgdm9pZCBhcHBseV9kc2NfcG9saWN5X2Zvcl9zdHJlYW0oc3RydWN0IGFtZGdwdV9k
bV9jb25uZWN0b3IgKmFjb25uZWN0b3IsCiAKIAlpZiAoc3RyZWFtLT50aW1pbmcuZmxhZ3MuRFND
ICYmIGFjb25uZWN0b3ItPmRzY19zZXR0aW5ncy5kc2NfYml0c19wZXJfcGl4ZWwpCiAJCXN0cmVh
bS0+dGltaW5nLmRzY19jZmcuYml0c19wZXJfcGl4ZWwgPSBhY29ubmVjdG9yLT5kc2Nfc2V0dGlu
Z3MuZHNjX2JpdHNfcGVyX3BpeGVsOwotI2VuZGlmCiB9CisjZW5kaWYKIAogc3RhdGljIHN0cnVj
dCBkcm1fZGlzcGxheV9tb2RlICoKIGdldF9oaWdoZXN0X3JlZnJlc2hfcmF0ZV9tb2RlKHN0cnVj
dCBhbWRncHVfZG1fY29ubmVjdG9yICphY29ubmVjdG9yLAotLSAKMi4yNS40CgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlz
dAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9w
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
