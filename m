Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96597C982C9
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Sep 2026 17:52:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DECC810EC9D;
	Wed, 16 Sep 2026 17:52:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3hesKjwo";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012051.outbound.protection.outlook.com [52.101.53.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4CD5C10ECAD
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Sep 2026 17:52:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f8+pY3OQPVqFWoIO6q8oGYSLXl7LVXpbt3CogcFR18I7Y/2RQgZhLJnkf4BG3rh11DZUIIj9CB1ocsOcfsTTT5lRVc0t6kPqZyQRfhPygiVSbHoiiWZaaQeAa8DqFhkr9NlzURXvvG6R8hubzA7tEXaPiQnj5cmzluTBI5eKs+a3IBfjPH73icVzPVWYFQqvWbOWgSvXcHWk+rvkWp2LYu/tOM0YY4fYN4fslwyCMa5YffRQFk3XzZeFjYy/m+Bgc6GB1PeggKdZatUSO/KHeRMhev3T7xDO785L5eSKgqY3jwbpksxNBuaAMd/7A7LLNYKmjhnUQLJ11AXOp92llw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n2aCmGuhcd7nmyPahhPGKlcZPn6BpK/ejg3SGA9lKf8=;
 b=sM4y0YSgUlF0f5jkN5kM1WvrI1SKygI8XKxAPM44dAvPCIT/HPLOm94f5RF9eq17cjXcNBMkuG0e2bInG+OtvwXWbHinm9UMfjESt5geL9v+dQ1dn7RRoFTpAQxmj2wMP0d8wpTfByNASEIwD6AZ8P/zPTnj49oaUARVP2OGKJV++Mmygo+frauAel069HokI4wAOeu1JSCtA8tqOoQO/+0BIDRq38Lv2UAlT4MR9vkGrnab/7XjJU0NKf+uvEIeMMQp5cnjU9iytF8TnQuBdoJCV1ROGozi5YBLot9aigRRG0LlvJzvXCGR4/qVn7uV01+6b1YoTaE3BzW05rBKZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n2aCmGuhcd7nmyPahhPGKlcZPn6BpK/ejg3SGA9lKf8=;
 b=3hesKjwoK7NlHmCVBjkuRhJkBe03/eNXWtqDc1oFuBYXTumBS8RhUjPswXCBgSWDfeys/gGt58Ng3oNGY1mBg4xL4JvtkErAXiNZkDZWR/B/Pw/1umjx469IKVKBUlJFmgEzleaXP9TQzgRD9lBiFO0M+2tRxVXAEepIMpg8e5c=
