Return-Path: <SRS0=/AY/=LL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26BB3C48BE8
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Jun 2021 01:42:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1196611BE
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Jun 2021 01:42:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1196611BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F18B6E861;
	Thu, 17 Jun 2021 01:42:17 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 831256E0EF;
 Thu, 17 Jun 2021 01:15:45 +0000 (UTC)
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.54])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4G53vL4VqgzZfjy;
 Thu, 17 Jun 2021 09:12:46 +0800 (CST)
Received: from dggpemm500019.china.huawei.com (7.185.36.180) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 17 Jun 2021 09:15:42 +0800
Received: from ubuntu1804.huawei.com (10.67.174.98) by
 dggpemm500019.china.huawei.com (7.185.36.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 17 Jun 2021 09:15:42 +0800
From: Pu Lehui <pulehui@huawei.com>
To: <harry.wentland@amd.com>, <sunpeng.li@amd.com>,
 <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
 <Xinhui.Pan@amd.com>, <airlied@linux.ie>, <daniel@ffwll.ch>,
 <Anson.Jacob@amd.com>, <Nicholas.Kazlauskas@amd.com>, <roman.li@amd.com>
Subject: [PATCH -next] drm/amd/display: remove unused variable 'dc'
Date: Thu, 17 Jun 2021 09:16:32 +0800
Message-ID: <20210617011632.187690-1-pulehui@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-Originating-IP: [10.67.174.98]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500019.china.huawei.com (7.185.36.180)
X-CFilter-Loop: Reflected
X-Mailman-Approved-At: Thu, 17 Jun 2021 01:42:16 +0000
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
Cc: zhangjinhao2@huawei.com, pulehui@huawei.com,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

R0NDIHJlcG9ydHMgdGhlIGZvbGxvd2luZyB3YXJuaW5nIHdpdGggVz0xOgoKZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvLi4vZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtX3Bzci5jOjcwOjEz
Ogp3YXJuaW5nOgogdmFyaWFibGUg4oCYZGPigJkgc2V0IGJ1dCBub3QgdXNlZCBbLVd1bnVzZWQt
YnV0LXNldC12YXJpYWJsZV0KICAgIDcwIHwgIHN0cnVjdCBkYyAqZGMgPSBOVUxMOwogICAgICAg
fCAgICAgICAgICAgICBefgoKVGhpcyB2YXJpYWJsZSBpcyBub3QgdXNlZCBpbiBmdW5jdGlvbiwg
dGhpcyBjb21taXQgcmVtb3ZlIGl0IHRvCmZpeCB0aGUgd2FybmluZy4KClNpZ25lZC1vZmYtYnk6
IFB1IExlaHVpIDxwdWxlaHVpQGh1YXdlaS5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9k
aXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG1fcHNyLmMgfCAyIC0tCiAxIGZpbGUgY2hhbmdlZCwg
MiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkv
YW1kZ3B1X2RtL2FtZGdwdV9kbV9wc3IuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9h
bWRncHVfZG0vYW1kZ3B1X2RtX3Bzci5jCmluZGV4IGY3Yzc3YWUwZDk2NS4uNzBhNTU0ZjFlNzI1
IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdw
dV9kbV9wc3IuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2Ft
ZGdwdV9kbV9wc3IuYwpAQCAtNjcsMTQgKzY3LDEyIEBAIGJvb2wgYW1kZ3B1X2RtX2xpbmtfc2V0
dXBfcHNyKHN0cnVjdCBkY19zdHJlYW1fc3RhdGUgKnN0cmVhbSkKIAlzdHJ1Y3QgZGNfbGluayAq
bGluayA9IE5VTEw7CiAJc3RydWN0IHBzcl9jb25maWcgcHNyX2NvbmZpZyA9IHswfTsKIAlzdHJ1
Y3QgcHNyX2NvbnRleHQgcHNyX2NvbnRleHQgPSB7MH07Ci0Jc3RydWN0IGRjICpkYyA9IE5VTEw7
CiAJYm9vbCByZXQgPSBmYWxzZTsKIAogCWlmIChzdHJlYW0gPT0gTlVMTCkKIAkJcmV0dXJuIGZh
bHNlOwogCiAJbGluayA9IHN0cmVhbS0+bGluazsKLQlkYyA9IGxpbmstPmN0eC0+ZGM7CiAKIAlw
c3JfY29uZmlnLnBzcl92ZXJzaW9uID0gbGluay0+ZHBjZF9jYXBzLnBzcl9jYXBzLnBzcl92ZXJz
aW9uOwogCi0tIAoyLjE3LjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Au
b3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdm
eAo=
