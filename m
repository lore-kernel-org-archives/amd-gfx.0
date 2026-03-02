Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3608AD58E49
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Mar 2026 03:02:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C053510E419;
	Mon,  2 Mar 2026 03:02:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="na12JA3m";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010034.outbound.protection.outlook.com
 [52.101.193.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD0F710E419
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Mar 2026 03:02:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PBz0BpfMUecwy8fmqIqiaxU4OQL6ot//VeG3TMln7fqix7qt/KT8WTJn8yYwuJGMVCeVyT3YMNc+s+KIke9nIQrfBr1QC/MnUIlhjMbj/ygaMO/dl/DGemxZRF5yqWE4xZyMStSc2UIIhBB+druSStjfxAAmuarav2YQcNNND3qzD3IVLqrk2QENg30gvBwiT/3NXZj0Xp/CRp/zoH4Vf1fqS3B3zF1kpzaeZ+AMgFLm6FVCmzjYxY9zP7CAbbLd4SsuRVKxiNEwOXQyy9UlzB+ZwSUhonqONhwaIoqxoSfxLVs+M0gmgFyERBSO8lM8QlAM1m8+Ra/0OVkW4MzAHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9fBpBxLERrEnOVlLeb6R+sxkKCFQj1qpBiIVXq9/P5I=;
 b=yn7ndRRLI/1A6z08mxPwVnEY8GLCBDXmgo7RgIoJv6H2Av8F/8bum0v7r9bl6j4MPWhz0qRiuGDibH7nZuTxoaNMBMS2XubqQYaHHyb+mWJLBAIl6JMQX3zPuaxPpba7g5Fi3nrnWpo5u2kk5mQ3BFF4Af8SWuea6me5gcVrp59w3qRmga31Q/FUvgkMarRfGUEd6e6vBv4Z8la7+sn3CMrko/1AcSMFZZE66ICbcocsb78VrUp6/Kw2y8JU0kw+xmPT2cxdLENazwEXRHRJ0f1QaAf1ccUKxuz907l3k4SCsfUJLhVws35azQNaGSJmonKdQX0QmA9jgfLRfpEsJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9fBpBxLERrEnOVlLeb6R+sxkKCFQj1qpBiIVXq9/P5I=;
 b=na12JA3mGkmfSGE6TRqx33O6XkGxWM1nZUcIWVyPzpDM/Ze8Mpztc4nyWgmM9JfNFulqUa9Ejr+wCWYidq9OpJsQR7t8E1koH4M8DijjP8v73s75dEy43Mzi/ambnyGKKXlUZd9lroho3T2JzBWW7fL4kF/qbbL6wVygMIWxyTs=
Received: from SJ0P220CA0030.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:41b::6)
 by CH3PR12MB8972.namprd12.prod.outlook.com (2603:10b6:610:169::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.14; Mon, 2 Mar
 2026 03:02:48 +0000
Received: from SJ1PEPF000026C5.namprd04.prod.outlook.com
 (2603:10b6:a03:41b:cafe::5b) by SJ0P220CA0030.outlook.office365.com
 (2603:10b6:a03:41b::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.20 via Frontend Transport; Mon,
 2 Mar 2026 03:02:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000026C5.mail.protection.outlook.com (10.167.244.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.16 via Frontend Transport; Mon, 2 Mar 2026 03:02:48 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Sun, 1 Mar 2026 21:02:46 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Harish Kasiviswanathan
 <Harish.Kasiviswanathan@amd.com>, Felix Kuehling <felix.kuehling@amd.com>
Subject: [PATCH v3 3/4] drm/amdgpu/gfx11: Wire MES EOP IRQ to render-node
 eventfd
Date: Mon, 2 Mar 2026 08:32:18 +0530
Message-ID: <20260302030219.1734986-4-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260302030219.1734986-1-srinivasan.shanmugam@amd.com>
References: <20260302030219.1734986-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C5:EE_|CH3PR12MB8972:EE_
X-MS-Office365-Filtering-Correlation-Id: a70e435d-ff01-4eb2-505a-08de78082f61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: gTZiPkoHwhMEIQGu/QIjonJdh9AE/AnRYOXYvRe2UWY2M0DQZZYh7J2esmsWKhjJ7x4RtDMxlnqKKBiUOIQcrIUB0fd1bFxWJ8grDiqj6Bjv0iusy9v/K0T/EwzuvIoPyIOcOaW1TBV3zIzKnJXhp2c95yLabbYBzdK/YzINlXkFujClhe7uZSnRm8JZeByUe4Z4ESossCpJK7ek+8NbZO90ke30QJqXXr5MLQAtsTiNcV1DJ9v+fBI4YCj66uFl751lP+qL9++Fu9lhrni+9gTuc30uyymqxKl+14HiPSNnG0D/xDvwHHZyTB2ydgCuVmY02SvASGcPw8myMzuVCcsI1ZR9GoI/Ov8bLy+3Y05ayysvxWUmnes4ssgKLeBrNCaaglAx6uJuRfexRaIaUgpb9XVyHuPqwqu3SRkefCqg/MVeZ5gbsH/yu6njeFONFEbDgE+do7IE2xqDiPbN0ME915dOlVtPhxevvrwf9gGhvn3Tax6td/bcjRM/8uIItxCRsaSqVrGC/6Gagqo8wKVxqQQV3DFKgHSnuvNe5jKgz0cEOX1CPazVLziWmULKL0lnD6DtRNr0IQ1llAkGNxWekAta+Xui7MQiyYKoh0kqnTe+Mb8UUhLQcXIvtTqHhU7dYN97AIXCKwRCPkmGcjf2bVsR47QyeyDXe0NEgPaDdg2lxeOnvbZtXYjJXA0SL2Kre03GvXJrP+47u/qXGJWOccfpEcNz1GJr/g5ONDpSNNyzDiVEHoxKw3guje1In5tRtGoUCToZ4wf0j2eBYtukjh3tmlqTPC6p+VhHeYyoak5MM1CIpFSESRv5nojA/ct/bVCH1diw5g2EZvutBQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: MhmW+nXFQCUSOjohO1Jis2CZkyNuqESL41dcvIQsTezwn+hhhBNJaaHO7iOj8W3eS+DzxnfAGNFQfblFJrddmJgMeS2lmO4SQQS4vS9dNjS2c9Cz17CrQFYNQu+LG3u+KpxrN0rBcLIOFWOfBl2GfQTddATYZK3u6YTj+HhlHdnUPFo0DlyHGk7c4kZeg5SeNESvP/Pszj2K6KwcdaQ4EjzHVzAFEYn2uzxUQv8F1jzElgN8AcvHqsrLH1lzNv9bFeTR347MFlqWCszw+CUTbZKzcO4wSEfpO8QqOX3ULUV0ixNWylyuQD2gvPn4sEMkNYWdeYsCTVHJeFbzR4ne6EhU2K3zkf8BzHHCo2gggIMiYB4jNkA1KHPqTPhT88MOuMf+XtsNSJMUKrcjG3vc0r4cr8EvMvVHn2drSt6LGDVkrG7fQlHMnSpXsorZgJ3H
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2026 03:02:48.2490 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a70e435d-ff01-4eb2-505a-08de78082f61
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026C5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8972
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

Add a minimal producer for the render-node eventfd mechanism by signaling
a fixed event_id on GFX11 MES/userq EOP interrupts.

The IRQ path resolves:
  doorbell_offset -> fence_drv -> fence_drv->eventfd_mgr -> signal(event_id)

This avoids referencing amdgpu_fpriv from the fence driver, which can
outlive fpriv.

Cc: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
Cc: Felix Kuehling <felix.kuehling@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index b1a1b8a10a08..e84d137dfef9 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -26,6 +26,7 @@
 #include <linux/module.h>
 #include <linux/pci.h>
 #include "amdgpu.h"
+#include "amdgpu_eventfd.h"
 #include "amdgpu_gfx.h"
 #include "amdgpu_psp.h"
 #include "amdgpu_smu.h"
@@ -54,6 +55,8 @@
 #define GFX11_NUM_GFX_RINGS		1
 #define GFX11_MEC_HPD_SIZE	2048
 
+#define AMDGPU_EVENT_ID_USERQ_EOP 1
+
 #define RLCG_UCODE_LOADING_START_ADDRESS	0x00002000L
 #define RLC_PG_DELAY_3_DEFAULT_GC_11_0_1	0x1388
 
@@ -6489,6 +6492,7 @@ static int gfx_v11_0_eop_irq(struct amdgpu_device *adev,
 
 	if (adev->enable_mes && doorbell_offset) {
 		struct amdgpu_userq_fence_driver *fence_drv = NULL;
+		struct amdgpu_eventfd_mgr *mgr = NULL;
 		struct xarray *xa = &adev->userq_xa;
 		unsigned long flags;
 
@@ -6496,7 +6500,17 @@ static int gfx_v11_0_eop_irq(struct amdgpu_device *adev,
 		fence_drv = xa_load(xa, doorbell_offset);
 		if (fence_drv)
 			amdgpu_userq_fence_driver_process(fence_drv);
+
+		/* fence_drv is stable while xa is locked */
+		mgr = fence_drv ? fence_drv->eventfd_mgr : NULL;
 		xa_unlock_irqrestore(xa, flags);
+
+		/*
+		 * Notify render-node subscribers for this queue.
+		 * IRQ-safe: amdgpu_eventfd_signal() uses xa_lock_irqsave().
+		 */
+		if (mgr)
+			amdgpu_eventfd_signal(mgr, AMDGPU_EVENT_ID_USERQ_EOP, 1);
 	} else {
 		me_id = (entry->ring_id & 0x0c) >> 2;
 		pipe_id = (entry->ring_id & 0x03) >> 0;
-- 
2.34.1

