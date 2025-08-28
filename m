Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C388CA0EED
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Aug 2025 09:15:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0189F10E93B;
	Thu, 28 Aug 2025 09:15:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xIoQ5nn8";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2041.outbound.protection.outlook.com [40.107.243.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B67EC10E93C
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Aug 2025 09:15:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qd+yYyMl1P2R1KaIl+aHJJMVfCns++Upt4zmcTxm+A+pAyKNtYIfQHhD/xkHh6i+1cktPJTh1MySOfwDI9LFs34nOIpS7wWVqDBcDwu+bxjeSkLLKmI6iV0+w0ySByraC4jJBe3jlE3PHelRFcthWu5JpCgwUnH/G7otydtAH5hLl2J11tQTYt6QEINdUcO0UA1iConDCFsaUFI03zFtzrICD21GMubdWxAr0hfr7JL+uS9LDWEOr0u7qQqbSIGx5C1JxymEBltNsIv5FMeceEnR3U0RMKaKnKzWVrJ6rseo2eByB0jYiTdz3QUhBzEmO5mHvKYfmjkKtukcy4BO2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9bkK/PSa0eWhTWxZbQflOCEmAExpUEoGTNAKGy/cuiA=;
 b=CayqoYCfU+WZWG0K47RCkWl0ttr7yzmLgdxR6MLXDeUJjevA0NbDYBHafcJqtR/ZXlrRZegV6xOzRyZPfgxXr4nMSuutk1cAsssEoD7ylD5Ui25tNB/ASM+NoQGIDHuPG0CfVr4vS/CYiZIKervW9FOO/p8jkOuFnCSj9sQ6EGNqOWrpNyWEWmLh9Jf9gdMjVyPGh8fWsi7JsQDrjecXXROCoyoXxkXZxR91XguebWaQjlvr5uUwGkLietITcgxn5Cah2Qw1BI0MQOSIus16negZ6tyxNK4MKPRI0R07Dwo7wB0FV4s4+p10uhPenPSIp24JDssIuvdRJRlsFpYaFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9bkK/PSa0eWhTWxZbQflOCEmAExpUEoGTNAKGy/cuiA=;
 b=xIoQ5nn8hUl9wed9xu/MFWj9z0DNJIB1GGVw4Sr0I+WORsNtNpIIzj0DBsa3Z8j2kIWsRgQMzfYqipYB67nxfzzZUmbdQBmPp+MYoqNThCHVIqG4E7wB5YSnpzfAgVJJgYR27ymItl0z7uInE/+2pXIQCI+cwu6JZCGl5+hXHpQ=
