Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0E22C4345F
	for <amd-gfx@archiver.kernel.org>; Wed,  1 May 2024 07:19:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4FBC71130C1;
	Wed,  1 May 2024 07:19:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XKpNB17O";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2051.outbound.protection.outlook.com [40.107.95.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B7181130C1
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 May 2024 07:19:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dqDT4LO/6HiH1X3pGI5D/AFwu6rbNrZF9T4XCwb5n3p+NjDFSr3pzxxcOILfDP0UJ1eCPQdxae+0TAc45xDWHX/KOmJpsyBt/oa7Hapqs32WzeJhedko8ll+f9QX+H/9YXWSzG/QZHShIt/Ea6EH40HwRxL71AIjcH50DaHHr1816NmBoVe7/BDZVcUADlCkAa5qpIFO9lXN/SNaHyjpCyHUODg9Obzn4GNvdsOyEDMK8/vg/sParZXY7Yzn3tmuEAS1Lnakm/VDyol40a1KDoFovkHMJ75D6HS2mInvYwLPHqI5jFCWuDQV8+9eJZbk1zkVZUH5XijP3vu2UY/h9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KtTg+kJe+w5OyOvmBA+AjoN0LQgGQuH2+6TOusU0nj8=;
 b=kbVId0Wg5U/fG7lRrsV+tdDrpYmjZ0DYlPEz9p0qoR5+5uSB6C+VWi8T8UQCowXX6EgvTirfl6U2mEwTkb9DBOAS8UEGJHLpoxjxx/tAxvy7TP/MUj5fjYAxWpX4lO7o8Sa+XXDTHwZhikPZjkJwdumWBWBpL6kRv2OF6sy+wdl/1OZdh6hGUhS2LGzSR18aqIEZH7bJP1t9tqBt75bfhOhz/gtVgPiTncc01lvWSe8oNqmzZnY1RCrxm5d48IlSmjgvAG8Y5qSn+M9QTII0RukRWwBYUBbLR+0X4eSTPF9JuVBVcUIGISUizL/AznZJlp0yX6ehICOg+r3iqmWfPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KtTg+kJe+w5OyOvmBA+AjoN0LQgGQuH2+6TOusU0nj8=;
 b=XKpNB17OJFWivQJGq6PFvK/Ep+ZA7nQAH0bPFYdDd2cQ/Nhk/N1CCDHW/QK2Wtt521adn5ff4kBMivW5/5M4ouRQQSvWwXhI4STrkI7rZam2izjz3h06hwOR1aoNbb5hNMHvyYB66kTqNCu3ok4Q8LZG1HVmi0UIv3mC3/3OkkQ=
