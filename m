Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3A7FC4332F
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Nov 2022 14:42:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 950DF10E826;
	Thu, 10 Nov 2022 14:42:30 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D30FD10E805;
 Thu, 10 Nov 2022 14:33:23 +0000 (UTC)
Received: from kwepemi500026.china.huawei.com (unknown [172.30.72.54])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4N7PT02XXZzRp8r;
 Thu, 10 Nov 2022 22:33:08 +0800 (CST)
Received: from localhost.localdomain (10.175.104.82) by
 kwepemi500026.china.huawei.com (7.221.188.247) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 10 Nov 2022 22:33:16 +0800
From: Dong Chenchen <dongchenchen2@huawei.com>
To: <airlied@gmail.com>, <daniel@ffwll.ch>
Subject: [PATCH] drm/amdgpu: Fix memory leak in amdgpu_cs_pass1
Date: Thu, 10 Nov 2022 22:33:14 +0800
Message-ID: <20221110143314.708434-1-dongchenchen2@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.175.104.82]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemi500026.china.huawei.com (7.221.188.247)
X-CFilter-Loop: Reflected
X-Mailman-Approved-At: Thu, 10 Nov 2022 14:42:27 +0000
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
Cc: Xinhui.Pan@amd.com, yuehaibing@huawei.com, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Dong Chenchen <dongchenchen2@huawei.com>,
 amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com,
 christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

When p->gang_size equals 0, amdgpu_cs_pass1() will return directly
without freeing chunk_array, which will cause a memory leak issue,
this patch fixes it.

Fixes: 4624459c84d7 ("drm/amdgpu: add gang submit frontend v6")
Signed-off-by: Dong Chenchen <dongchenchen2@huawei.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index 1bbd39b3b0fc..0e24d6b80e0b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -287,8 +287,10 @@ static int amdgpu_cs_pass1(struct amdgpu_cs_parser *p,
 		}
 	}
 
-	if (!p->gang_size)
-		return -EINVAL;
+	if (!p->gang_size) {
+		ret = -EINVAL;
+		goto free_partial_kdata;
+	}
 
 	for (i = 0; i < p->gang_size; ++i) {
 		ret = amdgpu_job_alloc(p->adev, num_ibs[i], &p->jobs[i], vm);
-- 
2.25.1
