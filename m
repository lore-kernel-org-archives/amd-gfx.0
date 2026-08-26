Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7B35C5DF97
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Aug 2026 23:31:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 511E310EE60;
	Wed, 26 Aug 2026 23:31:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pyrZunTv";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010038.outbound.protection.outlook.com [52.101.61.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D78DA10EE60
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Aug 2026 23:31:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xf5PrWnvbpdnFh+a8f7OOsg7SoqwWhHd4XnFm1HyoWws2TnrVZyIhrwSIxPOmAdWXY8tq2jrZe8xpC7Pvh0AojMKoA9timu7YxQlpQIBx+T6uFlUpiSWTKkCJs66QU+8CS/vpbIOXjCfejyQvJrL8geW3FdCgOxnDh7PoULQpnV0uv8QX1BvghEbzpZtM1N2UpYRZITbWpo0whjSO7nyFFHDur3RtVljM7NpTR15xkQ0EHUuPs7j1OAwqc5IQThGUKjWKjFaRk0MtoztN+JuTaWhQDVm54nJipnGD4iWBb7gW2ApOuwsARfjugg4MJYkNrxlbxcvl8u/gLkNpvOgAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6aVEmRog2IcDHZShUZMyS9ZenBMdXdydevrNvO9UIW8=;
 b=UtiW7IM4DgHvN8X/y/cMBPkbk4yzc3ORuYledxx1gukkoLXcy4Ox6o3gFPgiKWRSPKB7JCjAyP+A/CEIlqFdF6j8LFrybfEr9MJ1h2tsiVCLeg1xCB0w+I8PKD2ItOxIThYRwOQyjPC9geBQl2rYwAMGkEQqaYk3KgU581UeV17KeJKk7xUUtLklK3CQXEzJ/nblH3WIskOx9xviaBYDQs9f2aadBNkluhWHvBTzFccATOwtvo7I45L48kFV3zNZtAhhBCYB0XuRIMfaOo/aoutlD8EsyLnOx86cJoF6zGFAwJkKyLGD5KRIdma/4kw0jaCPm+dmh2i/bEc8teezwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 149.199.90.133) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=quarantine sp=quarantine pct=100)
 action=quarantine header.from=amd.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6aVEmRog2IcDHZShUZMyS9ZenBMdXdydevrNvO9UIW8=;
 b=pyrZunTvKksPoYi709EJ7dKv5psWmxoFLSYuUzUqIR5iOWUcK1ZabKJqgLpGlxSbhEQZj38Lxm+mBIlYf9LPveXCbe4+1uHhtGxeqYaZqbQxQyTc262g/BVZkToPsYHy5a+clU41klggJo2h1HMaC12JsTH5CM9VPNJJrvKU/T4=
Received: from PH3PEPF00004099.namprd05.prod.outlook.com (2603:10b6:518:1::45)
 by MN2PR12MB4485.namprd12.prod.outlook.com (2603:10b6:208:269::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.7; Wed, 26 Aug
 2026 23:31:51 +0000
Received: from SN1PEPF00036F3C.namprd05.prod.outlook.com
 (2a01:111:f403:f90f::2) by PH3PEPF00004099.outlook.office365.com
 (2603:1036:903:49::3) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.7 via Frontend Transport; Wed, 26
 Aug 2026 23:31:51 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 149.199.90.133) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 149.199.90.133 as permitted sender)
