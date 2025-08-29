Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88E5BCA0EED
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Aug 2025 05:54:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 33CD410EB34;
	Fri, 29 Aug 2025 05:54:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hyEl8Ax3";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2072.outbound.protection.outlook.com [40.107.102.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A2DA10EB34
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Aug 2025 05:54:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sKsOJBFH/Mtx5eZHEN8GwWSnEBThbvvr87JVpesCOaNeT2ZYPI6GGby+PzfEx2U1Ip1cbUz3avEDu3EUcwtHTGNea/QLmh2djFbDYdZejCHlmfBgIPxtvMIUbZ+PERYIpmxpqVpjLWfCDmuotGqu3Nr+xssRQvrqyHJby0r889VJjKAnjbVlhDkmgV8Mgm4AaI1os8mN2iNMOnc/f2Fi4wYP1jHgrXudPI6uVoYbxfxB8VyXAbfmLuYFAFXQTuO6xnYWjefLczIG0WitejJXUTUcbA0p4uCFgFzd9pNNxbAkUNsemVv8x3iTMeEHApVg/hfcraKpLjhjVqdeQ043nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9bkK/PSa0eWhTWxZbQflOCEmAExpUEoGTNAKGy/cuiA=;
 b=RyOUWaCFPjbTM/BR21FqPilWeD7EU8f1z7i0e5OaNvMd4/44PJv6TYsbiU4UqU8hkx+YYw6GuBfnH308n5AaK/nilJnnDC110H+HLdIt5rl4pvYb7ZXDfMrt00AZGlM/F6rtQuVWKu6rMFLugv7l58hLucG8K2+5c83kWJ5Om1ajvoChf9PwgFWdxHuGsCf3ON9evpMq09W4Omnz7M3ZoC9GA+G+4ddlKkpRaXKG8NvSVKvJOhvL7jXJ9+5DCtuaB4XftEhDAwDRp7Qyqr2U+0UqT7wVC6XVVW8QXBVG6BaLECmzaZD00AFHk5MPILvGkIiZ+gSy8zfGSkYdgKxXow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9bkK/PSa0eWhTWxZbQflOCEmAExpUEoGTNAKGy/cuiA=;
 b=hyEl8Ax3ojfT9z55v8NjmSSrKcR2IOolW3TSk4Knu1mW9IZfLcdR+C9mC/Z0gMQDik+x+470ie+r/XFdlXij1Z8w8SqwDDIkSWzV2yOFA7wg859TZjqAZYQ3GLdfYa0OFfhz4usUIoD3RJvNV4e7QOEMcqeOf1eBARRtwBv0sPI=
Received: from BLAPR03CA0080.namprd03.prod.outlook.com (2603:10b6:208:329::25)
 by IA0PPFFEC453979.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::beb) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.19; Fri, 29 Aug
 2025 05:54:01 +0000
