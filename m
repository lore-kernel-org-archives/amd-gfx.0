Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D6A5C04FDE
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Dec 2022 16:37:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C975510E569;
	Fri,  9 Dec 2022 16:37:39 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on20604.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e83::604])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8471E10E558
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Dec 2022 16:37:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j5cSQzx6+hfkIEi6jdnzit81A6ne8V7yLdDv2Y8ZsbcBeXlEn6LvFh4u2Kii1aXDjvvg5gHq7MLkyNCn+jHeMKCBf/ulspA3pe2fnU7Z86HhtuGrPj6IzeX2VpOQW1Mlcu/ZWJu8TrK1pnVrRlgNmMsh8HyBwSyfm9iijIjuW+cjwv3ypfxt8ucItVRElM2TUKT0N1mC78b97T4uMqzw+xiVZTr1HKhSPfnXlaUe4l1IWECO88jL9axDbjwLYDpSW+veQQNOK7YpZcl5nW9eTYrKW6C/LY6isOuMyNfcDcch+2GN4FGScTsLFo3/5TYuZllMhJWsuUjsW+1QEPEg0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OjYbxa6bjjKqaQl4DuZuk42TSBuRCMKVDLbrny9Piss=;
 b=mmQsD20jb3PAbtQwoJH7aff8coBw8Au+PLo/nGUA3JSWVFThRrEAUp/ULDVH6h5D0XahdDnYuJ0gxb5wOhuRAVMqSHwYYpgLewYDZtkG5z/NPtnLvJkNYRVb5h3GQWjOpGRgcXwcKVDHBZFbtBXUDResHegu+WvUL/l9yr8TAxdJisLrRpqeS1uEnM+f0dik1mnoG18LA9zDo4eM2WW1ENx2jz9M/e+frbVHMdy/LxkaWRIQ+LQQoZgrDuaUHrpv4uiXRRM4cwTQjeKQO/h3a81ori40L11cCuj+dV9j4PiVh80QneRdyribtuW4Jlv5fJlNGNKq4LUFADghRmglqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OjYbxa6bjjKqaQl4DuZuk42TSBuRCMKVDLbrny9Piss=;
 b=qfV9lNS8llCGMDhwKYM3rNjNNv/upuaT9EtD4482QTY15uKEzz1ozkH4OMfgZQdn7mBJyImGs3QTNBqCGbcEIqAR33wUrPjizGLOoj3rdPFHDZFIyw+yuDBJSiLaDj7ZnDZtOKbYyBLrZRohqNT3IPl6s50oWwQoQuCB15zx7ls=
Received: from MW4PR04CA0332.namprd04.prod.outlook.com (2603:10b6:303:8a::7)
 by DM4PR12MB6012.namprd12.prod.outlook.com (2603:10b6:8:6c::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5880.18; Fri, 9 Dec 2022 16:37:28 +0000
Received: from CO1NAM11FT085.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8a:cafe::4) by MW4PR04CA0332.outlook.office365.com
 (2603:10b6:303:8a::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.18 via Frontend
 Transport; Fri, 9 Dec 2022 16:37:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT085.mail.protection.outlook.com (10.13.174.137) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5901.17 via Frontend Transport; Fri, 9 Dec 2022 16:37:27 +0000
Received: from jasdeep-System-Product-Name.phub.net.cable.rogers.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Fri, 9 Dec 2022 10:37:24 -0600
From: jdhillon <jdhillon@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 09/23] drm/amd/display: save restore hdcp desired for disp
 unplug plug from mst hub
