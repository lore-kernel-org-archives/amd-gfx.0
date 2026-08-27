Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEB30C61DCD
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Aug 2026 12:47:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8928210EFFD;
	Thu, 27 Aug 2026 12:47:34 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B8FD10E34B
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Aug 2026 01:08:15 +0000 (UTC)
X-UUID: c40d9438a1b311f19a56ed5b684f684d-20260827
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19, REQID:96c0cc05-3e7b-441c-b281-c055d2eb5c28, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
 :release,TS:25
X-CID-META: VersionHash:7db8b62, CLOUDID:6fc1603edcbcc9bb94a20c64b10ec073,
 BulkI
 D:nil,BulkQuantity:0,SF:102|850|865|898,TC:nil,Content:0|15|50,EDM:5,IP:ni
 l,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
 :1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: c40d9438a1b311f19a56ed5b684f684d-20260827
X-User: yanglinlin@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
 (envelope-from <yanglinlin@kylinos.cn>)
 (Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
 with ESMTP id 910434891; Thu, 27 Aug 2026 09:08:08 +0800
From: Linlin Yang <yanglinlin@kylinos.cn>
To: harry.wentland@amd.com
Cc: amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Linlin Yang <yanglinlin@kylinos.cn>
Subject: [PATCH] drm/amd/display: fix misspelling of "overridden"
Date: Thu, 27 Aug 2026 09:08:02 +0800
Message-Id: <20260827010802.56422-1-yanglinlin@kylinos.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 27 Aug 2026 12:47:25 +0000
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

Fix misspelling of "overridden" (missing a 'd') in comments.
No functional change.

Signed-off-by: Linlin Yang <yanglinlin@kylinos.cn>
---
 .../gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c    | 2 +-
 .../gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c    | 2 +-
 .../amd/display/dc/link/protocols/link_edp_panel_control.c    | 4 ++--
 drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c               | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
index 33b5136f7ce3..75bdad22bf69 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
@@ -1805,7 +1805,7 @@ static void DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerforman
 	v->DISPCLKWithRamping = 0;
 	v->DISPCLKWithoutRamping = 0;
 	v->GlobalDPPCLK = 0.0;
-	/* DAL custom code: need to update ReturnBW in case min dcfclk is overriden */
+	/* DAL custom code: need to update ReturnBW in case min dcfclk is overridden */
 	v->IdealSDPPortBandwidthPerState[v->VoltageLevel][v->maxMpcComb] = dml_min3(
 			v->ReturnBusWidth * v->DCFCLK,
 			v->DRAMSpeedPerState[v->VoltageLevel] * v->NumberOfChannels * v->DRAMChannelWidth,
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c b/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c
index 8064c4b3fd25..3f62ea493787 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c
@@ -2045,7 +2045,7 @@ static void DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerforman
 	v->DISPCLKWithRamping = 0;
 	v->DISPCLKWithoutRamping = 0;
 	v->GlobalDPPCLK = 0.0;
-	/* DAL custom code: need to update ReturnBW in case min dcfclk is overriden */
+	/* DAL custom code: need to update ReturnBW in case min dcfclk is overridden */
 	{
 	double IdealFabricAndSDPPortBandwidthPerState = dml_min(
 			v->ReturnBusWidth * v->DCFCLKState[v->VoltageLevel][v->maxMpcComb],
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
index 16951a9550f2..d3fe6e024891 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
@@ -108,7 +108,7 @@ enum dp_panel_mode dp_get_panel_mode(struct dc_link *link)
 			/* alternate scrambler reset is required for Travis
 			 * for the case when external chip does not
 			 * provide sink device id, alternate scrambler
-			 * scheme will  be overriden later by querying
+			 * scheme will  be overridden later by querying
 			 * Encoder features
 			 */
 			if (strncmp(
@@ -124,7 +124,7 @@ enum dp_panel_mode dp_get_panel_mode(struct dc_link *link)
 			/* alternate scrambler reset is required for NUTMEG
 			 * for the case when external chip does not provide
 			 * sink device id, alternate scrambler scheme will
-			 * be overriden later by querying Encoder feature
+			 * be overridden later by querying Encoder feature
 			 */
 			if (strncmp(link->dpcd_caps.branch_dev_name,
 				DP_VGA_LVDS_CONVERTER_ID_3,
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
index 204375f1eff8..587d26c742cd 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
@@ -584,7 +584,7 @@ static bool dmub_srv_hw_setup(struct dmub_srv *dmub, enum dmub_asic asic)
 		return false;
 	}
 
-	/* set default inbox type if not overriden */
+	/* set default inbox type if not overridden */
 	if (dmub->inbox_type == DMUB_CMD_INTERFACE_DEFAULT) {
 		if (default_inbox_type != DMUB_CMD_INTERFACE_DEFAULT) {
 			/* use default inbox type as specified by DCN rev */
-- 
2.25.1

