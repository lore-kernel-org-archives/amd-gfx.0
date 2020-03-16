Return-Path: <SRS0=rOad=5B=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EABEC0044D
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Mar 2020 13:49:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43BF52051A
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Mar 2020 13:49:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="HDW7isR+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43BF52051A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CABDE6E44F;
	Mon, 16 Mar 2020 13:49:57 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2042.outbound.protection.outlook.com [40.107.236.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D3E966E44F
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Mar 2020 13:49:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KrbyU6yTghRngkO3K9DrYpbEui0PpFgR+UPRbIwMOpOZAi9zN0tWroup/aIbAXOznEBgJZGbQRqxl/wtqbqstQnp9R8mVriZaDEn8Xlfu5/pZseGDO5409TnWIqrihHyw3vJYS4Pmgbov0vrNpqgjC7QTVPuORzrzLJXqPzgLr7W4A4WRUk0bS1XXAqrCJ9UHFZEZ6TGr21w+E4jx4I7Rtyl9y+Q9y438p2JkUD+eZy8wDTwD/evAYwLW5YN+ZIElf0GGzPkMpQIe4QQPkcw5w20AC+MdLNFMdd0/mD/BZZLF0PMduGw51yKoNeFdB3WWO9vjgANEjHPGcEbcy84LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nk2VnsjJGcoc2t8ZWYdtLpbey9gEQ6Ej8RBmNAmj6bM=;
 b=ME7R4Ctri76PJsXkddauEpoP4X4ek5+bjnqaa66fME77TwT41fFjVV2/pQOpRtf5yGJHHJ5qUk7YQQlbZvTmzg9TgOpMD2gmVjSAtMrtGSyrN+WgsEHlEyAy3j6AE+F2GYHnbJM7sjrsSN6Cy+RoqoC5zADiQELnbGYC7o3CJxrGZEJJOODSm524oHnEqEJ9Mi/6Nl2P+4ZQOrlxaa+3XWxmJ3KaIyFeTfG6doJjlp4FVHt2wmRhKfRQPZV0i4ldG90e4hQHNSoc6cgieIF+XUvr9ScCqQOGhaKadQO2nRB0eCmmIt8daARDGOp2k3JmptHnmLO577tMNYyfj0UTsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nk2VnsjJGcoc2t8ZWYdtLpbey9gEQ6Ej8RBmNAmj6bM=;
 b=HDW7isR+K7RLehsYrlUs+VnIaEcKtGwOCTn3xmX+XGFrbvqfYvF2/EBG5CTIodoUo8NsMXF+Rw2hZ7YFWxAUSwfyHlTazigG/S4a2i2et0Aq3Vy+Us1qo0CxFHCqxqX3Z9XdM/2baZVbvN8gYaGflYJLB+55UVWGiIaZQHEC754=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (2603:10b6:907:9::27)
 by MW2PR12MB2363.namprd12.prod.outlook.com (2603:10b6:907:f::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.14; Mon, 16 Mar
 2020 13:49:55 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5%6]) with mapi id 15.20.2814.021; Mon, 16 Mar 2020
 13:49:55 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 03/19] drm/amd/display: Remove redundant hdcp display state
