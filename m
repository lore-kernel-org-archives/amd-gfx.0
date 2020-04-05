Return-Path: <SRS0=w0EQ=5V=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26990C2BA1B
	for <amd-gfx@archiver.kernel.org>; Sun,  5 Apr 2020 20:41:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE5A620644
	for <amd-gfx@archiver.kernel.org>; Sun,  5 Apr 2020 20:41:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="FWLa6vSM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE5A620644
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D322989FE8;
	Sun,  5 Apr 2020 20:41:47 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2070.outbound.protection.outlook.com [40.107.236.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 369B789EA6
 for <amd-gfx@lists.freedesktop.org>; Sun,  5 Apr 2020 20:41:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nAc0StDz9Tqdbp/HZt0bHzrd/fWdXThTiKh8Pk7s0q3gKRaaaDm/AaHu6YNiizPSoo5My/G1T7VSqEcckvmh5n9fa6cxlfLk77q3PcqBIjir8OuIEXsApblYggMfFva/E0GKAwOWzLwMEUJvyaTBdafXSuQgPC/GtoHAi/qw0s9IrcqwHuU6HhOPGlDdoID6uSXo0V1QpMJuK8WXJHrXbBPFct+B7YUy8/xG/KBcRws7dV+s7nNRkkSC9tmPW7vgOjNC8eMyS3vXh9a8mhYeTLewfJp3HoTIuN9BgwqkXDl7WwktOJtW3hXkBN0e9UBwQID6Fwm8m8bCdiiznONiWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eY6kGJzED/j8YdJ7iaR7/bh02/NkzoZgZKXag93Wtlg=;
 b=VLTz4mH7dr5dAGvzMpfyIrM3NGNF7G0YtglEOLwNywmr4ruWAI78I/vEN9QH8+NeZAiwdf2IrtctmrlqmDeu+9ewClG7TI4ODv/qut3a81ZwpubWKsk4ngTm60aanxyS/uOvsKn5WklG2RjbzYgJYNYrZ+X5l33RKvKaZu5NfRHaMmjR+2eCfbgAO5w+d4usei01j9U8eHcs0ZPqSCtaQVbJRtF+f574fqEnImhr5IjU9XacUQeOQa2iOFELY7YQVfPq8Ea7/h6RtZrhEBt3w2q4r6T+yWRDsao3HZRB0yrTo5p2v9VfgqweQShuMmDHtcV3GkCwQ0Uz3BGV9sQIBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eY6kGJzED/j8YdJ7iaR7/bh02/NkzoZgZKXag93Wtlg=;
 b=FWLa6vSMSaOVBI8TXq7hJ0DfyY4GamQJm0nevz8SPx7Nc0XGZbiv7zxiHDTJEhwQGS3nzE2hQYCLGF9J2wNSmJsnmYp0WpQJRfaKfkuRaE1fcxfQcDJTpB+kUoRfZEEjpWamP2aKXv/qt5PJxZLHCTHnSvRGQ8ZC0/BAX/sLizM=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (2603:10b6:907:9::27)
 by MW2PR12MB2555.namprd12.prod.outlook.com (2603:10b6:907:b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.15; Sun, 5 Apr
 2020 20:41:43 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5%6]) with mapi id 15.20.2878.018; Sun, 5 Apr 2020
 20:41:43 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 05/36] drm/amd/display: Remove hdcp display state with mst fix
