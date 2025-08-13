Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C060C87FCF
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Aug 2025 23:28:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C84A10E7E6;
	Wed, 13 Aug 2025 23:28:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UgkIilhd";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2066.outbound.protection.outlook.com [40.107.220.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3391010E7E6
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Aug 2025 23:28:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FQju/gUhOSeSBOGGLYT0ED9OfJps7E/oWB9ybTZyyxCVDmVThT9OvzhZ5BOkVktOeVx3ea1gaBaob5vrN1WsCBF3IZGbYnCJ8OQcJFtVloV+tIem6nu+YSG/rff79fxOUsCo+1wnefpFRR73IvlFdau63O5o7lVgJve9te7G0K3Rr2UCuZMIW33Og8VLnmkHZUN5ycglHH8zZn3kXBc7EH10s32PaUr+auUaK595HmaUnqco/5s0X6pnW3Q8qiyrJF4+h8h+kw16dG7MobLOobTEzMoAK71tliQ7mDhntYyHzK85DxPJJRkhBZLTSkoEUrSyZ9JYmVwUcj7AcZMNQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DPi0Kd1kcDOw7x35VBniADE3KhjVD11HT5IgaAjsBMA=;
 b=OGAMB0pfSwM1e6aNJ5ku7gidb2nVVPPlFJE4vTMcUv71O6kMwmlSBKWTprjkQfvIcvXKJjEOXfUteA0Y7LpwYIUkeSSPhQTxvPwNIWenAeqqqhFQrb7T8CSgqsQGA+ofySsFJBILiYe0x8yTT5gs9TNieKq4ffL0sh8+AKn63+YQVeH5+L4QlsBTYhddjgxr6cORMtkc6paQlbp01CpJxnUrG6elHZl30bzxQMoYZMWg6MEPHx6Hrnfi2hTCB9PnacWdrLPni2z6MEbLE/CcV9VNIP2B+C34HsI4WlHj4WE4Mgoi7uCaa9SO7ZJ2VC9myVPDeSeaOP9RrxrQ+ajcLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DPi0Kd1kcDOw7x35VBniADE3KhjVD11HT5IgaAjsBMA=;
 b=UgkIilhdpQQer29eiDFxUM7/JZd1qdtI0HKaAVORfX1sNm8GVPzZ8Kr2f4CUVIyVS4LtlnbProh49uiKJaJGZuTVuHaaNV8TnudyY7yxjrCqQvU9AKZwz34UxMKdaOdg1NRNEqZGeVe1xBbjAaSLVvwMYf2myvUcEryc2knjGKQ=
