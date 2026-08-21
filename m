Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07BCFC5DF7D
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2026 19:55:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8FDCA10F4EB;
	Fri, 21 Aug 2026 19:55:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WzwGTNL8";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010033.outbound.protection.outlook.com
 [52.101.193.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 308FA10F4E4
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2026 19:55:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LY8/U4RqVU1tEVtcvRuy8blWyZYx0V5IHMUB07cPV2rvnKTgDwWl8HMuIxvZph+eCurhg1d5BBzLJVuWTDybJ3fNDv4x7sIkCsz6Jj6wtF63bGqxDy0sRwZYgVN7EoJG/Ol+JEZlbmRUpKYhwuhdYuU6CgiOdG9/z5au0hcFUK0sWPmiCobJB+gOABlv0MM8dOAqYFiZMjt1YbXW+5aXCG9cr5VY2EG7hifI56e4Qy2t+JMrKlLP4uOz6rhLgAiWij9cT8qf1UtOQvEmAXlHinudXZQc8jDettm+X+eRRRsc6mTxOhD0kbR5bhlQPtcE3ZxkZ3nrNc2R1ljQ8ocU8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KD5ZIDae/1lyzopxf+c7n2PEZTFbHaFmzaE/JGd6LD8=;
 b=uBHdxe8GcjfmXbjJpfQzWhOGiaN4rRDl96CiKcqGtpycg+ZQOJ5kmhkYVoMt+daDZ6+uhStOrnE3AMSbVS/47F0VK1053h3tmNs7DAKTZzbl099Afay/OcCSod5l/P6ZcYvV4FPBBGi8NoXAU+Q+navaVvy/4nLHjMjRTlZZitwwF5T1fsLON1rYdlKPMGcaCV0mlmRtAU+Fv2azPYt1GX+4J80DzpRU6p5h/r3zTWTjFCrxKyt0z8DSmi+0Us1bMg7Bfq7rCtqqIBvi898Wo1f7u64KvQ7P529Vipthk9qdKOtqvi5vinJiitF0S4KFHFe4qOk5Wu89XshuSFusHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KD5ZIDae/1lyzopxf+c7n2PEZTFbHaFmzaE/JGd6LD8=;
 b=WzwGTNL84WkKUkmFm2S646FyID4w2SxCbRzatJXGOcDnpiCTOEqZNYxxVODBGppLeiWVSRKgM6pK+yt1bmMiXHNitDRtKN8A0KYfB5vLp+ihiK7qQ70MOqEOdhoIG3mrM8Gl+IHaW3WRBpxTJ/1wA+rQk+fIWRQcWFYwIYdl38Y=
Received: from CY5PR19CA0071.namprd19.prod.outlook.com (2603:10b6:930:69::17)
 by IA0PR12MB8907.namprd12.prod.outlook.com (2603:10b6:208:492::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Fri, 21 Aug
 2026 19:36:16 +0000
Received: from CY4PEPF0000EDD6.namprd03.prod.outlook.com
 (2603:10b6:930:69:cafe::88) by CY5PR19CA0071.outlook.office365.com
 (2603:10b6:930:69::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.11 via Frontend Transport; Fri,
 21 Aug 2026 19:36:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY4PEPF0000EDD6.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 19:36:15 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 14:36:10 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 14:36:09 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 21 Aug 2026 14:36:09 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mukul Joshi <mukul.joshi@amd.com>, Harish Kasiviswanathan
 <Harish.Kasiviswanathan@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 95/95] drm/amdgpu: Honor mtype overrides for NPA remote memory
Date: Fri, 21 Aug 2026 15:34:58 -0400
Message-ID: <20260821193458.808626-96-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821193458.808626-1-alexander.deucher@amd.com>
References: <20260821193458.808626-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD6:EE_|IA0PR12MB8907:EE_
X-MS-Office365-Filtering-Correlation-Id: 12b26517-8749-43c8-5eaa-08deffbb7769
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|376014|1800799024|36860700016|10067099003|11063799006|56012099006|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: r/pTu90GKUb1p9yAYuEj9lTcXgYV8WLhgTSkFOCJwaseiRmfy86XkUeT42ZP0oAWeRiYHbHweR7bV899q5WuVYCwzvZU8C7GM/5qQatPfS4ZyrzmUvCPconfS7/bdtrr1COHHVu7AzC6p9jX+jFlVMEmei0tEF/aarHUrJmTnEfVg1jRewBbgTUAnFP0lAoVR339iRcc+689rzXhGav+VjS+K9+Z1yfaDgzyOwedSq2tpUH/m7c8ZnSZn68nd/fauqP1FGBjgisJJxxSXWHXFnQdi2/LPOjQ1u5tOi1QXQJ260bxavym231+0WwbYAn8DEubVcHfk2HATvIHRpXEWOMj5XeOjsWE9U3YzGSXjQxk7NR40OXinuEZa/kGOJloszrxoP7GJfh1nGNL9Ms1B24cQCX0TNJE40NuGMm6rZXdh+d6zAje+2aWYHqaNG1E40mb0uuiItoHCIqvmNYDHfw8txdo7g2dTwL3ztq1hFlNnR/S3G4vbLSxavli6Sejp9H12zcyvkM0sNy23Sx4BJ1g0ah2A6X22kuTTxyEoIQd9jUk5sQzvzBaX8wpGx6OeukH2sM+55CXOzKVTNZW0mm/zA0laTFGjzZYpbaKxD0Oz/OrtzHSt4aJfftApOkDcqSXSJlYTWS3ZLpqviobriv4xm+iaZM3+8qNVmo6cqy9E6EhQjGNqwfGlBJqPSBlf+fqbH0LzH3hhvQyL8vjoQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(376014)(1800799024)(36860700016)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: sFOYQ6aJCATzRNQHqZoaQe8ggbU+KNgKVtz2Ldy6Ee8kAckhM3hl5U5+2Eyz6pJ/WRh8ji0etf8wg3pveyl/lk6imtYnPi+xTgOrtlVF+gR1y7UO8KJKnAArxYoBYVxcrgpZLLMAGKqY/1OK27HvfloMjkRfG3wXD4UMHmrlMTMsa7YQxSUMhdAw0AJfQjMC/HoJeHXyTNMO1b3kr7BFb6GV0dkZXrvgADag7cciR96mttUo8IQXU4WTyDGoWsLuk/ufBMsKoAVLeKlCxMNz5o0JYZoGwmap1LGuMCI7/FV6MnUTQmrZQcl/RhTOI8Tayganhf++bDzWBRKOMFsRbTm6qVdv8h8eovIpLeUf7rfneKUE994f9HJXhZ27LSp1UAndWlVyGePFqOGzyqLSO7YtE1zlALLjPa8h8nSV8QACKsv1XNU8GVm7U6RPgZkT
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 19:36:15.9700 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 12b26517-8749-43c8-5eaa-08deffbb7769
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8907
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

Derive mtype_remote in gmc_v12_1_get_npa_flags() from
gmc_v12_1_get_mtypes() so the module-parameter override and ASIC
defaults are honored instead of recomputing with hard-coded values.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
Reviewed-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
index 4e7b6e2c87ab5..565ee7fba3cdb 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
@@ -28,6 +28,10 @@
 #include "oss/osssys_7_1_0_sh_mask.h"
 #include "ivsrcid/vmc/irqsrcs_vmc_1_0.h"
 
+static void gmc_v12_1_get_mtypes(struct amdgpu_device *adev,
+				 unsigned int *mtype_local,
+				 unsigned int *mtype_remote);
+
 static int gmc_v12_1_vm_fault_interrupt_state(struct amdgpu_device *adev,
 					      struct amdgpu_irq_src *src,
 					      unsigned int type,
@@ -603,10 +607,9 @@ static void gmc_v12_1_get_vm_pde(struct amdgpu_device *adev, int level,
 static void gmc_v12_1_get_npa_flags(struct amdgpu_device *adev,
 				    uint64_t *flags)
 {
-	bool is_aid_a1 = (adev->rev_id & 0x10);
-	unsigned int mtype_remote;
+	unsigned int mtype_local, mtype_remote;
 
-	mtype_remote = is_aid_a1 ? MTYPE_NC : MTYPE_UC;
+	gmc_v12_1_get_mtypes(adev, &mtype_local, &mtype_remote);
 
 	*flags = AMDGPU_PTE_MTYPE_GFX12(*flags, mtype_remote);
 	/* VSCT = 0011 to identify NPA. Additionally PTE.B = 1 */
-- 
2.55.0

