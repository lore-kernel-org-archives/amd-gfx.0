Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10A8BC5B572
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Aug 2026 15:51:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D08310ECAD;
	Tue, 11 Aug 2026 15:51:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hfknAO38";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011060.outbound.protection.outlook.com [52.101.57.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE7B310ECAD
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Aug 2026 15:51:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LtxvBuyOFScFr3wQSbvi6Gmeg2lnUdaQUojRJOAFC37VfUvSGh2YeIpZgrdy4YyyehHrhaNyw1OWwPzMjOaY5+MPL9LKNbKdgJNLd6fXjjEfUnggza2x0ayBwdJAtKZzDqGT1EMmphHmAycHE8tWVykTW9rME1FWPZ+qM8x9LOGj7DyVvwkjGbioj0lc8JcMJuRm2nV+6eLRoN0xozQE2cYskM9bPriZhweWHZKWa2zzpDysIRAAs5JNYdaCsPFDfzOkwpygb6o8ykzYHEhkXsadGdBPJRlgAfvYFjiDDIVQ3X/XInWoBaS0L33BT4kZhDVxKgRICdDK07jMwrV30w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oQ67AFDU4vSFqJfLoWajxmPKVMHv9rpUFoyEZPpL+bY=;
 b=HjHGM1LwTyNdhDpAZZdehdLomqVh5iA13X/8E9+ye7SzAZ1Pyu1ESu61c89bPromOVE2j/gRXzmUHXGUAuuSnSPcPcCHrIF0CUEg1WHC2MYMfvGObTBq8iSz2V04oIIaZ8oANiBLGLy7Pe/fVcUiV7OaVwP5wjha/svROY3lX+1UGE/By5uA9KBhrYh0290RMWDQewp0Cy5DfBS7hRfRp5hgMjBVaVDNhUNeOLw4DWT7+AmAsQr7qZ29MCgTJruQVEWIoQMmeV+NoxHRHvRuy0ekyZU+eyl9QSqgYbEUhd6slNbaIz3yriwZsXQGJzxnJhEWnY7DZ53GY0+sv2B/MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oQ67AFDU4vSFqJfLoWajxmPKVMHv9rpUFoyEZPpL+bY=;
 b=hfknAO38xSejxp+0kXFjI9IvzP1OObDYmwZK0s0NaC3ZWhBenaWUtoafr5Im9f+tNzLe3C/9gWEhpCLohbl/sY92jq2CS6p0NcOL7bvW/4kQFxnAisZE2ofVZV7AdCpo9ZWqw8+3mghiADn8Jz7CdwdQoAr68modoHRaVDcEoQg=
