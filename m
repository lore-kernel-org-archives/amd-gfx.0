Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4572AC5CFCF
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Aug 2026 21:03:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DA1C010F6E8;
	Fri, 14 Aug 2026 21:03:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="k43P0hxr";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013005.outbound.protection.outlook.com
 [40.93.196.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B5CF710F6E0
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Aug 2026 21:03:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TDjgSHxzftpW1gy17ocLLPm17gYluk2h/Ao4WWm9tGCdFT0LaP3VHRfyeKU/DJZahcBchKK8DkRZ+V7g6Syx0wbzbuNnMgy4ZOYLsmuS0WHOGok0BgSfd/leAJ/whPORcaW31RVAsoDSFIsDgimvy2k4wmq1/F6J6b0SUego75sNPQ3AE2EWSmvdSepmbLme6RfOjjeIWLPV47/IoGMycYDZUa9n1iuKR5FUkRaOIJMbMX3RwEcE11bVCrm9kHxyGzwLUAoBGIkQHbajEmG65I77pTqWxJ7OPGSi5Id188hr0kF4PxT0Xvd9hQXhVqD+RoIjIa+o5tLyJc3ZSMsqJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M190NoyoUnnCLKgRP2swTbEjXhaYYJz/FopNtSxuIk8=;
 b=ar+J30Mttedd3bIJc9JClzXAR1F1eKqp+dIkqRa1fXoLLoNRe58qtxqIDM3JBqZSnx35G8G9dzzZ3xIBOYj9SFtRKrRGeSaXN5KAtq/M3eCreR8/yBAJu5iuANqT8DbaX+obCisCbionfhI5c6KLjCYFlacIC63vFSvkGsmQn4Sauy2apy8OQluyAs4n7pqEWC1wQaejGZuQz001i565lEgm4jqc3TSyUaZhLwzGIC0oH0E/TAfk2p3FOltXZGPWmnWvUPaEd602DhN0HG7fQF6hW6zvc972ZKyuX+fp7IHXL/8rMHi1IUhGkmA3W9gdnDp+biXCgk1rjxvgye8E0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M190NoyoUnnCLKgRP2swTbEjXhaYYJz/FopNtSxuIk8=;
 b=k43P0hxrVKufAZ3t83VXBbF9lnrPilY02EO+a+oA3+GxpO5KTQ310jJOP8/B3SgtffkMb7zkP0TCOiQYdKd2oTDTpxh/FihutfK8vfrOtE2Lv/ZVZUoSqgMZpZsEQYYHWqGmcsI82QiEldWn2/AVxw0IxashFkR7q+X/0g5TLw0=
Received: from DS1PR07CA0021.namprd07.prod.outlook.com (2603:10b6:8:44d::8) by
 DS0PR12MB7874.namprd12.prod.outlook.com (2603:10b6:8:141::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.15; Fri, 14 Aug 2026 21:03:07 +0000
Received: from CH3PEPF00000018.namprd21.prod.outlook.com
 (2603:10b6:8:44d:cafe::81) by DS1PR07CA0021.outlook.office365.com
 (2603:10b6:8:44d::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.16 via Frontend Transport; Fri,
 14 Aug 2026 21:03:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF00000018.mail.protection.outlook.com (10.167.244.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.0 via Frontend Transport; Fri, 14 Aug 2026 21:03:07 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 14 Aug
 2026 16:03:05 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 14 Aug 2026 16:03:04 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: YiPeng Chai <YiPeng.Chai@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 013/109] drm/amd/ras: Improve function interface to record
 different types of data
Date: Fri, 14 Aug 2026 17:01:10 -0400
Message-ID: <20260814210246.3067612-14-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260814210246.3067612-1-alexander.deucher@amd.com>
References: <20260814210246.3067612-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000018:EE_|DS0PR12MB7874:EE_
X-MS-Office365-Filtering-Correlation-Id: 5aaeb441-9d2e-4a15-5da9-08defa477099
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|82310400026|376014|36860700016|56012099006|11063799006|10067099003|6133799003|3023799007|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: QA3D2cKyVOsSSQXpSjldmdJpTc9MzxuJhwhX+fQw398e8lmzMu4zpu40mwuxAMvMEqITI/jRViMsdwuTRIJmMg8Wz1g69AyqGe/JGMr5RYxte2WXXOTtRI4Q0qw1FtYDVDKeWVRhlk7s/yi0147/PghxRfZuMn460cheFAd98YRZqiCXuAknu3tjt/Su/lK1x9jQUNLTm6Sx11FA+WHeIhSgCVImq1nFwGqwdeziiIXwP+e3gZN0TBBzBR1VvRdcxTf1m8nJEJIobXW4DK+CzLl+9RXWQ8nrA2R8MtcnfKmXED30tNKlrJkjbW8UZ91JC2Wl1pFxkwFJNe9C9DeYfE+lNjQkh5I/WQRZdH0e9pzi+SgkjGUtOgbVL9f2m8aj3o3S4ya+mndmCMkKUzLdgY/RAPyInfXvP1Y46AVbw9NncrC8arcIzYD2NNStkkxCLq5RtVPmriZfif4ibRULNVYkn16AuXNztPX/mS2NiwROe5GUZgktEXW6nKMtLVYzuMpXm/g3cl7GDirFTPI/37449a078gewz1YKaB8W2bafSeycSnb+PE3NS0gycfznVclLW7AZi4qynwBrTQ3N1ykjTvH8T+C7KGYj/zAifcXcoBU3RgIsiXE0CwkE7Nk4G4c6KiKL+u2i41Z5ol/PA+ar/Ni8av6KvUkP1Hl7iU16hL3dPbgEDe/wBrrRwU3+7NQn7WVBCIS6N9iE1KH4sQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(82310400026)(376014)(36860700016)(56012099006)(11063799006)(10067099003)(6133799003)(3023799007)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: pIVIxeJmSlkmPy2qn4brx3/t+rFDC1eSsYaDu9nh4uX8yKEsnEIbsijM1V4WYDcvIP3DKClw6o2fCnk63vQoRNgRmbuQGi1O/nBLNWXwp+G7HeJzDThgb/UWJeg+f1Ly9iedDldSZhwg7GS95pnvj7hoWJrOo0ElO63lVLye5VBMUZ1G7IMfDxIZQX7/1xuzdE+FjEQzZoD27/JJbIrYdEjjAe771GjH2deah1YRR7asfnMZ8YFzocyKjDJHvGiYr4kl8bSAZmmdSSRfCIdLLWCxJGzVxzwc56nzZIdkCik7jlFcwlQT1dfiBxX3RZ3P6J44irvlcWX21iE0bK7FKiu71pHzMxti9OcEHqgMyRQZD+q5IHqyl1HHlOZOw3FWjuERdinYw0uqdv2w8shymTGjYZeJ0qnc9zNG/+SL1WA24IrsKYTAZU/+s5XHTWDn
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 21:03:07.1629 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5aaeb441-9d2e-4a15-5da9-08defa477099
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000018.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7874
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

Improve function interface to record different types of data.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/ras/core/aca.c            | 11 +++--
 drivers/gpu/drm/amd/ras/core/cmd.c            |  5 ++-
 drivers/gpu/drm/amd/ras/core/log_ring.c       | 17 +++-----
 drivers/gpu/drm/amd/ras/core/log_ring.h       | 13 +++---
 drivers/gpu/drm/amd/ras/core/ras_cper.c       | 43 +++++++++++--------
 .../gpu/drm/amd/ras/ras_mgr/amdgpu_ras_sys.c  |  2 +-
 6 files changed, 53 insertions(+), 38 deletions(-)

diff --git a/drivers/gpu/drm/amd/ras/core/aca.c b/drivers/gpu/drm/amd/ras/core/aca.c
index 4258ffb490a60..67269062f072b 100644
--- a/drivers/gpu/drm/amd/ras/core/aca.c
+++ b/drivers/gpu/drm/amd/ras/core/aca.c
@@ -132,15 +132,20 @@ static void aca_log_bank_data(struct ras_core_context *ras_core,
 			struct aca_bank_reg *bank, struct aca_bank_ecc *bank_ecc,
 			struct ras_log_batch_tag *batch)
 {
+	enum ras_log_event event;
+
 	if (batch && bank->timestamp)
 		batch->timestamp = bank->timestamp;
 
 	if (bank_ecc->ue_count)
-		ras_log_ring_add_log_event(ras_core, RAS_LOG_EVENT_UE, bank->regs, batch);
+		event = RAS_LOG_EVENT_UE;
 	else if (bank_ecc->de_count)
-		ras_log_ring_add_log_event(ras_core, RAS_LOG_EVENT_DE, bank->regs, batch);
+		event = RAS_LOG_EVENT_DE;
 	else
-		ras_log_ring_add_log_event(ras_core, RAS_LOG_EVENT_CE, bank->regs, batch);
+		event = RAS_LOG_EVENT_CE;
+
+	ras_log_ring_add_log_event(ras_core,
+		event, bank->regs, sizeof(bank->regs), batch);
 }
 
 static int aca_get_bank_count(struct ras_core_context *ras_core,
diff --git a/drivers/gpu/drm/amd/ras/core/cmd.c b/drivers/gpu/drm/amd/ras/core/cmd.c
index 35c53f47e4500..98767a94d267b 100644
--- a/drivers/gpu/drm/amd/ras/core/cmd.c
+++ b/drivers/gpu/drm/amd/ras/core/cmd.c
@@ -331,8 +331,9 @@ static int ras_cmd_get_batch_trace_records(struct ras_core_context *ras_core,
 				record->seqno = trace_arry[j].seqno;
 				record->timestamp = trace_arry[j].timestamp;
 				record->event = trace_arry[j].event;
-				memcpy(&record->aca_reg,
-					&trace_arry[j].aca_reg, sizeof(trace_arry[j].aca_reg));
+				memcpy(&record->body.aca_reg,
+					&trace_arry[j].body.aca_reg,
+					sizeof(trace_arry[j].body.aca_reg));
 			}
 		} else {
 			count = 0;
diff --git a/drivers/gpu/drm/amd/ras/core/log_ring.c b/drivers/gpu/drm/amd/ras/core/log_ring.c
index 73f075b0f1fdd..b57749bc63d0f 100644
--- a/drivers/gpu/drm/amd/ras/core/log_ring.c
+++ b/drivers/gpu/drm/amd/ras/core/log_ring.c
@@ -223,7 +223,8 @@ void ras_log_ring_destroy_batch_tag(struct ras_core_context *ras_core,
 }
 
 void ras_log_ring_add_log_event(struct ras_core_context *ras_core,
-		enum ras_log_event event, void *data, struct ras_log_batch_tag *batch_tag)
+		enum ras_log_event event,
+		void *data, uint32_t size, struct ras_log_batch_tag *batch_tag)
 {
 	struct ras_log_ring *log_ring = &ras_core->ras_log_ring;
 	struct device_system_info dev_info = {0};
@@ -251,19 +252,15 @@ void ras_log_ring_add_log_event(struct ras_core_context *ras_core,
 		batch_tag ? batch_tag->timestamp : ras_core_get_utc_second_timestamp(ras_core);
 	log->event = event;
 
-	if (data) {
-		if (event == RAS_LOG_EVENT_BOOT)
-			memcpy(&log->boot_err_ctx, data, sizeof(log->boot_err_ctx));
-		else
-			memcpy(&log->aca_reg, data, sizeof(log->aca_reg));
-	}
+	if (data && size && size <= sizeof(log->body))
+		memcpy(&log->body, data, size);
 
 	if (event == RAS_LOG_EVENT_RMA) {
-		memcpy(&log->aca_reg, ras_rma_aca_reg, sizeof(log->aca_reg));
+		memcpy(&log->body.aca_reg, ras_rma_aca_reg, sizeof(log->body.aca_reg));
 		ras_core_get_device_system_info(ras_core, &dev_info);
 		socket_id = dev_info.socket_id;
-		log->aca_reg.regs[ACA_REG_IDX__IPID] |= ((socket_id / 4) & 0x01);
-		log->aca_reg.regs[ACA_REG_IDX__IPID] |= (((socket_id % 4) & 0x3) << 44);
+		log->body.aca_reg.regs[ACA_REG_IDX__IPID] |= ((socket_id / 4) & 0x01);
+		log->body.aca_reg.regs[ACA_REG_IDX__IPID] |= (((socket_id % 4) & 0x3) << 44);
 	}
 
 	ras_log_ring_add_data(ras_core, log, batch_tag);
diff --git a/drivers/gpu/drm/amd/ras/core/log_ring.h b/drivers/gpu/drm/amd/ras/core/log_ring.h
index 428ad48d08fee..2eaeccfb8965f 100644
--- a/drivers/gpu/drm/amd/ras/core/log_ring.h
+++ b/drivers/gpu/drm/amd/ras/core/log_ring.h
@@ -55,14 +55,16 @@ struct ras_boot_err_ctx {
 	u64 regs[CPER_OAM_MAX_COUNT];
 };
 
+union ras_log_body {
+	struct ras_aca_reg aca_reg;
+	struct ras_boot_err_ctx boot_err_ctx;
+};
+
 struct ras_log_info {
 	uint64_t seqno;
 	uint64_t timestamp;
 	enum ras_log_event event;
-	union {
-		struct ras_aca_reg aca_reg;
-		struct ras_boot_err_ctx boot_err_ctx;
-	};
+	union ras_log_body body;
 };
 
 struct ras_log_batch_tag {
@@ -95,7 +97,8 @@ struct ras_log_batch_tag *ras_log_ring_create_batch_tag(struct ras_core_context
 void ras_log_ring_destroy_batch_tag(struct ras_core_context *ras_core,
 			struct ras_log_batch_tag *tag);
 void ras_log_ring_add_log_event(struct ras_core_context *ras_core,
-		enum ras_log_event event, void *data, struct ras_log_batch_tag *tag);
+		enum ras_log_event event,
+		void *data, uint32_t size, struct ras_log_batch_tag *batch_tag);
 
 int ras_log_ring_get_batch_records(struct ras_core_context *ras_core, uint64_t batch_idx,
 		struct ras_log_info *log_arr, uint32_t arr_num);
diff --git a/drivers/gpu/drm/amd/ras/core/ras_cper.c b/drivers/gpu/drm/amd/ras/core/ras_cper.c
index 6d7c1cf6a8f4e..82fd277c3552f 100644
--- a/drivers/gpu/drm/amd/ras/core/ras_cper.c
+++ b/drivers/gpu/drm/amd/ras/core/ras_cper.c
@@ -137,10 +137,10 @@ static int fill_section_fatal(struct ras_core_context *ras_core,
 	fatal->data.reg_ctx_type = CPER_CTX_TYPE__CRASH;
 	fatal->data.reg_arr_size = sizeof(fatal->data.reg);
 
-	fatal->data.reg.status = trace->aca_reg.regs[RAS_CPER_ACA_REG_STATUS];
-	fatal->data.reg.addr   = trace->aca_reg.regs[RAS_CPER_ACA_REG_ADDR];
-	fatal->data.reg.ipid   = trace->aca_reg.regs[RAS_CPER_ACA_REG_IPID];
-	fatal->data.reg.synd   = trace->aca_reg.regs[RAS_CPER_ACA_REG_SYND];
+	fatal->data.reg.status = trace->body.aca_reg.regs[RAS_CPER_ACA_REG_STATUS];
+	fatal->data.reg.addr   = trace->body.aca_reg.regs[RAS_CPER_ACA_REG_ADDR];
+	fatal->data.reg.ipid   = trace->body.aca_reg.regs[RAS_CPER_ACA_REG_IPID];
+	fatal->data.reg.synd   = trace->body.aca_reg.regs[RAS_CPER_ACA_REG_SYND];
 
 	return 0;
 }
@@ -163,13 +163,20 @@ static int fill_section_runtime(struct ras_core_context *ras_core,
 	runtime->reg.reg_ctx_type = CPER_CTX_TYPE__CRASH;
 	runtime->reg.reg_arr_size = sizeof(runtime->reg.reg_dump);
 
-	runtime->reg.reg_dump[RAS_CPER_ACA_REG_CTL]    = trace->aca_reg.regs[ACA_REG_IDX__CTL];
-	runtime->reg.reg_dump[RAS_CPER_ACA_REG_STATUS] = trace->aca_reg.regs[ACA_REG_IDX__STATUS];
-	runtime->reg.reg_dump[RAS_CPER_ACA_REG_ADDR]   = trace->aca_reg.regs[ACA_REG_IDX__ADDR];
-	runtime->reg.reg_dump[RAS_CPER_ACA_REG_MISC0]  = trace->aca_reg.regs[ACA_REG_IDX__MISC0];
-	runtime->reg.reg_dump[RAS_CPER_ACA_REG_CONFIG] = trace->aca_reg.regs[ACA_REG_IDX__CONFG];
-	runtime->reg.reg_dump[RAS_CPER_ACA_REG_IPID]   = trace->aca_reg.regs[ACA_REG_IDX__IPID];
-	runtime->reg.reg_dump[RAS_CPER_ACA_REG_SYND]   = trace->aca_reg.regs[ACA_REG_IDX__SYND];
+	runtime->reg.reg_dump[RAS_CPER_ACA_REG_CTL] =
+			trace->body.aca_reg.regs[ACA_REG_IDX__CTL];
+	runtime->reg.reg_dump[RAS_CPER_ACA_REG_STATUS] =
+			trace->body.aca_reg.regs[ACA_REG_IDX__STATUS];
+	runtime->reg.reg_dump[RAS_CPER_ACA_REG_ADDR] =
+			trace->body.aca_reg.regs[ACA_REG_IDX__ADDR];
+	runtime->reg.reg_dump[RAS_CPER_ACA_REG_MISC0] =
+			trace->body.aca_reg.regs[ACA_REG_IDX__MISC0];
+	runtime->reg.reg_dump[RAS_CPER_ACA_REG_CONFIG] =
+			trace->body.aca_reg.regs[ACA_REG_IDX__CONFG];
+	runtime->reg.reg_dump[RAS_CPER_ACA_REG_IPID] =
+			trace->body.aca_reg.regs[ACA_REG_IDX__IPID];
+	runtime->reg.reg_dump[RAS_CPER_ACA_REG_SYND] =
+			trace->body.aca_reg.regs[ACA_REG_IDX__SYND];
 
 	return 0;
 }
@@ -177,12 +184,13 @@ static int fill_section_runtime(struct ras_core_context *ras_core,
 static int fill_section_boot(struct ras_core_context *ras_core, struct cper_section_boot *boot,
 			     struct ras_log_info *log)
 {
-	struct ras_boot_err_ctx *ctx = &log->boot_err_ctx;
+	struct ras_boot_err_ctx *ctx = &log->body.boot_err_ctx;
 	struct crashdump_boot *data = &boot->data;
 
 	data->reg_ctx_type = ctx->reg_ctx_type;
 	data->reg_arr_size = ctx->reg_arr_size;
-	memcpy(data->msg, ctx->regs, min(boot->data.reg_arr_size, sizeof(data->msg)));
+	memcpy(data->msg, ctx->regs,
+		min(boot->data.reg_arr_size, sizeof(data->msg)));
 
 	return 0;
 }
@@ -249,11 +257,12 @@ static int cper_generate_boot_record(struct ras_core_context *ras_core, u8 *buff
 		return -ENOMEM;
 
 	for (i = 0; i < arr_num; i++) {
-		u32 severity = trace_arr[i].boot_err_ctx.error_severity;
+		u32 severity = trace_arr[i].body.boot_err_ctx.error_severity;
 		struct ras_cper_guid section_type;
 
-		memcpy(&section_type, &trace_arr[i].boot_err_ctx.section_type,
-		       min(sizeof(section_type), sizeof(trace_arr[i].boot_err_ctx.section_type)));
+		memcpy(&section_type, &trace_arr[i].body.boot_err_ctx.section_type,
+			min(sizeof(section_type),
+			    sizeof(trace_arr[i].body.boot_err_ctx.section_type)));
 
 		fill_section_hdr(ras_core, &record->hdr, RAS_CPER_TYPE_BOOT, severity,
 				 &trace_arr[i]);
@@ -351,7 +360,7 @@ int ras_cper_generate_cper(struct ras_core_context *ras_core,
 		struct aca_bank_reg bank = { 0 };
 
 		/* MCE is encoded as 1 record each */
-		memcpy(&bank.regs, &trace_list[0].aca_reg.regs, sizeof(bank.regs));
+		memcpy(&bank.regs, &trace_list[0].body.aca_reg.regs, sizeof(bank.regs));
 		trace_list[0].event = cper_mce_parse_err_type(ras_core, &bank);
 	}
 
diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_sys.c b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_sys.c
index b9ecb7d966b41..a45fb22f7462f 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_sys.c
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_sys.c
@@ -136,7 +136,7 @@ static int amdgpu_ras_sys_event_notifier(struct ras_core_context *ras_core,
 		ret = amdgpu_dpm_send_hbm_bad_channel_flag(ras_core->dev, *(uint32_t *)data);
 		break;
 	case RAS_EVENT_ID__DEVICE_RMA:
-		ras_log_ring_add_log_event(ras_core, RAS_LOG_EVENT_RMA, NULL, NULL);
+		ras_log_ring_add_log_event(ras_core, RAS_LOG_EVENT_RMA, NULL, 0, NULL);
 		if (!ras_fw_eeprom_supported(ras_core))
 			ret = amdgpu_dpm_send_rma_reason(ras_core->dev);
 		break;
-- 
2.55.0

