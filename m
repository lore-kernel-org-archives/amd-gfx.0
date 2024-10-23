Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C91E9D2E014
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Oct 2024 04:55:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 788A410E729;
	Wed, 23 Oct 2024 04:55:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mMwseq6E";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2053.outbound.protection.outlook.com [40.107.212.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D79910E729
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Oct 2024 04:55:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sdm/bU72eKbvFL4VCRE+8G5zLncJiW7VuZpbADIEpGDBk6nOUUREkasI9sZ2Az52hraiumzWS0fBP8XBwsSWFhKU5YhLtJT+FbP97r8p3FfKII3ZwTnqKF0nna19eem+372lVhpRiTpR0gguWAsMSEw4eJUa38gxJyl4HDM/5KKh17x+4X2uNftkwMFqt8eRq5K7IMwFSzQqkhgj0IhPfOrbyUpILVO+eMb0/dN/NkbHyFRPJeGvn/eL6bPFJTcM855JNsn8sxTkNeLA1Nm5B6t2fujfnv7AF+Vxsvuj2Ultqwd2G/d0DxXHxYkEx3sefL3/s/j2sEDQp2f3ts2khQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b337RgJ+RWngKqJO1HgFeO+B0xYwo2DtUSkN00mqAQ0=;
 b=ZeF3jlh3Q4DiCPTgBbAJ0KVQ//QWRA36OSUZdCue/cpWS7aq5+QtyipGBQHrZ3ig7559nb+P0r4X+tHQ2tvpuA+5RMk5rcGq7wFCyEFMNEg78bzitM7I4Gm8VQZlkO+hZAxr7raZSOpKdpumIIcctAnX5tiVLQBo1QIgRxb4KVAlXVY4oX/Ywwt0VhP36YTdJt4j9CQPF4mIJLKbFsahvqB1NGA0A3oApL5Syz8YyYDyuIPpyrh2gZPJQqm2QSbu/82/5F+em8fdR4i7YJa6j603Io7DFb3kXob6qvywcfO8EC/VZJhywIZoip7ZlyG+3EHlewUTHxQJbqM0pgXWRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b337RgJ+RWngKqJO1HgFeO+B0xYwo2DtUSkN00mqAQ0=;
 b=mMwseq6EZ/XSNuobeWj+al7JCNRKXPcg/qfgZqoIru0BNN5gdmJbN94gb9odyt32Xu6/hCVTdUgJd+zkxvsAmbP76Kpe/Ngn7O4vcJmIzrYwoGOSXnfwnmfMOa0LWZPnE1GA9ywh+K4BA8vGfP8EmKLB79L3EOaGzqM72Pd3xTk=
