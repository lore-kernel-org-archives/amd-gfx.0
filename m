Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E380DC00140
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Aug 2022 17:59:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E75712A7EA;
	Fri,  5 Aug 2022 17:59:37 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2079.outbound.protection.outlook.com [40.107.223.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 275BE10FDD1
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Aug 2022 17:59:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lCbbMqrO2wsIIioBbBDd+Nr4m6zzfm6WDHNOMqixGj6yngquXbL4wl08Nynij8KOytGSxSnLirrJPd/fGHGmXTmTsNn9XQeWyZeNRj2nS6t5XitoWgroBZwUN2WUWdtcT2AoivoBDmKsuX89kIoZPzuIqOALnRhv2vLZfj9kXipBZff8Bfp+4OW41W02FloEkds3yFBQO3c0QPvUt1lfTaKi0IbIXpInDglBpor09E/4B2QjqWXpLM39j7wgUjCsFCbmTRyuBBriQzEodXSmLDqGWyuhiTMCMF2g3BCEC4c7pxXH4gJ1a5jm9SOnn0+E2WKqsoU5wPLpMeOdsmNgxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ibvafeU9k70LJXgRvbjsvQZDrmRhG5m8zqlk5NnnKPg=;
 b=JNp7vcKlAx2ybcLzVwQ6vPlpIIquUyaXRV1QsAKBk3MHwugULrzgSqJ3zAQ4sp5klhHt7L5VI7pHlrYTIux8u15C04tTOFnjdUdcxgEiyORy7keKuWRbyH6NhSf8ZfaC/nS2C69LFDxszphcdVztz067w+C2qWlwv0SAUAmHFd/Cz2TYAaLghIdXLFFtJgNsm2YcrWVPTQ0NzDFyPhefS2bseNwvG5MW3YU5tVziedxSuUcglxKvf4Mglp9iXnH0eECzBJ5lq8Cwx+QimPsulJlzzOC2Bc/phbwh1ag1hyjEvPTArFeFZr0CVL04hKyoYxs9j1ybKTD4VdIAGyg9Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ibvafeU9k70LJXgRvbjsvQZDrmRhG5m8zqlk5NnnKPg=;
 b=h4wlpyO2UXEe0iP1noMxUCmx6AkVw8PV5vT3Dy9l8Ig4fcId4eIRTdjYmppFWchDlWYTfjZEQ5hl/7tSdtvoHk/3Rtn+fmTx8lkkfBzTSpTGJG7V6vrAtNba/11fJmd77t1GURBg5WJlhOvAzlQCXYXI4EX10F39FR9GTDfaz4I=
Received: from BN9PR03CA0658.namprd03.prod.outlook.com (2603:10b6:408:13b::33)
 by MN2PR12MB2957.namprd12.prod.outlook.com (2603:10b6:208:100::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Fri, 5 Aug
 2022 17:59:25 +0000
Received: from BN8NAM11FT009.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13b:cafe::93) by BN9PR03CA0658.outlook.office365.com
 (2603:10b6:408:13b::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.16 via Frontend
 Transport; Fri, 5 Aug 2022 17:59:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT009.mail.protection.outlook.com (10.13.176.65) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5504.14 via Frontend Transport; Fri, 5 Aug 2022 17:59:25 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 5 Aug
 2022 12:59:24 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 5 Aug
 2022 10:59:24 -0700
Received: from tom-HP.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Fri, 5 Aug 2022 12:59:18 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 07/32] drm/amd/display: Add a variable to update FCLK latency
Date: Sat, 6 Aug 2022 01:58:01 +0800
Message-ID: <20220805175826.2992171-8-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220805175826.2992171-1-chiahsuan.chung@amd.com>
References: <20220805175826.2992171-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2bac7deb-411d-4786-b43a-08da770c3bd0
X-MS-TrafficTypeDiagnostic: MN2PR12MB2957:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HkdqsxcPBFlCtKZTho3hOVNrF5/0mz+jP+rs7bsjTYrAXsSeC+CFxo1jr0b38WajK50U0bph7z/5JsbHUgDicq9cVbk59o4DV2xrFI7LcBSNCtw3ajUlGyWJjPIx4BrP2+5aRKBDyGD1kX3SCq4+eaXL4ub4LfG4ku7qfzn4tuipUb8f1ObERVyPK3Hr9hyyXsBTOO2Yvgi51PFttEapRWaCKWAw4RXwSXNxrH+IYDssOnykDysptxISjskaQu0XxBl5Sa/MbHs1aY9BGKWCejOETf+MIACm81raqMTErUO1fpFnCdVA/3QiQ+bLuHPFmCxJnyJhmII0PDY1lxXiSKCCs+wEMIX4jjxA9KUGHQzlioiKl7AqDT1M+tcuMW1JOdBWvj1ZUHNlvFzf4HQnuh9TgtPpQY59AMJHZPnwPA5LW+bSUPUPMwLldze981prOupF2FNOXAfLhKUIrxYpcZgtQiyumPA48NTRDcvwqlFOQE9Dn+VKflWl/yOu9uYCLz9WgqI7o0G/1/BuuSDRF5jdmnFlOi6RRN2T8xf/Ym/d8hVftGbBfSoW+16gD6viclbOvkTf5jbC0Q2Ra/jmwh8lo99uiLPk3nb4PAMLZJrwKcS/rcd1SY6Zv/WQ5/SXEyBFEZi+4DgRkVqj/9sP1GamDb9/2tSu+Xxc3GGvaBnnguHyeY9ntrEz/bE2D3q1CAjpcRx1S5lHA/vYvFVAs03N7p6uoxXsUUW+U14cn8KLCMON1PXz+VOerL0/hpmlvP1o5NW5d85VxKMuQOC4kE+q5saUNFO9OQrigtgwsC+2FnZjRkzvuAfl5we/BN67wIHfqbLL1eJi1HzxLyu5zg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(396003)(39860400002)(136003)(346002)(40470700004)(36840700001)(46966006)(6666004)(41300700001)(7696005)(82310400005)(316002)(15650500001)(86362001)(40480700001)(81166007)(356005)(40460700003)(26005)(5660300002)(186003)(83380400001)(70586007)(70206006)(2616005)(336012)(8936002)(8676002)(4326008)(2906002)(36860700001)(54906003)(36756003)(1076003)(6916009)(478600001)(82740400003)(47076005)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2022 17:59:25.2567 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bac7deb-411d-4786-b43a-08da770c3bd0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT009.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB2957
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
Cc: stylon.wang@amd.com, Tom Chung <chiahsuan.chung@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Martin Leung <Martin.Leung@amd.com>, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 Alvin Lee <alvin.lee2@amd.com>, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alvin Lee <alvin.lee2@amd.com>

[Description]
Add a variable to update FCLK latency

Reviewed-by: Martin Leung <Martin.Leung@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Alvin Lee <alvin.lee2@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h                    | 1 +
 drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c   | 7 +++++++
 drivers/gpu/drm/amd/display/dc/dml/dcn321/dcn321_fpu.c | 7 +++++++
 3 files changed, 15 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 8e1e40083ec8..d73e68c2fd51 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -609,6 +609,7 @@ struct dc_bounding_box_overrides {
 	int percent_of_ideal_drambw;
 	int dram_clock_change_latency_ns;
 	int dummy_clock_change_latency_ns;
+	int fclk_clock_change_latency_ns;
 	/* This forces a hard min on the DCFCLK we use
 	 * for DML.  Unlike the debug option for forcing
 	 * DCFCLK, this override affects watermark calculations
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
index 66453546e24f..f8023cfe79f8 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
@@ -2098,6 +2098,13 @@ void dcn32_update_bw_bounding_box_fpu(struct dc *dc, struct clk_bw_params *bw_pa
 				dc->bb_overrides.dram_clock_change_latency_ns / 1000.0;
 		}
 
+		if ((int)(dcn3_2_soc.fclk_change_latency_us * 1000)
+				!= dc->bb_overrides.fclk_clock_change_latency_ns
+				&& dc->bb_overrides.fclk_clock_change_latency_ns) {
+			dcn3_2_soc.fclk_change_latency_us =
+				dc->bb_overrides.fclk_clock_change_latency_ns / 1000;
+		}
+
 		if ((int)(dcn3_2_soc.dummy_pstate_latency_us * 1000)
 				!= dc->bb_overrides.dummy_clock_change_latency_ns
 				&& dc->bb_overrides.dummy_clock_change_latency_ns) {
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn321/dcn321_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn321/dcn321_fpu.c
index 84b4b00f29cb..c87091683b5d 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn321/dcn321_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn321/dcn321_fpu.c
@@ -498,6 +498,13 @@ void dcn321_update_bw_bounding_box_fpu(struct dc *dc, struct clk_bw_params *bw_p
 				dc->bb_overrides.dram_clock_change_latency_ns / 1000.0;
 		}
 
+		if ((int)(dcn3_21_soc.fclk_change_latency_us * 1000)
+				!= dc->bb_overrides.fclk_clock_change_latency_ns
+				&& dc->bb_overrides.fclk_clock_change_latency_ns) {
+			dcn3_21_soc.fclk_change_latency_us =
+				dc->bb_overrides.fclk_clock_change_latency_ns / 1000;
+		}
+
 		if ((int)(dcn3_21_soc.dummy_pstate_latency_us * 1000)
 				!= dc->bb_overrides.dummy_clock_change_latency_ns
 				&& dc->bb_overrides.dummy_clock_change_latency_ns) {
-- 
2.25.1

