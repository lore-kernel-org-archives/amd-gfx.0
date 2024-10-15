Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2343CFC273
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Oct 2024 07:43:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4CA4210E523;
	Tue, 15 Oct 2024 07:43:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UdQT7lyJ";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2050.outbound.protection.outlook.com [40.107.243.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9DDFD10E51C
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Oct 2024 07:43:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iHJnZKN2aIItmGpphe1sbUaxVEWw92ok+0kL2v1pD4/wAczdIuRya5s2JsvPdXbS1Oh50CZUdrnHE5vfIFXDPEbcdFFVJdajYwrpbjcBIGNZmPrmfwJUBrNLwDEmsRtDiFeY8scx9otzDhRoRl8rw9KrwLBgBXdDmi78gMJFKBdRddAzDgYFU+PPRxxGHmGEMqaY1vb00LBlLY/V30l16n8x/M1GVee3NNoUEG35mUq2IpNGTQ3uBxs+wtgQEmE8Sc0NMPAtAjVk8nCxXXVpNCt5jB+w4PqMB2tBiGwNNTfRHg47jjZKKfuj4J20Egc9wLDhxh19UxlUSvoREfLu7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SOZjij49aUEUHxH1SfI7xvFKPOC1Du+kQDVhFS11o34=;
 b=sHjnKisOywx99YaGEbI3DBSy64rGc514xZP1nhThe3L9wRU4bJMNVsuu14WIeJVB71v1pv0cKx652PyQvBeV5EodcuqFa0C0Nh3dSUkwspb/yanA6avXDtWLKf4DqAJXoNLdBGQd6qFw51bQ9UXFlnl4TNEpWRSlyD5yYxlKtCuJhX9YmynjEn+i88ZojvOxVm1IjGhjDwwODLtMyny/AdGecCAA+7g2F3xmC3MzQ2qntTLaT5fdphPSsa4//Cd+xn/AibmupdIO88WLF8RGUp5tOfR4JXnYFxAW814FCHeLJ2iNTSyfEVYpz6yyourSjy0gAnVbSDpWf74/BBGTnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SOZjij49aUEUHxH1SfI7xvFKPOC1Du+kQDVhFS11o34=;
 b=UdQT7lyJsTzYNAheIxvqIDwMrf0MPCLgecC3hGGuj0ak0GedJ61ppTbrm8SMgbIwmd9FkWoXy3Ik587i9T1mkYColpouDmgRA5kVxgfByTgEkza5w9x57MbejdlLaHmTCpxn/U8lPRL5Oployr20Ikpg1UCg7enJVLhd8Oe1P+Y=
Received: from BN9PR03CA0276.namprd03.prod.outlook.com (2603:10b6:408:f5::11)
 by SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Tue, 15 Oct
 2024 07:43:34 +0000
