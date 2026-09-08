Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58C5EC79FA1
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Sep 2026 11:36:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E2FA910EAF8;
	Tue,  8 Sep 2026 11:35:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gW6EoM4k";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010006.outbound.protection.outlook.com [52.101.56.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 69B8B10EAF8
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Sep 2026 11:35:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PHGClKfRMphlWze4BSH1o+S1OjO/CHC6l68vp/DqDJm19Aty+PHsQXlnE5Z0L6N5HQIToChXH6Kb5KYecj8GLQfaJqZ4ElYJ2Em40MDSMfiX8IYzjLhO1/m7wL+Q+WdyHl8iA1Yua90EI+/VojGdqQSfsBJZATecEJqLLG7LgNzWkA6vhPc9hkaBG7WKDudYh73S0lAAx8Egay1xZVJpHRa8wjddVs0QQgr6FLywDPGcAesXyUU+DkbnfTmtL4JePA2BGBPnGbzJ6+rvh2ueWmwTb6e5HivJUp2313aEbH7qUG1CpX/8Wc0XZUcXNxUPmU6NLZx24EeT4Gs14cpETA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=42PnEmWYuhEhJDUmeIoVWxrWHJse3nlU+X29Bjv+Q3g=;
 b=XdEqcMsViG4UdYvVWc+kgSTVAwGg7xLDD2bZE6Dq7g9GQks7VwtmwY+58SRoDPHWfkDr/WVlKW8Bvgtj8tkgPfwnKJDxmfRcyojLhcOjlCJTarkfuBRQ3INpui91sIGw+7ChWV740Rph0bVvaLaMpWpRz41SDlVJhGQk7MOS7eRy14aeKMiNeNqzR3IhhkHup+1yefS59LzZjofzqScLPtHbYYkHmFPP1JQIJAOzQErmuB116k03DK1X2QQcM9zOYEQhMfqB4dpG7xjwgc+MHBXWLB2HyB4kTTBDb8gI8M3k7aI/K0n71kEEgfd6ZDLyTay+9XxvS2yYCPHct+m4Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=42PnEmWYuhEhJDUmeIoVWxrWHJse3nlU+X29Bjv+Q3g=;
 b=gW6EoM4kbafjXpDRWiacAQ0kSXXVlpVTtLp0PSltvT2441dtY1iXja9K9lwfyibktbaJfNOvZFzuk3OIjDE5qJzZVsq9dZM5C/Klsw0MX1P26J05wa8DKTyVeZU+bQKubZnnmTwo3y4nnHfOwN8PL8sthCL2/Ywf+TNdm2ZKQ70=
