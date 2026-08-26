Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29A3DC5DF97
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Aug 2026 23:26:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 95F8110EE4F;
	Wed, 26 Aug 2026 23:26:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3etdJpfZ";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011064.outbound.protection.outlook.com [52.101.52.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C21610EE4F
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Aug 2026 23:26:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fr6AigtQwdWhOuIQ9ta7oPHMSEpGBJP+TYX+80P9Jo91LBo36TLLj1DAG3dD3cFik+jB8BfqiIzfcaVmFRAd8TSzEzeYOlJgiOpwaJD8lwYZNDegxGeH4QrOF2VVtioWMr8ZgIisBGmFbiYvqKazta5iN+8t2mBFUg+BXHL64moQChxcw+qVG4xhM/+hws/xFy7xQ9DRopW1VWGL1WoEJa0Z+LXUGCLxwOfazawILuOvhAzKZzinyihsfSoiPZAFhEyiBR+0BRuvM8I3FBpQZUfs+ju1k3RiwbO+hq1zVwBbkf8Ju9GFoehzpQ5peeasqxPkgQgks1Qh3tQwSCyN6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EfJt29Lu9k79LmoyGXymKatb+9Sx+7Y5Yozkk7uz7/8=;
 b=GugPJzLCthRf3J4c/LTkA7vGsq5rDLD1Qds+lW+ipvd6XWgW6gWOPUVW0wd3sz9hYxVVwBzqsUISeaHICJjHY+LZLE2ILsfDDu+3nK6CgEu+G+Y4Vpkbk0v5jE6byiJrZW8dZc4llUZawZxJkEgUKvaQGcbfYXhU6LcABitZcO1tDX06V56JhiRYKG5rcJz3GzFQYgvDOY1/HROg4BG7FpFQyTJOwFye+1KwrXG1eii+GnBJx9fhOCGG10J9GKB8xwg8znPSlN90VlP4bPqVL/x8Jo1PSAqQiELOGbFWpiWPXMAM5LgTAe037zAJ4cPGK20ofNXIJyoPKptYqTWLCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 149.199.90.133) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=quarantine sp=quarantine pct=100)
 action=quarantine header.from=amd.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EfJt29Lu9k79LmoyGXymKatb+9Sx+7Y5Yozkk7uz7/8=;
 b=3etdJpfZchIvT+YMNZiG8TKaCo1nNOW4vpGwVIivQI0t0LnJ9Js2YQNoax8H7NhymIlH1Awt6fR+Z67KZXS3p076ADCbjkJMfJoinkJ/qybH3pGwfj0naUfIB6zCEjZ0DvdWGLV2gU64UU603M38acdBn2xMSzUQFb3+BJWdVZc=
Received: from SN7P222CA0016.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:124::16)
 by CH3PR12MB7523.namprd12.prod.outlook.com (2603:10b6:610:148::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.9; Wed, 26 Aug
 2026 23:25:53 +0000
Received: from SN1PEPF000397B0.namprd05.prod.outlook.com
 (2603:10b6:806:124:cafe::9b) by SN7P222CA0016.outlook.office365.com
 (2603:10b6:806:124::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.8 via Frontend Transport; Wed, 26
 Aug 2026 23:25:53 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 149.199.90.133) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 149.199.90.133 as permitted sender)