Date: Sun,  5 Apr 2020 16:40:44 -0400
Message-Id: <20200405204115.683559-6-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200405204115.683559-1-Rodrigo.Siqueira@amd.com>
References: <20200405204115.683559-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YTXPR0101CA0049.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::26) To MW2PR12MB2524.namprd12.prod.outlook.com
 (2603:10b6:907:9::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.hitronhub.home (2607:fea8:56a0:11a1::4) by
 YTXPR0101CA0049.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.16 via Frontend
 Transport; Sun, 5 Apr 2020 20:41:42 +0000
X-Mailer: git-send-email 2.26.0
X-Originating-IP: [2607:fea8:56a0:11a1::4]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 65dc49d4-3314-4329-b445-08d7d9a1c038
X-MS-TrafficTypeDiagnostic: MW2PR12MB2555:|MW2PR12MB2555:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB2555B8EC03C255A0F240B16398C50@MW2PR12MB2555.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:169;
X-Forefront-PRVS: 03648EFF89
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB2524.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(376002)(396003)(39860400002)(366004)(346002)(136003)(1076003)(8676002)(6916009)(8936002)(6486002)(81156014)(81166006)(30864003)(16526019)(52116002)(36756003)(2906002)(6512007)(186003)(86362001)(316002)(54906003)(6506007)(66556008)(66476007)(2616005)(66946007)(478600001)(4326008)(5660300002);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +bITeBTNGGSx3Gr8/U/hQV6vl5uvK/NOpqjpXSSsN3vz8Xtk1wbjk17HJvAbA998s0KKLsBa8ncliCoVj3U2owhJ3Sgz9FQIFshLOVFci+NMgK/UwV4UuBxYDX2Xtx2wpTZYctkRJFUv1R3fm9KZZySoRJZJKKMm2tlezFKAXQy2bll3Pgm856lQSgUPvFV5hsKm9mk8AGs63aBdiEcvjxLV0wgyWabA6FsLsS2XsYnVMpQLeDqFRF+5TJZ+NVUM6D2clHsx8VxTN/bOjAN5FHr7XsKITDR6NqQAfVkfjtpbzT4LrBbw5E23CM0SfyaMjQlopVdYZ6sATSFUUdN6wYUX7iwSUJH/OlWP/tnNDsIUVRNG5QDoPjsetnGXkEX/lMwlCMCMzUXtTz7HDElW7IRDbT+EdBMTUz9CJBxB0lUag4m/VVL26U5HWGJMuSFT
X-MS-Exchange-AntiSpam-MessageData: 9tmP3ZlGG307tvMga/Rj/8DDWFHBxtM/0evj9LXnyTMWA2DpzcUBbwRU1WdSbE1bEMYSTm5pHEyiQnawKVYhy5HsBVwhduwlZbbZCpFTLwZtCt1q45uN3h7S1Kct/N4FBiXpcfth9LOpmM4CsBWix6Y+AgoATlyNUnkRHE+wmEE=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65dc49d4-3314-4329-b445-08d7d9a1c038
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2020 20:41:43.5967 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AGsw+t20Z49CORH3K9lkJ4z0L7c5rM4r3DD9V5ODaBwjV+E0X81sixCQQbwo7JxPtISWewFf1RsVOWjQwZfzrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2555
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
Cc: Sunpeng.Li@amd.com, Bhawanpreet.Lakha@amd.com, Harry.Wentland@amd.com,
 Wenjing Liu <Wenjing.Liu@amd.com>, Isabel Zhang <isabel.zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Isabel Zhang <isabel.zhang@amd.com>

[Why]
Due to previous code changes, displays transition from active to active
and added state immediately, making it redundant to have both display
states. Previous change to fix this caused HDCP to get into a bad state
when monitor is connected to MST hub, this change fixes that issue.

[How]
Change code behavior so when a device is added successfully the state
remains as active and when addition is unsuccessful change state to
inactive. This removes need for added and active state.

Signed-off-by: Isabel Zhang <isabel.zhang@amd.com>
Reviewed-by: Wenjing Liu <Wenjing.Liu@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../gpu/drm/amd/display/modules/hdcp/hdcp.c   |  5 ++-
 .../gpu/drm/amd/display/modules/hdcp/hdcp.h   | 28 +++----------
 .../display/modules/hdcp/hdcp1_execution.c    |  2 +-
 .../display/modules/hdcp/hdcp2_execution.c    |  2 +-
 .../drm/amd/display/modules/hdcp/hdcp_psp.c   | 40 +++++++++----------
 .../drm/amd/display/modules/inc/mod_hdcp.h    |  1 -
 6 files changed, 29 insertions(+), 49 deletions(-)

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
index c2929815c3ee..1b54f169392a 100644
--- a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.c
+++ b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.c
@@ -54,7 +54,7 @@ enum mod_hdcp_status mod_hdcp_remove_display_from_topology(
 
 	dtm_cmd = (struct ta_dtm_shared_memory *)psp->dtm_context.dtm_shared_buf;
 
-	if (!display || !is_display_added(display))
+	if (!display || !is_display_active(display))
 		return MOD_HDCP_STATUS_DISPLAY_NOT_FOUND;
 
 	memset(dtm_cmd, 0, sizeof(struct ta_dtm_shared_memory));
@@ -75,23 +75,19 @@ enum mod_hdcp_status mod_hdcp_remove_display_from_topology(
  	return MOD_HDCP_STATUS_SUCCESS;
  
 }
-enum mod_hdcp_status mod_hdcp_add_display_to_topology(struct mod_hdcp *hdcp,
-						      uint8_t index)
+enum mod_hdcp_status mod_hdcp_add_display_to_topology(
+			struct mod_hdcp *hdcp, struct mod_hdcp_display *display)
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
@@ -113,10 +109,11 @@ enum mod_hdcp_status mod_hdcp_add_display_to_topology(struct mod_hdcp *hdcp,
 
 	psp_dtm_invoke(psp, dtm_cmd->cmd_id);
 
-	if (dtm_cmd->dtm_status != TA_DTM_STATUS__SUCCESS)
+	if (dtm_cmd->dtm_status != TA_DTM_STATUS__SUCCESS) {
+		display->state = MOD_HDCP_DISPLAY_INACTIVE;
 		return MOD_HDCP_STATUS_UPDATE_TOPOLOGY_FAILURE;
+	}
 
-	display->state = MOD_HDCP_DISPLAY_ACTIVE_AND_ADDED;
 	HDCP_TOP_ADD_DISPLAY_TRACE(hdcp, display->index);
 
 	return MOD_HDCP_STATUS_SUCCESS;
@@ -126,7 +123,7 @@ enum mod_hdcp_status mod_hdcp_hdcp1_create_session(struct mod_hdcp *hdcp)
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
@@ -301,9 +298,8 @@ enum mod_hdcp_status mod_hdcp_hdcp1_enable_dp_stream_encryption(struct mod_hdcp
 
 	for (i = 0; i < MAX_NUM_OF_DISPLAYS; i++) {
 
-		if (hdcp->displays[i].state != MOD_HDCP_DISPLAY_ACTIVE_AND_ADDED ||
-		    hdcp->displays[i].adjust.disable)
-			continue;
+		if (hdcp->displays[i].adjust.disable || hdcp->displays[i].state != MOD_HDCP_DISPLAY_ACTIVE)
+				continue;
 
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
@@ -747,9 +743,9 @@ enum mod_hdcp_status mod_hdcp_hdcp2_enable_dp_stream_encryption(struct mod_hdcp
 
 
 	for (i = 0; i < MAX_NUM_OF_DISPLAYS; i++) {
-		if (hdcp->displays[i].state != MOD_HDCP_DISPLAY_ACTIVE_AND_ADDED ||
-		    hdcp->displays[i].adjust.disable)
-			continue;
+		if (hdcp->displays[i].adjust.disable || hdcp->displays[i].state != MOD_HDCP_DISPLAY_ACTIVE)
+				continue;
+
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
2.26.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
