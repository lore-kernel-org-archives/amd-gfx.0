Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0526CF589D0
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Apr 2026 13:19:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9BCD810E0F7;
	Thu, 23 Apr 2026 13:19:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bzmK2tbB";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010031.outbound.protection.outlook.com [52.101.85.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B610810E0F7
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Apr 2026 13:19:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P4exjzLRMdGgwlJSIXt/nilTduvPvVVpx2NPOyIn+hot2gbMUM4rvVYvxiYu9DkB75FUJ3GSYHPnfUw5KEv7uS0tC1ijWj7uqQD8BAolVrAEWuzlNjGAPW+eEvsY70dJZ5NWHcxnlXb+uSU+4LT6HPdiDCjCiFeYWkJaTCJycKbtEVwpB2ml1qEN+8G9RjHfbHJSxXd0+lUW7GM5lxHHiSR5fcBWSAN7m8+FQlx7FXPVWfPIDcTUuzFJPwE61flrlzX9AvOJNlsORJRfTqyUvXFJSXBYzPy4AVik+oFkD1AL/JoKNtSVegGBWwLMO3Wx7QWrl4sYdgDoBx9RecnpBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZPZwlwjZS+2akTRGy7hRUjvnUsrjCFUL1aJEmDcG6jg=;
 b=Ro3mvjvgTUQoHbzngYiXfg5j8OyntB7SNNtXZFGB38h5bWYf7cp44fA17ohYdrGZ3bUPdHNZ0A6nssJTyRQdjEZrMKPNNGMBTvgFSo74CTm9D/TQFwo6Zd/m4u9uV1ulHwYBHYSbWQKsyrEWPJIfDGuHndHjDxaY6RJ5fRYZ8lEVnqhw1j2CZ2PKze2ueKgMJZ9soVVOL+eoIVS5Zh8HEWU5XFDLD90udZzXOJA2oR7BHJjil8QpthCu+QWe3a+T59jl/nxRJOT2cW/6gpxH+fXECX6dvSMYkPBRA6Kj2UMH803jfg8dN4+IP2MQrwSnO0kRrTWRhN8et6blCWYVVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZPZwlwjZS+2akTRGy7hRUjvnUsrjCFUL1aJEmDcG6jg=;
 b=bzmK2tbB56ZyOZydf94XlJexdVcQJ8kTjA5YmKCKrRiDcBKm7Bf87HDHflXpRFB4VoaCu22SGZ1Jwv5MaYY630U1FH3IEMnqgU6bj9nzUGE1RjOUQpPnYnQmC016o6gsRSHoyNn2YMFoFRXgYotRJVzvwo2+4wVch4WkliE8hdc=
