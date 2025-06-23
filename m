Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 533D4C77B7C
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Jun 2025 16:15:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A064F10E427;
	Mon, 23 Jun 2025 16:15:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zSE3Zu7i";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2072.outbound.protection.outlook.com [40.107.243.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D2E910E421
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Jun 2025 16:15:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DH4GAKaoJUW/NvxBHefRg+PdTUIYmwnWuBtypVIXiMyHQ3a4WFCTBHMliquT9AID6k1/UPt1tqurp5VKfyW7MA4v68yzgFbWhLYgSGu+Yg20uW/F0o40P3gxmd+/I1gwlNSXzRxxVgVeDMGw/tGSw9V8wbOgakbdLGKknVq4Ly8+anwxbxYIXHgmZA5RfwTxq0P/xi6qvlDDELU9i7n/dwKOsmm4QoVLcv+YVB6IK1nzKAxCE2Cw6IHT0MpTa4K5XhN4qgF2+ecpVKnPwYSfYc7g1Npo5Qc9+nO14qLexHXPhQToahVUIWPqAMqh3j5D4PlJSraLnNIeH3HclOh3Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5dhRVm+2ngURz6qcHrBVfZ+RozU6F+D/0xDi6+G5LlQ=;
 b=IdwgFM529uMBgQIue3M5MS3ln4gp+JvXPnjoVs3b2008qvGlDJsEDdjcJioQ+vlTuvvzmzEdqm7xLoBwZUnviH0YYG6JE5/U5lj4Tlvw/MAZBFyPtpS/T4Idm82+1Q9VJNXUcUGB/Aoq3/Zu2682Lih+R6vAWU71CYciA2j25Ql4F92+v6DcJdVTimhUCu5wZkgWy9cVlCD969OpeJGmyGzoIwEQGK/TTETd9IRXEZbPjYnYchufNw3zb43476ue3vqamUMJeLiLeRzuxiHMRb9Ts2MQE5IEPRw46cOedpRH03TxEGsPAyyY2OOEngAdq+CePXexh3MGDTi3hHNK+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5dhRVm+2ngURz6qcHrBVfZ+RozU6F+D/0xDi6+G5LlQ=;
 b=zSE3Zu7iCNcICZib3mv+DlrFX5D61zBCJwp0YFtSvy1cO1oll55nenz3RAviaiQbri8MzlLhQnyI4cJ/tZ0GWFPBDDV9tmTcDELpPEQjVpA9V3Zqc//kM+GPnUBZ2Z2EhctOlJrGOf874IgxNL7slcZh3XQg0GMGbvt264bJsJw=
