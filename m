Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEF39CF34C9
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Nov 2025 15:06:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9059310E64F;
	Wed, 19 Nov 2025 15:06:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JJlnsw2n";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011040.outbound.protection.outlook.com [40.107.208.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 33C5E10E64F
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Nov 2025 15:06:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G16nmSsSdePNjSN1mnm7riAorTKAW4F8Jlh5EYJqIPrlhwKBo1CBZeQa3yvoZjkskNRfsNnJ7+giHObW8rck2SfcGcjkDX4mPt+uUXxSRy8rSBdibtOLHh7Mpw/Q8a8qbWFrDPEd61fuejPZwzUACIA4tSMvHOkpUXLWQh7M35P4vqePQsNsF6EF6qR7owYWfhi+W1rmWykaQnTBAgtY00ur4WYQNpgPDNV1Jm3OBjHza8OJAtCm9nAQu/t87z78Vo3SL9O0p+8oiY/c9NPKjy9kNc9XUg1ELojGIEXjg+0nYSShQJ8PGMVp4FBwoForMNYyPjTk+TQUF1mcVGLsVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HUEBq0SKl/004dKRm/opJC/qqEwqtX/e7nW4oL3Q29E=;
 b=t0LxCXoEgT8wH7fUYMSIL1AUfXTvPtO3Y8Oc3BHe6TK+WHxKzbBShGOzCSLGJa/gU9EjcRVLH1M2SJpsloxNgqQLPJvl+OXK8WyHynaZB+ihPLf+37dLvZzGF8QjLPbX32fY7WCFweFZYvBc7OATDtp4p/3//mtNNlgR/G+L6X2pK6Q698V+RV8GSvrihv98BReAWJIkfNpkz3/s8GpQWCAAKN6sW8DcvGk0/kMJ0wh5/nRkIAAa4y4Jd87CA8bpHy7QicA8VkCToIoFuc175k/lD5JNHGp4xX5a8yDqfmkgbHpPWdUb8EG9ATFcGYMW9MAnArIkjNrbUM5RFM55ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HUEBq0SKl/004dKRm/opJC/qqEwqtX/e7nW4oL3Q29E=;
 b=JJlnsw2nw6Ij45ecx1STbPRzd5Xaop5QOSpSR5FIT0XHRGu/EPUhZsiNHtPRiV/kpDS3e7Qi3ok2wkTOKI0plRk6lMvqUIYcHFng+uftmE5ePRRgieQwTv3DzxanHBe286s7rzhyU1Pd14PPvWTlzsRAtaEf30hbBBUH8doXhWI=
