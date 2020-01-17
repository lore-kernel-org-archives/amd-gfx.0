Return-Path: <SRS0=QkQq=3G=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22011C33C9E
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Jan 2020 21:39:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF4332072B
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Jan 2020 21:39:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="P/B0sAzq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF4332072B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 91B076F937;
	Fri, 17 Jan 2020 21:39:33 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2089.outbound.protection.outlook.com [40.107.93.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C207F6F937
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Jan 2020 21:39:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Izl21ZvWyka6PRHfu2Lum4iORih47xo+wXjYWPFkfT9OEFUkkA860HSqrD4H2ytuA1K7dGRn/gMuMrJ4Odp9O71d1SQNJQxTyNsKiEZqDRXOw124auWaeBcs9PV0LBADlE7mcaOjzoPUUDYIz3N643l3RjhdtWSs9pKWG7/Y6OuZ8WUq/z9W05t0B2Tl+ZZu11W7awsDi+RVx2TYqN30+Y1Sn4sTWWGEeiwqTvWMCuXSyWpRWdr7i6CcvGnWcTAhghrUomze0yviBmcwKY4VEa3+a3dKefnPUOwQKBfY5pxPnl+9UfzhhpSKxaJ41qmduzIFKE1LCcRk9JYpbtNeig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q7U9CS8CU+tXReWeIkpYfpjg6gMwi7gcigXicjqAzV8=;
 b=Q6ncGgLS6nvDt2MbfeGiK0Afhv4e+AgFORv94cOuf3Sa/dDAwPsfW1FsSVj4zYViaOx7u4LZ8wi5yOaSCuF9qDUEYFXVyD4X1Tu/ubC1/D+/YOvllNN0gtQvJMzfceXS3vDNsTYjai2cNyG/61D7So1LqpVEjAZ4NOSw+aiaTPQbKhSPNoZsqvhXSVpkj3n7Ov+o2H+liBdy4C3koM7jbBaIlervkv7NOrmt+3FbJYvbLa98PjRx7ekElETQlF5PbEKcdWZPsL1HCU5uWm35tjNks1WilV3kYto8utvvgvNbcAZGfZaojNm5Q05djFH8WENOONSggEAfqsXhThhQHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q7U9CS8CU+tXReWeIkpYfpjg6gMwi7gcigXicjqAzV8=;
 b=P/B0sAzqfMGlQvHlSB+rX2gj4Sm6IiXcYqN5g8lAZ/xxqqzZYFcJwNRHiKCmmxXFYizk+3X7N3wPmz3AfLRAhEl3AauGGNtCFv0uo5AabQDIrFW4Rk9HSJd/2KXbJ3gWhi76wFvTJuqEreO1mspl5nymSd7zqzLmFJV+KnzqCDU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Joseph.Greathouse@amd.com; 
Received: from CY4PR1201MB2471.namprd12.prod.outlook.com (10.172.116.10) by
 CY4PR1201MB2517.namprd12.prod.outlook.com (10.172.121.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.9; Fri, 17 Jan 2020 21:39:30 +0000
Received: from CY4PR1201MB2471.namprd12.prod.outlook.com
 ([fe80::297a:4763:6e7f:bbce]) by CY4PR1201MB2471.namprd12.prod.outlook.com
 ([fe80::297a:4763:6e7f:bbce%11]) with mapi id 15.20.2644.023; Fri, 17 Jan
 2020 21:39:30 +0000
From: Joseph Greathouse <Joseph.Greathouse@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v2] drm/amdkfd: Enable GWS based on FW Support
Date: Fri, 17 Jan 2020 15:39:01 -0600
Message-Id: <20200117213901.85592-1-Joseph.Greathouse@amd.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20200117212446.65002-1-Joseph.Greathouse@amd.com>
References: <20200117212446.65002-1-Joseph.Greathouse@amd.com>
X-ClientProxiedBy: DM6PR03CA0018.namprd03.prod.outlook.com
 (2603:10b6:5:40::31) To CY4PR1201MB2471.namprd12.prod.outlook.com
 (2603:10b6:903:d0::10)
MIME-Version: 1.0
Received: from rocm-perf01.amd.com (165.204.78.2) by
 DM6PR03CA0018.namprd03.prod.outlook.com (2603:10b6:5:40::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.18 via Frontend Transport; Fri, 17 Jan 2020 21:39:29 +0000
X-Mailer: git-send-email 2.19.1
X-Originating-IP: [165.204.78.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3c358811-51fc-499a-1aad-08d79b95bbe2
X-MS-TrafficTypeDiagnostic: CY4PR1201MB2517:|CY4PR1201MB2517:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR1201MB2517FA23CDBD0474CF12B2F6F9310@CY4PR1201MB2517.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 0285201563
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(366004)(376002)(39860400002)(136003)(346002)(199004)(189003)(5660300002)(66556008)(66946007)(81166006)(8936002)(8676002)(66476007)(6666004)(81156014)(956004)(4326008)(2616005)(316002)(1076003)(16526019)(186003)(478600001)(86362001)(7696005)(52116002)(6486002)(26005)(6916009)(36756003)(2906002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CY4PR1201MB2517;
 H:CY4PR1201MB2471.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i8WRxzq4AKSVnYcmSfKLf+bGisCSNkqsIYrWIo1/NastqxK7QOV/F6384bpdBTE9u5UQiWK41ElinCtpzo4lANkuxYIadgfWYWFrLoG5/HTEQ0y0nhU562MU2VwCjsKLfmeDoYYBvLhCaT2vjzhVnZMKsiYi4d3OP7HavOHvEe9jeS0roKcMkPDVX+T8OZUgRauKp+k6rZ7u1DZf9dobPROyz0b5+8uq14M2scyIhmxAXXBtDbhc9sJHaG/Odv02Y41YY25kJWShwSeMFeB6X6IqkeWZ00O+zdf5N20vZic+5kJwAZQpe00VxmvBvxeQip5tRUu/Gsg+hHD+HTdMNe3sZCJAqMk5iqOlLFQWIo8xb3lHv7LygFF4+OZq85TNvl8LwrojCqJb1u9Stg+mQ4rxnCKN+2Vu5Pzk9TBAbNz2bzQ/NN9qX081ncBk3Z9V
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c358811-51fc-499a-1aad-08d79b95bbe2
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2020 21:39:30.4112 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eRqt2KOJx6Lph19TIZVXcMPa+Y1QYoWIpb2LkRUk1txJqZl143XCLU6Un4V0Pa1oDDCu7IXl4+8qwSfM9Jo0Kg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB2517
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
Cc: Joseph Greathouse <Joseph.Greathouse@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Rather than only enabling GWS support based on the hws_gws_support
modparm, also check whether the GPU's HWS firmware supports GWS.
Leave the old modparm in place in case users want to test GWS
on GPUs not yet in the support list.

v2: fix broken syntax from the first patch.

Change-Id: Ife6833c2d571f5e7fe0726f9340649ce0ef10443
Signed-off-by: Joseph Greathouse <Joseph.Greathouse@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c   |  7 ++--
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c  |  8 +++--
 drivers/gpu/drm/amd/amdkfd/kfd_device.c   | 40 ++++++++++++++++++-----
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h     |  1 +
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c |  2 +-
 5 files changed, 41 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 137e76f0e3db..f28d040de3ce 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -688,13 +688,12 @@ MODULE_PARM_DESC(halt_if_hws_hang, "Halt if HWS hang is detected (0 = off (defau
 
 /**
  * DOC: hws_gws_support(bool)
- * Whether HWS support gws barriers. Default value: false (not supported)
- * This will be replaced with a MEC firmware version check once firmware
- * is ready
+ * Assume that HWS supports GWS barriers regardless of what firmware version
+ * check says. Default value: false (rely on MEC2 firmware version check).
  */
 bool hws_gws_support;
 module_param(hws_gws_support, bool, 0444);
-MODULE_PARM_DESC(hws_gws_support, "MEC FW support gws barriers (false = not supported (Default), true = supported)");
+MODULE_PARM_DESC(hws_gws_support, "Assume MEC2 FW supports GWS barriers (false = rely on FW version check (Default), true = force supported)");
 
 /**
   * DOC: queue_preemption_timeout_ms (int)
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 1aebda4bbbe7..275f79ab0900 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -1590,9 +1590,6 @@ static int kfd_ioctl_alloc_queue_gws(struct file *filep,
 	struct queue *q;
 	struct kfd_dev *dev;
 
-	if (!hws_gws_support)
-		return -ENODEV;
-
 	mutex_lock(&p->mutex);
 	q = pqm_get_user_queue(&p->pqm, args->queue_id);
 
@@ -1603,6 +1600,11 @@ static int kfd_ioctl_alloc_queue_gws(struct file *filep,
 		goto out_unlock;
 	}
 
+	if (!dev->gws) {
+		retval = -ENODEV;
+		goto out_unlock;
+	}
+
 	if (dev->dqm->sched_policy == KFD_SCHED_POLICY_NO_HWS) {
 		retval = -ENODEV;
 		goto out_unlock;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index 2a9e40131735..798ad1c8f799 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -569,6 +569,23 @@ static void kfd_cwsr_init(struct kfd_dev *kfd)
 	}
 }
 
+static int kfd_gws_init(struct kfd_dev *kfd)
+{
+	int ret = 0;
+
+	if (kfd->dqm->sched_policy == KFD_SCHED_POLICY_NO_HWS)
+		return 0;
+
+	if (hws_gws_support
+		|| (kfd->device_info->asic_family >= CHIP_VEGA10
+			&& kfd->device_info->asic_family <= CHIP_RAVEN
+			&& kfd->mec2_fw_version >= 0x1b3))
+		ret = amdgpu_amdkfd_alloc_gws(kfd->kgd,
+				amdgpu_amdkfd_get_num_gws(kfd->kgd), &kfd->gws);
+
+	return ret;
+}
+
 bool kgd2kfd_device_init(struct kfd_dev *kfd,
 			 struct drm_device *ddev,
 			 const struct kgd2kfd_shared_resources *gpu_resources)
@@ -578,6 +595,8 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
 	kfd->ddev = ddev;
 	kfd->mec_fw_version = amdgpu_amdkfd_get_fw_version(kfd->kgd,
 			KGD_ENGINE_MEC1);
+	kfd->mec2_fw_version = amdgpu_amdkfd_get_fw_version(kfd->kgd,
+			KGD_ENGINE_MEC2);
 	kfd->sdma_fw_version = amdgpu_amdkfd_get_fw_version(kfd->kgd,
 			KGD_ENGINE_SDMA1);
 	kfd->shared_resources = *gpu_resources;
@@ -598,13 +617,6 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
 	} else
 		kfd->max_proc_per_quantum = hws_max_conc_proc;
 
-	/* Allocate global GWS that is shared by all KFD processes */
-	if (hws_gws_support && amdgpu_amdkfd_alloc_gws(kfd->kgd,
-			amdgpu_amdkfd_get_num_gws(kfd->kgd), &kfd->gws)) {
-		dev_err(kfd_device, "Could not allocate %d gws\n",
-			amdgpu_amdkfd_get_num_gws(kfd->kgd));
-		goto out;
-	}
 	/* calculate max size of mqds needed for queues */
 	size = max_num_of_queues_per_device *
 			kfd->device_info->mqd_size_aligned;
@@ -659,6 +671,15 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
 		goto device_queue_manager_error;
 	}
 
+	/* If supported on this device, allocate global GWS that is shared
+	 * by all KFD processes
+	 */
+	if (kfd_gws_init(kfd)) {
+		dev_err(kfd_device, "Could not allocate %d gws\n",
+			amdgpu_amdkfd_get_num_gws(kfd->kgd));
+		goto gws_error;
+	}
+
 	if (kfd_iommu_device_init(kfd)) {
 		dev_err(kfd_device, "Error initializing iommuv2\n");
 		goto device_iommu_error;
@@ -688,6 +709,7 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
 kfd_topology_add_device_error:
 kfd_resume_error:
 device_iommu_error:
+gws_error:
 	device_queue_manager_uninit(kfd->dqm);
 device_queue_manager_error:
 	kfd_interrupt_exit(kfd);
@@ -698,7 +720,7 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
 kfd_gtt_sa_init_error:
 	amdgpu_amdkfd_free_gtt_mem(kfd->kgd, kfd->gtt_mem);
 alloc_gtt_mem_failure:
-	if (hws_gws_support)
+	if (kfd->gws)
 		amdgpu_amdkfd_free_gws(kfd->kgd, kfd->gws);
 	dev_err(kfd_device,
 		"device %x:%x NOT added due to errors\n",
@@ -717,7 +739,7 @@ void kgd2kfd_device_exit(struct kfd_dev *kfd)
 		kfd_doorbell_fini(kfd);
 		kfd_gtt_sa_fini(kfd);
 		amdgpu_amdkfd_free_gtt_mem(kfd->kgd, kfd->gtt_mem);
-		if (hws_gws_support)
+		if (kfd->gws)
 			amdgpu_amdkfd_free_gws(kfd->kgd, kfd->gws);
 	}
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 8ac680dc90f1..c0b0defc8f7a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -281,6 +281,7 @@ struct kfd_dev {
 
 	/* Firmware versions */
 	uint16_t mec_fw_version;
+	uint16_t mec2_fw_version;
 	uint16_t sdma_fw_version;
 
 	/* Maximum process number mapped to HW scheduler */
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
index 203c823d65f1..43a82cf76628 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -1315,7 +1315,7 @@ int kfd_topology_add_device(struct kfd_dev *gpu)
 				gpu->device_info->num_xgmi_sdma_engines;
 	dev->node_props.num_sdma_queues_per_engine =
 				gpu->device_info->num_sdma_queues_per_engine;
-	dev->node_props.num_gws = (hws_gws_support &&
+	dev->node_props.num_gws = (dev->gpu->gws &&
 		dev->gpu->dqm->sched_policy != KFD_SCHED_POLICY_NO_HWS) ?
 		amdgpu_amdkfd_get_num_gws(dev->gpu->kgd) : 0;
 	dev->node_props.num_cp_queues = get_queues_num(dev->gpu->dqm);
-- 
2.19.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
