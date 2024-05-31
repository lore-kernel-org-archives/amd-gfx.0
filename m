Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6985CC27C51
	for <amd-gfx@archiver.kernel.org>; Fri, 31 May 2024 16:53:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C5E6010E2D5;
	Fri, 31 May 2024 16:53:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TWL9utOB";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2062.outbound.protection.outlook.com [40.107.93.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B233C10E583
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 May 2024 16:52:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G3HXUi7NQ/UJyrxJmJlt+zqJDGhe0nksbfuyuMCeXEPqM1jTTvDgbkJZW4gZMO5xx4jYB+nFZuWn6JJVRKftDEbYobYlCjE4LL0yMRJyZGnBjA10MC7EAlIs9ufwoAr2KYLI3PItpmUvLix+pFW1Sy+PQWKDxbN0gjSSqlKFQqE9rXbRdQmXEc3G+AE7mskIWzIwkzB681Zzx15NKc3fpvQmEpIjnTIZckj72ms1DDAHkDC9grWNY7b3liV7P9sBOgpB/99RyrSU4rB2kjPW/NzfNfCGCtiQM0USfnQ+tSPFtNS8inM5blepD+BZKNI366Y9UTowpZGUthuVc3P36Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jWLC9Eeptdz+chgZNNF/A2/Tt2RHg9lgdqbkGoY4PZU=;
 b=jomaWJtC807CQppZgITu185Satxvt9VmKAqyh7dzD4zm99o2KQpiTupFPUtPEZF/ANc0lljWOCd6zLU5ijRKY/uqp2bK5V5FdBUVETVtX2tqEVFKpB1hzcwgD34JJ3Q+TBs36Mik/QTDJI/zA8RTd+CLTci2G3QrOrXKrgq8jy+mXBegIebOUzPhNxy3HWCrYzJBj92IpxR5YIx+zNplmoaNRWCg6+o8+aGZNkBICbvDUJcr8xeMXoGhRA3yNivlxNUZuh5EqriDQHZKfH8mY2hI+R13ma2keUPcLUAd8wHA0TycO11+kKectDN7AQCXFcDVEiPcZ2cf8BqNTYSYxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jWLC9Eeptdz+chgZNNF/A2/Tt2RHg9lgdqbkGoY4PZU=;
 b=TWL9utOBhEoZDXZp/PFqake5z1H+TxiAeKWqgIn8yG60KYeqD/chevukeDjD64wPyGgVMi+zv3rZzqa5al+bg8j4rVAt+Uk5bhib1Yhou+M70n2ipYk/moE+xtFikBy1B74ZOCMi8sfEbg6n+fTNSLdnvVZIE2u2N3PKPifAJ28=