Received: from BN9PR03CA0722.namprd03.prod.outlook.com (2603:10b6:408:110::7)
 by LV2PR12MB5749.namprd12.prod.outlook.com (2603:10b6:408:17f::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 15:06:16 +0000
Received: from BN2PEPF00004FBD.namprd04.prod.outlook.com
 (2603:10b6:408:110:cafe::f3) by BN9PR03CA0722.outlook.office365.com
 (2603:10b6:408:110::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.18 via Frontend Transport; Wed,
 19 Nov 2025 15:06:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF00004FBD.mail.protection.outlook.com (10.167.243.183) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Wed, 19 Nov 2025 15:06:16 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 19 Nov
 2025 07:06:13 -0800
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Likun Gao <Likun.Gao@amd.com>, Le Ma <le.ma@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH 1/7] drm/amdgpu: Add gmc v12_1 support
Date: Wed, 19 Nov 2025 10:05:54 -0500
Message-ID: <20251119150600.3663611-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251119150600.3663611-1-alexander.deucher@amd.com>
References: <20251119150600.3663611-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBD:EE_|LV2PR12MB5749:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f74d3d2-455a-48e9-1043-08de277d302e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?tqp86vhIrOvOugeQmHunOf7UcMkvdzFou++cUw++tEVp0zww2Uo5fWknew9t?=
 =?us-ascii?Q?/3kEklv7JSgmJ2pa2SJNgj25t2Gosj1D5EIUZOSBW9Zauud6KCitxU9jRP11?=
 =?us-ascii?Q?0D3nyCP50fQCq8jQUp9pGm49dXRxdsQJvBEPtq66f7mg53zcWbTwSyPe+MEc?=
 =?us-ascii?Q?n7Cha8P6ZVG1NwDxKg0ymeHzc14hUESumO9WTZ45PGndD5YDe0FagqmAP4Az?=
 =?us-ascii?Q?yA4tDO6tkEy4z3mjwGCg0GB0tF2bs9TVLx5KwOvbg2AwjjPsyXomdx6dFnOu?=
 =?us-ascii?Q?GDgMeLhk+2yijmGm7etj2HlVMXWKytyEbrYhWdl/i33d4qNtOlsz5Dioh9W1?=
 =?us-ascii?Q?1YpR2oVgcyeIE81cYRNr50qVVBmH26yyYOBhq3s0oO8rsaareWh1DX9dyqNj?=
 =?us-ascii?Q?DkmOqkehzurn4GUMCpgbRyxSaLAS+RIf5Mx4UTL/LwntXHNt9JWNJBrI5bA4?=
 =?us-ascii?Q?dk38uaqn1bLyi1DkdVLqKRNWmwP31Q9ZB1lQH6z+ZC7ayYZCvz0Rv7yb21ai?=
 =?us-ascii?Q?sXK4hoP88inuTiJjyCn+h96Qy9Q5bwaVkRvv1YOYi3KbodbI/O5VMHzMIXvD?=
 =?us-ascii?Q?u9Ls2CbaJNW2KTCJg/b0zewYniWsaFLG2A4mSeg8aY/euDTAARDEpLrsIAqg?=
 =?us-ascii?Q?BC6YTaqMDtiK2ytoPQtlcLMHgDqSUCthUm+Vau5Z/YybN6FIghLRpADndQtl?=
 =?us-ascii?Q?BHwKVaWOhaegCzYjF4B2sBoLGu3TP8zFebgXp4cJuPiXMoPS+q2MBw1RuhPT?=
 =?us-ascii?Q?dH0B4NQn0FkQ+p3mdQCvvjLrjjLEfDtE3+DVmEtWbzeH2YLHmhbBLG16Uk4Y?=
 =?us-ascii?Q?aYC127bBDdeyljR+6UCLbkPCQB/lUpAWZjG2dJmJzihNhVvPsKWSyJP6Mo0m?=
 =?us-ascii?Q?5RVahBs5cJ4iFUpGtLSPiFk84L+URUhLh0rtKubdKd4T/E9j5umNpr7p5pvr?=
 =?us-ascii?Q?IywxsMvKUnrMeyaj9SdlQt9QVwhiOSiTLiLUL6wTAO2aPjrSF0JET8S2TLuj?=
 =?us-ascii?Q?NPf0rIzxxtqowMFuVoh3QP1W0UjmCFggoWAPcbqOapxB79IkmjJ2OZ7puh1s?=
 =?us-ascii?Q?NDIZjobOhrM64TixvmepDmG9R2xDvPOkgu5r4hT0a5UDwMT8ixzTnYeekrwG?=
 =?us-ascii?Q?AOJvyspnF1N3m+aHWwqvOC89vAiAER7KrCCaP2O3Pw3LaQkwkpSlSeQsnFnl?=
 =?us-ascii?Q?sy3TuMgNygJpDghMCD0r1lnNwGJNTPSUuRbILYjO7MiX0cmv4skIeHI1bP1v?=
 =?us-ascii?Q?Im4WcHtBk/k09Fa95Uwp/w2wav2/SM7v+oGHbhfdY4/81rj96oQPQHwGvS5p?=
 =?us-ascii?Q?1ldGD02/AxWRSOks8oYPhoRSQd6N+oYh5ghReflRdcq9zW5/C7g0w13HIXLZ?=
 =?us-ascii?Q?/rjxf+ZBjRrymC9b5QQUEdsccjVzYJTaxl9hf8vxTku5Lh95qFjBBvvBzvP5?=
 =?us-ascii?Q?fyXXUvLbjAf0Asdo3w4RPaKNdWJX78h0FMk8x0D5jTAKl4LCmm7G1fzVRRh+?=
 =?us-ascii?Q?jSLWdVDWQiQRG2845Yfmo8BDMT79Wv6YEjB1FYza5RK5gAS25flgqQwrZogP?=
 =?us-ascii?Q?c7Rzilne2B9x6jwdZQs=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 15:06:16.5479 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f74d3d2-455a-48e9-1043-08de277d302e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FBD.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5749
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

From: Likun Gao <Likun.Gao@amd.com>

Add gmc support for gc version 12_1_0.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Le Ma <le.ma@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c | 34 +++++++++++++++++++++-----
 1 file changed, 28 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
index 69d90a26ecf50..d22c762473424 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
@@ -38,7 +38,9 @@
 #include "soc15_common.h"
 #include "nbif_v6_3_1.h"
 #include "gfxhub_v12_0.h"
+#include "gfxhub_v12_1.h"
 #include "mmhub_v4_1_0.h"
+#include "mmhub_v4_2_0.h"
 #include "athub_v4_1_0.h"
 #include "umc_v8_14.h"
 
@@ -594,6 +596,9 @@ static void gmc_v12_0_set_mmhub_funcs(struct amdgpu_device *adev)
 	case IP_VERSION(4, 1, 0):
 		adev->mmhub.funcs = &mmhub_v4_1_0_funcs;
 		break;
+	case IP_VERSION(4, 2, 0):
+		adev->mmhub.funcs = &mmhub_v4_2_0_funcs;
+		break;
 	default:
 		break;
 	}
