Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EED1D2F7E4
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Dec 2025 12:15:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4296510EB04;
	Fri,  5 Dec 2025 12:15:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CSiVbJ3T";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012020.outbound.protection.outlook.com [40.107.209.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E03010EB04
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Dec 2025 12:15:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IHhHeKv9FuvLw8kfYsvvAYR2cB0raDFXFjxdwTi9vBIKOGpp4G/RaS6bA2RZ4VF3rPluzz2yvyp2f3Mh3B89HHj/CsnL4D8iM4Wm9b+eAs1MZZwdta++ECxwkYRN/RxSHi0UiQAQQIcVfBilmFJRuoQsgO4P/T9nr2ok7mFss/dIEiYKefPzBDj7iSMMU/JJxoLELKlKw1JuFfKfMucrWzDiSkfirhzD44LLgZk9kUUQEQ6xypKjEDzASh77pQNJzDYuUaZGV8j2HbZMQb/v+1OoQxqQKZuQ4G83pBcSpIi5zLBYgxNc6Pd6qCmt2Yh4RvdhUBjou2mWMHxDaqQqZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ECb0wdcpvxLSYt9Oc3NH1LPc8IWfxuL2AMRqrENHjL8=;
 b=cV7fBo37mZBSUlIawE1L2uIJLc8Ld3fRwRozpbYV6bi6CE7a/h26ha6dHLsGJ4YWbW4CKeycITYuKXcQIPSCAkAK/wGI5hJoW/I/3JAxQe6b+4rMmVQETV/ZF/6iFtixs32kHyJ+2kmk8GL4luJ7qysUXjVQ7Dy51RomM10HGOkgzPhumxNainDsTRpwzR6SbO6Po0OGSSGjl4DUpT7LGnYHdpUo8SGA8qEq8/6MzqihZDcmfwi8wB5XrejVV/+QREix+ujiieremhDDhISi8VnIBuP3F+DLObCbH1pI6ywsgZnOa548r7ZTi/H34IQi1NcSKdBOtqeK8mI4sis33A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ECb0wdcpvxLSYt9Oc3NH1LPc8IWfxuL2AMRqrENHjL8=;
 b=CSiVbJ3TU+rjdNheaFN9eaVTu4MjTXdfEDB0JwyEB4WLIfwLRZzUI1bcnHXo0eZjVrYNQaItIDSrsKC+CBpalBQZBcMbQwmSHAfQXROsbZD54iNtuP4TDym2QPyKFojNHTp0tzX0sKEsA3wztB9qfhffhTDen1yol+tvzwS+R8w=
