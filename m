Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C3EE606A321
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2026 06:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=f7fD8zKs
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1894B10EC5B;
	Wed, 21 Oct 2026 06:56:41 +0000 (UTC)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011043.outbound.protection.outlook.com
 [40.93.194.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7EDED10E2D8
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Oct 2026 06:56:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HrQ9CWV3WfMBo7S/qG9qyMvTKiq1w1MuRhmXLVfr3L36e7ayTTwzqEzc5HvjWhaPeTozt6uV2kDwXm5CL6YTEV1pPEE558byYGx1XR9WZ9zifm+hFFFwuzgodL+yYFFaePaLt2iFpf5flI1wesrjcMME72O7Nke7agq94egzAWeh7WGNVj5xC8CPiOWStaXfiUwwHoWiYllltFQEYZRGazHEqdvGthJUV5Ua9jShUqzqQWOiVjmMkFcin4uN0Ts3mq7F5W/khOnk4l6MxIwU/GIUMtSbcrysro0UjlcnBxHWYlgFA9xKJD9xLifFx83KbKuVWi2iPw3hnaPwFU4unA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9NuszUW5jn2e8bFgXZ7BiXebafHOU3wruwaJq9ICj9g=;
 b=D1c+Yld0jkk//9dhGluZaH/sc9kY0rDaoYhYrFzEEleZhHZthbhxxkXIRTiMQ6LVxS5yrf2vPkOU40RUUpSyVJavqr8UdOMwvZZNcPR3crsZoC4Dsv2k5DGQYbt0YgcTu5LJQs+WzI0DsWfqEr7jzL9+XurUr3FUocMEWRVNXO2U2qZdOP8X7j9/FwV+a2GxyCiKa1Sy6B+65N09+O/48dJUkxVVFLSmVLGkkAxnE+pUiNyzuMJU+hdaFCtAre5FYsDU3ThJTBqQtrYzVku0er6HAeRcvDNeo208qVtlkpI43V1lODSLcEMANyUMIzZ2IyyozZ7BpEe7uz9Ma1DCzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9NuszUW5jn2e8bFgXZ7BiXebafHOU3wruwaJq9ICj9g=;
 b=f7fD8zKs6VKARkOy3RFPLybLIM3qVSxi9xqYQLj3+2p72yBLXYp215taX948PjOjMkwvGAW2NRwl0LyOvKfsB4dxyjxfDTXUnCnxOqkuMp1Vr0wWTK8Dm9Pb3JhLeUCFh1+vr8w/wpJs6jAaLZmWc53ufr73+aazUH6J7VtyA1U=
Received: from BY5PR04CA0013.namprd04.prod.outlook.com (2603:10b6:a03:1d0::23)
 by MN2PR12MB4238.namprd12.prod.outlook.com (2603:10b6:208:199::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Wed, 21 Oct
 2026 06:56:26 +0000
Received: from SJ1PEPF0000231A.namprd03.prod.outlook.com
 (2603:10b6:a03:1d0:cafe::3b) by BY5PR04CA0013.outlook.office365.com
 (2603:10b6:a03:1d0::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Wed,
 21 Oct 2026 06:56:26 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF0000231A.mail.protection.outlook.com (10.167.242.231) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Wed, 21 Oct 2026 06:56:25 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.53; Wed, 21 Oct 2026 01:56:23 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Lijo Lazar <lijo.lazar@amd.com>, "James
 Zhu" <James.Zhu@amd.com>
Subject: [PATCH v2 2/7] drm/amdgpu: Integrate CWSR with user queues
Date: Wed, 21 Oct 2026 12:25:58 +0530
Message-ID: <20261021065603.1329111-3-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261021065603.1329111-1-srinivasan.shanmugam@amd.com>
References: <20261021065603.1329111-1-srinivasan.shanmugam@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231A:EE_|MN2PR12MB4238:EE_
X-MS-Office365-Filtering-Correlation-Id: 48912f37-c949-400a-8956-08df2f406cda
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|36860700016|82310400026|56012099006|11063799006|261009223027099003|10067099003|22082099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: /IkUpbnaOSOiK3d022Vogq7fuIVdrJoZ9FFkv5U47QH7F4TlFaD41UZenMJKmmFpdwbdio5T3Be6+ydRmujvy8yd1nwtSPUnpeuNratWShQMeaSy9rMKlEnDiyajZrCaenEqRdn30nKmg593MZp5ICXXXLwWWpNisImzPBBhUeDvR14mpDHfVtDnI3eBMzA+aSRgMLUYwEvMo6ry1z8ox9rEkcmfDAd8pgAliFgUGfh3msaVEIcMbYDuVE5kM4ypODk06/3vcggdpHTGB1DULQwaFuYYZaUyl4irelEmVFoAXysNYA9mkT7LKUpWdH7pf3MtPE54YAw2nL3E4DmQQT7gOHOla0EFGNGVEQd3rPFjLGS9hkH6d8dqbnSkBtg0mplx+zM5GmsrmDurn5HUJa/JUHCWQHICRRlBdRQ+b2Vfxv3MiM+MNw6wZqt+ALZjd7Iv8p3/oDjq4l3nek7YlzGAyAJr2XDaqSZ8brK9lDedB9D73LKACsJsLgrLuJ7aTREZczJKLecEVkRkqwkOy/7S+XTVpwhYls//zLp9cferS1sVRB1SPWeku+ZMIgOloj1vXmPjQV7+6MlHt1eg9HQGepjClXiGpIyZZ04bBIoXU8eQbwGmiSyGZo0G9ZnDISSfJ3NB3h+tLhSvK4C/nsMHvFwSHYS5eH2xl3OmlU1r7GxIMiXvQJ2+lwRSa4ruagZ+1cqAGIgo/qGawQNIzQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(36860700016)(82310400026)(56012099006)(11063799006)(261009223027099003)(10067099003)(22082099003)(18002099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: YOsqrcN/WeHHs0JufK9vRoBizQu/AwmK/YIFkjEgVrdiczwdh3kvPOd9V5jFhZ/56G3ccCXf2c1xKamENapAJUxA+0SBrT110/zTHbC1d1kXnXJFX2GL5rA1aUFLJs8zmRBuK11DPMt/WmOcT3h/Pz83xWAjHem6C1YsG+ubvRZ3RnSdrnxTickbJMSowpHotwvz7SHCDmWhnipzsCSwqSRak6PGf51iZIrj+YoONpdOh6Rc7cZk414roBibBMG6ah599czXQU1waLEJTTu4uPWiwLwTpm8Sza3gYYG5K2fUD5dbeoc5T/Oc4MUsMK+0Es7bDBsNAZJXgoJaYAOAe4orahhwd26BFvPPYZP2ddPljNdnv53G0Sc4fO3GgfCFI8n9Eoh7vS4wq/uxvMfQpAuovU4YsltsV60OXR8U76r0UBJHIFKJFzDITQbjbGt6
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 06:56:25.9291 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 48912f37-c949-400a-8956-08df2f406cda
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF0000231A.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4238
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Lijo Lazar <lijo.lazar@amd.com>

Initialize the CWSR handler during device initialization and release
the associated resources during device teardown.

Add a per-file CWSR trap object for render-node user queues and map the
first-level CWSR trap handler into the GPUVM associated with the file.
Use the mapped TBA and TMA addresses when programming user queues.

Add user save area parameters to the MQD properties for compute queue
creation and validate the parameters before using them for MQD
initialization.

The CWSR parameter validation walks the VM mapping tree and updates the
user queue VA mapping state. Reserve the VM root BO around the
validation so the required VM reservation is held while accessing the
mapping tree.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Co-developed-by: James Zhu <James.Zhu@amd.com>
Signed-off-by: James Zhu <James.Zhu@amd.com>
Change-Id: I2bc2159e6ff36b2aaa08d112ed8e7a17b5dadc5e
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |   2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.c   |   8 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.h   |   6 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  10 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c    |   9 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h    |   8 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c  |  25 +++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h  |   8 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c     |  14 +++
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 102 +++++++++++++++++----
 10 files changed, 172 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 53aeaca52a6e..6ed1cb942802 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -333,6 +333,7 @@ struct amdgpu_reset_control;
 struct amdgpu_coredump_info;
 struct amdgpu_video_codecs;
 struct amdgpu_cwsr_isa;
+struct amdgpu_cwsr_trap_obj;
 
 enum amdgpu_cp_irq {
 	AMDGPU_CP_IRQ_GFX_ME0_PIPE0_EOP = 0,
@@ -421,6 +422,7 @@ struct amdgpu_fpriv {
 	struct xarray		bo_list_handles;
 	struct amdgpu_ctx_mgr	ctx_mgr;
 	struct amdgpu_userq_mgr	userq_mgr;
+	struct amdgpu_cwsr_trap_obj *cwsr_trap;
 
 	/* Eviction fence infra */
 	struct amdgpu_eviction_fence_mgr evf_mgr;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.c
index e9cd04364367..e854614483c2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.c
@@ -387,6 +387,7 @@ int amdgpu_cwsr_alloc(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 
 	if (!amdgpu_cwsr_is_enabled(adev))
 		return -EOPNOTSUPP;
+
 	if (!vm || !trap_obj)
 		return -EINVAL;
 
@@ -395,12 +396,15 @@ int amdgpu_cwsr_alloc(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 		return -ENOMEM;
 
 	bo = adev->cwsr_info->isa_bo;
+
 	drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT, 0);
 	drm_exec_until_all_locked(&exec) {
 		r = amdgpu_vm_lock_pd(vm, &exec, 0);
 		if (likely(!r))
 			r = drm_exec_lock_obj(&exec, &bo->tbo.base);
+
 		drm_exec_retry_on_contention(&exec);
+
 		if (unlikely(r)) {
 			dev_err(adev->dev,
 				"failed to reserve for CWSR allocs: err=%d\n",
@@ -447,17 +451,21 @@ int amdgpu_cwsr_alloc(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	}
 
 	drm_exec_fini(&exec);
+
 	*trap_obj = cwsr;
 	return 0;
 
 err_kmap:
 	amdgpu_bo_kunmap(cwsr->tma_bo);
+
 err_tma:
 	amdgpu_bo_unref(&cwsr->tma_bo);
+
 err_exec:
 	drm_exec_fini(&exec);
 	kfree(cwsr);
 	*trap_obj = NULL;
+
 	return r;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.h
index 297a4ff04730..65a0d2852fb3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.h
@@ -79,4 +79,10 @@ uint32_t amdgpu_cwsr_size_needed(struct amdgpu_device *adev, int num_xcc);
 int amdgpu_cwsr_validate_params(struct amdgpu_device *adev,
 				struct amdgpu_cwsr_params *cwsr_params,
 				int num_xcc);
+static inline bool amdgpu_cwsr_has_dbg_wa(struct amdgpu_device *adev)
+{
+	uint32_t gc_ver = amdgpu_ip_version(adev, GC_HWIP, 0);
+
+	return gc_ver >= IP_VERSION(11, 0, 0) && gc_ver <= IP_VERSION(11, 0, 3);
+}
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 7cb1427761ef..ccabaf99eca6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -81,6 +81,7 @@
 #include "amdgpu_reset.h"
 #include "amdgpu_virt.h"
 #include "amdgpu_dev_coredump.h"
+#include "amdgpu_cwsr.h"
 
 #include <linux/suspend.h>
 #include <drm/task_barrier.h>
@@ -2546,6 +2547,14 @@ static int amdgpu_device_ip_init(struct amdgpu_device *adev)
 	amdgpu_fru_get_product_info(adev);
 
 	r = amdgpu_cper_init(adev);
+	if (r)
+		goto init_failed;
+
+	r = amdgpu_cwsr_init(adev);
+	if (r == -EOPNOTSUPP)
+		r = 0;
+	else if (r)
+		goto init_failed;
 
 init_failed:
 
@@ -2950,6 +2959,7 @@ static int amdgpu_device_ip_fini(struct amdgpu_device *adev)
 {
 	int i, r;
 
+	amdgpu_cwsr_fini(adev);
 	amdgpu_cper_fini(adev);
 
 	if (amdgpu_sriov_vf(adev) && adev->virt.ras_init_done)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 14a72a406d37..fe5e505c6f2b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -49,6 +49,8 @@
 #include "amdgpu_userq.h"
 #include "amdgpu_video_codecs.h"
 #include "amdgpu_ras_mgr.h"
+#include "amdgpu_vm.h"
+#include "amdgpu_cwsr.h"
 
 void amdgpu_unregister_gpu_instance(struct amdgpu_device *adev)
 {
@@ -1580,6 +1582,12 @@ int amdgpu_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
 			 r);
 
 	amdgpu_evf_mgr_init(&fpriv->evf_mgr);
+
+	r = amdgpu_cwsr_alloc(adev, &fpriv->vm,
+			      &fpriv->cwsr_trap);
+	if (r == -EOPNOTSUPP)
+		r = 0;
+
 	amdgpu_ctx_mgr_init(&fpriv->ctx_mgr, adev);
 
 	file_priv->driver_priv = fpriv;
@@ -1649,6 +1657,7 @@ void amdgpu_driver_postclose_kms(struct drm_device *dev,
 	}
 
 	amdgpu_ctx_mgr_fini(&fpriv->ctx_mgr);
+	amdgpu_cwsr_free(adev, &fpriv->vm, &fpriv->cwsr_trap);
 
 	if (pasid)
 		amdgpu_pasid_free_delayed(pd->tbo.base.resv, pasid);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
index 0f368fbd2c80..298ac47f83bc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
@@ -533,6 +533,14 @@ struct amdgpu_mqd_prop {
 	uint32_t cu_mask_count;
 	uint32_t cu_flags;
 	bool is_user_cu_masked;
+	bool aql_queue;
+	uint32_t queue_percentage;
+	/* used in gfx9 and gfx12.1 */
+	uint32_t pm4_target_xcc;
+	/* cwsr params */
+	uint64_t ctx_save_area_addr;
+	uint32_t ctx_save_area_size;
+	uint32_t ctl_stack_size;
 };
 
 struct amdgpu_mqd {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 1a2aa85c504e..d1811a29892a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -35,6 +35,7 @@
 #include "amdgpu_hmm.h"
 #include "amdgpu_userq_fence.h"
 #include "amdgpu_trace.h"
+#include "amdgpu_cwsr.h"
 
 u32 amdgpu_userq_get_supported_ip_mask(struct amdgpu_device *adev)
 {
@@ -266,6 +267,30 @@ int amdgpu_userq_input_va_validate(struct amdgpu_device *adev,
 	return -EINVAL;
 }
 
+int amdgpu_userq_input_cwsr_params_validate(
+	struct amdgpu_usermode_queue *queue,
+	struct amdgpu_cwsr_params *cwsr_params)
+{
+	struct amdgpu_fpriv *fpriv = uq_mgr_to_fpriv(queue->userq_mgr);
+	struct amdgpu_device *adev = queue->userq_mgr->adev;
+	uint32_t cwsr_size;
+	int num_xcc;
+	int r;
+
+	num_xcc = amdgpu_xcp_get_num_xcc(adev->xcp_mgr, fpriv->xcp_id);
+	r = amdgpu_cwsr_validate_params(queue->userq_mgr->adev, cwsr_params,
+					num_xcc);
+	if (r)
+		return r;
+	cwsr_size = amdgpu_cwsr_size_needed(queue->userq_mgr->adev, num_xcc);
+	if (!cwsr_size)
+		return -EOPNOTSUPP;
+
+	return amdgpu_userq_input_va_validate(
+		adev, queue, cwsr_params->ctx_save_area_address, cwsr_size,
+		&queue->userq_vas.va.cwsr);
+}
+
 static bool amdgpu_userq_buffer_va_mapped(struct amdgpu_vm *vm, u64 addr)
 {
 	struct amdgpu_bo_va_mapping *mapping;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
index 488dc21d7c81..727f60c40bbf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -41,6 +41,7 @@ enum amdgpu_userq_state {
 };
 
 struct amdgpu_mqd_prop;
+struct amdgpu_cwsr_params;
 
 struct amdgpu_userq_obj {
 	void		 *cpu_ptr;
@@ -97,8 +98,9 @@ struct amdgpu_usermode_queue {
 			u64 eop;
 			u64 shadow;
 			u64 csa;
+			u64 cwsr;
 		} va;
-		u64 va_array[6];
+		u64 va_array[7];
 	} userq_vas;
 
 	uint32_t	gang_ctx_array_index;
@@ -200,4 +202,8 @@ int amdgpu_userq_input_va_validate(struct amdgpu_device *adev,
 
 void amdgpu_userq_gem_va_unmap_validate(struct amdgpu_device *adev,
 					struct amdgpu_bo_va_mapping *mapping);
+int amdgpu_userq_input_cwsr_params_validate(
+	struct amdgpu_usermode_queue *queue,
+	struct amdgpu_cwsr_params *cwsr_params);
+
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index d334fb805020..2adc2bcc3dce 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -3224,6 +3224,20 @@ static int gfx_v12_0_compute_mqd_init(struct amdgpu_device *adev, void *m,
 	/* set CU mask */
 	gfx_v12_0_compute_mqd_set_cu_mask(adev, mqd, prop);
 
+	/* If non-zero, assume cwsr is enabled */
+	if (prop->ctx_save_area_addr) {
+		mqd->cp_hqd_persistent_state |=
+			(1 << CP_HQD_PERSISTENT_STATE__QSWITCH_MODE__SHIFT);
+		mqd->cp_hqd_ctx_save_base_addr_lo =
+			lower_32_bits(prop->ctx_save_area_addr);
+		mqd->cp_hqd_ctx_save_base_addr_hi =
+			upper_32_bits(prop->ctx_save_area_addr);
+		mqd->cp_hqd_ctx_save_size = prop->ctx_save_area_size;
+		mqd->cp_hqd_cntl_stack_size = prop->ctl_stack_size;
+		mqd->cp_hqd_cntl_stack_offset = prop->ctl_stack_size;
+		mqd->cp_hqd_wg_state_offset = prop->ctl_stack_size;
+	}
+
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
index 7abb9d95ef59..108dced28f97 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
@@ -27,6 +27,7 @@
 #include "mes_userqueue.h"
 #include "amdgpu_userq_fence.h"
 #include "amdgpu_trace.h"
+#include "amdgpu_cwsr.h"
 
 #define AMDGPU_USERQ_PROC_CTX_SZ PAGE_SIZE
 #define AMDGPU_USERQ_GANG_CTX_SZ PAGE_SIZE
@@ -120,6 +121,7 @@ static int convert_to_mes_priority(int priority)
 static int mes_userq_map(struct amdgpu_usermode_queue *queue)
 {
 	struct amdgpu_userq_mgr *uq_mgr = queue->userq_mgr;
+	struct amdgpu_fpriv *fpriv = uq_mgr_to_fpriv(uq_mgr);
 	struct amdgpu_device *adev = uq_mgr->adev;
 	struct amdgpu_userq_obj *ctx = &queue->fw_obj;
 	struct amdgpu_mqd_prop *userq_props = queue->userq_prop;
@@ -151,24 +153,37 @@ static int mes_userq_map(struct amdgpu_usermode_queue *queue)
 	queue_input.page_table_base_addr = amdgpu_gmc_pd_addr(queue->vm->root.bo);
 	queue_input.wptr_mc_addr = queue->wptr_obj.gpu_addr;
 
+	if (fpriv->cwsr_trap) {
+		queue_input.tba_addr = fpriv->cwsr_trap->tba_gpu_va_addr;
+		queue_input.tma_addr = fpriv->cwsr_trap->tma_gpu_va_addr;
+		queue_input.trap_en = !amdgpu_cwsr_has_dbg_wa(adev);
+	}
+
 	if (mes->use_rs64mem) {
 		if (!uq_mgr->proc_ctx_allocated) {
-			r = amdgpu_mes_alloc_proc_ctx_index(mes, &uq_mgr->proc_ctx_array_index);
+			r = amdgpu_mes_alloc_proc_ctx_index(mes,
+							    &uq_mgr->proc_ctx_array_index);
 			if (r) {
-				DRM_ERROR("Failed to allocate userq process index err:%d\n", r);
+				DRM_ERROR("Failed to allocate userq process index err:%d\n",
+					  r);
 				return r;
 			}
 			uq_mgr->proc_ctx_allocated = true;
 		}
 
-		r = amdgpu_mes_alloc_gang_ctx_index(mes, &queue->gang_ctx_array_index);
+		r = amdgpu_mes_alloc_gang_ctx_index(mes,
+						    &queue->gang_ctx_array_index);
 		if (r) {
 			DRM_ERROR("Failed to allocate userq gang index err:%d\n", r);
 			return r;
 		}
-		queue_input.process_context_array_index = uq_mgr->proc_ctx_array_index;
-		queue_input.gang_context_array_index = queue->gang_ctx_array_index;
+
+		queue_input.process_context_array_index =
+			uq_mgr->proc_ctx_array_index;
+		queue_input.gang_context_array_index =
+			queue->gang_ctx_array_index;
 	}
+
 	amdgpu_mes_lock(&adev->mes);
 	r = adev->mes.funcs->add_hw_queue(&adev->mes, &queue_input);
 	amdgpu_mes_unlock(&adev->mes);
@@ -179,7 +194,9 @@ static int mes_userq_map(struct amdgpu_usermode_queue *queue)
 
 	amdgpu_mes_userq_queue_mapped(adev);
 
-	DRM_DEBUG_DRIVER("Queue (doorbell:%d) mapped successfully\n", userq_props->doorbell_index);
+	DRM_DEBUG_DRIVER("Queue (doorbell:%d) mapped successfully\n",
+			 userq_props->doorbell_index);
+
 	return 0;
 }
 
@@ -403,6 +420,7 @@ static int mes_userq_mqd_create(struct amdgpu_usermode_queue *queue,
 
 	if (queue->queue_type == AMDGPU_HW_IP_COMPUTE) {
 		struct drm_amdgpu_userq_mqd_compute_gfx11 *compute_mqd;
+		struct amdgpu_cwsr_params cwsr_params;
 
 		if (mqd_user->mqd_size != sizeof(*compute_mqd)) {
 			DRM_ERROR("Invalid compute IP MQD size\n");
@@ -410,7 +428,8 @@ static int mes_userq_mqd_create(struct amdgpu_usermode_queue *queue,
 			goto free_mqd;
 		}
 
-		compute_mqd = memdup_user(u64_to_user_ptr(mqd_user->mqd), mqd_user->mqd_size);
+		compute_mqd = memdup_user(u64_to_user_ptr(mqd_user->mqd),
+					  mqd_user->mqd_size);
 		if (IS_ERR(compute_mqd)) {
 			r = PTR_ERR(compute_mqd);
 			goto free_mqd;
@@ -421,6 +440,7 @@ static int mes_userq_mqd_create(struct amdgpu_usermode_queue *queue,
 			kfree(compute_mqd);
 			goto free_mqd;
 		}
+
 		r = amdgpu_userq_input_va_validate(adev, queue,
 						   compute_mqd->eop_va, 2048,
 						   &queue->userq_vas.va.eop);
@@ -432,29 +452,63 @@ static int mes_userq_mqd_create(struct amdgpu_usermode_queue *queue,
 
 		userq_props->eop_gpu_addr = compute_mqd->eop_va;
 		userq_props->hqd_pipe_priority = AMDGPU_GFX_PIPE_PRIO_NORMAL;
-		userq_props->hqd_queue_priority = AMDGPU_GFX_QUEUE_PRIORITY_MINIMUM;
+		userq_props->hqd_queue_priority =
+			AMDGPU_GFX_QUEUE_PRIORITY_MINIMUM;
 		userq_props->hqd_active = false;
 		userq_props->tmz_queue =
 			mqd_user->flags & AMDGPU_USERQ_CREATE_FLAGS_QUEUE_SECURE;
+
+		if (amdgpu_cwsr_is_enabled(adev)) {
+			struct amdgpu_fpriv *fpriv =
+				uq_mgr_to_fpriv(queue->userq_mgr);
+			int num_xcc;
+
+			num_xcc = amdgpu_xcp_get_num_xcc(adev->xcp_mgr,
+							 fpriv->xcp_id);
+			cwsr_params.ctx_save_area_address =
+				userq_props->ctx_save_area_addr;
+			cwsr_params.cwsr_sz =
+				userq_props->ctx_save_area_size;
+			userq_props->ctl_stack_size =
+				adev->cwsr_info->xcc_ctl_stack_sz * num_xcc;
+
+			r = amdgpu_bo_reserve(queue->vm->root.bo, false);
+			if (r) {
+				kfree(compute_mqd);
+				goto free_mqd;
+			}
+
+			r = amdgpu_userq_input_cwsr_params_validate(
+				queue, &cwsr_params);
+			amdgpu_bo_unreserve(queue->vm->root.bo);
+			if (r) {
+				kfree(compute_mqd);
+				goto free_mqd;
+			}
+		}
+
 		kfree(compute_mqd);
 	} else if (queue->queue_type == AMDGPU_HW_IP_GFX) {
 		struct drm_amdgpu_userq_mqd_gfx11 *mqd_gfx_v11;
 		struct amdgpu_gfx_shadow_info shadow_info;
 
 		if (adev->gfx.funcs->get_gfx_shadow_info) {
-			adev->gfx.funcs->get_gfx_shadow_info(adev, &shadow_info, true);
+			adev->gfx.funcs->get_gfx_shadow_info(adev,
+							     &shadow_info, true);
 		} else {
 			r = -EINVAL;
 			goto free_mqd;
 		}
 
-		if (mqd_user->mqd_size != sizeof(*mqd_gfx_v11) || !mqd_user->mqd) {
+		if (mqd_user->mqd_size != sizeof(*mqd_gfx_v11) ||
+		    !mqd_user->mqd) {
 			DRM_ERROR("Invalid GFX MQD\n");
 			r = -EINVAL;
 			goto free_mqd;
 		}
 
-		mqd_gfx_v11 = memdup_user(u64_to_user_ptr(mqd_user->mqd), mqd_user->mqd_size);
+		mqd_gfx_v11 = memdup_user(u64_to_user_ptr(mqd_user->mqd),
+					   mqd_user->mqd_size);
 		if (IS_ERR(mqd_gfx_v11)) {
 			r = PTR_ERR(mqd_gfx_v11);
 			goto free_mqd;
@@ -470,7 +524,9 @@ static int mes_userq_mqd_create(struct amdgpu_usermode_queue *queue,
 			kfree(mqd_gfx_v11);
 			goto free_mqd;
 		}
-		r = amdgpu_userq_input_va_validate(adev, queue, mqd_gfx_v11->shadow_va,
+
+		r = amdgpu_userq_input_va_validate(adev, queue,
+						   mqd_gfx_v11->shadow_va,
 						   shadow_info.shadow_size,
 						   &queue->userq_vas.va.shadow);
 		if (r) {
@@ -479,7 +535,8 @@ static int mes_userq_mqd_create(struct amdgpu_usermode_queue *queue,
 			goto free_mqd;
 		}
 
-		r = amdgpu_userq_input_va_validate(adev, queue, mqd_gfx_v11->csa_va,
+		r = amdgpu_userq_input_va_validate(adev, queue,
+						   mqd_gfx_v11->csa_va,
 						   shadow_info.csa_size,
 						   &queue->userq_vas.va.csa);
 		amdgpu_bo_unreserve(queue->vm->root.bo);
@@ -492,13 +549,15 @@ static int mes_userq_mqd_create(struct amdgpu_usermode_queue *queue,
 	} else if (queue->queue_type == AMDGPU_HW_IP_DMA) {
 		struct drm_amdgpu_userq_mqd_sdma_gfx11 *mqd_sdma_v11;
 
-		if (mqd_user->mqd_size != sizeof(*mqd_sdma_v11) || !mqd_user->mqd) {
+		if (mqd_user->mqd_size != sizeof(*mqd_sdma_v11) ||
+		    !mqd_user->mqd) {
 			DRM_ERROR("Invalid SDMA MQD\n");
 			r = -EINVAL;
 			goto free_mqd;
 		}
 
-		mqd_sdma_v11 = memdup_user(u64_to_user_ptr(mqd_user->mqd), mqd_user->mqd_size);
+		mqd_sdma_v11 = memdup_user(u64_to_user_ptr(mqd_user->mqd),
+					    mqd_user->mqd_size);
 		if (IS_ERR(mqd_sdma_v11)) {
 			r = PTR_ERR(mqd_sdma_v11);
 			goto free_mqd;
@@ -509,7 +568,9 @@ static int mes_userq_mqd_create(struct amdgpu_usermode_queue *queue,
 			kfree(mqd_sdma_v11);
 			goto free_mqd;
 		}
-		r = amdgpu_userq_input_va_validate(adev, queue, mqd_sdma_v11->csa_va,
+
+		r = amdgpu_userq_input_va_validate(adev, queue,
+						   mqd_sdma_v11->csa_va,
 						   32,
 						   &queue->userq_vas.va.csa);
 		amdgpu_bo_unreserve(queue->vm->root.bo);
@@ -524,7 +585,8 @@ static int mes_userq_mqd_create(struct amdgpu_usermode_queue *queue,
 
 	queue->userq_prop = userq_props;
 
-	r = mqd_hw_default->init_mqd(adev, (void *)queue->mqd.cpu_ptr, userq_props);
+	r = mqd_hw_default->init_mqd(adev, (void *)queue->mqd.cpu_ptr,
+				     userq_props);
 	if (r) {
 		DRM_ERROR("Failed to initialize MQD for userqueue\n");
 		goto free_mqd;
@@ -533,7 +595,8 @@ static int mes_userq_mqd_create(struct amdgpu_usermode_queue *queue,
 	/* Create per-process MES process context BO */
 	r = mes_userq_create_proc_ctx_space(uq_mgr);
 	if (r) {
-		DRM_ERROR("Failed to allocate MES process context space bo, error: %d\n", r);
+		DRM_ERROR("Failed to allocate MES process context space bo, error: %d\n",
+			  r);
 		goto free_mqd;
 	}
 
@@ -545,7 +608,8 @@ static int mes_userq_mqd_create(struct amdgpu_usermode_queue *queue,
 	}
 
 	/* FW expects WPTR BOs to be mapped into GART */
-	r = mes_userq_create_wptr_mapping(adev, uq_mgr, queue, userq_props->wptr_gpu_addr);
+	r = mes_userq_create_wptr_mapping(adev, uq_mgr, queue,
+					  userq_props->wptr_gpu_addr);
 	if (r) {
 		DRM_ERROR("Failed to create WPTR mapping\n");
 		goto free_ctx;
-- 
2.34.1

