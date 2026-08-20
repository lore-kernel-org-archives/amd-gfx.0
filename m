Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41843C5DF81
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Aug 2026 14:05:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D528910F04B;
	Thu, 20 Aug 2026 14:05:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1GdegyTv";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011052.outbound.protection.outlook.com [52.101.62.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C70910E5EB
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Aug 2026 14:05:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cnFHyzoXILDUWv1pXZS9V3ss60fyzEPxr1ZaQcdg1qCsSl5DNZp/3sS5sHzpzlvf+L0OdcEx6dgnGtdBvxo/0gnREN8nqB3d4vXgk4c1bivlZ9zBXP1UJpwDtKBHcs8gVSHVve4iPkoqYnzNfim/TG4c1Qb90Kj9+gulViEb/1XfL2ugKQgqzYsXa6usQZSqhURPNrNVpTGiUy+fkp3sPhLim5sxTJNm1Y18GLVDK1I2O6KuwAvozTts8NXzKQ08tsu6RtyYvxCCU4hKOaevpg0H1hFQ41l3H5PaNMQS5317KCTqFmSnKOfrnybRHPEKJk96UHwN6beytZd5NSOsFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lgz2zYTxKK2ol2h4V/SrLo73x9pSKBxQdPh2jiRFR+Q=;
 b=s5z3RQAelfdvkaGWsKP7vlUxDykxO9aRcnffJOg4rLkUll28fuXN6o0qoUct9J9Un43Jl+cWUhdOnqmRqA5CQ4BTvT7eBLmRtH/VeU2YDaqDBoh0XHwMUNi6SHLYVEwafpAQb8Q2uClSBoztmaZqlbSD2vubk4FhVa1vT4OUHhCoj9AUsV+kcliaMdJWT3qIq6KW/qm/jm5BS8FsS8FkrND/onASE4pQuePxzbygR+yxmq6j5EdfEDhuRJNU4VUpFbXEPMmgi55MD3jw6hgH1HP5uFFglY8WaO3Rd5di2ud2cXNPy7ogdXaWQw4Q4wvTsNgNdlVg3XEcH+C5W/cbsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lgz2zYTxKK2ol2h4V/SrLo73x9pSKBxQdPh2jiRFR+Q=;
 b=1GdegyTvIkqNbzwXlh+8Nx6lIGn6m/CV1cPy44qZwxIzZSDibJBCDn0aL7ikGSHXyX6ui/lSzUWje94n07RWvGU8V6ybkkvyN1EGDnMb1XZFb+ncqQJvkTP8jXQj0EsT5IrHC4+TaciLX4FCucfy7t3xLaH9yPbnoa6v0sQBj4w=
