Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9742CCA0EED
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Aug 2025 08:55:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3858310EAC1;
	Fri, 22 Aug 2025 08:55:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dstFciQI";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2070.outbound.protection.outlook.com [40.107.100.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E95CE10EAA9
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Aug 2025 08:55:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XZEtq+P2MMsNbYzeVIP6mkQmbJOsAmQ3ujQb+YlWfqpfIgEBMkMIRfVMUpBdj11f6LInMl9qHRvc6pKGfye2KaAKA3P3Bjs5zi0HZ4+TmC7GFSx9KuGjYmok6kLTgfRAFO7L+RMZ/9cEfU187ZwPWpECqblWAzsUiHH1CyS3tjg/sXsX3OlGvTvvOXvFnLbN+7TwmGMScNXhKPRU80puj+NQZ5pqqMl8EvHcf3PiheG0ZWkCjREhsI2dqkWD7ymoNlQMItqeRa+BOdh0JBNxzd2SqKOkq6Dysab1TU77+bNq7crdDnMIqKp8XcEGHdYTyVpmDUQes+4ebMmcy028bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fBzCtGegdxdz/HG2UhZqTW6DWbkl/R/wmFw8IoOKXas=;
 b=VR2RFScx1xT+TcdqHicoKWLOigSh1CaHcKQy6nU+dRIGfYsEMLpPJHHqpFvoDQAMjndZWP4Blra7EBXQqSQYv+bSBppigVTWXCsTLmm6QaiIw5FBxVmVKF7qwPYU9oQXsT2IF2ydAR/ogURSAeur0LdCfonGtIbFhrfJqSMNthC940m+PGzYENPzdqWUusJFLOSd97eHHjKVPSPZFEn/lZVu4D+AmvOP4Mjt5cFjEeRoOH90Asn0zwn9E+jfzP0AY2EHxl0XO5c3ImL5yyQwFwFuvCSDdqiYThz1KMLinEtDQVceFARJiNadG8S9vaSC5Ic9km2Kx3HIcU4qSCd4CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fBzCtGegdxdz/HG2UhZqTW6DWbkl/R/wmFw8IoOKXas=;
 b=dstFciQIGTg4fvV7Ksg+8BASwwAs7BklK+juRxgCk02A/rLcnZc+sjtawMqhrFHvVlvK3/JFebxLvXjpe+sCZWopkXTEvJgguOaaW1kLnIosinvI8dFFGETTA0t1aHKbgNnNDoZr9jQUZbHPsS0QnPhS61HPh5sKMPfkAb7qPhI=
