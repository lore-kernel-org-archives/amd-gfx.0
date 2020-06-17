Return-Path: <SRS0=VPxi=76=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1F10C433E2
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Jun 2020 13:10:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B19A4206D8
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Jun 2020 13:10:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B19A4206D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B4366E94A;
	Wed, 17 Jun 2020 13:10:14 +0000 (UTC)
Received: from huawei.com (szxga06-in.huawei.com [45.249.212.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 251B96E8F8;
 Wed, 17 Jun 2020 10:52:53 +0000 (UTC)
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 14886898A01E1CECCB7A;
 Wed, 17 Jun 2020 18:52:48 +0800 (CST)
Received: from huawei.com (10.67.174.156) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.487.0; Wed, 17 Jun 2020
 18:52:40 +0800
From: Chen Tao <chentao107@huawei.com>
To: <airlied@linux.ie>, <daniel@ffwll.ch>
Subject: [PATCH v2 1/2] drm/amdgpu/debugfs: fix memory leak when
 pm_runtime_get_sync failed
Date: Wed, 17 Jun 2020 18:51:29 +0800
Message-ID: <20200617105130.207116-1-chentao107@huawei.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
X-Originating-IP: [10.67.174.156]
X-CFilter-Loop: Reflected
X-Mailman-Approved-At: Wed, 17 Jun 2020 13:10:12 +0000
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
Cc: tom.stdenis@amd.com, David1.Zhou@amd.com, Jack.Xiao@amd.com,
 amd-gfx@lists.freedesktop.org, chentao107@huawei.com,
 dri-devel@lists.freedesktop.org, christian.koenig@amd.com, yttao@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fix memory leak in amdgpu_debugfs_gpr_read not freeing data when
pm_runtime_get_sync failed.

Fixes: a9ffe2a983383 ("drm/amdgpu/debugfs: properly handle runtime pm")
Signed-off-by: Chen Tao <chentao107@huawei.com>
---
v1->v2:
 - remove the duplication of result and r here and then use "goto err"

 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index 1a4894fa3693..7993b9eeff38 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -863,7 +863,7 @@ static ssize_t amdgpu_debugfs_gpr_read(struct file *f, char __user *buf,
 
 	r = pm_runtime_get_sync(adev->ddev->dev);
 	if (r < 0)
-		return r;
+		goto err;
 
 	r = amdgpu_virt_enable_access_debugfs(adev);
 	if (r < 0)
@@ -893,7 +893,7 @@ static ssize_t amdgpu_debugfs_gpr_read(struct file *f, char __user *buf,
 		value = data[result >> 2];
 		r = put_user(value, (uint32_t *)buf);
 		if (r) {
-			result = r;
+			amdgpu_virt_disable_access_debugfs(adev);
 			goto err;
 		}
 
@@ -902,10 +902,13 @@ static ssize_t amdgpu_debugfs_gpr_read(struct file *f, char __user *buf,
 		size -= 4;
 	}
 
-err:
 	kfree(data);
 	amdgpu_virt_disable_access_debugfs(adev);
 	return result;
+
+err:
+	kfree(data);
+	return r;
 }
 
 /**
-- 
2.22.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
