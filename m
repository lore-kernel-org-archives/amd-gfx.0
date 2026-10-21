Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7297A606A31F
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2026 06:28:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0BE3210F95B;
	Wed, 21 Oct 2026 06:28:26 +0000 (UTC)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011067.outbound.protection.outlook.com
 [40.93.194.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0CED210F95B
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Oct 2026 06:28:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qi5/33B/0HB73GHG9gjfJXCEepQdDlAziTUyawsx81SBK7o4KyVfH1C5q8M+mNdalaUOjxnMNm1frebFEXj/MmPMMvc7kM5BnjIJb+Fi51a9M9k+1RSn85eYfDkoxDk2VKQ9TM5Sup/SnmyWSsvc6p0bAqdd5JdT8EDDnPUp4CalBLH29vHA5AWId2lwN4y3wPrtFtp9QLVG0zTfVbMKUY/EI/umfqgP5vkkULHTYtefQyy7NtnYR7uav4QEVkEVOzh4oACbKMkHMoDinm5jjLkbQAEDsMZJhQBblID8oXKCdkJYiwHYmvGyMdjMSKpHXfTq7LWj+Vjz4sS9Itn52g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ewygAfxwHSI2CEpRRW3C/w6N3GnrKFX6Dc/Tz3kXdeg=;
 b=ZIpXgPmLYdDB3EkdGQenQGs9eu9oTzLtF2uCYfCPrx4qGH4GTKu788vMJMyArAhAFjEIeEuXiOXlnMJW+RkLmIWlRceGkjSB0kf8DVF9D4HB2F/sKzoBiXg73nB29oQjrziYKmOWfkHqUqo657kS17rx8W8ytzHJ5pIc7w7OophIYo4j4PCOcJgFhIegPADKPQmZ6mDr/CfLZXnjvi0WDqJ1SHZjRgps6mHFbkN7HFzDT3H23BMHs1kN6+xayhY/vj1a6bNREO7utSZbSrTAdNynpbiFL7IhENzTIKJ9YuZbD93I4pr8d85PJ7yVJalnU1JEjolUu29vv1yyteW53w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ewygAfxwHSI2CEpRRW3C/w6N3GnrKFX6Dc/Tz3kXdeg=;
 b=AR9MLFt5ZfVwcoR6LMBu9gP3bDMMTj7Rz3vLo4kIf/EgiLbGDWtv93BSdhnf/X2SFZ/RfCq2j9bAvzhHS1JZhAZjY1dkS0ZHo/w3vcFrdNcOAVI4tSjTDe6xG1n530S1D5j0Ml5tJDhPaynH8TFF3FV1T/AU2us3A9lCFSG16kU=
Received: from SJ0PR03CA0060.namprd03.prod.outlook.com (2603:10b6:a03:33e::35)
 by DSVPR12MB999123.namprd12.prod.outlook.com (2603:10b6:8:388::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.14; Wed, 21 Oct
 2026 06:28:14 +0000
Received: from SJ1PEPF000037AD.namprd03.prod.outlook.com
 (2603:10b6:a03:33e:cafe::35) by SJ0PR03CA0060.outlook.office365.com
 (2603:10b6:a03:33e::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.20 via Frontend Transport; Wed,
 21 Oct 2026 06:28:14 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF000037AD.mail.protection.outlook.com (10.167.244.180) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Wed, 21 Oct 2026 06:28:14 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 21 Oct
 2026 01:28:11 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 21 Oct
 2026 01:28:11 -0500
Received: from tom-r5.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Wed, 21 Oct 2026 01:28:07 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Subject: [PATCH 45/49] drm/amd/display: Assert NOT_NULL on allocs
Date: Wed, 21 Oct 2026 14:22:51 +0800
Message-ID: <20261021062519.674697-46-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261021062519.674697-1-chiahsuan.chung@amd.com>
References: <20261021062519.674697-1-chiahsuan.chung@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000037AD:EE_|DSVPR12MB999123:EE_
X-MS-Office365-Filtering-Correlation-Id: 39a643c6-6440-45ff-84a0-08df2f3c7c7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|23010399003|1800799024|6133799003|22082099003|18002099003|10067099003|3023799007|261009223027099003|5023799004|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 7CQdjK0aLeaCdHAfWpWkdyYn8yVuyzqq82l0H920PWez7EA0Z/pRYmB5ghyVgerFl6fLH67Ccppg3A8z8mgg83NtK9qW4oNgrHsalZ61Y0vz+/7AXXJN01TnqV9eKLbBYy39zkkVo3wCmRcT7+xRToT3zq0AHYXV8Lv8QRT44MnaSiVTmrJflKrp9SCW9YrjjIyTpau1SxQzM7Q6UA7CC43LaXgimzeHlUsKr2KCRCLHbF7uR7Q/Qe1veuLDMOknLqMhmw2q/jzEZSccp4uJIReujWiGyqqTUsedIwWOJwoclr2Nhz71kn0RrivgIZMiznL4P7CxEfcEl8NZlJpF4/ufnoHnxFGpbqEP/hc11YTR/oj0acqB26VoLPHoawozdHMRyz6EbQcZGUIsB2NcYC6mKorA3THzpGZRZatIz/a/MiOHvB+YTgZwgVISN/RO0dFgGaauNrfbFcCvYr8QOfYvJ8sd2ihAKUMpZZ56mwTkWyYPIGfR+iVXtfFfE1JJJB8iM9ZmWWOjdVaZc39NwUsXqZ5HlMc+nEnqp6IPVL0UOJwTBS9Mx8RBCiXCR0/yM5zNhIrlYgLeNqPtOUI9CszQOQijzGhBSBN1ppFCjUFZGCwP1HvVXBybm9JYoy1NFPvmduWTCSot5KNFCNZ5DNSh1BXW7G69M7gkl3+IX5HGBsMUR/SvhqR6NHXK4bU1hCTYMEnp8vxTSAXG3PXd/g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(23010399003)(1800799024)(6133799003)(22082099003)(18002099003)(10067099003)(3023799007)(261009223027099003)(5023799004)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ccUGwJfLBLFft8/jq8JMnBw1bkom0n+esKj/XUEvaLIa1POSs+lFfXkYzr0HYJGq3rE1t+bm8ihCc93ASVA9tYgHUtdJm8Mra169te5KxoHjhhb02XeAMVhch/p408cRg4a3PfilKQcdHU/HepQySqvicrVVK4Be+cAv2gKbiGgoA0Wzj5GEIJ9yBj80afcOSMQRdS2/fCOSF/0n9mLRCKAwyzqVsh+z0h5VIRzZja0qGkVCP8LxBv7NM11wjEouV7ShPxnfZ9j4NyFwFFuZIXEJTkFcXnHuZ1wDWwWzeTOdcgNqUs4Gs+no9ug3rhWHWpNM0pgfFFF7+hQ/2HV90FVRr0Wggzn1jfqLZGG065J4kfYE2H6BoTuqbk7TliFN6FdUtWaVPTIBaHHF2yQ5rXVd7FzF01vPneGLJInbLfVV0pbvPdEgZTY4YlUUy7ur
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 06:28:14.1816 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 39a643c6-6440-45ff-84a0-08df2f3c7c7e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000037AD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR12MB999123
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
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Alex Hung <alex.hung@amd.com>

[WHY]
Many tests check kzalloc()-family results with
KUNIT_ASSERT_NOT_ERR_OR_NULL(), but these allocators return NULL on
failure and never an error pointer.

[HOW]
Use KUNIT_ASSERT_NOT_NULL() where the asserted pointer comes directly
from kunit_kzalloc(), kunit_kcalloc(), drmm_kzalloc() or kzalloc_obj().
Keep KUNIT_ASSERT_NOT_ERR_OR_NULL() for helpers that can return
ERR_PTR, such as the drm_kunit_helper and drm_atomic_get_*_state
calls.

Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
---
 .../amdgpu_dm/tests/amdgpu_dm_audio_test.c    |  84 ++---
 .../tests/amdgpu_dm_backlight_test.c          |  48 +--
 .../amdgpu_dm/tests/amdgpu_dm_color_test.c    |   6 +-
 .../amdgpu_dm/tests/amdgpu_dm_colorop_test.c  |   2 +-
 .../tests/amdgpu_dm_connector_test.c          |  70 ++--
 .../amdgpu_dm/tests/amdgpu_dm_crtc_test.c     | 240 ++++++-------
 .../amdgpu_dm/tests/amdgpu_dm_dmub_test.c     | 168 ++++-----
 .../amdgpu_dm/tests/amdgpu_dm_freesync_test.c |  24 +-
 .../amdgpu_dm/tests/amdgpu_dm_irq_test.c      | 324 +++++++++---------
 .../amdgpu_dm/tests/amdgpu_dm_kunit_helpers.c |   2 +-
 .../tests/amdgpu_dm_mst_types_test.c          |  12 +-
 .../amdgpu_dm/tests/amdgpu_dm_quirks_test.c   |   6 +-
 .../display/amdgpu_dm/tests/amdgpu_dm_test.c  |  30 +-
 13 files changed, 508 insertions(+), 508 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_audio_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_audio_test.c
index 040a7a9c0335..281dac959dca 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_audio_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_audio_test.c
@@ -77,7 +77,7 @@ static void dm_test_audio_init_disabled(struct kunit *test)
 	int saved_audio = amdgpu_dm_audio_get_param();
 
 	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev);
+	KUNIT_ASSERT_NOT_NULL(test, adev);
 
 	amdgpu_dm_audio_set_param(0);
 
@@ -107,11 +107,11 @@ static void dm_test_audio_init_enabled_success(struct kunit *test)
 	res_pool = kunit_kzalloc(test, sizeof(*res_pool), GFP_KERNEL);
 	audio0 = kunit_kzalloc(test, sizeof(*audio0), GFP_KERNEL);
 	audio1 = kunit_kzalloc(test, sizeof(*audio1), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dc);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, res_pool);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, audio0);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, audio1);
+	KUNIT_ASSERT_NOT_NULL(test, adev);
+	KUNIT_ASSERT_NOT_NULL(test, dc);
+	KUNIT_ASSERT_NOT_NULL(test, res_pool);
+	KUNIT_ASSERT_NOT_NULL(test, audio0);
+	KUNIT_ASSERT_NOT_NULL(test, audio1);
 
 	dev = root_device_register("kunit-dm-audio-init");
 	KUNIT_ASSERT_FALSE(test, IS_ERR(dev));
@@ -151,7 +151,7 @@ static void dm_test_audio_fini_without_enabled_audio(struct kunit *test)
 	int saved_audio = amdgpu_dm_audio_get_param();
 
 	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev);
+	KUNIT_ASSERT_NOT_NULL(test, adev);
 
 	amdgpu_dm_audio_set_param(1);
 	adev->mode_info.audio.enabled = false;
@@ -181,9 +181,9 @@ static void dm_test_fill_audio_info_ids_name_flags(struct kunit *test)
 	audio_info = kunit_kzalloc(test, sizeof(*audio_info), GFP_KERNEL);
 	connector = kunit_kzalloc(test, sizeof(*connector), GFP_KERNEL);
 	dc_sink = kunit_kzalloc(test, sizeof(*dc_sink), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, audio_info);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, connector);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dc_sink);
+	KUNIT_ASSERT_NOT_NULL(test, audio_info);
+	KUNIT_ASSERT_NOT_NULL(test, connector);
+	KUNIT_ASSERT_NOT_NULL(test, dc_sink);
 
 	dc_sink->edid_caps.manufacturer_id = 0x1234;
 	dc_sink->edid_caps.product_id = 0xABCD;
@@ -214,9 +214,9 @@ static void dm_test_fill_audio_info_cea_lt_3_skips_modes(struct kunit *test)
 	audio_info = kunit_kzalloc(test, sizeof(*audio_info), GFP_KERNEL);
 	connector = kunit_kzalloc(test, sizeof(*connector), GFP_KERNEL);
 	dc_sink = kunit_kzalloc(test, sizeof(*dc_sink), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, audio_info);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, connector);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dc_sink);
+	KUNIT_ASSERT_NOT_NULL(test, audio_info);
+	KUNIT_ASSERT_NOT_NULL(test, connector);
+	KUNIT_ASSERT_NOT_NULL(test, dc_sink);
 
 	connector->display_info.cea_rev = 2;
 	dc_sink->edid_caps.audio_mode_count = 2;
@@ -243,9 +243,9 @@ static void dm_test_fill_audio_info_cea_ge_3_copies_modes(struct kunit *test)
 	audio_info = kunit_kzalloc(test, sizeof(*audio_info), GFP_KERNEL);
 	connector = kunit_kzalloc(test, sizeof(*connector), GFP_KERNEL);
 	dc_sink = kunit_kzalloc(test, sizeof(*dc_sink), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, audio_info);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, connector);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dc_sink);
+	KUNIT_ASSERT_NOT_NULL(test, audio_info);
+	KUNIT_ASSERT_NOT_NULL(test, connector);
+	KUNIT_ASSERT_NOT_NULL(test, dc_sink);
 
 	connector->display_info.cea_rev = 3;
 	dc_sink->edid_caps.audio_mode_count = 2;
@@ -288,9 +288,9 @@ static void dm_test_fill_audio_info_latency_present(struct kunit *test)
 	audio_info = kunit_kzalloc(test, sizeof(*audio_info), GFP_KERNEL);
 	connector = kunit_kzalloc(test, sizeof(*connector), GFP_KERNEL);
 	dc_sink = kunit_kzalloc(test, sizeof(*dc_sink), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, audio_info);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, connector);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dc_sink);
+	KUNIT_ASSERT_NOT_NULL(test, audio_info);
+	KUNIT_ASSERT_NOT_NULL(test, connector);
+	KUNIT_ASSERT_NOT_NULL(test, dc_sink);
 
 	connector->display_info.cea_rev = 3;
 	connector->latency_present[0] = true;
@@ -316,9 +316,9 @@ static void dm_test_fill_audio_info_latency_absent_keeps_zero(struct kunit *test
 	audio_info = kunit_kzalloc(test, sizeof(*audio_info), GFP_KERNEL);
 	connector = kunit_kzalloc(test, sizeof(*connector), GFP_KERNEL);
 	dc_sink = kunit_kzalloc(test, sizeof(*dc_sink), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, audio_info);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, connector);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dc_sink);
+	KUNIT_ASSERT_NOT_NULL(test, audio_info);
+	KUNIT_ASSERT_NOT_NULL(test, connector);
+	KUNIT_ASSERT_NOT_NULL(test, dc_sink);
 
 	connector->display_info.cea_rev = 3;
 	connector->latency_present[0] = false;
@@ -347,9 +347,9 @@ static void dm_test_fill_audio_info_cea_ge_3_zero_modes(struct kunit *test)
 	audio_info = kunit_kzalloc(test, sizeof(*audio_info), GFP_KERNEL);
 	connector = kunit_kzalloc(test, sizeof(*connector), GFP_KERNEL);
 	dc_sink = kunit_kzalloc(test, sizeof(*dc_sink), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, audio_info);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, connector);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dc_sink);
+	KUNIT_ASSERT_NOT_NULL(test, audio_info);
+	KUNIT_ASSERT_NOT_NULL(test, connector);
+	KUNIT_ASSERT_NOT_NULL(test, dc_sink);
 
 	connector->display_info.cea_rev = 3;
 	dc_sink->edid_caps.audio_mode_count = 0;
@@ -379,9 +379,9 @@ static void dm_test_audio_component_bind_sets_fields(struct kunit *test)
 	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
 	kdev = kunit_kzalloc(test, sizeof(*kdev), GFP_KERNEL);
 	acomp = kunit_kzalloc(test, sizeof(*acomp), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, kdev);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, acomp);
+	KUNIT_ASSERT_NOT_NULL(test, adev);
+	KUNIT_ASSERT_NOT_NULL(test, kdev);
+	KUNIT_ASSERT_NOT_NULL(test, acomp);
 
 	dev_set_drvdata(kdev, &adev->ddev);
 
@@ -409,9 +409,9 @@ static void dm_test_audio_component_unbind_clears_fields(struct kunit *test)
 	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
 	kdev = kunit_kzalloc(test, sizeof(*kdev), GFP_KERNEL);
 	acomp = kunit_kzalloc(test, sizeof(*acomp), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, kdev);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, acomp);
+	KUNIT_ASSERT_NOT_NULL(test, adev);
+	KUNIT_ASSERT_NOT_NULL(test, kdev);
+	KUNIT_ASSERT_NOT_NULL(test, acomp);
 
 	dev_set_drvdata(kdev, &adev->ddev);
 
@@ -472,9 +472,9 @@ static void dm_test_eld_notify_invokes_callback(struct kunit *test)
 	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
 	acomp = kunit_kzalloc(test, sizeof(*acomp), GFP_KERNEL);
 	audio_ops = kunit_kzalloc(test, sizeof(*audio_ops), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, acomp);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, audio_ops);
+	KUNIT_ASSERT_NOT_NULL(test, adev);
+	KUNIT_ASSERT_NOT_NULL(test, acomp);
+	KUNIT_ASSERT_NOT_NULL(test, audio_ops);
 
 	audio_ops->audio_ptr = &marker;
 	audio_ops->pin_eld_notify = dm_test_pin_eld_notify;
@@ -504,7 +504,7 @@ static void dm_test_eld_notify_no_component(struct kunit *test)
 	struct amdgpu_device *adev;
 
 	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev);
+	KUNIT_ASSERT_NOT_NULL(test, adev);
 
 	adev->dm.audio_component = NULL;
 
@@ -528,8 +528,8 @@ static void dm_test_eld_notify_null_audio_ops(struct kunit *test)
 
 	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
 	acomp = kunit_kzalloc(test, sizeof(*acomp), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, acomp);
+	KUNIT_ASSERT_NOT_NULL(test, adev);
+	KUNIT_ASSERT_NOT_NULL(test, acomp);
 
 	acomp->audio_ops = NULL;
 	adev->dm.audio_component = acomp;
@@ -557,9 +557,9 @@ static void dm_test_eld_notify_null_callback(struct kunit *test)
 	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
 	acomp = kunit_kzalloc(test, sizeof(*acomp), GFP_KERNEL);
 	audio_ops = kunit_kzalloc(test, sizeof(*audio_ops), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, acomp);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, audio_ops);
+	KUNIT_ASSERT_NOT_NULL(test, adev);
+	KUNIT_ASSERT_NOT_NULL(test, acomp);
+	KUNIT_ASSERT_NOT_NULL(test, audio_ops);
 
 	audio_ops->pin_eld_notify = NULL;
 	acomp->audio_ops = audio_ops;
@@ -589,7 +589,7 @@ static void dm_test_audio_init_pins_sets_defaults(struct kunit *test)
 	int i;
 
 	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev);
+	KUNIT_ASSERT_NOT_NULL(test, adev);
 
 	amdgpu_dm_audio_init_pins(adev, 2, inst_array);
 
@@ -619,7 +619,7 @@ static void dm_test_audio_init_pins_zero_count(struct kunit *test)
 	struct amdgpu_device *adev;
 
 	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev);
+	KUNIT_ASSERT_NOT_NULL(test, adev);
 
 	/* Pre-fill a sentinel so we can confirm the loop never ran. */
 	adev->mode_info.audio.pin[0].channels = 99;
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_test.c
index 5221050dec2f..c6d15fb8ad98 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_test.c
@@ -44,9 +44,9 @@ static void setup_test_connector(struct kunit *test,
 	fixture->adev = kunit_kzalloc(test, sizeof(*fixture->adev), GFP_KERNEL);
 	fixture->aconnector = kunit_kzalloc(test, sizeof(*fixture->aconnector), GFP_KERNEL);
 	fixture->link = kunit_kzalloc(test, sizeof(*fixture->link), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, fixture->adev);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, fixture->aconnector);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, fixture->link);
+	KUNIT_ASSERT_NOT_NULL(test, fixture->adev);
+	KUNIT_ASSERT_NOT_NULL(test, fixture->aconnector);
+	KUNIT_ASSERT_NOT_NULL(test, fixture->link);
 
 	fixture->aconnector->bl_idx = bl_idx;
 	fixture->aconnector->dc_link = fixture->link;
@@ -111,7 +111,7 @@ static void dm_test_backlight_set_level_connector_off(struct kunit *test)
 
 	setup_test_dm_ddev(test, dm);
 	aconnector = kunit_kzalloc(test, sizeof(*aconnector), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, aconnector);
+	KUNIT_ASSERT_NOT_NULL(test, aconnector);
 	INIT_LIST_HEAD(&aconnector->base.head);
 	aconnector->bl_idx = 1;
 	aconnector->base.encoder = NULL;
@@ -169,7 +169,7 @@ static void dm_test_backlight_set_level_aux_programs_power_module(struct kunit *
 
 	/* Non-matching connector exercises the bl_idx skip (continue). */
 	other = kunit_kzalloc(test, sizeof(*other), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, other);
+	KUNIT_ASSERT_NOT_NULL(test, other);
 	INIT_LIST_HEAD(&other->base.head);
 	other->bl_idx = 0;
 	list_add_tail(&other->base.head, &dm->ddev->mode_config.connector_list);
@@ -245,16 +245,16 @@ static void dm_test_backlight_set_level_reallows_idle(struct kunit *test)
 
 	/* dm_kunit_alloc_dm() leaves dc->ctx NULL; the idle path dereferences it. */
 	ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
+	KUNIT_ASSERT_NOT_NULL(test, ctx);
 	dm->dc->ctx = ctx;
 
 	logger = kunit_kzalloc(test, sizeof(*logger), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, logger);
+	KUNIT_ASSERT_NOT_NULL(test, logger);
 	logger->dev = &adev->ddev;
 	dm->dc->ctx->logger = logger;
 
 	dmub_srv = kunit_kzalloc(test, sizeof(*dmub_srv), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dmub_srv);
+	KUNIT_ASSERT_NOT_NULL(test, dmub_srv);
 	dmub_srv->idle_allowed = true;
 	dm->dc->ctx->dmub_srv = dmub_srv;
 	dm->dc->caps.ips_support = true;
@@ -286,7 +286,7 @@ static void dm_test_backlight_update_status_no_stream(struct kunit *test)
 
 	setup_test_dm_ddev(test, dm);
 	bd = kunit_kzalloc(test, sizeof(*bd), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, bd);
+	KUNIT_ASSERT_NOT_NULL(test, bd);
 	dev_set_drvdata(&bd->dev, dm);
 	bd->props.brightness = 3456;
 	dm->num_of_edps = 2;
@@ -305,9 +305,9 @@ static void setup_test_link_service(struct kunit *test, struct dc_link *link)
 	dc = kunit_kzalloc(test, sizeof(*dc), GFP_KERNEL);
 	ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
 	link_srv = kunit_kzalloc(test, sizeof(*link_srv), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dc);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, link_srv);
