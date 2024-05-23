Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E37AC25B75
	for <amd-gfx@archiver.kernel.org>; Thu, 23 May 2024 08:07:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3841989A72;
	Thu, 23 May 2024 08:07:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vaBNZD1E";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2042.outbound.protection.outlook.com [40.107.243.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 025FA10E159
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 May 2024 08:07:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gqck/jrhMekDzJi1O3PuhfnqVGmj7s0qGEgYURrZPDMuXUL8dZJeQmz1HU6Gxnk309d4uyMCX2zCL8XttThk+R7UugaMCzDjcNgng9bHFpBOGw2C0e7UeVeJhsaA9DK0ljUkXmwrGgi7c834bTiCuj07rq6SIkVfCdc28Xyw9//opU6qrMdmqFflRzwCebGoSx/sAeXHptCB2FitYKtD9IO8yF88Fj+R5K9Ljdl+qrVoMdnYAvnjKXZd/I/Gncq78SLubN6vI/Ktut9CuRf1zZEb52sjhcYzzDcZR0yeFCiNnie5JI09dFwHw+VzC4OKlCpX+EZhbYLxW4CXCkVU7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7+FxIVfn61wEr5X7ilt1UrrO54sb4cyOz/2PWlPk+CE=;
 b=iL5kACvzpcSEdGyFakjPU+u/To86m1NSWDKfjUITV+T+4UnF1sCI6nFNASmQmwMETYvCdqbyroOpj5gi+rRyt3BZhKQ4iMXF1Trvm1rLCG57Xyemedh10R+uFnd/W+30hmJGK1Y+9z/D6poh19wtLGJPv+oYYeV4RYkUcaRIeJB0sMgSdrQBs9pM+swNAgF0PMm64X+X1edr8+sgB19Bmv/xrm92p/4gLcZhhNPEUbMhC8NJohH3VSYctXEyzxwEfo9j9e2evO7zhqZMEI2wU6i9EQlNm8gEIZf/07cP+jU1QeYtofils/xXmyHrflDFNdDaGEgcA+4jdM9iXEHVBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7+FxIVfn61wEr5X7ilt1UrrO54sb4cyOz/2PWlPk+CE=;
 b=vaBNZD1EDOo6u3L40OC0dyeUC1gpbxd4niXfSdbZzvhkCw7gTneB+MJ1n+LqX1SM/QOLKcOfu9+RluZI12g2P5AyFOir193KynYWbZ/8ICcn8kbqlmgn87D33VvV6yXZDb9DnR3yNpb+FpjHKa8D2XbZn02e9xIUiWZ2HFxZH2M=
