Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAC31C54E65
	for <amd-gfx@archiver.kernel.org>; Thu, 22 May 2025 04:45:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C28BC14A587;
	Thu, 22 May 2025 04:27:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GgxZ6MJm";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2078.outbound.protection.outlook.com [40.107.244.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 10640937E1
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 May 2025 03:45:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Iejpk+ErX5LizgqxrrtDC/Y1Q/dBfomA7s3HKqAvwKHYpXizzRErXXY/9ItAU/GowKLTuSItB3iV6a8NdmJhV8bmSLN7tS8jQEjYIi7M+h9t7AqvmXI1Sg8YQudS0TLw8uPK8ggahwLThhIH6UNK/Gl9uH7RiGJIRBkbYn6H1glzuKLjj75YQgWmd5qBtew6u0HdmUvzKccJQZ3fZUthOcsKsCgKm4iGaP0EdC8eHeBWDDy3Agbw0nXBrQMva1Tiq+BpcKDS4N/2eJS58mwUau3qK6GACTPz8Kea3KTiwO+rF6/iDpWYhePf8tBqVAXz2C0ijc02P4xuImUUd+2VGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x16c9WL4YO7ta2ep+cZphMjuceP48s98Au1E3Ft2xz0=;
 b=RyRxx15I480EjOdTQ3F9L57rNhq6MgwXv4sjVw1FF0iJY0V6oAZ9UqR9ULuoOXzQJdt148ba1p6x/uGJjLjfDDOb4mI+zutxSbh6jGFNLGmyxEzwesg6PTQ6tsbiy/4T8OuazlJTPgN6Y3hBXMI4k5fGctW8OVlJbCEFXGYYunRmuzPTPeQnY2rQNlVRYh/65z9cGu2oi74clzlrxRphlWWf/zG9M5BbgnQ4qqFLWOZRH2hi5nhkYyN17QRD2fmb/IendnQWyI0Ru/tQXMIHccFb9M84uS4pR4m7k1jBCVuQ3Gjz77hvOTqiU4Qgmo75Qs8vF8rxN0IjkyOjNygBLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x16c9WL4YO7ta2ep+cZphMjuceP48s98Au1E3Ft2xz0=;
 b=GgxZ6MJmEKkCrQ/Ti0ypXMXb9xaXMRSS4rmDGsaP0P0FfpILq4eIWeiKlnTp2JXEauWB33470ha48wYu79tF7eXJHiBZmGdSx/j03k3EoMg2sF6U0rigE7aP03cwpUxppWEvioPrYqbRsiW/NP9jf4Ces97sCUf4NuKpiIhi/5Q=
