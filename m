Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1660CC79F82
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Sep 2026 11:35:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9AEF410EB2F;
	Tue,  8 Sep 2026 11:35:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wofW+yN3";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010035.outbound.protection.outlook.com [52.101.56.35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 221D410EB2F
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Sep 2026 11:35:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kahitmiutYsGE8wgRclvJfhNxc03XgvJTFs2pfjMg66H2+COuFPx0JJsHklcNRaA5l5Ga5KQqLLX2p4kG/D8pNqD2Pjs9coYealkd65eXienKvIMC07I7eI1W9oFoZ8pXHY4bPzoi+NWZRSXyGqeuq5d/FA5W4YDtr+CEe+g/0K8G7PoRQQEU47G66Czr/F1H92rgzsws0O3CikdfIONfQXblebjRu7G88XIf4aI3QikqqLzzbbJa9dcvl7Ijtc87J0NumzgzcFcbwsjsy9/tGQUiTs8zoWiSLBT2aLjfSXtCsKw/DoutSRInNun+C1ATzsb4atCWnaC1YBm00idHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zB/2Tcyr7jArijq5UovyaDmhKbQB1LjRsIY7zflnWSs=;
 b=Yh9v1v0KT0oj5REgilhSfBuLI3ctf18Vw9q06Fkf5yXrPgxbr+OG0NskILx1V9TTU3e6pO2s3KNKUX/bjIxcuvzHyQUBtr8fYrOVViY4v+9Hzxx+kJeudcANhIHMk2fs7PwmtpuSNeX66l/sVgY2HS/PFddxddLyiilyI17DLhBybTwzgt9O1GognRZzFcjeO8bkJ+m+jZchmXGnk/5XlM/zQc+RaSgKIv4W7c5cx/dHV0D/9CeX//oNozzb/dQ55YXspVth1ZDnEUGF0qlhQOwP8tTiEuUe8QcGSSLOXnMbbX6M/5MViZ+xWGz2T01K0fb+dyPb8Q7/in/xB2y77Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zB/2Tcyr7jArijq5UovyaDmhKbQB1LjRsIY7zflnWSs=;
 b=wofW+yN3A7nYn2lmmv6E/vKn3xlwXkEzUHn0i5r9pIGotsX6fc2LiytW1Npi5TUmu841eJbyU4bDCOwIQcEPfyuw3IpHta0HDDVAeVSKLvv9QMIH0ka4I1yMR6Us0T42KrLCmkTRHDHmWO2RZyV7NNQ2CkaWWu0PfaoRcHBDiYA=
