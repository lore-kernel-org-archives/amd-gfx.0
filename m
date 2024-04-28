Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E310C4345F
	for <amd-gfx@archiver.kernel.org>; Sun, 28 Apr 2024 09:38:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ADAFF10EE3B;
	Sun, 28 Apr 2024 09:38:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UiSyZ+IQ";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2042.outbound.protection.outlook.com [40.107.212.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E08C310EE3B
 for <amd-gfx@lists.freedesktop.org>; Sun, 28 Apr 2024 09:38:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MOHRYfRl2LHTgJABZeeCGYFxZqKtBlfAdKUQ7gCeohYEA5x/pMEu2TU11KjiATE/kYeILD2Yur/JYjM5HhrwB/P9t2T6hSY0QVVf2iQiQ1QzMaue4mGXZ87TItMoUU0GvGyz2siH1YAM8Y/94/IXCN7ZhbWdyB4yRIHerRYvbGC14K58nxMEAf4mbByHvCufKjb33LrQsYigJ0YJVAAaQk0NM0mJvta6d+5FqzkKfSdDWLcMCG156hp/t3iHB6HohqRPgIxx76+qfEBWgoo6A6lEJQ2tyhp52hMyzxkhDyAqhS38AFyoDkCGoo6vFQLaXdQNKvlqri6RhaMPUV22ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VcgMCCVC11RH+qvhLs0jfW+A7ro9xj5601wrdL0KJiY=;
 b=NE06o4s/QHvVAvxc5Iznlu15W+3Jr8Jd7hYV1EmimgcvgYpVk0pT5Kg5MYtU6SfmWMRoobGEx76X/Br4NoH8kU1ty4Ugqv5QBSnDrmZZLdSWpxrugWu1QbsfPE34vWD9kwClj3Ci4sCT17wKX1+/DHolVuWp2wcPS9jzvqTS744UJs2sCstxdJPbszGsoirb72sSX2UB1zk2cesooQcHK7MYX5mDYSvDiQ8lqdd/dLt5MaEFcqrzu/qZbBPs4aR4KAO1d1WAcg5nc7HtVEnhZh3e4zM/0uKDdG3g1MGK9/dRGdNERERMzB0sJmoR4DT3fECGAMal5zS70pzsVT1rUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VcgMCCVC11RH+qvhLs0jfW+A7ro9xj5601wrdL0KJiY=;
 b=UiSyZ+IQAbU2o+8orBhg7Pl7J2igqWdDRZ9vP7JoSsKjqw5WMn/VEeH1hDgvVAg5oB+uxi56h1na5oOyN7sUgrqjEH1a4Uq+qUqjw0NVhhiFdOA2tYVoqgFX0wvLV+MN6IqmlKlUX/xcw0/WZ+dBfazhIUz/gLfzH7UxRr3eAxE=
