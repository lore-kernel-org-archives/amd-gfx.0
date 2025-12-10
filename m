Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEB46D2CE17
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Dec 2025 07:14:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE7D410E686;
	Wed, 10 Dec 2025 07:14:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SwQjSWK2";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013061.outbound.protection.outlook.com
 [40.107.201.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D77810E683
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Dec 2025 07:14:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zHWWGSGyHDveGexNYZvUwwMKtT+CInqO9G9yy9VR8S5lPCmqpTL1jiCdFTnN/KE4A2hyhPHHdUWXqkAs7qUiBKRzX48/IxgScg2QLdWooXt7g6Y3TaEEm7ixJo/28Eabf4nkoCKh7yruVa6tTPTW+1OWKMTvEcpxIgIiomLWTdiamtOpA8kY+DFDaPsxgNZwYMeSappwK93IRCHeQ/bHkeV+Gc7qtnJrKMQVWOoJLFwInhKNGBP4CEY7xhN5xB8HVRDYFsnS6Mgw9uRRbnFqp16oLYI3YzjUtd8Ew8rgqvXMRiwKc2AaKQZhujocdNWFQCc9Vl8nPONTah5Qc7+X2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xtE/ZhOSVsvw5YP9W41KQXOaiDBw4WR8W0S1dnVQKHw=;
 b=bcqBXyVnfcKXeo9g5LOM2SkBlLXOz20y1f4ZN18NY1apP0GtdIaW9z0XO1nEaW/nrrVXO6H4KiczqJJJrhNeUdZq3qwzrfilEUwck5dnMbLcXzxZ14EsA4YFKWbfiySMGMjaOg5zbZ50Lkb7bT0tSTTyDaaml5HwAcrNBaiHI8n37uyz6IUB5pn/D9NlIZV/wHCkezfdvYd+Hu8tk3bU3mu52JWebyBbuZJ5e6bUeImEpNUQwfBa70Jhwpo8ILbb1NpD7qHMSGZPg3N3kLbJbwG7QdVygMzO6Z1gtLTlrKM4ZVTN/pz4qZU7J60MHGUCeIBkGhZmXa/Y5+jqfr/mdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xtE/ZhOSVsvw5YP9W41KQXOaiDBw4WR8W0S1dnVQKHw=;
 b=SwQjSWK2vILwBRP+7IeEtJFESTitoUa+zdd7VlPkfd4MgyqTGT5rph/LtNPHlK5XL1wsv2ThmLFEgxKG2I7axFx6gkGDQhahChbIIElB0zsrsrFpN4AUqXPrgcGV3OC4otDz3msLbJO+HLC2OR9xc8Q9aRaiTG0qi/nB4A3zheE=
Received: from SA9PR13CA0041.namprd13.prod.outlook.com (2603:10b6:806:22::16)
 by DS0PR12MB8044.namprd12.prod.outlook.com (2603:10b6:8:148::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.7; Wed, 10 Dec
 2025 07:14:34 +0000
Received: from SN1PEPF0002529E.namprd05.prod.outlook.com
 (2603:10b6:806:22:cafe::9e) by SA9PR13CA0041.outlook.office365.com
 (2603:10b6:806:22::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.8 via Frontend Transport; Wed,
 10 Dec 2025 07:14:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002529E.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Wed, 10 Dec 2025 07:14:34 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 10 Dec
 2025 01:14:32 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Michael Chen <michael.chen@amd.com>, Harish Kasiviswanathan
 <Harish.Kasiviswanathan@amd.com>, Shaoyun.liu <Shaoyun.liu@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: Fix CP_MEC_MDBASE in multi-xcc for gfx v12_1
Date: Wed, 10 Dec 2025 02:14:04 -0500
Message-ID: <20251210071415.19983-10-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251210071415.19983-1-alexander.deucher@amd.com>
References: <20251210071415.19983-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529E:EE_|DS0PR12MB8044:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b19a9b4-7e9d-474e-ad41-08de37bbc591
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?bdk02kclPb6MhpD6I2TdCFvumaeHJMjjVL+WOLIpzeAVlVlecqtkj2RHwbmn?=
 =?us-ascii?Q?WwGAt5PKsBHord3MYLc+W398jCcKDeXlBU0rjWhvxWiMDD6QHimU76hd9hE8?=
 =?us-ascii?Q?US7yMH6ejST6JporJDU4zJ8IThEGvpmxhL4K0C6hHUjvoZdEUSqQOezyA9Xs?=
 =?us-ascii?Q?TPDjR73ZKOOsOuPNsVf15OYoJFNlTnK0jCOhPtSuBc8rq8kTXTbFz+5YGs/k?=
 =?us-ascii?Q?XZwh1S6+hzlyZ7W8MvlIRt1mOuoyV03lRdEK35nFzevmQyIjg79OD/BZgnuB?=
 =?us-ascii?Q?J6j71TrkmzpkqzfURr8oxK/q9jp9f2dX1rwI5+pW1McD9DJ2uYmLOEiZ6Rg6?=
 =?us-ascii?Q?SFO79NTYMvdqcVR/rfixIBatFXtemRJkkHDY0T8DTeiK28bhePvHRZIaQKmi?=
 =?us-ascii?Q?HfPNURIUJqXG1Sjry45ejHKJBZKU34ep1ZgObI257SE125kNd87Riu4xIPqb?=
 =?us-ascii?Q?nlOLVH4PsQZQwmG+HjZJFmSWlJ5ufiCXPbJY52ZdunOgqZSVCDtDDHI0VJ6K?=
 =?us-ascii?Q?WaAG3vZh2Xi8ebecZc4E2GsrETdKtlzKxhkmAUqLRQE9tB3/1RJE6WUllUu0?=
 =?us-ascii?Q?WsUObI/4lnbi4lMljdCuZHqZDruguXCuqrYIWnsI7BjgoVcoMyLd9Qpub5Ge?=
 =?us-ascii?Q?wE/tzK292lhm5Uvc4JPOeZWcVaovZFVoFthL40mQbxCD+43NVRqcQzkBav36?=
 =?us-ascii?Q?8VRKgUCLTRag4Sq++IEou56hQf7vQeyi97Qoej59CC18ZucN1Utifvqx0QWO?=
 =?us-ascii?Q?2KrEyTFGZokXzEqAeQZeTX06xUcAw0v+xBIWT743o1VC3x3JfTm2zC9R/Lm9?=
 =?us-ascii?Q?oMm1LLldt4aqgouiUx2b9XHcFg87ErngK+E+RJdrg0D/P0QV9N9qWojxvTrI?=
 =?us-ascii?Q?FV67dWrgkfskwzdF1aOZy5mNflwW4rJDVkOlASsuGb9MVG6/aEt7ndQnmay8?=
 =?us-ascii?Q?tYEaoQ0a9wPnSaCwKcGD+fdK+GZaKLoerMwRSp7BK3EuS7maEnP6wmOviCDp?=
 =?us-ascii?Q?zzNgK24YGuCNJ3xHByHEwiqtGbvou1xW44Wp8OcgRLvTk9ad0iYMYy0ZVjzm?=
 =?us-ascii?Q?xP4e4wsIrKhSWv1+WL9O+2qUZ1F5vEzozpFIC2HqM/c46/FmlEU1cHji9fIN?=
 =?us-ascii?Q?Nj6zmtFKREz4n/vsdjj08UA5ynqdH3oQDLQQ264jDD17K1FtO87SHxiSQDCW?=
 =?us-ascii?Q?Un+LY/H/62+aS8u/pFLuwuh/WYI8ZVKiR4aki7GfbMo0+pkk6YiUSDKCbtFi?=
 =?us-ascii?Q?ZmOoNKLGbZYf4/2ET8mPlKcBVzwlGKSVvCJE3pkI+cG1/hLbHkdDaDwhsDN3?=
 =?us-ascii?Q?v0CkTr3n0goQL+EKDjrel9tlBN+IEOX5eV41RdFmNhqir5kanrl8YWZefMUu?=
 =?us-ascii?Q?c03zGDmazdISFbEVBq5LRMcSN+762Zg+xcSFqNh6lV39R1mN/JKC6D2OdD/s?=
 =?us-ascii?Q?nn76B6Zh075MsBPygBdZ8nJ9ZfC3n92H+UhpzeljkjjhRQXUXu72u1Z9KjOH?=
 =?us-ascii?Q?s6ydgTuVmMvrJ4durtjReIhbMgBZIuEGHivT4DIqTjyIyzHuAB651zQrP4gy?=
 =?us-ascii?Q?jYFHxiCAhFs9mhxTBPo=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2025 07:14:34.5616 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b19a9b4-7e9d-474e-ad41-08de37bbc591
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002529E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8044
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

From: Michael Chen <michael.chen@amd.com>

Need to allocate memory for MEC FW data and program
registers CP_MEC_MDBASE for each XCC respectively.

Signed-off-by: Michael Chen <michael.chen@amd.com>
Acked-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
Reviewed-by: Shaoyun.liu <Shaoyun.liu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c | 192 +++++++++++++------------
 1 file changed, 98 insertions(+), 94 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
index 61ffba9a252bd..347912596a1b0 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
@@ -1887,20 +1887,18 @@ static void gfx_v12_1_xcc_cp_compute_enable(struct amdgpu_device *adev,
 }
 
 static int gfx_v12_1_xcc_cp_compute_load_microcode_rs64(struct amdgpu_device *adev,
-							int xcc_id)
+							uint16_t xcc_mask)
 {
 	const struct gfx_firmware_header_v2_0 *mec_hdr;
 	const __le32 *fw_ucode, *fw_data;
 	u32 tmp, fw_ucode_size, fw_data_size;
 	u32 i, usec_timeout = 50000; /* Wait for 50 ms */
 	u32 *fw_ucode_ptr, *fw_data_ptr;
-	int r;
+	int r, xcc_id;
 
 	if (!adev->gfx.mec_fw)
 		return -EINVAL;
 
-	gfx_v12_1_xcc_cp_compute_enable(adev, false, xcc_id);
-
 	mec_hdr = (const struct gfx_firmware_header_v2_0 *)adev->gfx.mec_fw->data;
 	amdgpu_ucode_print_gfx_hdr(&mec_hdr->header);
 
@@ -1925,7 +1923,7 @@ static int gfx_v12_1_xcc_cp_compute_load_microcode_rs64(struct amdgpu_device *ad
 
 	r = amdgpu_bo_create_reserved(adev,
 				      ALIGN(fw_data_size, 64 * 1024) *
-				      adev->gfx.mec.num_pipe_per_mec,
+				      adev->gfx.mec.num_pipe_per_mec * NUM_XCC(xcc_mask),
 				      64 * 1024, AMDGPU_GEM_DOMAIN_VRAM,
 				      &adev->gfx.mec.mec_fw_data_obj,
 				      &adev->gfx.mec.mec_fw_data_gpu_addr,
@@ -1937,8 +1935,12 @@ static int gfx_v12_1_xcc_cp_compute_load_microcode_rs64(struct amdgpu_device *ad
 	}
 
 	memcpy(fw_ucode_ptr, fw_ucode, fw_ucode_size);
-	for (i = 0; i < adev->gfx.mec.num_pipe_per_mec; i++) {
-		memcpy(fw_data_ptr + i * ALIGN(fw_data_size, 64 * 1024) / 4, fw_data, fw_data_size);
+	for_each_inst(xcc_id, xcc_mask) {
+		for (i = 0; i < adev->gfx.mec.num_pipe_per_mec; i++) {
+			u32 offset = (xcc_id * adev->gfx.mec.num_pipe_per_mec + i) *
+				     ALIGN(fw_data_size, 64 * 1024) / 4;
+			memcpy(fw_data_ptr + offset, fw_data, fw_data_size);
+		}
 	}
 
 	amdgpu_bo_kunmap(adev->gfx.mec.mec_fw_obj);
@@ -1946,75 +1948,81 @@ static int gfx_v12_1_xcc_cp_compute_load_microcode_rs64(struct amdgpu_device *ad
 	amdgpu_bo_unreserve(adev->gfx.mec.mec_fw_obj);
 	amdgpu_bo_unreserve(adev->gfx.mec.mec_fw_data_obj);
 
-	tmp = RREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_CPC_IC_BASE_CNTL);
-	tmp = REG_SET_FIELD(tmp, CP_CPC_IC_BASE_CNTL, VMID, 0);
-	tmp = REG_SET_FIELD(tmp, CP_CPC_IC_BASE_CNTL, EXE_DISABLE, 0);
-	tmp = REG_SET_FIELD(tmp, CP_CPC_IC_BASE_CNTL, CACHE_POLICY, 0);
-	WREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_CPC_IC_BASE_CNTL, tmp);
-
-	tmp = RREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_MEC_DC_BASE_CNTL);
-	tmp = REG_SET_FIELD(tmp, CP_MEC_DC_BASE_CNTL, VMID, 0);
-	tmp = REG_SET_FIELD(tmp, CP_MEC_DC_BASE_CNTL, CACHE_POLICY, 0);
-	WREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_MEC_DC_BASE_CNTL, tmp);
-
-	mutex_lock(&adev->srbm_mutex);
-	for (i = 0; i < adev->gfx.mec.num_pipe_per_mec; i++) {
-		soc_v1_0_grbm_select(adev, 1, i, 0, 0, GET_INST(GC, xcc_id));
+	for_each_inst(xcc_id, xcc_mask) {
+		gfx_v12_1_xcc_cp_compute_enable(adev, false, xcc_id);
 
-		WREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_MEC_MDBASE_LO,
-			     lower_32_bits(adev->gfx.mec.mec_fw_data_gpu_addr +
-					   i * ALIGN(fw_data_size, 64 * 1024)));
-		WREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_MEC_MDBASE_HI,
-			     upper_32_bits(adev->gfx.mec.mec_fw_data_gpu_addr +
-					   i * ALIGN(fw_data_size, 64 * 1024)));
+		tmp = RREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_CPC_IC_BASE_CNTL);
+		tmp = REG_SET_FIELD(tmp, CP_CPC_IC_BASE_CNTL, VMID, 0);
+		tmp = REG_SET_FIELD(tmp, CP_CPC_IC_BASE_CNTL, EXE_DISABLE, 0);
+		tmp = REG_SET_FIELD(tmp, CP_CPC_IC_BASE_CNTL, CACHE_POLICY, 0);
+		WREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_CPC_IC_BASE_CNTL, tmp);
 
-		WREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_CPC_IC_BASE_LO,
-			     lower_32_bits(adev->gfx.mec.mec_fw_gpu_addr));
-		WREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_CPC_IC_BASE_HI,
-			     upper_32_bits(adev->gfx.mec.mec_fw_gpu_addr));
-	}
-	mutex_unlock(&adev->srbm_mutex);
-	soc_v1_0_grbm_select(adev, 0, 0, 0, 0, GET_INST(GC, 0));
+		tmp = RREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_MEC_DC_BASE_CNTL);
+		tmp = REG_SET_FIELD(tmp, CP_MEC_DC_BASE_CNTL, VMID, 0);
+		tmp = REG_SET_FIELD(tmp, CP_MEC_DC_BASE_CNTL, CACHE_POLICY, 0);
+		WREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_MEC_DC_BASE_CNTL, tmp);
 
