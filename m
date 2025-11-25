Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB4CBD0E6F9
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Nov 2025 15:10:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 869AB10E431;
	Tue, 25 Nov 2025 15:10:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YFhPDYDx";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012028.outbound.protection.outlook.com [40.107.209.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E05910E431
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Nov 2025 15:10:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hwXH3Xdc6rZSu+jN3PYeVWG4kaJeizl6TVWs+VYANioioVu3jE9WBfW9lHeJvVLDH6oMGvw8iaH+gjfTH2stbLKLgCQLX9YVouHgBhOluifI6PNW/mZHgwl40oVzhZci8Pwu0GZgY7mlTWciITlz08wRsg1bvpZGrdAezO1ZLCN3JOxq1JniUOGpQigFVvPRJGe7MXlhit/t+GPAh80LD5kdaUnolUCxtAO+ACW/2h8RAzO/j0Jqn2hj4li/xObtT4FGHH821dkbvEUIrZAdXojhbfqlAAB9097EborzLO3c3SKIy7dFr0gxCfWV6Ry8PLPFXJ7xjvTP0gPfZCO+sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tbXDCQ1u0MJ8BM9aI4LFLhmuzWTZy8/pJDQLWBcj+oI=;
 b=oz3mrE2j9vudY2YDllh+ECAeKhkbVcr+kxckhDrdMM3v4GeWqFTUOQtvhlk3vmBUbiU9iksQoQ944khaDHtMNJ4nyY+6ulhchornOQHRYpLUF+XtFwUYlFxthdlM2vELdR79ZnzhdxMsaMRK4KSL7/qxKoDYtPVDP3/GASZRVllDZ89JCImzuEJtnquPTaO96S6zRGE1w4hDL4MH/m6Fs5kjzmmOc4+WvQTF2qRc4TjCTrecAdZqggsQHxMmLcOKN8Ez6Z9r1fx/FhXfUABiL84rW+xclc1T8W/S/jJZbizmyuSbQU4coPNz+2L4RIcZpnHmhv59s6usOBGfuODS0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tbXDCQ1u0MJ8BM9aI4LFLhmuzWTZy8/pJDQLWBcj+oI=;
 b=YFhPDYDxpiRkT6DOI4/wqzPKx04Y51cIbUyCAKN2+SggM8Kk9rWwrsUdJUzFHQZtN0nEKE/amSMRWALnfnVIXvlFz7EaBIKKVDKCyMVC3XcvbhvdApXVs/i/HGDd9Ej/la90qegDJvGH+zgkOZPakEF3vxpM0lcIryk1OiD/A/g=
