Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0E1CC27C52
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Jun 2024 21:57:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 573E010EAEB;
	Thu,  6 Jun 2024 21:57:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kGr7nXB7";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2050.outbound.protection.outlook.com [40.107.237.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F7AB10EAEA
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Jun 2024 21:57:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AfDWO+76nicvLkM8463SrDLhm5UqQKEV2b5ARSP+7KrwTzlhg+jUcVCwzN3iWkJsXKHR9CDOXKA/0k8qehMbJNSMQK0IuEBYtj4Y4DYQVj60rjanCJAwMKPUpKNuxms84gXoddfB++w4yV7MWc49tqc2TgyRe52QJkAJgG8T06P66J4cKSZorUgXNXquUlz2k1TfTJJLckSC+FCbiGsTHwbN4KgoKRHLxcC/gT3pHcBVMJ8JGI1JVpgWHFgBAz+U970E9uP2IgPGnQYBY3rz9zOz3SGi3r9SH78tyPdtp+lP2QoXPw5oU6QZb3XNlB2B/FHFyZKDTSyb2cSQ/ckMBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0O3yyKGuheN+o/rjOVS2Vs124z2ay9OH1Sw/f60wZ28=;
 b=PUaWZSooWcaaiqTTUF90hJP95zOwICp484pCgJbv9THIDebFt1rmwgU8ffHW4u+cDGZEtE6RYjidBkuhzyrB6RoBH8XBC8oOKUDe6Qhnp7KR3zRLxIYR5A1eSFQUbscXgJsztEFGpLks/PMelhrTWZBW+LFwq5VPkwUkkz4zrBMFSK4eUJjj9eyLw9fyZYAYCO88v4U6iFFqsWgwl1FX+puiNaUCBMnawhr4BHkpZz81e/Fjj/Ij+wORQ8IdKZJb0t6m4mNDZMAhW++kO+tz6U4uHLamuVaca2tcPjXJcpkce5DfSVINsf7dgnmuLkzz++UFOyg+sVRB0ZS0ACXnCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0O3yyKGuheN+o/rjOVS2Vs124z2ay9OH1Sw/f60wZ28=;
 b=kGr7nXB725tqu0amp24pRTqqXjeu7R37Z20HyuTjaZtydOyGWVZAx6ZrNLEc2PiMBxFSmPgXw94giedhVApDTd4PWg1OnCnBcswu0kq+cre/7AJVOR/SD6Ro2ARSeoXHLtqGMx54A/DWDQzhtZWHFNX2HMfRkxOZm1c3jF3x1qw=
