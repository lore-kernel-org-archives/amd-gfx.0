Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D698CCA0EED
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Aug 2025 01:42:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B9FA10E850;
	Thu, 21 Aug 2025 01:42:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BhmB5bri";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2078.outbound.protection.outlook.com [40.107.101.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 156B810E850
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Aug 2025 01:42:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hQT5W+A8RHh1AJ1BsgdcU/9fxP4XoRH95UGDtC5MPehnz05BoZmkh0yU0+zRJvkY4/A4CnAjp1XlpcB9M7U1+TgNLTgPJ5T3Mt8+KdcZ9TRIyS4af6sR8SFBfD/v5FBT2PTR+IoXx2ieyc5gf+3hyi3AZaMwLQvL2DEFHz5YeK8ON0+dkyCq4dg3Rmlpd0gePqN+/6TNFYDlZgTx+kiRu2aEWMy/wLd6NJUUY8e0w+LGoNHZqe9dkYai851/6UKhdswMSBnJnIzedMDUr746So+wGFNKBffH7xCslebq31CktNQmOWdIcq5kjKVuqzHLxu5+RBdyrS0qgvTUUO4HJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2sH/ANUyXtBZFgKsJVjYnQsbfhhHR3hHPsFieDCEFyU=;
 b=BMMhPpKLdZCpOYMuUjctB4odZGXzLYdPa3yv9agU/Eb3Vphx7DraMFnOqFr1nkUrPQr6P4U7O1vJTpovYKZJRYAIrIYk23332m11xvUfcj5p0VP2gLAkefqCs400DCyMf86he2HiCbwM+GRt3o9htkcNQDdvhTqb1aC6Lc2tqT8ZCW0EnWoz5YCmUKwkR/fMs4nXeg3PDLLu+qKrEZJcdbCr2dSIl17f7Cb27Ss847T4IZv/ivXu0SVTLDb+UpaexoTLKXuy+14Jb5gEdAJ6ekbkPz0l/HDKgblIiOvLkXMvu0xAwvWfVo8jL4W0ZyfGWydBa5SLG4rH7JAXRs3eKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2sH/ANUyXtBZFgKsJVjYnQsbfhhHR3hHPsFieDCEFyU=;
 b=BhmB5briADnITjSLvCUjht8+fuXKhemJS+jxhFtzCupn+ctTLBxfwOIhbe8nAl9eS+vgtxaHlgPrWt1vDg3AKRp7cx1anZThD53GeNJHa9ZGRKo+ggh4P2bqnb6e17LoDoNX4rHj1ad1xY+AInig+Mit5XLKOjyplO/En+kAFkU=
