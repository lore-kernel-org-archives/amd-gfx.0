Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC009C001DB
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Aug 2023 12:33:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 36F7010E50F;
	Thu, 10 Aug 2023 12:33:26 +0000 (UTC)
X-Greylist: delayed 1178 seconds by postgrey-1.36 at gabe;
 Thu, 10 Aug 2023 12:16:18 UTC
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 43B3E10E512
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Aug 2023 12:16:18 +0000 (UTC)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.54])
 by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4RM53136GDz1L9fb;
 Thu, 10 Aug 2023 19:55:25 +0800 (CST)
Received: from huawei.com (10.67.175.31) by dggpemm500024.china.huawei.com
 (7.185.36.203) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 10 Aug
 2023 19:56:37 +0800
From: GUO Zihua <guozihua@huawei.com>
To: <Felix.Kuehling@amd.com>, <alexander.deucher@amd.com>,
 <christian.koenig@amd.com>, <Xinhui.Pan@amd.com>
Subject: [PATCH -next] drm/amdgpu: Remove duplicated includes
Date: Thu, 10 Aug 2023 19:56:12 +0800
Message-ID: <20230810115612.23428-1-guozihua@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.175.31]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500024.china.huawei.com (7.185.36.203)
X-CFilter-Loop: Reflected
X-Mailman-Approved-At: Thu, 10 Aug 2023 12:33:24 +0000
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Remove duplicated includes in amdgpu_amdkfd_gpuvm.c and amdgpu_ttm.c.
Resolves checkincludes message.

Signed-off-by: GUO Zihua <guozihua@huawei.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 1 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c          | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index a136fba9f29b..7d6daf8d2bfa 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -39,7 +39,6 @@
 #include "amdgpu_xgmi.h"
 #include "kfd_priv.h"
 #include "kfd_smi_events.h"
-#include <drm/ttm/ttm_tt.h>
 
 /* Userptr restore delay, just long enough to allow consecutive VM
  * changes to accumulate
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index dea848bb55c1..f5aa1362c818 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -49,7 +49,6 @@
 #include <drm/ttm/ttm_tt.h>
 
 #include <drm/amdgpu_drm.h>
-#include <drm/drm_drv.h>
 
 #include "amdgpu.h"
 #include "amdgpu_object.h"
-- 
2.17.1

