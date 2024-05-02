Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81E99C4345F
	for <amd-gfx@archiver.kernel.org>; Thu,  2 May 2024 17:24:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B626112605;
	Thu,  2 May 2024 17:24:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MoGE4aRK";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2050.outbound.protection.outlook.com [40.107.244.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE4CB112604
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 May 2024 17:24:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A7iVulGZyeKrzGf/itfM2LosyXzz+tg1673X31pEx7XnIQHy8AeuykKcHicPxuzH62XgcnRB868tkjhND5RPbetIA320YLuO8ZBmmzb7TlW7FbbYkGx2mHkBjgcCv302dv9Vzzbx7pTdPeyfhw7gCZG7cyLQefhnwFeli9Z5aqAF5iOBNmirBaJxbLyTjo2pKnUmUN7QAAO4COMbEEmxuliHbnMIJN2G7moumZ2XZ3gt1ypn7yWju+L1sYLzygDR4r3EytP6P1scx6b7B2EjciL1aCFxGHLJHTFuxxVC+ORpz3VXd226US4y1dswuzWesb2aEyeSNvaag3+C+3cVqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Elgp2jUylpfxENBOHVJnnye7ztrbz5d4Mze26oPLCgc=;
 b=KtirCTZiK4QVdRtxYPr6Q4CP4D+pjcxmbE0sbJbnENh4xJUWAAI3rpM2ngJ3fG16DEPEwogFbVjuAegL7bjaJ5EDq3ZcRv63//1YEo4VTBNeWwkKov0A0DwhEfap5ndQqJTcZB4HDKIM2cVSjKReTbsohMiWcb/4CwovtCjZ5hu3y7m2jm7WOpVWU7GIJoS5tqzOkCNDrRadzvH5CAOupm6QBKqCXa/ClyhoOvSKbngSz5ihDVdxDSf+BKhCfAU+PadDqm4EobB72Z94ozWN9yse+SYVD1n0JVpyOLskF/ueqf2ekVHm0WZe6vrxxLNUVZjsU5OtmvW59EsrkvSWbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Elgp2jUylpfxENBOHVJnnye7ztrbz5d4Mze26oPLCgc=;
 b=MoGE4aRKaU7bN8gwHimKBf8IfL6SLuRwOxc+3D1wzeppNt18EXXcqrnNrsIZzswcXfBaTHcx+b+UBPmJ7QZdmYsPVQQ8KIVou9vGh6u4r1BCf4Z/o5e0oHd/Xk5TVP7dxN3qXlm/EPmgNxMHKv84ltBmWWrAyevsNTvQh7CyIjw=
