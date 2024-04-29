Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E18A0C4345F
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Apr 2024 07:42:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 41B581129A7;
	Mon, 29 Apr 2024 07:42:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HwsJcOo1";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2055.outbound.protection.outlook.com [40.107.220.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B3C11129A7
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Apr 2024 07:42:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WmyRQXr9RuqZ6FV53gkwsvreP5zjwg1dvx5Wj4OULhzsod2yoxbEuBdj3QY0XplfsEixUwappnssmw8ve5wxwz7zYHkp3rKRxJ6G/R2yJ67F1NVCnbkoibN8YHb9i5WACJNCU9PDw/vBAeoYg0zd27SRhS4CUcXj6WNG+KlISB3EPHa1rT4HJBFoQ7REpQRA3QC66pgGtGQvNXU/ttiRgvqhs2ZfquaMcoO5QCU/CDpgLot/x/GW7IRSBmeV/aeJFKNYHHRE7NLg39GC14mMH3eZnyDZSUFhU2/j6VpDvwE6jIolA9IAeXrw6o+++JcRlYruNVgxueMFJAbnSFIihg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gy5mzeIeewgYBEZpZrdCLeUnOqJWMIMLCghSnN6rQPk=;
 b=X5Q1Qr+pnGUgzxk406LTq7KpUrp4UgLj/2T3M6CSxNPqej1MYrfefE/K9Gam4V9ZkNztHAaG/gjmthUFS9HRTZYkppXifaVVs4r/S0nN76IkMJgAAW4KWdg5g0XWlJ01sgbOM2RBEzljzhTGe/aXSToFvd80s5yj5UBUws8QSmT3dJrqXwFUXGjEUk/3FZVigEv9sSiwKIR5tgDvg1o4wDTBPWvCxgwcHRAs5mC3P5w5SOjHIA+/jrenZjWRVvdqVqIslNT4kl1zgH4uFNqi6qk/wsah1A9kjIRBc1Yj7R/1tpHte98VnA16VeKO5hgnWT7WJilzOuiVdNQP3yRJXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gy5mzeIeewgYBEZpZrdCLeUnOqJWMIMLCghSnN6rQPk=;
 b=HwsJcOo13F2JD8dwoXcivqzMLo4pB3kvRDdUs0/ewuPxrFfk9jykcomSXGWKR5AUXJD3wZXqnTO9gzDgec9R4ClxL+J0fVGVr70hm5PuB2xinEUtGP3KwR152LS/UHLdOf8+PnmJcjCXZPXyXNt1nOUY2jT0vU+I6gltS2HYKRY=
