Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1297CCA47C
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Jul 2022 15:39:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3298295079;
	Tue, 12 Jul 2022 15:39:23 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2068.outbound.protection.outlook.com [40.107.223.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4637D94644
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Jul 2022 15:39:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ga4fzr5Yhp0emr0WJoJcNKZl6CdCHbnasyP0cGcPTVKRUVvyaIeBHQT1MoVHkq40mVZNcte/aIxasRuvDx3izSLXmmgBAnRqEsb9+Cr/K5BlQewfZhOcMbYpIVVpVGJa7pTjHOs3Xz03z1XGi3R4v9f6/Q5tXdJctPdkQE5/vVpFgyfxzjnaqafShPcneVO31VxgSSYxWGcO9XM5x9HjlBiUWcT03M1TseTCZdVVdFnRwjwnY6ohpubuk0HnTtRK5XtMw5tc+F49VDH9PbjrkoKl30mAbCYz2dZQd1SwSN9EqtCCLUGy+d8+EZtlbv3m88cExV9Itw2BDaozgxHuQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OwV4HwxL83BqyuwM4PHFA9U/aUcslmOLKLr6VK2Hu1Q=;
 b=H9AkSSGYMz24GZvahXAppBJbX+K8ORtNLPYFy13JZjidTO2FvYDSTkjIR8NXx1OKP92RimwuwiyRwAGAClNJnx0F0wOFE/c+aXbDLAEBdpAemRxqGwEYZVvoeP0kNr+iQ82k2RQeegoJYg/TtCLyjAZR+S8j0iDiLQh8e21YdGTfGY5JTJ2dzHqTmkb5pnn8VnQ8gcjZiAE98tq6tqHGBWuMYhyHTfsXYd1xC39AU8MwcPeNPbJDNZC+6GpYs0bKuPOLOa+0XZrV9NxxpX2PtJMRdLtVTxlIzwSDgHRx6LtBu8xS3DP+1Y6t4vp7tFx17VQe+Mv6JMbeiDE+6dKFEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OwV4HwxL83BqyuwM4PHFA9U/aUcslmOLKLr6VK2Hu1Q=;
 b=ZGKSCXFVwRwdoqh5eUjhnYfAWo0nxOOkOoUhx3b2+nlKgAqdNTUWdPzNjA+3WMaoxNAwJUFn1bIBXTb82pF8gP3Rs4g4tvztTOhX6OaBlpB8+rY/xjGSdOtk2AbPFXvDbke4nv10BQy360K4YGKwBjrwbd0uIEqHmq1U4aB8SBc=
Received: from BN0PR04CA0070.namprd04.prod.outlook.com (2603:10b6:408:ea::15)
 by DM5PR12MB1754.namprd12.prod.outlook.com (2603:10b6:3:10f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.25; Tue, 12 Jul
 2022 15:39:18 +0000
Received: from BN8NAM11FT063.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ea:cafe::95) by BN0PR04CA0070.outlook.office365.com
 (2603:10b6:408:ea::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.20 via Frontend
 Transport; Tue, 12 Jul 2022 15:39:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT063.mail.protection.outlook.com (10.13.177.110) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5417.15 via Frontend Transport; Tue, 12 Jul 2022 15:39:17 +0000
Received: from ryzen32.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 12 Jul
 2022 10:39:12 -0500
From: Solomon Chiu <solomon.chiu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 14/21] drm/amd/display: Grab dc_lock before detecting link
Date: Tue, 12 Jul 2022 23:38:55 +0800
Message-ID: <20220712153855.501271-1-solomon.chiu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220708163529.3534276-1-solomon.chiu@amd.com>
References: <20220708163529.3534276-1-solomon.chiu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6bd08142-3d69-40ac-c85a-08da641caeae
X-MS-TrafficTypeDiagnostic: DM5PR12MB1754:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6zCkFf5tOa0XHVwb2oiPfPi3mCGrKA3eiiXxen/BeYl55GT0V2Igoq6bqL50Gi3r2w4xXd9NSm5PEN8ppB+WK+i15vFdQ7fe7MBfgs/W4DtKvXVqqpIb1//7LJ5a05YTGYSxXt35sN1izlVocRoYQP1qJyq58KIa4LCpkK7MqGBi4vUWsS8g2PyJdahApTfdovi2tS3xclj6Qfm61nYefnSWgZpeVXxjuI9429rJqMyz46JZ7xTDDvnDf0e+JWXVDBt5uLXjPayu6rWgsF/Oa/DaHq2qhTSoKIPf/zxiuX/py3iyzaxbDw/ao966pw2kK6XTb8KBOgJ31hxKAHDZ/wTxQ1N2aHGJfWWOwepbwRoyr6b3zLbok46uGF5/1QoBiwCQtDUp6ZN/hfDOhve6NzSqERZYnRj3nPLbJUef3bavJtLVSF84dho3HJ5i6zlVPOWjiBQyb7mu+KbLNoci1SY2O0VuWZbXJ1X42Rxu1HzsDpVUEf4QNiBY/ysON9lfp6BIlCH8vRBjhZKWoiAplhVXtsLEfggkmZzpvUwuPt7N0HhPK85eG0duWihEvWuVKvOMyML1TztZ6TX49QrcpY3lS/cGmfmZ303TZ/PkEaJLqlLGqJptASK5ApHhnHOHyKC5LtHnlniJK555kHQRJzIr9+ZeJq3xewIC3JI8ZtvRycMO7lTMQfPOJk/1DKv0BvtTsKEY2YKtg+ftVWz3MiurYEJH3fabAFgafe8WdlfcMnbx5s/l2s5+UyvAmsWXjUPAlQeoirFPaoxF8uHiqi/tq772UJUiJu5utqHHppOfPg6Ih8q6TDq7wBXApY4iSJ85OtYgf5qt3Jl2jFYE9q58/uFXIFK6g7oqtoDaoPo=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(376002)(136003)(346002)(396003)(36840700001)(46966006)(40470700004)(186003)(2616005)(8676002)(8936002)(86362001)(82310400005)(6666004)(44832011)(16526019)(1076003)(356005)(426003)(82740400003)(4326008)(7696005)(70206006)(336012)(70586007)(26005)(47076005)(6916009)(478600001)(54906003)(2906002)(36860700001)(5660300002)(40460700003)(36756003)(83380400001)(40480700001)(41300700001)(316002)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2022 15:39:17.8117 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bd08142-3d69-40ac-c85a-08da641caeae
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT063.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1754
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
Cc: stylon.wang@amd.com, Hersen Wu <hersen.wu@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com,
 Daniel Wheeler <daniel.wheeler@amd.com>, Aurabindo.Pillai@amd.com,
 Wayne Lin <Wayne.Lin@amd.com>, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wayne Lin <Wayne.Lin@amd.com>

[Why & How]
There is chance we change dc state while calling dc_link_detect().
As the result of that, grab the dm.dc_lock before detecting link.

Reviewed-by: Hersen Wu <hersen.wu@amd.com>
Acked-by: Solomon Chiu <solomon.chiu@amd.com>
Signed-off-by: Wayne Lin <Wayne.Lin@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 85 ++++++++++++-------
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 11 ++-
 2 files changed, 63 insertions(+), 33 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index de1c139ae279..000d34a7b6b4 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -2716,10 +2716,13 @@ static int dm_resume(void *handle)
 		if (!dc_link_detect_sink(aconnector->dc_link, &new_connection_type))
 			DRM_ERROR("KMS: Failed to detect connector\n");
 
-		if (aconnector->base.force && new_connection_type == dc_connection_none)
+		if (aconnector->base.force && new_connection_type == dc_connection_none) {
 			emulated_link_detect(aconnector->dc_link);
-		else
+		} else {
+			mutex_lock(&dm->dc_lock);
 			dc_link_detect(aconnector->dc_link, DETECT_REASON_HPD);
+			mutex_unlock(&dm->dc_lock);
+		}
 
 		if (aconnector->fake_enable && aconnector->dc_link->local_sink)
 			aconnector->fake_enable = false;
@@ -3050,6 +3053,7 @@ static void handle_hpd_irq_helper(struct amdgpu_dm_connector *aconnector)
 #ifdef CONFIG_DRM_AMD_DC_HDCP
 	struct dm_connector_state *dm_con_state = to_dm_connector_state(connector->state);
 #endif
+	bool ret = false;
 
 	if (adev->dm.disable_hpd_irq)
 		return;
@@ -3081,16 +3085,20 @@ static void handle_hpd_irq_helper(struct amdgpu_dm_connector *aconnector)
 
 		if (aconnector->base.force == DRM_FORCE_UNSPECIFIED)
 			drm_kms_helper_connector_hotplug_event(connector);
+	} else {
+		mutex_lock(&adev->dm.dc_lock);
+		ret = dc_link_detect(aconnector->dc_link, DETECT_REASON_HPD);
+		mutex_unlock(&adev->dm.dc_lock);
+		if (ret) {
+			amdgpu_dm_update_connector_after_detect(aconnector);
 
-	} else if (dc_link_detect(aconnector->dc_link, DETECT_REASON_HPD)) {
-		amdgpu_dm_update_connector_after_detect(aconnector);
-
-		drm_modeset_lock_all(dev);
-		dm_restore_drm_connector_state(dev, connector);
-		drm_modeset_unlock_all(dev);
+			drm_modeset_lock_all(dev);
+			dm_restore_drm_connector_state(dev, connector);
+			drm_modeset_unlock_all(dev);
 
-		if (aconnector->base.force == DRM_FORCE_UNSPECIFIED)
-			drm_kms_helper_connector_hotplug_event(connector);
+			if (aconnector->base.force == DRM_FORCE_UNSPECIFIED)
+				drm_kms_helper_connector_hotplug_event(connector);
+		}
 	}
 	mutex_unlock(&aconnector->hpd_lock);
 
