Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FC5BC55174
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Aug 2026 06:41:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EDC4F10ED0B;
	Wed,  5 Aug 2026 06:41:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rKtcnmKc";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010012.outbound.protection.outlook.com
 [40.93.198.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EDBC610ED0E
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Aug 2026 06:41:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nnLSZTQRQdThEOpPCbW3SfOBC2OUke3R14pvPWWIDZCNA+438PcTSI4sTak+HoHU6StKrENF4WiR45BWdgcIyORZmMsn7vdTnRg3MM9DdFJGy98qFdzWlhJmkYNeS2ABm5ujR64Gbik4eTGeXI6fSaln4rAQRaL9Xcb+PLBAIl2SmobObiWGanicZ4rGPyA3ZZYvhiBVsJatiTt8b7qbaPLwaWHWYRUE45DoFYmNdHBwbLoIWd2Q2EdXkzVuHM5Vf8iJsf6BQU7HCsd0dP1OW+lW8RQnm8urvKSfqRB7mgaPv8WEyDR7SvnKQnaVtrEpVjWw1/H3GVzzr3JG56slVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7OqSugGy1KGvlaK+Rr+/4keGXhM+vtgZmBwgyQ3JadE=;
 b=gJToN8z3nHxZHLvBci/q/NKlqVC/lcJbWrjD57KIwRm8BpzTVNjL3UmWvzvZriQ3K+m62gkJ4Z3Iyhg5DQPs9P1bdr5iASZq9jpLeyJoqGPXM5jPXfwIE+2mfvfxK7wXxf6qw7x2W2ef5CW1Z1cU6RL/+6JNFjpQuEy9Fm/LlAQXpJU2qSofUfqjlb4grt8gAJP3B+gfffL6n9mDKKB6WgW8Bk6eXc/ayw8gcCrRxgDFKkf6Mllz3gE5ytiBUv0QJmhpYhZhCXydFmNXFgA6gWnOSsBg+2yVSc54yl/eGidXeg6EIKTQdDiSl/IBdC6dBg/G/Obf/q+CvFvV4kai6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7OqSugGy1KGvlaK+Rr+/4keGXhM+vtgZmBwgyQ3JadE=;
 b=rKtcnmKcj2n8NLgM05ytK9uY5446tFFjIwfQwKi+NUsGVf4TnRm9PZ5DL2yE1DqvZUYLbWCTsouNF9LgSekEDZ6Jbo6wZPPi8Q+c2WLJJPm9bih3OCM4KHV7vAmklY7kXIiYYUUg20X20I1g/xH+Fs/NPKesdx0ERdX2uyXdrCY=
Received: from MW4P221CA0024.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::29)
 by MW4PR12MB7288.namprd12.prod.outlook.com (2603:10b6:303:223::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.20; Wed, 5 Aug
 2026 06:41:11 +0000
Received: from MWH0EPF000C6184.namprd02.prod.outlook.com
 (2603:10b6:303:8b:cafe::2f) by MW4P221CA0024.outlook.office365.com
 (2603:10b6:303:8b::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.18 via Frontend Transport; Wed, 5
 Aug 2026 06:41:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MWH0EPF000C6184.mail.protection.outlook.com (10.167.249.116) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Wed, 5 Aug 2026 06:41:11 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 5 Aug
 2026 01:41:05 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 5 Aug
 2026 01:41:04 -0500
Received: from tom-r5.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 5 Aug 2026 01:41:01 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Subject: [PATCH 19/34] drm/amd/display: test VRR transitions
Date: Wed, 5 Aug 2026 14:36:31 +0800
Message-ID: <20260805063937.2145774-20-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260805063937.2145774-1-chiahsuan.chung@amd.com>
References: <20260805063937.2145774-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6184:EE_|MW4PR12MB7288:EE_
X-MS-Office365-Filtering-Correlation-Id: fb86671c-29ea-4ec5-268c-08def2bc8a29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|36860700016|1800799024|82310400026|10067099003|11063799006|56012099006|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: N10ssJ3duxnd0nVlstWttv6Lrtvv4R1FMEEgrnuyAij94edQaO9e/yAtyJhyuBu/3Z4Zy963GaL8EAE3utr+7wOzHmjJtTckrZxqh6Y0f6qKTnHeF2+eDJ9zl6Ut+yxMom8Q+Ca2IieEkkMx0yUol9OAkbqphYzrA6NtAgRqpmz5ojQ2sotpwdbozJeM5oU7mpRvqAUbg4EjzSMI3WJZ/kxmqNBjXNai/D0QLTDdvteFy3SmcmyMnSglr7Z8fkg5kXBB/Fvimv5kjVNT78gC5igFsMxFpLtMMSzY3rTtbOs1DZzV7UTC7vHJVIu9k4YMP0niDiWaip0F7LqrJWpt4+y/W2tBFqGED6Pk6Mbub1DlipEfqC269Ljm24AB2wmndn4XDA7C9ENzcWEl4okaxUju03rT852+1JTmKDxN3Puc6w+awr3YmZ/ar2A7Qn07Zi8+o5dwYyN/VtkWJpjopNvob1y3ULGAp90y5D/Z1TfWHaeo5fjixRbjkpKXn0+q264bWnUPBuo9uph8/l3zD6g5gDblqYlOB5Hg/ikxgT3m0Cs17HCM+iweIoAc4jcXcbR/c1k7IzmitCQ2VsnzHP1NDIMc32EChjbDHp+Sx+Ig/mjTQ2Pyn9m+e/C1eGwaqvcl78OLogp1rPxe91T6h3lWxHluVuo+B3k4ObVj8lg8PX0RDwt1DzU23EvxZa2XcCioXSNNjh1DGFqX39AAOA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(36860700016)(1800799024)(82310400026)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: kLJRFvPsf2snkwcH3zFhzy65gPVSBjqqWP5eCMqZJEB/xT1OLgW9EftWivK+iWy+dKAmso2QlEi9byiWNQAicmzqQ3UJM5e9Wtwz+bb9UJIdA3Ph+bFnld9DUxwBKwDSF3Y700J2EHflXD2fu+PqlaY5PrvAHS8YKlhyKoduGMQQLTOJCkXkeEmzy7oa5uqfmoMdyyJE6+tBE3nKZZYAPU6bOCKzLFyVSq3UxnPD9MBODb/JU742rd6/O+NDjTPKsAdAbXUDiCHtVuQ2Igdf7BtNt0efjSnWlKM463m9urO/X4Hus7SDeBXjWs14MseCU0lM5XQLAd9lOs3K4wIqFh3G2b9yGTggMjTPYA+5CXRP1QzZ/rrqd7TMjD6inkhm4M0SxiimdId/MHS+TrAgGyx1pYwuqElykNh6Hl/9OTldCCVseHrRDeDZssStTDV3
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2026 06:41:11.8119 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fb86671c-29ea-4ec5-268c-08def2bc8a29
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000C6184.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7288
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
Add tests for amdgpu_dm_handle_vrr_transition() covering steady inactive
state and an inactive-to-active-to-inactive vblank reference round trip.

Assisted-by: Copilot:GPT-5.6-Sol
Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
---
 .../display/amdgpu_dm/amdgpu_dm_freesync.c    |  1 +
 .../amdgpu_dm/tests/amdgpu_dm_freesync_test.c | 61 +++++++++++++++++++
 2 files changed, 62 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_freesync.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_freesync.c
index a127b3633fe5..46674b83183c 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_freesync.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_freesync.c
@@ -362,3 +362,4 @@ void amdgpu_dm_handle_vrr_transition(struct amdgpu_display_manager *dm,
 		}
 	}
 }
