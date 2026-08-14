Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AC9FC5DF77
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Aug 2026 21:03:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C28DB10F711;
	Fri, 14 Aug 2026 21:03:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="24eNqRVB";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012048.outbound.protection.outlook.com
 [40.107.200.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D48110F701
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Aug 2026 21:03:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DNfkjr1VG96PkVodq79KwxFT53XcKwMZR7KUb42cJ+M8fGdtRHhufbbQVPVgV32oiZanTUpD0Bo9oIPV5CQBlyjewzEIXNiDT3t2+TnasSJPOCPW+OkHrQl4me1F0pnZlzig7OS5B0QdjPNucvpIx01eGm0WEC4lQ+IlBrpTTk+cK0Sul39j1r0FH7hVa/0OBDEhvuNKIZu/PDm+n6LElxD/Ln/dgSmTcgKRz82VZThsYRhh/0ZTmpYpBF0QiKElfSbktGt3aasBxJ5tYcDt/GiiVN2ODOxqQvS7Utb3QffIm7g5i9AAzsz1gHjIH6UYfh5jyDIaw62UwbCOJe0BQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xkMXoGOfe9mGvRnj1q8/1D04Od4nQQjWa+y0oJIfaTQ=;
 b=ZYdxe7mqXQFIwv1OSlaEbZFqdcijoqvHn9AxttAlRh9V3QuPHuswBcnM13s69hTn4emWlQriNaJU1RTxBw1Av9ckJSyNBoatPmh2nDi9pOvjMe3GzQzMz4Yvlm/74ve+s6NwqNgv1tecQmA0LHidz25Dl3qutuX6GKi+qkzEYDCc0+PYyTnLoJ4T4H7zjm2u/OlE6t+1TS2An1Gl28XYRMehdxGf25PydsF3ClGYRjOFwMFxuNy2AWcnzgZ/3tfEgAkEZ0l8BDjRkpIjU9Zm3NBiQ2LEyrwUB9c9NB6HQeD1Thg9r+DCi00PXCnF84WKEiGat36WBNkdno3zt3mIgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xkMXoGOfe9mGvRnj1q8/1D04Od4nQQjWa+y0oJIfaTQ=;
 b=24eNqRVBKypkAVHkYPQK0ryLVMbCXIF2l2WnYER4SGPTiSIC65uD0DKmMVtqpHrFSjSFPBpBYiCI/DZR8aQjcuq+QAy/p8mpKmFh84hhT2rub1ewHImnO/Mwbx3R1wkYnqQftPMUTUkp3i2UcvExIFYw6TLtG+sBrRI4KwR5PlY=
Received: from BN9PR03CA0967.namprd03.prod.outlook.com (2603:10b6:408:109::12)
 by SJ5PPF000ACABD1.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::984) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.15; Fri, 14 Aug
 2026 21:03:34 +0000
Received: from BN2PEPF0000449D.namprd02.prod.outlook.com
 (2603:10b6:408:109:cafe::79) by BN9PR03CA0967.outlook.office365.com
 (2603:10b6:408:109::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.13 via Frontend Transport; Fri,
 14 Aug 2026 21:03:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF0000449D.mail.protection.outlook.com (10.167.243.148) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Fri, 14 Aug 2026 21:03:33 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 14 Aug
 2026 16:03:31 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 14 Aug
 2026 16:03:30 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 14 Aug 2026 16:03:29 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: YiPeng Chai <YiPeng.Chai@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 054/109] drm/amd/ras: Add null check to prevent null pointer
 exception
