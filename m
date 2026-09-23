Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34DDDC9830E
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Sep 2026 15:12:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9693410E5E6;
	Wed, 23 Sep 2026 15:12:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="oORbs0SG";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010000.outbound.protection.outlook.com [52.101.46.0])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 96BD910E4EB
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Sep 2026 15:12:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L3i7Fq7udQVnaRC0SGPW5JjeBoE/ChfyJDx1j7TBalvUN8Q3YPY7A993mLXqxG1H2HWBS12LyT5FQMJwoBpQaVQzl5KN+YVjwPrlLXO4P8knJldKM+6ziD7bHTQowi8wLJD7QudTHTZA5QX5C1XXpDCIxOobvwQMGucYw/OlNRVUO6BkQAH9JGDgW9Pie1GQuQEGQDOXtaj+aPhD6qjA2ZytJRJrMIh2ueLYAJ4Sh6qPfGgGOGSCeZB2D885+xLTzJQAdxoK+kivuMeId505aEkWyGAGKjG2vPmc10IxzZWOEljhc0KNh0rslXb0r1M3vfqeZU17aKceh0tyawKFNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n2DR3AhdfevGzdH2snmRCrWSF/YulW0/+A0troRpocs=;
 b=ydwvgnpNeH3Hdmdoe+nS+fWGZnWpxYtmzwwZKBjo2aoRbp6jGIIPgIFl6bAwqvenknqZoGkbJqU09ZpIaKol1hN4AXZxTob6GY1wdjVnla2uas6CCEqbO5MtdoWEx2sioYWx7LJx+XnNBK6vavx+f2Y/6x6i0EFR70t0qaphdkJbY7W6qtg75HC7J1g/KRIRtCde5NOUICqN5TKAPUz+CWP4WAsW1XwzYFbxpk2uMXhfjxsJ8uDNDyiPcJ0+IFfLfELttW8OtndRcm1ADt2TiAIQslIHv3L4fpPPYz+6pIGT3y/oje1CUpwfiDrTHBzf55g39/WUXIDHEbg+/OHzGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n2DR3AhdfevGzdH2snmRCrWSF/YulW0/+A0troRpocs=;
 b=oORbs0SGI4g92X7O2v1V+2Bfxh4AYyGUf/oP85O6xJ6YeT7Ca9Ymbqy5/7IwiPxZoEfB4bmgn0ueOaw8d+5kkkTYCrsF3ux2cZLuegQ1yi6HYIjhFHFzjYoPs88rx7OS5Hi4rOko1lfdJq5Npx6DPg5Kg5CDyhADKy2btV1AC8U=
