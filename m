Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7087CF9C7B
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Nov 2025 18:18:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E1F310E7AF;
	Thu, 20 Nov 2025 18:18:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JWZ5Na3U";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010043.outbound.protection.outlook.com
 [52.101.193.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C3B8110E7AF
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Nov 2025 18:18:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iLx3OueHh6bT7kR21PBo61ecVL0gqBcE9/19iO56VcbsXxTLGBwFlyOz1vLJOVg8vXPC3eHzcy/7Xz+90sirfIt5654YRtQJ3SrajWdBhZ32q/14Y8O6mzj+KJ1y2LugPsSfLTEcBKO04oSwqTEOUsu3KbYtQtxfsllmkw80lviAZg6mw1tVwT4lFgXfKRTFAks5p343Zv/sJyk+nFxmeR3TdzsYp65AWXtSJoTCCWuLzcn3qUSpw/zALGFteqtsujAtP2Nykxg/x9reBF8biBOAcX2WyRuK7Cb6KVwdOfK1MOe4fwUIFgXcVMZHVAnwGluv+VlmEoUFGOFI03zUfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s1/3jVeysTA1Yct5NB+Ut/ZWtmXMSlA0QR/6T56dyCc=;
 b=iI7zsdzKkDkAV6EPVs19omeAtDs9gwBggdsD28l2kfcCugGrZaPVH/x1IgDBb5/tXOLSJqAAmPt87RAaQeu9iW6Y8UV1q4avu1ewUmlPszxsmRynuroc0lOhC2gWzKt+eGMSwLck87B8QnK7Bd1i9TFSyfQAXl/LAPCEuLn73plUJGRlhqutQ03+fyPQi7Bt/MnqlbLfSHnWvj/e2OcKQ+uPbvhAwl0fGpeBezky4HictaxdclPLf0xj/KLrRPJU/01DyYEXu3MMEgw0c9uhDJQS8tW4PmYjBCx96U1TKnkNZOUNZf+HclfVeH+WLsNGsJvd+I0HWto90Z2LTdQ1VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s1/3jVeysTA1Yct5NB+Ut/ZWtmXMSlA0QR/6T56dyCc=;
 b=JWZ5Na3UGK/JVv2uSZ6ZNSw89Y85+IYVKxiayf+zPrwF3HSibJK/LIHcbplwiVATJqjIaT8W4ZxQOgOwj0mWwuEzalLSkoeXCJv8UdzHOHw5jg2Dq+m8nkbHWmXHNRn6c30jkfoi0nfu8esCNh/NRAM3S16wBMsks/TFsAfkChU=
Received: from DM6PR08CA0055.namprd08.prod.outlook.com (2603:10b6:5:1e0::29)
 by IA1PR12MB6459.namprd12.prod.outlook.com (2603:10b6:208:3a9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Thu, 20 Nov
 2025 18:18:28 +0000
Received: from DS3PEPF000099DE.namprd04.prod.outlook.com
 (2603:10b6:5:1e0:cafe::25) by DM6PR08CA0055.outlook.office365.com
 (2603:10b6:5:1e0::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.11 via Frontend Transport; Thu,
 20 Nov 2025 18:18:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF000099DE.mail.protection.outlook.com (10.167.17.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Thu, 20 Nov 2025 18:18:27 +0000
Received: from kylin.lan (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 20 Nov
 2025 10:18:18 -0800
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Jack Chang <jack.chang@amd.com>, Robin Chen
 <robin.chen@amd.com>, Leon Huang <Leon.Huang1@amd.com>
Subject: [PATCH 06/26] drm/amd/display: Fix sending redundant enable command
 to dmub
Date: Thu, 20 Nov 2025 11:03:02 -0700
Message-ID: <20251120181527.317107-7-alex.hung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251120181527.317107-1-alex.hung@amd.com>
References: <20251120181527.317107-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DE:EE_|IA1PR12MB6459:EE_
X-MS-Office365-Filtering-Correlation-Id: f1db1c5e-d80c-40c5-6bf2-08de28613376
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?8HPTQBuN0LScPBirLR73os8qpnfwAIFfFopVr0RCDj1SZXZDsNUtnCEW9WuL?=
 =?us-ascii?Q?sGqU0PusWwxg4kyb+f6BmdW/MofRFwlDm9Iz6SJIbcUcxgMHYSRShwJdIzLM?=
 =?us-ascii?Q?/PyDpSlnSzh/XxqMQY3YXG7cCl3Q3hMnmZueYA5FeQxI+vpM9neEun5KdmIi?=
 =?us-ascii?Q?YhBMaV+HPrhSzli1BwY2xtJFDF3lq4GijOroX0ZxCa5n+ESbXj7v71Hezqkq?=
 =?us-ascii?Q?/4NAMJ1EHYILpMwx9GicBrCGFs7sm9ZpF+eZ+IeKwd7OiOFxMLQZAyaWy42w?=
 =?us-ascii?Q?nLu2tc4u4LgVKIc0ouyszklsyXO9X0SixPRXUq9ubJN9CZjzhbzBthmA6E8h?=
 =?us-ascii?Q?Wh13JwIw2j0o6WwOgkY2Z4LiI80VGy9dDJTRQMWCAhI6ziOCcuZuGfwbfZWp?=
 =?us-ascii?Q?DLVg2PSPF5jopwWvqpotQEDFZ/53GgWlPN05ER2F8kwOBMgb0gPj95pUWaHw?=
 =?us-ascii?Q?CDVtGQiMjC2eawHGE4vHITFK7nYobaW/cCm1+6B4jtkDA69a0AWwtBJxDqJE?=
 =?us-ascii?Q?KwDdRIjF0OWiez9tcgCxZzPk4tEywfPDLCt/KegoOqXqFQ/oAhA6Jb4mBd8+?=
 =?us-ascii?Q?U7j+nyqWrcM876sNDGaHgZeZaLRZZllsmrIf9A/PITEDAM+Ut2ihR3t7oIzA?=
 =?us-ascii?Q?MLJiMQ02FETHWKju+rWE9jVKQqN5ORvkpsmePMD6VVIlEwIR01COdZyBJSxq?=
 =?us-ascii?Q?yXTOPw+yIy2pb5hFalVYPI39cuPTnqhll0C7PYZHF2JHxudpOo5aE2vqNf22?=
 =?us-ascii?Q?WRdgsNYfGUz+NdwSR8tZCDJKPQxS9A+w2adprE9X2qTanEAMtzBd3zlEBXUa?=
 =?us-ascii?Q?0A/9kmvCbiQjsmCCFgGxZtXH3moVWVa6ZzaeLfD2Ps/nvKCfNUKvoTH+Ps9w?=
 =?us-ascii?Q?naILKThUEM3j23Tk/M190bvCl6K5o5epaGGOtWa+RSaBjbaF4kKf/bbJZDeV?=
 =?us-ascii?Q?BhuQ5sVdjvXFZoDCbpjJ4TKJbWUwwJpcoSzoXTtTUgnVzUQQoGmWpOAx3CHo?=
 =?us-ascii?Q?2aetoggSup1I9V2gB8LHVM8VEAsOKXfpQbgD2RMqum+tn6sDaB9VZbuKxZ38?=
 =?us-ascii?Q?XnVzOjaEPpGS3skmACnzO2CQLm85m/+FuPR0V/bdcb6A787QX9s2fYqtAz9A?=
 =?us-ascii?Q?v0ASq4VycnUTfphxRWJFU6zoQxFHpoEdJB9XlqMXoMmbgXnwYe4wxUZfaIut?=
 =?us-ascii?Q?S9HnsfJJGTXE2or4otc54q9qGQMDjuoi4y7kZ7To48H1toe0NGfruqT8PeoB?=
 =?us-ascii?Q?eUUOSbcMbZXHl1VacXsKq6D0BkKKFyFsV7YX1zqXbRFsT8fz005iVo10DTiM?=
 =?us-ascii?Q?KZ3+Aj8ZLMK6cJhtcW+i9JKpWBMwm+ospNQBTK818wEhzEjPE/HLJXOvXgWd?=
 =?us-ascii?Q?dx3oklfMMMBjk94dgZWNFV/Qvz89Z+EPXxPXoWGF7kJFgSwMeFbd7dCDJ9sc?=
 =?us-ascii?Q?MUywsRhsduR119131Cvz1WB2Oxip26oje3z4aIJfaSKp8+Q9+ePWFFy1JZz9?=
 =?us-ascii?Q?XyHDxUJQLlilJIsnSrmxnpTzEhDcJtyENhZ8J8cGerd2H7KUM69wLAUHGr16?=
 =?us-ascii?Q?hBFjz7hTH89OqjUNUBs=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 18:18:27.2969 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f1db1c5e-d80c-40c5-6bf2-08de28613376
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6459
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

From: Jack Chang <jack.chang@amd.com>

[WHY & HOW]
Fix sending repeating PR enable/disable command to dmub
which causing performance problem

Reviewed-by: Robin Chen <robin.chen@amd.com>
Signed-off-by: Jack Chang <jack.chang@amd.com>
Signed-off-by: Leon Huang <Leon.Huang1@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 .../link/protocols/link_edp_panel_control.c   | 20 +++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
index 07f4f15851fc..99741c1334ca 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
@@ -1313,16 +1313,20 @@ bool edp_pr_enable(struct dc_link *link, bool enable)
 	if (!dc_get_edp_link_panel_inst(dc, link, &panel_inst))
 		return false;
 
-	//for sending PR enable commands to DMUB
-	memset(&cmd, 0, sizeof(cmd));
+	if (link->replay_settings.replay_allow_active != enable) {
+		//for sending PR enable commands to DMUB
+		memset(&cmd, 0, sizeof(cmd));
 
-	cmd.pr_enable.header.type = DMUB_CMD__PR;
-	cmd.pr_enable.header.sub_type = DMUB_CMD__PR_ENABLE;
-	cmd.pr_enable.header.payload_bytes = sizeof(struct dmub_cmd_pr_enable_data);
-	cmd.pr_enable.data.panel_inst = panel_inst;
-	cmd.pr_enable.data.enable = enable ? 1 : 0;
+		cmd.pr_enable.header.type = DMUB_CMD__PR;
+		cmd.pr_enable.header.sub_type = DMUB_CMD__PR_ENABLE;
+		cmd.pr_enable.header.payload_bytes = sizeof(struct dmub_cmd_pr_enable_data);
+		cmd.pr_enable.data.panel_inst = panel_inst;
+		cmd.pr_enable.data.enable = enable ? 1 : 0;
 
-	dc_wake_and_execute_dmub_cmd(dc->ctx, &cmd, DM_DMUB_WAIT_TYPE_WAIT);
+		dc_wake_and_execute_dmub_cmd(dc->ctx, &cmd, DM_DMUB_WAIT_TYPE_WAIT);
+
+		link->replay_settings.replay_allow_active = enable;
+	}
 	return true;
 }
 
-- 
2.43.0

