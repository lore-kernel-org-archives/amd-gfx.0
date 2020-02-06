Return-Path: <SRS0=1Ph7=32=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F65BC352A3
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Feb 2020 21:14:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0173321775
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Feb 2020 21:14:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="wX37tIZu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0173321775
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B51E26FB5E;
	Thu,  6 Feb 2020 21:14:42 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2069.outbound.protection.outlook.com [40.107.94.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A700D6FB5E
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Feb 2020 21:14:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZyvRveMMBpTwy2QcpErgNyJwpGZWXTOznkZMYHnk+ezjdsheJhFkZ7yG4Lha/fy7MxNvGBbK817KKGpkFsJLeNkGF0/NRB09H0KpLPFUkwLLpev/1IAnripzztqNYOiUV7dlX5NIVsCF2qoPcDQp85xrC838CLFW5U64cOioKCw0/o2FCFI3ImYKytvPAsysLhBxYsrDUPbIcMVNi30hXQhe/B2Viqr30RnnptVXAurHxBK7WPFz8SrHZAFnvBTs1NbJipn3h62Hi5KC6N2v0yQTwEkF9osbC96bcJB4hN1xo2y1JBq8duTcUrKf3pXJStxHxVCzcScOxHa2xYLuIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zWkW0zlBGeuStgpSC4uc7aseQcYAcziW27OXcLCbTHQ=;
 b=gwZ7IepQAqPi4uxGFRMI+14CDhFFwZKuRAih28H57v1v3UfcFoZ0WPzrOZhK7/lziUkAnU0A5vq5fUdkdRkogXZs3Oz1Vrfib4aq58HmnaDzklEG+/a6j/HVUAM0LhB+Xj25MWLA5396xO1Tmf8kSy7n9xFn5N+YeCefPVxtOHlOH7hiXqHIi+C4ry2LvnQBKUscwJkfiUR93PoH+Z2nMzXLmrj9OZ9TDLMXym3a7MjNgK19nfRbXVsuhWSH8HxdGsbB47XOCc0wS+V69f4ZoLy6akBuLkGe0TZsVoTH0iPoAkhNFXTsrRhG6PM/+eutPnT0q3GfTajxh5WGdnbP8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zWkW0zlBGeuStgpSC4uc7aseQcYAcziW27OXcLCbTHQ=;
 b=wX37tIZuHeoIsSxJaF3eSGrOYpztwjyACfK06rhYcmHguBtitN3MlzrUoInqUnUVMeS5eG9jMHbnpaeEektBcVwawkO3Rs2m65e/It5yj6VJRpt0d4+smCLTqtdXsN9NqmwckZJPuLnHN8/cpCZ2vJEkj3OfQrZBepYA0nKxI0w=
Received: from MN2PR12CA0006.namprd12.prod.outlook.com (2603:10b6:208:a8::19)
 by CH2PR12MB3653.namprd12.prod.outlook.com (2603:10b6:610:14::26)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2686.27; Thu, 6 Feb
 2020 21:14:39 +0000
Received: from BN8NAM11FT058.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eae::200) by MN2PR12CA0006.outlook.office365.com
 (2603:10b6:208:a8::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2707.24 via Frontend
 Transport; Thu, 6 Feb 2020 21:14:38 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 BN8NAM11FT058.mail.protection.outlook.com (10.13.177.58) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2707.21 via Frontend Transport; Thu, 6 Feb 2020 21:14:38 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 6 Feb 2020
 15:14:38 -0600
Received: from blakha.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Thu, 6 Feb 2020 15:14:37 -0600
From: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/5] drm/amd/display: update HDCP DTM immediately after
 hardware programming
