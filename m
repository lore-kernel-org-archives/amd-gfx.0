Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22034CDB471
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jun 2026 08:45:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B4C5C10E56F;
	Mon, 22 Jun 2026 08:45:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bP2PO2SN";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010043.outbound.protection.outlook.com [52.101.56.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E0A8910E581
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jun 2026 08:45:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CoUkj0LLgqFWZsKGqdOrnixYxgVtvegurNVz3cY82OoktnuBd/nGGWfOAWwIerdEboo348Gs3scKMC/0VG9cBVxWXphjF/yMtQxdGlLwDQqzzkTAkQN1UnK4KSJQWrQ+oAPKGgexoNq9vEZYfGoOvobviIFz6JzDk51GrEVtb5sRWrnZpJBcMPbExUibkHQSW9NjYbQ0akj6ER4FEsvdj0zCy16Y/VmWvUnAMgOrz6PGxNZ0DMkxKlcPMmbuo9GvIrMnulymuBDftPtG0GCuZRuiUn6/CxlofQbbH2geHNjDMhJJ2cvdGT2QyPyhvbQHSnqoVQgHYa9wIFY2Ugrzaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0PinExI0c8Et+qy6xaHsWeBc35E00oskDlpaAqcrBlc=;
 b=YVT6jaeqsxwAcZUJM5BFpXpXLc9XMweo7eiOrAm4OBQshO0C1O4xDxkRwBtpWVP2LJuF70bLIHISRQzEFpVI6cL7fYyU+xVG92MrzY646iYn+jiJnpvPgvZf0xwqcOzv7jau58B/GN7jxP/ALt93NvHlRj9/wsYbgdr6FdQs/sJMVGu02JszbHZzWjDiTVM8v+ymrPYqmf/OwXQTQeI+9Hq7eeI+oJjg1NTM3lajfW9MQSAcAnwEHEyC3Pkatagg1zKkyLAEdQP420n0uBGe+ApJOhc3xg4IT9uqSJM+HVq9LSmg8lfbA2bw9Mqryg8tZQGRsCZNN/022SKPMtDmAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0PinExI0c8Et+qy6xaHsWeBc35E00oskDlpaAqcrBlc=;
 b=bP2PO2SNwBGtZpKwwMyormCCYujeeWcU0GRyEUdKR9FkvAEhbBexiZWp6o5zUDXmve6/IzRaeuyFWzuHMM3NZqg2XQuNZV24bHAA//mA01ed0Kuk07D3VEZOroP+cZ3K6YdJB1oRFWNMUHZumtmfgJ30OjtHUIYxgFhuGi1KUBg=
