Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8684EC83013
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Jun 2025 21:07:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F25A010E821;
	Wed, 25 Jun 2025 21:07:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4W/2PQCM";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2043.outbound.protection.outlook.com [40.107.237.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 04C4510E80D
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Jun 2025 21:07:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=INT+NP0JIbKQ9C5AYeHzKn9hhrHdOSWEcVr/v4rBH8S0oT3Xw3HuQdBEsjbA7WJoYbPFiHhzrm3SbCsaNwp4AXIMucJYAtBvlID3BLck/mtoDbzloMCirj7ZDzmRnW25ze9w9a9WRTp5EuCo9Ude3XVfhhGWtaoGGSrJUmk7A44X1ru/OBpJrOmSdjrXYMs53lOPoRLPK7zpEN3/JPVR/RLvAO1zS6hxDmBJv9Axw3leH7hDuVeHZHXd6d4p3y4J7XIj7/57XTUfbrMs8ToWg27YEzh6UXBIPNQ8/TAghsjhY4lEZk8dtlPxQmvxdwPvPFH3Y9LTHqxl4vx/ncrvew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pqklPXV9ZwwFOEi8iGogzjUC6dcnIRffEL7tLVPHshU=;
 b=pYNK6SSZhZghQ8TrTj1oTbCwBGBaNmMcJbTrovqNYkL0tyx4+AYEppG/T+Q1PX81YMQt6tx3TTa2HTz0cHtX0jRUcSj4v0nKn5yzG3fyk+E0hC80K7F+77n/r5YLUZBzt9MRuYePMgRTLCjxUEu1Ek+FP8jcZPokivMWb+Jz5iDryCBH/NKLytiCmuIZ1GZ38pEUyClcKCy2+t9Fjo0NOp5AeCINycCPd6jrRmHdeKCm6P7o7c/u9mX1a2IUAnRTXfasHH/pZmLbhSMx+rsaBJO8C+CSR8DUJEHN+DMQQOklGt2IoLY0Cg2pbXI6kGpdZaEZ9aMO/UrHSWvH1CpL1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pqklPXV9ZwwFOEi8iGogzjUC6dcnIRffEL7tLVPHshU=;
 b=4W/2PQCMqbhYlTHfyCORZlpJSlm/DDaQZ1m0sCpV14pNMS7Z5Xl6ZKAHskyBvxoBcJWPKQQJiG7B3BBhIgRl6viBJD3HpqTUnxe0Tk3f412a3kXKCrpQ2Rr3AzhVF0t73/2xH4jDC2DkGsLVbipRpXNbYLGHbHvmWAFO3ToUhKU=