Date: Fri, 9 Dec 2022 11:36:33 -0500
Message-ID: <20221209163647.25704-10-jdhillon@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221209163647.25704-1-jdhillon@amd.com>
References: <20221209163647.25704-1-jdhillon@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT085:EE_|DM4PR12MB6012:EE_
X-MS-Office365-Filtering-Correlation-Id: f112359d-602d-4355-230c-08dada03a8fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HOJz/y+GJ6rSzZR4UGrk5sj34Supb8lF9BkqEM4gQDpFqU1de9gwbRqrcxBK4j/HUbplp9ZU/YeOC1AMy9/tL5wDdLeRVxhIQ1VBPYR4xcFiL3EjqlapYEULQFzkhBNcU1a/RCGYNiruLzVWZi7SK59YvUT4R/Yhpru9+KrGr6yz6CaP0G0qVwQRYW8spW7mq6/g21fxomxN6/AeCgslNMY80ks3/MAxF9PWlAwEfZRe568zpxlcLPp5xNyDvQmaD+j9VMeQfetkizEvRjAe/HeLxNQNXQ7KXpIDRmmrsQwqD2DEx0+PUJIrEXN0PmB9hpTBgYHuLNBwDKTg0D6CJ7/gzcP1n15D31lLRd9VMysU04V4VSniSFI9mB9E6839Bojk/XWF3+4cFhxBaAILoUG/y94nMdw3FugAJjz3KTsJ9XRfmtSkbqwHRASiQOAx+dFw0SP//3CUEZnszH9KGvJlMCPxVyQZVdyzqFXgpjPi0WYJuK0ul9Lfql5jtpEDdYYocbqQ1T9gDv2ZmmrS2kbGj3ZIkRr9tpzC0aJE6+Y9nh55dnbTj7I3Peq+YPxwZQRNtC9704DvvOFrBebPzdI0scZZTL475lwpPVKjxFHEsO9mGfZcFRbresiHhLzTPv+kWoKKXKxOp+TO/SKLHQwRwsB3/7lHHeJHsrOShv5XU/l+XBabba+nwwUx81tvyi+y3lScriOLFFW79iQYnIVwaObhT0eu9nqWn0N9G6U=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(396003)(39860400002)(346002)(376002)(451199015)(36840700001)(40470700004)(46966006)(36860700001)(426003)(47076005)(70586007)(8676002)(8936002)(4326008)(70206006)(82310400005)(36756003)(41300700001)(83380400001)(478600001)(186003)(26005)(40480700001)(81166007)(356005)(6666004)(82740400003)(1076003)(336012)(40460700003)(2616005)(16526019)(316002)(54906003)(6916009)(2906002)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2022 16:37:27.9481 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f112359d-602d-4355-230c-08dada03a8fc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT085.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6012
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Jasdeep Dhillon <jdhillon@amd.com>,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, hersen wu <hersenxs.wu@amd.com>, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: hersen wu <hersenxs.wu@amd.com>

[Why]
connector hdcp properties are lost after display is
unplgged from mst hub. connector is destroyed with
dm_dp_mst_connector_destroy. when display is plugged
back, hdcp is not desired, hdcp could not be enabled
by linux kernel automatically.

[How]
save hdcp properties into hdcp_work within
amdgpu_dm_atomic_commit_tail. if the same display is
plugged back with same display index, its hdcp
properties will be retrieved from hdcp_work within
dm_dp_mst_get_modes

Reviewed-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
Acked-by: Jasdeep Dhillon <jdhillon@amd.com>
Signed-off-by: hersen wu <hersenxs.wu@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 104 +++++++++++++++++-
 .../amd/display/amdgpu_dm/amdgpu_dm_hdcp.h    |  13 +++
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   |  25 +++++
 3 files changed, 138 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index bbacd764bf0f..7affe0899418 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -8292,15 +8292,65 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
 		}
 	}
 #ifdef CONFIG_DRM_AMD_DC_HDCP