Received: from SN6PR05CA0028.namprd05.prod.outlook.com (2603:10b6:805:de::41)
 by CYXPR12MB9387.namprd12.prod.outlook.com (2603:10b6:930:e6::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Wed, 1 May
 2024 07:19:09 +0000
Received: from SA2PEPF000015CB.namprd03.prod.outlook.com
 (2603:10b6:805:de:cafe::4b) by SN6PR05CA0028.outlook.office365.com
 (2603:10b6:805:de::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.27 via Frontend
 Transport; Wed, 1 May 2024 07:19:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SA2PEPF000015CB.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Wed, 1 May 2024 07:19:08 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 1 May
 2024 02:19:07 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 1 May
 2024 02:19:07 -0500
Received: from tom-r5.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 1 May 2024 02:18:59 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Alex Hung <alex.hung@amd.com>,
 Harry Wentland <harry.wentland@amd.com>
Subject: [PATCH 22/45] drm/amd/display: Check num_valid_sets before accessing
 reader_wm_sets[]
Date: Wed, 1 May 2024 15:16:28 +0800
Message-ID: <20240501071651.3541919-23-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240501071651.3541919-1-chiahsuan.chung@amd.com>
References: <20240501071651.3541919-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CB:EE_|CYXPR12MB9387:EE_
X-MS-Office365-Filtering-Correlation-Id: 44b98c1a-0f73-4965-471d-08dc69aefdf2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|376005|36860700004|82310400014|1800799015; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?USFkY3/2g96eZxM4nIs2oDpGvxYrZWNfKCasjH+FQ63EnRknb6hSNenQtslH?=
 =?us-ascii?Q?MiyIUIa0N6xHekI11vadSUKUPbV7zSX8lw+gMDDUaX5LuYhrbwV6yMyDQ4c3?=
 =?us-ascii?Q?y51S7s854YFh6a2W4SyIq6Uc12rmQsSFFiN5GtSofUXAM8XAKU+9UIFXeMgT?=
 =?us-ascii?Q?qRr15WsCb1bFGlXia5zsOUgSisvSH9aprMYXk+odFLv+xAV0azTs4mN4SfNh?=
 =?us-ascii?Q?ry+syAXcwdMJExlsO6vSe1ETD2ZhSYewIxzkFsio2YpA8X/ap+Edc+wdQbGQ?=
 =?us-ascii?Q?/XdV0KLwKMBiLJGQj40qgk3z38CHerML1wQDRo+qw1Jrs5RJIUni5cMRIT0l?=
 =?us-ascii?Q?khNQTjiluqlwMCEOI0ewoszTMC3PTx5DGL08ff5pdrbMzR/jdA/G93AWQdNv?=
 =?us-ascii?Q?tAVbnpxvNSKaQ6Eq8Y3b9UlCI8H0FvJ9xYq6l14GgXMXVFZ8eRZ641Ixuz8W?=
 =?us-ascii?Q?i7GyRbwJBP6TkUaeHqo8c9Tz3kLH3MRtJmhVB4BPfBGJFIjZePWxlc3kscK+?=
 =?us-ascii?Q?N9GDe/AgCyOwKjd6NX5ftOxAhMqhovzFaRCRabdUMUmWGUAT1Z8WkvvVUv6x?=
 =?us-ascii?Q?k+rE2lw1lCBH3vc9AvuQUBMq4Issu6NR6W3HShsxWXYh2j8qrclUFFO+lvkf?=
 =?us-ascii?Q?87A9rH0IC2C+/3hHqjPHehRiehZBl3KkBkrTK8evx9ZPloLgxQ5qgRnfmjCU?=
 =?us-ascii?Q?cnFdKdB/qENIVDrATfmtP4dOHHy2XjJcjf6Kmzyn3ilcH4pyOE81tZizMg6K?=
 =?us-ascii?Q?72AmeLm16stWZf7XGak3zwEt8L9WiTdtgN5ZkEhy+5vWbYLSNYpEQBs5Kp1C?=
 =?us-ascii?Q?KKzfdb+XhNiH0B7s8vfIzZjcpjiooTJ27qaiaijp4wXZmfneyac1ElGL0GuU?=
 =?us-ascii?Q?nGwU4d9T1XC2m/1mpX4g8XNs1bTF6D80oD/iOKd28W4GbLCEp2Nbj/YDZliR?=
 =?us-ascii?Q?R1YMmww2TEhjZ79CY4pZQqAC9sqWw4Zq0bP5FEg2TdBil2GKXmRxzlZIIXJH?=
 =?us-ascii?Q?dYRLG6MOKqAd/ElUAP54GRfUqWrOaGfZ+KLYol6UBapEyLK43FKybjd6IWWG?=
 =?us-ascii?Q?SaiGxmj0AA9cVFQV9Jv3f60ldjIjXXZvawsFst+ouvJBhnVKjRCmv31s+q4Q?=
 =?us-ascii?Q?pFmKOrjLbcjgtfMVahP7Lnzg6XinUCgE9045ac++LfJ/yzGbbVPMh0v/nILM?=
 =?us-ascii?Q?oA83+TRfAHVA/6W5P2GnRkNBXJrqb4sPX7P9rhGhUmj/TLH0yePzyTynHRL2?=
 =?us-ascii?Q?zNTQ4j6ZU+6qJxqPCSLp3PVAeRPQHJXqCtfVUBcdrajxrO28yMs/OUR/pw9W?=
 =?us-ascii?Q?mrpHCb/v3Ya5jyFzoYmRxPr2KaBZZv7G/UTNqCqp8rcwPnXTXWjNY7vmnt3X?=
 =?us-ascii?Q?uF0QIgMLkPvF787wRvr601pTeNHR?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(36860700004)(82310400014)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2024 07:19:08.4882 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 44b98c1a-0f73-4965-471d-08dc69aefdf2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015CB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9387
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

From: Alex Hung <alex.hung@amd.com>

[WHY & HOW]
num_valid_sets needs to be checked to avoid a negative index when
accessing reader_wm_sets[num_valid_sets - 1].

This fixes an OVERRUN issue reported by Coverity.

Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
index 5ef0879f6ad9..aea4bb46856e 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
@@ -484,7 +484,8 @@ static void build_watermark_ranges(struct clk_bw_params *bw_params, struct pp_sm
 			ranges->reader_wm_sets[num_valid_sets].max_fill_clk_mhz = PP_SMU_WM_SET_RANGE_CLK_UNCONSTRAINED_MAX;
 
 			/* Modify previous watermark range to cover up to max */
-			ranges->reader_wm_sets[num_valid_sets - 1].max_fill_clk_mhz = PP_SMU_WM_SET_RANGE_CLK_UNCONSTRAINED_MAX;
+			if (num_valid_sets > 0)
+				ranges->reader_wm_sets[num_valid_sets - 1].max_fill_clk_mhz = PP_SMU_WM_SET_RANGE_CLK_UNCONSTRAINED_MAX;
 		}
 		num_valid_sets++;
 	}
-- 
2.34.1

