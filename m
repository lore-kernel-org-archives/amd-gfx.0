Return-Path: <SRS0=S2wj=5F=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82102C4332B
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Mar 2020 15:11:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 546C02076E
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Mar 2020 15:11:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="yWwEMCKA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 546C02076E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0FF456E196;
	Fri, 20 Mar 2020 15:11:59 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770088.outbound.protection.outlook.com [40.107.77.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 15DE26E196
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Mar 2020 15:11:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qmf11JBjGG1MJB3nluuzdvge4ghUEnirpP1mIQwz85xrAuYXyIQWCsSu/Hzj5b6t+grO1JMEvI76twE6bS6DLwSCBAdQ6kqIHr5QHqfPyZabqdfI7rQv1hYs5emkwvMFg1yPRMph+C4Ctk0ztbQ+ydMlOUfaOkjyl7LsUrNbH/ugk8/0k/rOjtOyg36JBk0jRbRWvw2nWMR37TW+tqebVxNHXyP4JjvbJrYlFKOgT+FJuI0j6EQ/u6MNNKB/M0p1UoFxBvDlnHUTTdiTskbU0uqcxPqdo7P9gf5Ar5j6ep066oMdZRCuYU42bKaxPDBojPiDgwaHxigk/v8A7Pd9aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cdLskfZV9EkSc0DFh8qzibkXU49O2mYH1lb+gY2UiWs=;
 b=XTE5T9UXsvU6mU15ofZLSQ2W1hOyIaAd3s96tQD7v/zndNmZsfT09IBpTbOAk1HCGgm3tdzXJxYUOIXnFF4bG2dBuY8sOVBoLNDEk9ccqt04ZNVEF872/g1+rYJ0oNLVdQGC/dGtVnqGlfuLrjdUuX8wb31CLx/YJ3Ayo7jlg0nWfL/6D7KwI8itYalWf7g4U3S/VpCLMQ7RgofGlQ1PkzucjYeUyclium8azZ23aL4C1AO/qZiHD1iBB7c+v4UcNE0L6VOvhjAUvA2i1Ya0LLerX1WTrCPmz+28ffTMROOfjCJnZAD0Q4V9iXsiKle8+3u5FZ/1x0/pBzIDQ7D7rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cdLskfZV9EkSc0DFh8qzibkXU49O2mYH1lb+gY2UiWs=;
 b=yWwEMCKA2/jXlV7rO2Nzehn0iFJHtV3OSf7tB6mR220x64l/3kg/6fFH6J02DPia17kD9BUJ90neU0nPxQFSZWKoIHT+R9aS4XQb7GCui1TgMr+0PjKGgqbX7nBjAPruuaLPP5fv7m2Y/vQ7sXpC5MqYSg5+bB41vNdchuGRVdE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (2603:10b6:907:9::27)
 by MW2PR12MB2572.namprd12.prod.outlook.com (2603:10b6:907:6::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.18; Fri, 20 Mar
 2020 15:11:56 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5%6]) with mapi id 15.20.2814.021; Fri, 20 Mar 2020
 15:11:56 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 12/12] drm/amd/display: Fix dcn21 num_states
