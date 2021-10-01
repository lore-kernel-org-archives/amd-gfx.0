Return-Path: <SRS0=Ip3g=OV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 482E2C433F5
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Oct 2021 14:31:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 047FF61A40
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Oct 2021 14:31:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 047FF61A40
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C2E76ECFD;
	Fri,  1 Oct 2021 14:31:22 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2048.outbound.protection.outlook.com [40.107.236.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D6F06ECFD
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 Oct 2021 14:31:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NyF3wHxXEmdIIVXQrfNANfz1fRljgBEtoSXB7/6YnGFfYQ32Oy2oZxBop4w/CUnj2OVgW52xXoReAIG2Fh7Ir5c3JlItHHhPXlJE38IT600Z5PXWsIQEpTFDh78CmFBfaSa+oYlMEIK/dAx2yOZNK54qapZrywPlvQzZe+1gPHQswsRUOIZrYHXgMByyJkF7fKr1nNmXN+wbGt9c6Xj52WCwgwJ3hM1wmHaCTHB6L0LvXy4DAw7YJ6KeKU9mPxsuR/NS7gQeVZZ/zZ5Zx8Wt/WMUYI5lED/0Er9649CLCLsbCBZRu+XRzo/92+lozvbWCzQTvLbs5zlbrOCuLx4v7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mKQWpcQdWEz5MxhKqT0diwwNEaL5dEENRgZebNgWMXU=;
 b=mQpWp51feoVZoS95mVPqDsh5Tb5lH0t1ONXszAwUOvx+8HGjZxQtqa7GJT5yx3YKIPEAcr0+Sq22rlzjF++Iy+xT6rt740wwnjHfpJhn2Acv5A3SSkqW5omk9yLhrNZguI5D9NtkQzk+tNatyX914BdqQ48zLQicOqfY48vZ+W77FVuREaFyRz2DNC/dBv8TzcE8JuBODc0PFSA/VqsrUgNt6pIMGWAcGLhYokUnMGXzHNEAO5MNsHPUczMQUXUITVPSOP4IIrpuZxTQvtLMHb1tlUyqackv21etqDcEiyuJ4UPV2Q334HSyIEm1rjUk+WsHdDsP8LkjWRHQCuT5yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mKQWpcQdWEz5MxhKqT0diwwNEaL5dEENRgZebNgWMXU=;
 b=G7xmWgTK+wWPibUd6DdCnR6oxwUAMOhkemZKtfRxzI/Nz+AEoJiDIkEdmgNY5JS73QagdmvbKJHZmYDisbOVS99xrEYGwBy11t/Z9Q67YE7JrMQb/pboXP1WN0A2vLCZwvWEIf/T/YkDn5GlXHZohC/2PFmcbw+5qHgwluh2oN8=
Received: from DM6PR02CA0038.namprd02.prod.outlook.com (2603:10b6:5:177::15)
 by CH2PR12MB4924.namprd12.prod.outlook.com (2603:10b6:610:6b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.15; Fri, 1 Oct
 2021 14:31:18 +0000
Received: from DM6NAM11FT062.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:177:cafe::5) by DM6PR02CA0038.outlook.office365.com
 (2603:10b6:5:177::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.20 via Frontend
 Transport; Fri, 1 Oct 2021 14:31:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT062.mail.protection.outlook.com (10.13.173.40) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4566.14 via Frontend Transport; Fri, 1 Oct 2021 14:31:18 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Fri, 1 Oct 2021
 09:31:17 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu/display: fold DRM_AMD_DC_DCN201 into DRM_AMD_DC_DCN
Date: Fri, 1 Oct 2021 10:31:05 -0400
Message-ID: <20211001143105.558588-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9ee347cc-7638-4e4a-2a81-08d984e821b0
X-MS-TrafficTypeDiagnostic: CH2PR12MB4924:
X-Microsoft-Antispam-PRVS: <CH2PR12MB4924A1AF93E6D05047C33361F7AB9@CH2PR12MB4924.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:345;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GZhjMtNwokPvxIBczN3NlrnBle2gzdyFNe78ZtQDiZhcLfN0wX7AqFOP8QPFk/8n8H7Oh+oVrzA/6c7eBqZolXKqYuBczjeywqulvQdT2cLDapT+FSJ/tX7NZLkTiEJKi3KmaHCRpGjl/WEvkYR4NhaqPUZM3X/lsfRH5HEWtmBAt3/kMt2BpQkYDa08xcduLC1z5PfC6M/L6qjkof1Kae+v91aw7XPl1ZDU3Loyga1zeA9Gh1sHzrvIhiCdpQLF7QqimqZaxHFT2ob3j5NGJyKGDmyw0VpeKdWpoZ9BOgRAP7XubYzSQkeeCl00rvVsz3udfTkBag3ZXpT+ss5gmjWp0qS1Rla/VMTKf0EPGDXFnYgk1j2Vzv9tXE4la5UjzZh28uLzW5Nl09lbZbAmWhPSLY+k0R5la1Viy4JVvmItslKLvZg8dxUSsCY4Ps3+uDZ6Y2fw3xX9VaLw83MgJTbp6ATWwBLQWsEC38CyUTV5llH5U5aznw4Gmm7OJWmKumseCK9Sz7KDHet5Mh5oySrfQzOH64XnbKAuZbUWkcqsYvrFVw51mjIypnsJulo2Sr5aF6IEUx7zeDpQUebZrPaAQmD2cHqfbVgjPbT4pDoDpFOZMYDbrKmxZ7ynKxf5rPKJ3N1Okd2B/bEetydR/y7fgP1CMZa3avDNFKeWKsf0pZh4LRZwUZsaYzVSLffpXS0mhQRLAbpuLNqxoW9jSq/m4ZTM1IKoQmdgtIYt5yE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(36860700001)(82310400003)(508600001)(1076003)(8936002)(36756003)(81166007)(356005)(6916009)(2906002)(7696005)(26005)(86362001)(5660300002)(70206006)(316002)(4326008)(70586007)(8676002)(47076005)(83380400001)(336012)(426003)(6666004)(186003)(16526019)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2021 14:31:18.1329 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ee347cc-7638-4e4a-2a81-08d984e821b0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT062.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4924
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

No need for a separate kconfig option at this point.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/Kconfig               | 9 ---------
 drivers/gpu/drm/amd/display/dc/Makefile           | 2 --
 drivers/gpu/drm/amd/display/dc/clk_mgr/Makefile   | 2 --
 drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c  | 2 --
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c | 2 --
 drivers/gpu/drm/amd/display/dc/irq/Makefile       | 2 --
 6 files changed, 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/Kconfig b/drivers/gpu/drm/amd/display/Kconfig
index fb074a6067b2..7dffc04a557e 100644
--- a/drivers/gpu/drm/amd/display/Kconfig
+++ b/drivers/gpu/drm/amd/display/Kconfig
@@ -17,15 +17,6 @@ config DRM_AMD_DC_DCN
 	help
 	  Raven, Navi, and newer family support for display engine
 
-config DRM_AMD_DC_DCN201
-	bool "Enable DCN201 support in DC"
-	default y
-	depends on DRM_AMD_DC && X86
-	depends on DRM_AMD_DC_DCN
-	help
-	  Choose this option if you want to have
-	  201 support for display engine
-
 config DRM_AMD_DC_HDCP
 	bool "Enable HDCP support in DC"
 	depends on DRM_AMD_DC
diff --git a/drivers/gpu/drm/amd/display/dc/Makefile b/drivers/gpu/drm/amd/display/dc/Makefile
index 520f58538364..b5482980e995 100644
--- a/drivers/gpu/drm/amd/display/dc/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/Makefile
@@ -30,9 +30,7 @@ DC_LIBS += dcn20
 DC_LIBS += dsc
 DC_LIBS += dcn10 dml
 DC_LIBS += dcn21
-ifdef CONFIG_DRM_AMD_DC_DCN201
 DC_LIBS += dcn201
-endif
 DC_LIBS += dcn30
 DC_LIBS += dcn301
 DC_LIBS += dcn302
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/Makefile b/drivers/gpu/drm/amd/display/dc/clk_mgr/Makefile
index 7f70985b7a1b..6bd73e49a6d2 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/Makefile
@@ -93,7 +93,6 @@ AMD_DAL_CLK_MGR_DCN20 = $(addprefix $(AMDDALPATH)/dc/clk_mgr/dcn20/,$(CLK_MGR_DC
 
 AMD_DISPLAY_FILES += $(AMD_DAL_CLK_MGR_DCN20)
 
-ifdef CONFIG_DRM_AMD_DC_DCN201
 ###############################################################################
 # DCN201
 ###############################################################################
@@ -102,7 +101,6 @@ CLK_MGR_DCN201 = dcn201_clk_mgr.o
 AMD_DAL_CLK_MGR_DCN201 = $(addprefix $(AMDDALPATH)/dc/clk_mgr/dcn201/,$(CLK_MGR_DCN201))
 
 AMD_DISPLAY_FILES += $(AMD_DAL_CLK_MGR_DCN201)
-endif
 
 ###############################################################################
 # DCN21
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
index 421f5135b701..1548b2a3fe03 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
@@ -257,12 +257,10 @@ struct clk_mgr *dc_clk_mgr_create(struct dc_context *ctx, struct pp_smu_funcs *p
 			dcn3_clk_mgr_construct(ctx, clk_mgr, pp_smu, dccg);
 			return &clk_mgr->base;
 		}
-#if defined(CONFIG_DRM_AMD_DC_DCN201)
 		if (asic_id.chip_id == DEVICE_ID_NV_13FE) {
 			dcn201_clk_mgr_construct(ctx, clk_mgr, pp_smu, dccg);
 			return &clk_mgr->base;
 		}
-#endif
 		dcn20_clk_mgr_construct(ctx, clk_mgr, pp_smu, dccg);
 		return &clk_mgr->base;
 	}
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index fc490b77f47d..561c10a92bb5 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -224,11 +224,9 @@ struct resource_pool *dc_create_resource_pool(struct dc  *dc,
 	case DCN_VERSION_2_1:
 		res_pool = dcn21_create_resource_pool(init_data, dc);
 		break;
-#if defined(CONFIG_DRM_AMD_DC_DCN201)
 	case DCN_VERSION_2_01:
 		res_pool = dcn201_create_resource_pool(init_data, dc);
 		break;
-#endif
 	case DCN_VERSION_3_0:
 		res_pool = dcn30_create_resource_pool(init_data, dc);
 		break;
diff --git a/drivers/gpu/drm/amd/display/dc/irq/Makefile b/drivers/gpu/drm/amd/display/dc/irq/Makefile
index 8a182772eed2..fd739aecf104 100644
--- a/drivers/gpu/drm/amd/display/dc/irq/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/irq/Makefile
@@ -94,7 +94,6 @@ AMD_DAL_IRQ_DCN21= $(addprefix $(AMDDALPATH)/dc/irq/dcn21/,$(IRQ_DCN21))
 
 AMD_DISPLAY_FILES += $(AMD_DAL_IRQ_DCN21)
 
-ifdef CONFIG_DRM_AMD_DC_DCN201
 ###############################################################################
 # DCN 201
 ###############################################################################
@@ -103,7 +102,6 @@ IRQ_DCN201 = irq_service_dcn201.o
 AMD_DAL_IRQ_DCN201 = $(addprefix $(AMDDALPATH)/dc/irq/dcn201/,$(IRQ_DCN201))
 
 AMD_DISPLAY_FILES += $(AMD_DAL_IRQ_DCN201)
-endif
 
 ###############################################################################
 # DCN 30
-- 
2.31.1

