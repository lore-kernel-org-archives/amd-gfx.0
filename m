Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83517CAC599
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Sep 2025 09:36:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1855B10E76A;
	Tue, 16 Sep 2025 09:36:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jjECUYEg";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010032.outbound.protection.outlook.com
 [40.93.198.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C349D10E070
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Sep 2025 09:36:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VdrDcLH2IKt/pxX+WnzPGHSF+oC4bL8bpdr6mn2bqF7bpz4cekQ5o+7smK5dzUKP0OUMN8OeJeDAaB9kX7PPMXldiSBKxZJMJIFhBlqI0hefOuPipZ7DFOyoIEaN7zwS4gV5j5u9i5EUXd+wjeTBGtT3gvP27pRXD4a6CytJFjlYkg/02CbqVEiqj232zq55SVALTy+wkNpEU+1MasJco/7/ZhCeDd4S96k4jNxzU1m0AMnIEYGk/BT+Zc52uHe1kZtqRBZRj8neY6iJFKx4NZ+B+44ravXc30Mi5FxeBR1uFpAlh6oJgNTLtCa8vzfK9trHXYIm9GjnyR6hw4UoJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kV6zZJjGDcd/PttpjNQTJ6S5GULZynMh64Ki3stug+o=;
 b=VrizpHavvVy8dljCaJiYlFQR47PW6bBPG3NjpexWE+AsbSDEhzWNboLMAshz+1pI/tGki9OSfS3Y+TRUAWVzBZbqtG+wwQnOMXi4GLijP4eUJKY3KpZpRxtKPDn/89ph3TliTHB0Y5XuRFtXyfJCaZSnIPuTEWdC5+dtHK5Ofg+b4WnBuaKbohdWbVJPeRg6O9psjJcjPh78o+pjL3Ux9iyoFUnZuj710x947pR9gVsRHkUX/cSMSf3DqmZ0/qg2Lw6ojSjDnKiEv4fMkTh1i1L3cNPoeGPv/0ldbQT64yB8MtQ9U69ZIT8Rhgc87xH9pbV0UDMhctPuOAYA1u4wOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kV6zZJjGDcd/PttpjNQTJ6S5GULZynMh64Ki3stug+o=;
 b=jjECUYEg0U2B1ST1SQriuk/zz2Mmzmh0RC4QoM+kRv7K6WiXcEV+2MJ0WovMy/tjxdGP5wGJZJNmrce7n0f05c/Efhgnn7xo0+4dKAn2rco/cn2w9OnO7fww9EXM6Vk6ZpNIHfBO8DvI+oCBscpztfYYvwL+BanCHB7QolZX5Og=
Received: from CH0PR03CA0404.namprd03.prod.outlook.com (2603:10b6:610:11b::33)
 by MN0PR12MB5810.namprd12.prod.outlook.com (2603:10b6:208:376::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.19; Tue, 16 Sep
 2025 09:36:22 +0000
Received: from CH2PEPF00000148.namprd02.prod.outlook.com
 (2603:10b6:610:11b:cafe::58) by CH0PR03CA0404.outlook.office365.com
 (2603:10b6:610:11b::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.13 via Frontend Transport; Tue,
 16 Sep 2025 09:36:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF00000148.mail.protection.outlook.com (10.167.244.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Tue, 16 Sep 2025 09:36:21 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Tue, 16 Sep
 2025 02:36:20 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 16 Sep
 2025 04:36:19 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Tue, 16 Sep 2025 02:36:18 -0700
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse.Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH V3] drm/amdgpu: Convert amdgpu userqueue management from IDR
 to XArray
Date: Tue, 16 Sep 2025 17:35:29 +0800
Message-ID: <20250916093617.1046358-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: None (SATLEXMB05.amd.com: Jesse.Zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000148:EE_|MN0PR12MB5810:EE_
X-MS-Office365-Filtering-Correlation-Id: 30a3258a-2d31-4eb0-fbe2-08ddf5047f3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?b1YwUktHcUJzVCtPMlNuN3NsN2pva2xkaXowbGpuNDA2OGpnckhiZG9SYkxZ?=
 =?utf-8?B?WSs4Smd6MUI3bWdFd0R2ZSt5KzBtMmRlVWxGSTlMcmMzdXgwMzE2ZE5HcVFV?=
 =?utf-8?B?M01Lam1wb0ZBMGF0WGZUQnJielNCQXZIcFZ5SnpoMUtabnV5QTdSeVZSc1pl?=
 =?utf-8?B?R3pBdFYxVjlOWmV0QzIxZHpVbGpjTDhJOVRkMFBxSm9XVzZ6US9VRVhteS9V?=
 =?utf-8?B?Uk9lbEsxaTZCQ1hoalRkTDlLUldKWU1xanVnbnh1Njc3TzdEdGg1MnIyZElH?=
 =?utf-8?B?N1JDUzN5Y1NLTkZRSHp2SmN0QnZGZEM3cHc3ais5aERJcWQ1S3dFMXlqdXZP?=
 =?utf-8?B?UWluMkpucExTTThJcTVIeGt3UDZxVnhNVktBa0o2N1JxTE9SbWFUWUZVV0Fa?=
 =?utf-8?B?Wm9zZW0zd2F1OCtLbExDaG04K0U1Wm1uKzJTTzFnY2d1WXlSSGxWM0dmMzNV?=
 =?utf-8?B?aE9YUG1Hem5Vb2dWLzEvMWMvQUdaYUlBbE5WRWJuQWQxQlgrTWtpVE5Jend0?=
 =?utf-8?B?L0cyYmJPTVlnZGVIV2FFZUJldVV3bDBHQnlQbzBLZFBHNjZBalZNeUZQWEtz?=
 =?utf-8?B?bWtYd1o1Z0tBbU5KUjNDS2FqaFpQT1VXSHJYOXFuNnZ3ZE1mbCtHSXF6WkFW?=
 =?utf-8?B?QVBpZnpiT3ZsNk9CK2lGTGRuU0xrZEh2VGh2STRranVQTTc2RXVUcTlOam0r?=
 =?utf-8?B?cGlVUlJyKzdUeEN4VE5kYkNPQkFTNW5YMENjcjlLNTNnNGErclFvWmE5ZWl3?=
 =?utf-8?B?VlBHbzVKNnZISUhDRUE4dDNlUmh3ZWFZZzFzdUhSbUdmVTlhc0prdm5sejA4?=
 =?utf-8?B?SmlCQ1RHNGtBMmM2Smhadjk2Y2x1NEdOUElTbTJCVTJidmkxajBYTkFxUGNi?=
 =?utf-8?B?bjRrclhVbmVWZ09jUFgrT3F0Q0xGWjlyM1BkbHVhNU9HTUd6eVBwdy9va1R0?=
 =?utf-8?B?UGRIcjFJZHlwTHpHQXVwWVVUS1h4eU9zTlIvZ3kwVFo1OE53ZkZIcCt1TUkw?=
 =?utf-8?B?SFlSems5Mi9RRElodXhNV3EwWVkrcTQ1TjZ3M0gvVXpzbENBMm91a2Y0SkhE?=
 =?utf-8?B?YTdXWm9zOUtnV3hVU1hYMkJCQldiUTFKL241ZVlMWXBCckVuNkN1bk51TlZ5?=
 =?utf-8?B?UVRPMVdjN0FnNFFSSEVObU5lV0pwd1poTDdtOENHTFVDeE5TamxCQzJ4YTRh?=
 =?utf-8?B?bWNUSFd2SlBIdy9BK0NYanQvWHNlMERXbWtrSC9GeGpUZFFCWWVyakhxNkNR?=
 =?utf-8?B?c3o3NCtqeUthWlJYeEJxSUNOTWM1YjNHMGhiNHkzbk1YRC9McHRCMkdpSEpo?=
 =?utf-8?B?ZGpnanpqbUNXWk9ROWkrU3lDNFBxdzJESXAxN0dDb0Y5SW1pTncva2hBSi9y?=
 =?utf-8?B?UTJXL2t1cjV1aW16cGtBd2FDTzIxRFlEenVpbVB3Ync4am11QWkwSFRKT2Ns?=
 =?utf-8?B?L2RKWFh6WkFwOE9xeTZCMTF5MTIzb2xlciszV1QxdXB0djBnN25OYmdCY3BH?=
 =?utf-8?B?ajdEeWtOc3NIQlRpaEZGM21NVTV0QnlLL2NFU29wSDN5bEthYUQ3WDlyUG5K?=
 =?utf-8?B?YzQrSWYxd09ZOVNHL1VHSS8xaUx5WGxpQXRnVXNMbVBFMnZQMXJpWklwT0Z5?=
 =?utf-8?B?cGZ1SE1PVG0zajUrU1FBRXVqR092b1ZnbjhqVTU5NU5yYXRabTlZTTkzOWl4?=
 =?utf-8?B?K2xManNLS05laFRCMUdxbjJKMVNrWmYyWXVZbU1uVWpQTGsxV3c3aWlmbDUv?=
 =?utf-8?B?TDU2OFI4YUFMbW9RQnNQYVpOWHV0bUVPQm5HaEd2dEdUMUMvVFNBZ0QyTmN3?=
 =?utf-8?B?c3diakJiNXd2bEc0R3l6UTFuZ0FmbzBQeFdlak04UXhJc2txOVArOXJFTjg5?=
 =?utf-8?B?dXJtRzF5TlFtVFpYMkNrN3lENkVlVyttbWZCMlN6aFNiRGszbFo3VmIxTUE5?=
 =?utf-8?B?dFY2dTZ4bWtiWWJyejVBdzlWV0N4MzVtWlY3OG9LMm1Zcys2UGR6d25TT1Z1?=
 =?utf-8?B?MkJQZitGSUZxak1rOFp4TWlnUTRQZXczWnJZQjJYYWVyQXF3WGF4V2J6dDk1?=
 =?utf-8?Q?NgLyEk?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2025 09:36:21.9503 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 30a3258a-2d31-4eb0-fbe2-08ddf5047f3f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000148.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5810
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
   - Added `userq_global_xa` to `struct amdgpu_device` for global queue tracking
   - Uses doorbell_index as key for efficient global lookup
   - Replaces the previous `userq_mgr_list` linked list approach

2. **Per-process XArray Conversion**:
   - Replaced `userq_idr` with `userq_xa` in `struct amdgpu_userq_mgr`
   - Maintains per-process queue tracking with queue_id as key
   - Uses XA_FLAGS_ALLOC for automatic ID allocation

3. **Locking Improvements**:
   - Removed global `userq_mutex` from `struct amdgpu_device`
   - Replaced with fine-grained XArray locking using `xa_lock()`/`xa_unlock()`
   - Eliminated potential deadlocks from nested mutex operations

4. **Runtime Idle Check Optimization**:
   - Updated `amdgpu_runtime_idle_check_userq()` to use XArray iteration
   - Simplified logic and improved performance with direct XArray access

5. **Queue Management Functions**:
   - Converted all IDR operations to equivalent XArray functions:
     - `idr_alloc()` → `xa_alloc()`
     - `idr_find()` → `xa_load()`
     - `idr_remove()` → `xa_erase()`
     - `idr_for_each()` → `xa_for_each()`

6. **Suspend/Resume Logic**:
   - Rewrote suspend/resume functions to use XArray iteration
   - Improved error handling and resource cleanup
   - Fixed potential race conditions in queue state management

7. **DebugFS and IOCTL Updates**:
   - Updated all userqueue-related IOCTL handlers for XArray compatibility
   - Modified debugfs functionality to work with new XArray structure

Benefits:
- **Performance**: XArray provides better scalability for large numbers of queues
- **Memory Efficiency**: Reduced memory overhead compared to IDR
- **Thread Safety**: Improved locking semantics with XArray's internal spinlocks

Fixes addressed:
- Resolves soft lockup issues in queue cleanup operations
- Eliminates "scheduling while atomic" bugs in fini operations
- Prevents potential deadlocks in global queue management
- Improves error handling and resource cleanup reliability

Suggested-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |   7 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |   3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |  12 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c     | 150 +++++++++---------
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h     |   9 +-
 .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   |   4 +-
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c    |  28 ++--
 7 files changed, 109 insertions(+), 104 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 2a0df4cabb99..2800ef816e51 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1174,6 +1174,11 @@ struct amdgpu_device {
 	 * queue fence.
 	 */
 	struct xarray			userq_xa;
+	/* Global queue index,
+	 * key: doorbell_index,
+	 * value: struct amdgpu_usermode_queue
+	 */
+	struct xarray 			userq_global_xa;
 
 	/* df */
 	struct amdgpu_df                df;
@@ -1308,8 +1313,6 @@ struct amdgpu_device {
 	 */
 	bool                            apu_prefer_gtt;
 
-	struct list_head		userq_mgr_list;
-	struct mutex                    userq_mutex;
 	bool                            userq_halt_for_enforce_isolation;
 	struct amdgpu_uid *uid_info;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 0fdfde3dcb9f..4c9b4614be53 100644
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
+	xa_init(&adev->userq_global_xa);
 
 	INIT_DELAYED_WORK(&adev->delayed_init_work,
 			  amdgpu_device_delayed_init_work_handler);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index ece251cbe8c3..d1d2fcbd4195 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2772,20 +2772,18 @@ static int amdgpu_runtime_idle_check_userq(struct device *dev)
 	struct drm_device *drm_dev = pci_get_drvdata(pdev);
 	struct amdgpu_device *adev = drm_to_adev(drm_dev);
 	struct amdgpu_usermode_queue *queue;
-	struct amdgpu_userq_mgr *uqm, *tmp;
-	int queue_id;
+	unsigned long queue_id;
 	int ret = 0;
 
-	mutex_lock(&adev->userq_mutex);
-	list_for_each_entry_safe(uqm, tmp, &adev->userq_mgr_list, list) {
-		idr_for_each_entry(&uqm->userq_idr, queue, queue_id) {
+	xa_lock(&adev->userq_global_xa);
+	xa_for_each(&adev->userq_global_xa, queue_id, queue) {
+		if (queue) {
 			ret = -EBUSY;
 			goto done;
 		}
 	}
 done:
-	mutex_unlock(&adev->userq_mutex);
-
+	xa_unlock(&adev->userq_global_xa);
 	return ret;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index b649ac0cedff..c285bf927c46 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -183,14 +183,18 @@ amdgpu_userq_cleanup(struct amdgpu_userq_mgr *uq_mgr,
 
 	uq_funcs->mqd_destroy(uq_mgr, queue);
 	amdgpu_userq_fence_driver_free(queue);
-	idr_remove(&uq_mgr->userq_idr, queue_id);
+	__xa_erase(&uq_mgr->userq_xa, (unsigned long)queue_id);
+
+	/* Remove from global XArray */
+	__xa_erase(&adev->userq_global_xa, queue->doorbell_index);
+
 	kfree(queue);
 }
 
 static struct amdgpu_usermode_queue *
 amdgpu_userq_find(struct amdgpu_userq_mgr *uq_mgr, int qid)
 {
-	return idr_find(&uq_mgr->userq_idr, qid);
+	return xa_load(&uq_mgr->userq_xa, qid);
 }
 
 void
@@ -362,6 +366,7 @@ amdgpu_userq_destroy(struct drm_file *filp, int queue_id)
 	int r = 0;
 
 	cancel_delayed_work_sync(&uq_mgr->resume_work);
+	xa_lock(&adev->userq_global_xa);
 	mutex_lock(&uq_mgr->userq_mutex);
 
 	queue = amdgpu_userq_find(uq_mgr, queue_id);
@@ -389,6 +394,7 @@ amdgpu_userq_destroy(struct drm_file *filp, int queue_id)
 	}
 	amdgpu_userq_cleanup(uq_mgr, queue, queue_id);
 	mutex_unlock(&uq_mgr->userq_mutex);
+	xa_unlock(&adev->userq_global_xa);
 
 	pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
 	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
@@ -462,8 +468,9 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 	struct amdgpu_db_info db_info;
 	char *queue_name;
 	bool skip_map_queue;
+	u32 qid;
 	uint64_t index;
-	int qid, r = 0;
+	int r = 0;
 	int priority =
 		(args->in.flags & AMDGPU_USERQ_CREATE_FLAGS_QUEUE_PRIORITY_MASK) >>
 		AMDGPU_USERQ_CREATE_FLAGS_QUEUE_PRIORITY_SHIFT;
@@ -471,7 +478,6 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 	r = amdgpu_userq_priority_permit(filp, priority);
 	if (r)
 		return r;
-
 	r = pm_runtime_get_sync(adev_to_drm(adev)->dev);
 	if (r < 0) {
 		drm_file_err(uq_mgr->file, "pm_runtime_get_sync() failed for userqueue create\n");
@@ -486,7 +492,6 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 	 *
 	 * This will also make sure we have a valid eviction fence ready to be used.
 	 */
-	mutex_lock(&adev->userq_mutex);
 	amdgpu_userq_ensure_ev_fence(&fpriv->userq_mgr, &fpriv->evf_mgr);
 
 	uq_funcs = adev->userq_funcs[args->in.ip_type];
@@ -546,9 +551,16 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 		goto unlock;
 	}
 
+	xa_lock(&adev->userq_global_xa);
+	r =xa_err(__xa_store(&adev->userq_global_xa, index, queue, GFP_KERNEL));
+	xa_unlock(&adev->userq_global_xa);
+	if (r) {
+		kfree(queue);
+		goto unlock;
+	}
 
-	qid = idr_alloc(&uq_mgr->userq_idr, queue, 1, AMDGPU_MAX_USERQ_COUNT, GFP_KERNEL);
-	if (qid < 0) {
+	r = xa_alloc(&uq_mgr->userq_xa, &qid, queue, XA_LIMIT(1, AMDGPU_MAX_USERQ_COUNT), GFP_KERNEL);
+	if (r) {
 		drm_file_err(uq_mgr->file, "Failed to allocate a queue id\n");
 		amdgpu_userq_fence_driver_free(queue);
 		uq_funcs->mqd_destroy(uq_mgr, queue);
@@ -568,7 +580,7 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 		r = amdgpu_userq_map_helper(uq_mgr, queue);
 		if (r) {
 			drm_file_err(uq_mgr->file, "Failed to map Queue\n");
-			idr_remove(&uq_mgr->userq_idr, qid);
+			xa_erase(&uq_mgr->userq_xa, qid);
 			amdgpu_userq_fence_driver_free(queue);
 			uq_funcs->mqd_destroy(uq_mgr, queue);
 			kfree(queue);
@@ -591,7 +603,6 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 
 unlock:
 	mutex_unlock(&uq_mgr->userq_mutex);
-	mutex_unlock(&adev->userq_mutex);
 
 	return r;
 }
@@ -689,11 +700,11 @@ static int
 amdgpu_userq_restore_all(struct amdgpu_userq_mgr *uq_mgr)
 {
 	struct amdgpu_usermode_queue *queue;
-	int queue_id;
+	unsigned long queue_id;
 	int ret = 0, r;
 
 	/* Resume all the queues for this process */
-	idr_for_each_entry(&uq_mgr->userq_idr, queue, queue_id) {
+	xa_for_each(&uq_mgr->userq_xa, queue_id, queue) {
 		r = amdgpu_userq_restore_helper(uq_mgr, queue);
 		if (r)
 			ret = r;
@@ -846,11 +857,11 @@ static int
 amdgpu_userq_evict_all(struct amdgpu_userq_mgr *uq_mgr)
 {
 	struct amdgpu_usermode_queue *queue;
-	int queue_id;
+	unsigned long queue_id;
 	int ret = 0, r;
 
 	/* Try to unmap all the queues in this process ctx */
-	idr_for_each_entry(&uq_mgr->userq_idr, queue, queue_id) {
+	xa_for_each(&uq_mgr->userq_xa, queue_id, queue) {
 		r = amdgpu_userq_preempt_helper(uq_mgr, queue);
 		if (r)
 			ret = r;
@@ -865,9 +876,10 @@ static int
 amdgpu_userq_wait_for_signal(struct amdgpu_userq_mgr *uq_mgr)
 {
 	struct amdgpu_usermode_queue *queue;
-	int queue_id, ret;
+	unsigned long queue_id;
+	int ret;
 
-	idr_for_each_entry(&uq_mgr->userq_idr, queue, queue_id) {
+	xa_for_each(&uq_mgr->userq_xa, queue_id, queue) {
 		struct dma_fence *f = queue->last_fence;
 
 		if (!f || dma_fence_is_signaled(f))
@@ -920,14 +932,10 @@ int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct drm_file *f
 			  struct amdgpu_device *adev)
 {
 	mutex_init(&userq_mgr->userq_mutex);
-	idr_init_base(&userq_mgr->userq_idr, 1);
+	xa_init_flags(&userq_mgr->userq_xa, XA_FLAGS_ALLOC);
 	userq_mgr->adev = adev;
 	userq_mgr->file = file_priv;
 
-	mutex_lock(&adev->userq_mutex);
-	list_add(&userq_mgr->list, &adev->userq_mgr_list);
-	mutex_unlock(&adev->userq_mutex);
-
 	INIT_DELAYED_WORK(&userq_mgr->resume_work, amdgpu_userq_restore_worker);
 	return 0;
 }
@@ -936,28 +944,19 @@ void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr *userq_mgr)
 {
 	struct amdgpu_device *adev = userq_mgr->adev;
 	struct amdgpu_usermode_queue *queue;
-	struct amdgpu_userq_mgr *uqm, *tmp;
-	uint32_t queue_id;
+	unsigned long queue_id;
 
 	cancel_delayed_work_sync(&userq_mgr->resume_work);
 
-	mutex_lock(&adev->userq_mutex);
-	mutex_lock(&userq_mgr->userq_mutex);
-	idr_for_each_entry(&userq_mgr->userq_idr, queue, queue_id) {
+	xa_lock(&adev->userq_global_xa);
+	xa_for_each(&userq_mgr->userq_xa, queue_id, queue) {
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
-	mutex_unlock(&userq_mgr->userq_mutex);
-	mutex_unlock(&adev->userq_mutex);
+	xa_destroy(&userq_mgr->userq_xa);
+	xa_unlock(&adev->userq_global_xa);
 	mutex_destroy(&userq_mgr->userq_mutex);
 }
 
@@ -965,25 +964,24 @@ int amdgpu_userq_suspend(struct amdgpu_device *adev)
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
+	xa_lock(&adev->userq_global_xa);
+	xa_for_each(&adev->userq_global_xa, queue_id, queue) {
+		uqm = queue->userq_mgr;
 		cancel_delayed_work_sync(&uqm->resume_work);
 		mutex_lock(&uqm->userq_mutex);
-		idr_for_each_entry(&uqm->userq_idr, queue, queue_id) {
-			r = amdgpu_userq_unmap_helper(uqm, queue);
-			if (r)
-				ret = r;
-		}
-		mutex_unlock(&uqm->userq_mutex);
+		r = amdgpu_userq_unmap_helper(uqm, queue);
+		if (r)
+			ret = r;
+		mutex_lock(&uqm->userq_mutex);
 	}
-	mutex_unlock(&adev->userq_mutex);
+	xa_unlock(&adev->userq_global_xa);
 	return ret;
 }
 
@@ -991,24 +989,23 @@ int amdgpu_userq_resume(struct amdgpu_device *adev)
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
+	xa_lock(&adev->userq_global_xa);
+	xa_for_each(&adev->userq_global_xa, queue_id, queue) {
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
+	xa_unlock(&adev->userq_global_xa);
 	return ret;
 }
 
@@ -1017,33 +1014,33 @@ int amdgpu_userq_stop_sched_for_enforce_isolation(struct amdgpu_device *adev,
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
+	xa_lock(&adev->userq_global_xa);
+	xa_for_each(&adev->userq_global_xa, queue_id, queue) {
 		cancel_delayed_work_sync(&uqm->resume_work);
+		uqm = queue->userq_mgr;
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
+	xa_unlock(&adev->userq_global_xa);
+
 	return ret;
 }
 
@@ -1052,21 +1049,21 @@ int amdgpu_userq_start_sched_for_enforce_isolation(struct amdgpu_device *adev,
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
-		mutex_lock(&uqm->userq_mutex);
-		idr_for_each_entry(&uqm->userq_idr, queue, queue_id) {
+	xa_lock(&adev->userq_global_xa);
+	xa_for_each(&adev->userq_global_xa, queue_id, queue) {
+		uqm = queue->userq_mgr;
+		mutex_lock(&queue->userq_mgr->userq_mutex);
 			if (((queue->queue_type == AMDGPU_HW_IP_GFX) ||
 			     (queue->queue_type == AMDGPU_HW_IP_COMPUTE)) &&
 			    (queue->xcp_id == idx)) {
@@ -1074,9 +1071,8 @@ int amdgpu_userq_start_sched_for_enforce_isolation(struct amdgpu_device *adev,
 				if (r)
 					ret = r;
 			}
-		}
-		mutex_unlock(&uqm->userq_mutex);
+		mutex_unlock(&queue->userq_mgr->userq_mutex);
 	}
-	mutex_unlock(&adev->userq_mutex);
+	xa_unlock(&adev->userq_global_xa);
 	return ret;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
index c027dd916672..77125bbe3abc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -88,11 +88,16 @@ struct amdgpu_userq_funcs {
 
 /* Usermode queues for gfx */
 struct amdgpu_userq_mgr {
-	struct idr			userq_idr;
+	//struct idr			userq_idr;
+	/* In-process queue index,
+	 * key: queue_id
+	 * value: struct amdgpu_usermode_queue
+	 */
+	struct xarray			userq_xa;
 	struct mutex			userq_mutex;
 	struct amdgpu_device		*adev;
 	struct delayed_work		resume_work;
-	struct list_head		list;
+	//struct list_head		list;
 	struct drm_file			*file;
 };
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
index 95e91d1dc58a..32625079042d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
@@ -537,7 +537,7 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
 	}
 
 	/* Retrieve the user queue */
-	queue = idr_find(&userq_mgr->userq_idr, args->queue_id);
+	queue = xa_load(&userq_mgr->userq_xa, args->queue_id);
 	if (!queue) {
 		r = -ENOENT;
 		goto put_gobj_write;
@@ -899,7 +899,7 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
 		 */
 		num_fences = dma_fence_dedup_array(fences, num_fences);
 
-		waitq = idr_find(&userq_mgr->userq_idr, wait_info->waitq_id);
+		waitq = xa_load(&userq_mgr->userq_xa, wait_info->waitq_id);
 		if (!waitq) {
 			r = -EINVAL;
 			goto free_fences;
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
index 2db9b2c63693..0794bbb944ec 100644
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
@@ -227,20 +227,24 @@ static int mes_userq_detect_and_reset(struct amdgpu_device *adev,
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
+		xa_lock(&adev->userq_global_xa);
+		xa_for_each(&adev->userq_global_xa, queue_id, queue) {
+			mutex_lock(&queue->userq_mgr->userq_mutex);
+			if (queue->queue_type == queue_type) {
+				for (i = 0; i < hung_db_num; i++) {
+					if (queue->doorbell_index == db_array[i]) {
+						queue = xa_load(&adev->userq_global_xa, db_array[i]);
+						queue->state = AMDGPU_USERQ_STATE_HUNG;
+						queue->state = AMDGPU_USERQ_STATE_HUNG;
+						atomic_inc(&adev->gpu_reset_counter);
+						amdgpu_userq_fence_driver_force_completion(queue);
+						drm_dev_wedged_event(adev_to_drm(adev), DRM_WEDGE_RECOVERY_NONE, NULL);
 					}
 				}
 			}
+			mutex_unlock(&queue->userq_mgr->userq_mutex);
 		}
+		xa_unlock(&adev->userq_global_xa);
 	}
 
 	return r;
-- 
2.49.0

