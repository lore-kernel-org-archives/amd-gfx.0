Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFEB2C83F1B
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Jul 2025 22:41:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6551610EB00;
	Fri, 11 Jul 2025 22:41:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="I75Gsty+";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2066.outbound.protection.outlook.com [40.107.237.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5371F10EAE5
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Jul 2025 22:41:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y3nJBSbegFfJKgcn2QqMV+Pm8BPvvGkN8xlmE011YO2+SAzAcT5ONzbmJDEvnRNQMYJIBSJRodt4YKVitvgEJpeDqTzuWqWpNvM6IKjLUCQwmbt6/dwRDvJDlctN3c0fTxwud93Y4/D640btOGL8w9YAVnfF+0jH7uxmLAFxOP+f8yyFSPAtBOnaxS2C/yvo9/KhMHUSmKULNA8fsJ9vjmZjM+jpPboiJy5a0ZBdPLuCL3nRbe5KAn+08+V6PjFiC3hpXAAOC+YuVUY8Di7MbXko2zk9q9Tt3UvIAVHHbFoEy7UtAtL1Np3JiaxpXSl0U7Hi1GmjtwbvKeaLS+EvLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FjUXB+Fx6IHGk6Zsbhzlsf+hcBJkbTrg5P3e4hhIpHI=;
 b=uWyvucSkTrRoB3q4ANzXWmHiLpV9xqtP2nZmqJWagER7ilwbrFb/BNc7o1xEozEjqQINVeYMReDP7mjEjoGz3sSLCj+hqHLh8g3yy4drNj42/RkY2PRKW5QZlOURZQP8OeJI59RdQ/yAtt496Ht4mbrfN5vKolor9KppXfRxXkR388G9P/v/TlUUiymR3MiUdod8cSiv6T6CzUqJbJxAwonZr48lyYwhXXwaM2PswfFaBA18s25x5iRY+883kBEP+Yd1Lrl8U9ipob5IPfwI4ygvtmhgRjy5o1XIWNV1MZuyhKKNyvqd2sSCOvVndakXpRrBZL9XVjFDd2Cau4MIzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FjUXB+Fx6IHGk6Zsbhzlsf+hcBJkbTrg5P3e4hhIpHI=;
 b=I75Gsty+P41HXb4ntEbZ+SFxV2hMKTAw8T2luV8ft9sZD4eEmPGQcEaPwcFME30sFEBUG+wijqe9AqUvngy+dIaMjOJpupRGGdnuUBgtXm0huHRKxsvddrvHeBsVQEqdKt+cthk6avTOH3YFQ9IeKxzhRVJwCDSDBHC5bU6SsmY=
Received: from BYAPR01CA0062.prod.exchangelabs.com (2603:10b6:a03:94::39) by
 DM6PR12MB4171.namprd12.prod.outlook.com (2603:10b6:5:21f::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.28; Fri, 11 Jul 2025 22:40:58 +0000
Received: from CY4PEPF0000E9D5.namprd05.prod.outlook.com
 (2603:10b6:a03:94:cafe::3) by BYAPR01CA0062.outlook.office365.com
 (2603:10b6:a03:94::39) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.25 via Frontend Transport; Fri,
 11 Jul 2025 22:40:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D5.mail.protection.outlook.com (10.167.241.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Fri, 11 Jul 2025 22:40:58 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 11 Jul
 2025 17:40:56 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>, Sathishkumar S
 <sathishkumar.sundararaju@amd.com>
Subject: [PATCH 30/33] drm/amdgpu/vcn: add a helper framework for engine resets
Date: Fri, 11 Jul 2025 18:40:21 -0400
Message-ID: <20250711224024.410506-31-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250711224024.410506-1-alexander.deucher@amd.com>
References: <20250711224024.410506-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D5:EE_|DM6PR12MB4171:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e137d13-53f1-4b82-3ca5-08ddc0cc0171
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?hq3n8plCwQjS+5q2+2A/sqqnoLj9xut6/f0kEBa9npwE4MFbvy4VSwo4vITi?=
 =?us-ascii?Q?LWLBqJg/GCI31Zf/ochphu8Qz2UqaPHkJuXkNYRhRaGJhDv79riDj9cM2Vb6?=
 =?us-ascii?Q?B7IG+blF25gXCRYMThAYBkx9Gekvi4IOds/xxXbRTwCNfFfN4UYJkD7BJLVH?=
 =?us-ascii?Q?Y4Jp78XG0Se/bsk3lHQvrOKNHjpVImrXtIe0l4gBcLoRbK/IdTA5pSf/9fxN?=
 =?us-ascii?Q?f2KEIbi5449WRsu9Qih9Y+9M6m/gX615RPTIxKA9/PYh4zSK4MbDiXAFqiOh?=
 =?us-ascii?Q?CgQt3t3pPC/6EH8jBVvPvzOjLtF/VGtg4e5IuopH95h8QptuYFpVfVzYKZ/k?=
 =?us-ascii?Q?BRLbPTw67zV+9CS8iizXdQhJe+H9Y9ald1jLXdb2JE1Jk+O40UdmdKp8Rzww?=
 =?us-ascii?Q?UMbcpf2aLnYDixBwupWI7sL92wlX3SWpseBUooh4NsMRe5PXt3azu+sTzaMz?=
 =?us-ascii?Q?9rlommnG7eYP4Ski5gBZYz2BtVYzUd3vVorA153N3J6tnw4glkv3AaZod/Uu?=
 =?us-ascii?Q?zAqPtDm0I/Oa33nuBFkNmX5Aew2GGpkgI+j8ab5bDO//avJ6MEQ1WIiMSBDA?=
 =?us-ascii?Q?8Ummhs2B4lkIT5MJHp77J/0rL+hQ7jWnauySdbzfkx2yU0mpWCQ4IB7/zasa?=
 =?us-ascii?Q?DGEUjWCgUNHBGhgU1fZObam4gLWyFmWeaDk97LLr9riHfWrn2A8czaQca55u?=
 =?us-ascii?Q?1BZ/IZqr/xUg+YojUnY0olrIrt0FL2KGh0JgyI/LOSi3BrrsTSp84JEZLajd?=
 =?us-ascii?Q?2zq3JnMkvO1SEaZ1uM71qESt9gnbfW8raKGTYrrxO/wo6sny7ngEVNnbxDhn?=
 =?us-ascii?Q?EjiKI+1kB5/EwHP92XUmb7IZQRU5ZHKaPffG+Me6qdc08aVFSSniwuBZ+lpv?=
 =?us-ascii?Q?wy8JWLYbQi43WwLZWp5m6GNCUuJwdOH9flOY40rcURh+3bT20btkA5PtTAEz?=
 =?us-ascii?Q?NdUd+sAo1RGSQypJx6c3FamJXFwrgKtY2WqYLISOwyym76r8/SNvZcdDoh/r?=
 =?us-ascii?Q?34QkVMI9lLfIBH0iSlWaeJogsX0Wh42D83sLeA1hyBtsIhBMZ9wWcEqBh922?=
 =?us-ascii?Q?jCkaQIw3qRklFG3i37nS+hARSvdet1V42PSD7rwZxSyZLtqBVmiQBBNSiHbp?=
 =?us-ascii?Q?G63Be9BhjCGkUD+GnOeTKpxwTb/0rbqEFUInQ9I4ZwZprHNhAEXDpLJ51Bub?=
 =?us-ascii?Q?+ShDGRee+t/XsKDET9YerARGk8K0cGlPljtDXGuKtVjqkVBTh/ck635tORaq?=
 =?us-ascii?Q?lGHyTbJgf6lykl8pQ1gq/22hVTZwDgsUcMv7C9WvmIRPHv2VSD3XA5yMBJtF?=
 =?us-ascii?Q?Lou00nkzPhcN3baldUmEGjvbL7NBTQB355Sn1GBxgenNyD45AR+eHIitCxdo?=
 =?us-ascii?Q?ZBeccibZglRIOwJMZjhByb7Z0tF6Bq4aYQI5lBP+rAqnVx0sQE9n8al4gWcp?=
 =?us-ascii?Q?6/CcUIhQ7E9cdUcaNH0o4MME9q5AtO6H4KaYiTADTY8J91G0Liz4Srjs4LmT?=
 =?us-ascii?Q?ush+VK3bY8zEeQNOk5LiFN06xw6AurCwYXfq?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 22:40:58.5671 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e137d13-53f1-4b82-3ca5-08ddc0cc0171
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4171
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 79 +++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |  6 +-
 2 files changed, 84 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index c8885c3d54b33..d799bc74936c0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -134,6 +134,7 @@ int amdgpu_vcn_sw_init(struct amdgpu_device *adev, int i)
 
 	mutex_init(&adev->vcn.inst[i].vcn1_jpeg1_workaround);
 	mutex_init(&adev->vcn.inst[i].vcn_pg_lock);
+	mutex_init(&adev->vcn.inst[i].engine_reset_mutex);
 	atomic_set(&adev->vcn.inst[i].total_submission_cnt, 0);
 	INIT_DELAYED_WORK(&adev->vcn.inst[i].idle_work, amdgpu_vcn_idle_work_handler);
 	atomic_set(&adev->vcn.inst[i].dpg_enc_submission_cnt, 0);
@@ -1451,3 +1452,81 @@ int vcn_set_powergating_state(struct amdgpu_ip_block *ip_block,
 
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
+	if (!(adev->vcn.supported_reset & AMDGPU_RESET_TYPE_PER_QUEUE))
+		return -EOPNOTSUPP;
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

