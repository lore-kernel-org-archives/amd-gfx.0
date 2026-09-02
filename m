Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFBE6C61DD6
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Sep 2026 05:05:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D42310E466;
	Wed,  2 Sep 2026 05:05:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hnz7RG8l";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010022.outbound.protection.outlook.com [52.101.61.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B4E9F10E455
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Sep 2026 05:05:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jxKOmeuhlCgGNxG/ZkHWUaILnQYDXr/ubh+AiLbHAibiXSydFQlLWEAUXX8EVWPLSunYIBjxm3NjROK1snoCA82+NlroUNVNLU6JJggl/wCcqPWdA/d8kpdS8bYkwzX6dXFcCuzU57LZPxAc+Ovx/AjucyTPsoGCd4wsTu5FLJCmLKgS6rmTynzJTFIN9AErpVoodbHUtsPGZOqf3mfgUbXXeQ8INUSkTOw75yIPxyq1hCPoz9zRJMSTwnj8R3Ht5p68VtgExjku9i/Utx9DwWvn0xP05i/qVymNTha+AtUEOuqHF2i8hR9q7KES+tP3nK/dF8R+7Xwdsdjjgu7c1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ltd5Y1S+wEQzC5dt2jJcrdhwdcqbiPHBjhRI5lWUV4k=;
 b=sea2uccAyZesg3rwsiOC4Jlushp99UxWqiCJj1qRwMVFar+LrlI3SNpgxn9BhjYo1EI2EPc0FhkN0VPYoutVBkdt3+9iv2rhLYpCUOI+NzpGsn9CSY4qbVWaCb8gCb2wwvTkY8K91h9tGeGg3pPhkNbfBAfgwV9Kj0mp0HUU/XNJBDdtGgiGHYQQF0gxb79tzRi9GTE0xWWmlIq3tGD8SHOrea0Iu7fI4N30j4DROEHT7gkL2HULh6gvH1EW9Ut8iNuS30y/qIDR/QXgJTL8sorfymic5/wGr7EZmRvMai7J2CKQ8fhK5CUdcYLM3eg25FvYfomXpWBLXnBVs2lF6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ltd5Y1S+wEQzC5dt2jJcrdhwdcqbiPHBjhRI5lWUV4k=;
 b=hnz7RG8loeH3r/uYhfbXBBtBxxRG5R/8Wg6BHEfnw2z1Fugvs2KlJv89lcSEzVuxhlTxjyGSUaL84Zp4olV+PQouFSskJdwUnpoIbAoGNCvBXjh1+6OKV7oZ5Fbk8mjgI9fPaWisVlidWwYmP0RVcgblBf1xyVMlWpNaQNVjIqk=
