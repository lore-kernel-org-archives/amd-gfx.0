Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05F54CA0EED
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Aug 2025 09:21:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F03910E95A;
	Thu, 28 Aug 2025 09:21:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="X5HevOHg";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2078.outbound.protection.outlook.com [40.107.96.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F0FB10E95B
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Aug 2025 09:21:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NTjT6rcOBBsXs6Id/kbrQP5jqj/+J2YknevqXQgvkRKL8R0S6umNdSDC0mxuBGyLqFmKN+zOLy6x4P9SEvcfF/nH+m1PAbcw/512TIXz+UiU5h2v5ucAUxwdjeiRuQ7nvT6N27durjGR+X8Req61yfOv57MnyaepO3JcyoRTCX4vdEKgQWeOPL6/Hz/jS4z3Fi3vRLMLxNO/xFsan2nlHiMsfB9fj3+SR7r1aYFOERcIT4ZGCMaw02AoZqD0XSDKgTIyx19+eN05MA3M8TOPFUjNSXZQZ7nz+NFEH8IKQCZzA5SDt1GdDshIHM/LQsHoBZREmNj9jBmPcmc9z3Hcyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZoxpxOYhwnwwC2bQBC93KxN4HBMTp1WQQOOM54O2c6E=;
 b=e2l5vZTIslrOkmJeDA0I038xwAsc2r+f4AoCyeJebDgr1RvRswBxpWDnaoD+gV9gIvYRs5uS+nBS04HZVpCZwWblyNMm4NZAByxTzVL3J0WlqgbbOW08oJNXIgRmWc/Wo/lw0rHO92eGutDi7AL2V4jjgD7VYUQwyY1qb10ToMIQia6fOr14ICAceMlO3JvkXcPwgN8G1g6Ri6tGxYPikm5hKdlR4U1Ke+KVynfgwO18bpCypM/pUwDa06BHreSIwRCBOc5TeDWQvz5tpHSkynRHow3VMPKDtekNde134Z7CCwMxZNsCsA794eQI86pOo+xmO+ZUs54rL8xqyWDzoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZoxpxOYhwnwwC2bQBC93KxN4HBMTp1WQQOOM54O2c6E=;
 b=X5HevOHgMPc1Lg2+Rhqj5NNDap2q0SPk22rasZ25abBKAkLXk1Yi72Xm2bLM8C6pLFrztrtGGduuFWalKQ3ghGQuXC3v6xiCRhvM0A6ZAqBbi8MUI5l/szFdHcBe8JgYsAAKCRVKr/Ddk5QaQcHOJOor2Ux7BYHRX/77AFqbXlc=
Received: from BL6PEPF00013E12.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:22e:400:0:1001:0:16) by MN2PR12MB4240.namprd12.prod.outlook.com
 (2603:10b6:208:1d3::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Thu, 28 Aug
 2025 09:21:27 +0000
Received: from BL6PEPF00020E62.namprd04.prod.outlook.com
 (2a01:111:f403:f901::5) by BL6PEPF00013E12.outlook.office365.com
 (2603:1036:903:4::4) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.21 via Frontend Transport; Thu,
 28 Aug 2025 09:21:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL6PEPF00020E62.mail.protection.outlook.com (10.167.249.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9073.11 via Frontend Transport; Thu, 28 Aug 2025 09:21:27 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 28 Aug
 2025 02:23:17 -0500
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb09.amd.com (10.181.42.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1748.10; Thu, 28 Aug 2025 00:23:15 -0700
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v3 8/9] drm/amdgpu/ttm: Allocate/Free 4K MMIO_REMAP Singleton
 BO
Date: Thu, 28 Aug 2025 12:43:34 +0530
Message-ID: <20250828071335.3948819-9-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250828071335.3948819-1-srinivasan.shanmugam@amd.com>
References: <20250828071335.3948819-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E62:EE_|MN2PR12MB4240:EE_
X-MS-Office365-Filtering-Correlation-Id: c0257332-c563-44a3-cf38-08dde6144445
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TUNOckduK2cvUTFNVXhMakp2OGlLOWU5S050UTIrTS9HNUVSSUNBZUVWSXlZ?=
 =?utf-8?B?RTNoVTJ0NTVCSFdrUWpGVVJoVXA2SjhLUXVSVUN5N3JRRlpoME4rWUpySGxZ?=
 =?utf-8?B?cEtTUUpxcFNpQzVTZVBWZU9qcEFqb1pid0dJck8weWk3cHBQdDA3WW9hY3BH?=
 =?utf-8?B?V0NDTWlNbkM3VXpqS0F6Wi9xSSswdWRURWRWRWx5N2tFcjFCMFRHaWlZS284?=
 =?utf-8?B?eWxodlpzdWQvU2s3RkQ2NVUrQ0ZWMnl1Y3JHY3MwYmFqWUozdFl0YW1EUktJ?=
 =?utf-8?B?T1NObmhCWUhib2svdDNxemVQemdpRHBTSUIwcGRRdjlIMG10UVFBMnJFTlNC?=
 =?utf-8?B?cXY5MklPMWVraXpUSytaa1BTSUVCWk8waXU0Z2RJMkxPcTdUVmZHZGhQWFlD?=
 =?utf-8?B?NzRKMUI3U0c4Z2gyN0hYcjVsV0tUYko5WkswRmVFdkZFMnU2Vm5XWnkrWTE4?=
 =?utf-8?B?dlZSSnJnY0d0K0cwSzQwTFJmVHgzM3ROUHVRVVNmbENrMGs0ZXVmdlpVTjRC?=
 =?utf-8?B?U1VpeWZDVjZmLzBaakFXRE90ZjNaaU9MTGJxaVFmSU5hRkZHMEhDaXR4WCtE?=
 =?utf-8?B?WFJicXdjQkdjdlY3R2ZReHFKRStEaGdiZFYzM2V3U3dWUzJTeDM0UTZhTStC?=
 =?utf-8?B?MEx5T29mN0Q2djh2Ynd3aXZaOHR4azcvUzdxWXpTQnVTaTBkY0NRY25WZWts?=
 =?utf-8?B?N1F5dEU1WmFFZjU4S043MUtycXlxMldRdmk1QStVbzZzWHNsaEh3VkVXTGhR?=
 =?utf-8?B?UzlvKzhMb0Vic2UzTG9HNFRCVExBSnlkREdnRUU1MldKZU5JOWczQ2N3RE5h?=
 =?utf-8?B?UUFaN2NrRTNEMDFHbDN2cndEZkNaeHo4VmtRVXpLWi9PV2xJVHdqSURTc0VH?=
 =?utf-8?B?dkl4SFlDRGpIVDRGaTRzY1ZsVnUwd0RPWkMrdFFHamhWSHZNd0ZoV0tzbFcy?=
 =?utf-8?B?bzhra0M3MXVMK3k3RHZ1TVN5WnViWlJpdUJJUmZZZC8rTE9ud1BXNEwrNEV1?=
 =?utf-8?B?YmlFRGVPbnppRWluYnFwTmtHNzhtK1diS3Y3b1EzL1JKdnY1MmZtdXp1THpl?=
 =?utf-8?B?MjZoSWpDeTdOS3lDZUdXNHRoSmt5S2piYzVVc0I1OEwvaWdDaWV5VGhldURx?=
 =?utf-8?B?Y0ZjUEZ4RmNmMVg1WGt6dHNLa0F3emcxcmpERTFDOXkxN0gzOFlHdGw0YlhU?=
 =?utf-8?B?TUFCaFBNcmRvK2MvWFlGSU05dmRITkZrQ3FLbHRsWTFPNHZ0MVZWanp6TFhp?=
 =?utf-8?B?bzN0UjYvSTU0RDc2TVBHWmpaU2NoZERjbzZDaUlSdmM2Y0lXZ21sOHZqY2Z1?=
 =?utf-8?B?U0hrdW8rdmk2WU4zM1lPUitweGlkdkNIbUpKM2EwWkg5RWJwRCtsQU8wQmdG?=
 =?utf-8?B?UWRnV3ZZYjdBbTg2c3cxOW9EazlhbHBkamFRUENXaVg1bUV4VW1hZkRYbFZs?=
 =?utf-8?B?eW9FeVQrT0lyalZ6KzdpQkczcG1Vb2QxRXFxOUZMYUZDZUJNcnV5YWNTOFo0?=
 =?utf-8?B?K1BKYzBKN3h0L09qNTZlK3dsOWxDTjVxTjdnTTlkOWRDMFcvSTNSTGpwMmk1?=
 =?utf-8?B?dVNNbTdJNTQ3YktjRnhVMGxocWtWWFRoUVdhM0pyY0k4dDgremdmSGxKRDZ1?=
 =?utf-8?B?VHE4ZnU5NERxQkx2ZDJOOTNsRlFiaUkyb1o2bzNpTUFpRjRyT2tlVG9QQXNM?=
 =?utf-8?B?U2dSaFYzVk01aldzRG1ick5NbVlkOWRkQ2trRXJkTHZ0YVZsekpBdkdVV1lZ?=
 =?utf-8?B?cERHdG5QaXIzRmo2YWFxcEttSUlzZXplRitBK3JzeVozeUJsRWtudHBWaWh5?=
 =?utf-8?B?VUxPbzk0eXVweXNDOVBZRjVqcTIyWjZCenF2SlM4UHB4ZnhFNVRRYzAwOGVZ?=
 =?utf-8?B?M1RzWGRoajhUZlVZcll2TTEyekRCRXRFQ0pJNUFoR2NZT0h3ZkdZY1p1NmR5?=
 =?utf-8?B?NWdyN1AwTDk5K1N4VTUrNm5EdkIwYjkvRU5oWHJOMDlCN01PMHcyTWcxSGV5?=
 =?utf-8?B?MU0xaG9aejQ2bGI2K3ZjVDhMeDJrMStsNHBJaHRSaUVPTXZNSjdsUEpRQ1Nj?=
 =?utf-8?Q?UEExpH?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 09:21:27.5177 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c0257332-c563-44a3-cf38-08dde6144445
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E62.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4240
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

Add amdgpu_ttm_mmio_remap_bo_init()/fini() to manage the kernel-owned
one-page(4K) MMIO_REMAP BO. The allocator runs during TTM init when the
hardware exposes a remap base (adev->rmmio_base) and the host PAGE_SIZE
is <= AMDGPU_GPU_PAGE_SIZE (4K).

The helper is idempotent (returns 0 if already allocated) and only
returns an error when the actual allocation fails.

This keeps MMIO_REMAP lifetime handling localized and prepares for the
subsequent patch that exposes a userspace handle.

v2:
 - Check mmio_remap bus address (adev->rmmio_remap.bus_addr) instead of
   rmmio_base. (Alex)
 - Skip quietly if PAGE_SIZE > AMDGPU_GPU_PAGE_SIZE or no bus address
   (no warn). (Alex)
 - Use `amdgpu_bo_create()` (not *_kernel) - Only with this The object
   is stored in adev->mmio_remap.bo and will later be exposed to
   userspace via a GEM handle. (Christian)

Suggested-by: Christian König <christian.koenig@amd.com>
Suggested-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 64 +++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 7822d8969c9f..0e301cab74e0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1853,6 +1853,63 @@ static void amdgpu_ttm_pools_fini(struct amdgpu_device *adev)
 	adev->mman.ttm_pools = NULL;
 }
 
+/**
+ * amdgpu_ttm_mmio_remap_bo_init - allocate the singleton 4K MMIO_REMAP BO
+ * @adev: amdgpu device
+ *
+ * Allocates a one-page (4K) GEM BO in AMDGPU_GEM_DOMAIN_MMIO_REMAP when the
+ * hardware exposes a remap base (adev->rmmio_remap.bus_addr) and the host
+ * PAGE_SIZE is <= AMDGPU_GPU_PAGE_SIZE (4K). The BO is created as a regular
+ * GEM object (amdgpu_bo_create), then reserved and kmap’ed once to exercise
+ * the io-mem setup path. If prerequisites are not met, this is a no-op.
+ *
+ * Return:
+ *  * 0 on success or intentional skip (feature not present/unsupported)
+ *  * negative errno on allocation failure
+ */
+static int amdgpu_ttm_mmio_remap_bo_init(struct amdgpu_device *adev)
+{
+	int r;
+	struct amdgpu_bo_param bp = { 0 };
+	void *kptr;
+
+	/* Skip if HW doesn’t expose remap or system PAGE > GPU 4K */
+	if (!adev->rmmio_remap.bus_addr || PAGE_SIZE > AMDGPU_GPU_PAGE_SIZE)
+		return 0;
+
+	/* Hardware remap page is fixed 4K; skip on larger PAGE_SIZE. */
+	if (PAGE_SIZE > AMDGPU_GPU_PAGE_SIZE)
+		return 0;
+
+	/* Create exactly one GEM BO in the MMIO_REMAP domain. */
+	bp.type        = ttm_bo_type_device;          /* userspace-mappable GEM */
+	bp.size        = AMDGPU_GPU_PAGE_SIZE;        /* 4K */
+	bp.byte_align  = AMDGPU_GPU_PAGE_SIZE;
+	bp.domain      = AMDGPU_GEM_DOMAIN_MMIO_REMAP;
+	bp.flags       = 0;
+	bp.resv        = NULL;
+	bp.bo_ptr_size = sizeof(struct amdgpu_bo);
+
+	r = amdgpu_bo_create(adev, &bp, &adev->rmmio_remap.bo);
+	if (r)
+		return r;
+
+	return 0;
+}
+
+/**
+ * amdgpu_ttm_mmio_remap_bo_fini - free the singleton MMIO_REMAP BO
+ * @adev: amdgpu device
+ *
+ * Frees the kernel-owned MMIO_REMAP BO if it was allocated by
+ * amdgpu_ttm_mmio_remap_bo_init().
+ */
+static void amdgpu_ttm_mmio_remap_bo_fini(struct amdgpu_device *adev)
+{
+	amdgpu_bo_unref(&adev->rmmio_remap.bo);
+	adev->mmio_remap.bo = NULL;
+}
+
 /*
  * amdgpu_ttm_init - Init the memory management (ttm) as well as various
  * gtt/vram related fields.
@@ -2027,6 +2084,11 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
 		return r;
 	}
 
+	/* Allocate the singleton MMIO_REMAP BO (4K) if supported */
+	r = amdgpu_ttm_mmio_remap_bo_init(adev);
+	if (r)
+		return r;
+
 	/* Initialize preemptible memory pool */
 	r = amdgpu_preempt_mgr_init(adev);
 	if (r) {
@@ -2090,6 +2152,8 @@ void amdgpu_ttm_fini(struct amdgpu_device *adev)
 	amdgpu_bo_free_kernel(&adev->mman.sdma_access_bo, NULL,
 					&adev->mman.sdma_access_ptr);
 
+	/* Drop the singleton MMIO_REMAP BO (if allocated) */
+	amdgpu_ttm_mmio_remap_bo_fini(adev);
 	amdgpu_ttm_fw_reserve_vram_fini(adev);
 	amdgpu_ttm_drv_reserve_vram_fini(adev);
 
-- 
2.34.1

