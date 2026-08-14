Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E8A4C5DF77
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Aug 2026 21:04:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC14110F756;
	Fri, 14 Aug 2026 21:04:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pWb89izV";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011058.outbound.protection.outlook.com [52.101.62.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CBA4A10F736
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Aug 2026 21:04:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wsqhclBV9EdPI3Dfvb0TBAs0NpU4mtI2C2rTn5s3WxqnZsZ3sy4d8b/+tLkpmvZa3hCDH3ekfB94gr1SZkKIDFcS2zySulkzTen36w63RgaZyghHmg8PZyj238Zqp8D5ZWw7N/sT02DaGXn/BKgS7AnRhE9tC/kJ6YxZI+x+4x1ODgFH3z8AoghIkIndOdAvMJ+N7xGnpq+m0OD4dXLdABoIW0d7ae+z+MPyXFJotUe493tLt82495ClwNzBcfoEVJ0TnxdhOiy/TRlqsk4C4pCY8nVkcYCEotPcRYBdypB8HVHe+ZzPvHCRSN83dVXgblndwdr2vQgEhxf5DZtz9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b6Zl15l3UShwXUCOlvfyIU0f7WyrDdq2694WpY7Qar8=;
 b=K3eI6fGqkXKkgJ3v/gPV154IOiGqpbQg6sjhd5CszAPelvklZGCfH6Ien5iiS68SSDtm4ZmpMl0Hnb9UnnaujHx42CJVeFBo7ugI72jGzDCq6Qwd73kE4P0XBD3rg/yY/DRIfRogwRUGnF/hCH2sTEJnw8zvTVnAy9EAbrIEBfzYWWiySXaXRQJoGetDuRcBLoUkxDDABjYN+PFlS0QBVrLEZ8jPXmBhbf+77mFj8Jp6PFxe5PnOe1mckA+NdK/AZdhScJwf9fYcmwCV9mR6xFVqaWELnBZWHVKnlm1mdfnGEZqmz6F6B8Rdrc8VRMCCx1aYwFuDAtpVTWrBuTa5Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b6Zl15l3UShwXUCOlvfyIU0f7WyrDdq2694WpY7Qar8=;
 b=pWb89izVy082E0tKFiP7I9Vwhutv3VQVr86gKQklk1/YorQFxfGb/heTc9KvnTMTYDl2cDdBcCIZBWvbPA8uXXnED74HyeIb+mRDDRsPH5LoCs2LCmt7PTbQ8YfrC1t/2q4zR0iRJNgJnOokBHg52KkcU2p+MRfXPpkXD4sdzcE=
Received: from CH2PR04CA0028.namprd04.prod.outlook.com (2603:10b6:610:52::38)
 by IA1PR12MB6554.namprd12.prod.outlook.com (2603:10b6:208:3a2::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.15; Fri, 14 Aug
 2026 21:04:04 +0000
Received: from CH3PEPF00000014.namprd21.prod.outlook.com
 (2603:10b6:610:52:cafe::8f) by CH2PR04CA0028.outlook.office365.com
 (2603:10b6:610:52::38) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.16 via Frontend Transport; Fri,
 14 Aug 2026 21:04:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF00000014.mail.protection.outlook.com (10.167.244.119) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.0 via Frontend Transport; Fri, 14 Aug 2026 21:04:04 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 14 Aug
 2026 16:03:59 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 14 Aug 2026 16:03:59 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Xiang Liu <xiang.liu@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 104/109] drm/amd/ras: generate processor CPER records