Date: Thu, 6 Feb 2020 16:14:23 -0500
Message-ID: <20200206211425.20394-4-Bhawanpreet.Lakha@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200206211425.20394-1-Bhawanpreet.Lakha@amd.com>
References: <20200206211425.20394-1-Bhawanpreet.Lakha@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(396003)(39860400002)(346002)(376002)(428003)(199004)(189003)(186003)(7696005)(54906003)(36756003)(30864003)(81166006)(26005)(316002)(5660300002)(81156014)(336012)(8936002)(15650500001)(1076003)(478600001)(6916009)(4326008)(2906002)(8676002)(70206006)(70586007)(6666004)(356004)(426003)(2616005)(86362001)(14773001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CH2PR12MB3653; H:SATLEXMB02.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; A:1; MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 93fb205c-3f6d-4106-7dd0-08d7ab49934f
X-MS-TrafficTypeDiagnostic: CH2PR12MB3653:
X-Microsoft-Antispam-PRVS: <CH2PR12MB3653C3F37E18D1551CBE8253F91D0@CH2PR12MB3653.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:172;
X-Forefront-PRVS: 0305463112
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kFKWlvjUdYqR2eauBavW6BtN/SBQgjE66OkHpCJxF3SoqPamUvE3xHlOBH67XzHDj8J1xl9dP1/vPKTwuwC62l+329dSQ5WCXMqjLVJm/NKRkig9vX+Va8pgIy55B70jvoptxWI4/CSviIkfdgSEoDMmtApRYulCvBXTn2zVAmKTpGuMiLjIiaTDpsylWb7AYy714ovgLmKf58l2fjn/MAa9J5PK3Ft2sq0HrC3MZN7NTj562FWjBfRrVMaglmsVAgQ5BRZrJByqh3ojoaG0fEViT+1GNr/Nco3AKplxRxL6/L2WTV79QIbZfR42spDaFBSus+4K8Cvlxmfs5wa81W3a8D+a6lBTO0I+nEO0+nW/Ry+PMOFmGsT3NFaQfyMG7YxAB2CCHbbIHjhMaz+OHpDrkfgEuaskANPKNq7JoaApjmbjSDHUYFR5igwUfmTYdLgY9mcBfAty35aJ+YhWJ8MvPokhES6moepqOaVBcwib0G1P9AusVC+Ep7AI/zRG
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2020 21:14:38.8212 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 93fb205c-3f6d-4106-7dd0-08d7ab49934f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3653
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
Cc: Wenjing Liu <Wenjing.Liu@amd.com>, harry.wentland@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wenjing Liu <Wenjing.Liu@amd.com>

[why]
HDCP DTM needs to be aware of the upto date display topology
information in order to validate hardware consistency.

[how]
update HDCP DTM on update_stream_config call.

Signed-off-by: Wenjing Liu <Wenjing.Liu@amd.com>
Reviewed-by: Jun Lei <Jun.Lei@amd.com>
---
 .../gpu/drm/amd/display/modules/hdcp/hdcp.c   |  46 ++-----
 .../gpu/drm/amd/display/modules/hdcp/hdcp.h   |  10 +-
 .../display/modules/hdcp/hdcp1_execution.c    |   4 -
 .../display/modules/hdcp/hdcp1_transition.c   |   6 +-
 .../display/modules/hdcp/hdcp2_execution.c    |   6 +-
 .../display/modules/hdcp/hdcp2_transition.c   |   6 +-
 .../drm/amd/display/modules/hdcp/hdcp_log.h   |   9 ++
 .../drm/amd/display/modules/hdcp/hdcp_psp.c   | 129 ++++++++++--------
 8 files changed, 106 insertions(+), 110 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp.c b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp.c
index a7d24734c7cd..83eaec4c6ad7 100644
--- a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp.c
+++ b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp.c
@@ -104,8 +104,6 @@ static enum mod_hdcp_status execution(struct mod_hdcp *hdcp,
 			event_ctx->unexpected_event = 1;
 			goto out;
 		}
-		/* update topology event if hdcp is not desired */
-		status = mod_hdcp_add_display_topology(hdcp);
 	} else if (is_in_hdcp1_states(hdcp)) {
 		status = mod_hdcp_hdcp1_execution(hdcp, event_ctx, &input->hdcp1);
 	} else if (is_in_hdcp1_dp_states(hdcp)) {
@@ -192,14 +190,7 @@ static enum mod_hdcp_status reset_authentication(struct mod_hdcp *hdcp,
 			mod_hdcp_hdcp1_destroy_session(hdcp);
 
 		}
-		if (hdcp->auth.trans_input.hdcp1.add_topology == PASS) {
-			status = mod_hdcp_remove_display_topology(hdcp);
-			if (status != MOD_HDCP_STATUS_SUCCESS) {
-				output->callback_needed = 0;
-				output->watchdog_timer_needed = 0;
-				goto out;
-			}
-		}
+
 		HDCP_TOP_RESET_AUTH_TRACE(hdcp);
 		memset(&hdcp->auth, 0, sizeof(struct mod_hdcp_authentication));
 		memset(&hdcp->state, 0, sizeof(struct mod_hdcp_state));
@@ -213,25 +204,12 @@ static enum mod_hdcp_status reset_authentication(struct mod_hdcp *hdcp,
 				goto out;
 			}
 		}
