Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BA7BC7115A
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Jun 2025 09:38:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A84BA10E30C;
	Mon, 16 Jun 2025 09:38:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BhT4CGPR";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2054.outbound.protection.outlook.com [40.107.101.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC1C510E30D
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Jun 2025 09:38:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y39atb/U8BN3VFzZACgmcNbWZV59bOiNjSxN13bwr0vS9tYo/BWghjVlwVUFgF7HujybMSwTlHlhp85FdhKupFEREaPdBadt5zrxvqEO92noHNq+LtXf29ptFA7XC4AmnIqnHMtZPPW84ahsfGIeNGAhELZcQeaJz9EZRJKpnF5LLcBiliP9NE2UpyIN33Lj1wl3G1arbdsyXKIHc0d2Tq7lPsncld5NT/F5dnnlV8Y6R98MthyXXv+Z3vAs8ih0iCNmr9C3aEKHbCROQk/gKaZI8xrJRNxMHj9QA8MCTJ7rwiFy+uOlQuD2XbX9H7duOLLAHyV9viqVzFF0mEHPuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EF34qy/tZOIN55KIuSrLj3SNYYy9OOUvUoObDdOkqUA=;
 b=f/euJARiBC8CpqxR08WC20RSRx8OjaKCOW6eBfjDdfpwcTMxzAVh7H+/r+PablnnZcZM40Hw9tgrM/TySGu32TpBpn2dJwuH4j3qtgAhkliuicWo6OR3dLnPMSvEuSZRHE1P/FNf4ONwPlph0RYZHWXJv7OCOb7/Vka8yLcWR7jMHDHwo/VBbQa0+BkBoqM0ltaCtwDXFNlYcfKu83et7AorYHMCGRtFWPBCArxPjxAU2/3ay7oxgFX4R4dWUrijKnY9b4aO9OC7vT/SxpIyweH1yoZeL0RTrwg1zJ8SAtcEvBI88IQc+T8aRrp9r8JGGYIDvqF40hYNkqVjy4xqLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EF34qy/tZOIN55KIuSrLj3SNYYy9OOUvUoObDdOkqUA=;
 b=BhT4CGPRwvdxepaREQT7C6zqhxxLYDHWFmV9PYegtpUMl+Fu1uIefpOLvJ2nyrz82qb53lNliqaWqL9HbLATjLhnfrtSDNAypTK3K1oy1o/bAzfB1s58qZ4/i4u3VyinmK7ScIGdu08CboqoMHj4z3WFCmQBXF0D6RfLc+E7+M4=
