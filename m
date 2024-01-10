Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92D14C47073
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Jan 2024 21:56:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1FDDB10E691;
	Wed, 10 Jan 2024 21:56:35 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2073.outbound.protection.outlook.com [40.107.244.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 943EF10E682
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Jan 2024 21:56:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pcal+h3F6WLd5QN4OT2COmTrP/4l7AkcmqgOJmvXrzspLSjFoaOltmOIfsSyUt4mEDbshmx8IsfEcsJjmO4ZIpo/+Por+kANZtSsSxHwkh5xtm3/BLrWEdV1MKkZSAuv6MKLWoCNL9jut9Ga6A617pGRzVL4OmD7EG7lP0fizmnaxY92im3QR/Z9oF+s5IlMLESy8vk1dBb+UO6W5PuApA5nldWZ6RH7RC1/WYKtNFIxetWQTRSozkrn1nUPOYis7IV+1bmdAQgzL3fDsLnoUuBr30enM1PyHb1jamwrYQ5qyUchJo8PZH9RlM4CpAKesdK1d4kmg32ZZk06ohLq5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/yKb7aX0ZGRDnDKGJpbR0Wrbwv5EGKXb4T9rflDrkVU=;
 b=IBqpQDCxz94F83eJEaMWEHbQKAxKgcJct1jsE5SKIqZ8cCqsdGg1eHldwSekbXQY+BJAANRhd3xbKAJXAC8xa03Vcaq49Q3Bwhc61HiJFCk1XrdWFmeamXnOUzknxTpEO6w7+FlOAdbMDsMUTHjqsQaMBiIvKzGq++tNrNVNd778kWQ3ur6Tl8zhL97I14ogXLax3lSn13Vys2jXUmXX3uy+Lr0Hhici5lk1s9khfzeXx5PBl3UFLmSsx/YcTbk1jt/uAsOcKEzdoKwEzMop/wpWIFxNolztdACfkMtW2uHz7sR4JBzgwHcKdHR6hMiiypzoNwOKj5yQDSaOX6iqqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/yKb7aX0ZGRDnDKGJpbR0Wrbwv5EGKXb4T9rflDrkVU=;
 b=pHMcoxueRcRYXUR+fhzlh2OPiqcyGClWoZvuFshsypgYEKgRuqvexKS0b6KQ0U0icS5qHeXQjJC+yphW2+3aQwejvByGGJo6/fP+nKHM84Q/zSaTgC1nvyzz9zcovpaz+ThkLtfBYky4gojOYafQcSdMxZyTevqc1BN8DiQTGZQ=
Received: from MW4PR04CA0367.namprd04.prod.outlook.com (2603:10b6:303:81::12)
 by SA1PR12MB8141.namprd12.prod.outlook.com (2603:10b6:806:339::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.17; Wed, 10 Jan
 2024 21:56:30 +0000
Received: from MWH0EPF000989E5.namprd02.prod.outlook.com
 (2603:10b6:303:81:cafe::7) by MW4PR04CA0367.outlook.office365.com
 (2603:10b6:303:81::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.17 via Frontend
 Transport; Wed, 10 Jan 2024 21:56:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E5.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.14 via Frontend Transport; Wed, 10 Jan 2024 21:56:30 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 10 Jan
 2024 15:55:54 -0600
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 10/19] drm/amd/display: Update P010 scaling cap
Date: Wed, 10 Jan 2024 14:52:53 -0700
Message-ID: <20240110215302.2116049-11-alex.hung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240110215302.2116049-1-alex.hung@amd.com>
References: <20240110215302.2116049-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E5:EE_|SA1PR12MB8141:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e00245c-ac0c-4670-284b-08dc122700bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4RYX+q8+2HcNp3p6k8Fe089T0eTFCR9K3iGOtcjX4pTEWHNjzgS8iPqOc/DjOshiR3inaewx+e+dXDv0Ph+AtLa8tBDaF44ySbVmXN6zD7447tHAleanyBDHWkw7InBhPx2VeuxibqlP/Cfwn9o/cL0eV8I7V1BdvABgMOjFz0SGVOH01OTJFWAsxEDv57fB+43uqzfTnTmyqotMJvLj+T+2F+7ebcag34fOp/P4xpFAFgDA3XCBm41s9xtNVcL0JTijwk2zHI4N1yRIP5ABpa63ut6RSZlA7hU58574CSCrw/EnagzsZwHuCDzhzNAv/rfS5QogI9+1oUSpuOBo3umeA1VQOaGj6JwgUmn7wkWcCMbeNW7eMGXBf1xCW5bkhQiRhNaBpxFON64oCjh39HcFYjssoH+Ktiv2FSDQpgVNpo+hcZGlk5RqMOUn1WsmwhO/aZEitEceAgZbi8YTtzEbdW7rAkCydGjwcDvpDo7krmyt1JEJdPpGuEj1qU7rSG6gl9jmX0sxHAX2tyByZHlfri9ye4KV74Hu2X2YimX7PaMBeViQeIxKPc8A8qJOFN1A12DxDH5PNYz1DuBEGtaRr8G5HqlAZrhPf1e7gCpeVPbpGLTFzZI6zflaP4ax3M91wM1VebYsH0EsRHkgolio6WE63lK2E3CUNA4NqDgHogX73/ehNN2WLHTW7iUs8f1VEI1+DzGncyNsKv42dVZKOKz6yZjDtttZHHb17PF396y/8/LW2Zlaj3U8YQX/UsuqMr1gkH1q6grUphbt5w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(39860400002)(346002)(396003)(376002)(230922051799003)(82310400011)(1800799012)(186009)(64100799003)(451199024)(36840700001)(46966006)(40470700004)(478600001)(82740400003)(83380400001)(81166007)(2616005)(44832011)(8936002)(8676002)(4326008)(54906003)(36860700001)(316002)(70586007)(70206006)(86362001)(6916009)(36756003)(16526019)(426003)(1076003)(40480700001)(26005)(40460700003)(47076005)(356005)(7696005)(336012)(2906002)(5660300002)(41300700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2024 21:56:30.3757 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e00245c-ac0c-4670-284b-08dc122700bf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8141
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
Cc: stylon.wang@amd.com, Charlene Liu <charlene.liu@amd.com>,
 chiahsuan.chung@amd.com, Sunpeng.Li@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, Alex Hung <alex.hung@amd.com>, jerry.zuo@amd.com,
 Aurabindo.Pillai@amd.com, hersenxs.wu@amd.com,
 Ovidiu Bunea <ovidiu.bunea@amd.com>, wayne.lin@amd.com, Harry.Wentland@amd.com,
 agustin.gutierrez@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Charlene Liu <charlene.liu@amd.com>

[Why]
Keep the same as previous APU and also insert clock dump

Reviewed-by: Ovidiu Bunea <ovidiu.bunea@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Charlene Liu <charlene.liu@amd.com>
---
 .../display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c  | 25 +++++++++----------
 .../dc/resource/dcn35/dcn35_resource.c        |  2 +-
 2 files changed, 13 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
index 9c660d1facc7..0e5a3184f01c 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
@@ -384,19 +384,6 @@ static void dcn35_enable_pme_wa(struct clk_mgr *clk_mgr_base)
 	dcn35_smu_enable_pme_wa(clk_mgr);
 }
 
-void dcn35_init_clocks(struct clk_mgr *clk_mgr)
-{
-	uint32_t ref_dtbclk = clk_mgr->clks.ref_dtbclk_khz;
-
-	memset(&(clk_mgr->clks), 0, sizeof(struct dc_clocks));
-
-	// Assumption is that boot state always supports pstate
-	clk_mgr->clks.ref_dtbclk_khz = ref_dtbclk;	// restore ref_dtbclk
-	clk_mgr->clks.p_state_change_support = true;
-	clk_mgr->clks.prev_p_state_change_support = true;
-	clk_mgr->clks.pwr_state = DCN_PWR_STATE_UNKNOWN;
-	clk_mgr->clks.zstate_support = DCN_ZSTATE_SUPPORT_UNKNOWN;
-}
 
 bool dcn35_are_clock_states_equal(struct dc_clocks *a,
 		struct dc_clocks *b)
@@ -421,7 +408,19 @@ static void dcn35_dump_clk_registers(struct clk_state_registers_and_bypass *regs
 		struct clk_mgr_dcn35 *clk_mgr)
 {
 }
+void dcn35_init_clocks(struct clk_mgr *clk_mgr)
+{
+	uint32_t ref_dtbclk = clk_mgr->clks.ref_dtbclk_khz;
 
+	memset(&(clk_mgr->clks), 0, sizeof(struct dc_clocks));
+
+	// Assumption is that boot state always supports pstate
+	clk_mgr->clks.ref_dtbclk_khz = ref_dtbclk;	// restore ref_dtbclk
+	clk_mgr->clks.p_state_change_support = true;
+	clk_mgr->clks.prev_p_state_change_support = true;
+	clk_mgr->clks.pwr_state = DCN_PWR_STATE_UNKNOWN;
+	clk_mgr->clks.zstate_support = DCN_ZSTATE_SUPPORT_UNKNOWN;
+}
 static struct clk_bw_params dcn35_bw_params = {
 	.vram_type = Ddr4MemType,
 	.num_channels = 1,
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
index 761ec9891875..7d8e957d6a19 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
@@ -701,7 +701,7 @@ static const struct dc_plane_cap plane_cap = {
 
 	// 6:1 downscaling ratio: 1000/6 = 166.666
 	.max_downscale_factor = {
-			.argb8888 = 167,
+			.argb8888 = 250,
 			.nv12 = 167,
 			.fp16 = 167
 	},
-- 
2.34.1