Received: from IA1P220CA0019.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:464::6)
 by DS0PR12MB7873.namprd12.prod.outlook.com (2603:10b6:8:142::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.9; Thu, 20 Aug
 2026 14:05:20 +0000
Received: from MN1PEPF0000ECDA.namprd02.prod.outlook.com
 (2603:10b6:208:464:cafe::a5) by IA1P220CA0019.outlook.office365.com
 (2603:10b6:208:464::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.10 via Frontend Transport; Thu,
 20 Aug 2026 14:05:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000ECDA.mail.protection.outlook.com (10.167.242.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Thu, 20 Aug 2026 14:05:19 +0000
Received: from liuxiang-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 20 Aug
 2026 09:05:17 -0500
From: Xiang Liu <xiang.liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Tao.Zhou1@amd.com>, <Stanley.Yang@amd.com>,
 <YiPeng.Chai@amd.com>, Xiang Liu <xiang.liu@amd.com>
Subject: [PATCH 2/3] drm/amd/ras: use the per-ASIC reserved VRAM size for the
 bad page threshold
Date: Thu, 20 Aug 2026 22:04:53 +0800
Message-ID: <20260820140454.1340848-2-xiang.liu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260820140454.1340848-1-xiang.liu@amd.com>
References: <20260820140454.1340848-1-xiang.liu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECDA:EE_|DS0PR12MB7873:EE_
X-MS-Office365-Filtering-Correlation-Id: 625c89ff-8e25-43a9-3b65-08defec411d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|23010399003|82310400026|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: rimB5hvstxOnF8TaCmc7gSiqweXh2iKX3qMArwPjbQP6Kxtq1qU+pREf6eSNFwwihmsAzpCJMhhjWeWvHNCh+FA70K4MEyNv/x9zbejzTa0FgudTTT1/Afu3BkrruMBGQsoSuF+C3F8m8hc5gEyKM8l8TUdQZBdIsonAUsWqM9VgowvMmfwwTuZdF6MooZbDX27c/SfxfRuiQn6+mv65716Qfq1RXiPCBePJD35nUbqm64TB4Vzo1sIxgPiuNafz8sRV2i/Vjrb65Mv77aM22fKbI1UI0a+ao6qEqxCnHV9G+EZiirIAb5vhucI7+2D3PCDHwY2Tse/uuUWt/JgXf20OBA0GwT2spwU+nHouwhpqzjOOOYF2S0qwu205OFj6vOE66REfHQq+gYoBpjEoIokpqmyk+KLXA0VN2FaSdplUS3+/d+IJQvC/qcaCGpCiXtACEHme5EviJ3rb01i1+mADN2FGwppYOZVvbWONJXaYVWIm1HeTR05oDeyvmsUgMLfsbiqB6QDIjPIBpDWWNapZGowm63+rPZ1ksrdCtuO+aRVLmI2ztlvZNyEnlxVs1pCen29lNljCjcVHxeaAzxOHN4zoDzks8lRu+9oxmHwHBroXUkS6wd9hTCyFWTpCruhAs9KvKNFnEg77cLXS0BO3O82IBiQ/W2YU3r8k7QwrCBIBDpW1/pE20YRUjuGwB4XexOeyJl+RoKg9cDZYTA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(23010399003)(82310400026)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: BO2eE0V64fW6+tjJPs1UXjIa1lK/9IRynZxWLAVzZYFM3ajq6gSedfILexfP0UBLtDpcl/MtNzKnNllYIk0zPddAhgMmAHcaUGA7elffM9s+WdSMFMzfOW7AmiD1KEfBU5Y0olUYa6ePvtMAFAub4VWs/9JHOfubjUDxG2Dtr1cmuBFOXUrVk9AaPZinXZpXW1awckuO/vSjbiMpK/qT+8ek6bGAdwnBEL2Ys7aA50aeGTgtBSiCZjRc4ojTLEBaZTNRDVher/P1KbvC+qgNHattUnUJkHRN1pVuRhIEdMay9l8HWulgm28+Fef3cZls7j3Un2P7PVcmH2hYnOiTedVTD8jefdiR3CNzR7cPDbPoeTPsudmiyFiTfqeHv/QT+yGxnURWj4pswk+IlbSdw4vJUmm8T3N4o7BSUNGBSUfvXusMpm4rF5VTNeBHoLWK
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2026 14:05:19.9115 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 625c89ff-8e25-43a9-3b65-08defec411d8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECDA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7873
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

The default bad page threshold is derived from the VRAM reserved for
retirement, but ras_eeprom_i2c_config() hardcodes
RAS_RESERVED_VRAM_SIZE_DEFAULT. amdgpu_ras_validate_threshold() instead
derives it from con->reserved_pages_in_bytes, which
amdgpu_ras_init_reserved_vram_size() doubles on MP0 v13.0.14.

That part therefore ends up with a 128 bad page threshold where it
should have 256, and reaches the limit after half as many retirements
as intended.

Reuse the value already computed for con->reserved_pages_in_bytes
rather than deriving it again, so the two cannot drift apart.

Fixes: e383baf88f7d ("drm/amd/ras: Refactor EEPROM parameter config to support multiple ras EEPROMs")
Signed-off-by: Xiang Liu <xiang.liu@amd.com>
---
 .../drm/amd/ras/ras_mgr/amdgpu_ras_eeprom_i2c.c   | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_eeprom_i2c.c b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_eeprom_i2c.c
index d2c9fc525af5..a56d3116c5fd 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_eeprom_i2c.c
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_eeprom_i2c.c
@@ -77,6 +77,19 @@
 #define BAD_PAGE_NUM_PER_EEPROM_RECORD_V13  16
 #define BAD_PAGE_NUM_PER_EEPROM_RECORD_V15  128
 
+static u64 ras_eeprom_reserved_vram_size(struct amdgpu_device *adev)
+{
+	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
+
+	/* Set by amdgpu_ras_init_reserved_vram_size(); 0 means that path
+	 * does not cover this ASIC.
+	 */
+	if (con && con->reserved_pages_in_bytes)
+		return con->reserved_pages_in_bytes;
+
+	return RAS_RESERVED_VRAM_SIZE_DEFAULT;
+}
+
 static int ras_eeprom_i2c_config(struct ras_core_context *ras_core,
 		struct ras_eeprom_param_config *cfg)
 {
@@ -168,7 +181,7 @@ static int ras_eeprom_i2c_config(struct ras_core_context *ras_core,
 		badpages = ESTIMATE_BAD_PAGE_THRESHOLD(adev->gmc.mc_vram_size);
 	} else if (badpage_threshold == WARN_NONSTOP_OVER_THRESHOLD) {
 		cfg->work_mode_over_thresh = RAS_WORK_MODE_OVER_THRESH_STRICT;
-		badpages = COUNT_BAD_PAGE_THRESHOLD(RAS_RESERVED_VRAM_SIZE_DEFAULT);
+		badpages = COUNT_BAD_PAGE_THRESHOLD(ras_eeprom_reserved_vram_size(adev));
 	} else if (!badpage_threshold) {
 		cfg->work_mode_over_thresh = RAS_WORK_MODE_OVER_THRESH_DEBUG;
 		badpages = 128;
-- 
2.34.1