Received: from satlexmb07.amd.com (149.199.90.133) by
 SN1PEPF000397B0.mail.protection.outlook.com (10.167.248.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Wed, 26 Aug 2026 23:25:52 +0000
Received: from localhost.localdomain (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 26 Aug
 2026 18:25:46 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Subject: [PATCH 30/59] drm/amd/display: Test DM atomic private state helpers
Date: Wed, 26 Aug 2026 17:05:01 -0600
Message-ID: <20260826231519.881949-31-alex.hung@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B0:EE_|CH3PR12MB7523:EE_
X-MS-Office365-Filtering-Correlation-Id: 7dfb9bfa-aced-4191-c195-08df03c95f12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|23010399003|376014|36860700016|11063799006|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: HJAMq1N0F+o1RqHNmOGrfcGK9zlr9FI3hTYgJQONYoGRacUgNDzLmdyx0QZo8ucu26uBKowkseQWQfMZC08YFSo+lPIQ0LUDni4BDTzD5ctfNt3CUozlQPET0UnDxZlKO4/99yb8UjUy3MrVAf+SBDisFJvRfUIGqNOTrGE3JY39bTjAMRumakFlSJM30szMMStg96064cT7ijVwqohggx4WZ0zvtNTWXErhfp4fGhsRO/4didQwfC8TC7PbfG+7n+tZ1qIFegm4s4mWN5wn/9zrlehPGJueD177gdEQga2lsec+Y0WJMxrXf4IxKIbkg7WYhG9rj9HQOBMIVaZKKD2gA1lC79D7mNXB00DlBoy+hb3HxsezULDb40yJ542+JGrAyr8ADDCJdztO+s1LMnNLvbjOA+g42zD3H48UBLyZknmpbdwyQxRDx7G+F3AwuegXkS2WvP76HHTPMlTwNQYuPRtmi8oefzSICcnOP/xZGRgQyAV5hEbbot1EpRPWZtzwfAP2aI9OhFnWYOPae7tUwQWwEPR+NMcTVgTVLxuhoJtQBKpNzMq5S/l3AiSDACE3t990nlarODI5Ng71aUhwTjNObGyiK8H7YD2PXfLmfRmeD5NHJTca5UNe/aW0krNJJ4f9D7wfEmqmVPmO3jy5nDXmczr5gHIhKY9xJRkdRML67NkZMe1xK20lQWlylNgSvAoDgm1Rd9HELc1qRA==
X-Forefront-Antispam-Report: CIP:149.199.90.133; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:unknown-90-133.xilinx.com;
 CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(23010399003)(376014)(36860700016)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: y7PF2jiy8L+mfsL/mv9khr8vLEWCKah4ySDe4fp5ZNJmTB33WLtJ2tjzapxtqlR0ory+f6L5ScFxnNHZDwGmfe+KJxQM4y5xo+r36Y7gkbmeLNDdY2hIW4+vVLlNTKdqsEDvVQMO1cD8mMPh2IT8bRuxUCN0uRoLkVxdqWJ32Zt/hvuQSHLB3IcUkBqX+2DhMQl0CS9uBV/u8czHDrIby11e/kizRXu2TaCtnQwhz34kXg3pDkP3DBSOmKCW2KZtkn7U8T890K8dIoxoGD9Q0g+QBLaBOnByebmReSIdQhByDoymKJ4CuuVvy7PfbD92OslbHr/lehM0VHgR6zYtC44jEG7LbW6UciCQvrNryLjCH4dMzl4MvTzJ2BE0yql9jxV5eu7crlkjIJQ3UnG+GAEJ388WMLb3bQbXBfhVprTP+TrRiaZRuWJeDokbl2Un
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2026 23:25:52.7071 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dfb9bfa-aced-4191-c195-08df03c95f12
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[149.199.90.133];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397B0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7523
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
Add KUnit tests for dm_atomic_get_state() covering the return taken when
the caller already holds the DM state, and for dm_atomic_duplicate_state()
covering the failure path when the old private state has no DC context.

Assisted-by: Copilot:Claude-Opus-5 GPT-5.6-Sol
Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  4 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  1 +
 .../display/amdgpu_dm/tests/amdgpu_dm_test.c  | 53 +++++++++++++++++++
 3 files changed, 57 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index eb00c62c6f72..5c4aac207e8f 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -2136,6 +2136,7 @@ int dm_atomic_get_state(struct drm_atomic_commit *state,
 
 	return 0;
 }
+EXPORT_IF_KUNIT(dm_atomic_get_state);
 
 STATIC_IFN_KUNIT struct dm_atomic_state *
 dm_atomic_get_new_state(struct drm_atomic_commit *state)
@@ -2156,7 +2157,7 @@ dm_atomic_get_new_state(struct drm_atomic_commit *state)
 }
 EXPORT_IF_KUNIT(dm_atomic_get_new_state);
 
-static struct drm_private_state *
+STATIC_IFN_KUNIT struct drm_private_state *
 dm_atomic_duplicate_state(struct drm_private_obj *obj)
 {
 	struct dm_atomic_state *old_state, *new_state;
@@ -2179,6 +2180,7 @@ dm_atomic_duplicate_state(struct drm_private_obj *obj)
 
 	return &new_state->base;
 }
+EXPORT_IF_KUNIT(dm_atomic_duplicate_state);
 
 STATIC_IFN_KUNIT void dm_atomic_destroy_state(struct drm_private_obj *obj,
 					      struct drm_private_state *state)
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index a25942b5565f..6e078be5bc5e 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -1168,6 +1168,7 @@ u32 dm_vblank_get_counter(struct amdgpu_device *adev, int crtc);
 int dm_crtc_get_scanoutpos(struct amdgpu_device *adev, int crtc,
 			   u32 *vbl, u32 *position);
 struct dm_atomic_state *dm_atomic_get_new_state(struct drm_atomic_commit *state);
+struct drm_private_state *dm_atomic_duplicate_state(struct drm_private_obj *obj);
 void dm_atomic_destroy_state(struct drm_private_obj *obj,
 			     struct drm_private_state *state);
 int dm_plane_layer_index_cmp(const void *a, const void *b);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c
index 33cca3f01b5b..66c35a22c45e 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c
@@ -1232,6 +1232,56 @@ static void dm_test_crtc_get_scanoutpos_exits_idle(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, dm_crtc_get_scanoutpos(adev, 0, &vbl, &position), 0);
 }
 
