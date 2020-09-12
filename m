Return-Path: <SRS0=HfWL=CX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AC1CC433E2
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Sep 2020 05:17:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60F9B214F1
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Sep 2020 05:17:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60F9B214F1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D7BD189F41;
	Mon, 14 Sep 2020 05:17:41 +0000 (UTC)
Received: from huawei.com (szxga07-in.huawei.com [45.249.212.35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F33956E03F;
 Sat, 12 Sep 2020 02:23:11 +0000 (UTC)
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id C232617BFD37532447B9;
 Sat, 12 Sep 2020 10:23:04 +0800 (CST)
Received: from huawei.com (10.175.127.227) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.487.0; Sat, 12 Sep 2020
 10:22:55 +0800
From: Jason Yan <yanaijie@huawei.com>
To: <harry.wentland@amd.com>, <sunpeng.li@amd.com>,
 <alexander.deucher@amd.com>, <christian.koenig@amd.com>, <airlied@linux.ie>,
 <daniel@ffwll.ch>, <mikita.lipski@amd.com>, <eryk.brol@amd.com>,
 <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>
Subject: [PATCH] drm/amd/display: add debugfs entry for trigger_hotplug
Date: Sat, 12 Sep 2020 10:22:14 +0800
Message-ID: <20200912022214.3767954-1-yanaijie@huawei.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
X-Originating-IP: [10.175.127.227]
X-CFilter-Loop: Reflected
X-Mailman-Approved-At: Mon, 14 Sep 2020 05:17:40 +0000
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
Cc: Hulk Robot <hulkci@huawei.com>, Jason Yan <yanaijie@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

VGhlICd0cmlnZ2VyX2hvdHBsdWcnIGVudHJ5IGluIGRlYnVnZnMgaXMgZGVmaW5lZCBidXQgbm90
IHdpcmVkIHVwLiBUaGlzCmNhdXNlcyBhIGdjYyB3YXJuaW5nIGJ1aWxkIHdpdGggVz0xLgoKZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvLi4vZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtX2Rl
YnVnZnMuYzoyMDQ1OjM3Ogp3YXJuaW5nOiDigJhkcF90cmlnZ2VyX2hvdHBsdWdfZGVidWdmc19m
b3Bz4oCZIGRlZmluZWQgYnV0IG5vdCB1c2VkClstV3VudXNlZC1jb25zdC12YXJpYWJsZT1dCiAy
MDQ1IHwgc3RhdGljIGNvbnN0IHN0cnVjdCBmaWxlX29wZXJhdGlvbnMKICAgICAgZHBfdHJpZ2dl
cl9ob3RwbHVnX2RlYnVnZnNfZm9wcyA9IHsKICAgICAgfApefn5+fn5+fn5+fn5+fn5+fn5+fn5+
fn5+fn5+fn5+CgpSZXBvcnRlZC1ieTogSHVsayBSb2JvdCA8aHVsa2NpQGh1YXdlaS5jb20+ClNp
Z25lZC1vZmYtYnk6IEphc29uIFlhbiA8eWFuYWlqaWVAaHVhd2VpLmNvbT4KLS0tCiBkcml2ZXJz
L2dwdS9kcm0vYW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbV9kZWJ1Z2ZzLmMgfCAxICsK
IDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtX2RlYnVnZnMuYyBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtX2RlYnVnZnMuYwppbmRleCA5
NGZjYjA4NjE1NGMuLjk3MmM3ODBiNjI5MyAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG1fZGVidWdmcy5jCisrKyBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtX2RlYnVnZnMuYwpAQCAtMjExNSw2
ICsyMTE1LDcgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCB7CiAJCXsiZHNjX3BpY19oZWlnaHQiLCAm
ZHBfZHNjX3BpY19oZWlnaHRfZGVidWdmc19mb3BzfSwKIAkJeyJkc2NfY2h1bmtfc2l6ZSIsICZk
cF9kc2NfY2h1bmtfc2l6ZV9kZWJ1Z2ZzX2ZvcHN9LAogCQl7ImRzY19zbGljZV9icGciLCAmZHBf
ZHNjX3NsaWNlX2JwZ19vZmZzZXRfZGVidWdmc19mb3BzfSwKKwkJeyJ0cmlnZ2VyX2hvdHBsdWci
LCAmZHBfdHJpZ2dlcl9ob3RwbHVnX2RlYnVnZnNfZm9wc30sCiAJCXsiZHBfZHNjX2ZlY19zdXBw
b3J0IiwgJmRwX2RzY19mZWNfc3VwcG9ydF9mb3BzfQogfTsKIAotLSAKMi4yNS40CgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcg
bGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNr
dG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
