Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3089C79FA1
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Sep 2026 11:35:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7AD5B10EB3F;
	Tue,  8 Sep 2026 11:35:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Yk0NxdYS";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010044.outbound.protection.outlook.com [52.101.61.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2498310EB3F
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Sep 2026 11:35:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BOJZPd8eR+mhXGWtaDe1Rwg76yEBAXEvjmF2y8/6HybSbumPJQ9hM7yeaENNwll6iCX6TJU90Ud6pX9qRMXQgueTTD3AIP7iPGZF4NIYKaADlhtYe7aTOP4USLG3mf8TxuSglqN592y4de6WGe/rwElm0Cf8n4e5QI7cijaKRkXPgwL8gawh01I66prrGdpx3hUUGKT/LPjW/rzzQbPu6mJhpZH63Kk0kCqK8bcXqjQ1/+7MmK2zP5+9UnckVjwV++QfFAdRvGU6ynQyU3lW4vock5yOD5le0JVhEChd/OX4R7I8uRu9xkT+XY6NREBnIA8ig7OdnobSY9gBxAFb+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=smTykj7Z1NAacTpFsEsm1xsCjpcNw18Zz9FxRjtBg48=;
 b=PgFWEXyQZ9IXIdXxm0+E1VN3wteFtqGU9Y4M1C82kK8wwiLC6QK9Lh+4+KttTXuPhNlMdAth0rKGmVWsEJ/s2O9YfcHkH5YRiI6EKWzjO4tQfRWNQU7uD4UcBqn9v3RvUX0nQ5/Fxr5JQenwKrZ0MDH4EZ0psFiCeGwxq/eXq9ccFlemmrL/QJO5ftd2HI4/bB3WMAaoN4EhZsPRa20AJTsXNWrwTkD7D2z5EVo44KboaWWcOAJSU9+9r5WHbQPbv6TNdewTm/UWuMBxcEQmLUhHZhxzI6DUSOdniIZ3NJtH1BRe+srhpmAfwLA0NHE70clAfQSKqIkYiXgxF8VXzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=smTykj7Z1NAacTpFsEsm1xsCjpcNw18Zz9FxRjtBg48=;
 b=Yk0NxdYSEhP2YhLbKg1S906wb2cniqCJAcPvmFQMhqkGsu8hNbafoBAGSqpMHi2NtbhbqJQLFPpOpSsLy5YR4l7Zszv5A9jMDYJieih/+PjxqvYwmDxaR/Ymn1miMr7HYVZb3RLl7RGQ4S22FRn5ExfnNNbDzijAous3erRRI88=
