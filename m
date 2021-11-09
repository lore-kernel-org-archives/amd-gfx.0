Return-Path: <SRS0=P/1w=P4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2243C433F5
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Nov 2021 05:15:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9772461151
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Nov 2021 05:15:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9772461151
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B8FDB6E33F;
	Tue,  9 Nov 2021 05:15:15 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2049.outbound.protection.outlook.com [40.107.223.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 83C026E33F
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Nov 2021 05:15:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ve93qhGVXNWQ/W9bfbMMqj0/M/uePwl3GmISQIwuOnMtq4NMrWbH2toMa3FtiMHlAiVXcXiX/prWHPC+q1sIxF6rby60eAPLvjehRXgQpY4rRVuW9lMVeX7T+O1RsvVgkQd8LReAUqiqQYjYgEMXZE9LTS+mZxBKoatrMEEH0HJIXik/aqnw6sV2tOEdjf2jgIlh8Tdfh7yQ7GibriEHlKv9S4VlVV7O+A6lCEs6Sp8YWYFoLbNhY4evdoch4DuRenSnZD52Zzxl0Wf83oQaIL+WBqVXOK6WF4iDPlySlYUzLw37+8CTly3D80lmOKyCQ8xMztI73cJm76UlmGpQ3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bRgLdm1R6D/0OkObKPDfFo89UJ6CQFlC2i1Ir+bZjKM=;
 b=SJO99qMZgdfKUnAAykHSJJNnHjUfpLeDei+8RdBwOiveKIcoBf4u/oW57ZCikbXPP/quQGGQJF5Tt8xwhHOOp0Mlz8q0JKFPlBZj6IXSnXg5sBa+tchUSTyiVIxeqizVYgfa8Zb8u3s1T7Vz0jF9z6lIC/Ikcp8JMfWpcpCUUir4IY/OFZe28F8ctTgChjz3eESit220EqpEFBk7Umq4MsoG7DdpKJN4G7TZK4y6BkpASy/dKNzNgN4m2zLXvsM6Vvu++pECL0wGaCCiJ6Sp3ZxWxo4PyPlLaHcfUuD2dodIS3p01r/b3+fUL5NfnHRCSFEb9kKnd2DdAYz0b8TvBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bRgLdm1R6D/0OkObKPDfFo89UJ6CQFlC2i1Ir+bZjKM=;
 b=rRz67nBuIrYMzP60+foRs5/IK+t6CFtDWZ4sS2CL6YGixENiM/deSJBuA9B55yy5Hzx2ESNGUA36sWVIlsSu9QmGWLsvmSiRaLdi/zlvKllTQoJu2ji5f+aygomu0qFlmF8g4mGJDZuYEgaDJOzVQ7pHXAhuCLTfcAAZcF/G4mE=
Received: from BN9PR03CA0504.namprd03.prod.outlook.com (2603:10b6:408:130::29)
 by BL0PR12MB2561.namprd12.prod.outlook.com (2603:10b6:207:3e::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11; Tue, 9 Nov
 2021 05:15:11 +0000
Received: from BN8NAM11FT057.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:130:cafe::ad) by BN9PR03CA0504.outlook.office365.com
 (2603:10b6:408:130::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.13 via Frontend
 Transport; Tue, 9 Nov 2021 05:15:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT057.mail.protection.outlook.com (10.13.177.49) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4669.10 via Frontend Transport; Tue, 9 Nov 2021 05:15:11 +0000
Received: from amd-WhiteHaven.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Mon, 8 Nov 2021
 23:15:09 -0600
From: Shirish S <shirish.s@amd.com>
To: Harry Wentland <harry.wentland@amd.com>, Nicholas Kazlauskas
 <nicholas.kazlauskas@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amd/display: log amdgpu_dm_atomic_check() failure cause
Date: Tue, 9 Nov 2021 10:44:54 +0530
Message-ID: <20211109051454.46574-1-shirish.s@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 903fbd07-0ee3-48f1-13a4-08d9a33fe7b3
X-MS-TrafficTypeDiagnostic: BL0PR12MB2561:
X-Microsoft-Antispam-PRVS: <BL0PR12MB2561580A2F6A2BBC6436FC6CF2929@BL0PR12MB2561.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:345;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PdYFHT8mTH+d3sF9W7J1kl1Zmi/udIs21AjXqaatVAog/8a7M99NmvBH2YmMF8JM5bi8Kjob1/8zis7iDH84j4iKk+AnFLsT/d8n4vDgQ704ppQ1mUQncB/Zb6qb5QZMeea2Y8QUuIBYrYMZOEaDo64j+eC4rdiXhq1uDg50UbwwOs5MagJNmyvzhQkrasbiLnJsoZhwkX5gZgY8zhJC9/nG9KOMauwbnxYAXzq0l0E7Gu6uwKRn1+WWyE+3tSERz1YlM3/EqARddsD98rVJoC0tQ8iHAjuiDISA3iHOYSuFfUYGg8swU60PwbQ4YzOBqr44JGDgQ45xD0czQ5+BGkL9P4D8Qoy+uDlL/o+AOwdTVw1skp3ia7X604DpLVTnp3erAh0GK+jfbiRqIET7JlYy/Td2dO970qIZ8iz0Mus2SQRa1K2sev6tAg1yqn4oNM2+x3q2vpLiKDU4jHk8n72giUyd1XnJq4MJYIOz9vFaz6PmYDRkB8PXB85Sz3lFlDeMMcOqCttNqEjpC//tozMX9OWg5VI1+fXHcdTfI2+pOvSqASh77PASiIvPh5Jo/NswNCAq1rWwwniakqiYMR6sHD8WwEFU4n/eWzaUHcN0JytdIuQ16gF8c17fHe/bvyW2xJ6dX8wFmrmJwh0BSohqC2w06CVRtb984KPcUp2SRy3PSU4oMKbaA/YPy2NlDJOTqGJ+WYmKxZ529IzjbRhNjjSQesy+oqnmjzFLAdI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(16526019)(186003)(6636002)(70586007)(26005)(36860700001)(81166007)(316002)(2906002)(4326008)(7696005)(110136005)(336012)(86362001)(2616005)(426003)(83380400001)(82310400003)(356005)(508600001)(70206006)(8676002)(8936002)(1076003)(47076005)(6666004)(5660300002)(54906003)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2021 05:15:11.4746 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 903fbd07-0ee3-48f1-13a4-08d9a33fe7b3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT057.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2561
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
Cc: amd-gfx@lists.freedesktop.org, Shirish S <shirish.s@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

update developers with next level of info about unsupported
display configuration query that led to atomic check failure.

Signed-off-by: Shirish S <shirish.s@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 69 ++++++++++++++-----
 1 file changed, 51 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index b1d9e89e5ae9..b7044c04a7c5 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -10755,8 +10755,10 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
 	trace_amdgpu_dm_atomic_check_begin(state);
 
 	ret = drm_atomic_helper_check_modeset(dev, state);
-	if (ret)
+	if (ret) {
+		DRM_DEBUG_DRIVER("drm_atomic_helper_check_modeset() failed\n");
 		goto fail;
+	}
 
 	/* Check connector changes */
 	for_each_oldnew_connector_in_state(state, connector, old_con_state, new_con_state, i) {
@@ -10772,6 +10774,7 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
 
 		new_crtc_state = drm_atomic_get_crtc_state(state, new_con_state->crtc);
 		if (IS_ERR(new_crtc_state)) {
+			DRM_DEBUG_DRIVER("drm_atomic_get_crtc_state() failed\n");
 			ret = PTR_ERR(new_crtc_state);
 			goto fail;
 		}
@@ -10786,8 +10789,10 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
 		for_each_oldnew_crtc_in_state(state, crtc, old_crtc_state, new_crtc_state, i) {
 			if (drm_atomic_crtc_needs_modeset(new_crtc_state)) {
 				ret = add_affected_mst_dsc_crtcs(state, crtc);
-				if (ret)
+				if (ret) {
+					DRM_DEBUG_DRIVER("add_affected_mst_dsc_crtcs() failed\n");
 					goto fail;
+				}
 			}
 		}
 	}
@@ -10802,19 +10807,25 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
 			continue;
 
 		ret = amdgpu_dm_verify_lut_sizes(new_crtc_state);
-		if (ret)
+		if (ret) {
+			DRM_DEBUG_DRIVER("amdgpu_dm_verify_lut_sizes() failed\n");
 			goto fail;
+		}
 
 		if (!new_crtc_state->enable)
 			continue;
 
 		ret = drm_atomic_add_affected_connectors(state, crtc);
-		if (ret)
+		if (ret) {
+			DRM_DEBUG_DRIVER("drm_atomic_add_affected_connectors() failed\n");
 			goto fail;
+		}
 
 		ret = drm_atomic_add_affected_planes(state, crtc);
-		if (ret)
+		if (ret) {
+			DRM_DEBUG_DRIVER("drm_atomic_add_affected_planes() failed\n");
 			goto fail;
+		}
 
 		if (dm_old_crtc_state->dsc_force_changed)
 			new_crtc_state->mode_changed = true;
@@ -10851,6 +10862,7 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
 
 			if (IS_ERR(new_plane_state)) {
 				ret = PTR_ERR(new_plane_state);
+				DRM_DEBUG_DRIVER("new_plane_state is BAD\n");
 				goto fail;
 			}
 		}
@@ -10863,8 +10875,10 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
 					    new_plane_state,
 					    false,
 					    &lock_and_validation_needed);
