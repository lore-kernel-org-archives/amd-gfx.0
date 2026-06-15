Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70F73CD98E3
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Jun 2026 23:57:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C53AB10E784;
	Mon, 15 Jun 2026 23:57:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="u9FgWyWO";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012036.outbound.protection.outlook.com [52.101.43.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB86E10E77E
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Jun 2026 23:57:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jaX8aUCDLYoWpvZHoCPoTP24choYFuDO/lmuk1r7/EPUY+kfOAsogRBjZPXYOZvYtKPWdc+NZYz986Csz8C2yQdMEqjGuI2XhbNxhAZEJjziDx72Zp0NM1IzafWgbXyum9JKc6w6J6XK1bDrwdgAhIk5xfMA6sRdzyWDmcLKpNWx9Zwk8UHhswVbh/veqBsbvCQJx7Bk2JVTD0hAz3uSwaoLJhs8LXbdM5i5Ha/mZ+U/cyO8waCUTNo0z02wqxNf41Pfc3YK4is5M7PEOsuO1yzlMLm9XdfCT5586cwwGaQaLXqBqkDUgeqr4nc8hfc9RY9+MjdWwjoscAkSYZzqNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JZldUdj6VX8GdXfQzY1jBVM33A1KCkjkzPFO+hUv1lI=;
 b=Gl7r/1xgWZbR9VztmJqQquRlt02TV/eQ6U2pRnvSGoJUomz8AosX+cgyY0bjPOGuJ9dTDH8WxFy0fnJeCTKSB2JqcODKuixVHZwX8pYkPXGoJ9S0U2PoTbHk9sy0CGowBPwWM+8tT/16bYEo+5qA6uyAbXNncT3pEgknPsBs8ij3LPsvNtgXx8SEsZPvvtZ9N4MQ1/DErHS196Ni0u6Ge4FNcgAuzPULYjBBArZEKRNb5f78c9MoTJvoCMuHMbi61skR2TRE5TnCJwsjVBQDNmulXrHAJlC92t0k7WyIV9wsryD/9V9OITJ+nC8+AWxXVSpJD2RaUS1E+4VE33mDgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JZldUdj6VX8GdXfQzY1jBVM33A1KCkjkzPFO+hUv1lI=;
 b=u9FgWyWOoMMuBalbatga8350q3kMnM+onjfkvlDv/M7neK7tjbX77DzgiOhAO6e78X4EGHpdkrfmdTJIj301XuynummfOlBVru6OAliadQl183cVye43JVtUx6i9T7iu7D5sitDH/ZzMEkJ5RUKSsDrKmMlO0RONISC2tHqgEwY=
Received: from CH5P222CA0013.NAMP222.PROD.OUTLOOK.COM (2603:10b6:610:1ee::14)
 by DS7PR12MB6070.namprd12.prod.outlook.com (2603:10b6:8:9e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.15; Mon, 15 Jun
 2026 23:57:19 +0000
Received: from CH3PEPF00000009.namprd04.prod.outlook.com
 (2603:10b6:610:1ee:cafe::49) by CH5P222CA0013.outlook.office365.com
 (2603:10b6:610:1ee::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.18 via Frontend Transport; Mon,
 15 Jun 2026 23:57:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH3PEPF00000009.mail.protection.outlook.com (10.167.244.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Mon, 15 Jun 2026 23:57:19 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 15 Jun
 2026 18:57:15 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 15 Jun
 2026 18:57:15 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Mon, 15 Jun 2026 18:57:14 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 43/43] drm/amdgpu/gfx12.1: drop all BUG()s
Date: Mon, 15 Jun 2026 19:56:45 -0400
Message-ID: <20260615235645.737189-43-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260615235645.737189-1-alexander.deucher@amd.com>
References: <20260615235645.737189-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000009:EE_|DS7PR12MB6070:EE_
X-MS-Office365-Filtering-Correlation-Id: 1fe04023-dc7c-4f0e-ff7a-08decb39d5be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700016|82310400026|23010399003|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: nZuMB7zX+21Mk3exQaV26t/1fKJY62kDiaGxayWoUacjLx0UipVAOa6vrAg3DObG8RZN1dfbpqXCFf1aS5LAC/fK17jij9QvHhJQsalMn9j4nQyUvAHFy1S51Y4i/lk4EwiCyu55bRxgUx2CdaxGG6XJaQX3BvDFswPwG99OdND/Ma8wYGU5/7X2DMloJXxNjgOdTQl/Uou8pEkUN+Z2u44o+YLCxl/sUvTv9jdfBFFkepM4hEm+kls1lCan9IlGPm9qatVKUHHkAeteZkjIaUhVw7I1SGhKEEMO+nPYZwrVVuz0opxoklGs/4QbBQnf0qXcIi4xV5o5bj9nLt+YIdJa2RjUzatIjOwF0oEDM8kG6pjNQpuNBHTvVmsp5to4DgrfZfAmcbDqMvDDh8c3AP0FwvgASvQa1BNH0xy+KNVEy9RSbWxFUObeKOz3edBh4seP8JoZfp1MVDVJKir7xSUDOPajda8IRuPJa+6/S2ZJSNAWhw48ZoqxzUrM+IHz5CX8hMSzQEoptXQ6kbNWW283PU/5JuHlXwpUqVrCMN6VfkdAOBLlt1qnQxK7F2uPVrZbkojvWC1nnTtvnqoTShwCkW0eGDbzf8WmxqocoQdWjb+rrDhAZBHljvOOS3dUnroXYmZJzcQgEzlH9Oh+umP5Ky6sp+Lrk/+mYFa+G+ix0me7zcxOAqbu0CYrczsnneqpFwxliF3o90bZaSQr1WcnV+4kycjrWfgmt61MtZ0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700016)(82310400026)(23010399003)(18002099003)(22082099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Smh7mUnCIQAjy7saxmAzB18/sw7yaEzB3wXHoIpL7zEIh3E/gBq6c8BzC2PMGg5N7LHQcnrSwypJ3wgFTOXad2sJjAaKtNun+3ZgjzDgaGYnzYUFyB5dEt4knptsy3dua8Q1Q/1klrosqkQ0Ziuu9brg36yWnxLO3ojd16txLikZ5/2TLZ37SR1jo8GUA8R9NXbFdH5Kunx/+Y4l3ezS1QMGX9pJbO3e7nTORbmGS6OhWIYPIwrVo9bSl+0cKoh5ZeqWysxqolRrkyCCI0mkFvyrdtzow9Ju8mDVAw+3xGubX/2JNTVs5EZLuMb8RZ7NgDRHhsJk525YmQjeav1dCtN7loG6msn2V5Z+GIxPTP5GLON6sweHVmbw2H2bBdf05JyVuJf7kUNu3L6NRLIwwtNJmYvF/ahcdgJPhodlNZr695o1IVkwMtULizGkgXlX
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 23:57:19.2507 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fe04023-dc7c-4f0e-ff7a-08decb39d5be
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000009.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6070
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

There's no need to crash the kernel for these cases.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
index 4f090bb1f48c0..3a4c29dee0d90 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
@@ -770,8 +770,7 @@ static int gfx_v12_1_gpu_early_init(struct amdgpu_device *adev)
 		adev->gfx.config.sc_earlyz_tile_fifo_size = 0x4C0;
 		break;
 	default:
-		BUG();
-		break;
+		return -EINVAL;
 	}
 
 	return 0;
@@ -3387,13 +3386,16 @@ static u64 gfx_v12_1_ring_get_rptr_compute(struct amdgpu_ring *ring)
 
 static u64 gfx_v12_1_ring_get_wptr_compute(struct amdgpu_ring *ring)
 {
+	struct amdgpu_device *adev = ring->adev;
 	u64 wptr;
 
 	/* XXX check if swapping is necessary on BE */
-	if (ring->use_doorbell)
+	if (ring->use_doorbell) {
 		wptr = atomic64_read((atomic64_t *)ring->wptr_cpu_addr);
-	else
-		BUG();
+	} else {
+		dev_warn(adev->dev, "gfx_v12_1_ring_get_wptr_compute() requires doorbell!\n");
+		wptr = 0;
+	}
 	return wptr;
 }
 
@@ -3407,7 +3409,7 @@ static void gfx_v12_1_ring_set_wptr_compute(struct amdgpu_ring *ring)
 			     ring->wptr);
 		WDOORBELL64(ring->doorbell_index, ring->wptr);
 	} else {
-		BUG(); /* only DOORBELL method supported on gfx12 now */
+		dev_warn(adev->dev, "gfx_v12_1_ring_set_wptr_compute() requires doorbell!\n");
 	}
 }
 
-- 
2.54.0

