Return-Path: <SRS0=770C=P7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55FF5C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Nov 2021 00:55:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BEE061213
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Nov 2021 00:55:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1BEE061213
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B1CD76EAAC;
	Fri, 12 Nov 2021 00:55:38 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2059.outbound.protection.outlook.com [40.107.223.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D1C86EA87
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Nov 2021 00:55:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oNkMct3qY/DXLLGOLgPXcJeY747MC5+BlrMy6pZsBW8bjp3hUG+BXMWOjH8C3mtX9WBn2R5NqHycXK4vlakRzPL7qEb5gnE+GG+MkQELqLt9bzNeda3m4HLCrdWTyrKoIYJpFbdYkDVaCj0oeg0nj7DJsHDzhmhW8cv86c77sGR04hkTsGhtc4BlQkagCmLvECtfRAjDJh24oElASw99uRcz8QHsmiDe3RQCVmRrkfaS/ZGaXTe2OEZt6P/r1T6ph2xLtg+jezLArvGdfMzfC4e8WM740h9+rWtmMfsc++7PXUDLnongwjme0f8YHJZpxciq9/3jYjJAFRwQ9Kt2sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0+U0LrFjgw1o/Fd5pvqMW2ip3pKC5aRhns/w6KqT/2Q=;
 b=CnsFzbVVLPQWVN4US5mXPErOm5KzkL4Y9giuqGHoEGdUo4OXoMh7KoFM+5vvk2Dp5vvEH/CDWoceMj2YgBXHQmqDmRgPgx2F+9q/pFa8TzwyCRrhgKjTt0/TbHhMoJzFhFu5egN6rA6O0t5bH484Y1BsxjBslMYJNkRrTuN+kucA+lk/FLbRTNZcmjJyz4JWyBmH1sLklWQwrrhV2fJg0ogqZspXK/6SGx9bI01crB0KmZI1lBDpS8pQ2BaUA8LQKh+WNC98aTxQmflQLLc6+Hp07iGGkGQzs7y+O2f9PxEQhfB31HQ2EUafrxSeTU5z3Z7WNSu3pmgfwnyaedzZWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0+U0LrFjgw1o/Fd5pvqMW2ip3pKC5aRhns/w6KqT/2Q=;
 b=0GNsqrXFJcjh0PU7L2t+DEd0VSznphJYulYRZy/ez09ilbd5EowRzwqccVAWGquGP5K+lvkBkp7GqX28gHnnERqDE2uHn/0R8PkoxxTjb5QkpTxSADvVvjfSn4H2DCloVgB+z6JV/7aIdNyRtgS81N9isOS7y4bDJf8Ke/RtCSE=
Received: from MWHPR20CA0005.namprd20.prod.outlook.com (2603:10b6:300:13d::15)
 by DM5PR1201MB0218.namprd12.prod.outlook.com (2603:10b6:4:4d::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11; Fri, 12 Nov
 2021 00:55:33 +0000
Received: from CO1NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:13d:cafe::79) by MWHPR20CA0005.outlook.office365.com
 (2603:10b6:300:13d::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.15 via Frontend
 Transport; Fri, 12 Nov 2021 00:55:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT060.mail.protection.outlook.com (10.13.175.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4690.15 via Frontend Transport; Fri, 12 Nov 2021 00:55:32 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 11 Nov
 2021 18:55:30 -0600
Received: from wayne-Bilby-RV1.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.17 via
 Frontend Transport; Thu, 11 Nov 2021 18:55:27 -0600
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 07/14] drm/amd/display: Enable DSC over eDP
Date: Fri, 12 Nov 2021 08:54:31 +0800
Message-ID: <20211112005438.5505-8-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211112005438.5505-1-Wayne.Lin@amd.com>
References: <20211112005438.5505-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f01dc10f-d03a-42b8-974a-08d9a5772129
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0218:
X-Microsoft-Antispam-PRVS: <DM5PR1201MB021830DE634577FEAADD6AD2FC959@DM5PR1201MB0218.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AUS/eW3lfvQnV/uRAluJizLEKAwGR7yRfpusn9bTJ5+YNV7wAcskxeqWxoQ9u8i6SRcJKFxbASbb6rjXAXCAKmlRB7jYwTI9GlPCoy6s5sWT+YWoDeTiMLuGAc2T/wHni7wvAXbp04N8WKdaqtIaGzN0uur2iTaLigEZvW9xC45otFo+FoUEYUjmp5xzlwSNKdbsdyyO+/K8DMT4q0WX9Y+W++fygRDQwgIJCDdRn2U3dTCpY02mTLVElIucAcyf0BqkTMS2xZ+7eZJTPahEY8ylYIkmOdzr3RFLmJibDthBBWTICmFfDclR15QpDk/z1EHwLujgKWDqTD1RgG3ACMJYCtqK5BJLSCQMbtSjSFN8hSo3mqQXvQopzYeWWx7vMV89PH6/Y03Cu3YXjlonCNmIaX07dv6g+G8Ei0LXQQzlkF5k+XPxF1Qagt0q/Y8baGbW41/XEvNNmlADVflgcB3GKOkel8iVSzZ06ruQL70IfdanqCdGo96CpsmLglbh8fASEkBn0Tgx22OJGyE1bla3LETXy/xnofbW0AwmvtuJYHodra3Xe4xClDgcGlObCBXr+TXieggHzMAYVOlrfuwEdQAeBRgA6aWCs/mkCkJ9wMzWLyqBe9OdDgX+u1TEMPqLip7+0qJZU1qKrAEWRvDw5u6JlQMtOiu+8NlbUb07EQLQR2H1MwZOOivQl8kNRCY7ICtXV42+BPv715J4LGQVae2Xj69cLzvoA95Iwj4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(30864003)(2906002)(356005)(186003)(316002)(336012)(81166007)(2616005)(83380400001)(426003)(86362001)(36756003)(54906003)(6916009)(8676002)(8936002)(508600001)(5660300002)(47076005)(70586007)(1076003)(6666004)(36860700001)(70206006)(82310400003)(26005)(7696005)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2021 00:55:32.4131 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f01dc10f-d03a-42b8-974a-08d9a5772129
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT060.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0218
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
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 mikita.lipski@amd.com, Bhawanpreet.Lakha@amd.com,
 Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Mikita Lipski <mikita.lipski@amd.com>

[why]
- Adding a DM interface to enable DSC over eDP on Linux
- DSC over eDP will allow to power savings by reducing
the bandwidth required to support panel's modes
- Apply link optimization algorithm to reduce link bandwidth
when DSC is enabled

[how]
- Read eDP panel's DSC capabilities
- Apply DSC policy on eDP panel based on its DSC capabilities
- Enable DSC encoder's on the pipe
- Enable DSC on panel's side by setting DSC_ENABLE DPCD register
- Adding link optimization algorithm to reduce link rate or lane
count based

Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Mikita Lipski <mikita.lipski@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  73 +++++++-
 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c |   2 +-
 drivers/gpu/drm/amd/display/dc/core/dc_link.c |   2 +
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  | 162 +++++++++++++++++-
 drivers/gpu/drm/amd/display/dc/dc.h           |   3 +
 drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c |   1 +
 .../drm/amd/display/dc/dcn31/dcn31_resource.c |   1 +
 drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c   |   8 +
 drivers/gpu/drm/amd/display/dc/inc/hw/dsc.h   |   1 +
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |   8 +-
 .../amd/display/include/ddc_service_types.h   |   1 +
 11 files changed, 255 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 7a54ccb794f9..a15f20aaa11e 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1478,8 +1478,10 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 	if (amdgpu_dc_debug_mask & DC_DISABLE_STUTTER)
 		adev->dm.dc->debug.disable_stutter = true;
 
-	if (amdgpu_dc_debug_mask & DC_DISABLE_DSC)
+	if (amdgpu_dc_debug_mask & DC_DISABLE_DSC) {
 		adev->dm.dc->debug.disable_dsc = true;
+		adev->dm.dc->debug.disable_dsc_edp = true;
+	}
 
 	if (amdgpu_dc_debug_mask & DC_DISABLE_CLOCK_GATING)
 		adev->dm.dc->debug.disable_clock_gate = true;
@@ -6032,7 +6034,8 @@ static void update_dsc_caps(struct amdgpu_dm_connector *aconnector,
 {
 	stream->timing.flags.DSC = 0;
 
-	if (aconnector->dc_link && sink->sink_signal == SIGNAL_TYPE_DISPLAY_PORT) {
+	if (aconnector->dc_link && (sink->sink_signal == SIGNAL_TYPE_DISPLAY_PORT ||
+		sink->sink_signal == SIGNAL_TYPE_EDP)) {
 		dc_dsc_parse_dsc_dpcd(aconnector->dc_link->ctx->dc,
 				      aconnector->dc_link->dpcd_caps.dsc_caps.dsc_basic_caps.raw,
 				      aconnector->dc_link->dpcd_caps.dsc_caps.dsc_branch_decoder_caps.raw,
@@ -6040,6 +6043,64 @@ static void update_dsc_caps(struct amdgpu_dm_connector *aconnector,
 	}
 }
 
+static void apply_dsc_policy_for_edp(struct amdgpu_dm_connector *aconnector,
+				    struct dc_sink *sink, struct dc_stream_state *stream,
+				    struct dsc_dec_dpcd_caps *dsc_caps,
+				    uint32_t max_dsc_target_bpp_limit_override)
+{
+	const struct dc_link_settings *verified_link_cap = NULL;
+	uint32_t link_bw_in_kbps;
+	uint32_t edp_min_bpp_x16, edp_max_bpp_x16;
+	struct dc *dc = sink->ctx->dc;
+	struct dc_dsc_bw_range bw_range = {0};
+	struct dc_dsc_config dsc_cfg = {0};
+
+	verified_link_cap = dc_link_get_link_cap(stream->link);
+	link_bw_in_kbps = dc_link_bandwidth_kbps(stream->link, verified_link_cap);
+	edp_min_bpp_x16 = 8 * 16;
+	edp_max_bpp_x16 = 8 * 16;
+
+	if (edp_max_bpp_x16 > dsc_caps->edp_max_bits_per_pixel)
+		edp_max_bpp_x16 = dsc_caps->edp_max_bits_per_pixel;
+
+	if (edp_max_bpp_x16 < edp_min_bpp_x16)
+		edp_min_bpp_x16 = edp_max_bpp_x16;
+
+	if (dc_dsc_compute_bandwidth_range(dc->res_pool->dscs[0],
+				dc->debug.dsc_min_slice_height_override,
+				edp_min_bpp_x16, edp_max_bpp_x16,
+				dsc_caps,
+				&stream->timing,
+				&bw_range)) {
+
+		if (bw_range.max_kbps < link_bw_in_kbps) {
+			if (dc_dsc_compute_config(dc->res_pool->dscs[0],
+					dsc_caps,
+					dc->debug.dsc_min_slice_height_override,
+					max_dsc_target_bpp_limit_override,
+					0,
+					&stream->timing,
+					&dsc_cfg)) {
+				stream->timing.dsc_cfg = dsc_cfg;
+				stream->timing.flags.DSC = 1;
+				stream->timing.dsc_cfg.bits_per_pixel = edp_max_bpp_x16;
+			}
+			return;
+		}
+	}
+
+	if (dc_dsc_compute_config(dc->res_pool->dscs[0],
+				dsc_caps,
+				dc->debug.dsc_min_slice_height_override,
+				max_dsc_target_bpp_limit_override,
+				link_bw_in_kbps,
+				&stream->timing,
+				&dsc_cfg)) {
+		stream->timing.dsc_cfg = dsc_cfg;
+		stream->timing.flags.DSC = 1;
+	}
+}
+
 static void apply_dsc_policy_for_stream(struct amdgpu_dm_connector *aconnector,
 										struct dc_sink *sink, struct dc_stream_state *stream,
 										struct dsc_dec_dpcd_caps *dsc_caps)
@@ -6047,6 +6108,7 @@ static void apply_dsc_policy_for_stream(struct amdgpu_dm_connector *aconnector,
 	struct drm_connector *drm_connector = &aconnector->base;
 	uint32_t link_bandwidth_kbps;
 	uint32_t max_dsc_target_bpp_limit_override = 0;
+	struct dc *dc = sink->ctx->dc;
 
 	link_bandwidth_kbps = dc_link_bandwidth_kbps(aconnector->dc_link,
 							dc_link_get_link_cap(aconnector->dc_link));
@@ -6059,7 +6121,12 @@ static void apply_dsc_policy_for_stream(struct amdgpu_dm_connector *aconnector,
 	dc_dsc_policy_set_enable_dsc_when_not_needed(
 		aconnector->dsc_settings.dsc_force_enable == DSC_CLK_FORCE_ENABLE);
 
-	if (aconnector->dc_link && sink->sink_signal == SIGNAL_TYPE_DISPLAY_PORT) {
+	if (aconnector->dc_link && sink->sink_signal == SIGNAL_TYPE_EDP && !dc->debug.disable_dsc_edp &&
+	    dc->caps.edp_dsc_support && aconnector->dsc_settings.dsc_force_enable != DSC_CLK_FORCE_DISABLE) {
+
+		apply_dsc_policy_for_edp(aconnector, sink, stream, dsc_caps, max_dsc_target_bpp_limit_override);
+
+	} else if (aconnector->dc_link && sink->sink_signal == SIGNAL_TYPE_DISPLAY_PORT) {
 
 		if (dc_dsc_compute_config(aconnector->dc_link->ctx->dc->res_pool->dscs[0],
 						dsc_caps,
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
index c200e07d2fb2..84bcbf0c06fc 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
@@ -584,7 +584,7 @@ bool dm_helpers_dp_write_dsc_enable(
 		ret = drm_dp_dpcd_write(aconnector->dsc_aux, DP_DSC_ENABLE, &enable_dsc, 1);
 	}
 
-	if (stream->signal == SIGNAL_TYPE_DISPLAY_PORT) {
+	if (stream->signal == SIGNAL_TYPE_DISPLAY_PORT || SIGNAL_TYPE_EDP) {
 		ret = dm_helpers_dp_write_dpcd(ctx, stream->link, DP_DSC_ENABLE, &enable_dsc, 1);
 		DC_LOG_DC("Send DSC %s to sst display\n", enable_dsc ? "enable" : "disable");
 	}
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index 8a8a5aead34d..8f23c160f291 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -4792,6 +4792,8 @@ bool dc_link_should_enable_fec(const struct dc_link *link)
 			link->local_sink &&
 			link->local_sink->edid_caps.panel_patch.disable_fec) ||
 			(link->connector_signal == SIGNAL_TYPE_EDP
+				// enable FEC for EDP if DSC is supported
+				&& link->dpcd_caps.dsc_caps.dsc_basic_caps.fields.dsc_support.DSC_SUPPORT == false
 				))
 		is_fec_disable = true;
 
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index b21f61e89cba..2910188ba514 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -3346,6 +3346,148 @@ bool decide_edp_link_settings(struct dc_link *link, struct dc_link_settings *lin
 	return false;
 }
 
+static bool decide_edp_link_settings_with_dsc(struct dc_link *link,
+		struct dc_link_settings *link_setting,
+		uint32_t req_bw,
+		enum dc_link_rate max_link_rate)
+{
+	struct dc_link_settings initial_link_setting;
+	struct dc_link_settings current_link_setting;
+	uint32_t link_bw;
+
+	unsigned int policy = 0;
+
+	policy = link->ctx->dc->debug.force_dsc_edp_policy;
+	if (max_link_rate == LINK_RATE_UNKNOWN)
+		max_link_rate = link->verified_link_cap.link_rate;
+	/*
+	 * edp_supported_link_rates_count is only valid for eDP v1.4 or higher.
+	 * Per VESA eDP spec, "The DPCD revision for eDP v1.4 is 13h"
+	 */
+	if ((link->dpcd_caps.dpcd_rev.raw < DPCD_REV_13 ||
+			link->dpcd_caps.edp_supported_link_rates_count == 0)) {
+		/* for DSC enabled case, we search for minimum lane count */
+		memset(&initial_link_setting, 0, sizeof(initial_link_setting));
+		initial_link_setting.lane_count = LANE_COUNT_ONE;
+		initial_link_setting.link_rate = LINK_RATE_LOW;
+		initial_link_setting.link_spread = LINK_SPREAD_DISABLED;
+		initial_link_setting.use_link_rate_set = false;
+		initial_link_setting.link_rate_set = 0;
+		current_link_setting = initial_link_setting;
+		if (req_bw > dc_link_bandwidth_kbps(link, &link->verified_link_cap))
+			return false;
+
+		/* search for the minimum link setting that:
+		 * 1. is supported according to the link training result
+		 * 2. could support the b/w requested by the timing
+		 */
+		while (current_link_setting.link_rate <=
+				max_link_rate) {
+			link_bw = dc_link_bandwidth_kbps(
+					link,
+					&current_link_setting);
+			if (req_bw <= link_bw) {
+				*link_setting = current_link_setting;
+				return true;
+			}
+			if (policy) {
+				/* minimize lane */
+				if (current_link_setting.link_rate < max_link_rate) {
+					current_link_setting.link_rate =
+							increase_link_rate(
+									current_link_setting.link_rate);
+				} else {
+					if (current_link_setting.lane_count <
+									link->verified_link_cap.lane_count) {
+						current_link_setting.lane_count =
+								increase_lane_count(
+										current_link_setting.lane_count);
+						current_link_setting.link_rate = initial_link_setting.link_rate;
+					} else
+						break;
+				}
+			} else {
+				/* minimize link rate */
+				if (current_link_setting.lane_count <
+						link->verified_link_cap.lane_count) {
+					current_link_setting.lane_count =
+							increase_lane_count(
+									current_link_setting.lane_count);
+				} else {
+					current_link_setting.link_rate =
+							increase_link_rate(
+									current_link_setting.link_rate);
+					current_link_setting.lane_count =
+							initial_link_setting.lane_count;
+				}
+			}
+		}
+		return false;
+	}
+
+	/* if optimize edp link is supported */
+	memset(&initial_link_setting, 0, sizeof(initial_link_setting));
+	initial_link_setting.lane_count = LANE_COUNT_ONE;
+	initial_link_setting.link_rate = link->dpcd_caps.edp_supported_link_rates[0];
+	initial_link_setting.link_spread = LINK_SPREAD_DISABLED;
+	initial_link_setting.use_link_rate_set = true;
+	initial_link_setting.link_rate_set = 0;
+	current_link_setting = initial_link_setting;
+
+	/* search for the minimum link setting that:
+	 * 1. is supported according to the link training result
+	 * 2. could support the b/w requested by the timing
+	 */
+	while (current_link_setting.link_rate <=
+			max_link_rate) {
+		link_bw = dc_link_bandwidth_kbps(
+				link,
+				&current_link_setting);
+		if (req_bw <= link_bw) {
+			*link_setting = current_link_setting;
+			return true;
+		}
+		if (policy) {
+			/* minimize lane */
+			if (current_link_setting.link_rate_set <
+					link->dpcd_caps.edp_supported_link_rates_count
+					&& current_link_setting.link_rate < max_link_rate) {
+				current_link_setting.link_rate_set++;
+				current_link_setting.link_rate =
+					link->dpcd_caps.edp_supported_link_rates[current_link_setting.link_rate_set];
+			} else {
+				if (current_link_setting.lane_count < link->verified_link_cap.lane_count) {
+					current_link_setting.lane_count =
+							increase_lane_count(
+									current_link_setting.lane_count);
+					current_link_setting.link_rate_set = initial_link_setting.link_rate_set;
+					current_link_setting.link_rate =
+						link->dpcd_caps.edp_supported_link_rates[current_link_setting.link_rate_set];
+				} else
+					break;
+			}
+		} else {
+			/* minimize link rate */
+			if (current_link_setting.lane_count <
+					link->verified_link_cap.lane_count) {
+				current_link_setting.lane_count =
+						increase_lane_count(
+								current_link_setting.lane_count);
+			} else {
+				if (current_link_setting.link_rate_set < link->dpcd_caps.edp_supported_link_rates_count) {
+					current_link_setting.link_rate_set++;
+					current_link_setting.link_rate =
+						link->dpcd_caps.edp_supported_link_rates[current_link_setting.link_rate_set];
+					current_link_setting.lane_count =
+						initial_link_setting.lane_count;
+				} else
+					break;
+			}
+		}
+	}
+	return false;
+}
+
 static bool decide_mst_link_settings(const struct dc_link *link, struct dc_link_settings *link_setting)
 {
 	*link_setting = link->verified_link_cap;
@@ -3380,7 +3522,25 @@ void decide_link_settings(struct dc_stream_state *stream,
 		if (decide_mst_link_settings(link, link_setting))
 			return;
 	} else if (link->connector_signal == SIGNAL_TYPE_EDP) {
-		if (decide_edp_link_settings(link, link_setting, req_bw))
+		/* enable edp link optimization for DSC eDP case */
+		if (stream->timing.flags.DSC) {
+			enum dc_link_rate max_link_rate = LINK_RATE_UNKNOWN;
+
+			if (link->ctx->dc->debug.force_dsc_edp_policy) {
+				/* calculate link max link rate cap*/
+				struct dc_link_settings tmp_link_setting;
+				struct dc_crtc_timing tmp_timing = stream->timing;
+				uint32_t orig_req_bw;
+
+				tmp_link_setting.link_rate = LINK_RATE_UNKNOWN;
+				tmp_timing.flags.DSC = 0;
+				orig_req_bw = dc_bandwidth_in_kbps_from_timing(&tmp_timing);
+				decide_edp_link_settings(link, &tmp_link_setting, orig_req_bw);
+				max_link_rate = tmp_link_setting.link_rate;
+			}
+			if (decide_edp_link_settings_with_dsc(link, link_setting, req_bw, max_link_rate))
+				return;
+		} else if (decide_edp_link_settings(link, link_setting, req_bw))
 			return;
 	} else if (decide_dp_link_settings(link, link_setting, req_bw))
 		return;
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 2bebc52c8ed9..764663df7887 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -188,6 +188,7 @@ struct dc_caps {
 #if defined(CONFIG_DRM_AMD_DC_DCN)
 	bool dp_hpo;
 #endif
+	bool edp_dsc_support;
 	bool vbios_lttpr_aware;
 	bool vbios_lttpr_enable;
 };
@@ -667,6 +668,8 @@ struct dc_debug_options {
 	bool validate_dml_output;
 	bool enable_dmcub_surface_flip;
 	bool usbc_combo_phy_reset_wa;
+	bool disable_dsc_edp;
+	unsigned int  force_dsc_edp_policy;
 	bool enable_dram_clock_change_one_display_vactive;
 #if defined(CONFIG_DRM_AMD_DC_DCN)
 	/* TODO - remove once tested */
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c b/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
index 60b2ccffaf90..87ed48d5530d 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
@@ -329,6 +329,7 @@ static bool dmub_psr_copy_settings(struct dmub_psr *dmub,
 	copy_settings_data->fec_enable_delay_in100us = link->dc->debug.fec_enable_delay_in100us;
 	copy_settings_data->cmd_version =  DMUB_CMD_PSR_CONTROL_VERSION_1;
 	copy_settings_data->panel_inst = panel_inst;
+	copy_settings_data->dsc_enable_status = (pipe_ctx->stream->timing.flags.DSC == 1);
 
 	if (link->fec_state == dc_link_fec_enabled &&
 		(!memcmp(link->dpcd_caps.sink_dev_id_str, DP_SINK_DEVICE_STR_ID_1,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
index a7aeb236a884..6460fab496f6 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
@@ -2193,6 +2193,7 @@ static bool dcn31_resource_construct(
 	dc->caps.post_blend_color_processing = true;
 	dc->caps.force_dp_tps4_for_cp2520 = true;
 	dc->caps.dp_hpo = true;
+	dc->caps.edp_dsc_support = true;
 	dc->caps.extended_aux_timeout_support = true;
 	dc->caps.dmcub_support = true;
 	dc->caps.is_apu = true;
diff --git a/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c b/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c
index 2d0f1f4a8fff..9c74564cbd8d 100644
--- a/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c
+++ b/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c
@@ -455,6 +455,7 @@ static bool intersect_dsc_caps(
 	if (pixel_encoding == PIXEL_ENCODING_YCBCR422 || pixel_encoding == PIXEL_ENCODING_YCBCR420)
 		dsc_common_caps->bpp_increment_div = min(dsc_common_caps->bpp_increment_div, (uint32_t)8);
 
+	dsc_common_caps->edp_sink_max_bits_per_pixel = dsc_sink_caps->edp_max_bits_per_pixel;
 	dsc_common_caps->is_dp = dsc_sink_caps->is_dp;
 	return true;
 }
@@ -513,6 +514,13 @@ static bool decide_dsc_bandwidth_range(
 			range->min_target_bpp_x16 = preferred_bpp_x16;
 		}
 	}
+	/* TODO - make this value generic to all signal types */
+	else if (dsc_caps->edp_sink_max_bits_per_pixel) {
+		/* apply max bpp limitation from edp sink */
+		range->max_target_bpp_x16 = MIN(dsc_caps->edp_sink_max_bits_per_pixel,
+				max_bpp_x16);
+		range->min_target_bpp_x16 = min_bpp_x16;
+	}
 	else {
 		range->max_target_bpp_x16 = max_bpp_x16;
 		range->min_target_bpp_x16 = min_bpp_x16;
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/dsc.h b/drivers/gpu/drm/amd/display/dc/inc/hw/dsc.h
index f94135c6e3c2..0c83e79d3ce3 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/dsc.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/dsc.h
@@ -88,6 +88,7 @@ struct dsc_enc_caps {
 	int32_t max_total_throughput_mps; /* Maximum total throughput with all the slices combined */
 	int32_t max_slice_width;
 	uint32_t bpp_increment_div; /* bpp increment divisor, e.g. if 16, it's 1/16th of a bit */
+	uint32_t edp_sink_max_bits_per_pixel;
 	bool is_dp;
 };
 
diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index 93631b0db881..ba30ab11b2ae 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -1550,10 +1550,14 @@ struct dmub_cmd_psr_copy_settings_data {
 	 * Currently the support is only for 0 or 1
 	 */
 	uint8_t panel_inst;
+	/*
+	 * DSC enable status in driver
+	 */
+	uint8_t dsc_enable_status;
 	/**
-	 * Explicit padding to 4 byte boundary.
+	 * Explicit padding to 3 byte boundary.
 	 */
-	uint8_t pad3[4];
+	uint8_t pad3[3];
 };
 
 /**
diff --git a/drivers/gpu/drm/amd/display/include/ddc_service_types.h b/drivers/gpu/drm/amd/display/include/ddc_service_types.h
index 85b25e684464..a2b80514d83e 100644
--- a/drivers/gpu/drm/amd/display/include/ddc_service_types.h
+++ b/drivers/gpu/drm/amd/display/include/ddc_service_types.h
@@ -35,6 +35,7 @@
 #define DP_BRANCH_DEVICE_ID_00E04C 0x00E04C
 #define DP_BRANCH_DEVICE_ID_006037 0x006037
 
+#define DP_DEVICE_ID_38EC11 0x38EC11
 enum ddc_result {
 	DDC_RESULT_UNKNOWN = 0,
 	DDC_RESULT_SUCESSFULL,
-- 
2.25.1

