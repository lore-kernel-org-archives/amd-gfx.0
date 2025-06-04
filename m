Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB6D9C5B543
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Jun 2025 19:38:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6937410E78C;
	Wed,  4 Jun 2025 19:38:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XaP1gEHr";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2055.outbound.protection.outlook.com [40.107.95.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B309C10E78C
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Jun 2025 19:38:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L6hxCnxLN/jTjRKJlvublQ0138Nwz70lpyCKLrR+WaUbG1al/CgoJr6DhsOcf3U4HsduSd+k9tWupbMY09xD6Z9PIvdRtO3Fbv/ZrrQPCREWznC8wNmEsYDADkADxEUePynuHs+TlKIhY2W/J/eEb3lRKegsMc27BNGb8PwbcMzuMq1BcSH7rq4YcbURnOsEB3pDTzMpPo+g49VwM5dBrxWOaAJxPxHl2WR9lyx5NSJaYAdRpb927NKMBXyA/gM4vaVAXh0OpIyvZb/CD0S8bl+vut3ZfG2eD2FzHvKmWS2P03wmSk4QuRfGaTaZkiE6E1fvzFEO9N04rALCFMfbzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GuADFI18o0KXKDiWCuSx3xMN6F2cZZ/872AXtAZ4lkU=;
 b=Dg82q+k/vh9xtO4B7PG8zN7lGepioaBH7kyK7yrXPSUVATywwRbOvvfIrApKU1oWqUNaHN0cjGHJfYBjGNikou+gaDjkmS7A1kzcc9KGJK68MHxcn39lojVZrZ1++B6ylV8zGufC/XgPVdu3b8ihytUrCGp9+GPbDeTMYsHJDjTcu1SNT1o85h8D0M6HTTxcwKgZiXESXkhAUd0OwSbvceEkF8/eMHHdf7vVRmCh8o9W3BcaRhsMS/C6lytvS+XR2Hi59iKuh+ZCwTOwAwqrrhbeUIa08kWYHjhktZ4Lfza1fWTn3uvG4gm8p9368Kn445SMSEc1gm7B6KzJIXZ56w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GuADFI18o0KXKDiWCuSx3xMN6F2cZZ/872AXtAZ4lkU=;
 b=XaP1gEHrp2xfHIghqXjd+xv1h+28jRJqtR9KpXaeacEh9d4jcoHNwPoaPDJKu+efU6u0htXU/pIoYmdH1MzlfPrPpJS5k+W2hUAyN+6fj1SkRiIG7/m6ANrCwLgnmPXHPGNGTunUAtlRi3tlCDoQ0F9+8Q9qjTOns7G2tgTE+Kc=
