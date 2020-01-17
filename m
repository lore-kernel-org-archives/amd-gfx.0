Return-Path: <SRS0=QkQq=3G=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED4ADC33C9E
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Jan 2020 21:25:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BAF202072E
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Jan 2020 21:25:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="qeV1RZqC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAF202072E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B8DD6F929;
	Fri, 17 Jan 2020 21:25:06 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2072.outbound.protection.outlook.com [40.107.237.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C67B56F92F
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Jan 2020 21:25:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ibUz+7bNwtr5ux9vw/GowVKft/U8PG3U4lQUv4Ql/8GaiarzurqwxiUxdEKC/ZmPF35ttkKb4pr22SUj6LaVspMV+jLkHO7wvJGQ8fK2+vpWJlJvndZX1a9V3+sEgiMu9et7wFmw5Jf5+OTvjawm2+ZdHPf379mygLGBf1FVDnAPVM2dtCAx0wTmrHPS/UXym2wcIsOsgkDx8TD/IDk0yosdfqNrmEj0gFKumGLoca6+OC9Wfv0+CNXAX+ERyHmpjTwHgczuNUGdsTGSRshlPlIQ+fscpu5v+6X+m291pN60k1ejlXMyBVDS8xsS7dljjcr6Z4DQk/1SjnTnGfh9aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fT7ob+rfWByZDKeks8KNjV/0KlesTGg3wvU0njTya/Q=;
 b=A2SUNz2dPUr1KqrkePpLfOLR/zqBz0/5vc2ZXlGofF1tHB2ksXOKo8evC0/5EXnhE7XfR+zioXzSLB280kl6Rnha5Ismr0z0eTtlQ6mBP/akhOhctkkj73855ywamvMKsNFzpFr1S+vyV4oEmLrSd0wXobCYiGu3CCSKLRC1XH+tQwVwHt+TopkHH16c9SjtNqAloET1gPqjualIU91R9NK4xTXmC10BMxLE0yjiGmpeAiU7lFXtmTDb08nRUl7wKea38i3IYh88jmXR9H5O3QEnFdPc38z1Z2KgZI41oQIH5lC8BVXTz/czlPjb89Oxn8r7BM3SLSx1cAwjNYTslw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fT7ob+rfWByZDKeks8KNjV/0KlesTGg3wvU0njTya/Q=;
 b=qeV1RZqCfsFOuJGxENlj8O5XC+CrnFVsxLwzPqtLs9CWSqrONRLqvZYtKeZvUPpr1VNhdFteUu0Bz+o7KjC9Gl5a53tJclYfSDiX0PP2ZKJkqb3Nr7aF8vNijHBAJvgwrhjt3PmBqsA/9qCiz8fsYQc3DHvU3QQG801h7CcgPfw=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Joseph.Greathouse@amd.com; 
Received: from CY4PR1201MB2471.namprd12.prod.outlook.com (10.172.116.10) by
 CY4PR1201MB0165.namprd12.prod.outlook.com (10.172.78.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.23; Fri, 17 Jan 2020 21:25:03 +0000
Received: from CY4PR1201MB2471.namprd12.prod.outlook.com
 ([fe80::297a:4763:6e7f:bbce]) by CY4PR1201MB2471.namprd12.prod.outlook.com
 ([fe80::297a:4763:6e7f:bbce%11]) with mapi id 15.20.2644.023; Fri, 17 Jan
 2020 21:25:03 +0000
From: Joseph Greathouse <Joseph.Greathouse@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdkfd: Enable GWS based on FW Support
Date: Fri, 17 Jan 2020 15:24:46 -0600
Message-Id: <20200117212446.65002-1-Joseph.Greathouse@amd.com>
X-Mailer: git-send-email 2.19.1
X-ClientProxiedBy: SN6PR05CA0034.namprd05.prod.outlook.com
 (2603:10b6:805:de::47) To CY4PR1201MB2471.namprd12.prod.outlook.com
 (2603:10b6:903:d0::10)
MIME-Version: 1.0
Received: from rocm-perf01.amd.com (165.204.78.2) by
 SN6PR05CA0034.namprd05.prod.outlook.com (2603:10b6:805:de::47) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.11 via Frontend Transport; Fri, 17 Jan 2020 21:25:03 +0000
X-Mailer: git-send-email 2.19.1
X-Originating-IP: [165.204.78.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a961d1ff-ea80-4967-fdda-08d79b93b755
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0165:|CY4PR1201MB0165:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR1201MB01650DCA2DF5E8ADC85436A5F9310@CY4PR1201MB0165.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 0285201563
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(376002)(136003)(396003)(39860400002)(366004)(199004)(189003)(16526019)(7696005)(52116002)(316002)(66946007)(26005)(478600001)(186003)(66476007)(66556008)(4326008)(956004)(2906002)(5660300002)(2616005)(8676002)(6486002)(36756003)(86362001)(81166006)(81156014)(6916009)(6666004)(8936002)(1076003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CY4PR1201MB0165;
 H:CY4PR1201MB2471.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oP1ktO5rQXysEERK1SETdEkA6L3K8WN5WB/qwCLEa5Kw+Ejs4INm1ytEoypoeUopeJ3528WvF5/eoDWpUL/Gt7iGI9eDt9KDixPxtAQik4Twn+fCFSG04WbbueqOXtjC7LwG9iIXshVjNoku98QEyDZN8fqzRHXHdURaD+46UK8HtlqEGbdxiCSu6ZyiVtytyTSOl9jYy4WlN+TINXfQlgJRDqkgmNKnt7XCnsiIriO8mi5IjAqrzH4oOwmjTOdJiCMNeXY50m6S6iKPn+dV+LstfYJyzhBU3hJ/TWrgrnv55t7UohizKYolzdUy3ZHZ/RzNCK1KMnNZN2+8GeYJdIk1bT/NLQOXHG9DejbzsieVZSAvX0Jy6RSSqo2V4APOMXtzhxyVbvbsSCnXFSRpPkw788De2NZG67D2G7/YwcdO9k3fOzgUEuRJkycUYXaO
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a961d1ff-ea80-4967-fdda-08d79b93b755
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2020 21:25:03.7487 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FBr8s8XXGhJb80ooIb8aDRmEXw76rm4gTTXMM9DGXS5ZfVWPBgsG16Z6bWMhqxl6Trek1V0j5yoMrFhJ/1AwDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0165
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
index 2a9e40131735..c48490019fd6 100644
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
+			&& kfd->mec2_fw_version >= 0x1b3)
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
