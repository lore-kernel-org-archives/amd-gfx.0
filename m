Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8A6DC27C79
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Jun 2024 07:40:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 36A5110E09C;
	Thu, 20 Jun 2024 07:40:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rv0vvmu8";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2050.outbound.protection.outlook.com [40.107.220.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1040210E09C
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Jun 2024 07:40:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iauEAYU9R4i1wkiCRX7Lz1uH6bK6NxTpz+8DHqXFAc7pCjypPTdnPDki7fwyJU/dZsyQ/1V0ad+GJsCL152UVlWvfdRENxcqekNItj/lsmD2d2CXgs/GT1f5eeEBkUWO7n3VpemM67TJOQYdxrxwhCE5rs4gYZc6TUdhX+B5Bw13vObAZW01+rjBweVoylDzp4xnHDU+jT8LYOR2E379gU91ASpJpx2FyEJBOePuK9P4TgVdu+fxs1RakkiLmpG/9p2I9oy0dg8T4PMte9t+5cOavqUAJ/czvUfapNYp4qIQ9REzXyU71AaMHxLHnlwuT3WfWhiTi1kAcqVSXUlAOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bsJBmru48gjEw/Zzb45Dm2dlCU6z9H2HsKzgI6XSNAo=;
 b=HHfrqVNTyQIJofFECQ5v2jP6kMlsiCXP59VlNq4lQdteu3lC4NenvLaqKX93DojBwbOIATDx/En+N+fx/O6kNj+G9pgzqjEhC5yOH3nrldo6NG6MZsz1tBnLAMvs4H4t8tOkxz43ScRU9W5a26Molj5FEWA1gCxka0eB+ZzAFHL4C2rg826cRNH7VJa9x441OsAQnzKCjPd+voUdKpqX0YmebDGVKIKjiaAaAIWIlKoJ+L3Zm37J8nrRueoKN4H63L1RI5Asx16GGffRkpyNu34KbazMgyaISpq3eV4MRcqoqG/Q00NO6LPBh2RPDYAOLyf46Xx2oAIemfaNHZdlCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bsJBmru48gjEw/Zzb45Dm2dlCU6z9H2HsKzgI6XSNAo=;
 b=rv0vvmu8ccAfN7J1WoMz+Vf33hSJUvDhGuHsCavXojRX5O1U8Z5YdPAieXxjzr0gCE3x/VoF2UpFfSy4dv5EtNTmAE4q1SDvC0F3QzYGkHejKpM9XeizTPg9ew6iInsrYlE3/UvflGksVffK4iYHwWerAQnlXIezLx2QWKPaZIM=
