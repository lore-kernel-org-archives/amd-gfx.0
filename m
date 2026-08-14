Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB906C5B572
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Aug 2026 21:03:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 60AB410E5B2;
	Fri, 14 Aug 2026 21:03:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LVYvQXs4";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013001.outbound.protection.outlook.com
 [40.93.196.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 68B0810E5B2
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Aug 2026 21:03:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ccbwRaBgh0Liw58cagnwEluNly6yEnCmHmH9PNU1Q8/tsLPwtBTvt4RV0McdPKt85GXkChLHFhm7iajKlK6lrOYjgJRL0CV+uMeMsgwjByV1VejpkxW6k/F0BFX+fsLW3bW+3g4ghCH1YYVNW/ulzs6XEnffKSgzhtbuG6D7qM2gXJIr7kKOKJiwk/CplYXbWLCBrLePTpLkkeXuLWGQFDFFnr7ALjlMLxlNrYWFuB6VI/9GxZ774hKks1B11qtOj/zCypoxUtKvU6h0o1lcAT7oXbPrpmytfYbHPqz3AjdIGDrNU4bw1cXngei6jZmOc5LflGBbC8bD7ustraCe7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Mt2BSpKR6eHgQHfdCPS6GEHI4SRbm73sgkyncOaMdY=;
 b=ScSH7f+wKq1tzsQePXDXYROL/OQxguNzuXCw0k9lMsyo0FukEnnmErjWk1q8eRpwQJjwRJMdjT0BfF70mtgqW72SQlxl1wdWN2WDzZ5XA6CoDUE2MAlQRks9ykyoUL/uxGjl+z1OegYXO96W8wpK+wIEe+8Ym0gsHiL4VQDEyEvEUoNl3tC0SgYgI+6c69wi8uxFY8W4hnMxQI+GCkGlUP9stLX3El5Qdi8qLi+hv80h4dyNW9ihvreO+luaay3OAswJ0xqo6ZEuA2nPySzu95zOjbUInm8Q62Vxy2mDCfsgrIzY3VDy4LqdSH/o2QwDJnm9YPiTDMYzEq3h2NJlIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Mt2BSpKR6eHgQHfdCPS6GEHI4SRbm73sgkyncOaMdY=;
 b=LVYvQXs4kV61JVLHLNRHI2VXroRKAqaY4OZCWWeORnHMrM2vEYFdG7ZcDFpvWN1mMTS4a8TYlBAUAcxHxPud5B3WQ/QJ/SUedOIFHV2Kv3cQHJfSw91W27ALyI3f2Lp4tay84rRbUr+dMnAbfBS9Ygd0GwIeQuBPVF711MO8jqY=
Received: from DS1PR07CA0020.namprd07.prod.outlook.com (2603:10b6:8:44d::18)
 by DS3PR12MB999215.namprd12.prod.outlook.com (2603:10b6:8:38f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.14; Fri, 14 Aug
 2026 21:03:00 +0000
Received: from CH3PEPF00000018.namprd21.prod.outlook.com
 (2603:10b6:8:44d:cafe::52) by DS1PR07CA0020.outlook.office365.com
 (2603:10b6:8:44d::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.16 via Frontend Transport; Fri,
 14 Aug 2026 21:03:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF00000018.mail.protection.outlook.com (10.167.244.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.0 via Frontend Transport; Fri, 14 Aug 2026 21:03:00 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 14 Aug
 2026 16:02:59 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 14 Aug
 2026 16:02:59 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 14 Aug 2026 16:02:59 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: YiPeng Chai <YiPeng.Chai@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 004/109] drm/amd/ras: add interface to support parsing aca
 bank ecc info
Date: Fri, 14 Aug 2026 17:01:01 -0400
Message-ID: <20260814210246.3067612-5-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260814210246.3067612-1-alexander.deucher@amd.com>
References: <20260814210246.3067612-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000018:EE_|DS3PR12MB999215:EE_
X-MS-Office365-Filtering-Correlation-Id: 4facfebb-e992-4072-2cea-08defa476c85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|23010399003|82310400026|1800799024|18002099003|22082099003|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: 6Xv12b3WWmjLT0jsTLn94Fujns5jVZjkBkOBVAyfxp7g7NMy+fpH1mhvlY14Qwcad/jkM6/Ym2v3sckZs2CelV07lyN/7hhfMMmX4s0HItdFBrcA3e2+lfmMBJtrwIxwJjnsYoraeyo3hRXRNRwCjueEh3yRh971Wvo5nhS6pnhPz5Izh5b+ify4KEWpiuQIfSoChxe4afUtDgdjI5/wTHibc5QnWfOWSOzj6wKWqqkOVVR8ZPnO6pdX7tNlcMoV5+xOtnIkcPYiqvuSCG6637q4g2ZS8c5xUP73L+i6uxAf6E8s5YMHIw5Qilf8u938LaOMPltMHBLABNEcMzedOlDM7TK0/F7lx0LMa5LDGyt495TxLZhQ4cR3ZGUdTmRYGBFkm5ZwimfJFpgad0qFi4cQThBwVLY2gXJ2OKvy8QgnoWSuQY4Ri/YrV7gLFNUEltQ1HgwhVU1EXLeNoJrzkqba6H4daZsqAOJOK8RKpJBRL1GNsnOp+wX/Wc0BYRXZxPUqTTALSrtJLCmKjw4OxnRoZFvDHUlt/KgiTbIFU/DLKs9KskCzj7GBOU9w/cqBVCsw2yyLp+NFGXNNLqeV63Ouv7jsqcjabyRaGg9tllI/siOwtPKdDTOpfAh4RXJK9+qeQTX3a+mFQsWNrgqxF1cwgZY/fdyo3svRffpMYt+GlU7bsQS98Fyf2CTM2nxEBxWcAbTkIT4frPDf+wqB5w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(23010399003)(82310400026)(1800799024)(18002099003)(22082099003)(11063799006)(56012099006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: feZ4EucoXA7MteYMC+gDZn/Nfry9XvTv14dEQurPNgMhebM0Qt2Ozy3GFdRwClmHItv9p+AQ/Jmxto5SnQu7L/vj6sNlvlhOoRqynVniukgjd8YO9iknKRYsdu684FcSZqXev/Ywem2Ia6QCRltaHyDVGt+FlNIaEBGUT46IZaUNCxBs4QXhmnDitz4yd7chwprMe5QBLl8mVvmRou0CBr4irPm6tckA8CLskWBZRyrwThBBEphRZ/KcmSCwSDGrezicM0aXhtYvmHOqYkGNIOZZvGbgtIIrNz1fn6/Ip/2NZAtXbNcZQ0NxIzf6byY2dXqpHe/SlPhGXlkvdHlTWDU3tFKRC7esXbWBCUlvaRzBukLxU9VojXM21Wt5oluM8Wx1IeTLyoOWGT4AABwuLqWvuc9z/MP2JPupeSmRqs5V71uxYOQsrHrT7SMn2e3g
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 21:03:00.2929 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4facfebb-e992-4072-2cea-08defa476c85
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000018.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS3PR12MB999215
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

Add interface to support parsing aca bank ecc info.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/ras/core/aca.c | 18 ++++++++++++++++++
 drivers/gpu/drm/amd/ras/core/aca.h |  4 ++++
 2 files changed, 22 insertions(+)

diff --git a/drivers/gpu/drm/amd/ras/core/aca.c b/drivers/gpu/drm/amd/ras/core/aca.c
index 7c42a05b0207d..0b5d55e39e25a 100644
--- a/drivers/gpu/drm/amd/ras/core/aca.c
+++ b/drivers/gpu/drm/amd/ras/core/aca.c
@@ -170,6 +170,7 @@ static int aca_parse_bank(struct ras_core_context *ras_core,
 	if (!bank_ops || !bank_ops->bank_parse)
 		return -RAS_CORE_NOT_SUPPORTED;
 
+	ecc->block_id = aca_blk->blk_info->ras_block_id;
 	return bank_ops->bank_parse(ras_core, aca_blk, bank, ecc);
 }
 
@@ -687,3 +688,20 @@ int ras_aca_hw_fini(struct ras_core_context *ras_core)
 
 	return 0;
 }
+
+int ras_aca_parse_bank(struct ras_core_context *ras_core,
+				struct aca_bank_reg *bank,
+				struct aca_bank_ecc *ecc)
+{
+	struct aca_block *aca_blk;
+	int ret = -ENODATA;
+
+	if (!ras_core || !bank || !ecc)
+		return -EINVAL;
+
+	aca_blk = aca_get_bank_aca_block(ras_core, bank);
+	if (aca_blk)
+		ret = aca_parse_bank(ras_core, aca_blk, bank, ecc);
+
+	return ret;
+}
diff --git a/drivers/gpu/drm/amd/ras/core/aca.h b/drivers/gpu/drm/amd/ras/core/aca.h
index 3c1e691cd2ee0..c1a48e713044d 100644
--- a/drivers/gpu/drm/amd/ras/core/aca.h
+++ b/drivers/gpu/drm/amd/ras/core/aca.h
@@ -79,6 +79,7 @@ struct aca_ecc_info {
 };
 
 struct aca_bank_ecc {
+	u32 block_id;
 	struct aca_ecc_info bank_info;
 	u32 ce_count;
 	u32 ue_count;
@@ -161,4 +162,7 @@ int ras_aca_clear_all_blocks_ecc_count(struct ras_core_context *ras_core);
 int ras_aca_update_ecc(struct ras_core_context *ras_core, u32 ecc_type, void *data);
 void ras_aca_mark_fatal_flag(struct ras_core_context *ras_core);
 void ras_aca_clear_fatal_flag(struct ras_core_context *ras_core);
+int ras_aca_parse_bank(struct ras_core_context *ras_core,
+				struct aca_bank_reg *bank,
+				struct aca_bank_ecc *ecc);
 #endif
-- 
2.55.0

