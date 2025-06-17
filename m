Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BEF5C7115E
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Jun 2025 03:09:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 73D0110E4AA;
	Tue, 17 Jun 2025 03:09:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="C8qOpBd6";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2081.outbound.protection.outlook.com [40.107.244.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A65110E49B
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Jun 2025 03:08:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tD8GEis3gujNZl4LbNPo667Fv8+aZvo4H88OKKA9+2e88kDxonOKRRKSgWhiusUpJ7r2K7xS31mcLWBIE6UiEyE4GJZ250PK+3RtIb2QD15G2hiUCj2ojX2xT3fmGhEUZpnUOiW0yz2EQCA+ysEEApzfiB7BvTvvLuHsF4B02t+ItUwYEnSAW8bAmxA1ZH/KLpEh7WWFapcwY1NzzYlkOqINQwNq9cj9vkTeO+wZQHHF/Mw8iUYCS+rhwq95bhzff1222MNDqvE1/BnCZNdyYCrDPNCivphvMHh6gH1IalKUqGJLi1z4NE9MFEIqKuSgbnTbTZobfdVIDFcnHu6Apg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZfO2S0wMnId/Z08F1vVBFGhpEc7Su4C4moKXUAA9S0E=;
 b=rixd6F7m1yhy7K2JouSo/uQuDEdQfm7vv3YUBvRdANlVSsS8m6DyPBjJx9PF+lQkGjg5juhe5nDqGGukJxcMBo9RDINc5nnJG9LJv0meTmWXWPmu9fhda2vPvGjdifL2sWsuBVKYCv/Tja/vRm1L3ZrH/RRcNmAAtUjsUXbxmRZ7p3L6YvkTX+25mBzPPQEkQnIbgdstvwjyzFSSZvcLAP8dLIS0QCSwz4atDXRVejbf2MAvbBsy9yYRhhbUKqJ6vaA3swQs0fbPceZKZ240aUzLVOEeewETGu04uoo2z39ltJDBpMFRCMZJspkTRQ9zbVL0PodnYcwCWDDxaymVJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZfO2S0wMnId/Z08F1vVBFGhpEc7Su4C4moKXUAA9S0E=;
 b=C8qOpBd6P0cWu/3I1RFXpiM78Te2C7OdiTifwBxQ0gyhIfZmnWrTMzvWktnUf6vsQnhlMqpnhDcP6nJR0qC5k68bcDOIRNUQcXsi+5UjngXC6GK0BnlFW/lYZ9VWa0TB05vRTJ9toXpkXrI3XLY/eP2xIiN/W+GrYOF09/OFLoI=
Received: from MW4PR03CA0175.namprd03.prod.outlook.com (2603:10b6:303:8d::30)
 by SJ0PR12MB5663.namprd12.prod.outlook.com (2603:10b6:a03:42a::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.28; Tue, 17 Jun
 2025 03:08:54 +0000
Received: from SJ1PEPF00002327.namprd03.prod.outlook.com
 (2603:10b6:303:8d:cafe::a1) by MW4PR03CA0175.outlook.office365.com
 (2603:10b6:303:8d::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.27 via Frontend Transport; Tue,
 17 Jun 2025 03:08:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002327.mail.protection.outlook.com (10.167.242.90) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8835.15 via Frontend Transport; Tue, 17 Jun 2025 03:08:54 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 16 Jun
 2025 22:08:50 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 33/36] drm/amdgpu/vcn: add a helper framework for engine resets
Date: Mon, 16 Jun 2025 23:08:12 -0400
Message-ID: <20250617030815.5785-34-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250617030815.5785-1-alexander.deucher@amd.com>
References: <20250617030815.5785-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002327:EE_|SJ0PR12MB5663:EE_
X-MS-Office365-Filtering-Correlation-Id: 8db629a2-3d6f-4860-c5fa-08ddad4c4b0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?lV8JVmOyyhn3BQe2lZSdx/Y+WQXYJMu6Oq1sdEw8Atp+4vizB2wlOI6pK7tc?=
 =?us-ascii?Q?lDBDhUk//jw2m0Q8e4na0g8iWssCZSDQ9GCsnAV7o3oReV7RJMrWnLL8zxkm?=
 =?us-ascii?Q?/5PAnT9mpemkAXSoK2cbQNuvAPRfLo1wfn6qdzrRe/R0ow0oQ5n+3JvW1jLB?=
 =?us-ascii?Q?qHMopSF1zIAzG+dsLm3sq5mX8nH99zr0BeP0tpwxHx9KkC4WJXdmIfmXhV5Z?=
 =?us-ascii?Q?6Gu6SxSsoqBmzbWCQ9Oc0Wwg/c3WYXY+YCc0rUVbryG8WYU/lkfs8TRsPdnQ?=
 =?us-ascii?Q?7AlPIFNzK6zKwLGaZzbqmjmqieufca5Q9djrDlCWRBJBe7pgK4cXgPLJsD3j?=
 =?us-ascii?Q?go5YG2wayc5K1muOgsBPZGT1zwBAcuXqoXwCckq+Nf+abjd0YC2wpKbsOVh0?=
 =?us-ascii?Q?64/Iaw9pLZ+qTW5ctx1CBPvbfKMnnFivMD1vRzD3mfGm7vpD7ApHOkiG0rng?=
 =?us-ascii?Q?wgL5gsbzXZTK1FQqxSKnaPf7wD4naGas8qZ2MNjxDL9Z5rGOfhk4u7DQWYVM?=
 =?us-ascii?Q?ly0a8SumW0PqghkC+gqqleIjDrKnRpJvky4zdl04zdKI3byKh9Eqo+MvF5bW?=
 =?us-ascii?Q?sLQA4r91D/rko1yZ6FL2wQayOwRMYe1/CVctZXA3nrOcXw3LZfKQvo5DXTBm?=
 =?us-ascii?Q?7vHvGYkeAmTpn//qPeXHYZ2/XYYsM6UTiNI5oMqIhYgtvIQIUHfGUEpOfEsY?=
 =?us-ascii?Q?Ul2NJNdr9r85+g8KF5n5XQznCMXbivkVhwbra0DlQgtB+qXlkNdWat+LkhfT?=
 =?us-ascii?Q?AbwnaTw6IXFWgQfXbTQRomaieFWPvNOA39dWrCMN2aO/KHAV/S+/xzLtt3XQ?=
 =?us-ascii?Q?Orwz5TgmQZD0A4qU4QsMyticizCnCKzXJc5O79agEDK4pApjcTk1wuyxIu2z?=
 =?us-ascii?Q?HOfukA70Ig8ZB38ePKUWKCgkoA03mdhCSOOBeu3Fs3NNcoAE8Wd7y44/MWjW?=
 =?us-ascii?Q?AJOpp6qaf5eKRETe4C5rdPr/fV1sKN41gb+ERKZMczjxvswuoJz8Mpp4pXX+?=
 =?us-ascii?Q?DkTpWtZO7JMIgjL2daQ3uPsJxfMk3TqL5sbGkAeZjNWmgA8XIrtY+KAPQalA?=
 =?us-ascii?Q?R1VnjBDNlxaQyueQI8VExU60h+XU8SQ7M9+pv7sjUpxch9l0UahmywtcAbWq?=
 =?us-ascii?Q?bJsrstU/OLURb7lFtZ6u/cXVEhBXDXYcB5f6w4pwcMlEIB34DTLAQ6Gh7ov4?=
 =?us-ascii?Q?P+cLmkO7hgP+SmgrehebPuFXKv88zlxAgMNcSZ5xWE68pmAew+TWL1vmqPhF?=
 =?us-ascii?Q?XNIQ8VptePDUuh+rwpzqQ6NNgliaUE2so1ruFP8+/VUU0dLmG3g+jr6aGYNI?=
 =?us-ascii?Q?8z8lP3bD/xuC/Ex61vhgg8JCarmTxr+DM9yIRYvFNIF7MxvISd+CIk6H67Gi?=
 =?us-ascii?Q?7l8a/dq/yYCGFGUiEuLfvdOBCML++WtiE68gG7NqLy3rmLIv0NMt7sj62PlG?=
 =?us-ascii?Q?JxKZY5Nd1PQmkP2KJjm2GmACYTylEboL4vLKlePU1L7OD03+OYKvB7nIFGEC?=
 =?us-ascii?Q?+9IdDNM17sRwhRfBrRuo5LHmeCPOZRKWzFCr?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2025 03:08:54.3456 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8db629a2-3d6f-4860-c5fa-08ddad4c4b0d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002327.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5663
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

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 64 +++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |  6 ++-
 2 files changed, 69 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index c8885c3d54b33..075740ed275eb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -134,6 +134,7 @@ int amdgpu_vcn_sw_init(struct amdgpu_device *adev, int i)
 
 	mutex_init(&adev->vcn.inst[i].vcn1_jpeg1_workaround);
 	mutex_init(&adev->vcn.inst[i].vcn_pg_lock);
+	mutex_init(&adev->vcn.inst[i].engine_reset_mutex);
 	atomic_set(&adev->vcn.inst[i].total_submission_cnt, 0);
 	INIT_DELAYED_WORK(&adev->vcn.inst[i].idle_work, amdgpu_vcn_idle_work_handler);
 	atomic_set(&adev->vcn.inst[i].dpg_enc_submission_cnt, 0);
@@ -1451,3 +1452,66 @@ int vcn_set_powergating_state(struct amdgpu_ip_block *ip_block,
 
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
+	if (r) {
+		dev_err(adev->dev, "Failed to reset VCN instance %u\n", instance_id);
+	} else {
+		/* Restart the scheduler's work queue for the dec and enc rings
+		 * if they were stopped by this function. This allows new tasks
+		 * to be submitted to the queues after the reset is complete.
+		 */
+		drm_sched_wqueue_start(&vinst->ring_dec.sched);
+		for (i = 0; i < vinst->num_enc_rings; i++)
+			drm_sched_wqueue_start(&vinst->ring_enc[i].sched);
+	}
+	mutex_unlock(&vinst->engine_reset_mutex);
+
+	return r;
+}
+
+/**
+ * amdgpu_vcn_ring_reset - Reset a VCN ring
+ * @ring: ring to reset
+ * @vmid: vmid of guilty job
+ * @guilty_fence: guilty fence
+ *
+ * This helper is for VCN blocks without unified queues because
+ * resetting the engine resets all queues in that case.  With
+ * unified queues we have one queue per engine.
+ * Returns: 0 on success, or a negative error code on failure.
+ */
+int amdgpu_vcn_ring_reset(struct amdgpu_ring *ring,
+			  unsigned int vmid,
+			  struct amdgpu_fence *guilty_fence)
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
2.49.0