Received: from DS7PR03CA0336.namprd03.prod.outlook.com (2603:10b6:8:55::20) by
 BL1PR12MB5969.namprd12.prod.outlook.com (2603:10b6:208:398::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.20; Thu, 23 Apr 2026 13:19:17 +0000
Received: from DS1PEPF00017099.namprd05.prod.outlook.com
 (2603:10b6:8:55:cafe::d) by DS7PR03CA0336.outlook.office365.com
 (2603:10b6:8:55::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9791.48 via Frontend Transport; Thu,
 23 Apr 2026 13:19:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF00017099.mail.protection.outlook.com (10.167.18.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Thu, 23 Apr 2026 13:19:17 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 23 Apr 2026 08:19:14 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Leo Li <sunpeng.li@amd.com>, Ray Wu <ray.wu@amd.com>, Chenyu Chen
 <chen-yu.chen@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Dan Carpenter <error27@gmail.com>
Subject: [PATCH] drm/amd/display: Fix divide by zero in
 calc_psr_num_static_frames
Date: Thu, 23 Apr 2026 18:49:00 +0530
Message-ID: <20260423131900.2441526-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017099:EE_|BL1PR12MB5969:EE_
X-MS-Office365-Filtering-Correlation-Id: 49cdb3ff-6fb1-48ee-6e79-08dea13aebe6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|82310400026|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: 5fmGilZDSKFsd+wO3jz+a+5s7ZaOBGOGtAA36VvjoeWpcHm9LAD9sxLaqqmN1epdrjXYcOJmaaY6B89qqIoLy20SyDGIbt8Jv88qz6bzsZJk1JoEP+O5sm5engxobHNtoiUoSpFfGPABGVhvhtmAUVB8xJ/mWHSLDXKxnt2bLJdZ0FDejdDjLPFrZ7xFKH4IqK+hWLR9MYvjcyy7XYNbpMYARn0ab5tiqhSXKkHU6qOPeXNA/SQDaRteE/yVbWWrFT7hPfv1gJA7GpqVBpKXHItEizJ0LsZe31+yDCm7T8EJovknmBd8NLets4DdQDwnv295I+c1CBJVfM1h5KnWtZBiOzAOMkHDAHoT1aSnOVTbRMuB0/GI2KCPllpzCVSovpOUhmmYOXauBQmN0z/PnElrWEmBQBT2lLj0/dt4+yik1GiVA0cm1F3s2PzXZlMayu8uokofz8Mokw3PWoPlQublkLyO4miGVD7pLype/OOUrMhn8XlbrpcB/3L7zp/VoNq2c8C+gHw5wH15o7fQurRAB04LYoqRwXu97Nam0gD/wl19P+cFVDNNyrLJZUk9N9MpmHkCKhRPghHC6CWm3hjMzwvr6rfo/I4QrYuXskTQxgAiaspGerlwG1eBlKeT3sE5mgsTZ89b3EMy0Fe6v/FMsNd8rBQJkqyzDpW/bmxsHZyl029iC+1JiC88OclCm8OiO7W8/CaMCG3C+g/xeKDckKWUMzHuDBgQ2Ab5hcs1uMzLKL/LuGRlQeuZy5PtQZLzj/eo0SHM7ifqboM3kw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ptXDqrNR2Ic4ZeY51htwp/pOD62Iq5N3BXLU16EYoaoocKU0wMQ6QPpiPsuriNDEv/qHSb84Q5s/3RZlOHp+S2h0eDf87nO1em0dtFQal4voU0FOVuanzbfLOAlyeePcl8PDMlSRIHbcHtB6ngImn6K0mHTDWp7qDx7+fNAM2K/3rfyDPX/XZ/PQitEYvzdzsq/vbKQ83mU//FK05Si2+KHJkr6cYI+wJCo7YSO1ujs+hTbWhlgbaX/WlEosN4dj22cXcbZW7epIXmJJcTLrF6Oy0TTLHuD92hs61FTB9wOQO1mwv+bx7yumS22pj6M0et10VLQaprAU1jUevSN64T09MEeTIaoUhTOsNw68kupxlfYVIMhe+pwX7+KgevG9XR66xWZofts5+g1Gkutazds2jKjHa1Hwy8N0ciyCoVNTNVv/QfnZZ/3e/g9Ox2TJ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2026 13:19:17.0318 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 49cdb3ff-6fb1-48ee-6e79-08dea13aebe6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017099.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5969
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

calc_psr_num_static_frames() divides by vsync_rate_hz before checking
whether it is zero:

	frame_time_microsec = 1000000 / vsync_rate_hz;

This can trigger a divide-by-zero bug if an invalid refresh rate is
passed in.

Rewrite the calculation to directly compute the number of frames needed
for at least 30 ms using DIV_ROUND_UP(). This avoids the invalid divisor
and removes the temporary frame_time_microsec calculation.

Keep the existing fallback behavior of 2 static frames when
vsync_rate_hz is zero.

Fixes: 55676843f4b3 ("drm/amd/display: Introduce power module on Linux")
Reported-by: Dan Carpenter <error27@gmail.com>
Cc: Leo Li <sunpeng.li@amd.com>
Cc: Ray Wu <ray.wu@amd.com>
Cc: Chenyu Chen <chen-yu.chen@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/display/modules/power/power.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/modules/power/power.c b/drivers/gpu/drm/amd/display/modules/power/power.c
index 6c73fecf57d5..81d15a51e045 100644
--- a/drivers/gpu/drm/amd/display/modules/power/power.c
+++ b/drivers/gpu/drm/amd/display/modules/power/power.c
@@ -157,20 +157,14 @@ static const unsigned int default_dc_backlight_percent   = 70;
 
 static unsigned int calc_psr_num_static_frames(unsigned int vsync_rate_hz)
 {
-	/* Calculate number of static frames before generating interrupt to
-	 * enter PSR.
-	 */
-	unsigned int frame_time_microsec = 1000000 / vsync_rate_hz;
-
-	// Init fail safe of 2 frames static
+	/* Initialize fail-safe to 2 static frames. */
 	unsigned int num_frames_static = 2;
 
-	/* Round up
-	 * Calculate number of frames such that at least 30 ms of time has
-	 * passed.
+	/* Calculate number of frames such that at least 30 ms has passed.
+	 * Round up to ensure the static period is not shorter than 30 ms.
 	 */
 	if (vsync_rate_hz != 0)
-		num_frames_static = (30000 / frame_time_microsec) + 1;
+		num_frames_static = DIV_ROUND_UP(30000 * vsync_rate_hz, 1000000);
 
 	return num_frames_static;
 }
-- 
2.34.1

