Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66D0ACA1006
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Sep 2023 19:36:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B90C110E4A3;
	Tue,  5 Sep 2023 19:36:45 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2077.outbound.protection.outlook.com [40.107.223.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 206EE10E49E
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Sep 2023 19:36:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oT3ruMbkeRKtSgy7qjWQHTTpyQ/hBzN8MviWc8/JS2w1rVsC8vmofvjtyH/dzVg9FziP4gGy3z39kQNQSd+qtxAf+kliNOt65/I2knhyZ6lBCAPA+2a7CUxy8V9JMJIfI+QQHjaxtTaPxHd2gEMvAymPuf/Y11LX+d1KSXk7g9mXAgOVu5y00Zt/HlIL8YlRtmpD0QXv/aAOBknmUeV/8ManayAcWZmB5Yz9X+XtxRW4NRMnrpO3vtse0ZAm+q4hKBG8DExPTqsfv5MjDwdwvi8P05Nd396EbQwMmFNymjTyjH+MENdyvXykni4aXyWjcDVFeNsv8EIjWOxw+pXnDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XHlcrOxAI0iitwu9QOOQ1Yzzsz1Ot71yTA0y7Pqa55E=;
 b=kLv1Jhz+mxqaFfUDYpqt0lopScNPv+4DVOhPUDSZ5PxspW7RvC1Ihn4DmgGJRn2sLBXvIh1rSmpSNHfBSCbWc+T2wjGCuC8ceu2s9PZsaAbO1f5aCEy75ZlypUseaxFGCEnyr1XTNquY+8PrdP0mem5H8yb+CpurEvjD2ap4KujfijaI2BNM/r8tm0X/A0FzPzTQ2EKJ606eIW/blE6IlZh/GMcazJQKNE+u07AvO6ZtBH/HaIpjnjq/djdMCCFjbk6qz9e6EbZnJ8poyhGBC5aIQv01u8KUIH158/HfHgLJxT7mja/XkjvTZsq+1b8sctR3rdk8qPjDKaGyjrGNrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XHlcrOxAI0iitwu9QOOQ1Yzzsz1Ot71yTA0y7Pqa55E=;
 b=z0LB2dQZ3qp+pCBu6dhEp/Td6JHc459QXUNzc3bCmS++V1FItOG3o8clkGYlpRKqPke3LlFwfhVVUTcHMiB9Rkonzvw/Ak57zTWj0HHEJLa8J7eJYZ+QT3Ci6SdXIrPXHRuYFbyHiDtPqRnzWhHYwi43bbyNshRrb4SmseTTiG8=
Received: from SN6PR2101CA0029.namprd21.prod.outlook.com
 (2603:10b6:805:106::39) by SN7PR12MB7178.namprd12.prod.outlook.com
 (2603:10b6:806:2a6::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Tue, 5 Sep
 2023 19:36:39 +0000
Received: from SA2PEPF00001505.namprd04.prod.outlook.com
 (2603:10b6:805:106:cafe::99) by SN6PR2101CA0029.outlook.office365.com
 (2603:10b6:805:106::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.7 via Frontend
 Transport; Tue, 5 Sep 2023 19:36:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001505.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6768.25 via Frontend Transport; Tue, 5 Sep 2023 19:36:39 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 5 Sep
 2023 14:36:38 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/4] drm/amd: Move seamless boot check out of display
Date: Tue, 5 Sep 2023 14:25:58 -0500
Message-ID: <20230905192600.32449-3-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230905192600.32449-1-mario.limonciello@amd.com>
References: <20230905192600.32449-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001505:EE_|SN7PR12MB7178:EE_
X-MS-Office365-Filtering-Correlation-Id: 66da7bbe-1e84-413d-21d2-08dbae476cb2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uHU9NX/poSTM7rLbcyWVGmtKQtjAVy7uuKTtkQv/CXt/+cF/jpq5Sscn9PeJSehUbYiTicd78mVbelwx2wFNegg7PHnBfFhfsSJj3rHKXW4hB5O7EkJ+3fTj0e0o3I8NNNumJIWBLhClju3jDIvubLackg6Z6OYfPOjJisZF7ggXTNSghkoMBpLls/O1yVO308yIRf3KppvCpKIktitAUM0muw+0jp0/odB39AYxr1MvH/rpZRWTE/yAxPVhdmdSViOzfrGKI8KrVae9FNRlDgp+SGSbZQsiSjg13p7CQLom9Kp/SjWBJ2exe/pgEqGHKMox6QuVxpvpzizEXIXjSWVsAH2OKigfOnWA9tWumXIMhHwG32RxBEHRVhlX1XmUqDsNPa4jc0TFqsMn4FfepMp1caPgDJtQYxIxTJqNDYsjOByfPL0idw/5gd0ERech8H18ZlhFm0JeVhTLhSY7dS8WpqI6jTTJtyT6tMrA+Hqgl2+2NFzlc5M59GqLP07fq81VUecmpB488iNFQKiWASTNrOlHASrIhLE21NnAcPVxlR87CFwOkDxGsjagV1KqPdE2B321MV1p1Bko9ZKktmMHYbJfJX8N1EV4Gbg4BH8eJ5Hde0O4Mv/V69Nph0zDTT2pRFZELJ2RExd5F6iGGUFS+5d5sRvU+xpx/Y8J1kBLzRp/B66z1OuSVsL1hjnCSUG85dfAwgtZ4+OmXPx7KkklzHuCdwbxeZVEToTXKKp5G/Gx+JrwZYKoBrt2W2Z6R+6HIUdcL2n1zXALkdeMxA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(346002)(376002)(39860400002)(136003)(82310400011)(186009)(1800799009)(451199024)(46966006)(36840700001)(40470700004)(83380400001)(40460700003)(426003)(336012)(36756003)(81166007)(356005)(2906002)(82740400003)(36860700001)(40480700001)(47076005)(316002)(6916009)(41300700001)(70206006)(86362001)(70586007)(4326008)(7696005)(478600001)(6666004)(8936002)(8676002)(5660300002)(2616005)(1076003)(44832011)(16526019)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2023 19:36:39.1956 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 66da7bbe-1e84-413d-21d2-08dbae476cb2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001505.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7178
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
Cc: Mario Limonciello <mario.limonciello@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This will allow base driver to dictate whether seamless should be
enabled.  No intended functional changes.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    | 21 +++++++++++++++++
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 23 +------------------
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  2 --
 4 files changed, 23 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 1f846650cc8b..7fb282574fa3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1306,6 +1306,7 @@ void amdgpu_device_pci_config_reset(struct amdgpu_device *adev);
 int amdgpu_device_pci_reset(struct amdgpu_device *adev);
 bool amdgpu_device_need_post(struct amdgpu_device *adev);
 bool amdgpu_sg_display_supported(struct amdgpu_device *adev);
+bool amdgpu_seamless_boot_supported(struct amdgpu_device *adev);
 bool amdgpu_device_pcie_dynamic_switching_supported(void);
 bool amdgpu_device_should_use_aspm(struct amdgpu_device *adev);
 bool amdgpu_device_aspm_support_quirk(void);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index d45f5ea57583..72a5f77fc7b4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -1271,6 +1271,27 @@ bool amdgpu_sg_display_supported(struct amdgpu_device *adev)
 	return true;
 }
 
+/*
+ * Check whether seamless boot is supported.
+ *
+ * So far we only support seamless boot on select ASICs.
+ * If everything goes well, we may consider expanding
+ * seamless boot to other ASICs.
+ */
+bool amdgpu_seamless_boot_supported(struct amdgpu_device *adev)
+{
+	switch (adev->ip_versions[DCE_HWIP][0]) {
+	case IP_VERSION(3, 0, 1):
+		if (!adev->mman.keep_stolen_vga_memory)
+			return true;
+		break;
+	default:
+		break;
+	}
+
+	return false;
+}
+
 /*
  * Intel hosts such as Raptor Lake and Sapphire Rapids don't support dynamic
  * speed switching. Until we have confirmation from Intel that a specific host
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 1bb1a394f55f..8961e2ec3b51 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1675,7 +1675,7 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 
 	init_data.flags.seamless_boot_edp_requested = false;
 
-	if (check_seamless_boot_capability(adev)) {
+	if (amdgpu_seamless_boot_supported(adev)) {
 		init_data.flags.seamless_boot_edp_requested = true;
 		init_data.flags.allow_seamless_boot_optimization = true;
 		DRM_INFO("Seamless boot condition check passed\n");
@@ -10924,27 +10924,6 @@ int amdgpu_dm_process_dmub_set_config_sync(
 	return ret;
 }
 
-/*
- * Check whether seamless boot is supported.
- *
- * So far we only support seamless boot on CHIP_VANGOGH.
- * If everything goes well, we may consider expanding
- * seamless boot to other ASICs.
- */
-bool check_seamless_boot_capability(struct amdgpu_device *adev)
-{
-	switch (adev->ip_versions[DCE_HWIP][0]) {
-	case IP_VERSION(3, 0, 1):
-		if (!adev->mman.keep_stolen_vga_memory)
-			return true;
-		break;
-	default:
-		break;
-	}
-
-	return false;
-}
-
 bool dm_execute_dmub_cmd(const struct dc_context *ctx, union dmub_rb_cmd *cmd, enum dm_dmub_wait_type wait_type)
 {
 	return dc_dmub_srv_cmd_run(ctx->dmub_srv, cmd, wait_type);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index a2d34be82613..4c74245add90 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -825,8 +825,6 @@ int amdgpu_dm_process_dmub_aux_transfer_sync(struct dc_context *ctx, unsigned in
 int amdgpu_dm_process_dmub_set_config_sync(struct dc_context *ctx, unsigned int link_index,
 					struct set_config_cmd_payload *payload, enum set_config_status *operation_result);
 
-bool check_seamless_boot_capability(struct amdgpu_device *adev);
-
 struct dc_stream_state *
 	create_validate_stream_for_sink(struct amdgpu_dm_connector *aconnector,
 					const struct drm_display_mode *drm_mode,
-- 
2.34.1

