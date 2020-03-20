Return-Path: <SRS0=S2wj=5F=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B3B2C43332
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Mar 2020 15:11:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 325FE2072D
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Mar 2020 15:11:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="fLXJCLej"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 325FE2072D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 671FB6E18F;
	Fri, 20 Mar 2020 15:11:55 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770075.outbound.protection.outlook.com [40.107.77.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC0F06E186
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Mar 2020 15:11:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lF9aPKhftV1LXUflVVsKp0uQopa0b2vs+Hc16oPWRXymonxf0R+8g41CO3rkNOvvIjDNEV+oURCmFgEjsW49d3faivhRYbo4owR5JdACoS+dUFSFUQ0+ZyYefhBML/an2ASsRfvQrHxKQu7jjvWyIS/0wV9C7pGO0yi2nU09gq2rfJc4vHMjmZwZ4/xhIGyE+3tptItkMI6PPHlAb26EeoJJQs57g1IjeZ47w1zQjv1IH2BkSKCq18GvlMRkqfjQSEw5ygxpjvaxc9Iop9Mldo0Xa9pE9VvCBIcFnwMId9TjFr/wcnBBeU1XtlFQRsU+4drESNuphQ46hmwFHtzYhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nIcCFNSeiT3J+TTsmzzkXfNd/bsTyr7x80PJMgzaKDE=;
 b=fzGGlYF3GsVcETLAopO7RsZXHjV1BfwsQENm3Hp08ujb1AYkOMWFW242dotSDBDxNwJ3xK7Z6vLgy2NA+CVsc838ZrVaeKj/qyeryRGNFIk4b3MxOCrktNX3efQAwQf4++dOKP24mX6pD6yEdLCJDLhrn+h0gW9axmd9NE1GCBc1gannZitNGLfLy3hZh/ynQBS/jaZ7EA7liguL2z2Wqz1qEdJsi2MUcLg+RwmEy/OF+ic3omEopa11SHsoXZeUHXg+UaKFRysllBL5vXAUJuRdvgAVnMDKdr7lPZJfoeBifHpwWWNQBEC6f01dknvveWiRX+a4+zU5G3RNCeywDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nIcCFNSeiT3J+TTsmzzkXfNd/bsTyr7x80PJMgzaKDE=;
 b=fLXJCLejF844uT9zYg4+8xLLEf3+rxIZQPHWkbUd7Zk0aiz15yB7U83TFI7lHt7SuZVp8+8WzJfYLPBiH4gLDvkRu7qKqqlX1cgJM5uk98i8cTOSLYMoQSnZ5hNnaiospcoAAvsuhiALvKfu7tCwPlIZVwUG3OAYu8XB3BCD78Q=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (2603:10b6:907:9::27)
 by MW2PR12MB2572.namprd12.prod.outlook.com (2603:10b6:907:6::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.18; Fri, 20 Mar
 2020 15:11:52 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5%6]) with mapi id 15.20.2814.021; Fri, 20 Mar 2020
 15:11:52 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 07/12] drm/amd/display: Revert change to HDCP display states
