Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D0BFC369D7
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Apr 2025 18:39:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CAA1310E985;
	Fri, 25 Apr 2025 18:39:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="aMAOelac";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2089.outbound.protection.outlook.com [40.107.236.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D56810E979
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Apr 2025 18:39:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TAzzen8qN/briR9W4Tq1otzxyoMkQSj8NgnrSUsSlKWeUyLjQEwM9QYqCcHd0GSDDipvk3Cb/3klpw9t/CCFTG+SCPUq76CLjUo9J9QZr9Pv+LEvS1TG7uTGOMx1ei5Fv0O+rVHWqA9wXxcdMaDIXIgjtq48vpaVWhxj6z8gorHw8f+FIzNfy+J9XOdVI3hCC0d++F8BxkbI1jHM+I2m9tyBC2+CGxEWUuh7SOOXgY81aLfY1MRGiwspaOEMysktuwAB0oupiWTb1u0YC3Q1rxmd1d4ZS3vEFTC2NqHG99/3Hs2ZVT862gVuibjxuVVCq5X9Pj6sjNLwfkcACwJr7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CxRKVU0V4nvblqRYeOUySj4X+4F2NPNlfGjcQzrPkWo=;
 b=nUclZ+j5YZv75Tut7CCyo2qxRtbHR5PkK7lkCXgmOqs4gwE/f4Luex7STSJnP9ln6khjh1g7mIcW9xtl5TxFOX04yECP7NZ4MLTO+4on+lVmR1SnDgKLLZNNmhO3Faiq4tWcWLswpbXZhP1e13hc24hDlRs/nxs09TnV8Qit5sz7tGTpTj7m+2rGvYYdl8xOLTgSz6ce54gGnz3U+EX+c3KDinf0ahdWTRELHlLHf2GYL61LkC2+nI9IkVd9fG6wkuLEm1wGUWj36OrkNVCsamZz5h0y9QGmtNFTQFN6/Z3it5QWEK/peREMq38ErRXqSS7k/E6oYykJJiaEwdHPrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CxRKVU0V4nvblqRYeOUySj4X+4F2NPNlfGjcQzrPkWo=;
 b=aMAOelac8sIwYNOs42C/oOEDP1KTDr7BrFC9NirqkwPDRdyEcUwE9M/3BzUXyzVrnsR3hv2ywyFfXv5YZww0gRc0lDT6XACmqDHAw5KTIn5+B9aH5J6sNu1tAOREuvfYvgpeO1NiJ7l+eANnryenIiU5AU7jhu4wXzRGCfL57Xg=
Received: from DS7PR03CA0326.namprd03.prod.outlook.com (2603:10b6:8:2b::28) by
 BY5PR12MB4225.namprd12.prod.outlook.com (2603:10b6:a03:211::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Fri, 25 Apr
 2025 18:39:12 +0000
Received: from DS2PEPF00003446.namprd04.prod.outlook.com
 (2603:10b6:8:2b:cafe::ed) by DS7PR03CA0326.outlook.office365.com
 (2603:10b6:8:2b::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.38 via Frontend Transport; Fri,
 25 Apr 2025 18:39:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003446.mail.protection.outlook.com (10.167.17.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Fri, 25 Apr 2025 18:39:12 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 25 Apr
 2025 13:39:10 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 7/9] drm/amdgpu/userq: implement resets
Date: Fri, 25 Apr 2025 14:38:53 -0400
Message-ID: <20250425183855.165199-7-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250425183855.165199-1-alexander.deucher@amd.com>
References: <20250425183855.165199-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003446:EE_|BY5PR12MB4225:EE_
X-MS-Office365-Filtering-Correlation-Id: f2cbc593-5a78-45c8-1455-08dd84287920
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3Y1ab48WC6ngT984LXV3Y5oBsweg5P9yTq9SkjrMxmZO3/nX6OaRLFKHxgl8?=
 =?us-ascii?Q?+qJGIekvinghGaHrjWBwxryk51D63KXowlOU4ehto4XUYLKNg8chVAkgj9vO?=
 =?us-ascii?Q?w8XB8VhBWfkNYzJG2Jm5azAF/jDFblAVctgrR6qPdmUzNpinIvW4YeZpuDly?=
 =?us-ascii?Q?p3XiTAgpEQUaCRWtm8pJFKjta44t6+p3XDS/cqjddupsyz6XMOjP8jD8G7Pj?=
 =?us-ascii?Q?YmuKA72bcQL3tGjB2djCsjj1ZYe9SCQtDzAq3KzeIY2AuWjUsplHybWlB47n?=
 =?us-ascii?Q?Rz1T6JinG9J5u6Sf6TwbvUR6utTNE0kpRzxmjO00vkxBS6AyZh56sgJEXZg3?=
 =?us-ascii?Q?PpzLsS2jjN7jsdT7tYC6M0Mj/g8pyu0MyyOcYMb4hUIQlXxPs9Y5ZF6PSbk2?=
 =?us-ascii?Q?17Rw6y1aIeeHSDLy6uYloeolVKJ6b27RmfL+DhncQHQJOAbmHLPgezfuMOH2?=
 =?us-ascii?Q?xShPo05rNH1V9qaqv+yLvvNL5V4FXZPy2yaPY9/AdyeuDO2YjMQ/zJQAky+u?=
 =?us-ascii?Q?2I7b9ABvIXFNN1V4WPos11169AUKwlYrVk2AXmvnU60hEjYB/BU2Fpthk/Mi?=
 =?us-ascii?Q?Wn/ntvNcc1TCGfbNANQR435OPCyTJjfJOVnPhWpbv88hZq1wJo8lMXXY0Vza?=
 =?us-ascii?Q?AxyM2SNijZX1EmTgoHkwY1Tns114SOVbZsnddhhJGRLTaSAKKtRJwZbeOBKE?=
 =?us-ascii?Q?mLU4LvSkrpS8Y6Qcm0UC15PEyyiuJp+c2lZ5oqqqAK8GX39ztWolH2/mGRnw?=
 =?us-ascii?Q?sdpdfcq28xjwBEiBC4Mu/ar15W/EDSEYxZ+b4orum1z8kgpH/KthUPFTnvoX?=
 =?us-ascii?Q?3Pca8/cl8xOO7AXkT+FkSTj5RZzWifFyc3xyLkTMKmjAlzGeW89jrXtjDlAM?=
 =?us-ascii?Q?Wc4rosFfRlEuYgtTc1upE4DnHVcAPQXevqJzTZ020VQpZWxjddLQd7q6yrwL?=
 =?us-ascii?Q?cTKIp1DqEdfXYnr6jxzVvLTRfIGc0MNLCQnkx15Wja6XzPr7ACCuqapqwQWE?=
 =?us-ascii?Q?8jlhnBfmO01uwb93uw+4aGb7DDYuJ5ZjbsDH4R1NF27kGW0Rj6Obxt6OZ4ej?=
 =?us-ascii?Q?I5AX8JiiaJk+NXmGrnlnx9ejexgGNE2aK9TCdx3Ilah3wEGbWSXHkq0PWBqE?=
 =?us-ascii?Q?6lynXHJjCFk5DFHQxxcYWfmdlRKQ0CYeigLETEDdcdNuAnfHcDLWf7fQbUlU?=
 =?us-ascii?Q?ldcTTuOT9/IoGAuBgpF5sdYcWormcukE6BBrWAccXVo3m+wDpjQc8q8jWQyz?=
 =?us-ascii?Q?DZgwI0+luuCNeu8eJmU2s6CwJkBj9L1hoXUa6MJDgc59UPttU2h5mNdnjBVh?=
 =?us-ascii?Q?jFJCoiL5YwqG3H1k9s/MQ9ziyFJU9kO7+881rIsAaPAhK9RaEArwcqjqA49W?=
 =?us-ascii?Q?sLHQIkZfiEAfhGXo4pMmr2kC9KrXmolM9ZcN9O/dzScCEmZfxWKr0W+X1NLt?=
 =?us-ascii?Q?izwrURiSKrrZGQM0JwQjePpAf/BdrDRDoAn2xolwd95EzRDib94reYLJDh+X?=
 =?us-ascii?Q?uol7CY9gt1C6PYK4fEL0pSCOzkcszRCQrpEg?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2025 18:39:12.1400 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f2cbc593-5a78-45c8-1455-08dd84287920
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003446.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4225
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

If map or unmap fails, or a user fence times out, attempt to
reset the queue.  If that fails, schedule a GPU reset.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |   8 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c  | 128 +++++++++++++++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h  |   5 +
 4 files changed, 131 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index cc26cf1bd843e..936e1a0ac02f1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1251,6 +1251,7 @@ struct amdgpu_device {
 	struct list_head		userq_mgr_list;
 	struct mutex                    userq_mutex;
 	bool                            userq_halt_for_enforce_isolation;
+	struct work_struct		userq_reset_work;
 };
 
 static inline uint32_t amdgpu_ip_version(const struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index fe68ba9997ae4..317c86c1493a8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4420,6 +4420,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	}
 
 	INIT_WORK(&adev->xgmi_reset_work, amdgpu_device_xgmi_reset_func);
+	INIT_WORK(&adev->userq_reset_work, amdgpu_userq_reset_work);
 
 	adev->gfx.gfx_off_req_count = 1;
 	adev->gfx.gfx_off_residency = 0;
@@ -5777,6 +5778,10 @@ int amdgpu_device_reinit_after_reset(struct amdgpu_reset_context *reset_context)
 				if (r)
 					goto out;
 
+				r = amdgpu_userq_post_reset(tmp_adev, vram_lost);
+				if (r)
+					goto out;
+
 				drm_client_dev_resume(adev_to_drm(tmp_adev), false);
 
 				/*
@@ -5999,6 +6004,7 @@ static inline void amdgpu_device_stop_pending_resets(struct amdgpu_device *adev)
 	if (!amdgpu_sriov_vf(adev))
 		cancel_work(&adev->reset_work);
 #endif
+	cancel_work(&adev->userq_reset_work);
 
 	if (adev->kfd.dev)
 		cancel_work(&adev->kfd.reset_work);
@@ -6109,6 +6115,8 @@ static int amdgpu_device_halt_activities(struct amdgpu_device *adev,
 		      amdgpu_device_ip_need_full_reset(tmp_adev))
 			amdgpu_ras_suspend(tmp_adev);
 
+		amdgpu_userq_pre_reset(tmp_adev);
+
 		for (i = 0; i < AMDGPU_MAX_RINGS; ++i) {
 			struct amdgpu_ring *ring = tmp_adev->rings[i];
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index afbe01149ed3f..4be46fa76ceba 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -26,7 +26,10 @@
 #include <drm/drm_exec.h>
 #include <linux/pm_runtime.h>
 
+#include <drm/drm_drv.h>
+
 #include "amdgpu.h"
+#include "amdgpu_reset.h"
 #include "amdgpu_vm.h"
 #include "amdgpu_userq.h"
 #include "amdgpu_userq_fence.h"
@@ -44,6 +47,44 @@ u32 amdgpu_userq_get_supported_ip_mask(struct amdgpu_device *adev)
 	return userq_ip_mask;
 }
 
+static void amdgpu_userq_gpu_reset(struct amdgpu_device *adev)
+{
+
+	if (amdgpu_device_should_recover_gpu(adev))
+		amdgpu_reset_domain_schedule(adev->reset_domain,
+					     &adev->userq_reset_work);
+}
+
+static bool
+amdgpu_userq_queue_reset_helper(struct amdgpu_userq_mgr *uq_mgr,
+				struct amdgpu_usermode_queue *queue)
+{
+	struct amdgpu_device *adev = uq_mgr->adev;
+	const struct amdgpu_userq_funcs *userq_funcs =
+		adev->userq_funcs[queue->queue_type];
+	bool gpu_reset = false;
+	int r;
+
+	if (unlikely(adev->debug_disable_gpu_ring_reset)) {
+		dev_err(adev->dev, "userq reset disabled by debug mask\n");
+	} else if (amdgpu_gpu_recovery && userq_funcs->reset) {
+		r = userq_funcs->reset(uq_mgr, queue);
+		if (r) {
+			dev_err(adev->dev, "userq reset failed\n");
+			gpu_reset = true;
+		} else {
+			dev_err(adev->dev, "userq reset succeeded\n");
+			atomic_inc(&adev->gpu_reset_counter);
+			amdgpu_userq_fence_driver_force_completion(queue);
+			drm_dev_wedged_event(adev_to_drm(adev), DRM_WEDGE_RECOVERY_NONE);
+		}
+	} else if (amdgpu_gpu_recovery && !userq_funcs->reset) {
+		gpu_reset = true;
+	}
+
+	return gpu_reset;
+}
+
 static int
 amdgpu_userq_unmap_helper(struct amdgpu_userq_mgr *uq_mgr,
 			  struct amdgpu_usermode_queue *queue)
@@ -51,15 +92,22 @@ amdgpu_userq_unmap_helper(struct amdgpu_userq_mgr *uq_mgr,
 	struct amdgpu_device *adev = uq_mgr->adev;
 	const struct amdgpu_userq_funcs *userq_funcs =
 		adev->userq_funcs[queue->queue_type];
+	bool gpu_reset = false;
 	int r = 0;
 
 	if (queue->state == AMDGPU_USERQ_STATE_MAPPED) {
 		r = userq_funcs->unmap(uq_mgr, queue);
-		if (r)
+		if (r) {
 			queue->state = AMDGPU_USERQ_STATE_HUNG;
-		else
+			gpu_reset = amdgpu_userq_queue_reset_helper(uq_mgr, queue);
+		} else {
 			queue->state = AMDGPU_USERQ_STATE_UNMAPPED;
+		}
 	}
+
+	if (gpu_reset)
+		amdgpu_userq_gpu_reset(adev);
+
 	return r;
 }
 
@@ -70,16 +118,22 @@ amdgpu_userq_map_helper(struct amdgpu_userq_mgr *uq_mgr,
 	struct amdgpu_device *adev = uq_mgr->adev;
 	const struct amdgpu_userq_funcs *userq_funcs =
 		adev->userq_funcs[queue->queue_type];
+	bool gpu_reset = false;
 	int r = 0;
 
 	if (queue->state == AMDGPU_USERQ_STATE_UNMAPPED) {
 		r = userq_funcs->map(uq_mgr, queue);
 		if (r) {
 			queue->state = AMDGPU_USERQ_STATE_HUNG;
+			gpu_reset = amdgpu_userq_queue_reset_helper(uq_mgr, queue);
 		} else {
 			queue->state = AMDGPU_USERQ_STATE_MAPPED;
 		}
 	}
+
+	if (gpu_reset)
+		amdgpu_userq_gpu_reset(adev);
+
 	return r;
 }
 
@@ -698,6 +752,23 @@ amdgpu_userq_evict_all(struct amdgpu_userq_mgr *uq_mgr)
 	return ret;
 }
 
+void amdgpu_userq_reset_work(struct work_struct *work)
+{
+	struct amdgpu_device *adev = container_of(work, struct amdgpu_device,
+						  userq_reset_work);
+	struct amdgpu_reset_context reset_context;
+
+	memset(&reset_context, 0, sizeof(reset_context));
+
+	reset_context.method = AMD_RESET_METHOD_NONE;
+	reset_context.reset_req_dev = adev;
+	reset_context.src = AMDGPU_RESET_SRC_USERQ;
+	set_bit(AMDGPU_NEED_FULL_RESET, &reset_context.flags);
+	/*set_bit(AMDGPU_SKIP_COREDUMP, &reset_context.flags);*/
+
+	amdgpu_device_gpu_recover(adev, NULL, &reset_context);
+}
+
 static int
 amdgpu_userq_wait_for_signal(struct amdgpu_userq_mgr *uq_mgr)
 {
@@ -724,22 +795,19 @@ void
 amdgpu_userq_evict(struct amdgpu_userq_mgr *uq_mgr,
 		   struct amdgpu_eviction_fence *ev_fence)
 {
-	int ret;
 	struct amdgpu_fpriv *fpriv = uq_mgr_to_fpriv(uq_mgr);
 	struct amdgpu_eviction_fence_mgr *evf_mgr = &fpriv->evf_mgr;
+	struct amdgpu_device *adev = uq_mgr->adev;
+	int ret;
 
 	/* Wait for any pending userqueue fence work to finish */
 	ret = amdgpu_userq_wait_for_signal(uq_mgr);
-	if (ret) {
-		DRM_ERROR("Not evicting userqueue, timeout waiting for work\n");
-		return;
-	}
+	if (ret)
+		dev_err(adev->dev, "Not evicting userqueue, timeout waiting for work\n");
 
 	ret = amdgpu_userq_evict_all(uq_mgr);
-	if (ret) {
-		DRM_ERROR("Failed to evict userqueue\n");
-		return;
-	}
+	if (ret)
+		dev_err(adev->dev, "Failed to evict userqueue\n");
 
 	/* Signal current eviction fence */
 	amdgpu_eviction_fence_signal(evf_mgr, ev_fence);
@@ -914,3 +982,41 @@ int amdgpu_userq_start_sched_for_enforce_isolation(struct amdgpu_device *adev,
 	mutex_unlock(&adev->userq_mutex);
 	return ret;
 }
+
+void amdgpu_userq_pre_reset(struct amdgpu_device *adev)
+{
+	const struct amdgpu_userq_funcs *userq_funcs;
+	struct amdgpu_usermode_queue *queue;
+	struct amdgpu_userq_mgr *uqm, *tmp;
+	int queue_id;
+
+	mutex_lock(&adev->userq_mutex);
+	list_for_each_entry_safe(uqm, tmp, &adev->userq_mgr_list, list) {
+		cancel_delayed_work_sync(&uqm->resume_work);
+		mutex_lock(&uqm->userq_mutex);
+		idr_for_each_entry(&uqm->userq_idr, queue, queue_id) {
+			if (queue->state == AMDGPU_USERQ_STATE_MAPPED) {
+				amdgpu_userq_wait_for_last_fence(uqm, queue);
+				userq_funcs = adev->userq_funcs[queue->queue_type];
+				userq_funcs->unmap(uqm, queue);
+				/* just mark all queues as hung at this point.
+				 * if unmap succeeds, we could map again
+				 * in amdgpu_userq_post_reset() if vram is not lost
+				 */
+				queue->state = AMDGPU_USERQ_STATE_HUNG;
+				amdgpu_userq_fence_driver_force_completion(queue);
+			}
+		}
+		mutex_unlock(&uqm->userq_mutex);
+	}
+	mutex_unlock(&adev->userq_mutex);
+}
+
+int amdgpu_userq_post_reset(struct amdgpu_device *adev, bool vram_lost)
+{
+	/* if any queue state is AMDGPU_USERQ_STATE_UNMAPPED
+	 * at this point, we should be able to map it again
+	 * and continue if vram is not lost.
+	 */
+	return 0;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
index 24d201cdc9887..6ede08dd821d2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -132,4 +132,9 @@ int amdgpu_userq_stop_sched_for_enforce_isolation(struct amdgpu_device *adev,
 int amdgpu_userq_start_sched_for_enforce_isolation(struct amdgpu_device *adev,
 						   u32 idx);
 
+void amdgpu_userq_reset_work(struct work_struct *work);
+
+void amdgpu_userq_pre_reset(struct amdgpu_device *adev);
+int amdgpu_userq_post_reset(struct amdgpu_device *adev, bool vram_lost);
+
 #endif
-- 
2.49.0