Received: from CH5PR04CA0021.namprd04.prod.outlook.com (2603:10b6:610:1f4::14)
 by DM6PR12MB4283.namprd12.prod.outlook.com (2603:10b6:5:211::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.19; Thu, 28 Aug
 2025 09:15:35 +0000
Received: from CH2PEPF0000009C.namprd02.prod.outlook.com
 (2603:10b6:610:1f4:cafe::45) by CH5PR04CA0021.outlook.office365.com
 (2603:10b6:610:1f4::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.17 via Frontend Transport; Thu,
 28 Aug 2025 09:15:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000009C.mail.protection.outlook.com (10.167.244.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Thu, 28 Aug 2025 09:15:35 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 28 Aug 2025 01:45:56 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v3 3/9] drm/amdgpu/ttm: Add New AMDGPU_PL_MMIO_REMAP Placement
Date: Thu, 28 Aug 2025 12:15:24 +0530
Message-ID: <20250828064530.3948378-4-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250828064530.3948378-1-srinivasan.shanmugam@amd.com>
References: <20250828064530.3948378-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009C:EE_|DM6PR12MB4283:EE_
X-MS-Office365-Filtering-Correlation-Id: 64341b3c-3f35-408c-3c7e-08dde6137256
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VEFVMFg1eHBaMlB2OExFeFpxTzlnNUlESVA5NWY3Z0ZSOUk2c2lMMHd1ek1I?=
 =?utf-8?B?N3AzTUlpTjZkbXBjbnhnbUVmV0IvTmlRcXNHVm92S2JvUEFYNnY3T2pJRjYy?=
 =?utf-8?B?bmxEWnBvdzJVN3BLYStNZUtWWDdNTnhKc2RlZUdOVmh0RWVaNzhKdlJDZjU5?=
 =?utf-8?B?NkpCay9vWDNVdVNOOUxhb2t1aUNuQnRQRXN6WnpmT3ByRkxjamtkZUtOMmtu?=
 =?utf-8?B?MDNQSkRvRVZtdncyQ2RHNENVMTg0Z1ZCNUpGS1JIclFqQVBNbXpGMWlra1A5?=
 =?utf-8?B?VGxoZVg2ZXRsL2t5ODNnSGNYb0h2SWFLQ1hkMWh0aTg1anl1cENNaU1Ub3d1?=
 =?utf-8?B?Zlo4U1JQS01HcHh5SXdwSXY0WERyejNIMmlHZFRHRzhtSlMvSTRnaUpHa3NJ?=
 =?utf-8?B?UnRoWWlYZXBSbnNjazRVMVFXZnppSDJXMmVXMWdIOUIxTmxQMUlyeUhnSFIw?=
 =?utf-8?B?WXlObWthcko4TlA2TWNQSTB6N0RQNU1zUnUwTE8weEk5eFdzWTJGaWp5cTJQ?=
 =?utf-8?B?TnJUdjYrZ241S2dtZlVuVk03clBTYTRtTDJ5S1YvZ3BOOExsUndjMldwaWhi?=
 =?utf-8?B?b2dVWHVNZWdMUjFDaHNhRHJXRHQxVzIvcnNEYS9MRmgxaDVwcmg2MHBBVkIr?=
 =?utf-8?B?NzlqQzlCelNYYlQwQ3IzMXNqK2RERXVoNWVIMmVaYmV0UnJqc3V4NXZyb1BS?=
 =?utf-8?B?dWFNTXU1R3hQRndBakRoL3BaSXk5OGZIdGw5K0QrRXB6M1J6SEx6N1E4VXNu?=
 =?utf-8?B?Q2lSWWZabFptOEJFK3ppQjdKZVo0blQ5bFM1bVRDRmRzZGxzKzY2S0hQT3Zu?=
 =?utf-8?B?OWFUdDRtTGZabEVQRTg4b1lDekJ6anFMMy9KZjFiVElQZFlVZ3AzMTlFVGZF?=
 =?utf-8?B?enZZTGJ4Y3hxakE5Vm5SS1B0OWhOYmZyV1lvVnI2MnNic2FkelhqWjNybU5m?=
 =?utf-8?B?ekMrOHRCQjVPL1k3WEMxTGVLaW9yK2QrOWY1MEs1UU82dGRiVTk4V0tuSHdR?=
 =?utf-8?B?ZjB1dUpDSGI4TTFYRXg3YVBMTk9ELy9KZHMyRS9Cak1xYzhJUzB1amwvVE5O?=
 =?utf-8?B?empyYWhMeTVkckhtQ1Y3MjYzSUVVMlk2cktLWTI3YXNwYnVxZCtwQlJnRHQ0?=
 =?utf-8?B?Z3VIN0x2UHFjd09iRzlBSzd1ZkxRMjdWaHRKM2ZRdzVMRHRHTnQ0czBFY2U1?=
 =?utf-8?B?azVPcHoyZDFSMGRWWWNQQktua2ROWXhTbHFSbHE5OVlvMVA3MXErdThWd0Mw?=
 =?utf-8?B?UG9DYmNIVTVGRW00RWhaMzQzNGp1aTF5K3dDTVpUVCt4bTFHRCtXYWlFZGh0?=
 =?utf-8?B?c1o0T0VzQ09zTHFIWjJNblBSZC9qMjRZTTBuMk5NNWNwdlhvQWpQSXBvZzg1?=
 =?utf-8?B?bytQaWxHVnliaENiM0tHQjJVY01OVkF2eGY5TXIrdWZvQ2lPWHZaMGc1eE5M?=
 =?utf-8?B?Q0FFK2xHZU5EMTgvYitqTmIrdm1CZGFXSGc1QTh4YnlQQVc2WGpKVFBnWjZq?=
 =?utf-8?B?S1FxM3FGQXF4d0FKTHh6WGdMK3VHa1g3Y2FXSmZNSnVialEydXU4Y2h1Yjhs?=
 =?utf-8?B?TERoaE1ydzZnNFVXbUxJdmJBTEloS0VTSWlVRVJxV1hkdll1ci9TejJPOXVI?=
 =?utf-8?B?a0tCYjRmMyt0a2JCRnV1bWJJUkd5UUJMeDdsbWtHc0pnOVhtRnkzek9pNWhO?=
 =?utf-8?B?VVUvQ3NYNjZ0SzJHQWZvalpWcmpHZzFsNlI2UVU5bkZlUnIzZml6SDQ4SFM4?=
 =?utf-8?B?aUFscVRrYzJSQmpReTVxODBGelcyVTBOM1FnRTBDUUVDbExnRFFjN2NOOG94?=
 =?utf-8?B?Q2pRQ2ZpeVMxemdTa3ZpUDJUc1dES2tYVHVNZjJOVDJoSGpqMHcxeTh5NFVh?=
 =?utf-8?B?THF0SWUvSkVoVjBReFJRNG9vcy82dmRmWWhJWmZ4RHl5RUp0bnl4RVlsMDQ0?=
 =?utf-8?B?T0o2TFFMR25lYzF4MVU4QUhkZ3BnTG02NmR5R2pWL1hSV3lXUGNqODJiQXdx?=
 =?utf-8?B?R1BkblZ6SHhjaTdob1E5WnIxN1NyRy9KT1VvRFNBblhYTFpqaXRLQ01PM1JM?=
 =?utf-8?Q?1p7Z22?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 09:15:35.2968 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 64341b3c-3f35-408c-3c7e-08dde6137256
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4283
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

