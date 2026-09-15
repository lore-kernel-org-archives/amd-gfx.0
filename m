Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E116BC88E7D
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Sep 2026 07:30:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 58C5610FA38;
	Tue, 15 Sep 2026 07:30:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gc+X0CjH";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012050.outbound.protection.outlook.com
 [40.107.200.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2353F10FA38
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Sep 2026 07:30:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P2RQfvK54l9fXOVCURldGhqfLNZM9xyZvSgo0nj7HPBH/K482MKFOjr0Ei3J8K3IlcfHkTZcKe+6QB2xuFffT24VlOhr/eP9OFtoUB8yOcIrgxCOcSUZopXFrsagC6iBJzwIBevznVmGz4DvDBWTsrULspps2PMbVTgDWgzuEK1fXLQvrPJGhkOzYUPtXmQchjF312Eji7sBNWK9trp30uSINqW3rjpROnU9mDBWeAuTQYUkcj3ePFQ79N5nQ/22Z1e1oXgEU9fvVFK69/shQBRHoa32NVqNUCPL4Lbhfmo4l/+7HdxMN3U9FeBU48DZ8hpl11EA0R34KwWvlIEqYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WtQ7SpCSAQcWOyF5oFZ5ApcVd4gp3YdiGOcPn1oAVV4=;
 b=wHAep2GFO9uq6o3GZIWIjpks8IetxANP7FXTbCkv6sOPoAnXjuTA1gYh+lkk6BMrjG79gn1Y9JEpkntssIVXb9N7uP50AeVd+D6ZgAFExQBnjxkCNj+1w6WnIs7a4SyGSr8fpmsa+I7JzOCdEeqKXNx2ImAniiMOfAT37hdimrnwt2CSiRgJde8a40OGEdNbGN+KWDD94tgQQHWJ5bb1A/ELFadMjGS7FJaSoQJMISnGKtBp6w1FB8tcHYb3StC8Z4TTWAgbzjvXx9i/0MyNz+hOZhj/ZusZt01S28y+NCGf8lvqphViwADYV06cj6AYEqA2lgxD4tLrWYU3pys7gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WtQ7SpCSAQcWOyF5oFZ5ApcVd4gp3YdiGOcPn1oAVV4=;
 b=gc+X0CjH+LCQNn3N4J5Hd0lAGe3V04aZLrrH2VtyaWl8Tv4ealqVYrCrdoeR6nuWsEnPIqbJoTnLePVZCmQsZbz6Ki9czjJnG5P88RnFXL5SzbfuNZ/MBz3QRtjIzq2g5RC6Jod5XxGQZ56znzA8ffH7kAJ455uQejrprE2+OTE=
Received: from SJ0PR13CA0202.namprd13.prod.outlook.com (2603:10b6:a03:2c3::27)
 by BL1PR12MB5897.namprd12.prod.outlook.com (2603:10b6:208:395::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Tue, 15 Sep
 2026 07:29:58 +0000
Received: from SJ1PEPF00001CE4.namprd03.prod.outlook.com
 (2603:10b6:a03:2c3:cafe::a6) by SJ0PR13CA0202.outlook.office365.com
 (2603:10b6:a03:2c3::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.8 via Frontend Transport; Tue, 15
 Sep 2026 07:29:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CE4.mail.protection.outlook.com (10.167.242.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Tue, 15 Sep 2026 07:29:58 +0000
Received: from amd-03.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 15 Sep
 2026 02:29:56 -0500
From: YiPeng Chai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Tao.Zhou1@amd.com>, <Stanley.Yang@amd.com>,
 YiPeng Chai <YiPeng.Chai@amd.com>
Subject: [PATCH 2/2] drm/amd/ras: add ras command to query partition info
Date: Tue, 15 Sep 2026 15:29:19 +0800
Message-ID: <20260915072919.1751338-2-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260915072919.1751338-1-YiPeng.Chai@amd.com>
References: <20260915072919.1751338-1-YiPeng.Chai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE4:EE_|BL1PR12MB5897:EE_
X-MS-Office365-Filtering-Correlation-Id: 456e5f35-188f-4d31-9382-08df12fb2563
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|82310400026|376014|23010399003|18002099003|22082099003|3023799007|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: g2cw/rxlPdxvWBaa0dsT1yTxYXOaW1YBfpDdhD0leY1fW8ern7HlJn4xzbBvF2qUzt5SJmiMJvxLudaI75SoARUJ2psnEp9Kx68KT59aP2044xnG0vhzCGhbAmaFhPpkI0fdEL0AT+C4dziwChveZ1O5NIKacxDDl5FIqLt70tZSdFbySlM60w63KMCoN2pCQg0I9qFKJMCrFeHsMN7v1UFwmowZAFjFTBancD0VIEUqZKLjAnWCgndofVOYREqalcD/gfVhSkCs/y3wSxcGWZtyFjjsLiIIMj6eakBj+w8VCGEsmEjtg2bfWsowopfF38YkQBPQknfvKCoy7hZ7hHlf48s9MRjZzyZF9jwVJ09tdom0wqnJRZiWqnpuwt8+KGJ77nrPbn9MVDCxkzYFIpIppJL6gSzZjCUhtQaxqTX24HuNYRVoOOG26je6WlFDPQBFlVWGnjJIbQC2TOBtojnh8MZsvspgW8VON4ZhIV0OFBlsmMLaOL4FJGdbhfpY+GeUvYLo0mtJBkTg9mGXvn186Mmhhqh+HdxoSs6DMDD/qjZw/GcaxW3egQH6gzp7E8ZUThEo0QrWwOVMV6X02YKMmxXEWtC/BYd6UqdjN1w8tkJanOkIzTZO553NZHN7eGOCo/JtIN1n8hh0zIBNIrdFPKSQdI+aDcz7D4nQqzEDKvL8peZqUYjs9JJ6J3W6mVp6FVjZi3ASQVcnUxc1Ww==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(82310400026)(376014)(23010399003)(18002099003)(22082099003)(3023799007)(10067099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: qguGjwE3W6Bm1MECzPqJTU4oLYUeQCyrf6/V9VwA0c0vdyrJbCMEl90dqomcxP5GdFGI+oqBYAqenDKQPik0MILeQeS2Zkvg4g5TRmz2m4XCswyxtOWxZTA++jYmBqbf1g9whyCr6TXAJSRCRTqI+DzUI3OhtbepFKa7NeYuirlWGOu62LAvXdjc3l26cj9nfk4gsB/nI2+CV/W6bDvcj2wJYooje/cx1IPGOUEu8MmsadANRejWpN/bbBJL8O81QfNQumx55rNHknxDpU21kFFn/4K9ANTdSW+bp1UpDLBBa/KChgGXJ0ty6P5Ij8u7RqjodRjNU8dMZlkN6mmxr6fK1LURuDtRMlPa8TqIbAhyfBeBF110IzCjQBKda78hjI7sFdQpvKKCTPLHnV/mqqTq2c3HVeB8snfxFAIPT0X1ZBzuxyqXbfdWYuhuZRDo
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 07:29:58.1999 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 456e5f35-188f-4d31-9382-08df12fb2563
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5897
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

Add ras command to query partition info.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/ras/core/cmd.c            | 26 +++++++++++++++++++
 drivers/gpu/drm/amd/ras/core/cmd.h            | 13 ++++++++++
 drivers/gpu/drm/amd/ras/core/ras.h            |  3 +++
 .../gpu/drm/amd/ras/ras_mgr/amdgpu_ras_sys.c  |  8 ++++++
 4 files changed, 50 insertions(+)

diff --git a/drivers/gpu/drm/amd/ras/core/cmd.c b/drivers/gpu/drm/amd/ras/core/cmd.c
index 9f874800f38d..1f045d47fc3b 100644
--- a/drivers/gpu/drm/amd/ras/core/cmd.c
+++ b/drivers/gpu/drm/amd/ras/core/cmd.c
@@ -451,6 +451,31 @@ static int ras_cmd_get_ras_cap(struct ras_core_context *ras_core,
 	return 0;
 }
 
+static int ras_cmd_get_partition_info(struct ras_core_context *ras_core,
+	struct ras_cmd_ctx *cmd, void *data)
+{
+	struct ras_cmd_get_partition_info_rsp *output_data =
+			(struct ras_cmd_get_partition_info_rsp *)cmd->output_buff_raw;
+	struct device_system_info sys_info = {0};
+
+	if ((cmd->input_size != sizeof(struct ras_cmd_get_partition_info_req)) ||
+		(cmd->output_buf_size < sizeof(*output_data)))
+		return RAS_CMD__ERROR_INVALID_INPUT_SIZE;
+
+	memset(output_data, 0, sizeof(*output_data));
+
+	if (ras_core_get_device_system_info(ras_core, &sys_info))
+		return RAS_CMD__ERROR_GENERIC;
+
+	output_data->nps_mode = sys_info.nps_mode;
+	output_data->xcp_mode = sys_info.xcp_mode;
+
+	output_data->version = 0;
+	cmd->output_size = sizeof(*output_data);
+
+	return RAS_CMD__SUCCESS;
+}
+
 static struct ras_cmd_func_map ras_cmd_maps[] = {
 	{RAS_CMD__INJECT_ERROR, ras_cmd_inject_error},
 	{RAS_CMD__GET_BLOCK_ECC_STATUS, ras_get_block_ecc_info},
@@ -462,6 +487,7 @@ static struct ras_cmd_func_map ras_cmd_maps[] = {
 	{RAS_CMD__GET_BATCH_TRACE_SNAPSHOT, ras_cmd_get_batch_trace_snapshot},
 	{RAS_CMD__GET_BATCH_TRACE_RECORD, ras_cmd_get_batch_trace_records},
 	{RAS_CMD__GET_RAS_CAP, ras_cmd_get_ras_cap},
+	{RAS_CMD__GET_PARTITION_INFO, ras_cmd_get_partition_info},
 };
 
 int rascore_handle_cmd(struct ras_core_context *ras_core,
diff --git a/drivers/gpu/drm/amd/ras/core/cmd.h b/drivers/gpu/drm/amd/ras/core/cmd.h
index d3f5ec3c8e5c..79a713e0b785 100644
--- a/drivers/gpu/drm/amd/ras/core/cmd.h
+++ b/drivers/gpu/drm/amd/ras/core/cmd.h
@@ -78,6 +78,7 @@ enum ras_cmd_id {
 	RAS_CMD__CHECK_ADDRESS_VALIDITY,
 	RAS_CMD__CONVERT_RETIRED_ADDRESS,
 	RAS_CMD__GET_RAS_CAP,
+	RAS_CMD__GET_PARTITION_INFO,
 	RAS_CMD__SUPPORTED_MAX = RAS_CMD_ID_COMMON_END,
 };
 
@@ -492,6 +493,18 @@ struct ras_cmd_get_ras_cap_rsp {
 	uint32_t reserved[8];
 };
 
+struct ras_cmd_get_partition_info_req {
+	struct ras_cmd_dev_handle dev;
+	uint32_t reserved[4];
+};
+
+struct ras_cmd_get_partition_info_rsp {
+	uint32_t version;
+	uint32_t nps_mode;
+	int32_t xcp_mode;
+	uint32_t reserved[7];
+};
+
 #pragma pack(pop)
 
 int ras_cmd_init(struct ras_core_context *ras_core);
diff --git a/drivers/gpu/drm/amd/ras/core/ras.h b/drivers/gpu/drm/amd/ras/core/ras.h
index 5f133f3a8277..c21342fed32c 100644
--- a/drivers/gpu/drm/amd/ras/core/ras.h
+++ b/drivers/gpu/drm/amd/ras/core/ras.h
@@ -250,6 +250,9 @@ struct device_system_info {
 	uint32_t vendor_id;
 	uint32_t socket_id;
 	uint64_t unique_id;
+	uint32_t nps_mode;
+	int xcp_mode;
+	int vram_type;
 };
 
 enum gpu_mem_type {
diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_sys.c b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_sys.c
index dd8cdc2811f8..1bbbc383e373 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_sys.c
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_sys.c
@@ -228,6 +228,14 @@ static int amdgpu_ras_sys_get_device_system_info(struct ras_core_context *ras_co
 	dev_info->socket_id = adev->smuio.funcs->get_socket_id(adev);
 	dev_info->unique_id = adev->unique_id;
 
+	dev_info->xcp_mode = AMDGPU_UNKNOWN_COMPUTE_PARTITION_MODE;
+	if (adev->nbio.funcs && adev->nbio.funcs->get_compute_partition_mode)
+		dev_info->xcp_mode = adev->nbio.funcs->get_compute_partition_mode(adev);
+
+	dev_info->nps_mode = amdgpu_gmc_query_memory_partition(adev);
+
+	dev_info->vram_type = adev->gmc.vram_type;
+
 	return 0;
 }
 
-- 
2.43.0

