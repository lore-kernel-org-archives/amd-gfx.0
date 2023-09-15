Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3741EE645B
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Sep 2023 13:00:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2CB9A10E625;
	Fri, 15 Sep 2023 13:00:21 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2055.outbound.protection.outlook.com [40.107.243.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 93C6510E628
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Sep 2023 13:00:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BuqeACg/h+aJD1QKSlI+YJlktqKVuCpJFwNrN9KGFlIIhSn2pCeZxqRnk20PpmedsYUXf6/qlVPCvQpYlS/M5tzgbn8vOBJv03augx4+aX1W3VJ3H54csXmwYC3HQWQa5xT25cPGxo1O9O2X9LdfodHtU9So5Sb9MspuiWrOg4GsTDWgFK3kBA5sipZeABpAcyrzP+xCZGdD9PTyqRTQPVAeH4KQU6plexNAHLVBblZc4YlBsFEuMH0dte4zWbSMLAuj2pIH4/48kWPA/L4mYmIHnQbLymxYIl7xaHM3sVxz1e3xQzGj9qGOQPwvllpgmzjyNcNOzQVFwCidpojkGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U7VOOZf9OKMYzzCQcm3oK+xmJ4657CoxFvAGaJOkwzE=;
 b=CpU5PLEwqswElg16r2pTlJh4rsiTEw3MKfNDh2TBmzTq0IDT811VojeV3dlEP6Jix5RrWY50OfnhLYueTSPpKL2GTrQEA23gLIq28FdzOkjmO96rgv9WdXh6Gxc90EqTQ5H7ndRfJfnWaWnhXCqpRhD9PNQloasIYwQAXz/cKbeuc3OQ2x5K6Apk38MPdxWvgKZERHYQjeiky/qRCEJIDcSoBii1ao60tiX7h4gtGVSrWm+eWhzPoKFqNfZLo67IWqTL36bdDNOgyKC6pmwiEO8fH06xohT4ZW8RAhm+0AvfYv9T5jr1alPfvbaQEUhnkLoCRmoI07TP3gBwvE2Zkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U7VOOZf9OKMYzzCQcm3oK+xmJ4657CoxFvAGaJOkwzE=;
 b=5JGR3wac1R/I09ySYT8PxmlJAAymN0GZXZxVxlbkxNUef874ft2gOZfw8Bd6v56ohB5UNW5cMO6rcTc/RNkxK0GdT7CJHVXqRzLueUuFs6q4R0MIOAZnWvIaNvO6SAbNpn+dCPkp+WcIwC7N81ZupjkXp2meYjvYQGV31KtCako=
Received: from DM6PR03CA0073.namprd03.prod.outlook.com (2603:10b6:5:333::6) by
 PH7PR12MB8054.namprd12.prod.outlook.com (2603:10b6:510:27f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.20; Fri, 15 Sep
 2023 13:00:14 +0000
Received: from DS2PEPF00003439.namprd02.prod.outlook.com
 (2603:10b6:5:333:cafe::d) by DM6PR03CA0073.outlook.office365.com
 (2603:10b6:5:333::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.21 via Frontend
 Transport; Fri, 15 Sep 2023 13:00:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003439.mail.protection.outlook.com (10.167.18.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.11 via Frontend Transport; Fri, 15 Sep 2023 13:00:14 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 15 Sep
 2023 08:00:08 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/pm: Round Q10 format values in SMU v13.0.6
Date: Fri, 15 Sep 2023 18:29:37 +0530
Message-ID: <20230915125937.1261267-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003439:EE_|PH7PR12MB8054:EE_
X-MS-Office365-Filtering-Correlation-Id: 95f46dab-fc3b-4f13-6bd8-08dbb5ebb425
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: spKWIjpv/wfIjusLSN8iuJYJNrTX05PGpXZnFMyTgk0ok9Xoag1H+bXK5r8FqL+CeqrHK1b95ALFKN2aG6IBRZVPZGW5fq6ROuuckaaS1IXQ5yOfZv0z2bNLtjoMP0djRXyWFPZklCaAI76WNSk1TBPmmjWFaEDnVGvxsXdV16SuNFiOXxgMm3muc0+XAE8ggWxjau7Da3wrnr9DZzzTGXIGSblFXTgRTCVmF4+gjHp3+AeRNbOM3R9ElkavdZ8fPehUfcQHrC4zPd4+IROMpLF0FRPWuOcB+fa84AYsZ+RlyRuFloZojK1GZJlyI2zZ7/ktco+7zYIEA5IjF2KlRegV57mKTw7kq32021dZ0/srUSkd31d+pM3TwzdqA1BtYLaUwEBZmT4QDp0cSiU/YdBXut6q9Y5Hi2NLTVciK8UZ3zSD8T4QmDPjEADk8zf+SBYe7v9WQOt3WkfZDFzgdwc/SL328yqvtfd9JS6Gv9olb2ohQVyqLd39OUL2xtcbXSE1pkrGK9QxdvOtUBMeuwr16eNrH/NzNZRXOT+ZsA1YnvSH3+lJoEVEBoM/LD7Pyem4BV6ddYlViBN3lIpHiy+wd8qn+nsxkIwECGmYgGYAQht7uyo70Jt/46uaiZk7N5aXmWnk8sljCY3a+37sbvn2QJaT/rtk9GmHtaVs0CqO3HF8RZJi4dfU+GYFlEMCll/Uszszos5mLLKzIBPDlTVTa6qj7lynW6/sa8ZiQcnivbH+bpKaoxUTU+Q1MYGGZJ8+0YAoEMKnTeKLMPDGow==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(346002)(376002)(136003)(39860400002)(82310400011)(451199024)(186009)(1800799009)(46966006)(36840700001)(40470700004)(6916009)(70586007)(40480700001)(70206006)(316002)(81166007)(478600001)(356005)(86362001)(54906003)(40460700003)(36756003)(2906002)(82740400003)(41300700001)(44832011)(8676002)(8936002)(5660300002)(4326008)(26005)(336012)(426003)(16526019)(1076003)(2616005)(36860700001)(83380400001)(47076005)(6666004)(7696005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2023 13:00:14.6412 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 95f46dab-fc3b-4f13-6bd8-08dbb5ebb425
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003439.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8054
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
Cc: Alexander.Deucher@amd.com, Asad.Kamal@amd.com, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Instead of neglecting fractional part, round the Q10 format values in
SMU v13.0.6 metrics table.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 70 ++++++++++---------
 1 file changed, 36 insertions(+), 34 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index f9c1219f0c4f..11a6cd96c601 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -244,6 +244,8 @@ struct PPTable_t {
 };
 
 #define SMUQ10_TO_UINT(x) ((x) >> 10)
+#define SMUQ10_FRAC(x) ((x) & 0x3ff)
+#define SMUQ10_ROUND(x) ((SMUQ10_TO_UINT(x)) + ((SMUQ10_FRAC(x)) >= 0x200))
 
 struct smu_v13_0_6_dpm_map {
 	enum smu_clk_type clk_type;
@@ -389,25 +391,25 @@ static int smu_v13_0_6_setup_driver_pptable(struct smu_context *smu)
 			return -ETIME;
 
 		pptable->MaxSocketPowerLimit =
-			SMUQ10_TO_UINT(metrics->MaxSocketPowerLimit);
+			SMUQ10_ROUND(metrics->MaxSocketPowerLimit);
 		pptable->MaxGfxclkFrequency =
-			SMUQ10_TO_UINT(metrics->MaxGfxclkFrequency);
+			SMUQ10_ROUND(metrics->MaxGfxclkFrequency);
 		pptable->MinGfxclkFrequency =
-			SMUQ10_TO_UINT(metrics->MinGfxclkFrequency);
+			SMUQ10_ROUND(metrics->MinGfxclkFrequency);
 
 		for (i = 0; i < 4; ++i) {
 			pptable->FclkFrequencyTable[i] =
-				SMUQ10_TO_UINT(metrics->FclkFrequencyTable[i]);
+				SMUQ10_ROUND(metrics->FclkFrequencyTable[i]);
 			pptable->UclkFrequencyTable[i] =
-				SMUQ10_TO_UINT(metrics->UclkFrequencyTable[i]);
-			pptable->SocclkFrequencyTable[i] = SMUQ10_TO_UINT(
+				SMUQ10_ROUND(metrics->UclkFrequencyTable[i]);
+			pptable->SocclkFrequencyTable[i] = SMUQ10_ROUND(
 				metrics->SocclkFrequencyTable[i]);
 			pptable->VclkFrequencyTable[i] =
-				SMUQ10_TO_UINT(metrics->VclkFrequencyTable[i]);
+				SMUQ10_ROUND(metrics->VclkFrequencyTable[i]);
 			pptable->DclkFrequencyTable[i] =
-				SMUQ10_TO_UINT(metrics->DclkFrequencyTable[i]);
+				SMUQ10_ROUND(metrics->DclkFrequencyTable[i]);
 			pptable->LclkFrequencyTable[i] =
-				SMUQ10_TO_UINT(metrics->LclkFrequencyTable[i]);
+				SMUQ10_ROUND(metrics->LclkFrequencyTable[i]);
 		}
 
 		/* use AID0 serial number by default */
@@ -730,50 +732,50 @@ static int smu_v13_0_6_get_smu_metrics_data(struct smu_context *smu,
 		smu_cmn_get_smc_version(smu, NULL, &smu_version);
 		if (smu_version >= 0x552F00) {
 			xcc_id = GET_INST(GC, 0);
-			*value = SMUQ10_TO_UINT(metrics->GfxclkFrequency[xcc_id]);
+			*value = SMUQ10_ROUND(metrics->GfxclkFrequency[xcc_id]);
 		} else {
 			*value = 0;
 		}
 		break;
 	case METRICS_CURR_SOCCLK:
 	case METRICS_AVERAGE_SOCCLK:
-		*value = SMUQ10_TO_UINT(metrics->SocclkFrequency[0]);
+		*value = SMUQ10_ROUND(metrics->SocclkFrequency[0]);
 		break;
 	case METRICS_CURR_UCLK:
 	case METRICS_AVERAGE_UCLK:
-		*value = SMUQ10_TO_UINT(metrics->UclkFrequency);
+		*value = SMUQ10_ROUND(metrics->UclkFrequency);
 		break;
 	case METRICS_CURR_VCLK:
-		*value = SMUQ10_TO_UINT(metrics->VclkFrequency[0]);
+		*value = SMUQ10_ROUND(metrics->VclkFrequency[0]);
 		break;
 	case METRICS_CURR_DCLK:
-		*value = SMUQ10_TO_UINT(metrics->DclkFrequency[0]);
+		*value = SMUQ10_ROUND(metrics->DclkFrequency[0]);
 		break;
 	case METRICS_CURR_FCLK:
-		*value = SMUQ10_TO_UINT(metrics->FclkFrequency);
+		*value = SMUQ10_ROUND(metrics->FclkFrequency);
 		break;
 	case METRICS_AVERAGE_GFXACTIVITY:
-		*value = SMUQ10_TO_UINT(metrics->SocketGfxBusy);
+		*value = SMUQ10_ROUND(metrics->SocketGfxBusy);
 		break;
 	case METRICS_AVERAGE_MEMACTIVITY:
-		*value = SMUQ10_TO_UINT(metrics->DramBandwidthUtilization);
+		*value = SMUQ10_ROUND(metrics->DramBandwidthUtilization);
 		break;
 	case METRICS_CURR_SOCKETPOWER:
-		*value = SMUQ10_TO_UINT(metrics->SocketPower) << 8;
+		*value = SMUQ10_ROUND(metrics->SocketPower) << 8;
 		break;
 	case METRICS_TEMPERATURE_HOTSPOT:
-		*value = SMUQ10_TO_UINT(metrics->MaxSocketTemperature) *
+		*value = SMUQ10_ROUND(metrics->MaxSocketTemperature) *
 			 SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
 		break;
 	case METRICS_TEMPERATURE_MEM:
-		*value = SMUQ10_TO_UINT(metrics->MaxHbmTemperature) *
+		*value = SMUQ10_ROUND(metrics->MaxHbmTemperature) *
 			 SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
 		break;
 	/* This is the max of all VRs and not just SOC VR.
 	 * No need to define another data type for the same.
 	 */
 	case METRICS_TEMPERATURE_VRSOC:
-		*value = SMUQ10_TO_UINT(metrics->MaxVrTemperature) *
+		*value = SMUQ10_ROUND(metrics->MaxVrTemperature) *
 			 SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
 		break;
 	default:
@@ -1996,33 +1998,33 @@ static ssize_t smu_v13_0_6_get_gpu_metrics(struct smu_context *smu, void **table
 	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 1, 3);
 
 	gpu_metrics->temperature_hotspot =
-		SMUQ10_TO_UINT(metrics->MaxSocketTemperature);
+		SMUQ10_ROUND(metrics->MaxSocketTemperature);
 	/* Individual HBM stack temperature is not reported */
 	gpu_metrics->temperature_mem =
-		SMUQ10_TO_UINT(metrics->MaxHbmTemperature);
+		SMUQ10_ROUND(metrics->MaxHbmTemperature);
 	/* Reports max temperature of all voltage rails */
 	gpu_metrics->temperature_vrsoc =
-		SMUQ10_TO_UINT(metrics->MaxVrTemperature);
+		SMUQ10_ROUND(metrics->MaxVrTemperature);
 
 	gpu_metrics->average_gfx_activity =
-		SMUQ10_TO_UINT(metrics->SocketGfxBusy);
+		SMUQ10_ROUND(metrics->SocketGfxBusy);
 	gpu_metrics->average_umc_activity =
-		SMUQ10_TO_UINT(metrics->DramBandwidthUtilization);
+		SMUQ10_ROUND(metrics->DramBandwidthUtilization);
 
 	gpu_metrics->average_socket_power =
-		SMUQ10_TO_UINT(metrics->SocketPower);
+		SMUQ10_ROUND(metrics->SocketPower);
 	/* Energy counter reported in 15.259uJ (2^-16) units */
 	gpu_metrics->energy_accumulator = metrics->SocketEnergyAcc;
 
 	gpu_metrics->current_gfxclk =
-		SMUQ10_TO_UINT(metrics->GfxclkFrequency[xcc0]);
+		SMUQ10_ROUND(metrics->GfxclkFrequency[xcc0]);
 	gpu_metrics->current_socclk =
-		SMUQ10_TO_UINT(metrics->SocclkFrequency[inst0]);
-	gpu_metrics->current_uclk = SMUQ10_TO_UINT(metrics->UclkFrequency);
+		SMUQ10_ROUND(metrics->SocclkFrequency[inst0]);
+	gpu_metrics->current_uclk = SMUQ10_ROUND(metrics->UclkFrequency);
 	gpu_metrics->current_vclk0 =
-		SMUQ10_TO_UINT(metrics->VclkFrequency[inst0]);
+		SMUQ10_ROUND(metrics->VclkFrequency[inst0]);
 	gpu_metrics->current_dclk0 =
-		SMUQ10_TO_UINT(metrics->DclkFrequency[inst0]);
+		SMUQ10_ROUND(metrics->DclkFrequency[inst0]);
 
 	gpu_metrics->average_gfxclk_frequency = gpu_metrics->current_gfxclk;
 	gpu_metrics->average_socclk_frequency = gpu_metrics->current_socclk;
@@ -2047,9 +2049,9 @@ static ssize_t smu_v13_0_6_get_gpu_metrics(struct smu_context *smu, void **table
 	gpu_metrics->system_clock_counter = ktime_get_boottime_ns();
 
 	gpu_metrics->gfx_activity_acc =
-		SMUQ10_TO_UINT(metrics->SocketGfxBusyAcc);
+		SMUQ10_ROUND(metrics->SocketGfxBusyAcc);
 	gpu_metrics->mem_activity_acc =
-		SMUQ10_TO_UINT(metrics->DramBandwidthUtilizationAcc);
+		SMUQ10_ROUND(metrics->DramBandwidthUtilizationAcc);
 
 	gpu_metrics->firmware_timestamp = metrics->Timestamp;
 
-- 
2.25.1

