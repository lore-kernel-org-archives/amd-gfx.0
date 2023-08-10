Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 724FDC001DE
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Aug 2023 03:40:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B5E7810E637;
	Fri, 11 Aug 2023 03:40:52 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2062.outbound.protection.outlook.com [40.107.93.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 981B910E630
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Aug 2023 03:40:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KcUyrlu1R0IeSMKX2+OJ6SZ9hNSkqeYJmGpqlpm+ESHQlkQzCM5kLKEdXZ0cWGTE8Qfp/1Lq7Ukv+CjGRda0SrDmYiJQdgNkYpUnicbYj01y2JnJNm3PFm9UpIAvb9ycBjzpcniQl/CruOJJKD6VDEapOA1S4yyIO4fIhiD9flkD+cWeIBLHac+Kq+0FV3SrMzqPJF5iyyrLIq246Eoc3UpFVBqUjjbj0UaLaqy20Cby6FrVxmpFbl14pTLDLPrQgrIrrWIE20df4rW1lBCuLpFayhzyJKyaaaI7222cCV500tvCLEG7E2dRcmbh28PKMrd+4QPD8ILeMqwz7NH8FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Llx0GNFhACNYbeXguxuaeXBTkvDit8z5TDx7eYrlpo=;
 b=TeAdd0/ZCg+qYw+m2oxGmu2hAttq+OHdIBokm2Xwz12pMlHKbkOAClJPIuUU5z/lLsRbwX+Q4t6D9u8f+Iu5oQelqHHxxr5e1LsOmwZLDtxTFEOsg/hQk3eLxSUBtmIivsZ4hkaj6P9BVW8Or1S8VM7oTT5FDlL5vRk5S8VMZspiGdJSLtich9Yk+AtNCrqzggcnr2MuFQvqSNsk5cOqTs747LrjQ9Y4/sCQvtKCg/4InLmM1c1xVVCbv+pJS5P4sAqUHVJSgqoE0JYKlTXjUXxj+PZ2dmqwscga1I9fp8Bi+iCPQO6wisd35bnAzkWtQUQ4wySMe6r95gTL0oXr3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Llx0GNFhACNYbeXguxuaeXBTkvDit8z5TDx7eYrlpo=;
 b=RLDu4xZeTpYJmRWEhnz4xzin+MVSe9jis7PRX1w5lLUaezM8FWLMCcQkA1cqs9WH+g4OwiuoVuSk3Q2z/NO9wFcUgmohiQk8WDoBVCrSMrhoS+nRfjDN5VPWVqMIOLkPA65lkaeigTTwcIfH+WKaR6Zi1x4j9wgUudKiqufYryk=
Received: from SA1PR02CA0006.namprd02.prod.outlook.com (2603:10b6:806:2cf::15)
 by DM6PR12MB4284.namprd12.prod.outlook.com (2603:10b6:5:21a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Fri, 11 Aug
 2023 03:40:48 +0000
Received: from SN1PEPF0002636B.namprd02.prod.outlook.com
 (2603:10b6:806:2cf:cafe::47) by SA1PR02CA0006.outlook.office365.com
 (2603:10b6:806:2cf::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30 via Frontend
 Transport; Fri, 11 Aug 2023 03:40:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002636B.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Fri, 11 Aug 2023 03:40:48 +0000
Received: from SITE-L-T34-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 10 Aug
 2023 22:40:12 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 8/9] drm/amd: Rename AMDGPU_PP_SENSOR_GPU_POWER
Date: Thu, 10 Aug 2023 05:32:01 -0500
Message-ID: <20230810103202.141225-8-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636B:EE_|DM6PR12MB4284:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f94498a-d2c8-49d0-1b1a-08db9a1cc0a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZeU0OXCPa2Jp3N15FuuA58U+89GuqkgeHxObcA7dKsnd8zdMljmNwItqB6LUGbG0dL8GjJfjLmID2iwWMGEQHlueLjZZQDLL7HNo8qWJzS/LhnnQTwNfgZkNO+ODLPM5ebrG6j5eEzkKvN+bIvA0pt4ZUnmBiZ1Qa6WVjLZjAvPrmMrXG2S0Z6XUzkBeo0C0XjVTrQ3orpo5I7YrMVox0MrpilGQwI38YS/ov2K48i+Hdkd+ZNbA/PCozXZ72M4Pjxm70mYFDao4SBefEAUuK0hScYreZMxZJ+miRWQnQ8HuiaNsqH3zK1WOvINKB/hYfTQWXrVM5CdZB4idLR3YfGX4j+dd8vVVKaO8GPw1HpwfibTYZz2ZgIbocAqes5vO1l9mQkH4TEFjz9soZ9UjnY4hwCYBW72f3PoQMRPt36wBLuwclj0SmyXemrMf/I0ii7pRS4IYRED+59ApyvI0HjjTJzRdcreLndGAF7/953WyymUhR/Za3jLQJ8ujMiGb0oYLb1aUBH2d5OV9P5y+TyBkTA+APAGlqiZ2eMt2Vd8WYvgnPaswm3iLuR1OXlJDof0oc9o1Nmzqqee6CvWAqEIo+63Lgnk4F8J8RY4zhNwMrg2BFMffi6xfzRqRyukr9SsQMXwpDjgdF+qsQNYodilN8Oq9xQfUbrvETdTT5cHe9CQbC4XLKzBD+p9wr4eKXehftibN+A4HabEsIPQdGNwEq6AYQgkYjYX8ukIJqd2CkJBMQsrlWo/AvL+rzkwfUTvKiqHLoOMqJMJBmVfavg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(376002)(396003)(346002)(39860400002)(82310400008)(186006)(1800799006)(451199021)(46966006)(36840700001)(40470700004)(36860700001)(47076005)(26005)(44832011)(1076003)(16526019)(336012)(7696005)(6666004)(356005)(82740400003)(83380400001)(478600001)(2616005)(36756003)(426003)(81166007)(316002)(41300700001)(40460700003)(8676002)(8936002)(86362001)(5660300002)(2906002)(30864003)(6916009)(70586007)(4326008)(70206006)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2023 03:40:48.3912 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f94498a-d2c8-49d0-1b1a-08db9a1cc0a0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4284
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

Use the clearer name `AMDGPU_PP_SENSOR_GPU_AVG_POWER` instead.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c                 | 2 +-
 drivers/gpu/drm/amd/include/kgd_pp_interface.h          | 2 +-
 drivers/gpu/drm/amd/pm/amdgpu_pm.c                      | 4 ++--
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c   | 4 ++--
 drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c       | 2 +-
 drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c | 2 +-
 drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c         | 2 +-
 drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c | 2 +-
 drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c        | 2 +-
 drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c         | 1 +
 drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c      | 1 +
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c    | 2 +-
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c    | 2 +-
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c    | 1 +
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c    | 1 +
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c    | 2 +-
 drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c    | 1 +
 17 files changed, 19 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 631c5ab3f7dc5..99f4df133ed3e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -1019,7 +1019,7 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 		case AMDGPU_INFO_SENSOR_GPU_AVG_POWER:
 			/* get average GPU power */
 			if (amdgpu_dpm_read_sensor(adev,
-						   AMDGPU_PP_SENSOR_GPU_POWER,
+						   AMDGPU_PP_SENSOR_GPU_AVG_POWER,
 						   (void *)&ui32, &ui32_size)) {
 				return -EINVAL;
 			}
diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
index 6582cdf2736f3..84c5224d994c4 100644
--- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
@@ -132,7 +132,7 @@ enum amd_pp_sensors {
 	AMDGPU_PP_SENSOR_MEM_TEMP,
 	AMDGPU_PP_SENSOR_VCE_POWER,
 	AMDGPU_PP_SENSOR_UVD_POWER,
-	AMDGPU_PP_SENSOR_GPU_POWER,
+	AMDGPU_PP_SENSOR_GPU_AVG_POWER,
 	AMDGPU_PP_SENSOR_GPU_INPUT_POWER,
 	AMDGPU_PP_SENSOR_SS_APU_SHARE,
 	AMDGPU_PP_SENSOR_SS_DGPU_SHARE,
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index bb42851592291..8133d968f75b9 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -2796,7 +2796,7 @@ static ssize_t amdgpu_hwmon_show_power_avg(struct device *dev,
 {
 	unsigned int val;
 
-	val = amdgpu_hwmon_get_power(dev, AMDGPU_PP_SENSOR_GPU_POWER);
+	val = amdgpu_hwmon_get_power(dev, AMDGPU_PP_SENSOR_GPU_AVG_POWER);
 	if (val < 0)
 		return val;
 
@@ -3460,7 +3460,7 @@ static int amdgpu_debugfs_pm_info_pp(struct seq_file *m, struct amdgpu_device *a
 	if (!amdgpu_dpm_read_sensor(adev, AMDGPU_PP_SENSOR_VDDNB, (void *)&value, &size))
 		seq_printf(m, "\t%u mV (VDDNB)\n", value);
 	size = sizeof(uint32_t);
-	if (!amdgpu_dpm_read_sensor(adev, AMDGPU_PP_SENSOR_GPU_POWER, (void *)&query, &size))
+	if (!amdgpu_dpm_read_sensor(adev, AMDGPU_PP_SENSOR_GPU_AVG_POWER, (void *)&query, &size))
 		seq_printf(m, "\t%u.%u W (average GPU)\n", query >> 8, query & 0xff);
 	size = sizeof(value);
 	seq_printf(m, "\n");
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c
index ad40395be6028..3b33af30eb0fb 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c
@@ -2141,7 +2141,7 @@ static int vega20_get_gpu_power(struct pp_hwmgr *hwmgr, int idx,
 
 	/* For the 40.46 release, they changed the value name */
 	switch (idx) {
-	case AMDGPU_PP_SENSOR_GPU_POWER:
+	case AMDGPU_PP_SENSOR_GPU_AVG_POWER:
 		if (hwmgr->smu_version == 0x282e00)
 			*query = metrics_table.AverageSocketPower << 8;
 		else
@@ -2260,7 +2260,7 @@ static int vega20_read_sensor(struct pp_hwmgr *hwmgr, int idx,
 		*((uint32_t *)value) = data->vce_power_gated ? 0 : 1;
 		*size = 4;
 		break;
-	case AMDGPU_PP_SENSOR_GPU_POWER:
+	case AMDGPU_PP_SENSOR_GPU_AVG_POWER:
 	case AMDGPU_PP_SENSOR_GPU_INPUT_POWER:
 		*size = 16;
 		ret = vega20_get_gpu_power(hwmgr, idx, (uint32_t *)value);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
index e5f629a23db6b..704a2b577a0e2 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
@@ -1130,7 +1130,7 @@ static int arcturus_read_sensor(struct smu_context *smu,
 						    (uint32_t *)data);
 		*size = 4;
 		break;
-	case AMDGPU_PP_SENSOR_GPU_POWER:
+	case AMDGPU_PP_SENSOR_GPU_AVG_POWER:
 		ret = arcturus_get_smu_metrics_data(smu,
 						    METRICS_AVERAGE_SOCKETPOWER,
 						    (uint32_t *)data);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c
index 4840e4d69b106..9548bd3c624bd 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c
@@ -212,7 +212,7 @@ static int cyan_skillfish_read_sensor(struct smu_context *smu,
 		*(uint32_t *)data *= 100;
 		*size = 4;
 		break;
-	case AMDGPU_PP_SENSOR_GPU_POWER:
+	case AMDGPU_PP_SENSOR_GPU_AVG_POWER:
 		ret = cyan_skillfish_get_smu_metrics_data(smu,
 						   METRICS_AVERAGE_SOCKETPOWER,
 						   (uint32_t *)data);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index 06474bbb73829..18487ae10bcff 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -2202,7 +2202,7 @@ static int navi10_read_sensor(struct smu_context *smu,
 						  (uint32_t *)data);
 		*size = 4;
 		break;
-	case AMDGPU_PP_SENSOR_GPU_POWER:
+	case AMDGPU_PP_SENSOR_GPU_AVG_POWER:
 		ret = navi1x_get_smu_metrics_data(smu,
 						  METRICS_AVERAGE_SOCKETPOWER,
 						  (uint32_t *)data);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index 6dead62095bb1..4bb289f9b4b8b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -1902,7 +1902,7 @@ static int sienna_cichlid_read_sensor(struct smu_context *smu,
 							  (uint32_t *)data);
 		*size = 4;
 		break;
-	case AMDGPU_PP_SENSOR_GPU_POWER:
+	case AMDGPU_PP_SENSOR_GPU_AVG_POWER:
 		ret = sienna_cichlid_get_smu_metrics_data(smu,
 							  METRICS_AVERAGE_SOCKETPOWER,
 							  (uint32_t *)data);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
index 8a2c9c7abea6d..201cec5998428 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
@@ -1540,7 +1540,7 @@ static int vangogh_read_sensor(struct smu_context *smu,
 						   (uint32_t *)data);
 		*size = 4;
 		break;
-	case AMDGPU_PP_SENSOR_GPU_POWER:
+	case AMDGPU_PP_SENSOR_GPU_AVG_POWER:
 		ret = vangogh_common_get_smu_metrics_data(smu,
 						   METRICS_AVERAGE_SOCKETPOWER,
 						   (uint32_t *)data);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
index 7b5ccb935fc01..c8119491c5161 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
@@ -1315,6 +1315,7 @@ static int renoir_read_sensor(struct smu_context *smu,
 						  (uint32_t *)data);
 		*size = 4;
 		break;
+	case AMDGPU_PP_SENSOR_GPU_AVG_POWER:
 	default:
 		ret = -EOPNOTSUPP;
 		break;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
index 1341363ab01a8..cc3169400c9b0 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
@@ -1148,6 +1148,7 @@ static int aldebaran_read_sensor(struct smu_context *smu,
 							     (uint32_t *)data);
 		*size = 4;
 		break;
+	case AMDGPU_PP_SENSOR_GPU_AVG_POWER:
 		ret = aldebaran_get_smu_metrics_data(smu,
 						     METRICS_AVERAGE_SOCKETPOWER,
 						     (uint32_t *)data);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index 3af4f3aa1eb2a..93d21cdd613ba 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -947,7 +947,7 @@ static int smu_v13_0_0_read_sensor(struct smu_context *smu,
 						       (uint32_t *)data);
 		*size = 4;
 		break;
-	case AMDGPU_PP_SENSOR_GPU_POWER:
+	case AMDGPU_PP_SENSOR_GPU_AVG_POWER:
 		ret = smu_v13_0_0_get_smu_metrics_data(smu,
 						       METRICS_AVERAGE_SOCKETPOWER,
 						       (uint32_t *)data);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c
index 0951659299c15..626591f54bc49 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c
@@ -572,7 +572,7 @@ static int smu_v13_0_4_read_sensor(struct smu_context *smu,
 						       (uint32_t *)data);
 		*size = 4;
 		break;
-	case AMDGPU_PP_SENSOR_GPU_POWER:
+	case AMDGPU_PP_SENSOR_GPU_AVG_POWER:
 		ret = smu_v13_0_4_get_smu_metrics_data(smu,
 						       METRICS_AVERAGE_SOCKETPOWER,
 						       (uint32_t *)data);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c
index 5f8e70d4c467e..c6e7c2115a262 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c
@@ -388,6 +388,7 @@ static int smu_v13_0_5_read_sensor(struct smu_context *smu,
 						       (uint32_t *)data);
 		*size = 4;
 		break;
+	case AMDGPU_PP_SENSOR_GPU_AVG_POWER:
 	default:
 		ret = -EOPNOTSUPP;
 		break;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index af4375f50c72c..f697059feed3c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -1210,6 +1210,7 @@ static int smu_v13_0_6_read_sensor(struct smu_context *smu,
 		ret = smu_v13_0_get_gfx_vdd(smu, (uint32_t *)data);
 		*size = 4;
 		break;
+	case AMDGPU_PP_SENSOR_GPU_AVG_POWER:
 	default:
 		ret = -EOPNOTSUPP;
 		break;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
index 0b899b9a718f3..ae4b911d9057e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -928,7 +928,7 @@ static int smu_v13_0_7_read_sensor(struct smu_context *smu,
 						       (uint32_t *)data);
 		*size = 4;
 		break;
-	case AMDGPU_PP_SENSOR_GPU_POWER:
+	case AMDGPU_PP_SENSOR_GPU_AVG_POWER:
 		ret = smu_v13_0_7_get_smu_metrics_data(smu,
 						       METRICS_AVERAGE_SOCKETPOWER,
 						       (uint32_t *)data);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
index 14fe45d3b7b7d..2e74d749efdd2 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
@@ -479,6 +479,7 @@ static int yellow_carp_read_sensor(struct smu_context *smu,
 						       (uint32_t *)data);
 		*size = 4;
 		break;
+	case AMDGPU_PP_SENSOR_GPU_AVG_POWER:
 	default:
 		ret = -EOPNOTSUPP;
 		break;
-- 
2.34.1

