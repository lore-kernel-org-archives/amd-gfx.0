Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45942C64EC4
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Mar 2023 15:47:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9508F10E6D2;
	Fri,  3 Mar 2023 15:47:08 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20622.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::622])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2316F10E6D2
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Mar 2023 15:47:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SS+j/7aHQd3vmjKbKNcXM5EVH4Z6l8Ja7WhQU5FUuiOa2Ncrylr4CfL205T65oZKf7JfAqq6ERUYWQc/HgVu9dpsXviK3OC1PJya27S8NNdRvN3QXTNHqkVQiRXPQVHY8CMbCWYKsuOvcER/rxA7TE46IwGB23lMVxtxaw2Mo1X7uEzBrtslNPc9jS7DyK9JXiBijE7mepXW3B0qjIcApki9tf5ImO2bxA0fMT0jzH/JcUgn1tYOKRpnNmZ/vnWW6W/D3qYwzE5YTRkOUa2sRkmi6ThM66++SGp/GbvAdUYxoVpA84sy4pD089+qM8ve7X5QMlkb/JVGuuNl0efPiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NP0oeKsx7eIsTHxzl8Z+UF2v033SDmLz4InqzyXQsqM=;
 b=KQ8P+jd10cca5RpFCRCl0wefBn1R5jZheJZMoj6M9C9EnFt2yyBKOFD+IL8HSuWSI+LggnSpBURpsaD7cPIUdD1rHj+33w2hqtlj7zw1EtJjkh1Lw6qxlhMehV3q5JJ6yAjbsNiHPeFFyYQk0cg1zzK+48vfq7LEgvSdPPcMo1RpOIMDk+o13Ffg2qBR2kbXogn7a7kraBg+oPyJGA72EnC8RDHNlgevzTgW+NjZXznMWH9iaaqnyOzdZ4t/TJraqfcZ7J3t/jf025hpygr38k6fMv+u07hQD+RztFgDq6OUWGPO+nd75gqchrmmf5W9aDEHdfteBeB3QlBx78L3Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NP0oeKsx7eIsTHxzl8Z+UF2v033SDmLz4InqzyXQsqM=;
 b=MjPlvHd3+/YvGxpfM+/R/gNzEg72DfwiD9H0/sahdfe0jpohzBazgxXjXGdIXOKY+w++Mpvsi+sRUNP95ETK7s4XylMx8digqGZZvh0Apr5gi/2yrURv0AC6rIqXXhqwBlTgLSRzfPm9JHWAWJhChK6XLot7rypJaNdmkXCadNY=
Received: from MW4PR03CA0160.namprd03.prod.outlook.com (2603:10b6:303:8d::15)
 by MN6PR12MB8566.namprd12.prod.outlook.com (2603:10b6:208:47c::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.18; Fri, 3 Mar
 2023 15:47:03 +0000
Received: from CO1NAM11FT007.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8d:cafe::f8) by MW4PR03CA0160.outlook.office365.com
 (2603:10b6:303:8d::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.21 via Frontend
 Transport; Fri, 3 Mar 2023 15:47:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT007.mail.protection.outlook.com (10.13.174.131) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6156.21 via Frontend Transport; Fri, 3 Mar 2023 15:47:02 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 3 Mar
 2023 09:46:43 -0600
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 10/33] drm/amd/display: Drop CONFIG_DRM_AMD_DC_HDCP
Date: Fri, 3 Mar 2023 10:39:59 -0500
Message-ID: <20230303154022.2667-11-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230303154022.2667-1-qingqing.zhuo@amd.com>
References: <20230303154022.2667-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT007:EE_|MN6PR12MB8566:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c8ae684-ef69-4610-7438-08db1bfe888a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l78tU8PHm8vu5Qfk/0Ye9GSGMgzTTyVH/K2Z3M7kiiBrdx3YKAkmmCKzrWXriKvsitAI+GTu5udNrIhJtEhEbOve26Hp5kUKpaYKLJWpq/jdB85bkRY1pe2xxR13GUbviuOaAsvYtkC9mwlithvLiR+R7RGOBYPYudGjjiI6ZybSdzfobWzG3uvulh4zN9QxF9rY5E7nxlgfNK0z2QgiYCPCU2QNKM+KRAcIf7q6JORyjLfWSGmhuGscNK1dZFt1WQf7iXN1dLlM3Upvb55x2V23YTNOZulNWiDWeE+uACuXGxCnohkNiDK4jkydDmYfzcCN1Ds8vhPKy323jrVvkXP3dWeRw7ak/y9zh2TRK3BRmwBu06y3oygE5w5yRC7ZEH4+ZFmNamRnEb3oh6YkLyJ1ioZIg4HxtvtrwKDI0s1yH3viW0zouq7BX71dAzGAFA9VLVc+LRNtT1iOaPE5N1IR/t9vb7JIQy9lUTUdNjTJyFyj0aASNdmHFSnpT0juEDOBUzYzpOd6g9LRZ6SDOwL5sUl/CDYV4+qbMPM20vM3JR4BRexLW8/7P17eIsR/R9L2abICM7mI1Ry/uRDNIBoH+btNvud//2aU3n47lHTDHtJUSNq88m/GR+GmR+rqSO7A14HRtP/iSayUMoBf7mcU6KMn+Ay7+PSTwIlQJSN2/vKBIjCXmE307WImz1H9ECZkYYu0PWtnl4h58h3NWctQ3mghao4ro0IsHEJHdUg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(376002)(136003)(39860400002)(396003)(346002)(451199018)(46966006)(36840700001)(40470700004)(2906002)(70206006)(82310400005)(8676002)(316002)(70586007)(44832011)(36756003)(41300700001)(8936002)(4326008)(6916009)(40480700001)(426003)(2616005)(40460700003)(47076005)(83380400001)(336012)(26005)(186003)(1076003)(16526019)(356005)(478600001)(54906003)(86362001)(82740400003)(36860700001)(6666004)(81166007)(30864003)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2023 15:47:02.8069 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c8ae684-ef69-4610-7438-08db1bfe888a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT007.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8566
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com,
 Harry Wentland <harry.wentland@amd.com>, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, Wenjing Liu <Wenjing.Liu@amd.com>,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Harry Wentland <harry.wentland@amd.com>

