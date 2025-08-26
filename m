Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA94BCA0FE7
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Aug 2025 01:48:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8886710E5A8;
	Tue, 26 Aug 2025 01:48:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lRNoHYjF";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2059.outbound.protection.outlook.com [40.107.94.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AFB4010E5A9
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Aug 2025 01:48:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GrFOw/+ZU+/aaZgdtfYrH6yzkkrYilsRHFJ4M9KE1kjVK00HaVTaR3wJ/DmHq6YdP67WLdVeHM8OVEcSTyh2Zk1npx1RE+288mMTqFUXY/tjn96fgih498UoTiXqgOZKGulpTl3q8JSWAu+xOmpC2UJ8x1VNxQWaYnKLz0ttciqUHNdWCRZfjA29nIfbHOG3OdI/NCppe91mIgV39U2/HgHTAtNU6eiauyaS1yeQGScT8CXamR7xxNHdZBj78Envuha6oMHJio/FP2dJWq7cQR/wzyW69AN/HtMykAtwcU58H2LFfVPftAzj5u7rN/TwMBjD8llIm2bi2ujEHh6oOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6C4Erlf5OhtdM1NVSawPaP2lo7oTLrG8440S5jOobIc=;
 b=Si/1yq16HPpcjWuik/jlaCbwoJojJGzzs7LvGwRPQRp9E5vp056TILIkvG4r4JqdsR5E2VOO0W7TJjoum3GzdZvc9vfBUtQGd85+dRVMs3Ae8Y9fpi/YZSDvGDg9SK4SN3kI5vxiXxhMd7ob0uvkSCStsJOlGvJ1TQdba5tlfOgdh4ChOhH3Zxc0UMNA07a/ibTf/9AvVXnC4X2XJVe8vw85l2Z8sd4HwX9i4vX+TT/fNekNqUjrD+I5xfBT0PkBVMEG3KWRNQi2t2zA968vsbEILejv54vCQxObMBNpgiEIbMKhKvFqC7uQMTSuKLq9XCfTcUyKXdZFtZ6aP2C68w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 165.204.84.17)
 smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=temperror action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6C4Erlf5OhtdM1NVSawPaP2lo7oTLrG8440S5jOobIc=;
 b=lRNoHYjFNSfQ4pRQHYC9IP152FsMrtW3vo5yxTULYZLuskapR0dq4uzWkfLwPYBj7Wlzcpn5mNOOxB7Nj+AWE29keoKQ8q9gCKzG7DzcTKv1WJZA8Q56mISSDnx7mvulywGVDxUUDirHN6sjRz4ZqvmCugpWjDUCkjQpYjlK8Us=
