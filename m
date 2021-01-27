Return-Path: <SRS0=2QJd=G6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98C5DC433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Jan 2021 10:14:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E98B20723
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Jan 2021 10:14:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E98B20723
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 85E506E2EF;
	Wed, 27 Jan 2021 10:14:55 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2050.outbound.protection.outlook.com [40.107.243.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC2836E2EF
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Jan 2021 10:14:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nPKkBaVW4D2Hmzx8zGYJPwFchCg2Y2yPQEwSyWwUoRZp/XninnUsX+Rn4sPK9QKGhP7my8VLSG9Y2lqR0hjALKqsN5Yb+Yt3WWPcvk2pru4gwrtA4SeqqEmuundonAkIEjrlYGYXDBfsFQ23TMC2AjpUrA/jVzP54VZQYG9Emu9BGOKUv9Bbg1zmT/mJS/GwPtnzI0vb+RI19ziNdWtSKSz+4jaOgJ8GdkONM6bjHPdEwanPN3CKDau1spRw1phIa5cNhtZtRWcWVs06rUhKGEwh0ykyGW/vuBiU7hTqRkh4XQVHtcWbhJL3MGoz8hVFaekKymlOftMgUzwJtojtjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6re3ob6qktCGGOo5zjH4fWklDT/NY3fHYQdqWq+VlKo=;
 b=IGkr4xK6+sfhIRF8W/jIMJDza09vyvtwFfOVnqk2SOQmhJNAaF2o2hdWYZ1xROvspmm3fXTphEbRFLbunsVhd58uOHWn3jIqeu3xpeiMNnAJ2mWW9WaZuZc9xVa2r7Jw/D8EbNGqLPpbEy0jvBsfi6V5EY6HvzZZtS9gDyFZXJ4DHTiZh9v73gLMGc1/klOydXeN6y6Z4qZhQJj7yiwrHQ7ejajCoF7Vm5oUdGDtrca4mMCM6ug/0Gpo1pKoJpMz+gcKqXlvWpDOylhzc2srSSjotS1spBVpNwHQQnws3ZUEO9lkdcQYbVUHQ/u8FYOrqSJiaGo7ksuMjTjsebt9Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6re3ob6qktCGGOo5zjH4fWklDT/NY3fHYQdqWq+VlKo=;
 b=TQfNUHsFUwAwCerBQaHKaGVp1If1CT8kPW74I7/cCOKuLe0OiVOGqwkiKCvX7dQzHLnlGxC+0D752fbMEJ0xOGh+zD4/ecrIYDWgRMDt8VeCzRiGszfXVbbeLYfChLrhgGogrnvBQGYrIhrTiDpFLFSOlXPnCmp/F2leatddrFA=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1305.namprd12.prod.outlook.com (2603:10b6:3:75::20) by
 DM6PR12MB4580.namprd12.prod.outlook.com (2603:10b6:5:2a8::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3784.12; Wed, 27 Jan 2021 10:14:52 +0000
Received: from DM5PR12MB1305.namprd12.prod.outlook.com
 ([fe80::71be:7ead:41a7:271a]) by DM5PR12MB1305.namprd12.prod.outlook.com
 ([fe80::71be:7ead:41a7:271a%6]) with mapi id 15.20.3805.016; Wed, 27 Jan 2021
 10:14:52 +0000
From: Lang Yu <Lang.Yu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/amdkfd: adjust dummy functions ' placement
Date: Wed, 27 Jan 2021 18:14:03 +0800
Message-Id: <20210127101403.3059897-1-Lang.Yu@amd.com>
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [180.167.199.189]
X-ClientProxiedBy: HK2PR02CA0222.apcprd02.prod.outlook.com
 (2603:1096:201:20::34) To DM5PR12MB1305.namprd12.prod.outlook.com
 (2603:10b6:3:75::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from lang-desktop.amd.com (180.167.199.189) by
 HK2PR02CA0222.apcprd02.prod.outlook.com (2603:1096:201:20::34) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3784.12 via Frontend Transport; Wed, 27 Jan 2021 10:14:50 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 31fa6b34-8961-4e09-fed3-08d8c2ac62cc
X-MS-TrafficTypeDiagnostic: DM6PR12MB4580:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4580411C8A216075E6ACA648FBBB9@DM6PR12MB4580.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:597;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MYmcoaFpk+JxYtd/E0KFJyqrtUtIKOVQLwS1yd+SvUCOa8yIN8AHTflwtsXOUVncAs37+epo/DHM6c/8OAwAFa6e9iqEvT7f1Wokmf5qJPisoLcUf7z2kQ6X+hCqdJ6fwdthKtRt5Wjd5CbcpvVRjt5xlD6DLPcxCgRz5UbYsk0DvnEyRLYrnnBnSwiMS09iDTsJ/UUzlD4Y4OnOCez5S1dEEJ1HuJqU6cUC/4NbQv03RafoIGbgmEaez204tASaT8f/wZrboGv9YxifNeu5txFYmDHFHtG2FejeYNBbz365gneHN+ykLg6wDKKRH6gL0Wn9LqYQBqku6eYt1M1Onw47Scc1kVT6Rlb+4GXzqarvtLkXcG2A6uyrl/7T841IbfrRT1JD7/GQBjdEypNySJNfF0FzJpgn3AuJG01nu9HJi2cOqlXFjKTDbdJteejxKzBzyPQr2Itgz32PIxbPABIesmyA/syi/BpPyD5UG1ZimMt8875L6x46ZlJeasvSHiXSSSMsthUaKSIuWxO+aQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1305.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(376002)(366004)(136003)(39860400002)(8936002)(66556008)(36756003)(86362001)(5660300002)(16526019)(52116002)(316002)(66946007)(54906003)(7696005)(66476007)(26005)(4326008)(6916009)(478600001)(2616005)(6666004)(956004)(6486002)(83380400001)(2906002)(8676002)(1076003)(186003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?YDPU5p99iFDr6IFty11HEG/LRvRVInYHxbEkUhPV+1xs5s6HCwZwmh6YYtcB?=
 =?us-ascii?Q?PsobjZiZOI8dJQ4izP4kF1hCfjezoRJviWjdQmlgRsk9VCaJE0mnIFbI5kEl?=
 =?us-ascii?Q?Q7+CN7X1JeVy6fD/8usB9vxciyNR/WTCu78MaRcN6zI1Ng4VUVDFQheDOqbI?=
 =?us-ascii?Q?e+72w1hFL5ck/75/CCzuu3BI1eWhKLSWO0Az1wZp9rib3uO2fRgNs5gBO8Bz?=
 =?us-ascii?Q?6iR+nl7fCB/NXZ9UB67Fx5gOqq9fk6hvrlNkNt8mieNmkU/x0w5CxYBeAl9O?=
 =?us-ascii?Q?ZJ76E633sgoCSICGuXTUHyLO4tXtY3e948MRPahYorPc+yMfp2wz3S77iZQk?=
 =?us-ascii?Q?2ePMITuoxtI0SNWfb0D4G+rWx9ZconAXgtXi7K9T6iQ7S+neapgGKCI8hlo7?=
 =?us-ascii?Q?bzODcX/UX6bwofBYKIUPQuz0PQix09aovxhK4SuzAPDv0KLWIxP/UdJ5h/ww?=
 =?us-ascii?Q?NyEFiw1Sicf0UBG6IGl0VGtMu6x+bsSZ7uHQ3gkBr04U0r1DeJozi4M9QYa8?=
 =?us-ascii?Q?a5vce+qIFLkz9gxMBCEjNMC9v0Nn28J08znRAQow0aZ8EajOaYU42HvLQxQD?=
 =?us-ascii?Q?r/5mOg3hB7LxvpwYnmaFn0Omlr+OKYKmqKPivcEDHybg6SPkHv99TlZW2l5l?=
 =?us-ascii?Q?XYs2OxeBh5ych3iTwKSGXvyVSVMxCq9lF5dfMPjyEImeeaPDEyLJO3sLae4C?=
 =?us-ascii?Q?xEkWqyGG5fFLEdr8zJp2ZLSxgyUdcGQ/RsmjIQlJ+8rGvpMFiZF40abQVKjI?=
 =?us-ascii?Q?mUl26HbcK2p1kQ7GTl/QM8rSYPA/iR2EpwowkHvvlgRp59NEg11o0PTEcYqB?=
 =?us-ascii?Q?uK6h+gbmc3qlxOOzGDu2L0NS/Zcgdp6xYEUinXmF7ll887yUyj4IGbe/egtH?=
 =?us-ascii?Q?cM7IEC3TPjhNGPy5ODmeMm6pIEQQ77ZvyKf4qHGw1qFQ0RVDhFZqclEau9J+?=
 =?us-ascii?Q?FDuakAmvOoru+EocLNP4KrTgrqvRGErJXqC5543UVPNdzjCBVjuGI1bHDyUr?=
 =?us-ascii?Q?AqA7veeg+ezG8CUJNlqHKeyL7xncFxiiWS5onMI7WCOfk8NNPUV6WLLKaIQi?=
 =?us-ascii?Q?c0XpcSVz9bofZaVXNT/Rt1idxaiFSw=3D=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31fa6b34-8961-4e09-fed3-08d8c2ac62cc
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1305.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2021 10:14:52.4228 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RB4h4r3qeqDGq8yCJoS/t+xKCXOumIu2E4JP7rs2UVVQi2ikghVlNK8o/N6pAqDFTKhGqmp6MbWdghRwJy5hvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4580
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>, Huang Rui <ray.huang@amd.com>,
 Lang Yu <Lang.Yu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Move all the dummy functions in amdgpu_amdkfd.c to
amdgpu_amdkfd.h as inline functions.

Signed-off-by: Lang Yu <Lang.Yu@amd.com>
Suggested-by: Felix Kuehling <Felix.Kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c |  87 ------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h | 151 ++++++++++++++++++---
 2 files changed, 130 insertions(+), 108 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index db96d69eb45e..c5343a5eecbe 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -47,12 +47,8 @@ int amdgpu_amdkfd_init(void)
 	amdgpu_amdkfd_total_mem_size = si.totalram - si.totalhigh;
 	amdgpu_amdkfd_total_mem_size *= si.mem_unit;
 
-#ifdef CONFIG_HSA_AMD
 	ret = kgd2kfd_init();
 	amdgpu_amdkfd_gpuvm_init_mem_limits();
-#else
-	ret = -ENOENT;
-#endif
 	kfd_initialized = !ret;
 
 	return ret;
@@ -696,86 +692,3 @@ bool amdgpu_amdkfd_have_atomics_support(struct kgd_dev *kgd)
 
 	return adev->have_atomics_support;
 }
-
-#ifndef CONFIG_HSA_AMD
-bool amdkfd_fence_check_mm(struct dma_fence *f, struct mm_struct *mm)
-{
-	return false;
-}
-
-void amdgpu_amdkfd_unreserve_memory_limit(struct amdgpu_bo *bo)
-{
-}
-
-int amdgpu_amdkfd_remove_fence_on_pt_pd_bos(struct amdgpu_bo *bo)
-{
-	return 0;
-}
-
-void amdgpu_amdkfd_gpuvm_destroy_cb(struct amdgpu_device *adev,
-					struct amdgpu_vm *vm)
-{
-}
-
-struct amdgpu_amdkfd_fence *to_amdgpu_amdkfd_fence(struct dma_fence *f)
-{
-	return NULL;
-}
-
-int amdgpu_amdkfd_evict_userptr(struct kgd_mem *mem, struct mm_struct *mm)
-{
-	return 0;
-}
-
-struct kfd_dev *kgd2kfd_probe(struct kgd_dev *kgd, struct pci_dev *pdev,
-			      unsigned int asic_type, bool vf)
-{
-	return NULL;
-}
-
-bool kgd2kfd_device_init(struct kfd_dev *kfd,
-			 struct drm_device *ddev,
-			 const struct kgd2kfd_shared_resources *gpu_resources)
-{
-	return false;
-}
-
-void kgd2kfd_device_exit(struct kfd_dev *kfd)
-{
-}
-
-void kgd2kfd_exit(void)
-{
-}
-
-void kgd2kfd_suspend(struct kfd_dev *kfd, bool run_pm)
-{
-}
-
-int kgd2kfd_resume(struct kfd_dev *kfd, bool run_pm)
-{
-	return 0;
-}
-
-int kgd2kfd_pre_reset(struct kfd_dev *kfd)
-{
-	return 0;
-}
-
-int kgd2kfd_post_reset(struct kfd_dev *kfd)
-{
-	return 0;
-}
-
-void kgd2kfd_interrupt(struct kfd_dev *kfd, const void *ih_ring_entry)
-{
-}
-
-void kgd2kfd_set_sram_ecc_flag(struct kfd_dev *kfd)
-{
-}
-
-void kgd2kfd_smi_event_throttle(struct kfd_dev *kfd, uint32_t throttle_bitmask)
-{
-}
-#endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index bc9f0e42e0a2..c3a51c0d54e9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -94,11 +94,6 @@ enum kgd_engine_type {
 	KGD_ENGINE_MAX
 };
 
-struct amdgpu_amdkfd_fence *amdgpu_amdkfd_fence_create(u64 context,
-						       struct mm_struct *mm);
-bool amdkfd_fence_check_mm(struct dma_fence *f, struct mm_struct *mm);
-struct amdgpu_amdkfd_fence *to_amdgpu_amdkfd_fence(struct dma_fence *f);
-int amdgpu_amdkfd_remove_fence_on_pt_pd_bos(struct amdgpu_bo *bo);
 
 struct amdkfd_process_info {
 	/* List head of all VMs that belong to a KFD process */
@@ -132,8 +127,6 @@ void amdgpu_amdkfd_interrupt(struct amdgpu_device *adev,
 void amdgpu_amdkfd_device_probe(struct amdgpu_device *adev);
 void amdgpu_amdkfd_device_init(struct amdgpu_device *adev);
 void amdgpu_amdkfd_device_fini(struct amdgpu_device *adev);
-
-int amdgpu_amdkfd_evict_userptr(struct kgd_mem *mem, struct mm_struct *mm);
 int amdgpu_amdkfd_submit_ib(struct kgd_dev *kgd, enum kgd_engine_type engine,
 				uint32_t vmid, uint64_t gpu_addr,
 				uint32_t *ib_cmd, uint32_t ib_len);
@@ -153,6 +146,38 @@ void amdgpu_amdkfd_gpu_reset(struct kgd_dev *kgd);
 int amdgpu_queue_mask_bit_to_set_resource_bit(struct amdgpu_device *adev,
 					int queue_bit);
 
+struct amdgpu_amdkfd_fence *amdgpu_amdkfd_fence_create(u64 context,
+						       struct mm_struct *mm);
+#if IS_ENABLED(CONFIG_HSA_AMD)
+bool amdkfd_fence_check_mm(struct dma_fence *f, struct mm_struct *mm);
+struct amdgpu_amdkfd_fence *to_amdgpu_amdkfd_fence(struct dma_fence *f);
+int amdgpu_amdkfd_remove_fence_on_pt_pd_bos(struct amdgpu_bo *bo);
+int amdgpu_amdkfd_evict_userptr(struct kgd_mem *mem, struct mm_struct *mm);
+#else
+static inline
+bool amdkfd_fence_check_mm(struct dma_fence *f, struct mm_struct *mm)
+{
+	return false;
+}
+
+static inline
+struct amdgpu_amdkfd_fence *to_amdgpu_amdkfd_fence(struct dma_fence *f)
+{
+	return NULL;
+}
+
+static inline
+int amdgpu_amdkfd_remove_fence_on_pt_pd_bos(struct amdgpu_bo *bo)
+{
+	return 0;
+}
+
+static inline
+int amdgpu_amdkfd_evict_userptr(struct kgd_mem *mem, struct mm_struct *mm)
+{
+	return 0;
+}
+#endif
 /* Shared API */
 int amdgpu_amdkfd_alloc_gtt_mem(struct kgd_dev *kgd, size_t size,
 				void **mem_obj, uint64_t *gpu_addr,
@@ -215,8 +240,6 @@ int amdgpu_amdkfd_gpuvm_acquire_process_vm(struct kgd_dev *kgd,
 					struct file *filp, unsigned int pasid,
 					void **vm, void **process_info,
 					struct dma_fence **ef);
-void amdgpu_amdkfd_gpuvm_destroy_cb(struct amdgpu_device *adev,
-				struct amdgpu_vm *vm);
 void amdgpu_amdkfd_gpuvm_destroy_process_vm(struct kgd_dev *kgd, void *vm);
 void amdgpu_amdkfd_gpuvm_release_process_vm(struct kgd_dev *kgd, void *vm);
 uint64_t amdgpu_amdkfd_gpuvm_get_process_page_dir(void *vm);
@@ -236,23 +259,46 @@ int amdgpu_amdkfd_gpuvm_map_gtt_bo_to_kernel(struct kgd_dev *kgd,
 		struct kgd_mem *mem, void **kptr, uint64_t *size);
 int amdgpu_amdkfd_gpuvm_restore_process_bos(void *process_info,
 					    struct dma_fence **ef);
-
 int amdgpu_amdkfd_gpuvm_get_vm_fault_info(struct kgd_dev *kgd,
 					      struct kfd_vm_fault_info *info);
-
 int amdgpu_amdkfd_gpuvm_import_dmabuf(struct kgd_dev *kgd,
 				      struct dma_buf *dmabuf,
 				      uint64_t va, void *vm,
 				      struct kgd_mem **mem, uint64_t *size,
 				      uint64_t *mmap_offset);
-
-void amdgpu_amdkfd_gpuvm_init_mem_limits(void);
-void amdgpu_amdkfd_unreserve_memory_limit(struct amdgpu_bo *bo);
-
 int amdgpu_amdkfd_get_tile_config(struct kgd_dev *kgd,
 				struct tile_config *config);
-
+#if IS_ENABLED(CONFIG_HSA_AMD)
+void amdgpu_amdkfd_gpuvm_init_mem_limits(void);
+void amdgpu_amdkfd_gpuvm_destroy_cb(struct amdgpu_device *adev,
+				struct amdgpu_vm *vm);
+void amdgpu_amdkfd_unreserve_memory_limit(struct amdgpu_bo *bo);
+#else
+static inline
+void amdgpu_amdkfd_gpuvm_init_mem_limits(void)
+{
+		return;
+}
+
+static inline
+void amdgpu_amdkfd_gpuvm_destroy_cb(struct amdgpu_device *adev,
+					struct amdgpu_vm *vm)
+{
+		return;
+}
+
+static inline
+void amdgpu_amdkfd_unreserve_memory_limit(struct amdgpu_bo *bo)
+{
+		return;
+}
+#endif
 /* KGD2KFD callbacks */
+int kgd2kfd_quiesce_mm(struct mm_struct *mm);
+int kgd2kfd_resume_mm(struct mm_struct *mm);
+int kgd2kfd_schedule_evict_and_restore_process(struct mm_struct *mm,
+						struct dma_fence *fence);
+#if IS_ENABLED(CONFIG_HSA_AMD)
 int kgd2kfd_init(void);
 void kgd2kfd_exit(void);
 struct kfd_dev *kgd2kfd_probe(struct kgd_dev *kgd, struct pci_dev *pdev,
@@ -266,11 +312,74 @@ int kgd2kfd_resume(struct kfd_dev *kfd, bool run_pm);
 int kgd2kfd_pre_reset(struct kfd_dev *kfd);
 int kgd2kfd_post_reset(struct kfd_dev *kfd);
 void kgd2kfd_interrupt(struct kfd_dev *kfd, const void *ih_ring_entry);
-int kgd2kfd_quiesce_mm(struct mm_struct *mm);
-int kgd2kfd_resume_mm(struct mm_struct *mm);
-int kgd2kfd_schedule_evict_and_restore_process(struct mm_struct *mm,
-					       struct dma_fence *fence);
 void kgd2kfd_set_sram_ecc_flag(struct kfd_dev *kfd);
 void kgd2kfd_smi_event_throttle(struct kfd_dev *kfd, uint32_t throttle_bitmask);
-
+#else
+static inline int kgd2kfd_init(void)
+{
+	return -ENOENT;
+}
+
+static inline void kgd2kfd_exit(void)
+{
+		return;
+}
+
+static inline
+struct kfd_dev *kgd2kfd_probe(struct kgd_dev *kgd, struct pci_dev *pdev,
+					unsigned int asic_type, bool vf)
+{
+	return NULL;
+}
+
+static inline
+bool kgd2kfd_device_init(struct kfd_dev *kfd, struct drm_device *ddev,
+				const struct kgd2kfd_shared_resources *gpu_resources)
+{
+	return false;
+}
+
+static inline void kgd2kfd_device_exit(struct kfd_dev *kfd)
+{
+		return;
+}
+
+static inline void kgd2kfd_suspend(struct kfd_dev *kfd, bool run_pm)
+{
+		return;
+}
+
+static inline int kgd2kfd_resume(struct kfd_dev *kfd, bool run_pm)
+{
+	return 0;
+}
+
+static inline int kgd2kfd_pre_reset(struct kfd_dev *kfd)
+{
+	return 0;
+}
+
+static inline int kgd2kfd_post_reset(struct kfd_dev *kfd)
+{
+	return 0;
+}
+
+static inline
+void kgd2kfd_interrupt(struct kfd_dev *kfd, const void *ih_ring_entry)
+{
+		return;
+}
+
+static inline
+void kgd2kfd_set_sram_ecc_flag(struct kfd_dev *kfd)
+{
+		return;
+}
+
+static inline
+void kgd2kfd_smi_event_throttle(struct kfd_dev *kfd, uint32_t throttle_bitmask)
+{
+		return;
+}
+#endif
 #endif /* AMDGPU_AMDKFD_H_INCLUDED */
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
