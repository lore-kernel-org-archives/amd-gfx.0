Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EC20C5AD4C
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Nov 2023 19:44:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E47B310E1BB;
	Wed, 15 Nov 2023 19:44:15 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2084.outbound.protection.outlook.com [40.107.95.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA70210E1A8
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Nov 2023 19:44:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TH882Mx59C2k/gXJhYja1U1ku3lqi/89RlOGPm8wzm4AqJKv28nT2rNkMB0ZQ4FR7/Z/MeweX7XT0umzAKg5wahOVNftkqL0eiyimIuTunmDmdaVSW1qtdcEuQv5vNzADAcnls5m6pqLpSKu3QuxjBUHVEly8hSKV+sYMjZL0LIXv9FUdSEBvuqf0BTs1QTd6f5YxcoOhbv5oQHeG6F4INfH+HPeu+7DC7pxyiwl7aPWzksUtTjQJxKOMjhxSSevUJxAAwN1bwEfQC/GJqubgbFx7jo6mRas5YSG1Uzf5t2yVjIeakk0ojdqtQw4WGOHMaZLIyS9xTNBpQh3yyTcKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TMTGxP3phzASo1e7Ji+2RDOxPhZj49kcuIOJ6CA4138=;
 b=kbgqLp0pDFdxiO8gyQu4EaySekBeXmqBuLbv04djCDvL0G+MjnsUxDE2C6BS3aPujU5rrxLAqrqirU1xgIi0M+UM0x2Vm4EqH9Ugl7oDk64Mgr5zGu9G3aoSpduX2LiMlV0xnnJc47PM8DjZFBVngsEuPbdaO3JCOY7zwvCdXV86oJghc3ngval/G/iuhf83LFqAqokRfhrX5/xe9PbtvyHjYH+CSYPUE7rDRX3Eu9/eOsG5wh+xert3JXHKBP9xwPV870d44cphU3uixZNph84PvU1eUXGbed+/yW+twmtSTGGTARTcqzzHgQMW8L70XqrA2J8Lq0lr0PlZ849XZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TMTGxP3phzASo1e7Ji+2RDOxPhZj49kcuIOJ6CA4138=;
 b=1Udjh44dUULMErouUy76BfiqSTibNKprIcO+NlmrrDOAcnp00sZGT3XCfbUjuXjai+leiXg7Lamdmu3M+f+koKnUEMk9DtDoyBeXrNwZ6V/5eCbqb3qHKMNnm+PZbSmc1wRTD9G7oLl6ar+1Pm0VmFyarms6rgW/m7YBP7sgnCM=
Received: from MN2PR14CA0023.namprd14.prod.outlook.com (2603:10b6:208:23e::28)
 by CH3PR12MB9196.namprd12.prod.outlook.com (2603:10b6:610:197::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.31; Wed, 15 Nov
 2023 19:44:09 +0000
Received: from BL6PEPF0001AB74.namprd02.prod.outlook.com
 (2603:10b6:208:23e:cafe::e7) by MN2PR14CA0023.outlook.office365.com
 (2603:10b6:208:23e::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.20 via Frontend
 Transport; Wed, 15 Nov 2023 19:44:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB74.mail.protection.outlook.com (10.167.242.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7002.20 via Frontend Transport; Wed, 15 Nov 2023 19:44:09 +0000
Received: from hamza-pc.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Wed, 15 Nov
 2023 13:44:07 -0600
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 01/35] drm/amd/display: Add new Replay command and Disabled
 Replay Timing Reysnc
Date: Wed, 15 Nov 2023 14:40:14 -0500
Message-ID: <20231115194332.39469-2-hamza.mahfooz@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB74:EE_|CH3PR12MB9196:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d27748a-4b65-416a-cc24-08dbe6133c5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5dcQrbUe+PukdVGMEQq/PSEb5hpzBvJ9hVi0Wcaki7AO5HFov7I01jb+ChnrXl5YE6O9ifunQgYXPdxEqQ6wA8EPaUZ60HdkTv+mraTZ1P4y8hQnLzGdNMCFYcMCmbnv2TbkPHhTU0zTXiWy7ebyB2w+MC4zlHjz2rhQZEUlJEKfGPkVjXfKyx3ZUuTsxaDKodJz7yHQQCr5QnKOKUwSddhryqXh8SHyEEhcNk/s7uIkVC7oIMBq7Ol2B1WVGfTCk/v3N4+LjJmXZUwcRj6mscQC5EAB1HO12JtY2yLWyrZWNF/gKY/fQKbKKxGo9ZQ7Afrbveor6d4dCnvSLGDJA246e22t9Iu0RSynhgmlAc8sh08Wt4Vh6iYdvsR2+YBIllAjwtyHB9AGBYPOFBvT6acJOQvyeca4dOuwC/pbVK3igZtf5TECPqLt96kUcgUOfTvh60lUGKYn5BpapDfRnpke0640PMfikdkVLhZmdyB+sSpotUNd9as+rYbXc7bhU079nihgVrURlrjHMNE5mljoNXQ4aq+KdXslksXriDc5EX+Rvca8yLVJWIgPYj1QjeXDeI7KyUp5OIPV1QSgotZDBAw2HkqMl3+VXcIEWHFWlOGXCc0iYs8rg78ZRCo+ypab/LI/hqLLSOU4vBVtImAlxxctY/T7rYoVSnUK5Juik6kgZXXQkNYtMdRM79Y5u/76L4tnALFAm+zowLY7JhcuQnbGWCZ3f75TzJ4dIKTWDf0YGsvjc1e1Jm8Y4iCpp+JvNbgBz8lDQLIxcMVZEV1Dwax9yLqv4WJ2Yhnlg+jniS+N67tunVMbjXpSREJJ
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(39860400002)(136003)(346002)(396003)(230922051799003)(451199024)(1800799009)(186009)(82310400011)(64100799003)(40470700004)(36840700001)(46966006)(426003)(81166007)(36756003)(336012)(36860700001)(356005)(41300700001)(83380400001)(40460700003)(47076005)(86362001)(1076003)(4326008)(8676002)(8936002)(40480700001)(44832011)(5660300002)(70206006)(2616005)(70586007)(316002)(54906003)(6916009)(26005)(6666004)(16526019)(478600001)(2906002)(82740400003)(36900700001)(16060500005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2023 19:44:09.4095 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d27748a-4b65-416a-cc24-08dbe6133c5a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB74.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9196
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
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, ChunTao Tso <chuntao.tso@amd.com>,
 jerry.zuo@amd.com, Aurabindo.Pillai@amd.com, hersenxs.wu@amd.com,
 Dennis Chan <dennis.chan@amd.com>, wayne.lin@amd.com, Harry.Wentland@amd.com,
 agustin.gutierrez@amd.com, Hamza Mahfooz <hamza.mahfooz@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Dennis Chan <dennis.chan@amd.com>

[why]
To support dynamic switching for Replay timing sync mechanism.

Reviewed-by: ChunTao Tso <chuntao.tso@amd.com>
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Dennis Chan <dennis.chan@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_types.h     | 10 ++++++++
 .../gpu/drm/amd/display/dc/dce/dmub_replay.h  |  3 +++
 drivers/gpu/drm/amd/display/dc/inc/link.h     |  3 +++
 .../drm/amd/display/dc/link/link_factory.c    |  1 +
 .../link/protocols/link_edp_panel_control.c   | 24 +++++++++++++++++++
 .../link/protocols/link_edp_panel_control.h   |  3 +++
 6 files changed, 44 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_types.h b/drivers/gpu/drm/amd/display/dc/dc_types.h
index fcb825e4f1bb..edf60c4f318c 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_types.h
@@ -1022,6 +1022,16 @@ enum replay_coasting_vtotal_type {
 	PR_COASTING_TYPE_NUM,
 };
 
+/*
+ * This is general Interface for Replay to
+ * set an 32 bit variable to dmub
+ * The Message_type indicates which variable
+ * passed to DMUB.
+ */
+enum replay_FW_Message_type {
+	Replay_Set_Timing_Sync_Supported,
+};
+
 union replay_error_status {
 	struct {
 		unsigned char STATE_TRANSITION_ERROR    :1;
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_replay.h b/drivers/gpu/drm/amd/display/dc/dce/dmub_replay.h
index e8385bbf51fc..427bc47a676e 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_replay.h
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_replay.h
@@ -45,6 +45,9 @@ struct dmub_replay_funcs {
 		struct replay_context *replay_context, uint8_t panel_inst);
 	void (*replay_set_power_opt)(struct dmub_replay *dmub, unsigned int power_opt,
 		uint8_t panel_inst);
+	void (*replay_send_cmd)(struct dmub_replay *dmub,
+		enum replay_FW_Message_type msg, unsigned int panel_inst,
+		uint32_t cmd_data);
 	void (*replay_set_coasting_vtotal)(struct dmub_replay *dmub, uint16_t coasting_vtotal,
 		uint8_t panel_inst);
 	void (*replay_residency)(struct dmub_replay *dmub,
diff --git a/drivers/gpu/drm/amd/display/dc/inc/link.h b/drivers/gpu/drm/amd/display/dc/inc/link.h
index d7685368140a..dd3f53151d8b 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/link.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/link.h
@@ -281,6 +281,9 @@ struct link_service {
 			const unsigned int *power_opts);
 	bool (*edp_setup_replay)(struct dc_link *link,
 			const struct dc_stream_state *stream);
+	bool (*edp_send_replay_cmd)(struct dc_link *link,
+			enum replay_FW_Message_type msg,
+			uint32_t params);
 	bool (*edp_set_coasting_vtotal)(
 			struct dc_link *link, uint16_t coasting_vtotal);
 	bool (*edp_replay_residency)(const struct dc_link *link,
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_factory.c b/drivers/gpu/drm/amd/display/dc/link/link_factory.c
index 7abfc67d10a6..6b306ea58b9b 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_factory.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_factory.c
@@ -213,6 +213,7 @@ static void construct_link_service_edp_panel_control(struct link_service *link_s
 	link_srv->edp_get_replay_state = edp_get_replay_state;
 	link_srv->edp_set_replay_allow_active = edp_set_replay_allow_active;
 	link_srv->edp_setup_replay = edp_setup_replay;
+	link_srv->edp_send_replay_cmd = edp_send_replay_cmd;
 	link_srv->edp_set_coasting_vtotal = edp_set_coasting_vtotal;
 	link_srv->edp_replay_residency = edp_replay_residency;
 
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
index e32a7974a4bc..c52b51b2b4b3 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
@@ -1007,6 +1007,30 @@ bool edp_setup_replay(struct dc_link *link, const struct dc_stream_state *stream
 	return true;
 }
 
+/*
+ * This is general Interface for Replay to set an 32 bit variable to dmub
+ * replay_FW_Message_type: Indicates which instruction or variable pass to DMUB
+ * cmd_data: Value of the config.
+ */
+bool edp_send_replay_cmd(struct dc_link *link,
+			enum replay_FW_Message_type msg,
+			uint32_t cmd_data)
+{
+	struct dc *dc = link->ctx->dc;
+	struct dmub_replay *replay = dc->res_pool->replay;
+	unsigned int panel_inst;
+
+	if (!replay)
+		return false;
+
+	if (!dc_get_edp_link_panel_inst(dc, link, &panel_inst))
+		return false;
+
+	replay->funcs->replay_send_cmd(replay, msg, cmd_data, panel_inst);
+
+	return true;
+}
+
 bool edp_set_coasting_vtotal(struct dc_link *link, uint16_t coasting_vtotal)
 {
 	struct dc *dc = link->ctx->dc;
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.h b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.h
index ebf7deb63d13..6b223580ac8a 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.h
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.h
@@ -57,6 +57,9 @@ bool edp_set_replay_allow_active(struct dc_link *dc_link, const bool *enable,
 	bool wait, bool force_static, const unsigned int *power_opts);
 bool edp_setup_replay(struct dc_link *link,
 		const struct dc_stream_state *stream);
+bool edp_send_replay_cmd(struct dc_link *link,
+			enum replay_FW_Message_type msg,
+			uint32_t params);
 bool edp_set_coasting_vtotal(struct dc_link *link, uint16_t coasting_vtotal);
 bool edp_replay_residency(const struct dc_link *link,
 	unsigned int *residency, const bool is_start, const bool is_alpm);
-- 
2.42.0