Received: from CH0PR03CA0318.namprd03.prod.outlook.com (2603:10b6:610:118::26)
 by MN0PR12MB5763.namprd12.prod.outlook.com (2603:10b6:208:376::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.19; Tue, 26 Aug
 2025 01:47:59 +0000
Received: from CH3PEPF0000000C.namprd04.prod.outlook.com
 (2603:10b6:610:118:cafe::5d) by CH0PR03CA0318.outlook.office365.com
 (2603:10b6:610:118::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.20 via Frontend Transport; Tue,
 26 Aug 2025 01:47:58 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=temperror action=none header.from=amd.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of amd.com: DNS Timeout)
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF0000000C.mail.protection.outlook.com (10.167.244.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9073.11 via Frontend Transport; Tue, 26 Aug 2025 01:47:57 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 25 Aug
 2025 20:47:54 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Mon, 25 Aug
 2025 18:47:54 -0700
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Mon, 25 Aug 2025 20:47:48 -0500
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [v12 09/11] drm/amdgpu/userq: add a detect and reset callback
Date: Tue, 26 Aug 2025 09:42:19 +0800
Message-ID: <20250826014648.1711926-9-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250826014648.1711926-1-Jesse.Zhang@amd.com>
References: <20250826014648.1711926-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000C:EE_|MN0PR12MB5763:EE_
X-MS-Office365-Filtering-Correlation-Id: 06e2aa48-cfef-4e03-77c7-08dde44294e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?qX4+LBGgUqTKD+gXLf2uyDyqBS20X9BAozCOnCWElTNd7NfQvbKmi3Hv/N3h?=
 =?us-ascii?Q?vJtf+bPtmEGKk1VkVhyMhB/RkZpaDtxAp09E4VWIO8e/g80Oaif01ik8wtHh?=
 =?us-ascii?Q?hM6vlKTUNFkZhREqTxaCa7S94ElGoleNgqBXvpcLIvFgzJUSS+NF6DImPHj9?=
 =?us-ascii?Q?PbVky5egzQVwks13cx1tkwARFyCYwrl/pNkowjyi9pjKsa0M/WcO/oCt7UH0?=
 =?us-ascii?Q?UZmZ5L4R/OZLk/WeP5lWSuPxkzEblx/uNz7sQSejRD6MlF+GBhsD0sPKtKpI?=
 =?us-ascii?Q?dt7vL9vWFH8/3FLjwoaAseDu/3J/RA8FdpoSF/NuqIInxj0nVWkxsE25UGwf?=
 =?us-ascii?Q?jj6PLI2HKZPf+Fgys6rYP98R613svc+fSTSExMC7orfx0D+r0W/2qhwib5Ct?=
 =?us-ascii?Q?mvXCig9FrHSdrcqUiAbsN9amu58vpQNgM/eW+/v2Sxy8RjO3MVtYZbGhpRso?=
 =?us-ascii?Q?mEf6S/ZmtjZTHN79srGPgyfvEflzhRDLzarR5KcR5Rw5BMWp4vuBHY7W5yeN?=
 =?us-ascii?Q?S/7XVno8HQnsZErXi1F4kWX0+u7KaGmbhqH0hVjZbxYbA88nNIBYZxBFwxQD?=
 =?us-ascii?Q?7cCMnoRnFnvWG5k99aUYjRn+yyX1owdG+7orvgb8Eotmhi0DrIzXM275Vtmt?=
 =?us-ascii?Q?PBsxBTXgGY+OKyWCSerCMyzDGV71RsyFKqA8txGrV5CcylhpyuZ8XERjUx7f?=
 =?us-ascii?Q?/NcVlq8sok0D1ch3zGDzWE/Rp34Xh6twVt3qd0Xynp8j4hUt7zgCsOp7zR2h?=
 =?us-ascii?Q?PrRrGudZTzKNm4cZfv1jMsraF+b92zhkL+UlRGKusrfYsbV3OiKXD2nfsrFO?=
 =?us-ascii?Q?p2GuSIn0/gtqvQcbC1IIV5WEatCUYn8pHHo3f3AB5jpvCCWFrUxGCVXnpOlJ?=
 =?us-ascii?Q?o4SA99x6iPYlWqM84UtWsZW1lrT8N5O8TK8BF1dCvH7pNSct42MyRqtH8jfO?=
 =?us-ascii?Q?2svN13nzResFBjnjF+POF0GPRDvMXZ5iOiWd9Id4uzsK01Z5oJWWZVz57etz?=
 =?us-ascii?Q?xEwfh+ifTv+1ZRTsyCgPfHHG4HMO5c9WQFhq3oUdNPrmmw3m1QjHjuGvebVL?=
 =?us-ascii?Q?x/gx5+NW9EqXhLCip9ZLZ0xlOqQY/CJtUBJzKTTCzoOHx7U4tnpVmjnw8/w0?=
 =?us-ascii?Q?MxP3CMChjJrb4VPmoeZiNY7ly+TmmP0tSuOmThmwRPay9/MTdMEwIqO/P/7W?=
 =?us-ascii?Q?G3gah2aZGtCTgwcA2LllLjcwKxAtJUw43RySecwhajAPG2et4N7aXnI7qBpH?=
 =?us-ascii?Q?7k8RnNJAkCbQgOElMZoHPswwDP7kHW+HEFOtwwPi84n72xwTIHanPSTmFVic?=
 =?us-ascii?Q?3I6BNpMlR5KE/DAE7igVCMevjAu4noS6kRcuvTbaEMkLEwnHtPmgJHUcyvms?=
 =?us-ascii?Q?nsUYEPvjI6gRG0uiLKD/olz3Tb4t4cYn6LFs3v7W26eW6P4UYlVE1XZ4eD7l?=
 =?us-ascii?Q?HBKJ3zh620opLGtvoZgD+WCyCO6FC/8Q9AiV4hWbjbBl9vrnPgCvtmnIFURq?=
 =?us-ascii?Q?+SlSb2KvNrAH1lZDAxA7xELkhR4n3jKgdvSh?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 01:47:57.2836 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 06e2aa48-cfef-4e03-77c7-08dde44294e3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5763
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