Received: from BL1PR13CA0290.namprd13.prod.outlook.com (2603:10b6:208:2bc::25)
 by DS7PR12MB6287.namprd12.prod.outlook.com (2603:10b6:8:94::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Tue, 25 Nov
 2025 15:10:24 +0000
Received: from BN2PEPF000044A7.namprd04.prod.outlook.com
 (2603:10b6:208:2bc:cafe::f) by BL1PR13CA0290.outlook.office365.com
 (2603:10b6:208:2bc::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.11 via Frontend Transport; Tue,
 25 Nov 2025 15:10:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000044A7.mail.protection.outlook.com (10.167.243.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Tue, 25 Nov 2025 15:10:23 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 25 Nov
 2025 09:10:22 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Likun Gao <Likun.Gao@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>,
 "Alex Deucher" <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: add soc config init for GC v12_1
Date: Tue, 25 Nov 2025 10:10:10 -0500
Message-ID: <20251125151010.2046736-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.51.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A7:EE_|DS7PR12MB6287:EE_
X-MS-Office365-Filtering-Correlation-Id: 6dbecaca-3b5a-4320-adb3-08de2c34c207
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?pXZAvzXyfmAY9zKUGX3MU5ESK+cuIgT3FuQ/L4D14TNoYp/dbXsjn+Z+Ox7U?=
 =?us-ascii?Q?LuSk1ULkc8fLKO5MS0dChlKXCGMCApuQWGxk6ieSNW/tgXOxAUH2TjbNl5wW?=
 =?us-ascii?Q?w988tUV8aHSWu3TGUS9czifLPr5Zmcqh+2pc6aYdho+5Cn7rMiWlOeldxX0s?=
 =?us-ascii?Q?SJsU4gNsxAU6IvIwJ8YqSKLB1F7Uj7N4QAwQW1W9PioBAAPZ6hd8akA0vW4x?=
 =?us-ascii?Q?A1MaewPXzt2a5sqJ90J9tZpegFjbkzUCJoqpuC7Ksw8B4EoDxH7Vzrg6yZgB?=
 =?us-ascii?Q?86D1zmOLtLzNr8l61c2QwH9X+X61U61IzgJXTVim0q49YviOvJsI7tR3h3rI?=
 =?us-ascii?Q?cRWM4k0xf1RzwImpL+J2NLkQ2VAZYYYmobP9n+Uoa3EjOvu3HRbApY4cYBD4?=
 =?us-ascii?Q?QXmesYLfX9biRHM+i59uECgtwgkWJ9GOSlwlPqN+8cELlzktp4DVrmSY7NQN?=
 =?us-ascii?Q?WR2qR77SJ4yy1k8R4mV0i1+jijUz/dbhU2PgTKNqxEHiBwHZ5F+YmRjPq9hw?=
 =?us-ascii?Q?kZjgVrG13tZTwXBLMuHe4o1HCLP64XJ0BbXhbzxpJrbObz7Qo3SddS3nJMZJ?=
 =?us-ascii?Q?kfM5dxnM7J9CrUtZNfKLheuDbX2NZUurpzt3zOKrnauFWgo7kHWIGiQ4GMR9?=
 =?us-ascii?Q?VsBxfP1PZ17xUcBanWl7rviGIxtL8GoemsRT5gF3hu20k/j/vqT7oAed2Sov?=
 =?us-ascii?Q?gPNy9Zf1guGTrV/jrD0Cc1RPYA3uZuBP7uf+Z8895HLv4ClzpYvldj3qoN7j?=
 =?us-ascii?Q?1mUr0rTmN6SlUfq+fxdYw6itOIB3BLrwor/Z0kj7gu+HtTs/+9d5Z4r6GNO9?=
 =?us-ascii?Q?7mDP+vx5qGL5gv2PVAsf6EoRi3JggSisG/6L8Jl0fVYosYsKTYEZE2nHmnzK?=
 =?us-ascii?Q?Isa2fpVdu/j3zp7ukXgkblPHFDk2oif+VgyU31ZlGfldTZEuM9btqKbxYaqU?=
 =?us-ascii?Q?+78sU+4Fu313DiFP7kzkJM3tDA+5BJFsFYqasUuwsTWywS+v2HsPzpIWkOlA?=
 =?us-ascii?Q?XSS79LMK3bgl5LA+u4m7xZACaAEe3d+gCfdNeqScTZvexArjwbQoZegUTJmu?=
 =?us-ascii?Q?53+TowbM81+kxgxoTr/gePOr85zynsljOd000EjCS8Wef75tuy/2/YDpPn3z?=
 =?us-ascii?Q?iautonVLpzPwIiTFM6a9E1w3f+Rf5MTcuqs9jFDs83m2JkB4eiu7lQRxidFm?=
 =?us-ascii?Q?X5/XDdhee9+cWWzy8EZy52ukl47xFy7+dRf6vgHglIrHcaVNVxE81MgBca5v?=
 =?us-ascii?Q?cAbK3/pS9w9hZWzZChfunhK61DCPwnpz9jSXMdQc2okPmlHoo1pD9FlrQmHw?=
 =?us-ascii?Q?aXdu+YzwYHGwOU9q30alAz5HyVJWkxf1/43BgrtrCV15Yk3KxSfIas4VLSVU?=
 =?us-ascii?Q?7RcWSTBlv9R9oKcXsBBRKHEF/ZePyi+FKtYUYqI3q8dCZDITPX8XRElvE6uc?=
 =?us-ascii?Q?Bd+oGDUzsXBvKU4Qi9p+pVT8QA/sz32ed0JRDQtNc9TOH3Fm8nGOCQI+aBhe?=
 =?us-ascii?Q?g+tuAENEmAYKLp9FnNehrcQv6CFVD8tjZxgEkid1j8LmYYbSK1cv0nhBHCJV?=
 =?us-ascii?Q?y1aKOUoeI8bWcaL4y18=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2025 15:10:23.7966 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dbecaca-3b5a-4320-adb3-08de2c34c207
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6287
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

Add function to initialize soc configuration information
for GC 12.1.0 ASICs.
Use it to map IPs and other SOC related information once IP
configuration information is available through discovery.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |  3 +++
 drivers/gpu/drm/amd/amdgpu/soc_v1_0.c         | 10 ++++++++++
 drivers/gpu/drm/amd/amdgpu/soc_v1_0.h         |  1 +
 3 files changed, 14 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index ffffc60c98db5..20d05a3e4516e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -2592,6 +2592,9 @@ static void amdgpu_discovery_init_soc_config(struct amdgpu_device *adev)
 	case IP_VERSION(9, 5, 0):
 		aqua_vanjaram_init_soc_config(adev);
 		break;
+	case IP_VERSION(12, 1, 0):
+		soc_v1_0_init_soc_config(adev);
+		break;
 	default:
 		break;
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c b/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
index 815f130f760c7..0ede5e22e905f 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
@@ -24,6 +24,7 @@
 #include "soc15.h"
 #include "soc15_common.h"
 #include "soc_v1_0.h"
+#include "amdgpu_ip.h"
 
 #include "gc/gc_12_1_0_offset.h"
 #include "gc/gc_12_1_0_sh_mask.h"
@@ -334,3 +335,12 @@ const struct amdgpu_ip_block_version soc_v1_0_common_ip_block = {
 	.rev = 0,
 	.funcs = &soc_v1_0_common_ip_funcs,
 };
+
+int soc_v1_0_init_soc_config(struct amdgpu_device *adev)
+{
+	adev->sdma.num_inst_per_xcc = 2;
+
+	amdgpu_ip_map_init(adev);
+
+	return 0;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/soc_v1_0.h b/drivers/gpu/drm/amd/amdgpu/soc_v1_0.h
index d9de040c37291..23517c3a3d1bc 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc_v1_0.h
+++ b/drivers/gpu/drm/amd/amdgpu/soc_v1_0.h
@@ -29,5 +29,6 @@ void soc_v1_0_grbm_select(struct amdgpu_device *adev,
 			  u32 me, u32 pipe,
 			  u32 queue, u32 vmid,
 			  int xcc_id);
+int soc_v1_0_init_soc_config(struct amdgpu_device *adev);
 
 #endif
-- 
2.51.1

