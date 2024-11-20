Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA70CD63933
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Nov 2024 12:35:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3753110E118;
	Wed, 20 Nov 2024 12:35:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BLvmOSqr";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2052.outbound.protection.outlook.com [40.107.212.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A55810E118
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Nov 2024 12:35:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rPdLOKVWvAN5RdO0zoJo36Yecugu/GsJmeBH0igqPVfy2THQRZcueMroy7xpbb7OwP+jnGp+w2WZ6zEKVLalMuup97bycx62mbL1Ar55xZD8+1bouPci/0uPrs42s+LAHsFF3JUQ6uHeHO/4qwRQkdldqDntkEPAk9n0kfUIyZfKlqcaYElvRSo3SBaXHCFgDxrweUZsz/YFmwAblI4+fCFSGN6oB5ZLT6JzhPUr0d7f/8Qp+29bNndrcs3ilfwxBVAxLF9O8tOF0BDPJ6j42R7Kbtk8EvJqjKv/M1aGkMAOq5QnEKUrGJtUUtyIaqZIy6wfblTNjvntccZ4Q5zbvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sB+UHyxaQHsqO8Gpy2ybAxQovF/IN+M0PXNOfEswOxM=;
 b=a8WbJZtP9uiqeJLOp06DxZu4uil36q3ArxgS95VNIiOnxFTvgZEaBWT/vmhOxBG9DSI9Xri8wYzFYXlsDxMcSxdV5IkrGjX+WoAY52tLfWRBT/KdsGSiias39ZjzNDGTnqSfmc6uy6mezzysa2fecPMExJLDNrbsGRXgyJcManSNFy0+UR5dJV6SltyQM43uPvXAo42j3h9hLZ3GF0rCFzNHQmKwBazLeUObwB/XMovD9Sl3g+m4LPxB312gsoeqqKNi/YFg0/tZFwwqGRrhey9u2gklmZ9Xu2w+1u0dMcLNHVZkrtxs3M8Jz5vJHzzuYYtJ3FhCsODI5d3EDyqE2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.12) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sB+UHyxaQHsqO8Gpy2ybAxQovF/IN+M0PXNOfEswOxM=;
 b=BLvmOSqrxR06X01dBo6ULv8z7phUjZ47TijARJVO/Y4zW4XwafVqFgCyplyGd3P81DxPER7cAY/qp3khtV7fE52rCkToCksiUW0qVYwz6NpqngSksCua04vb6HxGKhAtfZHWvomfN/B+ORDjwcvUuOnPtd5zYccQqR27R6AmkrQ=
