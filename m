Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D97E9C27C52
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Jun 2024 21:02:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6707B10EAAA;
	Thu,  6 Jun 2024 21:02:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uE5WPIOp";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2071.outbound.protection.outlook.com [40.107.102.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E9E3F10EAA9
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Jun 2024 21:02:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dOxzZHscgi2AutEF3dxAidGySLw8t8qGeV9PIcn4QeNGy3zbCu8EID0fh7+vxj+knG2SyuyoNshLHwHnqqKgWZ/IahRztnGg99y3LSn1IGZko4p06qm3ZEmpQYjQcpKcPucD0CRiNvhCgpXQuY7mLASg1CX/wJ8Ol0PGSLT7aE2LShUN3SG483qhOh/Exf/ggPzAsomdj/J8d32NA79e6AMWN/6wKg/YaZfOi2vexYBha+9DgKa1TqE52OVmyxKpkzt4Yzjhh5s6Zcf1rw10YZDCoZyxeFX/4W97wSUqDNkXNqXC0A8MgQNO2qJHp8hK9jUYGcLpTbDSfn4FoQdFFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r02KKUZ6BklxQwDg3bT3+f0qD85cG/iWiE5ffTXYynw=;
 b=gvErpKt9UWbiMVnDOl1abDBtb5qbWm26d/WvRAzIwBto65Tt1lAQPRswDrCSC5CC3/A8Zxq7w6SDnHEFzPRbKLq/OUxraFxOsALKafUjjZMv3HuHzgprOedhwBkt4ZQqpzyHhxXcyPg8BsYNFC8jW2pgI7yXGVuE6sxcipMmwBmEdlcfOWfwfFB1hddmVI3PCwUCBzPnKDV+4L+J7eD159LldAh1bA8A+2A+dJ8Mu13oicoUxqk/JQS3hGOkb1BkV4DbHMyPd0HIByDjPvRDaAgcvc303gHoSjH0GazdmRScFF73MVqVrbD8C9eUmDiGlCxf0SZiNN0iBTnhZIA8KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r02KKUZ6BklxQwDg3bT3+f0qD85cG/iWiE5ffTXYynw=;
 b=uE5WPIOp/bFUvzTGFJb3nlT9WCwd/ioh9JJwAg53UP6EFtfhkuY20/zhpINC3VOcHkxnGr0uN3uanGjZM5WDsoGKst292ur8DsrdJNxOBxMIoUestMCKX2bJ0aQ/8UPCD7exy+WjCZBhyvUAnp6EmLI0pJpjNgJmNXYz4Sgw6jU=
