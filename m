Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36836CD98F6
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Jun 2026 13:32:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA8CF10F5F1;
	Fri, 19 Jun 2026 13:32:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lsrqYJJb";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013061.outbound.protection.outlook.com
 [40.93.196.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD20010F5EC
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Jun 2026 13:32:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dsBIqf9IDKqhcPEeear7fOOqBCbrXNLXNTT7n2CNQbuPLZ5wYjEuPx6p+wBCegbyVHkVGCERoY25/yXOW6KZyLL4BfWjWKGdA7GaVK0jWwifJLXDhDyNtrQHSLjwTv6+viNU4hxPfbmVtTh8ygTyE3nevUzOgF7tq7PttB0WztjL75G13YCrbV2KCC6eslujC0VgpbspWoAAYq2g6NDX9sFxtM41/SSFWANos7mQhgi1Zw5loMolNqY7WCuoo1LT8D6sR+dw7mIpUPgy/1Abt//3vZkNAyJs1qYDy2WCywrRSQU7sCKOz7NpX+QRWzNhtM8r9MM13n3kPn9XSRccfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W/xNOBnarvRq4rPS4B5qo3zrMD4+FNcpYATeK8LYjM4=;
 b=DcpcUoimh4FxU/S9u/cQhyWTqPy4wmJurYzoQ9v5ZeyntDEtP/7GWoNdNSBDR8gHKuqTUQnA18r4xaNZ+JCWljY+AoXGE9ecCWR1g0H75UcEw3A3mOVkJWppWGVaa8hKl83JiplRgg3Ci8CylclfMcYBYVH7mY2AwoYV2tmJB+BAckVnYrd+RpnLM7mTShG14YzqJ7AJ3OwOmwMuJOP8TdPM4SrFvpl7RG7qN/NaAzqxYztFhHuhODcHLsXX+vJYZzD9vC5DJOdNoNWyxkRuNyzC7FrFOG6rEcNdvqnayIE3DxNcuFFFQTnoAGCvk1TQfz9kGog99ZmqQTapquU1qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W/xNOBnarvRq4rPS4B5qo3zrMD4+FNcpYATeK8LYjM4=;
 b=lsrqYJJbGfT563mkKr+sf4Bim5v4EP1ifRy7y7MoFGuq/ZhycCHZd/rbVdAJyS+c935aXX9cVVZGdafpAF7iB0jTMeAAkaQa+jnvC6eUdjlaAmRagCyhMxiwxiw6oALjhH69p9jZSc+/addP2zzqchDVV0mLrgBLu+PQqypS4XA=
Received: from BLAPR03CA0116.namprd03.prod.outlook.com (2603:10b6:208:32a::31)
 by SJ0PR12MB6760.namprd12.prod.outlook.com (2603:10b6:a03:44c::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Fri, 19 Jun
 2026 13:32:39 +0000
Received: from BN2PEPF00004FC0.namprd04.prod.outlook.com
 (2603:10b6:208:32a:cafe::3) by BLAPR03CA0116.outlook.office365.com
 (2603:10b6:208:32a::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.11 via Frontend Transport; Fri,
 19 Jun 2026 13:32:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF00004FC0.mail.protection.outlook.com (10.167.243.186) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Fri, 19 Jun 2026 13:32:36 +0000
Received: from georzhanmkm (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 19 Jun
 2026 08:32:33 -0500
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
Subject: [PATCH 21/24] Add Debug Option To Enable Per-DPM De-rate Usage
Date: Fri, 19 Jun 2026 09:21:36 -0400
Message-ID: <20260619133154.116746-22-george.zhang@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FC0:EE_|SJ0PR12MB6760:EE_
X-MS-Office365-Filtering-Correlation-Id: 193c27ce-f69f-4615-d53d-08dece073a0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700016|1800799024|23010399003|22082099003|3023799007|18002099003|11063799006|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info: KYG+epkYbeMedIVtSGfSXcwzrmc7Il0IVs90PeAa7PGHfNdW0MhMO8zcqyP2IqNWLx/5WjMWfR80y5hRaAf6OTW9CLHXqLzJ1m6qG9YK6Dx/TFhgKfAG7boZ+EIavgkgOOdBzjiihfjPpmCT9uCBsJq4qlklqIRcVVWgt2yHhWqqvKiQIwSomJHhlDkLamFWluH2JYI6dwgS/Snu8Yne2RyvSFCXGT3EPOAcmtr8lxg/xNgLq57kxHYFiR5Tm3gW7oVrLy+uGRebQZiCE9XIHQARjk4DKFwlZxm7woR8usIbOQwJ206V+1EB+LJ2XlS9EbU75eGwa8l7lsuHbU8Dc+HAqkiO+t8QrqaV4DQYHVJOKoLbzzZZo4LasG60AlL/xcH7K96eQen8uDKoUcq2xxotHYgVfJRZKH7Xlznz06P06GqQfoDbsM7NlOP5cm6scF5lmVMhAEabAi66oMnLl5v1uzu7IMp2H9YVUoHJAdu2NRv8jdmAmBTS5wt4H5XylYaxtCYMNGyNT6jpd38Gj84xv3Hp9W+uiEcDKhAh0b3z0t/+Todw0wvS4jTxoSBuXG9vOM4Gqzumgrtc1fzu48/RvNSUNPwH9i9X9WQJKtXsCSjEBYhkcPwapjbJeNFpADM/Pt4A7ChS+5+V4U+gY5moYzv//2w+bdIhcbr3JZmC+6UwjvKSU891Zvr1MUlnsbBOh6QxwdfSkfbk8uyunQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700016)(1800799024)(23010399003)(22082099003)(3023799007)(18002099003)(11063799006)(6133799003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 9wq8t1/ijb4Ma++hTwGGytUeN3yMr839OhU3b/CBjTM86lOOGK9kt1qjRwXUX3xZHL+tNTBieoe8XR1JCG7UurYWS13Mn7xKmIaWIpaES5QP3sIWK03OvB1NvWrM6hPIqItunr1vzrfq73PzxJZGFg1Xyf0+HhXiOvmmaF3lxWF/+kdLimeXwNAP7evLarC9K0HHODLZ4dSsIjIzGFmouXL4297+szo3+QxjrldyXyCfbC/rbKARv4h5OCGuV+zDtmHmDCT1cCutIVdNkEz733MG2q3ybdyDTDW5jBdNRe/yvtuYD7E2U0LiBoiPs22c+Yx4JcvkOGPQNzTl2q8YrcIEb7+juneCboDgHh0+yhTcM62d1+WuhtnoV08MLn2VxpnNF0lU3qTLVyNmgptKZN39Qhu3fHqCrx4ifOUS5/08UOOSo7dOXERnqG03cvcp
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2026 13:32:36.6840 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 193c27ce-f69f-4615-d53d-08dece073a0d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FC0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6760
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
DML has been updated to use per-DPM derates when provided but per-DPM de-rates have not been finalized.
Need to validate to see what values should be stored in the bounding box.

[How]
Add debug options to set custom derates per DPM (starting at DPM0) and their values

Each entry in the custom derate expects the derates to be stored in the following format:
bits 0-7: dram_derate_percent_pixel
bits 8-15: fclk_derate_percent
bits 16-23: dcfclk_derate_percent
bits 24-31 are unused.

e.g. Using the value 0x414020 will set the following derates for DPM0
DPM0: 0x20, 0x40, 0x41 for dram, fclk, and dcfclk respectively

Note that global derate value will be used if the per-DPM derate is 0.

Reviewed-by: Jun Lei <jun.lei@amd.com>
Signed-off-by: Austin Zheng <Austin.Zheng@amd.com>
Signed-off-by: George Zhang <george.zhang@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h              |  2 ++
 .../dcn401/dcn401_soc_and_ip_translator.c        | 16 ++++++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index c2a1f75ae9ae..c628bf8778c9 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -1289,6 +1289,8 @@ struct dc_debug_options {
 	bool enable_replay_esd_recovery;
 	uint8_t iommu_mismatch_temp_wka;
 	bool disable_dynamic_expansion_for_test_pattern;
+	uint32_t dml21_custom_derate_num_dpms;
+	uint32_t dml21_custom_derate_at_dpm[DML2_MAX_NUM_DPM_LVL];
 };


diff --git a/drivers/gpu/drm/amd/display/dc/soc_and_ip_translator/dcn401/dcn401_soc_and_ip_translator.c b/drivers/gpu/drm/amd/display/dc/soc_and_ip_translator/dcn401/dcn401_soc_and_ip_translator.c
index 89f7ccd7f81f..0c8e652c3532 100644
--- a/drivers/gpu/drm/amd/display/dc/soc_and_ip_translator/dcn401/dcn401_soc_and_ip_translator.c
+++ b/drivers/gpu/drm/amd/display/dc/soc_and_ip_translator/dcn401/dcn401_soc_and_ip_translator.c
@@ -269,6 +269,22 @@ void dcn401_update_soc_bb_with_values_from_software_policy(struct dml2_soc_bb *s
 	if (dc->bb_overrides.sr_enter_plus_exit_z8_time_ns)
 		soc_bb->power_management_parameters.z8_stutter_enter_plus_exit_latency_us =
 				dc->bb_overrides.sr_enter_plus_exit_z8_time_ns / 1000.0;
+
+	/* Override per-dpm derates based on a custom derate table.
+	 * Global derate value will be used for derates that aren't populated
+	 * 3 derates for a single DPM level:
+	 *  bits 0-7: dram_derate_percent_pixel
+	 *  bits 8-15: fclk_derate_percent
+	 *  bits 16-23: dcfclk_derate_percent
+	 */
+	for (unsigned int i = 0; i < dc->debug.dml21_custom_derate_num_dpms; i++) {
+		soc_bb->qos_parameters.derate_table_per_dpm.system_active_derates_per_dpm.dram_derate_percent_pixel[i]
+			= dc->debug.dml21_custom_derate_at_dpm[i] & 0xFF;
+		soc_bb->qos_parameters.derate_table_per_dpm.system_active_derates_per_dpm.fclk_derate_percent[i]
+			= (dc->debug.dml21_custom_derate_at_dpm[i] >> 8) & 0xFF;
+		soc_bb->qos_parameters.derate_table_per_dpm.system_active_derates_per_dpm.dcfclk_derate_percent[i]
+			= (dc->debug.dml21_custom_derate_at_dpm[i] >> 16) & 0xFF;
+	}
 }

 static void apply_soc_bb_updates(struct dml2_soc_bb *soc_bb, const struct dc *dc, const struct dml2_configuration_options *config)
--
2.54.0

