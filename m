Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F51DECAAD5
	for <amd-gfx@archiver.kernel.org>; Sat, 27 Aug 2022 02:27:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 373D910EB48;
	Sat, 27 Aug 2022 02:27:11 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2070.outbound.protection.outlook.com [40.107.243.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D81A010EB3F
 for <amd-gfx@lists.freedesktop.org>; Sat, 27 Aug 2022 02:26:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gKavkNEIICRic2Ik/FijWR7blDvlnggQXwj4zqkMoUISV7ehspTs2Gdrh363EKdX9/Sq5N32NTYSIBk6ErZbaUuZnca2U9F5GFSzAek5QNUf597tP7NsqCwzNqXrX6+Dp9Rh/0x1tHpHsbx2Wbsf5So21n3CI71/zNX+il+ag9ryreD3OPeoLL+c/xDsp4Rblg1PqMl20bW5FFnMJX9LsSmSKl46f8MwvNhxAJVgmgoLaU6ogt5LU4pewE0kdP8/3pyQR11MEnxqxklY9hbBYEOKZDMDUgACrMguSwbFY4uW1DGRPwOJv9zsqISHkWx5jF1dlAijQP1RCGW53abwuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UmzlAaPebDib6Os5vr9N5H7i9F+wcwiDynD8q5zoCA8=;
 b=EcZANxIpIbiAaj6H4z4MQ6YhdW8mSuAFtGXttF8L3r4bI9kY6hMrP86qNnmdgO3k7LJquhZdv9NLexZA9Ll/z+ucrV4wvEb9fIWZRj2HyYfxHCKuUnTVtGJzzDu1ga+eDGYt/Pn+1aT9uP3E9xO5P1Q+78S/U3yLKiVrUoC79MqPZHu5jP/tMCifq9Kf8ZM8F1uJrWARaV2qIlsIqeEQpk/9LqCP4LGOYvgkqXzqlf2Vd1BIQxh98X3Is4xAbGPLFQPbvOv8WFVrc+gfeb18DdhPEG8Q2BRt82gdesxQ8IDuUPAdWnUXC9MFej++4a2qiJEWzpynL2pnZJgD8a2V6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UmzlAaPebDib6Os5vr9N5H7i9F+wcwiDynD8q5zoCA8=;
 b=TxBnOjt2WPLCMagXFjt4dj4FTp1wzsIf8aZuu8NYen5CdIDxy4v67JrHZCPR+7TjjAfGAvxN02Njz2qJ8dglUc25ZpSidFsYTaARRxoi8UZSS06pkSMNdBCmZ7VNEIlIfkC7EYMWFEWJQiHEIZekXH+FMvdrEVObt+T+DRuJWSI=
Received: from BN9PR03CA0463.namprd03.prod.outlook.com (2603:10b6:408:139::18)
 by DM5PR1201MB0010.namprd12.prod.outlook.com (2603:10b6:3:e3::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Sat, 27 Aug
 2022 02:26:49 +0000
Received: from BN8NAM11FT073.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:139:cafe::f3) by BN9PR03CA0463.outlook.office365.com
 (2603:10b6:408:139::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15 via Frontend
 Transport; Sat, 27 Aug 2022 02:26:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT073.mail.protection.outlook.com (10.13.177.231) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5566.15 via Frontend Transport; Sat, 27 Aug 2022 02:26:49 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 26 Aug
 2022 21:26:45 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 26 Aug
 2022 21:26:45 -0500
Received: from brianchang-HP-EliteDesk-805-G6-Small-Form-Factor-PC.amd.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server id 15.1.2375.28 via Frontend Transport; Fri, 26 Aug 2022 21:26:41
 -0500
From: brichang <Brian.Chang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 02/33] drm/amd/display: Don't choose SubVP display if
 ActiveMargin > 0
Date: Sat, 27 Aug 2022 06:26:51 +0800
Message-ID: <20220826222722.1428063-3-Brian.Chang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220826222722.1428063-1-Brian.Chang@amd.com>
References: <20220826222722.1428063-1-Brian.Chang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9203d73a-9477-42f9-0977-08da87d3987b
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0010:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wUzJmaTLTSaBid9COmKSNLENS6F+0JghqwuEmtL7qS4wCfc48R9Bk7BvmAp4PX08bjgLzSSVDMVSqjOl3eGHwQuzGbU1VPHOmDwmOkjPEHMjrVeoc3OZ2YBo7XWsycOc11tKT4oM8RKcel4cDRaK+n2qGmS+S0QGyYYsX+mYteYwzEIIwabdlnPh3XXYHhulRxDENMEch4UG1qs90HezVn0HIR+dvrewZA7UOsoTmYaofN1M/O+ViGuoHjeNQzGe7jD9s8l5OvC59Xysau4OL5ldN8545qI/zhzUvb+nkTfvqFrdi9SMZX+8fnRIkbSu/2zgjbZ0VDYM3Ge4cKpikh7H0bAF5I+9/PAzYmEsQNWWOMxBcKMOd64wQByXY6rvV8mK8UbiJ4zOIIvE7LFbV7x4Pj76K21cAOdf1S5x7ZLoCYSTAIXRMN2gw1r0OrOZUdmy5UaXHjTCUAJFe4C4B5nrr0ptmnrPvBga6Owvz4oTalh2ZkT+ryBiJuPPj2TNZtecw3QM1AZxKHX5urNp+yEWn+Z5nkxL+lcz1d4Bwy8i6DcLCRrekkt0QUg+gQ8QLt9AXnU2AjAsYadxUZnuL3w3GXowi0gZI5bIeeVzKjhg26fJObHgieEmpXWARu3KDKGPUgDVY8poJRpITCmegMCGJQ6Xu0IFfLzSwmzZzAAvxqPbK5sN3oEzqft3FgnA3JcHeLIL6xEnPrEWw0lwfgtMKHynsWMGvOxDgRLB2KwTbqlLVoxleFadL/eX/pZOWRlhtajXcjJvR4J5O3HOVzMGIZ8KubPX820j+IpChRwdHfzRRYm1BgzpUo9e8HlkGt1si6VM1moNg3tDe4mGQEvrBlSXP40tJqcwQGFLVrs=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(136003)(346002)(396003)(376002)(39860400002)(40470700004)(46966006)(36840700001)(40480700001)(7696005)(86362001)(82310400005)(41300700001)(83380400001)(478600001)(82740400003)(40460700003)(81166007)(1076003)(356005)(2616005)(26005)(186003)(336012)(426003)(36756003)(70206006)(47076005)(36860700001)(8676002)(6666004)(54906003)(70586007)(316002)(5660300002)(4326008)(6916009)(8936002)(2906002)(43062005)(36900700001)(44824005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2022 02:26:49.1770 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9203d73a-9477-42f9-0977-08da87d3987b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT073.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0010
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
Cc: stylon.wang@amd.com, Brian Chang <Brian.Chang@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 Alvin Lee <Alvin.Lee2@amd.com>, wayne.lin@amd.com, Jun Lei <Jun.Lei@amd.com>,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alvin Lee <Alvin.Lee2@amd.com>

[Description]
There can be SubVP scheduling issues if a SubVP
display is chosen has ActiveDramClockChangeLatency > 0.
Block this case for now, and enable Vactive case
(later) to handle this.

Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Brian Chang <Brian.Chang@amd.com>
Signed-off-by: Alvin Lee <Alvin.Lee2@amd.com>
---
 .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.c  | 21 ++++++++++++++++---
 .../dc/dml/dcn32/display_mode_vba_32.c        |  2 +-
 .../drm/amd/display/dc/dml/display_mode_vba.h |  1 +
 3 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
index edefb3fc1c3c..e72213a20e75 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
@@ -560,6 +560,7 @@ static bool dcn32_assign_subvp_pipe(struct dc *dc,
 	bool valid_assignment_found = false;
 	unsigned int free_pipes = dcn32_get_num_free_pipes(dc, context);
 	bool current_assignment_freesync = false;
+	struct vba_vars_st *vba = &context->bw_ctx.dml.vba;
 
 	for (i = 0, pipe_idx = 0; i < dc->res_pool->pipe_count; i++) {
 		struct pipe_ctx *pipe = &context->res_ctx.pipe_ctx[i];
@@ -573,8 +574,15 @@ static bool dcn32_assign_subvp_pipe(struct dc *dc,
 		refresh_rate = (pipe->stream->timing.pix_clk_100hz * 100 +
 				pipe->stream->timing.v_total * pipe->stream->timing.h_total - 1)
 				/ (double)(pipe->stream->timing.v_total * pipe->stream->timing.h_total);
+		/* SubVP pipe candidate requirements:
+		 * - Refresh rate < 120hz
+		 * - Not able to switch in vactive naturally (switching in active means the
+		 *   DET provides enough buffer to hide the P-State switch latency -- trying
+		 *   to combine this with SubVP can cause issues with the scheduling).
+		 */
 		if (pipe->plane_state && !pipe->top_pipe &&
-				pipe->stream->mall_stream_config.type == SUBVP_NONE && refresh_rate < 120) {
+				pipe->stream->mall_stream_config.type == SUBVP_NONE && refresh_rate < 120 &&
+				vba->ActiveDRAMClockChangeLatencyMarginPerState[vba->VoltageLevel][vba->maxMpcComb][vba->pipe_plane[pipe_idx]] <= 0) {
 			while (pipe) {
 				num_pipes++;
 				pipe = pipe->bottom_pipe;
@@ -998,8 +1006,10 @@ static void dcn32_full_validate_bw_helper(struct dc *dc,
 
 	*vlevel = dml_get_voltage_level(&context->bw_ctx.dml, pipes, *pipe_cnt);
 	/* This may adjust vlevel and maxMpcComb */
-	if (*vlevel < context->bw_ctx.dml.soc.num_states)
+	if (*vlevel < context->bw_ctx.dml.soc.num_states) {
 		*vlevel = dcn20_validate_apply_pipe_split_flags(dc, context, *vlevel, split, merge);
+		vba->VoltageLevel = *vlevel;
+	}
 
 	/* Conditions for setting up phantom pipes for SubVP:
 	 * 1. Not force disable SubVP
@@ -1085,13 +1095,16 @@ static void dcn32_full_validate_bw_helper(struct dc *dc,
 
 			*vlevel = dml_get_voltage_level(&context->bw_ctx.dml, pipes, *pipe_cnt);
 			/* This may adjust vlevel and maxMpcComb */
-			if (*vlevel < context->bw_ctx.dml.soc.num_states)
+			if (*vlevel < context->bw_ctx.dml.soc.num_states) {
 				*vlevel = dcn20_validate_apply_pipe_split_flags(dc, context, *vlevel, split, merge);
+				vba->VoltageLevel = *vlevel;
+			}
 		} else {
 			// only call dcn20_validate_apply_pipe_split_flags if we found a supported config
 			memset(split, 0, MAX_PIPES * sizeof(int));
 			memset(merge, 0, MAX_PIPES * sizeof(bool));
 			*vlevel = dcn20_validate_apply_pipe_split_flags(dc, context, *vlevel, split, merge);
+			vba->VoltageLevel = *vlevel;
 
 			// Most populate phantom DLG params before programming hardware / timing for phantom pipe
 			DC_FP_START();
@@ -1421,6 +1434,8 @@ bool dcn32_internal_validate_bw(struct dc *dc,
 			memset(split, 0, sizeof(split));
 			memset(merge, 0, sizeof(merge));
 			vlevel = dcn20_validate_apply_pipe_split_flags(dc, context, vlevel, split, merge);
+			// dcn20_validate_apply_pipe_split_flags can modify voltage level outside of DML
+			vba->VoltageLevel = vlevel;
 		}
 	}
 
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
index f831855db022..3040428a7304 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
@@ -3617,7 +3617,7 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 						&mode_lib->vba.FCLKChangeSupport[i][j],
 						&v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_single2[1], // double *MinActiveFCLKChangeLatencySupported
 						&mode_lib->vba.USRRetrainingSupport[i][j],
-						mode_lib->vba.ActiveDRAMClockChangeLatencyMargin);
+						mode_lib->vba.ActiveDRAMClockChangeLatencyMarginPerState[i][j]);
 			}
 		}
 	} // End of Prefetch Check
diff --git a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h
index 492aec634b68..da8acf59ccac 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h
@@ -312,6 +312,7 @@ struct vba_vars_st {
 	unsigned int ActiveDPPs;
 	unsigned int LBLatencyHidingSourceLinesY;
 	unsigned int LBLatencyHidingSourceLinesC;
+	double ActiveDRAMClockChangeLatencyMarginPerState[DC__VOLTAGE_STATES][2][DC__NUM_DPP__MAX];// DML doesn't save active margin per state
 	double ActiveDRAMClockChangeLatencyMargin[DC__NUM_DPP__MAX];
 	double CachedActiveDRAMClockChangeLatencyMargin[DC__NUM_DPP__MAX]; // Cache in dml_get_voltage_level for debug purposes only
 	double MinActiveDRAMClockChangeMargin;
-- 
2.25.1

