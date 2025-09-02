Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B767CA0FFE
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Sep 2025 03:33:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A268310E189;
	Tue,  2 Sep 2025 03:33:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EL/nRORH";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2080.outbound.protection.outlook.com [40.107.102.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C64410E189
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Sep 2025 03:33:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a1mvy+6OjNXhEEeg+oCK+duXRpLMtK/k1GetR7LpWsPJOol5yeGBodQ1UHr7gU0oEI8nVkCWAmp/s6gurmExODFxNXR2xu38TmR3M1/bDZ21+A5JTUbVMkEVCZrx+Ocksi5b6uklt32lVRziUlW2G0TfqQRhK4Ovkb8xdwnJGsfqaZytGcCtzuLfUVwMzfNCDFzahBaNZjeToS0xIPxVM2byW9CdWX3T4Al87dbGdYUx8uHQyo8VwcLSG5p2VVaYw+fxOg/0LtaDmD2+3ElVXHiQbP2iDz9Jf986eufxB29L7Uebl+GkdUiyeH6AFH9GuRJOmQ7GXAajwIeyTK2cPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QR3ExshdUXvTNfbAEYmtcYZ96cUrQhO3ZKmdNp5BilE=;
 b=xryJbFWIIzCPfeDN+WBxgEi0f+SpUB2KUVjoGkeHim9QPX7ThA5d1oV6a57ItsKrFWiofPuq++5WH189XyV0sh5dHXZnvn52/WtuNrscBBRdrWqFx0fr7nuH9ymhTZ6rUCjFVisBw1XmuGfp89ZgiCbUc2zC3qJ37iG2N3mx73mc2NjHSeqME7szZCAjVMCgVgyaEnuWUVASBWwdVgaIsLGwEt5NteBqFNfzA197U6884JdT8bNMxXwQ72PJmwzlqPIv8VW5QtZfWUjnNa16IqBvdj4CX5nyb2BFuE/dCX1qselAGQIDvWyPx2c2WDyU3nxj26d3mYJkX/zV1gSxzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QR3ExshdUXvTNfbAEYmtcYZ96cUrQhO3ZKmdNp5BilE=;
 b=EL/nRORHXsc/5A1/G9O18mM6Uc0JtqTA49rkIa8+JgD6I+rvUTsh59uybW4GxxGOLrhDpi0q1sKA/NWc34tyQp2Oc7LLU2yDK0dLdRqVPN8uqOqjsU+/L//9wdWmX8iKniN+BSn3DxsP/FNDLB4rZbYvk0D0mNm+94AoGpHg7To=
