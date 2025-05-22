Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6748AC54E65
	for <amd-gfx@archiver.kernel.org>; Thu, 22 May 2025 10:41:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DF0DE10EC44;
	Thu, 22 May 2025 10:41:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UHShduTn";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2074.outbound.protection.outlook.com [40.107.93.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4DF4510EC44
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 May 2025 10:41:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jUVEKBl/IPTclrR4q9meY+ZbLnlDB0GqpnKwK32JleWnytKw4v25Sk3ggNE+QWVe1D59/1Psslp8ECHmGOPxwn++tbqD/wy7cKh8o7gh0k/dL3IbCii/NUQnv+XwLPUwiY/SBoLYeOYsFRk9r4wy7GIjLGeNBrmljlMTa0VCtWtwtR2/NdsQxAv/oGCnZzw+7/Qv3Bur4s8NsCErZuge2dPkQ7CUt/mtYn4v8F3Z3eips/dyBCgBqON0K3bwv+6/6n6Bcehk/jBDoTwLmJbdfVynQHxLuMjibum7A6UXpGku9oVLMyRDHnq9CdD3TOYE3F36uPGGnPZj/mYYD/Xwhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=luXkovkIgQwkYQ+8KtYMXqfBkuuiPh/RYnuH6S0fCSk=;
 b=DuYHjmt2DsAFXKeDw/XtH/jB1PA3s9FJCIMGTENpuR9Hdasgy0FRobW9db3wIiuD81F1ZTwVh8WdWG+Ja+GRWDCvBj1mv2YMuAzUlW9WTUzIQmKE7ddIiOTTY14VNdaHuFciU3jZdBYFnPjFURKtYZ4UDx52DX55Jn4KEQtwY32mZu78K3B4NXOJLaLbmA2DeEHO/S25mTf1XEq0fk6Ke3Rw+fPWr+bwufqGN7s86yRaQuTskGSv6gI4C22x5rUXbfBbjYJmKWwKRo2uTXKQiLdo3maYXHXXXvVdpS0ibbMPp9FIj0kAwXkQe44JxDXE7Y0+/bVTW0FR3tS+EmB5ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=luXkovkIgQwkYQ+8KtYMXqfBkuuiPh/RYnuH6S0fCSk=;
 b=UHShduTnBFfoTtVfYRswKoUG8ixDREFyUYrKb5tLilwGJBe6qL/g/sFH3X8ll3dY+RbHE4JwSVeVzGj5mhi/9qB1ktXh0Ars3bQRVgE/s3m/UJ172jlPSCMMnzZFYtXIDFjupzLvikw0ue0Oy1DzmcutpR8WbfVwbS3gL7U/3/8=
