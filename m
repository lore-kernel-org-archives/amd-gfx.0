Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F9CECD4F51
	for <amd-gfx@archiver.kernel.org>; Mon, 18 May 2026 07:23:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D8D2A10E6C9;
	Mon, 18 May 2026 07:23:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sg7jeY0e";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012060.outbound.protection.outlook.com [40.107.209.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3829110E6BE
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 May 2026 07:23:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OaY34KY5mdjdkh9LI09/ddrTKjMDaQsIjuIB8pFJ7i4Gwo+3cneGL9M9Z09184GSEuoq1mcKnv7QRFdKV3oTRB0eWS50BXuMJn8VUysFodDPevuQfK/S1IXD9tM6iKYgCKcUGKb7oEQWGvTb9vUAbzIpzMml0cVhtEfwEm1OsW0PaBzRxXWlGIpTW6YX57wTc4YG6/z8tFvMI89aoP5ckkpnNptnnBtuMP13bSUyhE/ibT0ESTihV3uIpJKdva4lkPObVDfhQLKpUpw3/ANOcdbl6AssGFOrxhf2zWVAaW57h5X/svQRWEotRXgDAmydck8SivrVSssjRmHvjiugHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=66rCMqm+cap7MRLYR8Zuxw11gSx5KI1CNc2+g4OZBCw=;
 b=L5fHrGSwVzFafspIU4REP1bwvkmpLI7zwH3HMhTn6g2mFICwecTh+paXZwc6GeDt9HH0gqTxYo4iWc45AvWrmSSEByA2GJEbLZ9w+9HSOZzjAAyqW4Q+3Va2YckTx4cJKXFANSDA5MRNMMPx7LxiEKqJbCqR9uyNrzSQMQciAJYoh/P1r3i+eeRkOGSQUeYv3Pmq+DnWHRSXP/09kN0e06qvij00BuFFA0sFPOwFsJV/TGHgIVbrLGQiCGERTnI75OA+dMRMdFv2Hu9KNrYbJ9MqGxFKCntTiK5xIAni/KCBBG4m0hKo8AP2tf0YV1gGolmVfooYAn0Bs5v+YPbOLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=66rCMqm+cap7MRLYR8Zuxw11gSx5KI1CNc2+g4OZBCw=;
 b=sg7jeY0eP066Xq1X/U9K2o2w793c2dFHczj+4uwdNtY6o0bi7rWXrcf8N/AMG0f1uAqpnVgwbiHuySiiMQlQj00cWRxCJ97IOE2duxNlmdEL6vKhZVfuukAaUcP8J9fV5yO8UCH1Fh6tmWfSKvmA53Pbqt8KCkeQFHG7h0EVc+A=