Received: from SJ0PR05CA0159.namprd05.prod.outlook.com (2603:10b6:a03:339::14)
 by CH3PR12MB473303.namprd12.prod.outlook.com (2603:10b6:610:34c::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.17; Wed, 23 Sep
 2026 15:12:41 +0000
Received: from CO1PEPF000066E6.namprd05.prod.outlook.com
 (2603:10b6:a03:339:cafe::3) by SJ0PR05CA0159.outlook.office365.com
 (2603:10b6:a03:339::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.7 via Frontend Transport; Wed, 23
 Sep 2026 15:12:41 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000066E6.mail.protection.outlook.com (10.167.249.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Wed, 23 Sep 2026 15:12:40 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 23 Sep
 2026 10:12:38 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 23 Sep
 2026 10:12:38 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Wed, 23 Sep 2026 10:12:37 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Frank Min <Frank.Min@amd.com>, Likun Gao <Likun.Gao@amd.com>, "Hawking
 Zhang" <Hawking.Zhang@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 06/12] drm/amdgpu: add infrastructrure for handling mp5
 firmware
Date: Wed, 23 Sep 2026 11:12:20 -0400
Message-ID: <20260923151226.2778589-6-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260923151226.2778589-1-alexander.deucher@amd.com>
References: <20260923151226.2778589-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E6:EE_|CH3PR12MB473303:EE_
X-MS-Office365-Filtering-Correlation-Id: ec05fb92-f6ec-4a77-f748-08df19851c87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|23010399003|376014|1800799024|10067099003|56012099006|6133799003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: MfAanX78hEYB0KTnmm6RGL8oxXtlg4TqsuEDsfKG5LrJJNnvmDf6unDSHO5aVSAcQd+97U6ZutJrej7PMQDdKUHzwwhAAdQrtBdq6TocT28xsa6d+ChlBq68Rt1pWrUcD3J6QX0Ch5eTEIJXBXqgPg/VvNbWnPdZci3Vmw0jWRzYGhAdAjLV3noGaLmPuwRl6Rw2qqvOmbMZ+mKC0VwqxcO1Jeb/bcks3hfC2eBIWWYehLCmwjnOPb5gPEWKSuyNM+GoWP+nXIFEvKPpLVir1WVCDBKzEfVGZ/7PWqpqU9GZANPi0zFQN326gVgIqYf10/7c5pFScHynS+7YaZMfjp3M21QtCYemAZEUsYMp8wQxcYmkHShba08GA9fONMleuJkZoi+7SVi5NDOHcfBa2/tuby9+6PX68eVrvbEWGz8o8XAtnAAvM2W8hbwr/q93NKN6giilsKz+vpWXFrYYFdBpkwa55x696Ffm6TdPYX3dvt8+p8oshua1idl9HuhBTVk54qCwFlaz8R2RRwSkTZnLC+Jt8Avz63FUF7dAsPYklAeTqvUXb9fIEnHl950eHjwo7wcePybuflMs40GHi2mMVndFL2Q8R1HgPifQE12t66Iz1AA92eybeCQmXpucsI8usbGPGuR1bVqw6BEwBDyI5ry5kFnEbtDarOMJMNTvwg9nzkxTm7krjcd3jTeFx0rsh+9XGe0dZUI2n7DR3A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(23010399003)(376014)(1800799024)(10067099003)(56012099006)(6133799003)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 6C4hVneyHnXRBNPJO9RcNWVpxD23nHJKlBLBbAVz25BRP0f6l5FGsXPQyxoEETzTYadMF7ZPTv008R+QVRET8o2RFw5tb2XB8gJ2ER+hxMmO64KnyIX5VUrAVTZ+cfNtCdFyzTnDDM876nGsbFQmhoBDkR/c3mHGs5PROkp5PPAG7N+6/9u02P1JuJSCrP94QkihPUaQB1QAVs3x0/BQapFnDKzO3ZRi+rMiYkDla/mlyFizM1X2TnYG0ETkI+PB/EmUbwSAbuOl+Y9DalFX8hu3na3foSWTN4lMVt173sfPqIfoHUGFxtf1yO5wyMcmvOPQCUt6zSoSyWFLnNfSODY38RLnCrVFHC0DjYnBUy/dVzyFwwsmRYRUISWr0cFx4k7PSA+pfPFWjSHl9lLCBFnp5ssx2ZHuxsVv1BthulpuwG8lmo84QbmaQsFeMYER
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 15:12:40.8574 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ec05fb92-f6ec-4a77-f748-08df19851c87
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066E6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB473303
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

From: Frank Min <Frank.Min@amd.com>

Add framework for MP5 firmware.

Signed-off-by: Frank Min <Frank.Min@amd.com>
Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c   | 7 +++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c | 2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h | 1 +
 drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h   | 1 +
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h   | 2 ++
 5 files changed, 13 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 0b5e8373855aa..5db568fc24218 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -3753,6 +3753,9 @@ int amdgpu_psp_get_fw_type(struct amdgpu_firmware_info *ucode,
 	case AMDGPU_UCODE_ID_ISP:
 		*type = GFX_FW_TYPE_ISP;
 		break;
+	case AMDGPU_UCODE_ID_MP5:
+		*type = GFX_FW_TYPE_MP5;
+		break;
 	case AMDGPU_UCODE_ID_MAXIMUM:
 	default:
 		return -EINVAL;
@@ -3806,6 +3809,10 @@ static void psp_print_fw_hdr(struct psp_context *psp,
 		hdr = (struct common_firmware_header *)adev->pm.fw->data;
 		amdgpu_ucode_print_smc_hdr(hdr);
 		break;
+	case AMDGPU_UCODE_ID_MP5:
+		hdr = (struct common_firmware_header *)adev->pm.mp5_fw->data;
+		amdgpu_ucode_print_smc_hdr(hdr);
+		break;
 	default:
 		break;
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
index c07f6d8d36bbd..31c10e3046b37 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
@@ -753,6 +753,8 @@ const char *amdgpu_ucode_name(enum AMDGPU_UCODE_ID ucode_id)
 		return "RS64_MEC_P3_STACK";
 	case AMDGPU_UCODE_ID_ISP:
 		return "ISP";
+	case AMDGPU_UCODE_ID_MP5:
+		return "MP5";
 	default:
 		return "UNKNOWN UCODE";
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
index f316776fe950a..83e5f0627369d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
@@ -477,6 +477,7 @@ union amdgpu_firmware_header {
  */
 enum AMDGPU_UCODE_ID {
 	AMDGPU_UCODE_ID_CAP = 0,
+	AMDGPU_UCODE_ID_MP5,
 	AMDGPU_UCODE_ID_SDMA0,
 	AMDGPU_UCODE_ID_SDMA1,
 	AMDGPU_UCODE_ID_SDMA2,
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h b/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h
index 0803cfc445dc7..d54b9edcd5394 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h
+++ b/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h
@@ -322,6 +322,7 @@ enum psp_gfx_fw_type {
 	GFX_FW_TYPE_VPE                             = 102,
 	GFX_FW_TYPE_JPEG_RAM                        = 128,  /**< JPEG Command buffer */
 	GFX_FW_TYPE_P2S_TABLE                       = 129,
+	GFX_FW_TYPE_MP5                             = 158,  /* MP5 ucode    */
 	GFX_FW_TYPE_MAX
 };
 
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
index ed1e7385243db..64d68a905f86b 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
@@ -351,7 +351,9 @@ struct amdgpu_pm {
 	bool                    sysfs_initialized;
 	struct amdgpu_dpm       dpm;
 	const struct firmware	*fw;	/* SMC firmware */
+	const struct firmware	*mp5_fw;	/* MP5 firmware */
 	uint32_t                fw_version;
+	uint32_t                mp5_fw_version;
 	uint32_t                pcie_gen_mask;
 	uint32_t                pcie_mlw_mask;
 	struct amd_pp_display_configuration pm_display_cfg;/* set by dc */
-- 
2.55.0

