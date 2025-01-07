Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B527E77197
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jan 2025 12:09:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E29610E4C0;
	Tue,  7 Jan 2025 12:09:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HFzqh9aM";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2062.outbound.protection.outlook.com [40.107.92.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 130E110E4C0
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Jan 2025 12:09:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xiF49lqdos8sCLbi5l+5olw/1BnD2j4BEWh4qz4CJ5AjYdiAf5NOsGRPhaTDDYxcXyUSoddmzH/gv9sKj7tI1pr1hzC+nqFT7RYtUNvodxYGRpYMsYkquPphCEkJX/L604nin8KuSmi3XWYakCLrKSAHdmZw7SAwigTEWf6MbauuCXv0M7oOjyhcwDSKhU1Ar6GvY2C7u9604iG42+o5uGfY13MLEMDyKFcIvofYfoHvkq2yAxXVP4rzODl/0g1jJDZStlQuA0HrxHIZW93Q38vS5lx6qlz6cclAlA9jooLqCsScSBXiSz0r7mVSwuWzUBFuh9/eIIEcwndwA8SdLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q2mtZHYYiQ4AM2otLGbX7+G70j9GDEuj363MMNTkS+A=;
 b=hcCs1I6l7CpPZibXVg8p3nfcSIbpkILXvZiIjBGqEh5eVkUqgLDxd7A3hn/I5xW5MBwsFIntIgvaZaJfyOHD1H0CQObO1HmCURjRsUHJF4xnTIwlP4D9FrKhApO25XMT/Tbjw/dGyJifIRQSzprLCvOfGgLytkdxGZ5rgECwYBUi3xhKjanMzQC9ewbRCAGir0cPbX7TxlUtcNAhjYFmT8xg1UZnLLnQnl3p4iDl0htj3GBfKzBvwBZpZRu20QIJt8Dwa3o5XrPhmaWNAYywbc3N3PnmLPlZnUq4mWEQKLxRPqWkhJEsPFiN1230wrKOiMj5Oq1HULVIr2zSSa1Fsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q2mtZHYYiQ4AM2otLGbX7+G70j9GDEuj363MMNTkS+A=;
 b=HFzqh9aMvC/2PxAEiD8S8TR2txWJ+htc7mmY3XY5Z6mQ7MvA4gEiKvO7SO+Vxfc9snFTwqANXML3eKnVNkm9TCmip6x5J5XUmsW+ft6U7lHZN3XcJ5KHQ5uiwe31DMljRGVEzaSSgDdHGnn6L3Zy4NDlb1nDC5rw/IKI8XyC2oo=