Received: from BYAPR04CA0019.namprd04.prod.outlook.com (2603:10b6:a03:40::32)
 by SA3PR12MB9129.namprd12.prod.outlook.com (2603:10b6:806:397::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Mon, 29 Apr
 2024 07:42:02 +0000
Received: from MWH0EPF000971E4.namprd02.prod.outlook.com
 (2603:10b6:a03:40:cafe::a3) by BYAPR04CA0019.outlook.office365.com
 (2603:10b6:a03:40::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34 via Frontend
 Transport; Mon, 29 Apr 2024 07:42:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E4.mail.protection.outlook.com (10.167.243.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Mon, 29 Apr 2024 07:42:01 +0000
Received: from ldev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 29 Apr
 2024 02:41:59 -0500
From: Tim Huang <Tim.Huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <christian.koenig@amd.com>, Tim Huang
 <Tim.Huang@amd.com>
Subject: [PATCH] drm/amd/pm: fix uninitialized variable warning for smu_v13
Date: Mon, 29 Apr 2024 15:41:36 +0800
Message-ID: <20240429074136.1704135-1-Tim.Huang@amd.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E4:EE_|SA3PR12MB9129:EE_
X-MS-Office365-Filtering-Correlation-Id: 3dcca274-e2f2-49bb-0996-08dc681fdba2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|376005|1800799015|82310400014|36860700004; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?g1/aygqPLdIxcAiAW7KOLDlLgGmc5yfaAGMEF6w8WNFKDCevgz4FaQMdMyj5?=
 =?us-ascii?Q?hzIpVeaSjhRjxfmJhjoca8RMggH/CG1a0I50hhvY57TPmD2m2p4i6SpOiAvU?=
 =?us-ascii?Q?7ojsbq+9vhehppBYnMyXWe6N9abc0Gz6uAVFDntp6p98FsGq5eE+DnID/MLR?=
 =?us-ascii?Q?cJuD8wmyi8N+TAcFTjrXUaYoIpa6Bh6D2laAQzUuV6Xz8H6n84m+ENvhl3Cj?=
 =?us-ascii?Q?H6KFdUcAfwoodN1w651TIAVKdsErdoxoEAtHn5A0zlFROWzPxK8mG0GTAi8m?=
 =?us-ascii?Q?rnp693oFZhm13bkr9h6tn6eJjLzAc1Wp+b9HItUqnxk3XWTf5JgFtXmTf3ma?=
 =?us-ascii?Q?1rr6XhjM2hTZdwGVw12bJYD6BUeBXAJjZtifHL9SEoDcYsVEEsJDW7QuvGAP?=
 =?us-ascii?Q?o5MSOWf8QuO2tLS55zX8n+dhS84QllYTuavb3XUNEia4DUP4GASA8xfKB28z?=
 =?us-ascii?Q?dcQihIMRDlHsgSSG7MCp9WOPmZBL7CgkfQnTKP3FT7RpuQxsGpmLym1s5NEg?=
 =?us-ascii?Q?Z0jwtd9kNrO+we7FWGACtj4TQOt3kujZGTDIWWqcstJHg/B/bv2yObkU18Ug?=
 =?us-ascii?Q?V7IHcyCU4OqhoyxdRU5O5xExPYaIjJp1FSecjee6CZmUZfZCUvXxoY74K0TY?=
 =?us-ascii?Q?TvbLC8c51Dr10fNrEbGXatGVWSSfd+f04INiU054iD7kX6jvwzaRB+f5jmfu?=
 =?us-ascii?Q?EVGAzah9JpI1pUqX85xdXHW8XkBCO3jITQF3wSrEU5WwNRSkJYZ6a/BTLwCT?=
 =?us-ascii?Q?EkbeUGgjYTapCG/qwPZLeMRb3umxA1vGwAF661mnN0CkzMNI5sZUxIyLfZ3j?=
 =?us-ascii?Q?Ss0qRtgBizrvTMEyi+F6Ft0dN4jQ0DR93xrjTlQyhrry7ShTNsb3KRhKENRL?=
 =?us-ascii?Q?ct24aQdBdJhEk5Qdt5oKSJBStfuaZumN5ST/AgcjkG6fQG5k52T7GyrVnX7c?=
 =?us-ascii?Q?fAKer11P88ONazPX5LxMNSqoxSNxGRAvMRRTU1Em/f03IZiYLF4a6tH4JYvq?=
 =?us-ascii?Q?g25mNW3GGVW5FTfZnteDoX4JiF5jYrFHk2bxtA5Dr0buR7CMklH/eSsbzNSc?=
 =?us-ascii?Q?io1h4BaYuQgVjfSB/OoDSf2Jwcn36CRnbooDqyk1sndo6QtVAUJdJ+4ENCST?=
 =?us-ascii?Q?uMlIq1B1bFL3O3OW7AAZjID3oH85geLHlFyuBndkD8L2TerlCXmnUGQwkgxB?=
 =?us-ascii?Q?BdV/nbbv3axqYqY6L73RrZ4Mp0+mP2P9Ib7LKGSp2dtNrGQKRcRRwY/HHM0h?=
 =?us-ascii?Q?s42hMns+do0+NWUQDvgCEBnBlmWw//Axx6XnhaEuLPDxmofZTBaIy7XOc5Mv?=
 =?us-ascii?Q?p0DzK2/cu2G4GVvbk10wjXdjRz2Blh5/yboE9J1cYFzG2IgZf/MwCk8r7xPY?=
 =?us-ascii?Q?byej8YI=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(82310400014)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 07:42:01.6309 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dcca274-e2f2-49bb-0996-08dc681fdba2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9129
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

Clear warning that using uninitialized variable when the dpm is
not enabled and reuse the code for SMU13 to get the boot frequency.

Signed-off-by: Tim Huang <Tim.Huang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h  |  4 ++
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    | 55 +++++++++++++------
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c  | 28 +---------
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c  | 28 +---------
 .../drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c  | 28 +---------
 5 files changed, 51 insertions(+), 92 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
index d9700a3f28d2..e58220a7ee2f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
@@ -298,5 +298,9 @@ int smu_v13_0_enable_uclk_shadow(struct smu_context *smu, bool enable);
 
 int smu_v13_0_set_wbrf_exclusion_ranges(struct smu_context *smu,
 						 struct freq_band_range *exclusion_ranges);
+
+int smu_v13_0_get_boot_freq_by_index(struct smu_context *smu,
+				     enum smu_clk_type clk_type,
+				     uint32_t *value);
 #endif
 #endif
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
index a8d34adc7d3f..ed5a7a83c9e2 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -1559,22 +1559,9 @@ int smu_v13_0_get_dpm_ultimate_freq(struct smu_context *smu, enum smu_clk_type c
 	uint32_t clock_limit;
 
 	if (!smu_cmn_clk_dpm_is_enabled(smu, clk_type)) {
-		switch (clk_type) {
-		case SMU_MCLK:
-		case SMU_UCLK:
-			clock_limit = smu->smu_table.boot_values.uclk;
-			break;
-		case SMU_GFXCLK:
-		case SMU_SCLK:
-			clock_limit = smu->smu_table.boot_values.gfxclk;
-			break;
-		case SMU_SOCCLK:
-			clock_limit = smu->smu_table.boot_values.socclk;
-			break;
-		default:
-			clock_limit = 0;
-			break;
-		}
+		ret = smu_v13_0_get_boot_freq_by_index(smu, clk_type, &clock_limit);
+		if (ret)
+			return ret;
 
 		/* clock in Mhz unit */
 		if (min)
@@ -1894,6 +1881,40 @@ int smu_v13_0_set_power_source(struct smu_context *smu,
 					       NULL);
 }
 
+int smu_v13_0_get_boot_freq_by_index(struct smu_context *smu,
+				     enum smu_clk_type clk_type,
+				     uint32_t *value)
+{
+	int ret = 0;
+
+	switch (clk_type) {
+	case SMU_MCLK:
+	case SMU_UCLK:
+		*value = smu->smu_table.boot_values.uclk;
+		break;
+	case SMU_FCLK:
+		*value = smu->smu_table.boot_values.fclk;
+		break;
+	case SMU_GFXCLK:
+	case SMU_SCLK:
+		*value = smu->smu_table.boot_values.gfxclk;
+		break;
+	case SMU_SOCCLK:
+		*value = smu->smu_table.boot_values.socclk;
+		break;
+	case SMU_VCLK:
+		*value = smu->smu_table.boot_values.vclk;
+		break;
+	case SMU_DCLK:
+		*value = smu->smu_table.boot_values.dclk;
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+	return ret;
+}
+
 int smu_v13_0_get_dpm_freq_by_index(struct smu_context *smu,
 				    enum smu_clk_type clk_type, uint16_t level,
 				    uint32_t *value)
@@ -1905,7 +1926,7 @@ int smu_v13_0_get_dpm_freq_by_index(struct smu_context *smu,
 		return -EINVAL;
 
 	if (!smu_cmn_clk_dpm_is_enabled(smu, clk_type))
-		return 0;
+		return smu_v13_0_get_boot_freq_by_index(smu, clk_type, value);
 
 	clk_id = smu_cmn_to_asic_specific_index(smu,
 						CMN2ASIC_MAPPING_CLK,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c
index 88f1a0d878f3..e283b282ec27 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c
@@ -756,31 +756,9 @@ static int smu_v13_0_4_get_dpm_ultimate_freq(struct smu_context *smu,
 	int ret = 0;
 
 	if (!smu_v13_0_4_clk_dpm_is_enabled(smu, clk_type)) {
-		switch (clk_type) {
-		case SMU_MCLK:
-		case SMU_UCLK:
-			clock_limit = smu->smu_table.boot_values.uclk;
-			break;
-		case SMU_FCLK:
-			clock_limit = smu->smu_table.boot_values.fclk;
-			break;
-		case SMU_GFXCLK:
-		case SMU_SCLK:
-			clock_limit = smu->smu_table.boot_values.gfxclk;
-			break;
-		case SMU_SOCCLK:
-			clock_limit = smu->smu_table.boot_values.socclk;
-			break;
-		case SMU_VCLK:
-			clock_limit = smu->smu_table.boot_values.vclk;
-			break;
-		case SMU_DCLK:
-			clock_limit = smu->smu_table.boot_values.dclk;
-			break;
-		default:
-			clock_limit = 0;
-			break;
-		}
+		ret = smu_v13_0_get_boot_freq_by_index(smu, clk_type, &clock_limit);
+		if (ret)
+			return ret;
 
 		/* clock in Mhz unit */
 		if (min)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c
index 218f209c3775..59854465d711 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c
@@ -733,31 +733,9 @@ static int smu_v13_0_5_get_dpm_ultimate_freq(struct smu_context *smu,
 	int ret = 0;
 
 	if (!smu_v13_0_5_clk_dpm_is_enabled(smu, clk_type)) {
-		switch (clk_type) {
-		case SMU_MCLK:
-		case SMU_UCLK:
-			clock_limit = smu->smu_table.boot_values.uclk;
-			break;
-		case SMU_FCLK:
-			clock_limit = smu->smu_table.boot_values.fclk;
-			break;
-		case SMU_GFXCLK:
-		case SMU_SCLK:
-			clock_limit = smu->smu_table.boot_values.gfxclk;
-			break;
-		case SMU_SOCCLK:
-			clock_limit = smu->smu_table.boot_values.socclk;
-			break;
-		case SMU_VCLK:
-			clock_limit = smu->smu_table.boot_values.vclk;
-			break;
-		case SMU_DCLK:
-			clock_limit = smu->smu_table.boot_values.dclk;
-			break;
-		default:
-			clock_limit = 0;
-			break;
-		}
+		ret = smu_v13_0_get_boot_freq_by_index(smu, clk_type, &clock_limit);
+		if (ret)
+			return ret;
 
 		/* clock in Mhz unit */
 		if (min)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
index d8bcf765a803..5917c88cc87d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
@@ -867,31 +867,9 @@ static int yellow_carp_get_dpm_ultimate_freq(struct smu_context *smu,
 	int ret = 0;
 
 	if (!yellow_carp_clk_dpm_is_enabled(smu, clk_type)) {
-		switch (clk_type) {
-		case SMU_MCLK:
-		case SMU_UCLK:
-			clock_limit = smu->smu_table.boot_values.uclk;
-			break;
-		case SMU_FCLK:
-			clock_limit = smu->smu_table.boot_values.fclk;
-			break;
-		case SMU_GFXCLK:
-		case SMU_SCLK:
-			clock_limit = smu->smu_table.boot_values.gfxclk;
-			break;
-		case SMU_SOCCLK:
-			clock_limit = smu->smu_table.boot_values.socclk;
-			break;
-		case SMU_VCLK:
-			clock_limit = smu->smu_table.boot_values.vclk;
-			break;
-		case SMU_DCLK:
-			clock_limit = smu->smu_table.boot_values.dclk;
-			break;
-		default:
-			clock_limit = 0;
-			break;
-		}
+		ret = smu_v13_0_get_boot_freq_by_index(smu, clk_type, &clock_limit);
+		if (ret)
+			return ret;
 
 		/* clock in Mhz unit */
 		if (min)
-- 
2.39.2