Received: from BN9PR03CA0933.namprd03.prod.outlook.com (2603:10b6:408:108::8)
 by IA1PR12MB9063.namprd12.prod.outlook.com (2603:10b6:208:3a9::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Mon, 23 Jun
 2025 16:15:13 +0000
Received: from BN3PEPF0000B078.namprd04.prod.outlook.com
 (2603:10b6:408:108:cafe::5) by BN9PR03CA0933.outlook.office365.com
 (2603:10b6:408:108::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.20 via Frontend Transport; Mon,
 23 Jun 2025 16:15:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B078.mail.protection.outlook.com (10.167.243.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Mon, 23 Jun 2025 16:15:13 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 23 Jun
 2025 11:15:11 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>, Sathishkumar S
 <sathishkumar.sundararaju@amd.com>
Subject: [PATCH 28/31] drm/amdgpu/vcn: add a helper framework for engine resets
Date: Mon, 23 Jun 2025 12:14:34 -0400
Message-ID: <20250623161438.124020-29-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250623161438.124020-1-alexander.deucher@amd.com>
References: <20250623161438.124020-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B078:EE_|IA1PR12MB9063:EE_
X-MS-Office365-Filtering-Correlation-Id: 54a3f4d9-3d21-44a2-b22f-08ddb2712257
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?P62su4Nun/NbGTINq90Gtf8oZSlTIqDmG/PsNIXhdRtlP02hs7YmH9c/XpBj?=
 =?us-ascii?Q?LopavSxoIZ6S/VZ1BpPPlACeXbzPKN38+k6FvP9uhyno+rx80jKbj586PLXH?=
 =?us-ascii?Q?zlflCUpP4n2X6I5Lu9ZZCI5jDTOlIOsYrpQXzmn/NossMW5AdsTnZT1ShvaK?=
 =?us-ascii?Q?6vEhPJmV0NaMZTYVUhmaDwEWQbpVDBHosd6aigsJKe0rkMuqqmRoNCDij3EY?=
 =?us-ascii?Q?bb81kq/TxT/iEA5+JMUD80NcuAZskRjhyRGywVZzp+CUyNxsoHyTvpIOGFJz?=
 =?us-ascii?Q?pR7wQ7mVcGnHdl3fI44Tq0oOJHFsSl54D0UiY2MZ3VV+mxnsroCMsWr2XxyC?=
 =?us-ascii?Q?o73mmbPF9y2TyVwBi4TVyySnYny+2VqiK6CO7F5iv9cVwBKeOEwLhsuD59RZ?=
 =?us-ascii?Q?WTTefKBiC02NpnyTThVL5cuySinbCg6yh0cm1EV0DRJSyD/UtVN2oGg1jGx9?=
 =?us-ascii?Q?oAtE6XrchaOhrWry8L5La2Q88wwGVBLsq5EIBsqaWIGagKleyt5wXSpPZBJM?=
 =?us-ascii?Q?H7vq+PkSwQh4wm0R2/p6m2zbJdBS/rJ5qX5BgwPfE0PIZTa0ge89kUhLvWPL?=
 =?us-ascii?Q?+I0+9LMYm8HFVavTKoPyN8i6XhsIo6MD8Qb7q6/fpigodvA/gnVoBb6rWIfM?=
 =?us-ascii?Q?q0C9LqCa10r4gKet+rh2ZUcI4vsoml7I46tv865H4OpTE22HCRC63gtR8ZDu?=
 =?us-ascii?Q?hJN/J+Ch9s/l2xpDoXLkw0ffazY7C8zHJJhrYlrkBci+hT+Ih+TwcSooayAf?=
 =?us-ascii?Q?9tupNR1f5ClOCOs/Ih5kQjW3P3snkoRmDDACzo5DsKedBNMPxAYnNnzaZtHx?=
 =?us-ascii?Q?E+1UXan2GYGBrjaj5pLk/xo303BCGkMWHERyh3rvnzaSRfG/5peiWQw4953j?=
 =?us-ascii?Q?zc3EPj23ELLCJRSv077z6GoKl0o/faHLOw09B70Zv8K5r6WeA+jdf1716KCq?=
 =?us-ascii?Q?jb6jpUPathJNNX+B0vbl8YZ1hBYhGGVrT7K3ZXfq0RPBXUGa7uojIr8VOzwx?=
 =?us-ascii?Q?eIG+4c5Qdgk8gHN+fF343BRjrhPVahuanc77/cqrsTbIaew0WslOQ7RA6Ln/?=
 =?us-ascii?Q?0eKzcd+WeSzxIobUui84qrSNi6WgjfVF6Nd0Zqk2rLDx/CjER8y3jo7HEHhC?=
 =?us-ascii?Q?AdLJfZK9OWOWFMcnJlysxxmUnO9H3BxR6r8bKFQvJYopSzuYpqPizZxadPUV?=
 =?us-ascii?Q?USINZlmj/m+It3XUDE5XtHVAmzdd5k+gC002r3t8TrenU4ewTpsgOR80rpQb?=
 =?us-ascii?Q?QgQ1ZJ7lP7SRfwPCXAQt9ik9pVFg1ptQzJSRVeuSr9CjeSmPrSii5v66y5vg?=
 =?us-ascii?Q?bIItDqU6O2inVWSBN9gGbRKqVdjAVVwnfWerzRO33ZKGWsPB0kh3BJ1Y/9Nv?=
 =?us-ascii?Q?HJxpsZmo5rdNcsDBDtkyyQ5T8UArhB033yPH1kTOxAfRa9X9+4PMvXMBvU5M?=
 =?us-ascii?Q?otJToSlt5aayk2L+ZLtRaKJPNj5CMcmRzhE8AZAzFdDdj+M6ZLB1BZyf4mP4?=
 =?us-ascii?Q?3dU92XBvr/oX5UC6Fo/w/SLgFh04txhLnUyJ?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 16:15:13.3307 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 54a3f4d9-3d21-44a2-b22f-08ddb2712257
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B078.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9063
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
2.49.0

