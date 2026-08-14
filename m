Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 277CEC5DF74
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Aug 2026 21:04:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A32FD10F755;
	Fri, 14 Aug 2026 21:04:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BWYh4tMV";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011038.outbound.protection.outlook.com [52.101.62.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D23A810F72E
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Aug 2026 21:03:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TT65U05hIsQiS7I2bbAk+CUywly0ZBaSTg8i/TujEqxxG8jAv0Pp+waIYzCKcs6E02mh4l2yUry2/zcMnK3BlEHZC7uSGdDOTBygK2oMmwvDg30sP2q39bUv/FZix6W+2c8/AQ6ldJguskyjIXs1mjA7Uq26MlDZ2zpUh2/LLpaAuNSTyHPgpgpaaCNauKYRrybeBZPd04WB7/NyDX2zKtye8iad0/qYvsANF8a4IWRQjHqWel/2KmLLuPDctNIk15Iypfp8XD+J7VhcaRCizxws2Vge9h80EzJttO4wn/wjKDEIO/LR1ButT8lP1r08CbvAkVF5X067YKlgGKSsRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lt7URsKp7ZNqasGPXcde6KBYq8BuluXItCLkg2xt7LU=;
 b=Tza8bKV5FhtuVtax+N0rgX8btnCupTHmRSjgAmpd7WM7J9Guf58RXp5fbpZf8gZooqxmESEY/5+FaWp6TyG+cq531jYjcuQsvfAUnPdCFh2X9Qdf9KhgnXBmsSftRD4RqAU03/1K/CJAV8MQdot/JQYhJ4gFajpcIOx3/77cYrLESv/z9I2ZCECGWyQJB5g6OXF+/UoJ3ZBGMgGlXotYLbTa4MtYhllXNbiehmNE7JdChCDyl1zs7r64K8bRLxtDFjCU7xfsZ6aG0WMPTu7UEL4bGhd9+q9BMG0SEowU6ao6ae5XrPvX2LlMQm4Tpcbw4uUH6zEqf0OO207I9PdYCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lt7URsKp7ZNqasGPXcde6KBYq8BuluXItCLkg2xt7LU=;
 b=BWYh4tMVuIpYBxXtAL33o+q83YAa9cUlaaRF2zOxmd7qmRNFkMLQ1Y7XNYK5hWlwo9R8piwgpdv6gqdDm7vv7LC/wJv9SbOjzZI7OBVuyaxFOG0tia1dY6XADKQFXEWX8Bb3ytoAuCvjhYyQvqS3tiqX83hf6PZGuko3WeQGXuI=
