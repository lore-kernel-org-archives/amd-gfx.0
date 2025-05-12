Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21E37C3ABC3
	for <amd-gfx@archiver.kernel.org>; Mon, 12 May 2025 06:42:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C025C10E2D5;
	Mon, 12 May 2025 06:42:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="E4L62qAE";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2087.outbound.protection.outlook.com [40.107.236.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 335CC10E2D5
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 May 2025 06:42:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i+F42IcnyEuYaQhvBDs7uUztkibXuhlc4uuBKi1CHMbJHCXBlRWD5cISvKqgw7RVAXE35PxdZzQl0TN1oOnN+2EVhZdLCJhumlpnFC0DW+L/XuQBAIeA1VexYzCIJT5qvdR955Hm8Agm94/37sxderFBtSpOVv7fg8iPlsuFZwhvFg56hQBf/8r4ReCCXE4EXgkWca4mhmhFh22FqMWS18gImg/qD3lO07Fbh+vwtzbmQvIJ6Bns6KFVsl/yBQ2UxJ0BY1I/FLRiLMR0IyUzdmUaFZGMX9pfaKf7Hbkdx7Gd+X7tqsZXn4alEJMUMg8OulYiBp4LefVpZYQYY9Rsqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0eUNYEtLGMrMvyvnZuoTfkBm7QOvMRzlGUvO4uwNre8=;
 b=oVN3dK8fZpHDN1kbyIc6J1LodnnnSeE7Dy9SHGBl55MChXsbKx9pKSZ5IqOr36iJpy1qmSMPG5PSr9qiImo1mhov/x2sASJujpaKQ6NV2bq6BCD4H1P4+gf4pk+oRXBNApjkl3T9kgL4hAB8aXmOhJe1c3KF1YdWEpIET0q5ZpKxzCDj/qNTTxfHQ16iX5ZVwsq3qIFFgralVbnHf/BJ5dVV3ow/4s1E6R74xqJtK0Nuc+QC5S2C3SQnb6PIvS0xmKx87AXO8pCTfA01rfB6ESiEUqLYjGx/ZJlMGw7Kn4XmNZ7Ayp++G5V3qSjq67XEaCKa9xXacuFxakpvXYeg7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0eUNYEtLGMrMvyvnZuoTfkBm7QOvMRzlGUvO4uwNre8=;
 b=E4L62qAENTHXwBU8jjOPGwFcWDijVLXm2TDWZHYMvRENbVbtbe+1IKdTSWHpZR0S07zIuhXtUBbPCdpOWxCun8xzb943EcDZJ49ynsukMr0uXv8eUeA8lw78FM/NwVcEMlD3T8WCNm/RnDfH361tG0AaqKTrc2IxwkmuxAtGpbU=
Received: from CH5P222CA0017.NAMP222.PROD.OUTLOOK.COM (2603:10b6:610:1ee::21)
 by IA1PR12MB6628.namprd12.prod.outlook.com (2603:10b6:208:3a0::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.28; Mon, 12 May
 2025 06:42:14 +0000
Received: from CH1PEPF0000AD79.namprd04.prod.outlook.com
 (2603:10b6:610:1ee:cafe::b) by CH5P222CA0017.outlook.office365.com
 (2603:10b6:610:1ee::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.29 via Frontend Transport; Mon,
 12 May 2025 06:42:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD79.mail.protection.outlook.com (10.167.244.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Mon, 12 May 2025 06:42:13 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 12 May
 2025 01:42:13 -0500
Received: from hjbog17.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 12 May 2025 01:42:11 -0500
From: Samuel Zhang <guoqing.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <victor.zhao@amd.com>, <haijun.chang@amd.com>, <guoqing.zhang@amd.com>,
 <Christian.Koenig@amd.com>, <Alexander.Deucher@amd.com>,
 <Owen.Zhang2@amd.com>, <Qing.Ma@amd.com>, Jiang Liu <gerry@linux.alibaba.com>
Subject: [PATCH v5 1/4] drm/amdgpu: update xgmi info on resume
Date: Mon, 12 May 2025 14:41:38 +0800
Message-ID: <20250512064141.387079-2-guoqing.zhang@amd.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250512064141.387079-1-guoqing.zhang@amd.com>
References: <20250512064141.387079-1-guoqing.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: guoqing.zhang@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD79:EE_|IA1PR12MB6628:EE_
X-MS-Office365-Filtering-Correlation-Id: 99edfb4a-abbb-4c48-402f-08dd91202138
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?LsAIN5nCT0J79QXT1Fj1F8zt/ZmJnZkOBk6SbeUwsjnzOtSwv8uzq3qsaP3K?=
 =?us-ascii?Q?CQuBeUaTDkKozZaJ1vDiNn99LgW0laz7Dv11A521xGZDAvTJ7/jbOqi9RKd/?=
 =?us-ascii?Q?gqXXzOjmfdH8QdmDIZ+IpeF/UiN2nvRXjSElU/NCPGKQgZUm6pxZ75DbTjyg?=
 =?us-ascii?Q?gyRYlSXYMYrFVQhjAs9wrij9/1/l9G6rMPdOGxS53usg6Lz3HfemDJOygnAH?=
 =?us-ascii?Q?7gvUvjMYVDF58JJgPf2MQHt0RMhwOat3Q7QNg4AckJJjZ76/zRt7WKOHZ0m9?=
 =?us-ascii?Q?RHfY7FHT3C3lSG9nUbCWFR0K8CkTRieCAyZbB/WOjvq9vJHAvE31jOc6hVjM?=
 =?us-ascii?Q?/pDiNXLeShDyLXkIaeLbItEbrosRHIM+zaC9MeVdxJ5cR3K5DfLTBIZZQI59?=
 =?us-ascii?Q?jnWWBR/KoKdrsKq1463sy6DRiuCNwnourdeviDjASIZ8g2QF20dfA34yciiU?=
 =?us-ascii?Q?+4HGIR72777NGu/tltSt3e3dj9jhew7FPzLGOpPC+cVs9nD74QBSiw+7TgGk?=
 =?us-ascii?Q?Lp1g41c82MsE89XrfqO87e6KqIl/tI2q1DWM4ZSKpYUADS7uJkvtE1GcCPB8?=
 =?us-ascii?Q?c9GyKqoMooCeJbhxdm5pwEKW9U4yM3CsCHLxEzschIVmze45qTZB0lJPwyac?=
 =?us-ascii?Q?hwpF4O61mtyOaDUcQXkwCkO5v1pmgrurjh4nZS/IaLtAjdQLh4NcN+1gDPoZ?=
 =?us-ascii?Q?MYCgm9iyYk8pyl3uNr93SmHeTAVENWEIWiww5V//sxL8+XvwJtd60jlxsjdi?=
 =?us-ascii?Q?nyQY1W1UuEn9fQEsOVuWltK4d7+5sz+UXN6r4kDIG+lZscelMqd0CQyWBM8u?=
 =?us-ascii?Q?+I6PWQcf+yxGK6ziaq0p3pG4eSj4F0OSRV/2rFxEWCaL9jy8ZXMa0YZoi1J1?=
 =?us-ascii?Q?w64fIWnkIwaIgVY3vCYxO4MuGeyPtlaZneIBIGx5Uau67JpZBwNy/uWFZQVy?=
 =?us-ascii?Q?plq/Mp4CrrAOTfK0K9JnKut4Fvj84+zAwb4SH0HDYN28s+JnsvtkBa5U4rR+?=
 =?us-ascii?Q?hbVLfQI+mz8cFe73uJbGUCxdjiO6eMMRfBixJmVH729Sb6olpD77LePDpdor?=
 =?us-ascii?Q?V6Keqkt5Wn4PcSduYXjhnGIS0C4YE12KwC8wcHkj/Or5Gxm+9UfOXw3oBgnK?=
 =?us-ascii?Q?25+xKQhWn5kRWM2sJHubrbkP/REW2QrmQ/sCl39QbTObePCkZDDKnnpQnWTE?=
 =?us-ascii?Q?fOvLmxwPfBLlLQMSpHekxsjJnaakRjIM8H59qjBxiON1ENkFvVupFu2K5/YX?=
 =?us-ascii?Q?/b94XB74h8hv2u4wOfWU2qdgDHAv6BqiU3In9Yn3GrHmEY3UwBu7tx0RwVcj?=
 =?us-ascii?Q?+Ln7923y1lVeMuphwZgNV2N15AA+qOq0VIqdMxLuui4EHDqQsEFNv+j0Twmh?=
 =?us-ascii?Q?I27DxqhK4Z6vYP2t7Tz1I52d59ayergxXnD6DhPLYW16YHWqobWVrgeYXNbX?=
 =?us-ascii?Q?r8JBRqrq54YgqCCDO50WdlYib0ivuH1ZXkiv9jcJR7XdPipyDxf/i5Fa+Qjy?=
 =?us-ascii?Q?VmCTgpmegNqJRUnEtREC/I+uVCkt5/jFz/i0?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2025 06:42:13.8243 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 99edfb4a-abbb-4c48-402f-08dd91202138
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD79.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6628
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

For virtual machine with vGPUs in SRIOV single device mode and XGMI
is enabled, XGMI physical node ids may change when waking up from
hiberation with different vGPU devices. So update XGMI info on resume
for gfx944 on SRIOV environment.

add amdgpu_virt_xgmi_migrate_enabled() as the feature flag.

Signed-off-by: Jiang Liu <gerry@linux.alibaba.com>
Signed-off-by: Samuel Zhang <guoqing.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 27 ++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h   |  7 ++++++
 2 files changed, 34 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index d477a901af84..d8aacd5a88a6 100644
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
@@ -5040,6 +5046,23 @@ int amdgpu_device_suspend(struct drm_device *dev, bool notify_clients)
 	return 0;
 }
 
+static inline int amdgpu_device_update_xgmi_info(struct amdgpu_device *adev)
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
+	return 0;
+}
+
 /**
  * amdgpu_device_resume - initiate device resume
  *
@@ -5061,6 +5084,10 @@ int amdgpu_device_resume(struct drm_device *dev, bool notify_clients)
 			return r;
 	}
 
+	r = amdgpu_device_update_xgmi_info(adev);
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

