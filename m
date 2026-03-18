Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 116A0103E17A
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Mar 2026 14:12:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB45B10E840;
	Wed, 18 Mar 2026 14:12:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="q+8U3H6m";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010048.outbound.protection.outlook.com [52.101.61.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C69710E83D
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Mar 2026 14:11:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JIc3YJ482PtsSkcYGLVTR2dggE7x2a/41kfbohteCafoGFtZTBjOv2G6EkMBtWZjlFpFp8S+LkT7Y8L67qtaErkdVEVfx5iiOsj/nET4KT+74LVVKBe9Go9YshOC1E1xrAK0mvl/KRifweCea5IBiKXwswGpRvgxgjSCnApGh2zZMZtA5QYh1rvFloMzI/SPpWKZKzon+xB6OZwqY1jxwXQ8siafE68HNvjrI1BzFJRDbdhmAEut2j+stJN41sEpIDacGm5TWaYeYWC8AmIECZ4VOgIvpXfy3r2Sy16Sm9vV1tx/jw56L6xitoT24yw69BDViiFQm+plyf0Iav+/1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TmNy+qh4Gs9dQWeSR+0V/jxmNEfdVr1DivRiMTvwSCw=;
 b=KZVMoG/VmUkx0y1pzvwXf2rd+wVGEJ7NPom0lZ550g/eDH0gSlH/7eRQIKbRTnhPTcvfO8U4/7sBy8N1vnBJz8/KXGggrlvz3ah8njlXKfKo8aM4HMccgl0upEFDeeI0pdSlj46anHrfntyHWXEX26YndQRB5hvrbrj/NrQS0M1p0Yhi00AgHzT5i9C39/88Os5AJvdGAUQQYX37Bh47Zn83+daPA7XmuY/c2bgzkIGsw5GLTIf36z0HcAdaN7kkbK5fzsXXHoVtJwdspd4otjuGgwToFIXrr4N5nmDo6gAYlOzfXGVQHB7H3OqFk+7oVysQfxjvDMraYdL/moRssw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TmNy+qh4Gs9dQWeSR+0V/jxmNEfdVr1DivRiMTvwSCw=;
 b=q+8U3H6mnHQJNI4nia9pwDekpwejhfMwWLOXEY+tWsOfGN/y5O01zPcyfrboiP5St43B1O4o6xTczeY46IoKhXdbNMhJli/HlikLKNbEXIPQXCwqEPFCVpZmvYnWbmdDLu60Aj9kWf+9cxZlFL7rg3xtb/oNphdfNg6p7yxIZTE=
Received: from BYAPR07CA0039.namprd07.prod.outlook.com (2603:10b6:a03:60::16)
 by MW6PR12MB8997.namprd12.prod.outlook.com (2603:10b6:303:23e::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.16; Wed, 18 Mar
 2026 14:11:49 +0000
Received: from CO1PEPF00012E65.namprd05.prod.outlook.com
 (2603:10b6:a03:60:cafe::48) by BYAPR07CA0039.outlook.office365.com
 (2603:10b6:a03:60::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.27 via Frontend Transport; Wed,
 18 Mar 2026 14:11:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CO1PEPF00012E65.mail.protection.outlook.com (10.167.249.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Wed, 18 Mar 2026 14:11:49 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 18 Mar
 2026 09:11:45 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 18 Mar
 2026 07:11:45 -0700
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 18 Mar 2026 09:11:44 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 9/9] drm/amdgpu/sdma_6.0: set SEM_WAIT_FAIL_TIMER_CNTL to a
 non-0 value
Date: Wed, 18 Mar 2026 10:11:29 -0400
Message-ID: <20260318141129.583333-9-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260318141129.583333-1-alexander.deucher@amd.com>
References: <20260318141129.583333-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E65:EE_|MW6PR12MB8997:EE_
X-MS-Office365-Filtering-Correlation-Id: f6accfc8-3169-4849-bb38-08de84f84bff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|1800799024|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: CsPVOywdjx8OIQ/vE2HBlhZjIJLFQQZI9cpQgM6OTqsZIUB/4ZEwPweiPRovKunWCmMrKWcyilE5sEfRVlkZjYEunqlmLg+0cfl2IsNcgfY1zlGiOoWVvyJYiQCX/SelHtC+kF/5JBvZ5LYeTA4R/SKqsaORubbCFF+v9mhi8bJVc1mLDc6tgBMo/9mIpDO6W97fhg3BERUnvJRUtni4X9/osDNvojh7n7dnyvzgq9FlaM1BDFPy+BqQUk1l6KC6Crk7EMNtLBmJkuNEoWjuD/z9UgijrJtgYFkLYHEnP3Z66/NErHtwN+1HUUDgVbX7z1d38+bWdhQkon+zupzMKzI9NS355MxRLZYHokcjMdueb/Is792BvaKOL3R7p444oZDJXs4pEsVm6LRzXwn592qZlbsIyaz4BF6hfrxwvR7Q2WEVYdXe4+9ffBHjCJp8ccrl13U83b2VTox8t3ZIB4uZZ07bBMLno4QQLNaV0+7rDFcCKTMw8Vjr0nfYMOvNYqrF1ygMLU/gCreoRZ+Hra9wDASzSke1K4AoZ2olismNHZtcrXs7FdvKe3X/2nEGIAnseMeje1Ddpn0G/iiFxtEvPrbhKGUAp+xSPt9ehdRvJz326EDX2uQ60Nq2TMHucRLa4uE/lLgAGzdTXVZk8ha+l/pbl1qNyR/EEBIsq/5ySjgo8/Bj26Cqca2FKGvJGRsXdVuftYert1x3It/aw81DFvWh9vfBggbbL/vKYQSa/XsUrykYRHuquSDea1ZSBjEdlyZn3lo7cdFJLHMOdg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ipcPIv6NyluRxwiNiLFSavrwb4TQ6OHO+6WNR/CU4T23gH08IoNW+h8OFLGS79amnNn+drk5epR+OdvA11MG5mGmes7j7/+ptt9xJ9VLjihhRiDsYO/f+rsRX7vY2+JF+G0qW6gT8G7uD8FP1DkOmRi2uo2nrjnhcmo/hCK3YHHZQ0iLy/xNJQVKdDTcU4QNc76IoGZXzAOfypfVXdUf6kv7/18U0ByiHSVbzzCyvEaCAqrPE78SpJU+RbThT6eDPkyMypYdjxwHRz9GBjOhRWBRGsmG9w4WHNrr5R70jSDWZEGLJ8JUjmosa/41DYTI0PvHwE95LfX3OJEJ+8CYghMuSLYEDueqW3oVT0sj1SoUxRkHokq5g2ZP52LzURGUaDJbUQAiwX22MXFYTava40l7hVtdUGl2QOHDzTpE6Zv+Jah94In41GgFUJwrVr6p
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 14:11:49.3582 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f6accfc8-3169-4849-bb38-08de84f84bff
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00012E65.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8997
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

0 waits forever.  We don't actually use the HW semaphore anymore,
but if someone uses the packet, set a time out value so we
eventually time out and avoid a potential queue or GPU reset.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
index 3af5bf0f18426..60f897125c4c8 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
@@ -491,7 +491,7 @@ static int sdma_v6_0_gfx_resume_instance(struct amdgpu_device *adev, int i, bool
 
 	ring = &adev->sdma.instance[i].ring;
 	if (!amdgpu_sriov_vf(adev))
-		WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, regSDMA0_SEM_WAIT_FAIL_TIMER_CNTL), 0);
+		WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, regSDMA0_SEM_WAIT_FAIL_TIMER_CNTL), 10);
 
 	/* Set ring buffer size in dwords */
 	rb_bufsz = order_base_2(ring->ring_size / 4);
-- 
2.53.0

