Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8370CD98F6
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jun 2026 04:42:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 66B1010E477;
	Mon, 22 Jun 2026 04:42:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="puevBAjk";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010021.outbound.protection.outlook.com [52.101.85.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 262B910E46F
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jun 2026 04:42:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FAUtxWLzAhpG1ECpndqBQfeEjLvGnTlk6B2Ruq6vfrDvS7JA8Jq/oK31MIP0HdFAJAQ9GQkgEpzzQIKxWkwMkMOp4zq5TqStXOBq4n/tQyxgMj1q5TkytC43hB+gk5wfZOEY5v5NfWcIixOQJjcF1zaTIKE8lVyFTY38GeTOImuSiKdOolgol+q7AzB0571SQdA4dp2XZcro9pQpjtmQ5+EixPfNVRKEN0iIuZZRePRZKvQ3JoUGJvfTw65yfLd0gs7Pln0M8fi3oo8p9WvUEwH5DQlquBYJUDegKClHaIk76OrFw72zzYs6GxJ+ayeQuuZHbklUTuu3wwiyJitgBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0PinExI0c8Et+qy6xaHsWeBc35E00oskDlpaAqcrBlc=;
 b=TkDKl6VrP8r0x40O0x/82eh4r/YR7kgYuz+2fhTeXwHgIqv/n+4KOzoS0gGeK4w7iHfpq9DzYAW7OiP8s4XBHAMlkD5Xfi1bYz4TPw2OoXvbneW/huV46Zdi8xqhk2xf1P5YYicS48ybC9r5r0fAfejkIZKtkBa8aLyQvHYOvrMUbuADMQI//c3U1jGn/OzuediUPTkW62J7K3M/t+RrB3LpRxQ7mvT0xZ3y/sjI2RWaduvwxRdS1ttO6TT4ui6TeI54UJ9A8ZWq7VU/V/HoqUahvxEdEzNJedgBpmW4K/dGVKpk6vCGyIU2FB+AQk/gmXcVqiPwwf3z4/7oCAQCkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0PinExI0c8Et+qy6xaHsWeBc35E00oskDlpaAqcrBlc=;
 b=puevBAjkdaWp2FCwLqoGYxXyzUtRaYc3q8uM9ZkaboMo8NHaLt4IePmGxnc26soMdwxtuAna4kDDb5VEIbiHpKdUIplGpAdp6Z1hFsTvjMLlJGIXtRa44i8KHX8qrtwvTXj/oFl5y2KAjxhTxo6aP1zvFtTbLwOzXcjyiD85DOA=
Received: from BLAPR03CA0110.namprd03.prod.outlook.com (2603:10b6:208:32a::25)
 by CH8PR12MB9840.namprd12.prod.outlook.com (2603:10b6:610:271::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.19; Mon, 22 Jun
 2026 04:42:42 +0000
Received: from BL6PEPF00022574.namprd02.prod.outlook.com
 (2603:10b6:208:32a:cafe::2e) by BLAPR03CA0110.outlook.office365.com
 (2603:10b6:208:32a::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.11 via Frontend Transport; Mon,
 22 Jun 2026 04:42:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00022574.mail.protection.outlook.com (10.167.249.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Mon, 22 Jun 2026 04:42:42 +0000
Received: from sunce-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Sun, 21 Jun
 2026 23:42:40 -0500
From: Ce Sun <cesun102@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <YiPeng.Chai@amd.com>, <Tao.Zhou1@amd.com>, "Ce
 Sun" <cesun102@amd.com>
Subject: [PATCH v1 21/48] drm/amdgpu: retire legacy RAS reset/query operations
 for sdma v4_4_2
Date: Mon, 22 Jun 2026 12:40:10 +0800
Message-ID: <9c313cbaf069a201eb51848a7bda7e87acf6892a.1782103074.git.cesun102@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1782103073.git.cesun102@amd.com>
References: <cover.1782103073.git.cesun102@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022574:EE_|CH8PR12MB9840:EE_
X-MS-Office365-Filtering-Correlation-Id: 39963b96-7b0a-4705-825b-08ded018b25c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|376014|82310400026|1800799024|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 7Zaiq0YjhA+K9GJz/oDfEqYGLsuzlJw0OkKuLNVuuzjaRQOdpe3UMFeTn4GG++zMim7D7ro1Jxh8WzuAOIdwEIfuuI+Jlz1+rd4OJ8J43FEs+tnfAdduQnx91QZB9D/VXge3Jf4BHX0hza+hydv0UbZoKgBqEYvm+jMZgEfQSoMlpNf8th0rBp0ERg5kiqv26qlcmRwPXon1FbiHQn+JMwQAKwZg20nwvHiqsSlL8AFERnRQiypw7tgm7tLfIwuZ+unui1pp7DV6xLv5ZfmzG6K3mxrLi2LTvZUHAkiRiUdfBQHSUjMGinE9ZVRtUtTj/tRIdlIYKB81O5qFIJT4HtZxhXLkZUYyi+6oewmy8OXyNZ8rjzt5N2igeCVxey7Zy67Q8Zl8qHcGr1myDHU9dZMIOGAN/M8oYq6cYNHN09+ucqVD92KsOU+cIIyJ9e7NVX7UR59Jj2ZYCgA1fNDrhFwB5tvHwwfVSYGqbY0MkvxWnE9/7xAwIC2ta0JJri9hfh5FGhkwbIa3tKJ8ZRhon6x726/3zCCv7JMuZ+3pc6VyL7n++fPF9qF1MaOmeV3+UtnbVldiHImi8hDj91VRggSFSzeSK90eN69yOubD1hRDIjIJCut6OHvFdh54ffQDOYCGojQZryXOhvHUNYwXL0oPGqf+jen92SlSbu/ydJu3YzGVO1JgNY2lOYETbpi8lP8yHXz4/3RrfVuMGZwQgQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(376014)(82310400026)(1800799024)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: wnuqmCglOti4ypJw0zzpgtxvyeXvs4uAMQIO/9zQq7+pp2ieGRkwJ4IwJWQoRKminBZ03La4Ahsd8UMOjIFU5SY7WM4fZDwcbteKxw3l90OEAfdpK36MxOVtKl73lt2DxQ3jzBj8Z1zSLgaUaMCVgtRPLrIsNAqsvQPqNtRXS8IhuGs7Nc8TkPJ0IMiRO7px8xL1nCndHWLo2N50XX+vq+D5HRz+e/dTY3xXcPc+jyo9P+vCyafyn7VPyTJvrvvmnupV95WADnv2Ib5Ss2SgZByGqf0VVnsEjjlRfIHSpW9kN16qorPa5ZkiVLGdz2vXQrgDf3mcDlM4/XetkwTqE1nWhCETqj28YMqkrqXWMwOqCd4VA/5gYXHbGCf0dOIUmEJ9GKuSrvzx94jwVWRQWHF+6HT4hR0VgHsLGK6/L0sSqiEYmPrdnxZcuMWBjQUL
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 04:42:42.2956 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 39963b96-7b0a-4705-825b-08ded018b25c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00022574.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR12MB9840
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

