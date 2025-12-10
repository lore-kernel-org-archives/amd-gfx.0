Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 800B8D3B9A9
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Dec 2025 09:28:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2398110E697;
	Wed, 10 Dec 2025 09:28:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ko6lfUit";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011056.outbound.protection.outlook.com [40.107.208.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 21B1310E697
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Dec 2025 09:28:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vZ4I5V2gj1UtjcT0VZCif6e+u2xcpOSZBb0/YWxjigtHv3gUOQ8Uqk6+YpUXI/ZTm0CEYvuI7b7aI9erjezHVVfMRhxB3nsx1lEI1bnmkLjq41OmqajCEd2LQ6nfEk/66j+QRy53tK6On8YFRT6JPXHeTZHytYX7S44hS7LxWKf8j0T+C/A0YA0LM5b1fq3IJ5RS4cY1DGCOFfJgcZ5tFC4k+1IE4NE35t102qt285LETYJe3uTIw2MaUV2uKVxW2etLP0d3DpkZu+QbZklI6aavh+M4/44ahAy7Rx2sui4Lrb9PbwwpeB+bM/01yD0uG/1v2FJZhvbqFHASsUl7OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8tr+5W0pnxz+wsdxkStqvF1Gzw1tII8psFwv6dDBQ7s=;
 b=lNSWGTVrOu65rYlVoXmLOLqsPTGPCIDXTWglCPXNIwmJcR4i9CrmzrC8Hrf7jZSkU232F7ZWGNAVryFv6wunZvEh39sUhZciMzVM9mMQ2SsMP7uBX5BsVY4XeFS9P8tYA0uOsQq66M+igYRVm4Vtp5kCIUHR6Zf0PRhn9QejkxngwpVJi9OjY+sHjmJcbDx6En98QHBVPBECrQzn+prduLskE3x4/7GqR+dlb7CJA5YBO2vVpXBftDwOnOpbP52tTMH7apfaOGFtw4U7oo5oIU8iFh+I/WGKLKAmTS7kynuXGeyIl8qcXrD1PHefFn6hTmMwBz5aPXvhsf05Dxndzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8tr+5W0pnxz+wsdxkStqvF1Gzw1tII8psFwv6dDBQ7s=;
 b=ko6lfUitvwdsBnMK2eqzrdzVllxU/x+kbYP+ymhWysOT9ThOtTqfd++E8wvp+5H0CZYBVRWD+DCDG0AAKCX/IWfr7q0HzagFfw1E4l7hs73934MyW8F2j6RpvGMHiNN+HvgDHTh7TnQyiRef/+hYFymYs37VA9gskuDErzlyZLY=
