Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49A78C561E6
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Aug 2026 06:40:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D5EB610ECFE;
	Wed,  5 Aug 2026 06:40:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FbYY0/Rj";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011008.outbound.protection.outlook.com [52.101.57.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 620CF10ECFE
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Aug 2026 06:40:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SOyQphET+RZO7pV3WEo6FmrAb7GObsAUp7JuIVcB56z4RDHgi9pqQjjtgAi/LYJTvEUkL3g+kmYEIfgilU42JQdwhEL9hXPPZRrsDM0U3RZcmSLhlSUxgCit2+z7waQmN/D4UEZgwZv3obQoOt7onx/z3I/nwvoMr3ImhvxFxLD+MQMt6rD9sb6TAicCycifuAh179GOM3kPEFIlSPDby6AqECrN47fTW4Zl2IIoEq1D5OtGmSjkdFMl6SjT5RLwRqslZb3iq7X95ZjdLsCc+geG6ezgOxVTC4doP2UHR1smGTYdh2APSD2ASE4RiCPZMIcyWiU+5Q6lF9b1X2dYSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z+7znHAiZvfDyDECuJfixB681rwEee4jX47eEansR80=;
 b=hVmNB29hFgtoXru4WHzm4UtuOpNkBAXR+1GaUjCK6BOEIJJ62CbF63MsgGQzizERc80HpPh2bwOdvuvllS6YCHkSnyvUVyBBACY8gzqm8rE1vVRv2OYTKLqSg3Mnu7gUcXXVRpDAtLUFmt+p0CbL7MFGSB/gGXbYPfkoN34/u0sbtfScjS9AJasci9XQRaEMPyW4t/CXABVyke3do9Fc6xZc5vkt7fiE5g8T2k4eZyz/A4jwrUWxWgqYKVMfUKKHLqxpfFMHJq2lgJJKjz2Idk/I/6qjDxoeBUmO4tyndcTfiBHnWaQ/sgFWJhbyFG/GKsMxuccngbwjGwmMvMVDZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z+7znHAiZvfDyDECuJfixB681rwEee4jX47eEansR80=;
 b=FbYY0/RjsuDeuSHpRe58NimKYgyxIXrtsUGOfzHsG9SxA4vB2diqxktzGwlAWmd2lOg/uzCyJ6OiKmi8h1n/C/VsMRl50g+bUZ41e6p/TFslZbokk1XSLZOwmCNG0FuWwI9RNB6kO8cRK+lJpszhtxQpYUcJf22lZxMGFg22WMs=