Received: from CH5P221CA0013.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:1f2::10)
 by SN7PR12MB7323.namprd12.prod.outlook.com (2603:10b6:806:29a::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.25; Mon, 16 Jun
 2025 09:38:32 +0000
Received: from DS3PEPF0000C37D.namprd04.prod.outlook.com
 (2603:10b6:610:1f2:cafe::d3) by CH5P221CA0013.outlook.office365.com
 (2603:10b6:610:1f2::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.25 via Frontend Transport; Mon,
 16 Jun 2025 09:38:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF0000C37D.mail.protection.outlook.com (10.167.23.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8835.15 via Frontend Transport; Mon, 16 Jun 2025 09:38:32 +0000
Received: from hawzhang-System-Product-Master.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 16 Jun 2025 04:38:29 -0500
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Likun Gao <Likun.Gao@amd.com>, Le Ma
 <Le.Ma@amd.com>, Lijo Lazar <lijo.lazar@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
CC: Hawking Zhang <Hawking.Zhang@amd.com>
Subject: [PATCH 02/10] drm/amdgpu: use common function to map ip for
 aqua_vanjaram
Date: Mon, 16 Jun 2025 17:37:48 +0800
Message-ID: <20250616093756.16200-3-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250616093756.16200-1-Hawking.Zhang@amd.com>
References: <20250616093756.16200-1-Hawking.Zhang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37D:EE_|SN7PR12MB7323:EE_
X-MS-Office365-Filtering-Correlation-Id: 17f54eb6-5555-474c-35da-08ddacb98ed2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?xSLz40QJQtbRjTZJYTp6K7ebNPE7q1RAoTeqzO5UeEsu6wO0CXOBx1gw7N8G?=
 =?us-ascii?Q?kiqnp0tQvqcE0LnE8H1Fnr38jO4QQIVdvGvawLn53WTTkGyoiZ3dl0CMu4Xk?=
 =?us-ascii?Q?rrmi9RybzgKe21xtIYZO+gksKd5bBD71bJL7skO3pxA+tXqIXon/O6qeeULB?=
 =?us-ascii?Q?j5KVCyRdf/q2h7VtnsyoWxQDkeyBI0KclI9BOZYDCWjpo2zblBMwpGKfTPEp?=
 =?us-ascii?Q?tmXfzG0R9jrbkVgs/rD63u4K0RcC8V5xtLSTntHnPHjNRqTJvtaDpwNMHyPo?=
 =?us-ascii?Q?yG0NjZjKyXW3xpAlYejgoJP+hqbQxZWFjMF92zp7zI8yOGupa7UvluFXBfNN?=
 =?us-ascii?Q?QOLgiDOps1/XSxyFu9Ndc4U1Y45hix/InoZfd0Vb4OilcSyI4+OM+Bkt64Uj?=
 =?us-ascii?Q?mRWreJHpj9hGqvrHNmyq+kVOFrpSXLcRRjauDX1r/szuPlhke6d3xr1Cy5DF?=
 =?us-ascii?Q?40BC/WnM2921ijr3326SxicpMxKBbXI52EDVP+7RLdiZHsgYxuFhJgoWsHEU?=
 =?us-ascii?Q?OxRfLM6fXc0rOZzwXanaE316xgJH2cm1inqjV3JFXIaiot8W02qEfxzYfKcr?=
 =?us-ascii?Q?V6QmSgm+DcRuNH6dzJ/BzEg/T8hK1RgIxEQorZ6D5xQ703cBelZGQ5G/NMCz?=
 =?us-ascii?Q?kY32PCl20mvhRuqJ/rEK6r/CEHEbxW5oi8PIo8LwXOdspEklSDQZIQ09aJh9?=
 =?us-ascii?Q?MPX38Xqxau2A1vYkJdcXC2pYwn76gPS/Z5y0e8Mnvxcgj9yEc/xdsEIaGueI?=
 =?us-ascii?Q?VuPqQGhs5RBqpYvCIlgtLNWbe5tT4hgteOwFEfn61pP+OEEFHCAgLiLE5TRY?=
 =?us-ascii?Q?0u63VmKaZiIcJ3TTAntDdFvmKgxhR41ggGPVfBItVnvSMerzUvqiQdU5KeRm?=
 =?us-ascii?Q?0WAXqEzbL9ZwNvMDI25juECNX6yYms7Nm6Wiq76tQxTg66NQ8O3QeBJHbGHK?=
 =?us-ascii?Q?tCyDVTABev3M/YpCPEN00eISCAxpsSg+6iP1iP8SgrafqYaVlC7FvN0iK8Jy?=
 =?us-ascii?Q?ch7otLa/5+nftQ5avSbkfS63dySahv1XJ4nfNv00eWgYhABu/uySOvh2+Bw9?=
 =?us-ascii?Q?+LTYRdt2z2u+WNc9i7xI486f4b6nNdlimVy/x4oTuiWAEH5mZeMO3yEgYKh1?=
 =?us-ascii?Q?plpMZQGLb7T4nhQiVAizSXfxGHR+lBzieuwNR20wAG3ToRj4RhUXExEMkNjV?=
 =?us-ascii?Q?ZIsNY4Ddazlz+NMzKJ8Oed9ycWhub2KjX4sHKMg62F+y/iRJp6cussJDK8jM?=
 =?us-ascii?Q?7j7xOzrpJwnc36sNT4GvX8QDNJ2bOn5OBh5S0HvNRmCO5zX34j9SlV3P5OBL?=
 =?us-ascii?Q?w6ewY3ZUHimdOy4em5WrXgN17gb2iIfcN0+COUoZ3r7DF7d+wR5BRSMhLhDc?=
 =?us-ascii?Q?ZuKXTvuNwymo0pHA9/9RL+OyGMQHjTQ8V1tJ+3CaDEFs67jHuCMRQ1K528Rb?=
 =?us-ascii?Q?n/LD+Z81giwZ4lW/o6pNYkLsrHQslpsl1quusEiyWDGaiZL09TbwFGgOZ8b+?=
 =?us-ascii?Q?bYPiuxP+8L7vonQv39KiVtrMAe87uiWtMkhl?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2025 09:38:32.0758 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 17f54eb6-5555-474c-35da-08ddacb98ed2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C37D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7323
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

Transfer to use function amdgpu_ip_map_init to map ip
instance for aqua_vanjaram instead of operation on
different ASIC.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c | 74 +---------------------
 drivers/gpu/drm/amd/amdgpu/soc15.h         |  1 -
 2 files changed, 2 insertions(+), 73 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
index 1c083304ae77..c0043a553b7a 100644
--- a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
+++ b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
@@ -29,6 +29,7 @@
 #include "gfx_v9_4_3.h"
 #include "gfxhub_v1_2.h"
 #include "sdma_v4_4_2.h"
+#include "amdgpu_ip.h"
 
 #define XCP_INST_MASK(num_inst, xcp_id)                                        \
 	(num_inst ? GENMASK(num_inst - 1, 0) << (xcp_id * num_inst) : 0)
@@ -219,77 +220,6 @@ static int aqua_vanjaram_select_scheds(
 	return 0;
 }
 
-static int8_t aqua_vanjaram_logical_to_dev_inst(struct amdgpu_device *adev,
-					 enum amd_hw_ip_block_type block,
-					 int8_t inst)
-{
-	int8_t dev_inst;
-
-	switch (block) {
-	case GC_HWIP:
-	case SDMA0_HWIP:
-	/* Both JPEG and VCN as JPEG is only alias of VCN */
-	case VCN_HWIP:
-		dev_inst = adev->ip_map.dev_inst[block][inst];
-		break;
-	default:
-		/* For rest of the IPs, no look up required.
-		 * Assume 'logical instance == physical instance' for all configs. */
-		dev_inst = inst;
-		break;
-	}
-
-	return dev_inst;
-}
-
-static uint32_t aqua_vanjaram_logical_to_dev_mask(struct amdgpu_device *adev,
-					 enum amd_hw_ip_block_type block,
-					 uint32_t mask)
-{
-	uint32_t dev_mask = 0;
-	int8_t log_inst, dev_inst;
-
-	while (mask) {
-		log_inst = ffs(mask) - 1;
-		dev_inst = aqua_vanjaram_logical_to_dev_inst(adev, block, log_inst);
-		dev_mask |= (1 << dev_inst);
-		mask &= ~(1 << log_inst);
-	}
-
-	return dev_mask;
-}
-
-static void aqua_vanjaram_populate_ip_map(struct amdgpu_device *adev,
-					  enum amd_hw_ip_block_type ip_block,
-					  uint32_t inst_mask)
-{
-	int l = 0, i;
-
-	while (inst_mask) {
-		i = ffs(inst_mask) - 1;
-		adev->ip_map.dev_inst[ip_block][l++] = i;
-		inst_mask &= ~(1 << i);
-	}
-	for (; l < HWIP_MAX_INSTANCE; l++)
-		adev->ip_map.dev_inst[ip_block][l] = -1;
-}
-
-void aqua_vanjaram_ip_map_init(struct amdgpu_device *adev)
-{
-	u32 ip_map[][2] = {
-		{ GC_HWIP, adev->gfx.xcc_mask },
-		{ SDMA0_HWIP, adev->sdma.sdma_mask },
-		{ VCN_HWIP, adev->vcn.inst_mask },
-	};
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(ip_map); ++i)
-		aqua_vanjaram_populate_ip_map(adev, ip_map[i][0], ip_map[i][1]);
-
-	adev->ip_map.logical_to_dev_inst = aqua_vanjaram_logical_to_dev_inst;
-	adev->ip_map.logical_to_dev_mask = aqua_vanjaram_logical_to_dev_mask;
-}
-
 /* Fixed pattern for smn addressing on different AIDs:
  *   bit[34]: indicate cross AID access
  *   bit[33:32]: indicate target AID id
@@ -858,7 +788,7 @@ int aqua_vanjaram_init_soc_config(struct amdgpu_device *adev)
 	if (ret)
 		return ret;
 
-	aqua_vanjaram_ip_map_init(adev);
+	amdgpu_ip_map_init(adev);
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.h b/drivers/gpu/drm/amd/amdgpu/soc15.h
index ef7c603b50ae..c8ac11a9cdef 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.h
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.h
@@ -118,7 +118,6 @@ int vega10_reg_base_init(struct amdgpu_device *adev);
 int vega20_reg_base_init(struct amdgpu_device *adev);
 int arct_reg_base_init(struct amdgpu_device *adev);
 int aldebaran_reg_base_init(struct amdgpu_device *adev);
-void aqua_vanjaram_ip_map_init(struct amdgpu_device *adev);
 u64 aqua_vanjaram_encode_ext_smn_addressing(int ext_id);
 int aqua_vanjaram_init_soc_config(struct amdgpu_device *adev);
 ssize_t aqua_vanjaram_get_reg_state(struct amdgpu_device *adev,
-- 
2.17.1

