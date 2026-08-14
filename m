Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B268CC5DF70
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Aug 2026 21:04:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A641C10F74C;
	Fri, 14 Aug 2026 21:04:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fs/TXURY";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011006.outbound.protection.outlook.com [52.101.57.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0EC6510F73E
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Aug 2026 21:04:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xGDWocKlwySBBrvZNlBkvxHMnSeqa8OEokTDhfxaP1jWj5vng1MEOH3GVveMMtznd4PW+0Eb/gbb2qiM4N34PvfykdWPuZr/DyER7QNdGIIFcNdXw5CTwIP/Jk3jcvZE6TJm+tvDQZiLKiw2vLeDpc1JchuYINKbtqTgPk3+Fj2U2glbFmRQ3cFvOkSgTPsZ6u4QtvyG+D+KsucGsSn23GkLm9q45JNCrSqDbeVXpWijFzz0ewn6Y9Cje+u+u2tmx4kLXbmhgU1NxhuN0DRZLeJoQnCcYYeFWdOsW7Tl3J3wl+z/IJMqjAr/JRcxbqpelgPPtO+IcOfx39nLh7nB7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ul76pp2besVT0pOvGAWdw7bwFNphHgHJR20fkO8jAQg=;
 b=gxlgLZgRB5bEk794eB/WzBg+wG2dcTNXX3A0iMLtDUjNcZS9E3AL6B4vNhOzNk4HHEigczcQM87HL3DQb+VjM4iPM3IF0gf+2NrK75OX6uodssVqhOUwEBuOZNgWYcoFbU0Ns82OOrVPy3U167q1QFPurCgS4HZ+0CpunjkKAi/LrbiWVRGtPaUd55zQ4tnRGEypEPboT09yZbDPUopYw0xwgmNVYcjmKGWSKBGK8dA2wK3SfavrBjF+560YOPrh1Nu+lxKbWtMOMfTzOSy/plFyF8Sz1+VfNpYjJGNfBSrDCaiHpZiZm4TdDKvmQj2I+JZvIOEKnqLGm1jZsl4SuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ul76pp2besVT0pOvGAWdw7bwFNphHgHJR20fkO8jAQg=;
 b=fs/TXURYD2Kb7EUFrZu6yTpB/H97v8h+SCzvAtdJCuyzK1M8FEr1x5aUyPNpSgz9RctQJck/QGUotr1UlOxTPAVHDfpnKC849PXuvFFj6vEPrFmrZ7mT2ZSMIueWjB3idYx6G/nyUmd1DwIIsN1iSkCuhRpiG9wA2CJtRCUhcT8=
