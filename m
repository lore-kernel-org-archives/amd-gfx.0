Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCD59606A31A
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Oct 2026 23:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=decJ6Qkq
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E82E10F8AD;
	Tue, 27 Oct 2026 23:25:17 +0000 (UTC)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011018.outbound.protection.outlook.com [40.107.208.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 92D5610F8AD
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Oct 2026 23:25:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fxs0jq/YYc4a88CfJsoLAii2w6ctWSLsIfvz6nRUJLp8SHX/ECWxWeHvR+0yTWfl9QLdXnu6FFVeOJujxDVTaHeMOzH1X13dXmtgs6Jc5e1Re2T8z9lon1Mu+aGWRrAVFP+GNL2Uj6noTB1Tn2OdIhxpgVSulI/VWXBLer8wdGQ+SxycDMtv19R1uevEtx/p1FHMVV3SjQmpp8OBLW3GpgSA0v9sYDyu9IBVrUAIKwGzzC12MtMGQ5MjdE1O0Y9x8yAfuWziZLSmFJ27MupoAkUa4Bueg5oK7/mZ+a4ZmetADuvOeFUEvikTlHRfmfcm321bvO1UnByaiuiI6Lzh8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UyXwsc5EWkmoLPitPMttD0GDDAKv7kecW8xBFsw2P/w=;
 b=CsvMxk4qY1Mpau11/F1jFmiTgjNUEYf7w5rIw+YeAVQRw2fHBLja5jbIXttGWbdw5BqQOLjpTWJrzwGpGnwgee/fdxwDm8kbSBoxxcoDEJzrAceiN2vaj5oWIIRRXCNwsiItcYA9kH9VrS8r6CrFESAOwMucYbU4G7YqcbdLPUwjuy665vM3V7MzvH4ND+z61o7jiy3s8HVMvk/8nScGCjDepCbCOtZDFv6fhkINpt5WAAHpjYkRjhlz1fX8UF/+3Xvqw7TkN7wttJKkHXIih5cMw0R9ar28kv9KJDPNahL5n//0V3E2ZYH3+GZSIJ4/Kwr08vW0Jdo0kmM4yruKsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UyXwsc5EWkmoLPitPMttD0GDDAKv7kecW8xBFsw2P/w=;
 b=decJ6QkqdG0c0R3kXulCJbDKa0A5n8r64JLNd5lV2rRJYudCMu+eU/4PJsIOVT9ecfe5615LJwNbC/N6WmFezhRhxDWAkoiXrjzLPe0BoWtwCQpGp0UtBAdMJ7R4yDQwbAkS//TOZe+JXaRNJ9y4QiFHrZu20zL2hLo5fr1v7Fc=
Received: from CH0PR03CA0220.namprd03.prod.outlook.com (2603:10b6:610:e7::15)
 by CH3PR12MB7571.namprd12.prod.outlook.com (2603:10b6:610:147::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 23:25:05 +0000
Received: from CH01EPF000BE940.namprd02.prod.outlook.com
 (2603:10b6:610:e7:cafe::64) by CH0PR03CA0220.outlook.office365.com
 (2603:10b6:610:e7::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Tue,
 27 Oct 2026 23:25:05 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH01EPF000BE940.mail.protection.outlook.com (10.167.244.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Tue, 27 Oct 2026 23:25:05 +0000
Received: from kylin.lan (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 27 Oct
 2026 18:25:03 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Ilya Bakoulin <Ilya.Bakoulin@amd.com>, Dillon Varone
 <dillon.varone@amd.com>
Subject: [PATCH 21/28] drm/amd/display: Expand DSCCLK support check
Date: Tue, 27 Oct 2026 17:17:17 -0600
Message-ID: <20261027232005.2879750-22-alex.hung@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261027232005.2879750-1-alex.hung@amd.com>
References: <20261027232005.2879750-1-alex.hung@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH01EPF000BE940:EE_|CH3PR12MB7571:EE_
X-MS-Office365-Filtering-Correlation-Id: be42e1d2-3e75-4956-5ef0-08df348188a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700016|1800799024|23010399003|6133799003|18002099003|22082099003|261026121527099003|3023799007|10067099003|56012099006|11063799006|5023799004|261009221227099003|261021121427099003|261009223327099003|261009220027099003|261009223027099003|261021123027099003|261009221727099003|261022075727099003;
X-Microsoft-Antispam-Message-Info: o/kTSOCcuHzidluomVt7IqkN4usliezXXL700WNWmQB/wqVB9himjYMXKwAZ3i2SFpQBu5Y0ZtD9Q/QgPstIoYXNHWFcMsxIZUKV3/63t2tHV0hRWskPamwnQ86NdXzp+08Q5r3fx/zVGSoK0hARQA+M1PSFlkMCMRkOWXalLEvsxMvplMKuvhYQWp8xAv12RFjgRxIcf6sQ+TJvvhbCGz3fna4Xu3ESB9X4bqY/ScguRS8MOR3eI7gTwp5gm80dBTUXjzlIRbzzcpzdEoucXv/wUYuxNPlz9ifmVYLhshuAsY2y9qSe5/ySyEPdHDEPO3tx9Hey4YbditS0qIffPrJLd86iKay1gaPR2pqlSHmFJGng6tGx6Xau35hoH6xxy6AYPiTrkTmzuszKZ4B5PCukx8QYrdXoIkBYC7oxa3Iqe2HY3hHEY2Jk7i0jjzwl/rs0p0ed7OfoiU9h2XPggS5UG839pwOnMUmTwIwlKZQKODD38tUNR1s52dwF/NzacQhlLhmN67zDqRKeOrSLORcJ6i0je08SMZMn6f+253cX64sWtihmM1pwA6uOvzilxdSS6d7N3eEWIsplsml4wb3WzhQtc2FGfS7hOD+HYBP9tTYhLBSYajNgboGx9pm2HadBkI4PJ5eMVt7MgRaFO0zzX7yeNCgjq6uUCwg+LQr6PkUODsYm5iEjwfPPDu2MpXsyQn3TV650xuUuWYPGMQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700016)(1800799024)(23010399003)(6133799003)(18002099003)(22082099003)(261026121527099003)(3023799007)(10067099003)(56012099006)(11063799006)(5023799004)(261009221227099003)(261021121427099003)(261009223327099003)(261009220027099003)(261009223027099003)(261021123027099003)(261009221727099003)(261022075727099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: thDO/Q3a+SzuDC26j0voAdPmCVydcd++11Kr3wEHoUNxqMDCp6j5xkTu1WXMTAbErpXgvowqHVid5Ye2IlniWyKv2CzpNR0xaG8PuJZ9JhdGx8lEtZ3aIhgwxgPzr+6RBSN4S+3YD2NbRriXFWcg/Ev1VF/+2i7pc4NKS8sHOKWy4lAchoaRRlCejCOMyAhy6iahw8/pF1gJ6eNT3laWhBeQmXoUJMWcVK9+Jjwzhz1HD0GU5vNSPgjYb0Rc3sk0O89pkuVDpF/4Vy7PJxjRX6R/kZvlpa3kOPqQfMPDy3+eeirqmwBFpRVY3ixODRvepK2vMprz6e1gjaOePoHywWLHBrlpMVTOmgVrKrmL3Yo36vUF+lQSNWUr3MrmCeJ1VuWrm4RgY+Zj7DnQjDXTwsKu+9OJcZgFqDdwNkhTnHYfZpWQuhpbfM2WA3Nkombh
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 23:25:05.7455 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: be42e1d2-3e75-4956-5ef0-08df348188a7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH01EPF000BE940.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7571
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Ilya Bakoulin <Ilya.Bakoulin@amd.com>

[WHY & HOW]
Need to add a check for the case where there is 1 DSC slice per ODM
pipe, and DSCCLK exceeds 1/5th of DPREFCLK. Such configurations should
be marked as unsupported.

Cc: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Ilya Bakoulin <Ilya.Bakoulin@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 .../dml2_core_dcn5_funcs_mode_support.c       | 24 ++++++++++++++++---
 .../dml2_core_dcn6_funcs_mode_support.c       | 19 ++++++++++++++-
 .../dml2_utm_soc_bb/dml2_utm_soc_bb_dcn5.c    |  1 +
 .../dml2_utm_soc_bb/dml2_utm_soc_bb_dcn6.c    |  1 +
 .../src/inc/dml2_internal_shared_types.h      |  1 +
 5 files changed, 42 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn5_funcs_mode_support.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn5_funcs_mode_support.c
index 09519f0f2251..b9aef66d722d 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn5_funcs_mode_support.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn5_funcs_mode_support.c
@@ -1151,14 +1151,32 @@ static void dcn5_ms_calculate_dscclk_required(
 }
 
 static bool dcn5_ms_check_dscclk_support(
-		struct dml2_core_internal_display_mode_lib *mode_lib)
+		struct dml2_core_internal_display_mode_lib *mode_lib, const struct dml2_utm_soc_bb *utm_soc_bb)
 {
 	unsigned int k;
 	bool support = true;
 
-	for (k = 0; k < mode_lib->ms.num_active_planes; k++)
+	for (k = 0; k < mode_lib->ms.num_active_planes; k++) {
 		if (mode_lib->ms.required_dscclk_freq_mhz[k] > mode_lib->ms.max_dscclk_freq_mhz)
 			support = false;
+
+		unsigned int num_dsc_units;
+
+		if (mode_lib->ms.ODMMode[k] == dml2_odm_mode_combine_4to1)
+			num_dsc_units = 4;
+		else if (mode_lib->ms.ODMMode[k] == dml2_odm_mode_combine_3to1)
+			num_dsc_units = 3;
+		else if (mode_lib->ms.ODMMode[k] == dml2_odm_mode_combine_2to1)
+			num_dsc_units = 2;
+		else
+			num_dsc_units = 1;
+
+		if (mode_lib->ms.required_dscclk_freq_mhz[k] > ((double)utm_soc_bb->dprefclk_mhz / 5.0) &&
+				(mode_lib->ms.support.NumberOfDSCSlices[k] / num_dsc_units) == 1) {
+			support = false;
+		}
+	}
+
 	return support;
 }
 
@@ -2844,7 +2862,7 @@ static bool dcn5_mode_support(struct dml2_core_calcs_mode_support_ex *in_out_par
 
 	dcn5_ms_calculate_dscclk_required(display_cfg, mode_lib);
 
-	mode_lib->ms.support.DSCCLKRequiredMoreThanSupported = !dcn5_ms_check_dscclk_support(mode_lib);
+	mode_lib->ms.support.DSCCLKRequiredMoreThanSupported = !dcn5_ms_check_dscclk_support(mode_lib, utm_soc_bb);
 
 	dcn5_ms_check_dsc_engine_supports(display_cfg, mode_lib);
 
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn6_funcs_mode_support.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn6_funcs_mode_support.c
index 50ca620a4c41..2ca3a603615e 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn6_funcs_mode_support.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn6_funcs_mode_support.c
@@ -1516,7 +1516,7 @@ bool dcn6_ms_check_dscclk_support(
 	const struct dml2_utm_soc_bb *soc_bb = ctx->soc_bb;
 
 	DML_LOG_FUNC_ENTER();
-	for (k = 0; k < display_cfg->num_planes; k++)
+	for (k = 0; k < display_cfg->num_planes; k++) {
 		if (inputs->required_dscclk_freq_mhz[k] > (double) soc_bb->max_dscclk_khz / 1000) {
 			outputs->support.DSCCLKRequiredMoreThanSupported = true;
 			DML_LOG_VERBOSE("DML::%s: k=%u, DSCCLKRequiredMoreThanSupported = %u\n",
@@ -1524,6 +1524,23 @@ bool dcn6_ms_check_dscclk_support(
 			break;
 		}
 
+		unsigned int num_dsc_units;
+
+		if (inputs->ODMMode[k] == dml2_odm_mode_combine_4to1)
+			num_dsc_units = 4;
+		else if (inputs->ODMMode[k] == dml2_odm_mode_combine_3to1)
+			num_dsc_units = 3;
+		else if (inputs->ODMMode[k] == dml2_odm_mode_combine_2to1)
+			num_dsc_units = 2;
+		else
+			num_dsc_units = 1;
+
+		if (inputs->required_dscclk_freq_mhz[k] > ((double)soc_bb->dprefclk_mhz / 5.0) &&
+				(inputs->support.NumberOfDSCSlices[k] / num_dsc_units) == 1) {
+			outputs->support.DSCCLKRequiredMoreThanSupported = true;
+		}
+	}
+
 	DML_LOG_DEBUG_BOOL(outputs->support.DSCCLKRequiredMoreThanSupported);
 	DML_LOG_FUNC_EXIT();
 
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_utm_soc_bb/dml2_utm_soc_bb_dcn5.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_utm_soc_bb/dml2_utm_soc_bb_dcn5.c
index a58c3944addb..bb45d9b61554 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_utm_soc_bb/dml2_utm_soc_bb_dcn5.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_utm_soc_bb/dml2_utm_soc_bb_dcn5.c
@@ -121,6 +121,7 @@ bool dml2_utm_soc_bb_dcn5_create(struct dml2_utm_soc_bb *utm_soc_bb,
 	utm_soc_bb->writeback_base_latency_us = soc_bb->qos_parameters.writeback.base_latency_us;
 	utm_soc_bb->vmin_limit = soc_bb->vmin_limit;
 	utm_soc_bb->dchub_refclk_mhz = soc_bb->dchub_refclk_mhz;
+	utm_soc_bb->dprefclk_mhz = soc_bb->dprefclk_mhz;
 	utm_soc_bb->max_outstanding_reqs = soc_bb->max_outstanding_reqs;
 	utm_soc_bb->return_bus_width_bytes = soc_bb->return_bus_width_bytes;
 	utm_soc_bb->phy_downspread_percent = soc_bb->phy_downspread_percent;
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_utm_soc_bb/dml2_utm_soc_bb_dcn6.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_utm_soc_bb/dml2_utm_soc_bb_dcn6.c
index 9fce6b472aa6..586618d7dd58 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_utm_soc_bb/dml2_utm_soc_bb_dcn6.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_utm_soc_bb/dml2_utm_soc_bb_dcn6.c
@@ -315,6 +315,7 @@ static void dcn6_initialize_from_soc_bb(struct dml2_utm_soc_bb *utm_soc_bb,
 	utm_soc_bb->writeback_base_latency_us = soc_bb->qos_parameters.writeback.base_latency_us;
 	utm_soc_bb->vmin_limit = soc_bb->vmin_limit;
 	utm_soc_bb->dchub_refclk_mhz = soc_bb->dchub_refclk_mhz;
+	utm_soc_bb->dprefclk_mhz = soc_bb->dprefclk_mhz;
 	utm_soc_bb->max_outstanding_reqs = soc_bb->max_outstanding_reqs;
 	utm_soc_bb->return_bus_width_bytes = soc_bb->return_bus_width_bytes;
 	utm_soc_bb->phy_downspread_percent = soc_bb->phy_downspread_percent;
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/inc/dml2_internal_shared_types.h b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/inc/dml2_internal_shared_types.h
index fab9d149b3de..f06affe1fbbb 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/inc/dml2_internal_shared_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/inc/dml2_internal_shared_types.h
@@ -122,6 +122,7 @@ struct dml2_utm_soc_bb {
 	double hostvm_inefficiency_fraction;
 	unsigned int max_lsdma_bandwidth_kbps;
 	unsigned int dchub_refclk_mhz;
+	unsigned int dprefclk_mhz;
 	unsigned int max_outstanding_reqs;
 	unsigned long return_bus_width_bytes;
 	double phy_downspread_percent;
-- 
2.53.0

