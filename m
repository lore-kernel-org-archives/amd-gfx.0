Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67F2CE77188
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Dec 2024 08:15:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D761D10E359;
	Mon, 30 Dec 2024 08:15:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EEVS5hHt";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2057.outbound.protection.outlook.com [40.107.244.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6950A10E2C5
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 Dec 2024 08:15:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JwR3LwEm1pmN1BMHg2JkR3cKs+3bPPd+X7oDYbyXQRWqGj7z9GW+hAFafRbeGnmyy/75ZXPOH/vR4HJrynClGeUxaW5YyuOyyjVgsv0PH6EX9hB3rAqAx+qdG1QLBFYHwzZktZLnEjenWxTLCCnOAFMUoQKkObKqVfUEoEYwTIVR7ZZFCodXb41/9/nEbICsOgxGsXwTWWToTLlwxpHPn1XuKMEfmzqEL1Iw5vkJrvKH6zMXnzTP+WrXvJUMEQfgbZ2Pf0g71F4po2GMIPRiyP3rLCjjKUpy/WFFm4ypgdekvxtF8SOIp2dMBq3bJNBTUfWKNdRw5BXnHJou9Oj6EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gX6salJH6f2cIf8XKSqQ+IAab/XlilKoLhjwCP0bRlM=;
 b=CAsaeK/2AfAmc37TeHlrEzh1hiUkmwO0n4NXipiU5I+yrTu4U8tVNisOmLtYQYltKzFF/nsnO2Gt7cQ9AT8t50dOLfCUhlPcxU8WAgxqlZnqKbTA4Dx47OSiBYWx2eLg2RtyJz5NkmkyhqCYoZES3iiWhta92Id+YMounmHlvVjGnoUMCM+uMeei7sypRh5iblZvHgCHDGTGon9uNUQnBW6okaeD92uBcSDDBXBgAYvF57ccwreLuX5tvLLyjXUVetE0EJb2pRUC/ny6X4NgDlzYbDg0YPEw5UGsibfwXQkNg9/4117ZtUpMLnkpYVfoUXuUdbS/u7BOMZtqNdwQyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gX6salJH6f2cIf8XKSqQ+IAab/XlilKoLhjwCP0bRlM=;
 b=EEVS5hHtDiaK1TFp28mW9F6RjVD9AH9GERJJ22chPayZ+tXtmyIpEE/GqZKR/nA8W1tADlReHasnGE8WsEGRZWII26pgf/0bBHdA+Kp70mkPJcehtaTNRXqKmU1KQGE/0wydahONoea7BN/QWgZ/3Paa/CyPvXHS8tqATXnvPDI=
Received: from DM6PR07CA0062.namprd07.prod.outlook.com (2603:10b6:5:74::39) by
 PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.18; Mon, 30 Dec
 2024 08:15:05 +0000
