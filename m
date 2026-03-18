Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7482107BCF4
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Mar 2026 10:46:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7500E10E7BD;
	Wed, 18 Mar 2026 10:46:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sX9gc7eb";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012054.outbound.protection.outlook.com [52.101.43.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D77E810E7C1
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Mar 2026 10:46:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AS+LRQDszB+c6QVNbsunrdPG68LKmomZZMWyPd8Sshw6rxqPeSlCR6N3hQykWFtnIFsVVAzMZoPe4/NVJDMv9ygzWvmRvo0sC0VwQl4taLlpSgAK7ppctLlUaOyn/7Eeo9qB4hZ2n4d6Myy18dFin4H7rkWxyqPFHbXrrlGX0nDFhtjuHajTW4CmResLba2LK3oKgF66e/4wKjYhZ/OYc/fEQo7oLZxAChA0Kehg41Y2HnUe4CjK7ALklxs7p62W3dKvNrcYyBQBGu2/Ptrh1UcFm+fHrr+BIN4Uir+8YqvPockrdGyqNjlzvK0tdSdrOmBssLHCrsQlzqI0kqjkwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eMO6PGrLs1dWjIgD70OJyIiEQFOxzZHMp3BmrGJwh5M=;
 b=o3zKvAu8wPyOCcgNqboCeXHBGupp24Q3kCkNS5A15fXjSBUuTJtEcgn1z8GBkvYesPGshuauTdu8ZCNfWRnjEpkE7iTreTqoq5ikhWEC73FzcvJAah+C9ZuSM7NzMxtmIyZA2iTcBOleTqdghL2qsNYUWAQlVesUqIMV7IR4gyHUAsKYxz9ms5xmuqbaQMA7fVz7gumgA9Sz3URNw+4+6hCWPpam1NMQxSieXS3XU6Rs3PhgnxYtBUm7Mz8RrBmHarRydT5B+t1EIoUVqQNJb4X/KfhaHuX/FJxhHWaUebi6NlNf8mQyUdTu7PkVmKRbHDVZnnfrSuIobUxadIrOSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eMO6PGrLs1dWjIgD70OJyIiEQFOxzZHMp3BmrGJwh5M=;
 b=sX9gc7ebYacYr+BBuqnVyc98BtnbpNTWaZaQRDk9n8X36nj0xh0Le9grz3/R1uvIdEdEOya+9t3/rGSTXNb1ygB3kpyL4MtgJRJ3yQMk9BgPTvL4s8WktpZ4CLdZ87FTj3gV8SDH8TK43SZK1erbEh8sqxLtyGMi2uVXt6fOrDI=
Received: from SJ0PR03CA0100.namprd03.prod.outlook.com (2603:10b6:a03:333::15)
 by CH1PPF2C6B99E0C.namprd12.prod.outlook.com
 (2603:10b6:61f:fc00::609) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.8; Wed, 18 Mar
 2026 10:46:50 +0000
