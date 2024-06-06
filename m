Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4A0DC27C6E
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Jun 2024 21:59:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 38D6910EB0C;
	Thu,  6 Jun 2024 21:59:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IKyP8jAP";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2069.outbound.protection.outlook.com [40.107.237.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 68EED10EB10
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Jun 2024 21:59:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aZNHCHvUBsynLwG84ttA7WKV2QDDrxrx4hNCztOXkJNlmuoNeAVAf6andMcNZZ17ZAufXMSHdXKwYg8GWjyUDW6hcZre/Rwb77ckcA6/YKArO2VPsjvp9y9UUvc48RsnOd6mynfQG4+bjBBsAzR7yLwVzcz0DOrwaUaS2ntHAXEoW3Ty3DIpzrjLErmyf49TBTxB1z0OSKVrckctkEX5Oe0XjfYoGqHr3T9zA+yiqOnpIQN3ovtv+juh5X8wwsVRQr31AD5c8booS8Eg9UHTF8gwlGdWmArInTt8PllDhn1JpzVXMLuXrtmNbXUFE5TzgzAJLbZIQAgMyQ9Zi+oZhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IA1zP1l6yqvtrQNEHic5sSooKT9MAPHeN5zFnBMTqFk=;
 b=XhyiBOmXSnHe+jJg6/UgFFj/bFpaJE7wBb1yXP/CC08ic0zldZNN0xpcdIyApl1+E7rNXrkJtA8uARbt+hq5fR8fJu8XiuOtzV8ReHJ5mN9PFGD+eAi/WpSlKvmufBUyzFkVO0dL54Jzo/UqBZrY18w2mymsI6FHrQT+UPO0CJtoTCMEdJntLG0ll3e2NiwsJUmvBMrOZzpRtC7GOaDiU0uVSeS/35i2+an6dTLHrc1lSOMTKAPTVwQVNkH9xfLa5UzFLoaY2BUi0GT+w1qt1DqRJ0h6XDFOKjf+EWR6RqKBfCH7eLlNheUoTJ2lhju1qjdpHvtvNK6iHj43tDRTMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IA1zP1l6yqvtrQNEHic5sSooKT9MAPHeN5zFnBMTqFk=;
 b=IKyP8jAPqEHPxF5CLM/5GVBddxfgaRR/5VOB3nNZRQlAzF2fNsBypOyC3HwHWaEJx/ITZx98hUgeHW1ugcSmnMY6/AiHwNVs9n1dqfSJC6vujJujX1AGTqb1sl0Ka1plPF0nh5gntrygIiEPxWgtZXzEyLmO0k4e9cBCCNPnIUc=
