Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A705FF513EE
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Mar 2026 03:27:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C47410E30B;
	Fri,  6 Mar 2026 03:27:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5UkLpio7";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011032.outbound.protection.outlook.com [52.101.62.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 157FA10E30B
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Mar 2026 03:27:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Uwwy8kbEsnINyhND562yUm7Mjy3qrM8n9HwrngkUnc+ZHT2qexb/4IpuRm0WOddQr9WKRXC51rA4VNoduQOIDw/B4hefpJNt1seN7oK6y7OT6j6XurfWQT+YBNFrivi93Fd7u8O/c9GloK0Ksra+mKbyvFhXv+1FMmGYVjmqznahaKV8eRXUZrRiriSpbu5XocWI0kIWwnX1KkNtu6ZqzBIaiZUCy3zhkV5K4NeOvOr6dDqXlpVJc22yG7L1ibJb3o0Bn/BYo4M+EdDbJGUr3UM6OX0yQD7Ql7X2Ox6YlER2/REVD8545oAoxxIjteCxghevy1ddgudrFaGvP8IqZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6WNjC7tDKX/NSkc9tdnm2HyOv60p81T5b93UFu88NoM=;
 b=XMbAinkdmAbrtvDtJ1RDsFDc7Kl17/q0OFHfBwR2cwCKNU8/EVmKBOJF1GNqXEJ6lkWaA9evxpR7rT+h5MKHBhpJngC5/cUY1cvo2qaXJVIc6Hsrb4nBlC/5unODwybhfaCYiYI8XtaAVogcGz0E3DAy6WYQpzU/Cjm8z9kbMMWs+PZ2P0qx8OfklCPO3XEp6g0OLuqF49sdxU7JDm+a8/cpz3z5LTnMdjF3fagOJ2U1u2f8FGsMPrGDxu8vj97mdMTSPabLyhVKf0aNW3IzMJJNgAZ+dXoXr6N+vtqo0G5RBW3ztyhCQSi1GyEsfybRKuMnngp4S/Vv118BoQKtTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6WNjC7tDKX/NSkc9tdnm2HyOv60p81T5b93UFu88NoM=;
 b=5UkLpio78UYQ3jeIVu7F8LdyRZiDbyuVAw61HAUHP+0dFhALyU7Y36DEq3ft2ieChC0iKzJn0SWNGdfyFrO9j/v3J36KpDMrFBzi/GqibQr85tijyY7lT2tPEtIogsMI1OQJjOhSagHLeF5ryPJIMPfo+7JL5V3op/OSsSd/a6U=