[Why & How]
There is no reason we still need a config option for this.

Reviewed-by: Wenjing Liu <Wenjing.Liu@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Harry Wentland <harry.wentland@amd.com>
---
 drivers/gpu/drm/amd/display/Kconfig           |  6 -----
 drivers/gpu/drm/amd/display/Makefile          |  4 ----
 .../gpu/drm/amd/display/amdgpu_dm/Makefile    |  2 --
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 24 -------------------
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  4 ----
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 11 +--------
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   |  5 ----
 drivers/gpu/drm/amd/display/dc/Makefile       |  2 --
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  4 ----
 .../drm/amd/display/dc/core/dc_link_exports.c |  2 --
 drivers/gpu/drm/amd/display/dc/dc.h           | 15 +-----------
 drivers/gpu/drm/amd/display/dc/dc_types.h     |  6 -----
 .../dc/dcn32/dcn32_dio_stream_encoder.c       |  2 --
 .../gpu/drm/amd/display/dc/hdcp/hdcp_msg.c    |  2 +-
 .../gpu/drm/amd/display/dc/inc/core_types.h   |  2 --
 drivers/gpu/drm/amd/display/dc/inc/link.h     |  2 --
 .../drm/amd/display/dc/link/link_detection.c  | 10 --------
 .../gpu/drm/amd/display/dc/link/link_dpms.c   | 10 --------
 .../dc/link/protocols/link_dp_training.c      |  2 --
 .../{hdcp_types.h => hdcp_msg_types.h}        |  0
 .../drm/amd/display/modules/hdcp/hdcp_log.h   |  2 --
 21 files changed, 3 insertions(+), 114 deletions(-)
 rename drivers/gpu/drm/amd/display/include/{hdcp_types.h => hdcp_msg_types.h} (100%)

diff --git a/drivers/gpu/drm/amd/display/Kconfig b/drivers/gpu/drm/amd/display/Kconfig
index 195ad3ca5aa9..2426cad1de2a 100644
--- a/drivers/gpu/drm/amd/display/Kconfig
+++ b/drivers/gpu/drm/amd/display/Kconfig
@@ -18,12 +18,6 @@ config DRM_AMD_DC_DCN
 	help
 	  Raven, Navi, and newer family support for display engine
 
-config DRM_AMD_DC_HDCP
-	bool "Enable HDCP support in DC"
-	depends on DRM_AMD_DC
-	help
-	  Choose this option if you want to support HDCP authentication.
-
 config DRM_AMD_DC_SI
 	bool "AMD DC support for Southern Islands ASICs"
 	depends on DRM_AMDGPU_SI
diff --git a/drivers/gpu/drm/amd/display/Makefile b/drivers/gpu/drm/amd/display/Makefile
index 2633de77de5e..0d610cb376bb 100644
--- a/drivers/gpu/drm/amd/display/Makefile
+++ b/drivers/gpu/drm/amd/display/Makefile
@@ -36,18 +36,14 @@ subdir-ccflags-y += -I$(FULL_AMD_DISPLAY_PATH)/modules/info_packet
 subdir-ccflags-y += -I$(FULL_AMD_DISPLAY_PATH)/modules/power
 subdir-ccflags-y += -I$(FULL_AMD_DISPLAY_PATH)/dmub/inc
 
-ifdef CONFIG_DRM_AMD_DC_HDCP
 subdir-ccflags-y += -I$(FULL_AMD_DISPLAY_PATH)/modules/hdcp
-endif
 
 #TODO: remove when Timing Sync feature is complete
 subdir-ccflags-y += -DBUILD_FEATURE_TIMING_SYNC=0
 
 DAL_LIBS = amdgpu_dm dc	modules/freesync modules/color modules/info_packet modules/power dmub/src
 
-ifdef CONFIG_DRM_AMD_DC_HDCP
 DAL_LIBS += modules/hdcp
