Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 489EBC87FDA
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Aug 2025 08:41:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E1E5C10E4E0;
	Mon,  4 Aug 2025 08:41:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rjp3ycci";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2052.outbound.protection.outlook.com [40.107.237.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 66CD610E4E0
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Aug 2025 08:41:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=krA9j7TMXuy6KmTtbr6aOdIoigSLd6aW+JUavc0N5tJxRiuoON5ySgfyVRNErm5z5RexFuv8FPsNn7TPh79bS5f+rBa5MLg9L4iHso867Rx9rhL+S/7GtmuFDgOWFuY1rlFMXhBg3hG0N3+R4JI09l1WhxTDiGoHv/smDqXjWkhwz7oXSrVSim07o5p5nz22rZ+dXOzkb8g0cO24q7qyoREVkTLa+rGW5L4+q+ImNmdJ/v6F/BZKpulWRzzlYeaIR0lhsBH2gRSUoTvoSOJlOohOzPturaidZsKYYNr3JCQbQZxNl8YX0DLNFo0VqHNKGRvzdqkXZjvI5/lgwAwHmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U7MZFH7Yq4SJQSfgm3Xsvgi4HLUEfgrbJOshAFW/nwg=;
 b=DatjtWkciz8SvziAsEvL7h1ljDzHKEPCdSGyg30hpr2RBkeg28PWMkiqu1lLZc15qbqCfCO6KZ2BL3wrtXCHTiZ3TBMemw6auwD5gQwnAKF8TjuMBW2Er1LKNLOW3QuTGlYAwMKcL/+u7r3LKFu2CjkGgSYpdBzDC2pFboGybLqoT4O3/RVzsnc/D8ZuNLgubAIHMmWzOr+S5V9yA0RoBJgEpezGlMSkHFCgW3z8Ik46bUX7j+Phu77Nht/eETZ+TdAOV/WOZh9P0SfFL7C6qvL7uEZrfQPjrFB0sP5PUvapHELgMZbLQ7f7lVkBoLpQKLF4NVU+F2DiC9+yW60e+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U7MZFH7Yq4SJQSfgm3Xsvgi4HLUEfgrbJOshAFW/nwg=;
 b=rjp3ycci/w4uwK6W23aX5XTo9aKf0xy8MlIYokIaSSSv5CqYDdjxL9v2YlKfqaWpzEgvm3ZllyfSc5aEXxtK+CLzL+Ym8Slx4zhX1mZsBH7VZ9z4TQE6PN+IXblOZn5khG5GgcpXrPhhtDy7UnzBtf7iX/LFrPBncyyhrlvCNFs=
