Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D01CAC87FCF
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Aug 2025 13:45:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7902310E1E2;
	Wed, 13 Aug 2025 13:45:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="v9hd0LT6";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2044.outbound.protection.outlook.com [40.107.92.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 799D110E1E2
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Aug 2025 13:45:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GEKD8QQVHKn8DXjo0KI242qwEdHReype5tkUqOl1aRwVLBh060fZjgMAmFEM0wUhisAG2uMExjesrmbHheGKxlZgGLVxr1jPHTNzrYBMjZXq9tRhJODIVSTwnMmoyt34J77ex8STzQq+jzFHfoi75pKzdjIvlGoQVeoxgGSDkFl3rVI/q4Cmw8xx11WGJOE9AonMVObIfMS2kfy/8WFDAu7vkelwImFi492FvE53VO8ME6UcUtUSuzt8kQuf7B1YLBer1R9OrTLXnIvuXoC8iE4pqGRrngpxo1IBZXwq+eckJeNM4jAsKbKW2UvmNEnl1MvdxIqrQVE5s3vRlcL7XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Djx+uA6uE7aBeSpOjWDewpiWZlvc3reRnx9y4E0m1o=;
 b=PkVndyVf6K/7PNIS0JmpBfiBCNUhjkAoWImPvqDlh/4ch8rD+r2j+Sts8opgekjSZaQg8VN0dzleWfBE2HUU+0sv+Ai5ilA3HERWds6Ke/sk2NjjMprCaus/oW5qOr4DDLPuq6FHmZ+e4SevQkpnEdBnip53VlQZ5DXVMpoLBcAf1dpQeFeTP9aSbtcis713OS+EBS0D1uL3xLfTP7duWEvK6N13wPdjY7Cl6Vl8ITSVeZblL+6obQkj4PnjIRdjyiOq8Tp9E6zy3xutjhJphKwqIVwMDiw+ODcf1hQ/xJXpg3YltHewmIZ0ITAAM9/x1Y4vZlybyYDlleGnVX5KWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Djx+uA6uE7aBeSpOjWDewpiWZlvc3reRnx9y4E0m1o=;
 b=v9hd0LT6u8VLZqDkBdE8GGxVcH8a4HM9CAR59pysqDdh3eVn2fX0EExcwCLVU5DlJKnACXrbGtTgEtxGUgX98Cq3wS86jf4gLmsZhBOCs8cNkNfNjscNvOm1aO6HC5hvQ6okM1JjWg6rc9o0lnKSd6jA8csOpDW1NlUqWpNqvzI=
Received: from SN7P222CA0017.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:124::15)
 by BN7PPF683A477A9.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::6d3) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.16; Wed, 13 Aug
 2025 13:45:33 +0000
