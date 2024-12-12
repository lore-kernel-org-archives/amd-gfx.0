Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6B91E77180
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Dec 2024 15:52:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 026A110EE0D;
	Thu, 12 Dec 2024 15:52:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IsZvJXZ1";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20617.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2413::617])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 26F5E10ED56
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Dec 2024 15:52:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TjGCV3rtQ/F1Xm8XaqhEEVNygkXKKlTA6ciJZxb5HGwDRiZEMJA5wgy9uKuKfNnKCRzFDNFakoIG+2rFWFc2QRc+ifTFOwwLN6gBVed+oxocoD+VXyPrnrN2qhPqAoCCt0ruc3IRpTQIZUSNdYszznmm0GX7wSDFZISv93KxxuY1aA9hzanPOeZi9Lg1I0HFQ9YJlJchCZVnjr1nPdRXS+RxsJ6VHlHo9Mr0obeBQys9kzMO997EZPyMD23fjP5C/vt9mdvAeTtKBGQnXgJ404Ho09HqyDMffOOmz0iN3Jw2L0tZKg5IJegsmzZQlMa9tp+lFv/EVcxZVFJSnhflaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E5HwrtU7bfeBEZf8E17ChqL8nJC+146aA/P9ac6I54o=;
 b=Oaq17vTU/lnjx/Neb9BJTfPf1BGI2RA7nw7S7wNPT0bGplfeNfSp8YbCsnabuxppnHNItfs7e/rg377KkSIhfytfR2bnpHOXoHUI0jauChHNH66W2zmby8T5CswdU4HbB6vHnRDnGXgT1cvQHTSurB6B8iKH+lINlws3VZF9esX7VWmtOEqvU6rmqlxApQZ5dQMgYTLhoIgW08CfO27+/A1VnMHXoxpvuQZSgQgVFWYUM3DAOB7c2VLKZpmZrXUjz4NuHqTbaeBHdZkpNrACjHDcKS7zCgsh4ZNMg+mWO0eF+DqfaMHkX1oIXTgaXROIkA6pLGbWEuaqGmcD2Pf1jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E5HwrtU7bfeBEZf8E17ChqL8nJC+146aA/P9ac6I54o=;
 b=IsZvJXZ1EwWmvcxF7Ie8dzF/puVSQ6vDwXrgpGixoUzbttWM9rUglflFe0bRsAjQtkEnCtIrtJ1qpr9zdJfoNAxSCff0MzWNVWgFZ36f58Fcue0DlUXP6oRbcdZwFbbsUnivBHLy+pgjqXdti3hIp0yhu+L4DL/7CKkelMnEZDg=