+	for_each_oldnew_connector_in_state(state, connector, old_con_state, new_con_state, i) {
+		struct dm_connector_state *dm_new_con_state = to_dm_connector_state(new_con_state);
+		struct amdgpu_crtc *acrtc = to_amdgpu_crtc(dm_new_con_state->base.crtc);
+		struct amdgpu_dm_connector *aconnector = to_amdgpu_dm_connector(connector);
+
+		pr_debug("[HDCP_DM] -------------- i : %x ----------\n", i);
+
+		if (!connector)
+			continue;
+
+		pr_debug("[HDCP_DM] connector->index: %x connect_status: %x dpms: %x\n",
+			connector->index, connector->status, connector->dpms);
+		pr_debug("[HDCP_DM] state protection old: %x new: %x\n",
+			old_con_state->content_protection, new_con_state->content_protection);
+
+		if (aconnector->dc_sink) {
+			if (aconnector->dc_sink->sink_signal != SIGNAL_TYPE_VIRTUAL &&
+				aconnector->dc_sink->sink_signal != SIGNAL_TYPE_NONE) {
+				pr_debug("[HDCP_DM] pipe_ctx dispname=%s\n",
+				aconnector->dc_sink->edid_caps.display_name);
+			}
+		}
+
+		new_crtc_state = NULL;
+		old_crtc_state = NULL;
+
+		if (acrtc) {
+			new_crtc_state = drm_atomic_get_new_crtc_state(state, &acrtc->base);
+			old_crtc_state = drm_atomic_get_old_crtc_state(state, &acrtc->base);
+		}
+		if (old_crtc_state)
+			pr_debug("old crtc en: %x a: %x m: %x a-chg: %x c-chg: %x\n",
+			old_crtc_state->enable,
+			old_crtc_state->active,
+			old_crtc_state->mode_changed,
+			old_crtc_state->active_changed,
+			old_crtc_state->connectors_changed);
+
+		if (new_crtc_state)
+			pr_debug("NEW crtc en: %x a: %x m: %x a-chg: %x c-chg: %x\n",
+			new_crtc_state->enable,
+			new_crtc_state->active,
+			new_crtc_state->mode_changed,
+			new_crtc_state->active_changed,
+			new_crtc_state->connectors_changed);
+	}
+
 	for_each_oldnew_connector_in_state(state, connector, old_con_state, new_con_state, i) {
 		struct dm_connector_state *dm_new_con_state = to_dm_connector_state(new_con_state);
 		struct amdgpu_crtc *acrtc = to_amdgpu_crtc(dm_new_con_state->base.crtc);
 		struct amdgpu_dm_connector *aconnector = to_amdgpu_dm_connector(connector);
 
 		new_crtc_state = NULL;
+		old_crtc_state = NULL;
 
-		if (acrtc)
+		if (acrtc) {
 			new_crtc_state = drm_atomic_get_new_crtc_state(state, &acrtc->base);
+			old_crtc_state = drm_atomic_get_old_crtc_state(state, &acrtc->base);
+		}
 
 		dm_new_crtc_state = to_dm_crtc_state(new_crtc_state);
 
@@ -8312,11 +8362,57 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
 			continue;
 		}
 
