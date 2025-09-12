Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAF67CAC582
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Sep 2025 11:13:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 73D7610EC0D;
	Fri, 12 Sep 2025 11:13:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WZ/jFX58";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2078.outbound.protection.outlook.com [40.107.95.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B012E10EC0D
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Sep 2025 11:13:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i1FXuSfuLdUuHtVPdGoiMvDfO5/nAme6EL8fxCn2sO95RnEFVy+GKAMB3WPgz3TdjV5Cr9zis+zMyrLh1hjTbHyFKBQ0mPSy0mQdAJDAbP3zTuKSJh8jCK+lQ0UOStx5OrBHDJ1hCo+kHm+TAeyWW2GfD4+y1K+HjzRyeyKOrmTfh+d6XLRDBugKTKSVILBHENJuckRdg8gmqyptcvS9w4W4B4pn5i7B/Q3jJQbNoanNUjOZC0ixem4M1157EuhV9uj2W/9yX9jQNWek60T/XVvC74MvZsf5yBxMODwLeSaGsCZ0gjg+yBGUSy8YZpIMim5yG1d0Lyf9TArZ4JcSow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EgPmGetfXwnlxtGxLsZofLpbg3Xkjbb0z2Ypg11iY0Y=;
 b=GytOnZ7GtWIZxRzhtUWOho69asMNqV6fYDBqgAxLBTvWwhJkWgofspxw7fLJNt+tW/C5tQJ3iHDIM4kfm83/BkO2kSBfwsqTiAOmu1AeoId2BhQhEOdrbacKZPK4MBwmR85N9uYlHOdntmEBjiMJdCtG4AuNfR+xWqmUnSWgEP4pY6UdorxuXPyxFxW6suC6Fh2iT1TQz9olQpcNAWvEVPvwMmwdIBDkxEiXZCUlUhCRX3Mmz7Cov3g27VdHL3taX/NHTDdeYua/2pC0QC0IKpi/eAvXc/4KeEa69DoGE1ASkNAjtLjDnNFcOOvct16lodNEiqJLgtsZZbGVQTERug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EgPmGetfXwnlxtGxLsZofLpbg3Xkjbb0z2Ypg11iY0Y=;
 b=WZ/jFX58ZWbE30Qi+hSTUxRG5AUDnRPpGZmW45fcEUbMwjmbq7F9rAZVaOucdweGSV6QsMB277bHjCsTI5iWJNI3iB9ZRmOVzxzVeLjcfoZdFT03XOzeimcKJRm0xHYNMJ3JV1wLV/sw4R3oWMh/laWxPVtw9MGqtmWleImNkBk=
