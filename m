Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92A1FF513F2
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Mar 2026 03:43:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D26E710E317;
	Fri,  6 Mar 2026 03:43:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BoFWLlIa";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011028.outbound.protection.outlook.com [52.101.52.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 99D7F10E313
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Mar 2026 03:43:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CRMauop5GF5Z33ld8BZrL7F2Bz2YToG6Iky2Hy9yCxexLRmb16IaaK+rHqG0stYO/OfIuAwZZD6FhcsWtuaxFK2XfghqOVTbz4YRtaErEnMI3ndkVl7jFEmnv9MCyV47MP1+wILvlrv67mXjYHsfGnPoat4K1CLt034aAI+U6ON8TBbdn8iOxhrzbpR9iPW9JqNBDvrbxH3K9DJeOyKWMVEXdRTfz12Nt5Rm/eAnkf1Vn22oxpWvC5mK2LpiAfcMLZzu50rGTObU/2GGw8h2g1N19d8O1YkmyTtnF975ydtdZHJOxfzIAYeVqD9zK/XewDVQlVk+lrNWRt/3PRWxcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x4iJMGjqPxqVObCJfHSbHoTkMAg6P8Oo9irDNEbN7Uo=;
 b=PbFvaJz7iSm3KiazT/aeZ6sq2ZAsVEcl9jPWYEfv/9lI0oBaL2HdAIjw+EewpfAz9BP2rYzNmyPKi+SEbb+mMIT9W2k9FMWTWyDS6EhZnuQnV9zz4BHnn/koS+IdgWJvsRPIU8ucQVbRykOstf6AqDt2HjjyIIS+sWcqc7Pag0dMU9Dq565u8EME/StUXkXBioAm73jt0jd0R4K+K/sevZVpOOfvBbS7GcyyOopsT8g62v1VyfJRo2f1LM1m7Ydu32FE++jdmFXGbQjYubCC2irw27LJfBcG5dtJS8Ruo/8eRH4vwhxQRMKMn0IFHTSusCUb/zi/Jen0RyY+wBZrBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x4iJMGjqPxqVObCJfHSbHoTkMAg6P8Oo9irDNEbN7Uo=;
 b=BoFWLlIaR2beb5CufRL/tekS686qu9dPgo9BnrjMnffm70ZiGmCqjaBTZZzGOc6nSVoiae167eWcOYZZxUVGeNYhJhFepn60v3IuvW3ufilw3/kM7rRZmyzpimXlKN44ynEFadWa+pOGzlTOmgiCdKVYqdc0HhDkeXKy6xQAczE=
Received: from SJ0PR03CA0210.namprd03.prod.outlook.com (2603:10b6:a03:2ef::35)
 by DM4PR12MB8571.namprd12.prod.outlook.com (2603:10b6:8:187::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.5; Fri, 6 Mar
 2026 03:43:09 +0000
Received: from SJ1PEPF00001CE1.namprd05.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::c5) by SJ0PR03CA0210.outlook.office365.com
 (2603:10b6:a03:2ef::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.22 via Frontend Transport; Fri,
 6 Mar 2026 03:43:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CE1.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Fri, 6 Mar 2026 03:43:09 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 5 Mar 2026 21:43:07 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v5 4/5] drm/amdgpu/gfx11: Signal render-node eventfd via userq
 manager
