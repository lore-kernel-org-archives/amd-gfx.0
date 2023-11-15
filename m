Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 830C7C5AE4B
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Nov 2023 19:44:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EBE7B10E582;
	Wed, 15 Nov 2023 19:44:33 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2061.outbound.protection.outlook.com [40.107.101.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 558FF10E579
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Nov 2023 19:44:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QJ2Gcp+nrD9Z4qCosN4PypUgvbCtU8mFPz/4QjICDLVCLwsWE7sOflIXvyRV/pqeJ+9mPQBJjviQSyf6Jo5+ttUZh2OLHAJLeGc1E7SB5QAj2QlLqsh6kixs8wDv3CYXtHLIT3ibKTcyuXTPkPwONGqZb4tUdFVTkqWab2PYSEfaqGW0zC/i8DMPWRijA6gwB8raaI5HtY6Z5IJn4hb1HNUn/NdaXFz+KPQ7HY/BJd7MHEKdouwZ3m5Rq1n69MnP7YOoEprLpinMzX0z9vY7dkOSKX8MBRgo4PDtKkHu4LsUcfVSe0zFHUuoCPV0zW5QvOZLFhJJ4ukZdzegMOgh5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NRQXPqK+lMlbU8mXA3X1CjQh2RjNlTxBkTxHSkkvQIA=;
 b=nMKxDjcThvmNvMl2wCVeLwXSY6Ef54zY0sY3E5Y6Un1Y4WwaiAAARZ1OGqxaNCShy4JclGsOyvAZrvhjrpxFj+sEEKmJBd/2UbcI8H2G+tlVkPv+rM0Q1mPA6l1hdP2ROoNBxiZ/dIcRccRI4SYRZzPhYZbERD2a+ke2Uod0b/lirUJA1C6+2y47vfAzdgOIXiLudyyx4B2P+dSwZJ0cVCVJCANK+Vk53Jh8w+hNafyjP32JP0diVX3j2fBrLXMdBJwiBcnze4kYZ6aRxNLEzWdv+1psHVGiQ+a/VK86lD1y61Q+kEcgimJr2pF9+JPoSnMKhm5gdbkFd/H0ppEFhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NRQXPqK+lMlbU8mXA3X1CjQh2RjNlTxBkTxHSkkvQIA=;
 b=r93tp9DGjlRSxpSlwRtmJjd28/6SdcbDzad+sr8J6ulroDPt0q7CNbuIzK7vXnQF4eEiAlKnjA/LTOieDz1BlXoQdF1q3z1LdDzTAkPY3VYuHh6z3dIRWb2VEHhgR/ZrcqNi3te7X/2OYzqcqSmMluUjlT4h9GpTe1kpcCC3zhk=
Received: from BL1PR13CA0118.namprd13.prod.outlook.com (2603:10b6:208:2b9::33)
 by DM4PR12MB6567.namprd12.prod.outlook.com (2603:10b6:8:8e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.19; Wed, 15 Nov
 2023 19:44:26 +0000
Received: from BL6PEPF0001AB71.namprd02.prod.outlook.com
 (2603:10b6:208:2b9:cafe::95) by BL1PR13CA0118.outlook.office365.com
 (2603:10b6:208:2b9::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.19 via Frontend
 Transport; Wed, 15 Nov 2023 19:44:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB71.mail.protection.outlook.com (10.167.242.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7002.13 via Frontend Transport; Wed, 15 Nov 2023 19:44:24 +0000
Received: from hamza-pc.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Wed, 15 Nov
 2023 13:44:23 -0600
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 14/35] drm/amd/display: replay: generalize the send command
 function usage
Date: Wed, 15 Nov 2023 14:40:27 -0500
Message-ID: <20231115194332.39469-15-hamza.mahfooz@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB71:EE_|DM4PR12MB6567:EE_
X-MS-Office365-Filtering-Correlation-Id: a2822c6f-41f4-4d31-0daf-08dbe61345a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IE0K4l3Pxt4WHgKDQeEDgxXvl1zgJayW8Ff93LSv2Ct0LSQIGf4kuOnnKpfcIdo5bte6HrnN2zt9hRmsLs70xXbsVdxQ/pczPWIIKe38iMxTcDq1jt/j8fJA5UnFZaAwoo4fTFyLkSjVD6N11Md6R0wyZLXieJwoSqOzxGP+I1lCd+T5UvB3fifjf2mWk4E1GhUTh+upNKZ+mP/MB/KSTQ0qRxuaAbEpZSrcYciFEJGIFMYPU7lZ+FOSa94bNaBi43QvOGDTugn5EytqACKqNv4EuqhmSyZA4bsDttyCG76hVlLYCtYCPYRv+rEui853X2kI43zpbZWtz+zdRzs4ZEE+877ZjZzD9WWZAFGRUywLbJ39j83rvPEc0cNgDB6Aqz4NkPfogPWbV8mQ0+jPKBSP1SLYTLh8vY6o4HIGFX9+FOUBRpezFiNFd65AV9vhVvxPAQasx876QInjKapW6Vy5WPpMRQmD3wPeobVtCLqfby6I5GyrShfw+ttsp7ylvuolAau3EQBq5YoxmZpxzp+wlJA8D6DmgjnyAyBAirXkasfFVLJBMspxGtPSpm76qNr4qyj4d+Ku2V/cMxgDdQ1gm8v6Xa5IZKmLYLwaBT5WaOGB/caYZG+VY3L+skKbyieb/ZnBDUHgcVgRQWUtOeZOMfFm+0nmpXF9kmpeSOhCe8ZsTPkOr6KR5TfqIZKz1KAXT8IVjmCkHxwuCrB4ukYd3vjxL/pvavlnJI/KuB05wkNtOK6g3mV9/SNa7CmPqD26j9NpYdFQMG5B+C/z+axPnm5MbitHnbb7jycDigw4xj5Ljge1JqE/R0MtxtCQ
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(396003)(346002)(136003)(376002)(230922051799003)(1800799009)(451199024)(186009)(64100799003)(82310400011)(46966006)(36840700001)(40470700004)(40480700001)(40460700003)(47076005)(36860700001)(81166007)(2906002)(356005)(5660300002)(86362001)(44832011)(336012)(16526019)(426003)(83380400001)(82740400003)(1076003)(26005)(2616005)(41300700001)(36756003)(478600001)(6916009)(70586007)(316002)(70206006)(8936002)(54906003)(4326008)(8676002)(16060500005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2023 19:44:24.9593 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a2822c6f-41f4-4d31-0daf-08dbe61345a9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB71.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6567
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

Augment the function to allow send different format data in different
use case.

Reviewed-by: Dennis Chan <dennis.chan@amd.com>
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Max Tseng <max.tseng@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_types.h              |  1 +
 drivers/gpu/drm/amd/display/dc/dce/dmub_replay.h       |  3 +--
 drivers/gpu/drm/amd/display/dc/inc/link.h              |  2 +-
 .../display/dc/link/protocols/link_edp_panel_control.c |  4 ++--
 .../display/dc/link/protocols/link_edp_panel_control.h |  2 +-
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h        | 10 ++++++++++
 6 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_types.h b/drivers/gpu/drm/amd/display/dc/dc_types.h
index edf60c4f318c..6f5da510e8de 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_types.h
@@ -1029,6 +1029,7 @@ enum replay_coasting_vtotal_type {
  * passed to DMUB.
  */
 enum replay_FW_Message_type {
+	Replay_Msg_Not_Support = -1,
 	Replay_Set_Timing_Sync_Supported,
 };
 
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_replay.h b/drivers/gpu/drm/amd/display/dc/dce/dmub_replay.h
index 427bc47a676e..368711f76335 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_replay.h
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_replay.h
@@ -46,8 +46,7 @@ struct dmub_replay_funcs {
 	void (*replay_set_power_opt)(struct dmub_replay *dmub, unsigned int power_opt,
 		uint8_t panel_inst);
 	void (*replay_send_cmd)(struct dmub_replay *dmub,
-		enum replay_FW_Message_type msg, unsigned int panel_inst,
-		uint32_t cmd_data);
+		enum replay_FW_Message_type msg, unsigned int panel_inst, union dmub_replay_cmd_set *cmd_element);
 	void (*replay_set_coasting_vtotal)(struct dmub_replay *dmub, uint16_t coasting_vtotal,
 		uint8_t panel_inst);
 	void (*replay_residency)(struct dmub_replay *dmub,
diff --git a/drivers/gpu/drm/amd/display/dc/inc/link.h b/drivers/gpu/drm/amd/display/dc/inc/link.h
index dd3f53151d8b..7439865d1b50 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/link.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/link.h
@@ -283,7 +283,7 @@ struct link_service {
 			const struct dc_stream_state *stream);
 	bool (*edp_send_replay_cmd)(struct dc_link *link,
 			enum replay_FW_Message_type msg,
-			uint32_t params);
+			union dmub_replay_cmd_set *cmd_data);
 	bool (*edp_set_coasting_vtotal)(
 			struct dc_link *link, uint16_t coasting_vtotal);
 	bool (*edp_replay_residency)(const struct dc_link *link,
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
index c52b51b2b4b3..6bc8ec47e267 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
@@ -1014,7 +1014,7 @@ bool edp_setup_replay(struct dc_link *link, const struct dc_stream_state *stream
  */
 bool edp_send_replay_cmd(struct dc_link *link,
 			enum replay_FW_Message_type msg,
-			uint32_t cmd_data)
+			union dmub_replay_cmd_set *cmd_data)
 {
 	struct dc *dc = link->ctx->dc;
 	struct dmub_replay *replay = dc->res_pool->replay;
@@ -1026,7 +1026,7 @@ bool edp_send_replay_cmd(struct dc_link *link,
 	if (!dc_get_edp_link_panel_inst(dc, link, &panel_inst))
 		return false;
 
-	replay->funcs->replay_send_cmd(replay, msg, cmd_data, panel_inst);
+	replay->funcs->replay_send_cmd(replay, msg, panel_inst, cmd_data);
 
 	return true;
 }
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.h b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.h
index 6b223580ac8a..39526bd40178 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.h
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.h
@@ -59,7 +59,7 @@ bool edp_setup_replay(struct dc_link *link,
 		const struct dc_stream_state *stream);
 bool edp_send_replay_cmd(struct dc_link *link,
 			enum replay_FW_Message_type msg,
-			uint32_t params);
+			union dmub_replay_cmd_set *cmd_data);
 bool edp_set_coasting_vtotal(struct dc_link *link, uint16_t coasting_vtotal);
 bool edp_replay_residency(const struct dc_link *link,
 	unsigned int *residency, const bool is_start, const bool is_alpm);
diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index 55573083bc31..5f06cf4c663f 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -3143,6 +3143,16 @@ struct dmub_rb_cmd_replay_set_timing_sync {
 	struct dmub_cmd_replay_set_timing_sync_data replay_set_timing_sync_data;
 };
 
+/**
+ * Definition union of replay command set
+ */
+union dmub_replay_cmd_set {
+	/**
+	 * Definition of DMUB_CMD__REPLAY_SET_TIMING_SYNC_SUPPORTED command data.
+	 */
+	struct dmub_cmd_replay_set_timing_sync_data sync_data;
+};
+
 /**
  * Set of HW components that can be locked.
  *
-- 
2.42.0

