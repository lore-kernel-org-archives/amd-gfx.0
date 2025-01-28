Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AD80C0218D
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jan 2025 07:52:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE06510E23D;
	Tue, 28 Jan 2025 07:52:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HH+RiqwP";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2052.outbound.protection.outlook.com [40.107.102.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BEA9E10E23D
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Jan 2025 07:52:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yz8IzYM07PfBX1lHG1OWSC8GElTboShX462kz3YELZaPEm2apVIn0SXVccScUOjRsSxAwXOnhWL2zyhV/8TCgDPE36NGtMBHwjp9kG9SV0ElUQDJohF+lGbYhitY1MbsDfi6Sxbi0DjDslQGskeZpPV/T2BmAdMC+mfzAFl+d2wieiVESssV13EwlFGl9lUpOh21DozD2O3FdnDQSk7Aauk46TtFvbZxNC9gguQDLfLtiSUphOPsfGAfObQ6KQj9oM9yNn5dG+PSbIcCFenAvhtuX7Xe+Lo/1wabNX4OqrUjcssl1JVJmQk7DUgWwuagaJL96gqWeiHdckqWhMarzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iepXjQgVQvINMJ+2OQsHHMgROqc1Qu1EVXgXYTxG3yQ=;
 b=vl+CrxDyjdYqKd8FTU70gqN6efzKQMEnzbrG5WxP3MCEYOCLHotp3mxbVnV0SU32ZEBToeB1ye//LsRalaCloYnRpQHF1QYHPPDdS97L4sr/8hb/ectlWS9WCyzWRXaboomAaBtIzyZugopUFb8iYL8owe9pO5NpBx2g7rF85Floi8p+5k4UjFkrwfLHEew+x9O5lEQnWNSP3AwZUosy5g4QYYgA9RgZ7WSM2jvIkeoR0PLQstUO1MIl9FG7lqpjNf52sJIYS3TAKvMu9I7b8mh5DT2Xb1zM39sWTa/nA1CYXIUBPWVaH6vXvbTkDSl482vJ2mQyiRgpni3VinutQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iepXjQgVQvINMJ+2OQsHHMgROqc1Qu1EVXgXYTxG3yQ=;
 b=HH+RiqwPdYJGtYjE3WTqIczXbN3xP+HJC8MzPd7E5gpatJsh98N3uIFjL5MJf8mOi7Aq3V3DfEtyFUmKuqbIWhWHQ0miUCkCZJ89PvmX3SHl9vHaJNYAoc+/7U0n/gVAUi5YnfqU/ca7VaB522krw97pyIHAftoGlmguMYaldiQ=
