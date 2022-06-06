Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32BA5CCA473
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Jun 2022 15:42:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D78B113EF5;
	Mon,  6 Jun 2022 15:42:48 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2081.outbound.protection.outlook.com [40.107.212.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AF785113EF5
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Jun 2022 15:42:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZQpnC7Ac8goCRIGtZeke0Gcsoy9HcF2wWKaiFWkb6QZI84qdPAhWeKRQXpeuPTuTn+3TkiiPAZsvxLgz44P9cqBhDP4whxeZtfzMnYWE8Tooyx2cwTC1k8U4b+6/P0mjHPGv6uqjBaxNN6C4/t7COAqxUAATGaVFM/B+ceBaATicLEurrqSWKzTQrX+f0in63g25dq9PHVOy51++rHU/2J+3C1Yz2g3y7y+Wy2zHt58bQ6qMPsMD0T9haJR4CfO0llXLErRoaDAJgUSA9C42jgqbUlWCyAmK1X6GUgrz8bJ2zYQM/RIc6y5OAtcvrbdW/bmL/2pXu+P7kMtK/PAH1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=exArU9UWeWI36JO6R2EpPIkZfP0f4YIWCjnUm8BWxqU=;
 b=bhi1iCjVTUFYLVXeGES2mxc9UPMfSquJj3ZHvijJtRfpVXp0C4Fm1MKi12x4qG7CsmwSSDqBQ9Z+H7vQ5QEfZIRPQ7mUOyGUKIx9BDqrBYzL5DevFHBJ3tGuUM4+mdfHLOSkcCtu8pWM1kg73p6l9Ucnrz2KrhoBC5Gd1+pDcp6I3h1mihCSS3fHVPb810IgS2Fn3wWAnOl0uv4GMcYtnXxLNpXwZHrMSSRMVeAsYiwL05fXgTr2nxJt+WEBt+jc0t0+Pt+QtdMN5eoOIAqt9KB+ica+nIyM4/+15q07TAEMwjwMhS//RDd/kmajxZ9u/aCVrHkgqaKCOoZILJzEDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=exArU9UWeWI36JO6R2EpPIkZfP0f4YIWCjnUm8BWxqU=;
 b=la9/K5vcRl1iI/8Chu9P/K7IbjSSLkJSC0msiP4uWAjPxQX9/wa4cLPnrH2Phw+QB3k14IFLtDIySE39RHBtS2s29ViRIuiYOY77nwsp4sg8AnIMFDWoQ8cawDQFKwvLvnmPIvvKXKGir2jfyPbJ9S5A3YZv93QEG2P6fYyTB5w=
Received: from MWHPR19CA0061.namprd19.prod.outlook.com (2603:10b6:300:94::23)
 by DM4PR12MB5262.namprd12.prod.outlook.com (2603:10b6:5:399::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13; Mon, 6 Jun
 2022 15:42:44 +0000
Received: from CO1NAM11FT029.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:94:cafe::2c) by MWHPR19CA0061.outlook.office365.com
 (2603:10b6:300:94::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.19 via Frontend
 Transport; Mon, 6 Jun 2022 15:42:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT029.mail.protection.outlook.com (10.13.174.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5314.12 via Frontend Transport; Mon, 6 Jun 2022 15:42:44 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 6 Jun
 2022 10:42:42 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amdgpu/display: make some functions static
Date: Mon, 6 Jun 2022 11:42:27 -0400
Message-ID: <20220606154228.839904-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4f5bb5fa-7bfa-444b-024e-08da47d332e3
X-MS-TrafficTypeDiagnostic: DM4PR12MB5262:EE_
X-Microsoft-Antispam-PRVS: <DM4PR12MB52623A1D61DDF183E8C6FFC5F7A29@DM4PR12MB5262.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YVcUjqXMi+iLwDl+hNXIxIk8QWMr7hjH9P9IAVOqnAk3uUqz5biAc1YlMfoybyRCoOh/bN0RD1tWO4IveQRoa4iCF1mizntM1Ve5UvPnDYd4bZ8Dc5x/GMRnEa/3hoN322sFh09UocmmpiTXwnBlV/iQZRQypbs4fTM6b9M8X+c+oSAlSRiDHBLThfwU3WRIaJr7n6jiHVnYavcslLqKOeDAJsMzeo+iwDjkp1AC9VGareTAB1dJFcepDSuRKDcjMxirxfhssFV69V92rxuyik2jZQqfz1AqPfuPEhmJrUe13X0nT6ifOwSBtYCMEwNvykNLCSIOHlo5O1kaHODw1esv6ifiaZazU9H+ZUctvIS2j8wJ6zElxUYMM/S+BncCnxCAKQvGxkbsA7lwV0mevVmLpKjeCM9z2cpWixhxCrOeI5JURFKZ8fEzuvzmsxt7FZYgRvwZoeicqJUqKTmMm/TE+g8w9vZwomuTsyN3miwjM/V5xsH+uFHdJhMCdY85EbH16DzGMg6f9zeTBPkgkinrVjy9f8FyzP3wYWYN0tVUY3KTDxnIisLMxIoBLm5sC3ll7RsWPNBz61qmy2JBaucIudEPHoLtSiA89SU9Y58WgwQWnJL3LOzkYFz+tAkg7evMcH/5pEa6Qb4pNxcY27Jg/guk0Ko1+hY2xxcqwVtXD+mQt2KD2is9h2OaEmxUcn05MdMfYEDtMjsdkKPEcg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(86362001)(8676002)(336012)(36756003)(2616005)(54906003)(47076005)(70586007)(70206006)(426003)(7696005)(6666004)(4326008)(36860700001)(6916009)(508600001)(1076003)(2906002)(83380400001)(26005)(5660300002)(356005)(82310400005)(316002)(8936002)(186003)(81166007)(40460700003)(16526019)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2022 15:42:44.1881 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f5bb5fa-7bfa-444b-024e-08da47d332e3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT029.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5262
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
Cc: Alex Deucher <alexander.deucher@amd.com>, kernel test robot <lkp@intel.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fixes "no previous prototype" warnings.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c  | 2 +-
 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dccg.c         | 8 ++++----
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dccg.c         | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
index 1db61029481b..ed70ae10bdb1 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
@@ -487,7 +487,7 @@ static void dcn32_update_clocks(struct clk_mgr *clk_mgr_base,
 				clk_mgr_base->clks.dispclk_khz / 1000 / 7);
 }
 
-void dcn32_clock_read_ss_info(struct clk_mgr_internal *clk_mgr)
+static void dcn32_clock_read_ss_info(struct clk_mgr_internal *clk_mgr)
 {
 	struct dc_bios *bp = clk_mgr->base.ctx->dc_bios;
 	int ss_info_num = bp->funcs->get_ss_entry_number(
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dccg.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dccg.c
index 8eeb3b69b5b9..0faa1abd35ba 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dccg.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dccg.c
@@ -662,8 +662,8 @@ void dccg31_init(struct dccg *dccg)
 	}
 }
 
-void dccg31_otg_add_pixel(struct dccg *dccg,
-		uint32_t otg_inst)
+static void dccg31_otg_add_pixel(struct dccg *dccg,
+				 uint32_t otg_inst)
 {
 	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
 
@@ -671,8 +671,8 @@ void dccg31_otg_add_pixel(struct dccg *dccg,
 			OTG_ADD_PIXEL[otg_inst], 1);
 }
 
-void dccg31_otg_drop_pixel(struct dccg *dccg,
-		uint32_t otg_inst)
+static void dccg31_otg_drop_pixel(struct dccg *dccg,
+				  uint32_t otg_inst)
 {
 	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dccg.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dccg.c
index 08232d05d894..152a76ad7957 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dccg.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dccg.c
@@ -177,7 +177,7 @@ void dccg32_set_dtbclk_dto(
 	}
 }
 
-void dccg32_set_valid_pixel_rate(
+static void dccg32_set_valid_pixel_rate(
 		struct dccg *dccg,
 		int ref_dtbclk_khz,
 		int otg_inst,
-- 
2.35.3

