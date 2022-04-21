Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B06ADC433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Apr 2022 03:16:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6BC8310E271;
	Thu, 21 Apr 2022 03:16:31 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2087.outbound.protection.outlook.com [40.107.94.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D77810E271
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Apr 2022 03:16:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lOR91AidGKDQLUDFeZ6xU1/pm70bw91gta29P2Euml5kbxmc1u8UN1qPzB8jTxbzv0qdpryG4ywm85L1W6XtF7drTyu9Gihu7h0CbXIgpukIhdS4JmkuX1iuvTtMB1bRGb+wsOR02wT3JH+/HyyOQvCSNpMZbN6aHhAd/MjoZYPmboTGM7FyL0Fm/9+OpirZiWPyiolF7pksLTnNh5dZneEl+gYtAShOSohoe8hyvrKIdXFwUnOYVfFnmJ2WRHc1Fo3Bjvc1gV9UdIXr6CSD763JFklOfZzTjdf69wqAgwIO8iyr7RQZ4awOOD8juTsUpGoB3ELfpwZDM6Ci5vD0WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MRcsr6ug5J/CtutRVDDujgGGh3j5p88BIQrX9orhybk=;
 b=OWikP2kQT98gqDOnCZ9OEjZEK7oWLVZvZXgP9KeWHMrNqVL7Gffd6ckKxuevcSHAcdhsnlOJ+GoNRidwfVjpaPvsRTlzPo3vsS/bVu3INM50xfJMCyjoFFj8Y4VgPkeF/etEIO57RTQ8vU8p2CYHcXu25Wl551jHKrw1iviPxc0aVHTCSda3wI8GV/F0tK6H42SR9d52hMClv2+WiVHMUaaUV0e4l62UA4G867r/6VsvHCJdDf3Zk3keE7MbNgn4BUaJM9yMVyOmmTX07OOcNCLlCyDP+qQPYatJZb/Cf7IHAj6l5AUHtPju2YFWApAYrGsT2eZuWRFKRjXRKmUOzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MRcsr6ug5J/CtutRVDDujgGGh3j5p88BIQrX9orhybk=;
 b=MLvrCCOPx9roOTB/EEKpUW2GU/3lsdSGT/QP0aY3dLPwDRet5wq8gKuWgMnqKPc8Q8/0KAQxvTT52t003cPaQzlYr4sNDNSJXoKbbt8z9kkFPkjxvIhEDHl45u+bH2mjcli5qwJ12i6/dEF0denLtfLUKvovWf6eBg3ixTZZl3w=
Received: from DM6PR07CA0088.namprd07.prod.outlook.com (2603:10b6:5:337::21)
 by DM4PR12MB6376.namprd12.prod.outlook.com (2603:10b6:8:a0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Thu, 21 Apr
 2022 03:16:27 +0000
Received: from DM6NAM11FT004.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:337:cafe::91) by DM6PR07CA0088.outlook.office365.com
 (2603:10b6:5:337::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13 via Frontend
 Transport; Thu, 21 Apr 2022 03:16:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT004.mail.protection.outlook.com (10.13.172.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5186.14 via Frontend Transport; Thu, 21 Apr 2022 03:16:26 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 20 Apr
 2022 22:16:25 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: don't runtime suspend if there are displays
 attached (v2)
Date: Wed, 20 Apr 2022 23:16:07 -0400
Message-ID: <20220421031607.1745623-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7f3d43b0-ce8f-4c1a-b3fc-08da23455214
X-MS-TrafficTypeDiagnostic: DM4PR12MB6376:EE_
X-Microsoft-Antispam-PRVS: <DM4PR12MB6376E185070BC9EAAF07E868F7F49@DM4PR12MB6376.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nB7vmhF2Ogr/nugpWaMK/GWGtMn6EgIVcqJM/82aYYH30tlylbyzQsGCS9XOGGumibjn9DJhqIuR6LJDVGXWmJ6M+6BsyF22/5K3kvYehYyoOJgmgbAwLRlRoLdxU9c9fCTMDovxPkh5AQmDH/RTQeDh1LLreVxKNI6WFvvhkqa2xqxCPqsEIU6Q+7gAgmsIdENqENt/3EAuIyigOJIPArlqtIUV4uxy7NoRigcBT/57GHjGKsvZbCusiZ5W300rzFtvQNhHobow06iIUBMShK88B/08RrXT6zFaeSGsvDAqy8QK0WpNYnpmPj82DjAdpX0rvxiMPKwV3TfD0OUf+6RSVwVKknbYuC6jkHv8a0hhDBpDEQPl/WBwi9rJw1FhpbtIYVFCvd5qpFzSJ7yU7dwceB4U+LqH1U0czalOkB/H2jzTITfUV/FuvetMdKmtIcqzab9SFzRCXBhl02v2OvR48yZHmAgxRFIA1ZX2O//Zd9We3Qc4XngQaWRNcZMczDA2VcGuieh/rRNY43N+GQmk0RQXPMSK3t9rewR2zbUjiOrYj6dj33iXSXnRyVTYh0gIy9aGl9XxnY1yJu/XM7iBVRFNhLhjyrMTBAty7qm1/TlZr6t0Gn/Clutpbfgh+ZB4QF3G4YI7kbT0u3uplM6CqZIiJk/iKUai50MTbS8MGixdyzF/tWPQGyuT/xETmECxNlVgutHZBlYgxBhaHdKVPTD5w0MFKidIBQZ/Ep0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(40460700003)(1076003)(70206006)(2616005)(54906003)(36756003)(82310400005)(8676002)(4326008)(316002)(186003)(426003)(336012)(16526019)(47076005)(70586007)(6916009)(86362001)(7696005)(15650500001)(26005)(81166007)(8936002)(83380400001)(5660300002)(508600001)(36860700001)(356005)(6666004)(2906002)(21314003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2022 03:16:26.1744 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f3d43b0-ce8f-4c1a-b3fc-08da23455214
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT004.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6376
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
v3: wake ups -> wakeups in comment, retain pm_runtime behavior in
    runtime_idle callback

Fixes: 087451f372bf76 ("drm/amdgpu: use generic fb helpers instead of setting up AMD own's.")
Tested-by: Michele Ballabio <ballabio.m@gmail.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 105 ++++++++++++++++--------
 1 file changed, 70 insertions(+), 35 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 4efaa183abcd..ebd37fb19cdb 100644
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
+		 * possible display wakeups after runtime resume due to
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
@@ -2516,41 +2585,7 @@ static int amdgpu_pmops_runtime_idle(struct device *dev)
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
 
 	pm_runtime_mark_last_busy(dev);
 	pm_runtime_autosuspend(dev);
-- 
2.35.1