+static struct drm_atomic_commit *dm_test_alloc_commit(struct kunit *test,
+						     struct amdgpu_device *adev)
+{
+	struct drm_atomic_commit *state;
+
+	state = kunit_kzalloc(test, sizeof(*state), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, state);
+	state->dev = &adev->ddev;
+
+	return state;
+}
+
+/**
+ * dm_test_atomic_get_state_already_acquired - Test an acquired DM state is returned as is
+ * @test: The KUnit test context
+ */
+static void dm_test_atomic_get_state_already_acquired(struct kunit *test)
+{
+	struct amdgpu_device *adev = dm_kunit_alloc_adev(test);
+	struct drm_atomic_commit *state = dm_test_alloc_commit(test, adev);
+	struct dm_atomic_state *dm_state;
+	struct dm_atomic_state *acquired;
+
+	dm_state = kunit_kzalloc(test, sizeof(*dm_state), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, dm_state);
+	acquired = dm_state;
+
+	KUNIT_EXPECT_EQ(test, dm_atomic_get_state(state, &acquired), 0);
+	KUNIT_EXPECT_PTR_EQ(test, acquired, dm_state);
+}
+
+/**
+ * dm_test_atomic_duplicate_state_no_context - Test duplication fails without a DC context
+ * @test: The KUnit test context
+ */
+static void dm_test_atomic_duplicate_state_no_context(struct kunit *test)
+{
+	struct dm_atomic_state *old_state;
+	struct drm_private_obj *obj;
+
+	obj = kunit_kzalloc(test, sizeof(*obj), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, obj);
+	old_state = kunit_kzalloc(test, sizeof(*old_state), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, old_state);
+
+	obj->state = &old_state->base;
+
+	KUNIT_EXPECT_NULL(test, dm_atomic_duplicate_state(obj));
+}
+
 static struct kunit_case amdgpu_dm_tests[] = {
 	/* Simple DM callbacks */
 	KUNIT_CASE(dm_test_wait_for_idle),
@@ -1302,6 +1352,9 @@ static struct kunit_case amdgpu_dm_tests[] = {
 	KUNIT_CASE(dm_test_vblank_get_counter_unmapped_stream),
 	KUNIT_CASE(dm_test_crtc_get_scanoutpos_unmapped_stream),
 	KUNIT_CASE(dm_test_crtc_get_scanoutpos_exits_idle),
+	/* dm_atomic_get_state / dm_atomic_duplicate_state */
+	KUNIT_CASE(dm_test_atomic_get_state_already_acquired),
+	KUNIT_CASE(dm_test_atomic_duplicate_state_no_context),
 	{}
 };
 
-- 
2.43.0