Received: from DS7PR03CA0011.namprd03.prod.outlook.com (2603:10b6:5:3b8::16)
 by CYXPR12MB9337.namprd12.prod.outlook.com (2603:10b6:930:d8::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Wed, 4 Jun
 2025 19:38:18 +0000
Received: from DS3PEPF000099E1.namprd04.prod.outlook.com
 (2603:10b6:5:3b8:cafe::90) by DS7PR03CA0011.outlook.office365.com
 (2603:10b6:5:3b8::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.31 via Frontend Transport; Wed,
 4 Jun 2025 19:38:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099E1.mail.protection.outlook.com (10.167.17.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8792.29 via Frontend Transport; Wed, 4 Jun 2025 19:38:17 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 4 Jun
 2025 14:38:15 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Alex Hung <alex.hung@amd.com>, Charlene Liu
 <charlene.liu@amd.com>, Dmytro Laktyushkin <dmytro.laktyushkin@amd.com>
Subject: [PATCH 04/23] drm/amd/display: Add HW change required mpc gamut remap
Date: Wed, 4 Jun 2025 12:43:15 -0600
Message-ID: <20250604193659.2462225-5-alex.hung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250604193659.2462225-1-alex.hung@amd.com>
References: <20250604193659.2462225-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E1:EE_|CYXPR12MB9337:EE_
X-MS-Office365-Filtering-Correlation-Id: f118526a-fdc0-420e-ad4c-08dda39f5b08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?jCPQaE5KHST/KB483F9MgJUj1DZ+XFA4+ze0jD6oSe4kB3yYleWzi1s3tNJy?=
 =?us-ascii?Q?dXsWqQz/O7YhrImgFIes8YKYTkFlTLk8FercHvS05RoY3b6/n288h0z3jB+U?=
 =?us-ascii?Q?5L1CHThA3FHJCze7DdvFIlia/u1usntLwM2GG64XF60M7lm8PcyAYeVNw7lS?=
 =?us-ascii?Q?pvZ3Qgi8iqpN0QTK3/y0OX5s+2bbUDCZ4XJy0nwGuOjXcPYw9eK3PDzMHES2?=
 =?us-ascii?Q?DAJG11ldO3tJyioNcINwJbSDsDshA/NW3kDP6n7JbvslFUHbzy7ad4/RaN6b?=
 =?us-ascii?Q?rLndEO8xk7LsNPrOZNTUeXMqQSdItQ7i85MOKLa3CKl3Nwqyrzp2+MHCYeP4?=
 =?us-ascii?Q?o6R4RPmhzVLPImwvkWOO4FMJMK7oO9LAvPI5qcY/aiuFFEeynIIvJztvhjoG?=
 =?us-ascii?Q?DKCAwJ9exXAccGmYHn6YNrMVZFuzmRTSpnZ7qj++XrbBXTOMpefWtzQ0zkAP?=
 =?us-ascii?Q?F+Wp7qCUFw5RQOvmPNwTswKOipcAce9LwgQnYCmH560qCZN+9lHmLcx2xUEh?=
 =?us-ascii?Q?i7Ns+0WeO9bhd7Y/Dnct4a+OM13jwhByg+UIxcvSxcpbPfW9tdZn1bErYXrc?=
 =?us-ascii?Q?3ZYb3ME0lBZaC8vvm9Ov7ZbjYSfBUv1zWFL1A5TfeysI/fwEMY3Mzb272M96?=
 =?us-ascii?Q?f2eveR5Vh2SngiCIzgHq10v8Z8U94VMCLxUuKEvzPBQecABYn9rYeleadolm?=
 =?us-ascii?Q?bEW/8DKufyGm4sTV36AyJ1YDUtHVQ1v4WRho4k3ISNeUo2H5xTsrN2ryp+Kh?=
 =?us-ascii?Q?fEtsNQfxUF+nVXMFYa/hfHcnwQNghDgepdPHgDPAaY8BhhH/4xjW+IWxjvX6?=
 =?us-ascii?Q?WmaSErv8cKoKzIsRJKkNOdI1WHQPCLsBE1j3j1b5kbSQ9N8Y06b90uZC2gUE?=
 =?us-ascii?Q?NGI1aWFSAZeT55/rvQuUJ5OC0smUpXXSRvNfuu4LfemS66uWHlY/WobX7haF?=
 =?us-ascii?Q?SJd3qMKv7Ja5Kuk1wJB8vf4/V+rNEp653/6IUitDWgj1UlkEF/dS6gMl03YW?=
 =?us-ascii?Q?psSUjmDlzEsNTG2b2yPrvy46OSyCqEXskIllGAXKcqysJum81anLJAeW196a?=
 =?us-ascii?Q?FYcrABsDkcZRdYBwrrmx0yBd+Bp9iqFqBxT4uqm5tvlp14Zzz22nZdU8YSeH?=
 =?us-ascii?Q?5rgfvNxwbovodwW2CD6/EzEG2Kie0jCJyquk03PAxeWwLx/yBWqbzl/cCmED?=
 =?us-ascii?Q?hbRKrtTLKXiJc9Dj4Lzg+FZ5AvVVEK7QO0+uVPm317QgcbGRrGJnR1hCFevm?=
 =?us-ascii?Q?YmQvDhHCJUx1GvjCRcFu/Oe92ZBOZyxQBC0Yzv20tbF1Ks7X4rTr2eKCutOa?=
 =?us-ascii?Q?a3cO/T+jhR8VKSfanW+Am5EHnin0WTRnYRdknnyI8XO1a1llGaLGId7rzL//?=
 =?us-ascii?Q?G582N6sMa7s4GSe54groXYsXReiIq3y5ZAt+g467yQS4B480NXYoZozVAemD?=
 =?us-ascii?Q?CDPNPKNOTgN4hcet+MEsh75F2/WlOdz8X9Nm/4mh0/z30uJNNGPpIhqeh8WH?=
 =?us-ascii?Q?jJOldBbyMGPtV8OIHz0be51bWijNVO4ApTtV?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2025 19:38:17.8100 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f118526a-fdc0-420e-ad4c-08dda39f5b08
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099E1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9337
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

From: Charlene Liu <charlene.liu@amd.com>

[WHAT]
Add HW change to required mpc gamut remap

Reviewed-by: Dmytro Laktyushkin <dmytro.laktyushkin@amd.com>
Signed-off-by: Charlene Liu <charlene.liu@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_hw_types.h        |  3 ++-
 .../gpu/drm/amd/display/dc/mpc/dcn401/dcn401_mpc.c  | 10 +++++-----
 .../gpu/drm/amd/display/dc/mpc/dcn401/dcn401_mpc.h  | 13 +++++++++++++
 3 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_hw_types.h b/drivers/gpu/drm/amd/display/dc/dc_hw_types.h
index d562ddeca512..a0e99db61410 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_hw_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_hw_types.h
@@ -1103,7 +1103,8 @@ enum mpcc_gamut_remap_mode_select {
 enum mpcc_gamut_remap_id {
 	MPCC_OGAM_GAMUT_REMAP,
 	MPCC_MCM_FIRST_GAMUT_REMAP,
-	MPCC_MCM_SECOND_GAMUT_REMAP
+	MPCC_MCM_SECOND_GAMUT_REMAP,
+	MPCC_RMCM_GAMUT_REMAP,
 };
 
 enum cursor_matrix_mode {
diff --git a/drivers/gpu/drm/amd/display/dc/mpc/dcn401/dcn401_mpc.c b/drivers/gpu/drm/amd/display/dc/mpc/dcn401/dcn401_mpc.c
index 98cf0cbd59ba..99c10a7acbf3 100644
--- a/drivers/gpu/drm/amd/display/dc/mpc/dcn401/dcn401_mpc.c
+++ b/drivers/gpu/drm/amd/display/dc/mpc/dcn401/dcn401_mpc.c
@@ -294,7 +294,7 @@ void mpc401_program_3dlut_size(struct mpc *mpc, bool is_17x17x17, int mpcc_id)
 	REG_UPDATE(MPCC_MCM_3DLUT_MODE[mpcc_id], MPCC_MCM_3DLUT_SIZE, is_17x17x17 ? 0 : 1);
 }
 
-static void program_gamut_remap(
+void mpc_program_gamut_remap(
 	struct mpc *mpc,
 	unsigned int mpcc_id,
 	const uint16_t *regval,
@@ -426,7 +426,7 @@ void mpc401_set_gamut_remap(
 
 	if (adjust->gamut_adjust_type != GRAPHICS_GAMUT_ADJUST_TYPE_SW) {
 		/* Bypass / Disable if type is bypass or hw */
-		program_gamut_remap(mpc, mpcc_id, NULL,
+		mpc_program_gamut_remap(mpc, mpcc_id, NULL,
 			adjust->mpcc_gamut_remap_block_id, MPCC_GAMUT_REMAP_MODE_SELECT_0);
 	} else {
 		struct fixed31_32 arr_matrix[12];
@@ -460,12 +460,12 @@ void mpc401_set_gamut_remap(
 		else
 			mode_select = MPCC_GAMUT_REMAP_MODE_SELECT_2;
 
-		program_gamut_remap(mpc, mpcc_id, arr_reg_val,
+		mpc_program_gamut_remap(mpc, mpcc_id, arr_reg_val,
 			adjust->mpcc_gamut_remap_block_id, mode_select);
 	}
 }
 
-static void read_gamut_remap(struct mpc *mpc,
+void mpc_read_gamut_remap(struct mpc *mpc,
 	int mpcc_id,
 	uint16_t *regval,
 	enum mpcc_gamut_remap_id gamut_remap_block_id,
@@ -563,7 +563,7 @@ void mpc401_get_gamut_remap(struct mpc *mpc,
 	uint16_t arr_reg_val[12] = {0};
 	uint32_t mode_select;
 
-	read_gamut_remap(mpc, mpcc_id, arr_reg_val, adjust->mpcc_gamut_remap_block_id, &mode_select);
+	mpc_read_gamut_remap(mpc, mpcc_id, arr_reg_val, adjust->mpcc_gamut_remap_block_id, &mode_select);
 
 	if (mode_select == MPCC_GAMUT_REMAP_MODE_SELECT_0) {
 		adjust->gamut_adjust_type = GRAPHICS_GAMUT_ADJUST_TYPE_BYPASS;
diff --git a/drivers/gpu/drm/amd/display/dc/mpc/dcn401/dcn401_mpc.h b/drivers/gpu/drm/amd/display/dc/mpc/dcn401/dcn401_mpc.h
index 8e35ebc603a9..eb0c68d0b0c7 100644
--- a/drivers/gpu/drm/amd/display/dc/mpc/dcn401/dcn401_mpc.h
+++ b/drivers/gpu/drm/amd/display/dc/mpc/dcn401/dcn401_mpc.h
@@ -241,6 +241,19 @@ void mpc401_update_3dlut_fast_load_select(
 	int mpcc_id,
 	int hubp_idx);
 
+void mpc_program_gamut_remap(
+	struct mpc *mpc,
+	unsigned int mpcc_id,
+	const uint16_t *regval,
+	enum mpcc_gamut_remap_id gamut_remap_block_id,
+	enum mpcc_gamut_remap_mode_select mode_select);
+
+void mpc_read_gamut_remap(struct mpc *mpc,
+	int mpcc_id,
+	uint16_t *regval,
+	enum mpcc_gamut_remap_id gamut_remap_block_id,
+	uint32_t *mode_select);
+
 void mpc401_update_3dlut_fast_load_select(
 	struct mpc *mpc,
 	int mpcc_id,
-- 
2.43.0

