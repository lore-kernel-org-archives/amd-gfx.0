Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57B96C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Apr 2022 20:15:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C0A710E160;
	Wed, 13 Apr 2022 20:15:44 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2046.outbound.protection.outlook.com [40.107.95.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 66FEE10E160
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Apr 2022 20:15:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IQdRUIzkAyxmW16xUUdFyshYML5GqcdZMG7Jkjc/nffH3eW2t+C6WcquBBtK3NHs9huW4Zu9v3JAcTNVe/JdRmUx00SCX85x06Td/Qwm1uQccQPL3KhJgmQwV+psPfyqR3UNY+qKcFI00vyBOLC1FM/u089Im8JH83mtbXwNzZiCTKRTRFnznkJ47VT3oYZ6uLFETRvXmy9pDydACnJl1t7d6hxTixuaF8H0eWuVsfb3z8TvznuM7a4QlbDkbDyxQzBPecf1w5hfRP/UgsxJafJwWlYm6OBMyybK1w+IWoB8d6o2Z5FSOpVz9KR3RdZKFCOA7kDKOtWqGQPHXhtcgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RZsrrWyfSiKS0WygJxiMzLdrsWzw9QL1qIQRwzpmVTs=;
 b=VLp31bWTYhFqbgGwCKdLnBjAAIQCbaSetuXsKMMZSndgiskdvq091Qy8iTwxANsSJFcKSg2SK1Ncb678Al222nBTw945YEKuTWjAWud64QPp8x6ocW0QTrfOamgIaiZpypGjJFCc5YQ5Skxkp+5Va11clN8iWPrCF6SckU7+cY6/QbAsMA8VflDFsUIAQwF3vSlkq3qiyCb3Ibss1MDOqzB6QS3FfQkoYymRLjt9AmaphoYmefctzUm9i8963cn6ZAh5DhuMkb9nNP/50t6fT7bNI9is2MM+nFscDnx+ows6cqyaBKO8d+uKFxMMgOosuZoq4pHB2nxTT56PB32VbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RZsrrWyfSiKS0WygJxiMzLdrsWzw9QL1qIQRwzpmVTs=;
 b=pSNus+lW+9hsiskO0kVRSxtvr2qqZNRoG3z+zmzRR8hCssaZ527fcEtp0BuggD6gjAPJkj+20ugBbgZKaeI4DPjYp/e4exDl+3ypd06pWEfU5dkSZVl+XX3jZnMDDp8sKDP7mUbLT4zE93eDVxA1AFwidYE6brXBOAva7mWSLsU=
Received: from MW4PR04CA0258.namprd04.prod.outlook.com (2603:10b6:303:88::23)
 by BN7PR12MB2755.namprd12.prod.outlook.com (2603:10b6:408:32::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.18; Wed, 13 Apr
 2022 20:15:39 +0000
Received: from CO1NAM11FT032.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:88:cafe::5f) by MW4PR04CA0258.outlook.office365.com
 (2603:10b6:303:88::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20 via Frontend
 Transport; Wed, 13 Apr 2022 20:15:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT032.mail.protection.outlook.com (10.13.174.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5164.19 via Frontend Transport; Wed, 13 Apr 2022 20:15:38 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 13 Apr
 2022 15:15:36 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: don't runtime suspend if there are displays
 attached (v2)
Date: Wed, 13 Apr 2022 16:15:22 -0400
Message-ID: <20220413201522.2084041-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fa6923a7-44a1-48f9-cedc-08da1d8a6093
X-MS-TrafficTypeDiagnostic: BN7PR12MB2755:EE_
X-Microsoft-Antispam-PRVS: <BN7PR12MB27555E768251BB6E452EA5C2F7EC9@BN7PR12MB2755.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EhNB3VR0bv777vHKr8PjhsQrhu9EZ2SDrO+V/JqnENaANfJ2EF8QySpW07SGFErq9ufntNo7CAaje0N+nVOwDJuZ+WwqaP1PfZvvaFTei4uQECmVVynt3D5EsIK6Num9iuR0k693NUMxZWgH2F3CZZdOWD3CvNwOZMy7AIATtlO0obcmcjMowH0kYRGebu5qJpXaZoMn5RXApvIoyKv0k8629OpqaCVdI8bFglaJJ5VHlAS43B/BC5zg6k7DRupGq9OJITa9ge7N7Pyp0I4Vtm7k3F/KqmYqutIIpU7zjJYnKi7ZvZVn+6h8yldK8efL/7WgZZbO26KgkTQW3IBR/8cf83g2Iv0Yo1BObS3KACoFIpSZ3twxYMm64OdMGcMjYo79g5YhW/rG56dHmaaw0bXdLGxwFfcfRFLZxDYIxFRgjah/8f23glEvj6+MO8pmValRfnrVx/S6s9i1eH9MGYqQUnRvFAGPjRLd8lsUZjMX93BMFvbWEFuVmILSkgRR7mDFD2QU5UqqyeebdF28ObNbGPag+Ee84b9H01xF6zJDh5wgxjgG+QDqqawQFjb0OKnFsDDS7shONcjBS1YiY2ON/54E8bDAHTa1SKcz8T6pu9jEquMxW3JahUfSdGPeQoEVCfWbGoAje4ir/dTPLgx6xzRIE22N8rOiIyvh2YuNeaqVg1FvD6xyNIfin+oUFJtNtBle3bK82l6qneOpMMtJeF/NSnYXJ8DiuirpEI4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(2906002)(83380400001)(36860700001)(4326008)(8936002)(54906003)(8676002)(70586007)(86362001)(508600001)(70206006)(15650500001)(316002)(6916009)(7696005)(6666004)(5660300002)(356005)(40460700003)(26005)(186003)(16526019)(1076003)(47076005)(426003)(81166007)(36756003)(2616005)(82310400005)(336012)(21314003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2022 20:15:38.7307 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa6923a7-44a1-48f9-cedc-08da1d8a6093
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT032.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2755
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Michele Ballabio <ballabio.m@gmail.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

We normally runtime suspend when there are displays attached if they
are in the DPMS off state, however, if something wakes the GPU
we send a hotplug event on resume (in case any displays were connected
while the GPU was in suspend) which can cause userspace to light
up the displays again soon after they were turned off.

Prior to
commit 087451f372bf76 ("drm/amdgpu: use generic fb helpers instead of setting up AMD own's."),
the driver took a runtime pm reference when the fbdev emulation was
enabled because we didn't implement proper shadowing support for
vram access when the device was off so the device never runtime
suspended when there was a console bound.  Once that commit landed,
we now utilize the core fb helper implementation which properly
handles the emulation, so runtime pm now suspends in cases where it did
not before.  Ultimately, we need to sort out why runtime suspend in not
working in this case for some users, but this should restore similar
behavior to before.

v2: move check into runtime_suspend

Fixes: 087451f372bf76 ("drm/amdgpu: use generic fb helpers instead of setting up AMD own's.")
Tested-by: Michele Ballabio <ballabio.m@gmail.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 107 ++++++++++++++++--------
 1 file changed, 72 insertions(+), 35 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 4efaa183abcd..97a1aa02d76e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2395,6 +2395,71 @@ static int amdgpu_pmops_restore(struct device *dev)
 	return amdgpu_device_resume(drm_dev, true);
 }
 
+static int amdgpu_runtime_idle_check_display(struct device *dev)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	struct drm_device *drm_dev = pci_get_drvdata(pdev);
+	struct amdgpu_device *adev = drm_to_adev(drm_dev);
+
+	if (adev->mode_info.num_crtc) {
+		struct drm_connector *list_connector;
+		struct drm_connector_list_iter iter;
+		int ret = 0;
+
+		/* XXX: Return busy if any displays are connected to avoid
+		 * possible display wake ups after runtime resume due to
+		 * hotplug events in case any displays were connected while
+		 * the GPU was in suspend.  Remove this once that is fixed.
+		 */
+		mutex_lock(&drm_dev->mode_config.mutex);
+		drm_connector_list_iter_begin(drm_dev, &iter);
+		drm_for_each_connector_iter(list_connector, &iter) {
+			if (list_connector->status == connector_status_connected) {
+				ret = -EBUSY;
+				break;
+			}
+		}
+		drm_connector_list_iter_end(&iter);
+		mutex_unlock(&drm_dev->mode_config.mutex);
+
+		if (ret)
+			return ret;
+
+		if (amdgpu_device_has_dc_support(adev)) {
+			struct drm_crtc *crtc;
+
+			drm_for_each_crtc(crtc, drm_dev) {
+				drm_modeset_lock(&crtc->mutex, NULL);
+				if (crtc->state->active)
+					ret = -EBUSY;
+				drm_modeset_unlock(&crtc->mutex);
+				if (ret < 0)
+					break;
+			}
+		} else {
+			mutex_lock(&drm_dev->mode_config.mutex);
+			drm_modeset_lock(&drm_dev->mode_config.connection_mutex, NULL);
+
+			drm_connector_list_iter_begin(drm_dev, &iter);
+			drm_for_each_connector_iter(list_connector, &iter) {
+				if (list_connector->dpms ==  DRM_MODE_DPMS_ON) {
+					ret = -EBUSY;
+					break;
+				}
+			}
+
+			drm_connector_list_iter_end(&iter);
+
+			drm_modeset_unlock(&drm_dev->mode_config.connection_mutex);
+			mutex_unlock(&drm_dev->mode_config.mutex);
+		}
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
 static int amdgpu_pmops_runtime_suspend(struct device *dev)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
@@ -2407,6 +2472,10 @@ static int amdgpu_pmops_runtime_suspend(struct device *dev)
 		return -EBUSY;
 	}
 
+	ret = amdgpu_runtime_idle_check_display(dev);
+	if (ret)
+		return ret;
+
 	/* wait for all rings to drain before suspending */
 	for (i = 0; i < AMDGPU_MAX_RINGS; i++) {
 		struct amdgpu_ring *ring = adev->rings[i];
@@ -2516,41 +2585,9 @@ static int amdgpu_pmops_runtime_idle(struct device *dev)
 		return -EBUSY;
 	}
 
-	if (amdgpu_device_has_dc_support(adev)) {
-		struct drm_crtc *crtc;
-
-		drm_for_each_crtc(crtc, drm_dev) {
-			drm_modeset_lock(&crtc->mutex, NULL);
-			if (crtc->state->active)
-				ret = -EBUSY;
-			drm_modeset_unlock(&crtc->mutex);
-			if (ret < 0)
-				break;
-		}
-
-	} else {
-		struct drm_connector *list_connector;
-		struct drm_connector_list_iter iter;
-
-		mutex_lock(&drm_dev->mode_config.mutex);
-		drm_modeset_lock(&drm_dev->mode_config.connection_mutex, NULL);
-
-		drm_connector_list_iter_begin(drm_dev, &iter);
-		drm_for_each_connector_iter(list_connector, &iter) {
-			if (list_connector->dpms ==  DRM_MODE_DPMS_ON) {
-				ret = -EBUSY;
-				break;
-			}
-		}
-
-		drm_connector_list_iter_end(&iter);
-
-		drm_modeset_unlock(&drm_dev->mode_config.connection_mutex);
-		mutex_unlock(&drm_dev->mode_config.mutex);
-	}
-
-	if (ret == -EBUSY)
-		DRM_DEBUG_DRIVER("failing to power off - crtc active\n");
+	ret = amdgpu_runtime_idle_check_display(dev);
+	if (ret)
+		return ret;
 
 	pm_runtime_mark_last_busy(dev);
 	pm_runtime_autosuspend(dev);
-- 
2.35.1

