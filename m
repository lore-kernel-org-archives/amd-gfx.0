Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42FD5C433FE
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Nov 2022 08:30:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3AE5110E6A7;
	Thu, 24 Nov 2022 08:30:42 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E9FC10E250;
 Thu, 24 Nov 2022 01:55:42 +0000 (UTC)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.54])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NHgzv3QgszmW92;
 Thu, 24 Nov 2022 09:55:07 +0800 (CST)
Received: from huawei.com (10.67.174.73) by canpemm500009.china.huawei.com
 (7.192.105.203) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 24 Nov
 2022 09:55:39 +0800
From: Yu Songping <yusongping@huawei.com>
To: <airlied@gmail.com>, <daniel@ffwll.ch>
Subject: [PATCH] swsmu/amdgpu_smu: Fix the wrong if-condition
Date: Thu, 24 Nov 2022 09:52:37 +0800
Message-ID: <20221124015237.172948-1-yusongping@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.73]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
X-Mailman-Approved-At: Thu, 24 Nov 2022 08:30:36 +0000
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
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The logical operator '&&' will make
smu->ppt_funcs->set_gfx_power_up_by_imu segment fault when
smu->ppt_funcs is NULL.

Signed-off-by: Yu Songping <yusongping@huawei.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index b880f4d7d67e..1cb728b0b7ee 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -161,7 +161,7 @@ int smu_get_dpm_freq_range(struct smu_context *smu,
 
 int smu_set_gfx_power_up_by_imu(struct smu_context *smu)
 {
-	if (!smu->ppt_funcs && !smu->ppt_funcs->set_gfx_power_up_by_imu)
+	if (!smu->ppt_funcs || !smu->ppt_funcs->set_gfx_power_up_by_imu)
 		return -EOPNOTSUPP;
 
 	return smu->ppt_funcs->set_gfx_power_up_by_imu(smu);
-- 
2.17.1

