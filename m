Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2387C87FDB
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Aug 2025 10:00:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7FA5F10E40D;
	Mon, 11 Aug 2025 10:00:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0KUSZ5gg";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2057.outbound.protection.outlook.com [40.107.93.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3873110E40D
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Aug 2025 10:00:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TiPELfRoLCpUq5viQHie2HoweadlnwQzevGYU2BxibSJEV7mpNmSnGYNHco6JxYUehWdhTfZ27c9lVUGr3mJbJ9aTvplfey+x0tGhQsrHgJtWv9231Ejp6u+YUXywM6M9WE5c2GzPg3k7giAlDd2MNrThYbg3xzauTNxp6LxxndelcSGrmnzbf9nizNZWV3wlX3Rp0rGHV9ZH7NP+s4d6NLKx1DUa7jXikVWBaXWgUWhvhfgIEcccTQhGF6bQ/fU2qOnCvD0IrlkdMmlel6+hdDi0+ssihA/Feg01bcpr8Fe2YiUowvzqb4/sf2KIE8M2EJHGmQGO3quPZTyqTrjGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2sH/ANUyXtBZFgKsJVjYnQsbfhhHR3hHPsFieDCEFyU=;
 b=N7ThQFwHjC5wckbBxa+SyGdMem/zNrrlZfTuJbdZ3vhL3tTIIcdeqLgawYFTuUEzg/LAI32tJyb0UB0EZWtyMJXOMvSDWyku7zZGdvjydRR8ZRuLCkv8PmuR6yqx1faXe6K/oauxPPtzOarH/9kL7C2k6b98RWPTEzrK67Tnod7hEmqXeAYcac9eonXjhd4ek8jQu3Y06ttzM6/Ef9X/p3ZW5SPeK8yxdquguZZWjLepzrfIpM0c1F7N9CFfbM8ZqcKyVpj5U9U7YZdrpFeDqKnnvVcIDjprJlhlBd7Si3SQUMFEqGllde5FNA5Mi3zXuKaDmtJxKuJzMCGUGgTjHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2sH/ANUyXtBZFgKsJVjYnQsbfhhHR3hHPsFieDCEFyU=;
 b=0KUSZ5gg5EKzsFjxQO2DxmbliTYWuqZbiuCBZ17LeoHZItvTNqOwEggvEG5Fe2uMjJxNzBhRJQYKo9q+I1p6wM58Bf8f0+M+LBeWfkgpfE6fmy2mYPTNfvE5gr0ovPXmpOMibVwe8kTtIJgClpCGOOVMg8rEqUvPU4VMCet/rQk=
