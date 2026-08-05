Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F496C561E6
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Aug 2026 06:41:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE61310ED12;
	Wed,  5 Aug 2026 06:41:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JXCjmupP";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010006.outbound.protection.outlook.com [52.101.85.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F194C10ED12
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Aug 2026 06:41:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=duyoAQKwmEgJxuaUfY4Tt41k9E1GGtcFc0lYsaVs+1xhok0lnvLewiq8S8H8/f+y1TUBbN+BjQ4Pv7UqSGHxOhlV0xtr9pGIMU5k0zFj6AhxukLRGHbAbkpCxS6Y633kFN01y1rpRaEFO0Y1oiWEMamO1LHkLrvyFd7iRQvGmTn5zNudp/24PKnVBHdqp3KmFT9178PsNwXR9sa+59siMeHJzOpBBwh87CAK6HX7AxEZ+nVSiXYfe8CqdbWYa9te26h+vno2RQ7jsYW+gkJqwm9bRmnhw0PxvyXUE+vuzX7W+5Sd/JmaYk91HE3I3WryXY84Km+2ULNDGekibSaquA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dvl28fgVj+6qFAQ7hXc4zUMOLhoLg+w0KOaHxiSUIZY=;
 b=W5U2QfiliWteA5cNj6pyhT0r9IBHYPx3QFYHtfmWIBggbuHrxtI0FRWBfoZ6KPOF2ygbUELI+h/8B7VFr9+8m3EhYnOPryASjmzOvMoo+k6UfPBh6pXgK9o8pGrdl1R5ZJMWxHLMVKghb6kPSP4o1zTZM8DB32DXmQCRujMyRM4IzhVoRcCAHRwxEcC2XpnFj3VyImVEPXTQh6UbnZ5AAIHLdgkdrbBuNtZn/XxZ64Os2k4gtkDn+BSWX+TSzeBQIYEnY/o7hH73vH+zLGoHWhLshqRtuxBAe9hJhI/fDF4ivQC0BrGaXR/EIO6u2ElPZHl1nZjN6AkrELHSLv5mDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dvl28fgVj+6qFAQ7hXc4zUMOLhoLg+w0KOaHxiSUIZY=;
 b=JXCjmupP79DrR7ZrlDamYZYYyJZP+94OagT5M/euRV0ycAZsHEVbKvbYomNn0QwA/s2La3PiKXwvDN/xQKA3Uprbw9XQJBhsx68vCTVggfFUYMvZbZ5r3sTbKGrCGxZr8h6b7cj86a3XnoxmbYOwWbckPzGUu3xw2hYkFFdgWYE=