@@ -3285,19 +3293,25 @@ static void handle_hpd_rx_irq(void *param)
 			drm_modeset_unlock_all(dev);
 
 			drm_kms_helper_connector_hotplug_event(connector);
-		} else if (dc_link_detect(dc_link, DETECT_REASON_HPDRX)) {
+		} else {
+			bool ret = false;
 
-			if (aconnector->fake_enable)
-				aconnector->fake_enable = false;
+			mutex_lock(&adev->dm.dc_lock);
+			ret = dc_link_detect(dc_link, DETECT_REASON_HPDRX);
+			mutex_unlock(&adev->dm.dc_lock);
 
-			amdgpu_dm_update_connector_after_detect(aconnector);
+			if (ret) {
+				if (aconnector->fake_enable)
+					aconnector->fake_enable = false;
 
+				amdgpu_dm_update_connector_after_detect(aconnector);
 
-			drm_modeset_lock_all(dev);
-			dm_restore_drm_connector_state(dev, connector);
-			drm_modeset_unlock_all(dev);
+				drm_modeset_lock_all(dev);
+				dm_restore_drm_connector_state(dev, connector);
+				drm_modeset_unlock_all(dev);
 
-			drm_kms_helper_connector_hotplug_event(connector);
+				drm_kms_helper_connector_hotplug_event(connector);
+			}
 		}
 	}
 #ifdef CONFIG_DRM_AMD_DC_HDCP
