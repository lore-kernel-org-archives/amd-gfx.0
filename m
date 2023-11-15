Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24087C072A2
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Nov 2023 19:44:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B058F10E587;
	Wed, 15 Nov 2023 19:44:38 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2089.outbound.protection.outlook.com [40.107.100.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 14FC510E585
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Nov 2023 19:44:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cJmFMlDaxYpr+JnJAUcxC46uz1n6FaQ/rAnegEAL8c5hsOeOeH24qrN5hPTo4cFTZpcCpXdmNa+NAe6yBw5ce6t73Be9JWKvqLJ6cIb6+X2es0rAZtlYXd44Nw2ToTdpkT5sKatbunjSeZ/W37bZ47zaVI96OEHusGkfNFvMntxoSiIKE2ay8WvtwR2IuDGeoI3IBXfoGIa997Hi8JOnA9ixSmaPg/fAa6UPtYwcfpBlHTrmNvwm6xb6DDp79QyDjdZTThv4B2JRwm/RVu2T/fBt3hUmP0WNZxEPGVc9aABjNO6kWaju9eRKPR02Jh/cnBgTvT42tcmYs2KWJUErqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=boKwHu/4O5xigN4QmKpvqPX/Gt5SlX7DgXka/3B6Sb8=;
 b=Joz6bWACu3ik4Cjb3ob6zDrrwgijpFri+aJeciKEjWBuvQfHO0Z5psu3kIdCeavoXbpABoofDUhx+tPt/wjKUuWCFvcb929Es7ANRo5aLf+wNr9JgyTvoRzu1PdV4cAUUAOMqzPmeh7U468aVORDepCe1m5E09nNaas4PYeKLv5YVhKXfP0RWCdsFpituTvOGbyMWbaPHvoBlmlC7hPIOL13Z0tWwQvxSBm+9xbTg3lLQ978ljoDQIcWPPKuWrG7lrlWeAW5O3IkcCewX/0eeueWePDrR8W0ywUyAZFc8Y4b3n2jFE6LfCzqMbr5HqZdAcf7JWOwLYPl4Xt0MUiryg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=boKwHu/4O5xigN4QmKpvqPX/Gt5SlX7DgXka/3B6Sb8=;
 b=icBxmIlfagSVXjgDEbcX/qqykbPAzLNWzYLp1ODDiYnzd1zp3xS61drqOWI4+wtPEAZpfiH5HXG9VykY8MnDGdLgOesJNS6foYoRSOJrDfPUsjxGItaHDLCk1Ej+iRzrKN2/EBBGnzAidU7WKSm+wDpm8uesTp4VYNUFcieMwA8=
Received: from BL1PR13CA0261.namprd13.prod.outlook.com (2603:10b6:208:2ba::26)
 by BY5PR12MB4211.namprd12.prod.outlook.com (2603:10b6:a03:20f::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.17; Wed, 15 Nov
 2023 19:44:33 +0000
Received: from BL6PEPF0001AB75.namprd02.prod.outlook.com
 (2603:10b6:208:2ba:cafe::43) by BL1PR13CA0261.outlook.office365.com
 (2603:10b6:208:2ba::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.17 via Frontend
 Transport; Wed, 15 Nov 2023 19:44:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB75.mail.protection.outlook.com (10.167.242.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7002.20 via Frontend Transport; Wed, 15 Nov 2023 19:44:32 +0000
Received: from hamza-pc.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Wed, 15 Nov
 2023 13:44:27 -0600
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 17/35] drm/amd/display: replay: Augment Frameupdate Command
Date: Wed, 15 Nov 2023 14:40:30 -0500
Message-ID: <20231115194332.39469-18-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231115194332.39469-1-hamza.mahfooz@amd.com>
References: <20231115194332.39469-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB75:EE_|BY5PR12MB4211:EE_
X-MS-Office365-Filtering-Correlation-Id: a4d8b228-8b2f-4b37-a401-08dbe6134a4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gh8BdDdl2iV9VOk7FrV4XfVBDzqBhqEUiW3/lweAjLYI3kSdyJpbFQJO/BZ9t2Yjjkl4FWegZmlImYrBkGXlOQEO5zmwZKByUxrE+InqIaYUQS6MYX1rqYg8BhSPKmMWDsgMABpNo02RBfF42Aps9Xs0H4oPyt8fCHifVQAKD88rvW6g7WOIXZgLN1WGaeELDjleCxvd0jmmvlRZBX8zHCKuXiJQaoH2kw/7xD5DyQJS4D08QCrQca7vf0PfpMpiqXcEh4/xI5X0uU4IBe/Fzp8SeNK64L5AajVaSzfMxK0pFBG9x+bdovMaGYDdwlEriDO3A8DubSWcPRRey6cULMheiCUuM938rCuGm9E2fJ91HiH4wSRF+/lCDgCapOFihbkNB0WSsvyk+ihyELBv/BuEcjePLcRyxkl7SPijPJHX4jtxuKTJz3qKOauXKiT56JQXdHQClbbm4gjYmd0FFMbSmSN4qK7W/8bQj+W8Dbie3hWgZV9oq28T6HuekrIlanqr0CsuhPaOa8siuruCoaNAqK/wqbTvbQCeByybv7kJ6hGmvxO1lV+4Cxg4fwWAPx2PwLJcOLGoPn0ubPdm65UULZ6NUdv6z74QrIXJFKFpAxsLl7Ep9ZqNTuNIGxJl6jaHUEGZbg0YQKE1Y0HI9WMSypl7Ljyddwr4lhN8LLLNpkWzKzzco+3uY+SScttqjJqLtvM578Wc5hh1icZwsDpbBXQ7YCP8tkBJIba9LlOzI4kvKrNNN8yzzyrJeGtaspBUqecb0+insH6HpLwO8yTdJ0I1uIVyW4h+PQBWw8cFTum1yaxSmfOSuerKvKjf
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(376002)(136003)(39860400002)(396003)(230922051799003)(82310400011)(1800799009)(186009)(451199024)(64100799003)(46966006)(36840700001)(40470700004)(36860700001)(41300700001)(2616005)(1076003)(44832011)(83380400001)(8936002)(16526019)(4326008)(8676002)(336012)(6666004)(426003)(47076005)(26005)(2906002)(478600001)(356005)(40480700001)(81166007)(5660300002)(82740400003)(316002)(70206006)(36756003)(70586007)(54906003)(6916009)(86362001)(40460700003)(36900700001)(16060500005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2023 19:44:32.8023 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a4d8b228-8b2f-4b37-a401-08dbe6134a4e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB75.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4211
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
Cc: stylon.wang@amd.com, chiahsuan.chung@amd.com, Sunpeng.Li@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, Max
 Tseng <max.tseng@amd.com>, jerry.zuo@amd.com, Aurabindo.Pillai@amd.com,
 hersenxs.wu@amd.com, Dennis Chan <dennis.chan@amd.com>, wayne.lin@amd.com,
 Harry.Wentland@amd.com, agustin.gutierrez@amd.com,
 Hamza Mahfooz <hamza.mahfooz@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Max Tseng <max.tseng@amd.com>

[Why]
Sending certain Frameupdate number for Replay Power Evaluation

Reviewed-by: Dennis Chan <dennis.chan@amd.com>
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Max Tseng <max.tseng@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_types.h     |  1 +
 .../gpu/drm/amd/display/dc/dce/dmub_replay.h  |  2 +-
 .../link/protocols/link_edp_panel_control.c   | 10 +++-
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   | 51 +++++++++++++++++++
 4 files changed, 61 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_types.h b/drivers/gpu/drm/amd/display/dc/dc_types.h
index 6f5da510e8de..4a60d2c47686 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_types.h
@@ -1031,6 +1031,7 @@ enum replay_coasting_vtotal_type {
 enum replay_FW_Message_type {
 	Replay_Msg_Not_Support = -1,
 	Replay_Set_Timing_Sync_Supported,
+	Replay_Set_Residency_Frameupdate_Timer,
 };
 
 union replay_error_status {
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_replay.h b/drivers/gpu/drm/amd/display/dc/dce/dmub_replay.h
index 368711f76335..b3ee90a0b8b3 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_replay.h
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_replay.h
@@ -46,7 +46,7 @@ struct dmub_replay_funcs {
 	void (*replay_set_power_opt)(struct dmub_replay *dmub, unsigned int power_opt,
 		uint8_t panel_inst);
 	void (*replay_send_cmd)(struct dmub_replay *dmub,
-		enum replay_FW_Message_type msg, unsigned int panel_inst, union dmub_replay_cmd_set *cmd_element);
+		enum replay_FW_Message_type msg, union dmub_replay_cmd_set *cmd_element);
 	void (*replay_set_coasting_vtotal)(struct dmub_replay *dmub, uint16_t coasting_vtotal,
 		uint8_t panel_inst);
 	void (*replay_residency)(struct dmub_replay *dmub,
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
index 6bc8ec47e267..fdeb8dff5485 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
@@ -1023,10 +1023,16 @@ bool edp_send_replay_cmd(struct dc_link *link,
 	if (!replay)
 		return false;
 
-	if (!dc_get_edp_link_panel_inst(dc, link, &panel_inst))
+	DC_LOGGER_INIT(link->ctx->logger);
+
+	if (dc_get_edp_link_panel_inst(dc, link, &panel_inst))
+		cmd_data->panel_inst = panel_inst;
+	else {
+		DC_LOG_DC("%s(): get edp panel inst fail ", __func__);
 		return false;
+	}
 
-	replay->funcs->replay_send_cmd(replay, msg, panel_inst, cmd_data);
+	replay->funcs->replay_send_cmd(replay, msg, cmd_data);
 
 	return true;
 }
diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index 5f06cf4c663f..d1becbb5aa29 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -2880,6 +2880,10 @@ enum dmub_cmd_replay_type {
 	 * Set disabled iiming sync.
 	 */
 	DMUB_CMD__REPLAY_SET_TIMING_SYNC_SUPPORTED	= 5,
+	/**
+	 * Set Residency Frameupdate Timer.
+	 */
+	DMUB_CMD__REPLAY_SET_RESIDENCY_FRAMEUPDATE_TIMER = 6,
 };
 
 /**
@@ -3143,14 +3147,57 @@ struct dmub_rb_cmd_replay_set_timing_sync {
 	struct dmub_cmd_replay_set_timing_sync_data replay_set_timing_sync_data;
 };
 
+/**
+ * Data passed from driver to FW in  DMUB_CMD__REPLAY_SET_RESIDENCY_FRAMEUPDATE_TIMER command.
+ */
+struct dmub_cmd_replay_frameupdate_timer_data {
+	/**
+	 * Panel Instance.
+	 * Panel isntance to identify which replay_state to use
+	 * Currently the support is only for 0 or 1
+	 */
+	uint8_t panel_inst;
+	/**
+	 * Replay Frameupdate Timer Enable or not
+	 */
+	uint8_t enable;
+	/**
+	 * REPLAY force reflash frame update number
+	 */
+	uint16_t frameupdate_count;
+};
+/**
+ * Definition of DMUB_CMD__REPLAY_SET_RESIDENCY_FRAMEUPDATE_TIMER
+ */
+struct dmub_rb_cmd_replay_set_frameupdate_timer {
+	/**
+	 * Command header.
+	 */
+	struct dmub_cmd_header header;
+	/**
+	 * Definition of a DMUB_CMD__SET_REPLAY_POWER_OPT command.
+	 */
+	struct dmub_cmd_replay_frameupdate_timer_data data;
+};
+
 /**
  * Definition union of replay command set
  */
 union dmub_replay_cmd_set {
+	/**
+	 * Panel Instance.
+	 * Panel isntance to identify which replay_state to use
+	 * Currently the support is only for 0 or 1
+	 */
+	uint8_t panel_inst;
 	/**
 	 * Definition of DMUB_CMD__REPLAY_SET_TIMING_SYNC_SUPPORTED command data.
 	 */
 	struct dmub_cmd_replay_set_timing_sync_data sync_data;
+	/**
+	 * Definition of DMUB_CMD__REPLAY_SET_RESIDENCY_FRAMEUPDATE_TIMER command data.
+	 */
+	struct dmub_cmd_replay_frameupdate_timer_data timer_data;
 };
 
 /**
@@ -4288,6 +4335,10 @@ union dmub_rb_cmd {
 	struct dmub_rb_cmd_replay_set_power_opt_and_coasting_vtotal replay_set_power_opt_and_coasting_vtotal;
 
 	struct dmub_rb_cmd_replay_set_timing_sync replay_set_timing_sync;
+	/**
+	 * Definition of a DMUB_CMD__REPLAY_SET_RESIDENCY_FRAMEUPDATE_TIMER command.
+	 */
+	struct dmub_rb_cmd_replay_set_frameupdate_timer replay_set_frameupdate_timer;
 };
 
 /**
-- 
2.42.0

