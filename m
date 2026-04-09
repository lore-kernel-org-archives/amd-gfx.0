Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FA4EF31E21
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Apr 2026 14:19:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE69410E2E5;
	Thu,  9 Apr 2026 14:19:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XuMYmPOr";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010042.outbound.protection.outlook.com [52.101.61.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C2D4E10E2E5
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Apr 2026 14:19:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V5t9hNeKVdm75kbWx2ydEXpVUEsqfCJ7fVZ+9R/jhwm0sxT8n9nQaYWMvFZPzE+733LRJixfB5ArpxRxtyvtugDeK5gGlgtmHXPeHGnNpmUA5G+9eQb/VZ5EnDXeLFnYLcZluNTd3p7m1M4fRF16ZESZhtf+aWS2gDfugvF4Yx7cYeMIg0x65GNBphIT0rkvXpOViaN7vQT3FulaazG3vpW147FPl7g5gznZ2L+2HMKM2AA1CcFn9ooeyGAP5cjrcUDkcJ9uNAsmEcDad/WKPInd+TF/DT1sYRk7IiSsShdg9F7nMTYeEm7rDfQieiIQORh18yUrvjG95+8iSBTFRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V9mtu3tEg4u3GlTRwm86oCuVVHVp3PXMF1BgvABD/so=;
 b=CFVgF+CJkl5xIqrM9lwgvpbvPZm2Kg6YZiWSEo2nEXViZkC+be6Zu7H2fKIXGF4MdHqb0T9yEe2YczXHUxM5F5Fmqw0UNudjQt6fptIKn+dF2NoZAQxdSWOQmPc8CsZTuZa/fnV9+7r+sdH6GNenx4I1jFN1Bl5YCUEFO0GX9WACGuhI+EGuT8HwSy+RHTiK/xNT7KBe7R5gFA/989yiTchB33QArGVDdjhx/jKTHlGvYtxgqraeiUt6F+w4XLViYM1O7XjrtyS/zEJAKF/7MtEBPF3QFgesQ+dYUilUErqUXAfQ//GPabkw1lAmokso9IwqW/eunCZxuxAyyy4RxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V9mtu3tEg4u3GlTRwm86oCuVVHVp3PXMF1BgvABD/so=;
 b=XuMYmPOrHhRYgoqoTNLcnrXcCEGWpurL5rnmqetuoOl3uhCEeFtFTZxz5ZNDpHSq6rsSNq2/2vb3QXgd9rAITog0YDtvPOsVT5NIgGShGgtR/0mqc/ITHqC6D8hVSW13VpuMVwyMsggVhP3YpOjtGGa23GmjSswlGLQuDIkEO8k=
