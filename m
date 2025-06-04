Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50AA7C5B549
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Jun 2025 19:40:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE92210E7E2;
	Wed,  4 Jun 2025 19:40:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="D76yuito";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2062.outbound.protection.outlook.com [40.107.220.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2748510E7E0
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Jun 2025 19:40:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zXAwCVjG1V/gy1/iSj/F0LkX5K6AL1P70U1faznuvdg0oeZtF5U9spaSSmED+fUBig0/STt2YiPmcTmsCx4rlDc3C+crJUqVwqryu37T8Wx5OROBAZg5fdAojgZWIhYejFloj75gwcB3c41zvJfLZg+HlpqV2mr2IT9dpfhVP+J03r3bKAcYPfOqxVeayDN1tMUxYWb5Q3GoLK9icOvdiyNUFXybJClR3Zrrao1BF9IBvY62QyutOpEoQQMJRSz9uVyv2kbVoJuIkqVDOalVPMuvhdxa9J4YImQKeTmZuyDMshsxrJlUC6rAcfL+jeze+jTVrm4OghRSsC2x1LmxHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RVoRbCvHB3nvhznxIU22WUnNlYIKGlIHvw/3n9Z3vE0=;
 b=xvHmq/XZaudY9k1hAjKbaA3Y+IQmKDNlU870M2ZUCTtFH5VB4thgcMTzgDUn4EMYfCLUD9jOLOg3zoA2RlVh3Kou50Vr1XaVHlGtgGUA1JHuPj7C3svTI6QmynKRwCvBpjz8MdwcPi5+3RiepVIU658FMlLGaIge+7Qc7rp3Dz4qoC/ezxkJ38AOdCdla+9DwF7qk5D1SW4HXe4WPGI+9JyDoyrh33nmmct8GXe/MT+hB2JO5ss0h0NgWDs/BWai6XtSJmUBJr+QQGT5BjblNkeXZsbQfodmKUD8xjdVz1k9xvgexGXFrqad5oqCiSzAlXwR8RqguDoGBu9BtDkXZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RVoRbCvHB3nvhznxIU22WUnNlYIKGlIHvw/3n9Z3vE0=;
 b=D76yuitoUMT4RANhboJPglWpbB7vmcRA8vpdxXEd/R0FNJy2ThZZ96GyFMVO1kAoWvQWO3ghG2hyMalNRaZTbd+glu0Qxr439JQTEG7S7ok0r/iY8Rj0STnmTTBuZN+mvup+GxEfZ2UrkAIe1+LFBi+3OeCWr9/pwpDv/JaKSJ8=
Received: from CH0PR07CA0010.namprd07.prod.outlook.com (2603:10b6:610:32::15)
 by CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Wed, 4 Jun
 2025 19:40:28 +0000
Received: from DS3PEPF000099DB.namprd04.prod.outlook.com
 (2603:10b6:610:32:cafe::b9) by CH0PR07CA0010.outlook.office365.com
 (2603:10b6:610:32::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.30 via Frontend Transport; Wed,
 4 Jun 2025 19:40:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DB.mail.protection.outlook.com (10.167.17.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8792.29 via Frontend Transport; Wed, 4 Jun 2025 19:40:28 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 4 Jun
 2025 14:40:26 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Alex Hung <alex.hung@amd.com>, Muhammad Ahmed
 <Muhammad.Ahmed@amd.com>, Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Subject: [PATCH 14/23] drm/amd/display: Add option to disable PHY SSC
 reduction on transmitter enable
Date: Wed, 4 Jun 2025 12:43:25 -0600
Message-ID: <20250604193659.2462225-15-alex.hung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250604193659.2462225-1-alex.hung@amd.com>
References: <20250604193659.2462225-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DB:EE_|CH3PR12MB8659:EE_
X-MS-Office365-Filtering-Correlation-Id: aed15168-0a7f-45d3-b0e6-08dda39fa914
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?H8wG+RjPF0214Pms/8zXv9q9fQLJKWP2S6S5at5Y1RAv0a1/MCM/Oin8N330?=
 =?us-ascii?Q?GJJSsDCbocQ4HxzOxoOBXcnjqsI6d9mvPFMR7T0uNXeR7XVRoSjMg6W1YBOS?=
 =?us-ascii?Q?ROJKEcvZu805ROq01Q3eNSMyEm3YU5qkzx7ErVIGe43Dp4MFF7MK4y6TIW88?=
 =?us-ascii?Q?OukqnV6+fCf3VMkNQ4IB2091uf/PGu8AeadK2Nw8xN8mwL3p29Z7oWEzyWZq?=
 =?us-ascii?Q?E0Yegh86x+9saWWLdm47XmTWjZsXWcBpdcJNAfvUtS+4FQYvzavRjZ+59A8H?=
 =?us-ascii?Q?Wboa+FL3+BAq8ViTI2nghzqbKvYJkTcuiauiGiH7yyA5qkUCgAtvbXR7c3xH?=
 =?us-ascii?Q?Bu1wlJXSlJSQGu3q7xGRsKdYKLDJRHv3A0XoQNaNk/hrmx8JJcmEWTmxzGmJ?=
 =?us-ascii?Q?XJfHg9WREkEJXnrZ/dwK7onhmC0XVHMrg79ZYQHdYV73AZYlB+do70O6NZA/?=
 =?us-ascii?Q?gFXFpEQbjOuXD11yOfWiCRI/UvR5BmK+F/EG0bZcsnW7Bufw6dp5bAX2VXgs?=
 =?us-ascii?Q?gb2nYLithGmb1ihuINS+oVj1SiXLctkfaw/fLKugCV/rs5T8J8UO3uZDmvYW?=
 =?us-ascii?Q?NsGqKlmID22xrGDoBBPxzURJEH2oTmzTJQYBas5aXoP9yvzOFg18pWEJDHz5?=
 =?us-ascii?Q?lixLbv1KNXqgunEt6Af+l1Isxg+aXmK4rXzALUnYxW1R7byylwRs4tUHWLJC?=
 =?us-ascii?Q?OxHFwvwQm2aBuN0ebUDjVW7ic4x+tMckZwvqgucLMnVa7GL0vhUsus+PI48X?=
 =?us-ascii?Q?+5xdD7uKZldEjf7iuaX12xNLyfMrg+zQcUzdyKME+5LMUgF0BaUK5K0ZcxCL?=
 =?us-ascii?Q?Lcg3W3dktMe0sDvttXD/NoLVAtnrkXof57EHaziGld5UO6VwiYzC38At9pj6?=
 =?us-ascii?Q?Obo1YQ7HwZSMAMzcepg9uhAja26y/bgjfRGMdvCtrBdw3aOJf+2KdThV0ugu?=
 =?us-ascii?Q?ujVIRtz7R93BXU6nmYH2H3JrL6hvoF214CWvh45B155ZR9dDeVVj+6nU8O/Q?=
 =?us-ascii?Q?ZU8EtJwjoJstSKcCXDPP33LxfJVgaeUB1h4am2v1fwPTYUhir57vW6v6bj2A?=
 =?us-ascii?Q?KrVCOkQ/RBgiRthpuZnW5mi5kX4qWRVzXCtIYWu4hata2BA8aZmHB9ZXwzQf?=
 =?us-ascii?Q?zo8vLzPIrL6Y9vHZlv0U/v/1BkF0v/sTclXLJiimiSMMEOUP8ONyWqvBDtUQ?=
 =?us-ascii?Q?M1EL7h+0wCNabBKc1QpaoqE/UNpKpIieb2s1EOgAd7v4sPD6vcDXCp7Yf4dG?=
 =?us-ascii?Q?5PPgdm+xLnExrdKv0KGMFU/dI/E1KDyBz4XqxGwRnL61HV2oSaOsiqLGHOoJ?=
 =?us-ascii?Q?TluASWR0RhNfR5bF+nFfRCJR3Td7G3HCAf1opQQCH7567mE3cnxmG8iboU+j?=
 =?us-ascii?Q?Tw6BUnBWpOMJmDHcL6/hnBe0of4MUDTQb2BRjop5RpAqLRxJ9YKx0I4TgK4P?=
 =?us-ascii?Q?GFY3CsZox8No9PifYUL2mdUU54QG8rQr3uayTcdYQPJDs4J3Im+2K0r1GcCa?=
 =?us-ascii?Q?FYXh2BtyTfmQOEDhc2lxT7X4mxb03BYwTL7a?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2025 19:40:28.7510 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aed15168-0a7f-45d3-b0e6-08dda39fa914
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8659
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

From: Muhammad Ahmed <Muhammad.Ahmed@amd.com>

[WHY]
On some 8k display models flickering or black screens may occur at reduced
PHY SSC.

[HOW]
Add an option to set a workaround bit for these displays to keep the old
SSC value.

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Muhammad Ahmed <Muhammad.Ahmed@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/bios/command_table2.c | 1 +
 drivers/gpu/drm/amd/display/dc/dc.h                  | 1 +
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h      | 3 ++-
 3 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/bios/command_table2.c b/drivers/gpu/drm/amd/display/dc/bios/command_table2.c
index 2c645dffec18..f2b1720a6a66 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/command_table2.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/command_table2.c
@@ -396,6 +396,7 @@ static enum bp_result transmitter_control_v1_7(
 				process_phy_transition_init_params.display_port_link_rate   = link->cur_link_settings.link_rate;
 				process_phy_transition_init_params.transition_bitmask       = link->phy_transition_bitmask;
 			}
+			dig_v1_7.skip_phy_ssc_reduction = link->wa_flags.skip_phy_ssc_reduction;
 		}
 
 		// Handle PRE_OFF_TO_ON: Process ACPI PHY Transition Interlock
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 33209e056a0b..d57c57cabd4d 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -1609,6 +1609,7 @@ struct dc_scratch_space {
 		bool blank_stream_on_ocs_change;
 		bool read_dpcd204h_on_irq_hpd;
 		bool force_dp_ffe_preset;
+		bool skip_phy_ssc_reduction;
 	} wa_flags;
 	union dc_dp_ffe_preset forced_dp_ffe_preset;
 	struct link_mst_stream_allocation_table mst_stream_alloc_table;
diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index 4cdc75adadb2..75e08efc582d 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -2494,7 +2494,8 @@ struct dmub_dig_transmitter_control_data_v1_7 {
 	uint8_t connobj_id; /**< Connector Object Id defined in ObjectId.h */
 	uint8_t HPO_instance; /**< HPO instance (0: inst0, 1: inst1) */
 	uint8_t reserved1; /**< For future use */
-	uint8_t reserved2[3]; /**< For future use */
+	uint8_t skip_phy_ssc_reduction;
+	uint8_t reserved2[2]; /**< For future use */
 	uint32_t reserved3[11]; /**< For future use */
 };
 
-- 
2.43.0