-		if (is_content_protection_different(new_con_state, old_con_state, connector, adev->dm.hdcp_workqueue))
+		if (is_content_protection_different(
+			new_crtc_state,
+			old_crtc_state,
+			new_con_state,
+			old_con_state,
+			connector,
+			adev->dm.hdcp_workqueue)) {
+			/* when display is unplugged from mst hub, connctor will
+			 * be destroyed within dm_dp_mst_connector_destroy. connector
+			 * hdcp perperties, like type, undesired, desired, enabled,
+			 * will be lost. So, save hdcp properties into hdcp_work within
+			 * amdgpu_dm_atomic_commit_tail. if the same display is
+			 * plugged back with same display index, its hdcp properties
+			 * will be retrieved from hdcp_work within dm_dp_mst_get_modes
+			 */
+
+			bool enable_encryption = false;
+
+			if (new_con_state->content_protection ==
+				DRM_MODE_CONTENT_PROTECTION_DESIRED)
+				enable_encryption = true;
+
+
+			if (aconnector->dc_link && aconnector->dc_sink &&
+				aconnector->dc_link->type == dc_connection_mst_branch) {
+				struct hdcp_workqueue *hdcp_work = adev->dm.hdcp_workqueue;
+				struct hdcp_workqueue *hdcp_w =
+					&hdcp_work[aconnector->dc_link->link_index];
+
+				hdcp_w->hdcp_content_type[connector->index] =
+					new_con_state->hdcp_content_type;
+				hdcp_w->content_protection[connector->index] =
+					new_con_state->content_protection;
+			}
+
+			if (new_crtc_state && new_crtc_state->mode_changed &&
+				new_con_state->content_protection >=
+					DRM_MODE_CONTENT_PROTECTION_DESIRED) {
+				enable_encryption = true;
+			}
+
+			DRM_INFO("[HDCP_DM] hdcp_update_display enable_encryption = %x\n",
+				enable_encryption);
+
 			hdcp_update_display(
-				adev->dm.hdcp_workqueue, aconnector->dc_link->link_index, aconnector,
+				adev->dm.hdcp_workqueue, 
+				aconnector->dc_link->link_index, 
+				aconnector,
 				new_con_state->hdcp_content_type,
-				new_con_state->content_protection == DRM_MODE_CONTENT_PROTECTION_DESIRED);
+				enable_encryption);
+		}
 	}
 #endif
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.h
index 6e2537e579fa..69b445b011c8 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.h
@@ -52,6 +52,19 @@ struct hdcp_workqueue {
 	struct mod_hdcp_link link;
 
 	enum mod_hdcp_encryption_status encryption_status[AMDGPU_DM_MAX_DISPLAY_INDEX];
+	/* when display is unplugged from mst hub, connctor will be
+	 * destroyed within dm_dp_mst_connector_destroy. connector
+	 * hdcp perperties, like type, undesired, desired, enabled,
+	 * will be lost. So, save hdcp properties into hdcp_work within
+	 * amdgpu_dm_atomic_commit_tail. if the same display is
+	 * plugged back with same display index, its hdcp properties
+	 * will be retrieved from hdcp_work within dm_dp_mst_get_modes
+	 */
+	/* un-desired, desired, enabled */
+	unsigned int content_protection[AMDGPU_DM_MAX_DISPLAY_INDEX];
+	/* hdcp1.x, hdcp2.x */
+	unsigned int hdcp_content_type[AMDGPU_DM_MAX_DISPLAY_INDEX];
+
 	uint8_t max_link;
 
 	uint8_t *srm;
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index eef71940e43d..3270c61d3afe 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -31,6 +31,9 @@
 #include "amdgpu.h"
 #include "amdgpu_dm.h"
 #include "amdgpu_dm_mst_types.h"
+#ifdef CONFIG_DRM_AMD_DC_HDCP
+#include "amdgpu_dm_hdcp.h"
+#endif
 
 #include "dc.h"
 #include "dm_helpers.h"
@@ -344,6 +347,28 @@ static int dm_dp_mst_get_modes(struct drm_connector *connector)
 		/* dc_link_add_remote_sink returns a new reference */
 		aconnector->dc_sink = dc_sink;
 
+		/* when display is unplugged from mst hub, connctor will be
+		 * destroyed within dm_dp_mst_connector_destroy. connector
+		 * hdcp perperties, like type, undesired, desired, enabled,
+		 * will be lost. So, save hdcp properties into hdcp_work within
+		 * amdgpu_dm_atomic_commit_tail. if the same display is
+		 * plugged back with same display index, its hdcp properties
+		 * will be retrieved from hdcp_work within dm_dp_mst_get_modes
+		 */
+#ifdef CONFIG_DRM_AMD_DC_HDCP
+		if (aconnector->dc_sink && connector->state) {
+			struct drm_device *dev = connector->dev;
+			struct amdgpu_device *adev = drm_to_adev(dev);
+			struct hdcp_workqueue *hdcp_work = adev->dm.hdcp_workqueue;
+			struct hdcp_workqueue *hdcp_w = &hdcp_work[aconnector->dc_link->link_index];
+
+			connector->state->hdcp_content_type =
+			hdcp_w->hdcp_content_type[connector->index];
+			connector->state->content_protection =
+			hdcp_w->content_protection[connector->index];
+		}
+#endif
+
 		if (aconnector->dc_sink) {
 			amdgpu_dm_update_freesync_caps(
 					connector, aconnector->edid);
-- 
2.34.1