-	/* Trigger an invalidation of the L1 instruction caches */
-	tmp = RREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_MEC_DC_OP_CNTL);
-	tmp = REG_SET_FIELD(tmp, CP_MEC_DC_OP_CNTL, INVALIDATE_DCACHE, 1);
-	WREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_MEC_DC_OP_CNTL, tmp);
+		mutex_lock(&adev->srbm_mutex);
+		for (i = 0; i < adev->gfx.mec.num_pipe_per_mec; i++) {
+			soc_v1_0_grbm_select(adev, 1, i, 0, 0, GET_INST(GC, xcc_id));
+
+			WREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_MEC_MDBASE_LO,
+					lower_32_bits(adev->gfx.mec.mec_fw_data_gpu_addr +
+									(xcc_id * adev->gfx.mec.num_pipe_per_mec + i) *
+									ALIGN(fw_data_size, 64 * 1024)));
+			WREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_MEC_MDBASE_HI,
+					upper_32_bits(adev->gfx.mec.mec_fw_data_gpu_addr +
+									(xcc_id * adev->gfx.mec.num_pipe_per_mec + i) *
+									ALIGN(fw_data_size, 64 * 1024)));
+
+			WREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_CPC_IC_BASE_LO,
+					lower_32_bits(adev->gfx.mec.mec_fw_gpu_addr));
+			WREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_CPC_IC_BASE_HI,
+					upper_32_bits(adev->gfx.mec.mec_fw_gpu_addr));
+		}
+		mutex_unlock(&adev->srbm_mutex);
+		soc_v1_0_grbm_select(adev, 0, 0, 0, 0, GET_INST(GC, 0));
 