-		if (hdcp->auth.trans_input.hdcp2.add_topology == PASS) {
-			status = mod_hdcp_remove_display_topology(hdcp);
-			if (status != MOD_HDCP_STATUS_SUCCESS) {
-				output->callback_needed = 0;
-				output->watchdog_timer_needed = 0;
-				goto out;
-			}
-		}
+
 		HDCP_TOP_RESET_AUTH_TRACE(hdcp);
 		memset(&hdcp->auth, 0, sizeof(struct mod_hdcp_authentication));
 		memset(&hdcp->state, 0, sizeof(struct mod_hdcp_state));
 		set_state_id(hdcp, output, HDCP_INITIALIZED);
 	} else if (is_in_cp_not_desired_state(hdcp)) {
-		status = mod_hdcp_remove_display_topology(hdcp);
-		if (status != MOD_HDCP_STATUS_SUCCESS) {
-			output->callback_needed = 0;
-			output->watchdog_timer_needed = 0;
-			goto out;
-		}
 		HDCP_TOP_RESET_AUTH_TRACE(hdcp);
 		memset(&hdcp->auth, 0, sizeof(struct mod_hdcp_authentication));
 		memset(&hdcp->state, 0, sizeof(struct mod_hdcp_state));
@@ -338,16 +316,19 @@ enum mod_hdcp_status mod_hdcp_add_display(struct mod_hdcp *hdcp,
 	if (status != MOD_HDCP_STATUS_SUCCESS)
 		goto out;
 
-	/* add display to connection */
-	hdcp->connection.link = *link;
-	*display_container = *display;
-
 	/* reset retry counters */
 	reset_retry_counts(hdcp);
 
 	/* reset error trace */
 	memset(&hdcp->connection.trace, 0, sizeof(hdcp->connection.trace));
 
+	/* add display to connection */
+	hdcp->connection.link = *link;
+	*display_container = *display;
+	status = mod_hdcp_add_display_to_topology(hdcp, display->index);
+	if (status != MOD_HDCP_STATUS_SUCCESS)
+		goto out;
+
 	/* request authentication */
 	if (current_state(hdcp) != HDCP_INITIALIZED)
 		set_state_id(hdcp, output, HDCP_INITIALIZED);
@@ -380,15 +361,18 @@ enum mod_hdcp_status mod_hdcp_remove_display(struct mod_hdcp *hdcp,
 	if (status != MOD_HDCP_STATUS_SUCCESS)
 		goto out;
 
-	/* remove display */
-	display->state = MOD_HDCP_DISPLAY_INACTIVE;
-
 	/* clear retry counters */
 	reset_retry_counts(hdcp);
 
 	/* reset error trace */
 	memset(&hdcp->connection.trace, 0, sizeof(hdcp->connection.trace));
 
+	/* remove display */
+	status = mod_hdcp_remove_display_from_topology(hdcp, index);
+	if (status != MOD_HDCP_STATUS_SUCCESS)
+		goto out;
+	display->state = MOD_HDCP_DISPLAY_INACTIVE;
+
 	/* request authentication for remaining displays*/
 	if (get_active_display_count(hdcp) > 0)
 		callback_in_ms(hdcp->connection.link.adjust.auth_delay * 1000,
diff --git a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp.h b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp.h
index 4d717ec8f14b..b09d2f5502b3 100644
--- a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp.h
+++ b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp.h
@@ -41,7 +41,6 @@ enum mod_hdcp_trans_input_result {
 struct mod_hdcp_transition_input_hdcp1 {
 	uint8_t bksv_read;
 	uint8_t bksv_validation;
-	uint8_t add_topology;
 	uint8_t create_session;
 	uint8_t an_write;
 	uint8_t aksv_write;
@@ -71,7 +70,6 @@ struct mod_hdcp_transition_input_hdcp1 {
 struct mod_hdcp_transition_input_hdcp2 {
 	uint8_t hdcp2version_read;
 	uint8_t hdcp2_capable_check;
-	uint8_t add_topology;
 	uint8_t create_session;
 	uint8_t ake_init_prepare;
 	uint8_t ake_init_write;
@@ -328,10 +326,10 @@ void mod_hdcp_dump_binary_message(uint8_t *msg, uint32_t msg_size,
 /* TODO: add adjustment log */
 
 /* psp functions */
-enum mod_hdcp_status mod_hdcp_add_display_topology(
-		struct mod_hdcp *hdcp);
-enum mod_hdcp_status mod_hdcp_remove_display_topology(
-		struct mod_hdcp *hdcp);
+enum mod_hdcp_status mod_hdcp_add_display_to_topology(
+		struct mod_hdcp *hdcp, uint8_t index);
+enum mod_hdcp_status mod_hdcp_remove_display_from_topology(
+		struct mod_hdcp *hdcp, uint8_t index);
 enum mod_hdcp_status mod_hdcp_hdcp1_create_session(struct mod_hdcp *hdcp);
 enum mod_hdcp_status mod_hdcp_hdcp1_destroy_session(struct mod_hdcp *hdcp);
 enum mod_hdcp_status mod_hdcp_hdcp1_validate_rx(struct mod_hdcp *hdcp);
diff --git a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp1_execution.c b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp1_execution.c
index 37670db64855..37c8c05497d6 100644
--- a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp1_execution.c
+++ b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp1_execution.c
@@ -168,10 +168,6 @@ static enum mod_hdcp_status exchange_ksvs(struct mod_hdcp *hdcp,
 		goto out;
 	}
 
-	if (!mod_hdcp_execute_and_set(mod_hdcp_add_display_topology,
-			&input->add_topology, &status,
-			hdcp, "add_topology"))
-		goto out;
 	if (!mod_hdcp_execute_and_set(mod_hdcp_hdcp1_create_session,
 			&input->create_session, &status,
 			hdcp, "create_session"))
diff --git a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp1_transition.c b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp1_transition.c
index d66a9f954ade..5bc6706d2af7 100644
--- a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp1_transition.c
+++ b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp1_transition.c
@@ -46,8 +46,7 @@ enum mod_hdcp_status mod_hdcp_hdcp1_transition(struct mod_hdcp *hdcp,
 		set_state_id(hdcp, output, H1_A1_EXCHANGE_KSVS);
 		break;
 	case H1_A1_EXCHANGE_KSVS:
-		if (input->add_topology != PASS ||
-				input->create_session != PASS) {
+		if (input->create_session != PASS) {
 			/* out of sync with psp state */
 			adjust->hdcp1.disable = 1;
 			fail_and_restart_in_ms(0, &status, output);
@@ -173,8 +172,7 @@ enum mod_hdcp_status mod_hdcp_hdcp1_dp_transition(struct mod_hdcp *hdcp,
 		set_state_id(hdcp, output, D1_A1_EXCHANGE_KSVS);
 		break;
 	case D1_A1_EXCHANGE_KSVS:
-		if (input->add_topology != PASS ||
-				input->create_session != PASS) {
+		if (input->create_session != PASS) {
 			/* out of sync with psp state */
 			adjust->hdcp1.disable = 1;
 			fail_and_restart_in_ms(0, &status, output);
diff --git a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp2_execution.c b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp2_execution.c
index f730b94ac3c0..432b2a016e56 100644
--- a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp2_execution.c
+++ b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp2_execution.c
@@ -259,6 +259,7 @@ static enum mod_hdcp_status known_hdcp2_capable_rx(struct mod_hdcp *hdcp,
 		event_ctx->unexpected_event = 1;
 		goto out;
 	}
+
 	if (!mod_hdcp_execute_and_set(mod_hdcp_read_hdcp2version,
 			&input->hdcp2version_read, &status,
 			hdcp, "hdcp2version_read"))
@@ -281,10 +282,7 @@ static enum mod_hdcp_status send_ake_init(struct mod_hdcp *hdcp,
 		event_ctx->unexpected_event = 1;
 		goto out;
 	}
-	if (!mod_hdcp_execute_and_set(mod_hdcp_add_display_topology,
-			&input->add_topology, &status,
-			hdcp, "add_topology"))
-		goto out;
+
 	if (!mod_hdcp_execute_and_set(mod_hdcp_hdcp2_create_session,
 			&input->create_session, &status,
 			hdcp, "create_session"))
diff --git a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp2_transition.c b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp2_transition.c
index 8cae3e3aacd5..e738c7ae66ec 100644
--- a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp2_transition.c
+++ b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp2_transition.c
@@ -47,8 +47,7 @@ enum mod_hdcp_status mod_hdcp_hdcp2_transition(struct mod_hdcp *hdcp,
 		}
 		break;
 	case H2_A1_SEND_AKE_INIT:
-		if (input->add_topology != PASS ||
-				input->create_session != PASS ||
+		if (input->create_session != PASS ||
 				input->ake_init_prepare != PASS) {
 			/* out of sync with psp state */
 			adjust->hdcp2.disable = 1;
@@ -389,8 +388,7 @@ enum mod_hdcp_status mod_hdcp_hdcp2_dp_transition(struct mod_hdcp *hdcp,
 		}
 		break;
 	case D2_A1_SEND_AKE_INIT:
-		if (input->add_topology != PASS ||
-				input->create_session != PASS ||
+		if (input->create_session != PASS ||
 				input->ake_init_prepare != PASS) {
 			/* out of sync with psp state */
 			adjust->hdcp2.disable = 1;
diff --git a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_log.h b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_log.h
index ff91373ebada..6e844825ad23 100644
--- a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_log.h
+++ b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_log.h
@@ -49,6 +49,15 @@
 		HDCP_LOG_VER(hdcp, \
 			"[Link %d] HDCP 2.2 enabled on display %d", \
 			hdcp->config.index, displayIndex)
+#define HDCP_HDCP1_DISABLED_TRACE(hdcp, displayIndex) \
+		HDCP_LOG_VER(hdcp, \
+			"[Link %d] HDCP 1.4 disabled on display %d", \
+			hdcp->config.index, displayIndex)
+#define HDCP_HDCP2_DISABLED_TRACE(hdcp, displayIndex) \
+		HDCP_LOG_VER(hdcp, \
+			"[Link %d] HDCP 2.2 disabled on display %d", \
+			hdcp->config.index, displayIndex)
+
 /* state machine logs */
 #define HDCP_REMOVE_DISPLAY_TRACE(hdcp, displayIndex) \
 		HDCP_LOG_FSM(hdcp, \
diff --git a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.c b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.c
index 844454e0a5ba..acbe3e8a8eb7 100644
--- a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.c
+++ b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.c
@@ -44,85 +44,82 @@ static void hdcp2_message_init(struct mod_hdcp *hdcp,
 	in->process.msg3_desc.msg_id = TA_HDCP_HDCP2_MSG_ID__NULL_MESSAGE;
 	in->process.msg3_desc.msg_size = 0;
 }
-enum mod_hdcp_status mod_hdcp_remove_display_topology(struct mod_hdcp *hdcp)
-{
-
-	struct psp_context *psp = hdcp->config.psp.handle;
-	struct ta_dtm_shared_memory *dtm_cmd;
-	struct mod_hdcp_display *display = NULL;
-	uint8_t i;
+enum mod_hdcp_status mod_hdcp_remove_display_from_topology(
+		struct mod_hdcp *hdcp, uint8_t index)
+ {
+ 	struct psp_context *psp = hdcp->config.psp.handle;
+ 	struct ta_dtm_shared_memory *dtm_cmd;
+	struct mod_hdcp_display *display =
+			get_active_display_at_index(hdcp, index);
 
 	dtm_cmd = (struct ta_dtm_shared_memory *)psp->dtm_context.dtm_shared_buf;
 
-	for (i = 0; i < MAX_NUM_OF_DISPLAYS; i++) {
-		if (is_display_added(&(hdcp->connection.displays[i]))) {
-
-			memset(dtm_cmd, 0, sizeof(struct ta_dtm_shared_memory));
-
-			display = &hdcp->connection.displays[i];
+	if (!display || !is_display_added(display))
+		return MOD_HDCP_STATUS_DISPLAY_NOT_FOUND;
 
-			dtm_cmd->cmd_id = TA_DTM_COMMAND__TOPOLOGY_UPDATE_V2;
-			dtm_cmd->dtm_in_message.topology_update_v2.display_handle = display->index;
-			dtm_cmd->dtm_in_message.topology_update_v2.is_active = 0;
-			dtm_cmd->dtm_status = TA_DTM_STATUS__GENERIC_FAILURE;
+	memset(dtm_cmd, 0, sizeof(struct ta_dtm_shared_memory));
 
-			psp_dtm_invoke(psp, dtm_cmd->cmd_id);
+	dtm_cmd->cmd_id = TA_DTM_COMMAND__TOPOLOGY_UPDATE_V2;
+	dtm_cmd->dtm_in_message.topology_update_v2.display_handle = display->index;
+	dtm_cmd->dtm_in_message.topology_update_v2.is_active = 0;
+	dtm_cmd->dtm_status = TA_DTM_STATUS__GENERIC_FAILURE;
 
-			if (dtm_cmd->dtm_status != TA_DTM_STATUS__SUCCESS)
-				return MOD_HDCP_STATUS_UPDATE_TOPOLOGY_FAILURE;
+	psp_dtm_invoke(psp, dtm_cmd->cmd_id);
 
-			display->state = MOD_HDCP_DISPLAY_ACTIVE;
-			HDCP_TOP_REMOVE_DISPLAY_TRACE(hdcp, display->index);
-		}
-	}
+	if (dtm_cmd->dtm_status != TA_DTM_STATUS__SUCCESS)
+		return MOD_HDCP_STATUS_UPDATE_TOPOLOGY_FAILURE;
 
-	return MOD_HDCP_STATUS_SUCCESS;
-}
+	display->state = MOD_HDCP_DISPLAY_ACTIVE;
+	HDCP_TOP_REMOVE_DISPLAY_TRACE(hdcp, display->index);
+ 
+ 	return MOD_HDCP_STATUS_SUCCESS;
+ }
 
-enum mod_hdcp_status mod_hdcp_add_display_topology(struct mod_hdcp *hdcp)
+enum mod_hdcp_status mod_hdcp_add_display_to_topology(
+		struct mod_hdcp *hdcp, uint8_t index)
 {
 	struct psp_context *psp = hdcp->config.psp.handle;
 	struct ta_dtm_shared_memory *dtm_cmd;
-	struct mod_hdcp_display *display = NULL;
+	struct mod_hdcp_display *display =
+			get_active_display_at_index(hdcp, index);
 	struct mod_hdcp_link *link = &hdcp->connection.link;
-	uint8_t i;
 
 	if (!psp->dtm_context.dtm_initialized) {
 		DRM_ERROR("Failed to add display topology, DTM TA is not initialized.");
 		return MOD_HDCP_STATUS_FAILURE;
 	}
 
+	if (!display || is_display_added(display))
+		return MOD_HDCP_STATUS_UPDATE_TOPOLOGY_FAILURE;
+
 	dtm_cmd = (struct ta_dtm_shared_memory *)psp->dtm_context.dtm_shared_buf;
 
-	for (i = 0; i < MAX_NUM_OF_DISPLAYS; i++) {
-		if (hdcp->connection.displays[i].state == MOD_HDCP_DISPLAY_ACTIVE) {
-			display = &hdcp->connection.displays[i];
-
-			memset(dtm_cmd, 0, sizeof(struct ta_dtm_shared_memory));
-
-			dtm_cmd->cmd_id = TA_DTM_COMMAND__TOPOLOGY_UPDATE_V2;
-			dtm_cmd->dtm_in_message.topology_update_v2.display_handle = display->index;
-			dtm_cmd->dtm_in_message.topology_update_v2.is_active = 1;
-			dtm_cmd->dtm_in_message.topology_update_v2.controller = display->controller;
-			dtm_cmd->dtm_in_message.topology_update_v2.ddc_line = link->ddc_line;
-			dtm_cmd->dtm_in_message.topology_update_v2.dig_be = link->dig_be;
-			dtm_cmd->dtm_in_message.topology_update_v2.dig_fe = display->dig_fe;
-			dtm_cmd->dtm_in_message.topology_update_v2.dp_mst_vcid = display->vc_id;
-			dtm_cmd->dtm_in_message.topology_update_v2.max_hdcp_supported_version =
-				TA_DTM_HDCP_VERSION_MAX_SUPPORTED__2_2;
-			dtm_cmd->dtm_status = TA_DTM_STATUS__GENERIC_FAILURE;
-
-			psp_dtm_invoke(psp, dtm_cmd->cmd_id);
-
-			if (dtm_cmd->dtm_status != TA_DTM_STATUS__SUCCESS)
-				return MOD_HDCP_STATUS_UPDATE_TOPOLOGY_FAILURE;
-
-			display->state = MOD_HDCP_DISPLAY_ACTIVE_AND_ADDED;
-			HDCP_TOP_ADD_DISPLAY_TRACE(hdcp, display->index);
-		}
-	}
+	memset(dtm_cmd, 0, sizeof(struct ta_dtm_shared_memory));
 
-	return MOD_HDCP_STATUS_SUCCESS;
+	dtm_cmd->cmd_id = TA_DTM_COMMAND__TOPOLOGY_UPDATE_V2;
+	dtm_cmd->dtm_in_message.topology_update_v2.display_handle = display->index;
+	dtm_cmd->dtm_in_message.topology_update_v2.is_active = 1;
+	dtm_cmd->dtm_in_message.topology_update_v2.controller = display->controller;
+	dtm_cmd->dtm_in_message.topology_update_v2.ddc_line = link->ddc_line;
+	dtm_cmd->dtm_in_message.topology_update_v2.dig_be = link->dig_be;
+	dtm_cmd->dtm_in_message.topology_update_v2.dig_fe = display->dig_fe;
+	if (is_dp_hdcp(hdcp))
+		dtm_cmd->dtm_in_message.topology_update_v2.is_assr = link->dp.assr_supported;
+
+	dtm_cmd->dtm_in_message.topology_update_v2.dp_mst_vcid = display->vc_id;
+	dtm_cmd->dtm_in_message.topology_update_v2.max_hdcp_supported_version =
+			TA_DTM_HDCP_VERSION_MAX_SUPPORTED__2_2;
+	dtm_cmd->dtm_status = TA_DTM_STATUS__GENERIC_FAILURE;
+
+	psp_dtm_invoke(psp, dtm_cmd->cmd_id);
+
+	if (dtm_cmd->dtm_status != TA_DTM_STATUS__SUCCESS)
+		return MOD_HDCP_STATUS_UPDATE_TOPOLOGY_FAILURE;
+
+	display->state = MOD_HDCP_DISPLAY_ACTIVE_AND_ADDED;
+	HDCP_TOP_ADD_DISPLAY_TRACE(hdcp, display->index);
+ 
+ 	return MOD_HDCP_STATUS_SUCCESS;
 }
 
 enum mod_hdcp_status mod_hdcp_hdcp1_create_session(struct mod_hdcp *hdcp)
@@ -164,6 +161,7 @@ enum mod_hdcp_status mod_hdcp_hdcp1_destroy_session(struct mod_hdcp *hdcp)
 
 	struct psp_context *psp = hdcp->config.psp.handle;
 	struct ta_hdcp_shared_memory *hdcp_cmd;
+	uint8_t i = 0;
 
 	hdcp_cmd = (struct ta_hdcp_shared_memory *)psp->hdcp_context.hdcp_shared_buf;
 	memset(hdcp_cmd, 0, sizeof(struct ta_hdcp_shared_memory));
@@ -177,6 +175,14 @@ enum mod_hdcp_status mod_hdcp_hdcp1_destroy_session(struct mod_hdcp *hdcp)
 		return MOD_HDCP_STATUS_HDCP1_DESTROY_SESSION_FAILURE;
 
 	HDCP_TOP_HDCP1_DESTROY_SESSION_TRACE(hdcp);
+	for (i = 0; i < MAX_NUM_OF_DISPLAYS; i++)
+		if (is_display_encryption_enabled(
+				&hdcp->connection.displays[i])) {
+			hdcp->connection.displays[i].state =
+					MOD_HDCP_DISPLAY_ACTIVE_AND_ADDED;
+			HDCP_HDCP1_DISABLED_TRACE(hdcp,
+					hdcp->connection.displays[i].index);
+		}
 
 	return MOD_HDCP_STATUS_SUCCESS;
 }
@@ -399,6 +405,7 @@ enum mod_hdcp_status mod_hdcp_hdcp2_destroy_session(struct mod_hdcp *hdcp)
 {
 	struct psp_context *psp = hdcp->config.psp.handle;
 	struct ta_hdcp_shared_memory *hdcp_cmd;
+	uint8_t i = 0;
 
 	hdcp_cmd = (struct ta_hdcp_shared_memory *)psp->hdcp_context.hdcp_shared_buf;
 	memset(hdcp_cmd, 0, sizeof(struct ta_hdcp_shared_memory));
@@ -412,6 +419,14 @@ enum mod_hdcp_status mod_hdcp_hdcp2_destroy_session(struct mod_hdcp *hdcp)
 		return MOD_HDCP_STATUS_HDCP2_DESTROY_SESSION_FAILURE;
 
 	HDCP_TOP_HDCP2_DESTROY_SESSION_TRACE(hdcp);
+	for (i = 0; i < MAX_NUM_OF_DISPLAYS; i++)
+		if (is_display_encryption_enabled(
+				&hdcp->connection.displays[i])) {
+			hdcp->connection.displays[i].state =
+					MOD_HDCP_DISPLAY_ACTIVE_AND_ADDED;
+			HDCP_HDCP2_DISABLED_TRACE(hdcp,
+					hdcp->connection.displays[i].index);
+		}
 
 	return MOD_HDCP_STATUS_SUCCESS;
 }
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
