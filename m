Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9122C4345F
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Apr 2024 08:53:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6AD0E10FE22;
	Wed, 24 Apr 2024 08:53:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OdZRMiQ3";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2078.outbound.protection.outlook.com [40.107.94.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BEE6810FE22
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Apr 2024 08:53:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cPpfGW9DdY+70T/KbLv5glFmWRAbm13I8Neg6psaRGKAp21gqf9lAzzkJGYIqbrVbUJlAGQU7+aBZoZl0IFmanM+zBPU2hljmKKVVM8M4Qtsh+8ZaYFn1F49YIDL1K0JkJIn54fLPDu/5RHnPy47K2xqvatLhXPRdffJHlwcHIxCsK7rQVHMBBGJOHQegke3w5AwoGaFMCjsHGPBBGN3aOLpq6Ih4+v6neHXb/Z7wxk0rNf2Ix6K6Zz+mKAkTt0dCMi5rhd2u2FjAhlRN5VFclbRQ8HdVvfP8JfUzfvQD/v2BNd0+vqkt8PJvlUeGuq8AV08aSirTYpZ/XxAZ5IFqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YCUD9iSImRBxoz8ZH6IvFK0G+N5oql+tnfR3RI7W8+4=;
 b=AERqoVyaUoFCYrisNceoqo/kVGfxqm6eqTPMvfSzMe+uJ+gQQkd485d0dgcmSBbpLCkRc4TKb78niRn/azVIyfGaarL1ahKmUSLrT7XoGzVpqNIPFqum7lpfFX4QNyqctSys9djnl9bpQx3/kU9W6NQTo0Mf4Xcyo5b1kHjMbgFSaLF11yVauivdzwuNVod0VIxSqJQ49IWu26mXbl6eMxqXGbKgFky57h2Ar0srDAnxECzkbFUZxGPxV9RnEmm//S64zRsAyFnh2K19ZhyfWj2LBzfcTTgRjTme2vwWqKWAOd8L7wfsfaOyHCnxpkBnJJ1sZ56sLP1RG4e7cRxYJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YCUD9iSImRBxoz8ZH6IvFK0G+N5oql+tnfR3RI7W8+4=;
 b=OdZRMiQ3i9778pI7jNNgNcXm6pkpx1DDbkLjevJSWxJNcFolDVT8hJvVa/Qc4mYKzcvmhE3ClcUskcHuyKbzgMJQD9ddLVG+FzI+t2jtcFyOH8cNAig/sCh+yjyaBrIV6H5AHQzyyXjwhupv9HIP60Z3chtFQonxal4ln0G4NFI=