Received: from CH2PR07CA0034.namprd07.prod.outlook.com (2603:10b6:610:20::47)
 by LV2PR12MB6015.namprd12.prod.outlook.com (2603:10b6:408:14f::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.21; Thu, 21 Aug
 2025 01:42:22 +0000
Received: from DS2PEPF00003442.namprd04.prod.outlook.com
 (2603:10b6:610:20:cafe::3a) by CH2PR07CA0034.outlook.office365.com
 (2603:10b6:610:20::47) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.14 via Frontend Transport; Thu,
 21 Aug 2025 01:42:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003442.mail.protection.outlook.com (10.167.17.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Thu, 21 Aug 2025 01:42:22 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 20 Aug
 2025 20:42:21 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Wed, 20 Aug
 2025 18:42:21 -0700
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 20 Aug 2025 20:42:15 -0500
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [v9 09/11] drm/amdgpu/userq: add a detect and reset callback
Date: Thu, 21 Aug 2025 09:36:11 +0800
Message-ID: <20250821014115.566598-9-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250821014115.566598-1-Jesse.Zhang@amd.com>
References: <20250821014115.566598-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003442:EE_|LV2PR12MB6015:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c1c2b8b-9383-4b92-f24f-08dde053f921
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?89yKIOnXghFrVMcPlfeqh/ltcT4rYXhmf3bF6Ky4t+ZluAzEE4oRgPKLqAB4?=
 =?us-ascii?Q?iCGe1cQiMVO+7Qe6BT1Qg4E4ePCS+8xycjbN+rAa+PF/8Xp9jZWXyQc6jARC?=
 =?us-ascii?Q?GNeolx8WvkxcS1xx/hvTjHVh+3Ue++HUxEj7m57wI3zoAr/vfo470iJtF/x6?=
 =?us-ascii?Q?pfSQgRvluv97gs3Vv+scEarLEA2zBBHKwbRxfSlvAmpD4R00odxjGr0oi4q+?=
 =?us-ascii?Q?pDeQ/pHEmkFyWGrJwbTCf65NmrRKjyBjCJtAOxMwdWWJKk7Rz9Q0OyzY70BG?=
 =?us-ascii?Q?1PAMQTRCg7VYCA4Tl4/1rbJyUNSlfdkfCSmUGYiWZW/B6VBeNR8rB/44wd1I?=
 =?us-ascii?Q?L+YQWGgKok2lsE6yIbFRUuMR6sOODBbIZWHUK0N5qesxJTzILB+ufEzwQpiq?=
 =?us-ascii?Q?pE78z2e/Z+X/7mmfqzROn7Xsq8VzobNZihkJe5pb4ap86CRuyCRbNDsZbh1k?=
 =?us-ascii?Q?cHk2kblqyyygSagsLgNY8qp6LCDftaqNTAU0uZC6QaWVveM7nu+XBiKM6mAY?=
 =?us-ascii?Q?5lkyYWHOXg/pyTTddquyy3qrJUtHGg9xSGxL8uiTj2Ht3SfV12jli6ntL1qI?=
 =?us-ascii?Q?DbCsMD1MAhfbKJutfbZTr/waI76HhYvRBUQ8VU90xOM/UUPazr5QkcZoQpVg?=
 =?us-ascii?Q?hb49TiK012xbfbNg//0ZMrH4Jgqih5qh8/ZERB6afu4MjR1Vpj9jFeeNsDx6?=
 =?us-ascii?Q?Mu3JSPaR6JRBtD+L9OGmnU68z9Z1VmMwe9xWdfyjnDAJdi8ao3OUPIQDk1GM?=
 =?us-ascii?Q?CFT6YYwWdDJASIuE2+F09VhmZLWK4mt+CSan1oDRAGIAtn3SZMIiGGR2TPC+?=
 =?us-ascii?Q?2Mm1b8B+4ePzE8YVE/n/uWP9nXi5ZFSoetwJOMs/mOsqcipe+pUtvJ/Ljuiu?=
 =?us-ascii?Q?0X+56/HmzzVvhoHcZhkYwXEeTnEJofYVThs1OMhefxlOqQ1Q2fM5ekhvIje8?=
 =?us-ascii?Q?B12gv4TGaY5GbV6itc67b7f8cuBv0oc6zZknU1MMc4++VS85WduakcarTs4+?=
 =?us-ascii?Q?d5t8nlhniVKmn8/vhEXJ2B3Xk77kLs+5D2L1MkrswjSYPXu6+yyutRMBfAVk?=
 =?us-ascii?Q?1+eMsqM7GY8NEc9VJ+RDKaZsf/2IH92kcAB6c9b42aTuULbnOaRBVQprygrn?=
 =?us-ascii?Q?VFEPl+PXcPLwyV2AFgsRc0o+Zd7OErtqwLz+cJ9BO7R9dbHbeTyP5j7+cy9z?=
 =?us-ascii?Q?SiPUHli9V0DyXEwl8TAoBQdL2gbcVugSTa9ZLXLyveNBMBzo9i1OpBWF18Ar?=
 =?us-ascii?Q?6NWwhdnjAzGjcic27RmjdEZ9zd9aytraJ0kM4/X/HplZcxAv/SuLMNcmn3gd?=
 =?us-ascii?Q?jJYoWGZ5j+lH/6FjjMWydvvRWN5R7pMvwxiFn5ZIMX5Oote3S9SOOl0rf63I?=
 =?us-ascii?Q?VmQzjTykaSE+aNksnaN3v0KhFEbgEaGpD/TOZ+azOCgbOtJ6vJ3DV+Dxw1vq?=
 =?us-ascii?Q?g7E9vyGEZZA6M2NldS1AUIu3RCwDPTtCxGrS6lNoSXoZKyxQAlviB34bSVgX?=
 =?us-ascii?Q?CzUPCeFVCN+hODqRnyCdEmRe77MRbOKq343Y?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 01:42:22.2320 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c1c2b8b-9383-4b92-f24f-08dde053f921
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003442.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB6015
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
index 46b24035e14c..180bd4347bdc 100644
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
@@ -403,4 +451,5 @@ const struct amdgpu_userq_funcs userq_mes_funcs = {
 	.map = mes_userq_map,
 	.preempt = mes_userq_preempt,
 	.restore = mes_userq_restore,
+	.detect_and_reset = mes_userq_detect_and_reset,
 };
-- 
2.49.0