Received: from BN9PR03CA0204.namprd03.prod.outlook.com (2603:10b6:408:f9::29)
 by BL1PR12MB5876.namprd12.prod.outlook.com (2603:10b6:208:398::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.26; Tue, 2 Sep
 2025 03:33:23 +0000
Received: from BL02EPF0001A0FE.namprd03.prod.outlook.com
 (2603:10b6:408:f9:cafe::4f) by BN9PR03CA0204.outlook.office365.com
 (2603:10b6:408:f9::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.27 via Frontend Transport; Tue,
 2 Sep 2025 03:33:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A0FE.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9094.14 via Frontend Transport; Tue, 2 Sep 2025 03:33:22 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 1 Sep
 2025 22:33:22 -0500
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb09.amd.com (10.181.42.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1748.10; Mon, 1 Sep 2025 20:33:20 -0700
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v6 3/8] drm/amdgpu/ttm: Add New AMDGPU_PL_MMIO_REMAP Placement
Date: Tue, 2 Sep 2025 08:59:33 +0530
Message-ID: <20250902032938.468332-4-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250902032938.468332-1-srinivasan.shanmugam@amd.com>
References: <20250902032938.468332-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FE:EE_|BL1PR12MB5876:EE_
X-MS-Office365-Filtering-Correlation-Id: 68aa7ad7-762f-43b6-c085-08dde9d177ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?K2Z0TzVQUEg2Ykd0ZWR2MEluYnBVeUNrb05kZndhM29iSDdDQ3lhK0VPdDcv?=
 =?utf-8?B?UWJsZWM5alZlK1hiMWc5bXZvTGJUZHhRRzZhVTdsQ0tqV0ZXRXlNOXBSUVdJ?=
 =?utf-8?B?S3hDVTRpSTZ5Sy9wVG9kOTFhL1lrVXVOT0ovZGp5YkRLUVB2Z3VEb0pEdklX?=
 =?utf-8?B?YUJybXc4SXAxMWdLWm1ZOUQ3T25vM1Bvb01TVWt2RnhINHRKNlo5akdidytQ?=
 =?utf-8?B?ekxsTmd1alVMc2hCY3RibkxUS0lyMDNQNG0xSS9SZXBIU3dxM3ppZnRITkFq?=
 =?utf-8?B?dTlscG8vNnJ3NEh6V2lOUjQvbURHWmZEREtHOVl3MmFkTWhseE5ydUhaeTZm?=
 =?utf-8?B?RHVhSzViYU94RWExelFrMy93Y3hFRnMwZ3hMQzQ5RFJkNzVYQ2twc0RpalRG?=
 =?utf-8?B?ZW90S09QWVMzMUZLOHZOTFlXYkVnMVllR0x1aXV6MWxETFpMam0vMjR5aTFw?=
 =?utf-8?B?c2M0b2VjNmw0MmJaS0FZbXFxRXROZ2VtUEMvUHdWa0hQdDY5SW92d2lrV2gy?=
 =?utf-8?B?ZnRPU01aL1ppUFNVdVF6b3A5T3NoSGNVcXRmejhzWlFhdmE0OWNNREFKbDgx?=
 =?utf-8?B?cU8wMGR1MTQydUZmUGhrYytJcG5hSjFJcWtzMCtnemRuMWxKMEo2cmlybFB1?=
 =?utf-8?B?NEVPS2RXd2NCc2plY0pSdWxENngrdTJLUXlmL0RQTWNIcHFLdko2SnJxZ1ht?=
 =?utf-8?B?YnlqMDM1eDExS0JKSWhGQmxSS3J2S3BHZDVJcDJqeURCV2JDaGdwYzlsazFU?=
 =?utf-8?B?V1hDVVZmR3dTUjNzeFgwaC9HalZIaWM2aTFkbENTK0pwR2RUV1MvMkkwbTll?=
 =?utf-8?B?WjM2WXIwcEppRWU2VjVwSVVQVldzc2U0M29KeHJGaTQ2NDBkdFFKc2FsdldS?=
 =?utf-8?B?NmdOQWUxaFA0TXlYUndjSmZRQ2hFSk5KWURJcnZ2bzVqM2VuYXdpbndGNFB2?=
 =?utf-8?B?NnF6ODFPNzRsUkpMTnJQMEt5dDVXVlZpcDZLckNRWXphZkMxYTh5LzRqT1c2?=
 =?utf-8?B?dzIzOW0vWjFoeldIb0N6SHZtL04vQlc2YllOeVQ2U0NBYzUyWFkyVGNnd1k2?=
 =?utf-8?B?RW43WVRYalBrWWlZUS9qb0dxSno0bEY2eDZSYlU4Tll6MHFzd2pLcVE0UjhH?=
 =?utf-8?B?bXlTa05lME9EVElNR00vZnJRT0QyT2Jxa3lBOS9SVERQdUcvRS9TdTkycEVE?=
 =?utf-8?B?SzQwNEhpbUkxK0RaeUxRV0N4dEFMclByS1k2TEVUT2VvSmJzR3h4OHErM1dQ?=
 =?utf-8?B?NzdwbnJyUUFmbWVSQ3M1N3loeU5mTGpxTWVRQU9kQjY2c1NrbFdDdlMvZkc4?=
 =?utf-8?B?ZGtEWStyM1VJRGtJR3dvcEtTaC8rUm1vemFSejRiTTlEVklOalBydHRTNTNy?=
 =?utf-8?B?YmdMUHNGSEQxOEpLUnFhUXNEL2ErMmNhdWkwbnVDWmFwTUlGTkN0NkFqK0Z0?=
 =?utf-8?B?M3lQa1NJSWIrQVVJOHJRN0tVMnJjNEFNSGcrNStESXZPZzhBQ2VxSzluRjE4?=
 =?utf-8?B?S1NkK2lvMlpHZmVDTklFNGtqQ3hvblRqc2pnejJZeHdrYW90RzlTMEJkbGdw?=
 =?utf-8?B?bWdwSHdqK05LblhxRkF3YytDN0E1aVdZWWUyc2wrcGFaNVVKMjBUZWszVkl1?=
 =?utf-8?B?ZUVZbytjdi9Ickx6QjVBS2VLUHRwdTVZTVdtT2ZySjhGL1RweittdkpkbEtG?=
 =?utf-8?B?QjViaGI3djNOMWdvM1Rac0Zkb2ZId3llNDdrVDAxWEpEbDdsNjQzVVdMR1Fy?=
 =?utf-8?B?QmU3a0d3Z0xIWDBSajJNTG52MnA0ZngxVFNJei9Fejl0VlRXSFhUNkxtV3BZ?=
 =?utf-8?B?THkvaDBHU05mY2F4RXJaSVpnQVdEbUVYVDE3OHRWTFNFK09KRmQwNzErUkxt?=
 =?utf-8?B?TmcwQU9VL3N2aTkrODBEcklDck0wNHE3dUQzTUxpaHo0KzYwMEVpWExJQUg4?=
 =?utf-8?B?ZENIWm9JY3Z2QUFnUHU3dUwrSEZla3RTYU4zbFJsV1ZNSllTRkpjdUtERXJt?=
 =?utf-8?B?d250UU5PT1dtUVJURDRTeVdvOWtsWklaOTMzYXlGRlBNUGVyRXIyUmZDNkQw?=
 =?utf-8?Q?FmvZy4?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 03:33:22.6744 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 68aa7ad7-762f-43b6-c085-08dde9d177ff
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5876
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
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
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

