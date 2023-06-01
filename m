Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2C3DC77B7A
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Jun 2023 07:28:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1613A10E211;
	Thu,  1 Jun 2023 07:28:33 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on20628.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8b::628])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE08810E138
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Jun 2023 07:28:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IIzGGn1aNtlRSrliyiYX33xruLyc7AhqFV5W00mty0smvaKjU6XRbnlHI7gug4YU68FmmUphulZ3IllDynRbnSyYwYOy3Di7RzofiiCDl9XWYQlgVfDY2RbdoztvX4gQ2dHrkCG9rTyzC1+Gtqf+T19lrN//5Q6oeP+oiIWsmi6BJueVc/edqPRK8P6KvtxbWZDJ8ks9xV8qeBi0zsjC8KBcnaI+8yvlGisZAdhUtAv4Lrp9PR2fh1M95+mRxG6bowyF+3BQ+Kwcalkj4S81LAdItWprMmru2THv7mRQ11rzxmSoXs0aIkINSwTt9jcSF0iGkQhiRndnSfHbLQrgcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Of6Sxa6dnxzigrZ1RIowVQMCauont8als36eanpXn3I=;
 b=dJstQ1971dMItZYDOyOiYRzn/HE9iDMXCTidTsVG1NNSrFWRTebthGgdCxIChkblaerNtRz9u2Kwxvlyulr6/pgwTWDO+W7pSgDOwoBgXc5QHpc/ql08rpOTnOHpMMcbSDqJgRuBJ2mKCIzceP8aA8TsZDlStNOXCzItDsblVBid4F/8UmSrsuiSh9bwny0g3YKXXqVrBDLvNKjEGToVjQhsjLUYGENnsUzcYF0nLgWJosQN1ALyTcgIbZFvveLkDP5RUilAII8KE7uja3iDTjK7ho2knVL6Pt6e5BpHtmm1H3eGFV5RL3yJ3EJL97Sfpc8xuyiPpxOpVis1QMc4Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Of6Sxa6dnxzigrZ1RIowVQMCauont8als36eanpXn3I=;
 b=37+8HtcE1MVOPVD5fOsYvA4jXuuKsLXTkMt0qD71w6/IcD6ub1DBcda1B3zTMD4kIt1bXRYOV1AsX8hGH681kIfxHgLnyvu5VZ6b4EU/rYNH/rM1XRQ1YOIkXHxdtCIJ0OP88pGDxxs+syrs7NdT2YqKrw9Bt2PWWF3WT8H5mQs=