Received: from CH0P221CA0026.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11d::6)
 by CH3PR12MB7595.namprd12.prod.outlook.com (2603:10b6:610:14c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Tue, 11 Aug
 2026 15:51:46 +0000
Received: from CH2PEPF0000013D.namprd02.prod.outlook.com
 (2603:10b6:610:11d:cafe::13) by CH0P221CA0026.outlook.office365.com
 (2603:10b6:610:11d::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.25 via Frontend Transport; Tue,
 11 Aug 2026 15:51:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH2PEPF0000013D.mail.protection.outlook.com (10.167.244.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Tue, 11 Aug 2026 15:51:46 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 11 Aug
 2026 10:51:39 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 11 Aug
 2026 10:51:39 -0500
Received: from james-Birman-PHX.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via
 Frontend Transport; Tue, 11 Aug 2026 10:51:31 -0500
From: James Lin <PingLei.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, James Lin <pinglei.lin@amd.com>
Subject: [PATCH 23/24] drm/amd/display: test native cursor mode on a disabled
 CRTC
Date: Tue, 11 Aug 2026 05:28:57 +0800
Message-ID: <20260810213010.1703162-24-PingLei.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260810213010.1703162-1-PingLei.Lin@amd.com>
References: <20260810213010.1703162-1-PingLei.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013D:EE_|CH3PR12MB7595:EE_
X-MS-Office365-Filtering-Correlation-Id: d40df006-ac43-4daf-b171-08def7c072af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|23010399003|1800799024|376014|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: DA6etye3+0lZAlroUaOLjm726ujPvksMw8YvjinE5Nl52pa76+IvmyjBgsPkBDkX2fTrweqve+w+l5qkguvTtIMyAwk3FvlYqjTcHWY2Nh4iPelOE5lrJin6f5BztfHGHvRzjqFv96tr3bpC5KhFeIkF0j1azEA52yP3ywnHkZHNK63UG5B3OIwBgSo/B39+iu6sNIr3vsuEJq3sfwsH9Yb6IFasbvUtBX9qXSGA1Zz3+qHg3253ryaWPPgbo5QHmcJfRQZhXIbXt8An/nXLLjk2jrXTiuryaNEV2WI0KK59jU3lf2Slr3/q9Fmw+QLD/smeTzSukkd6sIRpy0TixfqMYVjAIY+ZbU8G7TeV0S3RmEAqxXeG4yDZRPfB2Y73lSSeQ/d4njSlzIVJtKERWqzJbuAZ4z63gokrDoXNW6z0ji9hQziEYWUcEN3ZVYuAgPFLy3M0KBEmHUTN2TJPvl9Kujei0DLm+HaEmPxVIOQbwL3qt08dLGDt9f/rVoeKnYduool+WlvHApiz1hPKFgwD7rNrCW9BBMSB1P9ZicHQ4Go3fVfJm8RCdhx0fOoIZOYGYFvz7JJ/UJTtw19MhRox1r3jtfPGcD5PQIqVGU3VUv7yVxtXoTKOnz4Tv6fxYOH8OiON0sI7Ed9DxWrFxXjIDlE0wKLmQh4wjX/AG/xdhj7AUERkCzsvbVSRHthH
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(23010399003)(1800799024)(376014)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: PFD1Kyti2NjUUZga9C9oF4k0UQ9VSCLVUiH5nuG06R5SSUtoi2kRdQltMEj7XxjviD7mHHyg4VCr+GY6AHjDQRbTkqdM+5UZD2u7ay2qHREcoPXy5Qwg2ffi/HoXsOOrw2weQBbvtl5GzpblFec8nJwW69N6kvvg+lSewxHl9rrTTwMqfPoMVf9Uq1jVRjyvFxfMWEdwfx4FaI6QSJYf8WngiTU/Nw1eXsW633Y7h0+Sl1Lv29xk1j7nt0FbFkqy0AgaqI160bwUr117meEz10nzLYuzCsfWEo/YhngYsMY6qcfMOLZciSl7e+XIHnjvwsqdF2N3MbIpZOnYM05ghL3T1qN3GaJzRrEUwOXOmVWFUlesEzspCpCptw+m79Mra+fus2GG9XDmKXuDCne48O9kLlJdT6pFJlTm8vBxW7nnwNCJRqkZl4xiaFqR7EK2
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2026 15:51:46.2535 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d40df006-ac43-4daf-b171-08def7c072af
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000013D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7595
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

From: Tom Chung <chiahsuan.chung@amd.com>

[why]
Upstream has no KUnit coverage for amdgpu_dm_crtc_get_cursor_mode(),
which is why the fix in the previous commit came with no test. The
disabled-CRTC path is easy to regress again: it has already been lost
once to a refactor.

[how]
Add a test whose plane setup would otherwise select overlay mode, and
check that a disabled CRTC still reports native mode. Reverting the
previous commit makes only this test fail.

Reviewed-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: James Lin <pinglei.lin@amd.com>
---
 .../amdgpu_dm/tests/amdgpu_dm_cursor_test.c   | 22 +++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_cursor_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_cursor_test.c
index 9e76dfa887ea..efd16575896e 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_cursor_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_cursor_test.c
@@ -499,6 +499,27 @@ static void dm_test_plane_color_pipeline_ignores_other_plane(struct kunit *test)
 
 /* Tests for amdgpu_dm_crtc_get_cursor_mode() */
 
+/**
+ * dm_test_crtc_get_cursor_mode_disabled_crtc - Test a disabled CRTC uses native cursor
+ * @test: The KUnit test context
+ *
+ * A disabled CRTC must report native mode regardless of what the planes look
+ * like, so that a commit disabling the CRTC is not rejected. The plane setup
+ * here would otherwise select overlay mode.
+ */
+static void dm_test_crtc_get_cursor_mode_disabled_crtc(struct kunit *test)
+{
+	struct dm_cursor_mode_fixture fixture = dm_test_alloc_cursor_mode_fixture(test);
+	enum amdgpu_dm_cursor_mode cursor_mode = DM_CURSOR_OVERLAY_MODE;
+
+	fixture.dm_crtc_state->base.enable = false;
+	fixture.old_primary_state->crtc_w = 1280;
+	fixture.primary_state->crtc_w = 1280;
+
+	KUNIT_EXPECT_EQ(test, dm_test_get_cursor_mode(&fixture, &cursor_mode), 0);
+	KUNIT_EXPECT_EQ(test, cursor_mode, DM_CURSOR_NATIVE_MODE);
+}
+
 /**
  * dm_test_crtc_get_cursor_mode_new_hardware - Test new hardware always uses native mode
  * @test: The KUnit test context
@@ -925,6 +946,7 @@ static struct kunit_case amdgpu_dm_cursor_tests[] = {
 	KUNIT_CASE(dm_test_plane_color_pipeline_active),
 	KUNIT_CASE(dm_test_plane_color_pipeline_ignores_other_plane),
 	/* amdgpu_dm_crtc_get_cursor_mode */
+	KUNIT_CASE(dm_test_crtc_get_cursor_mode_disabled_crtc),
 	KUNIT_CASE(dm_test_crtc_get_cursor_mode_new_hardware),
 	KUNIT_CASE(dm_test_crtc_get_cursor_mode_no_change),
 	KUNIT_CASE(dm_test_crtc_get_cursor_mode_disabled_cursor),
-- 
2.43.0

