Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FFC6C36005
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Mar 2025 17:57:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9AB5A10E56D;
	Wed, 19 Mar 2025 17:57:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Ds5+Ql0W";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2049.outbound.protection.outlook.com [40.107.237.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4762110E566
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Mar 2025 17:57:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=juk6VGJZJwA6CQLV/o9k3inCHuwKCkMijlOmNBZDg8jF6r+p97vxkCNQhkPCg9bGNxsA8mIGTWUV/wkQohODV9HV7Y8OOkvi2prZEMGvc6Eqi3a3hZM99XVW4h86mK1vxzkZHdLBjty0hJS8Q1dfaP/8fXxxGydqgQbUlxsOjKhojAeARPFzq490LXyoam4mRXEsXYnOKK0aLW/TIw4Dw1jtf/3BmJHF37OfM1O9Dex09eQD9+epokGWJDinGBxPQSLm3kCClRZ+nWD0lXuYV6WteTs/REtjaA7zahg8nuhNuUqLGxPMmpg9mRie+obA0Yl/UlCXZgnqfaR+Be0Auw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bsnfg8K3OlhYFs28JaPedNj1+0rzrASlifvdsBin3sI=;
 b=hpOR5c+qQEpd8EhYc3vqqAHXpzrrxnKj08mrIhDu1M70yuHOF/mLL4IKpMDDjJnDYnuhUbRi0r78S6zsTQSZLDAJ2G+Y0vYdMoNuLYGimm8lDtR/pH4CsrHD3+wSN8aQICYb1xVf3WaSeKt6L3MKkRlgr+NuhHt/WeTNXelpxRpSLXNb+ZTbbg8pRvYW2P0/j+evvH7cIQjrV1RMk+sOFSU9YA/CWjkT7pQh0LNgma00QAFARWpUWwmj4bUwgpaC9joVNgJtZN7cRykB5lwLdwn99jR8vo8WhqA0BiwLzecaIvBUxp1A6oQwrvLQnWLMqFeHm812sxcLYrNXtbaEPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bsnfg8K3OlhYFs28JaPedNj1+0rzrASlifvdsBin3sI=;
 b=Ds5+Ql0Wg1vue39BV2zBt0OcMyzD6yF6YHArBQKEMA20jyMbGgdzpeowgRRluU/qm4vQdgjCyuAFlp1AQ4CVt6wBGPWhGuaG40zypRauRjz9RkbMamNzPXrERbAroSn2DrchoIqnayjm1KTvvAMBbhlqcBY+KmfMno9J4Mq0/oY=
