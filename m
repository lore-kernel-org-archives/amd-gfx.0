Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E186C4450C
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jul 2026 21:02:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F63E10F6F2;
	Thu,  9 Jul 2026 21:02:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bLtg56aP";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012025.outbound.protection.outlook.com [52.101.43.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 860D610F6ED
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Jul 2026 21:02:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ru7oSRAvxL0kvcm1Y24nwZIvynCGF96jE9d6ziqM04j25Ev9FaDyu++TkL8aa4oe7DOj/BHn4iyCDsnCR/e5laqbnOf3sRabFt0T9Tm50fIeYzGzGGoXIbLEg4v2+WIdNrv+zGT6j3zAU6MuqcnPo2Nk9r7vCFfPcRD8IuNnx3Zv4z0Fehw+y1n6Grx/DuJFoPDmkpZgRmO1NRgIZ0Fpy4UWCCQ8KzzJIxBwcanI7lvPkJGCUGmj5B2gY/6Doa3I2SrAcX3v4VaG3aZlh+bHnXzwSFfsccbz0bxEiyOak4iokgScvu1W62OIxtLNxevAmuVm1j+NEsr5iXT4uu5Lug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OAlWzdSpix5+QlY36H+SWIyF6LsY9F7ZV787Hf+ZuPI=;
 b=Hi7WQBR3xcbxnCaag40OEjvYjIHJ6ap7axletyDCqsQgQ6Tp927AiUURgQLwZM0HtfVEzAWWL34JDIwU01Z7m7Kh1D33MXdZwDolUEUvzoc/WJwcpeVeaRRs+J2TCXAYhPZnbWHXIDQsYtG2mFAJ9OBEnetx78Ye1m4FENMv3xUhulS2pEZWbUamMq4T+Zgr8BEAIlej1fWHlJXKhxIca35B398GaRDpidB2x/HNTHx1dlV1m9RHpgOYEC4K/d7ZH18fIuKldllskQXitT3hs4hNI8czBRhuu52NkDH7Ri9oSgKma20InorXEu8XyGV6Kr4re2KG5K9FJqMMhu2adQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OAlWzdSpix5+QlY36H+SWIyF6LsY9F7ZV787Hf+ZuPI=;
 b=bLtg56aPiKOHn+dkyXJS8hS1lQJe7crMaoD5KMpfArfY78kAA83Kce6Gyu03KmP/x1Zzq6Aboc+JhgcvXOJV0xn8nGym39RBAvbnfxeBrUwWde9b3SuDOX0neyU3ZtSoqjty4n9j1BCBjohuFq6k1UwuOukfdUnNQpGWcawo5OQ=
