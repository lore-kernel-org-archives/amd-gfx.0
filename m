Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20208C624D9
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Sep 2026 20:11:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B654710EEFD;
	Tue,  1 Sep 2026 20:11:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="o6olv8ct";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011063.outbound.protection.outlook.com [52.101.52.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F34E10EF01
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Sep 2026 20:11:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qt7+iwUed/qz8MqV/XII0tJgNDZwyEYGW5GP+9JqhopUH5p2D1Lp3IVD7/EQauwDLAjAbYxQSMgywVTZuyXL0MtXHqnFKkJoLtDiEX+5h1V1Q6WROUVrljNkcV1XpT4cQeYCXq7TMcE3fCkEaMVxd/CvTdCYSNT2mpBZXyZyO9D23Jm4TgH35CKo8Xm7Ny6uY+rTUvw/i5b5DwC0PSCCz1TypOwSHXw2KFQYviF7nnjpMO6KcJDKAxqK+ZtCVb/GHsyyJtqfWisgPfRSgyPQhPuDMXCwwx014bqU+xulHRrh8QyuLbJ9LXg49tAmQVlF8czTjB5+caOllrUTfGdk0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1MAF8EnS2n11vV9k+8X0JMF6pNF8GevizhGT1W30uv4=;
 b=tfeZBBTbihGEw61pFlwoSRxsgnZsy2Mjfo+G32WdaO5Vxr0rY3QTAeyK6CqMGCf5TRRpNbtEYQWALt2vUov8eXaGfnAI10kO8v77X9P2sXJYUkpFjhrC/1uxOR+nnRrTkLspXdfrgS24rVRk5EPnNA9aetzMbt9jgXDOWfhIubYaLLuQtcnsXAnEJF7OspiYbRPivDS6TgswwG0fFzgzRXpRncJe/7pEv7bb8y0IY7C9fHS0v5y1S2L7lr03XH7z1L7Hwx1EpbBknJml0i4yYSKbe/rvWkkwAi2UttbLfUs2eCz1ElozH5lMz7CJPvVf4DksB4M+zlaua7KjpDUyqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1MAF8EnS2n11vV9k+8X0JMF6pNF8GevizhGT1W30uv4=;
 b=o6olv8ctm1+yO6DoQUwUZX6mR+t6Dv04vmMiKbiN9bb8tTWaptZfa/HoxHqHT5QtjJ8zrw3qrndwwFlv8HELiraKJey0KYh0BrqevpDwGs3tVynfexZQE3KOyjri26JTXQRe+p/aoWaE2PsOoHAW4fy4sAM9BnSgQ/Pbs1/4+Y8=
Received: from PH7PR02CA0017.namprd02.prod.outlook.com (2603:10b6:510:33d::9)
 by BL1PR12MB5802.namprd12.prod.outlook.com (2603:10b6:208:392::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 20:10:58 +0000
Received: from CY4PEPF0000EDD1.namprd03.prod.outlook.com
 (2603:10b6:510:33d:cafe::26) by PH7PR02CA0017.outlook.office365.com
 (2603:10b6:510:33d::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.10 via Frontend Transport; Tue, 1
 Sep 2026 20:10:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY4PEPF0000EDD1.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Tue, 1 Sep 2026 20:10:57 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 1 Sep
 2026 15:10:57 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 1 Sep
 2026 15:10:57 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Tue, 1 Sep 2026 15:10:56 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 17/31] drm/amdgpu: add tlb invalidation method enum
Date: Tue, 1 Sep 2026 16:10:20 -0400
Message-ID: <20260901201034.2960437-18-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260901201034.2960437-1-alexander.deucher@amd.com>
References: <20260901201034.2960437-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD1:EE_|BL1PR12MB5802:EE_
X-MS-Office365-Filtering-Correlation-Id: 561484a1-fcdf-4133-531b-08df086522b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|1800799024|23010399003|10067099003|11063799006|56012099006|3023799007|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: KqX350tbvzUhj4XjYULHvbBuDp2udiYMkAeDOCIQ+S4YKt6GgWfixGX6tYwqA/yVvm8pfKasynujFt8HwnK8KQD0DRMtb0JzVlEXk4udiMVi9/WDw8E6rcw17Sh9qot2u9VijLs15iwtCQEsJ/PFbyh4OqG87MdA/TCxBbHWRT07HAPL765rzzpx4Gcsc07rXBEjxagFF7QPsnTTH0Cov/ZWlOGZ9v8NOqwLJfs3ahai5KedZf9znLbhYPjVBMHAdMnrOPJrF80pQtkhPGRuxJhjDwDyfmMEluY6FwE3mMnRo3P9EBcGukBbBx3FYmBNV6LDHpEY9Bpz0NQrv8Xsfko2r4EB7+DD7CirhVyrgIhqWIIUl6armCDJTSjRkBZACLDPxVSOVJQ6kGkjdcCnzY+RpHkO9hNRAQHgWl0AVWiTgY58CNxSoDgW6Uo9CWEAvLV7plbFja9yXWSHPuIiO3pWrBN9wcDcW20pqj+ATHm9v6j7ukP8KxHaGaa41TWSoqoWFCkjDtJ8ERyJN5AzJokHnalMwoq+3LoxKnKQZSXda1LDfvEfwMU5rsXOOW3ZNKItkUMRI0VK/ADj6xWbu1xzrDordf8AJRP9nLHVLfevWLS5VvdG83nGEuX+rVgqER/lA/SMaQQBDJfcpQjxI5j2h7E5CI1Qfwprs5avIwC71b5ndbA/oE3XbDJhlQKIOtozJ7o73/h3BEZm5hbvmg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(23010399003)(10067099003)(11063799006)(56012099006)(3023799007)(6133799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 0ZtT1n/4iuo0cIOJNPFXHHkgTlHu73tmcDV2qnPAXImuW69PlxVXiX/qtOpei6/owVshzdhp7GX5GKq5rZETLKSIR7RMMeJ3Q2zI6nKUZyKP/rJ6mnwIqqMxaL6Y6KYQMcJuqNeX5SwuNkm8XVVdoFpB5hBcL17o3zrvpxsL9NbShA3SslEUVdwwTJ2CnkwDsdlpJ2AoNctzyLqH4Ymtk17ADnerHWTqXtxlRUgMWOhanJz22jqdH/ZtMmlxC6B6wkrkY9dgmgZAXU8qzwBvcM3yDEat0GpGHTAYZGdO2AGXMz8anLi/L0SvHRV2RYiGxv7uIdyDCR5iBRh1y4WyINIBsMgBMoC3PoYuJufHUdUwton8mySLGAZCpxJVhKBziDpXRBfy0+vdgyjp3Df9bPpR6IEj6ko7+e11hs3iC6KM/JnqArKWzrWQIudHwuRX
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 20:10:57.6013 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 561484a1-fcdf-4133-531b-08df086522b4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5802
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

Use it to track invalidation method.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
index 23954e3180a8c..204cf1c360896 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
@@ -98,6 +98,13 @@ enum amdgpu_memory_partition {
 #define AMDGPU_GMC121_FAULT_SOURCE_DATA_WRITE 0x200000
 #define AMDGPU_GMC121_FAULT_SOURCE_DATA_EXE   0x100000
 
+enum amdgpu_tlb_inv_method {
+	AMDGPU_TLB_INV_METHOD_MMIO = 0,
+	AMDGPU_TLB_INV_METHOD_SDMA,
+	AMDGPU_TLB_INV_METHOD_KIQ,
+	AMDGPU_TLB_INV_METHOD_MES
+};
+
 /*
  * GMC page fault information
  */
@@ -369,6 +376,9 @@ struct amdgpu_gmc {
 	bool override_pte;
 
 	bool use_mmio_for_tlb_flush;
+
+	enum amdgpu_tlb_inv_method gart_inv_method;
+	enum amdgpu_tlb_inv_method pasid_inv_method;
 };
 
 #define amdgpu_gmc_emit_flush_gpu_tlb(r, vmid, addr) (r)->adev->gmc.gmc_funcs->emit_flush_gpu_tlb((r), (vmid), (addr))
-- 
2.55.0