+	KUNIT_ASSERT_NOT_NULL(test, dc);
+	KUNIT_ASSERT_NOT_NULL(test, ctx);
+	KUNIT_ASSERT_NOT_NULL(test, link_srv);
 
 	dc->ctx = ctx;
 	dc->link_srv = link_srv;
@@ -440,7 +440,7 @@ static void dm_test_backlight_get_brightness_uses_device_index(struct kunit *tes
 	setup_test_link_service(test, link);
 	link->dc->link_srv->edp_get_backlight_level = dm_test_get_backlight_level_error;
 	bd = kunit_kzalloc(test, sizeof(*bd), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, bd);
+	KUNIT_ASSERT_NOT_NULL(test, bd);
 	dev_set_drvdata(&bd->dev, dm);
 	dm->num_of_edps = 2;
 	dm->backlight_dev[1] = bd;
@@ -487,7 +487,7 @@ static void dm_test_register_backlight_device_success(struct kunit *test)
 	setup_test_link_service(test, link);
 	link->dc->link_srv->edp_get_backlight_level = dm_test_get_backlight_level_error;
 	primary = kunit_kzalloc(test, sizeof(*primary), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, primary);
+	KUNIT_ASSERT_NOT_NULL(test, primary);
 	adev->ddev.primary = primary;
 	adev->dm.backlight_link[0] = link;
 
@@ -531,9 +531,9 @@ static struct drm_connector *setup_panel_power_savings_connector(struct kunit *t
 	connector = kunit_kzalloc(test, sizeof(*connector), GFP_KERNEL);
 	device = kunit_kzalloc(test, sizeof(*device), GFP_KERNEL);
 	state = kunit_kzalloc(test, sizeof(*state), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, connector);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, device);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, state);
+	KUNIT_ASSERT_NOT_NULL(test, connector);
+	KUNIT_ASSERT_NOT_NULL(test, device);
+	KUNIT_ASSERT_NOT_NULL(test, state);
 
 	connector->dev = &adev->ddev;
 	connector->state = &state->base;
@@ -646,9 +646,9 @@ static void dm_test_panel_power_savings_store_rejects_invalid_text(struct kunit
 	connector = kunit_kzalloc(test, sizeof(*connector), GFP_KERNEL);
 	drm = kunit_kzalloc(test, sizeof(*drm), GFP_KERNEL);
 	device = kunit_kzalloc(test, sizeof(*device), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, connector);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, drm);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, device);
+	KUNIT_ASSERT_NOT_NULL(test, connector);
+	KUNIT_ASSERT_NOT_NULL(test, drm);
+	KUNIT_ASSERT_NOT_NULL(test, device);
 
 	connector->dev = drm;
 	dev_set_drvdata(device, connector);
@@ -669,9 +669,9 @@ static void dm_test_panel_power_savings_store_rejects_out_of_range(struct kunit
 	connector = kunit_kzalloc(test, sizeof(*connector), GFP_KERNEL);
 	drm = kunit_kzalloc(test, sizeof(*drm), GFP_KERNEL);
 	device = kunit_kzalloc(test, sizeof(*device), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, connector);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, drm);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, device);
+	KUNIT_ASSERT_NOT_NULL(test, connector);
+	KUNIT_ASSERT_NOT_NULL(test, drm);
+	KUNIT_ASSERT_NOT_NULL(test, device);
 
 	connector->dev = drm;
 	dev_set_drvdata(device, connector);
@@ -1518,7 +1518,7 @@ static void dm_test_update_connector_ext_caps_negative_bl_idx(struct kunit *test
 	struct amdgpu_dm_connector *aconnector;
 
 	aconnector = kunit_kzalloc(test, sizeof(*aconnector), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, aconnector);
+	KUNIT_ASSERT_NOT_NULL(test, aconnector);
 
 	aconnector->bl_idx = -1;
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_color_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_color_test.c
index 4debfe3b49a4..c07661ef56c1 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_color_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_color_test.c
@@ -71,7 +71,7 @@ static void dm_test_is_lut_linear_with_linear_lut(struct kunit *test)
 	int i;
 
 	lut = kunit_kcalloc(test, size, sizeof(*lut), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, lut);
+	KUNIT_ASSERT_NOT_NULL(test, lut);
 
 	for (i = 0; i < size; i++) {
 		uint16_t val = (uint16_t)(i * MAX_DRM_LUT_VALUE / (size - 1));
@@ -91,7 +91,7 @@ static void dm_test_is_lut_linear_with_nonlinear_lut(struct kunit *test)
 	int i;
 
 	lut = kunit_kcalloc(test, size, sizeof(*lut), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, lut);
+	KUNIT_ASSERT_NOT_NULL(test, lut);
 
 	/* Fill with all-max values: clearly non-linear */
 	for (i = 0; i < size; i++) {
@@ -110,7 +110,7 @@ static void dm_test_is_lut_linear_rgb_mismatch(struct kunit *test)
 	int i;
 
 	lut = kunit_kcalloc(test, size, sizeof(*lut), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, lut);
+	KUNIT_ASSERT_NOT_NULL(test, lut);
 
 	for (i = 0; i < size; i++) {
 		uint16_t val = (uint16_t)(i * MAX_DRM_LUT_VALUE / (size - 1));
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_colorop_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_colorop_test.c
index 90cc5592ef5d..27cd4b8500e8 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_colorop_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_colorop_test.c
@@ -232,7 +232,7 @@ static void dm_test_initialize_default_pipeline_caps(struct kunit *test,
 	drm = &adev->ddev;
 
 	dc = kunit_kzalloc(test, sizeof(*dc), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dc);
+	KUNIT_ASSERT_NOT_NULL(test, dc);
 	adev->dm.dc = dc;
 	adev->dm.dc->caps.color.dpp.hw_3d_lut = dpp_hw_3d_lut;
 	adev->dm.dc->caps.color.mpc.preblend = mpc_preblend;
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
index a2ddcc2a53a2..acde20241f43 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
@@ -46,7 +46,7 @@ static void dm_test_subconnector_type_none(struct kunit *test)
 {
 	struct dc_link *link = kunit_kzalloc(test, sizeof(*link), GFP_KERNEL);
 
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, link);
+	KUNIT_ASSERT_NOT_NULL(test, link);
 
 	link->dpcd_caps.dongle_type = DISPLAY_DONGLE_NONE;
 	KUNIT_EXPECT_EQ(test, (int)get_subconnector_type(link), (int)DRM_MODE_SUBCONNECTOR_Native);
@@ -60,7 +60,7 @@ static void dm_test_subconnector_type_vga(struct kunit *test)
 {
 	struct dc_link *link = kunit_kzalloc(test, sizeof(*link), GFP_KERNEL);
 
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, link);
+	KUNIT_ASSERT_NOT_NULL(test, link);
 
 	link->dpcd_caps.dongle_type = DISPLAY_DONGLE_DP_VGA_CONVERTER;
 	KUNIT_EXPECT_EQ(test, (int)get_subconnector_type(link), (int)DRM_MODE_SUBCONNECTOR_VGA);
@@ -74,7 +74,7 @@ static void dm_test_subconnector_type_dvi_converter(struct kunit *test)
 {
 	struct dc_link *link = kunit_kzalloc(test, sizeof(*link), GFP_KERNEL);
 
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, link);
+	KUNIT_ASSERT_NOT_NULL(test, link);
 
 	link->dpcd_caps.dongle_type = DISPLAY_DONGLE_DP_DVI_CONVERTER;
 	KUNIT_EXPECT_EQ(test, (int)get_subconnector_type(link), (int)DRM_MODE_SUBCONNECTOR_DVID);
@@ -88,7 +88,7 @@ static void dm_test_subconnector_type_dvi_dongle(struct kunit *test)
 {
 	struct dc_link *link = kunit_kzalloc(test, sizeof(*link), GFP_KERNEL);
 
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, link);
+	KUNIT_ASSERT_NOT_NULL(test, link);
 
 	link->dpcd_caps.dongle_type = DISPLAY_DONGLE_DP_DVI_DONGLE;
 	KUNIT_EXPECT_EQ(test, (int)get_subconnector_type(link), (int)DRM_MODE_SUBCONNECTOR_DVID);
@@ -102,7 +102,7 @@ static void dm_test_subconnector_type_hdmi_converter(struct kunit *test)
 {
 	struct dc_link *link = kunit_kzalloc(test, sizeof(*link), GFP_KERNEL);
 
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, link);
+	KUNIT_ASSERT_NOT_NULL(test, link);
 
 	link->dpcd_caps.dongle_type = DISPLAY_DONGLE_DP_HDMI_CONVERTER;
 	KUNIT_EXPECT_EQ(test, (int)get_subconnector_type(link), (int)DRM_MODE_SUBCONNECTOR_HDMIA);
@@ -116,7 +116,7 @@ static void dm_test_subconnector_type_hdmi_dongle(struct kunit *test)
 {
 	struct dc_link *link = kunit_kzalloc(test, sizeof(*link), GFP_KERNEL);
 
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, link);
+	KUNIT_ASSERT_NOT_NULL(test, link);
 
 	link->dpcd_caps.dongle_type = DISPLAY_DONGLE_DP_HDMI_DONGLE;
 	KUNIT_EXPECT_EQ(test, (int)get_subconnector_type(link), (int)DRM_MODE_SUBCONNECTOR_HDMIA);
@@ -130,7 +130,7 @@ static void dm_test_subconnector_type_mismatched(struct kunit *test)
 {
 	struct dc_link *link = kunit_kzalloc(test, sizeof(*link), GFP_KERNEL);
 
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, link);
+	KUNIT_ASSERT_NOT_NULL(test, link);
 
 	link->dpcd_caps.dongle_type = DISPLAY_DONGLE_DP_HDMI_MISMATCHED_DONGLE;
 	KUNIT_EXPECT_EQ(test, (int)get_subconnector_type(link), (int)DRM_MODE_SUBCONNECTOR_Unknown);
@@ -144,7 +144,7 @@ static void dm_test_subconnector_type_default_unknown(struct kunit *test)
 {
 	struct dc_link *link = kunit_kzalloc(test, sizeof(*link), GFP_KERNEL);
 
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, link);
+	KUNIT_ASSERT_NOT_NULL(test, link);
 
 	link->dpcd_caps.dongle_type = (typeof(link->dpcd_caps.dongle_type))0x7f;
 	KUNIT_EXPECT_EQ(test, (int)get_subconnector_type(link), (int)DRM_MODE_SUBCONNECTOR_Unknown);
@@ -842,7 +842,7 @@ static void dm_test_color_depth_from_info_bpc8(struct kunit *test)
 	struct drm_connector *connector;
 
 	connector = kunit_kzalloc(test, sizeof(*connector), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, connector);
+	KUNIT_ASSERT_NOT_NULL(test, connector);
 
 	connector->display_info.bpc = 8;
 	KUNIT_EXPECT_EQ(test, (int)amdgpu_dm_convert_color_depth_from_display_info(connector, false, 0),
@@ -858,7 +858,7 @@ static void dm_test_color_depth_from_info_bpc10(struct kunit *test)
 	struct drm_connector *connector;
 
 	connector = kunit_kzalloc(test, sizeof(*connector), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, connector);
+	KUNIT_ASSERT_NOT_NULL(test, connector);
 
 	connector->display_info.bpc = 10;
 	KUNIT_EXPECT_EQ(test, (int)amdgpu_dm_convert_color_depth_from_display_info(connector, false, 0),
@@ -875,7 +875,7 @@ static void dm_test_color_depth_from_info_zero_bpc_defaults_888(struct kunit *te
 	struct drm_connector *connector;
 
 	connector = kunit_kzalloc(test, sizeof(*connector), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, connector);
+	KUNIT_ASSERT_NOT_NULL(test, connector);
 
 	connector->display_info.bpc = 0;
 	KUNIT_EXPECT_EQ(test, (int)amdgpu_dm_convert_color_depth_from_display_info(connector, false, 0),
@@ -891,7 +891,7 @@ static void dm_test_color_depth_from_info_requested_bpc_caps(struct kunit *test)
 	struct drm_connector *connector;
 
 	connector = kunit_kzalloc(test, sizeof(*connector), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, connector);
+	KUNIT_ASSERT_NOT_NULL(test, connector);
 
 	/* Display supports 12bpc but user requests max 10 */
 	connector->display_info.bpc = 12;
@@ -908,7 +908,7 @@ static void dm_test_color_depth_from_info_y420_default(struct kunit *test)
 	struct drm_connector *connector;
 
 	connector = kunit_kzalloc(test, sizeof(*connector), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, connector);
+	KUNIT_ASSERT_NOT_NULL(test, connector);
 
 	/* No Y420 DC modes set → 8bpc */
 	KUNIT_EXPECT_EQ(test, (int)amdgpu_dm_convert_color_depth_from_display_info(connector, true, 0),
@@ -924,7 +924,7 @@ static void dm_test_color_depth_from_info_y420_10bpc(struct kunit *test)
 	struct drm_connector *connector;
 
 	connector = kunit_kzalloc(test, sizeof(*connector), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, connector);
+	KUNIT_ASSERT_NOT_NULL(test, connector);
 
 	connector->display_info.hdmi.y420_dc_modes = DRM_EDID_YCBCR420_DC_30;
 	KUNIT_EXPECT_EQ(test, (int)amdgpu_dm_convert_color_depth_from_display_info(connector, true, 0),
@@ -940,7 +940,7 @@ static void dm_test_color_depth_from_info_y420_12bpc(struct kunit *test)
 	struct drm_connector *connector;
 
 	connector = kunit_kzalloc(test, sizeof(*connector), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, connector);
+	KUNIT_ASSERT_NOT_NULL(test, connector);
 
 	connector->display_info.hdmi.y420_dc_modes = DRM_EDID_YCBCR420_DC_36;
 	KUNIT_EXPECT_EQ(test, (int)amdgpu_dm_convert_color_depth_from_display_info(connector, true, 0),
@@ -956,7 +956,7 @@ static void dm_test_color_depth_from_info_y420_16bpc(struct kunit *test)
 	struct drm_connector *connector;
 
 	connector = kunit_kzalloc(test, sizeof(*connector), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, connector);
+	KUNIT_ASSERT_NOT_NULL(test, connector);
 
 	connector->display_info.hdmi.y420_dc_modes = DRM_EDID_YCBCR420_DC_48;
 	KUNIT_EXPECT_EQ(test, (int)amdgpu_dm_convert_color_depth_from_display_info(connector, true, 0),
@@ -972,7 +972,7 @@ static void dm_test_color_depth_from_info_requested_odd_bpc(struct kunit *test)
 	struct drm_connector *connector;
 
 	connector = kunit_kzalloc(test, sizeof(*connector), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, connector);
+	KUNIT_ASSERT_NOT_NULL(test, connector);
 
 	connector->display_info.bpc = 12;
 	KUNIT_EXPECT_EQ(test, (int)amdgpu_dm_convert_color_depth_from_display_info(connector, false, 11),
@@ -988,7 +988,7 @@ static void dm_test_color_depth_from_info_unsupported_bpc(struct kunit *test)
 	struct drm_connector *connector;
 
 	connector = kunit_kzalloc(test, sizeof(*connector), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, connector);
+	KUNIT_ASSERT_NOT_NULL(test, connector);
 
 	connector->display_info.bpc = 9;
 	KUNIT_EXPECT_EQ(test, (int)amdgpu_dm_convert_color_depth_from_display_info(connector, false, 0),
@@ -1133,7 +1133,7 @@ static void dm_test_is_duplicate_mode_empty_list(struct kunit *test)
 	struct drm_display_mode mode = {};
 
 	aconnector = kunit_kzalloc(test, sizeof(*aconnector), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, aconnector);
+	KUNIT_ASSERT_NOT_NULL(test, aconnector);
 
 	INIT_LIST_HEAD(&aconnector->base.probed_modes);
 	mode.hdisplay = 1920;
@@ -1153,7 +1153,7 @@ static void dm_test_is_duplicate_mode_match(struct kunit *test)
 	struct drm_display_mode candidate = {};
 
 	aconnector = kunit_kzalloc(test, sizeof(*aconnector), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, aconnector);
+	KUNIT_ASSERT_NOT_NULL(test, aconnector);
 
 	INIT_LIST_HEAD(&aconnector->base.probed_modes);
 	existing.hdisplay = 1920;
@@ -1179,7 +1179,7 @@ static void dm_test_is_duplicate_mode_no_match(struct kunit *test)
 	struct drm_display_mode candidate = {};
 
 	aconnector = kunit_kzalloc(test, sizeof(*aconnector), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, aconnector);
+	KUNIT_ASSERT_NOT_NULL(test, aconnector);
 
 	INIT_LIST_HEAD(&aconnector->base.probed_modes);
 	existing.hdisplay = 1920;
@@ -1206,7 +1206,7 @@ static void dm_test_is_duplicate_mode_same_size_different_clock(struct kunit *te
 	struct drm_display_mode candidate = {};
 
 	aconnector = kunit_kzalloc(test, sizeof(*aconnector), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, aconnector);
+	KUNIT_ASSERT_NOT_NULL(test, aconnector);
 
 	INIT_LIST_HEAD(&aconnector->base.probed_modes);
 	existing.hdisplay = 1920;
@@ -1232,7 +1232,7 @@ static void dm_test_encoder_crtc_mask_1(struct kunit *test)
 	struct amdgpu_device *adev;
 
 	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev);
+	KUNIT_ASSERT_NOT_NULL(test, adev);
 
 	adev->mode_info.num_crtc = 1;
 	KUNIT_EXPECT_EQ(test, amdgpu_dm_get_encoder_crtc_mask(adev), 0x1);
@@ -1247,7 +1247,7 @@ static void dm_test_encoder_crtc_mask_2(struct kunit *test)
 	struct amdgpu_device *adev;
 
 	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev);
+	KUNIT_ASSERT_NOT_NULL(test, adev);
 
 	adev->mode_info.num_crtc = 2;
 	KUNIT_EXPECT_EQ(test, amdgpu_dm_get_encoder_crtc_mask(adev), 0x3);
@@ -1262,7 +1262,7 @@ static void dm_test_encoder_crtc_mask_3(struct kunit *test)
 	struct amdgpu_device *adev;
 
 	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev);
+	KUNIT_ASSERT_NOT_NULL(test, adev);
 
 	adev->mode_info.num_crtc = 3;
 	KUNIT_EXPECT_EQ(test, amdgpu_dm_get_encoder_crtc_mask(adev), 0x7);
@@ -1277,7 +1277,7 @@ static void dm_test_encoder_crtc_mask_4(struct kunit *test)
 	struct amdgpu_device *adev;
 
 	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev);
+	KUNIT_ASSERT_NOT_NULL(test, adev);
 
 	adev->mode_info.num_crtc = 4;
 	KUNIT_EXPECT_EQ(test, amdgpu_dm_get_encoder_crtc_mask(adev), 0xf);
@@ -1292,7 +1292,7 @@ static void dm_test_encoder_crtc_mask_5(struct kunit *test)
 	struct amdgpu_device *adev;
 
 	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev);
+	KUNIT_ASSERT_NOT_NULL(test, adev);
 
 	adev->mode_info.num_crtc = 5;
 	KUNIT_EXPECT_EQ(test, amdgpu_dm_get_encoder_crtc_mask(adev), 0x1f);
@@ -1307,7 +1307,7 @@ static void dm_test_encoder_crtc_mask_6(struct kunit *test)
 	struct amdgpu_device *adev;
 
 	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev);
+	KUNIT_ASSERT_NOT_NULL(test, adev);
 
 	adev->mode_info.num_crtc = 6;
 	KUNIT_EXPECT_EQ(test, amdgpu_dm_get_encoder_crtc_mask(adev), 0x3f);
@@ -1322,7 +1322,7 @@ static void dm_test_encoder_crtc_mask_default(struct kunit *test)
 	struct amdgpu_device *adev;
 
 	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev);
+	KUNIT_ASSERT_NOT_NULL(test, adev);
 
 	/* Values > 6 use the default case */
 	adev->mode_info.num_crtc = 8;
@@ -2527,9 +2527,9 @@ static void setup_cacp_fixture(struct kunit *test,
 	fixture->aconnector = kunit_kzalloc(test, sizeof(*fixture->aconnector),
 					    GFP_KERNEL);
 	fixture->link = kunit_kzalloc(test, sizeof(*fixture->link), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, fixture->adev);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, fixture->aconnector);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, fixture->link);
+	KUNIT_ASSERT_NOT_NULL(test, fixture->adev);
+	KUNIT_ASSERT_NOT_NULL(test, fixture->aconnector);
+	KUNIT_ASSERT_NOT_NULL(test, fixture->link);
 
 	fixture->aconnector->dc_link = fixture->link;
 	fixture->aconnector->base.dev = &fixture->adev->ddev;
@@ -2675,11 +2675,11 @@ static void setup_panel_type_fixture(struct kunit *test,
 
 	fixture->aconnector = drmm_kzalloc(fixture->drm, sizeof(*fixture->aconnector),
 					   GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, fixture->aconnector);
+	KUNIT_ASSERT_NOT_NULL(test, fixture->aconnector);
 	fixture->link = kunit_kzalloc(test, sizeof(*fixture->link), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, fixture->link);
+	KUNIT_ASSERT_NOT_NULL(test, fixture->link);
 	fixture->sink = kunit_kzalloc(test, sizeof(*fixture->sink), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, fixture->sink);
+	KUNIT_ASSERT_NOT_NULL(test, fixture->sink);
 
 	fixture->aconnector->dc_link = fixture->link;
 	drmm_connector_init(fixture->drm, &fixture->aconnector->base,
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_crtc_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_crtc_test.c
index 3ea252ed1259..20ad887979f7 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_crtc_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_crtc_test.c
@@ -114,7 +114,7 @@ static void dm_test_crtc_vrr_active_irq_variable(struct kunit *test)
 	struct amdgpu_crtc *acrtc = kunit_kzalloc(test, sizeof(*acrtc),
 						  GFP_KERNEL);
 
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, acrtc);
+	KUNIT_ASSERT_NOT_NULL(test, acrtc);
 
 	acrtc->dm_irq_params.freesync_config.state = VRR_STATE_ACTIVE_VARIABLE;
 
@@ -130,7 +130,7 @@ static void dm_test_crtc_vrr_active_irq_fixed(struct kunit *test)
 	struct amdgpu_crtc *acrtc = kunit_kzalloc(test, sizeof(*acrtc),
 						  GFP_KERNEL);
 
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, acrtc);
+	KUNIT_ASSERT_NOT_NULL(test, acrtc);
 
 	acrtc->dm_irq_params.freesync_config.state = VRR_STATE_ACTIVE_FIXED;
 
@@ -146,7 +146,7 @@ static void dm_test_crtc_vrr_active_irq_inactive(struct kunit *test)
 	struct amdgpu_crtc *acrtc = kunit_kzalloc(test, sizeof(*acrtc),
 						  GFP_KERNEL);
 
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, acrtc);
+	KUNIT_ASSERT_NOT_NULL(test, acrtc);
 
 	acrtc->dm_irq_params.freesync_config.state = VRR_STATE_INACTIVE;
 
@@ -162,7 +162,7 @@ static void dm_test_crtc_vrr_active_irq_disabled(struct kunit *test)
 	struct amdgpu_crtc *acrtc = kunit_kzalloc(test, sizeof(*acrtc),
 						  GFP_KERNEL);
 
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, acrtc);
+	KUNIT_ASSERT_NOT_NULL(test, acrtc);
 
 	acrtc->dm_irq_params.freesync_config.state = VRR_STATE_DISABLED;
 
@@ -178,7 +178,7 @@ static void dm_test_crtc_vrr_active_irq_unsupported(struct kunit *test)
 	struct amdgpu_crtc *acrtc = kunit_kzalloc(test, sizeof(*acrtc),
 						  GFP_KERNEL);
 
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, acrtc);
+	KUNIT_ASSERT_NOT_NULL(test, acrtc);
 
 	acrtc->dm_irq_params.freesync_config.state = VRR_STATE_UNSUPPORTED;
 
@@ -197,7 +197,7 @@ static void dm_test_crtc_vrr_active_variable(struct kunit *test)
 						       sizeof(*dm_state),
 						       GFP_KERNEL);
 
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dm_state);
+	KUNIT_ASSERT_NOT_NULL(test, dm_state);
 
 	dm_state->freesync_config.state = VRR_STATE_ACTIVE_VARIABLE;
 
@@ -214,7 +214,7 @@ static void dm_test_crtc_vrr_active_fixed(struct kunit *test)
 						       sizeof(*dm_state),
 						       GFP_KERNEL);
 
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dm_state);
+	KUNIT_ASSERT_NOT_NULL(test, dm_state);
 
 	dm_state->freesync_config.state = VRR_STATE_ACTIVE_FIXED;
 
@@ -231,7 +231,7 @@ static void dm_test_crtc_vrr_active_inactive(struct kunit *test)
 						       sizeof(*dm_state),
 						       GFP_KERNEL);
 
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dm_state);
+	KUNIT_ASSERT_NOT_NULL(test, dm_state);
 
 	dm_state->freesync_config.state = VRR_STATE_INACTIVE;
 
