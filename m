Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91C2CCA0EF8
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Aug 2025 11:33:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DF55E10E6FA;
	Wed, 20 Aug 2025 11:33:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qgkaP3nq";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2052.outbound.protection.outlook.com [40.107.243.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7078710E6FA
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Aug 2025 11:33:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MCc1p2RSsJY8x0CibkfcbNcLMfNZqHB2p8W0EoZPTL9gRxvDC7Fgc1Dcmii4zThJERWvG1EbmDYFJRp79Y5xF5n7k569uoCZ474mQcmWCH8OlshdRCiKW8J9Li+XZW/TifPxz/0jaDwrl4Muige4G2FHsYgRXYtyoS9TolfvfF9G36jYVpLlWLQlZXWHoABT+keXrROqShay2CjuvfRbIS9xzZAXsAueN8bKzIv4V3XA+WKD32CnyMOkpxkpv/XnwY37zPOn3subq5kBFkSmHJi4rMlB8oXtp9tWOggt3/2BZPbyfoltAG6KWFLek/ighp/8cw5ZVRkPi4Dx40jyDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bP0ncrUN7AvRFd7NA91zkjDnHuoNPWLrT6dUQmYuLYY=;
 b=g1R/UUL5Wm03wvxt6OW24zDCc+EO8yiEhKrKQx3NPDfjR43rKBovf7s0le8/MKE4eFgjx7ZNOqlXotXLM4G98MzKvJwYMzJIf384YfIZbjdbWXG502VPj1DsyOtR0BVUwvtj8AQC2kRe7jqzE5BhhpAo+d5nAf/XoNv7SSYZSQbdKj0HzV8qH1g+eUAcR6nR87v5peEBSQcyU0l405WiSNKdVlOCJbFBcTj6juKUbOq9DC0Pm+nUrsi8Q8ns7rWpur1m+SWOVS/rSnh1RciNybFW+rJUUrq06NBJTTlHbxZce0JQCUkKaR9l2QxePl/v3xjpYXGgl3Hsqx0bhrDThw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bP0ncrUN7AvRFd7NA91zkjDnHuoNPWLrT6dUQmYuLYY=;
 b=qgkaP3nqqIVEP59G0JDTaMAKJrP7RdlEFma1FzzSGE8G6xcIqmERoNoeO7QJz+KSptTzb98GMugb8kDg15VgJR4Z+CSm/sMAH9bUxC0UcmD6oHmDCF7OSjZ3wPT/72wKtAHbJUdql92VqcSz8wwKiwkeFDCbB3xFeYEfnyEFGyI=