Received: from CH3P220CA0016.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1e8::10)
 by CH3PR12MB8074.namprd12.prod.outlook.com (2603:10b6:610:12b::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Wed, 19 Mar
 2025 17:57:28 +0000
Received: from CH2PEPF0000013E.namprd02.prod.outlook.com
 (2603:10b6:610:1e8:cafe::6e) by CH3P220CA0016.outlook.office365.com
 (2603:10b6:610:1e8::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.31 via Frontend Transport; Wed,
 19 Mar 2025 17:57:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000013E.mail.protection.outlook.com (10.167.244.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Wed, 19 Mar 2025 17:57:27 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 19 Mar
 2025 12:57:26 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 19 Mar
 2025 12:57:26 -0500
Received: from aaurabin-z5-cachy.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 19 Mar 2025 12:57:26 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Alex Hung
 <alex.hung@amd.com>, Charlene Liu <Charlene.Liu@amd.com>, Ovidiu Bunea
 <ovidiu.bunea@amd.com>
Subject: [PATCH 11/16] drm/amd/display: fix zero value for APU watermark_c
Date: Wed, 19 Mar 2025 13:55:16 -0400
Message-ID: <20250319175718.2578234-12-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250319175718.2578234-1-aurabindo.pillai@amd.com>
References: <20250319175718.2578234-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013E:EE_|CH3PR12MB8074:EE_
X-MS-Office365-Filtering-Correlation-Id: 06d1146a-9a75-42a1-29c2-08dd670f8305
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?e22u+GoM/VuC308d95k9gvVi1unZIalYhypLWCfO5yzzxRNpE+MIW1HnnapO?=
 =?us-ascii?Q?910EP7sVjJbdC4ahUIBYJ07L6/mosaEKUVC7KcDrJeLSCql+KiBYAyviZ9yz?=
 =?us-ascii?Q?R3KwiC8+fub9Z0PDuIryhz6LNu0X8we/0NLfq1H+RzWr3twvBNJmc8fVE1I5?=
 =?us-ascii?Q?5BE9xmW6zx2dXN4yGHRMcq6i+hKVOBIGNCs+caKmCWQ+V1dP3zWQiWQBGbMR?=
 =?us-ascii?Q?oaynFE0vTu/8j6iPtc3idN0iSyc70KOF4/MdRgMOantexHa7AHOKx6DJSzAg?=
 =?us-ascii?Q?C9MLV+6bkr2oBO/FMxl7vn3Ud+PFjWRIAlRdJ+0B27zpEzTvbogYubO7ZIyo?=
 =?us-ascii?Q?hhJjgVeESENVTIU1sQECSoCq2jlW/RD2dT1YObZh45aDxrSCwWilA5i9uRjl?=
 =?us-ascii?Q?FguM71YntmMPDAi4dqaCNneNPpTERlwjn5BbW/Zq9laoBYKpKFmCmWeHv0dR?=
 =?us-ascii?Q?OYhfIjTuVHpYG0Kf7ul8iQOAUODZasT08xZd5xlw67/fZjLX2XVNPAIEb+Xj?=
 =?us-ascii?Q?UXmD8pXhdo77ONCrmYXoyFgYMPhz9jl0FwzdegG7KHszZEHIQDUV7s6t2foo?=
 =?us-ascii?Q?7QkvgzA0WvGo570mGfGg5LzG0OnOTIkC0LBsI5JaUqAspsjm61PNhSKN9ziB?=
 =?us-ascii?Q?/+letesboaMLKFPuXLMgt7M9BlC9cVAnkmeXwu27g8nSfaaVlX2ER8PAEd0z?=
 =?us-ascii?Q?aS5r5PgoNPYq7dzlkBkkBOR2s8VrWt7pzENmeciadDByRSBntQYwvj3m2LTq?=
 =?us-ascii?Q?g0feaWH4Uq5fUEoJSqSXRIHzzu4HNOy0WmCeRdeChfTHXyF0svvcWnd6JgdB?=
 =?us-ascii?Q?lkdgYdiasEctNKRhLk26PV9uP4nitHLgNKNCUma70FSqllX/MjdxbVSQgami?=
 =?us-ascii?Q?/vBUMlq8uBk7GAQJ28Zv/LopUq1b5AMzXg0I5o+KlhVBxI/5hgj8dnC7Rv0u?=
 =?us-ascii?Q?TjTuAXQIzaCmhOLOB4PxvJflKxUZOmwRuWGGod4z59HE9nRiMOMvJkPBeYcD?=
 =?us-ascii?Q?lj29JSYLtczwOi1rmyo1q/pw/zjsjpfNxgvEgkRfJMGi5Aaf/P3Zs9HeFGRq?=
 =?us-ascii?Q?uAy+k/UkS0mNYJvX+TAWi0kT/mhHSLg00JTau7zgL/iPLfEpUtWdNYR5BtOr?=
 =?us-ascii?Q?Z4W6p4ZZM2xCBNY2R5mfxutODLFOF7CSY8pCBtVFvb1Zj4CFOrwA5Y3jmgUv?=
 =?us-ascii?Q?bZpvU+EnZ42g+BZgyL/acX8HDWkrOqam+o4wvcfXIpnzrxsW5bNAdNurgx3x?=
 =?us-ascii?Q?PkF7vyjN7ebwIcKQa589rF3GmXLqAGCj5WL8wD474Ue/SerP/9zaWZPdPy6B?=
 =?us-ascii?Q?B7JxE7gAbPJV6rgbM2T5iE+TZR58qCmxEVtsHRSd2XJJcJyXPcVraPv9FHZK?=
 =?us-ascii?Q?IaF2LpztLW4dSxaz+CUQLZCTslsNhRJ/lQ9b9noaaZN6RsFj9JbmANJd/89R?=
 =?us-ascii?Q?5yUAsDYCMxJdxuhYMA/4sOKrobRmD6gCQCfeyCKINvakoBjrxLI8zh9xlTX4?=
 =?us-ascii?Q?1oud5z2JO7Tf8OM=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2025 17:57:27.6021 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 06d1146a-9a75-42a1-29c2-08dd670f8305
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000013E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8074
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

From: Charlene Liu <Charlene.Liu@amd.com>

[why]
the guard of is_apu not in sync, caused no watermark_c output.

Reviewed-by: Ovidiu Bunea <ovidiu.bunea@amd.com>
Signed-off-by: Charlene Liu <Charlene.Liu@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c b/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c
index 939ee0708bd2..359a0337d617 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c
@@ -661,7 +661,10 @@ static bool dml2_validate_and_build_resource(const struct dc *in_dc, struct dc_s
 		dml2_copy_clocks_to_dc_state(&out_clks, context);
 		dml2_extract_watermark_set(&context->bw_ctx.bw.dcn.watermarks.a, &dml2->v20.dml_core_ctx);
 		dml2_extract_watermark_set(&context->bw_ctx.bw.dcn.watermarks.b, &dml2->v20.dml_core_ctx);
-		memcpy(&context->bw_ctx.bw.dcn.watermarks.c, &dml2->v20.g6_temp_read_watermark_set, sizeof(context->bw_ctx.bw.dcn.watermarks.c));
+		if (context->streams[0]->sink->link->dc->caps.is_apu)
+			dml2_extract_watermark_set(&context->bw_ctx.bw.dcn.watermarks.c, &dml2->v20.dml_core_ctx);
+		else
+			memcpy(&context->bw_ctx.bw.dcn.watermarks.c, &dml2->v20.g6_temp_read_watermark_set, sizeof(context->bw_ctx.bw.dcn.watermarks.c));
 		dml2_extract_watermark_set(&context->bw_ctx.bw.dcn.watermarks.d, &dml2->v20.dml_core_ctx);
 		dml2_extract_writeback_wm(context, &dml2->v20.dml_core_ctx);
 		//copy for deciding zstate use
-- 
2.49.0

