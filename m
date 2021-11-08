Return-Path: <SRS0=eROb=P3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1C6AC433F5
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Nov 2021 08:41:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9359B61163
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Nov 2021 08:41:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9359B61163
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 484126E595;
	Mon,  8 Nov 2021 08:41:20 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2060.outbound.protection.outlook.com [40.107.212.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E6096E595
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Nov 2021 08:41:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AV0WmcyB2nH17y+rmQyN0yjewKU4dYFIzdGi7Yz1BIsFTzVi3Pe208dMgxmrp+QIsjfQhWWq0K82BqC36lc1ObrTxcMPBh7ZeQwvz/qmzdNIb6tsufq6/y6fwianFbnqCUyQqjKmF6CtLNaZJoq7Qy0/D2XSdURGjzsMxtUsIFn1mZ6RyRTzP/0rUiD3OD1Qi8NokwORVrHFowp4H4avtoI7b/hff7UEmzCmqOH8A8yx7JgMkNqwxDbV8V636L6ZhR/kwSczhVKfkiCf5VedkxPJfSsfJstaR4tiin8ASQvxLuTG/PG/PfgrmjPcdTYB/9Nx4zxsugzo46Rmr1FIQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LMSO09ROl1heu7uqn2BLUiYqO/7QxWGqWpnYfX9dITQ=;
 b=GISKXSTXg2h01EyypseOsemkQbAYVnSEubJ/S7QrABaTStiNPJf5YIvhixWgxucetsS8jzebI9jvoSMYrRbYnRR46ouOk8M/phW6vF5fmrilOQF8oQMZzDBVbpCF/YSxW7vBMNxH67pqz9l+CQjLKL3WTQZKAz9c3nMfzARrzZa2oHPBPKKnEdTl/jToS743idZxbjenB1OzV160vJzvIT5plcRTl0a5IsLpFabbLksE8OfOzkhVaF05H+a0+CuA5f+Rzhh2yOnmPLaSlAf9DqVKSN9xGnBvbA0nP4k5E8RKC8sH2LwheGBuPyxw35likbseh15ivfmb2KOxhnBnDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LMSO09ROl1heu7uqn2BLUiYqO/7QxWGqWpnYfX9dITQ=;
 b=vCOXzRszJbpO+nCkAJ/ASkshyoQVYUlhMMQjYpulYYOAV5CKuTqHrcdS8nF8KYRhnCvwEh3zZeyalcqtKhZHQhmreUx10mXRDTfeA56Z0eqwJKX0Ms+B5h4/jTUF/fHJnQ3kgyr30v8re7es0hh89PZyU2qq5njQdjCm2lF9bGg=
Received: from DM6PR11CA0012.namprd11.prod.outlook.com (2603:10b6:5:190::25)
 by BYAPR12MB3608.namprd12.prod.outlook.com (2603:10b6:a03:de::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.10; Mon, 8 Nov
 2021 08:41:15 +0000
Received: from DM6NAM11FT067.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:190:cafe::7b) by DM6PR11CA0012.outlook.office365.com
 (2603:10b6:5:190::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.10 via Frontend
 Transport; Mon, 8 Nov 2021 08:41:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT067.mail.protection.outlook.com (10.13.172.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4669.10 via Frontend Transport; Mon, 8 Nov 2021 08:41:14 +0000
Received: from amd-WhiteHaven.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Mon, 8 Nov 2021
 02:41:09 -0600
From: Shirish S <shirish.s@amd.com>
To: Harry Wentland <harry.wentland@amd.com>, Nicholas Kazlauskas
 <nicholas.kazlauskas@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amd/display: log amdgpu_dm_atomic_check() failure cause
Date: Mon, 8 Nov 2021 14:10:54 +0530
Message-ID: <20211108084054.11162-1-shirish.s@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f7a062f1-2a6d-4d19-0792-08d9a293860a
X-MS-TrafficTypeDiagnostic: BYAPR12MB3608:
X-Microsoft-Antispam-PRVS: <BYAPR12MB3608500F6AFBDB8E5E517FD7F2919@BYAPR12MB3608.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:324;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /ThVA6wQLHaSsLtJ08EkbL2W82/ukH4wWoYg8QrciQbklX4LVZl5upvYVvGBIfwYislHgSx0RaIt4JUJyAxBatqWY1Dgx/pwPsVOBBxnFWxdKLjK+nWQru6GGAY3ozQMkfzk246FCrzN5lLwzbHRyL/k4Mggnf0bxYwf4U3nj3ola0nZHLd72VVKcsNIlDK7dFBxRqv5PsX+Nv98PeE9zD5q46jiE/MooOoUQYlrWLc4ASO2RII3tuBZtiV5EJinmRizDTYukSDPvvp3O9CM9VuHdCwgxK0kkwnIH721mCLF8N8++RVB7CHNJN+ix44CtObnN63SAyFxa5oOUdmdceR8nLEN1kevFBG4N2sTu0P3uPcSxbPWcpmcHbY1PRx8yyvAMCEuDlyIbOMsbM6/fon20BBPkqvkX9UDahFR7bPZ3WAKER57Tp8aC9Ovaw1ZM2mZA/hfCzYG/w0CiS9UrO+xTcnQIiwLILXOiXxuQ//jQsB3Qp5EBGPluoh+C5YnV8aEtVvS4s92WVLYuaxbXWcnZiT3H4tU5aKjEgZVuaY5QGrokizWhrj8/QAB3mhFhcVMTALbnyKX2eshB7vpfR8auX30XB/irVx7aH+oPNrKlot8sAl+tbS1I3hIoVC6VNlXmACJu7S43s85k78+IvYNWeB6AtOPFc61ph+9aDlFzcujKvjN29OEa7vOtvSGWS6bby/7+JA8XFUtWZ6cEdm8zWlr2ANggBNFEM23FUs=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(8936002)(16526019)(83380400001)(186003)(26005)(86362001)(508600001)(6666004)(7696005)(5660300002)(2906002)(6636002)(8676002)(82310400003)(54906003)(81166007)(47076005)(336012)(2616005)(356005)(70586007)(426003)(36756003)(110136005)(36860700001)(4326008)(316002)(1076003)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2021 08:41:14.1472 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f7a062f1-2a6d-4d19-0792-08d9a293860a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT067.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3608
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

update user with next level of info about which condition led to
atomic check failure.

Signed-off-by: Shirish S <shirish.s@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 70 ++++++++++++++-----
 1 file changed, 52 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 1e26d9be8993..37ea8a76fa09 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -10746,8 +10746,10 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
 	trace_amdgpu_dm_atomic_check_begin(state);
 
 	ret = drm_atomic_helper_check_modeset(dev, state);
-	if (ret)
+	if (ret) {
+		DRM_DEV_ERROR(adev->dev, "drm_atomic_helper_check_modeset() failed\n");
 		goto fail;
+	}
 
 	/* Check connector changes */
 	for_each_oldnew_connector_in_state(state, connector, old_con_state, new_con_state, i) {
@@ -10763,6 +10765,7 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
 
 		new_crtc_state = drm_atomic_get_crtc_state(state, new_con_state->crtc);
 		if (IS_ERR(new_crtc_state)) {
+			DRM_DEV_ERROR(adev->dev, "drm_atomic_get_crtc_state() failed\n");
 			ret = PTR_ERR(new_crtc_state);
 			goto fail;
 		}
@@ -10777,8 +10780,10 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
 		for_each_oldnew_crtc_in_state(state, crtc, old_crtc_state, new_crtc_state, i) {
 			if (drm_atomic_crtc_needs_modeset(new_crtc_state)) {
 				ret = add_affected_mst_dsc_crtcs(state, crtc);
-				if (ret)
+				if (ret) {
+					DRM_DEV_ERROR(adev->dev, "add_affected_mst_dsc_crtcs() failed\n");
 					goto fail;
+				}
 			}
 		}
 	}
@@ -10793,19 +10798,25 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
 			continue;
 
 		ret = amdgpu_dm_verify_lut_sizes(new_crtc_state);
-		if (ret)
+		if (ret) {
+			DRM_DEV_ERROR(adev->dev, "amdgpu_dm_verify_lut_sizes() failed\n");
 			goto fail;
+		}
 
 		if (!new_crtc_state->enable)
 			continue;
 
 		ret = drm_atomic_add_affected_connectors(state, crtc);
-		if (ret)
-			return ret;
+		if (ret) {
+			DRM_DEV_ERROR(adev->dev, "drm_atomic_add_affected_connectors() failed\n");
+			goto fail;
+		}
 
 		ret = drm_atomic_add_affected_planes(state, crtc);
-		if (ret)
+		if (ret) {
+			DRM_DEV_ERROR(adev->dev, "drm_atomic_add_affected_planes() failed\n");
 			goto fail;
+		}
 
 		if (dm_old_crtc_state->dsc_force_changed)
 			new_crtc_state->mode_changed = true;
@@ -10842,6 +10853,7 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
 
 			if (IS_ERR(new_plane_state)) {
 				ret = PTR_ERR(new_plane_state);
+				DRM_DEV_ERROR(adev->dev, "new_plane_state is BAD\n");
 				goto fail;
 			}
 		}
@@ -10854,8 +10866,10 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
 					    new_plane_state,
 					    false,
 					    &lock_and_validation_needed);
-		if (ret)
+		if (ret) {
+			DRM_DEV_ERROR(adev->dev, "dm_update_plane_state() failed\n");
 			goto fail;
+		}
 	}
 
 	/* Disable all crtcs which require disable */