@@ -248,7 +248,7 @@ static void dm_test_crtc_vrr_active_disabled(struct kunit *test)
 						       sizeof(*dm_state),
 						       GFP_KERNEL);
 
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dm_state);
+	KUNIT_ASSERT_NOT_NULL(test, dm_state);
 
 	dm_state->freesync_config.state = VRR_STATE_DISABLED;
 
@@ -265,7 +265,7 @@ static void dm_test_crtc_vrr_active_unsupported(struct kunit *test)
 						       sizeof(*dm_state),
 						       GFP_KERNEL);
 
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dm_state);
+	KUNIT_ASSERT_NOT_NULL(test, dm_state);
 
 	dm_state->freesync_config.state = VRR_STATE_UNSUPPORTED;
 
@@ -304,7 +304,7 @@ static void dm_test_crtc_is_headless_no_connectors(struct kunit *test)
 	struct amdgpu_device *adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
 	struct drm_device *dev = dm_kunit_alloc_drm_with_connector_list(test);
 
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev);
+	KUNIT_ASSERT_NOT_NULL(test, adev);
 	adev->dm.ddev = dev;
 
 	KUNIT_EXPECT_TRUE(test, amdgpu_dm_is_headless(adev));
@@ -320,8 +320,8 @@ static void dm_test_crtc_is_headless_writeback_only(struct kunit *test)
 	struct drm_device *dev = dm_kunit_alloc_drm_with_connector_list(test);
 	struct drm_connector *wb = kunit_kzalloc(test, sizeof(*wb), GFP_KERNEL);
 
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, wb);
+	KUNIT_ASSERT_NOT_NULL(test, adev);
+	KUNIT_ASSERT_NOT_NULL(test, wb);
 	adev->dm.ddev = dev;
 
 	dm_test_add_connector(dev, wb, DRM_MODE_CONNECTOR_WRITEBACK,
@@ -340,8 +340,8 @@ static void dm_test_crtc_is_headless_disconnected_display(struct kunit *test)
 	struct drm_device *dev = dm_kunit_alloc_drm_with_connector_list(test);
 	struct drm_connector *display = kunit_kzalloc(test, sizeof(*display), GFP_KERNEL);
 
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, display);
+	KUNIT_ASSERT_NOT_NULL(test, adev);
+	KUNIT_ASSERT_NOT_NULL(test, display);
 	adev->dm.ddev = dev;
 
 	dm_test_add_connector(dev, display, DRM_MODE_CONNECTOR_HDMIA,
@@ -360,8 +360,8 @@ static void dm_test_crtc_is_headless_connected_display(struct kunit *test)
 	struct drm_device *dev = dm_kunit_alloc_drm_with_connector_list(test);
 	struct drm_connector *display = kunit_kzalloc(test, sizeof(*display), GFP_KERNEL);
 
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, display);
+	KUNIT_ASSERT_NOT_NULL(test, adev);
+	KUNIT_ASSERT_NOT_NULL(test, display);
 	adev->dm.ddev = dev;
 
 	dm_test_add_connector(dev, display, DRM_MODE_CONNECTOR_HDMIA,
@@ -381,9 +381,9 @@ static void dm_test_crtc_is_headless_mixed_connectors(struct kunit *test)
 	struct drm_connector *wb = kunit_kzalloc(test, sizeof(*wb), GFP_KERNEL);
 	struct drm_connector *display = kunit_kzalloc(test, sizeof(*display), GFP_KERNEL);
 
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, wb);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, display);
+	KUNIT_ASSERT_NOT_NULL(test, adev);
+	KUNIT_ASSERT_NOT_NULL(test, wb);
+	KUNIT_ASSERT_NOT_NULL(test, display);
 	adev->dm.ddev = dev;
 
 	dm_test_add_connector(dev, wb, DRM_MODE_CONNECTOR_WRITEBACK,
@@ -426,7 +426,7 @@ static void dm_test_crtc_set_vupdate_irq_no_otg(struct kunit *test)
 	adev = dm_kunit_alloc_adev(test);
 
 	acrtc = kunit_kzalloc(test, sizeof(*acrtc), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, acrtc);
+	KUNIT_ASSERT_NOT_NULL(test, acrtc);
 
 	acrtc->base.dev = &adev->ddev;
 	acrtc->otg_inst = -1;
@@ -451,7 +451,7 @@ static void dm_test_crtc_set_vupdate_irq_dc_busy(struct kunit *test)
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev);
 
 	acrtc = kunit_kzalloc(test, sizeof(*acrtc), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, acrtc);
+	KUNIT_ASSERT_NOT_NULL(test, acrtc);
 
 	acrtc->base.dev = &adev->ddev;
 	acrtc->otg_inst = 0;
@@ -514,19 +514,19 @@ static void dm_test_crtc_set_vupdate_irq_enable(struct kunit *test)
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev);
 
 	acrtc = kunit_kzalloc(test, sizeof(*acrtc), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, acrtc);
+	KUNIT_ASSERT_NOT_NULL(test, acrtc);
 
 	dc = dm_kunit_alloc_dc_with_ctx(test);
 	res_pool = kunit_kzalloc(test, sizeof(*res_pool), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, res_pool);
+	KUNIT_ASSERT_NOT_NULL(test, res_pool);
 	irqs = kunit_kzalloc(test, sizeof(*irqs), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, irqs);
+	KUNIT_ASSERT_NOT_NULL(test, irqs);
 
 	/*
 	 * Populate the per-source info table so amdgpu_dm_irq_set() succeeds.
 	 */
 	info = kunit_kcalloc(test, DAL_IRQ_SOURCES_NUMBER, sizeof(*info), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, info);
+	KUNIT_ASSERT_NOT_NULL(test, info);
 	for (i = 0; i < DAL_IRQ_SOURCES_NUMBER; i++)
 		info[i].funcs = &dm_test_vupdate_irq_src_funcs;
 
@@ -559,7 +559,7 @@ static void dm_test_idle_create_workqueue(struct kunit *test)
 	struct idle_workqueue *idle_work;
 
 	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev);
+	KUNIT_ASSERT_NOT_NULL(test, adev);
 
 	idle_work = idle_create_workqueue(adev);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, idle_work);
@@ -587,7 +587,7 @@ static void dm_test_idle_worker_disabled_clears_running(struct kunit *test)
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev);
 
 	idle_work = kunit_kzalloc(test, sizeof(*idle_work), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, idle_work);
+	KUNIT_ASSERT_NOT_NULL(test, idle_work);
 
 	idle_work->dm = &adev->dm;
 	idle_work->enable = false;