Received: from BYAPR07CA0020.namprd07.prod.outlook.com (2603:10b6:a02:bc::33)
 by CH3PR12MB8308.namprd12.prod.outlook.com (2603:10b6:610:131::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.19; Thu, 20 Jun
 2024 07:40:17 +0000
Received: from MWH0EPF000971E6.namprd02.prod.outlook.com
 (2603:10b6:a02:bc:cafe::e7) by BYAPR07CA0020.outlook.office365.com
 (2603:10b6:a02:bc::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.33 via Frontend
 Transport; Thu, 20 Jun 2024 07:40:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E6.mail.protection.outlook.com (10.167.243.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Thu, 20 Jun 2024 07:40:17 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 20 Jun
 2024 02:40:14 -0500
Received: from dev.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 20 Jun 2024 02:40:12 -0500
From: Bob Zhou <bob.zhou@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Tim.Huang@amd.com>, <jesse.zhang@amd.com>
CC: <alexander.deucher@amd.com>, <christian.koenig@amd.com>, Bob Zhou
 <bob.zhou@amd.com>
Subject: [PATCH] drm/amdgpu: add missing error handling in function
 amdgpu_gmc_flush_gpu_tlb_pasid
Date: Thu, 20 Jun 2024 15:40:06 +0800
Message-ID: <20240620074006.11922-1-bob.zhou@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: bob.zhou@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E6:EE_|CH3PR12MB8308:EE_
X-MS-Office365-Filtering-Correlation-Id: b9201a69-af0b-411a-97df-08dc90fc3ad2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230037|376011|82310400023|36860700010|1800799021; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?NC1DaTCJ+wy16OwPpIFJb5Bo0gsvXaSy8cLzTZ3Vt8g1a7IhvpXeB8P7JMTG?=
 =?us-ascii?Q?p4m0n8Jb3jCjPR1YCO1DZ2oWz10lAaB0E3zgdAc9MBPt++fwockrOP38/tvT?=
 =?us-ascii?Q?IhMqFVpjrqz4VteQ85LCb4jQgK+rJhGu7gmEtlnntPoYPayrugjPTLf5UAYk?=
 =?us-ascii?Q?VoSC54pcPGiJmUDWYD83H4YSV2CTFstp4dtzFLPyGXQit68gL1GEmJLItxzJ?=
 =?us-ascii?Q?x2VIx0jzNBE20xxa9Sq2Dh/sYV+TUy3ACCWhLfq84V4LbZWucaTUd31bndct?=
 =?us-ascii?Q?cf/z61Zu/BSIw5uglJhxbvdfjPG8Yv23vHmp+yC0atZd4QogsmSdl22u7cMn?=
 =?us-ascii?Q?+CXKRIrklP+zdIBP80oqB8mlh+14ZdGwNmZ5GKMzvMvmMi1uU8yx6W9SQqg4?=
 =?us-ascii?Q?KWV+FzLMt5pjPaCoqUAahdHWnw50hV+lwgE8B5pOnhP6WdveItArcpLjJGtd?=
 =?us-ascii?Q?H6yVsYnFmQ3nrdCx1iomCa4mgdr4GpEsAp8ptWf/q2/YnMPgxjP7+tgJKheB?=
 =?us-ascii?Q?gtVBuPqD+za4UPD3FdAW6OIlpT2cCC3XRDjpglCcrOS3rTPxhVgbVmNj9S8i?=
 =?us-ascii?Q?kvxMmt7uMtGFJ5ogtKkyJHXiZ1BvdiD61hqjYpLt2NshOkvL0+c0HN8m+LLk?=
 =?us-ascii?Q?H3rluGo+Ys8JBknHazDHKduBu3t1jsnc/y5fwZoas6B5UtJhsU7DBkN/9vFU?=
 =?us-ascii?Q?Pc9QWUt116+4ls3tk3TIj6u49I+XwcwHrZk8mufJV13Ne4jfR1Fq2wqHpsKH?=
 =?us-ascii?Q?hJlmJFmf3nLFSoPillTmj/QddOMGl7bPHNqgsnbMG7r2zdmpXSRPKp9qC/W9?=
 =?us-ascii?Q?8H+V6uYeeVC3EeHYfQm4SobFaZDnZKjABmJRkw2X4NW75H20o2of+0wjYtxc?=
 =?us-ascii?Q?oifeP0tg+VFPfKXrQAYrhkGdvZtQBfsl0ZTXFrYK+64KgBV5r/kPDIBvP9ac?=
 =?us-ascii?Q?qkH9BBBKbYIindslrhvrjNm4Rc2oxa0LBFLTaIQAWVvpSLWHX6hH8liC6uJo?=
 =?us-ascii?Q?P+gyK5jPDTsMl1wgGvKbA2JlXMsQ7uOlu0a9saDFAw6LGvIvVdfCD3Xe+XJq?=
 =?us-ascii?Q?aU9dMeE8xRFWAS/5q8E5PasmwBXFv25u65B3wFEarRTobOkQEIVcWeIIOD8L?=
 =?us-ascii?Q?pnV6UM+KR8e7sI7z1U3Fr73BsJIKvFV73Y5puWvN/krGy4od1z4qipN48/o4?=
 =?us-ascii?Q?9fpiR2DHGVKMyK9VlXFTwIH2BL6sRtbdvRMSl3sQ385Xhc4dG5J+gosZLXAt?=
 =?us-ascii?Q?Zz4MoCwO02xtxXjn8DzUS81ovFMFWhCdnY4EJqEvMSrObjpM+Xpl+VyM8jnV?=
 =?us-ascii?Q?4Whn5aY/PRXNtnRmFmdpzh0oEU7E6qvmsUoC1qSAL7FsDkZMAy4DE3ulMU63?=
 =?us-ascii?Q?2Vccy3BY0NQX4iWHPdCrn5EBykaXNMvMGqDtKDNR+bCknhjZNQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230037)(376011)(82310400023)(36860700010)(1800799021); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2024 07:40:17.0774 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b9201a69-af0b-411a-97df-08dc90fc3ad2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8308
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

Fix the unchecked return value warning by warning reported by
Coverity, so add error handling.

Signed-off-by: Bob Zhou <bob.zhou@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index 322b8ff67cde..3a7622611916 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -718,7 +718,11 @@ int amdgpu_gmc_flush_gpu_tlb_pasid(struct amdgpu_device *adev, uint16_t pasid,
 			ndw += kiq->pmf->invalidate_tlbs_size;
 
 		spin_lock(&adev->gfx.kiq[inst].ring_lock);
-		amdgpu_ring_alloc(ring, ndw);
+		r = amdgpu_ring_alloc(ring, ndw);
+		if (r) {
+			spin_unlock(&adev->gfx.kiq[inst].ring_lock);
+			goto error_unlock_reset;
+		}
 		if (adev->gmc.flush_tlb_needs_extra_type_2)
 			kiq->pmf->kiq_invalidate_tlbs(ring, pasid, 2, all_hub);
 
-- 
2.34.1

