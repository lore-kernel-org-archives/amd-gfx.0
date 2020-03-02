Return-Path: <SRS0=ZiRI=4T=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DCA0C3F2D1
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Mar 2020 16:47:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8EEE21D56
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Mar 2020 16:47:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="JJ7iIBBl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8EEE21D56
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D8176E5C1;
	Mon,  2 Mar 2020 16:47:54 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750074.outbound.protection.outlook.com [40.107.75.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C8226E5BD
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Mar 2020 16:47:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OForFbgasR1Y8lovCOd06vCn2CfltkbY8tUm2vKgTXt105VhPEwEN+R0WnMkaBrsoE0MQfYTy3IlxCh79ipPtj60LK8XKkWNSKKOuOLq1/zVMtyyw3y18254P2nhltwD5apv/0aUndrJ2x0efZOPggyylhpGd/z0TK1XuarDouS7xWV6ntSuV5QgJ2VWNDX/74EEBVJbMf1CqFm6wy4lmlrjWxCjGO7JU4Ygd0Vw92JnX2ExOvi3Bnk5xTp/GeDlJXwKaPUx3tEpjVj+5NqgOSKDEGw4PZxVkiGN6fxrtm+pXfAVQIbuDJjIMUQN5PfjEa0sYENC0AaTQ3Ck0SsYgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TzsIu9WSfTv/00BXqZ79y7JmEfZ55h3A7Xr7wfjlA0E=;
 b=kvPcmDWwBb0V/SXith6bgDXLSBe6yno/W8Lu/ixLoiCGizhPYPijOoC/tGQ1zvuARkeFi02sOBFH2/xPZhvhaZ3eZFIS1gY/bnUE4t7prKbvCch+vw5SmU7sQiSGmLH0DTppJl8AE+hYP8lx3xBWcai/dQ7wCvd2BMdkoSZgjFKmpgO+NxRBqK40K5LROhTFB5QekOJ+N40yHj2VD+zZSnA51yCatE68jQ1FGV7qYnrGYhyJAdoQpJW8VyJca+VR9Z1AkWye58h7PCiSa23gbXODeQUtConIoGq6PLDSqgG8gDbH5qHjwnVlOzMupDZhg/y81J4IeMpmR+5YqjKexQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TzsIu9WSfTv/00BXqZ79y7JmEfZ55h3A7Xr7wfjlA0E=;
 b=JJ7iIBBlfXEzaWDox7qcgWyyKrBXwi4POIzsNc1PrULL5XmtvAWDJ7x/kS91I31TBp0dRyTUWeuuWRdkQA5dkU1EFZDM6ULSkHkEljd6AJ1Xo/GnlsUo5OUFlfI4xV/RMovQcj8T2a017K3yoqjx0AljbowsSdceujeOwflI3NA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (2603:10b6:907:9::27)
 by MW2PR12MB2411.namprd12.prod.outlook.com (2603:10b6:907:10::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.19; Mon, 2 Mar
 2020 16:47:51 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5%6]) with mapi id 15.20.2772.019; Mon, 2 Mar 2020
 16:47:51 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 02/22] drm/amd/display: Move mod_hdcp_displays to mod_hdcp
 struct
Date: Mon,  2 Mar 2020 11:47:16 -0500
Message-Id: <20200302164736.89429-3-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200302164736.89429-1-Rodrigo.Siqueira@amd.com>
References: <20200302164736.89429-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YTBPR01CA0021.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::34) To MW2PR12MB2524.namprd12.prod.outlook.com
 (2603:10b6:907:9::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.amd.com (165.204.55.250) by
 YTBPR01CA0021.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::34) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.14 via Frontend Transport; Mon, 2 Mar 2020 16:47:50 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1487ea8c-2bf0-4ad1-c912-08d7bec97238
