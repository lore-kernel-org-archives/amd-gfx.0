Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC351CFD65A
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Jan 2026 16:26:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 51E9810E63D;
	Wed,  7 Jan 2026 16:26:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HieNmPro";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012006.outbound.protection.outlook.com
 [40.107.200.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A4D7F10E63D
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Jan 2026 16:26:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eXx2GcC8YZIHwHbisc/LW8k/M7jJhsoMigbUmqqEyEOgg0ARh7tu3UHMqYWsDn1JdXWzcSA4+DS45I05Vcbbfz44u87wLuTojS2S5IsuA8fTy2PmMhNKiHf0RKVTy0ZMT+TGKVphsPNC9zH/nSVK+9aOj0CX7nRlnTXzWu4yfq6tN8giS636MYNiMrnRhU8bBwNWEtheehQ4YPFdYA/7xGleNs98R1rPsGTEyLAob7UlWn6oyBI9TAouOJyL/ldZe3sSHldboCc7Ii0TOCPR+kfAcHXkUDp/CBcl0tcMoTT6P34LQqJ8hLflN2xPVnSy8YCP9Lynme4VOcT0diXtFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jYdQ87dUQNEJZOlkPTRfj6iw1fYO4mA+LYe0x7ecYSc=;
 b=PfmQQztLsH7rAOIw3JIw/N5TQdII+rW4Ld9jDcYj2AqEa2SlPaBBgu3tbhXSZCZwVFJiCw6+49oeeFupu0hIgdCjh8PKGVsPesXeHdEzjPrYu0laIoPUt4DyjUpktVQGqOdDnex5GEcyYExkT3O4pwR80G46M0/rgbrJsfEV3psL8M2VhAWqQKJDg6PwPH8sWgYCwphqFwda0mk3TMZwZpcN2q55y1ETgLz/Pc3c3g8DHmOCYfO5xQqv7BjvNSrw9xeHQg7efwmS83NaP+2IDY/bOMerW0rLQ30x0nME9GW6E3oMW1vn94oJKspLNvvgi52xqNVG4EaddOfW9jRZqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jYdQ87dUQNEJZOlkPTRfj6iw1fYO4mA+LYe0x7ecYSc=;
 b=HieNmProN3i3rolfcaOpDGyX7vmRx31r00Aa6YS9+pDGfqM8DKbnC6QPgi53QHTAX4GUuSsphxRGOcAXGiPo+jPl0u27FTRwhRwn/0NEIzjWJl+VqVrs/m5R/JrO46q/R4BuUG9FdCl9vQIybLfwNV1u1XdthfiT7wsIRAApqH8=
Received: from DM6PR07CA0097.namprd07.prod.outlook.com (2603:10b6:5:337::30)
 by IA1PR12MB6411.namprd12.prod.outlook.com (2603:10b6:208:388::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Wed, 7 Jan
 2026 16:26:35 +0000
Received: from DS1PEPF00017095.namprd03.prod.outlook.com
 (2603:10b6:5:337:cafe::43) by DM6PR07CA0097.outlook.office365.com
 (2603:10b6:5:337::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.2 via Frontend Transport; Wed, 7
 Jan 2026 16:26:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF00017095.mail.protection.outlook.com (10.167.17.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9499.1 via Frontend Transport; Wed, 7 Jan 2026 16:26:33 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 7 Jan
 2026 10:26:33 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 7 Jan
 2026 08:26:33 -0800
Received: from Xiaogang-ROCM-Dev.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Wed, 7 Jan 2026 08:26:33 -0800
From: Xiaogang.Chen <xiaogang.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Xiaogang Chen <xiaogang.chen@amd.com>
Subject: [PATCH] drm/amdgpu: Use correct address to setup gart page table for
 vram access
Date: Wed, 7 Jan 2026 10:28:20 -0600
Message-ID: <20260107162820.707582-1-xiaogang.chen@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017095:EE_|IA1PR12MB6411:EE_
X-MS-Office365-Filtering-Correlation-Id: 946547e2-0198-45d2-c0b6-08de4e0985c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?AIFBzBrtUvF3y2L5Mmf/5l9R3UG1+PKj4J/7d6ulYTQp3J1yb0Q3UMX0HuaG?=
 =?us-ascii?Q?dp8ZOHbeMTdXSQmVX08sejGvlBlS7PJjB6MDlngt6G0U9sBhU2J/qTvC+lQp?=
 =?us-ascii?Q?lKTQE02nO6i8d29hcDKzmRK5s8dlKRyYjU7sh+9tF0J/eE8xieau8HVCrZ3H?=
 =?us-ascii?Q?ynwtFLANx+QnD1M6vB6HS4JkCniqWHVpFcnswoPsbZGlkZJ2py4rj8GYA41u?=
 =?us-ascii?Q?SM9OubMfz/940/pxb0f09xUV+ImHaw8M1IVX11hCC0n0T6oxRFvtohHuO059?=
 =?us-ascii?Q?n8ZDZw1j3g3qjo6G3o6Qmrl/tLgPQETWwbrcGdv4QO9Xpof++pS65uwOt9RP?=
 =?us-ascii?Q?4eeD59cXKBLcKaxQi9Fhyr4qqdzljA7ZTVvlQR+9EKdgHvRolt4SZYaoJLyp?=
 =?us-ascii?Q?RHODE7we1Kwfci9nqPkjim6z//e4DWVglvPX4Jc/I9ZzDfAkh+S9w6KaMIvu?=
 =?us-ascii?Q?CK2y9EWLptX+CLeQ5kQUf2EfjyEs3oX2rvGMUTXURvwLCbmV0cOLOPGKhY69?=
 =?us-ascii?Q?te3TgVNtwHRBcqqN5JVkhNck7Hx+DHD8mF90WbfmMFZ4/Gm1OYsXJBywgImA?=
 =?us-ascii?Q?w0Za4GeRgcyVhckMgAsjIngty2Kd7aBFVBv8pOks824qAvZllGYl+2eRzqqJ?=
 =?us-ascii?Q?B8q3/bSThQtPZHpYvlmeiRnJGNhQmZZiTW7j0RLhnotMj+U5jQNYma/+bwWi?=
 =?us-ascii?Q?gEFcWBsddEeIOA2Kh5OTb1abkAMipWw5tiIgoEj/u17nnxXe+FHz8WLhEojC?=
 =?us-ascii?Q?+FkgFu0JVqudX3reZffXLFGJSmhPTqVnSjT0YMAPyS7WwauUGh9frRYatp0F?=
 =?us-ascii?Q?E33NdgP1P4yBZ9vOGKnQyVdpC2760XTI0s48ZPvIqnZEKjmNPXEmpdPBgn8O?=
 =?us-ascii?Q?8uCF6MFON0vnFImQRLElbfUgwcloF+tb1gnp4qgPUInLI90w7VlZ5CTyMXU8?=
 =?us-ascii?Q?5wrxOVo5bdCYlNe3J4K/QPV8quCbfUUH0CONykxALcTIXE+ZjmlCa3U8GB6G?=
 =?us-ascii?Q?Qpv+H0bPhXflUvJCq4KejTKWu+EOzuTEesR1iWyYn1AUZECxM/VVH/vWQ2J1?=
 =?us-ascii?Q?ET9GAwJe/cBb5V9vSh2BUPaEbgGGko1E23IO22v4fkjM0hH/Vqk4WFPjOGnv?=
 =?us-ascii?Q?RxvT2lnI+NV4NLDut8jt+X1F2g3qDYmbze9JmfFmBubi2q2P5/5GtYFU6FwX?=
 =?us-ascii?Q?QkpP9846ngofSNJ/omg7nPVifLSMKeFGl+FGBTiVrQBrxoNmB9jDwRtXbJoc?=
 =?us-ascii?Q?x2P/UvIzB25tqxA52JRh5O18Mhxjm4ace4vwjxPePNefvyT/i1HfH3TZs2gp?=
 =?us-ascii?Q?2thSzZrUCJxsRXVrjdioGWbfMYWyfpbK7o/WWcKbj45cSM3wHlInxmo8mVKM?=
 =?us-ascii?Q?TkujLSrzDQzvcLu5ogF1l7Lbl8jhzawaZM1D5AbEmF5z6k0vrqXdRVo/SIue?=
 =?us-ascii?Q?kLKqvBYM/5139hIRQk1D4xdR61TC5SKPkP3cB9Lg5/TP7Vq4I8OlE1DaCnVk?=
 =?us-ascii?Q?6CA3eC48eVv2HBJVyK8T4av5TLfr9kDA2TT5AIIVEmTE043obBZIrjUlnaoD?=
 =?us-ascii?Q?PCFm79cYjvXniypi/5U=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2026 16:26:33.8500 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 946547e2-0198-45d2-c0b6-08de4e0985c2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017095.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6411
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

From: Xiaogang Chen <xiaogang.chen@amd.com>

Fixes: 68a5940841684 (drm/amdgpu/gart: Add helper to bind VRAM pages (v2)")

Use dst input parameter to setup gart page table entries instead of using fixed
location.

Signed-off-by: Xiaogang Chen <xiaogang.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
index 16c3b78e50cb..68d8d0702b45 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
@@ -396,7 +396,7 @@ void amdgpu_gart_map_vram_range(struct amdgpu_device *adev, uint64_t pa,
 		return;
 
 	for (i = 0; i < num_pages; ++i) {
-		amdgpu_gmc_set_pte_pde(adev, adev->gart.ptr,
+		amdgpu_gmc_set_pte_pde(adev, (dst ? dst : adev->gart.ptr),
 			start_page + i, pa + AMDGPU_GPU_PAGE_SIZE * i, flags);
 	}
 
-- 
2.34.1

