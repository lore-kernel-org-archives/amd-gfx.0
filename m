Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 022E3C02198
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Feb 2025 08:44:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9158010E2D8;
	Wed, 12 Feb 2025 08:44:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="C7KkXOwO";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2086.outbound.protection.outlook.com [40.107.220.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D1BA010E2D8
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Feb 2025 08:44:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nBkKR0tPUSOJuLtMLs0c2AHR6G31tVYXPWBT+ZKrCKqpH+XEGgERZHM4Y6NY2t8vPPry5U1I5EGgeVtYTPf1GaRllRTq6c146GreIsOBdPK2blgeYlEuA7UsAFL4bCzaLYpkyC9I6m8N2lmprkO7lwV9dVAZpAPvn/44I7TaPYq/EFVXh0k6+vk2y/XNigh3yxBRrE3iwOMbHenR25jo5osaZPiFmmgQIpsGXjxANnRDxgZSIQHE2aaNbnp5vs7KpSGyMFGi3lgPQVIW//C6ZZoEmjfNdReNr7e+tqoNPxJwCOUdOeH6LWtPUAwNvmfMe5q9cPGgLVm8KAHJjX7yRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V9Q50auGCeT92mk5b5MjaDJ3TAdhPTA8ysTpbD16mD0=;
 b=ltEUNkrMP4XJ+KaciJirszFxAAFO6R0H4YCo5fBe2ORptJuOqGu+rBDi0esNgbC5loNFNh1/R6vOcCrRZ6sSoKsyWkiA4A7/QPamCVHoZlXc6UYB/oaWtwj6/UV9UiwELBUThb732xWueOQBrNx4SyG4JwLolZlb7x1lI8tHhnVUTn4Xl+hKOfNp3xEQsTzF/tJrDGK9kvDYyHl2Pg21sEXcmYd1eqNBBAhdUNSeZ8RhM89T29j6KkOisyKNvREJq+yO66nmehiM0wh0IFkVZkNaOaIA8wq9RtL3xI90sM5+flJOr83/77Gbgy1hQOiJpXsPz/canj1UEpybhsMjAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V9Q50auGCeT92mk5b5MjaDJ3TAdhPTA8ysTpbD16mD0=;
 b=C7KkXOwO+99H4JCLhQieRn4js5Gy0pp5/+Ef97f2+6lch26IAY/QPhghIeHQBE7NMbfdsOXlugpFWWA+MsKVXhP4Yh8C/9kWGGoC+d1vgRQPmiNovHPwf2MC7dbbyOaSSoA6Wn1iIrBK/7i3F9g1yb9WEpHzqGxXE5aoy5SH52M=
Received: from MW4P223CA0001.NAMP223.PROD.OUTLOOK.COM (2603:10b6:303:80::6) by
 DS7PR12MB5792.namprd12.prod.outlook.com (2603:10b6:8:77::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8422.12; Wed, 12 Feb 2025 08:44:26 +0000
Received: from CY4PEPF0000EDD2.namprd03.prod.outlook.com
 (2603:10b6:303:80:cafe::c4) by MW4P223CA0001.outlook.office365.com
 (2603:10b6:303:80::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.31 via Frontend Transport; Wed,
 12 Feb 2025 08:44:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD2.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8445.10 via Frontend Transport; Wed, 12 Feb 2025 08:44:25 +0000
Received: from saleem-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 12 Feb
 2025 02:44:22 -0600
From: Saleemkhan Jamadar <saleemkhan.jamadar@amd.com>
To: <alexander.deucher@amd.com>, <Christian.Koenig@amd.com>,
 <amd-gfx@lists.freedesktop.org>
CC: <veerabadhran.gopalakrishnan@amd.com>, <leo.liu@amd.com>, "Saleemkhan
 Jamadar" <saleemkhan.jamadar@amd.com>, Christian Koenig
 <christian.koenig@amd.com>
Subject: [PATCH] drm/amdgpu/umsch: remove vpe test from umsch
Date: Wed, 12 Feb 2025 14:14:02 +0530
Message-ID: <20250212084402.3598063-1-saleemkhan.jamadar@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD2:EE_|DS7PR12MB5792:EE_
X-MS-Office365-Filtering-Correlation-Id: 43f5c4bf-5773-42a7-a610-08dd4b417467
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?d3BkTXJ4QlluelZQRFhhVDlURmJLVjk3RmxhWW0zZVliSUZPMDU5Wnc1VUVt?=
 =?utf-8?B?ZENLZkNmZmY4ZEc2a09WWXIxRThjUm95Y2Mrb2t0Z2EreHhpUnRVMU52WHVH?=
 =?utf-8?B?dU41eWRvQTc0LzNvbGVmU05QUzFFY0MwQ01ERENsZ1J4U2pibGV1cnVJbnNP?=
 =?utf-8?B?YWd3djYwNEtDNkgxZldYamgxUFNEQ1l5UXlORGd2WW1vVXJLL3U2QVBSejRK?=
 =?utf-8?B?aWo2SnVqSE5JTkdtVVNCZW9makhMQTNPVFR1b0hUY2hvdTRkZ2JKQVpWQTB4?=
 =?utf-8?B?QUV2QXZuR2hYQ2ZvYUNUampHUnJ6OXc5aFhTQk44NWhZOHZDR2ZieEg0OExS?=
 =?utf-8?B?dks3dkJGNG9mN2hUelJVaDdhZlhrWVU3Z3JpRU1sTkxFZERrZnBuR0graE9Y?=
 =?utf-8?B?Z0ZxUXh4TTJobGtsNlE5TW85bmZWTlRJem5uWC9tQzRLVlZ0UW1xUGxtWjZL?=
 =?utf-8?B?VXV5MnQxdVJWYk5wOTc5b3A1OGFEUFF5MFBOblBveDZ5VWdhTVY2dHUzNjZU?=
 =?utf-8?B?NGxLVGhwbTJ4L3c0WURXQ0xlZk0rMUNPYXZ5eDRCZmhWN2hLM1BPVDRZL3FJ?=
 =?utf-8?B?Ui9GV0hVY1NXeS9RRlZ4dzZSL21UQ0k0R2FIekU4clJlTjlQajVTMVVKUmQx?=
 =?utf-8?B?VnYvbmJ2Q0JDWHNjWm44cS94UGxIak8vaHVsT1ltV21Fc3ZTNU5UdXgyaExy?=
 =?utf-8?B?M21La1liVHVWaXRteDBDRWtEc2kvYmdCcjVxV2dvaFVvWGpXVWRVTEN2a0VE?=
 =?utf-8?B?Z2NQeFBVRWowdjFkbms0M005bnc1bTZkcWtRU2RjWW5sQ0ZBR252OCt2by9U?=
 =?utf-8?B?RlMweWtSOFpQN25uU2VuWU1iUkxOK0ZXNTVPTTVPSlpYTEVQb3QzVjNZZkFY?=
 =?utf-8?B?QWp3bTN3VmlPTEVOSkxINW1xVTl6T2phQklvVldVRjFGMGlBMFhDYW1pMHNS?=
 =?utf-8?B?cjNJN2RVTHJTWGRRSENDVkNJRE02RWd1NUhrVnRoVG4xcTRjSFIwU2JCMFlW?=
 =?utf-8?B?WW5Qd1U5dUxpOFBTZmdRaVZoeGtPc3dHZ2lreTVCS3kyTExxdFFpd2MxNTlE?=
 =?utf-8?B?cHkwdWZKWVJldFFFbTJSWmcxNXFNWWpjOGRGQUJZcEVtWUR1Um5oL3dKOU9M?=
 =?utf-8?B?bDFRTmxYUDltMFlmNGswQ2xOM05xTHZSNVdobi8vR2k3NnhuQ2lMZHdITTFG?=
 =?utf-8?B?Ymx6c2kxUGFJWWRmeUdhYU1kMEN0ZmVRWjhNRkRVVmVCY3J2WkFJMFc1T2Vt?=
 =?utf-8?B?MTRWckUyL210dWlGcS9ucHk0MnFVYjFRaFhRUE9sRnVNVjZ3SW1GdXZJNmdo?=
 =?utf-8?B?WUZOaVlDYkRKVGVVTTYrMFFOWmpGVWVGN1l0a2x1a2pEaHJIM1hwZHlnOGp4?=
 =?utf-8?B?Y09sbGMvT0FVd0pQOVIrVnM4alUzeEx1NkJIVEo5dUhsbURwM01sL1o5eS9y?=
 =?utf-8?B?QWY0MVdra2FhMkFqRGtWc0dFTVFhWHpXUnE1WmgzM2Q3clA3UlpGejM4aHJt?=
 =?utf-8?B?T3VKcFJ5RE9kaHpoRjdCcVhjYUF2Ykh3NUdTZjNxUStCZGtKd3lkRjJJbktm?=
 =?utf-8?B?eEJlMzVLRHg5YVkyRmpMWnY1bXBpaXRySGhLc1NHYUlPREJLRHFlNEdzMlFv?=
 =?utf-8?B?OWZMSDVSQjA4ajJTS1YzS3BXVlRDNVh1V0xsREdVODlUOGVzYVpFRElybW81?=
 =?utf-8?B?NWIxVUp5YmNZd29ZRFBLMU1CWUIwR0ZpcHBQVUpKaDhxVVNGTnR5dDhQUXRU?=
 =?utf-8?B?RmNoLzdOYW9vdzJYMFhWNW5ZZHFDeUl6Q3dlYUxMVHF4STNodmcxS2NuZFpp?=
 =?utf-8?B?cWNaNTF0dVV4b0o2Z0dNSDg1VFp3RWorR3lvVHp3N3oxaTdyY1YzeWdoaUVK?=
 =?utf-8?B?UHc5dy9UUDZYZk9WTVczOFFzbDhMVWg4VHpNZy8zdUY3MExCWnBGcVhVdXFi?=
 =?utf-8?B?MG1va2czTWluYmpXd21jMU1wbHgrVW1FdjNJRWMwSXZWd0ZsaEd4dTkzTXNF?=
 =?utf-8?Q?sE5NxrVOfjeEn3pPADiW5PSBk/KKqk=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2025 08:44:25.2666 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 43f5c4bf-5773-42a7-a610-08dd4b417467
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5792
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

current test is more intrusive for user queue test

Signed-off-by: Saleemkhan Jamadar <saleemkhan.jamadar@amd.com>
Suggested-by: Christian Koenig <christian.koenig@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c | 459 +------------------
 1 file changed, 1 insertion(+), 458 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c
index ba550c7e2118..2cfa2447d13e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c
@@ -32,463 +32,6 @@
 #include "amdgpu_umsch_mm.h"
 #include "umsch_mm_v4_0.h"
 
-struct umsch_mm_test_ctx_data {
-	uint8_t process_csa[PAGE_SIZE];
-	uint8_t vpe_ctx_csa[PAGE_SIZE];
-	uint8_t vcn_ctx_csa[PAGE_SIZE];
-};
-
-struct umsch_mm_test_mqd_data {
-	uint8_t vpe_mqd[PAGE_SIZE];
-	uint8_t vcn_mqd[PAGE_SIZE];
-};
-
-struct umsch_mm_test_ring_data {
-	uint8_t vpe_ring[PAGE_SIZE];
-	uint8_t vpe_ib[PAGE_SIZE];
-	uint8_t vcn_ring[PAGE_SIZE];
-	uint8_t vcn_ib[PAGE_SIZE];
-};
-
-struct umsch_mm_test_queue_info {
-	uint64_t mqd_addr;
-	uint64_t csa_addr;
-	uint32_t doorbell_offset_0;
-	uint32_t doorbell_offset_1;
-	enum UMSCH_SWIP_ENGINE_TYPE engine;
-};
-
-struct umsch_mm_test {
-	struct amdgpu_bo	*ctx_data_obj;
-	uint64_t		ctx_data_gpu_addr;
-	uint32_t		*ctx_data_cpu_addr;
-
-	struct amdgpu_bo	*mqd_data_obj;
-	uint64_t		mqd_data_gpu_addr;
-	uint32_t		*mqd_data_cpu_addr;
-
-	struct amdgpu_bo	*ring_data_obj;
-	uint64_t		ring_data_gpu_addr;
-	uint32_t		*ring_data_cpu_addr;
-
-
-	struct amdgpu_vm	*vm;
-	struct amdgpu_bo_va	*bo_va;
-	uint32_t		pasid;
-	uint32_t		vm_cntx_cntl;
-	uint32_t		num_queues;
-};
-
-static int map_ring_data(struct amdgpu_device *adev, struct amdgpu_vm *vm,
-			  struct amdgpu_bo *bo, struct amdgpu_bo_va **bo_va,
-			  uint64_t addr, uint32_t size)
-{
-	struct amdgpu_sync sync;
-	struct drm_exec exec;
-	int r;
-
-	amdgpu_sync_create(&sync);
-
-	drm_exec_init(&exec, 0, 0);
-	drm_exec_until_all_locked(&exec) {
-		r = drm_exec_lock_obj(&exec, &bo->tbo.base);
-		drm_exec_retry_on_contention(&exec);
-		if (unlikely(r))
-			goto error_fini_exec;
-
-		r = amdgpu_vm_lock_pd(vm, &exec, 0);
-		drm_exec_retry_on_contention(&exec);
-		if (unlikely(r))
-			goto error_fini_exec;
-	}
-
-	*bo_va = amdgpu_vm_bo_add(adev, vm, bo);
-	if (!*bo_va) {
-		r = -ENOMEM;
-		goto error_fini_exec;
-	}
-
-	r = amdgpu_vm_bo_map(adev, *bo_va, addr, 0, size,
-			     AMDGPU_PTE_READABLE | AMDGPU_PTE_WRITEABLE |
-			     AMDGPU_PTE_EXECUTABLE);
-
-	if (r)
-		goto error_del_bo_va;
-
-
-	r = amdgpu_vm_bo_update(adev, *bo_va, false);
-	if (r)
-		goto error_del_bo_va;
-
-	amdgpu_sync_fence(&sync, (*bo_va)->last_pt_update);
-
-	r = amdgpu_vm_update_pdes(adev, vm, false);
-	if (r)
-		goto error_del_bo_va;
-
-	amdgpu_sync_fence(&sync, vm->last_update);
-
-	amdgpu_sync_wait(&sync, false);
-	drm_exec_fini(&exec);
-
-	amdgpu_sync_free(&sync);
-
-	return 0;
-
-error_del_bo_va:
-	amdgpu_vm_bo_del(adev, *bo_va);
-	amdgpu_sync_free(&sync);
-
-error_fini_exec:
-	drm_exec_fini(&exec);
-	amdgpu_sync_free(&sync);
-	return r;
-}
-
-static int unmap_ring_data(struct amdgpu_device *adev, struct amdgpu_vm *vm,
-			    struct amdgpu_bo *bo, struct amdgpu_bo_va *bo_va,
-			    uint64_t addr)
-{
-	struct drm_exec exec;
-	long r;
-
-	drm_exec_init(&exec, 0, 0);
-	drm_exec_until_all_locked(&exec) {
-		r = drm_exec_lock_obj(&exec, &bo->tbo.base);
-		drm_exec_retry_on_contention(&exec);
-		if (unlikely(r))
-			goto out_unlock;
-
-		r = amdgpu_vm_lock_pd(vm, &exec, 0);
-		drm_exec_retry_on_contention(&exec);
-		if (unlikely(r))
-			goto out_unlock;
-	}
-
-
-	r = amdgpu_vm_bo_unmap(adev, bo_va, addr);
-	if (r)
-		goto out_unlock;
-
-	amdgpu_vm_bo_del(adev, bo_va);
-
-out_unlock:
-	drm_exec_fini(&exec);
-
-	return r;
-}
-
-static void setup_vpe_queue(struct amdgpu_device *adev,
-			    struct umsch_mm_test *test,
-			    struct umsch_mm_test_queue_info *qinfo)
-{
-	struct MQD_INFO *mqd = (struct MQD_INFO *)test->mqd_data_cpu_addr;
-	uint64_t ring_gpu_addr = test->ring_data_gpu_addr;
-
-	mqd->rb_base_lo = (ring_gpu_addr >> 8);
-	mqd->rb_base_hi = (ring_gpu_addr >> 40);
-	mqd->rb_size = PAGE_SIZE / 4;
-	mqd->wptr_val = 0;
-	mqd->rptr_val = 0;
-	mqd->unmapped = 1;
-
-	if (adev->vpe.collaborate_mode)
-		memcpy(++mqd, test->mqd_data_cpu_addr, sizeof(struct MQD_INFO));
-
-	qinfo->mqd_addr = test->mqd_data_gpu_addr;
-	qinfo->csa_addr = test->ctx_data_gpu_addr +
-		offsetof(struct umsch_mm_test_ctx_data, vpe_ctx_csa);
-	qinfo->doorbell_offset_0 = 0;
-	qinfo->doorbell_offset_1 = 0;
-}
-
-static void setup_vcn_queue(struct amdgpu_device *adev,
-			    struct umsch_mm_test *test,
-			    struct umsch_mm_test_queue_info *qinfo)
-{
-}
-
-static int add_test_queue(struct amdgpu_device *adev,
-			  struct umsch_mm_test *test,
-			  struct umsch_mm_test_queue_info *qinfo)
-{
-	struct umsch_mm_add_queue_input queue_input = {};
-	int r;
-
-	queue_input.process_id = test->pasid;
-	queue_input.page_table_base_addr = amdgpu_gmc_pd_addr(test->vm->root.bo);
-
-	queue_input.process_va_start = 0;
-	queue_input.process_va_end = adev->vm_manager.max_pfn - 1;
-
-	queue_input.process_quantum = 100000; /* 10ms */
-	queue_input.process_csa_addr = test->ctx_data_gpu_addr +
-				       offsetof(struct umsch_mm_test_ctx_data, process_csa);
-
-	queue_input.context_quantum = 10000; /* 1ms */
-	queue_input.context_csa_addr = qinfo->csa_addr;
-
-	queue_input.inprocess_context_priority = CONTEXT_PRIORITY_LEVEL_NORMAL;
-	queue_input.context_global_priority_level = CONTEXT_PRIORITY_LEVEL_NORMAL;
-	queue_input.doorbell_offset_0 = qinfo->doorbell_offset_0;
-	queue_input.doorbell_offset_1 = qinfo->doorbell_offset_1;
-
-	queue_input.engine_type = qinfo->engine;
-	queue_input.mqd_addr = qinfo->mqd_addr;
-	queue_input.vm_context_cntl = test->vm_cntx_cntl;
-
-	amdgpu_umsch_mm_lock(&adev->umsch_mm);
-	r = adev->umsch_mm.funcs->add_queue(&adev->umsch_mm, &queue_input);
-	amdgpu_umsch_mm_unlock(&adev->umsch_mm);
-	if (r)
-		return r;
-
-	return 0;
-}
-
-static int remove_test_queue(struct amdgpu_device *adev,
-			     struct umsch_mm_test *test,
-			     struct umsch_mm_test_queue_info *qinfo)
-{
-	struct umsch_mm_remove_queue_input queue_input = {};
-	int r;
-
-	queue_input.doorbell_offset_0 = qinfo->doorbell_offset_0;
-	queue_input.doorbell_offset_1 = qinfo->doorbell_offset_1;
-	queue_input.context_csa_addr = qinfo->csa_addr;
-
-	amdgpu_umsch_mm_lock(&adev->umsch_mm);
-	r = adev->umsch_mm.funcs->remove_queue(&adev->umsch_mm, &queue_input);
-	amdgpu_umsch_mm_unlock(&adev->umsch_mm);
-	if (r)
-		return r;
-
-	return 0;
-}
-
-static int submit_vpe_queue(struct amdgpu_device *adev, struct umsch_mm_test *test)
-{
-	struct MQD_INFO *mqd = (struct MQD_INFO *)test->mqd_data_cpu_addr;
-	uint32_t *ring = test->ring_data_cpu_addr +
-		offsetof(struct umsch_mm_test_ring_data, vpe_ring) / 4;
-	uint32_t *ib = test->ring_data_cpu_addr +
-		offsetof(struct umsch_mm_test_ring_data, vpe_ib) / 4;
-	uint64_t ib_gpu_addr = test->ring_data_gpu_addr +
-		offsetof(struct umsch_mm_test_ring_data, vpe_ib);
-	uint32_t *fence = ib + 2048 / 4;
-	uint64_t fence_gpu_addr = ib_gpu_addr + 2048;
-	const uint32_t test_pattern = 0xdeadbeef;
-	int i;
-
-	ib[0] = VPE_CMD_HEADER(VPE_CMD_OPCODE_FENCE, 0);
-	ib[1] = lower_32_bits(fence_gpu_addr);
-	ib[2] = upper_32_bits(fence_gpu_addr);
-	ib[3] = test_pattern;
-
-	ring[0] = VPE_CMD_HEADER(VPE_CMD_OPCODE_INDIRECT, 0);
-	ring[1] = (ib_gpu_addr & 0xffffffe0);
-	ring[2] = upper_32_bits(ib_gpu_addr);
-	ring[3] = 4;
-	ring[4] = 0;
-	ring[5] = 0;
-
-	mqd->wptr_val = (6 << 2);
-	if (adev->vpe.collaborate_mode)
-		(++mqd)->wptr_val = (6 << 2);
-
-	WDOORBELL32(adev->umsch_mm.agdb_index[CONTEXT_PRIORITY_LEVEL_NORMAL], mqd->wptr_val);
-
-	for (i = 0; i < adev->usec_timeout; i++) {
-		if (*fence == test_pattern)
-			return 0;
-		udelay(1);
-	}
-
-	dev_err(adev->dev, "vpe queue submission timeout\n");
-
-	return -ETIMEDOUT;
-}
-
-static int submit_vcn_queue(struct amdgpu_device *adev, struct umsch_mm_test *test)
-{
-	return 0;
-}
-
-static int setup_umsch_mm_test(struct amdgpu_device *adev,
-			  struct umsch_mm_test *test)
-{
-	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_MMHUB0(0)];
-	int r;
-
-	test->vm_cntx_cntl = hub->vm_cntx_cntl;
-
-	test->vm = kzalloc(sizeof(*test->vm), GFP_KERNEL);
-	if (!test->vm) {
-		r = -ENOMEM;
-		return r;
-	}
-
-	r = amdgpu_vm_init(adev, test->vm, -1);
-	if (r)
-		goto error_free_vm;
-
-	r = amdgpu_pasid_alloc(16);
-	if (r < 0)
-		goto error_fini_vm;
-	test->pasid = r;
-
-	r = amdgpu_bo_create_kernel(adev, sizeof(struct umsch_mm_test_ctx_data),
-				    PAGE_SIZE, AMDGPU_GEM_DOMAIN_GTT,
-				    &test->ctx_data_obj,
-				    &test->ctx_data_gpu_addr,
-				    (void **)&test->ctx_data_cpu_addr);
-	if (r)
-		goto error_free_pasid;
-
-	memset(test->ctx_data_cpu_addr, 0, sizeof(struct umsch_mm_test_ctx_data));
-
-	r = amdgpu_bo_create_kernel(adev, PAGE_SIZE,
-				    PAGE_SIZE, AMDGPU_GEM_DOMAIN_GTT,
-				    &test->mqd_data_obj,
-				    &test->mqd_data_gpu_addr,
-				    (void **)&test->mqd_data_cpu_addr);
-	if (r)
-		goto error_free_ctx_data_obj;
-
-	memset(test->mqd_data_cpu_addr, 0, PAGE_SIZE);
-
-	r = amdgpu_bo_create_kernel(adev, sizeof(struct umsch_mm_test_ring_data),
-				    PAGE_SIZE, AMDGPU_GEM_DOMAIN_GTT,
-				    &test->ring_data_obj,
-				    NULL,
-				    (void **)&test->ring_data_cpu_addr);
-	if (r)
-		goto error_free_mqd_data_obj;
-
-	memset(test->ring_data_cpu_addr, 0, sizeof(struct umsch_mm_test_ring_data));
-
-	test->ring_data_gpu_addr = AMDGPU_VA_RESERVED_BOTTOM;
-	r = map_ring_data(adev, test->vm, test->ring_data_obj, &test->bo_va,
-			  test->ring_data_gpu_addr, sizeof(struct umsch_mm_test_ring_data));
-	if (r)
-		goto error_free_ring_data_obj;
-
-	return 0;
-
-error_free_ring_data_obj:
-	amdgpu_bo_free_kernel(&test->ring_data_obj, NULL,
-			      (void **)&test->ring_data_cpu_addr);
-error_free_mqd_data_obj:
-	amdgpu_bo_free_kernel(&test->mqd_data_obj, &test->mqd_data_gpu_addr,
-			      (void **)&test->mqd_data_cpu_addr);
-error_free_ctx_data_obj:
-	amdgpu_bo_free_kernel(&test->ctx_data_obj, &test->ctx_data_gpu_addr,
-			      (void **)&test->ctx_data_cpu_addr);
-error_free_pasid:
-	amdgpu_pasid_free(test->pasid);
-error_fini_vm:
-	amdgpu_vm_fini(adev, test->vm);
-error_free_vm:
-	kfree(test->vm);
-
-	return r;
-}
-
-static void cleanup_umsch_mm_test(struct amdgpu_device *adev,
-				  struct umsch_mm_test *test)
-{
-	unmap_ring_data(adev, test->vm, test->ring_data_obj,
-			test->bo_va, test->ring_data_gpu_addr);
-	amdgpu_bo_free_kernel(&test->mqd_data_obj, &test->mqd_data_gpu_addr,
-			      (void **)&test->mqd_data_cpu_addr);
-	amdgpu_bo_free_kernel(&test->ring_data_obj, NULL,
-			      (void **)&test->ring_data_cpu_addr);
-	amdgpu_bo_free_kernel(&test->ctx_data_obj, &test->ctx_data_gpu_addr,
-			       (void **)&test->ctx_data_cpu_addr);
-	amdgpu_pasid_free(test->pasid);
-	amdgpu_vm_fini(adev, test->vm);
-	kfree(test->vm);
-}
-
-static int setup_test_queues(struct amdgpu_device *adev,
-			     struct umsch_mm_test *test,
-			     struct umsch_mm_test_queue_info *qinfo)
-{
-	int i, r;
-
-	for (i = 0; i < test->num_queues; i++) {
-		if (qinfo[i].engine == UMSCH_SWIP_ENGINE_TYPE_VPE)
-			setup_vpe_queue(adev, test, &qinfo[i]);
-		else
-			setup_vcn_queue(adev, test, &qinfo[i]);
-
-		r = add_test_queue(adev, test, &qinfo[i]);
-		if (r)
-			return r;
-	}
-
-	return 0;
-}
-
-static int submit_test_queues(struct amdgpu_device *adev,
-			      struct umsch_mm_test *test,
-			      struct umsch_mm_test_queue_info *qinfo)
-{
-	int i, r;
-
-	for (i = 0; i < test->num_queues; i++) {
-		if (qinfo[i].engine == UMSCH_SWIP_ENGINE_TYPE_VPE)
-			r = submit_vpe_queue(adev, test);
-		else
-			r = submit_vcn_queue(adev, test);
-		if (r)
-			return r;
-	}
-
-	return 0;
-}
-
-static void cleanup_test_queues(struct amdgpu_device *adev,
-			      struct umsch_mm_test *test,
-			      struct umsch_mm_test_queue_info *qinfo)
-{
-	int i;
-
-	for (i = 0; i < test->num_queues; i++)
-		remove_test_queue(adev, test, &qinfo[i]);
-}
-
-static int umsch_mm_test(struct amdgpu_device *adev)
-{
-	struct umsch_mm_test_queue_info qinfo[] = {
-		{ .engine = UMSCH_SWIP_ENGINE_TYPE_VPE },
-	};
-	struct umsch_mm_test test = { .num_queues = ARRAY_SIZE(qinfo) };
-	int r;
-
-	r = setup_umsch_mm_test(adev, &test);
-	if (r)
-		return r;
-
-	r = setup_test_queues(adev, &test, qinfo);
-	if (r)
-		goto cleanup;
-
-	r = submit_test_queues(adev, &test, qinfo);
-	if (r)
-		goto cleanup;
-
-	cleanup_test_queues(adev, &test, qinfo);
-	cleanup_umsch_mm_test(adev, &test);
-
-	return 0;
-
-cleanup:
-	cleanup_test_queues(adev, &test, qinfo);
-	cleanup_umsch_mm_test(adev, &test);
-	return r;
-}
-
 int amdgpu_umsch_mm_submit_pkt(struct amdgpu_umsch_mm *umsch, void *pkt, int ndws)
 {
 	struct amdgpu_ring *ring = &umsch->ring;
@@ -792,7 +335,7 @@ static int umsch_mm_late_init(struct amdgpu_ip_block *ip_block)
 	if (amdgpu_in_reset(adev) || adev->in_s0ix || adev->in_suspend)
 		return 0;
 
-	return umsch_mm_test(adev);
+	return 0;
 }
 
 static int umsch_mm_sw_init(struct amdgpu_ip_block *ip_block)
-- 
2.34.1

