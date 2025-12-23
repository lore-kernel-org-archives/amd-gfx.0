Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A4B3E6F093
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Dec 2025 14:15:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BEE2310E210;
	Tue, 23 Dec 2025 14:15:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xfipen+q";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012055.outbound.protection.outlook.com [52.101.53.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C071910E210
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Dec 2025 14:15:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tlt0ikqcA5txppVWxrDT40h058rkOD29B5VskI7RWXKCmb4AAeUEnrxEo521WyB5QdMcaTwilIyvvvDnWjjiA7ZuIFFD7H02Np/4UoB18pD5TwNLKwLlZ5MddWKOYlYM/OwW+MeLnWRzElF3INtjmBieR91duHlWdQZP9vTidsfgsw+Fix9gLNppyh7WbpCp3NlzF17bMEZTk+xIz9YNqItZpR0R6FE2HIszV7ix6kTLIU8OcZIsJGoME0M2DqVDI2cQUPa6VjOtm+6w6DhopmR+7RS0s8Pcw0sfWNXLFxBOdgEuEVPEPl88Ol0G9NxaDzoHwxnay+H0CbHmNwTYXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ifbkal0vJ8xIfj/W32X7lA4g/5//r7yGiBwaT2qELSI=;
 b=vhONA91wYdIwH/hN1lawh0UwAiuvCi8QJXePuVSU2jyodPlKTHEwgSpyz2D29ps541Q4MEhy48GY1mLRIvji/XI/HZArTY+A3MPl2pxmjbbIP6T51/HtxE6Yy+jHWnEmabEcSGi9n6jO6f32o1nzm6GK5DcLcLgyQOfQd4l/XjIBMwiaT46ks6Z4PES4dTwzi+bq4qiduhykQLz+6ZTF96+vawepC3dh+r7vHE4KRKfvoYs8i3CfSb914Rosd7lWP+wMk9JOInd6nc1nOblL6qfbupmIUJFUF+kui5mxx4+CJ5MHFBtzuIxzEWjD+WBrBrSEFtYOH0F/hHs2MEIP+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ifbkal0vJ8xIfj/W32X7lA4g/5//r7yGiBwaT2qELSI=;
 b=xfipen+qb25KLTlI/JEVy9AMp3n1NYrDuAayD2+6iySRZcbgELFvmgNZFSX9qPH79O83kqB0TD+9hbxL4RP2vkddVnuZ1mCCUmOacfJBz1ff60hML6uQ6GpnF2RSi3HZp4U1s4KcOfskKVMYKRjmKIIsGSmpkd37vdePZphsvrs=
Received: from BYAPR08CA0026.namprd08.prod.outlook.com (2603:10b6:a03:100::39)
 by BN7PPFA42F4F89B.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::6dd) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.11; Tue, 23 Dec
 2025 14:14:51 +0000
Received: from SJ5PEPF000001CF.namprd05.prod.outlook.com
 (2603:10b6:a03:100:cafe::c3) by BYAPR08CA0026.outlook.office365.com
 (2603:10b6:a03:100::39) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.11 via Frontend Transport; Tue,
 23 Dec 2025 14:14:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001CF.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9456.9 via Frontend Transport; Tue, 23 Dec 2025 14:14:49 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 23 Dec 2025 08:14:46 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, =?UTF-8?q?Christian=20K=C3=B6nig?=
 <ckoenig.leichtzumerken@gmail.com>, Leo Liu <leo.liu@amd.com>, Ruijing Dong
 <ruijing.dong@amd.com>, David Wu <David.Wu3@amd.com>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v3 1/2] drm/amdgpu: Drop MMIO_REMAP domain bit and keep it
 Internal
Date: Tue, 23 Dec 2025 19:44:26 +0530
Message-ID: <20251223141427.36850-2-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251223141427.36850-1-srinivasan.shanmugam@amd.com>
References: <20251217092200.703080-1-srinivasan.shanmugam@amd.com>
 <20251223141427.36850-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CF:EE_|BN7PPFA42F4F89B:EE_
