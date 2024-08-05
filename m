Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20783C3DA7F
	for <amd-gfx@archiver.kernel.org>; Mon,  5 Aug 2024 14:02:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B93310E20B;
	Mon,  5 Aug 2024 14:02:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zPlVMlAR";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2077.outbound.protection.outlook.com [40.107.243.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5847F10E20B
 for <amd-gfx@lists.freedesktop.org>; Mon,  5 Aug 2024 14:01:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tWYu0BAvA6JCrVX4uyC5t8b86G9eqt9LK/CqPDXdy1fujPRTgPTorZryyjBUZfTI6zUMC90Cr1i9dU8TVtyq2tCc2vlM8IaIUFQqXqHnGKNc7Uk6ldpBIp7tOcaq2yN5P4yTtHGvvsvD/3VO83FqY19sZsWqqXxkuTpOjZmBRvJUHOBEGIEfAMZY9dvZU/606K07JvGzGpyBhQzZvjv40/cn0K35/Y9oszFkpNKIum4XTeMSreoI7fT7/zOLsBrUmmwh0QDUyPzANF3H22nKmKrQOtkc+4glO1dr1fkjy0TOxsAy/oDMwCEzuuxtaqyvRrr4smGX82Po4s7Hpwt8tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M9L90K2DUlYH8ntBxdZnjErA40N41asbd9KtYdYU7kw=;
 b=uoJQOzdZtG+93DDogqVdcH4a/Iw39/rouACjPS2DnJog8NkvGsmgpslbqqIrfV7xjp5VGSGvSdLfVXXOI43uxrmxxhYncMM1eiGra2fszwQcYWupB5vtGtMxAQ+3fR1AWqqPYsU1lYj1ZEhU3eflT13Dz3AWNzyO2ecmLTLfIrLl7Nhz/obRXrA5GEwB/RNjC26P0ZY69UJj33RcLqYHCizK18eawZX61urQYgtlehfHgNlnykB9/qWKaOMLoPrjWAafxC0nL3NPD5mJ9tGCYbOV/jFQBGkgJvy0C9vBhIk6hwsAE2SG4QZRZ9G5GrtBITxGvwuGKkdVAcF/nPT5iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M9L90K2DUlYH8ntBxdZnjErA40N41asbd9KtYdYU7kw=;
 b=zPlVMlARTZBLGJZAcNpHZSSla7GspTqtDcHUMO/tXDpl4QvculahkrUKifEFJbjt3uD5NAH2Q/wx0kVNGNFXr40IGll+JEmtIHOKZ5n0R5BNYUdttBdXuis2JiWVn4CZhhGZVe6vhVnzaLOePp3Ko/XTqRS1UA94VGOsFEUKxAM=
