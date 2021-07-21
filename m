Return-Path: <SRS0=ovQZ=MN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66B23C12002
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Jul 2021 04:25:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3277561019
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Jul 2021 04:25:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3277561019
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E21F76E8EA;
	Wed, 21 Jul 2021 04:25:49 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2052.outbound.protection.outlook.com [40.107.212.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA02C6E8EA
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Jul 2021 04:25:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z7I/1OGSdPrAfshH89hOq2dvh0GVMYszv+6w0jXPOfDT2vi5yXNVYN9j594twZP9RpZIYxAjDSkWBEgZI3K/7IDSZ6kpKVUwVcUnjCsj8JbdxNhIM8uXqT/HmIwkW1/4p27NNYCtTrUPMty2hawOnalrIJlkSdi4QRGMlHRkedqpAwtOTdzZ7LsRKCvLvNMy91cZdp+n1GCyqyx+XSamP6XEmO/ji3+67D8Hu13Jui0pSoOjKajehX4vdkQGdN+Vw7VxhM6mO5gdn2gNhdM3ksIpXDvbM020qAbwh7ccnZ2G6sFjMgxfULMWVhWK5rc7jAB0Q3CLuKKaXXRMZiZsRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EFW5lwCK8BgVbTAJ0dP2WLXgy+u5sHeAs++K9Nck03Q=;
 b=kxf/KWkvy8z+lNMo2UyMMsrlKd2Gh0ae/udpTNH29J/SP1GJbrhEwKEtuQWj8MyFm+hOTTRJS/YxYKxlnUTHcUQXHorRGCSlS27f55NxB06mfCXl8WlsXgeOZAKX80y1CedZxI7vpICLE1ZWvXJm0g4IaYG17pcLsLWdA72mkKfzHZAzWMq7vFF25EVxyGcrGIsM5gmkzM6urhJ81tNYuabsMS+JJXCojoHwMWsayo+oyBnTV3/qv3WbNkn3kfr1tIzb4HD+MnJiwEJrAV3mahb5ebrET6joCTeKgBFboHPHcSO2AIpRte5Fh6RzGwczDHlYSkbi7+p4kvGQFUGqKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EFW5lwCK8BgVbTAJ0dP2WLXgy+u5sHeAs++K9Nck03Q=;
 b=sy0qmObHJeE7ULI2gaGT+OdIAlEIj/hU7maMWo5dbMYRwtcXqjXJRLn3nLYiWDfF/Qu8eMGj+BMTboetNi78gFvaQw9hMqWRt9E9daij9B6G6YWz8sfG1NniI7BoNMjFjA279bsfcXWcpTSlf28Mof+m5SGXliCatljey620i4c=
Received: from BN9PR03CA0191.namprd03.prod.outlook.com (2603:10b6:408:f9::16)
 by DM6PR12MB3131.namprd12.prod.outlook.com (2603:10b6:5:11d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.26; Wed, 21 Jul
 2021 04:25:46 +0000
Received: from BN8NAM11FT039.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f9:cafe::5d) by BN9PR03CA0191.outlook.office365.com
 (2603:10b6:408:f9::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend
 Transport; Wed, 21 Jul 2021 04:25:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT039.mail.protection.outlook.com (10.13.177.169) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4352.24 via Frontend Transport; Wed, 21 Jul 2021 04:25:45 +0000
Received: from stylon-T495.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Tue, 20 Jul
 2021 23:25:41 -0500
From: Stylon Wang <stylon.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 1/2] drm/amd/display: Revert "Re-enable 'Guard ASSR with
 internal display flag'"
Date: Wed, 21 Jul 2021 12:25:23 +0800
Message-ID: <20210721042524.754014-2-stylon.wang@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210721042524.754014-1-stylon.wang@amd.com>
References: <20210720033317.686726-1-stylon.wang@amd.com>
 <20210721042524.754014-1-stylon.wang@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 70e12fc3-f375-4474-c4dc-08d94bff9be8
X-MS-TrafficTypeDiagnostic: DM6PR12MB3131:
X-Microsoft-Antispam-PRVS: <DM6PR12MB31315CB7740C6D42ECE3F211FFE39@DM6PR12MB3131.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mICGU2s6vKqkVcmfB1Jki8uwhO/aMfyEu6EhA1H9UTXztRkXWq6RijdSuAOSkLxNr8owKgk2exAil/d24P7MrSTcKsMo7veIKMliISut0v4c48LDCotZawDnAPKWFPH13YamwlYRCmijpX4dZbhM4DZqZsAdSdwZm1Dz9B/vYXRn/XRIXWcwDrA9y2GFjMXkpwWILX6R4I/Mwn2/Z+ewzjmaJWrEq/RE/EVY+QLHUoxZR91J+kxjEX/lc+xRM7b8d6GUyOG/poU0RTrflzxh17gyd0AZsM13OKpRBtAEYikLP1O+r1qoGA0QMBu4U7yfUCMfv4CSpm53ISbY+wHgRF0NRSGYVHD34pMIocA1oYHJSFrSXKAS9Lecv8Jsu2SDNJ1WVjrUqKD6d/C0ltbRgqoW5ApN31glZxbYkcj0/THQcjUmoOhITWeNBPT51YQtReb/QWD5BUkDcPFMTcfuN5kJpBDHqVvv+pfuLB9pHKgWNnxUwKiKZA1+wKFbBoGHIQekW3F8jGgtXIvNDwxJRBL4Fr1dXK2UhBvneSvAj+R/UhqQUVyVfOMIxD441Y91DuSj47y+J+/Ae0gJRva1Je8iX17Ab+ebwyVK72EjYdS4WwLqGyh2/QaBLPHpuf6MVh35JM+WzOcwvA4aT+7KMEuymVuj6n9UTOBJP0old5gMKYEHrQHa0GTRhauKNCOJcjRk2Fo5U5eetRDO6QZ5hVMnB+14/zvhlBPPLtiRowg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(346002)(396003)(376002)(46966006)(36840700001)(316002)(6666004)(54906003)(36756003)(8676002)(4326008)(86362001)(82740400003)(83380400001)(7696005)(26005)(36860700001)(2616005)(2906002)(44832011)(1076003)(478600001)(82310400003)(16526019)(426003)(186003)(6916009)(5660300002)(47076005)(336012)(70206006)(81166007)(356005)(70586007)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2021 04:25:45.3573 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 70e12fc3-f375-4474-c4dc-08d94bff9be8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT039.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3131
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
Cc: Stylon Wang <stylon.wang@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com,
 Alex Deucher <alexander.deucher@amd.com>, Bhawanpreet.Lakha@amd.com,
 bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
A new change that simplifies the ASSR enabling and guarding is found
that also fixes regression on some embedded panels.

[How]
Revert the ASSR changes in preparation for upcoming patch.

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Stylon Wang <stylon.wang@amd.com>
---
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  | 54 ++++++-------------
 1 file changed, 17 insertions(+), 37 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index 8b35cd9d4c01..cc62124b0b82 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -1752,38 +1752,6 @@ enum link_training_result dc_link_dp_perform_link_training(
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
-#endif
-	return panel_mode;
-}
-
 bool perform_link_training_with_retries(
 	const struct dc_link_settings *link_setting,
 	bool skip_video_pattern,
@@ -1796,7 +1764,7 @@ bool perform_link_training_with_retries(
 	uint8_t delay_between_attempts = LINK_TRAINING_RETRY_DELAY;
 	struct dc_stream_state *stream = pipe_ctx->stream;
 	struct dc_link *link = stream->link;
-	enum dp_panel_mode panel_mode;
+	enum dp_panel_mode panel_mode = dp_get_panel_mode(link);
 	struct link_encoder *link_enc;
 	enum link_training_result status = LINK_TRAINING_CR_FAIL_LANE0;
 	struct dc_link_settings current_setting = *link_setting;
@@ -1832,11 +1800,23 @@ bool perform_link_training_with_retries(
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
2.32.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