X-MS-Office365-Filtering-Correlation-Id: 422de692-97a8-47e8-786d-08de422da252
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aGZhaFVmaGU4MTNCM1VyRjRKUnRXTnBuS2RnQzNKUnlpQXF1K2U0aWJsRTEx?=
 =?utf-8?B?YnlCU2ZiaDlia1Y2aStWdU9UcnBUc1hBWXY0OTVENFNNaUk5WXhvUEZmL3ky?=
 =?utf-8?B?aTRxU3RMZ3N0VWhSeVR5OFFVRitVYUdUaWQ3ZktvTERuWTdaQXVvR2NCZDUr?=
 =?utf-8?B?K0RTYnNsZXZzRmhpbS84MThhbGlvd2Z2c2xMait5VlZRVG52TWFveVY4MlRT?=
 =?utf-8?B?c0grSytTeXF5NzRxeEF5WklCd0JnWVlJem15a0RITE8xY0J0cm43azBsaUcx?=
 =?utf-8?B?Sm9nS3Z1RVArNWdMTzFSNFVoZ01nM2ptRE8wMm4vRGk1VnNuTU5KdmJPUFBv?=
 =?utf-8?B?ckpQeFJXc1dnWFJ5ckRleHFOOVJEMjB2bGhPVTQwWjc5dGhEQVBuQ1RoaGhC?=
 =?utf-8?B?MWxta0R3OXhmMnVMV0tKRitYQXIyS2t0ME9QQWdmaGtZb1NGb0p6N2lxb0pu?=
 =?utf-8?B?OEZQSERRdXQ0bjg0SjVLaFB1OHlNRmRJVGVCZDgrd1RYVlpIMk9JMXorRE5H?=
 =?utf-8?B?SUVnMW1nandZK0tTeHlVUjhSd2pNR05GMUdqbUJ1dDZQSGlIak5HK251TjlZ?=
 =?utf-8?B?ckY2cmc3eWdzSFpGdnI3UlZiMWovSXphTThRMThSVnRmM3RKd1JnN0NNZDdI?=
 =?utf-8?B?MUpnSU0rWnEyTVY2MmRGRkx5NHM4YmtybXJZZERudURVQngxOGtKanFVNmpl?=
 =?utf-8?B?WjQyR2R4UUZwTENlQy9JZ093cGM4d2JXSXJOeHFQckk1b0NHYlQwNEM0Vmd5?=
 =?utf-8?B?WHE3QXBCWmJ5QnQyS0tjb1NueWkxTGd2NlczZVR5MjhjK0tqbkhHa1NEenp0?=
 =?utf-8?B?WEpUVUdmVm9qR2lMRU9idjJVWEZvenhqZS85VDdrM0p2Uk5iN0J5dzRMQ0pv?=
 =?utf-8?B?S200Y0ZUYTBWb3IyU3pyenNZNGY3WU1xSFppZ0czQVdqUEdBU3V2SVM3dEhh?=
 =?utf-8?B?cGgySlZabTh0UkZiY3RrR1NGVXVYK252cjFlMndKczJGbnlMdWNRdGtWbnlo?=
 =?utf-8?B?dDlOSjFEdk9kd3VQRGMwcXA3dFNQRStJbHVLSGg1QUhzYWhQRFZ4N0ZIbzlD?=
 =?utf-8?B?NHJTV09Md0xJSFl5bXljdlRMdjNpdnRBZnY5dzdydElhVXllY0ZNRUZBdFJC?=
 =?utf-8?B?NDkvWDFGR2JJb3d2SkYwRjF3R3B6bWtIMjJNNDBhUWNlMFZHL3EzalByUThn?=
 =?utf-8?B?UjBhVGlpQlpFb3pmZEplNWw5VEZ4b3VydzZSaGQ0dm9ZcWFSTkR0SDhOR2J3?=
 =?utf-8?B?UVBBckZyRzRkY3pSRW95QVFka1B0ZGpobFVlM0QxaWJKdjBDYlJMeGU1RDFO?=
 =?utf-8?B?QStpcXBHaExCQnJmV2xNMlI5d2w1SktrSmJ4clA0dnFISUJBWTZFNkdaaENl?=
 =?utf-8?B?ZFFaRHh6eXI3YlNXVzV5OTcvT0EyVEZLbmMyVS9RSEtuRkFjM2R1eEFJUjNN?=
 =?utf-8?B?Mks1ajBYbm15RXpjQjFvL3BGWjlYVkJhUWFkRkZ0ZGpJd3BDYVZSSjBjdVI0?=
 =?utf-8?B?elFoSDRRazF5WWwwaktjQXFyUVo2ZVlxTkNGTFZ5TkNaZUFGSFFUUXl2dFky?=
 =?utf-8?B?eGJLN09qRG1jeCt3YTBLa1BkYVUrM2k1SmdDeFpBd2NTTkhWSFVpV1BNUEk4?=
 =?utf-8?B?OWQ2QU9PMUo3RWliRzZ4a0VGV3N6ZTBialJQOFdRRElLTHA4QkpUWlVkN3lW?=
 =?utf-8?B?UUxadlg4OG1QYmhNT01IV2Z1RHUvdFBDTCtVYWdWYVFyZjI5Q0I1T3VDQjR3?=
 =?utf-8?B?OXdRZWpJd20vNGtDd2dqNTJ0QVV1SCtVU0JkNm1HZVkxNjdBZ2JWQTFFVTh4?=
 =?utf-8?B?bEQvZ0JkNTliSmZ1WnlySzFFM0U2dzNuYVhWSU5ma0I4NHVtSk9zaS95MkVr?=
 =?utf-8?B?d0hjR21TdmV6MVNQTkNYMForMWlpK3NaWWdYbHFPWGRTTUUrK010UkhucUpY?=
 =?utf-8?B?N3B5TTFDZU0ycDN4d0xTQmpJZ1dIdGdleVprcUQ4M3M3N2ZVeHRBenJyMW5U?=
 =?utf-8?B?Y294Ykt3OVZ4LzFsaFl3V3d4UEFEQVpTKzUxbDZCaXlKY2FGMlZSM0JiS24v?=
 =?utf-8?B?OUlvSEg2eEcwK2J5ZlhJTFFicUZ2Ykg3bjM5WUZLZmg3R3Bja29VY2ZxOW1E?=
 =?utf-8?Q?g7sc=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2025 14:14:49.6127 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 422de692-97a8-47e8-786d-08de422da252
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001CF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPFA42F4F89B
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