-	/* Wait for invalidation complete */
-	for (i = 0; i < usec_timeout; i++) {
+		/* Trigger an invalidation of the L1 instruction caches */
 		tmp = RREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_MEC_DC_OP_CNTL);
-		if (1 == REG_GET_FIELD(tmp, CP_MEC_DC_OP_CNTL,
-				       INVALIDATE_DCACHE_COMPLETE))
-			break;
-		udelay(1);
-	}
-
-	if (i >= usec_timeout) {
-		dev_err(adev->dev, "failed to invalidate instruction cache\n");
-		return -EINVAL;
-	}
+		tmp = REG_SET_FIELD(tmp, CP_MEC_DC_OP_CNTL, INVALIDATE_DCACHE, 1);
+		WREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_MEC_DC_OP_CNTL, tmp);
+
+		/* Wait for invalidation complete */
+		for (i = 0; i < usec_timeout; i++) {
+			tmp = RREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_MEC_DC_OP_CNTL);
+			if (1 == REG_GET_FIELD(tmp, CP_MEC_DC_OP_CNTL,
+						INVALIDATE_DCACHE_COMPLETE))
+				break;
+			udelay(1);
+		}
 
-	/* Trigger an invalidation of the L1 instruction caches */
-	tmp = RREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_CPC_IC_OP_CNTL);
-	tmp = REG_SET_FIELD(tmp, CP_CPC_IC_OP_CNTL, INVALIDATE_CACHE, 1);
-	WREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_CPC_IC_OP_CNTL, tmp);
+		if (i >= usec_timeout) {
+			dev_err(adev->dev, "failed to invalidate instruction cache\n");
+			return -EINVAL;
+		}
 
