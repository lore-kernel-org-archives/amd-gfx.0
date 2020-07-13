Return-Path: <SRS0=fQkT=AY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EC10C433E0
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jul 2020 15:39:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2665320771
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jul 2020 15:39:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="FV9R0A2A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2665320771
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DBB1A6E09E;
	Mon, 13 Jul 2020 15:39:37 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2076.outbound.protection.outlook.com [40.107.236.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F3A3B6E09E
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jul 2020 15:39:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j3bDiCsp0u8TIuwnPUvRObSdKOyZ3jsfyM+DXawla8zsVzQ72tUD70+9Ml0z4sdVITAKIeqBzJJBsK6D0nIi+YjFif9jICz8FkK7BVBVJHVzXP5tCy25yxEjnCCIES8CHDBTry4XRn9Kpj0TgcKDgT1xqEJfaZTC1iEIuOo50OmK98sr7At4wIf6ioM6vMCSfRb1kiQXpcinyDW0yuIfgcWPDVRagcELvGxHAcr6qnyBjO553JctwFQyHBiBLl47N84+6OBx62Bqpq7k+dWcfgwT+kOQTQjXMJGEQ7dqTtCLkvtF+W6WAuyaK+YjbsadfDtUMZpp0KU8ew3XFsu82A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ejjbqnF+dT4ke7UQSs9AFhcztMD654enjriCBsebK2c=;
 b=mnrhm1d4CvESiQgri8wV3D5E3xYblD1OUlFFNdylNWBg4VapdW4BFfZJL264hy62PHp/4Z7Q4AXS+mhYmk3Z22JhNijUXakCk/8AfA+I7q68dRSWLZl6YowakZxgV4aXYOo9pWbUtfTJ85TQfj8uh6nzM216ej9Gupxs/PU27Ya34nQUhpx6W19VNPIahqEfq2LN2hbD+k59pSPwtrdITYltnY0qDhiI7Iv0T5f9z2GCq0VS+qXP4QkOf1FcAzK9R+zqETgNclW+TARugn6jqZijkm+aB6z1r6d+1G1Q4WKb0SyMYM31EhF2mozRxJPELpOaUvr0bvTNc0YMBDxnTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ejjbqnF+dT4ke7UQSs9AFhcztMD654enjriCBsebK2c=;
 b=FV9R0A2ALpkzwXukK2ZvLQQfx2VBhzuNvkTatOQnzX/ifv1vVKKL33Ui9vhllALK+Z5ehwa5ZMkl2Dct7wndFgngPGhyw+tifd6/3hKGDCg4KZItR3W1WAHNN7Io50ZRDkqQbKy6NOBClyjP5CnszyCQfUPcuJS8tx/KNPH5FkM=
Received: from BN6PR18CA0018.namprd18.prod.outlook.com (2603:10b6:404:121::28)
 by BYAPR12MB3222.namprd12.prod.outlook.com (2603:10b6:a03:12c::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.23; Mon, 13 Jul
 2020 15:39:33 +0000
Received: from BN8NAM11FT039.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:121:cafe::10) by BN6PR18CA0018.outlook.office365.com
 (2603:10b6:404:121::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.22 via Frontend
 Transport; Mon, 13 Jul 2020 15:39:33 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 BN8NAM11FT039.mail.protection.outlook.com (10.13.177.169) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3174.21 via Frontend Transport; Mon, 13 Jul 2020 15:39:33 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 13 Jul
 2020 10:39:32 -0500
Received: from DESKTOP-3JO4JG6.localdomain (10.180.168.240) by
 SATLEXMB01.amd.com (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5
 via Frontend Transport; Mon, 13 Jul 2020 10:39:32 -0500
From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amd/display: Allow for vblank enabled with no active
 planes
Date: Mon, 13 Jul 2020 11:39:08 -0400
Message-ID: <20200713153908.14815-2-nicholas.kazlauskas@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200713153908.14815-1-nicholas.kazlauskas@amd.com>
References: <20200713153908.14815-1-nicholas.kazlauskas@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(396003)(136003)(376002)(346002)(46966005)(2906002)(6916009)(316002)(186003)(83380400001)(26005)(70586007)(336012)(70206006)(86362001)(1076003)(44832011)(2616005)(82310400002)(356005)(5660300002)(478600001)(426003)(81166007)(8676002)(30864003)(54906003)(82740400003)(47076004)(6666004)(36756003)(8936002)(4326008);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 159f86e7-0494-4450-43d2-08d82742f0bf
X-MS-TrafficTypeDiagnostic: BYAPR12MB3222:
X-Microsoft-Antispam-PRVS: <BYAPR12MB3222D84D3A5DF6F25F6290AFEC600@BYAPR12MB3222.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FdzUhS5adQ2CFBm+aZmZkyZLHwmccEMsMlzGHACwIMDcu+ilRBN/kK+jm/n+qC7M2ZPCTDxYocn65giZYk7fVH66x97WplNPF9s1MWuhoiLKhrTCkHdYk+fj7bTbe0hviESwOCG56G7cAzNf3cPd8tpWhmDqigCzfHub23xL65gIiZpcjdO8n1zoTOSr7sbj8SHOr054lWDCpvmZN71h6vf663BBWwmSBQRxWGFQtVw998/AOrqwoy4NwtF2fYdyeU76s1WjRKHE3S3+bOX8n4F5vCFLDB1vUp6cdc/YIZS61q/4vpamTF80pxeEbP0RsMMdgfaDp8giNkxM55pf51YLpF4p6mz12k2+BZkMtDlK/Y0xoX4KBc0h+Q+VYEM5PcGjFcjBz6CBL32g4zkuSg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2020 15:39:33.2876 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 159f86e7-0494-4450-43d2-08d82742f0bf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT039.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3222
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
Cc: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
CRC capture doesn't work when the active plane count is 0 since we
currently tie both vblank and pageflip interrupts to active_plane_count
greater than 0.

[How]
The frontend is what generates the vblank interrupts while the backend
is what generates pageflip interrupts. Both have a requirement for
the CRTC to be active, so control the overall interrupt state based
on that instead.

Pageflip interrupts need to be enabled based on active plane count, but
we actually rely on power gating to take care of disabling the interrupt
for us on pipes that can be power gated.

For pipes that can't be power gated it's still fine to leave it enabled
since the interrupt only triggers after the address has been written
to that particular pipe - which we won't be doing without an active
plane.

The issue we had before with this setup was that we couldn't force
the state back on. We were essentially manipulating the refcount
to enable or disable as needed in a two pass approach.

However, there is a function that solves this problem more elegantly:
amdgpu_irq_update() will unconditionally call the set based on what it
thinks the current enablement state is.

This leaves two future TODO items for our IRQ handling:
- Disabling IRQs in commit tail instead of atomic commit
- Mapping the pageflip interrupt to VUPDATE or something that's tied to
  the frontend instead of the backend since the mapping to CRTC is not
  correct

Cc: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 168 ++++++++----------
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |   1 -
 2 files changed, 78 insertions(+), 91 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index d9f8e9c26390..05160c6bbc03 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -4719,7 +4719,6 @@ dm_crtc_duplicate_state(struct drm_crtc *crtc)
 	}
 
 	state->active_planes = cur->active_planes;
-	state->interrupts_enabled = cur->interrupts_enabled;
 	state->vrr_params = cur->vrr_params;
 	state->vrr_infopacket = cur->vrr_infopacket;
 	state->abm_level = cur->abm_level;
@@ -5393,29 +5392,19 @@ static int count_crtc_active_planes(struct drm_crtc_state *new_crtc_state)
 	return num_active;
 }
 
-/*
- * Sets whether interrupts should be enabled on a specific CRTC.
- * We require that the stream be enabled and that there exist active
- * DC planes on the stream.
- */
-static void
-dm_update_crtc_interrupt_state(struct drm_crtc *crtc,
-			       struct drm_crtc_state *new_crtc_state)
+static void dm_update_crtc_active_planes(struct drm_crtc *crtc,
+					 struct drm_crtc_state *new_crtc_state)
 {
 	struct dm_crtc_state *dm_new_crtc_state =
 		to_dm_crtc_state(new_crtc_state);
 
 	dm_new_crtc_state->active_planes = 0;
-	dm_new_crtc_state->interrupts_enabled = false;
 
 	if (!dm_new_crtc_state->stream)
 		return;
 
 	dm_new_crtc_state->active_planes =
 		count_crtc_active_planes(new_crtc_state);
-
-	dm_new_crtc_state->interrupts_enabled =
-		dm_new_crtc_state->active_planes > 0;
 }
 
 static int dm_crtc_helper_atomic_check(struct drm_crtc *crtc,
@@ -5426,13 +5415,7 @@ static int dm_crtc_helper_atomic_check(struct drm_crtc *crtc,
 	struct dm_crtc_state *dm_crtc_state = to_dm_crtc_state(state);
 	int ret = -EINVAL;
 
-	/*
-	 * Update interrupt state for the CRTC. This needs to happen whenever
-	 * the CRTC has changed or whenever any of its planes have changed.
-	 * Atomic check satisfies both of these requirements since the CRTC
-	 * is added to the state by DRM during drm_atomic_helper_check_planes.
-	 */
-	dm_update_crtc_interrupt_state(crtc, state);
+	dm_update_crtc_active_planes(crtc, state);
 
 	if (unlikely(!dm_crtc_state->stream &&
 		     modeset_required(state, NULL, dm_crtc_state->stream))) {
@@ -6547,8 +6530,10 @@ static void manage_dm_interrupts(struct amdgpu_device *adev,
 				 bool enable)
 {
 	/*
-	 * this is not correct translation but will work as soon as VBLANK
-	 * constant is the same as PFLIP
+	 * We have no guarantee that the frontend index maps to the same
+	 * backend index - some even map to more than one.
+	 *
+	 * TODO: Use a different interrupt or check DC itself for the mapping.
 	 */
 	int irq_type =
 		amdgpu_display_crtc_idx_to_irq_type(
@@ -6571,6 +6556,19 @@ static void manage_dm_interrupts(struct amdgpu_device *adev,
 	}
 }
 
+static void dm_update_pflip_irq_state(struct amdgpu_device *adev,
+				      struct amdgpu_crtc *acrtc)
+{
+	int irq_type =
+		amdgpu_display_crtc_idx_to_irq_type(adev, acrtc->crtc_id);
+
+	/**
+	 * This reads the current state for the IRQ and force reapplies
+	 * the setting to hardware.
+	 */
+	amdgpu_irq_update(adev, &adev->pageflip_irq, irq_type);
+}
+
 static bool
 is_scaling_state_different(const struct dm_connector_state *dm_state,
 			   const struct dm_connector_state *old_dm_state)
@@ -7154,7 +7152,16 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
 			usleep_range(1000, 1100);
 		}
 
-		if (acrtc_attach->base.state->event) {
+		/**
+		 * Prepare the flip event for the pageflip interrupt to handle.
+		 *
+		 * This only works in the case where we've already turned on the
+		 * appropriate hardware blocks (eg. HUBP) so in the transition case
+		 * from 0 -> n planes we have to skip a hardware generated event
+		 * and rely on sending it from software.
+		 */
+		if (acrtc_attach->base.state->event &&
+		    acrtc_state->active_planes > 0) {
 			drm_crtc_vblank_get(pcrtc);
 
 			spin_lock_irqsave(&pcrtc->dev->event_lock, flags);
@@ -7223,6 +7230,24 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
 						     &bundle->stream_update,
 						     dc_state);
 
+		/**
+		 * Enable or disable the interrupts on the backend.
+		 *
+		 * Most pipes are put into power gating when unused.
+		 *
+		 * When power gating is enabled on a pipe we lose the
+		 * interrupt enablement state when power gating is disabled.
+		 *
+		 * So we need to update the IRQ control state in hardware
+		 * whenever the pipe turns on (since it could be previously
+		 * power gated) or off (since some pipes can't be power gated
+		 * on some ASICs).
+		 */
+		if (dm_old_crtc_state->active_planes != acrtc_state->active_planes)
+			dm_update_pflip_irq_state(
+				(struct amdgpu_device *)dev->dev_private,
+				acrtc_attach);
+
 		if ((acrtc_state->update_type > UPDATE_TYPE_FAST) &&
 				acrtc_state->stream->link->psr_settings.psr_version != DC_PSR_VERSION_UNSUPPORTED &&
 				!acrtc_state->stream->link->psr_settings.psr_feature_enabled)
@@ -7323,64 +7348,6 @@ static void amdgpu_dm_commit_audio(struct drm_device *dev,
 	}
 }
 
-/*
- * Enable interrupts on CRTCs that are newly active, undergone
- * a modeset, or have active planes again.
- *
- * Done in two passes, based on the for_modeset flag:
- * Pass 1: For CRTCs going through modeset
- * Pass 2: For CRTCs going from 0 to n active planes
- *
- * Interrupts can only be enabled after the planes are programmed,
- * so this requires a two-pass approach since we don't want to
- * just defer the interrupts until after commit planes every time.
- */
-static void amdgpu_dm_enable_crtc_interrupts(struct drm_device *dev,
-					     struct drm_atomic_state *state,
-					     bool for_modeset)
-{
-	struct amdgpu_device *adev = dev->dev_private;
-	struct drm_crtc *crtc;
-	struct drm_crtc_state *old_crtc_state, *new_crtc_state;
-	int i;
-#ifdef CONFIG_DEBUG_FS
-	enum amdgpu_dm_pipe_crc_source source;
-#endif
-
-	for_each_oldnew_crtc_in_state(state, crtc, old_crtc_state,
-				      new_crtc_state, i) {
-		struct amdgpu_crtc *acrtc = to_amdgpu_crtc(crtc);
-		struct dm_crtc_state *dm_new_crtc_state =
-			to_dm_crtc_state(new_crtc_state);
-		struct dm_crtc_state *dm_old_crtc_state =
-			to_dm_crtc_state(old_crtc_state);
-		bool modeset = drm_atomic_crtc_needs_modeset(new_crtc_state);
-		bool run_pass;
-
-		run_pass = (for_modeset && modeset) ||
-			   (!for_modeset && !modeset &&
-			    !dm_old_crtc_state->interrupts_enabled);
-
-		if (!run_pass)
-			continue;
-
-		if (!dm_new_crtc_state->interrupts_enabled)
-			continue;
-
-		manage_dm_interrupts(adev, acrtc, true);
-
-#ifdef CONFIG_DEBUG_FS
-		/* The stream has changed so CRC capture needs to re-enabled. */
-		source = dm_new_crtc_state->crc_src;
-		if (amdgpu_dm_is_valid_crc_source(source)) {
-			amdgpu_dm_crtc_configure_crc_source(
-				crtc, dm_new_crtc_state,
-				dm_new_crtc_state->crc_src);
-		}
-#endif
-	}
-}
-
 /*
  * amdgpu_dm_crtc_copy_transient_flags - copy mirrored flags from DRM to DC
  * @crtc_state: the DRM CRTC state
@@ -7420,12 +7387,10 @@ static int amdgpu_dm_atomic_commit(struct drm_device *dev,
 	 * in atomic check.
 	 */
 	for_each_oldnew_crtc_in_state(state, crtc, old_crtc_state, new_crtc_state, i) {
-		struct dm_crtc_state *dm_old_crtc_state = to_dm_crtc_state(old_crtc_state);
-		struct dm_crtc_state *dm_new_crtc_state = to_dm_crtc_state(new_crtc_state);
 		struct amdgpu_crtc *acrtc = to_amdgpu_crtc(crtc);
 
-		if (dm_old_crtc_state->interrupts_enabled &&
-		    (!dm_new_crtc_state->interrupts_enabled ||
+		if (old_crtc_state->active &&
+		    (!new_crtc_state->active ||
 		     drm_atomic_crtc_needs_modeset(new_crtc_state)))
 			manage_dm_interrupts(adev, acrtc, false);
 	}
@@ -7704,8 +7669,34 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
 						dm_new_crtc_state);
 	}
 
-	/* Enable interrupts for CRTCs going through a modeset. */
-	amdgpu_dm_enable_crtc_interrupts(dev, state, true);
+	/**
+	 * Enable interrupts for CRTCs that are newly enabled or went through
+	 * a modeset. It was intentionally deferred until after the front end
+	 * state was modified to wait until the OTG was on and so the IRQ
+	 * handlers didn't access stale or invalid state.
+	 */
+	for_each_oldnew_crtc_in_state(state, crtc, old_crtc_state, new_crtc_state, i) {
+		struct amdgpu_crtc *acrtc = to_amdgpu_crtc(crtc);
+
+		if (new_crtc_state->active &&
+		    (!old_crtc_state->active ||
+		     drm_atomic_crtc_needs_modeset(new_crtc_state))) {
+			manage_dm_interrupts(adev, acrtc, true);
+#ifdef CONFIG_DEBUG_FS
+			/**
+			 * Frontend may have changed so reapply the CRC capture
+			 * settings for the stream.
+			 */
+			dm_new_crtc_state = to_dm_crtc_state(new_crtc_state);
+
+			if (amdgpu_dm_is_valid_crc_source(dm_new_crtc_state->crc_src)) {
+				amdgpu_dm_crtc_configure_crc_source(
+					crtc, dm_new_crtc_state,
+					dm_new_crtc_state->crc_src);
+			}
+#endif
+		}
+	}
 
 	for_each_new_crtc_in_state(state, crtc, new_crtc_state, j)
 		if (new_crtc_state->async_flip)
@@ -7720,9 +7711,6 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
 						dm, crtc, wait_for_vblank);
 	}
 
-	/* Enable interrupts for CRTCs going from 0 to n active planes. */
-	amdgpu_dm_enable_crtc_interrupts(dev, state, false);
-
 	/* Update audio instances for each connector. */
 	amdgpu_dm_commit_audio(dev, state);
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index 94d3ff727c25..82cdf07b4bd0 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -414,7 +414,6 @@ struct dm_crtc_state {
 
 	int update_type;
 	int active_planes;
-	bool interrupts_enabled;
 
 	int crc_skip_count;
 	enum amdgpu_dm_pipe_crc_source crc_src;
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
