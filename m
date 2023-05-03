Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7ADBC77B78
	for <amd-gfx@archiver.kernel.org>; Wed,  3 May 2023 01:41:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F5D910E189;
	Wed,  3 May 2023 01:41:07 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2049.outbound.protection.outlook.com [40.107.220.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5979B10E189
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 May 2023 01:41:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lf9mJyUX58Xymt8OJ93kL838ilPc2IWn1XWp21zWI2zqHDC2y/WZyMQxbXcjrU4II/WG+hvzhcLa9Acfn5/G7p50iVFNlkhXI28L6plABDxnErUfIfymKJggGPCXRM8dB88OZ0vUL7+yd99g4TJRrLzKoe6Tr86zLcjj3Tg1uyE7mI133fAWUiCDptEUMeMWh7Im9lw/xRmQwc+zDskBQG3DhahvuNm6Fr5NA9oHBIsEq6ENIFEI2SeEWUzFjadJhHuiWMWgk2eqnM8gexngO3+amM0iBsLR67JijakbrwMi6rWedytG/2npjwlDOI4qc5gI4HpQTpNeClKIWOyLhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tUcAwwaBpZEoNumuUkysWAMbJR5OTfC4tLAd1xqqtWg=;
 b=LqNntzRIgM68LtOu8jtrSH8Yvtl1AuZaT72Dt6e+odiKaK5ai9oWoDpvYiMZ2l7D1GqJYcCEMSvm0GTybhTgF5qLr4xpoAAS+Rl36C+MVKAxy4OmQ3OM5BOzYEgUzdf1oHUSAT5cJNrrV6jiAovhSTpfT52ikHqjL5oxA28aSLsbv4X/HdFvysfk78QgBn4I9xopkExwMa/P8OdasLqb6gSeYKx2Q8M+CFiIj5w++68LmwL8dnaI6N36LAz2x9HOouQsBhgGvBy/jzqnfXSIsgoR6V0XGNVNNBf6GlSBRMdAWv1ZOhQGgBtHRDBrxyQCsaDhHYAxMuVyYfxO+4w4tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tUcAwwaBpZEoNumuUkysWAMbJR5OTfC4tLAd1xqqtWg=;
 b=i5LIHI6zKvcM40WBrxJ6CSnrxtAEVj3iQu3Evpzoh4FIvrMocriQe8QCRaxH7psAWtObOWh6ENcti5VimqTsnjhFHevefa1bUnkkSWb/EF8I+iAzJCeBOync2hUKKj+smrF46awJDGkxgtD9Yk43PikkMOfOtpxL3pb2XenAgiY=
Received: from DM5PR07CA0109.namprd07.prod.outlook.com (2603:10b6:4:ae::38) by
 LV2PR12MB5896.namprd12.prod.outlook.com (2603:10b6:408:172::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.30; Wed, 3 May
 2023 01:41:02 +0000
Received: from DM6NAM11FT057.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:ae:cafe::5c) by DM5PR07CA0109.outlook.office365.com
 (2603:10b6:4:ae::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.22 via Frontend
 Transport; Wed, 3 May 2023 01:41:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT057.mail.protection.outlook.com (10.13.172.252) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6363.21 via Frontend Transport; Wed, 3 May 2023 01:41:02 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 2 May
 2023 20:40:55 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 4/8] drm/amd/display: Check Vactive for VRR active for FPO +
 Vactive
Date: Tue, 2 May 2023 19:38:49 -0600
Message-ID: <20230503013853.2266793-5-alex.hung@amd.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230503013853.2266793-1-alex.hung@amd.com>
References: <20230503013853.2266793-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT057:EE_|LV2PR12MB5896:EE_
X-MS-Office365-Filtering-Correlation-Id: efc3651d-939a-429c-abb2-08db4b777415
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HpF0qxLACNbPbpnmXjw16VJ+XpJGz9mVCKv+3IopQfIMfha38UIKy51/SKFuj3rtl2QYqqefT1FdvV1Nc+/k4zuR5cgoVBZFQfkE/w8KVe+aSrTaeP/bCrzQKSbtaxdSDzclZs9gR8G7wiVRZPsYr0O2T8LT2HBbTMPuyTE+MF1CzMmmQDfaZEFjObnWyRv0jO+CfsFVr7V7LUI0iSrgrLxAJND4GCwwAEeaBbdh6+JHgmwEiESi4OM9SaIeK2o0JhDuJ40b0/wQoPHokwHhweO0KgcSyOVLiZgVge27F22CSfpXozuquuSv9GqHjEAGQxESorSYDiwgikEUgpGCY0ft2PFdydDkQ53RwMKNdqge7ijQRTz5YQ5PXlm/6lMDadHPaxbHH/tOlNMaDfSOF2zbtBUdROpaKgDRJP2eQ2Q9KiZHGjUfc8tbPvDPmkwytiXNIfIdPze5gplc+1/3Viw9C5uSkw6Vuv5Xz/0XKDE3aIcD5fjmOPhEuYI6GzE8ajD5VTaOgt/n6Y8OMyAFkMNWYf40m4d4JQLEARTQAvEIjDYrQfRZtN//m7pl8GEYz+K3uGhb5klMplelmP5tJ4GbTDPu4dRAwX3hKkrwBLxFWh02rigxhfVE5WfmMWd1v3HCvhDld8uNjSalIdiiFOg1uFBjNxr/YCwAy0BQbYFJQUa0pPp20qRGr+ckyZzGQM6mJ9w130dHCaX2mR6IIWnxMQUTJgCjHnfDZC9teVMo70J4tslw5vRk3iEOCH0UONyfkERl99kiGf0BqPA3BQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(396003)(376002)(136003)(346002)(451199021)(46966006)(36840700001)(40470700004)(70586007)(5660300002)(8936002)(8676002)(40460700003)(44832011)(82740400003)(41300700001)(316002)(82310400005)(36756003)(356005)(86362001)(2906002)(81166007)(40480700001)(36860700001)(16526019)(186003)(2616005)(70206006)(478600001)(83380400001)(7696005)(6666004)(47076005)(426003)(26005)(1076003)(336012)(6916009)(4326008)(54906003)(36900700001)(44824005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2023 01:41:02.3044 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: efc3651d-939a-429c-abb2-08db4b777415
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT057.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5896
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
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, Alex Hung <alex.hung@amd.com>,
 Alvin Lee <Alvin.Lee2@amd.com>, wayne.lin@amd.com, Jun Lei <Jun.Lei@amd.com>,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alvin Lee <Alvin.Lee2@amd.com>

[Description]
- For FPO + Vactive cases, we rely on the Vactive display to be at
  it's nominal refresh rate because the Vactive pipe may not necessarily
  assert P-State allow while it's in VBLANK
- For cases where the Vactive display has a stretched VBLANK due to
  VRR, we could underflow when trying to complete an FPO + Vactive
  MCLK switch because the FPO display has limited VBLANK time in
  waiting for the Vactive display to assert P-State allow naturally
- Block FPO + Vactive if the Vactive display has VRR active (variable
  or fixed)

Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Alvin Lee <Alvin.Lee2@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c             | 5 ++++-
 drivers/gpu/drm/amd/display/dc/dc_stream.h           | 2 ++
 drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c | 7 ++++++-
 3 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 7b68ff0f9c4a..9be18ebb1c17 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -2604,7 +2604,7 @@ static enum surface_update_type check_update_surfaces_for_stream(
 
 		if (stream_update->stream && stream_update->stream->freesync_on_desktop &&
 			(stream_update->vrr_infopacket || stream_update->allow_freesync ||
-				stream_update->vrr_active_variable))
+				stream_update->vrr_active_variable || stream_update->vrr_active_fixed))
 			su_flags->bits.fams_changed = 1;
 
 		if (su_flags->raw != 0)
