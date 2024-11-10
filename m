Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8CF2D12D46
	for <amd-gfx@archiver.kernel.org>; Sun, 10 Nov 2024 15:42:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3191B10E2D6;
	Sun, 10 Nov 2024 15:42:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kVd4oJfD";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2071.outbound.protection.outlook.com [40.107.95.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 995F010E2D3
 for <amd-gfx@lists.freedesktop.org>; Sun, 10 Nov 2024 15:42:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o6cOoiIjEyPS+2Cpuh0zjfTZw1CmIIBUkYJc7jSqmbxVTSdNlpjT5a8KyLakVGizMF3ZH6U14N1i+WkPOUluNl1LQzriWKzpePkDNtoMaGySBU0JefrPoemKWwuPu8u/2nelNOQBfAnFwv0gCMZfOzTiiBcobQxljhOeTaIA2SEq7vqXa8bB2N8F6i0bRUrqA6NxSdPDCnfkSqsQCBrrQlEqz2atRbvwbValJnf/U8zBog0WmUny3SS44EjdjhEbFI64m7B9sjhMIS7OaTFjiepb3FwJFx3pdIdFOh+OJfomZOCGB/C5WYFJ3W1ZU+j20m1M3rZiG7EgUOHb4hUEhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ifp5PgNAAPWo3EDRC7wCkoWUNSna9FTXdu8FNFkfzEI=;
 b=qjMLpNSZJ89mMEkTQAukqr1ozrlGuUTvEzrLpvesj0xpKYObPPIBV12BvHIZAfwQHDvmavttetkcK2F+AdsHpm6Y3RMFABCEqD92aMnXoZIKcI1Ydgh94uupXm+3fAqGvRLwmvwLaco7uHB60DEkRNm5gVCHdlCoIu0Bc+syDtPCfipU3PhCOBhwGPfsT1pIZy3ylMfuy7Ulk1vyMVkK/hC3qk2Hj5ZLau4nb1FsdkUObin2ThnDZgJ/zLrjEUnHJBGTBKBflACZq8Ac5BLnbrLwgQFJMD9/X3rstNCIkju5Tqb0Lo1elPQYDWzbmMLd8zje73t68SNPvukTFVof3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ifp5PgNAAPWo3EDRC7wCkoWUNSna9FTXdu8FNFkfzEI=;
 b=kVd4oJfD9d4C9KjwFHSkiUsvwBDaBhL+K48intr3XdztVZdmlaxV4DarPBfab0ESRfbFpox9T2rPg2IYvrqEGtb6UZfKPx5fFhifHlor883b1jvK59MQGksmZ4XLBspRlHKjDN638cpov3LE1OKjPeelaGbSlX6HCd5z87DH7Bg=