Received: from BN0PR03CA0028.namprd03.prod.outlook.com (2603:10b6:408:e6::33)
 by DM3PR12MB9325.namprd12.prod.outlook.com (2603:10b6:0:46::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Wed, 20 Nov
 2024 12:34:58 +0000
Received: from BN1PEPF00004681.namprd03.prod.outlook.com
 (2603:10b6:408:e6:cafe::8a) by BN0PR03CA0028.outlook.office365.com
 (2603:10b6:408:e6::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23 via Frontend
 Transport; Wed, 20 Nov 2024 12:34:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.12)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.12 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.12; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.12) by
 BN1PEPF00004681.mail.protection.outlook.com (10.167.243.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8182.16 via Frontend Transport; Wed, 20 Nov 2024 12:34:58 +0000
Received: from liuxiang-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 20 Nov
 2024 06:34:56 -0600
From: Xiang Liu <xiang.liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>,
 <christian.koenig@amd.com>, <leo.liu@amd.com>, <hawking.zhang@amd.com>
CC: <david.wu3@amd.com>, Xiang Liu <xiang.liu@amd.com>
Subject: [PATCH] drm/amdgpu/vcn: reset fw_shared when VCPU buffers corrupted
 on vcn v4.0.3
Date: Wed, 20 Nov 2024 20:34:32 +0800
Message-ID: <20241120123432.1075304-1-xiang.liu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241118094737.1024533-1-xiang.liu@amd.com>
References: <20241118094737.1024533-1-xiang.liu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004681:EE_|DM3PR12MB9325:EE_
X-MS-Office365-Filtering-Correlation-Id: 4bd21f6e-f386-4b43-be74-08dd095fbed9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?M9KGQf0Hhpne8ncpMz7pM2LcomAOvDUWPiPDPeKCToTCH9uCbDaNvPqGaugi?=
 =?us-ascii?Q?jiU2y9DVkyZjcntygGkEqga6yWDBGnv/9GpO01SYXvtRc3qLH7oqIhsXh07e?=
 =?us-ascii?Q?CSMgS/f6oeQbvjdRuX+yL2yWHMbES1duQzj8ZFVGuYrIGzLbkHUXlwhqVpSP?=
 =?us-ascii?Q?028Y2zMTxTK+Kg+tMEzFHLiY8yLhrW10pmK1ynaLnoNDER84ym7gTcCFYDwV?=
 =?us-ascii?Q?LAdDE3Ex58fT8wl3CAH09Js7WOrudtHaXvnjyp9xpbpnThO62I+/RBJq+yuV?=
 =?us-ascii?Q?VuabJ/0IwJF7tWwRHeeUcZfUWTdbiUoiX9ZKs+Bkcz7+0PwRdxmOUvRcZCSb?=
 =?us-ascii?Q?ak9rVY+6sGE1NE7nd3MIVyoo/v+Q3AaNAaEJy4qReztNSnlHW7SQoyC5aKA0?=
 =?us-ascii?Q?8YQDFzXiJkdfv58nd4JLOzbbpaYI7EfijiqKjqj/24ULBa7tW6mynreT93xb?=
 =?us-ascii?Q?sF/QJEBgXhc2posR/75BdJPyu9eLyDgqZdLVQRa+8dybNtwEYyHdQWlUZN7i?=
 =?us-ascii?Q?PgIQeA7yCsWT2L3hJ7lmRGmgqr1hCzYTUzpHXFs24y0p8fhmH+KpZWAnX0ma?=
 =?us-ascii?Q?KC9D/OjFAjukHepdF+xk84zBkTIEBBTrGISYGC5Rescjvi4SEwa6DCMwR1Bs?=
 =?us-ascii?Q?KXw3+mBjYHxDzXXq0KCkCPYF3qTe64ropfvt1Bby/D8zphqUyALaxdEpx8lW?=
 =?us-ascii?Q?Zu6F1KPQrddu3WAImXG0yV9MEcrVD8nmfEUCCMe4WPvD3fJO4P26Z0ntYR/g?=
 =?us-ascii?Q?uQmej9LslHBd5KRuQQYvPq81ldz+O0iXGD3vTDkkK7Q+Nbk3DuVpv9mbYaOq?=
 =?us-ascii?Q?zm9JoIZD13KjRznNc0p2Nda7qyxuCKOddo1XBWvJe5tJXmLnHAAtFZ3dclpz?=
 =?us-ascii?Q?jdGP4f923txakTPntcx5DPqQkN8qrejiLFpRUpJyYMF8jwPiynAeTu6Cm1sr?=
 =?us-ascii?Q?flxYjT+/G0yogqzO4ET8fI5pdVbTaVMusVdX6RcPCyCEyDssCH4e8HEn25Cz?=
 =?us-ascii?Q?oH8NBRIb6dFGM05z+1LksEc1/bYtQKzxjOLgR680+1TFgRcuy8HRwri5gPBD?=
 =?us-ascii?Q?/8DYyrTJfW7Ane++Mt88RZ/c7pcS4Cl66qqiMfFIPO7VYwow4kruLNZc44Nq?=
 =?us-ascii?Q?1aLJZjaNZ7QnNH/Jz7QF3E8iOMclPY+eqkPBZfPLMCCi3cEX6MvSZA6ruogG?=
 =?us-ascii?Q?6KcwARlr+jAPwchNVtfFEdFtKjyTcQfS7oeC4qLkX7KqKmyXia/ygg3fghOi?=
 =?us-ascii?Q?/gZrEWIJBho7wAaU3Kaa40awz0E6dWtrFA9huV0oNbOUpSHKFW0r6tAkGiGO?=
 =?us-ascii?Q?GModZ2DnhBDBG03VN75Fhw0ErsgPTGwOlOhstiaasDF+tD0GzoNBrf0b0X20?=
 =?us-ascii?Q?G82gtN/Kqeo3fSojLaSYiG8uOahwG8vKveH6T9uMIqvrSIAAuA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.12; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:atlvpn-bp.amd.com; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2024 12:34:58.4181 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bd21f6e-f386-4b43-be74-08dd095fbed9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.12];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004681.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9325
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