@@ -622,7 +622,7 @@ static void dm_test_idle_worker_enabled_breaks_when_idle_disallowed(struct kunit
 	adev->dm.dc->idle_optimizations_allowed = false;
 
 	idle_work = kunit_kzalloc(test, sizeof(*idle_work), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, idle_work);
+	KUNIT_ASSERT_NOT_NULL(test, idle_work);
 
 	idle_work->dm = &adev->dm;
 	idle_work->enable = true;
@@ -667,12 +667,12 @@ static void dm_test_idle_worker_enabled_breaks_when_not_headless(struct kunit *t
 
 	/* A connected display makes amdgpu_dm_is_headless() false. */
 	display = kunit_kzalloc(test, sizeof(*display), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, display);
+	KUNIT_ASSERT_NOT_NULL(test, display);
 	dm_test_add_connector(adev->dm.ddev, display, DRM_MODE_CONNECTOR_HDMIA,
 			      connector_status_connected);
 
 	idle_work = kunit_kzalloc(test, sizeof(*idle_work), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, idle_work);
+	KUNIT_ASSERT_NOT_NULL(test, idle_work);
 	idle_work->dm = &adev->dm;
 	idle_work->enable = true;
 	adev->dm.idle_workqueue = idle_work;
@@ -726,7 +726,7 @@ static void dm_test_idle_worker_enabled_runs_body(struct kunit *test)
 	adev->dm.dc->caps.is_apu = true;
 	/* dc_allow() logs via DC_LOG_DEBUG() when it flips the flag. */
 	logger = kunit_kzalloc(test, sizeof(*logger), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, logger);
+	KUNIT_ASSERT_NOT_NULL(test, logger);
 	logger->dev = &adev->ddev;
 	adev->dm.dc->ctx->logger = logger;
 	/* dc_allow() only flips the flag when clk_mgr and apply() are present. */
@@ -735,7 +735,7 @@ static void dm_test_idle_worker_enabled_runs_body(struct kunit *test)
 	adev->dm.dc->hwss.apply_idle_power_optimizations = dm_test_idle_apply_flip;
 
 	idle_work = kunit_kzalloc(test, sizeof(*idle_work), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, idle_work);
+	KUNIT_ASSERT_NOT_NULL(test, idle_work);
 	idle_work->dm = &adev->dm;
 	idle_work->enable = true;
 	adev->dm.idle_workqueue = idle_work;
@@ -763,7 +763,7 @@ static void dm_test_crtc_set_static_screen_optimze_no_sr_entry(struct kunit *tes
 	struct dc_stream_state *stream;
 
 	dm = kunit_kzalloc(test, sizeof(*dm), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dm);
+	KUNIT_ASSERT_NOT_NULL(test, dm);
 
 	link = dm_kunit_alloc_link(test);
 	stream = dm_kunit_alloc_stream(test, link);
@@ -789,7 +789,7 @@ static void dm_test_crtc_set_static_screen_optimze_sr_entry_psr(struct kunit *te
 	struct dc_stream_state *stream;
 
 	dm = kunit_kzalloc(test, sizeof(*dm), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dm);
+	KUNIT_ASSERT_NOT_NULL(test, dm);
 
 	link = dm_kunit_alloc_link(test);
 	stream = dm_kunit_alloc_stream(test, link);
@@ -815,7 +815,7 @@ static void dm_test_crtc_set_static_screen_optimze_psr_su_skips(struct kunit *te
 	struct dc_stream_state *stream;
 
 	dm = kunit_kzalloc(test, sizeof(*dm), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dm);
+	KUNIT_ASSERT_NOT_NULL(test, dm);
 
 	link = dm_kunit_alloc_link(test);
 	stream = dm_kunit_alloc_stream(test, link);
@@ -841,7 +841,7 @@ static void dm_test_crtc_enable_vblank_rejects_unconfigured(struct kunit *test)
 	struct amdgpu_crtc *acrtc;
 
 	acrtc = kunit_kzalloc(test, sizeof(*acrtc), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, acrtc);
+	KUNIT_ASSERT_NOT_NULL(test, acrtc);
 
 	acrtc->base.dev = &adev->ddev;
 	acrtc->base.enabled = false;
@@ -925,7 +925,7 @@ static void dm_test_crtc_arm_irq_src(struct kunit *test,
 	atomic_t *enabled;
 
 	enabled = kunit_kzalloc(test, sizeof(*enabled), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, enabled);
+	KUNIT_ASSERT_NOT_NULL(test, enabled);
 
 	atomic_set(enabled, count);
 	src->num_types = 1;
@@ -969,11 +969,11 @@ dm_test_crtc_setup_enable(struct kunit *test, struct amdgpu_device **adev_out,
 	adev->mode_info.num_crtc = 1;
 
 	reset_domain = kunit_kzalloc(test, sizeof(*reset_domain), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, reset_domain);
+	KUNIT_ASSERT_NOT_NULL(test, reset_domain);
 	adev->reset_domain = reset_domain;
 
 	acrtc = kunit_kzalloc(test, sizeof(*acrtc), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, acrtc);
+	KUNIT_ASSERT_NOT_NULL(test, acrtc);
 	acrtc->base.dev = &adev->ddev;
 	acrtc->base.funcs = &dm_test_crtc_funcs;
 	acrtc->base.enabled = true;
@@ -987,7 +987,7 @@ dm_test_crtc_setup_enable(struct kunit *test, struct amdgpu_device **adev_out,
 	stream = dm_kunit_alloc_stream(test, link);
 
 	dm_state = kunit_kzalloc(test, sizeof(*dm_state), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dm_state);
+	KUNIT_ASSERT_NOT_NULL(test, dm_state);
 	dm_state->stream = stream;
 	acrtc->base.state = &dm_state->base;
 
@@ -1052,15 +1052,15 @@ static void dm_test_crtc_enable_vblank_vupdate_busy(struct kunit *test)
 	acrtc_state->freesync_config.state = VRR_STATE_ACTIVE_VARIABLE;
 
 	res_pool = kunit_kzalloc(test, sizeof(*res_pool), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, res_pool);
+	KUNIT_ASSERT_NOT_NULL(test, res_pool);
 	irqs = kunit_kzalloc(test, sizeof(*irqs), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, irqs);
+	KUNIT_ASSERT_NOT_NULL(test, irqs);
 
 	/*
 	 * Per-source .set fails so amdgpu_dm_irq_set() reports the source busy.
 	 */
 	info = kunit_kcalloc(test, DAL_IRQ_SOURCES_NUMBER, sizeof(*info), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, info);
+	KUNIT_ASSERT_NOT_NULL(test, info);
 	for (i = 0; i < DAL_IRQ_SOURCES_NUMBER; i++)
 		info[i].funcs = &dm_test_vupdate_irq_src_busy_funcs;
 
@@ -1284,7 +1284,7 @@ static struct drm_crtc *dm_test_crtc_setup_vline0(struct kunit *test,
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev);
 
 	crtc = kunit_kzalloc(test, sizeof(*crtc), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, crtc);
+	KUNIT_ASSERT_NOT_NULL(test, crtc);
 	crtc->dev = &adev->ddev;
 
 	adev->ip_versions[DCE_HWIP][0] = ip_version;
@@ -1373,7 +1373,7 @@ static void dm_test_crtc_update_active_planes_no_stream(struct kunit *test)
 	struct dm_crtc_state *dm_state;
 
 	dm_state = kunit_kzalloc(test, sizeof(*dm_state), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dm_state);
+	KUNIT_ASSERT_NOT_NULL(test, dm_state);
 
 	dm_state->stream = NULL;
 	dm_state->active_planes = 5;
@@ -1411,11 +1411,11 @@ static void dm_test_count_crtc_active_planes_none(struct kunit *test)
 	INIT_LIST_HEAD(&dev->mode_config.plane_list);
 
 	state = kunit_kzalloc(test, sizeof(*state), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, state);
+	KUNIT_ASSERT_NOT_NULL(test, state);
 	state->dev = dev;
 
 	crtc_state = kunit_kzalloc(test, sizeof(*crtc_state), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, crtc_state);
+	KUNIT_ASSERT_NOT_NULL(test, crtc_state);
 	crtc_state->state = state;
 	crtc_state->plane_mask = 0;
 
@@ -1450,15 +1450,15 @@ static void dm_test_count_crtc_active_planes_mixed(struct kunit *test)
 	INIT_LIST_HEAD(&dev->mode_config.plane_list);
 
 	plane_no_state = kunit_kzalloc(test, sizeof(*plane_no_state), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, plane_no_state);
+	KUNIT_ASSERT_NOT_NULL(test, plane_no_state);
 	plane_cursor = kunit_kzalloc(test, sizeof(*plane_cursor), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, plane_cursor);
+	KUNIT_ASSERT_NOT_NULL(test, plane_cursor);
 	plane_with_fb = kunit_kzalloc(test, sizeof(*plane_with_fb), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, plane_with_fb);
+	KUNIT_ASSERT_NOT_NULL(test, plane_with_fb);
 	plane_no_fb = kunit_kzalloc(test, sizeof(*plane_no_fb), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, plane_no_fb);
+	KUNIT_ASSERT_NOT_NULL(test, plane_no_fb);
 	plane_excluded = kunit_kzalloc(test, sizeof(*plane_excluded), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, plane_excluded);
+	KUNIT_ASSERT_NOT_NULL(test, plane_excluded);
 
 	dm_test_add_plane(dev, plane_no_state, 0, DRM_PLANE_TYPE_PRIMARY);
 	dm_test_add_plane(dev, plane_cursor, 1, DRM_PLANE_TYPE_CURSOR);
@@ -1467,19 +1467,19 @@ static void dm_test_count_crtc_active_planes_mixed(struct kunit *test)
 	dm_test_add_plane(dev, plane_excluded, 4, DRM_PLANE_TYPE_PRIMARY);
 
 	fb = kunit_kzalloc(test, sizeof(*fb), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, fb);
+	KUNIT_ASSERT_NOT_NULL(test, fb);
 	ps_fb = kunit_kzalloc(test, sizeof(*ps_fb), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ps_fb);
+	KUNIT_ASSERT_NOT_NULL(test, ps_fb);
 	ps_fb->fb = fb;
 	ps_no_fb = kunit_kzalloc(test, sizeof(*ps_no_fb), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ps_no_fb);
+	KUNIT_ASSERT_NOT_NULL(test, ps_no_fb);
 	ps_no_fb->fb = NULL;
 
 	state = kunit_kzalloc(test, sizeof(*state), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, state);
+	KUNIT_ASSERT_NOT_NULL(test, state);
 	state->dev = dev;
 	state->planes = kunit_kcalloc(test, 5, sizeof(*state->planes), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, state->planes);
+	KUNIT_ASSERT_NOT_NULL(test, state->planes);
 	state->planes[0].new_state = NULL;
 	state->planes[1].new_state = ps_fb;
 	state->planes[2].new_state = ps_fb;
@@ -1487,7 +1487,7 @@ static void dm_test_count_crtc_active_planes_mixed(struct kunit *test)
 	state->planes[4].new_state = ps_fb;
 
 	crtc_state = kunit_kzalloc(test, sizeof(*crtc_state), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, crtc_state);
+	KUNIT_ASSERT_NOT_NULL(test, crtc_state);
 	crtc_state->state = state;
 	/* Exclude plane index 4 from the CRTC. */
 	crtc_state->plane_mask = BIT(0) | BIT(1) | BIT(2) | BIT(3);
@@ -1512,9 +1512,9 @@ static void dm_test_crtc_duplicate_state_copies_fields(struct kunit *test)
 	struct dm_crtc_state *dm_dup;
 
 	crtc = kunit_kzalloc(test, sizeof(*crtc), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, crtc);
+	KUNIT_ASSERT_NOT_NULL(test, crtc);
 	cur = kunit_kzalloc(test, sizeof(*cur), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, cur);
+	KUNIT_ASSERT_NOT_NULL(test, cur);
 
 	cur->abm_level = 3;
 	cur->active_planes = 2;
@@ -1558,9 +1558,9 @@ static void dm_test_crtc_duplicate_state_retains_stream(struct kunit *test)
 	struct dc_link *link;
 
 	crtc = kunit_kzalloc(test, sizeof(*crtc), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, crtc);
+	KUNIT_ASSERT_NOT_NULL(test, crtc);
 	cur = kunit_kzalloc(test, sizeof(*cur), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, cur);
+	KUNIT_ASSERT_NOT_NULL(test, cur);
 
 	link = dm_kunit_alloc_link(test);
 	stream = dm_kunit_alloc_stream(test, link);
@@ -1593,7 +1593,7 @@ static void dm_test_crtc_duplicate_state_null_state_returns_null(struct kunit *t
 	struct drm_crtc *crtc;
 
 	crtc = kunit_kzalloc(test, sizeof(*crtc), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, crtc);
+	KUNIT_ASSERT_NOT_NULL(test, crtc);
 	crtc->state = NULL;
 
 	KUNIT_EXPECT_NULL(test, amdgpu_dm_crtc_duplicate_state(crtc));
@@ -1627,7 +1627,7 @@ static void dm_test_crtc_destroy_cleans_up_and_frees(struct kunit *test)
 
 	/* amdgpu_dm_crtc_destroy() kfree()s the CRTC, so use a plain alloc. */
 	acrtc = kzalloc_obj(*acrtc, GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, acrtc);
+	KUNIT_ASSERT_NOT_NULL(test, acrtc);
 
 	ret = drm_crtc_init_with_planes(&adev->ddev, &acrtc->base, plane,
 					NULL, &dm_test_crtc_funcs, NULL);
@@ -1655,7 +1655,7 @@ static void dm_test_crtc_reset_state_allocates_state(struct kunit *test)
 	struct drm_crtc *crtc;
 
 	crtc = kunit_kzalloc(test, sizeof(*crtc), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, crtc);
+	KUNIT_ASSERT_NOT_NULL(test, crtc);
 	crtc->dev = &adev->ddev;
 	crtc->state = NULL;
 
@@ -1685,7 +1685,7 @@ static void dm_test_crtc_reset_state_replaces_existing(struct kunit *test)
 	struct dc_link *link;
 
 	crtc = kunit_kzalloc(test, sizeof(*crtc), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, crtc);
+	KUNIT_ASSERT_NOT_NULL(test, crtc);
 	crtc->dev = &adev->ddev;
 
 	link = dm_kunit_alloc_link(test);
@@ -1695,7 +1695,7 @@ static void dm_test_crtc_reset_state_replaces_existing(struct kunit *test)
 
 	/* reset_state kfree()s the old state, so use a plain (unmanaged) alloc. */
 	old = kzalloc_obj(*old, GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, old);
+	KUNIT_ASSERT_NOT_NULL(test, old);
 	old->stream = stream;
 	crtc->state = &old->base;
 
@@ -1724,7 +1724,7 @@ static void dm_test_crtc_destroy_state_no_stream(struct kunit *test)
 
 	/* destroy_state kfree()s the state, so use a plain (unmanaged) alloc. */
 	dm_state = kzalloc_obj(*dm_state, GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dm_state);
+	KUNIT_ASSERT_NOT_NULL(test, dm_state);
 
 	amdgpu_dm_crtc_destroy_state(NULL, &dm_state->base);
 }
@@ -1754,7 +1754,7 @@ static void dm_test_crtc_destroy_state_releases_stream(struct kunit *test)
 
 	/* destroy_state kfree()s the state, so use a plain (unmanaged) alloc. */
 	dm_state = kzalloc_obj(*dm_state, GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dm_state);
+	KUNIT_ASSERT_NOT_NULL(test, dm_state);
 	dm_state->stream = stream;
 
 	amdgpu_dm_crtc_destroy_state(NULL, &dm_state->base);
@@ -1782,7 +1782,7 @@ static void dm_test_crtc_handle_vblank_no_event(struct kunit *test)
 	KUNIT_ASSERT_EQ(test, drm_vblank_init(&adev->ddev, 1), 0);
 
 	acrtc = kunit_kzalloc(test, sizeof(*acrtc), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, acrtc);
+	KUNIT_ASSERT_NOT_NULL(test, acrtc);
 	acrtc->base.dev = &adev->ddev;
 	acrtc->event = NULL;
 
@@ -1810,9 +1810,9 @@ static void dm_test_crtc_handle_vblank_skips_when_flip_submitted(struct kunit *t
 	KUNIT_ASSERT_EQ(test, drm_vblank_init(&adev->ddev, 1), 0);
 
 	acrtc = kunit_kzalloc(test, sizeof(*acrtc), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, acrtc);
+	KUNIT_ASSERT_NOT_NULL(test, acrtc);
 	event = kunit_kzalloc(test, sizeof(*event), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, event);
+	KUNIT_ASSERT_NOT_NULL(test, event);
 
 	acrtc->base.dev = &adev->ddev;
 	acrtc->base.funcs = &dm_test_crtc_funcs;
@@ -1849,11 +1849,11 @@ static void dm_test_crtc_handle_vblank_completes_cursor_only(struct kunit *test)
 	KUNIT_ASSERT_EQ(test, drm_vblank_init(&adev->ddev, 1), 0);
 
 	acrtc = kunit_kzalloc(test, sizeof(*acrtc), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, acrtc);
+	KUNIT_ASSERT_NOT_NULL(test, acrtc);
 
 	/* drm_crtc_send_vblank_event() consumes (kfree()s) the event. */
 	event = kzalloc_obj(*event, GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, event);
+	KUNIT_ASSERT_NOT_NULL(test, event);
 
 	acrtc->base.dev = &adev->ddev;
 	acrtc->base.funcs = &dm_test_crtc_funcs;
@@ -1906,7 +1906,7 @@ dm_test_vblank_control_worker_setup(struct kunit *test, bool enable,
 	adev->dm.active_vblank_irq_count = count;
 
 	acrtc = kunit_kzalloc(test, sizeof(*acrtc), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, acrtc);
+	KUNIT_ASSERT_NOT_NULL(test, acrtc);
 	acrtc->base.dev = &adev->ddev;
 	acrtc->base.state = NULL;
 
@@ -1917,7 +1917,7 @@ dm_test_vblank_control_worker_setup(struct kunit *test, bool enable,
 
 	/* Worker kfree()s the work item, so it must be a plain allocation. */
 	work = kzalloc_obj(*work, GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, work);
+	KUNIT_ASSERT_NOT_NULL(test, work);
 	work->dm = &adev->dm;
 	work->acrtc = acrtc;
 	work->stream = stream;
@@ -2011,7 +2011,7 @@ static void dm_test_crtc_disable_vblank_no_irq_installed(struct kunit *test)
 	adev->irq.installed = false;
 
 	acrtc = kunit_kzalloc(test, sizeof(*acrtc), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, acrtc);
+	KUNIT_ASSERT_NOT_NULL(test, acrtc);
 	acrtc->base.dev = &adev->ddev;
 	acrtc->crtc_id = 0;
 
@@ -2046,7 +2046,7 @@ static void dm_test_crtc_disable_vblank_vrr(struct kunit *test)
 	adev->irq.installed = true;
 
 	reset_domain = kunit_kzalloc(test, sizeof(*reset_domain), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, reset_domain);
+	KUNIT_ASSERT_NOT_NULL(test, reset_domain);
 	adev->reset_domain = reset_domain;
 
 	/* Seed with 2 so amdgpu_irq_put() drops to a non-zero refcount. */
@@ -2054,7 +2054,7 @@ static void dm_test_crtc_disable_vblank_vrr(struct kunit *test)
 	dm_test_crtc_arm_irq_src(test, &adev->pageflip_irq, 2);
 
 	acrtc = kunit_kzalloc(test, sizeof(*acrtc), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, acrtc);
+	KUNIT_ASSERT_NOT_NULL(test, acrtc);
 	acrtc->base.dev = &adev->ddev;
 	acrtc->crtc_id = 0;
 	/* OTG unassigned -> amdgpu_dm_crtc_set_vupdate_irq() returns 0 early. */
@@ -2097,7 +2097,7 @@ static void dm_test_crtc_disable_vblank_queues_work(struct kunit *test)
 	adev->irq.installed = true;
 
 	reset_domain = kunit_kzalloc(test, sizeof(*reset_domain), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, reset_domain);
+	KUNIT_ASSERT_NOT_NULL(test, reset_domain);
 	adev->reset_domain = reset_domain;
 
 	/* Seed with 2 so amdgpu_irq_put() drops to a non-zero refcount. */
@@ -2105,7 +2105,7 @@ static void dm_test_crtc_disable_vblank_queues_work(struct kunit *test)
 	dm_test_crtc_arm_irq_src(test, &adev->pageflip_irq, 2);
 
 	acrtc = kunit_kzalloc(test, sizeof(*acrtc), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, acrtc);
+	KUNIT_ASSERT_NOT_NULL(test, acrtc);
 	acrtc->base.dev = &adev->ddev;
 	acrtc->crtc_id = 0;
 	acrtc->otg_inst = -1;
@@ -2117,7 +2117,7 @@ static void dm_test_crtc_disable_vblank_queues_work(struct kunit *test)
 
 	/* CRTC state with no stream -> the stream-retain branch is skipped. */
 	dm_state = kunit_kzalloc(test, sizeof(*dm_state), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dm_state);
+	KUNIT_ASSERT_NOT_NULL(test, dm_state);
 	acrtc->base.state = &dm_state->base;
 
 	/* Real workqueue so the queue_work() branch runs the control worker. */
@@ -2151,7 +2151,7 @@ static void dm_test_crtc_late_register_inits_debugfs(struct kunit *test)
 	int ret;
 
 	crtc = kunit_kzalloc(test, sizeof(*crtc), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, crtc);
+	KUNIT_ASSERT_NOT_NULL(test, crtc);
 
 	crtc->debugfs_entry = debugfs_create_dir("dm_test_crtc", NULL);
 
@@ -2303,18 +2303,18 @@ static void dm_test_crtc_atomic_check_no_stream_passes(struct kunit *test)
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev);
 
 	crtc = kunit_kzalloc(test, sizeof(*crtc), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, crtc);
+	KUNIT_ASSERT_NOT_NULL(test, crtc);
 	crtc->dev = &adev->ddev;
 
 	dm_crtc_state = kunit_kzalloc(test, sizeof(*dm_crtc_state), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dm_crtc_state);
+	KUNIT_ASSERT_NOT_NULL(test, dm_crtc_state);
 	dm_crtc_state->base.crtc = crtc;
 
 	state = kunit_kzalloc(test, sizeof(*state), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, state);
+	KUNIT_ASSERT_NOT_NULL(test, state);
 	state->dev = &adev->ddev;
 	state->crtcs = kunit_kzalloc(test, sizeof(*state->crtcs), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, state->crtcs);
+	KUNIT_ASSERT_NOT_NULL(test, state->crtcs);
 	state->crtcs[0].new_state = &dm_crtc_state->base;
 	dm_crtc_state->base.state = state;
 
@@ -2363,24 +2363,24 @@ static void dm_test_crtc_atomic_check_enable_without_primary_fails(struct kunit
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev);
 
 	primary = kunit_kzalloc(test, sizeof(*primary), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, primary);
+	KUNIT_ASSERT_NOT_NULL(test, primary);
 
 	crtc = kunit_kzalloc(test, sizeof(*crtc), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, crtc);
+	KUNIT_ASSERT_NOT_NULL(test, crtc);
 	crtc->dev = &adev->ddev;
 	crtc->primary = primary;
 
 	dm_crtc_state = kunit_kzalloc(test, sizeof(*dm_crtc_state), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dm_crtc_state);
+	KUNIT_ASSERT_NOT_NULL(test, dm_crtc_state);
 	dm_crtc_state->base.crtc = crtc;
 	dm_crtc_state->base.enable = true;
 	dm_crtc_state->base.plane_mask = 0;
 
 	state = kunit_kzalloc(test, sizeof(*state), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, state);
+	KUNIT_ASSERT_NOT_NULL(test, state);
 	state->dev = &adev->ddev;
 	state->crtcs = kunit_kzalloc(test, sizeof(*state->crtcs), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, state->crtcs);
+	KUNIT_ASSERT_NOT_NULL(test, state->crtcs);
 	state->crtcs[0].new_state = &dm_crtc_state->base;
 	dm_crtc_state->base.state = state;
 
@@ -2408,20 +2408,20 @@ static void dm_test_crtc_atomic_check_async_flip_non_fast_fails(struct kunit *te
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev);
 
 	crtc = kunit_kzalloc(test, sizeof(*crtc), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, crtc);
+	KUNIT_ASSERT_NOT_NULL(test, crtc);
 	crtc->dev = &adev->ddev;
 
 	dm_crtc_state = kunit_kzalloc(test, sizeof(*dm_crtc_state), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dm_crtc_state);
+	KUNIT_ASSERT_NOT_NULL(test, dm_crtc_state);
 	dm_crtc_state->base.crtc = crtc;
 	dm_crtc_state->base.async_flip = true;
 	dm_crtc_state->update_type = UPDATE_TYPE_FULL;
 
 	state = kunit_kzalloc(test, sizeof(*state), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, state);
+	KUNIT_ASSERT_NOT_NULL(test, state);
 	state->dev = &adev->ddev;
 	state->crtcs = kunit_kzalloc(test, sizeof(*state->crtcs), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, state->crtcs);
+	KUNIT_ASSERT_NOT_NULL(test, state->crtcs);
 	state->crtcs[0].new_state = &dm_crtc_state->base;
 	dm_crtc_state->base.state = state;
 
@@ -2452,33 +2452,33 @@ static void dm_test_crtc_atomic_check_vrr_pulls_primary(struct kunit *test)
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev);
 
 	primary = kunit_kzalloc(test, sizeof(*primary), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, primary);
+	KUNIT_ASSERT_NOT_NULL(test, primary);
 
 	crtc = kunit_kzalloc(test, sizeof(*crtc), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, crtc);
+	KUNIT_ASSERT_NOT_NULL(test, crtc);
 	crtc->dev = &adev->ddev;
 	crtc->primary = primary;
 
 	dm_crtc_state = kunit_kzalloc(test, sizeof(*dm_crtc_state), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dm_crtc_state);
+	KUNIT_ASSERT_NOT_NULL(test, dm_crtc_state);
 	dm_crtc_state->base.crtc = crtc;
 	dm_crtc_state->freesync_config.state = VRR_STATE_ACTIVE_VARIABLE;
 
 	state = kunit_kzalloc(test, sizeof(*state), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, state);
+	KUNIT_ASSERT_NOT_NULL(test, state);
 	state->dev = &adev->ddev;
 	state->crtcs = kunit_kzalloc(test, sizeof(*state->crtcs), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, state->crtcs);
+	KUNIT_ASSERT_NOT_NULL(test, state->crtcs);
 	state->crtcs[0].new_state = &dm_crtc_state->base;
 	dm_crtc_state->base.state = state;
 
 	/* acquire ctx must be set; existing plane state avoids taking a lock. */
 	state->acquire_ctx = kunit_kzalloc(test, sizeof(*state->acquire_ctx), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, state->acquire_ctx);
+	KUNIT_ASSERT_NOT_NULL(test, state->acquire_ctx);
 	state->planes = kunit_kzalloc(test, sizeof(*state->planes), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, state->planes);
+	KUNIT_ASSERT_NOT_NULL(test, state->planes);
 	primary_plane_state = kunit_kzalloc(test, sizeof(*primary_plane_state), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, primary_plane_state);
+	KUNIT_ASSERT_NOT_NULL(test, primary_plane_state);
 	state->planes[0].new_state = primary_plane_state;
 
 	ret = amdgpu_dm_crtc_helper_atomic_check(crtc, state);
@@ -2513,18 +2513,18 @@ static void dm_test_crtc_atomic_check_valid_stream_passes(struct kunit *test)
 
 	dc = dm_kunit_alloc_dc_with_ctx(test);
 	res_pool = kunit_kzalloc(test, sizeof(*res_pool), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, res_pool);
+	KUNIT_ASSERT_NOT_NULL(test, res_pool);
 	tg = kunit_kzalloc(test, sizeof(*tg), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, tg);
+	KUNIT_ASSERT_NOT_NULL(test, tg);
 	tg_funcs = kunit_kzalloc(test, sizeof(*tg_funcs), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, tg_funcs);
+	KUNIT_ASSERT_NOT_NULL(test, tg_funcs);
 	tg_funcs->validate_timing = dm_test_atomic_check_validate_timing_ok;
 	tg->funcs = tg_funcs;
 	res_pool->timing_generators[0] = tg;
 	dc->res_pool = res_pool;
 
 	link_srv = kunit_kzalloc(test, sizeof(*link_srv), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, link_srv);
+	KUNIT_ASSERT_NOT_NULL(test, link_srv);
 	link_srv->validate_mode_timing = dm_test_atomic_check_validate_mode_timing_ok;
 	dc->link_srv = link_srv;
 	adev->dm.dc = dc;
@@ -2534,19 +2534,19 @@ static void dm_test_crtc_atomic_check_valid_stream_passes(struct kunit *test)
 	stream = dm_kunit_alloc_stream(test, link);
 
 	crtc = kunit_kzalloc(test, sizeof(*crtc), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, crtc);
+	KUNIT_ASSERT_NOT_NULL(test, crtc);
 	crtc->dev = &adev->ddev;
 
 	dm_crtc_state = kunit_kzalloc(test, sizeof(*dm_crtc_state), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dm_crtc_state);
+	KUNIT_ASSERT_NOT_NULL(test, dm_crtc_state);
 	dm_crtc_state->base.crtc = crtc;
 	dm_crtc_state->stream = stream;
 
 	state = kunit_kzalloc(test, sizeof(*state), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, state);
+	KUNIT_ASSERT_NOT_NULL(test, state);
 	state->dev = &adev->ddev;
 	state->crtcs = kunit_kzalloc(test, sizeof(*state->crtcs), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, state->crtcs);
+	KUNIT_ASSERT_NOT_NULL(test, state->crtcs);
 	state->crtcs[0].new_state = &dm_crtc_state->base;
 	dm_crtc_state->base.state = state;
 
@@ -2581,11 +2581,11 @@ static void dm_test_crtc_atomic_check_invalid_stream_fails(struct kunit *test)
 
 	dc = dm_kunit_alloc_dc_with_ctx(test);
 	res_pool = kunit_kzalloc(test, sizeof(*res_pool), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, res_pool);
+	KUNIT_ASSERT_NOT_NULL(test, res_pool);
 	tg = kunit_kzalloc(test, sizeof(*tg), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, tg);
+	KUNIT_ASSERT_NOT_NULL(test, tg);
 	tg_funcs = kunit_kzalloc(test, sizeof(*tg_funcs), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, tg_funcs);
+	KUNIT_ASSERT_NOT_NULL(test, tg_funcs);
 	tg_funcs->validate_timing = dm_test_atomic_check_validate_timing_fail;
 	tg->funcs = tg_funcs;
 	res_pool->timing_generators[0] = tg;
@@ -2596,19 +2596,19 @@ static void dm_test_crtc_atomic_check_invalid_stream_fails(struct kunit *test)
 	stream = dm_kunit_alloc_stream(test, link);
 
 	crtc = kunit_kzalloc(test, sizeof(*crtc), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, crtc);
+	KUNIT_ASSERT_NOT_NULL(test, crtc);
 	crtc->dev = &adev->ddev;
 
 	dm_crtc_state = kunit_kzalloc(test, sizeof(*dm_crtc_state), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dm_crtc_state);
+	KUNIT_ASSERT_NOT_NULL(test, dm_crtc_state);
 	dm_crtc_state->base.crtc = crtc;
 	dm_crtc_state->stream = stream;
 
 	state = kunit_kzalloc(test, sizeof(*state), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, state);
+	KUNIT_ASSERT_NOT_NULL(test, state);
 	state->dev = &adev->ddev;
 	state->crtcs = kunit_kzalloc(test, sizeof(*state->crtcs), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, state->crtcs);
+	KUNIT_ASSERT_NOT_NULL(test, state->crtcs);
 	state->crtcs[0].new_state = &dm_crtc_state->base;
 	dm_crtc_state->base.state = state;
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_dmub_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_dmub_test.c
index 1e499acbcb90..2e273dea17ef 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_dmub_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_dmub_test.c
@@ -90,7 +90,7 @@ static struct dmub_srv *dm_test_alloc_dmub_srv(struct kunit *test)
 	struct dmub_srv *dmub_srv;
 
 	dmub_srv = kunit_kzalloc(test, sizeof(*dmub_srv), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dmub_srv);
+	KUNIT_ASSERT_NOT_NULL(test, dmub_srv);
 
 	dmub_srv->sw_init = true;
 	dmub_srv->hw_init = true;
@@ -110,10 +110,10 @@ static const struct firmware *dm_test_alloc_dmub_fw(struct kunit *test)
 	u8 *data;
 
 	fw = kunit_kzalloc(test, sizeof(*fw), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, fw);
+	KUNIT_ASSERT_NOT_NULL(test, fw);
 
 	data = kunit_kzalloc(test, DM_TEST_FW_SIZE, GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, data);
+	KUNIT_ASSERT_NOT_NULL(test, data);
 
 	hdr = (struct dmcub_firmware_header_v1_0 *)data;
 	hdr->header.ucode_array_offset_bytes = cpu_to_le32(0);
@@ -136,7 +136,7 @@ static void dm_test_register_dmub_notify_callback_null_callback(struct kunit *te
 	struct amdgpu_device *adev;
 
 	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev);
+	KUNIT_ASSERT_NOT_NULL(test, adev);
 
 	KUNIT_EXPECT_FALSE(test, dm_register_dmub_notify_callback(adev,
 		DMUB_NOTIFICATION_AUX_REPLY, NULL, false));
@@ -151,7 +151,7 @@ static void dm_test_register_dmub_notify_callback_type_out_of_range(struct kunit
 	struct amdgpu_device *adev;
 
 	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev);
+	KUNIT_ASSERT_NOT_NULL(test, adev);
 
 	KUNIT_EXPECT_FALSE(test, dm_register_dmub_notify_callback(adev,
 		AMDGPU_DMUB_NOTIFICATION_MAX, dummy_callback, false));
@@ -166,7 +166,7 @@ static void dm_test_register_dmub_notify_callback_valid(struct kunit *test)
 	struct amdgpu_device *adev;
 
 	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev);
+	KUNIT_ASSERT_NOT_NULL(test, adev);
 
 	KUNIT_EXPECT_TRUE(test, dm_register_dmub_notify_callback(adev,
 		DMUB_NOTIFICATION_AUX_REPLY, dummy_callback, true));
@@ -186,7 +186,7 @@ static void dm_test_register_dmub_notify_callback_offload_false(struct kunit *te
 	struct amdgpu_device *adev;
 
 	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev);
+	KUNIT_ASSERT_NOT_NULL(test, adev);
 
 	KUNIT_EXPECT_TRUE(test, dm_register_dmub_notify_callback(adev,
 		DMUB_NOTIFICATION_HPD, dummy_callback, false));
@@ -210,10 +210,10 @@ static void dm_test_dmub_aux_setconfig_callback_copies_and_completes(struct kuni
 	struct dmub_notification notify = {};
 
 	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev);
+	KUNIT_ASSERT_NOT_NULL(test, adev);
 
 	dm_notify = kunit_kzalloc(test, sizeof(*dm_notify), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dm_notify);
+	KUNIT_ASSERT_NOT_NULL(test, dm_notify);
 
 	init_completion(&adev->dm.dmub_aux_transfer_done);
 	adev->dm.dmub_notify = dm_notify;
@@ -249,10 +249,10 @@ static void dm_test_dmub_aux_setconfig_callback_non_aux_no_complete(struct kunit
 	struct dmub_notification notify = {};
 
 	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev);
+	KUNIT_ASSERT_NOT_NULL(test, adev);
 
 	dm_notify = kunit_kzalloc(test, sizeof(*dm_notify), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dm_notify);
+	KUNIT_ASSERT_NOT_NULL(test, dm_notify);
 
 	init_completion(&adev->dm.dmub_aux_transfer_done);
 	adev->dm.dmub_notify = dm_notify;
@@ -276,7 +276,7 @@ static void dm_test_dmub_aux_setconfig_callback_aux_with_null_dm_notify(struct k
 	struct dmub_notification notify = {};
 
 	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev);
+	KUNIT_ASSERT_NOT_NULL(test, adev);
 
 	init_completion(&adev->dm.dmub_aux_transfer_done);
 	adev->dm.dmub_notify = NULL;
@@ -299,10 +299,10 @@ static void dm_test_dmub_aux_setconfig_callback_set_config_reply(struct kunit *t
 	struct dmub_notification notify = {};
 
 	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev);
+	KUNIT_ASSERT_NOT_NULL(test, adev);
 
 	dm_notify = kunit_kzalloc(test, sizeof(*dm_notify), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dm_notify);
+	KUNIT_ASSERT_NOT_NULL(test, dm_notify);
 
 	init_completion(&adev->dm.dmub_aux_transfer_done);
 	adev->dm.dmub_notify = dm_notify;
@@ -337,7 +337,7 @@ static void dm_test_dmub_aux_fused_io_callback_copies_reply_and_completes(struct
 	uint8_t ddc_line = 2;
 
 	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev);
+	KUNIT_ASSERT_NOT_NULL(test, adev);
 
 	init_completion(&adev->dm.fused_io[ddc_line].replied);
 
@@ -380,7 +380,7 @@ static void dm_test_dmub_aux_fused_io_callback_max_ddc_line(struct kunit *test)
 	uint8_t ddc_line;
 
 	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev);
+	KUNIT_ASSERT_NOT_NULL(test, adev);
 
 	ddc_line = ARRAY_SIZE(adev->dm.fused_io) - 1;
 	init_completion(&adev->dm.fused_io[ddc_line].replied);
@@ -430,7 +430,7 @@ static void dm_test_get_default_ips_mode_dcn35(struct kunit *test)
 	struct amdgpu_device *adev;
 
 	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev);
+	KUNIT_ASSERT_NOT_NULL(test, adev);
 
 	adev->ip_versions[DCE_HWIP][0] = IP_VERSION(3, 5, 0);
 
@@ -447,7 +447,7 @@ static void dm_test_get_default_ips_mode_dcn351(struct kunit *test)
 	struct amdgpu_device *adev;
 
 	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev);
+	KUNIT_ASSERT_NOT_NULL(test, adev);
 
 	adev->ip_versions[DCE_HWIP][0] = IP_VERSION(3, 5, 1);
 
@@ -464,7 +464,7 @@ static void dm_test_get_default_ips_mode_dcn36(struct kunit *test)
 	struct amdgpu_device *adev;
 
 	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev);
+	KUNIT_ASSERT_NOT_NULL(test, adev);
 
 	adev->ip_versions[DCE_HWIP][0] = IP_VERSION(3, 6, 0);
 
@@ -481,7 +481,7 @@ static void dm_test_get_default_ips_mode_older_than_dcn35(struct kunit *test)
 	struct amdgpu_device *adev;
 
 	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev);
+	KUNIT_ASSERT_NOT_NULL(test, adev);
 
 	adev->ip_versions[DCE_HWIP][0] = IP_VERSION(3, 2, 0);
 
@@ -498,7 +498,7 @@ static void dm_test_get_default_ips_mode_newer_default(struct kunit *test)
 	struct amdgpu_device *adev;
 
 	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev);
+	KUNIT_ASSERT_NOT_NULL(test, adev);
 
 	/* DCN 4.0.1 is >= 3.5 but has no explicit case, returns ENABLE */
 	adev->ip_versions[DCE_HWIP][0] = IP_VERSION(4, 0, 1);
@@ -522,16 +522,16 @@ static struct amdgpu_device *dm_test_alloc_adev_with_dc(struct kunit *test)
 	struct resource_pool *res_pool;
 
 	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev);
+	KUNIT_ASSERT_NOT_NULL(test, adev);
 
 	dc = kunit_kzalloc(test, sizeof(*dc), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dc);
+	KUNIT_ASSERT_NOT_NULL(test, dc);
 
 	res_pool = kunit_kzalloc(test, sizeof(*res_pool), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, res_pool);
+	KUNIT_ASSERT_NOT_NULL(test, res_pool);
 
 	ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
+	KUNIT_ASSERT_NOT_NULL(test, ctx);
 
 	dc->res_pool = res_pool;
 	dc->ctx = ctx;
@@ -551,20 +551,20 @@ static struct amdgpu_device *dm_test_alloc_adev_with_dmub(struct kunit *test)
 	adev = dm_test_alloc_adev_with_dc(test);
 
 	fb_info = kunit_kzalloc(test, sizeof(*fb_info), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, fb_info);
+	KUNIT_ASSERT_NOT_NULL(test, fb_info);
 
 	fb_info->num_fb = DMUB_WINDOW_TOTAL;
 	for (i = 0; i < DMUB_WINDOW_TOTAL; i++) {
 		fb_info->fb[i].size = PAGE_SIZE;
 		fb_info->fb[i].cpu_addr = kunit_kzalloc(test, PAGE_SIZE, GFP_KERNEL);
-		KUNIT_ASSERT_NOT_ERR_OR_NULL(test, fb_info->fb[i].cpu_addr);
+		KUNIT_ASSERT_NOT_NULL(test, fb_info->fb[i].cpu_addr);
 	}
 
 	adev->dm.dmub_srv = dm_test_alloc_dmub_srv(test);
 	adev->dm.dmub_fb_info = fb_info;
 	adev->dm.dmub_fw = dm_test_alloc_dmub_fw(test);
 	adev->bios = kunit_kzalloc(test, 4, GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev->bios);
+	KUNIT_ASSERT_NOT_NULL(test, adev->bios);
 	adev->bios_size = 4;
 	adev->dm.fw_inst_size = 0;
 
@@ -600,7 +600,7 @@ static void dm_test_dmub_hw_init_no_fb_info(struct kunit *test)
 	struct dmub_srv *dmub_srv;
 
 	dmub_srv = kunit_kzalloc(test, sizeof(*dmub_srv), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dmub_srv);
+	KUNIT_ASSERT_NOT_NULL(test, dmub_srv);
 
 	adev->dm.dmub_srv = dmub_srv;
 	adev->dm.dmub_fb_info = NULL;
@@ -622,10 +622,10 @@ static void dm_test_dmub_hw_init_no_firmware(struct kunit *test)
 	struct dmub_srv_fb_info *fb_info;
 
 	dmub_srv = kunit_kzalloc(test, sizeof(*dmub_srv), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dmub_srv);
+	KUNIT_ASSERT_NOT_NULL(test, dmub_srv);
 
 	fb_info = kunit_kzalloc(test, sizeof(*fb_info), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, fb_info);
+	KUNIT_ASSERT_NOT_NULL(test, fb_info);
 
 	adev->dm.dmub_srv = dmub_srv;
 	adev->dm.dmub_fb_info = fb_info;
@@ -791,10 +791,10 @@ static void dm_test_dmub_hw_init_dmcu_abm(struct kunit *test)
 	struct abm *abm;
 
 	dmcu = kunit_kzalloc(test, sizeof(*dmcu), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dmcu);
+	KUNIT_ASSERT_NOT_NULL(test, dmcu);
 
 	abm = kunit_kzalloc(test, sizeof(*abm), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, abm);
+	KUNIT_ASSERT_NOT_NULL(test, abm);
 
 	dmcu->funcs = &dm_test_dmcu_funcs;
 	dmcu->psp_version = 0x12345678;
@@ -911,7 +911,7 @@ static void dm_test_dmub_sw_init_unsupported_asic(struct kunit *test)
 	struct amdgpu_device *adev;
 
 	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev);
