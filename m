Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EBF5D374A6
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Dec 2025 21:50:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 43AA910EBCC;
	Fri,  5 Dec 2025 21:50:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1AejQ+Jd";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013001.outbound.protection.outlook.com
 [40.93.201.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 434F010EBCC
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Dec 2025 21:50:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FcQNWqpXnc7PKJOpKPiZKtEg38iuZd792MfoxKSzj7JcjZ7jerjU+Y2vMsMXrRzf2rJxZxdHzehQZ1C2pOyY3KS537C69uCZrMcIUXOfVcSX+igZ3ZcUGWDBPLJVtdVkLuhhQVESW3/Ungr4j8hrOjl5tmV8oDvkrg3dSIN0xv21pvdASQ1k3c2KJKtxe9PuUDvJ6ChUNgGmfocPWG+DvEe4Lt9Nt3LFVQMgku20BX5/hE2dhZxLnbuJf6EkdR10EAnJuhEaQskxyqGn+2MjDruAYvlLg7lL7MqJDISqou4ER0+xqDcW+QhQ4f0WfWWYltiC+FZHcpDztjRtOtEJCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IzJDVL3/T1vr2ME3plwMTsqjx/5XbzW8jF1yDGwl/mU=;
 b=fHJ59zSQuT6KRsYhndJqcp13tV9w3qtGf7xn8UmJf11RSndjwzuMA8IOsGKyUT9qmsaQtccfcNu6AK0O/nK52poarYvgAHfgJNfofBshwLeitnMw+k+yQy+lcVG+XzMxffWW5d1RUuDR4NY5SJDyh/BQWitisAxYlWK7zqUp9FhzOgcCaH6uciDyypq34Ug3EcMO5d0eGEQMuY3W034qkPGOO2Cf2wZImzDchE2wPlOFubYQdNeU4adgg/vN9bB4l2ZQAXlMtAcdeuzHa1QpQeDxf/f8mZnwQhQwkAypX1xft/X6h+Avcti1CLJrLY3f0tjQtlBiYkaRCdnUjI0LLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IzJDVL3/T1vr2ME3plwMTsqjx/5XbzW8jF1yDGwl/mU=;
 b=1AejQ+JdiV3ZDayBbfZ6qZcJB5rS3D6WIYa1EievGN3Lq/d4P96+VLR4NcmYRUysgvIxtodq/HcbdFLMMAc4hZTSrTOqb0SaR1yquchTdX/VHzV90b9KbK8cgS1Um8+WrxLnzqFUmLZ6K14eGv+N9fH+i9SGbDM4Gf0QFDbghD8=
Received: from DM6PR03CA0030.namprd03.prod.outlook.com (2603:10b6:5:40::43) by
 LV2PR12MB6014.namprd12.prod.outlook.com (2603:10b6:408:170::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.11; Fri, 5 Dec
 2025 21:50:06 +0000
Received: from DS1PEPF00017090.namprd03.prod.outlook.com
 (2603:10b6:5:40:cafe::91) by DM6PR03CA0030.outlook.office365.com
 (2603:10b6:5:40::43) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.12 via Frontend Transport; Fri,
 5 Dec 2025 21:50:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF00017090.mail.protection.outlook.com (10.167.17.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Fri, 5 Dec 2025 21:50:06 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 5 Dec
 2025 15:50:03 -0600
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <christian.koenig@amd.com>,
 <david.yatsin@amd.com>, Philip Yang <Philip.Yang@amd.com>
Subject: [PATCH v3 1/5] drm/amdgpu: Fix gfx9 update PTE mtype flag
Date: Fri, 5 Dec 2025 16:49:18 -0500
Message-ID: <20251205214922.1095629-2-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251205214922.1095629-1-Philip.Yang@amd.com>
References: <20251205214922.1095629-1-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017090:EE_|LV2PR12MB6014:EE_
X-MS-Office365-Filtering-Correlation-Id: 2fe827b9-c6a3-4e43-2a12-08de344840e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?vuMuQrx8rP5hf2qEoVzLqg+Gbymtwx8vyw15MKFZgleg58q+q4W0pxijGO1K?=
 =?us-ascii?Q?z4UZ/IlAvF9vNIkX5fSdGSlylwXQ/nydp28cFQnIb2n/M4SGPmzU8yaMAyq6?=
 =?us-ascii?Q?fW98K4VF13WulDjT2bzW+qY2rhoqFcro9gdyKMXuBLLJt8+TP0zgf1ls900S?=
 =?us-ascii?Q?84MuOIyeSK+yMxbinACeWnUv3s+5uYqePUBcmS+no9icGJKLHA+ldyQw5qT8?=
 =?us-ascii?Q?hWdsvyfSOVwM3g4xt5TeR56Z1sJmbsOVw8cM1ridDLBDi6iedttPOHoWLjHn?=
 =?us-ascii?Q?3R8KjTKUjLJKincohg3Q7uNJLKavhMoSP1mY2+XG4R0ttiAILpYO9KzT8QZq?=
 =?us-ascii?Q?poGgWTRmJeH4wRuposG9e6TAuCBz3L2oVc24dV8WQqCo0/qjQiEMHZlTHKUK?=
 =?us-ascii?Q?te9dLxnraR+9oxxPWgud0zT9yggW6cAMuqxiOcSQyT+eKX8S4G+a8GKT2jbI?=
 =?us-ascii?Q?71FOnNzir42eVD6XIg5gqbnognlGCPGEpqnHDMuBPTxDJZXijZ7mhYfOSGLD?=
 =?us-ascii?Q?2eDzit+xwVyD6FBNcTj0YnYNu8d19xvEl8Z51Gn03xt2gysAd6sUF4CeVjIB?=
 =?us-ascii?Q?ghPHBhOagG0l3HDNyf3q9VDYXYkey7kaYP7CvD7ZXrE4kR5H5AR9dcaBJh00?=
 =?us-ascii?Q?O4QgOKd1qFfi+vfmedoiY7c+9RkkV+l3x0Nq1vSN/tm4iTLM/SdQQ4B2DAzH?=
 =?us-ascii?Q?nIeaYzs16nR8YUgHTjs35I993zHEyw7kVLAzpUnf7ZV0aTN1Ydg/NoC0GVc6?=
 =?us-ascii?Q?LGD100JBM/4WOd1SbJGBjs69f9MbHMWQp2D4V2zKPEQ7dVowqKogR7Ri+AJb?=
 =?us-ascii?Q?fUp3aTDICCZcPxcUqUaj+mhVu3js9EnYnW/q+K3DVFxpByuFytKo8/36PBoK?=
 =?us-ascii?Q?mm5ISq5PbPBNMLy/24FfXiM0Ev71MITomppLfOX6+JA7IJGFgue1rpvzw+7k?=
 =?us-ascii?Q?vItcIgNSHMP2d4NmYRgoA3J5ObCI94/7T95D/9uk08n8phiPE/CUeJgUTIr2?=
 =?us-ascii?Q?F3aefKji+ICuBlH/lBKCXXj1kGL2djttjEJxgbR7iiLnftTnL4WZmzAurGrO?=
 =?us-ascii?Q?dv1neQbK0V+RVToe0RWt1K+9KTQgZz0+E6OsY7NIfiFz91qYmknvQTnY1x2q?=
 =?us-ascii?Q?edcEVdsihVI98m1tQM8eflo/FI7XDejD/urt+b1MxOm6+B6SvV8B/yboVXSG?=
 =?us-ascii?Q?XaLO58dhemhHmrM+MOexFDyhKVMmM3RibBwWVEEDr/NxjACT9QOBl17wk4hE?=
 =?us-ascii?Q?wudcf9iyIkKrNc+sfp5cJYxnaGTqhNDjgAeVEpwkRuyDPVWfIEDqbKmwlZg5?=
 =?us-ascii?Q?zN2IusRYNBO5R1wp+n6dYy8LttiC50iTgJXATstup0TvAm52eVst35AAU0L7?=
 =?us-ascii?Q?pSj0WBo1oEIAnhq4gZCpp/85XjldpmoAo7KQgZfUGD9sjMVaIDlVCyYL2lW8?=
 =?us-ascii?Q?YbZX8bwVHSXNZmtyGgrmuW1OCxW8Jde3HZ3ctfFynIjwIrTfVBdeP+Amn2wf?=
 =?us-ascii?Q?LCNO/Xd4P59teLGtYJuKr14GgCoxDzEVYLJalESPQ/Momr3jVkQKg3XdzVx3?=
 =?us-ascii?Q?TwjZNlAk0BDxE0mDFsw=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2025 21:50:06.3803 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fe827b9-c6a3-4e43-2a12-08de344840e5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017090.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB6014
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

With this bug MTYPE_UC 0x3 can not update to MTYPE_RW 0x1.

Set AMDGPU_PTE_EXECUTABLE flag if mapping flag set, but should not
clear it if mapping flag is not set, to only update mtype.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 97a04e3171f2..d2e8b96c0372 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1194,8 +1194,6 @@ static void gmc_v9_0_get_vm_pte(struct amdgpu_device *adev,
 {
 	if (vm_flags & AMDGPU_VM_PAGE_EXECUTABLE)
 		*flags |= AMDGPU_PTE_EXECUTABLE;
-	else
-		*flags &= ~AMDGPU_PTE_EXECUTABLE;
 
 	switch (vm_flags & AMDGPU_VM_MTYPE_MASK) {
 	case AMDGPU_VM_MTYPE_DEFAULT:
@@ -1204,16 +1202,16 @@ static void gmc_v9_0_get_vm_pte(struct amdgpu_device *adev,
 		*flags = AMDGPU_PTE_MTYPE_VG10(*flags, MTYPE_NC);
 		break;
 	case AMDGPU_VM_MTYPE_WC:
-		*flags |= AMDGPU_PTE_MTYPE_VG10(*flags, MTYPE_WC);
+		*flags = AMDGPU_PTE_MTYPE_VG10(*flags, MTYPE_WC);
 		break;
 	case AMDGPU_VM_MTYPE_RW:
-		*flags |= AMDGPU_PTE_MTYPE_VG10(*flags, MTYPE_RW);
+		*flags = AMDGPU_PTE_MTYPE_VG10(*flags, MTYPE_RW);
 		break;
 	case AMDGPU_VM_MTYPE_CC:
-		*flags |= AMDGPU_PTE_MTYPE_VG10(*flags, MTYPE_CC);
+		*flags = AMDGPU_PTE_MTYPE_VG10(*flags, MTYPE_CC);
 		break;
 	case AMDGPU_VM_MTYPE_UC:
-		*flags |= AMDGPU_PTE_MTYPE_VG10(*flags, MTYPE_UC);
+		*flags = AMDGPU_PTE_MTYPE_VG10(*flags, MTYPE_UC);
 		break;
 	}
 
-- 
2.50.1

