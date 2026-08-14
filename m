Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 102E3C5DF76
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Aug 2026 21:03:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D225010F700;
	Fri, 14 Aug 2026 21:03:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PTODkd0T";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010034.outbound.protection.outlook.com [52.101.61.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7CDCA10F6F4
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Aug 2026 21:03:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=APxc8IW3D85i0DspO/umRqsOVAyBZMeGy22uEPhf0xvTPZKCm9FNVCu6welhjhWSYKbcx3SpPfN4XdN5XC4V9B6oh1h9rcq+57fTRpxRi2eT0t8S+w7gUaEva6QebTiyc/CCWMvzZiVB0wOs0zQTyxEQ78mCE5QL9md8slcxMqglqbk4hPpjmrW+zfk4gkN75lNE4w7nbUK/65HSLtJjjVD9DqBle0iTHHSbaGyl7R26Fq29fZAVed3MrQKb5u4L1DfP3bWSjAX8j3eZ77hKHuqnkW/v9tN+M3nZPIe7O8f1zTij0QksyL1sSIk7UDNI+LnWSRWJD/eNc4ETE0pElg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vx8d2f9ZwDCrnif+opcfMgfhq3zvUdBZ//FqdV1uW84=;
 b=QvCKjcf2654WYkrGJXrhFyHLdPvYP2g+L8FpBYYPhQqcP5SuPmNBOPsrATk3MgYD0FPc9kQ9exfsSh3wMuBIogB6J18ArMZ4qiEAuYkJQXWMWzM7aLlTuLBkKaeagyTvwVIWKNp1Zeprf4t7D+lLQBeQLd4Gp/PwnDcVtimtKaM7B04kj/Zu86BmjXnOW/YMlzPvCvhSLumDkZLifzUwugejqtifGzRbcZdchB9rHUaTQdfLLrvT5BESIAbM7Q5UCNcTQgRyQNS2a7rdht4zEUuWrup5+RxqZ66I2dhuQgVMJzLl3rftrsXdD9AvouAoXHysli/DlKlx8EOuwHmxJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vx8d2f9ZwDCrnif+opcfMgfhq3zvUdBZ//FqdV1uW84=;
 b=PTODkd0THWmd/0woUP4NsbSnDfThffeDIcYWa23K1CELZT60GwnrCcD00UGCjbhACWH44iMM2Su3fFUQH+E4lR9hHb9674DLkCxk+EUgz+QjOMrvbv84b0sS61AnBYLluP7ED3pipvwjU1oRKpD+xYPQ9Et/a5a4R4Faax3iRyo=