-endif
 
 AMD_DAL = $(addsuffix /Makefile, $(addprefix $(FULL_AMD_DISPLAY_PATH)/,$(DAL_LIBS)))
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/Makefile b/drivers/gpu/drm/amd/display/amdgpu_dm/Makefile
index 90fb0f3cdb6f..aef782ca3706 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/Makefile
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/Makefile
@@ -41,9 +41,7 @@ ifneq ($(CONFIG_DRM_AMD_DC),)
 AMDGPUDM += amdgpu_dm_services.o amdgpu_dm_helpers.o amdgpu_dm_pp_smu.o amdgpu_dm_psr.o
 endif
 
-ifdef CONFIG_DRM_AMD_DC_HDCP
 AMDGPUDM += amdgpu_dm_hdcp.o
-endif
 
 ifneq ($(CONFIG_DEBUG_FS),)
 AMDGPUDM += amdgpu_dm_crc.o amdgpu_dm_debugfs.o
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 553406ec24bf..7c7f32e46945 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -52,10 +52,8 @@
 #include "amdgpu_dm.h"
 #include "amdgpu_dm_plane.h"
 #include "amdgpu_dm_crtc.h"
-#ifdef CONFIG_DRM_AMD_DC_HDCP
 #include "amdgpu_dm_hdcp.h"
 #include <drm/display/drm_hdcp_helper.h>
-#endif
 #include "amdgpu_pm.h"
 #include "amdgpu_atombios.h"
 
@@ -1488,9 +1486,7 @@ static void retrieve_dmi_info(struct amdgpu_display_manager *dm)
 static int amdgpu_dm_init(struct amdgpu_device *adev)
 {
 	struct dc_init_data init_data;
-#ifdef CONFIG_DRM_AMD_DC_HDCP
 	struct dc_callback_init init_params;
-#endif
 	int r;
 
 	adev->dm.ddev = adev_to_drm(adev);
@@ -1498,9 +1494,7 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 
 	/* Zero all the fields */
 	memset(&init_data, 0, sizeof(init_data));
-#ifdef CONFIG_DRM_AMD_DC_HDCP
 	memset(&init_params, 0, sizeof(init_params));
-#endif
 
 	mutex_init(&adev->dm.dpia_aux_lock);
 	mutex_init(&adev->dm.dc_lock);
@@ -1726,7 +1720,6 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 			DRM_ERROR("amdgpu: failed to initialize vblank_workqueue.\n");
 	}
 
-#ifdef CONFIG_DRM_AMD_DC_HDCP
 	if (adev->dm.dc->caps.max_links > 0 && adev->family >= AMDGPU_FAMILY_RV) {
 		adev->dm.hdcp_workqueue = hdcp_create_workqueue(adev, &init_params.cp_psp, adev->dm.dc);
 
@@ -1737,7 +1730,6 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 
 		dc_init_callbacks(adev->dm.dc, &init_params);
 	}
-#endif
 #if defined(CONFIG_DRM_AMD_SECURE_DISPLAY)
 	adev->dm.secure_display_ctxs = amdgpu_dm_crtc_secure_display_create_contexts(adev);
 	if (!adev->dm.secure_display_ctxs) {
@@ -1844,7 +1836,6 @@ static void amdgpu_dm_fini(struct amdgpu_device *adev)
 		adev->dm.secure_display_ctxs = NULL;
 	}
 #endif
-#ifdef CONFIG_DRM_AMD_DC_HDCP
 	if (adev->dm.hdcp_workqueue) {
 		hdcp_destroy(&adev->dev->kobj, adev->dm.hdcp_workqueue);
 		adev->dm.hdcp_workqueue = NULL;
@@ -1852,7 +1843,6 @@ static void amdgpu_dm_fini(struct amdgpu_device *adev)
 
 	if (adev->dm.dc)
 		dc_deinit_callbacks(adev->dm.dc);
-#endif
 
 	dc_dmub_srv_destroy(&adev->dm.dc->ctx->dmub_srv);
 
@@ -3112,11 +3102,9 @@ void amdgpu_dm_update_connector_after_detect(
 		aconnector->edid = NULL;
 		kfree(aconnector->timing_requested);
 		aconnector->timing_requested = NULL;
-#ifdef CONFIG_DRM_AMD_DC_HDCP
 		/* Set CP to DESIRED if it was ENABLED, so we can re-enable it again on hotplug */
 		if (connector->state->content_protection == DRM_MODE_CONTENT_PROTECTION_ENABLED)
 			connector->state->content_protection = DRM_MODE_CONTENT_PROTECTION_DESIRED;
-#endif
 	}
 
 	mutex_unlock(&dev->mode_config.mutex);
@@ -3133,9 +3121,7 @@ static void handle_hpd_irq_helper(struct amdgpu_dm_connector *aconnector)
 	struct drm_device *dev = connector->dev;
 	enum dc_connection_type new_connection_type = dc_connection_none;
 	struct amdgpu_device *adev = drm_to_adev(dev);
-#ifdef CONFIG_DRM_AMD_DC_HDCP
 	struct dm_connector_state *dm_con_state = to_dm_connector_state(connector->state);
-#endif
 	bool ret = false;
 
 	if (adev->dm.disable_hpd_irq)
@@ -3147,12 +3133,10 @@ static void handle_hpd_irq_helper(struct amdgpu_dm_connector *aconnector)
 	 */
 	mutex_lock(&aconnector->hpd_lock);
 
-#ifdef CONFIG_DRM_AMD_DC_HDCP
 	if (adev->dm.hdcp_workqueue) {
 		hdcp_reset_display(adev->dm.hdcp_workqueue, aconnector->dc_link->link_index);
 		dm_con_state->update_hdcp = true;
 	}
-#endif
 	if (aconnector->fake_enable)
 		aconnector->fake_enable = false;
 
@@ -3399,12 +3383,10 @@ static void handle_hpd_rx_irq(void *param)
 			}
 		}
 	}
