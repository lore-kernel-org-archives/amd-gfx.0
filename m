Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26E66C54ED1
	for <amd-gfx@archiver.kernel.org>; Wed, 28 May 2025 02:54:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD64D10E56D;
	Wed, 28 May 2025 02:54:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="38sRz5X/";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2061.outbound.protection.outlook.com [40.107.94.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2912610E56D
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 May 2025 02:54:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sAUTYAUDkOEWHFIAL+IXvwHALg33LmQ9sAlBH7dHftu3gwhOnRX9q/kFu9GUFsEdCWRQfbOU6yOYXvXhFzRgwPFj/9AOhIXWB0zZ2b4s42iFWPfoWt+/fpzI+fAe9Kb32JeFoaspiOMEgeBMIsgU08LylMidx0g9yFHaOwW2iLD8QiOoiMKsE8FjqEctrL3CAWBAAEMgIM9eob+ZqhQd0b7YIsNWC2YTCNjEM6P1MYqvtITtGp4NEkxxUWJeV57L6bbaoFGXy3yQO6h3LZ413e3AXuU1/w6lx2gi8OZuQCGks5eUOccJJj8xvtLappr6qZwSImml9roEe2GhW3Xp6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=16m9awCbnm1FXCxrvhmcxWVxfq5p8lXASHRwpz03Snk=;
 b=EV4pqZJwjZGrv2u/6s2jtK5xgkMcGU7p0XfoVPZtVTBbqnbnlRKNvOKr++04jlQCJNsqXrnZKgj0tliU3QaPXz45O11KeOb3KISaxUszTiPb97JwSnuYSgRhBsKw3buWLkPjYknwCsqGSMYe+Fu4rcy9mGSZ6D3u9BK7DHuMmpHpGQ5q+wWGYdlOpSJoRChRQg+G9SrOGOlShqZjmUw7VXw8btU7/TXHvxbR+8liJXYHPxkLEk20yxfvaEOOZlUbI6elV51FTf5a/BqCv4AmuJc3cE9I8V7s9So+AOsuq7XEKqi8CuhTZ/Buekh5gOkteKTYPtYFdGg608yHtu4G+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=16m9awCbnm1FXCxrvhmcxWVxfq5p8lXASHRwpz03Snk=;
 b=38sRz5X/2XTp2Yw5QzKFhbAnBv+Yz+rzH5pVKYHa2yJqAATdGv5nvwkZ1YOjQJOufxKKtPehWwGd93fJmHSemNiyUtrSWxQksfPDnp6KkRwUTLt9/YpqbILEDOVZ3rfqLg3ULHQDwpKCYM+8uN5mOf42aDVdMZ2DL3UfPdFOtA4=
Received: from BN9PR03CA0763.namprd03.prod.outlook.com (2603:10b6:408:13a::18)
 by IA1PR12MB6043.namprd12.prod.outlook.com (2603:10b6:208:3d5::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.23; Wed, 28 May
 2025 02:54:17 +0000
Received: from BN1PEPF00006002.namprd05.prod.outlook.com
 (2603:10b6:408:13a:cafe::9c) by BN9PR03CA0763.outlook.office365.com
 (2603:10b6:408:13a::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.18 via Frontend Transport; Wed,
 28 May 2025 02:54:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00006002.mail.protection.outlook.com (10.167.243.234) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Wed, 28 May 2025 02:54:16 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 27 May
 2025 21:54:16 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 27 May
 2025 21:54:16 -0500
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 27 May 2025 21:54:11 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Alex Hung <alex.hung@amd.com>, Mario Limonciello
 <mario.limonciello@amd.com>
Subject: [PATCH 22/24] drm/amd/display: Add debugging message for brightness
 caps
Date: Wed, 28 May 2025 10:49:17 +0800
Message-ID: <20250528025204.79578-23-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250528025204.79578-1-Wayne.Lin@amd.com>
References: <20250528025204.79578-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: Wayne.Lin@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00006002:EE_|IA1PR12MB6043:EE_
X-MS-Office365-Filtering-Correlation-Id: bb955644-79ec-49f7-27ca-08dd9d92efb8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?rPgT4BnncV+XTAW6nNP3QYdZcFpi7Hp1HurjZqTT6ow6vrPq3LK3gVU3yV16?=
 =?us-ascii?Q?Du4P1psZGgt4Vvz8MNFVgEEe23a2lrEFLgD5kmqSLT/DIkNWZn2iJFlip10g?=
 =?us-ascii?Q?ZeU4ykbKtNeapejR45/qxYCCd2EVzQhJhbzsdrTSvS8RV20ULz0WSbDQcu8j?=
 =?us-ascii?Q?ZD35mfJDNJnW1/tCfc0SREp/kwYkKKzWVzJB2F4fmTmfTPOUbApMTdBmY4WK?=
 =?us-ascii?Q?WNnBkJYuBx5yTT5EkrLm4AJYt6Shhzk98dLoc4JnAtIR/IrVtEfvN7NCLokx?=
 =?us-ascii?Q?K89/Ptp09kTjMj4BUreyr8VLka6SymV4s4pAbDuOglKr/X4X8sSgQL4uVYQc?=
 =?us-ascii?Q?W/IJr0vZBqvJL7gPj4UWBQ4C2xGt/aU0yCn8bwwkuUpUmVJ2LTDsUfnHtiW1?=
 =?us-ascii?Q?Cjp+0sKBhROAFocBjJ1D6MUiiS4Ht4R3xCs3uBO3a2CvRF+vD6UNpvtzOVr1?=
 =?us-ascii?Q?pdy5D60JYnXltMtAABmw2Wd0I5V/aHqMEF1MsU93dXwlBw3w9zvsyqowtMsX?=
 =?us-ascii?Q?FAkQ6O/to9OSgY7r7IAIvC/m739TLHTCrFO6porSMhqgjuAHuhFd+4s9kRTf?=
 =?us-ascii?Q?hq+GYIrsVGvaktdKln8NPb0g/EY0FuzA2iPhIlkFRgfH0/GssOuLh5IavYsS?=
 =?us-ascii?Q?F+yJWsq/BYpsAHgWCXFYAMLxX0cHZW2LwBbCc54tOgGZSZF4qaMy6pmOA6R/?=
 =?us-ascii?Q?1EXXEbUI+BEIWUB6V2rHoHFG2GS/rkApWtyq9csXJVJs+b4PBMakEPsQGWyj?=
 =?us-ascii?Q?MUXxtSaXFPb+/Gc3FkIg6uJZEzpEAiDI5TUI6LGknOpnJCvqo0Lvo3CkE5Fs?=
 =?us-ascii?Q?gbWLv6mJIO9OJAU70gBPhOK5zvgNDsxbfc5QX87zIocXcGnGH/hinPSHyVH4?=
 =?us-ascii?Q?2sPRkFYc4XBruPIhkjxvxGTm17R+PTz9yaN2MlPjdfr3d5d8wPbdGV0Q4VJe?=
 =?us-ascii?Q?6lOjRK8C+oHDarZoM0Qc3ANeww8l+F80nYCEiF/T2DPRax2IOQiMx38Ko/8u?=
 =?us-ascii?Q?xSqq6hbRE3yoCdKjjhVO/19KEssxtwkk1ZSwWXa98LbQIPIlB5zcCmq0swpl?=
 =?us-ascii?Q?U8Rpeq+peRt3EejhNE3KtAVBjIDmiayg6WuFTkE9+/nrGCEf95x+Hne5fdrd?=
 =?us-ascii?Q?C1Jql/UvXBZmjnS9QL+Aza3l3+d3oKj0LsMVLA5fOv2sGqDlcuDiCLmmfn1e?=
 =?us-ascii?Q?TdHKwalxcHmkBOxD6AYRwf0kVajf+HKfWRYUgnfQ9qhacghFqomYU29ZhQVf?=
 =?us-ascii?Q?p/lhdLSCyFwal2meWNcf3mHnVmu7zpiuPEtyDQtsclpvvjisAG2X7HwomPU7?=
 =?us-ascii?Q?6QNrpEjnHDOHfFbmg68K2BPQMgOBSlp1+lxb92Qshw/NUIkf+/NcyUV+U7n7?=
 =?us-ascii?Q?YJhyN2NVR6HX9lH/uBSW7P0Vejd948MCBB6M/EoaCFQGt3mg94XknV2R1OLi?=
 =?us-ascii?Q?YPNdbwuqKHSSdrtkaaW+Hz5xaBxmZLqJK7Pfmf2IqaND0eEUBigWZMcUPYaA?=
 =?us-ascii?Q?00Ml1sbwh2DRMf/kQNKzRBAt03JRna6sFq05?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2025 02:54:16.8653 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bb955644-79ec-49f7-27ca-08dd9d92efb8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00006002.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6043
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

From: Mario Limonciello <mario.limonciello@amd.com>

[Why]
Default BIOS brightness caps are buried in ACPI.

[How]
Add extra dynamic debug that can show default brightness caps.

Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 0ac42ebbd405..0d9a339d12eb 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -4911,6 +4911,7 @@ amdgpu_dm_register_backlight_device(struct amdgpu_dm_connector *aconnector)
 	struct backlight_properties props = { 0 };
 	struct amdgpu_dm_backlight_caps caps = { 0 };
 	char bl_name[16];
+	int min, max;
 
 	if (aconnector->bl_idx == -1)
 		return;
@@ -4923,11 +4924,15 @@ amdgpu_dm_register_backlight_device(struct amdgpu_dm_connector *aconnector)
 	}
 
 	amdgpu_acpi_get_backlight_caps(&caps);
-	if (caps.caps_valid) {
+	if (caps.caps_valid && get_brightness_range(&caps, &min, &max)) {
 		if (power_supply_is_system_supplied() > 0)
 			props.brightness = caps.ac_level;
 		else
 			props.brightness = caps.dc_level;
+		/* min is zero, so max needs to be adjusted */
+		props.max_brightness = max - min;
+		drm_dbg(drm, "Backlight caps: min: %d, max: %d, ac %d, dc %d\n", min, max,
+			caps.ac_level, caps.dc_level);
 	} else
 		props.brightness = AMDGPU_MAX_BL_LEVEL;
 
-- 
2.43.0

