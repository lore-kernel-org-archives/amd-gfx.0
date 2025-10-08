Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74A7BCAC5BB
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Oct 2025 19:13:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 116AF10E8D1;
	Wed,  8 Oct 2025 19:13:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="aBTZXUFk";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011035.outbound.protection.outlook.com [40.107.208.35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CBCAB10E8D1
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Oct 2025 19:13:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hp/T4gl3ddwhlFqTaPj2Yc9HIIXoYK8rLZpdsCYuXnePoAwlcsMrsVEzJt/fcB2nuPwHbNzola6DBp0EDHWBXGZcNnK9dH9akALPmZldHYscEMkAIP6vKJorYUhW/pwXamNj9I0//l+DkTWAvK49nf/4COLrifl3wVVpUVbTV953th77T86kxBfhboJ8DLcQkL8neHgttCxHUV70Fj/28R0/5+AezFh54KDnKm/CGCrP8y1+v/Z0kEwTpCzgxrtM//YQRanhHl+GG6THhVxBuEZC/Nn5T2qCFBpeJ2E0Euofl+QiFH3zezc7kPWmb2bGLfLhU5xsx7uI3fFxY8vuhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xdaiD+DJMkxqCkv9e2fvvWKNHwO7yG1yk/IKBhTaqlI=;
 b=TrqKW6wvwlfo4RRuv49UzuFpiIUoDX+KtsUf3GqEkGNq2UhYbYhW5DtK7J/kqr8r9wsowgF5er7VUtfB1WGhuZB9+xr+Zpg9P/vqguY1gSjsTrcCvUeeICGelWkQbke2bgwGcVw56iU3QGZ9CoFtZQJaD9n17uevcicZBVTaRp27sdJxakv4NkrSUE42H7iEddFp+UtmrceGYFjuAyASj1FQUP7e/chs+BizWOsCGbDt18iVou6qD0xtELtHjEI0/xDo5KSPVFCS92p5bKK9mnOOZhOP/9fGzBncnIZp7gnDvRArki0Ztzt4DlcUJl9Jm5CN0VuZOybyII4IStNzKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xdaiD+DJMkxqCkv9e2fvvWKNHwO7yG1yk/IKBhTaqlI=;
 b=aBTZXUFkmkyES3EFYUZLvmSPydCc8zGlj3s/JG0TA8K0k0aqnT+HKrRvLvg9hW8uSNtr5CPWzPxyYdlkIbg/ZXF8dYRlCfnUoctVFoTVfhPKH5nFPO2flydm5Y6xYWDFH34i4vdllFc9iNTe7AtuF3XmI4nraB/bZi0pVh+ZvIY=
Received: from BN0PR04CA0157.namprd04.prod.outlook.com (2603:10b6:408:eb::12)
 by PH8PR12MB7350.namprd12.prod.outlook.com (2603:10b6:510:216::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Wed, 8 Oct
 2025 19:13:38 +0000
Received: from BN2PEPF000055DB.namprd21.prod.outlook.com
 (2603:10b6:408:eb:cafe::c0) by BN0PR04CA0157.outlook.office365.com
 (2603:10b6:408:eb::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.20 via Frontend Transport; Wed,
 8 Oct 2025 19:13:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000055DB.mail.protection.outlook.com (10.167.245.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.3 via Frontend Transport; Wed, 8 Oct 2025 19:13:36 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 8 Oct
 2025 12:13:36 -0700
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Saleemkhan Jamadar
 <saleemkhan.jamadar@amd.com>
Subject: [PATCH] drm/amdgpu/userq: drop VCN and VPE doorbell handling
Date: Wed, 8 Oct 2025 15:13:16 -0400
Message-ID: <20251008191316.957075-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DB:EE_|PH8PR12MB7350:EE_
X-MS-Office365-Filtering-Correlation-Id: 9401d110-ec0c-40a1-71f1-08de069ec868
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3f5IeGUp9IrXGPwnq/fRjNXZ4A7g8S0wsYnRbvtRgRW/DRz8hXdFy/nK/eN4?=
 =?us-ascii?Q?F7YSxW60FKqqB3fqKqSDaHFz3dKQiUcr2XWipBpjA/qtpDvKAAnVmRbOaOWP?=
 =?us-ascii?Q?t7V//9u6XJSRzebiOLYqodOpIimFkB5ngY9geFg/3ibzCTAlCyiUv93cGa2E?=
 =?us-ascii?Q?UZOSgjgwmEyuHPdkZ+pTenBCoDaY+Jy9y4xyfo2ojbR0D0ADFDQ3fqJOh9H2?=
 =?us-ascii?Q?EkAYr2iV1YdRVG/9ol3Y/ZVBotzMyVMgAiq+6J2cCfemsD6jaDoZM1Q+Kyql?=
 =?us-ascii?Q?OYpeubIr5Z8QZCtFtJJ7x/u8JRzFONYfunGXuWeksECQCwQzWpV7snMdQMYZ?=
 =?us-ascii?Q?Z0FVrzAuSgVe6J15QSSRsoTafoVQ6vYtUsdisOwiLQ1aa42djX2DHdgP6TWc?=
 =?us-ascii?Q?kHS2bHxrROCN+kHuPEJlUeQ6nxGDAE/1oGVc3b7z1A1MR5c6xRmnW7LlZkR1?=
 =?us-ascii?Q?mGMyvF20TftMsMTZlusst3hVcVA5LLI4l8GaHpbM435g20ijzB9xYFeHCnFF?=
 =?us-ascii?Q?wHjHXQ3xduUeWa/R5NWnUuTzhISD0mzh9CbC2TimnSpwGxaSFkZY8vQwNmWp?=
 =?us-ascii?Q?HIXIKmvsRfK/hLW9LLrT3ZaYPPJ/nnUBepKACtPZMRey/yz6B6wvvHGCuOuO?=
 =?us-ascii?Q?OY1h2bWg1GdFGl6nHG1SxGARoonP5KIe3kw/ZKzzfVC37Ry1YEgW7AskRYtL?=
 =?us-ascii?Q?AnftonF2Yunw1zd/QAVn8AIQXRcF2eHC+1uz+5r2Bh7cx+1bPJ2Lu/DdIqtC?=
 =?us-ascii?Q?P5/+5KBnCfTFTg1mCYTESZeYITaGsqKYViJBML/zjmV3Pew+SfTy87uGqbI3?=
 =?us-ascii?Q?ttlkzAX7DNG6a1dUE41Zc5te7G0NMv4tFNPGwXNuaVnBMQM9zHqp4V5sB6LK?=
 =?us-ascii?Q?NbJSz6GBgl9yqtZmBErGjpZoc5WITX5B6CxarSDlonJMCjog4GcXGnTsUZDJ?=
 =?us-ascii?Q?KYzrBSjoS8Tcn0sz+aFu9sE6sRxGyf3wyBtHa64/eBKstlQpyqvgi4+L2iv3?=
 =?us-ascii?Q?pPXXvpChTqxqHB7o63THX+sbiDo95JRZidZYja+fdXtwQCV5ggstET+MOADu?=
 =?us-ascii?Q?HFhXivgJDBLplHJgpSP29o+1f64slE4lLpeCyn5vGwpP2cAqWhHHgJki4T69?=
 =?us-ascii?Q?jUWhR3VRvGFkMLtZcoh5O/X7+Qgqovoen3autgBxzwYRu1eb2sMjTG8FBs86?=
 =?us-ascii?Q?0TxzUa//KJOuUQ4qFe1P4ieEc8Oaz6KMlNMxgNsIJiYajrR2RyVDj2MN+RrP?=
 =?us-ascii?Q?89iLPCPX/IzvK16gZsfW6D9/mgIij9I2pF5oy7r+DJxsSWEHzjQYW3J+CCPJ?=
 =?us-ascii?Q?PLyqfcjuNGPrv7e5nE6M3EEjXmgy/QkojgSsHh8Br7DZzM1VNDJHRsBY5B5O?=
 =?us-ascii?Q?2i2OgnsRs3b08ZhbutWOrU94Z/Pw76ILt/DLzRaLSTm0Lj4kGhYOBR9aLLDX?=
 =?us-ascii?Q?unNMXGSMhpWHj3LxLrOGXOJuMw2pewNsGK+zt2wt7wsD41GHKpxZBc59Krss?=
 =?us-ascii?Q?ID1l0n+py8bu1Hlrf4M7jh4jt2ZRLDQgIeh9yu6MOLwtZR9mUXZXmmEzKRzE?=
 =?us-ascii?Q?04jwi/aOzGPKsIOQ0WE=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2025 19:13:36.9649 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9401d110-ec0c-40a1-71f1-08de069ec868
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055DB.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7350
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

VCN and VPE userqs are not yet supported and this code is
not correct.  Userspace should provide the correct
doorbell offset with in their doorbell page for the IP.
Adjusting it here will not work as expected as userspace
and the queue itself will have different offsets.

We need to add a INFO IOCTL query to get the offset and
range for each IP within the doorbell page to handle this
properly.

Cc: Saleemkhan Jamadar <saleemkhan.jamadar@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 8dc12064da495..916ce142b3c92 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -319,17 +319,6 @@ amdgpu_userq_get_doorbell_index(struct amdgpu_userq_mgr *uq_mgr,
 	case AMDGPU_HW_IP_DMA:
 		db_size = sizeof(u64);
 		break;
-
-	case AMDGPU_HW_IP_VCN_ENC:
-		db_size = sizeof(u32);
-		db_info->doorbell_offset += AMDGPU_NAVI10_DOORBELL64_VCN0_1 << 1;
-		break;
-
-	case AMDGPU_HW_IP_VPE:
-		db_size = sizeof(u32);
-		db_info->doorbell_offset += AMDGPU_NAVI10_DOORBELL64_VPE << 1;
-		break;
-
 	default:
 		drm_file_err(uq_mgr->file, "[Usermode queues] IP %d not support\n",
 			     db_info->queue_type);
-- 
2.51.0

