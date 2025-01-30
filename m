Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7605CC0218D
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jan 2025 20:51:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 276D510E9CD;
	Thu, 30 Jan 2025 20:51:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sATQc1KD";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2078.outbound.protection.outlook.com [40.107.96.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C75C10E9C9
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jan 2025 20:51:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cYcSmkiHBl3rDhxPovlLEh43fChq2HxQDLDhAYJ7nK1/5SejeR1Ih27svE+AW9sNKw27p5hboftw816ythik5u8jrUPWphkXZ3bgwLM1Rp6h2U7e7mOvF3s4pbyiS+0aH23DiHjCR9X9mumU9AqpFHkAboJqCxEnDy1n0pKyM0tyK2bq8QSgpbuC44ORT277lRldNXrCkjo+J/RTPBSSJiHmcFwzb4OjU1S2gX2kuaEjFF0q/Scp/rIthzV/Ygt4hUaGW8KM2+FwHPGIINiqjedHoESH1WLWa3iPbkmH5DyFeiMt24MXfftjaXZUAT0xC08oD+ttsZYlTV1ePYWHsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JEoXScsc8tWnzuvYSDEFaZ5TOpeSYfrerqeLkPgnCtA=;
 b=bvHVQUq1MBXYUhpj39xhHIVaw+1Ac9Nbfl7FWpe8kd5dVfOicXbQ6e1MXGnU6w/TUYIJl0XfyTq24Pfai1xY5JFB644Um3ZQvUl4m+1LAD3lxGtwudTGFfd51HOXlc1i/sIfQM8wyiGDi2sjg/ASltMuzeHi65XSR/5DEZ/PFVZael/ybTQaufo39qsbYCWAGWsH8SHhll3aX+g+BP+WEfr++0ETzVdyw+CoswdiROU0vR8A4U8XSb8GyTfo+2nfEgC1GyqPQfhxi+ljeuZuP2DATG2Pezph3UIc6RRRkPCnDMmCEHsbpEQL+jYPFHXQogkUlwhl5sf9j7vki/boVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JEoXScsc8tWnzuvYSDEFaZ5TOpeSYfrerqeLkPgnCtA=;
 b=sATQc1KDsVBT0axb+RN0q7Y0Eijn5EX3ewP+OZSWWLfb9XE3ki8g6M/pa8hpc8jUL9BugfiDf/+1ubx2kGTEo0OcrYtJtVVypp49hy0TWrnQQLQdnWjBwfXJNp1QopndxLn9aPVfb8jS9v881smY/bYVlR0eFLM8IFtLQJsbNaA=
