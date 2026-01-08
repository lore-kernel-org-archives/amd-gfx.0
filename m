Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47342D1D482
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Jan 2026 17:14:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CCD1510E7A1;
	Thu,  8 Jan 2026 17:14:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dyVamz/s";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010033.outbound.protection.outlook.com [52.101.85.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C9A4410E7A1
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Jan 2026 17:14:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BM7l+n5KsUR6+rdu5VWEGb96TW7Pt0kXxTK1z/BoJMzJX6m3didu/40aZgaxvriaSABJ3cSrF6Lolo1zLn1b1YD9pR+AV90JhKQFZ+jWBhRnoObjfwzN/a7g3WczNmKnDh3WR8XAMzIvYQOsIy1Sglf2gzMjwLyy2cHtaT8UdNDnKhkL/Mfz0U25fnoVQH2lWyemdBFUGXU66MYbdqf8wNel9iWf84PZEGXNT4GGVbHcj04b3QrWCLy9HW5C8dNzSMNAlgcq12hDKpOEXAOxochkwrqc0Dhk3r9f/0tlHPfYJEwGIjpb0FKYJ60YZLIxIBxo+JxFhx2IMg5C7ALGJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+R765nPejDXl4MhpICLcqhPUcZWNqjvcGXw1or8Qa1o=;
 b=sQBO0JBsvza5HBZOhC1s7YeqRg0oeY0SmxOHKsJnw12rHLrCgdme0Jm4itkMm+AF3rYi7gb07K7DbKM7I6FBRKPQ46eLi8I/+tTjAQYPk59x/sS2ALVYBIGtpyu5SVuUi4NkAvC2D9jpTbTVWJxCstIEoOj7X+P/aWG87nEurmdh5BmLnOpYQ+Txzvwf/k6fJK0iaT5EuO6WSWss7DhcmNu11/veWAgCWAw0Uyt8ACV5koSXj13rSZR9LbxKXX+ZnUd8i7ILZf1kwolmEbpejXvTZE0h43L8a+Y9XpwHbHtwkSxCkuVwdURWmvZ08zlMTqBlhXda4HofOiGX0I+X/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+R765nPejDXl4MhpICLcqhPUcZWNqjvcGXw1or8Qa1o=;
 b=dyVamz/sybvrUXW9v4DZmSgdeESUZinQJY74PxsQ4C0zfheNibcBy94iYFf8N5h8jZyhspzEASqry9HUX+T7STQgaL17XNyfZ/ppc9CibIQbqVrKWaBjMMukMP66uBPV8iaP+CjtfZ31K4lYwr7ZTuj/Y4oqcAXwuWMwR5COVwo=
