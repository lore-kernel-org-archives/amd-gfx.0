Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0426ACD1297
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Apr 2024 21:28:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 095EA10FA6C;
	Wed, 10 Apr 2024 21:28:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wS0seMTZ";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2057.outbound.protection.outlook.com [40.107.237.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5AA5B10EA5C
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Apr 2024 21:28:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lvhlZxLwHj+L/ElZHNToxyoAFzGNX+A9OkfPpEH8o1gwp022sSa5nGkfnJvHiOpB7NPoOu+KI5kcyqJMkrtKpGoFdcFXyrcfMBPQHx8l6hmxn5wUbPINXay8j7NYLFw+pcYxDFJENw2KmV/QyzqhEEQO+2zyvND71ZIuOdzumPVrn+iGoiNbMQ30htD8BWSqgEGgUZc/9oGlryz/bWrF1DetmNl/NWJBSkTPNeCY8T1JU+YcyzGrPpnZFoi6LfoIlEgv3mW3sGYB6BakP8DAEtWZt5xwNKASA0DKv32Kh+HL8uzsGYViiekiXW4TkpTdwMaxeHL6SsoOww3tI7x2Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4cgfMy2KL6L4+y3IA7W47I2bM9VgLU3hMRsKRtAIzdM=;
 b=Q1SLkPsvQQumbeZkkQNYqxrClgoq+KUSf2HVO82KRrGooSz8+1X3NSjQbOhP6AUYKm52rRfPk8NUvvAFdejoOjnOK2cl8AmO4ftu/SxFRd1693/L00JmV0d3Ymcgn3p7Q43HcuGlUSq3mxVygeTopPSqyTBitH5qe/zCcVxKhFyWuqM7qd7RYsVwk4AYL0OXe7meTfIQkIIqDjSOkRDdvRoyWC1UnXAHIckyva1e9TXQ0MiNQtj8l40qWAmFpU6pRJ+shuXfsq/33a3QO1miEFgVzU34DIeD/PETPnM7QsxcX2EexKm/VOrjj4rF6CcCB3SySThvS5yMSIWB8tUtVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4cgfMy2KL6L4+y3IA7W47I2bM9VgLU3hMRsKRtAIzdM=;
 b=wS0seMTZNHQLNOdWApXWoWu4xqK5+T0e862ZM7FqwiNrgvA5Bd+pP7DFvjcdPdeU0GQjAB7adPPwZ6fBDhU/q1Ecd0IS657XEwwUe2ALhiWndL0KhnZ/3rq1zSPxtUa6ywvhqZp3HSvmQQqxFvX5ReFkCxv24zQALNNIZhdk8cA=