+	KUNIT_ASSERT_NOT_NULL(test, adev);
 
 	adev->ip_versions[DCE_HWIP][0] = IP_VERSION(1, 0, 0);
 
@@ -932,7 +932,7 @@ static void dm_test_init_microcode_unsupported_asic(struct kunit *test)
 	struct amdgpu_device *adev;
 
 	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev);
+	KUNIT_ASSERT_NOT_NULL(test, adev);
 
 	adev->ip_versions[DCE_HWIP][0] = IP_VERSION(1, 0, 0);
 
@@ -954,7 +954,7 @@ static void dm_test_dmub_get_vbios_bounding_box_default_null(struct kunit *test)
 	struct amdgpu_device *adev;
 
 	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev);
+	KUNIT_ASSERT_NOT_NULL(test, adev);
 
 	adev->ip_versions[DCE_HWIP][0] = IP_VERSION(3, 5, 0);
 
@@ -977,13 +977,13 @@ static void dm_test_execute_dmub_cmd_null_dmub_srv(struct kunit *test)
 	union dmub_rb_cmd *cmd;
 
 	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev);
+	KUNIT_ASSERT_NOT_NULL(test, adev);
 
 	ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
+	KUNIT_ASSERT_NOT_NULL(test, ctx);
 
 	cmd = kunit_kzalloc(test, sizeof(*cmd), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, cmd);
+	KUNIT_ASSERT_NOT_NULL(test, cmd);
 
 	spin_lock_init(&adev->dm.dmub_lock);
 	ctx->driver_context = adev;
@@ -1014,19 +1014,19 @@ static void dm_test_process_dmub_aux_transfer_sync_engine_acquire(struct kunit *
 	int ret;
 
 	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev);
+	KUNIT_ASSERT_NOT_NULL(test, adev);
 
 	ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
+	KUNIT_ASSERT_NOT_NULL(test, ctx);
 
 	dc = kunit_kzalloc(test, sizeof(*dc), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dc);
+	KUNIT_ASSERT_NOT_NULL(test, dc);
 
 	payload = kunit_kzalloc(test, sizeof(*payload), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, payload);
+	KUNIT_ASSERT_NOT_NULL(test, payload);
 
 	notify = kunit_kzalloc(test, sizeof(*notify), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, notify);
+	KUNIT_ASSERT_NOT_NULL(test, notify);
 
 	dc->link_count = 0;
 	ctx->dc = dc;
@@ -1063,28 +1063,28 @@ static void dm_test_process_dmub_aux_transfer_sync_protocol_error(struct kunit *
 	int ret;
 
 	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev);
+	KUNIT_ASSERT_NOT_NULL(test, adev);
 
 	ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
+	KUNIT_ASSERT_NOT_NULL(test, ctx);
 
 	dc_ctx = kunit_kzalloc(test, sizeof(*dc_ctx), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dc_ctx);
+	KUNIT_ASSERT_NOT_NULL(test, dc_ctx);
 
 	dc = kunit_kzalloc(test, sizeof(*dc), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dc);
+	KUNIT_ASSERT_NOT_NULL(test, dc);
 
 	link = kunit_kzalloc(test, sizeof(*link), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, link);
+	KUNIT_ASSERT_NOT_NULL(test, link);
 
 	ddc = kunit_kzalloc(test, sizeof(*ddc), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ddc);
+	KUNIT_ASSERT_NOT_NULL(test, ddc);
 
 	payload = kunit_kzalloc(test, sizeof(*payload), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, payload);
+	KUNIT_ASSERT_NOT_NULL(test, payload);
 
 	notify = kunit_kzalloc(test, sizeof(*notify), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, notify);
+	KUNIT_ASSERT_NOT_NULL(test, notify);
 
 	link->ddc = ddc;
 	dc->ctx = dc_ctx;
@@ -1131,28 +1131,28 @@ static void dm_test_process_dmub_aux_transfer_sync_copies_data(struct kunit *tes
 	int ret;
 
 	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev);
+	KUNIT_ASSERT_NOT_NULL(test, adev);
 
 	ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
+	KUNIT_ASSERT_NOT_NULL(test, ctx);
 
 	dc_ctx = kunit_kzalloc(test, sizeof(*dc_ctx), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dc_ctx);
+	KUNIT_ASSERT_NOT_NULL(test, dc_ctx);
 
 	dc = kunit_kzalloc(test, sizeof(*dc), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dc);
+	KUNIT_ASSERT_NOT_NULL(test, dc);
 
 	link = kunit_kzalloc(test, sizeof(*link), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, link);
+	KUNIT_ASSERT_NOT_NULL(test, link);
 
 	ddc = kunit_kzalloc(test, sizeof(*ddc), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ddc);
+	KUNIT_ASSERT_NOT_NULL(test, ddc);
 
 	payload = kunit_kzalloc(test, sizeof(*payload), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, payload);
+	KUNIT_ASSERT_NOT_NULL(test, payload);
 
 	notify = kunit_kzalloc(test, sizeof(*notify), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, notify);
+	KUNIT_ASSERT_NOT_NULL(test, notify);
 
 	link->ddc = ddc;
 	dc->ctx = dc_ctx;
@@ -1212,28 +1212,28 @@ static void dm_test_process_dmub_aux_transfer_sync_zero_length(struct kunit *tes
 	int ret;
 
 	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev);
+	KUNIT_ASSERT_NOT_NULL(test, adev);
 
 	ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
+	KUNIT_ASSERT_NOT_NULL(test, ctx);
 
 	dc_ctx = kunit_kzalloc(test, sizeof(*dc_ctx), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dc_ctx);
+	KUNIT_ASSERT_NOT_NULL(test, dc_ctx);
 
 	dc = kunit_kzalloc(test, sizeof(*dc), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dc);
+	KUNIT_ASSERT_NOT_NULL(test, dc);
 
 	link = kunit_kzalloc(test, sizeof(*link), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, link);
+	KUNIT_ASSERT_NOT_NULL(test, link);
 
 	ddc = kunit_kzalloc(test, sizeof(*ddc), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ddc);
+	KUNIT_ASSERT_NOT_NULL(test, ddc);
 
 	payload = kunit_kzalloc(test, sizeof(*payload), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, payload);
+	KUNIT_ASSERT_NOT_NULL(test, payload);
 
 	notify = kunit_kzalloc(test, sizeof(*notify), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, notify);
+	KUNIT_ASSERT_NOT_NULL(test, notify);
 
 	link->ddc = ddc;
 	dc->ctx = dc_ctx;
@@ -1286,25 +1286,25 @@ static void dm_test_process_dmub_set_config_sync_unknown_error(struct kunit *tes
 	int ret;
 
 	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev);
+	KUNIT_ASSERT_NOT_NULL(test, adev);
 
 	ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
+	KUNIT_ASSERT_NOT_NULL(test, ctx);
 
 	dc_ctx = kunit_kzalloc(test, sizeof(*dc_ctx), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dc_ctx);
+	KUNIT_ASSERT_NOT_NULL(test, dc_ctx);
 
 	dc = kunit_kzalloc(test, sizeof(*dc), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dc);
+	KUNIT_ASSERT_NOT_NULL(test, dc);
 
 	link = kunit_kzalloc(test, sizeof(*link), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, link);
+	KUNIT_ASSERT_NOT_NULL(test, link);
 
 	payload = kunit_kzalloc(test, sizeof(*payload), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, payload);
+	KUNIT_ASSERT_NOT_NULL(test, payload);
 
 	notify = kunit_kzalloc(test, sizeof(*notify), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, notify);
+	KUNIT_ASSERT_NOT_NULL(test, notify);
 
 	dc->ctx = dc_ctx;
 	dc_ctx->dmub_srv = NULL;
@@ -1338,13 +1338,13 @@ static void dm_test_abort_fused_io_no_dmub_srv(struct kunit *test)
 	struct dmub_cmd_fused_request *req;
 
 	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev);
+	KUNIT_ASSERT_NOT_NULL(test, adev);
 
 	ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
+	KUNIT_ASSERT_NOT_NULL(test, ctx);
 
 	req = kunit_kzalloc(test, sizeof(*req), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, req);
+	KUNIT_ASSERT_NOT_NULL(test, req);
 
 	spin_lock_init(&adev->dm.dmub_lock);
 	ctx->driver_context = adev;
@@ -1484,7 +1484,7 @@ static int dm_test_dmub_hw_access_init(struct kunit *test)
 	void *cpu_ptr;
 
 	cpu_ptr = kunit_kzalloc(test, PAGE_SIZE, GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, cpu_ptr);
+	KUNIT_ASSERT_NOT_NULL(test, cpu_ptr);
 
 	dm_test_bo = (struct dm_test_bo_ctx) { .cpu_ptr = cpu_ptr };
 	dm_test_cgs = (struct dm_test_cgs_ctx) { .dev.ops = &dm_test_cgs_ops };
@@ -1509,7 +1509,7 @@ static struct amdgpu_device *dm_test_alloc_adev_with_cgs(struct kunit *test)
 	struct amdgpu_device *adev;
 
 	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev);
+	KUNIT_ASSERT_NOT_NULL(test, adev);
 
 	adev->dm.cgs_device = &dm_test_cgs.dev;
 	INIT_LIST_HEAD(&adev->dm.da_list);
@@ -1532,7 +1532,7 @@ static void dm_test_dmub_reg_write_then_read(struct kunit *test)
 	struct dc_perf_trace *perf_trace;
 
 	perf_trace = kunit_kzalloc(test, sizeof(*perf_trace), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, perf_trace);
+	KUNIT_ASSERT_NOT_NULL(test, perf_trace);
 
 	adev->dm.dc->ctx->cgs_device = &dm_test_cgs.dev;
 	adev->dm.dc->ctx->perf_trace = perf_trace;
@@ -1690,7 +1690,7 @@ static void dm_test_init_microcode_fw_names(struct kunit *test)
 	unsigned int i;
 
 	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev);
+	KUNIT_ASSERT_NOT_NULL(test, adev);
 
 	for (i = 0; i < ARRAY_SIZE(dm_test_ucode_cases); i++) {
 		const struct dm_test_ucode_case *c = &dm_test_ucode_cases[i];
@@ -1719,7 +1719,7 @@ static void dm_test_init_microcode_request_fails(struct kunit *test)
 	struct amdgpu_device *adev;
 
 	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev);
+	KUNIT_ASSERT_NOT_NULL(test, adev);
 
 	adev->ip_versions[DCE_HWIP][0] = IP_VERSION(3, 5, 0);
 	dm_test_ucode_ret = -ENOENT;
@@ -1735,7 +1735,7 @@ static struct amdgpu_device *dm_test_alloc_adev_for_sw_init(struct kunit *test)
 
 	adev->dm.dmub_fw = dm_test_alloc_dmub_fw(test);
 	adev->bios = kunit_kzalloc(test, 4, GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev->bios);
+	KUNIT_ASSERT_NOT_NULL(test, adev->bios);
 	adev->bios_size = 4;
 
 	return adev;
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_freesync_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_freesync_test.c
index 616a2b385140..710cdc7f40bf 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_freesync_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_freesync_test.c
@@ -166,11 +166,11 @@ static void dm_test_dc_timing_adjust_pending(struct kunit *test)
 	struct dc_stream_state *stream;
 
 	old_state = kunit_kzalloc(test, sizeof(*old_state), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, old_state);
+	KUNIT_ASSERT_NOT_NULL(test, old_state);
 	new_state = kunit_kzalloc(test, sizeof(*new_state), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, new_state);
+	KUNIT_ASSERT_NOT_NULL(test, new_state);
 	stream = kunit_kzalloc(test, sizeof(*stream), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, stream);
+	KUNIT_ASSERT_NOT_NULL(test, stream);
 
 	new_state->stream = stream;
 	stream->timing_adjust_pending = 1;
@@ -188,11 +188,11 @@ static void dm_test_dc_timing_adjust_active_fixed(struct kunit *test)
 	struct dc_stream_state *stream;
 
 	old_state = kunit_kzalloc(test, sizeof(*old_state), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, old_state);
+	KUNIT_ASSERT_NOT_NULL(test, old_state);
 	new_state = kunit_kzalloc(test, sizeof(*new_state), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, new_state);
+	KUNIT_ASSERT_NOT_NULL(test, new_state);
 	stream = kunit_kzalloc(test, sizeof(*stream), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, stream);
+	KUNIT_ASSERT_NOT_NULL(test, stream);
 
 	new_state->stream = stream;
 	new_state->freesync_config.state = VRR_STATE_ACTIVE_FIXED;
@@ -210,11 +210,11 @@ static void dm_test_dc_timing_adjust_vrr_toggle(struct kunit *test)
 	struct dc_stream_state *stream;
 
 	old_state = kunit_kzalloc(test, sizeof(*old_state), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, old_state);
+	KUNIT_ASSERT_NOT_NULL(test, old_state);
 	new_state = kunit_kzalloc(test, sizeof(*new_state), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, new_state);
+	KUNIT_ASSERT_NOT_NULL(test, new_state);
 	stream = kunit_kzalloc(test, sizeof(*stream), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, stream);
+	KUNIT_ASSERT_NOT_NULL(test, stream);
 
 	new_state->stream = stream;
 	old_state->freesync_config.state = VRR_STATE_ACTIVE_VARIABLE;
@@ -233,11 +233,11 @@ static void dm_test_dc_timing_adjust_not_needed(struct kunit *test)
 	struct dc_stream_state *stream;
 
 	old_state = kunit_kzalloc(test, sizeof(*old_state), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, old_state);
+	KUNIT_ASSERT_NOT_NULL(test, old_state);
 	new_state = kunit_kzalloc(test, sizeof(*new_state), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, new_state);
+	KUNIT_ASSERT_NOT_NULL(test, new_state);
 	stream = kunit_kzalloc(test, sizeof(*stream), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, stream);
+	KUNIT_ASSERT_NOT_NULL(test, stream);
 
 	new_state->stream = stream;
 	old_state->freesync_config.state = VRR_STATE_INACTIVE;
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_irq_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_irq_test.c
index b29aef2ae16c..f89812b5344c 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_irq_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_irq_test.c
@@ -428,16 +428,16 @@ static struct dc *dm_test_alloc_dc_with_irq_service(struct kunit *test,
 
 	dc = dm_kunit_alloc_dc_with_ctx(test);
 	res_pool = kunit_kzalloc(test, sizeof(*res_pool), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, res_pool);
+	KUNIT_ASSERT_NOT_NULL(test, res_pool);
 	irqs = kunit_kzalloc(test, sizeof(*irqs), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, irqs);
+	KUNIT_ASSERT_NOT_NULL(test, irqs);
 
 	/*
 	 * Populate the per-source info table so amdgpu_dm_irq_set()/_ack()
 	 * succeed without touching hardware registers.
 	 */
 	info = kunit_kcalloc(test, DAL_IRQ_SOURCES_NUMBER, sizeof(*info), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, info);
+	KUNIT_ASSERT_NOT_NULL(test, info);
 	for (i = 0; i < DAL_IRQ_SOURCES_NUMBER; i++)
 		info[i].funcs = &dm_test_irq_src_funcs;
 
@@ -503,7 +503,7 @@ static struct amdgpu_crtc *dm_test_add_crtc(struct kunit *test,
 	struct amdgpu_crtc *acrtc;
 
 	acrtc = kunit_kzalloc(test, sizeof(*acrtc), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, acrtc);
+	KUNIT_ASSERT_NOT_NULL(test, acrtc);
 
 	INIT_LIST_HEAD(&acrtc->base.head);
 	acrtc->base.dev = &adev->ddev;
@@ -576,7 +576,7 @@ static struct hdcp_workqueue *dm_test_alloc_hdcp_workqueue(struct kunit *test)
 	struct hdcp_workqueue *hdcp_work;
 
 	hdcp_work = kunit_kzalloc(test, sizeof(*hdcp_work), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, hdcp_work);
+	KUNIT_ASSERT_NOT_NULL(test, hdcp_work);
 
 	mutex_init(&hdcp_work->mutex);
 	INIT_WORK(&hdcp_work->cpirq_work, dm_test_hdcp_dummy_work);
@@ -678,7 +678,7 @@ static void dm_test_are_sinks_equal_first_null(struct kunit *test)
 	struct dc_sink *sink2;
 
 	sink2 = kunit_kzalloc(test, sizeof(*sink2), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, sink2);
+	KUNIT_ASSERT_NOT_NULL(test, sink2);
 
 	KUNIT_EXPECT_FALSE(test, are_sinks_equal(NULL, sink2));
 }
@@ -692,7 +692,7 @@ static void dm_test_are_sinks_equal_second_null(struct kunit *test)
 	struct dc_sink *sink1;
 
 	sink1 = kunit_kzalloc(test, sizeof(*sink1), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, sink1);
+	KUNIT_ASSERT_NOT_NULL(test, sink1);
 
 	KUNIT_EXPECT_FALSE(test, are_sinks_equal(sink1, NULL));
 }