Date: Fri, 14 Aug 2026 17:01:51 -0400
Message-ID: <20260814210246.3067612-55-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260814210246.3067612-1-alexander.deucher@amd.com>
References: <20260814210246.3067612-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449D:EE_|SJ5PPF000ACABD1:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ce00f8f-4431-4c77-1920-08defa47805e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700016|23010399003|11063799006|56012099006|18002099003|22082099003|10067099003;
X-Microsoft-Antispam-Message-Info: EXlcCgIV2pWx5ye+4KQZL4YRV5DaQkGTFy6GXGUMZkGuPTD2DRuDzwicmK/bbL74dkqUKx3mIsrKRrl5quCt1u4RRVhUS+oTCOwZR6oCXFHzo38Gev/4TOF2303W5FFaaZtOw/Ryq121KGKcc++RC2aNip1lZcM2p6O3dcED9DHBL59zIhhJtUPnzCdEEj/+W/asehQWWsrvv95Opm+BDzA0M4kyn+zfhCgDLAH+vRSMH/Va4k3XzePB7bY77k6pRaYqecI/sgRKXy8uZnOW/y8U1aM8Yjjg5RhMlPqWFjqgpCzym53Tc3rji7RxmKQsnH2ASHADSdAawdOBLuHdNpWxhRPnP0iNLv3yKIUEH66LwGU6hjIcI49kzhG6gAl/XAKg16sTuHkTuhg72KjKMsssnZhtPVCqzIG2MEDnvrt0PC1+PdFkicCoWz86ebRi03idNlY4PU7/ai9g4ySoMJ9gSf+tRF29uf3tN6snMAqnkFi48uzZ8LJ+hTD099R110kH0R1A/ThG8w1r8H0Z2Fves0lITIfxz1EmbhCX0mlkuqDNi49s55edp4YhbdaROsezbMblZBbcdQNk+kagcm6NVahfh/b8ADiR5NlbEjVnMp9sPplKtF4k2sRuI562SsdUb0nZh2Ktp+URxLSvNWlTe0QZ+18JTdN0DHKj5YCp1EwBpTun9SvKOn07p3rRRYQyQdoSxCabfoHHzw9lHg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(23010399003)(11063799006)(56012099006)(18002099003)(22082099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: tP92ZPMOthdVxTe0Kcc+OMFEr8EeYNzzaAfZV7GhYv5gg6getswLSud1n+9bOHVEY4pOuj2/GW17u2g0jmmCIb3UVvsN7wbvgZK7i2K3rdoItyByEmDHUVU5i6zZzoYguIguCWNMOjESvTiZpC0nHIgAv1X/qGotHExOshxs/2nD78FQbnqtM3lC4B82/VOSayHg9XYghPPvb+hQ/W7Lgap6KNGXD2Rn+HI2dI8lcUEIplpaL/EpJsrH9cLFX6YgI5qtcEBOyta6nlqLrUSyTfX8BIRC+7C+3OagASPzWMKj1WoXITecCT+WyIo5+Cm5ibaSCk88hTdhGkuV795XuBJh1az5wpW3gOV1TfO6SsrYHzZUWuQ4UGOJgwasv085C5d9zFiucfCHq+CDcw9lCDcdzREHjQ31eCtIy0kxCLc2tFYK0/AiR7FW8+95VCe7
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 21:03:33.6038 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ce00f8f-4431-4c77-1920-08defa47805e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000449D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF000ACABD1
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

From: YiPeng Chai <YiPeng.Chai@amd.com>

Add null check to prevent null pointer exception.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c  | 20 ++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
index c08e573206bd2..128a9bc1f2f09 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
@@ -284,6 +284,9 @@ static int amdgpu_ras_mgr_sw_init(struct amdgpu_ip_block *ip_block)
 	struct amdgpu_ras_mgr *ras_mgr;
 	int ret = 0;
 
+	if (!con)
+		return 0;
+
 	/* Disabled by default */
 	con->uniras_enabled = false;
 
@@ -347,11 +350,12 @@ static int amdgpu_ras_mgr_sw_fini(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
 	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
-	struct amdgpu_ras_mgr *ras_mgr = (struct amdgpu_ras_mgr *)con->ras_mgr;
+	struct amdgpu_ras_mgr *ras_mgr;
 
-	if (!con->uniras_enabled)
+	if (!con || !con->uniras_enabled)
 		return 0;
 
+	ras_mgr = amdgpu_ras_mgr_get_context(adev);
 	if (!ras_mgr)
 		return 0;
 
@@ -374,12 +378,13 @@ static int amdgpu_ras_mgr_hw_init(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
 	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
-	struct amdgpu_ras_mgr *ras_mgr = amdgpu_ras_mgr_get_context(adev);
+	struct amdgpu_ras_mgr *ras_mgr;
 	int ret;
 
-	if (!con->uniras_enabled)
+	if (!con || !con->uniras_enabled)
 		return 0;
 
+	ras_mgr = amdgpu_ras_mgr_get_context(adev);
 	if (!ras_mgr || !ras_mgr->ras_core)
 		return -EINVAL;
 
@@ -407,11 +412,12 @@ static int amdgpu_ras_mgr_hw_fini(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
 	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
-	struct amdgpu_ras_mgr *ras_mgr = amdgpu_ras_mgr_get_context(adev);
+	struct amdgpu_ras_mgr *ras_mgr;
 
-	if (!con->uniras_enabled)
+	if (!con || !con->uniras_enabled)
 		return 0;
 
+	ras_mgr = amdgpu_ras_mgr_get_context(adev);
 	if (!ras_mgr || !ras_mgr->ras_core)
 		return -EINVAL;
 
@@ -748,7 +754,7 @@ int amdgpu_ras_mgr_early_init_service(struct amdgpu_device *adev)
 	struct amdgpu_ras_mgr *ras_mgr;
 	int ret;
 
-	if (!con->uniras_enabled)
+	if (!con || !con->uniras_enabled)
 		return 0;
 
 	ras_mgr = amdgpu_ras_mgr_get_context(adev);
-- 
2.55.0

