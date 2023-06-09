Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25D27C7EE29
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Jun 2023 10:45:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB17010E681;
	Fri,  9 Jun 2023 10:45:46 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2061c.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::61c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 244F310E681
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Jun 2023 10:45:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZS6dbJOKOs+pwgPuo9MYODT/qxmYJIiAREq0nOylJYg1+GTqg+sM5aaSSfRBC9a0bD6Ae7KjLZqTHaCySrJyCgej+G+5lpD0GZw5AlnVDe4h8E7e6bfJb6teQUXW/jRYc7HawshMwgabnQtQMTRaX8CkzTu4Kxx+f1dPTlrkWsleQTq045Y474T7QqwdC8YekIALL15t0Z5wVQxE2xKsIPQS1ouQOwFV+khKkwOLLWJqwRIls3qIt5OQLVC8K+f3RLDoHM/OJE54kjuL5Q+uykC8bty7rgGG2YFplWwhUubmssSnBGvsVZX282GjyQF2p0HpOJCfu05EUo/Mqp5csw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dp1uKd8XFpu8q661EbmJf8bg2OAbguImxR4WMM57Enk=;
 b=Cz9zTTVuJ0IWyM95kZalyho2e5LjlHqsavFOlsXjkqxR673MzEQICnEdXP3+xuCeIC6cLazCsWXvs4r8VD0JKIedjStFT2yRKGIcuEP1HCCpLUQxmKoAN6hWnIld/3CPRYI/uf4hiTcWIQxK1DCY0FY9OY6fcUkQVdhlAnJ+KmUAic72LrVt5zWaBx7bPGkN1Mvrqp4bXtJhIkpmPxluy5ww0rr5wyqC4pqYQ2e+/LeZ8xcBhfcbgh46Sxc845aErp+rqSiKYFvixjX6MMpuO0GNH2tgWhix/DPTo/VwPzK3UVULAmz9Mg0puiK75zTJ94S7Wx5RuUZyg/eAY2av5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dp1uKd8XFpu8q661EbmJf8bg2OAbguImxR4WMM57Enk=;
 b=PyKhmmX4+NRaNf7L20ui06EoQ0CqPvh/panSxxXK+yv9BF75l31xGbCBgplOxsQ1Jqt7pK+sMnUDGSVT7h0KzQ7/e98x0XabLlVnPtmqa3EDQB321kn0GDqQOI1mtQkp86UXNJcc54PtcZdLZukLe3GXeIaBXxbz6cwLIiVvGD4=