Received: from CY4PEPF0000FCC5.namprd03.prod.outlook.com
 (2603:10b6:5:74:cafe::21) by DM6PR07CA0062.outlook.office365.com
 (2603:10b6:5:74::39) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8293.17 via Frontend Transport; Mon,
 30 Dec 2024 08:15:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000FCC5.mail.protection.outlook.com (10.167.242.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8293.12 via Frontend Transport; Mon, 30 Dec 2024 08:15:04 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 30 Dec
 2024 02:15:04 -0600
Received: from qdhost.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 30 Dec 2024 02:15:02 -0600
From: Kun Liu <Kun.Liu2@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <harry.wentland@amd.com>,
 <aurabindo.pillai@amd.com>
CC: <Mario.Limonciello@amd.com>, <Alexander.Deucher@amd.com>,
 <richardqi.liang@amd.com>, Kun Liu <Kun.Liu2@amd.com>
Subject: [PATCH] drm/amd/display: add CEC notifier to amdgpu driver
Date: Mon, 30 Dec 2024 16:15:01 +0800
Message-ID: <20241230081501.93823-1-Kun.Liu2@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: Kun.Liu2@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC5:EE_|PH7PR12MB5685:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f069020-7483-4db2-3a0b-08dd28aa10f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?KmEaDeOzyIvGLPjRB7unycNDo+DkDSGoH6o3ts7Sxb1MfuzG+198QdKQ/KUJ?=
 =?us-ascii?Q?gSSQLuzCAPpi+DZP6GHR03oNAt5/AnVXpbGoR0K/NsHWqqWfm1O1W280ThuB?=
 =?us-ascii?Q?3kGZdd5kkyIS3swmKc2nQDQMHixe9aJmAO25P9bOlWHmn3+mABFQPGLf0p3c?=
 =?us-ascii?Q?SBOFrG3RplYk1RSX1BWC81xRspwJWLvUTnjBfYq6vnM37GNvhfhKFkJLYBy+?=
 =?us-ascii?Q?PVsE+8eJjO1t8dPtCGXbx60+dyoODBi+W2d48coocQt70NT8DkcOXhZ0aV23?=
 =?us-ascii?Q?4BTJE/PYLaS7mLLw4XjCoWJTzqasZU770C6pUd0AgISqcHzdgvaRtbZos5PM?=
 =?us-ascii?Q?8vmhzow23IF6TDfbmgB7YigEN842CbWnLgvF0l1RLmHEIkRXRtyMmciCUnBj?=
 =?us-ascii?Q?cxg2W/cCgzOo/QuDg6gUJ6PFtf2ElSzNGcmm8aoc3zJslBZmB+u/oTzzUujb?=
 =?us-ascii?Q?c3qlHuq3cDu3NEJHusSA9/CQ25JxtigMLmiGi3XpuDZHbNwHDLsI74FYcgvT?=
 =?us-ascii?Q?UTOFOFodiUh4bIA7uhS6dxmSfYB+5vJFlfzShvvzyxJk+EWbjA2geHKDO4Ps?=
 =?us-ascii?Q?r4QL6Gs6RnDE5wW3Z25PrAFHyaNMjBM5YVuZoqKT6lRfwMcl35MruPk/++0T?=
 =?us-ascii?Q?ojYehlqTPlPBhPdVQQ6Z9L2PYcOXET6fso5qj+zf5Gj6L1N1tKjS+J8oqrvy?=
 =?us-ascii?Q?J0CizCMh7jXcHkyI+IQmvvLxQyrxtt5J3nMcRJ970H9S1NNI8tVbB6QrxcBI?=
 =?us-ascii?Q?JyoOc8vThBACezppssxv9GgpcwOpwRIZVF2mMS9oQTX/ZhIN0NOmYHHJ7HQR?=
 =?us-ascii?Q?+26W9YM06ggICJOfh+QSyBrlXRZmRF02RvNRIYC1PXA0IRh0nxQhEFQoFqGr?=
 =?us-ascii?Q?JEm8FYIunG/GffM4a7EgUjwaCTJS+RlbqK5IBclCWAKFT1atnbU0qZSrwehn?=
 =?us-ascii?Q?U0O3xMWdnFrIEkCoKtEzFwWWoSt4qZs7lXzCeR7UfwyexUOuraRuNE5FRnO+?=
 =?us-ascii?Q?0h6mN8NFDk9jb7pwDuOpbN+YQbfi8ZlGNrs9jAxMwqrAJB1TVavtBCdWUwvU?=
 =?us-ascii?Q?ypyYIEJt4lgbr4d1RWAny90dfTF/qmFlJr5aeCeVeR69XbCifw7U9JoKJoOm?=
 =?us-ascii?Q?DakQvEsdmEvn1JwB0Wxl+8iNOs9NukthNA6fM/yvc2L7Uw8/aFltvNUIqs9Z?=
 =?us-ascii?Q?rWzeSyifVvjJHTvwY8DJFYXcyr01NeReMrwWkXKJvkVrIXb7OxXVQd9F4BhL?=
 =?us-ascii?Q?vuuszmbVZ/yjZSee3T72SDjdjCqBxDqiyy5JpzgTmx5ZZS9iLxwpkbIOLT7s?=
 =?us-ascii?Q?DgvxHRhpekcK9a4tiQgmQ8t4HtFkU/+gOzbPDkq+mOtGzlJaqDD3TbrTaiiC?=
 =?us-ascii?Q?HYTGcABD0wZ1KjH5A+TkKAScx4B2txTNYlBgJhwaWPATBF7eb+Xd8UaQNfLE?=
 =?us-ascii?Q?uA93gyyFoxIkNF6hxpAcdu70FiHrDYlWUqIMw0SvB90x5PqzpT48sNN25fm2?=
 =?us-ascii?Q?4Zn1L3BhmQeRVXY=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Dec 2024 08:15:04.9024 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f069020-7483-4db2-3a0b-08dd28aa10f1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5685
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

This patch adds the cec_notifier feature to amdgpu driver.
The changes will allow amdgpu driver code to notify EDID
and HPD changes to an eventual CEC adapter.

Signed-off-by: Kun Liu <Kun.Liu2@amd.com>
---
 drivers/gpu/drm/amd/display/Kconfig           |  2 +
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 82 +++++++++++++++++++
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  4 +
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 66 ++++++++++++++-
 drivers/gpu/drm/amd/include/amd_shared.h      |  5 ++
 5 files changed, 158 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/Kconfig b/drivers/gpu/drm/amd/display/Kconfig
index 11e3f2f3b1..abd3b65643 100644
--- a/drivers/gpu/drm/amd/display/Kconfig
+++ b/drivers/gpu/drm/amd/display/Kconfig
@@ -8,6 +8,8 @@ config DRM_AMD_DC
 	bool "AMD DC - Enable new display engine"
 	default y
 	depends on BROKEN || !CC_IS_CLANG || ARM64 || LOONGARCH || RISCV || SPARC64 || X86_64
+	select CEC_CORE
+	select CEC_NOTIFIER
 	select SND_HDA_COMPONENT if SND_HDA_CORE
 	# !CC_IS_CLANG: https://github.com/ClangBuiltLinux/linux/issues/1752
 	select DRM_AMD_DC_FP if ARCH_HAS_KERNEL_FPU_SUPPORT && !(CC_IS_CLANG && (ARM64 || LOONGARCH || RISCV))
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 85f21db6ef..3bd93cc14f 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -97,6 +97,7 @@
 #include <drm/drm_audio_component.h>
 #include <drm/drm_gem_atomic_helper.h>
 
+#include <media/cec-notifier.h>
 #include <acpi/video.h>
 
 #include "ivsrcid/dcn/irqsrcs_dcn_1_0.h"
@@ -2746,6 +2747,54 @@ static void resume_mst_branch_status(struct drm_dp_mst_topology_mgr *mgr)
 	mutex_unlock(&mgr->lock);
 }
 
