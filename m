Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53F61C28B30
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Mar 2025 03:26:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC13710E6E6;
	Fri, 21 Mar 2025 03:25:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fAwweruL";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2069.outbound.protection.outlook.com [40.107.244.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD6CA10E6E6
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Mar 2025 03:25:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EMYbzH1o7Y1n20vuEXPPtJS45hyTSE3PnD79/pprTJyQiMONPqVrDawKcZfnvuWtLrw0ZPm7/IbVzHU73jkSnMzepCqw2pJvaN3JEUeFrOi8qYpL4RUFgx2YCzRLin1GPl4/qNfCT4LORxvmh9OtgzBOyo90lebn3VBlb1ykZU6E4Gy7VvTGuQgSuwTqk9F0GPiGEQTl/O+sR4zW4kelqgDLblVKQn4/TDBK6WewwgTAMDRLBcQAvgBy+8oR3TqGBSmrjTYrTOr7wOMSd0E7RD3sVbJb8cDfjKiEpyos38T99LpJAFAHQGYcaUNtCgRp/TO7uw8y36G6FaVbARmtuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yFAZIK7jSQJkIe8uGVLK0XcmyIOPL6RimrBTDdyKJ+M=;
 b=CN48Nqi+YioH0I9rftZhkQq0EGrIDTJ0wYOlr5G9ldUS4aCDEmZZczu4dRA9j02dko28McYb5BvIxVKTk9BhRTik1zhudOFDa5WRKBLWhwrIkCM0pjZWwLeGQdpCWu8segIsqUx0uLukHUZjD36nlMUbP16hTfeXZg1Pw1hmlYZV2jYLRKVL/cZhwK5NVkTkXeE7oCo5zFgLe5SbkHxDEQ6i2uZSrwwRPFNXaDCaK9DR1nHD3AGsh+z5rP1QZzdUH6hzuMZLItbVt0OR4BBUHKCQLzd8r/bs3TkrPf5g+8Lcy9Nd86u5IIPOEVnq8zKi/uYH220FlJXLUyewckRv/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yFAZIK7jSQJkIe8uGVLK0XcmyIOPL6RimrBTDdyKJ+M=;
 b=fAwweruLB4enYccKrGNlqjupstvIkksEVaRBqFH0dvTUjv4NPsRe9+slF1mIZ5xHH5Jxyh6WhEAUImiq1VMiLpmiQEi+POcnzSYZB+6zqnQfYSKGEsKbnwZFxljbKCOst1AXfZHFivCIlpZDafWiHbrIBLYcd5L0SAmazMBAB14=
