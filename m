Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBD0AC44501
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jul 2026 07:47:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C49E10EF29;
	Wed, 15 Jul 2026 07:47:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3nL1MgRL";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011066.outbound.protection.outlook.com [40.107.208.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 05C4710EF1D
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jul 2026 07:47:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v2RoPJznlqvYBjaUbdZz+RnbDL3RHIldJ2ugtnFFCSsjpMYBP1pjExpdKVOG8yPS1Ss0l3sUX+/p4fqyrL044F8egY1aW9WNi2UdxcrdPuev9Icx01CvMrZSL0jdBJ/tWHDpAkzyIa1LIM27WAc6FLF0KOc3gwY4nNS2fP3o1Gy+3QDgnUhHrMLv2Lew/9x2lYhStbhW8T1Hcz1lbBMTTQknZ6/bV0HHHfqVL9zdTtGxvOrVFiIQ/xxpyYOidIDaZZ1FYV3EmfOVBgVh6iNHsGYpwMZnjzuyOQ2qTHtXc2/ktZMnVRRd+r8tQXWBpY9Xr9rayl39CABknEfJL2t1fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pcOWvPbNHd+iVlmy6yTsoetFiz5JBOKIwfrrghEAUO0=;
 b=vCsisXdahImVgKSG9hvn/XHdWru4Ur90F3Ef+hL1qrfpKmg+Qldh8pOPoflX/BCk+dP2tyD2GvVO4nlSsJpVvUhb7nDqtWYPReKKN2O+9P26Jx4jyJsOvWca31CQTDVmlEEST3CijeBsd2JLye3J24vCtA7Yr8iHSuu1OoGulMlmYOTlvBBcfAoeO4bG6qV0KHbTej3zfEjFIeebFYGiewLHAnK3dHYFIADR6IW+LSvdT0vZxaUceEkMkaSWh7dAanVjKLnHONDXiNXwwQKrXDcTivsmPRzK5iekp6ncMvC9m2ID7qNxhuv1FDsDCHMxDbKEvf6sEu1Js5u0XytQKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pcOWvPbNHd+iVlmy6yTsoetFiz5JBOKIwfrrghEAUO0=;
 b=3nL1MgRL9cS94AqCZMsMHkDtpKEyxT0Dy2UHsPlVuqnKsP0yhTSpn7H/ZfafhEeKP8nwHLxplWy4Em1KvdiXTYuaihooJYFF6s6MBoY1aOLeB77hiB6tifmrX8aYF5U3jl5WugNdzeXm/tdMg+6mgOiP+j9cWJUfV4MC3FeyGNA=
