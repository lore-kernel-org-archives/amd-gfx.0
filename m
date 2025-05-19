Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FE7DC3DA6D
	for <amd-gfx@archiver.kernel.org>; Mon, 19 May 2025 08:22:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1501A10E20E;
	Mon, 19 May 2025 08:22:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vGfGuhT6";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2047.outbound.protection.outlook.com [40.107.102.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4920710E20E
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 May 2025 08:22:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mKeEoC82gKLI3yl99x5xn38f5c/tyXyRzjN33KN9fzBDgBr+a8yhgY+iwHBX6Btn0tAQr3I2JNOssNSgnlnxWsy8oyiU/NPIPnIGiwlEz/r04fSnJNncfcZaoC4jVa7ahSy9HJH+3ZTF2h4DjkKOKXToauL4UyKCC80wxUQAknAa+UhY/xIGV8Qw+g9K/q9zL+gsIYERl+A2cGcV8ScoxPDMYf77R3CstURZwMQYFXxbUATOLLupThbC8qSC98KltQLOQ+Fe5x0gsnjJ08iqmM55Z2eIKOD1kTlDbykfjvpvTO6Hlu32nlocJvTblWTdgRu6P/O18yUMRhSRqw1pZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QNww8sOaPRX0QyUWn9aqgLuQuCmHUHGzVaU8wma/oTc=;
 b=MS/Enk9+GWzwjlhePQqi4m8fF1JyVsXHgJZWQvMH51PARN3ac9R0YHC8X4vEb+ft8W2GYOdr+DyXgRHLB1RFdtFgchBLEL8X53nnwzP19O1TNER6GvEiaylia94GbHr6Vu7f7QH6hAQdSOisne+y7sJeCqF5mxxmAb5jFQrIr1P52AgTculqF/YujMGYwBogrfKjmny6z77iSK2KfaGVdLRatEcBR8P4EOkDGw1rQcYdt5QSSlec5bpvRqskF5+RhdTM5yzfBGEhrK9JcK3qZn2iSZ0QZp6CqUeoU65XbZU59T/wfYB8o/0E2RC9q/LIJGB032/GEpEsXeet8EaUcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QNww8sOaPRX0QyUWn9aqgLuQuCmHUHGzVaU8wma/oTc=;
 b=vGfGuhT6ZxeYAFw/mXh4nJIjPzHgEN4bKdpoBUj/exkUAh0pxGt3QGaPMNwwdGfb1OKawuNh3u7zCfkPey4TPluJxQG5zA52oVhp2IrG6A8jqweDgrLx/s8gB+2ffslUq43xeqM2fvfTZYuzQVfqf3cs7Rj9OTcu89c1zdwXbCA=
