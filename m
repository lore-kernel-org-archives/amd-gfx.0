Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35306C624DA
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Sep 2026 20:11:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 71BB310EF02;
	Tue,  1 Sep 2026 20:11:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="oTZ+hSbp";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010026.outbound.protection.outlook.com [52.101.201.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B925510EF03
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Sep 2026 20:11:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pij2RwM8KsefR93dIJwt73wn9Ltn6obxAk/m81ewI/+3Er+cRZbPz19TsudK3H3RlLMfBHaG798AYp9wbBr5LbNaaKt32Q+4YBJa2gGUAqIYDLq/aL4QIacKHCW3e2nSnHhUTXvjpaRMSEpOsY/+3DOr1arrlp7/MhplfEjrDaRL7h2WhuXv4U4dA6AqB0K9neTR2zPikQaFS+KoZ1xKvDf/3hHUTsj4FmqQeAEu6wAcD0LKqzSIRLURamUC31+lO47P74NjvU2OQtSsAUpFVFK2DouYNh391NSLs0cCdAnz6FMreRXjDH/CkBNXYaMqb86PUwn3x3W8MtzWcGiamw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=obvmG6DV3AaKweIDMadKVYGiDGvwc2qymz/9qbCTklQ=;
 b=YqK/Bo2wb4IdNRx7L4Pw+hZatB0urZtN/9orLeVGYr+D5G6KuqL+vXa80FYrG+71mrXBMOhInyeJXp8VLVDPJb8RQo3SqRevwV48aj6hLJMadKyky9BR6Q99DZUohfW290dp+PF9L1aBdJ1+sOtIM6q4RjOs1NLbAUx/zMCMyu7xPqtPIeTxReRg7iQ/Zh+77OZ8yHjtBIPaVlNV83uRvGRrXWus9doYV5a7nDbNSuHYGPKxoVvdoLJ+2fOd8vX5XGR2X0axaSPXyw53pLH991QMkEVwvSUXmgGz7gZbl6nKmZrrAswfzbg/emo551Zn+oNm5xuQng15+NFIpfLYPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=obvmG6DV3AaKweIDMadKVYGiDGvwc2qymz/9qbCTklQ=;
 b=oTZ+hSbpeg6t1S9nYfyvhK6h473OXHdLi8DX10BAl+pBVnVusiCvFj5X5PgP2C8vMXO/AiAstKxSXOL/PzEx+ehPIrHutx3o53tBekeCD77BJeDHdFizSxawwJ7+Rw08tOyor7Sa1kHF75IAY5ck7DKZM94HsmiE6rQB2sQiCAc=
Received: from CH0PR13CA0041.namprd13.prod.outlook.com (2603:10b6:610:b2::16)
 by DSVPR12MB999308.namprd12.prod.outlook.com (2603:10b6:8:423::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 20:11:00 +0000
Received: from BL6PEPF00022572.namprd02.prod.outlook.com
 (2603:10b6:610:b2:cafe::59) by CH0PR13CA0041.outlook.office365.com
 (2603:10b6:610:b2::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.10 via Frontend Transport; Tue, 1
 Sep 2026 20:11:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00022572.mail.protection.outlook.com (10.167.249.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Tue, 1 Sep 2026 20:11:00 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 1 Sep
 2026 15:10:53 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 1 Sep
 2026 15:10:53 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Tue, 1 Sep 2026 15:10:52 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 10/31] drm/amdgpu/gmc12: use MMIO for TLB flushes
Date: Tue, 1 Sep 2026 16:10:13 -0400
Message-ID: <20260901201034.2960437-11-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260901201034.2960437-1-alexander.deucher@amd.com>
References: <20260901201034.2960437-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022572:EE_|DSVPR12MB999308:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fcf1cfb-64e7-4717-0129-08df0865243c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|82310400026|23010399003|376014|10067099003|6133799003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: BqIuZWus6RgoKexLx+YPAV0Kb8KMRCy+SZmZN5qKKqvk85xQAO+Iwbkm/6OZ5koj+vC2u8hERXReOjhYdP4kWEEAIolU3+RtlnyogMxAbE3ZE7Jwow2/XjYkFChirHDP4Ycdfo+XcyhfTRv6R18YwFzDm0pAhxXravreB+S0OZdCG1/Cud++dudJ3J16Ws2SExPWD3SDg50mS2wrP7ilXlM+QSqFA1FC/jW5VQkc2hmXYBnlDCKKymICAqkgguJA780+dy2dXnKPfjaMZ6be4nMXh/P7fCBZuus7B0dJ8B9El0fQBPJ6PsFrdIyauEYWXtQx1Dt0xS4VuH43zZMsngvHYSe++EHMHOVJuKdY+dLItcUPx/q772uhI66ar6Ay5feA8nvYCGrWlPFvQy/CcCu8uIZ9YwE8VLLjy/m/7Ki2m/HQzSfMfv31yqqJC/le0UG4GykJ6gVcndzziH7uLYb2FHVtLIMohhgnma7ttR7f4fqNvfbGuf/jV+Ec+bvBiGDsPVAFo7PLD767/WiteZtj7lOAU633O3u6yuQ/ti70MUSOgJ+sO78/mUxNrMEaucYO+b7dJKqiPUw9k2gm7LbB+LrUT4YMp3gYrwVDKTvCAR4nfgSjIrqLPBT5n1pf/lMHa7kwgtJMy41oDrbix4KViBhRkS5ViI10ybZnnZ4H2nRMNkYm85mZsARMm5Iu6yoY8qhRHlVRWvGNdesQug==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(82310400026)(23010399003)(376014)(10067099003)(6133799003)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Qsp2yONmOnRODRUeCxsuvGD71M/VUD7pHWJbJwIAlhFUxm+yeLvIUZgqkANqvqSF9QqCTdLgDqUGWbxzRdsYb9hGWRZsRSBTqX0pNaVZagArTDcFA5EPhAlwvbECkxKE7ftgmG+0o5B37N1gguo8O9ycqNuUqu0Hq6PN6Bqa1NWtL8kqpTKdzAa6qcyOzx9/RoDLKERUrQyCVCaE5I2Iv2FTknLuABxKH7Aqri04ppQ2/o/x9IEYsrfek8SAVfVXDnNbcOcHbtEtSdR539D0s/Pxmg9+FU0DDSDnThlb+14rwFPERlXD4WU+Kzg8aXP5IjVeBk17VXaZooqVqKT++xmJEOeKTLdfc6UJHoOLT2LUE4V4Rg1qcNV4AASJ1rBtOuzEmzEma6dTJUaKldeqcKktyTlCUDr3Kk6+Qfj7FTBbpUpjq+uvInbPZfq9cEHO
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 20:11:00.2091 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fcf1cfb-64e7-4717-0129-08df0865243c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00022572.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR12MB999308
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

MES has a dedicated pipe for these sort of tasks
on GC12 so it shouldn't be an issue.

MES is used to avoid disallowing GFXOFF, but since the
MES will wake GFX anyway to execute the flush, just disallow
it when we flush and use MMIO for consistency with
other chips.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
index 3b1fe15fa1c01..cffc818880d12 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
@@ -968,8 +968,18 @@ static int gmc_v12_0_sw_init(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
-	adev->gmc.use_mmio_for_tlb_flush =
-		!(amdgpu_sriov_runtime(adev) || !amdgpu_sriov_vf(adev));
+	switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
+	case IP_VERSION(12, 0, 0):
+	case IP_VERSION(12, 0, 1):
+	default:
+		adev->gmc.use_mmio_for_tlb_flush =
+			!amdgpu_sriov_runtime(adev);
+		break;
+	case IP_VERSION(12, 1, 0):
+		adev->gmc.use_mmio_for_tlb_flush =
+			!(amdgpu_sriov_runtime(adev) || !amdgpu_sriov_vf(adev));
+		break;
+	}
 
 	return 0;
 }
-- 
2.55.0

