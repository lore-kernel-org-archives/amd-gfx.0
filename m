Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09CDACCD184
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Oct 2025 01:09:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D6E810E254;
	Wed, 15 Oct 2025 01:09:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fXFON+iU";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010064.outbound.protection.outlook.com [52.101.61.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 61B0D10E254
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Oct 2025 01:09:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=clSavucyLqfLTIAN4+aU+uC1MtA34vAgfTueS52AsC2Zf79e0kEuJuIUFqTk9iJzdavaCW+AtJiXKDNAV5PKJJ6//2oraEoiMpObuZHZkg3VpsfODpj0W6wJqRwUDV8job8nWI2haL1FpFHeJr1SHWmBRiEgviEAXO3p2HzLNky9QtrCrqDv3i8A8/9YQKyErAdc7hKFAu0SIdNT51w09ae82wD39a9kFItpS0rU10mbdJgREZyy/c0XM3bLJp370O+n8M+HT6u4Kh4p6LUKmZVRkhT6uki5jxuOGicz8H8h/E3ReEGJHNA2kYUddHDQC9a/GM//rTyzhNwZCcr4LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KRjx+g4VaZJgPCvKN9oYsAUBAS9Mw74OmuKkGJwoXDU=;
 b=qZFTnNJxLeyIukvaWmFIHEUTstJYPpvkn7Btb1VV8ZByWsDSEpN7ByfncqwX9lBGMlXQ2KyDpr/H2YkfNDgS/1mW4mwwonrPkxqL4eVtpUygnCfKmI3QiHUgnbzQpDQ38pmTc0j9eXL4ovKRVmAEL5a2Bk8lRigQUgjLGucW7k+attOxlbRjo4rXVcQ1laxCR+91qsGSAdIvn5S8eupVLjRD4FmPe4rqC0lLmdMld3Lsa021BoJOe7LUU2FiTL28t4aO7zU7QsMI8Nr8gQ9bmZHZjtzCA/f37PTY7SvodaKvgRabPAn9g0j6Scx4gNGyBiyqVC5eff/wJQQ9LXFR/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KRjx+g4VaZJgPCvKN9oYsAUBAS9Mw74OmuKkGJwoXDU=;
 b=fXFON+iUhwwmQoJ1OErJC+5vRyuUq0NKPiSz5mJeHakXh34yTm2Wp9LMhbmLByVM4oojEd/f3qQB3JZskoKhTGUxI7i8aEJNWGXmkmMGjuQYhRhP4z4f1Y/agv3G/293jrX/RfPscf2O0Z1NpGraXLTuYykwQ3crUFexk/2w0dU=