Received: from PH5P220CA0002.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:34a::17)
 by MN6PR12MB8516.namprd12.prod.outlook.com (2603:10b6:208:46f::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.11; Fri, 5 Dec
 2025 12:15:26 +0000
Received: from SN1PEPF0002BA4D.namprd03.prod.outlook.com
 (2603:10b6:510:34a:cafe::57) by PH5P220CA0002.outlook.office365.com
 (2603:10b6:510:34a::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.12 via Frontend Transport; Fri,
 5 Dec 2025 12:15:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002BA4D.mail.protection.outlook.com (10.167.242.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Fri, 5 Dec 2025 12:15:25 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 5 Dec 2025 06:15:23 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Tao Zhou <tao.zhou1@amd.com>, Hawking Zhang
 <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amd/ras: Reduce stack usage in
 amdgpu_virt_ras_get_cper_records()
Date: Fri, 5 Dec 2025 17:45:10 +0530
Message-ID: <20251205121510.408539-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4D:EE_|MN6PR12MB8516:EE_
X-MS-Office365-Filtering-Correlation-Id: 9fe11a1c-1085-4cfe-06e3-08de33f7f8ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dytQbERvVFdqZ0tQNGtZWDVvZmdWSjgrM09EQitRVWFpTmZSRVhVMDBReU5T?=
 =?utf-8?B?TFg2NVFSb3hYd1hyNTJUSlllSHpvR2JFOHBNQllmZUUvVVhoYjZLc29sNzY5?=
 =?utf-8?B?cXZoVGZPT09JYXUySjltZStnclg0YVJKNHdtM1RzL2V2S3pKak9oNUl5cEJ1?=
 =?utf-8?B?Y2xCZzhkUndLdjVJSjhhNVZrM2xzLzVkdlpkbHBzaVYzU1VtS2JLQ1JaTitY?=
 =?utf-8?B?UDZXelo1dVFuSGkybVp2SDVsWmtpRFp5QnlhbVdyc01UcUlwdFNxcERTdGFk?=
 =?utf-8?B?bExSR1FjS1VrMGowNyszS1JEanRURk12ZExqemNkM09lOEIyYVlJeHlqMVNN?=
 =?utf-8?B?TWdYN0dYUTErTlJwemlUVUI2QzZZR0xMOWNwTFhUVGZLT1QwT1VKRUE0d2dD?=
 =?utf-8?B?WFFyT216dVBleGszNjMwWFhGSXJ1OGhnT0hMYUpmTjBrWjRGUEZ4YVA5dldZ?=
 =?utf-8?B?RkI0SUZpcHJ1TG0yeXdVSXhLRmFGQ3hLcVRHQ3BsNnNRVk1QOE9IT0duaC9w?=
 =?utf-8?B?clVQaTduNm13MkY0UWVqOVRqaytLdGxwZ2VuY0VVTTVLOVlqZmgrWDBMR0dS?=
 =?utf-8?B?TDErQll1bWY1b3dpd0hCRDFQRlN2OWNYKzcrVkhuVEhUY0ViTjNwVEpvUlBN?=
 =?utf-8?B?aUg4dWRBWE1ndFJVVUtIcEdtUUVUNms2MlE1bDNRYVRTSG5WUm9PVUpiYVdt?=
 =?utf-8?B?QXBjeHJLSURQTmZ1ZFN5RmJncTgreGQrMDdDeDRWejlQWEZXQlBRUDJhcVVt?=
 =?utf-8?B?a2FoTFRDYkNJNGNCS2JjOHUydzlqZGQ2S2pSNVcvZDR1QUY2VWs0QUlFNHNT?=
 =?utf-8?B?Rk43NzJBamNoWFFsTm5HakpZSklwcFhFK0w1RnNzZ3NGQ1lYR2FBSldCcmQ3?=
 =?utf-8?B?TG9IT2ZTcVlmUXo2NGppWW4ybGU1eDRmYWtiUDZpdXlhODVtNk9qOURxZFBG?=
 =?utf-8?B?ZEE2OHVNeCt4anJIN2lIZTdGL3AxVG9tOEorT1FuNldRNG41YWdENmtaOExT?=
 =?utf-8?B?L0s2MjNUSVNjZ2NmZEFybGpXaVIyVWZRcUM2NExob3lmZ1U5TG5Fejh2UWVt?=
 =?utf-8?B?YW41VFhFT1NiazBxRE1Qc2hTOE1Vb1hEdTd0cTRSRlZCQkVHTjdjRjJjMWtw?=
 =?utf-8?B?d3dLNU1uNGVYNmNoaUw0ZncwVWJIYUhnSDFvMlFvUVN3OWhUVzFwTlBOUzVL?=
 =?utf-8?B?WWVQdGV4ZjBWaU9DYllRZEFGcTgvaVRJOUFuZnBDVTJORUhUMERIYkdnenkz?=
 =?utf-8?B?UngwV1A3bW1tR1Z0WllFQXAyZTNzQUhTUlJkNDVMeWdOSVFrK1NBTHFRRFZo?=
 =?utf-8?B?KzF6T2JsNWkrekZTdE4xNFlUS2tXbzdGZ25pYSsvTDJ4NlVmQzY3TkdNSE1r?=
 =?utf-8?B?UnFoUkFvQ0VwclNmSHpKcTRINldCZS9SUDhuNDJzdmNHVTRrUnRQRXVQS2F1?=
 =?utf-8?B?SXladXdmcVp0SlY3MFhDWGtadnNnbm51cUVUK0t2VHVhNGxEZnVMNFg1T2tY?=
 =?utf-8?B?Nkw4OWdXWGwxZk5qRzNNbXVpREdqZ3RSTldyQ2NGdzNzeU9vcDNER0F2R1Z3?=
 =?utf-8?B?NDRwdmJuZWdNNEVXdDA3a3pLekZCVGUva1c4aUVUMS9JdC9WeWxEUzRSbitC?=
 =?utf-8?B?aTBHQXRHOHVhVEtNc0w0TkpBS2JkVkhHdUtnUDZpWS9EMUlFKzU0VFdSWlUx?=
 =?utf-8?B?S2REODBmWVZlcFYxczlQZ3hhUjhFdmZ0VEZ3R3Z0OTkwQ0UvS1d3RGMydzJs?=
 =?utf-8?B?eExDUDNXMm5icFRMdEZMNFgra0FJVW56NFFUNGtUejBXcnJTNTJFQzdDVUJt?=
 =?utf-8?B?NTh6dUgzYzhIYXVKbHlDazd3OGNSUXA0THU2bjc5QlZsWTN0MXhSZllBMGpQ?=
 =?utf-8?B?bkkrQjRUSXovd0ozTHNMMWZGQkZCT1FxRURueFl2UllkR2dDT0k1eEYxVVp2?=
 =?utf-8?B?Qjk3R0xGbWlscHJZdCtIU3FjM0RMMXZzaHdVNGtHc3hOdHVuWmo3MlFMYXhD?=
 =?utf-8?B?M3pZYVdPVG9DYTExK1JzS05hQUhzOVBNQml1dUJGWGIzeWRMdnBpZFkxNk53?=
 =?utf-8?B?MVV1MXFSZkJpa21oYlUxQ3Z3RDUzZy9uZEtBM1k2YXpTMG5sb1UyQUxVbU5T?=
 =?utf-8?Q?j86o=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2025 12:15:25.8925 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fe11a1c-1085-4cfe-06e3-08de33f7f8ec
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA4D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8516
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

amdgpu_virt_ras_get_cper_records() was using a large stack array
of ras_log_info pointers. This contributed to the frame size
warning on this function.

Replace the fixed-size stack array:

    struct ras_log_info *trace[MAX_RECORD_PER_BATCH];

with a heap-allocated array using kcalloc().

We free the trace buffer together with out_buf on all exit paths.
If allocation of trace or out_buf fails, we return a generic RAS
error code.

This reduces stack usage and keeps the runtime behaviour
unchanged.

Fixes:
stack frame size: 1112 bytes (limit: 1024)

Cc: Tao Zhou <tao.zhou1@amd.com>
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 .../drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c   | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c
index 5e90a187155b..a75479593864 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c
@@ -183,7 +183,7 @@ static int amdgpu_virt_ras_get_cper_records(struct ras_core_context *ras_core,
 		(struct ras_cmd_cper_record_rsp *)cmd->output_buff_raw;
 	struct ras_log_batch_overview *overview = &virt_ras->batch_mgr.batch_overview;
 	struct ras_cmd_batch_trace_record_rsp *rsp_cache = &virt_ras->batch_mgr.batch_trace;
-	struct ras_log_info *trace[MAX_RECORD_PER_BATCH] = {0};
+	struct ras_log_info **trace;
 	uint32_t offset = 0, real_data_len = 0;
 	uint64_t batch_id;
 	uint8_t *out_buf;
@@ -195,9 +195,15 @@ static int amdgpu_virt_ras_get_cper_records(struct ras_core_context *ras_core,
 	if (!req->buf_size || !req->buf_ptr || !req->cper_num)
 		return RAS_CMD__ERROR_INVALID_INPUT_DATA;
 
+	trace = kcalloc(MAX_RECORD_PER_BATCH, sizeof(*trace), GFP_KERNEL);
+	if (!trace)
+		return RAS_CMD__ERROR_GENERIC;
+
 	out_buf = kzalloc(req->buf_size, GFP_KERNEL);
-	if (!out_buf)
+	if (!out_buf) {
+		kfree(trace);
 		return RAS_CMD__ERROR_GENERIC;
+	}
 
 	memset(out_buf, 0, req->buf_size);
 
@@ -205,8 +211,9 @@ static int amdgpu_virt_ras_get_cper_records(struct ras_core_context *ras_core,
 		batch_id = req->cper_start_id + i;
 		if (batch_id >= overview->last_batch_id)
 			break;
-		count = amdgpu_virt_ras_get_batch_records(ras_core, batch_id, trace,
-					ARRAY_SIZE(trace), rsp_cache);
+		count = amdgpu_virt_ras_get_batch_records(ras_core, batch_id,
+							  trace, MAX_RECORD_PER_BATCH,
+							  rsp_cache);
 		if (count > 0) {
 			ret = ras_cper_generate_cper(ras_core, trace, count,
 					&out_buf[offset], req->buf_size - offset, &real_data_len);
@@ -220,6 +227,7 @@ static int amdgpu_virt_ras_get_cper_records(struct ras_core_context *ras_core,
 	if ((ret && (ret != -ENOMEM)) ||
 	    copy_to_user(u64_to_user_ptr(req->buf_ptr), out_buf, offset)) {
 		kfree(out_buf);
+		kfree(trace);
 		return RAS_CMD__ERROR_GENERIC;
 	}
 
@@ -231,6 +239,7 @@ static int amdgpu_virt_ras_get_cper_records(struct ras_core_context *ras_core,
 	cmd->output_size = sizeof(struct ras_cmd_cper_record_rsp);
 
 	kfree(out_buf);
+	kfree(trace);
 
 	return RAS_CMD__SUCCESS;
 }
-- 
2.34.1

