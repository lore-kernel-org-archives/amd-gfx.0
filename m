Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5A63CF34D0
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Nov 2025 15:06:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 037D710E659;
	Wed, 19 Nov 2025 15:06:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sykWE3e3";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011036.outbound.protection.outlook.com [52.101.62.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 85E4D10E656
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Nov 2025 15:06:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GogyhYD0x804iHWq1dcZrfcuYFUOenk6pMxJNjuHuMHHeaRc1KMI4jxlCuTn8chhouzTJ/ToXSELPtb00HiO0HARdQlueN9rv2DV/D2V2WU8jDRWNxTFsbqx4GzaqYylcjA34DIfcukOJ4ttidBZlIRlksQeJU/K9xOFlMDiL5vGkDQfMyjkQhA8IPn2jPkcBANFWaa3lEc7FVvhoIZyOJEuYzUeJJ47E4hL+oJJNWX8Obv3WiEqaXaloAabFTFj0p0FDOtM6Q3pYxCU/6HxM3uIM5NBLsUkin7Jgoj6ECwr6SjVuR1zyjUn9TIt4akByuI4AunRtXYd/BruNmSxjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sj6EaPJOWX7GOHmhb4YDdLV5iaSktcAlg9/dValXazw=;
 b=niL8LIHbX32RB31eDvnI/VeGCU+TuvNVA5mvR15X9krAQfQmtRCC9XwI4FTkp3fImsCUB1fEslT3JgX51wnrRCiKmRWmzCSZTIw0xRHP+RVuJuzw5lHSWhg63uu4yO6UYaDKrDKlTZ7qyQPR/SwzcyyCgVEDUKfFPFr1LpAAjUwzK6xMRTlDiaerrXv4K48DXSgi3fCh6oLtZUj0n1LEefuiiniRWd8SYI9Uk2Eb5yc4bfeL58t4twG+h9OULyQJ3uwPYHcRuadgoVlGd7gWis/4jql50hlVyyVVorf53ofH8mYmR5M6ZJke0cgg6r7a9MENTdWuyyaUvF/zpdLyWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sj6EaPJOWX7GOHmhb4YDdLV5iaSktcAlg9/dValXazw=;
 b=sykWE3e3OlS/OegTIvqHHhJFeGpE6yY+8Tq9KHLRwv2l3Q8iBXLrfjy+SFlObPsCUliJ4Jp+B2VgrSfy23m5Uj5KixPtFFWNmTQ7jRICdOjTAnyt4g6eezqaro+/23nbLlKYSSTZYh7Ah2V/jYaOgJ0gi7HLsLI8926/igI9rFo=
