Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59FC2F45A0C
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Apr 2026 19:47:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB7C810E9CE;
	Fri, 10 Apr 2026 19:47:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="A+5q2l8y";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010044.outbound.protection.outlook.com [52.101.46.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 88EDD10E9CE
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Apr 2026 19:47:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FZrQiMBUzM2ZIoGa8aUXAFJ21YysWSvhqgTaSEFeUwSjmw3zRF0oqXy8Su5RvdkUbg9Crn72VUAPse0zCUKnCknB22qigSTUflhVBiCY8GQi9cWBrgCQUc2zCSVGhbnEHwC85yHk6KwzN10zZz4wXMAUseTXoToAd61t1f/G/t8J7DgaJjULCUWnkkdLlb/a43fNk1ndXwjveSDGQ64hz9wtUWLgTEYO0xqSoO1tOjdyd/VZNEYwwHz4NufR51kjUEc5LVGRfYmKy2h4j1odjcKBdDkxGq8Kj35kvsb2Q+P5p6tn17CjkMzmrwvIo87G/1kfX7omH2G37sbO5CLKuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mtK45gtkiG8Ic0hXaPwbN3ZyuQBz6AuN9jyua0C7lkA=;
 b=GdljgUmV6eHC/CuCe0oyDyAurFGm5Ao4tr+k8Co4WMqvUx9VaPWtQIZGZqjDlmsUxsadRaYt4OoTAHMP5rcVZpKMDIgoccZYy1TWhy9mzByzsdx0bgH/G+YZGKYyvLePV+VPeD9kKH9gzpFaE6sf/AHtm7nVJlRJIBaUhywmmQyKxZzfSn8IUXTWhJaeeHMowS8EooVB+koGTr8lNn7A0zocgImTGl9zJhlmY4kidCq88N0X9VY1F77O/Vz7rLhaQVGFVhVLWIBzlbGm8Gx3YOUw9GWfHb4Hg9dlU6wWWBA1V5kkhbi3zAA8YaUUGwpe272jF3ZFhOSbAsaSh8qn9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mtK45gtkiG8Ic0hXaPwbN3ZyuQBz6AuN9jyua0C7lkA=;
 b=A+5q2l8yKmDM48hZjhg+0rms8Wqd+Yia6iTDs6heSvpTjeUKPU+kNQnrT1mldtMwGNqGcn/1/3HL+crSsZ2JP5ux0sq/uUH2EtcMDhFxo6d4Mhj0frpJiMvakw15qpKk+92Y0Y0YNc3I+gb+6co2dU2SqrL3yxvt01Aw9ZrdDDQ=
Received: from SA9PR13CA0056.namprd13.prod.outlook.com (2603:10b6:806:22::31)
 by CH3PR12MB8186.namprd12.prod.outlook.com (2603:10b6:610:129::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.21; Fri, 10 Apr
 2026 19:47:01 +0000
Received: from SN1PEPF0002529E.namprd05.prod.outlook.com
 (2603:10b6:806:22:cafe::85) by SA9PR13CA0056.outlook.office365.com
 (2603:10b6:806:22::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.41 via Frontend Transport; Fri,
 10 Apr 2026 19:47:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002529E.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Fri, 10 Apr 2026 19:47:00 +0000
Received: from ram-Splinter.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 10 Apr
 2026 14:46:57 -0500
From: "Ramalingeswara Reddy, Kanala" <Kanala.RamalingeswaraReddy@amd.com>
To: <Alexander.Deucher@amd.com>, <amd-gfx@lists.freedesktop.org>,
 <Pratik.Vishwakarma@amd.com>, <Suresh.Guttula@amd.com>
CC: "Ramalingeswara Reddy, Kanala" <Kanala.RamalingeswaraReddy@amd.com>
Subject: [PATCH 2/3] drm/amdgpu: [Medusa]- Fix Unified metrics average
 calculation
Date: Sat, 11 Apr 2026 01:16:31 +0530
Message-ID: <20260410194632.1461984-2-Kanala.RamalingeswaraReddy@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260410194632.1461984-1-Kanala.RamalingeswaraReddy@amd.com>
References: <20260410194632.1461984-1-Kanala.RamalingeswaraReddy@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529E:EE_|CH3PR12MB8186:EE_
X-MS-Office365-Filtering-Correlation-Id: dd9ef19b-3b0c-423d-8c4c-08de9739ee5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: Da4ExfbIv/scjw6f8u5DKd2KLYuon017K/sRbLVp92DgUeCCaInC4E5b+XL6wJ7oO46uNNbYwUKNV8RajAEVyOd2qclVF9FWhkyDI/l8BPUTwd78K5wxzf8ulffqpqWHIqq3HQKJABZbuaPFajFiq4G5Yi8UDZ1ys6d++PoXCh9ky7WWqMxOrNWtF6HHvxGCrv2aJA4zEnFWkarY58LV40UidM50v++sVzqBsrzky8u9kXuAyrfp4bIKML0L9FTrTpLXJywu4ir+2tk7EN0wU3VDN3YeDlNkT0NtobUgTdLEBynFSd6YbiiYzwI6WwePqU4Ph7/At0knll0QSh0JjDCKQJZc0fMc3GEN7JjHhh1G/VWc2W0y84pjeLP9bDRnOmffC7SBt00CIQSM92DjCnHe7m7SlbUkn5U0zkSZyt1h3zI/6cqsTbPN77UKvZrbZ3qSR4szfJdw6xTlRm3zZRnnUiwTEJ60rcY9TNs6ZdVFvxXan3vUQg3aKYAEHf+iyq/57C+ffsRB8RfWywHu8gj3admkV+18UYvxpgehazCrv9ESnV3caEkN1E+pWqEWChl0HWFDOCeP2G4MQN8iZKUzghjSiBPUO9orfdBWexFpQo1lY4AoimBoA99w9pK1Oaj5Z+w6/lgZr81fjr9klION9nmpRzZy6I6I9iz/38qBuR5SDed0A8JhxF1v7+bAcU1rITltmZAZr6+OrLquiWhT7lY+zmB5DOI5g8UxHGgmDiQVZ31u8vU+Lg1HUqRpn31y5QmhP3ZZYkx9CRrRUw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: QqkWw3aL7AjgzDvk91jFwTMTyNjly5/rZr62SxF5jplDMf7FVK+n99mWIZ1vxJNrrBwu0p/B4vCHpVHx3MfqrewOXBGONOq717gnyq2syGTRUDe4qYnkKBnuKSww7kWgBAEeuoK3jpgB9fq1MY1/iXqEyNn8XjY6D9+nx6hIDnliq3jj9wIB7Sss9G2Ws3s7ENIxtkOG6XxMdbYZktaDWQwSOuAPt8Abfqk7NERigU2pbazJXdHyYjQttWV1MkdbJokfTna3X35qAUJKZGiacdbmcc3iekVpnVCNArAsFa1zFTmUSNoQaLeR49CXCtd1fUohi57aDaVECoj0Qx+TWePF7DjBds/wpSsP5KD2ko74Wj06Vi/BFts4YzOt8kfQESsuhyStka75SqBziJ/xFD0/t3c3PrlTqOlhByEquRUC/hkVDKh0xRH6Ja7HY3uS
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2026 19:47:00.0543 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dd9ef19b-3b0c-423d-8c4c-08de9739ee5c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002529E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8186
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

SWDEV-577922:[Medusa]-SMU Metrics:New Unified metrics table support
With new design SMU is sending accummulated metric values,
and stop sending us average metrics, so needs to average metrics once read.

Signed-off-by: sguttula <Suresh.Guttula@amd.com>
Signed-off-by: Ramalingeswara Reddy, Kanala <Kanala.RamalingeswaraReddy@amd.com>
---
 .../drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c  | 76 ++++++++++++-------
 .../drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.h  |  3 +-
 2 files changed, 52 insertions(+), 27 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
index a280506f43fa..a6a7df683b7e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
@@ -355,7 +355,7 @@ static int smu_v15_0_0_get_metrics_table(struct smu_context *smu,
 	addr = ((uint64_t)args.out_args[1] << 32) | args.out_args[0];
 	table_size = args.out_args[2];
 
-	cpu_addr = ioremap_wc(addr, metrics->table_size);
+	cpu_addr = ioremap_wc(addr, table_size);
 
 	args.msg = SMU_MSG_GetMetricsTableLogSample;
 	args.num_args = 0;
@@ -371,6 +371,10 @@ static int smu_v15_0_0_get_metrics_table(struct smu_context *smu,
 
 #define get_diff(a, b) \
 	(a > b ? ((0xFFFFFFFF - a) + b + 1) : (b - a))
+#define get_diff_count(a, b) \
+	(a > b ? ((MAX_UINT32  - a) + b + 1) : (b - a))
+#define get_diff_val(a, b) \
+	(a > b ? ((MAX_UINT64  - a) + b + 1) : (b - a))
 
 static int smu_v15_0_0_get_smu_metrics_data(struct smu_context *smu,
 					    MetricsMember_t member,
@@ -380,7 +384,8 @@ static int smu_v15_0_0_get_smu_metrics_data(struct smu_context *smu,
 	SmuMetrics_t *metrics = (SmuMetrics_t *)smu_table->metrics_table; //TBD
 
 	SMU_15_0_0_MetricsTable_t prev_metrics;
-	int ret, counter, val;
+	uint64_t counter, val;
+	int ret;
 
 	memcpy(&prev_metrics, smu_table->metrics_table,
 			sizeof(SMU_15_0_0_MetricsTable_t));
@@ -391,67 +396,86 @@ static int smu_v15_0_0_get_smu_metrics_data(struct smu_context *smu,
 
 	switch (member) {
 	case METRICS_AVERAGE_GFXCLK:
-		counter = get_diff(prev_metrics.IOD.AccumulationCounter,
+		counter = get_diff_count(prev_metrics.IOD.AccumulationCounter,
 		 ((SMU_15_0_0_MetricsTable_t *)smu_table->metrics_table)->IOD.AccumulationCounter);
-		val = get_diff(prev_metrics.IOD.GfxclkFreqEffAcc,
+		val = get_diff_val(prev_metrics.IOD.GfxclkFreqEffAcc,
 		 ((SMU_15_0_0_MetricsTable_t *)smu_table->metrics_table)->IOD.GfxclkFreqEffAcc);
-		*value = counter ? (val/counter)*1024 : 0;
+		*value = counter ? (val/counter)/1024 : 0;
 		break;
 	case METRICS_AVERAGE_SOCCLK:
-		counter = get_diff(prev_metrics.IOD.AccumulationCounter,
+		counter = get_diff_count(prev_metrics.IOD.AccumulationCounter,
 		 ((SMU_15_0_0_MetricsTable_t *)smu_table->metrics_table)->IOD.AccumulationCounter);
-		val = get_diff(prev_metrics.IOD.SocclkFreqEffAcc,
+		val = get_diff_val(prev_metrics.IOD.SocclkFreqEffAcc,
 		 ((SMU_15_0_0_MetricsTable_t *)smu_table->metrics_table)->IOD.SocclkFreqEffAcc);
-		*value = counter ? (val/counter)*1024 : 0;
+		*value = counter ? (val/counter)/1024 : 0;
 		break;
 	case METRICS_AVERAGE_VCLK:
-		*value = 0;//metrics->VclkFrequency;
+		counter = get_diff_count(prev_metrics.IOD.AccumulationCounter,
+		 ((SMU_15_0_0_MetricsTable_t *)smu_table->metrics_table)->IOD.AccumulationCounter);
+		val = get_diff_val(prev_metrics.IOD.VclkFreqEffAcc,
+		 ((SMU_15_0_0_MetricsTable_t *)smu_table->metrics_table)->IOD.VclkFreqEffAcc);
+		*value = counter ? (val/counter)/1024 : 0;
 		break;
 	case METRICS_AVERAGE_DCLK:
 		*value = 0;
 		break;
 	case METRICS_AVERAGE_UCLK:
-		counter = get_diff(prev_metrics.IOD.AccumulationCounter,
+		counter = get_diff_count(prev_metrics.IOD.AccumulationCounter,
 		 ((SMU_15_0_0_MetricsTable_t *)smu_table->metrics_table)->IOD.AccumulationCounter);
-		val = get_diff(prev_metrics.IOD.MemclkFreqEffAcc,
+		val = get_diff_val(prev_metrics.IOD.MemclkFreqEffAcc,
 		 ((SMU_15_0_0_MetricsTable_t *)smu_table->metrics_table)->IOD.MemclkFreqEffAcc);
-		*value = counter ? (val/counter)*1024 : 0;
+		*value = counter ? (val/counter)/1024 : 0;
 		break;
 	case METRICS_AVERAGE_FCLK:
-		*value = metrics->FclkFrequency;
+		counter = get_diff_count(prev_metrics.IOD.AccumulationCounter,
+		 ((SMU_15_0_0_MetricsTable_t *)smu_table->metrics_table)->IOD.AccumulationCounter);
+		val = get_diff_val(prev_metrics.IOD.FclkFreqEffAcc,
+		 ((SMU_15_0_0_MetricsTable_t *)smu_table->metrics_table)->IOD.FclkFreqEffAcc);
+		*value = counter ? (val/counter)/1024 : 0;
 		break;
 	case METRICS_AVERAGE_VPECLK:
 		*value = metrics->VpeclkFrequency;
 		break;
 	case METRICS_AVERAGE_NPUCLK:
-		*value = metrics->NpuclkFrequency;
+		counter = get_diff_count(prev_metrics.IOD.AccumulationCounter,
+		 ((SMU_15_0_0_MetricsTable_t *)smu_table->metrics_table)->IOD.AccumulationCounter);
+		val = get_diff_val(prev_metrics.IOD.NpuhclkFreqEffAcc,
+		 ((SMU_15_0_0_MetricsTable_t *)smu_table->metrics_table)->IOD.NpuhclkFreqEffAcc);
+		*value = counter ? (val/counter)/1024 : 0;
 		break;
 	case METRICS_AVERAGE_GFXACTIVITY:
-		counter = get_diff(prev_metrics.IOD.AccumulationCounter,
+		counter = get_diff_count(prev_metrics.IOD.AccumulationCounter,
 		 ((SMU_15_0_0_MetricsTable_t *)smu_table->metrics_table)->IOD.AccumulationCounter);
-		val = get_diff(prev_metrics.IOD.GfxBusyAcc,
+		val = get_diff_val(prev_metrics.IOD.GfxBusyAcc,
 		 ((SMU_15_0_0_MetricsTable_t *)smu_table->metrics_table)->IOD.GfxBusyAcc);
-		*value = counter ? (val/counter)*1024 : 0;
+		*value = counter ? (val/counter)/1024 : 0;
 		break;
 	case METRICS_AVERAGE_VCNACTIVITY:
-		*value = metrics->VcnActivity / 100;
+		counter = get_diff_count(prev_metrics.IOD.AccumulationCounter,
+		 ((SMU_15_0_0_MetricsTable_t *)smu_table->metrics_table)->IOD.AccumulationCounter);
+		val = get_diff_val(prev_metrics.IOD.VcnBusyAcc,
+		 ((SMU_15_0_0_MetricsTable_t *)smu_table->metrics_table)->IOD.VcnBusyAcc);
+		*value = counter ? (val/counter)/1024 : 0;
 		break;
 	case METRICS_AVERAGE_SOCKETPOWER:
-		counter = get_diff(prev_metrics.IOD.AccumulationCounter,
+		counter = get_diff_count(prev_metrics.IOD.AccumulationCounter,
 		 ((SMU_15_0_0_MetricsTable_t *)smu_table->metrics_table)->IOD.AccumulationCounter);
-		val = get_diff(prev_metrics.IOD.ApuPowerAcc,
+		val = get_diff_val(prev_metrics.IOD.ApuPowerAcc,
 		 ((SMU_15_0_0_MetricsTable_t *)smu_table->metrics_table)->IOD.ApuPowerAcc);
-		*value = counter ? (val/counter)*1024 : 0;
+		*value = counter ? (val/counter)/1024 : 0;
 	case METRICS_CURR_SOCKETPOWER:
-		counter = get_diff(prev_metrics.IOD.AccumulationCounter,
+		counter = get_diff_count(prev_metrics.IOD.AccumulationCounter,
 		 ((SMU_15_0_0_MetricsTable_t *)smu_table->metrics_table)->IOD.AccumulationCounter);
-		val = get_diff(prev_metrics.IOD.SystemPowerAcc,
+		val = get_diff_val(prev_metrics.IOD.SystemPowerAcc,
 		 ((SMU_15_0_0_MetricsTable_t *)smu_table->metrics_table)->IOD.SystemPowerAcc);
-		*value = counter ? (val/counter)*1024 : 0;
+		*value = counter ? (val/counter)/1024 : 0;
 		break;
 	case METRICS_TEMPERATURE_EDGE:
-		*value = metrics->GfxTemperature / 100 *
-		SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
+		counter = get_diff_count(prev_metrics.IOD.AccumulationCounter,
+		 ((SMU_15_0_0_MetricsTable_t *)smu_table->metrics_table)->IOD.AccumulationCounter);
+		val = get_diff_val(prev_metrics.IOD.GFX_TempAcc,
+		 ((SMU_15_0_0_MetricsTable_t *)smu_table->metrics_table)->IOD.GFX_TempAcc);
+		*value = counter ? (val/counter)/1024 : 0;
 		break;
 	case METRICS_TEMPERATURE_HOTSPOT:
 		*value = metrics->SocTemperature / 100 *
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.h b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.h
index b3dc6ccdddaf..592bb0f8ee96 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.h
@@ -23,6 +23,8 @@
 #ifndef __SMU_V15_0_0_PPT_H__
 #define __SMU_V15_0_0_PPT_H__
 
+#define MAX_UINT32 0x00000000FFFFFFFF
+#define MAX_UINT64 0xFFFFFFFFFFFFFFFF
 #pragma pack(push, 1)
 
 typedef struct {
@@ -213,7 +215,6 @@ typedef struct {
 } MetricsTable_CCX_t;
 
 typedef struct {
-	uint32_t table_size;
 	MetricsTable_IOD_t IOD;
 	MetricsTable_CCX_t CCX[4];
 } SMU_15_0_0_MetricsTable_t;
-- 
2.53.0