Received: from BY1PEPF0001AE1A.namprd04.prod.outlook.com
 (2603:10b6:a03:333:cafe::1) by SJ0PR03CA0100.outlook.office365.com
 (2603:10b6:a03:333::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.27 via Frontend Transport; Wed,
 18 Mar 2026 10:46:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BY1PEPF0001AE1A.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Wed, 18 Mar 2026 10:46:49 +0000
Received: from gangliang-mlse-vm.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 18 Mar 2026 05:46:47 -0500
From: Gangliang Xie <ganglxie@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <tao.zhou1@amd.com>, Gangliang Xie
 <ganglxie@amd.com>
Subject: [PATCH] drm/amdgpu: add support to query vram info from firmware
Date: Wed, 18 Mar 2026 18:46:09 +0800
Message-ID: <20260318104609.1739924-1-ganglxie@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE1A:EE_|CH1PPF2C6B99E0C:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b9b4697-f0bf-4c13-658d-08de84dba8d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|376014|82310400026|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: t9GjnMaLBOkfD2OBeNQybJ9rFNPR22+kcC0N36Hjazk6ZqbgEcxp9cbjUsD/O2dZqYQGK9u0x2C51TE76VD+GsUko9O3D4HWWLd+dth20FFxrNQ06Bpmb3YIffLPQQlfZ9gtfpQ4bTd8cdbKw0P3KkwwX09w5hUBJwB8k+TCVWMI59p0v4wA3StZK6xS12SWqD39oL+3qiOasPlt+wvKnLe1bL4RnKjGps1ezEb8VciwfbxWR3r5tcBSfWsse4CzeBW3kQ6qbxZ7LEQTzslNsuAH1rb/9oCMO/jvldwues9KLWTRmo33qq7jcooP1RvL4F2af7FXhLvYUgju8jTfneVrTWWqKz0fk6ol1NYciH1J+KpMM6qxVOKNO3i3DHotPdy/hNDg5lTLz1eTcdCbHynnYqybFLrn6VbQ8nLazIbkIYp1hTRJQN63y/QjtV7LBCpATPkjrtuk3XtD9M3m0s6yDcPlUuhn2Qkvd8MRxRGCIfPV+rtNfqMvBwZmHZEbdJNlKeFP2OlA7rvlKsqfN3MMlhAovgzcoM6GcFTvFKKqj385CNMpixFteEAnGSOHixSEctZAJo8AWbOJi9jHkwelVqSEIzKle1iHILBLbPNDjbSTwkDJcPYhXp3uBS2WtdWiZ3TV9EI10NevH5Z9bz/OSHCRChr//BSSmrVHjXKwKLUL5Nza44fsW1Q5kVcl3eevw+ntY1dH5997Gi/4d0VEsgtkw3NHP4bbTBulevDaOY5peAS/BdtxF+8gOFQAn0gtiEZfUOJliIDsRc2vDA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: lDjuZWrLpMBjHVPssXRLeGxUEFC9Cq6w6EYQG+XvsNmkg4TkblEP6x5PhvQxtF4fxnaxZmy/y9ypMXrzdIDw+02xPNiZtYuC5TljQv37dOIQRTyQ46Sz6zWdOKLYlv5bdw2x4NWZu8nZ5SO6eJLfU48NOU/Xzbv6rKB7uIin0lnFkuoaa9e/3ywJflozFo6tpCRswtwsg/m8ffUtZnczOOQhYLmYEjnchcattcw0BxtbCyef0irxfM4kwwPzz2/Rmi8K4jo9b/NZrNq6RryoTHSpH2EwWtmZrOPK+uXEkUcw3jEzew9E2a9E5QLz8mzJ9rf6+EY4zJxq968nICii0Qg2dxhzVWhqAOqGYVbkwn41dDxtIGLwW3aZ0888H5uF+BBVOIAuo2yXoAilgqV+hciAOFiKn8hZPI0aSEBKu15smD9lKLr1P0XkcQr1h3QS
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 10:46:49.6861 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b9b4697-f0bf-4c13-658d-08de84dba8d1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF0001AE1A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF2C6B99E0C
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

add support to query vram info from firmware

Signed-off-by: Gangliang Xie <ganglxie@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c |  6 ++++++
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c            | 16 ++++++++++------
 2 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
index 7f4751e5caaf..712b0588a359 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
@@ -399,6 +399,9 @@ amdgpu_atomfirmware_get_vram_info(struct amdgpu_device *adev,
 		switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
 		case IP_VERSION(12, 0, 0):
 		case IP_VERSION(12, 0, 1):
+		case IP_VERSION(9, 5, 0):
+		case IP_VERSION(9, 4, 4):
+		case IP_VERSION(9, 4, 3):
 			index = get_index_into_master_table(atom_master_list_of_data_tables_v2_1, umc_info);
 			break;
 		default:
@@ -475,6 +478,9 @@ amdgpu_atomfirmware_get_vram_info(struct amdgpu_device *adev,
 			switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
 			case IP_VERSION(12, 0, 0):
 			case IP_VERSION(12, 0, 1):
+			case IP_VERSION(9, 5, 0):
+			case IP_VERSION(9, 4, 4):
+			case IP_VERSION(9, 4, 3):
 				umc_info = (union umc_info *)(mode_info->atom_context->bios + data_offset);
 
 				if (frev == 4) {
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index e35ed0cc2ec6..02827afaa365 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1806,6 +1806,7 @@ static void gmc_v9_0_save_registers(struct amdgpu_device *adev)
 static void gmc_v9_4_3_init_vram_info(struct amdgpu_device *adev)
 {
 	static const u32 regBIF_BIOS_SCRATCH_4 = 0x50;
+	int dev_var = adev->pdev->device & 0xF;
 	u32 vram_info;
 
 	adev->gmc.vram_type = AMDGPU_VRAM_TYPE_HBM;
@@ -1818,6 +1819,10 @@ static void gmc_v9_4_3_init_vram_info(struct amdgpu_device *adev)
 		adev->rev_id == 0x3)
 		adev->gmc.vram_type = AMDGPU_VRAM_TYPE_HBM3E;
 
+	if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 3) &&
+	    (dev_var == 0x5))
+		adev->gmc.vram_type = AMDGPU_VRAM_TYPE_HBM3E;
+
 	if (!(adev->flags & AMD_IS_APU) && !amdgpu_sriov_vf(adev)) {
 		vram_info = RREG32(regBIF_BIOS_SCRATCH_4);
 		adev->gmc.vram_vendor = vram_info & 0xF;
@@ -1836,9 +1841,7 @@ static int gmc_v9_0_sw_init(struct amdgpu_ip_block *ip_block)
 
 	spin_lock_init(&adev->gmc.invalidate_lock);
 
-	if (amdgpu_is_multi_aid(adev)) {
-		gmc_v9_4_3_init_vram_info(adev);
-	} else if (!adev->bios) {
+	if (!adev->bios) {
 		if (adev->flags & AMD_IS_APU) {
 			adev->gmc.vram_type = AMDGPU_VRAM_TYPE_DDR4;
 			adev->gmc.vram_width = 64 * 64;
@@ -1846,9 +1849,8 @@ static int gmc_v9_0_sw_init(struct amdgpu_ip_block *ip_block)
 			adev->gmc.vram_type = AMDGPU_VRAM_TYPE_HBM;
 			adev->gmc.vram_width = 128 * 64;
 		}
-	} else {
-		r = amdgpu_atomfirmware_get_vram_info(adev,
-			&vram_width, &vram_type, &vram_vendor);
+	} else if (!amdgpu_atomfirmware_get_vram_info(adev,
+				&vram_width, &vram_type, &vram_vendor)) {
 		if (amdgpu_sriov_vf(adev))
 			/* For Vega10 SR-IOV, vram_width can't be read from ATOM as RAVEN,
 			 * and DF related registers is not readable, seems hardcord is the
@@ -1875,6 +1877,8 @@ static int gmc_v9_0_sw_init(struct amdgpu_ip_block *ip_block)
 
 		adev->gmc.vram_type = vram_type;
 		adev->gmc.vram_vendor = vram_vendor;
+	} else if (amdgpu_is_multi_aid(adev)) {
+		gmc_v9_4_3_init_vram_info(adev);
 	}
 	switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
 	case IP_VERSION(9, 1, 0):
-- 
2.34.1