Received: from SN1PEPF0002BA4B.namprd03.prod.outlook.com
 (2603:10b6:806:124:cafe::e) by SN7P222CA0017.outlook.office365.com
 (2603:10b6:806:124::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.16 via Frontend Transport; Wed,
 13 Aug 2025 13:45:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002BA4B.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Wed, 13 Aug 2025 13:45:32 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 13 Aug
 2025 08:45:31 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Sathishkumar S
 <sathishkumar.sundararaju@amd.com>
Subject: [PATCH] drm/amdgpu/vcn: fix video profile race condition (v3)
Date: Wed, 13 Aug 2025 09:45:04 -0400
Message-ID: <20250813134504.2037516-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4B:EE_|BN7PPF683A477A9:EE_
X-MS-Office365-Filtering-Correlation-Id: dad198fd-5835-42bd-7ef2-08ddda6faca8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?F0HlbwlXzzwLaWMq6XZTLiKIbox2WELJ1qPALTtmT4yTMTYaXSyqzVRzLZ54?=
 =?us-ascii?Q?Pi45y50TJIYu2otbHcU7LZyGNvngLoSSpWmnzoJYuQeMeEqX2AGvClbsZkLM?=
 =?us-ascii?Q?br+VLQNq3QQckR/fU4eyW/eXMz89t18CxTCDqjWlr3enR6oD/N/Dwx/BdPTf?=
 =?us-ascii?Q?1ke3RD7Fh01nypogISbsW0UB5kXrVDwIVizQ4LS/UT502u1yVbPf4lvCTpcN?=
 =?us-ascii?Q?qIltUNmYt3WZuJ/1RU/xU/blw3Mxs+k/1rGxrZmgJI6OLcrh53hmfvuq6bFt?=
 =?us-ascii?Q?pmmnm8mG72MY66ujeJwGuux39hv7kcrmTmflJpoQzhpORKDEEyHAem4C8+DV?=
 =?us-ascii?Q?GUu7wPUgwiXyD2L5vjJZ5GEQ8+3kTS1wylE3gv326VxAG60nBAFjf+Xxz8OF?=
 =?us-ascii?Q?DfpCp7POtRF8BUdKb2wwJIaLwQItONmJFLYlx5bZ6XwxemhGDU6Zer1giYtc?=
 =?us-ascii?Q?n1dDO7A9JNCcI3rFyrOxk/PHWP/oPdRYd+dSx7Kz50zOs3OuzHvksdzMQL9t?=
 =?us-ascii?Q?SusE+3qRL+7CpV0hhJaceWzpYgGDQ9sXJ0pfpPN1u0pu3IrKmRSmo7azcj2R?=
 =?us-ascii?Q?bzkkC/dJRQY2ifx0FzPxYkefUwxWLXbDC2P/yfrKXG6BbM8n+HlLRIHvS85E?=
 =?us-ascii?Q?wQyh9aBP8OQ4c/WKL73Snvs0YJpN8KVeDJhqSVeG4FnEbqbbZzoXhnCj1utI?=
 =?us-ascii?Q?k9xorTh3By3BCf1QrgRDfYas0a5SPCDIl4PKhIML8r2kF353DWuBuC+JOW4w?=
 =?us-ascii?Q?/8wriRhUfcZsns1Bpu6tWiAjxcoy5VqcN2kNiCJQr8DDheerb4GNK5u8HAQi?=
 =?us-ascii?Q?o7/f7EWAPHc4zDsOGEEZTfr6vYV7oBMPer+kHIDAAKdiCXLas0r4yd9xxv8V?=
 =?us-ascii?Q?s54uBbuwn56urI6Xmd9pLOKfUJCtDT+Y2gctMqUEvvwJrvETQPZNUErFDU5g?=
 =?us-ascii?Q?P12fd7SpZJua2J4NpMstuUN2UDJVK1lpmJnNUa3qNt7qinGqwlLFe04pzL4x?=
 =?us-ascii?Q?P2/Mp0r6g5YhsvT8jR5h5qyiZJcpa0+pxPULLou6v4RqwrnDsex3lTis/Lor?=
 =?us-ascii?Q?/fPgwpyWr9mKS8R3Iuuj0DRzqMXFK5b/vDm31BU6hHhcEyPjT42rXZyvinKz?=
 =?us-ascii?Q?1pHwMnaV/kBKv2PFd8aA1OSWqAk8qc+UZTxeHZT6uhAJ1C2wC3aaXd1UkluE?=
 =?us-ascii?Q?RrEfLE80aLDg+h4OUj3ls2thcZ2X/fAKH3wCbbK+ga5R/uvlqYlH8E2pk4Ti?=
 =?us-ascii?Q?g1QKXljrndHsnS4QnrK0eHkUy3iUznDgt8GiVfLVIzeeUnsr+04Zh3ZjC4gy?=
 =?us-ascii?Q?XFASKp/TmlaLchXxhpMxqR6X0rZfxBlj647InPuC9rVz20P2f3VuMGlxmL2d?=
 =?us-ascii?Q?1R6Ww8LAqkBSz6sskbLp4TRjupHfXSKgTo3LIrIQ0X1ePP9EvhwgM0mVIdFE?=
 =?us-ascii?Q?lBjzbRyFNogeGBATTwM/T6HS4j5JtDrU/34bze+7flHGc6jIhckOjjfdxKdS?=
 =?us-ascii?Q?X/rZX+bDUNuxh7idOFf8ncSfrHvX9NOhtYEl?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 13:45:32.8696 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dad198fd-5835-42bd-7ef2-08ddda6faca8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA4B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF683A477A9
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

If there are multiple instances of the VCN running,
we may end up switching the video profile while another
instance is active because we only take into account
the current instance's submissions.  Look at all
outstanding fences for the video profile.

v2: drop early exit in begin_use()
v3: handle possible race between begin_use() work handler

Fixes: 3b669df92c85 ("drm/amdgpu/vcn: adjust workload profile handling")
Reviewed-by: Sathishkumar S <sathishkumar.sundararaju@amd.com> (v1)
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 40 ++++++++++++-------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |  1 +
 2 files changed, 21 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index 9a76e11d1c184..593c1ddf8819b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -415,19 +415,25 @@ static void amdgpu_vcn_idle_work_handler(struct work_struct *work)
 	struct amdgpu_vcn_inst *vcn_inst =
 		container_of(work, struct amdgpu_vcn_inst, idle_work.work);
 	struct amdgpu_device *adev = vcn_inst->adev;
-	unsigned int fences = 0, fence[AMDGPU_MAX_VCN_INSTANCES] = {0};
-	unsigned int i = vcn_inst->inst, j;
+	unsigned int total_fences = 0, fence[AMDGPU_MAX_VCN_INSTANCES] = {0};
+	unsigned int i, j;
 	int r = 0;
 
-	if (adev->vcn.harvest_config & (1 << i))
+	if (adev->vcn.harvest_config & (1 << vcn_inst->inst))
 		return;
 
-	for (j = 0; j < adev->vcn.inst[i].num_enc_rings; ++j)
-		fence[i] += amdgpu_fence_count_emitted(&vcn_inst->ring_enc[j]);
+	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
+		struct amdgpu_vcn_inst *v = &adev->vcn.inst[i];
+
+		for (j = 0; j < v->num_enc_rings; ++j)
+			fence[i] += amdgpu_fence_count_emitted(&v->ring_enc[j]);
+		fence[i] += amdgpu_fence_count_emitted(&v->ring_dec);
+		total_fences += fence[i];
+	}
 
 	/* Only set DPG pause for VCN3 or below, VCN4 and above will be handled by FW */
 	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG &&
