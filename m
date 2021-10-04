Return-Path: <SRS0=otPk=OY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59908C433EF
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Oct 2021 14:44:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2792661391
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Oct 2021 14:44:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2792661391
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9BBA36EA09;
	Mon,  4 Oct 2021 14:44:27 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2044.outbound.protection.outlook.com [40.107.94.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 926516EA07
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Oct 2021 14:44:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IWSCiPRtWXHqiZ6GelUVnPH95uAPSZQzYEPQVPQzjcK6Q8Q02XjSCr59vNzWtC1+2HB79hknfeOJWNWNFTdxILCI1axe9A3YR3tvTQq8qGUK5cSIhudT4WAc02DX5fC+tcyNUckXKIc54tIjtkyKbxrOJv3v47XEuz6YQAZonp5vrTT6zuSy34sO1Lac/+hhsl20PyrQ9v/rm023ZOo6koITm7FdpzNNwqX1/vxVFtuuF9gtsBxcH6zToxH8FHmio+Xup+8XcwZopALCsbJ2/qQoVxy+pgZJQPy417nt/4pmQ6kl5ZJKi4s/+h90IOSNwmlgewMVElb2oge6Ip75YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WMWJR6V8P8Y9jUc4gAYNyckHUDyuRxmocrvew+BdF+0=;
 b=bEZ4OY9HFeAwmb9jTQLOwaxaYj70hIA0yHXOoWR8NqO2AgjoolD5hBymn6DDIChP2KMGlFcXgdF6Bk+PPMURufh6pgQSdAUudGjhOFFdK7xPPHZbnnlJOAglwvKDEeMyqcTgSwhuJsLBLfRRuMqRCYhlUTMTncD65v+jCCYr6ny6g5ZBLHpkRwM9kV3lDxvD5lf4acX5fSTf4sMNrlJWgxroqL7OzkGRr/qqfSuKIQP1j9CSq75aQf9+FE5dXylStpxPnrz4bnCiMwBBBEBguyDYI6GY9yK4g+o9S5DLQ7GBKgBBcCzcnGDdjv0qdYaune0DnsmzKkkVPClOougePg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WMWJR6V8P8Y9jUc4gAYNyckHUDyuRxmocrvew+BdF+0=;
 b=fHm7l/Dj3pJ+ydl6NcBTKKBjNJru9alVrVpGHKKNQgjjfJ54lGlpoufUpgW/uHbAmfrb8PTPmfW3skid2tN921lOxY5165hQdK8pBbQjl684cG9L1b4A67X6tVI4DJ3A4IBBv5pJdb0dWBu737X+IoA8ew5T0452mqua5XNN7pw=
Received: from CO2PR04CA0162.namprd04.prod.outlook.com (2603:10b6:104:4::16)
 by BY5PR12MB3986.namprd12.prod.outlook.com (2603:10b6:a03:195::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.22; Mon, 4 Oct
 2021 14:44:20 +0000
Received: from CO1NAM11FT010.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:4:cafe::e7) by CO2PR04CA0162.outlook.office365.com
 (2603:10b6:104:4::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14 via Frontend
 Transport; Mon, 4 Oct 2021 14:44:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT010.mail.protection.outlook.com (10.13.175.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4566.14 via Frontend Transport; Mon, 4 Oct 2021 14:44:19 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Mon, 4 Oct 2021
 09:44:18 -0500
Received: from wayne-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2308.8
 via Frontend Transport; Mon, 4 Oct 2021 09:44:11 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <Harry.Wentland@amd.com>,
 <nicholas.kazlauskas@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <wayne.lin@amd.com>, <stylon.wang@amd.com>, <jude.shih@amd.com>,
 <jimmy.kizito@amd.com>, <meenakshikumar.somasundaram@amd.com>, Jun Lei
 <Jun.Lei@amd.com>, Wayne Lin <Wayne.Lin@amd.com>
Subject: [PATCH 14/23] drm/amd/display: Support for SET_CONFIG processing with
 DMUB
Date: Mon, 4 Oct 2021 22:40:41 +0800
Message-ID: <20211004144050.3425351-15-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211004144050.3425351-1-Wayne.Lin@amd.com>
References: <20211004144050.3425351-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d957e14d-019e-4792-0f9a-08d9874572e9
X-MS-TrafficTypeDiagnostic: BY5PR12MB3986:
X-Microsoft-Antispam-PRVS: <BY5PR12MB398659B0903379379598E156FCAE9@BY5PR12MB3986.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:281;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nERzTQnv9dHujrbYgSWsoDYlVQsO8gIK9A13+jLW4IgLVFN4PDrWQW64obZQNuHht/DkkZ6goXLO+RAKeV3yYigt5rpZi4lko2nBOAPg0EsiHY+6qGmSnxYJZsY8izfF1JLJE52omaTnXoX+EjrVhI36ulBqcWVFUUpwgG0W4555Y0zdj2llj/3DDD2XWpZMhos3T1/9jOTn1hGCpSc2MmqqSDB8iB0KMciQ5lJ9ddP1wV0y9lH1Q7mnha12hI1flAJNKMe95wzOcKdB5UnQAPXgN4gALm6Purs6cUT4rHKMdRsN7sShyWKMszdUpgGWKDmD+H3c0Gc1SfQ5OdMSOrcjRiJp8lMUwIFkc5MspUIBrv0N4UqD/Ef591KcZYIgqtaJBLoMAxV9BnFCeHyzIAI7XYGewcppZK3YaR1JwZgcYuj8EIM0IO9AyZmKoMQ2WA8F9WMRomUQVcpYSsLl5DsoFtmkX9r/+10UylE5m0mf2pkEPwPQOveWCs3baseGiXMmb00rS79HeWCaKYT/fe1/EqqLazA9oX+5c1aX5+WwVGcAcT4QmK9gnSGgxGO5Saf4EQ/gN7ySOJRPV6Tkc6lh+5oJaB/nCVwg2abHc48EdCBcNGVDPY+8sLOF2i7oCQ5NoW3DKoGOuYtUa9NijskI7dbK9jHtG63U3XqJ9aSSFsBzpifXBIVB+QF65a0pXtehLli3pzLCff+UKr1gOmzN/cOS3t7pSECveWTtjSI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(54906003)(81166007)(356005)(4326008)(83380400001)(316002)(6916009)(6666004)(86362001)(5660300002)(47076005)(336012)(2616005)(8676002)(426003)(36756003)(1076003)(8936002)(186003)(70206006)(70586007)(30864003)(36860700001)(26005)(2906002)(508600001)(82310400003)(7696005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2021 14:44:19.8466 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d957e14d-019e-4792-0f9a-08d9874572e9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT010.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3986
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

From: Meenakshikumar Somasundaram <meenakshikumar.somasundaram@amd.com>

[Why]
To process SET_CONFIG transactions with DMUB using inbox1 and
outbox1 mail boxes.

[How]
1) Added inbox1 DPIA command subtype DMUB_CMD__DPIA_SET_CONFIG_ACCESS to
   issue SET_CONFIG command to DMUB in dc_process_dmub_set_config_async().
   DMUB processes the command with DPIA sends reply back immediately or
   in an outbox1 message triggering an outbox1 interrupt to driver.
2) DMUB posts SET_CONFIG reply as an Outbox1 message of type
   DMUB_OUT_CMD__SET_CONFIG_REPLY.
3) The dmub async to sync mechanism for AUX is modified to accommodate
   SET_CONFIG commands for both command issue and reply code paths.

Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Wayne Lin <Wayne.Lin@amd.com>
Acked-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Meenakshikumar Somasundaram <meenakshikumar.somasundaram@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 50 ++++++++++++++
 .../drm/amd/display/dc/core/dc_link_dpia.c    | 16 ++++-
 drivers/gpu/drm/amd/display/dc/core/dc_stat.c |  3 +-
 drivers/gpu/drm/amd/display/dc/dc.h           |  7 ++
 drivers/gpu/drm/amd/display/dc/dm_helpers.h   |  5 ++
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h   |  2 +
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   | 65 +++++++++++++++++++
 .../drm/amd/display/dmub/src/dmub_srv_stat.c  |  5 ++
 8 files changed, 149 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 6cdf68ca9048..517a2f0b4ba1 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -3678,6 +3678,56 @@ uint8_t get_link_index_from_dpia_port_index(const struct dc *dc,
 	return link_index;
 }
 
+/**
+ *****************************************************************************
+ *  Function: dc_process_dmub_set_config_async
+ *
+ *  @brief
+ *		Submits set_config command to dmub via inbox message
+ *
+ *  @param
+ *		[in] dc: dc structure
+ *		[in] link_index: link index
+ *		[in] payload: aux payload
+ *		[out] notify: set_config immediate reply
+ *
+ *	@return
+ *		True if successful, False if failure
+ *****************************************************************************
+ */
+bool dc_process_dmub_set_config_async(struct dc *dc,
+				uint32_t link_index,
+				struct set_config_cmd_payload *payload,
+				struct dmub_notification *notify)
+{
+	union dmub_rb_cmd cmd = {0};
+	struct dc_dmub_srv *dmub_srv = dc->ctx->dmub_srv;
+	bool is_cmd_complete = true;
+
+	/* prepare SET_CONFIG command */
+	cmd.set_config_access.header.type = DMUB_CMD__DPIA;
+	cmd.set_config_access.header.sub_type = DMUB_CMD__DPIA_SET_CONFIG_ACCESS;
+
+	cmd.set_config_access.set_config_control.instance = dc->links[link_index]->ddc_hw_inst;
+	cmd.set_config_access.set_config_control.cmd_pkt.msg_type = payload->msg_type;
+	cmd.set_config_access.set_config_control.cmd_pkt.msg_data = payload->msg_data;
+
+	if (!dc_dmub_srv_cmd_with_reply_data(dmub_srv, &cmd)) {
+		/* command is not processed by dmub */
+		notify->sc_status = SET_CONFIG_UNKNOWN_ERROR;
+		return is_cmd_complete;
+	}
+
+	/* command processed by dmub, if ret_status is 1, it is completed instantly */
+	if (cmd.set_config_access.header.ret_status == 1)
+		notify->sc_status = cmd.set_config_access.set_config_control.immed_status;
+	else
+		/* cmd pending, will receive notification via outbox */
+		is_cmd_complete = false;
+
+	return is_cmd_complete;
+}
+
 /**
  * dc_disable_accelerated_mode - disable accelerated mode
  * @dc: dc structure
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dpia.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dpia.c
index 4b1ad057bd1f..a7fc60565bda 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dpia.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dpia.c
@@ -31,6 +31,8 @@
 #include "dpcd_defs.h"
 #include "link_hwss.h"
 #include "inc/link_dpcd.h"
+#include "dm_helpers.h"
+#include "dmub/inc/dmub_cmd.h"
 
 #define DC_LOGGER \
 	link->ctx->logger
@@ -91,10 +93,18 @@ static enum link_training_result dpia_configure_link(struct dc_link *link,
 }
 
 static enum dc_status core_link_send_set_config(struct dc_link *link,
-		uint8_t msg_type, uint8_t msg_data)
+	uint8_t msg_type,
+	uint8_t msg_data)
 {
-	/** @todo Implement */
-	return DC_OK;
+	struct set_config_cmd_payload payload;
+	enum set_config_status set_config_result = SET_CONFIG_PENDING;
+
+	/* prepare set_config payload */
+	payload.msg_type = msg_type;
+	payload.msg_data = msg_data;
+
+	/* set_config should return ACK if successful */
+	return (set_config_result == SET_CONFIG_ACK_RECEIVED) ? DC_OK : DC_ERROR_UNEXPECTED;
 }
 
 /* Build SET_CONFIG message data payload for specified message type. */
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_stat.c b/drivers/gpu/drm/amd/display/dc/core/dc_stat.c
index 7d4a5dc8fc91..4b372aa52801 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_stat.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_stat.c
@@ -64,7 +64,8 @@ void dc_stat_get_dmub_notification(const struct dc *dc, struct dmub_notification
 
 	/* For HPD/HPD RX, convert dpia port index into link index */
 	if (notify->type == DMUB_NOTIFICATION_HPD ||
-	    notify->type == DMUB_NOTIFICATION_HPD_IRQ) {
+	    notify->type == DMUB_NOTIFICATION_HPD_IRQ ||
+	    notify->type == DMUB_NOTIFICATION_SET_CONFIG_REPLY) {
 		notify->link_index =
 			get_link_index_from_dpia_port_index(dc, notify->link_index);
 	}
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index d51c7b000eb9..082706c921af 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -44,6 +44,8 @@
 
 /* forward declaration */
 struct aux_payload;
+struct set_config_cmd_payload;
+struct dmub_notification;
 
 #define DC_VER "3.2.156"
 
@@ -1398,6 +1400,11 @@ bool dc_process_dmub_aux_transfer_async(struct dc *dc,
 /* Get dc link index from dpia port index */
 uint8_t get_link_index_from_dpia_port_index(const struct dc *dc,
 				uint8_t dpia_port_index);
+
+bool dc_process_dmub_set_config_async(struct dc *dc,
+				uint32_t link_index,
+				struct set_config_cmd_payload *payload,
+				struct dmub_notification *notify);
 /*******************************************************************************
  * DSC Interfaces
  ******************************************************************************/
diff --git a/drivers/gpu/drm/amd/display/dc/dm_helpers.h b/drivers/gpu/drm/amd/display/dc/dm_helpers.h
index 3a905fb667bf..0fe66b080a03 100644
--- a/drivers/gpu/drm/amd/display/dc/dm_helpers.h
+++ b/drivers/gpu/drm/amd/display/dc/dm_helpers.h
@@ -179,4 +179,9 @@ int dm_helper_dmub_aux_transfer_sync(
 		const struct dc_link *link,
 		struct aux_payload *payload,
 		enum aux_return_code_type *operation_result);
+enum set_config_status;
+int dm_helpers_dmub_set_config_sync(struct dc_context *ctx,
+		const struct dc_link *link,
+		struct set_config_cmd_payload *payload,
+		enum set_config_status *operation_result);
 #endif /* __DM_HELPERS__ */
diff --git a/drivers/gpu/drm/amd/display/dmub/dmub_srv.h b/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
index efb667cf6c98..7a86c97af910 100644
--- a/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
+++ b/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
@@ -119,6 +119,7 @@ enum dmub_notification_type {
 	DMUB_NOTIFICATION_AUX_REPLY,
 	DMUB_NOTIFICATION_HPD,
 	DMUB_NOTIFICATION_HPD_IRQ,
+	DMUB_NOTIFICATION_SET_CONFIG_REPLY,
 	DMUB_NOTIFICATION_MAX
 };
 
@@ -440,6 +441,7 @@ struct dmub_notification {
 	union {
 		struct aux_reply_data aux_reply;
 		enum dp_hpd_status hpd_status;
+		enum set_config_status sc_status;
 	};
 };
 
diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index 8461442b03a9..4c61e73ceccd 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -684,11 +684,16 @@ enum dmub_out_cmd_type {
 	 * Command type used for DP HPD event notification
 	 */
 	DMUB_OUT_CMD__DP_HPD_NOTIFY = 2,
+	/**
+	 * Command type used for SET_CONFIG Reply notification
+	 */
+	DMUB_OUT_CMD__SET_CONFIG_REPLY = 3,
 };
 
 /* DMUB_CMD__DPIA command sub-types. */
 enum dmub_cmd_dpia_type {
 	DMUB_CMD__DPIA_DIG1_DPIA_CONTROL = 0,
+	DMUB_CMD__DPIA_SET_CONFIG_ACCESS = 1,
 };
 
 #pragma pack(push, 1)
@@ -1038,6 +1043,31 @@ struct dmub_rb_cmd_dig1_dpia_control {
 	struct dmub_cmd_dig_dpia_control_data dpia_control;
 };
 
+/**
+ * SET_CONFIG Command Payload
+ */
+struct set_config_cmd_payload {
+	uint8_t msg_type; /* set config message type */
+	uint8_t msg_data; /* set config message data */
+};
+
+/**
+ * Data passed from driver to FW in a DMUB_CMD__DPIA_SET_CONFIG_ACCESS command.
+ */
+struct dmub_cmd_set_config_control_data {
+	struct set_config_cmd_payload cmd_pkt;
+	uint8_t instance; /* DPIA instance */
+	uint8_t immed_status; /* Immediate status returned in case of error */
+};
+
+/**
+ * DMUB command structure for SET_CONFIG command.
+ */
+struct dmub_rb_cmd_set_config_access {
+	struct dmub_cmd_header header; /* header */
+	struct dmub_cmd_set_config_control_data set_config_control; /* set config data */
+};
+
 /**
  * struct dmub_rb_cmd_dpphy_init - DPPHY init.
  */
@@ -1285,6 +1315,33 @@ struct dmub_rb_cmd_dp_hpd_notify {
 	struct dp_hpd_data hpd_data;
 };
 
+/**
+ * Definition of a SET_CONFIG reply from DPOA.
+ */
+enum set_config_status {
+	SET_CONFIG_PENDING = 0,
+	SET_CONFIG_ACK_RECEIVED,
+	SET_CONFIG_RX_TIMEOUT,
+	SET_CONFIG_UNKNOWN_ERROR,
+};
+
+/**
+ * Definition of a set_config reply
+ */
+struct set_config_reply_control_data {
+	uint8_t instance; /* DPIA Instance */
+	uint8_t status; /* Set Config reply */
+	uint16_t pad; /* Alignment */
+};
+
+/**
+ * Definition of a DMUB_OUT_CMD__SET_CONFIG_REPLY command.
+ */
+struct dmub_rb_cmd_dp_set_config_reply {
+	struct dmub_cmd_header header;
+	struct set_config_reply_control_data set_config_reply_control;
+};
+
 /*
  * Command IDs should be treated as stable ABI.
  * Do not reuse or modify IDs.
@@ -2483,6 +2540,10 @@ union dmub_rb_cmd {
 	 * Definition of a DMUB_CMD__DPIA_DIG1_CONTROL command.
 	 */
 	struct dmub_rb_cmd_dig1_dpia_control dig1_dpia_control;
+	/**
+	 * Definition of a DMUB_CMD__DPIA_SET_CONFIG_ACCESS command.
+	 */
+	struct dmub_rb_cmd_set_config_access set_config_access;
 	/**
 	 * Definition of a DMUB_CMD__EDID_CEA command.
 	 */
@@ -2505,6 +2566,10 @@ union dmub_rb_out_cmd {
 	 * HPD notify command.
 	 */
 	struct dmub_rb_cmd_dp_hpd_notify dp_hpd_notify;
+	/**
+	 * SET_CONFIG reply command.
+	 */
+	struct dmub_rb_cmd_dp_set_config_reply set_config_reply;
 };
 #pragma pack(pop)
 
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv_stat.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv_stat.c
index d7f66e5285c0..44502ec919a2 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv_stat.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv_stat.c
@@ -87,6 +87,11 @@ enum dmub_status dmub_srv_stat_get_notification(struct dmub_srv *dmub,
 		notify->link_index = cmd.dp_hpd_notify.hpd_data.instance;
 		notify->result = AUX_RET_SUCCESS;
 		break;
+	case DMUB_OUT_CMD__SET_CONFIG_REPLY:
+		notify->type = DMUB_NOTIFICATION_SET_CONFIG_REPLY;
+		notify->link_index = cmd.set_config_reply.set_config_reply_control.instance;
+		notify->sc_status = cmd.set_config_reply.set_config_reply_control.status;
+		break;
 	default:
 		notify->type = DMUB_NOTIFICATION_NO_DATA;
 		break;
-- 
2.25.1

