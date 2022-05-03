Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15131C4321E
	for <amd-gfx@archiver.kernel.org>; Tue,  3 May 2022 20:37:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B3B810F45F;
	Tue,  3 May 2022 20:37:46 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2086.outbound.protection.outlook.com [40.107.244.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 41CC710F441
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 May 2022 20:37:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c2qlVnsyjqgLRbzgAeYxGXSjMtYmGO1G4O9mHYsOaRD6WZ6XJjmX6FYYAlUdt45mYibd/UsNIQPKxm0ejMrwn3TVY60djzsAh/Ed9UWtIh+oTtseR5OJ008ofxVOdMkqioGFJEeYExH5TnrmAUEMMuOA0CF0Sr8U+j5PCOzHI7beeYW01N6l37kJP/p3bl4TS06A8yvl4qwUZNXQfoqOZPnhI0euuvNvMFhByeJrHOz2NeZUnRqFI8vPHZLD/PRn/PcSkGn5hU2M46VpnsoxnAEVYr4SkVcjNjhkBv+rUQBGKD0FuSF3x+vJTozyOtzNx7KYNT6fyHcj/gn/sYxPuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mnyxgoYI1hRlEjeyQn2tSkZqb8bj+x9CucT38dNpc8w=;
 b=GrscKhcFHARoilOUJ+qQyUawDCMgniSJB1oO2e5Jzjin4OeSqv9yEjtjPWXsxN86uZv6o4RsXwsf3J9tINj7osGZq2Jbsk4q9A1UD56Rv0uUwtZHQ9DnLh/vMP4kHly//ClTndddaPd1H7xlV6l6pyNSUmOcztQJmYtAq2Z48FEF/vyvEmaDYUGTZWBBdvhu/1cNfWF8hTsInDTsCdWVsj8s+RTWHWJTUFerO5nrXenodIR52UnUTLxpW7BEWHmKYH55QyidyVrX9wUgtLcoyHyA1bDDSaAoxEWGef+C56RO5HKey80GYK228/FTCGMrRTUj3KjqtUz+ioDj7vWAiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mnyxgoYI1hRlEjeyQn2tSkZqb8bj+x9CucT38dNpc8w=;
 b=PdJeRG/ZN2MDYYSJY6bsgFWi5dBTkHRCav44jF5kj0FLIPN144Eys+/RznYLcppd0sEtoqsV8iN/KLui5AJ3NnBJVg2wkZNXsAjZfzona2VGDQLs+8Ry7rA0WlTokC4Dm3aE68lqHTOpAVC/mgeBFbXJJVrIhX7ivINmrmJPSPE=
Received: from MW4PR04CA0139.namprd04.prod.outlook.com (2603:10b6:303:84::24)
 by BYAPR12MB2952.namprd12.prod.outlook.com (2603:10b6:a03:13b::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.20; Tue, 3 May
 2022 20:37:41 +0000
Received: from CO1NAM11FT009.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:84:cafe::3e) by MW4PR04CA0139.outlook.office365.com
 (2603:10b6:303:84::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13 via Frontend
 Transport; Tue, 3 May 2022 20:37:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT009.mail.protection.outlook.com (10.13.175.61) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5227.15 via Frontend Transport; Tue, 3 May 2022 20:37:41 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 3 May
 2022 15:37:37 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 17/26] drm/amd/pm: port the fan interface to smu_v13_0_7
Date: Tue, 3 May 2022 16:37:07 -0400
Message-ID: <20220503203716.1230313-17-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220503203716.1230313-1-alexander.deucher@amd.com>
References: <20220503203716.1230313-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fac47062-0ed4-4413-0e80-08da2d44c529
X-MS-TrafficTypeDiagnostic: BYAPR12MB2952:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB29528B97A67BC0034E9DABC1F7C09@BYAPR12MB2952.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B8L4WXHKGU3uYGcfyiJXFPGBm3o3sxrSEnB+DJe4F9eAx2rTpui/BlvpenhLtGZPrIb21ICNN+XdiWBWAzYWD9TXwRy84VsZJGHmo4U8W5zCW6X1HOID5z2z3J8k0vj8dt/qZcsn8Pmem53xp5k0UfG6Ylvq8jZjaviYn5G4s3OqEgEWrtLK9I6m96WPRqaoKspB4e6Rsv2iNEl2rOufCFFUZ9aYECCI6XUP+UrcJ3QLXnQp1irhqfE0HZ6UlSpydYpzR6YGXnWt/MoC/lW6Wf3+I/XX/YY0VFpx5+uxNaJlVZGT7dYHyw1rpgEBSO+SnGRub2ZCn58f5WS6iFnBVVsAQI2lITbkuNtHyoOeJSOcw+Dl8x6mBHCY07y4SRcxPrbmsFSvObzYVuXnYD4DnR+FcByesK674bUaybpSHqhzKom7uA3+kcpJuViMuuomceJ538rUKNs8rns5nNphWI10iySPKSZeoQF2fOFYdUtf+3Pg8ozxhsyTtpwiJoFAo1rlaTdDAhIUA/mDviK9BhN7lWIT5/S663l6gDqiYyWwi9AegSBF3Q5QJEvILoBruX/Hdgr+Xh0LwNTm06wAHpRh6ekhhmu4g8Jz+iRVoILAaVlMCoi4IXd1pQN3ykORDC1vAzWhRAtwZlbgqtlkaF/BtV4NGn2ryv4RwiAuJdV1EFKA7+LHW7Nw3bDbYmNvt+Ha03OZTyNmshxqCOXnlQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(82310400005)(36860700001)(186003)(16526019)(54906003)(6916009)(40460700003)(2616005)(26005)(1076003)(83380400001)(508600001)(70206006)(316002)(4326008)(70586007)(5660300002)(8936002)(356005)(86362001)(36756003)(81166007)(7696005)(2906002)(6666004)(426003)(336012)(47076005)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2022 20:37:41.3299 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fac47062-0ed4-4413-0e80-08da2d44c529
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT009.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2952
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
Cc: Alex
 Deucher <alexander.deucher@amd.com>, Kenneth Feng <kenneth.feng@amd.com>,
 Jack Gui <Jack.Gui@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Kenneth Feng <kenneth.feng@amd.com>

port the fan interface to smu_v13_0_7

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
Reviewed-by: Jack Gui <Jack.Gui@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c  | 48 +++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
index 4c7154f9b80b..6346a334bc76 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -1277,6 +1277,47 @@ static int smu_v13_0_7_populate_umd_state_clk(struct smu_context *smu)
 	return 0;
 }
 
