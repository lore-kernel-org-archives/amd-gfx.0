Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A67BC531DC
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Aug 2024 13:36:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF95410E835;
	Fri, 23 Aug 2024 13:36:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VSvfCdh0";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2043.outbound.protection.outlook.com [40.107.243.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A1ACC10E835
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Aug 2024 13:36:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PSV/PweteeoEv9AYutlqrisgN7HoWblhGnhqaoBWr4IhXjO2fKyQys0ueEoXm+Ens4Z52TFfJRNDlywUXi0JHbBOgVqdz6nk8NirhRJUgVUGteik7zrsnke/yDwE/uIpAcIZvy/xsMt3D4SmAre6krXAT6CSUTAfLyuFNZ7wsxmIwPmiRglU0eptqrFx6USFYGyOMzwrQxoRAGN2koGnOXPfsn5c9JKN2BEioIliKXMM5Y88OeO7Oy1codpcioAO5Rpl6g9sDjovrdFtCYm00EplO0BIrSMkWZV4Tyg3Hx4FIjD+hcu6Q0Rl4SorkuiPPfujwvBQ4mUjC8CRnUxSlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dJ1G0CkarenHKOlhXCesikfjHaF+WBC30IY4+8jTWwc=;
 b=WvHNBTDfoVshjQa1MjiOWssVlmfHvH3S3zGCD3piDb2gWmv1QwJnTP4T8TZctMpWA0oh+JRnjX9oxqRuNYKZoC34D+4znjc0VtSD5B3dC/U3L6WkOOo9f/TKp4blTeotAYDisYPvPawZUmc9Mo943wUuX18BwVuGnrowCCUBUd7uq8zDYypyxBxlf3O820JWTjdS+j/NWxxSH9zuOP1dNeF+f15sXPeged7hXhj7bSfKFWMEgKiIrmyR9lD3yVIy+VQZC4bCFBFPfNB+hzsPYJ2ve/qwb+Kt8KouIxk49ZR4bijJrsUKLqQwDwaypIXFZ/DvE7DK9V+8KHwUnSvbhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dJ1G0CkarenHKOlhXCesikfjHaF+WBC30IY4+8jTWwc=;
 b=VSvfCdh0x1AqNVuH0qjfVU9ft8Zs1/r3gqwbwQVeYIuocxBfRa2yPQhqcmDJJtfio8H6rR5PQEcUwHD9wLiyTlEc0VFrtgVdyze5R2uMsFpBg9RLVx4OKj6QS4ZUfabYfpyhV9bGOwRHAUhxRjjPjNJtLDm6Fgy+9t2gsQyMFz4=
