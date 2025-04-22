Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 705DEC369C2
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Apr 2025 13:24:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1147410E2C3;
	Tue, 22 Apr 2025 13:24:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xMTcn6HH";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2041.outbound.protection.outlook.com [40.107.244.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3ED3D10E2C3
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Apr 2025 13:24:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w1VUsxlfGXwvohy4zgJvCRzo9X8ArvPFfmSbTS/Ln+ssO2naMO7wV9ykLAUgHRNW6tDi7PXW6in+Cu82s7P+OjjRrLZom/UENJfWdW6nTwxpjzIlGrcUGHYKyTnsL2bqZGIO6wMTKyKyf9IRG82zY85WqiDiU3X00ogtE+1ebLSr9RPh2HSxUodC9yftmFGK8j9wJ7drUQVRCfAPOigpSDG9Df59pZgg2SQOFz5kvkOgxwgSgMh625cIs8PIvPtGL1TyvhqSvY5TA2yibMjdYp95C+tYGIZHB77VskEfcIlE/llD3TJh+YS7ly9Z0Ii96Qi9KPLA0jX8UqpzPt7A1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hHbxRF0kx2cAZrHTKY0S7Qg9nXEVbQ2jg++TfUMmAMU=;
 b=ZK/eaPVo364GE2HUjJ9zS4Drvi+gfNfxYAUzzy7Lao0Vr9O98166CROgpYfPfYkj1YyKiG6UM66RXSrSmHDFtz19YjaKE1axr3EQRxhKBXFxJrszcY4dlp88qZuTh+x3SkZAXaNB/uzmuqkn0fipuPnQUmkkgCNexr51KQ+flERwPFvfhd1lqx8yRt08vH5vpdA+PI1oO0zqBIhW/2ScB1o7tYit8ThtchqlA8Domhvc0zqeD0fPtEOL6rUi5jXnNklWNUm1L73dc5nltScIKi2ojR67kPQ8Yw4KCMboLBLe8llnytelLFSbFSeHIgeZmC1JRvL2O2H02HhU09udrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hHbxRF0kx2cAZrHTKY0S7Qg9nXEVbQ2jg++TfUMmAMU=;
 b=xMTcn6HHuGo2qNhxcVfyMYBkiW6N3vcfBJQDtlhKx/BZ8RxE1jlUx0l5lDUL454iSW17Isv+jbzDTIPjQj/VPMwzqb6C+He1fJToiZQTE5zHzmb0M118xkZkGtiAs1PzhjCXfig8RjhPJ036i0BGwCHsAE7bX4bLuVB/stA5ms8=
