Return-Path: <SRS0=8txe=6Q=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F1B0C47259
	for <amd-gfx@archiver.kernel.org>; Sat,  2 May 2020 21:34:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 416F62072E
	for <amd-gfx@archiver.kernel.org>; Sat,  2 May 2020 21:34:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="QXJBawCn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 416F62072E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 021C06E127;
	Sat,  2 May 2020 21:34:56 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770053.outbound.protection.outlook.com [40.107.77.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CDAFB6E127
 for <amd-gfx@lists.freedesktop.org>; Sat,  2 May 2020 21:34:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hjbS/sqyH7jlIl90qdAcbPQbYZmsQck2vJA14OXqwb0j52pFc/QDZrHVdP+PJBgR9LYoClBMDnR0B+xGj+mbjjM620qfp3qb+zMIxFT8nSbhZ8dDcILbM0A6y80zmXLDkHXSCXPmb3Yp+ptxs/eLPRlItu5JCPppYbVABuB3X6t3MBiAEjYXFLDUkGx76lvSkfV/LQeySAU3PvhIgpuhJgpecRRFBJiSPnEYLmQPAlOg4OcuT0EM0YTNicKges+D8OQ9dSBn+c8lc5UezjN+43hvUZw8LmOaRbdgvhf31ZhucegKbNiKRoA7hHvBfe6VAviIM5BRY5EH8SPZDjOYqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EegaoSWLMAH+yCc/9Wn+79fi30No4e5CDK1/t/FGRnA=;
 b=jhvhk+bdF/svAW3f53dxN1IgDKhIQNWDEfdIw449LkaBv/XmVjEXX/7NCUheG9NwJnS5RRDjHTdNtqoKKuwVOw6sBM/gcRkYBcC6VLPHz+jP3VnWNlmbCaZWahTYJFKdL6xnBX0N3x4VfYtzzh+kgq8yO+ThqYAlbTczkoUgiD79Vr4rnpbOzYEwelCOs78hrTmEhFdOkwhadCi7n+d89pyTAbA8ZSZjObR8GKSYTzrfPw2TzQV2uIX9yLYt6IBAEyl12hlcKif3YT3w7F9HhxH8kljP/utA4aFJJIwIhXmAEoBi2GqqX4s5wU7jguH9KVh8F/xAC/xJOUYRbhCMqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EegaoSWLMAH+yCc/9Wn+79fi30No4e5CDK1/t/FGRnA=;
 b=QXJBawCn2oTpPZiBrR0+4VWVd2ypHPG69rPuv8gUystMNXyQbOZMG0pHroArAjPnLc4TQJK6fc5M5NQXK7fjrr7NxkrUb1G1kSttUgA1Va/+xnhNnNTrSH7eHznf0KRIc1XySIFw9a9Bt5kOHrKnv1veW/7DbVRtASKSLViD92k=
Received: from MWHPR22CA0062.namprd22.prod.outlook.com (2603:10b6:300:12a::24)
 by DM6PR12MB2811.namprd12.prod.outlook.com (2603:10b6:5:45::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.19; Sat, 2 May
 2020 21:34:53 +0000
Received: from CO1NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:12a:cafe::7d) by MWHPR22CA0062.outlook.office365.com
 (2603:10b6:300:12a::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.20 via Frontend
 Transport; Sat, 2 May 2020 21:34:52 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT048.mail.protection.outlook.com (10.13.175.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2958.19 via Frontend Transport; Sat, 2 May 2020 21:34:52 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Sat, 2 May 2020
 16:34:51 -0500
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Sat, 2 May 2020
 16:34:50 -0500
Received: from sudo.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Sat, 2 May 2020 16:34:49 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 05/16] drm/amd/display: Allow PState switch in VBLANK one
 display VACTIVE
Date: Sat, 2 May 2020 17:34:32 -0400
Message-ID: <20200502213443.39232-7-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200502213443.39232-1-aurabindo.pillai@amd.com>
References: <20200502213443.39232-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(136003)(39860400002)(396003)(376002)(46966005)(2616005)(54906003)(70586007)(44832011)(1076003)(47076004)(5660300002)(6666004)(426003)(70206006)(8676002)(82740400003)(336012)(6916009)(81166007)(356005)(186003)(36756003)(478600001)(2906002)(4326008)(82310400002)(26005)(8936002)(86362001)(7696005)(316002);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9f60a7f2-289a-4764-3e5d-08d7eee0a610
X-MS-TrafficTypeDiagnostic: DM6PR12MB2811:|DM6PR12MB2811:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB2811FFB35A2DE704C06B65158BA80@DM6PR12MB2811.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:514;
X-Forefront-PRVS: 039178EF4A
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EBM1yZgXrDcWHSvoLoofxzC6PojBKRnFnT50JCh8tiR3elAjoh8vU+qm7PLb3SNpKs4u8QO7T/uPW7tt/dbBXVB18wBvzdYW7fZqM7bgTrOHIUwAGygd5BRsB0p2Gru+VReTEa6Oj8oTE7j48QpCpWBkffqzTufKB5ghtrzg1n/jpmoQmuo9THY5ONJaBNl6wHRAx38a3yojlrneYgUKx3IWFijf9lElivCjza7bzDtTQioL1YHkDV92WdNHRL0hNV7E5w1w/+cProvoNkhRkTEp6FbAEzwhqkYyo1hborqTrKy6Mck+gv1cLyAsMOCPYzQXny4R9Rkm9lRjVqYFboPwUvTHUczw2/XyIU1ilY6bPMEveWlQx+7mtPUCciv3IkQWzDuyrWIkKr0jWUqdX1eQWtrMQxhP9vEyRr4SuryWkE2jTA6I0sk7PAvi/XU7rQ9EzW49s55n9TlwM5stpFRsmIKv/X8m8l/hFTuSb7ugooWlIOp7ydmsNfaA59kvIm9uoSnT4lRQ23uYQE/shA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2020 21:34:52.0682 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f60a7f2-289a-4764-3e5d-08d7eee0a610
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2811
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
Cc: Sunpeng.Li@amd.com, Harry.Wentland@amd.com, Rodrigo.Siqueira@amd.com,
 Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>,
 Alvin Lee <alvin.lee2@amd.com>, Jun
 Lei <Jun.Lei@amd.com>, Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alvin Lee <alvin.lee2@amd.com>

[Why]
For certain display configurations we want to allow PSTATE
switch when one display can switch in VACTIVE and the
other display can switch in VBLANK

[How]
Add extra condition to dcn2 pstate support check

Signed-off-by: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>
Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h           |  1 +
 .../drm/amd/display/dc/dcn20/dcn20_resource.c |  2 ++
 .../dc/dml/dcn20/display_mode_vba_20v2.c      | 29 ++++++++++++++++++-
 .../amd/display/dc/dml/display_mode_structs.h |  1 +
 .../drm/amd/display/dc/dml/display_mode_vba.c |  1 +
 .../drm/amd/display/dc/dml/display_mode_vba.h |  1 +
 6 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 17075f99bc54..636cf5c3a709 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -476,6 +476,7 @@ struct dc_debug_options {
 	bool enable_dmcub_surface_flip;
 	bool usbc_combo_phy_reset_wa;
 	bool disable_dsc;
+	bool enable_dram_clock_change_one_display_vactive;
 };
 
 struct dc_debug_data {
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
index 1a525c423911..96b5a451cf26 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
@@ -3102,6 +3102,8 @@ bool dcn20_validate_bandwidth(struct dc *dc, struct dc_state *context,
 	p_state_latency_us = context->bw_ctx.dml.soc.dram_clock_change_latency_us;
 	context->bw_ctx.dml.soc.disable_dram_clock_change_vactive_support =
 		dc->debug.disable_dram_clock_change_vactive_support;
+	context->bw_ctx.dml.soc.allow_dram_clock_one_display_vactive =
+		dc->debug.enable_dram_clock_change_one_display_vactive;
 
 	if (fast_validate) {
 		voltage_supported = dcn20_validate_bandwidth_internal(dc, context, true);
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20v2.c b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20v2.c
index 922ab7169e52..80170f9721ce 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20v2.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20v2.c
@@ -2599,18 +2599,40 @@ static void dml20v2_DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndP
 		}
 	}
 
+	{
+	float SecondMinActiveDRAMClockChangeMarginOneDisplayInVBLank = 999999;
+	int PlaneWithMinActiveDRAMClockChangeMargin = -1;
+
 	mode_lib->vba.MinActiveDRAMClockChangeMargin = 999999;
 	for (k = 0; k < mode_lib->vba.NumberOfActivePlanes; ++k) {
 		if (mode_lib->vba.ActiveDRAMClockChangeLatencyMargin[k]
 				< mode_lib->vba.MinActiveDRAMClockChangeMargin) {
 			mode_lib->vba.MinActiveDRAMClockChangeMargin =
 					mode_lib->vba.ActiveDRAMClockChangeLatencyMargin[k];
+			if (mode_lib->vba.BlendingAndTiming[k] == k) {
+				PlaneWithMinActiveDRAMClockChangeMargin = k;
+			} else {
+				for (j = 0; j < mode_lib->vba.NumberOfActivePlanes; ++j) {
+					if (mode_lib->vba.BlendingAndTiming[k] == j) {
+						PlaneWithMinActiveDRAMClockChangeMargin = j;
+					}
+				}
+			}
 		}
 	}
 
 	mode_lib->vba.MinActiveDRAMClockChangeLatencySupported =
 			mode_lib->vba.MinActiveDRAMClockChangeMargin
 					+ mode_lib->vba.DRAMClockChangeLatency;
+	for (k = 0; k < mode_lib->vba.NumberOfActivePlanes; ++k) {
+		if (!((k == PlaneWithMinActiveDRAMClockChangeMargin) && (mode_lib->vba.BlendingAndTiming[k] == k))
+				&& !(mode_lib->vba.BlendingAndTiming[k] == PlaneWithMinActiveDRAMClockChangeMargin)
+				&& mode_lib->vba.ActiveDRAMClockChangeLatencyMargin[k]
+						< SecondMinActiveDRAMClockChangeMarginOneDisplayInVBLank) {
+			SecondMinActiveDRAMClockChangeMarginOneDisplayInVBLank =
+					mode_lib->vba.ActiveDRAMClockChangeLatencyMargin[k];
+		}
+	}
 
 	if (mode_lib->vba.DRAMClockChangeSupportsVActive &&
 			mode_lib->vba.MinActiveDRAMClockChangeMargin > 60) {
@@ -2629,7 +2651,11 @@ static void dml20v2_DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndP
 			mode_lib->vba.MinActiveDRAMClockChangeMargin > 0) {
 		mode_lib->vba.DRAMClockChangeSupport[0][0] = dm_dram_clock_change_vactive;
 	} else {
-		if (mode_lib->vba.SynchronizedVBlank || mode_lib->vba.NumberOfActivePlanes == 1) {
+		if ((mode_lib->vba.SynchronizedVBlank
+				|| mode_lib->vba.NumberOfActivePlanes == 1
+				|| (SecondMinActiveDRAMClockChangeMarginOneDisplayInVBLank > 0 &&
+						mode_lib->vba.AllowDramClockChangeOneDisplayVactive))
+					&& mode_lib->vba.PrefetchMode[mode_lib->vba.VoltageLevel][mode_lib->vba.maxMpcComb] == 0) {
 			mode_lib->vba.DRAMClockChangeSupport[0][0] = dm_dram_clock_change_vblank;
 			for (k = 0; k < mode_lib->vba.NumberOfActivePlanes; ++k) {
 				if (!mode_lib->vba.AllowDRAMClockChangeDuringVBlank[k]) {
@@ -2641,6 +2667,7 @@ static void dml20v2_DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndP
 			mode_lib->vba.DRAMClockChangeSupport[0][0] = dm_dram_clock_change_unsupported;
 		}
 	}
+	}
 	for (k = 0; k <= mode_lib->vba.soc.num_states; k++)
 		for (j = 0; j < 2; j++)
 			mode_lib->vba.DRAMClockChangeSupport[k][j] = mode_lib->vba.DRAMClockChangeSupport[0][0];
diff --git a/drivers/gpu/drm/amd/display/dc/dml/display_mode_structs.h b/drivers/gpu/drm/amd/display/dc/dml/display_mode_structs.h
index b2ecb174a93f..439ffd04be34 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/display_mode_structs.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/display_mode_structs.h
@@ -118,6 +118,7 @@ struct _vcs_dpi_soc_bounding_box_st {
 	double urgent_latency_adjustment_fabric_clock_component_us;
 	double urgent_latency_adjustment_fabric_clock_reference_mhz;
 	bool disable_dram_clock_change_vactive_support;
+	bool allow_dram_clock_one_display_vactive;
 };
 
 struct _vcs_dpi_ip_params_st {
diff --git a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c
index 6e4e8a452e66..b19988f54721 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c
@@ -224,6 +224,7 @@ static void fetch_socbb_params(struct display_mode_lib *mode_lib)
 	mode_lib->vba.DummyPStateCheck = soc->dram_clock_change_latency_us == soc->dummy_pstate_latency_us;
 	mode_lib->vba.DRAMClockChangeSupportsVActive = !soc->disable_dram_clock_change_vactive_support ||
 			mode_lib->vba.DummyPStateCheck;
+	mode_lib->vba.AllowDramClockChangeOneDisplayVactive = soc->allow_dram_clock_one_display_vactive;
 
 	mode_lib->vba.Downspreading = soc->downspread_percent;
 	mode_lib->vba.DRAMChannelWidth = soc->dram_channel_width_bytes;   // new!
diff --git a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h
index a1884ffe63ae..6a7b20927a6b 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h
@@ -899,6 +899,7 @@ struct vba_vars_st {
 	double BPP;
 	enum odm_combine_policy ODMCombinePolicy;
 	bool UseMinimumRequiredDCFCLK;
+	bool AllowDramClockChangeOneDisplayVactive;
 };
 
 bool CalculateMinAndMaxPrefetchMode(
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
