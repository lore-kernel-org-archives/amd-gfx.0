Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C61B6CDB470
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Jun 2026 06:07:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D2D310E021;
	Wed, 24 Jun 2026 06:07:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="efdvWaY/";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012031.outbound.protection.outlook.com [52.101.53.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A197610E021
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Jun 2026 06:07:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BVb9ioey21RltgFY72yCB94qcJDVfXzj+2ZWk+ympIWRnxqv5+6CYhrjL7Lvk4+SdBXdkE+EM+OcEqjFqvvaFVn50dpIQdFxmqXqzNAxINRB1LLBiKVwxBtgKFYEGEnIlJE6Ku+qGCdXfHWB5nHXNAnVaOcHPN4W51ON8tu4i1nanREG2zPnB7pdtNer/m75DV4fczqXnwNnvWLr+wQYvofSOD4nIsmr3BriHerpDcY0GXPmZXM6fm/g2CdgSzUXKBod7jcMyK3++ZjcdKBOyeMHkFQrNsCvXgVHkRjSKPoMpGDJG2NYbJLATbZIMd2m2iDPrKJc2Ccy6pEgEvpOhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DGvfyInMneX7Ehx5cQd9GLv8QdMHNK5xm3gFZX7eTv0=;
 b=L11hq0rqMM5MSsa/PXV9A8Gbenmt674xdfzHdsTslqEcB27QabcX4o+pI8VCZ6aX2rbX4p2gZ7V/OiB7c0MooicymkgdHmeWEMjW8OlKPjzvbiNALzlDHBz0lVMruSh8HRKsFWnCiD9gWwqVkM+tNLQAqAlJmA4IDCfFALRGsBtJBB77onFQyBSoJTV8PNUc2LUjxGNc/D9RelkJDMmA8YhLKsZ3T2BcS7Zj3kl1iVWpWRymoD4DV9Ppxz2HzIWJNJd14zna8ZeiNipnVUvAnrtFrr2OHsNc3LSzf/UH2gUjTc5tZM2wn7sMnsIV21OWmKvi8t+UEx6PoikE29kvFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DGvfyInMneX7Ehx5cQd9GLv8QdMHNK5xm3gFZX7eTv0=;
 b=efdvWaY/hgmRW5fO2pLvXQHVmmTxkwmVfnymbF/DtEGwmVPawR6Yb6ULhWVVhGgdPK/wtfnkPaEMv1t1SlB7JoM6Yy5wwAQHYhwRLU2jQTXI2sYSeWaTwIeuy39/FU95x/F4d0FntcvhI1ElM5mpDAvmAmfcO4Kgv6eOZgki8Ac=
Received: from SN7P222CA0012.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:124::26)
 by CY5PR12MB6036.namprd12.prod.outlook.com (2603:10b6:930:2c::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.14; Wed, 24 Jun
 2026 06:07:06 +0000
Received: from SA2PEPF0000150A.namprd04.prod.outlook.com
 (2603:10b6:806:124:cafe::6e) by SN7P222CA0012.outlook.office365.com
 (2603:10b6:806:124::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.12 via Frontend Transport; Wed,
 24 Jun 2026 06:07:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF0000150A.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Wed, 24 Jun 2026 06:07:05 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 24 Jun
 2026 01:07:03 -0500
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <hawking.zhang@amd.com>,
 <kenneth.feng@amd.com>
Subject: [PATCH] drm/amd/pm: drop unused smu pptable callbacks
Date: Wed, 24 Jun 2026 14:06:53 +0800
Message-ID: <20260624060653.992690-1-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF0000150A:EE_|CY5PR12MB6036:EE_
X-MS-Office365-Filtering-Correlation-Id: 5218ee1a-c8af-4af2-25c1-08ded1b6d115
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|36860700016|82310400026|6133799003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: H5SZZ6HqNjXFARNghU8cNDKWKP07zwU7CFEnwPVr00/chPeCpaslv2XC3uvCulvmdUYdXIdArAH0Rpk4QSk6w3SONNgaAYPDuLpcqOQJszv8V4N2f9x9e9TZ3FjvYu/0cfd53+bu/E3j3Mfko0kZDc69XBVsTuDDzLpojqNOAcRzkm/sEGcv09wiEq2fFtpwFjn5lbwUD1gN2sd1AhACiXK6ww2i5lvaQeskYJt2DfiS7E687dgR+nX2qmwvbvd5k3XQKJBqc6vv1TB5YBsqqcQhTMmfLLdNHK8TC7OXZ0ne1yXZaEdkSwrgmBdq6UZ9HGk+9e05YahMRjU0EYziLKbi1fXimyaXaHmwO7fK6UkTeuB5gLXIJ8/BFiZe71KSeZVmtJfFbrGy2LTXOUC2vINTe/Jqc56KjTtx69+c72LPgzLr661irUy2gROwu9oNEnOb7e8NLrynk1aGCFH/9LDSPu9LzV8OBkIdHNLxMGH3xELjHJtPJOIJwz/0tZLRGfvH3fLE/zRaMl/9owivGyhsdP7urciMmn9fIAjlLRXg4SBenK9DpShgqL6jAzsxxvvrRHS7U91+v1AUOk3IVfPp+ZEurRbdSf2YM38YMv2zzDPGusvmSZKOQZTulBFJa/YioKN9acFzfsy4UQmLTtlOkNPM5by70Wi1OmTJLmyhogCpMCszegUiZAzZQCeZ
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(36860700016)(82310400026)(6133799003)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: cUJeIzngjRloOl3kD8yYpLOWrlArWl9UyYwH2L//Qxh1tXDN+xcSq8amXjGUZ8tEZA2R7Q6Mdr3SEG1sI0ON1O7rt8TmAUNwLsHVB98oPuuJmgqoWgBVdVu0fh9DkA1nlDFshW48dP1pJ+Lkpd3xyaxzZgAX9oNtckDzyNzO3DYDSWZIyMn7uyF47a49b3vzSMGdv8/C806if4yRjIRjb01VuUJCQ22CSOymfdhNgyPn6TfQsdW9e4KyT+ggXKskIz8G4RX6XvTv0XhmgYxt0f8pKvPcDjgQDuYGttybw/BAmjmjYQBuDyx3hbg4MwLpRu2FWGOOxdqdG/ECyRY6radHVRxLYXR56r+P4mg4JcBQ+tjYzFm5TyV5K0jwH0wPxuf56da+/2vqyjdacxOd2CoxylZIotkDMzObLaX8CSp9oqLFOfxa9lMpMX31Aqn4
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2026 06:07:05.4656 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5218ee1a-c8af-4af2-25c1-08ded1b6d115
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF0000150A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6036
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

struct pptable_funcs still carries callback slots that no longer have
call paths, drop the following unused callback slots:

- baco_get_state()
- baco_set_state()
- set_power_state()
- get_clock_by_type_with_voltage()
- set_azalia_d3_pme()

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h | 29 -------------------
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0.h  |  2 --
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h  |  2 --
 .../gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c |  1 -
 .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   |  1 -
 .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   |  1 -
 .../gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c    |  5 ----
 .../gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c   |  1 -
 .../drm/amd/pm/swsmu/smu13/aldebaran_ppt.c    |  1 -
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    |  9 ------
 .../drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c  |  2 --
 11 files changed, 54 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
index d76e0b005308..38a8249570a9 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -849,8 +849,6 @@ struct pptable_funcs {
 	 */
 	int (*set_default_dpm_table)(struct smu_context *smu);
 
-	int (*set_power_state)(struct smu_context *smu);
-
 	/**
 	 * @populate_umd_state_clk: Populate the UMD power state table with
 	 *                          defaults.
@@ -903,16 +901,6 @@ struct pptable_funcs {
 					      struct
 					      pp_clock_levels_with_latency
 					      *clocks);
-	/**
-	 * @get_clock_by_type_with_voltage: Get the speed and voltage of a clock
-	 *                                  domain.
-	 */
-	int (*get_clock_by_type_with_voltage)(struct smu_context *smu,
-					      enum amd_pp_clock_type type,
-					      struct
-					      pp_clock_levels_with_voltage
-					      *clocks);
-
 	/**
 	 * @get_power_profile_mode: Print all power profile modes to
 	 *                          buffer. Star current mode.
@@ -1354,11 +1342,6 @@ struct pptable_funcs {
 	 */
 	int (*register_irq_handler)(struct smu_context *smu);
 
-	/**
-	 * @set_azalia_d3_pme: Wake the audio decode engine from d3 sleep.
-	 */
-	int (*set_azalia_d3_pme)(struct smu_context *smu);
-
 	/**
 	 * @get_max_sustainable_clocks_by_dc: Get a copy of the max sustainable
 	 *                                    clock speeds table.
@@ -1375,18 +1358,6 @@ struct pptable_funcs {
 	 */
 	int (*get_bamaco_support)(struct smu_context *smu);
 
-	/**
-	 * @baco_get_state: Get the current BACO state.
-	 *
-	 * Return: Current BACO state.
-	 */
-	enum smu_baco_state (*baco_get_state)(struct smu_context *smu);
-
-	/**
-	 * @baco_set_state: Enter/exit BACO.
-	 */
-	int (*baco_set_state)(struct smu_context *smu, enum smu_baco_state state);
-
 	/**
 	 * @baco_enter: Enter BACO.
 	 */
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0.h
index dd94e8a9e218..c0accee9a9c8 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0.h
@@ -199,8 +199,6 @@ int smu_v11_0_gfx_off_control(struct smu_context *smu, bool enable);
 
 int smu_v11_0_register_irq_handler(struct smu_context *smu);
 
-int smu_v11_0_set_azalia_d3_pme(struct smu_context *smu);
-
 int smu_v11_0_get_max_sustainable_clocks_by_dc(struct smu_context *smu,
 		struct pp_smu_nv_clock_table *max_clocks);
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
index 68f4de5f800c..7f21f867d73c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
@@ -180,8 +180,6 @@ int smu_v13_0_gfx_off_control(struct smu_context *smu, bool enable);
 
 int smu_v13_0_register_irq_handler(struct smu_context *smu);
 
-int smu_v13_0_set_azalia_d3_pme(struct smu_context *smu);
-
 int smu_v13_0_get_max_sustainable_clocks_by_dc(struct smu_context *smu,
 					       struct pp_smu_nv_clock_table *max_clocks);
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
index 051a0008aa10..99abfddff856 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
@@ -1934,7 +1934,6 @@ static const struct pptable_funcs arcturus_ppt_funcs = {
 	.set_xgmi_pstate = smu_v11_0_set_xgmi_pstate,
 	.gfx_off_control = smu_v11_0_gfx_off_control,
 	.register_irq_handler = smu_v11_0_register_irq_handler,
-	.set_azalia_d3_pme = smu_v11_0_set_azalia_d3_pme,
 	.get_max_sustainable_clocks_by_dc = smu_v11_0_get_max_sustainable_clocks_by_dc,
 	.get_bamaco_support = smu_v11_0_get_bamaco_support,
 	.baco_enter = smu_v11_0_baco_enter,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index 2f2a5953dbbc..52c23bd3b201 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -3340,7 +3340,6 @@ static const struct pptable_funcs navi10_ppt_funcs = {
 	.set_xgmi_pstate = smu_v11_0_set_xgmi_pstate,
 	.gfx_off_control = smu_v11_0_gfx_off_control,
 	.register_irq_handler = smu_v11_0_register_irq_handler,
-	.set_azalia_d3_pme = smu_v11_0_set_azalia_d3_pme,
 	.get_max_sustainable_clocks_by_dc = smu_v11_0_get_max_sustainable_clocks_by_dc,
 	.get_bamaco_support = smu_v11_0_get_bamaco_support,
 	.baco_enter = navi10_baco_enter,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index 70897c70db32..e5370267fda3 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -3146,7 +3146,6 @@ static const struct pptable_funcs sienna_cichlid_ppt_funcs = {
 	.set_xgmi_pstate = smu_v11_0_set_xgmi_pstate,
 	.gfx_off_control = smu_v11_0_gfx_off_control,
 	.register_irq_handler = smu_v11_0_register_irq_handler,
-	.set_azalia_d3_pme = smu_v11_0_set_azalia_d3_pme,
 	.get_max_sustainable_clocks_by_dc = smu_v11_0_get_max_sustainable_clocks_by_dc,
 	.get_bamaco_support = smu_v11_0_get_bamaco_support,
 	.baco_enter = sienna_cichlid_baco_enter,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
index ac8f84f1e30e..f5155a4dc5a2 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
@@ -1417,11 +1417,6 @@ int smu_v11_0_get_max_sustainable_clocks_by_dc(struct smu_context *smu,
 	return 0;
 }
 
-int smu_v11_0_set_azalia_d3_pme(struct smu_context *smu)
-{
-	return smu_cmn_send_smc_msg(smu, SMU_MSG_BacoAudioD3PME, NULL);
-}
-
 int smu_v11_0_baco_set_armd3_sequence(struct smu_context *smu,
 				      enum smu_baco_seq baco_seq)
 {
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
index 0349dba2503a..e5d319cda52b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
@@ -1444,7 +1444,6 @@ static int renoir_get_enabled_mask(struct smu_context *smu,
 }
 
 static const struct pptable_funcs renoir_ppt_funcs = {
-	.set_power_state = NULL,
 	.emit_clk_levels = renoir_emit_clk_levels,
 	.get_current_power_state = renoir_get_current_power_state,
 	.dpm_set_vcn_enable = renoir_dpm_set_vcn_enable,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
index 3a19f0ffcf3c..7c0d4e40b9b6 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
@@ -2005,7 +2005,6 @@ static const struct pptable_funcs aldebaran_ppt_funcs = {
 	.disable_thermal_alert = smu_v13_0_disable_thermal_alert,
 	.set_xgmi_pstate = smu_v13_0_set_xgmi_pstate,
 	.register_irq_handler = smu_v13_0_register_irq_handler,
-	.set_azalia_d3_pme = smu_v13_0_set_azalia_d3_pme,
 	.get_max_sustainable_clocks_by_dc = smu_v13_0_get_max_sustainable_clocks_by_dc,
 	.get_bamaco_support = aldebaran_get_bamaco_support,
 	.get_dpm_ultimate_freq = aldebaran_get_dpm_ultimate_freq,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
index d511f03354a6..67d20213ad07 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -1321,15 +1321,6 @@ int smu_v13_0_get_max_sustainable_clocks_by_dc(struct smu_context *smu,
 	return 0;
 }
 
-int smu_v13_0_set_azalia_d3_pme(struct smu_context *smu)
-{
-	int ret = 0;
-
-	ret = smu_cmn_send_smc_msg(smu, SMU_MSG_BacoAudioD3PME, NULL);
-
-	return ret;
-}
-
 static int smu_v13_0_wait_for_reset_complete(struct smu_context *smu,
 					     uint64_t event_arg)
 {
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
index 9c09b2640a0c..edc5140f6ab6 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
@@ -2891,8 +2891,6 @@ static const struct pptable_funcs smu_v14_0_2_ppt_funcs = {
 	.deep_sleep_control = smu_v14_0_deep_sleep_control,
 	.gfx_ulv_control = smu_v14_0_gfx_ulv_control,
 	.get_bamaco_support = smu_v14_0_get_bamaco_support,
-	.baco_get_state = smu_v14_0_baco_get_state,
-	.baco_set_state = smu_v14_0_baco_set_state,
 	.baco_enter = smu_v14_0_2_baco_enter,
 	.baco_exit = smu_v14_0_2_baco_exit,
 	.mode1_reset_is_support = smu_v14_0_2_is_mode1_reset_supported,
-- 
2.47.3

