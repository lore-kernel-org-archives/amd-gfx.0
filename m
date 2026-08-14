Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F170C5CFC1
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Aug 2026 21:04:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E6A1910F744;
	Fri, 14 Aug 2026 21:04:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rAK3bJRi";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012068.outbound.protection.outlook.com [52.101.48.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C90B610F73E
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Aug 2026 21:04:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sQjynHDAievmBBNtjyQbDbZZecVsBbmsvS5bKK19cNFrdbwT07nrSsmtb+txi6ykmShpOpy6yXUiDTW+JgqsLzZQk8TLtbuMJKyRSxsizDKZPnn32iU7PiBneoLB/dRE+HhWqabt63i+3p0dsYarZtE+hyzUehFz8DZswREd8Sy2zOAIMbnnt8rOXhaEau6vni6aJSkIawGLbyEe1T1SshygbHLHU+ytByiHfLmU2mjMx7QjxHRkhVt/W0ypqH4dRVASZiNs7YeSV0kpF+Ifv4gP1IoTia545WbiDnkmTiDuJx9BLpPn/jDpfQMiISR3mGBuT2UdDvxcS7ELVD4TPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M7hfuKQxFPaJfBku4wRNV9r5d91uB9NSUljJoOSD3xY=;
 b=cP0IUY/nMhd4A1dTLX76vTjHFEyTikseCAWthdeK3l8W4xCJBmy5sSsNfcng3EUbeJXwwCtRa6pqE58iCRFAHCaAbVLXTIVKjKZv+TA4xt5+aEdVPPdxM0adhA3zlEM2cjqcr3rPnCTuSxHOIOPaVZbwkZS3CJiBJBQqWYtn98M3Vgk6NanHOadAkpEVRPq8nkAfUSPVuNM5pGSDGriqEqEj9MH9UU2lrAw/mENNoJu4GyMXaKC3I+vZrtwag6DDm1Fsm5XSAHiLE1ahEyR7ALIz7gUiTMNXCdUH2KsCUR6I7FnYF0gGLRc4B5URqcmCxeuQtuWDFcvHEQXUj7mtkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M7hfuKQxFPaJfBku4wRNV9r5d91uB9NSUljJoOSD3xY=;
 b=rAK3bJRiFKybJb6wd206i85XBM0Bc+gG6UaE9xkA8OSBDtFe8IYNtj4tJe0picgKNFUSj7S5OB2lgzKJE47d6AEbOQLNVEG/X/vPh119dgKGuRtjva+TOGRqsbiZ5/GYOq00xyJ1y0xu3v71Hisz7c7J/c6ZtfUdw9+xQxKBMC0=
