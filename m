Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FC7EC5AC7A
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Aug 2026 12:29:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CBC3B10E0D0;
	Fri,  7 Aug 2026 12:29:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Vng+xlBh";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010011.outbound.protection.outlook.com [52.101.46.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 839BF10E0D0
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Aug 2026 12:29:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bJ/kgs4Ex3FKnZkULiWzCjh6VQ3Obkcq7l+qvIegtkO+2RsnBgUgp8a+6Ofkkaeng6J5+xjDQGSWAJrWaX62XbodzUZ18UyTjqvoZE1npc/bq+EhmgE80iKsHdrmuDZKc414Gj2hQHxFqJa67ZP/mdZuX6CpjgpH8EMTFDvS9XbklEtW/CNiGTBcxpB94bpuX6tYMEg/2u/SJDpkd319O+DmLkRrSB3V3pYAHhx9Rku21KMKOZg7zglHARHDN8lqK11Yt36xHC/sNr14l1wtPMr2nCryk7CJ6mIb758bTzIqXLoZHV5Gig+NmfetwhU74JwaNt0ZDUSLwcybbPP7wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y/rtKI/hr3wAFJPRkh1cTVSU3gvRYqSfuk684cXyUQU=;
 b=Pq12gWEkCrMC3DPHwziviGCpw6KGAydEuyOppuU6YLKv8K3OjYo2ppdwSZ1kQDy5gqYgYEZ/RbhkAULU/15MVTmJRjRQqMgrIShAc8qhx5ov/qL8pKOgxv+gBzr8TqWjUTcqwFE4pZR5tETGNV77Nx/tj/DM6Cg7Vqk0RfNc1nsMKqRr4IVWSc4kGfPHQhBFbZ4iJlCAUxJjQDAnlPokOmKLYBua/l7Mtf3lpeovG3Ff6spFXflwcGsgQyhVmYagV3JHsJMTPdXbIO5rlH5GDSlsCBfuYFu4HB708ph273yHNQUFnWKc/MqUTqdP7GrwgGxHQfYr3OCIe9dR8jj7YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y/rtKI/hr3wAFJPRkh1cTVSU3gvRYqSfuk684cXyUQU=;
 b=Vng+xlBhMitHtfJRLbLpUIiUgQrDzmiCyBXbdeII7XMeetxw6gC7PYb08y6KNLNMq68RzN9ALjLXxz0rquv6qf/KfYNlzzXu9IwK2jyMYyqGxGF/4pwc9/9l3otUAHbD/FrVkqaOlCTGK4MMIabBpuwQHmiG+KoTlP1q42QZ13A=
