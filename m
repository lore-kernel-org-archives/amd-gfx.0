Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19D6CC5DF97
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Aug 2026 23:28:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 872CB10EE57;
	Wed, 26 Aug 2026 23:28:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="F10t8WTz";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012051.outbound.protection.outlook.com [52.101.53.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B471210EE57
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Aug 2026 23:28:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XC0U0twNi1yQQl3hWW+enagJR0JpX930p/xF33SOkuhom4CrI6X0MiaG5lfJE9tqIzNqWDxmOoiCEtERdgoJj0chdqgpDe4khep4Nz85mr5enGk/dnXtez52cF6+3wtGQCw7cVfI6kSMeexXbeu6JcqP0V0U2kWLhhDAD6EoFR55+CX9ubZ5HPnWKgWQ87/fjlZJEJ/8tN1KrWseQUhtu3erNsCA//TdgziiCgmpAfAKo+/v8A+M63tJ/zH0id2Fcuf6p6z6kbQVRM57l1dyaJkiJeAUU/VzxhmUTeuq5Y3BXUC1kejI3uhqXneN2ihvzbQ0LL9XjFf33CqvzQqFqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tYKVr0+6pinpP0i/10DYmMs4zeb9nezLjagGR1GFBdI=;
 b=lquBE9aIqRtaB79H3zjNUI8DzvNYoRPjheDR1ovqrQIoQoeSxgaEa44K6MvUTvMxNQBDsYT2yUO6ZIlikLK6HMeJRg7iO0MQIlMILQoi0ADaAYAuztJ7+bPwLNjOm24yClIUN+d+VA2JafMRvrGYFIx58s8DHuOKhIK+lCJM1lZtiaPf1jh+iXXoFzTn8K4QuHoYfn9g0jojKcnl4KQKJPxAnT6hPSgqNXqgMfUYeeoy3IUIz6TL0Fem4UrP8vqq7gtpdV66jpzX5i5/2HcIMi1RvZ4dFUDYHJvf9GfiHgABblVRqwSmI1iP7HBCFVoogkdc2LQFfEdgZ/MGqKvyLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 149.199.90.133) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=quarantine sp=quarantine pct=100)
 action=quarantine header.from=amd.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tYKVr0+6pinpP0i/10DYmMs4zeb9nezLjagGR1GFBdI=;
 b=F10t8WTz0XNGopJ+eHcB2DjHYbPOqHY9Af5dDm4PKo/hRKV4FdmQUpelandEBPW6kaKcgGIwzLcYkRqHkv/dtFoF1PhDaTM4Rzt/3Af2Fm6ncyLZqeJCT0kzftHv4qSvjH/DymY9J2Evh1G+udL7/UETBTdKUv7MZdnP1Dh5Lus=
Received: from SN7PR18CA0011.namprd18.prod.outlook.com (2603:10b6:806:f3::19)
 by DS0PR12MB8454.namprd12.prod.outlook.com (2603:10b6:8:15e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.8; Wed, 26 Aug
 2026 23:28:32 +0000
Received: from SN1PEPF000397AF.namprd05.prod.outlook.com
 (2603:10b6:806:f3:cafe::48) by SN7PR18CA0011.outlook.office365.com
 (2603:10b6:806:f3::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.8 via Frontend Transport; Wed, 26
 Aug 2026 23:28:32 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 149.199.90.133) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 149.199.90.133 as permitted sender)
