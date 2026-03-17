Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18603FD7099
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Mar 2026 20:13:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A24C910E5F6;
	Tue, 17 Mar 2026 20:13:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="i6qJHt3j";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011007.outbound.protection.outlook.com [40.107.208.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB54C10E5E5
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Mar 2026 20:13:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pZqRNWaDKvLdzdoCfrTE0jTDcjdO3oOTvupPPcpz48SPlg/VR37Z3b0DY+KxkaIRrVZIr7qdnn/LdXNU/Yxap9+m1H+u/mBN1a3AT4rstvD/3Ok2WrradYQyBvm9UOfZb+PbQWYWPNA9uf0Y7P4ZbHzVjr+y1oqSA7VXlL525D3ii5BaQp7DzbQEU1y2gB60hRtW47TfqhRnswwPCWSA9EjFvZpERUdfdFxRdt9Of5tl+6Sr+rpBvfdiR7WMDMwmXQiA/nfN4bv/TSVbxZ54+SP14Cpen0l+hq61d+TMBo4qdc2wlVnz5YrjE3TVPxVvQWCbcuRLCBL9H0wjEFu/tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oXGrbgi7fwhLbbO7R3vcW63/VFbJqJ5KhRLGuRguTJc=;
 b=vIqPhRVX6itofJh3ek1WWdTebLphnt2RWQJrgk+Nx8/Ttgy64pjzXvutYHURIt2U8symZi7RVgy/MKwPVQK6cGTe0DiXtkry+fBYZ0qEgmCXs7tegsuO2QsHALmy18+Ha2MXirEqX2NjwLE3bLEuhg5WSOu36rd9nquEV9Ehg0JG2wQAWhT+yxDb7BXmojcT4hoC0wVkbRW5dymWs7hlWNL5e9xZx3et2CbqcZu/y5EceFxRYExRsqG3YxKiMfWO9/SkNUJJzD/webiVB2xdMqNx4fJkbiWKI9e85mwhYTXFhUNFzRLRzgg8RipYGiDfFIa6ATGBz0o4GJnNNA5D9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oXGrbgi7fwhLbbO7R3vcW63/VFbJqJ5KhRLGuRguTJc=;
 b=i6qJHt3jmOJtPji+XENcIuDPvzNMXFebtpDZGw0RhEQ05UUWveJPdLOUuznAAnPO9NEvLOtNKCizEIPVoWHPnQ2LD3CXqfMDjyJqNNTOTNJdliibjxJiSHh1SAZQ6l1DZgiYF9iwbIS/Gh7f7Ai6BKZ7nxOMZVHwYdI/4Mod+IQ=
Received: from PH2PEPF0000385F.namprd17.prod.outlook.com (2603:10b6:518:1::6d)
 by DM4PR12MB6661.namprd12.prod.outlook.com (2603:10b6:8:b7::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19; Tue, 17 Mar 2026 20:13:04 +0000
Received: from CY4PEPF0000EE3A.namprd03.prod.outlook.com
 (2a01:111:f403:f910::2) by PH2PEPF0000385F.outlook.office365.com
 (2603:1036:903:48::3) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.25 via Frontend Transport; Tue,
 17 Mar 2026 20:13:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EE3A.mail.protection.outlook.com (10.167.242.12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Tue, 17 Mar 2026 20:13:03 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 17 Mar
 2026 15:13:00 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 17 Mar
 2026 15:13:00 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 17 Mar 2026 15:13:00 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Asad Kamal <asad.kamal@amd.com>, Lijo Lazar <lijo.lazar@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
Subject: [PATCH 08/25] drm/amd/pm: Update dpm table structs for smu_v15_0
Date: Tue, 17 Mar 2026 16:12:24 -0400
Message-ID: <20260317201242.3808136-8-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260317201242.3808136-1-alexander.deucher@amd.com>
References: <20260317201242.3808136-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3A:EE_|DM4PR12MB6661:EE_
X-MS-Office365-Filtering-Correlation-Id: cb973cfb-fb0b-437e-71be-08de84619894
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|82310400026|1800799024|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: jQtkkytneAR47hLFD6LnuoGid8L2AWOX5cmG18VtN/BzOUoik4yMPZZRcIaI7wyUzN66gugh0doxd7U3bxKUnodQIxkjaStqAalwujdjMU458OBOzFLIG/se+qUrQnLurLcM/dLTc8v2raFrnmTUs7w4epdIvAVdSjBrhvK4MXF3kpVqIV1K7zDd/UJP7/+EbuCQaz9ohRq0ENA6DqXTNiK7QCVBsUqKPtovVOZtcSLHJHmNqlioGlaDbDHVjD2csgO9EVcCV0r8pr8gNIKfyNXx3Ff7DDd+JTs4rZNCie7klDDQM9sUwyjVNL2385Kh8EVelQe0i6XGv5LMefetcPGEdaQo9vn2r8WLGEBkl1KY83buuyHfrdaJRqnJ/82Z3Bjblj7WNWgUGCrQkaqjNXKB6CdTfgDtIdTQM5djSC+W0c3HDGJBV/Hef01Z3rwsUYZ+xwozHRI5d9bJW8Gs6PO948JCI8jHpZB5x45XwvIBafsBzoFsH+vYrmyGrcR1fLuc4IZ/r2HLzR1SAbDDsWmhJkrq321C0vMJ8HJOQ0QevmAQYZWQQWolGPOQ/Nbi3xsLv2WVXkEAP4ki/amIPuj0rlWaSqZP+L12dCZwDJ7ls3OlHvFDoS5Gf5Uvj0y0YpKtJarTrN3gf+9nglAj/1UhIyGvavzVUdlYKLvTmTPqNqXdQ87F8p8dHRp2Qnhg4TdGWR+MQQH8nXk2pNwhhKZtiy6FtYICeeZnYg7OdhUHDg0CvW31iVKcRVMugiZqZDfbPuu6NQR7Oy+EX+3IIg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Jp7tyWUzvD6ln+Lno1pwOg93NzMRSHc4zczHVsgpiwNopOokLg2jyqGgLVSnKQgHcWQ5wJK6tZKYpD4j9yaUH6ywYJt9INd0VwnM6A0EvuUShUaJdEPTMRnf22e0I3Fhiig0rh2vOac6kc3Y+3z/OS3BDzWRaJHLegopphixGkTjX5tI/pfXH8jU801lC+olnk11uB5sYK/AncNGmKafowAWNgUidByH5dg9iUHhvnwgurgkhx/rj5+/YdCY1NSYtWXLyNDBsPT9ocna103S/3+SBjaA9IeZSBq8UcOO1yQaaDEkUpPzBARu4IRu0Oj87LQdC306Go95+6Ibcz/AwRAFnxcKUyR4is5TBTNlwGRbTGiFxyN7sadmBNSFCCKYyZg9Qv2XzeVc5X3+dIgO64qjoQjEQ/TKn1Ty0xbkNH6EXtKv9eOzfBqLQ0udlDHU
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 20:13:03.8823 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb973cfb-fb0b-437e-71be-08de84619894
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3A.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6661
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

From: Asad Kamal <asad.kamal@amd.com>

Update dpm table structs to use common definitions for smu_15_0

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v15_0.h  | 47 +++--------
 .../gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c    | 79 +++++++++----------
 2 files changed, 49 insertions(+), 77 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v15_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v15_0.h
index 06842d38c92bd..3c8c086f0f9d8 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v15_0.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v15_0.h
@@ -45,7 +45,6 @@
 
 #define FEATURE_MASK(feature) (1ULL << feature)
 
-#define MAX_DPM_LEVELS 16
 #define MAX_PCIE_CONF 3
 
 #define SMU15_TOOL_SIZE			0x19000
@@ -69,39 +68,19 @@ struct smu_15_0_max_sustainable_clocks {
 	uint32_t soc_clock;
 };
 
-struct smu_15_0_dpm_clk_level {
-	bool				enabled;
-	uint32_t			value;
-};
-
-struct smu_15_0_dpm_table {
-	uint32_t			min;        /* MHz */
-	uint32_t			max;        /* MHz */
-	uint32_t			count;
-	bool				is_fine_grained;
-	struct smu_15_0_dpm_clk_level	dpm_levels[MAX_DPM_LEVELS];
-};
-
-struct smu_15_0_pcie_table {
-	uint8_t  pcie_gen[MAX_PCIE_CONF];
-	uint8_t  pcie_lane[MAX_PCIE_CONF];
-	uint16_t clk_freq[MAX_PCIE_CONF];
-	uint32_t num_of_link_levels;
-};
-
 struct smu_15_0_dpm_tables {
-	struct smu_15_0_dpm_table        soc_table;
-	struct smu_15_0_dpm_table        gfx_table;
-	struct smu_15_0_dpm_table        uclk_table;
-	struct smu_15_0_dpm_table        eclk_table;
-	struct smu_15_0_dpm_table        vclk_table;
-	struct smu_15_0_dpm_table        dclk_table;
-	struct smu_15_0_dpm_table        dcef_table;
-	struct smu_15_0_dpm_table        pixel_table;
-	struct smu_15_0_dpm_table        display_table;
-	struct smu_15_0_dpm_table        phy_table;
-	struct smu_15_0_dpm_table        fclk_table;
-	struct smu_15_0_pcie_table       pcie_table;
+	struct smu_dpm_table        soc_table;
+	struct smu_dpm_table        gfx_table;
+	struct smu_dpm_table        uclk_table;
+	struct smu_dpm_table        eclk_table;
+	struct smu_dpm_table        vclk_table;
+	struct smu_dpm_table        dclk_table;
+	struct smu_dpm_table        dcef_table;
+	struct smu_dpm_table        pixel_table;
+	struct smu_dpm_table        display_table;
+	struct smu_dpm_table        phy_table;
+	struct smu_dpm_table        fclk_table;
+	struct smu_pcie_table       pcie_table;
 };
 
 struct smu_15_0_dpm_context {
@@ -204,7 +183,7 @@ int smu_v15_0_set_power_source(struct smu_context *smu,
 
 int smu_v15_0_set_single_dpm_table(struct smu_context *smu,
 				   enum smu_clk_type clk_type,
-				   struct smu_15_0_dpm_table *single_dpm_table);
+				   struct smu_dpm_table *single_dpm_table);
 
 int smu_v15_0_gfx_ulv_control(struct smu_context *smu,
 			      bool enablement);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c
index 51d1f5d42ad31..a9417cb4e920b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c
@@ -1059,18 +1059,12 @@ int smu_v15_0_set_performance_level(struct smu_context *smu,
 {
 	struct smu_15_0_dpm_context *dpm_context =
 		smu->smu_dpm.dpm_context;
-	struct smu_15_0_dpm_table *gfx_table =
-		&dpm_context->dpm_tables.gfx_table;
-	struct smu_15_0_dpm_table *mem_table =
-		&dpm_context->dpm_tables.uclk_table;
-	struct smu_15_0_dpm_table *soc_table =
-		&dpm_context->dpm_tables.soc_table;
-	struct smu_15_0_dpm_table *vclk_table =
-		&dpm_context->dpm_tables.vclk_table;
-	struct smu_15_0_dpm_table *dclk_table =
-		&dpm_context->dpm_tables.dclk_table;
-	struct smu_15_0_dpm_table *fclk_table =
-		&dpm_context->dpm_tables.fclk_table;
+	struct smu_dpm_table *gfx_table = &dpm_context->dpm_tables.gfx_table;
+	struct smu_dpm_table *mem_table = &dpm_context->dpm_tables.uclk_table;
+	struct smu_dpm_table *soc_table = &dpm_context->dpm_tables.soc_table;
+	struct smu_dpm_table *vclk_table = &dpm_context->dpm_tables.vclk_table;
+	struct smu_dpm_table *dclk_table = &dpm_context->dpm_tables.dclk_table;
+	struct smu_dpm_table *fclk_table = &dpm_context->dpm_tables.fclk_table;
 	struct smu_umd_pstate_table *pstate_table =
 		&smu->pstate_table;
 	struct amdgpu_device *adev = smu->adev;
@@ -1085,34 +1079,34 @@ int smu_v15_0_set_performance_level(struct smu_context *smu,
 
 	switch (level) {
 	case AMD_DPM_FORCED_LEVEL_HIGH:
-		sclk_min = sclk_max = gfx_table->max;
-		mclk_min = mclk_max = mem_table->max;
-		socclk_min = socclk_max = soc_table->max;
-		vclk_min = vclk_max = vclk_table->max;
-		dclk_min = dclk_max = dclk_table->max;
-		fclk_min = fclk_max = fclk_table->max;
+		sclk_min = sclk_max = SMU_DPM_TABLE_MAX(gfx_table);
+		mclk_min = mclk_max = SMU_DPM_TABLE_MAX(mem_table);
+		socclk_min = socclk_max = SMU_DPM_TABLE_MAX(soc_table);
+		vclk_min = vclk_max = SMU_DPM_TABLE_MAX(vclk_table);
+		dclk_min = dclk_max = SMU_DPM_TABLE_MAX(dclk_table);
+		fclk_min = fclk_max = SMU_DPM_TABLE_MAX(fclk_table);
 		break;
 	case AMD_DPM_FORCED_LEVEL_LOW:
-		sclk_min = sclk_max = gfx_table->min;
-		mclk_min = mclk_max = mem_table->min;
-		socclk_min = socclk_max = soc_table->min;
-		vclk_min = vclk_max = vclk_table->min;
-		dclk_min = dclk_max = dclk_table->min;
-		fclk_min = fclk_max = fclk_table->min;
+		sclk_min = sclk_max = SMU_DPM_TABLE_MIN(gfx_table);
+		mclk_min = mclk_max = SMU_DPM_TABLE_MIN(mem_table);
+		socclk_min = socclk_max = SMU_DPM_TABLE_MIN(soc_table);
+		vclk_min = vclk_max = SMU_DPM_TABLE_MIN(vclk_table);
+		dclk_min = dclk_max = SMU_DPM_TABLE_MIN(dclk_table);
+		fclk_min = fclk_max = SMU_DPM_TABLE_MIN(fclk_table);
 		break;
 	case AMD_DPM_FORCED_LEVEL_AUTO:
-		sclk_min = gfx_table->min;
-		sclk_max = gfx_table->max;
-		mclk_min = mem_table->min;
-		mclk_max = mem_table->max;
-		socclk_min = soc_table->min;
-		socclk_max = soc_table->max;
-		vclk_min = vclk_table->min;
-		vclk_max = vclk_table->max;
-		dclk_min = dclk_table->min;
-		dclk_max = dclk_table->max;
-		fclk_min = fclk_table->min;
-		fclk_max = fclk_table->max;
+		sclk_min = SMU_DPM_TABLE_MIN(gfx_table);
+		sclk_max = SMU_DPM_TABLE_MAX(gfx_table);
+		mclk_min = SMU_DPM_TABLE_MIN(mem_table);
+		mclk_max = SMU_DPM_TABLE_MAX(mem_table);
+		socclk_min = SMU_DPM_TABLE_MIN(soc_table);
+		socclk_max = SMU_DPM_TABLE_MAX(soc_table);
+		vclk_min = SMU_DPM_TABLE_MIN(vclk_table);
+		vclk_max = SMU_DPM_TABLE_MAX(vclk_table);
+		dclk_min = SMU_DPM_TABLE_MIN(dclk_table);
+		dclk_max = SMU_DPM_TABLE_MAX(dclk_table);
+		fclk_min = SMU_DPM_TABLE_MIN(fclk_table);
+		fclk_max = SMU_DPM_TABLE_MAX(fclk_table);
 		auto_level = true;
 		break;
 	case AMD_DPM_FORCED_LEVEL_PROFILE_STANDARD:
@@ -1334,10 +1328,11 @@ static int smu_v15_0_get_fine_grained_status(struct smu_context *smu,
 
 int smu_v15_0_set_single_dpm_table(struct smu_context *smu,
 				   enum smu_clk_type clk_type,
-				   struct smu_15_0_dpm_table *single_dpm_table)
+				   struct smu_dpm_table *single_dpm_table)
 {
 	int ret = 0;
 	uint32_t clk;
+	bool is_fine_grained;
 	int i;
 
 	ret = smu_v15_0_get_dpm_level_count(smu,
@@ -1350,12 +1345,15 @@ int smu_v15_0_set_single_dpm_table(struct smu_context *smu,
 
 	ret = smu_v15_0_get_fine_grained_status(smu,
 						clk_type,
-						&single_dpm_table->is_fine_grained);
+						&is_fine_grained);
 	if (ret) {
 		dev_err(smu->adev->dev, "[%s] failed to get fine grained status!\n", __func__);
 		return ret;
 	}
 
+	if (is_fine_grained)
+		single_dpm_table->flags |= SMU_DPM_TABLE_FINE_GRAINED;
+
 	for (i = 0; i < single_dpm_table->count; i++) {
 		ret = smu_v15_0_get_dpm_freq_by_index(smu,
 						      clk_type,
@@ -1368,11 +1366,6 @@ int smu_v15_0_set_single_dpm_table(struct smu_context *smu,
 
 		single_dpm_table->dpm_levels[i].value = clk;
 		single_dpm_table->dpm_levels[i].enabled = true;
-
-		if (i == 0)
-			single_dpm_table->min = clk;
-		else if (i == single_dpm_table->count - 1)
-			single_dpm_table->max = clk;
 	}
 
 	return 0;
-- 
2.53.0