Received: from CH0PR04CA0082.namprd04.prod.outlook.com (2603:10b6:610:74::27)
 by DS2PR12MB9638.namprd12.prod.outlook.com (2603:10b6:8:27b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Thu, 8 Jan
 2026 17:14:17 +0000
Received: from DS2PEPF00003447.namprd04.prod.outlook.com
 (2603:10b6:610:74:cafe::79) by CH0PR04CA0082.outlook.office365.com
 (2603:10b6:610:74::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.4 via Frontend Transport; Thu, 8
 Jan 2026 17:14:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS2PEPF00003447.mail.protection.outlook.com (10.167.17.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Thu, 8 Jan 2026 17:14:13 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 8 Jan 2026 11:14:10 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?=
 <ckoenig.leichtzumerken@gmail.com>, Leo Liu <leo.liu@amd.com>, Ruijing Dong
 <ruijing.dong@amd.com>, David Wu <David.Wu3@amd.com>
Subject: [v3,1/2] drm/amdgpu: Drop MMIO_REMAP domain bit and keep it Internal
Date: Thu, 8 Jan 2026 22:43:53 +0530
Message-ID: <20251223141427.36850-2-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-Patchwork-Id: 696201
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003447:EE_|DS2PR12MB9638:EE_
X-MS-Office365-Filtering-Correlation-Id: f07579ab-bf2a-453d-2681-08de4ed958c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aWVlSXhzWmhxZFJUSHhGVGxWVHArSnJ6TUlPREJBTHhDWm9VRXBUT2t1bW9C?=
 =?utf-8?B?RTdIUW5XUWhaSTdIdVEvWGQyd2ZJZW9RNGs1ZVlGdDdqV0hUZnJmcWNLODhy?=
 =?utf-8?B?RHRWS25xNlN4bDlYM0FncU0zckFqOFB4Y202SDNVVityMHJvRndDTHFPc2Vm?=
 =?utf-8?B?TGhJam9JY2RPYTJ0eFhuRStLam1OWEtOekNOSFdMS0Z3RXhKT3ZJOGNYMzIy?=
 =?utf-8?B?TDdPQSs4TmJBOEFQNlFMTzVUWVdNVW1Tcm5xa2tYeFFtKzYrUWMxRHBuN1Ex?=
 =?utf-8?B?Zlk1ZEltYUtCc1hoUEdxMk5iQUUwVWorYTd0UGF3eXAvS1gzcmVyRUlkNVZ4?=
 =?utf-8?B?MG1FZzFyM3FEMkoxa21Uc3FnMEtUM0NnVHpGanFEWllZTjlzUkREb1NMZ3ow?=
 =?utf-8?B?MWlaRGtSR1VjQ3RLTE13TisxbEhzNVFWWk9HK1ZFdnVlK05LbmxFNzFkRlVi?=
 =?utf-8?B?bUozUU1EZ2o1OHZnSnR2SnErc1g5TjR5dnhwNFRPU1NjQ2ptcFZkMlA1ckN0?=
 =?utf-8?B?WkFkVzFpaDV1anU4dlJEVFhmTklVMTVKajhMYW9YV01pRU5ISjBlUG8xUmNo?=
 =?utf-8?B?ZmpnbzhWZ2VoajF5SStlUTZYa2Vyd3pvWEgwd2huZU1wT0hJVVZIQVdMMjJu?=
 =?utf-8?B?QXlYcU0wMGNaQ2R4Qlp1cU1pbHlIcWtGaWduUjd2VFRUcndwVWVabHA1ZFM5?=
 =?utf-8?B?VWxTampZc2VKMFJEN1dtOVkwU3VsR0FqR09tTVc0c0tOYzJQRFM1R0R6Qk1O?=
 =?utf-8?B?TFpVY0l2RDZ0eld1ZVZDR0E5U2ZZS2xBSFliQ0NPUnM3SEo0SC8xZkErOWxE?=
 =?utf-8?B?N21mMStSMjBuRnVDaVZEd2RGeFF6STFjV1V2NnZrYlorMDBlaDB1bHVOcS9W?=
 =?utf-8?B?VWhxN2liaGhTREJnMDBteWNMdWVtVDR0dmRUR1FQM1NXbklzMmx6THdXRW5y?=
 =?utf-8?B?L0FudW1FNGoya05lamg5alJJRkVRS0lMOFZGNEhSc1BJN3d1emUrRVRVODB1?=
 =?utf-8?B?MG5NTTBmWlFOYkZpNHBjYVZXNDFuZFlydDM5Vk50OWY1YWZxT21laGducUpT?=
 =?utf-8?B?K2loVVU1YnJHSTI5aWpvWnk1b1RyWWJFSUd3R3B6dXFMdHQwYyt0Vk43NEIy?=
 =?utf-8?B?aEVGUGVSdXlISWkwZ0xTaS9JU2tCU1dCSlpKY1JWWTE2eFQ1a1kvSzFIYkpw?=
 =?utf-8?B?cHlLM3B1UXVoVmJraldVUmw5VThIZ3hBQTJtYWlCWHM5UWx6R25WM2tmRTMv?=
 =?utf-8?B?VUs1bjBqRmd4THdKQ3I1OS9yYXRrWFFJa2d3U0VnVlIyQ2ExWmtGN3NUYmda?=
 =?utf-8?B?T0h5NFU1V3lucVFwY21XbXRlSjRXS1h1Qm5GZFJCckl0OEU1bVpzVmRWVDNw?=
 =?utf-8?B?TGlLRkxacXVDM2pUSGhWY3RwdmdJdDVwM2h3eTZUeXpLeG1RUHhFR0NUTWha?=
 =?utf-8?B?NVhwOExUNFIxczdqOXEwdVgraDNacmpZNFhKUzl4ajJoNFZPelU4N2RWaWhn?=
 =?utf-8?B?Um1RNEd3Y09UZ2lPL2Fkb1VoTE41RDlWbWtxQkhtMVArOHprMVl0UCtWV0d0?=
 =?utf-8?B?enQ2N1ZnUEsxZXJ6Z1NRekNDNXZ4Z0dWNjJxOUM0UDhOWGFUVFE3cHRuaGZi?=
 =?utf-8?B?MWQyYnhKdzcwS1cyMmV4RmRxZ3p4amxFV2F2anpYS3pzczFWUWxyUjRjd0cy?=
 =?utf-8?B?bWNKMVNMcHRLT0pJb2p3SEZaUlMxTXdNSXFjYVNMeWJ2bnhiNm1mYm5uS2hh?=
 =?utf-8?B?dFYxUkt3R2huTDZabThnTmoyMldxU2Ftc2x2QkJyeDBDTXQwVUFDRE5YK01J?=
 =?utf-8?B?bmsyS2tMY1JjcFNnUFJqWkM2TDhHcUk5SEZvNFFPakh0YTl4ZlMrT28xZUVo?=
 =?utf-8?B?SzlZejJHcFhlSnBhcFl4dUN6aXNGM2lRNDd1Tmg3Rm8rRE1SVjdqclhzd2d3?=
 =?utf-8?B?S0xxZGR0ZzZHVUNrK3Yra2gxZ2NkRVJGL2o0RGRrQnh0M29lMmdrdmRKdEFm?=
 =?utf-8?B?WUpsaXFKUGJpUDBHNnJod3RNQWs1UHZENnRPUis1U1JvTUJYNDZUK2s0U2dB?=
 =?utf-8?B?REl1ZzhsaThuVE4zakZ5eVFISlJVcHdPd2R4NU1lZ1RsbEZ3c3JqZWJDenQw?=
 =?utf-8?Q?/nPk=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 17:14:13.6579 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f07579ab-bf2a-453d-2681-08de4ed958c5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003447.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9638
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
Message-ID: <20260108171353.0waSwI-_aQ6lnhGm-rh1jRdTGGXBqte948T7d-y58Vg@z>

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
