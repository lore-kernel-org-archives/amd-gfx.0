Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC1C4CA0EED
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Aug 2025 09:24:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9781810E946;
	Thu, 28 Aug 2025 09:24:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uiZymMBU";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2051.outbound.protection.outlook.com [40.107.237.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D95210E946
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Aug 2025 09:24:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TqCM5/S8yXuZnWfFZBvYIw7uWUtdhdwxnN4/PHZsebF6sX/C5Pc9D3Y6Qk2Kn851eHRGV6to+fpTJvp0mCmObDjOjWK4o2XxDnE7PLEaH2EZgjvST3ZnaAuk2opduD1fYYGctjyIZ1WBi3MQebwsP3JyumqYY4c4OHmAFf9Rh0mgLOeqBxK8XR3P47HWE9LKEdw9UDpzIJPVxeGb9W7UDJ7PkpqO1mB52i11sQKKqErGHBgtKhJfUDcWskNd4CsrjxaMcnlk29WDoQIZBzNz+hHOVSIKnT+PTlkKM9vac8WTJ7A37HYuHOy2DXNFp85KxCHJkkyIoy8bfcPUmu17VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6C4Erlf5OhtdM1NVSawPaP2lo7oTLrG8440S5jOobIc=;
 b=Fm37UiUIsSm6X4iqqDmRiu1FRp44A1O/lxVdzGt6M+Pb0ekiGgY5jocJCgI/bU9tY4mFyWbgmxuZRiiZwaW0IVFhYrSSi8smdb2xVRz0oGP0k8PtJFqe8q0LlPGgW4GYG/hk16/9+BLoVJEsY9QhHWZgp7Ey6Mn6/QP5+xKINAtp+g8SFlWz7c2mbIbA3EFXvr0ximLOSEuSwUBNC3S83noSwGxj329X7SaxabBxC5mfvT7awrIxgjQLpHcXMXysRW6dAbFcXyViuLPY4rg4IQ5pLjr2v/WkYPsz1qpog1sI18d2BWuiVRMdJduJogb8kSYC7l1HPVNd1Gi+m7pWfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6C4Erlf5OhtdM1NVSawPaP2lo7oTLrG8440S5jOobIc=;
 b=uiZymMBULHHase77UGrGCtme3XmuuaznPfhrwjFE2ndMJP6csF1IDzdVo5IGhfnZFGlvbSy6SCQCeP+iJvsOkY6gmphHSfEsZVS60m/W3ZCvNYjHnGADvNWMWqkcwkUE1wfe85fxJ7CP6OLcua5/QA4pVqMGeWholhz6vkjgVB0=
