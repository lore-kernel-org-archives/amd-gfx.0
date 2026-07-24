Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B443AC531C9
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Jul 2026 12:03:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 42B6B10F389;
	Fri, 24 Jul 2026 12:03:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4vDp7Dx7";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010015.outbound.protection.outlook.com
 [52.101.193.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F2B8710F389
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Jul 2026 12:03:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qc5XT19Tni//7ZTGSYIDk1gqHpzS4NLRIKorh1SYibJ68hRbXi9wbRgdPSqC4DTtSkmVrHYlX+UgCYr3mVJCU/gPOX+6J4dnVBLQ3U1Ekt+CrwoOPtA1azdlx3j7vWJoLTrHzhipGkQ0CUlPSJHEBf348QK61lu9fn3+mC6vqIOQ7dUTJuOdsV/PVUrSwFUgiu8KEL8YRP/bVC5bXGtb/CosPVMt2xlmJ2g44V3x987Ow1Jt9SSwI9SnpaCzCDQB+IqRgxMmrc5oh0H/u2BnrQpuzpUwrN+cxnv57tj/3NnY3A23rB7Ozg15OadyIhVwSR7/yAl9G4yqf0I+v+21Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H6wZzoA+WxEEkNCAlQoicc063DFWu/flfAdfIb/wilQ=;
 b=GgNOvk2JcjKbNtcgpMEFGKdYRI1h6KIOMB5XAsYjUyUt+8OYreMntDigUDjLO4vwbMmqdtXbqfTfNl/vlG+1FB9Rai+FL/z1Aju6lpWMLSjHLLwkPw/KGhbzljssq8TVhtBaxbqQBRSiKGubNQnPoAwdexuJ/WrJjtKudoRvjQ8B23ELuOJM5y1hdGggek6+IOX7VUvkdG1hBXNxKIajqi2YjTun0v4lwxxljI/hQzT1QVFRSqk2mn7gJCNhWkn0FiJ+AfZmvMOr2poEzdHz4uRfK/CmqDK8ve5YqkuqfUpeLaMY7FVxZFdioXCAwoshhag1/gnyUvOru4dRUsrebQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H6wZzoA+WxEEkNCAlQoicc063DFWu/flfAdfIb/wilQ=;
 b=4vDp7Dx7pUcEnM+r56Y3DkF/GHZH8WBiN/1g41bRvLQs/dsLpOz2S78lxyPRRGkHRkwJDj3myJ7pg/15/arwdKKd88yM+nNzGE+nxPgK1WwQ4ygB/SeiVcYExeOdzxs4ohp1xYpNDg5ZHwIs3CQz2/Brn5dRLTZUwiFbkH+tnsU=
Received: from MN0P223CA0020.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:52b::11)
 by MW4PR12MB5604.namprd12.prod.outlook.com (2603:10b6:303:18d::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.12; Fri, 24 Jul
 2026 12:03:26 +0000
Received: from BL6PEPF0001AB4D.namprd04.prod.outlook.com
 (2603:10b6:208:52b:cafe::7e) by MN0P223CA0020.outlook.office365.com
 (2603:10b6:208:52b::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.11 via Frontend Transport; Fri,
 24 Jul 2026 12:03:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB4D.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Fri, 24 Jul 2026 12:03:25 +0000
Received: from shubhankar-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Fri, 24 Jul 2026 07:03:22 -0500
From: Shubhankar Milind Sardeshpande <Shubhankar.MilindSardeshpande@amd.com>
To: <Alexander.Deucher@amd.com>, <Lijo.Lazar@amd.com>,
 <Christian.Koenig@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: <Veerabadhran.Gopalakrishnan@amd.com>, Shubhankar Milind Sardeshpande
 <Shubhankar.MilindSardeshpande@amd.com>, Pratik Vishwakarma
 <Pratik.Vishwakarma@amd.com>, Suresh Guttula <Suresh.Guttula@amd.com>,
 "Kanala Ramalingeswara Reddy" <Kanala.RamalingeswaraReddy@amd.com>
Subject: [PATCH V3 2/3] drm/amd/pm/smu15: switch to DRAM-based accumulator
 metrics for SMU v15.0.0 using the newly added metrics table
Date: Fri, 24 Jul 2026 17:33:02 +0530
Message-ID: <20260724120306.3364384-1-Shubhankar.MilindSardeshpande@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4D:EE_|MW4PR12MB5604:EE_
X-MS-Office365-Filtering-Correlation-Id: 52b1ef59-01a5-4327-e956-08dee97b910d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|1800799024|376014|23010399003|56012099006|11063799006|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info: 4pG5PujD84FpethLezlu+30hGucR66C93pvc+t5tbD5imfg3U1Z3D/QSuE8ppWlQHqZHfILSiIcJEU6zZ6q+imin23IjKDXCtNXko0pKC2KMv4A5cFhHZndxM81dyyXKQJg3xwPID9eucdEd6pFZ0WNNPGoIkEn3xQ2zjHowpqKzMr8fe+7mvv5JDDKhRx+W2kljBAFxbPvRMqSAzNazirydbSWSNp5deVm4PHaW13AFj6oaHzXmTv21N4y7Y0bcLNCVQksENzjLWjpKyzoTmf2kCkOKOhqqEiqMhio/+ShKipBS6w4gDR6LrQamW6iFszSk5wGnrCTyW4LvuiFvlSJNhzE4jF1scilLPj+cZxQtEmFC2eLLVnKm8HoLm2UedPecXSAluIEfcQqaA9GdJUMJAFfPRJJOmAjJooCUrDpRstXIxLUwWnq2ejcou5LcZJtrLWFOrKZ3l7zFFXVR1x175sIrqzG/ndQdSGEOD5l3rPOSkMtJ0C8sPE2p4Few8tivF0lLNFlFgSiMqqsXywPmqPza6xGkg2/BZQXICa0lpMi1vKYfqUI+WcgMjZqhE1UInZ59hyGSE7nE2wOHg2zK1wkEQQo3mtRD2/qJqa3jKl0bKjzWVCtNapdWsgpzfdBNI1MjASMfzaH5v7V1Wk3kAqRdpUxlxsfnACLDJyKxtNMIjpb0xv5UIJR4KZ3e
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(1800799024)(376014)(23010399003)(56012099006)(11063799006)(10067099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Qq1c1aTztHjEp88bJJjmvZPgO8REx1QT3GCgbs97kFqyaCYS8nNldhSMtp2wMwy02BsxYACD6KR6c3x47LvH3xZqSzfbQhxNFOxNBaDR7NXrkboUetJr4T0GJUppBLjlGRok28qWbokBBTtmprNqR1AL7RVEKpZ/uMHf/MGl2//F7VtJykOSdS4LcdifpCs3FUWHFWYAMfRqHIntaiw66nClk025StTBe3K1FW5zL9qKFM26KQXlRVp9cVhdpUUREnWgM90ZyUThXYlnXKnqYtPylqiO/2UxK1Fy5Ub9PFE/s9eRZMMas3tE+5lAeCKMPkcHIoDtGz4KSi/KUQdzjYBdGlLOlYVUIWOgcHYe+9MlM0S1jsGc5bG0w0mpuRAb8kRg2T4uLHPQaWpPyHOAc9FTajtivlSy7REmgtEtF9frDob0DuKBmHQR/bWp9Cv4
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2026 12:03:25.6603 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 52b1ef59-01a5-4327-e956-08dee97b910d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5604
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

Replace the legacy SMU table-copy metrics path with a DRAM-mapped
accumulator-based approach for SMU v15.0.0:

- Add MSG_MAP entries for GetMetricsTableVersion,
  GetMetricsTableLogSample, and GetMetricsTableLogDramAddr messages.
- Introduce SMU_15_0_0_MetricsInfo_t wrapping MetricsTable_t with
  cached address, table size, and pre-computed average metrics.
- Add smu_v15_0_0_get_metrics_table() which obtains the DRAM address
  from the SMU, ioremaps it, and copies the metrics snapshot.
- Add smu_v15_0_0_compute_all_metrics() to derive averaged clocks,
  activity, power, and temperature from accumulator deltas between
  consecutive samples.
- Rework smu_v15_0_0_get_smu_metrics_data() to use the new
  accumulator-diff path, replacing the per-member switch statement
  with a single lookup into pre-computed avg_metric[].
- Rename the old smu_v15_0_0_get_metrics_table() to
  smu_v15_0_0_get_gpu_metrics_table(), preserving it for the
  gpu_metrics v3.0 export path.
- Use wrapping_sub() API to compute the difference between
  current and previous AccumulationCounter.

Signed-off-by: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
Signed-off-by: Suresh Guttula <Suresh.Guttula@amd.com>
Signed-off-by: Kanala Ramalingeswara Reddy <Kanala.RamalingeswaraReddy@amd.com>
Signed-off-by: Shubhankar Milind Sardeshpande <Shubhankar.MilindSardeshpande@amd.com>
---
 .../pm/swsmu/inc/pmfw_if/smu_v15_0_0_ppsmc.h  |   5 +-
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h  |   3 +
 .../drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c  | 249 +++++++++++-------
 .../drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.h  |  11 +
 4 files changed, 166 insertions(+), 102 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v15_0_0_ppsmc.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v15_0_0_ppsmc.h
index bf216f83e689..9f627b5fef5b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v15_0_0_ppsmc.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v15_0_0_ppsmc.h
@@ -100,7 +100,10 @@
 #define PPSMC_MSG_DisableLSdma                  0x1F ///< Disable LSDMA
 #define PPSMC_MSG_SetSoftMaxVpe                 0x20 ///<
 #define PPSMC_MSG_SetSoftMinVpe                 0x21 ///<
-#define PPSMC_Message_Count                     0x22 ///< Total number of PPSMC messages
+#define PPSMC_MSG_GetMetricsTableVersion        0x22
+#define PPSMC_MSG_GetMetricsTableLogSample      0x23
+#define PPSMC_MSG_GetMetricsTableLogDramAddr    0x24
+#define PPSMC_Message_Count                     0x25 ///< Total number of PPSMC messages
 /** @}*/
 
 /**
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
index acf03838d49d..d6675b4ee9be 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
@@ -297,6 +297,9 @@
 	__SMU_DUMMY_MAP(GetSmartShiftStatus), \
 	__SMU_DUMMY_MAP(EnableLSdma), \
 	__SMU_DUMMY_MAP(DisableLSdma), \
+	__SMU_DUMMY_MAP(GetMetricsTableVersion), \
+	__SMU_DUMMY_MAP(GetMetricsTableLogSample), \
+	__SMU_DUMMY_MAP(GetMetricsTableLogDramAddr), \
 	__SMU_DUMMY_MAP(InitializeGfx), \
 	__SMU_DUMMY_MAP(SetSoftMaxFclk), \
 	__SMU_DUMMY_MAP(SetSoftMaxGl2clk), \
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
index faa7d661f3bf..1d268a02992e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
@@ -33,6 +33,8 @@
 #include "smu_v15_0_0_pmfw.h"
 #include "smu_cmn.h"
 
+#include <linux/overflow.h>
+
 /*
  * DO NOT use these for err/warn/info/debug messages.
  * Use dev_err, dev_warn, dev_info and dev_dbg instead.
@@ -119,6 +121,9 @@ static struct cmn2asic_msg_mapping smu_v15_0_0_message_map[SMU_MSG_MAX_COUNT] =
 	MSG_MAP(DisableLSdma,                   PPSMC_MSG_DisableLSdma,				1),
 	MSG_MAP(SetSoftMaxVpe,                  PPSMC_MSG_SetSoftMaxVpe,			1),
 	MSG_MAP(SetSoftMinVpe,                  PPSMC_MSG_SetSoftMinVpe,			1),
+	MSG_MAP(GetMetricsTableVersion,         PPSMC_MSG_GetMetricsTableVersion,		1),
+	MSG_MAP(GetMetricsTableLogSample,       PPSMC_MSG_GetMetricsTableLogSample,		1),
+	MSG_MAP(GetMetricsTableLogDramAddr,     PPSMC_MSG_GetMetricsTableLogDramAddr,	1),
 };
 
 static struct cmn2asic_mapping smu_v15_0_0_feature_mask_map[SMU_FEATURE_COUNT] = {
@@ -173,7 +178,7 @@ static int smu_v15_0_0_init_smc_tables(struct smu_context *smu)
 	SMU_TABLE_INIT(tables, SMU_TABLE_SMU_METRICS, sizeof(SmuMetrics_t),
 		PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
 
-	smu_table->metrics_table = kzalloc_obj(SmuMetrics_t);
+	smu_table->metrics_table = kzalloc_obj(SMU_15_0_0_MetricsInfo_t);
 	if (!smu_table->metrics_table)
 		goto err0_out;
 	smu_table->metrics_time = 0;
@@ -299,7 +304,7 @@ static int smu_v15_0_0_set_default_dpm_tables(struct smu_context *smu)
 				    smu_table->clocks_table, false);
 }
 
-static int smu_v15_0_0_get_metrics_table(struct smu_context *smu,
+static int smu_v15_0_0_get_gpu_metrics_table(struct smu_context *smu,
 							void *metrics_table,
 							bool bypass_cache)
 {
@@ -329,115 +334,157 @@ static int smu_v15_0_0_get_metrics_table(struct smu_context *smu,
 	return 0;
 }
 
+
+static int smu_v15_0_0_get_metrics_table(struct smu_context *smu,
+					SMU_15_0_0_MetricsInfo_t *metrics_info)
+{
+	struct smu_table_context *smu_table = &smu->smu_table;
+	void __iomem *cpu_addr = NULL;
+	struct smu_msg_ctl *ctl = &smu->msg_ctl;
+	struct smu_msg_args args = {0};
+	int table_size = metrics_info->table_size;
+	uint64_t addr = metrics_info->addr;
+	int ret;
+
+	if (smu_table->metrics_time &&
+	    !time_after(jiffies, smu_table->metrics_time + msecs_to_jiffies(1)))
+		return 0;
+
+	if (addr == 0) {
+		struct smu_msg_args args = {
+			.msg = SMU_MSG_GetMetricsTableLogDramAddr,
+			.num_args = 0,
+			.num_out_args = 3,
+		};
+
+		ret = ctl->ops->send_msg(ctl, &args);
+
+		if (ret)
+			return ret;
+
+		addr = ((uint64_t)args.out_args[1] << 32) | args.out_args[0];
+		table_size = args.out_args[2];
+		metrics_info->addr = addr;
+		metrics_info->table_size = table_size;
+	}
+
+	cpu_addr = ioremap_wc(addr, table_size);
+	if (!cpu_addr)
+		return -ENOMEM;
+
+	args.msg = SMU_MSG_GetMetricsTableLogSample;
+	args.num_args = 0;
+	args.num_out_args = 0;
+
+	ret = ctl->ops->send_msg(ctl, &args);
+	if (!ret) {
+		amdgpu_hdp_invalidate(smu->adev, NULL);//best to flush before copy
+		if (table_size <= sizeof(MetricsTable_t))
+			memcpy(&metrics_info->metrics, cpu_addr, table_size);
+		else
+			memcpy(&metrics_info->metrics, cpu_addr, sizeof(MetricsTable_t));
+	}
+	iounmap(cpu_addr);
+	return ret;
+}
+
+/*
+ * Accumulators monotonically increase and roll over at their type width.
+ * Use the kernel wrapping_sub() API to compute the delta so the subtraction
+ * wraps modulo 2^n (correct across a single rollover) without tripping any
+ * wrap-around sanitizers.
+ */
+static void smu_v15_0_0_compute_all_metrics(
+		SMU_15_0_0_MetricsInfo_t *prev,
+		SMU_15_0_0_MetricsInfo_t *curr)
+{
+	uint64_t counter, val;
+	MetricsTable_IOD_t *p = &prev->metrics.IOD;
+	MetricsTable_IOD_t *c = &curr->metrics.IOD;
+
+	counter = wrapping_sub(u32, c->AccumulationCounter, p->AccumulationCounter);
+	if (!counter)
+		return;
+
+	/* Accumulator-based clock frequencies (fixed-point /1024) */
+	val = wrapping_sub(u64, c->GfxclkFreqEffAcc, p->GfxclkFreqEffAcc);
+	curr->avg_metric[METRICS_AVERAGE_GFXCLK] = (val / counter) / 1024;
+
+	val = wrapping_sub(u64, c->SocclkFreqEffAcc, p->SocclkFreqEffAcc);
+	curr->avg_metric[METRICS_AVERAGE_SOCCLK] = (val / counter) / 1024;
+
+	val = wrapping_sub(u64, c->VclkFreqEffAcc, p->VclkFreqEffAcc);
+	curr->avg_metric[METRICS_AVERAGE_VCLK] = (val / counter) / 1024;
+
+	curr->avg_metric[METRICS_AVERAGE_DCLK] = 0;
+
+	val = wrapping_sub(u64, c->MemclkFreqEffAcc, p->MemclkFreqEffAcc);
+	curr->avg_metric[METRICS_AVERAGE_UCLK] = (val / counter) / 1024;
+
+	val = wrapping_sub(u64, c->FclkFreqEffAcc, p->FclkFreqEffAcc);
+	curr->avg_metric[METRICS_AVERAGE_FCLK] = (val / counter) / 1024;
+
+	val = wrapping_sub(u64, c->NpuhclkFreqEffAcc, p->NpuhclkFreqEffAcc);
+	curr->avg_metric[METRICS_AVERAGE_NPUCLK] = (val / counter) / 1024;
+
+	/* Activity (fixed-point /1024) */
+	val = wrapping_sub(u64, c->GfxBusyAcc, p->GfxBusyAcc);
+	curr->avg_metric[METRICS_AVERAGE_GFXACTIVITY] = (val / counter) / 1024;
+
+	val = wrapping_sub(u64, c->VcnBusyAcc, p->VcnBusyAcc);
+	curr->avg_metric[METRICS_AVERAGE_VCNACTIVITY] = (val / counter) / 1024;
+
+	/* Power (fixed-point /1024) */
+	val = wrapping_sub(u64, c->ApuPowerAcc, p->ApuPowerAcc);
+	curr->avg_metric[METRICS_AVERAGE_SOCKETPOWER] = (val / counter) / 1024;
+
+	val = wrapping_sub(u64, c->SystemPowerAcc, p->SystemPowerAcc);
+	curr->avg_metric[METRICS_CURR_SOCKETPOWER] = (val / counter) / 1024;
+
+	/* Temperature */
+	val = wrapping_sub(u64, c->GFX_TempAcc, p->GFX_TempAcc);
+	curr->avg_metric[METRICS_TEMPERATURE_EDGE] = val / counter;
+
+	/* Static zero values */
+	curr->avg_metric[METRICS_VOLTAGE_VDDGFX] = 0;
+	curr->avg_metric[METRICS_VOLTAGE_VDDSOC] = 0;
+}
+
 static int smu_v15_0_0_get_smu_metrics_data(struct smu_context *smu,
 					    MetricsMember_t member,
 					    uint32_t *value)
 {
 	struct smu_table_context *smu_table = &smu->smu_table;
 
-	SmuMetrics_t *metrics = (SmuMetrics_t *)smu_table->metrics_table;
-	int ret = 0;
+	SMU_15_0_0_MetricsInfo_t *prev_metrics;
+	SMU_15_0_0_MetricsInfo_t *curr_metrics;
+	int ret;
 
-	ret = smu_v15_0_0_get_metrics_table(smu, NULL, false);
-	if (ret)
+	prev_metrics = kzalloc_obj(SMU_15_0_0_MetricsInfo_t);
+	if (!prev_metrics)
+		return -ENOMEM;
+
+	memcpy(prev_metrics, smu_table->metrics_table,
+			sizeof(SMU_15_0_0_MetricsInfo_t));
+	ret = smu_v15_0_0_get_metrics_table(smu,
+			(SMU_15_0_0_MetricsInfo_t *)smu_table->metrics_table);
+	if (ret) {
+		kfree(prev_metrics);
 		return ret;
+	}
 
-	switch (member) {
-	case METRICS_AVERAGE_GFXCLK:
-		*value = metrics->GfxclkFrequency;
-		break;
-	case METRICS_AVERAGE_SOCCLK:
-		*value = metrics->SocclkFrequency;
-		break;
-	case METRICS_AVERAGE_VCLK:
-		*value = metrics->VclkFrequency;
-		break;
-	case METRICS_AVERAGE_DCLK:
-		*value = 0;
-		break;
-	case METRICS_AVERAGE_UCLK:
-		*value = metrics->MemclkFrequency;
-		break;
-	case METRICS_AVERAGE_FCLK:
-		*value = metrics->FclkFrequency;
-		break;
-	case METRICS_AVERAGE_VPECLK:
-		*value = metrics->VpeclkFrequency;
-		break;
-	case METRICS_AVERAGE_NPUCLK:
-		*value = metrics->NpuclkFrequency;
-		break;
-	case METRICS_AVERAGE_GFXACTIVITY:
-		if ((smu->smc_fw_version > 0x5d4600))
-			*value = metrics->GfxActivity;
-		else
-			*value = metrics->GfxActivity / 100;
-		break;
-	case METRICS_AVERAGE_VCNACTIVITY:
-		*value = metrics->VcnActivity / 100;
-		break;
-	case METRICS_AVERAGE_SOCKETPOWER:
-	case METRICS_CURR_SOCKETPOWER:
-		*value = (metrics->SocketPower / 1000 << 8) +
-		(metrics->SocketPower % 1000 / 10);
-		break;
-	case METRICS_TEMPERATURE_EDGE:
-		*value = metrics->GfxTemperature / 100 *
-		SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
-		break;
-	case METRICS_TEMPERATURE_HOTSPOT:
-		*value = metrics->SocTemperature / 100 *
-		SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
-		break;
-	case METRICS_THROTTLER_RESIDENCY_PROCHOT:
-		*value = metrics->ThrottleResidency_PROCHOT;
-		break;
-	case METRICS_THROTTLER_RESIDENCY_SPL:
-		*value = metrics->ThrottleResidency_SPL;
-		break;
-	case METRICS_THROTTLER_RESIDENCY_FPPT:
-		*value = metrics->ThrottleResidency_FPPT;
-		break;
-	case METRICS_THROTTLER_RESIDENCY_SPPT:
-		*value = metrics->ThrottleResidency_SPPT;
-		break;
-	case METRICS_THROTTLER_RESIDENCY_THM_SOC:
-		*value = metrics->ThrottleResidency_THM_SOC;
-		break;
-	case METRICS_VOLTAGE_VDDGFX:
-		*value = 0;
-		break;
-	case METRICS_VOLTAGE_VDDSOC:
-		*value = 0;
-		break;
-	case METRICS_SS_APU_SHARE:
-		/* return the percentage of APU power with respect to APU's power limit.
-		 * percentage is reported, this isn't boost value. Smartshift power
-		 * boost/shift is only when the percentage is more than 100.
-		 */
-		if (metrics->StapmOpnLimit > 0)
-			*value = (metrics->ApuPower * 100) / metrics->StapmOpnLimit;
-		else
-			*value = 0;
-		break;
-	case METRICS_SS_DGPU_SHARE:
-		/* return the percentage of dGPU power with respect to dGPU's power limit.
-		 * percentage is reported, this isn't boost value. Smartshift power
-		 * boost/shift is only when the percentage is more than 100.
-		 */
-		if ((metrics->dGpuPower > 0) &&
-		    (metrics->StapmCurrentLimit > metrics->StapmOpnLimit))
-			*value = (metrics->dGpuPower * 100) /
-				 (metrics->StapmCurrentLimit - metrics->StapmOpnLimit);
-		else
-			*value = 0;
-		break;
-	default:
-		*value = UINT_MAX;
-		break;
+	curr_metrics = (SMU_15_0_0_MetricsInfo_t *)smu_table->metrics_table;
+
+	if (prev_metrics->metrics.IOD.AccumulationCounter !=
+		curr_metrics->metrics.IOD.AccumulationCounter) {
+		/* New sample: compute all accumulator-based metrics at once */
+		smu_v15_0_0_compute_all_metrics(prev_metrics, curr_metrics);
 	}
 
-	return ret;
+	*value = curr_metrics->avg_metric[member];
+
+	kfree(prev_metrics);
+	return 0;
 }
 
 static int smu_v15_0_0_read_sensor(struct smu_context *smu,
@@ -634,7 +681,7 @@ static ssize_t smu_v15_0_0_get_gpu_metrics(struct smu_context *smu,
 	SmuMetrics_t metrics;
 	int ret = 0;
 
-	ret = smu_v15_0_0_get_metrics_table(smu, &metrics, false);
+	ret = smu_v15_0_0_get_gpu_metrics_table(smu, &metrics, false);
 	if (ret)
 		return ret;
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.h b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.h
index 8365b9fea77e..8ee45591e9a6 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.h
@@ -23,6 +23,17 @@
 #ifndef __SMU_V15_0_0_PPT_H__
 #define __SMU_V15_0_0_PPT_H__
 
+#include "amdgpu_smu.h"
+
+#include "pmfw_if/smu_v15_0_0_metrics.h"
+
+typedef struct {
+	MetricsTable_t metrics;
+	uint32_t table_size;
+	uint64_t addr;
+	uint32_t avg_metric[METRICS_AVERAGE_NPUCLK+1];
+} SMU_15_0_0_MetricsInfo_t;
+
 extern void smu_v15_0_0_set_ppt_funcs(struct smu_context *smu);
 
 #endif
\ No newline at end of file
-- 
2.43.0