Received: from BL1PR13CA0422.namprd13.prod.outlook.com (2603:10b6:208:2c3::7)
 by SA3PR12MB8438.namprd12.prod.outlook.com (2603:10b6:806:2f6::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Tue, 8 Sep
 2026 11:35:42 +0000
Received: from BN2PEPF0000A894.namprd04.prod.outlook.com
 (2603:10b6:208:2c3:cafe::42) by BL1PR13CA0422.outlook.office365.com
 (2603:10b6:208:2c3::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.7 via Frontend Transport; Tue, 8
 Sep 2026 11:35:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF0000A894.mail.protection.outlook.com (10.167.248.186) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Tue, 8 Sep 2026 11:35:42 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 8 Sep
 2026 06:35:41 -0500
Received: from chenyu-station.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Tue, 8 Sep 2026 06:35:33 -0500
From: Chenyu Chen <chen-yu.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>,
 "Chenyu Chen" <chen-yu.chen@amd.com>
Subject: [PATCH 13/66] drm/amd/display: Test pre-GFX9 plane buffer attributes
Date: Tue, 8 Sep 2026 19:31:06 +0800
Message-ID: <20260908113338.2433445-14-chen-yu.chen@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260908113338.2433445-1-chen-yu.chen@amd.com>
References: <20260908113338.2433445-1-chen-yu.chen@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A894:EE_|SA3PR12MB8438:EE_
X-MS-Office365-Filtering-Correlation-Id: 92bb5b80-23ac-4ac0-0566-08df0d9d50a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|23010399003|1800799024|82310400026|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 5yVmah8VRvTkHTwYBRUBPPZtACm9xKkRc3YJE7i3mb5NRJBUmcHDhHHtMwM70JgjMu3AEMJVB1PoXY3JRC7w+zJ560bs15eC9Tu6SezQzyhfS+C8AE7BHk97PgGK6joMWwNW68GyQdLIPlbKbZAwAa32TN+Ij9ehf8dTdOXEGt72F/vRGim135S25OfznAFSawQlIOIcSwJDPP18BFDGIVmbUB7H/7qYNtii86U6kmmLs7UccxsbeICOW1iNmrPAKJlBQX/ObEDw+8pR5PG7ZvjP+qG/bxWvz8c2uKD5O9L1C2p7FZr7zy9wGu+Qe1brGDTPKOjMiqrvhINxpbhKIpKcqrSFnqIJ3VuNYPxKHrdwO3wAz9+spvwiu5unYmipXvcDvrX9ZgChd692klb+EwSBQt0wM5V69m5jocqWVj/wxAICJxDcJaXE0EZ5vaMIAU0AA6nCHsqicjrFeP0y6uD/meQgNoO7lTc0A8KhwxGvNzjoBuOC+Bn7NxLRYogrZEHPhfVVnsfFbzSXnDLeTK1ebvrHExf4ASkZRZN86aVGQvpGYSVjZqIAIqkUVZTU7041T4FSovst0H8T+Nv9c3iUe3E8YH9kbkC4nmCn+DYiXJ3d9tLt1HiC1Oj+vv8isN4KP5vz/1mzJ8iDHpJo1/5eW9hEX2600I+ZNrlmVVIb9Pg0TmX0W0AkJ6mTEL/HOjxJdvGHtqYh7pvqcGkTAg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(23010399003)(1800799024)(82310400026)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: v5SzGOD9/cW0UJ3l4hpUL2u7zGi6Tp0zaASg0QlM11LkbWqzkZ1xR7g/6yP44/y/myL5bEeZIrlV9/poY5cbNopcnBXUdG7D5f/QLsCnDfLlVcbcSiwKr8Sh/nijXDAA8k8UJa6fUpC5/gQ5rSySVi6M5A+f4AvMWJ1BXXslyaV4fHr13bYtjjrzc9xNB00m71EET2mYNBJU7umvdUG4xc2crczbiYHNQC4LZS+lO7EbK4a84XRueUsXcpBg0XTSUN1mR+/M6PB2R9qcTXNgl50HaBOZbitc1qtmBGyN1KnKOnhymJa4UJoYmEomUt7nGPwsea6SmIclW/lTj5HVzTma9sPYeYRM1nUINLCHufH3SbJq+MElS3ivWrH3n6VtDwTkCiDiklYzScNDX4flz6WPE45n4/CW7+9wFzs11cm3rlWBvvpgOo6ko2Ld6NEJ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 11:35:42.3722 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 92bb5b80-23ac-4ac0-0566-08df0d9d50a8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000A894.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8438
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
Add a KUnit test for amdgpu_dm_plane_fill_plane_buffer_attributes()
covering the pre-Vega dispatch to the GFX6 modifier decoder.

[HOW]
Run a GFX6-family framebuffer through a 1D tiled modifier and check
the decoded tiling version, then repeat with a GFX9 modifier to check
that the decode error is propagated instead.

Assisted-by: Copilot:Claude-Opus-5
Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Chenyu Chen <chen-yu.chen@amd.com>
---
 .../amdgpu_dm/tests/amdgpu_dm_plane_test.c    | 47 +++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_plane_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_plane_test.c
index 13e07c4fc0c7..9680c3fa8bc7 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_plane_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_plane_test.c
@@ -3708,6 +3708,52 @@ static void dm_test_add_modifier_alloc_failure(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, size, 1ULL << 62);
 }
 
+/**
+ * dm_test_fill_plane_buffer_attributes_gfx6() - Verify the pre-GFX9 dispatch.
+ * @test: KUnit test context.
+ *
+ * Verify if a pre-Vega family decodes tiling from the GFX6 modifier instead of
+ * taking the GFX9 or GFX12 modifier paths, and propagates the decode error for
+ * a modifier the GFX6 decoder does not understand.
+ */
+static void dm_test_fill_plane_buffer_attributes_gfx6(struct kunit *test)
+{
+	struct dc_tiling_info tiling_info = {0};
+	struct dc_plane_dcc_param dcc = {0};
+	struct dc_plane_address address = {0};
+	struct plane_size plane_size = {0};
+	struct amdgpu_framebuffer *afb;
+	struct amdgpu_device *adev;
+
+	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
+	afb = kunit_kzalloc(test, sizeof(*afb), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, adev);
+	KUNIT_ASSERT_NOT_NULL(test, afb);
+
+	adev->family = AMDGPU_FAMILY_CZ;
+	afb->address = 0x80000000ULL;
+	afb->base.width = 1920;
+	afb->base.height = 1080;
+	afb->base.pitches[0] = 7680;
+	afb->base.format = drm_format_info(DRM_FORMAT_XRGB8888);
+	KUNIT_ASSERT_NOT_NULL(test, afb->base.format);
+	afb->base.modifier = AMD_FMT_MOD |
+			     AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX6) |
+			     AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX6_1D_TILED_THIN1) |
+			     AMD_FMT_MOD_SET(MICROTILE, AMD_FMT_MOD_MICROTILE_DISPLAY);
+
+	KUNIT_EXPECT_EQ(test, dm_test_graphics_attrs(adev, afb, &tiling_info,
+						     &plane_size, &dcc, &address), 0);
+	KUNIT_EXPECT_EQ(test, address.type, (int)PLN_ADDR_TYPE_GRAPHICS);
+	KUNIT_EXPECT_EQ(test, (int)tiling_info.gfxversion, (int)DcGfxVersion8);
+
+	afb->base.modifier = AMD_FMT_MOD |
+			     AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX9);
+
+	KUNIT_EXPECT_EQ(test, dm_test_graphics_attrs(adev, afb, &tiling_info,
+						     &plane_size, &dcc, &address), -EINVAL);
+}
+
 static struct kunit_case amdgpu_dm_plane_test_cases[] = {
 	/* amdgpu_dm_plane_is_video_format() */
 	KUNIT_CASE(dm_test_plane_is_video_format_known_video),
@@ -3746,6 +3792,7 @@ static struct kunit_case amdgpu_dm_plane_test_cases[] = {
 	/* amdgpu_dm_plane_fill_plane_buffer_attributes() */
 	KUNIT_CASE(dm_test_fill_plane_buffer_attributes_video),
 	KUNIT_CASE(dm_test_fill_plane_buffer_attributes_gfx12),
+	KUNIT_CASE(dm_test_fill_plane_buffer_attributes_gfx6),
 	/* amdgpu_dm_plane_get_cursor_position() */
 	KUNIT_CASE(dm_test_get_cursor_position),
 	KUNIT_CASE(dm_test_get_cursor_position_bad_size),
-- 
2.43.0

