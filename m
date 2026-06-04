Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8A76CD6E77
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Jun 2026 14:55:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E3089112849;
	Thu,  4 Jun 2026 14:55:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="M7V3/MVb";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010041.outbound.protection.outlook.com
 [40.93.198.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C98CB112849
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Jun 2026 14:55:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xgBycfPqUYAby9qlJ2VO01aLbXKrjJZ+cZpRjbA31UzZ+jvxl6i7njJesX6xUID0CIeYfWPNNWajKbroHGHkNfbTUlO6ufkth6QzjbNYjHgBP83rnOl8aKy45xENoPAHUEKCR8NGzK7Pz7JDk0LFbho8CvlIQbbBJ1UdeySue6965soZl1SuYBGzCY0t4abqKi8juFXpDo4BZO2zKZw7CFIt4DFPDOoaqPUcS0ibiEQ7WYkVQEeewOusGOrWSiF7j7LG4zR+zVkdqpAtXyMPk/XvHCFMRkQcpEw7rh489qKnbO0fut0JalVpLVCF4+Ca4LwKtrgYRHaN4or483FU2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VGsIMXV2+ADSzM0giwFJ6rlI/3Tz1HQTziQHpOQQNv8=;
 b=hBNl1rzlDGkI0wpcDxxbG+oomH0/cztt9E+/qG+S2LG0M4UZH1HGqiO2EcVC5wdy0fKmxGsrB81k+41lj5BquBHJdtvZ2Mtc5QC6IwqTpYHivLs86V40sGt//uGmTuKEBBdx51vAXgK8DrWDBT6j48r0ovc3Z3r+TUJKMXUbV6d/ErVeXRK0lEqGGh2oiEPu8/AyApFTNK+baG6dwE0loT50/nD53Nn7sOcRWD2O7iz39IfwUSKesSNxUFj8zrzvWbbijW/uCVtWwxcOqge1zryLsIMBYrqaK6Ei/4jdRpQOuicYHvcM6jDMDBrDUWIWyJUbg+yCFU4XEaAkKzeQSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VGsIMXV2+ADSzM0giwFJ6rlI/3Tz1HQTziQHpOQQNv8=;
 b=M7V3/MVb5iDh9fKNUAcunObJZO0CnzywUujYWvUPkaSPxHydBt+tY8AgNjLFj9HAxfcH9XhyLK1GSceiVKcfZQI8BzSQ/B18lAXG14Xss1bwp5rU+woi1goHzdAx0eKO7rsaGYXFdyf+iie/Bir1DCAYaFIL27z9+61PvpS4djU=
Received: from BY3PR04CA0026.namprd04.prod.outlook.com (2603:10b6:a03:217::31)
 by SA1PR12MB8723.namprd12.prod.outlook.com (2603:10b6:806:385::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Thu, 4 Jun 2026
 14:55:16 +0000
Received: from SJ5PEPF000001F0.namprd05.prod.outlook.com
 (2603:10b6:a03:217:cafe::64) by BY3PR04CA0026.outlook.office365.com
 (2603:10b6:a03:217::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.8 via Frontend Transport; Thu, 4
 Jun 2026 14:55:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ5PEPF000001F0.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Thu, 4 Jun 2026 14:55:15 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 4 Jun
 2026 09:55:04 -0500
Received: from aaurabin-tumbleweed.king-squeaker.ts.net (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41
 via Frontend Transport; Thu, 4 Jun 2026 09:55:03 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Subject: [PATCH 14/24] drm/amd/display: Extract HDCP testable helpers for KUnit
Date: Thu, 4 Jun 2026 10:52:08 -0400
Message-ID: <20260604145428.809959-15-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260604145428.809959-1-aurabindo.pillai@amd.com>
References: <20260604145428.809959-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F0:EE_|SA1PR12MB8723:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ea4defc-fe27-454f-47b1-08dec249499e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|82310400026|1800799024|18002099003|6133799003|22082099003|56012099006|11063799006|3023799007;
X-Microsoft-Antispam-Message-Info: kSURyEAgz/WIEwq7ToFHwTRrrUkJyujS7Z9m0fmoo8a6gdlrriDzI4kk1d60G6G4bh+m8j2kKJnJyFKQ39HV8JHltsgP4h5tTdLv1fHFG8KtCFPQseiqwg8BHeGLAAcpG9XtAsNcEbODcxpWVH/gHGC0yrRL8jmTTnyMjWYY5IcyVz5xhrb/50flvG9Zz0F5k4xdLQU6MdnhmxcbF50pyUALbd0oxdBC5jdPC3n/h5BoQgAyhcbqfNExJ+CcJY5gcj4EVjN0zN/21mHPsBcue6RHg7MkkdCz5WHjrE/ZY4bpVMNK57ayJ7qbZyAnrbhTRL8Vsfxnz3dwcYfRY6kuMioesoLmAUlMjFzn6px43zmLNde5QJAIrjssBHS/vNrh8EODvrqNELJCPo3J0mHB6E+UNVis/yPBOdmR6XzdMIyaCrJRXbOEtxTCw03k7kmlPwPYEdYxqGAFv515yLw1rBajEppGmeebIWN8n4sephQg/j/GteYl1iWCNHTcXit0cr4aQdNR4IVpaenVBc1NQwIOAuFUde1/OVMtHGJFbMybO29tajE9na+/6s3SzmVEcv8wtWckoraXj1SnKlOw17mR/2rLTwF1NP2J51LGpXiCpfFHTqOM1v82I/R8NzLRowKuiskoO3ySlzZk2wkyiv27dzm5ZuKvzKmEonRpOPuqYv9LG7FRaowdxaAIzHnFUFcGJ1OzAyoLxdoHF8cXFPAcO1A1MoyK21oYCy8IIVE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(18002099003)(6133799003)(22082099003)(56012099006)(11063799006)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: PIRNnIYoFOGjfFlfZ1UwoYIFFhjA3IUhT9Fth8XLOrm21WyFwkwXnl94tMJkYHephjCy/aUT2tKR4gMdeTKwy1eJTmEGOp86yD7Wvw9JMShyhY8pDPNyShz/+HaAm0IpLJ6qxh6dVlFYENKKdxi3pCiMqGr8C1ZG2JrPi0n1ziXtBR1upzgY8RUv9LE7fjgJ1P//KyF1j+VwKAvu9TS1GW6/GtWFxPg/8VIH2IqLM5dT+QK8RdmRg4PkwTnbpfvrdUceuMUXvdAGPj4aocJxWbqMV61wRMNoF6sJDyW3NWz7+dj611oABN3uMLX49WD/Nw62rgD3JocPCIWMnCi3CyQV1djqQwEds23gmXGlY6GDQ/FkB0jmG+xHlLk+9669R/fTK0evrHagFiM0sPfaQYoag4TznYwtF+cIJKVoH5oRhtoDjGzufzOOchONpA0n
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2026 14:55:15.5654 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ea4defc-fe27-454f-47b1-08dec249499e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001F0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8723
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

From: Alex Hung <alex.hung@amd.com>

[WHAT]
Extract hdcp_get_content_protection_from_status() and
hdcp_get_link_display_adjustments() from event_property_update()
and hdcp_update_display() so the pure decision logic can be
KUnit-tested.

Also update function comments to kernel-doc formats.

Assisted-by: Copilot:Claude-Opus-4.6
Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_hdcp.c    | 115 ++++---
 .../amd/display/amdgpu_dm/amdgpu_dm_hdcp.h    |  12 +
 .../amdgpu_dm/tests/amdgpu_dm_hdcp_test.c     | 297 +++++++++++++++++-
 3 files changed, 370 insertions(+), 54 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
index d1de295f1171..039f6516085c 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
@@ -182,6 +182,70 @@ void process_output(struct hdcp_workqueue *hdcp_work)
 }
 EXPORT_IF_KUNIT(process_output);
 
+STATIC_IFN_KUNIT
+bool hdcp_get_content_protection_from_status(
+	unsigned int hdcp_content_type,
+	enum mod_hdcp_encryption_status encryption_status,
+	unsigned int *content_protection)
+{
+	if (encryption_status == MOD_HDCP_ENCRYPTION_STATUS_HDCP_OFF) {
+		*content_protection = DRM_MODE_CONTENT_PROTECTION_DESIRED;
+		return true;
+	}
+
+	if (hdcp_content_type == DRM_MODE_HDCP_CONTENT_TYPE0 &&
+	    encryption_status <= MOD_HDCP_ENCRYPTION_STATUS_HDCP2_TYPE0_ON) {
+		*content_protection = DRM_MODE_CONTENT_PROTECTION_ENABLED;
+		return true;
+	}
+
+	if (hdcp_content_type == DRM_MODE_HDCP_CONTENT_TYPE1 &&
+	    encryption_status == MOD_HDCP_ENCRYPTION_STATUS_HDCP2_TYPE1_ON) {
+		*content_protection = DRM_MODE_CONTENT_PROTECTION_ENABLED;
+		return true;
+	}
+
+	return false;
+}
+EXPORT_IF_KUNIT(hdcp_get_content_protection_from_status);
+
+STATIC_IFN_KUNIT
+void hdcp_get_link_display_adjustments(
+	bool enable_encryption,
+	u8 content_type,
+	bool fused_io_supported,
+	bool hdcp_lc_force_fw_enable,
+	bool hdcp_lc_enable_sw_fallback,
+	struct mod_hdcp_link_adjustment *link_adjust,
+	struct mod_hdcp_display_adjustment *display_adjust)
+{
+	memset(link_adjust, 0, sizeof(*link_adjust));
+	memset(display_adjust, 0, sizeof(*display_adjust));
+
+	if (!enable_encryption) {
+		display_adjust->disable =
+			MOD_HDCP_DISPLAY_DISABLE_AUTHENTICATION;
+		return;
+	}
+
+	display_adjust->disable = MOD_HDCP_DISPLAY_NOT_DISABLE;
+	link_adjust->auth_delay = 2;
+	link_adjust->retry_limit = MAX_NUM_OF_ATTEMPTS;
+
+	if (content_type == DRM_MODE_HDCP_CONTENT_TYPE0) {
+		link_adjust->hdcp2.force_type = MOD_HDCP_FORCE_TYPE_0;
+	} else if (content_type == DRM_MODE_HDCP_CONTENT_TYPE1) {
+		link_adjust->hdcp1.disable = 1;
+		link_adjust->hdcp2.force_type = MOD_HDCP_FORCE_TYPE_1;
+	}
+
+	link_adjust->hdcp2.use_fw_locality_check =
+		fused_io_supported || hdcp_lc_force_fw_enable;
+	link_adjust->hdcp2.use_sw_locality_fallback =
+		hdcp_lc_enable_sw_fallback;
+}
+EXPORT_IF_KUNIT(hdcp_get_link_display_adjustments);
+
 static void link_lock(struct hdcp_workqueue *work, bool lock)
 {
 	int i = 0;
@@ -212,8 +276,11 @@ void hdcp_update_display(struct hdcp_workqueue *hdcp_work,
 		drm_connector_put(&hdcp_w->aconnector[conn_index]->base);
 	hdcp_w->aconnector[conn_index] = aconnector;
 
-	memset(&link_adjust, 0, sizeof(link_adjust));
-	memset(&display_adjust, 0, sizeof(display_adjust));
+	hdcp_get_link_display_adjustments(enable_encryption, content_type,
+			dc->caps.fused_io_supported,
+			dc->debug.hdcp_lc_force_fw_enable,
+			dc->debug.hdcp_lc_enable_sw_fallback,
+			&link_adjust, &display_adjust);
 
 	if (enable_encryption) {
 		/* Explicitly set the saved SRM as sysfs call will be after we already enabled hdcp
@@ -224,25 +291,9 @@ void hdcp_update_display(struct hdcp_workqueue *hdcp_work,
 				    hdcp_work->srm_size,
 				    &hdcp_work->srm_version);
 
-		display_adjust.disable = MOD_HDCP_DISPLAY_NOT_DISABLE;
-
-		link_adjust.auth_delay = 2;
-		link_adjust.retry_limit = MAX_NUM_OF_ATTEMPTS;
-
-		if (content_type == DRM_MODE_HDCP_CONTENT_TYPE0) {
-			link_adjust.hdcp2.force_type = MOD_HDCP_FORCE_TYPE_0;
-		} else if (content_type == DRM_MODE_HDCP_CONTENT_TYPE1) {
-			link_adjust.hdcp1.disable = 1;
-			link_adjust.hdcp2.force_type = MOD_HDCP_FORCE_TYPE_1;
-		}
-		link_adjust.hdcp2.use_fw_locality_check =
-				(dc->caps.fused_io_supported || dc->debug.hdcp_lc_force_fw_enable);
-		link_adjust.hdcp2.use_sw_locality_fallback = dc->debug.hdcp_lc_enable_sw_fallback;
-
 		schedule_delayed_work(&hdcp_w->property_validate_dwork,
 				      msecs_to_jiffies(DRM_HDCP_CHECK_PERIOD_MS));
 	} else {
-		display_adjust.disable = MOD_HDCP_DISPLAY_DISABLE_AUTHENTICATION;
 		hdcp_w->encryption_status[conn_index] = MOD_HDCP_ENCRYPTION_STATUS_HDCP_OFF;
 		cancel_delayed_work(&hdcp_w->property_validate_dwork);
 	}
@@ -336,6 +387,7 @@ static void event_property_update(struct work_struct *work)
 							property_update_work);
 	struct amdgpu_dm_connector *aconnector = NULL;
 	struct drm_device *dev;
+	unsigned int content_protection;
 	long ret;
 	unsigned int conn_index;
 	struct drm_connector *connector;
@@ -375,26 +427,15 @@ static void event_property_update(struct work_struct *work)
 					MOD_HDCP_ENCRYPTION_STATUS_HDCP_OFF;
 			}
 		}
-		if (hdcp_work->encryption_status[conn_index] !=
-			MOD_HDCP_ENCRYPTION_STATUS_HDCP_OFF) {
-			if (conn_state->hdcp_content_type ==
-				DRM_MODE_HDCP_CONTENT_TYPE0 &&
-				hdcp_work->encryption_status[conn_index] <=
-				MOD_HDCP_ENCRYPTION_STATUS_HDCP2_TYPE0_ON) {
+		if (hdcp_get_content_protection_from_status(conn_state->hdcp_content_type,
+							    hdcp_work->encryption_status[conn_index],
+							    &content_protection)) {
+			if (content_protection == DRM_MODE_CONTENT_PROTECTION_ENABLED)
 				DRM_DEBUG_DRIVER("[HDCP_DM] DRM_MODE_CONTENT_PROTECTION_ENABLED\n");
-				drm_hdcp_update_content_protection(connector,
-								   DRM_MODE_CONTENT_PROTECTION_ENABLED);
-			} else if (conn_state->hdcp_content_type ==
-					DRM_MODE_HDCP_CONTENT_TYPE1 &&
-					hdcp_work->encryption_status[conn_index] ==
-					MOD_HDCP_ENCRYPTION_STATUS_HDCP2_TYPE1_ON) {
-				drm_hdcp_update_content_protection(connector,
-								   DRM_MODE_CONTENT_PROTECTION_ENABLED);
-			}
-		} else {
-			DRM_DEBUG_DRIVER("[HDCP_DM] DRM_MODE_CONTENT_PROTECTION_DESIRED\n");
-			drm_hdcp_update_content_protection(connector,
-							   DRM_MODE_CONTENT_PROTECTION_DESIRED);
+			else
+				DRM_DEBUG_DRIVER("[HDCP_DM] DRM_MODE_CONTENT_PROTECTION_DESIRED\n");
+
+			drm_hdcp_update_content_protection(connector, content_protection);
 		}
 		drm_modeset_unlock(&dev->mode_config.connection_mutex);
 	}
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.h
index 90b18c450ca6..3ba5823aed9f 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.h
@@ -96,6 +96,18 @@ struct hdcp_workqueue *hdcp_create_workqueue(struct amdgpu_device *adev, struct
 
 #if IS_ENABLED(CONFIG_DRM_AMD_DC_KUNIT_TEST)
 void process_output(struct hdcp_workqueue *hdcp_work);
+bool hdcp_get_content_protection_from_status(
+	unsigned int hdcp_content_type,
+	enum mod_hdcp_encryption_status encryption_status,
+	unsigned int *content_protection);
+void hdcp_get_link_display_adjustments(
+	bool enable_encryption,
+	u8 content_type,
+	bool fused_io_supported,
+	bool hdcp_lc_force_fw_enable,
+	bool hdcp_lc_enable_sw_fallback,
+	struct mod_hdcp_link_adjustment *link_adjust,
+	struct mod_hdcp_display_adjustment *display_adjust);
 #endif
 
 #endif /* AMDGPU_DM_AMDGPU_DM_HDCP_H_ */
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_hdcp_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_hdcp_test.c
index d03b606d27bc..619b4a80c82b 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_hdcp_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_hdcp_test.c
@@ -12,11 +12,241 @@
 
 static void dummy_work_fn(struct work_struct *work) {}
 
+/* Tests for hdcp_get_content_protection_from_status() */
+
+/**
+ * dm_test_hdcp_get_cp_disabled_returns_desired - HDCP off maps to DESIRED
+ * @test: KUnit test context
+ *
+ * When encryption status is HDCP_OFF, content_protection should be set
+ * to DESIRED and the function should return true to indicate an update.
+ */
+static void dm_test_hdcp_get_cp_disabled_returns_desired(struct kunit *test)
+{
+	unsigned int content_protection = DRM_MODE_CONTENT_PROTECTION_UNDESIRED;
+	bool update;
+
+	update = hdcp_get_content_protection_from_status(
+		DRM_MODE_HDCP_CONTENT_TYPE0,
+		MOD_HDCP_ENCRYPTION_STATUS_HDCP_OFF,
+		&content_protection);
+
+	KUNIT_EXPECT_TRUE(test, update);
+	KUNIT_EXPECT_EQ(test, content_protection,
+			DRM_MODE_CONTENT_PROTECTION_DESIRED);
+}
+
+/**
+ * dm_test_hdcp_get_cp_type0_returns_enabled - TYPE0 with TYPE0_ON maps to ENABLED
+ * @test: KUnit test context
+ *
+ * When content type is TYPE0 and encryption status is at or below
+ * HDCP2_TYPE0_ON, content_protection should be set to ENABLED.
+ */
+static void dm_test_hdcp_get_cp_type0_returns_enabled(struct kunit *test)
+{
+	unsigned int content_protection = DRM_MODE_CONTENT_PROTECTION_UNDESIRED;
+	bool update;
+
+	update = hdcp_get_content_protection_from_status(
+		DRM_MODE_HDCP_CONTENT_TYPE0,
+		MOD_HDCP_ENCRYPTION_STATUS_HDCP2_TYPE0_ON,
+		&content_protection);
+
+	KUNIT_EXPECT_TRUE(test, update);
+	KUNIT_EXPECT_EQ(test, content_protection,
+			DRM_MODE_CONTENT_PROTECTION_ENABLED);
+}
+
+/**
+ * dm_test_hdcp_get_cp_type1_returns_enabled - TYPE1 with TYPE1_ON maps to ENABLED
+ * @test: KUnit test context
+ *
+ * When content type is TYPE1 and encryption status is exactly
+ * HDCP2_TYPE1_ON, content_protection should be set to ENABLED.
+ */
+static void dm_test_hdcp_get_cp_type1_returns_enabled(struct kunit *test)
+{
+	unsigned int content_protection = DRM_MODE_CONTENT_PROTECTION_UNDESIRED;
+	bool update;
+
+	update = hdcp_get_content_protection_from_status(
+		DRM_MODE_HDCP_CONTENT_TYPE1,
+		MOD_HDCP_ENCRYPTION_STATUS_HDCP2_TYPE1_ON,
+		&content_protection);
+
+	KUNIT_EXPECT_TRUE(test, update);
+	KUNIT_EXPECT_EQ(test, content_protection,
+			DRM_MODE_CONTENT_PROTECTION_ENABLED);
+}
+
+/**
+ * dm_test_hdcp_get_cp_type1_rejects_type0_status - TYPE1 rejects TYPE0_ON
+ * @test: KUnit test context
+ *
+ * When content type is TYPE1 but encryption status is only TYPE0_ON,
+ * the function should return false and leave content_protection unchanged.
+ */
+static void dm_test_hdcp_get_cp_type1_rejects_type0_status(struct kunit *test)
+{
+	unsigned int content_protection = DRM_MODE_CONTENT_PROTECTION_UNDESIRED;
+	bool update;
+
+	update = hdcp_get_content_protection_from_status(
+		DRM_MODE_HDCP_CONTENT_TYPE1,
+		MOD_HDCP_ENCRYPTION_STATUS_HDCP2_TYPE0_ON,
+		&content_protection);
+
+	KUNIT_EXPECT_FALSE(test, update);
+	KUNIT_EXPECT_EQ(test, content_protection,
+			DRM_MODE_CONTENT_PROTECTION_UNDESIRED);
+}
+
+/**
+ * dm_test_hdcp_get_cp_type0_rejects_type1_status - TYPE0 rejects TYPE1_ON
+ * @test: KUnit test context
+ *
+ * When content type is TYPE0 but encryption status exceeds the TYPE0_ON
+ * boundary (TYPE1_ON), the function should return false.
+ */
+static void dm_test_hdcp_get_cp_type0_rejects_type1_status(struct kunit *test)
+{
+	unsigned int content_protection = DRM_MODE_CONTENT_PROTECTION_UNDESIRED;
+	bool update;
+
+	update = hdcp_get_content_protection_from_status(
+		DRM_MODE_HDCP_CONTENT_TYPE0,
+		MOD_HDCP_ENCRYPTION_STATUS_HDCP2_TYPE1_ON,
+		&content_protection);
+
+	KUNIT_EXPECT_FALSE(test, update);
+	KUNIT_EXPECT_EQ(test, content_protection,
+			DRM_MODE_CONTENT_PROTECTION_UNDESIRED);
+}
+
+/* Tests for hdcp_get_link_display_adjustments() */
+
+/**
+ * dm_test_hdcp_get_adjustments_disable_authentication - disable path zeroes adjustments
+ * @test: KUnit test context
+ *
+ * When enable_encryption is false, display_adjust should disable
+ * authentication and all link_adjust fields should remain zeroed.
+ */
+static void dm_test_hdcp_get_adjustments_disable_authentication(struct kunit *test)
+{
+	struct mod_hdcp_link_adjustment link_adjust;
+	struct mod_hdcp_display_adjustment display_adjust;
+	unsigned int disable;
+	unsigned int hdcp1_disable;
+	unsigned int force_type;
+
+	hdcp_get_link_display_adjustments(false, DRM_MODE_HDCP_CONTENT_TYPE0,
+		false, false, false, &link_adjust, &display_adjust);
+	disable = display_adjust.disable;
+	hdcp1_disable = link_adjust.hdcp1.disable;
+	force_type = link_adjust.hdcp2.force_type;
+
+	KUNIT_EXPECT_EQ(test, disable,
+			MOD_HDCP_DISPLAY_DISABLE_AUTHENTICATION);
+	KUNIT_EXPECT_EQ(test, link_adjust.auth_delay, 0);
+	KUNIT_EXPECT_EQ(test, link_adjust.retry_limit, 0);
+	KUNIT_EXPECT_EQ(test, hdcp1_disable, 0);
+	KUNIT_EXPECT_EQ(test, force_type, 0);
+}
+
+/**
+ * dm_test_hdcp_get_adjustments_type0_policy - TYPE0 enables HDCP1 and forces TYPE0
+ * @test: KUnit test context
+ *
+ * When encryption is enabled with content TYPE0, hdcp1 should remain
+ * enabled, force_type should be TYPE_0, and sw_locality_fallback should
+ * be propagated from the input parameter.
+ */
+static void dm_test_hdcp_get_adjustments_type0_policy(struct kunit *test)
+{
+	struct mod_hdcp_link_adjustment link_adjust;
+	struct mod_hdcp_display_adjustment display_adjust;
+	unsigned int disable;
+	unsigned int hdcp1_disable;
+	unsigned int force_type;
+
+	hdcp_get_link_display_adjustments(true, DRM_MODE_HDCP_CONTENT_TYPE0,
+		false, false, true, &link_adjust, &display_adjust);
+	disable = display_adjust.disable;
+	hdcp1_disable = link_adjust.hdcp1.disable;
+	force_type = link_adjust.hdcp2.force_type;
+
+	KUNIT_EXPECT_EQ(test, disable,
+			MOD_HDCP_DISPLAY_NOT_DISABLE);
+	KUNIT_EXPECT_EQ(test, link_adjust.auth_delay, 2);
+	KUNIT_EXPECT_EQ(test, link_adjust.retry_limit, MAX_NUM_OF_ATTEMPTS);
+	KUNIT_EXPECT_EQ(test, hdcp1_disable, 0);
+	KUNIT_EXPECT_EQ(test, force_type,
+			MOD_HDCP_FORCE_TYPE_0);
+	KUNIT_EXPECT_FALSE(test, link_adjust.hdcp2.use_fw_locality_check);
+	KUNIT_EXPECT_TRUE(test, link_adjust.hdcp2.use_sw_locality_fallback);
+}
+
+/**
+ * dm_test_hdcp_get_adjustments_type1_policy - TYPE1 disables HDCP1 and forces TYPE1
+ * @test: KUnit test context
+ *
+ * When encryption is enabled with content TYPE1, hdcp1 should be
+ * disabled, force_type should be TYPE_1, and fw_locality_check should
+ * be enabled when hdcp_lc_force_fw_enable is set.
+ */
+static void dm_test_hdcp_get_adjustments_type1_policy(struct kunit *test)
+{
+	struct mod_hdcp_link_adjustment link_adjust;
+	struct mod_hdcp_display_adjustment display_adjust;
+	unsigned int disable;
+	unsigned int hdcp1_disable;
+	unsigned int force_type;
+
+	hdcp_get_link_display_adjustments(true, DRM_MODE_HDCP_CONTENT_TYPE1,
+		false, true, false, &link_adjust, &display_adjust);
+	disable = display_adjust.disable;
+	hdcp1_disable = link_adjust.hdcp1.disable;
+	force_type = link_adjust.hdcp2.force_type;
+
+	KUNIT_EXPECT_EQ(test, disable,
+			MOD_HDCP_DISPLAY_NOT_DISABLE);
+	KUNIT_EXPECT_EQ(test, link_adjust.auth_delay, 2);
+	KUNIT_EXPECT_EQ(test, link_adjust.retry_limit, MAX_NUM_OF_ATTEMPTS);
+	KUNIT_EXPECT_EQ(test, hdcp1_disable, 1);
+	KUNIT_EXPECT_EQ(test, force_type,
+			MOD_HDCP_FORCE_TYPE_1);
+	KUNIT_EXPECT_TRUE(test, link_adjust.hdcp2.use_fw_locality_check);
+	KUNIT_EXPECT_FALSE(test, link_adjust.hdcp2.use_sw_locality_fallback);
+}
+
+/**
+ * dm_test_hdcp_get_adjustments_fused_io_enables_fw_check - fused_io enables FW locality check
+ * @test: KUnit test context
+ *
+ * When fused_io_supported is true, use_fw_locality_check should be
+ * enabled regardless of hdcp_lc_force_fw_enable.
+ */
+static void dm_test_hdcp_get_adjustments_fused_io_enables_fw_check(struct kunit *test)
+{
+	struct mod_hdcp_link_adjustment link_adjust;
+	struct mod_hdcp_display_adjustment display_adjust;
+
+	hdcp_get_link_display_adjustments(true, DRM_MODE_HDCP_CONTENT_TYPE0,
+		true, false, false, &link_adjust, &display_adjust);
+
+	KUNIT_EXPECT_TRUE(test, link_adjust.hdcp2.use_fw_locality_check);
+}
+
 /* Tests for process_output() */
 
-/*
- * Helper: allocate and initialise a minimal hdcp_workqueue sufficient for
- * process_output() testing.  Only the three delayed works accessed by
+/**
+ * alloc_test_workqueue - allocate a minimal hdcp_workqueue for testing
+ * @test: KUnit test context for managed allocation
+ *
+ * Allocates and initialises a minimal hdcp_workqueue sufficient for
+ * process_output() testing. Only the three delayed works accessed by
  * process_output() are initialised; everything else is zeroed.
  */
 static struct hdcp_workqueue *alloc_test_workqueue(struct kunit *test)
@@ -33,9 +263,12 @@ static struct hdcp_workqueue *alloc_test_workqueue(struct kunit *test)
 	return work;
 }
 
-/*
+/**
+ * dm_test_process_output_property_validate_always_scheduled - validate_dwork always queued
+ * @test: KUnit test context
+ *
  * process_output() always schedules property_validate_dwork with delay=0,
- * which queues the work item directly (bypassing the timer).  Use
+ * which queues the work item directly (bypassing the timer). Uses
  * work_pending() rather than delayed_work_pending() to detect this.
  */
 static void dm_test_process_output_property_validate_always_scheduled(struct kunit *test)
@@ -52,8 +285,12 @@ static void dm_test_process_output_property_validate_always_scheduled(struct kun
 	cancel_delayed_work_sync(&work->property_validate_dwork);
 }
 
-/*
- * output.callback_needed=true must schedule callback_dwork.
+/**
+ * dm_test_process_output_callback_needed - callback_needed schedules callback_dwork
+ * @test: KUnit test context
+ *
+ * When output.callback_needed is true, process_output() must schedule
+ * callback_dwork with the specified delay.
  */
 static void dm_test_process_output_callback_needed(struct kunit *test)
 {
@@ -70,8 +307,12 @@ static void dm_test_process_output_callback_needed(struct kunit *test)
 	cancel_delayed_work_sync(&work->property_validate_dwork);
 }
 
-/*
- * output.callback_stop=true must cancel a previously scheduled callback_dwork.
+/**
+ * dm_test_process_output_callback_stop - callback_stop cancels callback_dwork
+ * @test: KUnit test context
+ *
+ * When output.callback_stop is true, process_output() must cancel a
+ * previously scheduled callback_dwork.
  */
 static void dm_test_process_output_callback_stop(struct kunit *test)
 {
@@ -90,8 +331,12 @@ static void dm_test_process_output_callback_stop(struct kunit *test)
 	cancel_delayed_work_sync(&work->property_validate_dwork);
 }
 
-/*
- * output.watchdog_timer_needed=true must schedule watchdog_timer_dwork.
+/**
+ * dm_test_process_output_watchdog_needed - watchdog_needed schedules watchdog_dwork
+ * @test: KUnit test context
+ *
+ * When output.watchdog_timer_needed is true, process_output() must
+ * schedule watchdog_timer_dwork with the specified delay.
  */
 static void dm_test_process_output_watchdog_needed(struct kunit *test)
 {
@@ -108,9 +353,12 @@ static void dm_test_process_output_watchdog_needed(struct kunit *test)
 	cancel_delayed_work_sync(&work->property_validate_dwork);
 }
 
-/*
- * output.watchdog_timer_stop=true must cancel a previously scheduled
- * watchdog_timer_dwork.
+/**
+ * dm_test_process_output_watchdog_stop - watchdog_stop cancels watchdog_dwork
+ * @test: KUnit test context
+ *
+ * When output.watchdog_timer_stop is true, process_output() must cancel
+ * a previously scheduled watchdog_timer_dwork.
  */
 static void dm_test_process_output_watchdog_stop(struct kunit *test)
 {
@@ -129,9 +377,12 @@ static void dm_test_process_output_watchdog_stop(struct kunit *test)
 	cancel_delayed_work_sync(&work->property_validate_dwork);
 }
 
-/*
- * Both callback_needed and watchdog_timer_needed set: both dworks are
- * scheduled independently.
+/**
+ * dm_test_process_output_callback_and_watchdog_needed - both dworks scheduled independently
+ * @test: KUnit test context
+ *
+ * When both callback_needed and watchdog_timer_needed are set,
+ * process_output() must schedule both dworks independently.
  */
 static void dm_test_process_output_callback_and_watchdog_needed(struct kunit *test)
 {
@@ -154,6 +405,18 @@ static void dm_test_process_output_callback_and_watchdog_needed(struct kunit *te
 /* End of tests for process_output() */
 
 static struct kunit_case dm_hdcp_test_cases[] = {
+	/* hdcp_get_content_protection_from_status() */
+	KUNIT_CASE(dm_test_hdcp_get_cp_disabled_returns_desired),
+	KUNIT_CASE(dm_test_hdcp_get_cp_type0_returns_enabled),
+	KUNIT_CASE(dm_test_hdcp_get_cp_type1_returns_enabled),
+	KUNIT_CASE(dm_test_hdcp_get_cp_type1_rejects_type0_status),
+	KUNIT_CASE(dm_test_hdcp_get_cp_type0_rejects_type1_status),
+	/* hdcp_get_link_display_adjustments() */
+	KUNIT_CASE(dm_test_hdcp_get_adjustments_disable_authentication),
+	KUNIT_CASE(dm_test_hdcp_get_adjustments_type0_policy),
+	KUNIT_CASE(dm_test_hdcp_get_adjustments_type1_policy),
+	KUNIT_CASE(dm_test_hdcp_get_adjustments_fused_io_enables_fw_check),
+	/* process_output() */
 	KUNIT_CASE(dm_test_process_output_property_validate_always_scheduled),
 	KUNIT_CASE(dm_test_process_output_callback_needed),
 	KUNIT_CASE(dm_test_process_output_callback_stop),
-- 
2.54.0

