Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F091F606A8B4
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Nov 2026 03:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=PYst0cOp
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 76F2E10E025;
	Mon, 16 Nov 2026 03:24:17 +0000 (UTC)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011033.outbound.protection.outlook.com [40.107.208.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 50AD010E025
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Nov 2026 03:24:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qQOt6jUZiHUWBXJqGnQ5jqrtQtuPkXBOKcy8jfYWQDCKjiS7FShGTJZL4dIRZUDxXpE5cZRzDnZSrwPlVbirhmjcZ/mqE/ZbD4VRw9B0rRndAm/7L0aphTCs3SaxhaturUJS+6Ii4TN9y+DDjQJXFVzPihz9jHR3l5lXrrXA1agFNDZhxgwSqV+eR4tZWsUrcay7yPqSEBHBqTv6nEzbMmYjLqqjL3FzWgy7yYshsKK256MdrK4viJPVpp86sFwBt3u4oByUFvIrWAHT9ttEvO+rn1YiSKPdtSORYOgjKr4Os7di/JDewdU9V08fHpXFmLcONOWclHHwYjt5Hrz0iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E7qUZg1e6UuMcA7pz/xpIy/MHh36dbdkPCfL6w4VPtY=;
 b=Aqm6H4+B1M9hWR+AnsgKo2dz/mNIDWspsWlNwpN8EYWui7TQuBecE2SU/l4Xk5YFvlxd8gaQulwfQT4aSwnUy9tL0vYnYlZz+Qo215Pabvnj3M3+LXV0u61kiUE5MLmv4RLqxfWDIwItr+1jkhok3m0d4UySTQxCEdT5Yj+FTgc/3XlRAH8xQP7KSfUk6l2Zylb0m7v6NnQncyEglRP6X+yQ71pUrMSkjoyo81A0xU5LsohMeGQ7G0L6Q8b3d5p6UVEWf2qAiPXz6JpaNnthJi7J4fl7yISuNJpYqHg/C4mNDlDlXvM01RvbRBs8cXIM/lJI47r/ukX1PAWzxRfDFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E7qUZg1e6UuMcA7pz/xpIy/MHh36dbdkPCfL6w4VPtY=;
 b=PYst0cOpjg6Z5IekXePqrPc+LYWPNqaMAqbZFn8scBo5eaNmbQZ43MgMayxeizfVPhqmZA0tT6efvXEwSCJwADvM04BvxlxqeoRLyP4dX0Yb/4ebmaqT+Ik/t1Pmt9g2eTgDJ6Vm1PMuOLa5Ftgrb2SzZi5q3raQVMyEK1HousE=
Received: from BN1PR10CA0016.namprd10.prod.outlook.com (2603:10b6:408:e0::21)
 by LV5PR12MB9754.namprd12.prod.outlook.com (2603:10b6:408:305::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Mon, 16 Nov
 2026 03:23:08 +0000
Received: from BN3PEPF0000B374.namprd21.prod.outlook.com
 (2603:10b6:408:e0:cafe::22) by BN1PR10CA0016.outlook.office365.com
 (2603:10b6:408:e0::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13 via Frontend Transport; Mon,
 16 Nov 2026 03:23:08 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B374.mail.protection.outlook.com (10.167.243.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.0 via Frontend Transport; Mon, 16 Nov 2026 03:23:07 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Sun, 15 Nov
 2026 21:23:07 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Sun, 15 Nov
 2026 21:23:07 -0600
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Sun, 15 Nov 2026 21:23:05 -0600
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>, Lijo Lazar
 <lijo.lazar@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: look up the L2 trap handler mappings by GPU page
Date: Mon, 16 Nov 2026 11:22:58 +0800
Message-ID: <20261116032304.2023851-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.50.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B374:EE_|LV5PR12MB9754:EE_
X-MS-Office365-Filtering-Correlation-Id: 60a17378-7277-4446-d1de-08df4390ef22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|82310400026|36860700016|10067099003|56012099006|11063799006|261026121527099003|261026140227099003|261028144727099003|261022105027099003|261021123027099003|261021121427099003|261102123227099003|261009223027099003|18002099003;
X-Microsoft-Antispam-Message-Info: a99N+WcRhc5w3lb++XPYfn1MjSNlElHiJJpOTWXVmo268f+2X6hXS985cvyCtpjiNFTBKw9tt4cQHEfIKIX1/y/QpJI7tbwTHadYCwHy2757f3C3E0JRVbbjk6uVsy7kcIH9S1yP9lMi93S+LVB4mH523U7rt7ieALj2kEFeQ1eV5G3NNFt6NWz4reC79lZECMri+NBL1q5XX17BNsiirGL9QFoWAl3NuYZyfZUnfZBEo7TvjFJXw9w6J3tILKfAvJalYwNs/GT9R1NFh7VO80DN0YqHto2EymthQR4g8jgXfHClLvtXeBAY3iLiy6H8xZtlhgK4dUvM13/pcQlIsrcyYsleMX42T5qU9UPEDKDjASyqZbbR49nKpmfBTVpqsuUlWboNPcpLyXLbiR1tA5o25rvIqbADnD06LH0ADotEwUtiDz3CI/C/6hdlEPTRWmwpqoxqhcS4Z/wavyBYdSvUZg+QkDkPdrXSDiIzDSf0/cwE4fBGOwzbwqN5PaqgI++8pFDyP6f4aVWo6/v1y0laqSV4IPHWwCnQ8QPZrn/4o89MbuzvIhLxLpsB3SCciltEA7dv0blupgWLMu+agGpwlCH2oGhwox8bohFMxYnl3S51y0GBcmuXln7NkI7H6YMLh+aNlqjFuFfOTcGuRf/D8ige7f9S8WqCQ4oZfB0Vz2RdYrDeU+NdOU0viM0NC6R1lIYb7F7jgg+bc1YYUg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(82310400026)(36860700016)(10067099003)(56012099006)(11063799006)(261026121527099003)(261026140227099003)(261028144727099003)(261022105027099003)(261021123027099003)(261021121427099003)(261102123227099003)(261009223027099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ltD/Deq2k3sBz2KmaNFdbYDnRgs5qmMwwIU5aM/lwg1l6cdhAzapyMJlgLL69SNErbBaYQaQX8upHF7ZzVOL0bJABcXCz0RHOVsKHAfeKNpmLtGQVcoH+55hmr3ZHPRLl5Q/WIZfn8VHDrQG+yXR3pexXJ+cog6awwaL4K4ciiQ/yNkeIMu5mG8WZje4CnOXXo1cVVhWlKS9iT3YcrkJr0M+30MfKF8gFbfGdEpw/MZocMbcL9qrm3xfu5VWhd8MtwasVvdY2QHoCCOgbvKcrQEUyYntQFv/hP0GYG4w8TJgYeCpuAsaTZM5gH21sgnrotk3CoWZ1mVSgLcUrgeauFsKoUZRkGTOWn04Gwju7qJj1CMn6kwRi+FxXKcmRMVOp0a8CFcfIq4pR4Oo3ylZgeBUnaLoAmSJBuq6zp4cH97jhxHHn8XSeQ4scR6MsiQk
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 03:23:07.5897 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 60a17378-7277-4446-d1de-08df4390ef22
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B374.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV5PR12MB9754
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

amdgpu_trap_validate_user_addr() passes the byte address of the second
level TBA and TMA to amdgpu_vm_bo_lookup_mapping(), but the VM mappings
are indexed by GPU page number, like every other caller of it does and
like the range check right after it assumes. The lookup never finds the
mapping, so SET_L2_TRAP fails with -EINVAL for any valid TBA/TMA.

On navi48 with the VM ioctl SET_L2_TRAP added, the IGT slth-* tests map
the TBA at 0x100000000 and the lookup of 0x100000000 returns NULL, while
the mapping is at page 0x100000. With the page number the lookup finds
the mapping and slth-{gfx,comp}-kq-vgpr-proof, slth-gfx-umq-vgpr-proof
and slth-comp-kq-returnproof pass.

Look the mapping up by page number.

CC:Alexander.Deucher@amd.com
CC:Christian Koenig <christian.koenig@amd.com>
CC:Lijo Lazar <lijo.lazar@amd.com>
CC:Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

Fixes: 1a6f95d4a5d7 ("drm/amdgpu: Add second-level trap handler infrastructure")
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c
index 3660f94a0929..52e4d30e63fa 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c
@@ -622,17 +622,14 @@ static int amdgpu_trap_validate_user_addr(struct amdgpu_device *adev,
 	if (check_add_overflow(start, (u64)usr_addr->size - 1, &end))
 		return -EINVAL;
 
-	/*
-	 * amdgpu_vm_bo_lookup_mapping() expects a GPU VA,
-	 * not a page-shifted address.
-	 */
-	va_map = amdgpu_vm_bo_lookup_mapping(vm, start);
-	if (!va_map)
-		return -EINVAL;
-
 	addr = start >> AMDGPU_GPU_PAGE_SHIFT;
 	last = end >> AMDGPU_GPU_PAGE_SHIFT;
 
+	/* The VM mappings are indexed by GPU page number */
+	va_map = amdgpu_vm_bo_lookup_mapping(vm, addr);
+	if (!va_map)
+		return -EINVAL;
+
 	if (addr < va_map->start || last > va_map->last)
 		return -EINVAL;
 
-- 
2.50.1

