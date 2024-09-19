Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5912CF3963
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Sep 2024 17:43:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9742610E73C;
	Thu, 19 Sep 2024 17:43:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bgZT/5BZ";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2077.outbound.protection.outlook.com [40.107.243.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 14BAB10E73C
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Sep 2024 17:43:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VrfRs3geec9Jwj20oiX6onioLsoolBnvIO3xaFVMGXpeGlfmHU+ai8c84Vlomh11tv1IDOk3cy+N0R4lm+wERQ1vxiqCahjYv4Wv8ZINTcO3sxE+KH1AOSCLKkPGQeWJ0Rc3UuDeF3j/3h8Li9K9ZaTrhOsud97t9sDVPQxy4LiwCYyvQfSPS/htJOCnuWfJ4sA9fj577pqgl3uh4vNHWghkNdp9DajpehRpJDU3xwWd0SYfaF7gl+cWtpBQXb6ekOripCkWqFLxXZfcILsk26xvyyguEsjmZXQbgBAJ+HVzib6kta8V9yv0MHrAWX1E0YRS+ODBT0WbaFlzmzP9nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hx88p2jGFApRM/vM2MnwxXcqWleJ4s0YqnrzRj7IvkE=;
 b=IpHVjqFuDf7KuAzt03I6uPPXja3BaJANVplTMIaPDlnGuKG7VjwYH3DkxDh6Ta6RHRZBpYzJAkz63PGBzIeqWOpzNi44ps1/+cfkkgoDJgaHKXvUeCu8bonxtcNPtTl2F/dFVxNTl1U0JpwOPEIh6l+qEXgRUz4fFT2waNvaNa6yjmAJbV/+zMkfd9RbEOk6IN7A3nhPKUHPhcpClzhc3asNpAHhxsrNqzK9AFTtla66vSzh64cru0M+la2sQNZ0HPrHLGUr79+n6R06wVI3z0NvGxW/3sX+o8NVzskQb0xE0hZJzvK27qnN4H0IGXMgzcmYLdVOAVs3tcqXifYFRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hx88p2jGFApRM/vM2MnwxXcqWleJ4s0YqnrzRj7IvkE=;
 b=bgZT/5BZoakLxGfx8TcJpe08bUyNHNyRDD/VW7Xe6dK2tS+dz4pKf8RdEjfuFE9ScGUYk3dw77xdy0o5NN4Vi8zQOGwmp74VPvyz/261kUO3k63SevndTMqu1qnYPZHKKEVcr/mcQkoU3LldgXMgwlUv1GxbQ94sMnJFJcZerF4=
