Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D27A2C98321
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Sep 2026 18:46:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2CC8910F734;
	Thu, 24 Sep 2026 18:46:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GKExFqqp";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010034.outbound.protection.outlook.com
 [52.101.193.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E136010F73A
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Sep 2026 18:46:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iiQO2wYOhjoLw48xB3iMZU5M37uB5p1wq4HISWHON8raQFrXBF/oLpLeQQLquvrjdneHpnV0BIVGBwG7bttjHX1l0si1c47bDXECvYFs9jFFgaVoKnOUeklVOpVbhQIyhoN5EfxZSKAbqtotYAFd5zZUQeNHCQfJGMNV4cEYMd9tVJd3R3DIQO4OB0DGx4Vfhv42vd4uA71P/yVNvOftpLnJgGTdVfsWe4/9SMCIuaiKavD963ZQ4jDUv70jx87ss41vUNYdL3c64bDIIFFpMSzBNjfQ41UHZFEu/cG9xiKNYpr/XwZjqHIWkcIE85FVl9KvfFycutkboOw8WvN1BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uWZoOPZ44bvIB0jYhBqaBJ66296WfeirulEDYXdIc+M=;
 b=adKUwwpxz51ziNxvjynQFHBYy26VnlBdqwxq5HSwF3ObaslamFpoX4gghMngYYfwwgFXikVxjVkS7CRs45Ore+RAr0Ksjb9Nkv1dA7Gfk/jUYlYXM6/4peJWfGTFwB5qvwWsoenMwJf2wRN9xUek5syIcnsQxGKsY27BcQzNwSdOvu2Dz6TZTVeZ/H84O67OFDtNNKjUbkU30G0ClbzOQiJ+stx78gnn4gozNw+8kblv1Q2ETUM8uS4p+0V2orOMG+ZeweOWB0mwlpE/VRFBO7Wy2UhX35Zix+8cthkTYXCI3/65by9GV9jF3Ga2uJB+Ivf1fxwTe3rIYlzwdigMlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uWZoOPZ44bvIB0jYhBqaBJ66296WfeirulEDYXdIc+M=;
 b=GKExFqqpbZhBA8A287ZxzB9yOfnlPy/woOY/dnWiZ9Dsp1rNQd/PzCnJVerAOSAacgePD1xeQ1OBI0cm6mlLTcFW5q/vTKulUwDEnj+IaEBSrDBvXJvZmvVDmxs9luVP3tXJme5Wn4wz6656dYzboYUUxTwAtg1I047lmYG8N+8=
Received: from PH8P221CA0044.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:346::22)
 by CH3PR12MB9342.namprd12.prod.outlook.com (2603:10b6:610:1cb::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Thu, 24 Sep
 2026 18:46:44 +0000
Received: from SJ1PEPF00002310.namprd03.prod.outlook.com
 (2603:10b6:510:346:cafe::c) by PH8P221CA0044.outlook.office365.com
 (2603:10b6:510:346::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.18 via Frontend Transport; Thu,
 24 Sep 2026 18:46:44 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002310.mail.protection.outlook.com (10.167.242.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Thu, 24 Sep 2026 18:46:44 +0000
Received: from jzuo.laptop (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 24 Sep
 2026 13:46:25 -0500
From: Fangzhi Zuo <jerry.zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Clay King <clayking@amd.com>, Dillon Varone
 <dillon.varone@amd.com>
Subject: [PATCH 33/34] drm/amd/display: adjust floating point format for gamut
 remap when needed
Date: Thu, 24 Sep 2026 14:45:46 -0400
Message-ID: <20260924184824.596894-34-jerry.zuo@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260924184824.596894-1-jerry.zuo@amd.com>
References: <20260924184824.596894-1-jerry.zuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002310:EE_|CH3PR12MB9342:EE_
X-MS-Office365-Filtering-Correlation-Id: 88321b1a-5707-4ec4-4f12-08df1a6c2e2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|23010399003|36860700016|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: PiJoYQ8VWxx8Ubyw9MSfx20J2QIiFYu0fw9ET+K8sN5AR+XEir6rAN12VUOrKjj83l8mZpALqKVyMXkqwbVqspvRY+r6WPAshtRESINyamqwtNQGzi+Uk6Q1inRYNeiHzYImAFtWtZXRld5TNntM/+E78N4Qs6CWwvKBn50Wh7C6MD8g8/Qa5BEisQ9NYkUgJ2s7qFZDkughhRdNhqGj3nwCpoO25nBQfPJynWwNXBVT8jqSZ3vo+HtP/mDJVYknfB6Rq7rHP1g7SyiVTeeG7WeSEj80Ym2dczAQR366Mp01PRNIMo1ayRvW082s7XJDbqrKvbGJF9fRgnfkv4hvGm2WAJOY2cGxgT9qbiqjia4rnoQTzfHs+zb6zfaEzLN+RNjI89QI0JWjKB9FxNS4Ls2sl6kZWbJ0PH/papyr5ebVziO+5vAdo23FKIZw3F/MpNc+9nVNSos5mGYXHHJr1v/LiLGBGZ6C40L8BKv6TgYwutbkLJMqflW6DWEFvBWthYJTikoWjxHrAiWlMiSYzrhKhnQ6L4ow3eQWHhWHsYOy39hBTNTz9RKPqstHm5LUYap4d8PSdDFuipEHxGzS1FiCXC6wqUbzMDtPRLUknl2J7iOvvLMjw1GRm0aCGUL0Mx1dYJ5uHaa2yjLd4AFEyOadlZji+aqYdgJoYcAX1PQ/qUDI3LgDW23wJoTSjtoJDecSOqWTx6bN4G44KWqfKg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(23010399003)(36860700016)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: sxfnxHJhdNdNsYtg0i6/QiHf9jvXQivo9eKFx9oEwuNt3Xs08GFKS2SaZIfLjh/MOgybeeSWXgYBMKxHETr6qUyN0C8x9lKqyDEbj4+OX2wLPAN+KZlAxAwyE8BJcpciW9RmKl13UWdruNaxgrn90O1vaqJzeF0K51S3LAkyK9ly7fgHc08fqftKVG2VuBTF6+ZHj9bhucX97IKs0dVDlE+r/kRHvPDSENZrrjU4Lzg7HALdeWkCJ20232zu0NC37qIqrsLMz4Dpja2gnxvoRdbYNrG6dXUTaPWUA3VN7+p9c94K/YHtTRh9n7/2XbtY8e7e38eVKwRp89Y7Vcsh0ukZJ807xczOx/Ub647hdh3yMwMN/MYmGMvl8BaNK/NrtQ8nty/f2qq/6u2elAdajVTWY62WOjGXYc5BoOviEZDi88l/KvMIMoxq4B1bob2K
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 18:46:44.2216 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 88321b1a-5707-4ec4-4f12-08df1a6c2e2f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002310.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9342
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

From: Clay King <clayking@amd.com>

[Why]
The MPCCs different gamut remap matrices allow for S2D13 and S3D12 floating
point formats, but only S2D13 is used. There may be cases where
more integer bits are required.

[How]
Switch to S3D12 if any entries in the remap matrix cannot fit in S2D13.
Otherwise, prefer the extra precision of S2D13. Communicate the max value
that hw can support to dm via dc color caps.

Signed-off-by: Clay King <clayking@amd.com>
Signed-off-by: Fangzhi Zuo <jerry.zuo@amd.com>
Reviewed-by: Dillon Varone <dillon.varone@amd.com>
---
 .../dc/gpio/dcn42/hw_translate_dcn42.c.orig   | 206 ------------------
 .../dc/resource/dcn60/dcn60_resource.c        |   2 +
 2 files changed, 2 insertions(+), 206 deletions(-)
 delete mode 100644 drivers/gpu/drm/amd/display/dc/gpio/dcn42/hw_translate_dcn42.c.orig

diff --git a/drivers/gpu/drm/amd/display/dc/gpio/dcn42/hw_translate_dcn42.c.orig b/drivers/gpu/drm/amd/display/dc/gpio/dcn42/hw_translate_dcn42.c.orig
deleted file mode 100644
index e7e1d9979876..000000000000
--- a/drivers/gpu/drm/amd/display/dc/gpio/dcn42/hw_translate_dcn42.c.orig
+++ /dev/null
@@ -1,206 +0,0 @@
-// SPDX-License-Identifier: MIT
-//
-// Copyright 2026 Advanced Micro Devices, Inc.
-
-#include "hw_translate_dcn42.h"
-
-#include "dm_services.h"
-#include "include/gpio_types.h"
-#include "../hw_translate.h"
-
-
-#include "dcn/dcn_4_2_0_offset.h"
-#include "dcn/dcn_4_2_0_sh_mask.h"
-#include "dpcs/dpcs_4_0_0_offset.h"
-#include "dpcs/dpcs_4_0_0_sh_mask.h"
-
-#define DCN_BASE__INST0_SEG2                       0x000034C0
-
-/* begin *********************
- * macros to expend register list macro defined in HW object header file */
-
-/* DCN */
-#define block HPD
-#define reg_num 0
-
-#undef BASE_INNER
-#define BASE_INNER(seg) DCN_BASE__INST0_SEG ## seg
-
-#define BASE(seg) BASE_INNER(seg)
-
-#undef REG
-#define REG(reg_name)\
-		(BASE(reg ## reg_name ## _BASE_IDX) + reg ## reg_name)
-#define SF_HPD(reg_name, field_name, post_fix)\
-	.field_name = reg_name ## __ ## field_name ## post_fix
-
-
-/* macros to expend register list macro defined in HW object header file
- * end *********************/
-
-
-static bool offset_to_id(
-	uint32_t offset,
-	uint32_t mask,
-	enum gpio_id *id,
-	uint32_t *en)
-{
-	(void)mask;
-	switch (offset) {
-	/* HPD */
-	case REG(HPD0_DC_HPD_INT_STATUS):
-		*id = GPIO_ID_HPD;
-		*en = GPIO_HPD_1;
-		return true;
-	case REG(HPD1_DC_HPD_INT_STATUS):
-		*id = GPIO_ID_HPD;
-		*en = GPIO_HPD_2;
-		return true;
-	case REG(HPD2_DC_HPD_INT_STATUS):
-		*id = GPIO_ID_HPD;
-		*en = GPIO_HPD_3;
-		return true;
-	case REG(HPD3_DC_HPD_INT_STATUS):
-		*id = GPIO_ID_HPD;
-		*en = GPIO_HPD_4;
-		return true;
-	case REG(HPD4_DC_HPD_INT_STATUS):
-		*id = GPIO_ID_HPD;
-		*en = GPIO_HPD_5;
-		return true;
-	/* DDC */
-	/* we don't care about the GPIO_ID for DDC
-	 * in DdcHandle it will use GPIO_ID_DDC_DATA/GPIO_ID_DDC_CLOCK
-	 * directly in the create method
-	 */
-	case REG(DC_GPIO_DDC1_A):
-		*en = GPIO_DDC_LINE_DDC1;
-		return true;
-	case REG(DC_GPIO_DDC2_A):
-		*en = GPIO_DDC_LINE_DDC2;
-		return true;
-	case REG(DC_GPIO_DDC3_A):
-		*en = GPIO_DDC_LINE_DDC3;
-		return true;
-	case REG(DC_GPIO_DDC4_A):
-		*en = GPIO_DDC_LINE_DDC4;
-		return true;
-	case REG(DC_GPIO_DDC5_A):
-		*en = GPIO_DDC_LINE_DDC5;
-		return true;
-	case REG(DC_GPIO_DDCVGA_A):
-		*en = GPIO_DDC_LINE_DDC_VGA;
-		return true;
-	default:
-		ASSERT_CRITICAL(false);
-		return false;
-	}
-}
-
-
-static bool id_to_offset(
-	enum gpio_id id,
-	uint32_t en,
-	struct gpio_pin_info *info)
-{
-	bool result = true;
-
-	switch (id) {
-	case GPIO_ID_DDC_DATA:
-		info->mask = DC_GPIO_DDC1_A__DC_GPIO_DDC1DATA_A_MASK;
-		switch (en) {
-		case GPIO_DDC_LINE_DDC1:
-			info->offset = REG(DC_GPIO_DDC1_A);
-		break;
-		case GPIO_DDC_LINE_DDC2:
-			info->offset = REG(DC_GPIO_DDC2_A);
-		break;
-		case GPIO_DDC_LINE_DDC3:
-			info->offset = REG(DC_GPIO_DDC3_A);
-		break;
-		case GPIO_DDC_LINE_DDC4:
-			info->offset = REG(DC_GPIO_DDC4_A);
-		break;
-		case GPIO_DDC_LINE_DDC5:
-			info->offset = REG(DC_GPIO_DDC5_A);
-		break;
-		case GPIO_DDC_LINE_DDC_VGA:
-			info->offset = REG(DC_GPIO_DDCVGA_A);
-		break;
-		case GPIO_DDC_LINE_I2C_PAD:
-		default:
-			ASSERT_CRITICAL(false);
-			result = false;
-		}
-	break;
-	case GPIO_ID_DDC_CLOCK:
-		info->mask = DC_GPIO_DDC1_A__DC_GPIO_DDC1CLK_A_MASK;
-		switch (en) {
-		case GPIO_DDC_LINE_DDC1:
-			info->offset = REG(DC_GPIO_DDC1_A);
-		break;
-		case GPIO_DDC_LINE_DDC2:
-			info->offset = REG(DC_GPIO_DDC2_A);
-		break;
-		case GPIO_DDC_LINE_DDC3:
-			info->offset = REG(DC_GPIO_DDC3_A);
-		break;
-		case GPIO_DDC_LINE_DDC4:
-			info->offset = REG(DC_GPIO_DDC4_A);
-		break;
-		case GPIO_DDC_LINE_DDC5:
-			info->offset = REG(DC_GPIO_DDC5_A);
-		break;
-		case GPIO_DDC_LINE_DDC_VGA:
-			info->offset = REG(DC_GPIO_DDCVGA_A);
-		break;
-		case GPIO_DDC_LINE_I2C_PAD:
-		default:
-			ASSERT_CRITICAL(false);
-			result = false;
-		}
-	break;
-	case GPIO_ID_SYNC:
-	case GPIO_ID_VIP_PAD:
-	default:
-		ASSERT_CRITICAL(false);
-		result = false;
-	}
-
-	if (result) {
-		info->offset_y = info->offset + 2;
-		info->offset_en = info->offset + 1;
-		info->offset_mask = info->offset - 1;
-
-		info->mask_y = info->mask;
-		info->mask_en = info->mask;
-		info->mask_mask = info->mask;
-	}
-
-	return result;
-}
-
-
-/* function table */
-static const struct hw_translate_funcs funcs = {
-	.offset_to_id = offset_to_id,
-	.id_to_offset = id_to_offset,
-};
-
-
-/*
- * dal_hw_translate_dcn42_init
- *
- * @brief
- * Initialize Hw translate function pointers.
- *
- * @param
- * struct hw_translate *tr - [out] struct of function pointers
- *
- */
-void dal_hw_translate_dcn42_init(struct hw_translate *tr)
-{
-	tr->funcs = &funcs;
-}
-
-
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn60/dcn60_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn60/dcn60_resource.c
index 4e043343a819..3b70e97c0a6a 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn60/dcn60_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn60/dcn60_resource.c
@@ -12,6 +12,7 @@
 
 #include "resource.h"
 #include "include/irq_service_interface.h"
+#include "basics/conversion.h"
 
 #include "dcn20/dcn20_resource.h"
 #include "dcn30/dcn30_resource.h"
@@ -2100,6 +2101,7 @@ static bool dcn60_resource_construct(
 	dc->caps.color.mpc.ogam_rom_caps.hlg = 0;
 	dc->caps.color.mpc.ocsc = 1;
 	dc->caps.color.mpc.preblend = true;
+	dc->caps.color.mpc.max_gamut_remap_coeff = dc_fixpt_from_fraction(S3D12_MAX, DIVIDER);
 	/* HACK: Force FRL support until BIOS is ready. */
 	dc->config.force_hdmi21_frl_enc_enable = true;
 	dc->config.use_spl = true;
-- 
2.53.0

