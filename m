Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED8A0C5B549
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Jun 2025 02:19:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 82D7010E239;
	Tue,  3 Jun 2025 02:19:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Mdvv74jW";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2040.outbound.protection.outlook.com [40.107.101.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E3EB10E239
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Jun 2025 02:19:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bZktslrnjeZ4y+lr4GXQApjKRwbOKPWASZ24w22110eVflXuYriAb2lj8ma3j/LbcTOXBQdD8/ZkxOX54c3SF6UdQb1TjDyHHFTdXLFjVZ8EPB4xWVd2G2OLugG9voZf71zjlTKDK8NJuSmJcO/2gwBM2s81TgXpX+E8Rg4TUxHhhTa2uCKw6BK0MRhiay76Slyr0Giadsa2x8sUn2M9h4gXWCWtrXgY8NsusGnwgdr4Xe4rjOqTr675hPeGjWYUeWqT9Ozcde4PyEF7L0ViukHAJNi7g/KR041oCYYc/uOL0yyFMT5CnRfq4fZ7CTnyPEDeBzWLmXJ2ri4piaBVSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=luXkovkIgQwkYQ+8KtYMXqfBkuuiPh/RYnuH6S0fCSk=;
 b=FIk9LH3Da2Th7pYb6J3A6rY7wTXZAcru9VW8PV+e94nGUV1wCC/gAVGQ58p7BxyiSFFXisE2Vw/1zD+lEbP2JWGyF9gNdamZ066lD83ZUsOfAcZCxoiuuJ9BISkZ/9ahsOuT8/XaaTkBxQPCL6pYbB27ELJ93scetjBNL0fLrNrW8fGQ3nCSHZg7Wm53qjz6UlGu1AIq/G8n46nFCTBkAPfkNc18gAsuFI9zIoiAmIGQiJkEBbF7E6YJAx3lPfSF3YQb77F/1pPLc2WFh1aN193A+A5EXFupgfFzigmydHYQQRBZTkD9IO75k1DadKh5CiouMT1RnBoFYl+aHM6H2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=luXkovkIgQwkYQ+8KtYMXqfBkuuiPh/RYnuH6S0fCSk=;
 b=Mdvv74jWKcHm79VYLhPETvbFQcKcY9l5sqYLYtADBJZ+yjIrDbF6VgwKleC4ZtDpbG9DlCLAYRn+OzOGv3HSDETsW9mcRLtH87DhMoLNZC/La+LOK0j5jyBafn3u1hmyLn0tuWzGS0K9hK2Rq7lxDehk04RAzH7EgxlKTTZXPPg=