Received: from BL1PR13CA0426.namprd13.prod.outlook.com (2603:10b6:208:2c3::11)
 by CY5PR12MB6576.namprd12.prod.outlook.com (2603:10b6:930:40::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Tue, 8 Sep 2026
 11:35:52 +0000
Received: from BN2PEPF0000A894.namprd04.prod.outlook.com
 (2603:10b6:208:2c3:cafe::27) by BL1PR13CA0426.outlook.office365.com
 (2603:10b6:208:2c3::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.7 via Frontend Transport; Tue, 8
 Sep 2026 11:35:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF0000A894.mail.protection.outlook.com (10.167.248.186) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Tue, 8 Sep 2026 11:35:51 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 8 Sep
 2026 06:35:50 -0500
Received: from chenyu-station.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Tue, 8 Sep 2026 06:35:42 -0500
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
Subject: [PATCH 14/66] drm/amd/display: Test accepted plane atomic check
Date: Tue, 8 Sep 2026 19:31:07 +0800
Message-ID: <20260908113338.2433445-15-chen-yu.chen@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260908113338.2433445-1-chen-yu.chen@amd.com>
References: <20260908113338.2433445-1-chen-yu.chen@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A894:EE_|CY5PR12MB6576:EE_
X-MS-Office365-Filtering-Correlation-Id: 5cda71df-b146-495d-2dfc-08df0d9d55f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700016|23010399003|1800799024|6133799003|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 0y1H0GJ5tsfw6fVdHZpR1ypzKVYhWJytELiIcGirFPeZsUrl5oroGwyGSb0L7kMTwagyEWVInSCYWPtw6diB2kueZsLm6CJhAPJBm95Yv4IZ/XrNdOytIfbq9ZTNNSyrTDB1eaLEt3gdKRFsAnTtnyUmmwZk9P433CO3fZYETuVQYXYDYthemOwuvbX5+SloF+uLD/b94WcWOVIuTfi69LD34P6K5Xl/jVxiaDjEOCQIjkfvEbhTGp3NPhNljRMmrXGRtvQPznQMnnG0BcYtdtXYImtm58CDUX/3Hz+vqCcjzsZJMYHAvhXxUYX0DbYAEM3m74+u71MmL6+934oIi1THEEdR2o61Cxrbb/QLnNnOttn1DgXA/GInsKKQOOPXjmJCcLnxhGIM5N/5fRq1KS/ixHeU9jcXTxCkYX8OoVj7+u5gXVZvLzKTXQpFnT43CTUF65OlkCYUqPWw/UfYMV6qRGUPrmCiyPZVYQ+H1W8p2JBBXJlZn9VnAaXRDZD5//ccFmOGUV0Em9sOOrylT3ANVS+I/+31dRbfsrFcAXkXa/ykEZFBXI58g0QygMY+0M56s10gtaVkz+f4q3pjdaN2zGTrWd0dPAAxigDiCf7YTUBRyflenbS6TqWfNS9NXVLExQp8PbylYn9oVNQDYwRgpYPNMj9kxSjecsuFwBJ/UatMzgevVM7CcOu32LN8f4/oaRv48h1ehd1xWXORJA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700016)(23010399003)(1800799024)(6133799003)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 1HoK9AHu4O8YC+BEuMQSX/hgV9VEsq6SYRuLi+J13IVriaTzP4hei7OP+QhQ2cbSQCJlE5V4skQyoRuFSjsYdCTEoPftbBZUTfQDNpHuSK8atbCkQfkhqzIeNsdm156kzYfGahROXwax9I7eGbIzefyq8xtyx5RRebN4Rcnk6aLvLtEQOaLOdq6ilXbKKJ7J+6ykXmz7gNlHqye5uLY6DIIJQkiJq+ieHsXQCwg66De/RT56f9mnmEJv9oVc1uBgVkiatHDuUxlC1D86tjU+qutHwci2bWvlcphu/kmd4v2nZCQDO9ggPXtXzh/Y81RBrRXCb3zyqUzVrLFQmJFqjrH4Ag5f7swTY1+Qj+onI70d3d+hGrUFqLRWcJYumVeYlsFrg8PiON91R283/qXTW0AkvB96xCcNCTBuJuh3RtC98SqtwQ/xl0Ncp6adUcLS
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 11:35:51.2399 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cda71df-b146-495d-2dfc-08df0d9d55f1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000A894.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6576
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
Add a KUnit test for amdgpu_dm_plane_atomic_check() covering the
success path taken once DC validation accepts the plane.

[HOW]
Extend the shared atomic-check fixture with a resource pool that has
no validate_plane callback, so dc_validate_plane() only inspects the
source and destination rectangles.

Assisted-by: Copilot:Claude-Opus-5
Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Chenyu Chen <chen-yu.chen@amd.com>
---
 .../amdgpu_dm/tests/amdgpu_dm_plane_test.c    | 36 +++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_plane_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_plane_test.c
index 9680c3fa8bc7..90737090c61c 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_plane_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_plane_test.c
@@ -3754,6 +3754,41 @@ static void dm_test_fill_plane_buffer_attributes_gfx6(struct kunit *test)
 						     &plane_size, &dcc, &address), -EINVAL);
 }
 
+/**
+ * dm_test_atomic_check_success() - Verify a fully valid plane state is accepted.
+ * @test: KUnit test context.
+ *
+ * Verify if atomic_check reports success once DC validation accepts the plane.
+ * The resource pool exposes no validate_plane callback, so DC falls back to
+ * checking the source and destination rectangles only.
+ */
+static void dm_test_atomic_check_success(struct kunit *test)
+{
+	struct dm_plane_state *dm_plane_state;
+	struct drm_crtc_state *new_crtc_state;
+	struct drm_atomic_commit *state;
+	struct resource_pool *res_pool;
+	struct amdgpu_device *adev;
+	struct drm_framebuffer *fb;
+	struct drm_plane *plane;
+
+	adev = dm_test_init_atomic_check_state(test, &state, &plane, &dm_plane_state,
+					       &new_crtc_state, &fb);
+	res_pool = kunit_kzalloc(test, sizeof(*res_pool), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, res_pool);
+	res_pool->funcs = kunit_kzalloc(test, sizeof(*res_pool->funcs), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, res_pool->funcs);
+
+	adev->dm.dc->res_pool = res_pool;
+
+	dm_plane_state->dc_state->src_rect.width = 100;
+	dm_plane_state->dc_state->src_rect.height = 100;
+	dm_plane_state->dc_state->dst_rect.width = 100;
+	dm_plane_state->dc_state->dst_rect.height = 100;
+
+	KUNIT_EXPECT_EQ(test, amdgpu_dm_plane_atomic_check(plane, state), 0);
+}
+
 static struct kunit_case amdgpu_dm_plane_test_cases[] = {
 	/* amdgpu_dm_plane_is_video_format() */
 	KUNIT_CASE(dm_test_plane_is_video_format_known_video),
@@ -3837,6 +3872,7 @@ static struct kunit_case amdgpu_dm_plane_test_cases[] = {
 	KUNIT_CASE(dm_test_atomic_check_helper_failure),
 	KUNIT_CASE(dm_test_atomic_check_color_pipeline_conflict),
 	KUNIT_CASE(dm_test_atomic_check_scaling_failure),
+	KUNIT_CASE(dm_test_atomic_check_success),
 	/* amdgpu_dm_plane_panic_flush() */
 	KUNIT_CASE(dm_test_panic_flush_no_dc_state),
 	/* amdgpu_dm_plane_drm_plane_reset() */
-- 
2.43.0

