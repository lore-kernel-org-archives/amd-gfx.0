Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D3C606A333
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Nov 2026 09:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=03M4dikb
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9FE7A10FAD4;
	Wed, 25 Nov 2026 09:45:07 +0000 (UTC)
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012006.outbound.protection.outlook.com
 [40.107.200.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E22510FADD
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Nov 2026 09:45:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xD1CnNwjN2TFpGfvLexQZHg4l7Vq5d4t3BATzjOXzfhskte0zZ3eGBnC1U7QDxSbhK/MQ4O8hNNnGwqry0SJ60hmi4iGX6O963Dzzvvp6fzjMySxhSXi4rMM6recNKRz21/6wf7g2lhXFFJwcumIbC3TrQsPD1+fL+LsHG52X8HgeAawky5HJSEsDAZLc2Cbget42E0z4u6KOnQrKvR9BBsbpHgRCOKw6+DnD/qWm1o9tQ3WU7WmHjhbIs02ekj8SyZ2PDR/yKIrDdEwuC/C2c5k4yCoVJ7vhVSJeThhDxGEkOtWOUe5YzQ6SLjrbSiFb6TVhke1BdZhghagGzYykg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ItyCFP0CV5+eXtcRt15c9aCDccAanCs0LioMCyGC8MM=;
 b=DqMr7Zbz0iGBszKKAE25BvgMELBg6Hn5EHGWliuVgn0DLuO/2gjuqr+j/D2IvGHMxVy3e8rBfmQyAiOIEOh0XKzdKFK0ePkNPrpwdOuIveS5sRbGThZUqUORMMILTzCU47b2NZBS1bDcWc695MGCz0STzm774i8Zd/P8wwAHccYJK0o5OIcN9QOjYEEoqlTujdCGeHNqrK80Ee4PbCW4erIVvMVa38m7h3g6Xylwc5+uToNCQD+VUTflm315KRE4iYied6z14qrmdNncA1LXeAo+G0fViL6VPYVWBdJTMBYAzFJjxkdHi64gPYoNPLsZfERYdiYxjfcDocx4zU73tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ItyCFP0CV5+eXtcRt15c9aCDccAanCs0LioMCyGC8MM=;
 b=03M4dikb3saaPrOSWJB57r1TrXRzFyxKFIsOSfPxO/3RKIm+6yvcYRLPN1QJDHpMRsMOwxF3brJ9QYuRG9tJr/dZG2TIzq2j+TBf+wmOhZkTGlwILeSiXzBkVdITG8/HuweImK3MMhJdGACippkozLSH545Dw7jY3g/9u7Vt8VI=
Received: from CH0P223CA0016.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:116::34)
 by IA1PR12MB6089.namprd12.prod.outlook.com (2603:10b6:208:3ef::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.6; Wed, 25 Nov
 2026 09:42:54 +0000
Received: from CH01EPF000BE94C.namprd02.prod.outlook.com
 (2603:10b6:610:116:cafe::a8) by CH0P223CA0016.outlook.office365.com
 (2603:10b6:610:116::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.6 via Frontend Transport; Wed, 25
 Nov 2026 09:42:54 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH01EPF000BE94C.mail.protection.outlook.com (10.167.244.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.3 via Frontend Transport; Wed, 25 Nov 2026 09:42:53 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Wed, 25 Nov
 2026 03:42:51 -0600
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>, Prike Liang
 <Prike.Liang@amd.com>, Harry Wentland <harry.wentland@amd.com>, Leo Li
 <sunpeng.li@amd.com>
Subject: [PATCH 1/2] drm/amd/display: send the flip event right away if vblank
 is off
Date: Wed, 25 Nov 2026 17:42:38 +0800
Message-ID: <20261125094239.815850-1-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH01EPF000BE94C:EE_|IA1PR12MB6089:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a4118d3-100d-4bd2-3a10-08df4ad87a8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|23010399003|1800799024|82310400026|10067099003|56012099006|11063799006|260925021911599003|260925022911599003|260925021311599003|261021123027099003|261021121427099003|261026121527099003|261026140227099003|261022105027099003|261009223027099003|261102130727099003|261102123227099003|261028144727099003|18002099003;
X-Microsoft-Antispam-Message-Info: j45i7aATfFT1zfVIlsibEfywa7jpcOZPvQsDs3bsAozsGcvRXAw55oBP7UBrC179CyzhiH2oQPW//u/1r/EP+3LURMvPKQTiNFCEzZRwIPx4iHm7V07zZx5ZDI5KuwfSd+QrWyXAkZuhTq5h5HG6zbc0W7i84UrxJTbUuuvzNTNe3wKetJ0XwkVuH9mQWGN777khgRpMIAKB0Iof/zLHRzjVPc77jGowhXT/FFqUFzuyhqpZ63fbKtMMNgvV9dnB92Gukp8ua53kIevp/Kf9W7IFRJLV5ThS7Dv9e7gKFpfqWT2omiMGBjDMKYiUCXRNHZOwelQrJiuW6bf38MzCxSgClmzytJNi7gWB8mkUx8P0M/Dm9Vwfc9Mt0cXs8G/CuuknavjdftB1D5Boq+7DyqQe0utazuJY6SMv5yyeTnjDq/+0PamZEOQigiPF31ozw4w/Ij94kNu5LKzFA4w/FJWPPEsk78//uTBZCYwa7lqzfOOiSti/LTHLkTGSLyQWKOzQFGt1a68uS7Z1NSM99DvZtxhbvIsgOUwOv6BaAEk+/agY7WUyaKWdUiCyp2zlWjlv7jwTmpvRx/DoF9yO01YyahMgO5SbmDrihPY5bf/TjGF/sHwMQC2jdST8q+UDEjGafOvfQLyPkB1kcMVVVx5O84tCvtvN8Ox0HQvBkFl6O8JnPZ1enFYhRaURyGroQ3/gYqPQgmkX5xCe6aOkag==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(23010399003)(1800799024)(82310400026)(10067099003)(56012099006)(11063799006)(260925021911599003)(260925022911599003)(260925021311599003)(261021123027099003)(261021121427099003)(261026121527099003)(261026140227099003)(261022105027099003)(261009223027099003)(261102130727099003)(261102123227099003)(261028144727099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 0/z+hAagM2v8Cgngq1i9Da7dkbQC060Ao+3R0yIVDPQibdgAKp9pFU4BM2bbELTs/S9OfyquJBDq2Gyup0L9wnq/yQBdhQdA8NeTNOKDHJ9cbg6fFY8fZMD5K3x+mt1XZ8RidwIBYN+QSBEIp4FhYaAB6EGbFVkuDu0Xjj+uYLo+g0ECP9IzwRopnQlUnx/wjAe/q5JPo9MesXYKeBGVNSMOhuT9QFcDlcmDr0ARZIT8nPWhZPZzdH8Dx6f7WIYAPzmuyLdnBcY9+E1mJx1bCWBpUZv7Ip5Y6svDfv2C8ZImDkEXM/xOoU0XD5xngMfcPTuURdi/8wJRXVPCNRfRmf6y64j8dFDtZZEPO6Ll4FR8Oz8uRFBZ5aspMQrMp1T4yHUpMnYpL54ciuXc3jsF5y6WwscQw6PLtuhr3b7z6T/WTzwiV5iE5mCYEm0WS3Cg
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 09:42:53.8613 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a4118d3-100d-4bd2-3a10-08df4ad87a8a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH01EPF000BE94C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6089
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

dm_arm_vblank_event_pre_programming() takes a vblank reference for a
page flip or cursor update that carries an event, and the handler that
later sends the event drops that reference again. The return value of
drm_crtc_vblank_get() is ignored, though. If vblank is off, the event
is armed anyway, and the handler that eventually sends it drops a
reference that was never taken, which unbalances the vblank refcount.

That can't happen today: DM only turns vblank off for a CRTC that it
disables, and a disabled CRTC has no active planes. The next patch also
turns vblank off while a GPU reset has the streams stopped, though.
Page flips that don't modify the DC state skip
amdgpu_dm_commit_streams() and only take dc_lock after this point, so
they still get here while the reset holds it.

Send the event right away when no vblank reference can be taken, like
drm_crtc_vblank_off() does for queued vblank events. No vblank interrupt
could deliver it in that case anyway.

Add a KUnit test for it.

Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Leo Li <sunpeng.li@amd.com>
Assisted-by: Copilot:claude-opus-5.5
Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 15 ++++++++--
 .../display/amdgpu_dm/tests/amdgpu_dm_test.c  | 29 +++++++++++++++++++
 2 files changed, 42 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index b0310612425f..9cee9104112c 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -3924,6 +3924,11 @@ EXPORT_IF_KUNIT(dm_arm_vblank_event);
  * Grab a reference on the vblank counter if a page flip or cursor update is to
  * be programmed. Do this before programming so the HW is not in any
  * idle-optimized state (such as PSR).
+ *
+ * If vblank is off, no vblank interrupt can deliver the event, and the
+ * handlers that send it would drop a reference that was never taken. Send
+ * the event right away instead, like drm_crtc_vblank_off() does for queued
+ * vblank events.
  */
 STATIC_IFN_KUNIT void dm_arm_vblank_event_pre_programming(struct amdgpu_crtc *acrtc,
 							  struct dm_crtc_state *acrtc_state,
@@ -3935,8 +3940,14 @@ STATIC_IFN_KUNIT void dm_arm_vblank_event_pre_programming(struct amdgpu_crtc *ac
 	if (!acrtc->base.state->event || acrtc_state->active_planes == 0)
 		return;
 
-	if (pflip_update || cursor_update)
-		drm_crtc_vblank_get(&acrtc->base);
+	if (!pflip_update && !cursor_update)
+		return;
+
+	if (drm_crtc_vblank_get(&acrtc->base)) {
+		drm_crtc_send_vblank_event(&acrtc->base,
+					   acrtc->base.state->event);
+		acrtc->base.state->event = NULL;
+	}
 }
 EXPORT_IF_KUNIT(dm_arm_vblank_event_pre_programming);
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c
index 28ea2f8fbaf6..317e1f13655c 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c
@@ -1819,6 +1819,34 @@ static void dm_test_arm_vblank_pre_programming_update(struct kunit *test)
 	drm_crtc_vblank_put(&ctx->acrtc->base);
 }
 
+/**
+ * dm_test_arm_vblank_pre_programming_vblank_off - Test the event is sent with vblank off
+ * @test: The KUnit test context
+ *
+ * No vblank interrupt can deliver the event, and the handlers that send it
+ * must not drop a vblank reference that was never taken.
+ */
+static void dm_test_arm_vblank_pre_programming_vblank_off(struct kunit *test)
+{
+	struct dm_test_vblank_ctx *ctx = dm_test_vblank_ctx_alloc(test);
+	struct drm_vblank_crtc *vblank;
+
+	KUNIT_ASSERT_EQ(test, drm_vblank_init(&ctx->adev->ddev, 1), 0);
+	vblank = drm_crtc_vblank_crtc(&ctx->acrtc->base);
+	drm_crtc_vblank_off(&ctx->acrtc->base);
+
+	/* Sending an event that has no file frees it. */
+	ctx->acrtc_state->base.event = kzalloc_obj(*ctx->event, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ctx->acrtc_state->base.event);
+
+	dm_test_arm_vblank_pre_programming(ctx, true, false);
+
+	KUNIT_EXPECT_NULL(test, ctx->acrtc_state->base.event);
+	/* Only drm_crtc_vblank_off() holds a reference. */
+	KUNIT_EXPECT_EQ(test, atomic_read(&vblank->refcount), 1);
+	kfree(ctx->acrtc_state->base.event);
+}
+
 /**
  * dm_test_arm_vblank_event_no_event - Test a commit without an event is a no-op
  * @test: The KUnit test context
@@ -5555,6 +5583,7 @@ static struct kunit_case amdgpu_dm_tests[] = {
 	KUNIT_CASE(dm_test_arm_vblank_pre_programming_no_event),
 	KUNIT_CASE(dm_test_arm_vblank_pre_programming_no_planes),
 	KUNIT_CASE(dm_test_arm_vblank_pre_programming_update),
+	KUNIT_CASE(dm_test_arm_vblank_pre_programming_vblank_off),
 	/* dm_update_pflip_irq_state */
 	KUNIT_CASE(dm_test_update_pflip_irq_state_dcn),
 	KUNIT_CASE(dm_test_update_pflip_irq_state_dce),
-- 
2.34.1