Date: Fri, 14 Aug 2026 17:02:41 -0400
Message-ID: <20260814210246.3067612-105-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260814210246.3067612-1-alexander.deucher@amd.com>
References: <20260814210246.3067612-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000014:EE_|IA1PR12MB6554:EE_
X-MS-Office365-Filtering-Correlation-Id: 871ea89d-ad67-4763-2982-08defa4792f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|23010399003|376014|22082099003|18002099003|56012099006|6133799003|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info: pTQ4aMZI484Zy3MxA1XkupoXhrqTWLN7wmNnQc6SMKoKVUqf7zc4coOWA2UwwKumhOTQBKKAfl/J5il7xHJc1jyfDSza0nanklhlrH14zF8giBzo+rxG+NWxtAxwFHkkol+zFQRRmY/QFS/fV8h+um1f40C9UzD6/7NBTURuJzfj3Ax1WB99n9xKUE1iG5Uzp4YoBp3XKJLqtSEdmM44KD+j6dmgBSDYoGuye4tmTs0uGlmIYK9+TF9+YmfzJ8bZ9y+iK3PVUi2/78L+54N31lus7YMUPMDyPXdSj6Z5v6FOaou9Vd/EXKmG1YCIxEGeAYUvsJ+z1k6WtJExdHYtFVfN7DRESRqfynUe3JId/8nyVgZqjw1GYHZIZ3yzk5RG45OsI+hSx+Ca3OMoCTbXbzBZRzmgeqLlM5U1TmypFJnZQszLsganKq7Fi5rXF8eYuv0WDC1BUZnVRrnlC/BGz99hb6uB0lDVK45F9dl5ZnG80stxbbpN51muI4IiocSgwXAiJuP3sRlrOUqSRwhPZ6wf2fhnZl5ap6tWz9B6K+vhtTYjxqGX9HjCFLXEkEWzA1eghEEwAK8Uf0tH++37PuOKrPg5SoxG5gF8eD89WVyNI7vHhvGELtY2dPOrqRhPE7ofrp8VFZQPzOZa4HSrdDE2v4afAoMYRZ1OwUPIlXU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(23010399003)(376014)(22082099003)(18002099003)(56012099006)(6133799003)(10067099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: wwCWMn6t9MWevsDtvwPPWfE8NuoweiTcaXpoXQCF+jr1LAFG1EpEk3pRCQ33JF/iYrQrsJzkRNWI3O/gKa/fUC18fafPAtVQPpq+yNHTJU6amvDVptaAp+w7Os7dbZUuGJbcXCY5gGqTX5n0H5ezbtEBRM4eda2BuoXvay56lodmCXYKkVQy7WrCgZ8ub0rbqYLVik1LeLfjKQbmBKh4Zk3+DV2dp1bHjOA2lRyyhYWI/43XkRNbfSD6zMD8mhlkAzpENRF/MafomX7tXaeT9+kxldwURiAVWJaKmNC81I+D9fVp32et5Wzac7yqyA2WgHtul3B/+GJfCvLohZHL2nyEgojXm6VuKDBJQ+MnUf5VkZx9DlToaubYp25knaYr0KyN2XNSXRO+P6l4x2Rdp6ooYugzKW1qCbAEOjDn78g2L2m7DegdnPFTB9GAqsxX
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 21:04:04.8179 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 871ea89d-ad67-4763-2982-08defa4792f7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000014.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6554
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

Encode runtime CPU machine checks with the standard IA Processor
section, including APIC ID, machine-check status, bank MSR address, and
SMCA register context.

Also preserve IA Processor sections recovered from BERT as
boot-notified records with their original context metadata and variable
payload size.

Route both forms through a processor-specific generator so they remain
separate from AMD crashdump records.

Signed-off-by: Xiang Liu <xiang.liu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/ras/core/ras_cper.c | 212 ++++++++++++++++++++++++
 1 file changed, 212 insertions(+)

diff --git a/drivers/gpu/drm/amd/ras/core/ras_cper.c b/drivers/gpu/drm/amd/ras/core/ras_cper.c
index eee4e0373c3bd..1bbc2c3247c25 100644
--- a/drivers/gpu/drm/amd/ras/core/ras_cper.c
+++ b/drivers/gpu/drm/amd/ras/core/ras_cper.c
@@ -27,6 +27,9 @@
 #include "ras_cper.h"
 #define ns_to_seconds(ns)   div_u64(ns, NSEC_PER_SEC)
 
+static const struct ras_cper_guid processor_section_type =
+	PROC_ERR__SECTION_TYPE;
+
 static int ras_cper_get_profile(struct ras_core_context *ras_core,
 		enum ras_log_event event, struct ras_cper_profile **profile);
 
@@ -183,6 +186,79 @@ static int fill_section_boot(struct ras_core_context *ras_core, void *section,
 	return 0;
 }
 
+static void fill_processor_error_info(struct cper_processor_error_info *error_info,
+		u64 status)
+{
+	u64 check_info = CPER_MS_CHECK_VALID_ERR_TYPE |
+		CPER_MS_CHECK_ERR_TYPE_INTERNAL;
+
+	error_info->error_type = PROC_ERR__MS_CHECK_TYPE;
+	error_info->valid_bits = CPER_PROC_INFO_VALID_CHECK_INFO;
+
+	if (status & CPER_MCA_STATUS_PCC)
+		check_info |= CPER_MS_CHECK_VALID_PCC | CPER_MS_CHECK_PCC;
+	if (status & CPER_MCA_STATUS_UNCORRECTED)
+		check_info |= CPER_MS_CHECK_VALID_UNCORRECTED |
+			CPER_MS_CHECK_UNCORRECTED;
+	if (status & CPER_MCA_STATUS_OVERFLOW)
+		check_info |= CPER_MS_CHECK_VALID_OVERFLOW |
+			CPER_MS_CHECK_OVERFLOW;
+
+	error_info->check_info = check_info;
+}
+
+static int fill_section_processor(struct cper_section_processor *processor,
+		struct ras_log_info *log)
+{
+	const struct ras_cpu_mce *mce = &log->body.cpu_mce;
+	u64 status = mce->regs[RAS_CPER_ACA_REG_STATUS];
+	u64 *reg_dump = processor->context.reg_dump;
+
+	processor->processor.valid_bits = CPER_PROC_VALID_APIC_ID |
+		CPER_PROC_ERR_INFO_COUNT(1) | CPER_PROC_CONTEXT_COUNT(1);
+	processor->processor.apic_id = mce->apic_id;
+	fill_processor_error_info(&processor->error_info, status);
+	processor->context.reg_ctx_type = CPER_CTX_TYPE__CRASH;
+	processor->context.reg_arr_size = sizeof(processor->context.reg_dump);
+	processor->context.msr_addr = CPER_SMCA_MC0_STATUS_MSR +
+		(mce->bank * CPER_SMCA_BANK_STRIDE);
+	/* The IA processor register array starts at MCA_STATUS. */
+	reg_dump[0] = mce->regs[ACA_REG_IDX__STATUS];
+	reg_dump[1] = mce->regs[ACA_REG_IDX__ADDR];
+	reg_dump[2] = mce->regs[ACA_REG_IDX__MISC0];
+	reg_dump[3] = mce->regs[ACA_REG_IDX__CONFG];
+	reg_dump[4] = mce->regs[ACA_REG_IDX__IPID];
+	reg_dump[5] = mce->regs[ACA_REG_IDX__SYND];
+	reg_dump[7] = mce->regs[ACA_REG_IDX__DESTAT];
+	reg_dump[8] = mce->regs[ACA_REG_IDX__DEADDR];
+	reg_dump[9] = mce->regs[ACA_REG_IDX__CTL_MASK];
+
+	return 0;
+}
+
+static int fill_section_boot_processor(struct cper_section_processor *processor,
+		struct ras_log_info *log)
+{
+	const struct ras_boot_err_ctx *ctx = &log->body.boot_err_ctx;
+	u64 status = ctx->regs[0];
+
+	processor->processor.valid_bits = CPER_PROC_ERR_INFO_COUNT(1) |
+		CPER_PROC_CONTEXT_COUNT(1);
+	if (ctx->flags & RAS_BOOT_CTX_VALID_APIC_ID)
+		processor->processor.valid_bits |= CPER_PROC_VALID_APIC_ID;
+	processor->processor.apic_id = ctx->apic_id;
+	fill_processor_error_info(&processor->error_info, status);
+	processor->context.reg_ctx_type = ctx->reg_ctx_type;
+	processor->context.reg_arr_size = ctx->reg_arr_size;
+	processor->context.msr_addr = ctx->msr_addr;
+	processor->context.mm_reg_addr = ctx->mm_reg_addr;
+	memcpy(processor->context.reg_dump, ctx->regs,
+		min_t(size_t, ctx->reg_arr_size,
+		      sizeof(processor->context.reg_dump)));
+
+	return 0;
+}
+
 static int cper_boot_get_severity(struct ras_log_info *log,
 			enum ras_cper_severity *sev)
 {
@@ -293,6 +369,139 @@ static int cper_build_multiple_records(struct ras_core_context *ras_core,
 	return 0;
 }
 
+static int cper_generate_boot_processor_records(struct ras_core_context *ras_core,
+		u8 *buffer, struct ras_log_info *batch_logs, u32 nr_batch_logs)
+{
+	u32 offset = 0;
+	u32 i;
+
+	for (i = 0; i < nr_batch_logs; i++) {
+		const struct ras_boot_err_ctx *ctx = &batch_logs[i].body.boot_err_ctx;
+		struct ras_cper_processor_record record = { 0 };
+		u16 data_size = min_t(u16, ctx->reg_arr_size,
+					 sizeof(record.processor.context.reg_dump));
+		u32 section_size = offsetof(struct cper_section_processor,
+					    context.reg_dump) + data_size;
+		u32 record_size = RAS_HDR_LEN + RAS_SEC_DESC_LEN + section_size;
+		enum ras_cper_severity sev = ctx->error_severity;
+
+		fill_section_hdr(ras_core, &record.hdr, BOOT__TYPE, sev,
+				 &batch_logs[i]);
+		record.hdr.record_length = record_size;
+		record.hdr.sec_cnt = 1;
+		fill_section_descriptor(ras_core, &record.descriptor, sev,
+				PROC_ERR__SECTION_TYPE,
+				offsetof(struct ras_cper_processor_record, processor),
+				section_size);
+		fill_section_boot_processor(&record.processor, &batch_logs[i]);
+		memcpy(buffer + offset, &record, record_size);
+		offset += record_size;
+	}
+
+	return offset;
+}
+
+static int cper_generate_runtime_processor_records(struct ras_core_context *ras_core,
+		u8 *buffer, struct ras_log_info *batch_logs, u32 nr_batch_logs)
+{
+	u32 i;
+
+	for (i = 0; i < nr_batch_logs; i++) {
+		struct ras_cper_processor_record record = { 0 };
+		u64 status = batch_logs[i].body.cpu_mce.regs[ACA_REG_IDX__STATUS];
+		enum ras_cper_severity sev;
+
+		if (!(status & CPER_MCA_STATUS_UNCORRECTED) &&
+		    !(status & CPER_MCA_STATUS_DEFERRED))
+			sev = RAS_CPER_SEV_NON_FATAL_CE;
+		else if ((status & CPER_MCA_STATUS_UNCORRECTED) &&
+			 (status & CPER_MCA_STATUS_PCC))
+			sev = RAS_CPER_SEV_FATAL_UE;
+		else
+			sev = RAS_CPER_SEV_NON_FATAL_UE;
+
+		fill_section_hdr(ras_core, &record.hdr, CPER_NOTIFY__MCE, sev,
+				 &batch_logs[i]);
+		record.hdr.revision = CPER_HDR__REV_AMD_CPU;
+		record.hdr.record_length = sizeof(record);
+		record.hdr.sec_cnt = 1;
+		fill_section_descriptor(ras_core, &record.descriptor, sev,
+				PROC_ERR__SECTION_TYPE,
+				offsetof(struct ras_cper_processor_record, processor),
+				RAS_PROC_SEC_LEN);
+		record.descriptor.flag_bits.latent_err =
+			!!(status & CPER_MCA_STATUS_DEFERRED);
+		record.descriptor.revision_minor = CPER_SEC__REV_AMD_CPU & 0xff;
+		record.descriptor.revision_major = CPER_SEC__REV_AMD_CPU >> 8;
+		fill_section_processor(&record.processor, &batch_logs[i]);
+		memcpy(buffer + (i * sizeof(record)), &record, sizeof(record));
+	}
+
+	return 0;
+}
+
+static bool cper_is_processor_record(struct ras_log_info *log)
+{
+	return log->event == RAS_LOG_EVENT_CPU_RAS ||
+		(log->event == RAS_LOG_EVENT_BOOT &&
+		 !memcmp(log->body.boot_err_ctx.section_type,
+			 processor_section_type.b, CPER_UUID_MAX_SIZE));
+}
+
+static int cper_generate_processor_records(struct ras_core_context *ras_core,
+		struct ras_log_info *batch_logs, u32 nr_batch_logs,
+		u8 *buffer, u32 buf_len, u32 *real_data_len)
+{
+	u32 record_size = 0;
+	u32 i;
+	int ret;
+
+	if (batch_logs[0].event == RAS_LOG_EVENT_CPU_RAS) {
+		if (nr_batch_logs > U32_MAX / sizeof(struct ras_cper_processor_record))
+			return -EOVERFLOW;
+		record_size = sizeof(struct ras_cper_processor_record) * nr_batch_logs;
+		if (record_size > buf_len)
+			return -ENOMEM;
+
+		ret = cper_generate_runtime_processor_records(ras_core, buffer,
+				batch_logs, nr_batch_logs);
+		if (ret)
+			return ret;
+		*real_data_len = record_size;
+		return 0;
+	}
+
+	for (i = 0; i < nr_batch_logs; i++) {
+		const struct ras_boot_err_ctx *ctx = &batch_logs[i].body.boot_err_ctx;
+		u16 data_size;
+		u32 size;
+
+		if (batch_logs[i].event != RAS_LOG_EVENT_BOOT ||
+		    !cper_is_processor_record(&batch_logs[i]))
+			return -EINVAL;
+
+		data_size = min_t(u16, ctx->reg_arr_size,
+				  sizeof(struct cper_processor_context) -
+				  offsetof(struct cper_processor_context, reg_dump));
+		size = RAS_HDR_LEN + RAS_SEC_DESC_LEN +
+			offsetof(struct cper_section_processor, context.reg_dump) +
+			data_size;
+		if (record_size > U32_MAX - size)
+			return -EOVERFLOW;
+		record_size += size;
+	}
+	if (record_size > buf_len)
+		return -ENOMEM;
+
+	ret = cper_generate_boot_processor_records(ras_core, buffer,
+			batch_logs, nr_batch_logs);
+	if (ret < 0)
+		return ret;
+	*real_data_len = ret;
+
+	return 0;
+}
+
 static enum ras_log_event cper_mce_parse_err_type(struct ras_core_context *ras_core,
 						  struct aca_bank_reg *bank)
 {
@@ -327,6 +536,9 @@ int ras_cper_generate_batch_cper(struct ras_core_context *ras_core,
 		return -EINVAL;
 
 	*real_data_len = 0;
+	if (cper_is_processor_record(&batch_logs[0]))
+		return cper_generate_processor_records(ras_core, batch_logs,
+			nr_batch_logs, buf, buf_len, real_data_len);
 
 	event = batch_logs[0].event;
 	if (event == RAS_LOG_EVENT_MCE) {
-- 
2.55.0