Received: from BL6PEPF00016418.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:22e:400:0:1004:0:7) by SA0PR12MB4431.namprd12.prod.outlook.com
 (2603:10b6:806:95::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Sun, 28 Apr
 2024 09:38:30 +0000
Received: from BL6PEPF0001AB4F.namprd04.prod.outlook.com
 (2a01:111:f403:f902::) by BL6PEPF00016418.outlook.office365.com
 (2603:1036:903:4::a) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.24 via Frontend
 Transport; Sun, 28 Apr 2024 09:38:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL6PEPF0001AB4F.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Sun, 28 Apr 2024 09:38:29 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Sun, 28 Apr
 2024 04:38:29 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Sun, 28 Apr
 2024 04:38:29 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Sun, 28 Apr 2024 04:38:22 -0500
From: Jesse Zhang <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <Tim.Huang@amd.com>, Jesse Zhang <jesse.zhang@amd.com>, Jesse Zhang
 <Jesse.Zhang@amd.com>
Subject: [PATCH 1/3 V2] drm/amd/pm: Fix negative array index read warning for
 pptable->DpmDescriptor
Date: Sun, 28 Apr 2024 17:38:16 +0800
Message-ID: <20240428093816.2035537-1-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4F:EE_|SA0PR12MB4431:EE_
X-MS-Office365-Filtering-Correlation-Id: 9497366d-c875-4622-bad8-08dc6766f67e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|36860700004|82310400014|376005; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?yvDp0nAZH9lr2v0/DYp7kkI2VgDqRkKn+kI7Kwq3zTkaVgE0Kmry/oANFTot?=
 =?us-ascii?Q?jqgin9HiTvCQrc3FsT9NTdv3QHKWe+2qhc/r1It0yGQRuHS/UPizcfMbDziV?=
 =?us-ascii?Q?W0Ov4moKvCcgYUYT3XI8Mn98Q7X5V+Y5FrWUKxYgG64ssyr2+4NoGuMQ3dEM?=
 =?us-ascii?Q?urngg09NikZwXmEk1rSO17vCtiFFUorb4zc4wVAU043ADoB86PDYhvLWQuNH?=
 =?us-ascii?Q?Tf8xgtBAfWWcozKcFgfEA8i8Xfcqsuss7MjHSkJYI0nDGoFyW4LhBiw/D1uK?=
 =?us-ascii?Q?BYj2gMpKfMun+7hiSFLhN8E9VrEDVL6U7pFzCchjMb1Vl02T8Rqv7HSTPHLv?=
 =?us-ascii?Q?iYSxxb0OCNdydS7XIxNGMZIlLACOIMfAKcVp893JrejkMxOKegfHB6cV2cpy?=
 =?us-ascii?Q?NiwL/3mjX+KcCu3igdHrNZT1agh1+W00AabjP+R9IP6raPAy9+kHwJTDs1f4?=
 =?us-ascii?Q?IM8UZuJuYIzqA4FEK70vx3nd6kQo820upiSR1HKvZCDKSyO7tsLRa7eDLVZI?=
 =?us-ascii?Q?vCWYSDtv4QC+wE6Ldoud+4FlSCjMVqiiZeYYorD72p+jO07cloJ1ByRy0cw6?=
 =?us-ascii?Q?iETAtXVS+7TfI8aiqPgT9UtJoZaBffWJlWDpZATX4FXSJS4eolc8LqUh+4wx?=
 =?us-ascii?Q?FOfHzUMhB7Ys4UXhAA33AWjjs3gjgU06qFdTVobpH6Deb4i9T+sAYAHqZzgG?=
 =?us-ascii?Q?OYTbyANi6zCTO20+CYEIbzTWUIVaqhrJ57ekty0yaFRvifV+B0TD4ZMeIPAx?=
 =?us-ascii?Q?zg0CdhzYw6OfwKXnr+MkfZhW3ok4YMbK3a+LB50s3Ai6opLLQEJnmdKMGpoy?=
 =?us-ascii?Q?kGUkzPsKt+qC/GbDs3rBqXwqM+TWSV79e3Y7vaMWXK7SSNLmEtZtALC1qITc?=
 =?us-ascii?Q?uvwIXEZZ8SFUMgtaZN/wj0Pe5goIh5M+XKcK4tLIWcKHHWiNYOyxg6dx3+3D?=
 =?us-ascii?Q?W2VLfiy0TA8F+YpWgiJPPu4OFjmZA2yVGu4UW1gEvWxuLYUvfdwWmJE7oSy5?=
 =?us-ascii?Q?A90KvTCqKdRlXhb7xEMk0THdASxRkFcl1oJqMPZvwx8EIc2O5oNWuHamN3uR?=
 =?us-ascii?Q?q6FlY1pnNHGpdVqnjM1L4WiPP+F8BN/sxXNT07nC6E4vHWjy6/rzhqtTKLAj?=
 =?us-ascii?Q?vs/31D452od560FBt3h9xbPyoRTG1Hzx1o1TW8Ecko/EOACJTovxrlupXffe?=
 =?us-ascii?Q?5rT2MF7QpXGw5uA6UX0dRUkK01bmu+ioSGNC0V/eVDx+gKT3jEuA3tKi2rGW?=
 =?us-ascii?Q?3exVFVvINEnaWWp0afkuD81QftqT1JLZw+sjiXPrOI0bQAYtmMfiZFV0nCBa?=
 =?us-ascii?Q?SwUEaH1xApHlb4mEA3gnecmDx18fBEJTKI5AuSbPpvQCC2f5DI/0RRRPk2WC?=
 =?us-ascii?Q?ZjjISm8=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(36860700004)(82310400014)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2024 09:38:29.9124 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9497366d-c875-4622-bad8-08dc6766f67e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4431
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

Avoid using the negative values
for clk_idex as an index into an array pptable->DpmDescriptor.

V2: fix clk_index return check (Tim Huang)

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   | 27 ++++++++++++++-----
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index 5a68d365967f..c06e0d6e3017 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -1219,19 +1219,22 @@ static int navi10_get_current_clk_freq_by_table(struct smu_context *smu,
 					   value);
 }
 
