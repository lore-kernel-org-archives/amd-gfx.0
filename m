Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B28D6C001B0
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Jul 2023 02:42:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2999410E53F;
	Thu, 20 Jul 2023 02:42:56 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20628.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::628])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0704D10E53F
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Jul 2023 02:42:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JbIwFDulu3SEU9nLB2vNUdZyWRj9LIUdx+oN1tKhYB/Dw7YEWdnlP275IRUhstbongT9Pke+xqap8kMFaSwJwt/lAOKOHz6M6u3NoBr3rKOO1lmiVZZuS1GhsrNrO+meXl+r2RxpNObTHKvV0YEhzv7A/rO1+/7hcuokyEzUu78R2jkVJujMvcGtz7jF6PZuq+MrhnZgtfE7SmnPJq9ea9uVH/y6n6PqWurpJBCTVcfj8P6FEc3SyLSyrpwPansM4DSw+vdYH+iE2VanSfWR3qvukZZpWx6apjJjaCNdfmNSlYe3PJ8gmSvjrjqgCSo8DXYgsdAPewPvcc+IHvSeyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bJwAeee6A04ci4prRdMAL4MJJLh7LP8LLDjnAHTSSLI=;
 b=gM+sy69K4YvBfDxUy9HzdX398NGPYhtgxM0qFIqYO+MI76AJajweLNTw8q0P55/a3EqkoVbdWmd2SllW2BJPKmtLYIrPurEVlYc/N01qvTmPe2g1n7DUvDG9F3pfMuvJO59ZRf35Rf46RGqsgit13yiUNcly/MnCWmOZs6ntoULdCgzbItfkYZGkd7yR+JOXhqJ1v65xVkHQuP5YWCUJaf1mWsyKVheQ5xTjyJVPKPcaQPz17vxY2XwuGolFaXH8KWEWAZqQRhbUnZN482rmFL3R22+s0S+/Z4N9j7PM/yf76WVdmH028sxEM3WII0BcOvTsVYjBux/pH9/S4IDLig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bJwAeee6A04ci4prRdMAL4MJJLh7LP8LLDjnAHTSSLI=;
 b=AD0f+FzNJxzj2x2Ts3PDG0Nt9kfZwNoSVR7eLfICpP+ugdNqpUU3IgC3apggE9JhIFFouDTwcQVFrKNG0bP69jOEPXV2BKp2zfbKnrIfO/FxxJiB7UUmAi/SRjiq7W29SDalURCMoGaSgMJqQC6sFcFoJvsmQ4j3aC+xmbiaO2M=