Received: from DM6PR02CA0084.namprd02.prod.outlook.com (2603:10b6:5:1f4::25)
 by SJ2PR12MB9115.namprd12.prod.outlook.com (2603:10b6:a03:55c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.15; Wed, 13 Aug
 2025 23:28:09 +0000
Received: from DS1PEPF00017090.namprd03.prod.outlook.com
 (2603:10b6:5:1f4:cafe::ca) by DM6PR02CA0084.outlook.office365.com
 (2603:10b6:5:1f4::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.15 via Frontend Transport; Wed,
 13 Aug 2025 23:28:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017090.mail.protection.outlook.com (10.167.17.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Wed, 13 Aug 2025 23:28:09 +0000
Received: from SATLEXMB03.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 13 Aug
 2025 18:28:05 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 07/11] drm/amd/display: Attach privacy screen to DRM connector
Date: Wed, 13 Aug 2025 17:18:15 -0600
Message-ID: <20250813232532.2661638-8-alex.hung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250813232532.2661638-1-alex.hung@amd.com>
References: <20250813232532.2661638-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017090:EE_|SJ2PR12MB9115:EE_
X-MS-Office365-Filtering-Correlation-Id: da99a40a-63c7-4d6f-7f6e-08dddac11027
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?yD/O/qTAsLuMhft+sQQVeWOGkmQp1OSiDbTgqQlIoDibAdyLdLHW5QTN6o2W?=
 =?us-ascii?Q?q1FAukhxGCtv6McGui9BUHfzx7htNIYjRuPkAvP5XwI4rN6mudW2j7uPDJLz?=
 =?us-ascii?Q?TkRtyz0/80upYBZQPIDKlNuaXrn3Wz/cf57jcSC0TjDN3c/IfxvrmjSRyUmP?=
 =?us-ascii?Q?n8Hqqoq9dKRtyIW0AGZibgBpLN28ftAsUkCsSka8H+q1Uypdc0DtIvr7f8B4?=
 =?us-ascii?Q?f7OqmaIU9NXRDGCjakKPPCpcg94UoZ90EHjbD49ERGT8VuUer5xk/jGsGHuR?=
 =?us-ascii?Q?ZwxLe6KuQlp5RcNn9+1vJUI3PLpOJRdNFqm7vvEFBKxUPe+7iPx3H5F9MYW9?=
 =?us-ascii?Q?HgsFb80Zt6VnTGzFY5mT+EVE7LaTwhnaWvjaCfzPBN6MOKcFZmlozTvINrEu?=
 =?us-ascii?Q?uQ68iF1nQrbSvCmwVWZpXzYef7KdBhI1258PticCclA5QrY9i7ogNwplQoyK?=
 =?us-ascii?Q?aONobgJQhO2YW68Jt6wnvWLQezx4fau7GHfqxZkAQIxXhkfgpAMjfBui7xUJ?=
 =?us-ascii?Q?OJeEe2WcqV0A8S/7T20pb9kh5EgBDYSZih4dTOVsf4EeOAJulnXC+qFPumjV?=
 =?us-ascii?Q?uzfy9hx47lV/YxHSD7264ExyR7CkqJ6boDjMfRFSrhggaGKSybKbKiAh8cxQ?=
 =?us-ascii?Q?6bZaOHO2jqasOygt5YKhq5gIg4YcaVNp1USEdAWyqKVRImY3tZX5fUx5I+SP?=
 =?us-ascii?Q?yMV3ONzaru8bz8+Qh14f82Dvgt/D+fwd/Q5HWLrIp6C9gI2HcEC1xJTczOvd?=
 =?us-ascii?Q?9G7RpJys9jwost48Vleo93luUGREU7rQl4D5u8peUS8FZDN2wq2oysKF7UTz?=
 =?us-ascii?Q?Wr2c11Rnic5YCNVIH722f/QVhI0zcCl658j5p0DxjcadRoZdqXmRUYO/8Jfx?=
 =?us-ascii?Q?jLjqCv5bMtGIa2LZaiDWiLzPXgXP50HTUdmQg+MCg8/WmpYiHNt6zhN4J0lt?=
 =?us-ascii?Q?eCC5vu2i00SNwZjrJHIc8BvvkpA6ryXyDTbYtzx4rd+8cQ/yjYppnqQ+fytN?=
 =?us-ascii?Q?+nB1SEE7jjRfsh1ydpeWIUTIvGFWeW0kHvFczkp5qygRle1Nmr8fvyW/8GRb?=
 =?us-ascii?Q?4MzxJOui10EOhQdekeBDMOdRK+NpBp+yJBC2ZReCZfx+e6U5SHjifB7Drz0d?=
 =?us-ascii?Q?rv+qfzvkrK8Uw2q49Q/OD9btSJFqWHfwnGe580GxasxGRwFC69YN8B8amkXi?=
 =?us-ascii?Q?EFtCjjgpn7/xnOMH1RQd+TzoUVLv+Z/2nsihbvE7lBTg7RZuibKxr+s9njLt?=
 =?us-ascii?Q?SLzP1zBtBQzpGoRVu4NZWggca3U2To+szITtkQc1TeAfikSZUqRS/OqpijFA?=
 =?us-ascii?Q?1O2PfHnHbdxL656N9o6IhlVMyqyaXzfbcXbb/u8aecSQEYg4ePRSdL2ERcf6?=
 =?us-ascii?Q?uF38GjKOVg28B5CxUHbMFGaYpZkgKNv0yr9Y+fFu36us58m2w/c0qE+JXqFt?=
 =?us-ascii?Q?GF54su0K997SVNz8w2wuiB2vYtkkY+kMyJNQZmMksJFuk7+0SdnreorMcCCe?=
 =?us-ascii?Q?vrvsw6yiervxe76DVUMYxCGu9iFRLpoIMRyq?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 23:28:09.0237 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da99a40a-63c7-4d6f-7f6e-08dddac11027
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017090.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9115
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

From: Mario Limonciello <mario.limonciello@amd.com>

[WHY]
If a system has a privacy screen advertised by a driver it should
be included in the DRM connector for the eDP panel.

[HOW]
Detect statically declared privacy screens when creating eDP connector
and attach privacy screen DRM properties.

Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 25 ++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index e8cfae2bd2ae..176f420effd9 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -80,6 +80,7 @@
 #include <linux/component.h>
 #include <linux/sort.h>
 
+#include <drm/drm_privacy_screen_consumer.h>
 #include <drm/display/drm_dp_mst_helper.h>
 #include <drm/display/drm_hdmi_helper.h>
 #include <drm/drm_atomic.h>
@@ -7846,6 +7847,14 @@ amdgpu_dm_connector_atomic_check(struct drm_connector *conn,
 	if (!crtc)
 		return 0;
 
+	if (new_con_state->privacy_screen_sw_state != old_con_state->privacy_screen_sw_state) {
+		new_crtc_state = drm_atomic_get_crtc_state(state, crtc);
+		if (IS_ERR(new_crtc_state))
+			return PTR_ERR(new_crtc_state);
+
+		new_crtc_state->mode_changed = true;
+	}
+
 	if (new_con_state->colorspace != old_con_state->colorspace) {
 		new_crtc_state = drm_atomic_get_crtc_state(state, crtc);
 		if (IS_ERR(new_crtc_state))
@@ -8541,6 +8550,18 @@ void amdgpu_dm_connector_init_helper(struct amdgpu_display_manager *dm,
 		if (adev->dm.hdcp_workqueue)
 			drm_connector_attach_content_protection_property(&aconnector->base, true);
 	}
+
+	if (connector_type == DRM_MODE_CONNECTOR_eDP) {
+		struct drm_privacy_screen *privacy_screen;
+
+		privacy_screen = drm_privacy_screen_get(adev_to_drm(adev)->dev, NULL);
+		if (!IS_ERR(privacy_screen)) {
+			drm_connector_attach_privacy_screen_provider(&aconnector->base,
+								     privacy_screen);
+		} else if (PTR_ERR(privacy_screen) != -ENODEV) {
+			drm_warn(adev_to_drm(adev), "Error getting privacy-screen\n");
+		}
+	}
 }
 
 static int amdgpu_dm_i2c_xfer(struct i2c_adapter *i2c_adap,
@@ -10265,7 +10286,7 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
 	unsigned long flags;
 	bool wait_for_vblank = true;
 	struct drm_connector *connector;
-	struct drm_connector_state *old_con_state, *new_con_state;
+	struct drm_connector_state *old_con_state = NULL, *new_con_state = NULL;
 	struct dm_crtc_state *dm_old_crtc_state, *dm_new_crtc_state;
 	int crtc_disable_count = 0;
 
@@ -10383,6 +10404,8 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
 					    &stream_update);
 		mutex_unlock(&dm->dc_lock);
 		kfree(dummy_updates);
+
+		drm_connector_update_privacy_screen(new_con_state);
 	}
 
 	/**
-- 
2.43.0

