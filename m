Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4591BC5AD49
	for <amd-gfx@archiver.kernel.org>; Thu, 29 May 2025 10:03:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D250A10E726;
	Thu, 29 May 2025 10:03:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xmAMWIo3";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2060.outbound.protection.outlook.com [40.107.93.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A634010E726
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 May 2025 10:03:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZJK6YQKxT5Vf3pgqL+9zZjskwC+g+RlEqxwMD01W2V7elCQpYepfkB1tPEBTmk3M5YV8c7JJrYSZ319lWjC1GvjIWzglyk07XsgC+p7NVucIdw5j+ju5RJPyaS+p2ofEAx1r74zC7QBX9XViLHv5+ew/xZ18o9vcmUoEX9eSiU6EK9CFu1+vm/vTXuvbMi2vgpvUJ3xPeC7STmdlc29Q+RDTLFKpEdl8zB2J7xTQQEWzC5Ix4tqIUsLSO7quZsrIjR3xLTyRDdS52YZ+5GMLMaaJqwAKqX8oEx0i0E0nTjUEj/SlbHsQU5gvaMYw28LC5+fh2eMbEpA/j5cwQdOGkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=luXkovkIgQwkYQ+8KtYMXqfBkuuiPh/RYnuH6S0fCSk=;
 b=Y4nF7u/FtpFZxQUeG6HcrJckaKGD7t6sBpJoJk8XoA4vgf7bofsjTSW3ZO3+6mC6ohfB9jESxy8dy3k622bnFxLtS1BAUiKeb+P3h548eaOSzt4UWFLIzU198B/CqtJEXm8M05H/UT7BMonlP9+Db2wqhQjB/wfBNqg6q0MjcKhRv4vZDFz0QK6ydps9W/Ph+RLY0pN04IqRBFtJL7b4MdMi9b7NbsK5CxWFidsx/WL/dvAB0X9SlKwyr6Kt/BpnuuYrG8qKtNz68+F8a/0U+M8+kWGmp+KQu6IWuADde7RxXe49XHhuvnx+fFw47II5/AcqY9RLV8+Y3mIL7DLd2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=luXkovkIgQwkYQ+8KtYMXqfBkuuiPh/RYnuH6S0fCSk=;
 b=xmAMWIo3JFLcXD8bQ7jWLemdY9REAK1yrPUFIEdKlu3+SHizWOJa4ZlHXdkSs2IqSF52OFwVQOR9uJlSDqJ5agkIq8TvNoWT6oGqs3fPhF8GvSRUfUTxGTw2uaxDg5C3TDN5MWEPaYPCQxuveLaFLFomRuiOsFQZrtM94sdVR3k=
Received: from BYAPR07CA0001.namprd07.prod.outlook.com (2603:10b6:a02:bc::14)
 by CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.30; Thu, 29 May
 2025 10:03:11 +0000