Received: from BN0PR04CA0201.namprd04.prod.outlook.com (2603:10b6:408:e9::26)
 by SJ0PR12MB6880.namprd12.prod.outlook.com (2603:10b6:a03:485::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.22; Thu, 19 Sep
 2024 17:43:51 +0000
Received: from BN2PEPF000044A6.namprd04.prod.outlook.com
 (2603:10b6:408:e9:cafe::49) by BN0PR04CA0201.outlook.office365.com
 (2603:10b6:408:e9::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.26 via Frontend
 Transport; Thu, 19 Sep 2024 17:43:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044A6.mail.protection.outlook.com (10.167.243.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Thu, 19 Sep 2024 17:43:50 +0000
Received: from mukjoshi-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 19 Sep
 2024 12:43:50 -0500
From: Mukul Joshi <mukul.joshi@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <harish.kasiviswanathan@amd.com>, Mukul Joshi <mukul.joshi@amd.com>
Subject: [PATCH] drm/amdkfd: Fix CU occupancy calculations for GFX 9.4.3
Date: Thu, 19 Sep 2024 13:43:26 -0400
Message-ID: <20240919174326.4587-1-mukul.joshi@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A6:EE_|SJ0PR12MB6880:EE_
X-MS-Office365-Filtering-Correlation-Id: 94a6cc72-8e28-4c44-63c4-08dcd8d29f6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?U/sKGdrfB+w4z1ZARpGY2uj5FiuKAAdnQEMm5vrilocLyvzlKelAyc+yhZMa?=
 =?us-ascii?Q?UKAFF4UJH8MoFlqKpb8G7IRlcc0eyaSaLNGSfFxn7ukBUoSuYT80m6Yadus7?=
 =?us-ascii?Q?ARp3DAq/NxYmqMr0FudvFZiK/0T9oPZ8yg+Dh70VsQcVwTQnCmw4tIPPsPJx?=
 =?us-ascii?Q?ZsdQhe1QMJ4F82bBm6fpySd0YmwIu0rEJEHlqqheWipe2bWHysmDKbDHjFhb?=
 =?us-ascii?Q?oIVosKXEa+Kvf5MZVywC5VrwxySKNbk6YLTCnJ/zd/Yw9BQSqwOBtsG9PBtT?=
 =?us-ascii?Q?7r1hwBLntveRO+anlpgjHTkdZh1jtsAejvkRwHGTHc/peAj10B6xPbKoXrsY?=
 =?us-ascii?Q?DVtkFBnK2sROPjsOog0xxZic1iEuqRw4uqWzPEbA5h/T1k42vEt0sDpuXZsa?=
 =?us-ascii?Q?Z+SQRGN5qzuJll0mfd/+cYlFfK3z3FM5PyFjqt7zzfyplYtUq2nNgyazwVQs?=
 =?us-ascii?Q?ABg6DrCDYpm5EVVSy5GQ8YjDMM+eTVMgX0cOmH2f3mwHBh75okvrVA5ZeIeh?=
 =?us-ascii?Q?Y4n2WC8f0T+ocKL5m8bX+/vxuQljsBhZR58uYK0ZhfoCjY/CQnX/R//cfgpn?=
 =?us-ascii?Q?tqajq61hcyMtkLl3LdV2YhSfeJBa1QkF0LLSW54zYjLNYTL2Ds6DDCutgwfV?=
 =?us-ascii?Q?2gXlqZ7xV9ya388dS7w6qYA1g5GOcBp0XbFcrdYwks44MUBCIcc/mvYgmfxL?=
 =?us-ascii?Q?CaL+poSvQ5OC3Rrmjfmp4tBu7zm27VRP7UQ8wuhLyLDmji1lnTGiq4MvKyLR?=
 =?us-ascii?Q?v5RzVeli+/bstn6ce+XBOkEe0gsndynvI6TFXO5iwNC2jjKr/KmcaLK4kyAo?=
 =?us-ascii?Q?9H2yDsisCdx0CjUFVgLb3M7XWjmzQbjY/mNyzWHl6Fq1w3/tDDfIPqkiTUVB?=
 =?us-ascii?Q?9DIdiPPu75WfA540lbSh6qgVvnBj5BpEvyT02SnxfxvgcNw65wyOGgbE27lJ?=
 =?us-ascii?Q?uXJT9fz1dlEK40fC2fMOeO0e4K2JcfbK4J42FZUrgKazrnF2P2DtDSYr9FMn?=
 =?us-ascii?Q?jFA4gg8hrMnMqPJVXRAqc6cge9NMGLvPXSE00mtJqBu5O77vvUzaJiI4T+WJ?=
 =?us-ascii?Q?FqjrlkQw7Rp+3PfUeHjuHM5hETS7wgL7c0R+5xQKpsJ2vh9Das+Zwo2QLhKL?=
 =?us-ascii?Q?FoHj2Dc45+E/zb+NmggDWpcU9uoJthh2TpNVBVUIA+/bP7bnYHBI5E2PAy+e?=
 =?us-ascii?Q?rwoF6tTbnVz7CEdetW74On8lV9k0MjLYbLsnSEBF4GMEHokIm52LjA3eOvpT?=
 =?us-ascii?Q?mjQ+YVRLSczbh/WFTq0fUWKKZlZsbEaOUvPe/2lz0gHId5dsqwWPYuMnejCJ?=
 =?us-ascii?Q?ZBHQFFPletpbQVpZ58DDOZEaJowzBj+eOJ6KbVBHCaZpUpbxf4zSO4dKBb8Q?=
 =?us-ascii?Q?a3PsNgi2YDZmgsS2YWbHf6etiDIcBZB5v+9zZVnt0Q1+8el8JLhZKjoYYAZ5?=
 =?us-ascii?Q?aBwIF7yteDoX6pInHl/iQ3Qlrcv88+5C?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2024 17:43:50.8555 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 94a6cc72-8e28-4c44-63c4-08dcd8d29f6c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6880
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

Make CU occupancy work on GFX 9.4.3 by updating the code
to handle multiple XCCs correctly. Additionally, update
the algorithm to calculate CU occupancy by matching
dorrbell offset of the queue against the process's queues,
instead of using the IH_VMID_X_LUT registers since that can
be racy with CP updating the VMID-PASID mapping.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c | 92 ++++++++-----------
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h |  5 +-
 .../drm/amd/amdkfd/kfd_device_queue_manager.c | 20 ++++
 .../drm/amd/amdkfd/kfd_device_queue_manager.h |  3 +
 drivers/gpu/drm/amd/amdkfd/kfd_process.c      | 18 +++-
 .../gpu/drm/amd/include/kgd_kfd_interface.h   | 10 +-
 6 files changed, 88 insertions(+), 60 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
index 1254a43ec96b..b8c01257b101 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
@@ -950,28 +950,30 @@ static void unlock_spi_csq_mutexes(struct amdgpu_device *adev)
  * @inst: xcc's instance number on a multi-XCC setup
  */
 static void get_wave_count(struct amdgpu_device *adev, int queue_idx,
-		int *wave_cnt, int *vmid, uint32_t inst)
+		struct kfd_cu_occupancy *queue_cnt, uint32_t inst)
 {
 	int pipe_idx;
 	int queue_slot;
 	unsigned int reg_val;
-
+	unsigned int wave_cnt;
 	/*
 	 * Program GRBM with appropriate MEID, PIPEID, QUEUEID and VMID
 	 * parameters to read out waves in flight. Get VMID if there are
 	 * non-zero waves in flight.
 	 */
-	*vmid = 0xFF;
-	*wave_cnt = 0;
 	pipe_idx = queue_idx / adev->gfx.mec.num_queue_per_pipe;
 	queue_slot = queue_idx % adev->gfx.mec.num_queue_per_pipe;
-	soc15_grbm_select(adev, 1, pipe_idx, queue_slot, 0, inst);
-	reg_val = RREG32_SOC15_IP(GC, SOC15_REG_OFFSET(GC, inst, mmSPI_CSQ_WF_ACTIVE_COUNT_0) +
-			 queue_slot);
-	*wave_cnt = reg_val & SPI_CSQ_WF_ACTIVE_COUNT_0__COUNT_MASK;
-	if (*wave_cnt != 0)
-		*vmid = (RREG32_SOC15(GC, inst, mmCP_HQD_VMID) &
-			 CP_HQD_VMID__VMID_MASK) >> CP_HQD_VMID__VMID__SHIFT;
+	soc15_grbm_select(adev, 1, pipe_idx, queue_slot, 0, GET_INST(GC, inst));
+	reg_val = RREG32_SOC15_IP(GC, SOC15_REG_OFFSET(GC, GET_INST(GC, inst),
+				  mmSPI_CSQ_WF_ACTIVE_COUNT_0) + queue_slot);
+	wave_cnt = reg_val & SPI_CSQ_WF_ACTIVE_COUNT_0__COUNT_MASK;
+	if (wave_cnt != 0) {
+		queue_cnt->wave_cnt += wave_cnt;
+		queue_cnt->doorbell_off =
+			(RREG32_SOC15(GC, GET_INST(GC, inst), mmCP_HQD_PQ_DOORBELL_CONTROL) &
+			 CP_HQD_PQ_DOORBELL_CONTROL__DOORBELL_OFFSET_MASK) >>
+			 CP_HQD_PQ_DOORBELL_CONTROL__DOORBELL_OFFSET__SHIFT;
+	}
 }
 
 /**
@@ -1021,24 +1023,19 @@ static void get_wave_count(struct amdgpu_device *adev, int queue_idx,
  *
  *  Reading registers referenced above involves programming GRBM appropriately
  */
-void kgd_gfx_v9_get_cu_occupancy(struct amdgpu_device *adev, int pasid,
-		int *pasid_wave_cnt, int *max_waves_per_cu, uint32_t inst)
+void kgd_gfx_v9_get_cu_occupancy(struct amdgpu_device *adev,
+				 struct kfd_cu_occupancy *cu_occupancy,
+				 int *max_waves_per_cu, uint32_t inst)
 {
 	int qidx;
-	int vmid;
 	int se_idx;
-	int sh_idx;
 	int se_cnt;
-	int sh_cnt;
-	int wave_cnt;
 	int queue_map;
-	int pasid_tmp;
 	int max_queue_cnt;
-	int vmid_wave_cnt = 0;
 	DECLARE_BITMAP(cp_queue_bitmap, AMDGPU_MAX_QUEUES);
 
 	lock_spi_csq_mutexes(adev);
-	soc15_grbm_select(adev, 1, 0, 0, 0, inst);
+	soc15_grbm_select(adev, 1, 0, 0, 0, GET_INST(GC, inst));
 
 	/*
 	 * Iterate through the shader engines and arrays of the device
@@ -1048,51 +1045,38 @@ void kgd_gfx_v9_get_cu_occupancy(struct amdgpu_device *adev, int pasid,
 			  AMDGPU_MAX_QUEUES);
 	max_queue_cnt = adev->gfx.mec.num_pipe_per_mec *
 			adev->gfx.mec.num_queue_per_pipe;
-	sh_cnt = adev->gfx.config.max_sh_per_se;
 	se_cnt = adev->gfx.config.max_shader_engines;
 	for (se_idx = 0; se_idx < se_cnt; se_idx++) {
-		for (sh_idx = 0; sh_idx < sh_cnt; sh_idx++) {
+		amdgpu_gfx_select_se_sh(adev, se_idx, 0, 0xffffffff, inst);
+		queue_map = RREG32_SOC15(GC, GET_INST(GC, inst), mmSPI_CSQ_WF_ACTIVE_STATUS);
+
+		/*
+		 * Assumption: queue map encodes following schema: four
+		 * pipes per each micro-engine, with each pipe mapping
+		 * eight queues. This schema is true for GFX9 devices
+		 * and must be verified for newer device families
+		 */
+		for (qidx = 0; qidx < max_queue_cnt; qidx++) {
+			/* Skip qeueus that are not associated with
+			 * compute functions
+			 */
+			if (!test_bit(qidx, cp_queue_bitmap))
+				continue;
 
-			amdgpu_gfx_select_se_sh(adev, se_idx, sh_idx, 0xffffffff, inst);
-			queue_map = RREG32_SOC15(GC, inst, mmSPI_CSQ_WF_ACTIVE_STATUS);
+			if (!(queue_map & (1 << qidx)))
+				continue;
 
-			/*
-			 * Assumption: queue map encodes following schema: four
-			 * pipes per each micro-engine, with each pipe mapping
-			 * eight queues. This schema is true for GFX9 devices
-			 * and must be verified for newer device families
-			 */
-			for (qidx = 0; qidx < max_queue_cnt; qidx++) {
-
-				/* Skip qeueus that are not associated with
-				 * compute functions
-				 */
-				if (!test_bit(qidx, cp_queue_bitmap))
-					continue;
-
-				if (!(queue_map & (1 << qidx)))
-					continue;
-
-				/* Get number of waves in flight and aggregate them */
-				get_wave_count(adev, qidx, &wave_cnt, &vmid,
-						inst);
-				if (wave_cnt != 0) {
-					pasid_tmp =
-					  RREG32(SOC15_REG_OFFSET(OSSSYS, inst,
-						 mmIH_VMID_0_LUT) + vmid);
-					if (pasid_tmp == pasid)
-						vmid_wave_cnt += wave_cnt;
-				}
-			}
+			/* Get number of waves in flight and aggregate them */
+			get_wave_count(adev, qidx, &cu_occupancy[qidx],
+					inst);
 		}
 	}
 
 	amdgpu_gfx_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff, inst);
-	soc15_grbm_select(adev, 0, 0, 0, 0, inst);
+	soc15_grbm_select(adev, 0, 0, 0, 0, GET_INST(GC, inst));
 	unlock_spi_csq_mutexes(adev);
 
 	/* Update the output parameters and return */
-	*pasid_wave_cnt = vmid_wave_cnt;
 	*max_waves_per_cu = adev->gfx.cu_info.simd_per_cu *
 				adev->gfx.cu_info.max_waves_per_simd;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h
index 988c50ac3be0..b6a91a552aa4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h
@@ -52,8 +52,9 @@ bool kgd_gfx_v9_get_atc_vmid_pasid_mapping_info(struct amdgpu_device *adev,
 					uint8_t vmid, uint16_t *p_pasid);
 void kgd_gfx_v9_set_vm_context_page_table_base(struct amdgpu_device *adev,
 			uint32_t vmid, uint64_t page_table_base);
-void kgd_gfx_v9_get_cu_occupancy(struct amdgpu_device *adev, int pasid,
-		int *pasid_wave_cnt, int *max_waves_per_cu, uint32_t inst);
+void kgd_gfx_v9_get_cu_occupancy(struct amdgpu_device *adev,
+				 struct kfd_cu_occupancy *cu_occupancy,
+				 int *max_waves_per_cu, uint32_t inst);
 void kgd_gfx_v9_program_trap_handler_settings(struct amdgpu_device *adev,
 		uint32_t vmid, uint64_t tba_addr, uint64_t tma_addr,
 		uint32_t inst);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 71b465f8d83e..784d155d8bcc 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -3540,6 +3540,26 @@ int debug_refresh_runlist(struct device_queue_manager *dqm)
 	return debug_map_and_unlock(dqm);
 }
 