Received: from DSZP220CA0006.NAMP220.PROD.OUTLOOK.COM (2603:10b6:5:280::14) by
 DS2PR12MB9639.namprd12.prod.outlook.com (2603:10b6:8:27a::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9031.21; Wed, 20 Aug 2025 11:33:27 +0000
Received: from DS3PEPF000099DF.namprd04.prod.outlook.com
 (2603:10b6:5:280:cafe::45) by DSZP220CA0006.outlook.office365.com
 (2603:10b6:5:280::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.14 via Frontend Transport; Wed,
 20 Aug 2025 11:33:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DF.mail.protection.outlook.com (10.167.17.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Wed, 20 Aug 2025 11:33:26 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 20 Aug 2025 06:33:23 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [RFC PATCH 2/7] drm/amdgpu: Add New TTM Placement -
 AMDGPU_PL_MMIO_REMAP and wire up plumbing
Date: Wed, 20 Aug 2025 17:02:49 +0530
Message-ID: <20250820113254.3864753-3-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250820113254.3864753-1-srinivasan.shanmugam@amd.com>
References: <20250820113254.3864753-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DF:EE_|DS2PR12MB9639:EE_
X-MS-Office365-Filtering-Correlation-Id: 0356785d-f893-415d-af14-08dddfdd6113
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?b1ZURlV5ZiswN0dmV2lyUURVVTJzYkQyU1IrK0ZNN0R1a1JJK1NaYUJHVXc4?=
 =?utf-8?B?RHhBRHVaajRUSUlVSnRTbkorNVBtWWVtWWkyNUlzUENoYlp1SEpBRHYzbjBk?=
 =?utf-8?B?WVYxS0hEYzhDTE44Ykk2MG1mSURNRU1uYW1IRlpQYVA1ZTJDVFFrTkhJSVBq?=
 =?utf-8?B?bmVVaWRHUHhJMG5pbmtnQk5oVzNmdFFmOXVScVIvTTYrRVpETHlISEUyZHBW?=
 =?utf-8?B?ak13b3YzSUxjU09TdVk1Z0FsanRkSUk5UlRMSjBnOFVzQXBuQXdDRFdqNEJK?=
 =?utf-8?B?YUg5d2FjQ1M4QjJxZHFUNFVscnd4cVNOVWt0L1h0ZjNQcld6cVpJWlhPRGJi?=
 =?utf-8?B?ZjkreFZ4REViNGoyU0ZyL0ZlOUcrd1dGWVdwdjUycVYrZWpiQmlwbjFKTVhu?=
 =?utf-8?B?dGU4MTRmZTlwNEFRTThPZlkxMFFxMnQzci9VRTIwMGIzb0xpUXlVVVVxcWhX?=
 =?utf-8?B?RjJnL1FCVjVsTWhpU3RjcjVUKytNTzRnbjl1QXhMQy9xbFdvOUNCZXhoRnBm?=
 =?utf-8?B?YTlBYkFMRFowSUcvUklFWFZCeHUweWV0bjZDUXJFdG1RbWtFaEZFK3ZObjVw?=
 =?utf-8?B?bUZpN29KR1UyVXNXeGlYZkhDOXBVVXppRnYyWlBNYTlObXZIdmxWVUdCa3JI?=
 =?utf-8?B?Yk1admNYN2t5dHdRM2dSOGhXN09ubGFjT3o5Y3BqaEhaM0VUQ3dJamVLQkJm?=
 =?utf-8?B?S3JWc0xZOFBEUUUvNzNtNWdOd2dUZVFJcVJyUlJYNUdUOExQMWpPc3RZYm9t?=
 =?utf-8?B?T3ZzNk5VOTJ2QVIwV0NoSDZsS0FFZ3dQclh6dVBCZitON1VjRlUrNysvVDVC?=
 =?utf-8?B?UkU2RVE3SnBpK3VuUkJlb0luWXNld3lhM1FBSFNObnFYRjRSa1h3RmNuajBY?=
 =?utf-8?B?SlY2Z0NBSVppZ3FVNEFlSWRscVdid3ovR1JuZ3d5bnlnMVoydE9xR1lvYzJR?=
 =?utf-8?B?bE5lMjFlTUxBOGpGQmNNS3NVZ1VtMGhqdUN5akttdXRNTitWL0VhYmJoOC83?=
 =?utf-8?B?MjFLbU0xWUNjdEFrR3RsQmFnVWQ2bzB3U3l2WC81WFlPM3VmTGkyRFJQdDVj?=
 =?utf-8?B?RHJ6dEIycUdOd3VxNkhIRFFjSnRDWDFDRENRV3cwdXpkcHpPUWZveFJPS2dV?=
 =?utf-8?B?dm9TUHRMTGJDM3NLdXVLZElSYS85ano2UGE1U1pFd3pmK3JkaTF3a2p3a1RJ?=
 =?utf-8?B?WUlJOERuZ3h1aTl5eEloTGxhcUVDanhtMEFxa2E0V0Qwc1I0QTl1WCs1SXVu?=
 =?utf-8?B?ZUpNZi9KU21xZ0JmMnNjK2hkTUVydVdkTy92dEdTY1JqUDdQMHBabldQNlUy?=
 =?utf-8?B?L253ODVNVnhiSEw0VHdFVWQ3aEVMWTdackdGSHM0S3RpelNOakRBTVBqL3dv?=
 =?utf-8?B?a1d5R3pzL2gzSTY3cXJVOWUxT1R6Y0FZcC9pZE0yQlRqS24xVGpBUjZ3UkVF?=
 =?utf-8?B?N1hBUUhhZTBKVGVQb1p2TnJEanhqWHNENHhSZG80OHVzUHp2eXVnbWJjQ0xt?=
 =?utf-8?B?ZVAyekRIYTgzOGR2RXhwWW5ubVYvYUxwQzZRM2RQa0toNlRNdmI4V2JDVWhj?=
 =?utf-8?B?MnM0L282Z0ordTlSck9Ja0l1SGwrU3FUWWthVUhUYjZNNzBmTUxWSnVnTXkr?=
 =?utf-8?B?djk4UGJ4bnVNLzVtcHVpUDJ3cnlYbzBxbk1QeHcrV1pOQ1NiRk1jZE16cE56?=
 =?utf-8?B?cHZpdE9YMVBDMlRZcWlzNU5pTVE0aGR5ZllCMExIYzNpcitZaW9McmMwZUZF?=
 =?utf-8?B?Ly8rNjI5RVhBd0pkY25DMEpoRk03dW9ScHNKZlZ2ZzZzenVjTWY5S0JkZkNN?=
 =?utf-8?B?Y3Y5UGl1ai9vRU1iSytmMEw5N3dTeEd2YkNVdmlIY2lpclZucllXRHl4VG1S?=
 =?utf-8?B?SFVFZlVxVFdENUZBY1U3bGpRd0h0cnVLZGlOdWpCZ2ZRdis3U1RaRUkxaE1p?=
 =?utf-8?B?NmtCaVE2Q3dUTFBpdTluekxENk8wVUJFbUFDQ0FNY2RmaGhyUmh5ZlZmSitK?=
 =?utf-8?B?am94ZWh0ZHEwSEVVcFEzb2dGdk4yN2h5WUN0VGZMZWI5aE5iMU1JYkM5WkdI?=
 =?utf-8?Q?sEyEKm?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 11:33:26.5114 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0356785d-f893-415d-af14-08dddfdd6113
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9639
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

Notes:
- This patch bumps __AMDGPU_PL_NUM and (for now) TTM_NUM_MEM_TYPES to
  avoid compile-time guards.

Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h | 3 ++-
 include/drm/ttm/ttm_resource.h          | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

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
diff --git a/include/drm/ttm/ttm_resource.h b/include/drm/ttm/ttm_resource.h
index e52bba15012f..f49daa504c36 100644
--- a/include/drm/ttm/ttm_resource.h
+++ b/include/drm/ttm/ttm_resource.h
@@ -36,7 +36,7 @@
 #include <drm/ttm/ttm_kmap_iter.h>
 
 #define TTM_MAX_BO_PRIORITY	4U
-#define TTM_NUM_MEM_TYPES 8
+#define TTM_NUM_MEM_TYPES 9
 
 struct dmem_cgroup_device;
 struct ttm_device;
-- 
2.34.1

