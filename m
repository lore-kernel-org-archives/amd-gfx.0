Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0547C636D4
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Feb 2023 15:25:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 38D5D10E7F7;
	Fri,  3 Feb 2023 15:25:39 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2062.outbound.protection.outlook.com [40.107.96.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A11D510E7F7
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Feb 2023 15:25:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KVVi5e8sbqfK0QrHEHmzbG+JpG0CdqeHSYFPVwhE0JfiALLuYEBKODkpcR+Nfp4+rjm4LMTJpXHnHAukMvo8fjb/p+9H4kwc1PEbWZszLy+7NIm0r4eU/BTQMQG1Go1g29omkfb0ksF9HZUpvOqVFEWc5j8+oECHvP9/EFupF0863k6sFSzOXS3MbLYTSTxWHCLrUpDt6kcML3n6c9ooRWryEHMJQKbSPf9zSia5EKIr5RAZzltaWh2cMJZaO1UCDH/O8prwLgjGA/67VYMr9qVX8CkNGGN6A/4lfiZTxGfFj+Hw6tNBDvChXEBPMMxNBuKOsy9jIlHH7Fb0v0v/cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J+aKeXC1bNGUHDJBml3emKDBK28hdRjXr1p14rCsP6w=;
 b=dxuFmDOak/1ezz3Hycirtm7SssfJW8mfvpelfLJ06lfI0Ak4LZ1Ze8IoAykFYoDPyhdZdigcD0sC1uYvRdzY6SQst7VDz7fJqhKFouMZKqggxVSJU4mKNU1EILdLJHTIE0yJiIpZMA/o3sMpPuPWLgQHDQdhzYHatlNNfNr5fEX/Qmx9hB4HqxDWNhTMviDkt2iirtKXz9tSdlUba6fQqgyk7Ce2OEphtALn9tcv7tyNLU1qhOWUgaobY6p1MO1Gh1M7rlidsT0wVrHbBbuCwBOJWPxqXmPEXDCkYGf79kmc0aLxB4A41gABepop2EaoDhW/0AWm/8ODDg8uJQifuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J+aKeXC1bNGUHDJBml3emKDBK28hdRjXr1p14rCsP6w=;
 b=u7gqmU4V55IOnvC54BktqMRZjzs7A9K2bspOTPagl0QbLpVoSepssn9/3htWAHIjQLeT2YVp5sWnffhktg39cXd+XRkcV/KNVj8hhrCywShmqcwjzLx2nnT0qhGCwqvn8AzAsK52o08GQmYzBtQymHBZ7iQ6zYawTagIm6YpWVM=
Received: from MN2PR03CA0016.namprd03.prod.outlook.com (2603:10b6:208:23a::21)
 by DM4PR12MB5940.namprd12.prod.outlook.com (2603:10b6:8:6b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.22; Fri, 3 Feb
 2023 15:25:32 +0000
Received: from BL02EPF0000C407.namprd05.prod.outlook.com
 (2603:10b6:208:23a:cafe::e9) by MN2PR03CA0016.outlook.office365.com
 (2603:10b6:208:23a::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.31 via Frontend
 Transport; Fri, 3 Feb 2023 15:25:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0000C407.mail.protection.outlook.com (10.167.241.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6064.17 via Frontend Transport; Fri, 3 Feb 2023 15:25:31 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 3 Feb
 2023 09:25:27 -0600
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 05/12] drm/amd/display: Add HDMI manufacturer OUI and device
 id read
Date: Fri, 3 Feb 2023 10:24:45 -0500
Message-ID: <20230203152452.1441747-6-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230203152452.1441747-1-qingqing.zhuo@amd.com>
References: <20230203152452.1441747-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0000C407:EE_|DM4PR12MB5940:EE_
X-MS-Office365-Filtering-Correlation-Id: 488b75eb-a85b-4b99-75b3-08db05fae32c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PC20DbEQuUiLP4t3adPeVPMbfctwKwTsgjK2ctu6sbQKdCsmbDDCBSLy4ztlOFO8Rkl0I7HXQTFXYhJkJTgFjan1Uh0zORfKILCuOJq1Q91QvRnFC4zA8LW1Itw+ufZ7AO/0vMNneILi97IQX//W55CxVn/wU/TeB4yvrWOeGDdmC9tliOp9dcB7ztYtFbhVwMCvgT4MCdQ+9F/bWGhw5uD2ZhPCgctuSoEMEu+uOtBM7qPM+Kaw1ppazWVXhkMOnBaNP+CLF4cINwQGlkCnUxFnEvY1CS4nfb6FFRvaycYZd2cvY3CRx8t0RWx4XmiydWyHuZ0xCrSRWt0IxK11RjjFLmigUmkRb3R0OWlHpec5VvIkLAUocWGXjTK7NFX9ELXiCy83SfyB65jOtGyOsWzvs3hvW92iPx77SpWWmhm9MBNFjEXtzn0+kWWxyYMcpTEl0YbZsj+fLX9tZ8sycG7BiCFv/tMqCPDApFEmpw0lctC+I5/dGhbIxCqHt1ic6Bx1n/EVmtYGoSXuJBvhY7AnS9MzaSkVfmoiKSIbgxZn6zmq/RXYsXcGJEcU3JbiRTh9kvc2pe+fI5qncXls1Kel3oNbSM539zY0VFpky03WoEKR0R72ouLXlIfwS9CUZhPzIzGRMX+N+4Ev4i11n4EBrNzzJdmw+iIUi+cAER0Te1XZlzBA0OqkAiznY1ei37Wl3yDL72AWZctQ4RMxPU+qe9zmSWNawiT12u4D1Vw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(396003)(346002)(39860400002)(136003)(376002)(451199018)(46966006)(40470700004)(36840700001)(186003)(26005)(356005)(2616005)(81166007)(1076003)(47076005)(36756003)(6666004)(86362001)(36860700001)(83380400001)(336012)(426003)(478600001)(54906003)(16526019)(4326008)(316002)(70586007)(5660300002)(8676002)(41300700001)(82740400003)(70206006)(44832011)(2906002)(8936002)(6916009)(82310400005)(40480700001)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2023 15:25:31.2955 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 488b75eb-a85b-4b99-75b3-08db05fae32c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0000C407.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5940
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 Wenjing Liu <Wenjing.Liu@amd.com>, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 "Leo \(Hanghong\) Ma" <hanghong.ma@amd.com>, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: "Leo (Hanghong) Ma" <hanghong.ma@amd.com>

[Why && How]
Add support to read manufacturer OUI
and device id from HDMI SCDC.

Reviewed-by: Wenjing Liu <Wenjing.Liu@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Leo (Hanghong) Ma <hanghong.ma@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 17 ++++++++++++++++
 drivers/gpu/drm/amd/display/dc/dc.h           |  6 ++++++
 .../gpu/drm/amd/display/dc/dc_hdmi_types.h    | 20 +++++++++++++++++++
 3 files changed, 43 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index 6475664baa8a..ce1b6cbb1817 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -1045,6 +1045,20 @@ static void verify_link_capability(struct dc_link *link, struct dc_sink *sink,
 		verify_link_capability_non_destructive(link);
 }
 
+static void read_scdc_caps(struct ddc_service *ddc_service, struct dc_sink *sink)
+{
+	uint8_t slave_address = HDMI_SCDC_ADDRESS;
+	uint8_t offset = HDMI_SCDC_MANUFACTURER_OUI;
+
+	link_query_ddc_data(ddc_service, slave_address, &offset,
+			sizeof(offset), sink->scdc_caps.manufacturer_OUI.byte,
+			sizeof(sink->scdc_caps.manufacturer_OUI.byte));
+
+	offset = HDMI_SCDC_DEVICE_ID;
+
+	link_query_ddc_data(ddc_service, slave_address, &offset,
+			sizeof(offset), &(sink->scdc_caps.device_id.byte), sizeof(sink->scdc_caps.device_id.byte));
+}
 
 /**
  * detect_link_and_local_sink() - Detect if a sink is attached to a given link
@@ -1288,6 +1302,9 @@ static bool detect_link_and_local_sink(struct dc_link *link,
 		if (sink->edid_caps.panel_patch.skip_scdc_overwrite)
 			link->ctx->dc->debug.hdmi20_disable = true;
 
+		if (dc_is_hdmi_signal(link->connector_signal))
+			read_scdc_caps(link->ddc, link->local_sink);
+
 		if (link->connector_signal == SIGNAL_TYPE_DISPLAY_PORT &&
 		    sink_caps.transaction_type ==
 		    DDC_TRANSACTION_TYPE_I2C_OVER_AUX) {
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 2e23fd8b4e9f..cbb94c8ba9de 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -1505,6 +1505,11 @@ struct dc_sink_fec_caps {
 	bool is_topology_fec_supported;
 };
 
+struct scdc_caps {
+	union hdmi_scdc_manufacturer_OUI_data manufacturer_OUI;
+	union hdmi_scdc_device_id_data device_id;
+};
+
 /*
  * The sink structure contains EDID and other display device properties
  */
@@ -1518,6 +1523,7 @@ struct dc_sink {
 	struct stereo_3d_features features_3d[TIMING_3D_FORMAT_MAX];
 	bool converter_disable_audio;
 
+	struct scdc_caps scdc_caps;
 	struct dc_sink_dsc_caps dsc_caps;
 	struct dc_sink_fec_caps fec_caps;
 
diff --git a/drivers/gpu/drm/amd/display/dc/dc_hdmi_types.h b/drivers/gpu/drm/amd/display/dc/dc_hdmi_types.h
index faf0d175bf19..c364744b4c83 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_hdmi_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_hdmi_types.h
@@ -69,6 +69,9 @@ static const uint8_t dp_hdmi_dongle_signature_str[] = "DP-HDMI ADAPTOR";
 #define HDMI_SCDC_ERR_DETECT 0x50
 #define HDMI_SCDC_TEST_CONFIG 0xC0
 
+#define HDMI_SCDC_MANUFACTURER_OUI 0xD0
+#define HDMI_SCDC_DEVICE_ID 0xDB
+
 union hdmi_scdc_update_read_data {
 	uint8_t byte[2];
 	struct {
@@ -111,4 +114,21 @@ union hdmi_scdc_ced_data {
 	} fields;
 };
 
+union hdmi_scdc_manufacturer_OUI_data {
+	uint8_t byte[3];
+	struct {
+		uint8_t Manufacturer_OUI_1:8;
+		uint8_t Manufacturer_OUI_2:8;
+		uint8_t Manufacturer_OUI_3:8;
+	} fields;
+};
+
+union hdmi_scdc_device_id_data {
+	uint8_t byte;
+	struct {
+		uint8_t Hardware_Minor_Rev:4;
+		uint8_t Hardware_Major_Rev:4;
+	} fields;
+};
+
 #endif /* DC_HDMI_TYPES_H */
-- 
2.25.1

