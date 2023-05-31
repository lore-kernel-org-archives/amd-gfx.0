Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABDD7C7EE23
	for <amd-gfx@archiver.kernel.org>; Wed, 31 May 2023 13:10:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C90C10E4C3;
	Wed, 31 May 2023 13:10:12 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2046.outbound.protection.outlook.com [40.107.94.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 65DEE10E4C0
 for <amd-gfx@lists.freedesktop.org>; Wed, 31 May 2023 13:10:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YvZvzVL1KbmDxVbDtPVZckRmea9/cy+Kmf5Ld+WFXOWqT0hSXvOFoVNx32LqLVSmJcvd8xp5JbyPj5oa3x7Q3QWbojcX8cjjwpHv70cFfGn8cwbYAApnxupW+vjO6aUwe9IZ+F2JYC0HfvvOTYJOd7BNCxFcJQXnaFi6x0Ya/S0VwsbJ613N5GlnB3M0V9WOklJ8V1hnIjbjm9DNtn/E9AqqESnJTIfJcPWh97WGSmXjIEtsinWIQO5DPw1yWytMU12n29fuUFEe7ZHRX9vY6XsrKHcHotPnjb0GXP0dAroDRAVFavfrcwLfCZzU/XQ2ylbkIBYEx5laQKJdXCeg7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d5I/qUJwHQBMm9INaCB5pkZeMWlgQMOcPqdYF2mf4Po=;
 b=Ja/zOcj47INNG2d9cRtovm/ZkPBAQuw68sFT6OJoce9CylX5z8gu0lL3lnLn3/rps+iGDjdAgf74IXEGdnOi4u4Ai97GI9dCEVCqbUgneaTy6E/i4TrHwc6utWdfnzr8/C92JCMvifkiwoPN6jl5jV+cpt9PGihz09phbypLpGJR+2ktLFciw2FKe9pC+1tjb5nXBEbSFKAwH5zr4umtXixf6x1Q6LmOtTM4q1O2nNiuGEarZVocsKLflVb/pLdGlaluw/N0UobUMI3Rr3BHXxmdiaz+lZCyALvZYLO7fxtQHd1NP7Sb/1sOcMplzXsawyvR8zrF9D1YW4yk4kZf+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d5I/qUJwHQBMm9INaCB5pkZeMWlgQMOcPqdYF2mf4Po=;
 b=LSun9H+wy1EXewa0DKGwv4F3EI156qlX4nXwxLZqbGhDXx89LhZs2/W2B6ucyZanm8PxTAQVvp5UoK9NdWRQMJg0OYerlg1kaNeOt2fMlPOLw9uBii0KYnHDvvOJe7S9Ti/kcBjy6ATPru1rCOA0WIytjThma5Cv5WeS0EIYxEc=
Received: from BN0PR10CA0029.namprd10.prod.outlook.com (2603:10b6:408:143::7)
 by PH7PR12MB9175.namprd12.prod.outlook.com (2603:10b6:510:2e6::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.24; Wed, 31 May
 2023 13:10:06 +0000
Received: from BN8NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:143:cafe::63) by BN0PR10CA0029.outlook.office365.com
 (2603:10b6:408:143::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23 via Frontend
 Transport; Wed, 31 May 2023 13:10:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT068.mail.protection.outlook.com (10.13.177.69) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6455.23 via Frontend Transport; Wed, 31 May 2023 13:10:05 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 31 May
 2023 08:10:01 -0500
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/3] drm/amd/pm: Fix SMUv13.0.6 throttle status report
Date: Wed, 31 May 2023 21:09:44 +0800
Message-ID: <20230531130945.720648-2-asad.kamal@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230531130945.720648-1-asad.kamal@amd.com>
References: <20230531130945.720648-1-asad.kamal@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT068:EE_|PH7PR12MB9175:EE_
X-MS-Office365-Filtering-Correlation-Id: ac55359e-9487-4e70-588a-08db61d85a54
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o6bcJwRdBgSsuHfzf+x+DrOXkuLRhMyWTGflKasySbOAU0UcIrM+DXqpxSbfJiiJbfmWYrUktcpXeQjm+e70zoujvj+IQGVBNHGPwrLo1BpP9EUMJkHIvT38etWIAeVr8FRxSkELOKNfGq5CjQizNXL3QNda+RbeP0Cy2yTBf8nKt3K0uO5dJVCbMWFAzpl2QrJIsGBNJKTrnE4TU5jif9wL7xJfh8Yn09WNvSeptAKx/eHYYCP+FDB6mjTR+s0qcalcY5kNjOyynRBR/hA423zVyNsIMhzUC3bUzZBYsTZC8kRE+DjsLyxICpieFz+eScDgYu1gpQL+6WLsIBwYWSZMcHb+k8LD5fMHX18WIzZw+TcukdBvLrQZV0wbElgLBzo+gnQbyW/nJlJuO557YV+cWxIO00oIKFjU5M7nJnt+j7kyZHW7Zehma5Ph0+tecLFYUa3kq+meAasCSYPMNZOXUkyoZDoIH8MJWopo/a66d/sFy4Jl/1UAiuD62v2uFxHyDQa4Dh0ZRFw2Nz9YnGVae7VPm/i2IiyNoPP6xNrrc3vWFEKvTHMBsfXdCu7WPUuQfoMh4Aonu2qnCnJ98789PovRwhWtOSiOgqZ6bQvis/5vaZeqYlwpjLPY9nbpk8ft22a/S8wJHxPDVJ+JZGbfjvkUH9epQHorTiHhjKR4UHo4H1OnfyKbMe5KkvoToB+kg3cui/4kWSOLracj7cAp2Eav1JwijQ+6SVIlSYO4zGCeQ2TunhjA0QjTXMCDqMDhBWxgc53co6QZSrQYfQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(136003)(376002)(346002)(396003)(451199021)(36840700001)(40470700004)(46966006)(44832011)(70206006)(70586007)(6916009)(4326008)(8936002)(5660300002)(316002)(41300700001)(54906003)(2906002)(8676002)(36860700001)(6666004)(40460700003)(478600001)(7696005)(356005)(81166007)(40480700001)(16526019)(186003)(426003)(2616005)(83380400001)(336012)(36756003)(47076005)(26005)(1076003)(82310400005)(82740400003)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2023 13:10:05.8895 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ac55359e-9487-4e70-588a-08db61d85a54
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9175
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
Cc: Le.Ma@amd.com, lijo.lazar@amd.com, shiwzhan@amd.com, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Lijo Lazar <lijo.lazar@amd.com>

Instead of accumulated counters, PMFW will pass the throttle reason
along with throttle interrupt. Use that context information to report the
exact reason for throttling.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 93 +++++++++----------
 1 file changed, 45 insertions(+), 48 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 41b49cc827cd..b9f32e0364db 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -172,17 +172,12 @@ static const struct cmn2asic_mapping smu_v13_0_6_table_map[SMU_TABLE_COUNT] = {
 	TAB_MAP(I2C_COMMANDS),
 };
 
-#define THROTTLER_PROCHOT_GFX_BIT  0
-#define THROTTLER_PPT_BIT 1
-#define THROTTLER_TEMP_SOC_BIT 2
-#define THROTTLER_TEMP_VR_GFX_BIT 3
-
 static const uint8_t smu_v13_0_6_throttler_map[] = {
 	[THROTTLER_PPT_BIT]		= (SMU_THROTTLER_PPT0_BIT),
-	[THROTTLER_TEMP_SOC_BIT]	= (SMU_THROTTLER_TEMP_GPU_BIT),
-	[THROTTLER_TEMP_HBM_BIT]	= (SMU_THROTTLER_TEMP_MEM_BIT),
-	[THROTTLER_TEMP_VR_GFX_BIT]	= (SMU_THROTTLER_TEMP_VR_GFX_BIT),
-	[THROTTLER_PROCHOT_GFX_BIT]	= (SMU_THROTTLER_PROCHOT_GFX_BIT),
+	[THROTTLER_THERMAL_SOCKET_BIT]	= (SMU_THROTTLER_TEMP_GPU_BIT),
+	[THROTTLER_THERMAL_HBM_BIT]	= (SMU_THROTTLER_TEMP_MEM_BIT),
+	[THROTTLER_THERMAL_VR_BIT]	= (SMU_THROTTLER_TEMP_VR_GFX_BIT),
+	[THROTTLER_PROCHOT_BIT]		= (SMU_THROTTLER_PROCHOT_GFX_BIT),
 };
 
 struct PPTable_t {
@@ -640,16 +635,14 @@ static int smu_v13_0_6_freqs_in_same_level(int32_t frequency1,
 	return (abs(frequency1 - frequency2) <= EPSILON);
 }
 
-static uint32_t smu_v13_0_6_get_throttler_status(struct smu_context *smu,
-						 MetricsTable_t *metrics)
+static uint32_t smu_v13_0_6_get_throttler_status(struct smu_context *smu)
 {
+	struct smu_power_context *smu_power = &smu->smu_power;
+	struct smu_13_0_power_context *power_context = smu_power->power_context;
 	uint32_t  throttler_status = 0;
 
-	throttler_status |= metrics->ProchotResidencyAcc > 0 ? 1U << THROTTLER_PROCHOT_GFX_BIT : 0;
-	throttler_status |= metrics->PptResidencyAcc > 0 ? 1U << THROTTLER_PPT_BIT : 0;
-	throttler_status |= metrics->SocketThmResidencyAcc > 0 ?  1U << THROTTLER_TEMP_SOC_BIT : 0;
-	throttler_status |= metrics->VrThmResidencyAcc > 0 ? 1U << THROTTLER_TEMP_VR_GFX_BIT : 0;
-	throttler_status |= metrics->HbmThmResidencyAcc > 0 ? 1U << THROTTLER_TEMP_HBM_BIT : 0;
+	throttler_status = atomic_read(&power_context->throttle_status);
+	dev_dbg(smu->adev->dev, "SMU Throttler status: %u", throttler_status);
 
 	return throttler_status;
 }
@@ -719,9 +712,6 @@ static int smu_v13_0_6_get_smu_metrics_data(struct smu_context *smu,
 	case METRICS_TEMPERATURE_VRSOC:
 		*value = SMUQ10_TO_UINT(metrics->MaxVrTemperature);
 		break;
-	case METRICS_THROTTLER_STATUS:
-		*value = smu_v13_0_6_get_throttler_status(smu, metrics);
-		break;
 	default:
 		*value = UINT_MAX;
 		break;
@@ -1288,13 +1278,11 @@ static int smu_v13_0_6_irq_process(struct amdgpu_device *adev,
 				   struct amdgpu_iv_entry *entry)
 {
 	struct smu_context *smu = adev->powerplay.pp_handle;
+	struct smu_power_context *smu_power = &smu->smu_power;
+	struct smu_13_0_power_context *power_context = smu_power->power_context;
 	uint32_t client_id = entry->client_id;
-	uint32_t src_id = entry->src_id;
-	/*
-	 * ctxid is used to distinguish different
-	 * events for SMCToHost interrupt
-	 */
 	uint32_t ctxid = entry->src_data[0];
+	uint32_t src_id = entry->src_id;
 	uint32_t data;
 
 	if (client_id == SOC15_IH_CLIENTID_MP1) {
@@ -1303,7 +1291,10 @@ static int smu_v13_0_6_irq_process(struct amdgpu_device *adev,
 			data = RREG32_SOC15(MP1, 0, regMP1_SMN_IH_SW_INT_CTRL);
 			data = REG_SET_FIELD(data, MP1_SMN_IH_SW_INT_CTRL, INT_ACK, 1);
 			WREG32_SOC15(MP1, 0, regMP1_SMN_IH_SW_INT_CTRL, data);
-
+			/*
+			 * ctxid is used to distinguish different events for SMCToHost
+			 * interrupt.
+			 */
 			switch (ctxid) {
 			case IH_INTERRUPT_CONTEXT_ID_THERMAL_THROTTLING:
 				/*
@@ -1314,8 +1305,17 @@ static int smu_v13_0_6_irq_process(struct amdgpu_device *adev,
 				if (!atomic_read(&adev->throttling_logging_enabled))
 					return 0;
 
-				if (__ratelimit(&adev->throttling_logging_rs))
+				/* This uses the new method which fixes the
+				 * incorrect throttling status reporting
+				 * through metrics table. For older FWs,
+				 * it will be ignored.
+				 */
+				if (__ratelimit(&adev->throttling_logging_rs)) {
+					atomic_set(
+						&power_context->throttle_status,
+							entry->src_data[1]);
 					schedule_work(&smu->throttling_logging_work);
+				}
 
 				break;
 			}
@@ -1893,37 +1893,35 @@ static int smu_v13_0_6_allow_xgmi_power_down(struct smu_context *smu, bool en)
 					       en ? 0 : 1, NULL);
 }
 
-static const struct throttling_logging_label {
-	uint32_t feature_mask;
-	const char *label;
-} logging_label[] = {
-	{ (1U << THROTTLER_TEMP_HBM_BIT), "HBM" },
-	{ (1U << THROTTLER_TEMP_SOC_BIT), "SOC" },
-	{ (1U << THROTTLER_TEMP_VR_GFX_BIT), "VR limit" },
+static const char *const throttling_logging_label[] = {
+	[THROTTLER_PROCHOT_BIT] = "Prochot",
+	[THROTTLER_PPT_BIT] = "PPT",
+	[THROTTLER_THERMAL_SOCKET_BIT] = "SOC",
+	[THROTTLER_THERMAL_VR_BIT] = "VR",
+	[THROTTLER_THERMAL_HBM_BIT] = "HBM"
 };
+
 static void smu_v13_0_6_log_thermal_throttling_event(struct smu_context *smu)
 {
-	int ret;
 	int throttler_idx, throtting_events = 0, buf_idx = 0;
 	struct amdgpu_device *adev = smu->adev;
 	uint32_t throttler_status;
 	char log_buf[256];
 
-	ret = smu_v13_0_6_get_smu_metrics_data(smu, METRICS_THROTTLER_STATUS,
-					      &throttler_status);
-	if (ret)
+	throttler_status = smu_v13_0_6_get_throttler_status(smu);
+	if (!throttler_status)
 		return;
 
 	memset(log_buf, 0, sizeof(log_buf));
-	for (throttler_idx = 0; throttler_idx < ARRAY_SIZE(logging_label);
+	for (throttler_idx = 0;
+	     throttler_idx < ARRAY_SIZE(throttling_logging_label);
 	     throttler_idx++) {
-		if (throttler_status &
-		    logging_label[throttler_idx].feature_mask) {
+		if (throttler_status & (1U << throttler_idx)) {
 			throtting_events++;
-			buf_idx += snprintf(log_buf + buf_idx,
-					    sizeof(log_buf) - buf_idx, "%s%s",
-					    throtting_events > 1 ? " and " : "",
-					    logging_label[throttler_idx].label);
+			buf_idx += snprintf(
+				log_buf + buf_idx, sizeof(log_buf) - buf_idx,
+				"%s%s", throtting_events > 1 ? " and " : "",
+				throttling_logging_label[throttler_idx]);
 			if (buf_idx >= sizeof(log_buf)) {
 				dev_err(adev->dev, "buffer overflow!\n");
 				log_buf[sizeof(log_buf) - 1] = '\0';
@@ -1932,10 +1930,9 @@ static void smu_v13_0_6_log_thermal_throttling_event(struct smu_context *smu)
 		}
 	}
 
-	dev_warn(
-		adev->dev,
-		"WARN: GPU thermal throttling temperature reached, expect performance decrease. %s.\n",
-		log_buf);
+	dev_warn(adev->dev,
+		 "WARN: GPU is throttled, expect performance decrease. %s.\n",
+		 log_buf);
 	kgd2kfd_smi_event_throttle(
 		smu->adev->kfd.dev,
 		smu_cmn_get_indep_throttler_status(throttler_status,
-- 
2.34.1