Received: from MN0P222CA0001.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:531::6)
 by CH3PR12MB9220.namprd12.prod.outlook.com (2603:10b6:610:198::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Wed, 15 Jul
 2026 07:47:50 +0000
Received: from BL02EPF0001A0FA.namprd03.prod.outlook.com
 (2603:10b6:208:531:cafe::19) by MN0P222CA0001.outlook.office365.com
 (2603:10b6:208:531::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.11 via Frontend Transport; Wed,
 15 Jul 2026 07:47:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A0FA.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Wed, 15 Jul 2026 07:47:50 +0000
Received: from tao-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 15 Jul
 2026 02:47:48 -0500
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Tao Zhou <tao.zhou1@amd.com>
Subject: [PATCH 4/5] drm/amd/ras: add real ras deferred error count
Date: Wed, 15 Jul 2026 15:47:33 +0800
Message-ID: <20260715074734.2668631-4-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260715074734.2668631-1-tao.zhou1@amd.com>
References: <20260715074734.2668631-1-tao.zhou1@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FA:EE_|CH3PR12MB9220:EE_
X-MS-Office365-Filtering-Correlation-Id: 59d76111-33d9-4d11-d4ea-08dee2455e94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|82310400026|36860700016|1800799024|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: xxEuyb0bvxBUEnEdjS8zuG0vNmNWoQ7P37f/GEoMrjuxoEgFbcS4Noi8HsPX04vk27rgtNcD5/xUHPV7TKET/iqO4pAzXoYtURSwUhz8Bj3jsHeaio75U/jdYvYhEckoSUoQbfA7YdygdMMtKbL79qy+4zfXX5xtWG+CNbIwBQ/rDsYJ7uwUSaZnnbfCYgf/zjkNpBAoBIwFQyULT1ZAKkl3lRjXuZxe+w4L3FWhFKTW+DAF7L+w9c3W+J+oI0KXUFr7JFeo35QVfKTKJqSx6fIRm92r+9ncocouTnzQlsskLUe9KPkmWqhvWpTCkM0UMKm4Xaw8NyYFeOFZb3NIzhlGxpEN4DtbPosF2/HEwMIwiWoXevcu0Rj7L8aC/HvhJYWYZm5cAdHWzstds5ZuDC1vyQPz+unH1ebbHx0frnPqWtrJK9/lMBRcA6ehKEeOkll86n46YZJqbmZt3uVosNGCYAJwBS5G8znhtn9AaCCcsmU/zdvDTRy7GmLosdoqwRJZkYcZA3eHhO4ubeEDEAMrEb+n86R+Cf3dXGPWxBEfyFe+XflPuiRvLgHoGsPAlC9YXex+I98Xc51XrrBokzxCHq9czBVtRMi/g6qPKcYsK1FV99D5zpiQebVcBDVd/fQ84U79CztlV1gm45apJkIswVcMzIM5zAXPmGbIvzUiUOBHrvVSfAqQFE7n8cBUSbM6rUHsC39nLUOR5DVwJw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(82310400026)(36860700016)(1800799024)(18002099003)(22082099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 5dtzFxq0UciQ/YP+oggE9wbD1AGcEm8hAxuFsUS3PzumHw5F3LNPGrksujhbLGf1Cd8J3QaNQdTMBT+l2bTMATYVlOQsfwb1pvg9x9dzjzMNsDJVDJ8fm8zWyfTbQt7PVYxZNrPkIwu1XtRmBDBxD8BkPy8qiyoMjzbo+4VM/HO5Rk6BNnPCfsJXlUFeUF8QYv6IkJh30MUEsBMc0dZgK9sw7GLhteybAe8i/vJJjJNSd6VCtaOrRC9egcRdjA0xoZ6c/Pi7hQhD1GouAtxBLyob3axYVi4Mw45N5oHlC4OpZQYbbKzKxIJz96CuIMr2SsPcWG2wPpACXZ5O+B3LEA2AQ+Y9NOHrgwj3O+8sB8Fgfj2J2TU772u/eh0O0+R9RD0rVzTosbz65mCwg8sEQ7Qq9z0tsln5zKtt1EXgdcIoKd+lis+/TbF6AOVygcrt
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 07:47:50.0194 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 59d76111-33d9-4d11-d4ea-08dee2455e94
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9220
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

It only depends on the status of ras bank register, and can be used
in common aca layer.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/ras/rascore/ras_aca.h      |  2 ++
 drivers/gpu/drm/amd/ras/rascore/ras_aca_v1_0.c | 18 +++++++++++-------
 2 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_aca.h b/drivers/gpu/drm/amd/ras/rascore/ras_aca.h
index f61b02a5f0fc..0bde803f7472 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_aca.h
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_aca.h
@@ -83,6 +83,8 @@ struct aca_bank_ecc {
 	u32 ce_count;
 	u32 ue_count;
 	u32 de_count;
+	/* only depends on bank reg status */
+	u32 real_de_count;
 };
 
 struct aca_ecc_count {
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_aca_v1_0.c b/drivers/gpu/drm/amd/ras/rascore/ras_aca_v1_0.c
index 840610538c1f..41df331587a0 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_aca_v1_0.c
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_aca_v1_0.c
@@ -207,6 +207,13 @@ static bool aca_check_umc_ce(struct ras_core_context *ras_core, uint64_t mc_umc_
 		     !(aca_check_umc_ue(ras_core, mc_umc_status)))));
 }
 
+static bool aca_check_bank_is_de(struct ras_core_context *ras_core,
+				uint64_t status)
+{
+	return (ACA_REG_STATUS_POISON(status) ||
+				ACA_REG_STATUS_DEFERRED(status));
+}
+
 static int aca_parse_umc_bank(struct ras_core_context *ras_core,
 			struct aca_block *ras_blk, void *data, void *buf)
 {
@@ -230,6 +237,9 @@ static int aca_parse_umc_bank(struct ras_core_context *ras_core,
 	ext_error_code = ACA_REG_STATUS_ERRORCODEEXT(status0);
 	misc0_errcnt = ACA_REG_MISC0_ERRCNT(bank->regs[ACA_REG_IDX__MISC0]);
 
+	if (aca_check_bank_is_de(ras_core, status0))
+		ecc->real_de_count = misc0_errcnt ? misc0_errcnt : 1;
+
 	if (aca_check_umc_de(ras_core, status0))
 		ecc->de_count = misc0_errcnt ? misc0_errcnt : 1;
 	else if (aca_check_umc_ue(ras_core, status0))
@@ -240,13 +250,6 @@ static int aca_parse_umc_bank(struct ras_core_context *ras_core,
 	return 0;
 }
 
-static bool aca_check_bank_is_de(struct ras_core_context *ras_core,
-				uint64_t status)
-{
-	return (ACA_REG_STATUS_POISON(status) ||
-				ACA_REG_STATUS_DEFERRED(status));
-}
-
 static int aca_parse_bank_default(struct ras_core_context *ras_core,
 				  struct aca_block *ras_blk,
 				  void *data, void *buf)
@@ -266,6 +269,7 @@ static int aca_parse_bank_default(struct ras_core_context *ras_core,
 
 	if (aca_check_bank_is_de(ras_core, status)) {
 		ecc->de_count = 0;
+		ecc->real_de_count = 1;
 	} else {
 		if (bank->ecc_type == RAS_ERR_TYPE__UE)
 			ecc->ue_count = 1;
-- 
2.34.1

