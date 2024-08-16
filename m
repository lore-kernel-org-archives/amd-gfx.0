Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D427C531DC
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Aug 2024 07:55:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C3C810E5CB;
	Fri, 16 Aug 2024 07:55:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xa6eLG9b";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2079.outbound.protection.outlook.com [40.107.94.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 939C710E5CA
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Aug 2024 07:55:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ndX6bVCCvzkIJu+3zy5Bmz5zFxVUAmsUAa46MHvCjZZYSk5VnzmkjB0BGF/6rOWw//3MB9BesgQdkU5ic408Mq+7iKt3PGGy7MHDhevyXUsb56H2Wj8z5ESlEHQHV0CwHfb7sp5MIvHjzh5RgfXzTE0K7804frXqia8ypOe9kXUDkk+y85NOrQqiHd7Z49FYc7N2q0CkDBVndsIZqEzsoiqI3z8Qq8KAVvMO2OpgT5235TdG2FcYYpV7QDS5wk8al5bDbEn/U9K46s2YHi5jO2gYjaPR8ibdg0KY7SKeDCfeFAVX5YrnON1KVYEG3Eg96QjGUU4RGwkBs1cyQlUVMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BxwgF/Bhs2yu/4s9j+YDOKYgtwfkxfHdSVVkFDZoG3g=;
 b=RKvQWjBo8lwbrxztPduDKmGE+bsoMu26RO0yw+dA6Y6KemeEKz/j5cyEDXDU4c6q3OrVT+VFcOyGCFNfpCWFxRemWl23rr7pLCfbmYjHebhsnojH0u1kmmwrooTr6dujlOBSc9e967OsywJ7vbiHIJ4SqEnxYv5bBSK2EshVS+icRuJb6C3zJW9xkdU6RcnIYZ1NnSWEtYFwgdBFXzfpsgNBWqSUfPVmdnp25md6Je3FiDoSgqIilwiz+GvAOhPf0rgJELXXD5ogcVmU1N9mMg/wPGn3flzN+RryTzaOv6VSfI1+my7/VkNic8t9wzmp22v/Btzsd6Zdaoqre+PK1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BxwgF/Bhs2yu/4s9j+YDOKYgtwfkxfHdSVVkFDZoG3g=;
 b=xa6eLG9b4ir2LIjiKuVEphRbwmfVrBo6XF/Lhc/P3D+z0EQf60I84V7RwJX4YR8SVNZnRAysBl1g6r0+gkzHeqiJWXSl1MwOTxYHCQOs18HM/7a/onAxst1eZS56TwJXqKRzhmpl6iHSRpGKPloUxbStyDyVER6RJUOhOlw9iLE=
