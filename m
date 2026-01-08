Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3940FD1D478
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Jan 2026 16:08:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B790610E79F;
	Thu,  8 Jan 2026 16:08:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zrcfmlNb";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011013.outbound.protection.outlook.com [40.107.208.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3647110E791
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Jan 2026 16:08:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q7RE86x3hNfzOdN81/ZqUsUvw7MfAqfuckrJ5Cy9GJUVQ1fTjxu82SCx+SMBcc0MpdxF/TRYhLAAfanEYi4HsD+MLh2/DlekgBFTlw3XsbRWGd6/oABrd6487qOrRCCxHB8uvc9JV5RPd6hEA/T6WZsHorL8YZIJioafvrN7yo2O6kBETqp8AoosdS6Ywgtu39WI3pSoCm95dLHGiqQB1gLI2ytv8Fokv5X+pX9825Veiqf9srlNm0Qbvpd9jfQHoX8AJeEU9injlbt2ZJNq5vu92fhjrCYBP4t7mjd46ftbZfScwAXMNeNwKObUXFKGf01+uC+td8fTJsU5IXbMWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S9nxICSl7D1EU3HmAYIJkt23RJnunB6x+VBeJJYDj5o=;
 b=mDlbw1b5vR/HvQc7QVzWmX4mZxh3/YiAwiqunr0ihb5+r1nYSkPxSm9FRG1ZYIfL117ZHM2ht4L9Zlnqx6XPlIhmR2sm8MGznWsuG/KAjHEMIajovpxUGPieDd4UTgQwHbXboJAlOXRaGZcun5A+LM48C+CUK1LZ3jxmRZiqDFcljGZazEd9KAT7fJXDtBIXPWQ/A/cHFRl1iMYvFoaR4HCpYutizHx2Yo6hALDPaX+ltJZmgAGmktxpPZFqOIOVB2xQWYxyFJlC31x7clI7m60TOtdN4W9fNyG1FNcaB21vgeQ8pxJP5ImN3osO3BPw+4bw8vT3lrcFY/BVz09uOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S9nxICSl7D1EU3HmAYIJkt23RJnunB6x+VBeJJYDj5o=;
 b=zrcfmlNbc14KWHrRQNFWRWYqMWC8aZyANC9LE75XcWFkdPG75wacDR34oumyPvVfgUKLyzLhFvaCUKTw/Dpe0x4jmyuDPOpUyg0MFbLHZ0JN3J5J0GPnohfWGgB8AGN4dmut2Id3a3u6P6Zwk0s0SMl2IGLDkhq80UY4nixANPg=
