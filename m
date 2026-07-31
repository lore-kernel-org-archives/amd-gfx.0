Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18D81C55172
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jul 2026 21:16:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C9D810F413;
	Fri, 31 Jul 2026 21:16:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RCAo4K7x";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012024.outbound.protection.outlook.com [40.107.209.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE3B710F3E9
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Jul 2026 21:15:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g/oyjQlhYi20NdDhWCpfrwjCuFsOewb73JzMSLNfNBumDdWYgx7rRmwUn7qGQzbqpFVNIEuG9q7KzTorVT6xAxBq/3lCKzZrU80FDCrWO0zK9msMmdsQrzaVma4Z1SVFEPX7+5AjefBVrEzqz8C+T56bqjqA89Axzd8Fvi4vz+KDm5uO6CpeqUA73+z+PCgUYl5Lx9QNJ1rA3Sim/6HNzTG79tNTC+8jJndfajQONqIzLfVUnynUsBe+XAbmMzxXioeykdbtBGvYAuoW8IoTWQVidDnan1OCOZ6rE2S0P1FjrwAsKlY9UYmr3HePS71MYdc1Q42MOdDdNKhP5U7umg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zyuZU6XP3U8hYA7LHB+V2TQB5EFQYmOvks7RlWHQWn4=;
 b=GqCnulV+BzN+2Vg3t4v9CXNpBum9b3A+n4nYinO8Zlv+njhREXwouzHsrCIo/1t+WmdDKHzMkubvaYu48IEC3hBA9I0BAzGlRlY4IRcJ6tKFGRZbPbCwlWWXCxbMN7erV2cxd7TnP1hFz3xn5gnAEE+jBl7zzH9NL4Zz6vM5M9zbqFHeMZWJ8L5TqfJWg3w55L+NZbGY/o7x2J779uOvvUEcRvCXhLliRgstLhScUG4mGYrzhpFMdbmslpZ967dl2Mlja7DgUKfbvaHvHB6hSN7G1yytV0oqkti21eqJ2ASgywXBYD9qTZ9VuTsoBs7pcmc9VhuoEN9F55XZVYwaTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zyuZU6XP3U8hYA7LHB+V2TQB5EFQYmOvks7RlWHQWn4=;
 b=RCAo4K7xC4PBoZo7cn2EPMYjvrbpf+juXJXrv76Jxah64nlf2LSh8MzJferqpfGCt9wRwmVDqs+uAvIvOTwGJCHaSWwm1gfIdgVU+Z3rqWwQVZXYKS2c3CNxswSIM7Y/GT11ObrpI5VAqxXGWTN/q55PeXWLCsk5xsy7pf0m/Qs=