-	/* Wait for invalidation complete */
-	for (i = 0; i < usec_timeout; i++) {
+		/* Trigger an invalidation of the L1 instruction caches */
 		tmp = RREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_CPC_IC_OP_CNTL);
-		if (1 == REG_GET_FIELD(tmp, CP_CPC_IC_OP_CNTL,
-				       INVALIDATE_CACHE_COMPLETE))
-			break;
-		udelay(1);
-	}
+		tmp = REG_SET_FIELD(tmp, CP_CPC_IC_OP_CNTL, INVALIDATE_CACHE, 1);
+		WREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_CPC_IC_OP_CNTL, tmp);
+
+		/* Wait for invalidation complete */
+		for (i = 0; i < usec_timeout; i++) {
+			tmp = RREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_CPC_IC_OP_CNTL);
+			if (1 == REG_GET_FIELD(tmp, CP_CPC_IC_OP_CNTL,
+						INVALIDATE_CACHE_COMPLETE))
+				break;
+			udelay(1);
+		}
 
-	if (i >= usec_timeout) {
-		dev_err(adev->dev, "failed to invalidate instruction cache\n");
-		return -EINVAL;
-	}
+		if (i >= usec_timeout) {
+			dev_err(adev->dev, "failed to invalidate instruction cache\n");
+			return -EINVAL;
+		}
 
