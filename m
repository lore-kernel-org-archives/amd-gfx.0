Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABC76C5DF6A
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Aug 2026 21:03:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 487A010F6E0;
	Fri, 14 Aug 2026 21:03:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zIEyuXMN";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010005.outbound.protection.outlook.com
 [52.101.193.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C28B10F6DF
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Aug 2026 21:03:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yMW9S0EvqB3ksAdEbfq1F0bpLUYKb2AY2tqEEtuOvRPquIKypgIARgWvO0MAllF7LlPLIJNrkTbw321RUxjNFRVu1ab7OoLXK+bjRDkv0DwV2VvliyI7UzNFSv7GXgRKX/9JITt7r15AETdK+BxEZNaOcMBfctUfHNdVoeWa1y7bXuPfMipHps+8qvTrpzoPR0AcrfpvnbKtDareiCmIqv+9x3tekxjRk7csHl+QiOIjE5FpNqs10WQQO5p+67jcdfubywlMekcBL+5lyhI1qUbivGzd3AnWii59aXhppvV1Puwuvz8V4HgYBhTaf7UwSWKi05k5v8F8SbxABac1ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XSPGgkPsStjvPDLSg8auLyVcJVv1G3ebHLVwPkuQfxk=;
 b=s9AqMCB8ut8OxKmnGj++k0X3ZOZEEnMxTusDuu61lWkhMn7E46Rh1ZSKmKQzDBE9ya1qW4UDrpvIinr4VkfEAAKcyPGrkffSUC1nNFhUu6NdgHjY79+lnb1937Srb8+UFTabRqN+g4yKrsGK/DEFl0NAjiW5GnmCLkuceARd/3RFQ3Y8YpFOiVgffcrZ03DI+9vmZegvnSSj3LYkC2EvkgEJZnA5orlFJWS2r8M7vCZwXk0lbJKE0B8F0ffYAb7rAJ21bcGmv/MBCEH6B6NyTIfAWxobBGct6876THbgleDKEZkzWpCfgg0O9/ugc9vwBFOL9XGvLMJCJjOiJbbihA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XSPGgkPsStjvPDLSg8auLyVcJVv1G3ebHLVwPkuQfxk=;
 b=zIEyuXMNZdjjMYB26rsawak8P80TQnCJUKgbEfb4wKf7eqfzKs/ixx1L3vUWyQmuujzmmEZaoZtZPYNSQDXlCZDzM48gXjSv57dTf/Ef/VqL3h75WzSdV1qsOoAYEMDkngOFYeNhXPGwU4dojIzNkBQ8kB+XFYPnORts3fMM+mY=
Received: from DS1PR07CA0021.namprd07.prod.outlook.com (2603:10b6:8:44d::8) by
 PH7PR12MB8826.namprd12.prod.outlook.com (2603:10b6:510:26a::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.13; Fri, 14 Aug 2026 21:03:05 +0000
Received: from CH3PEPF00000018.namprd21.prod.outlook.com
 (2603:10b6:8:44d:cafe::52) by DS1PR07CA0021.outlook.office365.com
 (2603:10b6:8:44d::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.16 via Frontend Transport; Fri,
 14 Aug 2026 21:03:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF00000018.mail.protection.outlook.com (10.167.244.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.0 via Frontend Transport; Fri, 14 Aug 2026 21:03:04 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 14 Aug
 2026 16:03:01 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 14 Aug
 2026 16:03:00 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 14 Aug 2026 16:03:00 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Xiang Liu <xiang.liu@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>, Alex
 Deucher <alexander.deucher@amd.com>
Subject: [PATCH 006/109] drm/amd/ras: Introduce BOOT CPER encoding function
Date: Fri, 14 Aug 2026 17:01:03 -0400
Message-ID: <20260814210246.3067612-7-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260814210246.3067612-1-alexander.deucher@amd.com>
References: <20260814210246.3067612-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000018:EE_|PH7PR12MB8826:EE_
X-MS-Office365-Filtering-Correlation-Id: d72f9240-bd4d-4288-2dc8-08defa476f15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|23010399003|82310400026|1800799024|6133799003|56012099006|10067099003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: rKY1AMiVnBqe32j4d1ZGMBBo4kDGU3W+knPg5zeo+W02QDK7qibTMyN0ULVu86F3oeFfs7CD2lZTM5U+B3VdjczOS1W1NWjVa+ldtqVFDMSJ063JyvMchyqqF4yBIPSq93y1pqx7rtv6OtWVG8gfUjr+QK5YLjfzx8ZRheLWnkAy9nzNQgP63lGb6jddoM6ORlONBkrjT6+T74fu6Q5+PiHcTcNC0pFP32qEomjE/u02zImhZd/VxwUxQZDM+HReYHh0RDjKCuFkzeZ9LwiA+TxdpiyAaToNlYdACcapUWsr2ZoHm9pnsGB0rsAF1F7kAXX9w5D0RHFic2WaOR03jRmijQYqSnFxBYY5WmciLHEbkrj+5ZZL2+NcT458IjJ9bTqZLz914t5zYqkE6Gjl/mESs8rV9YkxaCxrqlKWXGhqalO2NElT2U9k6lbgbcTgFnM996h9W9gi/7SkNt251odSVOLCmDPLi2feBmb7w6WIXFJn9cXbgjePlXEXTyW0sOrCFBWoYxu2gNaSqW+tRPU+u17GylQ989XbUj+H3jaXs1qdoAJLfSS++gAYAiDtRc3QtY0cwdbCemRI/tDtReEdJ7ZIe4I1Oyq0dPrEYHOtVqDesAQ0WJX8dpFxbjxbSB7pSqLsGC8YMzD8s3qbY2lk4v3HrA44X6Y5qnw83gUiHlZJUGi6rdHHAjmketZzu8Pn+dRs6HygJz3JLg0zyg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(23010399003)(82310400026)(1800799024)(6133799003)(56012099006)(10067099003)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: CN0QBoCe64kS7lwMKGo3Qxafek4eiFvgG3XkQb43Bn/uI4e6BfjxTONjLWM2dztgh/MyURb/oCZ6PjDHQQhkoLoOnqtJhS1CaWDy+utP3o3dl7gnEb4DezCdxefXg8bMsBHuMuLsmC2aXw8JEtJFdN8e8sp0XfDnRB/35gK1Zi+uBpIpFcEC9SXrYut7crOndm4NdWD+7pxaogB+mwt+Y+lFYbkN01UBYmIB3Z/30o8vbeUsJ8TKVyzCsA9HcCl3Eupz74tcYC2O8k+0j5TmCWhKW7o22r2/RTwdkAEUsofrFyjB1JXuCPYLYi10WhZfMQPzCyLjI4ebS9Gay3azqjoXfcPP+OQQEuCIjvW6IDqdPlBFhS4Qi/mf4BKljqgfJjRgaZm0eTF5jqCcgb12d4HqgcDrWQXrS8P08Fzhw0Di5txP4V9j+xX5+84vi3KB
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 21:03:04.5919 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d72f9240-bd4d-4288-2dc8-08defa476f15
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000018.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8826
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

Introduce new fields for BOOT CPER encoding, only important fields are
introduced here due to the cache size limit.

Signed-off-by: Xiang Liu <xiang.liu@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/ras/core/log_ring.c |  8 +++-
 drivers/gpu/drm/amd/ras/core/log_ring.h | 11 ++++++
 drivers/gpu/drm/amd/ras/core/ras_cper.c | 51 +++++++++++++++++++++++++
 drivers/gpu/drm/amd/ras/core/ras_cper.h | 10 ++++-
 4 files changed, 76 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/ras/core/log_ring.c b/drivers/gpu/drm/amd/ras/core/log_ring.c
index 175c8b3571447..73f075b0f1fdd 100644
--- a/drivers/gpu/drm/amd/ras/core/log_ring.c
+++ b/drivers/gpu/drm/amd/ras/core/log_ring.c
@@ -251,8 +251,12 @@ void ras_log_ring_add_log_event(struct ras_core_context *ras_core,
 		batch_tag ? batch_tag->timestamp : ras_core_get_utc_second_timestamp(ras_core);
 	log->event = event;
 
-	if (data)
-		memcpy(&log->aca_reg, data, sizeof(log->aca_reg));
+	if (data) {
+		if (event == RAS_LOG_EVENT_BOOT)
+			memcpy(&log->boot_err_ctx, data, sizeof(log->boot_err_ctx));
+		else
+			memcpy(&log->aca_reg, data, sizeof(log->aca_reg));
+	}
 
 	if (event == RAS_LOG_EVENT_RMA) {
 		memcpy(&log->aca_reg, ras_rma_aca_reg, sizeof(log->aca_reg));
diff --git a/drivers/gpu/drm/amd/ras/core/log_ring.h b/drivers/gpu/drm/amd/ras/core/log_ring.h
index 13973add0e5cb..428ad48d08fee 100644
--- a/drivers/gpu/drm/amd/ras/core/log_ring.h
+++ b/drivers/gpu/drm/amd/ras/core/log_ring.h
@@ -24,6 +24,7 @@
 #ifndef __LOG_RING_H__
 #define __LOG_RING_H__
 #include "aca.h"
+#include "ras_cper.h"
 
 #define MAX_RECORD_PER_BATCH 32
 
@@ -38,6 +39,7 @@ enum ras_log_event {
 	RAS_LOG_EVENT_POISON_CONSUMPTION,
 	RAS_LOG_EVENT_RMA,
 	RAS_LOG_EVENT_MCE,
+	RAS_LOG_EVENT_BOOT,
 	RAS_LOG_EVENT_COUNT_MAX,
 };
 
@@ -45,12 +47,21 @@ struct ras_aca_reg {
 	uint64_t regs[ACA_REG_MAX_COUNT];
 };
 
+struct ras_boot_err_ctx {
+	u8 section_type[16];
+	u32 error_severity;
+	u16 reg_ctx_type;
+	u16 reg_arr_size;
+	u64 regs[CPER_OAM_MAX_COUNT];
+};
+
 struct ras_log_info {
 	uint64_t seqno;
 	uint64_t timestamp;
 	enum ras_log_event event;
 	union {
 		struct ras_aca_reg aca_reg;
+		struct ras_boot_err_ctx boot_err_ctx;
 	};
 };
 
diff --git a/drivers/gpu/drm/amd/ras/core/ras_cper.c b/drivers/gpu/drm/amd/ras/core/ras_cper.c
index fb37c7cc29142..6d7c1cf6a8f4e 100644
--- a/drivers/gpu/drm/amd/ras/core/ras_cper.c
+++ b/drivers/gpu/drm/amd/ras/core/ras_cper.c
@@ -174,6 +174,19 @@ static int fill_section_runtime(struct ras_core_context *ras_core,
 	return 0;
 }
 
+static int fill_section_boot(struct ras_core_context *ras_core, struct cper_section_boot *boot,
+			     struct ras_log_info *log)
+{
+	struct ras_boot_err_ctx *ctx = &log->boot_err_ctx;
+	struct crashdump_boot *data = &boot->data;
+
+	data->reg_ctx_type = ctx->reg_ctx_type;
+	data->reg_arr_size = ctx->reg_arr_size;
+	memcpy(data->msg, ctx->regs, min(boot->data.reg_arr_size, sizeof(data->msg)));
+
+	return 0;
+}
+
 static int cper_generate_runtime_record(struct ras_core_context *ras_core,
 	struct cper_section_hdr *hdr, struct ras_log_info *trace_arr, uint32_t arr_num,
 		enum ras_cper_severity sev)
@@ -225,6 +238,41 @@ static int cper_generate_fatal_record(struct ras_core_context *ras_core,
 	return 0;
 }
 
+static int cper_generate_boot_record(struct ras_core_context *ras_core, u8 *buffer,
+				     struct ras_log_info *trace_arr, u32 arr_num)
+{
+	struct ras_cper_boot_record *record;
+	int i;
+
+	record = kzalloc(sizeof(*record), GFP_KERNEL);
+	if (!record)
+		return -ENOMEM;
+
+	for (i = 0; i < arr_num; i++) {
+		u32 severity = trace_arr[i].boot_err_ctx.error_severity;
+		struct ras_cper_guid section_type;
+
+		memcpy(&section_type, &trace_arr[i].boot_err_ctx.section_type,
+		       min(sizeof(section_type), sizeof(trace_arr[i].boot_err_ctx.section_type)));
+
+		fill_section_hdr(ras_core, &record->hdr, RAS_CPER_TYPE_BOOT, severity,
+				 &trace_arr[i]);
+		record->hdr.record_length = RAS_HDR_LEN + RAS_SEC_DESC_LEN + RAS_BOOT_SEC_LEN;
+		record->hdr.sec_cnt = 1;
+
+		fill_section_descriptor(ras_core, &record->descriptor, severity, section_type,
+					offsetof(struct ras_cper_boot_record, boot),
+					sizeof(struct ras_cper_boot_record));
+
+		fill_section_boot(ras_core, &record->boot, &trace_arr[i]);
+
+		memcpy(buffer + (i * record->hdr.record_length), record, record->hdr.record_length);
+	}
+
+	kfree(record);
+	return 0;
+}
+
 static int cper_get_record_size(enum ras_cper_type type, uint16_t section_count)
 {
 	int size = 0;
@@ -331,6 +379,9 @@ int ras_cper_generate_cper(struct ras_core_context *ras_core,
 	case RAS_LOG_EVENT_UE:
 		cper_generate_fatal_record(ras_core, buffer + saved_size, trace_list, count);
 		break;
+	case RAS_LOG_EVENT_BOOT:
+		cper_generate_boot_record(ras_core, buffer + saved_size, trace_list, count);
+		break;
 	default:
 		RAS_DEV_WARN(ras_core->dev, "Unprocessed trace event: %d\n", trace_list[0].event);
 		break;
diff --git a/drivers/gpu/drm/amd/ras/core/ras_cper.h b/drivers/gpu/drm/amd/ras/core/ras_cper.h
index 8bfbeb7d78e01..037e8072eb2bc 100644
--- a/drivers/gpu/drm/amd/ras/core/ras_cper.h
+++ b/drivers/gpu/drm/amd/ras/core/ras_cper.h
@@ -30,11 +30,11 @@ struct ras_cper_guid {
 };
 
 #define CPER_GUID__INIT(a, b, c, d0, d1, d2, d3, d4, d5, d6, d7)			\
-	((struct ras_cper_guid)								\
+	(struct ras_cper_guid)								\
 	{{ (a) & 0xff, ((a) >> 8) & 0xff, ((a) >> 16) & 0xff, ((a) >> 24) & 0xff, \
 		(b) & 0xff, ((b) >> 8) & 0xff,					\
 		(c) & 0xff, ((c) >> 8) & 0xff,					\
-		(d0), (d1), (d2), (d3), (d4), (d5), (d6), (d7) }})
+		(d0), (d1), (d2), (d3), (d4), (d5), (d6), (d7) }}
 
 #define CPER_HDR__REV_1          (0x100)
 #define CPER_SEC__MINOR_REV_1    (0x01)
@@ -278,6 +278,12 @@ struct ras_cper_fatal_record {
 	struct cper_section_desc descriptor;
 	struct cper_section_fatal fatal;
 };
+
+struct ras_cper_boot_record {
+	struct cper_section_hdr hdr;
+	struct cper_section_desc descriptor;
+	struct cper_section_boot boot;
+};
 #pragma pack(pop)
 
 #define RAS_HDR_LEN				(sizeof(struct cper_section_hdr))
-- 
2.55.0

