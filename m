Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98342CDE002
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jun 2026 08:21:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D44A10F18D;
	Thu, 25 Jun 2026 08:21:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CYqlE4/M";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010038.outbound.protection.outlook.com [52.101.85.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4866810F181
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jun 2026 08:20:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rxxr4N9oTKUR4MNcYZQhsiK91vKW4ZPaUFovFTOEVJxSk/bYg2y3ka1g5tj0e7INaai15YXB0sQSlTF/5yXkCNLUm9j/RMjXyMMpaHMe7qOekv9j7sGRSvS22da+iuXLDveMMjQK7xoR+Mw2S3CleUotl5Yaxs/8iIw0xqk+8930HbMf6v47tl5fouJ4LMNsLsJWhkpkXP/YSBkprLWZg67sxdy9mZDNH0yccrQcYkzM68scZzwcJMGExrzL4OGequdAkowYc/LcDnFFLgw2Nj+bkGnI04ACwJbZ17motQmJ9VAdpIq/andDli+VXWfFzspu6kl1UlPjGaxGilTuwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0PinExI0c8Et+qy6xaHsWeBc35E00oskDlpaAqcrBlc=;
 b=Yn8un+Joshr2B7ip3oZv5osTEraAt+AdFgCqQHvgXRHqDjgoPg8kze5hvWb9/Bt6yCy1+9y7X8f+WRveKRZXKcP8QUG9WJU6nMXv4j10FjmoBhgCmxgr4LUbz1vQuSBsk68dGu9H+JSLPffegyDk5+tqvxJD23hSPLPdaAO4ILYq1k8DmEwpBpjhbpTnghWWzcVzm9T2QFvh6pAcVq1hO8uBcCIY0t2c+U3LT3TynZRcjrv9AP+1DrYwBiWDmH2F0fOSVQiGqEr0jcQcfr1sBWP1scLOWWGOgGy57ujrXcj2eWE5dMgm5APJYWzSLdhEXX0doq+japMlVxo2H1V8eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0PinExI0c8Et+qy6xaHsWeBc35E00oskDlpaAqcrBlc=;
 b=CYqlE4/M52QHV266Yfho62fCwk8y5F0lsRMHq1d9oNwsSdrpYmr+QLyvdf/ZKHVptGs1z3BzcR3bUPv41rNe2fJKLK2ZRkSX9gylU6TZks/AEDr+p+6l3b1hG02xO6dDHdnows/Up7Y0EtHaUt9xBoHoA9RXRdKiJRTT+75anFY=
Received: from CYZPR14CA0009.namprd14.prod.outlook.com (2603:10b6:930:8f::29)
 by IA1PR12MB6259.namprd12.prod.outlook.com (2603:10b6:208:3e5::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.16; Thu, 25 Jun
 2026 08:20:52 +0000
Received: from CY4PEPF0000EDD4.namprd03.prod.outlook.com
 (2603:10b6:930:8f:cafe::92) by CYZPR14CA0009.outlook.office365.com
 (2603:10b6:930:8f::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.16 via Frontend Transport; Thu,
 25 Jun 2026 08:20:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EDD4.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 25 Jun 2026 08:20:51 +0000
Received: from sunce-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 25 Jun
 2026 03:20:49 -0500
From: Ce Sun <cesun102@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <YiPeng.Chai@amd.com>, <Tao.Zhou1@amd.com>,
 <Stanley.Yang@amd.com>, Ce Sun <cesun102@amd.com>
Subject: [PATCH v3 21/44] drm/amdgpu: retire legacy RAS reset/query operations
 for sdma v4_4_2
Date: Thu, 25 Jun 2026 16:19:14 +0800
Message-ID: <f2bd180cc9c45c3f10949a9ab67c24c5e94987f1.1782373702.git.cesun102@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <b5587fca5f57f8f352245edf2c76606ad3307923.1782373701.git.cesun102@amd.com>
References: <b5587fca5f57f8f352245edf2c76606ad3307923.1782373701.git.cesun102@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD4:EE_|IA1PR12MB6259:EE_
X-MS-Office365-Filtering-Correlation-Id: 0480bfac-ef6f-4114-1b0e-08ded292aba0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|82310400026|23010399003|376014|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: qcR5cQfCK0uLAxqLxZ2SvCeKQg2pQQz5kq2WXmbFh9RuLV9HgciuKam8mvH/nqaof5gPnOmH9IbANsL0frMt8VORKTZbxoEaWSDZTfr9EUlY/2uUDjXvAmkItO8ZZSoe0x4nUIs5wIXDCREV/TRvvtORA6U8FKa59pkAstns8gWyB6+xB6/8QUxVuUjLxJG+rR0VIeiq3i+zOUlyAKuGJMvEQIRt68aZvQ+IbCQEAlAg6g5vgaTZM+ehFyvAkKHJZAl6MIxJYCyu9iv2p3fy9Y0tG1DVvBeFO0/VXGyKnz+qyCeC+ENKq1iU02B49xY7QP8GdTRw/0DwfFvmOVIkepaO/us5Nlt+RnvaPiUqtccAQNkk3Ng7HbDpe6u35h7/S08up4wf2jVKZHIuA5ACHwyvqPtYnJ6oIlmDCxwQyLr92XibjPyRGgRYHVlNDWCvT4+xeDWZdfm9WHvXW+PYLr4esEMWo8C5uAINgQ6hlgyLQ50t5eXu7fZHZ+7b/Ooad50TGCDeQimFHegZtAi1jT1hGH7iP5fmiHdM+4iq8igTM68yhLMrdbHkVvkQ7jRWnCWw5rKKv00HMKUn00Dd2712oPzrWwPj8AHTBr9EgCFaRLWzHJPWwRCO7lVHNklrdEyiYRREbxlZH3Dn9MBKNrXv7wnQWFW62LpEAbHg3MJrPsNd1zZKU4kzHLQ54X0kYYEYnJ6L84kQ6N3Z7zrdEg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(82310400026)(23010399003)(376014)(18002099003)(22082099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: U1zNGsbHeZbQsYao8WKqFNGMWOyr/gyUCCQnTxTlzd5eshDqEH130KgM3/bsYMvNFWjXCLWbOWK1pACa2MTPtxrtMLopd8dOce87o2xdVp8oilHTpBDu2GAWcqx93fqOAzVSE+plzXSKfCtGSSBRACeOMwWPGzpee9QX/8MyTCpFPwrScs2LVOfvzaUzOgUBNVno6l6VU2+V1OGx0Z3bUe42SjI/guxiH+xOAtPUoEEUr4I/LdlTNNXlEODho/2PZSvy9Z64CUY9EItDJzGjo/FI7k18w2Sq81aY8Th6g4pFU0VwHeCkA0xTDtDSCRSA5jZQNlwz8Vk428qPGLmiz5E6wXNB1Z3J6mJCx14w6oZHqpxHiZERN+k0EbQWpiSzCjJPSLLZLxPV6Ax92jPs8GGFRUUHrI/L2Dno0nUey+URKeLQPP0HD4fG3Hn+blr5
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 08:20:51.8764 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0480bfac-ef6f-4114-1b0e-08ded292aba0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6259
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

