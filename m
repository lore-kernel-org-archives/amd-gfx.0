Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F691C433EF
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Jul 2022 22:09:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A304B10ED77;
	Fri,  8 Jul 2022 22:09:22 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2068.outbound.protection.outlook.com [40.107.95.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9838E10ED7A
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Jul 2022 22:09:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cZTpIOjWWJiLxLvDIIA9ORiPvEOZdXK3ysO9H8dGz11YMZ0jLOMZTBSW0RVcqrNZQZJt9oXL8yjcGPdPCUI5R84lKGknNFUMSzWLoUNR0yOf+Tlvi+9d8d1V8FiquEODXbGmyw7hp6pefbumtDpJZKIWRiaKppZGcx9OOkRzlOiarfTUnkK13DjYKx+y6Jnf/bdqdxZLuOSLfRYH/ZghMRSE7/qIw2R/QfKGpFDNK6riqoiaE57qz65MAYcaD4WZ6w73z35Gqow9WD23WbeeMnjgOc5VGJjVkJ/S6ApvAy0h3RsIVJbL+MhjhEroFDlsrnvdm/aANaF3sidSVrf4Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PG1WyWjoOvMCoQw8GwvV7QUnaXg5LLeW3AwgN5bUypc=;
 b=iBrfa1eZ2IZojVnr009x1k76TyCe9Nn487TERMrHuHHavAg2rDgeRxcwStkl4NWDBM1a79gq/6m+C1FQPk3zy76QNVji8rr+fCq+DeKxEX72iHWOOgRa1b3lxlKZdLsyhmZ+cLge/NWsj/uECqD1Cb+tDfdjU4ExaH/bckhTqhisr+yvJEfzBVLCUHlRC7L6YD2+ofLNGYUl575dfi69c7x0bK3/IiAoAc4gGeN6TiZU9/XlAKF5zSdgerxDfixtDI1vTNr9G8fJ93GYKEJKr0NCJMFATLPA/P8jGadz8No8iinBfKWBIBMptngacZ5BV1mMNDFvAmO343EbmVRLEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PG1WyWjoOvMCoQw8GwvV7QUnaXg5LLeW3AwgN5bUypc=;
 b=px+X/CqZRp3SBzd6aFgf8Zewdq+s2UeFc+r4jSy4tChnBpKR6Ly0BmbAn7iWGgnKCG9QtRoiRfDiZVKWL0Qzjrv9bagHz5BLnMaFA5aqgMu6R4g+6x7ktNWfEklbLXiaIqQpvgnzQ2GKSXl85OJ0nYxFEFeD5JZeRPhaRrfC6bE=
Received: from DM6PR05CA0063.namprd05.prod.outlook.com (2603:10b6:5:335::32)
 by IA1PR12MB6459.namprd12.prod.outlook.com (2603:10b6:208:3a9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Fri, 8 Jul
 2022 22:09:14 +0000
Received: from DM6NAM11FT010.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:335:cafe::6f) by DM6PR05CA0063.outlook.office365.com
 (2603:10b6:5:335::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.7 via Frontend
 Transport; Fri, 8 Jul 2022 22:09:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT010.mail.protection.outlook.com (10.13.172.222) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5417.15 via Frontend Transport; Fri, 8 Jul 2022 22:09:14 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 8 Jul
 2022 17:09:12 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 7/9] drm/amd/display: Enable DCN314 in DC
Date: Fri, 8 Jul 2022 18:08:53 -0400
Message-ID: <20220708220855.1475213-7-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220708220855.1475213-1-alexander.deucher@amd.com>
References: <20220708220855.1475213-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 400aafaa-a34e-428c-c1bd-08da612e7e7a
X-MS-TrafficTypeDiagnostic: IA1PR12MB6459:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OmeXxkxcYk5yDLs5kVi2/fcOPCBR0bq9iw3jIOkNuicLiga9bvtt1t66y75/NwuR6Ig666BH6ug6dLROhJyyTXNMy1QwVBdY1I9t13aRVjjuMT8ITxO6CzYZurvzsIJ0jgd0JBsOt7LbVI9xgO/KSFteeTQZys2m9SRDWazjV+CUfVGr1Gtzbn0/FQpRIs6Sni5yh/rMG38bOtMad+bjK00/Ts+g2VU2/hD/8egOporkuBz8mVAKFRBmGnp+8bGo40qruYkcOSEmMp10Y2t8toF+BbwOrrIcrgQN13kSfU29qrzXeHc8X4bH2tE3MFUlMTx7nGMQDkDSeExKKNISl0d229Jjn3w0tagnEinbT9+xarYivgqoRzHVgz10JrJnJiVSBc5WJCqFLUWf19xV7pXlyBz1oLDxpFu94uzR7djxt1/pzZ+5k0EwYQLm1gUHgJX7GQoVWs3W46nEufhI3fmH2MtarJfBxfUQSR75scW9jMSdV/RPMexIjn0aF3rbqNZfYaCiKssly8DeVO4y7JZ+lLZjGWTIwrg6tI9DGsthDY2OcdJ24kki91xDvhtHQsEw2+g0dzPUhUxRcj4Qf9goy8AgZTCIjbnHTsdGd1tuiaimgYP7EUhPrnNFvmPZYH5MsubK8USkIAGPnN86cRdgGybwQFDzw19c+YEaESzbQinorv037dUZb1TIoYu18rHf6s4Q9Kx9SRm4s4wqhJ1mvK3VzHmYPbiGTGtBsXzrPOJBJ0MEWauQaHTbGD+XAzXpvyWwRV+3erqq1X0sIElE0qDcnoEeRbQNJJ+VinNyDY3CiIbHgoCDxhu+eOzxSfhjwy07b779v4gJztGYUwDtAJ4R3F1KelO16cL0nX0USNsbJ6XhvdZeOTBq7SHu
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(346002)(39860400002)(396003)(136003)(46966006)(36840700001)(40470700004)(2906002)(86362001)(8936002)(336012)(6666004)(41300700001)(8676002)(478600001)(356005)(4326008)(70586007)(82740400003)(36860700001)(426003)(70206006)(7696005)(83380400001)(40480700001)(34020700004)(5660300002)(6916009)(316002)(40460700003)(2616005)(36756003)(81166007)(1076003)(16526019)(186003)(82310400005)(30864003)(26005)(54906003)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2022 22:09:14.3773 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 400aafaa-a34e-428c-c1bd-08da612e7e7a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT010.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6459
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Roman Li <roman.li@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Roman Li <roman.li@amd.com>

Add support for DCN 3.1.4 in Display Core

Signed-off-by: Roman Li <roman.li@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/dc/Makefile       |   1 +
 .../display/dc/bios/command_table_helper2.c   |   1 +
 .../gpu/drm/amd/display/dc/clk_mgr/Makefile   |   9 +
 .../gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c  |  22 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c      |   4 +
 drivers/gpu/drm/amd/display/dc/core/dc_link.c |   1 +
 .../gpu/drm/amd/display/dc/core/dc_resource.c |   8 +
 .../drm/amd/display/dc/dce/dce_clock_source.h |   5 +-
 .../gpu/drm/amd/display/dc/dcn20/dcn20_dsc.c  |  17 +-
 .../gpu/drm/amd/display/dc/dcn20/dcn20_dsc.h  | 219 ++++++++++++++++++
 .../gpu/drm/amd/display/dc/dcn31/dcn31_dccg.c |  16 +-
 .../gpu/drm/amd/display/dc/dcn31/dcn31_dccg.h |  35 +++
 .../display/dc/dcn31/dcn31_dio_link_encoder.h |  28 +++
 .../drm/amd/display/dc/dcn31/dcn31_resource.c |   3 +
 .../gpu/drm/amd/display/dc/gpio/hw_factory.c  |   1 +
 .../drm/amd/display/dc/gpio/hw_translate.c    |   1 +
 drivers/gpu/drm/amd/display/dc/irq/Makefile   |  10 +
 17 files changed, 366 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/Makefile b/drivers/gpu/drm/amd/display/dc/Makefile
index dfe82bcdd17d..b6bacf6b25e1 100644
--- a/drivers/gpu/drm/amd/display/dc/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/Makefile
@@ -60,6 +60,7 @@ DC_LIBS += dcn301
 DC_LIBS += dcn302
 DC_LIBS += dcn303
 DC_LIBS += dcn31
+DC_LIBS += dcn314
 DC_LIBS += dcn315
 DC_LIBS += dcn316
 DC_LIBS += dcn32
diff --git a/drivers/gpu/drm/amd/display/dc/bios/command_table_helper2.c b/drivers/gpu/drm/amd/display/dc/bios/command_table_helper2.c
index f22593bcb862..8538f13e01bf 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/command_table_helper2.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/command_table_helper2.c
@@ -75,6 +75,7 @@ bool dal_bios_parser_init_cmd_tbl_helper2(
 	case DCN_VERSION_3_02:
 	case DCN_VERSION_3_03:
 	case DCN_VERSION_3_1:
+	case DCN_VERSION_3_14:
 	case DCN_VERSION_3_15:
 	case DCN_VERSION_3_16:
 	case DCN_VERSION_3_2:
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/Makefile b/drivers/gpu/drm/amd/display/dc/clk_mgr/Makefile
index 7b505e1e9308..053084121db2 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/Makefile
@@ -154,6 +154,15 @@ AMD_DAL_CLK_MGR_DCN31 = $(addprefix $(AMDDALPATH)/dc/clk_mgr/dcn31/,$(CLK_MGR_DC
 
 AMD_DISPLAY_FILES += $(AMD_DAL_CLK_MGR_DCN31)
 
+###############################################################################
+# DCN314
+###############################################################################
+CLK_MGR_DCN314 = dcn314_smu.o dcn314_clk_mgr.o
+
+AMD_DAL_CLK_MGR_DCN314 = $(addprefix $(AMDDALPATH)/dc/clk_mgr/dcn314/,$(CLK_MGR_DCN314))
+
+AMD_DISPLAY_FILES += $(AMD_DAL_CLK_MGR_DCN314)
+
 ###############################################################################
 # DCN315
 ###############################################################################
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
index 6972f99e9a9a..4c76091fd1f2 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
@@ -43,11 +43,11 @@
 #include "dcn30/dcn30_clk_mgr.h"
 #include "dcn301/vg_clk_mgr.h"
 #include "dcn31/dcn31_clk_mgr.h"
+#include "dcn314/dcn314_clk_mgr.h"
 #include "dcn315/dcn315_clk_mgr.h"
 #include "dcn316/dcn316_clk_mgr.h"
 #include "dcn32/dcn32_clk_mgr.h"
 
-
 int clk_mgr_helper_get_active_display_cnt(
 		struct dc *dc,
 		struct dc_state *context)
@@ -287,6 +287,7 @@ struct clk_mgr *dc_clk_mgr_create(struct dc_context *ctx, struct pp_smu_funcs *p
 			return &clk_mgr->base.base;
 		}
 		break;
+
 	case FAMILY_YELLOW_CARP: {
 		struct clk_mgr_dcn31 *clk_mgr = kzalloc(sizeof(*clk_mgr), GFP_KERNEL);
 
@@ -335,6 +336,20 @@ struct clk_mgr *dc_clk_mgr_create(struct dc_context *ctx, struct pp_smu_funcs *p
 	    return &clk_mgr->base;
 	    break;
 	}
+
+	case AMDGPU_FAMILY_GC_11_0_2: {
+		struct clk_mgr_dcn314 *clk_mgr = kzalloc(sizeof(*clk_mgr), GFP_KERNEL);
+
+		if (clk_mgr == NULL) {
+			BREAK_TO_DEBUGGER();
+			return NULL;
+		}
+
+		dcn314_clk_mgr_construct(ctx, clk_mgr, pp_smu, dccg);
+		return &clk_mgr->base.base;
+	}
+	break;
+
 #endif
 	default:
 		ASSERT(0); /* Unknown Asic */
@@ -381,6 +396,11 @@ void dc_destroy_clk_mgr(struct clk_mgr *clk_mgr_base)
 	case AMDGPU_FAMILY_GC_11_0_0:
 		dcn32_clk_mgr_destroy(clk_mgr);
 		break;
+
+	case AMDGPU_FAMILY_GC_11_0_2:
+		dcn314_clk_mgr_destroy(clk_mgr);
+		break;
+
 	default:
 		break;
 	}
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index dc2c59995a19..b30a13babde9 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -4167,6 +4167,10 @@ bool dc_is_dmub_outbox_supported(struct dc *dc)
 	    !dc->debug.dpia_debug.bits.disable_dpia)
 		return true;
 
+	if (dc->ctx->asic_id.chip_family == AMDGPU_FAMILY_GC_11_0_2 &&
+	    !dc->debug.dpia_debug.bits.disable_dpia)
+		return true;
+
 	/* dmub aux needs dmub notifications to be enabled */
 	return dc->debug.enable_dmub_aux_for_legacy_ddc;
 }
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index 335ca5b14fa7..c9d4c60bae6b 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -3368,6 +3368,7 @@ bool dc_link_setup_psr(struct dc_link *link,
 		switch(link->ctx->asic_id.chip_family) {
 		case FAMILY_YELLOW_CARP:
 		case AMDGPU_FAMILY_GC_10_3_6:
+		case AMDGPU_FAMILY_GC_11_0_2:
 			if(!dc->debug.disable_z10)
 				psr_context->psr_level.bits.SKIP_CRTC_DISABLE = false;
 			break;
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 2aa42c710488..f09f222b6abf 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -63,6 +63,7 @@
 #include "dcn302/dcn302_resource.h"
 #include "dcn303/dcn303_resource.h"
 #include "dcn31/dcn31_resource.h"
+#include "dcn314/dcn314_resource.h"
 #include "dcn315/dcn315_resource.h"
 #include "dcn316/dcn316_resource.h"
 #include "../dcn32/dcn32_resource.h"
@@ -167,6 +168,10 @@ enum dce_version resource_parse_asic_id(struct hw_asic_id asic_id)
 		if (ASICREV_IS_GC_11_0_2(asic_id.hw_internal_rev))
 			dc_version = DCN_VERSION_3_21;
 		break;
+	case AMDGPU_FAMILY_GC_11_0_2:
+		if (ASICREV_IS_GC_11_0_2(asic_id.hw_internal_rev))
+			dc_version = DCN_VERSION_3_14;
+		break;
 	default:
 		dc_version = DCE_VERSION_UNKNOWN;
 		break;
@@ -256,6 +261,9 @@ struct resource_pool *dc_create_resource_pool(struct dc  *dc,
 	case DCN_VERSION_3_1:
 		res_pool = dcn31_create_resource_pool(init_data, dc);
 		break;
+	case DCN_VERSION_3_14:
+		res_pool = dcn314_create_resource_pool(init_data, dc);
+		break;
 	case DCN_VERSION_3_15:
 		res_pool = dcn315_create_resource_pool(init_data, dc);
 		break;
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.h b/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.h
index e0c390fcc12c..aaf33c79b09b 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.h
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.h
@@ -157,13 +157,16 @@
 		SRII(PIXEL_RATE_CNTL, OTG, 0),\
 		SRII(PIXEL_RATE_CNTL, OTG, 1)
 
-
 #define CS_COMMON_MASK_SH_LIST_DCN2_0(mask_sh)\
 	CS_SF(DP_DTO0_PHASE, DP_DTO0_PHASE, mask_sh),\
 	CS_SF(DP_DTO0_MODULO, DP_DTO0_MODULO, mask_sh),\
 	CS_SF(PHYPLLA_PIXCLK_RESYNC_CNTL, PHYPLLA_DCCG_DEEP_COLOR_CNTL, mask_sh),\
 	CS_SF(OTG0_PIXEL_RATE_CNTL, DP_DTO0_ENABLE, mask_sh)
 
+#define CS_COMMON_MASK_SH_LIST_DCN3_1_4(mask_sh)\
+	CS_COMMON_MASK_SH_LIST_DCN2_0(mask_sh),\
+	CS_SF(OTG0_PIXEL_RATE_CNTL, PIPE0_DTO_SRC_SEL, mask_sh),
+
 #define CS_COMMON_MASK_SH_LIST_DCN3_2(mask_sh)\
 	CS_COMMON_MASK_SH_LIST_DCN2_0(mask_sh),\
 	CS_SF(OTG0_PIXEL_RATE_CNTL, PIPE0_DTO_SRC_SEL, mask_sh)
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dsc.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dsc.c
index c4f14aef0649..a02e8700c256 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dsc.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dsc.c
@@ -573,11 +573,18 @@ static void dsc_write_to_registers(struct display_stream_compressor *dsc, const
 		PIC_HEIGHT, reg_vals->pps.pic_height);
 
 	// dscc registers
-	REG_SET_4(DSCC_CONFIG0, 0,
-		ICH_RESET_AT_END_OF_LINE, reg_vals->ich_reset_at_eol,
-		NUMBER_OF_SLICES_PER_LINE, reg_vals->num_slices_h - 1,
-		ALTERNATE_ICH_ENCODING_EN, reg_vals->alternate_ich_encoding_en,
-		NUMBER_OF_SLICES_IN_VERTICAL_DIRECTION, reg_vals->num_slices_v - 1);
+	if (dsc20->dsc_mask->ICH_RESET_AT_END_OF_LINE == 0) {
+		REG_SET_3(DSCC_CONFIG0, 0,
+			  NUMBER_OF_SLICES_PER_LINE, reg_vals->num_slices_h - 1,
+			  ALTERNATE_ICH_ENCODING_EN, reg_vals->alternate_ich_encoding_en,
+			  NUMBER_OF_SLICES_IN_VERTICAL_DIRECTION, reg_vals->num_slices_v - 1);
+	} else {
+		REG_SET_4(DSCC_CONFIG0, 0, ICH_RESET_AT_END_OF_LINE,
+			  reg_vals->ich_reset_at_eol, NUMBER_OF_SLICES_PER_LINE,
+			  reg_vals->num_slices_h - 1, ALTERNATE_ICH_ENCODING_EN,
+			  reg_vals->alternate_ich_encoding_en, NUMBER_OF_SLICES_IN_VERTICAL_DIRECTION,
+			  reg_vals->num_slices_v - 1);
+	}
 
 	REG_SET(DSCC_CONFIG1, 0,
 			DSCC_RATE_CONTROL_BUFFER_MODEL_SIZE, reg_vals->rc_buffer_model_size);
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dsc.h b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dsc.h
index 1118e33aaa2c..5a6961f5f958 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dsc.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dsc.h
@@ -445,6 +445,225 @@
 	type DSCRM_DSC_FORWARD_EN; \
 	type DSCRM_DSC_OPP_PIPE_SOURCE
 
+#define DSC_REG_LIST_DCN314(id) \
+	SRI(DSC_TOP_CONTROL, DSC_TOP, id),\
+	SRI(DSC_DEBUG_CONTROL, DSC_TOP, id),\
+	SRI(DSCC_CONFIG0, DSCC, id),\
+	SRI(DSCC_CONFIG1, DSCC, id),\
+	SRI(DSCC_STATUS, DSCC, id),\
+	SRI(DSCC_INTERRUPT_CONTROL_STATUS, DSCC, id),\
+	SRI(DSCC_PPS_CONFIG0, DSCC, id),\
+	SRI(DSCC_PPS_CONFIG1, DSCC, id),\
+	SRI(DSCC_PPS_CONFIG2, DSCC, id),\
+	SRI(DSCC_PPS_CONFIG3, DSCC, id),\
+	SRI(DSCC_PPS_CONFIG4, DSCC, id),\
+	SRI(DSCC_PPS_CONFIG5, DSCC, id),\
+	SRI(DSCC_PPS_CONFIG6, DSCC, id),\
+	SRI(DSCC_PPS_CONFIG7, DSCC, id),\
+	SRI(DSCC_PPS_CONFIG8, DSCC, id),\
+	SRI(DSCC_PPS_CONFIG9, DSCC, id),\
+	SRI(DSCC_PPS_CONFIG10, DSCC, id),\
+	SRI(DSCC_PPS_CONFIG11, DSCC, id),\
+	SRI(DSCC_PPS_CONFIG12, DSCC, id),\
+	SRI(DSCC_PPS_CONFIG13, DSCC, id),\
+	SRI(DSCC_PPS_CONFIG14, DSCC, id),\
+	SRI(DSCC_PPS_CONFIG15, DSCC, id),\
+	SRI(DSCC_PPS_CONFIG16, DSCC, id),\
+	SRI(DSCC_PPS_CONFIG17, DSCC, id),\
+	SRI(DSCC_PPS_CONFIG18, DSCC, id),\
+	SRI(DSCC_PPS_CONFIG19, DSCC, id),\
+	SRI(DSCC_PPS_CONFIG20, DSCC, id),\
+	SRI(DSCC_PPS_CONFIG21, DSCC, id),\
+	SRI(DSCC_PPS_CONFIG22, DSCC, id),\
+	SRI(DSCC_MEM_POWER_CONTROL, DSCC, id),\
+	SRI(DSCC_R_Y_SQUARED_ERROR_LOWER, DSCC, id),\
+	SRI(DSCC_R_Y_SQUARED_ERROR_UPPER, DSCC, id),\
+	SRI(DSCC_G_CB_SQUARED_ERROR_LOWER, DSCC, id),\
+	SRI(DSCC_G_CB_SQUARED_ERROR_UPPER, DSCC, id),\
+	SRI(DSCC_B_CR_SQUARED_ERROR_LOWER, DSCC, id),\
+	SRI(DSCC_B_CR_SQUARED_ERROR_UPPER, DSCC, id),\
+	SRI(DSCC_MAX_ABS_ERROR0, DSCC, id),\
+	SRI(DSCC_MAX_ABS_ERROR1, DSCC, id),\
+	SRI(DSCC_RATE_BUFFER0_MAX_FULLNESS_LEVEL, DSCC, id),\
+	SRI(DSCC_RATE_BUFFER1_MAX_FULLNESS_LEVEL, DSCC, id),\
+	SRI(DSCC_RATE_BUFFER2_MAX_FULLNESS_LEVEL, DSCC, id),\
+	SRI(DSCC_RATE_BUFFER3_MAX_FULLNESS_LEVEL, DSCC, id),\
+	SRI(DSCC_RATE_CONTROL_BUFFER0_MAX_FULLNESS_LEVEL, DSCC, id),\
+	SRI(DSCC_RATE_CONTROL_BUFFER1_MAX_FULLNESS_LEVEL, DSCC, id),\
+	SRI(DSCC_RATE_CONTROL_BUFFER2_MAX_FULLNESS_LEVEL, DSCC, id),\
+	SRI(DSCC_RATE_CONTROL_BUFFER3_MAX_FULLNESS_LEVEL, DSCC, id),\
+	SRI(DSCCIF_CONFIG0, DSCCIF, id),\
+	SRI(DSCCIF_CONFIG1, DSCCIF, id),\
+	SRI(DSCRM_DSC_FORWARD_CONFIG, DSCRM, id)
+
+#define DSC_REG_LIST_SH_MASK_DCN314(mask_sh)\
+	DSC_SF(DSC_TOP0_DSC_TOP_CONTROL, DSC_CLOCK_EN, mask_sh), \
+	DSC_SF(DSC_TOP0_DSC_TOP_CONTROL, DSC_DISPCLK_R_GATE_DIS, mask_sh), \
+	DSC_SF(DSC_TOP0_DSC_TOP_CONTROL, DSC_DSCCLK_R_GATE_DIS, mask_sh), \
+	DSC_SF(DSC_TOP0_DSC_DEBUG_CONTROL, DSC_DBG_EN, mask_sh), \
+	DSC_SF(DSC_TOP0_DSC_DEBUG_CONTROL, DSC_TEST_CLOCK_MUX_SEL, mask_sh), \
+	DSC_SF(DSCC0_DSCC_CONFIG0, NUMBER_OF_SLICES_PER_LINE, mask_sh), \
+	DSC_SF(DSCC0_DSCC_CONFIG0, ALTERNATE_ICH_ENCODING_EN, mask_sh), \
+	DSC_SF(DSCC0_DSCC_CONFIG0, NUMBER_OF_SLICES_IN_VERTICAL_DIRECTION, mask_sh), \
+	DSC_SF(DSCC0_DSCC_CONFIG1, DSCC_RATE_CONTROL_BUFFER_MODEL_SIZE, mask_sh), \
+	/*DSC_SF(DSCC0_DSCC_CONFIG1, DSCC_DISABLE_ICH, mask_sh),*/ \
+	DSC_SF(DSCC0_DSCC_STATUS, DSCC_DOUBLE_BUFFER_REG_UPDATE_PENDING, mask_sh), \
+	DSC_SF(DSCC0_DSCC_INTERRUPT_CONTROL_STATUS, DSCC_RATE_BUFFER0_OVERFLOW_OCCURRED, mask_sh), \
+	DSC_SF(DSCC0_DSCC_INTERRUPT_CONTROL_STATUS, DSCC_RATE_BUFFER1_OVERFLOW_OCCURRED, mask_sh), \
+	DSC_SF(DSCC0_DSCC_INTERRUPT_CONTROL_STATUS, DSCC_RATE_BUFFER2_OVERFLOW_OCCURRED, mask_sh), \
+	DSC_SF(DSCC0_DSCC_INTERRUPT_CONTROL_STATUS, DSCC_RATE_BUFFER3_OVERFLOW_OCCURRED, mask_sh), \
+	DSC_SF(DSCC0_DSCC_INTERRUPT_CONTROL_STATUS, DSCC_RATE_BUFFER0_UNDERFLOW_OCCURRED, mask_sh), \
+	DSC_SF(DSCC0_DSCC_INTERRUPT_CONTROL_STATUS, DSCC_RATE_BUFFER1_UNDERFLOW_OCCURRED, mask_sh), \
+	DSC_SF(DSCC0_DSCC_INTERRUPT_CONTROL_STATUS, DSCC_RATE_BUFFER2_UNDERFLOW_OCCURRED, mask_sh), \
+	DSC_SF(DSCC0_DSCC_INTERRUPT_CONTROL_STATUS, DSCC_RATE_BUFFER3_UNDERFLOW_OCCURRED, mask_sh), \
+	DSC_SF(DSCC0_DSCC_INTERRUPT_CONTROL_STATUS, DSCC_RATE_CONTROL_BUFFER_MODEL0_OVERFLOW_OCCURRED, mask_sh), \
+	DSC_SF(DSCC0_DSCC_INTERRUPT_CONTROL_STATUS, DSCC_RATE_CONTROL_BUFFER_MODEL1_OVERFLOW_OCCURRED, mask_sh), \
+	DSC_SF(DSCC0_DSCC_INTERRUPT_CONTROL_STATUS, DSCC_RATE_CONTROL_BUFFER_MODEL2_OVERFLOW_OCCURRED, mask_sh), \
+	DSC_SF(DSCC0_DSCC_INTERRUPT_CONTROL_STATUS, DSCC_RATE_CONTROL_BUFFER_MODEL3_OVERFLOW_OCCURRED, mask_sh), \
+	DSC_SF(DSCC0_DSCC_INTERRUPT_CONTROL_STATUS, DSCC_RATE_BUFFER0_OVERFLOW_OCCURRED_INT_EN, mask_sh), \
+	DSC_SF(DSCC0_DSCC_INTERRUPT_CONTROL_STATUS, DSCC_RATE_BUFFER1_OVERFLOW_OCCURRED_INT_EN, mask_sh), \
+	DSC_SF(DSCC0_DSCC_INTERRUPT_CONTROL_STATUS, DSCC_RATE_BUFFER2_OVERFLOW_OCCURRED_INT_EN, mask_sh), \
+	DSC_SF(DSCC0_DSCC_INTERRUPT_CONTROL_STATUS, DSCC_RATE_BUFFER3_OVERFLOW_OCCURRED_INT_EN, mask_sh), \
+	DSC_SF(DSCC0_DSCC_INTERRUPT_CONTROL_STATUS, DSCC_RATE_BUFFER0_UNDERFLOW_OCCURRED_INT_EN, mask_sh), \
+	DSC_SF(DSCC0_DSCC_INTERRUPT_CONTROL_STATUS, DSCC_RATE_BUFFER1_UNDERFLOW_OCCURRED_INT_EN, mask_sh), \
+	DSC_SF(DSCC0_DSCC_INTERRUPT_CONTROL_STATUS, DSCC_RATE_BUFFER2_UNDERFLOW_OCCURRED_INT_EN, mask_sh), \
+	DSC_SF(DSCC0_DSCC_INTERRUPT_CONTROL_STATUS, DSCC_RATE_BUFFER3_UNDERFLOW_OCCURRED_INT_EN, mask_sh), \
+	DSC_SF(DSCC0_DSCC_INTERRUPT_CONTROL_STATUS, DSCC_RATE_CONTROL_BUFFER_MODEL0_OVERFLOW_OCCURRED_INT_EN, mask_sh), \
+	DSC_SF(DSCC0_DSCC_INTERRUPT_CONTROL_STATUS, DSCC_RATE_CONTROL_BUFFER_MODEL1_OVERFLOW_OCCURRED_INT_EN, mask_sh), \
+	DSC_SF(DSCC0_DSCC_INTERRUPT_CONTROL_STATUS, DSCC_RATE_CONTROL_BUFFER_MODEL2_OVERFLOW_OCCURRED_INT_EN, mask_sh), \
+	DSC_SF(DSCC0_DSCC_INTERRUPT_CONTROL_STATUS, DSCC_RATE_CONTROL_BUFFER_MODEL3_OVERFLOW_OCCURRED_INT_EN, mask_sh), \
+	DSC_SF(DSCC0_DSCC_PPS_CONFIG0, DSC_VERSION_MINOR, mask_sh), \
+	DSC_SF(DSCC0_DSCC_PPS_CONFIG0, DSC_VERSION_MAJOR, mask_sh), \
+	DSC_SF(DSCC0_DSCC_PPS_CONFIG0, PPS_IDENTIFIER, mask_sh), \
+	DSC_SF(DSCC0_DSCC_PPS_CONFIG0, LINEBUF_DEPTH, mask_sh), \
+	DSC2_SF(DSCC0, DSCC_PPS_CONFIG0__BITS_PER_COMPONENT, mask_sh), \
+	DSC_SF(DSCC0_DSCC_PPS_CONFIG1, BITS_PER_PIXEL, mask_sh), \
+	DSC_SF(DSCC0_DSCC_PPS_CONFIG1, VBR_ENABLE, mask_sh), \
+	DSC_SF(DSCC0_DSCC_PPS_CONFIG1, SIMPLE_422, mask_sh), \
+	DSC_SF(DSCC0_DSCC_PPS_CONFIG1, CONVERT_RGB, mask_sh), \
+	DSC_SF(DSCC0_DSCC_PPS_CONFIG1, BLOCK_PRED_ENABLE, mask_sh), \
+	DSC_SF(DSCC0_DSCC_PPS_CONFIG1, NATIVE_422, mask_sh), \
+	DSC_SF(DSCC0_DSCC_PPS_CONFIG1, NATIVE_420, mask_sh), \
+	DSC_SF(DSCC0_DSCC_PPS_CONFIG1, CHUNK_SIZE, mask_sh), \
+	DSC_SF(DSCC0_DSCC_PPS_CONFIG2, PIC_WIDTH, mask_sh), \
+	DSC_SF(DSCC0_DSCC_PPS_CONFIG2, PIC_HEIGHT, mask_sh), \
+	DSC_SF(DSCC0_DSCC_PPS_CONFIG3, SLICE_WIDTH, mask_sh), \
+	DSC_SF(DSCC0_DSCC_PPS_CONFIG3, SLICE_HEIGHT, mask_sh), \
+	DSC_SF(DSCC0_DSCC_PPS_CONFIG4, INITIAL_XMIT_DELAY, mask_sh), \
+	DSC_SF(DSCC0_DSCC_PPS_CONFIG4, INITIAL_DEC_DELAY, mask_sh), \
+	DSC_SF(DSCC0_DSCC_PPS_CONFIG5, INITIAL_SCALE_VALUE, mask_sh), \
+	DSC_SF(DSCC0_DSCC_PPS_CONFIG5, SCALE_INCREMENT_INTERVAL, mask_sh), \
+	DSC_SF(DSCC0_DSCC_PPS_CONFIG6, SCALE_DECREMENT_INTERVAL, mask_sh), \
+	DSC_SF(DSCC0_DSCC_PPS_CONFIG6, FIRST_LINE_BPG_OFFSET, mask_sh), \
+	DSC_SF(DSCC0_DSCC_PPS_CONFIG6, SECOND_LINE_BPG_OFFSET, mask_sh), \
+	DSC_SF(DSCC0_DSCC_PPS_CONFIG7, NFL_BPG_OFFSET, mask_sh), \
+	DSC_SF(DSCC0_DSCC_PPS_CONFIG7, SLICE_BPG_OFFSET, mask_sh), \
+	DSC_SF(DSCC0_DSCC_PPS_CONFIG8, NSL_BPG_OFFSET, mask_sh), \
+	DSC_SF(DSCC0_DSCC_PPS_CONFIG8, SECOND_LINE_OFFSET_ADJ, mask_sh), \
+	DSC_SF(DSCC0_DSCC_PPS_CONFIG9, INITIAL_OFFSET, mask_sh), \
+	DSC_SF(DSCC0_DSCC_PPS_CONFIG9, FINAL_OFFSET, mask_sh), \
+	DSC_SF(DSCC0_DSCC_PPS_CONFIG10, FLATNESS_MIN_QP, mask_sh), \
+	DSC_SF(DSCC0_DSCC_PPS_CONFIG10, FLATNESS_MAX_QP, mask_sh), \
+	DSC_SF(DSCC0_DSCC_PPS_CONFIG10, RC_MODEL_SIZE, mask_sh), \
+	DSC_SF(DSCC0_DSCC_PPS_CONFIG11, RC_EDGE_FACTOR, mask_sh), \
+	DSC_SF(DSCC0_DSCC_PPS_CONFIG11, RC_QUANT_INCR_LIMIT0, mask_sh), \
+	DSC_SF(DSCC0_DSCC_PPS_CONFIG11, RC_QUANT_INCR_LIMIT1, mask_sh), \
+	DSC_SF(DSCC0_DSCC_PPS_CONFIG11, RC_TGT_OFFSET_LO, mask_sh), \
+	DSC_SF(DSCC0_DSCC_PPS_CONFIG11, RC_TGT_OFFSET_HI, mask_sh), \
+	DSC_SF(DSCC0_DSCC_PPS_CONFIG12, RC_BUF_THRESH0, mask_sh), \
+	DSC_SF(DSCC0_DSCC_PPS_CONFIG12, RC_BUF_THRESH1, mask_sh), \
+	DSC_SF(DSCC0_DSCC_PPS_CONFIG12, RC_BUF_THRESH2, mask_sh), \
+	DSC_SF(DSCC0_DSCC_PPS_CONFIG12, RC_BUF_THRESH3, mask_sh), \
+	DSC_SF(DSCC0_DSCC_PPS_CONFIG13, RC_BUF_THRESH4, mask_sh), \
+	DSC_SF(DSCC0_DSCC_PPS_CONFIG13, RC_BUF_THRESH5, mask_sh), \
+	DSC_SF(DSCC0_DSCC_PPS_CONFIG13, RC_BUF_THRESH6, mask_sh), \
+	DSC_SF(DSCC0_DSCC_PPS_CONFIG13, RC_BUF_THRESH7, mask_sh), \
+	DSC_SF(DSCC0_DSCC_PPS_CONFIG14, RC_BUF_THRESH8, mask_sh), \
+	DSC_SF(DSCC0_DSCC_PPS_CONFIG14, RC_BUF_THRESH9, mask_sh), \
+	DSC_SF(DSCC0_DSCC_PPS_CONFIG14, RC_BUF_THRESH10, mask_sh), \
+	DSC_SF(DSCC0_DSCC_PPS_CONFIG14, RC_BUF_THRESH11, mask_sh), \
+	DSC_SF(DSCC0_DSCC_PPS_CONFIG15, RC_BUF_THRESH12, mask_sh), \
+	DSC_SF(DSCC0_DSCC_PPS_CONFIG15, RC_BUF_THRESH13, mask_sh), \
+	DSC_SF(DSCC0_DSCC_PPS_CONFIG15, RANGE_MIN_QP0, mask_sh), \
+	DSC_SF(DSCC0_DSCC_PPS_CONFIG15, RANGE_MAX_QP0, mask_sh), \
+	DSC_SF(DSCC0_DSCC_PPS_CONFIG15, RANGE_BPG_OFFSET0, mask_sh), \
+	DSC_SF(DSCC0_DSCC_PPS_CONFIG16, RANGE_MIN_QP1, mask_sh), \
+	DSC_SF(DSCC0_DSCC_PPS_CONFIG16, RANGE_MAX_QP1, mask_sh), \
+	DSC_SF(DSCC0_DSCC_PPS_CONFIG16, RANGE_BPG_OFFSET1, mask_sh), \
+	DSC_SF(DSCC0_DSCC_PPS_CONFIG16, RANGE_MIN_QP2, mask_sh), \
+	DSC_SF(DSCC0_DSCC_PPS_CONFIG16, RANGE_MAX_QP2, mask_sh), \
+	DSC_SF(DSCC0_DSCC_PPS_CONFIG16, RANGE_BPG_OFFSET2, mask_sh), \
+	DSC_SF(DSCC0_DSCC_PPS_CONFIG17, RANGE_MIN_QP3, mask_sh), \
+	DSC_SF(DSCC0_DSCC_PPS_CONFIG17, RANGE_MAX_QP3, mask_sh), \
+	DSC_SF(DSCC0_DSCC_PPS_CONFIG17, RANGE_BPG_OFFSET3, mask_sh), \
+	DSC_SF(DSCC0_DSCC_PPS_CONFIG17, RANGE_MIN_QP4, mask_sh), \
+	DSC_SF(DSCC0_DSCC_PPS_CONFIG17, RANGE_MAX_QP4, mask_sh), \
+	DSC_SF(DSCC0_DSCC_PPS_CONFIG17, RANGE_BPG_OFFSET4, mask_sh), \
+	DSC_SF(DSCC0_DSCC_PPS_CONFIG18, RANGE_MIN_QP5, mask_sh), \
+	DSC_SF(DSCC0_DSCC_PPS_CONFIG18, RANGE_MAX_QP5, mask_sh), \
+	DSC_SF(DSCC0_DSCC_PPS_CONFIG18, RANGE_BPG_OFFSET5, mask_sh), \
+	DSC_SF(DSCC0_DSCC_PPS_CONFIG18, RANGE_MIN_QP6, mask_sh), \
+	DSC_SF(DSCC0_DSCC_PPS_CONFIG18, RANGE_MAX_QP6, mask_sh), \
+	DSC_SF(DSCC0_DSCC_PPS_CONFIG18, RANGE_BPG_OFFSET6, mask_sh), \
+	DSC_SF(DSCC0_DSCC_PPS_CONFIG19, RANGE_MIN_QP7, mask_sh), \
+	DSC_SF(DSCC0_DSCC_PPS_CONFIG19, RANGE_MAX_QP7, mask_sh), \
+	DSC_SF(DSCC0_DSCC_PPS_CONFIG19, RANGE_BPG_OFFSET7, mask_sh), \
+	DSC_SF(DSCC0_DSCC_PPS_CONFIG19, RANGE_MIN_QP8, mask_sh), \
+	DSC_SF(DSCC0_DSCC_PPS_CONFIG19, RANGE_MAX_QP8, mask_sh), \
+	DSC_SF(DSCC0_DSCC_PPS_CONFIG19, RANGE_BPG_OFFSET8, mask_sh), \
+	DSC_SF(DSCC0_DSCC_PPS_CONFIG20, RANGE_MIN_QP9, mask_sh), \
+	DSC_SF(DSCC0_DSCC_PPS_CONFIG20, RANGE_MAX_QP9, mask_sh), \
+	DSC_SF(DSCC0_DSCC_PPS_CONFIG20, RANGE_BPG_OFFSET9, mask_sh), \
+	DSC_SF(DSCC0_DSCC_PPS_CONFIG20, RANGE_MIN_QP10, mask_sh), \
+	DSC_SF(DSCC0_DSCC_PPS_CONFIG20, RANGE_MAX_QP10, mask_sh), \
+	DSC_SF(DSCC0_DSCC_PPS_CONFIG20, RANGE_BPG_OFFSET10, mask_sh), \
+	DSC_SF(DSCC0_DSCC_PPS_CONFIG21, RANGE_MIN_QP11, mask_sh), \
+	DSC_SF(DSCC0_DSCC_PPS_CONFIG21, RANGE_MAX_QP11, mask_sh), \
+	DSC_SF(DSCC0_DSCC_PPS_CONFIG21, RANGE_BPG_OFFSET11, mask_sh), \
+	DSC_SF(DSCC0_DSCC_PPS_CONFIG21, RANGE_MIN_QP12, mask_sh), \
+	DSC_SF(DSCC0_DSCC_PPS_CONFIG21, RANGE_MAX_QP12, mask_sh), \
+	DSC_SF(DSCC0_DSCC_PPS_CONFIG21, RANGE_BPG_OFFSET12, mask_sh), \
+	DSC_SF(DSCC0_DSCC_PPS_CONFIG22, RANGE_MIN_QP13, mask_sh), \
+	DSC_SF(DSCC0_DSCC_PPS_CONFIG22, RANGE_MAX_QP13, mask_sh), \
+	DSC_SF(DSCC0_DSCC_PPS_CONFIG22, RANGE_BPG_OFFSET13, mask_sh), \
+	DSC_SF(DSCC0_DSCC_PPS_CONFIG22, RANGE_MIN_QP14, mask_sh), \
+	DSC_SF(DSCC0_DSCC_PPS_CONFIG22, RANGE_MAX_QP14, mask_sh), \
+	DSC_SF(DSCC0_DSCC_PPS_CONFIG22, RANGE_BPG_OFFSET14, mask_sh), \
+	DSC_SF(DSCC0_DSCC_MEM_POWER_CONTROL, DSCC_DEFAULT_MEM_LOW_POWER_STATE, mask_sh), \
+	DSC_SF(DSCC0_DSCC_MEM_POWER_CONTROL, DSCC_MEM_PWR_FORCE, mask_sh), \
+	DSC_SF(DSCC0_DSCC_MEM_POWER_CONTROL, DSCC_MEM_PWR_DIS, mask_sh), \
+	DSC_SF(DSCC0_DSCC_MEM_POWER_CONTROL, DSCC_MEM_PWR_STATE, mask_sh), \
+	DSC_SF(DSCC0_DSCC_MEM_POWER_CONTROL, DSCC_NATIVE_422_MEM_PWR_FORCE, mask_sh), \
+	DSC_SF(DSCC0_DSCC_MEM_POWER_CONTROL, DSCC_NATIVE_422_MEM_PWR_DIS, mask_sh), \
+	DSC_SF(DSCC0_DSCC_MEM_POWER_CONTROL, DSCC_NATIVE_422_MEM_PWR_STATE, mask_sh), \
+	DSC_SF(DSCC0_DSCC_R_Y_SQUARED_ERROR_LOWER, DSCC_R_Y_SQUARED_ERROR_LOWER, mask_sh), \
+	DSC_SF(DSCC0_DSCC_R_Y_SQUARED_ERROR_UPPER, DSCC_R_Y_SQUARED_ERROR_UPPER, mask_sh), \
+	DSC_SF(DSCC0_DSCC_G_CB_SQUARED_ERROR_LOWER, DSCC_G_CB_SQUARED_ERROR_LOWER, mask_sh), \
+	DSC_SF(DSCC0_DSCC_G_CB_SQUARED_ERROR_UPPER, DSCC_G_CB_SQUARED_ERROR_UPPER, mask_sh), \
+	DSC_SF(DSCC0_DSCC_B_CR_SQUARED_ERROR_LOWER, DSCC_B_CR_SQUARED_ERROR_LOWER, mask_sh), \
+	DSC_SF(DSCC0_DSCC_B_CR_SQUARED_ERROR_UPPER, DSCC_B_CR_SQUARED_ERROR_UPPER, mask_sh), \
+	DSC_SF(DSCC0_DSCC_MAX_ABS_ERROR0, DSCC_R_Y_MAX_ABS_ERROR, mask_sh), \
+	DSC_SF(DSCC0_DSCC_MAX_ABS_ERROR0, DSCC_G_CB_MAX_ABS_ERROR, mask_sh), \
+	DSC_SF(DSCC0_DSCC_MAX_ABS_ERROR1, DSCC_B_CR_MAX_ABS_ERROR, mask_sh), \
+	DSC_SF(DSCC0_DSCC_RATE_BUFFER0_MAX_FULLNESS_LEVEL, DSCC_RATE_BUFFER0_MAX_FULLNESS_LEVEL, mask_sh), \
+	DSC_SF(DSCC0_DSCC_RATE_BUFFER1_MAX_FULLNESS_LEVEL, DSCC_RATE_BUFFER1_MAX_FULLNESS_LEVEL, mask_sh), \
+	DSC_SF(DSCC0_DSCC_RATE_BUFFER2_MAX_FULLNESS_LEVEL, DSCC_RATE_BUFFER2_MAX_FULLNESS_LEVEL, mask_sh), \
+	DSC_SF(DSCC0_DSCC_RATE_BUFFER3_MAX_FULLNESS_LEVEL, DSCC_RATE_BUFFER3_MAX_FULLNESS_LEVEL, mask_sh), \
+	DSC_SF(DSCC0_DSCC_RATE_CONTROL_BUFFER0_MAX_FULLNESS_LEVEL, DSCC_RATE_CONTROL_BUFFER0_MAX_FULLNESS_LEVEL, mask_sh), \
+	DSC_SF(DSCC0_DSCC_RATE_CONTROL_BUFFER1_MAX_FULLNESS_LEVEL, DSCC_RATE_CONTROL_BUFFER1_MAX_FULLNESS_LEVEL, mask_sh), \
+	DSC_SF(DSCC0_DSCC_RATE_CONTROL_BUFFER2_MAX_FULLNESS_LEVEL, DSCC_RATE_CONTROL_BUFFER2_MAX_FULLNESS_LEVEL, mask_sh), \
+	DSC_SF(DSCC0_DSCC_RATE_CONTROL_BUFFER3_MAX_FULLNESS_LEVEL, DSCC_RATE_CONTROL_BUFFER3_MAX_FULLNESS_LEVEL, mask_sh), \
+	DSC_SF(DSCCIF0_DSCCIF_CONFIG0, INPUT_INTERFACE_UNDERFLOW_RECOVERY_EN, mask_sh), \
+	DSC_SF(DSCCIF0_DSCCIF_CONFIG0, INPUT_INTERFACE_UNDERFLOW_OCCURRED_INT_EN, mask_sh), \
+	DSC_SF(DSCCIF0_DSCCIF_CONFIG0, INPUT_INTERFACE_UNDERFLOW_OCCURRED_STATUS, mask_sh), \
+	DSC_SF(DSCCIF0_DSCCIF_CONFIG0, INPUT_PIXEL_FORMAT, mask_sh), \
+	DSC2_SF(DSCCIF0, DSCCIF_CONFIG0__BITS_PER_COMPONENT, mask_sh), \
+	DSC_SF(DSCCIF0_DSCCIF_CONFIG0, DOUBLE_BUFFER_REG_UPDATE_PENDING, mask_sh), \
+	DSC_SF(DSCCIF0_DSCCIF_CONFIG1, PIC_WIDTH, mask_sh), \
+	DSC_SF(DSCCIF0_DSCCIF_CONFIG1, PIC_HEIGHT, mask_sh), \
+	DSC_SF(DSCRM0_DSCRM_DSC_FORWARD_CONFIG, DSCRM_DSC_FORWARD_EN, mask_sh), \
+	DSC_SF(DSCRM0_DSCRM_DSC_FORWARD_CONFIG, DSCRM_DSC_OPP_PIPE_SOURCE, mask_sh)
+
 
 struct dcn20_dsc_registers {
 	uint32_t DSC_TOP_CONTROL;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dccg.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dccg.c
index 0faa1abd35ba..799a383a2684 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dccg.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dccg.c
@@ -43,7 +43,7 @@
 #define DC_LOGGER \
 	dccg->ctx->logger
 
-static void dccg31_update_dpp_dto(struct dccg *dccg, int dpp_inst, int req_dppclk)
+void dccg31_update_dpp_dto(struct dccg *dccg, int dpp_inst, int req_dppclk)
 {
 	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
 
@@ -338,7 +338,7 @@ void dccg31_disable_symclk32_le(
 	}
 }
 
-static void dccg31_disable_dscclk(struct dccg *dccg, int inst)
+void dccg31_disable_dscclk(struct dccg *dccg, int inst)
 {
 	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
 
@@ -373,7 +373,7 @@ static void dccg31_disable_dscclk(struct dccg *dccg, int inst)
 	}
 }
 
-static void dccg31_enable_dscclk(struct dccg *dccg, int inst)
+void dccg31_enable_dscclk(struct dccg *dccg, int inst)
 {
 	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
 
@@ -510,7 +510,7 @@ void dccg31_set_physymclk(
 }
 
 /* Controls the generation of pixel valid for OTG in (OTG -> HPO case) */
-static void dccg31_set_dtbclk_dto(
+void dccg31_set_dtbclk_dto(
 		struct dccg *dccg,
 		const struct dtbclk_dto_params *params)
 {
@@ -608,7 +608,7 @@ void dccg31_set_audio_dtbclk_dto(
 	}
 }
 
-static void dccg31_get_dccg_ref_freq(struct dccg *dccg,
+void dccg31_get_dccg_ref_freq(struct dccg *dccg,
 		unsigned int xtalin_freq_inKhz,
 		unsigned int *dccg_ref_freq_inKhz)
 {
@@ -620,7 +620,7 @@ static void dccg31_get_dccg_ref_freq(struct dccg *dccg,
 	return;
 }
 
-static void dccg31_set_dispclk_change_mode(
+void dccg31_set_dispclk_change_mode(
 	struct dccg *dccg,
 	enum dentist_dispclk_change_mode change_mode)
 {
@@ -662,7 +662,7 @@ void dccg31_init(struct dccg *dccg)
 	}
 }
 
-static void dccg31_otg_add_pixel(struct dccg *dccg,
+void dccg31_otg_add_pixel(struct dccg *dccg,
 				 uint32_t otg_inst)
 {
 	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
@@ -671,7 +671,7 @@ static void dccg31_otg_add_pixel(struct dccg *dccg,
 			OTG_ADD_PIXEL[otg_inst], 1);
 }
 
-static void dccg31_otg_drop_pixel(struct dccg *dccg,
+void dccg31_otg_drop_pixel(struct dccg *dccg,
 				  uint32_t otg_inst)
 {
 	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dccg.h b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dccg.h
index 80bd80707991..32b5593b1460 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dccg.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dccg.h
@@ -194,4 +194,39 @@ void dccg31_set_audio_dtbclk_dto(
 		struct dccg *dccg,
 		const struct dtbclk_dto_params *params);
 
+void dccg31_update_dpp_dto(
+	struct dccg *dccg,
+	int dpp_inst,
+	int req_dppclk);
+
+void dccg31_get_dccg_ref_freq(
+	struct dccg *dccg,
+	unsigned int xtalin_freq_inKhz,
+	unsigned int *dccg_ref_freq_inKhz);
+
+void dccg31_set_dpstreamclk(
+	struct dccg *dccg,
+	enum streamclk_source src,
+	int otg_inst);
+
+void dccg31_set_dtbclk_dto(
+		struct dccg *dccg,
+		const struct dtbclk_dto_params *params);
+
+void dccg31_otg_add_pixel(
+	struct dccg *dccg,
+	uint32_t otg_inst);
+
+void dccg31_otg_drop_pixel(
+	struct dccg *dccg,
+	uint32_t otg_inst);
+
+void dccg31_set_dispclk_change_mode(
+	struct dccg *dccg,
+	enum dentist_dispclk_change_mode change_mode);
+
+void dccg31_disable_dscclk(struct dccg *dccg, int inst);
+
+void dccg31_enable_dscclk(struct dccg *dccg, int inst);
+
 #endif //__DCN31_DCCG_H__
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dio_link_encoder.h b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dio_link_encoder.h
index 3454f1e7c1f1..221671563a0b 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dio_link_encoder.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dio_link_encoder.h
@@ -198,6 +198,34 @@
 	LE_SF(RDPCSTX0_RDPCSTX_PHY_FUSE3, RDPCS_PHY_DP_TX3_EQ_PRE, mask_sh),\
 	LE_SF(RDPCSTX0_RDPCSTX_PHY_FUSE3, RDPCS_PHY_DP_TX3_EQ_POST, mask_sh)
 
+#define DPCS_DCN314_REG_LIST(id) \
+	SRI(TMDS_CTL_BITS, DIG, id), \
+	SRI(RDPCSTX_PHY_CNTL3, RDPCSTX, id), \
+	SRI(RDPCSTX_PHY_CNTL4, RDPCSTX, id), \
+	SRI(RDPCSTX_PHY_CNTL5, RDPCSTX, id), \
+	SRI(RDPCSTX_PHY_CNTL7, RDPCSTX, id), \
+	SRI(RDPCSTX_PHY_CNTL8, RDPCSTX, id), \
+	SRI(RDPCSTX_PHY_CNTL9, RDPCSTX, id), \
+	SRI(RDPCSTX_PHY_CNTL10, RDPCSTX, id), \
+	SRI(RDPCSTX_PHY_CNTL11, RDPCSTX, id), \
+	SRI(RDPCSTX_PHY_CNTL12, RDPCSTX, id), \
+	SRI(RDPCSTX_PHY_CNTL13, RDPCSTX, id), \
+	SRI(RDPCSTX_PHY_CNTL14, RDPCSTX, id), \
+	SRI(RDPCSTX_CNTL, RDPCSTX, id), \
+	SRI(RDPCSTX_CLOCK_CNTL, RDPCSTX, id), \
+	SRI(RDPCSTX_INTERRUPT_CONTROL, RDPCSTX, id), \
+	SRI(RDPCSTX_PHY_CNTL0, RDPCSTX, id), \
+	SRI(RDPCSTX_PHY_CNTL2, RDPCSTX, id), \
+	SRI(RDPCS_TX_CR_ADDR, RDPCSTX, id), \
+	SRI(RDPCS_TX_CR_DATA, RDPCSTX, id), \
+	SRI(RDPCSTX_PHY_FUSE0, RDPCSTX, id), \
+	SRI(RDPCSTX_PHY_FUSE1, RDPCSTX, id), \
+	SRI(RDPCSTX_PHY_FUSE2, RDPCSTX, id), \
+	SRI(RDPCSTX_PHY_FUSE3, RDPCSTX, id), \
+	SR(RDPCSTX0_RDPCSTX_SCRATCH), \
+	SRI(RDPCSTX_PHY_RX_LD_VAL, RDPCSTX, id),\
+	SRI(RDPCSTX_DMCU_DPALT_DIS_BLOCK_REG, RDPCSTX, id)
+
 void dcn31_link_encoder_construct(
 	struct dcn20_link_encoder *enc20,
 	const struct encoder_init_data *init_data,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
index 16bbccc69fdc..5e924d0389cc 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
@@ -2162,6 +2162,9 @@ static bool dcn31_resource_construct(
 		pool->base.usb4_dpia_count = 4;
 	}
 
+	if (dc->ctx->asic_id.chip_family == AMDGPU_FAMILY_GC_11_0_2)
+		pool->base.usb4_dpia_count = 4;
+
 	/* Audio, Stream Encoders including HPO and virtual, MPC 3D LUTs */
 	if (!resource_construct(num_virtual_links, dc, &pool->base,
 			(!IS_FPGA_MAXIMUS_DC(dc->ctx->dce_environment) ?
diff --git a/drivers/gpu/drm/amd/display/dc/gpio/hw_factory.c b/drivers/gpu/drm/amd/display/dc/gpio/hw_factory.c
index 5c419225c3d6..0ceba8f57d57 100644
--- a/drivers/gpu/drm/amd/display/dc/gpio/hw_factory.c
+++ b/drivers/gpu/drm/amd/display/dc/gpio/hw_factory.c
@@ -100,6 +100,7 @@ bool dal_hw_factory_init(
 	case DCN_VERSION_3_02:
 	case DCN_VERSION_3_03:
 	case DCN_VERSION_3_1:
+	case DCN_VERSION_3_14:
 	case DCN_VERSION_3_16:
 		dal_hw_factory_dcn30_init(factory);
 		return true;
diff --git a/drivers/gpu/drm/amd/display/dc/gpio/hw_translate.c b/drivers/gpu/drm/amd/display/dc/gpio/hw_translate.c
index 82aad7bc0300..23b7ddefda11 100644
--- a/drivers/gpu/drm/amd/display/dc/gpio/hw_translate.c
+++ b/drivers/gpu/drm/amd/display/dc/gpio/hw_translate.c
@@ -101,6 +101,7 @@ bool dal_hw_translate_init(
 	case DCN_VERSION_3_02:
 	case DCN_VERSION_3_03:
 	case DCN_VERSION_3_1:
+	case DCN_VERSION_3_14:
 	case DCN_VERSION_3_16:
 		dal_hw_translate_dcn30_init(translate);
 		return true;
diff --git a/drivers/gpu/drm/amd/display/dc/irq/Makefile b/drivers/gpu/drm/amd/display/dc/irq/Makefile
index 41da81c85fdc..a0d86a154a98 100644
--- a/drivers/gpu/drm/amd/display/dc/irq/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/irq/Makefile
@@ -135,6 +135,16 @@ IRQ_DCN31 = irq_service_dcn31.o
 AMD_DAL_IRQ_DCN31= $(addprefix $(AMDDALPATH)/dc/irq/dcn31/,$(IRQ_DCN31))
 
 AMD_DISPLAY_FILES += $(AMD_DAL_IRQ_DCN31)
+
+###############################################################################
+# DCN 314
+###############################################################################
+IRQ_DCN314 = irq_service_dcn314.o
+
+AMD_DAL_IRQ_DCN314= $(addprefix $(AMDDALPATH)/dc/irq/dcn314/,$(IRQ_DCN314))
+
+AMD_DISPLAY_FILES += $(AMD_DAL_IRQ_DCN314)
+
 ###############################################################################
 # DCN 315
 ###############################################################################
-- 
2.35.3