@@ -4302,23 +4316,30 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
 		if (aconnector->base.force && new_connection_type == dc_connection_none) {
 			emulated_link_detect(link);
 			amdgpu_dm_update_connector_after_detect(aconnector);
+		} else {
+			bool ret = false;
 
-		} else if (dc_link_detect(link, DETECT_REASON_BOOT)) {
-			amdgpu_dm_update_connector_after_detect(aconnector);
-			register_backlight_device(dm, link);
-			if (dm->num_of_edps)
-				update_connector_ext_caps(aconnector);
-			if (psr_feature_enabled)
-				amdgpu_dm_set_psr_caps(link);
-
-			/* TODO: Fix vblank control helpers to delay PSR entry to allow this when
-			 * PSR is also supported.
-			 */
-			if (link->psr_settings.psr_feature_enabled)
-				adev_to_drm(adev)->vblank_disable_immediate = false;
-		}
+			mutex_lock(&dm->dc_lock);
+			ret = dc_link_detect(link, DETECT_REASON_BOOT);
+			mutex_unlock(&dm->dc_lock);
 
+			if (ret) {
+				amdgpu_dm_update_connector_after_detect(aconnector);
+				register_backlight_device(dm, link);
 
+				if (dm->num_of_edps)
+					update_connector_ext_caps(aconnector);
+
+				if (psr_feature_enabled)
+					amdgpu_dm_set_psr_caps(link);
+
+				/* TODO: Fix vblank control helpers to delay PSR entry to allow this when
+				 * PSR is also supported.
+				 */
+				if (link->psr_settings.psr_feature_enabled)
+					adev_to_drm(adev)->vblank_disable_immediate = false;
+			}
+		}
 	}
 
 	/* Software is initialized. Now we can register interrupt handlers. */
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
index 01c98ad06cf0..e0646db6fdbf 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
@@ -1243,12 +1243,14 @@ static ssize_t trigger_hotplug(struct file *f, const char __user *buf,
 	struct drm_connector *connector = &aconnector->base;
 	struct dc_link *link = NULL;
 	struct drm_device *dev = connector->dev;
+	struct amdgpu_device *adev = drm_to_adev(dev);
 	enum dc_connection_type new_connection_type = dc_connection_none;
 	char *wr_buf = NULL;
 	uint32_t wr_buf_size = 42;
 	int max_param_num = 1;
 	long param[1] = {0};
 	uint8_t param_nums = 0;
+	bool ret = false;
 
 	if (!aconnector || !aconnector->dc_link)
 		return -EINVAL;
@@ -1284,7 +1286,11 @@ static ssize_t trigger_hotplug(struct file *f, const char __user *buf,
 			new_connection_type != dc_connection_none)
 			goto unlock;
 
-		if (!dc_link_detect(aconnector->dc_link, DETECT_REASON_HPD))
+		mutex_lock(&adev->dm.dc_lock);
+		ret = dc_link_detect(aconnector->dc_link, DETECT_REASON_HPD);
+		mutex_unlock(&adev->dm.dc_lock);
+
+		if (!ret)
 			goto unlock;
 
 		amdgpu_dm_update_connector_after_detect(aconnector);
@@ -3306,7 +3312,10 @@ static int trigger_hpd_mst_set(void *data, u64 val)
 			aconnector = to_amdgpu_dm_connector(connector);
 			if (aconnector->dc_link->type == dc_connection_mst_branch &&
 			    aconnector->mst_mgr.aux) {
+				mutex_lock(&adev->dm.dc_lock);
 				dc_link_detect(aconnector->dc_link, DETECT_REASON_HPD);
+				mutex_unlock(&adev->dm.dc_lock);
+
 				drm_dp_mst_topology_mgr_set_mst(&aconnector->mst_mgr, true);
 			}
 		}
-- 
2.25.1

