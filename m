Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADDA2CE8D6B
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Nov 2025 18:51:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 34BA610E0FC;
	Mon, 17 Nov 2025 18:51:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qDLoTpsB";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010061.outbound.protection.outlook.com [52.101.56.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D88710E0FC
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Nov 2025 18:51:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tO6iZjezNFvIazY7N0yxZYfj37jV53IGRv9yaKv9utJn+7K22h65GFmugzJSCQZ5VHT3gfN2i0TSUyCdz+8rN7Sz5F9RyI55ELyOvX7X04fzZ4KX64GAc53i+kfNB3a+2l8jL+TTHpYS8mWAeTde7hfFRGNA249tmsQXWPZMgfm2jfDjHT8Z66SnaUEA0FY4fEf/qkKzBxyQE4pfKNScDvBE3cq3MBoin5KSt4rn08fDqnG74pmFTuKCKwc7SlwxNpNeRI19/MMFC628aztpq/TN2D0Fp9ItUjzJtguq5GFe/lgGGMOB1uHgn4oi/9aTOGUxlY+CVL6mrMkWzRphmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W3lq9BPqiAFEW7Dk5GanAHhOURTCq1VRWow1WWTfVWg=;
 b=mlmjywOVEb0U8g2eeSajf5MeHISGFVdrUwgFqn7RgOYNBQi2yNstIiK4AKPhUVZ+zt6aBFLI4r83lfDX0uOdGv4htrd1jZuPqN46GnyxcAYDOUeayeI/zyMT8IjH2QjFsQfvOy4ljhvDVv2yqSD5QzoQBYK6vkIBRljH95eozKAvppoLpy0amr7In3dM7SyGJibuyaZ/O5lLXauj6WzSdQoQeuKBkrAIQa62u0/aemRbnxJ1Ip2k7c4tTmVpwIomSio3QTvnwlehjqwEYbkD6V1+oAhQMIV7S7sMY3qRg/a3buMuy5SWL1vtUt5HfR/q7ikGBVfegL0n8TZ6G2gpdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W3lq9BPqiAFEW7Dk5GanAHhOURTCq1VRWow1WWTfVWg=;
 b=qDLoTpsBTko+EqiOdKSnEp3KQY8cCPb9ZygSJ+n395LlOAlbHIbMidumj2pPCbNkPwhSbtV/9CdB5J+TIebXxKNsO37hp8uaZrkyrCiaPmTmTqGKefMK1v0+s9hUfXZYHhCptAm9ldNnLDEsJCEMx9MDAdCgrNDZBMC4yPfkARI=
