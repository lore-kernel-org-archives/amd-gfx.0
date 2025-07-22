Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FA7AC83F1A
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Jul 2025 03:06:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC7C410E5D9;
	Tue, 22 Jul 2025 03:06:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Xys4iZlk";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2070.outbound.protection.outlook.com [40.107.101.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CEB8D10E5D9
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Jul 2025 03:06:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vsYEV1RtYYfHJ4aGxUi8uzzwudUrwZ1jktr/q/EcaXk2gU4Khl2EOMv7MCJvJ6QneMa0ds14Vh85oi32Ge8FKn8Cr1zuIDA+42fHrSITBu0dJHroXYC5BjQ7qE/od5DUJEeJHe+JR9PTgEYxKL+pFaFZG453LpipGI7K8b3a4O2yVJEOchkRBq5B64cb0iLUPDk2rVQydCC6CQhytqOhpD2+SYhNyQoGF7K3TkjQaAzJ5iiT4IOrcw4P9bO66y7+H2AEC4Rl4mbf0MprUpfUD440n+9ZT7YYWS3+FUOt6ZSohH9jcFWCJHK2D0aQ6+d5ASdYi/YwUk2Qi3fx3NUmgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=71x1DdgF2wu8aRS5VV+1yKbCjkTM+OCdSECSRJH5n4Q=;
 b=qeMD+Vw87j6/pZ7x7ytUt0MMBexDH2QgtEYijZHa5Mi8oZjzZ0P57HRSXTjN1X26PHHHlb2T4pfeXc0hH27satgmUTlUr+nXdh6OG48sjZLlnzop7GuVSZOyK0UlLq8R1QqesM5JWITL9uSJLTM5pxE+PFdbBV5hVIeVDPMnZ5wL/c3/FYIH+SRB6R3K2TkgLRZnUiw/U5gre+5iNRE4qo6EpO7Ecye5z5qCkTgKHDC90EW/I4g3LbzzC3d3Un3NcvseWVfqgueNSGuPMF78VeRqgPLAS2sYOvLsnoIJihg7d0Icqvzsx7RnjC+0ypPYS13unGwLBvOmAtXHP5R5Gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=71x1DdgF2wu8aRS5VV+1yKbCjkTM+OCdSECSRJH5n4Q=;
 b=Xys4iZlkZLcv4OjbE0EYqpbZ8xemfS0QVRpZSwop/YKq7O0TpkGlgkHvQphJiFORZmwTyQYLVDtV0UFs3S55Lb7eVHHuweWcOy7gP648Ml+j1roiNbzc5AuQr7SznoaQk42jrOjDxRAtnf3P9oByAln6V1IzFVguBZq5hzFbuyc=