Received: from CH2PR04CA0013.namprd04.prod.outlook.com (2603:10b6:610:52::23)
 by PH0PR12MB7789.namprd12.prod.outlook.com (2603:10b6:510:283::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 05:04:55 +0000
Received: from CH3PEPF0000000D.namprd04.prod.outlook.com
 (2603:10b6:610:52:cafe::4e) by CH2PR04CA0013.outlook.office365.com
 (2603:10b6:610:52::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.10 via Frontend Transport; Wed, 2
 Sep 2026 05:04:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF0000000D.mail.protection.outlook.com (10.167.244.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Wed, 2 Sep 2026 05:04:54 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 2 Sep
 2026 00:04:52 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 2 Sep
 2026 00:04:50 -0500
Received: from ray-Ubuntu.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Wed, 2 Sep 2026 00:04:41 -0500
From: Ray Wu <ray.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>, Ray Wu
 <ray.wu@amd.com>
Subject: [PATCH 03/40] drm/amd/display: Test vblank IRQ handling
Date: Wed, 2 Sep 2026 12:58:25 +0800
Message-ID: <20260902050411.3473916-4-ray.wu@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260902050411.3473916-1-ray.wu@amd.com>
References: <20260902050411.3473916-1-ray.wu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000D:EE_|PH0PR12MB7789:EE_
X-MS-Office365-Filtering-Correlation-Id: 14b1f610-7839-4604-43aa-08df08afba24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|30052699003|36860700016|376014|82310400026|23010399003|1800799024|11063799006|10067099003|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: kfzMhhCO9hnDIeYVu/UF/f30PhaAbj+Em0V4DFSHLRXInrOv4WnhYYHusDaCjbRJUV6vDzS/jR1FDQLfkB5S3QK6Js0A1VkYmf9+UBEBsgogXxBqV7Rh9+edosMDKfDbopd69RbwAuj/UvcSlwzqcxtRHQucnIkZT0/JBdHmhEncC/5KJLB8IZ3UlfOMfi3wSJbvIKUrnLC/NjD0720BZJnof9+8YYPSAwZXogH4kiqP24bV61iyYREymKIEgGSKmC5A9v4XznlkhAG/WVYFMd0XYc1RszWOIIofLuFdzr1EVis3HItpRc5QgnM3vRl9MicJTKpY8B+m2UMnN1wwVEwkWANQeE6d3vVmQkza7rO29b5tB4IjoPHOo2VHa49A9Rw2eAFp27DnoTXYLv0Luwjw+ZycUTvJ6Ztw/unLiZL1oLscFu7sY5kST6c85tE7EjhCowCtj02wOaanQtlc8wQDswhRp5Tu27DfmYmNIGjQt6vQUasNkd7hjRUX+kjfxKexISKm05ggV4lcXwc+FRKq7L+cDH4xEItOFz8yNce2f7oMa5An5enFlSFYivDeHvsR+YzRm14196WdN29ewEl9hKyzAIUAtC2kf0JBjgr4s4bwVZPl0La5S7JOTaLyORqToAztud2aZ3DAx24nWrMVpwSoR2y9PAA493PgobhBD2ak/O5QRJlnn5RpbAv6Yu7Sz93DVNKqBHWM2jj5DQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(30052699003)(36860700016)(376014)(82310400026)(23010399003)(1800799024)(11063799006)(10067099003)(22082099003)(18002099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: AN3M44XbP93UQdpQFO3EU2taQdmY3ugPU/H2afDAS091gBgyPS7EuCW4YWx0WgB55PMvx898+MaVuQTCNrwc5E6WOSMh5prrlc0LwEKl1kM9fkuQw9rAo7a4JKzWTuc2hR4MagH+SxWBX9Cb5WI80rZ2rhScuf2OmP60/K9BAQOdSrzWhRpgo4ztwxo7Aw4as54KaczhYyREYpbCsKePSMMIR14+g6Hfjr7BRxMTQU6sqv9Abr3RtoACqkJwtPQqzNb+23HD8n6oyjAfdOKP8eAjqJdSpXXY6kITdAYT9sPe2+SQIOSpSFwBLh6K0LVOl1kt9hRv5f9PySuH645ILD0q7pq1mJNv5z6+YVzst6ubxinlvEZlep3voeoEsb+hZcBbZVHR9O/jqP7m/43lpnMA48VfiLTVzXDAbGAFe3QCN5d6NnoOuw6j/k1r4G8x
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 05:04:54.4587 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 14b1f610-7839-4604-43aa-08df08afba24
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7789
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

[Why]
Add KUnit tests for manage_dm_interrupts(), covering the off delay
derived from the stream timing, the 30ms fallback, the DCN3.5 APU
instant off, and the vblank disable path.

[How]
The IRQ subsystem is not installed, so amdgpu_irq_get() and
amdgpu_irq_put() only report the missing source; the point is that the
affected DCN versions request it at all.

Assisted-by: Copilot:Claude-Opus-5 GPT-5.6 Sol
Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |   7 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |   2 +
 .../display/amdgpu_dm/tests/amdgpu_dm_test.c  | 116 ++++++++++++++++++
 3 files changed, 122 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index f49cc198fb0d..e793dd0426b1 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -3374,9 +3374,9 @@ STATIC_IFN_KUNIT int dm_update_mst_vcpi_slots_for_dsc(struct drm_atomic_commit *
 }
 EXPORT_IF_KUNIT(dm_update_mst_vcpi_slots_for_dsc);
 
-static void manage_dm_interrupts(struct amdgpu_device *adev,
-				 struct amdgpu_crtc *acrtc,
-				 struct dm_crtc_state *acrtc_state)
+STATIC_IFN_KUNIT void manage_dm_interrupts(struct amdgpu_device *adev,
+					   struct amdgpu_crtc *acrtc,
+					   struct dm_crtc_state *acrtc_state)
 {	/*
 	 * We cannot be sure that the frontend index maps to the same
 	 * backend index - some even map to more than one.
@@ -3455,6 +3455,7 @@ static void manage_dm_interrupts(struct amdgpu_device *adev,
 		drm_crtc_vblank_off(&acrtc->base);
 	}
 }
+EXPORT_IF_KUNIT(manage_dm_interrupts);
 
 STATIC_IFN_KUNIT void dm_update_pflip_irq_state(struct amdgpu_device *adev,
 						struct amdgpu_crtc *acrtc)
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index 089741ba0619..ad72dc182e93 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -1264,6 +1264,8 @@ int fill_dc_plane_info_and_addr(struct amdgpu_device *adev,
 				struct dc_plane_address *address, bool tmz_surface);
 int dm_update_mst_vcpi_slots_for_dsc(struct drm_atomic_commit *state, struct dc_state *dc_state,
 				     struct dsc_mst_fairness_vars *vars);
+void manage_dm_interrupts(struct amdgpu_device *adev, struct amdgpu_crtc *acrtc,
+			  struct dm_crtc_state *acrtc_state);
 int load_dmcu_fw(struct amdgpu_device *adev);
 int dm_sw_init(struct amdgpu_ip_block *ip_block);
 int dm_late_init(struct amdgpu_ip_block *ip_block);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c
index a67774e6db36..4daa187fbd0a 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c
@@ -3803,6 +3803,117 @@ static void dm_test_plane_info_layer_and_blending(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, ctx->plane_info.global_alpha_value, 0x7f);
 }
 
+/* Tests for manage_dm_interrupts() */
+
+struct dm_test_irq_mgmt_ctx {
+	struct amdgpu_device *adev;
+	struct amdgpu_crtc *acrtc;
+	struct dm_crtc_state *acrtc_state;
+};
+
+/*
+ * A CRTC with a single initialised vblank and a 1080p60 stream timing, which
+ * is what the vblank off-delay estimate is derived from.
+ */
+static struct dm_test_irq_mgmt_ctx *dm_test_irq_mgmt_ctx_alloc(struct kunit *test)
+{
+	struct dm_test_irq_mgmt_ctx *ctx;
+	struct dc_crtc_timing *timing;
+
+	ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ctx);
+
+	ctx->adev = dm_kunit_alloc_adev(test);
+	KUNIT_ASSERT_EQ(test, drm_vblank_init(&ctx->adev->ddev, 1), 0);
+
+	ctx->acrtc = kunit_kzalloc(test, sizeof(*ctx->acrtc), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ctx->acrtc);
+	ctx->acrtc_state = kunit_kzalloc(test, sizeof(*ctx->acrtc_state), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ctx->acrtc_state);
+
+	ctx->adev->mode_info.num_crtc = 1;
+	ctx->acrtc->base.dev = &ctx->adev->ddev;
+	ctx->acrtc->crtc_id = 0;
+
+	ctx->acrtc_state->stream = dm_kunit_alloc_stream(test, NULL);
+	timing = &ctx->acrtc_state->stream->timing;
+	timing->h_total = 2200;
+	timing->v_total = 1125;
+	timing->pix_clk_100hz = 1485000;
+
+	return ctx;
+}
+
+/**
+ * dm_test_manage_interrupts_offdelay - Test the off delay is derived from timing
+ * @test: The KUnit test context
+ *
+ * DCN3.0 also takes the extra vupdate reference. The IRQ subsystem is not
+ * installed, so amdgpu_irq_get() only reports the missing source.
+ */
+static void dm_test_manage_interrupts_offdelay(struct kunit *test)
+{
+	struct dm_test_irq_mgmt_ctx *ctx = dm_test_irq_mgmt_ctx_alloc(test);
+
+	/* Pre-DCN3.5 keeps the two frame off delay. */
+	ctx->adev->ip_versions[DCE_HWIP][0] = IP_VERSION(3, 0, 0);
+
+	manage_dm_interrupts(ctx->adev, ctx->acrtc, ctx->acrtc_state);
+
+	KUNIT_EXPECT_EQ(test, ctx->adev->ddev.vblank[0].config.offdelay_ms, 34);
+	KUNIT_EXPECT_FALSE(test, ctx->adev->ddev.vblank[0].config.disable_immediate);
+}
+
+/**
+ * dm_test_manage_interrupts_offdelay_fallback - Test a zero delay falls back to 30ms
+ * @test: The KUnit test context
+ */
+static void dm_test_manage_interrupts_offdelay_fallback(struct kunit *test)
+{
+	struct dm_test_irq_mgmt_ctx *ctx = dm_test_irq_mgmt_ctx_alloc(test);
+
+	ctx->adev->ip_versions[DCE_HWIP][0] = IP_VERSION(3, 1, 2);
+	/* A zero line count makes the computed delay round down to zero. */
+	ctx->acrtc_state->stream->timing.v_total = 0;
+
+	manage_dm_interrupts(ctx->adev, ctx->acrtc, ctx->acrtc_state);
+
+	KUNIT_EXPECT_EQ(test, ctx->adev->ddev.vblank[0].config.offdelay_ms, 30);
+}
+
+/**
+ * dm_test_manage_interrupts_apu_instant_off - Test DCN3.5 APUs use instant off
+ * @test: The KUnit test context
+ */
+static void dm_test_manage_interrupts_apu_instant_off(struct kunit *test)
+{
+	struct dm_test_irq_mgmt_ctx *ctx = dm_test_irq_mgmt_ctx_alloc(test);
+
+	ctx->adev->ip_versions[DCE_HWIP][0] = IP_VERSION(3, 5, 0);
+	ctx->adev->flags |= AMD_IS_APU;
+
+	manage_dm_interrupts(ctx->adev, ctx->acrtc, ctx->acrtc_state);
+
+	KUNIT_EXPECT_EQ(test, ctx->adev->ddev.vblank[0].config.offdelay_ms, 1);
+	KUNIT_EXPECT_TRUE(test, ctx->adev->ddev.vblank[0].config.disable_immediate);
+}
+
+/**
+ * dm_test_manage_interrupts_disable - Test a NULL CRTC state turns vblank off
+ * @test: The KUnit test context
+ */
+static void dm_test_manage_interrupts_disable(struct kunit *test)
+{
+	struct dm_test_irq_mgmt_ctx *ctx = dm_test_irq_mgmt_ctx_alloc(test);
+
+	ctx->adev->ip_versions[DCE_HWIP][0] = IP_VERSION(3, 0, 0);
+	manage_dm_interrupts(ctx->adev, ctx->acrtc, ctx->acrtc_state);
+
+	manage_dm_interrupts(ctx->adev, ctx->acrtc, NULL);
+
+	KUNIT_EXPECT_FALSE(test, ctx->adev->ddev.vblank[0].enabled);
+}
+
 /* Tests for dm_early_init() */
 
 #define DM_TEST_ATOM_BIOS_SIZE	512
@@ -4725,6 +4836,11 @@ static struct kunit_case amdgpu_dm_tests[] = {
 	KUNIT_CASE(dm_test_plane_info_bad_color_encoding),
 	KUNIT_CASE(dm_test_plane_info_rotations),
 	KUNIT_CASE(dm_test_plane_info_layer_and_blending),
+	/* manage_dm_interrupts */
+	KUNIT_CASE(dm_test_manage_interrupts_offdelay),
+	KUNIT_CASE(dm_test_manage_interrupts_offdelay_fallback),
+	KUNIT_CASE(dm_test_manage_interrupts_apu_instant_off),
+	KUNIT_CASE(dm_test_manage_interrupts_disable),
 	/* dm_early_init */
 	KUNIT_CASE(dm_test_early_init_no_object_header),
 	KUNIT_CASE(dm_test_early_init_legacy_asics),
-- 
2.43.0