Received: from SN7PR04CA0035.namprd04.prod.outlook.com (2603:10b6:806:120::10)
 by LV8PR12MB9335.namprd12.prod.outlook.com (2603:10b6:408:1fc::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.33; Thu, 6 Jun
 2024 21:01:59 +0000
Received: from SA2PEPF0000150A.namprd04.prod.outlook.com
 (2603:10b6:806:120:cafe::89) by SN7PR04CA0035.outlook.office365.com
 (2603:10b6:806:120::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.20 via Frontend
 Transport; Thu, 6 Jun 2024 21:01:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF0000150A.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Thu, 6 Jun 2024 21:01:58 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 6 Jun
 2024 16:01:56 -0500
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, Dennis Chan <dennis.chan@amd.com>
Subject: [PATCH 05/67] drm/amd/display: Fix Replay Desync Error Test
Date: Thu, 6 Jun 2024 16:58:26 -0400
Message-ID: <20240606205928.4050859-6-zaeem.mohamed@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240606205928.4050859-1-zaeem.mohamed@amd.com>
References: <20240606205928.4050859-1-zaeem.mohamed@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF0000150A:EE_|LV8PR12MB9335:EE_
X-MS-Office365-Filtering-Correlation-Id: bd3415f3-fca1-41c1-f387-08dc866be7e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|36860700004|376005|82310400017|1800799015; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?x6itO0AKi0KOQVCBaw1NnzaphjnD3kvXNUPhDwh3W1wkcG4wtTZit4Q/c71Q?=
 =?us-ascii?Q?R9kLt4B0I5kgf49chN9HDwcOFl6Jv9n3V1swuwmrWw/i2a1Vfxpi5rIrXe0G?=
 =?us-ascii?Q?9nGjyE9tmMsxXy8d1/xmLN1OehlzRrebQWl4+eWWnGIIsU2HkPP+sIV1dF72?=
 =?us-ascii?Q?gKJ88G6XhRDmF7UkBrdyT/+QuXnpUuBPIlMRs9VcUztJyjk+pcuFoU2q0+ff?=
 =?us-ascii?Q?TATr+HTr7fLsL0dCpX2LT+4m5q50lyHnvEcRfeLwCND2fxs66+YD6D08Eftw?=
 =?us-ascii?Q?pOo4BmaBaceGz8PmWNfYUxDuV/4DujZXoGO81Kzu1lIvjv8NBhje1kdQ7KvH?=
 =?us-ascii?Q?RbJ1YTe+woHGvFjAdp8nBAJAtaZr9cmSq+8Ya8jzwHsX4hzGxGhT1npmXfgb?=
 =?us-ascii?Q?pmaonprLfLST+UJna1qMXlxdJ9PmheU7UXaatHqYZ5fSiFmetASfpn7MRgUg?=
 =?us-ascii?Q?JVqm/9P92fOf3UX7AU95K3bsmyNpNquUDceb2O8ktgjo14Mzgni/CJ0UO2ff?=
 =?us-ascii?Q?Y+FBiIpxta+7/A2PW0/83rdhJkBzOdTQ1rBkLyQ1cCS9UBtUiz7nToBIEfRl?=
 =?us-ascii?Q?zrU2DiY2ftbHKDfTqB94k6NC8+NhsinwWat+du5ZlpM2cgvjEDqqwdHjqSp2?=
 =?us-ascii?Q?x7hALg+F2bo++77SlTkGZJ7I3SWPUxvmELrZ413Y8n2B0TVtRqVMhg9y7xNv?=
 =?us-ascii?Q?ztd7dDRU3b8SYi4drQADPp9L6QUKCSti3iz5AULsDsccM2gyTc1whPwJ35SK?=
 =?us-ascii?Q?qSGebAQG857/LIr/Efrvg3tZD4hdG1gF7mmbHDO2tf86ZSoTxlz2UBirrqx9?=
 =?us-ascii?Q?nYEfsXhQVh8/Mho4UfPymSTDmR/AigujjorPL3W6kakgPgD+nH7WRpjet6zt?=
 =?us-ascii?Q?ye2Wj8N992JbrzxJCmf8uRELqnaiY5ed0PpKCoFjdknlBpGAkKnuVA7IhCw6?=
 =?us-ascii?Q?RXRihK/yfpLkvmkhFT0XNkynWfqMfV2+5PRwmiXn2gOu0luMXlIpGH8aStAD?=
 =?us-ascii?Q?/y7Q/+a153J+h1aUwT7v2Zvck9Pedi3t/4GKnJ1oF0clK3CzHNrZYdj7nJT5?=
 =?us-ascii?Q?aMhUs3gfMI3Mp1sC/WpzU2WJNXgDKW3+0wBRu56pCTlNw6px9Rih5mlnHYyf?=
 =?us-ascii?Q?carGw0L1U+1JVVrWh2uWQiPZEOZ1EzBA/AvQpeONAb2ODCatOlBnmm8uWIi4?=
 =?us-ascii?Q?dFXyudhwXT0VGYIgwtI6byJ6WQFYQBNEzgGjDbTHQ1pmPD92pyzSXfgJntqs?=
 =?us-ascii?Q?G3JS2NZzV++/qyouL+9g5R2hEyIeBhXl5/vVj+hEyKU6olr60FBjtAeGKxMe?=
 =?us-ascii?Q?CNav23TzpOJU/hWubA4G9zX1jJ3hN4LS5fnoJMxIrsQBxYJyifcOn3OgXydM?=
 =?us-ascii?Q?x0LxW1jEsln/qF773pmuSNCPWG/Z4qJyJpFJb+fl3MIjArTkMw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(376005)(82310400017)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 21:01:58.9060 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bd3415f3-fca1-41c1-f387-08dc866be7e5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF0000150A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9335
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

From: Dennis Chan <dennis.chan@amd.com>

When PHY power off, the DP_SEC_CNTL cannot be configured and cause
disable Adaptive sync SDP failed. Regarding the issue, the driver will
disabled AS-SDP in replay state machine.

Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Dennis Chan <dennis.chan@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dce/dmub_replay.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_replay.c b/drivers/gpu/drm/amd/display/dc/dce/dmub_replay.c
index 958a927d0cea..62e03fdf813b 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_replay.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_replay.c
@@ -362,6 +362,18 @@ static void dmub_replay_send_cmd(struct dmub_replay *dmub,
 		cmd.replay_set_pseudo_vtotal.data.vtotal =
 			cmd_element->pseudo_vtotal_data.vtotal;
 		break;
+	case Replay_Disabled_Adaptive_Sync_SDP:
+		//Header
+		cmd.replay_disabled_adaptive_sync_sdp.header.sub_type =
+			DMUB_CMD__REPLAY_DISABLED_ADAPTIVE_SYNC_SDP;
+		cmd.replay_disabled_adaptive_sync_sdp.header.payload_bytes =
+			sizeof(struct dmub_rb_cmd_replay_set_pseudo_vtotal);
+		//Cmd Body
+		cmd.replay_disabled_adaptive_sync_sdp.data.panel_inst =
+			cmd_element->disabled_adaptive_sync_sdp_data.panel_inst;
+		cmd.replay_disabled_adaptive_sync_sdp.data.force_disabled =
+			cmd_element->disabled_adaptive_sync_sdp_data.force_disabled;
+		break;
 	case Replay_Msg_Not_Support:
 	default:
 		return;
-- 
2.34.1

