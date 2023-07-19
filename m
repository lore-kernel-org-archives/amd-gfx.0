Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3000CC001DC
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Jul 2023 05:20:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C9ED510E3F9;
	Wed, 19 Jul 2023 05:20:07 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::600])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 58A7210E3F5
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Jul 2023 05:20:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qm0P5pjFWiyAXKExAQTWxRvFHgsA6qsashv1byNwN18gKpPOMC44u68sLDhy/f/3lqslBtOeE85D9hk1biMJf9xFwp0cDOfTIpl1P2FLwWF//m0TL5PJZ08gkV1KJJvvmBHj0Ju1OiNf+WJ6Zr9LBSk7MXay2MUqKoYYl2fqFUoVV9tQhtK16yotmA/EnmSGSEaL7k2MVuMGAamG0csrOOkyBKtkBHD8oxUd2pkZwm0OqvibW2tQ4CWg77qtpz7QhEnF+fs+iM3xGsZfZD1rW4f/wnIZwKfj6kR0Yrjv52zJKjTro5QysHQ7WSaLmF1SFmATXVWpUbEdNfcEdwKGTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cr7uKT1R1174l8HnROnPqS19xRDOTOTXW2WEHsQDKO8=;
 b=Wcc9/og07k6vQcMQFhq7leSkY0rgLX8NKOXxg4ZfH0KQ7Gq2BY+/jFjY+NOm4KmcJtpwZGIo5dRmOFfKuQOAhUaY+jbT8LfXG/Dqxuzhw3x/H4ykMnwUF8ariJrkwO/ECdx8rxtkx7873Z8Av+CHwvdGX1cwsRt6VOiX0LUij8fnK0G21T7VbRRlskXc3sUMGrxrg8r2l/EJULt+EKl4DCP1FOBZ2mill0qHMQqn877JHAdGiwYSdkElotduji963Rb6G2DuerAlKZ39gUD5llxPyLDsFGC2YY7j78ZTNMiMaYo9wRzi/c3EnrkIn5S4X/QZPLWYG2PA6nDRc9KkOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cr7uKT1R1174l8HnROnPqS19xRDOTOTXW2WEHsQDKO8=;
 b=VcS/di0TP/igtTJt7Tmg1khaRHTpYElS9FUAg7oZLD1fuM472DjuwZejU8TKMUPRs1D01Uc2QAs2VQpDgGNQBSO7vum1J/fBVyvba4aw9msc8o0hvyYKdfsvX8Pv1xG+3j/nvXXG2D7BzSm8lvDpqCIzrhq40mDfq1wjb77JumA=
