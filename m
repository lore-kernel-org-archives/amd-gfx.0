Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 161F0EE01F4
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Sep 2023 17:15:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A5BF410E4C2;
	Wed, 13 Sep 2023 17:15:29 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 85F1910E4CE
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Sep 2023 17:15:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IV1Trz/Z6GnZEhjSPTwhfCJSUBS+NoRqiTfK8XIq6gF+O3dI1Dsv3ksm4KcNJhVDhS2SRcwjbecQJpKqf0gIrfEToEUg+LBz6i04Q3SDe0o7UNBjBneyeiMbBZ3mTNSvmN0Lf1vZtb3W5ZhgMQsjAvU5madruZkiSCi05CKj5LjvV/h0w/8JKdGyKWob/cfaVMJaYhegV/JL7P1DsUE48HqkQEHXsux/bVv4furERH9zv8Q01eMdjI9HiFG7SeHFGi6LEFKv7H16zy2SszfjnRZeS1gsbOR5ueKwWEqsG4a3UXcpZwg1SZiUxjsQh0OrMX/3RLvi/4KjL50+e2oong==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qj4X4VdkOVUpxBnNeN58XAogd6HhoxrBq02b3+yU5Wo=;
 b=GFiPOkLmo2tFAWR4b9NlLLxcfRsMD4ccIUoWnBOx/URtwv6aoY2gwlbYhVG1liE1aO1KWGGmAywX+83dem16D32V9k6KmZO0wYhUZDTOD7RXOXiBp3xEyp0MCCpHVOfHYT9l/4bKve2/TeXZNEuv96OpYgszkVdRGAAofDZ9hrtE8r2gd9fqrFwwcdojOyzKRxkMzeSPmW0wlVpjF2bPIsQfFZCJeIJpXFjIDN4Z+s/Pmw8abPrfPmzM1h/0JnS+0rpqg+yAqw7tumjHtU8NlE0gWmL3EW5/82G2+mMz3K2WXID5Ynwvi4h2SAl+RQwcWSubIWqZZMjVZ6x62O2Cgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qj4X4VdkOVUpxBnNeN58XAogd6HhoxrBq02b3+yU5Wo=;
 b=HnU2SFqugHn+/1lameRfFhmMS+UoCMerWWydFPisndv0AyG7T9kEkIHvofJf0TZ+JLNZE1UljzqABeqeEDa4hmoGxiA2ZQ1xwfBo6RhBflE4eTDBrKEHVn9mioSqKp11YnrH+1IuNBFyKQBILei27wRNJlYcp9yZSlw337dPa+E=
Received: from DM6PR13CA0045.namprd13.prod.outlook.com (2603:10b6:5:134::22)
 by DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.40; Wed, 13 Sep
 2023 17:15:26 +0000