Received: from BL6PEPF00020E62.namprd04.prod.outlook.com
 (2603:10b6:408:f5:cafe::78) by BN9PR03CA0276.outlook.office365.com
 (2603:10b6:408:f5::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.29 via Frontend
 Transport; Tue, 15 Oct 2024 07:43:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00020E62.mail.protection.outlook.com (10.167.249.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8069.17 via Frontend Transport; Tue, 15 Oct 2024 07:43:33 +0000
Received: from amd-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 15 Oct 2024 02:43:31 -0500
From: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: <alexander.deucher@amd.com>, Arunpravin Paneer Selvam
 <Arunpravin.PaneerSelvam@amd.com>
Subject: [PATCH v4 01/09] drm/amdgpu: Implement userqueue signal/wait IOCTL
Date: Tue, 15 Oct 2024 13:13:01 +0530
Message-ID: <20241015074309.2484264-1-Arunpravin.PaneerSelvam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E62:EE_|SA0PR12MB7091:EE_
X-MS-Office365-Filtering-Correlation-Id: f25c40a7-74d3-4cea-aa43-08dceced1236
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RXI3bklodnloS0l0WlFLOFJNMitHK252dGYwKzJxOXEzQXFBSUpJdXdMcTBK?=
 =?utf-8?B?ckpYcGdUdDRvL1pUQm5uVDUvUGRQdS91VkMwUzYwdGFON3FJT3c1R1dvVVV4?=
 =?utf-8?B?dUI1WGRDUy9ZM08ybWtwell0VTh5MGNOQy83QXQyazNoZHpRekcyaWw0eVBE?=
 =?utf-8?B?Wno0OXlRSlNNdVUwUTcxZjc2bUwzTEhRVUtadThRVFFOVDgxNHZsSnZORERa?=
 =?utf-8?B?UE0va3NaeVZNVXZRS0xlMmVzQlUrVW1Hdjg1blQwVUo1b1FxdlJ4Sm5LZlZS?=
 =?utf-8?B?NDNnY21ZR0MzM0NTc2lVRFZvKzZBVll1S3VqNGt3Q3dSMVJLUURSR0taaG92?=
 =?utf-8?B?UWVPbi90Z0NPSTBYSGFoV0t6V1NXcVlXMldlNUxHWmZjY2dhTThUaXNYSEcz?=
 =?utf-8?B?RDhHOE14NDJkOGl2ZC9JOFNyaVI2aDdtUW84dmViV1I3bUk4cmNMZFJyOGVY?=
 =?utf-8?B?RTlxK1hqS0ljL09xY2tUYit3TXZvM3c0bVhqeGlQOEhzL1ZzQVdjQXdXZ0th?=
 =?utf-8?B?M0FsVFNxbUY1aFUwREVmTXVqN3ZFdWVkd1NLWS8xOHYrTjdlNlRZTGpoRVRF?=
 =?utf-8?B?UVBPUXVnSGRDQksrZHhCMzgxMkRkZjR0ekVyclMzbmVsZVFIS2x6T1hTcndx?=
 =?utf-8?B?ZTdRMVI3MktuNUt6aUlnbHQvMWl4WnROcGM4TXRTelFjM2M4UUVCczZ3UnFn?=
 =?utf-8?B?OWduakc2OURrT3RLMFVTT25Pa1JNUzJhUGNBd2dFT0QxbXFKSCtQa2F5RXEr?=
 =?utf-8?B?clM5UDJOQmVURWJmQUpqSGhkd2RnOEE2dVNYTkl6SlRNdThBa3dYbEdNY0Nq?=
 =?utf-8?B?cjJ5Rm1tTHRkQ0xxVVBvWHdxTWk5T2JuSkI1YTJoUncrbU04YWErYXNMNDFu?=
 =?utf-8?B?NlRldy8wSVU4QmVmWVJMQ1U1ckcwT21OU3FWV3JGcVA3anNnYzZOYnh2aUg4?=
 =?utf-8?B?anZGUmo2ZEx5Y2RQWDllWVVoRE54T2ovVDR0VkJwM2dwbUdjQXZ5azFYcEtU?=
 =?utf-8?B?VU96QlEzTTJNMlVGeU9xK214eUNUNnhZODdXOHRyUC9ROFRHK0VrMXU0bmNi?=
 =?utf-8?B?Rk1vb2VkVVJvUkZlK1A5U1BuaTJ2cDQrT2N3NUF4Z3pUN2pZOTBKakJ3K1lD?=
 =?utf-8?B?bmlKM2NQL2grRklOZU11TEwrdHEyVDF1SGFCVmkzNFc0ZDhMMi9YQnIzejM1?=
 =?utf-8?B?bG1FbWx6akNGamQvMGs4MWx2MVA3S0tGS05KVWFEZDUzUW9tSThiRm84enNj?=
 =?utf-8?B?RWl5OEt5azRHMVZaS2k4TUxqWnJRMkcyc1NUc0lwYnFaTWl6T3NPVGQyN0JM?=
 =?utf-8?B?bUt0VkRkUXMwSFgzaG8xcXh6RUtMSFVhbDh2V1p5bVYzc0V4bDdrQ3hBNlpJ?=
 =?utf-8?B?aTdud0Jac0JReGdXcDIxK0k4NHdNZThFSFcyWFNWa0daNDV1dlhZZkJxL1FP?=
 =?utf-8?B?d096dWo4QXhFajJnUjdjaHVJVGRoSjZNdmJiVDhJUk91VWlkRy9ya1dVeFp5?=
 =?utf-8?B?VnArakF4dWd0bHB2b1pZOVpub1g2UmdoNFNaRnc2Z05kWVhBellBY0lGZ29I?=
 =?utf-8?B?QU1JL256ODErcHFIaXFsWG1MbVdIa3UvbGN3b1Y1ZjF1Y200bzNDSFh3aDZn?=
 =?utf-8?B?WmthNmJreWlIbGwyZWtsL1lTeFFLNE9WdHgxZTdKZ3o5c1NvbVVna3NyZUFD?=
 =?utf-8?B?aFBSTzhxb2ppajFnaUszV0twQmROTXJPTnl5U2N2OFd1MnZaRHc5MUo5U0dN?=
 =?utf-8?B?M2NEU2hKTVYxNXEzUWVqaXF2ZHdTM1hyeGlsRGEzYStmMmVBenoyZHVnTGZj?=
 =?utf-8?B?WVdZZjdVcDlrRDZMUG1wbXRVcHBoN3VhdlN4STB0dHpwN3NMdVhCOXlIQjhj?=
 =?utf-8?Q?qvO35fpwf68Zj?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 07:43:33.5963 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f25c40a7-74d3-4cea-aa43-08dceced1236
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E62.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7091
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
Reviewed-by: Christian König <christian.koenig@amd.com>
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