+static int smu_v13_0_7_get_fan_speed_pwm(struct smu_context *smu,
+					 uint32_t *speed)
+{
+	if (!speed)
+		return -EINVAL;
+
+	return smu_v13_0_7_get_smu_metrics_data(smu,
+						METRICS_CURR_FANPWM,
+						speed);
+}
+
+static int smu_v13_0_7_get_fan_speed_rpm(struct smu_context *smu,
+					 uint32_t *speed)
+{
+	if (!speed)
+		return -EINVAL;
+
+	return smu_v13_0_7_get_smu_metrics_data(smu,
+						METRICS_CURR_FANSPEED,
+						speed);
+}
+
+static int smu_v13_0_7_enable_mgpu_fan_boost(struct smu_context *smu)
+{
+	struct smu_table_context *table_context = &smu->smu_table;
+	PPTable_t *pptable = table_context->driver_pptable;
+	SkuTable_t *skutable = &pptable->SkuTable;
+
+	/*
+	 * Skip the MGpuFanBoost setting for those ASICs
+	 * which do not support it
+	 */
+	if (skutable->MGpuAcousticLimitRpmThreshold == 0)
+		return 0;
+
+	return smu_cmn_send_smc_msg_with_param(smu,
+					       SMU_MSG_SetMGpuFanBoostLimitRpm,
+					       0,
+					       NULL);
+}
+
 static const struct pptable_funcs smu_v13_0_7_ppt_funcs = {
 	.get_allowed_feature_mask = smu_v13_0_7_get_allowed_feature_mask,
 	.set_default_dpm_table = smu_v13_0_7_set_default_dpm_table,
@@ -1313,6 +1354,13 @@ static const struct pptable_funcs smu_v13_0_7_ppt_funcs = {
 	.get_gpu_metrics = smu_v13_0_7_get_gpu_metrics,
 	.set_soft_freq_limited_range = smu_v13_0_set_soft_freq_limited_range,
 	.set_performance_level = smu_v13_0_set_performance_level,
+	.get_fan_speed_pwm = smu_v13_0_7_get_fan_speed_pwm,
+	.get_fan_speed_rpm = smu_v13_0_7_get_fan_speed_rpm,
+	.set_fan_speed_pwm = smu_v13_0_set_fan_speed_pwm,
+	.set_fan_speed_rpm = smu_v13_0_set_fan_speed_rpm,
+	.get_fan_control_mode = smu_v13_0_get_fan_control_mode,
+	.set_fan_control_mode = smu_v13_0_set_fan_control_mode,
+	.enable_mgpu_fan_boost = smu_v13_0_7_enable_mgpu_fan_boost,
 };
 
 void smu_v13_0_7_set_ppt_funcs(struct smu_context *smu)
-- 
2.35.1