@@ -2964,6 +2964,9 @@ static void copy_stream_update_to_stream(struct dc *dc,
 	if (update->vrr_active_variable)
 		stream->vrr_active_variable = *update->vrr_active_variable;
 
+	if (update->vrr_active_fixed)
+		stream->vrr_active_fixed = *update->vrr_active_fixed;
+
 	if (update->crtc_timing_adjust)
 		stream->adjust = *update->crtc_timing_adjust;
 
diff --git a/drivers/gpu/drm/amd/display/dc/dc_stream.h b/drivers/gpu/drm/amd/display/dc/dc_stream.h
index 0add5ecc895f..d5b3e3a32cc6 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_stream.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_stream.h
@@ -233,6 +233,7 @@ struct dc_stream_state {
 	 */
 	bool vrr_active_variable;
 	bool freesync_on_desktop;
+	bool vrr_active_fixed;
 
 	bool converter_disable_audio;
 	uint8_t qs_bit;
@@ -326,6 +327,7 @@ struct dc_stream_update {
 	bool integer_scaling_update;
 	bool *allow_freesync;
 	bool *vrr_active_variable;
+	bool *vrr_active_fixed;
 
 	struct colorspace_transform *gamut_remap;
 	enum dc_color_space *output_color_space;
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
index 826059d5b367..46fd7b68857c 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
@@ -35,6 +35,7 @@
 
 #define DC_LOGGER_INIT(logger)
 
+static const unsigned int MAX_FPO_VACTIVE_BLANK_US = 600;
 static const struct subvp_high_refresh_list subvp_high_refresh_list = {
 			.min_refresh = 120,
 			.max_refresh = 165,
@@ -2924,6 +2925,7 @@ bool dcn32_find_vactive_pipe(struct dc *dc, const struct dc_state *context, uint
 	unsigned int i, pipe_idx;
 	const struct vba_vars_st *vba = &context->bw_ctx.dml.vba;
 	bool vactive_found = false;
+	unsigned int blank_us = 0;
 
 	for (i = 0, pipe_idx = 0; i < dc->res_pool->pipe_count; i++) {
 		const struct pipe_ctx *pipe = &context->res_ctx.pipe_ctx[i];
@@ -2931,7 +2933,10 @@ bool dcn32_find_vactive_pipe(struct dc *dc, const struct dc_state *context, uint
 		if (!pipe->stream)
 			continue;
 
-		if (vba->ActiveDRAMClockChangeLatencyMarginPerState[vba->VoltageLevel][vba->maxMpcComb][vba->pipe_plane[pipe_idx]] >= vactive_margin_req_us) {
+		blank_us = ((pipe->stream->timing.v_total - pipe->stream->timing.v_addressable) * pipe->stream->timing.h_total /
+				(double)(pipe->stream->timing.pix_clk_100hz * 100)) * 1000000;
+		if (vba->ActiveDRAMClockChangeLatencyMarginPerState[vba->VoltageLevel][vba->maxMpcComb][vba->pipe_plane[pipe_idx]] >= vactive_margin_req_us &&
+				!(pipe->stream->vrr_active_variable || pipe->stream->vrr_active_fixed) && blank_us < MAX_FPO_VACTIVE_BLANK_US) {
 			vactive_found = true;
 			break;
 		}
-- 
2.40.0

