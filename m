Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9295C61DBE
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Aug 2026 23:27:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3453010EE53;
	Wed, 26 Aug 2026 23:27:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="aQRLlmI/";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013046.outbound.protection.outlook.com
 [40.107.201.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A9D9D10EE53
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Aug 2026 23:27:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZjbKRW5pab9uBhSnprRztMnzy15/4WNug9y8q6Vb5KkAfElQ2YYBAWqA0hz5fJrA6MnK5tssC6t56+aJqYhZdL5IREEy2+CLEk4e5c7mFqHm9LFt20uQy/8KN3oNAR/BtEh1ELbsFs9JwZ9RiJ7kEouZS3uXRX1bM6tmSRW97/6nv1uMnaPpp/Rid6GzjQY/EameXd9yToSDQUfNZzW5cy1mT1v1bM6wHf3EwzO8J2bT9SRH1IISkFtLJZrvG5pY8IXjH3HZf/C7JuI8a0mwuGxB+Dit1/kSJU+2b3c2IlPe9fPE07iw3dqXo5jH7JelLzGWLWfD50JaSGjU5oscvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=73PW72FXXRb0Rn6PArDpJkjswBUgfGJ9j5KBNVr1fII=;
 b=qZMl49GOkh0Yhu/U5e9iILNiogXfjjVBLmdVMUzjXYobfMc2PGLhIkUfGEyVKAroQ/NLtjwKwqftFGuolbrbyrEeEPqT/N2Ni8659S7byTzLOTfSAKXMoZUh1vr3UKK5aw19CgfkL65F+SzSYrBLEaPFQbdDvYh9BazHMKQ7eBS2zou7TKtSGTdK4jgZbF53IbVGhMXksDxuCWuRNoN0F5QaTHmOPTrEfE2dcfDNd9SNhF2hcbdAXRIFJs9h/KIO9kXt8ODzysoMalYODSwqVRBHvDNkd9zZrSf57aN5WXcd6nvlPQDiViJGDS8YIn6ogg9n1Hi3ORRRYiynDz+D7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 149.199.90.133) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=quarantine sp=quarantine pct=100)
 action=quarantine header.from=amd.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=73PW72FXXRb0Rn6PArDpJkjswBUgfGJ9j5KBNVr1fII=;
 b=aQRLlmI/vk3KkgRgOVrfjJS5kYdUQfbJ1sB0P5tLQdCQwq5KJKWkOVOIlz9Erd3fxeoiDA0LZcEnXtpRIl+cK9RTnsbHoS6R1B5jA99e7COkZrIErkErVg5zha3khQzh/DKRySd+OlkXL5YnNmmCMECyKmFvKY+ErErWruaWFRQ=
Received: from PH8PR22CA0001.namprd22.prod.outlook.com (2603:10b6:510:2d1::16)
 by IA0PR12MB7700.namprd12.prod.outlook.com (2603:10b6:208:430::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.7; Wed, 26 Aug
 2026 23:27:11 +0000
Received: from SN1PEPF000397B3.namprd05.prod.outlook.com
 (2603:10b6:510:2d1:cafe::32) by PH8PR22CA0001.outlook.office365.com
 (2603:10b6:510:2d1::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.10 via Frontend Transport; Wed,
 26 Aug 2026 23:27:09 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 149.199.90.133) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 149.199.90.133 as permitted sender)
