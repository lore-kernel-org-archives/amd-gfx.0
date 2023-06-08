Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB66BC7EE25
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Jun 2023 03:28:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 60D1610E581;
	Thu,  8 Jun 2023 03:28:41 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2066.outbound.protection.outlook.com [40.107.96.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 269B310E581
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Jun 2023 03:28:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QEe69N3IFBNRGyEJcsB4J+dYBN0nGWcv45p5HJtHXpAtXNpikK2PTstiExj5WoPOUrnXChjqqDy8p21BRRaaGRJpeN/GtxeWTAIK0BH/FcO563D5PlWvD5CdXyCv9odbXBZn8lyAwFfOXDCP1nswR/bLzcavDn5nc79LYhEwTlGO23dcd/WN0a9iBTLHnGfbGpGQDiZkryLUYgmU1O60BKEbb+5/tJlfJlG48gCjD7v8vtRvvdpcUtaA8HLJxamuZCKDLRLU3GmXzHDtTe0LIVQbMrlReWWp9qaIk1Jsqz8JVIO5dfXgKXY4UQaUFaby5XfXveBdtFFf3qzZ3UzRpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K0sri4d/ZmQ5N97YnWDRdxv8uOECK/LUovte40ry/P8=;
 b=TNf8wGnF3wafnd8wC9+JVtDvE0cLZHg5CpvjA79Iu5El588DWjmB16pxQ6GvAV7inVNERd+X75ADQsO7s7xp0FQVcGA7FVbuyt/iQeOlnMtdltySjFMAw98fo7/yDo1fY6zGwC8VO0qL5r15OjknPXA4sulHqffVdYUSpNG7HKH+oZMEaim8/VomigSenHm15aIncoYUGOTda1OjTzb+I4vfCPVmFEyd6pDvuly6EgdPW5UpPWf8AoBytTWt+vLJ93TjY4lB7f03urFA9OfARP0PrYr5qRUiGQzYa+7LX1Yr+pfV70jMURerJnz87WYAr57cSxIsTCwKp4E0yQ4kRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K0sri4d/ZmQ5N97YnWDRdxv8uOECK/LUovte40ry/P8=;
 b=ggK2KcNykYc1SQ3WSUGDPPPwU/3/fP+URRTiwnX69ruEyBLaMVdeou81rmPKP7FaZwsRWRmy1yxM8FBmAkdq8mfobrUF9NmjbJrmDt6pMmflYgrnvFreaDwBcHS6NhvgFyL++d8Cla7mXDRAQ/xnaaN36GxKaZbBcE7gbUibViw=
Received: from MW4PR04CA0183.namprd04.prod.outlook.com (2603:10b6:303:86::8)
 by DM6PR12MB4187.namprd12.prod.outlook.com (2603:10b6:5:212::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Thu, 8 Jun
 2023 03:28:36 +0000
Received: from CO1NAM11FT088.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:86:cafe::ce) by MW4PR04CA0183.outlook.office365.com
 (2603:10b6:303:86::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33 via Frontend
 Transport; Thu, 8 Jun 2023 03:28:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT088.mail.protection.outlook.com (10.13.175.131) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6455.36 via Frontend Transport; Thu, 8 Jun 2023 03:28:35 +0000
Received: from master-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 7 Jun
 2023 22:28:32 -0500
From: shikaguo <shikai.guo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2] drm/amd/pm: enable more Pstates profile levels for
 yellow_carp
Date: Thu, 8 Jun 2023 11:27:47 +0800
Message-ID: <20230608032747.1782194-1-shikai.guo@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT088:EE_|DM6PR12MB4187:EE_
X-MS-Office365-Filtering-Correlation-Id: c7aa2a22-317b-418c-8be2-08db67d071a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GvpfkJk4K6mnxlUFuqjXHRn+pc66Xn0T2hav3+bsdrd3W9yyebbrEH94EnXd/VwKp5P3RT4RG1OO1kA+IzACGl38BTzHdlFx1eIDxAi0G8SAtaqaJA8K0F8UkQdRF9v0EH5WL+P2FRwPLhgRA7QKSU5RKGNICUitOPdoRKwubPIQthRBM87EVIwn/fzQJkf7pSg/TQQir9NWqndHIJuhzPlE0Sy3/pNH9VOu6bo7MSe/JT7yTdkPD/nPHqKSzEHZb8xBGOa+liaIh00KEG2dCUd7HgYFAUVBtyG3xbXF5SdmKF08GCQuoTEcuWhI/kj3n1kbK+OFrka+ZT+o2CuZl3020dUJWK0GhIwj0mUfX++DCQS8O0X1E5SgzPG+I8YlKb/08PUBMqvN3gv2k6I31zAuwWtcYbaQ9P1xPNlVMHisKq+CKws5ZZV0fNhp6x+R3nDc+IGR98MWN2gQYvwgr0q1RODBJovz9uyErwcJ7lIdiBM7JYWauASl89TLZTEYfWkDoL3EQ+RsjSDWsw0Ya0/8l7Z41oF7gIM3BqnJiiFmHzNUVurLZp8qT3hCNPpGbqZ1Qq0bU8MI5i3yYXzCjuQWvlBomLHAPtjxC5ptw2nBH/pAIE9VhhhGDwbRpbh5fUInvpXStcIh/RYtUPC60roPLHqZI+Ef7X28nUDzrkcYKwOSg3EFaAaRFZoyXDFO9hkP5AfC2UcIoprmYKST1iv3D5mILN+Jj/nE6iFNY3GV/MwLFrsvl4JcausSkvCkaQB/N5o4cdrQxjfiTq0dXYxZbTBz0iR/S+ZYye6re255WcZIgTw1ur3BxJyAAYxI5WkNj/RlcWET+m4jo/NWZg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(39860400002)(136003)(346002)(376002)(451199021)(36840700001)(46966006)(40470700004)(70586007)(7696005)(6666004)(2906002)(82740400003)(356005)(81166007)(70206006)(54906003)(8676002)(86362001)(5660300002)(36756003)(8936002)(6916009)(316002)(40480700001)(4326008)(41300700001)(478600001)(40460700003)(336012)(2616005)(82310400005)(26005)(1076003)(186003)(36860700001)(426003)(83380400001)(16526019)(47076005)(43062005)(16060500005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2023 03:28:35.8468 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c7aa2a22-317b-418c-8be2-08db67d071a6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT088.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4187
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
Cc: Alexander.Deucher@amd.com, tim.huang@amd.com, prike.liang@amd.com,
 aaron.liu@amd.com, shikaguo <shikai.guo@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This patch enables following UMD stable Pstates profile levels for power_dpm_force_performance_level interface.

- profile_peak
- profile_min_mclk
- profile_min_sclk
- profile_standard

Signed-off-by: shikaguo <shikai.guo@amd.com>
---
 .../drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c  | 94 ++++++++++++++++++-
 .../drm/amd/pm/swsmu/smu13/yellow_carp_ppt.h  |  5 +-
 2 files changed, 95 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
index a92da336ecec..5c968ab2ea8d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
@@ -957,6 +957,9 @@ static int yellow_carp_set_soft_freq_limited_range(struct smu_context *smu,
 							uint32_t max)
 {
 	enum smu_message_type msg_set_min, msg_set_max;
+	uint32_t min_clk = min;
+	uint32_t max_clk = max;
+
 	int ret = 0;
 
 	if (!yellow_carp_clk_dpm_is_enabled(smu, clk_type))
@@ -985,11 +988,17 @@ static int yellow_carp_set_soft_freq_limited_range(struct smu_context *smu,
 		return -EINVAL;
 	}
 
-	ret = smu_cmn_send_smc_msg_with_param(smu, msg_set_min, min, NULL);
+	if (clk_type == SMU_VCLK) {
+		min_clk = min << SMU_13_VCLK_SHIFT;
+		max_clk = max << SMU_13_VCLK_SHIFT;
+	}
+
+	ret = smu_cmn_send_smc_msg_with_param(smu, msg_set_min, min_clk, NULL);
+
 	if (ret)
 		goto out;
 
-	ret = smu_cmn_send_smc_msg_with_param(smu, msg_set_max, max, NULL);
+	ret = smu_cmn_send_smc_msg_with_param(smu, msg_set_max, max_clk, NULL);
 	if (ret)
 		goto out;
 
@@ -1107,6 +1116,50 @@ static int yellow_carp_force_clk_levels(struct smu_context *smu,
 	return ret;
 }
 
+static int yellow_carp_get_dpm_profile_freq(struct smu_context *smu,
+					enum amd_dpm_forced_level level,
+					enum smu_clk_type clk_type,
+					uint32_t *min_clk,
+					uint32_t *max_clk)
+{
+	int ret = 0;
+	uint32_t clk_limit = 0;
+
+	switch (clk_type) {
+	case SMU_GFXCLK:
+	case SMU_SCLK:
+		clk_limit = YELLOW_CARP_UMD_PSTATE_GFXCLK;
+		if (level == AMD_DPM_FORCED_LEVEL_PROFILE_PEAK)
+			yellow_carp_get_dpm_ultimate_freq(smu, SMU_SCLK, NULL, &clk_limit);
+		else if (level == AMD_DPM_FORCED_LEVEL_PROFILE_MIN_SCLK)
+			yellow_carp_get_dpm_ultimate_freq(smu, SMU_SCLK, &clk_limit, NULL);
+		break;
+	case SMU_SOCCLK:
+		clk_limit = YELLOW_CARP_UMD_PSTATE_SOCCLK;
+		if (level == AMD_DPM_FORCED_LEVEL_PROFILE_PEAK)
+			yellow_carp_get_dpm_ultimate_freq(smu, SMU_SOCCLK, NULL, &clk_limit);
+		break;
+	case SMU_FCLK:
+		clk_limit = YELLOW_CARP_UMD_PSTATE_FCLK;
+		if (level == AMD_DPM_FORCED_LEVEL_PROFILE_PEAK)
+			yellow_carp_get_dpm_ultimate_freq(smu, SMU_FCLK, NULL, &clk_limit);
+		else if (level == AMD_DPM_FORCED_LEVEL_PROFILE_MIN_MCLK)
+			yellow_carp_get_dpm_ultimate_freq(smu, SMU_FCLK, &clk_limit, NULL);
+		break;
+	case SMU_VCLK:
+		yellow_carp_get_dpm_ultimate_freq(smu, SMU_VCLK, NULL, &clk_limit);
+		break;
+	case SMU_DCLK:
+		yellow_carp_get_dpm_ultimate_freq(smu, SMU_DCLK, NULL, &clk_limit);
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+	*min_clk = *max_clk = clk_limit;
+	return ret;
+}
+
 static int yellow_carp_set_performance_level(struct smu_context *smu,
 						enum amd_dpm_forced_level level)
 {
@@ -1114,6 +1167,9 @@ static int yellow_carp_set_performance_level(struct smu_context *smu,
 	uint32_t sclk_min = 0, sclk_max = 0;
 	uint32_t fclk_min = 0, fclk_max = 0;
 	uint32_t socclk_min = 0, socclk_max = 0;
+	uint32_t vclk_min = 0, vclk_max = 0;
+	uint32_t dclk_min = 0, dclk_max = 0;
+
 	int ret = 0;
 
 	switch (level) {
@@ -1121,28 +1177,42 @@ static int yellow_carp_set_performance_level(struct smu_context *smu,
 		yellow_carp_get_dpm_ultimate_freq(smu, SMU_SCLK, NULL, &sclk_max);
 		yellow_carp_get_dpm_ultimate_freq(smu, SMU_FCLK, NULL, &fclk_max);
 		yellow_carp_get_dpm_ultimate_freq(smu, SMU_SOCCLK, NULL, &socclk_max);
+		yellow_carp_get_dpm_ultimate_freq(smu, SMU_VCLK, NULL, &vclk_max);
+		yellow_carp_get_dpm_ultimate_freq(smu, SMU_DCLK, NULL, &dclk_max);
 		sclk_min = sclk_max;
 		fclk_min = fclk_max;
 		socclk_min = socclk_max;
+		vclk_min = vclk_max;
+		dclk_min = dclk_max;
 		break;
 	case AMD_DPM_FORCED_LEVEL_LOW:
 		yellow_carp_get_dpm_ultimate_freq(smu, SMU_SCLK, &sclk_min, NULL);
 		yellow_carp_get_dpm_ultimate_freq(smu, SMU_FCLK, &fclk_min, NULL);
 		yellow_carp_get_dpm_ultimate_freq(smu, SMU_SOCCLK, &socclk_min, NULL);
+		yellow_carp_get_dpm_ultimate_freq(smu, SMU_VCLK, &vclk_min, NULL);
+		yellow_carp_get_dpm_ultimate_freq(smu, SMU_DCLK, &dclk_min, NULL);
 		sclk_max = sclk_min;
 		fclk_max = fclk_min;
 		socclk_max = socclk_min;
+		vclk_max = vclk_min;
+		dclk_max = dclk_min;
 		break;
 	case AMD_DPM_FORCED_LEVEL_AUTO:
 		yellow_carp_get_dpm_ultimate_freq(smu, SMU_SCLK, &sclk_min, &sclk_max);
 		yellow_carp_get_dpm_ultimate_freq(smu, SMU_FCLK, &fclk_min, &fclk_max);
 		yellow_carp_get_dpm_ultimate_freq(smu, SMU_SOCCLK, &socclk_min, &socclk_max);
+		yellow_carp_get_dpm_ultimate_freq(smu, SMU_VCLK, &vclk_min, &vclk_max);
+		yellow_carp_get_dpm_ultimate_freq(smu, SMU_DCLK, &dclk_min, &dclk_max);
 		break;
 	case AMD_DPM_FORCED_LEVEL_PROFILE_STANDARD:
 	case AMD_DPM_FORCED_LEVEL_PROFILE_MIN_SCLK:
 	case AMD_DPM_FORCED_LEVEL_PROFILE_MIN_MCLK:
 	case AMD_DPM_FORCED_LEVEL_PROFILE_PEAK:
-		/* Temporarily do nothing since the optimal clocks haven't been provided yet */
+		yellow_carp_get_dpm_profile_freq(smu, level, SMU_SCLK, &sclk_min, &sclk_max);
+		yellow_carp_get_dpm_profile_freq(smu, level, SMU_FCLK, &fclk_min, &fclk_max);
+		yellow_carp_get_dpm_profile_freq(smu, level, SMU_SOCCLK, &socclk_min, &socclk_max);
+		yellow_carp_get_dpm_profile_freq(smu, level, SMU_VCLK, &vclk_min, &vclk_max);
+		yellow_carp_get_dpm_profile_freq(smu, level, SMU_DCLK, &dclk_min, &dclk_max);
 		break;
 	case AMD_DPM_FORCED_LEVEL_MANUAL:
 	case AMD_DPM_FORCED_LEVEL_PROFILE_EXIT:
@@ -1182,6 +1252,24 @@ static int yellow_carp_set_performance_level(struct smu_context *smu,
 			return ret;
 	}
 
+	if (vclk_min && vclk_max) {
+		ret = yellow_carp_set_soft_freq_limited_range(smu,
+							      SMU_VCLK,
+							      vclk_min,
+							      vclk_max);
+		if (ret)
+			return ret;
+	}
+
+	if (dclk_min && dclk_max) {
+		ret = yellow_carp_set_soft_freq_limited_range(smu,
+							      SMU_DCLK,
+							      dclk_min,
+							      dclk_max);
+		if (ret)
+			return ret;
+	}
+
 	return ret;
 }
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.h b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.h
index a9205a8ea3ad..5ad4058b5e45 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.h
@@ -24,6 +24,9 @@
 #define __YELLOW_CARP_PPT_H__
 
 extern void yellow_carp_set_ppt_funcs(struct smu_context *smu);
-#define YELLOW_CARP_UMD_PSTATE_GFXCLK       1100
+
+#define YELLOW_CARP_UMD_PSTATE_GFXCLK       700
+#define YELLOW_CARP_UMD_PSTATE_SOCCLK		678
+#define YELLOW_CARP_UMD_PSTATE_FCLK			1800
 
 #endif
-- 
2.25.1

