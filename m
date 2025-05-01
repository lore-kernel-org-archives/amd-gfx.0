Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8645EC369D9
	for <amd-gfx@archiver.kernel.org>; Thu,  1 May 2025 00:27:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 04CD810E157;
	Thu,  1 May 2025 00:27:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="aStdYz+D";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2059.outbound.protection.outlook.com [40.107.100.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 82C2910E157
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 May 2025 00:27:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sjRiShz/AqgfkW0qRFijt80cJ0a80RnK66mfKbs7ohTW+j3mByGUpK5CLXPdWcniYjNCN7cHPRt9hLoOXB5R8IPB4HgoyIQaP1R7n+2FTc8/ZUx79o622phxmcySDyKRmc8UR47pmNi9I/6ceDJuvE0S6B2F1S28NFLWylS+rIfKOLGJN2kyTNB3ZLY6tCAZ7redefxYjm+XMHKNk4vB/bSm2mgz6uSAGvelMK3/Nx97Vu8GiSlSgDLr0pCV+yp4LcU5kwFrqVdLEosTPRXr6ZZVesdZpeNUS66mks9XqWh3fkgqWai+ZLUBHYRy+x+eSMmkVN+5V/E4HLlR8TxRbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m6ROo624wY8EzvWKdBdN9KeJ/jkc+nJtuvaXcoo2avU=;
 b=e/LochuyZwbgIi3tYeN4Q4ruzp5z1O1/1gQo4VbgNsln5wftTdI2/AaGh3rUKLlNUlsfimh8mT/j+rpI0B7enxIxyZatPKemSeP1uIoZkMmaRizovnXI5Pt6Iy3v3vYz90cvaZGaHFWSOkKGxDppOKyKayg1zee5vdbJ0wctFvEvj7/k7TF573ALemCmrzChSTrkYTbhgFmKGYTdSapkrdSczZ1XUB3ImLiZXWcnFT7RwkcTxNm4aEf8pexIvyUbZCJv06IIAQAY8JQUiDps1oDBhfH77aPL2XWw16MM87ZhQ+hmFEVeB1OSTTIzdg2iq9PkOl2tnXj1ZpPgEtJbSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m6ROo624wY8EzvWKdBdN9KeJ/jkc+nJtuvaXcoo2avU=;
 b=aStdYz+DRMf8c9FmfFlT3taRaGm6Msb6l3S5ZxM/HLznOj1AC6TNQWTpsivIo/ILuAA5MUv27BuyIw49fDyWDtwwdtk/ruvG51uYBN/vBPe2RwQKVaBIEUBgJooiSzq3YnSd+VdA7rF3joFLMJS5YXgVUBj9YU7O1Ema11bB6gk=
Received: from BLAPR03CA0084.namprd03.prod.outlook.com (2603:10b6:208:329::29)
 by IA0PR12MB8376.namprd12.prod.outlook.com (2603:10b6:208:40b::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.19; Thu, 1 May
 2025 00:27:47 +0000
Received: from MN1PEPF0000ECD5.namprd02.prod.outlook.com
 (2603:10b6:208:329:cafe::af) by BLAPR03CA0084.outlook.office365.com
 (2603:10b6:208:329::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.36 via Frontend Transport; Thu,
 1 May 2025 00:27:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD5.mail.protection.outlook.com (10.167.242.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8699.20 via Frontend Transport; Thu, 1 May 2025 00:27:47 +0000
Received: from ruijing-dev0.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 30 Apr
 2025 19:27:46 -0500
From: Ruijing Dong <ruijing.dong@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Christian.Koenig@amd.com>
CC: <alexander.deucher@amd.com>, <leo.liu@amd.com>, <ruijing.dong@amd.com>
Subject: [PATCH] drm/amdgpu/vcn4.0.5: Fix GFX10_ADDR_CONFIG programming for
 vcn1.
Date: Wed, 30 Apr 2025 20:27:32 -0400
Message-ID: <20250501002732.1266299-1-ruijing.dong@amd.com>
X-Mailer: git-send-email 2.48.0.rc0.12.gaaf18a9a82
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD5:EE_|IA0PR12MB8376:EE_
X-MS-Office365-Filtering-Correlation-Id: bc13e2b4-6244-4327-12a4-08dd8846ff89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?kvxYxQEeiIOCJ50woHcQwqjH0CGi9nPw6JlL89flgH3UbI6Ha8Inrp2X5RV+?=
 =?us-ascii?Q?rH7L5dHq1+NgYTNLugDygUfzGoaccZsvwQrns5Ad+TYMYZSkMqerL7ucC+k7?=
 =?us-ascii?Q?PWHfUaYsPoY346nY7817KIeTeWRLhrGNjjIniALjWKMdKDfz5bEIlJCbFRBa?=
 =?us-ascii?Q?wsSfulRz7tHfAnnp0tj3qikDQV+c3eHggUkI/zHcd6MhAJa2gbsOqXnqVsUY?=
 =?us-ascii?Q?qchyloM6eTY0yEHDr0mGCvR012oW90q2l7zo9p3+3NUY+zkFBFjsHl4gupTs?=
 =?us-ascii?Q?x2+N/7REb7h6TOWrlvA8cnCaZWWYWVpSViLpd2UQn9ic50dWp3RlxTWM2kNy?=
 =?us-ascii?Q?b2SgQ+CdJlbOb6YmowQ2gZhBPXYPdXZI3lba74kjOFdkIdn36EtXFa74ytyI?=
 =?us-ascii?Q?Q4mizZDNj0FUbnYHLQp85RJdbf2zrguOZjvXFVjzdsMuseoYkqw+ka3iPnK9?=
 =?us-ascii?Q?bNRZjyRGMkgCiBmSqAS3q8kVN5ick/zZtdD2hHZK43ArCMjOGiGX7YI6WofK?=
 =?us-ascii?Q?XllL/LWTj9Ah4mbLqn4H7pQhyFC7vj3PNRK5dQSavcQgiTu8Qcljb+06NBnH?=
 =?us-ascii?Q?wFBTYgZQqbFEnFfSrTdYXAoWKm2jRTHj8zESken88Q8vuNbe7jklkeHpLUh5?=
 =?us-ascii?Q?PxcpPVGG8H69DeCXVV9hoMZEe2YDZTuJvdwJxn+dECQhFA8Ssx1svdXtz9Bo?=
 =?us-ascii?Q?cL7NHPtRP2oIZZDkxqKuAf7oTByjnHejb868Xz2CLVuIVOEMN1urY6Uw8LpF?=
 =?us-ascii?Q?8VJcb6soOjgkyo1xtK1d4VHWKGhYt1cS6TorF0d3WOcY/YbW70YxnaIjt905?=
 =?us-ascii?Q?8A8Rgel33FJKQMrJxKVOJjm3FtQVkHf4P8guCITC+8xUVNDIY87DXosKg1Gp?=
 =?us-ascii?Q?xNXo5JYQ+uf6wSXjRJ1NB/34LAOvTR4f0U7GhJqMHUcf3MJ1RmOqchUnHS7C?=
 =?us-ascii?Q?3DOyqp9Qnc90RJpfFPPL6jQ452zFk3Ptcsf5mXqapqsuLg4wME79dgCjFqYA?=
 =?us-ascii?Q?BdrhsP5tDEhIAH/mERhVvXtN1gOn+F4hgD+u62FNW5EPO2HrUirhp9651SGL?=
 =?us-ascii?Q?Z6/GWpUDNHwNMupxVjYjlMosrWbM2y4gnyRIL0YM2hBIl412/iAOB2EbOLzq?=
 =?us-ascii?Q?FA98EmZRtuYoDoGu9mqbGu3QAao9bDltd93CSj3FQQCfIi8T5eyHJSE4ppGv?=
 =?us-ascii?Q?NCm4Ru4YAuh6Zldw224YzGmFL1RWCx1ApU8Vs2NV+Ye+m8zSg4A89LFQPYWg?=
 =?us-ascii?Q?Ljy+PpjPwOean/Cxp3f5KuWqqf6az6pZrUcAqYwo3kwB7OmEnVaPszGWdmet?=
 =?us-ascii?Q?iRDNCPsukitaabvAwongCf9Q6N4aZPgcYPqW+vRWu9oPOaIfzNR7UYzsaJfT?=
 =?us-ascii?Q?kM2E1YiC2gekVG2u8z1FrecFMKg3It9LKLYIGoOImEF7XR7JbpJnn1ofSeni?=
 =?us-ascii?Q?VD1PUmxEHFR3s2BwLXkwfjijpbZoU6hZiRDBMZxUgqgkrXbeilKocQjUSkJE?=
 =?us-ascii?Q?FfXsFXoPjApiX0eCBmuiFjv3/MTDYs+yONjs?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2025 00:27:47.2298 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bc13e2b4-6244-4327-12a4-08dd8846ff89
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8376
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

The UVD_GFX10_ADDR_CONFIG's offset for vcn1 was programmed
incorrectly, which causes the corrupted output from VCN1.

This fixes the issue, copied from UVD_GFX10_ADDR_CONFIG
programming from other VCN generations.

Signed-off-by: Ruijing Dong <ruijing.dong@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
index a8cfc63713ad..31cb19e144fe 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
@@ -563,7 +563,7 @@ static void vcn_v4_0_5_mc_resume_dpg_mode(struct amdgpu_vcn_inst *vinst,
 
 	/* VCN global tiling registers */
 	WREG32_SOC15_DPG_MODE(inst_idx, SOC15_DPG_MODE_OFFSET(
-		VCN, inst_idx, regUVD_GFX10_ADDR_CONFIG),
+		VCN, 0, regUVD_GFX10_ADDR_CONFIG),
 		adev->gfx.config.gb_addr_config, 0, indirect);
 }
 
-- 
2.48.0.rc0.12.gaaf18a9a82