Date: Fri, 20 Mar 2020 11:11:23 -0400
Message-Id: <20200320151128.2039940-8-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200320151128.2039940-1-Rodrigo.Siqueira@amd.com>
References: <20200320151128.2039940-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YTXPR0101CA0055.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::32) To MW2PR12MB2524.namprd12.prod.outlook.com
 (2603:10b6:907:9::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.hitronhub.home (2607:fea8:56a0:11a1::4) by
 YTXPR0101CA0055.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.18 via Frontend
 Transport; Fri, 20 Mar 2020 15:11:51 +0000
X-Mailer: git-send-email 2.25.2
X-Originating-IP: [2607:fea8:56a0:11a1::4]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 29b6416d-edf8-433c-71ff-08d7cce1051f
X-MS-TrafficTypeDiagnostic: MW2PR12MB2572:|MW2PR12MB2572:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB2572A9E0B98763E48AEF46F398F50@MW2PR12MB2572.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2000;
X-Forefront-PRVS: 03484C0ABF
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(366004)(39860400002)(376002)(396003)(136003)(199004)(81156014)(66556008)(6506007)(54906003)(4326008)(16526019)(2906002)(8936002)(186003)(81166006)(52116002)(2616005)(1076003)(8676002)(86362001)(66476007)(316002)(66946007)(6666004)(6486002)(36756003)(5660300002)(30864003)(6512007)(6916009)(478600001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MW2PR12MB2572;
 H:MW2PR12MB2524.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eKMt34kOo5rAgEZSPGhlka/Zx37zYNjRXWy1q5PvUoD0O7eMB185i4h1QSpi576R/IENyyaR+LWrGI4XmvtWGW59YSV1nzTWSx1Bcpct/ZJIYcxMJRl7kfNMRHHt0t62kA3cYkOvdynL4pPYvwqXXjmZP5DVj7oe6dLVDFd+FUAu97pEG/tsWkQ2eqyHuHKEJbcIfbKdm6ND4hzAnetTFevHPR+8g01dok+WZtcgYr4wthEKvxyGzigz4qywjEJGjyBgEp/iqevNViRAmwWrSu0sswAj1+76+GzZwjvDaV8SvohWx5Akm6nomgGZP+j4bIs5+kuVor3cZeH24DOeQE3h5sp8Cw4Wpcj0Ltx84SsrSYxZvxuVD0OBMq7VCQ6yV2TJvUFqtUFrotfD5lKgnWpe7oN8I/tqZzjOmQN1a4oF2c+dbyUERcFhqbplpDSE
X-MS-Exchange-AntiSpam-MessageData: OPAcku3EJgg/CUBY/Ykxv2Z0HkPiyvG2CFcTweRDoYhG3MLIUKzosWtpKk0DlJhEJjUlhqMG9rqXksB78Llq4mSJeVoK0plvWS094LKEyLqgb2jGEtmMn32PHzAlcX4c/bM5ciY1daSNqa6W5py+fj/+BMscz5aJvkM/PNArnMA=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29b6416d-edf8-433c-71ff-08d7cce1051f
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2020 15:11:52.4058 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aj5nlqCUUgABTs/FGyqRDQJLFdPO/qj3Ju8PMoe3EhGwki0jdqJdCgdRIWlaV/AyUPsbmgvuT6Fl2dxOAW3hcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2572
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
Cc: Sunpeng.Li@amd.com, Bhawanpreet.Lakha@amd.com,
 Yongqiang Sun <yongqiang.sun@amd.com>, Harry.Wentland@amd.com,
 Isabel Zhang <isabel.zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Isabel Zhang <isabel.zhang@amd.com>

[Why]
Change is causing a regression where the OPC app no longer functions
properly.

[How]
Revert the changelist causing the issue.

Signed-off-by: Isabel Zhang <isabel.zhang@amd.com>
Reviewed-by: Yongqiang Sun <yongqiang.sun@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../gpu/drm/amd/display/modules/hdcp/hdcp.c   |  5 +--
 .../gpu/drm/amd/display/modules/hdcp/hdcp.h   | 28 ++++++++++---
 .../display/modules/hdcp/hdcp1_execution.c    |  2 +-
 .../display/modules/hdcp/hdcp2_execution.c    |  2 +-
 .../drm/amd/display/modules/hdcp/hdcp_psp.c   | 39 +++++++++++--------
 .../drm/amd/display/modules/inc/mod_hdcp.h    |  1 +
 6 files changed, 49 insertions(+), 28 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp.c b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp.c
index e9fbd94f8635..cc1d3f470b99 100644
--- a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp.c
+++ b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp.c
@@ -328,8 +328,7 @@ enum mod_hdcp_status mod_hdcp_add_display(struct mod_hdcp *hdcp,
 	/* add display to connection */
 	hdcp->connection.link = *link;
 	*display_container = *display;
-	status = mod_hdcp_add_display_to_topology(hdcp, display_container);
-
+	status = mod_hdcp_add_display_to_topology(hdcp, display->index);
 	if (status != MOD_HDCP_STATUS_SUCCESS)
 		goto out;
 
@@ -375,7 +374,7 @@ enum mod_hdcp_status mod_hdcp_remove_display(struct mod_hdcp *hdcp,
 	status = mod_hdcp_remove_display_from_topology(hdcp, index);
 	if (status != MOD_HDCP_STATUS_SUCCESS)
 		goto out;
-	memset(display, 0, sizeof(struct mod_hdcp_display));
+	display->state = MOD_HDCP_DISPLAY_INACTIVE;
 
 	/* request authentication when connection is not reset */
 	if (current_state(hdcp) != HDCP_UNINITIALIZED)
diff --git a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp.h b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp.h
index 60ff1a0028ac..5cb4546be0ef 100644
--- a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp.h
+++ b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp.h
@@ -328,7 +328,7 @@ void mod_hdcp_dump_binary_message(uint8_t *msg, uint32_t msg_size,
 
 /* psp functions */
 enum mod_hdcp_status mod_hdcp_add_display_to_topology(
-		struct mod_hdcp *hdcp, struct mod_hdcp_display *display);
+		struct mod_hdcp *hdcp, uint8_t index);
 enum mod_hdcp_status mod_hdcp_remove_display_from_topology(
 		struct mod_hdcp *hdcp, uint8_t index);
 enum mod_hdcp_status mod_hdcp_hdcp1_create_session(struct mod_hdcp *hdcp);
@@ -503,6 +503,11 @@ static inline uint8_t is_display_active(struct mod_hdcp_display *display)
 	return display->state >= MOD_HDCP_DISPLAY_ACTIVE;
 }
 
+static inline uint8_t is_display_added(struct mod_hdcp_display *display)
+{
+	return display->state >= MOD_HDCP_DISPLAY_ACTIVE_AND_ADDED;
+}
+
 static inline uint8_t is_display_encryption_enabled(struct mod_hdcp_display *display)
 {
 	return display->state >= MOD_HDCP_DISPLAY_ENCRYPTION_ENABLED;
@@ -510,23 +515,34 @@ static inline uint8_t is_display_encryption_enabled(struct mod_hdcp_display *dis
 
 static inline uint8_t get_active_display_count(struct mod_hdcp *hdcp)
 {
-	uint8_t active_count = 0;
+	uint8_t added_count = 0;
 	uint8_t i;
 
 	for (i = 0; i < MAX_NUM_OF_DISPLAYS; i++)
 		if (is_display_active(&hdcp->displays[i]))
-			active_count++;
-	return active_count;
+			added_count++;
+	return added_count;
+}
+
+static inline uint8_t get_added_display_count(struct mod_hdcp *hdcp)
+{
+	uint8_t added_count = 0;
+	uint8_t i;
+
+	for (i = 0; i < MAX_NUM_OF_DISPLAYS; i++)
+		if (is_display_added(&hdcp->displays[i]))
+			added_count++;
+	return added_count;
 }
 
-static inline struct mod_hdcp_display *get_first_active_display(
+static inline struct mod_hdcp_display *get_first_added_display(
 		struct mod_hdcp *hdcp)
 {
 	uint8_t i;
 	struct mod_hdcp_display *display = NULL;
 
 	for (i = 0; i < MAX_NUM_OF_DISPLAYS; i++)
-		if (is_display_active(&hdcp->displays[i])) {
+		if (is_display_added(&hdcp->displays[i])) {
 			display = &hdcp->displays[i];
 			break;
 		}
diff --git a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp1_execution.c b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp1_execution.c
index f244b72e74e0..37c8c05497d6 100644
--- a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp1_execution.c
+++ b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp1_execution.c
@@ -129,7 +129,7 @@ static inline uint8_t get_device_count(struct mod_hdcp *hdcp)
 static inline enum mod_hdcp_status check_device_count(struct mod_hdcp *hdcp)
 {
 	/* device count must be greater than or equal to tracked hdcp displays */
-	return (get_device_count(hdcp) < get_active_display_count(hdcp)) ?
+	return (get_device_count(hdcp) < get_added_display_count(hdcp)) ?
 			MOD_HDCP_STATUS_HDCP1_DEVICE_COUNT_MISMATCH_FAILURE :
 			MOD_HDCP_STATUS_SUCCESS;
 }
diff --git a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp2_execution.c b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp2_execution.c
index 549c113abcf7..491c00f48026 100644
--- a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp2_execution.c
+++ b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp2_execution.c
@@ -208,7 +208,7 @@ static inline uint8_t get_device_count(struct mod_hdcp *hdcp)
 static enum mod_hdcp_status check_device_count(struct mod_hdcp *hdcp)
 {
 	/* device count must be greater than or equal to tracked hdcp displays */
-	return (get_device_count(hdcp) < get_active_display_count(hdcp)) ?
+	return (get_device_count(hdcp) < get_added_display_count(hdcp)) ?
 			MOD_HDCP_STATUS_HDCP2_DEVICE_COUNT_MISMATCH_FAILURE :
 			MOD_HDCP_STATUS_SUCCESS;
 }
diff --git a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.c b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.c
index 836e47954938..c2929815c3ee 100644
--- a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.c
+++ b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.c
@@ -54,7 +54,7 @@ enum mod_hdcp_status mod_hdcp_remove_display_from_topology(
 
 	dtm_cmd = (struct ta_dtm_shared_memory *)psp->dtm_context.dtm_shared_buf;
 
-	if (!display || !is_display_active(display))
+	if (!display || !is_display_added(display))
 		return MOD_HDCP_STATUS_DISPLAY_NOT_FOUND;
 
 	memset(dtm_cmd, 0, sizeof(struct ta_dtm_shared_memory));
@@ -73,21 +73,25 @@ enum mod_hdcp_status mod_hdcp_remove_display_from_topology(
 	HDCP_TOP_REMOVE_DISPLAY_TRACE(hdcp, display->index);
  
  	return MOD_HDCP_STATUS_SUCCESS;
- }
-
-enum mod_hdcp_status mod_hdcp_add_display_to_topology(
-		struct mod_hdcp *hdcp, struct mod_hdcp_display *display)
+ 
+}
+enum mod_hdcp_status mod_hdcp_add_display_to_topology(struct mod_hdcp *hdcp,
+						      uint8_t index)
 {
 	struct psp_context *psp = hdcp->config.psp.handle;
 	struct ta_dtm_shared_memory *dtm_cmd;
+	struct mod_hdcp_display *display =
+			get_active_display_at_index(hdcp, index);
 	struct mod_hdcp_link *link = &hdcp->connection.link;
 
 	if (!psp->dtm_context.dtm_initialized) {
 		DRM_ERROR("Failed to add display topology, DTM TA is not initialized.");
-		display->state = MOD_HDCP_DISPLAY_INACTIVE;
 		return MOD_HDCP_STATUS_FAILURE;
 	}
 
+	if (!display || is_display_added(display))
+		return MOD_HDCP_STATUS_UPDATE_TOPOLOGY_FAILURE;
+
 	dtm_cmd = (struct ta_dtm_shared_memory *)psp->dtm_context.dtm_shared_buf;
 
 	memset(dtm_cmd, 0, sizeof(struct ta_dtm_shared_memory));
@@ -109,11 +113,10 @@ enum mod_hdcp_status mod_hdcp_add_display_to_topology(
 
 	psp_dtm_invoke(psp, dtm_cmd->cmd_id);
 
-	if (dtm_cmd->dtm_status != TA_DTM_STATUS__SUCCESS) {
-		display->state = MOD_HDCP_DISPLAY_INACTIVE;
+	if (dtm_cmd->dtm_status != TA_DTM_STATUS__SUCCESS)
 		return MOD_HDCP_STATUS_UPDATE_TOPOLOGY_FAILURE;
-	}
 
+	display->state = MOD_HDCP_DISPLAY_ACTIVE_AND_ADDED;
 	HDCP_TOP_ADD_DISPLAY_TRACE(hdcp, display->index);
 
 	return MOD_HDCP_STATUS_SUCCESS;
@@ -123,7 +126,7 @@ enum mod_hdcp_status mod_hdcp_hdcp1_create_session(struct mod_hdcp *hdcp)
 {
 
 	struct psp_context *psp = hdcp->config.psp.handle;
-	struct mod_hdcp_display *display = get_first_active_display(hdcp);
+	struct mod_hdcp_display *display = get_first_added_display(hdcp);
 	struct ta_hdcp_shared_memory *hdcp_cmd;
 
 	if (!psp->hdcp_context.hdcp_initialized) {
@@ -176,7 +179,7 @@ enum mod_hdcp_status mod_hdcp_hdcp1_destroy_session(struct mod_hdcp *hdcp)
 		if (is_display_encryption_enabled(
 				&hdcp->displays[i])) {
 			hdcp->displays[i].state =
-								MOD_HDCP_DISPLAY_ACTIVE;
+					MOD_HDCP_DISPLAY_ACTIVE_AND_ADDED;
 			HDCP_HDCP1_DISABLED_TRACE(hdcp,
 					hdcp->displays[i].index);
 		}
@@ -228,7 +231,7 @@ enum mod_hdcp_status mod_hdcp_hdcp1_enable_encryption(struct mod_hdcp *hdcp)
 {
 	struct psp_context *psp = hdcp->config.psp.handle;
 	struct ta_hdcp_shared_memory *hdcp_cmd;
-	struct mod_hdcp_display *display = get_first_active_display(hdcp);
+	struct mod_hdcp_display *display = get_first_added_display(hdcp);
 
 	hdcp_cmd = (struct ta_hdcp_shared_memory *)psp->hdcp_context.hdcp_shared_buf;
 	memset(hdcp_cmd, 0, sizeof(struct ta_hdcp_shared_memory));
@@ -298,7 +301,8 @@ enum mod_hdcp_status mod_hdcp_hdcp1_enable_dp_stream_encryption(struct mod_hdcp
 
 	for (i = 0; i < MAX_NUM_OF_DISPLAYS; i++) {
 
-		if (hdcp->displays[i].adjust.disable)
+		if (hdcp->displays[i].state != MOD_HDCP_DISPLAY_ACTIVE_AND_ADDED ||
+		    hdcp->displays[i].adjust.disable)
 			continue;
 
 		memset(hdcp_cmd, 0, sizeof(struct ta_hdcp_shared_memory));
@@ -360,7 +364,7 @@ enum mod_hdcp_status mod_hdcp_hdcp2_create_session(struct mod_hdcp *hdcp)
 {
 	struct psp_context *psp = hdcp->config.psp.handle;
 	struct ta_hdcp_shared_memory *hdcp_cmd;
-	struct mod_hdcp_display *display = get_first_active_display(hdcp);
+	struct mod_hdcp_display *display = get_first_added_display(hdcp);
 
 	if (!psp->hdcp_context.hdcp_initialized) {
 		DRM_ERROR("Failed to create hdcp session, HDCP TA is not initialized");
@@ -419,7 +423,7 @@ enum mod_hdcp_status mod_hdcp_hdcp2_destroy_session(struct mod_hdcp *hdcp)
 		if (is_display_encryption_enabled(
 				&hdcp->displays[i])) {
 			hdcp->displays[i].state =
-								MOD_HDCP_DISPLAY_ACTIVE;
+					MOD_HDCP_DISPLAY_ACTIVE_AND_ADDED;
 			HDCP_HDCP2_DISABLED_TRACE(hdcp,
 					hdcp->displays[i].index);
 		}
@@ -658,7 +662,7 @@ enum mod_hdcp_status mod_hdcp_hdcp2_enable_encryption(struct mod_hdcp *hdcp)
 {
 	struct psp_context *psp = hdcp->config.psp.handle;
 	struct ta_hdcp_shared_memory *hdcp_cmd;
-	struct mod_hdcp_display *display = get_first_active_display(hdcp);
+	struct mod_hdcp_display *display = get_first_added_display(hdcp);
 
 	hdcp_cmd = (struct ta_hdcp_shared_memory *)psp->hdcp_context.hdcp_shared_buf;
 	memset(hdcp_cmd, 0, sizeof(struct ta_hdcp_shared_memory));
@@ -743,7 +747,8 @@ enum mod_hdcp_status mod_hdcp_hdcp2_enable_dp_stream_encryption(struct mod_hdcp
 
 
 	for (i = 0; i < MAX_NUM_OF_DISPLAYS; i++) {
-		if (hdcp->displays[i].adjust.disable)
+		if (hdcp->displays[i].state != MOD_HDCP_DISPLAY_ACTIVE_AND_ADDED ||
+		    hdcp->displays[i].adjust.disable)
 			continue;
 		hdcp_cmd->in_msg.hdcp2_enable_dp_stream_encryption.display_handle = hdcp->displays[i].index;
 		hdcp_cmd->in_msg.hdcp2_enable_dp_stream_encryption.session_handle = hdcp->auth.id;
diff --git a/drivers/gpu/drm/amd/display/modules/inc/mod_hdcp.h b/drivers/gpu/drm/amd/display/modules/inc/mod_hdcp.h
index eae9309cfb24..c088602bc1a0 100644
--- a/drivers/gpu/drm/amd/display/modules/inc/mod_hdcp.h
+++ b/drivers/gpu/drm/amd/display/modules/inc/mod_hdcp.h
@@ -117,6 +117,7 @@ enum mod_hdcp_operation_mode {
 enum mod_hdcp_display_state {
 	MOD_HDCP_DISPLAY_INACTIVE = 0,
 	MOD_HDCP_DISPLAY_ACTIVE,
+	MOD_HDCP_DISPLAY_ACTIVE_AND_ADDED,
 	MOD_HDCP_DISPLAY_ENCRYPTION_ENABLED
 };
 
-- 
2.25.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
