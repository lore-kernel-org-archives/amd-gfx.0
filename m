Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49733CFD65B
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Jan 2026 15:58:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D91D210E634;
	Wed,  7 Jan 2026 15:58:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SZGTGiKO";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010046.outbound.protection.outlook.com
 [52.101.193.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 058F910E62A
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Jan 2026 15:58:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LKoS5ZiY7sjJ0BmLE6KpvWsLiNI3xgeDrwId08cXSLZtrartf08DMM6HMZhu2lWpvYIuQSs7szp2jI2FqTf0DvcAECjiEjl6GYebUUEqPMIfrnBKl6DbLfp1Wdc5gM8lxv2wkPVq7dJufrQlpJeCTO6d0VzmcocbDAy0MZcTHiJMs9Romixebxp+j+AWLKc5cRcCLTYdIzSds3k9GOz9MbORY1ZhRTh75eZzSz2Jvw2PgH+dFbG9Ivzf+zhCyoMo6/2sfRBFekAO5yK82xC6E3nnEM9kJJ0Bzwsa3mXrnvaSiBjuhGCG4laiH+isH45uKM+OVRg/AAQYVZzaWywa3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lO5iK1+OfEgLrWAhytcAqauBHplL4eNb65rXifOJLSw=;
 b=yoJgn2F1WuUiXDXO7Shoq/mKUY1F0rBK4WhWm1XymS5P99JPpvyob6s/FCJXEc/5ToXDtkho6CYYaqS8/i0bmJBJIhpkOtUYNUwQWl0XYLlBfJFYGiNATxH9Z9PfUGQnNdVxKHFLoXBIOIVPdEAlEWsqt67JYL6keUQ0VIIWJDqGH99Fx1JOMESmYEZiVPWSYuqxx/pp3ubK0SWz+yGd/xqyFMNCYlMeGZPoDu7cqSwawXFIL7LyUedQTN3tfY94WVCA0iqTqWv6BsmqRofF+19I7vIEQ6BEvNvEnZ+ad7PO55oUSH/5WqCwIfVl/gFxHjfDTvVflysJU72y50Q2bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lO5iK1+OfEgLrWAhytcAqauBHplL4eNb65rXifOJLSw=;
 b=SZGTGiKOjGBpElKUvcu3dlfgN5W8RxVcpPlpekSf7/MLUD0PfrOQ35Get8fCMhobJJ1+uIttNbVPoLGV1gcSkMwmUTNkY9FgXG+49z+K9d0Qyfyi5hHosPk1ANdwslzB2HDTKAmj5rGlMd4DBY5EP6TNh0rvuoc3Qpeo4RZgtJU=
Received: from SJ0PR03CA0202.namprd03.prod.outlook.com (2603:10b6:a03:2ef::27)
 by SJ0PR12MB6711.namprd12.prod.outlook.com (2603:10b6:a03:44d::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Wed, 7 Jan
 2026 15:57:57 +0000
Received: from SJ5PEPF000001C8.namprd05.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::fe) by SJ0PR03CA0202.outlook.office365.com
 (2603:10b6:a03:2ef::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.2 via Frontend Transport; Wed, 7
 Jan 2026 15:57:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001C8.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9499.1 via Frontend Transport; Wed, 7 Jan 2026 15:57:56 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 7 Jan
 2026 09:57:54 -0600
Received: from mkmmattstew-dt.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 7 Jan 2026 09:57:54 -0600
From: Matthew Stewart <Matthew.Stewart2@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Robin Chen <robin.chen@amd.com>, Jack Chang
 <jack.chang@amd.com>, Matthew Stewart <matthew.stewart2@amd.com>
Subject: [PATCH 03/21] drm/amd/display: Remove unused DMUB replay commands
Date: Wed, 7 Jan 2026 10:47:55 -0500
Message-ID: <20260107155421.1999951-4-Matthew.Stewart2@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260107155421.1999951-1-Matthew.Stewart2@amd.com>
References: <20260107155421.1999951-1-Matthew.Stewart2@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001C8:EE_|SJ0PR12MB6711:EE_
X-MS-Office365-Filtering-Correlation-Id: 1cdb1fc1-6073-4a61-83d3-08de4e05866a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?bs0n31Vl4f+HB6uuWxtXk7lQc/xmfWPMOHjHbNISfkJj7lwVxk4HatBcvc3J?=
 =?us-ascii?Q?izuyw8KYsnYjkulZULntGiyVrBp8/N8uoF9NCDVEV3Xcn06EuxImZzaqa5zv?=
 =?us-ascii?Q?SH9CNDlJXP+20xNzVozfx5NnRtoaDKJWWSq5CpDHqZkPYLLfIPmHuBgnl8r3?=
 =?us-ascii?Q?jb09QY1ozZHs6Bsh8UlpIBdve3RZWcepMLD0xirkMdRIJE3PGf+wXmz4LFi4?=
 =?us-ascii?Q?l/PtGlM9zsf4fN0HZq2lL5p69puM2DWfRWPHXoI5t7HbwQtqmgIWa3NARAUJ?=
 =?us-ascii?Q?ggnLAhnvKF9b4Ory40UwalNgT4YQmYT2mcaQQvFWZMSs8aRXhE9ewtgH5VRs?=
 =?us-ascii?Q?RCa3Yw6ucxdf1B/8QoNENdvZyrXwq5P8CEwkKTEFwhFNlELIhz/f+Cx1rQX0?=
 =?us-ascii?Q?uK/JX/uSo/rRK2etM6TzoqDnaAQRpth0qEbu9Yj/RRWx4h+yRIxkdtJDjcav?=
 =?us-ascii?Q?HlHPl0FRGoRi2sIEfO1ke1KYPAm+dOQ2LismkpIJC1YZcqcu8nCG2l8wTiqi?=
 =?us-ascii?Q?L7zJZ4tyEeNJ5i4PMne379YJ6MO7rdSy3JKxFEYxuNRdWSL5/l+rpPNsEpgV?=
 =?us-ascii?Q?tkC5BMClg3S0pqOt2Q+OaRd6FO8K5ce5gwGqofUcyQ9lPWtkBZAULD91Pc9L?=
 =?us-ascii?Q?iAEP5Z+M+th2bXNyBrniswLXOp0pJ7NnjVxbNm08Db9MPXKxGI2Ik7Rz39ln?=
 =?us-ascii?Q?kWbOX+lQE7lR9Y+ghewfyB8bi5l3/b68cXiVqJ/bBYTjdLAuzZX2iNx5/7NY?=
 =?us-ascii?Q?+tSmGzXzBodQX2/7wXutOLdFNLIt22WIKmXhLdRu3bX7UcmFh6f0R12BtCzT?=
 =?us-ascii?Q?xt6+wao32D70HBFj0LtihhEJn7Vska1kuK6JRK90NtMNPomuA/wSLzrHVb1I?=
 =?us-ascii?Q?POr2+HmUVbxcA1pZ/8kEP18Avd0NeRXXm+nqOQ+BVIKw4TcZZnnDG98Zml9y?=
 =?us-ascii?Q?LWzI9v0OwelOBpuMVPXMS+r9wafzY+/e+Zvg9RvAMy7wj0sBu++SWELSFxXu?=
 =?us-ascii?Q?wsB8a97BwX8MtQqOQRZUyAUf9lqTh+VgfVYOtJgOw0djoQ8gEZz+eo62kxzz?=
 =?us-ascii?Q?ciek7g1v+y5pgbvLWSjqCEtI7Mjx8ZqWNq/hJlreDD6/pUxgPZ/SbBo5pl23?=
 =?us-ascii?Q?Qk0LJEeE4YjRl1QHM5ETZXWaIt5O0bod70QmFeNw3W0S1Xr5XkaxPjalYrw3?=
 =?us-ascii?Q?TuLJxWHrJ9jgLaOyE8wNWAuwwUMXCCISxn3sdHbMUa1sfsd8+EKmS5NEZLtR?=
 =?us-ascii?Q?WopfLEH87UHm8RMKyGacUM2F2sVSq+yGRn9enHErf9S8YLJ7wo8cKsdGE3O6?=
 =?us-ascii?Q?LwrXotd6biHFSizoeCWe6v7a2XK1vWFR2cMKY23+9YWHBfnYBXrQ9FyHavtP?=
 =?us-ascii?Q?iQD+5k9RxUAoVuZdzHlnGbzVRj0s6YgvHj56nW8fjb/2FBxwvJfWnsGsbmQt?=
 =?us-ascii?Q?YCBvbMfzsE6tsVj8B639h41rqBFXOfo+vARoJUxxo8CZtrx7tvn3uKwS0uOx?=
 =?us-ascii?Q?Rydi5kuPVDuWrEBzDX8ZluagMBl4b4E1x/+wvNcmANYSgqQV5LPMB0LMIutN?=
 =?us-ascii?Q?szAR+fsH2gCdTKLd7gA=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2026 15:57:56.8758 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cdb1fc1-6073-4a61-83d3-08de4e05866a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001C8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6711
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

From: Robin Chen <robin.chen@amd.com>

[WHY]
Remove unused DMUB Replay set version command and related code.

Reviewed-by: Jack Chang <jack.chang@amd.com>
Signed-off-by: Robin Chen <robin.chen@amd.com>
Signed-off-by: Matthew Stewart <matthew.stewart2@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_types.h     |  1 -
 .../gpu/drm/amd/display/dc/dce/dmub_replay.c  | 13 ------
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   | 46 -------------------
 3 files changed, 60 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_types.h b/drivers/gpu/drm/amd/display/dc/dc_types.h
index b3b785f1897d..5e71156d28e3 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_types.h
@@ -1101,7 +1101,6 @@ enum replay_FW_Message_type {
 	Replay_Set_Residency_Frameupdate_Timer,
 	Replay_Set_Pseudo_VTotal,
 	Replay_Disabled_Adaptive_Sync_SDP,
-	Replay_Set_Version,
 	Replay_Set_General_Cmd,
 };
 
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_replay.c b/drivers/gpu/drm/amd/display/dc/dce/dmub_replay.c
index cf1372aaff6c..fd8244c94687 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_replay.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_replay.c
@@ -387,19 +387,6 @@ static void dmub_replay_send_cmd(struct dmub_replay *dmub,
 		cmd.replay_disabled_adaptive_sync_sdp.data.force_disabled =
 			cmd_element->disabled_adaptive_sync_sdp_data.force_disabled;
 		break;
-	case Replay_Set_Version:
-		//Header
-		cmd.replay_set_version.header.sub_type =
-			DMUB_CMD__REPLAY_SET_VERSION;
-		cmd.replay_set_version.header.payload_bytes =
-			sizeof(struct dmub_rb_cmd_replay_set_version) -
-			sizeof(struct dmub_cmd_header);
-		//Cmd Body
-		cmd.replay_set_version.replay_set_version_data.panel_inst =
-			cmd_element->version_data.panel_inst;
-		cmd.replay_set_version.replay_set_version_data.version =
-			cmd_element->version_data.version;
-		break;
 	case Replay_Set_General_Cmd:
 		//Header
 		cmd.replay_set_general_cmd.header.sub_type =
diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index 87249b8005d6..87ae63cb0815 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -4334,10 +4334,6 @@ enum dmub_cmd_replay_type {
 	 * Set adaptive sync sdp enabled
 	 */
 	DMUB_CMD__REPLAY_DISABLED_ADAPTIVE_SYNC_SDP = 8,
-	/**
-	 * Set version
-	 */
-	DMUB_CMD__REPLAY_SET_VERSION = 9,
 	/**
 	 * Set Replay General command.
 	 */
@@ -4505,40 +4501,6 @@ enum replay_version {
 	REPLAY_VERSION_UNSUPPORTED		= 0xFF,
 };
 
-/**
- * Data passed from driver to FW in a DMUB_CMD___SET_REPLAY_VERSION command.
- */
-struct dmub_cmd_replay_set_version_data {
-	/**
-	 * Panel Instance.
-	 * Panel instance to identify which psr_state to use
-	 * Currently the support is only for 0 or 1
-	 */
-	uint8_t panel_inst;
-	/**
-	 * Replay version that FW should implement.
-	 */
-	enum replay_version version;
-	/**
-	 * Explicit padding to 4 byte boundary.
-	 */
-	uint8_t pad[3];
-};
-
-/**
- * Definition of a DMUB_CMD__REPLAY_SET_VERSION command.
- */
-struct dmub_rb_cmd_replay_set_version {
-	/**
-	 * Command header.
-	 */
-	struct dmub_cmd_header header;
-	/**
-	 * Data passed from driver to FW in a DMUB_CMD__REPLAY_SET_VERSION command.
-	 */
-	struct dmub_cmd_replay_set_version_data replay_set_version_data;
-};
-
 /**
  * Definition of a DMUB_CMD__REPLAY_COPY_SETTINGS command.
  */
@@ -4941,10 +4903,6 @@ union dmub_replay_cmd_set {
 	 * Definition of DMUB_CMD__REPLAY_DISABLED_ADAPTIVE_SYNC_SDP command data.
 	 */
 	struct dmub_cmd_replay_disabled_adaptive_sync_sdp_data disabled_adaptive_sync_sdp_data;
-	/**
-	 * Definition of DMUB_CMD__REPLAY_SET_VERSION command data.
-	 */
-	struct dmub_cmd_replay_set_version_data version_data;
 	/**
 	 * Definition of DMUB_CMD__REPLAY_SET_GENERAL_CMD command data.
 	 */
@@ -7032,10 +6990,6 @@ union dmub_rb_cmd {
 	 * Definition of a DMUB_CMD__IDLE_OPT_SET_DC_POWER_STATE command.
 	 */
 	struct dmub_rb_cmd_idle_opt_set_dc_power_state idle_opt_set_dc_power_state;
-	/**
-	 * Definition of a DMUB_CMD__REPLAY_SET_VERSION command.
-	 */
-	struct dmub_rb_cmd_replay_set_version replay_set_version;
 	/*
 	 * Definition of a DMUB_CMD__REPLAY_COPY_SETTINGS command.
 	 */
-- 
2.52.0

