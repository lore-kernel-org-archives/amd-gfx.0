Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA1B8C5CFC1
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Aug 2026 21:03:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5DC9910F6DB;
	Fri, 14 Aug 2026 21:03:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BDhvCbvl";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013007.outbound.protection.outlook.com
 [40.93.196.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C3F6510F6DF
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Aug 2026 21:03:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nMPaoYcrxWXbiYNZNKUVZBUtmoH9jZjFinilbtdWn7Lj07Qbuj/S2ncLtiD0zxXesCp99avggUf66Qvz/mX0bq3HMwfzlU4Fwabvuos+x8nY50PVDloj8LwdK9jGRAk6ZjG4dcPL7patVAgO5v4f1AFQQitDTJnA3FiGp95rlWDWDzUEeLaXXLX/HtRUifBDZNckrY4Y9LT9d77XYCF7KGjm7xVpI6U5S0vom8tfDgX74dDX7kihBUO6x091yqouXT3Ahrw36RRHG55HcurN8iYwultqg+1yBW6Sxl1zZoXoxoXHP0p42IrWbMVzXu0ztYEnVSnliRJm8nX9CbV0Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fYf7hrKxm2M1IVgcSNSsR+37Zqjk0Ej+8MC1pWbxQBY=;
 b=AkVXPC9JvnXzJ3GuolvcPKFLWOn3ZkK5J2VGiOd8U4NElPxEVhtML27WMX06QSBuZNd/MmhSpS2808BT+KkunaRDXr2saH7Rzf78xmwqlvF6/mIqcUhlFTQ4TZG7KJTGk7R/XkvQWrlNAyiwCaWMHwbAgIi7QXvgPiSudsbs3Y/VHIpWlOyGWII4n8dhkkersuiLAiC9JznMlE83UPa82eWUHzm1JQxt5Ig9INHewPx09CNORO8Qg7Mujb6jn1F363tEsY2KL138Qnu0j20IcRzysQH06Wjx0dgFCmTm73xhDq3SZQyb/7xgZIyYcL/G7Hjpk8EuVR1BNMjcAGMgCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fYf7hrKxm2M1IVgcSNSsR+37Zqjk0Ej+8MC1pWbxQBY=;
 b=BDhvCbvlgwoz3jWl4g/tMtNZtTfqGMTOtM92mG19nQb+04TAeUPMAvnUxoaxARkf6tN8XEw1OB/FnosuMr4Zldjhd8cB4vNAcrSiy/G1DpH7PcEQFSMYCTzSXiSBwSqGN9qQGT83VEqqkrm6F7rW/FPo8voywoRJ+ccxviEflAo=
Received: from CH2PR10CA0012.namprd10.prod.outlook.com (2603:10b6:610:4c::22)
 by DS7PR12MB6047.namprd12.prod.outlook.com (2603:10b6:8:84::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.14; Fri, 14 Aug
 2026 21:03:14 +0000
Received: from CH3PEPF00000017.namprd21.prod.outlook.com
 (2603:10b6:610:4c:cafe::3b) by CH2PR10CA0012.outlook.office365.com
 (2603:10b6:610:4c::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.14 via Frontend Transport; Fri,
 14 Aug 2026 21:03:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF00000017.mail.protection.outlook.com (10.167.244.122) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.0 via Frontend Transport; Fri, 14 Aug 2026 21:03:13 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 14 Aug
 2026 16:03:04 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 14 Aug
 2026 16:03:04 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 14 Aug 2026 16:03:04 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: YiPeng Chai <YiPeng.Chai@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 012/109] drm/amd/ras: Supports recording data source
 timestamps to EEPROM
Date: Fri, 14 Aug 2026 17:01:09 -0400
Message-ID: <20260814210246.3067612-13-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260814210246.3067612-1-alexander.deucher@amd.com>
References: <20260814210246.3067612-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000017:EE_|DS7PR12MB6047:EE_
X-MS-Office365-Filtering-Correlation-Id: f397270b-6dfe-4e28-d1b6-08defa4774a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|82310400026|23010399003|10067099003|11063799006|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: Chd6s0dxX6X9/UvivpOtsqi5Y0VMop4qk0CLvoNx7TRT1951PevyHcsrGtLhL9dWekv2J4eKSIMWyMB7ExrtoqU8/JXh0WXB1EG7qn5XTMruNdepaH9Pracevc7PsbMsR5g8iBp0v2V3p7HMcvTjMw4W/NVEyZF9V/VdNL5nGcWWIg8RLAZZh6E0R/7s6wIUJOJjIO0z3m+i7gWBdCbAMlQSf/QiBvAEPFWLModAg84ADuql+ZfsUBytnKkvau90jYmBdUl592bHcysEe2sYGPdNK/w5fHPsBnI1EgX/MJrQBjR4TVFJsgVbWX08NaOgOnC3uNAZ9Zu0L3SedhZhoGOxfZ+FmCLWINVBlkzAD5/RQZCQ+WLS/xlNVv3eMyy1MSZXJ/SPZNroFZB/c27r/Bz9cQwQDW8ttYm0z8MvlsKv2/vOJ4Uf5JDYmT/BrBdtq6hTsOnpyZZZV9Qq8GJwI1y9XbSU0Y64+CLOEunDT/8z7f7hR7OHGj9Qoov4TsV9wknIwjtaEZ+uSbi6suINT65Q4Gl7KbpVnHZpGR2HLMiFulcYDXld6ndXPQ/iLH3uEh4pGpN5ZgpDa01r6AuojJECQpXVXQ3cmXUYyAmJD8M+ZnxalZ8tReiBolhIJ4ZJUrByo2NT2b18lUL+p31VixoOhaLIYZor7k1v2ECSxxo=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(82310400026)(23010399003)(10067099003)(11063799006)(22082099003)(18002099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ABe6n0m+/Leo+4g32shQ+bveAsL46pBMmjNeoR0jMoLyyisGhC9iKXWknLQ4rI1Egfq4KtM6rSKFbKz10IsRWiNIKJV2Ybi8OGKWW2ywiwzzTSIo0tS+Nk51LjdSig+Y1GI30Cx2xpThSgheGV7+RRyK+mwKKd2HW4b04aqSue15461IIIhmYbckXnJ5W6JsoCqvM9gLM7e53WRcerFutzdLD6bMnX1eMgN48gLSFfzr4Djz+v5X8J4M25qhyfi3oLH2xvctT6b93B6D4Dg4rJErAZ6HP3dEw/gEh0KMFh5O1NW5u6v0rAh0eCwSIAaTCQUVQ3NAgNvOMq+bW8h/wwTXwdh419En/5sVBCliLh8PIbFQnW9WuExcM2xUVOhhC1SYW58j0mi6VpKWKa4mPoQkVZufAdApmr6ZoHV+kk6PsalEAqPuAHzRvjSPMnt2
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 21:03:13.9572 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f397270b-6dfe-4e28-d1b6-08defa4774a6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000017.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6047
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

Supports recording data source timestamps to EEPROM.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/ras/core/aca.c           | 5 +++++
 drivers/gpu/drm/amd/ras/core/aca.h           | 1 +
 drivers/gpu/drm/amd/ras/core/ras.h           | 1 +
 drivers/gpu/drm/amd/ras/core/ras_umc_v12_0.c | 6 ++++++
 4 files changed, 13 insertions(+)

diff --git a/drivers/gpu/drm/amd/ras/core/aca.c b/drivers/gpu/drm/amd/ras/core/aca.c
index da06c840cfc09..4258ffb490a60 100644
--- a/drivers/gpu/drm/amd/ras/core/aca.c
+++ b/drivers/gpu/drm/amd/ras/core/aca.c
@@ -132,6 +132,9 @@ static void aca_log_bank_data(struct ras_core_context *ras_core,
 			struct aca_bank_reg *bank, struct aca_bank_ecc *bank_ecc,
 			struct ras_log_batch_tag *batch)
 {
+	if (batch && bank->timestamp)
+		batch->timestamp = bank->timestamp;
+
 	if (bank_ecc->ue_count)
 		ras_log_ring_add_log_event(ras_core, RAS_LOG_EVENT_UE, bank->regs, batch);
 	else if (bank_ecc->de_count)
@@ -245,6 +248,7 @@ static int aca_log_bad_bank(struct ras_core_context *ras_core,
 				ras_ecc.nps = ras_core_get_curr_nps_mode(ras_core);
 				ras_ecc.status = bank_ecc->bank_info.status;
 				ras_ecc.seq_no = bank->seq_no;
+				ras_ecc.timestamp = bank->timestamp;
 			}
 		} else {
 			ras_ecc.nps = ras_core_get_curr_nps_mode(ras_core);
@@ -252,6 +256,7 @@ static int aca_log_bad_bank(struct ras_core_context *ras_core,
 			ras_ecc.ipid = bank_ecc->bank_info.ipid;
 			ras_ecc.status = bank_ecc->bank_info.status;
 			ras_ecc.seq_no = bank->seq_no;
+			ras_ecc.timestamp = bank->timestamp;
 		}
 
 		if (!ret) {
diff --git a/drivers/gpu/drm/amd/ras/core/aca.h b/drivers/gpu/drm/amd/ras/core/aca.h
index 00d4cc1185dff..a8aac196605aa 100644
--- a/drivers/gpu/drm/amd/ras/core/aca.h
+++ b/drivers/gpu/drm/amd/ras/core/aca.h
@@ -53,6 +53,7 @@ struct ras_core_context;
 struct aca_block;
 
 struct aca_bank_reg {
+	uint64_t timestamp;
 	u32 ecc_type;
 	u64 seq_no;
 	u64 regs[ACA_REG_MAX_COUNT];
diff --git a/drivers/gpu/drm/amd/ras/core/ras.h b/drivers/gpu/drm/amd/ras/core/ras.h
index 43e028189087b..5baeb15473a83 100644
--- a/drivers/gpu/drm/amd/ras/core/ras.h
+++ b/drivers/gpu/drm/amd/ras/core/ras.h
@@ -247,6 +247,7 @@ struct ras_ecc_count {
 };
 
 struct ras_bank_ecc {
+	uint64_t timestamp;
 	uint32_t nps;
 	uint64_t seq_no;
 	uint64_t status;
diff --git a/drivers/gpu/drm/amd/ras/core/ras_umc_v12_0.c b/drivers/gpu/drm/amd/ras/core/ras_umc_v12_0.c
index ccdbc5c4bab1a..ac78c404bed41 100644
--- a/drivers/gpu/drm/amd/ras/core/ras_umc_v12_0.c
+++ b/drivers/gpu/drm/amd/ras/core/ras_umc_v12_0.c
@@ -396,6 +396,12 @@ static int umc_v12_0_bank_to_eeprom_record(struct ras_core_context *ras_core,
 	if (ras_fw_eeprom_supported(ras_core) && bank->ts)
 		record->ts = bank->ts;
 
+	/* If the bank being converted already has a timestamp,
+	 * then use the bank's timestamp.
+	 */
+	if (bank->timestamp)
+		record->ts = bank->timestamp;
+
 	lookup_bad_pages_in_a_row(ras_core, record,
 		bank->nps, NULL, 0, bank->seq_no, true);
 
-- 
2.55.0

