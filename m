Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97346C27C54
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Jun 2024 21:59:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0383210EB0A;
	Thu,  6 Jun 2024 21:59:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CQpoVnVd";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2044.outbound.protection.outlook.com [40.107.93.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 90DC710EB08
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Jun 2024 21:59:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BOXfSyZ2w5rw6BwOWR8Oz3PS6L1Df9BImwsV0MWxN+4EokuvgL/XUhx2+5J9VehXXGrfau0X0rWKyTACIiVn61cyjJuGud8pLVQGzpW2Z8kphGZHNtHli9Oym//cAk1Jf5lY9GmY6d8NAdJojy2TRRAgTFiS+KX79h9dxOLDPFvDRzwAfSUi/v1t5rYKr/z2B7rjHW0D/KS/bJljoWXsxya6S6IuvIQDjyJia1tvpeCaAeg8k7b8OpyknDzie46Hu5eWSPUm9TJoAy/M7c01gm9Au9H3v0fRZ+lD6Z/ZeTxs/eoKtvpN3l0xmifvkM4jwJDwSv/9O7i78TUUp0VOPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0cHcVWsDAK20athZSraluD/oCu33vMn7qA3L4ifWN3w=;
 b=XgLLcTZAE6KD+NH1i3/Whaj5R8wC2e3uM5Hq+Xia4JxX1lRIAv/jsfjeSZR0mQdwYhTj2azZukDsSv0c7vvEvRWGA3OUdK50NO1NZUKXxC3dAsGF6WmgYicq3avGblf+HUob+BDrjTr1xsITYs/ghygOysVpdKeqY759vaYusj1RemHm0SncF9T1daQjNk1139A3BPMKx7yQCK9GG9GETinwHTP+Ui8expexSNosJI+9+AToxgFm8o4H01hoMeGbDAvS32Yg84jt6J6BO5ySxJarOHvCsOIeDUvmB129xKIF2d4dXPhjfYhNDta8PuXiZWfyMo/DauRT+QZBlCdG0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0cHcVWsDAK20athZSraluD/oCu33vMn7qA3L4ifWN3w=;
 b=CQpoVnVdJyRzHqJaX9I4o42Bo0W7+Cw/rti1L42xFqA9O2tswxkg9huSvfKFtcZKxIDdYGRRfmpvOMcD05prQ3BsC9xwJ6vDAM/bv8XDMwg6Rg5nGOyghynf36K/uKysLodn8YUE41a8IQDeKoeTOPKuRgQNdWS8B1zTq/0Q1fs=
