Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45151C7EE43
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Jun 2023 08:03:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C331C10E45B;
	Wed,  7 Jun 2023 08:03:48 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2068.outbound.protection.outlook.com [40.107.94.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D187C10E456
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Jun 2023 08:03:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oatBD9FlEahxx1ojmFx/gX6jdY2f9ygu0Z+jWn4x4PcQFeUt2fN3ZW4Agu9iow3JOYpcCvvGIU431g9KxB+pYFivR7ixHQRUbQpi3YMXYqmtM1QX9KJx8On2caTJvkDPmZAkmYKtImxwR+3QWbyYJSIDuHUUvRlBIn8fedEzvDtgpHFmen/x+cNtdPw0YYQbQAEtfvUJN9WQvjftq8kTNhXYKblDSh9R3++k+6mDDlOhBDV9vFSFSJin0oq8qvJPFZEO4WKnWb3aD64YyfuZUbOh9RXl+6AUFqLgjnBxG6+GsUkYChJxyfm+dqg6pPwzQsJkyz5a8rXjGsFzOKiWxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/kNkI0U9YLHooaKAS6lWjVYTBABdYz3NqXY0I0lrz08=;
 b=GVZhRpvfnlc9zKkUUBNVzNOQDvnx9dEvqUcCi7AwBivRucVOjQRo24cQnH3HXExVV9xHukYd0vPoBc2xMHphgTPCzwGUKxuUPZpJHnMBRW8RJ8zk0i+qEkDLIf0hnIj+aVqxC4HhWSaww0hMRbFck+IZVjlVILXHEx051pUkB2wal2nG04CElUSfAY3QksetSMBIpgp3XyUZp88KefYZnX5Z0T9r0HnNgcJLRh1pJj0//JKYCuSZAE9DvYuNaywIiHrz+cfmmE4j4IFaZp5KLnF1E5+pjj4Y6D1gQH1hHbTxbDI947n+3+vfmmpUixzcGrOiUIIn1bpjRmlGy35Wag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/kNkI0U9YLHooaKAS6lWjVYTBABdYz3NqXY0I0lrz08=;
 b=Bhp1UXwsGjdYO8HMhkSVBoIhltK/FvaaEPU0tZnJ3iyB0YWKCaXV21QH6HFCPO6uN0hoipx0EADcWlcMar0pNKXbEnA4PR1HDAJ0K4gDbNiTJ1gszsxUYklMRyjQDS92+2SK5KfYC8DiTX0zlk2wYojxxbN6SlJGYHXuvh6VQU8=
Received: from CY5PR19CA0043.namprd19.prod.outlook.com (2603:10b6:930:1a::33)
 by IA1PR12MB8360.namprd12.prod.outlook.com (2603:10b6:208:3d8::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Wed, 7 Jun
 2023 08:03:43 +0000
Received: from CY4PEPF0000EE31.namprd05.prod.outlook.com
 (2603:10b6:930:1a:cafe::4d) by CY5PR19CA0043.outlook.office365.com
 (2603:10b6:930:1a::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33 via Frontend
 Transport; Wed, 7 Jun 2023 08:03:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE31.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6477.13 via Frontend Transport; Wed, 7 Jun 2023 08:03:43 +0000
Received: from ldev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 7 Jun
 2023 03:03:40 -0500
From: Tim Huang <Tim.Huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/3] drm/amd/pm: enable more Pstates profile levels for SMU
 v13.0.4
Date: Wed, 7 Jun 2023 16:02:30 +0800
Message-ID: <20230607080230.3867810-3-Tim.Huang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230607080230.3867810-1-Tim.Huang@amd.com>
References: <20230607080230.3867810-1-Tim.Huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE31:EE_|IA1PR12MB8360:EE_
X-MS-Office365-Filtering-Correlation-Id: 15622013-f63a-445c-3072-08db672db640
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aS3yl1D9U+FHbn+MR0uf4fXFycbSkOSDegYF/Hk3K+D/k2oG17x1XyduKDien/PiwhbivB+OS6XqrpVLlE8yNe0giZsyWObEf9h9v7iQidKldSVkG73h/Wpy5saPdI+3dvsRQAJWyI7uC96jakeFlB+grce5nUhKppTqXmEWVkfDEnSuTrQ9PzT3KtvQYCKboA4kabYVD9yuzeTwMc77Dq5hDQvsafFbxqZQ3Hbblb5KlUXEVBjhwEu6Q+FD16oVnLc6oc5klQbdimhct4y1EwU+SnuJUOIP0FTK/NFlfMEY2jOTZjAJ8Oglm0imWg06ohPtwpRgQnvwDRmccstZPGtlzAcDUpAFCq6KzmT9ocA0g0jNnuqA3czNXo/UEn3rFP06L4f+7dkciVj1ZeKrKf5aIux4NX0dpwnv1j80iXo+FugyEFT4s4Q69lTBvj2J1/WfykrzsRpubpAfW6WeaC4ad277omGgfQfYM8twa9fiEm0Z+GI080gF+bB/bM/y0dOqTrIHQeKa2CwzNFP+3GGcpTdsy25H/HB3OBw5S0D0AoNGkZNSnFMBk7s6JmFP0DO7Pari8VIu+an8j9Goir2IEQJPRuC6fU6FA+A/UhWkgN4FhHv+LLpPlt0z7+yQEJT1t14geE9GnHgzyeyEdbdYX5M8hQYtDGaD7/plGyMAbOBI7X32QLVZLQSIt4a6nKkaG6k5hH6MpbbH5ma6YbLYTJ4+oTSZCGAmxDQdwPW+fneOyElS4va1jIONu2bQfZwTnBnpdFdCG04TLzy/MQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(136003)(346002)(39860400002)(376002)(451199021)(36840700001)(40470700004)(46966006)(1076003)(26005)(16526019)(336012)(426003)(2616005)(83380400001)(47076005)(186003)(36860700001)(82310400005)(6666004)(356005)(81166007)(82740400003)(2906002)(70586007)(70206006)(7696005)(40460700003)(8676002)(8936002)(5660300002)(36756003)(54906003)(86362001)(478600001)(41300700001)(40480700001)(316002)(4326008)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 08:03:43.0968 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 15622013-f63a-445c-3072-08db672db640
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE31.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8360
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
Cc: Alexander.Deucher@amd.com, Yifan1.zhang@amd.com, aaron.liu@amd.com,
 Tim Huang <Tim.Huang@amd.com>, shikai.guo@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This patch enables following UMD stable Pstates profile
levels for power_dpm_force_performance_level interface.

- profile_peak
- profile_min_mclk
- profile_min_sclk
- profile_standard

Signed-off-by: Tim Huang <Tim.Huang@amd.com>
---
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c  | 54 ++++++++++++++++++-
 1 file changed, 53 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c
index 315a6d8bde2e..ef37dda9908f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c
@@ -54,6 +54,10 @@
 
 #define FEATURE_MASK(feature) (1ULL << feature)
 
+#define SMU_13_0_4_UMD_PSTATE_GFXCLK			938
+#define SMU_13_0_4_UMD_PSTATE_SOCCLK			938
+#define SMU_13_0_4_UMD_PSTATE_FCLK			1875
+
 #define SMC_DPM_FEATURE ( \
 	FEATURE_MASK(FEATURE_CCLK_DPM_BIT) | \
 	FEATURE_MASK(FEATURE_VCN_DPM_BIT)	 | \
@@ -908,6 +912,50 @@ static int smu_v13_0_4_force_clk_levels(struct smu_context *smu,
 	return ret;
 }
 
+static int smu_v13_0_4_get_dpm_profile_freq(struct smu_context *smu,
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
+		clk_limit = SMU_13_0_4_UMD_PSTATE_GFXCLK;
+		if (level == AMD_DPM_FORCED_LEVEL_PROFILE_PEAK)
+			smu_v13_0_4_get_dpm_ultimate_freq(smu, SMU_SCLK, NULL, &clk_limit);
+		else if (level == AMD_DPM_FORCED_LEVEL_PROFILE_MIN_SCLK)
+			smu_v13_0_4_get_dpm_ultimate_freq(smu, SMU_SCLK, &clk_limit, NULL);
+		break;
+	case SMU_SOCCLK:
+		clk_limit = SMU_13_0_4_UMD_PSTATE_SOCCLK;
+		if (level == AMD_DPM_FORCED_LEVEL_PROFILE_PEAK)
+			smu_v13_0_4_get_dpm_ultimate_freq(smu, SMU_SOCCLK, NULL, &clk_limit);
+		break;
+	case SMU_FCLK:
+		clk_limit = SMU_13_0_4_UMD_PSTATE_FCLK;
+		if (level == AMD_DPM_FORCED_LEVEL_PROFILE_PEAK)
+			smu_v13_0_4_get_dpm_ultimate_freq(smu, SMU_FCLK, NULL, &clk_limit);
+		else if (level == AMD_DPM_FORCED_LEVEL_PROFILE_MIN_MCLK)
+			smu_v13_0_4_get_dpm_ultimate_freq(smu, SMU_FCLK, &clk_limit, NULL);
+		break;
+	case SMU_VCLK:
+		smu_v13_0_4_get_dpm_ultimate_freq(smu, SMU_VCLK, NULL, &clk_limit);
+		break;
+	case SMU_DCLK:
+		smu_v13_0_4_get_dpm_ultimate_freq(smu, SMU_DCLK, NULL, &clk_limit);
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+	*min_clk = *max_clk = clk_limit;
+	return ret;
+}
+
 static int smu_v13_0_4_set_performance_level(struct smu_context *smu,
 					     enum amd_dpm_forced_level level)
 {
@@ -955,7 +1003,11 @@ static int smu_v13_0_4_set_performance_level(struct smu_context *smu,
 	case AMD_DPM_FORCED_LEVEL_PROFILE_MIN_SCLK:
 	case AMD_DPM_FORCED_LEVEL_PROFILE_MIN_MCLK:
 	case AMD_DPM_FORCED_LEVEL_PROFILE_PEAK:
-		/* Temporarily do nothing since the optimal clocks haven't been provided yet */
+		smu_v13_0_4_get_dpm_profile_freq(smu, level, SMU_SCLK, &sclk_min, &sclk_max);
+		smu_v13_0_4_get_dpm_profile_freq(smu, level, SMU_FCLK, &fclk_min, &fclk_max);
+		smu_v13_0_4_get_dpm_profile_freq(smu, level, SMU_SOCCLK, &socclk_min, &socclk_max);
+		smu_v13_0_4_get_dpm_profile_freq(smu, level, SMU_VCLK, &vclk_min, &vclk_max);
+		smu_v13_0_4_get_dpm_profile_freq(smu, level, SMU_DCLK, &dclk_min, &dclk_max);
 		break;
 	case AMD_DPM_FORCED_LEVEL_MANUAL:
 	case AMD_DPM_FORCED_LEVEL_PROFILE_EXIT:
-- 
2.34.1