Received: from BN9PR03CA0867.namprd03.prod.outlook.com (2603:10b6:408:13d::32)
 by SA1PR12MB7221.namprd12.prod.outlook.com (2603:10b6:806:2bd::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.18; Mon, 4 Aug
 2025 08:41:01 +0000
Received: from BL6PEPF0001AB52.namprd02.prod.outlook.com
 (2603:10b6:408:13d:cafe::5e) by BN9PR03CA0867.outlook.office365.com
 (2603:10b6:408:13d::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.20 via Frontend Transport; Mon,
 4 Aug 2025 08:41:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL6PEPF0001AB52.mail.protection.outlook.com (10.167.241.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9009.8 via Frontend Transport; Mon, 4 Aug 2025 08:41:01 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 4 Aug
 2025 03:41:00 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Mon, 4 Aug 2025 03:40:54 -0500
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse.Zhang <Jesse.Zhang@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [v6 06/13] drm/amdgpu/userq: add a detect and reset callback
Date: Mon, 4 Aug 2025 16:38:24 +0800
Message-ID: <20250804084029.863138-6-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250804084029.863138-1-Jesse.Zhang@amd.com>
References: <20250804084029.863138-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: Jesse.Zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB52:EE_|SA1PR12MB7221:EE_
X-MS-Office365-Filtering-Correlation-Id: 81c3ec6a-7fbe-4125-f39a-08ddd332a415
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?kCHRTdJ98ZO7hDQ9dxo8gFrytS4OS7EPSKgUGyofPtAbI331zWVhR7R8Xoxu?=
 =?us-ascii?Q?TxAzp0VNkFJIQzzDeYaQOdyn9TghpsHtwqJb593IwB3jCGUokpqdy0SJ1XJ6?=
 =?us-ascii?Q?ujCeQi23UWOfh/it3Ci1IROPUknFaYEVsU0T+MlFdyY61UBWQSKy11gu1hqK?=
 =?us-ascii?Q?3bd5GbHqZwtiqcSmssS0Qvg8GDbbymhI5QKTCJGPE9NRrNoQWDnbpgdZ3RvP?=
 =?us-ascii?Q?sdl1AkGlg7+lsaTd6GELy9TN4MoQU3VCdYEFsb/QJQXZ9cxQ3NVHfANQNceI?=
 =?us-ascii?Q?uHM1ahg8cPpSR24WsJ573JzRLRstUtLU6ZhaddJG/IPL1+BVy9LM27DYQ1Fo?=
 =?us-ascii?Q?W7vHFQizb+fwcrHKKVPuqj/N7ezJU+Uf8FusAKGwWrER/rI4vTCLGemOViHg?=
 =?us-ascii?Q?6KSoruWA74wcHrbRQLiu25eMkNHxxfJx/bXAWGwkq1o4VBtpzfiUjVK0RowM?=
 =?us-ascii?Q?oak2+I0yZVkAmfhPoQmMeKmzNw3CbbPtqWTOMoKgffOGkNz7ym9OOhfkYVcS?=
 =?us-ascii?Q?pPqO3kf1IA6O4RTRk3dWRYYdYsmQRaa8tWd1/l/q0t8GhHwmo18bRkjlv3sA?=
 =?us-ascii?Q?swh8HetMoXjGNlYMP9/WsgzaIkrlVlicqLZvabpk0F5vBPUu1dGwEIeFacKA?=
 =?us-ascii?Q?egJjBw53QbTPDJfFGgiBzdELacNuQXRIFZtuj5/wkOLTm2hc1x5ITKbtVWHD?=
 =?us-ascii?Q?onv1XaK+RRP8QjqMMcoZV8GREDGHjWJVeiVqm5juuXBzpAmrELuUbG3vx6L6?=
 =?us-ascii?Q?zoLEcErakGSyB2KXs/qaiV2t4qlyzL8BUGXUvnQfxjcMmaNtAp7VPRjBR2rx?=
 =?us-ascii?Q?vzI9XvsFre/TTveQWDQcR8SsbeyNdGIpccukipGakWyRsOYm9apHqpWgnm+B?=
 =?us-ascii?Q?UVF2F/gRlmXfkUuNmXj+BwPfSECVlxlvkT/+bqSPk+N6v4WCLhv48ihCf48B?=
 =?us-ascii?Q?HuYKYVp2fUkBmNxLdaU88XXRaUXAQQggi2PCsksDHWAvvjftyjpmQPOyZLaZ?=
 =?us-ascii?Q?P5CxDui1XSb+W5nYyzumN0R2HyPu7/mjpyjjn0BsWK4N+sVPqR/UkShopgvI?=
 =?us-ascii?Q?K8gVwfXR/7e+Sv8S1hu7cyKJ6II6iHI9bCd3C7H74NlgmtkEfL/JGGRzHtC1?=
 =?us-ascii?Q?kAGYg1yktV9oY3SjOahBkDKslNbH6s2JHUq7yVDLpzgzGTQ+4jpeXQNgqB4b?=
 =?us-ascii?Q?EQ/Da/ooJLbXf8gfHHlGJsuEO/5NYUgBQvPif8GCpLCkW+0HswV/mz6OoacQ?=
 =?us-ascii?Q?+SmtFXetvMGZ45IEOrpxOE+ZBiLDJ5dKDW65rgXwXbXrFTvn3/HHBCnWSmLG?=
 =?us-ascii?Q?CXrdL9oH+aM/Utz50apOCPNE9dmV3MB7XBFRzW6KGMtWNfkNwj4xjmpwORBo?=
 =?us-ascii?Q?dwI0o3HXahMk7AwPo8MbTa/7tkfOmq/ob8fNxudy1g+CawU7YDOD47dR99ig?=
 =?us-ascii?Q?p3hWV07N8HDczic20OFTnJsgbR+7aEHo8MdiBH3dm/PMNKgmH2ZQhHBae2iM?=
 =?us-ascii?Q?Z/0z+xluMCoib2pmcNXpdunKaz8toYqj576J?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2025 08:41:01.0763 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 81c3ec6a-7fbe-4125-f39a-08ddd332a415
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB52.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7221
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

Add a detect and reset callback and add the implementation
for mes.  The callback will detect all hung queues of a
particular ip type (e.g., GFX or compute or SDMA) and
reset them.

v2: increase reset counter and set fence force completion
v3: Removed userq_mutex in mes_userq_detect_and_reset since the driver holds it when calling

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h  |  3 ++
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 49 ++++++++++++++++++++++
 2 files changed, 52 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
index ec040c2fd6c9..0335ff03f65f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -77,6 +77,9 @@ struct amdgpu_userq_funcs {
 		     struct amdgpu_usermode_queue *queue);
 	int (*map)(struct amdgpu_userq_mgr *uq_mgr,
 		   struct amdgpu_usermode_queue *queue);
+	int (*detect_and_reset)(struct amdgpu_device *adev,
+				int queue_type);
+
 };
 
 /* Usermode queues for gfx */
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
index d6f50b13e2ba..a871bac71e1e 100644
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
@@ -352,4 +400,5 @@ const struct amdgpu_userq_funcs userq_mes_funcs = {
 	.mqd_destroy = mes_userq_mqd_destroy,
 	.unmap = mes_userq_unmap,
 	.map = mes_userq_map,
+	.detect_and_reset = mes_userq_detect_and_reset,
 };
-- 
2.49.0