Received: from MN2PR15CA0066.namprd15.prod.outlook.com (2603:10b6:208:237::35)
 by SJ1PR12MB6172.namprd12.prod.outlook.com (2603:10b6:a03:459::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Tue, 8 Sep
 2026 11:35:04 +0000
Received: from BN2PEPF0000A895.namprd04.prod.outlook.com
 (2603:10b6:208:237:cafe::98) by MN2PR15CA0066.outlook.office365.com
 (2603:10b6:208:237::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.15 via Frontend Transport; Tue, 8
 Sep 2026 11:35:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF0000A895.mail.protection.outlook.com (10.167.248.187) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Tue, 8 Sep 2026 11:35:04 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 8 Sep
 2026 06:34:57 -0500
Received: from chenyu-station.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Tue, 8 Sep 2026 06:34:49 -0500
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
Subject: [PATCH 08/66] drm/amd/display: Test FreeSync caps update
Date: Tue, 8 Sep 2026 19:31:01 +0800
Message-ID: <20260908113338.2433445-9-chen-yu.chen@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260908113338.2433445-1-chen-yu.chen@amd.com>
References: <20260908113338.2433445-1-chen-yu.chen@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A895:EE_|SJ1PR12MB6172:EE_
X-MS-Office365-Filtering-Correlation-Id: a4b178db-59da-476f-6859-08df0d9d39ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|376014|23010399003|3023799007|10067099003|11063799006|5023799004|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: ijlZs3c0sbc72VNfTN2heJXcgTmCwq7LHIzYV+8RQzUP6hb4whWTFYyreuvK7qtn6of7A3yHHMsnLaFB1K8sOxp4hqUkQ4U+x9TVGP7fZJ6opqSAJ62IGwWh8BZeOx3oWo0TlXJ+VOGGnJ5XHenEv782oEQZpidTaUT5jQSY1n5qJIVG3wxzy2Kewdyt56Ux9cWQ/DgNCgQ+Dq+lFCkcGVtQ7OTVPKPkwR2HL/GbfUMVRPB4PRFAkTbNA9mv62jcsImd14/0IopNJnKp77d6uFLCtBUz/PF2zw1LoGrRbSYOUr2jDIm1l1b9ZvaiL3licqj6jFH9C2NSX8HIiAcY9oUY9UnYLuEFdLNo65HvIy+b+Gjmk1rdYgl6g4gj3LC3LuczAlSIFAlACUV0M7eK4ToNMLNZzUX24q6C2da4UlA41icOHnoiffxBtv9CqKkSMdrRSDIFmoN922eVp0i4LSH+wgf3caHNFHSW0CHwTiMUELuTAyHdr96ofrTxGSSYZ3wp/EcZdf/mNfGFxVLcnGFwEycs4KpnlUNTUxIUPULKEctfTwnW0l2uQ3FdzqmU7Ak77fIHWt1lGzuDGZizhsEKgwCy3J8510G8u9NoGfdmkwcEjVTmmiwnmtw0CiHMwz9UJ8Buhw/pAY9HhwVsUGkm63nrL0mCy0krdXjQEz0B0a3wDGQVbuGBQ/Ni/KQCiPyvW2zpUwTypaKXbcQ5jw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(23010399003)(3023799007)(10067099003)(11063799006)(5023799004)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ZcELDZFNAY3FE2ZzM70eLtNudnpecjW5zciZ7vtx2T0dfI8FcpEMesK2nn79ZhNm4CnSIqhrMpmT+B6rqnarnCcYpFgyPDSQls0XEQK5r35qa+FcvwzHRo9tYbSuWCO6NRgdr5OD5wyxp2LTCNkOEMl1s7YooF13koXhdjqjKQQGdxfdxqAjXYtMS/5am/2MTAUpa8XDMasAPJrlvmv0dQ7DTkKdj+hWNmWzmWlVjxgnKK7dW39xZZ3eTPZP8HIWONGGK39KiUcWOyuMu6DH9b7DU/SrzPktV2tpNFZf021LkPC1ALFGb1wu0352lyhtZRyfNIkUOZbcTUF4zRhInze5GTNHCav26r+2NEPzat4GA7JEpNicLOKkGFSsXn+CGgQEwZ0bEm18+aLjpKFsGMS8mx3c5j0nsmFCgMSm5HD6uYzBKFNcW0vnanwNBXew
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 11:35:04.2489 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a4b178db-59da-476f-6859-08df0d9d39ef
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000A895.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6172
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
Add KUnit tests for amdgpu_dm_update_freesync_caps() covering the
DisplayPort invalid-MSA refresh range along with its narrow-range and
valid-MSA-required rejections, an eDP panel advertising replay, the
HDMI AMD VSDB range with and without a parser, a whitelisted DP to HDMI
converter, the forced FreeSync minimum quirk, the MCCS capability
withdrawal and the replay teardown.

Assisted-by: Copilot:Claude-Opus-5
Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Chenyu Chen <chen-yu.chen@amd.com>
---
 .../display/amdgpu_dm/amdgpu_dm_connector.c   |   1 +
 .../tests/amdgpu_dm_connector_test.c          | 431 ++++++++++++++++++
 2 files changed, 432 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
index f95b680ee8f3..fdfb6f72b9fc 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
@@ -4001,3 +4001,4 @@ void amdgpu_dm_update_freesync_caps(struct drm_connector *connector,
 		drm_connector_set_vrr_capable_property(connector,
 						       freesync_capable);
 }
+EXPORT_IF_KUNIT(amdgpu_dm_update_freesync_caps);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
index 7a51b27f020a..d8a6d6ae90ec 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
@@ -9440,6 +9440,426 @@ static void dm_test_initialize_hdmi_cec_registers(struct kunit *test)
 	KUNIT_EXPECT_NOT_NULL(test, ctx->aconnector->notifier);
 }
 
+/* Tests for amdgpu_dm_update_freesync_caps() */
+
+static void dm_test_fs_free_edid(void *data)
+{
+	drm_edid_free(data);
+}
+
+/*
+ * Build a two block EDID: the minimal base block with its extension count set
+ * to one, followed by @ext, with both checksums recomputed so drm_edid_raw()
+ * and the DRM EDID parsers accept it.
+ */
+static const struct drm_edid *dm_test_fs_edid_alloc(struct kunit *test, const u8 *ext)
+{
+	const struct drm_edid *drm_edid;
+	u8 *raw;
+	int i;
+
+	raw = kunit_kzalloc(test, 2 * EDID_LENGTH, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, raw);
+	memcpy(raw, dm_test_uad_edid, EDID_LENGTH);
+	memcpy(raw + EDID_LENGTH, ext, EDID_LENGTH);
+	raw[EDID_LENGTH - 2] = 1;
+
+	for (i = 0; i < 2; i++) {
+		u8 *block = raw + i * EDID_LENGTH;
+		u8 sum = 0;
+		int j;
+
+		for (j = 0; j < EDID_LENGTH - 1; j++)
+			sum += block[j];
+		block[EDID_LENGTH - 1] = -sum;
+	}
+
+	drm_edid = drm_edid_alloc(raw, 2 * EDID_LENGTH);
+	KUNIT_ASSERT_NOT_NULL(test, drm_edid);
+	KUNIT_ASSERT_EQ(test,
+			kunit_add_action_or_reset(test, dm_test_fs_free_edid,
+						  (void *)drm_edid), 0);
+
+	return drm_edid;
+}
+
+/*
+ * A DisplayID extension holding a dynamic video timing range descriptor, which
+ * is what parse_edid_displayid_vrr() scans for.
+ */
+static const struct drm_edid *
+dm_test_fs_edid_displayid(struct kunit *test, u8 min_vfreq, u8 max_vfreq)
+{
+	u8 ext[EDID_LENGTH] = {0};
+
+	ext[0] = DM_TEST_DISPLAYID_EXT;
+	ext[1] = 0x25;
+	ext[2] = 0x00;
+	ext[3] = 9;
+	ext[10] = min_vfreq;
+	ext[11] = max_vfreq;
+
+	return dm_test_fs_edid_alloc(test, ext);
+}
+
+/*
+ * A CTA-861 extension with no data blocks, enough for parse_hdmi_amd_vsdb() to
+ * accept the block and hand it to the (mocked) DMCU parser.
+ */
+static const struct drm_edid *dm_test_fs_edid_cea(struct kunit *test)
+{
+	u8 ext[EDID_LENGTH] = {0};
+
+	ext[0] = DM_TEST_CEA_EXT;
+	ext[1] = 3;
+	ext[2] = 4;
+
+	return dm_test_fs_edid_alloc(test, ext);
+}
+
+/*
+ * A CTA-861 extension carrying a 15-byte AMD VSDB v3 payload, which
+ * drm_parse_amd_vsdb() turns into connector->display_info.amd_vsdb and
+ * get_amd_vsdb() then reads back.
+ */
+static const struct drm_edid *
+dm_test_fs_edid_amd_vsdb(struct kunit *test, u8 feature_caps)
+{
+	u8 ext[EDID_LENGTH] = {0};
+
+	ext[0] = DM_TEST_CEA_EXT;
+	ext[1] = 3;
+	ext[2] = 4 + 1 + 15;
+	ext[4] = (3 << 5) | 15;		/* vendor data block, 15-byte payload */
+	ext[5] = 0x1a;			/* AMD IEEE OUI, LSB first */
+	ext[8] = 0x03;			/* AMD VSDB payload version */
+	ext[9] = feature_caps;
+
+	return dm_test_fs_edid_alloc(test, ext);
+}
+
+struct dm_test_fs_caps_ctx {
+	struct amdgpu_device *adev;
+	struct drm_device *drm;
+	struct amdgpu_dm_connector *aconnector;
+	struct dc_link *link;
+	struct dc_sink *sink;
+	struct resource_pool *pool;
+};
+
+/*
+ * Build a connector that clears every guard at the top of
+ * amdgpu_dm_update_freesync_caps(): a reset connector state, a dc_sink whose
+ * dc_context reports a VRR capable DCE version, and a non-NULL freesync
+ * module. The resource pool carries no DMCU, so tests that need the AMD VSDB
+ * parser to succeed install one.
+ */
+static struct dm_test_fs_caps_ctx *
+dm_test_fs_caps_ctx_alloc(struct kunit *test, enum signal_type sink_signal)
+{
+	struct dm_test_fs_caps_ctx *ctx;
+	struct dc_context *dc_ctx;
+	struct device *dev;
+	struct dc *dc;
+
+	ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ctx);
+
+	dev = drm_kunit_helper_alloc_device(test);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dev);
+	ctx->drm = __drm_kunit_helper_alloc_drm_device(test, dev,
+						       sizeof(struct amdgpu_device),
+						       offsetof(struct amdgpu_device, ddev),
+						       DRIVER_MODESET);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx->drm);
+	ctx->adev = drm_to_adev(ctx->drm);
+	ctx->adev->dm.adev = ctx->adev;
+	mutex_init(&ctx->adev->dm.dc_lock);
+
+	ctx->aconnector = drmm_kzalloc(ctx->drm, sizeof(*ctx->aconnector), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ctx->aconnector);
+	KUNIT_ASSERT_EQ(test,
+			drmm_connector_init(ctx->drm, &ctx->aconnector->base,
+					    &dm_test_connector_funcs,
+					    DRM_MODE_CONNECTOR_DisplayPort, NULL), 0);
+	amdgpu_dm_connector_funcs_reset(&ctx->aconnector->base);
+	KUNIT_ASSERT_NOT_NULL(test, ctx->aconnector->base.state);
+	KUNIT_ASSERT_EQ(test,
+			drm_connector_attach_vrr_capable_property(&ctx->aconnector->base), 0);
+
+	dc_ctx = kunit_kzalloc(test, sizeof(*dc_ctx), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, dc_ctx);
+	dc_ctx->driver_context = ctx->adev;
+	dc_ctx->dce_version = DCE_VERSION_8_0;
+
+	ctx->pool = kunit_kzalloc(test, sizeof(*ctx->pool), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ctx->pool);
+
+	dc = kunit_kzalloc(test, sizeof(*dc), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, dc);
+	dc->ctx = dc_ctx;
+	dc->res_pool = ctx->pool;
+	ctx->adev->dm.dc = dc;
+
+	ctx->adev->dm.freesync_module =
+		kunit_kzalloc(test, sizeof(struct mod_freesync), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ctx->adev->dm.freesync_module);
+
+	ctx->link = kunit_kzalloc(test, sizeof(*ctx->link), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ctx->link);
+	ctx->aconnector->dc_link = ctx->link;
+
+	ctx->sink = kunit_kzalloc(test, sizeof(*ctx->sink), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ctx->sink);
+	ctx->sink->ctx = dc_ctx;
+	ctx->sink->sink_signal = sink_signal;
+	ctx->aconnector->dc_sink = ctx->sink;
+
+	return ctx;
+}
+
+/* Install the mocked DMCU so parse_edid_cea() reports an AMD VSDB of 24-60Hz. */
+static void dm_test_fs_caps_add_dmcu(struct kunit *test, struct dm_test_fs_caps_ctx *ctx)
+{
+	struct dmcu *dmcu = kunit_kzalloc(test, sizeof(*dmcu), GFP_KERNEL);
+
+	KUNIT_ASSERT_NOT_NULL(test, dmcu);
+	dmcu->funcs = &dm_test_dmcu_funcs_vsdb;
+	ctx->pool->dmcu = dmcu;
+}
+
+static bool dm_test_fs_caps_capable(struct dm_test_fs_caps_ctx *ctx)
+{
+	return to_dm_connector_state(ctx->aconnector->base.state)->freesync_capable;
+}
+
+/**
+ * dm_test_fs_caps_dp_msa_range - Test a DP sink with an invalid-MSA range
+ * @test: The KUnit test context
+ *
+ * A DisplayPort sink allowing invalid MSA timing takes its refresh range from
+ * the monitor range that parse_edid_displayid_vrr() recovered, and a range
+ * wider than 10Hz marks the connector FreeSync capable.
+ */
+static void dm_test_fs_caps_dp_msa_range(struct kunit *test)
+{
+	struct dm_test_fs_caps_ctx *ctx =
+		dm_test_fs_caps_ctx_alloc(test, SIGNAL_TYPE_DISPLAY_PORT);
+	const struct drm_edid *drm_edid = dm_test_fs_edid_displayid(test, 40, 144);
+
+	ctx->link->dpcd_caps.allow_invalid_MSA_timing_param = true;
+
+	amdgpu_dm_update_freesync_caps(&ctx->aconnector->base, drm_edid, false);
+
+	KUNIT_EXPECT_EQ(test, ctx->aconnector->min_vfreq, 40);
+	KUNIT_EXPECT_EQ(test, ctx->aconnector->max_vfreq, 144);
+	KUNIT_EXPECT_TRUE(test, dm_test_fs_caps_capable(ctx));
+}
+
+/**
+ * dm_test_fs_caps_dp_narrow_range - Test a range of 10Hz or less is rejected
+ * @test: The KUnit test context
+ */
+static void dm_test_fs_caps_dp_narrow_range(struct kunit *test)
+{
+	struct dm_test_fs_caps_ctx *ctx =
+		dm_test_fs_caps_ctx_alloc(test, SIGNAL_TYPE_DISPLAY_PORT);
+	const struct drm_edid *drm_edid = dm_test_fs_edid_displayid(test, 60, 65);
+
+	ctx->link->dpcd_caps.allow_invalid_MSA_timing_param = true;
+
+	amdgpu_dm_update_freesync_caps(&ctx->aconnector->base, drm_edid, false);
+
+	KUNIT_EXPECT_EQ(test, ctx->aconnector->min_vfreq, 60);
+	KUNIT_EXPECT_EQ(test, ctx->aconnector->max_vfreq, 65);
+	KUNIT_EXPECT_FALSE(test, dm_test_fs_caps_capable(ctx));
+}
+
+/**
+ * dm_test_fs_caps_dp_msa_not_allowed - Test a DP sink requiring valid MSA
+ * @test: The KUnit test context
+ *
+ * Without allow_invalid_MSA_timing_param the reported range is ignored and the
+ * connector keeps a zero refresh range.
+ */
+static void dm_test_fs_caps_dp_msa_not_allowed(struct kunit *test)
+{
+	struct dm_test_fs_caps_ctx *ctx =
+		dm_test_fs_caps_ctx_alloc(test, SIGNAL_TYPE_DISPLAY_PORT);
+	const struct drm_edid *drm_edid = dm_test_fs_edid_displayid(test, 40, 144);
+
+	amdgpu_dm_update_freesync_caps(&ctx->aconnector->base, drm_edid, false);
+
+	KUNIT_EXPECT_EQ(test, ctx->aconnector->min_vfreq, 0);
+	KUNIT_EXPECT_EQ(test, ctx->aconnector->max_vfreq, 0);
+	KUNIT_EXPECT_FALSE(test, dm_test_fs_caps_capable(ctx));
+}
+
+/**
+ * dm_test_fs_caps_edp_replay_mode - Test an eDP panel advertising replay
+ * @test: The KUnit test context
+ *
+ * An AMD VSDB with the replay feature bit set records the replay mode and its
+ * VSDB version on the connector and selects the eDP adaptive sync type.
+ */
+static void dm_test_fs_caps_edp_replay_mode(struct kunit *test)
+{
+	struct dm_test_fs_caps_ctx *ctx =
+		dm_test_fs_caps_ctx_alloc(test, SIGNAL_TYPE_EDP);
+	const struct drm_edid *drm_edid = dm_test_fs_edid_amd_vsdb(test, 0x40);
+
+	amdgpu_dm_update_freesync_caps(&ctx->aconnector->base, drm_edid, false);
+
+	KUNIT_EXPECT_TRUE(test, ctx->aconnector->vsdb_info.replay_mode);
+	KUNIT_EXPECT_EQ(test, ctx->aconnector->vsdb_info.amd_vsdb_version, 3);
+	KUNIT_EXPECT_EQ(test, (int)ctx->aconnector->as_type, (int)ADAPTIVE_SYNC_TYPE_EDP);
+}
+
+/**
+ * dm_test_fs_caps_hdmi_vsdb - Test the HDMI AMD VSDB refresh range
+ * @test: The KUnit test context
+ *
+ * On HDMI the CEA extension is handed to the DMCU parser, whose reported
+ * 24-60Hz range is copied to the connector and published as the monitor range.
+ */
+static void dm_test_fs_caps_hdmi_vsdb(struct kunit *test)
+{
+	struct dm_test_fs_caps_ctx *ctx =
+		dm_test_fs_caps_ctx_alloc(test, SIGNAL_TYPE_HDMI_TYPE_A);
+	const struct drm_edid *drm_edid = dm_test_fs_edid_cea(test);
+	struct drm_connector *connector = &ctx->aconnector->base;
+
+	dm_test_fs_caps_add_dmcu(test, ctx);
+
+	amdgpu_dm_update_freesync_caps(connector, drm_edid, false);
+
+	KUNIT_EXPECT_TRUE(test, ctx->aconnector->vsdb_info.freesync_supported);
+	KUNIT_EXPECT_EQ(test, ctx->aconnector->min_vfreq, 24);
+	KUNIT_EXPECT_EQ(test, ctx->aconnector->max_vfreq, 60);
+	KUNIT_EXPECT_EQ(test, connector->display_info.monitor_range.min_vfreq, 24);
+	KUNIT_EXPECT_EQ(test, connector->display_info.monitor_range.max_vfreq, 60);
+	KUNIT_EXPECT_TRUE(test, dm_test_fs_caps_capable(ctx));
+}
+
+/**
+ * dm_test_fs_caps_hdmi_no_vsdb - Test an HDMI sink with no AMD VSDB
+ * @test: The KUnit test context
+ *
+ * Without a DMCU the CEA parse fails, so no refresh range is recorded.
+ */
+static void dm_test_fs_caps_hdmi_no_vsdb(struct kunit *test)
+{
+	struct dm_test_fs_caps_ctx *ctx =
+		dm_test_fs_caps_ctx_alloc(test, SIGNAL_TYPE_HDMI_TYPE_A);
+	const struct drm_edid *drm_edid = dm_test_fs_edid_cea(test);
+
+	amdgpu_dm_update_freesync_caps(&ctx->aconnector->base, drm_edid, false);
+
+	KUNIT_EXPECT_FALSE(test, ctx->aconnector->vsdb_info.freesync_supported);
+	KUNIT_EXPECT_EQ(test, ctx->aconnector->max_vfreq, 0);
+	KUNIT_EXPECT_FALSE(test, dm_test_fs_caps_capable(ctx));
+}
+
+/**
+ * dm_test_fs_caps_pcon_whitelist - Test a whitelisted DP to HDMI converter
+ * @test: The KUnit test context
+ *
+ * A whitelisted protocol converter re-parses the AMD VSDB, enables SDP v1.3
+ * packing and adopts the converter adaptive sync type.
+ */
+static void dm_test_fs_caps_pcon_whitelist(struct kunit *test)
+{
+	struct dm_test_fs_caps_ctx *ctx =
+		dm_test_fs_caps_ctx_alloc(test, SIGNAL_TYPE_DISPLAY_PORT);
+	const struct drm_edid *drm_edid = dm_test_fs_edid_cea(test);
+	struct dpcd_caps *dpcd;
+
+	dm_test_fs_caps_add_dmcu(test, ctx);
+	dpcd = &ctx->link->dpcd_caps;
+	dpcd->dongle_type = DISPLAY_DONGLE_DP_HDMI_CONVERTER;
+	dpcd->adaptive_sync_caps.dp_adap_sync_caps.bits.ADAPTIVE_SYNC_SDP_SUPPORT = 1;
+	dpcd->allow_invalid_MSA_timing_param = true;
+	dpcd->branch_dev_id = DP_BRANCH_DEVICE_ID_0060AD;
+
+	amdgpu_dm_update_freesync_caps(&ctx->aconnector->base, drm_edid, false);
+
+	KUNIT_EXPECT_TRUE(test, ctx->aconnector->pack_sdp_v1_3);
+	KUNIT_EXPECT_EQ(test, (int)ctx->aconnector->as_type,
+			(int)FREESYNC_TYPE_PCON_IN_WHITELIST);
+	KUNIT_EXPECT_EQ(test, ctx->aconnector->min_vfreq, 24);
+	KUNIT_EXPECT_EQ(test, ctx->aconnector->max_vfreq, 60);
+	KUNIT_EXPECT_TRUE(test, dm_test_fs_caps_capable(ctx));
+}
+
+/**
+ * dm_test_fs_caps_force_min_hz_quirk - Test the forced FreeSync minimum quirk
+ * @test: The KUnit test context
+ *
+ * A quirked panel overrides the minimum refresh rate on both the connector and
+ * the published monitor range once FreeSync is otherwise supported.
+ */
+static void dm_test_fs_caps_force_min_hz_quirk(struct kunit *test)
+{
+	struct dm_test_fs_caps_ctx *ctx =
+		dm_test_fs_caps_ctx_alloc(test, SIGNAL_TYPE_DISPLAY_PORT);
+	const struct drm_edid *drm_edid = dm_test_fs_edid_displayid(test, 40, 144);
+	struct drm_connector *connector = &ctx->aconnector->base;
+
+	ctx->link->dpcd_caps.allow_invalid_MSA_timing_param = true;
+	ctx->sink->edid_caps.panel_patch.force_freesync_min_hz = 50;
+
+	amdgpu_dm_update_freesync_caps(connector, drm_edid, false);
+
+	KUNIT_EXPECT_EQ(test, ctx->aconnector->min_vfreq, 50);
+	KUNIT_EXPECT_EQ(test, connector->display_info.monitor_range.min_vfreq, 50);
+}
+
+/**
+ * dm_test_fs_caps_mccs_clears_capability - Test MCCS withdraws FreeSync support
+ * @test: The KUnit test context
+ *
+ * When the sink advertises a FreeSync VCP code but MCCS reports no support,
+ * the connector loses its FreeSync capability.
+ */
+static void dm_test_fs_caps_mccs_clears_capability(struct kunit *test)
+{
+	struct dm_test_fs_caps_ctx *ctx =
+		dm_test_fs_caps_ctx_alloc(test, SIGNAL_TYPE_DISPLAY_PORT);
+	const struct drm_edid *drm_edid = dm_test_fs_edid_displayid(test, 40, 144);
+
+	ctx->link->dpcd_caps.allow_invalid_MSA_timing_param = true;
+	/* A non-DP, non-HDMI link keeps dm_helpers_read_mccs_caps() off the wire. */
+	ctx->link->connector_signal = SIGNAL_TYPE_VIRTUAL;
+	ctx->sink->edid_caps.freesync_vcp_code = 0x60;
+
+	amdgpu_dm_update_freesync_caps(&ctx->aconnector->base, drm_edid, true);
+
+	KUNIT_EXPECT_FALSE(test, ctx->sink->mccs_caps.freesync_supported);
+	KUNIT_EXPECT_FALSE(test, dm_test_fs_caps_capable(ctx));
+}
+
+/**
+ * dm_test_fs_caps_disables_replay - Test replay is dropped without FreeSync
+ * @test: The KUnit test context
+ *
+ * A link advertising replay support has it withdrawn when the connector ends
+ * up without FreeSync capability.
+ */
+static void dm_test_fs_caps_disables_replay(struct kunit *test)
+{
+	struct dm_test_fs_caps_ctx *ctx =
+		dm_test_fs_caps_ctx_alloc(test, SIGNAL_TYPE_DISPLAY_PORT);
+	const struct drm_edid *drm_edid = dm_test_fs_edid_displayid(test, 40, 144);
+
+	ctx->link->replay_settings.config.replay_supported = true;
+	ctx->link->replay_settings.replay_feature_enabled = true;
+
+	amdgpu_dm_update_freesync_caps(&ctx->aconnector->base, drm_edid, false);
+
+	KUNIT_EXPECT_FALSE(test, ctx->link->replay_settings.config.replay_supported);
+	KUNIT_EXPECT_FALSE(test, ctx->link->replay_settings.replay_feature_enabled);
+}
+
 static struct kunit_case amdgpu_dm_connector_tests[] = {
 	/* get_subconnector_type */
 	KUNIT_CASE(dm_test_subconnector_type_none),
@@ -9850,6 +10270,17 @@ static struct kunit_case amdgpu_dm_connector_tests[] = {
 	KUNIT_CASE(dm_test_init_helper_hpd_debounce_disabled),
 	/* amdgpu_dm_initialize_hdmi_connector */
 	KUNIT_CASE(dm_test_initialize_hdmi_cec_registers),
+	/* amdgpu_dm_update_freesync_caps */
+	KUNIT_CASE(dm_test_fs_caps_dp_msa_range),
+	KUNIT_CASE(dm_test_fs_caps_dp_narrow_range),
+	KUNIT_CASE(dm_test_fs_caps_dp_msa_not_allowed),
+	KUNIT_CASE(dm_test_fs_caps_edp_replay_mode),
+	KUNIT_CASE(dm_test_fs_caps_hdmi_vsdb),
+	KUNIT_CASE(dm_test_fs_caps_hdmi_no_vsdb),
+	KUNIT_CASE(dm_test_fs_caps_pcon_whitelist),
+	KUNIT_CASE(dm_test_fs_caps_force_min_hz_quirk),
+	KUNIT_CASE(dm_test_fs_caps_mccs_clears_capability),
+	KUNIT_CASE(dm_test_fs_caps_disables_replay),
 	{}
 };
 
-- 
2.43.0

