Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F8AEC982ED
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Sep 2026 07:53:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A231C10E46F;
	Mon, 21 Sep 2026 07:53:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="C4+83qmI";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010028.outbound.protection.outlook.com [52.101.56.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3920010E46F
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Sep 2026 07:53:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tUALhN4Mb4kbfflYGxd5iCTH7ozF3S/Nd9mBWVpb/1Dt37+nnZDUdw8fIhhCGYRY4GbY4K7K1PhlE05ARKKih5vrfdOss3PADrnPCUpOL5bU147VeJo3VNYfTfga+cU5LyfKfLRd5Ii+KfD1OLgeJP5/KcsXZ2YE03HsOswFQGye3PKEVKtW2fYixQD3+ycCqrRhT9CDl7VS6bg5AUqCFPIEXWcW+Pegr25yOswNxu2bAG1DBVwWY3Ydo95bYXj13suFk266oDFdFCV8lK7SoL7+HEnJJkn8CQZFb1gvNIlVD2h7uWJkcFOd18IaIu7eObipiQdJqVHiYEUwgHAoRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Xg2eNivlben557iuOawDakMdislPTqO90dXxT7rQYA=;
 b=bRrkP7ChviCEVs6ZHjylOpZbLKbdvMIi6irQ0hb4gtXjgK6kKCUEH46n2d8DqJPtCeXgNLEQ9X2oJEizV1hJelk/sdLOZlB+cwFiQUVrWvq9jZITs1aRnEZ7yOZXWJwutFdYasSDUbqD5lD75VITlkBM1MiuHwMjXi6lqOSmnweftuubrac/9o3EMtxpfOQ+xCKzSNbiiF+uCCtw5fJxi0b3eOh3U8EZ3LzAa3WWN2iJQGOvJPlyX6OxcSLhYzOfIUuQarAKl/hkMwbq6OTRdTkESogfYajdQCrqZwy6Jhu88oytnh/5iUd+d8HukHTPITAlX1+qbb27TKHlyBc8+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Xg2eNivlben557iuOawDakMdislPTqO90dXxT7rQYA=;
 b=C4+83qmIGKcd9fIMqMzQ0MMK7FCsUz9UoSyX4bvk8LEkGd8gVj3/ossHNxkZHIl2CRERfiD4bmSB29XgcVNOS0WTtzyDTE2KAwUmFz706CR8/HZIwYFDqDQiE2WmIdntMsMg0jCLPGCllaZ2gPIGJEScoB8/Vyh6pODlv90HQ58=
Received: from BY3PR03CA0002.namprd03.prod.outlook.com (2603:10b6:a03:39a::7)
 by BL4PR12MB9721.namprd12.prod.outlook.com (2603:10b6:208:4ed::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Mon, 21 Sep
 2026 07:53:46 +0000
Received: from BY1PEPF00026959.namprd05.prod.outlook.com
 (2603:10b6:a03:39a:cafe::2e) by BY3PR03CA0002.outlook.office365.com
 (2603:10b6:a03:39a::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.16 via Frontend Transport; Mon,
 21 Sep 2026 07:53:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BY1PEPF00026959.mail.protection.outlook.com (10.167.244.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Mon, 21 Sep 2026 07:53:46 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 21 Sep
 2026 02:53:45 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 21 Sep
 2026 02:53:45 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Mon, 21 Sep 2026 02:53:43 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <Lijo.Lazar@amd.com>, <Prike.Liang@amd.com>, <mnovales@amd.com>,
 <Jiongyu.Zhu@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH 08/21] drm/amdgpu/mes12: read the gfx user queue VMID for MMIO
 reset
Date: Mon, 21 Sep 2026 15:51:15 +0800
Message-ID: <20260921075326.2409021-8-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260921075326.2409021-1-Jesse.Zhang@amd.com>
References: <20260921075326.2409021-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF00026959:EE_|BL4PR12MB9721:EE_
X-MS-Office365-Filtering-Correlation-Id: 142625cd-b95f-42b9-6cd7-08df17b576ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|1800799024|82310400026|23010399003|18002099003|22082099003|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: xoKoVL9pZ1C+bai4MVYE83Id9VbtWMXrIXh4ISXgZGEd172cd6tIR+5XhN6xvF3oZY4GN3+qhcNEUZUUQjvcb54WWvoQnI16kUELlkGyedry/+VM5bvGQRMg+QiKKujVjfEevkk5xo0a2yMV36fPkukJz063md6YzZ67s5U9BX9ReqbypgSBbrQmDM0PlAaHGpkaxk9fPtrxGGfJ0N8P+wLOoHEca03qHOSBmA3M0MjKNyqN99wiHhOR6T5u+hFT+CXgL40GpPTrMFIhte+zdhcOQBFytT0x92k1NYk1dXGuWRFNd3WpevPj+VPTIvcj0Q+DknEizZiiMMki4mNoTNtK/mPn/mjbNNs/QLrt/4Rpu1rfcVrZ/RPtf7N/S/kvnEHBEVo195XwloMIAJImTypVOlKBve4EzV+ZdBm2e0s2L9/CpAJbuqgf2vbYSQ8sQwhsJDla4iWzgkx7fuwafctIVIMyeX2/mCnNvwxQaicTzWKhT8Pppq8ZnJasuR5BTKmNN2Kkv0DYho4y+GPvdl/ehFWgUqZ/Agum9c2vHDhI5//rbKR8/FCNTdmN4P5njwCPaP9SfK82wZtIiKtvZEmtLSXJe53/vhuF65yYXGGaroY+EMhoaoQQ98srscbtnSQUae30JLCiR8DXzYjHyh7VNjhloBHDWOg3HE4mUpZJDn2FwS4itvOWkJGzADDVMiEDtuTwF7yWeJtNbMDvqw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(1800799024)(82310400026)(23010399003)(18002099003)(22082099003)(11063799006)(56012099006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 9bM91X1ngEHQJc5zi3GCB9/V/CJWK+Rln2xhIquVjXOvBSWctqh7ogYz0H8rJlkohLgEkAgMvMnznn3qaSB0guQ5piiRx8SYfyuEkAFHDLA2fLiNEW5h6OWpCDRGA7wAZgMYGa6vaoeuDIb85zJSRVR0kM0+MAjPZaDpS9vEPhXB63yCYFR8sV48lL52juZm9qE3PsqRRRy3uc/jnlE4ynYp+Zb6xhdtGZyAClP83+UugH+JRl1Qto7T2ECABuMI6oSuNDYGDTZnrxtPdIGSVyafWqYcVIAT/Z/oxlVRHWC9rKKy8bu4gBRaNwwMABaHu5foV0Xir6dcvUAZvN2MlH6Ojt2Qk3RELWuPySpwxmLHhKIXQs7C8FqPayipVRiGzbCo2WxG2MjbybhwXRtRSDy2sC4fdEKTdJd6MMJzSiKvKk7fw38d3vBtz0ov8Ouy
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 07:53:46.0460 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 142625cd-b95f-42b9-6cd7-08df17b576ee
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF00026959.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR12MB9721
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

Read the MES-assigned VMID from CP_GFX_HQD_VMID under srbm_mutex when
resetting a GFX user queue over MMIO. Kernel queues keep the IB VMID
supplied by the caller.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
index 41d6799177d2..ead276503522 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
@@ -663,7 +663,8 @@ static int mes_v12_0_reset_compute_pipe_mmio(struct amdgpu_device *adev,
 
 static int mes_v12_0_reset_queue_mmio(struct amdgpu_mes *mes, uint32_t queue_type,
 				      uint32_t me_id, uint32_t pipe_id,
-				      uint32_t queue_id, uint32_t vmid)
+				      uint32_t queue_id, uint32_t vmid,
+				      bool is_kq)
 {
 	struct amdgpu_device *adev = mes->adev;
 	uint32_t value, reg;
@@ -672,11 +673,15 @@ static int mes_v12_0_reset_queue_mmio(struct amdgpu_mes *mes, uint32_t queue_typ
 	amdgpu_gfx_rlc_enter_safe_mode(adev, 0);
 
 	if (queue_type == AMDGPU_RING_TYPE_GFX) {
-		dev_info(adev->dev, "reset gfx queue (%d:%d:%d: vmid:%d)\n",
-			 me_id, pipe_id, queue_id, vmid);
-
 		mutex_lock(&adev->gfx.reset_sem_mutex);
 		gfx_v12_0_request_gfx_index_mutex(adev, true);
+		mutex_lock(&adev->srbm_mutex);
+		soc24_grbm_select(adev, me_id, pipe_id, queue_id, 0);
+		/* Userq VMIDs are assigned by MES; KGQ uses the supplied IB VMID. */
+		if (!is_kq) {
+			value = RREG32_SOC15(GC, 0, regCP_GFX_HQD_VMID);
+			vmid = REG_GET_FIELD(value, CP_GFX_HQD_VMID, VMID);
+		}
 		/* all se allow writes */
 		WREG32_SOC15(GC, 0, regGRBM_GFX_INDEX,
 			     (uint32_t)(0x1 << GRBM_GFX_INDEX__SE_BROADCAST_WRITES__SHIFT));
@@ -686,6 +691,8 @@ static int mes_v12_0_reset_queue_mmio(struct amdgpu_mes *mes, uint32_t queue_typ
 		else
 			value = REG_SET_FIELD(value, CP_VMID_RESET, PIPE1_QUEUES, 1 << queue_id);
 		WREG32_SOC15(GC, 0, regCP_VMID_RESET, value);
+		soc24_grbm_select(adev, 0, 0, 0, 0);
+		mutex_unlock(&adev->srbm_mutex);
 		gfx_v12_0_request_gfx_index_mutex(adev, false);
 		mutex_unlock(&adev->gfx.reset_sem_mutex);
 
@@ -1182,7 +1189,8 @@ static int mes_v12_0_reset_hw_queue(struct amdgpu_mes *mes,
 	if (input->use_mmio) {
 		int r = mes_v12_0_reset_queue_mmio(mes, input->queue_type,
 						   input->me_id, input->pipe_id,
-						   input->queue_id, input->vmid);
+						   input->queue_id, input->vmid,
+						   input->is_kq);
 		if (r)
 			return mes_v12_0_reset_pipe_mmio(mes, input->queue_type,
 							 input->me_id, input->pipe_id,
-- 
2.49.0

