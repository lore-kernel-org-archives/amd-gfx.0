Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 947BDC5DF97
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Aug 2026 20:23:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 49A2910ECDE;
	Tue, 18 Aug 2026 20:23:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="eIgrMsKM";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010024.outbound.protection.outlook.com [52.101.201.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EEC1F10EC9F
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Aug 2026 20:22:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tWNqYgtR3dRcA9syphwYj5g/D9VRp1Cy8Y0Pmr6yf+i/daLGArKfmHgZJ2huwnMWWSzaE4kez4XuA+825C5j+nRTgCfp9F4w3/PJ6b7mIAyY+AMo82WzkI5Opuh1dNGMGQ8sxwTM368pMHQrUo/+KgBTsLPFia455wTWmM/fJddSX57LkBiZ5CPSq7UX1IgIXR5Q9MfivEBNK2J58oRoFvw1t3t4quBmHnA+oZiVfo0PAhae1G9WC5HqqGh8040RzzpRlfoOjqdjn/82BWMQ8vlZCmCYDoQd+IeeM2m/pKweiZQSAK9wvXNFWJ2FxOoGCpDv3S4AsBeIJwVSRaxM7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cV6EWtCrXcIPn27Fd6S24Uc3CXpcssldG8eVntggpvQ=;
 b=tLCge03apNj3NEO0DdatC2muFA89lNt4Vk7ohSLGnYV5JXZLSJzoUfisr7jSpxwI5bNVfEQb8D99Te43zBAnXX72a3aCaiAoGIf6V+UMSiHXdKRp0hWSkWSw3QakOBCiptMX4L2u4g41kRsmRnFv9eoIrTol4Sv6bh3TDvZnGAvo/OVOv3Q34DbUgPWoAX8cHM3XD6MgfIrFL766wKNCCbUcELj9UWWb/GSptv5lxdV9o/YQgJHQee69/Eiksjyjj6AYKr7gtuEQITr3BMa6lUzv9O/1VOewgnVzK5J+NbDAGVQ1MHDm0bIjOAqyRvCd6WYZUiGIQK8cBr1WLpQPYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cV6EWtCrXcIPn27Fd6S24Uc3CXpcssldG8eVntggpvQ=;
 b=eIgrMsKMSwagC1wPbMCRNzRoAXUUsbEyvsWdC62DfOi09NVWZYw4P2SAEsv5uU8WBUmXNqx/rOFdPSnedqvZOU/16/78lNsBkRbbIHdwH0hYBiYkVg9RqjWhEy3Tx8XR+GZCo3C69+3ZPlb1ZhpzCF3OrGdMcGqDtnktj/PHqUE=
Received: from BN9PR03CA0899.namprd03.prod.outlook.com (2603:10b6:408:13c::34)
 by BN7PPFED9549B84.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::6e7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Tue, 18 Aug
 2026 20:22:25 +0000
Received: from BN3PEPF0000B373.namprd21.prod.outlook.com
 (2603:10b6:408:13c:cafe::aa) by BN9PR03CA0899.outlook.office365.com
 (2603:10b6:408:13c::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.17 via Frontend Transport; Tue,
 18 Aug 2026 20:22:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B373.mail.protection.outlook.com (10.167.243.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.0 via Frontend Transport; Tue, 18 Aug 2026 20:22:25 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 18 Aug
 2026 15:22:18 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 18 Aug
 2026 15:22:18 -0500
Received: from box-0.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Tue, 18 Aug 2026 15:22:17 -0500
From: <IVAN.LIPSKI@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Subject: [PATCH 34/82] drm/amd/display: Cover
 hide_secondary_tile_from_userspace
Date: Tue, 18 Aug 2026 16:15:26 -0400
Message-ID: <20260818202139.4172592-35-IVAN.LIPSKI@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818202139.4172592-1-IVAN.LIPSKI@amd.com>
References: <20260818202139.4172592-1-IVAN.LIPSKI@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B373:EE_|BN7PPFED9549B84:EE_
X-MS-Office365-Filtering-Correlation-Id: c47546c2-1f47-4bf6-9bfe-08defd666ae0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|82310400026|1800799024|376014|10067099003|11063799006|5023799004|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: o7cytJPSmBm5m9ZN1QK4DXV7QVT1QoA53C3eN+ogpAP/O9Kezmllk0IU5E8WiR0Il5poIaFmIhUB2W2ggfZ0st7kom4NWkJDyRo78wuf/nAwjn1E2JzFkF2oVBuuA9LmtaXmBrCTsdnMASAOPay/Pybv1ypeLrmjRs3fahO1JqG5W9gQQKzF8ZYtpxhzTockahdYiJw9v34AMr39p3S16QqyxDjs0Q9aa8RtUI7UsgdWtcgm2gAuffMbOFUgUcq9msgA2/vkQZhQ+gNcgo7pnlpY8sgIwKFeCf2S583KyyAY7k4+NOjaBCJIpQ7OEK746rwoea+PhJARD/SXDX439njOWtd/MxtnFp1JCHeF9ECG7cDLfIHlklRfc+5rxIozFZNWRue14lQ+skpZcz3CE6p2VeESqx9AnJKGGK/xhw4Ojn2XgpeXHkPAre6mXvwEXVpoWt+wT7lX+yQkD3Dkf0oPilTPmLCSPV7310WTMDBNBrjqWM43ZS1iVo+6fQ5CiDQ/AsCMZjafm5N7tF462M2MYFDOIvQXxRH4WDhEbC/u7TGC8p4N3d4vwrWeRHXQwcrL93hSCfEtpBhuV5T3KBiAldaVUQHun2nV+qvBkfzXEfLOFSQQCNE7hXcraHxyBlF7CEoEZVmzzoZprfW7X50OFcbrDANod4d02TntqHEYKMIWUbGQS4UCDyJGbV2CVBH4CI2rdMvaUOfy/Od5Zg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(82310400026)(1800799024)(376014)(10067099003)(11063799006)(5023799004)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: SFVSHhdonR6+JpOyCAE653aizA6vcMyBiGyqJPfl8OBMpQnkYdYmN2+dC+S03WYZFk5mdoPV50zuRxpR4IBJmMcIQlP825IS3qoa/DNXG1QljiBgh0g1I/yGbao677xeIv6TfMO6GLl7ZbiUVzSGUtBF+a/WdoLgpCkMriW3hV9+k/VXtkxCutk6bM7imSdpFbv9sdIKAnojpytkDy+1R2G6G+2Eq5qeqr40CCtmGhYtJrTCrLlUi8088765ltJ4bkztwhO+YCyLbh89jHmnqIexnWaSTFjX4UJKSGYVQ6U4x7BeDpxB6Mdr3YdymahLFGQpSzML1FGuoltD0NeBN2dQc+xVU/URNMNLc2Y3Kf4IftQ4zz9IYc7s/hu2CDjJOMO/6QEorXwzcp92yj2mp8tQ/amorb/UpTZIxv19+8PDM3BPEkXA4PFxMyXeqhMX
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 20:22:25.4361 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c47546c2-1f47-4bf6-9bfe-08defd666ae0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B373.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPFED9549B84
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

Add a KUnit test that drives amdgpu_dm_connector_detect() through the
amdgpu_dm_hide_secondary_tile_from_userspace() path using a sink that
requests disable_second_tile and a synthesized DisplayID tiled EDID at a
non-origin tile location, so the secondary Apple Studio Display tile is
hidden and the connector reports disconnected. Raises the helper coverage
from 44% to 100%.

Assisted-by: Copilot:Claude-Opus-4.8
Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 .../tests/amdgpu_dm_connector_test.c          | 62 +++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
index 1b1ed534ed441..55cf9c3708394 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
@@ -4122,6 +4122,67 @@ static void dm_test_detect_no_sink(struct kunit *test)
 		(int)connector_status_disconnected);
 }
 
+/*
+ * A 256-byte EDID whose DisplayID extension carries a tiled display
+ * topology block placing this connector at tile location (h=1, v=0), i.e.
+ * a secondary tile. drm_edid_connector_update() parses it to set has_tile
+ * and the non-origin tile location.
+ */
+static const u8 dm_test_detect_tile_edid[256] = {
+	0x00, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0x00, 0x10, 0xac, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x04, 0x80, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0xc4, 0x70, 0x12, 0x18, 0x00,
+	0x00, 0x12, 0x00, 0x15, 0x00, 0x11, 0x10, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x8d, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x90,
+};
+
+/**
+ * dm_test_detect_hides_secondary_tile - Test the secondary tile is hidden
+ * @test: The KUnit test context
+ *
+ * A sink whose panel patch requests disable_second_tile combined with a tiled
+ * EDID at a non-origin tile location makes the detect path hide the secondary
+ * Apple Studio Display tile, reporting the connector as disconnected.
+ */
+static void dm_test_detect_hides_secondary_tile(struct kunit *test)
+{
+	struct amdgpu_dm_connector *aconnector = dm_test_detect_connector(test);
+	struct dc_sink *sink;
+
+	sink = kunit_kzalloc(test, sizeof(*sink), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, sink);
+	sink->edid_caps.panel_patch.disable_second_tile = true;
+
+	aconnector->base.force = DRM_FORCE_UNSPECIFIED;
+	aconnector->dc_sink = sink;
+	aconnector->drm_edid = drm_edid_alloc(dm_test_detect_tile_edid,
+					     sizeof(dm_test_detect_tile_edid));
+	KUNIT_ASSERT_NOT_NULL(test, aconnector->drm_edid);
+
+	KUNIT_EXPECT_EQ(test,
+		(int)amdgpu_dm_connector_detect(&aconnector->base, false),
+		(int)connector_status_disconnected);
+
+	drm_edid_free(aconnector->drm_edid);
+}
+
 /* Tests for amdgpu_dm_connector_poll() */
 
 /**
@@ -6491,6 +6552,7 @@ static struct kunit_case amdgpu_dm_connector_tests[] = {
 	KUNIT_CASE(dm_test_detect_force_off),
 	KUNIT_CASE(dm_test_detect_sink_present),
 	KUNIT_CASE(dm_test_detect_no_sink),
+	KUNIT_CASE(dm_test_detect_hides_secondary_tile),
 	/* amdgpu_dm_connector_poll */
 	KUNIT_CASE(dm_test_poll_dac_load_returns_cached),
 	KUNIT_CASE(dm_test_poll_connected_cached_sink),
-- 
2.43.0

