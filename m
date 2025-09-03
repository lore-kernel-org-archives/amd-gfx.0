Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53FE7CA0FF2
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Sep 2025 08:40:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED69B10E562;
	Wed,  3 Sep 2025 08:40:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fz3wG0zI";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2086.outbound.protection.outlook.com [40.107.243.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F36F710E511
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Sep 2025 08:40:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V78iaKhL4x3qzrM4iJ9c8fFxHr4Mo8hDzvm68R7bJN1PaAAs0ylLtP+CdPDpEO3fDWkCBYur6GHzZ6aeBTJbReWrJiPWyvVkQPKjAguDrpCJz6t1uYK3IYGXXpblT3iDNc+965Tmj8uSNqx2l9TKHNM4500UAz7WBxOJHg4m+8bjXJ0kU75TPWvV9Hwj7EkRIwyEd65WHDGeYe4d2lOs3okQNRNXnNQa/VrrVm3Q0kfbQuM7uxcReN+sUQ0O0SRL8G5yUr4KSW6215saOMvsTyRPszbCWiBs5GL/8O7l1lPL2cH3HSfzB4vfbHEsIK2B4PVo36qzdSNg13PmLvYNuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6C4Erlf5OhtdM1NVSawPaP2lo7oTLrG8440S5jOobIc=;
 b=TVbpfwPnDFsphX6HYe8KHdS+MpIwfCr2P+8Va1lJ8uFv1wsUbUw4xdntwDX8OGbsbYKefZFJewbMjIgl/XuC49rNC+k4c/z+mVzFs2V/E+0SHyhPMLmT178A5BXtpywoDbrNUfOBZwt6W46JEd21UWJDHch5cFX4vBTXOfJ+n2OEZdn0nfvvmw5afJ/2O8wbcodJDQZZlcMK59UEa9YLbqy7lOHIH4FW5+sDYOd+JdxnyIJueoWzvOU5tnmCZM/nwpYk5elmbhAQIxki8rTKwPRg8gmgSbmIoCwQvwbyiCzRZdUh31vq8A5gNroifTuu5eE9WxVtMC9Fd/DXfjOFTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6C4Erlf5OhtdM1NVSawPaP2lo7oTLrG8440S5jOobIc=;
 b=fz3wG0zIdZHzxIHe9KUx2Qp/1aZuHQsb5fXXKG9aRj2h3dS+h8FYCLRx2KpTBkBLf659q6fOR9pgVEPvcDVJK2Dm24i66WtoUoBz5df4Dp9FZeLzS7CAuk31zJThH7xfzKNmYwm28xxA7Xe349enGMPrRhVbgP7t2HiePWp/L9g=