Received: from BY3PR04CA0025.namprd04.prod.outlook.com (2603:10b6:a03:217::30)
 by IA0PR12MB8648.namprd12.prod.outlook.com (2603:10b6:208:486::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Thu, 2 May
 2024 17:24:41 +0000
Received: from DS3PEPF000099D7.namprd04.prod.outlook.com
 (2603:10b6:a03:217:cafe::b6) by BY3PR04CA0025.outlook.office365.com
 (2603:10b6:a03:217::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.30 via Frontend
 Transport; Thu, 2 May 2024 17:24:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D7.mail.protection.outlook.com (10.167.17.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Thu, 2 May 2024 17:24:40 +0000
Received: from OriUbuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 2 May
 2024 12:24:39 -0500
From: Ori Messinger <Ori.Messinger@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Ori Messinger <Ori.Messinger@amd.com>
Subject: [PATCH] drm/amdgpu: Add Ring Hang Events
Date: Thu, 2 May 2024 13:23:54 -0400
Message-ID: <20240502172354.16682-1-Ori.Messinger@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D7:EE_|IA0PR12MB8648:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b5ffcf8-e8cc-42bf-0ec2-08dc6accbfd0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|36860700004|376005|1800799015;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?FQC1HJyCOG5i1vrlw9+ZZknOCAXIMht/WkfA3/TW06QkCoVCe2BScy+G94r0?=
 =?us-ascii?Q?wDxjO9UJX94z85Ldbk8O+xjXO2EjEcoWqUW/5pLE6JqyhuLtaJ9R6C1xHjDB?=
 =?us-ascii?Q?1VRBjB0GApRc1k0Gr0SZDo0W2ivkx+GP51ZENqevDo7pWPC67+rx5JIP3uTy?=
 =?us-ascii?Q?mdbJ1g8oJ6pbje2JgPO0IGmXoBdw42KX1DgZakB5gqAL5aJXT6S5FahCyDQv?=
 =?us-ascii?Q?oezqEwVyY10nz0z2WoRclCL9aOUunJz/QTiX3Cz01kqhOFeb/5IeBBOxCgXG?=
 =?us-ascii?Q?o62j+COeKyg45zZuxWLDbP2FuwI73PM938mqXovWkSmFsEA5pIzm8b8K0+is?=
 =?us-ascii?Q?uofDp45qhPTz4sMRbJxUXGqjHWoy7xhCcD1qERYmdZ5E393ITDwRD9rVG7HS?=
 =?us-ascii?Q?vgdXJtJqsPZ5Gc38m/uuCRGsH1PbgJVPcp8usp6yRArXXlcJwRybRTFlw425?=
 =?us-ascii?Q?noxHYbtEPUbjDezUCEwk+ON7WOUEVhbgsOb/UfLt0nZS9w4oRBshd+sIPYE1?=
 =?us-ascii?Q?by6/GX4BalYRpUb4ilgoxVEtwAwWaL9vGvxWl4hykSzDEnnPBeqtlyydhDod?=
 =?us-ascii?Q?/DUB2aHmlIrg6UR9C2WmrG3s3aw/hdr08X96aP254OhGH7y8B/k2Ztk47dE7?=
 =?us-ascii?Q?cKJJc9raYcI5XBH1ksT3GCXQ6nhAQVOtEOt1LKjmLA8Au+UsbwYwHQX/pScD?=
 =?us-ascii?Q?CpYJW3opUXi6BmS+DsEAB+cHlJBb3no28G0kGlkuETnJbfddrU5djX44oIOx?=
 =?us-ascii?Q?XWuu4uGTINBlztAlS4w8Ez5b/gD2KvqY+lWK1A3gkyV3bGkVCeiIN1i/ef33?=
 =?us-ascii?Q?zhOnPr6q3OWMtvqx6+BzV74BZb61H5hEuWUluaE/6nn9lrwW7Awgv8bwtvX2?=
 =?us-ascii?Q?bvUKY9PvDEe23OZVZJgK3YXwCqcnp+dn9BnD+Z6SuMJT4j3/EyH4SOK+tUFA?=
 =?us-ascii?Q?s0u/TuDF60c4zXFWvHyTmBlhOM7hqa5i4U6N9JmWvLD+lLJbekRIQhjWLczs?=
 =?us-ascii?Q?hVGqHpEsgBoXZ9S7o3RqZq/owdoAyyJ6B3iUdsYc1HNUgmyTi79KABpBf9f1?=
 =?us-ascii?Q?WncZtwjtKw6z09faZ1/iwrHekvpBxxe7FKcIxgCbW23RtKUqa5Rvx5NNURIW?=
 =?us-ascii?Q?apkQgV6pb5GpPSGZoKLIe5qwyKftpayLteKiaA2+E4km7pn6Z+iBSwdMHuL2?=
 =?us-ascii?Q?1ajDv5w2YfaziMzlYrI5G18UzZD4BzCYEHVM/CiRpl/KTXqK6cMlOJFD4SGk?=
 =?us-ascii?Q?WXfw3RXrQZ5YyO5Imh+undyY4ZE/PsXPqjHF4u4arEaii/q9Z/5Po6LUq3Jn?=
 =?us-ascii?Q?AT/T9jUl52WfxAj9/2Q2IjCG6+zzVGoHbQ5wGT1UgQ8nAl2GRMA+gtlBWI3b?=
 =?us-ascii?Q?n42UeUc=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(376005)(1800799015); DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2024 17:24:40.2786 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b5ffcf8-e8cc-42bf-0ec2-08dc6accbfd0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8648
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

This patch adds 'ring hang' events to the driver.
This is done by adding a 'reset_ring_hang' bool variable to the
struct 'amdgpu_reset_context' in the amdgpu_reset.h file.
The purpose for this 'reset_ring_hang' variable is whenever a GPU
reset is initiated, the reset_ring_hang should be set to 'true'.

This 'amdgpu_reset_context' struct is now also passed
through across all relevant functions, and another event type
"KFD_SMI_EVENT_RING_HANG" is added to the kfd_smi_event enum.

Signed-off-by: Ori Messinger <Ori.Messinger@amd.com>
Change-Id: I6af3022eb1b4514201c9430d635ff87f167ad6f7
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c  |  4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h  |  9 ++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c     |  2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h   |  1 +
 drivers/gpu/drm/amd/amdkfd/kfd_device.c     |  7 ++++---
 drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c |  6 +++++-
 drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h |  5 ++++-
 include/uapi/linux/kfd_ioctl.h              | 15 ++++++++-------
 9 files changed, 33 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index 7ba05f030dd1..509f750702b4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -261,12 +261,12 @@ int amdgpu_amdkfd_resume(struct amdgpu_device *adev, bool run_pm)
 	return r;
 }
 
-int amdgpu_amdkfd_pre_reset(struct amdgpu_device *adev)
+int amdgpu_amdkfd_pre_reset(struct amdgpu_device *adev, struct amdgpu_reset_context *reset_context)
 {
 	int r = 0;
 
 	if (adev->kfd.dev)
-		r = kgd2kfd_pre_reset(adev->kfd.dev);
+		r = kgd2kfd_pre_reset(adev->kfd.dev, reset_context);
 
 	return r;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index 1de021ebdd46..c9030d8b8308 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -47,6 +47,7 @@ enum TLB_FLUSH_TYPE {
 };
 
 struct amdgpu_device;
+struct amdgpu_reset_context;
 
 enum kfd_mem_attachment_type {
 	KFD_MEM_ATT_SHARED,	/* Share kgd_mem->bo or another attachment's */
@@ -170,7 +171,8 @@ bool amdgpu_amdkfd_have_atomics_support(struct amdgpu_device *adev);
 
 bool amdgpu_amdkfd_is_kfd_vmid(struct amdgpu_device *adev, u32 vmid);
 
-int amdgpu_amdkfd_pre_reset(struct amdgpu_device *adev);
+int amdgpu_amdkfd_pre_reset(struct amdgpu_device *adev,
+			    struct amdgpu_reset_context *reset_context);
 
 int amdgpu_amdkfd_post_reset(struct amdgpu_device *adev);
 
@@ -416,7 +418,8 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
 void kgd2kfd_device_exit(struct kfd_dev *kfd);
 void kgd2kfd_suspend(struct kfd_dev *kfd, bool run_pm);
 int kgd2kfd_resume(struct kfd_dev *kfd, bool run_pm);
-int kgd2kfd_pre_reset(struct kfd_dev *kfd);
+int kgd2kfd_pre_reset(struct kfd_dev *kfd,
+		      struct amdgpu_reset_context *reset_context);
 int kgd2kfd_post_reset(struct kfd_dev *kfd);
 void kgd2kfd_interrupt(struct kfd_dev *kfd, const void *ih_ring_entry);
 void kgd2kfd_set_sram_ecc_flag(struct kfd_dev *kfd);
@@ -459,7 +462,7 @@ static inline int kgd2kfd_resume(struct kfd_dev *kfd, bool run_pm)
 	return 0;
 }
 
-static inline int kgd2kfd_pre_reset(struct kfd_dev *kfd)
+static inline int kgd2kfd_pre_reset(struct kfd_dev *kfd, struct amdgpu_reset_context *reset_context)
 {
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 77f6fd50002a..f9fa784f36f4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5772,7 +5772,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 
 		cancel_delayed_work_sync(&tmp_adev->delayed_init_work);
 
-		amdgpu_amdkfd_pre_reset(tmp_adev);
+		amdgpu_amdkfd_pre_reset(tmp_adev, reset_context);
 
 		/*
 		 * Mark these ASICs to be reseted as untracked first
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
index e4742b65032d..361ba892739f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -77,6 +77,8 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
 
 		reset_context.method = AMD_RESET_METHOD_NONE;
 		reset_context.reset_req_dev = adev;
+		reset_context.reset_ring_hang = true;
+		DRM_ERROR("Reset cause: ring hang\n");
 		clear_bit(AMDGPU_NEED_FULL_RESET, &reset_context.flags);
 
 		r = amdgpu_device_gpu_recover(ring->adev, job, &reset_context);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
index 5a9cc043b858..e1f5c0c1458d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
@@ -43,6 +43,7 @@ struct amdgpu_reset_context {
 	struct amdgpu_hive_info *hive;
 	struct list_head *reset_device_list;
 	unsigned long flags;
+	bool reset_ring_hang;
 };
 
 struct amdgpu_reset_handler {
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index 6b15e55811b6..88171f24496b 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -35,6 +35,7 @@
 #include "kfd_migrate.h"
 #include "amdgpu.h"
 #include "amdgpu_xcp.h"
+#include "amdgpu_reset.h"
 
 #define MQD_SIZE_ALIGNED 768
 
@@ -931,7 +932,7 @@ void kgd2kfd_device_exit(struct kfd_dev *kfd)
 	kfree(kfd);
 }
 
-int kgd2kfd_pre_reset(struct kfd_dev *kfd)
+int kgd2kfd_pre_reset(struct kfd_dev *kfd, struct amdgpu_reset_context *reset_context)
 {
 	struct kfd_node *node;
 	int i;
@@ -941,7 +942,7 @@ int kgd2kfd_pre_reset(struct kfd_dev *kfd)
 
 	for (i = 0; i < kfd->num_nodes; i++) {
 		node = kfd->nodes[i];
-		kfd_smi_event_update_gpu_reset(node, false);
+		kfd_smi_event_update_gpu_reset(node, false, reset_context);
 		node->dqm->ops.pre_reset(node->dqm);
 	}
 
@@ -981,7 +982,7 @@ int kgd2kfd_post_reset(struct kfd_dev *kfd)
 	for (i = 0; i < kfd->num_nodes; i++) {
 		node = kfd->nodes[i];
 		atomic_set(&node->sram_ecc_flag, 0);
-		kfd_smi_event_update_gpu_reset(node, true);
+		kfd_smi_event_update_gpu_reset(node, true, NULL);
 	}
 
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
index 06ac835190f9..5d86986b7c23 100644
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
 
@@ -224,6 +226,8 @@ void kfd_smi_event_update_gpu_reset(struct kfd_node *dev, bool post_reset)
 	} else {
 		event = KFD_SMI_EVENT_GPU_PRE_RESET;
 		++(dev->reset_seq_num);
+		if (reset_context && reset_context->reset_ring_hang)
+			kfd_smi_event_add(0, dev, KFD_SMI_EVENT_RING_HANG, "RING_HANG\n");
 	}
 	kfd_smi_event_add(0, dev, event, "%x\n", dev->reset_seq_num);
 }
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
diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioctl.h
index 285a36601dc9..7c94d2c7da13 100644
--- a/include/uapi/linux/kfd_ioctl.h
+++ b/include/uapi/linux/kfd_ioctl.h
@@ -519,13 +519,14 @@ enum kfd_smi_event {
 	KFD_SMI_EVENT_THERMAL_THROTTLE = 2,
 	KFD_SMI_EVENT_GPU_PRE_RESET = 3,
 	KFD_SMI_EVENT_GPU_POST_RESET = 4,
-	KFD_SMI_EVENT_MIGRATE_START = 5,
-	KFD_SMI_EVENT_MIGRATE_END = 6,
-	KFD_SMI_EVENT_PAGE_FAULT_START = 7,
-	KFD_SMI_EVENT_PAGE_FAULT_END = 8,
-	KFD_SMI_EVENT_QUEUE_EVICTION = 9,
-	KFD_SMI_EVENT_QUEUE_RESTORE = 10,
-	KFD_SMI_EVENT_UNMAP_FROM_GPU = 11,
+	KFD_SMI_EVENT_RING_HANG = 5,
+	KFD_SMI_EVENT_MIGRATE_START = 6,
+	KFD_SMI_EVENT_MIGRATE_END = 7,
+	KFD_SMI_EVENT_PAGE_FAULT_START = 8,
+	KFD_SMI_EVENT_PAGE_FAULT_END = 9,
+	KFD_SMI_EVENT_QUEUE_EVICTION = 10,
+	KFD_SMI_EVENT_QUEUE_RESTORE = 11,
+	KFD_SMI_EVENT_UNMAP_FROM_GPU = 12,
 
 	/*
 	 * max event number, as a flag bit to get events from all processes,
-- 
2.25.1