Date: Mon, 16 Mar 2020 09:49:04 -0400
Message-Id: <20200316134920.2526155-4-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200316134920.2526155-1-Rodrigo.Siqueira@amd.com>
References: <20200316134920.2526155-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YTXPR0101CA0009.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::22) To MW2PR12MB2524.namprd12.prod.outlook.com
 (2603:10b6:907:9::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.amd.com (165.204.55.250) by
 YTXPR0101CA0009.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.14 via Frontend Transport; Mon, 16 Mar 2020 13:49:54 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4812e2f9-33dc-4527-3d81-08d7c9b0e898
X-MS-TrafficTypeDiagnostic: MW2PR12MB2363:|MW2PR12MB2363:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB23638777FDB53DD915DF5B3E98F90@MW2PR12MB2363.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 03449D5DD1
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(136003)(346002)(376002)(39860400002)(366004)(199004)(8936002)(16526019)(478600001)(8676002)(7696005)(52116002)(186003)(81156014)(81166006)(6666004)(26005)(6916009)(54906003)(316002)(5660300002)(36756003)(66556008)(66476007)(86362001)(66946007)(2616005)(956004)(30864003)(2906002)(6486002)(1076003)(4326008);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MW2PR12MB2363;
 H:MW2PR12MB2524.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fs6TOQsREybiBcc++nCGJXuEmMifenfF6KZq5aWzNRgomm0H+MGChQZq5Mzkz/TNJJv9ix9CPErwMDl9y6LjvMljsJECm3T6rl700YF8ilSnbhs2K3FnhmwN4xZhF9oDBu4ApE2Bi3ybPQNg7E3163IV0IzvR9ot5Z0w0nhfg+jxdo1NMeHXMy8mADscDfMQFHYpAOcQyY6q0akt97E16SRz+sUh+bFlrRgj34s/oMDN3/7/vdUqcVWLwF/e1jUTIrRs/LUafuWPsXXgu4o4mFJdB0vogO/ApR4VNWwK4ThaKe5ecSoRpDJz/k+LqkSJxdfUHAWxLYrtC8m60ioG+U2IC+A4mOvZUVGJrdGRsJLQp1CSozgYAdCNhKDyiJ/ypxSGruIsSzsuQokOHsrVtaUmrUdoswnnlHBKlFEjuip4R3N4D950jYRdrDfbJEb/
X-MS-Exchange-AntiSpam-MessageData: h/n3bb7NOzsca4aRZe1aCYPgd8FPzkKtJUOUNUV7hgmkwoNIMQwJdxEM0iCgb1cYP72dMBlgLxBzx3K6cHRssHbDDWpJSxrOGSXSPPkS4bWp4qlNvRK7aAOK99KMTM+dQdAvlhEWRa3oaiBWZJEQTA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4812e2f9-33dc-4527-3d81-08d7c9b0e898
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2020 13:49:55.2911 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O3AmLF5KG/S6RBEhj8pKQp67P8lZhjFGKsJghtGmDMnCECAFw1fcGbYh6oz4D3G0IUO2l1cQYr+1+wYSHZhjXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2363
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
Cc: Isabel Zhang <isabel.zhang@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Rodrigo.Siqueira@amd.com,
 Wenjing Liu <Wenjing.Liu@amd.com>, Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Isabel Zhang <isabel.zhang@amd.com>

[Why]
Due to previous code changes displays which are in active state
immediately transition to the active and added state. This makes the two
states redundant and unnecessary.

[How]
Instead of updating the device state to active and added after
successful addition, change state to inactive if addition failed. Also,
change references to active and added state to just added state.

Signed-off-by: Isabel Zhang <isabel.zhang@amd.com>
Reviewed-by: Wenjing Liu <Wenjing.Liu@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../gpu/drm/amd/display/modules/hdcp/hdcp.c   |  5 ++-
 .../gpu/drm/amd/display/modules/hdcp/hdcp.h   | 28 +++-----------
 .../display/modules/hdcp/hdcp1_execution.c    |  2 +-
 .../display/modules/hdcp/hdcp2_execution.c    |  2 +-
 .../drm/amd/display/modules/hdcp/hdcp_psp.c   | 37 ++++++++-----------
 .../drm/amd/display/modules/inc/mod_hdcp.h    |  1 -
 6 files changed, 27 insertions(+), 48 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp.c b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp.c
index cc1d3f470b99..e9fbd94f8635 100644
--- a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp.c
+++ b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp.c
@@ -328,7 +328,8 @@ enum mod_hdcp_status mod_hdcp_add_display(struct mod_hdcp *hdcp,
 	/* add display to connection */
 	hdcp->connection.link = *link;
 	*display_container = *display;
-	status = mod_hdcp_add_display_to_topology(hdcp, display->index);
+	status = mod_hdcp_add_display_to_topology(hdcp, display_container);
+
 	if (status != MOD_HDCP_STATUS_SUCCESS)
 		goto out;
 
@@ -374,7 +375,7 @@ enum mod_hdcp_status mod_hdcp_remove_display(struct mod_hdcp *hdcp,
 	status = mod_hdcp_remove_display_from_topology(hdcp, index);
 	if (status != MOD_HDCP_STATUS_SUCCESS)
 		goto out;
-	display->state = MOD_HDCP_DISPLAY_INACTIVE;
+	memset(display, 0, sizeof(struct mod_hdcp_display));
 
 	/* request authentication when connection is not reset */
 	if (current_state(hdcp) != HDCP_UNINITIALIZED)
diff --git a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp.h b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp.h
index 5cb4546be0ef..60ff1a0028ac 100644
--- a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp.h
+++ b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp.h
@@ -328,7 +328,7 @@ void mod_hdcp_dump_binary_message(uint8_t *msg, uint32_t msg_size,
 
 /* psp functions */
 enum mod_hdcp_status mod_hdcp_add_display_to_topology(
-		struct mod_hdcp *hdcp, uint8_t index);
+		struct mod_hdcp *hdcp, struct mod_hdcp_display *display);
 enum mod_hdcp_status mod_hdcp_remove_display_from_topology(
 		struct mod_hdcp *hdcp, uint8_t index);
 enum mod_hdcp_status mod_hdcp_hdcp1_create_session(struct mod_hdcp *hdcp);
@@ -503,11 +503,6 @@ static inline uint8_t is_display_active(struct mod_hdcp_display *display)
 	return display->state >= MOD_HDCP_DISPLAY_ACTIVE;
 }
 
-static inline uint8_t is_display_added(struct mod_hdcp_display *display)
-{
-	return display->state >= MOD_HDCP_DISPLAY_ACTIVE_AND_ADDED;
-}
-
 static inline uint8_t is_display_encryption_enabled(struct mod_hdcp_display *display)
 {
 	return display->state >= MOD_HDCP_DISPLAY_ENCRYPTION_ENABLED;
@@ -515,34 +510,23 @@ static inline uint8_t is_display_encryption_enabled(struct mod_hdcp_display *dis
 
 static inline uint8_t get_active_display_count(struct mod_hdcp *hdcp)
 {
-	uint8_t added_count = 0;
+	uint8_t active_count = 0;
 	uint8_t i;
 
 	for (i = 0; i < MAX_NUM_OF_DISPLAYS; i++)
 		if (is_display_active(&hdcp->displays[i]))
-			added_count++;
-	return added_count;
-}
-
-static inline uint8_t get_added_display_count(struct mod_hdcp *hdcp)
-{
-	uint8_t added_count = 0;
-	uint8_t i;
-
-	for (i = 0; i < MAX_NUM_OF_DISPLAYS; i++)
-		if (is_display_added(&hdcp->displays[i]))
-			added_count++;
-	return added_count;
+			active_count++;
+	return active_count;
 }
 
-static inline struct mod_hdcp_display *get_first_added_display(
+static inline struct mod_hdcp_display *get_first_active_display(
 		struct mod_hdcp *hdcp)
 {
 	uint8_t i;
 	struct mod_hdcp_display *display = NULL;
 
 	for (i = 0; i < MAX_NUM_OF_DISPLAYS; i++)
-		if (is_display_added(&hdcp->displays[i])) {
+		if (is_display_active(&hdcp->displays[i])) {
 			display = &hdcp->displays[i];
 			break;
 		}
diff --git a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp1_execution.c b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp1_execution.c
index 37c8c05497d6..f244b72e74e0 100644
--- a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp1_execution.c
+++ b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp1_execution.c
@@ -129,7 +129,7 @@ static inline uint8_t get_device_count(struct mod_hdcp *hdcp)
 static inline enum mod_hdcp_status check_device_count(struct mod_hdcp *hdcp)
 {
 	/* device count must be greater than or equal to tracked hdcp displays */
-	return (get_device_count(hdcp) < get_added_display_count(hdcp)) ?
+	return (get_device_count(hdcp) < get_active_display_count(hdcp)) ?
 			MOD_HDCP_STATUS_HDCP1_DEVICE_COUNT_MISMATCH_FAILURE :
 			MOD_HDCP_STATUS_SUCCESS;
 }
diff --git a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp2_execution.c b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp2_execution.c
index 491c00f48026..549c113abcf7 100644
--- a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp2_execution.c
+++ b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp2_execution.c
@@ -208,7 +208,7 @@ static inline uint8_t get_device_count(struct mod_hdcp *hdcp)
 static enum mod_hdcp_status check_device_count(struct mod_hdcp *hdcp)
 {
 	/* device count must be greater than or equal to tracked hdcp displays */
-	return (get_device_count(hdcp) < get_added_display_count(hdcp)) ?
+	return (get_device_count(hdcp) < get_active_display_count(hdcp)) ?
 			MOD_HDCP_STATUS_HDCP2_DEVICE_COUNT_MISMATCH_FAILURE :
 			MOD_HDCP_STATUS_SUCCESS;
 }
diff --git a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.c b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.c
index b87e9d2862bc..836e47954938 100644
--- a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.c
+++ b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.c
@@ -54,7 +54,7 @@ enum mod_hdcp_status mod_hdcp_remove_display_from_topology(
 
 	dtm_cmd = (struct ta_dtm_shared_memory *)psp->dtm_context.dtm_shared_buf;
 
-	if (!display || !is_display_added(display))
+	if (!display || !is_display_active(display))
 		return MOD_HDCP_STATUS_DISPLAY_NOT_FOUND;
 
 	memset(dtm_cmd, 0, sizeof(struct ta_dtm_shared_memory));
@@ -76,22 +76,18 @@ enum mod_hdcp_status mod_hdcp_remove_display_from_topology(
  }
 
 enum mod_hdcp_status mod_hdcp_add_display_to_topology(
-		struct mod_hdcp *hdcp, uint8_t index)
+		struct mod_hdcp *hdcp, struct mod_hdcp_display *display)
 {
 	struct psp_context *psp = hdcp->config.psp.handle;
 	struct ta_dtm_shared_memory *dtm_cmd;
-	struct mod_hdcp_display *display =
-			get_active_display_at_index(hdcp, index);
 	struct mod_hdcp_link *link = &hdcp->connection.link;
 
 	if (!psp->dtm_context.dtm_initialized) {
 		DRM_ERROR("Failed to add display topology, DTM TA is not initialized.");
+		display->state = MOD_HDCP_DISPLAY_INACTIVE;
 		return MOD_HDCP_STATUS_FAILURE;
 	}
 
-	if (!display || is_display_added(display))
-		return MOD_HDCP_STATUS_UPDATE_TOPOLOGY_FAILURE;
-
 	dtm_cmd = (struct ta_dtm_shared_memory *)psp->dtm_context.dtm_shared_buf;
 
 	memset(dtm_cmd, 0, sizeof(struct ta_dtm_shared_memory));
@@ -113,20 +109,21 @@ enum mod_hdcp_status mod_hdcp_add_display_to_topology(
 
 	psp_dtm_invoke(psp, dtm_cmd->cmd_id);
 
-	if (dtm_cmd->dtm_status != TA_DTM_STATUS__SUCCESS)
+	if (dtm_cmd->dtm_status != TA_DTM_STATUS__SUCCESS) {
+		display->state = MOD_HDCP_DISPLAY_INACTIVE;
 		return MOD_HDCP_STATUS_UPDATE_TOPOLOGY_FAILURE;
+	}
 
-	display->state = MOD_HDCP_DISPLAY_ACTIVE_AND_ADDED;
 	HDCP_TOP_ADD_DISPLAY_TRACE(hdcp, display->index);
- 
- 	return MOD_HDCP_STATUS_SUCCESS;
+
+	return MOD_HDCP_STATUS_SUCCESS;
 }
 
 enum mod_hdcp_status mod_hdcp_hdcp1_create_session(struct mod_hdcp *hdcp)
 {
 
 	struct psp_context *psp = hdcp->config.psp.handle;
-	struct mod_hdcp_display *display = get_first_added_display(hdcp);
+	struct mod_hdcp_display *display = get_first_active_display(hdcp);
 	struct ta_hdcp_shared_memory *hdcp_cmd;
 
 	if (!psp->hdcp_context.hdcp_initialized) {
@@ -179,7 +176,7 @@ enum mod_hdcp_status mod_hdcp_hdcp1_destroy_session(struct mod_hdcp *hdcp)
 		if (is_display_encryption_enabled(
 				&hdcp->displays[i])) {
 			hdcp->displays[i].state =
-					MOD_HDCP_DISPLAY_ACTIVE_AND_ADDED;
+								MOD_HDCP_DISPLAY_ACTIVE;
 			HDCP_HDCP1_DISABLED_TRACE(hdcp,
 					hdcp->displays[i].index);
 		}
@@ -231,7 +228,7 @@ enum mod_hdcp_status mod_hdcp_hdcp1_enable_encryption(struct mod_hdcp *hdcp)
 {
 	struct psp_context *psp = hdcp->config.psp.handle;
 	struct ta_hdcp_shared_memory *hdcp_cmd;
-	struct mod_hdcp_display *display = get_first_added_display(hdcp);
+	struct mod_hdcp_display *display = get_first_active_display(hdcp);
 
 	hdcp_cmd = (struct ta_hdcp_shared_memory *)psp->hdcp_context.hdcp_shared_buf;
 	memset(hdcp_cmd, 0, sizeof(struct ta_hdcp_shared_memory));
@@ -301,8 +298,7 @@ enum mod_hdcp_status mod_hdcp_hdcp1_enable_dp_stream_encryption(struct mod_hdcp
 
 	for (i = 0; i < MAX_NUM_OF_DISPLAYS; i++) {
 
-		if (hdcp->displays[i].state != MOD_HDCP_DISPLAY_ACTIVE_AND_ADDED ||
-		    hdcp->displays[i].adjust.disable)
+		if (hdcp->displays[i].adjust.disable)
 			continue;
 
 		memset(hdcp_cmd, 0, sizeof(struct ta_hdcp_shared_memory));
@@ -364,7 +360,7 @@ enum mod_hdcp_status mod_hdcp_hdcp2_create_session(struct mod_hdcp *hdcp)
 {
 	struct psp_context *psp = hdcp->config.psp.handle;
 	struct ta_hdcp_shared_memory *hdcp_cmd;
-	struct mod_hdcp_display *display = get_first_added_display(hdcp);
+	struct mod_hdcp_display *display = get_first_active_display(hdcp);
 
 	if (!psp->hdcp_context.hdcp_initialized) {
 		DRM_ERROR("Failed to create hdcp session, HDCP TA is not initialized");
@@ -423,7 +419,7 @@ enum mod_hdcp_status mod_hdcp_hdcp2_destroy_session(struct mod_hdcp *hdcp)
 		if (is_display_encryption_enabled(
 				&hdcp->displays[i])) {
 			hdcp->displays[i].state =
-					MOD_HDCP_DISPLAY_ACTIVE_AND_ADDED;
+								MOD_HDCP_DISPLAY_ACTIVE;
 			HDCP_HDCP2_DISABLED_TRACE(hdcp,
 					hdcp->displays[i].index);
 		}
@@ -662,7 +658,7 @@ enum mod_hdcp_status mod_hdcp_hdcp2_enable_encryption(struct mod_hdcp *hdcp)
 {
 	struct psp_context *psp = hdcp->config.psp.handle;
 	struct ta_hdcp_shared_memory *hdcp_cmd;
-	struct mod_hdcp_display *display = get_first_added_display(hdcp);
+	struct mod_hdcp_display *display = get_first_active_display(hdcp);
 
 	hdcp_cmd = (struct ta_hdcp_shared_memory *)psp->hdcp_context.hdcp_shared_buf;
 	memset(hdcp_cmd, 0, sizeof(struct ta_hdcp_shared_memory));
@@ -747,8 +743,7 @@ enum mod_hdcp_status mod_hdcp_hdcp2_enable_dp_stream_encryption(struct mod_hdcp
 
 
 	for (i = 0; i < MAX_NUM_OF_DISPLAYS; i++) {
-		if (hdcp->displays[i].state != MOD_HDCP_DISPLAY_ACTIVE_AND_ADDED ||
-		    hdcp->displays[i].adjust.disable)
+		if (hdcp->displays[i].adjust.disable)
 			continue;
 		hdcp_cmd->in_msg.hdcp2_enable_dp_stream_encryption.display_handle = hdcp->displays[i].index;
 		hdcp_cmd->in_msg.hdcp2_enable_dp_stream_encryption.session_handle = hdcp->auth.id;
diff --git a/drivers/gpu/drm/amd/display/modules/inc/mod_hdcp.h b/drivers/gpu/drm/amd/display/modules/inc/mod_hdcp.h
index c088602bc1a0..eae9309cfb24 100644
--- a/drivers/gpu/drm/amd/display/modules/inc/mod_hdcp.h
+++ b/drivers/gpu/drm/amd/display/modules/inc/mod_hdcp.h
@@ -117,7 +117,6 @@ enum mod_hdcp_operation_mode {
 enum mod_hdcp_display_state {
 	MOD_HDCP_DISPLAY_INACTIVE = 0,
 	MOD_HDCP_DISPLAY_ACTIVE,
-	MOD_HDCP_DISPLAY_ACTIVE_AND_ADDED,
 	MOD_HDCP_DISPLAY_ENCRYPTION_ENABLED
 };
 
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
