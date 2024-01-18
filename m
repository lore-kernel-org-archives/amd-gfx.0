Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAF8BC4707B
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jan 2024 14:35:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 37B0D10E808;
	Thu, 18 Jan 2024 14:35:08 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2074.outbound.protection.outlook.com [40.107.220.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B365D10E83D
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Jan 2024 14:35:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R0qOmu6e8974xcFwA4nqYX6/i+qd+oHJiRtWrv7VMJT1Gt5kzLlq/wxGNR6Ku7PC0JChyht27K52XsCl19jls7hq9jyul+4uS+HeOxxsUaXl3CC5kAVhBiwW5VgTxLpsIBl/IOuk+Jf2n2awXZOxYv5E0V1Ez1fmGvIAi0uGRqgpWT8dRQCQlqujMsO+gNwryDf7oe3l6TP1LZfhORzNGwFS5HiAu+p5MnNNg64s65NTwqYtqtFyc/ogQqz1UqUjQDyBGGWJeYs4Mmx3czznHOxOaeP+lmeJpzjSTwJFiHaYQcLURFQkMTelifDNRtRr2rmj1tzoiXd0N+Hy1hD6+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ifbCPQuJkH/1x6awOrWbAD1OxTA0xBTpgfqPXFZD5J8=;
 b=Tc+wvcsoLDNvRbns2tzJGFVmKNPIan+fabc9kY7cvFQJxXgCmwd+DjnhNZWkK7lYWKQpbMC7CV5YXuPLcIPOg8n0CmkVBU6xaFKZCUFrW37aDOziGRIyYLYJ7g0kK05Bze9ZPtfra8rf/ZE1+Gz6pMq0HGTQcE/zwtSZKQGEFSDYLl4y3E2QueE+pYyh6ATsl2c16Z6jTf0CcTOHUrU/qL0UWIlil2yQ5lGW60zwmYOAb4MCoRI+m7J9pkn+EGod5XLAhFiEtgdgbBGM/lsm58E8xuOomjEKmr6sw8TheUbeefqcb62EXOdhoaHXOp/uERXDue8fpP4GIX/S/NB9pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ifbCPQuJkH/1x6awOrWbAD1OxTA0xBTpgfqPXFZD5J8=;
 b=ed9Lh1GDNmfotK54R06dSMQzsMiVgrWHlLSGI/IkR3itzFgo/BAwijZb0KFkBA93YjcME2PIp0OUucOI0RBiwSsoiQ/WmuRm7DDHG7tbgDQZ1ew/S59Lv0KzT7NLvFZKpZu8jssrTv35clRYlWo9Mbso9W/aQln5m/UaQkTQ7Ys=
Received: from BYAPR06CA0039.namprd06.prod.outlook.com (2603:10b6:a03:14b::16)
 by CH0PR12MB5092.namprd12.prod.outlook.com (2603:10b6:610:bf::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Thu, 18 Jan
 2024 14:34:50 +0000
Received: from CO1PEPF000044EF.namprd05.prod.outlook.com
 (2603:10b6:a03:14b:cafe::75) by BYAPR06CA0039.outlook.office365.com
 (2603:10b6:a03:14b::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24 via Frontend
 Transport; Thu, 18 Jan 2024 14:34:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044EF.mail.protection.outlook.com (10.167.241.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Thu, 18 Jan 2024 14:34:50 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 18 Jan
 2024 08:34:44 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 18 Jan
 2024 08:34:45 -0600
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Thu, 18 Jan 2024 08:34:44 -0600
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 10/12] drm/amd/display: Replay + IPS + ABM in Full Screen VPB
Date: Thu, 18 Jan 2024 09:33:58 -0500
Message-ID: <20240118143400.1001088-11-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240118143400.1001088-1-Roman.Li@amd.com>
References: <20240118143400.1001088-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044EF:EE_|CH0PR12MB5092:EE_
X-MS-Office365-Filtering-Correlation-Id: 23900595-202b-4a63-333a-08dc1832a098
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZOMbb+PUeyKcVV/ktZOZfCfT71l7eJ2v7W9A9QRKB2BaGBXk6od7Tin6BX3szwBU0agotB09ZUToIixH6g/DNg0e0pNwTkL74+qlKCFRhoYBOvJycDZOTVsO0o/tEW9ktSL1Xv5WC4FYMpKQAvzTfHfcTP588ayIqYTLSyCh6vPnptRy2WJ9c+q8MushneQHzzZRPZtISuKA0g/SR5av1zRPJuBbhkmz8f83e8y8RPuhsCLf+3gWZApEBGxIXDrE6r7Ycd6wGKBRb68P28XUSgjQX2LmojJN3iKMxEH+pg7RU14hfSX3Dgk7nvXLgJnYa7tWm+ihEPK78+0QMuzoYv57DFgeBVJOF+HFqq7zvxntv8jWapAEyVCq8qBFYKQkxii7pMQKK8kwTAMRI09eHGdRD/xzBVVKgXhdwuZVWwE42BaXSHB4X7kGuQTl8XXDWOm77VkcolKrosM2Atdz14RTknyPvnM72nSM3ebGV8C79BRxCF+ODUMw6AEi/EW5eUxKh3oVegNNZadfOpJB5blju1MOmxBVSjX3L9q7qMY0JHQd8T31kmR8/SaKH+l6A6lsVDiBO5k9QrrilHL+QaGkUfRp/LhihN9RyqL2wvUkRMUmOOmTSnujaGsFhwlPclLx+3v+M+XTOyIiWVv32j6DxiHvy3gLyWv/pdqRm7iT+qP1NL8QoMR6rUE7MqOnPlsY452MQECLRyd4Ew8OSITbLm96XquexIiOUy68dQMAscCCE9lv4TUaE/p3M/8854+iny2dJMgy5r4/fV1UMA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(376002)(346002)(396003)(136003)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(82310400011)(36840700001)(40470700004)(46966006)(82740400003)(36860700001)(336012)(26005)(6666004)(1076003)(2616005)(7696005)(426003)(47076005)(83380400001)(5660300002)(4326008)(8936002)(2906002)(2876002)(8676002)(70206006)(478600001)(316002)(70586007)(54906003)(6916009)(41300700001)(86362001)(36756003)(81166007)(356005)(40480700001)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2024 14:34:50.0122 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 23900595-202b-4a63-333a-08dc1832a098
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044EF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5092
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
Cc: chiahsuan.chung@amd.com, Sunpeng.Li@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, ChunTao Tso <chuntao.tso@amd.com>, jerry.zuo@amd.com,
 Aurabindo.Pillai@amd.com, hersenxs.wu@amd.com,
 Dennis Chan <dennis.chan@amd.com>, wayne.lin@amd.com, Harry.Wentland@amd.com,
 agustin.gutierrez@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: ChunTao Tso <chuntao.tso@amd.com>

[Why]
Because ABM will wait VStart to start getting histogram data,
 it will cause we can't enter IPS while full screnn video playing.

[How]
Modify the panel refresh rate to the maximun multiple of current
 refresh rate.

Reviewed-by: Dennis Chan <dennis.chan@amd.com>
Acked-by: Roman Li <roman.li@amd.com>
Signed-off-by: ChunTao Tso <chuntao.tso@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_types.h     |  5 ++
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   | 46 +++++++++++++++++++
 .../amd/display/modules/power/power_helpers.c |  5 ++
 .../amd/display/modules/power/power_helpers.h |  1 +
 4 files changed, 57 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_types.h b/drivers/gpu/drm/amd/display/dc/dc_types.h
index b08ccb8c68bc..9900dda2eef5 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_types.h
@@ -1034,6 +1034,7 @@ enum replay_FW_Message_type {
 	Replay_Msg_Not_Support = -1,
 	Replay_Set_Timing_Sync_Supported,
 	Replay_Set_Residency_Frameupdate_Timer,
+	Replay_Set_Pseudo_VTotal,
 };
 
 union replay_error_status {
@@ -1089,6 +1090,10 @@ struct replay_settings {
 	uint16_t coasting_vtotal_table[PR_COASTING_TYPE_NUM];
 	/* Maximum link off frame count */
 	enum replay_link_off_frame_count_level link_off_frame_count_level;
+	/* Replay pseudo vtotal for abm + ips on full screen video which can improve ips residency */
+	uint16_t abm_with_ips_on_full_screen_video_pseudo_vtotal;
+	/* Replay last pseudo vtotal set to DMUB */
+	uint16_t last_pseudo_vtotal;
 };
 
 /* To split out "global" and "per-panel" config settings.
diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index bcd3c361cca5..e699731ee68e 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -2895,6 +2895,10 @@ enum dmub_cmd_replay_type {
 	 * Set Residency Frameupdate Timer.
 	 */
 	DMUB_CMD__REPLAY_SET_RESIDENCY_FRAMEUPDATE_TIMER = 6,
+	/**
+	 * Set pseudo vtotal
+	 */
+	DMUB_CMD__REPLAY_SET_PSEUDO_VTOTAL = 7,
 };
 
 /**
@@ -3077,6 +3081,26 @@ struct dmub_cmd_replay_set_timing_sync_data {
 	uint8_t pad[2];
 };
 
+/**
+ * Data passed from driver to FW in a DMUB_CMD__REPLAY_SET_PSEUDO_VTOTAL command.
+ */
+struct dmub_cmd_replay_set_pseudo_vtotal {
+	/**
+	 * Panel Instance.
+	 * Panel isntance to identify which replay_state to use
+	 * Currently the support is only for 0 or 1
+	 */
+	uint8_t panel_inst;
+	/**
+	 * Source Vtotal that Replay + IPS + ABM full screen video src vtotal
+	 */
+	uint16_t vtotal;
+	/**
+	 * Explicit padding to 4 byte boundary.
+	 */
+	uint8_t pad;
+};
+
 /**
  * Definition of a DMUB_CMD__SET_REPLAY_POWER_OPT command.
  */
@@ -3157,6 +3181,20 @@ struct dmub_rb_cmd_replay_set_timing_sync {
 	struct dmub_cmd_replay_set_timing_sync_data replay_set_timing_sync_data;
 };
 
+/**
+ * Definition of a DMUB_CMD__REPLAY_SET_PSEUDO_VTOTAL command.
+ */
+struct dmub_rb_cmd_replay_set_pseudo_vtotal {
+	/**
+	 * Command header.
+	 */
+	struct dmub_cmd_header header;
+	/**
+	 * Definition of DMUB_CMD__REPLAY_SET_PSEUDO_VTOTAL command.
+	 */
+	struct dmub_cmd_replay_set_pseudo_vtotal data;
+};
+
 /**
  * Data passed from driver to FW in  DMUB_CMD__REPLAY_SET_RESIDENCY_FRAMEUPDATE_TIMER command.
  */
@@ -3208,6 +3246,10 @@ union dmub_replay_cmd_set {
 	 * Definition of DMUB_CMD__REPLAY_SET_RESIDENCY_FRAMEUPDATE_TIMER command data.
 	 */
 	struct dmub_cmd_replay_frameupdate_timer_data timer_data;
+	/**
+	 * Definition of DMUB_CMD__REPLAY_SET_PSEUDO_VTOTAL command data.
+	 */
+	struct dmub_cmd_replay_set_pseudo_vtotal pseudo_vtotal_data;
 };
 
 /**
@@ -4359,6 +4401,10 @@ union dmub_rb_cmd {
 	 * Definition of a DMUB_CMD__REPLAY_SET_RESIDENCY_FRAMEUPDATE_TIMER command.
 	 */
 	struct dmub_rb_cmd_replay_set_frameupdate_timer replay_set_frameupdate_timer;
+	/**
+	 * Definition of a DMUB_CMD__REPLAY_SET_PSEUDO_VTOTAL command.
+	 */
+	struct dmub_rb_cmd_replay_set_pseudo_vtotal replay_set_pseudo_vtotal;
 };
 
 /**
diff --git a/drivers/gpu/drm/amd/display/modules/power/power_helpers.c b/drivers/gpu/drm/amd/display/modules/power/power_helpers.c
index ad98e504c00d..e304e8435fb8 100644
--- a/drivers/gpu/drm/amd/display/modules/power/power_helpers.c
+++ b/drivers/gpu/drm/amd/display/modules/power/power_helpers.c
@@ -980,6 +980,11 @@ void set_replay_coasting_vtotal(struct dc_link *link,
 	link->replay_settings.coasting_vtotal_table[type] = vtotal;
 }
 
+void set_replay_ips_full_screen_video_src_vtotal(struct dc_link *link, uint16_t vtotal)
+{
+	link->replay_settings.abm_with_ips_on_full_screen_video_pseudo_vtotal = vtotal;
+}
+
 void calculate_replay_link_off_frame_count(struct dc_link *link,
 	uint16_t vtotal, uint16_t htotal)
 {
diff --git a/drivers/gpu/drm/amd/display/modules/power/power_helpers.h b/drivers/gpu/drm/amd/display/modules/power/power_helpers.h
index c17bbc6fb38c..bef4815e1703 100644
--- a/drivers/gpu/drm/amd/display/modules/power/power_helpers.h
+++ b/drivers/gpu/drm/amd/display/modules/power/power_helpers.h
@@ -57,6 +57,7 @@ void init_replay_config(struct dc_link *link, struct replay_config *pr_config);
 void set_replay_coasting_vtotal(struct dc_link *link,
 	enum replay_coasting_vtotal_type type,
 	uint16_t vtotal);
+void set_replay_ips_full_screen_video_src_vtotal(struct dc_link *link, uint16_t vtotal);
 void calculate_replay_link_off_frame_count(struct dc_link *link,
 	uint16_t vtotal, uint16_t htotal);
 
-- 
2.34.1