Received: from CH2PR10CA0009.namprd10.prod.outlook.com (2603:10b6:610:4c::19)
 by LV2PR12MB5992.namprd12.prod.outlook.com (2603:10b6:408:14e::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.15; Thu, 12 Dec
 2024 15:52:25 +0000
Received: from CH3PEPF00000012.namprd21.prod.outlook.com
 (2603:10b6:610:4c:cafe::ef) by CH2PR10CA0009.outlook.office365.com
 (2603:10b6:610:4c::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.16 via Frontend Transport; Thu,
 12 Dec 2024 15:52:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF00000012.mail.protection.outlook.com (10.167.244.117) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8272.0 via Frontend Transport; Thu, 12 Dec 2024 15:52:24 +0000
Received: from MKM-L10-YUNXIA9.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 12 Dec
 2024 09:52:23 -0600
From: Yunxiang Li <Yunxiang.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <tvrtko.ursulin@igalia.com>
CC: <Alexander.Deucher@amd.com>, Yunxiang Li <Yunxiang.Li@amd.com>
Subject: [PATCH v11 4/5] drm/amdgpu: remove unused function parameter
Date: Thu, 12 Dec 2024 10:52:05 -0500
Message-ID: <20241212155206.5030-5-Yunxiang.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241212155206.5030-1-Yunxiang.Li@amd.com>
References: <20241212155206.5030-1-Yunxiang.Li@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000012:EE_|LV2PR12MB5992:EE_
X-MS-Office365-Filtering-Correlation-Id: a687cecf-7fdb-403d-293b-08dd1ac4f8e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MHorYU45YVo5ZjhuNU0xZzVqNmRBTjh2REJ2eFdTUFEvNDF6cUJqQzhSN0pN?=
 =?utf-8?B?czR3TFhRMGtkaGZJQ2VBMlU5YVQ4TUJCaGRvTzA4L2NSVHpZUUhCeU9aQ0hT?=
 =?utf-8?B?WUJNRkQzS3VlQVNzcHRONm9DSTlxUmpEODVyTGkxRHJ1Uks5RWovNnl4K2tQ?=
 =?utf-8?B?UTcwSFQzWlExZEhqQ1ozb1FLZzREWjZBajhPRXUzaENsMEJuYmphM1hzU3Jm?=
 =?utf-8?B?UllkSHYvdnhHR2F2VU9jL1VOR0Fkc2VDY3Q1RkE5OU1hYUFLQlVFVSt6aG5y?=
 =?utf-8?B?N2FBdk9EQ21DSkxJUTVKakJPdks1TXhtdEdhbVBwREkwcVhOeUJJMEExbWdr?=
 =?utf-8?B?RHlNVGgxZVl2d0FybWxQQWRIWmR4c0Y4NmQ5L3g5STVybTVlT0RHd1hCUGpM?=
 =?utf-8?B?UE41ekF5U3N0a2lTK01WWDV3U25DcUkzUEZFbzRvaldPM1RCVTQ3MWdJRW1p?=
 =?utf-8?B?V0tnY0RCVFAxRFJSa1p2VDZOUVBpWmoxT2VpT1NaQ2FqOEZYd3g0UWQramV6?=
 =?utf-8?B?UDJEZ3NOeFMyZngvSEZxcStRcEhRL2xwalNhZmNuVHczaEFGZ3JJMWZFZ1BD?=
 =?utf-8?B?YkRZeU5FTXpTblFjWFA2a3VhZ01nMzBjU2lSRmFrSjBPQWZ6WVhPQ2ROODkz?=
 =?utf-8?B?RW9rN1gvU3J4WkRVaVJFS0JCSVZBUTRieTFRTXpFakVGN2EyTFJDbVRXTjM3?=
 =?utf-8?B?Q3gzMnptSVV4QmN1ZGFaZzN6czdid1Bmejd6bGZOZmF2bGdrQklmaEsrc21q?=
 =?utf-8?B?MkxtUjhUUTRsNFRJTENaNk10UjI5cmJjYTRsM0QxL3gybHVjWHFhZkl0c1lH?=
 =?utf-8?B?WkoyTkNEeXhpVUUvNDdCR090MUJOd2dITkN1L2JabnFBTUVyZ3llWXYxdmdX?=
 =?utf-8?B?bTlNTWdFaUlBa3JjZjlXTjZIWlltcHpHN2Q5YlhTdUFkNURDV25JR0F4OGVj?=
 =?utf-8?B?bDBNTUlCa0RSdTZnY0RMZlVZVHQzbnNMM2hVN0c3ejRSS1RUT2d6OHpZYmNm?=
 =?utf-8?B?OG5KcE1NZ2gxVG9kMDVFYzBPR2p5TG9sUmxyWEpxaEx5bkJyMDArYlhnaEJw?=
 =?utf-8?B?NTRRWUFGbXFwKzBraUZjeGQwL28zU2I4ak5ra3I5bzhudkRrUjlWNEdQV213?=
 =?utf-8?B?WHR0bmIrNFFZVnE0UHE0Lzd5OWdkODUzRlVETmZ2VVRjaGtGMkZNQXNFbnBQ?=
 =?utf-8?B?M3R2YVhmOEovalVzWVBHcXVYakozSFdxQlBzWWlxa3BtR3VIM3ZjRHVaVkhw?=
 =?utf-8?B?YklLOEx2NEpTWUxmRllZZk5pRkNWMlpuY0FrbVZrdFA1eW1TRkZTemlMUERW?=
 =?utf-8?B?RXVTRGVaY3YvQXI1ZmhZNG1FYTJSRCtJV0piZ0gzRk54ekNBbStDZHoxclZz?=
 =?utf-8?B?SU1DYjV3RDcvd01NdEZEWlNGdXJieFFYUXM1ZnY3ZjNhNVBGNWljOFpDalFm?=
 =?utf-8?B?c1VVbEsySDZCMlR4dVVyU3g3VGw1cVZDTFEvRHFZR2VnaU93SGc3STNGenhL?=
 =?utf-8?B?UTJER2ZGd2twSWJZcnBXZFZxS2w3ZmloWnV1UlBJcDJpZmlvRUZ0U1dVcXdx?=
 =?utf-8?B?TVpDZURseHowUWp4QzAxek0xdUtYZms1N3g3YVJBQW9MU00rbGlkUXBwWFd2?=
 =?utf-8?B?dVZnWC9rUWJ5a2ZHc2ovM242OUo0TDZHUHN3WGJWanI1dnhrQlVrejFMdEVS?=
 =?utf-8?B?Mlp1aFBDeTdnUnBFQ1VVWVFCYlRBMVZ6M2NzdlBtYlpCOFB1RFh5NEZSZG4z?=
 =?utf-8?B?MmlTc0pIblVHbVdOQUpGZko1L3ZhTUFkdng5Q3BsUUUvTnZGb2xObHIrRUR5?=
 =?utf-8?B?TzU0NnQ1eERRR1Fwdmh4WTAyWVpNdjNGa3cySnBLMGk1S1JHelVlWUZPL1ZJ?=
 =?utf-8?B?WVFlaFdmNzZoY01WNFFhNHVaNFkrRGZpL2Q5VzNQcXdneWh5Tml4S1l5LzNu?=
 =?utf-8?Q?BaAnXiledMc5Thq4M+ItQCBB7eoyIPdw?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2024 15:52:24.7639 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a687cecf-7fdb-403d-293b-08dd1ac4f8e9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000012.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5992
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
index 5df21529b3b13..5cc5f59e30184 100644
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
index 63e2cb1ab56ea..fe7ae45500639 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -977,7 +977,6 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
 int amdgpu_gem_op_ioctl(struct drm_device *dev, void *data,
 			struct drm_file *filp)
 {
-	struct amdgpu_device *adev = drm_to_adev(dev);
 	struct drm_amdgpu_gem_op *args = data;
 	struct drm_gem_object *gobj;
 	struct amdgpu_vm_bo_base *base;
@@ -1037,7 +1036,7 @@ int amdgpu_gem_op_ioctl(struct drm_device *dev, void *data,
 			robj->allowed_domains |= AMDGPU_GEM_DOMAIN_GTT;
 
 		if (robj->flags & AMDGPU_GEM_CREATE_VM_ALWAYS_VALID)
-			amdgpu_vm_bo_invalidate(adev, robj, true);
+			amdgpu_vm_bo_invalidate(robj, true);
 
 		amdgpu_bo_unreserve(robj);
 		break;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index 4f057996ef35b..951b20e40fd35 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -1251,7 +1251,6 @@ void amdgpu_bo_move_notify(struct ttm_buffer_object *bo,
 			   bool evict,
 			   struct ttm_resource *new_mem)
 {
-	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->bdev);
 	struct ttm_resource *old_mem = bo->resource;
 	struct amdgpu_bo *abo;
 
@@ -1259,7 +1258,7 @@ void amdgpu_bo_move_notify(struct ttm_buffer_object *bo,
 		return;
 
 	abo = ttm_to_amdgpu_bo(bo);
-	amdgpu_vm_bo_invalidate(adev, abo, evict);
+	amdgpu_vm_bo_invalidate(abo, evict);
 
 	amdgpu_bo_kunmap(abo);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 57636dfd77a8a..88173bd1f9a2c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2144,14 +2144,12 @@ bool amdgpu_vm_evictable(struct amdgpu_bo *bo)
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
2.47.0