Received: from DS7PR07CA0010.namprd07.prod.outlook.com (2603:10b6:5:3af::29)
 by MW4PR12MB7118.namprd12.prod.outlook.com (2603:10b6:303:213::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.26; Fri, 16 Aug
 2024 07:55:08 +0000
Received: from CY4PEPF0000EE32.namprd05.prod.outlook.com
 (2603:10b6:5:3af:cafe::88) by DS7PR07CA0010.outlook.office365.com
 (2603:10b6:5:3af::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.23 via Frontend
 Transport; Fri, 16 Aug 2024 07:55:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE32.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7849.8 via Frontend Transport; Fri, 16 Aug 2024 07:55:07 +0000
Received: from lps-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 16 Aug 2024 02:55:05 -0500
From: <Trigger.Huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <sunil.khatri@amd.com>, <alexander.deucher@amd.com>, Trigger Huang
 <Trigger.Huang@amd.com>
Subject: [PATCH 3/4] drm/amdgpu: skip printing vram_lost if needed
Date: Fri, 16 Aug 2024 15:54:46 +0800
Message-ID: <20240816075447.442983-4-Trigger.Huang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240816075447.442983-1-Trigger.Huang@amd.com>
References: <20240816075447.442983-1-Trigger.Huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE32:EE_|MW4PR12MB7118:EE_
X-MS-Office365-Filtering-Correlation-Id: e1568124-30c0-4e45-ed4b-08dcbdc8bf45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+TeMCnSkSgXlO3dmzwl9bIiasXLZFmbo/+1TFvx36cd4Tpwu4ZY9RbsW8Kgn?=
 =?us-ascii?Q?BGvNlufy4x+6ERgod6DfQ27rn34E3wjpg6kZ8RFdaIBQmeU0KktSf3YotSob?=
 =?us-ascii?Q?wdV4Wk0Au4D+Jj7igo32zr3pdCLO+3cjDE8mrkrvLNuxVi2m7xBXxtl4gUIc?=
 =?us-ascii?Q?JIx1ktoTL60EgL5iXU2myupFswT5FLb1h1QBOlGvNPrbqGMvaP5FP9iEa/+D?=
 =?us-ascii?Q?m853lnM60Yn7hVowj3iYmFXt8tW2SFe6wgweucdA/jdSclLXWOMc1wl6w7Cb?=
 =?us-ascii?Q?dfPc7Q0PcocGo8qcQg9SKngiNscjc20ARG3ViGjLRbeRxQMpT/ZCTFPHPdyi?=
 =?us-ascii?Q?RkxqH49oV8EhsJZolGhE5EiUWCQz+HHKvns5slSI9yo1cq4BrS2DtTpPPUhN?=
 =?us-ascii?Q?VIoajfU187WTeWgEpMW7JvIJd4qlulZHecTVn+NG3fC4G1WmeMRLBcdhUexR?=
 =?us-ascii?Q?07w9R2WFBSh9NdR/6sqKsNS6x95fzwV7+I/RrY/y8QqRTiSegTT7df4SVF1I?=
 =?us-ascii?Q?VUtjBMLC+jFbCFv5wxfOAbK/Ue6wkE7kYKPNGfiNvxik8cO/pXSArNFLV+DW?=
 =?us-ascii?Q?Z1uYsexdoU7cdXt2qRws70oWfIejuMQT7vKCxiEktUpuABpoiwgp26gOUJLm?=
 =?us-ascii?Q?NsiYGlNtj+rzOSSGkY5BFsmAVI/8dVzudc+EcpErf0llzxJUVeBCHfWvl/x0?=
 =?us-ascii?Q?uco8w0NGUvNdPKykfySzUjxIGO2UraGC3hIfnZU2Fwq3NaC7AfMk6VoQuXfu?=
 =?us-ascii?Q?zeiBXi1h7mV8pXVIivi1lBSQEDgbYLmBWtavd00o0vZP8ULbHy2XRYthWw7J?=
 =?us-ascii?Q?KxFcEjFPpnauKXPnNDV8nEfk2I3mqesMpXTaQz98aU0TWP8WhnPh8G33jItP?=
 =?us-ascii?Q?d3cK+L4PlziR49bLCY5PqFTKK5PALZbIjMdR7H8v3AMBl20bqd+QHlrXRmaQ?=
 =?us-ascii?Q?xmGnJHWkCFW1+PcZ3QBWfzKF/aLRrC8gvfVUSGx+bKoydEdzJRYfG0DWbPIN?=
 =?us-ascii?Q?HRQOahYjkhplalKFNDzDF/dsblzG71jV5FR23dmIPZpEy0ywO2KWNCVO6qeg?=
 =?us-ascii?Q?2kOYGNIcENXTjHIMW/pMIYlzjPQCW6XlSh7G+JyTERWsW70Yi+7Md3YbToVo?=
 =?us-ascii?Q?Y8jSY5hyG61me3cvzyGCwwFsmfmTYoe0BKW6NqAdDJ0ewEkt/yHK4fSGMobL?=
 =?us-ascii?Q?KOsyEHe/ta9qES5SFO+hu7fsAZFWT1W7WFuEZxvvEL7yMbu5uqcreVZ1TeHy?=
 =?us-ascii?Q?D/X8yK6DJN71d2WlDHgZQotG3P0LddQ6vUksgUaYEMaStuemfsATIbbjh+iE?=
 =?us-ascii?Q?FO5Hss52kVu7/2qdXIVp2ZWEd6TE7786DNsFJr8Trcy/a3nwrCHRBEImqCHq?=
 =?us-ascii?Q?TAz56dNDX5Q/MoTHogbUpr0VHl+vuhi7eFyqDB4SxwAzZBUD1SX/DXN/3zCW?=
 =?us-ascii?Q?NGyHhpydz+naBr+/TormBAHmSTvLdCDv?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2024 07:55:07.8813 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e1568124-30c0-4e45-ed4b-08dcbdc8bf45
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE32.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7118
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

From: Trigger Huang <Trigger.Huang@amd.com>

The vm lost status can only be obtained after a GPU reset occurs, but
sometimes a dev core dump can be happened before GPU reset. So a new
argument is added to tell the dev core dump implementation whether to
skip printing the vram_lost status in the dump.
And this patch is also trying to decouple the core dump function from
the GPU reset function, by replacing the argument amdgpu_reset_context
with amdgpu_job to specify the context for core dump.

Signed-off-by: Trigger Huang <Trigger.Huang@amd.com>
Suggested-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c  | 19 ++++++++++---------
 .../gpu/drm/amd/amdgpu/amdgpu_dev_coredump.h  |  6 +++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  2 +-
 3 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
index cf2b4dd4d865..a860f52d8bb0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
@@ -28,8 +28,9 @@
 #include "atom.h"
 
 #ifndef CONFIG_DEV_COREDUMP
-void amdgpu_coredump(struct amdgpu_device *adev, bool vram_lost,
-		     struct amdgpu_reset_context *reset_context)
+void amdgpu_coredump(struct amdgpu_device *adev, bool skip_vram_check,
+		     bool vram_lost, struct amdgpu_job *job)
+
 {
 }
 #else
@@ -315,7 +316,7 @@ amdgpu_devcoredump_read(char *buffer, loff_t offset, size_t count,
 		}
 	}
 
-	if (coredump->reset_vram_lost)
+	if (!(coredump->skip_vram_check) && coredump->reset_vram_lost)
 		drm_printf(&p, "VRAM is lost due to GPU reset!\n");
 
 	return count - iter.remain;
@@ -326,12 +327,11 @@ static void amdgpu_devcoredump_free(void *data)
 	kfree(data);
 }
 