Received: from BN9PR03CA0739.namprd03.prod.outlook.com (2603:10b6:408:110::24)
 by IA1PR12MB8520.namprd12.prod.outlook.com (2603:10b6:208:44d::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.17; Thu, 28 Aug
 2025 09:24:44 +0000
Received: from BL6PEPF00020E61.namprd04.prod.outlook.com
 (2603:10b6:408:110:cafe::18) by BN9PR03CA0739.outlook.office365.com
 (2603:10b6:408:110::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.20 via Frontend Transport; Thu,
 28 Aug 2025 09:24:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL6PEPF00020E61.mail.protection.outlook.com (10.167.249.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9073.11 via Frontend Transport; Thu, 28 Aug 2025 09:24:44 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 28 Aug
 2025 03:45:58 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Thu, 28 Aug 2025 03:45:51 -0500
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [v12 09/11] drm/amdgpu/userq: add a detect and reset callback
Date: Thu, 28 Aug 2025 16:42:15 +0800
Message-ID: <20250828084457.1999535-9-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250828084457.1999535-1-Jesse.Zhang@amd.com>
References: <20250828084457.1999535-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: Jesse.Zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E61:EE_|IA1PR12MB8520:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a101c83-9cda-4926-3159-08dde614b9e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?jsM9WKDGr9SZPY6q3ZmrDZCl2g7vtWYeFiaHrs1PtP9iFhPqhq1balsGBR10?=
 =?us-ascii?Q?1rXPVVOs/CKY/hiaCw7FOpCd/amdyNW8asHjFeISzECfxLFzgnUy2ejhxoV/?=
 =?us-ascii?Q?alC1KgGhY2EmPAtuS00VpmdhfEfiYDAy6C0Z+jsb0x5Zfo6KHkKndc7agc0e?=
 =?us-ascii?Q?6a71WjFBd0nbMqqw9FOrv9ziZIIWD07DnSwrMpaatahAJPAlw63tamFyQOom?=
 =?us-ascii?Q?/A0mIq0mLIQlHjjtarctaWGwTScT9gaDyGvFUImatdXNL52fgEYdOWO9jUaR?=
 =?us-ascii?Q?AOOfpoGtnXj56yOJHZHOb8KCtAb1oGLYtI4BDJBPSkojw6Ocamwrh4no4QUt?=
 =?us-ascii?Q?cPp27d4s/wLd9Tsl60HrREDWZJ3YtvIEbD5AMzreqcbxMeEfab0XMfaBMnoD?=
 =?us-ascii?Q?w87l0+NSyKFg6LLoT4D6Pvfz0y1iZa2/MiUHO1e8q9TI3LGmOs7dEVqKybvO?=
 =?us-ascii?Q?IaAzfyuvsc2mIRrJ/E7+Twn4DG+fZVlx6ATuAb7a378H4Zh2+lz3J6qV3Znn?=
 =?us-ascii?Q?3lKRSNdz5ki+E8OKRaowK2wr/CER5Ho80+r9OYDcLuv3RSmVzPQNFBs7h6Uv?=
 =?us-ascii?Q?5eZ7agJ7gxkaicTfk7zRh6FC1mUC/ri0PWABjz5Jg26NBUw73zLB9nzt8WSO?=
 =?us-ascii?Q?aIMWOxZpXKKzu9CXGXvoU4D/fIMPsDt1yhP5I+BpuTejasOFHAzFQddOrAzA?=
 =?us-ascii?Q?Kh69owe8rVBG/r91OdRsdEyZKUPqn7ZY814GTZHvL4ownYuTqYkdNie1xJLN?=
 =?us-ascii?Q?LnrLPE8XljCKe9wsciofZomRX+hC+LrGb197BTcxnGbKxUKvZojCBl98B/GD?=
 =?us-ascii?Q?zbP3eZBB+NcNUD1KgLniWgHMcBGglVFf9fRpfmNVAPqDkhnqm67mEPskbTTW?=
 =?us-ascii?Q?9RKshCEVIduNG+P+qJ72wSUs8AP71MNOqbjIrT52hlzhskmMNBHn/UZW6HST?=
 =?us-ascii?Q?xaGgKdKfuBm7oKgSdDaIaR5NCj/247v3ifk0YQsCD8vCaiHNLHEaUYAxlDDr?=
 =?us-ascii?Q?S+nvPxUPa22SlFD+AFOELDGls6qQiZXJz2GB44l6jXkiSOeRo4ep3TI86q1o?=
 =?us-ascii?Q?SK8LiVQS3vVJs27sIHE0oB8L3RGO783yJMubrrheZFn/udG4Qp65rDZFcpqy?=
 =?us-ascii?Q?6kDkN3ttF1UoYPHyBAcmg4511cpYaEP5kCECtyezbEaPY1rim0pefIi18qmJ?=
 =?us-ascii?Q?WA4Ijtyoiurw/AjQ/y9ci/myGN8IKWHt10zFduINlloUyFPlesVKnF6ZPgZQ?=
 =?us-ascii?Q?yEzyIuhQX7h/SWlMNT4uYz6XUBZo1ikileCqJTOSJPshW82fHI5vlx2gLyVd?=
 =?us-ascii?Q?tdX29xCwJvUa8sPW4iB56KKSU9TldH2z+6J/Go1L0nRpsvRlpLB4ChMwBWMQ?=
 =?us-ascii?Q?fkXQ2xzp5ulpB+1X2/iPxBQ7dpUaFTbkQ5NXL2kMhOPmoPrQ1rAwfMUIL5e2?=
 =?us-ascii?Q?kDU1kniDms0UunaxwZG3oRMbE774/LvVVkmqEKplbU6AvSXsvLViyQUU4ZfR?=
 =?us-ascii?Q?P8bwbfTbao9QdkpxbQbs40iVvitJkk06OSXx?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 09:24:44.8719 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a101c83-9cda-4926-3159-08dde614b9e7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E61.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8520
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alex Deucher <alexander.deucher@amd.com>

Add a detect and reset callback and add the implementation
for mes.  The callback will detect all hung queues of a
particular ip type (e.g., GFX or compute or SDMA) and
reset them.

v2: increase reset counter and set fence force completion
v3: Removed userq_mutex in mes_userq_detect_and_reset since the driver holds it when calling

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h  |  2 +
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 49 ++++++++++++++++++++++
 2 files changed, 51 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
index 5111d7dce86f..9fa0d1a88d71 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -81,6 +81,8 @@ struct amdgpu_userq_funcs {
 		   struct amdgpu_usermode_queue *queue);
 	int (*restore)(struct amdgpu_userq_mgr *uq_mgr,
 		   struct amdgpu_usermode_queue *queue);
+	int (*detect_and_reset)(struct amdgpu_device *adev,
+		  int queue_type);
 };
 
 /* Usermode queues for gfx */
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
index 502fa0a40107..5fac18dfeca3 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
@@ -21,6 +21,7 @@
  * OTHER DEALINGS IN THE SOFTWARE.
  *
  */
+#include <drm/drm_drv.h>
 #include "amdgpu.h"
 #include "amdgpu_gfx.h"
 #include "mes_userqueue.h"
@@ -198,6 +199,53 @@ static int mes_userq_create_ctx_space(struct amdgpu_userq_mgr *uq_mgr,
 	return 0;
 }
 
+static int mes_userq_detect_and_reset(struct amdgpu_device *adev,
+				      int queue_type)
+{
+	int db_array_size = amdgpu_mes_get_hung_queue_db_array_size(adev);
+	struct mes_detect_and_reset_queue_input input;
+	struct amdgpu_usermode_queue *queue;
+	struct amdgpu_userq_mgr *uqm, *tmp;
+	unsigned int hung_db_num = 0;
+	int queue_id, r, i;
+	u32 db_array[4];
+
+	if (db_array_size > 4) {
+		dev_err(adev->dev, "DB array size (%d vs 4) too small\n",
+			db_array_size);
+		return -EINVAL;
+	}
+
+	memset(&input, 0x0, sizeof(struct mes_detect_and_reset_queue_input));
+
+	input.queue_type = queue_type;
+
+	amdgpu_mes_lock(&adev->mes);
+	r = amdgpu_mes_detect_and_reset_hung_queues(adev, queue_type, false,
+						    &hung_db_num, db_array);
+	amdgpu_mes_unlock(&adev->mes);
+	if (r) {
+		dev_err(adev->dev, "Failed to detect and reset queues, err (%d)\n", r);
+	} else if (hung_db_num) {
+		list_for_each_entry_safe(uqm, tmp, &adev->userq_mgr_list, list) {
+			idr_for_each_entry(&uqm->userq_idr, queue, queue_id) {
+				if (queue->queue_type == queue_type) {
+					for (i = 0; i < hung_db_num; i++) {
+						if (queue->doorbell_index == db_array[i]) {
+							queue->state = AMDGPU_USERQ_STATE_HUNG;
+							atomic_inc(&adev->gpu_reset_counter);
+							amdgpu_userq_fence_driver_force_completion(queue);
+							drm_dev_wedged_event(adev_to_drm(adev), DRM_WEDGE_RECOVERY_NONE);
+						}
+					}
+				}
+			}
+		}
+	}
+
+	return r;
+}
+
 static int mes_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
 				struct drm_amdgpu_userq_in *args_in,
 				struct amdgpu_usermode_queue *queue)
@@ -423,4 +471,5 @@ const struct amdgpu_userq_funcs userq_mes_funcs = {
 	.map = mes_userq_map,
 	.preempt = mes_userq_preempt,
 	.restore = mes_userq_restore,
+	.detect_and_reset = mes_userq_detect_and_reset,
 };
-- 
2.49.0