Received: from DS7PR06CA0045.namprd06.prod.outlook.com (2603:10b6:8:54::26) by
 DSSPR12MB999236.namprd12.prod.outlook.com (2603:10b6:8:374::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.18; Mon, 22 Jun
 2026 08:45:51 +0000
Received: from CY4PEPF0000E9D9.namprd05.prod.outlook.com
 (2603:10b6:8:54:cafe::9d) by DS7PR06CA0045.outlook.office365.com
 (2603:10b6:8:54::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.20 via Frontend Transport; Mon,
 22 Jun 2026 08:45:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000E9D9.mail.protection.outlook.com (10.167.241.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Mon, 22 Jun 2026 08:45:51 +0000
Received: from sunce-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 22 Jun
 2026 03:45:48 -0500
From: Ce Sun <cesun102@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <YiPeng.Chai@amd.com>, <Tao.Zhou1@amd.com>,
 <Stanley.Yang@amd.com>, Ce Sun <cesun102@amd.com>
Subject: [PATCH v2 21/48] drm/amdgpu: retire legacy RAS reset/query operations
 for sdma v4_4_2
Date: Mon, 22 Jun 2026 16:44:23 +0800
Message-ID: <3170cae28d50e246301a29a59a488db0a206ee40.1782117608.git.cesun102@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <594f7cbae0387b60f8af49505b57c1a5a604db2f.1782117608.git.cesun102@amd.com>
References: <594f7cbae0387b60f8af49505b57c1a5a604db2f.1782117608.git.cesun102@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D9:EE_|DSSPR12MB999236:EE_
X-MS-Office365-Filtering-Correlation-Id: 364a5731-45ad-415f-f887-08ded03aa9fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|1800799024|82310400026|376014|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: d8aAjdn99LoQBLAlYnY35w22N0g4WXWn9Q3s7wbFI+ftYQULnrg6jGdaHBeVIdgvhdHe7a9QDtmAxQcS4Z20FxQB/+Rt7nWZHOZvutZbzdPzX0DaGT/2PJmkfHz8/0Dpj78vJHU8n8RsyYdTFzfkzI7a9aAttulE0bEpifGAWRt0oE7InbjOD6fMYWfO8GG5bRD/hcHAPnr2KqDwiAeycAeBfCEyR4GS2OD08fxP1e4Iz05iQ+RA9lS3DDJsms5zxrjcmVWM7xZFA9BYmne4bDaYzvi8aBduDe7u8NKA6DxgRGdBGPcJzwGxfU23hAIY4tVu7Ps8QqRRkEGYu5Viu4I7Kg8e9bFw9nQxpwiL5ugx7plm8FUSVu+aTfA+Ov0Au1Z+L99hlvZAQ1uRJbg+/OkXvH0ci8UwBQd1MTwbxRPuHOl7C1yHsyYlch+Suin69ARhRpsPbutmo/bSRA1w4SGyHyZ8k3qu0O9jv9llqtLr7IKrdoEiPnUYA3Dg61oW9AgBLiwRPC6on4lX+rUbnKzKwmYzwa50QBzHY6WwVumw5MCz2sUfBvSr9WKRZ3Cf7YUoWiMOCpILCL0EhtsdYbZ975tpZlOi0UMVi8Iex3/O4U5wIHHB0ifACU88oBkgtJLv2qm+XQL44Q9drW3gRYmKm/uDcqcKgl4Y8BGhq3OxFvaLxJp2MaZp0aGM7Cl3wDb1ZssIv+LeavvVmDygsA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(1800799024)(82310400026)(376014)(22082099003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: i5ra9OI5arVManNM4eCvd1zWdSsOgpLfKUF3nfy6KAgalKhlyZzSi0xAGGjCxDGmtE2CXxrcMm6acrx8hmeJ1QjhE6vOAQGUaZswOwMQkpzn0nIA9SnvZRdNssZ09nb/ZliMwRjcBCulX8P01Aj3lp7EsFkndbQfhFAjrAmWOeaTkPIao2phzCR9V3wYR5Kx+MUlY29izlPxc5y8zjTcH1T9hBezoG2rRR8B327TVV0XDgcyL2HrTEoADqyDDMZKg+2dtqXmh+Se+IumUjbxtTip6vFctb0/UW44MjuacFYcceHj5CAKvLEU434UO5N58UVyI3dioCDydwBD/BaFfSSnZSL8I8gFEUKnZeWBARvS0hVr3OyBmXM/bpI5P2+POh4CSwEeffTqinC2hnfAyODivKXONJ1l6zoUzJEyDRoAcGIMzAaEZQGM2SaKW/Lj
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 08:45:51.0991 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 364a5731-45ad-415f-f887-08ded03aa9fd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSSPR12MB999236
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

retire legacy RAS reset/query operations for sdma v4_4_2

Signed-off-by: Ce Sun <cesun102@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h |  28 ------
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 104 +----------------------
 2 files changed, 1 insertion(+), 131 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
index 2bf365609775..4f4e56022c97 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
@@ -85,34 +85,6 @@ struct amdgpu_sdma_instance {
 	const struct amdgpu_sdma_funcs   *funcs;
 };
 
-enum amdgpu_sdma_ras_memory_id {
-	AMDGPU_SDMA_MBANK_DATA_BUF0 = 1,
-	AMDGPU_SDMA_MBANK_DATA_BUF1 = 2,
-	AMDGPU_SDMA_MBANK_DATA_BUF2 = 3,
-	AMDGPU_SDMA_MBANK_DATA_BUF3 = 4,
-	AMDGPU_SDMA_MBANK_DATA_BUF4 = 5,
-	AMDGPU_SDMA_MBANK_DATA_BUF5 = 6,
-	AMDGPU_SDMA_MBANK_DATA_BUF6 = 7,
-	AMDGPU_SDMA_MBANK_DATA_BUF7 = 8,
-	AMDGPU_SDMA_MBANK_DATA_BUF8 = 9,
-	AMDGPU_SDMA_MBANK_DATA_BUF9 = 10,
-	AMDGPU_SDMA_MBANK_DATA_BUF10 = 11,
-	AMDGPU_SDMA_MBANK_DATA_BUF11 = 12,
-	AMDGPU_SDMA_MBANK_DATA_BUF12 = 13,
-	AMDGPU_SDMA_MBANK_DATA_BUF13 = 14,
-	AMDGPU_SDMA_MBANK_DATA_BUF14 = 15,
-	AMDGPU_SDMA_MBANK_DATA_BUF15 = 16,
-	AMDGPU_SDMA_UCODE_BUF = 17,
-	AMDGPU_SDMA_RB_CMD_BUF = 18,
-	AMDGPU_SDMA_IB_CMD_BUF = 19,
-	AMDGPU_SDMA_UTCL1_RD_FIFO = 20,
-	AMDGPU_SDMA_UTCL1_RDBST_FIFO = 21,
-	AMDGPU_SDMA_UTCL1_WR_FIFO = 22,
-	AMDGPU_SDMA_DATA_LUT_FIFO = 23,
-	AMDGPU_SDMA_SPLIT_DAT_BUF = 24,
-	AMDGPU_SDMA_MEMORY_BLOCK_LAST,
-};
-
 struct amdgpu_sdma_ras {
 	struct amdgpu_ras_block_object ras_block;
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
index 0d7e22060a92..484f1a6b5fbc 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -2416,111 +2416,9 @@ struct amdgpu_xcp_ip_funcs sdma_v4_4_2_xcp_funcs = {
 	.resume = &sdma_v4_4_2_xcp_resume
 };
 
-static const struct amdgpu_ras_err_status_reg_entry sdma_v4_2_2_ue_reg_list[] = {
-	{AMDGPU_RAS_REG_ENTRY(SDMA0, 0, regSDMA_UE_ERR_STATUS_LO, regSDMA_UE_ERR_STATUS_HI),
-	1, (AMDGPU_RAS_ERR_INFO_VALID | AMDGPU_RAS_ERR_STATUS_VALID), "SDMA"},
-};
-
-static const struct amdgpu_ras_memory_id_entry sdma_v4_4_2_ras_memory_list[] = {
-	{AMDGPU_SDMA_MBANK_DATA_BUF0, "SDMA_MBANK_DATA_BUF0"},
-	{AMDGPU_SDMA_MBANK_DATA_BUF1, "SDMA_MBANK_DATA_BUF1"},
-	{AMDGPU_SDMA_MBANK_DATA_BUF2, "SDMA_MBANK_DATA_BUF2"},
-	{AMDGPU_SDMA_MBANK_DATA_BUF3, "SDMA_MBANK_DATA_BUF3"},
-	{AMDGPU_SDMA_MBANK_DATA_BUF4, "SDMA_MBANK_DATA_BUF4"},
-	{AMDGPU_SDMA_MBANK_DATA_BUF5, "SDMA_MBANK_DATA_BUF5"},
-	{AMDGPU_SDMA_MBANK_DATA_BUF6, "SDMA_MBANK_DATA_BUF6"},
-	{AMDGPU_SDMA_MBANK_DATA_BUF7, "SDMA_MBANK_DATA_BUF7"},
-	{AMDGPU_SDMA_MBANK_DATA_BUF8, "SDMA_MBANK_DATA_BUF8"},
-	{AMDGPU_SDMA_MBANK_DATA_BUF9, "SDMA_MBANK_DATA_BUF9"},
-	{AMDGPU_SDMA_MBANK_DATA_BUF10, "SDMA_MBANK_DATA_BUF10"},
-	{AMDGPU_SDMA_MBANK_DATA_BUF11, "SDMA_MBANK_DATA_BUF11"},
-	{AMDGPU_SDMA_MBANK_DATA_BUF12, "SDMA_MBANK_DATA_BUF12"},
-	{AMDGPU_SDMA_MBANK_DATA_BUF13, "SDMA_MBANK_DATA_BUF13"},
-	{AMDGPU_SDMA_MBANK_DATA_BUF14, "SDMA_MBANK_DATA_BUF14"},
-	{AMDGPU_SDMA_MBANK_DATA_BUF15, "SDMA_MBANK_DATA_BUF15"},
-	{AMDGPU_SDMA_UCODE_BUF, "SDMA_UCODE_BUF"},
-	{AMDGPU_SDMA_RB_CMD_BUF, "SDMA_RB_CMD_BUF"},
-	{AMDGPU_SDMA_IB_CMD_BUF, "SDMA_IB_CMD_BUF"},
-	{AMDGPU_SDMA_UTCL1_RD_FIFO, "SDMA_UTCL1_RD_FIFO"},
-	{AMDGPU_SDMA_UTCL1_RDBST_FIFO, "SDMA_UTCL1_RDBST_FIFO"},
-	{AMDGPU_SDMA_UTCL1_WR_FIFO, "SDMA_UTCL1_WR_FIFO"},
-	{AMDGPU_SDMA_DATA_LUT_FIFO, "SDMA_DATA_LUT_FIFO"},
-	{AMDGPU_SDMA_SPLIT_DAT_BUF, "SDMA_SPLIT_DAT_BUF"},
-};
-
-static void sdma_v4_4_2_inst_query_ras_error_count(struct amdgpu_device *adev,
-						   uint32_t sdma_inst,
-						   void *ras_err_status)
-{
-	struct ras_err_data *err_data = (struct ras_err_data *)ras_err_status;
-	uint32_t sdma_dev_inst = GET_INST(SDMA0, sdma_inst);
-	unsigned long ue_count = 0;
-	struct amdgpu_smuio_mcm_config_info mcm_info = {
-		.socket_id = adev->smuio.funcs->get_socket_id(adev),
-		.die_id = adev->sdma.instance[sdma_inst].aid_id,
-	};
-
-	/* sdma v4_4_2 doesn't support query ce counts */
-	amdgpu_ras_inst_query_ras_error_count(adev,
-					sdma_v4_2_2_ue_reg_list,
-					ARRAY_SIZE(sdma_v4_2_2_ue_reg_list),
-					sdma_v4_4_2_ras_memory_list,
-					ARRAY_SIZE(sdma_v4_4_2_ras_memory_list),
-					sdma_dev_inst,
-					AMDGPU_RAS_ERROR__MULTI_UNCORRECTABLE,
-					&ue_count);
-
-	amdgpu_ras_error_statistic_ue_count(err_data, &mcm_info, ue_count);
-}
-
-static void sdma_v4_4_2_query_ras_error_count(struct amdgpu_device *adev,
-					      void *ras_err_status)
-{
-	uint32_t inst_mask;
-	int i = 0;
-
-	inst_mask = GENMASK(adev->sdma.num_instances - 1, 0);
-	if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__SDMA)) {
-		for_each_inst(i, inst_mask)
-			sdma_v4_4_2_inst_query_ras_error_count(adev, i, ras_err_status);
-	} else {
-		dev_warn(adev->dev, "SDMA RAS is not supported\n");
-	}
-}
-
-static void sdma_v4_4_2_inst_reset_ras_error_count(struct amdgpu_device *adev,
-						   uint32_t sdma_inst)
-{
-	uint32_t sdma_dev_inst = GET_INST(SDMA0, sdma_inst);
-
-	amdgpu_ras_inst_reset_ras_error_count(adev,
-					sdma_v4_2_2_ue_reg_list,
-					ARRAY_SIZE(sdma_v4_2_2_ue_reg_list),
-					sdma_dev_inst);
-}
-
-static void sdma_v4_4_2_reset_ras_error_count(struct amdgpu_device *adev)
-{
-	uint32_t inst_mask;
-	int i = 0;
-
-	inst_mask = GENMASK(adev->sdma.num_instances - 1, 0);
-	if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__SDMA)) {
-		for_each_inst(i, inst_mask)
-			sdma_v4_4_2_inst_reset_ras_error_count(adev, i);
-	} else {
-		dev_warn(adev->dev, "SDMA RAS is not supported\n");
-	}
-}
-
-static const struct amdgpu_ras_block_hw_ops sdma_v4_4_2_ras_hw_ops = {
-	.query_ras_error_count = sdma_v4_4_2_query_ras_error_count,
-	.reset_ras_error_count = sdma_v4_4_2_reset_ras_error_count,
-};
-
 static struct amdgpu_sdma_ras sdma_v4_4_2_ras = {
 	.ras_block = {
-		.hw_ops = &sdma_v4_4_2_ras_hw_ops,
+		.hw_ops = NULL,
 	},
 };
 
-- 
2.34.1