Received: from BL1PR13CA0112.namprd13.prod.outlook.com (2603:10b6:208:2b9::27)
 by SA1PR12MB9492.namprd12.prod.outlook.com (2603:10b6:806:459::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.10; Wed, 15 Oct
 2025 01:09:25 +0000
Received: from BN1PEPF00005FFF.namprd05.prod.outlook.com
 (2603:10b6:208:2b9:cafe::7f) by BL1PR13CA0112.outlook.office365.com
 (2603:10b6:208:2b9::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.9 via Frontend Transport; Wed,
 15 Oct 2025 01:09:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00005FFF.mail.protection.outlook.com (10.167.243.231) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.7 via Frontend Transport; Wed, 15 Oct 2025 01:09:25 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 14 Oct
 2025 18:09:24 -0700
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Tue, 14 Oct 2025 18:09:23 -0700
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse.Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH v8 1/2] drm/amdgpu: Convert amdgpu userqueue management from
 IDR to XArray
Date: Wed, 15 Oct 2025 09:08:52 +0800
Message-ID: <20251015010922.1983385-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFF:EE_|SA1PR12MB9492:EE_
X-MS-Office365-Filtering-Correlation-Id: 94109898-5852-485e-dd3e-08de0b877b67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?elM5K29wMTJoRGg2cjlKRlhzbEtvVEp2a041VGZPcjJtNVlNbC81dmRHZkRH?=
 =?utf-8?B?T2szSHpFY0hWSUJQQkVlSGpJL2FwRzhJaVBBakZzNW92b2JrVWRvT1VwdVAy?=
 =?utf-8?B?a0ZYOE02VG5OK05uSmJrekxORk53WkR4L1RrNm40d2szN3JxT2NBRDhqZytD?=
 =?utf-8?B?cnlJMXYweGVXNTZCNlo2QkhtNlM5UllaeGtFd2VtQllGSlV0dUEvUUNWdEg0?=
 =?utf-8?B?U2RiSm1kNHFuZUV4TG03NThWMExqclBhS2pxemEzcW9iWHRjQXo1N0J6OHpJ?=
 =?utf-8?B?NEFCQ05iVE5OcE5QWEtVWEN3RG9scEppc1BNY1FBU0lxd2h6Yjd2dlV0ZFBJ?=
 =?utf-8?B?ZUpaeExFdUdnUXExS09mODBiVTRzNXZyM3FINElXWUZ6ZW8vN3B4RkY1ZSt1?=
 =?utf-8?B?NU96cFZFUndzYUZwUm9SNTNTQk01NTRXT3phRWZLQ21GSkxQNjg5eFowOFJT?=
 =?utf-8?B?SHJib01IRExaNWZPQ3hVamZGV2VOQ0E2di9GWWhGa3VZYkhTeEEzZldZZ2F5?=
 =?utf-8?B?ay9xQlFCVXZoRlBCZk9WSVpaRUJ5MEEyWllZNC96dVFMb2VWckRBcEV1eGNx?=
 =?utf-8?B?TTc5ZWdaVjlVTmNjRXAyL1JyN3FSZWdlSTRCWG9TNENJcXBNN0E1aEt3UFdS?=
 =?utf-8?B?QkxtNklpS1ZNcFhKUkt6VzZFVlpZUklkZ3NrZUtUdVUyN0w3RmJpUTVFMlBR?=
 =?utf-8?B?cXBBWUo3VUYzam84WDB4ejZFTEpjZ1luQVY3SmgzNzlIWjVXeVpwWkkzUGpn?=
 =?utf-8?B?L1RSSk9nUjFBME5ocWNyRWE0bWlja294OXplelc2RGRZcDlseEd3V0Rpb01G?=
 =?utf-8?B?TWd3TnFyZG01L1pKbm5OM0xrc2lBT01pWGVhbGtoNlBxYlNtbTJGZ2FMQWtK?=
 =?utf-8?B?bkFxd2FjcDM0SlpnS3A0YW1Dazg1dHhkbHdRNXJ2dGFrZUN1aFNzQjJUdnE2?=
 =?utf-8?B?dXh3WmNHOG5kMzN0ZlBIVXFjTnVZU1gwaGgwN1V0TUVTT1l5bFNLdGNVOGlj?=
 =?utf-8?B?NCt5RmJLUWFOL3dSMXVrLzJWMWoxa244WlMzNkd3ZnRucDMreUJEYTZPY2Jz?=
 =?utf-8?B?ejNPM3NPa2JybUlkRFFmQnZRWGpiVlVReXpmQUFWVEhqdHpjK2xuQWRJV0c0?=
 =?utf-8?B?NTJlc01QdEI4SGdFbFRaN29rNFFFcXNqYzZMT2k5RmdJbDBTUlNLdDJsMVht?=
 =?utf-8?B?TEtLOUJRZkpzVnBlOXk4RlZ0dEE4cUtoeTgxNElGZmZHN0MxY3pnNE1admhG?=
 =?utf-8?B?b0pEWmlhVnRIUExGU0EzRkZYQTA1akZpUWZqYWdtWXBUR05NM2NlYitqODdN?=
 =?utf-8?B?OGVUZUpENjJXcTQrSUlDc1p2cTdJL1lYK3NwdW1NSXg5RmFJMzJlVmVVTlY0?=
 =?utf-8?B?S1FWRTJWWTFSenYyeEsvTkl6eTJoWllFamJhZ0hJd3hPVk96TmgwSzBMQThm?=
 =?utf-8?B?UTFXZFlrOFczSEZSYkl2ME1Yd0NIQy9QZjQ0cm1MbVJqUGNsL1pUcG40cWVp?=
 =?utf-8?B?Z0JqT0dZR0ZFU0lBL095VUd5T21LSDRlcE5GV3E4bmppZGZQTFF4MGowQjNB?=
 =?utf-8?B?dnlTWVRKU1R4TUtiY2ZCaDdjb3FZNC9OOHBVUVZLQjAxY3lDV053SE53MVlU?=
 =?utf-8?B?YUM2a2dJSS9zU2huNTZvZ1lJSVhObTI2TlhpMXJDVzFHR1o1eU1qQVFJVWhR?=
 =?utf-8?B?a0JIYUUxT2NQcWpzSHFaL2M2Lzg2UFp3RWE5dDcvL1BkRkg4endpUmtsTUFC?=
 =?utf-8?B?dlY3VkZTa1I3WEpvTmtiRC8xdDRLNDhCVSs1M20yckFiNVdQQnRnUjZhTENK?=
 =?utf-8?B?TWZpckMvZVNpamVaU2RyeGRkUlhLUGVGQ3ZtUHNESDBjczRKV3cyNUl3bm1J?=
 =?utf-8?B?Wnlwaks2QzZsQ21IOVNXZE5wV1RMY2xmZC9odGVZb0EySGxjV0x5TGhhTHV3?=
 =?utf-8?B?TllBNHVBVy9mdERSK1JHSjBaOHFQNFpUT3Blc01idVRDTzlMcnU3Wk9aeDli?=
 =?utf-8?B?NnZ4OGtiVUVUQnI4UlhlbElOQUUyelQwVmljL3VJd05tMDlBN0w0VWkrMmQr?=
 =?utf-8?B?WHlQTXBkaVZKTW8reUNwZklBVk44Tit6RndxaFEyS3BTbU9GWHJ4SXZaNTAr?=
 =?utf-8?Q?bjws=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2025 01:09:25.1660 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 94109898-5852-485e-dd3e-08de0b877b67
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00005FFF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9492
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
v4: use xa_store_irq (Christian)
    hold the read side of the reset lock while creating/destroying queues and the manager data structure. (Chritian)

Suggested-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |   8 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |   3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |  16 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c     | 151 +++++++++---------
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h     |   8 +-
 .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   |   4 +-
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c    |  22 ++-
 7 files changed, 101 insertions(+), 111 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index d9bd1d71552e..3d71da46b471 100644
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
@@ -1307,8 +1313,6 @@ struct amdgpu_device {
 	 */
 	bool                            apu_prefer_gtt;
 
-	struct list_head		userq_mgr_list;
-	struct mutex                    userq_mutex;
 	bool                            userq_halt_for_enforce_isolation;
 	struct amdgpu_uid *uid_info;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 0d5585bc3b04..5d9fd2cabc58 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4533,7 +4533,6 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	mutex_init(&adev->gfx.userq_sch_mutex);
 	mutex_init(&adev->gfx.workload_profile_mutex);
 	mutex_init(&adev->vcn.workload_profile_mutex);
-	mutex_init(&adev->userq_mutex);
 
 	amdgpu_device_init_apu_flags(adev);
 
@@ -4561,7 +4560,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 
 	INIT_LIST_HEAD(&adev->pm.od_kobj_list);
 
-	INIT_LIST_HEAD(&adev->userq_mgr_list);
+	xa_init(&adev->userq_doorbell_xa);
 
 	INIT_DELAYED_WORK(&adev->delayed_init_work,
 			  amdgpu_device_delayed_init_work_handler);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index bebf2ebc4f34..e8909abcf9c0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2772,22 +2772,8 @@ static int amdgpu_runtime_idle_check_userq(struct device *dev)
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
index 153d64bc3dcd..1e3a1013eb71 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -30,6 +30,7 @@
 #include "amdgpu_vm.h"
 #include "amdgpu_userq.h"
 #include "amdgpu_userq_fence.h"
+#include "amdgpu_reset.h"
 
 u32 amdgpu_userq_get_supported_ip_mask(struct amdgpu_device *adev)
 {
@@ -277,19 +278,27 @@ amdgpu_userq_cleanup(struct amdgpu_userq_mgr *uq_mgr,
 	struct amdgpu_device *adev = uq_mgr->adev;
 	const struct amdgpu_userq_funcs *uq_funcs = adev->userq_funcs[queue->queue_type];
 
+	/* Wait for mode-1 reset to complete */
+	down_read(&adev->reset_domain->sem);
+
 	/* Drop the userq reference. */
 	amdgpu_userq_buffer_vas_list_cleanup(adev, queue);
 	uq_funcs->mqd_destroy(uq_mgr, queue);
 	amdgpu_userq_fence_driver_free(queue);
-	idr_remove(&uq_mgr->userq_idr, queue_id);
+	/* Use interrupt-safe locking since IRQ handlers may access these XArrays */
+	xa_erase_irq(&uq_mgr->userq_mgr_xa, (unsigned long)queue_id);
+	xa_erase_irq(&adev->userq_doorbell_xa, queue->doorbell_index);
+	queue->userq_mgr = NULL;
 	list_del(&queue->userq_va_list);
 	kfree(queue);
+
+	up_read(&adev->reset_domain->sem);
 }
 
 static struct amdgpu_usermode_queue *
 amdgpu_userq_find(struct amdgpu_userq_mgr *uq_mgr, int qid)
 {
-	return idr_find(&uq_mgr->userq_idr, qid);
+	return xa_load(&uq_mgr->userq_mgr_xa, qid);
 }
 
 void
@@ -550,8 +559,9 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
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
@@ -574,7 +584,6 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 	 *
 	 * This will also make sure we have a valid eviction fence ready to be used.
 	 */
-	mutex_lock(&adev->userq_mutex);
 	amdgpu_userq_ensure_ev_fence(&fpriv->userq_mgr, &fpriv->evf_mgr);
 
 	uq_funcs = adev->userq_funcs[args->in.ip_type];
@@ -637,15 +646,27 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 		goto unlock;
 	}
 
-	qid = idr_alloc(&uq_mgr->userq_idr, queue, 1, AMDGPU_MAX_USERQ_COUNT, GFP_KERNEL);
-	if (qid < 0) {
+	/* Wait for mode-1 reset to complete */
+	down_read(&adev->reset_domain->sem);
+	r =xa_err(xa_store_irq(&adev->userq_doorbell_xa, index, queue, GFP_KERNEL));
+	if (r) {
+		kfree(queue);
+		up_read(&adev->reset_domain->sem);
+		goto unlock;
+	}
+
+	r = xa_alloc(&uq_mgr->userq_mgr_xa, &qid, queue, XA_LIMIT(1, AMDGPU_MAX_USERQ_COUNT), GFP_KERNEL);
+	if (r) {
 		drm_file_err(uq_mgr->file, "Failed to allocate a queue id\n");
 		amdgpu_userq_fence_driver_free(queue);
 		uq_funcs->mqd_destroy(uq_mgr, queue);
 		kfree(queue);
 		r = -ENOMEM;
+		up_read(&adev->reset_domain->sem);
 		goto unlock;
 	}
+	up_read(&adev->reset_domain->sem);
+	queue->userq_mgr = uq_mgr;
 
 	/* don't map the queue if scheduling is halted */
 	if (adev->userq_halt_for_enforce_isolation &&
@@ -658,7 +679,7 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 		r = amdgpu_userq_map_helper(uq_mgr, queue);
 		if (r) {
 			drm_file_err(uq_mgr->file, "Failed to map Queue\n");
-			idr_remove(&uq_mgr->userq_idr, qid);
+			xa_erase(&uq_mgr->userq_mgr_xa, qid);
 			amdgpu_userq_fence_driver_free(queue);
 			uq_funcs->mqd_destroy(uq_mgr, queue);
 			kfree(queue);
@@ -681,7 +702,6 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 
 unlock:
 	mutex_unlock(&uq_mgr->userq_mutex);
-	mutex_unlock(&adev->userq_mutex);
 
 	return r;
 }
@@ -779,11 +799,11 @@ static int
 amdgpu_userq_restore_all(struct amdgpu_userq_mgr *uq_mgr)
 {
 	struct amdgpu_usermode_queue *queue;
-	int queue_id;
+	unsigned long queue_id;
 	int ret = 0, r;
 
 	/* Resume all the queues for this process */
-	idr_for_each_entry(&uq_mgr->userq_idr, queue, queue_id) {
+	xa_for_each(&uq_mgr->userq_mgr_xa, queue_id, queue) {
 
 		if (!amdgpu_userq_buffer_vas_mapped(queue)) {
 			drm_file_err(uq_mgr->file,
@@ -942,11 +962,11 @@ static int
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
@@ -961,9 +981,10 @@ static int
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
@@ -1016,44 +1037,30 @@ int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct drm_file *f
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
 
@@ -1061,25 +1068,23 @@ int amdgpu_userq_suspend(struct amdgpu_device *adev)
 {
 	u32 ip_mask = amdgpu_userq_get_supported_ip_mask(adev);
 	struct amdgpu_usermode_queue *queue;
-	struct amdgpu_userq_mgr *uqm, *tmp;
-	int queue_id;
+	struct amdgpu_userq_mgr *uqm;
+	unsigned long queue_id;
 	int r;
 
 	if (!ip_mask)
 		return 0;
 
-	guard(mutex)(&adev->userq_mutex);
-	list_for_each_entry_safe(uqm, tmp, &adev->userq_mgr_list, list) {
+	xa_for_each(&adev->userq_doorbell_xa, queue_id, queue) {
+		uqm = queue->userq_mgr;
 		cancel_delayed_work_sync(&uqm->resume_work);
 		guard(mutex)(&uqm->userq_mutex);
-		idr_for_each_entry(&uqm->userq_idr, queue, queue_id) {
-			if (adev->in_s0ix)
-				r = amdgpu_userq_preempt_helper(uqm, queue);
-			else
-				r = amdgpu_userq_unmap_helper(uqm, queue);
-			if (r)
-				return r;
-		}
+		if (adev->in_s0ix)
+			r = amdgpu_userq_preempt_helper(uqm, queue);
+		else
+			r = amdgpu_userq_unmap_helper(uqm, queue);
+		if (r)
+			return r;
 	}
 	return 0;
 }
@@ -1088,24 +1093,22 @@ int amdgpu_userq_resume(struct amdgpu_device *adev)
 {
 	u32 ip_mask = amdgpu_userq_get_supported_ip_mask(adev);
 	struct amdgpu_usermode_queue *queue;
-	struct amdgpu_userq_mgr *uqm, *tmp;
-	int queue_id;
+	struct amdgpu_userq_mgr *uqm;
+	unsigned long queue_id;
 	int r;
 
 	if (!ip_mask)
 		return 0;
 
-	guard(mutex)(&adev->userq_mutex);
-	list_for_each_entry_safe(uqm, tmp, &adev->userq_mgr_list, list) {
+	xa_for_each(&adev->userq_doorbell_xa, queue_id, queue) {
+		uqm = queue->userq_mgr;
 		guard(mutex)(&uqm->userq_mutex);
-		idr_for_each_entry(&uqm->userq_idr, queue, queue_id) {
-			if (adev->in_s0ix)
-				r = amdgpu_userq_restore_helper(uqm, queue);
-			else
-				r = amdgpu_userq_map_helper(uqm, queue);
-			if (r)
-				return r;
-		}
+		if (adev->in_s0ix)
+			r = amdgpu_userq_restore_helper(uqm, queue);
+		else
+			r = amdgpu_userq_map_helper(uqm, queue);
+		if (r)
+			return r;
 	}
 
 	return 0;
@@ -1116,33 +1119,31 @@ int amdgpu_userq_stop_sched_for_enforce_isolation(struct amdgpu_device *adev,
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
 
@@ -1151,21 +1152,20 @@ int amdgpu_userq_start_sched_for_enforce_isolation(struct amdgpu_device *adev,
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
@@ -1173,10 +1173,9 @@ int amdgpu_userq_start_sched_for_enforce_isolation(struct amdgpu_device *adev,
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
index 036d8dd585cd..09da0617bfa2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -96,11 +96,15 @@ struct amdgpu_userq_funcs {
 
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
index 761bad98da3e..2aeeaa954882 100644
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
index 829129ad7bd1..b8486b0d0d69 100644
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

