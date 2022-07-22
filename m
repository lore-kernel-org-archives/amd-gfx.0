Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AADAC43334
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Jul 2022 20:40:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D856310F187;
	Fri, 22 Jul 2022 20:40:57 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2043.outbound.protection.outlook.com [40.107.100.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 39BF6112EC2
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Jul 2022 20:40:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jbq5gl/gZczEIKhNwfzpW2GROPMmbhfBL/k0KLoZAC7wbHLbgIxXfHWCdMV+OlXpGGtbhXpHlOimJ+lcKVbpBUK54NeCs2xcpZyDpR8yoRtbAr4Kwga/VFUYUJO2zjOtR8sPPQIBdpMqKnJi0uQcNpROCLroLjZGrME9iToxdHZwMOCzAYRaBFwvshQsDqTX9QurRnnf4IObo9a9Z36l9xKruT+aApREZzv0N4ohd1JKb10lLsIsItGAYEbMPGroGzaBBTtyTU2QccsUpnaycpzc1NmkU3Dmu+8Lghdm2buth2zVj7rYByTTq8NZqIinCcGZpUNXIMQh2kjcN1gklA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/DkKw474WNg5gabRvsFj+i4MbIUwcTQ527hm6+i1wU0=;
 b=bJncGdAC23S8j5X8itLMAj1doPvpAJHQ9eWr1/WV7GrH8Qqmu2Xwn+HVavuOwUmSZqJOj6KutQ/FOCx7VbjPchtJloBPqeq1C/EvkjI4W4wqnD5SrotuIWuLh2UBlTHGhwcfPlKdfLHP9eiJWhcs4xbKEQcj46TvWL5Tw9gRTERG2gTEOXwxJtezm30aeQqNIJNLwgOWOoT5wGvI6/hZJV11zyBhU6AAgm6xkvX0WiCUgwN6FgdtD7aPrn7OWsGzhO4+cWvl2QUnqrfdf2yn9ThKSqz6qKyctftGg8dT0zHfPl5bL1Vgpm1ps+9/y/QPUMMdDJ3Scc3lJqtiaxCMVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/DkKw474WNg5gabRvsFj+i4MbIUwcTQ527hm6+i1wU0=;
 b=pxNPuRKUyAtjOSN+m1HXzVnocw8bsUrlOLnWLnMWt7sxSv1OwOnXx0cvBNSDVkTycXifiIsjnpyt2HcM/55IntNmlfqHlrAZVBar0Y6hlaGHXBz7A0eNAkBP2Nzsf8O6UDW1YBg67GKbXJY5xsb3BDeg5s2V5CkLovPj0CRck7Q=
Received: from MW3PR05CA0007.namprd05.prod.outlook.com (2603:10b6:303:2b::12)
 by BL1PR12MB5708.namprd12.prod.outlook.com (2603:10b6:208:387::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Fri, 22 Jul
 2022 20:40:52 +0000
Received: from CO1NAM11FT016.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:2b:cafe::16) by MW3PR05CA0007.outlook.office365.com
 (2603:10b6:303:2b::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.10 via Frontend
 Transport; Fri, 22 Jul 2022 20:40:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT016.mail.protection.outlook.com (10.13.175.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5458.17 via Frontend Transport; Fri, 22 Jul 2022 20:40:51 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 22 Jul
 2022 15:40:18 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 13/31] drm/amd/display: Move mclk calculation function to DML
Date: Fri, 22 Jul 2022 14:31:19 -0600
Message-ID: <20220722203137.4043516-14-alex.hung@amd.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220722203137.4043516-1-alex.hung@amd.com>
References: <20220722203137.4043516-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c331ec03-d668-44fb-e549-08da6c2277af
X-MS-TrafficTypeDiagnostic: BL1PR12MB5708:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F74ccH+3EB6TOGozP4zoevjB1bHRf8VeVPZT/dWIVTFq4KQKLif2+KKyq6KOi7Z/lw4rA3kLGF6JeSMfgWnQRxxNR7bPDmOkqCmhYcXBvmwSPu4MrQo5mcYKAqBYOygPSi+IN2If92tKBpSM2V2mBencXUO+AzYN1IlfBlo84TuxSe1go690NUE0mx126+VU7uc5p234H9ZXWyhWBjkKvVPyg2ODgLMmb5W5URGfJU/RkB41/B9ZJZXKIvdLwJU0jdk+XGpe4azkTk5Ict4+co6lYD1RiMv++jdDSnVyaMWqSQ8xH1TZ1r7IDmsNopnscJgQLFsWURRJsSxhl2vSXw0eYTxE/Z6FfY1TSCBu0FI7wH0Ns5RXPo4CBNNM4NEpa9bYEK5mk/fNtcZfw1HoBk0vP7m29dV2Is0+Lg1R01MPZ1bgsJaI/iCqIPP1YCuJOc0bFx9BwMQDD2Dead85lYGrPlNKlTNcNUSUmGILVU38n1wAE3xWuVxshMEc7jUu2jRwY3eWtoRSvZ6oVHglICgtLPivInpczHnhWJAoLAMTvidSUFU4xpYmNfho0K+YCssfGfQVuxEXT2EGokNlPe1fOTNByIHKKj/T+XNZXU683tdGQr/T6x8gaMxBY7gm22VRqfgiULz6TMKggGnLmI75l6qi0+HVCxUoHYpv4Umcsd208JpXmgM+4NWo9Z6xdzZ1RwfkCD5vNxQI+J1XZKJRPSlXJe+Jk4B/2zef37qlXdSyysShEwj4EaLulmxmZSLxOBMHd/9RhJj5z9irVeD/cTGHImVsWIrVwZflWhWZC6q8YbhbO50qvglLm2j8rFjcx6/KwARRP6Pc1tLYqw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(136003)(376002)(346002)(396003)(46966006)(40470700004)(36840700001)(40460700003)(70206006)(54906003)(478600001)(41300700001)(316002)(6916009)(8676002)(1076003)(7696005)(26005)(2616005)(83380400001)(186003)(47076005)(82740400003)(426003)(356005)(8936002)(36860700001)(336012)(2906002)(44832011)(81166007)(16526019)(40480700001)(5660300002)(4326008)(70586007)(82310400005)(86362001)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2022 20:40:51.7328 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c331ec03-d668-44fb-e549-08da6c2277af
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT016.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5708
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
Cc: stylon.wang@amd.com, mark.broadworth@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, daniel.wheeler@amd.com,
 Aurabindo.Pillai@amd.com, Alex Hung <alex.hung@amd.com>, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

The function responsible for calculating the MCLK switching has FPU
operations. This commit moves it to the dcn30_fpu file.

Reviewed-by: Harry Wentland <Harry.Wentland@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../drm/amd/display/dc/dcn30/dcn30_resource.c | 38 ----------------
 .../drm/amd/display/dc/dml/dcn30/dcn30_fpu.c  | 43 +++++++++++++++++++
 .../drm/amd/display/dc/dml/dcn30/dcn30_fpu.h  |  6 +++
 3 files changed, 49 insertions(+), 38 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
index 7f01463942fb..e5e54097a07d 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
@@ -2031,44 +2031,6 @@ void dcn30_setup_mclk_switch_using_fw_based_vblank_stretch(struct dc *dc, struct
 	context->bw_ctx.bw.dcn.watermarks.a.cstate_pstate.pstate_change_ns = 4U * 1000U * 1000U * 1000U;
 }
 
-/*
- * Finds dummy_latency_index when MCLK switching using firmware based
- * vblank stretch is enabled. This function will iterate through the
- * table of dummy pstate latencies until the lowest value that allows
- * dm_allow_self_refresh_and_mclk_switch to happen is found
- */
-int dcn30_find_dummy_latency_index_for_fw_based_mclk_switch(struct dc *dc, struct dc_state *context,
-		display_e2e_pipe_params_st *pipes, int pipe_cnt, int vlevel)
-{
-	const int max_latency_table_entries = 4;
-	int dummy_latency_index = 0;
-
-	while (dummy_latency_index < max_latency_table_entries) {
-		context->bw_ctx.dml.soc.dram_clock_change_latency_us =
-				dc->clk_mgr->bw_params->dummy_pstate_table[dummy_latency_index].dummy_pstate_latency_us;
-		dcn30_internal_validate_bw(dc, context, pipes, &pipe_cnt, &vlevel, false);
-
-		if (context->bw_ctx.dml.soc.allow_dram_self_refresh_or_dram_clock_change_in_vblank ==
-			dm_allow_self_refresh_and_mclk_switch)
-			break;
-
-		dummy_latency_index++;
-	}
-
-	if (dummy_latency_index == max_latency_table_entries) {
-		ASSERT(dummy_latency_index != max_latency_table_entries);
-		/* If the execution gets here, it means dummy p_states are
-		 * not possible. This should never happen and would mean
-		 * something is severely wrong.
-		 * Here we reset dummy_latency_index to 3, because it is
-		 * better to have underflows than system crashes.
-		 */
-		dummy_latency_index = 3;
-	}
-
-	return dummy_latency_index;
-}
-
 void dcn30_update_soc_for_wm_a(struct dc *dc, struct dc_state *context)
 {
 	DC_FP_START();
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.c
index c00f759fdded..9e32b45b63dc 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.c
@@ -616,6 +616,49 @@ void dcn30_fpu_update_bw_bounding_box(struct dc *dc,
 
 }
 
+/**
+ * Finds dummy_latency_index when MCLK switching using firmware based
+ * vblank stretch is enabled. This function will iterate through the
+ * table of dummy pstate latencies until the lowest value that allows
+ * dm_allow_self_refresh_and_mclk_switch to happen is found
+ */
+int dcn30_find_dummy_latency_index_for_fw_based_mclk_switch(struct dc *dc,
+							    struct dc_state *context,
+							    display_e2e_pipe_params_st *pipes,
+							    int pipe_cnt,
+							    int vlevel)
+{
+	const int max_latency_table_entries = 4;
+	int dummy_latency_index = 0;
+
+	dc_assert_fp_enabled();
+
+	while (dummy_latency_index < max_latency_table_entries) {
+		context->bw_ctx.dml.soc.dram_clock_change_latency_us =
+				dc->clk_mgr->bw_params->dummy_pstate_table[dummy_latency_index].dummy_pstate_latency_us;
+		dcn30_internal_validate_bw(dc, context, pipes, &pipe_cnt, &vlevel, false);
+
+		if (context->bw_ctx.dml.soc.allow_dram_self_refresh_or_dram_clock_change_in_vblank ==
+			dm_allow_self_refresh_and_mclk_switch)
+			break;
+
+		dummy_latency_index++;
+	}
+
+	if (dummy_latency_index == max_latency_table_entries) {
+		ASSERT(dummy_latency_index != max_latency_table_entries);
+		/* If the execution gets here, it means dummy p_states are
+		 * not possible. This should never happen and would mean
+		 * something is severely wrong.
+		 * Here we reset dummy_latency_index to 3, because it is
+		 * better to have underflows than system crashes.
+		 */
+		dummy_latency_index = 3;
+	}
+
+	return dummy_latency_index;
+}
+
 void dcn3_fpu_build_wm_range_table(struct clk_mgr *base)
 {
 	/* defaults */
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.h b/drivers/gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.h
index c2024052a497..3e4221af1c1e 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.h
@@ -63,6 +63,12 @@ void dcn30_fpu_update_bw_bounding_box(struct dc *dc,
 	unsigned int *dcfclk_mhz,
 	unsigned int *dram_speed_mts);
 
+int dcn30_find_dummy_latency_index_for_fw_based_mclk_switch(struct dc *dc,
+							    struct dc_state *context,
+							    display_e2e_pipe_params_st *pipes,
+							    int pipe_cnt,
+							    int vlevel);
+
 void dcn3_fpu_build_wm_range_table(struct clk_mgr *base);
 
 #endif /* __DCN30_FPU_H__*/
-- 
2.37.1

