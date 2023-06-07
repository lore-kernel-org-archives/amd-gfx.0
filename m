Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF68DC7EE23
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Jun 2023 08:03:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E7E810E456;
	Wed,  7 Jun 2023 08:03:47 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2062e.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7ea9::62e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 93CE810E45B
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Jun 2023 08:03:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kP8B4WZu4M8zxN5Vlm1XHmsmVs9MJR6JLGrd47aVp0ROq8R0Xab6sTaJ3jB/lLK4jPQBWj7Co5hQ7AQIO68pzkdkUYMQUDX+XVnTaWq9OLrt6uOFb7E22OL5kEthkBN38CakwWDqXVdRSBYSB/AVgGlYKCdcWP9S1mATbuhuvApokymAcSgst5PpRtWdg65sJ5B5fzvdDNL36eRd+sWerGhcH97jg/TxLx7T62uacQvNoOB4dyv7DS4QK0gIrhtOjCn157ijDjywgUqpYZ/ATvyFrt5K1eWYAt+RrVEhbTFXVbtdGHJvbd+r6bENsfoMp3PDXd2jR5UaIrRwkPH9Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=38V3wVJWKTFQ4+DtggWfqWClVaVDDWfn/b8H2tbl/ag=;
 b=RvP/RzV3UEKE1+XkdU0hPDsbt32SVPTNRsaQqJ5wcqU9LwikMKEz2Wb+xPX0qKpnkSXBwLGGPzB+0CMB5erjTpmPLch0DVGFsiW9fYoh85vPErbDaGx0X9dnMMGGqDul8Tx+MyUFJIGF9UnJxdfTgbl+eeCxnFQgtMJJ9XjUF9GwI2VCmmexfAAw2EJJ2kUTl8FQtETye2/QfNrnzpqSUgQeE52jcY4qpkULZxuDx/2E4a/klT9psEq0wv+ZjWvbCzXOgflRL7SZ+1Lmy3wAYTXZRYFcjO9ex/+lzdjUa/uT5j3sSJMHVuCSeJzSUNmrwbbt+jflzZl7TVnSkghZew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=38V3wVJWKTFQ4+DtggWfqWClVaVDDWfn/b8H2tbl/ag=;
 b=sK5SpgufVNFdmIQfCAv7SUyrZJtwk+RvDn5QIEWHqwqHocGc4q2qzCwf+hoDsnDTtZpvOhnLlxQkm0kwin6NzSqXM2X+ytIbK1i79oCe5bVvV4R26Ztf+hX8V04kIsVr5VYxmxkuhXUXu84lfk0FLUaqF6++TB+klq1CeCYh7Zk=
