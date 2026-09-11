Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81BB7C88E58
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Sep 2026 17:56:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E36010F6B1;
	Fri, 11 Sep 2026 17:56:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pJyU0DI+";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011059.outbound.protection.outlook.com [40.107.208.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3DF5010F6AC
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Sep 2026 17:56:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S4b8kx68muBFpcFKiS4M5N/wd7JkDR1Fhr2XSOcfpd0YpaMG936g3kuH4klSRk+ozDmCjMKMkteqeJKDRrqtg5m6shgNwKGf8oJED04LoG74PtpVEAQjKBY/W5GJEkvkuPRbn0xrLNy0DGJaXD57CMBZca3REPzN6ZXQ3qkQRnF03J79aYBBRoU3Eqjn6OwxT+Dp0JXEeCPvkZ3MawdqjS9Mbi7eh1tjrQLHhaMgKy5vSQcb7+/H3DRhW3f5XQOYLWIfSfWNJFaRqUwf44IZw+IjQIJLUTJFYRinGro7ky2P+YNReyf2BjNEnzUUIpU/+HwVusZs8cmXOW+14K+24A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hQOh3BYlrARwvmTBxcUUxFFJUWgook1AVz4QnEggG0c=;
 b=r05VmMjJNvufyZAT5N3hQasRFtJIu0wrRRbNoBsFXCtZoIzJ11bwPfICThxCdSUMjNXb9+lWnH7KHhFQi86nMZjDp5vO2Uyv74CuXTNOld7zu5nfZxayEhApF9bEaJodWKS0ZI+ina17sC3+DzO6Aia/ud8AX4L3qYTfzW2PpTWTSbj8ykGjW5n001hcGrzK/g/Ukfm2Z2F+wbPayhQBXc48xuR9xp1e8laI8d7T54MfYFSZ62zOXli7q1HFBeplbtYFAfdA6C/ivpgCClmF+X8oW1hK7fEfv5f5CJrlJwzkDR4NM6ybxR7OQ5fmAbGvlNob6O4EYJFvWJ4ELk0PLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hQOh3BYlrARwvmTBxcUUxFFJUWgook1AVz4QnEggG0c=;
 b=pJyU0DI+1NKFJF9UYaGJFpj2igpigI60d3153/0tJ4gMDQMSLv/lRc7A6NTqMVpFmmyNlhRHij1pHpnaHURIwqf+6XbyvjwLdwwUD2+TUj4eeJHCy/FR86dekOHrCs1cb2z8OAO/ZY6WtDO+nxyyfzI/sxe2GDQdvDeku0Ayevg=
Received: from BN9PR03CA0162.namprd03.prod.outlook.com (2603:10b6:408:f4::17)
 by CY8PR12MB7611.namprd12.prod.outlook.com (2603:10b6:930:9b::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.10; Fri, 11 Sep
 2026 17:56:12 +0000
Received: from BN1PEPF00018071.namprd04.prod.outlook.com
 (2603:10b6:408:f4:cafe::51) by BN9PR03CA0162.outlook.office365.com
 (2603:10b6:408:f4::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.10 via Frontend Transport; Fri,
 11 Sep 2026 17:56:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00018071.mail.protection.outlook.com (10.167.245.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Fri, 11 Sep 2026 17:56:12 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 11 Sep
 2026 12:56:06 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Fri, 11 Sep 2026 12:56:06 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 22/23] drm/amdgpu/gmc11: use SDMA for pasid TLB invalidation
Date: Fri, 11 Sep 2026 13:55:43 -0400
Message-ID: <20260911175544.1314467-23-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260911175544.1314467-1-alexander.deucher@amd.com>
References: <20260911175544.1314467-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00018071:EE_|CY8PR12MB7611:EE_
X-MS-Office365-Filtering-Correlation-Id: a4925420-481d-4fa5-a400-08df102df787
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|376014|82310400026|1800799024|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: E8QG/b55lv2KqbH7JuDXa6UpWNOvqhGTDVvD+xoXNQbxG/9RQMGTZlGbzUmOnY2XQVTNdKQGtWgmws0TxUvdWobkZuyegWQmGkh8F6cQ+JyGbbeuph6Niv+qYvSM7wU1z7Og04NXkgaTMI3TKmjjHo8t3k7eVnVjk6cg+Sqo67WIyX6sfSiKCLzld1IloKVxmFglmgV99PYs0ti4SW0l7jDSDq1g+uXkphHmncEsY2O2F7lipfpgjkBnwFSjGhhDRxytDfnbfgUBP7mcD0i5X66B/LDOhKvC1DeUdSrBFiIuLbU6+wIFLBdNqy2DoCw9GC8v7I0tbe3Wf7+ildlWMIbuxWv0M4U/5eR6qsWs3hirM8/blUyaOwIgzUOiCPJqCmo4yY5O2Vhp8No7Bye/xQQFw+oNAPuFRW6pZePCrq8gOVdR+C/phjzY6Jw2h1bOeGkeFAfHO4Dkx0MsOuA+BXIgfxX9GtwCIb1vMYV6ilZXy/GCS2o2Z+3izSKQ6JWFqei5o3cSovuXx/qphtneBVJbooEu5ZaeV8MSiilAwo09qb29PYqF0Qt6xiw7xoIgFYUM5w+0hTLmlZZQ0BHtCLugeTOpquIe0vgMF3tWEZXBafL9O8V0vxDZhZLsKfcaDWU5o2CMbiCzUd18m1isa2l4hl/CFcqgOY28eDN4dzNZrssjumwE5eI4wKqnn8vcxi5fQaZtpD4do7wxdlVRgQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(376014)(82310400026)(1800799024)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: SWkBw4ID2Oun7/akC7XfCCU6OF0NsQyAEliiVi82gr53jXyNvcN2F//2lhLqft9tBwElmy+p39qQ7oST9JnHyNCXJJV7+kXPMQ2rDE0DtFVrPooD21jnYv0uQzr74kssMB2EIf3A41vXF2TodryZwrLNaJsyLa0VHmgiEZ9fBBGAVuuGv12jPo/ORnohmFUfNcwge3b26Lbwk5Zndcaj6R36tXVOuRmXrmb8t1mtLVP29ZJV5JA507Nl0HhCUABrbluz/IRzQrNbrZur1O+mO6zDEyaykyvPrrhIaJmsu/jX26EhRxu8QTLLg1qQ7CrZ/MQnkHhT5bRHZsWcrmKVlTrYAMefvXBaqAK2toWjN9yzbhTQtW2kFwkO9A1gpq2Rx6LBAWdz0srSHCuGYlgYesdwc72SZw9m6EE5tML8q4F4XTMu9UsPQhckc7h9famI
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 17:56:12.1879 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a4925420-481d-4fa5-a400-08df102df787
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00018071.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7611
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

Use SDMA rather than MES/MMIO.  This is recommended by
the hubs team and aligns with what other OSes do.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
index fa80132c8418e..d2a1825d3ce70 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -759,8 +759,7 @@ static int gmc_v11_0_hw_init(struct amdgpu_ip_block *ip_block)
 	int r;
 
 	adev->gmc.flush_pasid_uses_kiq = !amdgpu_emu_mode;
-	if (adev->gmc.flush_pasid_uses_kiq)
-		adev->gmc.pasid_inv_method = AMDGPU_TLB_INV_METHOD_KIQ;
+	adev->gmc.pasid_inv_method = AMDGPU_TLB_INV_METHOD_SDMA;
 	adev->gmc.gart_inv_method = AMDGPU_TLB_INV_METHOD_SDMA;
 
 	/* The sequence of these two function calls matters.*/
-- 
2.55.0

