Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0D2CC71157
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Jun 2025 09:23:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 63BFC10E59E;
	Tue, 17 Jun 2025 09:23:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bb6YTFka";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2067.outbound.protection.outlook.com [40.107.220.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 57ABA10E5A3
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Jun 2025 09:23:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qVKzwjsMo8BFPVTTG9a/DT8yaAoRDpmhMsyyCIgQcRLfkibjv79LJkqCU16fM/yqaLvVGDiy6NRzfGqQygpqtOwHcHzyuXe/mYWFyIcQUZ81L7G3bZ8ALFPUcdxK+098RqWeOsnsjNwhMDs6A+63wnmYwDrp2MpQaOq0t97wDSWekaLzGL3sGqPxYe/B3hoxjsfjLQ3QV5oIRXDTuLV5j/eMmm4icdVTUm3aJSnJnKY7SORZqlkCG+/u6yZ7n7BX3eTEvwrurJnjkSxa9fm/hX5rjOUx4ryzqbOHXjpuG3gN66zAsJSRI+6FDbVh0hVVmmpzNf1ShfTiy1JoI7hJgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7hU+SWeD2GnekAI2Ws+CLpODvWe/2m4QBylV2O5D/Mc=;
 b=IXPyV+Q1FQZM1O82loVTYH7wYBAsn9dg1f98ldtB8DR9e58Lt8AZkZ3WHUHlHSQSByb/t37Fl8oiwkReMkatukJT5QQ9SIQ3UEBJ+0WW5EqcsliBMeAMDiQzDDFxrPvQA5dFFJ3yAbm2Sbo84VD2aEvGjMDtdZuLdDyuHm65uZrr+PZZpDRNsfHvdbjBUvrPyvkiuQZq3Bw415nddXA/Zq7SZhownxtpFO401QKaAayrsZpV+VqbWzwvllJp8BT3+x88CuBQyNimx2m0J91PVXEXkPFlbBd/smLIHuDvwLbzq1YauxJpuVX+gFLuppDDzCglE28QeMH6pnqkjz33lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7hU+SWeD2GnekAI2Ws+CLpODvWe/2m4QBylV2O5D/Mc=;
 b=bb6YTFkaMc14TjnUJudEx3AKW1zDB7qZrTOjtAH1Vpd0cJf0Qk6PYHhNUuGhjGXJYcDuNk/eORw8/QVCK+Z2zpUMDcUqnSvcUci854ghbHDixyx+M8ewtDvxVROjoy8GZcbjSlEJd751uI2ezZm+x923b33ZKnwKqtPsIRuxMrc=
