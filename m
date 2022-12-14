Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E45A5C4332F
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Dec 2022 20:21:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 40BD210E471;
	Wed, 14 Dec 2022 20:21:55 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 24D0C10E050
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Dec 2022 20:21:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BmPtmosN17+0HKpxERuPDoyUaVsEuIZOToDnw1RracrMMhRvipoAqZzMAl1yx7/ecC3wJaBJghFBMRln+rhb0/I5sxJmFo1laGXh2yaLtE3aonzjR1HaVuJH0YGBE0UD80B9HBv+N6PjiBfB7dxP7ugDTYr2j+qRkYkhnW7fMOR2ZEf/mbDWqYHXXn6B34mXbin5nQ35saSl6Ie6nwtjWRSVhvBqYoKNncl6d+VKIaMJs4euMQiJuBeFycoKT9EHjuhAbzbbJUaCGzrpJhZummHMiTFEIGqxtKh51BlaOnwiK9w2s+4fPg90883BAbGQYzhpPP+jYvV41bBBni4pfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=niYZKL67e3AnetP94qZ4unNCBM+700kDWxVF4a7qCF4=;
 b=H8u/nlqr8Y3z3fOFUb3JS5JTlhWC9QcjCE9Nauydw64cxQtdHtMdQcGEGBIoLdiZN6me8hSzgcGQc4wK7NUJThaetQNftDfeFg7QaS1+QibrANb6jI5qn/ZQjVqQDW8PVFDGbKj5H999hR1aCvb5G94ganJ2zN67kK9NW1tSE5yaYMHg47nC+exIyPkIS1IE41GipELi6vDB04zO5Tfhb8piEOomviatsMAf3lPsB131JgXzo0SDlT/0cAuQ2c9XGvN/qp1ims4DEIsejaFNyt3NwEqDeu/1srU5wdG0Hwz71Sj038JLp+tm14gnADH3rQiheR9QVlH5esEiWCnZgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=niYZKL67e3AnetP94qZ4unNCBM+700kDWxVF4a7qCF4=;
 b=ZnrJcZubfz0oULrkjpn1hs0a2VeaSowGn/3u84q5oI7pm0J4SF9GdpSwazHKv8z3ZjhcuE16TeN88euSa9LEzLKb8Hvoz3x4a76Y+/q1SKL2o5JVBFHTPnCAtR5sW9yupHNDLJND/vEQ57BB1k0rcpJB2yI9aOKdoKBOFluzVm8=
Received: from MWH0EPF00056D02.namprd21.prod.outlook.com
 (2603:10b6:30f:fff2:0:1:0:f) by DM4PR12MB6159.namprd12.prod.outlook.com
 (2603:10b6:8:a8::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Wed, 14 Dec
 2022 20:21:48 +0000
Received: from CO1NAM11FT106.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eab::201) by MWH0EPF00056D02.outlook.office365.com
 (2603:1036:d20::b) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.4 via Frontend
 Transport; Wed, 14 Dec 2022 20:21:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT106.mail.protection.outlook.com (10.13.175.44) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5924.11 via Frontend Transport; Wed, 14 Dec 2022 20:21:47 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 14 Dec
 2022 14:21:44 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 14 Dec
 2022 14:21:44 -0600
Received: from aaurabin-elitedesk-arch.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34
 via Frontend Transport; Wed, 14 Dec 2022 14:21:43 -0600
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 01/18] drm/amd/display: save restore hdcp state when display
 is unplugged from mst hub