Received: from CH0PR07CA0012.namprd07.prod.outlook.com (2603:10b6:610:32::17)
 by SA3PR12MB9180.namprd12.prod.outlook.com (2603:10b6:806:39b::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Fri, 31 Jul
 2026 21:15:53 +0000
Received: from CH2PEPF00000140.namprd02.prod.outlook.com
 (2603:10b6:610:32:cafe::3b) by CH0PR07CA0012.outlook.office365.com
 (2603:10b6:610:32::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.15 via Frontend Transport; Fri,
 31 Jul 2026 21:15:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH2PEPF00000140.mail.protection.outlook.com (10.167.244.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Fri, 31 Jul 2026 21:15:52 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 31 Jul
 2026 16:15:48 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 31 Jul
 2026 16:15:48 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Fri, 31 Jul 2026 16:15:47 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Subject: [PATCH 20/41] drm/amd/display: Add KUnit tests for crtc
 set_static_screen_optimze
Date: Fri, 31 Jul 2026 17:12:41 -0400
Message-ID: <20260731211302.3040343-21-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260731211302.3040343-1-Roman.Li@amd.com>
References: <20260731211302.3040343-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000140:EE_|SA3PR12MB9180:EE_
X-MS-Office365-Filtering-Correlation-Id: ffeb0436-fa8c-4fb8-c78c-08deef48e6dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|82310400026|36860700016|11063799006|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: SmUceVd/LKunEO5CuVA3vog5kZUCDzxyDyVKZysXGtPv4CHe50E4ziQ9NkKyYnTh0nXmFM+PIG/foaHsrdj9fHJWH9Nu9bP/QIR22gmKBorFeGESS3oRPRD1GTQDkkHbSTFbu2Oq5AWlnVBkW8LLxrcIBgJEVLKzqFZZCWU0IEO0sXS5ARYiKwnvfENK2m6M6ffE9KinD/l6fkrl/iG7MnT/RTZlDq6xaAkYNiBBAmCaz6T7uy8PEjXGNjgwoZeKAz/crCnyFfqeLp5Y5Yr0suF2LSPrCObYW892i81hzgidwO4gVlLoUAZfJ5DUGmDqNp6LtepEaQKaS39aGLyfzSCG55lcZfyb5svGbjmVULAJOs3YdFdnODn9FIGa14TVJQEBrp63GnX1QgmVIzDh+u1KTUplbaKMM5EZ2LWS20Tj8RYRk1yuxJg/ej2ymfL9IrHGaXfnk2OogeoX8COYuKfSOS9LYjrzhFPrF+00em1tWeUzIorRhlcIVXdDdSbLbRlqFPugm1ec1PkbGAZ5vHCcOTdIKmNj6VaWLoazfE7OveLCTs+gFlb1SwrIGNREIx/T/qmQmAQfOIkQSP9OV6veY93osgpuDCxnsxzA3M4sYmI9Ebo49ns5+h3vTFY9flNCoL3rTprIoOn/S7zvMnESL8MvDZQW6Lh5Iw0QbkPJvl2+cSK2Nw01uvnOdA/EjDfh07W6CCKiQOsntZke/A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(82310400026)(36860700016)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: TMhSyHGdFaa88qYotz9OrE5EjA3qFxb6HUAm6i0S5yDwdMiLBOQJlpR+B/8CyA82auJMKCO8J0icKsnrTdW2oA7JALaV7nXVzs1XQW0Fy6xwnTH0zmJuYHcW/XH261yIBpJBxmY2+23IwbBNrekI9RhKV+wkgpdvdNuMJXSsQB+C6qJn2W3lqQMXRlARRyvlt3ZddSvp+DlljPK+1jgTFQMwUnLX3fLzFWltx8BDIu3d05vnDPNfzlRrA364ckZ7gE4LmHZHCeK39auHa6ZuyDLEb0u0qIs198jk8ef8LrH3en/kC+L+E0f2mSDkl8SrFSQEBsWI9U0xSW/s8iVfPzo3OLnlqLuP3gKDzVNtdJzAJ2Zzbs9wO+5pV3Uh/DhHRgXuUruLqPeMUJNyE/UTG4hS55wAKPYNJCGI+kppsBomPNApOIErKhsuoa0e+7zX
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2026 21:15:52.2553 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ffeb0436-fa8c-4fb8-c78c-08deef48e6dc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000140.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9180
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

Add dm_test_crtc_set_static_screen_optimze_sr_entry_psr and
dm_test_crtc_set_static_screen_optimze_psr_su_skips to cover the
allow_sr_entry == true path of amdgpu_dm_crtc_set_static_screen_optimze():
the replay/PSR event updates when psr_version < DC_PSR_VERSION_SU_1, and
skipping the PSR event update when psr_version is DC_PSR_VERSION_SU_1.

Assisted-by: Copilot:Claude-Opus-4.8
Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
---
 .../amdgpu_dm/tests/amdgpu_dm_crtc_test.c     | 55 +++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_crtc_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_crtc_test.c
index db98e42c561b..fa4986153eda 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_crtc_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_crtc_test.c
@@ -756,6 +756,59 @@ static void dm_test_crtc_set_static_screen_optimze_no_sr_entry(struct kunit *tes
 	amdgpu_dm_crtc_set_static_screen_optimze(dm, stream, false, false);
 }
 
+/**
+ * dm_test_crtc_set_static_screen_optimze_sr_entry_psr - Test SSO toggle drives PSR
+ * @test: The KUnit test context
+ *
+ * With self-refresh entry allowed and a PSR version below DC_PSR_VERSION_SU_1,
+ * the function must run both the replay and PSR event updates. The link has no
+ * replay/PSR feature enabled, so both event helpers short-circuit safely. Both
+ * SSO states are exercised to cover the set_vsync_event computation.
+ */
+static void dm_test_crtc_set_static_screen_optimze_sr_entry_psr(struct kunit *test)
+{
+	struct amdgpu_display_manager *dm;
+	struct dc_link *link;
+	struct dc_stream_state *stream;
+
+	dm = kunit_kzalloc(test, sizeof(*dm), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dm);
+
+	link = dm_kunit_alloc_link(test);
+	stream = dm_kunit_alloc_stream(test, link);
+
+	/* psr_version < DC_PSR_VERSION_SU_1 -> PSR event branch is taken. */
+	link->psr_settings.psr_version = DC_PSR_VERSION_1;
+
+	amdgpu_dm_crtc_set_static_screen_optimze(dm, stream, true, true);
+	amdgpu_dm_crtc_set_static_screen_optimze(dm, stream, false, true);
+}
+
+/**
+ * dm_test_crtc_set_static_screen_optimze_psr_su_skips - Test PSR SU skips PSR event
+ * @test: The KUnit test context
+ *
+ * With self-refresh entry allowed and a PSR version of DC_PSR_VERSION_SU_1, the
+ * function must update the replay event but skip the PSR event update.
+ */
+static void dm_test_crtc_set_static_screen_optimze_psr_su_skips(struct kunit *test)
+{
+	struct amdgpu_display_manager *dm;
+	struct dc_link *link;
+	struct dc_stream_state *stream;
+
+	dm = kunit_kzalloc(test, sizeof(*dm), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dm);
+
+	link = dm_kunit_alloc_link(test);
+	stream = dm_kunit_alloc_stream(test, link);
+
+	/* psr_version >= DC_PSR_VERSION_SU_1 -> PSR event branch is skipped. */
+	link->psr_settings.psr_version = DC_PSR_VERSION_SU_1;
+
+	amdgpu_dm_crtc_set_static_screen_optimze(dm, stream, true, true);
+}
+
 /* Tests for amdgpu_dm_crtc_enable_vblank() */
 
 /**
@@ -1295,6 +1348,8 @@ static struct kunit_case amdgpu_dm_crtc_tests[] = {
 	KUNIT_CASE(dm_test_idle_worker_enabled_runs_body),
 	/* amdgpu_dm_crtc_set_static_screen_optimze */
 	KUNIT_CASE(dm_test_crtc_set_static_screen_optimze_no_sr_entry),
+	KUNIT_CASE(dm_test_crtc_set_static_screen_optimze_sr_entry_psr),
+	KUNIT_CASE(dm_test_crtc_set_static_screen_optimze_psr_su_skips),
 	/* amdgpu_dm_crtc_enable_vblank */
 	KUNIT_CASE(dm_test_crtc_enable_vblank_rejects_unconfigured),
 	/* amdgpu_dm_crtc_update_crtc_active_planes */
-- 
2.34.1