Received: from MW4P222CA0020.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::25)
 by PH7PR12MB7938.namprd12.prod.outlook.com (2603:10b6:510:276::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.28; Tue, 17 Jun
 2025 09:23:28 +0000
Received: from SJ5PEPF000001EB.namprd05.prod.outlook.com
 (2603:10b6:303:114:cafe::34) by MW4P222CA0020.outlook.office365.com
 (2603:10b6:303:114::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.25 via Frontend Transport; Tue,
 17 Jun 2025 09:23:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001EB.mail.protection.outlook.com (10.167.242.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8835.15 via Frontend Transport; Tue, 17 Jun 2025 09:23:27 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 17 Jun
 2025 04:23:26 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Tue, 17 Jun 2025 04:23:20 -0500
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>
Subject: [v3 8/9] drm/amdgpu/userq: add a detect and reset callback
Date: Tue, 17 Jun 2025 17:20:20 +0800
Message-ID: <20250617092243.2769580-8-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250617092243.2769580-1-Jesse.Zhang@amd.com>
References: <20250617092243.2769580-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Jesse.Zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EB:EE_|PH7PR12MB7938:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e2103cd-3777-4474-3445-08ddad809e40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?He0yZ6yTDqRQ846BupptL/LiQz4YhV7VxAa2VfL+tevWjPU0GWjSF1HFkN/E?=
 =?us-ascii?Q?s/Srp2qFqS9SDefEeA5Q9iLlCtrRBFgyjbth9C+vYj1+Y4EuiumtpHH6oMYw?=
 =?us-ascii?Q?E56UE0tdgcAVOxSRudwX0unaJNiQuzmgRsQ0smWTYj11peEqpep+N0+cQsM/?=
 =?us-ascii?Q?QUE+gaSt8HeZ+DTTkwlHcZgzE54HXDWRJxxklUDFT2LwdB1NzOMI92LTBJBj?=
 =?us-ascii?Q?bOifQBtr+hKzHrKSj9DnPPLh8vr0PxhzAP8gIUoVYdkx8hkLrIMBTqwlVF0a?=
 =?us-ascii?Q?mygG5IajDj+TQTizCZ/0++zkW9njHHJRV77O5fQBRNGDwaeLpaLl6QZVcgzi?=
 =?us-ascii?Q?qTIVLXVGB1Zivyxsp1KSSfBSCM6yf/YNEOa/lupLIaUQO/ftPZz1bmvtFhXs?=
 =?us-ascii?Q?9KMib845OVNV4v2EnfyWMGQp9F71y/stk8Y2MzmAZjTAnvqGGg3rnd/0dcTr?=
 =?us-ascii?Q?922Mk9LhgiLsUl1n5Dlp0ZdNukwidTGNMmVrmam0yZnTm24G5z7HnmNH5ZGS?=
 =?us-ascii?Q?OWvnIRhbfyZahrx4jcNGfDlflAK8x8jL2s5alqpbI8o0CUSNjMomYrFhWko9?=
 =?us-ascii?Q?ZJGEDlrBoRkSVjm/LmZbBpR5vkP3HeD/5O35C/z2R7JVQ/6LuX+D8P7Op/fM?=
 =?us-ascii?Q?f4JvSNPFAtRMiyRhAJ9loK8Ml1jBRd1vHmvpMFebQvzNttSsxeVFVY9YAcW1?=
 =?us-ascii?Q?AbLgICKl8PjJdF3q8E0BnTnnTJYvSdclRQ/JvMMvdqB2KfHdD/avCmTfZ5/S?=
 =?us-ascii?Q?Exf+mLn952GkpkIlE6yhnYY9mwoGTHJDjztTeN6VTRVR/WhsTE/zwjSYVS3a?=
 =?us-ascii?Q?9Jbm07fWFIjTpeUul5rpHnhMcdAIHSwK9yrBJJnVNfnzhnVvDqSRi9iqi3/M?=
 =?us-ascii?Q?wv+dOaCpdxU3rU/Scm8rVh91UlDEZF/mJoW3LOWvdAaIocVY8YspZVfTHpp5?=
 =?us-ascii?Q?dTDlIV7FV5UCufgFJZ33ZH4cJf4kBOEBc75yjEDXoTQsO/mQaNMVs318mYG7?=
 =?us-ascii?Q?JqOuR6zqhQPXjU9Ly4rEsz01xAqdJunFbgcHAKaL9c0hB7vp84qS/kyTo2pN?=
 =?us-ascii?Q?L3A2GywHXPJM7ui+tpYGwvgyhTDQN0SjF/CR8JRhVtyXpUndV+XyejoFBiqt?=
 =?us-ascii?Q?gkoRumbz7LwQ9TWrKC8Dm+K/AUIkaaEYEezwg66LUkYxSNn/Q+kM4VnTKgiN?=
 =?us-ascii?Q?Cih7ZFXQjaYodAwboQnVPuQYO/j+0aciIw7IF338VjfXBF4UQmMZj+SFhb0c?=
 =?us-ascii?Q?vH0I3sWCi7tLQBoN21YWLcuds6pYPxfuyIPZ9CQcpd2Dr+mWW7LN9HSPh89T?=
 =?us-ascii?Q?9vEnRwnzSUpTTev5VJv9st6q/Zpr5lcIxey2vGfA2cwEWlJK8GAymzCwdbJu?=
 =?us-ascii?Q?bL+z4R93X+j1pK5jTDV3fFEouIV27Jo32gAuX9DXXQHOprBpQe4FPEloD1j4?=
 =?us-ascii?Q?HQq0KxEpuhaDTltRZKg8aqwk4kasEfC18ize5t8+Y3hY1kDV8C+tIHZNHvhS?=
 =?us-ascii?Q?0FwMFMWBy8l1pT/gA2/T7JLxVgvHTV/4SOsk?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2025 09:23:27.7571 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e2103cd-3777-4474-3445-08ddad809e40
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001EB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7938
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

v2: increase reset counter and set fence force completion (Jesse)

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h  |  3 ++
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 51 ++++++++++++++++++++++
 2 files changed, 54 insertions(+)

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
index d6f50b13e2ba..52d438b5dcef 100644
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
@@ -198,6 +199,55 @@ static int mes_userq_create_ctx_space(struct amdgpu_userq_mgr *uq_mgr,
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
+		mutex_lock(&adev->userq_mutex);
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
+		mutex_unlock(&adev->userq_mutex);
+	}
+
+	return r;
+}
+
 static int mes_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
 				struct drm_amdgpu_userq_in *args_in,
 				struct amdgpu_usermode_queue *queue)
@@ -352,4 +402,5 @@ const struct amdgpu_userq_funcs userq_mes_funcs = {
 	.mqd_destroy = mes_userq_mqd_destroy,
 	.unmap = mes_userq_unmap,
 	.map = mes_userq_map,
+	.detect_and_reset = mes_userq_detect_and_reset,
 };
-- 
2.49.0