Received: from MW4PR03CA0116.namprd03.prod.outlook.com (2603:10b6:303:b7::31)
 by LV8PR12MB9691.namprd12.prod.outlook.com (2603:10b6:408:295::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Mon, 11 Aug
 2025 10:00:44 +0000
Received: from MWH0EPF000A6730.namprd04.prod.outlook.com
 (2603:10b6:303:b7:cafe::b) by MW4PR03CA0116.outlook.office365.com
 (2603:10b6:303:b7::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.22 via Frontend Transport; Mon,
 11 Aug 2025 10:00:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 MWH0EPF000A6730.mail.protection.outlook.com (10.167.249.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Mon, 11 Aug 2025 10:00:43 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 11 Aug
 2025 05:00:39 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 11 Aug
 2025 05:00:39 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Mon, 11 Aug 2025 05:00:32 -0500
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [v8 09/11] drm/amdgpu/userq: add a detect and reset callback
Date: Mon, 11 Aug 2025 17:56:56 +0800
Message-ID: <20250811095937.1978747-9-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250811095937.1978747-1-Jesse.Zhang@amd.com>
References: <20250811095937.1978747-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6730:EE_|LV8PR12MB9691:EE_
X-MS-Office365-Filtering-Correlation-Id: 4460b6c2-64e9-411b-7bb5-08ddd8bdef53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5aHVt7vLwAPv4pwWaqgqYwjtq5UP4+ZGeFPOishnbJJGY5xXDzhKdtgtjeV5?=
 =?us-ascii?Q?a9IoS/+/0E3TnYgOnEFJJ2WyGJ0gcYEXAw/dEp/qbCAWknCl8xS9HJ8JTvXv?=
 =?us-ascii?Q?6Y1LbER24MbcV/wMqQR5eMLv9xDnN4sdaEiPnfUsDtgWu/4GB/0AvMOlE0Zp?=
 =?us-ascii?Q?7AjEIbE2QTAul/Y4KiSlDH4PNrdOn7BPLcPNIPZ9R9ti1GsQmTyfpwzQsk77?=
 =?us-ascii?Q?diJo7oEcqITCZHz9hfvVv7i0JrbRaG75pC6CmCw8PDe9oXp/hEswd842v/x0?=
 =?us-ascii?Q?eA4rmAbmB//tOfLpZt/JJzqbWTWq2hATdgefW1iakIc3KAh95Y7YZkASo38R?=
 =?us-ascii?Q?w4ABRPzN5BBPxfDe/NoCdw/27lK6+utXS5Y6EPyOfiVdjaLnE1Z0KxI/T5rR?=
 =?us-ascii?Q?76mls+iTdl1zx3wg4MlLfvRFWoSiosma/oPIWKrTtxSDspeEwZ7RT3OLlEvv?=
 =?us-ascii?Q?+cKsHxl8W9V7f8P7nqAiGApf3gPTK23HisGDZKzcgJaln18qBYHs8wP4cPbB?=
 =?us-ascii?Q?bs7ipxPMHwhCE0BSNpJBPiPGmjy9qlB0QA49jAfvXaAwwk4tOCZkicdXFs8s?=
 =?us-ascii?Q?lOIxwMwm9N/nUfYjWF+OKIvyosAm9X/w3HD2JExAURu/YRtM9G2O3kdTkhPn?=
 =?us-ascii?Q?DQVPLVbyDvVqMfR6xXpxD4CcLXWu2azZihIia2Y8l1Xe6yhGrGlirnKUtOpy?=
 =?us-ascii?Q?CXxL0soh+4YsF/kF+A3P2IJNYWIR6iNwtwFmYx+/p56pOnRR+0zz6tUjKeb+?=
 =?us-ascii?Q?YqU2EWB2Vr6F5s3lPriFFO1ZDJetdhytJhSBv0UZ6tIzV0KQuKqvCXJ8iL3F?=
 =?us-ascii?Q?9F++7fXaXe3siLSb4l3io93YHuug+65Gmg09O22qp8/vzv074481ZgSHTEPj?=
 =?us-ascii?Q?eOmr9FoGmvJbocwm+l1yiIJl1FRPJqY7Z2qcYNvCjHsKXjDlxsdBSWxSbMWZ?=
 =?us-ascii?Q?JQjqm8C7idJFqDZ9JoHNhBJ1uKobmDpfwaphbXqIrStlblxxSkdPehDs9toQ?=
 =?us-ascii?Q?rSyHq+m/eodcumJzaYIRPs7kI3HymajmynFzy50usK5hXoGdxWtPBZLAB2pI?=
 =?us-ascii?Q?CxWPt3vVtyojv+Ki2n4HstWGSfd6B3IXkwPhr5I6YoXvGcfCazUu12RPUlUH?=
 =?us-ascii?Q?64h3Ahw5K335uYX3SABsHeDQ6snVKb12NOqBaJGALvtKzbBg/X8MZ/SBFhiN?=
 =?us-ascii?Q?mqo4INgsJp0Xv9EkhW5K5gj8IeUBzqD30GWlPQFG+XbuIWgCpvkN04xv0nGZ?=
 =?us-ascii?Q?uXY57usTtqVB93wOIJEzzDEyEgmgVl0z7RIv2J1kEEwn5pO2tSh8vsBof4XB?=
 =?us-ascii?Q?/uBsCKQ/rZt7QTvMQI/9/NHCO2NW9av9q5vC6Gfrp3b7mYGX009NrTfTVAl+?=
 =?us-ascii?Q?fhxL+/59xhdVPwY+MlasuTWz7j7tIQRy1Bl4c9GdcfdTGBXwZhRju7Eef/CD?=
 =?us-ascii?Q?ZHTiV/1WP3+CQF8wle69Bemi8ixbFSnWuzAe4DPUH0xj5LakxR4JWT6fTAm0?=
 =?us-ascii?Q?q04fBmeDftkVJnCfuKBOHQNHp8TM62TkKhgj?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2025 10:00:43.0787 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4460b6c2-64e9-411b-7bb5-08ddd8bdef53
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A6730.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9691
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