Received: from PH7PR10CA0013.namprd10.prod.outlook.com (2603:10b6:510:23d::9)
 by DS0PR12MB7606.namprd12.prod.outlook.com (2603:10b6:8:13c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.19; Fri, 31 May
 2024 16:52:48 +0000
Received: from CY4PEPF0000EE3D.namprd03.prod.outlook.com
 (2603:10b6:510:23d:cafe::d5) by PH7PR10CA0013.outlook.office365.com
 (2603:10b6:510:23d::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21 via Frontend
 Transport; Fri, 31 May 2024 16:52:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3D.mail.protection.outlook.com (10.167.242.15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Fri, 31 May 2024 16:52:48 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 31 May
 2024 11:52:45 -0500
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, ChunTao Tso <chuntao.tso@amd.com>, Robin Chen
 <robin.chen@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>
Subject: [PATCH 26/32] drm/amd/display: Introduce deferred Replay coasting
 vtotal update
Date: Fri, 31 May 2024 12:51:39 -0400
Message-ID: <20240531165145.1874966-27-zaeem.mohamed@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240531165145.1874966-1-zaeem.mohamed@amd.com>
References: <20240531165145.1874966-1-zaeem.mohamed@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3D:EE_|DS0PR12MB7606:EE_
X-MS-Office365-Filtering-Correlation-Id: e71209f2-9790-48c3-528f-08dc81921a4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|376005|1800799015|82310400017|36860700004; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?dgCcI59rfaWoPPxdzQJjFsnJSFeXCi7/XepdT4Msl/BHIvv/UTpvxDjrGEP4?=
 =?us-ascii?Q?gb9DAc9Llafkh/rJtZ1es0eCIEZrJ6DOIexLHwxAQClBJAl4LGDCKh+E1KlA?=
 =?us-ascii?Q?CyjPWXCUtv9GtGVBjvMeTKY+IH0ENtYSD1DzYu2AmQluc5j85Fmg1YtjGc6l?=
 =?us-ascii?Q?CPiNiP8uLuab90gY1HKy1tW4bKIOlKPCpbV40MxQUk2T5MV8EdlDLXd4L0oX?=
 =?us-ascii?Q?BXhd3EEuEr1pumvgf4wcsEj0mla5tWW1Q/YqoWQs9eEYMu1s9lKPuKNTiHrh?=
 =?us-ascii?Q?8nHjEq/K7Gh9glELfaH73/yu7Ibp+PJ1zDbqCOyzBY4xs5Mb7MvNFLjzBLnt?=
 =?us-ascii?Q?gSzG1zCADy8fnCw5wqUeJN8j7qmswZEoXVWmPeakXITxsxVSov6vrIGFObV8?=
 =?us-ascii?Q?Eby1/IGQTDGdGvWi0yHpL4s+v/HbR2Gl650FXlWY55dAKjZPArqjobKwxiRY?=
 =?us-ascii?Q?o2PVKybgMhsASx5nG9AGldWmftlPO0wnnz/rf6HXOWbX0ZKStgidfsLKKGv3?=
 =?us-ascii?Q?gcI0MO3GVxD/5talTssYrf023N2ND0HGTcOw3ptWejyv4VzNjAiIzpNGQHaU?=
 =?us-ascii?Q?vjQVBjAF0sjJklbcSsjGKQl1AP4u4iQftI29MuKfaCttNwWdhb/gvbdBu/uL?=
 =?us-ascii?Q?rWPyPcakiIGTArKGOn9qw679H7GzTvFX1e9Hqt3rkFWBVz0cLixwhido4Oda?=
 =?us-ascii?Q?hKOQza/vd78pAO/BY++lAyAYWnemD0qUJ+T8pwM2j/PEMphxKaEp4vBCaRqZ?=
 =?us-ascii?Q?PQKKyjwyfmUNH5RESx3JN2Q/8mxQqyQHBOBIHI8i6fYTI16npx2bC2ysLq6a?=
 =?us-ascii?Q?ZBWmsN6CdiVTDEr/gWENI2FfRRu5mxzdwXYHEKS2YbZR847h6auV8Iycr1Wt?=
 =?us-ascii?Q?qRPpXVFwoagFDRblKoPYzFa0f7/9MwiiSm+jSyLjOrOLA8xkYh+FfD2ZSBjj?=
 =?us-ascii?Q?JCcyoExUxtQFYuDoLiUUi9OudY9oqCdeMOD4qmi9zx6QZs6inXvy9IE08olh?=
 =?us-ascii?Q?1uUFvlsbOP7rcbfJ3LTQKLvyWs6MlBp+9NiGCiKT7U7Q4b+tjq4mUcnK2tDU?=
 =?us-ascii?Q?8tJuQ8mBCm41ml0N8WQGJeTEPfeJhWbJUI7uzzHheB0wP6HG3WIHfEAGXsj/?=
 =?us-ascii?Q?neHkaaPHAxB6dW1DyT5l0MpIGPXm4eYzDMiWkfjZCYEcshckv/0sSKxsJfcq?=
 =?us-ascii?Q?vMVK+EPvX44xxDLHk8gZAMvP4nE8PYX9ALFBxrLLxgAXHRBGOurs1LoavRAl?=
 =?us-ascii?Q?fcKB23IIylSBzI86eED3F5vVe4k71oeUQib1O+DJo4BPn7UwQeHSGBkdt4Cb?=
 =?us-ascii?Q?L64fUadrQc9vLDM7WaM7N6OuosnPhaa8oCQ3uQDIlJGXODqkFiLpRRrdO0fp?=
 =?us-ascii?Q?5em9fOA=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(82310400017)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2024 16:52:48.4960 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e71209f2-9790-48c3-528f-08dc81921a4a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7606
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

From: ChunTao Tso <chuntao.tso@amd.com>

Add functions to defer updating of coasting vtotal after source refresh rate update.

Reviewed-by: Robin Chen <robin.chen@amd.com>
Acked-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
Signed-off-by: ChunTao Tso <chuntao.tso@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_types.h          |  2 ++
 .../drm/amd/display/modules/power/power_helpers.c  | 14 ++++++++++++++
 .../drm/amd/display/modules/power/power_helpers.h  |  5 +++++
 3 files changed, 21 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_types.h b/drivers/gpu/drm/amd/display/dc/dc_types.h
index cee012587e6e..21f4af9ab096 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_types.h
@@ -1091,6 +1091,8 @@ struct replay_settings {
 	uint32_t coasting_vtotal;
 	/* Coasting vtotal table */
 	uint32_t coasting_vtotal_table[PR_COASTING_TYPE_NUM];
+	/* Defer Update Coasting vtotal table */
+	uint32_t defer_update_coasting_vtotal_table[PR_COASTING_TYPE_NUM];
 	/* Maximum link off frame count */
 	uint32_t link_off_frame_count;
 	/* Replay pseudo vtotal for abm + ips on full screen video which can improve ips residency */
diff --git a/drivers/gpu/drm/amd/display/modules/power/power_helpers.c b/drivers/gpu/drm/amd/display/modules/power/power_helpers.c
index 530379508a69..3cd52e7a9c77 100644
--- a/drivers/gpu/drm/amd/display/modules/power/power_helpers.c
+++ b/drivers/gpu/drm/amd/display/modules/power/power_helpers.c
@@ -973,6 +973,20 @@ bool psr_su_set_dsc_slice_height(struct dc *dc, struct dc_link *link,
 	return true;
 }
 
+void set_replay_defer_update_coasting_vtotal(struct dc_link *link,
+	enum replay_coasting_vtotal_type type,
+	uint32_t vtotal)
+{
+	link->replay_settings.defer_update_coasting_vtotal_table[type] = vtotal;
+}
+
+void update_replay_coasting_vtotal_from_defer(struct dc_link *link,
+	enum replay_coasting_vtotal_type type)
+{
+	link->replay_settings.coasting_vtotal_table[type] =
+		link->replay_settings.defer_update_coasting_vtotal_table[type];
+}
+
 void set_replay_coasting_vtotal(struct dc_link *link,
 	enum replay_coasting_vtotal_type type,
 	uint32_t vtotal)
diff --git a/drivers/gpu/drm/amd/display/modules/power/power_helpers.h b/drivers/gpu/drm/amd/display/modules/power/power_helpers.h
index ff7e6f3cd6be..cac302e8fa10 100644
--- a/drivers/gpu/drm/amd/display/modules/power/power_helpers.h
+++ b/drivers/gpu/drm/amd/display/modules/power/power_helpers.h
@@ -57,6 +57,11 @@ void init_replay_config(struct dc_link *link, struct replay_config *pr_config);
 void set_replay_coasting_vtotal(struct dc_link *link,
 	enum replay_coasting_vtotal_type type,
 	uint32_t vtotal);
+void set_replay_defer_update_coasting_vtotal(struct dc_link *link,
+	enum replay_coasting_vtotal_type type,
+	uint32_t vtotal);
+void update_replay_coasting_vtotal_from_defer(struct dc_link *link,
+	enum replay_coasting_vtotal_type type);
 void set_replay_ips_full_screen_video_src_vtotal(struct dc_link *link, uint16_t vtotal);
 void calculate_replay_link_off_frame_count(struct dc_link *link,
 	uint16_t vtotal, uint16_t htotal);
-- 
2.34.1