Received: from MN2PR15CA0057.namprd15.prod.outlook.com (2603:10b6:208:237::26)
 by PH7PR12MB9074.namprd12.prod.outlook.com (2603:10b6:510:2f4::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.31; Thu, 6 Jun
 2024 21:57:47 +0000
Received: from BL6PEPF0001AB55.namprd02.prod.outlook.com
 (2603:10b6:208:237:cafe::8) by MN2PR15CA0057.outlook.office365.com
 (2603:10b6:208:237::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.21 via Frontend
 Transport; Thu, 6 Jun 2024 21:57:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB55.mail.protection.outlook.com (10.167.241.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Thu, 6 Jun 2024 21:57:46 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 6 Jun
 2024 16:57:43 -0500
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, Harry Wentland <harry.wentland@amd.com>, Zaeem Mohamed
 <zaeem.mohamed@amd.com>
Subject: [PATCH 30/67] drm/amd/display: Update efficiency bandwidth for dcn351
Date: Thu, 6 Jun 2024 17:55:55 -0400
Message-ID: <20240606215632.4061204-31-zaeem.mohamed@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB55:EE_|PH7PR12MB9074:EE_
X-MS-Office365-Filtering-Correlation-Id: 7edbf05c-488a-4319-9e87-08dc8673b35a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|82310400017|376005|36860700004; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?nUYz2NYC7FbqXidBHSkVuNegspOXGYdH5HU8zLLyn89ALYoeOgnLnUqybwA/?=
 =?us-ascii?Q?p3EyhLLHOn4bgrJriwQ/+ewbhgSOOnLH6gCR8vvdD18gDrjldytIEeGLfyv9?=
 =?us-ascii?Q?DOItP8XCHizLVQfspjaFqo4x3sh+U7xe5lltEWuMp6/W/cwdp21U9Qw8Kt+2?=
 =?us-ascii?Q?BDBWyBaV73krAIjo724j8LMCYUyV4sEnWiWVHB3RYKtQoU9FD2g5idKJkaAE?=
 =?us-ascii?Q?Tk/Ylie5yIKPMVJpAJE52EYgzN4ahqKVRF73Ga9tKZH+cxAUJcIqAIjP1CnY?=
 =?us-ascii?Q?vK+TSrrXv4LYkX4cr1tDVyFeFAsHMULAO66wnYJ94LaSNTcdpxWkAfxN5gS+?=
 =?us-ascii?Q?YRTl6fKH5f8GK2igFvaFWSABoKW29ehTwVXoh99U7Y6FgjW5wczmu6PSus79?=
 =?us-ascii?Q?/luKx3gNMyg0iW1Vr0xbjN9nwc/2KLrQPf4lTCAsi2WMAGeoCQR5577wTLUr?=
 =?us-ascii?Q?K5VWG15vcSYkNc/d2Cp3vioYjcBYVCjFR2zUS8xKRoCL5eDD7bhwKIornFDo?=
 =?us-ascii?Q?MZr9aacTMd3NPhltDw7AP2YzoYurfpAsvsdwQmZR2cSp0ArwV3VLxWTOJLRs?=
 =?us-ascii?Q?1dHcWkl/v28cXr+UotN651fQfz/Rx5Z+ETOd4iXaWfMkM9sH5ZIqpOq/sTl9?=
 =?us-ascii?Q?5kIb1l0Az0N8TFCcJU3IAu82FT/uGZ5fqQc5osAFMt6aBsFxPLDSWhCjU6tZ?=
 =?us-ascii?Q?0CLAH8S4D7jrLsdmNYd6cCEJA+dk4lXUltq0Rt+o8ToePz6MArb8qRMAQebX?=
 =?us-ascii?Q?xsjOvALciJ9tn/ozwnpbT2HWqdKfPnWfklqxL4s5cRDIhvfEcyQ1uXuYe81D?=
 =?us-ascii?Q?4TQcApqkTOuWUYoaBjz5cW5ffoy8HHjFatm8GGdedRgAw2rhEScNXd+shDen?=
 =?us-ascii?Q?Tu4JZboBU5ha8/sdBhnwYUv1b9rw00Mlahs4KrYjukrPTkJCn7qxnDJ8uc4g?=
 =?us-ascii?Q?f02CSvb/bX8PLLWr+WXe6vE1p3WFYcsmRVflMQ/sEGftLItsbuRuBDV8BRfR?=
 =?us-ascii?Q?tp/SGQ/NHwe5SG2PLRD5seZq049aXTkTnGrfGHk90H6pQL5TYYUS+d4p+fbj?=
 =?us-ascii?Q?nkMUbQvOT0gBFELCJKqgXsQWrp/nHYTStzO8T0+vCQ6NhLSz5cfgQqaeGRB9?=
 =?us-ascii?Q?l2xbQ9VlplGdwhwMo4mhTOwCsDtYJK4i7/Uu0TRTEJVBz3Qg2PLs+uzkWv0M?=
 =?us-ascii?Q?/wVGNdthpAFLKmqDE/Ekw/L84pxAu66K7Dsd+9UkSx4jZNpf+cp1c0CgfzBD?=
 =?us-ascii?Q?DKmAC+TXxbs68fUOSSKLKWURpcM/wr1UZF5doQxAR6MK4Gp0LFZ9LXwaAHQU?=
 =?us-ascii?Q?0IVvdVjrguirnx30RglUyhnd4FxNohTldUgOdl+V7q+1zlGRPjoAA8LqOVjP?=
 =?us-ascii?Q?AGm/ElK7h/VV89gAK6bxWOen7OmLAxBYgqsCdqJ6ZqpHNoLmdQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(82310400017)(376005)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 21:57:46.7564 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7edbf05c-488a-4319-9e87-08dc8673b35a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB55.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9074
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

From: Fangzhi Zuo <jerry.zuo@amd.com>

Fixing 4k240 underflow on dcn351

Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Acked-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
Signed-off-by: Fangzhi Zuo <jerry.zuo@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c b/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c
index 935893456849..8b9dcee77266 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c
@@ -296,6 +296,7 @@ void dml2_init_socbb_params(struct dml2_context *dml2, const struct dc *in_dc, s
 		out->round_trip_ping_latency_dcfclk_cycles = 106;
 		out->smn_latency_us = 2;
 		out->dispclk_dppclk_vco_speed_mhz = 3600;
+		out->pct_ideal_dram_bw_after_urgent_pixel_only = 65.0;
 		break;
 
 	case dml_project_dcn401:
-- 
2.34.1

