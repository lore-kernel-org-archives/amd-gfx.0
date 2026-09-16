Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA6B4C982D9
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Sep 2026 17:53:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C76410ECF1;
	Wed, 16 Sep 2026 17:53:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xmQ259u2";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010038.outbound.protection.outlook.com [52.101.56.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 08CAE10ECC2
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Sep 2026 17:53:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O58hlEDXbInWJNtb/S1B374lcQEf6hOla8OOQN0cOGO8Le16Fc5FQgpeuEF4QEPr8pPi6STc0OVLmv4lrwthvK2VaXtQpTYuuon1Os7Fids9yO1OaC1SevhPZ3LgTEH7gCw8/E0iNiL+fLCIdGEtV9JYffyQWVxiIv8ChEQC0wRIc4y2AZLNeX1wjZFAVI/e5G5Gwu4xi9G+Uj1HOwAufetnXiPuPZSwE0R+BEhBChwkulS9YOm6T1ZXGKIGdt88nTbUq2wtkNWYZkeAC9it+frN8j18ncmryIY+wsl0MFrDhjf+6gTsYIt9038c9Z1qw6iXZTyPwPGkZJgQbXFk5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EXLkFh10cO/311M6JeBWN2aTGTfT1XCa+yOfebn6NTM=;
 b=Lnay4tP0P3M4x5HdjPHI/v+bkYb09LX3MSUxcO+msqRwTCL1v5MdKnX5e5c7GAbukk2UMrecHceAmxCukLmGGitu4JcCim/VPyAXLPDGvYsJbT0MrUSiMJrT0DcpXzS+kHpWVsHK912l2szFI60I9N2C4u8UgTu+Hi0yXErmiBbs91aNTQ8NBLLUqyA1xR0m81PTu3W6tuKgBBhmYcIiV4ldBDjlH7NTi8y/bZukMOP1A8BH7ekauUI60gBeKVAghN8nIIH8MHz9HJ8hRcqPVPMMenwmxTH0tzVWxzNNx8WrG1tcKehFRBxCv3QO2QE2vsaNw/SOpRG5/lo0jQh4Ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EXLkFh10cO/311M6JeBWN2aTGTfT1XCa+yOfebn6NTM=;
 b=xmQ259u2Y/8dGWlhz+o5QwCGxp/Yz3Awf2D/gc5+U45Cv6BegXXwHwy4PbLBxcjG+TQWcaE5TuEzZJFPFCwV1TGHTmSEIbc19wQNcYPcgEeEMw0hPixPEAsXqxLabx27Y4tNh2rf9py5PW6Vit96oNIc6FICyg6VUVElTa9niZc=