Received: from MW4PR03CA0273.namprd03.prod.outlook.com (2603:10b6:303:b5::8)
 by PH7PR12MB7870.namprd12.prod.outlook.com (2603:10b6:510:27b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.23; Fri, 7 Aug
 2026 12:29:36 +0000
Received: from SJ5PEPF00000209.namprd05.prod.outlook.com
 (2603:10b6:303:b5:cafe::1c) by MW4PR03CA0273.outlook.office365.com
 (2603:10b6:303:b5::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.23 via Frontend Transport; Fri, 7
 Aug 2026 12:29:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF00000209.mail.protection.outlook.com (10.167.244.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Fri, 7 Aug 2026 12:29:35 +0000
Received: from shubhankar-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Fri, 7 Aug 2026 07:29:32 -0500
From: Shubhankar Milind Sardeshpande <Shubhankar.MilindSardeshpande@amd.com>
To: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <Lijo.Lazar@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: <Pratik.Vishwakarma@amd.com>, <Shubhankar.MilindSardeshpande@amd.com>,
 <Veerabadhran.Gopalakrishnan@amd.com>
Subject: [PATCH] drm/amd/pm: compute SMU v15.0.0 gpu_metrics from accumulator
 table
Date: Fri, 7 Aug 2026 17:56:56 +0530
Message-ID: <20260807122918.3677218-1-Shubhankar.MilindSardeshpande@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000209:EE_|PH7PR12MB7870:EE_
X-MS-Office365-Filtering-Correlation-Id: a81ba97b-3591-4912-2454-08def47f8aab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|23010399003|82310400026|18002099003|10067099003|56012099006|6133799003|11063799006;
X-Microsoft-Antispam-Message-Info: CO2t3D5BhxAOzWlh/rRkOjiW0K520p7VRVSsoa0qiCBVD5QwuO/PGu8Cawcg9JrIS2tmAKHFxiC6e50UsbBhrOgiBM/OsvDcY2haBNaff4F4an7V1I3phfs9QlwZMTNmn30sBgCa3zKzLOdStQfn3zpy3mX5fiQC45uuqt3+b8m/BNL/kXF0FoExnd7NlqO7jfIN10ZJ0xMx/KkuAa6EF/JA3XZxTjpJeO2rSHVLpaI08cdEOyilOO50rdxE2UzzASJteiJGPCTDe9ExOlGmxIkHehc0MXx9PErewkHgPZ6xY54iMYRN+VfnijzQ5/pVbgUQ0LeSqUFdd0nJW/DCp9kVeLoI/HWSaefcq0YNqVe/dLtuUG2Y9UTqGDnA63GkBTbWlNr/YCCUXYGB47agPd4ORnZQrpbRrAdsKkOCQKb+vSw+zUQvdoVeBpn3rSsL7KNgD8PXXrUDOfP+zrvaFujcCvJ7Ls9N2oJ9jg4GrIXf2pm2vqWRSnd89v/UqtLENHEJ6zZZbrQrQc7TWlVN0nQpSouw1urWl4wmzjgEErgCxr7vVPEepcggVX9be5QWQCwTMQznP5XUF5GDZb1xG055sJesF4uigtGdNWSoDK/ZH4adtQHTLJAAGSu4L5XzCTsUsKejz/IOSHLCI7qKVbYAInxjmXjgAdteUCyF8RFllxROnQt86iIT3MmXAE+XfC6vekyeQxzCbOIwA8E8Iw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(23010399003)(82310400026)(18002099003)(10067099003)(56012099006)(6133799003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: n4txWp/K6lOLd1QpsnbDK5CT8gahmFs1PeOmj5Q418sL6gOvaB4GwghWw5eF4nlQNILZIC9gu4n3v0K1Rvfue66vn4lIgcF4rg5AJU3LWvYZvaJCPtwEa3EwdtpXytfvilcsgQyrNX8lxhKVXlWGLje/FxVZoBbnzBVBT8VPZauQEtkrMbCr8aFGFIwY28vQce0WLncnRsAL1JGUdOdQbQ0fdbo4nAa2GAEcbRS/bzfzYu/u5dag9iWbyUJea2kXL5FIZ2xqYLaHYUnHRg+8yZUHXpl1CcH7u92d19QJ/DMUknmi/CqislrGDpyIvaoL7v3IwhxwvdvQ6kacDCcVaSZgzLBmM6TkQRo3pv0GKOV0e8hfwdD18cJXExrMgZvNNDwkuJEkD2ldyhTjyiB91NkUinTBSuOBTdEl+EPds/Q+ny90ppxYju8g8IruEwTI
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2026 12:29:35.6424 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a81ba97b-3591-4912-2454-08def47f8aab
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000209.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7870
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Rework smu_v15_0_0_get_gpu_metrics() to derive values from the raw
accumulator double-buffer instead of the firmware-computed SmuMetrics_t
snapshot:

- Add SMU_V15_IOD_AVG()/SMU_V15_CCX_AVG() helpers: wrapping_sub() delta
  over the sampling window, scaled by the caller's unit factor, then
  descaled from 1024x fixed-point with >>10 (scale before shift to keep
  sub-unit precision); typeof() preserves each field's width.
- Reuse the same macro in smu_v15_0_0_compute_all_metrics(), dropping
  the open-coded div_u64(..., 1024) boilerplate.
- Drop the unused smu_v15_0_0_get_gpu_metrics_table() helper and the
  SMU_TABLE_SMU_METRICS allocation.

Signed-off-by: Shubhankar Milind Sardeshpande <Shubhankar.MilindSardeshpande@amd.com>
Assisted-by: Claude:claude-opus-4.8
---
 .../inc/pmfw_if/smu15_driver_if_v15_0_0.h     |  46 ---
 .../drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c  | 282 +++++++++---------
 2 files changed, 140 insertions(+), 188 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu15_driver_if_v15_0_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu15_driver_if_v15_0_0.h
index a5d3e8d88860..94932d8f3e61 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu15_driver_if_v15_0_0.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu15_driver_if_v15_0_0.h
@@ -182,52 +182,6 @@ typedef struct {
 	uint32_t Spare9[8];
 } DpmClocks_t_v15_0_5;
 
-typedef struct {
-  uint16_t CoreFrequency[16];          //Target core frequency [MHz]
-  uint16_t CorePower[16];              //CAC calculated core power [mW]
-  uint16_t CoreTemperature[16];        //TSEN measured core temperature [centi-C]
-  uint16_t GfxTemperature;             //TSEN measured GFX temperature [centi-C]
-  uint16_t SocTemperature;             //TSEN measured SOC temperature [centi-C]
-  uint16_t StapmOpnLimit;              //Maximum IRM defined STAPM power limit [mW]
-  uint16_t StapmCurrentLimit;          //Time filtered STAPM power limit [mW]
-  uint16_t InfrastructureCpuMaxFreq;   //CCLK frequency limit enforced on classic cores [MHz]
-  uint16_t InfrastructureGfxMaxFreq;   //GFXCLK frequency limit enforced on GFX [MHz]
-  uint16_t SkinTemp;                   //Maximum skin temperature reported by APU and HS2 chassis sensors [centi-C]
-  uint16_t GfxclkFrequency;            //Time filtered target GFXCLK frequency [MHz]
-  uint16_t FclkFrequency;              //Time filtered target FCLK frequency [MHz]
-  uint16_t GfxActivity;                //Time filtered GFX busy % [0-100]
-  uint16_t SocclkFrequency;            //Time filtered target SOCCLK frequency [MHz]
-  uint16_t VclkFrequency;              //Time filtered target VCLK frequency [MHz]
-  uint16_t VcnActivity;                //Time filtered VCN busy % [0-100]
-  uint16_t VpeclkFrequency;            //Time filtered target VPECLK frequency [MHz]
-  uint16_t NpuclkFrequency;            //Time filtered target NPUCLK frequency [MHz]
-  uint16_t NpuBusy[8];                 //Time filtered NPU per-column busy % [0-100]
-  uint16_t DRAMReads;                  //Time filtered DRAM read bandwidth [MB/sec]
-  uint16_t DRAMWrites;                 //Time filtered DRAM write bandwidth [MB/sec]
-  uint16_t CoreC0Residency[16];        //Time filtered per-core C0 residency % [0-100]
-  uint16_t NpuPower;                   //Time filtered NPU power [mW]
-  uint32_t ApuPower;                   //Time filtered APU power [mW]
-  uint32_t GfxPower;                   //Time filtered GFX power [mW]
-  uint32_t dGpuPower;                  //Time filtered dGPU power [mW]
-  uint32_t SocketPower;                //Time filtered power used for PPT/STAPM [APU+dGPU] [mW]
-  uint32_t AllCorePower;               //Time filtered sum of core power across all cores in the socket [mW]
-  uint32_t FilterAlphaValue;           //Metrics table alpha filter time constant [us]
-  uint32_t MetricsCounter;             //Counter that is incremented on every metrics table update [PM_TIMER cycles]
-  uint16_t MemclkFrequency;            //Time filtered target MEMCLK frequency [MHz]
-  uint16_t AieclkFrequency;            //Time filtered target AIECLK frequency [MHz]
-  uint16_t NpuReads;                   //Time filtered NPU read bandwidth [MB/sec]
-  uint16_t NpuWrites;                  //Time filtered NPU write bandwidth [MB/sec]
-  uint32_t ThrottleResidency_PROCHOT;  //Counter that is incremented on every metrics table update when PROCHOT was engaged [PM_TIMER cycles]
-  uint32_t ThrottleResidency_SPL;      //Counter that is incremented on every metrics table update when SPL was engaged [PM_TIMER cycles]
-  uint32_t ThrottleResidency_FPPT;     //Counter that is incremented on every metrics table update when fast PPT was engaged [PM_TIMER cycles]
-  uint32_t ThrottleResidency_SPPT;     //Counter that is incremented on every metrics table update when slow PPT was engaged [PM_TIMER cycles]
-  uint32_t ThrottleResidency_THM_VDD;  //Counter that is incremented on every metrics table update when VDD thermal throttling was engaged [PM_TIMER cycles]
-  uint32_t ThrottleResidency_THM_SOC;  //Counter that is incremented on every metrics table update when SOC thermal throttling was engaged [PM_TIMER cycles]
-  uint16_t Psys;                       //Time filtered Psys power [mW]
-  uint16_t spare1;
-  uint32_t spare[6];
-} SmuMetrics_t;
-
 //ISP tile definitions
 typedef enum {
   TILE_XTILE = 0,         //ONO0
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
index 12fe2bc0488e..2bcd20072583 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
@@ -203,8 +203,6 @@ static int smu_v15_0_0_init_smc_tables(struct smu_context *smu)
 		PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
 	SMU_TABLE_INIT(tables, SMU_TABLE_DPMCLOCKS, sizeof(DpmClocks_t_v15_0_5),
 		PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
-	SMU_TABLE_INIT(tables, SMU_TABLE_SMU_METRICS, sizeof(SmuMetrics_t),
-		PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
 
 	smu_table->metrics_table = kzalloc_obj(SMU_15_0_0_MetricsInfo_t);
 	if (!smu_table->metrics_table)
@@ -348,36 +346,6 @@ static int smu_v15_0_0_set_default_dpm_tables(struct smu_context *smu)
 				    smu_table->clocks_table, false);
 }
 
-static int smu_v15_0_0_get_gpu_metrics_table(struct smu_context *smu,
-							void *metrics_table,
-							bool bypass_cache)
-{
-	struct smu_table_context *smu_table = &smu->smu_table;
-	uint32_t table_size =
-			smu_table->tables[SMU_TABLE_SMU_METRICS].size;
-	int ret;
-
-	if (bypass_cache ||
-		!smu_table->metrics_time ||
-		time_after(jiffies, smu_table->metrics_time + msecs_to_jiffies(1))) {
-		ret = smu_v15_0_0_update_table(smu,
-						SMU_TABLE_SMU_METRICS,
-						0,
-						smu_table->metrics_table,
-						false);
-		if (ret) {
-			dev_info(smu->adev->dev, "Failed to export SMU15_0_0 metrics table!\n");
-			return ret;
-		}
-		smu_table->metrics_time = jiffies;
-	}
-
-	if (metrics_table)
-		memcpy(metrics_table, smu_table->metrics_table, table_size);
-
-	return 0;
-}
-
 /*
  * Fetch a fresh metrics sample into the inactive buffer.
  * Returns 0 if a new sample was copied, 1 if the cached sample is still
@@ -424,85 +392,74 @@ static int smu_v15_0_0_get_metrics_table(struct smu_context *smu,
 }
 
 /*
- * Accumulators monotonically increase and roll over at their type width.
- * Use the kernel wrapping_sub() API to compute the delta so the subtraction
- * wraps modulo 2^n (correct across a single rollover) without tripping any
- * wrap-around sanitizers.
+ * All accumulators below are 1024x fixed-point values in their native unit.
+ * The average over the sampling window is (curr - prev) / AccumulationCounter,
+ * still 1024x fixed-point. We multiply by @scale first (to preserve the
+ * sub-unit fractional bits the scaled unit needs) and only then descale by
+ * 1024 with a >>10 shift. wrapping_sub() handles a single accumulator rollover
+ * without tripping wrap sanitizers; typeof() keeps the modular subtraction at
+ * the field's real width (the *_ResidencyAcc fields are u32, the rest u64).
+ *
+ * @scale folds in the unit conversion the consumer expects:
+ *   1    -> native unit  (MHz, %)
+ *   1000 -> W->mW, GHz->MHz, GB/s->MB/s, V->mV
+ *   100  -> C->centi-C
+ */
+#define SMU_V15_IOD_AVG(field, scale)						\
+	((uint32_t)((div64_u64(wrapping_sub(typeof(c->field),			\
+					    c->field, p->field),		\
+			       counter) * (scale)) >> 10))
+#define SMU_V15_CCX_AVG(field, scale)						\
+	((uint32_t)((div64_u64(wrapping_sub(typeof(curr->CCX[ccx].field[core]),	\
+					    curr->CCX[ccx].field[core],		\
+					    prev->CCX[ccx].field[core]),	\
+			       counter) * (scale)) >> 10))
+
+/*
+ * Compute the windowed average of every sensor exposed through read_sensor and
+ * cache it in avg_metric[]. Units here follow the hwmon/sysfs sensor ABI
+ * (milli-C, mW, mV), which differs from the gpu_metrics scaling used in
+ * smu_v15_0_0_get_gpu_metrics(). SMU_V15_IOD_AVG() relies on the c, p and
+ * counter locals declared below.
  */
 static void smu_v15_0_0_compute_all_metrics(
 		uint32_t *avg_metric,
 		MetricsTable_t *prev,
 		MetricsTable_t *curr)
 {
-	uint64_t counter, val;
-	uint32_t mw;
 	MetricsTable_IOD_t *p = &prev->IOD;
 	MetricsTable_IOD_t *c = &curr->IOD;
+	uint64_t counter;
 
 	counter = wrapping_sub(u32, c->AccumulationCounter, p->AccumulationCounter);
 	if (!counter)
 		return;
 
-	/* Accumulator-based clock frequencies (fixed-point /1024) */
-	val = wrapping_sub(u64, c->GfxclkFreqEffAcc, p->GfxclkFreqEffAcc);
-	avg_metric[METRICS_AVERAGE_GFXCLK] = div_u64(div64_u64(val, counter), 1024);
-
-	val = wrapping_sub(u64, c->SocclkFreqEffAcc, p->SocclkFreqEffAcc);
-	avg_metric[METRICS_AVERAGE_SOCCLK] = div_u64(div64_u64(val, counter), 1024);
+	/* Effective clocks: accumulator already in MHz. */
+	avg_metric[METRICS_AVERAGE_GFXCLK] = SMU_V15_IOD_AVG(GfxclkFreqEffAcc, 1);
+	avg_metric[METRICS_AVERAGE_SOCCLK] = SMU_V15_IOD_AVG(SocclkFreqEffAcc, 1);
+	avg_metric[METRICS_AVERAGE_VCLK] = SMU_V15_IOD_AVG(VclkFreqEffAcc, 1);
+	avg_metric[METRICS_AVERAGE_UCLK] = SMU_V15_IOD_AVG(MemclkFreqEffAcc, 1);
+	avg_metric[METRICS_AVERAGE_FCLK] = SMU_V15_IOD_AVG(FclkFreqEffAcc, 1);
+	avg_metric[METRICS_AVERAGE_NPUCLK] = SMU_V15_IOD_AVG(NpuhclkFreqEffAcc, 1);
 
-	val = wrapping_sub(u64, c->VclkFreqEffAcc, p->VclkFreqEffAcc);
-	avg_metric[METRICS_AVERAGE_VCLK] = div_u64(div64_u64(val, counter), 1024);
+	/* Activity: accumulator already in %. */
+	avg_metric[METRICS_AVERAGE_GFXACTIVITY] = SMU_V15_IOD_AVG(GfxBusyAcc, 1);
+	avg_metric[METRICS_AVERAGE_VCNACTIVITY] = SMU_V15_IOD_AVG(VcnBusyAcc, 1);
 
-	val = wrapping_sub(u64, c->MemclkFreqEffAcc, p->MemclkFreqEffAcc);
-	avg_metric[METRICS_AVERAGE_UCLK] = div_u64(div64_u64(val, counter), 1024);
+	/* Power: accumulator in W -> mW (hwmon/debugfs). */
+	avg_metric[METRICS_AVERAGE_SOCKETPOWER] = SMU_V15_IOD_AVG(ApuPowerAcc, 1000);
+	avg_metric[METRICS_CURR_SOCKETPOWER] = SMU_V15_IOD_AVG(SystemPowerAcc, 1000);
 
-	val = wrapping_sub(u64, c->FclkFreqEffAcc, p->FclkFreqEffAcc);
-	avg_metric[METRICS_AVERAGE_FCLK] = div_u64(div64_u64(val, counter), 1024);
-
-	val = wrapping_sub(u64, c->NpuhclkFreqEffAcc, p->NpuhclkFreqEffAcc);
-	avg_metric[METRICS_AVERAGE_NPUCLK] = div_u64(div64_u64(val, counter), 1024);
-
-	/* Activity (fixed-point /1024) */
-	val = wrapping_sub(u64, c->GfxBusyAcc, p->GfxBusyAcc);
-	avg_metric[METRICS_AVERAGE_GFXACTIVITY] = div_u64(div64_u64(val, counter), 1024);
-
-	val = wrapping_sub(u64, c->VcnBusyAcc, p->VcnBusyAcc);
-	avg_metric[METRICS_AVERAGE_VCNACTIVITY] = div_u64(div64_u64(val, counter), 1024);
-
-	/*
-	 * Power: accumulator holds a 1024x fixed-point value in Watts.
-	 * Average it into milliwatts, which is the unit expected by
-	 * power sensor consumers (hwmon/debugfs).
-	 */
-	val = wrapping_sub(u64, c->ApuPowerAcc, p->ApuPowerAcc);
-	mw = div_u64(div64_u64(val, counter) * 1000, 1024);
-	avg_metric[METRICS_AVERAGE_SOCKETPOWER] = mw;
-
-	val = wrapping_sub(u64, c->SystemPowerAcc, p->SystemPowerAcc);
-	mw = div_u64(div64_u64(val, counter) * 1000, 1024);
-	avg_metric[METRICS_CURR_SOCKETPOWER] = mw;
-
-	/*
-	 * Temperature: accumulator holds a 1024x fixed-point value in
-	 * Celsius. Descale by 1024 and convert to millidegrees C as the
-	 * hwmon/sysfs consumers expect (temp*_input is in millidegrees).
-	 */
-	val = wrapping_sub(u64, c->GFX_TempAcc, p->GFX_TempAcc);
+	/* Temperature: accumulator in Celsius -> millidegrees C (temp*_input). */
 	avg_metric[METRICS_TEMPERATURE_VRGFX] =
-		div_u64(div64_u64(val, counter) * SMU_TEMPERATURE_UNITS_PER_CENTIGRADES, 1024);
-
-	val = wrapping_sub(u64, c->STT_APU_HotSpotTempAcc, p->STT_APU_HotSpotTempAcc);
+		SMU_V15_IOD_AVG(GFX_TempAcc, SMU_TEMPERATURE_UNITS_PER_CENTIGRADES);
 	avg_metric[METRICS_TEMPERATURE_HOTSPOT] =
-		div_u64(div64_u64(val, counter) * SMU_TEMPERATURE_UNITS_PER_CENTIGRADES, 1024);
-
-	/* Voltage: accumulator holds a 1024x fixed-point value in Volts;
-	 * convert to millivolts for the hwmon/sysfs consumers.
-	 */
-	val = wrapping_sub(u64, c->VDDCR_GFX_TelemetryVoltage, p->VDDCR_GFX_TelemetryVoltage);
-	avg_metric[METRICS_VOLTAGE_VDDGFX] = div_u64(div64_u64(val, counter) * 1000, 1024);
+		SMU_V15_IOD_AVG(STT_APU_HotSpotTempAcc, SMU_TEMPERATURE_UNITS_PER_CENTIGRADES);
 
-	val = wrapping_sub(u64, c->VDDCR_SOC_TelemetryVoltage, p->VDDCR_SOC_TelemetryVoltage);
-	avg_metric[METRICS_VOLTAGE_VDDSOC] = div_u64(div64_u64(val, counter) * 1000, 1024);
+	/* Voltage: accumulator in Volts -> millivolts. */
+	avg_metric[METRICS_VOLTAGE_VDDGFX] = SMU_V15_IOD_AVG(VDDCR_GFX_TelemetryVoltage, 1000);
+	avg_metric[METRICS_VOLTAGE_VDDSOC] = SMU_V15_IOD_AVG(VDDCR_SOC_TelemetryVoltage, 1000);
 }
 
 static int smu_v15_0_0_get_smu_metrics_data(struct smu_context *smu,
@@ -714,61 +671,99 @@ static ssize_t smu_v15_0_0_get_gpu_metrics(struct smu_context *smu,
 	struct gpu_metrics_v3_0 *gpu_metrics =
 		(struct gpu_metrics_v3_0 *)smu_driver_table_ptr(
 			smu, SMU_DRIVER_TABLE_GPU_METRICS);
-	SmuMetrics_t metrics;
-	int ret = 0;
+	struct smu_table_context *smu_table = &smu->smu_table;
+	SMU_15_0_0_MetricsInfo_t *metrics_info =
+		(SMU_15_0_0_MetricsInfo_t *)smu_table->metrics_table;
+	uint32_t all_core_power = 0;
+	MetricsTable_IOD_t *p, *c;
+	MetricsTable_t *prev, *curr;
+	size_t i, ccx, core;
+	uint32_t coreclk;
+	uint64_t counter;
+	int ret;
 
-	ret = smu_v15_0_0_get_gpu_metrics_table(smu, &metrics, false);
-	if (ret)
+	/* Refresh the accumulator double-buffer (may reuse a cached sample). */
+	ret = smu_v15_0_0_get_metrics_table(smu, metrics_info);
+	if (ret < 0)
 		return ret;
 
+	curr = &metrics_info->metrics[metrics_info->active_idx];
+	prev = &metrics_info->metrics[!metrics_info->active_idx];
+	c = &curr->IOD;
+	p = &prev->IOD;
+
 	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 3, 0);
 
-	gpu_metrics->temperature_gfx = metrics.GfxTemperature;
-	gpu_metrics->temperature_soc = metrics.SocTemperature;
-	memcpy(&gpu_metrics->temperature_core[0],
-		&metrics.CoreTemperature[0],
-		sizeof(uint16_t) * 16);
-	gpu_metrics->temperature_skin = metrics.SkinTemp;
-
-	gpu_metrics->average_gfx_activity = metrics.GfxActivity;
-	gpu_metrics->average_vcn_activity = metrics.VcnActivity;
-
-	memcpy(&gpu_metrics->average_core_c0_activity[0],
-		&metrics.CoreC0Residency[0],
-		sizeof(uint16_t) * 16);
-	gpu_metrics->average_dram_reads = metrics.DRAMReads;
-	gpu_metrics->average_dram_writes = metrics.DRAMWrites;
-
-	gpu_metrics->average_socket_power = metrics.SocketPower;
-	gpu_metrics->average_apu_power = metrics.ApuPower;
-	gpu_metrics->average_gfx_power = metrics.GfxPower;
-	gpu_metrics->average_dgpu_power = metrics.dGpuPower;
-	gpu_metrics->average_all_core_power = metrics.AllCorePower;
-	gpu_metrics->average_sys_power = metrics.Psys;
-	memcpy(&gpu_metrics->average_core_power[0],
-		&metrics.CorePower[0],
-		sizeof(uint16_t) * 16);
-
-	gpu_metrics->average_gfxclk_frequency = metrics.GfxclkFrequency;
-	gpu_metrics->average_socclk_frequency = metrics.SocclkFrequency;
-	gpu_metrics->average_vpeclk_frequency = metrics.VpeclkFrequency;
-	gpu_metrics->average_fclk_frequency = metrics.FclkFrequency;
-	gpu_metrics->average_vclk_frequency = metrics.VclkFrequency;
-	gpu_metrics->average_uclk_frequency = metrics.MemclkFrequency;
-
-	memcpy(&gpu_metrics->current_coreclk[0],
-		&metrics.CoreFrequency[0],
-		sizeof(uint16_t) * 16);
-	gpu_metrics->current_core_maxfreq = metrics.InfrastructureCpuMaxFreq;
-	gpu_metrics->current_gfx_maxfreq = metrics.InfrastructureGfxMaxFreq;
-
-	gpu_metrics->throttle_residency_prochot = metrics.ThrottleResidency_PROCHOT;
-	gpu_metrics->throttle_residency_spl = metrics.ThrottleResidency_SPL;
-	gpu_metrics->throttle_residency_fppt = metrics.ThrottleResidency_FPPT;
-	gpu_metrics->throttle_residency_sppt = metrics.ThrottleResidency_SPPT;
-	gpu_metrics->throttle_residency_thm_soc = metrics.ThrottleResidency_THM_SOC;
-
-	gpu_metrics->time_filter_alphavalue = metrics.FilterAlphaValue;
+	counter = wrapping_sub(u32, c->AccumulationCounter, p->AccumulationCounter);
+	if (counter) {
+		/* Temperatures: accumulator in Celsius -> centi-C. */
+		gpu_metrics->temperature_gfx = SMU_V15_IOD_AVG(GFX_TempAcc, 100);
+		gpu_metrics->temperature_soc = SMU_V15_IOD_AVG(SOC_TempAcc, 100);
+		gpu_metrics->temperature_skin = SMU_V15_IOD_AVG(STT_APU_SkinTempAcc, 100);
+
+		/* Activity: accumulator already in %. */
+		gpu_metrics->average_gfx_activity = SMU_V15_IOD_AVG(GfxBusyAcc, 1);
+		gpu_metrics->average_vcn_activity = SMU_V15_IOD_AVG(VcnBusyAcc, 1);
+
+		/* Bandwidth: accumulator in GB/s -> MB/s. */
+		gpu_metrics->average_dram_reads = SMU_V15_IOD_AVG(DramReadBandwidth, 1000);
+		gpu_metrics->average_dram_writes = SMU_V15_IOD_AVG(DramWriteBandwidth, 1000);
+
+		/* Power: accumulator in W -> mW. */
+		gpu_metrics->average_apu_power = SMU_V15_IOD_AVG(ApuPowerAcc, 1000);
+		gpu_metrics->average_gfx_power = SMU_V15_IOD_AVG(VDDCR_GFX_TelemetryPower, 1000);
+		gpu_metrics->average_dgpu_power = SMU_V15_IOD_AVG(dGpuPowerAcc, 1000);
+		gpu_metrics->average_sys_power = SMU_V15_IOD_AVG(SystemPowerAcc, 1000);
+		/* No dedicated socket accumulator: APU + dGPU, matching PPT/STAPM. */
+		gpu_metrics->average_socket_power =
+			gpu_metrics->average_apu_power + gpu_metrics->average_dgpu_power;
+
+		/* Effective clocks: accumulator already in MHz. */
+		gpu_metrics->average_gfxclk_frequency = SMU_V15_IOD_AVG(GfxclkFreqEffAcc, 1);
+		gpu_metrics->average_socclk_frequency = SMU_V15_IOD_AVG(SocclkFreqEffAcc, 1);
+		gpu_metrics->average_vpeclk_frequency = SMU_V15_IOD_AVG(VpeclkFreqEffAcc, 1);
+		gpu_metrics->average_fclk_frequency = SMU_V15_IOD_AVG(FclkFreqEffAcc, 1);
+		gpu_metrics->average_vclk_frequency = SMU_V15_IOD_AVG(VclkFreqEffAcc, 1);
+		gpu_metrics->average_uclk_frequency = SMU_V15_IOD_AVG(MemclkFreqEffAcc, 1);
+
+		/* Per-core metrics: report only active cores (non-zero effective
+		 * clock), flattening CCX-major into the 16 gpu_metrics slots.
+		 */
+		i = 0;
+		for (ccx = 0; ccx < METRIC_CCX_MAX &&
+			      i < ARRAY_SIZE(gpu_metrics->current_coreclk); ccx++) {
+			for (core = 0; core < NUM_MAX_CORES &&
+				       i < ARRAY_SIZE(gpu_metrics->current_coreclk);
+			     core++) {
+				/* Effective clock gates whether the core is active. */
+				coreclk = SMU_V15_CCX_AVG(Core_FREQEFF, 1000);
+				if (!coreclk)
+					continue;
+
+				gpu_metrics->current_coreclk[i] = coreclk;
+				gpu_metrics->temperature_core[i] =
+					SMU_V15_CCX_AVG(Core_TEMP, 100);
+				gpu_metrics->average_core_c0_activity[i] =
+					SMU_V15_CCX_AVG(Core_C0, 1);
+				gpu_metrics->average_core_power[i] =
+					SMU_V15_CCX_AVG(Core_POWER, 1000);
+				all_core_power += gpu_metrics->average_core_power[i];
+				i++;
+			}
+		}
+		gpu_metrics->average_all_core_power = all_core_power;
+
+		/* Throttle residencies: accumulator in % (semantics differ from
+		 * the PM_TIMER cycle counters exposed by the legacy metrics path).
+		 */
+		gpu_metrics->throttle_residency_prochot =
+			SMU_V15_IOD_AVG(PROCHOT_ResidencyAcc, 1);
+		gpu_metrics->throttle_residency_spl = SMU_V15_IOD_AVG(SPL_ResidencyAcc, 1);
+		gpu_metrics->throttle_residency_fppt = SMU_V15_IOD_AVG(fPPT_ResidencyAcc, 1);
+		gpu_metrics->throttle_residency_sppt = SMU_V15_IOD_AVG(sPPT_ResidencyAcc, 1);
+		gpu_metrics->throttle_residency_thm_soc = SMU_V15_IOD_AVG(THM_ResidencyAcc, 1);
+	}
+
 	gpu_metrics->system_clock_counter = ktime_get_boottime_ns();
 
 	*table = (void *)gpu_metrics;
@@ -778,6 +773,9 @@ static ssize_t smu_v15_0_0_get_gpu_metrics(struct smu_context *smu,
 	return sizeof(struct gpu_metrics_v3_0);
 }
 
+#undef SMU_V15_IOD_AVG
+#undef SMU_V15_CCX_AVG
+
 static int smu_v15_0_0_mode2_reset(struct smu_context *smu)
 {
 	int ret;
-- 
2.43.0