Received: from CH2PR14CA0007.namprd14.prod.outlook.com (2603:10b6:610:60::17)
 by LV3PR12MB9439.namprd12.prod.outlook.com (2603:10b6:408:20e::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.20; Sun, 10 Nov
 2024 15:42:27 +0000
Received: from CH1PEPF0000AD75.namprd04.prod.outlook.com
 (2603:10b6:610:60:cafe::d5) by CH2PR14CA0007.outlook.office365.com
 (2603:10b6:610:60::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28 via Frontend
 Transport; Sun, 10 Nov 2024 15:42:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD75.mail.protection.outlook.com (10.167.244.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Sun, 10 Nov 2024 15:42:26 +0000
Received: from MKM-L10-YUNXIA9.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 10 Nov
 2024 09:42:25 -0600
From: Yunxiang Li <Yunxiang.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <tvrtko.ursulin@igalia.com>
CC: <Alexander.Deucher@amd.com>, Yunxiang Li <Yunxiang.Li@amd.com>
Subject: [PATCH v7 3/4] drm/amdgpu: remove unused function parameter
Date: Sun, 10 Nov 2024 10:41:51 -0500
Message-ID: <20241110154152.592-4-Yunxiang.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241110154152.592-1-Yunxiang.Li@amd.com>
References: <20241110154152.592-1-Yunxiang.Li@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD75:EE_|LV3PR12MB9439:EE_
X-MS-Office365-Filtering-Correlation-Id: 24fafc42-8eec-46a6-61b3-08dd019e4753
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?T3ErR0NteTRFTVRucitrMzVJU1lSUkttU2ZsS3NkelBLcHpxZFhMK0E5eldl?=
 =?utf-8?B?WmtnbE40UTAvUGpJcGxXWWQ5Vm1iajVUS3l2dDRQMEdaRjBkaHl5UHB3c0do?=
 =?utf-8?B?YkdEbXg2YldlQWQ1Z0JIRitBTTBlQ2xTcmVKT1k4R2hIMWNxUHZBMTNmNDdl?=
 =?utf-8?B?dUM3aGRpUEtJZ2owbWw3TUV4bS9DNEFzRENVdkIyKzREUW9hMDZkOUFwdGUx?=
 =?utf-8?B?Wk03blpMdkNLVFZEeDNHRFA2S1c1Zjk4VlV3eVgxNjR5aVdRUHIwVmxWT0Rn?=
 =?utf-8?B?MGZqQlU3TGlBREIrNStwL2lSZzdrMkt0bzRzUWR1NHpoa2dXR3R1aGV3ZFpv?=
 =?utf-8?B?YXpsR0NQMGpRRUtld1A1VnJzRTNpQTQxaU5hZ3A3aC9INDI5Mno5U2dybVhU?=
 =?utf-8?B?cW52Z2ptcEVlQXBPWXY2bnZyZTZJOUUwcjkvdldEbW4rc2M2Zmo4TkNRSk5M?=
 =?utf-8?B?UFhrTkh5anRrenVEbzJ4dWlXMEZIeXUvTXdMaDVCNUxOaU5xN01nSUF6bTJ6?=
 =?utf-8?B?Sy96UHBBbVMveGpIb20yQm15M3JGUHh3Mmc2TER5NmExWnZ0bHVnTFVPUklv?=
 =?utf-8?B?S1M4eWNKdllCaTkxMTNoWE1wckRqeFVHenR3Zkp4dDlZV21JS0tPbnlTMVA3?=
 =?utf-8?B?MW1oL3NXR1VLOVNZbUtOMGdFejdCTnVVaXNqVU10NlJwanN5SytWcmZhTkNj?=
 =?utf-8?B?OUc5UmtSVEhPUUVzWTZGSE1DcFRMc2dTYjUrNVZrbnZhRExnVUIvRm10M2N1?=
 =?utf-8?B?UmlpZkRGQld2UUI1Y0RpMkxBckxLL1N3dTREMVluUVhGTUo0UEc3WlFseHZP?=
 =?utf-8?B?TWxkbmJENkhHQUlYNGw2SmM5RWRZMU8yVXM1L3JNTUJFbW16QTZzVWcwQkxI?=
 =?utf-8?B?QlBHcFEvQXpnaXZxNnkvODUybmxzVkN0bXVLbGl4QS9Hd2FLY3hJNTQxN0Rh?=
 =?utf-8?B?L1lYd09iS2RvTDhvRWgrZ3pqSnFYZk9nM0FGTHFISzNCWFRKSGxLN1A0c0ZN?=
 =?utf-8?B?MVJkRWtpYmp1MzNCZ3NRUUY1Mm9KWDZmQmIyYUt0RDhxQ0pMdnZCamVOeU5z?=
 =?utf-8?B?VWlVWnFsTklxbmhlNkF5Z3Y5dFMvNUhnYUhhaHNGNWI2aXZteVFsK3VVOUJk?=
 =?utf-8?B?U0FQZGoxQTRpZGZaYXFqMEJQanVEVk1MSlR5N3JPaEJ5ZGUxa1hGYkZqdDNP?=
 =?utf-8?B?VVIxSVM0UEM0SGg3dDRUTGttVGRqYnJWU2hDZWRPWGt4dmtHcG9ZSlU2RExS?=
 =?utf-8?B?YVlyNXZnNlhJL1RNdVlyeG1EcURDMjVOUVZ2NmdvSHR5bjY0YXh2dVBOSlZV?=
 =?utf-8?B?TzR4NWdwcUg5OXVOTWFCR1Y1R2dRT1c4QUhZbjBncURhQXltTkg3MmpXOTNW?=
 =?utf-8?B?aGMrYVR4eTBUN0dlSm9ad3FDMGpjOTA3Z0h6dHhnUHBaRFFob0lrUzR0MU0v?=
 =?utf-8?B?QmJURFNQQ1I2RUNIZTRLcllwWXIySHZ5WnNyeWRvajNCd1krZjZyU3VqVFBQ?=
 =?utf-8?B?WmIvU2dEaStGTHgwTERaTE1mMFVxUU4zQ1o1SElUcFoyZVo4NERPMlBTM21i?=
 =?utf-8?B?WnhrMStyTVFxZ2NyWURBVGdlYXdZNmJ2R3JXZDdXakg0cWtPSWxUSXpMUkVn?=
 =?utf-8?B?VVpFOVNTOEZvelRMaEpWWVJmWVNHcEhQVzBITHIwN21QbjZtWHd2SXEydzB4?=
 =?utf-8?B?L0xUaTB1RzVKMTd5MEtuUEhGNVNYNis3dHpjRVVGQmUxVHV1V0tMeHNSekVy?=
 =?utf-8?B?WWIxTWNaYW1aV3ZMZENReXhnVE1CdjZNK01QN0lQaTU3UUVHMTV3eVN6UG9H?=
 =?utf-8?B?ZDgxemdtNmI2bTUwZkZ4MDdub2ZXamV5NHpnUkg1bTRLeDNnNWo1SDRXYnhy?=
 =?utf-8?B?WjNhazdVT1Y2Q0lLL1VOLzdiSE05RUVHSGdwaUFKT0pHYVE9PQ==?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2024 15:42:26.8804 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 24fafc42-8eec-46a6-61b3-08dd019e4753
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD75.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9439
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

amdgpu_vm_bo_invalidate doesn't use the adev parameter and not all
callers have a reference to adev handy, so remove it for cleanliness.

Signed-off-by: Yunxiang Li <Yunxiang.Li@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c      | 4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c     | 3 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c  | 3 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c      | 4 +---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h      | 3 +--
 6 files changed, 7 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index d891ab779ca7f..471f3dc81e8db 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -1105,7 +1105,7 @@ static int amdgpu_cs_vm_handling(struct amdgpu_cs_parser *p)
 	 * We can't use gang submit on with reserved VMIDs when the VM changes
 	 * can't be invalidated by more than one engine at the same time.
 	 */
-	if (p->gang_size > 1 && !p->adev->vm_manager.concurrent_flush) {
+	if (p->gang_size > 1 && !adev->vm_manager.concurrent_flush) {
 		for (i = 0; i < p->gang_size; ++i) {
 			struct drm_sched_entity *entity = p->entities[i];
 			struct drm_gpu_scheduler *sched = entity->rq->sched;
@@ -1189,7 +1189,7 @@ static int amdgpu_cs_vm_handling(struct amdgpu_cs_parser *p)
 			if (!bo)
 				continue;
 
-			amdgpu_vm_bo_invalidate(adev, bo, false);
+			amdgpu_vm_bo_invalidate(bo, false);
 		}
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
index 8e81a83d37d84..b144404902255 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
@@ -345,7 +345,7 @@ amdgpu_dma_buf_move_notify(struct dma_buf_attachment *attach)
 	/* FIXME: This should be after the "if", but needs a fix to make sure
 	 * DMABuf imports are initialized in the right VM list.
 	 */
-	amdgpu_vm_bo_invalidate(adev, bo, false);
+	amdgpu_vm_bo_invalidate(bo, false);
 	if (!bo->tbo.resource || bo->tbo.resource->mem_type == TTM_PL_SYSTEM)
 		return;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index 13e049cbc9300..9bac5dd4cd1c2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -980,7 +980,6 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
 int amdgpu_gem_op_ioctl(struct drm_device *dev, void *data,
 			struct drm_file *filp)
 {
-	struct amdgpu_device *adev = drm_to_adev(dev);
 	struct drm_amdgpu_gem_op *args = data;
 	struct drm_gem_object *gobj;
 	struct amdgpu_vm_bo_base *base;
@@ -1040,7 +1039,7 @@ int amdgpu_gem_op_ioctl(struct drm_device *dev, void *data,
 			robj->allowed_domains |= AMDGPU_GEM_DOMAIN_GTT;
 
 		if (robj->flags & AMDGPU_GEM_CREATE_VM_ALWAYS_VALID)
-			amdgpu_vm_bo_invalidate(adev, robj, true);
+			amdgpu_vm_bo_invalidate(robj, true);
 
 		amdgpu_bo_unreserve(robj);
 		break;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index b5f65ef1efcde..f0486519bee84 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -1149,7 +1149,6 @@ void amdgpu_bo_move_notify(struct ttm_buffer_object *bo,
 			   bool evict,
 			   struct ttm_resource *new_mem)
 {
-	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->bdev);
 	struct ttm_resource *old_mem = bo->resource;
 	struct amdgpu_bo *abo;
 
@@ -1157,7 +1156,7 @@ void amdgpu_bo_move_notify(struct ttm_buffer_object *bo,
 		return;
 
 	abo = ttm_to_amdgpu_bo(bo);
-	amdgpu_vm_bo_invalidate(adev, abo, evict);
+	amdgpu_vm_bo_invalidate(abo, evict);
 
 	amdgpu_bo_kunmap(abo);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 68dd4130b5ad9..d0db155a9ab7c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2143,14 +2143,12 @@ bool amdgpu_vm_evictable(struct amdgpu_bo *bo)
 /**
  * amdgpu_vm_bo_invalidate - mark the bo as invalid
  *
- * @adev: amdgpu_device pointer
  * @bo: amdgpu buffer object
  * @evicted: is the BO evicted
  *
  * Mark @bo as invalid.
  */
-void amdgpu_vm_bo_invalidate(struct amdgpu_device *adev,
-			     struct amdgpu_bo *bo, bool evicted)
+void amdgpu_vm_bo_invalidate(struct amdgpu_bo *bo, bool evicted)
 {
 	struct amdgpu_vm_bo_base *bo_base;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index 5d119ac26c4fe..6a1b344e15e1b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -524,8 +524,7 @@ int amdgpu_vm_bo_update(struct amdgpu_device *adev,
 			struct amdgpu_bo_va *bo_va,
 			bool clear);
 bool amdgpu_vm_evictable(struct amdgpu_bo *bo);
-void amdgpu_vm_bo_invalidate(struct amdgpu_device *adev,
-			     struct amdgpu_bo *bo, bool evicted);
+void amdgpu_vm_bo_invalidate(struct amdgpu_bo *bo, bool evicted);
 uint64_t amdgpu_vm_map_gart(const dma_addr_t *pages_addr, uint64_t addr);
 struct amdgpu_bo_va *amdgpu_vm_bo_find(struct amdgpu_vm *vm,
 				       struct amdgpu_bo *bo);
-- 
2.34.1