@@ -706,9 +706,9 @@ static void dm_test_are_sinks_equal_different_signal(struct kunit *test)
 	struct dc_sink *sink1, *sink2;
 
 	sink1 = kunit_kzalloc(test, sizeof(*sink1), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, sink1);
+	KUNIT_ASSERT_NOT_NULL(test, sink1);
 	sink2 = kunit_kzalloc(test, sizeof(*sink2), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, sink2);
+	KUNIT_ASSERT_NOT_NULL(test, sink2);
 
 	sink1->sink_signal = SIGNAL_TYPE_HDMI_TYPE_A;
 	sink2->sink_signal = SIGNAL_TYPE_DISPLAY_PORT;
@@ -725,9 +725,9 @@ static void dm_test_are_sinks_equal_different_edid_length(struct kunit *test)
 	struct dc_sink *sink1, *sink2;
 
 	sink1 = kunit_kzalloc(test, sizeof(*sink1), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, sink1);
+	KUNIT_ASSERT_NOT_NULL(test, sink1);
 	sink2 = kunit_kzalloc(test, sizeof(*sink2), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, sink2);
+	KUNIT_ASSERT_NOT_NULL(test, sink2);
 
 	sink1->sink_signal = SIGNAL_TYPE_HDMI_TYPE_A;
 	sink2->sink_signal = SIGNAL_TYPE_HDMI_TYPE_A;
@@ -746,9 +746,9 @@ static void dm_test_are_sinks_equal_different_edid_data(struct kunit *test)
 	struct dc_sink *sink1, *sink2;
 
 	sink1 = kunit_kzalloc(test, sizeof(*sink1), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, sink1);
+	KUNIT_ASSERT_NOT_NULL(test, sink1);
 	sink2 = kunit_kzalloc(test, sizeof(*sink2), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, sink2);
+	KUNIT_ASSERT_NOT_NULL(test, sink2);
 
 	sink1->sink_signal = SIGNAL_TYPE_HDMI_TYPE_A;
 	sink2->sink_signal = SIGNAL_TYPE_HDMI_TYPE_A;
@@ -769,9 +769,9 @@ static void dm_test_are_sinks_equal_zero_length(struct kunit *test)
 	struct dc_sink *sink1, *sink2;
 
 	sink1 = kunit_kzalloc(test, sizeof(*sink1), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, sink1);
+	KUNIT_ASSERT_NOT_NULL(test, sink1);
 	sink2 = kunit_kzalloc(test, sizeof(*sink2), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, sink2);
+	KUNIT_ASSERT_NOT_NULL(test, sink2);
 
 	sink1->sink_signal = SIGNAL_TYPE_DISPLAY_PORT;
 	sink2->sink_signal = SIGNAL_TYPE_DISPLAY_PORT;
@@ -790,9 +790,9 @@ static void dm_test_are_sinks_equal_full_edid_identical(struct kunit *test)
 	struct dc_sink *sink1, *sink2;
 
 	sink1 = kunit_kzalloc(test, sizeof(*sink1), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, sink1);
+	KUNIT_ASSERT_NOT_NULL(test, sink1);
 	sink2 = kunit_kzalloc(test, sizeof(*sink2), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, sink2);
+	KUNIT_ASSERT_NOT_NULL(test, sink2);
 
 	sink1->sink_signal = SIGNAL_TYPE_HDMI_TYPE_A;
 	sink2->sink_signal = SIGNAL_TYPE_HDMI_TYPE_A;
@@ -813,9 +813,9 @@ static void dm_test_are_sinks_equal_full_edid_last_byte_differs(struct kunit *te
 	struct dc_sink *sink1, *sink2;
 
 	sink1 = kunit_kzalloc(test, sizeof(*sink1), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, sink1);
+	KUNIT_ASSERT_NOT_NULL(test, sink1);
 	sink2 = kunit_kzalloc(test, sizeof(*sink2), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, sink2);
+	KUNIT_ASSERT_NOT_NULL(test, sink2);
 
 	sink1->sink_signal = SIGNAL_TYPE_HDMI_TYPE_A;
 	sink2->sink_signal = SIGNAL_TYPE_HDMI_TYPE_A;
@@ -927,7 +927,7 @@ static void dm_test_irq_init_initializes_lists(struct kunit *test)
 	int src;
 
 	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev);
+	KUNIT_ASSERT_NOT_NULL(test, adev);
 
 	KUNIT_EXPECT_EQ(test, amdgpu_dm_irq_init(adev), 0);
 
@@ -951,7 +951,7 @@ static void dm_test_irq_register_rejects_null_params(struct kunit *test)
 	struct dc_interrupt_params int_params = { 0 };
 
 	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev);
+	KUNIT_ASSERT_NOT_NULL(test, adev);
 
 	int_params.int_context = INTERRUPT_LOW_IRQ_CONTEXT;
 	int_params.irq_source = DC_IRQ_SOURCE_HPD1;
@@ -973,7 +973,7 @@ static void dm_test_irq_register_rejects_invalid_context(struct kunit *test)
 	struct dc_interrupt_params int_params = { 0 };
 
 	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev);
+	KUNIT_ASSERT_NOT_NULL(test, adev);
 
 	int_params.int_context = INTERRUPT_CONTEXT_NUMBER;
 	int_params.irq_source = DC_IRQ_SOURCE_HPD1;
@@ -993,7 +993,7 @@ static void dm_test_irq_register_rejects_invalid_source(struct kunit *test)
 	struct dc_interrupt_params int_params = { 0 };
 
 	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev);
+	KUNIT_ASSERT_NOT_NULL(test, adev);
 
 	int_params.int_context = INTERRUPT_LOW_IRQ_CONTEXT;
 	int_params.irq_source = DC_IRQ_SOURCE_INVALID;
@@ -1014,7 +1014,7 @@ static void dm_test_irq_register_separate_contexts(struct kunit *test)
 	void *handler;
 
 	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev);
+	KUNIT_ASSERT_NOT_NULL(test, adev);
 	KUNIT_ASSERT_EQ(test, amdgpu_dm_irq_init(adev), 0);
 
 	int_params.irq_source = DC_IRQ_SOURCE_HPD5;
@@ -1065,7 +1065,7 @@ static void dm_test_irq_unregister_rejects_invalid_source(struct kunit *test)
 	struct amdgpu_device *adev;
 
 	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev);
+	KUNIT_ASSERT_NOT_NULL(test, adev);
 	KUNIT_ASSERT_EQ(test, amdgpu_dm_irq_init(adev), 0);
 
 	amdgpu_dm_irq_unregister_interrupt(adev, DC_IRQ_SOURCE_INVALID,
@@ -1086,7 +1086,7 @@ static void dm_test_irq_unregister_rejects_null_handler(struct kunit *test)
 	struct amdgpu_device *adev;
 
 	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev);
+	KUNIT_ASSERT_NOT_NULL(test, adev);
 	KUNIT_ASSERT_EQ(test, amdgpu_dm_irq_init(adev), 0);
 
 	amdgpu_dm_irq_unregister_interrupt(adev, DC_IRQ_SOURCE_HPD1,
@@ -1109,7 +1109,7 @@ static void dm_test_irq_unregister_handler_not_found(struct kunit *test)
 	void *handler;
 
 	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev);
+	KUNIT_ASSERT_NOT_NULL(test, adev);
 	KUNIT_ASSERT_EQ(test, amdgpu_dm_irq_init(adev), 0);
 
 	int_params.int_context = INTERRUPT_LOW_IRQ_CONTEXT;
@@ -1145,7 +1145,7 @@ static void dm_test_irq_fini_removes_registered_handlers(struct kunit *test)
 	void *handler;
 
 	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev);
+	KUNIT_ASSERT_NOT_NULL(test, adev);
 	KUNIT_ASSERT_EQ(test, amdgpu_dm_irq_init(adev), 0);
 
 	int_params.int_context = INTERRUPT_LOW_IRQ_CONTEXT;
@@ -1178,7 +1178,7 @@ static void dm_test_irq_fini_on_empty_tables(struct kunit *test)
 	int src;
 
 	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev);
+	KUNIT_ASSERT_NOT_NULL(test, adev);
 	KUNIT_ASSERT_EQ(test, amdgpu_dm_irq_init(adev), 0);
 
 	amdgpu_dm_irq_fini(adev);
@@ -1207,9 +1207,9 @@ static void dm_test_get_crtc_by_otg_inst_returns_match(struct kunit *test)
 	drm = &adev->ddev;
 
 	acrtc_a = kunit_kzalloc(test, sizeof(*acrtc_a), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, acrtc_a);
+	KUNIT_ASSERT_NOT_NULL(test, acrtc_a);
 	acrtc_b = kunit_kzalloc(test, sizeof(*acrtc_b), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, acrtc_b);
+	KUNIT_ASSERT_NOT_NULL(test, acrtc_b);
 
 	INIT_LIST_HEAD(&acrtc_a->base.head);
 	INIT_LIST_HEAD(&acrtc_b->base.head);
@@ -1238,7 +1238,7 @@ static void dm_test_get_crtc_by_otg_inst_returns_null(struct kunit *test)
 	drm = &adev->ddev;
 
 	acrtc = kunit_kzalloc(test, sizeof(*acrtc), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, acrtc);
+	KUNIT_ASSERT_NOT_NULL(test, acrtc);
 
 	INIT_LIST_HEAD(&acrtc->base.head);
 	acrtc->otg_inst = 2;
@@ -1278,7 +1278,7 @@ static void dm_test_get_crtc_by_otg_inst_unassigned_otg(struct kunit *test)
 	adev = dm_kunit_alloc_adev(test);
 
 	acrtc = kunit_kzalloc(test, sizeof(*acrtc), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, acrtc);
+	KUNIT_ASSERT_NOT_NULL(test, acrtc);
 	adev->mode_info.crtcs[0] = acrtc;
 
 	KUNIT_EXPECT_PTR_EQ(test, amdgpu_dm_get_crtc_by_otg_inst(adev, -1), acrtc);
@@ -1295,7 +1295,7 @@ static void dm_test_set_irq_funcs(struct kunit *test)
 	struct amdgpu_device *adev;
 
 	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev);
+	KUNIT_ASSERT_NOT_NULL(test, adev);
 
 	adev->mode_info.num_crtc = 6;
 	adev->mode_info.num_hpd = 4;
@@ -1533,12 +1533,12 @@ static void dm_test_hpd_rx_irq_create_workqueue(struct kunit *test)
 	adev = dm_kunit_alloc_adev(test);
 
 	dc = kunit_kzalloc(test, sizeof(*dc), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dc);
+	KUNIT_ASSERT_NOT_NULL(test, dc);
 	dc->caps.max_links = 4;
 	adev->dm.dc = dc;
 
 	ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
+	KUNIT_ASSERT_NOT_NULL(test, ctx);
 
 	ctx->wq = amdgpu_dm_hpd_rx_irq_create_workqueue(adev);
 	KUNIT_ASSERT_NOT_NULL(test, ctx->wq);
@@ -1560,7 +1560,7 @@ static void dm_test_hpd_rx_irq_work_suspend_null(struct kunit *test)
 	struct amdgpu_display_manager *dm;
 
 	dm = kunit_kzalloc(test, sizeof(*dm), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dm);
+	KUNIT_ASSERT_NOT_NULL(test, dm);
 
 	/* A NULL hpd_rx_offload_wq must be a safe no-op (DC untouched). */
 	amdgpu_dm_hpd_rx_irq_work_suspend(dm);
@@ -1579,12 +1579,12 @@ static void dm_test_hpd_rx_irq_work_suspend_flushes(struct kunit *test)
 	adev = dm_kunit_alloc_adev(test);
 
 	dc = kunit_kzalloc(test, sizeof(*dc), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dc);
+	KUNIT_ASSERT_NOT_NULL(test, dc);
 	dc->caps.max_links = 2;
 	adev->dm.dc = dc;
 
 	ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
+	KUNIT_ASSERT_NOT_NULL(test, ctx);
 
 	ctx->wq = amdgpu_dm_hpd_rx_irq_create_workqueue(adev);
 	KUNIT_ASSERT_NOT_NULL(test, ctx->wq);
@@ -1607,7 +1607,7 @@ static void dm_test_set_crtc_irq_state_no_crtc(struct kunit *test)
 	struct amdgpu_device *adev;
 
 	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev);
+	KUNIT_ASSERT_NOT_NULL(test, adev);
 
 	/* mode_info.crtcs[0] is NULL -> returns 0 without dereferencing DC. */
 	KUNIT_EXPECT_EQ(test,
@@ -1623,7 +1623,7 @@ static void dm_test_set_pflip_irq_state_no_crtc(struct kunit *test)
 	struct amdgpu_device *adev;
 
 	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev);
+	KUNIT_ASSERT_NOT_NULL(test, adev);
 
 	KUNIT_EXPECT_EQ(test,
 			amdgpu_dm_set_pflip_irq_state(adev, NULL, 0, AMDGPU_IRQ_STATE_DISABLE), 0);
@@ -1638,7 +1638,7 @@ static void dm_test_set_vline0_irq_state_no_crtc(struct kunit *test)
 	struct amdgpu_device *adev;
 
 	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev);
+	KUNIT_ASSERT_NOT_NULL(test, adev);
 
 	KUNIT_EXPECT_EQ(test,
 			amdgpu_dm_set_vline0_irq_state(adev, NULL, 0, AMDGPU_IRQ_STATE_ENABLE), 0);
@@ -1653,7 +1653,7 @@ static void dm_test_set_vupdate_irq_state_no_crtc(struct kunit *test)
 	struct amdgpu_device *adev;
 
 	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev);
+	KUNIT_ASSERT_NOT_NULL(test, adev);
 
 	KUNIT_EXPECT_EQ(test,
 			amdgpu_dm_set_vupdate_irq_state(adev, NULL, 0, AMDGPU_IRQ_STATE_ENABLE), 0);
@@ -1671,9 +1671,9 @@ static void dm_test_set_crtc_irq_state_otg_disabled(struct kunit *test)
 	struct amdgpu_crtc *acrtc;
 
 	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev);
+	KUNIT_ASSERT_NOT_NULL(test, adev);
 	acrtc = kunit_kzalloc(test, sizeof(*acrtc), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, acrtc);
+	KUNIT_ASSERT_NOT_NULL(test, acrtc);
 
 	/* otg_inst == -1 short-circuits before computing the irq source. */
 	acrtc->otg_inst = -1;
@@ -1693,9 +1693,9 @@ static void dm_test_set_crtc_irq_state_enable(struct kunit *test)
 	struct amdgpu_crtc *acrtc;
 
 	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev);
+	KUNIT_ASSERT_NOT_NULL(test, adev);
 	acrtc = kunit_kzalloc(test, sizeof(*acrtc), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, acrtc);
+	KUNIT_ASSERT_NOT_NULL(test, acrtc);
 
 	/*
 	 * otg_inst >= 0 computes the irq source and reaches the NULL-safe
@@ -1718,9 +1718,9 @@ static void dm_test_set_pflip_irq_state_disable(struct kunit *test)
 	struct amdgpu_crtc *acrtc;
 
 	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev);
+	KUNIT_ASSERT_NOT_NULL(test, adev);
 	acrtc = kunit_kzalloc(test, sizeof(*acrtc), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, acrtc);
+	KUNIT_ASSERT_NOT_NULL(test, acrtc);
 
 	/* The disable state exercises the st == false path. */
 	acrtc->otg_inst = 1;
@@ -1748,13 +1748,13 @@ static void dm_test_set_crtc_irq_state_allows_idle(struct kunit *test)
 
 	adev = dm_kunit_alloc_adev(test);
 	acrtc = kunit_kzalloc(test, sizeof(*acrtc), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, acrtc);
+	KUNIT_ASSERT_NOT_NULL(test, acrtc);
 
 	dc = dm_test_alloc_dc_with_irq_service(test, &dm_test_irq_service_funcs_dcn10);
 
 	/* DC_LOG_* dereferences ctx->logger->dev, so wire a real drm device. */
 	logger = kunit_kzalloc(test, sizeof(*logger), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, logger);
+	KUNIT_ASSERT_NOT_NULL(test, logger);
 	logger->dev = &adev->ddev;
 	dc->ctx->logger = logger;
 
@@ -1782,7 +1782,7 @@ static void dm_test_irq_immediate_work_empty(struct kunit *test)
 	struct amdgpu_device *adev;
 
 	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev);
+	KUNIT_ASSERT_NOT_NULL(test, adev);
 	KUNIT_ASSERT_EQ(test, amdgpu_dm_irq_init(adev), 0);
 
 	/* No registered high-context handlers: must be a safe no-op. */
@@ -1801,7 +1801,7 @@ static void dm_test_irq_immediate_work_invokes_all(struct kunit *test)
 	void *handler;
 
 	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev);
+	KUNIT_ASSERT_NOT_NULL(test, adev);
 	KUNIT_ASSERT_EQ(test, amdgpu_dm_irq_init(adev), 0);
 
 	int_params.int_context = INTERRUPT_HIGH_IRQ_CONTEXT;
@@ -1832,7 +1832,7 @@ static void dm_test_irq_schedule_work_empty(struct kunit *test)
 	struct amdgpu_device *adev;
 
 	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev);
+	KUNIT_ASSERT_NOT_NULL(test, adev);
 	KUNIT_ASSERT_EQ(test, amdgpu_dm_irq_init(adev), 0);
 
 	/* Empty handler list: schedule_work returns immediately. */
@@ -1851,7 +1851,7 @@ static void dm_test_irq_schedule_work_queues_handler(struct kunit *test)
 	void *handler;
 
 	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev);
+	KUNIT_ASSERT_NOT_NULL(test, adev);
 	KUNIT_ASSERT_EQ(test, amdgpu_dm_irq_init(adev), 0);
 
 	int_params.int_context = INTERRUPT_LOW_IRQ_CONTEXT;
@@ -1892,7 +1892,7 @@ static void dm_test_irq_schedule_work_requeue_fallback(struct kunit *test)
 	void *handler;
 
 	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev);
+	KUNIT_ASSERT_NOT_NULL(test, adev);
 	KUNIT_ASSERT_EQ(test, amdgpu_dm_irq_init(adev), 0);
 
 	int_params.int_context = INTERRUPT_LOW_IRQ_CONTEXT;
@@ -1930,7 +1930,7 @@ static void dm_test_irq_schedule_work_no_workqueue(struct kunit *test)
 	void *handler;
 
 	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev);
+	KUNIT_ASSERT_NOT_NULL(test, adev);
 	KUNIT_ASSERT_EQ(test, amdgpu_dm_irq_init(adev), 0);
 
 	int_params.int_context = INTERRUPT_LOW_IRQ_CONTEXT;
@@ -1959,7 +1959,7 @@ static void dm_test_set_hpd_irq_state_null_dc(struct kunit *test)
 	struct amdgpu_device *adev;
 
 	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev);
+	KUNIT_ASSERT_NOT_NULL(test, adev);
 
 	/* amdgpu_dm_irq_set() is a no-op when dc is NULL, so both states
 	 * return 0 without dereferencing the (absent) DC.
@@ -1981,7 +1981,7 @@ static void dm_test_set_dmub_outbox_irq_state_null_dc(struct kunit *test)
 	struct amdgpu_device *adev;
 
 	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev);
+	KUNIT_ASSERT_NOT_NULL(test, adev);
 
 	KUNIT_EXPECT_EQ(test, amdgpu_dm_set_dmub_outbox_irq_state(adev, NULL, 0,
 								  AMDGPU_IRQ_STATE_ENABLE), 0);
@@ -2000,7 +2000,7 @@ static void dm_test_set_dmub_trace_irq_state_null_dc(struct kunit *test)
 	struct amdgpu_device *adev;
 
 	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev);
+	KUNIT_ASSERT_NOT_NULL(test, adev);
 
 	KUNIT_EXPECT_EQ(test, amdgpu_dm_set_dmub_trace_irq_state(adev, NULL, 0,
 								 AMDGPU_IRQ_STATE_ENABLE), 0);
@@ -2019,7 +2019,7 @@ static void dm_test_outbox_init_null_dc(struct kunit *test)
 	struct amdgpu_device *adev;
 
 	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev);
+	KUNIT_ASSERT_NOT_NULL(test, adev);
 
 	/* Single amdgpu_dm_irq_set() call must be skipped when dc is NULL. */
 	amdgpu_dm_outbox_init(adev);
@@ -2049,7 +2049,7 @@ static void dm_test_hpd_init_empty_connectors(struct kunit *test)
 	adev->dm.dc = dc;
 
 	link = kunit_kzalloc(test, sizeof(*link), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, link);
+	KUNIT_ASSERT_NOT_NULL(test, link);
 	link->irq_source_hpd = DC_IRQ_SOURCE_HPD1;
 	link->irq_source_hpd_rx = DC_IRQ_SOURCE_HPD1RX;
 	dc->links[0] = link;
@@ -2098,7 +2098,7 @@ static void dm_test_hpd_init_fini_with_connectors(struct kunit *test)
 
 	/* A writeback connector must be skipped by the per-connector loop. */
 	wbconn = kunit_kzalloc(test, sizeof(*wbconn), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, wbconn);