Received: from CH2PR10CA0023.namprd10.prod.outlook.com (2603:10b6:610:4c::33)
 by SA0PR12MB4416.namprd12.prod.outlook.com (2603:10b6:806:99::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Wed, 16 Sep
 2026 17:52:45 +0000
Received: from CH3PEPF0000000A.namprd04.prod.outlook.com
 (2603:10b6:610:4c:cafe::1c) by CH2PR10CA0023.outlook.office365.com
 (2603:10b6:610:4c::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.11 via Frontend Transport; Wed,
 16 Sep 2026 17:52:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF0000000A.mail.protection.outlook.com (10.167.244.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Wed, 16 Sep 2026 17:52:44 +0000
Received: from georzhanmkm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 16 Sep
 2026 12:52:33 -0500
From: George Zhang <george.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Alvin Lee <Alvin.Lee2@amd.com>, Wenjing Liu
 <wenjing.liu@amd.com>, George Zhang <george.zhang@amd.com>
Subject: [PATCH 26/64] drm/amd/display: Wait response should be based on
 fw_based_mclk_switch
Date: Wed, 16 Sep 2026 13:51:41 -0400
Message-ID: <20260916175301.368306-27-george.zhang@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260916175301.368306-1-george.zhang@amd.com>
References: <20260916175301.368306-1-george.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000A:EE_|SA0PR12MB4416:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f2ee427-4b8b-4f6e-6ea7-08df141b5005
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700016|82310400026|23010399003|11063799006|56012099006|18002099003|22082099003|10067099003;
X-Microsoft-Antispam-Message-Info: eBD9J+tjZBT7iMJqP1RScrwrVpxzVHAAw4MMKBIPFBmnJbbxkGazmtOBg33V0r1+t9QLiRQ9aMu1axZuUEfWXA8jKkcyN1K6CzGHx5CB7mAuZfyOU9X7oNqnmpO8gjdzg/HxOaXKt0/6P/JUYO4Kkfqihlk7eZixjxkIrGd0k/1vfJXAKdqwmy0w5qW6LfsHHuTvHQBznuieAmP5FdKpWgTotgICEJxHd2sPxlaS7Q2XXxa7jOslEN8Tssu9wBLp/JZ5WVef74F7XeFuvVAcMFm56WR2lldNLqx/LA1NSPIxS/GHOkejFD4i5WBBltgXQ6RNqtjaQa9SOtsrueh8tn7YgrEOtKgapJ4JkreFlPJNI2VWq4tDWajbLLYScNYNucDUV78f2x8tONErEhHWVa4Uu0pSMIDsyqpYRxyK4PuIHu8My7Ss44HO4gaO13jfqIttvg6l+UTWuurQUj8+e7evVMQQwie2pkqMj4g+HkzlKnP+/inQjhMfvER3Kst2TyA3ywVlIIGF0yIoR6Qww6O+XYBWHzScs8Sva7iN4AQCKaprEyiGShYUFJVXFjFhM+0A2w8TmYpeZebhx2u7TVa1BSWIXd0YPRqFY6QWyDtOxTJjXf4tcSRsmpOYtYzETr//X66AzADzJsnu1H7jzQDvdAHGWW4GmXZkVtRILFY57Yb3f9TSkVPyS8NzVjnjy15qFMmjPxnBG8mcluFKWA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700016)(82310400026)(23010399003)(11063799006)(56012099006)(18002099003)(22082099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: EQH5f1dhKJhGoEb6df5ttVyBuDI0dAAQ0O29Z8hXDmhC+NGDeF6TRQ5K9Iepmzge4B8ksjqu/+0B/escpBaRyM6WICzURCTwjD+59bUQWO9TDUsYmmmOsg336s5s62bx+ijUvWF9tgo/1MS5JM1m5eJtCrN162X4oSqtzJ7rtzdCrhtuUFNO+06SFOZTLOKGhkRHbjtu+7vKZuvMR9xolBKg7z1emWO7A2dZbV5IXMRNAjau0kWVQxMC5iryhcj861S4DafWn/ljj0BsIYfQhllSCfbMKIAAVChNgEVG6w+jMTAb8QxQdm53CzvAHav4msSc4z11zBDuvqtRkkuc845oHrVfHSCwc99PhazqmynsfckNabvaupYk8Vz5M94k3UA8iq9x8dpEDxZJ7JszexrvpZ+EouCryZYoBQktaNN+0JBLP2cMbCEMyG4uYxF5
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 17:52:44.8553 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f2ee427-4b8b-4f6e-6ea7-08df141b5005
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4416
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

From: Alvin Lee <Alvin.Lee2@amd.com>

[Description]
When sending the indicate P-Stat message to PMFW, the wait_resp flag
should be set based on fw_based_mclk_switching in order to maintain
the logic from previous product.

Reviewed-by: Wenjing Liu <wenjing.liu@amd.com>
Signed-off-by: Alvin Lee <Alvin.Lee2@amd.com>
Signed-off-by: George Zhang <george.zhang@amd.com>
---
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn60/dcn60_clk_mgr.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn60/dcn60_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn60/dcn60_clk_mgr.c
index 47b112f84330..d6db6168c3da 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn60/dcn60_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn60/dcn60_clk_mgr.c
@@ -1297,7 +1297,8 @@ static unsigned int dcn60_build_bandwidth_clocks_block_sequence_with_action(
 				action->fams.enable
 				|| clk_mgr_base->clks.fw_based_mclk_switching;
 		block_sequence[num_steps].params.indicate_pstate_status_params.wait_resp =
-				action->fams.enable;
+				action->fams.enable
+				|| clk_mgr_base->clks.fw_based_mclk_switching;
 		block_sequence[num_steps].params.indicate_pstate_status_params.alt_ch_enable =
 				action->alt_ch.enable
 				|| clk_mgr_base->clks.alt_ch_pstate_switch;
-- 
2.55.0

