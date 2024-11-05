Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C446AD36136
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Nov 2024 20:24:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6326E10E610;
	Tue,  5 Nov 2024 20:24:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YwEl1QTc";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2069.outbound.protection.outlook.com [40.107.102.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED58510E60A
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Nov 2024 20:24:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zV0BskAvkqH9Z0kXK8RRaY3l7XFXGfXSDoCxtzVWGLAO+jMY1EwdYDJ4CRDhAFlE0Py9MrqsM6fHIIaHym8/ypN3c3N3WUMdJ0c53bi16EWurBHdS0E9v5Lqp1fKd5dEYBKX1gsivtfz3B1ODt9f2Jyu4BuVLLXS0EGXXvg+2ZVunRnmgZ0/VdlL9X6y3mGw5aK79Aoo+4el+Ol6FaLL8AVj5UGuMLi6c3CDAm9mxRl9+PlBGf0naB+jq9MVA2OYDEVn3BsBf4vzGAsp+hMMOyG6cCbLvL98Lfc+UU1tMS10tNsptwxTbNzNtlw6hgSP3LxBeRRj6fMCzXXiyXk+dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9yMDfC1EEPezMT294JOBpCwEhq0tz6x0ISvFnVZzmbY=;
 b=NmsH24dUTdDQ3T4yW+J53tLNYYjqEZarNzNOf1t3wHLBtsC9HNmqCS07o/qYBycP3yIcENqV8V2r88Zmr8oT5oA2gUSvGYg08Y4w58Wrt3zBLf2i8zQc2WWBwVB2Os+npwJt1u/12Fg3VoUmd7bLDSACtzmfs9+s3cN1y2wQ4kmt51MtZopOBY7APc++/MDWfVSgIfJvXYugWkAtb2xfGpM0G+0EmHgEZn4E6iMEcRYRIpxLYcW7KEtrmV8ltbTuuPj4mkCqmUqbvrRo8JpxeLywz7ePDERbSNbuFmk9/Una/dj/p3MYBeO3Ow3j3mMDQmtu+kGFuUv7GDfKK/bwiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9yMDfC1EEPezMT294JOBpCwEhq0tz6x0ISvFnVZzmbY=;
 b=YwEl1QTcgm/JVkh3FQnbnNeM4fAm+p+Oa+iu11EI4GxNZIqCA1n1aSGR3kQdwnwoX/1gkHpetwJ2vT0V7FVEm7MGQ6HZkWnaEzu6HHGCN200RuIS71APEXXU5L6jB+cMWdKyTzXj/mMYKVEMZD7xuwb24J+SYSgN4XxcQUOiquw=