Received: from BY5PR17CA0023.namprd17.prod.outlook.com (2603:10b6:a03:1b8::36)
 by CY8PR12MB8244.namprd12.prod.outlook.com (2603:10b6:930:72::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.36; Fri, 21 Mar
 2025 03:25:53 +0000
Received: from SJ1PEPF00002323.namprd03.prod.outlook.com
 (2603:10b6:a03:1b8:cafe::e6) by BY5PR17CA0023.outlook.office365.com
 (2603:10b6:a03:1b8::36) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.36 via Frontend Transport; Fri,
 21 Mar 2025 03:25:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002323.mail.protection.outlook.com (10.167.242.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Fri, 21 Mar 2025 03:25:53 +0000
Received: from sunce-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 20 Mar
 2025 22:25:51 -0500
From: Ce Sun <cesun102@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, Ce Sun <cesun102@amd.com>
Subject: [PATCH v4 2/4] drm/amdgpu: refactor amdgpu_device_gpu_recover
Date: Fri, 21 Mar 2025 11:25:34 +0800
Message-ID: <223ae3cf90a7b92000c705c48ce3d3d5fb1ef1f1.1742526761.git.cesun102@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1742526761.git.cesun102@amd.com>
References: <cover.1742526761.git.cesun102@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002323:EE_|CY8PR12MB8244:EE_
X-MS-Office365-Filtering-Correlation-Id: fef7636c-fc1f-423e-d956-08dd682815f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?mvxgN1k9pckZg4X6bncdlpyobZk+WEoy7smRLLUv/v1DlxlVJcpYn1iKWA4t?=
 =?us-ascii?Q?vDbWpIgGONEUBPzJf6ud0I6UdkMGWFhbD1MWZzR2OjBsnULWPOEvoQmwBHq+?=
 =?us-ascii?Q?8p1ZIJc7gosRLoVhD1RvFY9pL3kfGJq3EUlNDGzdveTg6VM7bAUpHw9+1fVO?=
 =?us-ascii?Q?v1NYnhlSVvpjXU0XFKuykS75YH9GGbLFZP3PuhepoK9t2aFIZHj3NBiZ9QsG?=
 =?us-ascii?Q?khasjakzmBj6ysGvNcRsq0da+akvtO09EnAO5/nJ8OZBBcX/K+SLq0i1ALoy?=
 =?us-ascii?Q?u/+FfdeGFDHb5UvUvTGNGkSlIKcpk9525m/rJJjfln/ai/bKbVbvvMmxvxWi?=
 =?us-ascii?Q?ZG4VY6opcYDbN+5biyxomCAAelSbEwswcCKXbV14plDqaTmLbXgx8Efcrsy/?=
 =?us-ascii?Q?pIL2vTI8l75qkqTW6+YlIja+bcFw6yrwXDWtuL42v9TiORFNWjor/y33Yc5V?=
 =?us-ascii?Q?101sU6Aza1bH8ngHJEo45xMqcRmIE7yHHaEplF5YrrSjjVqBukW6KjjW5FVl?=
 =?us-ascii?Q?3eaoWERiCOJFtkuWiPv8Hls6KfaIqMi2xU2k/zFtA3ZSESrTjSGlJF+jVIfS?=
 =?us-ascii?Q?ocdhFE0Tfdwf6ti9to7udlb8bDeqQEB8AStq19jr4JuvNQ/XkMvhJPA5d9xx?=
 =?us-ascii?Q?KKAhqw0rstX2g/FfHj9h7PeyrMgj3VgFdkbS3c1qPKxTE3hD2PvPf+RG/vfD?=
 =?us-ascii?Q?MfbIwfb7Tyj9AOzU7f/HU9MRDz1NT1m96xWhzvW+2i6Wjwt86NWN9GdVCa6D?=
 =?us-ascii?Q?qsFOTQDAKtz7DmeAvnz97Q++YjOZ/ZCS8zCfQykIQGvF5l67Wdy/GlTo1NLV?=
 =?us-ascii?Q?1/cIuFmbP8vx1K+XRUvPOP8EkOnTXzjJAqd5ILA2E70pzsaCaC8AWAoHWO4c?=
 =?us-ascii?Q?ekNT+TG6vjEAIMv7EReyPmI9y7lOhjbRAVp+iwtcBr+oLFYIfu2/9xXdXStv?=
 =?us-ascii?Q?GyKKaHRhIOkPR6O1kGk3mRKvgZqBuwiprjpYcRU7fQkaToadkNfJkvgYXD3b?=
 =?us-ascii?Q?Ztnl25nPJVUxjH4jtKovGM0LxpYoviUoS4F4QIIu2LfZ83jVeVnB5DGi86NA?=
 =?us-ascii?Q?MFrl+TG+tTlFa/C8N25VGYUlNbE3l4TQdVAAUwmrBgi/qFseWyCBqcnqTsc6?=
 =?us-ascii?Q?ytpEjqoVnyVfeWcE2mfwS1t0N0HygAukkzQJTroA6g3Ve72TwrpNyRV1Wl4g?=
 =?us-ascii?Q?Q9ORKvaYfcuhT+EYJtu3YI0cWkuEyr1S7/6h58khpCTU62dc9EVsvjHSTACF?=
 =?us-ascii?Q?/uKwWWMMPvQhBzo5025MFlDJKtquCqR5gJdWCgACVNX1bdx/2CSGk1dDHkAw?=
 =?us-ascii?Q?lLWjYEmqMppLWQWeM3owfRvSU0Oyakz/tibGPBJBuO6VNBzfFqUMxnE3TwIx?=
 =?us-ascii?Q?22xCxyoeEM/TQMI1WC1+0Tv+8b1qM0O/8Z8AK60fhx5e0sAwalnRWUcS4vmG?=
 =?us-ascii?Q?mFmMI0qTG111YmExv+c1SqyuVL8LoJNUV5K3UA2I0IjZZ9mrhWMhr9elz3fg?=
 =?us-ascii?Q?4QrEkgJLcZmClD4=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2025 03:25:53.1551 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fef7636c-fc1f-423e-d956-08dd682815f6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002323.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8244
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

Split amdgpu_device_gpu_recover into the following stages:
halt activities,asic reset,schedule resume and amdgpu resume.
The reason is that the subsequent addition of dpc recover
code will have a high similarity with gpu reset

Signed-off-by: Ce Sun <cesun102@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |   6 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 239 +++++++++++++--------
 2 files changed, 152 insertions(+), 93 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 28d344b33367..774df867ea71 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -856,6 +856,10 @@ struct amdgpu_mqd {
 			struct amdgpu_mqd_prop *p);
 };
 
+struct amdgpu_pcie_reset_ctx {
+	bool audio_suspended;
+};
+
 /*
  * Custom Init levels could be defined for different situations where a full
  * initialization of all hardware blocks are not expected. Sample cases are
@@ -1200,6 +1204,8 @@ struct amdgpu_device {
 	struct pci_saved_state          *pci_state;
 	pci_channel_state_t		pci_channel_state;
 
+	struct amdgpu_pcie_reset_ctx	pcie_reset_ctx;
+
 	/* Track auto wait count on s_barrier settings */
 	bool				barrier_has_auto_waitcnt;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 3079b8088840..9da399626a64 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5886,97 +5886,40 @@ static int amdgpu_device_health_check(struct list_head *device_list_handle)
 	return ret;
 }
 
