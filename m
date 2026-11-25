Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D9E606A321
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Nov 2026 07:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=y+BvM20e
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4FA8510E595;
	Wed, 25 Nov 2026 07:44:34 +0000 (UTC)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012015.outbound.protection.outlook.com [52.101.53.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 052E510E595
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Nov 2026 07:44:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xml+HHky05becjJKJogr/C0q7bY0lZ/nFh3mSUHDL3lgqdr3OY/ri0zP0r/n8xkUwk71wMWB2LN9QG56dKErIhQpnUZR62UKEJFv84DU4RLWVyHd9M+XQAoZ9LTCwfbDjI6EA4F6+3LtQyPgHNSMDlgaFndEEzTcoVwACFkTT3VG9ZlmiEKV8pS7FsJfYFOy3Vfwo9cp/vX/4bLehe336Sv459ZbAhjuJF0Hp1u0RcBjUtS852msg/PjZBZ43ig3i1UzOTk4C7SZigkiG7qYr5+4CQvMDtR5mWr2YyNfuJDH3DiVMi+dADYou4X9sXf5NjGc2dycsQJQedGmA/iG4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6l8+RMOxNE78Nd6TUqVSNyOoHyZyAP30kxEwzEnSmvU=;
 b=C4EhqtV89ZomultbLrJxonMBE9vt1+cJwLU8hvtGDFqzOTcOfXXVh24I1OigSe2U7JB56Tz8WsdT2C3Kc6YhLOsmAMM2zPhjYIKqY9NvFtMmCVNng9mS89TUMEOLM7UP1SGC+T4p3wIN3jvqHhHUP4vtUIbzNk89f8iWBhHf93hzvzBS+Zx1S7Xfn0DO5GrXO5cdf/dkW4Cwpfa7yDFNzToL2VEjlDeq3uf/SwV6V+7MPBnzJBxm7VMpMVsKkja+Ai/ZhWnyLkR5I6b6qD+aKlkMuYLaUmbYaZrs3yZPfI21/rzayXD/CX/L2+LJ2o0IcC3FA/2OGazUWQpzNwPzPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6l8+RMOxNE78Nd6TUqVSNyOoHyZyAP30kxEwzEnSmvU=;
 b=y+BvM20eWt/zgnVxpPSmaax6nLg19hLqPvgkiHJxbz9iUYtcds4yUivu4RXgsqqtYoggoyY0cQJGnzSjIwj8Pz9LdfQh6+23+j8x0dHr7m0xB6/AuCvXtGhE6KXJDfiEFawkMAuqqSJaVUVDmd3uU6qrSGWLL0BETldQLrPdT2s=
Received: from CH5P220CA0002.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1ef::10)
 by PH7PR12MB7281.namprd12.prod.outlook.com (2603:10b6:510:208::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.6; Wed, 25 Nov
 2026 07:44:22 +0000
Received: from DS8PEPF000000E1.namprd05.prod.outlook.com
 (2603:10b6:610:1ef:cafe::69) by CH5P220CA0002.outlook.office365.com
 (2603:10b6:610:1ef::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.12 via Frontend Transport; Wed,
 25 Nov 2026 07:44:22 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS8PEPF000000E1.mail.protection.outlook.com (10.167.23.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.3 via Frontend Transport; Wed, 25 Nov 2026 07:44:22 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Wed, 25 Nov
 2026 01:44:19 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>, <Asad.Kamal@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: Fix accesses in SDMA v7.1 soft reset
Date: Wed, 25 Nov 2026 13:13:59 +0530
Message-ID: <20261125074359.3144477-2-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20261125074359.3144477-1-lijo.lazar@amd.com>
References: <20261125074359.3144477-1-lijo.lazar@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS8PEPF000000E1:EE_|PH7PR12MB7281:EE_
X-MS-Office365-Filtering-Correlation-Id: 13bc7e62-baf3-4930-2c3c-08df4ac7ebcc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|23010399003|376014|10067099003|261021123027099003|261102123227099003|261021121427099003|261009223027099003|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: 4sJXFC5441Is579XPcOFEEm7XKQa4vqS2Isy+qjmICerS9l8mZDjsKsD02dgj219w+XJJkMs+xNUTMzTQrjEa56ksHlD2aiEkjCFqlotvWAbgspogP6y2uAWAhT2NsKg86Dp4IbLntU3TA65vwWaf/n5TCPjpLGK+qzEsWTeXKd22WuNRoDrPqkEYWrz4T8P1IeMD/7GmIoU3RJMlMpXnyfzRMqB6YHMU/lgGD5nMSygL419ljEed9SzCKvJ3+Ah9SlKAzQ94JGniJGtGZ1jvfyXx7jieBWq6bB5ZRx+EXUrF7fNQy3rbEAFYkas1eCEUsRfdvizykZmhJ3nXdKuyWhayzm+2A8fP+ZxA+5ZsBtv/ES4Gpj/1SFUT40fwIvs9etW+niB4N6kQO3O9RGiVmIZcHJMAgZPLW6zzlXBvvXI6MrKZuNEHxBd0e+YIhdTP/l1Tbj4+GmiYMnyT+FAEanlhWZ8taqixTTFdQ69t+k7V8qi91eyj8K/MpISi8xbERhod/ZLHdK+/h96WW0mE7nOC2miS/YqsJuaBFkJiACakNskD3GwlTNk8ulAoiSAzqLVTC1l74ajDk7rKwmU1p7kwF7GDVaYBjpW1gf2Iif5IGi5O4DRm1i+Vgx5ixOZP4aj10NbHrmkqyvYlLQg4jaBvwflNeVsA30GoN7ygBxbTbAhWOohAapSbv2E315pfINbolKA52Ps2i8AsAfVLQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(23010399003)(376014)(10067099003)(261021123027099003)(261102123227099003)(261021121427099003)(261009223027099003)(18002099003)(22082099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: w9c8MS1pfOXoadWMjg4ruPypBmkoQNxXjGKtPmH7uHKycXrm1GDdDu78Picptgl2syR09/jGUQJ97LP3pDNdNo5aI1J+93PIYq0qDI+4iMKlO/iZWynejqOKoOh1jrXBov0TYWTOkPGgXSUghoM2qAq6zGVNnNHljMgzWLSCO1GhizszjVR/4Fq6fxiL5vF/2nCtYaG+nfvO4WeBCK1z/a8drQxbA7dBH9bBe3DIH/I7Aq7bIBCIIOCqaBKLJJakLseZpyEyL30yze3x1nSw1aPC1OOIZL35xrwJ7figF6hcwU2J+OD8RMEqjG+FN/OSNmABNo8NPE6YmgibKbuNRHwOe0itUS/t2kJlOEJCA8TcDpjvzZnF3wNb8DeXNaSsPMI88bPusFBYjAHnZlWjce+9z77Io6jk44CYy3yoXpzzXRo1XSAtMw5Bq6Q7FHZG
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 07:44:22.4262 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 13bc7e62-baf3-4930-2c3c-08df4ac7ebcc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS8PEPF000000E1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7281
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Fix the register access in soft reset sequence to use the correct XCC
instance and per XCC sdma instance.  Soft reset is not yet supported in
SDMA v7.1 though.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c
index 3e8facc0358d..c689e52b1d72 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c
@@ -788,8 +788,8 @@ static int sdma_v7_1_inst_load_microcode(struct amdgpu_device *adev,
 static int sdma_v7_1_soft_reset(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
+	u32 xcc_id, sdma_xcc_inst;
 	uint32_t inst_mask;
-	u32 xcc_id;
 	u32 tmp;
 	int i;
 
@@ -797,6 +797,8 @@ static int sdma_v7_1_soft_reset(struct amdgpu_ip_block *ip_block)
 	sdma_v7_1_inst_gfx_stop(adev, inst_mask);
 
 	for_each_inst(i, inst_mask) {
+		sdma_xcc_inst =
+			GET_INST(SDMA0, i) % adev->sdma.num_inst_per_xcc;
 		xcc_id = adev->sdma.instance[i].xcc_id;
 
 		//tmp = RREG32_SOC15_OFFSET(GC, xcc_id, regSDMA0_SDMA_FREEZE,
@@ -810,14 +812,14 @@ static int sdma_v7_1_soft_reset(struct amdgpu_ip_block *ip_block)
 
 		udelay(100);
 
-		tmp = GRBM_SOFT_RESET__SOFT_RESET_SDMA0_MASK << i;
-		WREG32_SOC15(GC, 0, regGRBM_SOFT_RESET, tmp);
-		tmp = RREG32_SOC15(GC, 0, regGRBM_SOFT_RESET);
+		tmp = GRBM_SOFT_RESET__SOFT_RESET_SDMA0_MASK << sdma_xcc_inst;
+		WREG32_SOC15(GC, xcc_id, regGRBM_SOFT_RESET, tmp);
+		tmp = RREG32_SOC15(GC, xcc_id, regGRBM_SOFT_RESET);
 
 		udelay(100);
 
-		WREG32_SOC15(GC, 0, regGRBM_SOFT_RESET, 0);
-		tmp = RREG32_SOC15(GC, 0, regGRBM_SOFT_RESET);
+		WREG32_SOC15(GC, xcc_id, regGRBM_SOFT_RESET, 0);
+		tmp = RREG32_SOC15(GC, xcc_id, regGRBM_SOFT_RESET);
 
 		udelay(100);
 	}
-- 
2.49.0