Received: from SJ0PR05CA0026.namprd05.prod.outlook.com (2603:10b6:a03:33b::31)
 by SJ1PR12MB6171.namprd12.prod.outlook.com (2603:10b6:a03:45a::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.26; Tue, 3 Jun
 2025 02:19:25 +0000
Received: from SJ5PEPF000001EF.namprd05.prod.outlook.com
 (2603:10b6:a03:33b:cafe::9) by SJ0PR05CA0026.outlook.office365.com
 (2603:10b6:a03:33b::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.14 via Frontend Transport; Tue,
 3 Jun 2025 02:19:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001EF.mail.protection.outlook.com (10.167.242.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8792.29 via Frontend Transport; Tue, 3 Jun 2025 02:19:25 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 2 Jun
 2025 21:19:23 -0500
Received: from hjbog-srdc-17.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 2 Jun 2025 21:19:15 -0500
From: Samuel Zhang <guoqing.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <victor.zhao@amd.com>, <haijun.chang@amd.com>, <guoqing.zhang@amd.com>,
 <Christian.Koenig@amd.com>, <Alexander.Deucher@amd.com>,
 <Owen.Zhang2@amd.com>, <Qing.Ma@amd.com>, <Lijo.Lazar@amd.com>,
 <Emily.Deng@amd.com>, Jiang Liu <gerry@linux.alibaba.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH v10 1/4] drm/amdgpu: update xgmi info and vram_base_offset on
 resume
Date: Tue, 3 Jun 2025 10:19:06 +0800
Message-ID: <20250603021909.841690-2-guoqing.zhang@amd.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250603021909.841690-1-guoqing.zhang@amd.com>
References: <20250603021909.841690-1-guoqing.zhang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: None (SATLEXMB04.amd.com: guoqing.zhang@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EF:EE_|SJ1PR12MB6171:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d33689e-4b82-4b71-11ec-08dda2450f7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bU0zQmtXcVk5cUhHaHdYV2N4dDlTYmdWRUR0MVVkbmEwOGZObU1qS0lDV3dr?=
 =?utf-8?B?bUJxK1hTaHptSTdVWlFCL0FhVE5hR3RNOEZWWitJV2JvNUZMem56bk9iMmFT?=
 =?utf-8?B?bU5GU2hsZjB0M3g2cVBKa1J3clFiMjFlWWFicC9ONmk4VExsWjU4TnorZ1pv?=
 =?utf-8?B?Vk50QS9ZNXlWTUxpaVdFVHZoamxheS9XbnNwTldFOStiWm1qbmd2NVBZYTZq?=
 =?utf-8?B?OUJISE1relVFdEliK09McTByOTlqNUZydHk3Z3BMc1hQMEs4RUMxc0xzcjVY?=
 =?utf-8?B?OVlJTVduMXJZdFVtdTUvdlNzMzRvUmV1dU05N21zRkdrUitMUEdqSm9kZ1JN?=
 =?utf-8?B?TlRnYnNXUjFKNnpMOWpFbFZFKzhBSUFuaVVGbkowdG54VlBFRGR5blh5alJZ?=
 =?utf-8?B?VlR0WWJLclE1TFE5Q2FpSmNsd3EwNnN4MElNanJ6TlgwY2NWZGVGckdaeHFK?=
 =?utf-8?B?eURGSTRxdnhMQW0wQWlqUjVJR1NGSzJpRndSVlByTndCdUhUVjRFV0k3ZllK?=
 =?utf-8?B?YlVEUjROUHRNc1RVWFZDWTg2UTFHV1hCam9qTnhoY21neXdBUU1DWC82K2J3?=
 =?utf-8?B?MnlhM1pEMWc4c240aVhLL3kyRUJtZjVJMzVLa1BHVkVreXV3SjdnU0c5U2pK?=
 =?utf-8?B?TnBGaWlNd0tYMllCci9HZ044WS96enFuK0toNC83bkZJOUtVUStGUWR0S0NC?=
 =?utf-8?B?WlZVUW1pM28yZzVaOG9DYWZqMi9KTGNSMjRuYmVxdzI1OXJWUGFXN0QyMkl0?=
 =?utf-8?B?RG9DYnBlSkM3MXBFM3VVNzNENGpjMjQvU0tRL2dTNnpuL09SV2hnY0xCUEhF?=
 =?utf-8?B?aU5GbUxTelNpeGEwZDZuMUl5cEtBY1VVVWNFRzF2a01hdncwWU1FdzY0aFlI?=
 =?utf-8?B?aHJYaWoxSXFIc0JnWEtpdkFwUjRQeVVGa0xSM042MXhxWFdqS1ZQejF5dG1n?=
 =?utf-8?B?ejNtQXFqNFY3ZUdFSDRMbzNwMXUzVDlLT1VVTFFWenJqRzkzcnkzbmF0RjB6?=
 =?utf-8?B?M2dJa3FhaUMyTkRNVGtaVFpVVmUwTkdoU3JoSWtFdXlqMXk5Skc2OGdaby91?=
 =?utf-8?B?WFRuMmNZV2U1ZXBiU3JMeVdRY0pTQnlZcDkyVjRnRHg1cm9Va2RUTWxmVXBo?=
 =?utf-8?B?Skh2N1hMYXlvYWNHZE1mU2NqbXorTzRiV1kxczdrRzN1VjJzR3F4U3BDUXJu?=
 =?utf-8?B?RC9jcTZKTXppVVlyWWhlM2dMRzMySFBpcU5jbHJFYitxVkZ0Uk1ETUZwU3Fu?=
 =?utf-8?B?QmFwa0FoU0xudUpXc0pscjh0T0JZQkxGcmk5VE9zRzR2VGdybC9SVU9iazlm?=
 =?utf-8?B?YTg0YWdpaE05YmlYZGg3cjc2Wm1UTSs5UTBwSGorN0VCbnczUU9YYURLeGdY?=
 =?utf-8?B?ZHlCUVRvR3lLL1RCM0hvazJKQWp1UVpHaUQ4aC9vTXloZXlOY21ZdzR4WmE4?=
 =?utf-8?B?VkMxcWk1cmd5QUFZUU5pWXVHYzFHKzI1QWJ6R1BXZEhCekluWjlxRGQ5V01B?=
 =?utf-8?B?MHZZd2VLOEJNamRuTjIvOU1wbWhtVVQ5YXNncHk1NW1MSTVqd0JOQVRxekND?=
 =?utf-8?B?UmVPUCtBY1kwQ3RCeEN6bmtzZERMTEZEeTdpN1pBNUVvUWRNdllhZkwwZHZm?=
 =?utf-8?B?M2JQSEZ6VzBNblZxSGgycXNiRnR6OXdieE1hS1R2TStCZHJsbi9sUmlvMjM2?=
 =?utf-8?B?STZHWTluT0hZLzB2Nkw2djJBRGI4Kzg3REE1M05PR004Szd6cjhnNUFtZGV5?=
 =?utf-8?B?dlF1NWxsRkRWYmpjeVQxUFU5ZGpLMWY4Q3pZS1JDTHJ3ODEycW1PNGt0VWsz?=
 =?utf-8?B?dkIxWDhQcW1zVDdldW9KVFZHdGd6QU5wN2NVMHJVL0VjSTBJUk9sblRybzJn?=
 =?utf-8?B?aklrblJJSmNsMno4WEFTb2MwdU1uekxDam1nQ2FGa0cwOWJFakM0NHZ1QndJ?=
 =?utf-8?B?MmJxblJVNTljM3BGQmtXQ015akRVbHJBUXhjZnhJenl4dERXYzBFT01pT1hG?=
 =?utf-8?B?V09Zdy9WaWhVNU14NFNwclRpTUJpNUhWWWVhbFZLUm0weUJtTzR0Zk9hU0tm?=
 =?utf-8?Q?1mGnVN?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2025 02:19:25.1514 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d33689e-4b82-4b71-11ec-08dda2450f7d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001EF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6171
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

