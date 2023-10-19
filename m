Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66D07CDB465
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Oct 2023 13:34:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DEEA810E4EF;
	Thu, 19 Oct 2023 13:34:14 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2068.outbound.protection.outlook.com [40.107.223.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E09A10E4EE
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Oct 2023 13:34:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P+S13Z9jo6ADPMaFJtYPTBywz6a6pKoT3E4aCvh2lHY+DEfzToL3ygHpRdvx++EFqi7Ha34XQ8zwToehGZg01ZGfSbAKjnqKqjN1z2D5XNL09T4dU/bxE9iSgAON9BQERLK1SzaugIWJ7pbhKncAToZJgZKdybRO/k9izy7x3Ewz2wkWpcWaPCSEbmvMPlPgoesqyJd2MesMpcCZzVdpWPdLF7oGHcZhmDDT+Qu4SWafclGMtYTSpU9RKZQ3oIwJiokVDFISa0+6NAF+guosqDseddVRfoVfIevafreXmLKPJjhYv2nMXtAcPiUpCxVWa0toP0qToaZ1NOq6V0Q9gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fknAXP4uRHMuCIZwcHUsugT8pc8amwFR/gFhhLEwv38=;
 b=Yi2h5hho5XfSFOCItrRwMrCCJz4lYKrENrvz1VIer4WnauiiW1p/WENf8NWd5EAb+lGUrUe4tF9cXvicb3meO4ayb642ytu3r/eWY4lshZT6I80kzrgSjb/JKsITPGG5PV9ie3CwfOo3L/lyewPZdr2nQz55zu3/zvdZmdfrhTLwDtpr/R0KkEKPwHQsHLCm4jOcrQcUctCcKTv0vibCkSotbz9EVnikC25DZ2mUat4yALGO2YHi6OWKXwsgp7JW6zp2Ci5msT3SyDzBcWMPKqTIDFuOlxFN34CyNw7DuUcaOaqhM+kP7WwtzLV+8jccfY3Z7z9sSg+/tkJ+nbffMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fknAXP4uRHMuCIZwcHUsugT8pc8amwFR/gFhhLEwv38=;
 b=tN88sZJNlF81NhvmUFU56tHM8LUsZ2s43yRYUUe3aTDIT5qFJcH0FfHakzJVdFUA2Rzao+Zej1lMBs20o/QjDNfRbZ61p9N7GjK9wS02KB3c+J+ltWnO3sfM49lFpgmNClcQeIje3n1ouCwjvRA77CVJ/PEJmsdxl1i2QRCbyUY=
Received: from MN2PR05CA0005.namprd05.prod.outlook.com (2603:10b6:208:c0::18)
 by SJ2PR12MB8011.namprd12.prod.outlook.com (2603:10b6:a03:4c8::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Thu, 19 Oct
 2023 13:34:09 +0000
Received: from BL6PEPF0001AB4C.namprd04.prod.outlook.com
 (2603:10b6:208:c0:cafe::9e) by MN2PR05CA0005.outlook.office365.com
 (2603:10b6:208:c0::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.7 via Frontend
 Transport; Thu, 19 Oct 2023 13:34:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL6PEPF0001AB4C.mail.protection.outlook.com (10.167.242.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Thu, 19 Oct 2023 13:34:09 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 19 Oct
 2023 08:33:32 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Thu, 19 Oct 2023 08:33:22 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 15/24] drm/amd/display: Add prefix to amdgpu crtc functions
Date: Thu, 19 Oct 2023 09:32:13 -0400
Message-ID: <20231019133222.1633077-16-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231019133222.1633077-1-Roman.Li@amd.com>
References: <20231019133222.1633077-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4C:EE_|SJ2PR12MB8011:EE_
X-MS-Office365-Filtering-Correlation-Id: d11daea6-ba95-4b88-9b37-08dbd0a812c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gzGNsU+rrb0B6BPcvTdPfuTFBZEv6bksK+tgeKImWlOkDo0ALtoK6nRu2gCe2sOWRaktoz9IB+HwRZOxlFET8b20PmBt0GZLeP1dUMwmEPqYM7xQ3Cz72vZArAh6xEk9sUAz8L/nITFh5nqpf5Mhv3lSe/W53uLoqt5Ck9UR0+lwQjdjlZALZTlM0IXalJ8FE+z81zfwzljo2laW1QDc0o0HpTAY619ke4T6Sr+i7sM3BGnnP3tPgMcz0Z3BVSwYtDLfVq9v0i7r8aPsa18VSbZB7ZpuET6viPS9TYRNDFv6IWnY3SB08RThJpH5ggd5kEA5AYDQg4UT0OUJ7hDoLIn0WQ3QNSQoPGh2pXdaS5GO8TKh4xuFTpXn7VHbOKvxG5kU/MCDLmVM7XpghgpleoPZmTzhWjY3zIAhKfDnwhAjqX92UPMivTryoruhk6Bvy1IHTkfznwBUi89CCGjEH0Ej9r13DlxnDVxDcFxPBOp5fCnhxmBrKK6ubUAYILqZMx0Y2wBcPe9A4ZabZsCAuWJeGmTYifMPMFh//ylm+Ytnq4g+m9aV6dg8gdMhex7qZhgfVb5Wmcz3t6B8gtzyOeiFHP0NNbUF9ZDoYoaiKAUwQ7SW9A0joOljDv3LJKzyFik/sGA7kPB3Cp0t9GE3gtJU2lJHqOkq5hofcvjUKv135WSiWIa6+QG9a8pRZ53sarWCf4TdVusYj8B+tLgYs60Y4uO5G2CTd8QhHwpBsuxAiZHdKErZ8GCTnlGus3bjwD/k1u2Iyycst4GZojq57A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(376002)(346002)(396003)(136003)(230922051799003)(186009)(82310400011)(451199024)(64100799003)(1800799009)(40470700004)(46966006)(36840700001)(40460700003)(86362001)(7696005)(36756003)(41300700001)(4326008)(47076005)(2906002)(2876002)(83380400001)(1076003)(82740400003)(40480700001)(81166007)(336012)(426003)(356005)(26005)(36860700001)(2616005)(6666004)(478600001)(5660300002)(8936002)(8676002)(70206006)(70586007)(6916009)(316002)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 13:34:09.0546 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d11daea6-ba95-4b88-9b37-08dbd0a812c4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8011
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
Cc: stylon.wang@amd.com, chiahsuan.chung@amd.com, Sunpeng.Li@amd.com,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, roman.li@amd.com,
 jerry.zuo@amd.com, Aurabindo Pillai <aurabindo.pillai@amd.com>,
 hersenxs.wu@amd.com, wayne.lin@amd.com, Harry.Wentland@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Rodrigo Siqueira <rodrigo.siqueira@amd.com>

The ftrace debug feature allows filtering functions based on a prefix,
which can be helpful in some complex debug scenarios. The driver can
benefit more from this feature if the function name follows some
patterns; for this reason, this commit adds the prefix amdgpu_dm_crtc_
to all the functions that do not have it in the amdgpu_dm_crtc.c file.

Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Acked-by: Roman Li <roman.li@amd.com>
Signed-off-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_crtc.c    | 48 +++++++++----------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
index 440fc0869a34..611849e3bf91 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
@@ -95,7 +95,7 @@ bool amdgpu_dm_crtc_vrr_active(struct dm_crtc_state *dm_state)
 	       dm_state->freesync_config.state == VRR_STATE_ACTIVE_FIXED;
 }
 
-static void vblank_control_worker(struct work_struct *work)
+static void amdgpu_dm_crtc_vblank_control_worker(struct work_struct *work)
 {
 	struct vblank_control_work *vblank_work =
 		container_of(work, struct vblank_control_work, work);
@@ -144,7 +144,7 @@ static void vblank_control_worker(struct work_struct *work)
 	kfree(vblank_work);
 }
 
-static inline int dm_set_vblank(struct drm_crtc *crtc, bool enable)
+static inline int amdgpu_dm_crtc_set_vblank(struct drm_crtc *crtc, bool enable)
 {
 	struct amdgpu_crtc *acrtc = to_amdgpu_crtc(crtc);
 	struct amdgpu_device *adev = drm_to_adev(crtc->dev);
@@ -184,7 +184,7 @@ static inline int dm_set_vblank(struct drm_crtc *crtc, bool enable)
 		if (!work)
 			return -ENOMEM;
 
-		INIT_WORK(&work->work, vblank_control_worker);
+		INIT_WORK(&work->work, amdgpu_dm_crtc_vblank_control_worker);
 		work->dm = dm;
 		work->acrtc = acrtc;
 		work->enable = enable;
@@ -202,15 +202,15 @@ static inline int dm_set_vblank(struct drm_crtc *crtc, bool enable)
 
 int amdgpu_dm_crtc_enable_vblank(struct drm_crtc *crtc)
 {
-	return dm_set_vblank(crtc, true);
+	return amdgpu_dm_crtc_set_vblank(crtc, true);
 }
 
 void amdgpu_dm_crtc_disable_vblank(struct drm_crtc *crtc)
 {
-	dm_set_vblank(crtc, false);
+	amdgpu_dm_crtc_set_vblank(crtc, false);
 }
 
-static void dm_crtc_destroy_state(struct drm_crtc *crtc,
+static void amdgpu_dm_crtc_destroy_state(struct drm_crtc *crtc,
 				  struct drm_crtc_state *state)
 {
 	struct dm_crtc_state *cur = to_dm_crtc_state(state);
@@ -226,7 +226,7 @@ static void dm_crtc_destroy_state(struct drm_crtc *crtc,
 	kfree(state);
 }
 
-static struct drm_crtc_state *dm_crtc_duplicate_state(struct drm_crtc *crtc)
+static struct drm_crtc_state *amdgpu_dm_crtc_duplicate_state(struct drm_crtc *crtc)
 {
 	struct dm_crtc_state *state, *cur;
 
@@ -266,12 +266,12 @@ static void amdgpu_dm_crtc_destroy(struct drm_crtc *crtc)
 	kfree(crtc);
 }
 
-static void dm_crtc_reset_state(struct drm_crtc *crtc)
+static void amdgpu_dm_crtc_reset_state(struct drm_crtc *crtc)
 {
 	struct dm_crtc_state *state;
 
 	if (crtc->state)
-		dm_crtc_destroy_state(crtc, crtc->state);
+		amdgpu_dm_crtc_destroy_state(crtc, crtc->state);
 
 	state = kzalloc(sizeof(*state), GFP_KERNEL);
 	if (WARN_ON(!state))
@@ -291,12 +291,12 @@ static int amdgpu_dm_crtc_late_register(struct drm_crtc *crtc)
 
 /* Implemented only the options currently available for the driver */
 static const struct drm_crtc_funcs amdgpu_dm_crtc_funcs = {
-	.reset = dm_crtc_reset_state,
+	.reset = amdgpu_dm_crtc_reset_state,
 	.destroy = amdgpu_dm_crtc_destroy,
 	.set_config = drm_atomic_helper_set_config,
 	.page_flip = drm_atomic_helper_page_flip,
-	.atomic_duplicate_state = dm_crtc_duplicate_state,
-	.atomic_destroy_state = dm_crtc_destroy_state,
+	.atomic_duplicate_state = amdgpu_dm_crtc_duplicate_state,
+	.atomic_destroy_state = amdgpu_dm_crtc_destroy_state,
 	.set_crc_source = amdgpu_dm_crtc_set_crc_source,
 	.verify_crc_source = amdgpu_dm_crtc_verify_crc_source,
 	.get_crc_sources = amdgpu_dm_crtc_get_crc_sources,
@@ -309,11 +309,11 @@ static const struct drm_crtc_funcs amdgpu_dm_crtc_funcs = {
 #endif
 };
 
-static void dm_crtc_helper_disable(struct drm_crtc *crtc)
+static void amdgpu_dm_crtc_helper_disable(struct drm_crtc *crtc)
 {
 }
 
-static int count_crtc_active_planes(struct drm_crtc_state *new_crtc_state)
+static int amdgpu_dm_crtc_count_crtc_active_planes(struct drm_crtc_state *new_crtc_state)
 {
 	struct drm_atomic_state *state = new_crtc_state->state;
 	struct drm_plane *plane;
@@ -345,8 +345,8 @@ static int count_crtc_active_planes(struct drm_crtc_state *new_crtc_state)
 	return num_active;
 }
 
-static void dm_update_crtc_active_planes(struct drm_crtc *crtc,
-					 struct drm_crtc_state *new_crtc_state)
+static void amdgpu_dm_crtc_update_crtc_active_planes(struct drm_crtc *crtc,
+						     struct drm_crtc_state *new_crtc_state)
 {
 	struct dm_crtc_state *dm_new_crtc_state =
 		to_dm_crtc_state(new_crtc_state);
@@ -357,18 +357,18 @@ static void dm_update_crtc_active_planes(struct drm_crtc *crtc,
 		return;
 
 	dm_new_crtc_state->active_planes =
-		count_crtc_active_planes(new_crtc_state);
+		amdgpu_dm_crtc_count_crtc_active_planes(new_crtc_state);
 }
 
-static bool dm_crtc_helper_mode_fixup(struct drm_crtc *crtc,
+static bool amdgpu_dm_crtc_helper_mode_fixup(struct drm_crtc *crtc,
 				      const struct drm_display_mode *mode,
 				      struct drm_display_mode *adjusted_mode)
 {
 	return true;
 }
 
-static int dm_crtc_helper_atomic_check(struct drm_crtc *crtc,
-				      struct drm_atomic_state *state)
+static int amdgpu_dm_crtc_helper_atomic_check(struct drm_crtc *crtc,
+					      struct drm_atomic_state *state)
 {
 	struct drm_crtc_state *crtc_state = drm_atomic_get_new_crtc_state(state,
 										crtc);
@@ -379,7 +379,7 @@ static int dm_crtc_helper_atomic_check(struct drm_crtc *crtc,
 
 	trace_amdgpu_dm_crtc_atomic_check(crtc_state);
 
-	dm_update_crtc_active_planes(crtc, crtc_state);
+	amdgpu_dm_crtc_update_crtc_active_planes(crtc, crtc_state);
 
 	if (WARN_ON(unlikely(!dm_crtc_state->stream &&
 			amdgpu_dm_crtc_modeset_required(crtc_state, NULL, dm_crtc_state->stream)))) {
@@ -410,9 +410,9 @@ static int dm_crtc_helper_atomic_check(struct drm_crtc *crtc,
 }
 
 static const struct drm_crtc_helper_funcs amdgpu_dm_crtc_helper_funcs = {
-	.disable = dm_crtc_helper_disable,
-	.atomic_check = dm_crtc_helper_atomic_check,
-	.mode_fixup = dm_crtc_helper_mode_fixup,
+	.disable = amdgpu_dm_crtc_helper_disable,
+	.atomic_check = amdgpu_dm_crtc_helper_atomic_check,
+	.mode_fixup = amdgpu_dm_crtc_helper_mode_fixup,
 	.get_scanout_position = amdgpu_crtc_get_scanout_position,
 };
 
-- 
2.34.1