Received: from satlexmb07.amd.com (149.199.90.133) by
 SN1PEPF000397B3.mail.protection.outlook.com (10.167.248.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Wed, 26 Aug 2026 23:27:08 +0000
Received: from localhost.localdomain (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 26 Aug
 2026 18:27:02 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Subject: [PATCH 34/59] drm/amd/display: Test page flip interrupt state update
Date: Wed, 26 Aug 2026 17:05:05 -0600
Message-ID: <20260826231519.881949-35-alex.hung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260826231519.881949-1-alex.hung@amd.com>
References: <20260826231519.881949-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B3:EE_|IA0PR12MB7700:EE_
X-MS-Office365-Filtering-Correlation-Id: cb527ed3-be07-4ce6-686a-08df03c98c47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|376014|82310400026|23010399003|56012099006|10067099003|11063799006|5023799004|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: DeSUCSSJ5VGS2Hy0rHHdut4ymUcecB3ts4LpftkTRSr5tmK9kjvbwxF4/Jx3cB6AEnXEUhu3Vz44i4UHS0+B9XObHMYP9WvH1kaeSPGIqOL9PCjAoCSV/Gp1OCDW3dxnFlEyaJfLmQOAM0xZ+fosjfvXDbDMRxM7lcnCGtgBaWuEPhLMTc+c5ymxhWrvWU+OgPWV8DYbLFeRIABWf7IFLKofWysMCL4IqKVmaj0CPkqMDVWS3dt+QRdiuj3VRYMTPxgDUZETQF43u1ZILeQr7dPuCtromzzIK4OUD5OcLm6VxaNWl489uBkYcvcryb21nGtHszScRc7Raf4CLlJKy1JDkVdQTVs+0xMMRLb1PbFWhHL9NSJu44CWVURind1h6mcAZOjEbviMDsdVEE/nZZUsWEcGXKnw4eYb4r07lSfFyvEYKbY4pA63fsj2jSAA3JdV/iip+QBYDHOSGpvW9zOnt330l+aZXHMh8qLu9Gn6eH2Rnbia2W321RE3RutJE1AH4TFU1/zDMEyUEUpXjUK/OmHXU+R3X30/dkhxdx4y+8JCB1HN3pCyd82rbAL8OgA5JUy+/BvWOJQvzJSBXE+2DoZtcHYIagadLgAspr0emQprh86zNu62HLWd/we7f4Vj26Eo4MKq69k8bU5FkaYNpDsO0Nx2N3d7cU/NIMWjhYE42bXSTYR9q1ku89Tf+3RA9pV77jtxXvJO/nEGgQ==
X-Forefront-Antispam-Report: CIP:149.199.90.133; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:unknown-90-133.xilinx.com;
 CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(376014)(82310400026)(23010399003)(56012099006)(10067099003)(11063799006)(5023799004)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 0OiHlMkjr22fReX0o2sT6EeeVec7UZ/7kdGVZr1fZGNK0zvtouYZkjbY/vtstnkXQHZQbhohFl0rxzBC9xBeDmnAhyrGITFaC1rS6ssQ5jfICR9a7JqFcLn1MosEVfqk5zEApl1ty6G/Wv/U6iv3K7FW7cHFmtDsw2Pb7RH8gNDOmh74BBEQ61t/PcmerSFJdXgZAaJfWVmmpibDbeU0jmFIQUgAA1fehfLJ6jer9dRC8YY+Q2xQ7dMWYoiDd5iurL+77tm32CMeYaynjXtjHUSxXa9V10VBJEykEVm9cBDv/GEzEzGjNl4UaIbM6isFWsR7w3m0cltmRngxQwDBhII322UVnVeAIZeYJxMjFPx0dN8gL8lxvFhgq4ihWQxEPP6htn5yl2B1A28rfsIpUKOkC3xrebanTQLlywXUCQPSQA1YAVd5XgQzDCPCTqGU
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2026 23:27:08.5784 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb527ed3-be07-4ce6-686a-08df03c98c47
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[149.199.90.133];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397B3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7700
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

[WHAT]
Add KUnit tests for dm_update_pflip_irq_state() covering DCN, where there
is nothing to reapply, and DCE, where the current interrupt state is
reapplied to the pageflip source.

[HOW]
Add a spy for the pageflip IRQ source. amdgpu_irq_update() always
dispatches through src->funcs->set(), which needs a registered IH ring on
real hardware, so the spy records the requested type and state instead.

Assisted-by: Copilot:Claude-Opus-5 GPT-5.6-Sol
Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  5 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  2 +
 .../display/amdgpu_dm/tests/amdgpu_dm_test.c  | 78 +++++++++++++++++++
 3 files changed, 83 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 1eb2f0973aac..4650b5f09c08 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -3419,8 +3419,8 @@ static void manage_dm_interrupts(struct amdgpu_device *adev,
 	}
 }
 
-static void dm_update_pflip_irq_state(struct amdgpu_device *adev,
-				      struct amdgpu_crtc *acrtc)
+STATIC_IFN_KUNIT void dm_update_pflip_irq_state(struct amdgpu_device *adev,
+						struct amdgpu_crtc *acrtc)
 {
 	int irq_type =
 		amdgpu_display_crtc_idx_to_irq_type(adev, acrtc->crtc_id);
@@ -3435,6 +3435,7 @@ static void dm_update_pflip_irq_state(struct amdgpu_device *adev,
 	 */
 	amdgpu_irq_update(adev, &adev->pageflip_irq, irq_type);
 }
+EXPORT_IF_KUNIT(dm_update_pflip_irq_state);
 
 STATIC_IFN_KUNIT bool
 is_scaling_state_different(const struct dm_connector_state *dm_state,
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index e4b67a0b98c3..c22266f534e3 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -1172,6 +1172,8 @@ struct dm_atomic_state *dm_atomic_get_new_state(struct drm_atomic_commit *state)
 struct drm_private_state *dm_atomic_duplicate_state(struct drm_private_obj *obj);
 void dm_atomic_destroy_state(struct drm_private_obj *obj,
 			     struct drm_private_state *state);
+void dm_update_pflip_irq_state(struct amdgpu_device *adev,
+			       struct amdgpu_crtc *acrtc);
 void amdgpu_dm_commit_cursors(struct drm_atomic_commit *state);
 void amdgpu_dm_update_cursor(struct drm_plane *plane,
 			     struct drm_plane_state *old_plane_state,
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c
index 648db4a58509..845638fed223 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c
@@ -1729,6 +1729,81 @@ static void dm_test_arm_vblank_event_cursor(struct kunit *test)
 			(int)AMDGPU_FLIP_NONE);
 }
 
+/**
+ * dm_test_update_pflip_irq_state_dcn - Test DCN skips the GRPH_PFLIP reapply
+ * @test: The KUnit test context
+ */
+static void dm_test_update_pflip_irq_state_dcn(struct kunit *test)
+{
+	struct amdgpu_device *adev = dm_kunit_alloc_adev(test);
+	struct amdgpu_crtc *acrtc;
+
+	acrtc = kunit_kzalloc(test, sizeof(*acrtc), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, acrtc);
+
+	adev->mode_info.num_crtc = 1;
+	adev->ip_versions[DCE_HWIP][0] = IP_VERSION(3, 2, 0);
+
+	dm_update_pflip_irq_state(adev, acrtc);
+}
+
+/*
+ * Spy for the pageflip IRQ source: amdgpu_irq_update() always dispatches
+ * through src->funcs->set(), which needs a registered IH ring on real
+ * hardware. Recording the requested state instead keeps the DCE reapply path
+ * reachable and observable.
+ */
+struct dm_test_irq_spy {
+	unsigned int set_count;
+	unsigned int last_type;
+	enum amdgpu_interrupt_state last_state;
+};
+
+static struct dm_test_irq_spy dm_test_irq_spy_data;
+
+static int dm_test_irq_set(struct amdgpu_device *adev,
+			   struct amdgpu_irq_src *src, unsigned int type,
+			   enum amdgpu_interrupt_state state)
+{
+	dm_test_irq_spy_data.set_count++;
+	dm_test_irq_spy_data.last_type = type;
+	dm_test_irq_spy_data.last_state = state;
+
+	return 0;
+}
+
+static const struct amdgpu_irq_src_funcs dm_test_irq_funcs = {
+	.set = dm_test_irq_set,
+};
+
+/**
+ * dm_test_update_pflip_irq_state_dce - Test DCE reapplies the GRPH_PFLIP state
+ * @test: The KUnit test context
+ */
+static void dm_test_update_pflip_irq_state_dce(struct kunit *test)
+{
+	struct amdgpu_device *adev = dm_kunit_alloc_adev(test);
+	struct amdgpu_crtc *acrtc;
+
+	acrtc = kunit_kzalloc(test, sizeof(*acrtc), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, acrtc);
+
+	memset(&dm_test_irq_spy_data, 0, sizeof(dm_test_irq_spy_data));
+	adev->mode_info.num_crtc = 2;
+	adev->ip_versions[DCE_HWIP][0] = 0;
+	adev->pageflip_irq.funcs = &dm_test_irq_funcs;
+	acrtc->crtc_id = 1;
+	spin_lock_init(&adev->irq.lock);
+
+	dm_update_pflip_irq_state(adev, acrtc);
+
+	KUNIT_EXPECT_EQ(test, dm_test_irq_spy_data.set_count, 1U);
+	KUNIT_EXPECT_EQ(test, dm_test_irq_spy_data.last_type,
+			(unsigned int)AMDGPU_CRTC_IRQ_VBLANK2);
+	KUNIT_EXPECT_EQ(test, (int)dm_test_irq_spy_data.last_state,
+			(int)AMDGPU_IRQ_STATE_DISABLE);
+}
+
 static struct kunit_case amdgpu_dm_tests[] = {
 	/* Simple DM callbacks */
 	KUNIT_CASE(dm_test_wait_for_idle),
@@ -1822,6 +1897,9 @@ static struct kunit_case amdgpu_dm_tests[] = {
 	KUNIT_CASE(dm_test_arm_vblank_pre_programming_no_event),
 	KUNIT_CASE(dm_test_arm_vblank_pre_programming_no_planes),
 	KUNIT_CASE(dm_test_arm_vblank_pre_programming_update),
+	/* dm_update_pflip_irq_state */
+	KUNIT_CASE(dm_test_update_pflip_irq_state_dcn),
+	KUNIT_CASE(dm_test_update_pflip_irq_state_dce),
 	{}
 };
 
-- 
2.43.0