Received: from BN0PR04CA0086.namprd04.prod.outlook.com (2603:10b6:408:ea::31)
 by PH7PR12MB7843.namprd12.prod.outlook.com (2603:10b6:510:27e::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Wed, 10 Apr
 2024 21:28:09 +0000
Received: from BN2PEPF000044A9.namprd04.prod.outlook.com
 (2603:10b6:408:ea:cafe::5a) by BN0PR04CA0086.outlook.office365.com
 (2603:10b6:408:ea::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.19 via Frontend
 Transport; Wed, 10 Apr 2024 21:28:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044A9.mail.protection.outlook.com (10.167.243.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Wed, 10 Apr 2024 21:28:08 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 10 Apr
 2024 16:28:06 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Anthony Koo
 <anthony.koo@amd.com>, Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Subject: [PATCH 10/25] drm/amd/display: Expand dmub_cmd operations
Date: Wed, 10 Apr 2024 15:25:59 -0600
Message-ID: <20240410212726.1312989-11-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240410212726.1312989-1-Rodrigo.Siqueira@amd.com>
References: <20240410212726.1312989-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A9:EE_|PH7PR12MB7843:EE_
X-MS-Office365-Filtering-Correlation-Id: 69e20275-6ddc-4c5b-d4f2-08dc59a51e13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R5fEWlgxhKA0zejNc/8JzAcMedybNFJJDWVh94bhNjn+OB1M++Te3AyIyDUkrf4QLRFpDkxpweA4AgiJFtFOrN6b/v1kCXIKVyJlkqdWWAwhl5I7LSFfNip6aaQyqte1Cqb5dB1vBd946VXrNqdiTU5ly10S8Oo3G+3y3ELMmMC0daFuvzid5WpvMlRO4+7w8z6+mOyAtoUnm7kA/9bcx6Olvmwn8CJSg1AGGhVDG1blXsdqpwa6bjk5gU0QJllr68vTbGtSnw0hIIdn1gPsO0EMJCsoMyYWu5RxlxpdbOz3ZX1b8bAx/vBD3/nbG8E5ioGtg2X+NgtfK4ywNuTL2Xyk0ZplIymHrjjyj73YZiPysQEZAAZvyAemhuUKt1M4zztKmvYhVNMn0waSyq1yFm/AneL/rjDFcBzDr9j5XwrCCtggn0J9/mucS5bi7LmMBrx3F5f4LhI628EBUKXWvETs44y66+rlgX8jq0xAiBeFdzuprAw6ombo0hDQaz1aNCh1k/90VH0VLDIeHcASNVVZ1Hq6tGwmJ1SSaPUF5MmoOK2RpQvkO/uoAYcPC6FG9QTc3/P5YfJLYE1G5Z2PUf+qAV8ChAcAk4iObs3Htue7NhbEA7/Gwhcur4TExzcmQrAflXtTG/Ta0F7NNipAUFj4hvVifPENSfUUnpvNbheWEHVU0cZGqZR1eeSVXyqH5/PAh34cMVeQv3IcCIiuW+Ibl4tCcjET8rdiwsIPtIN8TUYAxVMdtXxP2gQsIoIJ
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(376005)(82310400014)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2024 21:28:08.7766 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 69e20275-6ddc-4c5b-d4f2-08dc59a51e13
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A9.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7843
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

Update dmub_cmd to manipulate SDP control in replay FSM, add command
for panel_cntl, expand link rate enum, and increase the reserve byte.

Acked-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Signed-off-by: Anthony Koo <anthony.koo@amd.com>
---
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   | 53 ++++++++++++++++++-
 1 file changed, 52 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index 944f14307517..e85fd3ac52c7 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -1614,7 +1614,7 @@ struct dmub_rb_cmd_idle_opt_dcn_restore {
  */
 struct dmub_dcn_notify_idle_cntl_data {
 	uint8_t driver_idle;
-	uint8_t pad[1];
+	uint8_t reserved[59];
 };
 
 /**
@@ -2335,6 +2335,11 @@ enum phy_link_rate {
 	 * UHBR10 - 20.0 Gbps/Lane
 	 */
 	PHY_RATE_2000 = 11,
+
+	PHY_RATE_675 = 12,
+	/**
+	 * Rate 12 - 6.75 Gbps/Lane
+	 */
 };
 
 /**
@@ -3062,6 +3067,11 @@ enum dmub_cmd_replay_type {
 	 * Set pseudo vtotal
 	 */
 	DMUB_CMD__REPLAY_SET_PSEUDO_VTOTAL = 7,
+	/**
+	 * Set adaptive sync sdp enabled
+	 */
+	DMUB_CMD__REPLAY_DISABLED_ADAPTIVE_SYNC_SDP = 8,
+
 };
 
 /**
@@ -3263,6 +3273,20 @@ struct dmub_cmd_replay_set_pseudo_vtotal {
 	 */
 	uint8_t pad;
 };
+struct dmub_cmd_replay_disabled_adaptive_sync_sdp_data {
+	/**
+	 * Panel Instance.
+	 * Panel isntance to identify which replay_state to use
+	 * Currently the support is only for 0 or 1
+	 */
+	uint8_t panel_inst;
+	/**
+	 * enabled: set adaptive sync sdp enabled
+	 */
+	uint8_t force_disabled;
+
+	uint8_t pad[2];
+};
 
 /**
  * Definition of a DMUB_CMD__SET_REPLAY_POWER_OPT command.
@@ -3366,6 +3390,20 @@ struct dmub_rb_cmd_replay_set_pseudo_vtotal {
 	struct dmub_cmd_replay_set_pseudo_vtotal data;
 };
 
+/**
+ * Definition of a DMUB_CMD__REPLAY_DISABLED_ADAPTIVE_SYNC_SDP command.
+ */
+struct dmub_rb_cmd_replay_disabled_adaptive_sync_sdp {
+	/**
+	 * Command header.
+	 */
+	struct dmub_cmd_header header;
+	/**
+	 * Definition of DMUB_CMD__REPLAY_DISABLED_ADAPTIVE_SYNC_SDP command.
+	 */
+	struct dmub_cmd_replay_disabled_adaptive_sync_sdp_data data;
+};
+
 /**
  * Data passed from driver to FW in  DMUB_CMD__REPLAY_SET_RESIDENCY_FRAMEUPDATE_TIMER command.
  */
@@ -3421,6 +3459,11 @@ union dmub_replay_cmd_set {
 	 * Definition of DMUB_CMD__REPLAY_SET_PSEUDO_VTOTAL command data.
 	 */
 	struct dmub_cmd_replay_set_pseudo_vtotal pseudo_vtotal_data;
+	/**
+	 * Definition of DMUB_CMD__REPLAY_DISABLED_ADAPTIVE_SYNC_SDP command data.
+	 */
+	struct dmub_cmd_replay_disabled_adaptive_sync_sdp_data disabled_adaptive_sync_sdp_data;
+
 };
 
 /**
@@ -4096,6 +4139,10 @@ enum dmub_cmd_panel_cntl_type {
 	 * Queries backlight info for the embedded panel.
 	 */
 	DMUB_CMD__PANEL_CNTL_QUERY_BACKLIGHT_INFO = 1,
+	/**
+	 * Sets the PWM Freq as per user's requirement.
+	 */
+	DMUB_CMD__PANEL_DEBUG_PWM_FREQ = 2,
 };
 
 /**
@@ -4667,6 +4714,10 @@ union dmub_rb_cmd {
 	 * Definition of a DMUB_CMD__REPLAY_SET_PSEUDO_VTOTAL command.
 	 */
 	struct dmub_rb_cmd_replay_set_pseudo_vtotal replay_set_pseudo_vtotal;
+	/**
+	 * Definition of a DMUB_CMD__REPLAY_DISABLED_ADAPTIVE_SYNC_SDP command.
+	 */
+	struct dmub_rb_cmd_replay_disabled_adaptive_sync_sdp replay_disabled_adaptive_sync_sdp;
 	/**
 	 * Definition of a DMUB_CMD__PSP_ASSR_ENABLE command.
 	 */
-- 
2.43.0