+	KUNIT_ASSERT_NOT_NULL(test, wbconn);
 	KUNIT_ASSERT_EQ(test, drm_connector_init(&adev->ddev, wbconn, &dm_test_connector_funcs,
 						 DRM_MODE_CONNECTOR_WRITEBACK), 0);
 	KUNIT_ASSERT_EQ(test,
@@ -2106,7 +2106,7 @@ static void dm_test_hpd_init_fini_with_connectors(struct kunit *test)
 
 	/* A DisplayPort connector with a dc_link exercises the loop body. */
 	aconn = kunit_kzalloc(test, sizeof(*aconn), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, aconn);
+	KUNIT_ASSERT_NOT_NULL(test, aconn);
 	KUNIT_ASSERT_EQ(test, drm_connector_init(&adev->ddev, &aconn->base,
 						 &dm_test_connector_funcs,
 						 DRM_MODE_CONNECTOR_DisplayPort), 0);
@@ -2114,7 +2114,7 @@ static void dm_test_hpd_init_fini_with_connectors(struct kunit *test)
 			kunit_add_action_or_reset(test, dm_test_connector_cleanup, &aconn->base), 0);
 
 	link = kunit_kzalloc(test, sizeof(*link), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, link);
+	KUNIT_ASSERT_NOT_NULL(test, link);
 	link->irq_source_hpd = DC_IRQ_SOURCE_HPD1;
 	link->irq_source_hpd_rx = DC_IRQ_SOURCE_HPD1RX;
 	aconn->dc_link = link;
@@ -2145,7 +2145,7 @@ static void dm_test_hpd_init_fini_analog_connector(struct kunit *test)
 	adev->dm.dc = dc;
 
 	aconn = kunit_kzalloc(test, sizeof(*aconn), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, aconn);
+	KUNIT_ASSERT_NOT_NULL(test, aconn);
 	KUNIT_ASSERT_EQ(test, drm_connector_init(&adev->ddev, &aconn->base,
 						 &dm_test_connector_funcs,
 						 DRM_MODE_CONNECTOR_VGA), 0);
@@ -2153,7 +2153,7 @@ static void dm_test_hpd_init_fini_analog_connector(struct kunit *test)
 			kunit_add_action_or_reset(test, dm_test_connector_cleanup, &aconn->base), 0);
 
 	link = kunit_kzalloc(test, sizeof(*link), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, link);
+	KUNIT_ASSERT_NOT_NULL(test, link);
 	link->irq_source_hpd = DC_IRQ_SOURCE_HPD1;
 	link->irq_source_hpd_rx = DC_IRQ_SOURCE_HPD1RX;
 	/* An analog connector id makes the loop request polling. */
@@ -2198,7 +2198,7 @@ static void dm_test_hpd_init_fini_irq_ref(struct kunit *test)
 	adev->mode_info.num_hpd = 1;
 
 	aconn = kunit_kzalloc(test, sizeof(*aconn), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, aconn);
+	KUNIT_ASSERT_NOT_NULL(test, aconn);
 	KUNIT_ASSERT_EQ(test, drm_connector_init(&adev->ddev, &aconn->base,
 						 &dm_test_connector_funcs,
 						 DRM_MODE_CONNECTOR_DisplayPort), 0);
@@ -2206,7 +2206,7 @@ static void dm_test_hpd_init_fini_irq_ref(struct kunit *test)
 			kunit_add_action_or_reset(test, dm_test_connector_cleanup, &aconn->base), 0);
 
 	link = kunit_kzalloc(test, sizeof(*link), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, link);
+	KUNIT_ASSERT_NOT_NULL(test, link);
 	link->irq_source_hpd = DC_IRQ_SOURCE_HPD1;
 	link->irq_source_hpd_rx = DC_IRQ_SOURCE_INVALID;
 	aconn->dc_link = link;
@@ -2236,7 +2236,7 @@ static void dm_test_hpd_init_skips_connector_without_link(struct kunit *test)
 	adev->dm.dc = dm_test_alloc_dc_with_irq_service(test, &dm_test_irq_service_funcs_dcn10);
 
 	aconn = kunit_kzalloc(test, sizeof(*aconn), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, aconn);
+	KUNIT_ASSERT_NOT_NULL(test, aconn);
 	KUNIT_ASSERT_EQ(test, drm_connector_init(&adev->ddev, &aconn->base,
 						 &dm_test_connector_funcs,
 						 DRM_MODE_CONNECTOR_DisplayPort), 0);
@@ -2264,10 +2264,10 @@ static void dm_test_hpd_rx_offload_work_no_connector(struct kunit *test)
 	adev = dm_kunit_alloc_adev(test);
 
 	offload_wq = kunit_kzalloc(test, sizeof(*offload_wq), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, offload_wq);
+	KUNIT_ASSERT_NOT_NULL(test, offload_wq);
 
 	offload_work = kzalloc_obj(*offload_work, GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, offload_work);
+	KUNIT_ASSERT_NOT_NULL(test, offload_work);
 	offload_work->offload_wq = offload_wq;
 	offload_work->adev = adev;
 	INIT_WORK(&offload_work->work, dm_handle_hpd_rx_offload_work);