-	gfx_v12_1_xcc_set_mec_ucode_start_addr(adev, xcc_id);
+		gfx_v12_1_xcc_set_mec_ucode_start_addr(adev, xcc_id);
+	}
 
 	return 0;
 }
@@ -2411,42 +2419,43 @@ static int gfx_v12_1_xcc_kcq_resume(struct amdgpu_device *adev,
 	return r;
 }
 
-static int gfx_v12_1_xcc_cp_resume(struct amdgpu_device *adev,
-				   int xcc_id)
+static int gfx_v12_1_xcc_cp_resume(struct amdgpu_device *adev, uint16_t xcc_mask)
 {
-	int r, i;
+	int r, i, xcc_id;
 	struct amdgpu_ring *ring;
 
-	if (!(adev->flags & AMD_IS_APU))
-		gfx_v12_1_xcc_enable_gui_idle_interrupt(adev, false, xcc_id);
-
 	if (adev->firmware.load_type == AMDGPU_FW_LOAD_DIRECT) {
 		/* legacy firmware loading */
-		r = gfx_v12_1_xcc_cp_compute_load_microcode_rs64(adev, xcc_id);
+		r = gfx_v12_1_xcc_cp_compute_load_microcode_rs64(adev, xcc_mask);
 		if (r)
 			return r;
 	}
 
-	gfx_v12_1_xcc_cp_set_doorbell_range(adev, xcc_id);
+	for_each_inst(xcc_id, xcc_mask) {
+		if (!(adev->flags & AMD_IS_APU))
+			gfx_v12_1_xcc_enable_gui_idle_interrupt(adev, false, xcc_id);
 
-	gfx_v12_1_xcc_cp_compute_enable(adev, true, xcc_id);
+		gfx_v12_1_xcc_cp_set_doorbell_range(adev, xcc_id);
 
-	if (adev->enable_mes_kiq && adev->mes.kiq_hw_init)
-		r = amdgpu_mes_kiq_hw_init(adev, xcc_id);
-	else
-		r = gfx_v12_1_xcc_kiq_resume(adev, xcc_id);
-	if (r)
-		return r;
+		gfx_v12_1_xcc_cp_compute_enable(adev, true, xcc_id);
 
-	r = gfx_v12_1_xcc_kcq_resume(adev, xcc_id);
-	if (r)
-		return r;
+		if (adev->enable_mes_kiq && adev->mes.kiq_hw_init)
+			r = amdgpu_mes_kiq_hw_init(adev, xcc_id);
+		else
+			r = gfx_v12_1_xcc_kiq_resume(adev, xcc_id);
+		if (r)
+			return r;
 
-	for (i = 0; i < adev->gfx.num_compute_rings; i++) {
-		ring = &adev->gfx.compute_ring[i + xcc_id * adev->gfx.num_compute_rings];
-		r = amdgpu_ring_test_helper(ring);
+		r = gfx_v12_1_xcc_kcq_resume(adev, xcc_id);
 		if (r)
 			return r;
+
+		for (i = 0; i < adev->gfx.num_compute_rings; i++) {
+			ring = &adev->gfx.compute_ring[i + xcc_id * adev->gfx.num_compute_rings];
+			r = amdgpu_ring_test_helper(ring);
+			if (r)
+				return r;
+		}
 	}
 
 	return 0;
@@ -3923,14 +3932,9 @@ static int gfx_v12_1_xcp_resume(void *handle, uint32_t inst_mask)
 		}
 	}
 
-	tmp_mask = inst_mask;
-	for_each_inst(i, tmp_mask) {
-		r = gfx_v12_1_xcc_cp_resume(adev, i);
-		if (r)
-			return r;
-	}
+	r = gfx_v12_1_xcc_cp_resume(adev, inst_mask);
 
-	return 0;
+	return r;
 }
 
 static int gfx_v12_1_xcp_suspend(void *handle, uint32_t inst_mask)
-- 
2.52.0