Received: from SA1P222CA0051.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:2d0::24)
 by SN7PR12MB7935.namprd12.prod.outlook.com (2603:10b6:806:349::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.13; Fri, 14 Aug
 2026 21:03:16 +0000
Received: from SA2PEPF0000150B.namprd04.prod.outlook.com
 (2603:10b6:806:2d0:cafe::38) by SA1P222CA0051.outlook.office365.com
 (2603:10b6:806:2d0::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.16 via Frontend Transport; Fri,
 14 Aug 2026 21:03:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SA2PEPF0000150B.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Fri, 14 Aug 2026 21:03:16 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 14 Aug
 2026 16:03:08 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 14 Aug
 2026 16:03:08 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 14 Aug 2026 16:03:07 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: YiPeng Chai <YiPeng.Chai@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 018/109] drm/amd/ras: Add mce ras error type
Date: Fri, 14 Aug 2026 17:01:15 -0400
Message-ID: <20260814210246.3067612-19-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260814210246.3067612-1-alexander.deucher@amd.com>
References: <20260814210246.3067612-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF0000150B:EE_|SN7PR12MB7935:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e59e73d-1b3c-437e-b7c9-08defa4775f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700016|23010399003|1800799024|6133799003|18002099003|22082099003|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: Bcqw8eE1agQc0KNaDipV6Lf4LM3yAt/SM6+gtjJeFecl47TEoVk3/W8u8eDYkzJH59fI4gj051rr0R4v0rd6ceZqZwl3AVsWf0whYVLMdvyJHBPorSf+D2i4TLqCbVayhnAGqYw1kBVbbOq/dZdPavIlrc00agylSLTXBwewUiFt3E7G4TPlY9GFLmFNu/fbeN/2ytgyju8clFhGZyR/1xDn9UbhZACc57kX9sE99gPKa7Hh9qrp8og9ks6lFWM+IP5K0sYKCfql+hhSew2Wd2ZwfhqF5te42H99X8G/kkfPaBjZapXlUfVg4RUMfSHr5EF9ykXel/7jFGhF02fDgoPcrW4PplxPGr5teiDROkBSQjxKoVRCX2oXMuKgQ6uiYPnt+KWBYSivDpGNwYKIPvYmBQWk6+D3olOAl79S9HE/lEwT97AUOtwZLbCgsGmLL+utq186+1mBySb4xmETvQNRhabowABPCPnhXZJU6gqf4hOl7j5qMVs2dQ2t87lzzsUZ54wyGaM3lxICjzt4jnuOi2sVQM6l1Ry1s29Xjde41Z+k/0BCNKRbqepgO/CMS+/hcNQs4tYzCcNpPfQ0UZqSdO6KBGPAnniy4GaGmQQQkAW19089/3+IfnOK1nvNyKXYZK2VrQqUlceq364drZE8E+SmO1xOAbwmROlPGlh26uHO+hr6Ep+5JP71AjKvHIu3g13XEoBW+S25KVi+aA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700016)(23010399003)(1800799024)(6133799003)(18002099003)(22082099003)(11063799006)(56012099006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: lnrVz2MdI7qbQAf+QYjoYakE4lhpYLFYUlPPsk7SrPSGiUICHzURuAZFwQhVgagp3iEs3sU8uHwwUzoUSAdsx0aVoGXFAHZjQs47WjnFwPO4kwaptEiH6HOoB9B/Mfvox3WRY4+0+5T5lxptXiwyC0gz+kwNXg6GxVytW+QVUnmcsgf/pqCsZC0xHfBZ/wuC/i9b2q8SxxIQ3fMy9jnD0g1h0B+SzREu6boE2uyfIJa7PrnAsJNyAELknML5YexuRLgJPrC4Hs1jNLJcsw57bcSxg++tNFdnrCymYHY4PzW1Wmd5PEosHEQGw4Pe/Qb9MuWbcH/ybmCEa6zUjPEpjxX0FxNxHgHZ8WScM/BSkEKhW74tVhxrb9Eg0cF72qhiYDJx7tKtVm6Kra+CHcGWHedisRcNeIu75slKvOCEZBLGBpQFw8DAMiGjWine2ztS
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 21:03:16.1432 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e59e73d-1b3c-437e-b7c9-08defa4775f9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF0000150B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7935
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

Add new ras error type so that ACA parser
can parse ras data from mce.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/ras/core/aca.c          | 9 +++++++--
 drivers/gpu/drm/amd/ras/core/core.c         | 2 ++
 drivers/gpu/drm/amd/ras/core/ras.h          | 1 +
 drivers/gpu/drm/amd/ras/core/ras_aca_v5_0.c | 6 ++++--
 4 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/ras/core/aca.c b/drivers/gpu/drm/amd/ras/core/aca.c
index 23660e93eecde..be4af1522685b 100644
--- a/drivers/gpu/drm/amd/ras/core/aca.c
+++ b/drivers/gpu/drm/amd/ras/core/aca.c
@@ -23,6 +23,7 @@
  */
 #include "ras.h"
 #include "aca.h"
+#include "ras_mce.h"
 #include "aca_v1_0.h"
 #include "ras_aca_v5_0.h"
 #include "ras_mp1_v13_0.h"
@@ -152,7 +153,9 @@ static void aca_log_bank_data(struct ras_core_context *ras_core,
 static int aca_get_bank_count(struct ras_core_context *ras_core,
 			      enum ras_err_type type, u32 *count)
 {
-	return ras_mp1_get_bank_count(ras_core, type, count);
+	return (type == RAS_ERR_TYPE__MCE) ?
+		ras_mce_get_bank_count(ras_core, type, count) :
+		ras_mp1_get_bank_count(ras_core, type, count);
 }
 
 static bool aca_match_bank(struct aca_block *aca_blk, struct aca_bank_reg *bank)
@@ -297,7 +300,9 @@ static int aca_dump_bank(struct ras_core_context *ras_core, u32 ecc_type,
 {
 	struct aca_bank_reg *bank = (struct aca_bank_reg *)data;
 
-	return ras_mp1_dump_bank(ras_core, ecc_type, idx,
+	return (ecc_type == RAS_ERR_TYPE__MCE) ?
+			ras_mce_dump_bank(ras_core, ecc_type, idx, bank) :
+			ras_mp1_dump_bank(ras_core, ecc_type, idx,
 				bank->regs, ARRAY_SIZE(bank->regs));
 }
 
diff --git a/drivers/gpu/drm/amd/ras/core/core.c b/drivers/gpu/drm/amd/ras/core/core.c
index 2ddb011e8082b..9d0453ba21c15 100644
--- a/drivers/gpu/drm/amd/ras/core/core.c
+++ b/drivers/gpu/drm/amd/ras/core/core.c
@@ -534,6 +534,8 @@ int ras_core_update_ecc_info(struct ras_core_context *ras_core)
 {
 	int ret;
 
+	ras_aca_update_ecc(ras_core, RAS_ERR_TYPE__MCE, NULL);
+
 	ret = ras_aca_update_ecc(ras_core, RAS_ERR_TYPE__CE, NULL);
 	if (!ret)
 		ret = ras_aca_update_ecc(ras_core, RAS_ERR_TYPE__UE, NULL);
diff --git a/drivers/gpu/drm/amd/ras/core/ras.h b/drivers/gpu/drm/amd/ras/core/ras.h
index 2fed47a476168..9bab956bbf385 100644
--- a/drivers/gpu/drm/amd/ras/core/ras.h
+++ b/drivers/gpu/drm/amd/ras/core/ras.h
@@ -98,6 +98,7 @@ enum ras_err_type {
 	RAS_ERR_TYPE__UE = 0,
 	RAS_ERR_TYPE__CE,
 	RAS_ERR_TYPE__DE,
+	RAS_ERR_TYPE__MCE,
 	RAS_ERR_TYPE__LAST
 };
 
diff --git a/drivers/gpu/drm/amd/ras/core/ras_aca_v5_0.c b/drivers/gpu/drm/amd/ras/core/ras_aca_v5_0.c
index e407c3eb1c967..15e72d4b492d0 100644
--- a/drivers/gpu/drm/amd/ras/core/ras_aca_v5_0.c
+++ b/drivers/gpu/drm/amd/ras/core/ras_aca_v5_0.c
@@ -242,7 +242,8 @@ static int aca_parse_bank_default(struct ras_core_context *ras_core,
 	} else {
 		if (bank->ecc_type == RAS_ERR_TYPE__UE)
 			err->ue_count = 1;
-		else if (bank->ecc_type == RAS_ERR_TYPE__CE)
+		else if ((bank->ecc_type == RAS_ERR_TYPE__CE) ||
+			(bank->ecc_type == RAS_ERR_TYPE__MCE))
 			err->ce_count = ACA_V5_REG_MISC0_ERRCNT(misc0);
 	}
 
@@ -275,7 +276,8 @@ static int aca_parse_xgmi_bank(struct ras_core_context *ras_core,
 		if (ext_error_code != 0 && ext_error_code != 1 && ext_error_code != 9)
 			count = 0ULL;
 		err->ue_count = count;
-	} else if (bank->ecc_type == RAS_ERR_TYPE__CE) {
+	} else if ((bank->ecc_type == RAS_ERR_TYPE__CE) ||
+		(bank->ecc_type == RAS_ERR_TYPE__MCE)) {
 		count = ext_error_code == 6 ? count : 0ULL;
 		err->ce_count = count;
 	}
-- 
2.55.0

