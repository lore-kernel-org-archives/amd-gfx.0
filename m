Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 088B3C5DF8A
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Aug 2026 20:22:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC0AB10EC99;
	Tue, 18 Aug 2026 20:22:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TgQwfdRQ";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010045.outbound.protection.outlook.com [52.101.201.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B8AFE10ECC1
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Aug 2026 20:22:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NgbXs794W6TeL3WFYwvosCaGFMtQtT1kg2wuk6mEVZhSL478KUHfpw77UMBd2kCtfHgax9V0VOsy0XhCPnlWpoY2uUrC7Q6PpZ1tjqdAeTJE5jfefmhnCLn4uxgntea5Jn/CR4n20301w/OzA5isOiDHYdNZEhqCCoI8V0U8cSohBBZXb2rbgNBBedUb9O915OwWawwPxTO+MhiTZaCuUnmW/mUslVB7rgaw1Uh7BBW5J2eyQXyKi2AS4jLrwoGMLzBKhuwd5i3SHuYSRUznwQDGHE9iLyQxOJbXebEwW4X/KYr1AzdaXDfFtQCRIFaz4jQIEZU1dAbK+Ff9Cck6UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MkmnRGdWPzXmbIBaOLoBz++CvBofI5jv+/sufImawDU=;
 b=OMjsiOwf2jJvX5mlM+JlZpcdiOJrRbfJJlenepWjqeQkAghYCzEKxhUXJQzVUmsXv7tIxFevv7OIq3zKjYk1ZopCrrbd4xK31ESzH7hF5fSpNoyQ+kPtTRIlZjbyoo1sVSIVZBBYDv8MCvURaXHEdfQy76qXSPGkCgjs734vAgWviN66KBGMed8u4NO1G0gjLl+3g/NoSlh+MkSJxDeMEy0/g17clkIiYqJBvRISUVw1hNBJZNsXwoMMvZxIICpoohb0/TuyVYWgbIQ9QM2ncJT5Twhzz2KAxl1HpqxIC2cqPY5kVUa6QqDRim9ShzFe1vYJTSAtcFthPKfb/W6RFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MkmnRGdWPzXmbIBaOLoBz++CvBofI5jv+/sufImawDU=;
 b=TgQwfdRQBYccxCuA6/hdGOubLuOAU/Kpn94cXFbqtVN+5CVktLJuK6Wkl6QXH42oMANMsXtGSa7h/jkh9Sh+e1fjb0D8tyoRtUeKVVsjqqiwmIteEQ1sp8hSqSTtfxUoeL0OcyPZptto7h8qvh1MlTOYmklWGoNwkRlsFVnJk/8=