Received: from PH8P220CA0009.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:345::15)
 by BY5PR12MB4276.namprd12.prod.outlook.com (2603:10b6:a03:20f::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.20; Thu, 22 May
 2025 10:41:09 +0000
Received: from MWH0EPF000A6734.namprd04.prod.outlook.com
 (2603:10b6:510:345:cafe::20) by PH8P220CA0009.outlook.office365.com
 (2603:10b6:510:345::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.19 via Frontend Transport; Thu,
 22 May 2025 10:41:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 MWH0EPF000A6734.mail.protection.outlook.com (10.167.249.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Thu, 22 May 2025 10:41:08 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 22 May
 2025 05:41:07 -0500
Received: from hjbog-srdc-17.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 22 May 2025 05:40:59 -0500
From: Samuel Zhang <guoqing.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <victor.zhao@amd.com>, <haijun.chang@amd.com>, <guoqing.zhang@amd.com>,
 <Christian.Koenig@amd.com>, <Alexander.Deucher@amd.com>,
 <Owen.Zhang2@amd.com>, <Qing.Ma@amd.com>, <Lijo.Lazar@amd.com>,
 <Emily.Deng@amd.com>, Jiang Liu <gerry@linux.alibaba.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH v8 1/4] drm/amdgpu: update xgmi info and vram_base_offset on
 resume
Date: Thu, 22 May 2025 18:40:45 +0800
Message-ID: <20250522104048.569456-2-guoqing.zhang@amd.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250522104048.569456-1-guoqing.zhang@amd.com>
References: <20250522104048.569456-1-guoqing.zhang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: None (SATLEXMB03.amd.com: guoqing.zhang@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6734:EE_|BY5PR12MB4276:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f8db651-7da5-4a60-f146-08dd991d2950
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WmtXUWhyNzNWRjVReHk5d3MzQUpOcFgwWVZRZG1qbUovaXhndGdFdCtlTTBw?=
 =?utf-8?B?TW5sbW9TZnl6Z21mc09PUXV6OHZ1dGEyWUVuL1JCK1p2SUNKUE50V2JnVTNu?=
 =?utf-8?B?Nk9DN2xEdGZ1SzVjNXpuNDFleTZUMGxTYVFOem9CbTd3MnJMTUdCcjVhOGg4?=
 =?utf-8?B?TXhqZE5MVlFtN0JNbnI4eTF0ZVRFUU9pU2IwZnpuMVdEajdOR0dRejZmY0F0?=
 =?utf-8?B?eGZab2s4cWtUWGtjQW4reUFKS1Y2YzVQTGRINkU5MU5zSlhPbUJQWW9lVXBL?=
 =?utf-8?B?cmNqMjVHM2VqNUZZSEN0dFc4eWtYVFB6TXcyYkZId0wraE1oOTJ2aFZFV3M5?=
 =?utf-8?B?K3lCSXVhZXdBaE1PM2V3TjBqRnlWZlVRTzZobDBucTlZdzliM0VOUFZncFJp?=
 =?utf-8?B?cmowbFc3YUpNV01GNWdUNklyQnFhSTFsRytRNkVUcFNrL3VuWEY2Z2ZldFdY?=
 =?utf-8?B?NDY4U0NlQlZ5NS9vejF2ZU9QTTFLdFMxa0NMV0tRZHlFTXlXWmhRNkt6di92?=
 =?utf-8?B?SXhaUmJwQlB4clZoMjM5Z1dNSlZCT1JSRi81WHhBT3ZZajRBVjBPZ2Z6RHRR?=
 =?utf-8?B?Qk54R2FKcmVha2hubnAwN1RJZ3E1VWZyWXVtWFVDOXorZThZZ2oyUjFQaTgz?=
 =?utf-8?B?Uk1TSFdiWGVDV21vN1Vzd1dkUm1LbXBxU0FMcURuZFYydWdXblZIUU1XTVhs?=
 =?utf-8?B?QjYySkI2YTFSMTBRTWFNSFczL3krSmVFNGlaU09HWXpjaklRMVlRbEtBYnpF?=
 =?utf-8?B?UjJTR3FsaFl1UEZYN2EycytXL2lSRnlvaitLRHo5UGpSVHR5Wkx4WGdZaWVL?=
 =?utf-8?B?dG9ja3NHQmJ2UnRybnI4QVNFMUc0YTI4VG9EUGF1SUlIMkJSOVR6YkVvNWtS?=
 =?utf-8?B?THdwSG9KTnVjMmxlelFzcGplcm15MGk5SWgxVlQvM2NLb0VEWGhyZW5XckFI?=
 =?utf-8?B?OUpERGQvTXBGSUxIWWEzSHhyTS9GLzRwOHZJQkordXRSYlNuN2F3QmpCcERR?=
 =?utf-8?B?dU5lZXZsTGd2RDNlWEl1RjJaZ0wxSDh6cm14dU4rUWNwaS8xelpTVUhrM09P?=
 =?utf-8?B?OXlsSURoZWtNaFdJSTBUZjZWTDZZL2EyZEZBOUJOUk9YSlpEMERjTUk2Smdp?=
 =?utf-8?B?N2RscVZnRktKdGhVbjE2M2tTYkNxMWtaS1k4NklRUkRLWXZFUlduNGk0WDhH?=
 =?utf-8?B?aXo5a2h2Y3prL1FCbjdLZU1KVE5qS1habitRQUpGVVp1NS9BeWFwS3c0QWxF?=
 =?utf-8?B?T0NMNUZpNjRTOFBlS1VucnNXWkRQMFpCME9CdDFkZHZKbHJzZWFFUWxDakhO?=
 =?utf-8?B?cDZXcHRyZ2NBNHpNYVVBeFlibkF6QTRwOWl3UklHTkVXQVBBc2lYTzRxNkRi?=
 =?utf-8?B?bHJnUzk5WUdmeDdqQkxEWHhDN0xqbis0RWpwdHBLZFhTVHlKLzZrK1h6dmhz?=
 =?utf-8?B?T3hmWWs2akpRb1dvOFhBUGtDUkpzMWRnUFl4dCt2M3B2NHJtbmRjWG1wUHMv?=
 =?utf-8?B?MHNvNVBGcFgvVHlhNmZWYlhpeHZkNHVNNjEvMWJJbzdlT0NZVkdPSitqK1ht?=
 =?utf-8?B?RDNPZnEyWjJRY3VoVTc5TlhRU3dvSEVMUzBONUZuaVdpRW00QlZiMzExd1lM?=
 =?utf-8?B?NG1OZXJ4QWorUHkxSVpnVVFFZmNIbmI4bXZtanZ5ZlJTTEJoVk5wVVQ0TVdk?=
 =?utf-8?B?NHdMWFU2c2xzMHFHZnZ4UDFpM3BrSExDRjBwK204dDBRNU9Fc0VQMytFR0FH?=
 =?utf-8?B?Ym5LSGFnb1hnUnZYeVpwYVd0bEVtSG8zdldPNFJXOWEyWnVXVnp3RzMzQzF1?=
 =?utf-8?B?YmRWTXdMRVJrSG5xVDNEYXlBUnRSL1JnVHh1V0lNN21KQzdlay8xRnNPOVZm?=
 =?utf-8?B?YjRWR1IzYjlwc01JWnBFclJ5aGFCMzQvRXZXZGlZK3BOTHNuNHZ1elRVY3pO?=
 =?utf-8?B?RG52cFVuRkZEamlHZytERTQ0R0p2Y0J4L2lLcWNxK1dUSjVGMDM2Z0dXM0VU?=
 =?utf-8?B?YVVndy9ORDRqTkszUDk5LzFjeDhYbUNKV0M0cDRhYnlSWFVaY1M2eGpTM3ZE?=
 =?utf-8?Q?z3R13h?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2025 10:41:08.1267 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f8db651-7da5-4a60-f146-08dd991d2950
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A6734.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4276
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 31 ++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h   |  7 +++++
 2 files changed, 38 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index d477a901af84..0246a33b90af 100644
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
@@ -5040,6 +5046,25 @@ int amdgpu_device_suspend(struct drm_device *dev, bool notify_clients)
 	return 0;
 }
 
+static inline int amdgpu_virt_resume(struct amdgpu_device *adev)
+{
+	int r;
+	unsigned int prev_physical_node_id = adev->gmc.xgmi.physical_node_id;
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
@@ -5061,6 +5086,12 @@ int amdgpu_device_resume(struct drm_device *dev, bool notify_clients)
 			return r;
 	}
 
+	if (amdgpu_virt_xgmi_migrate_enabled(adev)) {
+		r = amdgpu_virt_resume(adev);
+		if (r)
+			goto exit;
+	}
+
 	if (dev->switch_power_state == DRM_SWITCH_POWER_OFF)
 		return 0;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
index df03dba67ab8..2a37d568ed27 100644
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
+	((adev)->virt.is_xgmi_node_migrate_enabled && adev->gmc.xgmi.node_segment_size != 0)
+
 bool amdgpu_virt_mmio_blocked(struct amdgpu_device *adev);
 void amdgpu_virt_init_setting(struct amdgpu_device *adev);
 int amdgpu_virt_request_full_gpu(struct amdgpu_device *adev, bool init);
-- 
2.43.5