Received: from MN2PR20CA0053.namprd20.prod.outlook.com (2603:10b6:208:235::22)
 by LV2PR12MB5845.namprd12.prod.outlook.com (2603:10b6:408:176::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.22; Mon, 18 May
 2026 07:23:25 +0000
Received: from BN2PEPF000044AB.namprd04.prod.outlook.com
 (2603:10b6:208:235:cafe::fd) by MN2PR20CA0053.outlook.office365.com
 (2603:10b6:208:235::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.23 via Frontend Transport; Mon, 18
 May 2026 07:23:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000044AB.mail.protection.outlook.com (10.167.243.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Mon, 18 May 2026 07:23:24 +0000
Received: from amd-03.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 18 May
 2026 02:23:22 -0500
From: YiPeng Chai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <yipechai@amd.com>, <Hawking.Zhang@amd.com>, <Tao.Zhou1@amd.com>,
 <Stanley.Yang@amd.com>, YiPeng Chai <YiPeng.Chai@amd.com>
Subject: [PATCH 6/7] drm/amd/ras: copy ras log data instead of referencing
 pointers
Date: Mon, 18 May 2026 15:22:14 +0800
Message-ID: <20260518072215.3647120-6-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260518072215.3647120-1-YiPeng.Chai@amd.com>
References: <20260518072215.3647120-1-YiPeng.Chai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AB:EE_|LV2PR12MB5845:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d64bd4c-50e2-4a95-4c0f-08deb4ae594d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700016|22082099003|18002099003|56012099003|3023799003|11063799003;
X-Microsoft-Antispam-Message-Info: TAYkcG6agX9LdcKFienQfa9drSUUBQYPLq6bsDcGNcXfFkyPdhXhJRgIXA4P7+VXjVKFbwekunkyGu4Z68MUPRiabYPTcxnsBjAAma8kIfJRdfW/oXOPI9B0lRQVxfy04GdqeItr/cf7saInR+orlvs7qoRvFZWDmEP5kSjOG8eCuGWsv9nBzV6/ee886Qauz1h0e9rgOuCabW9HWizsN4Xb1oU9u3YT2SaJ/Cz/DN0PnDnKHw3evqGvlEZCKj7jwrd4MeRyBh+CtV7tVap3WKfO0AK7Tl2kT6aPB/y+qDHpq7JS4c6VFuj/b+SQ2K08zWpDplMS1GqhcM6d3LElDymv7JG03F5rDAWKg9JsyVcZnRzKghDYY4F28gYZL1QkPNsoKy07WcsBi5M38XSsiUIs4Mg3bK5cJjFsroDHAfSaX/Dsr58hZyf3k+ofktbH8zlTSYrYidAYb4HZ5813wuu27pHHEABpSjsndo0iX3R2AR2YWtqzQ8e5w87mmImoZSyloxiF8vwqu7lvZQGqiWQITYu+YVV/lXWOJL/qP+uQi6xDgip5rKlA7zl5T4ZLuQ/2iRPG4KKDWqOa2CfwwMUsouxkuQsqSm7Bt6xvryBn+FZsZU4avkh7nKFD5jVYvsfCfRqLLlchL4d+r2meeJQIcHMZphzT7jPDLDGZz96/mztgSTKy41i+ExBWOhiQUxgoFKXjBdE11wl9AV1eIzGalIJXwU32GmjZS1lcveI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(22082099003)(18002099003)(56012099003)(3023799003)(11063799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 2IApnpMWnJR1AXbaSy36Gi4D00tNVDvbYbpD1ZQyDr5NerCFjKx16owZjIYr8ySfQZZsmR9YmzJX4IMN8BYzW4kjEU0Q8ShG7MvGuOKa/0l+JPisFwAWqfrtUiFjhPDzOU0hGFKPMhn8KhsALHIDpq/fwNCXe9U7XP1YQ1VNOOhN82UU4BP+ytN7Aijl9LuqCQDSkC4WvaADYpjmAopWzQFphpNm6SKqwCLUJYKvJ9PqVlsmTQ55ALMABATY1jHcKqavW9s1qPdZMvd8E06RAFLCjsgySdKRxpIgHsaYzabsMiFKNQb5z3+Agv6frfBYvcRgdnHkOTXsDBuI3qRIHZ610JLsKBIo9gOrXKD3BcKzB0qc7eHU3FZ7hto3w4JOGmS6SVklhUSw53cYiV7t9R3ab/1lNkkjU3fv7IDHfebCEdsrNQoqn6Nc26rIPle7
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 07:23:24.8339 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d64bd4c-50e2-4a95-4c0f-08deb4ae594d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044AB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5845
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

When generating ras cper file, the original data nodes in the ras
log ring buffer may be deleted, leading to invalid pointer
access. Copy the data from the ras log ring instead of directly
referencing the pointers to avoid this issue.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
---
 .../drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c | 12 +++---
 drivers/gpu/drm/amd/ras/rascore/ras_cmd.c     | 42 +++++++++++++------
 drivers/gpu/drm/amd/ras/rascore/ras_cper.c    | 20 ++++-----
 drivers/gpu/drm/amd/ras/rascore/ras_cper.h    |  2 +-
 .../gpu/drm/amd/ras/rascore/ras_log_ring.c    | 23 +++++-----
 .../gpu/drm/amd/ras/rascore/ras_log_ring.h    |  2 +-
 6 files changed, 58 insertions(+), 43 deletions(-)

diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c
index b8e9442b2ca5..537f709d8570 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c
@@ -219,7 +219,7 @@ static bool amdgpu_virt_ras_check_batch_cached(struct ras_cmd_batch_trace_record
 }
 
 static int amdgpu_virt_ras_get_batch_records(struct ras_core_context *ras_core, uint64_t batch_id,
-			struct ras_log_info **trace_arr, uint32_t arr_num,
+			struct ras_log_info *trace_arr, uint32_t arr_num,
 			struct ras_cmd_batch_trace_record_rsp *rsp_cache)
 {
 	struct ras_cmd_batch_trace_record_req req = {
@@ -255,7 +255,8 @@ static int amdgpu_virt_ras_get_batch_records(struct ras_core_context *ras_core,
 	}
 
 	for (i = 0; i < batch->trace_num && i < arr_num; i++)
-		trace_arr[i] = &rsp->records[batch->offset + i];
+		memcpy(&trace_arr[i],
+			&rsp->records[batch->offset + i], sizeof(*trace_arr));
 
 	return i;
 }
@@ -272,7 +273,8 @@ static int amdgpu_virt_ras_get_cper_records(struct ras_core_context *ras_core,
 		(struct ras_cmd_cper_record_rsp *)cmd->output_buff_raw;
 	struct ras_log_batch_overview *overview = &virt_ras->batch_mgr.batch_overview;
 	struct ras_cmd_batch_trace_record_rsp *rsp_cache = &virt_ras->batch_mgr.batch_trace;
-	struct ras_log_info **trace;
+	struct ras_log_info *trace;
+	uint32_t trace_count = MAX_RECORD_PER_BATCH;
 	uint32_t offset = 0, real_data_len = 0;
 	uint64_t batch_id;
 	uint8_t *out_buf;
@@ -289,7 +291,7 @@ static int amdgpu_virt_ras_get_cper_records(struct ras_core_context *ras_core,
 	    req->cper_num > RAS_CMD_MAX_CPER_FETCH_NUM)
 		return RAS_CMD__ERROR_INVALID_INPUT_DATA;
 
-	trace = kcalloc(MAX_RECORD_PER_BATCH, sizeof(*trace), GFP_KERNEL);
+	trace = kcalloc(trace_count, sizeof(*trace), GFP_KERNEL);
 	if (!trace)
 		return RAS_CMD__ERROR_GENERIC;
 
@@ -306,7 +308,7 @@ static int amdgpu_virt_ras_get_cper_records(struct ras_core_context *ras_core,
 		if (batch_id >= overview->last_batch_id)
 			break;
 		count = amdgpu_virt_ras_get_batch_records(ras_core, batch_id,
-							  trace, MAX_RECORD_PER_BATCH,
+							  trace, trace_count,
 							  rsp_cache);
 		if (count > 0) {
 			ret = ras_cper_generate_cper(ras_core, trace, count,
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_cmd.c b/drivers/gpu/drm/amd/ras/rascore/ras_cmd.c
index 5b7a36596b02..088b9b153f7f 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_cmd.c
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_cmd.c
@@ -202,11 +202,12 @@ static int ras_cmd_get_cper_records(struct ras_core_context *ras_core,
 			(struct ras_cmd_cper_record_req *)cmd->input_buff_raw;
 	struct ras_cmd_cper_record_rsp *rsp =
 			(struct ras_cmd_cper_record_rsp *)cmd->output_buff_raw;
-	struct ras_log_info *trace[MAX_RECORD_PER_BATCH] = {0};
+	struct ras_log_info *trace = NULL;
+	uint32_t trace_count = MAX_RECORD_PER_BATCH;
 	struct ras_log_batch_overview overview;
 	uint32_t offset = 0, real_data_len = 0;
 	uint64_t batch_id;
-	uint8_t *buffer;
+	uint8_t *buffer = NULL;
 	int ret = 0, i, count;
 
 	if ((cmd->input_size != sizeof(struct ras_cmd_cper_record_req)) ||
@@ -224,6 +225,12 @@ static int ras_cmd_get_cper_records(struct ras_core_context *ras_core,
 	if (!buffer)
 		return RAS_CMD__ERROR_GENERIC;
 
+	trace = kcalloc(trace_count, sizeof(*trace), GFP_KERNEL);
+	if (!trace) {
+		ret = RAS_CMD__ERROR_GENERIC;
+		goto out;
+	}
+
 	ras_log_ring_get_batch_overview(ras_core, &overview);
 	for (i = 0; i < req->cper_num; i++) {
 		batch_id = req->cper_start_id + i;
@@ -231,7 +238,7 @@ static int ras_cmd_get_cper_records(struct ras_core_context *ras_core,
 			break;
 
 		count = ras_log_ring_get_batch_records(ras_core, batch_id, trace,
-					ARRAY_SIZE(trace));
+					trace_count);
 		if (count > 0) {
 			ret = ras_cper_generate_cper(ras_core, trace, count,
 					&buffer[offset], req->buf_size - offset, &real_data_len);
@@ -244,8 +251,8 @@ static int ras_cmd_get_cper_records(struct ras_core_context *ras_core,
 
 	if ((ret && (ret != -ENOMEM)) ||
 		copy_to_user(u64_to_user_ptr(req->buf_ptr), buffer, offset)) {
-		kfree(buffer);
-		return RAS_CMD__ERROR_GENERIC;
+		ret = RAS_CMD__ERROR_GENERIC;
+		goto out;
 	}
 
 	rsp->real_data_size = offset;
@@ -254,10 +261,12 @@ static int ras_cmd_get_cper_records(struct ras_core_context *ras_core,
 	rsp->version = 0;
 
 	cmd->output_size = sizeof(struct ras_cmd_cper_record_rsp);
+	ret = RAS_CMD__SUCCESS;
 
+out:
+	kfree(trace);
 	kfree(buffer);
-
-	return RAS_CMD__SUCCESS;
+	return ret;
 }
 
 static int ras_cmd_get_batch_trace_snapshot(struct ras_core_context *ras_core,
@@ -291,7 +300,8 @@ static int ras_cmd_get_batch_trace_records(struct ras_core_context *ras_core,
 	struct ras_cmd_batch_trace_record_rsp *output_data =
 			(struct ras_cmd_batch_trace_record_rsp *)cmd->output_buff_raw;
 	struct ras_log_batch_overview overview;
-	struct ras_log_info *trace_arry[MAX_RECORD_PER_BATCH] = {0};
+	struct ras_log_info *trace_arry = NULL;
+	uint32_t trace_count = MAX_RECORD_PER_BATCH;
 	struct ras_log_info *record;
 	int i, j, count = 0, offset = 0;
 	uint64_t id;
@@ -309,6 +319,10 @@ static int ras_cmd_get_batch_trace_records(struct ras_core_context *ras_core,
 	    (input_data->start_batch_id >= overview.last_batch_id))
 		return RAS_CMD__ERROR_INVALID_INPUT_SIZE;
 
+	trace_arry = kcalloc(trace_count, sizeof(*trace_arry), GFP_KERNEL);
+	if (!trace_arry)
+		return RAS_CMD__ERROR_GENERIC;
+
 	for (i = 0; i < input_data->batch_num; i++) {
 		id = input_data->start_batch_id + i;
 		if (id >= overview.last_batch_id) {
@@ -317,17 +331,17 @@ static int ras_cmd_get_batch_trace_records(struct ras_core_context *ras_core,
 		}
 
 		count = ras_log_ring_get_batch_records(ras_core,
-					id, trace_arry, ARRAY_SIZE(trace_arry));
+					id, trace_arry, trace_count);
 		if (count > 0) {
 			if ((offset + count) > RAS_CMD_MAX_TRACE_NUM)
 				break;
 			for (j = 0; j < count; j++) {
 				record = &output_data->records[offset + j];
-				record->seqno = trace_arry[j]->seqno;
-				record->timestamp = trace_arry[j]->timestamp;
-				record->event = trace_arry[j]->event;
+				record->seqno = trace_arry[j].seqno;
+				record->timestamp = trace_arry[j].timestamp;
+				record->event = trace_arry[j].event;
 				memcpy(&record->aca_reg,
-					&trace_arry[j]->aca_reg, sizeof(trace_arry[j]->aca_reg));
+					&trace_arry[j].aca_reg, sizeof(trace_arry[j].aca_reg));
 			}
 		} else {
 			count = 0;
@@ -346,6 +360,8 @@ static int ras_cmd_get_batch_trace_records(struct ras_core_context *ras_core,
 
 	cmd->output_size = sizeof(struct ras_cmd_batch_trace_record_rsp);
 
+	kfree(trace_arry);
+
 	return RAS_CMD__SUCCESS;
 }
 
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_cper.c b/drivers/gpu/drm/amd/ras/rascore/ras_cper.c
index 0fc7522b7ab6..6e93a13bbc4c 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_cper.c
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_cper.c
@@ -175,14 +175,14 @@ static int fill_section_runtime(struct ras_core_context *ras_core,
 }
 
 static int cper_generate_runtime_record(struct ras_core_context *ras_core,
-	struct cper_section_hdr *hdr, struct ras_log_info **trace_arr, uint32_t arr_num,
+	struct cper_section_hdr *hdr, struct ras_log_info *trace_arr, uint32_t arr_num,
 		enum ras_cper_severity sev)
 {
 	struct cper_section_descriptor *descriptor;
 	struct cper_section_runtime *runtime;
 	int i;
 
-	fill_section_hdr(ras_core, hdr, RAS_CPER_TYPE_RUNTIME, sev, trace_arr[0]);
+	fill_section_hdr(ras_core, hdr, RAS_CPER_TYPE_RUNTIME, sev, &trace_arr[0]);
 	hdr->record_length =  RAS_HDR_LEN + ((RAS_SEC_DESC_LEN + RAS_NONSTD_SEC_LEN) * arr_num);
 	hdr->sec_cnt = arr_num;
 	for (i = 0; i < arr_num; i++) {
@@ -194,21 +194,21 @@ static int cper_generate_runtime_record(struct ras_core_context *ras_core,
 		fill_section_descriptor(ras_core, descriptor, sev, RUNTIME,
 			RAS_NONSTD_SEC_OFFSET(hdr->sec_cnt, i),
 			sizeof(struct cper_section_runtime));
-		fill_section_runtime(ras_core, runtime, trace_arr[i], sev);
+		fill_section_runtime(ras_core, runtime, &trace_arr[i], sev);
 	}
 
 	return 0;
 }
 
 static int cper_generate_fatal_record(struct ras_core_context *ras_core,
-	uint8_t *buffer, struct ras_log_info **trace_arr, uint32_t arr_num)
+	uint8_t *buffer, struct ras_log_info *trace_arr, uint32_t arr_num)
 {
 	struct ras_cper_fatal_record record = {0};
 	int i = 0;
 
 	for (i = 0; i < arr_num; i++) {
 		fill_section_hdr(ras_core, &record.hdr, RAS_CPER_TYPE_FATAL,
-				 RAS_CPER_SEV_FATAL_UE, trace_arr[i]);
+				 RAS_CPER_SEV_FATAL_UE, &trace_arr[i]);
 		record.hdr.record_length =  RAS_HDR_LEN + RAS_SEC_DESC_LEN + RAS_FATAL_SEC_LEN;
 		record.hdr.sec_cnt = 1;
 
@@ -216,7 +216,7 @@ static int cper_generate_fatal_record(struct ras_core_context *ras_core,
 					CRASHDUMP, offsetof(struct ras_cper_fatal_record, fatal),
 					sizeof(struct cper_section_fatal));
 
-		fill_section_fatal(ras_core, &record.fatal, trace_arr[i]);
+		fill_section_fatal(ras_core, &record.fatal, &trace_arr[i]);
 
 		memcpy(buffer + (i * record.hdr.record_length),
 				&record, record.hdr.record_length);
@@ -271,7 +271,7 @@ static enum ras_cper_type cper_ras_log_event_to_cper_type(enum ras_log_event eve
 }
 
 int ras_cper_generate_cper(struct ras_core_context *ras_core,
-		struct ras_log_info **trace_list, uint32_t count,
+		struct ras_log_info *trace_list, uint32_t count,
 		uint8_t *buf, uint32_t buf_len, uint32_t *real_data_len)
 {
 	uint8_t *buffer = buf;
@@ -281,14 +281,14 @@ int ras_cper_generate_cper(struct ras_core_context *ras_core,
 
 	/* All the batch traces share the same event */
 	record_size = cper_get_record_size(
-			cper_ras_log_event_to_cper_type(trace_list[0]->event), count);
+			cper_ras_log_event_to_cper_type(trace_list[0].event), count);
 
 	if ((record_size + saved_size) > buf_size)
 		return -ENOMEM;
 
 	hdr = (struct cper_section_hdr *)(buffer + saved_size);
 
-	switch (trace_list[0]->event) {
+	switch (trace_list[0].event) {
 	case RAS_LOG_EVENT_RMA:
 		cper_generate_runtime_record(ras_core, hdr, trace_list, count, RAS_CPER_SEV_RMA);
 		break;
@@ -304,7 +304,7 @@ int ras_cper_generate_cper(struct ras_core_context *ras_core,
 		cper_generate_fatal_record(ras_core, buffer + saved_size, trace_list, count);
 		break;
 	default:
-		RAS_DEV_WARN(ras_core->dev, "Unprocessed trace event: %d\n", trace_list[0]->event);
+		RAS_DEV_WARN(ras_core->dev, "Unprocessed trace event: %d\n", trace_list[0].event);
 		break;
 	}
 
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_cper.h b/drivers/gpu/drm/amd/ras/rascore/ras_cper.h
index 076c1883c1ce..e4e3615ecc2e 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_cper.h
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_cper.h
@@ -299,6 +299,6 @@ struct ras_cper_fatal_record {
 struct ras_core_context;
 struct ras_log_info;
 int ras_cper_generate_cper(struct ras_core_context *ras_core,
-		struct ras_log_info **trace_list, uint32_t count,
+		struct ras_log_info *trace_list, uint32_t count,
 		uint8_t *buf, uint32_t buf_len, uint32_t *real_data_len);
 #endif
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_log_ring.c b/drivers/gpu/drm/amd/ras/rascore/ras_log_ring.c
index 0a838fdcb2f6..c2fca1a1e780 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_log_ring.c
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_log_ring.c
@@ -265,8 +265,8 @@ void ras_log_ring_add_log_event(struct ras_core_context *ras_core,
 	ras_log_ring_add_data(ras_core, log, batch_tag);
 }
 
-static struct ras_log_info *ras_log_ring_lookup_data(struct ras_core_context *ras_core,
-					uint64_t idx)
+static int ras_log_ring_lookup_data(struct ras_core_context *ras_core,
+					uint64_t idx, struct ras_log_info *log)
 {
 	struct ras_log_ring *log_ring = &ras_core->ras_log_ring;
 	unsigned long flags = 0;
@@ -274,30 +274,27 @@ static struct ras_log_info *ras_log_ring_lookup_data(struct ras_core_context *ra
 
 	spin_lock_irqsave(&log_ring->spin_lock, flags);
 	data = radix_tree_lookup(&log_ring->ras_log_root, idx);
+	if (data)
+		memcpy(log, data, sizeof(*log));
 	spin_unlock_irqrestore(&log_ring->spin_lock, flags);
 
-	return (struct ras_log_info *)data;
+	return data ? 0 : -ENODATA;
 }
 
 int ras_log_ring_get_batch_records(struct ras_core_context *ras_core, uint64_t batch_id,
-		struct ras_log_info **log_arr, uint32_t arr_num)
+		struct ras_log_info *log_arr, uint32_t arr_num)
 {
 	struct ras_log_ring *log_ring = &ras_core->ras_log_ring;
 	uint32_t i, idx, count = 0;
-	void *data;
 
-	if ((batch_id >= log_ring->mono_upward_batch_id) ||
+	if (!log_arr || !arr_num || (batch_id >= log_ring->mono_upward_batch_id) ||
 		(batch_id < log_ring->last_del_batch_id))
 		return -EINVAL;
 
-	for (i = 0; i < MAX_RECORD_PER_BATCH; i++) {
+	for (i = 0; i < MAX_RECORD_PER_BATCH && i < arr_num; i++) {
 		idx = BATCH_IDX_TO_TREE_IDX(batch_id, i);
-		data = ras_log_ring_lookup_data(ras_core, idx);
-		if (data) {
-			log_arr[count++] = data;
-			if (count >= arr_num)
-				break;
-		}
+		if (!ras_log_ring_lookup_data(ras_core, idx, &log_arr[count]))
+			count++;
 	}
 
 	return count;
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_log_ring.h b/drivers/gpu/drm/amd/ras/rascore/ras_log_ring.h
index 0ff6cc35678d..cb66beaa9f43 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_log_ring.h
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_log_ring.h
@@ -86,7 +86,7 @@ void ras_log_ring_add_log_event(struct ras_core_context *ras_core,
 		enum ras_log_event event, void *data, struct ras_log_batch_tag *tag);
 
 int ras_log_ring_get_batch_records(struct ras_core_context *ras_core, uint64_t batch_idx,
-		struct ras_log_info **log_arr, uint32_t arr_num);
+		struct ras_log_info *log_arr, uint32_t arr_num);
 
 int ras_log_ring_get_batch_overview(struct ras_core_context *ras_core,
 		struct ras_log_batch_overview *overview);
-- 
2.43.0