X-MS-TrafficTypeDiagnostic: MW2PR12MB2411:|MW2PR12MB2411:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB24117F981DB1F2EEADDD5EA998E70@MW2PR12MB2411.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:178;
X-Forefront-PRVS: 033054F29A
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(396003)(346002)(136003)(376002)(366004)(199004)(189003)(66946007)(6916009)(6666004)(54906003)(8676002)(316002)(4326008)(66556008)(478600001)(36756003)(66476007)(8936002)(2616005)(1076003)(956004)(81156014)(186003)(81166006)(16526019)(86362001)(2906002)(52116002)(7696005)(26005)(6486002)(5660300002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MW2PR12MB2411;
 H:MW2PR12MB2524.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: den7S5/TW8ZbHLH1Bs9zkQKFrQZUzbgJyk6OCrDcKQiC184cajspK48/4rwXdsSmYqPXkEuo8lD8frSHHNPqXCWMo4O5Zl6r54pxxtPDTg0QSzJqkslnNIH4bbYct2mhXE2n/p1FGiHGuy9LbEWg3pLqQss7MySz6R5fndYz5bAj2w12H+S/7sZ7OYn4EBz2Pmc1+0kE3XI2bL9CKMjk7YhmoqSI5QfmHlWVuMlsVJPODhkN/qBN9iguuHZscSrUoS56ElqnUg+TeDb/eZAVpz6ZlQSKrgtrXvEftjR9mNo8zuERT7krVP1AQ57JM7T6fV8ZeDy6pUvDfNUlyb77omHKwaj1HgFsl0hAEWM4Imw7nKX7yF2sY7rcoAVEK4g9Yd2hIRNDXX45BSSwCvg+VHbmtjqT+ra5BUOaz0OyaJBG0gzWVAL+MYyhy1FefMWS
X-MS-Exchange-AntiSpam-MessageData: 4JtYTLgtm2quAUsU7PUAV7NptIdGgVFLUpf6ZGP+L6+9FIP3Wn15u8vvdIXKwC//dFBppyjsKjSvwXST+01Og5eGeukmCPChl1U3sT3OMQOHyq6FOHtddpJGLnK60TgE8ihp3/gEkwV8LLk1vrgSkg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1487ea8c-2bf0-4ad1-c912-08d7bec97238
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2020 16:47:51.2741 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hkbrcjtPVubO8pivxVoddKaXhma7SaT1xs/lf4S2gvJS188NRpZytOhxctDJlbRGAG4lQGJP3oJV+jRA/3om+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2411
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
 Wenjing Liu <Wenjing.Liu@amd.com>, Tony Cheng <Tony.Cheng@amd.com>,
 Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Isabel Zhang <isabel.zhang@amd.com>

[Why]
Reset connection is called before remove display in mod_hdcp. When
remove display is called, the display structure has been zeroed from
reset connection. Since no displays can be found, remove display does
not properly reset the hardware. This causes validation errors when
another display is plugged into a different port afterwards.

[How]
Moved displays structure out of connections structure. Displays
structure is now directly within mod_hdcp. Displays is no longer zeroed
when reset connection is called.

Signed-off-by: Isabel Zhang <isabel.zhang@amd.com>
Reviewed-by: Wenjing Liu <Wenjing.Liu@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Acked-by: Tony Cheng <Tony.Cheng@amd.com>
---
 .../gpu/drm/amd/display/modules/hdcp/hdcp.c   | 12 +++----
 .../gpu/drm/amd/display/modules/hdcp/hdcp.h   | 21 ++++++------
 .../drm/amd/display/modules/hdcp/hdcp_psp.c   | 32 +++++++++----------
 3 files changed, 33 insertions(+), 32 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp.c b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp.c
index 83eaec4c6ad7..bcba93d3b195 100644
--- a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp.c
+++ b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp.c
@@ -52,8 +52,8 @@ static uint8_t is_cp_desired_hdcp1(struct mod_hdcp *hdcp)
 	 * hdcp is not desired
 	 */
 	for (i = 0; i < MAX_NUM_OF_DISPLAYS; i++) {
-		if (hdcp->connection.displays[i].state != MOD_HDCP_DISPLAY_INACTIVE &&
-				!hdcp->connection.displays[i].adjust.disable) {
+		if (hdcp->displays[i].state != MOD_HDCP_DISPLAY_INACTIVE &&
+				!hdcp->displays[i].adjust.disable) {
 			is_auth_needed = 1;
 			break;
 		}
@@ -73,8 +73,8 @@ static uint8_t is_cp_desired_hdcp2(struct mod_hdcp *hdcp)
 	 * hdcp is not desired
 	 */
 	for (i = 0; i < MAX_NUM_OF_DISPLAYS; i++) {
-		if (hdcp->connection.displays[i].state != MOD_HDCP_DISPLAY_INACTIVE &&
-				!hdcp->connection.displays[i].adjust.disable) {
+		if (hdcp->displays[i].state != MOD_HDCP_DISPLAY_INACTIVE &&
+				!hdcp->displays[i].adjust.disable) {
 			is_auth_needed = 1;
 			break;
 		}
@@ -373,8 +373,8 @@ enum mod_hdcp_status mod_hdcp_remove_display(struct mod_hdcp *hdcp,
 		goto out;
 	display->state = MOD_HDCP_DISPLAY_INACTIVE;
 
-	/* request authentication for remaining displays*/
-	if (get_active_display_count(hdcp) > 0)
+	/* request authentication when connection is not reset */
+	if (current_state(hdcp) != HDCP_UNINITIALIZED)
 		callback_in_ms(hdcp->connection.link.adjust.auth_delay * 1000,
 				output);
 out:
diff --git a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp.h b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp.h
index b09d2f5502b3..77fdcec4263e 100644
--- a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp.h
+++ b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp.h
@@ -165,7 +165,6 @@ struct mod_hdcp_auth_counters {
 /* contains values per connection */
 struct mod_hdcp_connection {
 	struct mod_hdcp_link link;
-	struct mod_hdcp_display displays[MAX_NUM_OF_DISPLAYS];
 	uint8_t is_repeater;
 	uint8_t is_km_stored;
 	uint8_t is_hdcp1_revoked;
@@ -201,6 +200,8 @@ struct mod_hdcp {
 	struct mod_hdcp_config config;
 	/* per connection */
 	struct mod_hdcp_connection connection;
+	/* per displays */
+	struct mod_hdcp_display displays[MAX_NUM_OF_DISPLAYS];
 	/* per authentication attempt */
 	struct mod_hdcp_authentication auth;
 	/* per state in an authentication */
@@ -518,7 +519,7 @@ static inline uint8_t get_active_display_count(struct mod_hdcp *hdcp)
 	uint8_t i;
 
 	for (i = 0; i < MAX_NUM_OF_DISPLAYS; i++)
-		if (is_display_active(&hdcp->connection.displays[i]))
+		if (is_display_active(&hdcp->displays[i]))
 			added_count++;
 	return added_count;
 }
@@ -529,7 +530,7 @@ static inline uint8_t get_added_display_count(struct mod_hdcp *hdcp)
 	uint8_t i;
 
 	for (i = 0; i < MAX_NUM_OF_DISPLAYS; i++)
-		if (is_display_added(&hdcp->connection.displays[i]))
+		if (is_display_added(&hdcp->displays[i]))
 			added_count++;
 	return added_count;
 }
@@ -541,8 +542,8 @@ static inline struct mod_hdcp_display *get_first_added_display(
 	struct mod_hdcp_display *display = NULL;
 
 	for (i = 0; i < MAX_NUM_OF_DISPLAYS; i++)
-		if (is_display_added(&hdcp->connection.displays[i])) {
-			display = &hdcp->connection.displays[i];
+		if (is_display_added(&hdcp->displays[i])) {
+			display = &hdcp->displays[i];
 			break;
 		}
 	return display;
@@ -555,9 +556,9 @@ static inline struct mod_hdcp_display *get_active_display_at_index(
 	struct mod_hdcp_display *display = NULL;
 
 	for (i = 0; i < MAX_NUM_OF_DISPLAYS; i++)
-		if (hdcp->connection.displays[i].index == index &&
-				is_display_active(&hdcp->connection.displays[i])) {
-			display = &hdcp->connection.displays[i];
+		if (hdcp->displays[i].index == index &&
+				is_display_active(&hdcp->displays[i])) {
+			display = &hdcp->displays[i];
 			break;
 		}
 	return display;
@@ -570,8 +571,8 @@ static inline struct mod_hdcp_display *get_empty_display_container(
 	struct mod_hdcp_display *display = NULL;
 
 	for (i = 0; i < MAX_NUM_OF_DISPLAYS; i++)
-		if (!is_display_active(&hdcp->connection.displays[i])) {
-			display = &hdcp->connection.displays[i];
+		if (!is_display_active(&hdcp->displays[i])) {
+			display = &hdcp->displays[i];
 			break;
 		}
 	return display;
diff --git a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.c b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.c
index d9cb2383d6de..b87e9d2862bc 100644
--- a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.c
+++ b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.c
@@ -177,11 +177,11 @@ enum mod_hdcp_status mod_hdcp_hdcp1_destroy_session(struct mod_hdcp *hdcp)
 	HDCP_TOP_HDCP1_DESTROY_SESSION_TRACE(hdcp);
 	for (i = 0; i < MAX_NUM_OF_DISPLAYS; i++)
 		if (is_display_encryption_enabled(
-				&hdcp->connection.displays[i])) {
-			hdcp->connection.displays[i].state =
+				&hdcp->displays[i])) {
+			hdcp->displays[i].state =
 					MOD_HDCP_DISPLAY_ACTIVE_AND_ADDED;
 			HDCP_HDCP1_DISABLED_TRACE(hdcp,
-					hdcp->connection.displays[i].index);
+					hdcp->displays[i].index);
 		}
 
 	return MOD_HDCP_STATUS_SUCCESS;
@@ -301,14 +301,14 @@ enum mod_hdcp_status mod_hdcp_hdcp1_enable_dp_stream_encryption(struct mod_hdcp
 
 	for (i = 0; i < MAX_NUM_OF_DISPLAYS; i++) {
 
-		if (hdcp->connection.displays[i].state != MOD_HDCP_DISPLAY_ACTIVE_AND_ADDED ||
-		    hdcp->connection.displays[i].adjust.disable)
+		if (hdcp->displays[i].state != MOD_HDCP_DISPLAY_ACTIVE_AND_ADDED ||
+		    hdcp->displays[i].adjust.disable)
 			continue;
 
 		memset(hdcp_cmd, 0, sizeof(struct ta_hdcp_shared_memory));
 
 		hdcp_cmd->in_msg.hdcp1_enable_dp_stream_encryption.session_handle = hdcp->auth.id;
-		hdcp_cmd->in_msg.hdcp1_enable_dp_stream_encryption.display_handle = hdcp->connection.displays[i].index;
+		hdcp_cmd->in_msg.hdcp1_enable_dp_stream_encryption.display_handle = hdcp->displays[i].index;
 		hdcp_cmd->cmd_id = TA_HDCP_COMMAND__HDCP1_ENABLE_DP_STREAM_ENCRYPTION;
 
 		psp_hdcp_invoke(psp, hdcp_cmd->cmd_id);
@@ -316,8 +316,8 @@ enum mod_hdcp_status mod_hdcp_hdcp1_enable_dp_stream_encryption(struct mod_hdcp
 		if (hdcp_cmd->hdcp_status != TA_HDCP_STATUS__SUCCESS)
 			return MOD_HDCP_STATUS_HDCP1_ENABLE_STREAM_ENCRYPTION_FAILURE;
 
-		hdcp->connection.displays[i].state = MOD_HDCP_DISPLAY_ENCRYPTION_ENABLED;
-		HDCP_HDCP1_ENABLED_TRACE(hdcp, hdcp->connection.displays[i].index);
+		hdcp->displays[i].state = MOD_HDCP_DISPLAY_ENCRYPTION_ENABLED;
+		HDCP_HDCP1_ENABLED_TRACE(hdcp, hdcp->displays[i].index);
 	}
 
 	return MOD_HDCP_STATUS_SUCCESS;
@@ -421,11 +421,11 @@ enum mod_hdcp_status mod_hdcp_hdcp2_destroy_session(struct mod_hdcp *hdcp)
 	HDCP_TOP_HDCP2_DESTROY_SESSION_TRACE(hdcp);
 	for (i = 0; i < MAX_NUM_OF_DISPLAYS; i++)
 		if (is_display_encryption_enabled(
-				&hdcp->connection.displays[i])) {
-			hdcp->connection.displays[i].state =
+				&hdcp->displays[i])) {
+			hdcp->displays[i].state =
 					MOD_HDCP_DISPLAY_ACTIVE_AND_ADDED;
 			HDCP_HDCP2_DISABLED_TRACE(hdcp,
-					hdcp->connection.displays[i].index);
+					hdcp->displays[i].index);
 		}
 
 	return MOD_HDCP_STATUS_SUCCESS;
@@ -747,10 +747,10 @@ enum mod_hdcp_status mod_hdcp_hdcp2_enable_dp_stream_encryption(struct mod_hdcp
 
 
 	for (i = 0; i < MAX_NUM_OF_DISPLAYS; i++) {
-		if (hdcp->connection.displays[i].state != MOD_HDCP_DISPLAY_ACTIVE_AND_ADDED ||
-		    hdcp->connection.displays[i].adjust.disable)
+		if (hdcp->displays[i].state != MOD_HDCP_DISPLAY_ACTIVE_AND_ADDED ||
+		    hdcp->displays[i].adjust.disable)
 			continue;
-		hdcp_cmd->in_msg.hdcp2_enable_dp_stream_encryption.display_handle = hdcp->connection.displays[i].index;
+		hdcp_cmd->in_msg.hdcp2_enable_dp_stream_encryption.display_handle = hdcp->displays[i].index;
 		hdcp_cmd->in_msg.hdcp2_enable_dp_stream_encryption.session_handle = hdcp->auth.id;
 
 		hdcp_cmd->cmd_id = TA_HDCP_COMMAND__HDCP2_ENABLE_DP_STREAM_ENCRYPTION;
@@ -759,8 +759,8 @@ enum mod_hdcp_status mod_hdcp_hdcp2_enable_dp_stream_encryption(struct mod_hdcp
 		if (hdcp_cmd->hdcp_status != TA_HDCP_STATUS__SUCCESS)
 			break;
 
-		hdcp->connection.displays[i].state = MOD_HDCP_DISPLAY_ENCRYPTION_ENABLED;
-		HDCP_HDCP2_ENABLED_TRACE(hdcp, hdcp->connection.displays[i].index);
+		hdcp->displays[i].state = MOD_HDCP_DISPLAY_ENCRYPTION_ENABLED;
+		HDCP_HDCP2_ENABLED_TRACE(hdcp, hdcp->displays[i].index);
 	}
 
 	return (hdcp_cmd->hdcp_status == TA_HDCP_STATUS__SUCCESS) ? MOD_HDCP_STATUS_SUCCESS
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