Date: Fri, 6 Mar 2026 09:12:46 +0530
Message-ID: <20260306034247.1783347-5-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260306034247.1783347-1-srinivasan.shanmugam@amd.com>
References: <20260306034247.1783347-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE1:EE_|DM4PR12MB8571:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b9236f8-8f63-4adf-4238-08de7b327c53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: zpVReTb0fWCgP+A0K2rTz/IpfrwERkI3m+x6FzQSpIENzl6NvH7WrudPEYGz8H8kK242Jl9ZIXFRICnMJw5zjRl8d7yR2FjyaQdvaYhdzl11umdYuqF502M7Tp9XTamcmMfVJao3r+Jsj5pNYptQ7WMtGUWQZIFdPkMLA9vrcO+W/fx3AUw1cVxIvx6qQV06MuNLy/pVBWrDRtLArI6NdGGUDe7fIp7ImZGd/ZpvPWe2ot6YIWhVBqgKEhfuznyxzyvIsjeM+As0LW9GvfUaF8HppmRurrLdUhpgwtQAhMoBvZyzKNw45SQG9Oo7TmsGTQBygWdbaYqy35uN6Q04WHq4X+BU/JNBcs3C8SLyXWuWkmIrx25sCOywDlFCbcP6Rtei+vbeh1tghFCVzS2OfaYozO5LfkQGX6lfIMwv3bSdQXleTmDEjd8Z83zmLBCG5LF9DKOXZD+YZI5dfeUJirbAplZZdQrvBh/NTeGabrOeafJ6wJK9xRIFmCJ0QUvyF4eKKGB8kUZ5+akntZiLJjQF8RoKx9BK/BadlF/CwMZ7Gb7qSPx/zrS5MUrrKcrG7SVlMHtD58mE6l3+XyqtT5utWfqVhJrInhNuCTpQusFl2USlyQXhdqLwlE1j/PX/fWlaVaqdjN08JNLpzq+OnfdyGgJ5tURIVubQlPVdIi9NCK3VVbQZQmRP0YqO4FmyZmi+dNZ/NFXr0YYv40U793MfsLCQSN/qRo12SN77NH5/A+zsW9gz/THJ1LsIk7I2nwkEZvQwXtGHGpPnUx7Www==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: vwP7hRhdInDRBfBPPfcjZcrYxg5+u6S7FfJUAveSe5zYr0+cghrnEDWE5eJ4p8gLlAm3zGE5QmoLMOX6OnnF7/Iqxj+k1ghwXkAtW+4Q5jLN91E3a23tpR6rP4cRADV+JRw6sMnk4aAnetwRPfndYdiGC/0UtJ75IaNGTGHqAsUVF3JNxVqWXzbEdARjsXUhw9a1+qJa/9XJOvKW6bos7arh6PX6fbf8HhSpuSnEATH2dDnjOKieV/dvfdgLQeja/oV51nPSqX1P3m+zP/oaGwLSy9nlyb05kIKy46m2oYgvuO/BZbJtiHKB4S8fPwnRN6N5EvXJT2UZDYP/mCZYt1nd+fJNaCSTpER5MyyDkLIvVJrFQhiYapMLzrilvWZ09hGN79wRHU0Q8SlMhtib+SlY0nX3TA2MXSFQXKAKga8pd4nwaRZH4dYEmG5rSnUy
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 03:43:09.6447 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b9236f8-8f63-4adf-4238-08de7b327c53
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8571
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

Signal the render-node eventfd manager directly through the userq
manager associated with the queue.

v2:
This avoids walking queue -> file -> driver_priv in the IRQ path and
drops the READ_ONCE() usage there. The userq manager holds an optional
direct pointer to the per-file eventfd manager, which may be NULL.

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 27 +++++++++++++++++++++-----
 1 file changed, 22 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index b1a1b8a10a08..e399d8c79a0e 100644
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
 
@@ -6488,14 +6492,27 @@ static int gfx_v11_0_eop_irq(struct amdgpu_device *adev,
 	DRM_DEBUG("IH: CP EOP\n");
 
 	if (adev->enable_mes && doorbell_offset) {
-		struct amdgpu_userq_fence_driver *fence_drv = NULL;
-		struct xarray *xa = &adev->userq_xa;
+		struct amdgpu_usermode_queue *queue = NULL;
+		struct amdgpu_fpriv *fpriv = NULL;
+		struct amdgpu_userq_mgr *mgr = NULL;
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
+		 * Signal the render-node eventfd manager associated with
+		 * this queue. The pointer is optional and may be NULL.
+		 */
+		if (queue)
+			mgr = queue->userq_mgr;
+		if (mgr && mgr->eventfd_mgr)
+			amdgpu_eventfd_signal(mgr->eventfd_mgr,
+					      AMDGPU_EVENT_ID_USERQ_EOP);
 		xa_unlock_irqrestore(xa, flags);
 	} else {
 		me_id = (entry->ring_id & 0x0c) >> 2;
-- 
2.34.1

