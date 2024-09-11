Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEF61EE0211
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Sep 2024 07:07:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5206810EA06;
	Wed, 11 Sep 2024 07:07:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3Y3mj5M6";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2068.outbound.protection.outlook.com [40.107.95.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE2C810EA06
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Sep 2024 07:07:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CiRxE5mlqEMot/djG3GPcnOc23PBc9GTlx05GoiRo6wHyE39nWcSau3RQdiP2FAdtzH4ljm4KN+BMokoHmcOiee635BX87x5njsGcvRL6m5jlmwGQxNnbqxwZXys3o7cKIPY5ZVsbWPhNXZsb3OmAuVLWe0m81OmDj0SiElxUEGc7skiQ+RkzuMwLzmurQqpVqgsO13ZImPJDAwL86+HaCfSP2wrOF/lvnU1bdveyB/EMujGCJnzbb7P/DLas1zJRIEJlOKEfSb8QuVDMGFcXpPDcQ34GVHUmNz8QUVmFWYY0nb4+fe3vuyuJAAr94m2nZwgzyh+8wNhCNnhm6HB9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gbsuxfO6CV9Dk6Sk8rqeL9w7wEQCj7tn9aXh68pamY0=;
 b=iolnpjmugN0tS3oiCR6nXYRxON0YmdvJG8CxLSA7fvry0hHQVZdTRqjyRBD0V4WoFevN/p3liVLTrboN58CpepDcc13SElLrbBnPjjEuMuYYsswhdnmnhYqh1kC5FcllM6MAbJ7xALlVggLQYua4dMe37tdA3NmfWdzsFaVW8wjI1/x+uWt4NwxaKRriGPH98Hfw9OrLRWSYvpZD9ndYH3s/BNUJ21/OBp6zDJQem79Ov3KBJ5WinWGH4Wu33WVto/kIfWW0apHQjLJX/jM4qIelpIbxoHeXSNyOndcPd+SWv19q+JHa8FyJfKFqLSNWsfm96/L4aNb8CJQ+KTaYcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gbsuxfO6CV9Dk6Sk8rqeL9w7wEQCj7tn9aXh68pamY0=;
 b=3Y3mj5M6iSAa80TZrIzfLJljXWvvX9y3HAd1VFaDuAaff0WJOxm+Hvu6w/NQtjTwvh7Mk8shMDES2NuR6HL0nXdx3ZJg5VwAPgR+Uor41XZAqGqL2Np1I9ybCWWJhijIWPqJwUeKIUMiVUjw8GSL+P5IxXD3EIJCKvMn41MUq+4=