@@ -606,6 +611,9 @@ static void gmc_v12_0_set_gfxhub_funcs(struct amdgpu_device *adev)
 	case IP_VERSION(12, 0, 1):
 		adev->gfxhub.funcs = &gfxhub_v12_0_funcs;
 		break;
+	case IP_VERSION(12, 1, 0):
+		adev->gfxhub.funcs = &gfxhub_v12_1_funcs;
+		break;
 	default:
 		break;
 	}
@@ -759,6 +767,7 @@ static int gmc_v12_0_sw_init(struct amdgpu_ip_block *ip_block)
 	switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
 	case IP_VERSION(12, 0, 0):
 	case IP_VERSION(12, 0, 1):
+	case IP_VERSION(12, 1, 0):
 		set_bit(AMDGPU_GFXHUB(0), adev->vmhubs_mask);
 		set_bit(AMDGPU_MMHUB0(0), adev->vmhubs_mask);
 		/*
@@ -780,9 +789,14 @@ static int gmc_v12_0_sw_init(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
-	r = amdgpu_irq_add_id(adev, SOC21_IH_CLIENTID_GFX,
-			      UTCL2_1_0__SRCID__FAULT,
-			      &adev->gmc.vm_fault);
+	if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(12, 1, 0))
+		r = amdgpu_irq_add_id(adev, SOC21_IH_CLIENTID_UTCL2,
+				      UTCL2_1_0__SRCID__FAULT,
+				      &adev->gmc.vm_fault);
+	else
+		r = amdgpu_irq_add_id(adev, SOC21_IH_CLIENTID_GFX,
+				      UTCL2_1_0__SRCID__FAULT,
+				      &adev->gmc.vm_fault);
 	if (r)
 		return r;
 
@@ -829,7 +843,11 @@ static int gmc_v12_0_sw_init(struct amdgpu_ip_block *ip_block)
 	 * amdgpu graphics/compute will use VMIDs 1-7
 	 * amdkfd will use VMIDs 8-15
 	 */
-	adev->vm_manager.first_kfd_vmid = adev->gfx.disable_kq ? 1 : 8;
+	adev->vm_manager.first_kfd_vmid =
+		 amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(12, 1, 0) ?
+		3 : 8;
+	adev->vm_manager.first_kfd_vmid =
+		adev->gfx.disable_kq ? 1 : (adev->vm_manager.first_kfd_vmid);
 
 	amdgpu_vm_manager_init(adev);
 
@@ -997,7 +1015,10 @@ static int gmc_v12_0_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 	if (r)
 		return r;
 
-	return athub_v4_1_0_set_clockgating(adev, state);
+	if (amdgpu_ip_version(adev, GC_HWIP, 0) != IP_VERSION(12, 1, 0))
+		return athub_v4_1_0_set_clockgating(adev, state);
+	else
+		return 0;
 }
 
 static void gmc_v12_0_get_clockgating_state(struct amdgpu_ip_block *ip_block, u64 *flags)
@@ -1006,7 +1027,8 @@ static void gmc_v12_0_get_clockgating_state(struct amdgpu_ip_block *ip_block, u6
 
 	adev->mmhub.funcs->get_clockgating(adev, flags);
 
-	athub_v4_1_0_get_clockgating(adev, flags);
+	if (amdgpu_ip_version(adev, GC_HWIP, 0) != IP_VERSION(12, 1, 0))
+		athub_v4_1_0_get_clockgating(adev, flags);
 }
 
 static int gmc_v12_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
-- 
2.51.1