Received: from BYAPR02CA0070.namprd02.prod.outlook.com (2603:10b6:a03:54::47)
 by SN7PR12MB6958.namprd12.prod.outlook.com (2603:10b6:806:262::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.19; Wed, 25 Jun
 2025 21:07:12 +0000
Received: from MWH0EPF000989E9.namprd02.prod.outlook.com
 (2603:10b6:a03:54:cafe::1e) by BYAPR02CA0070.outlook.office365.com
 (2603:10b6:a03:54::47) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.16 via Frontend Transport; Wed,
 25 Jun 2025 21:07:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E9.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Wed, 25 Jun 2025 21:07:11 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 25 Jun
 2025 16:07:09 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>, Sathishkumar S
 <sathishkumar.sundararaju@amd.com>
Subject: [PATCH 27/30] drm/amdgpu/vcn: add a helper framework for engine resets
Date: Wed, 25 Jun 2025 17:06:35 -0400
Message-ID: <20250625210638.422479-28-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250625210638.422479-1-alexander.deucher@amd.com>
References: <20250625210638.422479-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E9:EE_|SN7PR12MB6958:EE_
X-MS-Office365-Filtering-Correlation-Id: d80e7f8c-d5c1-44e7-910e-08ddb42c4125
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?waHmn9/Zcbte7GoUXbb8weJc75Iv0kqPKmNnZBME2/l5AFZ4tIl1/bPLkfNq?=
 =?us-ascii?Q?OjPfexUgbIsbFo/6sdLDS6eHkaZXsZN29L8ZY8TXrxQUEhmNJLVF9AFrAHUu?=
 =?us-ascii?Q?2FEHh8VtXn3aA053yjfDuCiG9uoqxUtTR3I3+raS3iEbnEdFIeVtshz/Og+J?=
 =?us-ascii?Q?Mgu9Mt164UwDRS6EbcUsAHBZ93o0DhER0zQwdifvdu9F3ocQNqEZOKlXnK8c?=
 =?us-ascii?Q?WTKNi894m72FiBFYsUbM2AVqqqH1ePYBsdbMiRqh/Ujh6QTK7U0rh0mf06z1?=
 =?us-ascii?Q?WoNXBeCS90ta/B2eZGGWLh6l6F+maNp6sCoVIm+bEDhUHouNEKMOht7JwVCJ?=
 =?us-ascii?Q?nyzTW3WTO8q/yQ+HGl5gURQX6KBqiB1giqILctnBmNEUnRpquFrzyy4zU3BD?=
 =?us-ascii?Q?G+OYvV6hPEf6fCE6g2rFGkJrtjtTLw37DULym/v/gBYZoUmBKgz5QALLmFgl?=
 =?us-ascii?Q?Qfc/kB0BCqurGHDPfeqNFt8dtmOQy9liPC4WkXG+J1M2TYoNgxRBUkeHEq+w?=
 =?us-ascii?Q?BeXQ3btKaMg5tvEVQOtTSYiLblMMIMk9dq7VHFZbvBDdRWbfZCYoye1dt74f?=
 =?us-ascii?Q?OXBxPL7baxmUn7nLhHZRl6ad7dEHM1ejPL22Pnrp+Umqa3u8vHhvkQmVRTbE?=
 =?us-ascii?Q?CqIuMGQFUVedTESKkWWwfdXtWJVUucb/YCFyRYC6SSo/cwojOIut9BQg4rRB?=
 =?us-ascii?Q?RX9WKRJvCMxdkmBcC6E8iIJ4M+tV+SXhCOhrvxrinMCdusQtosSkKyoU4fpM?=
 =?us-ascii?Q?BIz5cOyudAeasAODac5qEecU0FSUioR7x5zwyvc+N3CZRTMzXjRwdhLQwRVT?=
 =?us-ascii?Q?dIKBehu1Wb6wIb+0spt/hCxYORDnTzyQiu/bpEfn7f/PZMsFt03+Vruf0FRB?=
 =?us-ascii?Q?TR7N0n4A9LDvuto0QZBNm0hSFcM/7bDmRqgwFBNPee/wZAFohbrQhNDmFznT?=
 =?us-ascii?Q?9zGN5H/Nvht4B1FVHeQk8JncXABYs49z+nplrwIqp87afcGI1McIsBLJqrUw?=
 =?us-ascii?Q?gIlr+sO7XUVWzfCZvvMauPYQNupD8jWZvYBIHryRX0/ftmTdC8LRIZYP95DM?=
 =?us-ascii?Q?qvStF6aReyo8VwLvBI5bX6SMSF2AWBe9Pw94p3YfXQbzJPJ78sB/wiJ139rh?=
 =?us-ascii?Q?6WkQoGGtWf2Y97QPENvfVssirVEQtbm1RNSGiHZPMIFwe90H4FwoK7u3WCkN?=
 =?us-ascii?Q?9vIvZo8imgDWrjN1F9nSHJYe8RPHswUI6yt2EwIP0KfW+dmzE62Cl+qHQANA?=
 =?us-ascii?Q?8Ss9oqnKY1kH9fjvP4CvLT7xE2RtFVbGyNIxvp4pMZ0uW2UGCEh0pY5EF6Uf?=
 =?us-ascii?Q?Mmw+NIyN2dEVznS9P+WGDz9AsKQcSVeAXz7K/P7JFbiJxqPdGGxHE8sNMhu1?=
 =?us-ascii?Q?HjoR50RgGfp6X8oZvmRIpNGpjCn7DW3bIQLQHINI3Z9+2fihkjAo13nQiOn5?=
 =?us-ascii?Q?AifRvA7z6ZAY1Af1IsxQ3X/fDzY07SvfVjVvTUgeqB1DNrgvtjHlNmd+NmS6?=
 =?us-ascii?Q?iBM7Vmd8uBJ3QgjhbBwV7AKd56GWa6NpleZH?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2025 21:07:11.9668 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d80e7f8c-d5c1-44e7-910e-08ddb42c4125
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6958
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

With engine resets we reset all queues on the engine rather
than just a single queue.  Add a framework to handle this
similar to SDMA.

Reviewed-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
Tested-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 76 +++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |  6 +-
 2 files changed, 81 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index c8885c3d54b33..f1f67521c29ca 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -134,6 +134,7 @@ int amdgpu_vcn_sw_init(struct amdgpu_device *adev, int i)
 
 	mutex_init(&adev->vcn.inst[i].vcn1_jpeg1_workaround);
 	mutex_init(&adev->vcn.inst[i].vcn_pg_lock);
+	mutex_init(&adev->vcn.inst[i].engine_reset_mutex);
 	atomic_set(&adev->vcn.inst[i].total_submission_cnt, 0);
 	INIT_DELAYED_WORK(&adev->vcn.inst[i].idle_work, amdgpu_vcn_idle_work_handler);
 	atomic_set(&adev->vcn.inst[i].dpg_enc_submission_cnt, 0);
@@ -1451,3 +1452,78 @@ int vcn_set_powergating_state(struct amdgpu_ip_block *ip_block,
 
 	return ret;
 }
+
+/**
+ * amdgpu_vcn_reset_engine - Reset a specific VCN engine
+ * @adev: Pointer to the AMDGPU device
+ * @instance_id: VCN engine instance to reset
+ *
+ * Returns: 0 on success, or a negative error code on failure.
+ */
+static int amdgpu_vcn_reset_engine(struct amdgpu_device *adev,
+				   uint32_t instance_id)
+{
+	struct amdgpu_vcn_inst *vinst = &adev->vcn.inst[instance_id];
+	int r, i;
+
+	mutex_lock(&vinst->engine_reset_mutex);
+	/* Stop the scheduler's work queue for the dec and enc rings if they are running.
+	 * This ensures that no new tasks are submitted to the queues while
+	 * the reset is in progress.
+	 */
+	drm_sched_wqueue_stop(&vinst->ring_dec.sched);
+	for (i = 0; i < vinst->num_enc_rings; i++)
+		drm_sched_wqueue_stop(&vinst->ring_enc[i].sched);
+
+	/* Perform the VCN reset for the specified instance */
+	r = vinst->reset(vinst);
+	if (r)
+		goto unlock;
+	r = amdgpu_ring_test_ring(&vinst->ring_dec);
+	if (r)
+		goto unlock;
+	for (i = 0; i < vinst->num_enc_rings; i++) {
+		r = amdgpu_ring_test_ring(&vinst->ring_enc[i]);
+		if (r)
+			goto unlock;
+	}
+	amdgpu_fence_driver_force_completion(&vinst->ring_dec);
+	for (i = 0; i < vinst->num_enc_rings; i++)
+		amdgpu_fence_driver_force_completion(&vinst->ring_enc[i]);
+
+	/* Restart the scheduler's work queue for the dec and enc rings
+	 * if they were stopped by this function. This allows new tasks
+	 * to be submitted to the queues after the reset is complete.
+	 */
+	drm_sched_wqueue_start(&vinst->ring_dec.sched);
+	for (i = 0; i < vinst->num_enc_rings; i++)
+		drm_sched_wqueue_start(&vinst->ring_enc[i].sched);
+
+unlock:
+	mutex_unlock(&vinst->engine_reset_mutex);
+
+	return r;
+}
+
+/**
+ * amdgpu_vcn_ring_reset - Reset a VCN ring
+ * @ring: ring to reset
+ * @vmid: vmid of guilty job
+ * @timedout_fence: fence of timed out job
+ *
+ * This helper is for VCN blocks without unified queues because
+ * resetting the engine resets all queues in that case.  With
+ * unified queues we have one queue per engine.
+ * Returns: 0 on success, or a negative error code on failure.
+ */
+int amdgpu_vcn_ring_reset(struct amdgpu_ring *ring,
+			  unsigned int vmid,
+			  struct amdgpu_fence *timedout_fence)
+{
+	struct amdgpu_device *adev = ring->adev;
+
+	if (adev->vcn.inst[ring->me].using_unified_queue)
+		return -EINVAL;
+
+	return amdgpu_vcn_reset_engine(adev, ring->me);
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
index 83adf81defc71..0bc0a94d7cf0f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
@@ -330,7 +330,9 @@ struct amdgpu_vcn_inst {
 			      struct dpg_pause_state *new_state);
 	int (*set_pg_state)(struct amdgpu_vcn_inst *vinst,
 			    enum amd_powergating_state state);
+	int (*reset)(struct amdgpu_vcn_inst *vinst);
 	bool using_unified_queue;
+	struct mutex		engine_reset_mutex;
 };
 
 struct amdgpu_vcn_ras {
@@ -552,5 +554,7 @@ void amdgpu_debugfs_vcn_sched_mask_init(struct amdgpu_device *adev);
 
 int vcn_set_powergating_state(struct amdgpu_ip_block *ip_block,
 			      enum amd_powergating_state state);
-
+int amdgpu_vcn_ring_reset(struct amdgpu_ring *ring,
+			  unsigned int vmid,
+			  struct amdgpu_fence *guilty_fence);
 #endif
-- 
2.50.0

