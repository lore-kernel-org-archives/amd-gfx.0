Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA2E8C7EE2D
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Mar 2023 15:50:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E36810E6E1;
	Fri,  3 Mar 2023 15:50:59 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2044.outbound.protection.outlook.com [40.107.223.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 74CD910E6E0
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Mar 2023 15:50:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GFf0W3gu2Hm+Li8vR8qhRK72iHMp2SMPe79IOHrxhzdchBzst7P0qg+rKvusKuK6v5a43Ej5IaiUdkPAVgME164IQ9zTKDNwCMTfxmKX1ya+p5uQRf94pugUfqTch2/mNli2+s6LKkt15WHqcytmvTLpn79eDhxgTPUoVk/r/pOl3cIRdUZoTbmootpKOSHPo5OOYn2Wb90Id4+qzXu+ncptHf5x4ue2fxiCdOqMJY1JMwqPLYC5pddFA188RBdB4apn64lALemtiB0HbfiJL9jpiL4IhpeckwlE/Nwa2MND1gxyUKhkjMObz19zs7ghOJU/KIYF/e5RYsSklFw90g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NNragl0e8MKTkIxn9TDK6r6qWIGvcjtvVXi3C1hBfAk=;
 b=eJtsi/sDQsiJ3nk64G45bJhtsywNWNAgMsizmWHelM+Hyvsw61hDM2P0hBwgkHlPaz8noOIQrpC0+JTK15SPWjCTx8Is1HoUoGABBzqqV6kzBeXwa+MUSCUGzYKXnhKX35ZGEV07A9Mv2rFhu/exVXQy2oLip5CMr2YJVfvGI2T2DQlowUKukrS3iryuk5uVRULkazfhgAJu7TgahWr6WuSoKlCDEx5sMlxIdOPy+cYCxoFttEWqvchQ1silHHY+KvjQMqkcvI6ZWagKs0V0/LAnkROPvdu1gJzk8ddLuqPgoCOpQ63OJuY8T/BkAcrkBe8yTn6PQvV0QyJZLFoMXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NNragl0e8MKTkIxn9TDK6r6qWIGvcjtvVXi3C1hBfAk=;
 b=a7gVEehcx1Zi8+NTLch+4HVQVO/aG99wkLA6fGd/HDzHhO04BA0bI7KnKymMS0E4wW9KnQUB0a0TwaS2SGpA2PL9xUJ/bFgCEK7qfJYAx0O+6ttAuuu5pUOyWYwUapRo+XpK4KbQZAGrd/h1C5zspwTeM6qqYytu0F6YJsw2Jpg=
Received: from DM5PR07CA0084.namprd07.prod.outlook.com (2603:10b6:4:ad::49) by
 DM4PR12MB5748.namprd12.prod.outlook.com (2603:10b6:8:5f::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6156.19; Fri, 3 Mar 2023 15:50:55 +0000
Received: from DS1PEPF0000E62F.namprd02.prod.outlook.com
 (2603:10b6:4:ad:cafe::cd) by DM5PR07CA0084.outlook.office365.com
 (2603:10b6:4:ad::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.22 via Frontend
 Transport; Fri, 3 Mar 2023 15:50:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000E62F.mail.protection.outlook.com (10.167.17.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6156.12 via Frontend Transport; Fri, 3 Mar 2023 15:50:55 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 3 Mar
 2023 09:50:40 -0600
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 23/33] drm/amd/display: Update to correct min FCLK when
 construction BB
Date: Fri, 3 Mar 2023 10:40:12 -0500
Message-ID: <20230303154022.2667-24-qingqing.zhuo@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E62F:EE_|DM4PR12MB5748:EE_
X-MS-Office365-Filtering-Correlation-Id: a5b5cb9c-18a3-477e-a148-08db1bff12eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: igmfvWDuh9rHjy/jb6C4m8hnrPZ0prXQjceKe7R4FFo9ZYvgpImAsG78+tO7JdehoQJgx9uyH/F9hYzkTQ2ejdAN65iP8d85l+gQaCP4rHta/6S0618WCcMMmyKX14n/muOw/4BC8aqzXm9vWYoAhZpCF5nCEQcTTEXUgg8krQtF3B4G6wDuhgKwpN9RBX6BRZhJ0Kssak9knepTdnZin9qnt01NeUDUYaYzBXqCL2PKdcqew1pYUUQAvKq6UOPl7Q6j3E9bHFCZq0kSxdPGH5NppGZjr+O+HTAKrNykl0hizssg6fgOLVMdBcJ6HgmQdGTb0nhlxq9x9t8WdL0/l0hjjWUvXEXCxUf+LevPI0IN6AbXjcGfL9sn+3qcFjNtQbokIPmxe6zXjq6IMyQfbMalrA8kwhUwTByOmUYagk5cxQq3qTGbbBRmeIsk1SY2W8VLWLJ9bu8g7Ou19O03tl00SNOG8HHIPFIyzXJnjcG5WUW1TI4xp0RsdfslYHN/3L8wHbgRyENHbjH6wq/yoXkUoKTycjuaAT9gt562qPQfSSXLrIrvEKUKR6B1u8EG7wlMjcgTFSvP3AY+dVwWGzcOvfb87xSUhjGFXmkBiIsY12zB9skG1u23uha0RtrruPJdg55kWdsZlx77OEiTxLQB9NgsOR3sCiMby4Ww02wCgMXzobI/7l0XPHyG5y4LK9pDeZrofXgQVc0JeMXJnX9Mog/hPzSuE2w44af/5iw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(396003)(136003)(39860400002)(346002)(376002)(451199018)(40470700004)(46966006)(36840700001)(83380400001)(426003)(36860700001)(6666004)(47076005)(36756003)(40460700003)(478600001)(8936002)(82740400003)(81166007)(86362001)(82310400005)(356005)(40480700001)(5660300002)(44832011)(186003)(2616005)(16526019)(336012)(1076003)(26005)(8676002)(2906002)(6916009)(54906003)(70586007)(70206006)(316002)(41300700001)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2023 15:50:55.0318 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a5b5cb9c-18a3-477e-a148-08db1bff12eb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E62F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5748
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, Alvin Lee <Alvin.Lee2@amd.com>,
 wayne.lin@amd.com, Jun Lei <Jun.Lei@amd.com>, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alvin Lee <Alvin.Lee2@amd.com>

[Description]
- For min FCLK, choose the min of 300Mhz and PMFW requirement
- Also only apply min DET check in DML for non-UR cases

Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Alvin Lee <Alvin.Lee2@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c        | 5 +++--
 .../gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c  | 6 ++++--
 .../drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c | 6 +++++-
 .../drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.h | 3 ++-
 drivers/gpu/drm/amd/display/dc/dml/dcn321/dcn321_fpu.c      | 5 +++--
 5 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
index e47828e3b6d5..077674be452b 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
@@ -2315,6 +2315,9 @@ static int build_synthetic_soc_states(struct clk_bw_params *bw_params,
 			num_dcfclk_dpms++;
 	}
 
+	if (num_dcfclk_dpms > 0 && bw_params->clk_table.entries[0].fclk_mhz > min_fclk_mhz)
+		min_fclk_mhz = bw_params->clk_table.entries[0].fclk_mhz;
+
 	if (!max_dcfclk_mhz || !max_dispclk_mhz || !max_dtbclk_mhz)
 		return -1;
 
@@ -2423,7 +2426,6 @@ static int build_synthetic_soc_states(struct clk_bw_params *bw_params,
 		for (i = *num_entries - 1; i >= 0 ; i--) {
 			if (table[i].fabricclk_mhz < min_fclk_mhz) {
 				table[i].fabricclk_mhz = min_fclk_mhz;
-				break;
 			}
 		}
 	}
@@ -2432,7 +2434,6 @@ static int build_synthetic_soc_states(struct clk_bw_params *bw_params,
 	for (i = *num_entries - 1; i >= 0 ; i--) {
 		if (table[i].dcfclk_mhz < min_dcfclk_mhz) {
 			table[i].dcfclk_mhz = min_dcfclk_mhz;
-			break;
 		}
 	}
 
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
index f2499811e269..f74730c2abbd 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
@@ -689,7 +689,8 @@ static void DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerforman
 						mode_lib->vba.PixelClock,
 						mode_lib->vba.VRatio,
 						mode_lib->vba.VRatioChroma,
-						mode_lib->vba.UsesMALLForPStateChange);
+						mode_lib->vba.UsesMALLForPStateChange,
+						mode_lib->vba.UseUnboundedRequesting);
 
 	for (k = 0; k < mode_lib->vba.NumberOfActiveSurfaces; ++k) {
 		v->MaxVStartupLines[k] = ((mode_lib->vba.Interlace[k] &&
@@ -3215,7 +3216,8 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 					mode_lib->vba.PixelClock,
 					mode_lib->vba.VRatio,
 					mode_lib->vba.VRatioChroma,
-					mode_lib->vba.UsesMALLForPStateChange);
+					mode_lib->vba.UsesMALLForPStateChange,
+					mode_lib->vba.UseUnboundedRequesting);
 
 			v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.VMDataOnlyReturnBWPerState = dml32_get_return_bw_mbps_vm_only(&mode_lib->vba.soc, i,
 					mode_lib->vba.DCFCLKState[i][j], mode_lib->vba.FabricClockPerState[i],
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c
index d1000aa4c481..61cc4904ade4 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c
@@ -6271,7 +6271,8 @@ bool dml32_CalculateDETSwathFillLatencyHiding(unsigned int NumberOfActiveSurface
 		double	PixelClock[],
 		double	VRatioY[],
 		double	VRatioC[],
-		enum dm_use_mall_for_pstate_change_mode UsesMALLForPStateChange[])
+		enum dm_use_mall_for_pstate_change_mode UsesMALLForPStateChange[],
+		enum unbounded_requesting_policy UseUnboundedRequesting)
 {
 	int k;
 	double SwathSizeAllSurfaces = 0;
@@ -6283,6 +6284,9 @@ bool dml32_CalculateDETSwathFillLatencyHiding(unsigned int NumberOfActiveSurface
 	double SwathSizePerSurfaceC[DC__NUM_DPP__MAX];
 	bool NotEnoughDETSwathFillLatencyHiding = false;
 
+	if (UseUnboundedRequesting == dm_unbounded_requesting)
+		return false;
+
 	/* calculate sum of single swath size for all pipes in bytes */
 	for (k = 0; k < NumberOfActiveSurfaces; k++) {
 		SwathSizePerSurfaceY[k] = SwathHeightY[k] * SwathWidthY[k] * BytePerPixelInDETY[k] * NumOfDPP[k];
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.h b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.h
index 9ba792c633a5..592d174df6c6 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.h
@@ -1163,6 +1163,7 @@ bool dml32_CalculateDETSwathFillLatencyHiding(unsigned int NumberOfActiveSurface
 		double	PixelClock[],
 		double	VRatioY[],
 		double	VRatioC[],
-		enum dm_use_mall_for_pstate_change_mode UsesMALLForPStateChange[]);
+		enum dm_use_mall_for_pstate_change_mode UsesMALLForPStateChange[],
+		enum unbounded_requesting_policy UseUnboundedRequesting);
 
 #endif
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn321/dcn321_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn321/dcn321_fpu.c
index b80cef70fa60..57b9bd896678 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn321/dcn321_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn321/dcn321_fpu.c
@@ -294,6 +294,9 @@ static int build_synthetic_soc_states(struct clk_bw_params *bw_params,
 			num_dcfclk_dpms++;
 	}
 
+	if (num_dcfclk_dpms > 0 && bw_params->clk_table.entries[0].fclk_mhz > min_fclk_mhz)
+		min_fclk_mhz = bw_params->clk_table.entries[0].fclk_mhz;
+
 	if (!max_dcfclk_mhz || !max_dispclk_mhz || !max_dtbclk_mhz)
 		return -1;
 
@@ -402,7 +405,6 @@ static int build_synthetic_soc_states(struct clk_bw_params *bw_params,
 		for (i = *num_entries - 1; i >= 0 ; i--) {
 			if (table[i].fabricclk_mhz < min_fclk_mhz) {
 				table[i].fabricclk_mhz = min_fclk_mhz;
-				break;
 			}
 		}
 	}
@@ -411,7 +413,6 @@ static int build_synthetic_soc_states(struct clk_bw_params *bw_params,
 	for (i = *num_entries - 1; i >= 0 ; i--) {
 		if (table[i].dcfclk_mhz < min_dcfclk_mhz) {
 			table[i].dcfclk_mhz = min_dcfclk_mhz;
-			break;
 		}
 	}
 
-- 
2.34.1