+EXPORT_IF_KUNIT(amdgpu_dm_handle_vrr_transition);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_freesync_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_freesync_test.c
index 9db7bfa90fce..82982553e8f3 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_freesync_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_freesync_test.c
@@ -10,6 +10,7 @@
 #include <drm/drm_connector.h>
 #include <drm/drm_crtc.h>
 #include <drm/drm_modes.h>
+#include <drm/drm_vblank.h>
 
 #include "dc.h"
 #include "inc/core_types.h"
@@ -745,6 +746,63 @@ static void dm_test_update_stream_irq_parameters_fixed(struct kunit *test)
 			60000000U);
 }
 
+/* Tests for amdgpu_dm_handle_vrr_transition() */
+
+/**
+ * dm_test_handle_vrr_transition_inactive - Test steady inactive state is a no-op
+ * @test: The KUnit test context
+ */
+static void dm_test_handle_vrr_transition_inactive(struct kunit *test)
+{
+	struct amdgpu_device *adev = dm_kunit_alloc_adev(test);
+	struct dm_crtc_state old_state = { 0 };
+	struct dm_crtc_state new_state = { 0 };
+
+	adev->dm.adev = adev;
+	amdgpu_dm_handle_vrr_transition(&adev->dm, &old_state, &new_state);
+
+	KUNIT_SUCCEED(test);
+}
+
+/**
+ * dm_test_handle_vrr_transition_round_trip - Test VRR on and off transitions
+ * @test: The KUnit test context
+ */
+static void dm_test_handle_vrr_transition_round_trip(struct kunit *test)
+{
+	struct amdgpu_device *adev = dm_kunit_alloc_adev(test);
+	struct dc_link *link = dm_kunit_alloc_link(test);
+	struct dc_stream_state *stream = dm_kunit_alloc_stream(test, link);
+	struct drm_vblank_crtc *vblank;
+	struct amdgpu_crtc *acrtc;
+	struct dm_crtc_state old_state = { 0 };
+	struct dm_crtc_state new_state = { 0 };
+
+	KUNIT_ASSERT_EQ(test, drm_vblank_init(&adev->ddev, 1), 0);
+	acrtc = kunit_kzalloc(test, sizeof(*acrtc), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, acrtc);
+	acrtc->base.dev = &adev->ddev;
+	acrtc->otg_inst = -1;
+	vblank = drm_crtc_vblank_crtc(&acrtc->base);
+	adev->ddev.vblank[0].enabled = true;
+	adev->dm.adev = adev;
+	adev->dm.dc = kunit_kzalloc(test, sizeof(*adev->dm.dc), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, adev->dm.dc);
+	mutex_init(&adev->dm.dc_lock);
+
+	old_state.base.crtc = &acrtc->base;
+	old_state.stream = stream;
+	new_state.base.crtc = &acrtc->base;
+	new_state.stream = stream;
+	new_state.freesync_config.state = VRR_STATE_ACTIVE_VARIABLE;
+
+	amdgpu_dm_handle_vrr_transition(&adev->dm, &old_state, &new_state);
+	KUNIT_EXPECT_EQ(test, atomic_read(&vblank->refcount), 1);
+
+	amdgpu_dm_handle_vrr_transition(&adev->dm, &new_state, &old_state);
+	KUNIT_EXPECT_EQ(test, atomic_read(&vblank->refcount), 0);
+}
+
 static struct kunit_case amdgpu_dm_freesync_tests[] = {
 	/* amdgpu_dm_is_timing_unchanged_for_freesync */
 	KUNIT_CASE(dm_test_timing_unchanged_null_args),
@@ -784,6 +842,9 @@ static struct kunit_case amdgpu_dm_freesync_tests[] = {
 	KUNIT_CASE(dm_test_update_stream_irq_parameters_variable),
 	KUNIT_CASE(dm_test_update_stream_irq_parameters_inactive),
 	KUNIT_CASE(dm_test_update_stream_irq_parameters_fixed),
+	/* amdgpu_dm_handle_vrr_transition */
+	KUNIT_CASE(dm_test_handle_vrr_transition_inactive),
+	KUNIT_CASE(dm_test_handle_vrr_transition_round_trip),
 	{}
 };
 
-- 
2.43.0

