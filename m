Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4157CF649C
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Sep 2024 12:00:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6BEE910E400;
	Mon, 30 Sep 2024 12:00:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gO4/F3yL";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2053.outbound.protection.outlook.com [40.107.92.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D2C2210E3FF
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 Sep 2024 12:00:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IPc7BOjgHjtHNerVV9Mie6BuRlpsxYljFy8GomrjiEbKv056oHFE3SXtLYKp4DQWlvv4Oa55ztRXTMgxArwMB+mheBPneOTTugYvCG809uHrEIeCmDVfSS2VLYqIOomuoHqlgamntIH674eOWeHjZ2nsvsIyCVRyd4g4dHIVF0Gt0pG+F6X77PEVQIuPBvq9VyKj6pmDK3VSZzU7D1MpJ7Sd4ig95iI5E1nkPXE06/4jHYTdzjV1s2Op15kZSQ5mGtoxzfFibrnfvdCND+xmY9iDaeF1USE5hGYuXfJpMSMJvV/kYOl1S+F6Y27W/nizfSpo4aqTdhrb8Y8WkuLaJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=brnrst+jbYgvT60QLVfbRlARWWHxJh/vu63D/441VqE=;
 b=TlpA1qxqapoeO9KDQr0HCX3CEeOsFZYirc5CV6ibIps4kAD91MhUEEPzsNfaHoohDExqNTU3a3xDSA1NuDlMW1jilOMObdJjv8Cd9EPhOGLkPL3XubfcYYfzMO4hjpOoZ9riIyUNh1rZ9yGPuXpomrNsYP8VYB4UvINXK0h9Gjvea6OyLsLh1vH3ybAs2hdb0cpqMBuXiG5EsxXbGDpULmxFBeyUSKJkeSnvcRuefE5Njo6XFkFwI4JTbD1l3fJPF4WzlDmOWbPTRWGAksteLZs9G/+Xv7mKMYjrWU5VOXSqYuwcKj2zh+NBJx7YKd5Y1ezz6stFg+jB/vILJ5qgDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=brnrst+jbYgvT60QLVfbRlARWWHxJh/vu63D/441VqE=;
 b=gO4/F3yLoMKv1wNCNw+v9DfsV6FRE/7oHNvCfhWX+3dN5gA6y/6nRaC2QaPwrvuVF7iVdnx5B69/bb6PXi+GSjSDd7zPNp+bbLWMwOAOY/AgiRSMjbJ7hG8YNgWUNCB5QNblyTcwHfwHsYDMq3o47cY5WHQZGAEOAsDsYc7iAZo=
