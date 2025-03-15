Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6D60C28B28
	for <amd-gfx@archiver.kernel.org>; Sat, 15 Mar 2025 17:22:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0AF3710E292;
	Sat, 15 Mar 2025 17:22:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="n5oeYo08";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2057.outbound.protection.outlook.com [40.107.93.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B18D110E292
 for <amd-gfx@lists.freedesktop.org>; Sat, 15 Mar 2025 17:22:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CQOjZwiXgAfi51zdt4DLlzIy3GGu9DTUkJDqvCpvIaTn9NP0cZ3nLeEzX4pLlBvHrt4bMBHKUJy258AwPLlK9jxLyyhoX/DTTIFNzy517a64UKB8CT79CWIsG309jZD6GqXw6WStzMreJjjsI3bn80boTk6s2EfOtL1m8PP4b00LDnbuBNcjtAutZePePJJGj7cUQvtLAKif/TkMOle1HhuJP9tKs4CeS9MTPaDSNzTK0wJ98/thm2N8dyfIAugs+68rZwH499KMAS9RQyJlgqSfKh/CTKgn6PEgUi4trMQkPPYqT28GuExBFKgic8wJxudBAtBzyhGLDE9NIa4LvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cz22hpPW7D8R8puFEvMTvimJbifaQdLgpjg+E4MEih8=;
 b=CXEsOH8HS/v2BiatWmWgEuLvvCWbHd4rXvkHl2I5q9qTglHhxgKBZEaaDQhwD62UFwiAHwFM8gGo6rOiVdYR+gbvj7ywc3M2Fztl5xhEwUJoBaTPi/Vk8sr06J7n0WtHpANegc95frwiSWanyds5FaEt4OjmUfKITb0krVKt6kc76FtMgnBJxJE2D2hb4bzQbS3UlXlzWKdJDyYNbKrGBXsWU0jSEcSDWCOElvcFwaftN63ld8nwbwQHEXYeTtuiZkhU72JAU4XX0LKHrcxNcfoZ9MI2pSSFcaUEGc7VEBZY6j1JsazG09IttlFLSo7KbU+WHhvem2xF5PKs8/TkXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cz22hpPW7D8R8puFEvMTvimJbifaQdLgpjg+E4MEih8=;
 b=n5oeYo089/nUQGA/t0dr4p8WZjbQ+MRq7f6tOccfFGvGrJH6DogQQ1jmUaZfCNjZwgDbIPAuRqwNYlrebd1YwuVmSGfsWlWBjUDUVF0DrW7cCBxMvuz+1tZoC/8xV4SDosY+MWQB7CHPNVNJ1ckHoemP2+W7DNP6Zma27T4LpAE=
Received: from CH5PR05CA0010.namprd05.prod.outlook.com (2603:10b6:610:1f0::22)
 by CY8PR12MB7756.namprd12.prod.outlook.com (2603:10b6:930:85::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.28; Sat, 15 Mar
 2025 17:22:04 +0000
Received: from CH2PEPF0000013E.namprd02.prod.outlook.com
 (2603:10b6:610:1f0:cafe::26) by CH5PR05CA0010.outlook.office365.com
 (2603:10b6:610:1f0::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.28 via Frontend Transport; Sat,
 15 Mar 2025 17:22:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000013E.mail.protection.outlook.com (10.167.244.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Sat, 15 Mar 2025 17:22:04 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sat, 15 Mar
 2025 12:22:02 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu/sdma: fix engine reset handling
Date: Sat, 15 Mar 2025 13:21:50 -0400
Message-ID: <20250315172150.3901918-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013E:EE_|CY8PR12MB7756:EE_
X-MS-Office365-Filtering-Correlation-Id: 62d1942e-990a-4a0a-ebc6-08dd63e5e7c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?jDS43AlWY9zr2ZXvZGUR70mPLGjN4YRGkzqm6cjY1SyudiZQoo6BWts3kAi8?=
 =?us-ascii?Q?jeBtUYtv01cxZgoF1QbLn/NsC4dzTIpVFZbqlOdaDVcstj34z1L8D9xUK0en?=
 =?us-ascii?Q?uBSJBlpVBDfuHi2Cj+UGK4dr9S5ooTj886g7hB7DuO72ukAYOMD/sjBzMByw?=
 =?us-ascii?Q?YeJ6u0zC8uJ4sGgBCQsdOTsc18IwWV1xbbeyCT+3gs2KZZydlDhs37+qnyyk?=
 =?us-ascii?Q?zCbZGvIE34jXN/8SDz9m2aj2NB77rIPoK/ehvUQlNTzMdy7oxFWqTz6tO92N?=
 =?us-ascii?Q?8hZ9xAsmSKemmCecmevTLiwbojARu51ywii8NXsS9LphbsVhhjjdQ7Sl/6Gs?=
 =?us-ascii?Q?H61B4nfkgXs8AFUKaYTMxhMgyF9tJLewhv9G/C0kIPWdRowHETwWPpMqwEuH?=
 =?us-ascii?Q?0R9q56rDeiB6K7163e51wzK/QmwdJCBweTDR8AzOcbQtAT2MDWvQPqMMDQo3?=
 =?us-ascii?Q?OsrCxLfCH+GM2EZHZqzikZVB8ZueTIeifTMk/NZrwOHaL8uEQoQc8B/2OJzE?=
 =?us-ascii?Q?tdCSRuknXnT6ijhX23e9+02vJbwj3kCVGPUzh6+iRYxgJWBSz8dTlEVkg+1U?=
 =?us-ascii?Q?Rd6lmjQfQ8/DM3y7y8jo1SVpEIxTcWwiCzZCFzqRs2jGuK5jH+wX1u5iJFOW?=
 =?us-ascii?Q?44DpjS8cVqEerMdQng/wgfSZsgJQbJ2wtFEAsoWNPjUWr2yL0AYO/Cw7o+Ws?=
 =?us-ascii?Q?gCkh7P5RJcIIs0KKxJKmhQYuk/LLdSKcqcAzvIoFw+14Y7lGJtiBcsZ6tpzU?=
 =?us-ascii?Q?wNQqURhfAoOsQuEj8oCP67vRCnIOfY/6Um5I1ZPAUjW5ET9JyB6miH1pOvxt?=
 =?us-ascii?Q?yxf+yFvfu7aGlAzH6c3wPZGyKp5DyTTKCkgvBIvhFXjv8t0cJPbMTH9SGTw2?=
 =?us-ascii?Q?VtZcpbX99Bc9uW387WQ6FMjXUGMKdk88tVm1drJT0ZU2h/ryh41ctFjhINoG?=
 =?us-ascii?Q?YNOnKmOvHFn+fuitRqZcikMttI7kUQitmWQR7OKBSik+YrOBabY8QT4aeAhT?=
 =?us-ascii?Q?oKl2ClPu6C3s+izSECG0wUk2t6IXWpXt9fpA5niZm+XSiDDTGjhpLIaNs13R?=
 =?us-ascii?Q?+9ubYfwApyNatyYJsDB/0zj4ejPwzvSqqED4r1xY7PEzcFmnNLITubcdWIqk?=
 =?us-ascii?Q?aYw83HvAw3BtwKBvoCtPn05S1X7KgHnh3QgqGTBHn+c5MuGZROfXtHmNtgn7?=
 =?us-ascii?Q?lXoSV4gN94dhj2Rzs+2soVFzSX06k9XEV9mq9ThOH799TdC2+5S27v2MPFti?=
 =?us-ascii?Q?ZzVKgX0U4oTszq2JGRcKER104NUlNJCcNP53PqnwFYtYV/anl6ZnJlB91uy9?=
 =?us-ascii?Q?aIlnia0TXT8BxZHnzq+BOgh5TLv/uHEZsG8GQ/WWVBFMLeBl6MOSfMLM3byg?=
 =?us-ascii?Q?VyffQYsGn/v5IeqWn2RmTfru55vO2bU9o4qRrVUjLPNqXCBhuG4JNVOU5/fp?=
 =?us-ascii?Q?mZAJXjJ3GJCR3ZCBPE858I6OuwXG3X0rFJo/ZFm7/lYKw7bFaisJJd49NLwR?=
 =?us-ascii?Q?H/GZdbCx/xG+DWU=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2025 17:22:04.3152 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 62d1942e-990a-4a0a-ebc6-08dd63e5e7c7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000013E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7756
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

Move the kfd suspend/resume code into the caller.  That
is where the KFD is likely to detect a reset so on the KFD
side there is no need to call them.  Also add a mutex to
lock the actual reset sequence.

Fixes: bac38ca8c475 ("drm/amdkfd: implement per queue sdma reset for gfx 9.4+")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c        |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c          | 15 +++------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h          |  3 ++-
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c          |  8 +++++++-
 .../gpu/drm/amd/amdkfd/kfd_device_queue_manager.c |  2 +-
 5 files changed, 14 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 1d8cfdc51bdcb..611b27c91a18a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4281,6 +4281,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	mutex_init(&adev->gfx.kfd_sch_mutex);
 	mutex_init(&adev->gfx.workload_profile_mutex);
 	mutex_init(&adev->vcn.workload_profile_mutex);
+	mutex_init(&adev->sdma.engine_reset_mutex);
 
 	amdgpu_device_init_apu_flags(adev);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
index 03c4c012a1508..0b2529ef5a963 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
@@ -524,7 +524,6 @@ void amdgpu_sdma_register_on_reset_callbacks(struct amdgpu_device *adev, struct
  * amdgpu_sdma_reset_engine - Reset a specific SDMA engine
  * @adev: Pointer to the AMDGPU device
  * @instance_id: ID of the SDMA engine instance to reset
- * @suspend_user_queues: check if suspend user queue.
  *
  * This function performs the following steps:
  * 1. Calls all registered pre_reset callbacks to allow KFD and AMDGPU to save their state.
@@ -533,7 +532,7 @@ void amdgpu_sdma_register_on_reset_callbacks(struct amdgpu_device *adev, struct
  *
  * Returns: 0 on success, or a negative error code on failure.
  */
-int amdgpu_sdma_reset_engine(struct amdgpu_device *adev, uint32_t instance_id, bool suspend_user_queues)
+int amdgpu_sdma_reset_engine(struct amdgpu_device *adev, uint32_t instance_id)
 {
 	struct sdma_on_reset_funcs *funcs;
 	int ret = 0;
@@ -542,13 +541,7 @@ int amdgpu_sdma_reset_engine(struct amdgpu_device *adev, uint32_t instance_id, b
 	struct amdgpu_ring *page_ring = &sdma_instance->page;
 	bool gfx_sched_stopped = false, page_sched_stopped = false;
 
-	/* Suspend KFD if suspend_user_queues is true.
-	 * prevent the destruction of in-flight healthy user queue packets and
-	 * avoid race conditions between KFD and KGD during the reset process.
-	 */
-	if (suspend_user_queues)
-		amdgpu_amdkfd_suspend(adev, false);
-
+	mutex_lock(&adev->sdma.engine_reset_mutex);
 	/* Stop the scheduler's work queue for the GFX and page rings if they are running.
 	* This ensures that no new tasks are submitted to the queues while
 	* the reset is in progress.
@@ -609,9 +602,7 @@ int amdgpu_sdma_reset_engine(struct amdgpu_device *adev, uint32_t instance_id, b
 			drm_sched_wqueue_start(&page_ring->sched);
 		}
 	}
-
-	if (suspend_user_queues)
-		amdgpu_amdkfd_resume(adev, false);
+	mutex_unlock(&adev->sdma.engine_reset_mutex);
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
index 9651693200655..d3a44a8cf6104 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
@@ -129,6 +129,7 @@ struct amdgpu_sdma {
 	/* track guilty state of GFX and PAGE queues */
 	bool gfx_guilty;
 	bool page_guilty;
+	struct mutex		engine_reset_mutex;
 };
 
 /*
@@ -169,7 +170,7 @@ struct amdgpu_buffer_funcs {
 };
 
 void amdgpu_sdma_register_on_reset_callbacks(struct amdgpu_device *adev, struct sdma_on_reset_funcs *funcs);
-int amdgpu_sdma_reset_engine(struct amdgpu_device *adev, uint32_t instance_id, bool suspend_user_queues);
+int amdgpu_sdma_reset_engine(struct amdgpu_device *adev, uint32_t instance_id);
 
 #define amdgpu_emit_copy_buffer(adev, ib, s, d, b, t) (adev)->mman.buffer_funcs->emit_copy_buffer((ib),  (s), (d), (b), (t))
 #define amdgpu_emit_fill_buffer(adev, ib, s, d, b) (adev)->mman.buffer_funcs->emit_fill_buffer((ib), (s), (d), (b))
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
index fd34dc1380811..14e4f7358cc4c 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -1666,7 +1666,13 @@ static int sdma_v4_4_2_reset_queue(struct amdgpu_ring *ring, unsigned int vmid)
 {
 	struct amdgpu_device *adev = ring->adev;
 	u32 id = GET_INST(SDMA0, ring->me);
-	return amdgpu_sdma_reset_engine(adev, id, true);
+	int r;
+
+	amdgpu_amdkfd_suspend(adev, false);
+	r = amdgpu_sdma_reset_engine(adev, id);
+	amdgpu_amdkfd_resume(adev, false);
+
+	return r;
 }
 
 static int sdma_v4_4_2_stop_queue(struct amdgpu_device *adev, uint32_t instance_id)
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 2ed003d3ff0e0..c610e172a2b83 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -2310,7 +2310,7 @@ static int reset_hung_queues_sdma(struct device_queue_manager *dqm)
 				continue;
 
 			/* Reset engine and check. */
-			if (amdgpu_sdma_reset_engine(dqm->dev->adev, i, false) ||
+			if (amdgpu_sdma_reset_engine(dqm->dev->adev, i) ||
 			    dqm->dev->kfd2kgd->hqd_sdma_get_doorbell(dqm->dev->adev, i, j) ||
 			    !set_sdma_queue_as_reset(dqm, doorbell_off)) {
 				r = -ENOTRECOVERABLE;
-- 
2.48.1

