Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B3F2CDB47E
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Oct 2023 17:43:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9925110E43A;
	Wed, 18 Oct 2023 17:43:29 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2064.outbound.protection.outlook.com [40.107.92.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6130210E43A
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Oct 2023 17:43:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NKPgmIxT8e5iDnJ0v0a7qN9ek0+txyng3eL/99J7xBEMa349DIu8Ktcr3iGhHoajKaGQEz3jLfg7ahvGwY+Sbj7wvLUGZTcRrYiSRaFtFeSZ5SrPo99Gao2cYlFvHY4YdJupTP6c5lVc1t+2UrsyAj+58VgAIzRa2HSie+hKmc0KBYJP+s0xAmvY6gvdDpvp1SO/4dlJ2DOm7TCb3c1wpP/Gf3wuaeAqFJBoMuqQg0yaFlxVbJ2aRwqMI+gVYl84kpBJwf/VYarBeXh4Bf0giHsuyvaVyN2ohxRsoQiv22xIDVriSMU5R5QpvotXnn2oco9WMk4/aHwhxqOI9mTb2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fknAXP4uRHMuCIZwcHUsugT8pc8amwFR/gFhhLEwv38=;
 b=lM/IKHlLoS1kynXB7bBUg454XgGKZ7++ruyZaQx4k1DkDIbQ8NtDsIA9CFbIurRL/kWKtdf27AN738FK5UKSRcYgTuM+EOgwi53qt1oTiIIS5NfKUZ7KqugfRd+QWS2JGe331ILl0PE4KpBs3kwmpguYR0QODUOFk5Ige4mayTeH+83p72VAouOe26E1vqKR00G0n+tc+N++k3k+qsH2XKp6Pud1A/IYX+zr65RQEE3JPs47nhdE9GpatVo0RDNCHmZKXFgmlIzbyfJoV4ZmtcfZhea70d0F0W1aX/WcABn94+Mvs3Ut7hoGo4WVMpkVrvtrnolvWLJX5WOfj7i7vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fknAXP4uRHMuCIZwcHUsugT8pc8amwFR/gFhhLEwv38=;
 b=5HYkPoM5I7MX4It1BQYgrq+fIMHL0uHOnU1RSfrFhDW/O1gGnaP6oFRRD0FXRWp5TTZrCcFEkiuZzxo7P1fwbBbp0ETL/8GZWYbTvIGKwZ16P3Ztfu9WDxOBFquGk6XxXBYBlr1Alh3km9KVLh6U7E40fO3KZii7C49GeNynRNE=
Received: from DS7P222CA0019.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:2e::12) by
 BN9PR12MB5212.namprd12.prod.outlook.com (2603:10b6:408:11d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.21; Wed, 18 Oct
 2023 17:43:25 +0000
Received: from DS1PEPF00017095.namprd03.prod.outlook.com
 (2603:10b6:8:2e:cafe::dc) by DS7P222CA0019.outlook.office365.com
 (2603:10b6:8:2e::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.24 via Frontend
 Transport; Wed, 18 Oct 2023 17:43:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017095.mail.protection.outlook.com (10.167.17.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6907.21 via Frontend Transport; Wed, 18 Oct 2023 17:43:24 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 18 Oct
 2023 12:42:55 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Wed, 18 Oct 2023 12:42:44 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 16/26] drm/amd/display: Add prefix to amdgpu crtc functions
Date: Wed, 18 Oct 2023 13:41:23 -0400
Message-ID: <20231018174133.1613439-17-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231018174133.1613439-1-Roman.Li@amd.com>
References: <20231018174133.1613439-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017095:EE_|BN9PR12MB5212:EE_
X-MS-Office365-Filtering-Correlation-Id: af3c950d-e554-4b5c-7355-08dbd001bab4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6YW1I+MGEWOrulAJFJkkuj/Lvio2GTEAS7sQqCgFx0P9kBvp8Uyo4r93f3QgATj2MvZGnqxvJTnDQMBbLHRfd4nPjVL31JYHmifcjbK5IFpIHa60KceSIWWMknoSp86TtRvVdBOrodP/X/rTtAOdy2URGJX4ySK8RCmrGCJP9KUIjD+L7tM06pkEDsVj88qFIYxPMFgcgv+YjuBuWUGztuhRwPHGti5OwyynTmKXWtta8Qe07OqlJSigpb6t7E8prhn2E07+rZwsxntqa8y9gBFdiN3vVzk9JmZqWcAHEF6lJHHghQQia6EXKc3I8SIVzGwsswHkIAh9frHoRrxfMLiEUuZ2U5Xe9ITZMKUrW2VElyelO+/RQEjr7pNdKY+fXkjiRxDZJa2gSt6SjWyoVwUSlqu7liaeOJMhXZQKMEat8IkFXpze5m564nj9TTJDPyrVs3g3JmVXVfSsuBCdZNtWJQ75w42TbBguyecLE9Ss4YcSrmy33Bk0BkoB3dmwY1SV2LKU+6DJuNHuK8Ou3Sknk+HvhXSU4HwvFWEBjXZ0fDBI1cB32VmvaQPEkTTdvlNHqbtWGfj9tpxbrvxwpmdSp9osJRQ8khpLZ30avBHu1Cw4F2429ZAPuqmQsoo90OOIuKDTh6mcFHGP9VtXxQiXqCUzhZugOJBMfLNopGeiXhfKKsggnLzdEJAKSvQrbXxEY0f6U2mlVO6qxvGNbDhLmeNhQWyr0eHxqUCAJfoHTNPvSSKou1r2aDH9CUp+affhaoS2D7B712ATIN7OBA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(136003)(39860400002)(396003)(346002)(230922051799003)(64100799003)(186009)(82310400011)(1800799009)(451199024)(46966006)(36840700001)(40470700004)(36756003)(40480700001)(40460700003)(316002)(54906003)(70586007)(6916009)(70206006)(1076003)(86362001)(81166007)(356005)(36860700001)(83380400001)(336012)(7696005)(6666004)(26005)(2616005)(426003)(82740400003)(8936002)(478600001)(2876002)(4326008)(5660300002)(47076005)(2906002)(8676002)(41300700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 17:43:24.8052 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: af3c950d-e554-4b5c-7355-08dbd001bab4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017095.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5212
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
 agustin.gutierrez@amd.com, kotarac@amd.com
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