Date: Fri, 20 Mar 2020 11:11:28 -0400
Message-Id: <20200320151128.2039940-13-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200320151128.2039940-1-Rodrigo.Siqueira@amd.com>
References: <20200320151128.2039940-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YTXPR0101CA0055.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::32) To MW2PR12MB2524.namprd12.prod.outlook.com
 (2603:10b6:907:9::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.hitronhub.home (2607:fea8:56a0:11a1::4) by
 YTXPR0101CA0055.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.18 via Frontend
 Transport; Fri, 20 Mar 2020 15:11:55 +0000
X-Mailer: git-send-email 2.25.2
X-Originating-IP: [2607:fea8:56a0:11a1::4]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0b088a04-852a-4628-8da2-08d7cce107b2
X-MS-TrafficTypeDiagnostic: MW2PR12MB2572:|MW2PR12MB2572:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB25720CF9E6E749A0A41A568998F50@MW2PR12MB2572.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-Forefront-PRVS: 03484C0ABF
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(366004)(39860400002)(376002)(396003)(136003)(199004)(81156014)(66556008)(6506007)(54906003)(4326008)(16526019)(2906002)(8936002)(186003)(81166006)(52116002)(2616005)(1076003)(8676002)(86362001)(66476007)(316002)(66946007)(6666004)(6486002)(36756003)(5660300002)(6512007)(6916009)(478600001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MW2PR12MB2572;
 H:MW2PR12MB2524.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gHgQ2VENNaK5oF2M3T41evPGpN7L46/gDbURa2KvIal7OYjy3hFrL0CZc/Crple2e7rqHQ5oNnga/U3N4bZ75rpE3eYtpzKcsuWb+1v4Qzp3wqxfF9xFZHfZC2QrajtpNrSBcOIJA9qh2a3+1aFBWwvEvWYmMqrEnOBkgSRpK4c80UntV2h358Ad2HSw1NPfxKdDS/FqXXdCUosWqXMbw58txF5XleGi912VWfd4te6w1Mks568Tz88PbqJqaTgJ9iAxk1z7dOUqgo/0yrqhXrgn8R310I9dmly+KiCgy+uoqZx32rJdx4FVtM8kEpkOycwwQqL463EHmzJ3oGSJaqNr7TF9VmBdd2+ESvCSHOa9EzpFowe+Loh1kHO+Q0N5SvWFo2Wzp3E5xc//ShUBYz08ca47PQUJEyb3s7/7byjlx4qHfocSwC6tsXzxUkeh
X-MS-Exchange-AntiSpam-MessageData: 2JMuiDqQyi2OZjLdHpLkwpFSJX9/fw64/BjErYY+i7FU2CFCcf4NTdsiYa97AI1VFsjroRk7iQKEUOKRt47lOC/lb5k2ytvvopObX6/REcYcNZDDp2JiTySn1X1PiGY8YMNmZ3QPAvJcxoPUWYeJODhkeQPA1DlB/g/zXyhDh2c=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b088a04-852a-4628-8da2-08d7cce107b2
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2020 15:11:56.6463 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KcpfydCv3OfmWfdzPnHaqN4yaDMQbeoKneWIWgKf67lZ7AhehAyVchu6shYXr71TvJDFChtAtDZx67KPQyx+Dw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2572
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
Cc: Sunpeng.Li@amd.com, Bhawanpreet.Lakha@amd.com,
 Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>, Harry.Wentland@amd.com,
 George Shen <george.shen@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>

[Why]
DML expects num_states to exclude the duplicate state.

[How]
Set num_states to correct value to prevent array off-by-one error.  Also
refactor max clock level code for diags.

Signed-off-by: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>
Signed-off-by: George Shen <george.shen@amd.com>
Reviewed-by: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../drm/amd/display/dc/dcn20/dcn20_resource.c |  2 +-
 .../drm/amd/display/dc/dcn21/dcn21_resource.c | 37 ++++++-------------
 .../gpu/drm/amd/display/dc/dml/dc_features.h  |  2 +-
 .../amd/display/dc/dml/display_mode_structs.h |  7 ++--
 4 files changed, 18 insertions(+), 30 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
index 54e096055c6f..5cdbba0cd873 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
@@ -3343,7 +3343,7 @@ void dcn20_cap_soc_clocks(
 void dcn20_update_bounding_box(struct dc *dc, struct _vcs_dpi_soc_bounding_box_st *bb,
 		struct pp_smu_nv_clock_table *max_clocks, unsigned int *uclk_states, unsigned int num_states)
 {
-	struct _vcs_dpi_voltage_scaling_st calculated_states[MAX_CLOCK_LIMIT_STATES];
+	struct _vcs_dpi_voltage_scaling_st calculated_states[DC__VOLTAGE_STATES];
 	int i;
 	int num_calculated_states = 0;
 	int min_dcfclk = 0;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
index 1849f7f9142c..17cef02f7327 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
@@ -301,7 +301,7 @@ struct _vcs_dpi_soc_bounding_box_st dcn2_1_soc = {
 	.xfc_bus_transport_time_us = 4,
 	.xfc_xbuf_latency_tolerance_us = 4,
 	.use_urgent_burst_bw = 1,
-	.num_states = 9
+	.num_states = 8
 };
 
 #ifndef MAX
@@ -1381,21 +1381,8 @@ static void update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_param
 	unsigned int i, j, k;
 	int closest_clk_lvl;
 
-	// diags does not retrieve proper values from SMU
-	// cap states to 5 and make state 5 the max state
-	if (IS_FPGA_MAXIMUS_DC(dc->ctx->dce_environment) || IS_DIAG_DC(dc->ctx->dce_environment)) {
-		dcn2_1_soc.num_states = 5;
-
-		dcn2_1_soc.clock_limits[5].state = 5;
-		dcn2_1_soc.clock_limits[5].dcfclk_mhz = 810.0;
-		dcn2_1_soc.clock_limits[5].fabricclk_mhz = 1600.0;
-		dcn2_1_soc.clock_limits[5].dispclk_mhz = 1395.0;
-		dcn2_1_soc.clock_limits[5].dppclk_mhz = 1285.0;
-		dcn2_1_soc.clock_limits[5].phyclk_mhz = 1325.0;
-		dcn2_1_soc.clock_limits[5].socclk_mhz = 953.0;
-		dcn2_1_soc.clock_limits[5].dscclk_mhz = 489.0;
-		dcn2_1_soc.clock_limits[5].dram_speed_mts = 4266.0;
-	} else {
+	// Default clock levels are used for diags, which may lead to overclocking.
+	if (!IS_FPGA_MAXIMUS_DC(dc->ctx->dce_environment) && !IS_DIAG_DC(dc->ctx->dce_environment)) {
 		dcn2_1_ip.max_num_otg = pool->base.res_cap->num_timing_generator;
 		dcn2_1_ip.max_num_dpp = pool->base.pipe_count;
 		dcn2_1_soc.num_chans = bw_params->num_channels;
@@ -1408,16 +1395,16 @@ static void update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_param
 		dcn2_1_soc.clock_limits[0].dram_speed_mts = clk_table->entries[0].memclk_mhz * 2;
 
 		/*
-		 * Other levels: find cloest DCN clocks that fit the given clock limit using dcfclk
-		 * as indicater
+		 * Other levels: find closest DCN clocks that fit the given clock limit using dcfclk
+		 * as indicator
 		 */
 
 		closest_clk_lvl = -1;
 		/* index currently being filled */
 		k = 1;
 		for (i = 1; i < clk_table->num_entries; i++) {
-			/* loop backwards, skip duplicate state, +1 because SMU has precision issue */
-			for (j = dcn2_1_soc.num_states - 2; j >= k; j--) {
+			/* loop backwards, skip duplicate state*/
+			for (j = dcn2_1_soc.num_states - 1; j >= k; j--) {
 				if ((unsigned int) dcn2_1_soc.clock_limits[j].dcfclk_mhz <= clk_table->entries[i].dcfclk_mhz) {
 					closest_clk_lvl = j;
 					break;
@@ -1442,13 +1429,13 @@ static void update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_param
 				k++;
 			}
 		}
-
-		/* duplicate last level */
-		dcn2_1_soc.clock_limits[k] = dcn2_1_soc.clock_limits[k - 1];
-		dcn2_1_soc.clock_limits[k].state = k;
-		dcn2_1_soc.num_states = k + 1;
+		dcn2_1_soc.num_states = k;
 	}
 
+	/* duplicate last level */
+	dcn2_1_soc.clock_limits[dcn2_1_soc.num_states] = dcn2_1_soc.clock_limits[dcn2_1_soc.num_states - 1];
+	dcn2_1_soc.clock_limits[dcn2_1_soc.num_states].state = dcn2_1_soc.num_states;
+
 	dml_init_instance(&dc->dml, &dcn2_1_soc, &dcn2_1_ip, DML_PROJECT_DCN21);
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dc_features.h b/drivers/gpu/drm/amd/display/dc/dml/dc_features.h
index ea4cde952f4f..2a1983324629 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dc_features.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/dc_features.h
@@ -29,7 +29,7 @@
 #define DC__PRESENT 1
 #define DC__PRESENT__1 1
 #define DC__NUM_DPP 4
-#define DC__VOLTAGE_STATES 7
+#define DC__VOLTAGE_STATES 9
 #define DC__NUM_DPP__4 1
 #define DC__NUM_DPP__0_PRESENT 1
 #define DC__NUM_DPP__1_PRESENT 1
diff --git a/drivers/gpu/drm/amd/display/dc/dml/display_mode_structs.h b/drivers/gpu/drm/amd/display/dc/dml/display_mode_structs.h
index dfd3be452766..687010c17324 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/display_mode_structs.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/display_mode_structs.h
@@ -22,11 +22,12 @@
  * Authors: AMD
  *
  */
+
+#include "dc_features.h"
+
 #ifndef __DISPLAY_MODE_STRUCTS_H__
 #define __DISPLAY_MODE_STRUCTS_H__
 
-#define MAX_CLOCK_LIMIT_STATES 9
-
 typedef struct _vcs_dpi_voltage_scaling_st voltage_scaling_st;
 typedef struct _vcs_dpi_soc_bounding_box_st soc_bounding_box_st;
 typedef struct _vcs_dpi_ip_params_st ip_params_st;
@@ -68,7 +69,7 @@ struct _vcs_dpi_voltage_scaling_st {
 };
 
 struct _vcs_dpi_soc_bounding_box_st {
-	struct _vcs_dpi_voltage_scaling_st clock_limits[MAX_CLOCK_LIMIT_STATES];
+	struct _vcs_dpi_voltage_scaling_st clock_limits[DC__VOLTAGE_STATES];
 	unsigned int num_states;
 	double sr_exit_time_us;
 	double sr_enter_plus_exit_time_us;
-- 
2.25.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