Received: from SJ0PR05CA0184.namprd05.prod.outlook.com (2603:10b6:a03:330::9)
 by LV3PR12MB9402.namprd12.prod.outlook.com (2603:10b6:408:213::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Fri, 12 Sep
 2025 11:13:28 +0000
Received: from SJ1PEPF00001CE2.namprd05.prod.outlook.com
 (2603:10b6:a03:330:cafe::db) by SJ0PR05CA0184.outlook.office365.com
 (2603:10b6:a03:330::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.8 via Frontend Transport; Fri,
 12 Sep 2025 11:13:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CE2.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Fri, 12 Sep 2025 11:13:26 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 12 Sep 2025 04:13:24 -0700
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v2 1/3] drm/amdgpu/ttm: Pin 4K MMIO_REMAP Singleton BO at Init
Date: Fri, 12 Sep 2025 16:41:46 +0530
Message-ID: <20250912111148.833465-2-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250912111148.833465-1-srinivasan.shanmugam@amd.com>
References: <20250912111148.833465-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE2:EE_|LV3PR12MB9402:EE_
X-MS-Office365-Filtering-Correlation-Id: 97303065-a3eb-408a-2ed9-08ddf1ed6590
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aGdGZkQvNUttY2lOQ3A4UGV2UEQwQllQMHh1dW8zZWwyMGZ6YzRFSjRvQWg5?=
 =?utf-8?B?Q1hiMks5S2lkZ0dlYjVweS9CR1czYzFheTVkRVZsUFF3ZkJUaWxOTUJKNkp1?=
 =?utf-8?B?WW9ZdGl1anc3T3dJenA1bEtlNnBRUHJqc0VtK253L3ZyWS9DYTVLZ292ejFx?=
 =?utf-8?B?bG5rR0JETWUyQUx1OXRUQStzUXJ0VG1wR2JtZHgyb3EzSmRROUcydzNUZDdz?=
 =?utf-8?B?R3llWWlzVk5vVWhxUTBYV2R0THJYeGxFMFRZYTU1bm1MaHdTaUlQWG1NSlFG?=
 =?utf-8?B?d215N0J1VGYwZnlhVFk1aXdjeWhPOUxnQnZxOFhLanVqUGdrS0pqVnBnL0hz?=
 =?utf-8?B?SUxOUGxVQU1udERKT08wbDEwU3JTVmlLc21IV3d4TndLT3NoeFBWQ0N5NmZN?=
 =?utf-8?B?eVI2aDE2RG9HKzhhL1NudDkrVmE4MUhsLzhaUXpab1huWGxSTmZXVTBPRkFB?=
 =?utf-8?B?cTh2SVFFUlh3SXJTeUhYRHRqUmVYa2xLaFk1TFl3Qkg0QmtJQjFsYVpCcmRk?=
 =?utf-8?B?MngrakZHaGxudjFGY2JiTWRKYmF5MW5QL2hvQzk5YUdVeFZTRFNBK29RV2RI?=
 =?utf-8?B?RW9YZXJMcjYzdFZOYjA5RE85OG50OHAxV1JIeDB1SURVcUlSdVg4amRVUm05?=
 =?utf-8?B?YVJPdWw0TXo3Z253b1VnenpFN1hZSFV0SDlRekttMWhFbEFGTmZwWWw3WUxj?=
 =?utf-8?B?ZzYwMTlaUFZkVnpmVFhTQUFoTXRkUXdISHBheUhsRjNwdFlHdWdxUzRFTjZ6?=
 =?utf-8?B?ekxtYnZCblZkWFdXVURCajlCeUVsZ1VaQnRsME5DMzgyYXZCMVJVcGhnamNv?=
 =?utf-8?B?VVVLaVRWT0JMZ2dlbVA4TnZjcnVVNGJsd0xvVmVlcUN3NVd0OGFUeER2MEIr?=
 =?utf-8?B?OU1BZTh4MGZTbkpPVU9EdHJIVHNsRG8vajF6OS9ocWkwM3RRZzQ1YkJmaXQy?=
 =?utf-8?B?aEIxVURGV01uT2FxT3VySm4ybzhQQlJOQS94dmM5ejRpU09zWU1aT1RHZW41?=
 =?utf-8?B?QzdMdUNpSk5ROFhwaXl6Njg1SExlY3BjOXlDSEpVMk5qL0lIcGhERG5uNnRM?=
 =?utf-8?B?eVpQVW1SUm5GYVcyR2pTZXZHcGlpUDFuVms3SHBya0loKzUzM08yQjZ6aWlz?=
 =?utf-8?B?MUtNZ2NOYXZpcDBJN3pTczVSaW9WbmszelM1Y0FUUGJtdDdXanlINUJZdUJL?=
 =?utf-8?B?cjJHeHFmSXl4Z0kyYzMzY1ZNVU01T2E1UFRsa0k3WG9SeDI3aWFXUnBFSjk5?=
 =?utf-8?B?N2NGYTJUUUM3L3RBZ0JEbE1VTU96SU5yK3J4Wm5WNGQzZGZ0MTExc2Vkbytu?=
 =?utf-8?B?ZEx6bXlGTkZrSU9kcy8ydC9rdmJ2ZmhCNFRnRy9FYkRSVGV4SEYwTnpndEFy?=
 =?utf-8?B?VjNkYXA0azBLdEp3Rkg3QkkyYlY4eTRQaXprRU5lYU4ycjF5RlBFMnRPOW5y?=
 =?utf-8?B?ZFNaUTRjYVRZZFh2aTZvdlRxRWhzV2RhS3J2ZzlNVlAyYkVRbTFkTUUyeTA5?=
 =?utf-8?B?SGFCQnlZSERxOTMvVE0rNlZvQnhxMzkwbkZrdU9sMkdyS20rTmNDMjRTRW5p?=
 =?utf-8?B?TXMrREpaV2tVdDVLYnNTaU9xeXR2KzVwUXZsUU9WTEMwYU1pdC9JUHR5cjlW?=
 =?utf-8?B?OXBtUzVzV256cmtvalcwZGNTZkNBSlNmUitZTjNrak5OWWV3TEhUcDdEbTMv?=
 =?utf-8?B?eGJqQXNrY010cGFUZFNFbU9DR1ZHNFFhcnJneCt1dWs4TDdnOW1LUUNNOXVE?=
 =?utf-8?B?Um1mYmVRdTZiTTlQZzBmTGdDZXJJZXM0MDE1clF2bDE3RU1NcDlKSkNLalJw?=
 =?utf-8?B?QTZzRjI5ek16bDFwT1gyTnBNTi8rNWVLd1R5UWpDSEN1OEwvVDNrVk9Ka3VS?=
 =?utf-8?B?MmZpOFVCUXo5NWkyb0cxSHN3bnhhZ2UreGxMTGtJbW9WbGtzTGM4dFpaYklL?=
 =?utf-8?B?OUtrOTFoYnBSakZOU2dMWHBvL1Nham94YmVrT1F2NGZCa05YTW42bWdoY0ww?=
 =?utf-8?B?MDhrRmVEdkF0MVNza1VKQTQ3WTU5clNUb2NnS2R4OHNhYnE3NzBUZ1lSNkJz?=
 =?utf-8?Q?1bQxie?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2025 11:13:26.8571 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 97303065-a3eb-408a-2ed9-08ddf1ed6590
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9402
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

MMIO_REMAP (HDP flush page) is a hardware I/O window exposed via a PCI
BAR.  It must not migrate or be evicted.

Allocate a single 4 KB GEM BO in AMDGPU_GEM_DOMAIN_MMIO_REMAP during TTM
initialization when the hardware exposes a remap bus address and the
host page size is <= 4 KiB. Reserve the BO and pin it at the TTM level
so it remains fixed for its lifetime. No CPU mapping is established
here.

On teardown, reserve, unpin, and free the BO if present.

This prepares the object to be shared (e.g., via dma-buf) without
triggering placement changes or no CPU-access migration

Suggested-by: Christian König <christian.koenig@amd.com>
Suggested-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 26 +++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index f38bc9542cd6..5ce7c8b9ff39 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1862,6 +1862,10 @@ static void amdgpu_ttm_pools_fini(struct amdgpu_device *adev)
  * hardware exposes a remap base (adev->rmmio_remap.bus_addr) and the host
  * PAGE_SIZE is <= AMDGPU_GPU_PAGE_SIZE (4K). The BO is created as a regular
  * GEM object (amdgpu_bo_create).
+ * 
+ * The BO is created as a normal GEM object via amdgpu_bo_create(), then
+ * reserved and pinned at the TTM level (ttm_bo_pin()) so it can never be
+ * migrated or evicted. No CPU mapping is established here.
  *
  * Return:
  *  * 0 on success or intentional skip (feature not present/unsupported)
@@ -1891,7 +1895,25 @@ static int amdgpu_ttm_mmio_remap_bo_init(struct amdgpu_device *adev)
 	if (r)
 		return r;
 
+	r = amdgpu_bo_reserve(adev->rmmio_remap.bo, true);
+	if (r)
+		goto err_unref;
+
+	/*
+	 * MMIO_REMAP is a fixed I/O placement (AMDGPU_PL_MMIO_REMAP).
+	 * Use TTM-level pin so the BO cannot be evicted/migrated,
+	 * independent of GEM domains. This
+	 * enforces the “fixed I/O window”
+	 */
+	ttm_bo_pin(&adev->rmmio_remap.bo->tbo);
+
+	amdgpu_bo_unreserve(adev->rmmio_remap.bo);
 	return 0;
+
+err_unref:
+	amdgpu_bo_unref(&adev->rmmio_remap.bo);
+	adev->rmmio_remap.bo = NULL;
+	return r;
 }
 
 /**
@@ -1903,6 +1925,10 @@ static int amdgpu_ttm_mmio_remap_bo_init(struct amdgpu_device *adev)
  */
 static void amdgpu_ttm_mmio_remap_bo_fini(struct amdgpu_device *adev)
 {
+	if (!amdgpu_bo_reserve(adev->rmmio_remap.bo, true)) {
+		ttm_bo_unpin(&adev->rmmio_remap.bo->tbo);
+		amdgpu_bo_unreserve(adev->rmmio_remap.bo);
+	}
 	amdgpu_bo_unref(&adev->rmmio_remap.bo);
 	adev->rmmio_remap.bo = NULL;
 }
-- 
2.34.1