Received: from BN1PR12CA0002.namprd12.prod.outlook.com (2603:10b6:408:e1::7)
 by DM3PR12MB9349.namprd12.prod.outlook.com (2603:10b6:0:49::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.27; Wed, 11 Sep
 2024 07:07:33 +0000
Received: from BN1PEPF00004688.namprd05.prod.outlook.com
 (2603:10b6:408:e1:cafe::52) by BN1PR12CA0002.outlook.office365.com
 (2603:10b6:408:e1::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24 via Frontend
 Transport; Wed, 11 Sep 2024 07:07:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00004688.mail.protection.outlook.com (10.167.243.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Wed, 11 Sep 2024 07:07:32 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 11 Sep
 2024 02:07:29 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Christian.Koenig@amd.com>, <feifxu@amd.com>, <rajneesh.bhardwaj@amd.com>,
 Feifei Xu <Feifei.Xu@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH v2 07/10] drm/amdgpu: Drop delayed reset work handler
Date: Wed, 11 Sep 2024 12:28:55 +0530
Message-ID: <20240911065858.2224424-8-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240911065858.2224424-1-lijo.lazar@amd.com>
References: <20240911065858.2224424-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004688:EE_|DM3PR12MB9349:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ef9dff3-2287-41ec-cdd7-08dcd2306831
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?zkIp8Fklhs8Z2BuJ9wM8FmBIF2EhCL1S0GSS5eaK7WWBvkQc6W3VsID1lBCe?=
 =?us-ascii?Q?L6wCuGrad9NctskdQJNPHhXAjOgRoikCsKXPS/vIWhTgcvZRgogglUpU0YIk?=
 =?us-ascii?Q?CwQmdNQWteRZcR3BkBkMQXcSYdFA1CowA17Fwp30AhEQgMWGMZjN0rJFqeVQ?=
 =?us-ascii?Q?+SGaefsJAOWnNvDhBZyrtP6OLOdy8BFLVntrjpXihHLYwaNbbAwCaaVudIwG?=
 =?us-ascii?Q?4m/MHDnGj5D27E5/Jcb/Cgo3K+T1aKfnpeENHCB9ApF3WZskHb7/VRpESdzE?=
 =?us-ascii?Q?IEVv3jYqKK+1LOgH3HMaAgWJXdlt4+LRhnkjbsK1UJKuwtZHcsCENM8Lgiq0?=
 =?us-ascii?Q?n6kGDdqCJ8OYV7e6L0hoA+OUqB2NXjTEK1/AfuWIdWOd7d3ArK27b9u1Z02v?=
 =?us-ascii?Q?vIm4L8GtzLufpMinQGMZ4HM12ASVTSvrvTQUVl+JGnG9j+Py9MFm2ZokyLug?=
 =?us-ascii?Q?EyoE/kmaqsflXtvWpW6JOScl+/q/bgUzIlnnFSaeHoD0C7R2G3J/Zr+3mXYI?=
 =?us-ascii?Q?lxmvF3Elg6ksjnSNzPNqtr64Dj+vAulB82s8GT5/8QWUmUsFmmVW2K+j5iiB?=
 =?us-ascii?Q?ciBrpx40BwAhzr+V/gepEd/Fe2EZ1V61aq1744rwPVJMINsZp5ptYZj7r/cB?=
 =?us-ascii?Q?+AezdgJpD9mBDqPUbcVa8fwdVLBRnXNiDgEi034GYVdE6ud3aiOj4HHWITQi?=
 =?us-ascii?Q?3l3FzZ2qpfZ+0FCMooNseJQTV14muOh5JJqa0o0zvCf9T6+qxR7AJrP/mKfS?=
 =?us-ascii?Q?s/+RHe2OERwLrx28EoYnsTqX6P23fwzK0eJLPsOzwqLIRwQioD6ppgZbKV7P?=
 =?us-ascii?Q?MrIOFMobTOdfrr5/THUQfvsIZe0xZ6i/BfTnf0y/9qQczwGUzUxmu+JpjA8W?=
 =?us-ascii?Q?EtuR4q4qZ4uZ1IjyEayqAUt8076e4s2U/17zyKUXhpiLQCMqafcf9jBVDCNW?=
 =?us-ascii?Q?Fxq5PoOZP5QwtegMtSYmIR6peg3lJxmo0or/M7vAGnBLeVf+2wNCdI3MENCx?=
 =?us-ascii?Q?HPWxZ1RArCwaoRuYnacQ8chqGq+m1hWxhkQ0GrqdQYD/VGL6wl/uJ4FszD6g?=
 =?us-ascii?Q?AqTylx6/3F8m+p7fR4GuIWCLPUKibrkvr74jM+eJrdfzHate7emPzRRnhlNl?=
 =?us-ascii?Q?U8U6SECWckGFuzosnz9QDmq6tKhOd3kczKZcY6Diis28Sx097vr9QnfybyyB?=
 =?us-ascii?Q?lwZe0F3u4DpLnGluzBdC9olxKAchGV268Dodb1gF4JI/he0n+hEcdThhqvma?=
 =?us-ascii?Q?3Gn50VnMbFgKiSv4XWhe8hbgxB5HvxM0YmWA0cEOcR3sXchmAu/Xm0ETcSdG?=
 =?us-ascii?Q?2vajahDyhz6xeo8MLUqe/Nw1vjkIz6tUpMd8jh9HcLnFCdgwyM7PWRUmNZ/r?=
 =?us-ascii?Q?v5H3Dpd8SUhvL9r2vS2gB4EldGORrOwlEbDztL3FEe/yGn6RZpcissRR6HBx?=
 =?us-ascii?Q?hN14W1iyUGVxRf4TeYwr85WZeC7e78rc?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2024 07:07:32.7500 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ef9dff3-2287-41ec-cdd7-08dcd2306831
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004688.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9349
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

Drop delayed reset work handler as it is no longer used.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Feifei Xu <Feifei.Xu@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h     |  4 --
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 80 -------------------------
 2 files changed, 84 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 348725908cf7..47949c43a335 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -131,10 +131,6 @@ struct amdgpu_mgpu_info {
 	uint32_t			num_gpu;
 	uint32_t			num_dgpu;
 	uint32_t			num_apu;
-
-	/* delayed reset_func for XGMI configuration if necessary */
-	struct delayed_work		delayed_reset_work;
-	bool				pending_reset;
 };
 
 enum amdgpu_ss {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 3dece2e69608..4f644b120df7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -221,8 +221,6 @@ int amdgpu_wbrf = -1;
 int amdgpu_damage_clips = -1; /* auto */
 int amdgpu_umsch_mm_fwlog;
 
-static void amdgpu_drv_delayed_reset_work_handler(struct work_struct *work);
-
 DECLARE_DYNDBG_CLASSMAP(drm_debug_classes, DD_CLASS_TYPE_DISJOINT_BITS, 0,
 			"DRM_UT_CORE",
 			"DRM_UT_DRIVER",
@@ -237,9 +235,6 @@ DECLARE_DYNDBG_CLASSMAP(drm_debug_classes, DD_CLASS_TYPE_DISJOINT_BITS, 0,
 
 struct amdgpu_mgpu_info mgpu_info = {
 	.mutex = __MUTEX_INITIALIZER(mgpu_info.mutex),
-	.delayed_reset_work = __DELAYED_WORK_INITIALIZER(
-			mgpu_info.delayed_reset_work,
-			amdgpu_drv_delayed_reset_work_handler, 0),
 };
 int amdgpu_ras_enable = -1;
 uint amdgpu_ras_mask = 0xffffffff;
@@ -2455,81 +2450,6 @@ amdgpu_pci_shutdown(struct pci_dev *pdev)
 	adev->mp1_state = PP_MP1_STATE_NONE;
 }
 
-/**
- * amdgpu_drv_delayed_reset_work_handler - work handler for reset
- *
- * @work: work_struct.
- */
-static void amdgpu_drv_delayed_reset_work_handler(struct work_struct *work)
-{
-	struct list_head device_list;
-	struct amdgpu_device *adev;
-	int i, r;
-	struct amdgpu_reset_context reset_context;
-
-	memset(&reset_context, 0, sizeof(reset_context));
-
-	mutex_lock(&mgpu_info.mutex);
-	if (mgpu_info.pending_reset == true) {
-		mutex_unlock(&mgpu_info.mutex);
-		return;
-	}
-	mgpu_info.pending_reset = true;
-	mutex_unlock(&mgpu_info.mutex);
-
-	/* Use a common context, just need to make sure full reset is done */
-	reset_context.method = AMD_RESET_METHOD_NONE;
-	set_bit(AMDGPU_NEED_FULL_RESET, &reset_context.flags);
-
-	for (i = 0; i < mgpu_info.num_dgpu; i++) {
-		adev = mgpu_info.gpu_ins[i].adev;
-		reset_context.reset_req_dev = adev;
-		r = amdgpu_device_pre_asic_reset(adev, &reset_context);
-		if (r) {
-			dev_err(adev->dev, "GPU pre asic reset failed with err, %d for drm dev, %s ",
-				r, adev_to_drm(adev)->unique);
-		}
-		if (!queue_work(system_unbound_wq, &adev->xgmi_reset_work))
-			r = -EALREADY;
-	}
-	for (i = 0; i < mgpu_info.num_dgpu; i++) {
-		adev = mgpu_info.gpu_ins[i].adev;
-		flush_work(&adev->xgmi_reset_work);
-	}
-
-	/* reset function will rebuild the xgmi hive info , clear it now */
-	for (i = 0; i < mgpu_info.num_dgpu; i++)
-		amdgpu_xgmi_remove_device(mgpu_info.gpu_ins[i].adev);
-
-	INIT_LIST_HEAD(&device_list);
-
-	for (i = 0; i < mgpu_info.num_dgpu; i++)
-		list_add_tail(&mgpu_info.gpu_ins[i].adev->reset_list, &device_list);
-
-	/* unregister the GPU first, reset function will add them back */
-	list_for_each_entry(adev, &device_list, reset_list)
-		amdgpu_unregister_gpu_instance(adev);
-
-	/* Use a common context, just need to make sure full reset is done */
-	set_bit(AMDGPU_SKIP_HW_RESET, &reset_context.flags);
-	set_bit(AMDGPU_SKIP_COREDUMP, &reset_context.flags);
-	r = amdgpu_do_asic_reset(&device_list, &reset_context);
-
-	if (r) {
-		DRM_ERROR("reinit gpus failure");
-		return;
-	}
-	for (i = 0; i < mgpu_info.num_dgpu; i++) {
-		adev = mgpu_info.gpu_ins[i].adev;
-		if (!adev->kfd.init_complete) {
-			kgd2kfd_init_zone_device(adev);
-			amdgpu_amdkfd_device_init(adev);
-			amdgpu_amdkfd_drm_client_create(adev);
-		}
-		amdgpu_ttm_set_buffer_funcs_status(adev, true);
-	}
-}
-
 static int amdgpu_pmops_prepare(struct device *dev)
 {
 	struct drm_device *drm_dev = dev_get_drvdata(dev);
-- 
2.25.1