Received: from CH2PR10CA0014.namprd10.prod.outlook.com (2603:10b6:610:4c::24)
 by CH3PR12MB8402.namprd12.prod.outlook.com (2603:10b6:610:132::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Wed, 16 Sep
 2026 17:53:03 +0000
Received: from CH3PEPF0000000A.namprd04.prod.outlook.com
 (2603:10b6:610:4c:cafe::7d) by CH2PR10CA0014.outlook.office365.com
 (2603:10b6:610:4c::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.9 via Frontend Transport; Wed, 16
 Sep 2026 17:53:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF0000000A.mail.protection.outlook.com (10.167.244.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Wed, 16 Sep 2026 17:53:03 +0000
Received: from georzhanmkm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 16 Sep
 2026 12:52:48 -0500
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
Subject: [PATCH 45/64] drm/amd/display: Fix KUnit cursor warning
Date: Wed, 16 Sep 2026 13:52:00 -0400
Message-ID: <20260916175301.368306-46-george.zhang@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000A:EE_|CH3PR12MB8402:EE_
X-MS-Office365-Filtering-Correlation-Id: 871b2929-e44d-4310-cd39-08df141b5b11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700016|23010399003|6133799003|56012099006|11063799006|18002099003|22082099003|10067099003;
X-Microsoft-Antispam-Message-Info: mvbE0OiOxiha00Pj9R9hnmDsKYfJJODtwWdjBSKyJuN1FNqj5rE5Vx5+YXUt7qBqaJEGnShK0RIYslvCwCTyi3PzWorAeA53s4rFWClxormlrZYXdmkjEo8ja7r/Kt8rP7jl9i3GXQyoEq5ayLL6dfrMQiVX40x5bnzMM2y7LOFRvv2S3mrhTEmiRIVE+PK7bridYLhrr5h+vxAb4fhxXQRB2zL6yTi+x7nF481uvjLiEPrre/UtDOp+gy0Jxgvrrk9MoqLPXB6bYY8QNjKEXZijVHEUrihSXi1XjAlEg06lx/8uswurx/3FlktRcpVepLSdfzISGgEeITmLiC0eh73ANXY4nNmQ9QqvOGAypPx2cYSaiEkVTJwvkhuw6DrkQ2eCtSCBmWAkOPoaWcZx/+xRSk96gLXa//UWu3mCS6I52A/cV2JQzKfmAauW/DBdb+rIV+xqxAPPy3ZwKj7hewRB3MuLS7+Aljz2I7fscH6bsLQ/B5KE7OyVDsom+IBjCvVRulMjspgUWbl5KOdf+b1aevkH+30Qd/B75h90pZ/oY4Y8W1f+Bv312KaOTthyoB1wsYaOZ/gh9OowukG4KTSKeDNRi1kBnz4rdZYYAWgOcIXMH2QiOcYHwrBSFqZch6yMm5lrDazEguLnTS7gpeLtgeFxrMosDJgPnEzwr3nyFBkFLN1FPcbYSYNKDA4AewHCzvnINaRzKjq5U6vnDw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(23010399003)(6133799003)(56012099006)(11063799006)(18002099003)(22082099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 9GbdtHTnxYSZlPrytOOvNcL7NYcADpJTKgHTn514lRJL8qRsPaGNz7tXIiz6TfgOOi3s2McPTC65Ms8flRy5WXgETvDV4tG+Ko8leHerAsd6sITRcjkwOcJ9csnleV8Aux+JJtqA2jDsmomB4NlliPNQcqcM+YG4ejyONAKJp19Wfaohg/NeSjMvdguD3YHNCNt2gtUveI4nxR1wNlJUNRAOuX0T+dkBc62RpWhNqLjIoPS8ADLl9+b8x4R5UHY+2nagg1mSfV0K99XIP0pPGzvi05EDOaVzz2j0zsg+uUKP39RsTcv2AV5c94XkJ5PKmXpRl8+LwUK09KG1nJKURP9YeEGL8HMo7Ga1ugr4LTlk1kW/YBl61d2PuO/pLDfd50q9cYyu1WbrXqhASEi129kWtOcpZxEr3X4THwvlUcvGhPNhWzVEcFOMT7ZoHOI3
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 17:53:03.4159 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 871b2929-e44d-4310-cd39-08df141b5b11
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8402
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
The cursor offset test binds a CRTC without a framebuffer, triggering
a plane-state consistency warning before the intended offset check.

[HOW]
Provide a test framebuffer in the new plane state while retaining the
invalid offset and its expected rejection.

Assisted-by: Copilot:GPT-6-Astra
Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: George Zhang <george.zhang@amd.com>
---
 .../drm/amd/display/amdgpu_dm/tests/amdgpu_dm_cursor_test.c   | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_cursor_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_cursor_test.c
index 9026c6ce7336..2212451043fb 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_cursor_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_cursor_test.c
@@ -365,6 +365,7 @@ static void dm_test_check_native_cursor_state_rejects_offset(struct kunit *test)
 	struct amdgpu_device *adev = dm_kunit_alloc_adev(test);
 	struct amdgpu_crtc *acrtc;
 	struct drm_plane *plane;
+	struct drm_framebuffer *fb;
 	struct drm_plane_state *old_plane_state;
 	struct drm_plane_state *new_plane_state;
 	int ret;
@@ -373,6 +374,8 @@ static void dm_test_check_native_cursor_state_rejects_offset(struct kunit *test)
 	KUNIT_ASSERT_NOT_NULL(test, acrtc);
 	plane = kunit_kzalloc(test, sizeof(*plane), GFP_KERNEL);
 	KUNIT_ASSERT_NOT_NULL(test, plane);
+	fb = kunit_kzalloc(test, sizeof(*fb), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, fb);
 	old_plane_state = kunit_kzalloc(test, sizeof(*old_plane_state), GFP_KERNEL);
 	KUNIT_ASSERT_NOT_NULL(test, old_plane_state);
 	new_plane_state = kunit_kzalloc(test, sizeof(*new_plane_state), GFP_KERNEL);
@@ -381,6 +384,7 @@ static void dm_test_check_native_cursor_state_rejects_offset(struct kunit *test)
 	acrtc->base.dev = &adev->ddev;
 	old_plane_state->crtc = &acrtc->base;
 	new_plane_state->crtc = &acrtc->base;
+	new_plane_state->fb = fb;
 	new_plane_state->src_x = 1;
 	plane->state = old_plane_state;
 
-- 
2.55.0

