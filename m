Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A12A6C64EC4
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Mar 2023 15:50:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2293710E6DD;
	Fri,  3 Mar 2023 15:50:45 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2061d.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::61d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8FCA210E6E1
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Mar 2023 15:50:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bwEBkglS5hqAtAhY+w0qRouXbnMT6YYhDqrMxNRD24Jl3w+Cj1t1XghN/8m4x3MIBhUdu1mxIg20264qxV0MQd826d1iskA1a5aIbKzstXWZtWsFMCF5v6rcghk6fxbIYXdoG304TKnGM3v/ioIc5DEuV23OgebA943FtWkGLoMa+8752W6XaTObhU8D1rFq1ZwoRpVbDPXdiOmqulR/B5y0o6fFERaCnVRNNoT06qZ/KgmislW6+EFCxB+/aEzjEv48cxXbs9YJOaLJvIo58rFNSyTSPeANE37O9OluhdkcYpzmlsV/aL+w4HLW1kvGx1YEW49kLJdk1kQ1PGs6Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zHxcwx4kCcNWfpp2FQUXQ99+9pA1fmn8vo8Ay10F0kk=;
 b=Q+Ls+c58W0IDYKIiXNLnM/Eusgh6fb4YqeQk6hWf+uLjoQDnNzeUpauUUB0JFCWkJTJ4qFOFsHa9KbzKtZoDNztxEsYFgOaA5O3/yRDxh99A2L2ZgnIyhtWdYTjGJlCIlxPERsYyjf+B1GjhYC0sBUfgkrE7cCmQf3gQ4FyKiAjIsJ3J8OFO5uUFOIAEwS60wkC51QyaNgY2CQOhtIU+HIpbFvaFALfovdZ1K/8R1mDbKn89mspVB+rLCKgHm0cglJdJVJfIiCOC8MU45RUYETt5bzq5ZbTAe5E1uc6THvhqeqR/Le2PfeZoK+EWQRTA+QoRW2PrJmkWGvdvQSjGWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zHxcwx4kCcNWfpp2FQUXQ99+9pA1fmn8vo8Ay10F0kk=;
 b=KjiYSf7nQhL9vBxiNFmpeePQTOGTAigQ+vWWM32bOiJ+n5RqAxEhnD4+y749p9EGW7aUc8dJocYzpnWp9V2AwLUKDNgyqxZiCGX+6Y7qITjiSppfZAZR5Q1HL8rVeCS6TW70CORdcbMAIaDDZkfC6F3F0ILLOVOz0ArrX6qo0Qc=
