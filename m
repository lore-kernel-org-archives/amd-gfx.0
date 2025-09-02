Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58E1CCA0FFE
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Sep 2025 08:08:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F240C10E5CF;
	Tue,  2 Sep 2025 08:08:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hFU8K00n";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2089.outbound.protection.outlook.com [40.107.244.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D0B6710E5CF
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Sep 2025 08:08:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g+bo1ZSqc4v9omrlC6UCzGPFP4sdMAYdc8YgBldJyjNIMd7IiyOV38rl4+D/bvHwV2CKUzUUdplprnVD12M3emIP85RLev6lCHgeXJJ6dl8CBFrXUtq9DYwC53cWdmkkZH6JigzWbkbWeOObg9KADuvGEFYAdtUlrEGilEOj/o6zx/dvgQ/ep4ZSU5CIiHs9mxhzsgI1PW+BrK+Uw/TIt6bI6I8t3w+gkIHx2iDrUpDQMqCm2qMVBFtHHHjDhFdzub8CC7e7Xq46TuPSDTpueRxi4zPvxB8AreMBoP3t9uWuxCj1L3wDDwDxuYRsgkJkbQvDLePnSPsUhZXrZtXyoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6C4Erlf5OhtdM1NVSawPaP2lo7oTLrG8440S5jOobIc=;
 b=ZJBcHmYjpJeNbwbsYQt4OtyUDCh0mVKX4rovVgTK2OzOGAFfKCe0KPaA19eYZyIwyspnN1GfauBuTjt34glEWZfBq754aNVM6nyabCuZwQrzwFOcu/InAXJOBr1qu1QtuKik6dxySyk4nsIGRM4jbjHSF93JN9IJ00vDmeP1nS7s+9bWYus5xAzYvOc3YK9qIllWeMnSg3CsNNUxQ/S9JgGXGAaBmkiK43KJwceF5Iadot4XJrz2bjhoIgLeJOWFxhum0fiiH2xkgk44kD8F4iBm36k4MINfPKiD9iUqk+XiQcL7zoGaBbXzz6L0KcUR6TRHLC7l+R25cO1R5CP5nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6C4Erlf5OhtdM1NVSawPaP2lo7oTLrG8440S5jOobIc=;
 b=hFU8K00nam7x1iAhCyjTEoGRsqGPAaopiYMGyApjF9+DeSOSHLZ5TnJKtiFCUynAqjgIADbPBzDFN6XBJLdsSdo4EmfGlsblav97VCcdF4FuWLDtvEBpHN43HMvHhirCXe4IAZcr46U21AOyax8WGP0WlouytxqwfEjZrUMCkqI=
