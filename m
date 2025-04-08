Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E783EC3600C
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Apr 2025 08:36:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7507210E609;
	Tue,  8 Apr 2025 08:36:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UbfL3Aw4";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2052.outbound.protection.outlook.com [40.107.223.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4092910E609
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Apr 2025 08:36:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ucu8r6taJN0SL0tfNOIoAOygMQjl7fEGJHk/ToVlDFEpcSQje2eYp/K5XlYcsxZZspozfCp8EDzqlteXB1r8l89pDnQjwXryo09WIlMBkkxT/mqVr6jsEfnQwKVke77G15RzzntDWSJ10OOkG1k7PCd0M++fmX6658PKZUo8HRrOpBl9mYzdhAPpGFbm3U9K5arEuWmNLjehT1zMe9RrdV9T4zBbGvt7ngYRWBXrTLl45Xfup4Lxq/k9eirxbxXlsvu03mFsJNfV0xx+5o9Dp5vvkFwXM01txoTYHf3pYxQPEGmjIHYlqlhmKDYmz0mihkzxqMMFTpm09Zex4FIXIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c/CxgscKc6iddhkkevlWv4qQHMjM9VEePcn93hx6aU8=;
 b=xLKo4I9jfzucECttF95XeO3iChasZOMNJDrpCzSySGTocZ6P3VHXT+cAhgJLzlBhiyWDMuEx9rt7nDPDfP2U2Put0iGpbQetC/K2AEM5xJJt7NY5mcg5wQaFRnNKK1UlcorSksrW7BmFUy4me3X7HsKb8hDU3GVdnEyvsRaEEDGsRbEhoCJpNJiYmVaRCfBtV+8DxaOydriOMTN9hKd/aYvHEVgAzcrK8l/L6rLCwNJDNXIXvwIx2hEIqzOrYGpeAnwu7fHfR8jXO0S3/LxUbcxoAAY9teE2enEeym3q8C+dty5pAlFnjAmuuSRlMQ1pCHT+e7gIllbwGKUI6IvRQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c/CxgscKc6iddhkkevlWv4qQHMjM9VEePcn93hx6aU8=;
 b=UbfL3Aw4FqCyC24KBiX/xJo45QKP2XLQ5CA37DCJN4IuDP+Dv+WrukYP/vE53awMsRdFYqRBQb59PpzK1UZZQKUMFLBypCW+6stbstSkNm6KDZ9+wXROLhqFRqBhobKLhzHLxloKiAO4xknd+4SDyWbwVO3t0XMaHrCNH59eLyo=