+bool kfd_dqm_find_queue_by_doorbell_off(struct device_queue_manager *dqm,
+					struct qcm_process_device *qpd,
+					int doorbell_off)
+{
+	struct queue *q;
+	bool r = false;
+
+	dqm_lock(dqm);
+
+	list_for_each_entry(q, &qpd->queues_list, list) {
+		if (q->properties.doorbell_off == doorbell_off) {
+			r = true;
+			goto out;
+		}
+	}
+
+out:
+	dqm_unlock(dqm);
+	return r;
+}
 #if defined(CONFIG_DEBUG_FS)
 
 static void seq_reg_dump(struct seq_file *m,
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
index 08b40826ad1e..e5951589e5bd 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
@@ -324,6 +324,9 @@ void set_queue_snapshot_entry(struct queue *q,
 int debug_lock_and_unmap(struct device_queue_manager *dqm);
 int debug_map_and_unlock(struct device_queue_manager *dqm);
 int debug_refresh_runlist(struct device_queue_manager *dqm);
+bool kfd_dqm_find_queue_by_doorbell_off(struct device_queue_manager *dqm,
+					struct qcm_process_device *qpd,
+					int doorbell_off);
 
 static inline unsigned int get_sh_mem_bases_32(struct kfd_process_device *pdd)
 {
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index a902950cc060..6720bd30517b 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -270,6 +270,10 @@ static int kfd_get_cu_occupancy(struct attribute *attr, char *buffer)
 	struct kfd_node *dev = NULL;
 	struct kfd_process *proc = NULL;
 	struct kfd_process_device *pdd = NULL;
+	int i;
+	struct kfd_cu_occupancy cu_occupancy[AMDGPU_MAX_QUEUES];
+
+	memset(cu_occupancy, 0x0, sizeof(struct kfd_cu_occupancy) * AMDGPU_MAX_QUEUES);
 
 	pdd = container_of(attr, struct kfd_process_device, attr_cu_occupancy);
 	dev = pdd->dev;
@@ -287,9 +291,19 @@ static int kfd_get_cu_occupancy(struct attribute *attr, char *buffer)
 	/* Collect wave count from device if it supports */
 	wave_cnt = 0;
 	max_waves_per_cu = 0;
-	dev->kfd2kgd->get_cu_occupancy(dev->adev, proc->pasid, &wave_cnt,
-			&max_waves_per_cu, 0);
 
+	dev->kfd2kgd->get_cu_occupancy(dev->adev, cu_occupancy,
+			&max_waves_per_cu, ffs(dev->xcc_mask) - 1);
+
+	for (i = 0; i < AMDGPU_MAX_QUEUES; i++) {
+		if (cu_occupancy[i].wave_cnt != 0 &&
+		    kfd_dqm_find_queue_by_doorbell_off(dev->dqm, &pdd->qpd,
+						cu_occupancy[i].doorbell_off))
+			wave_cnt += cu_occupancy[i].wave_cnt;
+	}
+
+	/* Update wave_cnt for the number of XCCs in the partition */
+	wave_cnt *= NUM_XCC(dev->xcc_mask);
 	/* Translate wave count to number of compute units */
 	cu_cnt = (wave_cnt + (max_waves_per_cu - 1)) / max_waves_per_cu;
 	return snprintf(buffer, PAGE_SIZE, "%d\n", cu_cnt);
diff --git a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h b/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
index 7744ca3ef4b1..e3e635a31b8a 100644
--- a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
@@ -71,6 +71,11 @@ enum kgd_memory_pool {
 	KGD_POOL_FRAMEBUFFER = 3,
 };
 
+struct kfd_cu_occupancy {
+	u32 wave_cnt;
+	u32 doorbell_off;
+};
+
 /**
  * enum kfd_sched_policy
  *
@@ -313,8 +318,9 @@ struct kfd2kgd_calls {
 			uint32_t grace_period,
 			uint32_t *reg_offset,
 			uint32_t *reg_data);
-	void (*get_cu_occupancy)(struct amdgpu_device *adev, int pasid,
-			int *wave_cnt, int *max_waves_per_cu, uint32_t inst);
+	void (*get_cu_occupancy)(struct amdgpu_device *adev,
+				 struct kfd_cu_occupancy *cu_occupancy,
+				 int *max_waves_per_cu, uint32_t inst);
 	void (*program_trap_handler_settings)(struct amdgpu_device *adev,
 			uint32_t vmid, uint64_t tba_addr, uint64_t tma_addr,
 			uint32_t inst);
-- 
2.35.1

