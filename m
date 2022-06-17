Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 657CBCCA479
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Jun 2022 19:35:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F406410F2DD;
	Fri, 17 Jun 2022 19:35:43 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2056.outbound.protection.outlook.com [40.107.236.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2237410F2A4
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Jun 2022 19:35:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JNqfb35YIop8vGFrNDz5pvuvI99PD1ov3nXdjo78KRaC688ok4JRPA2TLm4LDMx/3ukFdQzN16sf7cEMeoaePWK+YTG1DM6Pm4YF04gDvqw6ey1+d9uD8DhP4JZpQi279pcdAz8dO0dMy7WGhd8OkmaWrkySZ7LWCXtSyRp38zMoErOg81C82W+mCpDl6iTC4EOku2/VZSrAMDks3vZNYSnvd/YCB/MHVG47DvGrGi5uKed03RrQZP+kcVlt10AR/4VwZthSOO9S/T8xQwKcxJVGNt0aFiAcMdnAm0SP6t0SAdQofWmLeB89599CsPVhDMuydJy/+5r128hgHtZVlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rTBgszsJh+/huYTes99H+Y82gDiv+MbqVcO4lgOZ5As=;
 b=O0A0ayXjrWOxfowUYRNHEiBbjsypJYMW5rlh2CAeouKiJ4OOwllC1+rz/FDsos1lQ5B3AbzbjhxTgEwKkwpdOaOK7ISQm+Qc1XylW58ihUFGyyR/JT+IB/g2RI6eXvl6Gqa/wbhGnvnvIdtHJUHF+JMv9hkq4FIUIToRoYRiNufwbLj2y0x9toh1Gpw5z5vl42oiQyVy7FCtmLPqw14ZYnFM2iSA+XqSkJL+Lx9MZrt7iHfPTP/9iapRXXEUl6m+x5X9lMey3wdFtB8cHBbzK48bKkJeuoftWTq1OXR0rNRMbYPr1Vc/TB6JcJMNOOgZXTWs48wbt0kBWpeMWyHZIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rTBgszsJh+/huYTes99H+Y82gDiv+MbqVcO4lgOZ5As=;
 b=4i6c781vno4r6o2xTriBDo/+RS/T6gUR9AmjJ0rXnVCfVydEI4/PeOrMwCemXZqfUMl2hFMNpBJrnCkn42BN3/fJGJmvR6SswoT1nrzVwMmDSQSqSeN0F60dt6k4WEzb1dlGHh1uo/ZmiUC3VJ/5uXRowA4szXW4tVr16bO3SME=
Received: from BN6PR14CA0046.namprd14.prod.outlook.com (2603:10b6:404:13f::32)
 by DM5PR12MB1498.namprd12.prod.outlook.com (2603:10b6:4:f::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5353.16; Fri, 17 Jun 2022 19:35:39 +0000
Received: from BN8NAM11FT021.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:13f:cafe::12) by BN6PR14CA0046.outlook.office365.com
 (2603:10b6:404:13f::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.20 via Frontend
 Transport; Fri, 17 Jun 2022 19:35:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT021.mail.protection.outlook.com (10.13.177.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5353.14 via Frontend Transport; Fri, 17 Jun 2022 19:35:39 +0000
Received: from atma2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 17 Jun
 2022 14:35:37 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 02/31] drm/amd/display: Revert "drm/amd/display: Add flag to
 detect dpms force off during HPD"
Date: Fri, 17 Jun 2022 15:34:43 -0400
Message-ID: <20220617193512.3471076-3-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220617193512.3471076-1-Rodrigo.Siqueira@amd.com>
References: <20220617193512.3471076-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 88e62be5-b0b3-4480-00e0-08da50988f19
X-MS-TrafficTypeDiagnostic: DM5PR12MB1498:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB149825EE25BD3DCB85E1D1C098AF9@DM5PR12MB1498.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IZngaA/5GIUxK2LTqhHoB05zQbUIeKGiGLkNN4wMRIX6KdVXEnz/mUFGW2IcNd+RJiJtyzi3OR0iikxavKaZANTgnO9x5uMqXnrAsdL2DgwjDhJNK3VZ45wsDNkUhMnpnJ4ZbkB+qriYcaFs2OHYbV2vkt2UI2+XCvRII+GfVr50SWJniKQQOUkUj9LUVztnp7QsVGlx6LHyJxkjwLZ6FmnTNBtsJQg1zKkhz3Mp+oPBpv5kVfLYQefrxfBATDqdV2zk6tiq/rpccjtoCv3qqgsWTcbZpZ4FIuBv0whdddhiulxx1w+acA7XiACcnipxTDs/G6isvBZSxFs6JspsiyFBL71g08Ii6ui7OC+AhdUR+bVaNdbuPkBnQmc6FjpEVVXfbhLE9ky7jJ84ubc4f6ornOf0EGkKFVVmiD1uDeIfrQUX1o11y8f72y/RnVOFiG9b9QdDhM3mecpDALUDMpV+f0C1DeQj/Bwf0qR0+oNvez0J3fegFSmOduz4n9nGGRlgUcH207Wm19RXnIm8d/dUacRL9dJySMaIHESpjWXfEt3kEvQEhqWF4HWdg1PHwO2cQdpFb11ezy9iOZ6tBMZ/4G7b4omjoFN/5Lpp2OePSG7+Ahup0OmK0G+kUIegG8uZxJnfoqmrnRh7rbwVIFgmbTeU6BtWPrxtZZSWWna8kydwUtk+0bsxlU8PDQi1EzX39BOfIASBrDOgGgYbOQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(46966006)(40470700004)(36840700001)(4326008)(7696005)(316002)(1076003)(70586007)(498600001)(8676002)(70206006)(8936002)(6916009)(26005)(2616005)(5660300002)(356005)(81166007)(6666004)(86362001)(36756003)(36860700001)(40460700003)(47076005)(426003)(336012)(2906002)(186003)(16526019)(54906003)(83380400001)(82310400005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2022 19:35:39.1753 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 88e62be5-b0b3-4480-00e0-08da50988f19
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT021.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1498
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
 solomon.chiu@amd.com, jerry.zuo@amd.com, Aurabindo.Pillai@amd.com,
 hamza.mahfooz@amd.com, Wayne Lin <Wayne.Lin@amd.com>,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wayne Lin <Wayne.Lin@amd.com>

This reverts commit 3c4d55c9b9becedd8d31a7c96783a364533713ab.

The reverted commit was trying to fix side effect brought by commit:
"3c4d55c9b9be drm/amd/display: turn DPMS off on connector unplug"

However,
* This reverted commit will have mst case never call dm_set_dpms_off()
  which conflicts the idea of original commit: commit 3c4d55c9b9be
  ("drm/amd/display: turn DPMS off on connector unplug") That's due to
  dm_crtc_state is always null since the input parameter aconnector is the
  root device (source) of mst topology.  It's not an end stream sink
  within the mst topology.
* Setting dpms off should be triggered by usermode. Besdies, it seems
  usermode does release relevant resource for mst & non-mst case when
  unplug connecotr now. Which means we no longer need both commits now:
  - commit 3c4d55c9b9be ("drm/amd/display: turn DPMS off on connector
    unplug")
  - commit 035f54969bb2 ("drm/amd/display: Add flag to detect dpms
    force off during HPD")

Reviewed-by: Aurabindo Jayamohanan Pillai <Aurabindo.Pillai@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Acked-by: Lyude Paul <lyude@redhat.com>
Signed-off-by: Wayne Lin <Wayne.Lin@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 19 ++++++-------------
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  2 --
 .../amd/display/amdgpu_dm/amdgpu_dm_hdcp.c    | 16 +++++-----------
 3 files changed, 11 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index c2bc7db85d7e..beba783dd6ef 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -2582,7 +2582,7 @@ static void dm_gpureset_commit_state(struct dc_state *dc_state,
 	return;
 }
 
-static void dm_set_dpms_off(struct dc_link *link, struct dm_crtc_state *acrtc_state)
+static void dm_set_dpms_off(struct dc_link *link)
 {
 	struct dc_stream_state *stream_state;
 	struct amdgpu_dm_connector *aconnector = link->priv;
@@ -2603,7 +2603,6 @@ static void dm_set_dpms_off(struct dc_link *link, struct dm_crtc_state *acrtc_st
 	}
 
 	stream_update.stream = stream_state;
-	acrtc_state->force_dpms_off = true;
 	dc_commit_updates_for_stream(stream_state->ctx->dc, NULL, 0,
 				     stream_state, &stream_update,
 				     stream_state->ctx->dc->current_state);
@@ -3060,16 +3059,13 @@ static void handle_hpd_irq_helper(struct amdgpu_dm_connector *aconnector)
 	struct drm_device *dev = connector->dev;
 	enum dc_connection_type new_connection_type = dc_connection_none;
 	struct amdgpu_device *adev = drm_to_adev(dev);
+#ifdef CONFIG_DRM_AMD_DC_HDCP
 	struct dm_connector_state *dm_con_state = to_dm_connector_state(connector->state);
-	struct dm_crtc_state *dm_crtc_state = NULL;
+#endif
 
 	if (adev->dm.disable_hpd_irq)
 		return;
 
-	if (dm_con_state->base.state && dm_con_state->base.crtc)
-		dm_crtc_state = to_dm_crtc_state(drm_atomic_get_crtc_state(
-					dm_con_state->base.state,
-					dm_con_state->base.crtc));
 	/*
 	 * In case of failure or MST no need to update connector status or notify the OS
 	 * since (for MST case) MST does this in its own context.
@@ -3100,9 +3096,8 @@ static void handle_hpd_irq_helper(struct amdgpu_dm_connector *aconnector)
 
 	} else if (dc_link_detect(aconnector->dc_link, DETECT_REASON_HPD)) {
 		if (new_connection_type == dc_connection_none &&
-		    aconnector->dc_link->type == dc_connection_none &&
-		    dm_crtc_state)
-			dm_set_dpms_off(aconnector->dc_link, dm_crtc_state);
+		    aconnector->dc_link->type == dc_connection_none)
+			dm_set_dpms_off(aconnector->dc_link);
 
 		amdgpu_dm_update_connector_after_detect(aconnector);
 
@@ -6839,7 +6834,6 @@ dm_crtc_duplicate_state(struct drm_crtc *crtc)
 	state->freesync_config = cur->freesync_config;
 	state->cm_has_degamma = cur->cm_has_degamma;
 	state->cm_is_degamma_srgb = cur->cm_is_degamma_srgb;
-	state->force_dpms_off = cur->force_dpms_off;
 	state->mpo_requested = cur->mpo_requested;
 	/* TODO Duplicate dc_stream after objects are stream object is flattened */
 
@@ -9572,8 +9566,7 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
 		 * and rely on sending it from software.
 		 */
 		if (acrtc_attach->base.state->event &&
-		    acrtc_state->active_planes > 0 &&
-		    !acrtc_state->force_dpms_off) {
+		    acrtc_state->active_planes > 0) {
 			drm_crtc_vblank_get(pcrtc);
 
 			spin_lock_irqsave(&pcrtc->dev->event_lock, flags);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index 3cc5c15303e6..cbd2e8f2ae50 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -639,8 +639,6 @@ struct dm_crtc_state {
 
 	bool dsc_force_changed;
 	bool vrr_supported;
-
-	bool force_dpms_off;
 	struct mod_freesync_config freesync_config;
 	struct dc_info_packet vrr_infopacket;
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
index c76b628e6791..236a5ebab5ab 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
@@ -448,8 +448,6 @@ static void update_config(void *handle, struct cp_psp_stream_config *config)
 	struct mod_hdcp_display *display = &hdcp_work[link_index].display;
 	struct mod_hdcp_link *link = &hdcp_work[link_index].link;
 	struct drm_connector_state *conn_state;
-	struct dc_sink *sink = NULL;
-	bool link_is_hdcp14 = false;
 
 	if (config->dpms_off) {
 		hdcp_remove_display(hdcp_work, link_index, aconnector);
@@ -462,13 +460,8 @@ static void update_config(void *handle, struct cp_psp_stream_config *config)
 	display->index = aconnector->base.index;
 	display->state = MOD_HDCP_DISPLAY_ACTIVE;
 
-	if (aconnector->dc_sink)
-		sink = aconnector->dc_sink;
-	else if (aconnector->dc_em_sink)
-		sink = aconnector->dc_em_sink;
-
-	if (sink != NULL)
-		link->mode = mod_hdcp_signal_type_to_operation_mode(sink->sink_signal);
+	if (aconnector->dc_sink != NULL)
+		link->mode = mod_hdcp_signal_type_to_operation_mode(aconnector->dc_sink->sink_signal);
 
 	display->controller = CONTROLLER_ID_D0 + config->otg_inst;
 	display->dig_fe = config->dig_fe;
@@ -478,8 +471,9 @@ static void update_config(void *handle, struct cp_psp_stream_config *config)
 	link->link_enc_idx = config->link_enc_idx;
 	link->dio_output_id = config->dio_output_idx;
 	link->phy_idx = config->phy_idx;
-	if (sink)
-		link_is_hdcp14 = dc_link_is_hdcp14(aconnector->dc_link, sink->sink_signal);
+
+	link->hdcp_supported_informational = dc_link_is_hdcp14(aconnector->dc_link,
+			aconnector->dc_sink->sink_signal) ? 1 : 0;
 	link->hdcp_supported_informational = link_is_hdcp14;
 	link->dp.rev = aconnector->dc_link->dpcd_caps.dpcd_rev.raw;
 	link->dp.assr_enabled = config->assr_enabled;
-- 
2.25.1