-/**
- * amdgpu_device_gpu_recover - reset the asic and recover scheduler
- *
- * @adev: amdgpu_device pointer
- * @job: which job trigger hang
- * @reset_context: amdgpu reset context pointer
- *
- * Attempt to reset the GPU if it has hung (all asics).
- * Attempt to do soft-reset or full-reset and reinitialize Asic
- * Returns 0 for success or an error on failure.
- */
-
-int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
+static int amdgpu_device_halt_activities(struct amdgpu_device *adev,
 			      struct amdgpu_job *job,
-			      struct amdgpu_reset_context *reset_context)
+			      struct amdgpu_reset_context *reset_context,
+			      struct list_head *device_list,
+			      struct amdgpu_hive_info *hive,
+			      bool need_emergency_restart)
 {
-	struct list_head device_list, *device_list_handle =  NULL;
-	bool job_signaled = false;
-	struct amdgpu_hive_info *hive = NULL;
+	struct list_head *device_list_handle =  NULL;
 	struct amdgpu_device *tmp_adev = NULL;
 	int i, r = 0;
-	bool need_emergency_restart = false;
-	bool audio_suspended = false;
-	int retry_limit = AMDGPU_MAX_RETRY_LIMIT;
-
-	if (amdgpu_reset_domain_in_drain_mode(adev->reset_domain))
-		return 0;
-
-	/*
-	 * If it reaches here because of hang/timeout and a RAS error is
-	 * detected at the same time, let RAS recovery take care of it.
-	 */
-	if (amdgpu_ras_is_err_state(adev, AMDGPU_RAS_BLOCK__ANY) &&
-	    !amdgpu_sriov_vf(adev) &&
-	    reset_context->src != AMDGPU_RESET_SRC_RAS) {
-		dev_dbg(adev->dev,
-			"Gpu recovery from source: %d yielding to RAS error recovery handling",
-			reset_context->src);
-		return 0;
-	}
-	/*
-	 * Special case: RAS triggered and full reset isn't supported
-	 */
-	need_emergency_restart = amdgpu_ras_need_emergency_restart(adev);
-
-	/*
-	 * Flush RAM to disk so that after reboot
-	 * the user can read log and see why the system rebooted.
-	 */
-	if (need_emergency_restart && amdgpu_ras_get_context(adev) &&
-		amdgpu_ras_get_context(adev)->reboot) {
-		DRM_WARN("Emergency reboot.");
-
-		ksys_sync_helper();
-		emergency_restart();
-	}
-
-	dev_info(adev->dev, "GPU %s begin!\n",
-		need_emergency_restart ? "jobs stop":"reset");
-
-	if (!amdgpu_sriov_vf(adev))
-		hive = amdgpu_get_xgmi_hive(adev);
-	if (hive)
-		mutex_lock(&hive->hive_lock);
 
-	reset_context->job = job;
-	reset_context->hive = hive;
 	/*
 	 * Build list of devices to reset.
 	 * In case we are in XGMI hive mode, resort the device list
 	 * to put adev in the 1st position.
 	 */
-	INIT_LIST_HEAD(&device_list);
 	if (!amdgpu_sriov_vf(adev) && (adev->gmc.xgmi.num_physical_nodes > 1) && hive) {
 		list_for_each_entry(tmp_adev, &hive->device_list, gmc.xgmi.head) {
-			list_add_tail(&tmp_adev->reset_list, &device_list);
+			list_add_tail(&tmp_adev->reset_list, device_list);
 			if (adev->shutdown)
 				tmp_adev->shutdown = true;
 		}
-		if (!list_is_first(&adev->reset_list, &device_list))
-			list_rotate_to_front(&adev->reset_list, &device_list);
-		device_list_handle = &device_list;
+		if (!list_is_first(&adev->reset_list, device_list))
+			list_rotate_to_front(&adev->reset_list, device_list);
+		device_list_handle = device_list;
 	} else {
-		list_add_tail(&adev->reset_list, &device_list);
-		device_list_handle = &device_list;
+		list_add_tail(&adev->reset_list, device_list);
+		device_list_handle = device_list;
 	}
 
 	if (!amdgpu_sriov_vf(adev)) {
 		r = amdgpu_device_health_check(device_list_handle);
 		if (r)
-			goto end_reset;
+			return r;
 	}
 
 	/* We need to lock reset domain only once both for XGMI and single device */
@@ -6000,7 +5943,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 		 * some audio codec errors.
 		 */
 		if (!amdgpu_device_suspend_display_audio(tmp_adev))
-			audio_suspended = true;
+			tmp_adev->pcie_reset_ctx.audio_suspended = true;
 
 		amdgpu_ras_set_error_query_ready(tmp_adev, false);
 
@@ -6035,23 +5978,19 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 		atomic_inc(&tmp_adev->gpu_reset_counter);
 	}
 