Received: from MN2PR05CA0002.namprd05.prod.outlook.com (2603:10b6:208:c0::15)
 by SA1PR12MB6752.namprd12.prod.outlook.com (2603:10b6:806:259::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.27; Thu, 6 Jun
 2024 21:59:14 +0000
Received: from BL6PEPF0001AB56.namprd02.prod.outlook.com
 (2603:10b6:208:c0:cafe::6f) by MN2PR05CA0002.outlook.office365.com
 (2603:10b6:208:c0::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.12 via Frontend
 Transport; Thu, 6 Jun 2024 21:59:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB56.mail.protection.outlook.com (10.167.241.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Thu, 6 Jun 2024 21:59:14 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 6 Jun
 2024 16:59:13 -0500
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, Anthony Koo <anthony.koo@amd.com>, Zaeem Mohamed
 <zaeem.mohamed@amd.com>
Subject: [PATCH 66/67] drm/amd/display: [FW Promotion] Release 0.0.221.0
Date: Thu, 6 Jun 2024 17:56:31 -0400
Message-ID: <20240606215632.4061204-67-zaeem.mohamed@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240606215632.4061204-1-zaeem.mohamed@amd.com>
References: <20240606215632.4061204-1-zaeem.mohamed@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB56:EE_|SA1PR12MB6752:EE_
X-MS-Office365-Filtering-Correlation-Id: d3fd15f5-3145-4af3-3c47-08dc8673e7a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|376005|82310400017|36860700004; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?lXcjh6UMqYjSf04XBAZfWcX8LVSw5bUsFA7iltPfhFYRJq+fdyp6JK3QVhgb?=
 =?us-ascii?Q?7tiLszTG49ANtzu9U5/Xp6QbzSbz7FOyL42UIbtMnXpCmnvDn7j7q6SdwRbM?=
 =?us-ascii?Q?6muSO0A0HO4ir3/jfp3HxbemDH2STmPvVTLcU/43UvLSCUoCpwK39zVK8vh4?=
 =?us-ascii?Q?yJcClz/zHgD0QPc7q8ZUT1eJixcHHYF0JNqkxhCeHuqjN4q9o4uCqTPllsbx?=
 =?us-ascii?Q?zxwSSAlKjWKON5GFFaoHnQ0v855NHPm38yic/oMo8cbimbgL4l+V0BOD5x9P?=
 =?us-ascii?Q?1Ke1aJWZSWpT7f+SmAgamadMwAkLWUIv/7Q8QKC7G5bxFayzclutntp0wH0b?=
 =?us-ascii?Q?qMD9Peb5DP2MABZxKEtS0VF/QqfW8hlikGQcn4Tdi8q5ORaOggLrgmclfFXG?=
 =?us-ascii?Q?r3DL0EMMFTHA+uQ5cguMvDKleJjmSVY2m5h81q7YdEE9hkSkYk6sakZajUoy?=
 =?us-ascii?Q?xDZkhrC+kJKLzKwNoMMmXXd9WXrI5xe1Q32XDYZ1VJh3EExHHfheFf0dpYWb?=
 =?us-ascii?Q?qF/NCJpESBY43yDjs+ZB+6hIC9JaszzCjzG3dpAkH+XtoaTBeea9HLfbum1N?=
 =?us-ascii?Q?p6/fzh8OFBNMnbR7apt0L+VyYVg8M0QhBWgdtplRajhDUhliwQe7IvCUFxh6?=
 =?us-ascii?Q?6KJrHzPLST24eEzMv7t1i4jGJ8VyurhgzkNI8qjLrHVq+zb+S/gqRr+Z3aA9?=
 =?us-ascii?Q?wf0X3miy/lfPj1LW8AEc93lbhwwk1pZ5wRRWmtPkrM6Gvmw71bm2Yo+Dk6J8?=
 =?us-ascii?Q?QVBzkN0wH8+afnRW43R4zWggYdKyMag13Uujwjw1MElYyuwdJEbF9sDtvdUp?=
 =?us-ascii?Q?kD56tLNlLNTfgIwWux62jLhfUsbEaSA/ouIOUCTc5zqLLqlIa/27oiLCi0Ia?=
 =?us-ascii?Q?Bs1ZbS/2ojhhnigV9I4Bf6zNz0AqH/dDxGThwMJ/SIEXHrVQPUnEfxXihCV9?=
 =?us-ascii?Q?eKF2f+Mhpgb9KB6YIBSJ9C9TzyJTmKRnYfuLwCZwgY4MxoM+N/R1L/TNUCVA?=
 =?us-ascii?Q?zFLx73DeLWn6bxp0RC3iJvbwlIJTQtt4RdPIb88CN9AuZiH95eb9U4Hh5hlf?=
 =?us-ascii?Q?e7ThQQVIRR67SscMuXwVF6lt82/PVF8RpiM0Wd+pIsAHLtpnJz7qEhw1U2YM?=
 =?us-ascii?Q?os40jCcrlt+afCwyesVRzxXtvu9tFPRw0YHMRKR4gjYX3hiL5VfQNpeVQiuQ?=
 =?us-ascii?Q?n/Oph0jjtvCN2VUzfIqnxoqrjsF5pr/lFrFkgNGdDqoXsEzQ7LyKjVqwEl5a?=
 =?us-ascii?Q?Jivh3/y0W8rgs8M+yzg9IacnNqdgKiSbTP5Zy0UkEQvSEIlw7RzNrgncpzW7?=
 =?us-ascii?Q?a3cTUERkMHDejKud1bTlolkfgB0yBwmjP2RGnwAbgB5qERCAco6t5hHC/5kg?=
 =?us-ascii?Q?7vRyqd8yJDi44HuwQVMWdrFMy3VZ72FBcqmgntuTK2o1hX4nkw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(82310400017)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 21:59:14.4713 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d3fd15f5-3145-4af3-3c47-08dc8673e7a5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB56.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6752
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

From: Anthony Koo <anthony.koo@amd.com>

 - Create a general command and fix Replay desync error with general cmd

Acked-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
Signed-off-by: Anthony Koo <anthony.koo@amd.com>
---
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   | 61 ++++++++++++++++++-
 1 file changed, 60 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index 3e8d5f2d7429..b75653faf40e 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -3381,7 +3381,25 @@ enum dmub_cmd_replay_type {
 	 * Set adaptive sync sdp enabled
 	 */
 	DMUB_CMD__REPLAY_DISABLED_ADAPTIVE_SYNC_SDP = 8,
+	/**
+	 * Set Replay General command.
+	 */
+	DMUB_CMD__REPLAY_SET_GENERAL_CMD = 16,
+};
 
+/**
+ * Replay general command sub-types.
+ */
+enum dmub_cmd_replay_general_subtype {
+	REPLAY_GENERAL_CMD_NOT_SUPPORTED = -1,
+	/**
+	 * TODO: For backward compatible, allow new command only.
+	 * REPLAY_GENERAL_CMD_SET_TIMING_SYNC_SUPPORTED,
+	 * REPLAY_GENERAL_CMD_SET_RESIDENCY_FRAMEUPDATE_TIMER,
+	 * REPLAY_GENERAL_CMD_SET_PSEUDO_VTOTAL,
+	 */
+	REPLAY_GENERAL_CMD_DISABLED_ADAPTIVE_SYNC_SDP,
+	REPLAY_GENERAL_CMD_DISABLED_DESYNC_ERROR_DETECTION,
 };
 
 /**
@@ -3597,6 +3615,26 @@ struct dmub_cmd_replay_disabled_adaptive_sync_sdp_data {
 
 	uint8_t pad[2];
 };
+struct dmub_cmd_replay_set_general_cmd_data {
+	/**
+	 * Panel Instance.
+	 * Panel isntance to identify which replay_state to use
+	 * Currently the support is only for 0 or 1
+	 */
+	uint8_t panel_inst;
+	/**
+	 * subtype: replay general cmd sub type
+	 */
+	uint8_t subtype;
+
+	uint8_t pad[2];
+	/**
+	 * config data with param1 and param2
+	 */
+	uint32_t param1;
+
+	uint32_t param2;
+};
 
 /**
  * Definition of a DMUB_CMD__SET_REPLAY_POWER_OPT command.
@@ -3714,6 +3752,20 @@ struct dmub_rb_cmd_replay_disabled_adaptive_sync_sdp {
 	struct dmub_cmd_replay_disabled_adaptive_sync_sdp_data data;
 };
 
+/**
+ * Definition of a DMUB_CMD__REPLAY_SET_GENERAL_CMD command.
+ */
+struct dmub_rb_cmd_replay_set_general_cmd {
+	/**
+	 * Command header.
+	 */
+	struct dmub_cmd_header header;
+	/**
+	 * Definition of DMUB_CMD__REPLAY_SET_GENERAL_CMD command.
+	 */
+	struct dmub_cmd_replay_set_general_cmd_data data;
+};
+
 /**
  * Data passed from driver to FW in  DMUB_CMD__REPLAY_SET_RESIDENCY_FRAMEUPDATE_TIMER command.
  */
@@ -3773,7 +3825,10 @@ union dmub_replay_cmd_set {
 	 * Definition of DMUB_CMD__REPLAY_DISABLED_ADAPTIVE_SYNC_SDP command data.
 	 */
 	struct dmub_cmd_replay_disabled_adaptive_sync_sdp_data disabled_adaptive_sync_sdp_data;
-
+	/**
+	 * Definition of DMUB_CMD__REPLAY_SET_GENERAL_CMD command data.
+	 */
+	struct dmub_cmd_replay_set_general_cmd_data set_general_cmd_data;
 };
 
 /**
@@ -5273,6 +5328,10 @@ union dmub_rb_cmd {
 	 * Definition of a DMUB_CMD__REPLAY_DISABLED_ADAPTIVE_SYNC_SDP command.
 	 */
 	struct dmub_rb_cmd_replay_disabled_adaptive_sync_sdp replay_disabled_adaptive_sync_sdp;
+	/**
+	 * Definition of a DMUB_CMD__REPLAY_SET_GENERAL_CMD command.
+	 */
+	struct dmub_rb_cmd_replay_set_general_cmd replay_set_general_cmd;
 	/**
 	 * Definition of a DMUB_CMD__PSP_ASSR_ENABLE command.
 	 */
-- 
2.34.1

