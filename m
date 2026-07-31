Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E597C55177
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jul 2026 21:16:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B33B810F42C;
	Fri, 31 Jul 2026 21:16:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xwKP88vl";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010059.outbound.protection.outlook.com
 [52.101.193.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C287F10F403
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Jul 2026 21:16:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DooyP1o5uYXleIka0i1rNR1/FyW5BUsz+Ls5L83V3PyxhAK/QiUO1Xf0rUWMFumVPUUgnniHnG6WpHogZj88qw9UEBqQd99meKYnhmtm4JqliJdRUjlQq6g4IddxVxOvZWI2g15Ir2nsVM+jjXH3YqwiQ33IWgsberyP+zYp3wEXReqeS+CQHhgPMxW4m4GNJucJlQurFobTX0rmZ7rMLrpXDpu+PIpYVfDN8xoP82gt78T3ekVNeqF2XHkY35hJKB/Fqm6PaB58BjAtzkiAHGWnD2th/EwRSzf97934NgexRblJEOG8pU02/Yf0+HUDt6KNi5j0gMfE3scbDLjmmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kbe/2h4a/eEKWr4xnys1bfA7kaktY8KzlAatfe6Y1Ak=;
 b=q81rn7NrIsc1Va74ZogruicUDSyBJl62kn21uI6hSN2TYpl0fmkND/n8FqtpkSlCY9/a1FQjvhe59QIE0qpeXug3OzA8AZW6YLsJuiCO4NRvjNjWXcWAO5ROF1stRlcM8Is+FHVq/TCBP8Ca3dd+Ta0HIUY/q6K4egggfUqkBQ0PSLnRWN7Jxr4kjN/okEuN22qUnhXwWKA7p2eeRMeA0+NaGaf6ghHyEvC+WqddMpVehIqlzQFmf9EVd47OJtHy4CIGCcDWRCcWgwlmTCwvUZeWkEilqt7nZ43vrQndLKMwuGJfhBmnwN/zC+NbI+B78LtSTumwBS4qqP8SrYmi2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kbe/2h4a/eEKWr4xnys1bfA7kaktY8KzlAatfe6Y1Ak=;
 b=xwKP88vlCfUOZaFxWfqiDh49Nx71ftJY9EU7t/+tFXSGO6iJN27rTq6LrQ9zTF6g82LonLH7+UoUj5aVMObysgPkUr7lvusXW9O/XHowCUz6YXuYprY+1CoMudPW1VMW/e8dpS8bL0UEw2WNBPtGwB0rYEcp1qMeINIxrvP1sDo=
Received: from CH2PR14CA0045.namprd14.prod.outlook.com (2603:10b6:610:56::25)
 by DM4PR12MB6207.namprd12.prod.outlook.com (2603:10b6:8:a6::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Fri, 31 Jul
 2026 21:15:55 +0000
Received: from CH2PEPF00000142.namprd02.prod.outlook.com
 (2603:10b6:610:56:cafe::20) by CH2PR14CA0045.outlook.office365.com
 (2603:10b6:610:56::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.16 via Frontend Transport; Fri,
 31 Jul 2026 21:15:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH2PEPF00000142.mail.protection.outlook.com (10.167.244.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Fri, 31 Jul 2026 21:15:55 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 31 Jul
 2026 16:15:55 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Fri, 31 Jul 2026 16:15:54 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Subject: [PATCH 27/41] drm/amd/display: Cover crtc vblank IPS self-refresh
 restore
Date: Fri, 31 Jul 2026 17:12:48 -0400
Message-ID: <20260731211302.3040343-28-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260731211302.3040343-1-Roman.Li@amd.com>
References: <20260731211302.3040343-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000142:EE_|DM4PR12MB6207:EE_
X-MS-Office365-Filtering-Correlation-Id: ffa1d07f-813b-42c9-eb6c-08deef48e8ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|36860700016|376014|82310400026|11063799006|5023799004|56012099006|10067099003|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: zeeJLj7yxQ6224WkPWCg3S1RqlSuZMNeybPUp8TTL9YpJzyb6S3BEzuOILkvHWHPXnKina9cEDdE6h9M67a9pHaxQFJ648gIJ4dRhXpgkeyhh2UkFnkJSiGXCog6B3h6F9ftsJh+yvtPMYx2snW0TU30OQgzNnuwp4DDcFV1o4MfCo7fSng7GQX+G6B8WDiqM6184pslXs39fwihwaG5iwPH2HmKvULxkKPmGy9X88dCbThx98R+haqHXki3oevfPkQB/GAir+qfpY7/Dc+mqodmP2TNV1AeNIrio0q4oLfQBoeYEDZR6uHYo597M38VcLwTv0GY22NWsvPWKYcwR8i/2ObEZhJ2Py5sjQZOSV3RiIF0Fy6rXRRpDkSu+tYDCPxD7sFJPaChyHCKjwePnXP6HnX/jsjDt/3AWDnLLg7WoGT1yIYXHGs9Nc1hHkyTwYnoM70MQ8uv1RDwv1qiMH8LjRdZP4UVxae5LoJEbtYcfMkswyCa0fVeHZcZEh7M/STGeDDrGuHohJCWEe30n5aFnY9k44XI5w7+LEhB3PG7caIvlVgc6YHm5ixNXmP7oG6b9JbN6h5Y5+Pad8c9PRMJJbiDgZ3iW5E9Qv1U+93AK6xvouQjTOzCcG19m3KRU28COcmk/QVaTLbPA+Jap53+d8DcFxm/C5SZo2fazPsLVFwOmEmnvZq74v1BLVZOU+Ob9uCFC0cysPy7FiuCTw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(36860700016)(376014)(82310400026)(11063799006)(5023799004)(56012099006)(10067099003)(6133799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: QRh/OnQpf18BRoxFqzu8Si9Gm8XYpFXxFFdkx3mjffQY0L1OP+EdyUM6qXeAZjE16UMy7Jygxeke9bT+gpg4t0b2lErp85hVyTBowwvxcc7UwJvtQrb/UTi287ZNOQzQsFINbYtQSkZNM3BN9g1VUNJxLdv9e0yn242otd0cx3sTXmw3Myip44cgFdEsrHRvOBc+Qb1izhElIJA8Emn/uxEYu/3afhfYsK9cLvP5iXVSnaNePtycRADfFhWohmSfqwUHEmd49sKRQODA6QJrx7XKibnprEEjVs/gu/mF+sgCRIb3SN2xc6XZ6b9wy7rfnZRKB9QsmN3fYcg9uK5EsbEuaEE/lCv79ZVxGNv7r0oAZI1clPfsa2iYGCHFiZebHX4IXtZkv0DaN6S0UGTMu+rqm1waDco9M1+ZrmxKxvO3K5mtJqJJYN4xbpnAqVS1
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2026 21:15:55.4951 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ffa1d07f-813b-42c9-eb6c-08deef48e8ca
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000142.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6207
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

From: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>

Add dm_test_crtc_enable_vblank_ips_restore to cover the IPS/self-refresh
branch of amdgpu_dm_crtc_set_vblank() that calls drm_crtc_vblank_restore().

The test primes the DC with ips_support set and IPS not fully disabled, a
supported PSR version (self-refresh supported) and an immediate-disable
vblank config, so all four conditions gating the restore hold. A stub
get_vblank_timestamp hook is installed on the CRTC so the restore helper
passes its sanity check, and the enable path then runs to completion.

Assisted-by: Copilot:Claude-Opus-4.8
Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
---
 .../amdgpu_dm/tests/amdgpu_dm_crtc_test.c     | 66 +++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_crtc_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_crtc_test.c
index 74d72289dff6..b64660064902 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_crtc_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_crtc_test.c
@@ -858,6 +858,24 @@ static const struct amdgpu_irq_src_funcs dm_test_crtc_irq_src_funcs = {
 	.set = dm_test_crtc_irq_src_set,
 };
 
+/*
+ * Stub get_vblank_timestamp so drm_crtc_vblank_restore() finds a non-NULL hook.
+ * The CRTC is not registered on the device, so drm_crtc_from_index() returns
+ * NULL and this callback is never actually invoked; it only satisfies the
+ * WARN_ON_ONCE(!crtc->funcs->get_vblank_timestamp) sanity check.
+ */
+static bool dm_test_crtc_get_vblank_timestamp(struct drm_crtc *crtc,
+					      int *max_error,
+					      ktime_t *vblank_time,
+					      bool in_vblank_irq)
+{
+	return false;
+}
+
+static const struct drm_crtc_funcs dm_test_crtc_funcs = {
+	.get_vblank_timestamp = dm_test_crtc_get_vblank_timestamp,
+};
+
 /*
  * dm_test_crtc_arm_irq_src - Prime an IRQ source so get()/put() short-circuit.
  * @test: The KUnit test context
@@ -1107,6 +1125,53 @@ static void dm_test_crtc_enable_vblank_queues_work(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, adev->dm.active_vblank_irq_count, 1);
 }
 
+/**
+ * dm_test_crtc_enable_vblank_ips_restore - Test IPS/self-refresh vblank restore
+ * @test: The KUnit test context
+ *
+ * When the DC advertises IPS support with IPS not fully disabled, self-refresh
+ * is supported and immediate vblank disable is configured, the enable path must
+ * call drm_crtc_vblank_restore() to estimate missed vblanks before arming the
+ * IRQs. The enable path then runs to completion.
+ */
+static void dm_test_crtc_enable_vblank_ips_restore(struct kunit *test)
+{
+	struct dm_crtc_state *acrtc_state;
+	struct drm_vblank_crtc *vblank;
+	struct amdgpu_device *adev;
+	struct amdgpu_crtc *acrtc;
+	struct dc_link *link;
+
+	/* DCE_VERSION_8_0 supports VRR -> the vupdate-irq branch is walked. */
+	acrtc = dm_test_crtc_setup_enable(test, &adev, DCE_VERSION_8_0);
+
+	/* OTG unassigned -> amdgpu_dm_crtc_set_vupdate_irq() returns 0 early. */
+	acrtc->otg_inst = -1;
+	acrtc_state = to_dm_crtc_state(acrtc->base.state);
+	acrtc_state->freesync_config.state = VRR_STATE_ACTIVE_VARIABLE;
+
+	/* Non-NULL get_vblank_timestamp keeps drm_crtc_vblank_restore() quiet. */
+	acrtc->base.funcs = &dm_test_crtc_funcs;
+
+	/* IPS enabled and not fully disabled -> first restore condition holds. */
+	adev->dm.dc->caps.ips_support = true;
+	adev->dm.dc->config.disable_ips = DMUB_IPS_ENABLE;
+
+	/* Supported PSR version makes self-refresh supported. */
+	link = acrtc_state->stream->link;
+	link->psr_settings.psr_version = DC_PSR_VERSION_1;
+
+	/* Immediate vblank disable is the last condition gating the restore. */
+	vblank = drm_crtc_vblank_crtc(&acrtc->base);
+	vblank->config.disable_immediate = true;
+
+	adev->irq.installed = true;
+	dm_test_crtc_arm_irq_src(test, &adev->crtc_irq, 1);
+	dm_test_crtc_arm_irq_src(test, &adev->pageflip_irq, 1);
+
+	KUNIT_EXPECT_EQ(test, amdgpu_dm_crtc_enable_vblank(&acrtc->base), 0);
+}
+
 /* Tests for amdgpu_dm_crtc_update_crtc_active_planes() */
 
 /**
@@ -1748,6 +1813,7 @@ static struct kunit_case amdgpu_dm_crtc_tests[] = {
 	KUNIT_CASE(dm_test_crtc_enable_vblank_crtc_irq_error),
 	KUNIT_CASE(dm_test_crtc_enable_vblank_in_reset),
 	KUNIT_CASE(dm_test_crtc_enable_vblank_queues_work),
+	KUNIT_CASE(dm_test_crtc_enable_vblank_ips_restore),
 	/* amdgpu_dm_crtc_update_crtc_active_planes */
 	KUNIT_CASE(dm_test_crtc_update_active_planes_no_stream),
 	/* amdgpu_dm_crtc_count_crtc_active_planes */
-- 
2.34.1

