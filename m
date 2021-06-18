Return-Path: <SRS0=S25v=LM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0548BC48BDF
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Jun 2021 18:38:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5CA2613E2
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Jun 2021 18:38:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5CA2613E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4225C6EA6A;
	Fri, 18 Jun 2021 18:38:12 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2086.outbound.protection.outlook.com [40.107.94.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B4A0D6EA6A
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Jun 2021 18:38:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aRU2gAR1iuZsM/y9fRszrj0EKQmo1eDwqvcJNCW6wpcF8sBq2SyUgqZfNF8ZPkGYGvUPopG54vjZvZQo/j44ckVOPNqEVh/DPEUfywPc+eXfkBZOGE1jw5lFKpJ+phPJw5P0TcGcH6xoBwLY4FPXMCd1wdXNv2x8PfQ99fOJtHaryPo7NoVSK/E2kveyvKngkLNFLwRSVNM08Rf6PoqEyVAlAFC5N6tNy0HjTTSXtpTL3tLLlI9a/Za2GSt7siO5CqIyKnEHyphgKX+BgxTiYJTq+rQjW9N6ykiX7qOj50+h81SjZZGb702sXQD1HMG46KIkHw67Wa/XC4m3SRcM1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UsbMKXQoqt12xXLfWvRtSRrRgqqzBcalu6Snnwkclko=;
 b=D0YguE4ESzTOOCftgbWYfDRuGlmNgRXAO2BPtcjSWtfoCkICnSeZpWFavaR+ozEQgQ9GjPFO9qdwrZt+CiiTNT25hM/OGRBzi3iUSN60ZRmWy8HX71PnqU3DvfwU/ZbYy/DRIO5kI06VqxpHVQuMg4yu7UqSERy02WRxNMtOc7QLWEUjAOWqs447QlJ9+FNFj2GzBCkbgRGM6uy3OCcNRYK1V3hHpnxijoM8PouLOjnWFu0I8Uf3uB0cQ5QnP14yfRdS1vFb941uilMbHshzyf9sBWrNc8A0Sf4Zlk+Y/9IZACib/q3CZCAuzrgoo+d1aOFOJTzGUcycCGqNGfsvGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UsbMKXQoqt12xXLfWvRtSRrRgqqzBcalu6Snnwkclko=;
 b=qUnMc16cJf59QXsBx1vCKgi/Xc2tGdIAOpMdAKmVDfVTB/OdIP9TmSDBbV8jV54FoqL+2MpsFDKUrsecHOLJEIjeVE+zkwKmjDncufs8QpVRDwPitURJ2wNz287FtXP9e6Ui1VysalH4KX4UybUJFeQM9+jE4ZRYhrJnPYldt+Q=
Received: from MWHPR1601CA0001.namprd16.prod.outlook.com
 (2603:10b6:300:da::11) by MWHPR1201MB2478.namprd12.prod.outlook.com
 (2603:10b6:300:e5::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.21; Fri, 18 Jun
 2021 18:38:08 +0000
Received: from CO1NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:da:cafe::b7) by MWHPR1601CA0001.outlook.office365.com
 (2603:10b6:300:da::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.16 via Frontend
 Transport; Fri, 18 Jun 2021 18:38:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT003.mail.protection.outlook.com (10.13.175.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4242.16 via Frontend Transport; Fri, 18 Jun 2021 18:38:07 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Fri, 18 Jun
 2021 13:38:06 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Fri, 18 Jun
 2021 11:38:06 -0700
Received: from bindu-HP-EliteDesk-705-G4-MT.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2242.4
 via Frontend Transport; Fri, 18 Jun 2021 13:38:05 -0500
From: Bindu Ramamurthy <bindu.r@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 09/12] drm/amd/display: Revert "Guard ASSR with internal
 display flag"
Date: Fri, 18 Jun 2021 14:37:33 -0400
Message-ID: <20210618183736.647268-9-bindu.r@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ffe6d32f-a1c3-4131-0f1d-08d9328837b6
X-MS-TrafficTypeDiagnostic: MWHPR1201MB2478:
X-Microsoft-Antispam-PRVS: <MWHPR1201MB2478674DE4938D8C6779B70BF50D9@MWHPR1201MB2478.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:949;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0ZYOqpC4Y2wwLnVPgzSXZjrF3tb6VTXHYz0Q+0V7d92ECRO8ZfamxeTqqOQOy9FYjeOR481HEahFOZMT8aGB+7IzKdc3QE70QLlLpFZ14OHPc+rLDudG77IYKJ+bqeZaYct4PDzAKE0J2pqOYKeUGaKhDdr/XrSzEe8x53pZCgHvtMDLzgDJxsA40doKY+mtEA4AjdGD1yOv/G7+OgQHJ+lw1SnkmfmQo9r5saz/1GEDHskQ9iKWSFPZpptwrD2itJWgUciRLY+WIdVjCpRX1uBV1kJ6D8X4MiqeMrRvBk/J42MwJZfXupodGUpDSmOd5AgtCFoO5p7WcxjfkZfSnhP5cRQ0m6K01uuNX2soA0MlRHX/uR8TbjQafmnij3U6q1Mhdvzbdt0m6EOJ/kbeSzaTW8PhX6ZdHDKDfMRZQ2XQXSrdIWE0KZTbEYntkFk9S/ZJ9elwxPPknsnE+d3HhIFcHNFBGf9qGqH93LMlMcCJDamjCK29AjBs2HUsx1HRjPCURWOXsAwT2Jg3osD9DbIsVeCuhtYVZncrfbGKUz3V+9S23UM36HZck7sZ3PPeQ38R3rtAj+5ffaQdcyItrA0btrGJbQZbEC8QmFimI2UkYqeE+ekLejW0AO6gbdWX9K2bLTbGKSP2Ul/FDvCgATdifiRnQdeUJC4MtHqe4ns3sBDpMDKHbuNEsvvJZLgw
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(376002)(346002)(136003)(36840700001)(46966006)(336012)(82310400003)(70206006)(70586007)(186003)(86362001)(426003)(478600001)(7696005)(6666004)(26005)(36756003)(5660300002)(356005)(8936002)(8676002)(6916009)(2906002)(4326008)(36860700001)(1076003)(316002)(2616005)(54906003)(81166007)(82740400003)(47076005)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2021 18:38:07.9636 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ffe6d32f-a1c3-4131-0f1d-08d9328837b6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB2478
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
Cc: Stylon Wang <stylon.wang@amd.com>,
 Wesley Chalmers <Wesley.Chalmers@amd.com>, Eryk.Brol@amd.com,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com,
 Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Stylon Wang <stylon.wang@amd.com>

[Why]
1. Previous patch regresses on some embedded panels.
2. Project coreboot doesn't support passing of internal display flag.

[How]
This reverts "Guard ASSR with internal display flag" commit.

Signed-off-by: Stylon Wang <stylon.wang@amd.com>
Reviewed-by: Wesley Chalmers <Wesley.Chalmers@amd.com>
Acked-by: Bindu Ramamurthy <bindu.r@amd.com>
---
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  | 58 ++++++-------------
 1 file changed, 17 insertions(+), 41 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index 4326ac577756..10b749ef7fbb 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -1760,42 +1760,6 @@ enum link_training_result dc_link_dp_perform_link_training(
 	return status;
 }
 
-static enum dp_panel_mode try_enable_assr(struct dc_stream_state *stream)
-{
-	struct dc_link *link = stream->link;
-	enum dp_panel_mode panel_mode = dp_get_panel_mode(link);
-#ifdef CONFIG_DRM_AMD_DC_HDCP
-	struct cp_psp *cp_psp = &stream->ctx->cp_psp;
-#endif
-
-	/* ASSR must be supported on the panel */
-	if (panel_mode == DP_PANEL_MODE_DEFAULT)
-		return panel_mode;
-
-	/* eDP or internal DP only */
-	if (link->connector_signal != SIGNAL_TYPE_EDP &&
-		!(link->connector_signal == SIGNAL_TYPE_DISPLAY_PORT &&
-		 link->is_internal_display))
-		return DP_PANEL_MODE_DEFAULT;
-
-#ifdef CONFIG_DRM_AMD_DC_HDCP
-	if (cp_psp && cp_psp->funcs.enable_assr) {
-		if (!cp_psp->funcs.enable_assr(cp_psp->handle, link)) {
-			/* since eDP implies ASSR on, change panel
-			 * mode to disable ASSR
-			 */
-			panel_mode = DP_PANEL_MODE_DEFAULT;
-		}
-	} else
-		panel_mode = DP_PANEL_MODE_DEFAULT;
-
-#else
-	/* turn off ASSR if the implementation is not compiled in */
-	panel_mode = DP_PANEL_MODE_DEFAULT;
-#endif
-	return panel_mode;
-}
-
 bool perform_link_training_with_retries(
 	const struct dc_link_settings *link_setting,
 	bool skip_video_pattern,
@@ -1808,7 +1772,7 @@ bool perform_link_training_with_retries(
 	uint8_t delay_between_attempts = LINK_TRAINING_RETRY_DELAY;
 	struct dc_stream_state *stream = pipe_ctx->stream;
 	struct dc_link *link = stream->link;
-	enum dp_panel_mode panel_mode;
+	enum dp_panel_mode panel_mode = dp_get_panel_mode(link);
 	struct link_encoder *link_enc;
 	enum link_training_result status = LINK_TRAINING_CR_FAIL_LANE0;
 	struct dc_link_settings current_setting = *link_setting;
@@ -1845,11 +1809,23 @@ bool perform_link_training_with_retries(
 			msleep(delay_dp_power_up_in_ms);
 		}
 
-		panel_mode = try_enable_assr(stream);
+#ifdef CONFIG_DRM_AMD_DC_HDCP
+		if (panel_mode == DP_PANEL_MODE_EDP) {
+			struct cp_psp *cp_psp = &stream->ctx->cp_psp;
+
+			if (cp_psp && cp_psp->funcs.enable_assr) {
+				if (!cp_psp->funcs.enable_assr(cp_psp->handle, link)) {
+					/* since eDP implies ASSR on, change panel
+					 * mode to disable ASSR
+					 */
+					panel_mode = DP_PANEL_MODE_DEFAULT;
+				}
+			} else
+				panel_mode = DP_PANEL_MODE_DEFAULT;
+		}
+#endif
+
 		dp_set_panel_mode(link, panel_mode);
-		DC_LOG_DETECTION_DP_CAPS("Link: %d ASSR enabled: %d\n",
-			 link->link_index,
-			 panel_mode != DP_PANEL_MODE_DEFAULT);
 
 		if (link->aux_access_disabled) {
 			dc_link_dp_perform_link_training_skip_aux(link, &current_setting);
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
