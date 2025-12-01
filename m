Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 849B1D116F8
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Dec 2025 10:14:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0EF8110E369;
	Mon,  1 Dec 2025 10:14:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FkOIKfIg";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011059.outbound.protection.outlook.com [52.101.52.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 297EE10E364
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Dec 2025 10:14:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EXA0gXDgsFY6Bvcy0vFIvyJur7wYj/pSx6gaaL9LPxSE1vqqIJuV8GLJCGo4lLmHL8+z0QWdBjydiBqyGccl6LskLCtESK6zuquEertOzpBRMri+2lmsWnpCWrxXiZzMuX7YFZnmXwpN3nDLics7vy8b5N5BJC3Gd3uUbeESUQYjJrrGq59QUTRrBLpdEpooG64HpDhjllImI0ulDD0fjwtEWZh2AT8TA0L3wntRxjkGaz9SYg8kXnT6Lx37KXrgw0VrZDWyY9ih1QS0yljWLXl3K4kCAuImAIyJjcImY139kYvqy6xG3bWTvig805X5tJ11kDqJyFRjmK1tOHTvBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j9MhUURlO4JHQSCZdBwc9O61FyNfFWD7VFtvf7VCMJY=;
 b=eIPsX/BZVWMIUMRFlwptuu3GYVGw8wEShfSQTOQqRX6yy3mG999LSXooha+JXc9oSoTOh1OHr5RMuxVHxWnwRJqAn3NtzCEgAXXCW4AXgqi2DsPLG1Ms2zmQFikyz04Omegcqyjsb1lwCoirDq7dGHxsfSotavpUibnxurzK0w2CwBvYrC4SuIQMEU6y9yRY/R8KrInPmuc7g8AeMX0NPuZo0JIVfSoLGwWGQHQg2gBhV1nyLcgY3SUlal4pjquSXqJmsXbdFuJWT/lVYGTp1QTjRmYyKd1dZ5kBZ8BFI2HIgiaQrSptDrByAQjTSlL+XNfPei7EJO5Nd7cRPHxVew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j9MhUURlO4JHQSCZdBwc9O61FyNfFWD7VFtvf7VCMJY=;
 b=FkOIKfIgGxUNZcYRsuM01HkWLKZ6aU5Rf/J2e5jYpglQ0W0B+Vh59Rw+0Kf3EGtnOpyqjjJS1CdunZkztRyw2r5P7CMoVePOhPXD2ffUb9vcJGjXsqt0f1K0mtCK6/0wjYLZ0zr8rf7nICCVyTTy6NzeI4FkVAdUjEZq/jFaSLY=