Received: from DS7PR05CA0088.namprd05.prod.outlook.com (2603:10b6:8:56::14) by
 PH0PR12MB8030.namprd12.prod.outlook.com (2603:10b6:510:28d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.22; Mon, 5 Aug
 2024 14:01:53 +0000
Received: from DS1PEPF00017095.namprd03.prod.outlook.com
 (2603:10b6:8:56:cafe::5a) by DS7PR05CA0088.outlook.office365.com
 (2603:10b6:8:56::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.11 via Frontend
 Transport; Mon, 5 Aug 2024 14:01:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017095.mail.protection.outlook.com (10.167.17.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7828.19 via Frontend Transport; Mon, 5 Aug 2024 14:01:52 +0000
Received: from amd-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 5 Aug 2024 09:01:50 -0500
From: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <christian.koenig@amd.com>, <alexander.deucher@amd.com>,
 <frank.min@amd.com>, Arunpravin Paneer Selvam
 <Arunpravin.PaneerSelvam@amd.com>
Subject: [PATCH] drm/amdgpu: Add DCC GFX12 flag to enable address alignment
Date: Mon, 5 Aug 2024 19:31:25 +0530
Message-ID: <20240805140125.549000-1-Arunpravin.PaneerSelvam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017095:EE_|PH0PR12MB8030:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bd8d78f-776d-46a6-11fa-08dcb55728c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?n7JCSOKsd8txk8X+O6DsgYQ6srOlXrqxh3wgUb+9S8l6FVwKen5Vs4GN01ya?=
 =?us-ascii?Q?AHYVitnfKbEWMpNf8LC1za5THETfCYa3pYmPMQNnUeMj40RnmA3vCThtBjoV?=
 =?us-ascii?Q?UXfeBa6sE8t+XV0LMYP2fdVM7gXW3UQjiw8gq+FlZkCWYJNIx+M/OwJMmrmQ?=
 =?us-ascii?Q?z766mYDYyuVR3sCu5NwB+1/loORUwtt6OGP2LzAaIJ/fSzVJ7OBrT5wglMoG?=
 =?us-ascii?Q?WWCIj7gr6qT1NJu9xCEXzZens9NI/3L7qsKnlwOE1WxTvBGRAJO46eXHGJFY?=
 =?us-ascii?Q?Ywa2VJMrgq2bDUx2yihIxd4xKOpqLX+PSjbWwbKl9qY+/+5IiHsEPSD+XMqx?=
 =?us-ascii?Q?U4kG4sgTjLbv4NRBcIDGNf297O2GEMvHNJfwXaENyL50YL0OBQLSW/ALLxmI?=
 =?us-ascii?Q?Vc0TnWfBClfocvzyZmH/DxiSsOhXVCZrt+2aOuBDR8/zh+qS7NROLJ14lG/U?=
 =?us-ascii?Q?1jP3hmlr4JxuTJnTsMj/BbvLAgbCqfbNrDsByGBhq2skpRjRuzNH4sRftJ0m?=
 =?us-ascii?Q?ZmxCP22nUol9J5IBVh3mreBAu98db4gMmMPuKk1eBq8CJN9fBAhtqpoYZ/A9?=
 =?us-ascii?Q?k+kLEvUsoNSeya/Tj/M5Awgdi/dLEzRrwR75uaC2jnM6dioWYTy6+VkA3YUc?=
 =?us-ascii?Q?EZ+8gzUOZfjAhbAnAHm4ZC2T5ZRfx+J1RiLz060BN8lwxJ527kJOws/wjc1V?=
 =?us-ascii?Q?O7HC+jAObib9vsH6Ua8NvQL8ArCF5mFK38RZvMDzN7EQz8SVxSGhiGee6u7h?=
 =?us-ascii?Q?id7QNtJXvy2Fovkj02mvN+TCcoA0v5qr8LE1SxfLOYOz/U9QodYR9vOEwGKf?=
 =?us-ascii?Q?XBLpCopFWT6hyzzigUuORXnANmFPSEn8su7VWATHiN7J1Nu1wEuGyQP7qM4j?=
 =?us-ascii?Q?i3h9xMKu0Kcpqv1zRGOoxYLiCKoDN2cGzFaE/IuWVA50Garxb6HQsWJT4Ukg?=
 =?us-ascii?Q?pa980z6UvE0K64o0JQjXbA8O+E+Mg5NkAFjsgvpUHdX48+tUSIoZ1ZflqRRh?=
 =?us-ascii?Q?62Kg7hB0nwzKA9fJPuiVTBSAg/iWCC9Jjl+OdhgEyAOjDmDg4Fp72nr3hTs0?=
 =?us-ascii?Q?0yeF5bWvMp4Vh0GbKgUvbtTxAJt68L1XIeUyTv0pVglNJwVnC4CL/Ud/bV9U?=
 =?us-ascii?Q?qzT799cYSrpS9V5hicvEWKdd+ude7o26lOVWvub+fib0wSP2o861/8+73Pfr?=
 =?us-ascii?Q?cq71EXi4gpU8wzHwxEUqsPc/Fln8l9crdgdym8IS9aqmtKBiZ1ohryPS7eh3?=
 =?us-ascii?Q?jT4Xz01fpcyneeMa17V4LGEHVmQ0grqYo0G9KiA1ETgyVLnaOEBC4SrUdu0p?=
 =?us-ascii?Q?234/Nxk3Lcx1KNStj1gfWFYHp+IqkQA5qIhfm/5H6y2pvlQ4y9MBzPgw9ccR?=
 =?us-ascii?Q?y3rZlJzB7FBB3WBUO/M1LIfMUysKz+d/1aIVpLelu6uajedfqEp9AJzShTWC?=
 =?us-ascii?Q?b+N+GgX4XjI5i2o7wQe6yqqI9BB2ukEp?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2024 14:01:52.9132 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bd8d78f-776d-46a6-11fa-08dcb55728c0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017095.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8030
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

We require this flag AMDGPU_GEM_CREATE_GFX12_DCC or any other
kernel level GFX12 DCC flag to differentiate the DCC buffers and other
pinned display buffers(which has TTM_PL_FLAG_CONTIGUOUS enabled).

If we use the TTM_PL_FLAG_CONTIGUOUS flag for DCC buffers, we may over
allocate for all the pinned display buffers unnecessarily that leads to
memory allocation failure.

Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
index 5415a5cc7789..7de0ac07a060 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
@@ -509,7 +509,8 @@ static int amdgpu_vram_mgr_new(struct ttm_resource_manager *man,
 		/* Allocate blocks in desired range */
 		vres->flags |= DRM_BUDDY_RANGE_ALLOCATION;
 
-	if (adev->gmc.gmc_funcs->get_dcc_alignment)
+	if (bo->flags & AMDGPU_GEM_CREATE_GFX12_DCC &&
+	    adev->gmc.gmc_funcs->get_dcc_alignment)
 		adjust_dcc_size = amdgpu_gmc_get_dcc_alignment(adev);
 
 	remaining_size = (u64)vres->base.size;
-- 
2.25.1

