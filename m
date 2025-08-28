Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81B90CA0EED
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Aug 2025 09:21:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2ADDC10E95C;
	Thu, 28 Aug 2025 09:21:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kGGhT02I";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2065.outbound.protection.outlook.com [40.107.236.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2BB5110E953
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Aug 2025 09:21:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h8HRelsfNIPo7vP323/bGYciBfOZXWTOIKb3oJzxy0RXZIgZ+bQFZgGyJw0uo0/+PhYguEnXysJukcskaWw5KEAXjc/191Dc1YM/WWC0/4fsk9MczueSYJG5Z0DC5WxfMfCg+yhJXhD+AW8YaxwFRxoEh7t0jjNNwqwTCci/RfeCoulQ+/9wjCcdASojNaAX2u/7It6Vjvpxoq7aiI9xFx1vRwE1K2P7OZEZUFJNpdw6Iegw31G16ZnWGSsj3/YlC7sffPYapiapAEHmbGXvBbGjHVhZj/bM06GB8QW9hyuAQVnXTa7FyoRb0YbRNL5pVOsVjGWInnm+76bYrTlzEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9bkK/PSa0eWhTWxZbQflOCEmAExpUEoGTNAKGy/cuiA=;
 b=f87hggABJHuDYikYHkl3oAzhj2QPzoLH8sTRyAQIQkZ0qFC7XwhfbOZd1fDwH3iEhT07tzPixRgh9KB0v5MzLQBKOAzUWV51Tdy20AtmUr6SDlDoeayrP1unF5epWu1d2TMQTmncV9XeiM89zcYjhcZv4qBqpOOdw4WcyRbbbtGd3zdEdE857rzOrrmroctuVXhNKAgnQER/XM2EL/JnKt+0suDKZgqrBv+KdJGkukWHAeI9x+A9CLxEgOeydIQQrCzkLco8ynLbg180D2sf26DqCM94br8e7ad0GMb65MWJnyCEbz2VLf38O36TJpcu1auE3kygcyFiBeKmEtuKpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9bkK/PSa0eWhTWxZbQflOCEmAExpUEoGTNAKGy/cuiA=;
 b=kGGhT02IjvKlTWNyXb+XIdsdgSqXdr+u+/AuhAISHinfcxggqAVrGVzk117Jwcg9Aoca4v0Kcic5xlZAJ6DyYW1qNc/D4aJ2Vidf7lusIp+gjL0W1cmyTFX4wf5nzdqlVKyfjtiW5HNoTenD8rE3frjg5/rNTsPOMzf+pomtenI=