Received: from DM5PR07CA0058.namprd07.prod.outlook.com (2603:10b6:4:ad::23) by
 SJ2PR12MB7920.namprd12.prod.outlook.com (2603:10b6:a03:4cc::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6134.26; Fri, 3 Mar 2023 15:50:39 +0000
Received: from DS1PEPF0000E62F.namprd02.prod.outlook.com
 (2603:10b6:4:ad:cafe::f) by DM5PR07CA0058.outlook.office365.com
 (2603:10b6:4:ad::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.22 via Frontend
 Transport; Fri, 3 Mar 2023 15:50:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000E62F.mail.protection.outlook.com (10.167.17.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6156.12 via Frontend Transport; Fri, 3 Mar 2023 15:50:39 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 3 Mar
 2023 09:50:24 -0600
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 22/33] drm/amd/display: Rename DCN config to FP
Date: Fri, 3 Mar 2023 10:40:11 -0500
Message-ID: <20230303154022.2667-23-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230303154022.2667-1-qingqing.zhuo@amd.com>
References: <20230303154022.2667-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E62F:EE_|SJ2PR12MB7920:EE_
X-MS-Office365-Filtering-Correlation-Id: 671784bd-1473-451e-2392-08db1bff0981
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WdKupHp8zH4QQR/GAI9MO+Aqhb5ktXGjD/6xFmlxlviPpSRLkkbkscsM/mYywu2ll8OKv8DT+cqcc4y6HRQbc61gfhb35rEFE3SOsUuDrDU1u3jRvUdDHc41KUrPNWNgKyIGJvffrvgW4n6CLxURv/YlnITC3Dvnt2xSKkkEj/jEZxN3/OBODwbkQtDXy0tNjLag9kl3I3Cegj5XQco/V4149laxcvVSfssqjxk9zTVfVUL9+2mIMUrsIi08rJmF5wukUB6ZIGVTp4oM4T8uvCpz/v57zwiA80oD54RD24RlFjKHXZn1uxh3ejCSEVx+HqqNeX4t8KkwsHvsVHiHdkSurrPDhZhn+bx2j5DmWhL6dNjRAS+1FkT1m6D4JxuwFcBWkXM9REjuRRXwZuzK6lHPpqBP6h49dcGS5l3GJBrLSDz50yT0HJdGVRCnGUreX13uskeUT50q484rswVbnNbFfy6Ai5dEHxmWaM7pKytuYW3v+M+9XxwSZvAkJwG8gq5GMPXMs10zRdl2pOeD77A5hIWMIEmuYCxMWLtVKxKGP1CfY4ptlcsfMjTYslt8H3xzP6ue4z+ZQNquTDREoGkh2cgZ4EpErGDUnvwKVb4WdsOgLMwPq2z4BcnNxSaSVNkMTyywfr5Vrm0cjWZeF3XjyU+tiBZjy/YXR2rDIkhn0vp1uvi7CeEXdPiWzsdoiKPtN+gZPflL7a5Oma+D0ELPdz/t+IX92x+/0hK3ec4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(346002)(39860400002)(396003)(136003)(376002)(451199018)(46966006)(36840700001)(40470700004)(82310400005)(54906003)(316002)(36756003)(36860700001)(86362001)(966005)(186003)(26005)(478600001)(40460700003)(47076005)(426003)(336012)(30864003)(8676002)(6916009)(70586007)(4326008)(8936002)(70206006)(2906002)(41300700001)(6666004)(1076003)(16526019)(2616005)(40480700001)(44832011)(5660300002)(82740400003)(83380400001)(81166007)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2023 15:50:39.2344 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 671784bd-1473-451e-2392-08db1bff0981
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E62F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7920
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com,
 Harry Wentland <harry.wentland@amd.com>, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Harry Wentland <harry.wentland@amd.com>

[Why & How]
The only reason we have the DCN config is for
floating point support. Rename it to make that
clear and (hopefully) avoid misuse of the config
in the future.

Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Harry Wentland <harry.wentland@amd.com>
---
 drivers/gpu/drm/amd/display/Kconfig                       | 8 ++++----
 drivers/gpu/drm/amd/display/amdgpu_dm/Makefile            | 2 +-
 drivers/gpu/drm/amd/display/dc/Makefile                   | 2 +-
 drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c        | 2 +-
 drivers/gpu/drm/amd/display/dc/clk_mgr/Makefile           | 2 +-
 drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c          | 8 ++++----
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c | 2 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c                  | 2 +-
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c         | 8 ++++----
 drivers/gpu/drm/amd/display/dc/dc.h                       | 2 +-
 drivers/gpu/drm/amd/display/dc/dc_hw_types.h              | 2 +-
 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c        | 4 ++--
 drivers/gpu/drm/amd/display/dc/dml/Makefile               | 2 +-
 drivers/gpu/drm/amd/display/dc/dsc/rc_calc.c              | 2 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/dwb.h               | 2 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h              | 2 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h  | 2 +-
 drivers/gpu/drm/amd/display/dc/inc/hw_sequencer_private.h | 2 +-
 drivers/gpu/drm/amd/display/dc/inc/resource.h             | 2 +-
 drivers/gpu/drm/amd/display/dc/link/link_validation.c     | 2 +-
 drivers/gpu/drm/amd/display/dc/os_types.h                 | 4 ++--
 21 files changed, 32 insertions(+), 32 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/Kconfig b/drivers/gpu/drm/amd/display/Kconfig
index 2426cad1de2a..dae0356991ca 100644
--- a/drivers/gpu/drm/amd/display/Kconfig
+++ b/drivers/gpu/drm/amd/display/Kconfig
@@ -7,16 +7,16 @@ config DRM_AMD_DC
 	default y
 	select SND_HDA_COMPONENT if SND_HDA_CORE
 	# !CC_IS_CLANG: https://github.com/ClangBuiltLinux/linux/issues/1752
-	select DRM_AMD_DC_DCN if (X86 || PPC_LONG_DOUBLE_128 || (ARM64 && KERNEL_MODE_NEON && !CC_IS_CLANG))
+	select DRM_AMD_DC_FP if (X86 || PPC64 || (ARM64 && KERNEL_MODE_NEON && !CC_IS_CLANG))
 	help
 	  Choose this option if you want to use the new display engine
 	  support for AMDGPU. This adds required support for Vega and
 	  Raven ASICs.
 
-config DRM_AMD_DC_DCN
+config DRM_AMD_DC_FP
 	def_bool n
 	help
-	  Raven, Navi, and newer family support for display engine
+	  Floating point support, required for DCN-based SoCs
 
 config DRM_AMD_DC_SI
 	bool "AMD DC support for Southern Islands ASICs"
@@ -37,7 +37,7 @@ config DEBUG_KERNEL_DC
 config DRM_AMD_SECURE_DISPLAY
         bool "Enable secure display support"
         depends on DEBUG_FS
-        depends on DRM_AMD_DC_DCN
+        depends on DRM_AMD_DC_FP
         help
             Choose this option if you want to
             support secure display
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/Makefile b/drivers/gpu/drm/amd/display/amdgpu_dm/Makefile
index aef782ca3706..249b073f6a23 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/Makefile
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/Makefile
@@ -33,7 +33,7 @@ AMDGPUDM = \
 	amdgpu_dm_mst_types.o \
 	amdgpu_dm_color.o
 
-ifdef CONFIG_DRM_AMD_DC_DCN
+ifdef CONFIG_DRM_AMD_DC_FP
 AMDGPUDM += dc_fpu.o
 endif
 
diff --git a/drivers/gpu/drm/amd/display/dc/Makefile b/drivers/gpu/drm/amd/display/dc/Makefile
index d2b1e824eeaa..69ffd4424dc7 100644
--- a/drivers/gpu/drm/amd/display/dc/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/Makefile
@@ -24,7 +24,7 @@
 
 DC_LIBS = basics bios dml clk_mgr dce gpio irq link virtual dsc
 
-ifdef CONFIG_DRM_AMD_DC_DCN
+ifdef CONFIG_DRM_AMD_DC_FP
 
 KCOV_INSTRUMENT := n
 
diff --git a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
index e381de2429fa..f0f948501e9a 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
@@ -2064,7 +2064,7 @@ static enum bp_result bios_parser_get_encoder_cap_info(
 	if (!info)
 		return BP_RESULT_BADINPUT;
 
-#if defined(CONFIG_DRM_AMD_DC_DCN)
+#if defined(CONFIG_DRM_AMD_DC_FP)
 	/* encoder cap record not available in v1_5 */
 	if (bp->object_info_tbl.revision.minor == 5)
 		return BP_RESULT_NORECORD;
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/Makefile b/drivers/gpu/drm/amd/display/dc/clk_mgr/Makefile
index 271d8e573181..ad390e4cd0a9 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/Makefile
@@ -74,7 +74,7 @@ CLK_MGR_DCE120 = dce120_clk_mgr.o
 AMD_DAL_CLK_MGR_DCE120 = $(addprefix $(AMDDALPATH)/dc/clk_mgr/dce120/,$(CLK_MGR_DCE120))
 
 AMD_DISPLAY_FILES += $(AMD_DAL_CLK_MGR_DCE120)
-ifdef CONFIG_DRM_AMD_DC_DCN
+ifdef CONFIG_DRM_AMD_DC_FP
 ###############################################################################
 # DCN10
 ###############################################################################
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
index 73a45ec27f90..ee81d36146e4 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
@@ -221,7 +221,7 @@ struct clk_mgr *dc_clk_mgr_create(struct dc_context *ctx, struct pp_smu_funcs *p
 			dce120_clk_mgr_construct(ctx, clk_mgr);
 		return &clk_mgr->base;
 	}
-#if defined(CONFIG_DRM_AMD_DC_DCN)
+#if defined(CONFIG_DRM_AMD_DC_FP)
 	case FAMILY_RV: {
 		struct clk_mgr_internal *clk_mgr = kzalloc(sizeof(*clk_mgr), GFP_KERNEL);
 
@@ -351,7 +351,7 @@ struct clk_mgr *dc_clk_mgr_create(struct dc_context *ctx, struct pp_smu_funcs *p
 	}
 	break;
 
-#endif
+#endif /* CONFIG_DRM_AMD_DC_FP - Family RV */
 	default:
 		ASSERT(0); /* Unknown Asic */
 		break;
@@ -364,7 +364,7 @@ void dc_destroy_clk_mgr(struct clk_mgr *clk_mgr_base)
 {
 	struct clk_mgr_internal *clk_mgr = TO_CLK_MGR_INTERNAL(clk_mgr_base);
 
-#ifdef CONFIG_DRM_AMD_DC_DCN
+#ifdef CONFIG_DRM_AMD_DC_FP
 	switch (clk_mgr_base->ctx->asic_id.chip_family) {
 	case FAMILY_NV:
 		if (ASICREV_IS_SIENNA_CICHLID_P(clk_mgr_base->ctx->asic_id.hw_internal_rev)) {
@@ -405,7 +405,7 @@ void dc_destroy_clk_mgr(struct clk_mgr *clk_mgr_base)
 	default:
 		break;
 	}
-#endif
+#endif /* CONFIG_DRM_AMD_DC_FP */
 
 	kfree(clk_mgr);
 }
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
index ca6dfd2d7561..bd9fd0b54f46 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
@@ -706,7 +706,7 @@ void rn_clk_mgr_construct(
 	enum pp_smu_status status = 0;
 	int is_green_sardine = 0;
 
-#if defined(CONFIG_DRM_AMD_DC_DCN)
+#if defined(CONFIG_DRM_AMD_DC_FP)
 	is_green_sardine = ASICREV_IS_GREEN_SARDINE(ctx->asic_id.hw_internal_rev);
 #endif
 
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 8282401f6fb3..f9f051f1537d 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -994,7 +994,7 @@ static bool dc_construct(struct dc *dc,
 	dc->clk_mgr = dc_clk_mgr_create(dc->ctx, dc->res_pool->pp_smu, dc->res_pool->dccg);
 	if (!dc->clk_mgr)
 		goto fail;
-#ifdef CONFIG_DRM_AMD_DC_DCN
+#ifdef CONFIG_DRM_AMD_DC_FP
 	dc->clk_mgr->force_smu_not_present = init_params->force_smu_not_present;
 
 	if (dc->res_pool->funcs->update_bw_bounding_box) {
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index d9f2ef242b0f..2e3b2fd23b56 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -232,7 +232,7 @@ struct resource_pool *dc_create_resource_pool(struct dc  *dc,
 				init_data->num_virtual_links, dc);
 		break;
 
-#if defined(CONFIG_DRM_AMD_DC_DCN)
+#if defined(CONFIG_DRM_AMD_DC_FP)
 	case DCN_VERSION_1_0:
 	case DCN_VERSION_1_01:
 		res_pool = dcn10_create_resource_pool(init_data, dc);
@@ -276,7 +276,7 @@ struct resource_pool *dc_create_resource_pool(struct dc  *dc,
 	case DCN_VERSION_3_21:
 		res_pool = dcn321_create_resource_pool(init_data, dc);
 		break;
-#endif
+#endif /* CONFIG_DRM_AMD_DC_FP */
 	default:
 		break;
 	}
@@ -4027,14 +4027,14 @@ bool dc_resource_acquire_secondary_pipe_for_mpc_odm(
 		else
 			sec_pipe->stream_res.opp = sec_pipe->top_pipe->stream_res.opp;
 		if (sec_pipe->stream->timing.flags.DSC == 1) {
-#if defined(CONFIG_DRM_AMD_DC_DCN)
+#if defined(CONFIG_DRM_AMD_DC_FP)
 			dcn20_acquire_dsc(dc, &state->res_ctx, &sec_pipe->stream_res.dsc, pipe_idx);
 #endif
 			ASSERT(sec_pipe->stream_res.dsc);
 			if (sec_pipe->stream_res.dsc == NULL)
 				return false;
 		}
-#if defined(CONFIG_DRM_AMD_DC_DCN)
+#if defined(CONFIG_DRM_AMD_DC_FP)
 		dcn20_build_mapped_resource(dc, state, sec_pipe->stream);
 #endif
 	}
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index c1e69fdd5020..0f6873449d15 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -2054,7 +2054,7 @@ struct dc_sink_dsc_caps {
 	// 'true' if these are virtual DPCD's DSC caps (immediately upstream of sink in MST topology),
 	// 'false' if they are sink's DSC caps
 	bool is_virtual_dpcd_dsc;
-#if defined(CONFIG_DRM_AMD_DC_DCN)
+#if defined(CONFIG_DRM_AMD_DC_FP)
 	// 'true' if MST topology supports DSC passthrough for sink
 	// 'false' if MST topology does not support DSC passthrough
 	bool is_dsc_passthrough_supported;
diff --git a/drivers/gpu/drm/amd/display/dc/dc_hw_types.h b/drivers/gpu/drm/amd/display/dc/dc_hw_types.h
index a583a72845fe..100d62162b71 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_hw_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_hw_types.h
@@ -829,7 +829,7 @@ struct dc_dsc_config {
 	uint32_t version_minor; /* DSC minor version. Full version is formed as 1.version_minor. */
 	bool ycbcr422_simple; /* Tell DSC engine to convert YCbCr 4:2:2 to 'YCbCr 4:2:2 simple'. */
 	int32_t rc_buffer_size; /* DSC RC buffer block size in bytes */
-#if defined(CONFIG_DRM_AMD_DC_DCN)
+#if defined(CONFIG_DRM_AMD_DC_FP)
 	bool is_frl; /* indicate if DSC is applied based on HDMI FRL sink's capability */
 #endif
 	bool is_dp; /* indicate if DSC is applied based on DP's capability */
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c
index d13e46eeee3c..80a0c5a575a9 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c
@@ -97,7 +97,7 @@ static void enable_memory_low_power(struct dc *dc)
 		// Power down VPGs
 		for (i = 0; i < dc->res_pool->stream_enc_count; i++)
 			dc->res_pool->stream_enc[i]->vpg->funcs->vpg_powerdown(dc->res_pool->stream_enc[i]->vpg);
-#if defined(CONFIG_DRM_AMD_DC_DCN)
+#if defined(CONFIG_DRM_AMD_DC_FP)
 		for (i = 0; i < dc->res_pool->hpo_dp_stream_enc_count; i++)
 			dc->res_pool->hpo_dp_stream_enc[i]->vpg->funcs->vpg_powerdown(dc->res_pool->hpo_dp_stream_enc[i]->vpg);
 #endif
@@ -291,7 +291,7 @@ void dcn31_init_hw(struct dc *dc)
 	if (dc->res_pool->hubbub->funcs->force_pstate_change_control)
 		dc->res_pool->hubbub->funcs->force_pstate_change_control(
 				dc->res_pool->hubbub, false, false);
-#if defined(CONFIG_DRM_AMD_DC_DCN)
+#if defined(CONFIG_DRM_AMD_DC_FP)
 	if (dc->res_pool->hubbub->funcs->init_crb)
 		dc->res_pool->hubbub->funcs->init_crb(dc->res_pool->hubbub);
 #endif
diff --git a/drivers/gpu/drm/amd/display/dc/dml/Makefile b/drivers/gpu/drm/amd/display/dc/dml/Makefile
index d4e93bed1c8e..a38888ddcf05 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dml/Makefile
@@ -128,7 +128,7 @@ CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/calcs/dcn_calc_math.o := $(dml_rcflags)
 
 DML = calcs/dce_calcs.o calcs/custom_float.o calcs/bw_fixed.o
 
-ifdef CONFIG_DRM_AMD_DC_DCN
+ifdef CONFIG_DRM_AMD_DC_FP
 DML += display_mode_lib.o display_rq_dlg_helpers.o dml1_display_rq_dlg_calc.o
 DML += dcn10/dcn10_fpu.o
 DML += dcn20/dcn20_fpu.o
diff --git a/drivers/gpu/drm/amd/display/dc/dsc/rc_calc.c b/drivers/gpu/drm/amd/display/dc/dsc/rc_calc.c
index 3215ca4d5799..64cee8c80110 100644
--- a/drivers/gpu/drm/amd/display/dc/dsc/rc_calc.c
+++ b/drivers/gpu/drm/amd/display/dc/dsc/rc_calc.c
@@ -39,7 +39,7 @@
  */
 void calc_rc_params(struct rc_params *rc, const struct drm_dsc_config *pps)
 {
-#if defined(CONFIG_DRM_AMD_DC_DCN)
+#if defined(CONFIG_DRM_AMD_DC_FP)
 	enum colour_mode mode;
 	enum bits_per_comp bpc;
 	bool is_navite_422_or_420;
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/dwb.h b/drivers/gpu/drm/amd/display/dc/inc/hw/dwb.h
index 42f7081cf3b3..86b711dcc785 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/dwb.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/dwb.h
@@ -202,7 +202,7 @@ struct dwbc_funcs {
 		struct dwb_warmup_params *warmup_params);
 
 
-#if defined(CONFIG_DRM_AMD_DC_DCN)
+#if defined(CONFIG_DRM_AMD_DC_FP)
 
 	void (*dwb_program_output_csc)(
 		struct dwbc *dwbc,
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h b/drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h
index d5ea7545583e..b5d353c41aa9 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h
@@ -146,7 +146,7 @@ struct hubp_funcs {
 
 	void (*set_blank)(struct hubp *hubp, bool blank);
 	void (*set_blank_regs)(struct hubp *hubp, bool blank);
-#ifdef CONFIG_DRM_AMD_DC_DCN
+#ifdef CONFIG_DRM_AMD_DC_FP
 	void (*phantom_hubp_post_enable)(struct hubp *hubp);
 #endif
 	void (*set_hubp_blank_en)(struct hubp *hubp, bool blank);
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h b/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h
index 1d9f9c53d2bd..c21e7ffd5bd0 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h
@@ -182,7 +182,7 @@ struct timing_generator_funcs {
 
 	bool (*enable_crtc)(struct timing_generator *tg);
 	bool (*disable_crtc)(struct timing_generator *tg);
-#ifdef CONFIG_DRM_AMD_DC_DCN
+#ifdef CONFIG_DRM_AMD_DC_FP
 	void (*phantom_crtc_post_enable)(struct timing_generator *tg);
 #endif
 	void (*disable_phantom_crtc)(struct timing_generator *tg);
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer_private.h b/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer_private.h
index a4d61bb724b6..45d37c584551 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer_private.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer_private.h
@@ -148,7 +148,7 @@ struct hwseq_private_funcs {
 	void (*PLAT_58856_wa)(struct dc_state *context,
 			struct pipe_ctx *pipe_ctx);
 	void (*setup_hpo_hw_control)(const struct dce_hwseq *hws, bool enable);
-#ifdef CONFIG_DRM_AMD_DC_DCN
+#ifdef CONFIG_DRM_AMD_DC_FP
 	void (*program_mall_pipe_config)(struct dc *dc, struct dc_state *context);
 	void (*subvp_update_force_pstate)(struct dc *dc, struct dc_state *context);
 	void (*update_mall_sel)(struct dc *dc, struct dc_state *context);
diff --git a/drivers/gpu/drm/amd/display/dc/inc/resource.h b/drivers/gpu/drm/amd/display/dc/inc/resource.h
index fa6da93caa88..eaeb684c8a48 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/resource.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/resource.h
@@ -201,7 +201,7 @@ bool get_temp_dp_link_res(struct dc_link *link,
 		struct link_resource *link_res,
 		struct dc_link_settings *link_settings);
 
-#if defined(CONFIG_DRM_AMD_DC_DCN)
+#if defined(CONFIG_DRM_AMD_DC_FP)
 struct hpo_dp_link_encoder *resource_get_hpo_dp_link_enc_for_det_lt(
 		const struct resource_context *res_ctx,
 		const struct resource_pool *pool,
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_validation.c b/drivers/gpu/drm/amd/display/dc/link/link_validation.c
index 2ab23bdf5a89..62aa5f6b1f0c 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_validation.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_validation.c
@@ -124,7 +124,7 @@ static bool dp_active_dongle_validate_timing(
 		if (dongle_caps->dp_hdmi_frl_max_link_bw_in_kbps > 0) { // DP to HDMI FRL converter
 			struct dc_crtc_timing outputTiming = *timing;
 
-#if defined(CONFIG_DRM_AMD_DC_DCN)
+#if defined(CONFIG_DRM_AMD_DC_FP)
 			if (timing->flags.DSC && !timing->dsc_cfg.is_frl)
 				/* DP input has DSC, HDMI FRL output doesn't have DSC, remove DSC from output timing */
 				outputTiming.flags.DSC = 0;
diff --git a/drivers/gpu/drm/amd/display/dc/os_types.h b/drivers/gpu/drm/amd/display/dc/os_types.h
index 6b88ae14f1f9..aad8095660c9 100644
--- a/drivers/gpu/drm/amd/display/dc/os_types.h
+++ b/drivers/gpu/drm/amd/display/dc/os_types.h
@@ -53,11 +53,11 @@
 
 #define dm_error(fmt, ...) DRM_ERROR(fmt, ##__VA_ARGS__)
 
-#if defined(CONFIG_DRM_AMD_DC_DCN)
+#if defined(CONFIG_DRM_AMD_DC_FP)
 #include "amdgpu_dm/dc_fpu.h"
 #define DC_FP_START() dc_fpu_begin(__func__, __LINE__)
 #define DC_FP_END() dc_fpu_end(__func__, __LINE__)
-#endif
+#endif /* CONFIG_DRM_AMD_DC_FP */
 
 /*
  *
-- 
2.34.1