Received: from BN9PR03CA0076.namprd03.prod.outlook.com (2603:10b6:408:fc::21)
 by SA3PR12MB8801.namprd12.prod.outlook.com (2603:10b6:806:312::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.23; Tue, 28 Jan
 2025 07:52:26 +0000
Received: from BL6PEPF0001AB53.namprd02.prod.outlook.com
 (2603:10b6:408:fc:cafe::4b) by BN9PR03CA0076.outlook.office365.com
 (2603:10b6:408:fc::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8377.25 via Frontend Transport; Tue,
 28 Jan 2025 07:52:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB53.mail.protection.outlook.com (10.167.241.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Tue, 28 Jan 2025 07:52:25 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 28 Jan
 2025 01:52:23 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Asad.Kamal@amd.com>, <Le.Ma@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: Clean up GFX v9.4.3 IP version checks
Date: Tue, 28 Jan 2025 13:22:06 +0530
Message-ID: <20250128075207.1695418-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB53:EE_|SA3PR12MB8801:EE_
X-MS-Office365-Filtering-Correlation-Id: 96e3d57d-e6f4-41ef-67c3-08dd3f70b493
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Vpyk88jzGOtMVJgDDCDDU0gfcz8SvRj05uE8ltwZmQ2l1zGo29NqrvjcGCA3?=
 =?us-ascii?Q?jIEttKWttwIMIfuLCHIiqOgWvrePsshPZh6M1w6zgB5/Dem1283KrzcTH/Sg?=
 =?us-ascii?Q?2Cg60qWD1PUNwPtdq4qPXQ5SXkseycxNOPKdviPRxNQbC+bTVLAOW5ipcY2S?=
 =?us-ascii?Q?sv1Fsjx9C12r7vofsSfxDWiOcoCOlu9l3dw3POpQoPpV97vpDvtes3fqJkdt?=
 =?us-ascii?Q?vD807wK3mCZB4JU5di2/7/Yz4B9oTalSWayt/RD8QZB6n2lURD5Izj1klIWL?=
 =?us-ascii?Q?0m8itljw0GuwoADIjikrQbtgoNDchNY36mLXKg49ayJwVMwGfcb5EQI4iuTb?=
 =?us-ascii?Q?CdK/OH7sGoRE5J+yi9E2IO6LUoJEQQT5x2VID16hVZSO6+GiQEZzurcowJ/s?=
 =?us-ascii?Q?i4gqxXrIANPXj5WU13a5qUmlimILcUyisfMzR6ADvfMB+mdCm0ObSRqVJqlm?=
 =?us-ascii?Q?g+YdXxASwaN5pCdJN0MbNOo84ht9FeT+KsKnNOyReus/kBvP9wCVHBnvFZwA?=
 =?us-ascii?Q?2tJarqok4eMLWkpRVQ/PD5K5KIYJ2giR7qbsLRJURrrMmeLzaLvDV5SWx1au?=
 =?us-ascii?Q?bK79QvWB6a3fKJx2eUMF6geaqg+YPjhFqcwy+CiO/qXwWAy7uJa4npErF34y?=
 =?us-ascii?Q?Rw6SWhVbCYA7lBkIHblH7x/a1wGGNJvESZHeHp6PgYjjUmVpCfvMS8H1e6JL?=
 =?us-ascii?Q?CY8h4F1hJ5W0bgjY+VpzYH9DXtD55/VkWn2AgG10PFLlrL85Zsmr6gYcEIMT?=
 =?us-ascii?Q?+hFpejYs+B+yhgDS5j5CZhCnYS7f0aaHdZTPmUQechfwxcH65PhrGyHpjP1F?=
 =?us-ascii?Q?1j1SBNwnGPChRskuD7PT3NsXfwBnN42CcK/JbZnqdkgteiNG0yl8LDx+/Zgh?=
 =?us-ascii?Q?gRd9Yi8+oVmdL8YLcwpeLVyydKYX4SvGcg+Zqst5cdW/HMAizbnvEEMrHOG+?=
 =?us-ascii?Q?SdmCH2dRsZUpNLuuX0zwdQzusCKIDdQbxOxaj32lvjrepxUUq5FZk+HHWoNU?=
 =?us-ascii?Q?7NOFQxddcR4xGSEHE8Yq3sYvgR606WgvqVr9lEN6MlFYRPytaEMBBFeYqWr0?=
 =?us-ascii?Q?bulwzfGDJbDGAU13rPsE8SCodlmKjUzZ9c2xXg1pLgmkBbMUqVor0M1gCQg+?=
 =?us-ascii?Q?x+s7fQaPDcf3IquaDIyb8Vcxp0WN2X9MIhMtrH0q+gG5Qh4diHaYeLRXSjp9?=
 =?us-ascii?Q?eRikfmdVDM4Yv2ziB9fZJ/VxwyxypORW8zPKOvfLa09M/s3lDNdJ1NwIGZ/K?=
 =?us-ascii?Q?iCIxVTS3LE2wtRkMjgWv8O1g/tfZ/M85l55I8kzbZ7trWeTmtMMqJZdeGFfa?=
 =?us-ascii?Q?hu8MLalP0YYcwx+1uVYAIHUf84roYbRAtomXsQComqJdGpPsouflJv2JYVNT?=
 =?us-ascii?Q?yPxyte2tlcBdb3BGVb2w5jjHPA3B7/LERIiRsbeLQZHAqBJZbMT1ahR1aA+r?=
 =?us-ascii?Q?qaa2UN18wo8giYLoBcf0h/0/Iuy0969gDAQOcj1CRbfuL580SnW1G+RfAEaq?=
 =?us-ascii?Q?zeLvkbqRMuJmvCw=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2025 07:52:25.4299 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 96e3d57d-e6f4-41ef-67c3-08dd3f70b493
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB53.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8801
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

Remove unnecessary IP version checks for GFX 9.4.3 and similar variants.
Wrap checks inside meaningful function.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c  | 68 ++++++------------------
 drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c | 22 ++++----
 2 files changed, 29 insertions(+), 61 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index 2ba185875baa..f4635fc8a7ca 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -942,21 +942,12 @@ static int gfx_v9_4_3_gpu_early_init(struct amdgpu_device *adev)
 	adev->gfx.funcs = &gfx_v9_4_3_gfx_funcs;
 	adev->gfx.ras = &gfx_v9_4_3_ras;
 
-	switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
-	case IP_VERSION(9, 4, 3):
-	case IP_VERSION(9, 4, 4):
-	case IP_VERSION(9, 5, 0):
-		adev->gfx.config.max_hw_contexts = 8;
-		adev->gfx.config.sc_prim_fifo_size_frontend = 0x20;
-		adev->gfx.config.sc_prim_fifo_size_backend = 0x100;
-		adev->gfx.config.sc_hiz_tile_fifo_size = 0x30;
-		adev->gfx.config.sc_earlyz_tile_fifo_size = 0x4C0;
-		gb_addr_config = RREG32_SOC15(GC, GET_INST(GC, 0), regGB_ADDR_CONFIG);
-		break;
-	default:
-		BUG();
-		break;
-	}
+	adev->gfx.config.max_hw_contexts = 8;
+	adev->gfx.config.sc_prim_fifo_size_frontend = 0x20;
+	adev->gfx.config.sc_prim_fifo_size_backend = 0x100;
+	adev->gfx.config.sc_hiz_tile_fifo_size = 0x30;
+	adev->gfx.config.sc_earlyz_tile_fifo_size = 0x4C0;
+	gb_addr_config = RREG32_SOC15(GC, GET_INST(GC, 0), regGB_ADDR_CONFIG);
 
 	adev->gfx.config.gb_addr_config = gb_addr_config;
 
@@ -2795,16 +2786,10 @@ static int gfx_v9_4_3_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 		return 0;
 
 	num_xcc = NUM_XCC(adev->gfx.xcc_mask);
-	switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
-	case IP_VERSION(9, 4, 3):
-	case IP_VERSION(9, 4, 4):
-		for (i = 0; i < num_xcc; i++)
-			gfx_v9_4_3_xcc_update_gfx_clock_gating(
-				adev, state == AMD_CG_STATE_GATE, i);
-		break;
-	default:
-		break;
-	}
+	for (i = 0; i < num_xcc; i++)
+		gfx_v9_4_3_xcc_update_gfx_clock_gating(
+			adev, state == AMD_CG_STATE_GATE, i);
+
 	return 0;
 }
 