Received: from BL1PR13CA0260.namprd13.prod.outlook.com (2603:10b6:208:2ba::25)
 by DM6PR12MB4452.namprd12.prod.outlook.com (2603:10b6:5:2a4::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.34; Thu, 6 Jun
 2024 21:59:03 +0000
Received: from BL6PEPF0001AB53.namprd02.prod.outlook.com
 (2603:10b6:208:2ba:cafe::96) by BL1PR13CA0260.outlook.office365.com
 (2603:10b6:208:2ba::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.12 via Frontend
 Transport; Thu, 6 Jun 2024 21:59:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB53.mail.protection.outlook.com (10.167.241.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Thu, 6 Jun 2024 21:59:03 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 6 Jun
 2024 16:59:01 -0500
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, Alvin Lee <alvin.lee2@amd.com>, Dillon Varone
 <dillon.varone@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>
Subject: [PATCH 55/67] drm/amd/display: populate hardware_release hook for
 dcn401
Date: Thu, 6 Jun 2024 17:56:20 -0400
Message-ID: <20240606215632.4061204-56-zaeem.mohamed@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240606215632.4061204-1-zaeem.mohamed@amd.com>
References: <20240606215632.4061204-1-zaeem.mohamed@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB53:EE_|DM6PR12MB4452:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fe872c9-2301-4e28-41c1-08dc8673e106
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400017|1800799015|376005|36860700004; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?qWH/8nw0DEi/WGg1xY1xs7GjXTz/3Vqy0HOd+oTvU+EKECv6kOqa+eQEwosH?=
 =?us-ascii?Q?EpPyAcQ6YD1TwILyYFG2qzN1jftktWVtOw0NclffXkwntEmxSSYjn1m0pR2H?=
 =?us-ascii?Q?6bbeRmUptfL1FkkSeFdJ/rM3EUAZp42yKgctpt92QYtPC/uhrXzTjf1mntVa?=
 =?us-ascii?Q?9vM0ZHz5ZzbRKe2ALkUiqZRdehwnmXd4ncO7kh+P+aErfMt9AknftjhNudpw?=
 =?us-ascii?Q?5/m053Eft99/BeZLnEdz0aQDVe6qd2mBfRXnsEOXAQmaQu5sf4qoPBtnGz3b?=
 =?us-ascii?Q?t4xRPEbh3fzDonUdAtkgQILjQtXW6j9/OhSM3zy9w9dH6INqgHdxiGnwJjWA?=
 =?us-ascii?Q?u1cIUu5iFqhGWk9sXkYfy+CePFrRF1eU/v3BPbyovvkKgNPUm6ICTHu60wtb?=
 =?us-ascii?Q?xQ6szcSUZAAxh/NZYx16eM6ACLjfI4HHIbPaY4lVnXXRf4qoTuSI8gz84uMq?=
 =?us-ascii?Q?r6fK8zVRRdMPhPRMzHFcU237LAGohhr1u8AJr9W+xUpge/YF7tvRaE0edC9a?=
 =?us-ascii?Q?nV4nTtzZOOXMOk4BiOPxI8xr720ys2VELPNyr6INuBgg01mKRhjRh3q+GuN/?=
 =?us-ascii?Q?dJ4r0m7qrzox45yqtx3+r1VYPh/4I3hGsA9NJyFJjrdIls9o6kAbaH1uxNDm?=
 =?us-ascii?Q?nbyOO3x0DA5rLZNIWhcOum/lnxlAx2zh5yIRPVcqNLEIRuqbWF98T0QG1jLl?=
 =?us-ascii?Q?vF70Clos1omywV3CHrNFJ+cped8kxtdjQIedp2idFG9zzcifMNagvUM9nF5W?=
 =?us-ascii?Q?J8MJZvUZNEsI/5xASfbWwv8g0G3fRQDcYSrwXbtFdbe2d7FaYqQk6ShHTgc/?=
 =?us-ascii?Q?J3bAVlDoEZUtQ+QCexGXizwIZnExvYOizTc+sAzKAejLo0SstwJn+giBLkbt?=
 =?us-ascii?Q?8iQVtgBW8aI1t3t7h0Gw1iY4e/NdYZzg0Q1xQ1qC2EXSNxPrKD6s4bnX0t/+?=
 =?us-ascii?Q?ENRSRf9O/4qcA4cBx49mbX5FA2svthuBher6OXjgz0QtG6Iq9qx+X3gOL+hr?=
 =?us-ascii?Q?RHQZ44GKBUJfbNZvxbSpBtMACuy/NhlhsVxKQDo0dUP+LupoG01s9Wx+T8BZ?=
 =?us-ascii?Q?M351ioQVyoeXo96135y6tiFfzpUm31ZzF3ijC/opp1EhFkAL/tKr+raznSHi?=
 =?us-ascii?Q?/W9vvez9imYrpGC4h1gxpdujGWX6deE4xDqPk2JmjCZuPE6/Q/4xMuo8N95o?=
 =?us-ascii?Q?z1WOJ4AqgwAkxU75hGQQ8fhFBEqzYGHFi0+L9Hc3HNyGp97JwvBOM1iTfRCY?=
 =?us-ascii?Q?y8SH1KgDwlO1qR2145yFLBbUpRTzDUyYoLZFOPYMDdVGZmDf85WP0pYa/h87?=
 =?us-ascii?Q?sWYVCzY5nLTEatpax5KVvdE4VNaD/1AlPJlQ/1oKIhdl3QmRw1gNKa1FZG5P?=
 =?us-ascii?Q?kEm3fqf72cVhFfE46awSrngFXkuJidL5XHn4nqD7sydELubZDg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400017)(1800799015)(376005)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 21:59:03.3631 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fe872c9-2301-4e28-41c1-08dc8673e106
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB53.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4452
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alvin Lee <alvin.lee2@amd.com>

[Description]
hardare_release() is called when driver is removed. Add the missing hook for DCN401

Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Acked-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
Signed-off-by: Alvin Lee <alvin.lee2@amd.com>
---
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c | 20 +++++++++++++++++++
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.h |  2 +-
 .../amd/display/dc/hwss/dcn401/dcn401_init.c  |  2 +-
 3 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
index 116411aa0a2b..4d0c01e866be 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
@@ -1674,3 +1674,23 @@ void dcn401_unblank_stream(struct pipe_ctx *pipe_ctx,
 	if (link->local_sink && link->local_sink->sink_signal == SIGNAL_TYPE_EDP)
 		hws->funcs.edp_backlight_control(link, true);
 }
+
+void dcn401_hardware_release(struct dc *dc)
+{
+	dc_dmub_srv_fams2_update_config(dc, dc->current_state, false);
+
+	/* If pstate unsupported, or still supported
+	 * by firmware, force it supported by dcn
+	 */
+	if (dc->current_state) {
+		if ((!dc->clk_mgr->clks.p_state_change_support ||
+				dc->current_state->bw_ctx.bw.dcn.fams2_stream_count > 0) &&
+				dc->res_pool->hubbub->funcs->force_pstate_change_control)
+			dc->res_pool->hubbub->funcs->force_pstate_change_control(
+					dc->res_pool->hubbub, true, true);
+
+		dc->current_state->bw_ctx.bw.dcn.clk.p_state_change_support = true;
+		dc->clk_mgr->funcs->update_clocks(dc->clk_mgr, dc->current_state, true);
+	}
+}
+
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.h b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.h
index f91159a6e6d4..bada43d4b2eb 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.h
@@ -75,7 +75,7 @@ void dcn401_fams2_global_control_lock(struct dc *dc,
 void dcn401_fams2_update_config(struct dc *dc, struct dc_state *context, bool enable);
 void dcn401_fams2_global_control_lock_fast(union block_sequence_params *params);
 void dcn401_unblank_stream(struct pipe_ctx *pipe_ctx, struct dc_link_settings *link_settings);
-
+void dcn401_hardware_release(struct dc *dc);
 void dcn401_update_odm(struct dc *dc, struct dc_state *context,
 		struct pipe_ctx *otg_master);
 #endif /* __DC_HWSS_DCN401_H__ */
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_init.c
index 8358ba74405f..dabad7feff03 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_init.c
@@ -79,7 +79,7 @@ static const struct hw_sequencer_funcs dcn401_funcs = {
 	.does_plane_fit_in_mall = NULL,
 	.set_backlight_level = dcn21_set_backlight_level,
 	.set_abm_immediate_disable = dcn21_set_abm_immediate_disable,
-	.hardware_release = dcn30_hardware_release,
+	.hardware_release = dcn401_hardware_release,
 	.set_pipe = dcn21_set_pipe,
 	.enable_lvds_link_output = dce110_enable_lvds_link_output,
 	.enable_tmds_link_output = dce110_enable_tmds_link_output,
-- 
2.34.1

