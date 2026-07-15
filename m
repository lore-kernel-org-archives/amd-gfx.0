Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB0F0C44508
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jul 2026 13:47:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C94C10F096;
	Wed, 15 Jul 2026 13:47:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OQ6fLtVO";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012022.outbound.protection.outlook.com
 [40.93.195.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3BD9B10F096
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jul 2026 13:47:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P/2ftIlGAVuvkY98pG9peI/eJEYIAFwb4NmI3PELt2y7/G761dtHhf0K/MQNiQ60lD3b6wB6O4IFAndjpvOkC8/xyFq2+0D6hYmtlUC9hineMJA78I7He8xHr8W3qMDkQzhm85fwzshZOowqWbt/RTc5z9TB1JKr1bmufJ7G1oNFmHZQ9lj63nlq48EcoQLo0v9mPbfU2tNQB76yYKs1TKqvBFmNmCHfxUl046vPQACZ7+PIPyXAtaN/z9u2OCanb4eKb/TQHNSdHJtRtKeChqY2MDHD83u7MMAo3E7nH3KD5lzJwcjn19cCS8lfuBirXa+bEyTtAEFEDIQ0qVTidg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g6QEZlzSM4cweSaYPMbMVc/Bv+w6vaR60YomwIZo3yY=;
 b=YMUWkryMVRgF4YOzapcmVYmR39qaGToxFARbVRQ1qLFzCtu3wXEOrqbnnvXBTEs1AS68HHUEn5l1bLa2qCzqoeBKsHkdiauh/S+yctNQPGKbDoDbGZtDuvcFRO7vgAzA45fq9km/0SPE9rWPVpa5FzK4ukiKuGXJN7EpU+sXgJ1lJuiMHikp8BI/qES9NLI4ItvEZFPGh3MQKqNHRzhhhYiCsOg1GDQL5RRqMfSM2YrYgO1ifiPjoxWS+Ox6MZC0fR2DijkMTrYPjTzqFxhB5uJufJsMjOMVjV+edBbdoV3vaR9jZPmeEihelg5KEOI+ruixMYSnJ3aECt6JupivUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g6QEZlzSM4cweSaYPMbMVc/Bv+w6vaR60YomwIZo3yY=;
 b=OQ6fLtVOf1FmiIHd0Mk+ULuSUxJT/JP1quiwrpMd5W2lXNNh391KKi0ekSAKOjs13Hb+SwjB/3y3DR3P1dMblcjQygOFguphecHjcydQJRGsfwXcAPMGeoXQkfJfrnrswxqhYGh4WRhBb9oDWftPczQbFs7eeYAErI7fg1ctmWg=
Received: from BY5PR03CA0004.namprd03.prod.outlook.com (2603:10b6:a03:1e0::14)
 by CYYPR12MB8924.namprd12.prod.outlook.com (2603:10b6:930:bd::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.19; Wed, 15 Jul
 2026 13:47:24 +0000
Received: from SJ5PEPF000001F5.namprd05.prod.outlook.com
 (2603:10b6:a03:1e0:cafe::3c) by BY5PR03CA0004.outlook.office365.com
 (2603:10b6:a03:1e0::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.10 via Frontend Transport; Wed,
 15 Jul 2026 13:47:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001F5.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Wed, 15 Jul 2026 13:47:21 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 15 Jul
 2026 08:47:20 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 15 Jul
 2026 08:47:20 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 15 Jul 2026 08:47:16 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Subject: [PATCH 39/70] drm/amd/display: add CRC source list KUnit coverage
Date: Wed, 15 Jul 2026 21:37:49 +0800
Message-ID: <20260715134432.1975118-40-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260715134432.1975118-1-Wayne.Lin@amd.com>
References: <20260715134432.1975118-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F5:EE_|CYYPR12MB8924:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f937fdf-bdd1-42f8-d032-08dee2779801
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|1800799024|376014|82310400026|6133799003|11063799006|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: sdxSu7DNf19P4KbWJppZVToXrBorF033iW1W/rU9ptvuwW/+f1d0F3RvBBsd1jw1P2sWbp/L2uPoOrv4IBHkJQw4DMysg/di4guFlg4lJs+aOOsw4Ub4kgrozz2/BTm0H1vIIyvPPYlU2dOqdykC+YN7Vy0smYzUFFi+uLccldH4Lw6O2N7zyF69tYEoRUwwGboPrM2c7Ctm0eeqOzWtMFSPgfzpWUXvVERNBPH5CoNNd+zvMlmS6u/HuM9O3OrJmdozjjVkXesW1CZeNUQWdpGZBnHeJxy/xaMTGyxtMp2Mmszs1d1OCHuRs1vL1WEKG6ujppRpoGj+WYuuR8wUKkKfhLuICRN7UM2TGKb3Q/U9zUEQtdSdKhOPCUtUt48RgWc1mLDoO9BmlVW3zQJvmXF5iHZntvwgm68L1UedRbdZpdUcJCO+xEvBYXmtMVM7dE9VdceUY5FM79CKm/dx7malZyiKCFZG6hnpZ+P7K7SDDT1bojymNBB85f9qgElU/x3RuqQoktifr+qZEdjU4sbxYVSeCP6zMftNsWFeVn3k4InvobSWOXjru8pA4g/IwkukvGBDXutLa300ZOhNMnK3Vef9pbbDLNOE87SOAuW0e/0T27uDPL3jqjxgSbPVV3wai8alUTeAIhBzdh7fuoH2mfNXN6hWjCzEHxf3rkvEZCbTYsLUIqjjrPviRN6KH70uqo1Q3GCbo9Hoj3tdPQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(1800799024)(376014)(82310400026)(6133799003)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: c/C6kr4Leyxq+jjtNjDB5t1EPkeafg7cUkDQ1rLFNT+sohjv2KPyL66cyYqHmBiWJvHius7uSzAVh1ub2+od8Cl3fHw8HJit0udYi5JkpLrhhP/u1H2xWqpoBpubF9cB5lQaLwqz0pryDn3DouTFQi2NcYqMdA+XAYAmJtLtSvMS4gDeOIxn/GZVn0GVkrL13gPeJ3YlgxnqomvPXlqJ1Sklrg2Fp9k6guKw9LZWKLUqkDPfbfN70fkxdZK2AdBSA7CHMMzJs/5ZlbbHZSvAXebmHTowdlDp+NMYbu6+EGbso8GSYQ9myfciXlty0KWLYGuxdOlNWaKL45N/jfez5Ej2TF/6wGvqqImOHhWvIexVrRTOk0kvJ8+verY5qNph18DFsX2gYFCORADabeuOdgSGquCfkpiNxovRk//YTDoci+DUM6qjcLYawrvnmG/C
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 13:47:21.1163 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f937fdf-bdd1-42f8-d032-08dee2779801
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001F5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8924
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
Expose amdgpu_dm_crtc_get_crc_sources() for KUnit and add a test that
verifies the returned static source-name list and its count. This is the
accessor used by the debugfs CRC control interface.

Assisted-by: Copilot:Claude-Opus-4.8 GPT-5.5
Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c |  1 +
 .../amdgpu_dm/tests/amdgpu_dm_crc_test.c      | 26 +++++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c
index 1f9528364e53..630dea3487b3 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c
@@ -152,6 +152,7 @@ const char *const *amdgpu_dm_crtc_get_crc_sources(struct drm_crtc *crtc,
 	*count = ARRAY_SIZE(pipe_crc_sources);
 	return pipe_crc_sources;
 }
+EXPORT_IF_KUNIT(amdgpu_dm_crtc_get_crc_sources);
 
 #ifdef CONFIG_DRM_AMD_SECURE_DISPLAY
 static void update_phy_id_mapping(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_crc_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_crc_test.c
index a6fd3a6fd803..88f7a15853e8 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_crc_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_crc_test.c
@@ -95,6 +95,30 @@ static void dm_test_is_valid_crc_source(struct kunit *test)
 	KUNIT_EXPECT_FALSE(test, amdgpu_dm_is_valid_crc_source(AMDGPU_DM_PIPE_CRC_SOURCE_INVALID));
 }
 
+/**
+ * dm_test_crtc_get_crc_sources() - Test available CRC source strings.
+ * @test: KUnit test context.
+ *
+ * Verifies that amdgpu_dm_crtc_get_crc_sources() returns the static source
+ * list and reports all debugfs source names.
+ */
+static void dm_test_crtc_get_crc_sources(struct kunit *test)
+{
+	const char *const *sources;
+	size_t count = 0;
+
+	sources = amdgpu_dm_crtc_get_crc_sources(NULL, &count);
+
+	KUNIT_ASSERT_NOT_NULL(test, sources);
+	KUNIT_EXPECT_EQ(test, count, 6);
+	KUNIT_EXPECT_STREQ(test, sources[0], "none");
+	KUNIT_EXPECT_STREQ(test, sources[1], "crtc");
+	KUNIT_EXPECT_STREQ(test, sources[2], "crtc dither");
+	KUNIT_EXPECT_STREQ(test, sources[3], "dprx");
+	KUNIT_EXPECT_STREQ(test, sources[4], "dprx dither");
+	KUNIT_EXPECT_STREQ(test, sources[5], "auto");
+}
+
 /**
  * dm_test_need_dp_aux() - Test dm_need_dp_aux().
  * @test: KUnit test context.
@@ -222,6 +246,8 @@ static struct kunit_case dm_crc_test_cases[] = {
 	KUNIT_CASE(dm_test_need_crc_dither),
 	/* amdgpu_dm_is_valid_crc_source() */
 	KUNIT_CASE(dm_test_is_valid_crc_source),
+	/* amdgpu_dm_crtc_get_crc_sources() */
+	KUNIT_CASE(dm_test_crtc_get_crc_sources),
 	/* dm_need_dp_aux() */
 	KUNIT_CASE(dm_test_need_dp_aux),
 	/* dm_crc_source_should_start_dprx() */
-- 
2.43.0

