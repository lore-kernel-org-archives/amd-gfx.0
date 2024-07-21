Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C85E8C3DA5D
	for <amd-gfx@archiver.kernel.org>; Sun, 21 Jul 2024 06:22:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7BB1410E1F4;
	Sun, 21 Jul 2024 06:22:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="D0/JaLHY";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2050.outbound.protection.outlook.com [40.107.237.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0AF7510E1F4
 for <amd-gfx@lists.freedesktop.org>; Sun, 21 Jul 2024 06:22:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XKxXUZhtqleXZ+92nfvTcPS7cGbM5wI5l12df9WcAof5Dv+n9kKvhinHSmi21Ulu5kVggPz9PHgeFbcuqwapsrexf3Wf15OdEwIqCx1ATrpR4eG6Uq2Q+UUXgp2YaSULgeAlM6kGoVmxN11w9plC/akPBpyD76OjaTo1o1RAWsLPSjmrtJwqB1TXsAqGxHPc1zU7Hzss+2DqcFNHoExHL9HA5FBel++iUwjMM+EuQvu+K4yLZQcUBxSrT5HzSZwxebOkMeAmv/9zh3lnGW0qs32ixsjEACyBVYZXFXEXxl8yUH4DX3uZ8yCozkCvrhi8vloW2qcNhUkmxwmRK9JIoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dfl5kzIr7Bfw/6s1NZLSV9LE5aEnjyb4Necy2/RcJfM=;
 b=wRfs02OIaMyc4lKkY9AasgYHvO5+SBdzctJae0JxKzA8zxSXCsWs7KiFYJE9DOzKrAE31dO8o/bK7RrVASyngi3l7LOwFBkT+7rDZcT7ZqMBwc7wJRGsm1DiKi+DmiftoLJox/mhsolWU1eIAvhWiAMrv041IDIRo49QTW+fXBwLlMK4gx0VYrt2xai3aqZoEYPaHL4EnPEc7ic2gMsYdYPlzEuKnORza1r3XOZHVIGkE5E4U7WdzUs1Q/wI0orDWLpo5jHxdzWgB7EJalYPidjIKO+Zpj/G32K4K8yNykZYfI37E0U9OKN64tSgErw89qFNC3iuqI1yrDM9cZAdZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dfl5kzIr7Bfw/6s1NZLSV9LE5aEnjyb4Necy2/RcJfM=;
 b=D0/JaLHYYpeucOQGzBMs86Bk93dRjgA67p4hXtEfN8K2Yc5OctpG5H0sd/RS0fL4X1edSuKurZ+Jn58VC0fzUhZh4XMfrjdc/KKRuLUbsR88+D8V0KPmFrRHS7jGiNP/fkJljOCPTNO10+afBYUbXSuHDirUU+s3odiS7F9EEbo=
Received: from CH5PR02CA0017.namprd02.prod.outlook.com (2603:10b6:610:1ed::19)
 by SA0PR12MB4430.namprd12.prod.outlook.com (2603:10b6:806:70::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.18; Sun, 21 Jul
 2024 06:22:50 +0000
Received: from CH1PEPF0000AD83.namprd04.prod.outlook.com
 (2603:10b6:610:1ed:cafe::d5) by CH5PR02CA0017.outlook.office365.com
 (2603:10b6:610:1ed::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.19 via Frontend
 Transport; Sun, 21 Jul 2024 06:22:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD83.mail.protection.outlook.com (10.167.244.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Sun, 21 Jul 2024 06:22:49 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 21 Jul 2024 01:22:46 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, Roman Li
 <roman.li@amd.com>, Alex Hung <alex.hung@amd.com>, Harry Wentland
 <harry.wentland@amd.com>, Hamza Mahfooz <hamza.mahfooz@amd.com>
Subject: [PATCH] drm/amd/display: Fix index out of bounds in DCN30 degamma
 hardware format translation
Date: Sun, 21 Jul 2024 11:52:15 +0530
Message-ID: <20240721062216.3151119-6-srinivasan.shanmugam@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD83:EE_|SA0PR12MB4430:EE_
X-MS-Office365-Filtering-Correlation-Id: babf3f65-8a7e-48a3-20a6-08dca94d8b9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?eAZnkAU5wZ5zHYfgAEks61Ca72iUecHwLEENIEJtyw755Ce2bmUp9JLzib5N?=
 =?us-ascii?Q?5oMoMf28dGjxubO2YThk4lcFTV/V+nVfKvViyhiKPWoHlWDtNE5SGTRO662O?=
 =?us-ascii?Q?TQeCBH2Jc41gCOQa28i+rfbDC3pNFw+2hr8rSg85N1ZLhkfoepdmSfbFpHSe?=
 =?us-ascii?Q?W+5aDp/V5MRj0JLacV9VcumQ9tPs6TvvP3zXNMEkD7TSO63YNij0dp9w0P8P?=
 =?us-ascii?Q?1jx++lxaSEP1CBfbInD0HZI2lz/v6mr2QBYXRk4T+txUh4/FHvQ/7lnZxXCx?=
 =?us-ascii?Q?NpMhttrg6rmaDOX53SFcGz1ZZ2q9z5un1ocsVJKoDAQhwQVK/LBHyLCxbt3d?=
 =?us-ascii?Q?fxHsrPD6SruSY9frQDx4BQsfxSck39iVZ6hNPZdUdVMoeT1hG/yFXTN03XgJ?=
 =?us-ascii?Q?CuRvDQ0U2alZWbNlRgOaSjfpRZylzXUPHAJ7dBUyLaXC1t5HIBYN1ZSK9YQl?=
 =?us-ascii?Q?jSOB66UwtFwRXOb17fwBKSJo4mWqPivO56HLIPf6UV9oLqOjjW0L2wgapsvA?=
 =?us-ascii?Q?3dZz5AtOUZHOslggNMrvW/MLJyvGfxwfzdcelK+YlxRxxmwWMhLNg9nNEVYB?=
 =?us-ascii?Q?wYECJFSeSrObyeRFIwqa0eXniBU6pDA/BdXQSQp2l9Z5cR2xDf1jBed74Dsq?=
 =?us-ascii?Q?sZ0vwqKKE/SYDGhXyM7lJyrfOe06Df20sHzLb/9Lm/2SUj+wED+rAlwGyHry?=
 =?us-ascii?Q?/aoZp7RYYqHeCPP/xO16f1pkI9ikE/TKUNkDt3VmlUczZQxtLtVqfqY39NYV?=
 =?us-ascii?Q?y+QX2YHn6TGD/tHS4tewjzESkd+CW4IN8ox1M1uKL7CgDJ8E/v7+l8tUJYAl?=
 =?us-ascii?Q?OEsWAEzZs5r9JmNizVswL3e/8PwybHpV+/N4fiiIQfZUaZrYEFHtugzmY/sr?=
 =?us-ascii?Q?wDo9hEtCW+iGa8h5gWMz7FX7obdo6RLiIcyKJouQZZ0wwOSrM8oTMcR3oLqX?=
 =?us-ascii?Q?HZgn7vm9yXju768eS0TRa8yFOAZHZKmBMkt9P+yX4uVvujJ/EUAEWbFB9Aj7?=
 =?us-ascii?Q?czlFXnAjiwhwvz067FQB7e+CZx853mokRVZUb9OShDS0YgMid9JJBTV7pGuF?=
 =?us-ascii?Q?7TkMwRh+DMoD+IPsAHNpn6a1tYtt4R/kfSV2k94fqekllg7HZuPfF9LnwTN3?=
 =?us-ascii?Q?47QSQaDB0uuRhiO8p8yripVSCNZU31EB+hZETzQU7xf1qdcJSmMUtbe6qRSE?=
 =?us-ascii?Q?i5JA/6q9q4XXlsjk6E7416VRmTsZc3Iqg6JxtI2nSFY31aieAvsdyUZlMQkd?=
 =?us-ascii?Q?G0uYyPcq6qvMsxJNMZMBTydqc8LP8wbRwzu4qYcC4hsSIZAJTSJv49KZTWJ8?=
 =?us-ascii?Q?TgkAxoNz/TS2FItRbszXOq178ix+qcwFZ3ZzYEgpRYCzBJ2/w/2ED+Yq7hrw?=
 =?us-ascii?Q?+gggTUrqxLEK5QXi2qs6Ao1/3iLv9wB2xL9pPfKDlJStQb+GxCxV92w5e2Wq?=
 =?us-ascii?Q?5KAQF0g8JH3asQU6kn48izDQBiqyDP8J?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2024 06:22:49.8802 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: babf3f65-8a7e-48a3-20a6-08dca94d8b9e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD83.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4430
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
`cm3_helper_translate_curve_to_degamma_hw_format` function in the DCN30
color  management module. The issue could occur when the index 'i'
exceeds the  number of transfer function points (TRANSFER_FUNC_POINTS).

The fix adds a check to ensure 'i' is within bounds before accessing the
transfer function points. If 'i' is out of bounds, the function returns
false to indicate an error.

Reported by smatch:
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_cm_common.c:338 cm3_helper_translate_curve_to_degamma_hw_format() error: buffer overflow 'output_tf->tf_pts.red' 1025 <= s32max
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_cm_common.c:339 cm3_helper_translate_curve_to_degamma_hw_format() error: buffer overflow 'output_tf->tf_pts.green' 1025 <= s32max
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_cm_common.c:340 cm3_helper_translate_curve_to_degamma_hw_format() error: buffer overflow 'output_tf->tf_pts.blue' 1025 <= s32max

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
index ef7d75f6ab93..f31f0e3abfc0 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_cm_common.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_cm_common.c
@@ -337,6 +337,8 @@ bool cm3_helper_translate_curve_to_degamma_hw_format(
 				i += increment) {
 			if (j == hw_points - 1)
 				break;
+			if (i >= TRANSFER_FUNC_POINTS)
+				return false;
 			rgb_resulted[j].red = output_tf->tf_pts.red[i];
 			rgb_resulted[j].green = output_tf->tf_pts.green[i];
 			rgb_resulted[j].blue = output_tf->tf_pts.blue[i];
-- 
2.34.1