Received: from BN9P220CA0008.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:13e::13)
 by MN0PR12MB5881.namprd12.prod.outlook.com (2603:10b6:208:379::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.22; Thu, 30 Jan
 2025 20:51:31 +0000
Received: from BL6PEPF0001AB73.namprd02.prod.outlook.com
 (2603:10b6:408:13e:cafe::91) by BN9P220CA0008.outlook.office365.com
 (2603:10b6:408:13e::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.18 via Frontend Transport; Thu,
 30 Jan 2025 20:51:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB73.mail.protection.outlook.com (10.167.242.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Thu, 30 Jan 2025 20:51:31 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 30 Jan
 2025 14:51:26 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 2/2] drm/amdkfd: use GTT for VRAM on APUs only if GTT is larger
Date: Thu, 30 Jan 2025 15:51:10 -0500
Message-ID: <20250130205110.811511-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250130205110.811511-1-alexander.deucher@amd.com>
References: <20250130205110.811511-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB73:EE_|MN0PR12MB5881:EE_
X-MS-Office365-Filtering-Correlation-Id: e783359d-f85a-4010-ebe4-08dd416fe052
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?P/ez/kgE/xy+AvRlYlAQl2aMld7shTTFoScjHTSvCGnzLATVuDw4s9bPHeHk?=
 =?us-ascii?Q?PFcv+L3+Ns9PuCG9drRqoAmTglcBXUQzMIdZ9EyIj4ZGJ/L0vqBil08y0XIt?=
 =?us-ascii?Q?Gzgl8qws6QNufiMRFk0gPl0BwP0zU4jxlxTyFSQB7RSjtRSBlnqxYBpmuLpE?=
 =?us-ascii?Q?PwPNV+4Ldbp8OVNS/X7tANfBrZSTyObqtf/cvSCcV0nPRErTWtIJi9imks5l?=
 =?us-ascii?Q?3P5B3THHdyvOLJK4LsJdVoLPDd833sTM1dBRG7LKxCqMN8SCefzvOq9N8jqT?=
 =?us-ascii?Q?4AoUbxVLkuMnHWm1eAXL9tVkyTnoRjiN7muqbBc7i7UVoMcrFlr8l2MKu1gj?=
 =?us-ascii?Q?w9r1SrKKNgTk6vo7HFnIY6Y+fNgB1jf4koYSyCSYUeLkLBw+wD1VvGR2YpEM?=
 =?us-ascii?Q?xkVz4OufTn6x3PjBP9wlNEzuv//lTUj++eMIf6JbXD3FfWYStl8/gSFkpYjd?=
 =?us-ascii?Q?jkBt1foMNEdYS/57YTgvut2TIWfoNpo4wmUsN6F9bEAOjpSa5ikL4zSgEKpe?=
 =?us-ascii?Q?tKcR2XWhKYbdkNsLLVb4pFuNa3Ds5IFPtAarqKlcsS0bpDxnjxrVUna+QLxy?=
 =?us-ascii?Q?zyw3PCZhJgFV5y1FpXUAMoVq0eq4sJ2IbO8hR1hpuNaHdpgUVAJWiKdEVrym?=
 =?us-ascii?Q?OSBTHHzdVn2TiepdMwUkKzMxN4IxSJ9ibp3dOC/EMf5WygE9TdyHpa+xDGC+?=
 =?us-ascii?Q?LIGmmFuyBWv5W8ykHzqqwaB+iwljhECVgEbD8a7qsUcHCKE+dOQPTHp3KSIt?=
 =?us-ascii?Q?W4zBXuoeIIsGfTaWjKUVvMGgvseMtqQKfLqOja/+1MABndJkE1db/x7udJgA?=
 =?us-ascii?Q?CZqQ0l9Xj8kdLFryYd23fKbsSdCATCoM/c/PrGBRS6Kria3bLM2ZjzCO4Uox?=
 =?us-ascii?Q?N03iAoFvPSFlpuOnv6RQ7WiTsVrAXOJj9F0ZoVdMHQZSoyl1HPHU398KxURo?=
 =?us-ascii?Q?Bx6l0UzrDNUZ4pAUAYlOXtDEGxTU6Sxd6joF8f3fdRlt+mP4xUBliMfEG4yP?=
 =?us-ascii?Q?8rxW4XCe2XgHEFNZgVGbnC0l0nAHpMq0+PlqrB9VvvQYbeTdGnCOgRm6rsob?=
 =?us-ascii?Q?ZjsZYDK3Ju0UJQw6Q7PAo0YMahOC7qcvUeYU/M8MT6rlNSM+mu/kqsrJxf4V?=
 =?us-ascii?Q?QF4rWabOTY+MbnKR0AVhKdlkSGrkRNTZa/G3vZ8nn3vDMzIttfYgHMmubUnu?=
 =?us-ascii?Q?NnqbHJ/dV427p7qkB6tNkQCX6dsVSA7nN7fT6Cj3xSUoZszWYBVk3GxJVSOF?=
 =?us-ascii?Q?KKLVthNcgW0bWK5MJoViwAeANb3/Ez2KrcyOnvmIYodDwyIdN69hD9J9LIca?=
 =?us-ascii?Q?BPrv0M0yXIxlgwcnBAgkjZnBVFQrxwZsNflJx+GUdOv1ssmcIXIM68VjgeMp?=
 =?us-ascii?Q?nr92T+MAs+8qqJzAy4ucnMXYw+WKBlP81E0pc44Ktug0msdLJVTA4pGaBSER?=
 =?us-ascii?Q?m35ugxihGCRQI52U0wMPiQCXfH+37bTlIg6+3aBS6LN5J0RQmHQdSboCxDR4?=
 =?us-ascii?Q?vn/9vzNu+Kw/ULk=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2025 20:51:31.6403 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e783359d-f85a-4010-ebe4-08dd416fe052
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB73.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5881
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

If the user has configured a large carveout on a small APU,
only use GTT for VRAM allocations if GTT is larger than
VRAM.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 9d2a3e2ad9df5..96ec26946db60 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1985,8 +1985,10 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
 	DRM_INFO("amdgpu: %uM of GTT memory ready.\n",
 		 (unsigned int)(gtt_size / (1024 * 1024)));
 
-	if (adev->flags & AMD_IS_APU)
-		adev->apu_prefer_gtt = true;
+	if (adev->flags & AMD_IS_APU) {
+		if (adev->gmc.real_vram_size >= gtt_size)
+			adev->apu_prefer_gtt = true;
+	}
 
 	/* Initialize doorbell pool on PCI BAR */
 	r = amdgpu_ttm_init_on_chip(adev, AMDGPU_PL_DOORBELL, adev->doorbell.size / PAGE_SIZE);
-- 
2.48.1

