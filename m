Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC533C7115D
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Aug 2024 03:48:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A2EC10E177;
	Thu, 29 Aug 2024 03:48:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Fds/Galq";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2059.outbound.protection.outlook.com [40.107.237.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 670A310E177
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Aug 2024 03:48:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XnyoMOIJ6sOQx0Hm2CUBsBa9DqEHknFxa3aRlWspxyXu7xqz74U3WL89h/GRPZtjp5JLvdWtJaOTx4aXMdY7h7izBGmy9VP8xmjW8UaIj3ZIqS+bbdzVRJ5LE0Rg/owyxYNb7AB7mZ50qt7yK+4+hx4XimmFJ+eCfGA4szK6OBFx2k6ksdzie3pDmR588ecL7buS+pNnRSPZ0dl1KrpepZnDcvLFeKlmfJtwAXu1rHjgYjtXoDLOr2Nsuir1KkR94yQ/McpJxv0tzKMDIPNdbrK3d9nz3CQhbn3GKTmY0LVn8l7bo3DgXsDCtCodex5XTQVQDSV8Aco0Hnaca1JK6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2cDs8FNmVs800cPQUXNnjIiG7s6HvJxlbUcFB4kskYg=;
 b=O+JwH5XTbCb+/EDTz9xM0m3/4SqYRt1KeTgJNxHpOQk5pf+7BXl5QtpaiE9wsm8IVSAY+3T3YYu+z+zb88EHz/A2xZrBUUjFmCTj2EP9YZ1sQ6B2LSiwDV3+Tm+NHWavvtVIjD3rUEAw/bOKjkk08h5xNQcdkR1kD+6w+/+kWck/10aBr6aPVcBpKq/O60vFYEdub+7e7Ttafn2/xkJeaOxz5jga+ZiUvdGfNlSht+zM+Rtrlp62XS2wN704FboWkqxeYuLWom3US1TwOpORIGLsE7WtUtw3zxDfjXM3AhULZJEwYaRD1bgZocKtQrqSLgVTQw5Oz7Wl+E/yFmTbOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2cDs8FNmVs800cPQUXNnjIiG7s6HvJxlbUcFB4kskYg=;
 b=Fds/GalqFsRqsz9ka8t4wxcPemDpgdlUpKg/aQCDcPNQndY1fK/UblWf1plcrf9K//sXOf9el4cWBw+sMMiMygKigNk88xHGrcNtfuBKgkNm3AmtN7gjS6Daze9ANa7uDRZvx4thr76MAfo+6mFTi2OBUw2nDRbK4NVwy+RLPoU=