Received: from DS1PEPF0001708F.namprd03.prod.outlook.com
 (2603:10b6:5:134:cafe::ca) by DM6PR13CA0045.outlook.office365.com
 (2603:10b6:5:134::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.19 via Frontend
 Transport; Wed, 13 Sep 2023 17:15:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0001708F.mail.protection.outlook.com (10.167.17.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Wed, 13 Sep 2023 17:15:26 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 13 Sep
 2023 12:15:25 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 2/4] drm/amd: Move seamless boot check out of display
Date: Wed, 13 Sep 2023 12:14:53 -0500
Message-ID: <20230913171455.153412-3-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230913171455.153412-1-mario.limonciello@amd.com>
References: <20230913171455.153412-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001708F:EE_|DM4PR12MB5040:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b42ff90-a649-4c56-8980-08dbb47d05c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yf0VBfYut0jrf5xWYeqdwKxvBDSZIUCNusfTsJmPQEdUQPlFyq+0hyCnjgJJ3ozMXvo9E7J8HPau8xLTNN3eJh+KunMYXzywOmxzjxBMYdiZBAobI4KkhjZrf379OGvvbxtgjBlqxZvwcgR3U5SVRuxay4JQB6D2ITTULNj0Ql4Mty5vrysbzv7ISHST2CSn3lMMlMu9ti5CkzgrLBHYf9xTv9+pXaTrFBWIAlsvBonBHHjbjqwcAxmTUrRQj96GGtnytWH/3F8YcYx8RZ7smDhYGciqcx3r/s/Y8UIT5F2pUoonYGXLHiwteehSHnb/gddNXI9tSU+2G/HqObyontC3Oq9W0giOM2EWfKn3ljZCaLC5caAuHbJuAj1KqXerww6HKDPLIxcEORzChZ4HVW/XP4wAkM9tAb8mWgAkpyZZSpb2yVzK45U3rvgtrpf73kDFePIGczIRj2HMLOXG0Fdn6pcRY/vvnFUqjJIBOv8Ng8lpG2yOuePCMcdyRg18FKMGlFzKkIUuumk0pBr7sIEd8nkjQzj0pFmTfNfhwjZpZznR3Y/nluT6TvAg/y2DzXDqFoTC7q3ttgip+Ukut2OJPmGiMMwAB5prH2b5McDUr11furtW/d9M+N0N6Huko2HWBOjkF9zcFBfHknjl3VwJPThHbLHM5A1NEEKgjkBUaCvwNC+1DlV7cZKah52cYMeX4KVWQvkbrLxagX1aOJDntF+ztVr0/4ipL1BF9I1xh3+M7Ksd8SjuE8o6/OWUQz9Oj75ViOMSbLCnnHwoJQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(376002)(396003)(39860400002)(136003)(186009)(82310400011)(451199024)(1800799009)(36840700001)(40470700004)(46966006)(5660300002)(8936002)(7696005)(8676002)(4326008)(44832011)(41300700001)(478600001)(316002)(70586007)(70206006)(6666004)(2906002)(6916009)(54906003)(47076005)(1076003)(336012)(426003)(26005)(2616005)(16526019)(36860700001)(83380400001)(36756003)(40480700001)(81166007)(356005)(82740400003)(40460700003)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2023 17:15:26.3019 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b42ff90-a649-4c56-8980-08dbb47d05c5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001708F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5040
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
Cc: alexander.deucher@amd.com, harry.wentland@amd.com,
 Mario Limonciello <mario.limonciello@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This will allow base driver to dictate whether seamless should be
enabled.  No intended functional changes.

Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    | 21 +++++++++++++++++
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 23 +------------------
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  2 --
 4 files changed, 23 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 30f44db6c9c5..38a10d6be921 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1327,6 +1327,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 void amdgpu_device_pci_config_reset(struct amdgpu_device *adev);
 int amdgpu_device_pci_reset(struct amdgpu_device *adev);
 bool amdgpu_device_need_post(struct amdgpu_device *adev);
+bool amdgpu_device_seamless_boot_supported(struct amdgpu_device *adev);
 bool amdgpu_device_pcie_dynamic_switching_supported(void);
 bool amdgpu_device_should_use_aspm(struct amdgpu_device *adev);
 bool amdgpu_device_aspm_support_quirk(void);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index ca56b5a543b4..7187eeb8ffa6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -1358,6 +1358,27 @@ bool amdgpu_device_need_post(struct amdgpu_device *adev)
 	return true;
 }
 
+/*
+ * Check whether seamless boot is supported.
+ *
+ * So far we only support seamless boot on select ASICs.
+ * If everything goes well, we may consider expanding
+ * seamless boot to other ASICs.
+ */
+bool amdgpu_device_seamless_boot_supported(struct amdgpu_device *adev)
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
index 933c9b5d5252..725fad6c8efe 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1680,7 +1680,7 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 
 	init_data.flags.seamless_boot_edp_requested = false;
 
-	if (check_seamless_boot_capability(adev)) {
+	if (amdgpu_device_seamless_boot_supported(adev)) {
 		init_data.flags.seamless_boot_edp_requested = true;
 		init_data.flags.allow_seamless_boot_optimization = true;
 		DRM_INFO("Seamless boot condition check passed\n");
@@ -10997,27 +10997,6 @@ int amdgpu_dm_process_dmub_set_config_sync(
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
-	switch (amdgpu_ip_version(adev, DCE_HWIP, 0)) {
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
index 9e4cc5eeda76..3d480be802cb 100644
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