Received: from SN4PR0501CA0025.namprd05.prod.outlook.com
 (2603:10b6:803:40::38) by CH3PR12MB9196.namprd12.prod.outlook.com
 (2603:10b6:610:197::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Thu, 23 May
 2024 08:07:33 +0000
Received: from SN1PEPF0002BA51.namprd03.prod.outlook.com
 (2603:10b6:803:40:cafe::31) by SN4PR0501CA0025.outlook.office365.com
 (2603:10b6:803:40::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.19 via Frontend
 Transport; Thu, 23 May 2024 08:07:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002BA51.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7611.14 via Frontend Transport; Thu, 23 May 2024 08:07:33 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 23 May
 2024 03:07:31 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 23 May 2024 03:07:25 -0500
From: Jesse Zhang <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <Tim.Huang@amd.com>, Jesse Zhang <jesse.zhang@amd.com>, Jesse Zhang
 <Jesse.Zhang@amd.com>
Subject: [PATCH V2] drm/amdgpu: fix dereference null return value for the
 function amdgpu_vm_pt_parent
Date: Thu, 23 May 2024 16:07:24 +0800
Message-ID: <20240523080724.1422801-1-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: jesse.zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA51:EE_|CH3PR12MB9196:EE_
X-MS-Office365-Filtering-Correlation-Id: b5de5404-5882-4f85-f960-08dc7aff6657
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|82310400017|36860700004|376005; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?rSuhVgEJTRaF5yseyLRz/o3v36zBzZVrhZnFDkwHeI0cW3rjqixvlpcvdOKa?=
 =?us-ascii?Q?kqgMftZlBrWLGUnk9GMvXWcxqfOtddlU5bReyOHH20vIw4dPVj7r4397KnP1?=
 =?us-ascii?Q?YKmXm4ZZUbA6ephWQmmZEpxpXkJaPSWzkldOhgUVl0ew55ZHc38rRu4cx31k?=
 =?us-ascii?Q?qRJihjNg5XifZ6sjfi8Z7VYDaosv4UF21+gh8jhZ/hFk1K0CvrgmpdSr6b3X?=
 =?us-ascii?Q?2O9mZq5l0osbQ5iufXBkhHYTn6lPO/HcfkOYytrbcTN+sPhnVjW+n6GbKX1A?=
 =?us-ascii?Q?OkkUeo5Ho8dNEryYfzDb5SlneFCWKmrdOtE1W1h9Y4VZt/dXMZcIb+5mlhpk?=
 =?us-ascii?Q?VNMY6DbXC9Tlc21ssqPTWy2dkmxgAhzjrYmVUGZ8/EKnyMOr2H55m+E5Tn+Q?=
 =?us-ascii?Q?OG3tTVTOkn2bjlOBwAgfhL1FQ+keOQm5Cjo7fkn+cmmOaILN+G9QyWC2xySw?=
 =?us-ascii?Q?iScLTbUhf83rOXx4wavhjfE7RCLTOGYvXAon5Q78tOqdTfiLesElD85lni3f?=
 =?us-ascii?Q?so5A9sbAM/0Bw653qBojNsPI0g7cRs1xwNFRJkEbmPyoQE2PsUVILwPHefNz?=
 =?us-ascii?Q?BtqVb81nrT8YoyyHYXxukVhiO0NflOEp1xcO4ylap4YBfnYj6uJsqZDSEaob?=
 =?us-ascii?Q?IZSy/zWeqa2bMiJjveKjczJiZGZqacgJDvgvRgsE2Q3b6zu7XG3czIRz9g/b?=
 =?us-ascii?Q?2PnkXTCofT3u9Fy8DaEaTC5I1Rb4UzVoVO53O+VplOYieiYrdt4vIMZXElh9?=
 =?us-ascii?Q?uRb/RRq3UkOIpqPRoKHrH9qFep6g+YGHjfP4e0/JXXxyfi6wfz+h5CO1P4se?=
 =?us-ascii?Q?CTfriw7nX/gYbEEm6tpnSu8mtJZKgq7w8RdYuVAMxVFbxhM9DMCFh1dzJt0k?=
 =?us-ascii?Q?OsrTOnZtIi7RlBTD7Rke6EV37WITnVvXttdPmVTnQx4UcQm0todRooshkd9f?=
 =?us-ascii?Q?0gpqT8G7MLkIswwguFFvRu8W3y7pBX9ASAwRIaU420GtYQbvlqVPrpDIbzPh?=
 =?us-ascii?Q?+/c8wQPhGzvMsKfvEhtbIgds0HlINqHZ9HTBW+n2WJltl1zhH/32TZN0QPwd?=
 =?us-ascii?Q?fIpqJSY1JhBiR8+yMbf3yL80/6CAkVqlgLjkoxW5h/8qLBSeK90CPUJcTM7X?=
 =?us-ascii?Q?IgCoQgaH0YH4gmpqOK6dHL//d2yrmMpqnpjtZxdxSk80O4yquboG/CKq6W7/?=
 =?us-ascii?Q?bZz5fFAU1HMr0GjvQ49nB9q4Mo4oYUs+0X0/DoOHYTyWto07JgTT+c+bHLCu?=
 =?us-ascii?Q?E7/EvSdMjm0Yrn7YhPfpxz5TsFtTf74PFEv/IGiaRsdI/50kb9LCkZthiQ+u?=
 =?us-ascii?Q?JyhKeolia9bKmbv+2atbyBgqMD4cd+PKaIeTE6mj32Bt2ePIqM8qJHOJzXoS?=
 =?us-ascii?Q?l0uu7NIndjfNjalBH1BTwvCk2q0z?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(82310400017)(36860700004)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2024 08:07:33.1277 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b5de5404-5882-4f85-f960-08dc7aff6657
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA51.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9196
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

The pointer parent may be NULLed by the function amdgpu_vm_pt_parent.
To make the code more robust, check the pointer parent.

V2: When parent is NULL here we should
 probably call BUG() instead. (Christian)

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
index 0763382d305a..6fac8440012e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
@@ -706,11 +706,17 @@ int amdgpu_vm_pde_update(struct amdgpu_vm_update_params *params,
 			 struct amdgpu_vm_bo_base *entry)
 {
 	struct amdgpu_vm_bo_base *parent = amdgpu_vm_pt_parent(entry);
-	struct amdgpu_bo *bo = parent->bo, *pbo;
+	struct amdgpu_bo *bo, *pbo;
 	struct amdgpu_vm *vm = params->vm;
 	uint64_t pde, pt, flags;
 	unsigned int level;
 
+	if (!parent) {
+		BUG();
+		return -EINVAL;
+	}
+	bo = parent->bo;
+
 	for (level = 0, pbo = bo->parent; pbo; ++level)
 		pbo = pbo->parent;
 
-- 
2.25.1

