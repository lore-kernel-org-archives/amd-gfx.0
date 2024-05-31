Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6642FC25B7E
	for <amd-gfx@archiver.kernel.org>; Fri, 31 May 2024 16:53:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3DD3F10E583;
	Fri, 31 May 2024 16:53:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jdAmUlaI";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2056.outbound.protection.outlook.com [40.107.93.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 398C010E76F
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 May 2024 16:52:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=duTvZhg+RQIL140j7HtCViGgffRhRzr1v3WRLZZLlfbCAjvLOlA8xkSkv6pX1n4+y60iGYeXvmsPqrV2bJ64A/IjmtjF7DLHMJvZaZXu0HJl52gcK/5gYn27To6IQKs8sl9RB+a/kJNKLOttff7s8xPFrgrD6/Td1+7cM75Uyv9PiERlRY+1SOfHYNKCRDY+EJznUy5z5DXF8AB+13u2GmAxO3SDzCaYDj33wIlDku4B4uwLAmQ9fF8FcvQ490ons4ulWF9490MBS5Gaq60INK/8PbTJOU/vevkauA2ujPlLj3dV691MXp8GOQZVGcSPST6K1O8K89PYjFfSwlrrvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5sJJr9rDomlgKLvmO6mHsEfUot4msyusyBjouaqUWYA=;
 b=Sm5cPy2WM9z84doR0N+LV5X3WtZQjvPn1kzSoCHe5ZmwtGen3+e7QNMM55ect4wMoQKkeEyD7RNRcwl/noqtxqsSWNCHE6U/AhHRkkMBHMmpUawNN4ZPQ5BaFOULsugoVsX9sk2Q23i3MeldLImxgaWuselFH0oOdaApZyPJSeSXTfTyQNcqudkWLOAmy3rKSGnwIvYNHlIUKFHag2l1Z04NHT++s3zu7Zsp5dX1PzqEwnvRSvxsxgH7m4WxWid98BQNQnB7cVf5kAc4cxB77tfSeJL7tekasjW+TMIyHuaZuL1aKpb7rC2MywCS5zdGSUBS+GH/0EO5nKahvDphzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5sJJr9rDomlgKLvmO6mHsEfUot4msyusyBjouaqUWYA=;
 b=jdAmUlaIuXcvKtFPSA6O5r3Ej1zjdr2SPOxLzvVf/89/oThP8F6DJ8WDNmdUh0aTy/Eq1pQUExZHveL8Zxb23b/9o95aN3HQpp2Ti0yil5HFVncwjRtg5hYaRnILiihlTuwTMElYNMt2MhFUB8pHwwCQhfN2K60VWvfBbz89vtM=