Received: from BN9PR03CA0296.namprd03.prod.outlook.com (2603:10b6:408:f5::31)
 by PH7PR12MB7427.namprd12.prod.outlook.com (2603:10b6:510:202::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Tue, 5 Nov
 2024 20:24:23 +0000
Received: from BL6PEPF00020E63.namprd04.prod.outlook.com
 (2603:10b6:408:f5:cafe::1e) by BN9PR03CA0296.outlook.office365.com
 (2603:10b6:408:f5::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.18 via Frontend
 Transport; Tue, 5 Nov 2024 20:24:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00020E63.mail.protection.outlook.com (10.167.249.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.17 via Frontend Transport; Tue, 5 Nov 2024 20:24:23 +0000
Received: from hamza-pc.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 5 Nov
 2024 14:24:17 -0600
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Hamza Mahfooz
 <hamza.mahfooz@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>, "Roman
 Li" <roman.li@amd.com>, Wayne Lin <wayne.lin@amd.com>, Tom Chung
 <chiahsuan.chung@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>, Zaeem Mohamed
 <zaeem.mohamed@amd.com>, Solomon Chiu <solomon.chiu@amd.com>, Daniel Wheeler
 <daniel.wheeler@amd.com>, Meenakshikumar Somasundaram
 <meenakshikumar.somasundaram@amd.com>, PeiChen Huang <peichen.huang@amd.com>, 
 Wenjing Liu <wenjing.liu@amd.com>
Subject: [PATCH 05/16] drm/amd/display: Adding flag for forced MST blocked
 discovery
Date: Tue, 5 Nov 2024 15:22:06 -0500
Message-ID: <20241105202341.154036-6-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20241105202341.154036-1-hamza.mahfooz@amd.com>
References: <20241105202341.154036-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E63:EE_|PH7PR12MB7427:EE_
X-MS-Office365-Filtering-Correlation-Id: 2384c448-be4b-41b3-b291-08dcfdd7d617
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?O24dFOdvugIp+kYUNWgWrtfZiI76XTYNAjjKDkoVDOwFbxn9AhKMYobh7hxL?=
 =?us-ascii?Q?rdPhm3hxgQ/Lyw+zwrFejJiH1/KqpeOWQDKo/xjM7Rt8T1mHDeSAQNvlu4uj?=
 =?us-ascii?Q?s2dTh01gnL96Ap4WijxBf0KHQvGi/S7f8oUxUP1p2Oxan21b/MW+6d4nC9G/?=
 =?us-ascii?Q?S1iQ0JNh3J0nXV3dYJ8AkYuKaZ/bKP2mC0rTHZEYiA5GMfwcZUhgBQd5xh6c?=
 =?us-ascii?Q?QMT3oQsKOcs63x2WXo7u9yDydwLB7v8AvLNIZac21G2NGYtHw3ZnxsTd7gs6?=
 =?us-ascii?Q?d2hmDjYyV4AMcyS3R4spXjYxoHlkQvtyOXG7c7bbSJXzIZmU6aeLtFEhyqWC?=
 =?us-ascii?Q?vBNH8dkHpktiHplrOD4JUHDCVWc2nfID++rCpQhPV890IZkz2+mURr6eD+ui?=
 =?us-ascii?Q?WPJCYsLYUmX2QbgthpTRcoJ5TyDubUMNqv6vHV5n8zhvAsjEt1m5ePJp9ZNe?=
 =?us-ascii?Q?EqNAop3MHhs8/oqooZBqCuR1hDUhJgowul5brZNrAfob9QOfHQKcqij09vI9?=
 =?us-ascii?Q?ded66gXy0VeMMaJ1+jqXOqo5sI+qNMidY7wp5nSTo5sFMyyIDzzUjZAF00o8?=
 =?us-ascii?Q?ivCdm3hKa8TsAZaCkA1DBr113mB4Qwm3oYELtJt4Q8o6lqmK9NVxt7UQJUCk?=
 =?us-ascii?Q?ca6OYRcs648CegWuu7D1HFgHMyMmBpfyP6sva/rW0vrMCVUQeBwLB5TKk4n2?=
 =?us-ascii?Q?uVzUgIXrMZ3pX2tmqveq7gVrbjOIkKaczvsa8lJfDhxsUkmN2ctYUU+seKzn?=
 =?us-ascii?Q?pJxuqYVuwL0SpT1I21TQZR5h9473VKmqFW5/s5OvVJtLlKGCn0KGHLvOt+Nv?=
 =?us-ascii?Q?4/bdC8FMOoTv6ioufX6yLCESTwgmffwhZ7EOkedV00XpH8L17RnbB+tu6gb5?=
 =?us-ascii?Q?UlPYz/YlSZsbL90ukP5qSyZLzqEfY3pVmLPYttHG7ucGzmRqLmqSfXv36isu?=
 =?us-ascii?Q?pvisb9jfnI2ZvPM8d2r2+i0cZVepooHWz+0q/U83js6EK/RX8kLscL1zUoZq?=
 =?us-ascii?Q?eM6+7a8BRMKCfmhPiMQPxAhDGaDM2ak3yy27oviaJx+md9SAU+b0YPcXftTK?=
 =?us-ascii?Q?Suc06wka7rJ9EL/D9PjyuChFfsEuP/LiMK0yvVZuk6r7Cngq0kQD/0NHQIh6?=
 =?us-ascii?Q?pvFAZkB46n9STwKm830p38rKBWXIOZxk7Rq95gOl03UipmKIUjjVuLNk+4JM?=
 =?us-ascii?Q?r304UWGLWPh0tmbj295WTbU0duJDBAWWx1FfHl3yqw1s1aGe1aGFW8WdPKtC?=
 =?us-ascii?Q?Ui1iXhZX2oeX6dlVxtvYSfLqGbxPlNuJQAji8C1MP6P5m0c4ufqaii9KY1Af?=
 =?us-ascii?Q?CbD+7XpeeHCIZ1ukhSDtfvsV2S4KNd2XNHvR9Hq/Sdppg3F9mWUNeJ07qQjS?=
 =?us-ascii?Q?gkuUaoo/TVbmfCA7vT3UgmtqWEWr/Om17XXDtxW3Ftjpgv8FZw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 20:24:23.0033 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2384c448-be4b-41b3-b291-08dcfdd7d617
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E63.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7427
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

From: Meenakshikumar Somasundaram <meenakshikumar.somasundaram@amd.com>

[Why]
Need a flag to force MST blocked discovery for certain branch devices.

[How]
Added a flag to force MST blocked discovery in struct dc_panel_patch.

Reviewed-by: PeiChen Huang <peichen.huang@amd.com>
Reviewed-by: Wenjing Liu <wenjing.liu@amd.com>
Signed-off-by: Meenakshikumar Somasundaram <meenakshikumar.somasundaram@amd.com>
Signed-off-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_types.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_types.h b/drivers/gpu/drm/amd/display/dc/dc_types.h
index 1fd030e3f4be..edf4df1d03b5 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_types.h
@@ -181,6 +181,7 @@ struct dc_panel_patch {
 	unsigned int disable_colorimetry;
 	uint8_t blankstream_before_otg_off;
 	bool oled_optimize_display_on;
+	unsigned int force_mst_blocked_discovery;
 };
 
 struct dc_edid_caps {
-- 
2.46.1