Received: from MN2PR12CA0023.namprd12.prod.outlook.com (2603:10b6:208:a8::36)
 by SJ2PR12MB7895.namprd12.prod.outlook.com (2603:10b6:a03:4c6::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.21; Mon, 17 Nov
 2025 18:51:30 +0000
Received: from BL6PEPF0002256F.namprd02.prod.outlook.com
 (2603:10b6:208:a8:cafe::f4) by MN2PR12CA0023.outlook.office365.com
 (2603:10b6:208:a8::36) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.22 via Frontend Transport; Mon,
 17 Nov 2025 18:51:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL6PEPF0002256F.mail.protection.outlook.com (10.167.249.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Mon, 17 Nov 2025 18:51:29 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 17 Nov
 2025 10:51:28 -0800
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 17 Nov
 2025 10:51:28 -0800
Received: from Xiaogang-ROCM-Dev.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Mon, 17 Nov 2025 10:51:28 -0800
From: Xiaogang.Chen <xiaogang.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Xiaogang Chen <xiaogang.chen@amd.com>
Subject: [PATCH] drm/amdgpu: Don't send warning when close drm obj if drm
 device has been unplug
Date: Mon, 17 Nov 2025 12:52:57 -0600
Message-ID: <20251117185257.1396940-1-xiaogang.chen@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0002256F:EE_|SJ2PR12MB7895:EE_
X-MS-Office365-Filtering-Correlation-Id: 922cc8ca-ceb0-448d-8df6-08de260a5198
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?016/mRfxzILBn69o2YKpdoH48mNWrZQwKM9tyHYY6BtLsrMLg1HCYdPIwOFi?=
 =?us-ascii?Q?+GqIj48IBmzJDr5LDx32XN5Tv87ULGHgy7bHUXXgaQoQkFMaeG/K4yBGNi4l?=
 =?us-ascii?Q?FHY3axIDJndPYuUJhPtvupQG6QJxBobJzFw7PcFfkdSpVlzopHxlhV1Tzsj7?=
 =?us-ascii?Q?YLqIi7Q2hvgfK+E+ADzN3q1A/qEQWrSy7ZAYZdSlmH7ndOsuMggzeIQAq8iE?=
 =?us-ascii?Q?3yfuGvuha4ZnQ/6B9qg7zNLzJ7M8tVJnwj/DY/4gpeyKIyCYk28tSVOMIMMN?=
 =?us-ascii?Q?K/f27mVz5xl+gzWhLjivjmUe2rI4yqJnhm2jI5MjXGy1wu6v9KlAe20ZVBpV?=
 =?us-ascii?Q?7tzTi5OCWFneT+5INPJRjo5/LIyw37d111KSjNbG/3G2v2siX3GdIOXk7hex?=
 =?us-ascii?Q?zMfCaqLU7EbeJaSZyKifVXCEZD/vcb6+692zeJjRpjRyQpNuMHSceOyLa5Xw?=
 =?us-ascii?Q?/taFMZVqkTcOv06A+X4mO9GAkAWXJvXsWT2vX/IkCABOzE746SutAHfuET2X?=
 =?us-ascii?Q?uIeqpP6K86+pUOmXNLlPq882A4vyN5MSmNZN2JazExBfrY0flhVIEaiLuMAV?=
 =?us-ascii?Q?8IB9+ZiRMg++5bgehmI1Y0Mq6VAujSyw/6YE28LK+KLbH5thXALLMtEU8Tbj?=
 =?us-ascii?Q?LxSuZjCAMeD7Gcza0rFmfauDljRn9D9+KklrLuUSLTSa+C7h/NnCc1fmSu7R?=
 =?us-ascii?Q?GPaewofWqqYNqI3LxxfsQpAlx+fTrUzUwvcQXTjRtdYpsWGkQOjiTT8rVswE?=
 =?us-ascii?Q?qhHwt+jQUgbxer8AsmaPkYcRB7sEDBkCFheKx2O5/85FDbHzMrcI8SmNd+V3?=
 =?us-ascii?Q?qrRmshkF+rGGMvg2j0pjj9AO5prjb2NLjmw3EZhe4i8dlZutcQjUx5iNYpCH?=
 =?us-ascii?Q?LGJsrH4tUy3RmB10bphADEXnVLY34/rVIT2R15bzCtjYUjNBnndLk6snDK2Z?=
 =?us-ascii?Q?HUYSqpw9aFMFA6Ebs1W3bACmJJMl1eBVhDGfdO/BAhEubcI6r5dcQJ+6ttDH?=
 =?us-ascii?Q?oE8rcGjqzRsHvTx7mK1lfRDWsnmqc7rG3aAWIihLlqwmbW04Se7XcWkvQwWO?=
 =?us-ascii?Q?YbEgSbWgqCTylL/k9/E1PP8Kctzx+HlRLUGryGBLk7gh4DaKziNeyT1Evkzi?=
 =?us-ascii?Q?6YTiqrct9NmFOckpDXLnuSvil+CUxmizkiuSQqb2d5JE6+yL//vY/reKDUbh?=
 =?us-ascii?Q?hRUK4o9brO8FjTOokU4WJ4rb4hWqi5N5o26FrelymKPXF1L3OIviYuDu9708?=
 =?us-ascii?Q?FcdPdN3JjXdlvOmX06Ifz2yF2QfSL1r5FGgn5veesdhsuwzC3F1TwkNoxDnB?=
 =?us-ascii?Q?uwbtjY/ReaIEymD4pJ6NYoj6VErcHMJNQto0+zgB8SSaMsUfv9Jhq+iHcjvM?=
 =?us-ascii?Q?8kR2Js/m2jk4wyYjJhMCgLB/djzYTQSvWYMfwyxdFpv6+BIw/sCGOJAxWKjg?=
 =?us-ascii?Q?bA1eyaZsNlarjUzkcQI7GRZ+KbdlWvTJC/uJkZAQ90rdySHtyWggPaR1fDe3?=
 =?us-ascii?Q?HZe0gxyVCngCXh8ce88qP2EUbihiQppf8eDk0bP9bexcRtwX1Kc4EEd2lG6z?=
 =?us-ascii?Q?nfLafZrOIfVXRHv9OUw=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2025 18:51:29.3236 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 922cc8ca-ceb0-448d-8df6-08de260a5198
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0002256F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7895
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

During amdgpu_gem_object_close amdgpu driver cleans vm mapping for the closing
drm obj. If the correspondent adev has been unplug got error -ENODEV code. In
this case do not need send warning message.

Signed-off-by: Xiaogang Chen<xiaogang.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index e3f65977eeee..1b9a6b15b29f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -377,7 +377,7 @@ static void amdgpu_gem_object_close(struct drm_gem_object *obj,
 		goto out_unlock;
 
 	r = amdgpu_vm_clear_freed(adev, vm, &fence);
-	if (unlikely(r < 0))
+	if (unlikely(r < 0) && !drm_dev_is_unplugged(adev_to_drm(adev)))
 		dev_err(adev->dev, "failed to clear page "
 			"tables on GEM object close (%ld)\n", r);
 	if (r || !fence)
@@ -387,7 +387,7 @@ static void amdgpu_gem_object_close(struct drm_gem_object *obj,
 	dma_fence_put(fence);
 
 out_unlock:
-	if (r)
+	if (r && !drm_dev_is_unplugged(adev_to_drm(adev)))
 		dev_err(adev->dev, "leaking bo va (%ld)\n", r);
 	drm_exec_fini(&exec);
 }
-- 
2.34.1