Received: from PH7PR10CA0023.namprd10.prod.outlook.com (2603:10b6:510:23d::21)
 by SJ1PR12MB6147.namprd12.prod.outlook.com (2603:10b6:a03:45a::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29; Fri, 31 May
 2024 16:52:44 +0000
Received: from CY4PEPF0000EE3D.namprd03.prod.outlook.com
 (2603:10b6:510:23d:cafe::61) by PH7PR10CA0023.outlook.office365.com
 (2603:10b6:510:23d::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.22 via Frontend
 Transport; Fri, 31 May 2024 16:52:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3D.mail.protection.outlook.com (10.167.242.15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Fri, 31 May 2024 16:52:43 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 31 May
 2024 11:52:42 -0500
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, Dillon Varone <dillon.varone@amd.com>, Alvin Lee
 <alvin.lee2@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>
Subject: [PATCH 22/32] drm/amd/display: Force max clocks unconditionally when
 p-state is unsupported
Date: Fri, 31 May 2024 12:51:35 -0400
Message-ID: <20240531165145.1874966-23-zaeem.mohamed@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240531165145.1874966-1-zaeem.mohamed@amd.com>
References: <20240531165145.1874966-1-zaeem.mohamed@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3D:EE_|SJ1PR12MB6147:EE_
X-MS-Office365-Filtering-Correlation-Id: d646e0b9-5336-4f22-88bc-08dc81921775
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|36860700004|376005|82310400017|1800799015; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Q5+uZAoSHBHVvnz+RrDpSVNJyB5G7XI2IWK6wi2j4EI0wsrDN4HX3WN8d9ti?=
 =?us-ascii?Q?8+IHiGcfkD222d5EHYnbzpAVwmdF5PmoqU+bzf2Ix+JTLuazRos7W5arr/ox?=
 =?us-ascii?Q?CdqmINOy70XqJh++NEi2ICaeg9OW5BijZ2Xz8FP51Gtjaj0OMHEChLhYkVJZ?=
 =?us-ascii?Q?Ttx4YORRAfj69hzOK5KIR+FuTIts9nXV1cmtZMl4I0PIgoUAY7Vn65SUzlHh?=
 =?us-ascii?Q?ZO09rtt8uD4/lAUJ4QG4bVJNEqLwjn1ufeaVPZJN9uSW4LP/e6tK9QkgdW5q?=
 =?us-ascii?Q?ZhQKuDZ9wEkiwcRaWadFQsk/G+59Eis4/MyQKu8s87G7ZialsTllN1Wzg82D?=
 =?us-ascii?Q?jjMWutP6/o6eP/usW8PQeLVgaCH1oAeZxX+4gPeznHgonDYePLYfCR559KA2?=
 =?us-ascii?Q?Pa9bIcdvU4tFj3PO+V3sPvpL14G8KjXS0mJpLEzX1Ct2xGw9kRj/NmCKdVcI?=
 =?us-ascii?Q?PDCUyYvAhCX5Fou+LnfokO1YyV5iPHXyl3Hp7ORrqh4VlQM1Znyc6UjNyry0?=
 =?us-ascii?Q?5eD4kSVLH/Awroa95WuDhQjyCsrWpaMuSkOwPrfc1nMLtFxJ30T0X+ciJ1V3?=
 =?us-ascii?Q?iRUDfmJB+HOa94w0E2X/ilv8aqQ3gm8AUcs/R7KY/+2mBlNqE41spH+/8/J/?=
 =?us-ascii?Q?boo0kH9YLtIEVrv6l1Nk3Sl6jqkVANktejhEp4nd4kNkf5z518E8FCQSAb8c?=
 =?us-ascii?Q?7KOR8wjOItjY7S4xgQg15nBQp6Dm2JgL1Pkaxhi9a+7rt6vsjs+gRG6QnJBK?=
 =?us-ascii?Q?cOlRIj6N1SDDgcQ806U9UfCJNPe3lXxO3NAZwVmlsBM2epEvTZxtbPUzqgq/?=
 =?us-ascii?Q?XMr+PGUF6PM7K1kT2S/FVcu2/NrfZqx0kQ378U1QCx572Em1gB5dilccugJ7?=
 =?us-ascii?Q?F3sWJJErtpKh59OWKvHjEDDtUtOraxiD0hfumVT0SLT7IGvOgnMW2/k3E0qP?=
 =?us-ascii?Q?5NxUZQlEnKJfcZmMsCt1q/Cf0o1IRpzYS6w/CxmJI/0jvleyVXaEDlFyM/jY?=
 =?us-ascii?Q?cz6HEbGx/EfepQKIPbXL5A6heWD5CLK4iqWTw8VhzXuMSxibapJMt82WHcUT?=
 =?us-ascii?Q?ieNGfS1JHf98kD1FfJqkRlEpY/gVSyXVMK7CUhntxC3EAhHQDK3Yx84dwY6N?=
 =?us-ascii?Q?WAPQIVItImloq6KAWFM52a2Vyq1nOhZoU9eIY0Gu9xrkABbrxbM+nNKii14B?=
 =?us-ascii?Q?Q0+Lvi/PkO2rF+AnmahT6n4+ypKPp+G1PEJ51CebBx1mp+/RCi4RUGFTMZYY?=
 =?us-ascii?Q?fLHBZbhcdLAthbV8dbpCKjexxBGEuQYdk1GrFuaUHEeaCh1dKKVV8qpSD5jR?=
 =?us-ascii?Q?L2ZkK+iiqAb1L5QaZNhIkWO1LeoJNOMXGjrMSMXcPAUo/7OUYmnT4MHkzp17?=
 =?us-ascii?Q?QO7gAhoi0BJu/R+enGFFtuqkyb89?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(376005)(82310400017)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2024 16:52:43.7617 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d646e0b9-5336-4f22-88bc-08dc81921775
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6147
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

From: Dillon Varone <dillon.varone@amd.com>

[WHY&HOW]
UCLK and FCLK are updated together, so an FCLK update can also cause UCLK update
to SMU.  When this happens, the UCLK provided should be max if switching is
unsupported.

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Acked-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
Signed-off-by: Dillon Varone <dillon.varone@amd.com>
---
 .../dc/clk_mgr/dcn401/dcn401_clk_mgr.c        | 36 ++++++++++---------
 1 file changed, 20 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.c
index 0975986f5989..0fbe615069f0 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.c
@@ -791,14 +791,16 @@ static unsigned int dcn401_build_update_bandwidth_clocks_sequence(
 				block_sequence[num_steps].func = CLK_MGR401_UPDATE_FCLK_PSTATE_SUPPORT;
 				num_steps++;
 			}
-		} else {
-			/* P-State is not supported so force max clocks */
-			idle_fclk_mhz =
-					clk_mgr_base->bw_params->clk_table.entries[clk_mgr_base->bw_params->clk_table.num_entries_per_clk.num_fclk_levels - 1].fclk_mhz;
-			active_fclk_mhz = idle_fclk_mhz;
 		}
 	}
 
+	if (!clk_mgr_base->clks.fclk_p_state_change_support && dcn401_is_ppclk_dpm_enabled(clk_mgr_internal, PPCLK_FCLK)) {
+		/* when P-State switching disabled, set UCLK min = max */
+		idle_fclk_mhz =
+				clk_mgr_base->bw_params->clk_table.entries[clk_mgr_base->bw_params->clk_table.num_entries_per_clk.num_fclk_levels - 1].fclk_mhz;
+		active_fclk_mhz = idle_fclk_mhz;
+	}
+
 	/* UPDATE DCFCLK */
 	if (dc->debug.force_min_dcfclk_mhz > 0)
 		new_clocks->dcfclk_khz = (new_clocks->dcfclk_khz > (dc->debug.force_min_dcfclk_mhz * 1000)) ?
@@ -872,19 +874,21 @@ static unsigned int dcn401_build_update_bandwidth_clocks_sequence(
 				block_sequence[num_steps].func = CLK_MGR401_UPDATE_UCLK_PSTATE_SUPPORT;
 				num_steps++;
 			}
+		}
+	}
+
+	if (!clk_mgr_base->clks.p_state_change_support && dcn401_is_ppclk_dpm_enabled(clk_mgr_internal, PPCLK_UCLK)) {
+		/* when P-State switching disabled, set UCLK min = max */
+		if (dc->clk_mgr->dc_mode_softmax_enabled) {
+			/* will never have the functional UCLK min above the softmax
+			* since we calculate mode support based on softmax being the max UCLK
+			* frequency.
+			*/
+			active_uclk_mhz = clk_mgr_base->bw_params->dc_mode_softmax_memclk;
 		} else {
-			/* when disabling P-State switching, set UCLK min = max */
-			if (dc->clk_mgr->dc_mode_softmax_enabled) {
-				/* will never have the functional UCLK min above the softmax
-				* since we calculate mode support based on softmax being the max UCLK
-				* frequency.
-				*/
-				active_uclk_mhz = clk_mgr_base->bw_params->dc_mode_softmax_memclk;
-			} else {
-				active_uclk_mhz = clk_mgr_base->bw_params->max_memclk_mhz;
-			}
-			idle_uclk_mhz = active_uclk_mhz;
+			active_uclk_mhz = clk_mgr_base->bw_params->max_memclk_mhz;
 		}
+		idle_uclk_mhz = active_uclk_mhz;
 	}
 
 	/* Always update saved value, even if new value not set due to P-State switching unsupported */
-- 
2.34.1