Received: from CH0PR07CA0003.namprd07.prod.outlook.com (2603:10b6:610:32::8)
 by PH7PR12MB9202.namprd12.prod.outlook.com (2603:10b6:510:2ef::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.29; Tue, 8 Apr
 2025 08:36:48 +0000
Received: from CH2PEPF0000009C.namprd02.prod.outlook.com
 (2603:10b6:610:32:cafe::ef) by CH0PR07CA0003.outlook.office365.com
 (2603:10b6:610:32::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8606.35 via Frontend Transport; Tue,
 8 Apr 2025 08:36:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000009C.mail.protection.outlook.com (10.167.244.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8606.22 via Frontend Transport; Tue, 8 Apr 2025 08:36:47 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 8 Apr
 2025 03:36:46 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 8 Apr
 2025 03:36:45 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Tue, 8 Apr 2025 03:36:39 -0500
From: "Jesse.zhang@amd.com" <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <jonathan.kim@amd.com>, <jiadong.zhu@amd.com>, "Jesse.zhang@amd.com"
 <jesse.zhang@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [v4 1/7] drm/amd/amdgpu: Simplify SDMA reset mechanism by removing
 dynamic callbacks
Date: Tue, 8 Apr 2025 16:36:27 +0800
Message-ID: <20250408083633.2300420-1-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009C:EE_|PH7PR12MB9202:EE_
X-MS-Office365-Filtering-Correlation-Id: 6929d179-516e-4e20-f387-08dd76788044
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?K8MjC7XPgHjSBBRRsSm75uaQspTUl169NIPJsy6jrfzQAaZemYGSiOa0fQlJ?=
 =?us-ascii?Q?jgEdTQI4O7/fmHB07bwYCB9AkNp18iTZAChyHRxigRsOOExFi+cSE7rieRyG?=
 =?us-ascii?Q?xkQ/SPShZyazVApKW0fxIa/hNFXxJ8HE3JSVIH2KVub5p2yBuz4qVy2uk3HG?=
 =?us-ascii?Q?u/DMe15a2DOMd471Qk2m/9vsWnRLX5SBArBhdtPONO6TZzD6/C9eYc3wog/+?=
 =?us-ascii?Q?euvEN7jpFWNiFHke3aDgxBB0IXj4VX/i9R2Kc3qpvfvrxiHMG5kP8nxEkRot?=
 =?us-ascii?Q?F8ULb/7Xob45ntdg0V2MTR+K9DBZKTiMcHtRi/piKa3D48HrtGsNr/epoQHT?=
 =?us-ascii?Q?GTlr3uQ/UyFrBUX0Rqdy07lr5vVaqnp/LUQD0W2h3YLzXljizhImpGu2bSf8?=
 =?us-ascii?Q?LwCh9Smp3I4HN7003ja8Pj6QhbNSYU5ehwyNBX+gUFcqq2trK7NqXYDzZyWt?=
 =?us-ascii?Q?dhYXnf/8qiWUXJ29WnKD+WM3K7s2uiZBgmlZkzN1dwkcxset9TJ9Sgrl93MM?=
 =?us-ascii?Q?k3mXUdvZ0wwN5C6mTy1mDPLZ9ZGE/foNtkIkMPJ2WbXJd5j0rTfozMBB4Hp1?=
 =?us-ascii?Q?Fwv/RSVS5GEKzifQ85aF1RmX/FejRhEhUrjyJtPSsuXirnxnHRv2QivVceMR?=
 =?us-ascii?Q?JN7Mgcj2gGGGkChTpoeOArSOWQWlk8fsljFD/XIi0YcRe1b2ze9itDemtKh4?=
 =?us-ascii?Q?maY726D0f1gsxN5uzM3/MH+/qDnVaXAO1tRqjqHH9TErwabBWy9zNRvuLwrz?=
 =?us-ascii?Q?F0jRzPP58gXfIV+Fw++JQwh2hqD7ALrKe9YK8x/BRHIJT3aslskkgVzjrJZu?=
 =?us-ascii?Q?rEUR7O1yNFHAbXnXMTvvW4E+nfP4+lWVJ9Wdxzc3iBtwil32wFsF0US2DpGd?=
 =?us-ascii?Q?18LAQLh7rrPoWdNdrIoMjTHJ7VePlur4RIYuHFuq9ttgwNfBv8lxZrt8HxAx?=
 =?us-ascii?Q?h2wUnIeaVHS/lHwlrkOC6kcZrmG3+PWtLynALbD12KuxFgVOU+oG9yG+TlmP?=
 =?us-ascii?Q?pbpGp6BLe77aHX/JbM/8HoqPClDbAuEOIYiMzUbjb3lJpv0HWo9cq+T4/goF?=
 =?us-ascii?Q?0IXpsv6kgHPUfEwCn9llkGgpN+rGU/kiic/BtzRIZYwQY+IScG8md9jRttkY?=
 =?us-ascii?Q?gitQ+cysq1sxRxeaiol7u/EuCssVQK1aBBlBtTu0G6mBGUIPMLi+gXsK90NP?=
 =?us-ascii?Q?KSp+h9gfgbDq+4YPNJhe3mj6xsVT2MPTwkjG402q09EsuztOO3JGk5pncQE4?=
 =?us-ascii?Q?Mbixg5EhuXZyfQSjeReIDfpOcQWKyNG87c0j3PK3xmoSUfmFjjcvgEXVqM8s?=
 =?us-ascii?Q?Ti5J6++QMDYwijneHKXGCOpERGD/U8FPqqeO9sLV8Y7m/c0RqznKlQf2SaCd?=
 =?us-ascii?Q?OtszWKqzBFbEa3Q8vIFx4g59Fwz/MfYhe5OUT3L7c0yERKIfPwV/WJgvW3z7?=
 =?us-ascii?Q?lKNqksjQ7OorEDMIt7zsiaNTgoQpIT+epSh6ihgFNy+b46qk16EtzMV8bigg?=
 =?us-ascii?Q?XYOGxwupWx5A1hg=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2025 08:36:47.6008 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6929d179-516e-4e20-f387-08dd76788044
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9202
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

Since KFD no longer registers its own callbacks for SDMA resets, and only KGD uses the reset mechanism,
we can simplify the SDMA reset flow by directly calling the ring's `stop_queue` and `start_queue` functions.
This patch removes the dynamic callback mechanism and prepares for its eventual deprecation.

1. **Remove Dynamic Callbacks**:
   - The `pre_reset` and `post_reset` callback invocations in `amdgpu_sdma_reset_engine` are removed.
   - Instead, the ring's `stop_queue` and `start_queue` functions are called directly during the reset process.

2. **Prepare for Deprecation of Dynamic Mechanism**:
   - By removing the callback invocations, this patch prepares the codebase for the eventual removal of the dynamic callback registration mechanism.

v2: Update stop_queue/start_queue function paramters to use ring pointer instead of device/instance(Christian)
v3: The general coding style is to declare variables like "i" or "r" last. E.g. longest lines first and short lasts. (Chritian)
v4: move stop_queue/start_queue to struct amdgpu_sdma_instance and rename them. (Alex)

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c | 54 ++++++------------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h |  7 ++-
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 22 ++++++----
 3 files changed, 34 insertions(+), 49 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
index 0a9893fee828..541b349e0310 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
@@ -558,20 +558,14 @@ void amdgpu_sdma_register_on_reset_callbacks(struct amdgpu_device *adev, struct
  * @adev: Pointer to the AMDGPU device
  * @instance_id: ID of the SDMA engine instance to reset
  *
- * This function performs the following steps:
- * 1. Calls all registered pre_reset callbacks to allow KFD and AMDGPU to save their state.
- * 2. Resets the specified SDMA engine instance.
- * 3. Calls all registered post_reset callbacks to allow KFD and AMDGPU to restore their state.
- *
  * Returns: 0 on success, or a negative error code on failure.
  */
 int amdgpu_sdma_reset_engine(struct amdgpu_device *adev, uint32_t instance_id)
 {
-	struct sdma_on_reset_funcs *funcs;
 	int ret = 0;
 	struct amdgpu_sdma_instance *sdma_instance = &adev->sdma.instance[instance_id];
-	struct amdgpu_ring *gfx_ring = &sdma_instance->ring;
-	struct amdgpu_ring *page_ring = &sdma_instance->page;
+	struct amdgpu_ring *sdma_gfx_ring = &sdma_instance->ring;
+	struct amdgpu_ring *sdma_page_ring = &sdma_instance->page;
 	bool gfx_sched_stopped = false, page_sched_stopped = false;
 
 	mutex_lock(&sdma_instance->engine_reset_mutex);
@@ -579,28 +573,18 @@ int amdgpu_sdma_reset_engine(struct amdgpu_device *adev, uint32_t instance_id)
 	* This ensures that no new tasks are submitted to the queues while
 	* the reset is in progress.
 	*/
-	if (!amdgpu_ring_sched_ready(gfx_ring)) {
-		drm_sched_wqueue_stop(&gfx_ring->sched);
+	if (!amdgpu_ring_sched_ready(sdma_gfx_ring)) {
+		drm_sched_wqueue_stop(&sdma_gfx_ring->sched);
 		gfx_sched_stopped = true;
 	}
 
-	if (adev->sdma.has_page_queue && !amdgpu_ring_sched_ready(page_ring)) {
-		drm_sched_wqueue_stop(&page_ring->sched);
+	if (adev->sdma.has_page_queue && !amdgpu_ring_sched_ready(sdma_page_ring)) {
+		drm_sched_wqueue_stop(&sdma_page_ring->sched);
 		page_sched_stopped = true;
 	}
 
-	/* Invoke all registered pre_reset callbacks */
-	list_for_each_entry(funcs, &adev->sdma.reset_callback_list, list) {
-		if (funcs->pre_reset) {
-			ret = funcs->pre_reset(adev, instance_id);
-			if (ret) {
-				dev_err(adev->dev,
-				"beforeReset callback failed for instance %u: %d\n",
-					instance_id, ret);
-				goto exit;
-			}
-		}
-	}
+	if (sdma_instance->funcs->stop_kernel_queue)
+		sdma_instance->funcs->stop_kernel_queue(sdma_gfx_ring);
 
 	/* Perform the SDMA reset for the specified instance */
 	ret = amdgpu_dpm_reset_sdma(adev, 1 << instance_id);
@@ -609,18 +593,8 @@ int amdgpu_sdma_reset_engine(struct amdgpu_device *adev, uint32_t instance_id)
 		goto exit;
 	}
 
-	/* Invoke all registered post_reset callbacks */
-	list_for_each_entry(funcs, &adev->sdma.reset_callback_list, list) {
-		if (funcs->post_reset) {
-			ret = funcs->post_reset(adev, instance_id);
-			if (ret) {
-				dev_err(adev->dev,
-				"afterReset callback failed for instance %u: %d\n",
-					instance_id, ret);
-				goto exit;
-			}
-		}
-	}
+	if (sdma_instance->funcs->start_kernel_queue)
+		sdma_instance->funcs->start_kernel_queue(sdma_gfx_ring);
 
 exit:
 	/* Restart the scheduler's work queue for the GFX and page rings
@@ -628,11 +602,11 @@ int amdgpu_sdma_reset_engine(struct amdgpu_device *adev, uint32_t instance_id)
 	 * to be submitted to the queues after the reset is complete.
 	 */
 	if (!ret) {
-		if (gfx_sched_stopped && amdgpu_ring_sched_ready(gfx_ring)) {
-			drm_sched_wqueue_start(&gfx_ring->sched);
+		if (gfx_sched_stopped && amdgpu_ring_sched_ready(sdma_gfx_ring)) {
+			drm_sched_wqueue_start(&sdma_gfx_ring->sched);
 		}
-		if (page_sched_stopped && amdgpu_ring_sched_ready(page_ring)) {
-			drm_sched_wqueue_start(&page_ring->sched);
+		if (page_sched_stopped && amdgpu_ring_sched_ready(sdma_page_ring)) {
+			drm_sched_wqueue_start(&sdma_page_ring->sched);
 		}
 	}
 	mutex_unlock(&sdma_instance->engine_reset_mutex);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
index 47d56fd0589f..620fd7663526 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
@@ -50,6 +50,11 @@ enum amdgpu_sdma_irq {
 
 #define NUM_SDMA(x) hweight32(x)
 
+struct amdgpu_sdma_funcs {
+	int (*stop_kernel_queue)(struct amdgpu_ring *ring);
+	int (*start_kernel_queue)(struct amdgpu_ring *ring);
+};
+
 struct amdgpu_sdma_instance {
 	/* SDMA firmware */
 	const struct firmware	*fw;
@@ -68,7 +73,7 @@ struct amdgpu_sdma_instance {
 	/* track guilty state of GFX and PAGE queues */
 	bool			gfx_guilty;
 	bool			page_guilty;
-
+	const struct amdgpu_sdma_funcs   *funcs;
 };
 
 enum amdgpu_sdma_ras_memory_id {
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
index 688a720bbbbd..c663c63485f4 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -108,6 +108,8 @@ static void sdma_v4_4_2_set_irq_funcs(struct amdgpu_device *adev);
 static void sdma_v4_4_2_set_ras_funcs(struct amdgpu_device *adev);
 static void sdma_v4_4_2_set_engine_reset_funcs(struct amdgpu_device *adev);
 static void sdma_v4_4_2_update_reset_mask(struct amdgpu_device *adev);
+static int sdma_v4_4_2_stop_queue(struct amdgpu_ring *ring);
+static int sdma_v4_4_2_restore_queue(struct amdgpu_ring *ring);
 
 static u32 sdma_v4_4_2_get_reg_offset(struct amdgpu_device *adev,
 		u32 instance, u32 offset)
@@ -1333,6 +1335,11 @@ static bool sdma_v4_4_2_fw_support_paging_queue(struct amdgpu_device *adev)
 	}
 }
 
+static const struct amdgpu_sdma_funcs sdma_v4_4_2_sdma_funcs = {
+	.stop_kernel_queue = &sdma_v4_4_2_stop_queue,
+	.start_kernel_queue = &sdma_v4_4_2_restore_queue,
+};
+
 static int sdma_v4_4_2_early_init(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
@@ -1352,7 +1359,6 @@ static int sdma_v4_4_2_early_init(struct amdgpu_ip_block *ip_block)
 	sdma_v4_4_2_set_irq_funcs(adev);
 	sdma_v4_4_2_set_ras_funcs(adev);
 	sdma_v4_4_2_set_engine_reset_funcs(adev);
-
 	return 0;
 }
 
@@ -1447,6 +1453,7 @@ static int sdma_v4_4_2_sw_init(struct amdgpu_ip_block *ip_block)
 		/* Initialize guilty flags for GFX and PAGE queues */
 		adev->sdma.instance[i].gfx_guilty = false;
 		adev->sdma.instance[i].page_guilty = false;
+		adev->sdma.instance[i].funcs = &sdma_v4_4_2_sdma_funcs;
 
 		ring = &adev->sdma.instance[i].ring;
 		ring->ring_obj = NULL;
@@ -1678,11 +1685,12 @@ static int sdma_v4_4_2_reset_queue(struct amdgpu_ring *ring, unsigned int vmid)
 	return r;
 }
 
-static int sdma_v4_4_2_stop_queue(struct amdgpu_device *adev, uint32_t instance_id)
+static int sdma_v4_4_2_stop_queue(struct amdgpu_ring *ring)
 {
+	struct amdgpu_device *adev = ring->adev;
+	u32 instance_id = GET_INST(SDMA0, ring->me);
 	u32 inst_mask;
 	uint64_t rptr;
-	struct amdgpu_ring *ring = &adev->sdma.instance[instance_id].ring;
 
 	if (amdgpu_sriov_vf(adev))
 		return -EINVAL;
@@ -1715,11 +1723,11 @@ static int sdma_v4_4_2_stop_queue(struct amdgpu_device *adev, uint32_t instance_
 	return 0;
 }
 
-static int sdma_v4_4_2_restore_queue(struct amdgpu_device *adev, uint32_t instance_id)
+static int sdma_v4_4_2_restore_queue(struct amdgpu_ring *ring)
 {
-	int i;
+	struct amdgpu_device *adev = ring->adev;
 	u32 inst_mask;
-	struct amdgpu_ring *ring = &adev->sdma.instance[instance_id].ring;
+	int i;
 
 	inst_mask = 1 << ring->me;
 	udelay(50);
@@ -1740,8 +1748,6 @@ static int sdma_v4_4_2_restore_queue(struct amdgpu_device *adev, uint32_t instan
 }
 
 static struct sdma_on_reset_funcs sdma_v4_4_2_engine_reset_funcs = {
-	.pre_reset = sdma_v4_4_2_stop_queue,
-	.post_reset = sdma_v4_4_2_restore_queue,
 };
 
 static void sdma_v4_4_2_set_engine_reset_funcs(struct amdgpu_device *adev)
-- 
2.25.1

