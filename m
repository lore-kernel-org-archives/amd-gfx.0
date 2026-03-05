Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98C95EFCE43
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Mar 2026 03:08:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 131A510EAE8;
	Thu,  5 Mar 2026 03:08:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hMYR2iwL";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012001.outbound.protection.outlook.com
 [40.93.195.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E73410EAE6
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Mar 2026 03:08:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=htbYXGBkXYT3Ph/Xxn1ksZqtBsWFvJcL/BsXza9DBZiUc1NleB1AcJS2/R3+zN9u9W0HjuMEdUNAw1as8jaTOsTdbJPuA+nkirLXmUSFHovvx43E/VdMLRUVnufO0aj0FyumwbeTAQXL3trYil7je1XB+jbluNQqEG6ctDoWng5xbISpN1N/fXEGS3DYZssUVN5z0CEblKkWR/+pw7AyFbiS7w4S/g29oYIz6oMJ9LA2BaI+r91dz0iuSi/anhGFFIc1LBqAHRho0UhYom9i0fnnTmRSE+ZzD6FLFhGwlsi9wrC4qpSdvwuZKd4L2kDDoE2mZI+gqqhlimk/EQg7zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NTN1uBeagkAvlmVsJXWLq0++5aI7yNPT+ureThABAyU=;
 b=tec/CYqyaELDT+QD3xLqObGcSNZxH+0/ZIgVFtu4R4FN5gU60O5FlEUUBt47AqOrEq/t13RiF6zIWnGzqf+7Rj2GbW7Ye5d+qPmov/T9l+RjYALEMr7CKOZ2VIZ1jjS7E/0odM0o4ImVDBK08dyTOsQ+seGWr/IfX5fEKLvCiFzF5WenCQa/qv7uhnzsHBLG9DzI7njnqKE05NlZ270MfT+N4YxZ7Samc4r5heMXJbm6ePpFZmMnAzMaCabjwjbsjLzmjmUw+yfpgu23mXaNnFEWpc8HFMfuiHhYqU7Qaye1OVoJf0nlHl5lBGM/ViH4KTBFc0rG2/pX+MgiLyvLRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NTN1uBeagkAvlmVsJXWLq0++5aI7yNPT+ureThABAyU=;
 b=hMYR2iwLa4SP0+0USnw7bhtIHw05X05aluYfTFi64fi+HH8CN1ucuKSLzUrbdHXLLR0G4zPFENmPOVMtJRtoC3bcYHKpC+JFFTC1kGeM8TJNAwW5izRzhTdCDW5bW27WH09psBujMZGlZWxNtMfKPFkDWwV3MnpMPajSVtDUxb4=
Received: from SN7PR04CA0077.namprd04.prod.outlook.com (2603:10b6:806:121::22)
 by DS0PR12MB9321.namprd12.prod.outlook.com (2603:10b6:8:1b8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.18; Thu, 5 Mar
 2026 03:08:28 +0000
Received: from SA2PEPF000015C6.namprd03.prod.outlook.com
 (2603:10b6:806:121:cafe::1d) by SN7PR04CA0077.outlook.office365.com
 (2603:10b6:806:121::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.23 via Frontend Transport; Thu,
 5 Mar 2026 03:08:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF000015C6.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Thu, 5 Mar 2026 03:08:27 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 4 Mar 2026 21:08:20 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v4 3/4] drm/amdgpu/gfx11: Wire MES EOP IRQ to render-node
 eventfd
Date: Thu, 5 Mar 2026 08:37:25 +0530
Message-ID: <20260305030726.1779794-4-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260305030726.1779794-1-srinivasan.shanmugam@amd.com>
References: <20260305030726.1779794-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C6:EE_|DS0PR12MB9321:EE_
X-MS-Office365-Filtering-Correlation-Id: b2817ca0-0ad3-46c4-5a47-08de7a64790c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700016; 
X-Microsoft-Antispam-Message-Info: UjCWwkhokmFGKkLMeOAxe6jd5zpKUBRgiKnlGKBl0gJzr/kUV7NroB/doYD1v8IvFBLAKe1zbIC/QfgXyv2nVZmnT8+flq4gbz9gmTgyzjqLwgpT4jr9XkCIKZ5bkwfPDWt0y6zy0EYL561kRusm2XCV+G/iFTSgqd2jzCTVMbL/PUnZvLh1+l5Bg1ThuS/hlsC/MDkNoLlp6JATJVjOg92uvL72D3OmnPGZSC1A1RG+gN5AfSCBmBf4HqsT+WiIGbMsdqnDPcLqe0E5Ixw9G2oISNMpRPprh2LHECsoZgXVwkrS0jA0n5/HZvraOn4Bfu4fclgXptZY0eWVLlgtADZpDKB0k3RSFMqBGdg2E0lKtOI7IJ1FPEzYRa13h6tjBxXcXfGc4UJPOSX+F+srwRPJjmIetdy5m1fMXTMZQa9cuG74jkY+y7NouHok12OkRLEEzianXSQWQkS5Q959Td/IGMVR58aAXBkh59Wg7+YNIUOih960CUwW8UdlJ9tKQEJmC1yHprVPvBP4bF3QM7c8RCkTqcuOurUX7dFOd0dDoOoebCKU80eVVHe8KllErcrFuci7pXecs0pkvUntjbITSmrqwByKLIjRI2xwM9c6irqk6fMr0rklixtG/cA/DWaBr3k8pIR075+mQJTO4F707kBMJXvg6o7187yDUZ9MCfSFS3+hVeK9c7DTTMsMaa7w5CvocsZqMzqFewSHCV0bzhPGMgb3tGyIkhb0M/3krTQYSmNEvLDZ5S+7qnK7vGsni5YExAxV/Jf0DzCO9w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: xjzZ3D9Rg4AIJHbsEpVE7ICo/WjeD2rMxgYdZhf8OS9ibC9VQitkHejxqmHMDEf8VJEYwD5qM+ft29EQmoGbMbfEv84z7R5lF0xBCxgX9WCvjf96qEr7NpsZpsnrFQJyCZWSvTh+RxRXQVm7Ud4BppvIAgoKI5kSK0Bojtgr1yf+m2/IdHGHdxc9x52PIloQJDGyCDqiIIfYqvQqdFHhk7BrfuTcRvMZAzn0tarraa7BR3sG1ryBlAVnlysZePT2eggsbnc0szj1Btl6fkppKu+w71cbcnyjfj1zUT3+yWlcOm2AkhCytMK7hSTMjYU/emYr9iGt7Xl1tBRbY0yxqf3fqf/8lgI6SHt9NKolkTImRRyP+heo+IdYsjkym2970QkkDWTp5JmcLzDmM4IMwDnO6Py50XR6gJjpCvu+enNuoLbSEqvxUjI0f7kGQdZt
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2026 03:08:27.8745 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b2817ca0-0ad3-46c4-5a47-08de7a64790c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015C6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9321
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

Signal a fixed event_id on GFX11 MES/userq EOP interrupts.

Resolve doorbell_offset -> userq (adev->userq_doorbell_xa) and signal
the per-file eventfd manager embedded in amdgpu_fpriv.

This avoids storing eventfd manager pointers in longer-lived objects.

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Change-Id: I53a61e1d58983ccc99e1978effee72aac71ee0b4
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 30 +++++++++++++++++++++-----
 1 file changed, 25 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index b1a1b8a10a08..8af57625d7a3 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -26,6 +26,8 @@
 #include <linux/module.h>
 #include <linux/pci.h>
 #include "amdgpu.h"
+#include "amdgpu_userq.h"
+#include "amdgpu_eventfd.h"
 #include "amdgpu_gfx.h"
 #include "amdgpu_psp.h"
 #include "amdgpu_smu.h"
@@ -54,6 +56,8 @@
 #define GFX11_NUM_GFX_RINGS		1
 #define GFX11_MEC_HPD_SIZE	2048
 
+#define AMDGPU_EVENT_ID_USERQ_EOP 1
+
 #define RLCG_UCODE_LOADING_START_ADDRESS	0x00002000L
 #define RLC_PG_DELAY_3_DEFAULT_GC_11_0_1	0x1388
 
@@ -6488,14 +6492,30 @@ static int gfx_v11_0_eop_irq(struct amdgpu_device *adev,
 	DRM_DEBUG("IH: CP EOP\n");
 
 	if (adev->enable_mes && doorbell_offset) {
-		struct amdgpu_userq_fence_driver *fence_drv = NULL;
-		struct xarray *xa = &adev->userq_xa;
+		struct amdgpu_usermode_queue *queue = NULL;
+		struct amdgpu_fpriv *fpriv = NULL;
+		struct drm_file *file = NULL;
+		struct xarray *xa = &adev->userq_doorbell_xa;
 		unsigned long flags;
 
 		xa_lock_irqsave(xa, flags);
-		fence_drv = xa_load(xa, doorbell_offset);
-		if (fence_drv)
-			amdgpu_userq_fence_driver_process(fence_drv);
+		queue = xa_load(xa, doorbell_offset);
+
+		if (queue && queue->fence_drv)
+			amdgpu_userq_fence_driver_process(queue->fence_drv);
+
+		/*
+		 * Resolve per-file manager via queue -> userq_mgr -> file.
+		 * file->driver_priv remains valid while the queue exists.
+		 */
+		if (queue && queue->userq_mgr)
+			file = READ_ONCE(queue->userq_mgr->file);
+		if (file) {
+			fpriv = READ_ONCE(file->driver_priv);
+			if (fpriv)
+				amdgpu_eventfd_signal(&fpriv->eventfd_mgr,
+						      AMDGPU_EVENT_ID_USERQ_EOP);
+		}
 		xa_unlock_irqrestore(xa, flags);
 	} else {
 		me_id = (entry->ring_id & 0x0c) >> 2;
-- 
2.34.1