Received: from SN7PR04CA0239.namprd04.prod.outlook.com (2603:10b6:806:127::34)
 by SJ0PR12MB5661.namprd12.prod.outlook.com (2603:10b6:a03:422::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.24; Mon, 30 Sep
 2024 12:00:18 +0000
Received: from SA2PEPF000015C9.namprd03.prod.outlook.com
 (2603:10b6:806:127:cafe::a3) by SN7PR04CA0239.outlook.office365.com
 (2603:10b6:806:127::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.27 via Frontend
 Transport; Mon, 30 Sep 2024 12:00:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015C9.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8026.11 via Frontend Transport; Mon, 30 Sep 2024 12:00:17 +0000
Received: from amd-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 30 Sep 2024 07:00:15 -0500
From: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <christian.koenig@amd.com>, <alexander.deucher@amd.com>, "Arunpravin
 Paneer Selvam" <Arunpravin.PaneerSelvam@amd.com>
Subject: [PATCH v3 01/09] drm/amdgpu: Implement userqueue signal/wait IOCTL
Date: Mon, 30 Sep 2024 17:28:58 +0530
Message-ID: <20240930115906.191060-1-Arunpravin.PaneerSelvam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C9:EE_|SJ0PR12MB5661:EE_
X-MS-Office365-Filtering-Correlation-Id: db0a7eef-26e9-445b-a42f-08dce14773b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RlR5Smx0Y05jM1NHU01EemMwblpjZFdtUSt4TmhhbWwwWHZ1K05YSE1HbTVS?=
 =?utf-8?B?Rmp0dzR3R3Y1ZmVRQnpBRUdheWtydXl3QndCbUtGazA0OGNUd1dVR1Q4cE0z?=
 =?utf-8?B?U1oyWDN6YnVnZjh1T1N6RzVnNTBPcUhTekc0VGlzMEFWL01tUXM4eWFEcmhM?=
 =?utf-8?B?aVdKejlMVlFTdlpaYzBJZElRRmtqTDRZWGZ2Slk3SkpDbW0yNEc2Y3FzejdC?=
 =?utf-8?B?akk1UlhIcjRsalR2aXFIcnJjTC81MDJEMEU1azVwSmZwaE1hV3k3V3k5YzZx?=
 =?utf-8?B?djVWMUdreld2YnpaZTloK2V3VzBqVEZzYkxCRityNk4rTDlJNFh4NDFOckRi?=
 =?utf-8?B?SU9iMlZSUWZEZ251OWsxSjhuM29MMzlPa2RKMVUrQWV4WlUzRzk0cE5ZdzJv?=
 =?utf-8?B?MmsvR0dIN0lCTjU2V1kvcVVDUzRTNGNza0ZDc0RSNzA5TmNReDZmV1VCZGtQ?=
 =?utf-8?B?Q0pUU04wb1N6Q21qemNBT0FRSTlhUnpVN3J6cEtRN01VZkFiaFJHSmtZSzlB?=
 =?utf-8?B?cndZZFg5c0R3bm9YL1VFR0VFbkdWQU5LL1JPOXpMeXN0K3BhT3NOMWRvWjlr?=
 =?utf-8?B?VnhvckR5ckNtZTZjUk5pS0ZURElpNm5OWXAzMytkT3RwSVVVWkRZSkdFenFG?=
 =?utf-8?B?VHdoOG5KTXRXRU1nUi9wOXA2OTRNK043Q0RnOU8xOEZPUVBZaUR0Wlk0OUVH?=
 =?utf-8?B?N05ONzNKMzFKUGgrUHJIRXRBSkFlUTJtSFpkcEUrMTViSDEvbjMycGswa0ho?=
 =?utf-8?B?NWYvM0pFMHRXdzluck4vRjRQTTRiZE1Ec1QyTjJYY1laK0l6eHFtMmdLVytY?=
 =?utf-8?B?MHBsc3dabFJHSnZoYnhuVTI5MUEyc2dtb1p0UjFwb1pyTmVwOGN3ZFI4WFJZ?=
 =?utf-8?B?bUhOYXhxeXduOC9QNFUvZEZxY3hneVJQU1dqZ1VEdGV4ZEY3aVNQcWpIZEo1?=
 =?utf-8?B?ZFpMTTc5SVNXa1NvOFFUaGZKNVgxblQvcmpEK1RJc0RsRjVRTGtXcXExNzYr?=
 =?utf-8?B?cnpjblYyMGtmUFhiczZaaXlzOXZOTDFnTHRDdjNmWWRNVkdMbkpSTEVYd2xa?=
 =?utf-8?B?MW91RXhidmp6K0R6UTIyamdXc0FmWXRzV1RabHp5UkkwMkU0MWFnZFhMRzA1?=
 =?utf-8?B?N0dCTjl1TDFRcE84Mi9HMm1mRUZNMjIvK1JDNkl0RlAzWmlHSjVVdEdJN3VC?=
 =?utf-8?B?dGExV2Ewd3BpcE1xMkdGbTZ6d3Q3MXpsWXp3NldKSnhWVVVPcVJSVS82WmdS?=
 =?utf-8?B?UXRlQVJzcE9jRWFOS1ROVXZtRXIvZ3gyazI2cWVoL2RxeXZtdXU1TlhCVFJu?=
 =?utf-8?B?cTJvclhmTG9FU29icEtpRm5MNmYra2RqczZ6OGtDZVh2L3ZoekxQWjRRYzhh?=
 =?utf-8?B?clNOblhRUWhXZnZaWHB4L1BIVHk0cVB0V0Q3ZHo4M25TdDFDMExCNHFoSWxj?=
 =?utf-8?B?TG9vNzNRazBVYVExRHBXOHZzUEh1czNUeGJ4Q1RnRUx4UVNFbkRkNFF0Wmho?=
 =?utf-8?B?RVRjQzJJNFNJVjEzU28yZklpWWMzMTJEemdNQlljZU5QSjFWck83eHBQdmNu?=
 =?utf-8?B?RnIxSW9wMXZ3R2hFTG04TjdpK2dFM3dGOEhWdFFTN3VOcUV3dXVONTdVNFBa?=
 =?utf-8?B?YjB5Zzh6SzJvb056UzFrU3h5NG1XNEVOajl4VE9vVjgvZHhsR3Y4NUw1SnZV?=
 =?utf-8?B?cUtFWHVOMEJxQWkxcnJ4MFlGMzVjUU5EcjlScTdSS202NjlZM1JEVHFSS3VB?=
 =?utf-8?B?LzhEVUtjTDdmM1A4bEFmbjF4TzFmdEVJV1AyUFNnTTUyODNHMi8yQlhkYnZS?=
 =?utf-8?B?Mld6aTcrK21NMDBWSi9ITWRhcFJoNFE1N0pOMHZvYTdYV2VtNnRkWkRPL0ly?=
 =?utf-8?Q?SB5hiKnpzPHS4?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2024 12:00:17.8910 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: db0a7eef-26e9-445b-a42f-08dce14773b3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015C9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5661
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

This patch introduces new IOCTL for userqueue secure semaphore.

The signal IOCTL called from userspace application creates a drm
syncobj and array of bo GEM handles and passed in as parameter to
the driver to install the fence into it.

The wait IOCTL gets an array of drm syncobjs, finds the fences
attached to the drm syncobjs and obtain the array of
memory_address/fence_value combintion which are returned to
userspace.

v2: (Christian)
    - Install fence into GEM BO object.
    - Lock all BO's using the dma resv subsystem
    - Reorder the sequence in signal IOCTL function.
    - Get write pointer from the shadow wptr
    - use userq_fence to fetch the va/value in wait IOCTL.

v3: (Christian)
    - Use drm_exec helper for the proper BO drm reserve and avoid BO
      lock/unlock issues.
    - fence/fence driver reference count logic for signal/wait IOCTLs.

v4: (Christian)
    - Fixed the drm_exec calling sequence
    - use dma_resv_for_each_fence_unlock if BO's are not locked
    - Modified the fence_info array storing logic.

v5: (Christian)
    - Keep fence_drv until wait queue execution.
    - Add dma_fence_wait for other fences.
    - Lock BO's using drm_exec as the number of fences in them could
      change.
    - Install signaled fences as well into BO/Syncobj.
    - Move Syncobj fence installation code after the drm_exec_prepare_array.
    - Directly add dma_resv_usage_rw(args->bo_flags....
    - remove unnecessary dma_fence_put.

v6: (Christian)
    - Add xarray stuff to store the fence_drv
    - Implement a function to iterate over the xarray and drop
      the fence_drv references.
    - Add drm_exec_until_all_locked() wrapper
    - Add a check that if we haven't exceeded the user allocated num_fences
      before adding dma_fence to the fences array.

v7: (Christian)
    - Use memdup_user() for kmalloc_array + copy_from_user
    - Move the fence_drv references from the xarray into the newly created fence
      and drop the fence_drv references when we signal this fence.
    - Move this locking of BOs before the "if (!wait_info->num_fences)",
      this way you need this code block only once.
    - Merge the error handling code and the cleanup + return 0 code.
    - Initializing the xa should probably be done in the userq code.
    - Remove the userq back pointer stored in fence_drv.
    - Pass xarray as parameter in amdgpu_userq_walk_and_drop_fence_drv()

v8: (Christian)
    - Move fence_drv references must come before adding the fence to the list.
    - Use xa_lock_irqsave_nested for nested spinlock operations.
    - userq_mgr should be per fpriv and not one per device.
    - Restructure the interrupt process code for the early exit of the loop.
    - The reference acquired in the syncobj fence replace code needs to be
      kept around.
    - Modify the dma_fence acquire placement in wait IOCTL.
    - Move USERQ_BO_WRITE flag to UAPI header file.
    - drop the fence drv reference after telling the hw to stop accessing it.
    - Add multi sync object support to userq signal IOCTL.

V9: (Christian)
    - Store all the fence_drv ref to other drivers and not ourself.
    - Remove the userq fence xa implementation and replace with
      kvmalloc_array.

v10: (Christian)
     - Add a comment for the userq_xa xarray
     - drop the if check of userq_fence->fence_drv_array
     - use the i variable to initialize userq_fence->fence_drv_array_count
     - drop the fence reference before you free the array in the error handling,
       otherwise it could be that some references leaked.

Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
Suggested-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |   6 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |   2 +
 .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   | 446 +++++++++++++++++-
 .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.h   |   7 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c |  29 +-
 .../gpu/drm/amd/include/amdgpu_userqueue.h    |   1 +
 6 files changed, 483 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index a31f6c92a755..6178a1cda223 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1043,6 +1043,12 @@ struct amdgpu_device {
 	struct amdgpu_mqd               mqds[AMDGPU_HW_IP_NUM];
 	const struct amdgpu_userq_funcs *userq_funcs[AMDGPU_HW_IP_NUM];
 
+	/* xarray used to retrieve the user queue fence driver reference
+	 * in the EOP interrupt handler to signal the particular user
+	 * queue fence.
+	 */
+	struct xarray			userq_xa;
+
 	/* df */
 	struct amdgpu_df                df;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 6e51b27b833d..70cb3b794a8a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2878,6 +2878,8 @@ const struct drm_ioctl_desc amdgpu_ioctls_kms[] = {
 	DRM_IOCTL_DEF_DRV(AMDGPU_GEM_OP, amdgpu_gem_op_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
 	DRM_IOCTL_DEF_DRV(AMDGPU_GEM_USERPTR, amdgpu_gem_userptr_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
 	DRM_IOCTL_DEF_DRV(AMDGPU_USERQ, amdgpu_userq_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
+	DRM_IOCTL_DEF_DRV(AMDGPU_USERQ_SIGNAL, amdgpu_userq_signal_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
+	DRM_IOCTL_DEF_DRV(AMDGPU_USERQ_WAIT, amdgpu_userq_wait_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
 };
 
 static const struct drm_driver amdgpu_kms_driver = {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
index f7baea2c67ab..95f232ad4a3d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
@@ -25,6 +25,7 @@
 #include <linux/kref.h>
 #include <linux/slab.h>
 
+#include <drm/drm_exec.h>
 #include <drm/drm_syncobj.h>
 
 #include "amdgpu.h"
@@ -92,6 +93,7 @@ int amdgpu_userq_fence_driver_alloc(struct amdgpu_device *adev,
 	spin_lock_init(&fence_drv->fence_list_lock);
 
 	fence_drv->adev = adev;
+	fence_drv->uq_fence_drv_xa_ref = &userq->uq_fence_drv_xa;
 	fence_drv->context = dma_fence_context_alloc(1);
 	get_task_comm(fence_drv->timeline_name, current);
 
@@ -105,6 +107,7 @@ void amdgpu_userq_fence_driver_process(struct amdgpu_userq_fence_driver *fence_d
 	struct amdgpu_userq_fence *userq_fence, *tmp;
 	struct dma_fence *fence;
 	u64 rptr;
+	int i;
 
 	if (!fence_drv)
 		return;
@@ -115,14 +118,16 @@ void amdgpu_userq_fence_driver_process(struct amdgpu_userq_fence_driver *fence_d
 	list_for_each_entry_safe(userq_fence, tmp, &fence_drv->fences, link) {
 		fence = &userq_fence->base;
 
-		if (rptr >= fence->seqno) {
-			dma_fence_signal(fence);
-			list_del(&userq_fence->link);
-
-			dma_fence_put(fence);
-		} else {
+		if (rptr < fence->seqno)
 			break;
-		}
+
+		dma_fence_signal(fence);
+
+		for (i = 0; i < userq_fence->fence_drv_array_count; i++)
+			amdgpu_userq_fence_driver_put(userq_fence->fence_drv_array[i]);
+
+		list_del(&userq_fence->link);
+		dma_fence_put(fence);
 	}
 	spin_unlock(&fence_drv->fence_list_lock);
 }
@@ -132,8 +137,11 @@ void amdgpu_userq_fence_driver_destroy(struct kref *ref)
 	struct amdgpu_userq_fence_driver *fence_drv = container_of(ref,
 					 struct amdgpu_userq_fence_driver,
 					 refcount);
+	struct amdgpu_userq_fence_driver *xa_fence_drv;
 	struct amdgpu_device *adev = fence_drv->adev;
 	struct amdgpu_userq_fence *fence, *tmp;
+	struct xarray *xa = &adev->userq_xa;
+	unsigned long index;
 	struct dma_fence *f;
 
 	spin_lock(&fence_drv->fence_list_lock);
@@ -150,6 +158,12 @@ void amdgpu_userq_fence_driver_destroy(struct kref *ref)
 	}
 	spin_unlock(&fence_drv->fence_list_lock);
 
+	xa_lock(xa);
+	xa_for_each(xa, index, xa_fence_drv)
+		if (xa_fence_drv == fence_drv)
+			__xa_erase(xa, index);
+	xa_unlock(xa);
+
 	/* Free seq64 memory */
 	amdgpu_seq64_free(adev, fence_drv->gpu_addr);
 	kfree(fence_drv);
@@ -191,6 +205,33 @@ int amdgpu_userq_fence_create(struct amdgpu_usermode_queue *userq,
 	amdgpu_userq_fence_driver_get(fence_drv);
 	dma_fence_get(fence);
 
+	if (!xa_empty(&userq->uq_fence_drv_xa)) {
+		struct amdgpu_userq_fence_driver *stored_fence_drv;
+		unsigned long index, count = 0;
+		int i = 0;
+
+		xa_for_each(&userq->uq_fence_drv_xa, index, stored_fence_drv)
+			count++;
+
+		userq_fence->fence_drv_array =
+			kvmalloc_array(count,
+				       sizeof(struct amdgpu_userq_fence_driver *),
+				       GFP_KERNEL);
+
+		if (userq_fence->fence_drv_array) {
+			xa_for_each(&userq->uq_fence_drv_xa, index, stored_fence_drv) {
+				userq_fence->fence_drv_array[i] = stored_fence_drv;
+				xa_erase(&userq->uq_fence_drv_xa, index);
+				i++;
+			}
+		}
+
+		userq_fence->fence_drv_array_count = i;
+	} else {
+		userq_fence->fence_drv_array = NULL;
+		userq_fence->fence_drv_array_count = 0;
+	}
+
 	spin_lock(&fence_drv->fence_list_lock);
 	/* Check if hardware has already processed the job */
 	if (!dma_fence_is_signaled(fence))
@@ -240,6 +281,8 @@ static void amdgpu_userq_fence_free(struct rcu_head *rcu)
 
 	/* Release the fence driver reference */
 	amdgpu_userq_fence_driver_put(fence_drv);
+
+	kvfree(userq_fence->fence_drv_array);
 	kmem_cache_free(amdgpu_userq_fence_slab, userq_fence);
 }
 
@@ -255,3 +298,392 @@ static const struct dma_fence_ops amdgpu_userq_fence_ops = {
 	.signaled = amdgpu_userq_fence_signaled,
 	.release = amdgpu_userq_fence_release,
 };
+
+/**
+ * amdgpu_userq_fence_read_wptr - Read the userq wptr value
+ *
+ * @filp: drm file private data structure
+ * @queue: user mode queue structure pointer
+ * @wptr: write pointer value
+ *
+ * Read the wptr value from userq's MQD. The userq signal IOCTL
+ * creates a dma_fence for the shared buffers that expects the
+ * RPTR value written to seq64 memory >= WPTR.
+ *
+ * Returns wptr value on success, error on failure.
+ */
+static int amdgpu_userq_fence_read_wptr(struct drm_file *filp,
+					struct amdgpu_usermode_queue *queue,
+					u64 *wptr)
+{
+	struct amdgpu_fpriv *fpriv = filp->driver_priv;
+	struct amdgpu_bo_va_mapping *mapping;
+	struct amdgpu_vm *vm = &fpriv->vm;
+	struct amdgpu_bo *bo;
+	u64 addr, *ptr;
+	int r;
+
+	addr = queue->userq_prop->wptr_gpu_addr;
+	addr &= AMDGPU_GMC_HOLE_MASK;
+
+	mapping = amdgpu_vm_bo_lookup_mapping(vm, addr >> PAGE_SHIFT);
+	if (!mapping)
+		return -EINVAL;
+
+	bo = mapping->bo_va->base.bo;
+	r = amdgpu_bo_reserve(bo, true);
+	if (r) {
+		DRM_ERROR("Failed to reserve userqueue wptr bo");
+		return r;
+	}
+
+	r = amdgpu_bo_kmap(bo, (void **)&ptr);
+	if (r) {
+		DRM_ERROR("Failed mapping the userqueue wptr bo");
+		goto map_error;
+	}
+
+	*wptr = le64_to_cpu(*ptr);
+
+	amdgpu_bo_kunmap(bo);
+	amdgpu_bo_unreserve(bo);
+
+	return 0;
+
+map_error:
+	amdgpu_bo_unreserve(bo);
+	return r;
+}
+
+int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
+			      struct drm_file *filp)
+{
+	struct amdgpu_fpriv *fpriv = filp->driver_priv;
+	struct amdgpu_userq_mgr *userq_mgr = &fpriv->userq_mgr;
+	struct drm_amdgpu_userq_signal *args = data;
+	struct amdgpu_usermode_queue *queue;
+	struct drm_gem_object **gobj = NULL;
+	struct drm_syncobj **syncobj = NULL;
+	u32 *syncobj_handles, num_syncobj_handles;
+	u32 *bo_handles, num_bo_handles;
+	int r, i, entry, boentry;
+	struct dma_fence *fence;
+	struct drm_exec exec;
+	u64 wptr;
+
+	/* Array of syncobj handles */
+	num_syncobj_handles = args->num_syncobj_handles;
+	syncobj_handles = memdup_user(u64_to_user_ptr(args->syncobj_handles_array),
+				      sizeof(u32) * num_syncobj_handles);
+	if (IS_ERR(syncobj_handles))
+		return PTR_ERR(syncobj_handles);
+
+	/* Array of pointers to the looked up syncobjs */
+	syncobj = kmalloc_array(num_syncobj_handles, sizeof(*syncobj), GFP_KERNEL);
+	if (!syncobj) {
+		r = -ENOMEM;
+		goto free_syncobj_handles;
+	}
+
+	for (entry = 0; entry < num_syncobj_handles; entry++) {
+		syncobj[entry] = drm_syncobj_find(filp, syncobj_handles[entry]);
+		if (!syncobj[entry]) {
+			r = -ENOENT;
+			goto free_syncobj;
+		}
+	}
+
+	/* Array of bo handles */
+	num_bo_handles = args->num_bo_handles;
+	bo_handles = memdup_user(u64_to_user_ptr(args->bo_handles_array),
+				 sizeof(u32) * num_bo_handles);
+	if (IS_ERR(bo_handles))
+		goto free_syncobj;
+
+	/* Array of pointers to the GEM objects */
+	gobj = kmalloc_array(num_bo_handles, sizeof(*gobj), GFP_KERNEL);
+	if (!gobj) {
+		r = -ENOMEM;
+		goto free_bo_handles;
+	}
+
+	for (boentry = 0; boentry < num_bo_handles; boentry++) {
+		gobj[boentry] = drm_gem_object_lookup(filp, bo_handles[boentry]);
+		if (!gobj[boentry]) {
+			r = -ENOENT;
+			goto put_gobj;
+		}
+	}
+
+	drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT, 0);
+	drm_exec_until_all_locked(&exec) {
+		r = drm_exec_prepare_array(&exec, gobj, num_bo_handles, 1);
+		drm_exec_retry_on_contention(&exec);
+		if (r)
+			goto exec_fini;
+	}
+
+	/*Retrieve the user queue */
+	queue = idr_find(&userq_mgr->userq_idr, args->queue_id);
+	if (!queue) {
+		r = -ENOENT;
+		goto exec_fini;
+	}
+
+	r = amdgpu_userq_fence_read_wptr(filp, queue, &wptr);
+	if (r)
+		goto exec_fini;
+
+	/* Create a new fence */
+	r = amdgpu_userq_fence_create(queue, wptr, &fence);
+	if (r)
+		goto exec_fini;
+
+	for (i = 0; i < num_bo_handles; i++)
+		dma_resv_add_fence(gobj[i]->resv, fence,
+				   dma_resv_usage_rw(args->bo_flags &
+				   AMDGPU_USERQ_BO_WRITE));
+
+	/* Add the created fence to syncobj/BO's */
+	for (i = 0; i < num_syncobj_handles; i++)
+		drm_syncobj_replace_fence(syncobj[i], fence);
+
+	/* drop the reference acquired in fence creation function */
+	dma_fence_put(fence);
+
+exec_fini:
+	drm_exec_fini(&exec);
+put_gobj:
+	while (boentry-- > 0)
+		drm_gem_object_put(gobj[boentry]);
+	kfree(gobj);
+free_bo_handles:
+	kfree(bo_handles);
+free_syncobj:
+	while (entry-- > 0)
+		if (syncobj[entry])
+			drm_syncobj_put(syncobj[entry]);
+	kfree(syncobj);
+free_syncobj_handles:
+	kfree(syncobj_handles);
+
+	return r;
+}
+
+int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
+			    struct drm_file *filp)
+{
+	struct drm_amdgpu_userq_fence_info *fence_info = NULL;
+	struct drm_amdgpu_userq_wait *wait_info = data;
+	u32 *syncobj_handles, *bo_handles;
+	struct dma_fence **fences = NULL;
+	u32 num_syncobj, num_bo_handles;
+	struct drm_gem_object **gobj;
+	struct drm_exec exec;
+	int r, i, entry, cnt;
+	u64 num_fences = 0;
+
+	num_bo_handles = wait_info->num_bo_handles;
+	bo_handles = memdup_user(u64_to_user_ptr(wait_info->bo_handles_array),
+				 sizeof(u32) * num_bo_handles);
+	if (IS_ERR(bo_handles))
+		return PTR_ERR(bo_handles);
+
+	num_syncobj = wait_info->num_syncobj_handles;
+	syncobj_handles = memdup_user(u64_to_user_ptr(wait_info->syncobj_handles_array),
+				      sizeof(u32) * num_syncobj);
+	if (IS_ERR(syncobj_handles)) {
+		r = PTR_ERR(syncobj_handles);
+		goto free_bo_handles;
+	}
+
+	/* Array of GEM object handles */
+	gobj = kmalloc_array(num_bo_handles, sizeof(*gobj), GFP_KERNEL);
+	if (!gobj) {
+		r = -ENOMEM;
+		goto free_syncobj_handles;
+	}
+
+	for (entry = 0; entry < num_bo_handles; entry++) {
+		gobj[entry] = drm_gem_object_lookup(filp, bo_handles[entry]);
+		if (!gobj[entry]) {
+			r = -ENOENT;
+			goto put_gobj;
+		}
+	}
+
+	drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT, 0);
+	drm_exec_until_all_locked(&exec) {
+		r = drm_exec_prepare_array(&exec, gobj, num_bo_handles, 0);
+		drm_exec_retry_on_contention(&exec);
+		if (r) {
+			drm_exec_fini(&exec);
+			goto put_gobj;
+		}
+	}
+
+	if (!wait_info->num_fences) {
+		/* Count syncobj's fence */
+		for (i = 0; i < num_syncobj; i++) {
+			struct dma_fence *fence;
+
+			r = drm_syncobj_find_fence(filp, syncobj_handles[i],
+						   0, 0, &fence);
+			if (r)
+				goto exec_fini;
+
+			num_fences++;
+			dma_fence_put(fence);
+		}
+
+		/* Count GEM objects fence */
+		for (i = 0; i < num_bo_handles; i++) {
+			struct dma_resv_iter resv_cursor;
+			struct dma_fence *fence;
+
+			dma_resv_for_each_fence(&resv_cursor, gobj[i]->resv,
+						dma_resv_usage_rw(wait_info->bo_wait_flags &
+						AMDGPU_USERQ_BO_WRITE), fence)
+				num_fences++;
+		}
+
+		/*
+		 * Passing num_fences = 0 means that userspace doesn't want to
+		 * retrieve userq_fence_info. If num_fences = 0 we skip filling
+		 * userq_fence_info and return the actual number of fences on
+		 * args->num_fences.
+		 */
+		wait_info->num_fences = num_fences;
+	} else {
+		/* Array of fence info */
+		fence_info = kmalloc_array(wait_info->num_fences, sizeof(*fence_info), GFP_KERNEL);
+		if (!fence_info) {
+			r = -ENOMEM;
+			goto exec_fini;
+		}
+
+		/* Array of fences */
+		fences = kmalloc_array(wait_info->num_fences, sizeof(*fences), GFP_KERNEL);
+		if (!fences) {
+			r = -ENOMEM;
+			goto free_fence_info;
+		}
+
+		/* Retrieve GEM objects fence */
+		for (i = 0; i < num_bo_handles; i++) {
+			struct dma_resv_iter resv_cursor;
+			struct dma_fence *fence;
+
+			dma_resv_for_each_fence(&resv_cursor, gobj[i]->resv,
+						dma_resv_usage_rw(wait_info->bo_wait_flags &
+						AMDGPU_USERQ_BO_WRITE), fence) {
+				if (WARN_ON_ONCE(num_fences >= wait_info->num_fences)) {
+					r = -EINVAL;
+					goto free_fences;
+				}
+
+				fences[num_fences++] = fence;
+				dma_fence_get(fence);
+			}
+		}
+
+		/* Retrieve syncobj's fence */
+		for (i = 0; i < num_syncobj; i++) {
+			struct dma_fence *fence;
+
+			r = drm_syncobj_find_fence(filp, syncobj_handles[i],
+						   0, 0, &fence);
+			if (r)
+				goto free_fences;
+
+			if (WARN_ON_ONCE(num_fences >= wait_info->num_fences)) {
+				r = -EINVAL;
+				goto free_fences;
+			}
+
+			fences[num_fences++] = fence;
+		}
+
+		for (i = 0, cnt = 0; i < wait_info->num_fences; i++) {
+			struct amdgpu_userq_fence_driver *fence_drv;
+			struct amdgpu_userq_fence *userq_fence;
+			u32 index;
+
+			userq_fence = to_amdgpu_userq_fence(fences[i]);
+			if (!userq_fence) {
+				/*
+				 * Just waiting on other driver fences should
+				 * be good for now
+				 */
+				dma_fence_wait(fences[i], false);
+				dma_fence_put(fences[i]);
+
+				continue;
+			}
+
+			fence_drv = userq_fence->fence_drv;
+			/*
+			 * We need to make sure the user queue release their reference
+			 * to the fence drivers at some point before queue destruction.
+			 * Otherwise, we would gather those references until we don't
+			 * have any more space left and crash.
+			 */
+			if (fence_drv->uq_fence_drv_xa_ref) {
+				r = xa_alloc(fence_drv->uq_fence_drv_xa_ref, &index, fence_drv,
+					     xa_limit_32b, GFP_KERNEL);
+				if (r)
+					goto free_fences;
+
+				amdgpu_userq_fence_driver_get(fence_drv);
+			}
+
+			/* Store drm syncobj's gpu va address and value */
+			fence_info[cnt].va = fence_drv->gpu_addr;
+			fence_info[cnt].value = fences[i]->seqno;
+
+			dma_fence_put(fences[i]);
+			/* Increment the actual userq fence count */
+			cnt++;
+		}
+
+		wait_info->num_fences = cnt;
+		/* Copy userq fence info to user space */
+		if (copy_to_user(u64_to_user_ptr(wait_info->userq_fence_info),
+				 fence_info, wait_info->num_fences * sizeof(*fence_info))) {
+			r = -EFAULT;
+			goto free_fences;
+		}
+
+		kfree(fences);
+		kfree(fence_info);
+	}
+
+	drm_exec_fini(&exec);
+	for (i = 0; i < num_bo_handles; i++)
+		drm_gem_object_put(gobj[i]);
+	kfree(gobj);
+
+	kfree(syncobj_handles);
+	kfree(bo_handles);
+
+	return 0;
+
+free_fences:
+	while (num_fences-- > 0)
+		dma_fence_put(fences[num_fences]);
+	kfree(fences);
+free_fence_info:
+	kfree(fence_info);
+exec_fini:
+	drm_exec_fini(&exec);
+put_gobj:
+	while (entry-- > 0)
+		drm_gem_object_put(gobj[entry]);
+	kfree(gobj);
+free_syncobj_handles:
+	kfree(syncobj_handles);
+free_bo_handles:
+	kfree(bo_handles);
+
+	return r;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h
index c3e04cdbb9e7..f72424248cc5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h
@@ -37,7 +37,9 @@ struct amdgpu_userq_fence {
 	 */
 	spinlock_t lock;
 	struct list_head link;
+	unsigned long fence_drv_array_count;
 	struct amdgpu_userq_fence_driver *fence_drv;
+	struct amdgpu_userq_fence_driver **fence_drv_array;
 };
 
 struct amdgpu_userq_fence_driver {
@@ -52,6 +54,7 @@ struct amdgpu_userq_fence_driver {
 	spinlock_t fence_list_lock;
 	struct list_head fences;
 	struct amdgpu_device *adev;
+	struct xarray *uq_fence_drv_xa_ref;
 	char timeline_name[TASK_COMM_LEN];
 };
 
@@ -65,5 +68,9 @@ int amdgpu_userq_fence_driver_alloc(struct amdgpu_device *adev,
 				    struct amdgpu_usermode_queue *userq);
 void amdgpu_userq_fence_driver_process(struct amdgpu_userq_fence_driver *fence_drv);
 void amdgpu_userq_fence_driver_destroy(struct kref *ref);
+int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
+			      struct drm_file *filp);
+int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
+			    struct drm_file *filp);
 
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
index 7f6495466975..ba986d55ceeb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
@@ -27,6 +27,32 @@
 #include "amdgpu_userqueue.h"
 #include "amdgpu_userq_fence.h"
 
+static void amdgpu_userq_walk_and_drop_fence_drv(struct xarray *xa)
+{
+	struct amdgpu_userq_fence_driver *fence_drv;
+	unsigned long index;
+
+	if (xa_empty(xa))
+		return;
+
+	xa_lock(xa);
+	xa_for_each(xa, index, fence_drv) {
+		__xa_erase(xa, index);
+		amdgpu_userq_fence_driver_put(fence_drv);
+	}
+
+	xa_unlock(xa);
+}
+
+static void
+amdgpu_userq_fence_driver_free(struct amdgpu_usermode_queue *userq)
+{
+	amdgpu_userq_walk_and_drop_fence_drv(&userq->uq_fence_drv_xa);
+	xa_destroy(&userq->uq_fence_drv_xa);
+	/* Drop the fence_drv reference held by user queue */
+	amdgpu_userq_fence_driver_put(userq->fence_drv);
+}
+
 static void
 amdgpu_userqueue_cleanup(struct amdgpu_userq_mgr *uq_mgr,
 			 struct amdgpu_usermode_queue *queue,
@@ -36,7 +62,7 @@ amdgpu_userqueue_cleanup(struct amdgpu_userq_mgr *uq_mgr,
 	const struct amdgpu_userq_funcs *uq_funcs = adev->userq_funcs[queue->queue_type];
 
 	uq_funcs->mqd_destroy(uq_mgr, queue);
-	amdgpu_userq_fence_driver_put(queue->fence_drv);
+	amdgpu_userq_fence_driver_free(queue);
 	idr_remove(&uq_mgr->userq_idr, queue_id);
 	kfree(queue);
 }
@@ -320,6 +346,7 @@ amdgpu_userqueue_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 	}
 	queue->doorbell_index = index;
 
+	xa_init_flags(&queue->uq_fence_drv_xa, XA_FLAGS_ALLOC);
 	r = amdgpu_userq_fence_driver_alloc(adev, queue);
 	if (r) {
 		DRM_ERROR("Failed to alloc fence driver\n");
diff --git a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
index 5fbffde48999..77a33f9e37f8 100644
--- a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
+++ b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
@@ -47,6 +47,7 @@ struct amdgpu_usermode_queue {
 	struct amdgpu_userq_obj	db_obj;
 	struct amdgpu_userq_obj fw_obj;
 	struct amdgpu_userq_obj wptr_obj;
+	struct xarray		uq_fence_drv_xa;
 	struct amdgpu_userq_fence_driver *fence_drv;
 };
 
-- 
2.34.1