+static void hdmi_cec_unset_edid(struct amdgpu_dm_connector *aconnector)
+{
+	struct drm_device *ddev = aconnector->base.dev;
+	struct cec_notifier *n = aconnector->notifier;
+
+	if (!n) {
+		drm_dbg(ddev, "failed to unset edid\n");
+		return;
+	}
+
+	cec_notifier_phys_addr_invalidate(n);
+}
+
+static void hdmi_cec_set_edid(struct amdgpu_dm_connector *aconnector)
+{
+	struct drm_connector *connector = &aconnector->base;
+	struct drm_device *ddev = aconnector->base.dev;
+	struct cec_notifier *n = aconnector->notifier;
+
+	if (!n) {
+		drm_dbg(ddev, "failed to set edid\n");
+		return;
+	}
+
+	cec_notifier_set_phys_addr(n,
+			connector->display_info.source_physical_address);
+}
+
+static void s3_handle_hdmi_cec(struct drm_device *ddev, bool suspend)
+{
+	struct amdgpu_dm_connector *aconnector;
+	struct drm_connector *connector;
+	struct drm_connector_list_iter conn_iter;
+
+	drm_connector_list_iter_begin(ddev, &conn_iter);
+	drm_for_each_connector_iter(connector, &conn_iter) {
+		if (connector->connector_type == DRM_MODE_CONNECTOR_WRITEBACK)
+			continue;
+
+		aconnector = to_amdgpu_dm_connector(connector);
+		if (suspend)
+			hdmi_cec_unset_edid(aconnector);
+		else
+			hdmi_cec_set_edid(aconnector);
+	}
+	drm_connector_list_iter_end(&conn_iter);
+}
+
 static void s3_handle_mst(struct drm_device *dev, bool suspend)
 {
 	struct amdgpu_dm_connector *aconnector;
@@ -3017,6 +3066,8 @@ static int dm_suspend(struct amdgpu_ip_block *ip_block)
 	if (IS_ERR(adev->dm.cached_state))
 		return PTR_ERR(adev->dm.cached_state);
 
+	s3_handle_hdmi_cec(adev_to_drm(adev), true);
+
 	s3_handle_mst(adev_to_drm(adev), true);
 
 	amdgpu_dm_irq_suspend(adev);
@@ -3289,6 +3340,8 @@ static int dm_resume(struct amdgpu_ip_block *ip_block)
 	 */
 	amdgpu_dm_irq_resume_early(adev);
 
+	s3_handle_hdmi_cec(ddev, false);
+
 	/* On resume we need to rewrite the MSTM control bits to enable MST*/
 	s3_handle_mst(ddev, false);
 
@@ -3598,6 +3651,7 @@ void amdgpu_dm_update_connector_after_detect(
 		dc_sink_retain(aconnector->dc_sink);
 		if (sink->dc_edid.length == 0) {
 			aconnector->drm_edid = NULL;
+			hdmi_cec_unset_edid(aconnector);
 			if (aconnector->dc_link->aux_mode) {
 				drm_dp_cec_unset_edid(&aconnector->dm_dp_aux.aux);
 			}
@@ -3607,6 +3661,7 @@ void amdgpu_dm_update_connector_after_detect(
 			aconnector->drm_edid = drm_edid_alloc(edid, sink->dc_edid.length);
 			drm_edid_connector_update(connector, aconnector->drm_edid);
 
+			hdmi_cec_set_edid(aconnector);
 			if (aconnector->dc_link->aux_mode)
 				drm_dp_cec_attach(&aconnector->dm_dp_aux.aux,
 						  connector->display_info.source_physical_address);
@@ -3623,6 +3678,7 @@ void amdgpu_dm_update_connector_after_detect(
 		amdgpu_dm_update_freesync_caps(connector, aconnector->drm_edid);
 		update_connector_ext_caps(aconnector);
 	} else {
+		hdmi_cec_unset_edid(aconnector);
 		drm_dp_cec_unset_edid(&aconnector->dm_dp_aux.aux);
 		amdgpu_dm_update_freesync_caps(connector, NULL);
 		aconnector->num_modes = 0;
@@ -7042,6 +7098,7 @@ static void amdgpu_dm_connector_unregister(struct drm_connector *connector)
 	if (amdgpu_dm_should_create_sysfs(amdgpu_dm_connector))
 		sysfs_remove_group(&connector->kdev->kobj, &amdgpu_group);
 
+	cec_notifier_conn_unregister(amdgpu_dm_connector->notifier);
 	drm_dp_aux_unregister(&amdgpu_dm_connector->dm_dp_aux.aux);
 }
 
@@ -8278,6 +8335,27 @@ create_i2c(struct ddc_service *ddc_service,
 	return i2c;
 }
 
+int amdgpu_dm_initialize_hdmi_connector(struct amdgpu_dm_connector *aconnector)
+{
+	struct cec_connector_info conn_info;
+	struct drm_device *ddev = aconnector->base.dev;
+	struct device *hdmi_dev = ddev->dev;
+
+	if (amdgpu_dc_debug_mask & DC_DISABLE_HDMI_CEC) {
+		drm_info(ddev, "HDMI-CEC feature masked\n");
+		return -EINVAL;
+	}
+
+	cec_fill_conn_info_from_drm(&conn_info, &aconnector->base);
+	aconnector->notifier =
+		cec_notifier_conn_register(hdmi_dev, NULL, &conn_info);
+	if (!aconnector->notifier) {
+		drm_err(ddev, "Failed to create cec notifier\n");
+		return -ENOMEM;
+	}
+
+	return 0;
+}
 
 /*
  * Note: this function assumes that dc_link_detect() was called for the
@@ -8341,6 +8419,10 @@ static int amdgpu_dm_connector_init(struct amdgpu_display_manager *dm,
 	drm_connector_attach_encoder(
 		&aconnector->base, &aencoder->base);
 
+	if (connector_type == DRM_MODE_CONNECTOR_HDMIA
+		|| connector_type == DRM_MODE_CONNECTOR_HDMIB)
+		amdgpu_dm_initialize_hdmi_connector(aconnector);
+
 	if (connector_type == DRM_MODE_CONNECTOR_DisplayPort
 		|| connector_type == DRM_MODE_CONNECTOR_eDP)
 		amdgpu_dm_initialize_dp_connector(dm, aconnector, link->link_index);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index 6464a83783..4c1942652b 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -671,6 +671,8 @@ struct amdgpu_dm_connector {
 	uint32_t connector_id;
 	int bl_idx;
 
+	struct cec_notifier *notifier;
+
 	/* we need to mind the EDID between detect
 	   and get modes due to analog/digital/tvencoder */
 	const struct drm_edid *drm_edid;
@@ -1010,4 +1012,6 @@ void dm_free_gpu_mem(struct amdgpu_device *adev,
 
 bool amdgpu_dm_is_headless(struct amdgpu_device *adev);
 
+int amdgpu_dm_initialize_hdmi_connector(struct amdgpu_dm_connector *aconnector);
+
 #endif /* __AMDGPU_DM_H__ */
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
index 6a97bb2d91..922f329175 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
@@ -25,6 +25,7 @@
 
 #include <linux/string_helpers.h>
 #include <linux/uaccess.h>
+#include <media/cec-notifier.h>
 
 #include "dc.h"
 #include "amdgpu.h"
@@ -2825,6 +2826,67 @@ static int is_dpia_link_show(struct seq_file *m, void *data)
 	return 0;
 }
 
+/*
+ * function description: Read out the HDMI-CEC feature status
+ *
+ * Example usage:
+ * cat /sys/kernel/debug/dri/0/HDMI-A-1/hdmi_cec_state
+ */
+static int hdmi_cec_state_show(struct seq_file *m, void *data)
+{
+	struct drm_connector *connector = m->private;
+	struct amdgpu_dm_connector *aconnector = to_amdgpu_dm_connector(connector);
+
+	seq_printf(m, "%s:%d\n", connector->name, connector->base.id);
+	seq_printf(m, "HDMI-CEC status: %d\n", aconnector->notifier ? 1:0);
+
+	return 0;
+}
+
+/*
+ * function: Enable/Disable HDMI-CEC feature from driver side
+ *
+ * Example usage:
+ * echo 1 > /sys/kernel/debug/dri/0/HDMI-A-1/hdmi_cec_state
+ * echo 0 > /sys/kernel/debug/dri/0/HDMI-A-1/hdmi_cec_state
+ */
+static ssize_t hdmi_cec_state_write(struct file *f, const char __user *buf,
+				     size_t size, loff_t *pos)
+{
+	char tmp[2];
+	int ret;
+	struct amdgpu_dm_connector *aconnector = file_inode(f)->i_private;
+	struct drm_connector *dconn = &aconnector->base;
+	struct drm_device *ddev = aconnector->base.dev;
+
+	if (size == 0)
+		return -EINVAL;
+
+	if (copy_from_user(tmp, buf, 1)) {
+		drm_dbg_driver(ddev, "Failed to copy user data !\n");
+		return -EFAULT;
+	}
+
+	switch (tmp[0]) {
+	case '0':
+		cec_notifier_conn_unregister(aconnector->notifier);
+		aconnector->notifier = NULL;
+		break;
+	case '1':
+		ret = amdgpu_dm_initialize_hdmi_connector(aconnector);
+		if (ret)
+			return ret;
+		cec_notifier_set_phys_addr(aconnector->notifier,
+				dconn->display_info.source_physical_address);
+		break;
+	default:
+		drm_dbg_driver(ddev, "Unsupported param\n");
+		break;
+	}
+
+	return size;
+}
+
 DEFINE_SHOW_ATTRIBUTE(dp_dsc_fec_support);
 DEFINE_SHOW_ATTRIBUTE(dmub_fw_state);
 DEFINE_SHOW_ATTRIBUTE(dmub_tracebuffer);
@@ -2837,6 +2899,7 @@ DEFINE_SHOW_ATTRIBUTE(psr_capability);
 DEFINE_SHOW_ATTRIBUTE(dp_is_mst_connector);
 DEFINE_SHOW_ATTRIBUTE(dp_mst_progress_status);
 DEFINE_SHOW_ATTRIBUTE(is_dpia_link);
+DEFINE_SHOW_STORE_ATTRIBUTE(hdmi_cec_state);
 
 static const struct file_operations dp_dsc_clock_en_debugfs_fops = {
 	.owner = THIS_MODULE,
@@ -2972,7 +3035,8 @@ static const struct {
 	char *name;
 	const struct file_operations *fops;
 } hdmi_debugfs_entries[] = {
-		{"hdcp_sink_capability", &hdcp_sink_capability_fops}
+		{"hdcp_sink_capability", &hdcp_sink_capability_fops},
+		{"hdmi_cec_state", &hdmi_cec_state_fops}
 };
 
 /*
diff --git a/drivers/gpu/drm/amd/include/amd_shared.h b/drivers/gpu/drm/amd/include/amd_shared.h
index 98d9e840b0..05bdb4e020 100644
--- a/drivers/gpu/drm/amd/include/amd_shared.h
+++ b/drivers/gpu/drm/amd/include/amd_shared.h
@@ -344,6 +344,11 @@ enum DC_DEBUG_MASK {
 	 * eDP display from ACPI _DDC method.
 	 */
 	DC_DISABLE_ACPI_EDID = 0x8000,
+
+	/*
+	 * @DC_DISABLE_HDMI_CEC: If set, disable HDMI-CEC feature in amdgpu driver.
+	 */
+	DC_DISABLE_HDMI_CEC = 0x10000,
 };
 
 enum amd_dpm_forced_level;
-- 
2.34.1