Received: from BN1PR12CA0028.namprd12.prod.outlook.com (2603:10b6:408:e1::33)
 by DM6PR12MB4449.namprd12.prod.outlook.com (2603:10b6:5:2a5::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.9; Wed, 10 Dec
 2025 09:28:02 +0000
Received: from BN2PEPF000044A9.namprd04.prod.outlook.com
 (2603:10b6:408:e1:cafe::1f) by BN1PR12CA0028.outlook.office365.com
 (2603:10b6:408:e1::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.6 via Frontend Transport; Wed,
 10 Dec 2025 09:27:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000044A9.mail.protection.outlook.com (10.167.243.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Wed, 10 Dec 2025 09:28:01 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 10 Dec
 2025 03:27:59 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 10 Dec
 2025 01:27:59 -0800
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Wed, 10 Dec 2025 01:27:58 -0800
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse.Zhang <Jesse.Zhang@amd.com>, Prike Liang <Prike.Liang@amd.com>
Subject: [PATCH] drm/amdgpu: Add sync function for specific reservation usage
 and update VM sync
Date: Wed, 10 Dec 2025 17:20:59 +0800
Message-ID: <20251210092752.1416361-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A9:EE_|DM6PR12MB4449:EE_
X-MS-Office365-Filtering-Correlation-Id: 2cbe5de7-2b09-4b3a-de19-08de37ce69f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?PdnhJ281Kv7KId6S20vB7tCb+HNtsaOfka3LA8HnIcac3g9r1diVgAtmZA1W?=
 =?us-ascii?Q?mFTW98QRH/wzWyqHzrRRFSFIv7JLD8RwO95GKATISY4zLX8s6uqESlXB+bVw?=
 =?us-ascii?Q?SdXTCvIXPGFgHslUVvmQs3RO3MLxhPOcdEyLRPDXs/VqUx07myMfQZwmbu/j?=
 =?us-ascii?Q?g54wyQxF0QXqtd4DXDzhP8IC/AgQRH5Q+45SFG694tZ7semS0lEerxvjWdpf?=
 =?us-ascii?Q?x+/xqakjK40QX4WQT/tQDxLOA2PI7tg+vhcW7dVZPKYqU1ByQcbsTgVBQER6?=
 =?us-ascii?Q?3sENknpvhYD9iUL/r+6xzwToJwdDHixyLG7gwWeVYhw6AZj0Z9KCoYAZyG9c?=
 =?us-ascii?Q?HDpVmsW396MAN4EFt/tXvXwkd8663UWoso8fBxMRURw624bdnnP4mNaWHp6v?=
 =?us-ascii?Q?HO2HJnwHdwmmVHylzrwqtVtekA7/yJFqRDfD4qnhlwCkozUiG6zpQpte+ICo?=
 =?us-ascii?Q?ex6IDgcpvCv1bINsNI7/rJcLiLF8Y9ycx3HVjCUVJ2MQSYiDAI7id22eILHr?=
 =?us-ascii?Q?sNjnouIkFUSuhHAiKvwHBvKCJyNHl3TfZr+XqJ4o8u9prz/EA3rmoon8/i5F?=
 =?us-ascii?Q?Dc5HkZKi8c/ZPdAaxEIeluTmSjUEFBieCRRU6xbIhGGQjki0lam8YU9c8+Yh?=
 =?us-ascii?Q?z+7d9vufZhwbBV9n2Ltd5T1j1AtLEOQQ0R+iLFpn0gJsI9YcRQS1ZJ9zO243?=
 =?us-ascii?Q?QTfPSPXhty2nNwYoQ3RCCbufwPSfPJHzoEgoR39svWNQjHcK4Hcd9NlldZF+?=
 =?us-ascii?Q?dlZe2a78q/SXDzI9evaqsN1QOeShUVoB2zOswI7eqPhoX1MbyrqLYRlTUIH5?=
 =?us-ascii?Q?khf5NFkQ2/cJDCAAqoNzBQKlV3/83cJ+GwAWDOS/DdlRpTZ44z37qPWgMe9v?=
 =?us-ascii?Q?OBv9nFDa40lBqx/eLiEkk8Lebx+4W8quWHYF73dbQS0oeu+OhoAc3zJMHhLc?=
 =?us-ascii?Q?2omjgFgJA6iqpFQuwNm1TodSrkwuVqdmy+M5TwPBdx/MIV12YJ6EfRvAWWlE?=
 =?us-ascii?Q?aJ3FJOGSWIN0ia5dJyTl05LCBeyBZUmqjEQZV3batnYD9Sx48pKzGJvDALQZ?=
 =?us-ascii?Q?bFu5Y0teeTHa4uslDdtrpvTfPGc3nbbHL4qqHQDD8cfGoUFZeo7ZfphvkDUg?=
 =?us-ascii?Q?x7DiKOfUdBx12cxD1+nSJnxl9QJnDdPsz7iCmQ737GFWoj57IKJRsEafFqTd?=
 =?us-ascii?Q?r4z06e1/jByLqJkH358r1P3ue1SrO3up4K/gZZQDp9LOE1KUWG0k5WbI8leZ?=
 =?us-ascii?Q?K1IMFXVlcDzGvcaIkEEzdWztHssu+cWug8X/+iWhvEWXb6v6SAAAHdZxIJ5i?=
 =?us-ascii?Q?Z2BXMcgBEis2JfJJvSXiFcWg1lX+Xa7NwmLEjl8yIWdxfpcS+igpIYeiYvcJ?=
 =?us-ascii?Q?wFUGbme1rXgwcqFh/pMYkloT8X7rE7r1TC2mUxhnmuWTsSbHqlISixYSu0ux?=
 =?us-ascii?Q?yhewaKxzZMb0TDue02QbzGHQE6bn8Fk/urFPGo+dT18My2eB0HTWKVeT/kwx?=
 =?us-ascii?Q?8nUYowtVbXKbX+/KuEjM66a58NUcdiaIfOxPQnE0h0JfA6ECOwsuapURglE1?=
 =?us-ascii?Q?MBZOADsa4FMMXXAg+fE=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2025 09:28:01.3006 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cbe5de7-2b09-4b3a-de19-08de37ce69f1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A9.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4449
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

This patch introduces a new function `amdgpu_sync_resv_usage` that allows
syncing fences of a specific usage from a reservation object, replacing
the hardcoded DMA_RESV_USAGE_READ in the original `amdgpu_sync_resv`.

The original `amdgpu_sync_resv` is modified to call the new function with
DMA_RESV_USAGE_READ to maintain backward compatibility.

In `amdgpu_vm_bo_update`, we update the sync call to use
`amdgpu_sync_resv_usage` with DMA_RESV_USAGE_BOOKKEEP.
This ensures we properly sync with bookkeeping fences (e.g., related to
memory eviction, migration) when updating VM mappings.

Suggested-by: Prike Liang <Prike.Liang@amd.com>
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c | 49 ++++++++++++++++--------
 drivers/gpu/drm/amd/amdgpu/amdgpu_sync.h |  3 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c   | 10 ++++-
 3 files changed, 44 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
index d6ae9974c952..9665eed65b5d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
@@ -229,31 +229,30 @@ static bool amdgpu_sync_test_fence(struct amdgpu_device *adev,
 }
 
 /**
- * amdgpu_sync_resv - sync to a reservation object
- *
- * @adev: amdgpu device
- * @sync: sync object to add fences from reservation object to
- * @resv: reservation object with embedded fence
- * @mode: how owner affects which fences we sync to
- * @owner: owner of the planned job submission
- *
- * Sync to the fence
+ * amdgpu_sync_resv_usage - Sync fences of a specific usage from a reservation object
+ * @adev: AMDGPU device
+ * @sync: Sync object
+ * @resv: Reservation object
+ * @mode: Sync mode (affects which fences are selected)
+ * @owner: Owner identifier
+ * @usage: Target fence usage (e.g., DMA_RESV_USAGE_BOOKKEEP)
+ *
+ * Collects fences of the specified usage from the reservation and adds them to the sync object
  */
-int amdgpu_sync_resv(struct amdgpu_device *adev, struct amdgpu_sync *sync,
-		     struct dma_resv *resv, enum amdgpu_sync_mode mode,
-		     void *owner)
+int amdgpu_sync_resv_usage(struct amdgpu_device *adev, struct amdgpu_sync *sync,
+			   struct dma_resv *resv, enum amdgpu_sync_mode mode,
+			   void *owner, uint64_t usage)
 {
 	struct dma_resv_iter cursor;
 	struct dma_fence *f;
 	int r;
 
-	if (resv == NULL)
+	if (!resv)
 		return -EINVAL;
-	/* Implicitly sync only to KERNEL, WRITE and READ */
-	dma_resv_for_each_fence(&cursor, resv, DMA_RESV_USAGE_READ, f) {
+
+	dma_resv_for_each_fence(&cursor, resv, usage, f) {
 		dma_fence_chain_for_each(f, f) {
 			struct dma_fence *tmp = dma_fence_chain_contained(f);
-
 			if (amdgpu_sync_test_fence(adev, mode, owner, tmp)) {
 				r = amdgpu_sync_fence(sync, f, GFP_KERNEL);
 				dma_fence_put(f);
@@ -266,6 +265,24 @@ int amdgpu_sync_resv(struct amdgpu_device *adev, struct amdgpu_sync *sync,
 	return 0;
 }
 
+/**
+ * amdgpu_sync_resv - sync to a reservation object
+ *
+ * @adev: amdgpu device
+ * @sync: sync object to add fences from reservation object to
+ * @resv: reservation object with embedded fence
+ * @mode: how owner affects which fences we sync to
+ * @owner: owner of the planned job submission
+ *
+ * Sync to the fence
+ */
+int amdgpu_sync_resv(struct amdgpu_device *adev, struct amdgpu_sync *sync,
+		     struct dma_resv *resv, enum amdgpu_sync_mode mode,
+		     void *owner)
+{
+	 return amdgpu_sync_resv_usage(adev, sync, resv, mode, owner, DMA_RESV_USAGE_READ);
+}
+
 /**
  * amdgpu_sync_kfd - sync to KFD fences
  *
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.h
index 51eb4382c91e..1f875b1e9d2c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.h
@@ -52,6 +52,9 @@ int amdgpu_sync_fence(struct amdgpu_sync *sync, struct dma_fence *f,
 int amdgpu_sync_resv(struct amdgpu_device *adev, struct amdgpu_sync *sync,
 		     struct dma_resv *resv, enum amdgpu_sync_mode mode,
 		     void *owner);
+int amdgpu_sync_resv_usage(struct amdgpu_device *adev, struct amdgpu_sync *sync,
+                          struct dma_resv *resv, enum amdgpu_sync_mode mode,
+                          void *owner, uint64_t usage);
 int amdgpu_sync_kfd(struct amdgpu_sync *sync, struct dma_resv *resv);
 struct dma_fence *amdgpu_sync_peek_fence(struct amdgpu_sync *sync,
 				     struct amdgpu_ring *ring);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 0eccb31793ca..f470b7e5489a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -1313,8 +1313,14 @@ int amdgpu_vm_bo_update(struct amdgpu_device *adev, struct amdgpu_bo_va *bo_va,
 			pages_addr = bo->tbo.ttm->dma_address;
 
 		/* Implicitly sync to moving fences before mapping anything */
-		r = amdgpu_sync_resv(adev, &sync, bo->tbo.base.resv,
-				     AMDGPU_SYNC_EXPLICIT, vm);
+		if (vm->update_funcs == &amdgpu_vm_sdma_funcs)
+			r = amdgpu_sync_resv_usage(adev, &sync, bo->tbo.base.resv,
+					AMDGPU_SYNC_EXPLICIT, vm,
+					DMA_RESV_USAGE_BOOKKEEP);
+		else
+			r = amdgpu_sync_resv_usage(adev, &sync, bo->tbo.base.resv,
+					AMDGPU_SYNC_EXPLICIT, vm,
+					DMA_RESV_USAGE_READ);
 		if (r)
 			goto error_free;
 	}
-- 
2.49.0