Received: from BLAPR03CA0008.namprd03.prod.outlook.com (2603:10b6:208:32b::13)
 by DS0PR12MB6605.namprd12.prod.outlook.com (2603:10b6:8:d3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.5; Fri, 6 Mar
 2026 03:27:35 +0000
Received: from BL6PEPF0001AB4D.namprd04.prod.outlook.com
 (2603:10b6:208:32b:cafe::73) by BLAPR03CA0008.outlook.office365.com
 (2603:10b6:208:32b::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.18 via Frontend Transport; Fri,
 6 Mar 2026 03:27:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB4D.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Fri, 6 Mar 2026 03:27:35 +0000
Received: from kylin.lan (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 5 Mar
 2026 21:27:33 -0600
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Roman Li <Roman.Li@amd.com>
Subject: [PATCH 17/21] drm/amd/display: Enable dcn42 DC clk_mgr
Date: Thu, 5 Mar 2026 20:13:43 -0700
Message-ID: <20260306031932.136179-18-alex.hung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260306031932.136179-1-alex.hung@amd.com>
References: <20260306031932.136179-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4D:EE_|DS0PR12MB6605:EE_
X-MS-Office365-Filtering-Correlation-Id: 01f778be-995b-4614-c48c-08de7b304f78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700016; 
X-Microsoft-Antispam-Message-Info: ELLJXlG4eUiCKcSO+o+54X62F9/VMSN3Dfe9x+0XzqgMHYuJoYNFWvWOIAYnBeIC1hHiymgp6r3H0MElm6Z0YD6isR8HJZYij9NUaAldiPfMGo4iXM5TNDil+GlqDM37CHvd4sfucC5zTIKKvHC5BT1FcOfJZShC1olUbJEsTL4vj2AzQmHlDYvy949u1pNY1klUreGYVzKSMRkb+GUlhDRs5BoABZD+stBe9LvA58z7hWBtzV5CDPmtj6GioqGn9r1ET2mwpSkmd9MVQnzc5bPjf8jfZQ6kklYt/EIXWtnq2WqWDpg0wRlEFPOvovsm/1H2a7SnENot1U3ElORN5+ARV3iSzr4laC6E8Yv2/YGw+qJjDA2UJsdGPjzskhPRG7wD9YR1ZYylAJKhEy2xNnJTsY9a+Bg3nXyVQkZQ/feQf2apgzzZiwqNbaSrrDRNxYv8WrB9TF2nBb40HZZyviYUeVYjA4JIdHMwReVWOoHO3AFz20cdJMjsFAzqKZehomB1ZDt3gKXxSlz3ZWjnWN3I/Q9HBPs9hs3/s0I5LzppqY3eMen0SRKsvsO42QKNgPTwtOQWLN1bZ4r/qwzVpY96BniNj7kcqUMRZA6k/jjoIbNscLI0KYvw0qu/Z4gCe0ig8HYyHeUZAehX93ex9EXUTnISg7V/Ng7MQI7RVl+elhjUxADctZn+XG/Z7QaKQjhAq/5PniRBxtEIHT5bZZo6d2npusRcaQWooy8vZ3snXSp5gJAhPjfeQG7n0YUn2M2/ryswhYGOBs0/6kN6jQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 8H8Rd3ekUn0nWiUtvGI9xmp86JkqUEU0zR0BBTe7nwao5WjU4+Es5RE+aCp32upj/4dbydslfeFiFInfBH+fuHvT92rO9iZ2RfUq4cIsq/aO+3qWou1tB5PyI7i1+UPfq/pYs1nRmgb7H+jGnOe+TQh/VcyOXQU2vT/IF8/Scnt07BkuxmX9B/uPS2YAkBV85xqzE6xML/Cd/ZPrsPXzqeybFfqGHqXPFLHVlQM4iOlABtGJmIRG8bJ8thJUUzJ4XNILHEUgExr3+XGoyXiZnRIdcQOj6SCedYPlUxUbuH5k4QoUrtALAeVl2BRNnFz0pGoIMRtA80ZUkLA10wsHFDY61YMxPTZ7GtARrwtNB821K2XtkLEdWrLqtKOOBwNpvOI8GW7bND3PrduPxqmoyU9ezXsVu2S1Uq0pg4vCEQ77Unc6HTf0QXi6DBB48OXE
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 03:27:35.4710 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 01f778be-995b-4614-c48c-08de7b304f78
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6605
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

From: Roman Li <Roman.Li@amd.com>

Add support for DCN 4.2 clock manager.

Signed-off-by: Roman Li <Roman.Li@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 .../gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c  |  16 +
 .../display/dc/clk_mgr/dcn42/dcn42_clk_mgr.c  | 236 ++++++------
 drivers/gpu/drm/amd/display/dc/core/dc.c      |   1 +
 .../gpu/drm/amd/display/dc/dc_spl_translate.c |   1 +
 .../amd/display/dc/dccg/dcn20/dcn20_dccg.h    |   3 +-
 .../amd/display/dc/dccg/dcn42/dcn42_dccg.c    |  59 ++-
 .../amd/display/dc/dccg/dcn42/dcn42_dccg.h    |  11 +-
 .../dml21/inc/bounding_boxes/dcn42_soc_bb.h   | 359 ++++++++++++++++++
 .../gpu/drm/amd/display/dc/inc/hw/clk_mgr.h   |   2 +-
 .../amd/display/dc/inc/hw/clk_mgr_internal.h  |  73 +++-
 .../link/protocols/link_edp_panel_control.c   |   1 +
 .../display/dc/soc_and_ip_translator/Makefile |   3 +
 .../dcn42/dcn42_soc_and_ip_translator.c       | 159 +++++++-
 .../dcn42/dcn42_soc_and_ip_translator.h       |   1 +
 .../soc_and_ip_translator.c                   |   4 +
 .../include/asic_reg/clk/clk_15_0_0_offset.h  |  44 +++
 .../include/asic_reg/clk/clk_15_0_0_sh_mask.h |  52 +++
 17 files changed, 885 insertions(+), 140 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/bounding_boxes/dcn42_soc_bb.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/clk/clk_15_0_0_offset.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/clk/clk_15_0_0_sh_mask.h

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
index de016ea407b6..a75d76d9f740 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
@@ -48,6 +48,7 @@
 #include "dcn32/dcn32_clk_mgr.h"
 #include "dcn35/dcn35_clk_mgr.h"
 #include "dcn401/dcn401_clk_mgr.h"
+#include "dcn42/dcn42_clk_mgr.h"
 
 int clk_mgr_helper_get_active_display_cnt(
 		struct dc *dc,
@@ -362,6 +363,18 @@ struct clk_mgr *dc_clk_mgr_create(struct dc_context *ctx, struct pp_smu_funcs *p
 		return &clk_mgr->base;
 	}
 	break;
+	case AMDGPU_FAMILY_GC_11_5_4: {
+		struct clk_mgr_dcn42 *clk_mgr = kzalloc(sizeof(*clk_mgr), GFP_KERNEL);
+
+		if (clk_mgr == NULL) {
+			BREAK_TO_DEBUGGER();
+			return NULL;
+		}
+
+		dcn42_clk_mgr_construct(ctx, clk_mgr, pp_smu, dccg);
+		return &clk_mgr->base.base;
+	}
+	break;
 #endif	/* CONFIG_DRM_AMD_DC_FP */
 	default:
 		ASSERT(0); /* Unknown Asic */
@@ -419,6 +432,9 @@ void dc_destroy_clk_mgr(struct clk_mgr *clk_mgr_base)
 	case AMDGPU_FAMILY_GC_12_0_0:
 		dcn401_clk_mgr_destroy(clk_mgr);
 		break;
+	case AMDGPU_FAMILY_GC_11_5_4:
+		dcn42_clk_mgr_destroy(clk_mgr);
+		break;
 
 	default:
 		break;
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn42/dcn42_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn42/dcn42_clk_mgr.c
index 55434f046fa2..cbb79789a532 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn42/dcn42_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn42/dcn42_clk_mgr.c
@@ -31,59 +31,19 @@
 #include "link_service.h"
 #include "logger_types.h"
 
+#include "clk/clk_15_0_0_offset.h"
+#include "clk/clk_15_0_0_sh_mask.h"
+#include "dcn/dcn_4_2_0_offset.h"
+#include "dcn/dcn_4_2_0_sh_mask.h"
+
 
 #undef DC_LOGGER
 #define DC_LOGGER \
-	clk_mgr->base.base.ctx->logger
-
-
-#define DCN_BASE__INST0_SEG1                       0x000000C0
-
-#define regCLK8_CLK2_BYPASS_CNTL			 0x4c2a
-#define regCLK8_CLK2_BYPASS_CNTL_BASE_IDX	0
-#define CLK8_CLK2_BYPASS_CNTL__CLK2_BYPASS_SEL__SHIFT	0x0
-#define CLK8_CLK2_BYPASS_CNTL__CLK2_BYPASS_DIV__SHIFT	0x10
-#define CLK8_CLK2_BYPASS_CNTL__CLK2_BYPASS_SEL_MASK		0x00000007L
-#define CLK8_CLK2_BYPASS_CNTL__CLK2_BYPASS_DIV_MASK		0x000F0000L
-
-#define regDENTIST_DISPCLK_CNTL 0x0064
-#define regDENTIST_DISPCLK_CNTL_BASE_IDX 1
-
-// DENTIST_DISPCLK_CNTL
-#define DENTIST_DISPCLK_CNTL__DENTIST_DISPCLK_WDIVIDER__SHIFT 0x0
-#define DENTIST_DISPCLK_CNTL__DENTIST_DISPCLK_RDIVIDER__SHIFT 0x8
-#define DENTIST_DISPCLK_CNTL__DENTIST_DISPCLK_CHG_DONE__SHIFT 0x13
-#define DENTIST_DISPCLK_CNTL__DENTIST_DPPCLK_CHG_DONE__SHIFT 0x14
-#define DENTIST_DISPCLK_CNTL__DENTIST_DPPCLK_WDIVIDER__SHIFT 0x18
-#define DENTIST_DISPCLK_CNTL__DENTIST_DISPCLK_WDIVIDER_MASK 0x0000007FL
-#define DENTIST_DISPCLK_CNTL__DENTIST_DISPCLK_RDIVIDER_MASK 0x00007F00L
-#define DENTIST_DISPCLK_CNTL__DENTIST_DISPCLK_CHG_DONE_MASK 0x00080000L
-#define DENTIST_DISPCLK_CNTL__DENTIST_DPPCLK_CHG_DONE_MASK 0x00100000L
-#define DENTIST_DISPCLK_CNTL__DENTIST_DPPCLK_WDIVIDER_MASK 0x7F000000L
-#define mmDENTIST_DISPCLK_CNTL 0x0124
-#define mmCLK8_CLK_TICK_CNT_CONFIG_REG                  0x1B851
-#define mmCLK8_CLK0_CURRENT_CNT                         0x1B853
-#define mmCLK8_CLK1_CURRENT_CNT                         0x1B854
-#define mmCLK8_CLK2_CURRENT_CNT                         0x1B855
-#define mmCLK8_CLK3_CURRENT_CNT                         0x1B856
-#define mmCLK8_CLK4_CURRENT_CNT                         0x1B857
-
-
-#define mmCLK8_CLK0_BYPASS_CNTL                         0x1B81A
-#define mmCLK8_CLK1_BYPASS_CNTL                         0x1B822
-#define mmCLK8_CLK2_BYPASS_CNTL                         0x1B82A
-#define mmCLK8_CLK3_BYPASS_CNTL                         0x1B832
-#define mmCLK8_CLK4_BYPASS_CNTL                         0x1B83A
-
-
-#define mmCLK8_CLK0_DS_CNTL                             0x1B814
-#define mmCLK8_CLK1_DS_CNTL                             0x1B81C
-#define mmCLK8_CLK2_DS_CNTL                             0x1B824
-#define mmCLK8_CLK3_DS_CNTL                             0x1B82C
-#define mmCLK8_CLK4_DS_CNTL                             0x1B834
-
-
+	dc_logger
+#define DC_LOGGER_INIT(logger) \
+	struct dal_logger *dc_logger = logger
 
+#define DCN42_CLKIP_REFCLK 48000
 
 #undef FN
 #define FN(reg_name, field_name) \
@@ -92,16 +52,25 @@
 #define REG(reg) \
 	(clk_mgr->regs->reg)
 
+// for DCN register access
+#define DCN_BASE__INST0_SEG0 0x00000012
+#define DCN_BASE__INST0_SEG1 0x000000C0
+
 #define BASE_INNER(seg) DCN_BASE__INST0_SEG ## seg
 
 #define BASE(seg) BASE_INNER(seg)
 
-#define SR(reg_name)\
-		.reg_name = BASE(reg ## reg_name ## _BASE_IDX) +  \
-					reg ## reg_name
+#define SR(reg_name) \
+	.reg_name = BASE(reg ## reg_name ## _BASE_IDX) + reg ## reg_name
+
+// for CLKIP register access
+#define CLK_BASE__INST0_SEG0 0x00016C00
 
-#define CLK_SR_DCN42(reg_name)\
-	.reg_name = mm ## reg_name
+#define CLK_BASE_INNER(seg) \
+	CLK_BASE__INST0_SEG ## seg
+
+#define CLK_SR_DCN42(reg_name) \
+	.reg_name = CLK_BASE(reg ## reg_name ## _BASE_IDX) + reg ## reg_name
 
 static const struct clk_mgr_registers clk_mgr_regs_dcn42 = {
 	CLK_REG_LIST_DCN42()
@@ -115,8 +84,6 @@ static const struct clk_mgr_mask clk_mgr_mask_dcn42 = {
 	CLK_COMMON_MASK_SH_LIST_DCN42(_MASK)
 };
 
-
-
 #define TO_CLK_MGR_DCN42(clk_mgr_int)\
 	container_of(clk_mgr_int, struct clk_mgr_dcn42, base)
 
@@ -154,6 +121,49 @@ int dcn42_get_active_display_cnt_wa(
 	return display_count;
 }
 
+static uint32_t dcn42_get_clock_freq_from_clkip(struct clk_mgr *clk_mgr_base, enum clock_type clock)
+{
+	struct clk_mgr_internal *clk_mgr = TO_CLK_MGR_INTERNAL(clk_mgr_base);
+	uint64_t clock_freq_mhz = 0;
+	uint32_t timer_threshold = 0;
+
+	// always safer to read the timer threshold instead of using cached value
+	REG_GET(CLK8_CLK_TICK_CNT_CONFIG_REG, TIMER_THRESHOLD, &timer_threshold);
+
+	if (timer_threshold == 0) {
+		BREAK_TO_DEBUGGER();
+		return 0;
+	}
+
+	switch (clock) {
+	case clock_type_dispclk:
+		clock_freq_mhz = REG_READ(CLK8_CLK0_CURRENT_CNT);
+		break;
+	case clock_type_dppclk:
+		clock_freq_mhz = REG_READ(CLK8_CLK1_CURRENT_CNT);
+		break;
+	case clock_type_dprefclk:
+		clock_freq_mhz = REG_READ(CLK8_CLK2_CURRENT_CNT);
+		break;
+	case clock_type_dcfclk:
+		clock_freq_mhz = REG_READ(CLK8_CLK3_CURRENT_CNT);
+		break;
+	case clock_type_dtbclk:
+		clock_freq_mhz = REG_READ(CLK8_CLK4_CURRENT_CNT);
+		break;
+	default:
+		break;
+	}
+
+	clock_freq_mhz *= DCN42_CLKIP_REFCLK;
+	clock_freq_mhz = div_u64(clock_freq_mhz, timer_threshold);
+
+	// there are no DCN clocks over 0xFFFFFFFF MHz
+	ASSERT(clock_freq_mhz <= 0xFFFFFFFF);
+
+	return (uint32_t)clock_freq_mhz;
+}
+
 void dcn42_update_clocks_update_dtb_dto(struct clk_mgr_internal *clk_mgr,
 		struct dc_state *context,
 		int ref_dtbclk_khz)
@@ -224,8 +234,6 @@ void dcn42_update_clocks(struct clk_mgr *clk_mgr_base,
 
 	display_count = dcn42_get_active_display_cnt_wa(dc, context, &all_active_disps);
 
-	/*dml21 issue*/
-	ASSERT(new_clocks->dtbclk_en && new_clocks->ref_dtbclk_khz > 590000); //remove this section if assert is hit
 	if (new_clocks->dtbclk_en && new_clocks->ref_dtbclk_khz < 590000)
 		new_clocks->ref_dtbclk_khz = 600000;
 
@@ -262,9 +270,7 @@ void dcn42_update_clocks(struct clk_mgr *clk_mgr_base,
 
 			dcn42_update_clocks_update_dtb_dto(clk_mgr, context, new_clocks->ref_dtbclk_khz);
 			dcn42_smu_set_dtbclk(clk_mgr, true);
-			if (clk_mgr_base->boot_snapshot.timer_threhold)
-				actual_dtbclk = REG_READ(CLK8_CLK4_CURRENT_CNT) / (clk_mgr_base->boot_snapshot.timer_threhold / 48000);
-
+			actual_dtbclk = dcn42_get_clock_freq_from_clkip(clk_mgr_base, clock_type_dtbclk);
 
 			if (actual_dtbclk > 590000) {
 				clk_mgr_base->clks.ref_dtbclk_khz = new_clocks->ref_dtbclk_khz;
@@ -386,34 +392,27 @@ bool dcn42_are_clock_states_equal(struct dc_clocks *a,
 static void dcn42_dump_clk_registers_internal(struct dcn42_clk_internal *internal, struct clk_mgr *clk_mgr_base)
 {
 	struct clk_mgr_internal *clk_mgr = TO_CLK_MGR_INTERNAL(clk_mgr_base);
-	uint32_t ratio = 1;
-
-	internal->CLK8_CLK_TICK_CNT__TIMER_THRESHOLD = REG_READ(CLK8_CLK_TICK_CNT_CONFIG_REG) & 0xFFFFFF;
-
-	ratio = internal->CLK8_CLK_TICK_CNT__TIMER_THRESHOLD / 48000;
-	ASSERT(ratio != 0);
-
-	if (ratio) {
-		// read dcf deep sleep divider
-		internal->CLK8_CLK0_DS_CNTL = REG_READ(CLK8_CLK0_DS_CNTL);
-		internal->CLK8_CLK3_DS_CNTL = REG_READ(CLK8_CLK3_DS_CNTL);
-		// read dispclk
-		internal->CLK8_CLK0_CURRENT_CNT = REG_READ(CLK8_CLK0_CURRENT_CNT) / ratio;
-		internal->CLK8_CLK0_BYPASS_CNTL = REG_READ(CLK8_CLK0_BYPASS_CNTL);
-		// read dppclk
-		internal->CLK8_CLK1_CURRENT_CNT = REG_READ(CLK8_CLK1_CURRENT_CNT) / ratio;
-		internal->CLK8_CLK1_BYPASS_CNTL = REG_READ(CLK8_CLK1_BYPASS_CNTL);
-		// read dprefclk
-		internal->CLK8_CLK2_CURRENT_CNT = REG_READ(CLK8_CLK2_CURRENT_CNT) / ratio;
-		internal->CLK8_CLK2_BYPASS_CNTL = REG_READ(CLK8_CLK2_BYPASS_CNTL);
-		// read dcfclk
-		internal->CLK8_CLK3_CURRENT_CNT = REG_READ(CLK8_CLK3_CURRENT_CNT) / ratio;
-		internal->CLK8_CLK3_BYPASS_CNTL = REG_READ(CLK8_CLK3_BYPASS_CNTL);
-		// read dtbclk
-		internal->CLK8_CLK4_CURRENT_CNT = REG_READ(CLK8_CLK4_CURRENT_CNT) / ratio;
-		internal->CLK8_CLK4_BYPASS_CNTL = REG_READ(CLK8_CLK4_BYPASS_CNTL);
-	}
 
+	REG_GET(CLK8_CLK_TICK_CNT_CONFIG_REG, TIMER_THRESHOLD, &internal->CLK8_CLK_TICK_CNT__TIMER_THRESHOLD);
+
+	// read dcf deep sleep divider
+	internal->CLK8_CLK0_DS_CNTL = REG_READ(CLK8_CLK0_DS_CNTL);
+	internal->CLK8_CLK3_DS_CNTL = REG_READ(CLK8_CLK3_DS_CNTL);
+	// read dispclk
+	internal->CLK8_CLK0_CURRENT_CNT = dcn42_get_clock_freq_from_clkip(clk_mgr_base, clock_type_dispclk);
+	internal->CLK8_CLK0_BYPASS_CNTL = REG_READ(CLK8_CLK0_BYPASS_CNTL);
+	// read dppclk
+	internal->CLK8_CLK1_CURRENT_CNT = dcn42_get_clock_freq_from_clkip(clk_mgr_base, clock_type_dppclk);
+	internal->CLK8_CLK1_BYPASS_CNTL = REG_READ(CLK8_CLK1_BYPASS_CNTL);
+	// read dprefclk
+	internal->CLK8_CLK2_CURRENT_CNT = dcn42_get_clock_freq_from_clkip(clk_mgr_base, clock_type_dprefclk);
+	internal->CLK8_CLK2_BYPASS_CNTL = REG_READ(CLK8_CLK2_BYPASS_CNTL);
+	// read dcfclk
+	internal->CLK8_CLK3_CURRENT_CNT = dcn42_get_clock_freq_from_clkip(clk_mgr_base, clock_type_dcfclk);
+	internal->CLK8_CLK3_BYPASS_CNTL = REG_READ(CLK8_CLK3_BYPASS_CNTL);
+	// read dtbclk
+	internal->CLK8_CLK4_CURRENT_CNT = dcn42_get_clock_freq_from_clkip(clk_mgr_base, clock_type_dtbclk);
+	internal->CLK8_CLK4_BYPASS_CNTL = REG_READ(CLK8_CLK4_BYPASS_CNTL);
 }
 
 static void dcn42_dump_clk_registers(struct clk_state_registers_and_bypass *regs_and_bypass,
@@ -422,8 +421,11 @@ static void dcn42_dump_clk_registers(struct clk_state_registers_and_bypass *regs
 	struct dcn42_clk_internal internal = {0};
 	char *bypass_clks[5] = {"0x0 DFS", "0x1 REFCLK", "0x2 ERROR", "0x3 400 FCH", "0x4 600 FCH"};
 
+	DC_LOGGER_INIT(clk_mgr->base.base.ctx->logger);
+	(void)dc_logger;
+
 	dcn42_dump_clk_registers_internal(&internal, &clk_mgr->base.base);
-	regs_and_bypass->timer_threhold = internal.CLK8_CLK_TICK_CNT__TIMER_THRESHOLD;
+	regs_and_bypass->timer_threshold = internal.CLK8_CLK_TICK_CNT__TIMER_THRESHOLD;
 	regs_and_bypass->dcfclk = internal.CLK8_CLK3_CURRENT_CNT / 10;
 	regs_and_bypass->dcf_deep_sleep_divider = internal.CLK8_CLK3_DS_CNTL / 10;
 	regs_and_bypass->dcf_deep_sleep_allow = internal.CLK8_CLK3_DS_CNTL & 0x10; /*bit 4: CLK0_ALLOW_DS*/
@@ -432,18 +434,10 @@ static void dcn42_dump_clk_registers(struct clk_state_registers_and_bypass *regs
 	regs_and_bypass->dppclk = internal.CLK8_CLK1_CURRENT_CNT / 10;
 	regs_and_bypass->dtbclk = internal.CLK8_CLK4_CURRENT_CNT / 10;
 
-	regs_and_bypass->dppclk_bypass = internal.CLK8_CLK1_BYPASS_CNTL & 0x0007;
-	if (regs_and_bypass->dppclk_bypass > 4)
-		regs_and_bypass->dppclk_bypass = 0;
-	regs_and_bypass->dcfclk_bypass = internal.CLK8_CLK3_BYPASS_CNTL & 0x0007;
-	if (regs_and_bypass->dcfclk_bypass > 4)
-		regs_and_bypass->dcfclk_bypass = 0;
-	regs_and_bypass->dispclk_bypass = internal.CLK8_CLK0_BYPASS_CNTL & 0x0007;
-	if (regs_and_bypass->dispclk_bypass > 4)
-		regs_and_bypass->dispclk_bypass = 0;
-	regs_and_bypass->dprefclk_bypass = internal.CLK8_CLK2_BYPASS_CNTL & 0x0007;
-	if (regs_and_bypass->dprefclk_bypass > 4)
-		regs_and_bypass->dprefclk_bypass = 0;
+	regs_and_bypass->dispclk_bypass = get_reg_field_value(internal.CLK8_CLK0_BYPASS_CNTL, CLK8_CLK0_BYPASS_CNTL, CLK0_BYPASS_SEL);
+	regs_and_bypass->dppclk_bypass = get_reg_field_value(internal.CLK8_CLK1_BYPASS_CNTL, CLK8_CLK1_BYPASS_CNTL, CLK1_BYPASS_SEL);
+	regs_and_bypass->dprefclk_bypass = get_reg_field_value(internal.CLK8_CLK2_BYPASS_CNTL, CLK8_CLK2_BYPASS_CNTL, CLK2_BYPASS_SEL);
+	regs_and_bypass->dcfclk_bypass = get_reg_field_value(internal.CLK8_CLK3_BYPASS_CNTL, CLK8_CLK3_BYPASS_CNTL, CLK3_BYPASS_SEL);
 
 	if (clk_mgr->base.base.ctx->dc->debug.pstate_enabled) {
 		DC_LOG_SMU("clk_type,clk_value,deepsleep_cntl,deepsleep_allow,bypass\n");
@@ -588,6 +582,9 @@ void dcn42_init_clocks(struct clk_mgr *clk_mgr_base)
 	struct clk_mgr_dcn42 *clk_mgr = TO_CLK_MGR_DCN42(clk_mgr_int);
 	struct dcn42_smu_dpm_clks smu_dpm_clks = { 0 };
 
+	DC_LOGGER_INIT(clk_mgr_base->ctx->logger);
+	(void)dc_logger;
+
 	init_clk_states(clk_mgr_base);
 
 	// to adjust dp_dto reference clock if ssc is enable otherwise to apply dprefclk
@@ -1111,25 +1108,30 @@ void dcn42_clk_mgr_construct(
 	 */
 	clk_mgr->base.base.dprefclk_khz = 600000;
 
-		clk_mgr->base.smu_present = false;
+	clk_mgr->base.smu_present = false;
+	clk_mgr->base.smu_ver = dcn42_smu_get_pmfw_version(&clk_mgr->base);
+	if (clk_mgr->base.smu_ver && clk_mgr->base.smu_ver != -1)
+		clk_mgr->base.smu_present = true;
 
-		if (ctx->dc_bios->integrated_info) {
-			clk_mgr->base.base.dentist_vco_freq_khz = ctx->dc_bios->integrated_info->dentist_vco_freq;
+	if (ctx->dc_bios->integrated_info) {
+		clk_mgr->base.base.dentist_vco_freq_khz = ctx->dc_bios->integrated_info->dentist_vco_freq;
 
-			if (ctx->dc_bios->integrated_info->memory_type == LpDdr5MemType)
-				dcn42_bw_params.wm_table = lpddr5_wm_table;
-			else
-				dcn42_bw_params.wm_table = ddr5_wm_table;
-			dcn42_bw_params.vram_type = ctx->dc_bios->integrated_info->memory_type;
-			dcn42_bw_params.dram_channel_width_bytes = ctx->dc_bios->integrated_info->memory_type == 0x22 ? 8 : 4;
-			dcn42_bw_params.num_channels = ctx->dc_bios->integrated_info->ma_channel_number ? ctx->dc_bios->integrated_info->ma_channel_number : 4;
-		}
-		/* in case we don't get a value from the BIOS, use default */
-		if (clk_mgr->base.base.dentist_vco_freq_khz == 0)
-			clk_mgr->base.base.dentist_vco_freq_khz = 3000000; /* 3000MHz */
+		if (ctx->dc_bios->integrated_info->memory_type == LpDdr5MemType)
+			dcn42_bw_params.wm_table = lpddr5_wm_table;
+		else
+			dcn42_bw_params.wm_table = ddr5_wm_table;
+
+		dcn42_bw_params.vram_type = ctx->dc_bios->integrated_info->memory_type;
+		dcn42_bw_params.dram_channel_width_bytes = ctx->dc_bios->integrated_info->memory_type == 0x22 ? 8 : 4;
+		dcn42_bw_params.num_channels = ctx->dc_bios->integrated_info->ma_channel_number ? ctx->dc_bios->integrated_info->ma_channel_number : 4;
+	}
+
+	/* in case we don't get a value from the BIOS, use default */
+	if (clk_mgr->base.base.dentist_vco_freq_khz == 0)
+		clk_mgr->base.base.dentist_vco_freq_khz = 3000000; /* 3000MHz */
 
-		/* Saved clocks configured at boot for debug purposes */
-		dcn42_dump_clk_registers(&clk_mgr->base.base.boot_snapshot, clk_mgr);
+	/* Saved clocks configured at boot for debug purposes */
+	dcn42_dump_clk_registers(&clk_mgr->base.base.boot_snapshot, clk_mgr);
 
 	if (clk_mgr->base.smu_present)
 		clk_mgr->base.base.dprefclk_khz = dcn42_smu_get_dprefclk(&clk_mgr->base);
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index fc94c002bd6a..2e89b05fcc32 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -5946,6 +5946,7 @@ bool dc_is_dmub_outbox_supported(struct dc *dc)
 
 	case AMDGPU_FAMILY_GC_11_0_1:
 	case AMDGPU_FAMILY_GC_11_5_0:
+	case AMDGPU_FAMILY_GC_11_5_4:
 		if (!dc->debug.dpia_debug.bits.disable_dpia)
 			return true;
 	break;
diff --git a/drivers/gpu/drm/amd/display/dc/dc_spl_translate.c b/drivers/gpu/drm/amd/display/dc/dc_spl_translate.c
index 37d1a79e8241..ba7bf23f2b2f 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_spl_translate.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_spl_translate.c
@@ -89,6 +89,7 @@ void translate_SPL_in_params_from_pipe_ctx(struct pipe_ctx *pipe_ctx, struct spl
 		spl_in->callbacks = dcn32_spl_callbacks;
 		break;
 	case DCN_VERSION_4_01:
+	case DCN_VERSION_4_2:
 		spl_in->callbacks = dcn401_spl_callbacks;
 		break;
 	default:
diff --git a/drivers/gpu/drm/amd/display/dc/dccg/dcn20/dcn20_dccg.h b/drivers/gpu/drm/amd/display/dc/dccg/dcn20/dcn20_dccg.h
index 463f5826a1ea..088cf305a772 100644
--- a/drivers/gpu/drm/amd/display/dc/dccg/dcn20/dcn20_dccg.h
+++ b/drivers/gpu/drm/amd/display/dc/dccg/dcn20/dcn20_dccg.h
@@ -374,7 +374,8 @@
 	type OTG1_DROP_PIXEL;\
 	type OTG2_DROP_PIXEL;\
 	type OTG3_ADD_PIXEL;\
-	type OTG3_DROP_PIXEL;
+	type OTG3_DROP_PIXEL;\
+	type RESYNC_FIFO_LEVEL_ADJUST_EN;
 
 struct dccg_shift {
 	DCCG_REG_FIELD_LIST(uint8_t)
diff --git a/drivers/gpu/drm/amd/display/dc/dccg/dcn42/dcn42_dccg.c b/drivers/gpu/drm/amd/display/dc/dccg/dcn42/dcn42_dccg.c
index d1593dc68e36..19dfc3fe5c3a 100644
--- a/drivers/gpu/drm/amd/display/dc/dccg/dcn42/dcn42_dccg.c
+++ b/drivers/gpu/drm/amd/display/dc/dccg/dcn42/dcn42_dccg.c
@@ -180,6 +180,61 @@ void dccg42_set_physymclk(
 	}
 }
 
+void dccg42_set_pixel_rate_div(
+		struct dccg *dccg,
+		uint32_t otg_inst,
+		enum pixel_rate_div tmds_div,
+		enum pixel_rate_div unused)
+{
+	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
+	uint32_t cur_tmds_div = PIXEL_RATE_DIV_NA;
+	uint32_t dp_dto_int;
+	uint32_t reg_val;
+
+	// only 2 and 4 are valid on dcn401
+	if (tmds_div != PIXEL_RATE_DIV_BY_2 && tmds_div != PIXEL_RATE_DIV_BY_4) {
+		return;
+	}
+
+	dccg401_get_pixel_rate_div(dccg, otg_inst, &cur_tmds_div, &dp_dto_int);
+	if (tmds_div == cur_tmds_div)
+		return;
+
+	// encode enum to register value
+	reg_val = tmds_div == PIXEL_RATE_DIV_BY_4 ? 1 : 0;
+
+	switch (otg_inst) {
+	case 0:
+		REG_UPDATE(OTG_PIXEL_RATE_DIV,
+				OTG0_TMDS_PIXEL_RATE_DIV, reg_val);
+		break;
+	case 1:
+		REG_UPDATE(OTG_PIXEL_RATE_DIV,
+				OTG1_TMDS_PIXEL_RATE_DIV, reg_val);
+		break;
+	case 2:
+		REG_UPDATE(OTG_PIXEL_RATE_DIV,
+				OTG2_TMDS_PIXEL_RATE_DIV, reg_val);
+		break;
+	case 3:
+		REG_UPDATE(OTG_PIXEL_RATE_DIV,
+				OTG3_TMDS_PIXEL_RATE_DIV, reg_val);
+		break;
+	default:
+		BREAK_TO_DEBUGGER();
+		return;
+	}
+}
+
+void dccg42_trigger_dio_fifo_resync(struct dccg *dccg)
+{
+	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
+
+	REG_UPDATE(DISPCLK_FREQ_CHANGE_CNTL, RESYNC_FIFO_LEVEL_ADJUST_EN, 1);
+	REG_UPDATE(DISPCLK_FREQ_CHANGE_CNTL, RESYNC_FIFO_LEVEL_ADJUST_EN, 0);
+	REG_WAIT(DISPCLK_FREQ_CHANGE_CNTL, DISPCLK_FREQ_RAMP_DONE, 1, 50, 2000);
+}
+
 static void dccg42_init(struct dccg *dccg)
 {
 	int otg_inst;
@@ -240,9 +295,9 @@ static const struct dccg_funcs dccg42_funcs = {
 	.otg_drop_pixel = dccg42_otg_drop_pixel,
 	.disable_dsc = dccg35_disable_dscclk,
 	.enable_dsc = dccg35_enable_dscclk,
-	.set_pixel_rate_div = dccg401_set_pixel_rate_div,
+	.set_pixel_rate_div = dccg42_set_pixel_rate_div,
 	.get_pixel_rate_div = dccg401_get_pixel_rate_div,
-	.trigger_dio_fifo_resync = dccg35_trigger_dio_fifo_resync,
+	.trigger_dio_fifo_resync = dccg42_trigger_dio_fifo_resync,
 	.set_dp_dto = dccg401_set_dp_dto,
 	.enable_symclk_se = dccg35_enable_symclk_se,
 	.disable_symclk_se = dccg35_disable_symclk_se,
diff --git a/drivers/gpu/drm/amd/display/dc/dccg/dcn42/dcn42_dccg.h b/drivers/gpu/drm/amd/display/dc/dccg/dcn42/dcn42_dccg.h
index 96eae0003f43..d9831b0f8235 100644
--- a/drivers/gpu/drm/amd/display/dc/dccg/dcn42/dcn42_dccg.h
+++ b/drivers/gpu/drm/amd/display/dc/dccg/dcn42/dcn42_dccg.h
@@ -238,7 +238,8 @@
 	DCCG_SF(SYMCLKE_CLOCK_ENABLE, SYMCLKE_SRC_SEL, mask_sh),\
 	DCCG_SF(SYMCLKE_CLOCK_ENABLE, SYMCLKE_CLOCK_ENABLE, mask_sh),\
 	DCCG_SF(SYMCLKE_CLOCK_ENABLE, SYMCLKE_FE_EN, mask_sh),\
-	DCCG_SF(SYMCLKE_CLOCK_ENABLE, SYMCLKE_FE_SRC_SEL, mask_sh)
+	DCCG_SF(SYMCLKE_CLOCK_ENABLE, SYMCLKE_FE_SRC_SEL, mask_sh),\
+	DCCG_SF(DISPCLK_FREQ_CHANGE_CNTL, RESYNC_FIFO_LEVEL_ADJUST_EN, mask_sh)
 
 
 void dccg42_otg_add_pixel(struct dccg *dccg,
@@ -254,6 +255,14 @@ void dccg42_set_physymclk(
 		enum physymclk_clock_source clk_src,
 		bool force_enable);
 
+void dccg42_set_pixel_rate_div(
+		struct dccg *dccg,
+		uint32_t otg_inst,
+		enum pixel_rate_div tmds_div,
+		enum pixel_rate_div unused);
+
+void dccg42_trigger_dio_fifo_resync(struct dccg *dccg);
+
 struct dccg *dccg42_create(
 	struct dc_context *ctx,
 	const struct dccg_registers *regs,
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/bounding_boxes/dcn42_soc_bb.h b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/bounding_boxes/dcn42_soc_bb.h
new file mode 100644
index 000000000000..8cd074cfdf18
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/bounding_boxes/dcn42_soc_bb.h
@@ -0,0 +1,359 @@
+/* SPDX-License-Identifier: MIT */
+/* Copyright 2026 Advanced Micro Devices, Inc. */
+
+#ifndef __DML_DML_DCN42_SOC_BB__
+#define __DML_DML_DCN42_SOC_BB__
+
+#include "dml_top_soc_parameter_types.h"
+
+static const struct dml2_soc_qos_parameters dml_dcn42_variant_a_soc_qos_params = {
+	.derate_table = {
+		.system_active_urgent = {
+			.dram_derate_percent_pixel = 22,
+			.dram_derate_percent_vm = 0,
+			.dram_derate_percent_pixel_and_vm = 0,
+			.fclk_derate_percent = 76,
+			.dcfclk_derate_percent = 100,
+		},
+		.system_active_average = {
+			.dram_derate_percent_pixel = 17,
+			.dram_derate_percent_vm = 0,
+			.dram_derate_percent_pixel_and_vm = 0,
+			.fclk_derate_percent = 57,
+			.dcfclk_derate_percent = 75,
+		},
+		.dcn_mall_prefetch_urgent = {
+			.dram_derate_percent_pixel = 40,
+			.dram_derate_percent_vm = 0,
+			.dram_derate_percent_pixel_and_vm = 0,
+			.fclk_derate_percent = 83,
+			.dcfclk_derate_percent = 100,
+		},
+		.dcn_mall_prefetch_average = {
+			.dram_derate_percent_pixel = 33,
+			.dram_derate_percent_vm = 0,
+			.dram_derate_percent_pixel_and_vm = 0,
+			.fclk_derate_percent = 62,
+			.dcfclk_derate_percent = 83,
+		},
+		.system_idle_average = {
+			.dram_derate_percent_pixel = 70,
+			.dram_derate_percent_vm = 0,
+			.dram_derate_percent_pixel_and_vm = 0,
+			.fclk_derate_percent = 83,
+			.dcfclk_derate_percent = 100,
+		},
+	},
+	.writeback = {
+		.base_latency_us = 12,
+		.scaling_factor_us = 0,
+		.scaling_factor_mhz = 0,
+	},
+	.qos_params = {
+		.dcn4x = {
+			.df_qos_response_time_fclk_cycles = 300,
+			.max_round_trip_to_furthest_cs_fclk_cycles = 350,
+			.mall_overhead_fclk_cycles = 50,
+			.meta_trip_adder_fclk_cycles = 36,
+			.average_transport_distance_fclk_cycles = 257,
+			.umc_urgent_ramp_latency_margin = 50,
+			.umc_max_latency_margin = 30,
+			.umc_average_latency_margin = 20,
+			.fabric_max_transport_latency_margin = 20,
+			.fabric_average_transport_latency_margin = 10,
+
+			.per_uclk_dpm_params = {
+				{
+					.minimum_uclk_khz = 97 * 1000,
+					.urgent_ramp_uclk_cycles = 472,
+					.trip_to_memory_uclk_cycles = 827,
+					.meta_trip_to_memory_uclk_cycles = 827,
+					.maximum_latency_when_urgent_uclk_cycles = 72,
+					.average_latency_when_urgent_uclk_cycles = 61,
+					.maximum_latency_when_non_urgent_uclk_cycles = 827,
+					.average_latency_when_non_urgent_uclk_cycles = 118,
+				},
+			},
+		},
+	},
+	.qos_type = dml2_qos_param_type_dcn4x,
+};
+
+static const struct dml2_soc_bb dml2_socbb_dcn42 = {
+	.clk_table = {
+		.uclk = {
+				.clk_values_khz = {97000},
+				.num_clk_values = 1,
+		},
+		.fclk = {
+				.clk_values_khz = {300000, 2500000},
+				.num_clk_values = 2,
+		},
+		.dcfclk = {
+				.clk_values_khz = {200000, 1564000},
+				.num_clk_values = 2,
+		},
+		.dispclk = {
+				.clk_values_khz = {100000, 1500000},
+				.num_clk_values = 2,
+		},
+		.dppclk = {
+				.clk_values_khz = {100000, 1500000},
+				.num_clk_values = 2,
+		},
+		.dtbclk = {
+				.clk_values_khz = {600000, 600000},
+				.num_clk_values = 2,
+		},
+		.phyclk = {
+				.clk_values_khz = {810000, 810000},
+				.num_clk_values = 2,
+		},
+		.socclk = {
+				.clk_values_khz = {300000, 1200000},
+				.num_clk_values = 2,
+		},
+		.dscclk = {
+				.clk_values_khz = {500000, 500000},
+				.num_clk_values = 2,
+		},
+		.phyclk_d18 = {
+				.clk_values_khz = {667000, 667000},
+				.num_clk_values = 2,
+		},
+		.phyclk_d32 = {
+				.clk_values_khz = {625000, 625000},
+				.num_clk_values = 2,
+		},
+		.dram_config = {
+			.channel_width_bytes = 4,
+			.channel_count = 4,
+			.alt_clock_bw_conversion = true,
+		},
+	},
+
+	.qos_parameters = {
+		.derate_table = {
+			.system_active_urgent = {
+				.dram_derate_percent_pixel = 22,
+				.dram_derate_percent_vm = 0,
+				.dram_derate_percent_pixel_and_vm = 0,
+				.fclk_derate_percent = 76,
+				.dcfclk_derate_percent = 100,
+			},
+			.system_active_average = {
+				.dram_derate_percent_pixel = 15,
+				.dram_derate_percent_vm = 0,
+				.dram_derate_percent_pixel_and_vm = 0,
+				.fclk_derate_percent = 57,
+				.dcfclk_derate_percent = 75,
+			},
+			.dcn_mall_prefetch_urgent = {
+				.dram_derate_percent_pixel = 40,
+				.dram_derate_percent_vm = 0,
+				.dram_derate_percent_pixel_and_vm = 0,
+				.fclk_derate_percent = 83,
+				.dcfclk_derate_percent = 100,
+			},
+			.dcn_mall_prefetch_average = {
+				.dram_derate_percent_pixel = 30,
+				.dram_derate_percent_vm = 0,
+				.dram_derate_percent_pixel_and_vm = 0,
+				.fclk_derate_percent = 62,
+				.dcfclk_derate_percent = 83,
+			},
+			.system_idle_average = {
+				.dram_derate_percent_pixel = 70,
+				.dram_derate_percent_vm = 0,
+				.dram_derate_percent_pixel_and_vm = 0,
+				.fclk_derate_percent = 83,
+				.dcfclk_derate_percent = 100,
+			},
+		},
+		.writeback = {
+			.base_latency_us = 12,
+			.scaling_factor_us = 0,
+			.scaling_factor_mhz = 0,
+		},
+		.qos_params = {
+			.dcn4x = {
+				.df_qos_response_time_fclk_cycles = 300,
+				.max_round_trip_to_furthest_cs_fclk_cycles = 350,
+				.mall_overhead_fclk_cycles = 50,
+				.meta_trip_adder_fclk_cycles = 36,
+				.average_transport_distance_fclk_cycles = 260,
+				.umc_urgent_ramp_latency_margin = 50,
+				.umc_max_latency_margin = 30,
+				.umc_average_latency_margin = 20,
+				.fabric_max_transport_latency_margin = 20,
+				.fabric_average_transport_latency_margin = 10,
+
+				.per_uclk_dpm_params = {
+					{
+						// State 1
+						.minimum_uclk_khz = 0,
+						.urgent_ramp_uclk_cycles = 472,
+						.trip_to_memory_uclk_cycles = 827,
+						.meta_trip_to_memory_uclk_cycles = 827,
+						.maximum_latency_when_urgent_uclk_cycles = 72,
+						.average_latency_when_urgent_uclk_cycles = 72,
+						.maximum_latency_when_non_urgent_uclk_cycles = 827,
+						.average_latency_when_non_urgent_uclk_cycles = 117,
+					},
+					{
+						// State 2
+						.minimum_uclk_khz = 0,
+						.urgent_ramp_uclk_cycles = 546,
+						.trip_to_memory_uclk_cycles = 848,
+						.meta_trip_to_memory_uclk_cycles = 848,
+						.maximum_latency_when_urgent_uclk_cycles = 146,
+						.average_latency_when_urgent_uclk_cycles = 146,
+						.maximum_latency_when_non_urgent_uclk_cycles = 848,
+						.average_latency_when_non_urgent_uclk_cycles = 133,
+					},
+					{
+						// State 3
+						.minimum_uclk_khz = 0,
+						.urgent_ramp_uclk_cycles = 564,
+						.trip_to_memory_uclk_cycles = 853,
+						.meta_trip_to_memory_uclk_cycles = 853,
+						.maximum_latency_when_urgent_uclk_cycles = 164,
+						.average_latency_when_urgent_uclk_cycles = 164,
+						.maximum_latency_when_non_urgent_uclk_cycles = 853,
+						.average_latency_when_non_urgent_uclk_cycles = 136,
+					},
+					{
+						// State 4
+						.minimum_uclk_khz = 0,
+						.urgent_ramp_uclk_cycles = 613,
+						.trip_to_memory_uclk_cycles = 869,
+						.meta_trip_to_memory_uclk_cycles = 869,
+						.maximum_latency_when_urgent_uclk_cycles = 213,
+						.average_latency_when_urgent_uclk_cycles = 213,
+						.maximum_latency_when_non_urgent_uclk_cycles = 869,
+						.average_latency_when_non_urgent_uclk_cycles = 149,
+					},
+					{
+						// State 5
+						.minimum_uclk_khz = 0,
+						.urgent_ramp_uclk_cycles = 632,
+						.trip_to_memory_uclk_cycles = 874,
+						.meta_trip_to_memory_uclk_cycles = 874,
+						.maximum_latency_when_urgent_uclk_cycles = 232,
+						.average_latency_when_urgent_uclk_cycles = 232,
+						.maximum_latency_when_non_urgent_uclk_cycles = 874,
+						.average_latency_when_non_urgent_uclk_cycles = 153,
+					},
+					{
+						// State 6
+						.minimum_uclk_khz = 0,
+						.urgent_ramp_uclk_cycles = 665,
+						.trip_to_memory_uclk_cycles = 885,
+						.meta_trip_to_memory_uclk_cycles = 885,
+						.maximum_latency_when_urgent_uclk_cycles = 265,
+						.average_latency_when_urgent_uclk_cycles = 265,
+						.maximum_latency_when_non_urgent_uclk_cycles = 885,
+						.average_latency_when_non_urgent_uclk_cycles = 161,
+					},
+					{
+						// State 7
+						.minimum_uclk_khz = 0,
+						.urgent_ramp_uclk_cycles = 689,
+						.trip_to_memory_uclk_cycles = 895,
+						.meta_trip_to_memory_uclk_cycles = 895,
+						.maximum_latency_when_urgent_uclk_cycles = 289,
+						.average_latency_when_urgent_uclk_cycles = 289,
+						.maximum_latency_when_non_urgent_uclk_cycles = 895,
+						.average_latency_when_non_urgent_uclk_cycles = 167,
+					},
+					{
+						// State 8
+						.minimum_uclk_khz = 0,
+						.urgent_ramp_uclk_cycles = 716,
+						.trip_to_memory_uclk_cycles = 902,
+						.meta_trip_to_memory_uclk_cycles = 902,
+						.maximum_latency_when_urgent_uclk_cycles = 316,
+						.average_latency_when_urgent_uclk_cycles = 316,
+						.maximum_latency_when_non_urgent_uclk_cycles = 902,
+						.average_latency_when_non_urgent_uclk_cycles = 174,
+					},
+				},
+			},
+		},
+		.qos_type = dml2_qos_param_type_dcn4x,
+	},
+
+	.power_management_parameters = {
+		.dram_clk_change_blackout_us = 11.72,
+		.fclk_change_blackout_us = 0,
+		.g7_ppt_blackout_us = 0,
+		.stutter_enter_plus_exit_latency_us = 11,
+		.stutter_exit_latency_us = 9,
+		.z8_stutter_enter_plus_exit_latency_us = 300,
+		.z8_stutter_exit_latency_us = 200,
+	},
+
+	 .vmin_limit = {
+		.dispclk_khz = 600 * 1000,
+	 },
+
+	.dprefclk_mhz = 600,
+	.xtalclk_mhz = 24,
+	.pcie_refclk_mhz = 100,
+	.dchub_refclk_mhz = 50,
+	.mall_allocated_for_dcn_mbytes = 64,
+	.max_outstanding_reqs = 256,
+	.fabric_datapath_to_dcn_data_return_bytes = 32,
+	.return_bus_width_bytes = 64,
+	.hostvm_min_page_size_kbytes = 4,
+	.gpuvm_min_page_size_kbytes = 256,
+	.phy_downspread_percent = 0.38,
+	.dcn_downspread_percent = 0.38,
+	.dispclk_dppclk_vco_speed_mhz = 3000,
+	.do_urgent_latency_adjustment = 0,
+	.mem_word_bytes = 32,
+	.num_dcc_mcaches = 8,
+	.mcache_size_bytes = 2048,
+	.mcache_line_size_bytes = 32,
+	.max_fclk_for_uclk_dpm_khz = 2200 * 1000,
+};
+
+static const struct dml2_ip_capabilities dml2_dcn42_max_ip_caps = {
+	.pipe_count = 4,
+	.otg_count = 4,
+	.num_dsc = 4,
+	.max_num_dp2p0_streams = 4,
+	.max_num_hdmi_frl_outputs = 1,
+	.max_num_dp2p0_outputs = 4,
+	.rob_buffer_size_kbytes = 64,
+	.config_return_buffer_size_in_kbytes = 1792,
+	.config_return_buffer_segment_size_in_kbytes = 64,
+	.meta_fifo_size_in_kentries = 32,
+	.compressed_buffer_segment_size_in_kbytes = 64,
+	.cursor_buffer_size = 24,
+	.max_flip_time_us = 110,
+	.max_flip_time_lines = 50,
+	.hostvm_mode = 0,
+	.subvp_drr_scheduling_margin_us = 100,
+	.subvp_prefetch_end_to_mall_start_us = 15,
+	.subvp_fw_processing_delay = 15,
+	.max_vactive_det_fill_delay_us = 400,
+
+	.fams2 = {
+		.max_allow_delay_us = 100 * 1000,
+		.scheduling_delay_us = 550,
+		.vertical_interrupt_ack_delay_us = 40,
+		.allow_programming_delay_us = 18,
+		.min_allow_width_us = 20,
+		.subvp_df_throttle_delay_us = 100,
+		.subvp_programming_delay_us = 200,
+		.subvp_prefetch_to_mall_delay_us = 18,
+		.drr_programming_delay_us = 35,
+
+		.lock_timeout_us = 5000,
+		.recovery_timeout_us = 5000,
+		.flip_programming_delay_us = 300,
+	},
+};
+
+#endif
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr.h b/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr.h
index 91eba1985bab..21224fd6b36d 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr.h
@@ -215,7 +215,7 @@ struct clk_state_registers_and_bypass {
 	uint32_t dcfclk_bypass;
 	uint32_t dprefclk_bypass;
 	uint32_t dispclk_bypass;
-	uint32_t timer_threhold;
+	uint32_t timer_threshold;
 };
 
 struct rv1_clk_internal {
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr_internal.h b/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr_internal.h
index 9e53eacee3f8..c69ccfcebeb5 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr_internal.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr_internal.h
@@ -243,7 +243,23 @@ enum dentist_divider_range {
 	CLK_SR_DCN42(CLK8_CLK3_DS_CNTL), \
 	CLK_SR_DCN42(CLK8_CLK4_DS_CNTL)
 
-#define CLK_COMMON_MASK_SH_LIST_DCN42(mask_sh) 0
+#define CLK_COMMON_MASK_SH_LIST_DCN42(mask_sh) \
+	CLK_SF(CLK8_CLK_TICK_CNT_CONFIG_REG, TIMER_THRESHOLD, mask_sh), \
+	CLK_SF(CLK8_CLK0_BYPASS_CNTL, CLK0_BYPASS_SEL, mask_sh), \
+	CLK_SF(CLK8_CLK1_BYPASS_CNTL, CLK1_BYPASS_SEL, mask_sh), \
+	CLK_SF(CLK8_CLK2_BYPASS_CNTL, CLK2_BYPASS_SEL, mask_sh), \
+	CLK_SF(CLK8_CLK3_BYPASS_CNTL, CLK3_BYPASS_SEL, mask_sh), \
+	CLK_SF(CLK8_CLK4_BYPASS_CNTL, CLK4_BYPASS_SEL, mask_sh), \
+	CLK_SF(CLK8_CLK0_DS_CNTL, CLK0_DS_DIV_ID, mask_sh), \
+	CLK_SF(CLK8_CLK1_DS_CNTL, CLK1_DS_DIV_ID, mask_sh), \
+	CLK_SF(CLK8_CLK2_DS_CNTL, CLK2_DS_DIV_ID, mask_sh), \
+	CLK_SF(CLK8_CLK3_DS_CNTL, CLK3_DS_DIV_ID, mask_sh), \
+	CLK_SF(CLK8_CLK4_DS_CNTL, CLK4_DS_DIV_ID, mask_sh), \
+	CLK_SF(CLK8_CLK0_DS_CNTL, CLK0_ALLOW_DS, mask_sh), \
+	CLK_SF(CLK8_CLK1_DS_CNTL, CLK1_ALLOW_DS, mask_sh), \
+	CLK_SF(CLK8_CLK2_DS_CNTL, CLK2_ALLOW_DS, mask_sh), \
+	CLK_SF(CLK8_CLK3_DS_CNTL, CLK3_ALLOW_DS, mask_sh), \
+	CLK_SF(CLK8_CLK4_DS_CNTL, CLK4_ALLOW_DS, mask_sh), \
 
 
 
@@ -259,6 +275,42 @@ enum dentist_divider_range {
 	type FbMult_int; \
 	type FbMult_frac;
 
+#define CLK42_REG_LIST(clkip_num, type) \
+	type CLK ## clkip_num ## _CLK_TICK_CNT_CONFIG_REG; \
+	type CLK ## clkip_num ## _CLK0_CURRENT_CNT; \
+	type CLK ## clkip_num ## _CLK1_CURRENT_CNT; \
+	type CLK ## clkip_num ## _CLK2_CURRENT_CNT; \
+	type CLK ## clkip_num ## _CLK3_CURRENT_CNT; \
+	type CLK ## clkip_num ## _CLK4_CURRENT_CNT; \
+	type CLK ## clkip_num ## _CLK0_BYPASS_CNTL; \
+	type CLK ## clkip_num ## _CLK1_BYPASS_CNTL; \
+	type CLK ## clkip_num ## _CLK2_BYPASS_CNTL; \
+	type CLK ## clkip_num ## _CLK3_BYPASS_CNTL; \
+	type CLK ## clkip_num ## _CLK4_BYPASS_CNTL; \
+	type CLK ## clkip_num ## _CLK0_DS_CNTL; \
+	type CLK ## clkip_num ## _CLK1_DS_CNTL; \
+	type CLK ## clkip_num ## _CLK2_DS_CNTL; \
+	type CLK ## clkip_num ## _CLK3_DS_CNTL; \
+	type CLK ## clkip_num ## _CLK4_DS_CNTL;
+
+#define CLK42_REG_FIELD_LIST(type) \
+	type TIMER_THRESHOLD; \
+	type CLK0_BYPASS_SEL; \
+	type CLK1_BYPASS_SEL; \
+	type CLK2_BYPASS_SEL; \
+	type CLK3_BYPASS_SEL; \
+	type CLK4_BYPASS_SEL; \
+	type CLK0_DS_DIV_ID; \
+	type CLK1_DS_DIV_ID; \
+	type CLK2_DS_DIV_ID; \
+	type CLK3_DS_DIV_ID; \
+	type CLK4_DS_DIV_ID; \
+	type CLK0_ALLOW_DS; \
+	type CLK1_ALLOW_DS; \
+	type CLK2_ALLOW_DS; \
+	type CLK3_ALLOW_DS; \
+	type CLK4_ALLOW_DS;
+
 /*
  ***************************************************************************************
  ****************** Clock Manager Private Structures ***********************************
@@ -322,32 +374,19 @@ struct clk_mgr_registers {
 	uint32_t CLK1_CLK5_ALLOW_DS;
 	uint32_t CLK5_spll_field_8;
 	uint32_t CLK6_spll_field_8;
-	uint32_t CLK8_CLK0_CURRENT_CNT;
-	uint32_t CLK8_CLK1_CURRENT_CNT;
-	uint32_t CLK8_CLK2_CURRENT_CNT;
-	uint32_t CLK8_CLK3_CURRENT_CNT;
-	uint32_t CLK8_CLK4_CURRENT_CNT;
-	uint32_t CLK8_CLK0_DS_CNTL;
-	uint32_t CLK8_CLK1_DS_CNTL;
-	uint32_t CLK8_CLK2_DS_CNTL;
-	uint32_t CLK8_CLK3_DS_CNTL;
-	uint32_t CLK8_CLK4_DS_CNTL;
-	uint32_t CLK8_CLK0_BYPASS_CNTL;
-	uint32_t CLK8_CLK1_BYPASS_CNTL;
-	uint32_t CLK8_CLK2_BYPASS_CNTL;
-	uint32_t CLK8_CLK3_BYPASS_CNTL;
-	uint32_t CLK8_CLK4_BYPASS_CNTL;
-	uint32_t CLK8_CLK_TICK_CNT_CONFIG_REG;
+	CLK42_REG_LIST(8, uint32_t)
 };
 
 struct clk_mgr_shift {
 	CLK_REG_FIELD_LIST(uint8_t)
 	CLK20_REG_FIELD_LIST(uint8_t)
+	CLK42_REG_FIELD_LIST(uint8_t)
 };
 
 struct clk_mgr_mask {
 	CLK_REG_FIELD_LIST(uint32_t)
 	CLK20_REG_FIELD_LIST(uint32_t)
+	CLK42_REG_FIELD_LIST(uint32_t)
 };
 
 enum clock_type {
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
index ba311a8f3f65..4a2699a374b7 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
@@ -847,6 +847,7 @@ bool edp_setup_psr(struct dc_link *link,
 		case FAMILY_YELLOW_CARP:
 		case AMDGPU_FAMILY_GC_10_3_6:
 		case AMDGPU_FAMILY_GC_11_0_1:
+		case AMDGPU_FAMILY_GC_11_5_4:
 			if (dc->debug.disable_z10 || dc->debug.psr_skip_crtc_disable)
 				psr_context->psr_level.bits.SKIP_CRTC_DISABLE = true;
 			break;
diff --git a/drivers/gpu/drm/amd/display/dc/soc_and_ip_translator/Makefile b/drivers/gpu/drm/amd/display/dc/soc_and_ip_translator/Makefile
index bc93356a0b5b..d168fb1eacf7 100644
--- a/drivers/gpu/drm/amd/display/dc/soc_and_ip_translator/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/soc_and_ip_translator/Makefile
@@ -8,11 +8,14 @@ soc_and_ip_translator_ccflags := $(CC_FLAGS_FPU)
 soc_and_ip_translator_rcflags := $(CC_FLAGS_NO_FPU)
 
 CFLAGS_$(AMDDALPATH)/dc/soc_and_ip_translator/dcn401/dcn401_soc_and_ip_translator.o := $(soc_and_ip_translator_ccflags)
+CFLAGS_$(AMDDALPATH)/dc/soc_and_ip_translator/dcn42/dcn42_soc_and_ip_translator.o := $(soc_and_ip_translator_ccflags)
 
 CFLAGS_REMOVE_$(AMDDALPATH)/dc/soc_and_ip_translator/dcn401/dcn401_soc_and_ip_translator.o := $(soc_and_ip_translator_rcflags)
+CFLAGS_REMOVE_$(AMDDALPATH)/dc/soc_and_ip_translator/dcn42/dcn42_soc_and_ip_translator.o := $(soc_and_ip_translator_rcflags)
 
 soc_and_ip_translator := soc_and_ip_translator.o
 soc_and_ip_translator += dcn401/dcn401_soc_and_ip_translator.o
+soc_and_ip_translator += dcn42/dcn42_soc_and_ip_translator.o
 
 AMD_DAL_soc_and_ip_translator := $(addprefix $(AMDDALPATH)/dc/soc_and_ip_translator/, $(soc_and_ip_translator))
 
diff --git a/drivers/gpu/drm/amd/display/dc/soc_and_ip_translator/dcn42/dcn42_soc_and_ip_translator.c b/drivers/gpu/drm/amd/display/dc/soc_and_ip_translator/dcn42/dcn42_soc_and_ip_translator.c
index c9e224d262c9..87ac56739030 100644
--- a/drivers/gpu/drm/amd/display/dc/soc_and_ip_translator/dcn42/dcn42_soc_and_ip_translator.c
+++ b/drivers/gpu/drm/amd/display/dc/soc_and_ip_translator/dcn42/dcn42_soc_and_ip_translator.c
@@ -11,13 +11,169 @@
  * This component provides an interface to get DCN-specific bounding box values.
  */
 
+static void get_default_soc_bb(struct dml2_soc_bb *soc_bb)
+{
+	memcpy(soc_bb, &dml2_socbb_dcn42, sizeof(struct dml2_soc_bb));
+	memcpy(&soc_bb->qos_parameters, &dml_dcn42_variant_a_soc_qos_params, sizeof(struct dml2_soc_qos_parameters));
+}
+
+/*
+ * DC clock table is obtained from SMU during runtime.
+ * SMU stands for System Management Unit. It is a power management processor.
+ * It owns the initialization of dc's clock table and programming of clock values
+ * based on dc's requests.
+ * Our clock values in base soc bb is a dummy placeholder. The real clock values
+ * are retrieved from SMU firmware to dc clock table at runtime.
+ * This function overrides our dummy placeholder values with real values in dc
+ * clock table.
+ */
+static void dcn42_convert_dc_clock_table_to_soc_bb_clock_table(
+		struct dml2_soc_state_table *dml_clk_table,
+		struct dml2_soc_vmin_clock_limits *vmin_limit,
+		const struct clk_bw_params *dc_bw_params)
+{
+	int i;
+	const struct clk_limit_table *dc_clk_table;
+
+	if (dc_bw_params == NULL)
+		/* skip if bw params could not be obtained from smu */
+		return;
+
+	dc_clk_table = &dc_bw_params->clk_table;
+
+	/* fclk/dcfclk - dcn42 pmfw table can have 0 entries for inactive dpm levels
+	 * for use with dml we need to fill in using an active value aiming for >= 2x DCFCLK
+	 */
+	if (dc_clk_table->num_entries_per_clk.num_fclk_levels && dc_clk_table->num_entries_per_clk.num_dcfclk_levels) {
+		dml_clk_table->fclk.num_clk_values = dc_clk_table->num_entries_per_clk.num_dcfclk_levels;
+		dml_clk_table->dcfclk.num_clk_values = dc_clk_table->num_entries_per_clk.num_dcfclk_levels;
+		for (i = 0; i < min(DML_MAX_CLK_TABLE_SIZE, MAX_NUM_DPM_LVL); i++) {
+			if (i < dc_clk_table->num_entries_per_clk.num_dcfclk_levels) {
+				int j, max_fclk = 0;
+
+				dml_clk_table->dcfclk.clk_values_khz[i] = dc_clk_table->entries[i].dcfclk_mhz * 1000;
+				for (j = 0; j < MAX_NUM_DPM_LVL; j++) {
+					if (dc_clk_table->entries[j].fclk_mhz * 1000 > max_fclk)
+						max_fclk = dc_clk_table->entries[j].fclk_mhz * 1000;
+					dml_clk_table->fclk.clk_values_khz[i] = max_fclk;
+					if (max_fclk >= 2 * dml_clk_table->dcfclk.clk_values_khz[i])
+						break;
+				}
+			} else {
+				dml_clk_table->dcfclk.clk_values_khz[i] = 0;
+				dml_clk_table->fclk.clk_values_khz[i] = 0;
+			}
+		}
+	}
+
+	/* uclk */
+	if (dc_clk_table->num_entries_per_clk.num_memclk_levels) {
+		dml_clk_table->uclk.num_clk_values = dc_clk_table->num_entries_per_clk.num_memclk_levels;
+		for (i = 0; i < min(DML_MAX_CLK_TABLE_SIZE, MAX_NUM_DPM_LVL); i++) {
+			if (i < dml_clk_table->uclk.num_clk_values) {
+				dml_clk_table->uclk.clk_values_khz[i] = dc_clk_table->entries[i].memclk_mhz * 1000;
+				dml_clk_table->wck_ratio.clk_values_khz[i] = dc_clk_table->entries[i].wck_ratio;
+			} else {
+				dml_clk_table->uclk.clk_values_khz[i] = 0;
+				dml_clk_table->wck_ratio.clk_values_khz[i] = 0;
+			}
+		}
+	}
+
+	/* dispclk */
+	if (dc_clk_table->num_entries_per_clk.num_dispclk_levels) {
+		dml_clk_table->dispclk.num_clk_values = dc_clk_table->num_entries_per_clk.num_dispclk_levels;
+		for (i = 0; i < min(DML_MAX_CLK_TABLE_SIZE, MAX_NUM_DPM_LVL); i++) {
+			if (i < dml_clk_table->dispclk.num_clk_values) {
+				dml_clk_table->dispclk.clk_values_khz[i] = dc_clk_table->entries[i].dispclk_mhz * 1000;
+			} else {
+				dml_clk_table->dispclk.clk_values_khz[i] = 0;
+			}
+		}
+		vmin_limit->dispclk_khz = min(dc_clk_table->entries[0].dispclk_mhz * 1000, vmin_limit->dispclk_khz);
+	}
+
+	/* dppclk */
+	if (dc_clk_table->num_entries_per_clk.num_dppclk_levels) {
+		dml_clk_table->dppclk.num_clk_values = dc_clk_table->num_entries_per_clk.num_dppclk_levels;
+		for (i = 0; i < min(DML_MAX_CLK_TABLE_SIZE, MAX_NUM_DPM_LVL); i++) {
+			if (i < dml_clk_table->dppclk.num_clk_values) {
+				dml_clk_table->dppclk.clk_values_khz[i] = dc_clk_table->entries[i].dppclk_mhz * 1000;
+			} else {
+				dml_clk_table->dppclk.clk_values_khz[i] = 0;
+			}
+		}
+	}
+
+	/* dtbclk */
+	if (dc_clk_table->num_entries_per_clk.num_dtbclk_levels) {
+		dml_clk_table->dtbclk.num_clk_values = dc_clk_table->num_entries_per_clk.num_dtbclk_levels;
+		for (i = 0; i < min(DML_MAX_CLK_TABLE_SIZE, MAX_NUM_DPM_LVL); i++) {
+			if (i < dml_clk_table->dtbclk.num_clk_values) {
+				dml_clk_table->dtbclk.clk_values_khz[i] = dc_clk_table->entries[i].dtbclk_mhz * 1000;
+			} else {
+				dml_clk_table->dtbclk.clk_values_khz[i] = 0;
+			}
+		}
+	}
+
+	/* socclk */
+	if (dc_clk_table->num_entries_per_clk.num_socclk_levels) {
+		dml_clk_table->socclk.num_clk_values = dc_clk_table->num_entries_per_clk.num_socclk_levels;
+		for (i = 0; i < min(DML_MAX_CLK_TABLE_SIZE, MAX_NUM_DPM_LVL); i++) {
+			if (i < dml_clk_table->socclk.num_clk_values) {
+				dml_clk_table->socclk.clk_values_khz[i] = dc_clk_table->entries[i].socclk_mhz * 1000;
+			} else {
+				dml_clk_table->socclk.clk_values_khz[i] = 0;
+			}
+		}
+	}
+
+	/* dram config */
+	dml_clk_table->dram_config.channel_count = dc_bw_params->num_channels;
+	dml_clk_table->dram_config.channel_width_bytes = dc_bw_params->dram_channel_width_bytes;
+}
+
+static void dcn42_update_soc_bb_with_values_from_clk_mgr(struct dml2_soc_bb *soc_bb, const struct dc *dc)
+{
+	soc_bb->dprefclk_mhz = dc->clk_mgr->dprefclk_khz / 1000;
+	soc_bb->dispclk_dppclk_vco_speed_mhz = dc->clk_mgr->dentist_vco_freq_khz / 1000.0;
+	soc_bb->mall_allocated_for_dcn_mbytes = dc->caps.mall_size_total / (1024 * 1024);
+
+	if (dc->clk_mgr->funcs->is_smu_present &&
+			dc->clk_mgr->funcs->is_smu_present(dc->clk_mgr)) {
+		dcn42_convert_dc_clock_table_to_soc_bb_clock_table(&soc_bb->clk_table, &soc_bb->vmin_limit,
+			dc->clk_mgr->bw_params);
+	}
+}
+
+static void apply_soc_bb_updates(struct dml2_soc_bb *soc_bb, const struct dc *dc, const struct dml2_configuration_options *config)
+{
+	/* Individual modification can be overwritten even if it was obtained by a previous function.
+	 * Modifications are acquired in order of priority (lowest to highest).
+	 */
+	dc_assert_fp_enabled();
+
+	dcn42_update_soc_bb_with_values_from_clk_mgr(soc_bb, dc);
+	dcn401_update_soc_bb_with_values_from_vbios(soc_bb, dc);
+	dcn401_update_soc_bb_with_values_from_software_policy(soc_bb, dc);
+}
+
+void dcn42_get_soc_bb(struct dml2_soc_bb *soc_bb, const struct dc *dc, const struct dml2_configuration_options *config)
+{
+	//get default soc_bb with static values
+	get_default_soc_bb(soc_bb);
+	//update soc_bb values with more accurate values
+	apply_soc_bb_updates(soc_bb, dc, config);
+}
+
 static void dcn42_get_ip_caps(struct dml2_ip_capabilities *ip_caps)
 {
 	*ip_caps = dml2_dcn42_max_ip_caps;
 }
 
 static struct soc_and_ip_translator_funcs dcn42_translator_funcs = {
-	.get_soc_bb = dcn401_get_soc_bb,
+	.get_soc_bb = dcn42_get_soc_bb,
 	.get_ip_caps = dcn42_get_ip_caps,
 };
 
@@ -25,3 +181,4 @@ void dcn42_construct_soc_and_ip_translator(struct soc_and_ip_translator *soc_and
 {
 	soc_and_ip_translator->translator_funcs = &dcn42_translator_funcs;
 }
+
diff --git a/drivers/gpu/drm/amd/display/dc/soc_and_ip_translator/dcn42/dcn42_soc_and_ip_translator.h b/drivers/gpu/drm/amd/display/dc/soc_and_ip_translator/dcn42/dcn42_soc_and_ip_translator.h
index 914dcbb369a7..1dded5426152 100644
--- a/drivers/gpu/drm/amd/display/dc/soc_and_ip_translator/dcn42/dcn42_soc_and_ip_translator.h
+++ b/drivers/gpu/drm/amd/display/dc/soc_and_ip_translator/dcn42/dcn42_soc_and_ip_translator.h
@@ -12,5 +12,6 @@
 #include "soc_and_ip_translator.h"
 
 void dcn42_construct_soc_and_ip_translator(struct soc_and_ip_translator *soc_and_ip_translator);
+void dcn42_get_soc_bb(struct dml2_soc_bb *soc_bb, const struct dc *dc, const struct dml2_configuration_options *config);
 
 #endif /* _DCN42_SOC_AND_IP_TRANSLATOR_H_ */
diff --git a/drivers/gpu/drm/amd/display/dc/soc_and_ip_translator/soc_and_ip_translator.c b/drivers/gpu/drm/amd/display/dc/soc_and_ip_translator/soc_and_ip_translator.c
index 0fc0e5a6c171..bc1487d4ebda 100644
--- a/drivers/gpu/drm/amd/display/dc/soc_and_ip_translator/soc_and_ip_translator.c
+++ b/drivers/gpu/drm/amd/display/dc/soc_and_ip_translator/soc_and_ip_translator.c
@@ -4,6 +4,7 @@
 
 #include "soc_and_ip_translator.h"
 #include "soc_and_ip_translator/dcn401/dcn401_soc_and_ip_translator.h"
+#include "soc_and_ip_translator/dcn42/dcn42_soc_and_ip_translator.h"
 
 static void dc_construct_soc_and_ip_translator(struct soc_and_ip_translator *soc_and_ip_translator,
 		enum dce_version dc_version)
@@ -12,6 +13,9 @@ static void dc_construct_soc_and_ip_translator(struct soc_and_ip_translator *soc
 	case DCN_VERSION_4_01:
 		dcn401_construct_soc_and_ip_translator(soc_and_ip_translator);
 		break;
+	case DCN_VERSION_4_2:
+		dcn42_construct_soc_and_ip_translator(soc_and_ip_translator);
+		break;
 	default:
 		break;
 	}
diff --git a/drivers/gpu/drm/amd/include/asic_reg/clk/clk_15_0_0_offset.h b/drivers/gpu/drm/amd/include/asic_reg/clk/clk_15_0_0_offset.h
new file mode 100644
index 000000000000..aa3ef3a34013
--- /dev/null
+++ b/drivers/gpu/drm/amd/include/asic_reg/clk/clk_15_0_0_offset.h
@@ -0,0 +1,44 @@
+/* SPDX-License-Identifier: MIT */
+/* Copyright 2026 Advanced Micro Devices, Inc. */
+
+#ifndef _clk_15_0_0_OFFSET_HEADER
+#define _clk_15_0_0_OFFSET_HEADER
+
+// addressBlock: clk_clk8_0_SmuClkDec
+// base address: 0x6e000
+#define regCLK8_CLK0_DS_CNTL                                                                            0x4c14
+#define regCLK8_CLK0_DS_CNTL_BASE_IDX                                                                   0
+#define regCLK8_CLK1_DS_CNTL                                                                            0x4c1c
+#define regCLK8_CLK1_DS_CNTL_BASE_IDX                                                                   0
+#define regCLK8_CLK2_DS_CNTL                                                                            0x4c24
+#define regCLK8_CLK2_DS_CNTL_BASE_IDX                                                                   0
+#define regCLK8_CLK3_DS_CNTL                                                                            0x4c2c
+#define regCLK8_CLK3_DS_CNTL_BASE_IDX                                                                   0
+#define regCLK8_CLK4_DS_CNTL                                                                            0x4c34
+#define regCLK8_CLK4_DS_CNTL_BASE_IDX                                                                   0
+#define regCLK8_CLK0_BYPASS_CNTL                                                                        0x4c1a
+#define regCLK8_CLK0_BYPASS_CNTL_BASE_IDX                                                               0
+#define regCLK8_CLK1_BYPASS_CNTL                                                                        0x4c22
+#define regCLK8_CLK1_BYPASS_CNTL_BASE_IDX                                                               0
+#define regCLK8_CLK2_BYPASS_CNTL                                                                        0x4c2a
+#define regCLK8_CLK2_BYPASS_CNTL_BASE_IDX                                                               0
+#define regCLK8_CLK3_BYPASS_CNTL                                                                        0x4c32
+#define regCLK8_CLK3_BYPASS_CNTL_BASE_IDX                                                               0
+#define regCLK8_CLK4_BYPASS_CNTL                                                                        0x4c3a
+#define regCLK8_CLK4_BYPASS_CNTL_BASE_IDX                                                               0
+#define regCLK8_CLK_TICK_CNT_CONFIG_REG                                                                 0x4c51
+#define regCLK8_CLK_TICK_CNT_CONFIG_REG_BASE_IDX                                                        0
+#define regCLK8_CLK_TICK_CNT_STATUS                                                                     0x4c52
+#define regCLK8_CLK_TICK_CNT_STATUS_BASE_IDX                                                            0
+#define regCLK8_CLK0_CURRENT_CNT                                                                        0x4c53
+#define regCLK8_CLK0_CURRENT_CNT_BASE_IDX                                                               0
+#define regCLK8_CLK1_CURRENT_CNT                                                                        0x4c54
+#define regCLK8_CLK1_CURRENT_CNT_BASE_IDX                                                               0
+#define regCLK8_CLK2_CURRENT_CNT                                                                        0x4c55
+#define regCLK8_CLK2_CURRENT_CNT_BASE_IDX                                                               0
+#define regCLK8_CLK3_CURRENT_CNT                                                                        0x4c56
+#define regCLK8_CLK3_CURRENT_CNT_BASE_IDX                                                               0
+#define regCLK8_CLK4_CURRENT_CNT                                                                        0x4c57
+#define regCLK8_CLK4_CURRENT_CNT_BASE_IDX                                                               0
+
+#endif
diff --git a/drivers/gpu/drm/amd/include/asic_reg/clk/clk_15_0_0_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/clk/clk_15_0_0_sh_mask.h
new file mode 100644
index 000000000000..c78622d06e1b
--- /dev/null
+++ b/drivers/gpu/drm/amd/include/asic_reg/clk/clk_15_0_0_sh_mask.h
@@ -0,0 +1,52 @@
+/* SPDX-License-Identifier: MIT */
+/* Copyright 2026 Advanced Micro Devices, Inc. */
+
+#ifndef _clk_15_0_0_SH_MASK_HEADER
+#define _clk_15_0_0_SH_MASK_HEADER
+
+// addressBlock: clk_clk8_0_SmuClkDec
+//CLK8_CLK_TICK_CNT_CONFIG_REG
+#define CLK8_CLK_TICK_CNT_CONFIG_REG__TIMER_THRESHOLD__SHIFT                                                   0x0
+#define CLK8_CLK_TICK_CNT_CONFIG_REG__TIMER_THRESHOLD_MASK                                                     0xFFFFL
+//CLK8_CLK0_BYPASS_CNTL
+#define CLK8_CLK0_BYPASS_CNTL__CLK0_BYPASS_SEL__SHIFT                                                         0x0
+#define CLK8_CLK0_BYPASS_CNTL__CLK0_BYPASS_SEL_MASK                                                           0x00000007L
+//CLK8_CLK1_BYPASS_CNTL
+#define CLK8_CLK1_BYPASS_CNTL__CLK1_BYPASS_SEL__SHIFT                                                         0x0
+#define CLK8_CLK1_BYPASS_CNTL__CLK1_BYPASS_SEL_MASK                                                           0x00000007L
+//CLK8_CLK2_BYPASS_CNTL
+#define CLK8_CLK2_BYPASS_CNTL__CLK2_BYPASS_SEL__SHIFT                                                         0x0
+#define CLK8_CLK2_BYPASS_CNTL__CLK2_BYPASS_SEL_MASK                                                           0x00000007L
+//CLK8_CLK3_BYPASS_CNTL
+#define CLK8_CLK3_BYPASS_CNTL__CLK3_BYPASS_SEL__SHIFT                                                         0x0
+#define CLK8_CLK3_BYPASS_CNTL__CLK3_BYPASS_SEL_MASK                                                           0x00000007L
+//CLK8_CLK4_BYPASS_CNTL
+#define CLK8_CLK4_BYPASS_CNTL__CLK4_BYPASS_SEL__SHIFT                                                         0x0
+#define CLK8_CLK4_BYPASS_CNTL__CLK4_BYPASS_SEL_MASK                                                           0x00000007L
+//CLK8_CLK0_DS_CNTL
+#define CLK8_CLK0_DS_CNTL__CLK0_DS_DIV_ID__SHIFT                                                              0x0
+#define CLK8_CLK0_DS_CNTL__CLK0_DS_DIV_ID_MASK                                                                0x0000000FL
+#define CLK8_CLK0_DS_CNTL__CLK0_ALLOW_DS__SHIFT                                                              0x4
+#define CLK8_CLK0_DS_CNTL__CLK0_ALLOW_DS_MASK                                                                0x00000010L
+//CLK8_CLK1_DS_CNTL
+#define CLK8_CLK1_DS_CNTL__CLK1_DS_DIV_ID__SHIFT                                                              0x0
+#define CLK8_CLK1_DS_CNTL__CLK1_DS_DIV_ID_MASK                                                                0x0000000FL
+#define CLK8_CLK1_DS_CNTL__CLK1_ALLOW_DS__SHIFT                                                              0x4
+#define CLK8_CLK1_DS_CNTL__CLK1_ALLOW_DS_MASK                                                                0x00000010L
+//CLK8_CLK2_DS_CNTL
+#define CLK8_CLK2_DS_CNTL__CLK2_DS_DIV_ID__SHIFT                                                              0x0
+#define CLK8_CLK2_DS_CNTL__CLK2_DS_DIV_ID_MASK                                                                0x0000000FL
+#define CLK8_CLK2_DS_CNTL__CLK2_ALLOW_DS__SHIFT                                                              0x4
+#define CLK8_CLK2_DS_CNTL__CLK2_ALLOW_DS_MASK                                                                0x00000010L
+//CLK8_CLK3_DS_CNTL
+#define CLK8_CLK3_DS_CNTL__CLK3_DS_DIV_ID__SHIFT                                                              0x0
+#define CLK8_CLK3_DS_CNTL__CLK3_DS_DIV_ID_MASK                                                                0x0000000FL
+#define CLK8_CLK3_DS_CNTL__CLK3_ALLOW_DS__SHIFT                                                              0x4
+#define CLK8_CLK3_DS_CNTL__CLK3_ALLOW_DS_MASK                                                                0x00000010L
+//CLK8_CLK4_DS_CNTL
+#define CLK8_CLK4_DS_CNTL__CLK4_DS_DIV_ID__SHIFT                                                              0x0
+#define CLK8_CLK4_DS_CNTL__CLK4_DS_DIV_ID_MASK                                                                0x0000000FL
+#define CLK8_CLK4_DS_CNTL__CLK4_ALLOW_DS__SHIFT                                                              0x4
+#define CLK8_CLK4_DS_CNTL__CLK4_ALLOW_DS_MASK                                                                0x00000010L
+
+#endif
-- 
2.43.0

