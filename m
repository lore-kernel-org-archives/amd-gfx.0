Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18F15FED9E9
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Mar 2026 01:02:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ACD6210E656;
	Wed, 18 Mar 2026 01:02:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="S3zwovuq";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011058.outbound.protection.outlook.com [40.107.208.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9FAC210E656
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Mar 2026 01:02:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qJmyl88fU3CL2wxSPe8aNsQxFWsWqY5UaDPki64SL3giFM7HvzSiGS/2lfEw+S+0h4BjyQ8u+UeG/xAQWi7WKiwLN0ltFgqisCcwEZcLkH0clZLvc0SIZAPNbKTZq+R1TsgPI1H1V8dxd/OGcsCKoZSyORJT76aNQE2HfvM2Y1t0HwhQFrc+kk+OHyEj2ykkrUhCD7V9i0DKaUidEN7wVsU8kfgXLesl9omcIm8R2fnF2ypVZ/yfYSIbm9yKfaAGtdh5PRX6re0EIywLr4/ZRgzUXQnaH9m3yniDJ4zcn/T767vIWhaJtXYkq+BdzcFKTMRYvznpUmZRVRH/SUoBeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uHH6zrkvDYAT6NOrEUMe5FyTcQ02B3NuED9E3pZDSxg=;
 b=tuQj7mLCkmwDwLDhsJw3/55WhVNQ5NMCVW3ynrXASbENUuuHbiZbzeK7ph9ptV1NaURZiEfqmLxwdV/Xqf5Q03f9KrYDbQ4vOzrQHPzpz4u4cM4xmSoprdIzcg5V9G8CZ/LI7QsZjd5Bkzcywyi/GPJe5+Q5GY1BddlcPnUvCtYIoXE4hsKvSav1JURwREem/ymaCwHckh7osj30fJOC5UybLwru35uL1heRztapC8+MRopbhivdNU9hOX35uzIPztyJNjc3p0B7lsXmvq9oUX/UvEC7fHdOhsNp3ZAZ6gg4qPvxV/aEnPEJ0YPtzVi/2nkB+GOyCGkOIZp8DujKiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uHH6zrkvDYAT6NOrEUMe5FyTcQ02B3NuED9E3pZDSxg=;
 b=S3zwovuq6VoVFPrbCfYyfYgYEEX6WekfM9yAT8c8g01wX4WXLS6UIXFBxKBw84wENs/1gTARAd8x+fkqi5Gah3Pze3lW5jx0agA/z8NnIM8220OCSBFQ3E/vwVRaTofEJ8riBTj2BgdzZ+TMOc+nkckKLyqXF9y/zOh/Um5skgc=
Received: from PH8P220CA0029.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:348::13)
 by MN0PR12MB5835.namprd12.prod.outlook.com (2603:10b6:208:37a::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Wed, 18 Mar
 2026 01:02:38 +0000
Received: from SN1PEPF000397B3.namprd05.prod.outlook.com
 (2603:10b6:510:348:cafe::ba) by PH8P220CA0029.outlook.office365.com
 (2603:10b6:510:348::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.27 via Frontend Transport; Wed,
 18 Mar 2026 01:02:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000397B3.mail.protection.outlook.com (10.167.248.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Wed, 18 Mar 2026 01:02:38 +0000
Received: from maxMSI.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 17 Mar
 2026 20:02:27 -0500
From: ChuanYu Tseng <ChuanYu.Tseng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Gaghik Khachatrian <gaghik.khachatrian@amd.com>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>, Chuanyu Tseng
 <chuanyu.tseng@amd.com>
Subject: [PATCH 24/31] drm/amd/display: Fix Signed/Unsigned Int Usage Compiler
 Warning
Date: Wed, 18 Mar 2026 08:59:33 +0800
Message-ID: <20260318010224.513094-25-ChuanYu.Tseng@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260318010224.513094-1-ChuanYu.Tseng@amd.com>
References: <20260318010224.513094-1-ChuanYu.Tseng@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B3:EE_|MN0PR12MB5835:EE_
X-MS-Office365-Filtering-Correlation-Id: b73a2488-b9e6-4301-c5b4-08de848a0c99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|82310400026|376014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: /uiYa5/goXJsFJjYWmNWIlo/vnmPS223tbj7m8xbmNUkNjhluYsyvoL4ucWwdXGt+4AVgBEDpWzE4HyIMXy/w42xY18hmiJcfYMDxGYU5BdheZ6ddpiyuSGAqAjCCVNSz83SQ4p+XK7yak6KbYe15LVO9sPpgQnBkfpWcM/3nPsd66hSSEdHdogE4rmHGHWyVN/++IkCHPYOKTPRmqBUEEaLxs8siteIaCDmTgF795WGhg/Q/Yf82YX/6lTnF5F6CYEZIIEs0bu9q1TWn0rau0Ws5I0lYRU4pY1+yOuYaKHNSOe073repS8w1N7m8HfaZsC7RprTA4Q4avbO9KOfnXr/Qjah+PO3+paat9P57u0ORpMVvySYuFSx7rePFi8+IyEN1EOKLQ/QjwjNJ4IDcyeLDxiCH+tQhbmKBgCGQvk8kN53o2DqUtHtRTHuVNEbcCYSofIc/rhYDCaUI6w1bD7f3kdzckRuVlipdKBV2LsIuRTAVO1SS3G17WHmbYl9yhKqd36r1Ds1bWf3nMMK2lx7DNKYs3nXFDLpDC9Hc9h3n+1WHAFMx38a6ccHXKooOiyDwzC6NJVC6xHsychFNktNpXXdSP+WaAwNIhxOfX5JTAxHOR8qyD47PdVNUA+RgV3JdiM/zCsWppInqotgvjUupdgbkOqxiPVIKFdOSZAhuYtpcRrpkWGz8OvKyVFIeqA468OKgO0dFU1AST5wCCmhjhMvx8JHAWO287nRAs1CZNFXedMWI6sOhHEmfKE5VtI1V7KMVko6ESuG8jrSaA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(82310400026)(376014)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: N2KmLeLyStPJp/3zrelkGepTPlfBuAjnI5NJZhE5XjGXWARsMXXuFBwQuanl9i3SdtGNVJML6ofg9KslPYlZxe2jSXF9oYurzWzJMuQ2UUXMz9T03TTmEGdV6+PMo15xirCYIZv4qAJuJp5O5Ty49FMzUOrcHCdht7jWQ1wuUAwPl0OggV9g5tr45KrtjO2vnFC+l3AaKBgjcYrbUBdHuA0KDVho0aizQ3Xl5AwsjaBqX7fmCUonBGu5CfyRPiurpQi36YSUUDua7Phca12imF4K8uVVzfAwmc0qalchZblMxdnbaPf/Ke0g6vNBLbhU1RHFWkKerfJ6b4BBX8tD3kccRyORk3BG9RJO3Og67J7cCCrGiPvXg7aDiw32EwM3wanLDoikfJ4Q4YjMbXAnN/I/xJfBK02WkOwo15NcbQCtn0Z9zMiRwcDkAMDlJk2F
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 01:02:38.4191 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b73a2488-b9e6-4301-c5b4-08de848a0c99
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397B3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5835
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

From: Gaghik Khachatrian <gaghik.khachatrian@amd.com>

[Why] Compiler generates compiler warnings when signed enum
constants or literal -1 are implicitly converted to unsigned
integer types, cluttering build output and masking genuine issues.

[How] Use UINT_MAX as the invalid sentinel for unsigned IDs and align
loop/index types to unsigned where appropriate to remove implicit
signed-to-unsigned conversions, with no functional behavior change.

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Gaghik Khachatrian <gaghik.khachatrian@amd.com>
Signed-off-by: Chuanyu Tseng <chuanyu.tseng@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml2_0/dml2_dc_resource_mgmt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml2_dc_resource_mgmt.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml2_dc_resource_mgmt.c
index 74812a7d5e28..fd3c61509f1b 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml2_dc_resource_mgmt.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml2_dc_resource_mgmt.c
@@ -143,7 +143,7 @@ static unsigned int find_pipes_assigned_to_plane(struct dml2_context *ctx,
 {
 	int i;
 	unsigned int num_found = 0;
-	unsigned int plane_id_assigned_to_pipe = -1;
+	unsigned int plane_id_assigned_to_pipe = UINT_MAX;
 
 	for (i = 0; i < ctx->config.dcn_pipe_count; i++) {
 		struct pipe_ctx *pipe = &state->res_ctx.pipe_ctx[i];
-- 
2.43.0