Received: from SJ0PR05CA0046.namprd05.prod.outlook.com (2603:10b6:a03:33f::21)
 by DS7PR12MB6288.namprd12.prod.outlook.com (2603:10b6:8:93::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.35; Tue, 22 Apr 2025 13:24:05 +0000
Received: from MWH0EPF000989E8.namprd02.prod.outlook.com
 (2603:10b6:a03:33f:cafe::bf) by SJ0PR05CA0046.outlook.office365.com
 (2603:10b6:a03:33f::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.10 via Frontend Transport; Tue,
 22 Apr 2025 13:24:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E8.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Tue, 22 Apr 2025 13:24:04 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 22 Apr
 2025 08:24:02 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>, Prike Liang
 <Prike.Liang@amd.com>
Subject: [PATCH 1/3] drm/amdgpu: add the evf attached gem obj resv dump
Date: Tue, 22 Apr 2025 21:23:51 +0800
Message-ID: <20250422132352.3988185-1-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E8:EE_|DS7PR12MB6288:EE_
X-MS-Office365-Filtering-Correlation-Id: 9608a898-6297-452d-d4d0-08dd81a0f43e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?BWmmLN3vREfViQ7yFlTdNhTXrRuwl66nc/NpwP1XI8Nry0lXi6Ria1Q0p2uQ?=
 =?us-ascii?Q?mk6V4FJEbq6oeytjBTKzfJ4qg4bMG9tEFb0iOpt2HtcBVKQhcvALsRb+n56Y?=
 =?us-ascii?Q?RNMyTuX8J7fEGjX/ibrNyQR3YR0jPKgNtGhfnV391KIOqU9rszIn8H9zXAWT?=
 =?us-ascii?Q?iPOPYI/7zYZYU2GS9FaBaEgXAyoVH+jzW8r+Xkcs9F8RkqkU1xjwCtxD1i3E?=
 =?us-ascii?Q?yqNiSngJsejWeH1UbJa6XC1ROrTxwwbDfmbnsfJM+7A4sBSSAtSN4UNe0HwA?=
 =?us-ascii?Q?AJX3gNJDolWqWNOK82dXOXfnKVX8R9hRC0r26dEw7E3j4S6Twh9SC5T2uQo5?=
 =?us-ascii?Q?XFdWSHCc+MUODKRioPE70CBc4ykE02PmUlHJ5nsXRVl9LuEDcK0vNojo4/dd?=
 =?us-ascii?Q?DvhDQ27ODBUq4DIVMOYGr1JE9pEPQjTg29WupedKh5/sksxL7Xqa7b1GHxUJ?=
 =?us-ascii?Q?Emi4wT2R8QjOSQeUCaP5ly1hcHHMz+mvb1bj+tmZTQOyi6qySX+9kctApIMS?=
 =?us-ascii?Q?3rO9h7PSvhM/pNAXeNWGud297CsoV+senWBpwVh81gt8auqB+y4I+mldjWTk?=
 =?us-ascii?Q?ZSNgOlWzS1c1YSdl6aO2ofuyBKSXwnayOEQ/BTzLglIYkLCe8ajFWsusqw6o?=
 =?us-ascii?Q?vdFv2eJGFe8RyM8UFFK68jJ/rVxXSY/lHGryindGmOz8nqdM0Ixsfl9+Ri/g?=
 =?us-ascii?Q?h1h+QvEMbTuycVuFHDa0Jgo+DlFCHyedvJE6bh3krLCDOqXvtVUeCzus5StZ?=
 =?us-ascii?Q?BVboKPsVY7UBWepwqP3pipGpsArTFX8XOT7rIT2gwaVPAn5S5fuFMTAywIS5?=
 =?us-ascii?Q?JjCRV461pbS+NysGgmDUr7z8anSfBFnjV7F/SeB69C/QhrqlNDyCwreVZixv?=
 =?us-ascii?Q?ZZt+7PSImI6/Cpei6Wmet7vrZcCob+QDh5adIX+SNaZGUBPLCzccHM0VbCMO?=
 =?us-ascii?Q?KK17RKZrVAgEbS0J9fYj3aPLZKVtT+VQNjAn5dMuWcEVsHr8UZc5gWTKLaMr?=
 =?us-ascii?Q?DX0smMcFosjFQY4Ez5ipRaW67bSpubyC9UVJZ7aygZJigaFgE61svFIXXXHL?=
 =?us-ascii?Q?SW2kZ1+kFsIQE9uKTCdrkmLMCh6XXSztSD6LHfefxqS/x5M7n8GZ0eNKqvDJ?=
 =?us-ascii?Q?Nyb3PswxPqoH23QT2VwxLdYExjYZ8ux8MTFsZAQu8UG3dIqhwY3ez5QpkPNO?=
 =?us-ascii?Q?Rw1BT7LrikMKbUmZWrIjhudrSumxNIsgLgasr0lemYKV2uKyKtSPvwoR+Z6K?=
 =?us-ascii?Q?GwFU225uG49dYaNWnhVLYqYh1JIW5f4R+NcdS/KpWdgpDHsf62KODWuXeTKR?=
 =?us-ascii?Q?udisEhv7nR2F4tEelfmUjf5bgLlsBQJl2fiO4ekko9QZrY+X1Q2ZNO1msO76?=
 =?us-ascii?Q?xvcOIW2upDARqRz2Kfdm57Tb30XnxKCwy4eCUd6aJzvjkJI3g/RE7KAmdIIC?=
 =?us-ascii?Q?UKtWpzr2vV1JMpmWq5Qyg7Vl5AYAijdERaaY1K7Y8PXT6wkbEE/YLwEPPWej?=
 =?us-ascii?Q?Po6pbHxgMzQVR8rFuV+gwVdoioZ17tt02aip?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2025 13:24:04.7358 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9608a898-6297-452d-d4d0-08dd81a0f43e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6288
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

This debug dump will help on debugging the evf attached gem obj fence
related issue.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index d09db052e282..1e73ce30d4d7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -1675,7 +1675,11 @@ u64 amdgpu_bo_print_info(int id, struct amdgpu_bo *bo, struct seq_file *m)
 	amdgpu_bo_print_flag(m, bo, VRAM_CONTIGUOUS);
 	amdgpu_bo_print_flag(m, bo, VM_ALWAYS_VALID);
 	amdgpu_bo_print_flag(m, bo, EXPLICIT_SYNC);
-
+	/* Add the gem obj resv fence dump*/
+	if (dma_resv_trylock(bo->tbo.base.resv)) {
+		dma_resv_describe(bo->tbo.base.resv, m);
+		dma_resv_unlock(bo->tbo.base.resv);
+	}
 	seq_puts(m, "\n");
 
 	return size;
-- 
2.34.1

