Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D49A8CAC598
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Sep 2025 09:57:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 421F810E037;
	Wed, 17 Sep 2025 09:57:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XoLuA8Fa";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010003.outbound.protection.outlook.com [52.101.46.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA8EC10E037
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Sep 2025 09:57:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hipbau0CaOK2Q1VWFZu/1+QMBm9HzkULU46rfoZr119dwC/VZrXpYAfJ3Fyi5IDPPWphqpjO14vTPnlCNF5M/RVHA3i9bSjv1lYFoMxmyGYRlWhv1EQ9lwp1WFTPy2NmG4Ds+wYkupllJdYq/2wrCtmvkAnhTxGE1tkZniDCxFy7WT5oKbaN8iwJE/LcrhTAN0Ju7pGyw4u2qdOeHxZZTSq5MlbqWmA7y2frO9S+3w6HnpkJCA+dHDgobVbcbRAoELiBP7A8T29wf4kYBqMcgetf7tIpoHA0oGVvU/m71N2ofBHGO13bh5sD3fjNg+k46loXQ1qgH0SmlZ3eVRnvHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vFc7axWMNT/9/w2A8tdqS5BKyBpT3H8Pj2S/z2j6HyQ=;
 b=FN6cfa3fh45lo51URmV+w/u69yaqNPmOc0IqnO/lz6+yIUDZPeG3IhfAci28wXjoSZfjctV9z1ex/8t0RM8jVctpX40ku1dzJjaanEuVjY6Dw7YKZuG+qLW/yA8fcOhmdmkSN9CugLZKNBsHX5fESMED24Zn7FLGVyC4X20O9+7K/L8UKOOSbchtdxANQqW3kIF5DruAL1x7EMbhPvzXz99/Otgmxy3rUXZKNjHNBNwABCGtdFE6tJ6E6E6rXNS/vAaD+4ZYi0a2YZSGCQSrf2jPWumpe0Qztt8HUZDmU5HVQojCOmLrQF3uK0VYEtsojaYg35K8mz8iOQhLy8jGCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vFc7axWMNT/9/w2A8tdqS5BKyBpT3H8Pj2S/z2j6HyQ=;
 b=XoLuA8FaqfPZIC/w0qdtj11sU7SUHKGgIAM/ALwxthCGZk2KlB/bEuy1PpxTS/p/8ZpP5xz8x6xb/2cwcT0qXxjyk4jARY3+ECaevxQcUX66PtPRxHwRZa7JOoavYow0STY5OmUKTCRb3DeMoGz9hETzpj0EnfpB6gJbSEL9yFs=