-static bool navi10_is_support_fine_grained_dpm(struct smu_context *smu, enum smu_clk_type clk_type)
+static int navi10_is_support_fine_grained_dpm(struct smu_context *smu, enum smu_clk_type clk_type)
 {
 	PPTable_t *pptable = smu->smu_table.driver_pptable;
 	DpmDescriptor_t *dpm_desc = NULL;
-	uint32_t clk_index = 0;
+	int clk_index = 0;
 
 	clk_index = smu_cmn_to_asic_specific_index(smu,
 						   CMN2ASIC_MAPPING_CLK,
 						   clk_type);
+	if (clk_index < 0)
+		return clk_index;
+
 	dpm_desc = &pptable->DpmDescriptor[clk_index];
 
 	/* 0 - Fine grained DPM, 1 - Discrete DPM */
-	return dpm_desc->SnapToDiscrete == 0;
+	return dpm_desc->SnapToDiscrete == 0 ? 1 : 0;
 }
 
 static inline bool navi10_od_feature_is_supported(struct smu_11_0_overdrive_table *od_table, enum SMU_11_0_ODFEATURE_CAP cap)
@@ -1287,7 +1290,11 @@ static int navi10_emit_clk_levels(struct smu_context *smu,
 		if (ret)
 			return ret;
 
-		if (!navi10_is_support_fine_grained_dpm(smu, clk_type)) {
+		ret = navi10_is_support_fine_grained_dpm(smu, clk_type);
+		if (ret < 0)
+			return ret;
+
+		if (!ret) {
 			for (i = 0; i < count; i++) {
 				ret = smu_v11_0_get_dpm_freq_by_index(smu,
 								      clk_type, i, &value);
@@ -1496,7 +1503,11 @@ static int navi10_print_clk_levels(struct smu_context *smu,
 		if (ret)
 			return size;
 
-		if (!navi10_is_support_fine_grained_dpm(smu, clk_type)) {
+		ret = navi10_is_support_fine_grained_dpm(smu, clk_type);
+		if (ret < 0)
+			return ret;
+
+		if (!ret) {
 			for (i = 0; i < count; i++) {
 				ret = smu_v11_0_get_dpm_freq_by_index(smu, clk_type, i, &value);
 				if (ret)
@@ -1665,7 +1676,11 @@ static int navi10_force_clk_levels(struct smu_context *smu,
 	case SMU_UCLK:
 	case SMU_FCLK:
 		/* There is only 2 levels for fine grained DPM */
-		if (navi10_is_support_fine_grained_dpm(smu, clk_type)) {
+		ret = navi10_is_support_fine_grained_dpm(smu, clk_type);
+		if (ret < 0)
+			return ret;
+
+		if (ret) {
 			soft_max_level = (soft_max_level >= 1 ? 1 : 0);
 			soft_min_level = (soft_min_level >= 1 ? 1 : 0);
 		}
-- 
2.25.1