Received: from BN9PR03CA0739.namprd03.prod.outlook.com (2603:10b6:408:110::24)
 by CH3PR12MB8355.namprd12.prod.outlook.com (2603:10b6:610:131::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 15:06:18 +0000
Received: from BN2PEPF00004FBD.namprd04.prod.outlook.com
 (2603:10b6:408:110:cafe::56) by BN9PR03CA0739.outlook.office365.com
 (2603:10b6:408:110::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.10 via Frontend Transport; Wed,
 19 Nov 2025 15:06:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF00004FBD.mail.protection.outlook.com (10.167.243.183) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Wed, 19 Nov 2025 15:06:17 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 19 Nov
 2025 07:06:16 -0800
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mukul Joshi <mukul.joshi@amd.com>, Alex Sierra <alex.sierra@amd.com>,
 "Alex Deucher" <alexander.deucher@amd.com>
Subject: [PATCH 5/7] drm/amdgpu: Enable PDE.C usage on GFX 12.1
Date: Wed, 19 Nov 2025 10:05:58 -0500
Message-ID: <20251119150600.3663611-6-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251119150600.3663611-1-alexander.deucher@amd.com>
References: <20251119150600.3663611-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBD:EE_|CH3PR12MB8355:EE_
X-MS-Office365-Filtering-Correlation-Id: f6a3cd47-944e-43e1-8418-08de277d3105
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?j+V4/JLOS93Z5P+GVgmGkxAyaagtJZ5cQ5VhhIawOHQbbRRR+axMX80f6mGe?=
 =?us-ascii?Q?gIlEw5CmSnUGFjx9g8S6q/zoE067qLdV9LrvXifFbN9V854TV9KDBzW35Lbw?=
 =?us-ascii?Q?EeK/r+OccGgaE5OhEPrzmJ+nuFNRWWDKczWX6gSGOPq6Sz4D8++hIwF/5kcq?=
 =?us-ascii?Q?JLrcOKw15aRubNZOnDGtlgF6iCxUY9DADkCd786QuCF/IkJCChtXF+vc6OBk?=
 =?us-ascii?Q?zhsbSRFmvv3xjaurvTr6psZytImPsyr2qGID0LGU2fDG+/+92SZ05XQ2DuMi?=
 =?us-ascii?Q?gh2KQJ/hwDpAqBzH4WMsCpP1XYztz6F7b7SfrYgOXUR9fwYVTN4NX4xdxgCy?=
 =?us-ascii?Q?qdth3M6avFiwm6vVP7w50zjaAIwvE550D1wjpcELdqD+rXAkw1inzVFaPpD7?=
 =?us-ascii?Q?VMidB8AsJrAkrXeNnHL9+QjGoLZ7sQj7yd8UZH+jZTeQ5ILXu75h1E+ldz3B?=
 =?us-ascii?Q?gBqKkmXWDhpYSVUBT+NG/9vSRyCQY2SbdZiAiCKGJny6nqZJ0Z14vFoe3/wb?=
 =?us-ascii?Q?r+qvh5AftIM2GgVvk+UcXf49iMlFKmjTrW4XIXI8lUkpUxDyoprMLm3E0jCP?=
 =?us-ascii?Q?RjM8P90A2iazNKCU49TiJdawU7h3w7MYJy/4cB0KG97Ak4A838QE7jMrW7k8?=
 =?us-ascii?Q?bCu2lGIINPGyXHCjyiQ6HWFY6Mn6K4kRnif5w9xF88Jum3Aq6kSQ+0Ihx3Do?=
 =?us-ascii?Q?0ipCHnf4KZMnjPgeJZNpcsbVqllG8GTE/d6wrEBi78eT+9IfywBF1JByffX5?=
 =?us-ascii?Q?F2tgAOmfGZzzLDuGsA1ifFkvGXPbHi6I1sb1VIMgZwTHHk/xA7JppcJ+LFk0?=
 =?us-ascii?Q?z9ZH/XFNWn+gZQ3SyTSL0TJGp0EpNaqcPje1EjmDAIljKEFfnVGdiR6whPt8?=
 =?us-ascii?Q?+BwMJwwLULT8auuRzlAm/zgZBIUoDxOTqt88rHpI9cpzhCHOf0h9hYT7x96R?=
 =?us-ascii?Q?dzRRRrhzcoLggQh2VgJHA6OdlFpPbhVo4T/s+zqf+INwPp5lo9qdyZPCKewi?=
 =?us-ascii?Q?XH96pNC+qjTtr1aJVDYp32vn9Fn0JxuvamUmxe0qXDRAChwkzNNjk0r/vr1Z?=
 =?us-ascii?Q?VLAUDs3Wzcuerg9vOjEyRmQPYHM0+BTsFSk88THYUyhXqDkVfuLBIQA5NNAH?=
 =?us-ascii?Q?a6lr3rPbq7BtyGAfOwIcAv3Hs6XIohL0UqZgCPRCmzqY+KQgpVK26QVtjVRI?=
 =?us-ascii?Q?IVgX9Lc7CXr3f5xdC1U9VRP52jomiFe9661lGRyQ9IVHC3gThIFLhy3+KxLY?=
 =?us-ascii?Q?2Pvi9Ce7My5smRRtSleUo9p2ZcF7akWT6RRBrOECMcc1M2o3ycWM4sBmh/Kz?=
 =?us-ascii?Q?VOB8YuWXSjikGJYlTwIKIdMuidUqyLP6+tY2i5To8qBFOfEvZ/xt1AHba9N3?=
 =?us-ascii?Q?bV9N2t1k3hUTc3NkFmAKUaM+qFlEPfLInqxrpzuGFPv/ShrJW0tf8xMIu9Cn?=
 =?us-ascii?Q?PkntDFusk/w8hWcRYzSlxQAB7dsi5hidscBOSaOn361nJdSjjK1mR5Ai2GQ/?=
 =?us-ascii?Q?FAHh7tB44fwRNBwnk+TWXr4HiFkKWDFzV3RePUcsHCgeQAISCeEheocPLLkW?=
 =?us-ascii?Q?rx5a2fjlqYEMQwVhTRs=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 15:06:17.9585 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f6a3cd47-944e-43e1-8418-08de277d3105
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FBD.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8355
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

From: Mukul Joshi <mukul.joshi@amd.com>

On GFX 12.1, PDE.C is ignored if (PDE|PTE)_REQUEST_PHYSICAL
is not setup in the GCVM control register. Always set this
field to enable PDE.C usage.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
Reviewed-by: Alex Sierra <alex.sierra@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c
index 8ec0a14d3203b..4c59da7f2ccb1 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c
@@ -322,18 +322,10 @@ static void gfxhub_v12_1_xcc_init_cache_regs(struct amdgpu_device *adev,
 		WREG32_SOC15_RLC(GC, GET_INST(GC, i), regGCVM_L2_CNTL3, tmp);
 
 		tmp = regGCVM_L2_CNTL4_DEFAULT;
-		/* For AMD APP APUs setup WC memory */
-		if (adev->gmc.xgmi.connected_to_cpu || adev->gmc.is_app_apu) {
-			tmp = REG_SET_FIELD(tmp, GCVM_L2_CNTL4,
-					    VMC_TAP_PDE_REQUEST_PHYSICAL, 1);
-			tmp = REG_SET_FIELD(tmp, GCVM_L2_CNTL4,
-					    VMC_TAP_PTE_REQUEST_PHYSICAL, 1);
-		} else {
-			tmp = REG_SET_FIELD(tmp, GCVM_L2_CNTL4,
-					    VMC_TAP_PDE_REQUEST_PHYSICAL, 0);
-			tmp = REG_SET_FIELD(tmp, GCVM_L2_CNTL4,
-					    VMC_TAP_PTE_REQUEST_PHYSICAL, 0);
-		}
+		tmp = REG_SET_FIELD(tmp, GCVM_L2_CNTL4,
+				    VMC_TAP_PDE_REQUEST_PHYSICAL, 1);
+		tmp = REG_SET_FIELD(tmp, GCVM_L2_CNTL4,
+				    VMC_TAP_PTE_REQUEST_PHYSICAL, 1);
 		WREG32_SOC15_RLC(GC, GET_INST(GC, i), regGCVM_L2_CNTL4, tmp);
 
 		tmp = regGCVM_L2_CNTL5_DEFAULT;
-- 
2.51.1