Received: from BN2PEPF000055DE.namprd21.prod.outlook.com
 (2603:10b6:208:329:cafe::ff) by BLAPR03CA0080.outlook.office365.com
 (2603:10b6:208:329::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.17 via Frontend Transport; Fri,
 29 Aug 2025 05:54:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000055DE.mail.protection.outlook.com (10.167.245.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9094.0 via Frontend Transport; Fri, 29 Aug 2025 05:54:00 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 29 Aug
 2025 00:54:00 -0500
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb09.amd.com (10.181.42.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1748.10; Thu, 28 Aug 2025 22:53:58 -0700
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v4 3/9] drm/amdgpu/ttm: Add New AMDGPU_PL_MMIO_REMAP Placement
Date: Fri, 29 Aug 2025 11:23:49 +0530
Message-ID: <20250829055349.3983421-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DE:EE_|IA0PPFFEC453979:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f17bc17-1b45-4853-ef90-08dde6c0739a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aFluZERCY2JMR3RHUm1GTy95ZEF3N1pXSWRLVEZqZlA0K3lDTHNrQjBPMk5S?=
 =?utf-8?B?U1RUN3lLZUp1Q1NJYzE0bXV0UFcyU3lvZWx5OEllandZRW1iTG5LWktJM0VJ?=
 =?utf-8?B?ZjlKVWpsNXhFV3llYjBaNkFLZGNXc2lOVWRSNit2dTk2VFovZU5kOVNMR0c2?=
 =?utf-8?B?bmhhdFF3NVhEekw5Y2hSWnVWamczS3ZkQ2VCR2oxS0orUjgrdlVIeDhQRFJu?=
 =?utf-8?B?dG5JZytuUExVSXdtOUgxZ1huQ0gzUGEwb3p5eFJZaFhBRTBKaHovaUdjV21z?=
 =?utf-8?B?bTc5WkY3eVhvV3VSN2JseEd1QTNOdXJiMG10RTFrQlRyMXA3b1Y5TW0waisv?=
 =?utf-8?B?M204TTdqOGU0Z055b2dVYkZWWHZ1emlBVEZpUVpPVkE4OStidEFjbHY1d1FJ?=
 =?utf-8?B?RGRMWE5hd2N5dW9GRFVoNnRRaWtnbjN5N2FGdEhyQWh5K3NpeFFFbkpIZE9h?=
 =?utf-8?B?V21rNVpsTDdBZHNqVmk0aDdrMXVpSnpLaWd3T3JjZCtsZE5IRmMvai9WVE5y?=
 =?utf-8?B?ZHljc0J3Q3BneEEvKzM1dW52MnEzSDdFSlhqd09mclVIcTIyeDZZWFJlZ01y?=
 =?utf-8?B?VlE3SzRlNjFqWUE4TU82aGxjWXBMclpYU2EvbUtrTGl4elpveDI0QW1xVXpz?=
 =?utf-8?B?MzVJQ293YjQwbENhdVRMdENEYzc1bjRoVm1hS1FHQW1PbDdEVHp5WFJuZ1Fn?=
 =?utf-8?B?VXV4aW1sQml2YXU4cUZOait3WWh3ZmtTQjl1TzZzbloveXJZbHB3ajJkUk1j?=
 =?utf-8?B?dUZQWndYbWZHTVBmMDFwWXBBMFJYaGo1eGgzK2c0ZiszS2dBb3R5TjFsbkRw?=
 =?utf-8?B?cDFFeXV2eTEvbVo0UktML3pYL2J0K3prdnVDMFVMM1krVDBJT2UxSEN2enRN?=
 =?utf-8?B?MElmVVdoYmxScHpvY0ZDV1lpSzRsbkVTSGVVOVpGVDhoajlueWsrSnlaWEhq?=
 =?utf-8?B?bXdhZGtFOHNkbWFMS0tURDMwN0VEWlZNT1BjSGhsakxZUXdVemRQVkpsc3lG?=
 =?utf-8?B?YTVobmV4TGF1WlE1Ky9wZCtJTGJpWURmMmFpVStjUDdnTjVpclRuTVo0UXdO?=
 =?utf-8?B?czFVV0hzUjZIbWF5aDlUeTFZUk5IaElxNkpBYXlYV0trTDhWWlFEaFRpc2cz?=
 =?utf-8?B?djl2Znd4SEN4UnhkMGpSS0ZIVTJxc1RhRlpLSVU0bk1WUnRJY3hKbkVvcWZO?=
 =?utf-8?B?V3V1QTJHdEs5NERJY2x2a3oyWmhucHQ2UWN5WXpqVVQ4ck9jUTEyK0xkWGM1?=
 =?utf-8?B?WThSSEV6bXpad0s5U1BlVWZPeGdGdzNVeE85YkF6MjlEVGd0U2swTWtxMDlv?=
 =?utf-8?B?SXcreVpVdFg0U2k1OXNkeHBZRjJpeEt4c1M3U1UzdEVlbzZ6MGZrYzMxQ2Ry?=
 =?utf-8?B?MW5iZ3lzOUVwb3ZyL0RvQ2FGR1czTVVtZVJTMFJqREVVbndpdmg2RnB5UU9G?=
 =?utf-8?B?aG5WdHpRcDFocnBOd2JsUXIxZnROK3pYL05pWUwya2Nob1FXbkprYVNaNXhM?=
 =?utf-8?B?NW9QMEFaVlB6TFI4SFd4OFBRam5tbWZYSFE0TEp0S3NKaUlDMzl1WHdFbi84?=
 =?utf-8?B?bHRud0w3RmU1bitNb0FZdTl1ZWEvTjVrOS8rbWJOSk1pcUQ2akJEbWdIT3pW?=
 =?utf-8?B?K0dTQkhqMko5Ly8vYnhxcWZ0MllIY1NWczdVT0dlL3p1WGFaTWh4eklSWjFE?=
 =?utf-8?B?cDl5WG9NSCtKQnBMQ21mVlRlL3YxR0hEUUEvck9XSDNrN1JhM1kvaTdXY2NN?=
 =?utf-8?B?R044UFdnYytLdHVuY1k5UFo1RE55RkNXVHdzaEZ5SFFET0FKRi94am5FZmxW?=
 =?utf-8?B?elBqK1k0eHpIM2NkUGNuOXJac1YvaS9QVFFnakFiWDEzYWwyL3R0dTI0TUhI?=
 =?utf-8?B?eHhPWWw2cFBJZFVyMFJJYXgrL2h0NTg1UGtLdUJGMW55RFo2UXcycitPdS9O?=
 =?utf-8?B?UE1Zb1lZcUNTUE04YUpPNlZmdDZHOCtwQWdlWDBqRGpHRlVNMzA1TmJOZHhM?=
 =?utf-8?B?UDU0TkNEMU45aHNkc2VHZzRRV3dZQ1puZ1Ird2Y0WGJkd3lWcUlpdGdDUTFa?=
 =?utf-8?Q?8TQvwc?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2025 05:54:00.3709 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f17bc17-1b45-4853-ef90-08dde6c0739a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055DE.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPFFEC453979
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

