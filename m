Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A0A6C25B47
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Oct 2023 19:06:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8970D10EA33;
	Fri, 27 Oct 2023 19:06:03 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2040.outbound.protection.outlook.com [40.107.243.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 41DB710EA32
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Oct 2023 19:06:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J1yksGHf/Kk4VEVpiXQ/W9kHEK3/8AVzEqKxxxbWaf6dNjxa0CTO9oRknqopi4G20TEYWbeLwsErK8lyV1Ipttuskc6vAIiFDql5x2/BPacbXdbFgexi8tKS4CxwdVX30+69BUHH63rLF7mLu34vA0GbFM7YX50mKHyp5kwBQZITpLV3Ux8jrujMD4dEvXUH1xp5ezQJhjJPs2BLAU8Dft0UCSFfZvWZVdTKGn3gfQ1nRKP+xK18xrq5mCLJ/B5HxokmcSyyzvUE4P8x6MnZEuWeze+Oyy9UUy5dHdFMcQQPSO4CXgA7nHUPNWMN4AteoZBVgQ4f0rw7rzRuZ7gS8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1N+dlZolmWKk4qVW8MDzcRSy00TXb+XlG/KSinV3GX8=;
 b=izOR5/8NU3AOxuvkB4xtTntGaO3rI7y8qi/ZQVDH9vfqczAH35p5CTlAw7WtK3Kf9FT/DIukNLU5jrI+TZa8dTnI7wxNZ+42pK776kXh4vPJ35w0fuiZHwl3BqkxSkYqWxVCMICQS+KewQLxtkmE0A3CpqpVYFf69ktJl7IAFShih6ac1S6ILlar3/sqp2oYaWG9IU6NKvPEyzjHEBbv/IVp8DZK+QJ191td2w3TXerrf5ZKg2SLIMIae8d+NXD8jOE6Gsk6zFKBSNUcO3DVx3yDP13JuzoEizKLUa+MFhCC0M0fuarDduKfBNhrFR02yBoLvPdxDZky5kbfNm4FIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1N+dlZolmWKk4qVW8MDzcRSy00TXb+XlG/KSinV3GX8=;
 b=ll1NjhUQM4aiF4nnOMi7w7I9WNhlEkKbyiM1wwINgPS17ePsr26ukeU2+wDuAp4P3DCf3BWwD9VfmwnxnoH5lnISCTB6hS8g+twiBbbinpQs/4Y5TAofdDIf2A5UxrBtllLeZjYGa+JDCPiB2W5PfUX93BbM01c+TBqVGvwFZDo=
Received: from MN2PR16CA0057.namprd16.prod.outlook.com (2603:10b6:208:234::26)
 by MN2PR12MB4191.namprd12.prod.outlook.com (2603:10b6:208:1d3::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.24; Fri, 27 Oct
 2023 19:06:00 +0000
Received: from BL6PEPF0001AB4D.namprd04.prod.outlook.com
 (2603:10b6:208:234:cafe::fb) by MN2PR16CA0057.outlook.office365.com
 (2603:10b6:208:234::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.22 via Frontend
 Transport; Fri, 27 Oct 2023 19:06:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4D.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6933.15 via Frontend Transport; Fri, 27 Oct 2023 19:06:00 +0000
Received: from mukjoshi-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Fri, 27 Oct
 2023 14:05:59 -0500
From: Mukul Joshi <mukul.joshi@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCHv2 1/2] drm/amdkfd: Populate cache info for GFX 9.4.3
Date: Fri, 27 Oct 2023 15:04:00 -0400
Message-ID: <20231027190402.553203-1-mukul.joshi@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4D:EE_|MN2PR12MB4191:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c742c56-c28b-4be3-ea3c-08dbd71fc1f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y25xollAvn6/guy6q4YtSUyPvP6BeXzWvMehqLHnZqKokokSxRY8Pc0n+46rszqaGXlVDAD96X5ZXz66gT8VTEc4jF+wCnrMLDpxLQxMyLSRAZXMS6JKTs4ziKbdBS/tz+8VJnGyyEKe1btForqE7EVuY8HCuncY2q57aFaBUZFe/115qL6JSq5oKaX6Vm7C1+8VaSiBdtKa1kOu8HwRMTcll7TS4WKe5RV6LT4u2SmcqOo3nR5bKigMfBWfCF73IjYX+wh+qMZTM2+J6DOYF+MNUJYS9PGV347zbSi3uWk6Um36oMTunjYjM/AeqeAelv+znwz5WF7qKjk6G2//D0aiKyTCLTCBCtPe5QNIk0rEnoKMqaQ6DDdGHwdYBANvjR8l/3Bh6PxDyDTAqwnPHPNdLp3icKOkMzlw6BTeXK6Q08bu7g9wO4AmKlWDx764K8mjoz123H/PbZ1sZYPD3vZOKoLpUv+RzOMLW7slg0r11GHEtoS7CsxpR5rVN/NULRVZ6wdzsbx0fnPRHvBK6VrrwBGKM4I1pzuRuvvBtFuEe1lMNnNJN5o0IW0uJrQigxekb0p+vA2nIWfEWUshLbvcbmJTEdFpi43ecc9vpKK8oMCrAv1upaq3GY7y8g0m3oYhdPclomMAiZi0852c5x27Oqnq2FI+S/P2j8WHwMakFde9EqknbK44gkfMC2WthxP9+RHPQZ5cvm5hs5MM7ulnc/umLwx0L9SUV8zDeiEIRGNRkm4E1bc9zqNd3E54qk7ZkRY4B8lIbct2iyc6ew==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(376002)(396003)(346002)(39860400002)(230922051799003)(64100799003)(451199024)(186009)(82310400011)(1800799009)(36840700001)(46966006)(40470700004)(40480700001)(40460700003)(86362001)(36756003)(8676002)(8936002)(44832011)(4326008)(356005)(81166007)(82740400003)(47076005)(36860700001)(1076003)(83380400001)(2616005)(478600001)(7696005)(6666004)(6916009)(70206006)(54906003)(316002)(70586007)(26005)(2906002)(336012)(41300700001)(426003)(16526019)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2023 19:06:00.0000 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c742c56-c28b-4be3-ea3c-08dbd71fc1f2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4191
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
Cc: Mukul Joshi <mukul.joshi@amd.com>, Felix.Kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

GFX 9.4.3 uses a new version of the GC info table which
contains the cache info. This patch adds a new function
to populate the cache info from IP discovery for GFX 9.4.3.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
---
v1->v2:
- Separate out the original patch into 2 patches.

 drivers/gpu/drm/amd/amdkfd/kfd_crat.c | 66 ++++++++++++++++++++++++++-
 1 file changed, 65 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
index 0e792a8496d6..cd8e459201f1 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
@@ -1404,6 +1404,66 @@ static int kfd_fill_gpu_cache_info_from_gfx_config(struct kfd_dev *kdev,
 	return i;
 }
 
+static int kfd_fill_gpu_cache_info_from_gfx_config_v2(struct kfd_dev *kdev,
+						   struct kfd_gpu_cache_info *pcache_info)
+{
+	struct amdgpu_device *adev = kdev->adev;
+	int i = 0;
+
+	/* TCP L1 Cache per CU */
+	if (adev->gfx.config.gc_tcp_size_per_cu) {
+		pcache_info[i].cache_size = adev->gfx.config.gc_tcp_size_per_cu;
+		pcache_info[i].cache_level = 1;
+		pcache_info[i].flags = (CRAT_CACHE_FLAGS_ENABLED |
+					CRAT_CACHE_FLAGS_DATA_CACHE |
+					CRAT_CACHE_FLAGS_SIMD_CACHE);
+		pcache_info[i].num_cu_shared = 1;
+		i++;
+	}
+	/* Scalar L1 Instruction Cache per SQC */
+	if (adev->gfx.config.gc_l1_instruction_cache_size_per_sqc) {
+		pcache_info[i].cache_size =
+			adev->gfx.config.gc_l1_instruction_cache_size_per_sqc;
+		pcache_info[i].cache_level = 1;
+		pcache_info[i].flags = (CRAT_CACHE_FLAGS_ENABLED |
+					CRAT_CACHE_FLAGS_INST_CACHE |
+					CRAT_CACHE_FLAGS_SIMD_CACHE);
+		pcache_info[i].num_cu_shared = adev->gfx.config.gc_num_cu_per_sqc;
+		i++;
+	}
+	/* Scalar L1 Data Cache per SQC */
+	if (adev->gfx.config.gc_l1_data_cache_size_per_sqc) {
+		pcache_info[i].cache_size = adev->gfx.config.gc_l1_data_cache_size_per_sqc;
+		pcache_info[i].cache_level = 1;
+		pcache_info[i].flags = (CRAT_CACHE_FLAGS_ENABLED |
+					CRAT_CACHE_FLAGS_DATA_CACHE |
+					CRAT_CACHE_FLAGS_SIMD_CACHE);
+		pcache_info[i].num_cu_shared = adev->gfx.config.gc_num_cu_per_sqc;
+		i++;
+	}
+	/* L2 Data Cache per GPU (Total Tex Cache) */
+	if (adev->gfx.config.gc_tcc_size) {
+		pcache_info[i].cache_size = adev->gfx.config.gc_tcc_size;
+		pcache_info[i].cache_level = 2;
+		pcache_info[i].flags = (CRAT_CACHE_FLAGS_ENABLED |
+					CRAT_CACHE_FLAGS_DATA_CACHE |
+					CRAT_CACHE_FLAGS_SIMD_CACHE);
+		pcache_info[i].num_cu_shared = adev->gfx.config.max_cu_per_sh;
+		i++;
+	}
+	/* L3 Data Cache per GPU */
+	if (adev->gmc.mall_size) {
+		pcache_info[i].cache_size = adev->gmc.mall_size / 1024;
+		pcache_info[i].cache_level = 3;
+		pcache_info[i].flags = (CRAT_CACHE_FLAGS_ENABLED |
+					CRAT_CACHE_FLAGS_DATA_CACHE |
+					CRAT_CACHE_FLAGS_SIMD_CACHE);
+		pcache_info[i].num_cu_shared = adev->gfx.config.max_cu_per_sh;
+		i++;
+	}
+	return i;
+}
+
 int kfd_get_gpu_cache_info(struct kfd_node *kdev, struct kfd_gpu_cache_info **pcache_info)
 {
 	int num_of_cache_types = 0;
@@ -1461,10 +1521,14 @@ int kfd_get_gpu_cache_info(struct kfd_node *kdev, struct kfd_gpu_cache_info **pc
 			num_of_cache_types = ARRAY_SIZE(vega20_cache_info);
 			break;
 		case IP_VERSION(9, 4, 2):
-		case IP_VERSION(9, 4, 3):
 			*pcache_info = aldebaran_cache_info;
 			num_of_cache_types = ARRAY_SIZE(aldebaran_cache_info);
 			break;
+		case IP_VERSION(9, 4, 3):
+			num_of_cache_types =
+				kfd_fill_gpu_cache_info_from_gfx_config_v2(kdev->kfd,
+									*pcache_info);
+			break;
 		case IP_VERSION(9, 1, 0):
 		case IP_VERSION(9, 2, 2):
 			*pcache_info = raven_cache_info;
-- 
2.35.1

