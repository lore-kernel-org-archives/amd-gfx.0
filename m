Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 000A7C982C9
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Sep 2026 17:53:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7183210EBD2;
	Wed, 16 Sep 2026 17:53:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="iulgxZtY";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012024.outbound.protection.outlook.com [52.101.53.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6EA6F10EBD2
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Sep 2026 17:53:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JEOpsm8kvDwwl5nDYRsYzN2ArgkRZC4pagNo5rEWDslkgkgxJJf+IxjZA70Deek0ci5weyTQAu0RJyPBwvis4gbTqJjWS/v6IZWEYzJIgzVfTF3y4Mn4Zg79Bnc3wUxM6nFPlPAbBPnRaYIGxBUXSKzHDIdXGo9Shs/r3GYWGmXioWeNNSgzKS9LN3zqhocLS1m/BKhmnrdYv5BzNzb/oVyrWjVZUEnQjZrSlxuiIB1lAiQ/MkJFq/y+PiybG/sE6PEW+OXcNSuLFhjj05ef7lbfPxyQS0vvgFTy4NhffRYxU1cmKXXMcQKwUXnhTXqls3n/dYptmU2+PQZnEImYOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7evEsf59pSV7Gj7ixzjjNp1dJRToLsYSAzFPR5vdMcs=;
 b=aWGu55R9jECURC8GWdF//BgZC2WpcS8m4uLqrClDn4v5CmBnUmtuF7GIcJOcDEX/qN63LsuC20mZQ2rdeBAQGPmW8V7cz9mPinggqCWkHpfjyOfWd1RbVgJcnBKXX3XpqNzhIJP4PvCoNfepfc2ype7EJllQ3yyfCJemyZ8aTfMPLzmzTtIL6q4bKXVFIpe/LK0INRrx+v9j2ZbzBfoWEfU2y0qJtXw4TZPuozzLeVXz/IbYyjLDyWN48fl1OlWZwW5FqTRlhj1gX1oO8y4xbKFnp+fLZ+2q3Ojf0l4EeofpUH9zDcqgwG3Q+LbgSwQMhRBzXz4NchCXmCtqiS1w1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7evEsf59pSV7Gj7ixzjjNp1dJRToLsYSAzFPR5vdMcs=;
 b=iulgxZtY/vzieqxvoSnTyyNN1t8HV9DTe3ORz5hsOk867cbg5PfcdPdL/BbFIzN6zo13roHcFfjEhFIRRibNBs2JAOldQTzv3V9gu9QkRMkIVx0R6XYHWbfFVF4EVEaC4InPMolxYXVJ9B+DzxSCrpmH1mOP4PztXUo4qihnxIA=
Received: from CH2PR10CA0015.namprd10.prod.outlook.com (2603:10b6:610:4c::25)
 by MW3PR12MB4458.namprd12.prod.outlook.com (2603:10b6:303:5d::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Wed, 16 Sep
 2026 17:53:05 +0000
Received: from CH3PEPF0000000A.namprd04.prod.outlook.com
 (2603:10b6:610:4c:cafe::24) by CH2PR10CA0015.outlook.office365.com
 (2603:10b6:610:4c::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.11 via Frontend Transport; Wed,
 16 Sep 2026 17:53:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF0000000A.mail.protection.outlook.com (10.167.244.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Wed, 16 Sep 2026 17:53:05 +0000
Received: from georzhanmkm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 16 Sep
 2026 12:52:52 -0500
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
Subject: [PATCH 50/64] drm/amd/display: Fix KUnit DM warnings
Date: Wed, 16 Sep 2026 13:52:05 -0400
Message-ID: <20260916175301.368306-51-george.zhang@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260916175301.368306-1-george.zhang@amd.com>
References: <20260916175301.368306-1-george.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000A:EE_|MW3PR12MB4458:EE_
X-MS-Office365-Filtering-Correlation-Id: 958ea085-7178-4086-f20d-08df141b5c34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700016|23010399003|22082099003|18002099003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: C2seenae2R9vb86xsoLHpm48j4nPpW+LbtYhNIIiIQsYF8+c7D51QH+bA/1N5/euQFH+q8G/HjQYlnuPIdYSBj5nOFTGFAQ8SHn3pjeUS9asTJso6bUpoOULV9fi78+szhAj6A+ShIKoh+bUmH50qq0vTmtNCNzIlO1ot6kcNWsKQ8GY7BCFFS2U5fcXxrRsLSaEQzBsOl+o2ocz+ZJ3aX3SUSWWZfNNNwMKLJWjPYBrtq0Q8c3Ah/jaylMj93bvH2gGd6oulwskQCdqf6a99YoGMvOEEPjtdpEm2cofgwYp+22Ct2g2s5kvMgX85RLqBzeG6f/QKzOCeERNcXov46JFxRTfFoYPcuNW8/Y90JTxpD9O2d7AOgEvoxXNTBewx/7o+72ZGFkMLGcVWpfrxLGIZ/jf3hlv2rCWsv9nVrwf4OF03MqrBvjov7IGME4zdKH2cz81OfOI11/fvBrq+LkPtITUjn7rSnM68nRvxifqi/Vk/2sz+VxFrSq5gsZzEFmVZkdgcOxkwuU6ICPpmAivLXgcutnOF2LCiFyZPmYTHJbnW9yrQ6xqGpjhs6VsMz34zemcZNCLwq9oSGJ0bgKyZbAL643tc8JOFb+taV14iuIu2dVm1d+9jPxyLAXhlb3YYsCxy+ZDdIuhEUViTscjiDKfAISnuIiRtKBE6MOuRUeghkRBjXF9WNq2CdPdAYCoiDcrAiJ8FgDNZSPitA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700016)(23010399003)(22082099003)(18002099003)(10067099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 6ylUSxYTxC6QLBAUoEWzOdHwkIKz50Xx9ev8dPuEy0+vxRYZ/nQSnpB/O5g6e/MRcTXoB5ryr5HJ8ypGBJ93hRJHVxG+wlYxNwwDuoHKBEoIxHy0OrJsBh53SpvYPC8jmfkvChnoqou4j84GE9Z9XZ4zDkq2VpB/WW87VAF0Z+BkY0NGfBzkfgS1Ye3wpFjsQb6uDqUIGG2NNdMrcI94YaQimxRzjXWpRLSK6B/8daBXcKYj53u0g0vB5Fydczr2FAR2CBhK7XX9cZ9oU8v34PUqIxmiGPhsq3t3fR2HpOLUHzmz8S92okxmgUu0VQT2WLDIKHDhLDNGgQAJh8lYDsLZ2cpd4oW2o5iZZprt7TqynF32tMwkTHR08z9MlxGx1W8rF/KdWvJfiiocx4vwYwTfhNjAZuWioARqFWG7UjecOWdTx4h0FKhjjJ3PNx/a
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 17:53:05.3007 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 958ea085-7178-4086-f20d-08df141b5c34
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4458
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

[WHY]
Vblank and interrupt-management tests need discoverable CRTCs with
complete vblank callbacks and balanced teardown.

[HOW]
Add the callbacks, link the fake CRTCs, and register cleanup actions
to disable vblank before unlinking. Pass the CRTC directly so cleanup
does not reinterpret two different fixture types through one layout.

Assisted-by: Copilot:GPT-6-Astra
Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: George Zhang <george.zhang@amd.com>
---
 .../display/amdgpu_dm/tests/amdgpu_dm_test.c  | 41 +++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c
index e0fbb84912df..11be3a267ce9 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c
@@ -1681,6 +1681,35 @@ struct dm_test_vblank_ctx {
 	struct drm_pending_vblank_event *event;
 };
 
+static int dm_test_vblank_enable(struct drm_crtc *crtc)
+{
+	return 0;
+}
+
+static void dm_test_vblank_disable(struct drm_crtc *crtc)
+{
+}
+
+static u32 dm_test_vblank_counter(struct drm_crtc *crtc)
+{
+	return 0;
+}
+
+static const struct drm_crtc_funcs dm_test_vblank_crtc_funcs = {
+	.enable_vblank = dm_test_vblank_enable,
+	.disable_vblank = dm_test_vblank_disable,
+	.get_vblank_counter = dm_test_vblank_counter,
+};
+
+static void dm_test_vblank_ctx_cleanup(void *data)
+{
+	struct amdgpu_crtc *acrtc = data;
+
+	if (drm_dev_has_vblank(acrtc->base.dev))
+		drm_crtc_vblank_off(&acrtc->base);
+	list_del_init(&acrtc->base.head);
+}
+
 /*
  * A CRTC with one active plane and a pending vblank event. There is no
  * initialised vblank, so drm_crtc_vblank_get() fails, which the function under
@@ -1702,9 +1731,15 @@ static struct dm_test_vblank_ctx *dm_test_vblank_ctx_alloc(struct kunit *test)
 	KUNIT_ASSERT_NOT_NULL(test, ctx->event);
 
 	ctx->acrtc->base.dev = &ctx->adev->ddev;
+	ctx->acrtc->base.funcs = &dm_test_vblank_crtc_funcs;
+	INIT_LIST_HEAD(&ctx->acrtc->base.head);
+	list_add_tail(&ctx->acrtc->base.head,
+		      &ctx->adev->ddev.mode_config.crtc_list);
 	ctx->acrtc->base.state = &ctx->acrtc_state->base;
 	ctx->acrtc_state->base.event = ctx->event;
 	ctx->acrtc_state->active_planes = 1;
+	KUNIT_ASSERT_EQ(test,
+			kunit_add_action_or_reset(test, dm_test_vblank_ctx_cleanup, ctx->acrtc), 0);
 
 	return ctx;
 }
@@ -4185,7 +4220,13 @@ static struct dm_test_irq_mgmt_ctx *dm_test_irq_mgmt_ctx_alloc(struct kunit *tes
 
 	ctx->adev->mode_info.num_crtc = 1;
 	ctx->acrtc->base.dev = &ctx->adev->ddev;
+	ctx->acrtc->base.funcs = &dm_test_vblank_crtc_funcs;
+	INIT_LIST_HEAD(&ctx->acrtc->base.head);
+	list_add_tail(&ctx->acrtc->base.head,
+		      &ctx->adev->ddev.mode_config.crtc_list);
 	ctx->acrtc->crtc_id = 0;
+	KUNIT_ASSERT_EQ(test,
+			kunit_add_action_or_reset(test, dm_test_vblank_ctx_cleanup, ctx->acrtc), 0);
 
 	ctx->acrtc_state->stream = dm_kunit_alloc_stream(test, NULL);
 	timing = &ctx->acrtc_state->stream->timing;
-- 
2.55.0