Received: from BN0PR07CA0022.namprd07.prod.outlook.com (2603:10b6:408:141::14)
 by SJ2PR12MB7865.namprd12.prod.outlook.com (2603:10b6:a03:4cc::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.19; Fri, 23 Aug
 2024 13:36:29 +0000
Received: from BL6PEPF00020E64.namprd04.prod.outlook.com
 (2603:10b6:408:141:cafe::a6) by BN0PR07CA0022.outlook.office365.com
 (2603:10b6:408:141::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.24 via Frontend
 Transport; Fri, 23 Aug 2024 13:36:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00020E64.mail.protection.outlook.com (10.167.249.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7897.11 via Frontend Transport; Fri, 23 Aug 2024 13:36:28 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 23 Aug
 2024 08:36:27 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?q?Michel=20D=C3=A4nzer?=
 <mdaenzer@redhat.com>, Arunpravin Paneer Selvam
 <Arunpravin.PaneerSelvam@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
Subject: [PATCH] drm/amdgpu: always allocate cleared VRAM for GEM allocations
Date: Fri, 23 Aug 2024 09:36:12 -0400
Message-ID: <20240823133612.719681-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E64:EE_|SJ2PR12MB7865:EE_
X-MS-Office365-Filtering-Correlation-Id: f6f49ba5-364c-4552-369b-08dcc37897c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WGIrSDZwTXM5YlZKZkk5cXFEcUlGT28rc29seDR0L1o1SWptRkJWc0ZEb0dI?=
 =?utf-8?B?QzI5NFJ2WHFkZ1JRRjRRQys2bUJHcVlTV1dWYXI3UHBlSFloQnhDOFl5S1BS?=
 =?utf-8?B?RVRkZEdSWk1LUCtWV0tBWEsvV1laK2xDb0M1RGtXeCtCVmFmYWIzSzA0MzBP?=
 =?utf-8?B?NHI4aTcvNXZuaGt6eWdhVG93bEh5dSsvS3psUjc5OWdIT3hieGFWMG9iQUQx?=
 =?utf-8?B?Z0lyd1E2RnJqTlNYeGRiKzk5TVh1N2pjRCtKTGdac1NOOGtYTjBlbWRpelk2?=
 =?utf-8?B?Skx6ZDJsbWxzVTVtZlV3aG81VnBVbDI2R1p1QlJGY0pkZnRNcC9kZE04NlY4?=
 =?utf-8?B?Rkx2TVJ2eHNZNTVmcGFndUo3MEljYkFlQ085bjlnRkEvcWV1bVFyVWdybWNV?=
 =?utf-8?B?U0pvdmVoVXJxY0lYVGlpS3FCUTIzMkc5RVF1UXN3VlA5RGN2YnFLK1FiVktm?=
 =?utf-8?B?aHhpdWNOdlc5VlRaRXlxVFpYcDlRRlJkRWphcElxRmFkeHozL1RkV1FUNk5I?=
 =?utf-8?B?RzNBYlNnTms3VWZpSXBydXUvMXFicVJYTlVSR2g2VVE3S3FVbXBrQms2dS9a?=
 =?utf-8?B?bTBSN3lQeS9rM3NtN09EbnFCU2FhbW1tWmZIRUhQY3ZIMXgxT0hCazF1R20w?=
 =?utf-8?B?TUJneEZiVUw3ZW5TdXJwRGdBTVRzeE1xWlBIdk16OVlhRGdyaVVjbnJzMThU?=
 =?utf-8?B?MEtUZFl4S2EzYWpnd1pJTko4STJPS2pTelBHTjhYb3F4UmplQkpmclRCSUQx?=
 =?utf-8?B?b1dMMG1mZHRBUEhWb29WeVYxSHdiQVpFbXloUUxzdlFpSStuMitpeUI0MHVE?=
 =?utf-8?B?NWpob1VOTzNlYlEySUhRWldVMExSMGNQanh2U0d1Ni82UjJZZnNDTHlxUytZ?=
 =?utf-8?B?MnVZaVFTUXdmUFJzUWJpViswTVhxWkM4R3Fwa1d4K250UFlsVVlWdHFjaTZL?=
 =?utf-8?B?OW5rdTEwLzE1N2R0NUtPY3IvaG1zSloyMlJ6MzRuU2pMYy9UMXVSZlByZUNF?=
 =?utf-8?B?TDRaVUtQL2VZRFpscmhtbjV2N2JadGt4NS9ueGEybzFZanB0MkFWekl2NUtj?=
 =?utf-8?B?Rkp6VDdndk1adTg2b1VaTWk0ajRYT3NmVHFpMzRLSXBFdWdCSkpDNmZDVzJz?=
 =?utf-8?B?amJVOWh5UnYwR0xsYVhMdGFoeVhRZngreEI4dFNXenhPM0RjVzZLT3ZOM2Qw?=
 =?utf-8?B?L3NRSm5XQ3l5ZXI2TTk1d1ZyVWpmL25FNmluK050NytIM2YwSDl1MTlEdkNj?=
 =?utf-8?B?NC9TY1JHTFB1WmtzOVg3MVVzdkN0M2s1VkpNR3V0VE56SkVXVTRuR1R0UFBX?=
 =?utf-8?B?bzJGNEhnVFp0UTFzNndMb0ZmY29oRlFLMGUyTVpRRmFSRG5WSzJSQllIUEJE?=
 =?utf-8?B?L2J1eGd4SEh5WGZhMnljZituMlk3MHFLdWw2ZTVYL1RvbWNxSlZwcm44amkz?=
 =?utf-8?B?S0NuaW5sYmJsekwwUFB1ZHdxaFU3NWtLQ2tjRURVS1dLVXovU0crR0ZGdm1y?=
 =?utf-8?B?NmlwRTRxcEhOMExiV1h4N00vcWFpam80L1FheXUrNXJmQy82Vnlja0FHZmFh?=
 =?utf-8?B?MjdGS2JDVHg2WnlWMXRsOGd4N2d4SzkxL2wyblhhWjBhc3U2ekdFYjB1VXk5?=
 =?utf-8?B?MFROUVJJZ0Z4SCtPek9zeVNEcER1UFkzNmo3Uk5QdTBGQ0pLQnhKMlBhQ0ZE?=
 =?utf-8?B?UUNoTC9Eck9BSUpOamV6MmcraERqRjFuMGUrSWlnbnlDUVZkS3hhRy8wbWZF?=
 =?utf-8?B?UFpSZ0xEWlRja3B3R004eTFrYWRJYnFOc08xRkxwMjNGS0MrVXNTVmxpa2Rq?=
 =?utf-8?B?UkpEbWMzdmMydVZ4aDR6OWNWNWlaYmI1cXcycHZvYythSmI3TnM2TTN4cGJn?=
 =?utf-8?B?d2VLMWFCcXQybHNtZ0oxejRkd3N5dzY3cjcvYkwrNkJuNWc9PQ==?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2024 13:36:28.8853 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f6f49ba5-364c-4552-369b-08dcc37897c4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E64.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7865
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

This adds allocation latency, but aligns better with user
expectations.  The latency should improve with the drm buddy
clearing patches that Arun has been working on.

In addition this fixes the high CPU spikes seen when doing
wipe on release.

Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3528
Reviewed-by: Michel Dänzer <mdaenzer@redhat.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
Cc: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index 1f149c9e2177..16af465f1c01 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -349,6 +349,10 @@ int amdgpu_gem_create_ioctl(struct drm_device *dev, void *data,
 		return -EINVAL;
 	}
 
+	/* always clear VRAM */
+	if (args->in.domains & AMDGPU_GEM_DOMAIN_VRAM)
+		flags |= AMDGPU_GEM_CREATE_VRAM_CLEARED;
+
 	/* create a gem object to contain this object in */
 	if (args->in.domains & (AMDGPU_GEM_DOMAIN_GDS |
 	    AMDGPU_GEM_DOMAIN_GWS | AMDGPU_GEM_DOMAIN_OA)) {
-- 
2.46.0