Received: from SJ0PR03CA0064.namprd03.prod.outlook.com (2603:10b6:a03:331::9)
 by IA1PR12MB9062.namprd12.prod.outlook.com (2603:10b6:208:3aa::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.22; Thu, 1 Jun
 2023 07:28:25 +0000
Received: from DM6NAM11FT052.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:331:cafe::b3) by SJ0PR03CA0064.outlook.office365.com
 (2603:10b6:a03:331::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.22 via Frontend
 Transport; Thu, 1 Jun 2023 07:28:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT052.mail.protection.outlook.com (10.13.172.111) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6455.23 via Frontend Transport; Thu, 1 Jun 2023 07:28:24 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 1 Jun
 2023 02:28:22 -0500
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/3] drm/amd/pm: Fix SMUv13.0.6 throttle status report
Date: Thu, 1 Jun 2023 15:28:03 +0800
Message-ID: <20230601072803.1321429-3-asad.kamal@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230601072803.1321429-1-asad.kamal@amd.com>
References: <20230601072803.1321429-1-asad.kamal@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT052:EE_|IA1PR12MB9062:EE_
X-MS-Office365-Filtering-Correlation-Id: b6a2dad8-9c64-445b-338d-08db6271c8f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UcCGlJPYfqUZnirdpScEBZOnAsliAOScqduEpO2vawLP6jyBreuWMAAy714D/PUUJdH8DBGc4aLfIL6gzo1QwtCr6uj90KqGo1o2x2CvFr+fq57bp2P/JCSUh1A3UgPtkwi1Eg39wK3j7YOXcbRpuV+yluOw8ti2NIx6BlJnQZUMXf83Sxi/AR+hSu4sXw8fbuaAFHpXspjGOLaPMpgQott7fv/oMuAJVOLsH26sVZjZkuZJL7UAEfJOsPxqqRtNnKQti6+eBmQQCic+kbMFSUThkrP4bdgf5ZxJTWb+CsaV8p/bqoziaRPpiFfutBB8s7/i0qjKya+BAJRg0ls2McZGTZkM3ukwS0PMM58N6pYN32yIgU8pLcJLZ/qtZqQErSaIfye3SbzJA8C81WipEuUVvx32lBlsVClcqrEe94aDTyy+Mkgi6kpKoodAzP3MfcdvnOVZpKtrPjv6XUgdezW1RPog4Lyf+sjl/GjgXY5ecUlGx96KLuSlC71/xRqksNYwUxMIKpHCbyPZNBGoPrWwsn8mgbY5jOfGC+LsHmIcRhd8HzWICXxAvkmu6FQYo9myviXVJACu75GA68KIt1SKOd0ecTrhM4fKZLLb3Gts5taUFZ68CHL3HcQKOXElAQYGzlsIIK1vGEMsf2RjQh8DhbnoAuUuBYLI3JJGcfZbfeEHAiUgBc43SIJ6K8/0EaIJZKlz3wiIK1E5WgN2s+WPtwOV3ZAUmxRB364mvOF8b81M+0T0+SXd7F3MIkFKBxwKxkCiWb4fbtcO0/V2tA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(346002)(396003)(39860400002)(136003)(451199021)(36840700001)(46966006)(40470700004)(356005)(6916009)(83380400001)(70206006)(70586007)(478600001)(36860700001)(4326008)(41300700001)(40480700001)(2616005)(47076005)(81166007)(82740400003)(316002)(54906003)(8936002)(8676002)(26005)(5660300002)(1076003)(86362001)(40460700003)(2906002)(186003)(16526019)(82310400005)(36756003)(7696005)(336012)(426003)(44832011)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2023 07:28:24.4287 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b6a2dad8-9c64-445b-338d-08db6271c8f0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT052.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9062
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

v2: Removed Dummy definition

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 95 +++++++++----------
 1 file changed, 45 insertions(+), 50 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 27fd71afc73f..b9f32e0364db 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -82,8 +82,6 @@
 
 #define smnPCIE_ESM_CTRL 0x111003D0
 
-#define THROTTLER_TEMP_HBM_BIT 2
-
 static const struct cmn2asic_msg_mapping smu_v13_0_6_message_map[SMU_MSG_MAX_COUNT] = {
 	MSG_MAP(TestMessage,			     PPSMC_MSG_TestMessage,			0),
 	MSG_MAP(GetSmuVersion,			     PPSMC_MSG_GetSmuVersion,			1),
@@ -174,17 +172,12 @@ static const struct cmn2asic_mapping smu_v13_0_6_table_map[SMU_TABLE_COUNT] = {
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
@@ -642,16 +635,14 @@ static int smu_v13_0_6_freqs_in_same_level(int32_t frequency1,
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
@@ -721,9 +712,6 @@ static int smu_v13_0_6_get_smu_metrics_data(struct smu_context *smu,
 	case METRICS_TEMPERATURE_VRSOC:
 		*value = SMUQ10_TO_UINT(metrics->MaxVrTemperature);
 		break;
-	case METRICS_THROTTLER_STATUS:
-		*value = smu_v13_0_6_get_throttler_status(smu, metrics);
-		break;
 	default:
 		*value = UINT_MAX;
 		break;
@@ -1290,13 +1278,11 @@ static int smu_v13_0_6_irq_process(struct amdgpu_device *adev,
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
@@ -1305,7 +1291,10 @@ static int smu_v13_0_6_irq_process(struct amdgpu_device *adev,
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
@@ -1316,8 +1305,17 @@ static int smu_v13_0_6_irq_process(struct amdgpu_device *adev,
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
@@ -1895,37 +1893,35 @@ static int smu_v13_0_6_allow_xgmi_power_down(struct smu_context *smu, bool en)
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
@@ -1934,10 +1930,9 @@ static void smu_v13_0_6_log_thermal_throttling_event(struct smu_context *smu)
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

