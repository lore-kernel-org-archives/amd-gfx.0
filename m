Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 727EACCD1BF
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Oct 2025 03:11:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B39410E6E9;
	Wed, 29 Oct 2025 03:11:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="snZsS/RZ";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013044.outbound.protection.outlook.com
 [40.107.201.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2467C10E6E7
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Oct 2025 03:11:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vTiFAe1njRdh9vezP5jcdHvHMZGllnMCjP/jaT4DYMCQxY/lQnSH0Ol8PnjkT2TJL2ZMJGjEAXwmTaBVdOT94ZFyE6kzdQNEJeZvT785FDFFx0gRoFHtCj8yVWoPMqPP1oG5XrOgqNo0eWvnNwuTHS83EGjj1ZnmsYCFebMwl1pCGM5PzfxauG92bGdKK7ZwfRAJzfdpJ3DGUsR/i2HCfrdNyglYbiAhKo1w//dCFoIzUFydgDfDzIg2kZ4lnxjH66eNayTiW8sJkBXFLhZWBDLyMPeH1p3PbWeOWgWSrGVUYGDm+rkbRPPMu29Z+ZkeuMLU3O+Tobhe+SWm67QIWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hdSDJmB023hlucNVnGiJJHjtdVllOmFfW9JZMniIgQM=;
 b=sZn2bRuQGKKnXWbw+y6hGXJ42qNPCnqqtMC7RVeV9wfUHOR0fOWy7eLdLmkxK408akBksn8kmKMwnkUiJ2U7V+eUrrSmtZXAUDZtxgy5CJsMbWO8dfjAeuKhyjS3V3d9gHi6MbwN5f4IxVj+pM691mQUdEI1syN3pT1kpYoxm4WeUFzXqIWU8tiJ2jsK0v73pybbIaoaURRQ8uI5ocdyatvsXuoyWoVmSyx7RxRt/k0hbF3Xli68tD6NsOJw8Mkd3qREbdwNX9DjtJ/ITnHlEW/uWHqcKC+9spqkBbj+bZRuT8bcwr8FJH6e8hdDlwcT4JCx0W9GxZjS8+sHaSDCDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hdSDJmB023hlucNVnGiJJHjtdVllOmFfW9JZMniIgQM=;
 b=snZsS/RZDjLKTOKGSsaWNE2noXkmUPfZg+2gpD9QsIiA+pyvDojjmsaDN50+UApjNP4hmw1mqgpueTq/eC/7BITGYJdbdS2AmEoWVZUykQbHlxtQ+tDokAFY9iUkB+JN3RwAdDpPNAiRJGNHVHSknotx9AqzIXxZeCNKt4xrpp0=
Received: from DM6PR21CA0007.namprd21.prod.outlook.com (2603:10b6:5:174::17)
 by CH3PR12MB8187.namprd12.prod.outlook.com (2603:10b6:610:125::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.20; Wed, 29 Oct
 2025 03:11:12 +0000
Received: from DS3PEPF000099D6.namprd04.prod.outlook.com
 (2603:10b6:5:174:cafe::7) by DM6PR21CA0007.outlook.office365.com
 (2603:10b6:5:174::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.4 via Frontend Transport; Wed,
 29 Oct 2025 03:11:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS3PEPF000099D6.mail.protection.outlook.com (10.167.17.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Wed, 29 Oct 2025 03:11:12 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Tue, 28 Oct
 2025 20:10:56 -0700
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 28 Oct
 2025 22:10:55 -0500
Received: from ray-Ubuntu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 28 Oct 2025 20:10:47 -0700
From: Ray Wu <ray.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Austin Zheng <Austin.Zheng@amd.com>, Dillon Varone
 <dillon.varone@amd.com>, Ray Wu <ray.wu@amd.com>
Subject: [PATCH 05/13] drm/amd/display: Update P-state naming for clarity.
Date: Wed, 29 Oct 2025 11:02:53 +0800
Message-ID: <20251029030935.2785560-6-ray.wu@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251029030935.2785560-1-ray.wu@amd.com>
References: <20251029030935.2785560-1-ray.wu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: ray.wu@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D6:EE_|CH3PR12MB8187:EE_
X-MS-Office365-Filtering-Correlation-Id: 052ee764-b970-4dfd-a075-08de1698d0a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|30052699003|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2FXBrF8yzH9Tmy8aI9xpGgVNTpEvh0qNwjGgL5oWWHvAtes2R3BWx7rMb0Z9?=
 =?us-ascii?Q?AYwpXRu6lEb3Ry2dhzcnPdNMh6f4Sn8D3m6PpG9+1U/CPqQMFhgMjNXwcHpq?=
 =?us-ascii?Q?bDbXuyD6eqn0t6e+M8DqNnVJmX/7Gk0pJbEwSWc/QlsNHjtQhRpOAjVrMp0p?=
 =?us-ascii?Q?6jGLxTcnsfvk1RwWlI70rgLDHLtUmVloVvCOvc20v5rSeLnLGC0mR1D/fT5L?=
 =?us-ascii?Q?c/0DVy1DH+JfvHYQEJCULJU5n2D9EM2zNmjIdmoBPGD6k8OPM1mCK+BtT2el?=
 =?us-ascii?Q?CZ78Xv/HO2KkNVoYBvx9kaftd/hW2OI/2ChJU9/I6viTH0kxiKU7Uin40OWA?=
 =?us-ascii?Q?qmm14r1odF+FDNs5/CcUKmk0pL/kOlTvqHRpz6s+CkKCbweoZwbY1mgJKarE?=
 =?us-ascii?Q?q5uBqeyEH0eNtFeyivIg40zHZ+bev0jPzvWw53O99cBN9dDGwuWQO06aU2uT?=
 =?us-ascii?Q?AcZsXGjdVfQ2LdSKLAJvaL4BaI2J2p/HR/2vXPY/Fn6+Spueqmt7z9wrI2oo?=
 =?us-ascii?Q?s7Ed2TfFD0yXQLc8/mESPFv9okGALT1R4B6Tbcn5p/cX+LhWz87gxyN1qp11?=
 =?us-ascii?Q?x14XbjHx0x1Z0SkzHAvamg1KtfzvlN8MOGTrfwo5lrbHLja49crDn8ItShM4?=
 =?us-ascii?Q?OF1XLcOKnBrv14IzGBn/8QDjjKUK43WgiHmlukJqD4Q65YXu2bOtAcimIZxE?=
 =?us-ascii?Q?/P74SPMQYWQd67flLC5Yf/SNh2GoKd4h8Qj/1KZ/iZimowx52kqR3KYYJYf3?=
 =?us-ascii?Q?JsMAfzlc2XC0XJrptsl7URbaDajBB6V4lJad5mBHZzFURgVTAcJkTFzlAJnU?=
 =?us-ascii?Q?CiKtvn6upusTictDLpEIay7PYrbKZioA+JlBpF34pRzzXqykfX2eA7vHaLO1?=
 =?us-ascii?Q?7Osdz2b3mQtBfMx2JFoES9Sxaoa2gk/KziM3N7i000g/cCvRfYI1XtmLzwLy?=
 =?us-ascii?Q?Xx9lcfV/19tcFmFUJDqyuEX0rnX+WPqitCRlbUWq3M3qeAE8pKo+jkvi47DC?=
 =?us-ascii?Q?8qhQ2zTeEVQ2DGYmswOocknbP7OzMvMqa7FebMyokK7b9jwrY0lNvH+NFbOf?=
 =?us-ascii?Q?c+6egt2c5Cuz9CMG7e1M178OOac32+XuN6OKlDpk3l9pUVETqJ06HnVM4Z4k?=
 =?us-ascii?Q?11IXqDGlmNcdW+x0xOrDsDbmix0r6kqqXm5gI9Cs9+K/pPGVu2bBwPSHZMu1?=
 =?us-ascii?Q?bgGwpQ83B+1tgX2ioMZ7jnOF5TIaPpPvcyv3A1t/fR17tcGCXC4iQ7NIj1P9?=
 =?us-ascii?Q?FldV7tE/VAVXIJr45fUi3UY7xKrq+J/LbA3tj0mMeN9Mp6BMffW/Vt0n5gjr?=
 =?us-ascii?Q?/QZ8FySArFptYYywL3HNmlvVCMHQsUGB1hxuKXuZIJkOIEowoBtZu8nE+TtQ?=
 =?us-ascii?Q?6/WdxXehN8CUwweyAP9uwCMhIWQlHiAej2iVvl987UuNzLCvF4nab71aqBd9?=
 =?us-ascii?Q?h6nWGdomsLjOUIFAgrDvieoDqrLm7xLzkSOiL/16T9+vpvPxx6V+BBS2FqRM?=
 =?us-ascii?Q?lklYBLy59J4MEzbrXkr+NjyptMRknw41Xbx2SqldBMKJ9dWrVPVpbjrXtyA5?=
 =?us-ascii?Q?P9kN0OqKQWSPzJBN7mQ=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(30052699003)(36860700013);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 03:11:12.3626 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 052ee764-b970-4dfd-a075-08de1698d0a3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8187
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

[Why & How]
P-state can refer to different things like UCLK P-state, PPT, or temp read
Update naming for clarity

Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Austin Zheng <Austin.Zheng@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
---
 .../dml21/src/dml2_core/dml2_core_dcn4_calcs.c |  2 +-
 .../src/dml2_core/dml2_core_shared_types.h     | 18 ++++++++++++------
 .../dml21/src/dml2_core/dml2_core_utils.c      |  2 ++
 3 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4_calcs.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
index f809c4073b43..e7a0f46e1289 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
@@ -13024,7 +13024,7 @@ void dml2_core_calcs_get_informative(const struct dml2_core_internal_display_mod
 	out->informative.mode_support_info.InvalidCombinationOfMALLUseForPState = mode_lib->ms.support.InvalidCombinationOfMALLUseForPState;
 	out->informative.mode_support_info.ExceededMALLSize = mode_lib->ms.support.ExceededMALLSize;
 	out->informative.mode_support_info.EnoughWritebackUnits = mode_lib->ms.support.EnoughWritebackUnits;
-	out->informative.mode_support_info.temp_read_or_ppt_support = mode_lib->ms.support.temp_read_or_ppt_support;
+	out->informative.mode_support_info.temp_read_or_ppt_support = mode_lib->ms.support.global_temp_read_or_ppt_supported;
 	out->informative.mode_support_info.g6_temp_read_support = mode_lib->ms.support.g6_temp_read_support;
 
 	out->informative.mode_support_info.ExceededMultistreamSlots = mode_lib->ms.support.ExceededMultistreamSlots;
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_shared_types.h b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_shared_types.h
index 051c31ec2f0e..6d13d4c9b69a 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_shared_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_shared_types.h
@@ -264,8 +264,11 @@ struct dml2_core_internal_mode_support_info {
 	bool DCCMetaBufferSizeNotExceeded;
 	enum dml2_pstate_change_support DRAMClockChangeSupport[DML2_MAX_PLANES];
 	enum dml2_pstate_change_support FCLKChangeSupport[DML2_MAX_PLANES];
+	enum dml2_pstate_change_support temp_read_or_ppt_support[DML2_MAX_PLANES];
+	bool global_dram_clock_change_support_required;
 	bool global_dram_clock_change_supported;
 	bool global_fclk_change_supported;
+	bool global_temp_read_or_ppt_supported;
 	bool USRRetrainingSupport;
 	bool AvgBandwidthSupport;
 	bool UrgVactiveBandwidthSupport;
@@ -336,7 +339,6 @@ struct dml2_core_internal_mode_support_info {
 	bool incorrect_imall_usage;
 
 	bool g6_temp_read_support;
-	bool temp_read_or_ppt_support;
 
 	struct dml2_core_internal_watermarks watermarks;
 	bool dcfclk_support;
@@ -646,7 +648,7 @@ struct dml2_core_internal_mode_support {
 	unsigned int DSTYAfterScaler[DML2_MAX_PLANES];
 	unsigned int DSTXAfterScaler[DML2_MAX_PLANES];
 
-	enum dml2_pstate_method pstate_switch_modes[DML2_MAX_PLANES];
+	enum dml2_pstate_method uclk_pstate_switch_modes[DML2_MAX_PLANES];
 };
 
 /// @brief A mega structure that houses various info for model programming step.
@@ -837,6 +839,7 @@ struct dml2_core_internal_mode_program {
 	double max_urgent_latency_us;
 	double df_response_time_us;
 
+	enum dml2_pstate_method uclk_pstate_switch_modes[DML2_MAX_PLANES];
 	// -------------------
 	// Output
 	// -------------------
@@ -963,11 +966,12 @@ struct dml2_core_internal_mode_program {
 	double MaxActiveFCLKChangeLatencySupported;
 	bool USRRetrainingSupport;
 	bool g6_temp_read_support;
-	bool temp_read_or_ppt_support;
 	enum dml2_pstate_change_support FCLKChangeSupport[DML2_MAX_PLANES];
 	enum dml2_pstate_change_support DRAMClockChangeSupport[DML2_MAX_PLANES];
+	enum dml2_pstate_change_support temp_read_or_ppt_support[DML2_MAX_PLANES];
 	bool global_dram_clock_change_supported;
 	bool global_fclk_change_supported;
+	bool global_temp_read_or_ppt_supported;
 	double MaxActiveDRAMClockChangeLatencySupported[DML2_MAX_PLANES];
 	double WritebackAllowFCLKChangeEndPosition[DML2_MAX_PLANES];
 	double WritebackAllowDRAMClockChangeEndPosition[DML2_MAX_PLANES];
@@ -1313,7 +1317,7 @@ struct dml2_core_calcs_CalculateVMRowAndSwath_params {
 	unsigned int HostVMMinPageSize;
 	unsigned int DCCMetaBufferSizeBytes;
 	bool mrq_present;
-	enum dml2_pstate_method *pstate_switch_modes;
+	enum dml2_pstate_method *uclk_pstate_switch_modes;
 
 	// Output
 	bool *PTEBufferSizeNotExceeded;
@@ -1740,10 +1744,12 @@ struct dml2_core_calcs_CalculateWatermarksMALLUseAndDRAMSpeedChangeSupport_param
 	unsigned int max_request_size_bytes;
 	unsigned int *meta_row_height_l;
 	unsigned int *meta_row_height_c;
+	enum dml2_pstate_method *uclk_pstate_switch_modes;
 
 	// Output
 	struct dml2_core_internal_watermarks *Watermark;
 	enum dml2_pstate_change_support *DRAMClockChangeSupport;
+	bool *global_dram_clock_change_support_required;
 	bool *global_dram_clock_change_supported;
 	double *MaxActiveDRAMClockChangeLatencySupported;
 	unsigned int *SubViewportLinesNeededInMALL;
@@ -1754,10 +1760,10 @@ struct dml2_core_calcs_CalculateWatermarksMALLUseAndDRAMSpeedChangeSupport_param
 	double *VActiveLatencyHidingMargin;
 	double *VActiveLatencyHidingUs;
 	bool *g6_temp_read_support;
-	bool *temp_read_or_ppt_support;
+	enum dml2_pstate_change_support *temp_read_or_ppt_support;
+	bool *global_temp_read_or_ppt_supported;
 };
 
-
 struct dml2_core_calcs_CalculateSwathAndDETConfiguration_params {
 	const struct dml2_display_cfg *display_cfg;
 	unsigned int ConfigReturnBufferSizeInKByte;
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_utils.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_utils.c
index 5f301befed16..b57d0f6ea6a1 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_utils.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_utils.c
@@ -306,6 +306,8 @@ void dml2_core_utils_print_mode_support_info(const struct dml2_core_internal_mod
 		DML_LOG_VERBOSE("DML: support: ExceededMALLSize = %d\n", support->ExceededMALLSize);
 	if (!fail_only || support->g6_temp_read_support == 0)
 		DML_LOG_VERBOSE("DML: support: g6_temp_read_support = %d\n", support->g6_temp_read_support);
+	if (!fail_only || (support->global_dram_clock_change_supported == 0 && support->global_dram_clock_change_support_required))
+		DML_LOG_VERBOSE("DML: support: dram_clock_change_support = %d\n", support->global_dram_clock_change_supported);
 	if (!fail_only || support->ImmediateFlipSupport == 0)
 		DML_LOG_VERBOSE("DML: support: ImmediateFlipSupport = %d\n", support->ImmediateFlipSupport);
 	if (!fail_only || support->LinkCapacitySupport == 0)
-- 
2.43.0