-		if (ret)
+		if (ret) {
+			DRM_DEBUG_DRIVER("dm_update_plane_state() failed\n");
 			goto fail;
+		}
 	}
 
 	/* Disable all crtcs which require disable */
@@ -10874,8 +10888,10 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
 					   new_crtc_state,
 					   false,
 					   &lock_and_validation_needed);
-		if (ret)
+		if (ret) {
+			DRM_DEBUG_DRIVER("DISABLE: dm_update_crtc_state() failed\n");
 			goto fail;
+		}
 	}
 
 	/* Enable all crtcs which require enable */
@@ -10885,8 +10901,10 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
 					   new_crtc_state,
 					   true,
 					   &lock_and_validation_needed);
-		if (ret)
+		if (ret) {
+			DRM_DEBUG_DRIVER("ENABLE: dm_update_crtc_state() failed\n");
 			goto fail;
+		}
 	}
 
 	/* Add new/modified planes */
@@ -10896,20 +10914,26 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
 					    new_plane_state,
 					    true,
 					    &lock_and_validation_needed);
-		if (ret)
+		if (ret) {
+			DRM_DEBUG_DRIVER("dm_update_plane_state() failed\n");
 			goto fail;
+		}
 	}
 
 	/* Run this here since we want to validate the streams we created */
 	ret = drm_atomic_helper_check_planes(dev, state);
