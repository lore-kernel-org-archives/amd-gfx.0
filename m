Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80DF2C5B572
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Aug 2026 21:04:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1AE1E10F73A;
	Fri, 14 Aug 2026 21:04:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vd14N5Wg";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013006.outbound.protection.outlook.com
 [40.93.201.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B572410F735
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Aug 2026 21:04:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IrFjegootoKVLrAmbT8Fa1x+cnVOop5r5JGgvusL99QFkBMsbfiUXvR+PXMiwyWL9zpO1dDHbM7/GxieEMHQV+6xPrmrgl0cn4FFQB++hdaqg9u/sNHVFRlCUitBoFrkm8+ly2/KDPrJHyQSpkWC/hQ6snBRz8uGl+5UT1rfn8y9rLdok+saqo8Y9z3xUXvIBiS0OWuCEShd3PrPBuT2w/kZ4e7BJecqvBoaFJfGmBGfg8+DBcPrrgzH+JQtm7xJTw5BRquKOAFioA5pqjepwOlmO2aGrsOLHNGcxBZI3k9P8j3sd78msrZLvG2f64w18MLnvp/6ApQSOL4BWbrAxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=irb3q9WETAODzIe4/UxzF+F5T91VqkH2HLD4/r/A1E0=;
 b=dp7cjxIP7/ct/NRuhKE/pQni8yMXSWWaYHFRpEtmds+Q6Twarihe94oh/UEWlUSQ5Ovpc+mvyK7Ky0zajF9d3WjxynbpZO37kL9+n3eSh13OOGE8oGz5Un3L4ayIjP8a+IW2S38cZU4KwzYi3/0UV6KowxTRnWabFy+p/mi6HfM+PwOh30ZyoYYLfUwGXhK+dL9YJ4krylTYijoU7kH82nbmBc7dYR/Eh2dwq3mm+w8MBnH8aS+bM1LztSpTXWItg/i4pV6A3uCsvy9p2CdLReCt3fS4L18el5u0VI8vStakqoEZz8YHKNJ1VTIgxBhl/YSB7Vm8ebXKgicoTb559g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=irb3q9WETAODzIe4/UxzF+F5T91VqkH2HLD4/r/A1E0=;
 b=vd14N5WgnBcfEjBMqTshtNe1GsuOYYev+noRw9siwAsHNIcbA2TCQ4aSRIcsZ/jxCbNjQMXwyHoJ/CdbFWGMWwdqfEKDBlpc/kR2AvssZcpzWxpZBhk5EyvTYIt2X0nV9JG1e+cQrYHtKZUYPPAU+vncluGM2BnZnTPNH7mc0tA=
Received: from DSZP220CA0008.NAMP220.PROD.OUTLOOK.COM (2603:10b6:5:280::9) by
 DS0PR12MB6462.namprd12.prod.outlook.com (2603:10b6:8:c6::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.15; Fri, 14 Aug 2026 21:04:05 +0000
Received: from CH3PEPF00000015.namprd21.prod.outlook.com
 (2603:10b6:5:280:cafe::ab) by DSZP220CA0008.outlook.office365.com
 (2603:10b6:5:280::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.16 via Frontend Transport; Fri,
 14 Aug 2026 21:04:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF00000015.mail.protection.outlook.com (10.167.244.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.0 via Frontend Transport; Fri, 14 Aug 2026 21:04:05 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 14 Aug
 2026 16:04:00 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 14 Aug 2026 16:04:00 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Xiang Liu <xiang.liu@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 107/109] drm/amd/ras: parse and route BERT sections
Date: Fri, 14 Aug 2026 17:02:44 -0400
Message-ID: <20260814210246.3067612-108-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260814210246.3067612-1-alexander.deucher@amd.com>
References: <20260814210246.3067612-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000015:EE_|DS0PR12MB6462:EE_
X-MS-Office365-Filtering-Correlation-Id: bba6a633-60b8-4e2e-2e72-08defa479380
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|23010399003|376014|82310400026|18002099003|22082099003|10067099003|11063799006|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info: kv+xxw+BowwcYonKE9jIv9/viz29AGwbKMUEgBKLvv4QYCHEQGztPOrCSzD1oHjGG0OA4CTDeMdfVecvAzNx98fvKbTXJaLDL+XsyMMHgtTwHFuEs8H8eZPgSqY7dtY8ME7hrS5v6Xz+v4BrwbUdfy+w1X0xU3Ie+Zs9VZEko+nq+7lVDbAiB7tHTxe7/GywDflOiAOjq5mpa10pMBb3s400KYzotM1f3DC4mfvSFCtPYqq3SuOKdwEGnccX8FP/3BX8vGTL1w5OEf1PhyvS+hnWKzQ1rJsZ+vv3aLF9DFD3GOegD0krdqtTRefsYh8aC+YrsnfB8wQsIkZYFY5sRYcUOaxtUxU04SfwpD88c5Hj/aqKVzRIhUqd7Mp7n8NxoQo6MbuxlZR1FFETmSYJFYkc/14MzshQ/sLtVMV3aEf/rUhxRpCWQhctIn7HhsDDPkDDXcSwGML+bv8QkIuX891W9l5BxV080ffdlSE4jSkaiVxCDAP6psmbc94BGv0Wqdwe44HIkysHHzYnbioFGtfJH6Cgv0TQY0UOMrMizfDBzEQsGDxWJfNDmmRcuM+lnt7QVoTz1iTjgVizVAw2Hlgb0wpN/gY1qejOPhep9RTqKsCujFIDFvwf1E5LP/FK1wEecpnyKHdWbpbZpA/nLiFJ6c1IemOdh/E17zOyPiw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(23010399003)(376014)(82310400026)(18002099003)(22082099003)(10067099003)(11063799006)(56012099006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ZO0nf7+DpbNoGPbrNmCG5sr61c1hpWB7i4HlsfylMpXF5dv8RO2Ohqga80lWkqqZxuobSR9OKjCPJufvhNtI9o4u8KLJLGHvbZXZpEQ578XiXYX1a48TZmHDgTorGUQV6BAKoQMUMHc5HEncBmRNI8ypS0W927T2FIFWpGHgZlZZ0luK3aCERrN2R+SgckpiP3WZlSCppYvWBnw6/Os8NOmpxbFIXoqTvT7dVK/0hclidWzauntYobFleZujLD0K3SJM5p+AUeikbXM3R3vPdEoBUTV5xKet5bD/TqqMNUCm8kmv0woua55Gyj8NqgCCKbOQq16gqje7GWfM4Qj1fZmLkgXPE0Mr48bKQtBuQgwn0dLSBiHq+ARy3fSNfmIH9mOPGLBsNnQ420TSUdXiI8L9heH28o6QnD+nux4wDEzt04Kqei1rOzn0Gt/LN/Fq
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 21:04:05.7192 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bba6a633-60b8-4e2e-2e72-08defa479380
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000015.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6462
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

BERT may contain structured AMD crashdump, IA processor, Platform
Memory, PCIe, and SMN sections. Replaying all sections for every GPU
either duplicates GPU records or drops CPU and platform records when
their topology IDs are compared with GPU OAM IDs.

Parse the supported section formats in rascore. Route GPU records using
the OAM identity and gate CPU and platform sections through an explicit
owner selected by the operating-system integration layer.

Signed-off-by: Xiang Liu <xiang.liu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/ras/core/ras.h      |   1 +
 drivers/gpu/drm/amd/ras/core/ras_bert.c | 337 +++++++++++++++++++++++-
 2 files changed, 331 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/ras/core/ras.h b/drivers/gpu/drm/amd/ras/core/ras.h
index 6509bd798e48e..49f9dd1b212d3 100644
--- a/drivers/gpu/drm/amd/ras/core/ras.h
+++ b/drivers/gpu/drm/amd/ras/core/ras.h
@@ -384,6 +384,7 @@ struct ras_core_config {
 struct ras_core_context {
 	void *dev;
 	struct ras_core_config *config;
+	bool bert_platform_owner;
 	u32 socket_num_per_node;
 	u32 aid_num_per_socket;
 	u32 xcd_num_per_aid;
diff --git a/drivers/gpu/drm/amd/ras/core/ras_bert.c b/drivers/gpu/drm/amd/ras/core/ras_bert.c
index 474b2836dee77..cc4140bb97612 100644
--- a/drivers/gpu/drm/amd/ras/core/ras_bert.c
+++ b/drivers/gpu/drm/amd/ras/core/ras_bert.c
@@ -25,6 +25,20 @@
 #include "ras.h"
 
 #if defined(CONFIG_X86_MCE_AMD) && defined(CONFIG_ACPI_APEI)
+#define RAS_BERT_ERR_INFO_COUNT(bits)  (((bits) & GENMASK_ULL(7, 2)) >> 2)
+#define RAS_BERT_CONTEXT_COUNT(bits)   (((bits) & GENMASK_ULL(13, 8)) >> 8)
+#define CPER_MEM_VALID_NODE            0x0008
+#define CPER_MEM_VALID_ERROR_STATUS    0x0001
+#define CPER_MEM_VALID_PA              0x0002
+#define CPER_MEM_VALID_PA_MASK         0x0004
+#define CPER_MEM_VALID_REQUESTOR_ID    0x0800
+#define CPER_MEM_VALID_RESPONDER_ID    0x1000
+#define CPER_MEM_VALID_TARGET_ID       0x2000
+#define CPER_MEM_VALID_ERROR_TYPE      0x4000
+#define AMD_CPER_BODY_VALID_MASK       GENMASK_ULL(15, 1)
+#define RAS_BERT_VALID_FRU_STRING       BIT(1)
+#define RAS_BERT_PROC_CTX_TYPE_MSR      1
+
 struct ras_bert_hest_generic_status {
 	u32 block_status;
 	u32 raw_data_offset;
@@ -56,6 +70,71 @@ struct ras_bert_hest_generic_data_v300 {
 	u64 time_stamp;
 };
 
+struct ras_bert_sec_proc_ia {
+	u64 validation_bits;
+	u64 lapic_id;
+	u8 cpuid[48];
+};
+
+struct ras_bert_ia_err_info {
+	u8 err_type[16];
+	u64 validation_bits;
+	u64 check_info;
+	u64 target_id;
+	u64 requestor_id;
+	u64 responder_id;
+	u64 ip;
+};
+
+struct ras_bert_ia_proc_ctx {
+	u16 reg_ctx_type;
+	u16 reg_arr_size;
+	u32 msr_addr;
+	u64 mm_reg_addr;
+};
+
+struct ras_bert_sec_mem_err_old {
+	u64 validation_bits;
+	u64 error_status;
+	u64 physical_addr;
+	u64 physical_addr_mask;
+	u16 node;
+	u16 card;
+	u16 module;
+	u16 bank;
+	u16 device;
+	u16 row;
+	u16 column;
+	u16 bit_pos;
+	u64 requestor_id;
+	u64 responder_id;
+	u64 target_id;
+	u8 error_type;
+} __packed;
+
+struct ras_bert_sec_mem_err {
+	u64 validation_bits;
+	u64 error_status;
+	u64 physical_addr;
+	u64 physical_addr_mask;
+	u16 node;
+	u16 card;
+	u16 module;
+	u16 bank;
+	u16 device;
+	u16 row;
+	u16 column;
+	u16 bit_pos;
+	u64 requestor_id;
+	u64 responder_id;
+	u64 target_id;
+	u8 error_type;
+	u8 extended;
+	u16 rank;
+	u16 mem_array_handle;
+	u16 mem_dev_handle;
+} __packed;
+
 static inline int ras_bert_get_version(struct ras_bert_hest_generic_data *gdata)
 {
 	return gdata->revision >> 8;
@@ -121,29 +200,273 @@ struct ras_bert_section_dispatch {
 	ras_bert_section_parser parser;
 };
 
-static int ras_bert_record_section(struct ras_core_context *ras_core,
+static const struct ras_cper_guid ras_bert_guid_crashdump = GPU__CRASHDUMP;
+static const struct ras_cper_guid ras_bert_guid_proc_ia = PROC_ERR__SECTION_TYPE;
+static const struct ras_cper_guid ras_bert_guid_platform_mem = PLATFORM_MEM__SECTION_TYPE;
+static const struct ras_cper_guid ras_bert_guid_pcie = PCIE_ERR__SECTION_TYPE;
+static const struct ras_cper_guid ras_bert_guid_smn = SMN_ERR__SECTION_TYPE;
+
+static u64 ras_bert_read_le64(const u8 *data)
+{
+	u64 value = 0;
+	size_t i;
+
+	for (i = 0; i < sizeof(value); i++)
+		value |= (u64)data[i] << (i * 8);
+
+	return value;
+}
+
+static void ras_bert_fill_boot_ctx(struct ras_boot_err_ctx *ctx,
 				   struct ras_bert_hest_generic_data *gdata)
+{
+	memcpy(ctx->section_type, gdata->section_type, sizeof(ctx->section_type));
+	ctx->error_severity = gdata->error_severity;
+}
+
+static bool ras_bert_amd_body_valid(const u8 *body, u32 body_len)
+{
+	u64 valid_bits;
+	u32 context_count;
+	u32 error_count;
+	u32 min_size;
+
+	if (body_len < sizeof(struct crashdump_hdr))
+		return false;
+
+	valid_bits = ras_bert_read_le64(body);
+	if (valid_bits & ~AMD_CPER_BODY_VALID_MASK)
+		return false;
+	error_count = RAS_BERT_ERR_INFO_COUNT(valid_bits);
+	context_count = RAS_BERT_CONTEXT_COUNT(valid_bits);
+	if (!error_count && !context_count)
+		return false;
+
+	min_size = sizeof(struct crashdump_hdr) +
+		(error_count * sizeof(struct crashdump_error_info)) +
+		(context_count * sizeof(struct ras_bert_ia_proc_ctx));
+
+	return min_size <= body_len;
+}
+
+static bool ras_bert_fru_matches_device(struct ras_core_context *ras_core,
+					struct ras_bert_hest_generic_data *gdata)
+{
+	struct device_system_info dev_info = { 0 };
+	char fru_text[sizeof(gdata->fru_text) + 1] = { 0 };
+	unsigned int socket_id;
+
+	if (!(gdata->validation_bits & RAS_BERT_VALID_FRU_STRING))
+		return false;
+	if (ras_core_get_device_system_info(ras_core, &dev_info))
+		return false;
+
+	memcpy(fru_text, gdata->fru_text, sizeof(gdata->fru_text));
+	if (sscanf(fru_text, "OAM%u", &socket_id) != 1 &&
+	    sscanf(fru_text, "EAM%u", &socket_id) != 1)
+		return false;
+
+	return socket_id == dev_info.socket_id;
+}
+
+static void ras_bert_log_processor_section(struct ras_core_context *ras_core,
+					   struct ras_bert_hest_generic_data *gdata,
+					   const struct ras_bert_sec_proc_ia *proc,
+					   const struct ras_bert_ia_proc_ctx *ctx_info)
 {
 	struct ras_boot_err_ctx ctx = { 0 };
 	u16 data_size;
 
-	memcpy(ctx.section_type, gdata->section_type,
-	       min(sizeof(ctx.section_type), sizeof(gdata->section_type)));
-	ctx.error_severity = gdata->error_severity;
+	ras_bert_fill_boot_ctx(&ctx, gdata);
+	ctx.apic_id = proc->lapic_id;
+	if (proc->validation_bits & CPER_PROC_VALID_APIC_ID)
+		ctx.flags |= RAS_BOOT_CTX_VALID_APIC_ID;
+	ctx.reg_ctx_type = ctx_info->reg_ctx_type;
+	ctx.msr_addr = ctx_info->msr_addr;
+	ctx.mm_reg_addr = ctx_info->mm_reg_addr;
+	data_size = min_t(u16, ctx_info->reg_arr_size, sizeof(ctx.regs));
+	ctx.reg_arr_size = data_size;
+	memcpy(ctx.regs, ctx_info + 1, data_size);
+
+	ras_log_ring_add_log_event(ras_core, RAS_LOG_EVENT_BOOT, &ctx, sizeof(ctx), NULL);
+}
+
+static int ras_bert_record_amd_contexts(struct ras_core_context *ras_core,
+					struct ras_bert_hest_generic_data *gdata,
+					const u8 *body)
+{
+	const struct ras_bert_ia_proc_ctx *context;
+	u64 valid_bits = ras_bert_read_le64(body);
+	u32 error_count = RAS_BERT_ERR_INFO_COUNT(valid_bits);
+	u32 context_count = RAS_BERT_CONTEXT_COUNT(valid_bits);
+	u32 offset = sizeof(struct crashdump_hdr) +
+		(error_count * sizeof(struct crashdump_error_info));
+	u32 i;
+
+	for (i = 0; i < context_count; i++) {
+		struct ras_boot_err_ctx ctx = { 0 };
+		u32 context_size;
+		u16 data_size;
+
+		if (offset > gdata->error_data_length ||
+		    sizeof(*context) > gdata->error_data_length - offset)
+			return -EINVAL;
+
+		context = (const struct ras_bert_ia_proc_ctx *)(body + offset);
+		context_size = ALIGN(sizeof(*context) + context->reg_arr_size, 16);
+		if (context_size > gdata->error_data_length - offset)
+			return -EINVAL;
+
+		ras_bert_fill_boot_ctx(&ctx, gdata);
+		ctx.reg_ctx_type = context->reg_ctx_type;
+		ctx.msr_addr = context->msr_addr;
+		ctx.mm_reg_addr = context->mm_reg_addr;
+		data_size = min_t(u16, context->reg_arr_size, sizeof(ctx.regs));
+		ctx.reg_arr_size = data_size;
+		memcpy(ctx.regs, context + 1, data_size);
+		ras_log_ring_add_log_event(ras_core, RAS_LOG_EVENT_BOOT,
+					   &ctx, sizeof(ctx), NULL);
+
+		offset += context_size;
+	}
+
+	return 0;
+}
+
+static int ras_bert_record_section(struct ras_core_context *ras_core,
+				   struct ras_bert_hest_generic_data *gdata)
+{
+	struct aca_bank_ecc err = { 0 };
+	struct aca_bank_reg bank = { 0 };
+	struct device_system_info dev_info = { 0 };
+	struct ras_boot_err_ctx ctx = { 0 };
+	u64 *regs = ras_bert_get_payload(gdata);
+	u32 data_size;
+	int ret;
+
+	if (ras_bert_amd_body_valid((u8 *)regs, gdata->error_data_length)) {
+		if (!ras_bert_fru_matches_device(ras_core, gdata))
+			return 0;
+
+		return ras_bert_record_amd_contexts(ras_core, gdata,
+						    (const u8 *)regs);
+	}
+
+	if (gdata->error_data_length < sizeof(u64) * (RAS_CPER_ACA_REG_IPID + 1))
+		return 0;
+
+	bank.bank_type = MCE_BANK_TYPE_GPU;
+	data_size = min_t(u32, gdata->error_data_length, sizeof(bank.regs));
+	memcpy(bank.regs, regs, data_size);
+	ret = ras_aca_parse_bank(ras_core, &bank, &err);
+	if (ret || ras_core_get_device_system_info(ras_core, &dev_info) ||
+	    err.bank_info.socket_id != dev_info.socket_id)
+		return 0;
+
+	ras_bert_fill_boot_ctx(&ctx, gdata);
 	ctx.reg_ctx_type = CPER_CTX_TYPE__BOOT;
-	data_size = min_t(u32, gdata->error_data_length, sizeof(ctx.regs));
+	data_size = min_t(u32, data_size, sizeof(ctx.regs));
 	ctx.reg_arr_size = data_size;
-	memcpy(ctx.regs, ras_bert_get_payload(gdata), data_size);
+	memcpy(ctx.regs, regs, data_size);
 
 	ras_log_ring_add_log_event(ras_core, RAS_LOG_EVENT_BOOT, &ctx, sizeof(ctx), NULL);
 
 	return 0;
 }
 
-static const struct ras_cper_guid ras_bert_guid_crashdump = GPU__CRASHDUMP;
+static int ras_bert_record_proc_ia_section(struct ras_core_context *ras_core,
+					   struct ras_bert_hest_generic_data *gdata)
+{
+	struct ras_bert_ia_err_info *err_info;
+	struct ras_bert_ia_proc_ctx *ctx_info;
+	struct ras_bert_sec_proc_ia *proc;
+	u8 *section_end;
+	int ctx_count;
+	int err_count;
+	int i;
+
+	if (gdata->error_data_length < sizeof(*proc))
+		return -EINVAL;
+
+	if (!ras_core->bert_platform_owner)
+		return 0;
+
+	proc = ras_bert_get_payload(gdata);
+	section_end = (u8 *)proc + gdata->error_data_length;
+	err_count = RAS_BERT_ERR_INFO_COUNT(proc->validation_bits);
+	ctx_count = RAS_BERT_CONTEXT_COUNT(proc->validation_bits);
+	err_info = (struct ras_bert_ia_err_info *)(proc + 1);
+	if ((u8 *)err_info > section_end ||
+	    err_count * sizeof(*err_info) > section_end - (u8 *)err_info)
+		return -EINVAL;
+
+	err_info += err_count;
+	ctx_info = (struct ras_bert_ia_proc_ctx *)err_info;
+	for (i = 0; i < ctx_count; i++) {
+		size_t remaining;
+		size_t ctx_size;
+
+		if ((u8 *)ctx_info > section_end ||
+		    sizeof(*ctx_info) > section_end - (u8 *)ctx_info)
+			return -EINVAL;
+
+		remaining = section_end - (u8 *)ctx_info;
+		if (ctx_info->reg_arr_size > remaining - sizeof(*ctx_info))
+			return -EINVAL;
+		ctx_size = ALIGN(sizeof(*ctx_info) + ctx_info->reg_arr_size, 16);
+		if (ctx_size > remaining)
+			return -EINVAL;
+		if (ctx_info->reg_ctx_type != RAS_BERT_PROC_CTX_TYPE_MSR ||
+		    ctx_info->msr_addr < CPER_SMCA_MC0_STATUS_MSR ||
+		    (ctx_info->msr_addr - CPER_SMCA_MC0_STATUS_MSR) %
+		    CPER_SMCA_BANK_STRIDE)
+			goto next_ctx;
+		if (ctx_info->reg_arr_size < sizeof(u64))
+			goto next_ctx;
+
+		ras_bert_log_processor_section(ras_core, gdata, proc, ctx_info);
+
+next_ctx:
+		ctx_info = (struct ras_bert_ia_proc_ctx *)((u8 *)ctx_info + ctx_size);
+	}
+
+	return 0;
+}
+
+static int ras_bert_record_platform_mem_section(struct ras_core_context *ras_core,
+						struct ras_bert_hest_generic_data *gdata)
+{
+	struct ras_boot_err_ctx ctx = { 0 };
+	struct ras_bert_sec_mem_err *mem;
+	u16 data_size;
+
+	if (gdata->error_data_length != sizeof(struct ras_bert_sec_mem_err_old) &&
+	    gdata->error_data_length != sizeof(struct ras_bert_sec_mem_err))
+		return -EINVAL;
+
+	if (!ras_core->bert_platform_owner)
+		return 0;
+
+	mem = ras_bert_get_payload(gdata);
+	if (gdata->error_data_length > sizeof(ctx.raw_data))
+		return -EOVERFLOW;
+
+	ras_bert_fill_boot_ctx(&ctx, gdata);
+	data_size = gdata->error_data_length;
+	ctx.raw_data_size = data_size;
+	memcpy(ctx.raw_data, mem, data_size);
+
+	ras_log_ring_add_log_event(ras_core, RAS_LOG_EVENT_BOOT, &ctx, sizeof(ctx), NULL);
+
+	return 0;
+}
 
 static const struct ras_bert_section_dispatch ras_bert_section_dispatch[] = {
 	{ ras_bert_guid_crashdump.b, ras_bert_record_section },
+	{ ras_bert_guid_pcie.b, ras_bert_record_section },
+	{ ras_bert_guid_smn.b, ras_bert_record_section },
+	{ ras_bert_guid_proc_ia.b, ras_bert_record_proc_ia_section },
+	{ ras_bert_guid_platform_mem.b, ras_bert_record_platform_mem_section },
 };
 
 static const struct ras_bert_section_dispatch *
-- 
2.55.0

