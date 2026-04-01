Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D72810FCAC9
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Apr 2026 20:21:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0CD0910ED36;
	Wed,  1 Apr 2026 20:21:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xgaXEDco";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012065.outbound.protection.outlook.com [52.101.53.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 70E6210EDE2
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Apr 2026 20:21:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GiaMmFZSNIS9uec36TWUlLvWnnfqrZEx0fg+OxpxULJgRGmjTXR4vTAoBR6vct/6BEO+jJVNZVK8ztOk6WQbl3xphxKmi00NlblQNPwg5+QGtpmg+CaTgloFyKs0qAsXz4i0MHb64iN7UpbKtzaij9mzkcLYbnpFH8fPoxs2XGF6WJvmaI2S/thNhwOquqQvdlyteRjzZlavi156sW9Bhnvzip7UJwNeT9kY8ekj/Nv7fyKsQR8nSSwFbsYnb79rfMvdeO59wxv4hEUfDQpSVQB+0e8VwmPM6/NJ5obsUoMeW8xsmmwANsLFXLjpjHAm37dtesWZ4kCsrY/yKW3WWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V9mtu3tEg4u3GlTRwm86oCuVVHVp3PXMF1BgvABD/so=;
 b=Yb/W3KEEee+Dawc/+BIJABl0Zt/HBrewAGmFTLhO3OFUV4KA3k5sVMDUfMjamBf9BxkLO6cAwY8eYtlAlrMXquC7xO8izTqmnqXO45GAK9nWDqFm2i75u7emvcBgSo/K3M1SBQbwa8jGh+nI6+LiXpvo+IF2fWyLZcKI0fqMao1s9RDgIYp1Rsj95/hXeCnYNEIS9KWxFbYxEmreAL14+wGyxr9sDcI8Y2t5iBVx8fZuzU5IoPz+ID/tFNFs0Eo5VDPt8YRd4hFcdytis1eEQLFLaXRJegkc+tXXIcB9sUYtl7VJ8y0O2KysJ0JAAB3LbYHZYdcULtHz+lqC80DzSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V9mtu3tEg4u3GlTRwm86oCuVVHVp3PXMF1BgvABD/so=;
 b=xgaXEDcoVLThkFSEVsEMWlvFGw1se2lv3ePdna3+WCr5iugoSDq7FmusqvncSMblVznsv+A2o1eM3znLZpSniOxiwL07nR7f+KeNjJRNnXBaNoCpqiWAndIm8Xku8bnxWVoxBgdfqcFW5oscgJngj9BpLs9WGQNUpGTsY3fPbZs=
Received: from BL1P223CA0025.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:2c4::30)
 by SJ0PR12MB5662.namprd12.prod.outlook.com (2603:10b6:a03:429::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Wed, 1 Apr
 2026 20:21:19 +0000
Received: from MN1PEPF0000ECD9.namprd02.prod.outlook.com
 (2603:10b6:208:2c4:cafe::a7) by BL1P223CA0025.outlook.office365.com
 (2603:10b6:208:2c4::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.30 via Frontend Transport; Wed,
 1 Apr 2026 20:21:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000ECD9.mail.protection.outlook.com (10.167.242.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Wed, 1 Apr 2026 20:21:18 +0000
Received: from amir-devpc.tail3064dc.ts.net (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 1 Apr 2026 15:21:13 -0500
From: Amir Shetaia <Amir.Shetaia@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <felix.kuehling@amd.com>, <harish.kasiviswanathan@amd.com>, Amir Shetaia
 <Amir.Shetaia@amd.com>
Subject: [PATCH] drm/amdkfd: Clear VRAM on allocation to prevent stale data
 exposure
Date: Wed, 1 Apr 2026 16:21:08 -0400
Message-ID: <20260401202108.1564982-1-Amir.Shetaia@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD9:EE_|SJ0PR12MB5662:EE_
X-MS-Office365-Filtering-Correlation-Id: 02dc60ef-df29-406b-ec55-08de902c3b8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700016|1800799024|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: K1biDv7Sf/N/Zjqc9fgJCW2dB+d+ZwlT8m8p1S3iU0uVj6ERKxqQliWfowR3H4riRi6a0rKn5WT1RYtGNDIypN1/8IsqOE1hhCvjS62of5d1AjvRSesS/kse8IdcVEsdWMwlA0B6ABgm8WFQrq6VQ0VJmCdg5QloWShwpRVVaCKlIbjSPLkSvewCDAyhpRnLx5LQMCsyMh+mi9c8APdA6BJUQOo+RXapejHfOTEwpF+dozhkLn31t/K7yKoiv5fDWh3dlNNcB4/0ZMKnQXm2zBUn5HccDfBE4CfSsxarVO6Sh0eqd62GueD6TYL3rv+59jaCV+I1SMPBm/DhD+M+AISMQ7mPFFRqCpLA++p40Na742qpdO+9J8ZyTMHrxnTvNTBDWQ2D9B8oBvDeQNQtXWpED27GOi4CO3EwT8AqbgAakyF4iu9jB3emi1mQYva4SJeC7o//ggLVKEzDwBVMpUF89L4qaCXKI2KtOkkWjTNhJt5UlZDhOOaQfzJw3VHPeBeG3LH/AfmoVLYxoGSRTFgv2AveZboCE8K8bz6y/D9o00TZpycVeutfSWAH1ZR1yfz3pA77ooDjfwbJKhKvJepre/XF9J4OpOY3OIKElFreycMXoNqzqCesee+6fkOVlRZSBdvVNylV7J7gIgPqCu7dOB/ZsN71f87LDQfHSim0qJRCNsGH9YZJUU9dhwOZT24oCYDc3/etnPjbKOS4/IKNBnVXEnpPVI9uIVYhznP3fo+Wmjn8mamXkOX4rVzSW/zeKrAB6Pulk0F73RigKQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 7jXRRQq4DA2SDRyhxr+6BCWgBzqJXTkdGOmhs5sar4IiVJ2aw8ntg35PkTO5oa8ysDgOc8EJvzE6p2x4U2A/DAXYwJgyZ1p9+A/gvk+zlm+APIpH3d5pAw4TV1MTCpcXnOko/VoaMGXO2kTQd9s+p59UxRaXNC32+/rgS/fCpBwBYYqGiPO6Dn31WjROozX6Ke0WD/3WjT+bUrcjdAnWuos4ieIokxJjbMf9W9leKD7Ih065NuJQPSOCmDFYJ91QTonyErBbVZWkSVz4aR+aVQfvv/8U655NYHypnBHkhfTAm1p0i4aXCgstaAVMlO5wOg4xmeqWQ8jXn9eaWjxouy/cU5xQR1xfLjsNT7TkWou3PV41MEb/XxMDdwD3yXGqh78RKva/crrZmJQ6EyC+uSGFUajTEIh4ZWa83O+VLVjri3a3Z/KOYo15NSu+z/5I
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 20:21:18.4986 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 02dc60ef-df29-406b-ec55-08de902c3b8f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5662
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