Received: from PH7P221CA0068.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:328::17)
 by LV3PR12MB9094.namprd12.prod.outlook.com (2603:10b6:408:19e::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.27; Thu, 29 Aug
 2024 03:48:35 +0000
Received: from SN1PEPF0002BA50.namprd03.prod.outlook.com
 (2603:10b6:510:328:cafe::1) by PH7P221CA0068.outlook.office365.com
 (2603:10b6:510:328::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.28 via Frontend
 Transport; Thu, 29 Aug 2024 03:48:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002BA50.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Thu, 29 Aug 2024 03:48:34 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 28 Aug
 2024 22:47:57 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Lijo.Lazar@amd.com>, <Le.Ma@amd.com>, "Prike
 Liang" <Prike.Liang@amd.com>
Subject: [PATCH v5] drm/amdgpu/gfx9.4.3: Implement compute pipe reset
Date: Thu, 29 Aug 2024 11:47:12 +0800
Message-ID: <20240829034712.2896869-1-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA50:EE_|LV3PR12MB9094:EE_
X-MS-Office365-Filtering-Correlation-Id: c55f28fc-851d-4a93-8004-08dcc7dd7567
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3CdXX70iRqzRPGuGJNaWZqWSn68GuUoXsA1gytdGNl39hlOknnMlwl9XMQjf?=
 =?us-ascii?Q?+FODqCKq66g3zqmsbGKYQWGFRbv2d1T/PKR0ryqQYS93SKzL0DVvQsAz4mZz?=
 =?us-ascii?Q?fCOlY98G7eoLv6SKnww92L6xyZil4FQ4f87NE3xA+GgBuXF8TR8xq8+wL3SE?=
 =?us-ascii?Q?lFjw3619nKbhbo9IllQIhyUIIY5fDeb9qBBLBJqIgf2SwWvJlYovyf3jZP7j?=
 =?us-ascii?Q?I8PrZyFzhV0NZn2D5GkhJpO5eqN3+2S2oYXd+fLg05Q1DOPdPpnHQGxkJeIF?=
 =?us-ascii?Q?nxrX5Urpejb7U2BxR94Ux20r0jnOS+8iBnnkLTtMfUTWeyTjw9k1wHWNkJMt?=
 =?us-ascii?Q?AXydnGL3VHj3CLMZ32cjHqWcMVqj7SKqkOIc3u0iTl8zqgP5B2U2Qj3EvBpG?=
 =?us-ascii?Q?GyFBflclOd/X4TklsvsOAR4LhELY3GwUrfCUPv7ruCS4/ebBs+dxbAk2c1O1?=
 =?us-ascii?Q?Uf/ByOqywOkrM0F+jRyLrO25AT0rWRuG5rZBFQ6cYmuEH6LMCEHm7U99O9P5?=
 =?us-ascii?Q?fFfRThuKpnV2oaWFlBNApERKm62S+a6HbVDmKkY9ABEl0xW7o6RtxR9LQnK2?=
 =?us-ascii?Q?GTX11jJiwmzNRcgNaNoNwPiUWVaOYVF9LLzC4RqNtvTCSk5zvJHYC8vv4vbl?=
 =?us-ascii?Q?U35ZYgA0I+W7Lwiam98Nk2+X2VJM/Eb4AleeOSmgbuG34HTWnyY3PmWCMlHJ?=
 =?us-ascii?Q?dy/S0Jh+YR2hw96ahMEUm3PZI7NRJCgE03MoBSdql4bXiZJ7mbfVguo58+ou?=
 =?us-ascii?Q?K1d8z6gDw0e9vSPZdp8934kqfbHbbvSkkErs60In+pJZUi5P/cw/DYbPUH91?=
 =?us-ascii?Q?Bpm+uIQb3gToQu6AdhWmW+BFyfobL2Xgp/n0VoUBIR4al87v6X5lyA23VsFa?=
 =?us-ascii?Q?fWX6DrP6n7Bmo18msDgcDHt90/Vq5wxFyGmQoE20wmW+3jyhiy0n0ts3jrgW?=
 =?us-ascii?Q?kuorb4UOCbgKxxhbQ7sd/TQI1wlqgK/43gyfcirpc+6hNhMxFF8Gc1qpbRGV?=
 =?us-ascii?Q?i6blLlb+0++drblpWTJE5yVpf/VRz5I9NWCgL96c5gReFlslIA52IGPlkRyJ?=
 =?us-ascii?Q?IKHmasdXO12w+fpimTsaaIcrxiShJxt8Y/obzC+QkU3LEm9Qwk6AU2j1ExjB?=
 =?us-ascii?Q?NfD2MMjA/D6VgjmkhCLWT5g1sTGUTtXo534bjBx6h7vCEgTppeUbYthsu7pT?=
 =?us-ascii?Q?HE5qvUNbzYQDZyIfLwbxwUKNCpuIHCdYKRCwa2W6EUpJ1BfuMxZ3YxsiMhAG?=
 =?us-ascii?Q?a46/E25LLj6Z7WbjKy03PFopx7oqPwgHB+wrQdoTNQ/5tXokZyuyyDfk29r4?=
 =?us-ascii?Q?IKcyi98UICwjuLhFf6Ie2P7aKlXJTzLgjgF9IbIJzKWqaOJrSBqd/IfRr3Eu?=
 =?us-ascii?Q?SvpBfIIPdqCNmtrDCZ7URJuOXJAs2a1UGIIiy3E9bhxrwy1flq99zMoi9ppp?=
 =?us-ascii?Q?rYc7pf5ge+kVBFgsfScZfFg807kBNgbJ?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 03:48:34.9309 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c55f28fc-851d-4a93-8004-08dcc7dd7567
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA50.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9094
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

Implement the compute pipe reset, and the driver will
fallback to pipe reset when queue reset fails.
The pipe reset only deactivates the queue which is
scheduled in the pipe, and meanwhile the MEC engine
will be reset to the firmware _start pointer. So,
it seems pipe reset will cost more cycles than the
queue reset; therefore, the driver tries to recover
by doing queue reset first.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 127 ++++++++++++++++++++----
 1 file changed, 108 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index 2067f26d3a9d..26ae62d2a752 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -3466,6 +3466,98 @@ static void gfx_v9_4_3_emit_wave_limit(struct amdgpu_ring *ring, bool enable)
 	}
 }
 