Received: from BN0PR10CA0021.namprd10.prod.outlook.com (2603:10b6:408:143::24)
 by DS2PR12MB9799.namprd12.prod.outlook.com (2603:10b6:8:270::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.29; Tue, 22 Jul
 2025 03:06:37 +0000
Received: from BL6PEPF00020E64.namprd04.prod.outlook.com
 (2603:10b6:408:143:cafe::b3) by BN0PR10CA0021.outlook.office365.com
 (2603:10b6:408:143::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.29 via Frontend Transport; Tue,
 22 Jul 2025 03:06:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00020E64.mail.protection.outlook.com (10.167.249.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8964.20 via Frontend Transport; Tue, 22 Jul 2025 03:06:36 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 21 Jul
 2025 22:06:35 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Mon, 21 Jul 2025 22:06:29 -0500
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>
Subject: [v5 6/9] drm/amdgpu/userq: add a detect and reset callback
Date: Tue, 22 Jul 2025 11:03:42 +0800
Message-ID: <20250722030605.2741435-6-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250722030605.2741435-1-Jesse.Zhang@amd.com>
References: <20250722030605.2741435-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Jesse.Zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E64:EE_|DS2PR12MB9799:EE_
X-MS-Office365-Filtering-Correlation-Id: 462130f7-378d-4d50-7f3e-08ddc8ccc54a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?KKz3HYpFyM941TzTs6y84nyDlvpvYXUnUdnGl7jx2Yjo68ZFOYYpWY5biyU+?=
 =?us-ascii?Q?2NS7ExuBBLWta37YdD4yhGlTJ3KTm1YVoaiR3CG7Jo9wftzwTKaFuXRIC0VH?=
 =?us-ascii?Q?qFdgwndBj9AeqP3cC6aG1bWiZ/aTnwZhZn/8B9X+0iU9oJuRHqaZgJsIXC7b?=
 =?us-ascii?Q?XsEn1/yPFgFu/y7yh8cCHJHAZsMtnxtw0MhvXBSXUhA9225l1OUsmbo7322g?=
 =?us-ascii?Q?FmVSMguWFwGwf6y6nUi7R+W2DaCONQLzWg2GoaKCWk2NmjiJdqO9/aWoHGm+?=
 =?us-ascii?Q?ZArCIcLoMVJ1pkJwe36IvgtnwpJpxHY0dZpaLL3pQB2tzCwJ4/xR0Xlzl/JV?=
 =?us-ascii?Q?DdIjI18MYlhX10qTq2MfTUCuhNiU1e9YxGYRO8fziA9tJrbPt3gnKi8gAc5W?=
 =?us-ascii?Q?/P8kToKGthezkwrMmToDaXjav/yc8+Yy5BPAL4RAfPKwvJGdI/dulDZlZ0I3?=
 =?us-ascii?Q?S5mbbOlkIylfv/Z3ZIR/9R6+57bm4WhnZTb3CUV8XgKdsARpIWCK0wZYaAzk?=
 =?us-ascii?Q?nCyvBQqNjCT6tc1eFSoAypFNG6+I/ZLzuT6o6OVJK0TokiUmx4LS/6uhYqsa?=
 =?us-ascii?Q?4L8S+x4FQIQrHl+dLXxwk+Tiv9ufvwW/Jv1AilfXBmyI2EHF/JbQn0HVy6zB?=
 =?us-ascii?Q?vKNEJzH0CAk1x2yk+ful8pjWkpCcbl4pStIZCJuDWdZqM/nwdPPjghGw8Rt8?=
 =?us-ascii?Q?0YKoJK4J6pU876smE7l78pEI/KvbV15VbkvErxGWks9mrp6d1v01MTaSZ3+D?=
 =?us-ascii?Q?ewy3BC+6/JkqkXkEdm5urlV0Et+HGCCMSoGVw3EikS6OsjUyrYV/utJI3wRR?=
 =?us-ascii?Q?3PFCJHUUjHU/SGwTx9n97KjCpjo8Y7TL52Ge3d3SEJr6nKMWNqhnC1/ciixv?=
 =?us-ascii?Q?N0qlI7NRT2/UuTJDjh09wJjcNoeKHjOkATqbQHxiq0wjLF3OUp/h4ra+h7Ys?=
 =?us-ascii?Q?r4CRMGWkWef0rhj4R+ewgGgefWeUoy4SUjrHB2C4N0Su6PT89wdOqZBoIDP3?=
 =?us-ascii?Q?WeE93fhdayrp7Oo3OAYn5vtvvT4J07qSr2rV5GYbV889BKDqYJBslyJk8kBE?=
 =?us-ascii?Q?5jA20onUdYRQbiXfoTcQSARGdSyq8KobsW4tqNBDDnYkXx4qSiaMUICygT1j?=
 =?us-ascii?Q?G9vFm9WBMw+Yn53xbuhfr4o35s4yjt7rYcBTK1o+r9MTCpiBu3v8YLlOGSKz?=
 =?us-ascii?Q?sG5Blt6RRDCcDqdPTLgreN4wQrRzJofa2ghFSJd9zNTZyZn3CNMYfghe3xKm?=
 =?us-ascii?Q?5Kmc2yYj8ZtW8q3RTa0cM6Zn5afg/OUhJq8+khHgt7zq6Hkd6OqSHW53p+sx?=
 =?us-ascii?Q?YTPlASQ4tCor7r6zCZkE+K6NByak+fHuic/JYzyIvK8KNKY/q+ZPhxXdffJ7?=
 =?us-ascii?Q?sWkVrRpBKjjEi4OXoXn7jIvALDMRkaIya2c856qnMVrrKZNl4haFWjiToV/4?=
 =?us-ascii?Q?woO9hYXqvcVg16tcXD+cuwGpOsS+FNUYU2UVmjv+4+jyKpaJuJ1QndB9ifak?=
 =?us-ascii?Q?Uog1036cMW9XsZcURA++msWOIAN5ur30HUu6?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 03:06:36.4911 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 462130f7-378d-4d50-7f3e-08ddc8ccc54a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E64.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9799
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

From: "Alex Deucher" <alexander.deucher@amd.com>

Add a detect and reset callback and add the implementation
for mes.  The callback will detect all hung queues of a
particular ip type (e.g., GFX or compute or SDMA) and
reset them.

v2: increase reset counter and set fence force completion (Jesse)
v3: Removed userq_mutex in mes_userq_detect_and_reset since the driver holds it when calling (Jesse)

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
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