-#ifdef CONFIG_DRM_AMD_DC_HDCP
 	if (hpd_irq_data.bytes.device_service_irq.bits.CP_IRQ) {
 		if (adev->dm.hdcp_workqueue)
 			hdcp_handle_cpirq(adev->dm.hdcp_workqueue,  aconnector->base.index);
 	}
-#endif
 
 	if (dc_link->type != dc_connection_mst_branch)
 		drm_dp_cec_irq(&aconnector->dm_dp_aux.aux);
@@ -7275,10 +7257,8 @@ void amdgpu_dm_connector_init_helper(struct amdgpu_display_manager *dm,
 		if (!aconnector->mst_root)
 			drm_connector_attach_vrr_capable_property(&aconnector->base);
 
-#ifdef CONFIG_DRM_AMD_DC_HDCP
 		if (adev->dm.hdcp_workqueue)
 			drm_connector_attach_content_protection_property(&aconnector->base, true);
-#endif
 	}
 }
 
@@ -7540,7 +7520,6 @@ is_scaling_state_different(const struct dm_connector_state *dm_state,
 	return false;
 }
 
-#ifdef CONFIG_DRM_AMD_DC_HDCP
 static bool is_content_protection_different(struct drm_crtc_state *new_crtc_state,
 					    struct drm_crtc_state *old_crtc_state,
 					    struct drm_connector_state *new_conn_state,
@@ -7660,7 +7639,6 @@ static bool is_content_protection_different(struct drm_crtc_state *new_crtc_stat
 	pr_debug("[HDCP_DM] DESIRED->ENABLED %s :false\n", __func__);
 	return false;
 }
-#endif
 
 static void remove_stream(struct amdgpu_device *adev,
 			  struct amdgpu_crtc *acrtc,
@@ -8540,7 +8518,6 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
 				acrtc->otg_inst = status->primary_otg_inst;
 		}
 	}
-#ifdef CONFIG_DRM_AMD_DC_HDCP
 	for_each_oldnew_connector_in_state(state, connector, old_con_state, new_con_state, i) {
 		struct dm_connector_state *dm_new_con_state = to_dm_connector_state(new_con_state);
 		struct amdgpu_crtc *acrtc = to_amdgpu_crtc(dm_new_con_state->base.crtc);
@@ -8651,7 +8628,6 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
 				new_con_state->hdcp_content_type, enable_encryption);
 		}
 	}