Received: from BYAPR08CA0041.namprd08.prod.outlook.com (2603:10b6:a03:117::18)
 by PH7PR12MB7844.namprd12.prod.outlook.com (2603:10b6:510:27b::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Wed, 24 Apr
 2024 08:53:32 +0000
Received: from MWH0EPF000971E7.namprd02.prod.outlook.com
 (2603:10b6:a03:117:cafe::70) by BYAPR08CA0041.outlook.office365.com
 (2603:10b6:a03:117::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22 via Frontend
 Transport; Wed, 24 Apr 2024 08:53:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 MWH0EPF000971E7.mail.protection.outlook.com (10.167.243.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Wed, 24 Apr 2024 08:53:32 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 24 Apr
 2024 03:53:31 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 24 Apr
 2024 03:53:30 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 24 Apr 2024 03:53:26 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Alvin Lee <alvin.lee2@amd.com>,
 Samson Tam <samson.tam@amd.com>, Chaitanya Dhere <chaitanya.dhere@amd.com>
Subject: [PATCH 35/46] drm/amd/display: For FPO + Vactive check that all pipes
 support VA
Date: Wed, 24 Apr 2024 16:49:20 +0800
Message-ID: <20240424084931.2656128-36-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20240424084931.2656128-1-Wayne.Lin@amd.com>
References: <20240424084931.2656128-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: Wayne.Lin@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E7:EE_|PH7PR12MB7844:EE_
X-MS-Office365-Filtering-Correlation-Id: db3e4dc0-50ae-4b3e-8524-08dc643c04de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?0Y7tQlWup2tpKivSFKdkyLOgLRtN7NvClzWX3+hZMfv+zeBUkCCl1JUZ1cw5?=
 =?us-ascii?Q?Z/hWTuuGvOeoFN0aSKwTzWWH00xWk5GCd3lX9Jk9QZ0qoCkreyExUbYIoJA2?=
 =?us-ascii?Q?LzCzPRUI8FrBbPdMphmg5rDGo+56P8CX7qNprkop9x3v5w+8gEjLOdr8+TQp?=
 =?us-ascii?Q?VETUnE5lK8ZPS3enEwJOqQ9ogfoy3ap6QgzGFNa+7+7LnxgE24ByYByhV+/f?=
 =?us-ascii?Q?9R5zXEc1qGccFLFypRMRXE5d3whb0JcpuyG97wTqXx9zub0TqAKD1WKML9ww?=
 =?us-ascii?Q?G5xtE31uo6VoIgUfHWEnSb+nS5f68G/dz8iby40RY0agx0VPZk8V6d8A9pFg?=
 =?us-ascii?Q?jhhKUIdXDupx9oPu9W/jUS50wYVcoyt/dYywW/UvYXZ9OlSjNb6bFpa1vSB1?=
 =?us-ascii?Q?vYMtpkR7jS++mjUq1mZJDzSqWTe9OH3EQ2bD3CAEcCeFL4wEJXoogL1xlnMF?=
 =?us-ascii?Q?Op5i9v5T55IP+uaPzW/WKLfoDjxUO4FxSXrnL1c3w5YYyLbEV8xkeRtnm1U8?=
 =?us-ascii?Q?Us5qccEnfZvq+yjN9HeEsA6rXiYddLUNvOQ3hZIb8DV3bROsyBXtv6lz/7rS?=
 =?us-ascii?Q?Aj4I+A1g18mH5f2alqkWhCWGZpBLHx1sF8GUMl+S1UC1nL03Z9jl/25QeyLj?=
 =?us-ascii?Q?LP/LhzeuaVIw7eZyjJCHJYB3Fcpt3yPlKSZVe+3bpuDmm4Tl/gut3RkNVUpW?=
 =?us-ascii?Q?/zIWtyN2DnOqsGWwdI+i/JYkF4EJBblWtIS0SnFBW2RPjfiVuEItHSKd/TL7?=
 =?us-ascii?Q?CW+Oip99YGvV33gMVncUFI4EcUe69ck94GL3WQqDtBQ1C5k13iWfCNjenzhi?=
 =?us-ascii?Q?mAB0u7m4MsRWevT3uFFfGEPp4cNoHbcBEneAjQymmRWApjrWBjONt5bSfJb7?=
 =?us-ascii?Q?kL2ySHjSVWfGPuJOwLSO5CQnuORAJkTUXsdsz3+wcqSknFIjgjYm1gWWed1P?=
 =?us-ascii?Q?HyWo9WsIqbxsyzMO0NEkvc6meK8IJTl9OsWipBa2FJvXEHjULi+PLBmSD4O2?=
 =?us-ascii?Q?ZnOc6vTQfcUMIf4YpVLUMbn2uWwk3KASNRhLEwOLrjxNxiWNrVuP6bAmjhLy?=
 =?us-ascii?Q?5pdhvA13L1gABCIiKZWeJErVPdsVo8iuYG46+HQgW6DYAbqym2jXT3VHoZSF?=
 =?us-ascii?Q?LcKdHg51lWr/bb901/2Xt/D8MNAkmAGps2YLlalYACaV8zuKHN6ZHzLzWRMl?=
 =?us-ascii?Q?1NfgORyChC1EkNPhDIXje146KRAPBEp8W3iusGP7hlHkxccuAY9OIPK6seqg?=
 =?us-ascii?Q?FGF3T3teVaZtffbPlRy62/dfN9Mc+fO4FUziWHHcF5JQTW7//3uuTZ1/nbvj?=
 =?us-ascii?Q?ZUk1zGzX41agn8D/UuSFrZvGN06NvEmaFil+6t8YDx99iJiZLT8BEtfwv6qI?=
 =?us-ascii?Q?nunvuHfxQqvyppN0l8T9cwnyPi8F?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(82310400014)(1800799015)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 08:53:32.0399 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: db3e4dc0-50ae-4b3e-8524-08dc643c04de
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7844
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
For FPO + Vactive scenarios we must check that all non-FPO pipes
have VACTIVE margin to allow it. The previous check only confirmed
that there is at least one pipe that has vactive margin, but this
is incorrect as the vactive display could be using two pipes (MPO)
where the desktop plane has vactive margin, and the video plane
does not.

Reviewed-by: Samson Tam <samson.tam@amd.com>
Reviewed-by: Chaitanya Dhere <chaitanya.dhere@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Alvin Lee <alvin.lee2@amd.com>
---
 .../display/dc/dcn32/dcn32_resource_helpers.c |  2 +-
 .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.c  | 20 ++++++++++++++-----
 .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.h  |  2 +-
 3 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c
index a8c36eda1d09..eba7bfc7e4af 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c
@@ -545,7 +545,7 @@ struct dc_stream_state *dcn32_can_support_mclk_switch_using_fw_based_vblank_stre
 		if (fpo_candidate_stream)
 			fpo_stream_status = dc_state_get_stream_status(context, fpo_candidate_stream);
 		DC_FP_START();
-		is_fpo_vactive = dcn32_find_vactive_pipe(dc, context, dc->debug.fpo_vactive_min_active_margin_us);
+		is_fpo_vactive = dcn32_find_vactive_pipe(dc, context, fpo_candidate_stream, dc->debug.fpo_vactive_min_active_margin_us);
 		DC_FP_END();
 		if (!is_fpo_vactive || dc->debug.disable_fpo_vactive)
 			return NULL;
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
index 5be976fa44f9..8912475f01e2 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
@@ -3521,15 +3521,16 @@ void dcn32_assign_fpo_vactive_candidate(struct dc *dc, const struct dc_state *co
  *
  * @dc: current dc state
  * @context: new dc state
+ * @fpo_candidate_stream: candidate stream to be chosen for FPO
  * @vactive_margin_req_us: The vactive marign required for a vactive pipe to be considered "found"
  *
  * Return: True if VACTIVE display is found, false otherwise
  */
-bool dcn32_find_vactive_pipe(struct dc *dc, const struct dc_state *context, uint32_t vactive_margin_req_us)
+bool dcn32_find_vactive_pipe(struct dc *dc, const struct dc_state *context, struct dc_stream_state *fpo_candidate_stream, uint32_t vactive_margin_req_us)
 {
 	unsigned int i, pipe_idx;
 	const struct vba_vars_st *vba = &context->bw_ctx.dml.vba;
-	bool vactive_found = false;
+	bool vactive_found = true;
 	unsigned int blank_us = 0;
 
 	for (i = 0, pipe_idx = 0; i < dc->res_pool->pipe_count; i++) {
@@ -3538,11 +3539,20 @@ bool dcn32_find_vactive_pipe(struct dc *dc, const struct dc_state *context, uint
 		if (!pipe->stream)
 			continue;
 
+		/* Don't need to check for vactive margin on the FPO candidate stream */
+		if (fpo_candidate_stream && pipe->stream == fpo_candidate_stream) {
+			pipe_idx++;
+			continue;
+		}
+
+		/* Every plane (apart from the ones driven by the FPO pipes) needs to have active margin
+		 * in order for us to have found a valid "vactive" config for FPO + Vactive
+		 */
 		blank_us = ((pipe->stream->timing.v_total - pipe->stream->timing.v_addressable) * pipe->stream->timing.h_total /
 				(double)(pipe->stream->timing.pix_clk_100hz * 100)) * 1000000;
-		if (vba->ActiveDRAMClockChangeLatencyMarginPerState[vba->VoltageLevel][vba->maxMpcComb][vba->pipe_plane[pipe_idx]] >= vactive_margin_req_us &&
-				!(pipe->stream->vrr_active_variable || pipe->stream->vrr_active_fixed) && blank_us < dc->debug.fpo_vactive_max_blank_us) {
-			vactive_found = true;
+		if (vba->ActiveDRAMClockChangeLatencyMarginPerState[vba->VoltageLevel][vba->maxMpcComb][vba->pipe_plane[pipe_idx]] < vactive_margin_req_us ||
+				pipe->stream->vrr_active_variable || pipe->stream->vrr_active_fixed || blank_us >= dc->debug.fpo_vactive_max_blank_us) {
+			vactive_found = false;
 			break;
 		}
 		pipe_idx++;
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.h b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.h
index d25c3f730a59..276e90e4e0ce 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.h
@@ -71,7 +71,7 @@ void dcn32_zero_pipe_dcc_fraction(display_e2e_pipe_params_st *pipes,
 
 void dcn32_assign_fpo_vactive_candidate(struct dc *dc, const struct dc_state *context, struct dc_stream_state **fpo_candidate_stream);
 
-bool dcn32_find_vactive_pipe(struct dc *dc, const struct dc_state *context, uint32_t vactive_margin_req);
+bool dcn32_find_vactive_pipe(struct dc *dc, const struct dc_state *context, struct dc_stream_state *fpo_candidate_stream, uint32_t vactive_margin_req);
 
 void dcn32_override_min_req_memclk(struct dc *dc, struct dc_state *context);
 
-- 
2.37.3