From: Christian König <ckoenig.leichtzumerken@gmail.com>

"AMDGPU_GEM_DOMAIN_MMIO_REMAP" - Never activated as UAPI and it turned
out that this was to inflexible.

Allocate the MMIO_REMAP buffer object as a regular GEM BO and explicitly
move it into the fixed AMDGPU_PL_MMIO_REMAP placement at the TTM level.

This avoids relying on GEM domain bits for MMIO_REMAP, keeps the
placement purely internal, and makes the lifetime and pinning of the
global MMIO_REMAP BO explicit. The BO is pinned in TTM so it cannot be
migrated or evicted.

The corresponding free path relies on normal DRM teardown ordering,
where no further user ioctls can access the global BO once TTM teardown
begins.

v2 (Srini):
- Updated patch title.
- Drop use of AMDGPU_GEM_DOMAIN_MMIO_REMAP in amdgpu_ttm.c. The
  MMIO_REMAP domain bit is removed from UAPI, so keep the MMIO_REMAP BO
  allocation domain-less (bp.domain = 0) and rely on the TTM placement
  (AMDGPU_PL_MMIO_REMAP) for backing/pinning.
- Keep fdinfo/mem-stats visibility for MMIO_REMAP by classifying BOs
  based on bo->tbo.resource->mem_type == AMDGPU_PL_MMIO_REMAP, since the
  domain bit is removed.

v3: Squash patches #1 & #3

