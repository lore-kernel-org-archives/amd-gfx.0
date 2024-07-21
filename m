Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF143C3DA61
	for <amd-gfx@archiver.kernel.org>; Sun, 21 Jul 2024 06:22:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7EE9E10E18B;
	Sun, 21 Jul 2024 06:22:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pUoXdYZV";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2048.outbound.protection.outlook.com [40.107.94.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C05710E1F4
 for <amd-gfx@lists.freedesktop.org>; Sun, 21 Jul 2024 06:22:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h73jtJbcnBxRekuzCDJBOE31+45XiFO0P3uwHLVf8VTGs2jcBnzSZPpMAmcOhpPE2YPD7AKHQsGC7ipP+jwqRHwLeNumaFtKBP05NB7n5jmt4oBBBgwqnlQOPDX5hOx/K1qSdR3ibuIYYoClLl0H8nW883NRHjdLqzPsyKTVfC5/6xG8oWIC6iaLXxZihJVDJkbhS8UGg7w+ca7404dDM4JtAf1hJpPsgKuZ0l6406r2v/xitCn48TsSMqqPhwAuA0buGvrNWEqjGMTh1SehIWQ2Wp0kYzb8qKmELOGGexDyxKoIyWX0JKE3sJ0pPGRmUJfkAM+E0TsnfULq80wz6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zhq4dOpaHmQiEAdeHZQrVYuf76lUvwxPsibw24PcYTw=;
 b=GU+WXRRxBeH5Txzlv2e7YP3YUplEP3RewxH1/jUQmffgOCWWJMeoTpTvbsl2uY2h2DPOiqTCp4nN1OzEa2JAaAgswQAt/2hu8WjhZCcGgmZPyiXTg5MLmo7IAI8Xp9DjGDE/EjCQJQ5wf3qmH8xR2nGSnMB2QU5dC2VHOcQLf6LV5RUZYzb+/c2gv76AN0aJ949W2vwh6q8nTun0n7Mnz5WK6Nw614oZSB6ibHUlIT3vTlCSUMNv/VndDuQYuGlrNBmsYygBsv6prUXm9hx2VwjhMvIK/B3vKVJ/Nk99/igp782dzce242fzSlnqcCviiy7fP+vkZt9R7S+tuc7pbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zhq4dOpaHmQiEAdeHZQrVYuf76lUvwxPsibw24PcYTw=;
 b=pUoXdYZVwvz9/lm768vFpfjEk3WGU04x87/iLBefJykBb/MGKXJ5Pzimh3oN+sAgUrv/L9o/3eI+yf2KegsTo3bGIo1HyTilKdkI5eW8I+jLCPTdYtC0uQIaf+WQNn9IHMcQFc6tDFF6FP2UBfS3nto4xgEQpbavoYVf9XpzUUA=