Received: from MN2PR20CA0031.namprd20.prod.outlook.com (2603:10b6:208:e8::44)
 by IA4PR12MB9787.namprd12.prod.outlook.com (2603:10b6:208:54d::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.25; Tue, 2 Sep
 2025 08:08:17 +0000
Received: from BN2PEPF000044A0.namprd02.prod.outlook.com
 (2603:10b6:208:e8:cafe::d8) by MN2PR20CA0031.outlook.office365.com
 (2603:10b6:208:e8::44) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.28 via Frontend Transport; Tue,
 2 Sep 2025 08:08:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN2PEPF000044A0.mail.protection.outlook.com (10.167.243.151) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9094.14 via Frontend Transport; Tue, 2 Sep 2025 08:08:17 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 2 Sep
 2025 03:08:14 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Tue, 2 Sep 2025 03:08:08 -0500
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [v13 09/11] drm/amdgpu/userq: add a detect and reset callback
Date: Tue, 2 Sep 2025 16:04:10 +0800
Message-ID: <20250902080712.2515811-9-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250902080712.2515811-1-Jesse.Zhang@amd.com>
References: <20250902080712.2515811-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: Jesse.Zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A0:EE_|IA4PR12MB9787:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d216d8f-97bf-43ce-bfc6-08dde9f7dfa2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?DgONEHEXTfiNIuvNUSdhrb5VSZjL1J6MmS4fbX2px8Kz2KO8zcFqZSzyPrMG?=
 =?us-ascii?Q?KlQF2I0SkZxY0bkqDqpWOeDkbcFiyi8Kevqx0emRJ47GhC3mjaHcZcgZ6pYO?=
 =?us-ascii?Q?/XhDYLnRuhZ3EFGGO2qRovlsdjihQAeubrGKKDKDhlk+M0fhNmCPjIcw+jv9?=
 =?us-ascii?Q?+JtZ4ZybDg6gjp5t+JLg2ypULQmfW5vtzvlfEbgJSk5ovTuiP3yDEAppmuP/?=
 =?us-ascii?Q?SZA0zTszqsi6bThFGbKsgIHFQYP62APqrs54ACxMNDID5BpNLq3zc+mbHwO7?=
 =?us-ascii?Q?nIF/UP1ltrpRb17/h7RZtTQrbsbG7BWjDfZf5I/RutB57daDlYcMAfO9p62K?=
 =?us-ascii?Q?q6z68vEBFY9UCZScdsZK0uUGDVNtlIwGL5vWh/iNhARrle0fD4TWApBH8z7M?=
 =?us-ascii?Q?6vTK2FJvLP9x9YxAUG/9Sm+jl18vL3kV+2Sn22BAnZphTGfcbyNV1lgMMpvW?=
 =?us-ascii?Q?gXMweyejd+M/jlwV9Yfh30VnrA5Rajfa77z8At3IYt8SegDepfLERdNLETDC?=
 =?us-ascii?Q?O5aDs5QCIylrMX0+/to1QXxyFbyxzDBzkb12i13PPeTsjOEdhttK0scfe853?=
 =?us-ascii?Q?96KCX6eYNPHg2W4spbtydub49aCeYl6ferPy15IVI9C7O/oMIgTAtfU34h3d?=
 =?us-ascii?Q?+AVsq8iyg/xTFumJUKC+VGf8ajoFjO0Bz3xNfflpkDLcHLLkIbRR6iqgX9C7?=
 =?us-ascii?Q?kO77aAqogizlqQdoagQhZTReMFKnBEhUBjlQj4DcHXsNpR0n4qseJge1y6VU?=
 =?us-ascii?Q?Odmw73w8jv+1jX1TKDWsDnEBk07iPABPlog2f9bLvfarCBgPMU6XCUnZEXL/?=
 =?us-ascii?Q?QdsOUmZ4VK1e1hYnzsp2qg9Fdj+E5dKnk/JM9btuOuoPeyLSUAc6IsmwnUqj?=
 =?us-ascii?Q?6FADVUylaMKi5+NtHOZDx94mSyEOMnhycpLMcu87YLxG3RhMPjeG+++QsE8c?=
 =?us-ascii?Q?U1kXxts9BXRQitvg39S78rRrvZZJVwqzSo0UyTPF/ZU5LH0Zi9s11Kh4qwBX?=
 =?us-ascii?Q?6yfWokeOk6vpzqeEGdVSGHn6PYxTK1rpyTcE96bnc8q5UKh9KsGIG4refREV?=
 =?us-ascii?Q?9eOuzDtarGx83VLjXI/1Ndb7H86BAo4555NiH33V52Aw2gXea3ty6Iwn2x3b?=
 =?us-ascii?Q?u9SGfXKCQX2ZaF26sf22YvPI0iEz7mXcBhq0pxWwl/F7ELCQkhIJNTnAmiC/?=
 =?us-ascii?Q?wil/eJ4tBQJn5obx84eavgXq5yRXYOE0C+UGLXA7neJMFEVmgmFBwyn+9sRF?=
 =?us-ascii?Q?UkZyqwptN5MZpcxwGH1Oa6IOZ3g61yyRKRZQUf94c3XGcQyGJgNEAirA5si4?=
 =?us-ascii?Q?Ac35VpP9zXan/nB3QdKpmdYuIC74OMYSeDGJiwitbBVc7eMKa4HO3AvjWGvt?=
 =?us-ascii?Q?uP+K9QDsqkF+LdqgjOE0qkGlA+ZvntHGth+YIVAJ/uh4M0I/x8DPrJF6yYzW?=
 =?us-ascii?Q?I3ZXuX7C+NWSWsYDYSQMyva0ZmnMMrjQKiZNUW9qAiIIzxVmyyP1tJSuqKtr?=
 =?us-ascii?Q?xSagMNmhTduZjZUdudi/TBkBWd2KENxQ84FZ?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 08:08:17.4223 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d216d8f-97bf-43ce-bfc6-08dde9f7dfa2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A0.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR12MB9787
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

