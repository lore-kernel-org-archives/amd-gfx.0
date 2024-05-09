Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2E05C10F1A
	for <amd-gfx@archiver.kernel.org>; Thu,  9 May 2024 20:42:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B51E10F3ED;
	Thu,  9 May 2024 20:42:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="APJlEwAx";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2063.outbound.protection.outlook.com [40.107.93.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 396DA10F3ED
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 May 2024 20:42:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m3z9rDTATcqF0B2cZZxm4hCvGtrCFVvv52Ose+RV8SSk2d2LI6NYirO6iB1e8wD9uiBG9RbNhfjCvI3y3i/TPk9aXAOCAfjf1P71XeaGEPniG+i36fs0sX+5T1rwmt00bRNAi2V52y0GnJxiKhF84iCzlVd79M9W+nOpAgoiosXM2+SiuR0RMSNltzKrlB26pI+b17jWpu+7XhlIVCaIiqmnKjqGDPyLK1KH4wDBWnVPJvlKymjnuwYQ3PbWPkm/JBqLQvQa83thXmB8q3Wc26cr5re8Og1v9065O7fHl4Jxu3gEGImB0OeYS0MmF9tjIX8P60lpaQVzMfnq7wxffg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sn+/Y2/Bds7S9iqlYYsA9Ur1VCnHXk8IdXISEew6Ft8=;
 b=fSW9Peq074DF+B5ap/Ia1xcD+sAViLOAQCA1MADGEFErQUrZ6m7Ud2lmREsaTLqNqM6J9ZLlMdxvkGmAaY6ZQS2zEaTFrrVpYywCZ+QdVbmR9HuunW6dvFWFBJyqZ4xhdDsWd3GiNuNpfOveG07XbjE/nKTGilvngo30d+LY2TYJafWKLUPy18h508lwAJBvZ86SLDe1Chj8AAxEah3+MFbGXAooVgK8W+IqHlX0K9qVZZ7Sbu907ujjqWfTmQC5GbJ0cKzI80zHhH9vD/gAoh/xrnNXUimyNrnC427MJES3tSbRDivKGJhuRuU0eCmUQO1WBV1av7mfI03kqlB0Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sn+/Y2/Bds7S9iqlYYsA9Ur1VCnHXk8IdXISEew6Ft8=;
 b=APJlEwAx+AEklJv+6xUi2kPtWV3dzl9scgmpn70hcOWx0ON2cqVho01ouIvjW+ZkeNLqcFcxgQR6Uo2hAg0wd0pyoQhAJRJkxQDyPlTeMKOjYQ2bevFJT0TTmOpluJjkUTBb+trI8En2bFgmnpLM1skCj0k72GxnGZ9B4gqtFpE=
Received: from PH8PR21CA0013.namprd21.prod.outlook.com (2603:10b6:510:2ce::22)
 by PH8PR12MB6985.namprd12.prod.outlook.com (2603:10b6:510:1bc::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.43; Thu, 9 May
 2024 20:42:09 +0000
Received: from SA2PEPF000015CB.namprd03.prod.outlook.com
 (2603:10b6:510:2ce:cafe::69) by PH8PR21CA0013.outlook.office365.com
 (2603:10b6:510:2ce::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.15 via Frontend
 Transport; Thu, 9 May 2024 20:42:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015CB.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Thu, 9 May 2024 20:42:08 +0000
Received: from OriUbuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 9 May
 2024 15:42:08 -0500
From: Ori Messinger <Ori.Messinger@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Ori Messinger <Ori.Messinger@amd.com>
Subject: [PATCH v2] drm/amdgpu: Add Ring Hang Events
Date: Thu, 9 May 2024 16:41:53 -0400
Message-ID: <20240509204153.55885-1-Ori.Messinger@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CB:EE_|PH8PR12MB6985:EE_
X-MS-Office365-Filtering-Correlation-Id: efe24f81-6714-45e8-ccfa-08dc70687f09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400017|376005|1800799015|36860700004; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?u4oRz5XFpu8IkfTZohbeD9KcAPxcT0Yd1E6PWQ54Nik7F9b96G2wn5UrevhX?=
 =?us-ascii?Q?CDpb8kxl+98IyfGWBAJHoQJpINcnFXuggKgPwuWJSyHdZ+50IpRpLdg3ul+X?=
 =?us-ascii?Q?hCb1o0R4yTLYg5QOMVAqOxfeAqS6gDEasxBhl9qpujuMyNQ98UDYFZsivmR+?=
 =?us-ascii?Q?KqU21acovrusiFjkbUxm+0YwGdWhHbkWmIVOVBPNAtWkknw2u4QIKW/wf6xL?=
 =?us-ascii?Q?coaoLdwlLeGadPZGCVGo4eXTWDgFwLvHd1vZaSPrC/Z6hMnZIajwwbPxPNwF?=
 =?us-ascii?Q?dKAlA9XbJJXg0FAR1hSybyd28kqk2winNk4K+cM2e61hGfAU4BljyAIQUeO0?=
 =?us-ascii?Q?t/CTe4F4/FWCZ1n8G5uYf0Ky2h4EYWyMUZakUR3mhQdepgIvrJmERzEVa8JW?=
 =?us-ascii?Q?b0gIJM89nbUGkEVa/V25D9w9b+YKAD9Gaz+QkTqd/RviBZix33OO4sG4+hnr?=
 =?us-ascii?Q?j5zO9VYXOSOiDES+2U60Olgm+AJn+pPK8R6Yt3rDeE9FzJucpXFT6Ci2M+eW?=
 =?us-ascii?Q?MDJtkNzsYSC8gHbx5tq7+5kVLo4DbGoeA6ti7Q+/m5aE02LsP7upi+VQX0AT?=
 =?us-ascii?Q?ZbfXyr3GduxRhzA4bY4evBPDqoS0bzrJtrIpCzQKXhRgZwQPVDIb/NbZmkuW?=
 =?us-ascii?Q?GTjDqycRbTEUML4sLAt1NWXtUFEmfUM3VUeo3mgx7deLR6gXFGMC19KSVztl?=
 =?us-ascii?Q?GwHV+g8QAEWSECxiB4AiKBBjKlHmzgdseipqKyARjxKNxNvmDKD04YwsmKEy?=
 =?us-ascii?Q?R9eeDhgUp9+RW6GVrX2FgGwa7PuQSsSVZRk5Ss0irT/PXZi703Ub5MSfbPPl?=
 =?us-ascii?Q?FHE3piBin46aCzI3TMHoTnTTT94g0zT4N9S7hgqFRaJ30qvrw41VZ6I8QgwB?=
 =?us-ascii?Q?/KLR4PTZoseC9YXuRGQkcUSckIYiB/S5lxsMTLbU/h7SmiOlfonBGrfCCJB3?=
 =?us-ascii?Q?UHKvipx5ksOOYfiYgW8RKsJT019qw8X3D5602Th7RS5wFBPi4abjTCYVUPZ4?=
 =?us-ascii?Q?5db7CHUx1V3ASio2tcivF7i8FdOJ6LFjPX40rnYRFrVA0C858FSmlOSZ/j01?=
 =?us-ascii?Q?SqiCHO9i1OR3n7FE8RoDTvoTyjWw7ZyutpQ7Yni4I4k3SuYQWG6lxMokKVba?=
 =?us-ascii?Q?nfQTdQoyJT7aPDwXuL+sbNclV43YBSBtTGnhA3VF/UwEn5ANuS7xMCpVZ+D8?=
 =?us-ascii?Q?VFLMtUhjQIhIqF6wOKzSSiTBL1NyBiit9c5THc1yY7rKbTidJapJzTWGveA6?=
 =?us-ascii?Q?VBOyT0aGteyBBFMzsTOjLjxGKV2ijPYea7a964aLIj7icCf/UehpUJ1kxWdh?=
 =?us-ascii?Q?DSsd9O1nHFCbx7/j7VERxzl+M/LMqjZFwPxHldW5Mwl1ajx/K6Weidjez5mj?=
 =?us-ascii?Q?hEATUfk=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400017)(376005)(1800799015)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2024 20:42:08.9401 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: efe24f81-6714-45e8-ccfa-08dc70687f09
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015CB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6985
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
reset is initiated due to a ring hang, the reset_ring_hang should
be set to 'true'.

This 'amdgpu_reset_context' struct is now also passed
through across all relevant functions, and another event type
"KFD_SMI_EVENT_RING_HANG" is added to the kfd_smi_event enum.

Signed-off-by: Ori Messinger <Ori.Messinger@amd.com>
Change-Id: I6af3022eb1b4514201c9430d635ff87f167ad6f7
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c  |  6 ++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h  |  9 ++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c     |  3 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h   |  2 ++
 drivers/gpu/drm/amd/amdkfd/kfd_device.c     |  7 ++++---
 drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c |  7 ++++++-
 drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h |  5 ++++-
 include/uapi/linux/kfd_ioctl.h              | 15 ++++++++-------
 9 files changed, 38 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index e3738d417245..ac0ee4322555 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -133,6 +133,8 @@ static void amdgpu_amdkfd_reset_work(struct work_struct *work)
 
 	reset_context.method = AMD_RESET_METHOD_NONE;
 	reset_context.reset_req_dev = adev;
+	reset_context.reset_ring_hang = true;
+	strscpy(reset_context.reset_cause, "scheduler_hang", sizeof(reset_context.reset_cause));
 	clear_bit(AMDGPU_NEED_FULL_RESET, &reset_context.flags);
 
 	amdgpu_device_gpu_recover(adev, NULL, &reset_context);
@@ -261,12 +263,12 @@ int amdgpu_amdkfd_resume(struct amdgpu_device *adev, bool run_pm)
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
index e4742b65032d..abcae2e7ed0f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -77,6 +77,9 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
 
 		reset_context.method = AMD_RESET_METHOD_NONE;
 		reset_context.reset_req_dev = adev;
+		reset_context.reset_ring_hang = true;
+		strscpy(reset_context.reset_cause, "SDMA_hang", sizeof(reset_context.reset_cause));
+		DRM_ERROR("Reset cause: SDMA ring hang\n");
 		clear_bit(AMDGPU_NEED_FULL_RESET, &reset_context.flags);
 
 		r = amdgpu_device_gpu_recover(ring->adev, job, &reset_context);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
index 5a9cc043b858..757284ab36e0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
@@ -43,6 +43,8 @@ struct amdgpu_reset_context {
 	struct amdgpu_hive_info *hive;
 	struct list_head *reset_device_list;
 	unsigned long flags;
+	bool reset_ring_hang;
+	char reset_cause[64];
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
index 06ac835190f9..3ffe4b61fe4f 100644
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
 
@@ -224,6 +226,9 @@ void kfd_smi_event_update_gpu_reset(struct kfd_node *dev, bool post_reset)
 	} else {
 		event = KFD_SMI_EVENT_GPU_PRE_RESET;
 		++(dev->reset_seq_num);
+		if (reset_context && reset_context->reset_ring_hang)
+			kfd_smi_event_add(0, dev, KFD_SMI_EVENT_RING_HANG, "%s\n",
+					  reset_context->reset_cause);
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