Received: from MN2PR14CA0027.namprd14.prod.outlook.com (2603:10b6:208:23e::32)
 by DS7PR12MB8345.namprd12.prod.outlook.com (2603:10b6:8:d8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Tue, 7 Jan
 2025 12:08:53 +0000
Received: from BN1PEPF00004686.namprd03.prod.outlook.com
 (2603:10b6:208:23e:cafe::4c) by MN2PR14CA0027.outlook.office365.com
 (2603:10b6:208:23e::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8335.11 via Frontend Transport; Tue,
 7 Jan 2025 12:08:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00004686.mail.protection.outlook.com (10.167.243.91) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8335.7 via Frontend Transport; Tue, 7 Jan 2025 12:08:52 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 7 Jan
 2025 06:08:52 -0600
Received: from qdhost.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 7 Jan 2025 06:08:50 -0600
From: Kun Liu <Kun.Liu2@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <harry.wentland@amd.com>,
 <Mario.Limonciello@amd.com>
CC: <richardqi.liang@amd.com>, Kun Liu <Kun.Liu2@amd.com>
Subject: [PATCH v2] drm/amd/display: add CEC notifier to amdgpu driver
Date: Tue, 7 Jan 2025 20:08:50 +0800
Message-ID: <20250107120850.213843-1-Kun.Liu2@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Kun.Liu2@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004686:EE_|DS7PR12MB8345:EE_
X-MS-Office365-Filtering-Correlation-Id: e700f75a-ddf4-4219-9a7d-08dd2f140d66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?vDyyukwWyX6iDdp0G26RecNMNLlnCje2FDHnpN43WUkp4PJcmFWgcJHW6kma?=
 =?us-ascii?Q?4nP/vaNBZnx3YncZG2+wGT1RrDegdHkw6OvNHaD6k+pKuAF48B5WIw2/uCjt?=
 =?us-ascii?Q?r9Fv4G5DWvw1p1W/bid1ELyVfj7Sy6wczwd9efOMAKxnMcjTaKX00AsTbhO6?=
 =?us-ascii?Q?+tZEIL1Uz7JqaVLWa1AFmL5rLWClfs2N6XyDR3C9uT6RJey+ySh/h8pLHbBY?=
 =?us-ascii?Q?uEOANvsLIzidfpZJpZptWE9rixKlog8BaZRd4VPQLOdJT0DX8EjOfNqOGOns?=
 =?us-ascii?Q?qooyuGY/mSIhLcOz7HvqTm9wUk52fQCFZyhuc4go3FZzpBaeC8mKsYDhzHbY?=
 =?us-ascii?Q?jRlsRDTd0qAg4NViGIiuANL1XJHy76jLOj6JoGGX5+8KfbSNMpuRie9Zn6zZ?=
 =?us-ascii?Q?HCm0gj409Z3iNjgYwAlk61Zt/BA25gRl2eKYV5xkzuzFIKxGJHchP3KLIXc2?=
 =?us-ascii?Q?iqpxuynYRTFjVV/jXjKERo+Ku7ll6Khsc+p11oESiwtUZRqFKIhWUSDohAGK?=
 =?us-ascii?Q?3rlh+oOSi59isIZb2smEF8JDZjTq3M29lx7XxiQBSqYEEvereyDz6iEsEaC1?=
 =?us-ascii?Q?VMJ03jka/bfw3pj3owwigBptASObyUEuGefpDCIzOTw1jRTy0r8N4M4jB79j?=
 =?us-ascii?Q?KFctRLx93ZKHIlg/Qkbnf42qNCtEaUn8uZ35la1Wzpu5BMl5tZvkH66l05dm?=
 =?us-ascii?Q?UhnBGtNR7JunHgFVKOHoc0Bk0YhnWtj0SF+wPNepnCFxqJG5lzbubsuI19TS?=
 =?us-ascii?Q?GtTsUo3BpBoRxikYRE2H7AWoaLcUzZrL2X1JXTDTXhKS6QscUGDayIO8NgXH?=
 =?us-ascii?Q?+9BTkKWD4TMQutD9Yhe6yHDSfGfXtSXc8J0Mnk3Uabw/+BtmWfO47DHpMVZf?=
 =?us-ascii?Q?lyJ5L5ddyz0mCAIcfTL3zgVqpIMQDUyPDycXlL4JsKL7Z2X1Y3k9NL753BsK?=
 =?us-ascii?Q?XQ1J1gW2dnlNRX3iF6Lktty791E03Gh4LSWhqy6eJa/uUrdnmbHS9E3yJi9J?=
 =?us-ascii?Q?zWvvBtLL8RkeUa9HYRPjIOt3eFb/6wptpcX5+oHwm1jtwPwMoiSTKkSY7D3O?=
 =?us-ascii?Q?87ULbiudK07M3k1xT106ZclgvUWSbL7l4vIL5zch2S96hZAoB4U85pRhFEbK?=
 =?us-ascii?Q?42iKnkuh8aw9Yb9HLGlYvJ+ish51eGcbEA2FWKF4bf2lwVKyk9OX8noop4Ea?=
 =?us-ascii?Q?QKKrIu7cTFydD7n6QXvD/wBlTVeqpgDNNy/KUV3A0X9B8qRzX/345lDqsyAs?=
 =?us-ascii?Q?qp1xpWYubh3QH9qZ7FxjnuzOvrVNK68KnTY8k4bXj0spx6NSSJeNOProKaRL?=
 =?us-ascii?Q?HEG5KFPKPgxgE2EVGiVQJdaJr7HAVb58c3PHRB794yKMkUqFXKq1qQar9Qww?=
 =?us-ascii?Q?KxMOUmqAC3vkSEa3Acm92fZR4zIhnUAbODqPzq/ZHhS8IO5Xesy7qvm+T6j+?=
 =?us-ascii?Q?mBhvXBmQkt8=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 12:08:52.6532 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e700f75a-ddf4-4219-9a7d-08dd2f140d66
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004686.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8345
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
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 76 +++++++++++++++++++
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  6 ++
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 66 +++++++++++++++-
 drivers/gpu/drm/amd/include/amd_shared.h      |  5 ++
 5 files changed, 154 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/Kconfig b/drivers/gpu/drm/amd/display/Kconfig
index 11e3f2f3b..abd3b6564 100644
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
index 49baef9dd..1db955c28 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -97,6 +97,7 @@
 #include <drm/drm_audio_component.h>
 #include <drm/drm_gem_atomic_helper.h>
 
+#include <media/cec-notifier.h>
 #include <acpi/video.h>
 
 #include "ivsrcid/dcn/irqsrcs_dcn_1_0.h"
@@ -2751,6 +2752,48 @@ static void resume_mst_branch_status(struct drm_dp_mst_topology_mgr *mgr)
 	mutex_unlock(&mgr->lock);
 }
 
+void hdmi_cec_unset_edid(struct amdgpu_dm_connector *aconnector)
+{
+	struct cec_notifier *n = aconnector->notifier;
+
+	if (!n)
+		return;
+
+	cec_notifier_phys_addr_invalidate(n);
+}
+
+void hdmi_cec_set_edid(struct amdgpu_dm_connector *aconnector)
+{
+	struct drm_connector *connector = &aconnector->base;
+	struct cec_notifier *n = aconnector->notifier;
+
+	if (!n)
+		return;
+
+	cec_notifier_set_phys_addr(n,
+				   connector->display_info.source_physical_address);
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
@@ -3022,6 +3065,8 @@ static int dm_suspend(struct amdgpu_ip_block *ip_block)
 	if (IS_ERR(adev->dm.cached_state))
 		return PTR_ERR(adev->dm.cached_state);
 
+	s3_handle_hdmi_cec(adev_to_drm(adev), true);
+
 	s3_handle_mst(adev_to_drm(adev), true);
 
 	amdgpu_dm_irq_suspend(adev);
@@ -3294,6 +3339,8 @@ static int dm_resume(struct amdgpu_ip_block *ip_block)
 	 */
 	amdgpu_dm_irq_resume_early(adev);
 
+	s3_handle_hdmi_cec(ddev, false);
+
 	/* On resume we need to rewrite the MSTM control bits to enable MST*/
 	s3_handle_mst(ddev, false);
 
@@ -3603,6 +3650,7 @@ void amdgpu_dm_update_connector_after_detect(
 		dc_sink_retain(aconnector->dc_sink);
 		if (sink->dc_edid.length == 0) {
 			aconnector->drm_edid = NULL;
+			hdmi_cec_unset_edid(aconnector);
 			if (aconnector->dc_link->aux_mode) {
 				drm_dp_cec_unset_edid(&aconnector->dm_dp_aux.aux);
 			}
@@ -3612,6 +3660,7 @@ void amdgpu_dm_update_connector_after_detect(
 			aconnector->drm_edid = drm_edid_alloc(edid, sink->dc_edid.length);
 			drm_edid_connector_update(connector, aconnector->drm_edid);
 
+			hdmi_cec_set_edid(aconnector);
 			if (aconnector->dc_link->aux_mode)
 				drm_dp_cec_attach(&aconnector->dm_dp_aux.aux,
 						  connector->display_info.source_physical_address);
@@ -3628,6 +3677,7 @@ void amdgpu_dm_update_connector_after_detect(
 		amdgpu_dm_update_freesync_caps(connector, aconnector->drm_edid);
 		update_connector_ext_caps(aconnector);
 	} else {
+		hdmi_cec_unset_edid(aconnector);
 		drm_dp_cec_unset_edid(&aconnector->dm_dp_aux.aux);
 		amdgpu_dm_update_freesync_caps(connector, NULL);
 		aconnector->num_modes = 0;
@@ -7044,6 +7094,7 @@ static void amdgpu_dm_connector_unregister(struct drm_connector *connector)
 	if (amdgpu_dm_should_create_sysfs(amdgpu_dm_connector))
 		sysfs_remove_group(&connector->kdev->kobj, &amdgpu_group);
 
+	cec_notifier_conn_unregister(amdgpu_dm_connector->notifier);
 	drm_dp_aux_unregister(&amdgpu_dm_connector->dm_dp_aux.aux);
 }
 
@@ -8280,6 +8331,27 @@ create_i2c(struct ddc_service *ddc_service,
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
@@ -8343,6 +8415,10 @@ static int amdgpu_dm_connector_init(struct amdgpu_display_manager *dm,
 	drm_connector_attach_encoder(
 		&aconnector->base, &aencoder->base);
 
+	if (connector_type == DRM_MODE_CONNECTOR_HDMIA ||
+	    connector_type == DRM_MODE_CONNECTOR_HDMIB)
+		amdgpu_dm_initialize_hdmi_connector(aconnector);
+
 	if (connector_type == DRM_MODE_CONNECTOR_DisplayPort
 		|| connector_type == DRM_MODE_CONNECTOR_eDP)
 		amdgpu_dm_initialize_dp_connector(dm, aconnector, link->link_index);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index e46e1365f..76fa3e785 100644
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
@@ -1010,4 +1012,8 @@ void dm_free_gpu_mem(struct amdgpu_device *adev,
 
 bool amdgpu_dm_is_headless(struct amdgpu_device *adev);
 
+void hdmi_cec_set_edid(struct amdgpu_dm_connector *aconnector);
+void hdmi_cec_unset_edid(struct amdgpu_dm_connector *aconnector);
+int amdgpu_dm_initialize_hdmi_connector(struct amdgpu_dm_connector *aconnector);
+
 #endif /* __AMDGPU_DM_H__ */
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
index 0d84308c5..d189dddb1 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
@@ -25,6 +25,7 @@
 
 #include <linux/string_helpers.h>
 #include <linux/uaccess.h>
+#include <media/cec-notifier.h>
 
 #include "dc.h"
 #include "amdgpu.h"
@@ -2848,6 +2849,67 @@ static int is_dpia_link_show(struct seq_file *m, void *data)
 	return 0;
 }
 
+/**
+ * hdmi_cec_state_show - Read out the HDMI-CEC feature status
+ * @m: sequence file.
+ * @data: unused.
+ *
+ * Return 0 on success
+ */
+static int hdmi_cec_state_show(struct seq_file *m, void *data)
+{
+	struct drm_connector *connector = m->private;
+	struct amdgpu_dm_connector *aconnector = to_amdgpu_dm_connector(connector);
+
+	seq_printf(m, "%s:%d\n", connector->name, connector->base.id);
+	seq_printf(m, "HDMI-CEC status: %d\n", aconnector->notifier ? 1 : 0);
+
+	return 0;
+}
+
+/**
+ * hdmi_cec_state_write - Enable/Disable HDMI-CEC feature from driver side
+ * @f: file structure.
+ * @buf: userspace buffer. set to '1' to enable; '0' to disable cec feature.
+ * @size: size of buffer from userpsace.
+ * @pos: unused.
+ *
+ * Return size on success, error code on failure
+ */
+static ssize_t hdmi_cec_state_write(struct file *f, const char __user *buf,
+				     size_t size, loff_t *pos)
+{
+	int ret;
+	bool enable;
+	struct amdgpu_dm_connector *aconnector = file_inode(f)->i_private;
+	struct drm_device *ddev = aconnector->base.dev;
+
+	if (size == 0)
+		return -EINVAL;
+
+	ret = kstrtobool_from_user(buf, size, &enable);
+	if (ret) {
+		drm_dbg_driver(ddev, "invalid user data !\n");
+		return ret;
+	}
+
+	if (enable) {
+		if (aconnector->notifier)
+			return -EINVAL;
+		ret = amdgpu_dm_initialize_hdmi_connector(aconnector);
+		if (ret)
+			return ret;
+		hdmi_cec_set_edid(aconnector);
+	} else {
+		if (!aconnector->notifier)
+			return -EINVAL;
+		cec_notifier_conn_unregister(aconnector->notifier);
+		aconnector->notifier = NULL;
+	}
+
+	return size;
+}
+
 DEFINE_SHOW_ATTRIBUTE(dp_dsc_fec_support);
 DEFINE_SHOW_ATTRIBUTE(dmub_fw_state);
 DEFINE_SHOW_ATTRIBUTE(dmub_tracebuffer);
@@ -2860,6 +2922,7 @@ DEFINE_SHOW_ATTRIBUTE(psr_capability);
 DEFINE_SHOW_ATTRIBUTE(dp_is_mst_connector);
 DEFINE_SHOW_ATTRIBUTE(dp_mst_progress_status);
 DEFINE_SHOW_ATTRIBUTE(is_dpia_link);
+DEFINE_SHOW_STORE_ATTRIBUTE(hdmi_cec_state);
 
 static const struct file_operations dp_dsc_clock_en_debugfs_fops = {
 	.owner = THIS_MODULE,
@@ -2995,7 +3058,8 @@ static const struct {
 	char *name;
 	const struct file_operations *fops;
 } hdmi_debugfs_entries[] = {
-		{"hdcp_sink_capability", &hdcp_sink_capability_fops}
+		{"hdcp_sink_capability", &hdcp_sink_capability_fops},
+		{"hdmi_cec_state", &hdmi_cec_state_fops}
 };
 
 /*
diff --git a/drivers/gpu/drm/amd/include/amd_shared.h b/drivers/gpu/drm/amd/include/amd_shared.h
index 98d9e840b..05bdb4e02 100644
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
2.47.0

