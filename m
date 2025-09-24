Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9E8ACAC5A5
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Sep 2025 07:37:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 69E2D10E222;
	Wed, 24 Sep 2025 07:37:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="E0rKY3QQ";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011014.outbound.protection.outlook.com [52.101.57.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 98F9C10E222
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Sep 2025 07:37:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VRIlI/SLAmwHvne70CrQJG3t35Lc2aliGWpZd/+1do8bJJYYzgmjwpcGaawzwbZNYdYsxjIVmeFf66Bfboh2JQKeo8aiVi2g/DmhQfn3RPWSamoPInCXsTR4WZK3ptRY1LYXJ19NWQ0jsB1aW7W3xf5bM6v1G5SLJRVH6dqyljyBEqQBS6p8qmxa+aVQPtz0H943scTgF0dXmzS0QAgemeXeYLXJSExJ9KcJNiaGRHLw26Ow6b/FkwXRzK9UrYkSp7obW8+PgYOiq5iV9N0P2BdzIaUxyIJ0mARR4BmfWfGFe1uZWFa8KPyESdkQlkFOg+4qqodNNd9V4ivdCsaMpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tbtLOiHqGbacykvoGeiCqQltiU+3CuBAq0pGAalcmdA=;
 b=HjRypaYJFzU55OJYXrNVboFdL+W9lnAjhq2iGzCRUT2pbPwroDS9JOlZxA4DJVa2eAVQ309T2Dy6e1Xh0ZgX/PZjZCk3WMJ5YILJWpZ92jZio1J7OhosOoMHFs3UI94vT8ngJoEOYrCQ4rqjCiyXT/l1lwS/hPHWtqP06ZhyxUJc/oTQ/OG9A5es6zZccqPfmLESF6GEikMVJdiyJrs5AQe1g1BL1S3nljcH50XXly1uEucAEsXZy+LGHOYdxVRBQez/3c4NyzvDxv//MVrK2V5x/g6TksMAndG0aHU4DvwQGhFvWp8aagrh+sjBCsBgYsEnGe25JQQp1+MQTbqZRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tbtLOiHqGbacykvoGeiCqQltiU+3CuBAq0pGAalcmdA=;
 b=E0rKY3QQAtz6xd0fs4Hca6JfvdOmytHcEy1T3ykUEnZbr4XAExS86+XH2JhRAscIvBjC4y36ESisC3pUrhn4bQJ3EG6xcOyTHKqc9bQ9CUKQA9ln2djYFIN5rVYvxt9rfxF64SY8APf37+N/BGcsNRi28H7Y0uiYThAGH1Ojyr8=
Received: from SA0PR11CA0005.namprd11.prod.outlook.com (2603:10b6:806:d3::10)
 by MN2PR12MB4127.namprd12.prod.outlook.com (2603:10b6:208:1d1::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.20; Wed, 24 Sep
 2025 07:37:23 +0000
Received: from SA2PEPF00003AE5.namprd02.prod.outlook.com
 (2603:10b6:806:d3:cafe::11) by SA0PR11CA0005.outlook.office365.com
 (2603:10b6:806:d3::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.20 via Frontend Transport; Wed,
 24 Sep 2025 07:37:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SA2PEPF00003AE5.mail.protection.outlook.com (10.167.248.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Wed, 24 Sep 2025 07:37:23 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 24 Sep
 2025 00:37:22 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 24 Sep
 2025 00:37:22 -0700
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Wed, 24 Sep 2025 00:37:21 -0700
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse.Zhang <Jesse.Zhang@amd.com>
Subject: [v6 1/2] drm/amdgpu: Convert amdgpu userqueue management from IDR to
 XArray
Date: Wed, 24 Sep 2025 15:34:46 +0800
Message-ID: <20250924073715.2335544-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE5:EE_|MN2PR12MB4127:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d475b1e-b3f9-458e-58b3-08ddfb3d3388
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RUVQU0tOSG5zMk13Qm5xRTlDamJId2ptMnV6R28xUVFOL0s1RUYwTzRGa25Y?=
 =?utf-8?B?MGVwb2Z6eXJkczI0OHJRbC9NQzl0SzY5Y0pKT3FqL2I1VFZiL0x1MEtwRDhm?=
 =?utf-8?B?aXY5RkdoSVBSZkRvY01kTEtNV0VzVjR0bE95Y2tBR1ZZcUgyS21XTWQxT2dW?=
 =?utf-8?B?ekpLRWdKcVlycWR5RnowS3hiSW1PaGRuUXVHVHlKQ0VDQzJ1bEd4TjNYL21Z?=
 =?utf-8?B?RkdKRnd1LzhnNGFxLzVBenE0UjdkeDBmd0RaZHNsT0p4d3U5QVdvK09MN1Qw?=
 =?utf-8?B?M2doV3lzNXFSbklpck5nTWs1QmpOamJmVlRyV3pFUGhlRVpPdzR6VFVqWkZI?=
 =?utf-8?B?Wkt4UGgvemVBVUVuR2xOWHZEeEVCbHN5dzNuK1Rkd0RleDFsQnlNSWxDdzN1?=
 =?utf-8?B?MjNVUzJyWGFjSDM0UFV3SlJFdnE5R2RmNkV5cm9lYjRhdGIwMXRlNVpkR1Nk?=
 =?utf-8?B?SEF0ckNuYUFDU1FyZTd1dmFrLzhUb2FBMG5SNkFheVFnKzBJV3owNzJQd3R6?=
 =?utf-8?B?NVI0N0tuaWxOMmdlU1NiSFd6SkJZc2xZbVl1c01zS3Nnak0rbDJMQlZ1cE1v?=
 =?utf-8?B?QlZZOHZZRGptaG5JMGlNN3NOV09BME1KSllyMUR6SlEwM0pRY3VuQ2k5czVV?=
 =?utf-8?B?WHFDRWpvWDVHNWovSWJIN05sZTRDQThHdGprVmRLeGNrOUlsUzNSaGVaWVJp?=
 =?utf-8?B?Z2ZnQkZYNWNjUlIxU2FMRWxCQlBNQTlBUWM1VWV4N1hrc084Tk95aU1xbHNG?=
 =?utf-8?B?U3NBQnRnK2gvV3lwQVpERFA1Y0ZSdWVhRkErc2x4bkkzOTl0bmVPWnMySVoz?=
 =?utf-8?B?QWZoTHRiR01SdFZIVURHZlVvRW45MmVZYnBDbkhTYVd2M2ZSRDdoa2UvWlha?=
 =?utf-8?B?Tlh1NWhKUEE2Z2FzUDdMTlJFQ2lqb0ZXQ0tUZzdWQUZNbythSE54c1lxNUMx?=
 =?utf-8?B?dGszaDVvcThqK1pTOXcweWgrWWhpaUpTOE5qVWlGRjJDVDNuemh4VS8vYm1n?=
 =?utf-8?B?QVN0OE1QUHMvRkpIaXBpV0d6WHVFUzF0VUIzYUxGQXVESVV4TkQ3Tk5qbGRj?=
 =?utf-8?B?d1BqbW9BVHZweWJyTWlmdnNnaE10Zm9EQTJVb0xFVUFCVGZROFBOSG0vcWhZ?=
 =?utf-8?B?QUR4Z1FSS2c4MFlMU2tJWkNMcGZqQzRDKzFHY3dZdFRUZ0o3RzZaT0syYmp6?=
 =?utf-8?B?bWJhOWt1MWlKSGRTdklGNmFSeTNocFk1OVpteGcvQ3d0MG92M29NTFJiL2p4?=
 =?utf-8?B?RDd6UHA0YWk1b0tMdWNjOFZHWW1lYXVHMEQzTldvTUdwVU1YM3pFOC9CSlpZ?=
 =?utf-8?B?Q1ZYZjFLNk5HWWx0KzlwVmhSc3R5SEJWYXE0Z083bElOeGQxRzlFNXhoQXEr?=
 =?utf-8?B?enlpVWRsKzhwbFpNSDlkN0hDVzJsZTN2eWtLV0tldVFoeHNvKy91VlJHL2Zl?=
 =?utf-8?B?T1gzc2JzcUdSMVBRS1JtV0oyY2ZCcmRPamJQTVFqVVBuT3k5Tm9jZW5FOE1K?=
 =?utf-8?B?V0NnRnVUQXkzZWhCL3BjL0lGekt6WDViT2VLMUpFOThXV2VvdjVBUncwbDBq?=
 =?utf-8?B?bkhWN1pLOXFEeTlYSW12T09abDdnSit0MFdBWWVYOXB3b3E2VndVenFTN2x0?=
 =?utf-8?B?YjBRZm5CQmdrZ0VQOEFQKy9rK0VrQWJabmRVdnc3OW5nMXhMOHFXV2tWalhx?=
 =?utf-8?B?dEUzV1J2QmRQakJ0MmwzZ0Y5Y1NsQTAyU2RXWXlZMzhCREhUNkF6TE9wakdx?=
 =?utf-8?B?eS8xcFU2eXhTY05zVXh0OWRJUnQrM2wxeGtlM3Y0VEFHamU2NWNHQWp0SHRZ?=
 =?utf-8?B?b2tWaTNGcVVhQ3Q5NjJZdXNjZ09aWXNzOXRPYTZtYWl1c3Z4R1Rlc21pNFdU?=
 =?utf-8?B?WlZLM1VORzJmZ0JXRC93Y043ZGhwdkV0ck55RGJLYTFpY0JvdWdEV1A0SUxa?=
 =?utf-8?B?WWF6Y3c0S1hjUXNVWWphTDl1WisxQlBuQjMrVm1OQkRJY3hURDhUaXNUN3I1?=
 =?utf-8?B?UlN2dTRwNmVvSDE3SzNMRlRIb1Z2bzQ3QUZpUTZjOENtaWVrc1U3ZUtpV3dp?=
 =?utf-8?Q?WCzoJb?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 07:37:23.1846 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d475b1e-b3f9-458e-58b3-08ddfb3d3388
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003AE5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4127
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

This commit refactors the AMDGPU userqueue management subsystem to replace
IDR (ID Allocation) with XArray for improved performance, scalability, and
maintainability. The changes address several issues with the previous IDR
implementation and provide better locking semantics.

Key changes:

1. **Global XArray Introduction**:
   - Added `userq_doorbell_xa` to `struct amdgpu_device` for global queue tracking
   - Uses doorbell_index as key for efficient global lookup
   - Replaces the previous `userq_mgr_list` linked list approach

2. **Per-process XArray Conversion**:
   - Replaced `userq_idr` with `userq_mgr_xa` in `struct amdgpu_userq_mgr`
   - Maintains per-process queue tracking with queue_id as key
   - Uses XA_FLAGS_ALLOC for automatic ID allocation

3. **Locking Improvements**:
   - Removed global `userq_mutex` from `struct amdgpu_device`
   - Replaced with fine-grained XArray locking using XArray's internal spinlocks

4. **Runtime Idle Check Optimization**:
   - Updated `amdgpu_runtime_idle_check_userq()` to use xa_empty

5. **Queue Management Functions**:
   - Converted all IDR operations to equivalent XArray functions:
     - `idr_alloc()` → `xa_alloc()`
     - `idr_find()` → `xa_load()`
     - `idr_remove()` → `xa_erase()`
     - `idr_for_each()` → `xa_for_each()`

Benefits:
- **Performance**: XArray provides better scalability for large numbers of queues
- **Memory Efficiency**: Reduced memory overhead compared to IDR
- **Thread Safety**: Improved locking semantics with XArray's internal spinlocks

v2: rename userq_global_xa/userq_xa to userq_doorbell_xa/userq_mgr_xa
    Remove xa_lock and use its own lock.

v3: Set queue->userq_mgr = uq_mgr in amdgpu_userq_create()

Suggested-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |   8 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |   3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |  16 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c     | 143 +++++++++---------
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h     |   8 +-
 .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   |   4 +-
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c    |  22 ++-
 7 files changed, 97 insertions(+), 107 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 2a0df4cabb99..ae10832a09f4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1174,6 +1174,12 @@ struct amdgpu_device {
 	 * queue fence.
 	 */
 	struct xarray			userq_xa;
+	/**
+	 * @userq_doorbell_xa: Global user queue map (doorbell index → queue)
+	 * Key: doorbell_index (unique global identifier for the queue)
+	 * Value: struct amdgpu_usermode_queue
+	 */
+	struct xarray userq_doorbell_xa;
 
 	/* df */
 	struct amdgpu_df                df;
@@ -1308,8 +1314,6 @@ struct amdgpu_device {
 	 */
 	bool                            apu_prefer_gtt;
 
-	struct list_head		userq_mgr_list;
-	struct mutex                    userq_mutex;
 	bool                            userq_halt_for_enforce_isolation;
 	struct amdgpu_uid *uid_info;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 0fdfde3dcb9f..e066f7ff2a82 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4483,7 +4483,6 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	mutex_init(&adev->gfx.userq_sch_mutex);
 	mutex_init(&adev->gfx.workload_profile_mutex);
 	mutex_init(&adev->vcn.workload_profile_mutex);
-	mutex_init(&adev->userq_mutex);
 
 	amdgpu_device_init_apu_flags(adev);
 
@@ -4511,7 +4510,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 
 	INIT_LIST_HEAD(&adev->pm.od_kobj_list);
 
-	INIT_LIST_HEAD(&adev->userq_mgr_list);
+	xa_init(&adev->userq_doorbell_xa);
 
 	INIT_DELAYED_WORK(&adev->delayed_init_work,
 			  amdgpu_device_delayed_init_work_handler);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index ece251cbe8c3..fdea7cd4b3ce 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2771,22 +2771,8 @@ static int amdgpu_runtime_idle_check_userq(struct device *dev)
 	struct pci_dev *pdev = to_pci_dev(dev);
 	struct drm_device *drm_dev = pci_get_drvdata(pdev);
 	struct amdgpu_device *adev = drm_to_adev(drm_dev);
-	struct amdgpu_usermode_queue *queue;
-	struct amdgpu_userq_mgr *uqm, *tmp;
-	int queue_id;
-	int ret = 0;
-
-	mutex_lock(&adev->userq_mutex);
-	list_for_each_entry_safe(uqm, tmp, &adev->userq_mgr_list, list) {
-		idr_for_each_entry(&uqm->userq_idr, queue, queue_id) {
-			ret = -EBUSY;
-			goto done;
-		}
-	}
-done:
-	mutex_unlock(&adev->userq_mutex);
 
-	return ret;
+	return xa_empty(&adev->userq_doorbell_xa) ? 0 : -EBUSY;
 }
 
 static int amdgpu_pmops_runtime_suspend(struct device *dev)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index b649ac0cedff..0712b88782c8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -180,17 +180,28 @@ amdgpu_userq_cleanup(struct amdgpu_userq_mgr *uq_mgr,
 {
 	struct amdgpu_device *adev = uq_mgr->adev;
 	const struct amdgpu_userq_funcs *uq_funcs = adev->userq_funcs[queue->queue_type];
+	unsigned long flags;
 
 	uq_funcs->mqd_destroy(uq_mgr, queue);
 	amdgpu_userq_fence_driver_free(queue);
-	idr_remove(&uq_mgr->userq_idr, queue_id);
+
+	/* Use interrupt-safe locking since IRQ handlers may access these XArrays */
+	xa_lock_irqsave(&uq_mgr->userq_mgr_xa, flags);
+	__xa_erase(&uq_mgr->userq_mgr_xa, (unsigned long)queue_id);
+	xa_unlock_irqrestore(&uq_mgr->userq_mgr_xa, flags);
+
+	xa_lock_irqsave(&adev->userq_doorbell_xa, flags);
+	__xa_erase(&adev->userq_doorbell_xa, queue->doorbell_index);
+	xa_unlock_irqrestore(&adev->userq_doorbell_xa, flags);
+
+	queue->userq_mgr = NULL;
 	kfree(queue);
 }
 
 static struct amdgpu_usermode_queue *
 amdgpu_userq_find(struct amdgpu_userq_mgr *uq_mgr, int qid)
 {
-	return idr_find(&uq_mgr->userq_idr, qid);
+	return xa_load(&uq_mgr->userq_mgr_xa, qid);
 }
 
 void
@@ -462,8 +473,10 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 	struct amdgpu_db_info db_info;
 	char *queue_name;
 	bool skip_map_queue;
+	unsigned long flags;
+	u32 qid;
 	uint64_t index;
-	int qid, r = 0;
+	int r = 0;
 	int priority =
 		(args->in.flags & AMDGPU_USERQ_CREATE_FLAGS_QUEUE_PRIORITY_MASK) >>
 		AMDGPU_USERQ_CREATE_FLAGS_QUEUE_PRIORITY_SHIFT;
@@ -486,7 +499,6 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 	 *
 	 * This will also make sure we have a valid eviction fence ready to be used.
 	 */
-	mutex_lock(&adev->userq_mutex);
 	amdgpu_userq_ensure_ev_fence(&fpriv->userq_mgr, &fpriv->evf_mgr);
 
 	uq_funcs = adev->userq_funcs[args->in.ip_type];
@@ -546,9 +558,17 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 		goto unlock;
 	}
 
+	xa_lock_irqsave(&adev->userq_doorbell_xa, flags);
+	r =xa_err(__xa_store(&adev->userq_doorbell_xa, index, queue, GFP_KERNEL));
+	if (r) {
+		kfree(queue);
+		xa_unlock_irqrestore(&adev->userq_doorbell_xa, flags);
+		goto unlock;
+	}
+	xa_unlock_irqrestore(&adev->userq_doorbell_xa, flags);
 
-	qid = idr_alloc(&uq_mgr->userq_idr, queue, 1, AMDGPU_MAX_USERQ_COUNT, GFP_KERNEL);
-	if (qid < 0) {
+	r = xa_alloc(&uq_mgr->userq_mgr_xa, &qid, queue, XA_LIMIT(1, AMDGPU_MAX_USERQ_COUNT), GFP_KERNEL);
+	if (r) {
 		drm_file_err(uq_mgr->file, "Failed to allocate a queue id\n");
 		amdgpu_userq_fence_driver_free(queue);
 		uq_funcs->mqd_destroy(uq_mgr, queue);
@@ -556,6 +576,7 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 		r = -ENOMEM;
 		goto unlock;
 	}
+	queue->userq_mgr = uq_mgr;
 
 	/* don't map the queue if scheduling is halted */
 	if (adev->userq_halt_for_enforce_isolation &&
@@ -568,7 +589,7 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 		r = amdgpu_userq_map_helper(uq_mgr, queue);
 		if (r) {
 			drm_file_err(uq_mgr->file, "Failed to map Queue\n");
-			idr_remove(&uq_mgr->userq_idr, qid);
+			xa_erase(&uq_mgr->userq_mgr_xa, qid);
 			amdgpu_userq_fence_driver_free(queue);
 			uq_funcs->mqd_destroy(uq_mgr, queue);
 			kfree(queue);
@@ -591,7 +612,6 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 
 unlock:
 	mutex_unlock(&uq_mgr->userq_mutex);
-	mutex_unlock(&adev->userq_mutex);
 
 	return r;
 }
@@ -689,11 +709,11 @@ static int
 amdgpu_userq_restore_all(struct amdgpu_userq_mgr *uq_mgr)
 {
 	struct amdgpu_usermode_queue *queue;
-	int queue_id;
+	unsigned long queue_id;
 	int ret = 0, r;
 
 	/* Resume all the queues for this process */
-	idr_for_each_entry(&uq_mgr->userq_idr, queue, queue_id) {
+	xa_for_each(&uq_mgr->userq_mgr_xa, queue_id, queue) {
 		r = amdgpu_userq_restore_helper(uq_mgr, queue);
 		if (r)
 			ret = r;
@@ -846,11 +866,11 @@ static int
 amdgpu_userq_evict_all(struct amdgpu_userq_mgr *uq_mgr)
 {
 	struct amdgpu_usermode_queue *queue;
-	int queue_id;
+	unsigned long queue_id;
 	int ret = 0, r;
 
 	/* Try to unmap all the queues in this process ctx */
-	idr_for_each_entry(&uq_mgr->userq_idr, queue, queue_id) {
+	xa_for_each(&uq_mgr->userq_mgr_xa, queue_id, queue) {
 		r = amdgpu_userq_preempt_helper(uq_mgr, queue);
 		if (r)
 			ret = r;
@@ -865,9 +885,10 @@ static int
 amdgpu_userq_wait_for_signal(struct amdgpu_userq_mgr *uq_mgr)
 {
 	struct amdgpu_usermode_queue *queue;
-	int queue_id, ret;
+	unsigned long queue_id;
+	int ret;
 
-	idr_for_each_entry(&uq_mgr->userq_idr, queue, queue_id) {
+	xa_for_each(&uq_mgr->userq_mgr_xa, queue_id, queue) {
 		struct dma_fence *f = queue->last_fence;
 
 		if (!f || dma_fence_is_signaled(f))
@@ -920,44 +941,30 @@ int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct drm_file *f
 			  struct amdgpu_device *adev)
 {
 	mutex_init(&userq_mgr->userq_mutex);
-	idr_init_base(&userq_mgr->userq_idr, 1);
+	xa_init_flags(&userq_mgr->userq_mgr_xa, XA_FLAGS_ALLOC);
 	userq_mgr->adev = adev;
 	userq_mgr->file = file_priv;
 
-	mutex_lock(&adev->userq_mutex);
-	list_add(&userq_mgr->list, &adev->userq_mgr_list);
-	mutex_unlock(&adev->userq_mutex);
-
 	INIT_DELAYED_WORK(&userq_mgr->resume_work, amdgpu_userq_restore_worker);
 	return 0;
 }
 
 void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr *userq_mgr)
 {
-	struct amdgpu_device *adev = userq_mgr->adev;
 	struct amdgpu_usermode_queue *queue;
-	struct amdgpu_userq_mgr *uqm, *tmp;
-	uint32_t queue_id;
+	unsigned long queue_id;
 
 	cancel_delayed_work_sync(&userq_mgr->resume_work);
 
-	mutex_lock(&adev->userq_mutex);
 	mutex_lock(&userq_mgr->userq_mutex);
-	idr_for_each_entry(&userq_mgr->userq_idr, queue, queue_id) {
+	xa_for_each(&userq_mgr->userq_mgr_xa, queue_id, queue) {
 		amdgpu_userq_wait_for_last_fence(userq_mgr, queue);
 		amdgpu_userq_unmap_helper(userq_mgr, queue);
 		amdgpu_userq_cleanup(userq_mgr, queue, queue_id);
 	}
 
-	list_for_each_entry_safe(uqm, tmp, &adev->userq_mgr_list, list) {
-		if (uqm == userq_mgr) {
-			list_del(&uqm->list);
-			break;
-		}
-	}
-	idr_destroy(&userq_mgr->userq_idr);
+	xa_destroy(&userq_mgr->userq_mgr_xa);
 	mutex_unlock(&userq_mgr->userq_mutex);
-	mutex_unlock(&adev->userq_mutex);
 	mutex_destroy(&userq_mgr->userq_mutex);
 }
 
@@ -965,25 +972,23 @@ int amdgpu_userq_suspend(struct amdgpu_device *adev)
 {
 	u32 ip_mask = amdgpu_userq_get_supported_ip_mask(adev);
 	struct amdgpu_usermode_queue *queue;
-	struct amdgpu_userq_mgr *uqm, *tmp;
-	int queue_id;
+	struct amdgpu_userq_mgr *uqm;
+	unsigned long queue_id;
 	int ret = 0, r;
 
 	if (!ip_mask)
 		return 0;
 
-	mutex_lock(&adev->userq_mutex);
-	list_for_each_entry_safe(uqm, tmp, &adev->userq_mgr_list, list) {
+	xa_for_each(&adev->userq_doorbell_xa, queue_id, queue) {
+		uqm = queue->userq_mgr;
 		cancel_delayed_work_sync(&uqm->resume_work);
 		mutex_lock(&uqm->userq_mutex);
-		idr_for_each_entry(&uqm->userq_idr, queue, queue_id) {
-			r = amdgpu_userq_unmap_helper(uqm, queue);
-			if (r)
-				ret = r;
-		}
+		r = amdgpu_userq_unmap_helper(uqm, queue);
+		if (r)
+			ret = r;
 		mutex_unlock(&uqm->userq_mutex);
 	}
-	mutex_unlock(&adev->userq_mutex);
+
 	return ret;
 }
 
@@ -991,24 +996,22 @@ int amdgpu_userq_resume(struct amdgpu_device *adev)
 {
 	u32 ip_mask = amdgpu_userq_get_supported_ip_mask(adev);
 	struct amdgpu_usermode_queue *queue;
-	struct amdgpu_userq_mgr *uqm, *tmp;
-	int queue_id;
+	struct amdgpu_userq_mgr *uqm;
+	unsigned long queue_id;
 	int ret = 0, r;
 
 	if (!ip_mask)
 		return 0;
 
-	mutex_lock(&adev->userq_mutex);
-	list_for_each_entry_safe(uqm, tmp, &adev->userq_mgr_list, list) {
+	xa_for_each(&adev->userq_doorbell_xa, queue_id, queue) {
+		uqm = queue->userq_mgr;
 		mutex_lock(&uqm->userq_mutex);
-		idr_for_each_entry(&uqm->userq_idr, queue, queue_id) {
-			r = amdgpu_userq_map_helper(uqm, queue);
-			if (r)
-				ret = r;
-		}
+		r = amdgpu_userq_map_helper(uqm, queue);
+		if (r)
+			ret = r;
 		mutex_unlock(&uqm->userq_mutex);
 	}
-	mutex_unlock(&adev->userq_mutex);
+
 	return ret;
 }
 
@@ -1017,33 +1020,31 @@ int amdgpu_userq_stop_sched_for_enforce_isolation(struct amdgpu_device *adev,
 {
 	u32 ip_mask = amdgpu_userq_get_supported_ip_mask(adev);
 	struct amdgpu_usermode_queue *queue;
-	struct amdgpu_userq_mgr *uqm, *tmp;
-	int queue_id;
+	struct amdgpu_userq_mgr *uqm;
+	unsigned long queue_id;
 	int ret = 0, r;
 
 	/* only need to stop gfx/compute */
 	if (!(ip_mask & ((1 << AMDGPU_HW_IP_GFX) | (1 << AMDGPU_HW_IP_COMPUTE))))
 		return 0;
 
-	mutex_lock(&adev->userq_mutex);
 	if (adev->userq_halt_for_enforce_isolation)
 		dev_warn(adev->dev, "userq scheduling already stopped!\n");
 	adev->userq_halt_for_enforce_isolation = true;
-	list_for_each_entry_safe(uqm, tmp, &adev->userq_mgr_list, list) {
+	xa_for_each(&adev->userq_doorbell_xa, queue_id, queue) {
+		uqm = queue->userq_mgr;
 		cancel_delayed_work_sync(&uqm->resume_work);
 		mutex_lock(&uqm->userq_mutex);
-		idr_for_each_entry(&uqm->userq_idr, queue, queue_id) {
-			if (((queue->queue_type == AMDGPU_HW_IP_GFX) ||
-			     (queue->queue_type == AMDGPU_HW_IP_COMPUTE)) &&
-			    (queue->xcp_id == idx)) {
-				r = amdgpu_userq_preempt_helper(uqm, queue);
-				if (r)
-					ret = r;
-			}
+		if (((queue->queue_type == AMDGPU_HW_IP_GFX) ||
+		     (queue->queue_type == AMDGPU_HW_IP_COMPUTE)) &&
+		    (queue->xcp_id == idx)) {
+			r = amdgpu_userq_preempt_helper(uqm, queue);
+			if (r)
+				ret = r;
 		}
 		mutex_unlock(&uqm->userq_mutex);
 	}
-	mutex_unlock(&adev->userq_mutex);
+
 	return ret;
 }
 
@@ -1052,21 +1053,20 @@ int amdgpu_userq_start_sched_for_enforce_isolation(struct amdgpu_device *adev,
 {
 	u32 ip_mask = amdgpu_userq_get_supported_ip_mask(adev);
 	struct amdgpu_usermode_queue *queue;
-	struct amdgpu_userq_mgr *uqm, *tmp;
-	int queue_id;
+	struct amdgpu_userq_mgr *uqm;
+	unsigned long queue_id;
 	int ret = 0, r;
 
 	/* only need to stop gfx/compute */
 	if (!(ip_mask & ((1 << AMDGPU_HW_IP_GFX) | (1 << AMDGPU_HW_IP_COMPUTE))))
 		return 0;
 
-	mutex_lock(&adev->userq_mutex);
 	if (!adev->userq_halt_for_enforce_isolation)
 		dev_warn(adev->dev, "userq scheduling already started!\n");
 	adev->userq_halt_for_enforce_isolation = false;
-	list_for_each_entry_safe(uqm, tmp, &adev->userq_mgr_list, list) {
+	xa_for_each(&adev->userq_doorbell_xa, queue_id, queue) {
+		uqm = queue->userq_mgr;
 		mutex_lock(&uqm->userq_mutex);
-		idr_for_each_entry(&uqm->userq_idr, queue, queue_id) {
 			if (((queue->queue_type == AMDGPU_HW_IP_GFX) ||
 			     (queue->queue_type == AMDGPU_HW_IP_COMPUTE)) &&
 			    (queue->xcp_id == idx)) {
@@ -1074,9 +1074,8 @@ int amdgpu_userq_start_sched_for_enforce_isolation(struct amdgpu_device *adev,
 				if (r)
 					ret = r;
 			}
-		}
 		mutex_unlock(&uqm->userq_mutex);
 	}
-	mutex_unlock(&adev->userq_mutex);
+
 	return ret;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
index c027dd916672..c562c8d2b53a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -88,11 +88,15 @@ struct amdgpu_userq_funcs {
 
 /* Usermode queues for gfx */
 struct amdgpu_userq_mgr {
-	struct idr			userq_idr;
+	/**
+	 * @userq_mgr_xa: Per-process user queue map (queue ID → queue)
+	 * Key: queue_id (unique ID within the process's userq manager)
+	 * Value: struct amdgpu_usermode_queue
+	 */
+	struct xarray			userq_mgr_xa;
 	struct mutex			userq_mutex;
 	struct amdgpu_device		*adev;
 	struct delayed_work		resume_work;
-	struct list_head		list;
 	struct drm_file			*file;
 };
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
index 95e91d1dc58a..cc597fae8971 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
@@ -537,7 +537,7 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
 	}
 
 	/* Retrieve the user queue */
-	queue = idr_find(&userq_mgr->userq_idr, args->queue_id);
+	queue = xa_load(&userq_mgr->userq_mgr_xa, args->queue_id);
 	if (!queue) {
 		r = -ENOENT;
 		goto put_gobj_write;
@@ -899,7 +899,7 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
 		 */
 		num_fences = dma_fence_dedup_array(fences, num_fences);
 
-		waitq = idr_find(&userq_mgr->userq_idr, wait_info->waitq_id);
+		waitq = xa_load(&userq_mgr->userq_mgr_xa, wait_info->waitq_id);
 		if (!waitq) {
 			r = -EINVAL;
 			goto free_fences;
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
index 2db9b2c63693..9e4229c79c69 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
@@ -205,9 +205,9 @@ static int mes_userq_detect_and_reset(struct amdgpu_device *adev,
 	int db_array_size = amdgpu_mes_get_hung_queue_db_array_size(adev);
 	struct mes_detect_and_reset_queue_input input;
 	struct amdgpu_usermode_queue *queue;
-	struct amdgpu_userq_mgr *uqm, *tmp;
 	unsigned int hung_db_num = 0;
-	int queue_id, r, i;
+	unsigned long queue_id;
+	int r, i;
 	u32 db_array[4];
 
 	if (db_array_size > 4) {
@@ -227,16 +227,14 @@ static int mes_userq_detect_and_reset(struct amdgpu_device *adev,
 	if (r) {
 		dev_err(adev->dev, "Failed to detect and reset queues, err (%d)\n", r);
 	} else if (hung_db_num) {
-		list_for_each_entry_safe(uqm, tmp, &adev->userq_mgr_list, list) {
-			idr_for_each_entry(&uqm->userq_idr, queue, queue_id) {
-				if (queue->queue_type == queue_type) {
-					for (i = 0; i < hung_db_num; i++) {
-						if (queue->doorbell_index == db_array[i]) {
-							queue->state = AMDGPU_USERQ_STATE_HUNG;
-							atomic_inc(&adev->gpu_reset_counter);
-							amdgpu_userq_fence_driver_force_completion(queue);
-							drm_dev_wedged_event(adev_to_drm(adev), DRM_WEDGE_RECOVERY_NONE, NULL);
-						}
+		xa_for_each(&adev->userq_doorbell_xa, queue_id, queue) {
+			if (queue->queue_type == queue_type) {
+				for (i = 0; i < hung_db_num; i++) {
+					if (queue->doorbell_index == db_array[i]) {
+						queue->state = AMDGPU_USERQ_STATE_HUNG;
+						atomic_inc(&adev->gpu_reset_counter);
+						amdgpu_userq_fence_driver_force_completion(queue);
+						drm_dev_wedged_event(adev_to_drm(adev), DRM_WEDGE_RECOVERY_NONE, NULL);
 					}
 				}
 			}
-- 
2.49.0

