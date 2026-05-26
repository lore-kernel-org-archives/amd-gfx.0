Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7FE8CD5BCF
	for <amd-gfx@archiver.kernel.org>; Tue, 26 May 2026 07:20:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 722C610E50E;
	Tue, 26 May 2026 07:20:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="S2UhGIY8";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010036.outbound.protection.outlook.com [52.101.46.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2136D10E50E
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 May 2026 07:20:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZmT54dn7+m9cVfl3VUCSIwj+yo2XocW7xNZb+Qx+98Gg74vZ87UkYCRF2GzfmD4odj8Tw0K3jI6OGiEothcFFsSnViHu7zxytIzbX2XGiEVDlZZy/fbW9F0BbA3Od12Yq/Ptbs0IOIKHQHayOpqTp3CaL0/tplC9NnLgW7pCQxfm1S702kykYxORg0OMKU3JiLYapuHyNMRX6oNdRL2I9747ilEzpdLOCfMrV3l6TjI1R16ThWVjU5MXzHrh/YJqAsnku4CNEAZq+HBvU0kTryoX5aLC2KHY+ISmXF7aq0hTEPcOEGb5Hq7vtTHc1fG0zHzs9bhnw7y5B30YGofBxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cg75gGSLcOW8ZxlaD478YsBIDeoptmwKtwFLwukMduo=;
 b=MHgXjtPx0XffdonjpegcwuE4X1Zk8Ju/g+17QIxeNoQDnV5P2yhLrHiD7jBDfY6Kzo1aVlupcP+BLInh5skE2EDG9Luz0IAXiy6Mc4cvXlFWHXT4qAeOhDIiM/KUjIRHwK63w5S3PWpxZ/QdUzL5QVLRGicmSAMPH8BxgPrFIQfjRayVRhb62On3d3XOKuEu3hO3mgqaviLnYlofUvIsbnVqwDvKGk8jRAatRi0QrR5OwrpCFcm6JXfav8A7Y/LKVomv1WQEybwQPP2L8iaS8icrU5BxlR9zoBEkJPOXalsN3ButYvhV+6/fKuFt9RicLzeYeRpV+HYjAP1yhFq14w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cg75gGSLcOW8ZxlaD478YsBIDeoptmwKtwFLwukMduo=;
 b=S2UhGIY8Nibhn40mPIoCoNOQyI6uhCnkqUfyk5NTfkrGa/zYS12eOSifQa40RvhfswhmdFk9zCfSXlM7ZYurbVdYjIEMn8dQxASFutKEx8PA8i8cei4mEIknlB/FM4aGGYa2JKwe591WKddBgLL6WSKVMLegcJgu3cS4HICMc+M=
Received: from BL1PR13CA0384.namprd13.prod.outlook.com (2603:10b6:208:2c0::29)
 by DM6PR12MB4354.namprd12.prod.outlook.com (2603:10b6:5:28f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Tue, 26 May
 2026 07:20:13 +0000
Received: from BL02EPF0001A107.namprd05.prod.outlook.com
 (2603:10b6:208:2c0:cafe::65) by BL1PR13CA0384.outlook.office365.com
 (2603:10b6:208:2c0::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.11 via Frontend Transport; Tue, 26
 May 2026 07:20:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL02EPF0001A107.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Tue, 26 May 2026 07:20:13 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.41; Tue, 26 May
 2026 02:20:07 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 26 May
 2026 02:20:06 -0500
Received: from ray-Ubuntu.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Tue, 26 May 2026 02:19:52 -0500
From: Ray Wu <ray.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Matthew Stewart <matthew.stewart2@amd.com>, "Matthew
 Stewart" <Matthew.Stewart2@amd.com>, Ray Wu <ray.wu@amd.com>
Subject: [PATCH 36/41] drm/amd/display: Add DCN42B code to DC
Date: Tue, 26 May 2026 15:01:59 +0800
Message-ID: <20260526071413.2181251-37-ray.wu@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260526071413.2181251-1-ray.wu@amd.com>
References: <20260526071413.2181251-1-ray.wu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: ray.wu@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A107:EE_|DM6PR12MB4354:EE_
X-MS-Office365-Filtering-Correlation-Id: 988452fd-d636-4fdb-bdcc-08debaf73aa0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|376014|3023799007|5023799004|6133799003|11063799006|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: m4P59pHrsiKxKwS0zJeAqWYiy9F1ql572chvZQxzdi/UYO5XPdmgDX7tvKxkl9PXaRIxCTwSCdzy7WFlF6uIneDgMHxkDoOwpj/vn4MIyivITLwyVDaarut0kvr/n0R3Iuh2oJv6nt15+AXk6LG7cTOscDQjB3SBMawhy5ujLNe3dmfTDXzBaRTLNJhylkJujqWQZSrq1NUpwEmv1fXklxhgA+4eHUhhsCXPL6d2hzSNhFCBQCMRyWxRA3vcc2g4BEJBTiYu+oipBsaHpfNX3myZm+c371K6X6WAm8aj+kqVVhbhKBpF7TKwB4WwSsFCRSX2J5iIUJiDoA5FErEgFkJGdm7DMVSiHQeh1yHtWs7S8yb9lNklb2dYxwoicl1Id730HU6+h3ZJwi6TpbI5HJBpAo1CwAiyyj3BEZI1IRvEg6W5qjwCQxdEfu9Am0oZXUFFvZOSmIhhhX/iYt3lLBxz1FmCqeLSNjEvfZ6KumqyVaBsjw23aJrCo+Q/B3K3RCaOsHR9lOBWlyW3p+5SDWj6hxw+uWo4XGffTFDVDrEHNIHErVaeYn4A+q74y/Xio/IDMl179yrlNClSLzToaS2n0zSClgWUMQ0diOMk21ZCjh2yAciCohu0MormXYObDPn9+TrNrRk1EwUk16lZs1kx3BArfoTQJdbV69FgjWyb/B2P2x7qCQsoNF9B1CuAbA72srBz8t+lEQFrhdSRbf23fmsSp5hrldePdVFJwrE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(3023799007)(5023799004)(6133799003)(11063799006)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ZLMjRU3Vg3Tk0fzaloXY/PzHQMz/Bue0BPPPVYDV8hBLAqPgCmG0ZT5vn3l/woL3kVAdPRJW2Fo+LkEIrQVmksLo+bOWW/BelkpUB/46iamgenxC1aLpP7CywiaD883j8kLgiSzTdcBk5pDYJPuHwF2/JGSekrWDdp/G1dyn7cP7FaMb6fqiHaQzW/BJ63pNXHsJYHbqCPSASuGe4FIXa/blYH6oXSnjCtdUrFW4slE5q09sTkD5JTLMk3PgYiQeVeSFLM9Dwvs5237iuICqDALukKoDtK+VCeTeY6Vu4kKd++7TFA84BxTl8dNn0mZB+sKL0A6TWKL3tjfgyLNUvHuq8VTFU+l8uZjEe8FAIi7MU4jTi6kaHk8+uNTET9cbSoYDNNKh/joctr0HCGybL6WVKVsom8SjGJsIjvqBAr3J1NmUuQkZQbiNFsNVseX0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 07:20:13.6054 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 988452fd-d636-4fdb-bdcc-08debaf73aa0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A107.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4354
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

From: Matthew Stewart <matthew.stewart2@amd.com>

[Why & How]
Add DCN42B code to DC

Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Matthew Stewart <Matthew.Stewart2@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
---
 .../display/dc/bios/command_table_helper2.c   |   1 +
 .../gpu/drm/amd/display/dc/clk_mgr/Makefile   |  10 +
 .../gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c  |  15 ++
 .../gpu/drm/amd/display/dc/core/dc_resource.c |   6 +
 drivers/gpu/drm/amd/display/dc/dc_helper.c    |   2 +
 .../gpu/drm/amd/display/dc/dc_spl_translate.c |   1 +
 .../gpu/drm/amd/display/dc/dcn31/dcn31_apg.h  |  13 ++
 .../dc/dio/dcn42/dcn42_dio_link_encoder.h     |  95 +++++++++
 drivers/gpu/drm/amd/display/dc/gpio/Makefile  |   8 +
 .../gpu/drm/amd/display/dc/gpio/hw_factory.c  |   4 +
 .../drm/amd/display/dc/gpio/hw_translate.c    |   4 +
 .../hpo/dcn31/dcn31_hpo_dp_stream_encoder.h   |  47 +++++
 .../display/dc/hubbub/dcn35/dcn35_hubbub.h    | 198 ++++++++++++++++++
 .../amd/display/dc/hubp/dcn42/dcn42_hubp.h    |  19 ++
 drivers/gpu/drm/amd/display/dc/hwss/Makefile  |   8 +
 .../gpu/drm/amd/display/dc/inc/hw/clk_mgr.h   |  21 ++
 .../amd/display/dc/inc/hw/clk_mgr_internal.h  |  33 ++-
 drivers/gpu/drm/amd/display/dc/inc/resource.h |   2 +
 .../amd/display/dc/optc/dcn42/dcn42_optc.h    | 179 ++++++++++++++++
 .../amd/display/dc/pg/dcn42/dcn42_pg_cntl.h   |  86 ++++++++
 .../gpu/drm/amd/display/dc/resource/Makefile  |   7 +
 .../dcn42/dcn42_soc_and_ip_translator.c       |   6 +-
 .../soc_and_ip_translator.c                   |   1 +
 .../gpu/drm/amd/display/include/dal_asic_id.h |   3 +
 .../gpu/drm/amd/display/include/dal_types.h   |   1 +
 25 files changed, 768 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/bios/command_table_helper2.c b/drivers/gpu/drm/amd/display/dc/bios/command_table_helper2.c
index a93a8860535a..902f06ac43c6 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/command_table_helper2.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/command_table_helper2.c
@@ -85,6 +85,7 @@ bool dal_bios_parser_init_cmd_tbl_helper2(
 	case DCN_VERSION_3_6:
 	case DCN_VERSION_4_01:
 	case DCN_VERSION_4_2:
+	case DCN_VERSION_4_2B:
 		*h = dal_cmd_tbl_helper_dce112_get_table2();
 		return true;
 
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/Makefile b/drivers/gpu/drm/amd/display/dc/clk_mgr/Makefile
index 98911ef56c2e..fb234a729bdc 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/Makefile
@@ -185,4 +185,14 @@ CLK_MGR_DCN42 = dcn42_smu.o dcn42_clk_mgr.o
 AMD_DAL_CLK_MGR_DCN42 = $(addprefix $(AMDDALPATH)/dc/clk_mgr/dcn42/,$(CLK_MGR_DCN42))
 
 AMD_DISPLAY_FILES += $(AMD_DAL_CLK_MGR_DCN42)
+
+###############################################################################
+# DCN42B
+###############################################################################
+CLK_MGR_DCN42B = dcn42b_clk_mgr.o
+
+AMD_DAL_CLK_MGR_DCN42B = $(addprefix $(AMDDALPATH)/dc/clk_mgr/dcn42b/,$(CLK_MGR_DCN42B))
+
+AMD_DISPLAY_FILES += $(AMD_DAL_CLK_MGR_DCN42B)
+
 endif
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
index 0340f6b9f157..5f9a6bb84324 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
@@ -49,6 +49,7 @@
 #include "dcn35/dcn35_clk_mgr.h"
 #include "dcn401/dcn401_clk_mgr.h"
 #include "dcn42/dcn42_clk_mgr.h"
+#include "dcn42b/dcn42b_clk_mgr.h"
 
 int clk_mgr_helper_get_active_display_cnt(
 		struct dc *dc,
@@ -338,6 +339,16 @@ struct clk_mgr *dc_clk_mgr_create(struct dc_context *ctx, struct pp_smu_funcs *p
 	break;
 
 	case AMDGPU_FAMILY_GC_11_5_0: {
+		if (ctx->dce_version == DCN_VERSION_4_2B) {
+			struct clk_mgr_dcn42 *clk_mgr = kzalloc(sizeof(*clk_mgr), GFP_KERNEL);
+
+			if (clk_mgr == NULL) {
+				BREAK_TO_DEBUGGER();
+				return NULL;
+			}
+			dcn42b_clk_mgr_construct(ctx, clk_mgr, pp_smu, dccg);
+			return &clk_mgr->base.base;
+		}
 		struct clk_mgr_dcn35 *clk_mgr = kzalloc(sizeof(*clk_mgr), GFP_KERNEL);
 
 		if (clk_mgr == NULL) {
@@ -428,6 +439,10 @@ void dc_destroy_clk_mgr(struct clk_mgr *clk_mgr_base)
 		break;
 
 	case AMDGPU_FAMILY_GC_11_5_0:
+		if (clk_mgr_base->ctx->dce_version == DCN_VERSION_4_2B) {
+			dcn42_clk_mgr_destroy(clk_mgr);
+			break;
+		}
 		dcn35_clk_mgr_destroy(clk_mgr);
 		break;
 	case AMDGPU_FAMILY_GC_12_0_0:
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index f57e9d85563e..e727f8c7a549 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -79,6 +79,7 @@
 #include "dcn36/dcn36_resource.h"
 #include "dcn401/dcn401_resource.h"
 #include "dcn42/dcn42_resource.h"
+#include "dcn42b/dcn42b_resource.h"
 #if defined(CONFIG_DRM_AMD_DC_FP)
 #include "dc_spl_translate.h"
 #endif
@@ -243,6 +244,8 @@ enum dce_version resource_parse_asic_id(struct hw_asic_id asic_id)
 		break;
 	case AMDGPU_FAMILY_GC_11_5_0:
 		dc_version = DCN_VERSION_3_5;
+		if (ASICREV_IS_DCN4A_SOC_VAR_B(asic_id.hw_internal_rev))
+			dc_version = DCN_VERSION_4_2B;
 		if (ASICREV_IS_GC_11_0_4(asic_id.hw_internal_rev))
 			dc_version = DCN_VERSION_3_51;
 		if (ASICREV_IS_DCN36(asic_id.hw_internal_rev))
@@ -375,6 +378,9 @@ struct resource_pool *dc_create_resource_pool(struct dc  *dc,
 	case DCN_VERSION_4_2:
 		res_pool = dcn42_create_resource_pool(init_data, dc);
 		break;
+	case DCN_VERSION_4_2B:
+		res_pool = dcn42b_create_resource_pool(init_data, dc);
+		break;
 #endif /* CONFIG_DRM_AMD_DC_FP */
 	default:
 		break;
diff --git a/drivers/gpu/drm/amd/display/dc/dc_helper.c b/drivers/gpu/drm/amd/display/dc/dc_helper.c
index 9650cccf1b8d..0e0165764a57 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_helper.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_helper.c
@@ -754,6 +754,8 @@ char *dce_version_to_string(const int version)
 		return "DCN 4.0.1";
 	case DCN_VERSION_4_2:
 		return "DCN 4.2";
+	case DCN_VERSION_4_2B:
+		return "DCN 4.2B";
 	default:
 		return "Unknown";
 	}
diff --git a/drivers/gpu/drm/amd/display/dc/dc_spl_translate.c b/drivers/gpu/drm/amd/display/dc/dc_spl_translate.c
index 52ed8deebf63..bc55f10fba7c 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_spl_translate.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_spl_translate.c
@@ -91,6 +91,7 @@ void translate_SPL_in_params_from_pipe_ctx(struct pipe_ctx *pipe_ctx, struct spl
 		break;
 	case DCN_VERSION_4_01:
 	case DCN_VERSION_4_2:
+	case DCN_VERSION_4_2B:
 		spl_in->callbacks = dcn401_spl_callbacks;
 		break;
 	default:
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_apg.h b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_apg.h
index 1b81f6773c53..fbcaad4334dd 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_apg.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_apg.h
@@ -60,6 +60,19 @@ struct dcn31_apg_registers {
 		type APG_DBG_AUDIO_CHANNEL_ENABLE;\
 		type APG_MEM_PWR_FORCE
 
+//APG0_APG_DBG_GEN_CONTROL
+#define APG0_APG_DBG_GEN_CONTROL__APG_DBG_AUDIO_CHANNEL_ENABLE__SHIFT                                         0x8
+#define APG0_APG_DBG_GEN_CONTROL__APG_DBG_AUDIO_CHANNEL_ENABLE_MASK                                           0x0000FF00L
+
+/* Not in DCN42B: APG_DBG_GEN_CONTROL, APG0_APG_DBG_60958 */
+#define DCN42B_APG_MASK_SH_LIST(mask_sh)\
+	SE_SF(APG0_APG_CONTROL, APG_RESET, mask_sh),\
+	SE_SF(APG0_APG_CONTROL, APG_RESET_DONE, mask_sh),\
+	SE_SF(APG0_APG_CONTROL2, APG_ENABLE, mask_sh),\
+	SE_SF(APG0_APG_CONTROL2, APG_DP_AUDIO_STREAM_ID, mask_sh),\
+	SE_SF(APG0_APG_MEM_PWR, APG_MEM_PWR_FORCE, mask_sh),\
+	SE_SF(APG0_APG_DBG_GEN_CONTROL, APG_DBG_AUDIO_CHANNEL_ENABLE, mask_sh)
+
 struct dcn31_apg_shift {
 	APG_DCN31_REG_FIELD_LIST(uint8_t);
 };
diff --git a/drivers/gpu/drm/amd/display/dc/dio/dcn42/dcn42_dio_link_encoder.h b/drivers/gpu/drm/amd/display/dc/dio/dcn42/dcn42_dio_link_encoder.h
index 9c607b24ec1c..bd9c071c2a9f 100644
--- a/drivers/gpu/drm/amd/display/dc/dio/dcn42/dcn42_dio_link_encoder.h
+++ b/drivers/gpu/drm/amd/display/dc/dio/dcn42/dcn42_dio_link_encoder.h
@@ -122,6 +122,101 @@
 	LE_SF(DIO_CLK_CNTL, SYMCLKD_G_HDCP_GATE_DIS, mask_sh),\
 	LE_SF(DIO_CLK_CNTL, SYMCLKE_G_HDCP_GATE_DIS, mask_sh),\
 
+#define LINK_ENCODER_MASK_SH_LIST_DCN42B(mask_sh) \
+	LE_SF(DIG0_DIG_BE_EN_CNTL, DIG_BE_ENABLE, mask_sh),\
+	LE_SF(DIG0_DIG_BE_CNTL, DIG_RB_SWITCH_EN, mask_sh),\
+	LE_SF(DIG0_DIG_BE_CNTL, DIG_HPD_SELECT, mask_sh),\
+	LE_SF(DIG0_DIG_BE_CNTL, DIG_FE_SOURCE_SELECT, mask_sh),\
+	LE_SF(DIG0_DIG_BE_CLK_CNTL, DIG_BE_MODE, mask_sh),\
+	LE_SF(DIG0_DIG_BE_CLK_CNTL, DIG_BE_CLK_EN, mask_sh),\
+	LE_SF(DIG0_DIG_BE_CLK_CNTL, DIG_BE_SOFT_RESET, mask_sh),\
+	LE_SF(DIG0_DIG_BE_CLK_CNTL, HDCP_SOFT_RESET, mask_sh),\
+	LE_SF(DIG0_DIG_BE_CLK_CNTL, DIG_BE_SYMCLK_G_CLOCK_ON, mask_sh),\
+	LE_SF(DIG0_DIG_BE_CLK_CNTL, DIG_BE_SYMCLK_G_HDCP_CLOCK_ON, mask_sh),\
+	LE_SF(DIG0_DIG_BE_CLK_CNTL, DIG_BE_SYMCLK_G_TMDS_CLOCK_ON, mask_sh),\
+	LE_SF(DIG0_DIG_CLOCK_PATTERN, DIG_CLOCK_PATTERN, mask_sh),\
+	LE_SF(DIG0_TMDS_CTL_BITS, TMDS_CTL0, mask_sh), \
+	LE_SF(DP0_DP_DPHY_CNTL, DPHY_BYPASS, mask_sh),\
+	LE_SF(DP0_DP_DPHY_CNTL, DPHY_ATEST_SEL_LANE0, mask_sh),\
+	LE_SF(DP0_DP_DPHY_CNTL, DPHY_ATEST_SEL_LANE1, mask_sh),\
+	LE_SF(DP0_DP_DPHY_CNTL, DPHY_ATEST_SEL_LANE2, mask_sh),\
+	LE_SF(DP0_DP_DPHY_CNTL, DPHY_ATEST_SEL_LANE3, mask_sh),\
+	LE_SF(DP0_DP_DPHY_PRBS_CNTL, DPHY_PRBS_EN, mask_sh),\
+	LE_SF(DP0_DP_DPHY_PRBS_CNTL, DPHY_PRBS_SEL, mask_sh),\
+	LE_SF(DP0_DP_DPHY_SYM0, DPHY_SYM1, mask_sh),\
+	LE_SF(DP0_DP_DPHY_SYM0, DPHY_SYM2, mask_sh),\
+	LE_SF(DP0_DP_DPHY_SYM0, DPHY_SYM3, mask_sh),\
+	LE_SF(DP0_DP_DPHY_SYM1, DPHY_SYM4, mask_sh),\
+	LE_SF(DP0_DP_DPHY_SYM1, DPHY_SYM5, mask_sh),\
+	LE_SF(DP0_DP_DPHY_SYM1, DPHY_SYM6, mask_sh),\
+	LE_SF(DP0_DP_DPHY_SYM2, DPHY_SYM7, mask_sh),\
+	LE_SF(DP0_DP_DPHY_SYM2, DPHY_SYM8, mask_sh),\
+	LE_SF(DP0_DP_DPHY_SCRAM_CNTL, DPHY_SCRAMBLER_BS_COUNT, mask_sh),\
+	LE_SF(DP0_DP_DPHY_SCRAM_CNTL, DPHY_SCRAMBLER_ADVANCE, mask_sh),\
+	LE_SF(DP0_DP_DPHY_FAST_TRAINING, DPHY_RX_FAST_TRAINING_CAPABLE, mask_sh),\
+	LE_SF(DP0_DP_DPHY_BS_SR_SWAP_CNTL, DPHY_LOAD_BS_COUNT, mask_sh),\
+	LE_SF(DP0_DP_DPHY_TRAINING_PATTERN_SEL, DPHY_TRAINING_PATTERN_SEL, mask_sh),\
+	LE_SF(DP0_DP_DPHY_HBR2_PATTERN_CONTROL, DP_DPHY_HBR2_PATTERN_CONTROL, mask_sh),\
+	LE_SF(DP0_DP_LINK_CNTL, DP_LINK_TRAINING_COMPLETE, mask_sh),\
+	LE_SF(DP0_DP_LINK_FRAMING_CNTL, DP_IDLE_BS_INTERVAL, mask_sh),\
+	LE_SF(DP0_DP_LINK_FRAMING_CNTL, DP_VBID_DISABLE, mask_sh),\
+	LE_SF(DP0_DP_LINK_FRAMING_CNTL, DP_VID_ENHANCED_FRAME_MODE, mask_sh),\
+	LE_SF(DP0_DP_VID_STREAM_CNTL, DP_VID_STREAM_ENABLE, mask_sh),\
+	LE_SF(DP0_DP_CONFIG, DP_UDI_LANES, mask_sh),\
+	LE_SF(DP0_DP_SEC_CNTL1, DP_SEC_GSP0_LINE_NUM, mask_sh),\
+	LE_SF(DP0_DP_SEC_CNTL1, DP_SEC_GSP0_PRIORITY, mask_sh),\
+	LE_SF(DP0_DP_MSE_SAT0, DP_MSE_SAT_SRC0, mask_sh),\
+	LE_SF(DP0_DP_MSE_SAT0, DP_MSE_SAT_SRC1, mask_sh),\
+	LE_SF(DP0_DP_MSE_SAT0, DP_MSE_SAT_SLOT_COUNT0, mask_sh),\
+	LE_SF(DP0_DP_MSE_SAT0, DP_MSE_SAT_SLOT_COUNT1, mask_sh),\
+	LE_SF(DP0_DP_MSE_SAT1, DP_MSE_SAT_SRC2, mask_sh),\
+	LE_SF(DP0_DP_MSE_SAT1, DP_MSE_SAT_SRC3, mask_sh),\
+	LE_SF(DP0_DP_MSE_SAT1, DP_MSE_SAT_SLOT_COUNT2, mask_sh),\
+	LE_SF(DP0_DP_MSE_SAT1, DP_MSE_SAT_SLOT_COUNT3, mask_sh),\
+	LE_SF(DP0_DP_MSE_SAT_UPDATE, DP_MSE_SAT_UPDATE, mask_sh),\
+	LE_SF(DP0_DP_MSE_SAT_UPDATE, DP_MSE_16_MTP_KEEPOUT, mask_sh),\
+	LE_SF(DP_AUX0_AUX_CONTROL, AUX_HPD_SEL, mask_sh),\
+	LE_SF(DP_AUX0_AUX_CONTROL, AUX_LS_READ_EN, mask_sh),\
+	LE_SF(DP_AUX0_AUX_DPHY_RX_CONTROL0, AUX_RX_RECEIVE_WINDOW, mask_sh),\
+	LE_SF(HPD0_DC_HPD_CONTROL, DC_HPD_EN, mask_sh),\
+	LE_SF(HPD0_DC_HPD_INT_STATUS, DC_HPD_SENSE, mask_sh),\
+	LE_SF(HPD0_DC_HPD_TOGGLE_FILT_CNTL, DC_HPD_CONNECT_INT_DELAY, mask_sh),\
+	LE_SF(HPD0_DC_HPD_TOGGLE_FILT_CNTL, DC_HPD_DISCONNECT_INT_DELAY, mask_sh),\
+	LE_SF(DP0_DP_DPHY_CNTL, DPHY_FEC_EN, mask_sh),\
+	LE_SF(DP0_DP_DPHY_CNTL, DPHY_FEC_READY_SHADOW, mask_sh),\
+	LE_SF(DP0_DP_DPHY_CNTL, DPHY_FEC_ACTIVE_STATUS, mask_sh),\
+	LE_SF(DIG0_TMDS_CTL_BITS, TMDS_CTL0, mask_sh), \
+	LE_SF(DP_AUX0_AUX_DPHY_RX_CONTROL0, AUX_RX_START_WINDOW, mask_sh),\
+	LE_SF(DP_AUX0_AUX_DPHY_RX_CONTROL0, AUX_RX_HALF_SYM_DETECT_LEN, mask_sh),\
+	LE_SF(DP_AUX0_AUX_DPHY_RX_CONTROL0, AUX_RX_TRANSITION_FILTER_EN, mask_sh),\
+	LE_SF(DP_AUX0_AUX_DPHY_RX_CONTROL0, AUX_RX_ALLOW_BELOW_THRESHOLD_PHASE_DETECT, mask_sh),\
+	LE_SF(DP_AUX0_AUX_DPHY_RX_CONTROL0, AUX_RX_ALLOW_BELOW_THRESHOLD_START, mask_sh),\
+	LE_SF(DP_AUX0_AUX_DPHY_RX_CONTROL0, AUX_RX_ALLOW_BELOW_THRESHOLD_STOP, mask_sh),\
+	LE_SF(DP_AUX0_AUX_DPHY_RX_CONTROL0, AUX_RX_PHASE_DETECT_LEN, mask_sh),\
+	LE_SF(DP_AUX0_AUX_DPHY_RX_CONTROL0, AUX_RX_DETECTION_THRESHOLD, mask_sh), \
+	LE_SF(DP_AUX0_AUX_DPHY_TX_CONTROL, AUX_TX_PRECHARGE_LEN, mask_sh),\
+	LE_SF(DP_AUX0_AUX_DPHY_TX_CONTROL, AUX_TX_PRECHARGE_SYMBOLS, mask_sh),\
+	LE_SF(DP_AUX0_AUX_DPHY_TX_CONTROL, AUX_MODE_DET_CHECK_DELAY, mask_sh),\
+	LE_SF(DP_AUX0_AUX_DPHY_RX_CONTROL1, AUX_RX_PRECHARGE_SKIP, mask_sh),\
+	LE_SF(DP_AUX0_AUX_DPHY_RX_CONTROL1, AUX_RX_TIMEOUT_LEN, mask_sh),\
+	LE_SF(DP_AUX0_AUX_DPHY_RX_CONTROL1, AUX_RX_TIMEOUT_LEN_MUL, mask_sh),\
+	LE_SF(DIO_CLK_CNTL, DISPCLK_R_GATE_DIS, mask_sh),\
+	LE_SF(DIO_CLK_CNTL, DISPCLK_G_GATE_DIS, mask_sh),\
+	LE_SF(DIO_CLK_CNTL, REFCLK_R_GATE_DIS, mask_sh),\
+	LE_SF(DIO_CLK_CNTL, REFCLK_G_GATE_DIS, mask_sh),\
+	LE_SF(DIO_CLK_CNTL, SOCCLK_G_GATE_DIS, mask_sh),\
+	LE_SF(DIO_CLK_CNTL, SYMCLK_FE_R_GATE_DIS, mask_sh),\
+	LE_SF(DIO_CLK_CNTL, SYMCLK_FE_G_GATE_DIS, mask_sh),\
+	LE_SF(DIO_CLK_CNTL, SYMCLK_R_GATE_DIS, mask_sh),\
+	LE_SF(DIO_CLK_CNTL, SYMCLK_G_GATE_DIS, mask_sh),\
+	LE_SF(DIO_CLK_CNTL, DIO_FGCG_REP_DIS, mask_sh),\
+	LE_SF(DIO_CLK_CNTL, DISPCLK_G_HDCP_GATE_DIS, mask_sh),\
+	LE_SF(DIO_CLK_CNTL, SYMCLKA_G_HDCP_GATE_DIS, mask_sh),\
+	LE_SF(DIO_CLK_CNTL, SYMCLKB_G_HDCP_GATE_DIS, mask_sh),\
+	LE_SF(DIO_CLK_CNTL, SYMCLKC_G_HDCP_GATE_DIS, mask_sh),\
+	LE_SF(DIO_CLK_CNTL, SYMCLKD_G_HDCP_GATE_DIS, mask_sh),\
+	LE_SF(DIO_CLK_CNTL, SYMCLKE_G_HDCP_GATE_DIS, mask_sh)
+
 void dcn42_link_encoder_construct(
 	struct dcn20_link_encoder *enc20,
 	const struct encoder_init_data *init_data,
diff --git a/drivers/gpu/drm/amd/display/dc/gpio/Makefile b/drivers/gpu/drm/amd/display/dc/gpio/Makefile
index f8142ebf363f..3a860b016b7a 100644
--- a/drivers/gpu/drm/amd/display/dc/gpio/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/gpio/Makefile
@@ -142,4 +142,12 @@ AMD_DAL_GPIO_DCN42 = $(addprefix $(AMDDALPATH)/dc/gpio/dcn42/,$(GPIO_DCN42))
 
 AMD_DISPLAY_FILES += $(AMD_DAL_GPIO_DCN42)
 
+###############################################################################
+# DCN 4.2B
+###############################################################################
+
+GPIO_DCN42B = hw_translate_dcn42b.o hw_factory_dcn42b.o
+
+AMD_DAL_GPIO_DCN42B = $(addprefix $(AMDDALPATH)/dc/gpio/dcn42b/,$(GPIO_DCN42B))
 
+AMD_DISPLAY_FILES += $(AMD_DAL_GPIO_DCN42B)
diff --git a/drivers/gpu/drm/amd/display/dc/gpio/hw_factory.c b/drivers/gpu/drm/amd/display/dc/gpio/hw_factory.c
index d81a71ac00d2..a907f7d0628b 100644
--- a/drivers/gpu/drm/amd/display/dc/gpio/hw_factory.c
+++ b/drivers/gpu/drm/amd/display/dc/gpio/hw_factory.c
@@ -54,6 +54,7 @@
 #include "dcn32/hw_factory_dcn32.h"
 #include "dcn401/hw_factory_dcn401.h"
 #include "dcn42/hw_factory_dcn42.h"
+#include "dcn42b/hw_factory_dcn42b.h"
 
 bool dal_hw_factory_init(
 	struct hw_factory *factory,
@@ -123,6 +124,9 @@ bool dal_hw_factory_init(
 	case DCN_VERSION_4_2:
 		dal_hw_factory_dcn42_init(factory);
 		return true;
+	case DCN_VERSION_4_2B:
+		dal_hw_factory_dcn42b_init(factory);
+		return true;
 	default:
 		ASSERT_CRITICAL(false);
 		return false;
diff --git a/drivers/gpu/drm/amd/display/dc/gpio/hw_translate.c b/drivers/gpu/drm/amd/display/dc/gpio/hw_translate.c
index e6e36a912b13..64a5e11fce5c 100644
--- a/drivers/gpu/drm/amd/display/dc/gpio/hw_translate.c
+++ b/drivers/gpu/drm/amd/display/dc/gpio/hw_translate.c
@@ -54,6 +54,7 @@
 #include "dcn32/hw_translate_dcn32.h"
 #include "dcn401/hw_translate_dcn401.h"
 #include "dcn42/hw_translate_dcn42.h"
+#include "dcn42b/hw_translate_dcn42b.h"
 
 /*
  * This unit
@@ -124,6 +125,9 @@ bool dal_hw_translate_init(
 	case DCN_VERSION_4_2:
 		dal_hw_translate_dcn42_init(translate);
 		return true;
+	case DCN_VERSION_4_2B:
+		dal_hw_translate_dcn42b_init(translate);
+		return true;
 	default:
 		BREAK_TO_DEBUGGER();
 		return false;
diff --git a/drivers/gpu/drm/amd/display/dc/hpo/dcn31/dcn31_hpo_dp_stream_encoder.h b/drivers/gpu/drm/amd/display/dc/hpo/dcn31/dcn31_hpo_dp_stream_encoder.h
index d96fcc59cc0e..66739c643e2f 100644
--- a/drivers/gpu/drm/amd/display/dc/hpo/dcn31/dcn31_hpo_dp_stream_encoder.h
+++ b/drivers/gpu/drm/amd/display/dc/hpo/dcn31/dcn31_hpo_dp_stream_encoder.h
@@ -165,6 +165,53 @@
 	SE_SF(DP_SYM32_ENC0_DP_SYM32_ENC_VID_CRC_CONTROL, CRC_CONT_MODE_ENABLE, mask_sh),\
 	SE_SF(DP_SYM32_ENC0_DP_SYM32_ENC_HBLANK_CONTROL, HBLANK_MINIMUM_SYMBOL_WIDTH, mask_sh)
 
+/* Not in DCN42B:
+ * SE_SF(DP_SYM32_ENC0_DP_SYM32_ENC_VID_CRC_CONTROL, CRC_ENABLE, mask_sh),
+ * SE_SF(DP_SYM32_ENC0_DP_SYM32_ENC_VID_CRC_CONTROL, CRC_CONT_MODE_ENABLE, mask_sh),
+ * SE_SF(DP_SYM32_ENC0_DP_SYM32_ENC_HBLANK_CONTROL, HBLANK_MINIMUM_SYMBOL_WIDTH, mask_sh),
+ */
+#define DCN4_2B_HPO_DP_STREAM_ENC_MASK_SH_LIST(mask_sh)\
+	SE_SF(DP_STREAM_MAPPER_CONTROL0, DP_STREAM_LINK_TARGET, mask_sh),\
+	SE_SF(DP_STREAM_ENC0_DP_STREAM_ENC_CLOCK_CONTROL, DP_STREAM_ENC_CLOCK_EN, mask_sh),\
+	SE_SF(DP_STREAM_ENC0_DP_STREAM_ENC_INPUT_MUX_CONTROL, DP_STREAM_ENC_INPUT_MUX_PIXEL_STREAM_SOURCE_SEL, mask_sh),\
+	SE_SF(DP_STREAM_ENC0_DP_STREAM_ENC_AUDIO_CONTROL, DP_STREAM_ENC_INPUT_MUX_AUDIO_STREAM_SOURCE_SEL, mask_sh),\
+	SE_SF(DP_STREAM_ENC0_DP_STREAM_ENC_AUDIO_CONTROL, DP_STREAM_ENC_APG_CLOCK_EN, mask_sh),\
+	SE_SF(DP_STREAM_ENC0_DP_STREAM_ENC_CLOCK_RAMP_ADJUSTER_FIFO_STATUS_CONTROL0, FIFO_RESET, mask_sh),\
+	SE_SF(DP_STREAM_ENC0_DP_STREAM_ENC_CLOCK_RAMP_ADJUSTER_FIFO_STATUS_CONTROL0, FIFO_RESET_DONE, mask_sh),\
+	SE_SF(DP_STREAM_ENC0_DP_STREAM_ENC_CLOCK_RAMP_ADJUSTER_FIFO_STATUS_CONTROL0, FIFO_ENABLE, mask_sh),\
+	SE_SF(DP_SYM32_ENC0_DP_SYM32_ENC_CONTROL, DP_SYM32_ENC_RESET, mask_sh),\
+	SE_SF(DP_SYM32_ENC0_DP_SYM32_ENC_CONTROL, DP_SYM32_ENC_RESET_DONE, mask_sh),\
+	SE_SF(DP_SYM32_ENC0_DP_SYM32_ENC_CONTROL, DP_SYM32_ENC_ENABLE, mask_sh),\
+	SE_SF(DP_SYM32_ENC0_DP_SYM32_ENC_VID_PIXEL_FORMAT, PIXEL_ENCODING_TYPE, mask_sh),\
+	SE_SF(DP_SYM32_ENC0_DP_SYM32_ENC_VID_PIXEL_FORMAT, UNCOMPRESSED_PIXEL_ENCODING, mask_sh),\
+	SE_SF(DP_SYM32_ENC0_DP_SYM32_ENC_VID_PIXEL_FORMAT, UNCOMPRESSED_COMPONENT_DEPTH, mask_sh),\
+	SE_SF(DP_SYM32_ENC0_DP_SYM32_ENC_VID_PIXEL_FORMAT_DOUBLE_BUFFER_CONTROL, PIXEL_FORMAT_DOUBLE_BUFFER_ENABLE, mask_sh),\
+	SE_SF(DP_SYM32_ENC0_DP_SYM32_ENC_VID_MSA_DOUBLE_BUFFER_CONTROL, MSA_DOUBLE_BUFFER_ENABLE, mask_sh),\
+	SE_SF(DP_SYM32_ENC_VID_MSA, MSA_DATA_LANE_0, mask_sh),\
+	SE_SF(DP_SYM32_ENC_VID_MSA, MSA_DATA_LANE_1, mask_sh),\
+	SE_SF(DP_SYM32_ENC_VID_MSA, MSA_DATA_LANE_2, mask_sh),\
+	SE_SF(DP_SYM32_ENC_VID_MSA, MSA_DATA_LANE_3, mask_sh),\
+	SE_SF(DP_SYM32_ENC0_DP_SYM32_ENC_VID_FIFO_CONTROL, PIXEL_TO_SYMBOL_FIFO_RESET, mask_sh),\
+	SE_SF(DP_SYM32_ENC0_DP_SYM32_ENC_VID_FIFO_CONTROL, PIXEL_TO_SYMBOL_FIFO_RESET_DONE, mask_sh),\
+	SE_SF(DP_SYM32_ENC0_DP_SYM32_ENC_VID_FIFO_CONTROL, PIXEL_TO_SYMBOL_FIFO_ENABLE, mask_sh),\
+	SE_SF(DP_SYM32_ENC0_DP_SYM32_ENC_VID_STREAM_CONTROL, VID_STREAM_ENABLE, mask_sh),\
+	SE_SF(DP_SYM32_ENC0_DP_SYM32_ENC_VID_STREAM_CONTROL, VID_STREAM_STATUS, mask_sh),\
+	SE_SF(DP_SYM32_ENC0_DP_SYM32_ENC_VID_VBID_CONTROL, VBID_6_COMPRESSEDSTREAM_FLAG_SOF_REFERENCE, mask_sh),\
+	SE_SF(DP_SYM32_ENC0_DP_SYM32_ENC_VID_VBID_CONTROL, VBID_6_COMPRESSEDSTREAM_FLAG_LINE_NUMBER, mask_sh),\
+	SE_SF(DP_SYM32_ENC0_DP_SYM32_ENC_SDP_CONTROL, SDP_STREAM_ENABLE, mask_sh),\
+	SE_SF(DP_SYM32_ENC0_DP_SYM32_ENC_SDP_GSP_CONTROL0, GSP_VIDEO_CONTINUOUS_TRANSMISSION_ENABLE, mask_sh),\
+	SE_SF(DP_SYM32_ENC0_DP_SYM32_ENC_SDP_GSP_CONTROL0, GSP_PAYLOAD_SIZE, mask_sh),\
+	SE_SF(DP_SYM32_ENC0_DP_SYM32_ENC_SDP_GSP_CONTROL0, GSP_TRANSMISSION_LINE_NUMBER, mask_sh),\
+	SE_SF(DP_SYM32_ENC0_DP_SYM32_ENC_SDP_GSP_CONTROL5, GSP_VIDEO_CONTINUOUS_TRANSMISSION_ENABLE, mask_sh),\
+	SE_SF(DP_SYM32_ENC0_DP_SYM32_ENC_SDP_GSP_CONTROL5, GSP_TRANSMISSION_LINE_NUMBER, mask_sh),\
+	SE_SF(DP_SYM32_ENC0_DP_SYM32_ENC_SDP_GSP_CONTROL5, GSP_SOF_REFERENCE, mask_sh),\
+	SE_SF(DP_SYM32_ENC0_DP_SYM32_ENC_SDP_METADATA_PACKET_CONTROL, METADATA_PACKET_ENABLE, mask_sh),\
+	SE_SF(DP_SYM32_ENC0_DP_SYM32_ENC_SDP_AUDIO_CONTROL0, AUDIO_MUTE, mask_sh),\
+	SE_SF(DP_SYM32_ENC0_DP_SYM32_ENC_SDP_AUDIO_CONTROL0, ASP_ENABLE, mask_sh),\
+	SE_SF(DP_SYM32_ENC0_DP_SYM32_ENC_SDP_AUDIO_CONTROL0, ATP_ENABLE, mask_sh),\
+	SE_SF(DP_SYM32_ENC0_DP_SYM32_ENC_SDP_AUDIO_CONTROL0, AIP_ENABLE, mask_sh),\
+	SE_SF(DP_SYM32_ENC0_DP_SYM32_ENC_SDP_AUDIO_CONTROL0, ACM_ENABLE, mask_sh)
+
 
 #define DCN3_1_HPO_DP_STREAM_ENC_REG_FIELD_LIST(type) \
 	type DP_STREAM_LINK_TARGET;\
diff --git a/drivers/gpu/drm/amd/display/dc/hubbub/dcn35/dcn35_hubbub.h b/drivers/gpu/drm/amd/display/dc/hubbub/dcn35/dcn35_hubbub.h
index 9f65fff1bd4d..5ae9fb76c675 100644
--- a/drivers/gpu/drm/amd/display/dc/hubbub/dcn35/dcn35_hubbub.h
+++ b/drivers/gpu/drm/amd/display/dc/hubbub/dcn35/dcn35_hubbub.h
@@ -109,6 +109,88 @@
 	SR(DCHUBBUB_ARB_ALLOW_SR_EXIT_WATERMARK_Z8_D),\
 	SR(DCHUBBUB_ARB_QOS_FORCE)
 
+/*
+ * Not in DCN42B:
+ * SR(DCHUBBUB_DEBUG_CTRL_0),
+ */
+#define HUBBUB_REG_LIST_DCN42B(id)\
+	SR(DCHUBBUB_ARB_DATA_URGENCY_WATERMARK_A),\
+	SR(DCHUBBUB_ARB_DATA_URGENCY_WATERMARK_B),\
+	SR(DCHUBBUB_ARB_DATA_URGENCY_WATERMARK_C),\
+	SR(DCHUBBUB_ARB_DATA_URGENCY_WATERMARK_D),\
+	SR(DCHUBBUB_ARB_WATERMARK_CHANGE_CNTL),\
+	SR(DCHUBBUB_ARB_DRAM_STATE_CNTL),\
+	SR(DCHUBBUB_ARB_SAT_LEVEL),\
+	SR(DCHUBBUB_ARB_DF_REQ_OUTSTAND),\
+	SR(DCHUBBUB_GLOBAL_TIMER_CNTL), \
+	SR(DCHUBBUB_SOFT_RESET),\
+	SR(DCHUBBUB_CRC_CTRL), \
+	SR(DCN_VM_FB_LOCATION_BASE),\
+	SR(DCN_VM_FB_LOCATION_TOP),\
+	SR(DCN_VM_FB_OFFSET),\
+	SR(DCN_VM_AGP_BOT),\
+	SR(DCN_VM_AGP_TOP),\
+	SR(DCN_VM_AGP_BASE),\
+	HUBBUB_SR_WATERMARK_REG_LIST(), \
+	SR(DCHUBBUB_ARB_FRAC_URG_BW_NOM_A),\
+	SR(DCHUBBUB_ARB_FRAC_URG_BW_NOM_B),\
+	SR(DCHUBBUB_ARB_FRAC_URG_BW_NOM_C),\
+	SR(DCHUBBUB_ARB_FRAC_URG_BW_NOM_D),\
+	SR(DCHUBBUB_ARB_FRAC_URG_BW_FLIP_A),\
+	SR(DCHUBBUB_ARB_FRAC_URG_BW_FLIP_B),\
+	SR(DCHUBBUB_ARB_FRAC_URG_BW_FLIP_C),\
+	SR(DCHUBBUB_ARB_FRAC_URG_BW_FLIP_D),\
+	SR(DCHUBBUB_ARB_REFCYC_PER_TRIP_TO_MEMORY_A),\
+	SR(DCHUBBUB_ARB_REFCYC_PER_TRIP_TO_MEMORY_B),\
+	SR(DCHUBBUB_ARB_REFCYC_PER_TRIP_TO_MEMORY_C),\
+	SR(DCHUBBUB_ARB_REFCYC_PER_TRIP_TO_MEMORY_D),\
+	SR(DCHUBBUB_DET0_CTRL),\
+	SR(DCHUBBUB_DET1_CTRL),\
+	SR(DCHUBBUB_DET2_CTRL),\
+	SR(DCHUBBUB_DET3_CTRL),\
+	SR(DCHUBBUB_COMPBUF_CTRL),\
+	SR(COMPBUF_RESERVED_SPACE),\
+	SR(DCHUBBUB_ARB_USR_RETRAINING_CNTL),\
+	SR(DCHUBBUB_ARB_USR_RETRAINING_WATERMARK_A),\
+	SR(DCHUBBUB_ARB_USR_RETRAINING_WATERMARK_B),\
+	SR(DCHUBBUB_ARB_USR_RETRAINING_WATERMARK_C),\
+	SR(DCHUBBUB_ARB_USR_RETRAINING_WATERMARK_D),\
+	SR(DCHUBBUB_ARB_UCLK_PSTATE_CHANGE_WATERMARK_A),\
+	SR(DCHUBBUB_ARB_UCLK_PSTATE_CHANGE_WATERMARK_B),\
+	SR(DCHUBBUB_ARB_UCLK_PSTATE_CHANGE_WATERMARK_C),\
+	SR(DCHUBBUB_ARB_UCLK_PSTATE_CHANGE_WATERMARK_D),\
+	SR(DCHUBBUB_ARB_FCLK_PSTATE_CHANGE_WATERMARK_A),\
+	SR(DCHUBBUB_ARB_FCLK_PSTATE_CHANGE_WATERMARK_B),\
+	SR(DCHUBBUB_ARB_FCLK_PSTATE_CHANGE_WATERMARK_C),\
+	SR(DCHUBBUB_ARB_FCLK_PSTATE_CHANGE_WATERMARK_D),\
+	SR(DCN_VM_FAULT_ADDR_MSB),\
+	SR(DCN_VM_FAULT_ADDR_LSB),\
+	SR(DCN_VM_FAULT_CNTL),\
+	SR(DCN_VM_FAULT_STATUS),\
+	SR(SDPIF_REQUEST_RATE_LIMIT),\
+	SR(DCHUBBUB_CLOCK_CNTL),\
+	SR(DCHUBBUB_SDPIF_CFG0),\
+	SR(DCHUBBUB_SDPIF_CFG1),\
+	SR(DCHUBBUB_MEM_PWR_MODE_CTRL),\
+	SR(DCHUBBUB_ARB_HOSTVM_CNTL),\
+	SR(DCHVM_CTRL0),\
+	SR(DCHVM_MEM_CTRL),\
+	SR(DCHVM_CLK_CTRL),\
+	SR(DCHVM_RIOMMU_CTRL0),\
+	SR(DCHVM_RIOMMU_STAT0),\
+	SR(DCHUBBUB_ARB_ALLOW_SR_ENTER_WATERMARK_Z8_A),\
+	SR(DCHUBBUB_ARB_ALLOW_SR_EXIT_WATERMARK_Z8_A),\
+	SR(DCHUBBUB_ARB_ALLOW_SR_ENTER_WATERMARK_Z8_B),\
+	SR(DCHUBBUB_ARB_ALLOW_SR_EXIT_WATERMARK_Z8_B),\
+	SR(DCHUBBUB_ARB_ALLOW_SR_ENTER_WATERMARK_Z8_C),\
+	SR(DCHUBBUB_ARB_ALLOW_SR_EXIT_WATERMARK_Z8_C),\
+	SR(DCHUBBUB_ARB_ALLOW_SR_ENTER_WATERMARK_Z8_D),\
+	SR(DCHUBBUB_ARB_ALLOW_SR_EXIT_WATERMARK_Z8_D),\
+	SR(DCHUBBUB_CTRL_STATUS),\
+	SR(DCHUBBUB_TIMEOUT_DETECTION_CTRL1),\
+	SR(DCHUBBUB_TIMEOUT_DETECTION_CTRL2),\
+	SR(DCHUBBUB_ARB_QOS_FORCE)
+
 
 #define HUBBUB_MASK_SH_LIST_DCN35(mask_sh)\
 	HUBBUB_MASK_SH_LIST_DCN32(mask_sh), \
@@ -144,6 +226,122 @@
 	HUBBUB_SF(DCHUBBUB_ARB_HOSTVM_CNTL, DCHUBBUB_ARB_MAX_QOS_COMMIT_THRESHOLD, mask_sh),\
 	HUBBUB_SF(DCHUBBUB_ARB_DF_REQ_OUTSTAND, DCHUBBUB_ARB_MIN_REQ_OUTSTAND_COMMIT_THRESHOLD, mask_sh)
 
+#define HUBBUB_MASK_SH_LIST_DCN42B(mask_sh)\
+	HUBBUB_SF(DCHUBBUB_GLOBAL_TIMER_CNTL, DCHUBBUB_GLOBAL_TIMER_ENABLE, mask_sh), \
+	HUBBUB_SF(DCHUBBUB_SOFT_RESET, DCHUBBUB_GLOBAL_SOFT_RESET, mask_sh), \
+	HUBBUB_SF(DCHUBBUB_ARB_WATERMARK_CHANGE_CNTL, DCHUBBUB_ARB_WATERMARK_CHANGE_REQUEST, mask_sh), \
+	HUBBUB_SF(DCHUBBUB_ARB_WATERMARK_CHANGE_CNTL, DCHUBBUB_ARB_WATERMARK_CHANGE_DONE_INTERRUPT_DISABLE, mask_sh), \
+	HUBBUB_SF(DCHUBBUB_ARB_DRAM_STATE_CNTL, DCHUBBUB_ARB_ALLOW_SELF_REFRESH_FORCE_VALUE, mask_sh), \
+	HUBBUB_SF(DCHUBBUB_ARB_DRAM_STATE_CNTL, DCHUBBUB_ARB_ALLOW_SELF_REFRESH_FORCE_ENABLE, mask_sh), \
+	HUBBUB_SF(DCHUBBUB_ARB_DRAM_STATE_CNTL, DCHUBBUB_ARB_ALLOW_PSTATE_CHANGE_FORCE_VALUE, mask_sh), \
+	HUBBUB_SF(DCHUBBUB_ARB_DRAM_STATE_CNTL, DCHUBBUB_ARB_ALLOW_PSTATE_CHANGE_FORCE_ENABLE, mask_sh), \
+	HUBBUB_SF(DCHUBBUB_ARB_SAT_LEVEL, DCHUBBUB_ARB_SAT_LEVEL, mask_sh), \
+	HUBBUB_SF(DCHUBBUB_ARB_DF_REQ_OUTSTAND, DCHUBBUB_ARB_MIN_REQ_OUTSTAND, mask_sh), \
+	HUBBUB_SF(DCHUBBUB_ARB_DF_REQ_OUTSTAND, DCHUBBUB_ARB_MAX_REQ_OUTSTAND, mask_sh), \
+	HUBBUB_SF(DCHUBBUB_ARB_DATA_URGENCY_WATERMARK_A, DCHUBBUB_ARB_DATA_URGENCY_WATERMARK_A, mask_sh), \
+	HUBBUB_SF(DCHUBBUB_ARB_DATA_URGENCY_WATERMARK_B, DCHUBBUB_ARB_DATA_URGENCY_WATERMARK_B, mask_sh), \
+	HUBBUB_SF(DCHUBBUB_ARB_DATA_URGENCY_WATERMARK_C, DCHUBBUB_ARB_DATA_URGENCY_WATERMARK_C, mask_sh), \
+	HUBBUB_SF(DCHUBBUB_ARB_DATA_URGENCY_WATERMARK_D, DCHUBBUB_ARB_DATA_URGENCY_WATERMARK_D, mask_sh), \
+	HUBBUB_MASK_SH_LIST_STUTTER(mask_sh), \
+	HUBBUB_SF(DCHUBBUB_GLOBAL_TIMER_CNTL, DCHUBBUB_GLOBAL_TIMER_REFDIV, mask_sh), \
+	HUBBUB_SF(DCN_VM_FB_LOCATION_BASE, FB_BASE, mask_sh), \
+	HUBBUB_SF(DCN_VM_FB_LOCATION_TOP, FB_TOP, mask_sh), \
+	HUBBUB_SF(DCN_VM_FB_OFFSET, FB_OFFSET, mask_sh), \
+	HUBBUB_SF(DCN_VM_AGP_BOT, AGP_BOT, mask_sh), \
+	HUBBUB_SF(DCN_VM_AGP_TOP, AGP_TOP, mask_sh), \
+	HUBBUB_SF(DCN_VM_AGP_BASE, AGP_BASE, mask_sh), \
+	HUBBUB_SF(DCHUBBUB_ARB_FRAC_URG_BW_FLIP_A, DCHUBBUB_ARB_FRAC_URG_BW_FLIP_A, mask_sh), \
+	HUBBUB_SF(DCHUBBUB_ARB_FRAC_URG_BW_FLIP_B, DCHUBBUB_ARB_FRAC_URG_BW_FLIP_B, mask_sh), \
+	HUBBUB_SF(DCHUBBUB_ARB_FRAC_URG_BW_FLIP_C, DCHUBBUB_ARB_FRAC_URG_BW_FLIP_C, mask_sh), \
+	HUBBUB_SF(DCHUBBUB_ARB_FRAC_URG_BW_FLIP_D, DCHUBBUB_ARB_FRAC_URG_BW_FLIP_D, mask_sh), \
+	HUBBUB_SF(DCHUBBUB_ARB_FRAC_URG_BW_NOM_A, DCHUBBUB_ARB_FRAC_URG_BW_NOM_A, mask_sh), \
+	HUBBUB_SF(DCHUBBUB_ARB_FRAC_URG_BW_NOM_B, DCHUBBUB_ARB_FRAC_URG_BW_NOM_B, mask_sh), \
+	HUBBUB_SF(DCHUBBUB_ARB_FRAC_URG_BW_NOM_C, DCHUBBUB_ARB_FRAC_URG_BW_NOM_C, mask_sh), \
+	HUBBUB_SF(DCHUBBUB_ARB_FRAC_URG_BW_NOM_D, DCHUBBUB_ARB_FRAC_URG_BW_NOM_D, mask_sh), \
+	HUBBUB_SF(DCHUBBUB_ARB_REFCYC_PER_TRIP_TO_MEMORY_A, DCHUBBUB_ARB_REFCYC_PER_TRIP_TO_MEMORY_A, mask_sh), \
+	HUBBUB_SF(DCHUBBUB_ARB_REFCYC_PER_TRIP_TO_MEMORY_B, DCHUBBUB_ARB_REFCYC_PER_TRIP_TO_MEMORY_B, mask_sh), \
+	HUBBUB_SF(DCHUBBUB_ARB_REFCYC_PER_TRIP_TO_MEMORY_C, DCHUBBUB_ARB_REFCYC_PER_TRIP_TO_MEMORY_C, mask_sh), \
+	HUBBUB_SF(DCHUBBUB_ARB_REFCYC_PER_TRIP_TO_MEMORY_D, DCHUBBUB_ARB_REFCYC_PER_TRIP_TO_MEMORY_D, mask_sh),\
+	HUBBUB_SF(DCHUBBUB_DET0_CTRL, DET0_SIZE, mask_sh),\
+	HUBBUB_SF(DCHUBBUB_DET0_CTRL, DET0_SIZE_CURRENT, mask_sh),\
+	HUBBUB_SF(DCHUBBUB_DET1_CTRL, DET1_SIZE, mask_sh),\
+	HUBBUB_SF(DCHUBBUB_DET1_CTRL, DET1_SIZE_CURRENT, mask_sh),\
+	HUBBUB_SF(DCHUBBUB_DET2_CTRL, DET2_SIZE, mask_sh),\
+	HUBBUB_SF(DCHUBBUB_DET2_CTRL, DET2_SIZE_CURRENT, mask_sh),\
+	HUBBUB_SF(DCHUBBUB_DET3_CTRL, DET3_SIZE, mask_sh),\
+	HUBBUB_SF(DCHUBBUB_DET3_CTRL, DET3_SIZE_CURRENT, mask_sh),\
+	HUBBUB_SF(DCHUBBUB_COMPBUF_CTRL, COMPBUF_SIZE, mask_sh),\
+	HUBBUB_SF(DCHUBBUB_COMPBUF_CTRL, COMPBUF_SIZE_CURRENT, mask_sh),\
+	HUBBUB_SF(COMPBUF_RESERVED_SPACE, COMPBUF_RESERVED_SPACE_64B, mask_sh),\
+	HUBBUB_SF(COMPBUF_RESERVED_SPACE, COMPBUF_RESERVED_SPACE_ZS, mask_sh),\
+	HUBBUB_SF(DCHUBBUB_ARB_USR_RETRAINING_CNTL, DCHUBBUB_ARB_ALLOW_USR_RETRAINING_FORCE_VALUE, mask_sh),\
+	HUBBUB_SF(DCHUBBUB_ARB_USR_RETRAINING_CNTL, DCHUBBUB_ARB_ALLOW_USR_RETRAINING_FORCE_ENABLE, mask_sh),\
+	HUBBUB_SF(DCHUBBUB_ARB_USR_RETRAINING_CNTL, DCHUBBUB_ARB_DO_NOT_FORCE_ALLOW_USR_RETRAINING_DURING_PSTATE_CHANGE_REQUEST, mask_sh),\
+	HUBBUB_SF(DCHUBBUB_ARB_USR_RETRAINING_CNTL, DCHUBBUB_ARB_DO_NOT_FORCE_ALLOW_USR_RETRAINING_DURING_PRE_CSTATE, mask_sh),\
+	HUBBUB_SF(DCHUBBUB_ARB_USR_RETRAINING_WATERMARK_A, DCHUBBUB_ARB_USR_RETRAINING_WATERMARK_A, mask_sh), \
+	HUBBUB_SF(DCHUBBUB_ARB_USR_RETRAINING_WATERMARK_B, DCHUBBUB_ARB_USR_RETRAINING_WATERMARK_B, mask_sh), \
+	HUBBUB_SF(DCHUBBUB_ARB_USR_RETRAINING_WATERMARK_C, DCHUBBUB_ARB_USR_RETRAINING_WATERMARK_C, mask_sh), \
+	HUBBUB_SF(DCHUBBUB_ARB_USR_RETRAINING_WATERMARK_D, DCHUBBUB_ARB_USR_RETRAINING_WATERMARK_D, mask_sh),\
+	HUBBUB_SF(DCHUBBUB_ARB_UCLK_PSTATE_CHANGE_WATERMARK_A, DCHUBBUB_ARB_UCLK_PSTATE_CHANGE_WATERMARK_A, mask_sh),\
+	HUBBUB_SF(DCHUBBUB_ARB_UCLK_PSTATE_CHANGE_WATERMARK_B, DCHUBBUB_ARB_UCLK_PSTATE_CHANGE_WATERMARK_B, mask_sh),\
+	HUBBUB_SF(DCHUBBUB_ARB_UCLK_PSTATE_CHANGE_WATERMARK_C, DCHUBBUB_ARB_UCLK_PSTATE_CHANGE_WATERMARK_C, mask_sh),\
+	HUBBUB_SF(DCHUBBUB_ARB_UCLK_PSTATE_CHANGE_WATERMARK_D, DCHUBBUB_ARB_UCLK_PSTATE_CHANGE_WATERMARK_D, mask_sh),\
+	HUBBUB_SF(DCHUBBUB_ARB_FCLK_PSTATE_CHANGE_WATERMARK_A, DCHUBBUB_ARB_FCLK_PSTATE_CHANGE_WATERMARK_A, mask_sh),\
+	HUBBUB_SF(DCHUBBUB_ARB_FCLK_PSTATE_CHANGE_WATERMARK_B, DCHUBBUB_ARB_FCLK_PSTATE_CHANGE_WATERMARK_B, mask_sh),\
+	HUBBUB_SF(DCHUBBUB_ARB_FCLK_PSTATE_CHANGE_WATERMARK_C, DCHUBBUB_ARB_FCLK_PSTATE_CHANGE_WATERMARK_C, mask_sh),\
+	HUBBUB_SF(DCHUBBUB_ARB_FCLK_PSTATE_CHANGE_WATERMARK_D, DCHUBBUB_ARB_FCLK_PSTATE_CHANGE_WATERMARK_D, mask_sh), \
+	HUBBUB_SF(DCN_VM_FAULT_ADDR_MSB, DCN_VM_FAULT_ADDR_MSB, mask_sh), \
+	HUBBUB_SF(DCN_VM_FAULT_ADDR_LSB, DCN_VM_FAULT_ADDR_LSB, mask_sh), \
+	HUBBUB_SF(DCN_VM_FAULT_CNTL, DCN_VM_ERROR_STATUS_CLEAR, mask_sh), \
+	HUBBUB_SF(DCN_VM_FAULT_CNTL, DCN_VM_ERROR_STATUS_MODE, mask_sh), \
+	HUBBUB_SF(DCN_VM_FAULT_CNTL, DCN_VM_ERROR_INTERRUPT_ENABLE, mask_sh), \
+	HUBBUB_SF(DCN_VM_FAULT_CNTL, DCN_VM_RANGE_FAULT_DISABLE, mask_sh), \
+	HUBBUB_SF(DCN_VM_FAULT_CNTL, DCN_VM_PRQ_FAULT_DISABLE, mask_sh), \
+	HUBBUB_SF(DCN_VM_FAULT_STATUS, DCN_VM_ERROR_STATUS, mask_sh), \
+	HUBBUB_SF(DCN_VM_FAULT_STATUS, DCN_VM_ERROR_VMID, mask_sh), \
+	HUBBUB_SF(DCN_VM_FAULT_STATUS, DCN_VM_ERROR_TABLE_LEVEL, mask_sh), \
+	HUBBUB_SF(DCN_VM_FAULT_STATUS, DCN_VM_ERROR_PIPE, mask_sh), \
+	HUBBUB_SF(DCN_VM_FAULT_STATUS, DCN_VM_ERROR_INTERRUPT_STATUS, mask_sh),\
+	HUBBUB_SF(SDPIF_REQUEST_RATE_LIMIT, SDPIF_REQUEST_RATE_LIMIT, mask_sh),\
+	HUBBUB_SF(DCHUBBUB_CLOCK_CNTL, DISPCLK_R_DCHUBBUB_GATE_DIS, mask_sh),\
+	HUBBUB_SF(DCHUBBUB_CLOCK_CNTL, DCFCLK_R_DCHUBBUB_GATE_DIS, mask_sh),\
+	HUBBUB_SF(DCHUBBUB_SDPIF_CFG0, SDPIF_PORT_CONTROL, mask_sh),\
+	HUBBUB_SF(DCHUBBUB_SDPIF_CFG1, SDPIF_MAX_NUM_OUTSTANDING, mask_sh),\
+	HUBBUB_SF(DCHUBBUB_MEM_PWR_MODE_CTRL, DET_MEM_PWR_LS_MODE, mask_sh),\
+	HUBBUB_SF(DCHUBBUB_ARB_MALL_CNTL, MALL_PREFETCH_COMPLETE, mask_sh),\
+	HUBBUB_SF(DCHUBBUB_ARB_MALL_CNTL, MALL_IN_USE, mask_sh),\
+	HUBBUB_SF(DCHVM_CTRL0, HOSTVM_INIT_REQ, mask_sh),\
+	HUBBUB_SF(DCHVM_MEM_CTRL, HVM_GPUVMRET_PWR_REQ_DIS, mask_sh),\
+	HUBBUB_SF(DCHVM_MEM_CTRL, HVM_GPUVMRET_FORCE_REQ, mask_sh),\
+	HUBBUB_SF(DCHVM_MEM_CTRL, HVM_GPUVMRET_POWER_STATUS, mask_sh),\
+	HUBBUB_SF(DCHVM_CLK_CTRL, HVM_DISPCLK_R_GATE_DIS, mask_sh),\
+	HUBBUB_SF(DCHVM_CLK_CTRL, HVM_DISPCLK_G_GATE_DIS, mask_sh),\
+	HUBBUB_SF(DCHVM_CLK_CTRL, HVM_DCFCLK_R_GATE_DIS, mask_sh),\
+	HUBBUB_SF(DCHVM_CLK_CTRL, HVM_DCFCLK_G_GATE_DIS, mask_sh),\
+	HUBBUB_SF(DCHVM_CLK_CTRL, TR_REQ_REQCLKREQ_MODE, mask_sh),\
+	HUBBUB_SF(DCHVM_CLK_CTRL, TW_RSP_COMPCLKREQ_MODE, mask_sh),\
+	HUBBUB_SF(DCHVM_RIOMMU_CTRL0, HOSTVM_PREFETCH_REQ, mask_sh),\
+	HUBBUB_SF(DCHVM_RIOMMU_CTRL0, HOSTVM_POWERSTATUS, mask_sh),\
+	HUBBUB_SF(DCHVM_RIOMMU_STAT0, RIOMMU_ACTIVE, mask_sh),\
+	HUBBUB_SF(DCHVM_RIOMMU_STAT0, HOSTVM_PREFETCH_DONE, mask_sh),\
+	HUBBUB_SF(DCHUBBUB_COMPBUF_CTRL, COMPBUF_SIZE, mask_sh),\
+	HUBBUB_SF(DCHUBBUB_COMPBUF_CTRL, COMPBUF_SIZE_CURRENT, mask_sh),\
+	HUBBUB_SF(DCHUBBUB_COMPBUF_CTRL, CONFIG_ERROR, mask_sh),\
+	HUBBUB_SF(COMPBUF_RESERVED_SPACE, COMPBUF_RESERVED_SPACE_64B, mask_sh),\
+	HUBBUB_SF(COMPBUF_RESERVED_SPACE, COMPBUF_RESERVED_SPACE_ZS, mask_sh),\
+	HUBBUB_SF(DCHUBBUB_CLOCK_CNTL, DCHUBBUB_FGCG_REP_DIS, mask_sh),\
+	HUBBUB_SF(DCHUBBUB_ARB_ALLOW_SR_ENTER_WATERMARK_Z8_A, DCHUBBUB_ARB_ALLOW_SR_ENTER_WATERMARK_Z8_A, mask_sh), \
+	HUBBUB_SF(DCHUBBUB_ARB_ALLOW_SR_ENTER_WATERMARK_Z8_B, DCHUBBUB_ARB_ALLOW_SR_ENTER_WATERMARK_Z8_B, mask_sh), \
+	HUBBUB_SF(DCHUBBUB_ARB_ALLOW_SR_ENTER_WATERMARK_Z8_C, DCHUBBUB_ARB_ALLOW_SR_ENTER_WATERMARK_Z8_C, mask_sh), \
+	HUBBUB_SF(DCHUBBUB_ARB_ALLOW_SR_ENTER_WATERMARK_Z8_D, DCHUBBUB_ARB_ALLOW_SR_ENTER_WATERMARK_Z8_D, mask_sh), \
+	HUBBUB_SF(DCHUBBUB_ARB_ALLOW_SR_EXIT_WATERMARK_Z8_A, DCHUBBUB_ARB_ALLOW_SR_EXIT_WATERMARK_Z8_A, mask_sh), \
+	HUBBUB_SF(DCHUBBUB_ARB_ALLOW_SR_EXIT_WATERMARK_Z8_B, DCHUBBUB_ARB_ALLOW_SR_EXIT_WATERMARK_Z8_B, mask_sh), \
+	HUBBUB_SF(DCHUBBUB_ARB_ALLOW_SR_EXIT_WATERMARK_Z8_C, DCHUBBUB_ARB_ALLOW_SR_EXIT_WATERMARK_Z8_C, mask_sh), \
+	HUBBUB_SF(DCHUBBUB_ARB_ALLOW_SR_EXIT_WATERMARK_Z8_D, DCHUBBUB_ARB_ALLOW_SR_EXIT_WATERMARK_Z8_D, mask_sh), \
+	HUBBUB_SF(DCHUBBUB_ARB_DRAM_STATE_CNTL, DCHUBBUB_ARB_ALLOW_CSTATE_DEEPSLEEP_LEGACY_MODE, mask_sh), \
+	HUBBUB_SF(DCHUBBUB_ARB_HOSTVM_CNTL, DCHUBBUB_ARB_MAX_QOS_COMMIT_THRESHOLD, mask_sh),\
+	HUBBUB_SF(DCHUBBUB_ARB_DF_REQ_OUTSTAND, DCHUBBUB_ARB_MIN_REQ_OUTSTAND_COMMIT_THRESHOLD, mask_sh)
+
 void hubbub35_construct(struct dcn20_hubbub *hubbub2,
 	struct dc_context *ctx,
 	const struct dcn_hubbub_registers *hubbub_regs,
diff --git a/drivers/gpu/drm/amd/display/dc/hubp/dcn42/dcn42_hubp.h b/drivers/gpu/drm/amd/display/dc/hubp/dcn42/dcn42_hubp.h
index f0e614136228..fc30afd4c912 100644
--- a/drivers/gpu/drm/amd/display/dc/hubp/dcn42/dcn42_hubp.h
+++ b/drivers/gpu/drm/amd/display/dc/hubp/dcn42/dcn42_hubp.h
@@ -48,6 +48,25 @@
 	HUBP_SF(CURSOR0_0_HUBP_3DLUT_ADDRESS_LOW, HUBP_3DLUT_ADDRESS_LOW, mask_sh),\
 	HUBP_SF(CURSOR0_0_HUBP_3DLUT_DLG_PARAM, REFCYC_PER_3DLUT_GROUP, mask_sh)
 
+#define HUBP_MASK_SH_LIST_DCN42B(mask_sh)\
+	HUBP_MASK_SH_LIST_DCN35(mask_sh),\
+	HUBP_SF(HUBP0_3DLUT_FL_CONFIG, HUBP0_3DLUT_FL_MODE, mask_sh),\
+	HUBP_SF(HUBP0_3DLUT_FL_CONFIG, HUBP0_3DLUT_FL_FORMAT, mask_sh),\
+	HUBP_SF(HUBP0_3DLUT_FL_BIAS_SCALE, HUBP0_3DLUT_FL_BIAS, mask_sh),\
+	HUBP_SF(HUBP0_3DLUT_FL_BIAS_SCALE, HUBP0_3DLUT_FL_SCALE, mask_sh),\
+	HUBP_SF(CURSOR0_0_HUBP_3DLUT_CONTROL, HUBP_3DLUT_ENABLE, mask_sh),\
+	HUBP_SF(CURSOR0_0_HUBP_3DLUT_CONTROL, HUBP_3DLUT_DONE, mask_sh),\
+	HUBP_SF(CURSOR0_0_HUBP_3DLUT_CONTROL, HUBP_3DLUT_ADDRESSING_MODE, mask_sh),\
+	HUBP_SF(CURSOR0_0_HUBP_3DLUT_CONTROL, HUBP_3DLUT_WIDTH, mask_sh),\
+	HUBP_SF(CURSOR0_0_HUBP_3DLUT_CONTROL, HUBP_3DLUT_MPC_WIDTH, mask_sh),\
+	HUBP_SF(CURSOR0_0_HUBP_3DLUT_CONTROL, HUBP_3DLUT_TMZ, mask_sh),\
+	HUBP_SF(CURSOR0_0_HUBP_3DLUT_CONTROL, HUBP_3DLUT_CROSSBAR_SEL_B, mask_sh),\
+	HUBP_SF(CURSOR0_0_HUBP_3DLUT_CONTROL, HUBP_3DLUT_CROSSBAR_SEL_G, mask_sh),\
+	HUBP_SF(CURSOR0_0_HUBP_3DLUT_CONTROL, HUBP_3DLUT_CROSSBAR_SEL_R, mask_sh),\
+	HUBP_SF(CURSOR0_0_HUBP_3DLUT_ADDRESS_HIGH, HUBP_3DLUT_ADDRESS_HIGH, mask_sh),\
+	HUBP_SF(CURSOR0_0_HUBP_3DLUT_ADDRESS_LOW, HUBP_3DLUT_ADDRESS_LOW, mask_sh),\
+	HUBP_SF(CURSOR0_0_HUBP_3DLUT_DLG_PARAM, REFCYC_PER_3DLUT_GROUP, mask_sh)
+
 struct dml2_display_rq_regs;
 
 bool hubp42_construct(
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/Makefile b/drivers/gpu/drm/amd/display/dc/hwss/Makefile
index 08cbbf87a19f..df3101ce1784 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/hwss/Makefile
@@ -207,4 +207,12 @@ AMD_DAL_HWSS_DCN42 = $(addprefix $(AMDDALPATH)/dc/hwss/dcn42/,$(HWSS_DCN42))
 
 AMD_DISPLAY_FILES += $(AMD_DAL_HWSS_DCN42)
 
+###############################################################################
+
+HWSS_DCN42B = dcn42b_hwseq.o dcn42b_init.o
+
+AMD_DAL_HWSS_DCN42B = $(addprefix $(AMDDALPATH)/dc/hwss/dcn42b/,$(HWSS_DCN42B))
+
+AMD_DISPLAY_FILES += $(AMD_DAL_HWSS_DCN42B)
+
 endif
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr.h b/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr.h
index dcce81e3d97c..f829ce3f70e5 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr.h
@@ -117,6 +117,27 @@ struct dcn42_clk_internal {
 	uint32_t CLK8_CLK_TICK_CNT__TIMER_THRESHOLD;
 };
 
+struct dcn42b_clk_internal {
+	int dummy;
+	uint32_t CLK5_CLK0_CURRENT_CNT; //dispclk
+	uint32_t CLK5_CLK1_CURRENT_CNT; //dppclk
+	uint32_t CLK5_CLK2_CURRENT_CNT; //dprefclk
+	uint32_t CLK5_CLK3_CURRENT_CNT; //dcfclk
+	//uint32_t CLK5_CLK4_CURRENT_CNT; //dtbclk
+	uint32_t CLK5_CLK0_DS_CNTL;	    //dispclk deep_sleep_divider
+	uint32_t CLK5_CLK1_DS_CNTL;	    //dppclk deep_sleep_divider
+	uint32_t CLK5_CLK2_DS_CNTL;	    //dprefclk deep_sleep_divider
+	uint32_t CLK5_CLK3_DS_CNTL;	    //dcfclk deep_sleep_divider
+	uint32_t CLK5_CLK3_ALLOW_DS;	//dcf_deep_sleep_allow
+	//uint32_t CLK8_CLK4_DS_CNTL;	    //dtbclk deep_sleep_divider
+	uint32_t CLK5_CLK0_BYPASS_CNTL; //dispclk bypass
+	uint32_t CLK5_CLK1_BYPASS_CNTL; //dppclk bypass
+	uint32_t CLK5_CLK2_BYPASS_CNTL; //dprefclk bypass
+	uint32_t CLK5_CLK3_BYPASS_CNTL; //dcfclk bypass
+	//uint32_t CLK5_CLK4_BYPASS_CNTL; //dtbclk bypass
+	uint32_t CLK5_CLK_TICK_CNT__TIMER_THRESHOLD;
+};
+
 /* Will these bw structures be ASIC specific? */
 
 #define MAX_NUM_DPM_LVL		8
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr_internal.h b/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr_internal.h
index 6ed1011457de..23c9798936c2 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr_internal.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr_internal.h
@@ -261,7 +261,37 @@ enum dentist_divider_range {
 	CLK_SF(CLK8_CLK3_DS_CNTL, CLK3_ALLOW_DS, mask_sh), \
 	CLK_SF(CLK8_CLK4_DS_CNTL, CLK4_ALLOW_DS, mask_sh), \
 
-
+#define CLK_REG_LIST_DCN42B()	  \
+	SR(DENTIST_DISPCLK_CNTL), \
+	CLK_SR_DCN42B(CLK5_CLK_TICK_CNT_CONFIG_REG), \
+	CLK_SR_DCN42B(CLK5_CLK0_CURRENT_CNT), \
+	CLK_SR_DCN42B(CLK5_CLK1_CURRENT_CNT), \
+	CLK_SR_DCN42B(CLK5_CLK2_CURRENT_CNT), \
+	CLK_SR_DCN42B(CLK5_CLK3_CURRENT_CNT), \
+	CLK_SR_DCN42B(CLK5_CLK0_DS_CNTL), \
+	CLK_SR_DCN42B(CLK5_CLK1_DS_CNTL), \
+	CLK_SR_DCN42B(CLK5_CLK2_DS_CNTL), \
+	CLK_SR_DCN42B(CLK5_CLK3_DS_CNTL), \
+	CLK_SR_DCN42B(CLK5_CLK0_BYPASS_CNTL), \
+	CLK_SR_DCN42B(CLK5_CLK1_BYPASS_CNTL), \
+	CLK_SR_DCN42B(CLK5_CLK2_BYPASS_CNTL), \
+	CLK_SR_DCN42B(CLK5_CLK3_BYPASS_CNTL)
+
+#define CLK_COMMON_MASK_SH_LIST_DCN42B(mask_sh) \
+	CLK_COMMON_MASK_SH_LIST_DCN20_BASE(mask_sh),\
+	CLK_SF(CLK5_CLK_TICK_CNT_CONFIG_REG, TIMER_THRESHOLD, mask_sh), \
+	CLK_SF(CLK5_CLK0_BYPASS_CNTL, CLK0_BYPASS_SEL, mask_sh), \
+	CLK_SF(CLK5_CLK1_BYPASS_CNTL, CLK1_BYPASS_SEL, mask_sh), \
+	CLK_SF(CLK5_CLK2_BYPASS_CNTL, CLK2_BYPASS_SEL, mask_sh), \
+	CLK_SF(CLK5_CLK3_BYPASS_CNTL, CLK3_BYPASS_SEL, mask_sh), \
+	CLK_SF(CLK5_CLK0_DS_CNTL, CLK0_DS_DIV_ID, mask_sh), \
+	CLK_SF(CLK5_CLK1_DS_CNTL, CLK1_DS_DIV_ID, mask_sh), \
+	CLK_SF(CLK5_CLK2_DS_CNTL, CLK2_DS_DIV_ID, mask_sh), \
+	CLK_SF(CLK5_CLK3_DS_CNTL, CLK3_DS_DIV_ID, mask_sh), \
+	CLK_SF(CLK5_CLK0_DS_CNTL, CLK0_ALLOW_DS, mask_sh), \
+	CLK_SF(CLK5_CLK1_DS_CNTL, CLK1_ALLOW_DS, mask_sh), \
+	CLK_SF(CLK5_CLK2_DS_CNTL, CLK2_ALLOW_DS, mask_sh), \
+	CLK_SF(CLK5_CLK3_DS_CNTL, CLK3_ALLOW_DS, mask_sh)
 
 #define CLK_REG_FIELD_LIST(type) \
 	type DPREFCLK_SRC_SEL; \
@@ -375,6 +405,7 @@ struct clk_mgr_registers {
 	uint32_t CLK5_spll_field_8;
 	uint32_t CLK6_spll_field_8;
 	CLK42_REG_LIST(8, uint32_t)
+	CLK42_REG_LIST(5, uint32_t)
 };
 
 struct clk_mgr_shift {
diff --git a/drivers/gpu/drm/amd/display/dc/inc/resource.h b/drivers/gpu/drm/amd/display/dc/inc/resource.h
index cecd3282a29f..d51fa22ce472 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/resource.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/resource.h
@@ -60,7 +60,9 @@ struct resource_caps {
 	int num_hpo_dp_stream_encoder;
 	int num_hpo_dp_link_encoder;
 	int num_mpc_3dlut;
+	int num_mpc;
 	int num_rmcm;
+	int num_aux;
 };
 
 struct resource_straps {
diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn42/dcn42_optc.h b/drivers/gpu/drm/amd/display/dc/optc/dcn42/dcn42_optc.h
index 8e7d65317e7c..d652358eea22 100644
--- a/drivers/gpu/drm/amd/display/dc/optc/dcn42/dcn42_optc.h
+++ b/drivers/gpu/drm/amd/display/dc/optc/dcn42/dcn42_optc.h
@@ -208,6 +208,185 @@
 	SF(OTG0_INTERRUPT_DEST, OTG0_IHC_OTG_VERTICAL_INTERRUPT2_DEST, mask_sh),\
 	SF(OPTC_CLOCK_CONTROL, OPTC_FGCG_REP_DIS, mask_sh)
 
+#define OPTC_COMMON_MASK_SH_LIST_DCN42B(mask_sh)\
+	SF(OTG0_OTG_VSTARTUP_PARAM, VSTARTUP_START, mask_sh),\
+	SF(OTG0_OTG_VUPDATE_PARAM, VUPDATE_OFFSET, mask_sh),\
+	SF(OTG0_OTG_VUPDATE_PARAM, VUPDATE_WIDTH, mask_sh),\
+	SF(OTG0_OTG_VREADY_PARAM, VREADY_OFFSET, mask_sh),\
+	SF(OTG0_OTG_MASTER_UPDATE_LOCK, OTG_MASTER_UPDATE_LOCK, mask_sh),\
+	SF(OTG0_OTG_MASTER_UPDATE_LOCK, UPDATE_LOCK_STATUS, mask_sh),\
+	SF(OTG0_OTG_GLOBAL_CONTROL0, MASTER_UPDATE_LOCK_DB_START_X, mask_sh),\
+	SF(OTG0_OTG_GLOBAL_CONTROL0, MASTER_UPDATE_LOCK_DB_END_X, mask_sh),\
+	SF(OTG0_OTG_GLOBAL_CONTROL0, MASTER_UPDATE_LOCK_DB_EN, mask_sh),\
+	SF(OTG0_OTG_GLOBAL_CONTROL1, MASTER_UPDATE_LOCK_DB_START_Y, mask_sh),\
+	SF(OTG0_OTG_GLOBAL_CONTROL1, MASTER_UPDATE_LOCK_DB_END_Y, mask_sh),\
+	SF(OTG0_OTG_GLOBAL_CONTROL2, OTG_MASTER_UPDATE_LOCK_SEL, mask_sh),\
+	SF(OTG0_OTG_GLOBAL_CONTROL4, DIG_UPDATE_POSITION_X, mask_sh),\
+	SF(OTG0_OTG_GLOBAL_CONTROL4, DIG_UPDATE_POSITION_Y, mask_sh),\
+	SF(OTG0_OTG_DOUBLE_BUFFER_CONTROL, OTG_UPDATE_PENDING, mask_sh),\
+	SF(OTG0_OTG_H_TOTAL, OTG_H_TOTAL, mask_sh),\
+	SF(OTG0_OTG_H_BLANK_START_END, OTG_H_BLANK_START, mask_sh),\
+	SF(OTG0_OTG_H_BLANK_START_END, OTG_H_BLANK_END, mask_sh),\
+	SF(OTG0_OTG_H_SYNC_A, OTG_H_SYNC_A_START, mask_sh),\
+	SF(OTG0_OTG_H_SYNC_A, OTG_H_SYNC_A_END, mask_sh),\
+	SF(OTG0_OTG_H_SYNC_A_CNTL, OTG_H_SYNC_A_POL, mask_sh),\
+	SF(OTG0_OTG_V_TOTAL, OTG_V_TOTAL, mask_sh),\
+	SF(OTG0_OTG_V_BLANK_START_END, OTG_V_BLANK_START, mask_sh),\
+	SF(OTG0_OTG_V_BLANK_START_END, OTG_V_BLANK_END, mask_sh),\
+	SF(OTG0_OTG_V_SYNC_A, OTG_V_SYNC_A_START, mask_sh),\
+	SF(OTG0_OTG_V_SYNC_A, OTG_V_SYNC_A_END, mask_sh),\
+	SF(OTG0_OTG_V_SYNC_A_CNTL, OTG_V_SYNC_A_POL, mask_sh),\
+	SF(OTG0_OTG_V_SYNC_A_CNTL, OTG_V_SYNC_MODE, mask_sh),\
+	SF(OTG0_OTG_CONTROL, OTG_MASTER_EN, mask_sh),\
+	SF(OTG0_OTG_CONTROL, OTG_START_POINT_CNTL, mask_sh),\
+	SF(OTG0_OTG_CONTROL, OTG_DISABLE_POINT_CNTL, mask_sh),\
+	SF(OTG0_OTG_CONTROL, OTG_FIELD_NUMBER_CNTL, mask_sh),\
+	SF(OTG0_OTG_CONTROL, OTG_OUT_MUX, mask_sh),\
+	SF(OTG0_OTG_STEREO_CONTROL, OTG_STEREO_EN, mask_sh),\
+	SF(OTG0_OTG_STEREO_CONTROL, OTG_STEREO_SYNC_OUTPUT_LINE_NUM, mask_sh),\
+	SF(OTG0_OTG_STEREO_CONTROL, OTG_STEREO_SYNC_OUTPUT_POLARITY, mask_sh),\
+	SF(OTG0_OTG_STEREO_CONTROL, OTG_STEREO_EYE_FLAG_POLARITY, mask_sh),\
+	SF(OTG0_OTG_STEREO_CONTROL, OTG_DISABLE_STEREOSYNC_OUTPUT_FOR_DP, mask_sh),\
+	SF(OTG0_OTG_STEREO_STATUS, OTG_STEREO_CURRENT_EYE, mask_sh),\
+	SF(OTG0_OTG_3D_STRUCTURE_CONTROL, OTG_3D_STRUCTURE_EN, mask_sh),\
+	SF(OTG0_OTG_3D_STRUCTURE_CONTROL, OTG_3D_STRUCTURE_V_UPDATE_MODE, mask_sh),\
+	SF(OTG0_OTG_3D_STRUCTURE_CONTROL, OTG_3D_STRUCTURE_STEREO_SEL_OVR, mask_sh),\
+	SF(OTG0_OTG_V_TOTAL_MAX, OTG_V_TOTAL_MAX, mask_sh),\
+	SF(OTG0_OTG_V_TOTAL_MIN, OTG_V_TOTAL_MIN, mask_sh),\
+	SF(OTG0_OTG_V_TOTAL_CONTROL, OTG_V_TOTAL_MIN_SEL, mask_sh),\
+	SF(OTG0_OTG_V_TOTAL_CONTROL, OTG_V_TOTAL_MAX_SEL, mask_sh),\
+	SF(OTG0_OTG_V_TOTAL_CONTROL, OTG_FORCE_LOCK_ON_EVENT, mask_sh),\
+	SF(OTG0_OTG_V_TOTAL_CONTROL, OTG_SET_V_TOTAL_MIN_MASK, mask_sh),\
+	SF(OTG0_OTG_V_TOTAL_CONTROL, OTG_VTOTAL_MID_REPLACING_MIN_EN, mask_sh),\
+	SF(OTG0_OTG_V_TOTAL_CONTROL, OTG_VTOTAL_MID_REPLACING_MAX_EN, mask_sh),\
+	SF(OTG0_OTG_FORCE_COUNT_NOW_CNTL, OTG_FORCE_COUNT_NOW_CLEAR, mask_sh),\
+	SF(OTG0_OTG_FORCE_COUNT_NOW_CNTL, OTG_FORCE_COUNT_NOW_MODE, mask_sh),\
+	SF(OTG0_OTG_FORCE_COUNT_NOW_CNTL, OTG_FORCE_COUNT_NOW_OCCURRED, mask_sh),\
+	SF(OTG0_OTG_TRIGA_CNTL, OTG_TRIGA_SOURCE_SELECT, mask_sh),\
+	SF(OTG0_OTG_TRIGA_CNTL, OTG_TRIGA_SOURCE_PIPE_SELECT, mask_sh),\
+	SF(OTG0_OTG_TRIGA_CNTL, OTG_TRIGA_RISING_EDGE_DETECT_CNTL, mask_sh),\
+	SF(OTG0_OTG_TRIGA_CNTL, OTG_TRIGA_FALLING_EDGE_DETECT_CNTL, mask_sh),\
+	SF(OTG0_OTG_TRIGA_CNTL, OTG_TRIGA_POLARITY_SELECT, mask_sh),\
+	SF(OTG0_OTG_TRIGA_CNTL, OTG_TRIGA_FREQUENCY_SELECT, mask_sh),\
+	SF(OTG0_OTG_TRIGA_CNTL, OTG_TRIGA_DELAY, mask_sh),\
+	SF(OTG0_OTG_TRIGA_CNTL, OTG_TRIGA_CLEAR, mask_sh),\
+	SF(OTG0_OTG_STATIC_SCREEN_CONTROL, OTG_STATIC_SCREEN_EVENT_MASK, mask_sh),\
+	SF(OTG0_OTG_STATIC_SCREEN_CONTROL, OTG_STATIC_SCREEN_FRAME_COUNT, mask_sh),\
+	SF(OTG0_OTG_STATUS_FRAME_COUNT, OTG_FRAME_COUNT, mask_sh),\
+	SF(OTG0_OTG_STATUS, OTG_V_BLANK, mask_sh),\
+	SF(OTG0_OTG_STATUS, OTG_V_ACTIVE_DISP, mask_sh),\
+	SF(OTG0_OTG_STATUS_POSITION, OTG_HORZ_COUNT, mask_sh),\
+	SF(OTG0_OTG_STATUS_POSITION, OTG_VERT_COUNT, mask_sh),\
+	SF(OTG0_OTG_NOM_VERT_POSITION, OTG_VERT_COUNT_NOM, mask_sh),\
+	SF(OTG0_OTG_M_CONST_DTO0, OTG_M_CONST_DTO_PHASE, mask_sh),\
+	SF(OTG0_OTG_M_CONST_DTO1, OTG_M_CONST_DTO_MODULO, mask_sh),\
+	SF(OTG0_OTG_CLOCK_CONTROL, OTG_BUSY, mask_sh),\
+	SF(OTG0_OTG_CLOCK_CONTROL, OTG_CLOCK_EN, mask_sh),\
+	SF(OTG0_OTG_CLOCK_CONTROL, OTG_CLOCK_ON, mask_sh),\
+	SF(OTG0_OTG_CLOCK_CONTROL, OTG_CLOCK_GATE_DIS, mask_sh),\
+	SF(OTG0_OTG_VERTICAL_INTERRUPT0_CONTROL, OTG_VERTICAL_INTERRUPT0_INT_ENABLE, mask_sh),\
+	SF(OTG0_OTG_VERTICAL_INTERRUPT0_POSITION, OTG_VERTICAL_INTERRUPT0_LINE_START, mask_sh),\
+	SF(OTG0_OTG_VERTICAL_INTERRUPT0_POSITION, OTG_VERTICAL_INTERRUPT0_LINE_END, mask_sh),\
+	SF(OTG0_OTG_VERTICAL_INTERRUPT1_CONTROL, OTG_VERTICAL_INTERRUPT1_INT_ENABLE, mask_sh),\
+	SF(OTG0_OTG_VERTICAL_INTERRUPT1_POSITION, OTG_VERTICAL_INTERRUPT1_LINE_START, mask_sh),\
+	SF(OTG0_OTG_VERTICAL_INTERRUPT2_CONTROL, OTG_VERTICAL_INTERRUPT2_INT_ENABLE, mask_sh),\
+	SF(OTG0_OTG_VERTICAL_INTERRUPT2_POSITION, OTG_VERTICAL_INTERRUPT2_LINE_START, mask_sh),\
+	SF(ODM0_OPTC_INPUT_CLOCK_CONTROL, OPTC_INPUT_CLK_EN, mask_sh),\
+	SF(ODM0_OPTC_INPUT_CLOCK_CONTROL, OPTC_INPUT_CLK_ON, mask_sh),\
+	SF(ODM0_OPTC_INPUT_CLOCK_CONTROL, OPTC_INPUT_CLK_GATE_DIS, mask_sh),\
+	SF(ODM0_OPTC_INPUT_GLOBAL_CONTROL, OPTC_UNDERFLOW_OCCURRED_STATUS, mask_sh),\
+	SF(ODM0_OPTC_INPUT_GLOBAL_CONTROL, OPTC_DOUBLE_BUFFER_PENDING, mask_sh),\
+	SF(ODM0_OPTC_INPUT_GLOBAL_CONTROL, OPTC_UNDERFLOW_CLEAR, mask_sh),\
+	SF(ODM0_OPTC_RSMU_UNDERFLOW, OPTC_RSMU_UNDERFLOW_OCCURRED_STATUS, mask_sh),\
+	SF(ODM0_OPTC_RSMU_UNDERFLOW, OPTC_RSMU_UNDERFLOW_CLEAR, mask_sh),\
+	SF(ODM0_OPTC_RSMU_UNDERFLOW, OPTC_RSMU_UNDERFLOW_INT_EN, mask_sh),\
+	SF(ODM0_OPTC_RSMU_UNDERFLOW, OPTC_RSMU_UNDERFLOW_INT_STATUS, mask_sh),\
+	SF(VTG0_CONTROL, VTG0_ENABLE, mask_sh),\
+	SF(VTG0_CONTROL, VTG0_FP2, mask_sh),\
+	SF(VTG0_CONTROL, VTG0_VCOUNT_INIT, mask_sh),\
+	SF(OTG0_OTG_VERT_SYNC_CONTROL, OTG_FORCE_VSYNC_NEXT_LINE_OCCURRED, mask_sh),\
+	SF(OTG0_OTG_VERT_SYNC_CONTROL, OTG_FORCE_VSYNC_NEXT_LINE_CLEAR, mask_sh),\
+	SF(OTG0_OTG_VERT_SYNC_CONTROL, OTG_AUTO_FORCE_VSYNC_MODE, mask_sh),\
+	SF(OTG0_OTG_GSL_CONTROL, OTG_GSL0_EN, mask_sh),\
+	SF(OTG0_OTG_GSL_CONTROL, OTG_GSL1_EN, mask_sh),\
+	SF(OTG0_OTG_GSL_CONTROL, OTG_GSL2_EN, mask_sh),\
+	SF(OTG0_OTG_GSL_CONTROL, OTG_GSL_MASTER_EN, mask_sh),\
+	SF(OTG0_OTG_GSL_CONTROL, OTG_GSL_FORCE_DELAY, mask_sh),\
+	SF(OTG0_OTG_GSL_CONTROL, OTG_GSL_CHECK_ALL_FIELDS, mask_sh),\
+	SF(OTG0_OTG_CRC_CNTL, OTG_CRC_CONT_EN, mask_sh),\
+	SF(OTG0_OTG_CRC_CNTL, OTG_CRC0_SELECT, mask_sh),\
+	SF(OTG0_OTG_CRC_CNTL, OTG_CRC_EN, mask_sh),\
+	SF(OTG0_OTG_CRC0_DATA_R, CRC0_R_CR, mask_sh),\
+	SF(OTG0_OTG_CRC0_DATA_G, CRC0_G_Y, mask_sh),\
+	SF(OTG0_OTG_CRC0_DATA_B, CRC0_B_CB, mask_sh),\
+	SF(OTG0_OTG_CRC1_DATA_R, CRC1_R_CR, mask_sh),\
+	SF(OTG0_OTG_CRC1_DATA_G, CRC1_G_Y, mask_sh),\
+	SF(OTG0_OTG_CRC1_DATA_B, CRC1_B_CB, mask_sh),\
+	SF(OTG0_OTG_CRC0_WINDOWA_X_CONTROL, OTG_CRC0_WINDOWA_X_START, mask_sh),\
+	SF(OTG0_OTG_CRC0_WINDOWA_X_CONTROL, OTG_CRC0_WINDOWA_X_END, mask_sh),\
+	SF(OTG0_OTG_CRC0_WINDOWA_Y_CONTROL, OTG_CRC0_WINDOWA_Y_START, mask_sh),\
+	SF(OTG0_OTG_CRC0_WINDOWA_Y_CONTROL, OTG_CRC0_WINDOWA_Y_END, mask_sh),\
+	SF(OTG0_OTG_CRC0_WINDOWB_X_CONTROL, OTG_CRC0_WINDOWB_X_START, mask_sh),\
+	SF(OTG0_OTG_CRC0_WINDOWB_X_CONTROL, OTG_CRC0_WINDOWB_X_END, mask_sh),\
+	SF(OTG0_OTG_CRC0_WINDOWB_Y_CONTROL, OTG_CRC0_WINDOWB_Y_START, mask_sh),\
+	SF(OTG0_OTG_CRC0_WINDOWB_Y_CONTROL, OTG_CRC0_WINDOWB_Y_END, mask_sh),\
+	SF(OTG0_OTG_CRC1_WINDOWA_X_CONTROL, OTG_CRC1_WINDOWA_X_START, mask_sh),\
+	SF(OTG0_OTG_CRC1_WINDOWA_X_CONTROL, OTG_CRC1_WINDOWA_X_END, mask_sh),\
+	SF(OTG0_OTG_CRC1_WINDOWA_Y_CONTROL, OTG_CRC1_WINDOWA_Y_START, mask_sh),\
+	SF(OTG0_OTG_CRC1_WINDOWA_Y_CONTROL, OTG_CRC1_WINDOWA_Y_END, mask_sh),\
+	SF(OTG0_OTG_CRC1_WINDOWB_X_CONTROL, OTG_CRC1_WINDOWB_X_START, mask_sh),\
+	SF(OTG0_OTG_CRC1_WINDOWB_X_CONTROL, OTG_CRC1_WINDOWB_X_END, mask_sh),\
+	SF(OTG0_OTG_CRC1_WINDOWB_Y_CONTROL, OTG_CRC1_WINDOWB_Y_START, mask_sh),\
+	SF(OTG0_OTG_CRC1_WINDOWB_Y_CONTROL, OTG_CRC1_WINDOWB_Y_END, mask_sh),\
+	SF(OTG0_OTG_TRIGA_MANUAL_TRIG, OTG_TRIGA_MANUAL_TRIG, mask_sh),\
+	SF(GSL_SOURCE_SELECT, GSL0_READY_SOURCE_SEL, mask_sh),\
+	SF(GSL_SOURCE_SELECT, GSL1_READY_SOURCE_SEL, mask_sh),\
+	SF(GSL_SOURCE_SELECT, GSL2_READY_SOURCE_SEL, mask_sh),\
+	SF(OTG0_OTG_GLOBAL_CONTROL2, GLOBAL_UPDATE_LOCK_EN, mask_sh),\
+	SF(OTG0_OTG_GSL_WINDOW_X, OTG_GSL_WINDOW_START_X, mask_sh),\
+	SF(OTG0_OTG_GSL_WINDOW_X, OTG_GSL_WINDOW_END_X, mask_sh), \
+	SF(OTG0_OTG_GSL_WINDOW_Y, OTG_GSL_WINDOW_START_Y, mask_sh),\
+	SF(OTG0_OTG_GSL_WINDOW_Y, OTG_GSL_WINDOW_END_Y, mask_sh),\
+	SF(OTG0_OTG_VUPDATE_KEEPOUT, OTG_MASTER_UPDATE_LOCK_VUPDATE_KEEPOUT_EN, mask_sh), \
+	SF(OTG0_OTG_VUPDATE_KEEPOUT, MASTER_UPDATE_LOCK_VUPDATE_KEEPOUT_START_OFFSET, mask_sh), \
+	SF(OTG0_OTG_VUPDATE_KEEPOUT, MASTER_UPDATE_LOCK_VUPDATE_KEEPOUT_END_OFFSET, mask_sh), \
+	SF(OTG0_OTG_GSL_CONTROL, OTG_GSL_MASTER_MODE, mask_sh), \
+	SF(OTG0_OTG_GSL_CONTROL, OTG_MASTER_UPDATE_LOCK_GSL_EN, mask_sh), \
+	SF(ODM0_OPTC_DATA_SOURCE_SELECT, OPTC_SEG0_SRC_SEL, mask_sh),\
+	SF(ODM0_OPTC_DATA_SOURCE_SELECT, OPTC_SEG1_SRC_SEL, mask_sh),\
+	SF(ODM0_OPTC_DATA_SOURCE_SELECT, OPTC_SEG2_SRC_SEL, mask_sh),\
+	SF(ODM0_OPTC_DATA_SOURCE_SELECT, OPTC_SEG3_SRC_SEL, mask_sh),\
+	SF(ODM0_OPTC_DATA_SOURCE_SELECT, OPTC_NUM_OF_INPUT_SEGMENT, mask_sh),\
+	SF(ODM0_OPTC_MEMORY_CONFIG, OPTC_MEM_SEL, mask_sh),\
+	SF(ODM0_OPTC_DATA_FORMAT_CONTROL, OPTC_DATA_FORMAT, mask_sh),\
+	SF(ODM0_OPTC_DATA_FORMAT_CONTROL, OPTC_DSC_MODE, mask_sh),\
+	SF(ODM0_OPTC_BYTES_PER_PIXEL, OPTC_DSC_BYTES_PER_PIXEL, mask_sh),\
+	SF(ODM0_OPTC_WIDTH_CONTROL, OPTC_DSC_SLICE_WIDTH, mask_sh),\
+	SF(ODM0_OPTC_WIDTH_CONTROL, OPTC_SEGMENT_WIDTH, mask_sh),\
+	SF(ODM0_OPTC_WIDTH_CONTROL2, OPTC_SEGMENT_WIDTH_LAST, mask_sh),\
+	SF(OTG0_OTG_DRR_TRIGGER_WINDOW, OTG_DRR_TRIGGER_WINDOW_START_X, mask_sh),\
+	SF(OTG0_OTG_DRR_TRIGGER_WINDOW, OTG_DRR_TRIGGER_WINDOW_END_X, mask_sh),\
+	SF(OTG0_OTG_DRR_V_TOTAL_CHANGE, OTG_DRR_V_TOTAL_CHANGE_LIMIT, mask_sh),\
+	SF(OTG0_OTG_H_TIMING_CNTL, OTG_H_TIMING_DIV_MODE, mask_sh),\
+	SF(OTG0_OTG_H_TIMING_CNTL, OTG_H_TIMING_DIV_MODE_MANUAL, mask_sh),\
+	SF(OTG0_OTG_DOUBLE_BUFFER_CONTROL, OTG_DRR_TIMING_DBUF_UPDATE_MODE, mask_sh),\
+	SF(OTG0_OTG_DRR_CONTROL, OTG_V_TOTAL_LAST_USED_BY_DRR, mask_sh),\
+	SF(OTG0_OTG_PSTATE_REGISTER, OTG_PSTATE_KEEPOUT_START, mask_sh),\
+	SF(OTG0_OTG_PSTATE_REGISTER, OTG_PSTATE_EXTEND, mask_sh),\
+	SF(OTG0_OTG_PSTATE_REGISTER, OTG_UNBLANK, mask_sh),\
+	SF(OTG0_OTG_PSTATE_REGISTER, OTG_PSTATE_ALLOW_WIDTH_MIN, mask_sh),\
+	SF(OTG0_OTG_PIPE_UPDATE_STATUS, OTG_FLIP_PENDING, mask_sh),\
+	SF(OTG0_OTG_PIPE_UPDATE_STATUS, OTG_DC_REG_UPDATE_PENDING, mask_sh),\
+	SF(OTG0_OTG_PIPE_UPDATE_STATUS, OTG_CURSOR_UPDATE_PENDING, mask_sh),\
+	SF(OTG0_OTG_PIPE_UPDATE_STATUS, OTG_VUPDATE_KEEPOUT_STATUS, mask_sh),\
+	SF(OTG0_OTG_PWA_FRAME_SYNC_CONTROL, OTG_PWA_FRAME_SYNC_EN, mask_sh),\
+	SF(OTG0_OTG_PWA_FRAME_SYNC_CONTROL, OTG_PWA_FRAME_SYNC_VCOUNT_MODE, mask_sh),\
+	SF(OTG0_OTG_PWA_FRAME_SYNC_CONTROL, OTG_PWA_FRAME_SYNC_LINE, mask_sh),\
+	SF(OTG0_INTERRUPT_DEST, OTG0_IHC_OTG_VERTICAL_INTERRUPT2_DEST, mask_sh),\
+	SF(OPTC_CLOCK_CONTROL, OPTC_FGCG_REP_DIS, mask_sh),\
+	SF(OTG0_OTG_CONTROL, OTG_CURRENT_MASTER_EN_STATE, mask_sh),\
+	SF(OTG0_OTG_DOUBLE_BUFFER_CONTROL, OTG_DRR_TIMING_DBUF_UPDATE_PENDING, mask_sh)
+
 void dcn42_timing_generator_init(struct optc *optc1);
 void optc42_enable_pwa(struct timing_generator *optc, struct otc_pwa_frame_sync *pwa_sync_param);
 void optc42_disable_pwa(struct timing_generator *optc);
diff --git a/drivers/gpu/drm/amd/display/dc/pg/dcn42/dcn42_pg_cntl.h b/drivers/gpu/drm/amd/display/dc/pg/dcn42/dcn42_pg_cntl.h
index a0aa14a796f4..7e8f4f03ae0e 100644
--- a/drivers/gpu/drm/amd/display/dc/pg/dcn42/dcn42_pg_cntl.h
+++ b/drivers/gpu/drm/amd/display/dc/pg/dcn42/dcn42_pg_cntl.h
@@ -36,6 +36,35 @@
 	SR(DOMAIN26_PG_STATUS), \
 	SR(DC_IP_REQUEST_CNTL)
 
+#define PG_CNTL_REG_LIST_DCN42B()\
+	SR(DOMAIN0_PG_CONFIG), \
+	SR(DOMAIN1_PG_CONFIG), \
+	SR(DOMAIN2_PG_CONFIG), \
+	SR(DOMAIN3_PG_CONFIG), \
+	SR(DOMAIN16_PG_CONFIG), \
+	SR(DOMAIN17_PG_CONFIG), \
+	SR(DOMAIN18_PG_CONFIG), \
+	/* SR(DOMAIN19_PG_CONFIG), */ \
+	SR(DOMAIN22_PG_CONFIG), \
+	SR(DOMAIN23_PG_CONFIG), \
+	SR(DOMAIN24_PG_CONFIG), \
+	SR(DOMAIN25_PG_CONFIG), \
+	SR(DOMAIN26_PG_CONFIG), \
+	SR(DOMAIN0_PG_STATUS), \
+	SR(DOMAIN1_PG_STATUS), \
+	SR(DOMAIN2_PG_STATUS), \
+	SR(DOMAIN3_PG_STATUS), \
+	SR(DOMAIN16_PG_STATUS), \
+	SR(DOMAIN17_PG_STATUS), \
+	SR(DOMAIN18_PG_STATUS), \
+	/* SR(DOMAIN19_PG_CONFIG), */ \
+	SR(DOMAIN22_PG_STATUS), \
+	SR(DOMAIN23_PG_STATUS), \
+	SR(DOMAIN24_PG_STATUS), \
+	SR(DOMAIN25_PG_STATUS), \
+	SR(DOMAIN26_PG_STATUS), \
+	SR(DC_IP_REQUEST_CNTL)
+
 #define PG_CNTL_SF(reg_name, field_name, post_fix)\
 	.field_name = reg_name ## __ ## field_name ## post_fix
 
@@ -94,6 +123,63 @@
 	PG_CNTL_SF(DOMAIN26_PG_STATUS, DOMAIN_PGFSM_PWR_STATUS, mask_sh), \
 	PG_CNTL_SF(DC_IP_REQUEST_CNTL, IP_REQUEST_EN, mask_sh)
 
+/* Not in DCN42B:
+ * PG_CNTL_SF(DOMAIN19_PG_CONFIG, DOMAIN_POWER_FORCEON, mask_sh),
+ * PG_CNTL_SF(DOMAIN19_PG_CONFIG, DOMAIN_POWER_GATE, mask_sh),
+ * PG_CNTL_SF(DOMAIN19_PG_STATUS, DOMAIN_DESIRED_PWR_STATE, mask_sh),
+ * PG_CNTL_SF(DOMAIN19_PG_STATUS, DOMAIN_PGFSM_PWR_STATUS, mask_sh),
+ */
+#define PG_CNTL_MASK_SH_LIST_DCN42B(mask_sh) \
+	PG_CNTL_SF(DOMAIN0_PG_CONFIG, DOMAIN_POWER_FORCEON, mask_sh), \
+	PG_CNTL_SF(DOMAIN0_PG_CONFIG, DOMAIN_POWER_GATE, mask_sh), \
+	PG_CNTL_SF(DOMAIN1_PG_CONFIG, DOMAIN_POWER_FORCEON, mask_sh), \
+	PG_CNTL_SF(DOMAIN1_PG_CONFIG, DOMAIN_POWER_GATE, mask_sh), \
+	PG_CNTL_SF(DOMAIN2_PG_CONFIG, DOMAIN_POWER_FORCEON, mask_sh), \
+	PG_CNTL_SF(DOMAIN2_PG_CONFIG, DOMAIN_POWER_GATE, mask_sh), \
+	PG_CNTL_SF(DOMAIN3_PG_CONFIG, DOMAIN_POWER_FORCEON, mask_sh), \
+	PG_CNTL_SF(DOMAIN3_PG_CONFIG, DOMAIN_POWER_GATE, mask_sh), \
+	PG_CNTL_SF(DOMAIN16_PG_CONFIG, DOMAIN_POWER_FORCEON, mask_sh), \
+	PG_CNTL_SF(DOMAIN16_PG_CONFIG, DOMAIN_POWER_GATE, mask_sh), \
+	PG_CNTL_SF(DOMAIN17_PG_CONFIG, DOMAIN_POWER_FORCEON, mask_sh), \
+	PG_CNTL_SF(DOMAIN17_PG_CONFIG, DOMAIN_POWER_GATE, mask_sh), \
+	PG_CNTL_SF(DOMAIN18_PG_CONFIG, DOMAIN_POWER_FORCEON, mask_sh), \
+	PG_CNTL_SF(DOMAIN18_PG_CONFIG, DOMAIN_POWER_GATE, mask_sh), \
+	PG_CNTL_SF(DOMAIN22_PG_CONFIG, DOMAIN_POWER_FORCEON, mask_sh), \
+	PG_CNTL_SF(DOMAIN22_PG_CONFIG, DOMAIN_POWER_GATE, mask_sh), \
+	PG_CNTL_SF(DOMAIN23_PG_CONFIG, DOMAIN_POWER_FORCEON, mask_sh), \
+	PG_CNTL_SF(DOMAIN23_PG_CONFIG, DOMAIN_POWER_GATE, mask_sh), \
+	PG_CNTL_SF(DOMAIN24_PG_CONFIG, DOMAIN_POWER_FORCEON, mask_sh), \
+	PG_CNTL_SF(DOMAIN24_PG_CONFIG, DOMAIN_POWER_GATE, mask_sh), \
+	PG_CNTL_SF(DOMAIN25_PG_CONFIG, DOMAIN_POWER_FORCEON, mask_sh), \
+	PG_CNTL_SF(DOMAIN25_PG_CONFIG, DOMAIN_POWER_GATE, mask_sh), \
+	PG_CNTL_SF(DOMAIN26_PG_CONFIG, DOMAIN_POWER_FORCEON, mask_sh), \
+	PG_CNTL_SF(DOMAIN26_PG_CONFIG, DOMAIN_POWER_GATE, mask_sh), \
+	PG_CNTL_SF(DOMAIN0_PG_STATUS, DOMAIN_DESIRED_PWR_STATE, mask_sh), \
+	PG_CNTL_SF(DOMAIN0_PG_STATUS, DOMAIN_PGFSM_PWR_STATUS, mask_sh), \
+	PG_CNTL_SF(DOMAIN1_PG_STATUS, DOMAIN_DESIRED_PWR_STATE, mask_sh), \
+	PG_CNTL_SF(DOMAIN1_PG_STATUS, DOMAIN_PGFSM_PWR_STATUS, mask_sh), \
+	PG_CNTL_SF(DOMAIN2_PG_STATUS, DOMAIN_DESIRED_PWR_STATE, mask_sh), \
+	PG_CNTL_SF(DOMAIN2_PG_STATUS, DOMAIN_PGFSM_PWR_STATUS, mask_sh), \
+	PG_CNTL_SF(DOMAIN3_PG_STATUS, DOMAIN_DESIRED_PWR_STATE, mask_sh), \
+	PG_CNTL_SF(DOMAIN3_PG_STATUS, DOMAIN_PGFSM_PWR_STATUS, mask_sh), \
+	PG_CNTL_SF(DOMAIN16_PG_STATUS, DOMAIN_DESIRED_PWR_STATE, mask_sh), \
+	PG_CNTL_SF(DOMAIN16_PG_STATUS, DOMAIN_PGFSM_PWR_STATUS, mask_sh), \
+	PG_CNTL_SF(DOMAIN17_PG_STATUS, DOMAIN_DESIRED_PWR_STATE, mask_sh), \
+	PG_CNTL_SF(DOMAIN17_PG_STATUS, DOMAIN_PGFSM_PWR_STATUS, mask_sh), \
+	PG_CNTL_SF(DOMAIN18_PG_STATUS, DOMAIN_DESIRED_PWR_STATE, mask_sh), \
+	PG_CNTL_SF(DOMAIN18_PG_STATUS, DOMAIN_PGFSM_PWR_STATUS, mask_sh), \
+	PG_CNTL_SF(DOMAIN22_PG_STATUS, DOMAIN_DESIRED_PWR_STATE, mask_sh), \
+	PG_CNTL_SF(DOMAIN22_PG_STATUS, DOMAIN_PGFSM_PWR_STATUS, mask_sh), \
+	PG_CNTL_SF(DOMAIN23_PG_STATUS, DOMAIN_DESIRED_PWR_STATE, mask_sh), \
+	PG_CNTL_SF(DOMAIN23_PG_STATUS, DOMAIN_PGFSM_PWR_STATUS, mask_sh), \
+	PG_CNTL_SF(DOMAIN24_PG_STATUS, DOMAIN_DESIRED_PWR_STATE, mask_sh), \
+	PG_CNTL_SF(DOMAIN24_PG_STATUS, DOMAIN_PGFSM_PWR_STATUS, mask_sh), \
+	PG_CNTL_SF(DOMAIN25_PG_STATUS, DOMAIN_DESIRED_PWR_STATE, mask_sh), \
+	PG_CNTL_SF(DOMAIN25_PG_STATUS, DOMAIN_PGFSM_PWR_STATUS, mask_sh), \
+	PG_CNTL_SF(DOMAIN26_PG_STATUS, DOMAIN_DESIRED_PWR_STATE, mask_sh), \
+	PG_CNTL_SF(DOMAIN26_PG_STATUS, DOMAIN_PGFSM_PWR_STATUS, mask_sh), \
+	PG_CNTL_SF(DC_IP_REQUEST_CNTL, IP_REQUEST_EN, mask_sh)
+
 struct pg_cntl_shift {
 	uint8_t IP_REQUEST_EN;
 	uint8_t DOMAIN_POWER_FORCEON;
diff --git a/drivers/gpu/drm/amd/display/dc/resource/Makefile b/drivers/gpu/drm/amd/display/dc/resource/Makefile
index 1a17a885fe84..fe02ed39a3e9 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/resource/Makefile
@@ -239,5 +239,12 @@ CFLAGS_$(AMDDALPATH)/dc/resource/dcn42/dcn42_resource_fpu.o := $(resource_ccflag
 CFLAGS_REMOVE_$(AMDDALPATH)/dc/resource/dcn42/dcn42_resource_fpu.o := $(resource_rcflags)
 
 ###############################################################################
+# DCN42B
+###############################################################################
+RESOURCE_DCN42B = dcn42b_resource.o
+
+AMD_DAL_RESOURCE_DCN42B = $(addprefix $(AMDDALPATH)/dc/resource/dcn42b/,$(RESOURCE_DCN42B))
+
+AMD_DISPLAY_FILES += $(AMD_DAL_RESOURCE_DCN42B)
 endif
 
diff --git a/drivers/gpu/drm/amd/display/dc/soc_and_ip_translator/dcn42/dcn42_soc_and_ip_translator.c b/drivers/gpu/drm/amd/display/dc/soc_and_ip_translator/dcn42/dcn42_soc_and_ip_translator.c
index e0802359829e..ae2c6a2f3f75 100644
--- a/drivers/gpu/drm/amd/display/dc/soc_and_ip_translator/dcn42/dcn42_soc_and_ip_translator.c
+++ b/drivers/gpu/drm/amd/display/dc/soc_and_ip_translator/dcn42/dcn42_soc_and_ip_translator.c
@@ -5,6 +5,7 @@
 #include "dcn42_soc_and_ip_translator.h"
 #include "../dcn401/dcn401_soc_and_ip_translator.h"
 #include "bounding_boxes/dcn42_soc_bb.h"
+#include "bounding_boxes/dcn42b_soc_bb.h"
 
 /* soc_and_ip_translator component used to get up-to-date values for bounding box.
  * Bounding box values are stored in several locations and locations can vary with DCN revision.
@@ -13,7 +14,10 @@
 
 static void get_default_soc_bb(struct dml2_soc_bb *soc_bb, const struct dc *dc)
 {
-	{
+	if (dc->ctx->dce_version == DCN_VERSION_4_2B) {
+		memcpy(soc_bb, &dml2_socbb_dcn42b, sizeof(struct dml2_soc_bb));
+		memcpy(&soc_bb->qos_parameters, &dml_dcn42b_variant_a_soc_qos_params, sizeof(struct dml2_soc_qos_parameters));
+	} else {
 		memcpy(soc_bb, &dml2_socbb_dcn42, sizeof(struct dml2_soc_bb));
 		memcpy(&soc_bb->qos_parameters, &dml_dcn42_variant_a_soc_qos_params, sizeof(struct dml2_soc_qos_parameters));
 	}
diff --git a/drivers/gpu/drm/amd/display/dc/soc_and_ip_translator/soc_and_ip_translator.c b/drivers/gpu/drm/amd/display/dc/soc_and_ip_translator/soc_and_ip_translator.c
index bc1487d4ebda..e6887cac5884 100644
--- a/drivers/gpu/drm/amd/display/dc/soc_and_ip_translator/soc_and_ip_translator.c
+++ b/drivers/gpu/drm/amd/display/dc/soc_and_ip_translator/soc_and_ip_translator.c
@@ -14,6 +14,7 @@ static void dc_construct_soc_and_ip_translator(struct soc_and_ip_translator *soc
 		dcn401_construct_soc_and_ip_translator(soc_and_ip_translator);
 		break;
 	case DCN_VERSION_4_2:
+	case DCN_VERSION_4_2B:
 		dcn42_construct_soc_and_ip_translator(soc_and_ip_translator);
 		break;
 	default:
diff --git a/drivers/gpu/drm/amd/display/include/dal_asic_id.h b/drivers/gpu/drm/amd/display/include/dal_asic_id.h
index 92510af1bd65..7d8944d27d92 100644
--- a/drivers/gpu/drm/amd/display/include/dal_asic_id.h
+++ b/drivers/gpu/drm/amd/display/include/dal_asic_id.h
@@ -279,6 +279,9 @@ enum {
 #define ASICREV_IS_DCN4(eChipRev)	(eChipRev >= GC_12_0_1_A0 && eChipRev < GC_12_0_0_A0)
 #define ASICREV_IS_DCN401(eChipRev)	(eChipRev >= GC_12_0_0_A0 && eChipRev < GC_12_UNKNOWN)
 
+#define DCN4A_SOC_VAR_B_A0 0xD0
+#define ASICREV_IS_DCN4A_SOC_VAR_B(eChipRev) ((eChipRev >= DCN4A_SOC_VAR_B_A0) && (eChipRev < 0xE0))
+
 /*
  * ASIC chip ID
  */
diff --git a/drivers/gpu/drm/amd/display/include/dal_types.h b/drivers/gpu/drm/amd/display/include/dal_types.h
index d30eb24cf11e..f77fc367eab1 100644
--- a/drivers/gpu/drm/amd/display/include/dal_types.h
+++ b/drivers/gpu/drm/amd/display/include/dal_types.h
@@ -66,6 +66,7 @@ enum dce_version {
 	DCN_VERSION_3_6,
 	DCN_VERSION_4_01,
 	DCN_VERSION_4_2,
+	DCN_VERSION_4_2B,
 	DCN_VERSION_MAX
 };
 
-- 
2.43.0