Received: from DS7PR03CA0083.namprd03.prod.outlook.com (2603:10b6:5:3bb::28)
 by DM4PR12MB6349.namprd12.prod.outlook.com (2603:10b6:8:a4::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.29; Wed, 23 Oct 2024 04:55:02 +0000
Received: from CY4PEPF0000EDD5.namprd03.prod.outlook.com
 (2603:10b6:5:3bb:cafe::e8) by DS7PR03CA0083.outlook.office365.com
 (2603:10b6:5:3bb::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.29 via Frontend
 Transport; Wed, 23 Oct 2024 04:55:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD5.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Wed, 23 Oct 2024 04:55:02 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 22 Oct
 2024 23:55:01 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 22 Oct
 2024 23:55:00 -0500
Received: from tom-r5.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 22 Oct 2024 23:54:57 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Hamza Mahfooz
 <hamza.mahfooz@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>, "Roman
 Li" <roman.li@amd.com>, Wayne Lin <wayne.lin@amd.com>, Tom Chung
 <chiahsuan.chung@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>, Zaeem Mohamed
 <zaeem.mohamed@amd.com>, Solomon Chiu <solomon.chiu@amd.com>, Daniel Wheeler
 <daniel.wheeler@amd.com>, Samson Tam <Samson.Tam@amd.com>, Ilya Bakoulin
 <ilya.bakoulin@amd.com>
Subject: [PATCH 14/16] drm/amd/display: store sharpness 1dlut table in
 dscl_prog_data
Date: Wed, 23 Oct 2024 12:53:34 +0800
Message-ID: <20241023045336.1557443-15-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241023045336.1557443-1-chiahsuan.chung@amd.com>
References: <20241023045336.1557443-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD5:EE_|DM4PR12MB6349:EE_
X-MS-Office365-Filtering-Correlation-Id: c4ae46f1-f9cc-40e5-c754-08dcf31edacc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?r0WltRLCVGYp3kdoVf9Gvi7di8+wSk1NyiNFK7PO/Gy/M4Y5bm5DBBAQSeaw?=
 =?us-ascii?Q?CPJNX3C2NRpHboRjMgst4+ECeoDFahNq1qOzEdU0j8VB7eZBJwazu9/1xy5z?=
 =?us-ascii?Q?+SQmgg3kVIfQQVGIkkCn2LFgzov9JL/axpB7xhL/Su8TOBnIIb0v1bcBJnii?=
 =?us-ascii?Q?hRje9IS5w6UC3m1bMZrYh1tjkUOj+ZMirxQ1qSzxpeQqcMpf3hSDG331WvNa?=
 =?us-ascii?Q?6KwhD1r8SG3E8w9k86ojJUL2obUbYRNORU+ksir+6PjXtlQnH0BY4G4UO6+L?=
 =?us-ascii?Q?eHzMsnLdI1PwGqqR69YI5Nm2EGRs1FrO4HKvtyjHyMOKsygnzkiFl7o1f9nA?=
 =?us-ascii?Q?KS/UHQszcmFqnTUT4TUQKhdG9SNLyT0nPS7aM5PbFtLPL7CeJa67ZOZ19+k8?=
 =?us-ascii?Q?2JPuskq7FW+Qjd2EYd80HCh5OCsalAcHBgY0czDvvtxFsvwAhEj82KYdga/4?=
 =?us-ascii?Q?lIVjmRBBJMPPL6wjPtrjJp0WRsQCcoa9OSFcC7F8OutpotpI2D29yKlXd6as?=
 =?us-ascii?Q?kp8d8HT7+5shcWS5qlhu6rj5XTxAGOaPgmwSlC3xwYbwZU/sYOp4b7WNUuOo?=
 =?us-ascii?Q?Nhhz+qctsZ+TVcYmztxyl2hvOTgP4Na3ZA2y4oYkU/XmpMk+9cXVUZFqSSuz?=
 =?us-ascii?Q?8XBCkEDVpZKukZ3xMeX1D2Oam1i/3pD9k4fL/PifLQSIWciAK/rNg5aB9F8W?=
 =?us-ascii?Q?SkgBQbRo99EG4WNQwqemm5CPogdMqBbCEPSlTpUwoEMchOVeil+gAFY+aGf9?=
 =?us-ascii?Q?li00lKQEik2onfUG3+Mn/aM5lxF9eckS/FFgu2BPf3x/Blfv70IKlHoLkXln?=
 =?us-ascii?Q?FiWVVaxDgjxbOB8VaOTdIeNyXzwtNmQx9bb1iA+l39M0HzshpMaqMbyD0v6R?=
 =?us-ascii?Q?52xr6AQdr09bIuB396Kr0Qh8hJT9BEoIW/CUcT7wF+n0tqaF+n5Aax8v8Udr?=
 =?us-ascii?Q?AF7gG089Kh5pnbMQtZ+uq0DIYTrA//BM7gAI40ejJAgjusKojV+68gF2KuHp?=
 =?us-ascii?Q?RqFFOAwfsw9xFOz23w1WD4kg0pvq5KtGqrbAtMPWJA6sXeuRDlP58OVtNmJC?=
 =?us-ascii?Q?To//573J3yTZfiZExHMu5P18aZzSFwD3Kfza+W9wYEnrK9msM0TxHOExQnay?=
 =?us-ascii?Q?Xro3ZqD0aYlBrr59cRcvUaaX6uG11RVFdJ8G9+r1TIH9vk7tvgybEB3Nnysc?=
 =?us-ascii?Q?T8B0BK0bE/UljjxTSULES1JYF2ZqKnqahzArOaUfMueJ2CSAHsRlKtk5JGEM?=
 =?us-ascii?Q?ZK7w/1FDl9yFJU2h2kuyFJxDG5FiqaxoakoohvbrF1hBZiCbWM+RVjE5+B5u?=
 =?us-ascii?Q?tBgZug58o7Hw6TyytXHYnl3lPj2rTMvWb/rflrkqaYDY1oDbi/DBkBW9Urau?=
 =?us-ascii?Q?agWsNwYFmr4uyMqeJmFwyHxqsPcn1ntRC7RbhvrfnazR4MYxUQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 04:55:02.3158 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c4ae46f1-f9cc-40e5-c754-08dcf31edacc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6349
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

From: Samson Tam <Samson.Tam@amd.com>

[Why]
Previously dscl_prog_data stored pointer to sharpness 1dlut table.
SPL had four pre-generated tables, one for each setup. This allowed
us to minimize number of times we had to recalculate table when
switching between setups.
However, with dual display, this becomes an issue because for a given
setup, we could have a different per app sharpness value than the
global sharpness value. So the pre-generated table will change
but both displays may point to the same table and one of them
will have the wrong sharpness setting.

[How]
Store the sharpness 1dlut table in dscl_prog_data. This ensures
that each display can have its own sharpness setting.

Reviewed-by: Ilya Bakoulin <ilya.bakoulin@amd.com>
Signed-off-by: Samson Tam <Samson.Tam@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp_dscl.c | 3 ++-
 drivers/gpu/drm/amd/display/dc/spl/dc_spl.c                 | 3 ++-
 drivers/gpu/drm/amd/display/dc/spl/dc_spl_isharp_filters.h  | 1 -
 drivers/gpu/drm/amd/display/dc/spl/dc_spl_types.h           | 3 ++-
 4 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp_dscl.c b/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp_dscl.c
index 5105fd580017..2f92e7d4981b 100644
--- a/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp_dscl.c
+++ b/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp_dscl.c
@@ -1091,7 +1091,8 @@ void dpp401_dscl_set_scaler_manual_scale(struct dpp *dpp_base,
 		/* ISHARP_DELTA_LUT */
 		dpp401_dscl_set_isharp_filter(dpp, scl_data->dscl_prog_data.isharp_delta);
 		dpp->scl_data.dscl_prog_data.sharpness_level = scl_data->dscl_prog_data.sharpness_level;
-		dpp->scl_data.dscl_prog_data.isharp_delta = scl_data->dscl_prog_data.isharp_delta;
+		memcpy(dpp->scl_data.dscl_prog_data.isharp_delta, scl_data->dscl_prog_data.isharp_delta,
+			sizeof(uint32_t) * ISHARP_LUT_TABLE_SIZE);
 
 		if (memcmp(&dpp->scl_data, scl_data, sizeof(*scl_data)) == 0)
 			return;
diff --git a/drivers/gpu/drm/amd/display/dc/spl/dc_spl.c b/drivers/gpu/drm/amd/display/dc/spl/dc_spl.c
index 403fd1221803..133906e73a65 100644
--- a/drivers/gpu/drm/amd/display/dc/spl/dc_spl.c
+++ b/drivers/gpu/drm/amd/display/dc/spl/dc_spl.c
@@ -1607,7 +1607,8 @@ static void spl_set_isharp_data(struct dscl_prog_data *dscl_prog_data,
 
 	spl_build_isharp_1dlut_from_reference_curve(ratio, setup, adp_sharpness,
 		scale_to_sharpness_policy);
-	dscl_prog_data->isharp_delta = spl_get_pregen_filter_isharp_1D_lut(setup);
+	memcpy(dscl_prog_data->isharp_delta, spl_get_pregen_filter_isharp_1D_lut(setup),
+		sizeof(uint32_t) * ISHARP_LUT_TABLE_SIZE);
 	dscl_prog_data->sharpness_level = adp_sharpness.sharpness_level;
 
 	dscl_prog_data->isharp_en = 1;	// ISHARP_EN
diff --git a/drivers/gpu/drm/amd/display/dc/spl/dc_spl_isharp_filters.h b/drivers/gpu/drm/amd/display/dc/spl/dc_spl_isharp_filters.h
index afcc66206ca2..89af91e19b6c 100644
--- a/drivers/gpu/drm/amd/display/dc/spl/dc_spl_isharp_filters.h
+++ b/drivers/gpu/drm/amd/display/dc/spl/dc_spl_isharp_filters.h
@@ -7,7 +7,6 @@
 
 #include "dc_spl_types.h"
 
-#define ISHARP_LUT_TABLE_SIZE 32
 const uint32_t *spl_get_filter_isharp_1D_lut_0(void);
 const uint32_t *spl_get_filter_isharp_1D_lut_0p5x(void);
 const uint32_t *spl_get_filter_isharp_1D_lut_1p0x(void);
diff --git a/drivers/gpu/drm/amd/display/dc/spl/dc_spl_types.h b/drivers/gpu/drm/amd/display/dc/spl/dc_spl_types.h
index fcb5d389592b..8b00ccb1dfda 100644
--- a/drivers/gpu/drm/amd/display/dc/spl/dc_spl_types.h
+++ b/drivers/gpu/drm/amd/display/dc/spl/dc_spl_types.h
@@ -250,6 +250,7 @@ enum isharp_en	{
 	ISHARP_DISABLE,
 	ISHARP_ENABLE
 };
+#define ISHARP_LUT_TABLE_SIZE 32
 // Below struct holds values that can be directly used to program
 // hardware registers. No conversion/clamping is required
 struct dscl_prog_data {
@@ -400,7 +401,7 @@ struct dscl_prog_data {
 	uint32_t isharp_nl_en;  //      ISHARP_NL_EN ? TODO:check this
 	struct isharp_lba isharp_lba;   //      ISHARP_LBA
 	struct isharp_fmt isharp_fmt;   //      ISHARP_FMT
-	const uint32_t *isharp_delta;
+	uint32_t isharp_delta[ISHARP_LUT_TABLE_SIZE];
 	struct isharp_nldelta_sclip isharp_nldelta_sclip;       //      ISHARP_NLDELTA_SCLIP
 	/* blur and scale filter */
 	const uint16_t *filter_blur_scale_v;
-- 
2.34.1