Received: from satlexmb07.amd.com (149.199.90.133) by
 SN1PEPF000397AF.mail.protection.outlook.com (10.167.248.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Wed, 26 Aug 2026 23:28:32 +0000
Received: from localhost.localdomain (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 26 Aug
 2026 18:28:27 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Subject: [PATCH 38/59] drm/amd/display: Test link and sink dump
Date: Wed, 26 Aug 2026 17:05:09 -0600
Message-ID: <20260826231519.881949-39-alex.hung@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397AF:EE_|DS0PR12MB8454:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e7dbc90-e801-4cd6-16dc-08df03c9be26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700016|23010399003|6133799003|56012099006|10067099003|5023799004|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 6UzS8Z2A5ZAQINHZlkPD1lpj2T9YkdMRxtTNTjHU6N6PJFBDs+A8fFvnGNMB9uL55iwdhZ6AGB3j+qKHCUpSDIM1I6vK0D3Xldtqpksl1Ac1Uyg9Cn+IZjCULKovJAKDSGDeFxQ2QIvAx+A/1gYp8F5wDUnMMygKY8Iwk6TpaZpwE+e9YhwFiP1tuP3JMllFl4AOXRZgeVeCGHRY0y2u17nLAvzvwBKHVWjJXerrOPLCU+GWEnN1GO7YW9igFNpcDm2+TPOWJgqJ8WORBqvfi61lBt1x6pIsZ2hsNYiNelaKwWDZMbd2Lu9rApdM5bIvqN/94S0L8TTILLpshh6c3ibQvPTShXzrGlc77zeBWAQEe4VOoXkP/pF7H28qWRTTqizQz8l8pIFz7121mCenop+UHzTZzpf3dVYXixGI2OIjyuceaL4T7HHJXTNgaqAjWd9gzjbULdwKwvchG/7OeiDLPOkRxJwkLBPY69PeL8x97XYvWUAIpJoDL1fb/XQkrV+vY11wVE4TwHVkXjlpw+3FC7XvGLQ4CKfaGR3QnEnESL3CJEwy2wiOEpHGS595y+F6P+vBoUq0+82QNVUeou5COUYyb0qOWNEbkj2CgpmGvdqWR2y6YqCOMbqdLxqq2hGHGvtM2/MsyVpmjPZTQ8HROLR8H5JKBiohDw/BO/YyH9ghh7ZVAKplROEmlOZHBS723e6Aqr/tHwh3Z7GPcQ==
X-Forefront-Antispam-Report: CIP:149.199.90.133; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:unknown-90-133.xilinx.com;
 CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700016)(23010399003)(6133799003)(56012099006)(10067099003)(5023799004)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 2pe5NK7yel3c8aweMn0DgB02oQcqyzwDXkpqNTjuCNjQOj+mVrXCFudzP1e4+rWsAW5NK0BqHGKsS4wrfZh9UahHhlchywJktpmgCGOIqrjKrfeAFAUdRL2nqc9T1uioCJSmAWkCVd2c2koIHTmkvtegVn5o+/l92fMG1jG5nHQylLcfc7q3vNb2+bLu5s0a7OleJmXGzJPNPpNnPgH2bZ2D/+SuIrSMCqyP/VSxuEbHFgGddA3TqOR/SSKH/+ZakUOZowD968d/bJcsXJBLaRqy844u+h/QSKJuRweiRfoboblRwg2Yj1RkFaS2erzNMMkQI9P8D4GhZgcKlQg/f+Oi73nR5j7k3M4iQr/2u54a3U9ekvmmMOM/cODz/IxfGyKQAYfqZwipfp+yoic2LechPySZsHtqq3RuPj10IVzsiL/YxbQs+gY6agSLWm4G
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2026 23:28:32.2159 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e7dbc90-e801-4cd6-16dc-08df03c9be26
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[149.199.90.133];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397AF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8454
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
Add KUnit tests for amdgpu_dm_dump_links_and_sinks() covering a device
without DC, a DC without links, named local and remote sinks, and missing
or unnamed sinks.

[HOW]
Build lightweight DC link and sink objects so the dump walks each naming
and skip path without display hardware.

Assisted-by: Copilot:Claude-Opus-5 GPT-5.6-Sol
Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  3 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  1 +
 .../display/amdgpu_dm/tests/amdgpu_dm_test.c  | 92 +++++++++++++++++++
 3 files changed, 95 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 8db18d7cf49f..fc03fcca4c6a 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1776,7 +1776,7 @@ EXPORT_IF_KUNIT(amdgpu_dm_apply_delay_after_dpcd_poweroff);
  * (MST) sinks. Should be called after connector detection is complete to see
  * the final state of all links.
  */
-static void amdgpu_dm_dump_links_and_sinks(struct amdgpu_device *adev)
+STATIC_IFN_KUNIT void amdgpu_dm_dump_links_and_sinks(struct amdgpu_device *adev)
 {
 	struct dc *dc = adev->dm.dc;
 	struct drm_device *dev = adev_to_drm(adev);
@@ -1828,6 +1828,7 @@ static void amdgpu_dm_dump_links_and_sinks(struct amdgpu_device *adev)
 		}
 	}
 }