Received: from SJ0PR03CA0086.namprd03.prod.outlook.com (2603:10b6:a03:331::31)
 by PH7PR12MB6882.namprd12.prod.outlook.com (2603:10b6:510:1b8::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Mon, 19 May
 2025 08:22:05 +0000
Received: from SJ5PEPF000001CB.namprd05.prod.outlook.com
 (2603:10b6:a03:331:cafe::c1) by SJ0PR03CA0086.outlook.office365.com
 (2603:10b6:a03:331::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.29 via Frontend Transport; Mon,
 19 May 2025 08:22:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001CB.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Mon, 19 May 2025 08:22:04 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 19 May
 2025 03:22:04 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 19 May
 2025 03:22:03 -0500
Received: from hjbog-srdc-17.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 19 May 2025 03:22:01 -0500
From: Samuel Zhang <guoqing.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <victor.zhao@amd.com>, <haijun.chang@amd.com>, <guoqing.zhang@amd.com>,
 <Christian.Koenig@amd.com>, <Alexander.Deucher@amd.com>,
 <Owen.Zhang2@amd.com>, <Qing.Ma@amd.com>, <Lijo.Lazar@amd.com>, Jiang Liu
 <gerry@linux.alibaba.com>
Subject: [PATCH v6 1/4] drm/amdgpu: update xgmi info and vram_base_offset on
 resume
Date: Mon, 19 May 2025 16:20:35 +0800
Message-ID: <20250519082038.21459-2-guoqing.zhang@amd.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250519082038.21459-1-guoqing.zhang@amd.com>
References: <20250519082038.21459-1-guoqing.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CB:EE_|PH7PR12MB6882:EE_
X-MS-Office365-Filtering-Correlation-Id: 778c0f8c-febb-4275-90ec-08dd96ae3d23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?yhW0MJr4iqw8Fm9xdruinwrg1HFHrSBiHDPTiCXW95ZvRxy/0dU6ZTItTKob?=
 =?us-ascii?Q?grmWSeke3ZBSja57q9ZqLdo3xmi4/EUTmOO0PjFUEx0nxtT/yn+ouf2aTs/L?=
 =?us-ascii?Q?uZOsHqQneP9xP3OQziTy/cnbEppQqqPC20ANTBzsL5il/477krOfTHj0bYEi?=
 =?us-ascii?Q?a8CyZa2DcbjqSD9bU14gkEt7XviOEzWUQJJSkQXyh8vZhInUhnfkuPwRph17?=
 =?us-ascii?Q?QlT3vHVadMhP9K0Zb3ot/vTLLWrDe/c9WNbBnMuh3ja8lTQ7Rwm3seFsgNmP?=
 =?us-ascii?Q?USf4Pksrgap3fWakBX8axzADxJofui3S0jo+fa32uYRRDkGa6w4D34H2hhEA?=
 =?us-ascii?Q?dZNYPY3IDUtEMnU8jXddIqtzzed5mvZYWcBl/+SvKKFSPT+1POI6KWf/9u9o?=
 =?us-ascii?Q?dtIN15OWhj5IzJ7vMNQtHcu7l87LcNnu7e32eZHM+01DTyMI0dS6DTRt0RMw?=
 =?us-ascii?Q?WWW0gzDQeq+bWGbL+KtF9ya8WazSdvecFW9al3Ae4kvla+TRZWzq6c0Ui/QV?=
 =?us-ascii?Q?h18KOQgS6cLkHZqRpLiZW2FffIdv10u7S0FbkIfrALXOpjXuCqB0xh0rcaNC?=
 =?us-ascii?Q?BW2fD6uf+0i28iWehqlTvjc+SwfJLmFnBLMKZIs1xaCfUs1tL8Gt83zijFfe?=
 =?us-ascii?Q?wdxuK0BwAHHwqf+PnwQi6B1VXh2/2VMJAQuEL0ocJ2MtsgzmkdTeTM/WOimt?=
 =?us-ascii?Q?VzAiNWJirtafS8/G8Yj2/ZCZWI2pD51RluNiXgXUg2SVzll2Dd4EIZBAe97A?=
 =?us-ascii?Q?PRbEXNVSNOOpvq1h9Y1Yz5J9SK1t3kIo1DfuOWnPcjiUmWyuwuDddisejrh8?=
 =?us-ascii?Q?4ceE6I3wcUmwdATwjFK8hO+YmXm3lyk5K/rS/Dbvwnd1Ki+KQClzefzlbDBB?=
 =?us-ascii?Q?ST+ueel3e+6HXY8tlYH+SWrUgWCSYdqy2ukEo0QjflqPJjeUZJSrABoVWS+K?=
 =?us-ascii?Q?ZX3ztvrs+a1n/PrSDSgIamSpg55/KC/llpLZWw+kqvbo6BxyUIODmYwUANRV?=
 =?us-ascii?Q?8jUfL4tG3rAdTOAzAHpncao0gQ4mnYS/g95J7zK6E3yMR+sEGPPXN/xfvCEQ?=
 =?us-ascii?Q?598Q89ti+T/ucjH7xspvK11uwZ1lwe8ydl/LJvnKEDHJeCeXEIsVVKuXuHlE?=
 =?us-ascii?Q?MkJa7EpkmIG0r3Z87OsmMA6I0MLDMnZlOQcgs71wkcSUTlEJz0ZA3a+1n9ZD?=
 =?us-ascii?Q?FVWly4H1X4OkVFckyL9wXQ0b4placIy3Jx/K/ib4g3KW7vWGuKKvwoAwZ7zY?=
 =?us-ascii?Q?iS3vvZcF6odg6eMKHvaJD3dxPoSLzbiIJionCKIxpFVXn+CPqj1L6v5GE9Qx?=
 =?us-ascii?Q?25TCcA1BStVghWCC240Ec1bw6fuHUpOspJ1ziKAwHrpUDZZfBVJ41lX2NLMU?=
 =?us-ascii?Q?1csav1VeQbBea6lGJosgFLMxyzd0e/Bq8g8/BtcDFTSxMPAdpWSgPpmVLwz3?=
 =?us-ascii?Q?3ECwHx6DlAiUhBy1pyD4AQqVLR3EwIdIeWDzIpL2jNiEnf4E88Pp4ZjOF3Pl?=
 =?us-ascii?Q?0WHFcWDS50Sfo6m5WYKUO3CAoRJoCcZoGOBI?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2025 08:22:04.9436 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 778c0f8c-febb-4275-90ec-08dd96ae3d23
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001CB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6882
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