Fixes: dd2bf86d1383 ("drm/amdgpu/uapi: Introduce AMDGPU_GEM_DOMAIN_MMIO_REMAP")
Fixes: 2f711aebfa64 ("drm/amdgpu/ttm: Allocate/Free 4K MMIO_REMAP Singleton")
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Leo Liu <leo.liu@amd.com>
Cc: Ruijing Dong <ruijing.dong@amd.com>
Cc: David (Ming Qiang) Wu <David.Wu3@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c    |  3 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 21 +++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h |  2 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c    | 77 ++++++++++++++--------
 include/uapi/drm/amdgpu_drm.h              |  6 +-
 5 files changed, 60 insertions(+), 49 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index 9b81a6677f90..b46b61297f68 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -458,9 +458,6 @@ int amdgpu_gem_create_ioctl(struct drm_device *dev, void *data,
 	/* always clear VRAM */
 	flags |= AMDGPU_GEM_CREATE_VRAM_CLEARED;
 
-	if (args->in.domains & AMDGPU_GEM_DOMAIN_MMIO_REMAP)
-		return -EINVAL;
-
 	/* create a gem object to contain this object in */
 	if (args->in.domains & (AMDGPU_GEM_DOMAIN_GDS |
 	    AMDGPU_GEM_DOMAIN_GWS | AMDGPU_GEM_DOMAIN_OA)) {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index b676310ce9ac..1fb956400696 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -153,14 +153,6 @@ void amdgpu_bo_placement_from_domain(struct amdgpu_bo *abo, u32 domain)
 		c++;
 	}
 
-	if (domain & AMDGPU_GEM_DOMAIN_MMIO_REMAP) {
-		places[c].fpfn = 0;
-		places[c].lpfn = 0;
-		places[c].mem_type = AMDGPU_PL_MMIO_REMAP;
-		places[c].flags = 0;
-		c++;
-	}
-
 	if (domain & AMDGPU_GEM_DOMAIN_GTT) {
 		places[c].fpfn = 0;
 		places[c].lpfn = 0;
@@ -1546,8 +1538,17 @@ u64 amdgpu_bo_gpu_offset_no_check(struct amdgpu_bo *bo)
  */
 uint32_t amdgpu_bo_mem_stats_placement(struct amdgpu_bo *bo)
 {
-	uint32_t domain = bo->preferred_domains & AMDGPU_GEM_DOMAIN_MASK;
+	u32 domain;
 
+	/*
+	 * MMIO_REMAP is internal now, so it no longer maps from a userspace
+	 * domain bit. Keep fdinfo/mem-stats visibility by checking the actual
+	 * TTM placement.
+	 */
+	if (bo->tbo.resource && bo->tbo.resource->mem_type == AMDGPU_PL_MMIO_REMAP)
+		return AMDGPU_PL_MMIO_REMAP;
+
+	domain = bo->preferred_domains & AMDGPU_GEM_DOMAIN_MASK;
 	if (!domain)
 		return TTM_PL_SYSTEM;
 
@@ -1566,8 +1567,6 @@ uint32_t amdgpu_bo_mem_stats_placement(struct amdgpu_bo *bo)
 		return AMDGPU_PL_OA;
 	case AMDGPU_GEM_DOMAIN_DOORBELL:
 		return AMDGPU_PL_DOORBELL;
-	case AMDGPU_GEM_DOMAIN_MMIO_REMAP:
-		return AMDGPU_PL_MMIO_REMAP;
 	default:
 		return TTM_PL_SYSTEM;
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
index 52c2d1731aab..912c9afaf9e1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
@@ -168,8 +168,6 @@ static inline unsigned amdgpu_mem_type_to_domain(u32 mem_type)
 		return AMDGPU_GEM_DOMAIN_OA;
 	case AMDGPU_PL_DOORBELL:
 		return AMDGPU_GEM_DOMAIN_DOORBELL;
-	case AMDGPU_PL_MMIO_REMAP:
-		return AMDGPU_GEM_DOMAIN_MMIO_REMAP;
 	default:
 		break;
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index f27ffe64aafa..6d7a5bf2d0c8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1909,42 +1909,45 @@ static void amdgpu_ttm_pools_fini(struct amdgpu_device *adev)
 }
 
 /**
- * amdgpu_ttm_mmio_remap_bo_init - Allocate the singleton 4K MMIO_REMAP BO
+ * amdgpu_ttm_mmio_remap_bo_init - Allocate the singleton MMIO_REMAP BO
  * @adev: amdgpu device
  *
- * Allocates a one-page (4K) GEM BO in AMDGPU_GEM_DOMAIN_MMIO_REMAP when the
+ * Allocates a global BO with backing AMDGPU_PL_MMIO_REMAP when the
  * hardware exposes a remap base (adev->rmmio_remap.bus_addr) and the host
  * PAGE_SIZE is <= AMDGPU_GPU_PAGE_SIZE (4K). The BO is created as a regular
  * GEM object (amdgpu_bo_create).
  *
- * The BO is created as a normal GEM object via amdgpu_bo_create(), then
- * reserved and pinned at the TTM level (ttm_bo_pin()) so it can never be
- * migrated or evicted. No CPU mapping is established here.
- *
  * Return:
  *  * 0 on success or intentional skip (feature not present/unsupported)
  *  * negative errno on allocation failure
  */
-static int amdgpu_ttm_mmio_remap_bo_init(struct amdgpu_device *adev)
+static int amdgpu_ttm_alloc_mmio_remap_bo(struct amdgpu_device *adev)
 {
+	struct ttm_operation_ctx ctx = { false, false };
+	struct ttm_placement placement;
+	struct ttm_buffer_object *tbo;
+	struct ttm_place placements;
 	struct amdgpu_bo_param bp;
+	struct ttm_resource *tmp;
 	int r;
 
 	/* Skip if HW doesn't expose remap, or if PAGE_SIZE > AMDGPU_GPU_PAGE_SIZE (4K). */
 	if (!adev->rmmio_remap.bus_addr || PAGE_SIZE > AMDGPU_GPU_PAGE_SIZE)
 		return 0;
 
+	/*
+	 * Allocate a BO first and then move it to AMDGPU_PL_MMIO_REMAP.
+	 * The initial TTM resource assigned by amdgpu_bo_create() is
+	 * replaced below with a fixed MMIO_REMAP placement.
+	 */
 	memset(&bp, 0, sizeof(bp));
-
-	/* Create exactly one GEM BO in the MMIO_REMAP domain. */
-	bp.type        = ttm_bo_type_device;          /* userspace-mappable GEM */
-	bp.size        = AMDGPU_GPU_PAGE_SIZE;        /* 4K */
+	bp.type        = ttm_bo_type_device;
+	bp.size        = AMDGPU_GPU_PAGE_SIZE;
 	bp.byte_align  = AMDGPU_GPU_PAGE_SIZE;
-	bp.domain      = AMDGPU_GEM_DOMAIN_MMIO_REMAP;
+	bp.domain      = 0;
 	bp.flags       = 0;
 	bp.resv        = NULL;
 	bp.bo_ptr_size = sizeof(struct amdgpu_bo);
-
 	r = amdgpu_bo_create(adev, &bp, &adev->rmmio_remap.bo);
 	if (r)
 		return r;
@@ -1953,42 +1956,60 @@ static int amdgpu_ttm_mmio_remap_bo_init(struct amdgpu_device *adev)
 	if (r)
 		goto err_unref;
 
+	tbo = &adev->rmmio_remap.bo->tbo;
+
 	/*
 	 * MMIO_REMAP is a fixed I/O placement (AMDGPU_PL_MMIO_REMAP).
-	 * Use TTM-level pin so the BO cannot be evicted/migrated,
-	 * independent of GEM domains. This
-	 * enforces the “fixed I/O window”
 	 */
-	ttm_bo_pin(&adev->rmmio_remap.bo->tbo);
+	placement.num_placement = 1;
+	placement.placement = &placements;
+	placements.fpfn = 0;
+	placements.lpfn = 0;
+	placements.mem_type = AMDGPU_PL_MMIO_REMAP;
+	placements.flags = 0;
+	/* Force the BO into the fixed MMIO_REMAP placement */
+	r = ttm_bo_mem_space(tbo, &placement, &tmp, &ctx);
+	if (unlikely(r))
+		goto err_unlock;
+
+	ttm_resource_free(tbo, &tbo->resource);
+	ttm_bo_assign_mem(tbo, tmp);
+	ttm_bo_pin(tbo);
 
 	amdgpu_bo_unreserve(adev->rmmio_remap.bo);
 	return 0;
 
+err_unlock:
+	amdgpu_bo_unreserve(adev->rmmio_remap.bo);
+
 err_unref:
-	if (adev->rmmio_remap.bo)
-		amdgpu_bo_unref(&adev->rmmio_remap.bo);
+	amdgpu_bo_unref(&adev->rmmio_remap.bo);
 	adev->rmmio_remap.bo = NULL;
 	return r;
 }
 
 /**
- * amdgpu_ttm_mmio_remap_bo_fini - Free the singleton MMIO_REMAP BO
+ * amdgpu_ttm_free_mmio_remap_bo - Free the singleton MMIO_REMAP BO
  * @adev: amdgpu device
  *
  * Frees the kernel-owned MMIO_REMAP BO if it was allocated by
  * amdgpu_ttm_mmio_remap_bo_init().
  */
-static void amdgpu_ttm_mmio_remap_bo_fini(struct amdgpu_device *adev)
+static void amdgpu_ttm_free_mmio_remap_bo(struct amdgpu_device *adev)
 {
-	struct amdgpu_bo *bo = adev->rmmio_remap.bo;
-
-	if (!bo)
-		return;   /* <-- safest early exit */
+	if (!adev->rmmio_remap.bo)
+		return;
 
 	if (!amdgpu_bo_reserve(adev->rmmio_remap.bo, true)) {
 		ttm_bo_unpin(&adev->rmmio_remap.bo->tbo);
 		amdgpu_bo_unreserve(adev->rmmio_remap.bo);
 	}
+
+    /*
+     * At this point we rely on normal DRM teardown ordering:
+     * no new user ioctls can access the global MMIO_REMAP BO
+     * once TTM teardown begins.
+     */
 	amdgpu_bo_unref(&adev->rmmio_remap.bo);
 	adev->rmmio_remap.bo = NULL;
 }
@@ -2169,8 +2190,8 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
 		return r;
 	}
 
-	/* Allocate the singleton MMIO_REMAP BO (4K) if supported */
-	r = amdgpu_ttm_mmio_remap_bo_init(adev);
+	/* Allocate the singleton MMIO_REMAP BO if supported */
+	r = amdgpu_ttm_alloc_mmio_remap_bo(adev);
 	if (r)
 		return r;
 
@@ -2238,7 +2259,7 @@ void amdgpu_ttm_fini(struct amdgpu_device *adev)
 	amdgpu_bo_free_kernel(&adev->mman.sdma_access_bo, NULL,
 					&adev->mman.sdma_access_ptr);
 
-	amdgpu_ttm_mmio_remap_bo_fini(adev);
+	amdgpu_ttm_free_mmio_remap_bo(adev);
 	amdgpu_ttm_fw_reserve_vram_fini(adev);
 	amdgpu_ttm_drv_reserve_vram_fini(adev);
 
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index 9680548ee41b..ab2bf47553e1 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -105,8 +105,6 @@ extern "C" {
  *
  * %AMDGPU_GEM_DOMAIN_DOORBELL	Doorbell. It is an MMIO region for
  * signalling user mode queues.
- *
- * %AMDGPU_GEM_DOMAIN_MMIO_REMAP	MMIO remap page (special mapping for HDP flushing).
  */
 #define AMDGPU_GEM_DOMAIN_CPU		0x1
 #define AMDGPU_GEM_DOMAIN_GTT		0x2
@@ -115,15 +113,13 @@ extern "C" {
 #define AMDGPU_GEM_DOMAIN_GWS		0x10
 #define AMDGPU_GEM_DOMAIN_OA		0x20
 #define AMDGPU_GEM_DOMAIN_DOORBELL	0x40
-#define AMDGPU_GEM_DOMAIN_MMIO_REMAP	0x80
 #define AMDGPU_GEM_DOMAIN_MASK		(AMDGPU_GEM_DOMAIN_CPU | \
 					 AMDGPU_GEM_DOMAIN_GTT | \
 					 AMDGPU_GEM_DOMAIN_VRAM | \
 					 AMDGPU_GEM_DOMAIN_GDS | \
 					 AMDGPU_GEM_DOMAIN_GWS | \
 					 AMDGPU_GEM_DOMAIN_OA |	\
-					 AMDGPU_GEM_DOMAIN_DOORBELL | \
-					 AMDGPU_GEM_DOMAIN_MMIO_REMAP)
+					 AMDGPU_GEM_DOMAIN_DOORBELL)
 
 /* Flag that CPU access will be required for the case of VRAM domain */
 #define AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED	(1 << 0)
-- 
2.34.1