Received: from CH0PR03CA0436.namprd03.prod.outlook.com (2603:10b6:610:10e::33)
 by SJ2PR12MB9191.namprd12.prod.outlook.com (2603:10b6:a03:55a::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Mon, 1 Dec
 2025 10:14:20 +0000
Received: from CH3PEPF0000000D.namprd04.prod.outlook.com
 (2603:10b6:610:10e:cafe::71) by CH0PR03CA0436.outlook.office365.com
 (2603:10b6:610:10e::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.17 via Frontend Transport; Mon,
 1 Dec 2025 10:14:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF0000000D.mail.protection.outlook.com (10.167.244.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Mon, 1 Dec 2025 10:14:20 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 1 Dec
 2025 04:14:18 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>, <Asad.Kamal@amd.com>
Subject: [PATCH 04/17] drm/amd/pm: Use generic dpm table for SMUv14 SOCs
Date: Mon, 1 Dec 2025 15:33:17 +0530
Message-ID: <20251201101331.101584-5-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251201101331.101584-1-lijo.lazar@amd.com>
References: <20251201101331.101584-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000D:EE_|SJ2PR12MB9191:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b703e62-f9e8-4fc0-f0c1-08de30c264b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?FfOB3sH4xgoXYqJbAy4bu7/1I3YAyUUhVfvQZpFerau4EfvVY83mf/kfZxrD?=
 =?us-ascii?Q?mxP8HfVL1tuOKABQaacTXCkr3a4vZKoW8gfZwDx4EAq/Rc2bhtpAkMD6QF2K?=
 =?us-ascii?Q?O3AlV8g6Mm/be3v2/9GUtwiW8rBeqNi/XaRmZ2c/vgM7I1kfFu+AcLxt4TPU?=
 =?us-ascii?Q?O9N0GUCXY2gv+J+0fAotSxSiDY6jEqozYLGaWfbvhlqf88sV8IkDkQ6iLBw0?=
 =?us-ascii?Q?dokwz1Ip2tdsu7ZMb0M/Cman9jk2+ir0sHGGm4n7mGMk/un2NsWL2Kyx08Jx?=
 =?us-ascii?Q?IOOLnnnCJxObjR6mZiZQVuOku355OfXv4xYFNZ7+pbHkqlx4TFj5UdFRVlsE?=
 =?us-ascii?Q?+3CwmXNR15Xnu4C3vOiXrqDY3l6jPdCQIlvaLMnLBGXtOlXu+2PeYffA2ZGp?=
 =?us-ascii?Q?+9mHHH10pn1RN1aZm5QPXQ1I3tho2QwDsyF9qHnUn4d1SFYrGjH2ctwDt4GU?=
 =?us-ascii?Q?ZVmJDgApFT9LY3aYI6cxS2tzTXgzmOY5eDX8Bsi/rgbCA7zbA2zXDdatYJoG?=
 =?us-ascii?Q?5tFa2MncbWhxkCHJJ1jnWZvbqKA/3wYPdnr/burgYydfkODRmfDcEvjsSUMy?=
 =?us-ascii?Q?3anycsItbKnbuV7AX/NXOJMHjYwtOPmsQuEeLg+N68oNVyS4ohoqlSBhdv3M?=
 =?us-ascii?Q?E/it0TACre2N1GwuSlzvPReu6mDmAkTUv1s4A8Pb72burM3rXsIqj5hIor5K?=
 =?us-ascii?Q?xOxcDacLeaDhfjK3UvwZ2VmmLS16fVl7iBVa37u5t3FRp4NseZgeIChcEQYa?=
 =?us-ascii?Q?FeLxMrpJIT1fy7cZxk/oOim4Rd8tpKODnxgxh55Ewq0DkVgxEUznkf82MUZt?=
 =?us-ascii?Q?p10a0D5tPuX2S7HcbrRtR2cUszpoLNwzPEe9PT78NJUISQ68mYpTFHy8MzZt?=
 =?us-ascii?Q?9jHnvFqNE/7Y9yqE6V90i1GWNMTqhOon1sjgQuGjXKClVYn+B9shuVbkcREx?=
 =?us-ascii?Q?5Jf2JjPIh73LkJHD259U5yrG4kcMHZ1qbtQ6PbLiopKA7h64YvLZC7g7mcyv?=
 =?us-ascii?Q?ck9Ov/aBx5u/CTZYH3KpdcY57/eTQkTjBXa7YbbF/Q15vXBf87UEYap0mPgN?=
 =?us-ascii?Q?14zKOYxDSxA5mW2qbqSTSrNZWRbAGBGsbno6DWqHJK7IOfA3GbUMwt38zS4F?=
 =?us-ascii?Q?V5jvFvU9KALoiYClCKLw+kgWolGTenUVGQeo476d2LexHPnad3t42WxbekD9?=
 =?us-ascii?Q?A7uW7zTITBsypC9fUODsSJIa94vD6hRspholRxZQ5cIkIALryHq99wAMfZVq?=
 =?us-ascii?Q?T4+AlH5XhuQxgcBZ6ZJxWzNncxmpRykgqWNDnYTHF6A2WTRWwzvqzDlm8odF?=
 =?us-ascii?Q?eFZWCyXomqFkdMFN9B7Om9K1NI7KZ/Ya+GW3ZrcBe8BjJtSPY0Gr8eKC74gQ?=
 =?us-ascii?Q?lClce2v4Qut4BV408SYM4EZA2qP9UpSvB0JsytTJJBBSBRVR5zxEwsWZISb1?=
 =?us-ascii?Q?aSjSGS0j9y1VKijNvbN0JK58b2r/jLkMLfS7806w9UqYDgxoIBkb0dpdtP6H?=
 =?us-ascii?Q?2Wc5AHfaToeTT7yE85f7mQ4wUs6OmZTDFosnesk71bLPsvAuq0JUg/cu/Ywf?=
 =?us-ascii?Q?oZTGoUcJdiTmQNuVHs0=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2025 10:14:20.3755 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b703e62-f9e8-4fc0-f0c1-08de30c264b0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9191
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

Use the generic dpm table structure instead of SMUv14 specific table.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v14_0.h  | 38 +++-----
 .../gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c    | 81 +++++++---------
 .../drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c  | 97 ++++++++-----------
 3 files changed, 90 insertions(+), 126 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v14_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v14_0.h
index 29a4583db873..5b6fa8fdce2d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v14_0.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v14_0.h
@@ -43,7 +43,6 @@
 #define smnMP1_FIRMWARE_FLAGS		0x3010024
 #define smnMP1_PUB_CTRL			0x3010d10
 
-#define MAX_DPM_LEVELS 16
 #define MAX_PCIE_CONF 3
 
 #define SMU14_TOOL_SIZE			0x19000
@@ -67,19 +66,6 @@ struct smu_14_0_max_sustainable_clocks {
 	uint32_t soc_clock;
 };
 
-struct smu_14_0_dpm_clk_level {
-	bool				enabled;
-	uint32_t			value;
-};
-
-struct smu_14_0_dpm_table {
-	uint32_t			min;        /* MHz */
-	uint32_t			max;        /* MHz */
-	uint32_t			count;
-	bool				is_fine_grained;
-	struct smu_14_0_dpm_clk_level	dpm_levels[MAX_DPM_LEVELS];
-};
-
 struct smu_14_0_pcie_table {
 	uint8_t  pcie_gen[MAX_PCIE_CONF];
 	uint8_t  pcie_lane[MAX_PCIE_CONF];
@@ -88,17 +74,17 @@ struct smu_14_0_pcie_table {
 };
 
 struct smu_14_0_dpm_tables {
-	struct smu_14_0_dpm_table        soc_table;
-	struct smu_14_0_dpm_table        gfx_table;
-	struct smu_14_0_dpm_table        uclk_table;
-	struct smu_14_0_dpm_table        eclk_table;
-	struct smu_14_0_dpm_table        vclk_table;
-	struct smu_14_0_dpm_table        dclk_table;
-	struct smu_14_0_dpm_table        dcef_table;
-	struct smu_14_0_dpm_table        pixel_table;
-	struct smu_14_0_dpm_table        display_table;
-	struct smu_14_0_dpm_table        phy_table;
-	struct smu_14_0_dpm_table        fclk_table;
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
 	struct smu_14_0_pcie_table       pcie_table;
 };
 
@@ -201,7 +187,7 @@ int smu_v14_0_set_power_source(struct smu_context *smu,
 
 int smu_v14_0_set_single_dpm_table(struct smu_context *smu,
 				   enum smu_clk_type clk_type,
-				   struct smu_14_0_dpm_table *single_dpm_table);
+				   struct smu_dpm_table *single_dpm_table);
 
 int smu_v14_0_gfx_ulv_control(struct smu_context *smu,
 			      bool enablement);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
index f9b0938c57ea..7db1161c0c05 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
@@ -1247,18 +1247,12 @@ int smu_v14_0_set_performance_level(struct smu_context *smu,
 {
 	struct smu_14_0_dpm_context *dpm_context =
 		smu->smu_dpm.dpm_context;
-	struct smu_14_0_dpm_table *gfx_table =
-		&dpm_context->dpm_tables.gfx_table;
-	struct smu_14_0_dpm_table *mem_table =
-		&dpm_context->dpm_tables.uclk_table;
-	struct smu_14_0_dpm_table *soc_table =
-		&dpm_context->dpm_tables.soc_table;
-	struct smu_14_0_dpm_table *vclk_table =
-		&dpm_context->dpm_tables.vclk_table;
-	struct smu_14_0_dpm_table *dclk_table =
-		&dpm_context->dpm_tables.dclk_table;
-	struct smu_14_0_dpm_table *fclk_table =
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
@@ -1273,34 +1267,34 @@ int smu_v14_0_set_performance_level(struct smu_context *smu,
 
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
@@ -1522,11 +1516,12 @@ static int smu_v14_0_get_fine_grained_status(struct smu_context *smu,
 
 int smu_v14_0_set_single_dpm_table(struct smu_context *smu,
 				   enum smu_clk_type clk_type,
-				   struct smu_14_0_dpm_table *single_dpm_table)
+				   struct smu_dpm_table *single_dpm_table)
 {
 	int ret = 0;
 	uint32_t clk;
 	int i;
+	bool is_fine_grained;
 
 	ret = smu_v14_0_get_dpm_level_count(smu,
 					    clk_type,
@@ -1536,13 +1531,14 @@ int smu_v14_0_set_single_dpm_table(struct smu_context *smu,
 		return ret;
 	}
 
-	ret = smu_v14_0_get_fine_grained_status(smu,
-						clk_type,
-						&single_dpm_table->is_fine_grained);
+	ret = smu_v14_0_get_fine_grained_status(smu, clk_type,
+						&is_fine_grained);
 	if (ret) {
 		dev_err(smu->adev->dev, "[%s] failed to get fine grained status!\n", __func__);
 		return ret;
 	}
+	if (is_fine_grained)
+		single_dpm_table->flags |= SMU_DPM_TABLE_FINE_GRAINED;
 
 	for (i = 0; i < single_dpm_table->count; i++) {
 		ret = smu_v14_0_get_dpm_freq_by_index(smu,
@@ -1556,11 +1552,6 @@ int smu_v14_0_set_single_dpm_table(struct smu_context *smu,
 
 		single_dpm_table->dpm_levels[i].value = clk;
 		single_dpm_table->dpm_levels[i].enabled = true;
-
-		if (i == 0)
-			single_dpm_table->min = clk;
-		else if (i == single_dpm_table->count - 1)
-			single_dpm_table->max = clk;
 	}
 
 	return 0;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
index ab57bb2e5dcf..daa51364cb24 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
@@ -501,11 +501,12 @@ static int smu_v14_0_2_set_default_dpm_table(struct smu_context *smu)
 	struct smu_table_context *table_context = &smu->smu_table;
 	PPTable_t *pptable = table_context->driver_pptable;
 	SkuTable_t *skutable = &pptable->SkuTable;
-	struct smu_14_0_dpm_table *dpm_table;
+	struct smu_dpm_table *dpm_table;
 	int ret = 0;
 
 	/* socclk dpm table setup */
 	dpm_table = &dpm_context->dpm_tables.soc_table;
+	dpm_table->clk_type = SMU_SOCCLK;
 	if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_DPM_SOCCLK_BIT)) {
 		ret = smu_v14_0_set_single_dpm_table(smu,
 						     SMU_SOCCLK,
@@ -516,12 +517,11 @@ static int smu_v14_0_2_set_default_dpm_table(struct smu_context *smu)
 		dpm_table->count = 1;
 		dpm_table->dpm_levels[0].value = smu->smu_table.boot_values.socclk / 100;
 		dpm_table->dpm_levels[0].enabled = true;
-		dpm_table->min = dpm_table->dpm_levels[0].value;
-		dpm_table->max = dpm_table->dpm_levels[0].value;
 	}
 
 	/* gfxclk dpm table setup */
 	dpm_table = &dpm_context->dpm_tables.gfx_table;
+	dpm_table->clk_type = SMU_GFXCLK;
 	if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_DPM_GFXCLK_BIT)) {
 		ret = smu_v14_0_set_single_dpm_table(smu,
 						     SMU_GFXCLK,
@@ -543,18 +543,16 @@ static int smu_v14_0_2_set_default_dpm_table(struct smu_context *smu)
 		    skutable->DriverReportedClocks.GameClockAc)) {
 			dpm_table->dpm_levels[dpm_table->count - 1].value =
 				skutable->DriverReportedClocks.GameClockAc;
-			dpm_table->max = skutable->DriverReportedClocks.GameClockAc;
 		}
 	} else {
 		dpm_table->count = 1;
 		dpm_table->dpm_levels[0].value = smu->smu_table.boot_values.gfxclk / 100;
 		dpm_table->dpm_levels[0].enabled = true;
-		dpm_table->min = dpm_table->dpm_levels[0].value;
-		dpm_table->max = dpm_table->dpm_levels[0].value;
 	}
 
 	/* uclk dpm table setup */
 	dpm_table = &dpm_context->dpm_tables.uclk_table;
+	dpm_table->clk_type = SMU_UCLK;
 	if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_DPM_UCLK_BIT)) {
 		ret = smu_v14_0_set_single_dpm_table(smu,
 						     SMU_UCLK,
@@ -565,12 +563,11 @@ static int smu_v14_0_2_set_default_dpm_table(struct smu_context *smu)
 		dpm_table->count = 1;
 		dpm_table->dpm_levels[0].value = smu->smu_table.boot_values.uclk / 100;
 		dpm_table->dpm_levels[0].enabled = true;
-		dpm_table->min = dpm_table->dpm_levels[0].value;
-		dpm_table->max = dpm_table->dpm_levels[0].value;
 	}
 
 	/* fclk dpm table setup */
 	dpm_table = &dpm_context->dpm_tables.fclk_table;
+	dpm_table->clk_type = SMU_FCLK;
 	if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_DPM_FCLK_BIT)) {
 		ret = smu_v14_0_set_single_dpm_table(smu,
 						     SMU_FCLK,
@@ -581,12 +578,11 @@ static int smu_v14_0_2_set_default_dpm_table(struct smu_context *smu)
 		dpm_table->count = 1;
 		dpm_table->dpm_levels[0].value = smu->smu_table.boot_values.fclk / 100;
 		dpm_table->dpm_levels[0].enabled = true;
-		dpm_table->min = dpm_table->dpm_levels[0].value;
-		dpm_table->max = dpm_table->dpm_levels[0].value;
 	}
 
 	/* vclk dpm table setup */
 	dpm_table = &dpm_context->dpm_tables.vclk_table;
+	dpm_table->clk_type = SMU_VCLK;
 	if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_DPM_VCLK_BIT)) {
 		ret = smu_v14_0_set_single_dpm_table(smu,
 						     SMU_VCLK,
@@ -597,12 +593,11 @@ static int smu_v14_0_2_set_default_dpm_table(struct smu_context *smu)
 		dpm_table->count = 1;
 		dpm_table->dpm_levels[0].value = smu->smu_table.boot_values.vclk / 100;
 		dpm_table->dpm_levels[0].enabled = true;
-		dpm_table->min = dpm_table->dpm_levels[0].value;
-		dpm_table->max = dpm_table->dpm_levels[0].value;
 	}
 
 	/* dclk dpm table setup */
 	dpm_table = &dpm_context->dpm_tables.dclk_table;
+	dpm_table->clk_type = SMU_DCLK;
 	if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_DPM_DCLK_BIT)) {
 		ret = smu_v14_0_set_single_dpm_table(smu,
 						     SMU_DCLK,
@@ -613,12 +608,11 @@ static int smu_v14_0_2_set_default_dpm_table(struct smu_context *smu)
 		dpm_table->count = 1;
 		dpm_table->dpm_levels[0].value = smu->smu_table.boot_values.dclk / 100;
 		dpm_table->dpm_levels[0].enabled = true;
-		dpm_table->min = dpm_table->dpm_levels[0].value;
-		dpm_table->max = dpm_table->dpm_levels[0].value;
 	}
 
 	/* dcefclk dpm table setup */
 	dpm_table = &dpm_context->dpm_tables.dcef_table;
+	dpm_table->clk_type = SMU_DCEFCLK;
 	if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_DPM_DCN_BIT)) {
 		ret = smu_v14_0_set_single_dpm_table(smu,
 						     SMU_DCEFCLK,
@@ -629,8 +623,6 @@ static int smu_v14_0_2_set_default_dpm_table(struct smu_context *smu)
 		dpm_table->count = 1;
 		dpm_table->dpm_levels[0].value = smu->smu_table.boot_values.dcefclk / 100;
 		dpm_table->dpm_levels[0].enabled = true;
-		dpm_table->min = dpm_table->dpm_levels[0].value;
-		dpm_table->max = dpm_table->dpm_levels[0].value;
 	}
 
 	return 0;
@@ -794,7 +786,7 @@ static int smu_v14_0_2_get_dpm_ultimate_freq(struct smu_context *smu,
 {
 	struct smu_14_0_dpm_context *dpm_context =
 		smu->smu_dpm.dpm_context;
-	struct smu_14_0_dpm_table *dpm_table;
+	struct smu_dpm_table *dpm_table;
 
 	switch (clk_type) {
 	case SMU_MCLK:
@@ -831,9 +823,9 @@ static int smu_v14_0_2_get_dpm_ultimate_freq(struct smu_context *smu,
 	}
 
 	if (min)
-		*min = dpm_table->min;
+		*min = SMU_DPM_TABLE_MIN(dpm_table);
 	if (max)
-		*max = dpm_table->max;
+		*max = SMU_DPM_TABLE_MAX(dpm_table);
 
 	return 0;
 }
@@ -1053,7 +1045,7 @@ static int smu_v14_0_2_emit_clk_levels(struct smu_context *smu,
 	struct smu_14_0_dpm_context *dpm_context = smu_dpm->dpm_context;
 	OverDriveTableExternal_t *od_table =
 		(OverDriveTableExternal_t *)smu->smu_table.overdrive_table;
-	struct smu_14_0_dpm_table *single_dpm_table;
+	struct smu_dpm_table *single_dpm_table;
 	struct smu_14_0_pcie_table *pcie_table;
 	uint32_t gen_speed, lane_width;
 	int i, curr_freq, size = *offset, start_offset = *offset;
@@ -1109,7 +1101,7 @@ static int smu_v14_0_2_emit_clk_levels(struct smu_context *smu,
 			return ret;
 		}
 
-		if (single_dpm_table->is_fine_grained) {
+		if (single_dpm_table->flags & SMU_DPM_TABLE_FINE_GRAINED) {
 			/*
 			 * For fine grained dpms, there are only two dpm levels:
 			 *   - level 0 -> min clock freq
@@ -1383,7 +1375,7 @@ static int smu_v14_0_2_force_clk_levels(struct smu_context *smu,
 {
 	struct smu_dpm_context *smu_dpm = &smu->smu_dpm;
 	struct smu_14_0_dpm_context *dpm_context = smu_dpm->dpm_context;
-	struct smu_14_0_dpm_table *single_dpm_table;
+	struct smu_dpm_table *single_dpm_table;
 	uint32_t soft_min_level, soft_max_level;
 	uint32_t min_freq, max_freq;
 	int ret = 0;
@@ -1429,7 +1421,7 @@ static int smu_v14_0_2_force_clk_levels(struct smu_context *smu,
 	case SMU_VCLK1:
 	case SMU_DCLK:
 	case SMU_DCLK1:
-		if (single_dpm_table->is_fine_grained) {
+		if (single_dpm_table->flags & SMU_DPM_TABLE_FINE_GRAINED) {
 			/* There is only 2 levels for fine grained DPM */
 			soft_max_level = (soft_max_level >= 1 ? 1 : 0);
 			soft_min_level = (soft_min_level >= 1 ? 1 : 0);
@@ -1582,18 +1574,12 @@ static int smu_v14_0_2_populate_umd_state_clk(struct smu_context *smu)
 {
 	struct smu_14_0_dpm_context *dpm_context =
 		smu->smu_dpm.dpm_context;
-	struct smu_14_0_dpm_table *gfx_table =
-		&dpm_context->dpm_tables.gfx_table;
-	struct smu_14_0_dpm_table *mem_table =
-		&dpm_context->dpm_tables.uclk_table;
-	struct smu_14_0_dpm_table *soc_table =
-		&dpm_context->dpm_tables.soc_table;
-	struct smu_14_0_dpm_table *vclk_table =
-		&dpm_context->dpm_tables.vclk_table;
-	struct smu_14_0_dpm_table *dclk_table =
-		&dpm_context->dpm_tables.dclk_table;
-	struct smu_14_0_dpm_table *fclk_table =
-		&dpm_context->dpm_tables.fclk_table;
+	struct smu_dpm_table *gfx_table = &dpm_context->dpm_tables.gfx_table;
+	struct smu_dpm_table *mem_table = &dpm_context->dpm_tables.uclk_table;
+	struct smu_dpm_table *soc_table = &dpm_context->dpm_tables.soc_table;
+	struct smu_dpm_table *vclk_table = &dpm_context->dpm_tables.vclk_table;
+	struct smu_dpm_table *dclk_table = &dpm_context->dpm_tables.dclk_table;
+	struct smu_dpm_table *fclk_table = &dpm_context->dpm_tables.fclk_table;
 	struct smu_umd_pstate_table *pstate_table =
 		&smu->pstate_table;
 	struct smu_table_context *table_context = &smu->smu_table;
@@ -1601,38 +1587,39 @@ static int smu_v14_0_2_populate_umd_state_clk(struct smu_context *smu)
 	DriverReportedClocks_t driver_clocks =
 			pptable->SkuTable.DriverReportedClocks;
 
-	pstate_table->gfxclk_pstate.min = gfx_table->min;
+	pstate_table->gfxclk_pstate.min = SMU_DPM_TABLE_MIN(gfx_table);
 	if (driver_clocks.GameClockAc &&
-	    (driver_clocks.GameClockAc < gfx_table->max))
+	    (driver_clocks.GameClockAc < SMU_DPM_TABLE_MAX(gfx_table)))
 		pstate_table->gfxclk_pstate.peak = driver_clocks.GameClockAc;
 	else
-		pstate_table->gfxclk_pstate.peak = gfx_table->max;
+		pstate_table->gfxclk_pstate.peak = SMU_DPM_TABLE_MAX(gfx_table);
 
-	pstate_table->uclk_pstate.min = mem_table->min;
-	pstate_table->uclk_pstate.peak = mem_table->max;
+	pstate_table->uclk_pstate.min = SMU_DPM_TABLE_MIN(mem_table);
+	pstate_table->uclk_pstate.peak = SMU_DPM_TABLE_MAX(mem_table);
 
-	pstate_table->socclk_pstate.min = soc_table->min;
-	pstate_table->socclk_pstate.peak = soc_table->max;
+	pstate_table->socclk_pstate.min = SMU_DPM_TABLE_MIN(soc_table);
+	pstate_table->socclk_pstate.peak = SMU_DPM_TABLE_MAX(soc_table);
 
-	pstate_table->vclk_pstate.min = vclk_table->min;
-	pstate_table->vclk_pstate.peak = vclk_table->max;
+	pstate_table->vclk_pstate.min = SMU_DPM_TABLE_MIN(vclk_table);
+	pstate_table->vclk_pstate.peak = SMU_DPM_TABLE_MAX(vclk_table);
 
-	pstate_table->dclk_pstate.min = dclk_table->min;
-	pstate_table->dclk_pstate.peak = dclk_table->max;
+	pstate_table->dclk_pstate.min = SMU_DPM_TABLE_MIN(dclk_table);
+	pstate_table->dclk_pstate.peak = SMU_DPM_TABLE_MAX(dclk_table);
 
-	pstate_table->fclk_pstate.min = fclk_table->min;
-	pstate_table->fclk_pstate.peak = fclk_table->max;
+	pstate_table->fclk_pstate.min = SMU_DPM_TABLE_MIN(fclk_table);
+	pstate_table->fclk_pstate.peak = SMU_DPM_TABLE_MAX(fclk_table);
 
 	if (driver_clocks.BaseClockAc &&
-	    driver_clocks.BaseClockAc < gfx_table->max)
+	    driver_clocks.BaseClockAc < SMU_DPM_TABLE_MAX(gfx_table))
 		pstate_table->gfxclk_pstate.standard = driver_clocks.BaseClockAc;
 	else
-		pstate_table->gfxclk_pstate.standard = gfx_table->max;
-	pstate_table->uclk_pstate.standard = mem_table->max;
-	pstate_table->socclk_pstate.standard = soc_table->min;
-	pstate_table->vclk_pstate.standard = vclk_table->min;
-	pstate_table->dclk_pstate.standard = dclk_table->min;
-	pstate_table->fclk_pstate.standard = fclk_table->min;
+		pstate_table->gfxclk_pstate.standard =
+			SMU_DPM_TABLE_MAX(gfx_table);
+	pstate_table->uclk_pstate.standard = SMU_DPM_TABLE_MAX(mem_table);
+	pstate_table->socclk_pstate.standard = SMU_DPM_TABLE_MIN(soc_table);
+	pstate_table->vclk_pstate.standard = SMU_DPM_TABLE_MIN(vclk_table);
+	pstate_table->dclk_pstate.standard = SMU_DPM_TABLE_MIN(dclk_table);
+	pstate_table->fclk_pstate.standard = SMU_DPM_TABLE_MIN(fclk_table);
 
 	return 0;
 }
-- 
2.49.0

