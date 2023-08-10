Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8637AC001DE
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Aug 2023 03:40:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 230FE10E630;
	Fri, 11 Aug 2023 03:40:51 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::600])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9954810E630
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Aug 2023 03:40:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hnFJ+PLM6QWEb/CX5MNjHUAf6DnkNHoDheUBc2QVwKTIBkCBD5oLlV2LD0aGyYI00Gm0kikiLKGkSLLHyHGJsW21sT7b/1ryOSkNDe64fXlMt0FuhKJOrwakNMYy8FyS8NqQf8wgtjQODu1siSSiv2c2AD0etHxYGWHmPWCYRG1B1JPwFyhYWkUowM8UbVBpMd97XHX4INhQn3zlY71kUg7fCsnEV8jbDmjscuQz7Kp5YCutQPuz6pgEruO6F8rvEHqCqz569lOiBw92iY5KIYqKXrasuFQ+eAxlrkQinWO6KVXRLP7IISs1IrBKooDDJzbszeHplIugs6oums7tPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=936xcVoFs5fAPbJO2m6hNiOxoKV64mmTxAJMJl/19ZE=;
 b=Yo6PZoToHeOnMYoJlezCDhAbfXpYYKE3awNJKcgATctQqnvWCEUucgHD7DnpTXf35jWcZrr4J/nQvYUZy0CgSR2tENXyJXdveGvnDfHwpThAms00UUOogZLIy1hCPvpnxRqOioPz6w8/LLlQ5TmnZQGynkYoVip9+4M9CBp0m32XRo+DRHW5Sjy5C8Ykd81Uee+sQqoTeTgG1rPMTh6yOeLxJ6tbiba8yXABakYmMkQdDMi6bKohMYYF4puJQXSV3jezZ3NrZNe+aOJWbJuCULrIBA5ovh8Ac2qXg/da63Rr0kt8MGtHuJY9O76UDeQplLCE00aHrUmdU3iGREN+Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=936xcVoFs5fAPbJO2m6hNiOxoKV64mmTxAJMJl/19ZE=;
 b=RQ4IKbyngQZeBxmsG2T8CavMGxrXONGW8M++NMf5zV2v+X++yfupe1KilhRP6CP2kljrEILc3xo5CA73J1G7IgEK3HFo7k4U0Q20pNHIC1sc9gq2JZSgzoQevjB4vNCio4JL04mj7767FTwcpsObjp7Bb0DI9kcQS8gsjjVbr2w=
