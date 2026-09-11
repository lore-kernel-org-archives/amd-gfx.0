Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1520C88E5C
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Sep 2026 17:56:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6DFF010F6B2;
	Fri, 11 Sep 2026 17:56:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qXh5o4Tk";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011041.outbound.protection.outlook.com [52.101.57.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1BC9B10F6AB
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Sep 2026 17:56:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v3KfXT3f1r44ucafhXLKLK1M69BeQCDQAIs6aaoddg8yxRTrnAopDviYEV9AMHy1Yh/k29D9zu8CyQfSx/7oMr+rKKFpmjWTwGLzGAq1yH8zvB/ay/QySU0JnF63v8brqHKrrbfp/oFBj+nQIMrTSR0ctIY99wleh0rnP59OfRbh96+bujBeNjEMmBqhdovHZVYmhhZ/5m2KC49MXI2I8cHEAsMSDGXpoLH1O2CwqIr60x6Tp4LodLng+u1GyUwJ/B6cwy8K+51qokjVYADBPOFJ45U87ePfAKpwDJgOHr4j9mLOWCC0af9VPf00vNXG1vStCcDamuvGHjkaDXO8DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5GOf7K5ruwIEg6PtfjvFwK6B7eOvZnTDeRUynMNSPlo=;
 b=EfZZySJCbYWFeHrsIG6bMtknTrCM4ZNML0v0cmbigzip1eZuokCj7Wqwv9JyD3pRdSZcDuAfTQCjbv/xjM19z/m2qUz33bttJ23O2gysMy7tZJCb9Z8kPnwNufSktnTH/UNplT1Z6KChVGEH4oeX6bn+DTsZdA+VYDE2KsMKh44I1rfQbmwjPoFE8jvXJlY5b9wns+saMZbsiWunPZ4ZGf1o6/Q+JSRMrD6TV74U6WZKZZ4uHgunQIFQJbcJtEx5TQv15lCVY8q9KHs0ltGM0XWWI20+SYr5FE3uM2meYpbnoPfgFA5UT+F4EleVQXztSz95FjDxn1IZCNYbvHAebw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5GOf7K5ruwIEg6PtfjvFwK6B7eOvZnTDeRUynMNSPlo=;
 b=qXh5o4TkVdlojGLWdLiEZNUFyINnv6LHA4LagIloam+DNauFtJadjU4sVq2xwCP4rUv2Z4ZjLvu9WggW783agLVjhiP8s5xs7+tpRl5dSP3Y8/lc8DxalhXJ/NLHUSLpY4QEcXgGnk6EIONS+Jpp8Ere2mrM8oLft55rZqpg/b0=
Received: from CH0PR03CA0190.namprd03.prod.outlook.com (2603:10b6:610:e4::15)
 by CY5PR12MB6058.namprd12.prod.outlook.com (2603:10b6:930:2d::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Fri, 11 Sep
 2026 17:56:20 +0000
Received: from BN2PEPF0000A7FF.namprd02.prod.outlook.com
 (2603:10b6:610:e4:cafe::56) by CH0PR03CA0190.outlook.office365.com
 (2603:10b6:610:e4::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.10 via Frontend Transport; Fri,
 11 Sep 2026 17:56:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF0000A7FF.mail.protection.outlook.com (10.167.245.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Fri, 11 Sep 2026 17:56:19 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 11 Sep
 2026 12:56:07 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Fri, 11 Sep 2026 12:56:07 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 23/23] drm/amdgpu/gmc12: use MES or SDMA for pasid TLB
 invalidation
Date: Fri, 11 Sep 2026 13:55:44 -0400
Message-ID: <20260911175544.1314467-24-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260911175544.1314467-1-alexander.deucher@amd.com>
References: <20260911175544.1314467-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A7FF:EE_|CY5PR12MB6058:EE_
X-MS-Office365-Filtering-Correlation-Id: 7222dd01-fdff-4a1c-7330-08df102dfc24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|1800799024|376014|23010399003|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: BV7e3etZA9FGj+mSAWdriW1uWlUdrifuCi8TraRr9guLidpdbhtgs+pqpHWUyqKKX4t44TSlhQC1sNV68n8Wrnq0jEfIcfQ1DRXWzsDG/NRNQkjqXjjz1WmpYvRaGjY1gHLU4L8srw77TrCt2rhRZW42Np6aCYASDMiKRdKpI94E+7EvWbtodP2yhuQaRCTZS0bTrZ9LwjqBjeHOw5xvKzMcJWEwr2d93sIZvxNq01lc3snu9iBgonMR/AHbBwKWqJuLVBsiG0EWsChvFZ3Csgw1QXNUKvvsYQRb/9Wap7AodlWPRI0ACa633shejdff91MYIdAt8uQlqcaNULjg+cr/aKLMfMadkAyHF7d2X0eDU4Xv2GawlTIi/NkILuDdJao4P9KMSL/UZtjJW+13OFbr3Am5a3aHFP/zD1eSP7oVa6THjPGWM6+cEFMelHyHN3jnqgb3QJ1IqFaUkGX8N34yT4oxxzIOA+31LNzN5X/PwKncJesnsx4Fe9o/k5JupuHhuTVRoqiQlt5z1lo0+2UgONYI3uIWaAjpztQwWoOxzoX1gr0Ig1p8d60c4bckPV7Wum132XntDRP1scUxzXpVLbba3nOZQkPOpmu0wH6ZjNHfsYOV/M4Rj1/JeWEzU40eZKRhDaocWy2wU5ddu/QB0LNQjTyKYnn4VwmeKCnqJL3AahVcq/ESytoEhjar
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(23010399003)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: A9EyQ2mVHXCIUOd8rBldUqa5d1x5l+0KyAz1mg0S22okowWyjSgT74tGlgq396aoli+i6ppx+qJxWJGdG4PyalcJi8Bwz9PLa9UoUcseo8urlEQpGFQfI+YNXDu/BXfg4P/r7mdoCf3C/tRkj61tW8j6opdR/QUGzzQdkj2u3dQrF0XLVLQpgoEoVXFdJ2BlRMnS+AzcZPdVLyKxYGwNlnvDH1Ozdf9yygUnycABpQqdSikkSABw9P72RBRuV2EShZgGeKFutchaWLmuCBakkMBuq3S7kK5qOgmKskzUY8xFI1uN3M+lRMbWkJfkwKORX/oAeh35jMlBXu5GcXX//L2QE0L9gsYvRaWgxC5oOf/nfg9coNCnLvGSGwPTpJYdxn+mjOYLc27PJFOC8XKjLcG24lNjoYe2czbOUcshYyZSQ2tDJHzrkYzJUoqCCdN1
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 17:56:19.9292 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7222dd01-fdff-4a1c-7330-08df102dfc24
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000A7FF.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6058
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

Use SDMA and or MES. No change in behavior on systems already using
MES firmware which supports the pasid invalidation packet.
This is recommended by the hubs team and aligns with what other
OSes do.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
index b5db3f966ba5b..d03f0653c30a5 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
@@ -850,6 +850,7 @@ static int gmc_v12_0_hw_init(struct amdgpu_ip_block *ip_block)
 	int r;
 	struct amdgpu_device *adev = ip_block->adev;
 
+	adev->gmc.pasid_inv_method = AMDGPU_TLB_INV_METHOD_SDMA;
 	adev->gmc.gart_inv_method = AMDGPU_TLB_INV_METHOD_SDMA;
 
 	/* The sequence of these two function calls matters.*/
-- 
2.55.0