-	    !adev->vcn.inst[i].using_unified_queue) {
+	    !vcn_inst->using_unified_queue) {
 		struct dpg_pause_state new_state;
 
 		if (fence[i] ||
@@ -436,18 +442,18 @@ static void amdgpu_vcn_idle_work_handler(struct work_struct *work)
 		else
 			new_state.fw_based = VCN_DPG_STATE__UNPAUSE;
 
-		adev->vcn.inst[i].pause_dpg_mode(vcn_inst, &new_state);
+		vcn_inst->pause_dpg_mode(vcn_inst, &new_state);
 	}
 
-	fence[i] += amdgpu_fence_count_emitted(&vcn_inst->ring_dec);
-	fences += fence[i];
-
-	if (!fences && !atomic_read(&vcn_inst->total_submission_cnt)) {
+	if (!fence[vcn_inst->inst] && !atomic_read(&vcn_inst->total_submission_cnt)) {
+		/* This is specific to this instance */
 		mutex_lock(&vcn_inst->vcn_pg_lock);
 		vcn_inst->set_pg_state(vcn_inst, AMD_PG_STATE_GATE);
 		mutex_unlock(&vcn_inst->vcn_pg_lock);
 		mutex_lock(&adev->vcn.workload_profile_mutex);
-		if (adev->vcn.workload_profile_active) {
+		/* This is global and depends on all VCN instances */
+		if (adev->vcn.workload_profile_active && !total_fences &&
+		    !atomic_read(&adev->vcn.total_submission_cnt)) {
 			r = amdgpu_dpm_switch_power_profile(adev, PP_SMC_POWER_PROFILE_VIDEO,
 							    false);
 			if (r)
@@ -467,16 +473,10 @@ void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring)
 	int r = 0;
 
 	atomic_inc(&vcn_inst->total_submission_cnt);
+	atomic_inc(&adev->vcn.total_submission_cnt);
 
 	cancel_delayed_work_sync(&vcn_inst->idle_work);
 
-	/* We can safely return early here because we've cancelled the
-	 * the delayed work so there is no one else to set it to false
-	 * and we don't care if someone else sets it to true.
-	 */
-	if (adev->vcn.workload_profile_active)
-		goto pg_lock;
-
 	mutex_lock(&adev->vcn.workload_profile_mutex);
 	if (!adev->vcn.workload_profile_active) {
 		r = amdgpu_dpm_switch_power_profile(adev, PP_SMC_POWER_PROFILE_VIDEO,
@@ -487,7 +487,6 @@ void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring)
 	}
 	mutex_unlock(&adev->vcn.workload_profile_mutex);
 
-pg_lock:
 	mutex_lock(&vcn_inst->vcn_pg_lock);
 	vcn_inst->set_pg_state(vcn_inst, AMD_PG_STATE_UNGATE);
 
@@ -528,6 +527,7 @@ void amdgpu_vcn_ring_end_use(struct amdgpu_ring *ring)
 		atomic_dec(&ring->adev->vcn.inst[ring->me].dpg_enc_submission_cnt);
 
 	atomic_dec(&ring->adev->vcn.inst[ring->me].total_submission_cnt);
+	atomic_dec(&ring->adev->vcn.total_submission_cnt);
 
 	schedule_delayed_work(&ring->adev->vcn.inst[ring->me].idle_work,
 			      VCN_IDLE_TIMEOUT);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
index b3fb1d0e43fc9..febc3ce8641ff 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
@@ -352,6 +352,7 @@ struct amdgpu_vcn {
 
 	uint16_t inst_mask;
 	uint8_t	num_inst_per_aid;
+	atomic_t		total_submission_cnt;
 
 	/* IP reg dump */
 	uint32_t		*ip_dump;
-- 
2.50.1

