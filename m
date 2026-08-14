Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B1F6C5DF7C
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Aug 2026 21:04:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B714910F749;
	Fri, 14 Aug 2026 21:04:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cimDglgk";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010056.outbound.protection.outlook.com
 [52.101.193.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC96D10F72E
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Aug 2026 21:04:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qpG/YJJ34u4vv0HqMR7dID3BdomYIPN+Chy3UcxPw5B4hTsVb87wVh/CKPxgRs58AWLskPbNytIHLIlvSsf+Yc7alcTG/WQiOiIdgTGNzrYfeuNtSUrGCsu+CeoPv9OTFhLvz8elujOmteJedSRDUCkfvr5FgTZDrCQFixAWeHrYKA0Xb12VclG0G7VChOABcLyK9cuDGZKkjlDcsrkf3ceunspwC5mND1Ftt0bBDl6C9PXz+rHoUhtvACdHTkA2mnurHubDs7aRsEYySbcUHm8Y7MXS3zLnR1LmBgQ76W8g9pTpONTxOJGHOEjELvXKoG+my8Wwsw/4U9uHJOga4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zlm8t6NeqEK0lJHJFZHJrmJFwJTgvu6cDR/6JtJsgxc=;
 b=xi8hEXW9oUeFVgsvZEfY71umaLenNcX4iJjRdIV+HWKDbQLRVRskgNOV7jcjEJ2LCzQ8Fr4LyoKMulg3wJgYzllrtyHn+lgSmLPCJta8jF9lEzgUYRa1q1FNWNBLZbnTOzGCDU/rkq7X6WiCd+GKnesvZBV95IO/THfjeJjQb47WeDBlA4fOpn0riN1n9z7C+WXjr2vm4ygHRxampau0gDtiAyv0NjRfBFUezpvcvXoRqca/K8NnK6U7zN0VurnVtfBuQM3bZQqcbjgTrLfeDs/BpV2tjzfYv0z+jnpw3AWmWnQU2oYFljcP5GDlqTEexg63hKjSfn9Xn2pD5yyUDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zlm8t6NeqEK0lJHJFZHJrmJFwJTgvu6cDR/6JtJsgxc=;
 b=cimDglgktKVDctB7rozO1cqxoGFVDwd4qljBA+C0rlW6rOloUieDR/ubPeSnBr2hxMiTepRp8NArmd7bxDVsC5cXBJ4RJuFdY01zOEXUOTlSS8+dKzq6fPmof43hPKwfJGLajefheakKoNadkIa4jBDJ34utHUTe2AROdjjySPo=
Received: from BN0PR07CA0013.namprd07.prod.outlook.com (2603:10b6:408:141::19)
 by DS0PR12MB999313.namprd12.prod.outlook.com (2603:10b6:8:42c::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.16; Fri, 14 Aug
 2026 21:03:55 +0000
Received: from BN2PEPF000044A3.namprd02.prod.outlook.com
 (2603:10b6:408:141:cafe::3d) by BN0PR07CA0013.outlook.office365.com
 (2603:10b6:408:141::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.16 via Frontend Transport; Fri,
 14 Aug 2026 21:03:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF000044A3.mail.protection.outlook.com (10.167.243.154) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Fri, 14 Aug 2026 21:03:55 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 14 Aug
 2026 16:03:51 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 14 Aug 2026 16:03:51 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: YiPeng Chai <YiPeng.Chai@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 090/109] drm/amd/ras: refactor ras cper to simplify adding new
 cper events
Date: Fri, 14 Aug 2026 17:02:27 -0400
Message-ID: <20260814210246.3067612-91-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260814210246.3067612-1-alexander.deucher@amd.com>
References: <20260814210246.3067612-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A3:EE_|DS0PR12MB999313:EE_
X-MS-Office365-Filtering-Correlation-Id: 16b022b0-0a5a-4e33-e794-08defa478d61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|23010399003|82310400026|376014|6133799003|10067099003|11063799006|56012099006|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: 5xAYujyjdi4hNF83HHT/hfcP73UoScOvbB8L++BVBEtjHOrq/5iFDb9b8LnSgsUy4JekteICAkpz66gFW2DwkRR6dT3D5gU9/G87kTfd7mNfOVX27JH/Ne1mrCB1smcvBmusiqc+cc6CARSkWqZjr3YP6Y/FkJfHbZxwQAlyGRY2u+nlz91He/4ND/MoHmMznCaBNJSWVyuvEUxJBca34pFtO66n2TtvE6eOOqHursgbIcTFji8Ew5hVray6Wb7KoxZB2NpgVSxDicps9SqPA6IsILgj/c1KXvwB1uiMPJuFPkzSGgdbEsHJ0XwXzmCVbPCdWfrsFo4jh3iaCiiGeETa4uxUNi+JIKn+1DQrOSvGx/56j06Q/UFQ7VKEy4Dz2UwetRlkbI1SZZvK8v/Io9JNlrgqzyEi1OBS+i5/N2dCX07/Kk0+Joj3mtYd7pY8hAGymuXapJa7ngYBfvx5k3hR6Zs74UztN9R7gXFM+Q+dJONouYxFuPaKz/n6rcG8wtcPmuhDsxoEyWlr8fRRn9fgKoOadD0bRRA/07h5JlZ5Hc4Fpl9mOpqPO6EQ4aupg2r/npEDcjb7pekOlU6lOo8R0RgiaWkeCpV+QgnidzyYOxJ6Q/xbk04GapZhBWPECNNsADYP1wxbAhCsF3/rHNKvxTUa6b+d6QmK6zgujhnt7xOEXns+y1C91fRhPs6nPSYo09Q9a1B3XawHq/QSNw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(23010399003)(82310400026)(376014)(6133799003)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: o+ej+iPS6LlFlB9dV2SNtqliQg3d0ASfxNrQn2yk8StLL8vcYmZ+6id7H18zfOA88MvYUIFjIXoy71kN4bcffVFxIoDwSoqq3JC1QeQDhEbR3gd7Km3L8SRWRrtL47XvjS0ji/PjP8m2DkVwnJrZFo8lHr5avtniOx4Rsjf2vdegqaDki29O1x6G6CvCHyA7Y6lPkzGYQQXYVGC/f45jsx43V3fONnFzU3rF/8l7NclX3HsIlUCHc7V8thLRLRrFagXK56ZpdVLeLlQXPBCJD/Uw5uGKuibzfK6WuoRfKTVB56T5SN+kjDlwGlpEcqLpctO37vv7bV/WV6raQoWAekrn2KIW3iymK0A/UaLEe+hGn6io0QmasG4GLbrrkFf9V6Avw9ycB6iYKROY5SXzOZugZ5RL5BhsVPgqrY3kIXP6PTPPAMEr6DsR5ugTv3yN
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 21:03:55.4397 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 16b022b0-0a5a-4e33-e794-08defa478d61
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A3.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB999313
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

Restructure ras cper to improve extensibility, making it straightforward
to add and handle new cper event types.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/ras/core/cmd.c            |   2 +-
 drivers/gpu/drm/amd/ras/core/core.c           |   6 +-
 drivers/gpu/drm/amd/ras/core/ras.h            |   1 +
 drivers/gpu/drm/amd/ras/core/ras_cper.c       | 532 +++++++++++-------
 drivers/gpu/drm/amd/ras/core/ras_cper.h       |  62 +-
 .../drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c |   2 +-
 6 files changed, 395 insertions(+), 210 deletions(-)

diff --git a/drivers/gpu/drm/amd/ras/core/cmd.c b/drivers/gpu/drm/amd/ras/core/cmd.c
index 2c328116f339c..ea5f6194d9863 100644
--- a/drivers/gpu/drm/amd/ras/core/cmd.c
+++ b/drivers/gpu/drm/amd/ras/core/cmd.c
@@ -229,7 +229,7 @@ static int ras_cmd_get_cper_records(struct ras_core_context *ras_core,
 		count = ras_log_ring_get_batch_records(ras_core, batch_id, trace,
 					trace_count);
 		if (count > 0) {
-			ret = ras_cper_generate_cper(ras_core, trace, count,
+			ret = ras_cper_generate_batch_cper(ras_core, trace, count,
 					&buf_ptr[offset], req->buf_size - offset, &real_data_len);
 			if (ret)
 				break;
diff --git a/drivers/gpu/drm/amd/ras/core/core.c b/drivers/gpu/drm/amd/ras/core/core.c
index e03f6889e1db5..d833e7de16d9e 100644
--- a/drivers/gpu/drm/amd/ras/core/core.c
+++ b/drivers/gpu/drm/amd/ras/core/core.c
@@ -408,6 +408,10 @@ int ras_core_sw_init(struct ras_core_context *ras_core)
 	if (ret)
 		return ret;
 
+	ret = ras_cper_sw_init(ras_core);
+	if (ret)
+		return ret;
+
 	return 0;
 }
 
@@ -424,7 +428,7 @@ int ras_core_sw_fini(struct ras_core_context *ras_core)
 	ras_aca_sw_fini(ras_core);
 	ras_eeprom_mgr_sw_fini(ras_core);
 	ras_mce_sw_fini(ras_core);
-
+	ras_cper_sw_fini(ras_core);
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/ras/core/ras.h b/drivers/gpu/drm/amd/ras/core/ras.h
index 6ae23a677f57b..464ad7381c5c0 100644
--- a/drivers/gpu/drm/amd/ras/core/ras.h
+++ b/drivers/gpu/drm/amd/ras/core/ras.h
@@ -402,6 +402,7 @@ struct ras_core_context {
 	struct ras_process ras_proc;
 	struct ras_log_ring ras_log_ring;
 	struct ras_mce ras_mce;
+	struct ras_cper ras_cper;
 
 	const struct ras_sys_func *sys_fn;
 
diff --git a/drivers/gpu/drm/amd/ras/core/ras_cper.c b/drivers/gpu/drm/amd/ras/core/ras_cper.c
index bb60fcd283a87..03240715b4aaf 100644
--- a/drivers/gpu/drm/amd/ras/core/ras_cper.c
+++ b/drivers/gpu/drm/amd/ras/core/ras_cper.c
@@ -27,12 +27,8 @@
 #include "ras_cper.h"
 #define ns_to_seconds(ns)   div_u64(ns, NSEC_PER_SEC)
 
-static const struct ras_cper_guid MCE	= CPER_NOTIFY__MCE;
-static const struct ras_cper_guid CMC	= CPER_NOTIFY__CMC;
-static const struct ras_cper_guid BOOT	= BOOT__TYPE;
-
-static const struct ras_cper_guid CRASHDUMP = GPU__CRASHDUMP;
-static const struct ras_cper_guid RUNTIME = GPU__NONSTANDARD_ERROR;
+static int ras_cper_get_profile(struct ras_core_context *ras_core,
+		enum ras_log_event event, struct ras_cper_profile **profile);
 
 static void cper_get_timestamp(struct ras_core_context *ras_core,
 		struct ras_cper_timestamp *timestamp, uint64_t utc_second_timestamp)
@@ -51,8 +47,8 @@ static void cper_get_timestamp(struct ras_core_context *ras_core,
 }
 
 static void fill_section_hdr(struct ras_core_context *ras_core,
-				struct cper_section_hdr *hdr, enum ras_cper_type type,
-				enum ras_cper_severity sev, struct ras_log_info *trace)
+		struct cper_section_hdr *hdr, struct ras_cper_guid notify_type,
+		enum ras_cper_severity sev, struct ras_log_info *log)
 {
 	struct device_system_info dev_info = {0};
 	char record_id[32];
@@ -70,10 +66,10 @@ static void fill_section_hdr(struct ras_core_context *ras_core,
 
 	ras_core_get_device_system_info(ras_core, &dev_info);
 
-	cper_get_timestamp(ras_core, &hdr->timestamp, ns_to_seconds(trace->timestamp));
+	cper_get_timestamp(ras_core, &hdr->timestamp, ns_to_seconds(log->timestamp));
 
 	snprintf(record_id, sizeof(record_id), "%d:%llX", dev_info.socket_id,
-		    RAS_LOG_SEQNO_TO_BATCH_IDX(trace->seqno));
+		    RAS_LOG_SEQNO_TO_BATCH_IDX(log->seqno));
 	memcpy(hdr->record_id, record_id, 8);
 
 	snprintf(hdr->platform_id, 16, "0x%04X:0x%04X",
@@ -81,40 +77,20 @@ static void fill_section_hdr(struct ras_core_context *ras_core,
 	/* pmfw version should be part of creator_id according to CPER spec */
 	snprintf(hdr->creator_id, 16, "%s", CPER_CREATOR_ID__AMDGPU);
 
-	switch (type) {
-	case RAS_CPER_TYPE_BOOT:
-		hdr->notify_type = BOOT;
-		break;
-	case RAS_CPER_TYPE_FATAL:
-	case RAS_CPER_TYPE_RMA:
-		hdr->notify_type = MCE;
-		break;
-	case RAS_CPER_TYPE_RUNTIME:
-		if (sev == RAS_CPER_SEV_NON_FATAL_CE)
-			hdr->notify_type = CMC;
-		else
-			hdr->notify_type = MCE;
-		break;
-	default:
-		RAS_DEV_ERR(ras_core->dev, "Unknown CPER Type\n");
-		break;
-	}
+	hdr->notify_type = notify_type;
 }
 
 static int fill_section_descriptor(struct ras_core_context *ras_core,
-					struct cper_section_desc *descriptor,
-					enum ras_cper_severity sev,
-					struct ras_cper_guid sec_type,
-					uint32_t section_offset,
-					uint32_t section_length)
+		struct cper_section_desc *descriptor, enum ras_cper_severity sev,
+		struct ras_cper_guid sec_type, uint32_t sec_offset, uint32_t sec_len)
 {
 	struct device_system_info dev_info = {0};
 
 	descriptor->revision_minor		= CPER_SEC__MINOR_REV_1;
 	descriptor->revision_major		= CPER_SEC__MAJOR_REV_22;
-	descriptor->sec_offset		= section_offset;
-	descriptor->sec_length		= section_length;
-	descriptor->valid_bits.fru_text	= 1;
+	descriptor->sec_offset		= sec_offset;
+	descriptor->sec_length		= sec_len;
+	descriptor->valid_bits.fru_text = 1;
 	descriptor->flag_bits.primary	= 1;
 	descriptor->severity = (sev == RAS_CPER_SEV_RMA ? RAS_CPER_SEV_FATAL_UE : sev);
 	descriptor->sec_type			= sec_type;
@@ -132,28 +108,31 @@ static int fill_section_descriptor(struct ras_core_context *ras_core,
 	return 0;
 }
 
-static int fill_section_fatal(struct ras_core_context *ras_core,
-		struct cper_section_fatal *fatal, struct ras_log_info *trace)
+static int fill_section_fatal(struct ras_core_context *ras_core, void *section,
+		struct ras_log_info *log, enum ras_cper_severity sev)
 {
+	struct cper_section_fatal *fatal = section;
+
 	fatal->data.reg_ctx_type = CPER_CTX_TYPE__CRASH;
 	fatal->data.reg_arr_size = sizeof(fatal->data.reg);
 
-	fatal->data.reg.status = trace->body.aca_reg.regs[RAS_CPER_ACA_REG_STATUS];
-	fatal->data.reg.addr   = trace->body.aca_reg.regs[RAS_CPER_ACA_REG_ADDR];
-	fatal->data.reg.ipid   = trace->body.aca_reg.regs[RAS_CPER_ACA_REG_IPID];
-	fatal->data.reg.synd   = trace->body.aca_reg.regs[RAS_CPER_ACA_REG_SYND];
+	fatal->data.reg.status = log->body.aca_reg.regs[RAS_CPER_ACA_REG_STATUS];
+	fatal->data.reg.addr   = log->body.aca_reg.regs[RAS_CPER_ACA_REG_ADDR];
+	fatal->data.reg.ipid   = log->body.aca_reg.regs[RAS_CPER_ACA_REG_IPID];
+	fatal->data.reg.synd   = log->body.aca_reg.regs[RAS_CPER_ACA_REG_SYND];
 
 	return 0;
 }
 
-static int fill_section_runtime(struct ras_core_context *ras_core,
-		struct cper_section_runtime *runtime, struct ras_log_info *trace,
-		enum ras_cper_severity sev)
+static int fill_section_runtime(struct ras_core_context *ras_core, void *section,
+		struct ras_log_info *log, enum ras_cper_severity sev)
 {
+	struct cper_section_runtime *runtime = section;
+
 	runtime->hdr.valid_bits.err_info_cnt = 1;
 	runtime->hdr.valid_bits.err_context_cnt = 1;
 
-	runtime->descriptor.error_type = RUNTIME;
+	runtime->descriptor.error_type = GPU__NONSTANDARD_ERROR;
 	runtime->descriptor.ms_chk_bits.err_type_valid = 1;
 	if (sev == RAS_CPER_SEV_RMA) {
 		runtime->descriptor.valid_bits.ms_chk = 1;
@@ -165,26 +144,27 @@ static int fill_section_runtime(struct ras_core_context *ras_core,
 	runtime->reg.reg_arr_size = sizeof(runtime->reg.reg_dump);
 
 	runtime->reg.reg_dump[RAS_CPER_ACA_REG_CTL] =
-			trace->body.aca_reg.regs[ACA_REG_IDX__CTL];
+			log->body.aca_reg.regs[ACA_REG_IDX__CTL];
 	runtime->reg.reg_dump[RAS_CPER_ACA_REG_STATUS] =
-			trace->body.aca_reg.regs[ACA_REG_IDX__STATUS];
+			log->body.aca_reg.regs[ACA_REG_IDX__STATUS];
 	runtime->reg.reg_dump[RAS_CPER_ACA_REG_ADDR] =
-			trace->body.aca_reg.regs[ACA_REG_IDX__ADDR];
+			log->body.aca_reg.regs[ACA_REG_IDX__ADDR];
 	runtime->reg.reg_dump[RAS_CPER_ACA_REG_MISC0] =
-			trace->body.aca_reg.regs[ACA_REG_IDX__MISC0];
+			log->body.aca_reg.regs[ACA_REG_IDX__MISC0];
 	runtime->reg.reg_dump[RAS_CPER_ACA_REG_CONFIG] =
-			trace->body.aca_reg.regs[ACA_REG_IDX__CONFG];
+			log->body.aca_reg.regs[ACA_REG_IDX__CONFG];
 	runtime->reg.reg_dump[RAS_CPER_ACA_REG_IPID] =
-			trace->body.aca_reg.regs[ACA_REG_IDX__IPID];
+			log->body.aca_reg.regs[ACA_REG_IDX__IPID];
 	runtime->reg.reg_dump[RAS_CPER_ACA_REG_SYND] =
-			trace->body.aca_reg.regs[ACA_REG_IDX__SYND];
+			log->body.aca_reg.regs[ACA_REG_IDX__SYND];
 
 	return 0;
 }
 
-static int fill_section_boot(struct ras_core_context *ras_core, struct cper_section_boot *boot,
-			     struct ras_log_info *log)
+static int fill_section_boot(struct ras_core_context *ras_core, void *section,
+		struct ras_log_info *log, enum ras_cper_severity sev)
 {
+	struct cper_section_boot *boot = section;
 	struct ras_boot_err_ctx *ctx = &log->body.boot_err_ctx;
 	struct crashdump_boot *data = &boot->data;
 
@@ -196,138 +176,114 @@ static int fill_section_boot(struct ras_core_context *ras_core, struct cper_sect
 	return 0;
 }
 
-static int cper_generate_runtime_record(struct ras_core_context *ras_core,
-	struct cper_section_hdr *hdr, struct ras_log_info *trace_arr, uint32_t arr_num,
-		enum ras_cper_severity sev)
+static int cper_boot_get_severity(struct ras_log_info *log,
+			enum ras_cper_severity *sev)
 {
-	struct cper_section_desc *descriptor;
-	struct cper_section_runtime *runtime;
-	int i;
-
-	fill_section_hdr(ras_core, hdr, RAS_CPER_TYPE_RUNTIME, sev, &trace_arr[0]);
-	hdr->record_length =  RAS_HDR_LEN + ((RAS_SEC_DESC_LEN + RAS_NONSTD_SEC_LEN) * arr_num);
-	hdr->sec_cnt = arr_num;
-	for (i = 0; i < arr_num; i++) {
-		descriptor = (struct cper_section_desc *)((uint8_t *)hdr +
-			     RAS_SEC_DESC_OFFSET(i));
-		runtime = (struct cper_section_runtime *)((uint8_t *)hdr +
-			  RAS_NONSTD_SEC_OFFSET(hdr->sec_cnt, i));
-
-		fill_section_descriptor(ras_core, descriptor, sev, RUNTIME,
-			RAS_NONSTD_SEC_OFFSET(hdr->sec_cnt, i),
-			sizeof(struct cper_section_runtime));
-		fill_section_runtime(ras_core, runtime, &trace_arr[i], sev);
-	}
-
+	*sev = log->body.boot_err_ctx.error_severity;
 	return 0;
 }
 
-static int cper_generate_fatal_record(struct ras_core_context *ras_core,
-	uint8_t *buffer, struct ras_log_info *trace_arr, uint32_t arr_num)
+static int cper_boot_get_sec_type(struct ras_log_info *log, struct ras_cper_guid *out)
 {
-	struct ras_cper_fatal_record record = {0};
-	int i = 0;
-
-	for (i = 0; i < arr_num; i++) {
-		fill_section_hdr(ras_core, &record.hdr, RAS_CPER_TYPE_FATAL,
-				 RAS_CPER_SEV_FATAL_UE, &trace_arr[i]);
-		record.hdr.record_length =  RAS_HDR_LEN + RAS_SEC_DESC_LEN + RAS_FATAL_SEC_LEN;
-		record.hdr.sec_cnt = 1;
-
-		fill_section_descriptor(ras_core, &record.descriptor, RAS_CPER_SEV_FATAL_UE,
-					CRASHDUMP, offsetof(struct ras_cper_fatal_record, fatal),
-					sizeof(struct cper_section_fatal));
-
-		fill_section_fatal(ras_core, &record.fatal, &trace_arr[i]);
+	memcpy(out, &log->body.boot_err_ctx.section_type,
+		min(sizeof(*out), sizeof(log->body.boot_err_ctx.section_type)));
+	return 0;
+}
 
-		memcpy(buffer + (i * record.hdr.record_length),
-				&record, record.hdr.record_length);
-	}
+static uint32_t cper_get_record_size(const struct ras_cper_profile *profile,
+		uint32_t section_count)
+{
+	if (profile->build_record_per_log)
+		return (RAS_HDR_LEN + RAS_SEC_DESC_LEN + profile->section_size) *
+			section_count;
 
-	return 0;
+	return RAS_HDR_LEN +
+		(RAS_SEC_DESC_LEN + profile->section_size) * section_count;
 }
 
-static int cper_generate_boot_record(struct ras_core_context *ras_core, u8 *buffer,
-				     struct ras_log_info *trace_arr, u32 arr_num)
+static int cper_build_single_record(struct ras_core_context *ras_core,
+		struct cper_section_hdr *hdr, const struct ras_cper_profile *profile,
+		struct ras_log_info *batch_logs, uint32_t nr_batch_logs)
 {
-	struct ras_cper_boot_record *record;
-	int i;
+	enum ras_cper_severity sev = profile->severity;
+	struct ras_cper_guid sec_type = profile->sec_type;
+	struct ras_cper_guid notify_type = profile->notify_type;
+	struct cper_section_desc *descriptor;
+	uint32_t desc_off, sec_off;
+	void *section;
+	uint32_t i;
 
-	record = kzalloc(sizeof(*record), GFP_KERNEL);
-	if (!record)
-		return -ENOMEM;
+	if (profile->get_severity)
+		profile->get_severity(&batch_logs[0], &sev);
 
-	for (i = 0; i < arr_num; i++) {
-		u32 severity = trace_arr[i].body.boot_err_ctx.error_severity;
-		struct ras_cper_guid section_type;
+	if (profile->get_sec_type)
+		profile->get_sec_type(&batch_logs[0], &sec_type);
 
-		memcpy(&section_type, &trace_arr[i].body.boot_err_ctx.section_type,
-			min(sizeof(section_type),
-			    sizeof(trace_arr[i].body.boot_err_ctx.section_type)));
+	if (profile->get_notify_type)
+		profile->get_notify_type(&batch_logs[0], &notify_type);
 
-		fill_section_hdr(ras_core, &record->hdr, RAS_CPER_TYPE_BOOT, severity,
-				 &trace_arr[i]);
-		record->hdr.record_length = RAS_HDR_LEN + RAS_SEC_DESC_LEN + RAS_BOOT_SEC_LEN;
-		record->hdr.sec_cnt = 1;
+	fill_section_hdr(ras_core, hdr, notify_type, sev, &batch_logs[0]);
+	hdr->sec_cnt = nr_batch_logs;
+	hdr->record_length = RAS_HDR_LEN +
+		(RAS_SEC_DESC_LEN + profile->section_size) * nr_batch_logs;
 
-		fill_section_descriptor(ras_core, &record->descriptor, severity, section_type,
-					offsetof(struct ras_cper_boot_record, boot),
-					sizeof(struct ras_cper_boot_record));
+	for (i = 0; i < nr_batch_logs; i++) {
+		desc_off = RAS_HDR_LEN + (RAS_SEC_DESC_LEN * i);
+		sec_off  = RAS_HDR_LEN + (RAS_SEC_DESC_LEN * nr_batch_logs) +
+			   (profile->section_size * i);
 
-		fill_section_boot(ras_core, &record->boot, &trace_arr[i]);
+		descriptor = (struct cper_section_desc *)((uint8_t *)hdr + desc_off);
+		section = (uint8_t *)hdr + sec_off;
 
-		memcpy(buffer + (i * record->hdr.record_length), record, record->hdr.record_length);
+		fill_section_descriptor(ras_core, descriptor, sev,
+			sec_type, sec_off, profile->section_size);
+
+		profile->fill_section(ras_core, section, &batch_logs[i], sev);
 	}
 
-	kfree(record);
 	return 0;
 }
 
-static int cper_get_record_size(enum ras_cper_type type, uint16_t section_count)
+static int cper_build_multiple_records(struct ras_core_context *ras_core,
+		uint8_t *buffer, const struct ras_cper_profile *profile,
+		struct ras_log_info *batch_logs, uint32_t nr_batch_logs)
 {
-	int size = 0;
-
-	size += RAS_HDR_LEN;
-	size += (RAS_SEC_DESC_LEN * section_count);
-
-	switch (type) {
-	case RAS_CPER_TYPE_RUNTIME:
-	case RAS_CPER_TYPE_RMA:
-		size += (RAS_NONSTD_SEC_LEN * section_count);
-		break;
-	case RAS_CPER_TYPE_FATAL:
-		size += (RAS_FATAL_SEC_LEN * section_count);
-		size += (RAS_HDR_LEN * (section_count - 1));
-		break;
-	case RAS_CPER_TYPE_BOOT:
-		size += (RAS_BOOT_SEC_LEN * section_count);
-		break;
-	default:
-		/* should never reach here */
-		break;
-	}
+	uint32_t rec_len = RAS_HDR_LEN + RAS_SEC_DESC_LEN + profile->section_size;
+	uint32_t i;
 
-	return size;
-}
+	for (i = 0; i < nr_batch_logs; i++) {
+		struct ras_log_info *log = &batch_logs[i];
+		enum ras_cper_severity sev = profile->severity;
+		struct ras_cper_guid sec_type = profile->sec_type;
+		struct ras_cper_guid notify_type = profile->notify_type;
+		struct cper_section_hdr *hdr;
+		struct cper_section_desc *descriptor;
+		void *section;
 
-static enum ras_cper_type cper_ras_log_event_to_cper_type(enum ras_log_event event)
-{
-	switch (event) {
-	case RAS_LOG_EVENT_UE:
-		return RAS_CPER_TYPE_FATAL;
-	case RAS_LOG_EVENT_DE:
-	case RAS_LOG_EVENT_CE:
-	case RAS_LOG_EVENT_POISON_CREATION:
-	case RAS_LOG_EVENT_POISON_CONSUMPTION:
-		return RAS_CPER_TYPE_RUNTIME;
-	case RAS_LOG_EVENT_RMA:
-		return RAS_CPER_TYPE_RMA;
-	case RAS_LOG_EVENT_BOOT:
-		return RAS_CPER_TYPE_BOOT;
-	default:
-		/* should never reach here */
-		return RAS_CPER_TYPE_RUNTIME;
+		if (profile->get_severity)
+			profile->get_severity(log, &sev);
+
+		if (profile->get_sec_type)
+			profile->get_sec_type(log, &sec_type);
+
+		if (profile->get_notify_type)
+			profile->get_notify_type(log, &notify_type);
+
+		hdr = (struct cper_section_hdr *)(buffer + (i * rec_len));
+		descriptor = (struct cper_section_desc *)((uint8_t *)hdr + RAS_HDR_LEN);
+		section = (uint8_t *)hdr + RAS_HDR_LEN + RAS_SEC_DESC_LEN;
+
+		fill_section_hdr(ras_core, hdr, notify_type, sev, log);
+		hdr->sec_cnt = 1;
+		hdr->record_length = rec_len;
+
+		fill_section_descriptor(ras_core, descriptor, sev, sec_type,
+			RAS_HDR_LEN + RAS_SEC_DESC_LEN, profile->section_size);
+
+		profile->fill_section(ras_core, section, log, sev);
 	}
+
+	return 0;
 }
 
 static enum ras_log_event cper_mce_parse_err_type(struct ras_core_context *ras_core,
@@ -350,57 +306,235 @@ static enum ras_log_event cper_mce_parse_err_type(struct ras_core_context *ras_c
 	return RAS_LOG_EVENT_NONE;
 }
 
-int ras_cper_generate_cper(struct ras_core_context *ras_core,
-		struct ras_log_info *trace_list, uint32_t count,
+int ras_cper_generate_batch_cper(struct ras_core_context *ras_core,
+		struct ras_log_info *batch_logs, uint32_t nr_batch_logs,
 		uint8_t *buf, uint32_t buf_len, uint32_t *real_data_len)
 {
-	uint8_t *buffer = buf;
-	uint64_t buf_size = buf_len;
-	int record_size, saved_size = 0;
-	struct cper_section_hdr *hdr;
+	struct ras_cper *cper = &ras_core->ras_cper;
+	struct ras_cper_profile *profile;
+	enum ras_log_event event;
+	uint32_t record_size;
+	int ret = 0;
 
-	if (trace_list[0].event == RAS_LOG_EVENT_MCE) {
+	if (!batch_logs || !nr_batch_logs || !buf || !buf_len || !real_data_len)
+		return -EINVAL;
+
+	*real_data_len = 0;
+
+	event = batch_logs[0].event;
+	if (event == RAS_LOG_EVENT_MCE) {
 		struct aca_bank_reg bank = { 0 };
 
 		/* MCE is encoded as 1 record each */
-		memcpy(&bank.regs, &trace_list[0].body.aca_reg.regs, sizeof(bank.regs));
-		trace_list[0].event = cper_mce_parse_err_type(ras_core, &bank);
+		memcpy(&bank.regs, &batch_logs[0].body.aca_reg.regs, sizeof(bank.regs));
+		event = cper_mce_parse_err_type(ras_core, &bank);
+		batch_logs[0].event = event;
 	}
 
-	/* All the batch traces share the same event */
-	record_size = cper_get_record_size(
-			cper_ras_log_event_to_cper_type(trace_list[0].event), count);
+	mutex_lock(&cper->profile_mutex);
+	/* All the batch logs share the same event */
+	ret = ras_cper_get_profile(ras_core, event, &profile);
+	if (ret) {
+		RAS_DEV_ERR(ras_core->dev,
+			"Unprocessed ras log event: %d, ret:%d\n", event, ret);
+		goto out;
+	}
+
+	record_size = cper_get_record_size(profile, nr_batch_logs);
+	if (record_size > buf_len) {
+		ret = -ENOMEM;
+		goto out;
+	}
 
-	if ((record_size + saved_size) > buf_size)
+	memset(buf, 0, record_size);
+
+	if (profile->build_record_per_log)
+		cper_build_multiple_records(ras_core, buf, profile, batch_logs, nr_batch_logs);
+	else
+		cper_build_single_record(ras_core,
+			(struct cper_section_hdr *)buf, profile, batch_logs, nr_batch_logs);
+
+	*real_data_len = record_size;
+
+out:
+	mutex_unlock(&cper->profile_mutex);
+	return ret;
+}
+
+static int ras_cper_get_profile(struct ras_core_context *ras_core,
+		enum ras_log_event event, struct ras_cper_profile **profile)
+{
+	struct ras_cper *cper = &ras_core->ras_cper;
+
+	if (!profile || event < 0 || event >= cper->nr_profiles)
+		return -EINVAL;
+
+	if (!cper->profiles)
+		return -EPERM;
+
+	if (!cper->profiles[event].fill_section)
+		return -ENOENT;
+
+	*profile = &cper->profiles[event];
+
+	return 0;
+}
+
+static struct ras_cper_profile ras_ue_profile = {
+	.cper_type        = RAS_CPER_TYPE_FATAL,
+	.severity         = RAS_CPER_SEV_FATAL_UE,
+	.notify_type      = CPER_NOTIFY__MCE,
+	.sec_type         = GPU__CRASHDUMP,
+	.section_size     = sizeof(struct cper_section_fatal),
+	.build_record_per_log = true,
+	.fill_section     = fill_section_fatal,
+};
+
+static struct ras_cper_profile ras_de_profile = {
+	.cper_type        = RAS_CPER_TYPE_RUNTIME,
+	.severity         = RAS_CPER_SEV_NON_FATAL_UE,
+	.notify_type      = CPER_NOTIFY__MCE,
+	.sec_type         = GPU__NONSTANDARD_ERROR,
+	.section_size     = sizeof(struct cper_section_runtime),
+	.build_record_per_log = false,
+	.fill_section     = fill_section_runtime,
+};
+
+static struct ras_cper_profile ras_ce_profile = {
+	.cper_type        = RAS_CPER_TYPE_RUNTIME,
+	.severity         = RAS_CPER_SEV_NON_FATAL_CE,
+	.notify_type      = CPER_NOTIFY__CMC,
+	.sec_type         = GPU__NONSTANDARD_ERROR,
+	.section_size     = sizeof(struct cper_section_runtime),
+	.build_record_per_log = false,
+	.fill_section     = fill_section_runtime,
+};
+
+static struct ras_cper_profile ras_rma_profile = {
+	.cper_type        = RAS_CPER_TYPE_RUNTIME,
+	.severity         = RAS_CPER_SEV_RMA,
+	.notify_type      = CPER_NOTIFY__MCE,
+	.sec_type         = GPU__NONSTANDARD_ERROR,
+	.section_size     = sizeof(struct cper_section_runtime),
+	.build_record_per_log = false,
+	.fill_section     = fill_section_runtime,
+};
+
+static struct ras_cper_profile ras_boot_profile = {
+	.cper_type        = RAS_CPER_TYPE_BOOT,
+	.severity         = RAS_CPER_SEV_FATAL_UE,
+	.notify_type      = BOOT__TYPE,
+	.sec_type         = GPU__CRASHDUMP,
+	.section_size     = sizeof(struct cper_section_boot),
+	.build_record_per_log = true,
+	.get_severity     = cper_boot_get_severity,
+	.get_sec_type     = cper_boot_get_sec_type,
+	.fill_section     = fill_section_boot,
+};
+
+static struct ras_event_profile_map ras_event_profile_maps[] = {
+	{RAS_LOG_EVENT_UE,   &ras_ue_profile},
+	{RAS_LOG_EVENT_DE,   &ras_de_profile},
+	{RAS_LOG_EVENT_CE,   &ras_ce_profile},
+	{RAS_LOG_EVENT_RMA,  &ras_rma_profile},
+	{RAS_LOG_EVENT_BOOT, &ras_boot_profile},
+};
+
+int ras_cper_sw_init(struct ras_core_context *ras_core)
+{
+	struct ras_cper *cper = &ras_core->ras_cper;
+	struct ras_cper_profile *profiles;
+	uint32_t nr_profiles = RAS_LOG_EVENT_COUNT_MAX;
+	int i, ret = 0;
+
+	profiles = kcalloc(nr_profiles, sizeof(*profiles), GFP_KERNEL);
+	if (!profiles)
 		return -ENOMEM;
 
-	hdr = (struct cper_section_hdr *)(buffer + saved_size);
-
-	switch (trace_list[0].event) {
-	case RAS_LOG_EVENT_RMA:
-		cper_generate_runtime_record(ras_core, hdr, trace_list, count, RAS_CPER_SEV_RMA);
-		break;
-	case RAS_LOG_EVENT_DE:
-		cper_generate_runtime_record(ras_core,
-			hdr, trace_list, count, RAS_CPER_SEV_NON_FATAL_UE);
-		break;
-	case RAS_LOG_EVENT_CE:
-		cper_generate_runtime_record(ras_core,
-			hdr, trace_list, count, RAS_CPER_SEV_NON_FATAL_CE);
-		break;
-	case RAS_LOG_EVENT_UE:
-		cper_generate_fatal_record(ras_core, buffer + saved_size, trace_list, count);
-		break;
-	case RAS_LOG_EVENT_BOOT:
-		cper_generate_boot_record(ras_core, buffer + saved_size, trace_list, count);
-		break;
-	default:
-		RAS_DEV_WARN(ras_core->dev, "Unprocessed trace event: %d\n", trace_list[0].event);
-		break;
+	cper->profiles = profiles;
+	cper->nr_profiles = nr_profiles;
+	mutex_init(&cper->profile_mutex);
+
+	for (i = 0; i < ARRAY_SIZE(ras_event_profile_maps); i++) {
+		ret = ras_cper_register_profile(ras_core,
+				ras_event_profile_maps[i].event,
+				ras_event_profile_maps[i].profile);
+		if (ret) {
+			RAS_DEV_ERR(ras_core->dev,
+				"Failed to register %u profile. ret:%d\n",
+				ras_event_profile_maps[i].event, ret);
+			goto out;
+		}
 	}
 
-	saved_size += record_size;
+	return 0;
+
+out:
+	ras_cper_sw_fini(ras_core);
+	return ret;
+}
+
+int ras_cper_sw_fini(struct ras_core_context *ras_core)
+{
+	struct ras_cper *cper = &ras_core->ras_cper;
+
+	if (!cper->profiles)
+		return 0;
+
+	kfree(cper->profiles);
+	cper->profiles = NULL;
+	cper->nr_profiles = 0;
+	mutex_destroy(&cper->profile_mutex);
 
-	*real_data_len = saved_size;
 	return 0;
 }
+
+int ras_cper_register_profile(struct ras_core_context *ras_core,
+	enum ras_log_event event, struct ras_cper_profile *profile)
+{
+	struct ras_cper *cper = &ras_core->ras_cper;
+	int ret = 0;
+
+	if (!profile || event >= cper->nr_profiles)
+		return -EINVAL;
+
+	if (!cper->profiles)
+		return -EPERM;
+
+	mutex_lock(&cper->profile_mutex);
+	if (cper->profiles[event].fill_section) {
+		ret = -EEXIST;
+		goto out;
+	}
+
+	memcpy(&cper->profiles[event], profile, sizeof(struct ras_cper_profile));
+
+out:
+	mutex_unlock(&cper->profile_mutex);
+	return ret;
+}
+
+int ras_cper_unregister_profile(struct ras_core_context *ras_core,
+	enum ras_log_event event)
+{
+	struct ras_cper *cper = &ras_core->ras_cper;
+	int ret = 0;
+
+	if (event >= cper->nr_profiles)
+		return -EINVAL;
+
+	if (!cper->profiles)
+		return -EPERM;
+
+	mutex_lock(&cper->profile_mutex);
+	if (!cper->profiles[event].fill_section) {
+		ret = 0;
+		goto out;
+	}
+
+	memset(&cper->profiles[event], 0, sizeof(struct ras_cper_profile));
+
+out:
+	mutex_unlock(&cper->profile_mutex);
+	return ret;
+}
diff --git a/drivers/gpu/drm/amd/ras/core/ras_cper.h b/drivers/gpu/drm/amd/ras/core/ras_cper.h
index 037e8072eb2bc..f69f4e4de9ec9 100644
--- a/drivers/gpu/drm/amd/ras/core/ras_cper.h
+++ b/drivers/gpu/drm/amd/ras/core/ras_cper.h
@@ -23,6 +23,7 @@
  */
 #ifndef __RAS_CPER_H__
 #define __RAS_CPER_H__
+#include "log_ring.h"
 
 #define CPER_UUID_MAX_SIZE 16
 struct ras_cper_guid {
@@ -46,6 +47,7 @@ struct ras_cper_guid {
 
 #define CPER_CREATOR_ID__AMDGPU	"amdgpu"
 
+/* Cper Notification Type */
 #define CPER_NOTIFY__MCE                                               \
 	CPER_GUID__INIT(0xE8F56FFE, 0x919C, 0x4cc5, 0xBA, 0x88, 0x65, 0xAB, \
 		  0xE1, 0x49, 0x13, 0xBB)
@@ -56,6 +58,7 @@ struct ras_cper_guid {
 	CPER_GUID__INIT(0x3D61A466, 0xAB40, 0x409a, 0xA6, 0x98, 0xF3, 0x62, \
 		  0xD4, 0x64, 0xB3, 0x8F)
 
+/* Cper Section Type */
 #define GPU__CRASHDUMP                                                 \
 	CPER_GUID__INIT(0x32AC0C78, 0x2623, 0x48F6, 0xB0, 0xD0, 0x73, 0x65, \
 		  0x72, 0x5F, 0xD6, 0xAE)
@@ -73,6 +76,7 @@ enum ras_cper_type {
 	RAS_CPER_TYPE_RMA,
 };
 
+/* Cper Error Severity */
 enum ras_cper_severity {
 	RAS_CPER_SEV_NON_FATAL_UE   = 0,
 	RAS_CPER_SEV_FATAL_UE       = 1,
@@ -286,12 +290,50 @@ struct ras_cper_boot_record {
 };
 #pragma pack(pop)
 
+struct ras_core_context;
+struct ras_log_info;
+enum ras_log_event;
+/*
+ * Per-event description of how to build its CPER record(s).
+ *
+ * Fixed fields (severity/notify_type/sec_type) are used as-is unless the matching
+ * optional hook (get_severity/get_notify_type/get_sec_type) is provided.
+ */
+struct ras_cper_profile {
+	enum ras_cper_type     cper_type;
+	enum ras_cper_severity severity;
+	struct ras_cper_guid   notify_type;
+	struct ras_cper_guid   sec_type;
+	uint32_t section_size;
+	/* true: one CPER record per log */
+	bool build_record_per_log;
+
+	int (*get_severity)(struct ras_log_info *log, enum ras_cper_severity *out);
+	int (*get_notify_type)(struct ras_log_info *log, struct ras_cper_guid *out);
+	int (*get_sec_type)(struct ras_log_info *log, struct ras_cper_guid *out);
+
+	/* Required: fill the error-type specific section body for one log */
+	int (*fill_section)(struct ras_core_context *ras_core, void *section,
+			    struct ras_log_info *log, enum ras_cper_severity sev);
+};
+
+struct ras_event_profile_map {
+	uint32_t event;
+	struct ras_cper_profile *profile;
+};
+
+struct ras_cper {
+	struct ras_cper_profile *profiles;
+	uint32_t nr_profiles;
+	struct mutex profile_mutex;
+};
+
 #define RAS_HDR_LEN				(sizeof(struct cper_section_hdr))
-#define RAS_SEC_DESC_LEN			(sizeof(struct cper_sec_desc))
+#define RAS_SEC_DESC_LEN			(sizeof(struct cper_section_desc))
 
-#define RAS_BOOT_SEC_LEN			(sizeof(struct cper_sec_crashdump_boot))
-#define RAS_FATAL_SEC_LEN			(sizeof(struct cper_sec_crashdump_fatal))
-#define RAS_NONSTD_SEC_LEN			(sizeof(struct cper_sec_nonstd_err))
+#define RAS_BOOT_SEC_LEN			(sizeof(struct cper_section_boot))
+#define RAS_FATAL_SEC_LEN			(sizeof(struct cper_section_fatal))
+#define RAS_NONSTD_SEC_LEN			(sizeof(struct cper_section_runtime))
 
 #define RAS_SEC_DESC_OFFSET(idx)		(RAS_HDR_LEN + (RAS_SEC_DESC_LEN * idx))
 
@@ -302,9 +344,13 @@ struct ras_cper_boot_record {
 #define RAS_NONSTD_SEC_OFFSET(count, idx) \
 	(RAS_HDR_LEN + (RAS_SEC_DESC_LEN * count) + (RAS_NONSTD_SEC_LEN * idx))
 
-struct ras_core_context;
-struct ras_log_info;
-int ras_cper_generate_cper(struct ras_core_context *ras_core,
-		struct ras_log_info *trace_list, uint32_t count,
+int ras_cper_sw_init(struct ras_core_context *ras_core);
+int ras_cper_sw_fini(struct ras_core_context *ras_core);
+int ras_cper_generate_batch_cper(struct ras_core_context *ras_core,
+		struct ras_log_info *batch_logs, uint32_t nr_batch_logs,
 		uint8_t *buf, uint32_t buf_len, uint32_t *real_data_len);
+int ras_cper_register_profile(struct ras_core_context *ras_core,
+	enum ras_log_event event, struct ras_cper_profile *profile);
+int ras_cper_unregister_profile(struct ras_core_context *ras_core,
+	enum ras_log_event event);
 #endif
diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c
index f6b114d9d613f..9c7430aec3f3a 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c
@@ -308,7 +308,7 @@ static int amdgpu_virt_ras_get_cper_records(struct ras_core_context *ras_core,
 							  trace, trace_count,
 							  rsp_cache);
 		if (count > 0) {
-			ret = ras_cper_generate_cper(ras_core, trace, count,
+			ret = ras_cper_generate_batch_cper(ras_core, trace, count,
 					&out_buf[offset], req->buf_size - offset, &real_data_len);
 			if (ret)
 				break;
-- 
2.55.0

