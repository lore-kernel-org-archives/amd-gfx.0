Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67CD4C25B7E
	for <amd-gfx@archiver.kernel.org>; Fri, 31 May 2024 15:08:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 273CF10E1AE;
	Fri, 31 May 2024 15:08:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZDhfESCF";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2071.outbound.protection.outlook.com [40.107.220.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4DFF310E1AE
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 May 2024 15:08:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AkQsO7rPy9OiFXJKGwhq5JCJkaAIVkg5IGq1vg81JD0ung6fqHuT0gOVBRBgugE5NvfeXPurLlaYnGfuXxeGF+1L4u8eT/7WEuHeEBUG48zub6tT09IUeY9FzZ08B95lcc09a1N8cXaGim1aFQ9YK8omNRtITWr6BhbfCNaFZIvpbKdh2uTRM6eAiEE+Oh7+hoNsFhAk8NMhr2s1/5JSzpjL7CGlqEBfQa31kUi3GJrpD247kWuyXGqCVocbUgtlVAn8TA9dMPNJprhvgDtlsY6glywPK3du6ULzZi3uclWUf63Hzgy86oLBfTL6CAB+SXv4MJ+TLWJiuua46maNNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hMVmVxk4XpPpVouyOXFdFDzD4s8ixcsV0iU9pdNm8gg=;
 b=MuIwfZVh67p1LzHy/D+kkMUpOqn6kfjqX3PAx6OXTG9nHjdltk/ejq/A21GUl43tnxSgJJzeUyqZhECJn1TWPManNvy89VBZg5j+nPr9a8RRkW8AFJCbp1nzqcKZAECxQwvI1eTUE6Jx67Jiu7FjZ6uLD6cAZj2vz17gOEHPcZSMOMbcivF6oZkNF4wcMQ6OSR18LX6zG5Lvnk4nCtg3c+O4XAKhYQ+osCoeTGvAAuLnptlt87ntVlo3LLdoYeBdJAWQ6uOluBPtzEGfAL3JkjsE5MWGAjA6Ovy+gX0tp3vkaYhIcUCgqEZPq1EHC5GTP0JKns6lxkQ7hk3tYqyecA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hMVmVxk4XpPpVouyOXFdFDzD4s8ixcsV0iU9pdNm8gg=;
 b=ZDhfESCFl4gpcZ2E4G6kDnGUKNLLPBrS6yCMML+f8GoploLn94GgYehpWXNol5Z58K3unu7uXR5KqBGrhjP0nUTXoQwcRM+GnErLVUtbpknQDE3puUpHrr4OLpuk1SXbtHiEt2u6BoAYUS4Wpt/8MmNQso5GROcYdGkpeHtjoFI=