Received: from BN0PR03CA0048.namprd03.prod.outlook.com (2603:10b6:408:e7::23)
 by PH7PR12MB7966.namprd12.prod.outlook.com (2603:10b6:510:274::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.15; Fri, 14 Aug
 2026 21:04:08 +0000
Received: from BN2PEPF000044A0.namprd02.prod.outlook.com
 (2603:10b6:408:e7:cafe::62) by BN0PR03CA0048.outlook.office365.com
 (2603:10b6:408:e7::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.15 via Frontend Transport; Fri,
 14 Aug 2026 21:04:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF000044A0.mail.protection.outlook.com (10.167.243.151) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Fri, 14 Aug 2026 21:04:08 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 14 Aug
 2026 16:04:02 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 14 Aug 2026 16:04:01 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Xiang Liu <xiang.liu@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 109/109] drm/amd/ras: fix CPER command record retrieval
Date: Fri, 14 Aug 2026 17:02:46 -0400
Message-ID: <20260814210246.3067612-110-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260814210246.3067612-1-alexander.deucher@amd.com>
References: <20260814210246.3067612-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A0:EE_|PH7PR12MB7966:EE_
X-MS-Office365-Filtering-Correlation-Id: f31b8011-5fe5-46c0-a3af-08defa479507
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|1800799024|36860700016|376014|6133799003|10067099003|3023799007|5023799004|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: KVL1vgc1zJcIGdPyvcXu0o8kHWP4+d6J38GYiNFtG0cLtoAQT+qTC9vHMmbI5IIaDT6uwhZz+dU1SX0ebWIW9BMvrofBsg0yPQO2fDCI+i8ERpuiksy4sS1p/41dkAFk3yUdA7PsU8HO3Rl9RUAml/Pm6kNg44SKm0Fc0Kh0rdRDjQ0Iapj9Mh7wTQV3BoNzDjbDwsCSFIwCNPWYJyWGw/jWsm+KZep8MtRTdoT6FUCo86O8+9eQSMb1yMCD870zUwjf1+mvogIy2Zb1WHAcJp4q2liCPZvjg6eb5H1RpOjA7qI6R1hM2pHmp1ZwjCWtwz0OtRyUEz5718IyMPh6lIlNU+HkMFkvVzkkVcGNfxYl2SjIDxCdHhErJW0z3vwbqRm7l37BcGLJ/0T8+H72cZJJKxlF9PZWJqrdo5Q/Rx8hxwzrjfwKe0gKnJ+ri7C+1EdQBoJqVfkij1/EZufnfZafv3bCfLVILxHmVtWBxprkrT4kKWliJYr8dlOckyVDn3xcl32J/Q9/TPMpZrjEFKlLIUzE3VReGW0Qkp1LF2kYR5NNHCxFrbOu50VpLesMwZj/5zAPmnSYL8ppXWrtRuWMJbFO0KRYDsh4xvRS84AXRh6Q1UJpgQSXn4sbs5/hj4ODRb5WTq70rV9REkBuAIf9PLmDUbNG4bqpEh+0hecoXB34yGpGrmLwj6RDbycf9sQsuY5vG28pWV2FAclPTQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(1800799024)(36860700016)(376014)(6133799003)(10067099003)(3023799007)(5023799004)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: iyKBwIRcOXvurLlGHb7oI/5DtMGpTxMTsBYmGDF6sZ87lLtKC3xmk6lpziep6D78hAucr/jGB/xE3x85j0rsWKZPn2U26P1zGEVCOuRmZHDzGq2e+VhVMAKuvK1nLI7xGRjfvm6UuVLWRO9di32NNzWkkDfr1MzYYv8J/09nuXBwS+ApuXjqvgARgEmBXEq6vr9AZDaNWpvtpINDGSh0wJfcPQTFTPuyDsB7GyjaCLmD7yifUJzatv0v2vzhd01+f9acqTlnAU+5ETnszL8gq3jkO00QGLr3UnmG8vAleYyYmGsoFeWFQ6WfD3Ev0YlhhmspZ9RYmbZp2wIbvvwRKMrRywdAgmFHGMRx6QlFPOQvrph6z52z/h6T8b/26ENBXrH3kBYas+BWRHHITVVx2xCZJwBiptlK5ewuViUhS4xQy4uDypwxJawCQP+Y9Ggr
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 21:04:08.2696 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f31b8011-5fe5-46c0-a3af-08defa479507
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A0.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7966
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

From: Xiang Liu <xiang.liu@amd.com>

The CPER command reports the next batch ID as the latest valid record
and does not handle a request starting at the write pointer. Batch trace
responses also copy only the ACA interpretation of the log union.

Report the latest valid CPER ID, select the preceding record for a write
pointer request, expose a bounded command transfer size, and copy the
complete log body for batch trace records.

Signed-off-by: Xiang Liu <xiang.liu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/ras/core/cmd.c | 23 +++++++++++++++++------
 drivers/gpu/drm/amd/ras/core/cmd.h |  2 ++
 2 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/ras/core/cmd.c b/drivers/gpu/drm/amd/ras/core/cmd.c
index 2eb67ccc562d5..66bd62a819b2e 100644
--- a/drivers/gpu/drm/amd/ras/core/cmd.c
+++ b/drivers/gpu/drm/amd/ras/core/cmd.c
@@ -174,16 +174,18 @@ static int ras_cmd_get_cper_snapshot(struct ras_core_context *ras_core,
 	struct ras_cmd_cper_snapshot_rsp *output_data =
 			(struct ras_cmd_cper_snapshot_rsp *)cmd->output_buff_raw;
 	struct ras_log_batch_overview overview;
+	u64 latest_cper_id;
 
 	if ((cmd->input_size != sizeof(struct ras_cmd_cper_snapshot_req)) ||
 		(cmd->output_buf_size < sizeof(*output_data)))
 		return RAS_CMD__ERROR_INVALID_INPUT_SIZE;
 
 	ras_log_ring_get_batch_overview(ras_core, &overview);
+	latest_cper_id = overview.logged_batch_count ? overview.last_batch_id - 1 : 0;
 
 	output_data->total_cper_num = overview.logged_batch_count;
 	output_data->start_cper_id = overview.first_batch_id;
-	output_data->latest_cper_id = overview.last_batch_id;
+	output_data->latest_cper_id = latest_cper_id;
 
 	output_data->version = 0;
 
@@ -202,7 +204,7 @@ static int ras_cmd_get_cper_records(struct ras_core_context *ras_core,
 	uint32_t nr_batch_logs = MAX_RECORD_PER_BATCH;
 	struct ras_log_batch_overview overview;
 	uint32_t offset = 0, real_data_len = 0;
-	uint64_t batch_id;
+	u64 batch_id, start_batch_id;
 	uint8_t *buf_ptr = (uint8_t *)(uintptr_t)req->buf_ptr;
 	int ret = 0, i, count, valid_batch_count = 0;
 
@@ -221,14 +223,24 @@ static int ras_cmd_get_cper_records(struct ras_core_context *ras_core,
 	}
 
 	ras_log_ring_get_batch_overview(ras_core, &overview);
+
+	start_batch_id = req->cper_start_id;
+	if (overview.logged_batch_count && start_batch_id == overview.last_batch_id)
+		start_batch_id = overview.last_batch_id - 1;
+
 	for (i = 0; i < req->cper_num; i++) {
-		batch_id = req->cper_start_id + i;
+		batch_id = start_batch_id + i;
 		if (batch_id >= overview.last_batch_id)
 			break;
 
 		count = ras_log_ring_get_batch_records(ras_core, batch_id, batch_logs,
 					nr_batch_logs);
 		if (count > 0) {
+			if (offset >= req->buf_size) {
+				ret = -ENOMEM;
+				break;
+			}
+
 			ret = ras_cper_generate_batch_cper(ras_core, batch_logs, count,
 					&buf_ptr[offset], req->buf_size - offset, &real_data_len);
 			if (ret)
@@ -328,9 +340,8 @@ static int ras_cmd_get_batch_trace_records(struct ras_core_context *ras_core,
 				record->seqno = trace_arry[j].seqno;
 				record->timestamp = trace_arry[j].timestamp;
 				record->event = trace_arry[j].event;
-				memcpy(&record->body.aca_reg,
-					&trace_arry[j].body.aca_reg,
-					sizeof(trace_arry[j].body.aca_reg));
+				memcpy(&record->body, &trace_arry[j].body,
+				       sizeof(record->body));
 			}
 		} else {
 			count = 0;
diff --git a/drivers/gpu/drm/amd/ras/core/cmd.h b/drivers/gpu/drm/amd/ras/core/cmd.h
index a37b050e913ab..d3f5ec3c8e5c6 100644
--- a/drivers/gpu/drm/amd/ras/core/cmd.h
+++ b/drivers/gpu/drm/amd/ras/core/cmd.h
@@ -359,6 +359,8 @@ struct ras_cmd_cper_snapshot_rsp {
 	uint64_t latest_cper_id;
 };
 
+#define RAS_CMD_MAX_CPER_BUF_SZ	(2 * 1024U * 1024U) /* 2 MiB */
+
 struct ras_cmd_cper_record_req {
 	struct ras_cmd_dev_handle dev;
 	uint64_t cper_start_id;
-- 
2.55.0

