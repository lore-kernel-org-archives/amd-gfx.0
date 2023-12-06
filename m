Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CD1CC4167B
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Dec 2023 19:52:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E64AA10E508;
	Wed,  6 Dec 2023 19:52:47 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A66C10E630
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Dec 2023 19:52:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PDpmRRyS1A0cC0pMcyA1sEJgwlb1HGEon0kXW4PtsFXo/JaT3bonR6jugKdepzATCyLWynkOpXV0cSVRn5OT+n836AFC8RkLODvN0rvk7xXOKGhqlb0b1vzxHPi+uUM2P4/GXNWtwEIeRP6J97MIFOBMZm0ZhTEPh3yavjld09EkZr0fE+J+hFqLwW0KsLMEuhK61HO3bJERskis1mxQUI/niVJuNn+ucBScMV8U6mXG4B8a0p76gkRJM7gIwfR9aCg/nxGGD+UY9CwMNIoF0YSWEZFUQWIYsS10z/Tr2QF+eJzscTH9kiokLOxKrcGdg/bO8ioUcqFg69AuSJNDIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FvDpD7u2AxltewFpUAbDkGPm5ZeVZCqRvrUIixIqW0U=;
 b=hp/cXau2F9xYnzkaFqVhZzf5cSYDWBbuYJPvZ/33yp0J0pWksveITL1Qo+Hx0153DxUVtLTLNlj5KtZf15W19J2x1I3gI0G5tj8RIgSy2ao+Lu8nfbAm403XoGJYtfNFFWD38IzptFCoQepu5Iw+P8AjRFQVUJ5dkJiDBVq3JnT/+LPtF8WpX0E+SgQ1aZeSCfsVJY6yFxUnSLf7YR9sIYaix1WK5/Co03dFZ8IgW9bWISqFOiMD35sKNFqrzqLDDMxXOWG4rOSgU0cg1AawhfwI4flY2XQB3HrE5gD8KDHrkwry8lY/ySPzmhJQ1WCxicbCxcEu5BUL94kvdXqubA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FvDpD7u2AxltewFpUAbDkGPm5ZeVZCqRvrUIixIqW0U=;
 b=QC3JwDy7FA0vUMiFhGjJicVTlKwlW9Wu/fWNZ8vTqS8rYCpD8zifpXZ1Hu/BeslvVDCrV8cIbofEM7++2AGf2Sm0baW+a6U08S93+1N7bsR+uiij7aY4MzB1G8Aid7iQaZaJ2RRErJgcVVVIJVwgCR4lpi9/yoZDRJVT7viC9pA=
