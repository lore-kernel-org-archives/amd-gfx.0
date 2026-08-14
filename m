Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17D4AC5CFCF
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Aug 2026 21:04:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9704410F751;
	Fri, 14 Aug 2026 21:04:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="g+TJR+un";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012046.outbound.protection.outlook.com [40.107.209.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A9FC10F735
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Aug 2026 21:04:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eEPNYw1BM+oJ8qgArYTGsdSKdwveu31rrR4a0KFzKwgdaimYko+UAH/3MilKFuryI7WkcCUXbMI4xADQ8UY8syHwQwnAo8EvhI62aK0LT0C1zS7Km+T1Bv9qVuOju/bmFNkL5TfAlRQnMmvL9YUxslVZjBZuvQPEsppbDzItyUrbVNCqu0Fy/PCEX713frFwr6x8KTlCIv+pB6CkSwXlftWadQOcPYvptkZrPyxnZlY5eQjSyncxZw18indIsFOEvaTXsstzgGyfescZVYEa3irVHpc0+xYUQ/h6llO9GaQRUP/YcGpXUR1nU1Ry1CSVTLUscLZEw/02vCWNnit5+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kkuwropJ0I5oALiUxVA5ZmFDa5rGAvxkrAU7ZLVLqHk=;
 b=B9YzTNtEnc7wuzOWLpWrAToSv/cqDSrJEUTrrorVFF7Rkk3i4BhTYLAUlmYqvjZsVQGZyt9rZdx747sfO7WrLKXOi8dRHGKsQZI2lLN9jn3Gct6DnrFXLggXEeOCNzx5UrkQnhkDaKdPA8E2t3EnwPSd25jK5pzay8HxFXf0LYHrzWofDXE9dDzI6i3ktc/LqtS9DSlMt2Luc8BiumGcGSCBf+JGmzv8KNL9mCG9+VjC+HThZD0Df1Cyu0/h0QLK92d3g8sPT9P4J7io5wcr5UCEZYT2aEx0CQzaKeHPQISHhWciruBHzL6OIuaJsSPF3311udgxgiSCcIjJR2yR9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kkuwropJ0I5oALiUxVA5ZmFDa5rGAvxkrAU7ZLVLqHk=;
 b=g+TJR+unpRlS/HvL7c0PlNuv9PoRiZ8bVliWQSz9WF1xjALEN139wLW+UMXkCNWzgvAsIccnUzfHPtfggTTwh+NOR3fDrCPdLAGgjQebI78o3M0ZIfuv8ggwOE06WZoFf9rLbfydSfmSnglKEZHn73LzGqDpVRpTG6fEtGVz8QI=
Received: from CH2PR04CA0020.namprd04.prod.outlook.com (2603:10b6:610:52::30)
 by MN2PR12MB4376.namprd12.prod.outlook.com (2603:10b6:208:26c::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.22; Fri, 14 Aug
 2026 21:04:07 +0000
Received: from CH3PEPF00000014.namprd21.prod.outlook.com
 (2603:10b6:610:52:cafe::71) by CH2PR04CA0020.outlook.office365.com
 (2603:10b6:610:52::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.16 via Frontend Transport; Fri,
 14 Aug 2026 21:04:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF00000014.mail.protection.outlook.com (10.167.244.119) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.0 via Frontend Transport; Fri, 14 Aug 2026 21:04:05 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 14 Aug
 2026 16:04:00 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 14 Aug
 2026 16:03:59 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 14 Aug 2026 16:03:59 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Xiang Liu <xiang.liu@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 105/109] drm/amd/ras: generate Platform Memory CPER records
Date: Fri, 14 Aug 2026 17:02:42 -0400
Message-ID: <20260814210246.3067612-106-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260814210246.3067612-1-alexander.deucher@amd.com>
References: <20260814210246.3067612-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000014:EE_|MN2PR12MB4376:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f3730a1-bdfa-4072-4052-08defa479363
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|82310400026|376014|36860700016|10067099003|22082099003|18002099003|56012099006|6133799003|11063799006;
X-Microsoft-Antispam-Message-Info: 7nUhHXmx7TdtQwHH+mPyLWB75krZ6lk5Qj+PKj9kDifUzVTC46w9gwr13FDivnHoE/jQ00yIOZLJvyHGi0QbUnTI+9x3uCOanf21D0id5Q9RcdFzl9S9BwCFfydFDs84IJdCspLWBcTWi1WUj+awN18Sqsyq6Nk10PUR5RPhzoH9NLMv5q87DLlwfONQ5GvANFI6wMwCPjuzIDmd2TWCG42Y5qGHi8dzBIPfLvhdWk3FKHNskzeuXVLRaJ1q2XE0IY+t1sDjT+LnUZEbKIMMXfwC7tJ6H1gK4ClyBM6HQYLYkW3BFsvmpcUQTM0w47Eaz13KmhwmjowOToDLcS7diJ6mJLQCy5CQzaDZeAICbvOEdRL6O8nAtX3FYPTC1SavJjxyBCuaqdMoUg6lmJ+G1dT8uVP9XoOPQotmrracg7hT5yDIJD6cNfVPnITzjqS8hXdDUIMOQR2QA/TntOo9/8Qrz3irNy1xfqaE7V/Dq4vcvOqim9EUI0gi+NeZKJ94fVqq30BvtRqtleKC5QLH79bqlxlHpBP568hdE094bvVvfpCJWU4g7UxzUdG4fgsykbhon8KlLmcCfBrQanHCKr6bSbjwuLFwMp1IwryggfY1obGJeLFqGaBrwrblIkJi2V6ZmIs1gQDrATk4NOhyPU14/mQ9Q4T+Df/x1jjGSs8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(82310400026)(376014)(36860700016)(10067099003)(22082099003)(18002099003)(56012099006)(6133799003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ktMuNePB8pt4JJV4g5sfcukrMw95EH2g1Y9xruB/02l0fYR52AVkRwFT4ze3eimFx1LWcGKBPgAxz1c9R+kyeLvE/1i4GQbdjpRcoOATZl/Zk/P6eknH67CFZX5klOZB6xolk1v7p5jhBHDPPAlOx9P5lmrVBQl6fnSJV9ZTWkYJ+JAh0iqq8JZyfGZpjszD/b/tgVBMHfCNZf73KuJ2FqARQgT8IjuWaqhzI262rtzlMhSbMnD2SWuCt52AGnduZziAtBU10jyT5ryFRJmxdfk05o8wAo6dV8nNGHnKlpEaeUBhc+njE4jgzB3q0jl8aJc9AB023XtRukuZKd8wigz7sv1TDWJ9Z3jikLb/0PiZtwXSqoORmhmB21ExvpOsragfH1cSWBQnKwwHkVOhPxQFPzms9l2tnuayU8v+1r/kpK5PLRg8Al7UbjJlZIvP
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 21:04:05.5223 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f3730a1-bdfa-4072-4052-08defa479363
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000014.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4376
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

Preserve standard Platform Memory sections recovered from BERT instead
of wrapping them in the AMD crashdump format.

Validate each boot section, copy its raw payload unchanged, align each
complete record to a 32-bit boundary, and report the exact serialized
size.

Route Platform Memory records through a dedicated generator,
independently of crashdump and processor records.

Signed-off-by: Xiang Liu <xiang.liu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/ras/core/ras_cper.c | 69 +++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/drivers/gpu/drm/amd/ras/core/ras_cper.c b/drivers/gpu/drm/amd/ras/core/ras_cper.c
index 1bbc2c3247c25..c8506f695d607 100644
--- a/drivers/gpu/drm/amd/ras/core/ras_cper.c
+++ b/drivers/gpu/drm/amd/ras/core/ras_cper.c
@@ -29,6 +29,8 @@
 
 static const struct ras_cper_guid processor_section_type =
 	PROC_ERR__SECTION_TYPE;
+static const struct ras_cper_guid platform_memory_section_type =
+	PLATFORM_MEM__SECTION_TYPE;
 
 static int ras_cper_get_profile(struct ras_core_context *ras_core,
 		enum ras_log_event event, struct ras_cper_profile **profile);
@@ -502,6 +504,70 @@ static int cper_generate_processor_records(struct ras_core_context *ras_core,
 	return 0;
 }
 
+static bool cper_is_platform_memory_record(struct ras_log_info *log)
+{
+	return log->event == RAS_LOG_EVENT_BOOT &&
+		!memcmp(log->body.boot_err_ctx.section_type,
+			platform_memory_section_type.b, CPER_UUID_MAX_SIZE);
+}
+
+static int cper_generate_platform_memory_records(struct ras_core_context *ras_core,
+		struct ras_log_info *batch_logs, u32 nr_batch_logs,
+		u8 *buffer, u32 buf_len, u32 *real_data_len)
+{
+	u32 record_size = 0;
+	u32 offset = 0;
+	u32 i;
+
+	for (i = 0; i < nr_batch_logs; i++) {
+		const struct ras_boot_err_ctx *ctx = &batch_logs[i].body.boot_err_ctx;
+		u32 size;
+
+		if (!cper_is_platform_memory_record(&batch_logs[i]) ||
+		    !ctx->raw_data_size ||
+		    ctx->raw_data_size > sizeof(ctx->raw_data))
+			return -EINVAL;
+
+		size = ALIGN(RAS_HDR_LEN + RAS_SEC_DESC_LEN +
+			     ctx->raw_data_size, sizeof(u32));
+		if (record_size > U32_MAX - size)
+			return -EOVERFLOW;
+		record_size += size;
+	}
+	if (record_size > buf_len)
+		return -ENOMEM;
+
+	for (i = 0; i < nr_batch_logs; i++) {
+		const struct ras_boot_err_ctx *ctx = &batch_logs[i].body.boot_err_ctx;
+		struct cper_section_desc *descriptor;
+		struct cper_section_hdr *hdr;
+		u32 size = ALIGN(RAS_HDR_LEN + RAS_SEC_DESC_LEN +
+				 ctx->raw_data_size, sizeof(u32));
+
+		hdr = (struct cper_section_hdr *)(buffer + offset);
+		descriptor = (struct cper_section_desc *)(buffer + offset +
+						  RAS_HDR_LEN);
+		fill_section_hdr(ras_core, hdr, BOOT__TYPE,
+				 ctx->error_severity, &batch_logs[i]);
+		hdr->record_length = size;
+		hdr->sec_cnt = 1;
+		fill_section_descriptor(ras_core, descriptor, ctx->error_severity,
+				PLATFORM_MEM__SECTION_TYPE,
+				RAS_HDR_LEN + RAS_SEC_DESC_LEN,
+				ctx->raw_data_size);
+		memcpy(buffer + offset + RAS_HDR_LEN + RAS_SEC_DESC_LEN,
+		       ctx->raw_data, ctx->raw_data_size);
+		memset(buffer + offset + RAS_HDR_LEN + RAS_SEC_DESC_LEN +
+		       ctx->raw_data_size, 0,
+		       size - RAS_HDR_LEN - RAS_SEC_DESC_LEN -
+		       ctx->raw_data_size);
+		offset += size;
+	}
+
+	*real_data_len = offset;
+	return 0;
+}
+
 static enum ras_log_event cper_mce_parse_err_type(struct ras_core_context *ras_core,
 						  struct aca_bank_reg *bank)
 {
@@ -539,6 +605,9 @@ int ras_cper_generate_batch_cper(struct ras_core_context *ras_core,
 	if (cper_is_processor_record(&batch_logs[0]))
 		return cper_generate_processor_records(ras_core, batch_logs,
 			nr_batch_logs, buf, buf_len, real_data_len);
+	if (cper_is_platform_memory_record(&batch_logs[0]))
+		return cper_generate_platform_memory_records(ras_core, batch_logs,
+			nr_batch_logs, buf, buf_len, real_data_len);
 
 	event = batch_logs[0].event;
 	if (event == RAS_LOG_EVENT_MCE) {
-- 
2.55.0

