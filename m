Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AF53C5CFCF
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Aug 2026 21:03:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE18A10F6E1;
	Fri, 14 Aug 2026 21:03:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="D8u96xO4";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012029.outbound.protection.outlook.com [40.107.209.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C4DE10F6CF
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Aug 2026 21:03:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yPS4U4CDlJ+ltLYxaiKNGV+NLvvdKjRqv0EMLqRqWlHnTVkP+NYOnGhKoof2ri6XNNdhDBIWqoBEdm2g343GVJRsVuykn9TfyU/mcXvQZtkP6WzJ6WyRaH2Yz8s/Mj38Ewnu1F/Tw9TDs9Z7r//nekC+xBWWdJyjjU9pzc4VLM1ccePIifVo5se9iOv68Esvr0eS4GdE4TOtCxr/HRt+MNf9iCygzc6Tra0h1hA6t5KZ2fQHoCE2ifJ2dv8YGlWQphzD/IqP7ipZBOmWYEgN9uPhM++FY+VYyAspwg4dJdmjgIQRNu8OO/SfTGITGJ03sHJImliLYV5C33VTbOGtxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8tPHlCALm+2ytYM6Xvu/BKRtON3hXemgYiS49QIklaM=;
 b=QiGOaHrtbBqdYo2y8cMVDEZewpxtyQnzM5TjvUJTshec48F+AXUg0ngFTLp4BHkLrR3dJe6ZgikXl1K0Xs/Din9iBzgb8pyJmtQk3g90PALqitfJyE5gp8K9RKfSjJtNdzbLXMOUTMgVbF4SOyDx2MxF0dDkPM/KCTXhop3p7/4AvXY3jI/rC6xxvda5kMqEF7+/sq4kOW/3/zAjSBlyGAINid270NeG/FYxGouLxyaQjOp/N+2Gu4Xw78X25DhkPX1wAlCvDggyOlsYh05G9tb/ATYNLFICEstbxwWaCnCio6t0LOjPG0zLHPJW6MSinmu2IGnZB5ohu9EfVmOR2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8tPHlCALm+2ytYM6Xvu/BKRtON3hXemgYiS49QIklaM=;
 b=D8u96xO4kbRkWGlCMtbnO0dM7CaYGQMjnONGqNAWbJlygm2MVC/IRvfEsMMjMZYqAE0plmvaw9nMs8WSdsLeI39zuN0NNGfoZnXfmvOtpl79ToTbKLxOIaNevIKCiLSIJNSmOsgFYgIxvGw+/32+amF7si3qMbIGYi9+bep363A=
Received: from DS1PR07CA0022.namprd07.prod.outlook.com (2603:10b6:8:44d::7) by
 DM3PR12MB9352.namprd12.prod.outlook.com (2603:10b6:0:4a::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.15; Fri, 14 Aug 2026 21:03:04 +0000
Received: from CH3PEPF00000018.namprd21.prod.outlook.com
 (2603:10b6:8:44d:cafe::42) by DS1PR07CA0022.outlook.office365.com
 (2603:10b6:8:44d::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.16 via Frontend Transport; Fri,
 14 Aug 2026 21:03:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF00000018.mail.protection.outlook.com (10.167.244.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.0 via Frontend Transport; Fri, 14 Aug 2026 21:03:04 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 14 Aug
 2026 16:03:03 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 14 Aug 2026 16:03:02 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: YiPeng Chai <YiPeng.Chai@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 010/109] drm/amd/ras: support separate logging of gfx aid and
 xcd errors
Date: Fri, 14 Aug 2026 17:01:07 -0400
Message-ID: <20260814210246.3067612-11-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260814210246.3067612-1-alexander.deucher@amd.com>
References: <20260814210246.3067612-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000018:EE_|DM3PR12MB9352:EE_
X-MS-Office365-Filtering-Correlation-Id: 1fb2d20e-9494-420e-d1b6-08defa476ec0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|23010399003|376014|22082099003|18002099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: VEzj4nPmL4M2Gcvoi7ynIZaUyuTVQZfFJYddMQm/xjBbeqlhWMtKnUDZ9RVxHYJsrgj9tCqWj0DacdJY7wwbwhw9ravpiFzmJL9+3DEsev4FycDKIdbWD02nZS6HBFeBxnRcNPl1ywVKwXsxrg9psw8Esa2nVqXR7LhTKybX/EFs7Az1xaTyVvYrzE2cfoQmGgmZqB1wMeF9XX8C3uAzzrQVoHpSCIxQ2Lj53laAiymJRB7mZQxOHkgr4Ucw6H9BVhtZ52+t7Cj+Iy1Ii2g2C2HaDtONlba5fVcPuPjO/IsuHwWGNIlUoIEhqL9L7U7Sgnpah0H/15PwvzLkC3m1WxFWmodLag9Y/Jke+ZfizA/Koea7JGCOg6JK4LTfBtaNJhnuN36oHnrZhfiIMeU9RGWNpd0qUBBBEEfVNogaJ7SCLmlQlhYjA3emJPzjFZcTY0poh1mp8RSO0AFOIjzyPBhDsHvsqr9NKARC0hChxltNvjg8+0M6uDUDx4+m9hOlD3Boknd4px0Tn/tjS52ADEZOndBMUI/pYvkgJwt2oEOk6jwdYXYYSn/KxC9MZarJNL54YH/OJzt3pcULuZGTGZlArPqweRgMrFiBu2Ky3Aj24DCgdCVwspk91Xv1+n9wUR9ig2XQjx6dvkIUOBggX491SxZ/IXrgSoS0kCAGJGQIrF+lya7sLL8KoVVuHRj4b3iD5UZ+bZzZ3hgdMb3iUg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(23010399003)(376014)(22082099003)(18002099003)(56012099006)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: tYqQNURkElvN1Z+MP0UxpQSaoYvKvi7UNAEZHur1ejHZB+Z7hBhXVcYzjZUy3Jhs53q3oRzRqiwVxeXgSqWM9KL9O0jIY8PvVS5RkTxXVcYNpU0OrmeZ5bQKzMpxZxbF6KuRSC7+Gd1gBTWKxX8XQ1jE547geQMqdirD4K/sHuna6/125gdpG7fHIltxmgoRHxvtzJObfLXmt4Z3siM+5hqG35wKghSOBynAMJo/DpFEHkR3yiuZXpn0eMi0ftmsOD6g4PFjAcyqCzFqc52C2kJ1k23k52Xn591Jef5qlyXiGhPNmFrCETjMG4yTi4+ZzCcA/sQAggdkyKjWLu1XKWGKQLHg51HuPCOA0BT/uLJ6CZt9MpRa7uhnObFlj0Wz/IBIzS0O4Hs+N4Aa7UvvCOupz4rvuBMLtj73AN6ZyEsYv6gArvpOjtG3mQqpgRBS
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 21:03:04.0373 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fb2d20e-9494-420e-d1b6-08defa476ec0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000018.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9352
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

Support separate logging of gfx aid and xcd errors.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/ras/core/aca.c | 33 +++++++++++++++---------------
 drivers/gpu/drm/amd/ras/core/aca.h | 13 ++++++------
 2 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/amd/ras/core/aca.c b/drivers/gpu/drm/amd/ras/core/aca.c
index de47137379a16..c8eb1abaccb06 100644
--- a/drivers/gpu/drm/amd/ras/core/aca.c
+++ b/drivers/gpu/drm/amd/ras/core/aca.c
@@ -54,24 +54,24 @@ static void aca_report_ecc_info(struct ras_core_context *ras_core,
 				struct aca_bank_ecc *new_ecc)
 {
 	struct aca_ecc_count ecc_count = {0};
+	struct aca_ecc_count *xcd_ecc;
+	int xcd_id;
 
 	ecc_count.new_ue_count = new_ecc->ue_count;
 	ecc_count.new_de_count = new_ecc->de_count;
 	ecc_count.new_ce_count = new_ecc->ce_count;
-	if (blk == RAS_BLOCK_ID__GFX) {
-		struct aca_ecc_count *xcd_ecc;
-		int xcd_id;
 
+	ecc_count.total_ue_count = aid_ecc->ecc_err.total_ue_count;
+	ecc_count.total_de_count = aid_ecc->ecc_err.total_de_count;
+	ecc_count.total_ce_count = aid_ecc->ecc_err.total_ce_count;
+
+	if (blk == RAS_BLOCK_ID__GFX) {
 		for (xcd_id = 0; xcd_id < aid_ecc->xcd.xcd_num; xcd_id++) {
 			xcd_ecc = &aid_ecc->xcd.xcd[xcd_id].ecc_err;
 			ecc_count.total_ue_count += xcd_ecc->total_ue_count;
 			ecc_count.total_de_count += xcd_ecc->total_de_count;
 			ecc_count.total_ce_count += xcd_ecc->total_ce_count;
 		}
-	} else {
-		ecc_count.total_ue_count = aid_ecc->ecc_err.total_ue_count;
-		ecc_count.total_de_count = aid_ecc->ecc_err.total_de_count;
-		ecc_count.total_ce_count = aid_ecc->ecc_err.total_ce_count;
 	}
 
 	if (ecc_count.new_ue_count) {
@@ -191,7 +191,7 @@ static int aca_check_block_ecc_info(struct ras_core_context *ras_core,
 		return -ENODATA;
 	}
 
-	if ((aca_blk->blk_info->ras_block_id == RAS_BLOCK_ID__GFX) &&
+	if ((aca_blk->blk_info->ras_block_id == RAS_BLOCK_ID__GFX) && info->xcd_valid &&
 	    (info->xcd_id >=
 		 aca_blk->ecc.socket[info->socket_id].aid[info->die_id].xcd.xcd_num)) {
 		RAS_DEV_ERR(ras_core->dev,
@@ -221,10 +221,11 @@ static int aca_log_bad_bank(struct ras_core_context *ras_core,
 
 	mutex_lock(&ras_core->ras_aca.aca_lock);
 	aid_ecc = &aca_blk->ecc.socket[info->socket_id].aid[info->die_id];
-	if (aca_blk->blk_info->ras_block_id == RAS_BLOCK_ID__GFX)
+	ecc_err = &aid_ecc->ecc_err;
+
+	if ((aca_blk->blk_info->ras_block_id == RAS_BLOCK_ID__GFX) &&
+		bank_ecc->bank_info.xcd_valid)
 		ecc_err = &aid_ecc->xcd.xcd[info->xcd_id].ecc_err;
-	else
-		ecc_err = &aid_ecc->ecc_err;
 
 	ecc_err->new_ce_count += bank_ecc->ce_count;
 	ecc_err->total_ce_count += bank_ecc->ce_count;
@@ -477,12 +478,12 @@ int ras_aca_clear_block_new_ecc_count(struct ras_core_context *ras_core, u32 blk
 					ecc_err->new_ue_count = 0;
 					ecc_err->new_de_count = 0;
 				}
-			} else {
-				ecc_err = &aid_ecc->ecc_err;
-				ecc_err->new_ce_count = 0;
-				ecc_err->new_ue_count = 0;
-				ecc_err->new_de_count = 0;
 			}
+
+			ecc_err = &aid_ecc->ecc_err;
+			ecc_err->new_ce_count = 0;
+			ecc_err->new_ue_count = 0;
+			ecc_err->new_de_count = 0;
 		}
 	}
 	mutex_unlock(&ras_core->ras_aca.aca_lock);
diff --git a/drivers/gpu/drm/amd/ras/core/aca.h b/drivers/gpu/drm/amd/ras/core/aca.h
index c1a48e713044d..00d4cc1185dff 100644
--- a/drivers/gpu/drm/amd/ras/core/aca.h
+++ b/drivers/gpu/drm/amd/ras/core/aca.h
@@ -73,6 +73,7 @@ struct aca_ecc_info {
 	int xcd_id;
 	int hwid;
 	int mcatype;
+	bool xcd_valid;
 	uint64_t status;
 	uint64_t ipid;
 	uint64_t addr;
@@ -100,13 +101,11 @@ struct aca_xcd_ecc {
 };
 
 struct aca_aid_ecc {
-	union {
-		struct aca_xcd {
-			struct aca_xcd_ecc xcd[MAX_XCD_NUM_PER_AID];
-			u32 xcd_num;
-		} xcd;
-		struct aca_ecc_count ecc_err;
-	};
+	struct aca_xcd {
+		struct aca_xcd_ecc xcd[MAX_XCD_NUM_PER_AID];
+		u32 xcd_num;
+	} xcd;
+	struct aca_ecc_count ecc_err;
 };
 
 struct aca_socket_ecc {
-- 
2.55.0