-#endif
 
 	/* Handle connector state changes */
 	for_each_oldnew_connector_in_state(state, connector, old_con_state, new_con_state, i) {
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index ed5cbe9da40c..904f9e2fd35b 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -461,9 +461,7 @@ struct amdgpu_display_manager {
 	struct amdgpu_dm_backlight_caps backlight_caps[AMDGPU_DM_MAX_NUM_EDP];
 
 	struct mod_freesync *freesync_module;
-#ifdef CONFIG_DRM_AMD_DC_HDCP
 	struct hdcp_workqueue *hdcp_workqueue;
-#endif
 
 	/**
 	 * @vblank_control_workqueue:
@@ -747,9 +745,7 @@ struct dm_connector_state {
 	uint8_t underscan_hborder;
 	bool underscan_enable;
 	bool freesync_capable;
-#ifdef CONFIG_DRM_AMD_DC_HDCP
 	bool update_hdcp;
-#endif
 	uint8_t abm_level;
 	int vcpi_slots;
 	uint64_t pbn;
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
index 4a5dae578d97..abf7895d1608 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
@@ -947,7 +947,6 @@ static ssize_t dp_dsc_passthrough_set(struct file *f, const char __user *buf,
 	return 0;
 }
 
-#ifdef CONFIG_DRM_AMD_DC_HDCP
 /*
  * Returns the HDCP capability of the Display (1.4 for now).
  *
@@ -984,7 +983,6 @@ static int hdcp_sink_capability_show(struct seq_file *m, void *data)
 
 	return 0;
 }
-#endif
 
 /*
  * Returns whether the connected display is internal and not hotpluggable.
@@ -2593,9 +2591,7 @@ DEFINE_SHOW_ATTRIBUTE(dp_dsc_fec_support);
 DEFINE_SHOW_ATTRIBUTE(dmub_fw_state);
 DEFINE_SHOW_ATTRIBUTE(dmub_tracebuffer);
 DEFINE_SHOW_ATTRIBUTE(dp_lttpr_status);
-#ifdef CONFIG_DRM_AMD_DC_HDCP
 DEFINE_SHOW_ATTRIBUTE(hdcp_sink_capability);
-#endif
 DEFINE_SHOW_ATTRIBUTE(internal_display);
 DEFINE_SHOW_ATTRIBUTE(psr_capability);
 DEFINE_SHOW_ATTRIBUTE(dp_is_mst_connector);
@@ -2726,9 +2722,7 @@ static const struct {
 		{"phy_settings", &dp_phy_settings_debugfs_fop},
 		{"lttpr_status", &dp_lttpr_status_fops},
 		{"test_pattern", &dp_phy_test_pattern_fops},
-#ifdef CONFIG_DRM_AMD_DC_HDCP
 		{"hdcp_sink_capability", &hdcp_sink_capability_fops},
-#endif
 		{"sdp_message", &sdp_message_fops},
 		{"aux_dpcd_address", &dp_dpcd_address_debugfs_fops},
 		{"aux_dpcd_size", &dp_dpcd_size_debugfs_fops},
@@ -2749,14 +2743,13 @@ static const struct {
 		{"is_dpia_link", &is_dpia_link_fops}
 };
 
-#ifdef CONFIG_DRM_AMD_DC_HDCP
 static const struct {
 	char *name;
 	const struct file_operations *fops;
 } hdmi_debugfs_entries[] = {
 		{"hdcp_sink_capability", &hdcp_sink_capability_fops}
 };
-#endif
+
 /*
  * Force YUV420 output if available from the given mode
  */
@@ -3015,7 +3008,6 @@ void connector_debugfs_init(struct amdgpu_dm_connector *connector)
 	connector->debugfs_dpcd_address = 0;
 	connector->debugfs_dpcd_size = 0;
 
-#ifdef CONFIG_DRM_AMD_DC_HDCP
 	if (connector->base.connector_type == DRM_MODE_CONNECTOR_HDMIA) {
 		for (i = 0; i < ARRAY_SIZE(hdmi_debugfs_entries); i++) {
 			debugfs_create_file(hdmi_debugfs_entries[i].name,
@@ -3023,7 +3015,6 @@ void connector_debugfs_init(struct amdgpu_dm_connector *connector)
 					    hdmi_debugfs_entries[i].fops);
 		}
 	}
-#endif
 }
 
 #ifdef CONFIG_DRM_AMD_SECURE_DISPLAY
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index 19721941b069..1579c2839ce3 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -31,10 +31,7 @@
 #include "amdgpu.h"
 #include "amdgpu_dm.h"
 #include "amdgpu_dm_mst_types.h"
-
-#ifdef CONFIG_DRM_AMD_DC_HDCP
 #include "amdgpu_dm_hdcp.h"
-#endif
 
 #include "dc.h"
 #include "dm_helpers.h"
@@ -362,7 +359,6 @@ static int dm_dp_mst_get_modes(struct drm_connector *connector)
 		 * plugged back with same display index, its hdcp properties
 		 * will be retrieved from hdcp_work within dm_dp_mst_get_modes
 		 */
-#ifdef CONFIG_DRM_AMD_DC_HDCP
 		if (aconnector->dc_sink && connector->state) {
 			struct drm_device *dev = connector->dev;
 			struct amdgpu_device *adev = drm_to_adev(dev);
@@ -374,7 +370,6 @@ static int dm_dp_mst_get_modes(struct drm_connector *connector)
 			connector->state->content_protection =
 			hdcp_w->content_protection[connector->index];
 		}
-#endif
 
 		if (aconnector->dc_sink) {
 			amdgpu_dm_update_freesync_caps(
diff --git a/drivers/gpu/drm/amd/display/dc/Makefile b/drivers/gpu/drm/amd/display/dc/Makefile
index 94f156d57220..ba75e91ef62b 100644
--- a/drivers/gpu/drm/amd/display/dc/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/Makefile
@@ -56,9 +56,7 @@ ifdef CONFIG_DRM_AMD_DC_SI
 DC_LIBS += dce60
 endif
 
-ifdef CONFIG_DRM_AMD_DC_HDCP
 DC_LIBS += hdcp
-endif
 
 AMD_DC = $(addsuffix /Makefile, $(addprefix $(FULL_AMD_DISPLAY_PATH)/dc/,$(DC_LIBS)))
 
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index e3bfc4bb8341..5378b09471d3 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -1377,16 +1377,12 @@ void dc_hardware_init(struct dc *dc)
 void dc_init_callbacks(struct dc *dc,
 		const struct dc_callback_init *init_params)
 {
-#ifdef CONFIG_DRM_AMD_DC_HDCP
 	dc->ctx->cp_psp = init_params->cp_psp;
-#endif
 }
 
 void dc_deinit_callbacks(struct dc *dc)
 {
-#ifdef CONFIG_DRM_AMD_DC_HDCP
 	memset(&dc->ctx->cp_psp, 0, sizeof(dc->ctx->cp_psp));
-#endif
 }
 
 void dc_destroy(struct dc **dc)
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_exports.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_exports.c
index 862cb0f93b7d..565c62a272d6 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_exports.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_exports.c
@@ -93,7 +93,6 @@ const struct dc_link_status *dc_link_get_status(const struct dc_link *link)
 {
 	return link_get_status(link);
 }
-#ifdef CONFIG_DRM_AMD_DC_HDCP
 
 /* return true if the connected receiver supports the hdcp version */
 bool dc_link_is_hdcp14(struct dc_link *link, enum signal_type signal)
@@ -105,7 +104,6 @@ bool dc_link_is_hdcp22(struct dc_link *link, enum signal_type signal)
 {
 	return link_is_hdcp22(link, signal);
 }
-#endif
 
 void dc_link_clear_dprx_states(struct dc_link *link)
 {
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index f1ea9031a191..ae9d31cf9a23 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -29,9 +29,7 @@
 #include "dc_types.h"
 #include "grph_object_defs.h"
 #include "logger_types.h"
-#if defined(CONFIG_DRM_AMD_DC_HDCP)
-#include "hdcp_types.h"
-#endif
+#include "hdcp_msg_types.h"
 #include "gpio_types.h"
 #include "link_service_types.h"
 #include "grph_object_ctrl_defs.h"
@@ -993,11 +991,7 @@ struct dc_init_data {
 };
 
 struct dc_callback_init {
-#ifdef CONFIG_DRM_AMD_DC_HDCP
 	struct cp_psp cp_psp;
-#else
-	uint8_t reserved;
-#endif
 };
 
 struct dc *dc_create(const struct dc_init_data *init_params);
@@ -1475,9 +1469,7 @@ struct dc_link {
 	uint32_t dongle_max_pix_clk;
 	unsigned short chip_caps;
 	unsigned int dpcd_sink_count;
-#if defined(CONFIG_DRM_AMD_DC_HDCP)
 	struct hdcp_caps hdcp_caps;
-#endif
 	enum edp_revision edp_revision;
 	union dpcd_sink_ext_caps dpcd_sink_ext_caps;
 
@@ -1661,12 +1653,9 @@ bool dc_is_oem_i2c_device_present(
 	size_t slave_address
 );
 
-#ifdef CONFIG_DRM_AMD_DC_HDCP
-
 /* return true if the connected receiver supports the hdcp version */
 bool dc_link_is_hdcp14(struct dc_link *link, enum signal_type signal);
 bool dc_link_is_hdcp22(struct dc_link *link, enum signal_type signal);
-#endif
 
 /* Notify DC about DP RX Interrupt (aka DP IRQ_HPD).
  *
@@ -2154,7 +2143,6 @@ void dc_resume(struct dc *dc);
 
 void dc_power_down_on_boot(struct dc *dc);
 
-#if defined(CONFIG_DRM_AMD_DC_HDCP)
 /*
  * HDCP Interfaces
  */
@@ -2162,7 +2150,6 @@ enum hdcp_message_status dc_process_hdcp_msg(
 		enum signal_type signal,
 		struct dc_link *link,
 		struct hdcp_protection_message *message_info);
-#endif
 bool dc_is_dmcu_initialized(struct dc *dc);
 
 enum dc_status dc_set_clock(struct dc *dc, enum dc_clock_type clock_type, uint32_t clk_khz, uint32_t stepping);
diff --git a/drivers/gpu/drm/amd/display/dc/dc_types.h b/drivers/gpu/drm/amd/display/dc/dc_types.h
index f28b8597cc1e..4b47fa00610b 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_types.h
@@ -40,9 +40,7 @@
 #include "grph_object_defs.h"
 #include "grph_object_ctrl_defs.h"
 
-#ifdef CONFIG_DRM_AMD_DC_HDCP
 #include "dm_cp_psp.h"
-#endif
 
 /* forward declarations */
 struct dc_plane_state;
@@ -813,9 +811,7 @@ struct dc_context {
 	uint32_t dc_edp_id_count;
 	uint64_t fbc_gpu_addr;
 	struct dc_dmub_srv *dmub_srv;
-#ifdef CONFIG_DRM_AMD_DC_HDCP
 	struct cp_psp cp_psp;
-#endif
 	uint32_t *dcn_reg_offsets;
 	uint32_t *nbio_reg_offsets;
 };
@@ -955,7 +951,6 @@ struct dc_link_status {
 	struct dpcd_caps *dpcd_caps;
 };
 
-#if defined(CONFIG_DRM_AMD_DC_HDCP)
 union hdcp_rx_caps {
 	struct {
 		uint8_t version;
@@ -982,7 +977,6 @@ struct hdcp_caps {
 	union hdcp_rx_caps rx_caps;
 	union hdcp_bcaps bcaps;
 };
-#endif
 
 /* DP MST stream allocation (payload bandwidth number) */
 struct link_mst_stream_allocation {
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dio_stream_encoder.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dio_stream_encoder.c
index 36e6f5657942..ccf6b181c349 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dio_stream_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dio_stream_encoder.c
@@ -211,10 +211,8 @@ static void enc32_stream_encoder_hdmi_set_stream_attribute(
 		HDMI_GC_SEND, 1,
 		HDMI_NULL_SEND, 1);
 
-#if defined(CONFIG_DRM_AMD_DC_HDCP)
 	/* Disable Audio Content Protection packet transmission */
 	REG_UPDATE(HDMI_VBI_PACKET_CONTROL, HDMI_ACP_SEND, 0);
-#endif
 
 	/* following belongs to audio */
 	/* Enable Audio InfoFrame packet transmission. */
diff --git a/drivers/gpu/drm/amd/display/dc/hdcp/hdcp_msg.c b/drivers/gpu/drm/amd/display/dc/hdcp/hdcp_msg.c
index e1422e5e86c9..25ffc052d53b 100644
--- a/drivers/gpu/drm/amd/display/dc/hdcp/hdcp_msg.c
+++ b/drivers/gpu/drm/amd/display/dc/hdcp/hdcp_msg.c
@@ -27,7 +27,7 @@
 
 #include "dm_services.h"
 #include "dm_helpers.h"
-#include "include/hdcp_types.h"
+#include "include/hdcp_msg_types.h"
 #include "include/signal_types.h"
 #include "core_types.h"
 #include "link.h"
diff --git a/drivers/gpu/drm/amd/display/dc/inc/core_types.h b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
index ed3c03108da6..2eb597a24425 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/core_types.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
@@ -51,9 +51,7 @@ void enable_surface_flip_reporting(struct dc_plane_state *plane_state,
 #include "clock_source.h"
 #include "audio.h"
 #include "dm_pp_smu.h"
-#ifdef CONFIG_DRM_AMD_DC_HDCP
 #include "dm_cp_psp.h"
-#endif
 #include "link_hwss.h"
 
 /********** DAL Core*********************/
diff --git a/drivers/gpu/drm/amd/display/dc/inc/link.h b/drivers/gpu/drm/amd/display/dc/inc/link.h
index 6a346a41f07b..a3fcfa918a8f 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/link.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/link.h
@@ -139,11 +139,9 @@ bool link_detect(struct dc_link *link, enum dc_detect_reason reason);
 bool link_detect_connection_type(struct dc_link *link,
 		enum dc_connection_type *type);
 const struct dc_link_status *link_get_status(const struct dc_link *link);
-#ifdef CONFIG_DRM_AMD_DC_HDCP
 /* return true if the connected receiver supports the hdcp version */
 bool link_is_hdcp14(struct dc_link *link, enum signal_type signal);
 bool link_is_hdcp22(struct dc_link *link, enum signal_type signal);
-#endif
 void link_clear_dprx_states(struct dc_link *link);
 bool link_reset_cur_dp_mst_topology(struct dc_link *link);
 uint32_t dp_link_bandwidth_kbps(
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_detection.c b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
index 393bdefba0ba..99279e1e7330 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_detection.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
@@ -466,7 +466,6 @@ static void link_disconnect_remap(struct dc_sink *prev_sink, struct dc_link *lin
 	link->local_sink = prev_sink;
 }
 
-#if defined(CONFIG_DRM_AMD_DC_HDCP)
 static void query_hdcp_capability(enum signal_type signal, struct dc_link *link)
 {
 	struct hdcp_protection_message msg22;
@@ -508,7 +507,6 @@ static void query_hdcp_capability(enum signal_type signal, struct dc_link *link)
 	}
 
 }
-#endif // CONFIG_DRM_AMD_DC_HDCP
 static void read_current_link_settings_on_detect(struct dc_link *link)
 {
 	union lane_count_set lane_count_set = {0};
@@ -1084,9 +1082,7 @@ static bool detect_link_and_local_sink(struct dc_link *link,
 			 * TODO debug why certain monitors don't like
 			 *  two link trainings
 			 */
-#if defined(CONFIG_DRM_AMD_DC_HDCP)
 			query_hdcp_capability(sink->sink_signal, link);
-#endif
 		} else {
 			// If edid is the same, then discard new sink and revert back to original sink
 			if (same_edid) {
@@ -1094,9 +1090,7 @@ static bool detect_link_and_local_sink(struct dc_link *link,
 				sink = prev_sink;
 				prev_sink = NULL;
 			}
-#if defined(CONFIG_DRM_AMD_DC_HDCP)
 			query_hdcp_capability(sink->sink_signal, link);
-#endif
 		}
 
 		/* HDMI-DVI Dongle */
@@ -1162,9 +1156,7 @@ static bool detect_link_and_local_sink(struct dc_link *link,
 		/* From Connected-to-Disconnected. */
 		link->type = dc_connection_none;
 		sink_caps.signal = SIGNAL_TYPE_NONE;
-#if defined(CONFIG_DRM_AMD_DC_HDCP)
 		memset(&link->hdcp_caps, 0, sizeof(struct hdcp_caps));
-#endif
 		/* When we unplug a passive DP-HDMI dongle connection, dongle_max_pix_clk
 		 *  is not cleared. If we emulate a DP signal on this connection, it thinks
 		 *  the dongle is still there and limits the number of modes we can emulate.
@@ -1266,7 +1258,6 @@ void link_clear_dprx_states(struct dc_link *link)
 {
 	memset(&link->dprx_states, 0, sizeof(link->dprx_states));
 }
-#if defined(CONFIG_DRM_AMD_DC_HDCP)
 
 bool link_is_hdcp14(struct dc_link *link, enum signal_type signal)
 {
@@ -1314,7 +1305,6 @@ bool link_is_hdcp22(struct dc_link *link, enum signal_type signal)
 
 	return ret;
 }
-#endif // CONFIG_DRM_AMD_DC_HDCP
 
 const struct dc_link_status *link_get_status(const struct dc_link *link)
 {
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
index a1214e5606dd..0039928186ff 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
@@ -647,7 +647,6 @@ static void write_i2c_redriver_setting(
 	if (!i2c_success)
 		DC_LOG_DEBUG("Set redriver failed");
 }
-#if defined(CONFIG_DRM_AMD_DC_HDCP)
 
 static void update_psp_stream_config(struct pipe_ctx *pipe_ctx, bool dpms_off)
 {
@@ -713,7 +712,6 @@ static void update_psp_stream_config(struct pipe_ctx *pipe_ctx, bool dpms_off)
 
 	cp_psp->funcs.update_stream_config(cp_psp->handle, &config);
 }
-#endif
 
 static void set_avmute(struct pipe_ctx *pipe_ctx, bool enable)
 {
@@ -2269,9 +2267,7 @@ void link_set_dpms_off(struct pipe_ctx *pipe_ctx)
 
 	dc->hwss.disable_audio_stream(pipe_ctx);
 
-#if defined(CONFIG_DRM_AMD_DC_HDCP)
 	update_psp_stream_config(pipe_ctx, true);
-#endif
 	dc->hwss.blank_stream(pipe_ctx);
 
 	if (pipe_ctx->stream->signal == SIGNAL_TYPE_DISPLAY_PORT_MST)
@@ -2417,9 +2413,7 @@ void link_set_dpms_on(
 				dc->hwss.enable_audio_stream(pipe_ctx);
 			}
 
-#if defined(CONFIG_DRM_AMD_DC_HDCP)
 			update_psp_stream_config(pipe_ctx, false);
-#endif
 			return;
 		}
 
@@ -2429,9 +2423,7 @@ void link_set_dpms_on(
 					!pipe_ctx->stream->timing.flags.DSC &&
 					!pipe_ctx->next_odm_pipe) {
 			pipe_ctx->stream->dpms_off = false;
-#if defined(CONFIG_DRM_AMD_DC_HDCP)
 			update_psp_stream_config(pipe_ctx, false);
-#endif
 			return;
 		}
 
@@ -2515,9 +2507,7 @@ void link_set_dpms_on(
 
 		if (dc_is_dp_signal(pipe_ctx->stream->signal))
 			enable_stream_features(pipe_ctx);
-#if defined(CONFIG_DRM_AMD_DC_HDCP)
 		update_psp_stream_config(pipe_ctx, false);
-#endif
 
 		dc->hwss.enable_audio_stream(pipe_ctx);
 
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c
index 5e613ea2cd3f..cb0049cd1133 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c
@@ -1570,7 +1570,6 @@ bool perform_link_training_with_retries(
 			msleep(delay_dp_power_up_in_ms);
 		}
 
-#ifdef CONFIG_DRM_AMD_DC_HDCP
 		if (panel_mode == DP_PANEL_MODE_EDP) {
 			struct cp_psp *cp_psp = &stream->ctx->cp_psp;
 
@@ -1584,7 +1583,6 @@ bool perform_link_training_with_retries(
 				result = cp_psp->funcs.enable_assr(cp_psp->handle, link);
 			}
 		}
-#endif
 
 		dp_set_panel_mode(link, panel_mode);
 
diff --git a/drivers/gpu/drm/amd/display/include/hdcp_types.h b/drivers/gpu/drm/amd/display/include/hdcp_msg_types.h
similarity index 100%
rename from drivers/gpu/drm/amd/display/include/hdcp_types.h
rename to drivers/gpu/drm/amd/display/include/hdcp_msg_types.h
diff --git a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_log.h b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_log.h
index eb6f9b9c504a..c62df3bcc7cb 100644
--- a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_log.h
+++ b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_log.h
@@ -26,13 +26,11 @@
 #ifndef MOD_HDCP_LOG_H_
 #define MOD_HDCP_LOG_H_
 
-#ifdef CONFIG_DRM_AMD_DC_HDCP
 #define HDCP_LOG_ERR(hdcp, ...) DRM_DEBUG_KMS(__VA_ARGS__)
 #define HDCP_LOG_VER(hdcp, ...) DRM_DEBUG_KMS(__VA_ARGS__)
 #define HDCP_LOG_FSM(hdcp, ...) DRM_DEBUG_KMS(__VA_ARGS__)
 #define HDCP_LOG_TOP(hdcp, ...) pr_debug("[HDCP_TOP]:"__VA_ARGS__)
 #define HDCP_LOG_DDC(hdcp, ...) pr_debug("[HDCP_DDC]:"__VA_ARGS__)
-#endif
 
 /* default logs */
 #define HDCP_ERROR_TRACE(hdcp, status) \
-- 
2.34.1