Received: from SJ0PR13CA0107.namprd13.prod.outlook.com (2603:10b6:a03:2c5::22)
 by MW6PR12MB8835.namprd12.prod.outlook.com (2603:10b6:303:240::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.17; Wed, 5 Aug
 2026 06:41:42 +0000
Received: from MWH0EPF000C6189.namprd02.prod.outlook.com
 (2603:10b6:a03:2c5:cafe::a5) by SJ0PR13CA0107.outlook.office365.com
 (2603:10b6:a03:2c5::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.16 via Frontend Transport; Wed, 5
 Aug 2026 06:41:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000C6189.mail.protection.outlook.com (10.167.249.121) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Wed, 5 Aug 2026 06:41:42 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 5 Aug
 2026 01:41:32 -0500
Received: from tom-r5.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 5 Aug 2026 01:41:29 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Subject: [PATCH 25/34] drm/amd/display: test amdgpu_dm_crtc_get_cursor_mode
Date: Wed, 5 Aug 2026 14:36:37 +0800
Message-ID: <20260805063937.2145774-26-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260805063937.2145774-1-chiahsuan.chung@amd.com>
References: <20260805063937.2145774-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6189:EE_|MW6PR12MB8835:EE_
X-MS-Office365-Filtering-Correlation-Id: ae2582e0-79f2-4cab-06a5-08def2bc9c38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|23010399003|376014|18002099003|22082099003|11063799006|6133799003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: yJ7WngP14Ta99iIC4ZD9xknySleBXdvbQZi//1jiOsbfM8HR9casCOJXaIfhN2NmyInUNXdXFV3qwJNKB8INIjdjRx/NMCPfEcUA8cJtCUdo6R7v+9MulHXlioTNTHLcMj2AIglCNjmq0XiyUGwCNK5BLkKPnPxzXMuHRWGCdK5bXu1S0guPrXtQGvOHujNXZmkHDir8DIXcORcpfwhywthTjMKd6QkU8AK1N3VvcbVHvES0THgmzkhKarDK+Tiaoum20yul4SLki5X6Wpq3B1nw3LLHFZkGEJ3t4laid8SQ/Oqd9TKOqnhDZ9O8qQY2UhCxms2gyzlBJQixiVGFD0IH95flpv2tSD9MPacxa1ac0jvX6nkd0lPpTAFjR8t6FBt79IlgL43mmF+vh3JYxplbiehSzJjtdHt+7Bf0aKH31qNWNOD/JyU+ILR1T5H829cp+W6Ar7A8X4e0IS4BPCVESYtWEgvB+eN4HVQ5uR27If8D/9qfs0jxq+0xCC+eNDDK4py2K23nFovzbpba7JWq/bzjXICYXCH27lVpa5r0zcuU3AG0UfEHX3k/4GyrpKPVrbjnM9skz8tSIa+roiuyllGfS4qcTvpZdxkqzu6HWggH/T3beKeyYwct7YBy7j9uUHRe9OOqGivjcAG7d+UgcbEG9LeGHyfOlKzAXSU/4vjY1DESypnIK8/Ynbh5nm0cTnO4JPq5M1WSaeRrLA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(23010399003)(376014)(18002099003)(22082099003)(11063799006)(6133799003)(10067099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 0ih4Iee4gtdAYP++I6eRY0ocYr5/Vr050puf8si5VP5tqLdua/VxgMwoTVeeXzVxphaO0y82ay+i2F0tnubEjtVoaWkZcX/qBJc6/Z1D1fXPmRAJSKeAgDXNA+5PjW5nDQdsgu5YgFDxY8ZbAcB7hNSlOE9+dN6dR1DwHnJOUYdH0nWC0n34QIAU9YEPnTtqyk2BniCk6kWfUqxl+8sPFBBxaHcStvv6Yj0oxMit7LtBNRXnDqPlJn0C6irtTPfspNFGeOMJgcfbX05BX7iJdEYMHigFOsx7VS78ePrvxs1fb2W98iXhQd5RnMsE0JyhCUHyxp0QYLYX+UwoXGj0tXcw+9/pidtkQoSnMwYqLWB8+2jnUembDzXdYnlpF1h0CdxUNYgK123rrqy2p10ZN0L9Q4MPgvN3LYZUU75wkaElKjVeZ106xOt38XwvqxRv
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2026 06:41:42.0529 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ae2582e0-79f2-4cab-06a5-08def2bc9c38
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000C6189.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8835
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
Add KUnit tests for amdgpu_dm_crtc_get_cursor_mode() with a synthetic
two-plane atomic-state fixture, an invocation helper, and a colorop
helper, covering:

- new hardware defaulting to overlay mode,
- an unchanged state keeping native mode,
- a disabled cursor keeping native mode,
- a YUV underlying plane forcing overlay,
- a plane scale mismatch forcing overlay,
- full cursor coverage allowing native mode,
- a coverage hole forcing overlay,
- an unrelated update leaving the cursor untouched,
- a cursor scale change forcing recomputation,
- a cursor position change forcing recomputation,
- a color pipeline activation forcing recomputation.

Assisted-by: Copilot:GPT-5.6-Sol
Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_cursor.c  |   1 +
 .../amdgpu_dm/tests/amdgpu_dm_cursor_test.c   | 336 ++++++++++++++++++
 2 files changed, 337 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_cursor.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_cursor.c
index 34b5f2b28e91..046ffc0bd5dc 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_cursor.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_cursor.c
@@ -444,3 +444,4 @@ int amdgpu_dm_crtc_get_cursor_mode(struct amdgpu_device *adev,
 
 	return 0;
 }
+EXPORT_IF_KUNIT(amdgpu_dm_crtc_get_cursor_mode);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_cursor_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_cursor_test.c
index e093420bb2fd..f085eb1a616d 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_cursor_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_cursor_test.c
@@ -54,6 +54,144 @@ static struct dm_cursor_fb_fixture dm_test_alloc_cursor_fb_fixture(struct kunit
 	return fixture;
 }
 
+struct dm_cursor_mode_fixture {
+	struct amdgpu_device *adev;
+	struct drm_atomic_commit *state;
+	struct dm_crtc_state *dm_crtc_state;
+	struct drm_crtc *crtc;
+	struct drm_plane *cursor;
+	struct drm_plane *primary;
+	struct drm_plane_state *old_cursor_state;
+	struct drm_plane_state *cursor_state;
+	struct drm_plane_state *old_primary_state;
+	struct drm_plane_state *primary_state;
+	struct drm_framebuffer *cursor_fb;
+	struct drm_framebuffer *primary_fb;
+};
+
+static struct dm_cursor_mode_fixture dm_test_alloc_cursor_mode_fixture(struct kunit *test)
+{
+	struct dm_cursor_mode_fixture fixture = { 0 };
+
+	fixture.adev = dm_kunit_alloc_adev(test);
+	fixture.state = kunit_kzalloc(test, sizeof(*fixture.state), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, fixture.state);
+	fixture.dm_crtc_state = kunit_kzalloc(test, sizeof(*fixture.dm_crtc_state), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, fixture.dm_crtc_state);
+	fixture.crtc = kunit_kzalloc(test, sizeof(*fixture.crtc), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, fixture.crtc);
+	fixture.cursor = kunit_kzalloc(test, sizeof(*fixture.cursor), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, fixture.cursor);
+	fixture.primary = kunit_kzalloc(test, sizeof(*fixture.primary), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, fixture.primary);
+	fixture.old_cursor_state =
+		kunit_kzalloc(test, sizeof(*fixture.old_cursor_state), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, fixture.old_cursor_state);
+	fixture.cursor_state = kunit_kzalloc(test, sizeof(*fixture.cursor_state), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, fixture.cursor_state);
+	fixture.old_primary_state =
+		kunit_kzalloc(test, sizeof(*fixture.old_primary_state), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, fixture.old_primary_state);
+	fixture.primary_state = kunit_kzalloc(test, sizeof(*fixture.primary_state), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, fixture.primary_state);
+	fixture.cursor_fb = kunit_kzalloc(test, sizeof(*fixture.cursor_fb), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, fixture.cursor_fb);
+	fixture.primary_fb = kunit_kzalloc(test, sizeof(*fixture.primary_fb), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, fixture.primary_fb);
+	fixture.state->planes = kunit_kcalloc(test, 2, sizeof(*fixture.state->planes), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, fixture.state->planes);
+	fixture.state->acquire_ctx =
+		kunit_kzalloc(test, sizeof(*fixture.state->acquire_ctx), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, fixture.state->acquire_ctx);
+
+	fixture.adev->ddev.mode_config.num_total_plane = 2;
+	fixture.state->dev = &fixture.adev->ddev;
+	fixture.crtc->dev = &fixture.adev->ddev;
+	fixture.crtc->cursor = fixture.cursor;
+	fixture.cursor->dev = &fixture.adev->ddev;
+	fixture.cursor->index = 0;
+	fixture.cursor->type = DRM_PLANE_TYPE_CURSOR;
+	fixture.cursor->base.id = 2;
+	fixture.primary->dev = &fixture.adev->ddev;
+	fixture.primary->index = 1;
+	fixture.primary->type = DRM_PLANE_TYPE_PRIMARY;
+	fixture.primary->base.id = 1;
+
+	fixture.cursor_fb->format = drm_format_info(DRM_FORMAT_ARGB8888);
+	fixture.primary_fb->format = drm_format_info(DRM_FORMAT_XRGB8888);
+	fixture.old_cursor_state->plane = fixture.cursor;
+	fixture.old_cursor_state->crtc = fixture.crtc;
+	fixture.old_cursor_state->fb = fixture.cursor_fb;
+	fixture.old_cursor_state->src_w = 64 << 16;
+	fixture.old_cursor_state->src_h = 64 << 16;
+	fixture.old_cursor_state->crtc_w = 64;
+	fixture.old_cursor_state->crtc_h = 64;
+	fixture.old_cursor_state->zpos = 1;
+	*fixture.cursor_state = *fixture.old_cursor_state;
+	fixture.cursor_state->state = fixture.state;
+	fixture.old_primary_state->plane = fixture.primary;
+	fixture.old_primary_state->crtc = fixture.crtc;
+	fixture.old_primary_state->fb = fixture.primary_fb;
+	fixture.old_primary_state->src_w = 1920 << 16;
+	fixture.old_primary_state->src_h = 1080 << 16;
+	fixture.old_primary_state->crtc_w = 1920;
+	fixture.old_primary_state->crtc_h = 1080;
+	fixture.old_primary_state->zpos = 0;
+	*fixture.primary_state = *fixture.old_primary_state;
+	fixture.primary_state->state = fixture.state;
+
+	fixture.state->planes[0].ptr = fixture.cursor;
+	fixture.state->planes[0].old_state = fixture.old_cursor_state;
+	fixture.state->planes[0].new_state = fixture.cursor_state;
+	fixture.state->planes[1].ptr = fixture.primary;
+	fixture.state->planes[1].old_state = fixture.old_primary_state;
+	fixture.state->planes[1].new_state = fixture.primary_state;
+	fixture.dm_crtc_state->base.crtc = fixture.crtc;
+	fixture.dm_crtc_state->base.plane_mask = drm_plane_mask(fixture.cursor) |
+						 drm_plane_mask(fixture.primary);
+	fixture.dm_crtc_state->base.zpos_changed = true;
+	fixture.dm_crtc_state->base.mode.hdisplay = 1920;
+	fixture.dm_crtc_state->base.mode.vdisplay = 1080;
+
+	return fixture;
+}
+
+static void dm_test_add_cursor_mode_colorop(struct kunit *test,
+					    struct dm_cursor_mode_fixture *fixture,
+					    bool old_bypass, bool new_bypass)
+{
+	struct drm_colorop_state *old_colorop_state;
+	struct drm_colorop_state *new_colorop_state;
+	struct drm_colorop *colorop;
+
+	colorop = kunit_kzalloc(test, sizeof(*colorop), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, colorop);
+	old_colorop_state = kunit_kzalloc(test, sizeof(*old_colorop_state), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, old_colorop_state);
+	new_colorop_state = kunit_kzalloc(test, sizeof(*new_colorop_state), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, new_colorop_state);
+	fixture->state->colorops =
+		kunit_kzalloc(test, sizeof(*fixture->state->colorops), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, fixture->state->colorops);
+
+	fixture->adev->ddev.mode_config.num_colorop = 1;
+	fixture->state->colorops[0].ptr = colorop;
+	fixture->state->colorops[0].old_state = old_colorop_state;
+	fixture->state->colorops[0].new_state = new_colorop_state;
+	colorop->plane = fixture->primary;
+	old_colorop_state->colorop = colorop;
+	old_colorop_state->bypass = old_bypass;
+	new_colorop_state->colorop = colorop;
+	new_colorop_state->bypass = new_bypass;
+}
+
+static int dm_test_get_cursor_mode(struct dm_cursor_mode_fixture *fixture,
+				   enum amdgpu_dm_cursor_mode *cursor_mode)
+{
+	return amdgpu_dm_crtc_get_cursor_mode(fixture->adev, fixture->state,
+					      fixture->dm_crtc_state, cursor_mode);
+}
+
 /* Tests for dm_check_cursor_fb() */
 
 /**
@@ -358,6 +496,192 @@ static void dm_test_plane_color_pipeline_ignores_other_plane(struct kunit *test)
 	KUNIT_EXPECT_FALSE(test, dm_plane_color_pipeline_active(state, other_plane, false));
 }
 
+/* Tests for amdgpu_dm_crtc_get_cursor_mode() */
+
+/**
+ * dm_test_crtc_get_cursor_mode_new_hardware - Test new hardware always uses native mode
+ * @test: The KUnit test context
+ */
+static void dm_test_crtc_get_cursor_mode_new_hardware(struct kunit *test)
+{
+	struct amdgpu_device *adev = dm_kunit_alloc_adev(test);
+	struct dm_crtc_state *dm_crtc_state;
+	enum amdgpu_dm_cursor_mode cursor_mode = DM_CURSOR_OVERLAY_MODE;
+	int ret;
+
+	dm_crtc_state = kunit_kzalloc(test, sizeof(*dm_crtc_state), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, dm_crtc_state);
+	adev->ip_versions[DCE_HWIP][0] = IP_VERSION(4, 2, 0);
+
+	ret = amdgpu_dm_crtc_get_cursor_mode(adev, NULL, dm_crtc_state, &cursor_mode);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+	KUNIT_EXPECT_EQ(test, cursor_mode, DM_CURSOR_NATIVE_MODE);
+}
+
+/**
+ * dm_test_crtc_get_cursor_mode_no_change - Test unchanged atomic state preserves cursor mode
+ * @test: The KUnit test context
+ */
+static void dm_test_crtc_get_cursor_mode_no_change(struct kunit *test)
+{
+	struct amdgpu_device *adev = dm_kunit_alloc_adev(test);
+	struct drm_atomic_commit *state;
+	struct dm_crtc_state *dm_crtc_state;
+	enum amdgpu_dm_cursor_mode cursor_mode = DM_CURSOR_NATIVE_MODE;
+	int ret;
+
+	state = kunit_kzalloc(test, sizeof(*state), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, state);
+	dm_crtc_state = kunit_kzalloc(test, sizeof(*dm_crtc_state), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, dm_crtc_state);
+	state->dev = &adev->ddev;
+	dm_crtc_state->cursor_mode = DM_CURSOR_OVERLAY_MODE;
+
+	ret = amdgpu_dm_crtc_get_cursor_mode(adev, state, dm_crtc_state, &cursor_mode);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+	KUNIT_EXPECT_EQ(test, cursor_mode, DM_CURSOR_OVERLAY_MODE);
+}
+
+/**
+ * dm_test_crtc_get_cursor_mode_disabled_cursor - Test disabled cursor preserves mode
+ * @test: The KUnit test context
+ */
+static void dm_test_crtc_get_cursor_mode_disabled_cursor(struct kunit *test)
+{
+	struct dm_cursor_mode_fixture fixture = dm_test_alloc_cursor_mode_fixture(test);
+	enum amdgpu_dm_cursor_mode cursor_mode = DM_CURSOR_NATIVE_MODE;
+
+	fixture.cursor_state->crtc = NULL;
+	fixture.cursor_state->fb = NULL;
+
+	KUNIT_EXPECT_EQ(test, dm_test_get_cursor_mode(&fixture, &cursor_mode), 0);
+	KUNIT_EXPECT_EQ(test, cursor_mode, DM_CURSOR_NATIVE_MODE);
+}
+
+/**
+ * dm_test_crtc_get_cursor_mode_yuv_plane - Test YUV plane requires overlay cursor
+ * @test: The KUnit test context
+ */
+static void dm_test_crtc_get_cursor_mode_yuv_plane(struct kunit *test)
+{
+	struct dm_cursor_mode_fixture fixture = dm_test_alloc_cursor_mode_fixture(test);
+	enum amdgpu_dm_cursor_mode cursor_mode = DM_CURSOR_NATIVE_MODE;
+
+	fixture.primary_fb->format = drm_format_info(DRM_FORMAT_NV12);
+
+	KUNIT_EXPECT_EQ(test, dm_test_get_cursor_mode(&fixture, &cursor_mode), 0);
+	KUNIT_EXPECT_EQ(test, cursor_mode, DM_CURSOR_OVERLAY_MODE);
+}
+
+/**
+ * dm_test_crtc_get_cursor_mode_scale_mismatch - Test different scaling requires overlay
+ * @test: The KUnit test context
+ */
+static void dm_test_crtc_get_cursor_mode_scale_mismatch(struct kunit *test)
+{
+	struct dm_cursor_mode_fixture fixture = dm_test_alloc_cursor_mode_fixture(test);
+	enum amdgpu_dm_cursor_mode cursor_mode = DM_CURSOR_NATIVE_MODE;
+
+	fixture.old_primary_state->src_w = 960 << 16;
+	fixture.old_primary_state->src_h = 540 << 16;
+	fixture.primary_state->src_w = 960 << 16;
+	fixture.primary_state->src_h = 540 << 16;
+
+	KUNIT_EXPECT_EQ(test, dm_test_get_cursor_mode(&fixture, &cursor_mode), 0);
+	KUNIT_EXPECT_EQ(test, cursor_mode, DM_CURSOR_OVERLAY_MODE);
+}
+
+/**
+ * dm_test_crtc_get_cursor_mode_full_coverage - Test full RGB coverage uses native cursor
+ * @test: The KUnit test context
+ */
+static void dm_test_crtc_get_cursor_mode_full_coverage(struct kunit *test)
+{
+	struct dm_cursor_mode_fixture fixture = dm_test_alloc_cursor_mode_fixture(test);
+	enum amdgpu_dm_cursor_mode cursor_mode = DM_CURSOR_OVERLAY_MODE;
+
+	KUNIT_EXPECT_EQ(test, dm_test_get_cursor_mode(&fixture, &cursor_mode), 0);
+	KUNIT_EXPECT_EQ(test, cursor_mode, DM_CURSOR_NATIVE_MODE);
+}
+
+/**
+ * dm_test_crtc_get_cursor_mode_hole - Test incomplete plane coverage uses overlay cursor
+ * @test: The KUnit test context
+ */
+static void dm_test_crtc_get_cursor_mode_hole(struct kunit *test)
+{
+	struct dm_cursor_mode_fixture fixture = dm_test_alloc_cursor_mode_fixture(test);
+	enum amdgpu_dm_cursor_mode cursor_mode = DM_CURSOR_NATIVE_MODE;
+
+	fixture.old_primary_state->crtc_w = 1280;
+	fixture.primary_state->crtc_w = 1280;
+
+	KUNIT_EXPECT_EQ(test, dm_test_get_cursor_mode(&fixture, &cursor_mode), 0);
+	KUNIT_EXPECT_EQ(test, cursor_mode, DM_CURSOR_OVERLAY_MODE);
+}
+
+/**
+ * dm_test_crtc_get_cursor_mode_without_cursor - Test unrelated update avoids cursor state
+ * @test: The KUnit test context
+ */
+static void dm_test_crtc_get_cursor_mode_without_cursor(struct kunit *test)
+{
+	struct dm_cursor_mode_fixture fixture = dm_test_alloc_cursor_mode_fixture(test);
+	enum amdgpu_dm_cursor_mode cursor_mode = DM_CURSOR_NATIVE_MODE;
+
+	fixture.state->planes[0].ptr = NULL;
+	fixture.dm_crtc_state->base.plane_mask = drm_plane_mask(fixture.primary);
+
+	KUNIT_EXPECT_EQ(test, dm_test_get_cursor_mode(&fixture, &cursor_mode), 0);
+	KUNIT_EXPECT_EQ(test, cursor_mode, DM_CURSOR_NATIVE_MODE);
+}
+
+/**
+ * dm_test_crtc_get_cursor_mode_scale_changed - Test scale change triggers reevaluation
+ * @test: The KUnit test context
+ */
+static void dm_test_crtc_get_cursor_mode_scale_changed(struct kunit *test)
+{
+	struct dm_cursor_mode_fixture fixture = dm_test_alloc_cursor_mode_fixture(test);
+	enum amdgpu_dm_cursor_mode cursor_mode = DM_CURSOR_NATIVE_MODE;
+
+	fixture.primary_state->src_w = 960 << 16;
+	fixture.primary_state->src_h = 540 << 16;
+
+	KUNIT_EXPECT_EQ(test, dm_test_get_cursor_mode(&fixture, &cursor_mode), 0);
+	KUNIT_EXPECT_EQ(test, cursor_mode, DM_CURSOR_OVERLAY_MODE);
+}
+
+/**
+ * dm_test_crtc_get_cursor_mode_position_changed - Test destination move triggers reevaluation
+ * @test: The KUnit test context
+ */
+static void dm_test_crtc_get_cursor_mode_position_changed(struct kunit *test)
+{
+	struct dm_cursor_mode_fixture fixture = dm_test_alloc_cursor_mode_fixture(test);
+	enum amdgpu_dm_cursor_mode cursor_mode = DM_CURSOR_NATIVE_MODE;
+
+	fixture.primary_state->crtc_x = 1;
+
+	KUNIT_EXPECT_EQ(test, dm_test_get_cursor_mode(&fixture, &cursor_mode), 0);
+	KUNIT_EXPECT_EQ(test, cursor_mode, DM_CURSOR_OVERLAY_MODE);
+}
+
+/**
+ * dm_test_crtc_get_cursor_mode_color_pipeline - Test active color pipeline requires overlay
+ * @test: The KUnit test context
+ */
+static void dm_test_crtc_get_cursor_mode_color_pipeline(struct kunit *test)
+{
+	struct dm_cursor_mode_fixture fixture = dm_test_alloc_cursor_mode_fixture(test);
+	enum amdgpu_dm_cursor_mode cursor_mode = DM_CURSOR_NATIVE_MODE;
+
+	dm_test_add_cursor_mode_colorop(test, &fixture, true, false);
+
+	KUNIT_EXPECT_EQ(test, dm_test_get_cursor_mode(&fixture, &cursor_mode), 0);
+	KUNIT_EXPECT_EQ(test, cursor_mode, DM_CURSOR_OVERLAY_MODE);
+}
+
 /* Tests for amdgpu_dm_should_update_native_cursor() */
 
 /**
@@ -598,6 +922,18 @@ static struct kunit_case amdgpu_dm_cursor_tests[] = {
 	/* dm_plane_color_pipeline_active */
 	KUNIT_CASE(dm_test_plane_color_pipeline_active),
 	KUNIT_CASE(dm_test_plane_color_pipeline_ignores_other_plane),
+	/* amdgpu_dm_crtc_get_cursor_mode */
+	KUNIT_CASE(dm_test_crtc_get_cursor_mode_new_hardware),
+	KUNIT_CASE(dm_test_crtc_get_cursor_mode_no_change),
+	KUNIT_CASE(dm_test_crtc_get_cursor_mode_disabled_cursor),
+	KUNIT_CASE(dm_test_crtc_get_cursor_mode_yuv_plane),
+	KUNIT_CASE(dm_test_crtc_get_cursor_mode_scale_mismatch),
+	KUNIT_CASE(dm_test_crtc_get_cursor_mode_full_coverage),
+	KUNIT_CASE(dm_test_crtc_get_cursor_mode_hole),
+	KUNIT_CASE(dm_test_crtc_get_cursor_mode_without_cursor),
+	KUNIT_CASE(dm_test_crtc_get_cursor_mode_scale_changed),
+	KUNIT_CASE(dm_test_crtc_get_cursor_mode_position_changed),
+	KUNIT_CASE(dm_test_crtc_get_cursor_mode_color_pipeline),
 	/* amdgpu_dm_should_update_native_cursor */
 	KUNIT_CASE(dm_test_should_update_native_cursor_without_crtc),
 	KUNIT_CASE(dm_test_should_update_native_cursor_disable_native),
-- 
2.43.0

