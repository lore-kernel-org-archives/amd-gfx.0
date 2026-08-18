Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D088FC5DF7D
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Aug 2026 20:22:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 690AC10EC8E;
	Tue, 18 Aug 2026 20:22:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="URuI8cbM";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010043.outbound.protection.outlook.com [52.101.61.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 187EE10EC8E
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Aug 2026 20:22:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J97a8p0WOvOIHFjnr9ABZcMzeWB9iZLuOSt0ZiEYX2lUXyii9zVPO9POkDV4yEvMElH3whOO1IdDB37fycBwsw3A24JxTUEBjOwwjLBvV7ITf4BLGtIV84Q5hJLE9CiXIw0caslziBzs6u5QkFh1sVdq36OEEODPZfzvX5eJEqG+ltgxPxonXi2xcspIyJ5HCBlsCxcKyra9Xo4ECmRWjeYZ1vvarPzxtwtI/KN5bt0/BY+13qMohQoQYhHDCiWU/ePRK50yK+jQHYtwQjOCOsyxUhr5Rt+o7/VxDF81IIzXt/ld2lraNeA1DfbVplKSNHaLN3GtJNhpgwFAeuJ6mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FAcUBCHqLO1yTVpmoXlzqa+UuA8X8Aq/JaISgaDomTY=;
 b=dl2p2TPnPk291EQINQSSpmhIWFJSlyU4qr6V+Be7KwK9qjTXfonaNjH4KVL6b5vfCj36xD0F2fsyCgNIZOZg0o9zTIHwtzjBAtu+TxiImijkfC87x3A0SCFBgIf+uAiSD2hTdHm+8HoSSMA4iBnNYwyU9yKMj9735IIUj3wuj4xtMEiUaZhJyyorrN4ed+66loOlQvx98cjMwkNPwdu4n75MeIfdRIMUlb7fBdGyGihSq0SSvq6JTxMhOuTuqgb2haArufc+KnEZEbuWniEz40xBkfaoX4TJNrq6kt+BDfcR3jWAThbZQMDufOwix0gqrmxd7Aqhnt9d33tZgREqug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FAcUBCHqLO1yTVpmoXlzqa+UuA8X8Aq/JaISgaDomTY=;
 b=URuI8cbMPTUf6ZvvdmzPMFjkeKRksyza+HWKbxvoS/fbHt9t8cp3mz7AhwfviwKU8BEiRw4PsR2RB7478hGF57Iw7re5UbxjfXnnGwdk3jLCb6YqwP8xLlQVjO8JKMI6Vc6SUumS0VFsqaQcXVyhX0AQiTH2yXNmZVpJ+Ty+gtI=
Received: from BN1PR10CA0019.namprd10.prod.outlook.com (2603:10b6:408:e0::24)
 by CY8PR12MB7657.namprd12.prod.outlook.com (2603:10b6:930:9d::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Tue, 18 Aug
 2026 20:22:09 +0000
Received: from BN3PEPF0000B371.namprd21.prod.outlook.com
 (2603:10b6:408:e0:cafe::73) by BN1PR10CA0019.outlook.office365.com
 (2603:10b6:408:e0::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.8 via Frontend Transport; Tue, 18
 Aug 2026 20:22:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B371.mail.protection.outlook.com (10.167.243.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.0 via Frontend Transport; Tue, 18 Aug 2026 20:22:08 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 18 Aug
 2026 15:22:01 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 18 Aug
 2026 15:22:01 -0500
Received: from box-0.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Tue, 18 Aug 2026 15:22:00 -0500
From: <IVAN.LIPSKI@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Subject: [PATCH 10/82] drm/amd/display: Cover amdgpu_dm_encoder_init
Date: Tue, 18 Aug 2026 16:15:02 -0400
Message-ID: <20260818202139.4172592-11-IVAN.LIPSKI@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818202139.4172592-1-IVAN.LIPSKI@amd.com>
References: <20260818202139.4172592-1-IVAN.LIPSKI@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B371:EE_|CY8PR12MB7657:EE_
X-MS-Office365-Filtering-Correlation-Id: d05895df-2cce-4c8f-a057-08defd6660f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|376014|82310400026|23010399003|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: RQwpzWa/QhcQO1Ie1iFA0/9JrsQmnuZp9+iUzKdqW47rNhDh+ZowvmszialVVai4u11NgVLfiYqV/ZOTtqexMU07Zfo6+TEDhcxYQu9aK3hQJKPBfyh2EtegZ6mRzd40ET4Mqf3ylar54Y+fxVBV3CLdXXAnjq7SnbqIT6CkYKq+zCTcbK9GmknToWhEBpmhAD3cba8MmFGtF3UDVvxikF3KmplR0e7+Idt+2unWZNoRe3HjWeitHj+uQtPBMP9emAJO9TT+7yFMpxpky+fVeaSdOYTyWNwVIXEUWTHkGnaAhEKE2woXMwTQlY89j6qoRiP99WgjYDG1V0T6SWOS8ZuvxakEylut+PfLk2y4snZGN1gZLEHjRRALKLEzr23pOVfl7KdLAJ/VDIJgVPyw+VTmWDi+v0y16JdE8P9p/BHB/P2MdN0XistH4nyBVLjVrj6AIpnWt3VsQjyfOdQmW9yMfqGrAZ5OdSfG1Ze/gnXKArE00JRmCbURzhMNJuXP3lqq9gGgDS21LPoWSO/pDuhc0Pg2HBvHBpWWvzAmI5eqNykY9aS3VnCfFA9+dVGdi1htFVhs+a23O3c0tkZtcpF0HbSy8M5xX3F2EHYZ63tOXtR3FPIFU6fo3O7AJikSePjZ3PcP15JolELOgjdvyCP4XNs5emp4EJz0nHGysA5SNrYbprBVUQNVFRrBz+7GYvEsDtpzcqlOdfbUdU8S+g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(376014)(82310400026)(23010399003)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: e09+CyZPXnmg/SKVUvehcJzMS5EUev54phsUochMaG6a545yaUG+rYm/gA2HBf/mZfbsoMoDPwtr1VPqhHuWRMeB2v1TDukQLD8foZGRaYz08czsVIdnIWcZ/f1nPW4vG8Btg6F8IN+iv//LiM04+VozxTqUjzmXdUKjKqZmH4s0WgEfdVyLl4TM1uKgguTmfIPf+BtsfPoNBk7ddQvjYfXAr4YhKs4AcxJ+Z0k+qPRF4nPEYYMU0w/o1S6OQkydA1k4XMGSHbCx30Y1hrdyLB/ob9ipf01xbZynf+2eD5NGjQOwUXAwE7Y/XM53GsFduKUW5B54G1wnpA7xn7OqSDaFVPMP4LGZuQxGk+UzX9sbQEQ5YmrLFaWT92eloX93LQWAs9zf1KeaxE4wuQGSMyRNq3w7m6h+Jxvulh3P/oIxMXV8nnQ8JLaRHsIV8Ejz
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 20:22:08.7760 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d05895df-2cce-4c8f-a057-08defd6660f2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B371.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7657
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

Add a KUnit test that initializes a TMDS encoder on a DRM device embedded
in an amdgpu_device and verifies the derived possible_crtcs mask, the
encoder id set from the link index, and the attached helper funcs.

Assisted-by: Copilot:Claude-Opus-4.8
Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 .../display/amdgpu_dm/amdgpu_dm_connector.c   |  2 +
 .../tests/amdgpu_dm_connector_test.c          | 38 +++++++++++++++++++
 2 files changed, 40 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
index 2cc3734c992bd..ed16e01987726 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
@@ -171,6 +171,7 @@ const struct drm_encoder_helper_funcs amdgpu_dm_encoder_helper_funcs = {
 	.disable = dm_encoder_helper_disable,
 	.atomic_check = dm_encoder_helper_atomic_check
 };
+EXPORT_IF_KUNIT(amdgpu_dm_encoder_helper_funcs);
 
 int amdgpu_dm_get_encoder_crtc_mask(struct amdgpu_device *adev)
 {
@@ -215,6 +216,7 @@ int amdgpu_dm_encoder_init(struct drm_device *dev,
 
 	return res;
 }
+EXPORT_IF_KUNIT(amdgpu_dm_encoder_init);
 
 STATIC_IFN_KUNIT enum drm_mode_subconnector get_subconnector_type(struct dc_link *link)
 {
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
index d209e26b684eb..b51aba8c07c3c 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
@@ -4289,6 +4289,43 @@ static void dm_test_encoder_disable_noop(struct kunit *test)
  * connector and connector-state are stacked in their containers and wired
  * together through conn_state->connector.
  */
+/* Tests for amdgpu_dm_encoder_init() */
+
+/**
+ * dm_test_encoder_init_success - Test encoder init wires id, crtc mask and helpers
+ * @test: The KUnit test context
+ *
+ * On a DRM device embedded in an amdgpu_device, amdgpu_dm_encoder_init()
+ * registers a TMDS encoder, derives possible_crtcs from mode_info.num_crtc,
+ * records the link index as the encoder id and attaches the helper funcs.
+ */
+static void dm_test_encoder_init_success(struct kunit *test)
+{
+	struct device *dev;
+	struct drm_device *drm;
+	struct amdgpu_device *adev;
+	struct amdgpu_encoder *aencoder;
+
+	dev = drm_kunit_helper_alloc_device(test);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dev);
+	drm = __drm_kunit_helper_alloc_drm_device(test, dev, sizeof(*adev),
+						  offsetof(struct amdgpu_device, ddev),
+						  DRIVER_MODESET);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, drm);
+	adev = drm_to_adev(drm);
+	adev->mode_info.num_crtc = 4;
+
+	/* Plain kzalloc: amdgpu_dm_encoder_destroy() kfree()s it on teardown. */
+	aencoder = kzalloc_obj(*aencoder);
+	KUNIT_ASSERT_NOT_NULL(test, aencoder);
+
+	KUNIT_EXPECT_EQ(test, amdgpu_dm_encoder_init(drm, aencoder, 2), 0);
+	KUNIT_EXPECT_EQ(test, aencoder->encoder_id, 2);
+	KUNIT_EXPECT_EQ(test, (int)aencoder->base.possible_crtcs, 0xf);
+	KUNIT_EXPECT_PTR_EQ(test, (const void *)aencoder->base.helper_private,
+			    (const void *)&amdgpu_dm_encoder_helper_funcs);
+}
+
 struct dm_test_atomic_check_ctx {
 	struct drm_device *drm;
 	struct amdgpu_encoder *aenc;
@@ -5863,6 +5900,7 @@ static struct kunit_case amdgpu_dm_connector_tests[] = {
 	KUNIT_CASE(dm_test_atomic_check_mst_duplicated_skips_pbn),
 	KUNIT_CASE(dm_test_atomic_check_mst_topology_err_propagates),
 	KUNIT_CASE(dm_test_atomic_check_mst_vcpi_error_propagates),
+	KUNIT_CASE(dm_test_encoder_init_success),
 	/* hdmi_cec_unset_edid */
 	KUNIT_CASE(dm_test_hdmi_cec_unset_edid_no_notifier),
 	/* create_eml_sink */
-- 
2.43.0

