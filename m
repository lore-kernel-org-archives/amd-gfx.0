Return-Path: <SRS0=tiv0=75=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32DA2C433E1
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Jun 2020 07:10:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13D342082F
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Jun 2020 07:10:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13D342082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 121A46E831;
	Tue, 16 Jun 2020 07:09:48 +0000 (UTC)
Received: from huawei.com (szxga07-in.huawei.com [45.249.212.35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 430646E5D3;
 Tue, 16 Jun 2020 06:32:09 +0000 (UTC)
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 9AA5DBC2290480716A2C;
 Tue, 16 Jun 2020 14:32:00 +0800 (CST)
Received: from huawei.com (10.67.174.156) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.487.0; Tue, 16 Jun 2020
 14:31:50 +0800
From: Chen Tao <chentao107@huawei.com>
To: <airlied@linux.ie>, <daniel@ffwll.ch>
Subject: [PATCH 2/2] drm/amdgpu/debugfs: fix memory leak when
 amdgpu_virt_enable_access_debugfs failed
Date: Tue, 16 Jun 2020 14:30:39 +0800
Message-ID: <20200616063039.260990-2-chentao107@huawei.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20200616063039.260990-1-chentao107@huawei.com>
References: <20200616063039.260990-1-chentao107@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.67.174.156]
X-CFilter-Loop: Reflected
X-Mailman-Approved-At: Tue, 16 Jun 2020 07:09:46 +0000
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
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 chentao107@huawei.com, dri-devel@lists.freedesktop.org,
 alexander.deucher@amd.com, christian.koenig@amd.com, yttao@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fix memory leak in amdgpu_debugfs_gpr_read not freeing data when
amdgpu_virt_enable_access_debugfs failed.

Fixes: 95a2f917387a2 ("drm/amdgpu: restrict debugfs register accessunder SR-IOV")
Signed-off-by: Chen Tao <chentao107@huawei.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index bea8c36a53a4..f66ee4b8f04e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -868,8 +868,10 @@ static ssize_t amdgpu_debugfs_gpr_read(struct file *f, char __user *buf,
 	}
 
 	r = amdgpu_virt_enable_access_debugfs(adev);
-	if (r < 0)
+	if (r < 0) {
+		kfree(data);
 		return r;
+	}
 
 	/* switch to the specific se/sh/cu */
 	mutex_lock(&adev->grbm_idx_mutex);
-- 
2.22.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