Received: from BL0PR02CA0011.namprd02.prod.outlook.com (2603:10b6:207:3c::24)
 by LV2PR12MB5775.namprd12.prod.outlook.com (2603:10b6:408:179::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Thu, 28 Aug
 2025 09:20:58 +0000
Received: from BL6PEPF00020E63.namprd04.prod.outlook.com
 (2603:10b6:207:3c:cafe::7e) by BL0PR02CA0011.outlook.office365.com
 (2603:10b6:207:3c::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.25 via Frontend Transport; Thu,
 28 Aug 2025 09:20:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL6PEPF00020E63.mail.protection.outlook.com (10.167.249.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9073.11 via Frontend Transport; Thu, 28 Aug 2025 09:20:58 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 28 Aug
 2025 02:04:35 -0500
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb09.amd.com (10.181.42.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1748.10; Thu, 28 Aug 2025 00:04:34 -0700
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v3 3/9] drm/amdgpu/ttm: Add New AMDGPU_PL_MMIO_REMAP Placement
Date: Thu, 28 Aug 2025 12:34:14 +0530
Message-ID: <20250828070420.3948568-4-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250828070420.3948568-1-srinivasan.shanmugam@amd.com>
References: <20250828070420.3948568-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E63:EE_|LV2PR12MB5775:EE_
X-MS-Office365-Filtering-Correlation-Id: 38f536a0-7421-4987-4627-08dde6143300
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?S21yRE5INUQvTGxYYSsyL2M2WVpSbGRINmFEZUNBUGF6NXR3eVhuc0kxamtH?=
 =?utf-8?B?ZCtCUW9ZYWpidm1CSUdZT05xN3U3S2hYaGxsYWN4THZYYXV2Y3IvTlZSeFNP?=
 =?utf-8?B?WkhPMlJCMmorWW1od01ObjIvNHZSMmtpdnJTdVF1bk1wVjQwVTkvcmRIVmNZ?=
 =?utf-8?B?MjQwRmVBamxhY2ZVTyswNXRCTDUwMTNDc2pGbStyMVp4SnJqcnN6bmVTR0JH?=
 =?utf-8?B?SDlxQUUwN1FYWDVKSW9OTWFVWjFnL0hsODgwYkZwSVNtc3VaOG05ak1yRTBy?=
 =?utf-8?B?b0RhSzVWS2JObGJEVlJTSDY4dEVwbHA5MzhQRXpzWi85TWZJY2hnUGxoOVJR?=
 =?utf-8?B?VjJtM3Z0cjhsRWc0VTJXaWwzeUpjbFh4V3VyWkRZY2ZjYkpGYngreldTeVNw?=
 =?utf-8?B?RlYxbUswSFgwVnZlVUphNTh2VXZwYmp5emFwbUU0L3JLQmhlWGZ3aTVleGpt?=
 =?utf-8?B?OHhXVm9RSUVwSlBpbFVsTnFKbUJCUDU5Y2JWN1VaNHpkTFRqYy9RdUNUQVYz?=
 =?utf-8?B?S05UcWFYNExRcnRVMXhNc2FwWVRsMExiTjJMcStuSWtQb2w2azFWK01Mdkwr?=
 =?utf-8?B?UHVhZ1RXV2Z6bjVaaXRkd0dTUFNTOStNeHV0ek92ZVRkWWJicmNIdDI3N2Qx?=
 =?utf-8?B?SXZ3ejB5djhSeDFobjl1WWJSRjRQejZ1V3hmamROQzhERXZvTkE1bStNai8y?=
 =?utf-8?B?YXdoeWJQQ2NiVkQzaGdoL01kb3Z6ZlA0VTdVa09OYnpzbzFydkI3MHllZksv?=
 =?utf-8?B?U2RZR0VVQk1jY1hqTi9vcDduSVZQcDl6YkNMRVR1TDVSaHJnby9CbUwvMVJZ?=
 =?utf-8?B?TGw2d3NZRlAwOEZxcWpmWG9NSnpNT3F0REd5djQ0azJPT3lza08vektBTHVk?=
 =?utf-8?B?UTRYRHdZT0RzWmN5NFRqR09tWk52ODV0U2FrVkNVSjJzY2hpeE5DWW5jcE5m?=
 =?utf-8?B?Z1B2UFhmbUltS1k0S0NWV3FzbXZtTjZvbmxBRWZzcE1GR3FUVDJUeWR3Ukw0?=
 =?utf-8?B?SVdPek1yNDdyYkE3MGZuNGtadThqMmpBR05yVnk2cnBpbEZZd2lkc25oRVFU?=
 =?utf-8?B?M2N0dTk3ZXl1dmlMdG9tSTVYRXl1VEdqWGlFTElDSXdrS28zeGhKbG8xM29F?=
 =?utf-8?B?dTUrVkFWVEd0L1BNM0JlYU1xZldRRlRMNllsaDJKV1FoQ2dkbDVzdnd5TW1L?=
 =?utf-8?B?R3NSeXFzMUJHb0hLemlNYXJpNTVhREVKL2dBa0toUmVIMjdEWmw4OUdHZUdL?=
 =?utf-8?B?SzJaNTcwMkdMWlZiMlZ3MTdwS250SkV3cnlmMml1UnJLQk5hSElmOFBJOVZE?=
 =?utf-8?B?TnpjWmo2VlpJMWdzRGFmZDR3WTNiSmxmRmNtblBvaDR3YnhRS21rVmIwT25x?=
 =?utf-8?B?ZVZSNGRvUWRzZnZEaWg1TXNScXBPbVFjS2dVbWdWM01oeHVGTkVYa2lhcUpY?=
 =?utf-8?B?WEdLSkg2ek5LWWw4aWV3Z1NTd1p5cExnaDMvd1RWT25yd0ZBdHE2VkhwL0ZF?=
 =?utf-8?B?NU55bElPR1lvQzgzOVdFQ2VjK0kzK2VBM3poSkkxQlZiV3R4bnhpK01CS3hP?=
 =?utf-8?B?ZDFOSWdUakEvbitTR3NEb0VEU1laUStvbG9va0pnM2RJNVU2M2FZeitmOTFp?=
 =?utf-8?B?RGVDOTVodFhiS0YrTmFjbDhlclhMOGw3cW9jZExNRG9yYnI1ODlOY3IzL1ZB?=
 =?utf-8?B?d2dxMG4ybGFqclAydU0rYTVzbnBicFU3b2xTQzJXRUt1b3ZqT2IxZDFlaU5s?=
 =?utf-8?B?OFpDeXNsamFJcjJXSjJZVVl4SjEwL0xzOWtJMlZCTGxUT2xDUmYxenN2Z0dx?=
 =?utf-8?B?U3I2Y0xZZE5Oa0ZiMWdUWDg0WEpHRTFYY1BjYWdGdEdaZkh5a1NxQncwSnFi?=
 =?utf-8?B?eTFYaEQ4ZEVxL0cyQ3hvOHZ6OUY0U29nYWJ5ZW54WHlBMkp2SThWT3dYT2xM?=
 =?utf-8?B?U0UyL3RMVUpiTk52cWtoMzVWZnNOYmNEcHlOZEFOcmpNK0RtNytZcjA3d1gy?=
 =?utf-8?B?OFpEMGZrc3E2QkN0MTlLWXNjZ0xKTUgrU2hBb0kzSlBUWmVaRUpaNFRRYS90?=
 =?utf-8?Q?dS7Shv?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 09:20:58.5429 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 38f536a0-7421-4987-4627-08dde6143300
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E63.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5775
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

Introduce a kernel-internal TTM placement type AMDGPU_PL_MMIO_REMAP
for the HDP flush MMIO remap page

Plumbing added:
- amdgpu_res_cursor.{first,next}: treat MMIO_REMAP like DOORBELL
- amdgpu_ttm_io_mem_reserve(): return BAR bus address + offset
  for MMIO_REMAP, mark as uncached I/O
- amdgpu_ttm_io_mem_pfn(): PFN from register BAR
- amdgpu_res_cpu_visible(): visible to CPU
- amdgpu_evict_flags()/amdgpu_bo_move(): non-migratable
- amdgpu_ttm_tt_pde_flags(): map as SYSTEM
- amdgpu_bo_mem_stats_placement(): report AMDGPU_PL_MMIO_REMAP
- amdgpu_fdinfo: print “mmioremap” bucket label

Cc: Alex Deucher <alexander.deucher@amd.com>
Suggested-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
index 2309df3f68a9..bb17987f0447 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
@@ -34,7 +34,8 @@
 #define AMDGPU_PL_OA		(TTM_PL_PRIV + 2)
 #define AMDGPU_PL_PREEMPT	(TTM_PL_PRIV + 3)
 #define AMDGPU_PL_DOORBELL	(TTM_PL_PRIV + 4)
-#define __AMDGPU_PL_NUM	(TTM_PL_PRIV + 5)
+#define AMDGPU_PL_MMIO_REMAP	(TTM_PL_PRIV + 5)
+#define __AMDGPU_PL_NUM	(TTM_PL_PRIV + 6)
 
 #define AMDGPU_GTT_MAX_TRANSFER_SIZE	512
 #define AMDGPU_GTT_NUM_TRANSFER_WINDOWS	2
-- 
2.34.1