Received: from MW4PR03CA0247.namprd03.prod.outlook.com (2603:10b6:303:b4::12)
 by SJ0PR12MB6942.namprd12.prod.outlook.com (2603:10b6:a03:449::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.19; Fri, 11 Aug
 2023 03:40:45 +0000
Received: from CO1PEPF000042AE.namprd03.prod.outlook.com
 (2603:10b6:303:b4:cafe::6b) by MW4PR03CA0247.outlook.office365.com
 (2603:10b6:303:b4::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30 via Frontend
 Transport; Fri, 11 Aug 2023 03:40:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AE.mail.protection.outlook.com (10.167.243.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.20 via Frontend Transport; Fri, 11 Aug 2023 03:40:45 +0000
Received: from SITE-L-T34-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 10 Aug
 2023 22:40:10 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/9] drm/amd: Introduce `AMDGPU_PP_SENSOR_GPU_INPUT_POWER`
Date: Thu, 10 Aug 2023 05:31:56 -0500
Message-ID: <20230810103202.141225-3-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230810103202.141225-1-mario.limonciello@amd.com>
References: <20230810103202.141225-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AE:EE_|SJ0PR12MB6942:EE_
X-MS-Office365-Filtering-Correlation-Id: ba72a37a-5976-4ca3-bda2-08db9a1cbece
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KYJGZFE/uaWZdaMJr7r0VOjQ/eulwn9WT/YJolVkzgY+zdZ2FRCcIp6Dj/zCYGo+ddN1t+pJpBRy/xe/gVGOe3Sp+UiPpvOSH2dLlq0zSW7lJhGPQ7KnKnB5xiGuwL4e5KU6Zx7RbLBMIFB1u0L9e5QRmnMaWMehj79YX44+Kmg9AypCdCMWut0CjIGlTg2Y41fg6V9OWdXP6jhZbip/HrUUVhl/M3itSZnnfuB7O/hwOdn7s2zfrqcz8TgEgsit1gyUyf8wWcNJzI8Njc3eoMJF8AK/6oRSXZSKw2Tu0yeMQBNsWZduvni8ryDMxGiGHHXidhmSMJpYXic3ibnHbJK8SOTcGNqqW31Efc32zKNAVH+1nIDmr5XEB79bZ67o1KPQioFMFdzDnRQV+j7rw3L8NQNvswmCeRepUwCMGHlRD0/+TBUdc47HQZy/EX9aXbVPzTJKfzPeqyZH/VkLQL+mTK7UfnG2l7tyYr+utegNl9vZSQY8N0Mghi1BKKpEIG+FNW/Qff2SeWL/x+eXTycRPDeQDhqFUOIqxxaesqm0kumuPJgVsdGuLl+cKLiFPra1LM+AF/eSAeGi3JdnEq3XCfV92sZqol31HIckJECRVKLj3fD9LQzAIViPxyXeVLgEEANvSH7WNxWhNLNYVapNEpOQZwg4t0v4ec/9twgr+WQLhXiofs2bvuM/I9MKt9uGCRoSuu2vBKSlBb/9YVdctyvXXKGD3Gy3DFbIKPKqGqoBXbQq3c7UKwmbFJqEcmwED+ZDpuEJ8kF6llMy4fdYVqweibjH29MK+MjfYQI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(136003)(39860400002)(346002)(376002)(1800799006)(82310400008)(451199021)(186006)(36840700001)(46966006)(40470700004)(47076005)(40460700003)(336012)(426003)(83380400001)(30864003)(2906002)(36860700001)(81166007)(82740400003)(36756003)(86362001)(356005)(40480700001)(4326008)(5660300002)(2616005)(6666004)(70586007)(70206006)(478600001)(6916009)(8676002)(7696005)(8936002)(316002)(1076003)(41300700001)(26005)(16526019)(44832011)(81973001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2023 03:40:45.2320 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ba72a37a-5976-4ca3-bda2-08db9a1cbece
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6942
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
Cc: Mario Limonciello <mario.limonciello@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Some GPUs have been overloading average power values and input power
values. To disambiguate these, introduce a new
`AMDGPU_PP_SENSOR_GPU_INPUT_POWER` and the GPUs that share input
power update to use this instead of average power.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/include/kgd_pp_interface.h  |  1 +
 drivers/gpu/drm/amd/pm/amdgpu_pm.c              |  2 +-
 .../gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c |  2 +-
 .../drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c   |  2 +-
 .../drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c   |  2 +-
 .../drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c   |  2 +-
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h   |  1 +
 .../gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c   |  1 +
 .../drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c | 12 +++++++++++-
 drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c |  1 +
 .../drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c |  1 +
 .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c    | 10 ++++++++++
 drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c |  6 +++---
 .../gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c  |  1 +
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c    |  1 +
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c    |  9 +++++++++
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c    |  6 +++---
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c    | 17 +++++------------
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c    |  1 +
 .../drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c    |  6 +++---
 20 files changed, 57 insertions(+), 27 deletions(-)

diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
index 90989405eddcf..6582cdf2736f3 100644
--- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
@@ -133,6 +133,7 @@ enum amd_pp_sensors {
 	AMDGPU_PP_SENSOR_VCE_POWER,
 	AMDGPU_PP_SENSOR_UVD_POWER,
 	AMDGPU_PP_SENSOR_GPU_POWER,
+	AMDGPU_PP_SENSOR_GPU_INPUT_POWER,
 	AMDGPU_PP_SENSOR_SS_APU_SHARE,
 	AMDGPU_PP_SENSOR_SS_DGPU_SHARE,
 	AMDGPU_PP_SENSOR_STABLE_PSTATE_SCLK,
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 816f034cfe3f1..bb42851592291 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -2809,7 +2809,7 @@ static ssize_t amdgpu_hwmon_show_power_input(struct device *dev,
 {
 	unsigned int val;
 
-	val = amdgpu_hwmon_get_power(dev, AMDGPU_PP_SENSOR_GPU_POWER);
+	val = amdgpu_hwmon_get_power(dev, AMDGPU_PP_SENSOR_GPU_INPUT_POWER);
 	if (val < 0)
 		return val;
 
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
index c91b2a3966cdb..5a2371484a58c 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
@@ -4039,7 +4039,7 @@ static int smu7_read_sensor(struct pp_hwmgr *hwmgr, int idx,
 		*((uint32_t *)value) = data->vce_power_gated ? 0 : 1;
 		*size = 4;
 		return 0;
-	case AMDGPU_PP_SENSOR_GPU_POWER:
+	case AMDGPU_PP_SENSOR_GPU_INPUT_POWER:
 		return smu7_get_gpu_power(hwmgr, (uint32_t *)value);
 	case AMDGPU_PP_SENSOR_VDDGFX:
 		if ((data->vr_config & VRCONF_VDDGFX_MASK) ==
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
index 52ae6fa2d2a6d..6d6bc6a380b36 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
@@ -3966,7 +3966,7 @@ static int vega10_read_sensor(struct pp_hwmgr *hwmgr, int idx,
 		*((uint32_t *)value) = data->vce_power_gated ? 0 : 1;
 		*size = 4;
 		break;
-	case AMDGPU_PP_SENSOR_GPU_POWER:
+	case AMDGPU_PP_SENSOR_GPU_INPUT_POWER:
 		ret = vega10_get_gpu_power(hwmgr, (uint32_t *)value);
 		break;
 	case AMDGPU_PP_SENSOR_VDDGFX:
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c
index 4bd573d815ff5..460067933de2e 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c
@@ -1529,7 +1529,7 @@ static int vega12_read_sensor(struct pp_hwmgr *hwmgr, int idx,
 		*((uint32_t *)value) = data->vce_power_gated ? 0 : 1;
 		*size = 4;
 		break;
-	case AMDGPU_PP_SENSOR_GPU_POWER:
+	case AMDGPU_PP_SENSOR_GPU_INPUT_POWER:
 		ret = vega12_get_gpu_power(hwmgr, (uint32_t *)value);
 		if (!ret)
 			*size = 4;
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c
index 492ca33637d6f..b6dd7f8daf725 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c
@@ -2253,7 +2253,7 @@ static int vega20_read_sensor(struct pp_hwmgr *hwmgr, int idx,
 		*((uint32_t *)value) = data->vce_power_gated ? 0 : 1;
 		*size = 4;
 		break;
-	case AMDGPU_PP_SENSOR_GPU_POWER:
+	case AMDGPU_PP_SENSOR_GPU_INPUT_POWER:
 		*size = 16;
 		ret = vega20_get_gpu_power(hwmgr, (uint32_t *)value);
 		break;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
index 6e2069dcb6b9d..6b5e220affdf2 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -1398,6 +1398,7 @@ typedef enum {
 	METRICS_PCIE_RATE,
 	METRICS_PCIE_WIDTH,
 	METRICS_CURR_FANPWM,
+	METRICS_CURR_SOCKETPOWER,
 } MetricsMember_t;
 
 enum smu_cmn2asic_mapping_type {
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
index c49f770c97b38..e5f629a23db6b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
@@ -1169,6 +1169,7 @@ static int arcturus_read_sensor(struct smu_context *smu,
 		ret = smu_v11_0_get_gfx_vdd(smu, (uint32_t *)data);
 		*size = 4;
 		break;
+	case AMDGPU_PP_SENSOR_GPU_INPUT_POWER:
 	default:
 		ret = -EOPNOTSUPP;
 		break;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c
index ca4d97b7f576c..4840e4d69b106 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c
@@ -154,10 +154,14 @@ cyan_skillfish_get_smu_metrics_data(struct smu_context *smu,
 	case METRICS_CURR_UCLK:
 		*value = metrics->Current.MemclkFrequency;
 		break;
-	case METRICS_AVERAGE_SOCKETPOWER:
+	case METRICS_CURR_SOCKETPOWER:
 		*value = (metrics->Current.CurrentSocketPower << 8) /
 				1000;
 		break;
+	case METRICS_AVERAGE_SOCKETPOWER:
+		*value = (metrics->Average.CurrentSocketPower << 8) /
+				1000;
+		break;
 	case METRICS_TEMPERATURE_EDGE:
 		*value = metrics->Current.GfxTemperature / 100 *
 				SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
@@ -214,6 +218,12 @@ static int cyan_skillfish_read_sensor(struct smu_context *smu,
 						   (uint32_t *)data);
 		*size = 4;
 		break;
+	case AMDGPU_PP_SENSOR_GPU_INPUT_POWER:
+		ret = cyan_skillfish_get_smu_metrics_data(smu,
+						   METRICS_CURR_SOCKETPOWER,
+						   (uint32_t *)data);
+		*size = 4;
+		break;
 	case AMDGPU_PP_SENSOR_HOTSPOT_TEMP:
 		ret = cyan_skillfish_get_smu_metrics_data(smu,
 						   METRICS_TEMPERATURE_HOTSPOT,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index e655071516b73..06474bbb73829 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -2240,6 +2240,7 @@ static int navi10_read_sensor(struct smu_context *smu,
 		ret = smu_v11_0_get_gfx_vdd(smu, (uint32_t *)data);
 		*size = 4;
 		break;
+	case AMDGPU_PP_SENSOR_GPU_INPUT_POWER:
 	default:
 		ret = -EOPNOTSUPP;
 		break;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index f0800c0c5168c..6dead62095bb1 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -1962,6 +1962,7 @@ static int sienna_cichlid_read_sensor(struct smu_context *smu,
 			ret = -EOPNOTSUPP;
 		}
 		break;
+	case AMDGPU_PP_SENSOR_GPU_INPUT_POWER:
 	default:
 		ret = -EOPNOTSUPP;
 		break;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
index 185d0b50ee8ea..8a2c9c7abea6d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
@@ -390,6 +390,10 @@ static int vangogh_get_smu_metrics_data(struct smu_context *smu,
 		*value = metrics->Current.UvdActivity;
 		break;
 	case METRICS_AVERAGE_SOCKETPOWER:
+		*value = (metrics->Average.CurrentSocketPower << 8) /
+		1000;
+		break;
+	case METRICS_CURR_SOCKETPOWER:
 		*value = (metrics->Current.CurrentSocketPower << 8) /
 		1000;
 		break;
@@ -1542,6 +1546,12 @@ static int vangogh_read_sensor(struct smu_context *smu,
 						   (uint32_t *)data);
 		*size = 4;
 		break;
+	case AMDGPU_PP_SENSOR_GPU_INPUT_POWER:
+		ret = vangogh_common_get_smu_metrics_data(smu,
+						   METRICS_CURR_SOCKETPOWER,
+						   (uint32_t *)data);
+		*size = 4;
+		break;
 	case AMDGPU_PP_SENSOR_EDGE_TEMP:
 		ret = vangogh_common_get_smu_metrics_data(smu,
 						   METRICS_TEMPERATURE_EDGE,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
index a7569354229de..7b5ccb935fc01 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
@@ -1197,7 +1197,7 @@ static int renoir_get_smu_metrics_data(struct smu_context *smu,
 	case METRICS_AVERAGE_VCNACTIVITY:
 		*value = metrics->AverageUvdActivity / 100;
 		break;
-	case METRICS_AVERAGE_SOCKETPOWER:
+	case METRICS_CURR_SOCKETPOWER:
 		if (((adev->ip_versions[MP1_HWIP][0] == IP_VERSION(12, 0, 1)) && (adev->pm.fw_version >= 0x40000f)) ||
 		((adev->ip_versions[MP1_HWIP][0] == IP_VERSION(12, 0, 0)) && (adev->pm.fw_version >= 0x373200)))
 			*value = metrics->CurrentSocketPower << 8;
@@ -1297,9 +1297,9 @@ static int renoir_read_sensor(struct smu_context *smu,
 						  (uint32_t *)data);
 		*size = 4;
 		break;
-	case AMDGPU_PP_SENSOR_GPU_POWER:
+	case AMDGPU_PP_SENSOR_GPU_INPUT_POWER:
 		ret = renoir_get_smu_metrics_data(smu,
-						  METRICS_AVERAGE_SOCKETPOWER,
+						  METRICS_CURR_SOCKETPOWER,
 						  (uint32_t *)data);
 		*size = 4;
 		break;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
index 8f26123ac7031..4e5043b6ce40b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
@@ -1183,6 +1183,7 @@ static int aldebaran_read_sensor(struct smu_context *smu,
 		ret = smu_v13_0_get_gfx_vdd(smu, (uint32_t *)data);
 		*size = 4;
 		break;
+	case AMDGPU_PP_SENSOR_GPU_INPUT_POWER:
 	default:
 		ret = -EOPNOTSUPP;
 		break;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index 0fb6be11a0cc7..3af4f3aa1eb2a 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -991,6 +991,7 @@ static int smu_v13_0_0_read_sensor(struct smu_context *smu,
 						       (uint32_t *)data);
 		*size = 4;
 		break;
+	case AMDGPU_PP_SENSOR_GPU_INPUT_POWER:
 	default:
 		ret = -EOPNOTSUPP;
 		break;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c
index ef37dda9908fa..a4e87984645ec 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c
@@ -321,6 +321,9 @@ static int smu_v13_0_4_get_smu_metrics_data(struct smu_context *smu,
 		*value = metrics->UvdActivity;
 		break;
 	case METRICS_AVERAGE_SOCKETPOWER:
+		*value = (metrics->AverageSocketPower << 8) / 1000;
+		break;
+	case METRICS_CURR_SOCKETPOWER:
 		*value = (metrics->CurrentSocketPower << 8) / 1000;
 		break;
 	case METRICS_TEMPERATURE_EDGE:
@@ -575,6 +578,12 @@ static int smu_v13_0_4_read_sensor(struct smu_context *smu,
 						       (uint32_t *)data);
 		*size = 4;
 		break;
+	case AMDGPU_PP_SENSOR_GPU_INPUT_POWER:
+		ret = smu_v13_0_4_get_smu_metrics_data(smu,
+						       METRICS_CURR_SOCKETPOWER,
+						       (uint32_t *)data);
+		*size = 4;
+		break;
 	case AMDGPU_PP_SENSOR_EDGE_TEMP:
 		ret = smu_v13_0_4_get_smu_metrics_data(smu,
 						       METRICS_TEMPERATURE_EDGE,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c
index 87a79e6f983b5..5f8e70d4c467e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c
@@ -288,7 +288,7 @@ static int smu_v13_0_5_get_smu_metrics_data(struct smu_context *smu,
 	case METRICS_AVERAGE_VCNACTIVITY:
 		*value = metrics->UvdActivity;
 		break;
-	case METRICS_AVERAGE_SOCKETPOWER:
+	case METRICS_CURR_SOCKETPOWER:
 		*value = (metrics->CurrentSocketPower << 8) / 1000;
 		break;
 	case METRICS_TEMPERATURE_EDGE:
@@ -332,9 +332,9 @@ static int smu_v13_0_5_read_sensor(struct smu_context *smu,
 								(uint32_t *)data);
 		*size = 4;
 		break;
-	case AMDGPU_PP_SENSOR_GPU_POWER:
+	case AMDGPU_PP_SENSOR_GPU_INPUT_POWER:
 		ret = smu_v13_0_5_get_smu_metrics_data(smu,
-								METRICS_AVERAGE_SOCKETPOWER,
+								METRICS_CURR_SOCKETPOWER,
 								(uint32_t *)data);
 		*size = 4;
 		break;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 2898e9c0295e7..af4375f50c72c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -714,7 +714,7 @@ static int smu_v13_0_6_get_smu_metrics_data(struct smu_context *smu,
 	case METRICS_AVERAGE_MEMACTIVITY:
 		*value = SMUQ10_TO_UINT(metrics->DramBandwidthUtilization);
 		break;
-	case METRICS_AVERAGE_SOCKETPOWER:
+	case METRICS_CURR_SOCKETPOWER:
 		*value = SMUQ10_TO_UINT(metrics->SocketPower) << 8;
 		break;
 	case METRICS_TEMPERATURE_HOTSPOT:
@@ -1136,15 +1136,6 @@ static int smu_v13_0_6_get_current_activity_percent(struct smu_context *smu,
 	return ret;
 }
 
-static int smu_v13_0_6_get_gpu_power(struct smu_context *smu, uint32_t *value)
-{
-	if (!value)
-		return -EINVAL;
-
-	return smu_v13_0_6_get_smu_metrics_data(smu, METRICS_AVERAGE_SOCKETPOWER,
-					       value);
-}
-
 static int smu_v13_0_6_thermal_get_temperature(struct smu_context *smu,
 					       enum amd_pp_sensors sensor,
 					       uint32_t *value)
@@ -1190,8 +1181,10 @@ static int smu_v13_0_6_read_sensor(struct smu_context *smu,
 							       (uint32_t *)data);
 		*size = 4;
 		break;
-	case AMDGPU_PP_SENSOR_GPU_POWER:
-		ret = smu_v13_0_6_get_gpu_power(smu, (uint32_t *)data);
+	case AMDGPU_PP_SENSOR_GPU_INPUT_POWER:
+		ret = smu_v13_0_6_get_smu_metrics_data(smu,
+						       METRICS_CURR_SOCKETPOWER,
+						       (uint32_t *)data);
 		*size = 4;
 		break;
 	case AMDGPU_PP_SENSOR_HOTSPOT_TEMP:
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
index b43c5d13f8d9c..0b899b9a718f3 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -972,6 +972,7 @@ static int smu_v13_0_7_read_sensor(struct smu_context *smu,
 						       (uint32_t *)data);
 		*size = 4;
 		break;
+	case AMDGPU_PP_SENSOR_GPU_INPUT_POWER:
 	default:
 		ret = -EOPNOTSUPP;
 		break;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
index a1be2029ba4ab..14fe45d3b7b7d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
@@ -365,7 +365,7 @@ static int yellow_carp_get_smu_metrics_data(struct smu_context *smu,
 	case METRICS_AVERAGE_VCNACTIVITY:
 		*value = metrics->UvdActivity;
 		break;
-	case METRICS_AVERAGE_SOCKETPOWER:
+	case METRICS_CURR_SOCKETPOWER:
 		*value = (metrics->CurrentSocketPower << 8) / 1000;
 		break;
 	case METRICS_TEMPERATURE_EDGE:
@@ -423,9 +423,9 @@ static int yellow_carp_read_sensor(struct smu_context *smu,
 								(uint32_t *)data);
 		*size = 4;
 		break;
-	case AMDGPU_PP_SENSOR_GPU_POWER:
+	case AMDGPU_PP_SENSOR_GPU_INPUT_POWER:
 		ret = yellow_carp_get_smu_metrics_data(smu,
-								METRICS_AVERAGE_SOCKETPOWER,
+								METRICS_CURR_SOCKETPOWER,
 								(uint32_t *)data);
 		*size = 4;
 		break;
-- 
2.34.1