Received: from BLAPR03CA0115.namprd03.prod.outlook.com (2603:10b6:208:32a::30)
 by DM3PR12MB9413.namprd12.prod.outlook.com (2603:10b6:8:1af::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.16; Thu, 9 Jul
 2026 21:02:33 +0000
Received: from BL02EPF0001A0F9.namprd03.prod.outlook.com
 (2603:10b6:208:32a:cafe::a8) by BLAPR03CA0115.outlook.office365.com
 (2603:10b6:208:32a::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.10 via Frontend Transport; Thu, 9
 Jul 2026 21:02:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A0F9.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 9 Jul 2026 21:02:33 +0000
Received: from georzhanmkm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 9 Jul
 2026 16:02:16 -0500
From: George Zhang <george.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>,
 "George Zhang" <george.zhang@amd.com>
Subject: [PATCH 53/80] drm/amd/display: Test plane atomic check and hooks
Date: Thu, 9 Jul 2026 16:48:21 -0400
Message-ID: <20260709205936.5719-54-george.zhang@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260709205936.5719-1-george.zhang@amd.com>
References: <20260709205936.5719-1-george.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0F9:EE_|DM3PR12MB9413:EE_
X-MS-Office365-Filtering-Correlation-Id: 090cf90b-faaf-4a81-aea1-08deddfd659d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|23010399003|82310400026|1800799024|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: ogl9/DkZt0RBXOdsgovVvgYyAuXuy5YXF5uajaomiFHwLVAqj25rQgJHiRVjbE8OCVFZkEPHmYksMPf1VS1zNVBKIpVtDQQXUs8WlFU66B38CGPFebr8GdWKEyyFnO3JD3uA42DkD5P0kqKNl1dATjW5U697QmxynLjwLkRCJuloxyGHzrLVYC2/1miV45SBacc4SJh+3wo7WMZDSvY1v/6DF9LSqbmQbELgsDlvR+Nyexyo1AMov80oehJVAiX5VwsMNJegXndJu8/ASqiZ2wFw6WFupw1vArNwLV8DAYziXNAjRGZB7Pe61tkBKRNGU00UMCUUuOAZITfw2wVHcfJW0t13JUaBaRL6OdWpTpbXo/D4d9A5HE8lA788O0kh/oqaL0p6sNCYQmd177lMwLaXr888C1bpZt46aotx9T3q2ljq2KI0NCK5dDw9gfASkoOLw89Y9yIaf5IYscgI5jnUSTKcAngLRPBo6TB9ZJIuWDYd+PnVqejwtjIs7Jz5ta3viaucYAjHLUNQZZXaCcNdzH3ZLsmqv8LfXdc+c7+pX82GQTnAEF4Cfo7GKbOvRsyvKAozB/ZVYeGXlewwJq+/3mxLH2CVoFXheCbMQNPKieL/bnA+to5It5hDgj6vJO0xp+5A/Pf++wYh2SWRBcxx/1Mk9SjXUHRewImn7aTmW6TvPVSRDobXRe0dNMF+ZMqpdCQQ973aSqpTucSO8Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(23010399003)(82310400026)(1800799024)(18002099003)(22082099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: umX7d1f8BqNWG1DqPKeWJS9zbjJvHkdpEtue9WogHXpWzUvcCymUZ/lCZpRDl5hhfeppEGGerhXk/C90ujJP2aKkHz63X1+41dT0kBgTR50CPZMUSlaZTLHGAiOqbwDFwpHPhoG+N7xTCuHiUyFij+CruyRI0uv07y1wazl7vTDluwVD45RRDg7x9tt7wvKo3gOSRaCfXLAqaBZJofJTwAAiw2kUv6lHVJRKcIGFJdqehXdaMDLX8uxvUQMCGGDNWTsQY89AD6O4+mSxS8N4wLFTm/0sWoNwGbgkZUm3wdT60iHqtB7n9VVuCJw2ZNG9/z/osfBf9zW6XjBvghgpi61AEtQSDGYbQJYV94Sd7EOH90K4P7Df0ImoQdY7n6z2IMSiv2FIm9j0HpWpi/5FksYDgFuw5S7lUCwA20zcjP4cF74+jNayDAtaMMQsNFnp
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 21:02:33.4127 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 090cf90b-faaf-4a81-aea1-08deddfd659d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0F9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9413
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

From: Alex Hung <alex.hung@amd.com>

[WHAT]
Add KUnit tests for amdgpu_dm_plane_atomic_async_check(),
amdgpu_dm_plane_atomic_check(), amdgpu_dm_plane_panic_flush() and the
DRM plane reset, duplicate-state and destroy-state hooks.

Add the dm_test_init_atomic_check_state() helper and plane reset vtable
used by the new tests.

Assisted-by: Copilot:Claude-Opus-4.8 GPT-5.5
Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: George Zhang <george.zhang@amd.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_plane.c   |  25 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_plane.h   |   9 +
 .../amdgpu_dm/tests/amdgpu_dm_plane_test.c    | 457 ++++++++++++++++++
 3 files changed, 482 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
index 204b4641f07d..cc0a8e8b1ff5 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
@@ -1254,8 +1254,8 @@ int amdgpu_dm_plane_fill_dc_scaling_info(struct amdgpu_device *adev,
 }
 EXPORT_IF_KUNIT(amdgpu_dm_plane_fill_dc_scaling_info);
 
-static int amdgpu_dm_plane_atomic_check(struct drm_plane *plane,
-					struct drm_atomic_state *state)
+STATIC_IFN_KUNIT int amdgpu_dm_plane_atomic_check(struct drm_plane *plane,
+						  struct drm_atomic_state *state)
 {
 	struct drm_plane_state *new_plane_state = drm_atomic_get_new_plane_state(state,
 										 plane);
@@ -1300,9 +1300,10 @@ static int amdgpu_dm_plane_atomic_check(struct drm_plane *plane,
 
 	return -EINVAL;
 }
+EXPORT_IF_KUNIT(amdgpu_dm_plane_atomic_check);
 
-static int amdgpu_dm_plane_atomic_async_check(struct drm_plane *plane,
-					      struct drm_atomic_state *state, bool flip)
+STATIC_IFN_KUNIT int amdgpu_dm_plane_atomic_async_check(struct drm_plane *plane,
+							struct drm_atomic_state *state, bool flip)
 {
 	struct drm_crtc_state *new_crtc_state;
 	struct drm_plane_state *new_plane_state;
@@ -1324,6 +1325,7 @@ static int amdgpu_dm_plane_atomic_async_check(struct drm_plane *plane,
 
 	return 0;
 }
+EXPORT_IF_KUNIT(amdgpu_dm_plane_atomic_async_check);
 
 int amdgpu_dm_plane_get_cursor_position(struct drm_plane *plane, struct drm_crtc *crtc,
 					struct dc_cursor_position *position)
@@ -1483,7 +1485,7 @@ static void amdgpu_dm_plane_atomic_async_update(struct drm_plane *plane,
 	amdgpu_dm_plane_handle_cursor_update(plane, old_state);
 }
 
-static void amdgpu_dm_plane_panic_flush(struct drm_plane *plane)
+STATIC_IFN_KUNIT void amdgpu_dm_plane_panic_flush(struct drm_plane *plane)
 {
 	struct dm_plane_state *dm_plane_state = to_dm_plane_state(plane->state);
 	struct drm_framebuffer *fb = plane->state->fb;
@@ -1496,6 +1498,7 @@ static void amdgpu_dm_plane_panic_flush(struct drm_plane *plane)
 
 	dc_plane_force_dcc_and_tiling_disable(dc_plane_state, fb->modifier ? true : false);
 }
+EXPORT_IF_KUNIT(amdgpu_dm_plane_panic_flush);
 
 static const struct drm_plane_helper_funcs dm_plane_helper_funcs = {
 	.prepare_fb = amdgpu_dm_plane_helper_prepare_fb,
@@ -1515,7 +1518,7 @@ static const struct drm_plane_helper_funcs dm_primary_plane_helper_funcs = {
 	.panic_flush = amdgpu_dm_plane_panic_flush,
 };
 
-static void amdgpu_dm_plane_drm_plane_reset(struct drm_plane *plane)
+STATIC_IFN_KUNIT void amdgpu_dm_plane_drm_plane_reset(struct drm_plane *plane)
 {
 	struct dm_plane_state *amdgpu_state;
 
@@ -1532,8 +1535,10 @@ static void amdgpu_dm_plane_drm_plane_reset(struct drm_plane *plane)
 	amdgpu_state->shaper_tf = AMDGPU_TRANSFER_FUNCTION_DEFAULT;
 	amdgpu_state->blend_tf = AMDGPU_TRANSFER_FUNCTION_DEFAULT;
 }
+EXPORT_IF_KUNIT(amdgpu_dm_plane_drm_plane_reset);
 
-static struct drm_plane_state *amdgpu_dm_plane_drm_plane_duplicate_state(struct drm_plane *plane)
+STATIC_IFN_KUNIT struct drm_plane_state *
+amdgpu_dm_plane_drm_plane_duplicate_state(struct drm_plane *plane)
 {
 	struct dm_plane_state *dm_plane_state, *old_dm_plane_state;
 
@@ -1572,6 +1577,7 @@ static struct drm_plane_state *amdgpu_dm_plane_drm_plane_duplicate_state(struct
 
 	return &dm_plane_state->base;
 }
+EXPORT_IF_KUNIT(amdgpu_dm_plane_drm_plane_duplicate_state);
 
 STATIC_IFN_KUNIT bool amdgpu_dm_plane_format_mod_supported(struct drm_plane *plane,
 							   uint32_t format,
@@ -1636,8 +1642,8 @@ STATIC_IFN_KUNIT bool amdgpu_dm_plane_format_mod_supported(struct drm_plane *pla
 }
 EXPORT_IF_KUNIT(amdgpu_dm_plane_format_mod_supported);
 
-static void amdgpu_dm_plane_drm_plane_destroy_state(struct drm_plane *plane,
-						    struct drm_plane_state *state)
+STATIC_IFN_KUNIT void amdgpu_dm_plane_drm_plane_destroy_state(struct drm_plane *plane,
+							      struct drm_plane_state *state)
 {
 	struct dm_plane_state *dm_plane_state = to_dm_plane_state(state);
 
@@ -1657,6 +1663,7 @@ static void amdgpu_dm_plane_drm_plane_destroy_state(struct drm_plane *plane,
 
 	drm_atomic_helper_plane_destroy_state(plane, state);
 }
+EXPORT_IF_KUNIT(amdgpu_dm_plane_drm_plane_destroy_state);
 
 #ifdef AMD_PRIVATE_COLOR
 static void
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.h
index 911fb2d73e22..be82e371bc08 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.h
@@ -115,5 +115,14 @@ void amdgpu_dm_plane_get_min_max_dc_plane_scaling(struct drm_device *dev,
 						  struct drm_framebuffer *fb,
 						  int *min_downscale,
 						  int *max_upscale);
+int amdgpu_dm_plane_atomic_async_check(struct drm_plane *plane,
+				       struct drm_atomic_state *state, bool flip);
+int amdgpu_dm_plane_atomic_check(struct drm_plane *plane,
+				 struct drm_atomic_state *state);
+void amdgpu_dm_plane_panic_flush(struct drm_plane *plane);
+void amdgpu_dm_plane_drm_plane_reset(struct drm_plane *plane);
+struct drm_plane_state *amdgpu_dm_plane_drm_plane_duplicate_state(struct drm_plane *plane);
+void amdgpu_dm_plane_drm_plane_destroy_state(struct drm_plane *plane,
+					     struct drm_plane_state *state);
 #endif
 #endif
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_plane_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_plane_test.c
index f36c5c139554..eb15de64aa78 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_plane_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_plane_test.c
@@ -2726,6 +2726,446 @@ static void dm_test_format_mod_supported_d_swizzle_reject(struct kunit *test)
 								listed_mod));
 }
 
+/**
+ * dm_test_atomic_async_check_rejects() - Verify async check rejections.
+ * @test: KUnit test context.
+ *
+ * Verify if async flip on non-overlay planes and async cursor update on
+ * non-cursor planes are rejected.
+ */
+static void dm_test_atomic_async_check_rejects(struct kunit *test)
+{
+	struct drm_plane *plane;
+
+	plane = kunit_kzalloc(test, sizeof(*plane), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, plane);
+
+	plane->type = DRM_PLANE_TYPE_PRIMARY;
+	KUNIT_EXPECT_EQ(test,
+			amdgpu_dm_plane_atomic_async_check(plane, NULL, true),
+			-EINVAL);
+	KUNIT_EXPECT_EQ(test,
+			amdgpu_dm_plane_atomic_async_check(plane, NULL, false),
+			-EINVAL);
+}
+
+/**
+ * dm_test_atomic_async_check_overlay_cursor() - Verify overlay cursor rejection.
+ * @test: KUnit test context.
+ *
+ * Verify if async cursor updates are rejected while the CRTC is using an
+ * overlay cursor mode.
+ */
+static void dm_test_atomic_async_check_overlay_cursor(struct kunit *test)
+{
+	struct drm_atomic_state *state;
+	struct __drm_planes_state *planes;
+	struct __drm_crtcs_state *crtcs;
+	struct drm_plane *plane;
+	struct drm_plane_state *plane_state;
+	struct drm_crtc *crtc;
+	struct dm_crtc_state *dm_crtc_state;
+
+	state = kunit_kzalloc(test, sizeof(*state), GFP_KERNEL);
+	planes = kunit_kzalloc(test, sizeof(*planes), GFP_KERNEL);
+	crtcs = kunit_kzalloc(test, sizeof(*crtcs), GFP_KERNEL);
+	plane = kunit_kzalloc(test, sizeof(*plane), GFP_KERNEL);
+	plane_state = kunit_kzalloc(test, sizeof(*plane_state), GFP_KERNEL);
+	crtc = kunit_kzalloc(test, sizeof(*crtc), GFP_KERNEL);
+	dm_crtc_state = kunit_kzalloc(test, sizeof(*dm_crtc_state), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, state);
+	KUNIT_ASSERT_NOT_NULL(test, planes);
+	KUNIT_ASSERT_NOT_NULL(test, crtcs);
+	KUNIT_ASSERT_NOT_NULL(test, plane);
+	KUNIT_ASSERT_NOT_NULL(test, plane_state);
+	KUNIT_ASSERT_NOT_NULL(test, crtc);
+	KUNIT_ASSERT_NOT_NULL(test, dm_crtc_state);
+
+	plane->type = DRM_PLANE_TYPE_CURSOR;
+	plane->index = 0;
+	crtc->index = 0;
+	plane_state->crtc = crtc;
+	dm_crtc_state->cursor_mode = DM_CURSOR_OVERLAY_MODE;
+	state->planes = planes;
+	state->crtcs = crtcs;
+	state->planes[0].new_state = plane_state;
+	state->crtcs[0].new_state = &dm_crtc_state->base;
+
+	KUNIT_EXPECT_EQ(test,
+			amdgpu_dm_plane_atomic_async_check(plane, state, false),
+			-EINVAL);
+
+	dm_crtc_state->cursor_mode = DM_CURSOR_NATIVE_MODE;
+	KUNIT_EXPECT_EQ(test,
+			amdgpu_dm_plane_atomic_async_check(plane, state, false),
+			0);
+}
+
+static struct amdgpu_device *dm_test_init_atomic_check_state(struct kunit *test,
+							     struct drm_atomic_state **state,
+							     struct drm_plane **plane,
+							     struct dm_plane_state **dm_plane_state,
+							     struct drm_crtc_state **new_crtc_state,
+							     struct drm_framebuffer **fb)
+{
+	struct amdgpu_device *adev;
+	struct dc *dc;
+	struct __drm_planes_state *planes;
+	struct __drm_crtcs_state *crtcs;
+	struct dc_plane_state *dc_plane_state;
+	struct drm_crtc *crtc;
+
+	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
+	dc = kunit_kzalloc(test, sizeof(*dc), GFP_KERNEL);
+	*state = kunit_kzalloc(test, sizeof(**state), GFP_KERNEL);
+	planes = kunit_kzalloc(test, sizeof(*planes), GFP_KERNEL);
+	crtcs = kunit_kzalloc(test, sizeof(*crtcs), GFP_KERNEL);
+	*plane = kunit_kzalloc(test, sizeof(**plane), GFP_KERNEL);
+	*dm_plane_state = kunit_kzalloc(test, sizeof(**dm_plane_state), GFP_KERNEL);
+	dc_plane_state = kunit_kzalloc(test, sizeof(*dc_plane_state), GFP_KERNEL);
+	crtc = kunit_kzalloc(test, sizeof(*crtc), GFP_KERNEL);
+	*new_crtc_state = kunit_kzalloc(test, sizeof(**new_crtc_state), GFP_KERNEL);
+	*fb = kunit_kzalloc(test, sizeof(**fb), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, adev);
+	KUNIT_ASSERT_NOT_NULL(test, dc);
+	KUNIT_ASSERT_NOT_NULL(test, *state);
+	KUNIT_ASSERT_NOT_NULL(test, planes);
+	KUNIT_ASSERT_NOT_NULL(test, crtcs);
+	KUNIT_ASSERT_NOT_NULL(test, *plane);
+	KUNIT_ASSERT_NOT_NULL(test, *dm_plane_state);
+	KUNIT_ASSERT_NOT_NULL(test, dc_plane_state);
+	KUNIT_ASSERT_NOT_NULL(test, crtc);
+	KUNIT_ASSERT_NOT_NULL(test, *new_crtc_state);
+	KUNIT_ASSERT_NOT_NULL(test, *fb);
+
+	adev->dm.dc = dc;
+	dc->caps.planes[0].max_upscale_factor.argb8888 = 1000;
+	dc->caps.planes[0].max_downscale_factor.argb8888 = 1000;
+	dc->caps.planes[0].max_upscale_factor.nv12 = 1000;
+	dc->caps.planes[0].max_downscale_factor.nv12 = 1000;
+
+	(*plane)->dev = &adev->ddev;
+	(*plane)->index = 0;
+	(*plane)->type = DRM_PLANE_TYPE_OVERLAY;
+	(*plane)->name = "kunit-plane";
+	crtc->dev = &adev->ddev;
+	crtc->index = 0;
+	(*fb)->width = 100;
+	(*fb)->height = 100;
+	(*fb)->format = drm_format_info(DRM_FORMAT_XRGB8888);
+	KUNIT_ASSERT_NOT_NULL(test, (*fb)->format);
+
+	(*dm_plane_state)->base.plane = *plane;
+	(*dm_plane_state)->base.state = *state;
+	(*dm_plane_state)->base.crtc = crtc;
+	(*dm_plane_state)->base.fb = *fb;
+	(*dm_plane_state)->base.src_w = 100 << 16;
+	(*dm_plane_state)->base.src_h = 100 << 16;
+	(*dm_plane_state)->base.crtc_w = 100;
+	(*dm_plane_state)->base.crtc_h = 100;
+	(*dm_plane_state)->dc_state = dc_plane_state;
+
+	(*new_crtc_state)->crtc = crtc;
+	(*new_crtc_state)->enable = true;
+	(*new_crtc_state)->mode.crtc_hdisplay = 1920;
+	(*new_crtc_state)->mode.crtc_vdisplay = 1080;
+
+	(*state)->planes = planes;
+	(*state)->crtcs = crtcs;
+	(*state)->planes[0].new_state = &(*dm_plane_state)->base;
+	(*state)->crtcs[0].new_state = *new_crtc_state;
+
+	return adev;
+}
+
+/**
+ * dm_test_atomic_check_no_dc_state() - Verify missing DC plane state succeeds.
+ * @test: KUnit test context.
+ *
+ * Verify if atomic_check exits before deeper validation when the DM plane state
+ * has no DC plane state attached.
+ */
+static void dm_test_atomic_check_no_dc_state(struct kunit *test)
+{
+	struct amdgpu_device *adev;
+	struct drm_atomic_state *state;
+	struct __drm_planes_state *planes;
+	struct drm_plane *plane;
+	struct dm_plane_state *dm_plane_state;
+
+	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
+	state = kunit_kzalloc(test, sizeof(*state), GFP_KERNEL);
+	planes = kunit_kzalloc(test, sizeof(*planes), GFP_KERNEL);
+	plane = kunit_kzalloc(test, sizeof(*plane), GFP_KERNEL);
+	dm_plane_state = kunit_kzalloc(test, sizeof(*dm_plane_state), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, adev);
+	KUNIT_ASSERT_NOT_NULL(test, state);
+	KUNIT_ASSERT_NOT_NULL(test, planes);
+	KUNIT_ASSERT_NOT_NULL(test, plane);
+	KUNIT_ASSERT_NOT_NULL(test, dm_plane_state);
+
+	plane->dev = &adev->ddev;
+	plane->index = 0;
+	dm_plane_state->base.plane = plane;
+	state->planes = planes;
+	state->planes[0].new_state = &dm_plane_state->base;
+
+	KUNIT_EXPECT_EQ(test, amdgpu_dm_plane_atomic_check(plane, state), 0);
+}
+
+/**
+ * dm_test_atomic_check_missing_crtc_state() - Verify missing CRTC state fails.
+ * @test: KUnit test context.
+ *
+ * Verify if atomic_check rejects a plane with DC state when the atomic CRTC
+ * state is absent.
+ */
+static void dm_test_atomic_check_missing_crtc_state(struct kunit *test)
+{
+	struct amdgpu_device *adev;
+	struct drm_atomic_state *state;
+	struct __drm_planes_state *planes;
+	struct __drm_crtcs_state *crtcs;
+	struct drm_plane *plane;
+	struct dm_plane_state *dm_plane_state;
+	struct dc_plane_state *dc_plane_state;
+	struct drm_crtc *crtc;
+
+	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
+	state = kunit_kzalloc(test, sizeof(*state), GFP_KERNEL);
+	planes = kunit_kzalloc(test, sizeof(*planes), GFP_KERNEL);
+	crtcs = kunit_kzalloc(test, sizeof(*crtcs), GFP_KERNEL);
+	plane = kunit_kzalloc(test, sizeof(*plane), GFP_KERNEL);
+	dm_plane_state = kunit_kzalloc(test, sizeof(*dm_plane_state), GFP_KERNEL);
+	dc_plane_state = kunit_kzalloc(test, sizeof(*dc_plane_state), GFP_KERNEL);
+	crtc = kunit_kzalloc(test, sizeof(*crtc), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, adev);
+	KUNIT_ASSERT_NOT_NULL(test, state);
+	KUNIT_ASSERT_NOT_NULL(test, planes);
+	KUNIT_ASSERT_NOT_NULL(test, crtcs);
+	KUNIT_ASSERT_NOT_NULL(test, plane);
+	KUNIT_ASSERT_NOT_NULL(test, dm_plane_state);
+	KUNIT_ASSERT_NOT_NULL(test, dc_plane_state);
+	KUNIT_ASSERT_NOT_NULL(test, crtc);
+
+	plane->dev = &adev->ddev;
+	plane->index = 0;
+	crtc->index = 0;
+	dm_plane_state->base.plane = plane;
+	dm_plane_state->base.crtc = crtc;
+	dm_plane_state->dc_state = dc_plane_state;
+	state->planes = planes;
+	state->crtcs = crtcs;
+	state->planes[0].new_state = &dm_plane_state->base;
+
+	KUNIT_EXPECT_EQ(test, amdgpu_dm_plane_atomic_check(plane, state), -EINVAL);
+}
+
+/**
+ * dm_test_atomic_check_helper_failure() - Verify helper-check failures return.
+ * @test: KUnit test context.
+ *
+ * Verify if atomic_check returns before DC validation when the DRM helper state
+ * validation rejects the plane.
+ */
+static void dm_test_atomic_check_helper_failure(struct kunit *test)
+{
+	struct drm_atomic_state *state;
+	struct drm_plane *plane;
+	struct dm_plane_state *dm_plane_state;
+	struct drm_crtc_state *new_crtc_state;
+	struct drm_framebuffer *fb;
+
+	dm_test_init_atomic_check_state(test, &state, &plane, &dm_plane_state,
+					&new_crtc_state, &fb);
+	dm_plane_state->base.crtc_w = 10;
+
+	KUNIT_EXPECT_EQ(test, amdgpu_dm_plane_atomic_check(plane, state), -EINVAL);
+}
+
+/**
+ * dm_test_atomic_check_color_pipeline_conflict() - Verify color conflict rejection.
+ * @test: KUnit test context.
+ *
+ * Verify if atomic_check rejects use of both plane COLOR_PIPELINE and CRTC
+ * DEGAMMA_LUT before DC validation.
+ */
+static void dm_test_atomic_check_color_pipeline_conflict(struct kunit *test)
+{
+	struct drm_atomic_state *state;
+	struct drm_plane *plane;
+	struct dm_plane_state *dm_plane_state;
+	struct drm_crtc_state *new_crtc_state;
+	struct drm_framebuffer *fb;
+	void *color_pipeline;
+	void *degamma_lut;
+
+	dm_test_init_atomic_check_state(test, &state, &plane, &dm_plane_state,
+					&new_crtc_state, &fb);
+	color_pipeline = kunit_kzalloc(test, 1, GFP_KERNEL);
+	degamma_lut = kunit_kzalloc(test, 1, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, color_pipeline);
+	KUNIT_ASSERT_NOT_NULL(test, degamma_lut);
+
+	dm_plane_state->base.color_pipeline = color_pipeline;
+	new_crtc_state->degamma_lut = degamma_lut;
+
+	KUNIT_EXPECT_EQ(test, amdgpu_dm_plane_atomic_check(plane, state), -EINVAL);
+}
+
+/**
+ * dm_test_atomic_check_scaling_failure() - Verify scaling-info failures return.
+ * @test: KUnit test context.
+ *
+ * Verify if atomic_check returns the scaling-info error before DC validation.
+ */
+static void dm_test_atomic_check_scaling_failure(struct kunit *test)
+{
+	struct amdgpu_device *adev;
+	struct drm_atomic_state *state;
+	struct drm_plane *plane;
+	struct dm_plane_state *dm_plane_state;
+	struct drm_crtc_state *new_crtc_state;
+	struct drm_framebuffer *fb;
+
+	adev = dm_test_init_atomic_check_state(test, &state, &plane, &dm_plane_state,
+					       &new_crtc_state, &fb);
+	adev->ip_versions[DCE_HWIP][0] = IP_VERSION(1, 0, 0);
+	fb->width = 200;
+	fb->format = drm_format_info(DRM_FORMAT_NV12);
+	KUNIT_ASSERT_NOT_NULL(test, fb->format);
+	dm_plane_state->base.src_x = 1 << 16;
+
+	KUNIT_EXPECT_EQ(test, amdgpu_dm_plane_atomic_check(plane, state), -EINVAL);
+}
+
+/**
+ * dm_test_panic_flush_no_dc_state() - Verify panic flush exits without DC state.
+ * @test: KUnit test context.
+ *
+ * Verify if panic_flush returns without dereferencing DC state when the current
+ * plane state has no DC plane state attached.
+ */
+static void dm_test_panic_flush_no_dc_state(struct kunit *test)
+{
+	struct drm_plane *plane;
+	struct dm_plane_state *dm_plane_state;
+
+	plane = kunit_kzalloc(test, sizeof(*plane), GFP_KERNEL);
+	dm_plane_state = kunit_kzalloc(test, sizeof(*dm_plane_state), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, plane);
+	KUNIT_ASSERT_NOT_NULL(test, dm_plane_state);
+
+	plane->state = &dm_plane_state->base;
+
+	amdgpu_dm_plane_panic_flush(plane);
+}
+
+static const struct drm_plane_funcs dm_test_plane_reset_funcs = {
+	.atomic_destroy_state = amdgpu_dm_plane_drm_plane_destroy_state,
+};
+
+/**
+ * dm_test_plane_reset_initializes_state() - Verify reset installs default state.
+ * @test: KUnit test context.
+ *
+ * Verify amdgpu_dm_plane_drm_plane_reset() destroys the existing plane state,
+ * allocates a fresh dm_plane_state, and initializes the AMD-specific transfer
+ * function and HDR multiplier defaults.
+ */
+static void dm_test_plane_reset_initializes_state(struct kunit *test)
+{
+	struct dm_plane_state *old_state;
+	struct dm_plane_state *new_state;
+	struct drm_plane *plane;
+
+	plane = kunit_kzalloc(test, sizeof(*plane), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, plane);
+
+	/*
+	 * Provide an existing state plus a funcs table so reset exercises the
+	 * destroy-existing-state path. The destroy hook frees this state, so it
+	 * must be a plain (non-KUnit-managed) allocation.
+	 */
+	old_state = kzalloc(sizeof(*old_state), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, old_state);
+	plane->funcs = &dm_test_plane_reset_funcs;
+	plane->state = &old_state->base;
+
+	amdgpu_dm_plane_drm_plane_reset(plane);
+
+	KUNIT_ASSERT_NOT_NULL(test, plane->state);
+	new_state = to_dm_plane_state(plane->state);
+	KUNIT_EXPECT_EQ(test, new_state->degamma_tf, AMDGPU_TRANSFER_FUNCTION_DEFAULT);
+	KUNIT_EXPECT_EQ(test, new_state->hdr_mult, AMDGPU_HDR_MULT_DEFAULT);
+	KUNIT_EXPECT_EQ(test, new_state->shaper_tf, AMDGPU_TRANSFER_FUNCTION_DEFAULT);
+	KUNIT_EXPECT_EQ(test, new_state->blend_tf, AMDGPU_TRANSFER_FUNCTION_DEFAULT);
+
+	kfree(new_state);
+}
+
+/**
+ * dm_test_plane_duplicate_state_copies_fields() - Verify state duplication.
+ * @test: KUnit test context.
+ *
+ * Verify amdgpu_dm_plane_drm_plane_duplicate_state() allocates a new state and
+ * copies the transfer-function and HDR-multiplier fields from the current
+ * plane state when no DC state or color blob is attached.
+ */
+static void dm_test_plane_duplicate_state_copies_fields(struct kunit *test)
+{
+	struct dm_plane_state *old_state;
+	struct drm_plane_state *dup_base;
+	struct dm_plane_state *dup_state;
+	struct drm_plane *plane;
+
+	plane = kunit_kzalloc(test, sizeof(*plane), GFP_KERNEL);
+	old_state = kunit_kzalloc(test, sizeof(*old_state), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, plane);
+	KUNIT_ASSERT_NOT_NULL(test, old_state);
+
+	old_state->degamma_tf = AMDGPU_TRANSFER_FUNCTION_PQ_EOTF;
+	old_state->hdr_mult = 0x123456789ULL;
+	old_state->shaper_tf = AMDGPU_TRANSFER_FUNCTION_IDENTITY;
+	old_state->blend_tf = AMDGPU_TRANSFER_FUNCTION_SRGB_EOTF;
+	plane->state = &old_state->base;
+
+	dup_base = amdgpu_dm_plane_drm_plane_duplicate_state(plane);
+	KUNIT_ASSERT_NOT_NULL(test, dup_base);
+
+	dup_state = to_dm_plane_state(dup_base);
+	KUNIT_EXPECT_EQ(test, dup_state->degamma_tf, AMDGPU_TRANSFER_FUNCTION_PQ_EOTF);
+	KUNIT_EXPECT_EQ(test, dup_state->hdr_mult, 0x123456789ULL);
+	KUNIT_EXPECT_EQ(test, dup_state->shaper_tf, AMDGPU_TRANSFER_FUNCTION_IDENTITY);
+	KUNIT_EXPECT_EQ(test, dup_state->blend_tf, AMDGPU_TRANSFER_FUNCTION_SRGB_EOTF);
+	KUNIT_EXPECT_NULL(test, dup_state->dc_state);
+
+	kfree(dup_state);
+}
+
+/**
+ * dm_test_plane_destroy_state_minimal() - Verify destroy of a minimal state.
+ * @test: KUnit test context.
+ *
+ * Verify amdgpu_dm_plane_drm_plane_destroy_state() tears down a plane state
+ * that has no color blobs or DC plane state attached without dereferencing
+ * NULL resources.
+ */
+static void dm_test_plane_destroy_state_minimal(struct kunit *test)
+{
+	struct dm_plane_state *dm_plane_state;
+	struct drm_plane *plane;
+
+	plane = kunit_kzalloc(test, sizeof(*plane), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, plane);
+
+	/* destroy_state frees the state itself, so use a plain allocation. */
+	dm_plane_state = kzalloc(sizeof(*dm_plane_state), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, dm_plane_state);
+
+	amdgpu_dm_plane_drm_plane_destroy_state(plane, &dm_plane_state->base);
+}
+
 static struct kunit_case amdgpu_dm_plane_test_cases[] = {
 	/* amdgpu_dm_plane_is_video_format() */
 	KUNIT_CASE(dm_test_plane_is_video_format_known_video),
@@ -2790,6 +3230,23 @@ static struct kunit_case amdgpu_dm_plane_test_cases[] = {
 	KUNIT_CASE(dm_test_helper_check_state_small_viewport_height),
 	KUNIT_CASE(dm_test_helper_check_state_bottom_clipped_height),
 	KUNIT_CASE(dm_test_helper_check_state_scaling_caps),
+	/* amdgpu_dm_plane_atomic_async_check() */
+	KUNIT_CASE(dm_test_atomic_async_check_rejects),
+	KUNIT_CASE(dm_test_atomic_async_check_overlay_cursor),
+	/* amdgpu_dm_plane_atomic_check() */
+	KUNIT_CASE(dm_test_atomic_check_no_dc_state),
+	KUNIT_CASE(dm_test_atomic_check_missing_crtc_state),
+	KUNIT_CASE(dm_test_atomic_check_helper_failure),
+	KUNIT_CASE(dm_test_atomic_check_color_pipeline_conflict),
+	KUNIT_CASE(dm_test_atomic_check_scaling_failure),
+	/* amdgpu_dm_plane_panic_flush() */
+	KUNIT_CASE(dm_test_panic_flush_no_dc_state),
+	/* amdgpu_dm_plane_drm_plane_reset() */
+	KUNIT_CASE(dm_test_plane_reset_initializes_state),
+	/* amdgpu_dm_plane_drm_plane_duplicate_state() */
+	KUNIT_CASE(dm_test_plane_duplicate_state_copies_fields),
+	/* amdgpu_dm_plane_drm_plane_destroy_state() */
+	KUNIT_CASE(dm_test_plane_destroy_state_minimal),
 	/* amdgpu_dm_plane_add_modifier() */
 	KUNIT_CASE(dm_test_add_modifier_appends_value),
 	KUNIT_CASE(dm_test_add_modifier_grows_capacity),
-- 
2.55.0