Received: from PH7P220CA0037.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32b::18)
 by CH2PR12MB4215.namprd12.prod.outlook.com (2603:10b6:610:ab::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.18; Thu, 9 Apr
 2026 14:19:30 +0000
Received: from CY4PEPF0000FCBE.namprd03.prod.outlook.com
 (2603:10b6:510:32b:cafe::a3) by PH7P220CA0037.outlook.office365.com
 (2603:10b6:510:32b::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.41 via Frontend Transport; Thu,
 9 Apr 2026 14:19:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000FCBE.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Thu, 9 Apr 2026 14:19:29 +0000
Received: from amir-devpc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 9 Apr
 2026 09:19:29 -0500
From: Amir Shetaia <Amir.Shetaia@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <felix.kuehling@amd.com>, <harish.kasiviswanathan@amd.com>,
 <christian.koenig@amd.com>, Amir Shetaia <Amir.Shetaia@amd.com>
Subject: [PATCH] drm/amdkfd: Clear VRAM on allocation to prevent stale data
 exposure
Date: Thu, 9 Apr 2026 10:19:18 -0400
Message-ID: <20260409141918.1317087-1-Amir.Shetaia@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCBE:EE_|CH2PR12MB4215:EE_
X-MS-Office365-Filtering-Correlation-Id: cf11edc8-f7f1-49fb-4fbd-08de9643038d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|82310400026|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: Dta0bVSxsBRLHooF877fk2Zs2egFtJaGGg4oh7PedyTc61ZcVeRxMPEwFxbmBtMFVs8lABN++QdYDxloHqUuWhLa4bCLblELEBdRNv+LkKLyx9VUHOYR7hqxRkYvokcodabFLfZ+nSjhgcFIs7BOxbJUVVvOgdcrJqXSqr83ECXCJmHTcoNVMSJO/MRkw6v7IbEkouvVwUPZOerlr1D95FPA/9LbbyaWFhUO7gTxmVGMtXwpZuyBpemu2S046/rKLPR+Rtn0WPS++zI9cvYqFCC7tvEm3GyB+Po0GNyarcdQ8YBeSIiMZkdvbAouTDQD8nTi/9wkti3vbDYRpx2wYfEJWiDrpBei8AjzC73y59lgJGj3Dny3iJWsK8pQV55bPJyndW/8l2cuRYp/qIoRbFcnb2JfXxugqC/8zNNZ1IfTtkDdLcFoXM24tr8JwB49YF/BSMBAxvFfVujcculOi5NxF/sWPETSfNnr0ejP1kQgEUg1FKH22Cv1k/epGNYGRoq+051lx75VVZBlSVKrjJyM7VLEAj9qDqEVAnorzB4LUEFaU+7UU3iDIKkN5GxzpY63Cq0x/kNIkWGEh8/bP9NceVfvbicHas/85+8KWWRd5FAW7/S4WIKT/cgfULsyl7MvcTEuN3QnAm7JdhWlMKLzOqR41zMoHaTjp5bip08hyMqg40d8Sr0dGMUsM1DjfQZmPD9FM2HandXsdjtq411TgOTdhXDMGmw2MMoQ88/Dv3FYmA41vflGaKldjg+bwW6p5tGB66Alguvj++7jFw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: N7xiCNa9zw7+JjneboCuaiBtXuinxe8u8P646nLPcaVxAyM46YfEIh0c3e80o2jk5bZfRt0S4ZEynkh+QTgBXBKOD2ue3IevXXWruKWFgRvEn+e2y74BqiWQ7Jr94FpOI4FxKrNAHquvQHEC4iBQCBwd1UCMT5WSjYhA+co5hhVX3rXw0P0RIs8xKOGDBfU+d7Mu8EEv0qFbDUFgUyoZrRSQMjyWrGwwpavA1R8FzwtPNRns76eTTawnzVLY5pWQ9xkl+sdseubuTfII4hgUHkv1iZ/lGSaMZoH7oEOLbAUs0Cp0TRXb/VK4GPD3cMGfjoIViJfOSnrs7btqAaK+XwsoH4vYmvGXeY7GqjooyeALzFn+Pv1KkCqx+c8n3l8YpP2fr4DF4lXsCZrVZBzdq/nqf4ICiohOPztqxMoW1zr0uswyXD/xZZ4k/mwSIn/t
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2026 14:19:29.8872 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cf11edc8-f7f1-49fb-4fbd-08de9643038d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCBE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4215
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

KFD VRAM allocations only set AMDGPU_GEM_CREATE_VRAM_WIPE_ON_RELEASE
(clear on free) but not AMDGPU_GEM_CREATE_VRAM_CLEARED (clear on
create). This means freshly allocated VRAM BOs contain stale data
from prior use, which is observable by GPU compute kernels.

The GEM ioctl path unconditionally sets VRAM_CLEARED, but the KFD
path was missing this flag.

This causes data corruption in applications that depend on
VMM-allocated memory being zero-initialized, such as RCCL P2P
transport where stale data in ptrExchange/head/tail fields leads
to HSA_STATUS_ERROR_MEMORY_FAULT crashes.

Signed-off-by: Amir Shetaia <Amir.Shetaia@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 8a869fe41acd..7c01492e69dd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -1735,7 +1735,8 @@ int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
 			alloc_domain = AMDGPU_GEM_DOMAIN_GTT;
 			alloc_flags = 0;
 		} else {
-			alloc_flags = AMDGPU_GEM_CREATE_VRAM_WIPE_ON_RELEASE;
+			alloc_flags = AMDGPU_GEM_CREATE_VRAM_WIPE_ON_RELEASE |
+				AMDGPU_GEM_CREATE_VRAM_CLEARED;
 			alloc_flags |= (flags & KFD_IOC_ALLOC_MEM_FLAGS_PUBLIC) ?
 			AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED : 0;
 
-- 
2.43.0