Received: from BYAPR06CA0027.namprd06.prod.outlook.com (2603:10b6:a03:d4::40)
 by CY3PR12MB9654.namprd12.prod.outlook.com (2603:10b6:930:ff::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.19; Fri, 22 Aug
 2025 08:55:40 +0000
Received: from SJ1PEPF000026C4.namprd04.prod.outlook.com
 (2603:10b6:a03:d4:cafe::aa) by BYAPR06CA0027.outlook.office365.com
 (2603:10b6:a03:d4::40) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.19 via Frontend Transport; Fri,
 22 Aug 2025 08:55:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000026C4.mail.protection.outlook.com (10.167.244.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Fri, 22 Aug 2025 08:55:40 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 22 Aug
 2025 03:55:35 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Fri, 22 Aug 2025 03:55:29 -0500
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [v10 09/11] drm/amdgpu/userq: add a detect and reset callback
Date: Fri, 22 Aug 2025 16:51:12 +0800
Message-ID: <20250822085434.970798-9-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250822085434.970798-1-Jesse.Zhang@amd.com>
References: <20250822085434.970798-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Jesse.Zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C4:EE_|CY3PR12MB9654:EE_
X-MS-Office365-Filtering-Correlation-Id: 2474765a-0d7e-41b9-9e44-08dde159abbd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?r6XCPjcK2eTm8xY1LbBVX6QORgPDINmJctY2XMDtTdarrvqhR6yfE+vPu+wN?=
 =?us-ascii?Q?kIbcQIqfYqfmufJZSW/ztEvS4jD5re0/s8ujounQYxeG8pf8R7z/RxubFOze?=
 =?us-ascii?Q?6kNUF9pGrIthhJu5gE/3SCSeCZmO+4FMnI+/EzeE3p0djAq4x3548oMUOxZ7?=
 =?us-ascii?Q?AZMCrWYyzRa7samj9cdlNAHUxOXGZ828hgVBhpFBBpnqqeVgOZiM1bpyeHkQ?=
 =?us-ascii?Q?cjJynNfH4EVj5lBOLGJqY4aF4kIOAZa7W2oARiQprysca1hwvOB66bub+4PE?=
 =?us-ascii?Q?w+1HgIF6xfKPceoxBCi9OgehpYVsiflERMkoBxCrXMykWP5btNSvTCdZ27g8?=
 =?us-ascii?Q?/R2MGx+KKNf8uZLQL4uj5BJLz3uaVvO39OtrixUTbVK+fpqF06p961BSOdeP?=
 =?us-ascii?Q?RncOYjGQOQMYmKtwm41vCQ1K4f0VPTK7bbT2QhhDvs1KN1Zk5xNRZDuhmjpn?=
 =?us-ascii?Q?HHghuMKEZsB5ooWms/X9j0NtN6DNvxd/cPWQ1rcRqIzMs48DiN4adeS2SIGq?=
 =?us-ascii?Q?gNzkxjf/W4VMHuqmTCZYtFpR9THgxXPzfw1HO0dOTL4tepbHW52/Dc8zQp5z?=
 =?us-ascii?Q?Y6+tY8YBkNRqwGYgIIn1fjdDzvjnWhIjlOQTk9hcCrOz6ur3QxDA4mRDPMVv?=
 =?us-ascii?Q?J/4Sh/HKjDqxJpgI5aJmp9gj6BieIEvjBPw1RZD3OMeBj8IGQVlepfwQJZmT?=
 =?us-ascii?Q?VG/DexXJbz9HyEpHXUCQoQop6Q9eezwU80yzVZdvXVvVeNQw4pXVB63lXmhl?=
 =?us-ascii?Q?GNwhEeACmDhU3xAUwObOrlD/LQVbTcYiF1mminqxItdZiH2Jg4yxyQujGthf?=
 =?us-ascii?Q?6edMcWln7VwDJa3ZiwIcZJKuSXOdVv25Zve87SE4DofoYj63+2tjoWz9rSVy?=
 =?us-ascii?Q?JJJSwoENHzgnRIwhXaSoWx+U0noCvbdKEGKsxU5I+DoXaKvTtsUM6HeEz22m?=
 =?us-ascii?Q?oMMaX7k9K1nlLgnC9IBEW1UknbyfaIIZRMTExjPFabFc+gH2nugA7w7lnAVd?=
 =?us-ascii?Q?9KaOmkuYivSrAFVfTq2AqXX4GIMpQeB2Z/uF/4YsHBqB3pr0klZyJJtvL+gl?=
 =?us-ascii?Q?MJALOfnDluE5HO5XsOH0a1SgLUtKPFhBAZAchDO6dFa42hFYXzsxy+8F8IPE?=
 =?us-ascii?Q?3vC01JWg6CcTP7/ZfCThrKQGC+YNnmaIrH8QdKTajZUTyK4WVz/B49MOpUAG?=
 =?us-ascii?Q?E9jleE/Br2WzV/EaHNB3FttzX6jQJ+I8v7KcusN86aLo8zNXSDagW4Q5kISz?=
 =?us-ascii?Q?33v8OQALIhULfNl4+ahNlcmnYur9D4aEUBCz4CFPSiaEvp4/AdJtExSBflkC?=
 =?us-ascii?Q?fI83eSGLNQZUEfQU/nnA7P2os3lb6zaCHBpA9Ls1aF0y/TpBg8bpRR2eGB72?=
 =?us-ascii?Q?+XVmT5v1a0sS2s0EMfjDYfVTV3wRFRBC3h4isqG9mKMDgRS/ajbh15AVAslf?=
 =?us-ascii?Q?UFO0Hj4GVQA3HyV0pLVXMriDSQaqetcH60S3tBZ4nUeZEvPbTSEVwZqiU9nN?=
 =?us-ascii?Q?ma0ldHPWAymVTFw2cdPpHB7i++mt7wr2HA8m?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 08:55:40.4884 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2474765a-0d7e-41b9-9e44-08dde159abbd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026C4.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9654
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
index d58cf48b456b..dd35717f0835 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -83,6 +83,8 @@ struct amdgpu_userq_funcs {
 		   struct amdgpu_usermode_queue *queue);
 	int (*restore)(struct amdgpu_userq_mgr *uq_mgr,
 		   struct amdgpu_usermode_queue *queue);
+	int (*detect_and_reset)(struct amdgpu_device *adev,
+		  int queue_type);
 };
 
 /* Usermode queues for gfx */
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
index ce5ac8c2f7e1..c3bcf758bf7a 100644
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
@@ -200,6 +201,53 @@ static int mes_userq_create_ctx_space(struct amdgpu_userq_mgr *uq_mgr,
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
@@ -448,4 +496,5 @@ const struct amdgpu_userq_funcs userq_mes_funcs = {
 	.map = mes_userq_map,
 	.preempt = mes_userq_preempt,
 	.restore = mes_userq_restore,
+	.detect_and_reset = mes_userq_detect_and_reset,
 };
-- 
2.49.0