-	if (need_emergency_restart)
-		goto skip_sched_resume;
+	return r;
+}
 
-	/*
-	 * Must check guilty signal here since after this point all old
-	 * HW fences are force signaled.
-	 *
-	 * job->base holds a reference to parent fence
-	 */
-	if (job && dma_fence_is_signaled(&job->hw_fence)) {
-		job_signaled = true;
-		dev_info(adev->dev, "Guilty job already signaled, skipping HW reset");
-		goto skip_hw_reset;
-	}
+static int amdgpu_device_asic_reset(struct amdgpu_device *adev,
+			      struct list_head *device_list,
+			      struct amdgpu_reset_context *reset_context)
+{
+	struct amdgpu_device *tmp_adev = NULL;
+	int retry_limit = AMDGPU_MAX_RETRY_LIMIT;
+	int r = 0;
 
 retry:	/* Rest of adevs pre asic reset from XGMI hive. */
-	list_for_each_entry(tmp_adev, device_list_handle, reset_list) {
+	list_for_each_entry(tmp_adev, device_list, reset_list) {
 		r = amdgpu_device_pre_asic_reset(tmp_adev, reset_context);
 		/*TODO Should we stop ?*/
 		if (r) {
@@ -6078,12 +6017,12 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 		if (r)
 			adev->asic_reset_res = r;
 	} else {
-		r = amdgpu_do_asic_reset(device_list_handle, reset_context);
+		r = amdgpu_do_asic_reset(device_list, reset_context);
 		if (r && r == -EAGAIN)
 			goto retry;
 	}
 
-	list_for_each_entry(tmp_adev, device_list_handle, reset_list) {
+	list_for_each_entry(tmp_adev, device_list, reset_list) {
 		/*
 		 * Drop any pending non scheduler resets queued before reset is done.
 		 * Any reset scheduled after this point would be valid. Scheduler resets
@@ -6093,10 +6032,18 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 		amdgpu_device_stop_pending_resets(tmp_adev);
 	}
 
-skip_hw_reset:
+	return r;
+}
+
+static int amdgpu_device_sched_resume(struct list_head *device_list,
+			      struct amdgpu_reset_context *reset_context,
+			      bool   job_signaled)
+{
+	struct amdgpu_device *tmp_adev = NULL;
+	int i, r = 0;
 
 	/* Post ASIC reset for all devs .*/
-	list_for_each_entry(tmp_adev, device_list_handle, reset_list) {
+	list_for_each_entry(tmp_adev, device_list, reset_list) {
 
 		for (i = 0; i < AMDGPU_MAX_RINGS; ++i) {
 			struct amdgpu_ring *ring = tmp_adev->rings[i];
@@ -6132,8 +6079,16 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 		}
 	}
 
-skip_sched_resume:
-	list_for_each_entry(tmp_adev, device_list_handle, reset_list) {
+	return r;
+}
+
+static void amdgpu_device_gpu_resume(struct amdgpu_device *adev,
+			      struct list_head *device_list,
+			      bool   need_emergency_restart)
+{
+	struct amdgpu_device *tmp_adev = NULL;
+
+	list_for_each_entry(tmp_adev, device_list, reset_list) {
 		/* unlock kfd: SRIOV would do it separately */
 		if (!need_emergency_restart && !amdgpu_sriov_vf(tmp_adev))
 			amdgpu_amdkfd_post_reset(tmp_adev);
@@ -6144,18 +6099,116 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 		if (!adev->kfd.init_complete)
 			amdgpu_amdkfd_device_init(adev);
 
-		if (audio_suspended)
+		if (tmp_adev->pcie_reset_ctx.audio_suspended)
 			amdgpu_device_resume_display_audio(tmp_adev);
 
 		amdgpu_device_unset_mp1_state(tmp_adev);
 
 		amdgpu_ras_set_error_query_ready(tmp_adev, true);
+
 	}
 
-	tmp_adev = list_first_entry(device_list_handle, struct amdgpu_device,
+	tmp_adev = list_first_entry(device_list, struct amdgpu_device,
 					    reset_list);
 	amdgpu_device_unlock_reset_domain(tmp_adev->reset_domain);
 
+}
+
+
+/**
+ * amdgpu_device_gpu_recover - reset the asic and recover scheduler
+ *
+ * @adev: amdgpu_device pointer
+ * @job: which job trigger hang
+ * @reset_context: amdgpu reset context pointer
+ *
+ * Attempt to reset the GPU if it has hung (all asics).
+ * Attempt to do soft-reset or full-reset and reinitialize Asic
+ * Returns 0 for success or an error on failure.
+ */
+
+int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
+			      struct amdgpu_job *job,
+			      struct amdgpu_reset_context *reset_context)
+{
+	struct list_head device_list;
+	bool job_signaled = false;
+	struct amdgpu_hive_info *hive = NULL;
+	int r = 0;
+	bool need_emergency_restart = false;
+
+	if (amdgpu_reset_domain_in_drain_mode(adev->reset_domain))
+		return 0;
+	/*
+	 * If it reaches here because of hang/timeout and a RAS error is
+	 * detected at the same time, let RAS recovery take care of it.
+	 */
+	if (amdgpu_ras_is_err_state(adev, AMDGPU_RAS_BLOCK__ANY) &&
+	    !amdgpu_sriov_vf(adev) &&
+	    reset_context->src != AMDGPU_RESET_SRC_RAS) {
+		dev_dbg(adev->dev,
+			"Gpu recovery from source: %d yielding to RAS error recovery handling",
+			reset_context->src);
+		return 0;
+	}
+
+	/*
+	 * Special case: RAS triggered and full reset isn't supported
+	 */
+	need_emergency_restart = amdgpu_ras_need_emergency_restart(adev);
+
+	/*
+	 * Flush RAM to disk so that after reboot
+	 * the user can read log and see why the system rebooted.
+	 */
+	if (need_emergency_restart && amdgpu_ras_get_context(adev) &&
+		amdgpu_ras_get_context(adev)->reboot) {
+		DRM_WARN("Emergency reboot.");
+
+		ksys_sync_helper();
+		emergency_restart();
+	}
+
+	dev_info(adev->dev, "GPU %s begin!\n",
+		need_emergency_restart ? "jobs stop":"reset");
+
+	if (!amdgpu_sriov_vf(adev))
+		hive = amdgpu_get_xgmi_hive(adev);
+	if (hive)
+		mutex_lock(&hive->hive_lock);
+
+	reset_context->job = job;
+	reset_context->hive = hive;
+	INIT_LIST_HEAD(&device_list);
+
+	r = amdgpu_device_halt_activities(adev, job, reset_context, &device_list,
+					 hive, need_emergency_restart);
+	if (r)
+		goto end_reset;
+
+	if (need_emergency_restart)
+		goto skip_sched_resume;
+	/*
+	 * Must check guilty signal here since after this point all old
+	 * HW fences are force signaled.
+	 *
+	 * job->base holds a reference to parent fence
+	 */
+	if (job && dma_fence_is_signaled(&job->hw_fence)) {
+		job_signaled = true;
+		dev_info(adev->dev, "Guilty job already signaled, skipping HW reset");
+		goto skip_hw_reset;
+	}
+
+	r = amdgpu_device_asic_reset(adev, &device_list, reset_context);
+	if (r)
+		goto end_reset;
+skip_hw_reset:
+	r = amdgpu_device_sched_resume(&device_list, reset_context, job_signaled);
+	if (r)
+		goto end_reset;
+skip_sched_resume:
+	amdgpu_device_gpu_resume(adev, &device_list, need_emergency_restart);
 end_reset:
 	if (hive) {
 		mutex_unlock(&hive->hive_lock);
-- 
2.34.1