Received: from BN9PR03CA0107.namprd03.prod.outlook.com (2603:10b6:408:fd::22)
 by SJ1PR12MB6265.namprd12.prod.outlook.com (2603:10b6:a03:458::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.35; Fri, 31 May
 2024 15:08:49 +0000
Received: from BN1PEPF0000468B.namprd05.prod.outlook.com
 (2603:10b6:408:fd:cafe::66) by BN9PR03CA0107.outlook.office365.com
 (2603:10b6:408:fd::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.22 via Frontend
 Transport; Fri, 31 May 2024 15:08:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF0000468B.mail.protection.outlook.com (10.167.243.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Fri, 31 May 2024 15:08:49 +0000
Received: from eric-hp-elitebook-845-g7.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 31 May 2024 10:08:48 -0500
From: Eric Huang <jinhuieric.huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harish.Kasiviswanathan@amd.com>, Eric Huang <jinhuieric.huang@amd.com>
Subject: [PATCH] drm/amdkfd: add reset cause in gpu pre-reset smi event
Date: Fri, 31 May 2024 11:08:18 -0400
Message-ID: <20240531150818.119896-1-jinhuieric.huang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468B:EE_|SJ1PR12MB6265:EE_
X-MS-Office365-Filtering-Correlation-Id: c1483867-cca9-48fc-51ea-08dc81839352
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|36860700004|82310400017|376005|1800799015; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?A7ncLklHTNpg928HNWa8mLZq1r2JEVB+Ng4SKLpqUJTSCiz/EitjJzH44Oi2?=
 =?us-ascii?Q?1oedAK2GhY//cYdMI2IWUvNxyS+2Kcj9ecuh6ZDqasEp0hsiQ1+aQGU6DwdW?=
 =?us-ascii?Q?oSU2BoYWGvlGfdSu3UQlcWUWi8LenhB961QgH/d7O0Nvf/R8CXnZ+z7PhgIP?=
 =?us-ascii?Q?gCfnf2NbhJZkb1nydd+8YSlOsK52qr2qmP+z5o38Ryu7d9LfdLcmXmhWymag?=
 =?us-ascii?Q?5PxrtX3/2a8uIAXs2vSmhEtCku6in/g6BKz6IJmaYOPv2rKwA2gGyD5HYLkC?=
 =?us-ascii?Q?iG0MnvHQAuiwJO3XYw7TZJOQOhi4+7q46mS9Ugk6x+Z9XNJe3Q3jjO05x3s5?=
 =?us-ascii?Q?64+rkmT41gH2Pgutk4qSlGjc5HvoHgASlad/DBSETGDArhUo7xQfzfy9BldR?=
 =?us-ascii?Q?BKC7+EKl0Qd9dI8gtCN+fFiuEz0H7xWJ+sFZt3qEfO3g+qcED1t4a4+D1efp?=
 =?us-ascii?Q?ARl6NrhYw8QnOUPTUra3b8A497wVe6kbJ9hut4t0yL0z6IYJ0kQLNR2+HzJu?=
 =?us-ascii?Q?7JDAhePazAGATZgTkLlT3lKWin4WrRzAV/83LLM06FikKUb8UORyf/4Fq5ou?=
 =?us-ascii?Q?Cz3AzT+Csv/stijKprFpxfFzzlD6Qo2pi40R2y+N0p62Iv9DseHBlgZ09W2c?=
 =?us-ascii?Q?gcDf7miaKP85DJqQG3y0Ve2R3bpD0TSMBKwteno0nlZULznTaKhiCVe8d3d9?=
 =?us-ascii?Q?6bp9+fbZt4s18+C6XEGPmCIUDBhWyttD6pTsZB4Hnp1VJa2hDvA38evEA+2f?=
 =?us-ascii?Q?9OGnM4kW4fce+/mf0XRwrAMCPidYGJf21qBe6VLC9OV3rGa0/w3M5zbyiSt1?=
 =?us-ascii?Q?VMOeeV9/icy8G3aJRUZzvtNkICBpQyxm4szwajb2pSszTCrTrPPPwsQ1MISV?=
 =?us-ascii?Q?/XjMq7JGjYhyLJ5090ZF2HIdH0gjSeU6r5zssMXNsXB7rAawhvPKxLqQwAZw?=
 =?us-ascii?Q?Ej5GxEVtf2hjviUdDaMO9K6tgOXai/rGn1V8Ywcaci+1yk/lkBufnilxJHRP?=
 =?us-ascii?Q?u/PLVpOSkUEyWFdA5LZ5T5qUFAy6vsZ3hHpBqmJfde/98HLHllTwmx3R8/MI?=
 =?us-ascii?Q?ZiVd/xHQvnbM4gKL/JFB5IDWvjX2jypFb3Y4XYl+a9Wgd08UmlZGff8WQ74k?=
 =?us-ascii?Q?uz9ztJ/6XFj6A3NIaJsDyHqNKNhPm/Y6Z87cLY4WcDfDBJCnYfmwD8XxtwmZ?=
 =?us-ascii?Q?r0Gi067hKyWEoBW15GocUASvP6CsnXCboRGCWQStMua6gGajfeHGQTnGcDIe?=
 =?us-ascii?Q?T2Id1rxBlnHa5sNRALeORxeGF8fKzn2fou9p9n6yKSOBHQZ5byJGEAnQY2uL?=
 =?us-ascii?Q?3wrOON2tnVEBDzwItGOLr6PFI7JNYtxTOSz17jjPPUHrYeK09KYCr92PC++Y?=
 =?us-ascii?Q?VEQ4uYYbiv5e+UxtNPZr/NQA5MiQ?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(82310400017)(376005)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2024 15:08:49.1643 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c1483867-cca9-48fc-51ea-08dc81839352
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000468B.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6265
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

reset cause is requested by customer as additional
info for gpu reset smi event.

Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c    | 34 +++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    | 17 +++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  9 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h     |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c      |  2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_device.c       |  7 +-
 .../drm/amd/amdkfd/kfd_device_queue_manager.c | 71 +++++++++++++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c   | 13 +++-
 drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h   |  5 +-
 9 files changed, 133 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index e3738d417245..3588c912214a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -125,17 +125,26 @@ static void amdgpu_doorbell_get_kfd_info(struct amdgpu_device *adev,
 static void amdgpu_amdkfd_reset_work(struct work_struct *work)
 {
 	struct amdgpu_device *adev = container_of(work, struct amdgpu_device,
-						  kfd.reset_work);
-
-	struct amdgpu_reset_context reset_context;
+						  kfd.reset_work.work);
+
+	if (adev->kfd.reset_work.reset_context) {
+		amdgpu_device_gpu_recover(
+				adev, NULL,
+				(struct amdgpu_reset_context *)
+				adev->kfd.reset_work.reset_context);
+		kfree(adev->kfd.reset_work.reset_context);
+		adev->kfd.reset_work.reset_context = NULL;
+	} else {
+		struct amdgpu_reset_context reset_context;
 
-	memset(&reset_context, 0, sizeof(reset_context));
+		memset(&reset_context, 0, sizeof(reset_context));
 
-	reset_context.method = AMD_RESET_METHOD_NONE;
-	reset_context.reset_req_dev = adev;
-	clear_bit(AMDGPU_NEED_FULL_RESET, &reset_context.flags);
+		reset_context.method = AMD_RESET_METHOD_NONE;
+		reset_context.reset_req_dev = adev;
+		clear_bit(AMDGPU_NEED_FULL_RESET, &reset_context.flags);
 
-	amdgpu_device_gpu_recover(adev, NULL, &reset_context);
+		amdgpu_device_gpu_recover(adev, NULL, &reset_context);
+	}
 }
 
 static const struct drm_client_funcs kfd_client_funcs = {
@@ -225,7 +234,7 @@ void amdgpu_amdkfd_device_init(struct amdgpu_device *adev)
 
 		amdgpu_amdkfd_total_mem_size += adev->gmc.real_vram_size;
 
-		INIT_WORK(&adev->kfd.reset_work, amdgpu_amdkfd_reset_work);
+		INIT_WORK(&adev->kfd.reset_work.work, amdgpu_amdkfd_reset_work);
 	}
 }
 
@@ -261,12 +270,13 @@ int amdgpu_amdkfd_resume(struct amdgpu_device *adev, bool run_pm)
 	return r;
 }
 
-int amdgpu_amdkfd_pre_reset(struct amdgpu_device *adev)
+int amdgpu_amdkfd_pre_reset(struct amdgpu_device *adev,
+			    struct amdgpu_reset_context *reset_context)
 {
 	int r = 0;
 
 	if (adev->kfd.dev)
-		r = kgd2kfd_pre_reset(adev->kfd.dev);
+		r = kgd2kfd_pre_reset(adev->kfd.dev, reset_context);
 
 	return r;
 }
@@ -285,7 +295,7 @@ void amdgpu_amdkfd_gpu_reset(struct amdgpu_device *adev)
 {
 	if (amdgpu_device_should_recover_gpu(adev))
 		amdgpu_reset_domain_schedule(adev->reset_domain,
-					     &adev->kfd.reset_work);
+					     &adev->kfd.reset_work.work);
 }
 
 int amdgpu_amdkfd_alloc_gtt_mem(struct amdgpu_device *adev, size_t size,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index 1de021ebdd46..1fc9ed33a1c2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -47,6 +47,7 @@ enum TLB_FLUSH_TYPE {
 };
 
 struct amdgpu_device;
+struct amdgpu_reset_context;
 
 enum kfd_mem_attachment_type {
 	KFD_MEM_ATT_SHARED,	/* Share kgd_mem->bo or another attachment's */
@@ -98,12 +99,17 @@ struct amdgpu_amdkfd_fence {
 	struct svm_range_bo *svm_bo;
 };
 
+struct kfd_reset_work {
+	struct work_struct work;
+	void *reset_context;
+};
+
 struct amdgpu_kfd_dev {
 	struct kfd_dev *dev;
 	int64_t vram_used[MAX_XCP];
 	uint64_t vram_used_aligned[MAX_XCP];
 	bool init_complete;
-	struct work_struct reset_work;
+	struct kfd_reset_work reset_work;
 
 	/* HMM page migration MEMORY_DEVICE_PRIVATE mapping */
 	struct dev_pagemap pgmap;
@@ -170,7 +176,8 @@ bool amdgpu_amdkfd_have_atomics_support(struct amdgpu_device *adev);
 
 bool amdgpu_amdkfd_is_kfd_vmid(struct amdgpu_device *adev, u32 vmid);
 
-int amdgpu_amdkfd_pre_reset(struct amdgpu_device *adev);
+int amdgpu_amdkfd_pre_reset(struct amdgpu_device *adev,
+			    struct amdgpu_reset_context *reset_context);
 
 int amdgpu_amdkfd_post_reset(struct amdgpu_device *adev);
 
@@ -416,7 +423,8 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
 void kgd2kfd_device_exit(struct kfd_dev *kfd);
 void kgd2kfd_suspend(struct kfd_dev *kfd, bool run_pm);
 int kgd2kfd_resume(struct kfd_dev *kfd, bool run_pm);
-int kgd2kfd_pre_reset(struct kfd_dev *kfd);
+int kgd2kfd_pre_reset(struct kfd_dev *kfd,
+		      struct amdgpu_reset_context *reset_context);
 int kgd2kfd_post_reset(struct kfd_dev *kfd);
 void kgd2kfd_interrupt(struct kfd_dev *kfd, const void *ih_ring_entry);
 void kgd2kfd_set_sram_ecc_flag(struct kfd_dev *kfd);
@@ -459,7 +467,8 @@ static inline int kgd2kfd_resume(struct kfd_dev *kfd, bool run_pm)
 	return 0;
 }
 
-static inline int kgd2kfd_pre_reset(struct kfd_dev *kfd)
+static inline int kgd2kfd_pre_reset(struct kfd_dev *kfd,
+				struct amdgpu_reset_context *reset_context)
 {
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 6711836054f9..a9fb9b181584 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5642,8 +5642,11 @@ static inline void amdgpu_device_stop_pending_resets(struct amdgpu_device *adev)
 		cancel_work(&adev->reset_work);
 #endif
 
-	if (adev->kfd.dev)
-		cancel_work(&adev->kfd.reset_work);
+	if (adev->kfd.dev) {
+		kfree(adev->kfd.reset_work.reset_context);
+		adev->kfd.reset_work.reset_context = NULL;
+		cancel_work(&adev->kfd.reset_work.work);
+	}
 
 	if (amdgpu_sriov_vf(adev))
 		cancel_work(&adev->virt.flr_work);
@@ -5775,7 +5778,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 
 		cancel_delayed_work_sync(&tmp_adev->delayed_init_work);
 
-		amdgpu_amdkfd_pre_reset(tmp_adev);
+		amdgpu_amdkfd_pre_reset(tmp_adev, reset_context);
 
 		/*
 		 * Mark these ASICs to be reseted as untracked first
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
index 5a9cc043b858..7ef500992f30 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
@@ -43,6 +43,7 @@ struct amdgpu_reset_context {
 	struct amdgpu_hive_info *hive;
 	struct list_head *reset_device_list;
 	unsigned long flags;
+	char reset_cause[32];
 };
 
 struct amdgpu_reset_handler {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index a72683f83390..cf0908996765 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -602,7 +602,7 @@ static void amdgpu_virt_update_vf2pf_work_item(struct work_struct *work)
 		    amdgpu_sriov_runtime(adev)) {
 			amdgpu_ras_set_fed(adev, true);
 			if (amdgpu_reset_domain_schedule(adev->reset_domain,
-							  &adev->kfd.reset_work))
+							  &adev->kfd.reset_work.work))
 				return;
 			else
 				dev_err(adev->dev, "Failed to queue work! at %s", __func__);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index fba9b9a258a5..52be4e340fb1 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -924,7 +924,8 @@ void kgd2kfd_device_exit(struct kfd_dev *kfd)
 	kfree(kfd);
 }
 
-int kgd2kfd_pre_reset(struct kfd_dev *kfd)
+int kgd2kfd_pre_reset(struct kfd_dev *kfd,
+		      struct amdgpu_reset_context *reset_context)
 {
 	struct kfd_node *node;
 	int i;
@@ -934,7 +935,7 @@ int kgd2kfd_pre_reset(struct kfd_dev *kfd)
 
 	for (i = 0; i < kfd->num_nodes; i++) {
 		node = kfd->nodes[i];
-		kfd_smi_event_update_gpu_reset(node, false);
+		kfd_smi_event_update_gpu_reset(node, false, reset_context);
 		node->dqm->ops.pre_reset(node->dqm);
 	}
 
@@ -974,7 +975,7 @@ int kgd2kfd_post_reset(struct kfd_dev *kfd)
 	for (i = 0; i < kfd->num_nodes; i++) {
 		node = kfd->nodes[i];
 		atomic_set(&node->sram_ecc_flag, 0);
-		kfd_smi_event_update_gpu_reset(node, true);
+		kfd_smi_event_update_gpu_reset(node, true, NULL);
 	}
 
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 485e26abc619..b6473110514f 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -37,6 +37,7 @@
 #include "amdgpu_amdkfd.h"
 #include "mes_v11_api_def.h"
 #include "kfd_debug.h"
+#include "amdgpu_reset.h"
 
 /* Size of the per-pipe EOP queue */
 #define CIK_HPD_EOP_BYTES_LOG2 11
@@ -246,6 +247,23 @@ static int add_queue_mes(struct device_queue_manager *dqm, struct queue *q,
 	r = adev->mes.funcs->add_hw_queue(&adev->mes, &queue_input);
 	amdgpu_mes_unlock(&adev->mes);
 	if (r) {
+		struct amdgpu_reset_context *reset_context =
+				kzalloc(sizeof(struct amdgpu_reset_context),
+					GFP_KERNEL);
+
+		if (!reset_context) {
+			pr_err("No memory to allocate reset context!\n");
+		} else {
+			reset_context->method = AMD_RESET_METHOD_NONE;
+			reset_context->reset_req_dev = dqm->dev->adev;
+			clear_bit(AMDGPU_NEED_FULL_RESET,
+				  &reset_context->flags);
+			strscpy(reset_context->reset_cause, "MES_hang",
+				sizeof(reset_context->reset_cause));
+			dqm->dev->adev->kfd.reset_work.reset_context =
+					(void *)reset_context;
+		}
+
 		dev_err(adev->dev, "failed to add hardware queue to MES, doorbell=0x%x\n",
 			q->properties.doorbell_off);
 		dev_err(adev->dev, "MES might be in unrecoverable state, issue a GPU reset\n");
@@ -274,6 +292,23 @@ static int remove_queue_mes(struct device_queue_manager *dqm, struct queue *q,
 	amdgpu_mes_unlock(&adev->mes);
 
 	if (r) {
+		struct amdgpu_reset_context *reset_context =
+				kzalloc(sizeof(struct amdgpu_reset_context),
+					GFP_KERNEL);
+
+		if (!reset_context) {
+			pr_err("No memory to allocate reset context!\n");
+		} else {
+			reset_context->method = AMD_RESET_METHOD_NONE;
+			reset_context->reset_req_dev = dqm->dev->adev;
+			clear_bit(AMDGPU_NEED_FULL_RESET,
+				  &reset_context->flags);
+			strscpy(reset_context->reset_cause, "MES_hang",
+				sizeof(reset_context->reset_cause));
+			dqm->dev->adev->kfd.reset_work.reset_context =
+					(void *)reset_context;
+		}
+
 		dev_err(adev->dev, "failed to remove hardware queue from MES, doorbell=0x%x\n",
 			q->properties.doorbell_off);
 		dev_err(adev->dev, "MES might be in unrecoverable state, issue a GPU reset\n");
@@ -1983,6 +2018,23 @@ static int unmap_queues_cpsch(struct device_queue_manager *dqm,
 	retval = amdkfd_fence_wait_timeout(dqm, KFD_FENCE_COMPLETED,
 					   queue_preemption_timeout_ms);
 	if (retval) {
+		struct amdgpu_reset_context *reset_context =
+				kzalloc(sizeof(struct amdgpu_reset_context),
+					GFP_KERNEL);
+
+		if (!reset_context) {
+			pr_err("No memory to allocate reset context!\n");
+		} else {
+			reset_context->method = AMD_RESET_METHOD_NONE;
+			reset_context->reset_req_dev = dqm->dev->adev;
+			clear_bit(AMDGPU_NEED_FULL_RESET,
+				  &reset_context->flags);
+			strscpy(reset_context->reset_cause, "HWS_hang",
+				sizeof(reset_context->reset_cause));
+			dqm->dev->adev->kfd.reset_work.reset_context =
+					(void *)reset_context;
+		}
+
 		dev_err(dev, "The cp might be in an unrecoverable state due to an unsuccessful queues preemption\n");
 		kfd_hws_hang(dqm);
 		return retval;
@@ -1998,8 +2050,27 @@ static int unmap_queues_cpsch(struct device_queue_manager *dqm,
 	 */
 	mqd_mgr = dqm->mqd_mgrs[KFD_MQD_TYPE_HIQ];
 	if (mqd_mgr->check_preemption_failed(mqd_mgr, dqm->packet_mgr.priv_queue->queue->mqd)) {
+		struct amdgpu_reset_context *reset_context;
+
 		while (halt_if_hws_hang)
 			schedule();
+
+		reset_context =	kzalloc(sizeof(struct amdgpu_reset_context),
+					GFP_KERNEL);
+
+		if (!reset_context) {
+			pr_err("No memory to allocate reset context!\n");
+		} else {
+			reset_context->method = AMD_RESET_METHOD_NONE;
+			reset_context->reset_req_dev = dqm->dev->adev;
+			clear_bit(AMDGPU_NEED_FULL_RESET,
+				  &reset_context->flags);
+			strscpy(reset_context->reset_cause, "HWS_hang",
+				sizeof(reset_context->reset_cause));
+			dqm->dev->adev->kfd.reset_work.reset_context =
+					(void *)reset_context;
+		}
+
 		kfd_hws_hang(dqm);
 		return -ETIME;
 	}
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
index 06ac835190f9..569a17be8387 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
@@ -29,6 +29,7 @@
 #include "amdgpu_vm.h"
 #include "kfd_priv.h"
 #include "kfd_smi_events.h"
+#include "amdgpu_reset.h"
 
 struct kfd_smi_client {
 	struct list_head list;
@@ -215,7 +216,8 @@ static void kfd_smi_event_add(pid_t pid, struct kfd_node *dev,
 	add_event_to_kfifo(pid, dev, event, fifo_in, len);
 }
 
-void kfd_smi_event_update_gpu_reset(struct kfd_node *dev, bool post_reset)
+void kfd_smi_event_update_gpu_reset(struct kfd_node *dev, bool post_reset,
+				    struct amdgpu_reset_context *reset_context)
 {
 	unsigned int event;
 
@@ -225,7 +227,14 @@ void kfd_smi_event_update_gpu_reset(struct kfd_node *dev, bool post_reset)
 		event = KFD_SMI_EVENT_GPU_PRE_RESET;
 		++(dev->reset_seq_num);
 	}
-	kfd_smi_event_add(0, dev, event, "%x\n", dev->reset_seq_num);
+
+	if (reset_context)
+		kfd_smi_event_add(0, dev, event, "%x %s\n",
+				  dev->reset_seq_num,
+				  reset_context->reset_cause);
+	else
+		kfd_smi_event_add(0, dev, event, "%x\n",
+				  dev->reset_seq_num);
 }
 
 void kfd_smi_event_update_thermal_throttling(struct kfd_node *dev,
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h
index fa95c2dfd587..85010b8307f8 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h
@@ -24,11 +24,14 @@
 #ifndef KFD_SMI_EVENTS_H_INCLUDED
 #define KFD_SMI_EVENTS_H_INCLUDED
 
+struct amdgpu_reset_context;
+
 int kfd_smi_event_open(struct kfd_node *dev, uint32_t *fd);
 void kfd_smi_event_update_vmfault(struct kfd_node *dev, uint16_t pasid);
 void kfd_smi_event_update_thermal_throttling(struct kfd_node *dev,
 					     uint64_t throttle_bitmask);
-void kfd_smi_event_update_gpu_reset(struct kfd_node *dev, bool post_reset);
+void kfd_smi_event_update_gpu_reset(struct kfd_node *dev, bool post_reset,
+				    struct amdgpu_reset_context *reset_context);
 void kfd_smi_event_page_fault_start(struct kfd_node *node, pid_t pid,
 				    unsigned long address, bool write_fault,
 				    ktime_t ts);
-- 
2.34.1