Received: from BN8PR15CA0033.namprd15.prod.outlook.com (2603:10b6:408:c0::46)
 by SA1PR12MB7104.namprd12.prod.outlook.com (2603:10b6:806:29e::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Wed, 19 Jul
 2023 05:19:56 +0000
Received: from BN8NAM11FT099.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:c0:cafe::b8) by BN8PR15CA0033.outlook.office365.com
 (2603:10b6:408:c0::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.23 via Frontend
 Transport; Wed, 19 Jul 2023 05:19:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT099.mail.protection.outlook.com (10.13.177.197) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.34 via Frontend Transport; Wed, 19 Jul 2023 05:19:56 +0000
Received: from TRX40-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 19 Jul
 2023 00:19:54 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
Subject: [PATCH 1/2] drm/amd/display: Convert macros to functions in
 amdgpu_display.c & amdgpu_display.h
Date: Wed, 19 Jul 2023 10:49:37 +0530
Message-ID: <20230719051939.811520-2-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230719051939.811520-1-srinivasan.shanmugam@amd.com>
References: <20230719051939.811520-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT099:EE_|SA1PR12MB7104:EE_
X-MS-Office365-Filtering-Correlation-Id: 468f5553-e4b3-48bf-1eb4-08db8817ca4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uj0/305eP2Yh4LFsiirbkV8D79UY9I3YTXSwSSyvfLxWYvHKvPyUdgIBXpWqKw90WU7MN3C11nhxnS1CvUZaGAz+1pZInK687JoaGNwGTnG44gv1v9Rw2hyeZt4ObTr3vgHHaH+fd/ehM6aTXK7BY2AqL3U74KMr1ScU5kfPjVr9zsuYXqS02SzabafLvmQ2jwP6a/CbgK/dfdJscXZ2q/r//e+JbvWfhQSsEl2rhdBG2lqhDRN6cxo6avSUvdZANGlqTd1E/knd/84vGP/92Ii/JGh2iSX8g3VvR+rNQw0hiZn+YiNnY/+tRsLgV+8FWwuVs6DopDKunhxgBwwbo1FSTFkgvhdFScvTyRBLFVrHs2DJBrY5BxWFIVzsYmtFtWz6YOacj8dVnY9U1u645Xqwc4mHYbkfeehFEbB+ZsCQojLRmalHqE+vSh2qZgbTQ6kqDMM61Fd/AcuNPRJK0eHhHHu6hi1xoWs5ckqjAWvjkW4KxWLR4FYAA9+cb1Uw9yJ+PFjJtBCjPQetqF0IuvlsjudinFp9fAhmDv9kNDxanII3pSlyqqPl9sGkhwXmfAiob2DwYgNNSTIw8+FyBCcVk4auHq2svo8yZAxRo5pPTuIXgqIc5xQtQesySSsXTfBUyKIpCYOWkJzKP9rtYhnARc8HxXwbG6uuropIKAYKNIKchrzCjV/ZJeV8wuzvT1yKtGt3/KaBJi0L87gycu+q47gdaeMe4GveII3pONgL3b9kJQZS1L/6LIBH0r9qz3jyDCVRbTW9eOkJzHMQig==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(346002)(396003)(136003)(39860400002)(451199021)(82310400008)(40470700004)(36840700001)(46966006)(7696005)(54906003)(6666004)(478600001)(110136005)(82740400003)(2616005)(36860700001)(83380400001)(426003)(47076005)(40460700003)(86362001)(66574015)(40480700001)(30864003)(70586007)(2906002)(44832011)(356005)(1076003)(186003)(16526019)(26005)(4326008)(81166007)(336012)(70206006)(41300700001)(6636002)(316002)(8676002)(5660300002)(36756003)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2023 05:19:56.2331 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 468f5553-e4b3-48bf-1eb4-08db8817ca4e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT099.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7104
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
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Convert macros to functions to fix the following & for better readability:

drivers/gpu/drm/amd/amdgpu/amdgpu_display.h:26: Macro argument reuse 'adev' - possible side-effects?
drivers/gpu/drm/amd/amdgpu/amdgpu_display.h:32: Macro argument reuse 'adev' - possible side-effects?
drivers/gpu/drm/amd/amdgpu/amdgpu_display.h:34: Macro argument reuse 'adev' - possible side-effects?
drivers/gpu/drm/amd/amdgpu/amdgpu_display.h:36: Macro argument reuse 'adev' - possible side-effects?
drivers/gpu/drm/amd/amdgpu/amdgpu_display.h:38: Macro argument reuse 'adev' - possible side-effects?
drivers/gpu/drm/amd/amdgpu/amdgpu_display.h:40: Macro argument reuse 'adev' - possible side-effects?
drivers/gpu/drm/amd/amdgpu/amdgpu_display.h:42: Macro argument reuse 'adev' - possible side-effects?
drivers/gpu/drm/amd/amdgpu/amdgpu_display.h:44: Macro argument reuse 'adev' - possible side-effects?

And other warnings:

WARNING: Block comments use * on subsequent lines
WARNING: Block comments use a trailing */ on a separate line
WARNING: suspect code indent for conditional statements (8, 12)
WARNING: braces {} are not necessary for single statement blocks

Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c | 118 +++++++++++++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.h |  46 ++++++--
 2 files changed, 136 insertions(+), 28 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
index b702f499f5fb..6eea92cef97c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
@@ -45,6 +45,82 @@
 #include <drm/drm_modeset_helper.h>
 #include <drm/drm_vblank.h>
 
+u32 amdgpu_display_vblank_get_counter(struct amdgpu_device *adev, int crtc)
+{
+	return (adev)->mode_info.funcs->vblank_get_counter((adev), (crtc));
+}
+
+void amdgpu_display_backlight_set_level(struct amdgpu_device *adev,
+					struct amdgpu_encoder *amdgpu_encoder,
+					u8 level)
+{
+	(adev)->mode_info.funcs->backlight_set_level((amdgpu_encoder), (level));
+}
+
+u8 amdgpu_display_backlight_get_level(struct amdgpu_device *adev,
+				      struct amdgpu_encoder *amdgpu_encoder)
+{
+	return (adev)->mode_info.funcs->backlight_get_level(amdgpu_encoder);
+}
+
+bool amdgpu_display_hpd_sense(struct amdgpu_device *adev,
+			      enum amdgpu_hpd_id hpd)
+{
+	return (adev)->mode_info.funcs->hpd_sense((adev), (hpd));
+}
+
+void amdgpu_display_hpd_set_polarity(struct amdgpu_device *adev,
+				     enum amdgpu_hpd_id hpd)
+{
+	(adev)->mode_info.funcs->hpd_set_polarity((adev), (hpd));
+}
+
+u32 amdgpu_display_hpd_get_gpio_reg(struct amdgpu_device *adev)
+{
+	return (adev)->mode_info.funcs->hpd_get_gpio_reg(adev);
+}
+
+void amdgpu_display_bandwidth_update(struct amdgpu_device *adev)
+{
+	(adev)->mode_info.funcs->bandwidth_update(adev);
+}
+
+void amdgpu_display_page_flip(struct amdgpu_device *adev,
+			      int crtc_id, u64 crtc_base,
+			      bool async)
+{
+	(adev)->mode_info.funcs->page_flip((adev), (crtc_id), (crtc_base), (async));
+}
+
+int amdgpu_display_page_flip_get_scanoutpos(struct amdgpu_device *adev, int crtc,
+					    u32 *vbl, u32 *pos)
+{
+	return (adev)->mode_info.funcs->page_flip_get_scanoutpos((adev), (crtc), (vbl), (pos));
+}
+
+void amdgpu_display_add_encoder(struct amdgpu_device *adev,
+				u32 encoder_enum,
+				u32 supported_device,
+				u16 caps)
+{
+	(adev)->mode_info.funcs->add_encoder((adev), (encoder_enum), (supported_device), (caps));
+}
+
+void amdgpu_display_add_connector(struct amdgpu_device *adev,
+				  u32 connector_id,
+				  u32 supported_device,
+				  int connector_type,
+				  struct amdgpu_i2c_bus_rec *i2c_bus,
+				  u16 connector_object_id,
+				  struct amdgpu_hpd *hpd,
+				  struct amdgpu_router *router)
+{
+	(adev)->mode_info.funcs->add_connector((adev), (connector_id),
+					       (supported_device), (connector_type),
+					       (i2c_bus), (connector_object_id),
+					       (hpd), (router));
+}
+
 /**
  * amdgpu_display_hotplug_work_func - work handler for display hotplug event
  *
@@ -124,7 +200,7 @@ static void amdgpu_display_flip_work_func(struct work_struct *__work)
 
 	struct drm_crtc *crtc = &amdgpu_crtc->base;
 	unsigned long flags;
-	unsigned i;
+	unsigned int i;
 	int vpos, hpos;
 
 	for (i = 0; i < work->shared_count; ++i)
@@ -201,7 +277,7 @@ int amdgpu_display_crtc_page_flip_target(struct drm_crtc *crtc,
 	u64 tiling_flags;
 	int i, r;
 
-	work = kzalloc(sizeof *work, GFP_KERNEL);
+	work = kzalloc(sizeof(*work), GFP_KERNEL);
 	if (work == NULL)
 		return -ENOMEM;
 
@@ -332,13 +408,15 @@ int amdgpu_display_crtc_set_config(struct drm_mode_set *set,
 
 	adev = drm_to_adev(dev);
 	/* if we have active crtcs and we don't have a power ref,
-	   take the current one */
+	 * take the current one
+	 */
 	if (active && !adev->have_disp_power_ref) {
 		adev->have_disp_power_ref = true;
 		return ret;
 	}
 	/* if we have no active crtcs, then drop the power ref
-	   we got before */
+	 * we got before
+	 */
 	if (!active && adev->have_disp_power_ref) {
 		pm_runtime_put_autosuspend(dev->dev);
 		adev->have_disp_power_ref = false;
@@ -507,11 +585,10 @@ bool amdgpu_display_ddc_probe(struct amdgpu_connector *amdgpu_connector,
 	if (amdgpu_connector->router.ddc_valid)
 		amdgpu_i2c_router_select_ddc_port(amdgpu_connector);
 
-	if (use_aux) {
+	if (use_aux)
 		ret = i2c_transfer(&amdgpu_connector->ddc_bus->aux.ddc, msgs, 2);
-	} else {
+	else
 		ret = i2c_transfer(&amdgpu_connector->ddc_bus->adapter, msgs, 2);
-	}
 
 	if (ret != 2)
 		/* Couldn't find an accessible DDC on this connector */
@@ -520,10 +597,12 @@ bool amdgpu_display_ddc_probe(struct amdgpu_connector *amdgpu_connector,
 	 * EDID header starts with:
 	 * 0x00,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0x00.
 	 * Only the first 6 bytes must be valid as
-	 * drm_edid_block_valid() can fix the last 2 bytes */
+	 * drm_edid_block_valid() can fix the last 2 bytes
+	 */
 	if (drm_edid_header_is_valid(buf) < 6) {
 		/* Couldn't find an accessible EDID on this
-		 * connector */
+		 * connector
+		 */
 		return false;
 	}
 	return true;
@@ -1216,8 +1295,10 @@ amdgpu_display_user_framebuffer_create(struct drm_device *dev,
 
 	obj = drm_gem_object_lookup(file_priv, mode_cmd->handles[0]);
 	if (obj ==  NULL) {
-		drm_dbg_kms(dev, "No GEM object associated to handle 0x%08X, "
-			    "can't create framebuffer\n", mode_cmd->handles[0]);
+		drm_dbg_kms(dev, "No GEM object associated to handle 0x%08X\n",
+			    mode_cmd->handles[0]);
+		drm_dbg_kms(dev, "  - Can't create framebuffer\n");
+
 		return ERR_PTR(-ENOENT);
 	}
 
@@ -1410,6 +1491,7 @@ bool amdgpu_display_crtc_scaling_mode_fixup(struct drm_crtc *crtc,
 	}
 	if (amdgpu_crtc->rmx_type != RMX_OFF) {
 		fixed20_12 a, b;
+
 		a.full = dfixed_const(src_v);
 		b.full = dfixed_const(dst_v);
 		amdgpu_crtc->vsc.full = dfixed_div(a, b);
@@ -1429,7 +1511,7 @@ bool amdgpu_display_crtc_scaling_mode_fixup(struct drm_crtc *crtc,
  *
  * \param dev Device to query.
  * \param pipe Crtc to query.
- * \param flags Flags from caller (DRM_CALLED_FROM_VBLIRQ or 0).
+ * \param flags from caller (DRM_CALLED_FROM_VBLIRQ or 0).
  *              For driver internal use only also supports these flags:
  *
  *              USE_REAL_VBLANKSTART to use the real start of vblank instead
@@ -1504,8 +1586,8 @@ int amdgpu_display_get_crtc_scanoutpos(struct drm_device *dev,
 
 	/* Called from driver internal vblank counter query code? */
 	if (flags & GET_DISTANCE_TO_VBLANKSTART) {
-	    /* Caller wants distance from real vbl_start in *hpos */
-	    *hpos = *vpos - vbl_start;
+		/* Caller wants distance from real vbl_start in *hpos */
+		*hpos = *vpos - vbl_start;
 	}
 
 	/* Fudge vblank to start a few scanlines earlier to handle the
@@ -1527,7 +1609,7 @@ int amdgpu_display_get_crtc_scanoutpos(struct drm_device *dev,
 
 	/* In vblank? */
 	if (in_vbl)
-	    ret |= DRM_SCANOUTPOS_IN_VBLANK;
+		ret |= DRM_SCANOUTPOS_IN_VBLANK;
 
 	/* Called from driver internal vblank counter query code? */
 	if (flags & GET_DISTANCE_TO_VBLANKSTART) {
@@ -1635,6 +1717,7 @@ int amdgpu_display_suspend_helper(struct amdgpu_device *adev)
 
 		if (amdgpu_crtc->cursor_bo && !adev->enable_virtual_display) {
 			struct amdgpu_bo *aobj = gem_to_amdgpu_bo(amdgpu_crtc->cursor_bo);
+
 			r = amdgpu_bo_reserve(aobj, true);
 			if (r == 0) {
 				amdgpu_bo_unpin(aobj);
@@ -1642,9 +1725,9 @@ int amdgpu_display_suspend_helper(struct amdgpu_device *adev)
 			}
 		}
 
-		if (fb == NULL || fb->obj[0] == NULL) {
+		if (!fb || !fb->obj[0])
 			continue;
-		}
+
 		robj = gem_to_amdgpu_bo(fb->obj[0]);
 		if (!amdgpu_display_robj_is_fb(adev, robj)) {
 			r = amdgpu_bo_reserve(robj, true);
@@ -1671,6 +1754,7 @@ int amdgpu_display_resume_helper(struct amdgpu_device *adev)
 
 		if (amdgpu_crtc->cursor_bo && !adev->enable_virtual_display) {
 			struct amdgpu_bo *aobj = gem_to_amdgpu_bo(amdgpu_crtc->cursor_bo);
+
 			r = amdgpu_bo_reserve(aobj, true);
 			if (r == 0) {
 				r = amdgpu_bo_pin(aobj, AMDGPU_GEM_DOMAIN_VRAM);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.h
index 9d19940f73c8..4cefaec6a495 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.h
@@ -23,17 +23,41 @@
 #ifndef __AMDGPU_DISPLAY_H__
 #define __AMDGPU_DISPLAY_H__
 
-#define amdgpu_display_vblank_get_counter(adev, crtc) (adev)->mode_info.funcs->vblank_get_counter((adev), (crtc))
-#define amdgpu_display_backlight_set_level(adev, e, l) (adev)->mode_info.funcs->backlight_set_level((e), (l))
-#define amdgpu_display_backlight_get_level(adev, e) (adev)->mode_info.funcs->backlight_get_level((e))
-#define amdgpu_display_hpd_sense(adev, h) (adev)->mode_info.funcs->hpd_sense((adev), (h))
-#define amdgpu_display_hpd_set_polarity(adev, h) (adev)->mode_info.funcs->hpd_set_polarity((adev), (h))
-#define amdgpu_display_hpd_get_gpio_reg(adev) (adev)->mode_info.funcs->hpd_get_gpio_reg((adev))
-#define amdgpu_display_bandwidth_update(adev) (adev)->mode_info.funcs->bandwidth_update((adev))
-#define amdgpu_display_page_flip(adev, crtc, base, async) (adev)->mode_info.funcs->page_flip((adev), (crtc), (base), (async))
-#define amdgpu_display_page_flip_get_scanoutpos(adev, crtc, vbl, pos) (adev)->mode_info.funcs->page_flip_get_scanoutpos((adev), (crtc), (vbl), (pos))
-#define amdgpu_display_add_encoder(adev, e, s, c) (adev)->mode_info.funcs->add_encoder((adev), (e), (s), (c))
-#define amdgpu_display_add_connector(adev, ci, sd, ct, ib, coi, h, r) (adev)->mode_info.funcs->add_connector((adev), (ci), (sd), (ct), (ib), (coi), (h), (r))
+u32 amdgpu_display_vblank_get_counter(struct amdgpu_device *adev,
+				      int crtc);
+bool amdgpu_display_hpd_sense(struct amdgpu_device *adev,
+			      enum amdgpu_hpd_id hpd);
+void amdgpu_display_hpd_set_polarity(struct amdgpu_device *adev,
+				     enum amdgpu_hpd_id hpd);
+void amdgpu_display_backlight_set_level(struct amdgpu_device *adev,
+					struct amdgpu_encoder *amdgpu_encoder,
+					u8 level);
+u8 amdgpu_display_backlight_get_level(struct amdgpu_device *adev,
+				      struct amdgpu_encoder *amdgpu_encoder);
+bool amdgpu_display_hpd_sense(struct amdgpu_device *adev,
+			      enum amdgpu_hpd_id hpd);
+void amdgpu_display_hpd_set_polarity(struct amdgpu_device *adev,
+				     enum amdgpu_hpd_id hpd);
+u32 amdgpu_display_hpd_get_gpio_reg(struct amdgpu_device *adev);
+void amdgpu_display_bandwidth_update(struct amdgpu_device *adev);
+void amdgpu_display_page_flip(struct amdgpu_device *adev,
+			      int crtc_id, u64 crtc_base,
+			       bool async);
+int amdgpu_display_page_flip_get_scanoutpos(struct amdgpu_device *adev, int crtc,
+					    u32 *vbl, u32 *position);
+
+void amdgpu_display_add_encoder(struct amdgpu_device *adev,
+				u32 encoder_enum,
+				u32 supported_device,
+				u16 caps);
+void amdgpu_display_add_connector(struct amdgpu_device *adev,
+				  u32 connector_id,
+				  u32 supported_device,
+				  int connector_type,
+				  struct amdgpu_i2c_bus_rec *i2c_bus,
+				  u16 connector_object_id,
+				  struct amdgpu_hpd *hpd,
+				  struct amdgpu_router *router);
 
 void amdgpu_display_hotplug_work_func(struct work_struct *work);
 void amdgpu_display_update_priority(struct amdgpu_device *adev);
-- 
2.25.1