Received: from CH5PR02CA0024.namprd02.prod.outlook.com (2603:10b6:610:1ed::6)
 by CY5PR12MB6478.namprd12.prod.outlook.com (2603:10b6:930:35::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.31; Thu, 22 May
 2025 03:44:58 +0000
Received: from CH3PEPF0000000A.namprd04.prod.outlook.com
 (2603:10b6:610:1ed:cafe::23) by CH5PR02CA0024.outlook.office365.com
 (2603:10b6:610:1ed::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.19 via Frontend Transport; Thu,
 22 May 2025 03:44:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH3PEPF0000000A.mail.protection.outlook.com (10.167.244.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Thu, 22 May 2025 03:44:56 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 21 May
 2025 22:44:56 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 21 May
 2025 22:44:56 -0500
Received: from hjbog-srdc-17.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 21 May 2025 22:44:48 -0500
From: Samuel Zhang <guoqing.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <victor.zhao@amd.com>, <haijun.chang@amd.com>, <guoqing.zhang@amd.com>,
 <Christian.Koenig@amd.com>, <Alexander.Deucher@amd.com>,
 <Owen.Zhang2@amd.com>, <Qing.Ma@amd.com>, <Lijo.Lazar@amd.com>,
 <Emily.Deng@amd.com>, Jiang Liu <gerry@linux.alibaba.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH v7 1/4] drm/amdgpu: update xgmi info and vram_base_offset on
 resume
Date: Thu, 22 May 2025 11:43:47 +0800
Message-ID: <20250522034350.433219-2-guoqing.zhang@amd.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250522034350.433219-1-guoqing.zhang@amd.com>
References: <20250522034350.433219-1-guoqing.zhang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: None (SATLEXMB05.amd.com: guoqing.zhang@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000A:EE_|CY5PR12MB6478:EE_
X-MS-Office365-Filtering-Correlation-Id: a2172b4d-025c-4aef-cf9f-08dd98e3053c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?U2J6Qm5DRENzN1MrekdPWWxRNnlmSjZVOU4vZHVJa1pWaFR4amR0N0xTY25C?=
 =?utf-8?B?c2d5Um41TlF0azdPRXlBcjEzY0lRd3d3Z3cySTY0am01SlVVWWhxQ2I4U2lx?=
 =?utf-8?B?N3h2TUhTR200bDFQRDFJMHVQcGlqY2R5TjM5UjJ6N0tVcVNSMXZ5T2Q3N2pQ?=
 =?utf-8?B?cGx5czBoRGlvUU00REtKYjQ0eEJuTlh4NVhpTU9Cb0xaZG5DV1RNRjhnVytI?=
 =?utf-8?B?UzYySUpyS1FEZk1pK0RndmJFR3pGeEZYeG40dkZLcmJLSzZXbmh4QmFkYkdW?=
 =?utf-8?B?U0JFck9NL1NEaUdSWms5ZlZmQm9xMlFpWDlrMko1VmhZUjJ5eHc3SHB5eHpP?=
 =?utf-8?B?anZYMW9meC9WdWt0UTVpNmdsdVJPZ3VPdG5mMUtNam00azUvMkFqVSt1Rk8z?=
 =?utf-8?B?djdudU9ISGFEUUJCczNNNklkbGNPSG9PY0puRC9nNWFDZ2p4NndzY3FwSUxD?=
 =?utf-8?B?U2JMajJSMTJ0SUVKd0FnYVVpWXBJMFU3ZWJOdm9jdmxFUng3WnRCUVRWYWVE?=
 =?utf-8?B?UGN4Y3czWlNUTUdTLzVIQW9Xa1QwckdPTTRLMk1wcVBUYWtQZXRDY0Qza3lV?=
 =?utf-8?B?cS9rbDExa1ZQVjR5NVgydWtyOGhHZm84R0pyQkNrT0ErU0tDQWhDUzJqaEdm?=
 =?utf-8?B?R1dadXJWNG8rN3A4OGJKbWM5aGdmeXYrSWZSNlkwNDBqWTFLbkVPS1BlcUZH?=
 =?utf-8?B?K3k5aHhWcGRHZ2Z2TGdFWko0cCs0UzFVL1I0WTgwaWF1czZKMFk4eVg2VGox?=
 =?utf-8?B?d0hKRnlUcmd4VlV3RWNCS2J4S1VjSzFlbjJWbSsyZlY1SWR3SVA5L2lORndW?=
 =?utf-8?B?MHFvczNGRDg3elRTY0pPZHM0SXBYOG5hMUdRcnJQaTdkS2szNDdRa1gzMzJ1?=
 =?utf-8?B?QUpkd0ovNk02L2cwYm9wUlorY0tHSzRyYnB4ODZhTzIxUHlsR1lJTmZuT0ts?=
 =?utf-8?B?cVFjZ2NpcDZJZHpPdlRYNXJvMGZOSnNjb3VkN3FVb0FpUXZvWGFVQ1U4Ymt3?=
 =?utf-8?B?VlU4WTk2UUloVGhyN2dDeW1RWHlUa1FGUG42SnVvOWdqZldFS1dDbUZtZnBO?=
 =?utf-8?B?NTVhMlNEdTV6amRtaEpnUWVlY0tPQ0xXOWpTSEdSNlpEVFlOd0tKVUVWNi9W?=
 =?utf-8?B?cXBUYWFnMWd6dmhVdXVJdnJuWnBhT3gwcXVSdytET2xnMWhrbXJqYXBLcVpQ?=
 =?utf-8?B?SldkV2VvbFpCcVY1NThMd0FWMy9sTUE3RThHVTNlR0JMUmJBSUczQmxjSVdi?=
 =?utf-8?B?Qll0eUF3TzNYZk5FNGpIQmVHK1QzUzYzUWw3cC9nOEtzWGJZcHlCR0ZlRWov?=
 =?utf-8?B?ZVI5Ym54K3JtVEFCOW1Qa3ZpRHRNVEZKaFc1ZHFrU01GV3pNYjJUSGl5Y25q?=
 =?utf-8?B?K1hYaEwvNjVleldndThKNklwWmh6RlFOa0JuYmFlcU0xam0zbGdiZnAzMzdI?=
 =?utf-8?B?bHpvQUV0RlcxR1FTdmlvamVzYmhvSFNvSEl4MlZ0S0NPeHR0L1VORStrTjZV?=
 =?utf-8?B?ZTVhTEpkZkVVb0M1bWQyd1QyU2ZIZElVY20rMzFDcXd2WlUzbWVQNFZHVXda?=
 =?utf-8?B?eHFWQWxDYks5T3lucUpucU1Ram9EN3FhNmhwdElYYzhLaHNvTVZvSDlvUHp0?=
 =?utf-8?B?S1ZjYmFOdlcrUVR5eG9DWjdnNTdEYUxpaUFYdE5NMGNRdktySExIWVkvOTV0?=
 =?utf-8?B?cHBGRmkrYy85dU1FajVFbEhKemN4WHBjVkVUbE8xV1Jud0JweXJvNzlSUVBJ?=
 =?utf-8?B?bWNBeFl0QTZTb0dkSG41SzQzdWpTS2VXUUM5RWdFMGVXMVNGdGZBTUlEb2JK?=
 =?utf-8?B?UDVxWmdRR0FRSEJPTHNPQkFCTFpZWE1oRjA4bG1JcWN6S0Q5REVIaHk4UWx4?=
 =?utf-8?B?UTl3Uk1EaXBGUkI3SnJVMGxwVEFveDBMN2dJQnJqVmh2WWpSQTJ1Y0oxMlY4?=
 =?utf-8?B?MXJnM3VlS2pyeThVRXRDTDNRejZ4YWtRRUZieEd6S3BwY1M3TWVLdWlFdTJa?=
 =?utf-8?B?cWxYQjVlWjZISGRjbHZTbUVYd2ZTM085V3Q0RFdZcE5VbXp0NjQ5dnc5ZkM1?=
 =?utf-8?Q?5A/NwS?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2025 03:44:56.8784 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a2172b4d-025c-4aef-cf9f-08dd98e3053c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6478
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

For SRIOV VM env with XGMI enabled systems, XGMI physical node id may
change when hibernate and resume with different VF.

Update XGMI info and vram_base_offset on resume for gfx444 SRIOV env.
Add amdgpu_virt_xgmi_migrate_enabled() as the feature flag.

Signed-off-by: Jiang Liu <gerry@linux.alibaba.com>
Signed-off-by: Samuel Zhang <guoqing.zhang@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 32 ++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h   |  7 +++++
 2 files changed, 39 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index d477a901af84..e5bb46effb6c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2732,6 +2732,12 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
 	if (!amdgpu_device_pcie_dynamic_switching_supported(adev))
 		adev->pm.pp_feature &= ~PP_PCIE_DPM_MASK;
 
+	adev->virt.is_xgmi_node_migrate_enabled = false;
+	if (amdgpu_sriov_vf(adev)) {
+		adev->virt.is_xgmi_node_migrate_enabled =
+			amdgpu_ip_version((adev), GC_HWIP, 0) == IP_VERSION(9, 4, 4);
+	}
+
 	total = true;
 	for (i = 0; i < adev->num_ip_blocks; i++) {
 		ip_block = &adev->ip_blocks[i];
@@ -5040,6 +5046,28 @@ int amdgpu_device_suspend(struct drm_device *dev, bool notify_clients)
 	return 0;
 }
 
+static inline int amdgpu_virt_resume(struct amdgpu_device *adev)
+{
+	int r;
+	unsigned int prev_physical_node_id = adev->gmc.xgmi.physical_node_id;
+
+	if (!amdgpu_virt_xgmi_migrate_enabled(adev))
+		return 0;
+
+	r = adev->gfxhub.funcs->get_xgmi_info(adev);
+	if (r)
+		return r;
+
+	dev_info(adev->dev, "xgmi node, old id %d, new id %d\n",
+		prev_physical_node_id, adev->gmc.xgmi.physical_node_id);
+
+	adev->vm_manager.vram_base_offset = adev->gfxhub.funcs->get_mc_fb_offset(adev);
+	adev->vm_manager.vram_base_offset +=
+		adev->gmc.xgmi.physical_node_id * adev->gmc.xgmi.node_segment_size;
+
+	return 0;
+}
+
 /**
  * amdgpu_device_resume - initiate device resume
  *
@@ -5061,6 +5089,10 @@ int amdgpu_device_resume(struct drm_device *dev, bool notify_clients)
 			return r;
 	}
 
+	r = amdgpu_virt_resume(adev);
+	if (r)
+		goto exit;
+
 	if (dev->switch_power_state == DRM_SWITCH_POWER_OFF)
 		return 0;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
index df03dba67ab8..532b92628171 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
@@ -295,6 +295,9 @@ struct amdgpu_virt {
 	union amd_sriov_ras_caps ras_telemetry_en_caps;
 	struct amdgpu_virt_ras ras;
 	struct amd_sriov_ras_telemetry_error_count count_cache;
+
+	/* hibernate and resume with different VF feature for xgmi enabled system */
+	bool is_xgmi_node_migrate_enabled;
 };
 
 struct amdgpu_video_codec_info;
@@ -376,6 +379,10 @@ static inline bool is_virtual_machine(void)
 	((adev)->virt.gim_feature & AMDGIM_FEATURE_VCN_RB_DECOUPLE)
 #define amdgpu_sriov_is_mes_info_enable(adev) \
 	((adev)->virt.gim_feature & AMDGIM_FEATURE_MES_INFO_ENABLE)
+
+#define amdgpu_virt_xgmi_migrate_enabled(adev) \
+	((adev)->virt.is_xgmi_node_migrate_enabled)
+
 bool amdgpu_virt_mmio_blocked(struct amdgpu_device *adev);
 void amdgpu_virt_init_setting(struct amdgpu_device *adev);
 int amdgpu_virt_request_full_gpu(struct amdgpu_device *adev, bool init);
-- 
2.43.5