Received: from CY5PR15CA0167.namprd15.prod.outlook.com (2603:10b6:930:81::13)
 by SJ2PR12MB7868.namprd12.prod.outlook.com (2603:10b6:a03:4cd::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Wed, 6 Dec
 2023 19:52:41 +0000
Received: from CY4PEPF0000EE3F.namprd03.prod.outlook.com
 (2603:10b6:930:81:cafe::72) by CY5PR15CA0167.outlook.office365.com
 (2603:10b6:930:81::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.25 via Frontend
 Transport; Wed, 6 Dec 2023 19:52:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000EE3F.mail.protection.outlook.com (10.167.242.19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7068.26 via Frontend Transport; Wed, 6 Dec 2023 19:52:41 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 6 Dec
 2023 13:52:38 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 6 Dec
 2023 13:52:38 -0600
Received: from debaura-ryzen.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Wed, 6 Dec 2023 13:52:38 -0600
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 04/13] drm/amd/display: Revert "Fix conversions between bytes
 and KB"
Date: Wed, 6 Dec 2023 14:52:25 -0500
Message-ID: <20231206195234.182989-5-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231206195234.182989-1-aurabindo.pillai@amd.com>
References: <20231206195234.182989-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3F:EE_|SJ2PR12MB7868:EE_
X-MS-Office365-Filtering-Correlation-Id: 9864637e-896b-44a4-32dc-08dbf694e82e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rcuWelBOMJpQdjZlRcJeKvnxJlVaLqkeno2Fn+3Vv4kUezJUJ9JzDhU8HPpS1E3w6ElTr7NL3+T/nDpUzuJ8zMzl7fH8H2Ggn7mLlrYx6zRRE+iWS23fTWyBtjIypDg/M+DWR8Q4aAu47cZQZzikYDqcaSk1DkahVfzFhtxVoPLKfFYRVCbh5AC2z8+qBCH1t2MijnYB1t5qWx+hG4+BE7IJ9FZSTLgCKUlxF79nwfxop2FlnPG2HbuZmR8hO3zq1JFso1aQO+LF+52vUFh+058NYy+bumE3n+1kgCvO/HqhzRTV+6DeIr4xQtJhWbU7Susj5ffEmfVua3gMmfvP1nOSc0/7Gbv3XBQ7Su1IhAe9Coxm6AvgEpSO1kzw09+IYk4f/jBxeNhjo+q56LEa7UnVvn8pqO4iLewQD+ulYKh9t22Lrcbabc7kw3rQFbR7DpEBdfmAqt00V86nKHzms953jdm/eYRhQw5L5u70aOSQ4QdyJcTX99BmmmlQ8wvIgftnLhsZeSeM72d7Ext8q54XMpMe61Kapju5DkqtQycQ3ubNU3NB3eouslfSKLs8KB20pMBQ7T0UIFGaJrVh4IHL2BjA5udtz+8xGvCTBjIzWmxArGwqg/lP/RcV+hM+bSn8uCP6z82j9f3K2DNFnL4sZ1uK7KGcsjObaksBYjvbHiPC/n9kE16xDLa0thRHWvE64drf/0OnwiX2DQwMTdvNKaEU9B0T/z0qRz2eEyxVNakPyLLgk+ORlxYpLlc/LHQWh4HRNKEkk0Ml2Vj5QlTNuk3zcE9FQUm8CYlK4Iyfvvs5xAWh7Sz7p90doJ8BmNVjJ5Ax/43V0LZ9r38kNe+HGA/wKXsXwcVJFVXf6Gs=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(39860400002)(136003)(346002)(376002)(230922051799003)(82310400011)(186009)(64100799003)(1800799012)(451199024)(46966006)(40470700004)(36840700001)(6916009)(70206006)(54906003)(316002)(70586007)(6666004)(40460700003)(478600001)(5660300002)(41300700001)(36756003)(2906002)(4326008)(8936002)(44832011)(86362001)(83380400001)(2616005)(36860700001)(47076005)(81166007)(356005)(8676002)(426003)(26005)(336012)(82740400003)(1076003)(40480700001)(7696005)(36900700001)(44824005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2023 19:52:41.2897 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9864637e-896b-44a4-32dc-08dbf694e82e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7868
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
Cc: stylon.wang@amd.com, chiahsuan.chung@amd.com, Sunpeng.Li@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 Taimur Hassan <syed.hassan@amd.com>, jerry.zuo@amd.com,
 Aurabindo.Pillai@amd.com, hersenxs.wu@amd.com, wayne.lin@amd.com,
 Harry.Wentland@amd.com, Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 agustin.gutierrez@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Taimur Hassan <syed.hassan@amd.com>

[Why & How]
HostVMMinPageSize is expected to be in KB according to spec,
the checks later down the line reflect this as well.

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Taimur Hassan <syed.hassan@amd.com>
---
 .../drm/amd/display/dc/dml2/display_mode_core.c  | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/display_mode_core.c b/drivers/gpu/drm/amd/display/dc/dml2/display_mode_core.c
index 4d1336e5afc2..180f8a98a361 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/display_mode_core.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/display_mode_core.c
@@ -6329,7 +6329,7 @@ static void dml_prefetch_check(struct display_mode_lib_st *mode_lib)
 				mode_lib->ms.NoOfDPPThisState,
 				mode_lib->ms.dpte_group_bytes,
 				s->HostVMInefficiencyFactor,
-				mode_lib->ms.soc.hostvm_min_page_size_kbytes * 1024,
+				mode_lib->ms.soc.hostvm_min_page_size_kbytes,
 				mode_lib->ms.cache_display_cfg.plane.HostVMMaxPageTableLevels);
 
 		s->NextMaxVStartup = s->MaxVStartupAllPlanes[j];
@@ -6542,7 +6542,7 @@ static void dml_prefetch_check(struct display_mode_lib_st *mode_lib)
 						mode_lib->ms.cache_display_cfg.plane.HostVMEnable,
 						mode_lib->ms.cache_display_cfg.plane.HostVMMaxPageTableLevels,
 						mode_lib->ms.cache_display_cfg.plane.GPUVMEnable,
-						mode_lib->ms.soc.hostvm_min_page_size_kbytes * 1024,
+						mode_lib->ms.soc.hostvm_min_page_size_kbytes,
 						mode_lib->ms.PDEAndMetaPTEBytesPerFrame[j][k],
 						mode_lib->ms.MetaRowBytes[j][k],
 						mode_lib->ms.DPTEBytesPerRow[j][k],
@@ -7687,7 +7687,7 @@ dml_bool_t dml_core_mode_support(struct display_mode_lib_st *mode_lib)
 		CalculateVMRowAndSwath_params->HostVMMaxNonCachedPageTableLevels = mode_lib->ms.cache_display_cfg.plane.HostVMMaxPageTableLevels;
 		CalculateVMRowAndSwath_params->GPUVMMaxPageTableLevels = mode_lib->ms.cache_display_cfg.plane.GPUVMMaxPageTableLevels;
 		CalculateVMRowAndSwath_params->GPUVMMinPageSizeKBytes = mode_lib->ms.cache_display_cfg.plane.GPUVMMinPageSizeKBytes;
-		CalculateVMRowAndSwath_params->HostVMMinPageSize = mode_lib->ms.soc.hostvm_min_page_size_kbytes * 1024;
+		CalculateVMRowAndSwath_params->HostVMMinPageSize = mode_lib->ms.soc.hostvm_min_page_size_kbytes;
 		CalculateVMRowAndSwath_params->PTEBufferModeOverrideEn = mode_lib->ms.cache_display_cfg.plane.PTEBufferModeOverrideEn;
 		CalculateVMRowAndSwath_params->PTEBufferModeOverrideVal = mode_lib->ms.cache_display_cfg.plane.PTEBufferMode;
 		CalculateVMRowAndSwath_params->PTEBufferSizeNotExceeded = mode_lib->ms.PTEBufferSizeNotExceededPerState;
@@ -7957,7 +7957,7 @@ dml_bool_t dml_core_mode_support(struct display_mode_lib_st *mode_lib)
 		UseMinimumDCFCLK_params->GPUVMMaxPageTableLevels = mode_lib->ms.cache_display_cfg.plane.GPUVMMaxPageTableLevels;
 		UseMinimumDCFCLK_params->HostVMEnable = mode_lib->ms.cache_display_cfg.plane.HostVMEnable;
 		UseMinimumDCFCLK_params->NumberOfActiveSurfaces = mode_lib->ms.num_active_planes;
-		UseMinimumDCFCLK_params->HostVMMinPageSize = mode_lib->ms.soc.hostvm_min_page_size_kbytes * 1024;
+		UseMinimumDCFCLK_params->HostVMMinPageSize = mode_lib->ms.soc.hostvm_min_page_size_kbytes;
 		UseMinimumDCFCLK_params->HostVMMaxNonCachedPageTableLevels = mode_lib->ms.cache_display_cfg.plane.HostVMMaxPageTableLevels;
 		UseMinimumDCFCLK_params->DynamicMetadataVMEnabled = mode_lib->ms.ip.dynamic_metadata_vm_enabled;
 		UseMinimumDCFCLK_params->ImmediateFlipRequirement = s->ImmediateFlipRequiredFinal;
@@ -8699,7 +8699,7 @@ void dml_core_mode_programming(struct display_mode_lib_st *mode_lib, const struc
 	CalculateVMRowAndSwath_params->HostVMMaxNonCachedPageTableLevels = mode_lib->ms.cache_display_cfg.plane.HostVMMaxPageTableLevels;
 	CalculateVMRowAndSwath_params->GPUVMMaxPageTableLevels = mode_lib->ms.cache_display_cfg.plane.GPUVMMaxPageTableLevels;
 	CalculateVMRowAndSwath_params->GPUVMMinPageSizeKBytes = mode_lib->ms.cache_display_cfg.plane.GPUVMMinPageSizeKBytes;
-	CalculateVMRowAndSwath_params->HostVMMinPageSize = mode_lib->ms.soc.hostvm_min_page_size_kbytes * 1024;
+	CalculateVMRowAndSwath_params->HostVMMinPageSize = mode_lib->ms.soc.hostvm_min_page_size_kbytes;
 	CalculateVMRowAndSwath_params->PTEBufferModeOverrideEn = mode_lib->ms.cache_display_cfg.plane.PTEBufferModeOverrideEn;
 	CalculateVMRowAndSwath_params->PTEBufferModeOverrideVal = mode_lib->ms.cache_display_cfg.plane.PTEBufferMode;
 	CalculateVMRowAndSwath_params->PTEBufferSizeNotExceeded = s->dummy_boolean_array[0];
@@ -8805,7 +8805,7 @@ void dml_core_mode_programming(struct display_mode_lib_st *mode_lib, const struc
 			mode_lib->ms.cache_display_cfg.hw.DPPPerSurface,
 			locals->dpte_group_bytes,
 			s->HostVMInefficiencyFactor,
-			mode_lib->ms.soc.hostvm_min_page_size_kbytes * 1024,
+			mode_lib->ms.soc.hostvm_min_page_size_kbytes,
 			mode_lib->ms.cache_display_cfg.plane.HostVMMaxPageTableLevels);
 
 	locals->TCalc = 24.0 / locals->DCFCLKDeepSleep;
@@ -8995,7 +8995,7 @@ void dml_core_mode_programming(struct display_mode_lib_st *mode_lib, const struc
 			CalculatePrefetchSchedule_params->GPUVMEnable = mode_lib->ms.cache_display_cfg.plane.GPUVMEnable;
 			CalculatePrefetchSchedule_params->HostVMEnable = mode_lib->ms.cache_display_cfg.plane.HostVMEnable;
 			CalculatePrefetchSchedule_params->HostVMMaxNonCachedPageTableLevels = mode_lib->ms.cache_display_cfg.plane.HostVMMaxPageTableLevels;
-			CalculatePrefetchSchedule_params->HostVMMinPageSize = mode_lib->ms.soc.hostvm_min_page_size_kbytes * 1024;
+			CalculatePrefetchSchedule_params->HostVMMinPageSize = mode_lib->ms.soc.hostvm_min_page_size_kbytes;
 			CalculatePrefetchSchedule_params->DynamicMetadataEnable = mode_lib->ms.cache_display_cfg.plane.DynamicMetadataEnable[k];
 			CalculatePrefetchSchedule_params->DynamicMetadataVMEnabled = mode_lib->ms.ip.dynamic_metadata_vm_enabled;
 			CalculatePrefetchSchedule_params->DynamicMetadataLinesBeforeActiveRequired = mode_lib->ms.cache_display_cfg.plane.DynamicMetadataLinesBeforeActiveRequired[k];
@@ -9240,7 +9240,7 @@ void dml_core_mode_programming(struct display_mode_lib_st *mode_lib, const struc
 						mode_lib->ms.cache_display_cfg.plane.HostVMEnable,
 						mode_lib->ms.cache_display_cfg.plane.HostVMMaxPageTableLevels,
 						mode_lib->ms.cache_display_cfg.plane.GPUVMEnable,
-						mode_lib->ms.soc.hostvm_min_page_size_kbytes * 1024,
+						mode_lib->ms.soc.hostvm_min_page_size_kbytes,
 						locals->PDEAndMetaPTEBytesFrame[k],
 						locals->MetaRowByte[k],
 						locals->PixelPTEBytesPerRow[k],
-- 
2.39.2

