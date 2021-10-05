Return-Path: <SRS0=e3IM=OZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76D11C433F5
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Oct 2021 07:57:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42C8E61165
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Oct 2021 07:57:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 42C8E61165
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB3596F52F;
	Tue,  5 Oct 2021 07:57:30 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2071.outbound.protection.outlook.com [40.107.94.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F7176F52F
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Oct 2021 07:57:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=InEGRpsPYGwYqIaRWb0Df9xE0vBlaS1ddc9XSovWqdAT1/eQ5zplUsuw3LQZNtUbk97E8BBUymXWHYRrAeA6D/xybF9wduilDmPTkLLRyp2dIB7zMKQJlL8mCACOLN29/q4+uhJRHsXrLQVf68kqGyysOp3f7AHvGoBAvHBBMLgdZEMUHlHOiGPpOI22dpGz8mUXcOv82xQcE0GrNmCtmxb+v2oow0kzBdVrWLlmM2cnoM2A4eyKZqdqFJBWmuluf0UTkeNu+gAB5edVKvg1RYlcbt7hsbvoSqJxHIgTqfRPBrgDPR7hzHFxp28Cj+p/DjtgzNKlOdX2DpHusP5Zqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n53ZXRq3bJDAKl7hQ0mXYRB+u1+g/gjR15cy9RpM6Yg=;
 b=VSXQ+LYA5nKzSJxAj0VLqYXdKwjS6qC4EhsSLM9oe4yqyPg9K0LD8FcE3aErWSVAcNWFuuu3H7o6NuES8tfXsGEtnDZ0AFhQVwFFf/BhKREYX/LgCUij+USgSM7sT+JtarXWSjt3HmZCoPlPnAUeGCsRJFS6Q4WJ3j1KooutvU5A91ZjGEHdlXq20p89teB1XDMW60iAEp2ZLG2KJ4yv357t8cerOyw9bCkCaKKOOXgcfxQihARnEJezD4LJIBliuaIT/aBMBKl64/EAw79SAT1NidMlQxn6WeXu6/wwdjEGxUdsHijxnUQleth15Kj5YqKKgar+xOxOhMPkZZxKWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n53ZXRq3bJDAKl7hQ0mXYRB+u1+g/gjR15cy9RpM6Yg=;
 b=O6MSSbaX8MH4eqOYB0dXcgv+5JMImVryOFz7xBDHj4B05eQRbR1pe85jIw5kVaLbtwyTIN3SrUxlyFNVVjU1kVOo9GJAIenV9zKjfcMllXfY7rphUp+QhkEfrIjtL0o3WgcbtOJYizH62PlazoRCPh2F46OdVZTeBXF9H1e3GS0=
Received: from BN9PR03CA0165.namprd03.prod.outlook.com (2603:10b6:408:f4::20)
 by CH2PR12MB4892.namprd12.prod.outlook.com (2603:10b6:610:65::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.19; Tue, 5 Oct
 2021 07:57:26 +0000
Received: from BN8NAM11FT011.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f4:cafe::b4) by BN9PR03CA0165.outlook.office365.com
 (2603:10b6:408:f4::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.20 via Frontend
 Transport; Tue, 5 Oct 2021 07:57:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT011.mail.protection.outlook.com (10.13.176.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4566.14 via Frontend Transport; Tue, 5 Oct 2021 07:57:26 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Tue, 5 Oct 2021
 02:57:25 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Tue, 5 Oct 2021
 00:57:24 -0700
Received: from wayne-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2308.8
 via Frontend Transport; Tue, 5 Oct 2021 02:57:12 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <Harry.Wentland@amd.com>,
 <nicholas.kazlauskas@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <wayne.lin@amd.com>, <stylon.wang@amd.com>, <jude.shih@amd.com>,
 <jimmy.kizito@amd.com>, <meenakshikumar.somasundaram@amd.com>, Jimmy Kizito
 <Jimmy.Kizito@amd.com>, Jun Lei <Jun.Lei@amd.com>, Wayne Lin
 <Wayne.Lin@amd.com>
Subject: [PATCH v2 10/23] drm/amd/display: Implement DPIA link configuration
Date: Tue, 5 Oct 2021 15:51:52 +0800
Message-ID: <20211005075205.3467938-11-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211005075205.3467938-1-Wayne.Lin@amd.com>
References: <20211005075205.3467938-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 22fecd5f-278b-4d15-9e6d-08d987d5c58e
X-MS-TrafficTypeDiagnostic: CH2PR12MB4892:
X-Microsoft-Antispam-PRVS: <CH2PR12MB4892195B09D69948D021C17AFCAF9@CH2PR12MB4892.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:23;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ld8rHozc3NEaZrC72FSo2pTlqy8PsZ3Bl4p2y+ZW+UgEN5aTYfvJTI4aadQ4Reh589SS+HhEqpzKtzM9XYBnze61zOXrPKpa+UwUQVvRMB2ukK/ZWWxHa1EfYmIq6iAp/s1WxVU6hQRvTZqlFDbTNYm8AJAXASHTh80UVLguSwLDlKs16uDxfBrXTB7zT44qfejpUwtsErYNS7R6yTvT1N2RnVMx0KTvnbWJ0ma3QSdUJR4U77UR8xKApJ4NQNE30XHTH2fHQGLMQtvoBD8qL74wo3fO76P6Uok3DCz4/bFDM+jpYMG2dm/drbx0J4kbmE8sEZJ0bW5tlazLFacQAWKtI8WGJACoBMJEQ17xNuy2SgeJpIZmbzUg8hzxBV8MCEzYX9rq1/eQcPEu06Q1W+Gq/OMxPyhXcwdMEbc9dPvAtbLffB6c0yn6UL+2ScIrqevGGuXHTGlKGxW8+4ryX7coZMkGiPGWp2+F2hkcybtTFXtoj3SCJSzs6ZyYeJ74RKMfh7hgvKDw4oPsL1jFKqy4eR9Q9Et3K6C9Ma64mXBzR0rW5AIR+LW5SRzllIvRCPFoDodFK9D5VwSsa/TojhJKkPTJzgL7v/k091cVf8H8H9eLyVYFyWCvTpZWfXKl+eZkF6oLl5hdAt1xZ96qnUTMrNq2da5nwusf0zCiP05n7FQLfMi4ON3o4GS2moBdJKiY8b3O+er6G8JQZFmyyfTof+wgFqkDs4OFjPjszsk=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(508600001)(316002)(70206006)(6916009)(47076005)(54906003)(356005)(336012)(26005)(81166007)(186003)(7696005)(426003)(2616005)(2906002)(4326008)(83380400001)(82310400003)(8676002)(36756003)(36860700001)(1076003)(86362001)(70586007)(5660300002)(6666004)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2021 07:57:26.1458 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 22fecd5f-278b-4d15-9e6d-08d987d5c58e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT011.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4892
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

From: Jimmy Kizito <Jimmy.Kizito@amd.com>

[Why]
Training settings need to be applied to DPIA link at start of each
training loop. Note: FEC readiness should be configured before link
training while FEC enablement should be configured once training is
complete.

[How]
- Implement DPIA link configuration function.
- Account for dynamically assigned link encoders during link
configuration.

Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Wayne Lin <Wayne.Lin@amd.com>
Acked-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Jimmy Kizito <Jimmy.Kizito@amd.com>
---
 .../drm/amd/display/dc/core/dc_link_dpia.c    | 49 ++++++++++++++++---
 .../display/dc/dcn31/dcn31_dio_link_encoder.c |  2 +
 2 files changed, 45 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dpia.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dpia.c
index 4e9bbc9180d0..5ffaf6ca372b 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dpia.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dpia.c
@@ -29,6 +29,9 @@
 #include "dc_link.h"
 #include "dc_link_dp.h"
 
+#define DC_LOGGER \
+	link->ctx->logger
+
 enum dc_status dpcd_get_tunneling_device_data(struct dc_link *link)
 {
 	/** @todo Read corresponding DPCD region and update link caps. */
@@ -37,17 +40,51 @@ enum dc_status dpcd_get_tunneling_device_data(struct dc_link *link)
 
 /* Configure link as prescribed in link_setting; set LTTPR mode; and
  * Initialize link training settings.
+ * Abort link training if sink unplug detected.
+ *
+ * @param link DPIA link being trained.
+ * @param[in] link_setting Lane count, link rate and downspread control.
+ * @param[out] lt_settings Link settings and drive settings (voltage swing and pre-emphasis).
  */
 static enum link_training_result dpia_configure_link(struct dc_link *link,
 		const struct dc_link_settings *link_setting,
 		struct link_training_settings *lt_settings)
 {
-	enum link_training_result result;
-
-	/** @todo Fail until implemented. */
-	result = LINK_TRAINING_ABORT;
-
-	return result;
+	enum dc_status status;
+	bool fec_enable;
+
+	DC_LOG_HW_LINK_TRAINING("%s\n DPIA(%d) configuring\n - LTTPR mode(%d)\n",
+				__func__,
+				link->link_id.enum_id - ENUM_ID_1,
+				link->lttpr_mode);
+
+	dp_decide_training_settings(link,
+		link_setting,
+		lt_settings);
+
+	status = dpcd_configure_channel_coding(link, lt_settings);
+	if (status != DC_OK && !link->hpd_status)
+		return LINK_TRAINING_ABORT;
+
+	/* Configure lttpr mode */
+	status = dpcd_configure_lttpr_mode(link, lt_settings);
+	if (status != DC_OK && !link->hpd_status)
+		return LINK_TRAINING_ABORT;
+
+	/* Set link rate, lane count and spread. */
+	status = dpcd_set_link_settings(link, lt_settings);
+	if (status != DC_OK && !link->hpd_status)
+		return LINK_TRAINING_ABORT;
+
+	if (link->preferred_training_settings.fec_enable)
+		fec_enable = *link->preferred_training_settings.fec_enable;
+	else
+		fec_enable = true;
+	status = dp_set_fec_ready(link, fec_enable);
+	if (status != DC_OK && !link->hpd_status)
+		return LINK_TRAINING_ABORT;
+
+	return LINK_TRAINING_SUCCESS;
 }
 
 /* Execute clock recovery phase of link training for specified hop in display
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dio_link_encoder.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dio_link_encoder.c
index f86d4446f347..a5266d5999d7 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dio_link_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dio_link_encoder.c
@@ -428,6 +428,7 @@ void dcn31_link_encoder_enable_dp_output(
 
 		if (link) {
 			dpia_control.dpia_id = link->ddc_hw_inst;
+			dpia_control.fec_rdy = link->fec_state == dc_link_fec_ready ? 1 : 0;
 		} else {
 			DC_LOG_ERROR("%s: Failed to execute DPIA enable DMUB command.\n", __func__);
 			BREAK_TO_DEBUGGER();
@@ -469,6 +470,7 @@ void dcn31_link_encoder_enable_dp_mst_output(
 
 		if (link) {
 			dpia_control.dpia_id = link->ddc_hw_inst;
+			dpia_control.fec_rdy = link->fec_state == dc_link_fec_ready ? 1 : 0;
 		} else {
 			DC_LOG_ERROR("%s: Failed to execute DPIA enable DMUB command.\n", __func__);
 			BREAK_TO_DEBUGGER();
-- 
2.25.1