+EXPORT_IF_KUNIT(amdgpu_dm_dump_links_and_sinks);
 
 static int dm_resume(struct amdgpu_ip_block *ip_block)
 {
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index 0151913336b7..7cb22915d18b 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -1201,6 +1201,7 @@ int add_affected_mst_dsc_crtcs(struct drm_atomic_commit *state,
 bool amdgpu_dm_crtc_mem_type_changed(struct drm_device *dev,
 				     struct drm_atomic_commit *state,
 				     struct drm_crtc_state *crtc_state);
+void amdgpu_dm_dump_links_and_sinks(struct amdgpu_device *adev);
 int dm_plane_layer_index_cmp(const void *a, const void *b);
 int fill_plane_color_attributes(const struct drm_plane_state *plane_state,
 				const enum surface_pixel_format format,
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c
index 799cd3867a77..63d43f917273 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c
@@ -2759,6 +2759,93 @@ static void dm_test_reset_plane_other_modifier(struct kunit *test)
 	KUNIT_EXPECT_TRUE(test, dm_test_should_reset_plane(ctx));
 }
 
+/* Tests for amdgpu_dm_dump_links_and_sinks() */
+
+/**
+ * dm_test_dump_links_no_dc - Test a device without DC dumps nothing
+ * @test: The KUnit test context
+ */
+static void dm_test_dump_links_no_dc(struct kunit *test)
+{
+	struct amdgpu_device *adev = dm_kunit_alloc_adev(test);
+
+	amdgpu_dm_dump_links_and_sinks(adev);
+}
+
+/**
+ * dm_test_dump_links_no_links - Test a DC without links dumps nothing
+ * @test: The KUnit test context
+ */
+static void dm_test_dump_links_no_links(struct kunit *test)
+{
+	struct amdgpu_device *adev = dm_kunit_alloc_adev(test);
+
+	adev->dm.dc = dm_kunit_alloc_dc_with_ctx(test);
+
+	amdgpu_dm_dump_links_and_sinks(adev);
+}
+
+/*
+ * Attach a single DC link to @adev so amdgpu_dm_dump_links_and_sinks() walks it.
+ */
+static struct dc_link *dm_test_dc_with_link(struct kunit *test,
+					   struct amdgpu_device *adev)
+{
+	struct dc *dc = dm_kunit_alloc_dc_with_ctx(test);
+	struct dc_link *link = dm_kunit_alloc_link(test);
+
+	dc->links[0] = link;
+	dc->link_count = 1;
+	adev->dm.dc = dc;
+
+	return link;
+}
+
+/**
+ * dm_test_dump_links_with_sinks - Test local and remote sinks are walked
+ * @test: The KUnit test context
+ */
+static void dm_test_dump_links_with_sinks(struct kunit *test)
+{
+	struct amdgpu_device *adev = dm_kunit_alloc_adev(test);
+	struct dc_link *link = dm_test_dc_with_link(test, adev);
+	struct dc_sink *local_sink, *remote_sink;
+
+	local_sink = kunit_kzalloc(test, sizeof(*local_sink), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, local_sink);
+	remote_sink = kunit_kzalloc(test, sizeof(*remote_sink), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, remote_sink);
+
+	strscpy(local_sink->edid_caps.display_name, "local");
+	strscpy(remote_sink->edid_caps.display_name, "remote");
+	link->local_sink = local_sink;
+	link->sink_count = 1;
+	link->remote_sinks[0] = remote_sink;
+	adev->dm.dc->link_count = 2;
+
+	amdgpu_dm_dump_links_and_sinks(adev);
+}
+
+/**
+ * dm_test_dump_links_unnamed_sinks - Test links without a sink or EDID name
+ * @test: The KUnit test context
+ */
+static void dm_test_dump_links_unnamed_sinks(struct kunit *test)
+{
+	struct amdgpu_device *adev = dm_kunit_alloc_adev(test);
+	struct dc_link *link = dm_test_dc_with_link(test, adev);
+	struct dc_sink *remote_sink;
+
+	remote_sink = kunit_kzalloc(test, sizeof(*remote_sink), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, remote_sink);
+
+	link->sink_count = 2;
+	link->remote_sinks[0] = NULL;
+	link->remote_sinks[1] = remote_sink;
+
+	amdgpu_dm_dump_links_and_sinks(adev);
+}
+
 static struct kunit_case amdgpu_dm_tests[] = {
 	/* Simple DM callbacks */
 	KUNIT_CASE(dm_test_wait_for_idle),
@@ -2896,6 +2983,11 @@ static struct kunit_case amdgpu_dm_tests[] = {
 	KUNIT_CASE(dm_test_reset_plane_other_no_fb),
 	KUNIT_CASE(dm_test_reset_plane_other_format),
 	KUNIT_CASE(dm_test_reset_plane_other_modifier),
+	/* amdgpu_dm_dump_links_and_sinks */
+	KUNIT_CASE(dm_test_dump_links_no_dc),
+	KUNIT_CASE(dm_test_dump_links_no_links),
+	KUNIT_CASE(dm_test_dump_links_with_sinks),
+	KUNIT_CASE(dm_test_dump_links_unnamed_sinks),
 	{}
 };
 
-- 
2.43.0