Received: from CH0PR04CA0012.namprd04.prod.outlook.com (2603:10b6:610:76::17)
 by CY8PR12MB7635.namprd12.prod.outlook.com (2603:10b6:930:9e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.16; Fri, 14 Aug
 2026 21:04:00 +0000
Received: from CH3PEPF00000016.namprd21.prod.outlook.com
 (2603:10b6:610:76:cafe::7a) by CH0PR04CA0012.outlook.office365.com
 (2603:10b6:610:76::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.16 via Frontend Transport; Fri,
 14 Aug 2026 21:04:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF00000016.mail.protection.outlook.com (10.167.244.121) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.0 via Frontend Transport; Fri, 14 Aug 2026 21:04:00 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 14 Aug
 2026 16:03:58 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 14 Aug 2026 16:03:58 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Xiang Liu <xiang.liu@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 103/109] drm/amd/ras: generate AMD crashdump CPER records
Date: Fri, 14 Aug 2026 17:02:40 -0400
Message-ID: <20260814210246.3067612-104-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260814210246.3067612-1-alexander.deucher@amd.com>
References: <20260814210246.3067612-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000016:EE_|CY8PR12MB7635:EE_
X-MS-Office365-Filtering-Correlation-Id: 231d62e0-179f-4a84-5ef1-08defa47902c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|23010399003|82310400026|376014|56012099006|10067099003|3023799007|6133799003|18002099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info: tzM78Bsn8Fc8SG6DgO/aEH528YvbOXsyP0dYZUWHDqeLc9JeZmyoEGmLy67HUMyCACmmFSBUGTM11ePBeuWf1C3dQUh/Q2YlxGqC/A6TwYAlofwNstpSO0JWvFczBw1jJrPPTLcOpAYa2PhbECz65IGz7Kizrthjg6YP/dHvEEcm3gM+2LXTNnInY+hY0aUQuLrXg7sFCrVbUGTtYaDr9QMI/yXTg6sEvzyC9fsxIhrvPgPAbRcwfZJp6ZPB0b2dgzqu0WiHrG475lGSrXje9PM9O2TIlyJFqGEUPI5DVfup1u7fWUYdIwV9k+r/t4cIBhkjuWqz9x1OB6cS9aJLNAWHDf64HshHyc3zuCs4d7GAAy+hHc0bp0g/9rf4nAGK6rs/kXMGDO7ecq37lscMa7cQrea6eGJCg3+e5u8jlIm2G2YBl+dtM/4a+QoqKfx11k4ufrfIL18beHKfgLcyFtatulzlM1cH26OIfGR345sCQrbMzohtC5zKES97W2TKmTlHgi9n66KfpgR5x36TEYhalxpBUr7+KBulaKqq1hBktGqPuL2X3bU/XOBtRgSMPfeC1MPpeyfzRDcEEDlB+LTj4IzuMQx9+mH4RvzKbgXDIyzsZbDsvIvapOJ7fnV1sFwfoBKrWaTM2V2ctnXhPD3euUJUn7K0VVKxVku4IWY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(23010399003)(82310400026)(376014)(56012099006)(10067099003)(3023799007)(6133799003)(18002099003)(22082099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: fbCuMXqImwiGh9mY1qRhMoupfyw/PN+Suo1+Ig3gq5m6eEzkzY00wmKh/EerokpcVuXqaKyfTqCug5VC3ktU0/gXdbuiD3JUmxCE+jg2wKvR/2rvTtvcceDUehezgVQNA2C6LyH/oxuMFjzmZkds8g9Zx2YwYuUcLer+Tv4hzNCiSTbbJNXRJokAfKU2sM7KhGXK4cO9cevOVAo8LbWKEqmI1eIxIe8aTYubfTnLe4ztN4Pj9xFZ28AWD9/I7rIxCLllXQsfsNs0Xmx23qm6iGF4naANhumr/zWetfJfk6uFzKbCJ6Ykh2TKf3cv2U7ugVVP/YR+q0TPEft30H3YAZxTzDxikmM/8kIPx59LrtHuqr140ts224awC0P6xwyO2m9/u9gGNLoM6tERQkEvfV41d2qbIsUIrfNZxErmBnFoPbRxHTpf173meY5LS7MK
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 21:04:00.1351 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 231d62e0-179f-4a84-5ef1-08defa47902c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000016.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7635
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

Populate the AMD crashdump common header and error information before
serializing fatal and boot records.

Validate that batched boot records share a section type, clamp the
register context to the crashdump payload, and account for each record
header when sizing the output.

Keep AMD record dispatch in a dedicated helper so processor and
Platform Memory generation can be added independently.

Signed-off-by: Xiang Liu <xiang.liu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/ras/core/ras_cper.c | 26 ++++++++++++++++++++++---
 1 file changed, 23 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/ras/core/ras_cper.c b/drivers/gpu/drm/amd/ras/core/ras_cper.c
index 03240715b4aaf..eee4e0373c3bd 100644
--- a/drivers/gpu/drm/amd/ras/core/ras_cper.c
+++ b/drivers/gpu/drm/amd/ras/core/ras_cper.c
@@ -113,6 +113,9 @@ static int fill_section_fatal(struct ras_core_context *ras_core, void *section,
 {
 	struct cper_section_fatal *fatal = section;
 
+	fatal->hdr.valid_bits = CPER_AMD_ERR_INFO_COUNT(1) |
+		CPER_AMD_CONTEXT_COUNT(1);
+	fatal->error_info.error_type = GPU__NONSTANDARD_ERROR;
 	fatal->data.reg_ctx_type = CPER_CTX_TYPE__CRASH;
 	fatal->data.reg_arr_size = sizeof(fatal->data.reg);
 
@@ -167,11 +170,15 @@ static int fill_section_boot(struct ras_core_context *ras_core, void *section,
 	struct cper_section_boot *boot = section;
 	struct ras_boot_err_ctx *ctx = &log->body.boot_err_ctx;
 	struct crashdump_boot *data = &boot->data;
+	u16 data_size;
 
+	boot->hdr.valid_bits = CPER_AMD_ERR_INFO_COUNT(1) |
+		CPER_AMD_CONTEXT_COUNT(1);
+	boot->error_info.error_type = GPU__NONSTANDARD_ERROR;
 	data->reg_ctx_type = ctx->reg_ctx_type;
-	data->reg_arr_size = ctx->reg_arr_size;
-	memcpy(data->msg, ctx->regs,
-		min(boot->data.reg_arr_size, sizeof(data->msg)));
+	data_size = min_t(u16, ctx->reg_arr_size, sizeof(data->msg));
+	data->reg_arr_size = data_size;
+	memcpy(data->msg, ctx->regs, data_size);
 
 	return 0;
 }
@@ -327,10 +334,23 @@ int ras_cper_generate_batch_cper(struct ras_core_context *ras_core,
 
 		/* MCE is encoded as 1 record each */
 		memcpy(&bank.regs, &batch_logs[0].body.aca_reg.regs, sizeof(bank.regs));
+		bank.ecc_type = RAS_ERR_TYPE__MCE;
 		event = cper_mce_parse_err_type(ras_core, &bank);
 		batch_logs[0].event = event;
 	}
 
+	if (event == RAS_LOG_EVENT_BOOT) {
+		uint32_t i;
+
+		for (i = 1; i < nr_batch_logs; i++) {
+			if (batch_logs[i].event != RAS_LOG_EVENT_BOOT ||
+			    memcmp(batch_logs[i].body.boot_err_ctx.section_type,
+				   batch_logs[0].body.boot_err_ctx.section_type,
+				   CPER_UUID_MAX_SIZE))
+				return -EINVAL;
+		}
+	}
+
 	mutex_lock(&cper->profile_mutex);
 	/* All the batch logs share the same event */
 	ret = ras_cper_get_profile(ras_core, event, &profile);
-- 
2.55.0

