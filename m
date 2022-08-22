Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92DE1C28D13
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Aug 2022 13:58:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 351238F0B8;
	Mon, 22 Aug 2022 13:58:23 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2044.outbound.protection.outlook.com [40.107.243.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 147B91132C8
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Aug 2022 13:57:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eVd3Y0zgz3mnu6mr8Sdy53lZlykh0e9y+kXcBSBlHh2msaC5sRIqPdfxARpQrNLgFZkkeOYP2zLaRB6xmXvmdIyBxBSjUWOyfHxYq6pZeKDKkSpfUYAclbk4ddz7c5WFswBI6p1WhjmZ7khgMQNput3NviFcdsbHNZZtda407Ph7ebb8B6XikWQB+ioR/hPl10eLcq+7R/pUuLx4ARfIEVDu4wdJsKMYzhVJqHO56w6SDLOiAqKmrgjkLR0Ki8+0TO5qHH+syCKRsUF0bohiu8fMqR+VT6Uip1+saTLX/SEK5rUIEIC2MR38fEgfU1nsEiQAIVCqrnkPm5iSBi3hjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fupt08b/8wLa3nAyLSOvkJGsM4a7Xiy87jDistTcpvs=;
 b=H+VVJqovomUBCE6zsHx+81vr3ul+xb2kvbjaene40Q+y2tYykniIbaM7NZtfxLtCeWBREb3A/rz/yNnXXR4Cuecr5YfTIKMaQN2fcGm7YBTbwpX/8+LJyYeu0DrR2xh6Yd9BaHbpashXCLl9i3vl3shTtkcBXZUCLxqmanNiC5+XaLNUnIwNPNMeTUoi6NPnJ1mmGjubDGZWoEcCVQM2BwR+wKBZb4zi4F6vcibY8NAurMTKGAqo3/zlAdCsu51p7BXbhdMOGkSufIt1rLNqXQnEA0Qjl6oM9snlhuqtV4kGrnDFI7sCKEjIAjh5QvJO9fFwcJW5AbgYzI7zSEyfBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fupt08b/8wLa3nAyLSOvkJGsM4a7Xiy87jDistTcpvs=;
 b=5rjob3IPUUmiqku+UBLJBGVZFPHXZ4zDKl9YkWEu5Ffx1ZqBFmkrjhqQZD1GJ1PPqkkkFzxsazptYuffoFln7MoWDWYDgKpJlVMwVby2DnOn815BlWUT9PyO5M1rFVjQtaSQ1R6ezZyuXixbXJH/yI8jVml09SFQEVqnNMhGIGo=
Received: from BN8PR15CA0016.namprd15.prod.outlook.com (2603:10b6:408:c0::29)
 by DM6PR12MB4896.namprd12.prod.outlook.com (2603:10b6:5:1b6::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.21; Mon, 22 Aug
 2022 13:57:44 +0000
Received: from BN8NAM11FT013.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:c0:cafe::8c) by BN8PR15CA0016.outlook.office365.com
 (2603:10b6:408:c0::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.22 via Frontend
 Transport; Mon, 22 Aug 2022 13:57:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT013.mail.protection.outlook.com (10.13.176.182) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5546.15 via Frontend Transport; Mon, 22 Aug 2022 13:57:41 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 22 Aug
 2022 08:57:39 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 22 Aug
 2022 08:57:16 -0500
Received: from brianchang-HP-EliteDesk-805-G6-Small-Form-Factor-PC.amd.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server id 15.1.2375.28 via Frontend Transport; Mon, 22 Aug 2022 08:57:13
 -0500
From: brichang <Brian.Chang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 02/14] drm/amd/display: do not change pipe split policy for RV2
Date: Mon, 22 Aug 2022 17:57:40 +0800
Message-ID: <20220822095752.3750614-3-Brian.Chang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220822095752.3750614-1-Brian.Chang@amd.com>
References: <20220822095752.3750614-1-Brian.Chang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 14bd9513-9d9d-41c7-f967-08da844647d6
X-MS-TrafficTypeDiagnostic: DM6PR12MB4896:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H0KACVk3f9g/Ix0eWUPxzegHYvGHkVMETwzy7x+yUqNdruI1S1WcucYlD1tocsdvpN/PGTlIABd7SUPTwMWFJkHBmhkSBePgMlsLkJcQ5XXpY3GxG4GsgLDjPWZB/+uuKe5wpRcgZkQ00wpxYObHBsuKFg2xtMaO6lNvk8czmfn7n22CKoACi3NECzjbuvCmtU4c5yDuOafTdlHcwmVl1PTuUcWHF4JMhkbMEyzFzlchpqlXiwtddBny5Q+JGWts8h7EWhoQjuc5d/3FAErcLQOnyF5B1/5ODdB9DwKgAeRdh8oh4eBNB/R9Vy/YS1yF0i2EqlAFnKaaIKWFykEpEqEfJ7MXYh+ftWwMEVxh7iU58dAi0jSyVP3uhL3QEo5Q60ZItwGB0veAVcYOTAL6YN0hXmnOzGYnHm+TQ0FCXKnbxPIDB6JPj3AIyWx7PSMVMBIEkzXsnAfk50Zs8Izm2jdvAFRaOb19V6nTnG04Awi9tv9xjFZyo/0Jl9GL+QvtFT82JgipXEUqfDSSr8MAqKC9bU0xy+3OhdISSrU7F/LrdpLmJeaXQXeIogqUj2uJOEKS92HglBviy+3OfGhQp7Emx3ZCGecR96l+5CREOAhx3Oo9wX7/0uy3arIA0GO9dHsDB/c8P/Dv2Pqvkf1lyTPtf/TfMWarqAVCVvQj1BSAFqniZ2EiD45lZiF9qGmh6mrnXdP0q9bb1tfCgX9xSz907n0BNHg4TytJG4bJ9JE/OfAKtie5CNuuj+P+Vy0SueZg1weS+Ym7XcJVHI077+xIjHPL0osv6LHdzZ7D6KIhoflpLt0VeOmeOzluUO8qSLX3qiZO1yUS3SWiFpoUHw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(396003)(346002)(136003)(376002)(40470700004)(36840700001)(46966006)(336012)(186003)(26005)(2906002)(86362001)(7696005)(2616005)(1076003)(36860700001)(82740400003)(82310400005)(83380400001)(356005)(47076005)(426003)(40480700001)(81166007)(54906003)(6916009)(8936002)(36756003)(316002)(478600001)(40460700003)(8676002)(4326008)(6666004)(70206006)(70586007)(5660300002)(41300700001)(43062005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2022 13:57:41.3413 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 14bd9513-9d9d-41c7-f967-08da844647d6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT013.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4896
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
Cc: stylon.wang@amd.com, Charlene Liu <Charlene.Liu@amd.com>,
 Brian Chang <Brian.Chang@amd.com>, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Derek Lai <Derek.Lai@amd.com>, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Derek Lai <Derek.Lai@amd.com>

[Why]
RV2 do not change pipe split policy in the
minimal pipe split transition state.
This will unblock mode support on some
parts that limit to DPM0 for power reason.

[How]
Do not change pipe split policy in the
minimal pipe split transition state to
allow 4k multi display configs to be
supported at DPM0.

Reviewed-by: Charlene Liu <Charlene.Liu@amd.com>
Acked-by: Brian Chang <Brian.Chang@amd.com>
Signed-off-by: Derek Lai <Derek.Lai@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  9 ++++--
 drivers/gpu/drm/amd/display/dc/dc.h           |  1 +
 .../drm/amd/display/dc/dcn10/dcn10_resource.c | 18 +++++++++++
 .../drm/amd/display/dc/dml/calcs/dcn_calcs.c  | 32 ++++---------------
 4 files changed, 31 insertions(+), 29 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 0fade2f1efb5..5006263f8d56 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -3546,8 +3546,10 @@ static bool commit_minimal_transition_state(struct dc *dc,
 	if (!transition_context)
 		return false;
 
-	tmp_policy = dc->debug.pipe_split_policy;
-	dc->debug.pipe_split_policy = MPC_SPLIT_AVOID;
+	if (!dc->config.is_vmin_only_asic) {
+		tmp_policy = dc->debug.pipe_split_policy;
+		dc->debug.pipe_split_policy = MPC_SPLIT_AVOID;
+	}
 
 	dc_resource_state_copy_construct(transition_base_context, transition_context);
 
@@ -3573,7 +3575,8 @@ static bool commit_minimal_transition_state(struct dc *dc,
 	dc_release_state(transition_context);
 
 	//restore previous pipe split policy
-	dc->debug.pipe_split_policy = tmp_policy;
+	if (!dc->config.is_vmin_only_asic)
+		dc->debug.pipe_split_policy = tmp_policy;
 
 	if (ret != DC_OK) {
 		//this should never happen
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 2f2d0095d328..322ecc96b174 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -401,6 +401,7 @@ struct dc_config {
 	uint8_t  vblank_alignment_max_frame_time_diff;
 	bool is_asymmetric_memory;
 	bool is_single_rank_dimm;
+	bool is_vmin_only_asic;
 	bool use_pipe_ctx_sync_logic;
 	bool ignore_dpref_ss;
 	bool enable_mipi_converter_optimization;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c
index 174eebbe8b4f..831080b9eb87 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c
@@ -1495,6 +1495,24 @@ static bool dcn10_resource_construct(
 	/* Other architectures we build for build this with soft-float */
 	dcn10_resource_construct_fp(dc);
 
+	if (!dc->config.is_vmin_only_asic)
+		if (ASICREV_IS_RAVEN2(dc->ctx->asic_id.hw_internal_rev))
+			switch (dc->ctx->asic_id.pci_revision_id) {
+			case PRID_DALI_DE:
+			case PRID_DALI_DF:
+			case PRID_DALI_E3:
+			case PRID_DALI_E4:
+			case PRID_POLLOCK_94:
+			case PRID_POLLOCK_95:
+			case PRID_POLLOCK_E9:
+			case PRID_POLLOCK_EA:
+			case PRID_POLLOCK_EB:
+				dc->config.is_vmin_only_asic = true;
+				break;
+			default:
+				break;
+			}
+
 	pool->base.pp_smu = dcn10_pp_smu_create(ctx);
 
 	/*
diff --git a/drivers/gpu/drm/amd/display/dc/dml/calcs/dcn_calcs.c b/drivers/gpu/drm/amd/display/dc/dml/calcs/dcn_calcs.c
index db3b16b77034..d46adc849d2a 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/calcs/dcn_calcs.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/calcs/dcn_calcs.c
@@ -736,30 +736,13 @@ static void hack_bounding_box(struct dcn_bw_internal_vars *v,
 		hack_force_pipe_split(v, context->streams[0]->timing.pix_clk_100hz);
 }
 
-static unsigned int get_highest_allowed_voltage_level(uint32_t chip_family,
-						      uint32_t hw_internal_rev,
-						      uint32_t pci_revision_id)
+static unsigned int get_highest_allowed_voltage_level(bool is_vmin_only_asic)
 {
 	/* for low power RV2 variants, the highest voltage level we want is 0 */
-	if ((chip_family == FAMILY_RV) &&
-	     ASICREV_IS_RAVEN2(hw_internal_rev))
-		switch (pci_revision_id) {
-		case PRID_DALI_DE:
-		case PRID_DALI_DF:
-		case PRID_DALI_E3:
-		case PRID_DALI_E4:
-		case PRID_POLLOCK_94:
-		case PRID_POLLOCK_95:
-		case PRID_POLLOCK_E9:
-		case PRID_POLLOCK_EA:
-		case PRID_POLLOCK_EB:
-			return 0;
-		default:
-			break;
-		}
-
-	/* we are ok with all levels */
-	return 4;
+	if (is_vmin_only_asic)
+		return 0;
+	else	/* we are ok with all levels */
+		return 4;
 }
 
 bool dcn_validate_bandwidth(
@@ -1323,10 +1306,7 @@ bool dcn_validate_bandwidth(
 	PERFORMANCE_TRACE_END();
 	BW_VAL_TRACE_FINISH();
 
-	if (bw_limit_pass && v->voltage_level <= get_highest_allowed_voltage_level(
-							dc->ctx->asic_id.chip_family,
-							dc->ctx->asic_id.hw_internal_rev,
-							dc->ctx->asic_id.pci_revision_id))
+	if (bw_limit_pass && v->voltage_level <= get_highest_allowed_voltage_level(dc->config.is_vmin_only_asic))
 		return true;
 	else
 		return false;
-- 
2.25.1