Received: from MW2PR16CA0050.namprd16.prod.outlook.com (2603:10b6:907:1::27)
 by CH2PR12MB4165.namprd12.prod.outlook.com (2603:10b6:610:a4::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.33; Thu, 20 Jul
 2023 02:42:51 +0000
Received: from CO1NAM11FT095.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:1:cafe::24) by MW2PR16CA0050.outlook.office365.com
 (2603:10b6:907:1::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20 via Frontend
 Transport; Thu, 20 Jul 2023 02:42:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT095.mail.protection.outlook.com (10.13.174.179) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.34 via Frontend Transport; Thu, 20 Jul 2023 02:42:51 +0000
Received: from TRX40-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 19 Jul
 2023 21:42:48 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
Subject: [PATCH v2] drm/amd/amdgpu: Fix warnings in amdgpu/amdgpu_display.c
Date: Thu, 20 Jul 2023 08:12:29 +0530
Message-ID: <20230720024229.78400-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230719051939.811520-2-srinivasan.shanmugam@amd.com>
References: <20230719051939.811520-2-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT095:EE_|CH2PR12MB4165:EE_
X-MS-Office365-Filtering-Correlation-Id: 790f7891-010d-4316-7077-08db88cb02f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wY3GD0aaq+J/Yzoe/0jCB2lmdkOEB9T3kIGajeHQoBrRG76QxzSEjRAAtJCa0F1ynuAYPsfm/8BMVBjdXvv3D9D9aMAIKBatcyyTlVD+f1EHH7vto5rAjc7hFU9C6zPyfQ4KBIT6+KvFAGlfRZoTX1UPTIRgJs9Om+GNXnmOdGLbLElDe351Af0ajG4gZSdlVLe8lJ/Qkc8bPXU7+P3hwy3FdcgTOhL4n7FkrKR/rLde28WYAHKzs+XrL02WtO1ErY1WhRp+g4fv0wrV1uCHRys/PCqa+cByP07EIKwe+4OSsthLQwBZrwoVo8bc8fqR1ZDIPAS8yaWZVVVfeQPSKzufL1rm3qGvrdRsxYTAaiwD+pMktcpuLPhwJqGq8xWRAQYoO1huYxgEv0lSoOuh1bpClR/QjlF9o1ikCWLV4rppIO7Jltc2EqYIR1FBBIAas6nPuIMEbY5ptcaeDN0lwa63R5+iSrVM3N8q9Op5lgCfbFh3rH9M6XflaRFvQfHlrfMtdxGhXKHyAPqJbNa9Grx/VbUXlNwdrrG+NoEtVkNiK4mhOP/mM7X/AU7K+6H+F907FnUQe5fT7aZTxU6zQ+0cMJU1EZGQlt8S3IpNzZlVW9xPcBVmIudROef7U4ays+LnLIJH9ZuQ8WEeWnsUlut19vCeodOuxJDiMROuL9JElJOSLTRDbmctKj980G1Be3v2cvrLFK/qfutFEgDw8Fm0oq9669Pc9EjU6BuiFXSuGJE0XnUHIABdwkiavnQku/okM9E9wFmahv8thntc+A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(396003)(136003)(39860400002)(376002)(82310400008)(451199021)(36840700001)(46966006)(40470700004)(478600001)(6666004)(7696005)(54906003)(110136005)(66574015)(47076005)(356005)(2616005)(36860700001)(336012)(83380400001)(86362001)(36756003)(40460700003)(40480700001)(2906002)(44832011)(26005)(186003)(1076003)(16526019)(82740400003)(41300700001)(81166007)(426003)(70586007)(8936002)(70206006)(8676002)(5660300002)(4326008)(316002)(6636002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2023 02:42:51.1225 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 790f7891-010d-4316-7077-08db88cb02f8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT095.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4165
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

Fixes the below checkpatch.pl warnings:

WARNING: Block comments use * on subsequent lines
WARNING: Block comments use a trailing */ on a separate line
WARNING: suspect code indent for conditional statements (8, 12)
WARNING: braces {} are not necessary for single statement blocks

Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c | 42 ++++++++++++---------
 1 file changed, 25 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
index b702f499f5fb..9a74eae50ad4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
@@ -124,7 +124,7 @@ static void amdgpu_display_flip_work_func(struct work_struct *__work)
 
 	struct drm_crtc *crtc = &amdgpu_crtc->base;
 	unsigned long flags;
-	unsigned i;
+	unsigned int i;
 	int vpos, hpos;
 
 	for (i = 0; i < work->shared_count; ++i)
@@ -201,7 +201,7 @@ int amdgpu_display_crtc_page_flip_target(struct drm_crtc *crtc,
 	u64 tiling_flags;
 	int i, r;
 
-	work = kzalloc(sizeof *work, GFP_KERNEL);
+	work = kzalloc(sizeof(*work), GFP_KERNEL);
 	if (work == NULL)
 		return -ENOMEM;
 
@@ -332,13 +332,15 @@ int amdgpu_display_crtc_set_config(struct drm_mode_set *set,
 
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
@@ -507,11 +509,10 @@ bool amdgpu_display_ddc_probe(struct amdgpu_connector *amdgpu_connector,
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
@@ -520,10 +521,12 @@ bool amdgpu_display_ddc_probe(struct amdgpu_connector *amdgpu_connector,
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
@@ -1216,8 +1219,10 @@ amdgpu_display_user_framebuffer_create(struct drm_device *dev,
 
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
 
@@ -1410,6 +1415,7 @@ bool amdgpu_display_crtc_scaling_mode_fixup(struct drm_crtc *crtc,
 	}
 	if (amdgpu_crtc->rmx_type != RMX_OFF) {
 		fixed20_12 a, b;
+
 		a.full = dfixed_const(src_v);
 		b.full = dfixed_const(dst_v);
 		amdgpu_crtc->vsc.full = dfixed_div(a, b);
@@ -1429,7 +1435,7 @@ bool amdgpu_display_crtc_scaling_mode_fixup(struct drm_crtc *crtc,
  *
  * \param dev Device to query.
  * \param pipe Crtc to query.
- * \param flags Flags from caller (DRM_CALLED_FROM_VBLIRQ or 0).
+ * \param flags from caller (DRM_CALLED_FROM_VBLIRQ or 0).
  *              For driver internal use only also supports these flags:
  *
  *              USE_REAL_VBLANKSTART to use the real start of vblank instead
@@ -1504,8 +1510,8 @@ int amdgpu_display_get_crtc_scanoutpos(struct drm_device *dev,
 
 	/* Called from driver internal vblank counter query code? */
 	if (flags & GET_DISTANCE_TO_VBLANKSTART) {
-	    /* Caller wants distance from real vbl_start in *hpos */
-	    *hpos = *vpos - vbl_start;
+		/* Caller wants distance from real vbl_start in *hpos */
+		*hpos = *vpos - vbl_start;
 	}
 
 	/* Fudge vblank to start a few scanlines earlier to handle the
@@ -1527,7 +1533,7 @@ int amdgpu_display_get_crtc_scanoutpos(struct drm_device *dev,
 
 	/* In vblank? */
 	if (in_vbl)
-	    ret |= DRM_SCANOUTPOS_IN_VBLANK;
+		ret |= DRM_SCANOUTPOS_IN_VBLANK;
 
 	/* Called from driver internal vblank counter query code? */
 	if (flags & GET_DISTANCE_TO_VBLANKSTART) {
@@ -1635,6 +1641,7 @@ int amdgpu_display_suspend_helper(struct amdgpu_device *adev)
 
 		if (amdgpu_crtc->cursor_bo && !adev->enable_virtual_display) {
 			struct amdgpu_bo *aobj = gem_to_amdgpu_bo(amdgpu_crtc->cursor_bo);
+
 			r = amdgpu_bo_reserve(aobj, true);
 			if (r == 0) {
 				amdgpu_bo_unpin(aobj);
@@ -1642,9 +1649,9 @@ int amdgpu_display_suspend_helper(struct amdgpu_device *adev)
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
@@ -1671,6 +1678,7 @@ int amdgpu_display_resume_helper(struct amdgpu_device *adev)
 
 		if (amdgpu_crtc->cursor_bo && !adev->enable_virtual_display) {
 			struct amdgpu_bo *aobj = gem_to_amdgpu_bo(amdgpu_crtc->cursor_bo);
+
 			r = amdgpu_bo_reserve(aobj, true);
 			if (r == 0) {
 				r = amdgpu_bo_pin(aobj, AMDGPU_GEM_DOMAIN_VRAM);
-- 
2.25.1