Received: from satlexmb07.amd.com (149.199.90.133) by
 SN1PEPF00036F3C.mail.protection.outlook.com (10.167.248.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Wed, 26 Aug 2026 23:31:50 +0000
Received: from localhost.localdomain (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 26 Aug
 2026 18:31:46 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Subject: [PATCH 47/59] drm/amd/display: Test vline0 irq control
Date: Wed, 26 Aug 2026 17:05:18 -0600
Message-ID: <20260826231519.881949-48-alex.hung@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F3C:EE_|MN2PR12MB4485:EE_
X-MS-Office365-Filtering-Correlation-Id: e8372aa8-a25f-4006-afa4-08df03ca346b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|23010399003|1800799024|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: kiLaQ99tgA34XGJ5drtIZ6OgASxtOcFQEwWJZQxMWedb2Sns+sgeLCZ7A2MrFlw6WYdv+1IwxNl+NORfljgGExwBVynezghuO24N5ODtc0Xfl2dAUxrNjmYw2h955xfR6BRPf6nCxb2jEdEUW9HQDz59uaCr1YhmSxK3IEJ8Ab6cZ/VmhoJzaedgC7AJwIe3K3eukDqonJy4XQqs37OeH1kM/+q+JG30SULIj//36uy3eOQ/aWrWKaFkBCH4TSmne50smrHpTvmg6MVVrEBjjTCIyA/QHJL053dVz93G7B9AbKDXs26UEfHaYghPU6687qqOkFEWKIMt46x9CI3tI72adnoGgdCHPBGq62ZtNy4Ue8jO4H7D5lFL1FProXAxXe3mff7nbQT83BFCTjvZA/xr9rTN4nqq4CIB1IGN16GfV2LX+3YJ4dPdep2vHox8a/87OuzHezg6OUFxggwkIFcI0GrudROoDj8Ni4MrPmiB25YY0+QrLECwnYDdMCo6BA6k+eSPUx9EqxXBSv2zGcOaaoX49RUpF3pLglw2IKCBh0/iwIK8rBql7yCRY3ovKUTltkRgVTDoPFynX573DA6l30fkWAU7mSbNJNJ0K/6js2ZvF7ZPSjuMKMtLfILabET3d7VpX5W0jbK+lux/0KQ1WmS0etCpf4epVtyeDUAfgCFEsWCXq6V1maoKV435Uftl7Zba/R+l57qjFKJIWA==
X-Forefront-Antispam-Report: CIP:149.199.90.133; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:unknown-90-133.xilinx.com;
 CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(23010399003)(1800799024)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: eGn+lia0xqpTgBQLnmny7c5Md5ei5zapGQ2KHVTcjbqTXZkdUkFiLgHkrkwO32yt2SE848vKudO/aesOLkBLcRNApyJW3A9pU5AQQegLgsJrE/ir1mtHd0IN++jmdCQy/HwH8B8TGf28FUYoGlm+5LH4W1TDzOZoSfMD8ghOtarWRHtHEqvx7sz1stVQB7FkpZPikpj88PZMHUREzRFvoVD+qsa1JqBeb28uWHA8jDPVtoQ6shqTL6tXKyf1RBj75HP+41WvrX0MaJjRYNeu5JOJD0YJpB3Yk7MzF6nDMbsqVjbxGMpGBFn28yebEsNVBooP1/J5dYW9str3sCRWFJ9dbqp2l7avQNphwVgxMAVFNCXXBhjAetMJPjgw/FFI1bqKvNbABJe9fpn1jWdggbhJ2CnskyUaYQRaZbIm7lRUBfmQj/r9l2jYBkWhvlig
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2026 23:31:50.6737 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e8372aa8-a25f-4006-afa4-08df03ca346b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[149.199.90.133];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00036F3C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4485
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
The vline0 interrupt handling in amdgpu_dm_crtc_set_vblank() sits
inside a CONFIG_DRM_AMD_SECURE_DISPLAY block. That symbol depends on
CONFIG_DRM_AMD_DC_FP, which cannot be enabled on UML because UML does
not select ARCH_HAS_KERNEL_FPU_SUPPORT, so the logic is never built by
the KUnit tests and stays uncovered.

[HOW]
Move the block into amdgpu_dm_crtc_set_vline0_irq() and build it
whenever CONFIG_DRM_AMD_SECURE_DISPLAY or the KUnit tests are enabled.
The DCN-only check becomes an early return. Behaviour of
amdgpu_dm_crtc_set_vblank() is unchanged.

Add tests for amdgpu_dm_crtc_set_vline0_irq() covering the DCE no-op
path, error propagation from amdgpu_irq_get() and the enable/disable
refcount round-trip.

Assisted-by: Copilot:Claude-Opus-5
Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_crtc.c    |  40 ++++---
 .../amd/display/amdgpu_dm/amdgpu_dm_crtc.h    |   1 +
 .../amdgpu_dm/tests/amdgpu_dm_crtc_test.c     | 101 ++++++++++++++++++
 3 files changed, 129 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
index 2de758aceda5..4b8530d734e5 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
@@ -249,6 +249,30 @@ STATIC_IFN_KUNIT void amdgpu_dm_crtc_vblank_control_worker(struct work_struct *w
 }
 EXPORT_IF_KUNIT(amdgpu_dm_crtc_vblank_control_worker);
 
+#if defined(CONFIG_DRM_AMD_SECURE_DISPLAY) || IS_ENABLED(CONFIG_DRM_AMD_DC_KUNIT_TEST)
+STATIC_IFN_KUNIT int amdgpu_dm_crtc_set_vline0_irq(struct drm_crtc *crtc, int irq_type,
+						   bool enable)
+{
+	struct amdgpu_device *adev = drm_to_adev(crtc->dev);
+	int rc;
+
+	/* crtc vline0 interrupt, only available on DCN+ */
+	if (amdgpu_ip_version(adev, DCE_HWIP, 0) == 0)
+		return 0;
+
+	if (enable) {
+		rc = amdgpu_irq_get(adev, &adev->vline0_irq, irq_type);
+		drm_dbg_vbl(crtc->dev, "Get vline0_irq ret=%d\n", rc);
+	} else {
+		rc = amdgpu_irq_put(adev, &adev->vline0_irq, irq_type);
+		drm_dbg_vbl(crtc->dev, "Put vline0_irq ret=%d\n", rc);
+	}
+
+	return rc;
+}
+EXPORT_IF_KUNIT(amdgpu_dm_crtc_set_vline0_irq);
+#endif
+
 static inline int amdgpu_dm_crtc_set_vblank(struct drm_crtc *crtc, bool enable)
 {
 	struct amdgpu_crtc *acrtc = to_amdgpu_crtc(crtc);
@@ -358,19 +382,9 @@ static inline int amdgpu_dm_crtc_set_vblank(struct drm_crtc *crtc, bool enable)
 	}
 
 #if defined(CONFIG_DRM_AMD_SECURE_DISPLAY)
-	/* crtc vline0 interrupt, only available on DCN+ */
-	if (amdgpu_ip_version(adev, DCE_HWIP, 0) != 0) {
-		if (enable) {
-			rc = amdgpu_irq_get(adev, &adev->vline0_irq, irq_type);
-			drm_dbg_vbl(crtc->dev, "Get vline0_irq ret=%d\n", rc);
-		} else {
-			rc = amdgpu_irq_put(adev, &adev->vline0_irq, irq_type);
-			drm_dbg_vbl(crtc->dev, "Put vline0_irq ret=%d\n", rc);
-		}
-
-		if (rc)
-			return rc;
-	}
+	rc = amdgpu_dm_crtc_set_vline0_irq(crtc, irq_type, enable);
+	if (rc)
+		return rc;
 #endif
 
 	if (amdgpu_in_reset(adev))
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.h
index 7de79796a56d..91fdd262c2d2 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.h
@@ -56,6 +56,7 @@ void amdgpu_dm_crtc_update_crtc_active_planes(struct drm_crtc *crtc,
 					      struct drm_crtc_state *new_crtc_state);
 void amdgpu_dm_crtc_vblank_control_worker(struct work_struct *work);
 void amdgpu_dm_idle_worker(struct work_struct *work);
+int amdgpu_dm_crtc_set_vline0_irq(struct drm_crtc *crtc, int irq_type, bool enable);
 int amdgpu_dm_crtc_helper_atomic_check(struct drm_crtc *crtc,
 				       struct drm_atomic_commit *state);
 #ifdef CONFIG_DEBUG_FS
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_crtc_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_crtc_test.c
index a88175d99092..544445fbc770 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_crtc_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_crtc_test.c
@@ -1226,6 +1226,103 @@ static void dm_test_crtc_enable_vblank_ips_restore_replay(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, amdgpu_dm_crtc_enable_vblank(&acrtc->base), 0);
 }
 
+/* Tests for amdgpu_dm_crtc_set_vline0_irq() */
+
+/*
+ * dm_test_crtc_setup_vline0 - Build an adev/CRTC for the vline0 IRQ helper.
+ * @test: The KUnit test context
+ * @adev_out: Receives the allocated device
+ * @ip_version: DCE IP version stamped on the device (0 selects the DCE path)
+ *
+ * Returns a bare CRTC attached to the device. The IRQ subsystem is left
+ * uninstalled for callers to arm.
+ */
+static struct drm_crtc *dm_test_crtc_setup_vline0(struct kunit *test,
+						  struct amdgpu_device **adev_out,
+						  uint32_t ip_version)
+{
+	struct amdgpu_device *adev;
+	struct drm_crtc *crtc;
+
+	adev = dm_kunit_alloc_adev(test);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev);
+
+	crtc = kunit_kzalloc(test, sizeof(*crtc), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, crtc);
+	crtc->dev = &adev->ddev;
+
+	adev->ip_versions[DCE_HWIP][0] = ip_version;
+
+	*adev_out = adev;
+	return crtc;
+}
+
+/**
+ * dm_test_crtc_set_vline0_irq_dce_noop - Test vline0 irq is skipped on DCE
+ * @test: The KUnit test context
+ *
+ * VLINE0 only exists on DCN+. With no DCE IP version stamped the helper must
+ * return 0 without touching the IRQ source, even though the IRQ subsystem is
+ * uninstalled (which would otherwise make amdgpu_irq_get() fail).
+ */
+static void dm_test_crtc_set_vline0_irq_dce_noop(struct kunit *test)
+{
+	struct amdgpu_device *adev;
+	struct drm_crtc *crtc;
+
+	crtc = dm_test_crtc_setup_vline0(test, &adev, 0);
+
+	KUNIT_EXPECT_EQ(test,
+			amdgpu_dm_crtc_set_vline0_irq(crtc, AMDGPU_CRTC_IRQ_VBLANK1, true), 0);
+}
+
+/**
+ * dm_test_crtc_set_vline0_irq_error - Test vline0 irq failure is propagated
+ * @test: The KUnit test context
+ *
+ * On DCN with the IRQ subsystem uninstalled, amdgpu_irq_get() returns -ENOENT
+ * and the helper must propagate it.
+ */
+static void dm_test_crtc_set_vline0_irq_error(struct kunit *test)
+{
+	struct amdgpu_device *adev;
+	struct drm_crtc *crtc;
+
+	crtc = dm_test_crtc_setup_vline0(test, &adev, IP_VERSION(3, 5, 0));
+
+	KUNIT_EXPECT_EQ(test,
+			amdgpu_dm_crtc_set_vline0_irq(crtc, AMDGPU_CRTC_IRQ_VBLANK1, true),
+			-ENOENT);
+}
+
+/**
+ * dm_test_crtc_set_vline0_irq_enable_disable - Test vline0 irq refcounting
+ * @test: The KUnit test context
+ *
+ * On DCN with an armed IRQ source, enabling takes a vline0 reference and
+ * disabling drops it again.
+ */
+static void dm_test_crtc_set_vline0_irq_enable_disable(struct kunit *test)
+{
+	struct amdgpu_device *adev;
+	struct drm_crtc *crtc;
+	atomic_t *refcount;
+
+	crtc = dm_test_crtc_setup_vline0(test, &adev, IP_VERSION(3, 5, 0));
+
+	adev->irq.installed = true;
+	dm_test_crtc_arm_irq_src(test, &adev->vline0_irq, 1);
+	refcount = &adev->vline0_irq.enabled_types[AMDGPU_CRTC_IRQ_VBLANK1];
+
+	KUNIT_EXPECT_EQ(test,
+			amdgpu_dm_crtc_set_vline0_irq(crtc, AMDGPU_CRTC_IRQ_VBLANK1, true), 0);
+	KUNIT_EXPECT_EQ(test, atomic_read(refcount), 2);
+
+	KUNIT_EXPECT_EQ(test,
+			amdgpu_dm_crtc_set_vline0_irq(crtc, AMDGPU_CRTC_IRQ_VBLANK1, false), 0);
+	KUNIT_EXPECT_EQ(test, atomic_read(refcount), 1);
+}
+
 /* Tests for amdgpu_dm_crtc_update_crtc_active_planes() */
 
 /**
@@ -2526,6 +2623,10 @@ static struct kunit_case amdgpu_dm_crtc_tests[] = {
 	KUNIT_CASE(dm_test_crtc_enable_vblank_queues_work),
 	KUNIT_CASE(dm_test_crtc_enable_vblank_ips_restore),
 	KUNIT_CASE(dm_test_crtc_enable_vblank_ips_restore_replay),
+	/* amdgpu_dm_crtc_set_vline0_irq */
+	KUNIT_CASE(dm_test_crtc_set_vline0_irq_dce_noop),
+	KUNIT_CASE(dm_test_crtc_set_vline0_irq_error),
+	KUNIT_CASE(dm_test_crtc_set_vline0_irq_enable_disable),
 	/* amdgpu_dm_crtc_update_crtc_active_planes */
 	KUNIT_CASE(dm_test_crtc_update_active_planes_no_stream),
 	/* amdgpu_dm_crtc_count_crtc_active_planes */
-- 
2.43.0

