Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EA56C44508
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jul 2026 13:46:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D199810F077;
	Wed, 15 Jul 2026 13:46:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="osdxH5NK";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012061.outbound.protection.outlook.com [52.101.48.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 52B6A10F07B
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jul 2026 13:46:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mdAIShFCW2dEUP4Uo1+83p4mhWqp2IwNaJ66Wvo4wmIu49g68MAb87m2GHoVcSNpfWEk0f6b5qOYyqjXgslN0cJnYw+5++LAIRLEYScmDmFTIrNrecvJjZ6TTNu8gK/nD4c9FCbWRqciVFGRIYZEbMM4HZi86rhjz3GO6b7yrKBisbWkI3Po9p257RHZ2DPdlIh1Pwz7HOcZ97yWgKx19tgk6VtkIEh1dyc4602gizYP2MYGFymszAM37X4ZI1On16+LNy8pNKPFX5j2WWl6EsPcEuxy9AZIXdBRipJ8Yws3JUJ1Zzk95XbdfafrZ5JYHXhS37KdNqbTJp7yGoAjiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aARhKX/hLrmQF6JUM5eePVlktnq+y3UTMZ1AjSw9g2o=;
 b=So59rxulNVJsvE87aM2rAaAnuWucRswfkMBbW9aGJIXpxTGQe3e1Hz1PRg0UnI40GBakAI1i2Z4XMyerZm8R//lUL9djWAW14mVtAU3mof4UX/df7palCaxNUNmvw1XmqA/0p3OpenxqtwEpiazfGxhJCbnWtaTlrWPV21xII/Xrmc7woHvLpltcesiapK6JjpNccPAAQerenwt1smQuCH3PFc3qOj2/g4KmGRTqKFDJwaJalLKypDMYTjWJIu+Wqw+eAuOOK5rhuiTzM58+srDtrsxVdvz3/6HmIAKzYEDNsE2mFRzq3NRcuYF0a2Yg5oYzPp66R+AEDjStm5fa0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aARhKX/hLrmQF6JUM5eePVlktnq+y3UTMZ1AjSw9g2o=;
 b=osdxH5NKNAHfaQ5k41fTWQ/kZxm/8scocora6p17HBRg27D04aHOZgPzQlVka/iFH4du5Lx/ZkA1HsdX7U4fxWgNnC4BKHn/lV4iZmuR63mlvytMluI/XckKyuv+tRec5ZDA2DqPaGJYKBfdsuT+vhqVcIoFbN09eIVc2aRR6OY=
Received: from SJ0PR13CA0111.namprd13.prod.outlook.com (2603:10b6:a03:2c5::26)
 by DSSPR12MB999235.namprd12.prod.outlook.com (2603:10b6:8:377::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.11; Wed, 15 Jul
 2026 13:46:00 +0000
Received: from SJ5PEPF000001F2.namprd05.prod.outlook.com
 (2603:10b6:a03:2c5:cafe::68) by SJ0PR13CA0111.outlook.office365.com
 (2603:10b6:a03:2c5::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.10 via Frontend Transport; Wed,
 15 Jul 2026 13:45:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001F2.mail.protection.outlook.com (10.167.242.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Wed, 15 Jul 2026 13:45:59 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 15 Jul
 2026 08:45:42 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 15 Jul 2026 08:45:39 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Ilya Bakoulin <Ilya.Bakoulin@amd.com>, George Shen
 <george.shen@amd.com>
Subject: [PATCH 13/70] drm/amd/display: Fix DP LT failure logging
Date: Wed, 15 Jul 2026 21:37:23 +0800
Message-ID: <20260715134432.1975118-14-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260715134432.1975118-1-Wayne.Lin@amd.com>
References: <20260715134432.1975118-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F2:EE_|DSSPR12MB999235:EE_
X-MS-Office365-Filtering-Correlation-Id: be37a8ce-2303-46e5-f793-08dee277674f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|82310400026|36860700016|3023799007|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 9EHcdWHl0eVGXZ6rczMgM++zSvNRiSg+MIj7SjRcRfG6SJMumAVWYp8ugIPU5222zy6qu1eZnOMjWlwyCLLqRrLquih106R8LFbnsqCyZ+ZVNF3ZU8B7wxpvyzWdP43SC6Tf9WybjmilIeRE0Iftcg2A5xC8i7I2YqJzqs458Du1L4wjrDAEaI5k/baGOsEzcNc+hAA3CXjOyHRMDlm5czI0FxUf10DNRBVJi3IDQodhsdxXdTC58Y4OkydCkX52of51nhL37YASPJOwseSo6xQtRbhLr0vazVlYabRSfR8zc8/C3O2RXcqVrEusOTtuCYS/6ngnuMZR3VX8IAEg1cH6W81SosSyEDkd94ndhrOnnNCS0nHVN0YtMjRWTP/I/JXe1gPuuEpdVQn1JTSaGY9D8UwMjE2u4HiBsvciTzQMnmhP5fI/fUVpnAIEsuoEaMOu3LulyFeg954XOJPL505xe7TEcZ2ZuWtOzehtgpp2IeHx3t+5SxAvqUXwRttRUqrXJIZWlRn4BXFTg1VqzBi5vetxaq1G/bL6Bz8jQXLPTuT9jqGEfowRnqKoqwZaAYEf3umZS9XMUfA022o24ZhmSqD2r+E2L3mJC6g+Ku1+m/Fq+4OybUOV1GspSfizFxzIYn/9QhOkVhI6I5i/MZRG0ZtNWTlbJFLfwT4v9ZY/zJPa4aJhnx7rG+Ms+CoSIamFfG/+iwaz/x9hAYCRbg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(82310400026)(36860700016)(3023799007)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: HWWmNplH57yJAerT2IxMtMC0qMdhI9Kv/nPY5jrG60JlJ0SH0AvxWQdgFeM0cAWGqtCaub54w0f1ewoAO+KtoOSkn7f5GEc7v6VoFZWDE43mM0QPkoF2D326Ii0XV9BSf0gkhI02ZuZqpBArTnpIzb0uuQDEm5ZgoGnN1SOPTHP3pPQcfvoyEaqk02XTkBHlGHnttD4pqbYLGaT76X+9/diz3VqEu+cZyDgJhN6/nARZzqRbt9GlG9fGeEH6RgdTlqB4rMIiRNHWmStXYioXDb0hQjWJIX7wcZNj5XSoASbOhC6Z+0ol0mp9rRXZjsUcVCsMD4JdtjgZt5ZKf0bkyoHCOMog4ilBuDjZ1VBXWq6AXSZlKzVPOe8u+Ux5OykhmiytVygnpfb0P5rSkCwOUPof19GqEtCnx3gaImVJ3a2oKBnN4+zRbIZgZYaX5t8U
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 13:45:59.4157 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: be37a8ce-2303-46e5-f793-08dee277674f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001F2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSSPR12MB999235
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

From: Ilya Bakoulin <Ilya.Bakoulin@amd.com>

[Why/How]
The final DP LT failure meant to be logged as DC warning is skipped due
to a break statement above. Move logging up to make sure we don't miss
LT fail events.

Reviewed-by: George Shen <george.shen@amd.com>
Signed-off-by: Ilya Bakoulin <Ilya.Bakoulin@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 .../dc/link/protocols/link_dp_training.c      | 28 +++++++++----------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c
index 605bf19dc4f2..04eedec8a230 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c
@@ -1721,6 +1721,20 @@ bool perform_link_training_with_retries(
 			}
 		}
 
+		if (j == (attempts - 1)) {
+			DC_LOG_WARNING(
+				"%s: Link(%d) training attempt %u of %d failed @ rate(%d) x lane(%d) @ spread = %x : fail reason:(%d)\n",
+				__func__, link->link_index, (unsigned int)j + 1, attempts,
+				cur_link_settings.link_rate, cur_link_settings.lane_count,
+				cur_link_settings.link_spread, status);
+		} else {
+			DC_LOG_HW_LINK_TRAINING(
+				"%s: Link(%d) training attempt %u of %d failed @ rate(%d) x lane(%d) @ spread = %x : fail reason:(%d)\n",
+				__func__, link->link_index, (unsigned int)j + 1, attempts,
+				cur_link_settings.link_rate, cur_link_settings.lane_count,
+				cur_link_settings.link_spread, status);
+		}
+
 		fail_count++;
 		dp_trace_lt_fail_count_update(link, fail_count, false);
 		if (link->ep_type == DISPLAY_ENDPOINT_PHY) {
@@ -1740,20 +1754,6 @@ bool perform_link_training_with_retries(
 				do_fallback = false;
 		}
 
-		if (j == (attempts - 1)) {
-			DC_LOG_WARNING(
-				"%s: Link(%d) training attempt %u of %d failed @ rate(%d) x lane(%d) @ spread = %x : fail reason:(%d)\n",
-				__func__, link->link_index, (unsigned int)j + 1, attempts,
-				cur_link_settings.link_rate, cur_link_settings.lane_count,
-				cur_link_settings.link_spread, status);
-		} else {
-			DC_LOG_HW_LINK_TRAINING(
-				"%s: Link(%d) training attempt %u of %d failed @ rate(%d) x lane(%d) @ spread = %x : fail reason:(%d)\n",
-				__func__, link->link_index, (unsigned int)j + 1, attempts,
-				cur_link_settings.link_rate, cur_link_settings.lane_count,
-				cur_link_settings.link_spread, status);
-		}
-
 		dp_disable_link_phy(link, &pipe_ctx->link_res, signal);
 
 		/* Abort link training if failure due to sink being unplugged. */
-- 
2.43.0