Received: from BN9PR03CA0554.namprd03.prod.outlook.com (2603:10b6:408:138::19)
 by MW5PR12MB5684.namprd12.prod.outlook.com (2603:10b6:303:1a1::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Wed, 3 Sep
 2025 08:40:18 +0000
Received: from BL6PEPF00020E65.namprd04.prod.outlook.com
 (2603:10b6:408:138:cafe::c4) by BN9PR03CA0554.outlook.office365.com
 (2603:10b6:408:138::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.26 via Frontend Transport; Wed,
 3 Sep 2025 08:40:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00020E65.mail.protection.outlook.com (10.167.249.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9094.14 via Frontend Transport; Wed, 3 Sep 2025 08:40:17 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 3 Sep
 2025 03:40:15 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 3 Sep
 2025 03:40:15 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 3 Sep 2025 03:40:09 -0500
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [v14 09/11] drm/amdgpu/userq: add a detect and reset callback
Date: Wed, 3 Sep 2025 16:34:27 +0800
Message-ID: <20250903083914.2604482-9-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250903083914.2604482-1-Jesse.Zhang@amd.com>
References: <20250903083914.2604482-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E65:EE_|MW5PR12MB5684:EE_
X-MS-Office365-Filtering-Correlation-Id: 673deac9-932d-4bb9-93e8-08ddeac58271
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?k9CBeg8wUTyqwhKHcYCBwJYEWcf7YRKVcOl5z0Itv9eLMmaglXFSeFmpN1+D?=
 =?us-ascii?Q?VLINBhiAV9b3DFO2mDm097HMgzgkVL3STsRurv4YvdGNETBHtZQ3PRheLdmU?=
 =?us-ascii?Q?K95YyjP6TtM7LvvPPYFJpEO+O2gibMBYoiudBzNxoxP4ha3SxDi8rdC114/w?=
 =?us-ascii?Q?L7BFnPybVtp8A/zUWamWtVrgpArMhYt2JAy024Ta8c5Z+qfUGXm1Gd/FsexC?=
 =?us-ascii?Q?apt4aLDTNoqGRaj5pfT+BbKILm0OYBGkWzY3Y+CDGh/mKqPP3h8R7yKJ4Kjx?=
 =?us-ascii?Q?tSy/GExNy9a3tWpCjUH7zKW80/n5pRflHJGyOGkazNcLhTgfX9TB4iu0Egv7?=
 =?us-ascii?Q?aPOXAkdyIlaZUAJkxHyn8n2oGPAU2Jf4lKbW5KhoOhmQaMzC5+bJ7ZupjHrp?=
 =?us-ascii?Q?phfOgqPPVhww3KNMyv5M8oBW87DUok7b23f3oaoZG2DkyeadivrdtlwXPzgZ?=
 =?us-ascii?Q?31fwIrbgUR0Fhz/8q1QPC4lZs0AXFU9I19wOsDz465RKt3+NmeRVqaawG6jD?=
 =?us-ascii?Q?bPWaPQqSegkve57VzTUZcYP146jnXLtREygbK8mvNPdL0gYJ/5UBLyvqzUxw?=
 =?us-ascii?Q?lQjH9BdQYFkNzRxNINOlD3wR6FLNlGVJc/CgVlAQkhMPsYbCmtN3YPVxCRn4?=
 =?us-ascii?Q?0nykV6A5vdDdsFmvkHB2qzY7T9StGCg2vhEPB3CmgvK92Jd6hbv3BaZNcvCs?=
 =?us-ascii?Q?cMas84JaAQ9ggcJp2xqI10WKBWdMZZOzx4PtukvXRc4XuYDV8GUMAxu4Cj0h?=
 =?us-ascii?Q?4UIDq98GS0lkLLueJyASnPpHXZ6eU0R9HyuzBDoAvDcoOcjq17GIqYQYld6L?=
 =?us-ascii?Q?gCiaKM+R3oRpIOe7TDm6oaHcBzZD7UJKBXZiA16dTxhw5xTa6vwI/uwctU4/?=
 =?us-ascii?Q?dOr+yNTFjMjbKUNjUjQxP7ygT/4ZZX7X+4bt//JIRW6rAbPlr+X0idB2dtGZ?=
 =?us-ascii?Q?5orDukxd4YNQZWAQRB1hmxXRiHTFt0uaGTgLCA2DgkEUHD52xIOlCvyu+Lbm?=
 =?us-ascii?Q?5igwJxtLrjMt5vzdJHWlH3l3MUWFzo7qxRMmvts4ASi7qDIQU/AwC4cemPVW?=
 =?us-ascii?Q?FJq8e6vL0cPlWEgLo4l8fdrtwOx3LMqcBx5vLhJxdTucveCmTcF+pU1iEn39?=
 =?us-ascii?Q?k0emCblR59AcCwOvMN83JbXsEG14MLoK6sYxf22hDlB3DCQNScp/PMan8Liv?=
 =?us-ascii?Q?IpgF5Gsn8d1Xf0215uPoz94r5pKSyHSSI6CAJZQtwYJXHSacHpan07IlOelp?=
 =?us-ascii?Q?dEUPHwa1UKTE9clQf+mFRxEo+gMGOjFkqMkgGuJ+2nIfhPIqqG+y/2zqvCBz?=
 =?us-ascii?Q?SpjTlVlveNGKWm6eH4bLzAWGEa88iOserrbIYSkr++I9lQZCQVPqGFst/fL3?=
 =?us-ascii?Q?CqLr7CL5YftKdM6a0pE0i4R3cb4XUOhZs9IWv3iLJlO+ZztmzRpMNHLlLKN5?=
 =?us-ascii?Q?RFBHaR9h/eiHI1XVhH4qAxoOIg0Y5mnAbtZy4a1jSrvKLgoxF7JTq2p5MpAt?=
 =?us-ascii?Q?+tZ4QOmbrb94JFEQmbsmo+DazqvsQM/7wmRQ?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 08:40:17.3987 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 673deac9-932d-4bb9-93e8-08ddeac58271
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E65.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5684
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