@@ -2300,10 +2300,10 @@ dm_test_setup_hpd_rx_offload_work(struct kunit *test,
 	mutex_init(&adev->dm.dc_lock);
 	adev->reset_domain = kunit_kzalloc(test, sizeof(*adev->reset_domain),
 					   GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev->reset_domain);
+	KUNIT_ASSERT_NOT_NULL(test, adev->reset_domain);
 
 	offload_wq = kunit_kzalloc(test, sizeof(*offload_wq), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, offload_wq);
+	KUNIT_ASSERT_NOT_NULL(test, offload_wq);
 	spin_lock_init(&offload_wq->offload_lock);
 
 	aconn = dm_kunit_alloc_connector(test, adev, NULL);
@@ -2311,13 +2311,13 @@ dm_test_setup_hpd_rx_offload_work(struct kunit *test,
 	offload_wq->aconnector = aconn;
 
 	dc = kunit_kzalloc(test, sizeof(*dc), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dc);
+	KUNIT_ASSERT_NOT_NULL(test, dc);
 	ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
+	KUNIT_ASSERT_NOT_NULL(test, ctx);
 	link_srv = kunit_kzalloc(test, sizeof(*link_srv), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, link_srv);
+	KUNIT_ASSERT_NOT_NULL(test, link_srv);
 	link = kunit_kzalloc(test, sizeof(*link), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, link);
+	KUNIT_ASSERT_NOT_NULL(test, link);
 
 	link_srv->detect_connection_type = dm_test_detect_connection_single;
 	dc->link_srv = link_srv;
@@ -2329,7 +2329,7 @@ dm_test_setup_hpd_rx_offload_work(struct kunit *test,
 	aconn->dc_link = link;
 
 	offload_work = kzalloc_obj(*offload_work, GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, offload_work);
+	KUNIT_ASSERT_NOT_NULL(test, offload_work);
 	offload_work->offload_wq = offload_wq;
 	offload_work->adev = adev;
 	INIT_WORK(&offload_work->work, dm_handle_hpd_rx_offload_work);
@@ -2536,13 +2536,13 @@ static struct amdgpu_dm_connector *dm_test_setup_hdmi_debounce(struct kunit *tes
 			  amdgpu_dm_hdmi_hpd_debounce_work);
 
 	dc = kunit_kzalloc(test, sizeof(*dc), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dc);
+	KUNIT_ASSERT_NOT_NULL(test, dc);
 	ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
+	KUNIT_ASSERT_NOT_NULL(test, ctx);
 	link_srv = kunit_kzalloc(test, sizeof(*link_srv), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, link_srv);
+	KUNIT_ASSERT_NOT_NULL(test, link_srv);
 	link = kunit_kzalloc(test, sizeof(*link), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, link);
+	KUNIT_ASSERT_NOT_NULL(test, link);
 
 	link_srv->detect_link = dm_test_detect_link_false;
 	dc->ctx = ctx;
@@ -2594,9 +2594,9 @@ static void dm_test_hdmi_hpd_debounce_reallow_idle(struct kunit *test)
 	dc = aconn->dc_link->ctx->dc;
 
 	logger = kunit_kzalloc(test, sizeof(*logger), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, logger);
+	KUNIT_ASSERT_NOT_NULL(test, logger);
 	dmub_srv = kunit_kzalloc(test, sizeof(*dmub_srv), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dmub_srv);
+	KUNIT_ASSERT_NOT_NULL(test, dmub_srv);
 
 	/* DC_LOG_* dereferences ctx->logger->dev, so wire a real drm device. */
 	logger->dev = aconn->base.dev;
@@ -2697,15 +2697,15 @@ static void dm_test_handle_hpd_irq_disabled(struct kunit *test)
 
 	aconn = dm_kunit_alloc_connector(test, adev, NULL);
 	state = kunit_kzalloc(test, sizeof(*state), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, state);
+	KUNIT_ASSERT_NOT_NULL(test, state);
 	aconn->base.state = &state->base;
 
 	dc = kunit_kzalloc(test, sizeof(*dc), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dc);
+	KUNIT_ASSERT_NOT_NULL(test, dc);
 	ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
+	KUNIT_ASSERT_NOT_NULL(test, ctx);
 	link = kunit_kzalloc(test, sizeof(*link), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, link);
+	KUNIT_ASSERT_NOT_NULL(test, link);
 
 	dc->ctx = ctx;
 	ctx->dc = dc;
@@ -2746,17 +2746,17 @@ static struct amdgpu_dm_connector *dm_test_setup_hpd_irq_helper(struct kunit *te
 			  amdgpu_dm_hdmi_hpd_debounce_work);
 
 	state = kunit_kzalloc(test, sizeof(*state), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, state);
+	KUNIT_ASSERT_NOT_NULL(test, state);
 	aconn->base.state = &state->base;
 
 	dc = kunit_kzalloc(test, sizeof(*dc), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dc);
+	KUNIT_ASSERT_NOT_NULL(test, dc);
 	ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
+	KUNIT_ASSERT_NOT_NULL(test, ctx);
 	link_srv = kunit_kzalloc(test, sizeof(*link_srv), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, link_srv);
+	KUNIT_ASSERT_NOT_NULL(test, link_srv);
 	link = kunit_kzalloc(test, sizeof(*link), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, link);
+	KUNIT_ASSERT_NOT_NULL(test, link);
 
 	link_srv->detect_connection_type = dm_test_detect_connection_none;
 	dc->ctx = ctx;
@@ -3005,19 +3005,19 @@ static void dm_test_handle_hpd_rx_irq_disabled(struct kunit *test)
 	adev->dm.disable_hpd_irq = true;
 
 	offload_wq = kunit_kzalloc(test, sizeof(*offload_wq), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, offload_wq);
+	KUNIT_ASSERT_NOT_NULL(test, offload_wq);
 	adev->dm.hpd_rx_offload_wq = offload_wq;
 
 	aconn = dm_kunit_alloc_connector(test, adev, NULL);
 
 	dc = kunit_kzalloc(test, sizeof(*dc), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dc);
+	KUNIT_ASSERT_NOT_NULL(test, dc);
 	ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
+	KUNIT_ASSERT_NOT_NULL(test, ctx);
 	link_srv = kunit_kzalloc(test, sizeof(*link_srv), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, link_srv);
+	KUNIT_ASSERT_NOT_NULL(test, link_srv);
 	link = kunit_kzalloc(test, sizeof(*link), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, link);
+	KUNIT_ASSERT_NOT_NULL(test, link);
 
 	link_srv->dp_handle_hpd_rx_irq = dm_test_handle_hpd_rx_no_work;
 	dc->ctx = ctx;
@@ -3044,7 +3044,7 @@ static void dm_test_schedule_hpd_rx_offload_work(struct kunit *test)
 	adev = dm_kunit_alloc_adev(test);
 
 	offload_wq = kunit_kzalloc(test, sizeof(*offload_wq), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, offload_wq);
+	KUNIT_ASSERT_NOT_NULL(test, offload_wq);
 	offload_wq->wq = create_singlethread_workqueue("dm_irq_test_hpd_rx");
 	KUNIT_ASSERT_NOT_NULL(test, offload_wq->wq);
 
@@ -3082,7 +3082,7 @@ static struct amdgpu_dm_connector *dm_test_setup_hpd_rx_irq(struct kunit *test,
 	mutex_init(&adev->dm.dc_lock);
 
 	offload_wq = kunit_kzalloc(test, sizeof(*offload_wq), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, offload_wq);
+	KUNIT_ASSERT_NOT_NULL(test, offload_wq);
 	spin_lock_init(&offload_wq->offload_lock);
 	offload_wq->wq = create_singlethread_workqueue("dm_irq_test_hpd_rx");
 	KUNIT_ASSERT_NOT_NULL(test, offload_wq->wq);
@@ -3095,13 +3095,13 @@ static struct amdgpu_dm_connector *dm_test_setup_hpd_rx_irq(struct kunit *test,
 	aconn->mst_mgr.mst_state = true;
 
 	dc = kunit_kzalloc(test, sizeof(*dc), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dc);
+	KUNIT_ASSERT_NOT_NULL(test, dc);
 	ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
+	KUNIT_ASSERT_NOT_NULL(test, ctx);
 	link_srv = kunit_kzalloc(test, sizeof(*link_srv), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, link_srv);
+	KUNIT_ASSERT_NOT_NULL(test, link_srv);
 	link = kunit_kzalloc(test, sizeof(*link), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, link);
+	KUNIT_ASSERT_NOT_NULL(test, link);
 
 	dc->ctx = ctx;
 	dc->link_srv = link_srv;
@@ -3326,7 +3326,7 @@ static void dm_test_dmub_hpd_callback_invalid_index(struct kunit *test)
 
 	adev = dm_kunit_alloc_adev(test);
 	dc = kunit_kzalloc(test, sizeof(*dc), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dc);
+	KUNIT_ASSERT_NOT_NULL(test, dc);
 	adev->dm.dc = dc;
 	notify.link_index = 1;
 
@@ -3345,7 +3345,7 @@ static void dm_test_dmub_hpd_callback_empty_connectors(struct kunit *test)
 
 	adev = dm_kunit_alloc_adev(test);
 	dc = kunit_kzalloc(test, sizeof(*dc), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dc);
+	KUNIT_ASSERT_NOT_NULL(test, dc);
 	adev->dm.dc = dc;
 	adev->dm.ddev = &adev->ddev;
 	dc->link_count = 1;
@@ -3370,7 +3370,7 @@ static void dm_test_dmub_hpd_callback_suspend_skip(struct kunit *test)
 
 	adev = dm_kunit_alloc_adev(test);
 	dc = kunit_kzalloc(test, sizeof(*dc), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dc);
+	KUNIT_ASSERT_NOT_NULL(test, dc);
 	adev->dm.dc = dc;
 	adev->in_suspend = true;
 	dc->link_count = 1;
@@ -3402,25 +3402,25 @@ static void dm_test_dmub_hpd_callback_unknown_type_match(struct kunit *test)
 
 	adev = dm_kunit_alloc_adev(test);
 	dc = kunit_kzalloc(test, sizeof(*dc), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dc);
+	KUNIT_ASSERT_NOT_NULL(test, dc);
 	adev->dm.dc = dc;
 	adev->dm.ddev = &adev->ddev;
 	dc->link_count = 1;
 
 	link = kunit_kzalloc(test, sizeof(*link), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, link);
+	KUNIT_ASSERT_NOT_NULL(test, link);
 	dc->links[0] = link;
 
 	/* A writeback connector must be skipped by the loop. */
 	wbconn = kunit_kzalloc(test, sizeof(*wbconn), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, wbconn);
+	KUNIT_ASSERT_NOT_NULL(test, wbconn);
 	KUNIT_ASSERT_EQ(test, drm_connector_init(&adev->ddev, wbconn, &dm_test_connector_funcs,
 						 DRM_MODE_CONNECTOR_WRITEBACK), 0);
 	KUNIT_ASSERT_EQ(test, kunit_add_action_or_reset(test, dm_test_connector_cleanup, wbconn), 0);
 
 	/* A DisplayPort connector whose dc_link matches drives the match branch. */
 	aconn = kunit_kzalloc(test, sizeof(*aconn), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, aconn);
+	KUNIT_ASSERT_NOT_NULL(test, aconn);
 	KUNIT_ASSERT_EQ(test, drm_connector_init(&adev->ddev, &aconn->base,
 						 &dm_test_connector_funcs,
 						 DRM_MODE_CONNECTOR_DisplayPort), 0);
@@ -3457,13 +3457,13 @@ static void dm_test_dmub_hpd_callback_hpd_type(struct kunit *test)
 	mutex_init(&adev->dm.dc_lock);
 
 	dc = kunit_kzalloc(test, sizeof(*dc), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dc);
+	KUNIT_ASSERT_NOT_NULL(test, dc);
 	ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
+	KUNIT_ASSERT_NOT_NULL(test, ctx);
 	link_srv = kunit_kzalloc(test, sizeof(*link_srv), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, link_srv);
+	KUNIT_ASSERT_NOT_NULL(test, link_srv);
 	link = kunit_kzalloc(test, sizeof(*link), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, link);
+	KUNIT_ASSERT_NOT_NULL(test, link);
 
 	link_srv->detect_connection_type = dm_test_detect_connection_none;
 	link_srv->detect_link = dm_test_detect_link_false;
@@ -3479,7 +3479,7 @@ static void dm_test_dmub_hpd_callback_hpd_type(struct kunit *test)
 	dc->links[0] = link;
 
 	aconn = kunit_kzalloc(test, sizeof(*aconn), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, aconn);
+	KUNIT_ASSERT_NOT_NULL(test, aconn);
 	KUNIT_ASSERT_EQ(test, drm_connector_init(&adev->ddev, &aconn->base,
 						 &dm_test_connector_funcs,
 						 DRM_MODE_CONNECTOR_DisplayPort), 0);
@@ -3521,18 +3521,18 @@ static void dm_test_dmub_hpd_callback_hpd_irq_type(struct kunit *test)
 	mutex_init(&adev->dm.dc_lock);
 
 	offload_wq = kunit_kzalloc(test, sizeof(*offload_wq), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, offload_wq);
+	KUNIT_ASSERT_NOT_NULL(test, offload_wq);
 	spin_lock_init(&offload_wq->offload_lock);
 	adev->dm.hpd_rx_offload_wq = offload_wq;
 
 	dc = kunit_kzalloc(test, sizeof(*dc), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dc);
+	KUNIT_ASSERT_NOT_NULL(test, dc);
 	ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
+	KUNIT_ASSERT_NOT_NULL(test, ctx);
 	link_srv = kunit_kzalloc(test, sizeof(*link_srv), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, link_srv);
+	KUNIT_ASSERT_NOT_NULL(test, link_srv);
 	link = kunit_kzalloc(test, sizeof(*link), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, link);
+	KUNIT_ASSERT_NOT_NULL(test, link);
 
 	link_srv->dp_handle_hpd_rx_irq = dm_test_handle_hpd_rx_no_work;
 	dc->ctx = ctx;
@@ -3549,7 +3549,7 @@ static void dm_test_dmub_hpd_callback_hpd_irq_type(struct kunit *test)
 	dc->links[0] = link;
 
 	aconn = kunit_kzalloc(test, sizeof(*aconn), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, aconn);
+	KUNIT_ASSERT_NOT_NULL(test, aconn);
 	KUNIT_ASSERT_EQ(test, drm_connector_init(&adev->ddev, &aconn->base,
 						 &dm_test_connector_funcs,
 						 DRM_MODE_CONNECTOR_DisplayPort), 0);
@@ -3578,7 +3578,7 @@ static void dm_test_register_hpd_handlers_empty(struct kunit *test)
 
 	adev = dm_kunit_alloc_adev(test);
 	dc = kunit_kzalloc(test, sizeof(*dc), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dc);
+	KUNIT_ASSERT_NOT_NULL(test, dc);
 	adev->dm.dc = dc;
 
 	KUNIT_EXPECT_EQ(test, amdgpu_dm_register_hpd_handlers(adev), 0);
@@ -3603,18 +3603,18 @@ static void dm_test_register_hpd_handlers_valid(struct kunit *test)
 	adev = dm_kunit_alloc_adev(test);
 	KUNIT_ASSERT_EQ(test, amdgpu_dm_irq_init(adev), 0);
 	dc = kunit_kzalloc(test, sizeof(*dc), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dc);
+	KUNIT_ASSERT_NOT_NULL(test, dc);
 	adev->dm.dc = dc;
 
 	wbconn = kunit_kzalloc(test, sizeof(*wbconn), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, wbconn);
+	KUNIT_ASSERT_NOT_NULL(test, wbconn);
 	KUNIT_ASSERT_EQ(test, drm_connector_init(&adev->ddev, wbconn, &dm_test_connector_funcs,
 						 DRM_MODE_CONNECTOR_WRITEBACK), 0);
 	KUNIT_ASSERT_EQ(test,
 			kunit_add_action_or_reset(test, dm_test_connector_cleanup, wbconn), 0);
 
 	aconn = kunit_kzalloc(test, sizeof(*aconn), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, aconn);
+	KUNIT_ASSERT_NOT_NULL(test, aconn);
 	KUNIT_ASSERT_EQ(test, drm_connector_init(&adev->ddev, &aconn->base,
 						 &dm_test_connector_funcs,
 						 DRM_MODE_CONNECTOR_DisplayPort), 0);
@@ -3622,7 +3622,7 @@ static void dm_test_register_hpd_handlers_valid(struct kunit *test)
 			kunit_add_action_or_reset(test, dm_test_connector_cleanup, &aconn->base), 0);
 
 	link = kunit_kzalloc(test, sizeof(*link), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, link);
+	KUNIT_ASSERT_NOT_NULL(test, link);
 	link->irq_source_hpd = DC_IRQ_SOURCE_HPD1;
 	link->irq_source_hpd_rx = DC_IRQ_SOURCE_HPD1RX;
 	aconn->dc_link = link;
@@ -3650,11 +3650,11 @@ static void dm_test_register_hpd_handlers_invalid_hpd(struct kunit *test)
 	adev = dm_kunit_alloc_adev(test);
 	KUNIT_ASSERT_EQ(test, amdgpu_dm_irq_init(adev), 0);
 	dc = kunit_kzalloc(test, sizeof(*dc), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dc);
+	KUNIT_ASSERT_NOT_NULL(test, dc);
 	adev->dm.dc = dc;
 
 	aconn = kunit_kzalloc(test, sizeof(*aconn), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, aconn);
+	KUNIT_ASSERT_NOT_NULL(test, aconn);
 	KUNIT_ASSERT_EQ(test, drm_connector_init(&adev->ddev, &aconn->base,
 						 &dm_test_connector_funcs,
 						 DRM_MODE_CONNECTOR_DisplayPort), 0);
@@ -3662,7 +3662,7 @@ static void dm_test_register_hpd_handlers_invalid_hpd(struct kunit *test)
 			kunit_add_action_or_reset(test, dm_test_connector_cleanup, &aconn->base), 0);
 
 	link = kunit_kzalloc(test, sizeof(*link), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, link);
+	KUNIT_ASSERT_NOT_NULL(test, link);
 	link->irq_source_hpd = DC_IRQ_SOURCE_HPD1RX;
 	link->irq_source_hpd_rx = DC_IRQ_SOURCE_INVALID;
 	aconn->dc_link = link;
@@ -3685,11 +3685,11 @@ static void dm_test_register_hpd_handlers_invalid_hpd_rx(struct kunit *test)
 	adev = dm_kunit_alloc_adev(test);
 	KUNIT_ASSERT_EQ(test, amdgpu_dm_irq_init(adev), 0);
 	dc = kunit_kzalloc(test, sizeof(*dc), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dc);
+	KUNIT_ASSERT_NOT_NULL(test, dc);
 	adev->dm.dc = dc;
 
 	aconn = kunit_kzalloc(test, sizeof(*aconn), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, aconn);
+	KUNIT_ASSERT_NOT_NULL(test, aconn);
 	KUNIT_ASSERT_EQ(test, drm_connector_init(&adev->ddev, &aconn->base,
 						 &dm_test_connector_funcs,
 						 DRM_MODE_CONNECTOR_DisplayPort), 0);
@@ -3697,7 +3697,7 @@ static void dm_test_register_hpd_handlers_invalid_hpd_rx(struct kunit *test)
 			kunit_add_action_or_reset(test, dm_test_connector_cleanup, &aconn->base), 0);
 
 	link = kunit_kzalloc(test, sizeof(*link), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, link);
+	KUNIT_ASSERT_NOT_NULL(test, link);
 	link->irq_source_hpd = DC_IRQ_SOURCE_INVALID;
 	link->irq_source_hpd_rx = DC_IRQ_SOURCE_HPD1;
 	aconn->dc_link = link;
@@ -3802,7 +3802,7 @@ static void dm_test_pflip_high_irq_completes_flip(struct kunit *test)
 
 	/* drm_crtc_send_vblank_event() consumes (kfree()s) the event. */
 	event = kzalloc_obj(*event, GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, event);
+	KUNIT_ASSERT_NOT_NULL(test, event);
 	acrtc->event = event;
 
 	/* Balance the handler's drm_crtc_vblank_put(). */
@@ -3838,7 +3838,7 @@ static struct amdgpu_crtc *dm_test_setup_vrr_pflip_crtc(struct kunit *test,
 	dc = dm_kunit_alloc_dc_with_ctx(test);
 	dc->current_state = kunit_kzalloc(test, sizeof(*dc->current_state),
 					  GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dc->current_state);
+	KUNIT_ASSERT_NOT_NULL(test, dc->current_state);
 	adev->dm.dc = dc;
 
 	link = dm_kunit_alloc_link(test);
@@ -3878,7 +3878,7 @@ static void dm_test_pflip_high_irq_vrr_no_scanoutpos(struct kunit *test)
 
 	/* drm_crtc_send_vblank_event() consumes (kfree()s) the event. */
 	event = kzalloc_obj(*event, GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, event);
+	KUNIT_ASSERT_NOT_NULL(test, event);
 	acrtc->event = event;
 
 	/* Balance the handler's drm_crtc_vblank_put(). */
@@ -3911,14 +3911,14 @@ static void dm_test_pflip_high_irq_vrr_front_porch(struct kunit *test)
 	struct amdgpu_crtc *acrtc;
 
 	tg = kunit_kzalloc(test, sizeof(*tg), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, tg);
+	KUNIT_ASSERT_NOT_NULL(test, tg);
 	tg->funcs = &dm_test_tg_funcs;
 
 	acrtc = dm_test_setup_vrr_pflip_crtc(test, tg);
 	adev = drm_to_adev(acrtc->base.dev);
 
 	event = kzalloc_obj(*event, GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, event);
+	KUNIT_ASSERT_NOT_NULL(test, event);
 	acrtc->event = event;
 
 	params.adev = adev;
@@ -3979,7 +3979,7 @@ static void dm_test_vupdate_high_irq_dcn_completes_flip(struct kunit *test)
 	acrtc->pflip_status = AMDGPU_FLIP_SUBMITTED;
 
 	event = kzalloc_obj(*event, GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, event);
+	KUNIT_ASSERT_NOT_NULL(test, event);
 	acrtc->event = event;
 
 	adev->ddev.vblank[0].time = ktime_get();
@@ -4051,7 +4051,7 @@ static struct amdgpu_crtc *dm_test_setup_vmin_vmax_crtc(struct kunit *test,
 	dc = dm_kunit_alloc_dc_with_ctx(test);
 	dc->current_state = kunit_kzalloc(test, sizeof(*dc->current_state),
 					  GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dc->current_state);
+	KUNIT_ASSERT_NOT_NULL(test, dc->current_state);
 	adev->dm.dc = dc;
 
 	link = dm_kunit_alloc_link(test);
@@ -4208,7 +4208,7 @@ static void dm_test_crtc_high_irq_writeback_disables(struct kunit *test)
 	acrtc = dm_test_add_crtc(test, adev);
 
 	wb_conn = kunit_kzalloc(test, sizeof(*wb_conn), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, wb_conn);
+	KUNIT_ASSERT_NOT_NULL(test, wb_conn);
 	acrtc->wb_conn = wb_conn;
 	acrtc->wb_pending = true;
 
@@ -4244,7 +4244,7 @@ static void dm_test_crtc_high_irq_writeback_completes(struct kunit *test)
 	acrtc = dm_test_add_crtc(test, adev);
 
 	wb_conn = kunit_kzalloc(test, sizeof(*wb_conn), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, wb_conn);
+	KUNIT_ASSERT_NOT_NULL(test, wb_conn);
 	spin_lock_init(&wb_conn->job_lock);
 	INIT_LIST_HEAD(&wb_conn->job_queue);
 
@@ -4253,7 +4253,7 @@ static void dm_test_crtc_high_irq_writeback_completes(struct kunit *test)
 	 * work only kfree()s it; it needs nothing from this test.
 	 */
 	job = kzalloc_obj(*job, GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, job);
+	KUNIT_ASSERT_NOT_NULL(test, job);
 	list_add_tail(&job->list_entry, &wb_conn->job_queue);
 
 	acrtc->wb_conn = wb_conn;
@@ -4321,9 +4321,9 @@ static void dm_test_handle_hpd_work_out_of_range(struct kunit *test)
 
 	adev = dm_kunit_alloc_adev(test);
 	hpd_work = kzalloc_obj(*hpd_work, GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, hpd_work);
+	KUNIT_ASSERT_NOT_NULL(test, hpd_work);
 	hpd_work->dmub_notify = kzalloc_obj(*hpd_work->dmub_notify, GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, hpd_work->dmub_notify);
+	KUNIT_ASSERT_NOT_NULL(test, hpd_work->dmub_notify);
 	hpd_work->dmub_notify->type =
 		(enum dmub_notification_type)ARRAY_SIZE(adev->dm.dmub_callback);
 	hpd_work->adev = adev;
@@ -4345,7 +4345,7 @@ static void dm_test_handle_hpd_work_null_notify(struct kunit *test)
 
 	adev = dm_kunit_alloc_adev(test);
 	hpd_work = kzalloc_obj(*hpd_work, GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, hpd_work);
+	KUNIT_ASSERT_NOT_NULL(test, hpd_work);
 	hpd_work->adev = adev;
 	INIT_WORK(&hpd_work->handle_hpd_work, dm_handle_hpd_work);
 
@@ -4371,9 +4371,9 @@ static void dm_test_dmub_outbox1_low_irq_empty(struct kunit *test)
 	adev = dm_kunit_alloc_adev(test);
 	dc = dm_kunit_alloc_dc_with_ctx(test);
 	dc_dmub_srv = kunit_kzalloc(test, sizeof(*dc_dmub_srv), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dc_dmub_srv);
+	KUNIT_ASSERT_NOT_NULL(test, dc_dmub_srv);
 	dmub = kunit_kzalloc(test, sizeof(*dmub), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dmub);
+	KUNIT_ASSERT_NOT_NULL(test, dmub);
 
 	dmub->hw_funcs.get_outbox0_wptr = dm_test_dmub_get_outbox0_wptr;
 	dc_dmub_srv->dmub = dmub;
@@ -4405,11 +4405,11 @@ static void dm_test_dmub_outbox1_low_irq_drains_trace(struct kunit *test)
 	adev = dm_kunit_alloc_adev(test);
 	dc = dm_kunit_alloc_dc_with_ctx(test);
 	dc_dmub_srv = kunit_kzalloc(test, sizeof(*dc_dmub_srv), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dc_dmub_srv);
+	KUNIT_ASSERT_NOT_NULL(test, dc_dmub_srv);
 	dmub = kunit_kzalloc(test, sizeof(*dmub), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dmub);
+	KUNIT_ASSERT_NOT_NULL(test, dmub);
 	rb = kunit_kzalloc(test, DM_TEST_OUTBOX0_RB_SIZE, GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, rb);
+	KUNIT_ASSERT_NOT_NULL(test, rb);
 
 	dmub->outbox0_rb.base_address = rb;
 	dmub->outbox0_rb.capacity = DM_TEST_OUTBOX0_RB_SIZE;
@@ -4445,9 +4445,9 @@ static struct amdgpu_device *dm_test_alloc_adev_outbox_notify(struct kunit *test
 	adev = dm_kunit_alloc_adev(test);
 	dc = dm_kunit_alloc_dc_with_ctx(test);
 	dc_dmub_srv = kunit_kzalloc(test, sizeof(*dc_dmub_srv), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dc_dmub_srv);
+	KUNIT_ASSERT_NOT_NULL(test, dc_dmub_srv);
 	dmub = kunit_kzalloc(test, sizeof(*dmub), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dmub);
+	KUNIT_ASSERT_NOT_NULL(test, dmub);
 
 	dmub->hw_init = true;
 	dmub->hw_funcs.get_outbox0_wptr = dm_test_dmub_get_outbox0_wptr;
@@ -4925,7 +4925,7 @@ static void dm_test_register_outbox_irq_handlers_with_dmub(struct kunit *test)
 							 adev), 0);
 	dc = dm_test_alloc_dc_with_irq_service(test, &dm_test_irq_service_funcs_dcn10);
 	dc_dmub_srv = kunit_kzalloc(test, sizeof(*dc_dmub_srv), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dc_dmub_srv);
+	KUNIT_ASSERT_NOT_NULL(test, dc_dmub_srv);
 	dc->ctx->dmub_srv = dc_dmub_srv;
 	adev->dm.dc = dc;
 	amdgpu_dm_set_irq_funcs(adev);
@@ -4968,7 +4968,7 @@ static void dm_test_irq_handler_dispatches_work(struct kunit *test)
 	struct dc *dc;
 
 	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev);
+	KUNIT_ASSERT_NOT_NULL(test, adev);
 	KUNIT_ASSERT_EQ(test, amdgpu_dm_irq_init(adev), 0);
 
 	dc = dm_test_alloc_dc_with_irq_service(test,
@@ -5028,7 +5028,7 @@ static void dm_test_irq_handler_invalid_source(struct kunit *test)
 	int low_count = 0;
 
 	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev);
+	KUNIT_ASSERT_NOT_NULL(test, adev);
 	KUNIT_ASSERT_EQ(test, amdgpu_dm_irq_init(adev), 0);
 
 	/* This stub maps every src_id to DC_IRQ_SOURCE_INVALID. */
@@ -5075,17 +5075,17 @@ static void dm_test_handle_vmin_vmax_update(struct kunit *test)
 	struct dc *dc;
 
 	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev);
+	KUNIT_ASSERT_NOT_NULL(test, adev);
 	mutex_init(&adev->dm.dc_lock);
 
 	dc = dm_kunit_alloc_dc_with_ctx(test);
 	dc->current_state = kunit_kzalloc(test, sizeof(*dc->current_state),
 					  GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dc->current_state);
+	KUNIT_ASSERT_NOT_NULL(test, dc->current_state);
 	adev->dm.dc = dc;
 
 	stream = kunit_kzalloc(test, sizeof(*stream), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, stream);
+	KUNIT_ASSERT_NOT_NULL(test, stream);
 	/*
 	 * Start at two references: the worker's dc_stream_release() drops one,
 	 * leaving the kunit-managed allocation intact (no kfree).
@@ -5095,9 +5095,9 @@ static void dm_test_handle_vmin_vmax_update(struct kunit *test)
 
 	/* The worker kfree()s both, so they must come from the slab. */
 	work = kzalloc_obj(*work, GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, work);
+	KUNIT_ASSERT_NOT_NULL(test, work);
 	adjust = kzalloc_obj(*adjust, GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adjust);
+	KUNIT_ASSERT_NOT_NULL(test, adjust);
 
 	work->adev = adev;
 	work->stream = stream;
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_kunit_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_kunit_helpers.c
index aad122c7229f..f844b644bb77 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_kunit_helpers.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_kunit_helpers.c
@@ -182,7 +182,7 @@ struct drm_device *dm_kunit_alloc_drm_with_connector_list(struct kunit *test)
 	struct drm_device *dev;
 
 	dev = kunit_kzalloc(test, sizeof(*dev), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dev);
+	KUNIT_ASSERT_NOT_NULL(test, dev);
 
 	INIT_LIST_HEAD(&dev->mode_config.connector_list);
 	spin_lock_init(&dev->mode_config.connector_list_lock);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_mst_types_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_mst_types_test.c
index eafa3e6733a6..237431c83a81 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_mst_types_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_mst_types_test.c
@@ -203,7 +203,7 @@ static void dm_mst_test_needs_dsc_aux_workaround_match(struct kunit *test)
 {
 	struct dc_link *link = kunit_kzalloc(test, sizeof(*link), GFP_KERNEL);
 
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, link);
+	KUNIT_ASSERT_NOT_NULL(test, link);
 
 	link->dpcd_caps.branch_dev_id = DP_BRANCH_DEVICE_ID_90CC24;
 	link->dpcd_caps.dpcd_rev.raw = DPCD_REV_14;
@@ -223,7 +223,7 @@ static void dm_mst_test_needs_dsc_aux_workaround_rev12(struct kunit *test)
 {
 	struct dc_link *link = kunit_kzalloc(test, sizeof(*link), GFP_KERNEL);
 
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, link);
+	KUNIT_ASSERT_NOT_NULL(test, link);
 
 	link->dpcd_caps.branch_dev_id = DP_BRANCH_DEVICE_ID_90CC24;
 	link->dpcd_caps.dpcd_rev.raw = DPCD_REV_12;
@@ -243,7 +243,7 @@ static void dm_mst_test_needs_dsc_aux_workaround_wrong_dev_id(struct kunit *test
 {
 	struct dc_link *link = kunit_kzalloc(test, sizeof(*link), GFP_KERNEL);
 
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, link);
+	KUNIT_ASSERT_NOT_NULL(test, link);
 
 	link->dpcd_caps.branch_dev_id = 0x123456;
 	link->dpcd_caps.dpcd_rev.raw = DPCD_REV_14;
@@ -263,7 +263,7 @@ static void dm_mst_test_needs_dsc_aux_workaround_wrong_rev(struct kunit *test)
 {
 	struct dc_link *link = kunit_kzalloc(test, sizeof(*link), GFP_KERNEL);
 
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, link);
+	KUNIT_ASSERT_NOT_NULL(test, link);
 
 	link->dpcd_caps.branch_dev_id = DP_BRANCH_DEVICE_ID_90CC24;
 	link->dpcd_caps.dpcd_rev.raw = 0x11; /* DPCD 1.1 */
@@ -283,7 +283,7 @@ static void dm_mst_test_needs_dsc_aux_workaround_low_sink_count(struct kunit *te
 {
 	struct dc_link *link = kunit_kzalloc(test, sizeof(*link), GFP_KERNEL);
 
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, link);
+	KUNIT_ASSERT_NOT_NULL(test, link);
 
 	link->dpcd_caps.branch_dev_id = DP_BRANCH_DEVICE_ID_90CC24;
 	link->dpcd_caps.dpcd_rev.raw = DPCD_REV_14;
@@ -303,7 +303,7 @@ static void dm_mst_test_needs_dsc_aux_workaround_zero_sink_count(struct kunit *t
 {
 	struct dc_link *link = kunit_kzalloc(test, sizeof(*link), GFP_KERNEL);
 
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, link);
+	KUNIT_ASSERT_NOT_NULL(test, link);
 
 	link->dpcd_caps.branch_dev_id = DP_BRANCH_DEVICE_ID_90CC24;
 	link->dpcd_caps.dpcd_rev.raw = DPCD_REV_14;
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_quirks_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_quirks_test.c
index 150c53a68bed..8547ac047e7f 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_quirks_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_quirks_test.c
@@ -27,7 +27,7 @@ static void dm_test_quirks_aux_hpd_discon_reset(struct kunit *test)
 	struct amdgpu_display_manager *dm;
 
 	dm = kunit_kzalloc(test, sizeof(*dm), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dm);
+	KUNIT_ASSERT_NOT_NULL(test, dm);
 
 	dm->aux_hpd_discon_quirk = true;
 
@@ -54,7 +54,7 @@ static void dm_test_quirks_edp0_on_dp1_reset(struct kunit *test)
 	struct amdgpu_display_manager *dm;
 
 	dm = kunit_kzalloc(test, sizeof(*dm), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dm);
+	KUNIT_ASSERT_NOT_NULL(test, dm);
 
 	dm->edp0_on_dp1_quirk = true;
 
@@ -76,7 +76,7 @@ static void dm_test_quirks_no_dmi_match_both_false(struct kunit *test)
 	struct amdgpu_display_manager *dm;
 
 	dm = kunit_kzalloc(test, sizeof(*dm), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dm);
+	KUNIT_ASSERT_NOT_NULL(test, dm);
 
 	retrieve_dmi_info(dm);
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c
index a497cce332bb..b9272b28f53c 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c
@@ -258,9 +258,9 @@ static void dm_test_plane_layer_index_cmp_equal(struct kunit *test)
 	struct dc_surface_update sa, sb;
 
 	plane_a = kunit_kzalloc(test, sizeof(*plane_a), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, plane_a);
+	KUNIT_ASSERT_NOT_NULL(test, plane_a);
 	plane_b = kunit_kzalloc(test, sizeof(*plane_b), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, plane_b);
+	KUNIT_ASSERT_NOT_NULL(test, plane_b);
 
 	plane_a->layer_index = 5;
 	plane_b->layer_index = 5;
@@ -281,9 +281,9 @@ static void dm_test_plane_layer_index_cmp_descending(struct kunit *test)
 	struct dc_surface_update sa, sb;
 
 	plane_a = kunit_kzalloc(test, sizeof(*plane_a), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, plane_a);
+	KUNIT_ASSERT_NOT_NULL(test, plane_a);
 	plane_b = kunit_kzalloc(test, sizeof(*plane_b), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, plane_b);
+	KUNIT_ASSERT_NOT_NULL(test, plane_b);
 
 	plane_a->layer_index = 3;
 	plane_b->layer_index = 7;
@@ -305,9 +305,9 @@ static void dm_test_plane_layer_index_cmp_ascending(struct kunit *test)
 	struct dc_surface_update sa, sb;
 
 	plane_a = kunit_kzalloc(test, sizeof(*plane_a), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, plane_a);
+	KUNIT_ASSERT_NOT_NULL(test, plane_a);
 	plane_b = kunit_kzalloc(test, sizeof(*plane_b), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, plane_b);
+	KUNIT_ASSERT_NOT_NULL(test, plane_b);
 
 	plane_a->layer_index = 9;
 	plane_b->layer_index = 2;
@@ -763,7 +763,7 @@ static void dm_test_multisync_trigger_disabled(struct kunit *test)
 	struct dc_stream_state *stream;
 
 	stream = kunit_kzalloc(test, sizeof(*stream), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, stream);
+	KUNIT_ASSERT_NOT_NULL(test, stream);
 
 	stream->triggered_crtc_reset.enabled = false;
 	stream->triggered_crtc_reset.event = CRTC_EVENT_VSYNC_FALLING;
@@ -788,9 +788,9 @@ static void dm_test_multisync_trigger_rising(struct kunit *test)
 	struct dc_stream_state *master;
 
 	stream = kunit_kzalloc(test, sizeof(*stream), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, stream);
+	KUNIT_ASSERT_NOT_NULL(test, stream);
 	master = kunit_kzalloc(test, sizeof(*master), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, master);
+	KUNIT_ASSERT_NOT_NULL(test, master);
 
 	master->timing.flags.VSYNC_POSITIVE_POLARITY = 1;
 	stream->triggered_crtc_reset.enabled = true;
@@ -814,9 +814,9 @@ static void dm_test_multisync_trigger_falling(struct kunit *test)
 	struct dc_stream_state *master;
 
 	stream = kunit_kzalloc(test, sizeof(*stream), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, stream);
+	KUNIT_ASSERT_NOT_NULL(test, stream);
 	master = kunit_kzalloc(test, sizeof(*master), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, master);
+	KUNIT_ASSERT_NOT_NULL(test, master);
 
 	master->timing.flags.VSYNC_POSITIVE_POLARITY = 0;
 	stream->triggered_crtc_reset.enabled = true;
@@ -842,9 +842,9 @@ static void dm_test_master_stream_highest_refresh(struct kunit *test)
 	struct dc_stream_state *stream_set[2];
 
 	stream0 = kunit_kzalloc(test, sizeof(*stream0), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, stream0);
+	KUNIT_ASSERT_NOT_NULL(test, stream0);
 	stream1 = kunit_kzalloc(test, sizeof(*stream1), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, stream1);
+	KUNIT_ASSERT_NOT_NULL(test, stream1);
 	stream_set[0] = stream0;
 	stream_set[1] = stream1;
 
@@ -880,9 +880,9 @@ static void dm_test_master_stream_defaults_to_first(struct kunit *test)
 	struct dc_stream_state *stream_set[2];
 
 	stream0 = kunit_kzalloc(test, sizeof(*stream0), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, stream0);
+	KUNIT_ASSERT_NOT_NULL(test, stream0);
 	stream1 = kunit_kzalloc(test, sizeof(*stream1), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, stream1);
+	KUNIT_ASSERT_NOT_NULL(test, stream1);
 	stream_set[0] = stream0;
 	stream_set[1] = stream1;
 
-- 
2.43.0