Received: from BN9PR03CA0506.namprd03.prod.outlook.com (2603:10b6:408:130::31)
 by MN6PR12MB8543.namprd12.prod.outlook.com (2603:10b6:208:47b::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.13; Fri, 14 Aug
 2026 21:03:56 +0000
Received: from BN2PEPF000044A1.namprd02.prod.outlook.com
 (2603:10b6:408:130:cafe::6e) by BN9PR03CA0506.outlook.office365.com
 (2603:10b6:408:130::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.15 via Frontend Transport; Fri,
 14 Aug 2026 21:03:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF000044A1.mail.protection.outlook.com (10.167.243.152) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Fri, 14 Aug 2026 21:03:55 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 14 Aug
 2026 16:03:52 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 14 Aug 2026 16:03:51 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: YiPeng Chai <YiPeng.Chai@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 091/109] drm/amd/ras: fix ras cmd returning incorrect cper
 count
Date: Fri, 14 Aug 2026 17:02:28 -0400
Message-ID: <20260814210246.3067612-92-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260814210246.3067612-1-alexander.deucher@amd.com>
References: <20260814210246.3067612-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A1:EE_|MN6PR12MB8543:EE_
X-MS-Office365-Filtering-Correlation-Id: b54b6345-50eb-41c3-f02d-08defa478db5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|82310400026|23010399003|10067099003|11063799006|22082099003|18002099003|56012099006|3023799007;
X-Microsoft-Antispam-Message-Info: IKR8Qki9EcSQeSGIE4BBhtWlaQmrPUzGGpgXgSN1oisMAWfid4SwVPuJDmR9hgUiY7vqMq0RjHgQ3pZuXpgRbgxCppGurSyRN+mbvoaotFm5Q9thuWmqgiBnArdNOpBruyuMpSFiQ7JbDwEmRKnYaZ3GM3TCR+bGAcj8i2H4b9N6crpkJSA7+oUh3SpVS/MsjWV/2O+G9qhVyQwpWTGUKETzf5J26/xlBg5cKaMzXL86eUS8xjXRAZxr35No7+LfOCRhDczXAVWxRv5P5EUjamBaR1ZeQRS4snC5OROPLkfQkRuvP3eRCRxcJ2SLefyVb7glDoroneVS1G15vqtgxlQNmAe4DwuiMUqAvEvVrxVcoijJBLBdJxxkfz7+HQlCcwbb8N3Gx/xaO9n8HYWlMNR9sRNOxluR5VdOQoUQ+zsS1dK1awu7kAyalTUjH7naDfbToVJB6ROzGpuNhKHWoIH7Pohls+ibbkekx7OpgG9RuM1YiOCM+viaDDL2Sq05SyADXUfxlLa7XxlwgvskMFkQxzV+HVgJFrPuWMN18pkUEAutAV97OwhVds+/SCl6SsAtCaQv3BKq0hIrH5XYM8FAMhDl28+Bo2znRlQjQdX89QG6A3lpImLnOmxS8AXmt0ZeWupV4jjlsWo1Jkwc18gkdCn3C23HMfSOnFpheByBmtQWG6/dP36F3q2ie3maF1/WcKm0IKxsVyFeKFw8RA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(82310400026)(23010399003)(10067099003)(11063799006)(22082099003)(18002099003)(56012099006)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: lpb3jj9he2hCDmzebCimoEMK/mhKKkj4Zv0puoujznbaUS3EJzadECjW7I0/5geMADU69cHbiqXKIju+kBBpRybKcl7SWgPOA1FJIqcHeWrKpyOdUm38FThNRQyg95vQM62fKGW/CF0ZSspmk1wDB83Sb3SRfM88GJrB/ssgoHbwVv7egZdzorM9rLaAdAGnBC5Ilzwz3mYhOYX/Y/Uxmt0Q81faDhI02TuwCoBIPBYA5FiFp3astHfPpz2Zldg/L/fvWBkTRrmvCPEHbXcQBvMNXb61bKr3MN18JdmwN8eIRnXllt8KTRAA/ZlZs4+VsDw6LNfB2x7K/n57GhYJJrQGc3YSpSJ1JyMbgY3hOzyl4ngP9twJ082Ncn8WM+oVkE7q+gb21iNoOoVULHdz0goAAcf0WqdgKCNyXr7zapQknancaUy+I5Nii9c3cVOY
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 21:03:55.9915 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b54b6345-50eb-41c3-f02d-08defa478db5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A1.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8543
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

From: YiPeng Chai <YiPeng.Chai@amd.com>

Fix ras cmd returning incorrect cper count.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/ras/core/cmd.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/ras/core/cmd.c b/drivers/gpu/drm/amd/ras/core/cmd.c
index ea5f6194d9863..2eb67ccc562d5 100644
--- a/drivers/gpu/drm/amd/ras/core/cmd.c
+++ b/drivers/gpu/drm/amd/ras/core/cmd.c
@@ -198,13 +198,13 @@ static int ras_cmd_get_cper_records(struct ras_core_context *ras_core,
 			(struct ras_cmd_cper_record_req *)cmd->input_buff_raw;
 	struct ras_cmd_cper_record_rsp *rsp =
 			(struct ras_cmd_cper_record_rsp *)cmd->output_buff_raw;
-	struct ras_log_info *trace = NULL;
-	uint32_t trace_count = MAX_RECORD_PER_BATCH;
+	struct ras_log_info *batch_logs = NULL;
+	uint32_t nr_batch_logs = MAX_RECORD_PER_BATCH;
 	struct ras_log_batch_overview overview;
 	uint32_t offset = 0, real_data_len = 0;
 	uint64_t batch_id;
 	uint8_t *buf_ptr = (uint8_t *)(uintptr_t)req->buf_ptr;
-	int ret = 0, i, count;
+	int ret = 0, i, count, valid_batch_count = 0;
 
 	if ((cmd->input_size != sizeof(struct ras_cmd_cper_record_req)) ||
 		(cmd->output_buf_size < sizeof(*rsp)))
@@ -214,8 +214,8 @@ static int ras_cmd_get_cper_records(struct ras_core_context *ras_core,
 	    req->buf_size > RAS_CMD_MAX_CPER_BUF_SZ)
 		return RAS_CMD__ERROR_INVALID_INPUT_DATA;
 
-	trace = kcalloc(trace_count, sizeof(*trace), GFP_KERNEL);
-	if (!trace) {
+	batch_logs = kcalloc(nr_batch_logs, sizeof(*batch_logs), GFP_KERNEL);
+	if (!batch_logs) {
 		ret = RAS_CMD__ERROR_GENERIC;
 		goto out;
 	}
@@ -226,14 +226,15 @@ static int ras_cmd_get_cper_records(struct ras_core_context *ras_core,
 		if (batch_id >= overview.last_batch_id)
 			break;
 
-		count = ras_log_ring_get_batch_records(ras_core, batch_id, trace,
-					trace_count);
+		count = ras_log_ring_get_batch_records(ras_core, batch_id, batch_logs,
+					nr_batch_logs);
 		if (count > 0) {
-			ret = ras_cper_generate_batch_cper(ras_core, trace, count,
+			ret = ras_cper_generate_batch_cper(ras_core, batch_logs, count,
 					&buf_ptr[offset], req->buf_size - offset, &real_data_len);
 			if (ret)
 				break;
 
+			valid_batch_count++;
 			offset += real_data_len;
 		}
 	}
@@ -244,7 +245,7 @@ static int ras_cmd_get_cper_records(struct ras_core_context *ras_core,
 	}
 
 	rsp->real_data_size = offset;
-	rsp->real_cper_num = i;
+	rsp->real_cper_num = valid_batch_count;
 	rsp->remain_num = (ret == -ENOMEM) ? (req->cper_num - i) : 0;
 	rsp->version = 0;
 
@@ -252,7 +253,7 @@ static int ras_cmd_get_cper_records(struct ras_core_context *ras_core,
 	ret = RAS_CMD__SUCCESS;
 
 out:
-	kfree(trace);
+	kfree(batch_logs);
 	return ret;
 }
 
-- 
2.55.0

