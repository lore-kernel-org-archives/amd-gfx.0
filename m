Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9EF8CD4F26
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Jun 2026 13:32:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1206D10F5E4;
	Fri, 19 Jun 2026 13:32:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="00SjaKxm";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013005.outbound.protection.outlook.com
 [40.93.196.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 26FC910F5E2
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Jun 2026 13:32:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LTcyVKvAC7o1aWb1EGADVRWHTMkXWX2soeqpkXrkAQ1xriXTKj2tt+Q72hTltLaXQCiXSwjigESftXAQt/KaHH5ksT4Y7G4ut788B6lDH87HLcdoEGCFi+wge16cTFTWWGVJDguIH5S7P50ZnsK+0cyWuihl02y1la3Siz1b9atIgQX011pINgO4nC5geCFZiovu8HicBPrddNixRlas06ysj1OreFYzRNrfeUgRwXmpK1XbQ4+hgbjwvUy1zAb5vPA6zuXcyzqy5wZUW6nxjA4RWTGpayjT380HAq909Tk0i+l21aKiGPE99N5OnV24GtKQJ/7m6qJ63riA5iZsMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VZP6hwc28STm4ATRPHrylbc/it4dG79lP+gnYAXAhgs=;
 b=sA6eR1UApVqg/WYqOzevBWv39/ALO0IfJNr8w5HHA6dmk+e/Ob4QyPLMFHNRpPUaWyftROOUfKaGTUjBphJCp9KG6lwc48nsRwFvU1JOgAsBtbsH0fKjiWixt+0L3wE8cEAM7ynxLy57u9QXDQyNmsJ25LQSi32X9lshNfug9pUiFz4N5x2g3ytDhl5jBKzq5cnJeNQm9EJr5GbLMdyqxZ0ApNnuaWlGFARh70fER8y8DP2mIiwpyofTVb2f0UWh5W8evvQSLmyePXhOCSbgYWgN8+yHfiidKRbAYBp0s+Nbukz7YS/Punl8Vfav849toK7CrSAEfLgEukW1rA4lkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VZP6hwc28STm4ATRPHrylbc/it4dG79lP+gnYAXAhgs=;
 b=00SjaKxmA+VPGYgWhhn5wg7inXXhkhmqUIqieuDkCsH+JE1bokFaT7cFgjFLw3e7jZ/Tr82Z2Nk+BPldP45mPMum6Q5qVBQgpHImv2h+yaecKJzDCkD8dmcy4UWTHoNv/dsZ2HWcG5eGsCaPmWU6vYws21pmA1LAGX35a81Eg40=
Received: from BN0PR03CA0011.namprd03.prod.outlook.com (2603:10b6:408:e6::16)
 by IA1PR12MB7711.namprd12.prod.outlook.com (2603:10b6:208:421::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.12; Fri, 19 Jun
 2026 13:32:29 +0000
Received: from BN2PEPF00004FBB.namprd04.prod.outlook.com
 (2603:10b6:408:e6:cafe::79) by BN0PR03CA0011.outlook.office365.com
 (2603:10b6:408:e6::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.13 via Frontend Transport; Fri,
 19 Jun 2026 13:32:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF00004FBB.mail.protection.outlook.com (10.167.243.181) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Fri, 19 Jun 2026 13:32:29 +0000
Received: from georzhanmkm (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 19 Jun
 2026 08:32:28 -0500
From: George Zhang <george.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Austin Zheng <Austin.Zheng@amd.com>, Jun Lei
 <jun.lei@amd.com>, George Zhang <george.zhang@amd.com>
Subject: [PATCH 13/24] drm/amd/display: Allow Per-DPM De-rates Instead Of A
 Single Global Value
Date: Fri, 19 Jun 2026 09:21:28 -0400
Message-ID: <20260619133154.116746-14-george.zhang@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260619133154.116746-1-george.zhang@amd.com>
References: <20260619133154.116746-1-george.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBB:EE_|IA1PR12MB7711:EE_
X-MS-Office365-Filtering-Correlation-Id: d9166e5c-d2db-4273-110e-08dece073583
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|376014|23010399003|56012099006|3023799007|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 4SRThWJviUIGNt/3HgEQ6pLIS4e94/wJqccOXVQ5xqYMzbsEOmNtzlZZhZ4ifsAuDpnQ3jKnVM0+bSWPIVBE5k+fgSQLS9Nc9MxKhaGFOcgAzC6GpLfXhfPezbVvYfXi2EsaXnXjqUoKlr0SL8jfnPtwubTPuKvsFhFKHPjgsy3jqP1UwLoqSLwS/meGXccOHyXbzHY3oDE5kVy0v+xnl3atKyki1Gug2a4KVdPsb9tXSDFwnYg2D5UfoMu/bX4DSzaYME7UtEPHH9uliu4586NmB2raww6tjxrb9MYnpYnUIamZWuUxb5xIcXQln+HSlV9h5Y/H8kXGGJHAkp61Gd8muUC0x6YS53zSQhzVe+2bfr6vSrhnh+LddWUgGLdjkUcifZhov6Iop4E9mTzeN13KJBSPWt5QiR5hmxxgE5mIJwDro7ob382yJM7BlJhOAx4GcfKwdPx1JyPV/NHpiLdWKCoVfXR2pbTTbHXvWGCYzj7nLq7mEVPuPYWi0o5DF5y4XSB8lF9w2aYWCrzIHK0WZ59Zc0iCUoPV5HA4F5+ZEw5GkQEV5+bZUPfkxZfPKyr04Pv7DGt+7drWg4kES5gQUSy+Q1eWCE8IcAeY2J3IbhfXcfBSdC146PfZ3hnFDPgQEDlgghrMPLO8kgGwcE7swXCDGkqqy32jTtRVQmFJUfSStCjgK5DzFbisr9YKKVu1v+rEHBiCDC3CEhJ4eQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(23010399003)(56012099006)(3023799007)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: durk8Fnz9zxPpSm+t6v+2GqYS65k6WFVrp3K90vlzsLwQBa8uXzpWccBNN5ch6YhbrdaOdycB1xyLMmcqMie+RqZhhm4EBo38xNBj2m+Z2Gh6MyXduzsWIcZ+YpYjtubAy9l8uAb3sqISgniddSLKVMhO4SYoF96A0cSm8zC4q/W4/ZdVXR/dFrkAsA4FoMSG3dkwW4t4xRPJ9QsWlFwM03GnZfNHG41KhWP2cjdLL3caxBqBoIobQPe9bcEOf9LqBguyfvCwiovqMMZ1rwhj2C7ZvkxpMXskJoDoAnFlQ1NfwZE8OIuvPZ4yYD19l0J+713PYOqqkFx/8pCoeu0XD1J1Fbr8B5a0TxPAFr/a97dgU0BzOQDOtGDz4vYXeX9JW3Zn1zZ3UVQeV2ZNoiqZ1OP0OP5dXVn5wg2m910tn2cklGLbKmNyA80OKDAFJTG
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2026 13:32:29.0592 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d9166e5c-d2db-4273-110e-08dece073583
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FBB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7711
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

From: Austin Zheng <Austin.Zheng@amd.com>

[Why]
Currently only a singular de-rate is used for all DPM levels.
The intent was to limit the bandwidth utilization at high DPMs
so the display requirements are not competing with other engines for bandwidth.
At lower DPMs, the de-rates could be more lenient so more bandwidth can be
utilized without the need to increase the DPM level and result in potential power savings.
i.e. DPM0 could be achieved on certain display configs instead of DPM1
if de-rates were a couple percentage points higher

The system average de-rates can be adjusted as needed as only urgent de-rates are defined for the SOC.

[How]
Update QOS parameters to have a table of derates with a per-DPM granularity
If the per-DPM value is provided, that will value be used.
Otherwise use the global value if there is no DPM specific value.

Reviewed-by: Jun Lei <jun.lei@amd.com>
Signed-off-by: Austin Zheng <Austin.Zheng@amd.com>
Signed-off-by: George Zhang <george.zhang@amd.com>
---
 .../dml21/inc/dml_top_soc_parameter_types.h   | 13 ++++++
 .../src/dml2_core/dml2_core_dcn4_calcs.c      | 41 +++++++++++++------
 2 files changed, 41 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/dml_top_soc_parameter_types.h b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/dml_top_soc_parameter_types.h
index 6152155d6073..672b96a3da74 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/dml_top_soc_parameter_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/dml_top_soc_parameter_types.h
@@ -71,8 +71,21 @@ enum dml2_qos_param_type {
 	dml2_qos_param_type_dcn4x
 };

+//Indicies mapped to DPM level
+// Unpopulated indicies should fallback to the global derate value.
+struct dml2_soc_derate_values_per_dpm {
+	unsigned int dram_derate_percent_pixel[DML_MAX_CLK_TABLE_SIZE];
+	unsigned int fclk_derate_percent[DML_MAX_CLK_TABLE_SIZE];
+	unsigned int dcfclk_derate_percent[DML_MAX_CLK_TABLE_SIZE];
+};
+
+struct dml2_soc_derates_per_dpm {
+	struct dml2_soc_derate_values_per_dpm system_active_derates_per_dpm;
+};
+
 struct dml2_soc_qos_parameters {
 	struct dml2_soc_derates derate_table;
+	struct dml2_soc_derates_per_dpm derate_table_per_dpm;
 	struct {
 		unsigned int base_latency_us;
 		unsigned int scaling_factor_us;
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4_calcs.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
index f338e733318e..51a66e1be7a1 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
@@ -2701,7 +2701,8 @@ static double dml_get_return_bandwidth_available(
 	bool is_hvm_only,
 	double dcfclk_mhz,
 	double fclk_mhz,
-	double dram_bw_mbps)
+	double dram_bw_mbps,
+	unsigned int uclk_dpm_level)
 {
 	double return_bw_mbps = 0.;
 	double ideal_sdp_bandwidth = (double)soc->return_bus_width_bytes * dcfclk_mhz;
@@ -2722,9 +2723,16 @@ static double dml_get_return_bandwidth_available(
 			derate_fabric_factor = soc->qos_parameters.derate_table.dcn_mall_prefetch_average.fclk_derate_percent / 100.0;
 			derate_dram_factor = soc->qos_parameters.derate_table.dcn_mall_prefetch_average.dram_derate_percent_pixel / 100.0;
 		} else { // just assume sys_active
-			derate_sdp_factor = soc->qos_parameters.derate_table.system_active_average.dcfclk_derate_percent / 100.0;
-			derate_fabric_factor = soc->qos_parameters.derate_table.system_active_average.fclk_derate_percent / 100.0;
-			derate_dram_factor = soc->qos_parameters.derate_table.system_active_average.dram_derate_percent_pixel / 100.0;
+			// use per dpm derates if the values are populated. Otherwise use global derates
+			derate_sdp_factor = soc->qos_parameters.derate_table_per_dpm.system_active_derates_per_dpm.dcfclk_derate_percent[uclk_dpm_level] != 0 ?
+				soc->qos_parameters.derate_table_per_dpm.system_active_derates_per_dpm.dcfclk_derate_percent[uclk_dpm_level] / 100.0 :
+				soc->qos_parameters.derate_table.system_active_average.dcfclk_derate_percent / 100.0;
+			derate_fabric_factor = soc->qos_parameters.derate_table_per_dpm.system_active_derates_per_dpm.fclk_derate_percent[uclk_dpm_level] != 0 ?
+				soc->qos_parameters.derate_table_per_dpm.system_active_derates_per_dpm.fclk_derate_percent[uclk_dpm_level] / 100.0 :
+				soc->qos_parameters.derate_table.system_active_average.fclk_derate_percent / 100.0;
+			derate_dram_factor = soc->qos_parameters.derate_table_per_dpm.system_active_derates_per_dpm.dram_derate_percent_pixel[uclk_dpm_level] != 0 ?
+				soc->qos_parameters.derate_table_per_dpm.system_active_derates_per_dpm.dram_derate_percent_pixel[uclk_dpm_level] / 100.0 :
+				soc->qos_parameters.derate_table.system_active_average.dram_derate_percent_pixel / 100.0;
 		}
 	} else { // urgent bw
 		if (state_type == dml2_core_internal_soc_state_svp_prefetch) {
@@ -2778,6 +2786,7 @@ static double dml_get_return_bandwidth_available(
 	DML_LOG_VERBOSE("DML::%s: derate_fabric_bandwidth = %f (derate %f)\n", __func__, derate_fabric_bandwidth, derate_fabric_factor);
 	DML_LOG_VERBOSE("DML::%s: derate_dram_bandwidth = %f (derate %f)\n", __func__, derate_dram_bandwidth, derate_dram_factor);
 	DML_LOG_VERBOSE("DML::%s: return_bw_mbps = %f\n", __func__, return_bw_mbps);
+	DML_LOG_VERBOSE("DML::%s: uclk_dpm_level = %u\n", __func__, uclk_dpm_level);
 	return return_bw_mbps;
 }

@@ -2793,7 +2802,8 @@ static noinline_for_stack void calculate_bandwidth_available(
 	bool HostVMEnable,
 	double dcfclk_mhz,
 	double fclk_mhz,
-	double dram_bw_mbps)
+	double dram_bw_mbps,
+	unsigned int uclk_dpm_level)
 {
 	unsigned int n, m;

@@ -2812,9 +2822,10 @@ static noinline_for_stack void calculate_bandwidth_available(
 				0, // hvm_only
 				dcfclk_mhz,
 				fclk_mhz,
-				dram_bw_mbps);
+				dram_bw_mbps,
+				uclk_dpm_level);

-			urg_bandwidth_available[m][n] = dml_get_return_bandwidth_available(soc, m, n, 0, HostVMEnable, 0, dcfclk_mhz, fclk_mhz, dram_bw_mbps);
+			urg_bandwidth_available[m][n] = dml_get_return_bandwidth_available(soc, m, n, 0, HostVMEnable, 0, dcfclk_mhz, fclk_mhz, dram_bw_mbps, uclk_dpm_level);


 #ifdef __DML_VBA_DEBUG__
@@ -2824,8 +2835,8 @@ static noinline_for_stack void calculate_bandwidth_available(

 			// urg_bandwidth_available_vm_only is indexed by soc_state
 			if (n == dml2_core_internal_bw_dram) {
-				urg_bandwidth_available_vm_only[m] = dml_get_return_bandwidth_available(soc, m, n, 0, HostVMEnable, 1, dcfclk_mhz, fclk_mhz, dram_bw_mbps);
-				urg_bandwidth_available_pixel_and_vm[m] = dml_get_return_bandwidth_available(soc, m, n, 0, HostVMEnable, 0, dcfclk_mhz, fclk_mhz, dram_bw_mbps);
+				urg_bandwidth_available_vm_only[m] = dml_get_return_bandwidth_available(soc, m, n, 0, HostVMEnable, 1, dcfclk_mhz, fclk_mhz, dram_bw_mbps, uclk_dpm_level);
+				urg_bandwidth_available_pixel_and_vm[m] = dml_get_return_bandwidth_available(soc, m, n, 0, HostVMEnable, 0, dcfclk_mhz, fclk_mhz, dram_bw_mbps, uclk_dpm_level);
 			}
 		}

@@ -9483,7 +9494,8 @@ static bool dml_core_mode_support(struct dml2_core_calcs_mode_support_ex *in_out
 		display_cfg->hostvm_enable,
 		mode_lib->ms.DCFCLK,
 		mode_lib->ms.FabricClock,
-		mode_lib->ms.dram_bw_mbps);
+		mode_lib->ms.dram_bw_mbps,
+		mode_lib->ms.active_min_uclk_dpm_index);

 	calculate_bandwidth_available(
 		mode_lib->ms.support.avg_bandwidth_available_min,
@@ -9498,10 +9510,12 @@ static bool dml_core_mode_support(struct dml2_core_calcs_mode_support_ex *in_out
 		mode_lib->ms.MaxDCFCLK,
 		mode_lib->ms.MaxFabricClock,
 #ifdef DML_MODE_SUPPORT_USE_DPM_DRAM_BW
-		mode_lib->ms.dram_bw_mbps);
+		mode_lib->ms.dram_bw_mbps,
 #else
-		mode_lib->ms.max_dram_bw_mbps);
+		mode_lib->ms.max_dram_bw_mbps,
 #endif
+		mode_lib->ms.active_min_uclk_dpm_index);
+

 	// Average BW support check
 	calculate_avg_bandwidth_required(
@@ -10958,7 +10972,8 @@ static bool dml_core_mode_programming(struct dml2_core_calcs_mode_programming_ex
 		display_cfg->hostvm_enable,
 		mode_lib->mp.Dcfclk,
 		mode_lib->mp.FabricClock,
-		mode_lib->mp.dram_bw_mbps);
+		mode_lib->mp.dram_bw_mbps,
+		mode_lib->mp.active_min_uclk_dpm_index);


 	calculate_hostvm_inefficiency_factor(
--
2.54.0