+static int gfx_v9_4_3_unmap_done(struct amdgpu_device *adev, uint32_t me,
+				uint32_t pipe, uint32_t queue,
+				uint32_t xcc_id)
+{
+	int i, r;
+	/* make sure dequeue is complete*/
+	gfx_v9_4_3_xcc_set_safe_mode(adev, xcc_id);
+	mutex_lock(&adev->srbm_mutex);
+	soc15_grbm_select(adev, me, pipe, queue, 0, GET_INST(GC, xcc_id));
+	for (i = 0; i < adev->usec_timeout; i++) {
+		if (!(RREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_HQD_ACTIVE) & 1))
+			break;
+		udelay(1);
+	}
+	if (i >= adev->usec_timeout)
+		r = -ETIMEDOUT;
+	else
+		r = 0;
+	soc15_grbm_select(adev, 0, 0, 0, 0, GET_INST(GC, xcc_id));
+	mutex_unlock(&adev->srbm_mutex);
+	gfx_v9_4_3_xcc_unset_safe_mode(adev, xcc_id);
+
+	return r;
+
+}
+
+static bool gfx_v9_4_3_pipe_reset_support(struct amdgpu_device *adev)
+{
+	/*TODO: Need check gfx9.4.4 mec fw whether supports pipe reset as well.*/
+	if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 3) &&
+			adev->gfx.mec_fw_version >= 0x0000009b)
+		return true;
+	else
+		dev_warn_once(adev->dev, "Please use the latest MEC version to see whether support pipe reset\n");
+
+	return false;
+}
+
+static int gfx_v9_4_3_kiq_reset_hw_pipe(struct amdgpu_ring *ring)
+{
+	struct amdgpu_device *adev = ring->adev;
+	uint32_t reset_pipe, clean_pipe;
+	int r;
+
+	if (!gfx_v9_4_3_pipe_reset_support(adev))
+		return -EINVAL;
+
+	gfx_v9_4_3_xcc_set_safe_mode(adev, ring->xcc_id);
+	mutex_lock(&adev->srbm_mutex);
+
+	reset_pipe = RREG32_SOC15(GC, GET_INST(GC, ring->xcc_id), regCP_MEC_CNTL);
+	clean_pipe = reset_pipe;
+
+	if (ring->me == 1) {
+		switch (ring->pipe) {
+		case 0:
+			reset_pipe = REG_SET_FIELD(reset_pipe, CP_MEC_CNTL,
+						   MEC_ME1_PIPE0_RESET, 1);
+			break;
+		case 1:
+			reset_pipe = REG_SET_FIELD(reset_pipe, CP_MEC_CNTL,
+						   MEC_ME1_PIPE1_RESET, 1);
+			break;
+		case 2:
+			reset_pipe = REG_SET_FIELD(reset_pipe, CP_MEC_CNTL,
+						   MEC_ME1_PIPE2_RESET, 1);
+			break;
+		case 3:
+			reset_pipe = REG_SET_FIELD(reset_pipe, CP_MEC_CNTL,
+						   MEC_ME1_PIPE3_RESET, 1);
+			break;
+		default:
+			break;
+		}
+	} else {
+		if (ring->pipe)
+			reset_pipe = REG_SET_FIELD(reset_pipe, CP_MEC_CNTL,
+						   MEC_ME2_PIPE1_RESET, 1);
+		else
+			reset_pipe = REG_SET_FIELD(reset_pipe, CP_MEC_CNTL,
+						   MEC_ME2_PIPE0_RESET, 1);
+	}
+
+	WREG32_SOC15(GC, GET_INST(GC, ring->xcc_id), regCP_MEC_CNTL, reset_pipe);
+	WREG32_SOC15(GC, GET_INST(GC, ring->xcc_id), regCP_MEC_CNTL, clean_pipe);
+	mutex_unlock(&adev->srbm_mutex);
+	gfx_v9_4_3_xcc_unset_safe_mode(adev, ring->xcc_id);
+
+	r = gfx_v9_4_3_unmap_done(adev, ring->me, ring->pipe, ring->queue, ring->xcc_id);
+	return r;
+}
+
 static int gfx_v9_4_3_reset_kcq(struct amdgpu_ring *ring,
 				unsigned int vmid)
 {
@@ -3473,7 +3565,7 @@ static int gfx_v9_4_3_reset_kcq(struct amdgpu_ring *ring,
 	struct amdgpu_kiq *kiq = &adev->gfx.kiq[ring->xcc_id];
 	struct amdgpu_ring *kiq_ring = &kiq->ring;
 	unsigned long flags;
-	int r, i;
+	int r;
 
 	if (amdgpu_sriov_vf(adev))
 		return -EINVAL;
@@ -3495,26 +3587,23 @@ static int gfx_v9_4_3_reset_kcq(struct amdgpu_ring *ring,
 	spin_unlock_irqrestore(&kiq->ring_lock, flags);
 
 	r = amdgpu_ring_test_ring(kiq_ring);
+	if (r) {
+		dev_err(adev->dev, "kiq ring test failed after ring: %s queue reset\n",
+				ring->name);
+		goto pipe_reset;
+	}
+
+	r = gfx_v9_4_3_unmap_done(adev, ring->me, ring->pipe, ring->queue, ring->xcc_id);
 	if (r)
-		return r;
+		dev_err(adev->dev, "fail to wait on hqd deactive and will try pipe reset\n");
 
-	/* make sure dequeue is complete*/
-	amdgpu_gfx_rlc_enter_safe_mode(adev, ring->xcc_id);
-	mutex_lock(&adev->srbm_mutex);
-	soc15_grbm_select(adev, ring->me, ring->pipe, ring->queue, 0, GET_INST(GC, ring->xcc_id));
-	for (i = 0; i < adev->usec_timeout; i++) {
-		if (!(RREG32_SOC15(GC, 0, regCP_HQD_ACTIVE) & 1))
-			break;
-		udelay(1);
-	}
-	if (i >= adev->usec_timeout)
-		r = -ETIMEDOUT;
-	soc15_grbm_select(adev, 0, 0, 0, 0, GET_INST(GC, ring->xcc_id));
-	mutex_unlock(&adev->srbm_mutex);
-	amdgpu_gfx_rlc_exit_safe_mode(adev, ring->xcc_id);
-	if (r) {
-		dev_err(adev->dev, "fail to wait on hqd deactive\n");
-		return r;
+pipe_reset:
+	if(r) {
+		r = gfx_v9_4_3_kiq_reset_hw_pipe(ring);
+		dev_info(adev->dev, "ring: %s pipe reset :%s\n", ring->name,
+				r ? "failed" : "successfully");
+		if (r)
+			return r;
 	}
 
 	r = amdgpu_bo_reserve(ring->mqd_obj, false);
-- 
2.34.1