Received: from CY5PR19CA0041.namprd19.prod.outlook.com (2603:10b6:930:1a::8)
 by MW4PR12MB6802.namprd12.prod.outlook.com (2603:10b6:303:20f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Wed, 7 Jun
 2023 08:03:42 +0000
Received: from CY4PEPF0000EE31.namprd05.prod.outlook.com
 (2603:10b6:930:1a:cafe::40) by CY5PR19CA0041.outlook.office365.com
 (2603:10b6:930:1a::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.19 via Frontend
 Transport; Wed, 7 Jun 2023 08:03:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE31.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6477.13 via Frontend Transport; Wed, 7 Jun 2023 08:03:42 +0000
Received: from ldev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 7 Jun
 2023 03:03:38 -0500
From: Tim Huang <Tim.Huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/3] drm/amd/pm: enable vclk and dclk Pstates for SMU v13.0.4
Date: Wed, 7 Jun 2023 16:02:29 +0800
Message-ID: <20230607080230.3867810-2-Tim.Huang@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE31:EE_|MW4PR12MB6802:EE_
X-MS-Office365-Filtering-Correlation-Id: 22d9c206-7701-4256-ad27-08db672db5ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QPD4d1PK7opEeLQvBeHiKBPVYUBAX/c+xIc/9naBZ4OkOnKrH2nfeZWke610lUq76Zb5toupaTh8pnbLtRYp5ws8AISUBlXIjYXSP2bzKrFuE8lfon4dOy/rPQKYdpsDOEeHElR9eFY2GnQ5+ChaRy8AtBFM4bs+2KpJmO24fcOpgwmRnhjUIQzmwDqWcXhtYCgbds58g3gPX+RjHYITIOFyjgSnVBq+JsXvt5I8Z3nQmTWvJe8kJLLMscc+b8ILrTYFoUGPLzrIvoe5KNISH0i4xIoDsEodRq0NuldQMygHEcAl9Tzc41fdHIrsB8jdU6AImMuNgYG6eUQp/H5bCAdcrecmQF6NZTLAHKhqtIsy0OswUqLVXZz1l8djJZCKN5RbRZxK4I86hW49bSXsnRLS8mfNP1Zci28LI9wBrnXVvGpyWieYq8dH7ST34Xoeg1CxPyz0OrhtfjO55Peouc5VhwbNZKCS47xwT1zkZhAjapfO+j5w76FZWhKC+ICdBD3vp3QPsmatTxe0EG0YLbVcWNNMDES33kQ7kNAdAlNDg1nRRKk8m8FCPDcNz+nVt353ZlLOBwmi2kgK6NGiAVHE8A+JdBkK5owreHoL0t1nO/dBTeTTgIVstr2//My6dPn2PWuaINTTpeAujVXdotdFnRb3KrnnLnNu0PDwwLcMlloTd0YzXaFZAFSdGpjclL76E5m/Yb6NxOpAIIk3IiFXu2Eg+5MlhKP/13Gd1B6DOJfgCRVSKO6Z/ViVNC2j4Aww23CwcuDJ3D67GAOJ5g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(376002)(136003)(396003)(39860400002)(451199021)(36840700001)(46966006)(40470700004)(7696005)(1076003)(2616005)(41300700001)(336012)(6666004)(426003)(47076005)(26005)(186003)(36860700001)(16526019)(83380400001)(40460700003)(82740400003)(478600001)(40480700001)(54906003)(82310400005)(70206006)(316002)(81166007)(356005)(70586007)(6916009)(5660300002)(8936002)(8676002)(4326008)(2906002)(86362001)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 08:03:42.2219 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 22d9c206-7701-4256-ad27-08db672db5ba
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE31.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6802
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

Add the ability to control the vclk and dclk frequency by
power_dpm_force_performance_level interface.

Signed-off-by: Tim Huang <Tim.Huang@amd.com>
---
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c  | 29 +++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c
index 999b07db862e..315a6d8bde2e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c
@@ -915,6 +915,8 @@ static int smu_v13_0_4_set_performance_level(struct smu_context *smu,
 	uint32_t sclk_min = 0, sclk_max = 0;
 	uint32_t fclk_min = 0, fclk_max = 0;
 	uint32_t socclk_min = 0, socclk_max = 0;
+	uint32_t vclk_min = 0, vclk_max = 0;
+	uint32_t dclk_min = 0, dclk_max = 0;
 	int ret = 0;
 
 	switch (level) {
@@ -922,22 +924,32 @@ static int smu_v13_0_4_set_performance_level(struct smu_context *smu,
 		smu_v13_0_4_get_dpm_ultimate_freq(smu, SMU_SCLK, NULL, &sclk_max);
 		smu_v13_0_4_get_dpm_ultimate_freq(smu, SMU_FCLK, NULL, &fclk_max);
 		smu_v13_0_4_get_dpm_ultimate_freq(smu, SMU_SOCCLK, NULL, &socclk_max);
+		smu_v13_0_4_get_dpm_ultimate_freq(smu, SMU_VCLK, NULL, &vclk_max);
+		smu_v13_0_4_get_dpm_ultimate_freq(smu, SMU_DCLK, NULL, &dclk_max);
 		sclk_min = sclk_max;
 		fclk_min = fclk_max;
 		socclk_min = socclk_max;
+		vclk_min = vclk_max;
+		dclk_min = dclk_max;
 		break;
 	case AMD_DPM_FORCED_LEVEL_LOW:
 		smu_v13_0_4_get_dpm_ultimate_freq(smu, SMU_SCLK, &sclk_min, NULL);
 		smu_v13_0_4_get_dpm_ultimate_freq(smu, SMU_FCLK, &fclk_min, NULL);
 		smu_v13_0_4_get_dpm_ultimate_freq(smu, SMU_SOCCLK, &socclk_min, NULL);
+		smu_v13_0_4_get_dpm_ultimate_freq(smu, SMU_VCLK, &vclk_min, NULL);
+		smu_v13_0_4_get_dpm_ultimate_freq(smu, SMU_DCLK, &dclk_min, NULL);
 		sclk_max = sclk_min;
 		fclk_max = fclk_min;
 		socclk_max = socclk_min;
+		vclk_max = vclk_min;
+		dclk_max = dclk_min;
 		break;
 	case AMD_DPM_FORCED_LEVEL_AUTO:
 		smu_v13_0_4_get_dpm_ultimate_freq(smu, SMU_SCLK, &sclk_min, &sclk_max);
 		smu_v13_0_4_get_dpm_ultimate_freq(smu, SMU_FCLK, &fclk_min, &fclk_max);
 		smu_v13_0_4_get_dpm_ultimate_freq(smu, SMU_SOCCLK, &socclk_min, &socclk_max);
+		smu_v13_0_4_get_dpm_ultimate_freq(smu, SMU_VCLK, &vclk_min, &vclk_max);
+		smu_v13_0_4_get_dpm_ultimate_freq(smu, SMU_DCLK, &dclk_min, &dclk_max);
 		break;
 	case AMD_DPM_FORCED_LEVEL_PROFILE_STANDARD:
 	case AMD_DPM_FORCED_LEVEL_PROFILE_MIN_SCLK:
@@ -983,6 +995,23 @@ static int smu_v13_0_4_set_performance_level(struct smu_context *smu,
 			return ret;
 	}
 
+	if (vclk_min && vclk_max) {
+		ret = smu_v13_0_4_set_soft_freq_limited_range(smu,
+							      SMU_VCLK,
+							      vclk_min,
+							      vclk_max);
+		if (ret)
+			return ret;
+	}
+
+	if (dclk_min && dclk_max) {
+		ret = smu_v13_0_4_set_soft_freq_limited_range(smu,
+							      SMU_DCLK,
+							      dclk_min,
+							      dclk_max);
+		if (ret)
+			return ret;
+	}
 	return ret;
 }
 
-- 
2.34.1

