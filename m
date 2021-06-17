Return-Path: <SRS0=/AY/=LL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27535C48BE5
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Jun 2021 03:18:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2B2E613DE
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Jun 2021 03:18:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2B2E613DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E43C6E867;
	Thu, 17 Jun 2021 03:18:08 +0000 (UTC)
X-Greylist: delayed 991 seconds by postgrey-1.36 at gabe;
 Thu, 17 Jun 2021 02:46:52 UTC
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 41AFF6E7E2
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Jun 2021 02:46:52 +0000 (UTC)
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.57])
 by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4G55XB3lMfz6ySF;
 Thu, 17 Jun 2021 10:26:18 +0800 (CST)
Received: from dggpemm500019.china.huawei.com (7.185.36.180) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 17 Jun 2021 10:30:17 +0800
Received: from ubuntu1804.huawei.com (10.67.174.98) by
 dggpemm500019.china.huawei.com (7.185.36.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 17 Jun 2021 10:30:17 +0800
From: Pu Lehui <pulehui@huawei.com>
To: <harry.wentland@amd.com>, <sunpeng.li@amd.com>,
 <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
 <Xinhui.Pan@amd.com>, <airlied@linux.ie>, <daniel@ffwll.ch>,
 <Jun.Lei@amd.com>, <wenjing.liu@amd.com>, <Anson.Jacob@amd.com>,
 <qingqing.zhuo@amd.com>, <Wesley.Chalmers@amd.com>, <Jimmy.Kizito@amd.com>,
 <aric.cyr@amd.com>, <martin.tsai@amd.com>, <jinlong.zhang@amd.com>
Subject: [PATCH -next] drm/amd/display: Fix gcc unused variable warning
Date: Thu, 17 Jun 2021 10:31:09 +0800
Message-ID: <20210617023109.204591-1-pulehui@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-Originating-IP: [10.67.174.98]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500019.china.huawei.com (7.185.36.180)
X-CFilter-Loop: Reflected
X-Mailman-Approved-At: Thu, 17 Jun 2021 03:18:07 +0000
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
ZHJtL2FtZC9hbWRncHUvLi4vZGlzcGxheS9kYy9jb3JlL2RjX2xpbmtfZHAuYzozNjM1OjE3Ogp3
YXJuaW5nOgogdmFyaWFibGUg4oCYc3RhdHVz4oCZIHNldCBidXQgbm90IHVzZWQgWy1XdW51c2Vk
LWJ1dC1zZXQtdmFyaWFibGVdCiAgMzYzNSB8ICBlbnVtIGRjX3N0YXR1cyBzdGF0dXMgPSBEQ19F
UlJPUl9VTkVYUEVDVEVEOwogICAgICAgfCAgICAgICAgICAgICAgICAgXn5+fn5+CgpUaGUgdmFy
aWFibGUgc2hvdWxkIGJlIHVzZWQgZm9yIGVycm9yIGNoZWNrLCBsZXQncyBmaXggaXQuCgpTaWdu
ZWQtb2ZmLWJ5OiBQdSBMZWh1aSA8cHVsZWh1aUBodWF3ZWkuY29tPgotLS0KIGRyaXZlcnMvZ3B1
L2RybS9hbWQvZGlzcGxheS9kYy9jb3JlL2RjX2xpbmtfZHAuYyB8IDQgKysrKwogMSBmaWxlIGNo
YW5nZWQsIDQgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQv
ZGlzcGxheS9kYy9jb3JlL2RjX2xpbmtfZHAuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxh
eS9kYy9jb3JlL2RjX2xpbmtfZHAuYwppbmRleCBmY2I2MzVjODUzMzAuLmNmMjkyNjU4NzBjOCAx
MDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2NvcmUvZGNfbGlua19k
cC5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9jb3JlL2RjX2xpbmtfZHAu
YwpAQCAtMzY4MSw2ICszNjgxLDEwIEBAIGJvb2wgZHBfcmV0cmlldmVfbHR0cHJfY2FwKHN0cnVj
dCBkY19saW5rICpsaW5rKQogCQkJCURQX0xUX1RVTkFCTEVfUEhZX1JFUEVBVEVSX0ZJRUxEX0RB
VEFfU1RSVUNUVVJFX1JFViwKIAkJCQlsdHRwcl9kcGNkX2RhdGEsCiAJCQkJc2l6ZW9mKGx0dHBy
X2RwY2RfZGF0YSkpOworCQlpZiAoc3RhdHVzICE9IERDX09LKSB7CisJCQlkbV9lcnJvcigiJXM6
IFJlYWQgTFRUUFIgY2FwcyBkYXRhIGZhaWxlZC5cbiIsIF9fZnVuY19fKTsKKwkJCXJldHVybiBm
YWxzZTsKKwkJfQogCiAJCWxpbmstPmRwY2RfY2Fwcy5sdHRwcl9jYXBzLnJldmlzaW9uLnJhdyA9
CiAJCQkJbHR0cHJfZHBjZF9kYXRhW0RQX0xUX1RVTkFCTEVfUEhZX1JFUEVBVEVSX0ZJRUxEX0RB
VEFfU1RSVUNUVVJFX1JFViAtCi0tIAoyLjE3LjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlz
dGluZm8vYW1kLWdmeAo=
