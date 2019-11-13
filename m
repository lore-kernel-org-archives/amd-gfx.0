Return-Path: <SRS0=4UxD=ZF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8661EC17442
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Nov 2019 14:12:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 657EB2245B
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Nov 2019 14:12:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 657EB2245B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD2756ED37;
	Wed, 13 Nov 2019 14:12:14 +0000 (UTC)
Received: from huawei.com (szxga05-in.huawei.com [45.249.212.191])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 18E4389836;
 Wed, 13 Nov 2019 12:37:26 +0000 (UTC)
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id D2414F03F8CB951FDDDD;
 Wed, 13 Nov 2019 20:37:20 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.439.0; Wed, 13 Nov 2019
 20:37:10 +0800
From: yu kuai <yukuai3@huawei.com>
To: <alexander.deucher@amd.com>, <Felix.Kuehling@amd.com>,
 <christian.koenig@amd.com>, <David1.Zhou@amd.com>, <airlied@linux.ie>,
 <daniel@ffwll.ch>, <Rex.Zhu@amd.com>, <evan.quan@amd.com>
Subject: [PATCH 0/7] various '-Wunused-but-set-variable' gcc warning fixes
Date: Wed, 13 Nov 2019 20:44:27 +0800
Message-ID: <1573649074-72589-1-git-send-email-yukuai3@huawei.com>
X-Mailer: git-send-email 2.7.4
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
Message-ID: <20191113124427.Mm99yoxjpmOvg0bFGVWhH6LUHUg9Zz25xaHVG0YNAd4@z>

VGhpcyBwYXRjaCBzZXQgZml4ZXMgdmFyaW91cyB1bnJlbGF0ZWQgZ2NjICctV3VudXNlZC1idXQt
c2V0LXZhcmlhYmxlJwp3YXJuaW5ncy4KCnl1IGt1YWkgKDcpOgogIGRybS9hbWRncHU6IHJlbW92
ZSBzZXQgYnV0IG5vdCB1c2VkIHZhcmlhYmxlICdtY19zaGFyZWRfY2htYXAnIGZyb20KICAgICdn
ZnhfdjZfMC5jJyBhbmQgJ2dmeF92N18wLmMnCiAgZHJtL2FtZGdwdTogcmVtb3ZlIHNldCBidXQg
bm90IHVzZWQgdmFyaWFibGUgJ2FtZGdwdV9jb25uZWN0b3InCiAgZHJtL2FtZGdwdTogcmVtb3Zl
IHNldCBidXQgbm90IHVzZWQgdmFyaWFibGUgJ2NvdW50JwogIGRybS9hbWRncHU6IHJlbW92ZSBz
ZXQgYnV0IG5vdCB1c2VkIHZhcmlhYmxlICdpbnZhbGlkJwogIGRybS9hbWRncHU6IHJlbW92ZSBz
ZXQgYnV0IG5vdCB1c2VkIHZhcmlhYmxlICd0aHJlc2hvbGQnCiAgZHJtL2FtZGdwdTogcmVtb3Zl
IHNldCBidXQgbm90IHVzZWQgdmFyaWFibGUgJ3N0YXRlJwogIGRybS9hbWRncHU6IHJlbW92ZSBz
ZXQgYnV0IG5vdCB1c2VkIHZhcmlhYmxlICd1c19tdmRkJwoKIGRyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV9hbWRrZmRfZ3B1dm0uYyAgICB8ICA0ICsrLS0KIGRyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV9kaXNwbGF5LmMgICAgICAgICB8ICAyIC0tCiBkcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9nZnhfdjZfMC5jICAgICAgICAgICAgICAgfCAgMyArLS0KIGRyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92N18wLmMgICAgICAgICAgICAgICB8ICAzICstLQog
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX2RldmljZS5jICAgICAgICAgICAgIHwgIDQg
KystLQogZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvc211bWdyL2Zpamlfc211bWdyLmMg
IHwgIDcgKystLS0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvc211bWdyL3ZlZ2Ft
X3NtdW1nci5jIHwgMTIgLS0tLS0tLS0tLS0tCiA3IGZpbGVzIGNoYW5nZWQsIDggaW5zZXJ0aW9u
cygrKSwgMjcgZGVsZXRpb25zKC0pCgotLSAKMi43LjQKCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlz
dHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4v
bGlzdGluZm8vYW1kLWdmeA==
