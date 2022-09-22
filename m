Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF4E7ECAAD8
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Sep 2022 00:20:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A7A3C10EA09;
	Thu, 22 Sep 2022 00:19:57 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2086.outbound.protection.outlook.com [40.107.96.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 963D410EA02
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Sep 2022 00:19:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UMsyioAQFIp96VbhvhwNoJ446BaT1db1abQ8PwozQbcavXM8SOUudszJGA76YvqF1awBujgrIPQ3/g2mgIXw3K2Fg1MtlvjsbKfvX3wONBYQ3kqHs/FUn8Yeltfz0t4alaxVa6A5Bf9reeQfoAPD/eXJookqF47O36zNolj8Iz0q4EEv+QxciGk2EZBCf++mBvRqKJFXoPWnXdds2mZNfiRnFYqJ1armjN82fzV2ZFG9sR1TNpkTM18wWSAmlUUPCE7aVMH231XZgPjugLJ3Bim9Mp/Vs0mozvAuLygRho+Ug8E5ETe/CUQY+HhL3LrhjJWXV/a5KttIsbX2BhXKTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mf1jP3HOjtbr5QgFUTJXU9Fdf0Ihc1n0e/Kl4MgdfTA=;
 b=ghTLQIFl0GcbAxPJc6PMXBUnfK/LY0MgGUGvANuB9TgfRXdQCpWQJWz0CRKDl2rLpQc8j5oL21xjaKS4LgSAp/K9khn64BIzmj4ZuuA3YqG0DMnRrLvrY9FXeknTWmJ9N/U/7UqayMt50mwQ0rBKJVsnn5r7DMgSK6jtUw9ZZ1c421lUNUeUJAZdXIVGBmpi05fY2Cfc4Lq+jQeI9uARRH+wW7fD45w1MbbqeEaFL3zb645SGe5MWj2Uh2Y4pVFkH/e/redWzGyErVnTuWJqMsd7sgRNg2op2wn3m+VrEEACsSc4fzziL4oWv7SQUkzH2UMs4CZz1kqhElSkcKf/jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mf1jP3HOjtbr5QgFUTJXU9Fdf0Ihc1n0e/Kl4MgdfTA=;
 b=TENW/117qGd2fV+we6zLd6tpSg/gKRxOxrGINhIfbz+TyLvFNioqbi/0iFGa9oAHDGZy+uRrMSO/8nCjZHWVKbJ/T5klNOaaKJs8l8KN6Vh2t9rzR90IVn6foy/ZfLQmvMKZxwDQJ5CeXZoVYxKKFwrdhEiPpulfaPMXzpdkrKk=
Received: from BN9PR03CA0651.namprd03.prod.outlook.com (2603:10b6:408:13b::26)
 by SA0PR12MB4414.namprd12.prod.outlook.com (2603:10b6:806:9a::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.16; Thu, 22 Sep
 2022 00:19:15 +0000
Received: from BN8NAM11FT029.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13b:cafe::c0) by BN9PR03CA0651.outlook.office365.com
 (2603:10b6:408:13b::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.17 via Frontend
 Transport; Thu, 22 Sep 2022 00:19:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT029.mail.protection.outlook.com (10.13.177.68) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5654.14 via Frontend Transport; Thu, 22 Sep 2022 00:19:14 +0000
Received: from jasdeep-System-Product-Name.phub.net.cable.rogers.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Wed, 21 Sep 2022 19:19:11 -0500
From: Jasdeep Dhillon <jdhillon@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 17/31] drm/amd/display: Disable MALL when TMZ surface
Date: Wed, 21 Sep 2022 20:18:07 -0400
Message-ID: <20220922001821.320255-18-jdhillon@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220922001821.320255-1-jdhillon@amd.com>
References: <20220922001821.320255-1-jdhillon@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT029:EE_|SA0PR12MB4414:EE_
X-MS-Office365-Filtering-Correlation-Id: f410b85f-7474-40de-f93d-08da9c3014de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: frBN6zRW9EEhrcXr+RYjyPrgoqjSgbK+hsBtPwN5A+VJ6Uwlg+LXpds5EesOfTG60oSB88WJCLiNNvCQFpUAoiCdNVw+CHIBVQcqUg6O2mqPaKrP8PdbK3taimvu7eUNQutP8XrA6SXq+fANpTyCpk3Z+xsAONfFXnRF+AUBi9ivImqAYCN4+0sC/mm4D0i13X2Mk1uqry7npNlBPZWZJXyBeIYH+iPJgTS+O7nhwTMd/247Ls6ih9qgs8csYf95PpOgYOphYITdNw2Vdvy6l+rQYGc4CfJTKp1WklWtgnH5CQ4o1BTeRmue6/J+GHEdt5OkBDn8Ycy87wLeu9OI3vKsj6h5coMN2vWCplxjyQT4vN/NXGxxOZhr4ZS7TqE0TkTgUURxvEKPS9RVI1ylMAuPBYzVraogOakD4ayHxVbvYLXd6pwgeA9hLNhblin6U+4VB55g6gqndGdqZGTFHW7LyrUwRQH29q3a42bw5gGxE99SCVLNnjv5ngkifgnKxcYJFWYoUN7GCayLIqSrpEytYntZSeLBEv7tEpJYKqfcesTtuJZ4LPnFEnXDbQeZ+tvmqC0ygepF/gsSF96AFka5XsuOgStpF5rI0+U3k7kHC+42jZ8P4Choi305yafLAeSoOQZNGtUnUnohEkl+jMtDHxz8pY1COh3S/BCOF8BcaYfefxSDkpNKejasDfi8bd3vq5pUIjh3EeZHJBiKV+hc5TBywiDaX+6tl+yDFLB/99GM/9zJ8WhZu9qzY1uTi4abaVlTm6zbhpmdudmsny/Sgppeve1hJ/VoIVQSlNR94oHEl8Tl8E+pBqiR5ZkyPBp3215LASfmGUvYryTUbg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(39860400002)(136003)(376002)(396003)(451199015)(40470700004)(36840700001)(46966006)(36756003)(54906003)(6916009)(316002)(81166007)(356005)(426003)(36860700001)(82740400003)(16526019)(2616005)(83380400001)(336012)(47076005)(70206006)(478600001)(8676002)(70586007)(5660300002)(4326008)(26005)(6666004)(41300700001)(40460700003)(2906002)(8936002)(186003)(1076003)(82310400005)(40480700001)(36900700001)(44824005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2022 00:19:14.8085 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f410b85f-7474-40de-f93d-08da9c3014de
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT029.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4414
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
 qingqing.zhuo@amd.com, Jasdeep Dhillon <jdhillon@amd.com>,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, Alvin Lee <Alvin.Lee2@amd.com>, wayne.lin@amd.com,
 Jun Lei <Jun.Lei@amd.com>, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alvin Lee <Alvin.Lee2@amd.com>

[Description]
- Don't use MALL buffering of any kind when the
  surface is TMZ
- Workaround for a HW bug

Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Jasdeep Dhillon <jdhillon@amd.com>
Signed-off-by: Alvin Lee <Alvin.Lee2@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c       |  8 ++++++--
 drivers/gpu/drm/amd/display/dc/dc.h            |  1 +
 .../gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c | 18 ++++++++++--------
 .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.c   |  3 ++-
 4 files changed, 19 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index b5ad0bf4135a..b82d572c55ae 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -2331,9 +2331,13 @@ static enum surface_update_type det_surface_update(const struct dc *dc,
 	type = get_scaling_info_update_type(u);
 	elevate_update_type(&overall_type, type);
 
-	if (u->flip_addr)
+	if (u->flip_addr) {
 		update_flags->bits.addr_update = 1;
-
+		if (u->flip_addr->address.tmz_surface != u->surface->address.tmz_surface) {
+			update_flags->bits.tmz_changed = 1;
+			elevate_update_type(&overall_type, UPDATE_TYPE_FULL);
+		}
+	}
 	if (u->in_transfer_func)
 		update_flags->bits.in_transfer_func_change = 1;
 
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index ccb5395a8a90..7db7929a7e81 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -1122,6 +1122,7 @@ union surface_update_flags {
 		uint32_t clock_change:1;
 		uint32_t stereo_format_change:1;
 		uint32_t lut_3d:1;
+		uint32_t tmz_changed:1;
 		uint32_t full_update:1;
 	} bits;
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
index 133bc4085c78..6497246692cf 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
@@ -355,7 +355,7 @@ bool dcn32_apply_idle_power_optimizations(struct dc *dc, bool enable)
 	union dmub_rb_cmd cmd;
 	uint8_t ways, i;
 	int j;
-	bool stereo_in_use = false;
+	bool mall_ss_unsupported = false;
 	struct dc_plane_state *plane = NULL;
 
 	if (!dc->ctx->dmub_srv)
@@ -386,22 +386,23 @@ bool dcn32_apply_idle_power_optimizations(struct dc *dc, bool enable)
 			 */
 			ways = dcn32_calculate_cab_allocation(dc, dc->current_state);
 
-			/* MALL not supported with Stereo3D. If any plane is using stereo,
-			 * don't try to enter MALL.
+			/* MALL not supported with Stereo3D or TMZ surface. If any plane is using stereo,
+			 * or TMZ surface, don't try to enter MALL.
 			 */
 			for (i = 0; i < dc->current_state->stream_count; i++) {
 				for (j = 0; j < dc->current_state->stream_status[i].plane_count; j++) {
 					plane = dc->current_state->stream_status[i].plane_states[j];
 
-					if (plane->address.type == PLN_ADDR_TYPE_GRPH_STEREO) {
-						stereo_in_use = true;
+					if (plane->address.type == PLN_ADDR_TYPE_GRPH_STEREO ||
+							plane->address.tmz_surface) {
+						mall_ss_unsupported = true;
 						break;
 					}
 				}
-				if (stereo_in_use)
+				if (mall_ss_unsupported)
 					break;
 			}
-			if (ways <= dc->caps.cache_num_ways && !stereo_in_use) {
+			if (ways <= dc->caps.cache_num_ways && !mall_ss_unsupported) {
 				memset(&cmd, 0, sizeof(cmd));
 				cmd.cab.header.type = DMUB_CMD__CAB_FOR_SS;
 				cmd.cab.header.sub_type = DMUB_CMD__CAB_DCN_SS_FIT_IN_CAB;
@@ -759,7 +760,8 @@ void dcn32_update_mall_sel(struct dc *dc, struct dc_state *context)
 				hubp->funcs->hubp_update_mall_sel(hubp,
 					num_ways <= dc->caps.cache_num_ways &&
 					pipe->stream->link->psr_settings.psr_version == DC_PSR_VERSION_UNSUPPORTED &&
-					pipe->plane_state->address.type !=  PLN_ADDR_TYPE_GRPH_STEREO ? 2 : 0,
+					pipe->plane_state->address.type !=  PLN_ADDR_TYPE_GRPH_STEREO &&
+					!pipe->plane_state->address.tmz_surface ? 2 : 0,
 							cache_cursor);
 			}
 		}
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
index 3202b52224b1..cb97afbee097 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
@@ -674,9 +674,10 @@ static bool dcn32_assign_subvp_pipe(struct dc *dc,
 		 * - Not able to switch in vactive naturally (switching in active means the
 		 *   DET provides enough buffer to hide the P-State switch latency -- trying
 		 *   to combine this with SubVP can cause issues with the scheduling).
+		 * - Not TMZ surface
 		 */
 		if (pipe->plane_state && !pipe->top_pipe &&
-				pipe->stream->mall_stream_config.type == SUBVP_NONE && refresh_rate < 120 &&
+				pipe->stream->mall_stream_config.type == SUBVP_NONE && refresh_rate < 120 && !pipe->plane_state->address.tmz_surface &&
 				vba->ActiveDRAMClockChangeLatencyMarginPerState[vba->VoltageLevel][vba->maxMpcComb][vba->pipe_plane[pipe_idx]] <= 0) {
 			while (pipe) {
 				num_pipes++;
-- 
2.25.1