Received: from DS7PR07CA0018.namprd07.prod.outlook.com (2603:10b6:5:3af::27)
 by BL1PR12MB5971.namprd12.prod.outlook.com (2603:10b6:208:39a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Fri, 9 Jun
 2023 10:45:40 +0000
Received: from MWH0EPF000989E9.namprd02.prod.outlook.com
 (2603:10b6:5:3af:cafe::91) by DS7PR07CA0018.outlook.office365.com
 (2603:10b6:5:3af::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.27 via Frontend
 Transport; Fri, 9 Jun 2023 10:45:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E9.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6477.22 via Frontend Transport; Fri, 9 Jun 2023 10:45:39 +0000
Received: from ldev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 9 Jun
 2023 05:45:35 -0500
From: Tim Huang <Tim.Huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/3] drm/amd/pm: enable more Pstates profile levels for SMU
 v13.0.5
Date: Fri, 9 Jun 2023 18:44:27 +0800
Message-ID: <20230609104427.636097-3-Tim.Huang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230609104427.636097-1-Tim.Huang@amd.com>
References: <20230609104427.636097-1-Tim.Huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E9:EE_|BL1PR12MB5971:EE_
X-MS-Office365-Filtering-Correlation-Id: 28a51a33-40c8-4581-ac1d-08db68d6aaa2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8zDo3tJ6yVdiiwz+5IKP1XzjCrklwg82SQq4sUsdGPnDQDU+5g8LnKY5kzg3XcSbylNC8LlMcRwDNfSco5AwqQvfbcO07b1Zgkh2fWAl1xeEoBJ1VDlyof0X2kZoMnOpa8vcZ3CylMZtVAxfqg5DPTD6v6t4xpRDx3Jsuqc+nWVLge4hTMMkv/jgx9MnshzVMt3I91Cd3a4Zwpy5hUHiHHHpYLfqnAwNC5o2L9mN+MH4LBT/FIRTme0qaOHzFLiS+UXWrkRqEm2m0ddLvm6CCDUtVHXOiizDmcF0vWmOiF+QUcuSyhps8PekoPnbxWcNbfFEYIfG5Z5cF7qUxgaV7JiS6R6vuT4ilVI2X6fTa5yHg5dgv2EERNs0dml+c4VON6InS97Km4vZzNdLsrPD/UmiaLYJUsQtHBZVzhidLuQ2yAwphvT7WUu/Fe0pQgnpqgzhJzRG3/ihEsEnsLbse9CG7uo/3VSjlGoqs0wnJVNoBc1hKLbj7dk23VhE+HOXHjMXnKub3ciu4al21nfsr6u0nbpyL85Zo/p0BfQnI8HsX1JEVuhV0sLFt7PzJ5bbID53UZFr6lsjWyjUtYnbpjMVp+modP4wprFsaPX4ZfI1vaqWTJYYxfK6QHaOfqveGNHFLwu21UozQo/SwiEckV+iA75Xf4hxL/lygmLJv76YiHbH0ALzMeldJPkBRhnpNjOA+HJL3Q9pxXQkf58DppgwpYBtJekW/hAO2xzVnNLKDEUhHvffUVmlDfNEWoRtgOQN8VeH2joktt7vEOEfhQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(39860400002)(396003)(376002)(136003)(451199021)(40470700004)(36840700001)(46966006)(40480700001)(7696005)(82740400003)(70586007)(81166007)(478600001)(54906003)(6916009)(316002)(336012)(356005)(47076005)(8936002)(186003)(41300700001)(8676002)(4326008)(70206006)(2616005)(426003)(36860700001)(6666004)(40460700003)(83380400001)(1076003)(26005)(16526019)(86362001)(82310400005)(2906002)(36756003)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2023 10:45:39.6728 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 28a51a33-40c8-4581-ac1d-08db68d6aaa2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5971
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
Cc: Alexander.Deucher@amd.com, Yifan1.zhang@amd.com, jesse.zhang@amd.com,
 Tim Huang <Tim.Huang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This patch enables following UMD stable Pstates profile
levels for power_dpm_force_performance_level interface.

- profile_peak
- profile_min_sclk
- profile_standard

Signed-off-by: Tim Huang <Tim.Huang@amd.com>
---
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c  | 40 ++++++++++++++++++-
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.h  |  2 +-
 2 files changed, 39 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c
index 53c508acf895..42f110602eb1 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c
@@ -978,6 +978,38 @@ static int smu_v13_0_5_force_clk_levels(struct smu_context *smu,
 	return ret;
 }
 
+static int smu_v13_0_5_get_dpm_profile_freq(struct smu_context *smu,
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
+		clk_limit = SMU_13_0_5_UMD_PSTATE_GFXCLK;
+		if (level == AMD_DPM_FORCED_LEVEL_PROFILE_PEAK)
+			smu_v13_0_5_get_dpm_ultimate_freq(smu, SMU_SCLK, NULL, &clk_limit);
+		else if (level == AMD_DPM_FORCED_LEVEL_PROFILE_MIN_SCLK)
+			smu_v13_0_5_get_dpm_ultimate_freq(smu, SMU_SCLK, &clk_limit, NULL);
+		break;
+	case SMU_VCLK:
+		smu_v13_0_5_get_dpm_ultimate_freq(smu, SMU_VCLK, NULL, &clk_limit);
+		break;
+	case SMU_DCLK:
+		smu_v13_0_5_get_dpm_ultimate_freq(smu, SMU_DCLK, NULL, &clk_limit);
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+	*min_clk = *max_clk = clk_limit;
+	return ret;
+}
+
 static int smu_v13_0_5_set_performance_level(struct smu_context *smu,
 						enum amd_dpm_forced_level level)
 {
@@ -1011,10 +1043,14 @@ static int smu_v13_0_5_set_performance_level(struct smu_context *smu,
 		break;
 	case AMD_DPM_FORCED_LEVEL_PROFILE_STANDARD:
 	case AMD_DPM_FORCED_LEVEL_PROFILE_MIN_SCLK:
-	case AMD_DPM_FORCED_LEVEL_PROFILE_MIN_MCLK:
 	case AMD_DPM_FORCED_LEVEL_PROFILE_PEAK:
-		/* Temporarily do nothing since the optimal clocks haven't been provided yet */
+		smu_v13_0_5_get_dpm_profile_freq(smu, level, SMU_SCLK, &sclk_min, &sclk_max);
+		smu_v13_0_5_get_dpm_profile_freq(smu, level, SMU_VCLK, &vclk_min, &vclk_max);
+		smu_v13_0_5_get_dpm_profile_freq(smu, level, SMU_DCLK, &dclk_min, &dclk_max);
 		break;
+	case AMD_DPM_FORCED_LEVEL_PROFILE_MIN_MCLK:
+		dev_err(adev->dev, "The performance level profile_min_mclk is not supported.");
+		return -EOPNOTSUPP;
 	case AMD_DPM_FORCED_LEVEL_MANUAL:
 	case AMD_DPM_FORCED_LEVEL_PROFILE_EXIT:
 		return 0;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.h b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.h
index 40bc0f8e6d61..263cd651855e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.h
@@ -24,6 +24,6 @@
 #define __SMU_V13_0_5_PPT_H__
 
 extern void smu_v13_0_5_set_ppt_funcs(struct smu_context *smu);
-#define SMU_13_0_5_UMD_PSTATE_GFXCLK   1100
+#define SMU_13_0_5_UMD_PSTATE_GFXCLK   700
 
 #endif
-- 
2.34.1

