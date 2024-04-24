Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 368B7C4345F
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Apr 2024 08:54:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B18C910FE35;
	Wed, 24 Apr 2024 08:54:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="d3GyZB3u";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2055.outbound.protection.outlook.com [40.107.100.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9194E10FE35
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Apr 2024 08:54:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ek8L08YJOLL4H9hoRZqCFi6i8/J+l8ri8hv9TfJ2Uc9SPmADCZLt0e6878MIcNom5N6tinSsTKBjVybWW6ydJlIVjb91X/67gQoopf3UcO5C+PEjjgCqIkbGTqPVS/93GbZfGK32FCROU8qFC/zW0YDiTwQtIiBVDBZLoCANF78BJAyuHu1QFTVopROMCI3DSI/8lI7AIiRI1t+FK6joEaXOWEq3vgn9anDOTHMlwNu6r0ypH1FOZk2yIC50ES7S398JxVoQmqQ+14jP6f9sybXdj+j7cOx5biMfEGzMXoeWlOiILUg2pdwb6S/3PPuD5JhmtbXyLqlAns7ImaYl+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E5KrsSxzmwUFHSrW5M4y+GF+rUuDScXFsiM7GfBmJcw=;
 b=acBO//CWkm1YVqiCERDB1OCw6b4d2BdevBLsf5h73nU+elv3tOB9DnSX+vxci8s5kOxal2hdnx2QjlPkiNzUM1DjpQVPQLSPeAYK+IGUNLBnVYIV8Bv7Cu1wIxbbkpCZJNBP/wc2cL5QKhIzwtSr0/eGEoqp4cWWGS2X2wDLmAP5/VeeW01AmBYe9JkWqF1EAlEISOBcog8KFq/ZSq87hS+7tzyGbXcHmjv8LW2zmf4Vv0NE+ABVQTnRIGEDRPOciLWJf3XWNlF5PMp6HkSFhnpJvN2eDVUlVGhsRPth9mRINroV83zXGUCKvSv5zr5Ypz8+t6ajCT3ZzMVLNKztug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E5KrsSxzmwUFHSrW5M4y+GF+rUuDScXFsiM7GfBmJcw=;
 b=d3GyZB3u4IlOjQtuZsDZxv4h2bsRA2SINDylpHM98Ry7JoztD7QWKxnlDs54pvO6+BL6AZkK5Tpm46XlqdQm9WulEsx8UUT2XPm5BeM7BSOgpCB/IG2/1ZCKXimhXMNc7kzbjN7An7qErfAXE0BC2uwbI4BV5Tya1KuNFvjG5Sc=
Received: from BYAPR05CA0041.namprd05.prod.outlook.com (2603:10b6:a03:74::18)
 by IA0PR12MB7724.namprd12.prod.outlook.com (2603:10b6:208:430::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22; Wed, 24 Apr
 2024 08:54:06 +0000
Received: from MWH0EPF000971E5.namprd02.prod.outlook.com
 (2603:10b6:a03:74:cafe::c8) by BYAPR05CA0041.outlook.office365.com
 (2603:10b6:a03:74::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.21 via Frontend
 Transport; Wed, 24 Apr 2024 08:54:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 MWH0EPF000971E5.mail.protection.outlook.com (10.167.243.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Wed, 24 Apr 2024 08:54:06 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 24 Apr
 2024 03:54:05 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 24 Apr
 2024 01:54:04 -0700
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 24 Apr 2024 03:54:01 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Hamza Mahfooz
 <hamza.mahfooz@amd.com>
Subject: [PATCH 42/46] drm/amd/display: Add periodic detection for IPS
Date: Wed, 24 Apr 2024 16:49:27 +0800
Message-ID: <20240424084931.2656128-43-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20240424084931.2656128-1-Wayne.Lin@amd.com>
References: <20240424084931.2656128-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E5:EE_|IA0PR12MB7724:EE_
X-MS-Office365-Filtering-Correlation-Id: 83001da7-2322-4091-8200-08dc643c1948
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|376005|1800799015|36860700004|82310400014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?1EpUSwyUfakxDwPR6MWI0ZohmrEOBGCBN0XZdjOl/Sgsm3bsBtWz5rBIyaVF?=
 =?us-ascii?Q?NCwlJquyUAGbBw8vKCsE2mCEc5c2i5/7nEdpkmyiJ+g25nIRoGps6gyFm03H?=
 =?us-ascii?Q?zPqeEEO0AVGqfoJy5nqaoFDsHaXVbzPl1Wysruky33+df9j2Z3vMYWJDiA0X?=
 =?us-ascii?Q?vTxXAtnPQKxonvkmvcYkn3aec6eMHgT+suLut3ZOGKabUHav/ZgUumsO+yhD?=
 =?us-ascii?Q?sM7SHXNWb+1D9PsDz4TR3R530ItlSs3a7WsCtQJ7GzuiRMkkxH39Uw6UJnDd?=
 =?us-ascii?Q?txuwWYZHbvQAjQ+dNimAnls0q4D/r/U4g4hOxO3fCQ3UHElMw1BJFppavEx+?=
 =?us-ascii?Q?slAVovVjeEHtuMpU2+oSAJY0D8n35KCsBKB1teuwgCdO38Y3deL/AWph4N5Z?=
 =?us-ascii?Q?zHB6joj9ooTJqRh3+hWKxwFAK6qwvv31SpXAe5LWDRF7QGYM9XwrUeS4o3m4?=
 =?us-ascii?Q?vyH+fEhUQRsT4ndMcII1XrFyF6QUsgmB/iyr7b/2fIhH4uQZiFxmYAoAdJAV?=
 =?us-ascii?Q?6B2oDuECxdpR57OUgzC/vEr2Tw51SwhqZIzROKsSTciM/axWQXJENDk0tUh4?=
 =?us-ascii?Q?kziRxnxiG8iv1Z9CjXPGsVQhBWw+zL8ipMcPSiTqFpHIsRvuNx/sPfzqkNsD?=
 =?us-ascii?Q?dq+BXI5bK8iiRpTRGll9Mamwglq8edt0f1IhhzgHkDCF21cr3Rl2/C2dezyE?=
 =?us-ascii?Q?twmCyMoF8d5kSVV6VlEGoh1yDV6QHor/uNsxqKuJGaoGOd4Vah4Qo/cucm4A?=
 =?us-ascii?Q?/fQixUE+4MBQO0tUnB3z7BtyFflAbcPlH3A4YhW7OFD7A/rcH8+EJnotnkGj?=
 =?us-ascii?Q?3uAAc/IIN4affPMeaREGl4xp8Ly1Z3ftTyLP4GOWblUeAoOvFt2MfNeOVxrO?=
 =?us-ascii?Q?wNcmMdeK8jEcItG0ALjOXOcVo6Mi1pvKIyZIT19/YZ4yA60GvenG4ddDRt5e?=
 =?us-ascii?Q?lZikX0OIMJCj9UonsFA2PJ+QTyyDLjtDCZ+hSeiNJVBlB6bM64herEjG8e2U?=
 =?us-ascii?Q?NLgdG2rV9yB1Wl6KblIv7CkxAlsRldrDTX+vQOska3cSDVvvM7/q3B1ozpWI?=
 =?us-ascii?Q?K4H92uBQV2H7WLi4fFprFzetauTtPucDAjdnDUVsSk33efiJHNbhThtpp0Fu?=
 =?us-ascii?Q?Oivfbm+v1z7+tysI+NcwfHQwTf0mm8+pTfrIcoacM3GERgM/ZmJncJKzrcyD?=
 =?us-ascii?Q?r3H4gjDh9DblUV+1pZchMIdoRIHv9LhSsS/TsIU4c5j/L1k4AzMBEYUnsSyG?=
 =?us-ascii?Q?5A0X28vdvux/pr9fuKy7MSgxw9Z0Za94IxM3iIM6uQGPB8RmpRjKz9ZfGBUB?=
 =?us-ascii?Q?CDlEJVwC9wcTsB8KGca1PEtAr8Lq4ebVEJEx+l44UUh/TegzX5CPvq3pqLgx?=
 =?us-ascii?Q?2R1TUOU=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(36860700004)(82310400014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 08:54:06.3046 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 83001da7-2322-4091-8200-08dc643c1948
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7724
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

From: Roman Li <roman.li@amd.com>

[Why]
HPD interrupt cannot be handled in IPS2 state.
So if there's a display topology change while system in IPS2
it can be missed.

[How]
Implement worker to check each 5 sec in IPS for HPD.

Reviewed-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 13 ++++
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  9 +++
 .../amd/display/amdgpu_dm/amdgpu_dm_crtc.c    | 59 ++++++++++++++++++-
 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c |  5 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c | 28 +++++++++
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_psr.h |  1 +
 6 files changed, 113 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 29b5c953a656..eb946f1ad4d5 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1838,6 +1838,9 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 			DRM_ERROR("amdgpu: failed to initialize vblank_workqueue.\n");
 	}
 
+	if (adev->dm.dc->caps.ips_support && adev->dm.dc->config.disable_ips == DMUB_IPS_ENABLE)
+		adev->dm.idle_workqueue = idle_create_workqueue(adev);
+
 	if (adev->dm.dc->caps.max_links > 0 && adev->family >= AMDGPU_FAMILY_RV) {
 		adev->dm.hdcp_workqueue = hdcp_create_workqueue(adev, &init_params.cp_psp, adev->dm.dc);
 
@@ -1935,6 +1938,16 @@ static void amdgpu_dm_fini(struct amdgpu_device *adev)
 		adev->dm.vblank_control_workqueue = NULL;
 	}
 
+	if (adev->dm.idle_workqueue) {
+		if (adev->dm.idle_workqueue->running) {
+			adev->dm.idle_workqueue->enable = false;
+			flush_work(&adev->dm.idle_workqueue->work);
+		}
+
+		kfree(adev->dm.idle_workqueue);
+		adev->dm.idle_workqueue = NULL;
+	}
+
 	amdgpu_dm_destroy_drm_device(&adev->dm);
 
 #if defined(CONFIG_DRM_AMD_SECURE_DISPLAY)
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index 09519b7abf67..79469cdc3b10 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -137,6 +137,13 @@ struct vblank_control_work {
 	bool enable;
 };
 
+struct idle_workqueue {
+	struct work_struct work;
+	struct amdgpu_display_manager *dm;
+	bool enable;
+	bool running;
+};
+
 /**
  * struct amdgpu_dm_backlight_caps - Information about backlight
  *
@@ -487,6 +494,7 @@ struct amdgpu_display_manager {
 	 * Deferred work for vblank control events.
 	 */
 	struct workqueue_struct *vblank_control_workqueue;
+	struct idle_workqueue *idle_workqueue;
 
 	struct drm_atomic_state *cached_state;
 	struct dc_state *cached_dc_state;
@@ -956,4 +964,5 @@ amdgpu_dm_find_first_crtc_matching_connector(struct drm_atomic_state *state,
 					     struct drm_crtc *crtc);
 
 int convert_dc_color_depth_into_bpc(enum dc_color_depth display_color_depth);
+struct idle_workqueue *idle_create_workqueue(struct amdgpu_device *adev);
 #endif /* __AMDGPU_DM_H__ */
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
index e23a0a276e33..83ea0afddda7 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
@@ -35,6 +35,9 @@
 #include "amdgpu_dm_trace.h"
 #include "amdgpu_dm_debugfs.h"
 
+#define HPD_DETECTION_PERIOD_uS 5000000
+#define HPD_DETECTION_TIME_uS 1000
+
 void amdgpu_dm_crtc_handle_vblank(struct amdgpu_crtc *acrtc)
 {
 	struct drm_crtc *crtc = &acrtc->base;
@@ -146,11 +149,65 @@ static void amdgpu_dm_crtc_set_panel_sr_feature(
 		struct amdgpu_dm_connector *aconn =
 			(struct amdgpu_dm_connector *) vblank_work->stream->dm_stream_context;
 
-		if (!aconn->disallow_edp_enter_psr)
+		if (!aconn->disallow_edp_enter_psr) {
+			struct amdgpu_display_manager *dm = vblank_work->dm;
+
 			amdgpu_dm_psr_enable(vblank_work->stream);
+			if (dm->idle_workqueue &&
+			    dm->dc->idle_optimizations_allowed &&
+			    dm->idle_workqueue->enable &&
+			    !dm->idle_workqueue->running)
+				schedule_work(&dm->idle_workqueue->work);
+		}
 	}
 }
 
+static void amdgpu_dm_idle_worker(struct work_struct *work)
+{
+	struct idle_workqueue *idle_work;
+
+	idle_work = container_of(work, struct idle_workqueue, work);
+	idle_work->dm->idle_workqueue->running = true;
+	fsleep(HPD_DETECTION_PERIOD_uS);
+	mutex_lock(&idle_work->dm->dc_lock);
+	while (idle_work->enable) {
+		if (!idle_work->dm->dc->idle_optimizations_allowed)
+			break;
+
+		dc_allow_idle_optimizations(idle_work->dm->dc, false);
+
+		mutex_unlock(&idle_work->dm->dc_lock);
+		fsleep(HPD_DETECTION_TIME_uS);
+		mutex_lock(&idle_work->dm->dc_lock);
+
+		if (!amdgpu_dm_psr_is_active_allowed(idle_work->dm))
+			break;
+
+		dc_allow_idle_optimizations(idle_work->dm->dc, true);
+		mutex_unlock(&idle_work->dm->dc_lock);
+		fsleep(HPD_DETECTION_PERIOD_uS);
+		mutex_lock(&idle_work->dm->dc_lock);
+	}
+	mutex_unlock(&idle_work->dm->dc_lock);
+	idle_work->dm->idle_workqueue->running = false;
+}
+
+struct idle_workqueue *idle_create_workqueue(struct amdgpu_device *adev)
+{
+	struct idle_workqueue *idle_work;
+
+	idle_work = kzalloc(sizeof(*idle_work), GFP_KERNEL);
+	if (ZERO_OR_NULL_PTR(idle_work))
+		return NULL;
+
+	idle_work->dm = &adev->dm;
+	idle_work->enable = false;
+	idle_work->running = false;
+	INIT_WORK(&idle_work->work, amdgpu_dm_idle_worker);
+
+	return idle_work;
+}
+
 static void amdgpu_dm_crtc_vblank_control_worker(struct work_struct *work)
 {
 	struct vblank_control_work *vblank_work =
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
index c27063305a13..7a510fe66908 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
@@ -1261,7 +1261,10 @@ void dm_set_phyd32clk(struct dc_context *ctx, int freq_khz)
 
 void dm_helpers_enable_periodic_detection(struct dc_context *ctx, bool enable)
 {
-	/* TODO: add periodic detection implementation */
+	struct amdgpu_device *adev = ctx->driver_context;
+
+	if (adev->dm.idle_workqueue)
+		adev->dm.idle_workqueue->enable = enable;
 }
 
 void dm_helpers_dp_mst_update_branch_bandwidth(
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
index bfa090432ce2..633ab1c16dc6 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
@@ -223,3 +223,31 @@ bool amdgpu_dm_psr_disable_all(struct amdgpu_display_manager *dm)
 	return dc_set_psr_allow_active(dm->dc, false);
 }
 
+/*
+ * amdgpu_dm_psr_is_active_allowed() - check if psr is allowed on any stream
+ * @dm:  pointer to amdgpu_display_manager
+ *
+ * Return: true if allowed
+ */
+
+bool amdgpu_dm_psr_is_active_allowed(struct amdgpu_display_manager *dm)
+{
+	unsigned int i;
+	bool allow_active = false;
+
+	for (i = 0; i < dm->dc->current_state->stream_count ; i++) {
+		struct dc_link *link;
+		struct dc_stream_state *stream = dm->dc->current_state->streams[i];
+
+		link = stream->link;
+		if (!link)
+			continue;
+		if (link->psr_settings.psr_feature_enabled &&
+		    link->psr_settings.psr_allow_active) {
+			allow_active = true;
+			break;
+		}
+	}
+
+	return allow_active;
+}
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.h
index 1fdfd183c0d9..cd2d45c2b5ef 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.h
@@ -36,5 +36,6 @@ void amdgpu_dm_psr_enable(struct dc_stream_state *stream);
 bool amdgpu_dm_link_setup_psr(struct dc_stream_state *stream);
 bool amdgpu_dm_psr_disable(struct dc_stream_state *stream);
 bool amdgpu_dm_psr_disable_all(struct amdgpu_display_manager *dm);
+bool amdgpu_dm_psr_is_active_allowed(struct amdgpu_display_manager *dm);
 
 #endif /* AMDGPU_DM_AMDGPU_DM_PSR_H_ */
-- 
2.37.3