Received: from BN9PR03CA0332.namprd03.prod.outlook.com (2603:10b6:408:f6::7)
 by CY8PR12MB7145.namprd12.prod.outlook.com (2603:10b6:930:5f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Tue, 18 Aug
 2026 20:22:43 +0000
Received: from MN1PEPF0000F0DE.namprd04.prod.outlook.com
 (2603:10b6:408:f6:cafe::21) by BN9PR03CA0332.outlook.office365.com
 (2603:10b6:408:f6::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.17 via Frontend Transport; Tue,
 18 Aug 2026 20:22:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MN1PEPF0000F0DE.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Tue, 18 Aug 2026 20:22:43 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 18 Aug
 2026 15:22:32 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 18 Aug
 2026 15:22:32 -0500
Received: from box-0.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Tue, 18 Aug 2026 15:22:31 -0500
From: <IVAN.LIPSKI@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Subject: [PATCH 54/82] drm/amd/display: Cover amdgpu_dm_fill_hdr_info_packet
Date: Tue, 18 Aug 2026 16:15:46 -0400
Message-ID: <20260818202139.4172592-55-IVAN.LIPSKI@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818202139.4172592-1-IVAN.LIPSKI@amd.com>
References: <20260818202139.4172592-1-IVAN.LIPSKI@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DE:EE_|CY8PR12MB7145:EE_
X-MS-Office365-Filtering-Correlation-Id: b75884b1-2640-460e-11de-08defd66756f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|23010399003|376014|82310400026|10067099003|11063799006|56012099006|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: Eo4AJWUxY3b4GlbVKadjINfeHqpm312QUQhWy8U4qZFXjBkwW7VQuEKbBoqPbQGgdblCp3lD+YkN/gSlOWhdFymydfZH2cRBFKyfvnq2EJo+IqZM962rMtoXSXOlAFbZJGRkiRTwNP/TVHMXrYEBaNF08tk2HALE/w0z0YqSphi3Nq+d+6bR07vqYSOKie0zrNkwbV1ZG/pMELiZaZkAqTrso5M4feEygE2BWMLvTUNmiYqcUi8AKSQMPGHdDS7i+bZVp0mZ/JIwA5BZpwppt9hYvpbGoI7SE02u+nuE1PQXTZMGcyQs8xbPgyVffDNT+GxwmKpq9ILpWuvQ+yuM0EvE/j14MmpxbkSQ5yHU5o58VnPztIor8EdDUjzPTmk763BEgpeFsKsyb3MKGImHjg6CK1n2a9kjQaBpQHGokLDHdUqqMDOXpcOyDV/KlV0CKgPYFOWiijp9h4JsM1GnIfWVbANMgLsXoMzcYEAWwxjHwSe4YE5D2A2jvm+wL5nfqn1r0daX0dY/8z6Ho8J/USqQHqeco7hqNdoTH0wnY53nwrJlAvzJNOujIA4UE/DjfyHKGWPaPCvwUqpSEM9OH4RDqnNNoCBi6he2wjwI3jxeK94Ff/Gw7SEjw7XGIWIg45q71Gac4fzaqYjkGPIKKYTgIHSLrGN1RVhyrCkNeSdzOnvAq2eYPKoYHfDHBlPX8+GtjlncEz2cgCWdQgns5w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(23010399003)(376014)(82310400026)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: W6w5qTo6aSEZ7AvMnj8sslr3vYpWUQ3jFtMH0B+R/bhl2Rj9yqKdrIadXC5mMfRNitw7wIIN0VN/KnZxMd8j/jdKTOoMcRUaubI50u58EiS2wScdAW6VQWiyo8Cauk+AMWjBqU7cUYx0yEWTOlXgQp9T+4H4NPte+KBFwLkLh3IPjOpRbpEJHBo8+fdX/WSpAfTzRp0Q9gD+pWFf1cDlYDAMoBqI/3d64GT6Nyunf+OTofUh5LUlpvvgGi67i1m1ajhXFLVQJGBJT9m309PXMVhqyblcSJgUKE/9c1EUQ3yWQhANXT1VXp3PSYKTStqnWei6QK7Mv88BGpu2JHwl0GMd6gugWUH+K5zI6JpVdH/BOJJi8quXzZBXOnxgw+WhgcGujQ1j3fZ4l6sxbqbIiAFuS8LSj4SOxmP9R9yZlGjlL6vumQ3BE6T4Org+7Skr
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 20:22:43.1458 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b75884b1-2640-460e-11de-08defd66756f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0DE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7145
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

Add KUnit tests for amdgpu_dm_fill_hdr_info_packet() covering the HDMI
and DisplayPort HDR paths, an unsupported connector signal, and invalid
HDR metadata.

Assisted-by: Copilot:Claude-Opus-4.8
Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 .../tests/amdgpu_dm_connector_test.c          | 122 ++++++++++++++++++
 1 file changed, 122 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
index fc16d3a35b653..5c701c6b0511d 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
@@ -1654,6 +1654,124 @@ static void dm_test_fill_hdr_zeroes_output(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, (int)out.hb3, 0);
 }
 
+/*
+ * Build a minimal connector state carrying a valid static HDR metadata blob so
+ * the packing path can be exercised without a full atomic state. connector_type
+ * selects the sink-specific header layout.
+ */
+struct dm_test_hdr_ctx {
+	struct drm_connector conn;
+	struct drm_connector_state state;
+	struct drm_property_blob blob;
+	struct hdr_output_metadata meta;
+};
+
+static struct dm_test_hdr_ctx *
+dm_test_hdr_ctx_alloc(struct kunit *test, int connector_type)
+{
+	struct dm_test_hdr_ctx *ctx;
+
+	ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ctx);
+
+	ctx->conn.connector_type = connector_type;
+	ctx->state.connector = &ctx->conn;
+	ctx->blob.data = &ctx->meta;
+	ctx->blob.length = sizeof(ctx->meta);
+	ctx->state.hdr_output_metadata = &ctx->blob;
+
+	return ctx;
+}
+
+/**
+ * dm_test_fill_hdr_hdmi - Test the HDMI infopacket header layout
+ * @test: The KUnit test context
+ *
+ * A valid metadata blob on an HDMI connector packs a type 0x87 infoframe and
+ * marks the packet valid.
+ */
+static void dm_test_fill_hdr_hdmi(struct kunit *test)
+{
+	struct dm_test_hdr_ctx *ctx =
+		dm_test_hdr_ctx_alloc(test, DRM_MODE_CONNECTOR_HDMIA);
+	struct dc_info_packet out;
+
+	memset(&out, 0xAA, sizeof(out));
+
+	KUNIT_EXPECT_EQ(test,
+			amdgpu_dm_fill_hdr_info_packet(&ctx->state, &out), 0);
+	KUNIT_EXPECT_TRUE(test, out.valid);
+	KUNIT_EXPECT_EQ(test, (int)out.hb0, 0x87);
+	KUNIT_EXPECT_EQ(test, (int)out.hb1, 0x01);
+	KUNIT_EXPECT_EQ(test, (int)out.hb2, 0x1A);
+}
+
+/**
+ * dm_test_fill_hdr_dp - Test the DisplayPort SDP header layout
+ * @test: The KUnit test context
+ *
+ * A valid metadata blob on a DisplayPort connector packs the SDP header with
+ * the version/length subpacket bytes and marks the packet valid.
+ */
+static void dm_test_fill_hdr_dp(struct kunit *test)
+{
+	struct dm_test_hdr_ctx *ctx =
+		dm_test_hdr_ctx_alloc(test, DRM_MODE_CONNECTOR_DisplayPort);
+	struct dc_info_packet out;
+
+	memset(&out, 0xAA, sizeof(out));
+
+	KUNIT_EXPECT_EQ(test,
+			amdgpu_dm_fill_hdr_info_packet(&ctx->state, &out), 0);
+	KUNIT_EXPECT_TRUE(test, out.valid);
+	KUNIT_EXPECT_EQ(test, (int)out.hb0, 0x00);
+	KUNIT_EXPECT_EQ(test, (int)out.hb1, 0x87);
+	KUNIT_EXPECT_EQ(test, (int)out.hb2, 0x1D);
+	KUNIT_EXPECT_EQ(test, (int)out.hb3, 0x13 << 2);
+	KUNIT_EXPECT_EQ(test, (int)out.sb[0], 0x01);
+	KUNIT_EXPECT_EQ(test, (int)out.sb[1], 0x1A);
+}
+
+/**
+ * dm_test_fill_hdr_unsupported_connector - Test unsupported sinks are rejected
+ * @test: The KUnit test context
+ *
+ * A connector type with no defined HDR infopacket layout returns -EINVAL and
+ * leaves the packet invalid.
+ */
+static void dm_test_fill_hdr_unsupported_connector(struct kunit *test)
+{
+	struct dm_test_hdr_ctx *ctx =
+		dm_test_hdr_ctx_alloc(test, DRM_MODE_CONNECTOR_VGA);
+	struct dc_info_packet out = {};
+
+	KUNIT_EXPECT_EQ(test,
+			amdgpu_dm_fill_hdr_info_packet(&ctx->state, &out),
+			-EINVAL);
+	KUNIT_EXPECT_FALSE(test, out.valid);
+}
+
+/**
+ * dm_test_fill_hdr_bad_metadata - Test malformed metadata is propagated
+ * @test: The KUnit test context
+ *
+ * A metadata blob with no payload makes drm_hdmi_infoframe_set_hdr_metadata()
+ * fail, and that error is returned unchanged.
+ */
+static void dm_test_fill_hdr_bad_metadata(struct kunit *test)
+{
+	struct dm_test_hdr_ctx *ctx =
+		dm_test_hdr_ctx_alloc(test, DRM_MODE_CONNECTOR_HDMIA);
+	struct dc_info_packet out = {};
+
+	ctx->blob.data = NULL;
+
+	KUNIT_EXPECT_EQ(test,
+			amdgpu_dm_fill_hdr_info_packet(&ctx->state, &out),
+			-EINVAL);
+	KUNIT_EXPECT_FALSE(test, out.valid);
+}
+
 /* Tests for amdgpu_dm_connector_atomic_set_property() */
 
 /*
@@ -7018,6 +7136,10 @@ static struct kunit_case amdgpu_dm_connector_tests[] = {
 	/* amdgpu_dm_fill_hdr_info_packet */
 	KUNIT_CASE(dm_test_fill_hdr_null_metadata),
 	KUNIT_CASE(dm_test_fill_hdr_zeroes_output),
+	KUNIT_CASE(dm_test_fill_hdr_hdmi),
+	KUNIT_CASE(dm_test_fill_hdr_dp),
+	KUNIT_CASE(dm_test_fill_hdr_unsupported_connector),
+	KUNIT_CASE(dm_test_fill_hdr_bad_metadata),
 	/* amdgpu_dm_connector_atomic_set_property */
 	KUNIT_CASE(dm_test_set_property_scaling_center),
 	KUNIT_CASE(dm_test_set_property_scaling_aspect),
-- 
2.43.0

