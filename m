Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E873C433EF
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Apr 2022 17:27:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE82A10F109;
	Fri,  8 Apr 2022 17:27:43 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2080.outbound.protection.outlook.com [40.107.220.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 45B5210F108
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Apr 2022 17:27:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EMgA9t5RbrTmCGXrsBrCK2g6hucIXCCOFmHuJ0EZg8+3R0lUD751Mv2fMUXQD84pYuFNhCt2hQlOSKIf9lb+tC1671u4pKofrToBXGeM+WI7cjMTkGmoL/YgeuiXuqrH1u6bNguS5AMmWXqJuyrcbzxrRmf220Ghr1TSPAnEIqPLlavDOMxDJ2on6OEIvDAxCStLHDaZrW4TnGkP6mc7P2d5BUvk0M1QJXIUDcj5JKY6tJ4IE4acS3IdrWDRHuGe+SGOJB17xiN/gR7drLh1eawpLkhe9b1Xs3o9J4hNm4AAJX1zdopGrHC5SweZCWvI9pAT5K4WvLbDc3OSfZQqYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vRwzsxMg+zkMJG0N1MRxNtuEymIFox+msrS/Tj+jpn0=;
 b=Eh/ZIGziw8n8GDIrO9NOHmYooBzTpby8oocVl/N4BaAITDSOdsGwLVEZuXdt6bbTQLISG4WBQXxADTDWWX3vwfrwNGFhcpnUSpaSpUrib/Bc9YnxR6rLLtArusSJ5kClY5+IIrjOo7vJXB6TaTx1X6vVCtO1PXaX3wfUnroZ8hupN/nOjwybEEUG47uJK9bjwde59cFuoXDOGQv66mn89pN6QxepmO0BhawheOogSOMbwn0BVpZjplWoFT3xE62XA2sQmX8x0/TS2Uz4OcYCKb1Th6insKxaIFSTbqmmbpVRnSkDDcVT1zaFHxeTnogSRcBWiZzFBdfBDh1ULr39eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vRwzsxMg+zkMJG0N1MRxNtuEymIFox+msrS/Tj+jpn0=;
 b=mCsX1Jn3HtVVRrrUV0Rjyi+AFqIRk+hWzKt0Fh3YUPhETS153A9XNJYFIW427KcSiCh5CzqfhWwCxHZ9g5GX3/hPjE/6g/iMENkngEYd2JcKjzryM42iBqObCsyZc3Rz84MtYjZtdsgwtS1Tp4nrW/9VPhQpLf9sluT4zg1ktaY=
Received: from DS7PR05CA0021.namprd05.prod.outlook.com (2603:10b6:5:3b9::26)
 by DM6PR12MB3722.namprd12.prod.outlook.com (2603:10b6:5:1c3::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.26; Fri, 8 Apr
 2022 17:27:39 +0000
Received: from DM6NAM11FT029.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b9:cafe::3) by DS7PR05CA0021.outlook.office365.com
 (2603:10b6:5:3b9::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.18 via Frontend
 Transport; Fri, 8 Apr 2022 17:27:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT029.mail.protection.outlook.com (10.13.173.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5144.20 via Frontend Transport; Fri, 8 Apr 2022 17:27:38 +0000
Received: from lnxpromo.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 8 Apr
 2022 12:27:37 -0500
From: Pavle Kotarac <Pavle.Kotarac@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 08/20] drm/amd/display: remove dtbclk_ss compensation for
 dcn316
Date: Fri, 8 Apr 2022 13:18:59 -0400
Message-ID: <20220408171911.601615-9-Pavle.Kotarac@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220408171911.601615-1-Pavle.Kotarac@amd.com>
References: <20220408171911.601615-1-Pavle.Kotarac@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c03f145f-7efd-4440-8312-08da19851463
X-MS-TrafficTypeDiagnostic: DM6PR12MB3722:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB3722E674C97999B0850B5409FCE99@DM6PR12MB3722.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QoEiQA0laAJ8O3Pt1Mg+s0T3UZ2BT5z4miLprFYU4x7xpYt7pIFwVekqKL2dByReP2LAONfm2p0A6g+ibmfu9lhbZr07gHZ/iZ3xaqUJxwT7j3fTFBW0uz+yII5Yqi5vv+cf33vuU3+JqbRkN2PZa3NM82QVvTzEKiPbQA+yUU+gzuQiUlk214AL3Kwm3YaPk7uZv7jL4qOayiO/ARfjmsuPTYZkGQuCwCsuxbNSFsIqDq2cZLQlFjGIxz+aBHMmg1CEKO3YHtJA1HVpzybYEZNhgNOBMtySbVINlz9FXB9NEyDQfae92/IIcoguuULcAQjVTC3qnDzk36Uh5ZFWXINPrKuUadHpKl6aR7S0UrgzJjVjYZpUpEYcTEtlhyasNM61e9o61m7mb0qkwXS/3VnZn5vegSDTYuC0dciHSUh30qd6TQJf5xeE9Ae/Rc5NsdHQnOK8L4R5dLu95wWg0j25t4Dxf8wom35fhqlPW4orDJM/Ewi5EoUls+nSHD+x84h8p4FK6LGLz06AoLGJTMQZ7AYP98H9xq8UbogpMuSDzuz29eFPYBV6e3zUOvxV8j7eUfqgI8OajMVvctDazSKRRmGK3b/gKtWILyo/PpRLxcQ9ZbwgGWKHegsqzKgGUFOZXJwm7gxPlfSbBKAcltsDoIB86myIxfPCqGAzs2pUGX+wUxzbpUSX1uIV02jOHdA15IEiVdjZpzseZS7cmg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(2906002)(6916009)(336012)(36756003)(36860700001)(54906003)(86362001)(2616005)(7696005)(1076003)(316002)(47076005)(40460700003)(26005)(70206006)(186003)(70586007)(4326008)(82310400005)(5660300002)(6666004)(16526019)(8676002)(356005)(508600001)(83380400001)(8936002)(81166007)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2022 17:27:38.8663 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c03f145f-7efd-4440-8312-08da19851463
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT029.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3722
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
Cc: stylon.wang@amd.com, Charlene Liu <Charlene.Liu@amd.com>,
 Chris Park <Chris.Park@amd.com>, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 Pavle Kotarac <Pavle.Kotarac@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Charlene Liu <Charlene.Liu@amd.com>

[why]
dcn316's dtbclk is from non_ss clock source.
no compensation required here.

Reviewed-by: Chris Park <Chris.Park@amd.com>
Acked-by: Pavle Kotarac <Pavle.Kotarac@amd.com>
Signed-off-by: Charlene Liu <Charlene.Liu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c   | 2 +-
 .../gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_clk_mgr.c    | 4 ++--
 drivers/gpu/drm/amd/display/dc/dc.h                           | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c
index dfba6138f538..26feefbb8990 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c
@@ -374,7 +374,7 @@ void dce_clock_read_ss_info(struct clk_mgr_internal *clk_mgr_dce)
 				clk_mgr_dce->dprefclk_ss_percentage =
 						info.spread_spectrum_percentage;
 			}
-			if (clk_mgr_dce->base.ctx->dc->debug.ignore_dpref_ss)
+			if (clk_mgr_dce->base.ctx->dc->config.ignore_dpref_ss)
 				clk_mgr_dce->dprefclk_ss_percentage = 0;
 		}
 	}
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_clk_mgr.c
index 702d00ce7da4..3121dd2d2a91 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_clk_mgr.c
@@ -686,8 +686,8 @@ void dcn316_clk_mgr_construct(
 	clk_mgr->base.base.dprefclk_khz = dcn316_smu_get_dpref_clk(&clk_mgr->base);
  	clk_mgr->base.dccg->ref_dtbclk_khz = clk_mgr->base.base.dprefclk_khz;
 	dce_clock_read_ss_info(&clk_mgr->base);
-	clk_mgr->base.dccg->ref_dtbclk_khz =
-	dce_adjust_dp_ref_freq_for_ss(&clk_mgr->base, clk_mgr->base.base.dprefclk_khz);
+	/*clk_mgr->base.dccg->ref_dtbclk_khz =
+	dce_adjust_dp_ref_freq_for_ss(&clk_mgr->base, clk_mgr->base.base.dprefclk_khz);*/
 
 	clk_mgr->base.base.bw_params = &dcn316_bw_params;
 
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 70cc21ec643a..e723553f9c5a 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -340,6 +340,7 @@ struct dc_config {
 	bool is_asymmetric_memory;
 	bool is_single_rank_dimm;
 	bool use_pipe_ctx_sync_logic;
+	bool ignore_dpref_ss;
 };
 
 enum visual_confirm {
@@ -729,7 +730,6 @@ struct dc_debug_options {
 	bool apply_vendor_specific_lttpr_wa;
 	bool extended_blank_optimization;
 	union aux_wake_wa_options aux_wake_wa;
-	bool ignore_dpref_ss;
 	uint8_t psr_power_use_phy_fsm;
 };
 
-- 
2.32.0

