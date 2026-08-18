Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A7A1C5DF8D
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Aug 2026 20:23:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8598010ECDB;
	Tue, 18 Aug 2026 20:23:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3LpnQimB";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010035.outbound.protection.outlook.com
 [52.101.193.35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DED1910EC99
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Aug 2026 20:22:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u6djzUPd8+7YQ/hVtApI61KP1xqxX3FcxvlcH2BRUD1/sSJsg4TdRV7IJc9JxrnKoWl1fjHXe5JtvoDXcl+AFGIR6k02id7c0SK7OBKaRhZ8VoCQ6L5TNEwu1RkCiZ/fTZXwJIHOrfSGwCfeE4l9GgYyL7cVyEHbP3rJJzrmZ6LWUgrTIL4hcg1WRS/cz48aMQ8tOSMXt92po/b/nIsBbh139s7NR9+KsYzbC84+28afL5MEwFC1cKRN41GDf19ip4Za0L/M35+RqYP8n9566o9LL1smJtyVuDSehk75avfQvdOdFjpxlacyUWJ1j3FxKf2dFPRPR9NaBLQYzcye8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d1/wU3aOMTIY1Q8ClF6jaIczlls4dDMT/LfSe2fPsJY=;
 b=ndZWsxfgO2j5+CBRs0V+1MElUZMLJRhfJSfZEUdmag2I2FhwYHS8nVELSMoJme6wmUl6n+JBXsZ1pjAsO/7FyZQccz/WWCTnGLd93DQB03ctYrVQTTl/RzXXDaAvO4FYpESJVC/gqF9box9Zsg5kHs92NpPZSNWsEzO1LNm2Z50mLSDJIqq7aTolVPrfkurqEbHpc9jdA7b1pNuZVRndRMUAmE5uiRAvwKZI8THKNeerAgYAer8Khm66ChVPqQ0dp1V9Z7/h0BQQp9VQEpnwqakTMSHVOVVOSxTMMobr7EOoA19l4LhfGuUsRIxB4JbzfjhFniPjY6JS+9zRriKQhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d1/wU3aOMTIY1Q8ClF6jaIczlls4dDMT/LfSe2fPsJY=;
 b=3LpnQimBcVs+99HB+gE/vqfKJlhrH9raMVfrVpdYunGdrBUEKeKvpPkpMeRKmkdYNhg/OR0jeg4DgGLk4apo6UP9vTaacX4TDtyPnBYPS6cHGvzDN+97QBv7t3/OcdPCPP3ZymrtohSHLy/KS749gZKFvRTrVwNmT0mlP8oUH+o=
Received: from BL1P221CA0010.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:2c5::14)
 by MW6PR12MB8757.namprd12.prod.outlook.com (2603:10b6:303:239::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Tue, 18 Aug
 2026 20:22:49 +0000
Received: from BN3PEPF0000B36F.namprd21.prod.outlook.com
 (2603:10b6:208:2c5:cafe::73) by BL1P221CA0010.outlook.office365.com
 (2603:10b6:208:2c5::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.8 via Frontend Transport; Tue, 18
 Aug 2026 20:22:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B36F.mail.protection.outlook.com (10.167.243.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.0 via Frontend Transport; Tue, 18 Aug 2026 20:22:49 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 18 Aug
 2026 15:22:47 -0500
Received: from box-0.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Tue, 18 Aug 2026 15:22:47 -0500
From: <IVAN.LIPSKI@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Subject: [PATCH 72/82] drm/amd/display: Cover add_fs_modes mode generation
Date: Tue, 18 Aug 2026 16:16:04 -0400
Message-ID: <20260818202139.4172592-73-IVAN.LIPSKI@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818202139.4172592-1-IVAN.LIPSKI@amd.com>
References: <20260818202139.4172592-1-IVAN.LIPSKI@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B36F:EE_|MW6PR12MB8757:EE_
X-MS-Office365-Filtering-Correlation-Id: 01bdd89c-78a7-42fc-5858-08defd667932
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|376014|82310400026|23010399003|10067099003|56012099006|18002099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info: npOTLgJzRxynsh74NL1zTch7EDj4Od8I/6LNLBnXrh1KVZ/x3vRoqVuIJNVJ/m/XqBlhOBllQXmO9oez01V4e/exsNP/vAojmBk2mrVMUYeF3Zs1Ne0HMkiwj3CnSOPdPgPvKO1pmI4bysPtsqExcBerKxj4DfaCf+MwpoGp3tWr2eEeJjvyt/3sysaGPbgNdt90NLfsS8KRT4tMAvKWW9Z3jdWuTK2ZS3PECWwba21Ez8rNg2DiQR+41EjV0dPv+AXPHNXyw/bgwM687RnDKW2pcs83WoLMjqMiTbgXJUx8FVy1VJ0GCjIKwIUUGnTJ2jBykEE2ODdsIe1OEvtWDm7ie39OhJcKmIUNQS1tiuRvFcVPMX8cxscE/emQ1NTtYjGOP9oequzGYhWX/QaxBMUC9gXJS7dKVBB2pWeMHcbZVZMtv+7arG5dWfciGA22r3UqhY6egpzX05h2wbIgvsYvvqpOwFlJhBzaJs25A1djrE0hH47TmCQFfH9wYqEz9CfcvT/aqKImUfa7m+qdlXeTkvsx+kh5eibAyRgsvOwGZ6emwINXI4zahBrQmpiLxIYxw02zQRBZU+0LrRrMm1jfKkj6usfSHnonafkQrlH2i6H4sZs+XUvVDYDmUK9vxWtZ9WAvqKRvkSAQvtlw70aPLAewv0AY0odMAcUduIc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(376014)(82310400026)(23010399003)(10067099003)(56012099006)(18002099003)(22082099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: /PBT893YL9qQCQcNUqTvNh6VonxhgFJ1upCkNhayFI773Hf5yQwslM/KvQ8F9Wns0yHDDh6aXP3AbtgvIBeWkntahOSEi9f0T5dHzivwOhKZ4ht6uNvC8t+upr+ysvtd0bAaYJoY7PN9Z9eoOk6+xpen5zHjoxhHHlUvXb5Gmf9Ej0VtAgxLtyUxm2VISgud8BFCh0bi+4iNOkP4J4ADfneIc+OFfrwjWxUMtLMqpxKpfCwUjWwepqg2UfsFHJN5uZdUWg0nW7IZOeh2nmCy/rtJyjhWp3T7Jj0lolhFktsR23atvKW+37DVMNyGFtQap3QC7Er+BZ0CMxJBwlw6DxRH/qwDo07yEVdQHAFPdUoCJnqpzAQHcX+BhmfwU9/x0/mLwxXaJa6BMLYHArwEuur+OyiiZ3gIr1POh4tCvFf55mmibk5YOUcVrQhNqsLK
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 20:22:49.4590 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 01bdd89c-78a7-42fc-5858-08defd667932
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B36F.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8757
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

Add KUnit tests for add_fs_modes() covering successful freesync-video
mode generation and refresh rates that fall outside the supported
range.

Assisted-by: Copilot:Claude-Opus-4.8
Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 .../tests/amdgpu_dm_connector_test.c          | 64 +++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
index e022f93c36cf5..988f0885679aa 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
@@ -5602,6 +5602,68 @@ static void dm_test_add_fs_modes_no_preferred_mode(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, (int)add_fs_modes(aconnector), 0);
 }
 
+/*
+ * Build a DisplayPort connector whose highest-refresh mode is a fixed
+ * 1920x1080@60 timing. A non-zero freesync_vid_base.clock makes
+ * amdgpu_dm_get_highest_refresh_rate_mode() return that timing directly,
+ * giving the test full control of the reference mode.
+ */
+static struct amdgpu_dm_connector *dm_test_fs_setup(struct kunit *test)
+{
+	struct drm_device *drm = dm_test_alloc_drm(test);
+	struct amdgpu_dm_connector *aconnector =
+		dm_test_add_connector(test, drm, DRM_MODE_CONNECTOR_DisplayPort);
+	struct drm_display_mode *m = &aconnector->freesync_vid_base;
+
+	m->clock = 148500;
+	m->hdisplay = 1920;
+	m->htotal = 2200;
+	m->vdisplay = 1080;
+	m->vsync_start = 1084;
+	m->vsync_end = 1089;
+	m->vtotal = 1125;
+
+	return aconnector;
+}
+
+/**
+ * dm_test_add_fs_modes_generates - Test FreeSync video modes are added
+ * @test: The KUnit test context
+ *
+ * With min/max vfreq spanning the standard rates, add_fs_modes() derives one
+ * mode per legal rate at or below the reference refresh. A second call finds
+ * every generated mode already present, so is_duplicate_mode() rejects them
+ * all and no new modes are added.
+ */
+static void dm_test_add_fs_modes_generates(struct kunit *test)
+{
+	struct amdgpu_dm_connector *aconnector = dm_test_fs_setup(test);
+
+	aconnector->min_vfreq = 20;
+	aconnector->max_vfreq = 60;
+
+	KUNIT_EXPECT_EQ(test, (int)add_fs_modes(aconnector), 8);
+	KUNIT_EXPECT_EQ(test, (int)add_fs_modes(aconnector), 0);
+}
+
+/**
+ * dm_test_add_fs_modes_out_of_range - Test no modes when rates fall outside range
+ * @test: The KUnit test context
+ *
+ * A vfreq window above the reference refresh leaves every standard rate either
+ * higher than the mode or outside [min_vfreq, max_vfreq], so add_fs_modes()
+ * skips them all and returns 0.
+ */
+static void dm_test_add_fs_modes_out_of_range(struct kunit *test)
+{
+	struct amdgpu_dm_connector *aconnector = dm_test_fs_setup(test);
+
+	aconnector->min_vfreq = 100;
+	aconnector->max_vfreq = 120;
+
+	KUNIT_EXPECT_EQ(test, (int)add_fs_modes(aconnector), 0);
+}
+
 /**
  * dm_test_add_freesync_modes_null_edid_noop - Test NULL EDID adds no modes
  * @test: The KUnit test context
@@ -8206,6 +8268,8 @@ static struct kunit_case amdgpu_dm_connector_tests[] = {
 	KUNIT_CASE(dm_test_ddc_get_modes_null_edid),
 	/* add_fs_modes */
 	KUNIT_CASE(dm_test_add_fs_modes_no_preferred_mode),
+	KUNIT_CASE(dm_test_add_fs_modes_generates),
+	KUNIT_CASE(dm_test_add_fs_modes_out_of_range),
 	/* amdgpu_dm_connector_add_freesync_modes */
 	KUNIT_CASE(dm_test_add_freesync_modes_null_edid_noop),
 	/* amdgpu_dm_i2c_func */
-- 
2.43.0