-	if (ret)
+	if (ret) {
+		DRM_DEBUG_DRIVER("drm_atomic_helper_check_planes() failed\n");
 		goto fail;
+	}
 
 	/* Check cursor planes scaling */
 	for_each_new_crtc_in_state(state, crtc, new_crtc_state, i) {
 		ret = dm_check_crtc_cursor(state, crtc, new_crtc_state);
-		if (ret)
+		if (ret) {
+			DRM_DEBUG_DRIVER("dm_check_crtc_cursor() failed\n");
 			goto fail;
+		}
 	}
 
 	if (state->legacy_cursor_update) {
@@ -10996,20 +11020,28 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
 	 */
 	if (lock_and_validation_needed) {
 		ret = dm_atomic_get_state(state, &dm_state);
-		if (ret)
+		if (ret) {
+			DRM_DEBUG_DRIVER("dm_atomic_get_state() failed\n");
 			goto fail;
+		}
 
 		ret = do_aquire_global_lock(dev, state);
-		if (ret)
+		if (ret) {
+			DRM_DEBUG_DRIVER("do_aquire_global_lock() failed\n");
 			goto fail;
+		}
 
 #if defined(CONFIG_DRM_AMD_DC_DCN)
-		if (!compute_mst_dsc_configs_for_state(state, dm_state->context, vars))
+		if (!compute_mst_dsc_configs_for_state(state, dm_state->context, vars)) {
+			DRM_DEBUG_DRIVER("compute_mst_dsc_configs_for_state() failed\n");
 			goto fail;
+		}
 
 		ret = dm_update_mst_vcpi_slots_for_dsc(state, dm_state->context, vars);
-		if (ret)
+		if (ret) {
+			DRM_DEBUG_DRIVER("dm_update_mst_vcpi_slots_for_dsc() failed\n");
 			goto fail;
+		}
 #endif
 
 		/*
@@ -11019,12 +11051,13 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
 		 * to get stuck in an infinite loop and hang eventually.
 		 */
 		ret = drm_dp_mst_atomic_check(state);
-		if (ret)
+		if (ret) {
+			DRM_DEBUG_DRIVER("drm_dp_mst_atomic_check() failed\n");
 			goto fail;
+		}
 		status = dc_validate_global_state(dc, dm_state->context, false);
 		if (status != DC_OK) {
-			drm_dbg_atomic(dev,
-				       "DC global validation failure: %s (%d)",
+			DRM_DEBUG_DRIVER("DC global validation failure: %s (%d)",
 				       dc_status_to_str(status), status);
 			ret = -EINVAL;
 			goto fail;
-- 
2.17.1