Date: Wed, 14 Dec 2022 15:21:24 -0500
Message-ID: <20221214202141.1721178-2-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20221214202141.1721178-1-aurabindo.pillai@amd.com>
References: <20221214202141.1721178-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT106:EE_|DM4PR12MB6159:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e79d6aa-bfc1-4846-4e62-08dade10d371
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j8FjUCVOEDdlVxrmV6gdxxs4NWLeg6yvsbBV1v1ijfJKO1qCfoeeF/C5ZSqjsiCvKyrDh9wW+TN7yTQ9r6X486HNI+WZozyPMaWqa87er0K37dTdLRRvvDpybAAihjozqYOLrHpMK/r/XGiGmVL3/HYB28v/94XUQgrNBn8kzLE6jMXCKLeUmW/zlKCUY5p2dzJOck7zSpx+7M6zxpBlBElDJqUeItuvee+zhNxWaISbdYur0ESTIPvuAfHcSNw8BIPETprRFNZl4naHC0JUaguUVgNwl0G6ZFLLVnxkedx3bwydpe/jwYuNhSHg/8lb3Sk1R7xabXp/rOJz86zxDMO9DDIa86Gpo4zxDjW64nTXJDNBUEAA4GDXPC20/7ZTA20/fiEgEItM/gwJn20a+eghAJrdMISBcW0E7MSzJBb00qahRYuGs/50uw1WUoKNNwsqhERjIvHxhjAFkku3VGm9b4IN9wgKw2UlCVJympapma6O1Yt0YfOSSiEH5x3vRVtUbZ066yQgwRygBiSfZtiHFf7zFjGnTnrIFIYIQhP5D1jwlI+mvk056rS7KQ7RKtJo7bFWoZ2LjtHOvvGr6I7Pz0Df8CxUJ72XYCAqRukAYAN1X7oossT1Q4HcdwcEkkpGTKgqBab3jLlaK/XCQX/HC7RqST2CH9MpDPucT9YLs7PIsO37xfiGmt4LyoK5KKtKIaLHnhKOzbQD0LktBCqPKyAFGpwYCGr7b3EYfHk=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:CA; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(346002)(396003)(376002)(136003)(451199015)(36840700001)(46966006)(40470700004)(336012)(86362001)(478600001)(83380400001)(7696005)(316002)(44832011)(36756003)(6916009)(82310400005)(54906003)(36860700001)(186003)(5660300002)(41300700001)(4326008)(8676002)(426003)(2616005)(47076005)(70586007)(70206006)(81166007)(6666004)(356005)(2906002)(8936002)(40460700003)(26005)(40480700001)(1076003)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2022 20:21:47.2889 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e79d6aa-bfc1-4846-4e62-08dade10d371
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT106.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6159
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
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 hersen wu <hersenxs.wu@amd.com>, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: hersen wu <hersenxs.wu@amd.com>

[Why]
connector hdcp properties are lost after display is
unplgged from mst hub. connector is destroyed with
dm_dp_mst_connector_destroy. when display is plugged
back, hdcp is not desired and it wouldnt be enabled.

[How]
save hdcp properties into hdcp_work within
amdgpu_dm_atomic_commit_tail. If the same display is
plugged back with same display index, its hdcp
properties will be retrieved from hdcp_work within
dm_dp_mst_get_modes.

Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: hersen wu <hersenxs.wu@amd.com>
Reviewed-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 24 ++++++++++++++++-
 .../amd/display/amdgpu_dm/amdgpu_dm_hdcp.h    | 14 ++++++++++
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   | 26 +++++++++++++++++++
 3 files changed, 63 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index a60b3729752a..acd78fde6121 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -8317,11 +8317,33 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
 			continue;
 		}
 
-		if (is_content_protection_different(new_con_state, old_con_state, connector, adev->dm.hdcp_workqueue))
+		if (is_content_protection_different(new_con_state, old_con_state, connector, adev->dm.hdcp_workqueue)) {
+			/* when display is unplugged from mst hub, connctor will
+			 * be destroyed within dm_dp_mst_connector_destroy. connector
+			 * hdcp perperties, like type, undesired, desired, enabled,
+			 * will be lost. So, save hdcp properties into hdcp_work within
+			 * amdgpu_dm_atomic_commit_tail. if the same display is
+			 * plugged back with same display index, its hdcp properties
+			 * will be retrieved from hdcp_work within dm_dp_mst_get_modes
+			 */
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
 			hdcp_update_display(
 				adev->dm.hdcp_workqueue, aconnector->dc_link->link_index, aconnector,
 				new_con_state->hdcp_content_type,
 				new_con_state->content_protection == DRM_MODE_CONTENT_PROTECTION_DESIRED);
+    }
 	}
 #endif
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.h
index 09294ff122fe..bbbf7d0eff82 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.h
@@ -52,6 +52,20 @@ struct hdcp_workqueue {
 	struct mod_hdcp_link link;
 
 	enum mod_hdcp_encryption_status encryption_status;
+
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
index eef71940e43d..ad02435a3bfd 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -32,6 +32,10 @@
 #include "amdgpu_dm.h"
 #include "amdgpu_dm_mst_types.h"
 
+#ifdef CONFIG_DRM_AMD_DC_HDCP
+#include "amdgpu_dm_hdcp.h"
+#endif
+
 #include "dc.h"
 #include "dm_helpers.h"
 
@@ -344,6 +348,28 @@ static int dm_dp_mst_get_modes(struct drm_connector *connector)
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
2.39.0

