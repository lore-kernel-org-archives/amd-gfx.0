Return-Path: <SRS0=HRUr=4J=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 510B3C35659
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Feb 2020 16:03:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25F5F2067D
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Feb 2020 16:03:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="HYC0fJ/W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25F5F2067D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D80BC6F4A0;
	Fri, 21 Feb 2020 16:03:58 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20624.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::624])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4DA4D6F4A0
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Feb 2020 16:03:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dEr6SoH+Y8GIg114BtNxEfWUn98bVRA2aIL5d9tx0+jWfsC/q1I+8gM6xFvNb9pBC14Lgn97PfJ6mX88AawvZrJEhrXzA4WsGmzFkRQcfEA9UaeXTvBR8Fg5S4I7WDsvQwDETlMP5Tu/Exu2jzSsUvxC+850a1WOVtjw57xILfnzrwDbLuyQtgsfYa89TWyO2n/ysWBUSYIIVRxF2+xyd4fos8CU0mf94lwnrH0vVvSloYU8irGbkwC4YTuTdePo+60nmjnLWhBNIADP8+hbQOKcIxpus0NXCZD6yH6F0CMFAYXNTJHNsMLi69CeLfU/RgLTdNd4CCdPuLdFXuLrTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7yLfFuZATIJKm80viq8gr2qpr7iKEOBX9hAww6PzmRA=;
 b=NkGR2mOvGPRRCYNQG6ZGqjdzKA9F+z0nlLtuUi9jzhoEo3Bv2r1snu7irAlzdoLLdz2/orbRTkFLbht5GxG0aP/OJJDeBl4a0B7qds8ivN7TQrifprLvqf0HEUIeSrGpUFm4J2Ro5edAS3f5tA1qx0Z2ZOV46QeyjZSrgj15eeJeRPpz5kInVcRlynm4U+UYrYYwdGkDqto6tpsM1sLWO63o1tT46gmErwcKeMpCE5r5QFC94xJSP8QjXGdh75/h/ASBcwDV7YX2DwvWEaEJOc15UY+a2SQeuPw3lChn+BB3vtzGdukzA1G/uqzOTXeSE6kFfB8/2UtmmGnIilFpoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7yLfFuZATIJKm80viq8gr2qpr7iKEOBX9hAww6PzmRA=;
 b=HYC0fJ/W+X34wkVRixZrWuqGTcipJBETDwm7ZllCFP+k1EH+j1/x1ei+lNQJ9A8tx9AA2lUq9aUUnc1vxl/dyxRD32V28KavtdhwVIGRSJEnmjrvIczjDUCMoS7UJ7S4swLSICQxGa3aHGl2U0cteyybq2Wq/LEqL4EU9BeRa+k=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (2603:10b6:907:9::27)
 by MW2PR12MB2572.namprd12.prod.outlook.com (2603:10b6:907:6::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.21; Fri, 21 Feb
 2020 16:03:54 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::b8ff:6893:5820:420f]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::b8ff:6893:5820:420f%6]) with mapi id 15.20.2729.033; Fri, 21 Feb 2020
 16:03:54 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 10/35] drm/amd/display: do not force UCLK DPM to stay at
 highest state during display off in DCN2
Date: Fri, 21 Feb 2020 11:02:59 -0500
Message-Id: <20200221160324.2969975-11-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200221160324.2969975-1-Rodrigo.Siqueira@amd.com>
References: <20200221160324.2969975-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YTOPR0101CA0008.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::21) To MW2PR12MB2524.namprd12.prod.outlook.com
 (2603:10b6:907:9::27)
MIME-Version: 1.0
Received: from atma2.amd.com (165.204.55.250) by
 YTOPR0101CA0008.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.18 via Frontend
 Transport; Fri, 21 Feb 2020 16:03:52 +0000
