Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28032C5DF7B
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Aug 2026 21:04:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B131610F72B;
	Fri, 14 Aug 2026 21:03:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="raNkb7oy";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013048.outbound.protection.outlook.com
 [40.93.201.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4AFA510F718
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Aug 2026 21:03:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WT1Syn1agIx0RanjQ/8mmBL7valaz8tfsMOJmZE1fLsJBAsW0S9mXGTefTpyNPbPP0jwIUq37t+g3Knt/YczQMPN28UjNQggMiBCGhZgYcU89/icq8yaPCrw9FUS6CT3A0w8QRuGaLEeMyMAb8yF0zj1EAY2FBt6JvtSSd9JwopwSYR1bWVYNynGiT47lWOGtnci8hS3Ey+A1qNFU3ZhM0gdWysnxJy0N4m85xg/QeXDNgKfGyBqF28avzAscxRbJeH1R1Dnxo0y6JxujNiFUvV7yAr8aTV74qeLlN3hx6ViZNUr89gi/n7FIoxKLB0GIabI9aU1AFKsYkfPDN40Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VRuuvVA12SC/68pl9OuczWICDGO1lhU7/fJZ6tJDchA=;
 b=diSbNJRV87nd03394f/Dckp0UrGEVrBiVz9DmevLUvPqQIJY4K7L2z62FbJRF3UoQxEzFG7DrPO4Nky2nBtykFj0r7wrxHb4Gs/fFWPNh70TeKJNrnbGXzQ9NicpcXHZ+RXpq/t7fbBWJYA2yMq35NEJwsf2ovrjo1TtcTmbs3vI7reqIMAAHB2aCcK4fTKlveiYfyjYozDoOL7UbeyHR6u+dGVfbrrtX9dW/C+/AJOKvo8/WHLOzbWi80BZlUPSnCcPsKxk6Usy7VruOJ788ebyvOR+dQVFKNwdN5SrK00JXI9lDqy+P/dWBN2q4pESfEPi9Y0i54dw68UMKlw8Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VRuuvVA12SC/68pl9OuczWICDGO1lhU7/fJZ6tJDchA=;
 b=raNkb7oy17l9e/jGTmYwdnKOHpD33/PgcvvErXNOTi/2OazpSASSk0IoPac8NojUyXwXDoaOoYm+6BIoT3XDuHlhwCQIzuQ7yFIAS2EcNPe/TQ/9XUFJB3w8vmZrI22TBzBEtTTo77F+YFPmNdJ6sHNRahhthwNYi7+0oHFU4PY=
Received: from CH0PR04CA0011.namprd04.prod.outlook.com (2603:10b6:610:76::16)
 by PH7PR12MB8155.namprd12.prod.outlook.com (2603:10b6:510:2b2::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.16; Fri, 14 Aug
 2026 21:03:46 +0000
Received: from CH3PEPF00000016.namprd21.prod.outlook.com
 (2603:10b6:610:76:cafe::2c) by CH0PR04CA0011.outlook.office365.com
 (2603:10b6:610:76::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.16 via Frontend Transport; Fri,
 14 Aug 2026 21:03:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF00000016.mail.protection.outlook.com (10.167.244.121) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.0 via Frontend Transport; Fri, 14 Aug 2026 21:03:46 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 14 Aug
 2026 16:03:41 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 14 Aug
 2026 16:03:40 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 14 Aug 2026 16:03:40 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: YiPeng Chai <YiPeng.Chai@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 071/109] drm/amd/ras: use single socket per GPU device to
 store ACA RAS error info
Date: Fri, 14 Aug 2026 17:02:08 -0400
Message-ID: <20260814210246.3067612-72-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260814210246.3067612-1-alexander.deucher@amd.com>
References: <20260814210246.3067612-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000016:EE_|PH7PR12MB8155:EE_
X-MS-Office365-Filtering-Correlation-Id: 414c3253-d95b-44ae-17c1-08defa4787e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|23010399003|1800799024|36860700016|10067099003|11063799006|56012099006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: ZUCH/fp6fRTmmteUXr7AK+Z1QyiX6r8O3g91wGvmUOt6MafjiT0PQGM5DSG0X/6gHLrwQ6tanToKhGT7Woi6F0Pv+oK1MzQz7C70tgG8Rt7fvS35VkbkBoS1ccYRJPPJU+pkPPznDwwlzcrwF2IlK++ve9xb1c9X5zrilsgeEFzeMdrwn4AFiT3Ztl9/rjyYFLOG2P0mNUCqu5bCSt6+kYAkuIY5Qx9VTA9enhyMcwSsMsY2gvBDzmfvO4JlGeFzpzqd0n9P+P1KwjJtEn/e87dJjK/cXOIenksGyakGYM4djUbgQS3r3gsyvZUSxYwA6wdt3WBlMIHMK92X29aKKz/05ULxTO+7eKh9rC0FYBL84xe5BfqEiJLRpX/ZEUGQ+G+g9qdq29DA9SagdzhxL7rv8PW9hSlhD/52kC7rNjqqw4OLAwQ2Tt61BdsSxM2jSzGmCbTo7QPa+VNQJu5sFpo+gGEVAlt2/WhjLexyWiVTLLkJlzPOz6VTgY7HDBt633+v19Q8Kn1q9wd1b98hd0KOPbSXfO6Gp3J2bJsfP4uSX26pdo0CCDrEzZPMFrewfY3JprqAYiwDg6/QUFBi4QTnuvSz/zw5N7tCgf57jj7pq2xthbEahBQnqv66fpj9lU1orUdDB6NPRZd9QDZ9rPKr5LI8qd1ghPGOgaGpp6Y=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(23010399003)(1800799024)(36860700016)(10067099003)(11063799006)(56012099006)(6133799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: r4cpV9O322sozx4Z3cntdOdS+14tNNehR2OCN8jnUxJ1N9oU3NX1Q31RWVfAde/6wxs4fT/F+04LxyxuNvhOEaaaaOidraDHkcdFnbX3hOHBbefr/QCdo7cXv/CmKuwiYNzJj18fYvVkTZI2wmm05Z6brBn///tvkva6ZDY3zBhigTG4Suo52S0tFwg8Ivoxx6hlUiuHRfzbLPgTw5kRIkHndGji17yZTtOBxaYl9Bm/tU3n89Bz3BwutrQPpCpqlel8YFaq9V17zR/iRFyfHCQt3DcUbgFow7urTNCXTaW9GTvJ7eMf7GYoGMnZzadskXL7n9LY+hyR8ilroF19x9BpBB1GMLXhVfWO9/pEz7nE24y4pIrrdhs/d5KwBsS/Tq/wZTiRWfji09JZDXllkv+4RiJICiII7xmfoNSssQR9dOQ9zdThlLggUsEgiwtf
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 21:03:46.2219 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 414c3253-d95b-44ae-17c1-08defa4787e3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000016.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8155
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

The socket ID parsed from ACA IPID always corresponds to the current
socket and never references another socket. Therefore, there is no
need to maintain per-socket storage for remote sockets — a single
socket is sufficient to store all ACA RAS error information for each
GPU device.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/ras/core/aca.c            | 100 ++++++++----------
 drivers/gpu/drm/amd/ras/core/aca.h            |   4 +-
 drivers/gpu/drm/amd/ras/core/ras.h            |   1 -
 .../gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c  |   4 -
 .../gpu/drm/amd/ras/ras_mgr/amdgpu_ras_sys.c  |   3 +
 5 files changed, 49 insertions(+), 63 deletions(-)

diff --git a/drivers/gpu/drm/amd/ras/core/aca.c b/drivers/gpu/drm/amd/ras/core/aca.c
index a2529645af098..60a435ae92c9a 100644
--- a/drivers/gpu/drm/amd/ras/core/aca.c
+++ b/drivers/gpu/drm/amd/ras/core/aca.c
@@ -189,27 +189,36 @@ static int aca_parse_bank(struct ras_core_context *ras_core,
 static int aca_check_block_ecc_info(struct ras_core_context *ras_core,
 			struct aca_block *aca_blk, struct aca_ecc_info *info)
 {
-	if (info->socket_id >= aca_blk->ecc.socket_num_per_node) {
+	struct device_system_info dev_info = {0};
+	int ret;
+
+	ret = ras_core_get_device_system_info(ras_core, &dev_info);
+	if (ret) {
+		RAS_DEV_ERR(ras_core->dev, "Failed to get system device info.\n");
+		return ret;
+	}
+
+	if (info->socket_id != dev_info.socket_id) {
 		RAS_DEV_ERR(ras_core->dev,
-			"Socket id (%d) is out of config! max:%u\n",
-			info->socket_id, aca_blk->ecc.socket_num_per_node);
-		return -ENODATA;
+			"Bank socket id (%d) does not match device socket id:%u\n",
+			info->socket_id, dev_info.socket_id);
+		return -ENXIO;
 	}
 
-	if (info->die_id >= aca_blk->ecc.socket[info->socket_id].aid_num) {
+	if (info->die_id >= aca_blk->ecc.socket.aid_num) {
 		RAS_DEV_ERR(ras_core->dev,
 			"Die id (%d) is out of config! max:%u\n",
-			info->die_id, aca_blk->ecc.socket[info->socket_id].aid_num);
+			info->die_id, aca_blk->ecc.socket.aid_num);
 		return -ENODATA;
 	}
 
 	if ((aca_blk->blk_info->ras_block_id == RAS_BLOCK_ID__GFX) && info->xcd_valid &&
 	    (info->xcd_id >=
-		 aca_blk->ecc.socket[info->socket_id].aid[info->die_id].xcd.xcd_num)) {
+		 aca_blk->ecc.socket.aid[info->die_id].xcd.xcd_num)) {
 		RAS_DEV_ERR(ras_core->dev,
 			"Xcd id (%d) is out of config! max:%u\n",
 			info->xcd_id,
-			aca_blk->ecc.socket[info->socket_id].aid[info->die_id].xcd.xcd_num);
+			aca_blk->ecc.socket.aid[info->die_id].xcd.xcd_num);
 		return -ENODATA;
 	}
 
@@ -232,7 +241,7 @@ static int aca_log_bad_bank(struct ras_core_context *ras_core,
 		return ret;
 
 	mutex_lock(&ras_core->ras_aca.aca_lock);
-	aid_ecc = &aca_blk->ecc.socket[info->socket_id].aid[info->die_id];
+	aid_ecc = &aca_blk->ecc.socket.aid[info->die_id];
 	ecc_err = &aid_ecc->ecc_err;
 
 	if ((aca_blk->blk_info->ras_block_id == RAS_BLOCK_ID__GFX) &&
@@ -268,7 +277,7 @@ static int aca_log_bad_bank(struct ras_core_context *ras_core,
 
 	aca_report_ecc_info(ras_core,
 		bank->seq_no, aca_blk->blk_info->ras_block_id, info->socket_id, info->die_id,
-		&aca_blk->ecc.socket[info->socket_id].aid[info->die_id], bank_ecc);
+		&aca_blk->ecc.socket.aid[info->die_id], bank_ecc);
 
 	return 0;
 }
@@ -452,16 +461,13 @@ int ras_aca_clear_all_blocks_ecc_count(struct ras_core_context *ras_core)
 {
 	struct aca_block *aca_blk;
 	enum ras_block_id blk;
-	int skt;
 
 	mutex_lock(&ras_core->ras_aca.aca_lock);
 	for (blk = RAS_BLOCK_ID__UMC; blk < RAS_BLOCK_ID__LAST; blk++) {
 		aca_blk = ras_aca_get_block_handle(ras_core, blk);
-		if (aca_blk) {
-			for (skt = 0; skt < aca_blk->ecc.socket_num_per_node; skt++)
-				__clear_block_socket_ecc_count(ras_core,
-						blk, &aca_blk->ecc.socket[skt]);
-		}
+		if (aca_blk)
+			__clear_block_socket_ecc_count(ras_core,
+						blk, &aca_blk->ecc.socket);
 	}
 	mutex_unlock(&ras_core->ras_aca.aca_lock);
 
@@ -471,29 +477,27 @@ int ras_aca_clear_all_blocks_ecc_count(struct ras_core_context *ras_core)
 int ras_aca_clear_block_new_ecc_count(struct ras_core_context *ras_core, u32 blk)
 {
 	struct aca_block *aca_blk;
-	int skt, aid, xcd;
+	int aid, xcd;
 	struct aca_ecc_count *ecc_err;
 	struct aca_aid_ecc  *aid_ecc;
 
 	mutex_lock(&ras_core->ras_aca.aca_lock);
 	aca_blk = ras_aca_get_block_handle(ras_core, blk);
-	for (skt = 0; skt < aca_blk->ecc.socket_num_per_node; skt++) {
-		for (aid = 0; aid < aca_blk->ecc.socket[skt].aid_num; aid++) {
-			aid_ecc = &aca_blk->ecc.socket[skt].aid[aid];
-			if (blk == RAS_BLOCK_ID__GFX) {
-				for (xcd = 0; xcd < aid_ecc->xcd.xcd_num; xcd++) {
-					ecc_err = &aid_ecc->xcd.xcd[xcd].ecc_err;
-					ecc_err->new_ce_count = 0;
-					ecc_err->new_ue_count = 0;
-					ecc_err->new_de_count = 0;
-				}
+	for (aid = 0; aid < aca_blk->ecc.socket.aid_num; aid++) {
+		aid_ecc = &aca_blk->ecc.socket.aid[aid];
+		if (blk == RAS_BLOCK_ID__GFX) {
+			for (xcd = 0; xcd < aid_ecc->xcd.xcd_num; xcd++) {
+				ecc_err = &aid_ecc->xcd.xcd[xcd].ecc_err;
+				ecc_err->new_ce_count = 0;
+				ecc_err->new_ue_count = 0;
+				ecc_err->new_de_count = 0;
 			}
-
-			ecc_err = &aid_ecc->ecc_err;
-			ecc_err->new_ce_count = 0;
-			ecc_err->new_ue_count = 0;
-			ecc_err->new_de_count = 0;
 		}
+
+		ecc_err = &aid_ecc->ecc_err;
+		ecc_err->new_ce_count = 0;
+		ecc_err->new_ue_count = 0;
+		ecc_err->new_de_count = 0;
 	}
 	mutex_unlock(&ras_core->ras_aca.aca_lock);
 
@@ -551,9 +555,7 @@ int ras_aca_get_block_ecc_count(struct ras_core_context *ras_core,
 {
 	struct ras_ecc_count *err_data = (struct ras_ecc_count *)data;
 	struct aca_block *aca_blk;
-	struct aca_ecc_count skt_ecc;
 	struct aca_ecc_count ecc;
-	u32 skt;
 
 	if (blk >= RAS_BLOCK_ID__LAST)
 		return -EINVAL;
@@ -565,13 +567,7 @@ int ras_aca_get_block_ecc_count(struct ras_core_context *ras_core,
 	memset(&ecc, 0, sizeof(ecc));
 
 	mutex_lock(&ras_core->ras_aca.aca_lock);
-	for (skt = 0; skt < aca_blk->ecc.socket_num_per_node; skt++) {
-		memset(&skt_ecc, 0, sizeof(skt_ecc));
-		__get_block_socket_ecc_count(ras_core, blk,
-				&aca_blk->ecc.socket[skt], &skt_ecc);
-
-		_add_ecc_count(&ecc, &skt_ecc);
-	}
+	__get_block_socket_ecc_count(ras_core, blk, &aca_blk->ecc.socket, &ecc);
 
 	err_data->new_ce_count = ecc.new_ce_count;
 	err_data->total_ce_count = ecc.total_ce_count;
@@ -589,21 +585,18 @@ int ras_aca_sw_init(struct ras_core_context *ras_core)
 	struct ras_aca *ras_aca = &ras_core->ras_aca;
 	struct ras_aca_config *aca_cfg = &ras_core->config->aca_cfg;
 	struct aca_block *aca_blk;
-	uint32_t socket_num_per_node;
 	uint32_t aid_num_per_socket;
 	uint32_t xcd_num_per_aid;
-	int blk, skt, aid;
+	int blk, aid;
 
-	socket_num_per_node = aca_cfg->socket_num_per_node;
 	aid_num_per_socket = aca_cfg->aid_num_per_socket;
 	xcd_num_per_aid = aca_cfg->xcd_num_per_aid;
 
 	if (!xcd_num_per_aid || !aid_num_per_socket ||
-		(socket_num_per_node > MAX_SOCKET_NUM_PER_NODE) ||
 	    (aid_num_per_socket > MAX_AID_NUM_PER_SOCKET) ||
 	    (xcd_num_per_aid > MAX_XCD_NUM_PER_AID)) {
-		RAS_DEV_ERR(ras_core->dev, "Invalid ACA system configuration: %d, %d, %d\n",
-			socket_num_per_node, aid_num_per_socket, xcd_num_per_aid);
+		RAS_DEV_ERR(ras_core->dev, "Invalid ACA system configuration: %d, %d\n",
+			aid_num_per_socket, xcd_num_per_aid);
 		return -EINVAL;
 	}
 
@@ -615,14 +608,11 @@ int ras_aca_sw_init(struct ras_core_context *ras_core)
 
 	for (blk = 0; blk < RAS_BLOCK_ID__LAST; blk++) {
 		aca_blk = &ras_aca->aca_blk[blk];
-		aca_blk->ecc.socket_num_per_node = socket_num_per_node;
-		for (skt = 0; skt < aca_blk->ecc.socket_num_per_node; skt++) {
-			aca_blk->ecc.socket[skt].aid_num = aid_num_per_socket;
-			if (blk == RAS_BLOCK_ID__GFX) {
-				for (aid = 0; aid < aca_blk->ecc.socket[skt].aid_num; aid++)
-					aca_blk->ecc.socket[skt].aid[aid].xcd.xcd_num =
-								xcd_num_per_aid;
-			}
+		aca_blk->ecc.socket.aid_num = aid_num_per_socket;
+		if (blk == RAS_BLOCK_ID__GFX) {
+			for (aid = 0; aid < aca_blk->ecc.socket.aid_num; aid++)
+				aca_blk->ecc.socket.aid[aid].xcd.xcd_num =
+							xcd_num_per_aid;
 		}
 	}
 
diff --git a/drivers/gpu/drm/amd/ras/core/aca.h b/drivers/gpu/drm/amd/ras/core/aca.h
index b19b6e7089f28..22b12a036754e 100644
--- a/drivers/gpu/drm/amd/ras/core/aca.h
+++ b/drivers/gpu/drm/amd/ras/core/aca.h
@@ -26,7 +26,6 @@
 #define __ACA_H__
 #include "ras.h"
 
-#define MAX_SOCKET_NUM_PER_NODE 8
 #define MAX_AID_NUM_PER_SOCKET 4
 #define MAX_XCD_NUM_PER_AID 4
 
@@ -119,8 +118,7 @@ struct aca_socket_ecc {
 };
 
 struct aca_block_ecc {
-	struct aca_socket_ecc socket[MAX_SOCKET_NUM_PER_NODE];
-	u32 socket_num_per_node;
+	struct aca_socket_ecc socket;
 };
 
 struct aca_bank_hw_ops {
diff --git a/drivers/gpu/drm/amd/ras/core/ras.h b/drivers/gpu/drm/amd/ras/core/ras.h
index 38ab1aa9be0f9..9c830b803e834 100644
--- a/drivers/gpu/drm/amd/ras/core/ras.h
+++ b/drivers/gpu/drm/amd/ras/core/ras.h
@@ -323,7 +323,6 @@ struct ras_bank_ecc_node {
 };
 
 struct ras_aca_config {
-	u32 socket_num_per_node;
 	u32 aid_num_per_socket;
 	u32 xcd_num_per_aid;
 };
diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
index 34b4b3345259a..0e41c005a1ea2 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
@@ -35,11 +35,9 @@
 #include "amdgpu_ras_nbio_v7_9.h"
 #include "amdgpu_ras_mce.h"
 
-#define MAX_SOCKET_NUM_PER_NODE_GFX9    8
 #define MAX_AID_NUM_PER_SOCKET_GFX9     4
 #define MAX_XCD_NUM_PER_AID_GFX9        2
 
-#define MAX_SOCKET_NUM_PER_NODE_GFX12   4
 #define MAX_AID_NUM_PER_SOCKET_GFX12    2
 #define MAX_XCD_NUM_PER_AID_GFX12       4
 
@@ -92,12 +90,10 @@ static int amdgpu_ras_mgr_init_aca_config(struct amdgpu_device *adev,
 	case IP_VERSION(9, 4, 3):
 	case IP_VERSION(9, 4, 4):
 	case IP_VERSION(9, 5, 0):
-		aca_cfg->socket_num_per_node = MAX_SOCKET_NUM_PER_NODE_GFX9;
 		aca_cfg->aid_num_per_socket = MAX_AID_NUM_PER_SOCKET_GFX9;
 		aca_cfg->xcd_num_per_aid = MAX_XCD_NUM_PER_AID_GFX9;
 		break;
 	case IP_VERSION(12, 1, 0):
-		aca_cfg->socket_num_per_node = MAX_SOCKET_NUM_PER_NODE_GFX12;
 		aca_cfg->aid_num_per_socket = MAX_AID_NUM_PER_SOCKET_GFX12;
 		aca_cfg->xcd_num_per_aid = MAX_XCD_NUM_PER_AID_GFX12;
 		break;
diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_sys.c b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_sys.c
index 7bc827cc8e9fc..afb539f068c2d 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_sys.c
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_sys.c
@@ -212,6 +212,9 @@ static int amdgpu_ras_sys_get_device_system_info(struct ras_core_context *ras_co
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)ras_core->dev;
 
+	if (!adev->smuio.funcs || !adev->smuio.funcs->get_socket_id)
+		return -ENOENT;
+
 	dev_info->device_id = adev->pdev->device;
 	dev_info->vendor_id = adev->pdev->vendor;
 	dev_info->socket_id = adev->smuio.funcs->get_socket_id(adev);
-- 
2.55.0