It is not necessarily corrupted. When there is RAS fatal error, device
memory access is blocked. Hence vcpu bo cannot be saved to system memory
as in a regular suspend sequence before going for reset. In other full
device reset cases, that gets saved and restored during resume.

v2: Remove redundant code like vcn_v4_0 did
v2: Refine commit message
v3: Drop the volatile
v3: Refine commit message

Signed-off-by: Xiang Liu <xiang.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c | 30 ++++++++++++++++++-------
 1 file changed, 22 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index d011e4678ca1..c678631c6887 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -123,6 +123,20 @@ static int vcn_v4_0_3_early_init(struct amdgpu_ip_block *ip_block)
 	return amdgpu_vcn_early_init(adev);
 }
 
+static int vcn_v4_0_3_fw_shared_init(struct amdgpu_device *adev, int inst_idx)
+{
+	struct amdgpu_vcn4_fw_shared *fw_shared;
+
+	fw_shared = adev->vcn.inst[inst_idx].fw_shared.cpu_addr;
+	fw_shared->present_flag_0 = cpu_to_le32(AMDGPU_FW_SHARED_FLAG_0_UNIFIED_QUEUE);
+	fw_shared->sq.is_enabled = 1;
+
+	if (amdgpu_vcnfw_log)
+		amdgpu_vcn_fwlog_init(&adev->vcn.inst[inst_idx]);
+
+	return 0;
+}
+
 /**
  * vcn_v4_0_3_sw_init - sw init for VCN block
  *
@@ -155,8 +169,6 @@ static int vcn_v4_0_3_sw_init(struct amdgpu_ip_block *ip_block)
 		return r;
 
 	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
-		volatile struct amdgpu_vcn4_fw_shared *fw_shared;
-
 		vcn_inst = GET_INST(VCN, i);
 
 		ring = &adev->vcn.inst[i].ring_enc[0];
@@ -179,12 +191,7 @@ static int vcn_v4_0_3_sw_init(struct amdgpu_ip_block *ip_block)
 		if (r)
 			return r;
 
-		fw_shared = adev->vcn.inst[i].fw_shared.cpu_addr;
-		fw_shared->present_flag_0 = cpu_to_le32(AMDGPU_FW_SHARED_FLAG_0_UNIFIED_QUEUE);
-		fw_shared->sq.is_enabled = true;
-
-		if (amdgpu_vcnfw_log)
-			amdgpu_vcn_fwlog_init(&adev->vcn.inst[i]);
+		vcn_v4_0_3_fw_shared_init(adev, i);
 	}
 
 	if (amdgpu_sriov_vf(adev)) {
@@ -280,6 +287,8 @@ static int vcn_v4_0_3_hw_init(struct amdgpu_ip_block *ip_block)
 		}
 	} else {
 		for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
+			struct amdgpu_vcn4_fw_shared *fw_shared;
+
 			vcn_inst = GET_INST(VCN, i);
 			ring = &adev->vcn.inst[i].ring_enc[0];
 
@@ -303,6 +312,11 @@ static int vcn_v4_0_3_hw_init(struct amdgpu_ip_block *ip_block)
 					regVCN_RB1_DB_CTRL);
 			}
 
+			/* Re-init fw_shared when RAS fatal error occurred */
+			fw_shared = adev->vcn.inst[i].fw_shared.cpu_addr;
+			if (!fw_shared->sq.is_enabled)
+				vcn_v4_0_3_fw_shared_init(adev, i);
+
 			r = amdgpu_ring_test_helper(ring);
 			if (r)
 				return r;
-- 
2.34.1