@@ -10865,8 +10879,10 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
 					   new_crtc_state,
 					   false,
 					   &lock_and_validation_needed);
-		if (ret)
+		if (ret) {
+			DRM_DEV_ERROR(adev->dev, "DISABLE: dm_update_crtc_state() failed\n");
 			goto fail;
+		}
 	}
 
 	/* Enable all crtcs which require enable */
@@ -10876,8 +10892,10 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
 					   new_crtc_state,
 					   true,
 					   &lock_and_validation_needed);
-		if (ret)
+		if (ret) {
+			DRM_DEV_ERROR(adev->dev, "ENABLE: dm_update_crtc_state() failed\n");
 			goto fail;
+		}
 	}
 
 	/* Add new/modified planes */
@@ -10887,20 +10905,26 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
 					    new_plane_state,
 					    true,
 					    &lock_and_validation_needed);
-		if (ret)
+		if (ret) {
+			DRM_DEV_ERROR(adev->dev, "dm_update_plane_state() failed\n");
 			goto fail;
+		}
 	}
 
 	/* Run this here since we want to validate the streams we created */
 	ret = drm_atomic_helper_check_planes(dev, state);
-	if (ret)
+	if (ret) {
+		DRM_DEV_ERROR(adev->dev, "drm_atomic_helper_check_planes() failed\n");
 		goto fail;
+	}
 
 	/* Check cursor planes scaling */
 	for_each_new_crtc_in_state(state, crtc, new_crtc_state, i) {
 		ret = dm_check_crtc_cursor(state, crtc, new_crtc_state);
-		if (ret)
+		if (ret) {
+			DRM_DEV_ERROR(adev->dev, "dm_check_crtc_cursor() failed\n");
 			goto fail;
+		}
 	}
 
 	if (state->legacy_cursor_update) {
@@ -10987,20 +11011,28 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
 	 */
 	if (lock_and_validation_needed) {
 		ret = dm_atomic_get_state(state, &dm_state);
-		if (ret)
+		if (ret) {
+			DRM_DEV_ERROR(adev->dev, "dm_atomic_get_state() failed\n");
 			goto fail;
+		}
 
 		ret = do_aquire_global_lock(dev, state);
-		if (ret)
+		if (ret) {
+			DRM_DEV_ERROR(adev->dev, "do_aquire_global_lock() failed\n");
 			goto fail;
+		}
 
 #if defined(CONFIG_DRM_AMD_DC_DCN)
-		if (!compute_mst_dsc_configs_for_state(state, dm_state->context, vars))
+		if (!compute_mst_dsc_configs_for_state(state, dm_state->context, vars)) {
+			DRM_DEV_ERROR(adev->dev, "compute_mst_dsc_configs_for_state() failed\n");
 			goto fail;
+		}
 
 		ret = dm_update_mst_vcpi_slots_for_dsc(state, dm_state->context, vars);
-		if (ret)
+		if (ret) {
+			DRM_DEV_ERROR(adev->dev, "dm_update_mst_vcpi_slots_for_dsc() failed\n");
 			goto fail;
+		}
 #endif
 
 		/*
@@ -11010,11 +11042,13 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
 		 * to get stuck in an infinite loop and hang eventually.
 		 */
 		ret = drm_dp_mst_atomic_check(state);
-		if (ret)
+		if (ret) {
+			DRM_DEV_ERROR(adev->dev, "drm_dp_mst_atomic_check() failed\n");
 			goto fail;
+		}
 		status = dc_validate_global_state(dc, dm_state->context, false);
 		if (status != DC_OK) {
-			drm_dbg_atomic(dev,
+			DRM_DEV_ERROR(adev->dev,
 				       "DC global validation failure: %s (%d)",
 				       dc_status_to_str(status), status);
 			ret = -EINVAL;
-- 
2.17.1