X-Mailer: git-send-email 2.25.0
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 305ab7a7-c793-4543-d23f-08d7b6e7a59d
X-MS-TrafficTypeDiagnostic: MW2PR12MB2572:|MW2PR12MB2572:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB257206ADE323BE1C98887F8798120@MW2PR12MB2572.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1923;
X-Forefront-PRVS: 0320B28BE1
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(39860400002)(376002)(366004)(346002)(136003)(189003)(199004)(1076003)(5660300002)(36756003)(2906002)(8936002)(86362001)(8676002)(6486002)(81156014)(81166006)(7696005)(52116002)(4326008)(316002)(186003)(26005)(6916009)(16526019)(54906003)(2616005)(66476007)(66556008)(66946007)(956004)(478600001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MW2PR12MB2572;
 H:MW2PR12MB2524.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sRAp+B0FC+LaZg+8b7RFtJgG97+y7bPr1CkM5cXx1vhc81Xeh2E4rIoUY+XvNN3+2OUKBXD6nQx1XjUnI6iUO/A657lRE/Rj0STupvAkF8OJJoj9wdKIYhlisva0ZrBlpcXMRBCRz7Epn0ZpWbxdvXCDSDFMt1qJJUBi+V4UidHYUVCV1V+pFLA23BPIw8oHatmRED68wK5ezkppnoy7kEsI2FM2+rYT0NvWWfTlIk5sI9EcBTM7sTBwAdmje+pxytbdb2rpDJP8zmIQfRHJXSbnnTMRWGk/5SsxgnDOxOilLT0gQubl4unLCKZQKXNh+ImjIDCyAUxx/9gyEFLtFqNHCXMzgkFnfrcp/xu3jVghkpc9nZ0JaYe5KLV/BaNvfCboCc5OBoy/5ue5A9CqbwhvhLbkOedx8ALMxFGsDwZvKfAZiAP4xl6MhomNB+c3
X-MS-Exchange-AntiSpam-MessageData: 9yCaamOTH5y1h78VC36vG6qUpbrPM5a+5Qsd9QvK4R8naKd4A3ib1HeWDFo7qO/cN0l8q63PsxAOfb0pfrLCShm2b6t5xo5z29s0sLIYVhCiNP0h/Ssek4IjriD8nPL+HDU5BXB+OcZb1plAp2+G8A==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 305ab7a7-c793-4543-d23f-08d7b6e7a59d
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2020 16:03:53.0237 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YzbVplDnlRPI/yHokakmFbQ7RfLaFS34KDh0nLNtuBBK0Xp1eFSd/nHbSrCga7hbasyw1v6Wv4Qyq8siMRwJJA==
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
Cc: Sunpeng.Li@amd.com, Harry Wentland <harry.wentland@amd.com>,
 Rodrigo.Siqueira@amd.com, Samson Tam <Samson.Tam@amd.com>,
 Jun Lei <Jun.Lei@amd.com>, Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Samson Tam <Samson.Tam@amd.com>

[Why]
Add optimization to allow pstate change support when all displays
are off in DCN2.

[How]
Add clk_mgr_helper_get_active_plane_cnt() to sum plane_count for all
valid stream_status[].  If plane_count is 0, then there are no active
or virtual streams present. Use plane_count == 0 as extra condition to
enable p_state_change_support in dcn2_update_clocks().

Signed-off-by: Samson Tam <Samson.Tam@amd.com>
Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Acked-by: Harry Wentland <harry.wentland@amd.com>
---
 .../gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c  | 19 +++++++++++++++++++
 .../display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c  |  8 ++++++--
 .../amd/display/dc/inc/hw/clk_mgr_internal.h  |  4 ++++
 3 files changed, 29 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
index a78e5c74c79c..2f43f1618db8 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
@@ -63,6 +63,25 @@ int clk_mgr_helper_get_active_display_cnt(
 	return display_count;
 }
 
+int clk_mgr_helper_get_active_plane_cnt(
+		struct dc *dc,
+		struct dc_state *context)
+{
+	int i, total_plane_count;
+
+	total_plane_count = 0;
+	for (i = 0; i < context->stream_count; i++) {
+		const struct dc_stream_status stream_status = context->stream_status[i];
+
+		/*
+		 * Sum up plane_count for all streams ( active and virtual ).
+		 */
+		total_plane_count += stream_status.plane_count;
+	}
+
+	return total_plane_count;
+}
+
 void clk_mgr_exit_optimized_pwr_state(const struct dc *dc, struct clk_mgr *clk_mgr)
 {
 	struct dc_link *edp_link = get_edp_link(dc);
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c
index 49ce46b543ea..68a1120ff674 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c
@@ -158,6 +158,8 @@ void dcn2_update_clocks(struct clk_mgr *clk_mgr_base,
 	bool dpp_clock_lowered = false;
 	struct dmcu *dmcu = clk_mgr_base->ctx->dc->res_pool->dmcu;
 	bool force_reset = false;
+	bool p_state_change_support;
+	int total_plane_count;
 
 	if (dc->work_arounds.skip_clock_update)
 		return;
@@ -213,9 +215,11 @@ void dcn2_update_clocks(struct clk_mgr *clk_mgr_base,
 			pp_smu->set_hard_min_socclk_by_freq(&pp_smu->pp_smu, clk_mgr_base->clks.socclk_khz / 1000);
 	}
 
-	if (should_update_pstate_support(safe_to_lower, new_clocks->p_state_change_support, clk_mgr_base->clks.p_state_change_support)) {
+	total_plane_count = clk_mgr_helper_get_active_plane_cnt(dc, context);
+	p_state_change_support = new_clocks->p_state_change_support || (total_plane_count == 0);
+	if (should_update_pstate_support(safe_to_lower, p_state_change_support, clk_mgr_base->clks.p_state_change_support)) {
 		clk_mgr_base->clks.prev_p_state_change_support = clk_mgr_base->clks.p_state_change_support;
-		clk_mgr_base->clks.p_state_change_support = new_clocks->p_state_change_support;
+		clk_mgr_base->clks.p_state_change_support = p_state_change_support;
 		if (pp_smu && pp_smu->set_pstate_handshake_support)
 			pp_smu->set_pstate_handshake_support(&pp_smu->pp_smu, clk_mgr_base->clks.p_state_change_support);
 	}
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr_internal.h b/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr_internal.h
index 862952c0286a..9311d0de377f 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr_internal.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr_internal.h
@@ -296,6 +296,10 @@ int clk_mgr_helper_get_active_display_cnt(
 		struct dc *dc,
 		struct dc_state *context);
 
+int clk_mgr_helper_get_active_plane_cnt(
+		struct dc *dc,
+		struct dc_state *context);
+
 
 
 #endif //__DAL_CLK_MGR_INTERNAL_H__
-- 
2.25.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