Received: from SJ1PEPF00001CE4.namprd03.prod.outlook.com
 (2603:10b6:a02:bc:cafe::5c) by BYAPR07CA0001.outlook.office365.com
 (2603:10b6:a02:bc::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.19 via Frontend Transport; Thu,
 29 May 2025 10:03:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ1PEPF00001CE4.mail.protection.outlook.com (10.167.242.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Thu, 29 May 2025 10:03:11 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 29 May
 2025 05:03:10 -0500
Received: from hjbog-srdc-17.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 29 May 2025 05:03:02 -0500
From: Samuel Zhang <guoqing.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <victor.zhao@amd.com>, <haijun.chang@amd.com>, <guoqing.zhang@amd.com>,
 <Christian.Koenig@amd.com>, <Alexander.Deucher@amd.com>,
 <Owen.Zhang2@amd.com>, <Qing.Ma@amd.com>, <Lijo.Lazar@amd.com>,
 <Emily.Deng@amd.com>, Jiang Liu <gerry@linux.alibaba.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH v9 1/4] drm/amdgpu: update xgmi info and vram_base_offset on
 resume
Date: Thu, 29 May 2025 18:02:53 +0800
Message-ID: <20250529100256.754769-2-guoqing.zhang@amd.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250529100256.754769-1-guoqing.zhang@amd.com>
References: <20250529100256.754769-1-guoqing.zhang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: None (SATLEXMB03.amd.com: guoqing.zhang@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE4:EE_|CY5PR12MB6405:EE_
X-MS-Office365-Filtering-Correlation-Id: 7cc1a4f3-86cc-4ce8-71f4-08dd9e98050a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OGh3UDkzNklOTTFVdUlvb3BZRC9tSDF6S1ZlM1BPZEZ5dXF3VENBam4wbW5X?=
 =?utf-8?B?T0tKdm5xSlo3RWNsanNjUWdaSG1LeVh2amU5aFVQQmR1cHl5WDJSem83V0NU?=
 =?utf-8?B?YUxvV3p0TWJTRjFJaHhQZjJMTkcvQkpEYTdvMDBiY1BXeXV0ZGRScDNsSzV6?=
 =?utf-8?B?T0treFlzeGpQc21DY0lyallodmc3dTFTSVNZUkZFcU1zZTBvMFhYOW1uckNk?=
 =?utf-8?B?WmtQTFdwL1BCMjQ1UW5PcDI1bG94TDhTWXdBbVljMU00cDdybHdqN053eXVC?=
 =?utf-8?B?ejl4MHdnY3FGR3ZqaDh1OGNRUjJENUxIMGZZdFdhWlRnMGkwenc4amhtblpG?=
 =?utf-8?B?RFZYd2ZQRjlVVG43aVN1dGtWaU9zTGVNck12eURKalU3N1NCNm5qKy9XR241?=
 =?utf-8?B?UzV2OGNRUEo2QytjQmhXVXlSeG1ORU5xeDhyTHBkdnp3MnVWNlZzaW94SVdT?=
 =?utf-8?B?eW91Z2tUUThjM0ZERDN3TmRWdHoveHNmU2t0YkdGT3crME1pREpCeHBEd2Vl?=
 =?utf-8?B?Tmt1ZEZSNzVwZnhCR2xGbUlydXczK2k1NkZ0dk9ROU8zL0pvYUZ2OWhtNWpF?=
 =?utf-8?B?WjVuYVRoMGxOQU8wNFN2TlhkYzU1d1U4ZnBoMGljMVpDM1RmZ1gyVXh0MENX?=
 =?utf-8?B?NCtjd2x3cFJBSmk2dDdsbG1uaXdOTUd4S1NEcXR3ZVh3TlBuZW1aTHFOd0Yz?=
 =?utf-8?B?LzNEYXRuNzFHNUpISU9KSEVSclpzS2FWV1VEcU9iNW1yYmFtMTlBeUp2alRn?=
 =?utf-8?B?NHBEUGh1RWRQY01jdnBtNVNLS1FKZzdhUzNzbXdNVnRUeE4rUGsyQThuNTVw?=
 =?utf-8?B?NHF5MGFSTU1aK0pWZ2R4OGN5cDNqbHdKT0F3cHQxMXpwYVo1cEhuTXphY2VG?=
 =?utf-8?B?Nm4wV1JLKys0d0t1NHdsVTdBZGovTDBidTRlUlpOLzBmY2pOczZYbVpBYmc3?=
 =?utf-8?B?VlI4cS9mRWdPZU84VnZRQldNU3J6K2w3enN1aldSYnNPcXpDdXV4MHM2bFE4?=
 =?utf-8?B?L2UrQ05CQ3luYmI1VUFTRkMwaFM3T3kvZ20vZG5XOGRVa1dWSWVXQ2Y2M3Vl?=
 =?utf-8?B?UWQycU91OWo4UnZjdHc3RmY4bmZsbjlvc1BvTzhlOEpyS3JwTUpoaVdsc0Er?=
 =?utf-8?B?MFVnR2J5SVF4TFpVUHVpNkd6RUx0bTgwaUpHOE0ycGhVVDgvbG85K3psdytQ?=
 =?utf-8?B?bnVXY0NQYk5JdU9oS2syQ0tlb21yUVMwVU5tTHZFOHJuck4wb2tMeDFlYXNL?=
 =?utf-8?B?L3p1Uk1WZDJKYml1OEpCZjhYUE5waUp5UW5UNEQ0UkdTK3p0S3BxMGN3YWUx?=
 =?utf-8?B?RzNSSDBsY01pRHNOZW1qU2pqa0ZXdnhSaGVwblBpUlVOUXozUjVBY3JqeFBH?=
 =?utf-8?B?Q3RmRWlEZkFhMjE0cXJPQTlNWGQ3U1AyZis3TzVJV3ZoMTFEREQwWCtqenFK?=
 =?utf-8?B?cCtmZ3ZpNzdVRGdOczdDVWFCczZjSC81N0ZDdW51RVFsR2MvQ09CaHpZTTJ2?=
 =?utf-8?B?SGNSVC83M3pvWU5CMEl6VTdIVE1tM0NpbWc3Q0p0NDVFUEtTc1pEMC85VEto?=
 =?utf-8?B?enRUam9sSE9ydW5rQ1cwSUVIZDJVSnpTeW9KWEhkaFM5RkNpMGtpU2ZsT0N3?=
 =?utf-8?B?MTZ6WFRQb2FqOXppQW51VTl2Q3h4WVZZODRQendwOVdVMmxjV1h2Nm5ROGhJ?=
 =?utf-8?B?VzVKQmI4bis2SG5rSnZjVndjTUc1eGx4N1Q2YjJOaXNmRmlrU3hhSkEvQU9u?=
 =?utf-8?B?aHdCQ0grZTROR0NXWlBqMHNjcmV2Q0lhdVBLc1pMdTUvOWs3a3JuYkNpYjBp?=
 =?utf-8?B?bmsvb0h4R3kzWVFkT3pEY21qN1phRzR0VEEweHczZk1pblhOSm1iTnZoejNl?=
 =?utf-8?B?TVVkZjJFRmlEK0pwbjRtdGl6MjhscDh4YWdaNE84bWllVmdDQy9rRHdqbndm?=
 =?utf-8?B?cW1hc1RhK1oyWjdjQ0hnenlIemRHSTN3TUtTVTYxS3QyS2Z0c25VV0thSzYv?=
 =?utf-8?B?RkxzckZ3WlpvczNXSkV5TTNxQklVOXl4ZWFwSkVacEZKaEtEQWNneGV0Z3Ev?=
 =?utf-8?Q?Fxp4TZ?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2025 10:03:11.2008 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cc1a4f3-86cc-4ce8-71f4-08dd9e98050a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6405
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

