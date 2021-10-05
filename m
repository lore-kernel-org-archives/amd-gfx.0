Return-Path: <SRS0=e3IM=OZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 214EDC433EF
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Oct 2021 07:58:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE7E461165
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Oct 2021 07:58:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org DE7E461165
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7130B6F59A;
	Tue,  5 Oct 2021 07:58:40 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2058.outbound.protection.outlook.com [40.107.101.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8822D6F59A
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Oct 2021 07:58:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HKIiIL6ed+1GXBpT93FAtymtcO6LWvgWOuITAo9jYUSOV6V66HyQD/CnMHrndWu2WrWvIxE4VpW7yxvidjiohDsk6Nu4rp0RDzB43glHgs9gzepVnkbcgAkLsUVDJJt58zWEedDKEvzeHZfwxrrBgnvRWIIzcTDYf/c4fmeeHX7tzj/4Rjsf2OikGmPvy2rn856K439j+jpZhToby+VwsEqojGIkv11FLgxOflZfzl1k633/q127QMnLjFAC/dbrZY04a6GUp8HYpGKHNCKMpCSsc6zkn71m1X0iwFeRReFb//tnsvImpWWkDIAHDU6spxOtE3bwrQIiCUPBTPCT7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WMWJR6V8P8Y9jUc4gAYNyckHUDyuRxmocrvew+BdF+0=;
 b=gGQM8oNCydLArFy6whB7zla8h+lqdDHx26+GcF8+lNM3aUB4gJyMi8jM2Hgk00BO0lFAG/r1u6q/W9IBa6pEvlmHzcGup4j5qfIXjK37fiewMTpjBwY5BtIcFI0mvf97se8zuVRrlBgXEElPZ8oWRB5T7EffKft7+5ldM0tW4bIHEUAwmnfpFJiYEn0YEEmk3P3ugP+/eP1pLGeiNdYnYI+TyHepA121RQpZiZfdHOwqoH6adbiVuqV5AJMtac2IgSPA2U1hDEhf4Ohiva3LqZEStUm02E4vD42QhtxzVerjGwKaisFektpZYjk/TTfY6ANgt1KklNZPb+ruigvsng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WMWJR6V8P8Y9jUc4gAYNyckHUDyuRxmocrvew+BdF+0=;
 b=M9TE8+TLVS11bILmmq2UPThTRhq4z2QzXHcdqvHY/B3sfOlUynv+esaxvOMp6mUEO99mHg/JTot2waBw+u3TX8QJFYaLOtILtbeiC6oAUii7OSUNOk3cPOEzqMCLSeqQhIDiCK+vhFRSPZedDhi/U/uWl3STFoxn2NYNdj68pj4=
Received: from BN6PR19CA0105.namprd19.prod.outlook.com (2603:10b6:404:a0::19)
 by MN2PR12MB4797.namprd12.prod.outlook.com (2603:10b6:208:a4::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.19; Tue, 5 Oct
 2021 07:58:33 +0000
Received: from BN8NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:a0:cafe::a6) by BN6PR19CA0105.outlook.office365.com
 (2603:10b6:404:a0::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14 via Frontend
 Transport; Tue, 5 Oct 2021 07:58:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT048.mail.protection.outlook.com (10.13.177.117) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4566.14 via Frontend Transport; Tue, 5 Oct 2021 07:58:32 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Tue, 5 Oct 2021
 02:58:31 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Tue, 5 Oct 2021
 00:58:31 -0700
Received: from wayne-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2308.8
 via Frontend Transport; Tue, 5 Oct 2021 02:58:23 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <Harry.Wentland@amd.com>,
 <nicholas.kazlauskas@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <wayne.lin@amd.com>, <stylon.wang@amd.com>, <jude.shih@amd.com>,
 <jimmy.kizito@amd.com>, <meenakshikumar.somasundaram@amd.com>, Jun Lei
 <Jun.Lei@amd.com>, Wayne Lin <Wayne.Lin@amd.com>
Subject: [PATCH v2 14/23] drm/amd/display: Support for SET_CONFIG processing
 with DMUB
Date: Tue, 5 Oct 2021 15:51:56 +0800
Message-ID: <20211005075205.3467938-15-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211005075205.3467938-1-Wayne.Lin@amd.com>
References: <20211005075205.3467938-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 134b86b9-5d02-4d07-1aec-08d987d5ed2c
X-MS-TrafficTypeDiagnostic: MN2PR12MB4797:
X-Microsoft-Antispam-PRVS: <MN2PR12MB47976B8A9F1C5CF814530D8FFCAF9@MN2PR12MB4797.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:281;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ueH8pfqWm3HTk6EYCPPUW0ulRWFi9OPomYTNvI1S1/UK1yvtClB1smSFIlGFfX5EbCYY++lye70hGLlTBqv4f5pM+lG68G6dlPqEJhRiyc9nXGrZxD1y+kD9uVAZp+q/VFm2CTs4zbmabH6JmHOxYlUFNbX3WAZ+IwyxVWeQtLcKLbixWkv63nvn/C71xpfoueatfUvfFjzdusFyy9suvoV23ZZR/VjLpbtxXOUD7FTwOb1V0Ib17DEtefsnSAPm/X/Q18UeEsr6ZhQy+KWIeqgrGwZdjhbdLeNo4K8Q0bFV+JBd38kopfWw+315d+aTwvKNmP6sB5EIyUwq4rP/pxD0oVZN1lQbTW0P4aH/fOJz0IXURNYzIx6EQ5rgZajd8duXCEPH/3vtvAADV/CfNyRSPMMQaXYU2rIPfmKizYjh1I5ihH7lWYCNgDmkB3S11AP/lcLpPCiyXLaVzVGSCm24nA+ukbS9ryrouEFr9cvkGcLNdCPpMO5NESlev+j64LD8mtDMMmDi2gvpEi7U7L5waIipXbE9qPBDZP5yiW0NGJ7WWGHE9mg6ukpia5xiRHfRO9ctEeA57JhdTh86t3ibAfQwbpLH/dXfEfd/u6R9r1p3o5fZNFMk/817vcal+kFQJb75UyzEnet4UrXf5W8XBVPIvAp2SgGXGNrmlIhM17uOcAK5mws4JOb0Oxudw8Y45hZF7QOm/udUO2ALWawgsnY3K0C3kIjBFsXfGws=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(26005)(6916009)(30864003)(70206006)(316002)(47076005)(54906003)(356005)(336012)(81166007)(508600001)(186003)(426003)(2906002)(2616005)(7696005)(4326008)(83380400001)(82310400003)(8676002)(5660300002)(36756003)(36860700001)(8936002)(6666004)(1076003)(70586007)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2021 07:58:32.6080 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 134b86b9-5d02-4d07-1aec-08d987d5ed2c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4797
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