Received: from CH2PR02CA0009.namprd02.prod.outlook.com (2603:10b6:610:4e::19)
 by PH7PR12MB5903.namprd12.prod.outlook.com (2603:10b6:510:1d7::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.20; Sun, 21 Jul
 2024 06:22:47 +0000
Received: from CH1PEPF0000AD7E.namprd04.prod.outlook.com
 (2603:10b6:610:4e:cafe::77) by CH2PR02CA0009.outlook.office365.com
 (2603:10b6:610:4e::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16 via Frontend
 Transport; Sun, 21 Jul 2024 06:22:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD7E.mail.protection.outlook.com (10.167.244.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Sun, 21 Jul 2024 06:22:47 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 21 Jul 2024 01:22:44 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, Roman Li
 <roman.li@amd.com>, Alex Hung <alex.hung@amd.com>, Harry Wentland
 <harry.wentland@amd.com>, Hamza Mahfooz <hamza.mahfooz@amd.com>
Subject: [PATCH] drm/amd/display: Fix index out of bounds in DCN30 color
 transformation
Date: Sun, 21 Jul 2024 11:52:14 +0530
Message-ID: <20240721062216.3151119-5-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240721062216.3151119-1-srinivasan.shanmugam@amd.com>
References: <20240721062216.3151119-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7E:EE_|PH7PR12MB5903:EE_
X-MS-Office365-Filtering-Correlation-Id: 15ab20c6-f61c-44d7-a10f-08dca94d89fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Nmy/94xJuHkWXTg+ybWoolzJXCszPm4NLouMMmDfYNiOt9weebxbuSDqRtoZ?=
 =?us-ascii?Q?1X3X0eWWcAl/acrO/XoSCHx9Z908NGfnTXa0iGxqHuCHExTrXAElc3XimtFT?=
 =?us-ascii?Q?UJJZT7PorNq0PuWbYg2dL/f5IEA9dnxxywIgqHW0A5EOVyGERPoU+L4I4TQB?=
 =?us-ascii?Q?UoMUq3rBXbjWVBl/NPfCL4sOl5pdLiWYuo5xsY0OntkZL4MhlekKMQ4WN0gh?=
 =?us-ascii?Q?CQGaRNYppuNmfZF6sRcfmElmQN3JelVgQvOAuQpC3GYUJjzTEGOfyfyJBQMU?=
 =?us-ascii?Q?AVDu5Hhz4dPFFRnMZsbdmMztUIMHZ4yWC+visKQrgf8QAc92ZktN4LOn2Img?=
 =?us-ascii?Q?fVqZLx6s3xTqlvSaz6EmPgyyeTuZ6sRZSm390BKDK2kR47B0lyR9GfefG3dD?=
 =?us-ascii?Q?OiwfWIc6KIF6q7no6yh/0hoO5WEuc4yFmoYpm9CP6O7VzEgaUPdC0XtYaPLQ?=
 =?us-ascii?Q?H52fgI3WqM3fQT/5GSs37pEfMm4wbaB4UsDIptAhn69HU4moZl9VfHz/5/rP?=
 =?us-ascii?Q?3NLH855Orx+mqIwHK3m/YiG1UczuIy7qqAdp+JcEnvtJ/2BQrB9lULej8OgO?=
 =?us-ascii?Q?wJhQm3E+rBoYQGBoTjZDLQZcDeiHB9G0bk7raDJdHxeYrXYQfpITInuezSZb?=
 =?us-ascii?Q?Nz0shW4MvHEeruH6eHEcq/Wxqx7HdZ5reW+V+fhjQL0z/KoqK4EDX1FpZc9o?=
 =?us-ascii?Q?a/7G9JTQ/kUBCNn2CM8WTqLH9UGLY3zlia/NNqbeN2Q+zO9UamlzISnbvqIi?=
 =?us-ascii?Q?9ObKSVlpH9JtVt2r/c6WWUKlYsCUV8Rv/MG9DlD5RZajUn6vIUtv4ovDOXpp?=
 =?us-ascii?Q?bnADUeNi36I3Tdl6U+V7K2k58/9sPZKOYl34iJQujNsDdRbAq1gnw6+1RK71?=
 =?us-ascii?Q?Ht4CyP971IZfw6LH0YNnJhD04/EAbsdhIzkq9PxWnh1+gPnqtIJOhKfXvqw9?=
 =?us-ascii?Q?y0DZTaBR9skvBZFJ3XKXfKnyuQgM8PpJAGkuN5vcUx8Jecik2DX6KGBfujEc?=
 =?us-ascii?Q?EOeWyphfav84kEgMff7Iz5oBuRWy+0aGhzGo42sn9mIFcFmdP9hrHTs2bDQl?=
 =?us-ascii?Q?noJw6pr6BFHXa1P5KTcHA6I4ayUpNbRIrOGM6LhyaaZqdD0Y6iYmF0+pJ2VG?=
 =?us-ascii?Q?BdO3oqYyt2zLfFTPnO2NM2ABnlpH4JwQ54giGhaoSusp+Vuvk04A0kRxL7uz?=
 =?us-ascii?Q?m5MipaG1jGo2OnluNhLvhQSxVlZ8OGVtnCTkXZhjWORGcGdH8+IzGJkbldAx?=
 =?us-ascii?Q?NC4tn+/QvtuKDwRQ6/071OwD974ptQoXjbemWy4EmnKZw3yb25gyHoxjnmlN?=
 =?us-ascii?Q?PDKmOcXXVtXnxJrU2TmdYITnSx4Ve0QSAQucfKwQDzJDjV1CDx4b+aLp7gUs?=
 =?us-ascii?Q?SGuFrKB0GG+UCHgEQ7xDIFlTg2iBD0yfXf2IjhuEMEnWN0fufntOSUky1f6K?=
 =?us-ascii?Q?wDcrUTQJe7niNso0WZVXua4cPfODjWwE?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2024 06:22:47.1662 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 15ab20c6-f61c-44d7-a10f-08dca94d89fd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5903
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

This commit addresses a potential index out of bounds issue in the
`cm3_helper_translate_curve_to_hw_format` function in the DCN30 color
management module. The issue could occur when the index 'i' exceeds the
number of transfer function points (TRANSFER_FUNC_POINTS).

The fix adds a check to ensure 'i' is within bounds before accessing the
transfer function points. If 'i' is out of bounds, the function returns
false to indicate an error.

drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_cm_common.c:180 cm3_helper_translate_curve_to_hw_format() error: buffer overflow 'output_tf->tf_pts.red' 1025 <= s32max
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_cm_common.c:181 cm3_helper_translate_curve_to_hw_format() error: buffer overflow 'output_tf->tf_pts.green' 1025 <= s32max
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_cm_common.c:182 cm3_helper_translate_curve_to_hw_format() error: buffer overflow 'output_tf->tf_pts.blue' 1025 <= s32max

Cc: Tom Chung <chiahsuan.chung@amd.com>
Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: Roman Li <roman.li@amd.com>
Cc: Alex Hung <alex.hung@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_cm_common.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_cm_common.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_cm_common.c
index 685702321d32..ef7d75f6ab93 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_cm_common.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_cm_common.c
@@ -177,6 +177,8 @@ bool cm3_helper_translate_curve_to_hw_format(
 				i += increment) {
 			if (j == hw_points)
 				break;
+			if (i >= TRANSFER_FUNC_POINTS)
+				return false;
 			rgb_resulted[j].red = output_tf->tf_pts.red[i];
 			rgb_resulted[j].green = output_tf->tf_pts.green[i];
 			rgb_resulted[j].blue = output_tf->tf_pts.blue[i];
-- 
2.34.1