@@ -4867,34 +4852,13 @@ static void gfx_v9_4_3_set_rlc_funcs(struct amdgpu_device *adev)
 
 static void gfx_v9_4_3_set_gds_init(struct amdgpu_device *adev)
 {
-	/* init asci gds info */
-	switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
-	case IP_VERSION(9, 4, 3):
-	case IP_VERSION(9, 4, 4):
-	case IP_VERSION(9, 5, 0):
-		/* 9.4.3 removed all the GDS internal memory,
-		 * only support GWS opcode in kernel, like barrier
-		 * semaphore.etc */
-		adev->gds.gds_size = 0;
-		break;
-	default:
-		adev->gds.gds_size = 0x10000;
-		break;
-	}
-
-	switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
-	case IP_VERSION(9, 4, 3):
-	case IP_VERSION(9, 4, 4):
-	case IP_VERSION(9, 5, 0):
-		/* deprecated for 9.4.3, no usage at all */
-		adev->gds.gds_compute_max_wave_id = 0;
-		break;
-	default:
-		/* this really depends on the chip */
-		adev->gds.gds_compute_max_wave_id = 0x7ff;
-		break;
-	}
+	/* 9.4.3 variants removed all the GDS internal memory,
+	 * only support GWS opcode in kernel, like barrier
+	 * semaphore.etc */
 
+	/* init asic gds info */
+	adev->gds.gds_size = 0;
+	adev->gds.gds_compute_max_wave_id = 0;
 	adev->gds.gws_size = 64;
 	adev->gds.oa_size = 16;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
index 5470cef7e9bd..cb25f7f0dfc1 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
@@ -313,6 +313,16 @@ gfxhub_v1_2_xcc_disable_identity_aperture(struct amdgpu_device *adev,
 	}
 }
 
+static inline bool
+gfxhub_v1_2_per_process_xnack_support(struct amdgpu_device *adev)
+{
+	/*
+	 * TODO: Check if this function is really needed, so far only 9.4.3
+	 * variants use GFXHUB 1.2
+	 */
+	return !!adev->aid_mask;
+}
+
 static void gfxhub_v1_2_xcc_setup_vmid_config(struct amdgpu_device *adev,
 					      uint32_t xcc_mask)
 {
@@ -355,7 +365,7 @@ static void gfxhub_v1_2_xcc_setup_vmid_config(struct amdgpu_device *adev,
 					    PAGE_TABLE_BLOCK_SIZE,
 					    block_size);
 			/* Send no-retry XNACK on fault to suppress VM fault storm.
-			 * On 9.4.2 and 9.4.3, XNACK can be enabled in
+			 * On 9.4.3 variants, XNACK can be enabled in
 			 * the SQ per-process.
 			 * Retry faults need to be enabled for that to work.
 			 */
@@ -363,14 +373,8 @@ static void gfxhub_v1_2_xcc_setup_vmid_config(struct amdgpu_device *adev,
 				tmp, VM_CONTEXT1_CNTL,
 				RETRY_PERMISSION_OR_INVALID_PAGE_FAULT,
 				!adev->gmc.noretry ||
-					amdgpu_ip_version(adev, GC_HWIP, 0) ==
-						IP_VERSION(9, 4, 2) ||
-					amdgpu_ip_version(adev, GC_HWIP, 0) ==
-						IP_VERSION(9, 4, 3) ||
-					amdgpu_ip_version(adev, GC_HWIP, 0) ==
-						IP_VERSION(9, 4, 4) ||
-					amdgpu_ip_version(adev, GC_HWIP, 0) ==
-						IP_VERSION(9, 5, 0));
+					gfxhub_v1_2_per_process_xnack_support(
+						adev));
 			WREG32_SOC15_OFFSET(GC, GET_INST(GC, j), regVM_CONTEXT1_CNTL,
 					    i * hub->ctx_distance, tmp);
 			WREG32_SOC15_OFFSET(GC, GET_INST(GC, j),
-- 
2.25.1