Received: from MW4P221CA0011.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::16)
 by IA1PR12MB9738.namprd12.prod.outlook.com (2603:10b6:208:465::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Wed, 5 Aug
 2026 06:40:20 +0000
Received: from MWH0EPF000C6184.namprd02.prod.outlook.com
 (2603:10b6:303:8b:cafe::23) by MW4P221CA0011.outlook.office365.com
 (2603:10b6:303:8b::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.15 via Frontend Transport; Wed, 5
 Aug 2026 06:40:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MWH0EPF000C6184.mail.protection.outlook.com (10.167.249.116) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Wed, 5 Aug 2026 06:40:19 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 5 Aug
 2026 01:40:15 -0500
Received: from tom-r5.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 5 Aug 2026 01:40:11 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Subject: [PATCH 06/34] drm/amd/display: Add reset_state existing-state branch
 test
Date: Wed, 5 Aug 2026 14:36:18 +0800
Message-ID: <20260805063937.2145774-7-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260805063937.2145774-1-chiahsuan.chung@amd.com>
References: <20260805063937.2145774-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6184:EE_|IA1PR12MB9738:EE_
X-MS-Office365-Filtering-Correlation-Id: 75d67fd1-f914-4c4b-258a-08def2bc6b02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|36860700016|1800799024|82310400026|56012099006|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: NkivGFzfWBKXbxHliEt0r8kMsnxpiMipbaZryRop5HJfYaMoo7LkQ2glXajWi+QhNNPLZ19zHoYgx9GDVMj7PeXZCLjzYZXXv5f6bIbukmls5nRcQRhsyVJNGgcl5wEv6BeXjoQfP/MQtSHZ4Sz93dWNUgw8cl9Ex1mkOrXSOGlsmzGPWQou8MHVNxR4e9YiED4Cw6N1rzLMlCfYwswSU6JWUzfa3fEa6YfLazMqqZm00hFrhsDg5D69/Ng/AuPGxHw5ldgcBsScdC9adfNNXmRo7FvQdQ9Vvaj42bZ2KpYU9+xOo3tx2+7Wh6ekWWeMj4gBG+pgQ7WXpB7eP0NZNUcMXEHOd4/g6Ajru3B8SSqaomeHBiSz7esCCQ5nBEvWlqZ1ihdwoPFuKX0W3Dgak7YkoWwtpdmkNsh0ZA6WVwFIMU8q26s/rbt41us3pUVBCKQGkJFc5EK6xd6g6vbZEWmyh5yyspJP3FuiQHIkGRG1xb906XZF5fDetMDxiRoA8nAj/SK1W8UStlvpb/2dp/PUS+9nmO1Vzq6BdNMAuhi69NasNeY6q69aseu5I0lalENoX7XHBLlGY3IAyHgNzeoccMy54TGhgDmKCIMxAcyzrb7dJWRcfVRuniNTVzBthEAxDHt/8tP4oRpSCd3V6jHhbMKg4sPDgXevdsgAdro29aXC57mrganFJ0VYoevb6/px8KHE9AB47EDUiDKRWA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(36860700016)(1800799024)(82310400026)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: CKAXJnr4/x+EioNVPxfLDXdBNWH/ein8AtxXvx0HKM5Ev4gAbxJ8XwEki0eceySRsBsHTqvPqd7BdzxfugrnSfpEwWonicZw/BR/GmRCSCZm2eGrHk1ZbMavYtv3dL1o1P0X0p0MGqMendO42MCJcZnpyKkvPfdHKvs2/bab7jfZXBBv/Oit2CQDogJf4fFjb4oySB7dqh3+5ir/+0xwV8tGtMj/+d8NW+9fE8yvvL6NhnBHbOqdIEcV+oQ7E871AJd7rLGylaXEvD2wu/2Nf30vcSPoITYi/6NaG28YDMCWCCTwnjtJ/bfoOjrHrBitOgoaBAPT1gba+kJ84c744Ch12z4SR4q82EPyijUQEXWL65Dmy0rEMPE9trP9OTfg7Bt2LHGNtgpQ4HQrkzv6vOLuN/kOZl9lnZ2B8HvSxikSiZBHmZBm5ZhZZHE6MBCF
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2026 06:40:19.5566 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 75d67fd1-f914-4c4b-258a-08def2bc6b02
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000C6184.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9738
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

why:
amdgpu_dm_crtc_reset_state has a branch that destroys an already-installed
crtc state before allocating a new one. Only the NULL-state branch was
covered, leaving the state-replacement path untested.

how:
Add dm_test_crtc_reset_state_replaces_existing, which installs a plain
dm_crtc_state holding an extra stream reference, calls reset_state, and
verifies the old state was destroyed (stream ref dropped) and a fresh
non-NULL state was installed. Register the new case under the existing
reset_state group.

Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
---
 .../amdgpu_dm/tests/amdgpu_dm_crtc_test.c     | 43 +++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_crtc_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_crtc_test.c
index 1af819113168..430765dd87a3 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_crtc_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_crtc_test.c
@@ -1531,6 +1531,48 @@ static void dm_test_crtc_reset_state_allocates_state(struct kunit *test)
 		amdgpu_dm_crtc_destroy_state(crtc, crtc->state);
 }
 
+/**
+ * dm_test_crtc_reset_state_replaces_existing - Test reset frees the old state
+ * @test: The KUnit test context
+ *
+ * Resetting a CRTC that already carries a state must destroy the existing
+ * state before installing a fresh one. The old state holds a stream reference,
+ * so a successful reset drops that reference (via amdgpu_dm_crtc_destroy_state)
+ * and leaves the CRTC with a new, non-NULL state.
+ */
+static void dm_test_crtc_reset_state_replaces_existing(struct kunit *test)
+{
+	struct amdgpu_device *adev = dm_kunit_alloc_adev(test);
+	struct dc_stream_state *stream;
+	struct dm_crtc_state *old;
+	struct drm_crtc *crtc;
+	struct dc_link *link;
+
+	crtc = kunit_kzalloc(test, sizeof(*crtc), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, crtc);
+	crtc->dev = &adev->ddev;
+
+	link = dm_kunit_alloc_link(test);
+	stream = dm_kunit_alloc_stream(test, link);
+	/* Extra ref so destroying the old state drops back to the managed one. */
+	kref_get(&stream->refcount);
+
+	/* reset_state kfree()s the old state, so use a plain (unmanaged) alloc. */
+	old = kzalloc_obj(*old, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, old);
+	old->stream = stream;
+	crtc->state = &old->base;
+
+	amdgpu_dm_crtc_reset_state(crtc);
+
+	/* Old state was destroyed (stream ref dropped) and a new one installed. */
+	KUNIT_EXPECT_EQ(test, kref_read(&stream->refcount), 1);
+	KUNIT_EXPECT_NOT_NULL(test, crtc->state);
+
+	if (crtc->state)
+		amdgpu_dm_crtc_destroy_state(crtc, crtc->state);
+}
+
 /* Tests for amdgpu_dm_crtc_destroy_state() */
 
 /**
@@ -2013,6 +2055,7 @@ static struct kunit_case amdgpu_dm_crtc_tests[] = {
 	KUNIT_CASE(dm_test_crtc_destroy_cleans_up_and_frees),
 	/* amdgpu_dm_crtc_reset_state */
 	KUNIT_CASE(dm_test_crtc_reset_state_allocates_state),
+	KUNIT_CASE(dm_test_crtc_reset_state_replaces_existing),
 	/* amdgpu_dm_crtc_destroy_state */
 	KUNIT_CASE(dm_test_crtc_destroy_state_no_stream),
 	KUNIT_CASE(dm_test_crtc_destroy_state_releases_stream),
-- 
2.43.0