Received: from PH8P221CA0031.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:346::7)
 by PH7PR12MB7163.namprd12.prod.outlook.com (2603:10b6:510:202::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Thu, 8 Jan
 2026 16:08:08 +0000
Received: from CY4PEPF0000EE3E.namprd03.prod.outlook.com
 (2603:10b6:510:346:cafe::7b) by PH8P221CA0031.outlook.office365.com
 (2603:10b6:510:346::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.4 via Frontend Transport; Thu, 8
 Jan 2026 16:08:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EE3E.mail.protection.outlook.com (10.167.242.16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Thu, 8 Jan 2026 16:08:05 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 8 Jan
 2026 10:08:05 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 8 Jan
 2026 10:08:05 -0600
Received: from Xiaogang-ROCM-Dev.amd.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Thu, 8 Jan 2026 10:08:04 -0600
From: Xiaogang.Chen <xiaogang.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexdeucher@gmail.com>, Xiaogang Chen <xiaogang.chen@amd.com>
Subject: [PATCH v2] drm/amdgpu: Use correct address to setup gart page table
 for vram access
Date: Thu, 8 Jan 2026 10:00:32 -0600
Message-ID: <20260108160032.1114678-1-xiaogang.chen@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3E:EE_|PH7PR12MB7163:EE_
X-MS-Office365-Filtering-Correlation-Id: d56548c5-166d-42f4-d8fc-08de4ed01bcf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3ISd7SETxpkKzB5mkgH4NlLPCo3q9tDcjd6dmqGqRCkF3KCTDAfWyH2s7VO8?=
 =?us-ascii?Q?kK5Aclsc3cBBpkwLT1ROFTfjTjfF0aohZhF2ObgyL9XZYKVKbZJ7SZGI4+wH?=
 =?us-ascii?Q?reuQ+IRdzDTQ+RvH4wRxCKg/WSp2kKVHEHFI70V6Wgsj9jXaQNYGVRG1TD8r?=
 =?us-ascii?Q?mIcPYYxvwlwQsKpsQpch5Fk3+LYd0s58gBHouEDXyvt0Mk7c89Zw7hN3ri+d?=
 =?us-ascii?Q?NgfWjmYUvqOPI63bFAtjFof5mLYEr8rtTy0+DlYdPDMrHwq5Ug139xwUPBCR?=
 =?us-ascii?Q?6i7c4FxADeDfgsdyajGaNj1RmBzc/Ey821cZcx5ACxaAOq686kJFl1Vstg0B?=
 =?us-ascii?Q?AYqdOgA+0qlZ6xK/BsBJkvgppgKLn0KZ7I5rzJZp6w+AuTqYFuOX42UsTTSO?=
 =?us-ascii?Q?90UaSxfodermAGc38l0knaytW7e2WlEh5UsHcOuetrOuZKXpMm6uNsWtg2R0?=
 =?us-ascii?Q?IxCLvIGInC66XdujYBaoRzsQwX9PczO/6JV5TjGWSjzWuPY8YHnVC22PvT2I?=
 =?us-ascii?Q?/LrJ5Xi+6dFfPeb/ElE7RMDyQ7FOzHWhC/qQdNPBdzBJz8vnEyqejMQCzcRl?=
 =?us-ascii?Q?wxi1lrfYiQoBmOXaNiMqwnDIW8OUXI4cDKsEfOdbfPJxiE3EZKIQJzVda9bw?=
 =?us-ascii?Q?GD8gXCCoUNk4gXuVVIF7cAn9O0sKqJu3+kOaL/SBMQytveeegagfN3Dhfy3d?=
 =?us-ascii?Q?znJve2Nl2rBl/N8OEb6r+wHPUNgSafigcpuReEI4p1eWkMh8bV4uIF9lknl/?=
 =?us-ascii?Q?+SXccsti2WXAkHuSKq8HGtB7RC1nsZBC3qOd3cp3hpcIn082ATOaA8V7MOOd?=
 =?us-ascii?Q?tVEAzEaEAoqzXnj5l9db4vdDwUsPU6z6l6D983OD0mRySg6/QZxKk0cpxZzi?=
 =?us-ascii?Q?wO5KhgtLUMns54tuxa2g8NaNy56/Tyf0jQLA81T7FfgK8WQYzYKCDgposowK?=
 =?us-ascii?Q?HdYwcGY6vFKwD5EOmmaRyEKB/qlAd6bwTPjRXK4b2PmSZFDLZGvYKIvoSGGz?=
 =?us-ascii?Q?5OqmF1LOXh2lXao3mhw5319r0PRosW4ZoJUK8elvxSGNrpNxdLPan95y7GFI?=
 =?us-ascii?Q?eQJrHxB1QKyFXA0pYFPQ3IUIgrGPaxygJItr1iJHokJzjhpM9CGSV9+DY38t?=
 =?us-ascii?Q?xLwfhBMPLAc7yP5siXTkeHr4aax3RmNCOUWZg50BwFgqzYSYhnOvi3F2AVn2?=
 =?us-ascii?Q?ifbdYmLtZMZccHtbF58yhL/udXKnT/NlIzhpiPDTWId04XOk55PUPKUPf7f2?=
 =?us-ascii?Q?vQ9hwCj/kiiXMgsemtiahy0YnazH8OhBNQ2Vvr0j175g5w1TZm0+R6KNAsFE?=
 =?us-ascii?Q?uV1Nq+YNScjAity1IJA+RfVcpswQKdF5BgYoew4KGzD+eqa/iDTrf+9qidF/?=
 =?us-ascii?Q?r9OZM9Q40+0DH/YI2wzbx7+edVhVMdNYdXfms3KSHgSEJyuNS5L+hglGCFb5?=
 =?us-ascii?Q?E4nDIt3QiOeasaQi+iSa72+/5fox1+OJ6dMDQgZePVFT0zOKHcBXF/Yb/5jV?=
 =?us-ascii?Q?HiVBbZSwcpHMGD005VcZIBRP47bq82TXkejwe2ZngAxEJER5yE0PLULIU9Rg?=
 =?us-ascii?Q?kcDockLiCQp3Q7miWdg=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 16:08:05.9073 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d56548c5-166d-42f4-d8fc-08de4ed01bcf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7163
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

Fixes: 68a5940841684 ("drm/amdgpu/gart: Add helper to bind VRAM pages (v2)")

Use dst input parameter to setup gart page table entries instead of using fixed
location.

Signed-off-by: Xiaogang Chen <xiaogang.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
index 16c3b78e50cb..ec911dce345f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
@@ -375,7 +375,7 @@ void amdgpu_gart_map(struct amdgpu_device *adev, uint64_t offset,
  * @start_page: first page to map in the GART aperture
  * @num_pages: number of pages to be mapped
  * @flags: page table entry flags
- * @dst: CPU address of the GART table
+ * @dst: valid CPU address of GART table, cannot be null
  *
  * Binds a BO that is allocated in VRAM to the GART page table
  * (all ASICs).
@@ -396,7 +396,7 @@ void amdgpu_gart_map_vram_range(struct amdgpu_device *adev, uint64_t pa,
 		return;
 
 	for (i = 0; i < num_pages; ++i) {
-		amdgpu_gmc_set_pte_pde(adev, adev->gart.ptr,
+		amdgpu_gmc_set_pte_pde(adev, dst,
 			start_page + i, pa + AMDGPU_GPU_PAGE_SIZE * i, flags);
 	}
 
-- 
2.34.1