-void amdgpu_coredump(struct amdgpu_device *adev, bool vram_lost,
-		     struct amdgpu_reset_context *reset_context)
+void amdgpu_coredump(struct amdgpu_device *adev, bool skip_vram_check,
+		     bool vram_lost, struct amdgpu_job *job)
 {
-	struct amdgpu_coredump_info *coredump;
 	struct drm_device *dev = adev_to_drm(adev);
-	struct amdgpu_job *job = reset_context->job;
+	struct amdgpu_coredump_info *coredump;
 	struct drm_sched_job *s_job;
 
 	coredump = kzalloc(sizeof(*coredump), GFP_NOWAIT);
@@ -341,11 +341,12 @@ void amdgpu_coredump(struct amdgpu_device *adev, bool vram_lost,
 		return;
 	}
 
+	coredump->skip_vram_check = skip_vram_check;
 	coredump->reset_vram_lost = vram_lost;
 
-	if (reset_context->job && reset_context->job->vm) {
+	if (job && job->vm) {
 		struct amdgpu_task_info *ti;
-		struct amdgpu_vm *vm = reset_context->job->vm;
+		struct amdgpu_vm *vm = job->vm;
 
 		ti = amdgpu_vm_get_task_info_vm(vm);
 		if (ti) {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.h
index 52459512cb2b..c4e522e49251 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.h
@@ -26,7 +26,6 @@
 #define __AMDGPU_DEV_COREDUMP_H__
 
 #include "amdgpu.h"
-#include "amdgpu_reset.h"
 
 #ifdef CONFIG_DEV_COREDUMP
 
@@ -36,12 +35,13 @@ struct amdgpu_coredump_info {
 	struct amdgpu_device            *adev;
 	struct amdgpu_task_info         reset_task_info;
 	struct timespec64               reset_time;
+	bool                            skip_vram_check;
 	bool                            reset_vram_lost;
 	struct amdgpu_ring              *ring;
 };
 #endif
 
-void amdgpu_coredump(struct amdgpu_device *adev, bool vram_lost,
-		     struct amdgpu_reset_context *reset_context);
+void amdgpu_coredump(struct amdgpu_device *adev, bool skip_vram_check,
+		     bool vram_lost, struct amdgpu_job *job);
 
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 9885d0606b0a..825cc62cd75d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5445,7 +5445,7 @@ int amdgpu_do_asic_reset(struct list_head *device_list_handle,
 				vram_lost = amdgpu_device_check_vram_lost(tmp_adev);
 
 				if (amdgpu_gpu_coredump && (!test_bit(AMDGPU_SKIP_COREDUMP, &reset_context->flags)))
-					amdgpu_coredump(tmp_adev, vram_lost, reset_context);
+					amdgpu_coredump(tmp_adev, false, vram_lost, reset_context->job);
 
 				if (vram_lost) {
 					DRM_INFO("VRAM is lost due to GPU reset!\n");
-- 
2.34.1