Received: from CH5P222CA0018.NAMP222.PROD.OUTLOOK.COM (2603:10b6:610:1ee::29)
 by SA1PR12MB8721.namprd12.prod.outlook.com (2603:10b6:806:38d::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.23; Wed, 17 Sep
 2025 09:57:26 +0000
Received: from CH1PEPF0000AD78.namprd04.prod.outlook.com
 (2603:10b6:610:1ee:cafe::36) by CH5P222CA0018.outlook.office365.com
 (2603:10b6:610:1ee::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.13 via Frontend Transport; Wed,
 17 Sep 2025 09:57:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH1PEPF0000AD78.mail.protection.outlook.com (10.167.244.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Wed, 17 Sep 2025 09:57:26 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 17 Sep
 2025 02:57:25 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 17 Sep
 2025 02:57:25 -0700
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Wed, 17 Sep 2025 02:57:23 -0700
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse.Zhang <Jesse.Zhang@amd.com>
Subject: [v4] drm/amdgpu: Convert amdgpu userqueue management from IDR to
 XArray
Date: Wed, 17 Sep 2025 17:54:26 +0800
Message-ID: <20250917095723.1568958-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD78:EE_|SA1PR12MB8721:EE_
X-MS-Office365-Filtering-Correlation-Id: 6683d82b-ca6c-441a-88a0-08ddf5d09b4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?USswR2FuNTA4aURqeXFRUVlYK1Q3cU1VS3B5WEtFMThDdjhKZHdqNW5ySVgr?=
 =?utf-8?B?SUdjM3dqaHRwUGsxdlRKVWhtYzhxY1daOE0rbVpJSjRYbnlzNXVZc0VjTFZR?=
 =?utf-8?B?ODQrUFdoaCsxd3JDd0RUUEVNa2FROFBLYjlYNm1VUFZORlExVWJTU2JhWkxM?=
 =?utf-8?B?UmZwZERlNWRSanJURmFJcFp0Q3ZTSk82RUJPZHROdFM0dm1Wd1ZoL1NnUU5I?=
 =?utf-8?B?cUhTRDRBSzNoNW8rT29na1dGSnpSK0NXQkwzSUJ5dFdwTURSYVhqV28xODZF?=
 =?utf-8?B?QmY3dkdpaUQ5S0l4T0d5L1VlSGxHZDhQekJ3UGdiaUVMazRYbTNnUW5TaWth?=
 =?utf-8?B?RXFrZWpGdHZ3TXBWd2p1Wk05OFRYQ2lFYkRYSHdPUjl1ZkUyQ0JMa0MrbFUr?=
 =?utf-8?B?bUx4L3lTK0pEbXE5RUMxWGxQd2tDNXhUYVlQSGxPZmJwbHFBcUhueHpsVnoz?=
 =?utf-8?B?WCtRaVlxWUY5SUJtMEhaVkxZWERXQzNrcytTZk42aXJUamVsM3pNbkN6YTFw?=
 =?utf-8?B?dVRmR2ZQOXRLYkhidGNMT2lwckNzNEF3Sm1qcFRVQ3BGVjBxYzE0cng0T25h?=
 =?utf-8?B?L1ZpWEU5Y1JNb2FkVnpsTGJlWlVTaDBnczhycnJ4NG9tNVlqS1JUS1JZanp1?=
 =?utf-8?B?VDc4RkNpT0hRMGo3VU1LRGRURkNqajJab3FRRFNjNG51YWVLTlNTR0UycE9k?=
 =?utf-8?B?em9nbGIrUzV1K0JOcFJGSDRIUmtLMmpKU2dsTS9FUWlKbmJ5U0J6ZGRQYks4?=
 =?utf-8?B?OFYxcCtFNUdFZTZFNnJLR1REYnFsYjBQKzRhZDVGOEFENDJKV2pDRjdWNjJH?=
 =?utf-8?B?YjcyRUpYSkZoVUJuL09oa0FLcXJnbFFnMXlIdStPd0ZOck92M2pLTk91YURl?=
 =?utf-8?B?Z3RJZWhISy9rRllSdmZGaGttZ3hVdTBMYU1nTytEN3FaOGZWWjUvNU1iT1Rj?=
 =?utf-8?B?TkJ6a2JkV3FNYWF2UG81QVhRVnIzUm51N2doaEc3a1N5RG1BZExLRkljQkxa?=
 =?utf-8?B?dmJJQTRERnFPUDl3cnZDWnNDRUIzNjJCdXVGRjlLelgvY0NoL3JjWHlUbnFr?=
 =?utf-8?B?Q2ZrQ05vM3A3b0ZQM1NUY1lRMUxKdGxtZzlDUTRUS2ppZlhBLzJ5c0w4NDRT?=
 =?utf-8?B?ejMxMzkwaTJJTmZ5bUlHR0N5aGx2S2NjVmhwazhackhSQmFCU0R4eHo4bk44?=
 =?utf-8?B?dkFlRndVd2NHVjJ5VzUrVUFlaUc2R1VoUWQzS3VWZVNjaGcxMXF4eWEvZEEy?=
 =?utf-8?B?Z29kUFBiZ2NRWnFBbStQdjRLUnZpQ3R3L05EN01HdjFiSndqVFBoMFFIdHEx?=
 =?utf-8?B?OGFIalZYV3k1MzFwOEpMUXhpeEdEU0FoeXU5YnJEZTJ1TEx6cmd5bTlUejhP?=
 =?utf-8?B?QXI0UFpTSEN6VzJxN2RHWDNRem8yRDRnZzU3TDVPdnJlZ2JNV3JHeDg4eEZh?=
 =?utf-8?B?cm1kQkxTYXd3YjREb2tVRHZqSnYvbzE0UHh1ZVZXQkdLYmE0ZnRod2t2bTAr?=
 =?utf-8?B?QlZxWDU1QjZIczE3c0c0Y2s2YmZUT1VHTHdxWmdWZUtzK0Q2c1E1YWI1M2FX?=
 =?utf-8?B?cnUyL2c1RlA1S1NXQ2trQVdVaGFUL2tJU0VuYS9GY095OTBqejdTYWFYUEZr?=
 =?utf-8?B?RWFsK1dIVkY4SVZjRytqdUJsWWxNaVhwTGQ3eFZHTHFUQjU0amg5NGp3ZWVG?=
 =?utf-8?B?NEw0cEY4c2ZQTzUzbUYxa0lrYnh0Z3FENjFpU04zMnVaQTdBd1dMY2J4K1Nr?=
 =?utf-8?B?UnFwTU5hMW9rMTkwSEVCa1d0WFBXK3RTb3U1enArSVpUcU5nOXJXSmVmWTQ4?=
 =?utf-8?B?UjVJMGV5b1lON2M5VC9BdDZpYkhmWW93S2YxOWlXNk9ZWGozaitUOS94ekVy?=
 =?utf-8?B?eXZBWWxmODRWRnI2SXhic3JsblhWeVA5cWxuV2Yvd2FLZ2NiNFd0MXFJa0Rp?=
 =?utf-8?B?bjA2ZDQwQ0NkUytiQ3JYNWVWcFJaVzhIYVJOTUg2bWNVZDdWd3p2VzlSL1ps?=
 =?utf-8?B?R2V5dkFzV1JQdkJYN1NlYzcvUmx4YmgvUkhEOTBld2dvU0NLWmVEc3IrMzdq?=
 =?utf-8?Q?QNiegL?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2025 09:57:26.3285 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6683d82b-ca6c-441a-88a0-08ddf5d09b4a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD78.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8721
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

v2: rename userq_global_xa/userq_xa to userq_doorbell_xa/userq_mgr_xa
    Remove xa_lock and use its own lock.

Suggested-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |   8 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |   3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |  15 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c     | 141 ++++++++----------
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h     |   9 +-
 .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   |   4 +-
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c    |  26 ++--
 7 files changed, 98 insertions(+), 108 deletions(-)

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
index ece251cbe8c3..f718923716ce 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2772,19 +2772,12 @@ static int amdgpu_runtime_idle_check_userq(struct device *dev)
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
-			ret = -EBUSY;
-			goto done;
-		}
-	}
-done:
-	mutex_unlock(&adev->userq_mutex);
+	xa_lock(&adev->userq_doorbell_xa);
+	ret = xa_empty(&adev->userq_doorbell_xa) ? 0 : -EBUSY;
+	xa_unlock(&adev->userq_doorbell_xa);
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index b649ac0cedff..46ea63744829 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -180,17 +180,20 @@ amdgpu_userq_cleanup(struct amdgpu_userq_mgr *uq_mgr,
 {
 	struct amdgpu_device *adev = uq_mgr->adev;
 	const struct amdgpu_userq_funcs *uq_funcs = adev->userq_funcs[queue->queue_type];
+	unsigned long flags;
 
 	uq_funcs->mqd_destroy(uq_mgr, queue);
 	amdgpu_userq_fence_driver_free(queue);
-	idr_remove(&uq_mgr->userq_idr, queue_id);
+	xa_erase(&uq_mgr->userq_mgr_xa, (unsigned long)queue_id);
+	xa_erase(&adev->userq_doorbell_xa, queue->doorbell_index);
+
 	kfree(queue);
 }
 
 static struct amdgpu_usermode_queue *
 amdgpu_userq_find(struct amdgpu_userq_mgr *uq_mgr, int qid)
 {
-	return idr_find(&uq_mgr->userq_idr, qid);
+	return xa_load(&uq_mgr->userq_mgr_xa, qid);
 }
 
 void
@@ -462,8 +465,10 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
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
@@ -471,7 +476,6 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 	r = amdgpu_userq_priority_permit(filp, priority);
 	if (r)
 		return r;
-
 	r = pm_runtime_get_sync(adev_to_drm(adev)->dev);
 	if (r < 0) {
 		drm_file_err(uq_mgr->file, "pm_runtime_get_sync() failed for userqueue create\n");
@@ -486,7 +490,6 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 	 *
 	 * This will also make sure we have a valid eviction fence ready to be used.
 	 */
-	mutex_lock(&adev->userq_mutex);
 	amdgpu_userq_ensure_ev_fence(&fpriv->userq_mgr, &fpriv->evf_mgr);
 
 	uq_funcs = adev->userq_funcs[args->in.ip_type];
@@ -546,9 +549,16 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 		goto unlock;
 	}
 
+	local_irq_save(flags);
+	r =xa_err(xa_store(&adev->userq_doorbell_xa, index, queue, GFP_KERNEL));
+	local_irq_restore(flags);
+	if (r) {
+		kfree(queue);
+		goto unlock;
+	}
 
-	qid = idr_alloc(&uq_mgr->userq_idr, queue, 1, AMDGPU_MAX_USERQ_COUNT, GFP_KERNEL);
-	if (qid < 0) {
+	r = xa_alloc(&uq_mgr->userq_mgr_xa, &qid, queue, XA_LIMIT(1, AMDGPU_MAX_USERQ_COUNT), GFP_KERNEL);
+	if (r) {
 		drm_file_err(uq_mgr->file, "Failed to allocate a queue id\n");
 		amdgpu_userq_fence_driver_free(queue);
 		uq_funcs->mqd_destroy(uq_mgr, queue);
@@ -568,7 +578,7 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 		r = amdgpu_userq_map_helper(uq_mgr, queue);
 		if (r) {
 			drm_file_err(uq_mgr->file, "Failed to map Queue\n");
-			idr_remove(&uq_mgr->userq_idr, qid);
+			xa_erase(&uq_mgr->userq_mgr_xa, qid);
 			amdgpu_userq_fence_driver_free(queue);
 			uq_funcs->mqd_destroy(uq_mgr, queue);
 			kfree(queue);
@@ -588,10 +598,8 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 	kfree(queue_name);
 
 	args->out.queue_id = qid;
-
 unlock:
 	mutex_unlock(&uq_mgr->userq_mutex);
-	mutex_unlock(&adev->userq_mutex);
 
 	return r;
 }
@@ -689,11 +697,11 @@ static int
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
@@ -846,11 +854,11 @@ static int
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
@@ -865,9 +873,10 @@ static int
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
@@ -920,44 +929,30 @@ int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct drm_file *f
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
 
@@ -965,25 +960,23 @@ int amdgpu_userq_suspend(struct amdgpu_device *adev)
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
-		mutex_unlock(&uqm->userq_mutex);
+		r = amdgpu_userq_unmap_helper(uqm, queue);
+		if (r)
+			ret = r;
+		mutex_lock(&uqm->userq_mutex);
 	}
-	mutex_unlock(&adev->userq_mutex);
+
 	return ret;
 }
 
@@ -991,24 +984,22 @@ int amdgpu_userq_resume(struct amdgpu_device *adev)
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
 
@@ -1017,33 +1008,31 @@ int amdgpu_userq_stop_sched_for_enforce_isolation(struct amdgpu_device *adev,
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
+
 	return ret;
 }
 
@@ -1052,21 +1041,20 @@ int amdgpu_userq_start_sched_for_enforce_isolation(struct amdgpu_device *adev,
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
+	xa_for_each(&adev->userq_doorbell_xa, queue_id, queue) {
+		uqm = queue->userq_mgr;
+		mutex_lock(&queue->userq_mgr->userq_mutex);
 			if (((queue->queue_type == AMDGPU_HW_IP_GFX) ||
 			     (queue->queue_type == AMDGPU_HW_IP_COMPUTE)) &&
 			    (queue->xcp_id == idx)) {
@@ -1074,9 +1062,8 @@ int amdgpu_userq_start_sched_for_enforce_isolation(struct amdgpu_device *adev,
 				if (r)
 					ret = r;
 			}
-		}
-		mutex_unlock(&uqm->userq_mutex);
+		mutex_unlock(&queue->userq_mgr->userq_mutex);
 	}
-	mutex_unlock(&adev->userq_mutex);
+
 	return ret;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
index c027dd916672..d308afc60b65 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -88,11 +88,16 @@ struct amdgpu_userq_funcs {
 
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
+	//struct list_head		list;
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
index 2db9b2c63693..8995751049be 100644
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
@@ -227,19 +227,21 @@ static int mes_userq_detect_and_reset(struct amdgpu_device *adev,
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
+			mutex_lock(&queue->userq_mgr->userq_mutex);
+			if (queue->queue_type == queue_type) {
+				for (i = 0; i < hung_db_num; i++) {
+					if (queue->doorbell_index == db_array[i]) {
+						queue = xa_load(&adev->userq_doorbell_xa, db_array[i]);
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
 	}
 
-- 
2.49.0

