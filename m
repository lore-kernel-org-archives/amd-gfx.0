Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14666C27C55
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Jun 2024 06:02:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 853E510E285;
	Fri,  7 Jun 2024 06:02:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SGsCj5/V";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2086.outbound.protection.outlook.com [40.107.220.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8271E10E126
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Jun 2024 06:02:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V6qrPWIIdLpgiQsqvPtr5Wq75V3zoJkc9fHZ1w0YsVLMSM1VwRm9hUNNXJS3Yf8V9cyfS67zDj5vPImjbcTy6YRtA2MzHocBHQ4eUHg1s9N6tAtpppyD/YSGU48yTn5tXbPbAxoBPe9w0J0l3G6P/+zZwj4ByaoS3nzgAg7guU7zI4ANlebNThO3IxIzQLOI+f040+ahPIXyWOLWJCkjWy+DkGREDbQZeDjroKt9TrL0Xl6MAz3Ap89yzvTQZq3T47qpLP9onAKNvVAue+YOoudJCD36JtJ3w2t4tq9EfCYVfzs60BzbHAbzVMMwYxfn++BuMrIHdSG/FmSKlzdo+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yVsGgVNlmbdmsAO4qjJlg+2s2ks25UyLkvqqwapmZJU=;
 b=kMKSK1QW4qs4e69JbdpUoTHATMZDoOMXr1HnWv/vTihZwyvICwMjD/u5eomSDmTU/qDTq6ptExhcENrR1pW83mdPbEpEpdebj8gtS+NXe52dMOGS1hkp0hoq3hNKHvPvPE/541zAhE8kXYHb+FjxrswqRuKnjGlPIKYa1qlGfAfeJ7rZmTqC6ujfqLqf2+E8MSb4cJTXe4HsvjimEjceUBXQ9+9rzemepdZgGt/zpJxC49OjRoz37xnvTdgAYm/0AEunALni3K4duPgLS8/9jOpzUXMsuOHPKDVtPESUtdnllF9LbISDvhPDDA4tBk2AJNTA4Mj9nMIPkZJ2713cJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yVsGgVNlmbdmsAO4qjJlg+2s2ks25UyLkvqqwapmZJU=;
 b=SGsCj5/VzsIug8Mrb/PB03Em7d/kzi3f8SAcyS58pMgH7lyFVm+RDE/RwRGFnrZ6susseMZGGaiIMbNfwX4Eow/1GSgd7wHqYgwlEju6SiR232Z/JdvTLjZSXaIULH4WxUXmOPl8efvOFRiqZ04KdaFsHFndL1zFQzCOFW+k/Yk=
Received: from BN0PR04CA0042.namprd04.prod.outlook.com (2603:10b6:408:e8::17)
 by MW4PR12MB7309.namprd12.prod.outlook.com (2603:10b6:303:22f::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.25; Fri, 7 Jun
 2024 06:02:47 +0000
Received: from BN1PEPF0000468D.namprd05.prod.outlook.com
 (2603:10b6:408:e8:cafe::f9) by BN0PR04CA0042.outlook.office365.com
 (2603:10b6:408:e8::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.31 via Frontend
 Transport; Fri, 7 Jun 2024 06:02:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF0000468D.mail.protection.outlook.com (10.167.243.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Fri, 7 Jun 2024 06:02:46 +0000
Received: from SITE-L-T34-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 7 Jun
 2024 01:02:44 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <Harry.Wentland@amd.com>, Mario Limonciello
 <mario.limonciello@amd.com>
Subject: [PATCH] drm/amd/display: Set default brightness according to ACPI
Date: Fri, 7 Jun 2024 01:02:28 -0500
Message-ID: <20240607060228.509050-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468D:EE_|MW4PR12MB7309:EE_
X-MS-Office365-Filtering-Correlation-Id: 4668cff2-c7bd-4774-da0b-08dc86b77449
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400017|36860700004|1800799015|376005; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?0Tcv4/Yw1PjsUz9pE5nIzcjE+NeBKtiIZNME8yPyibj9LLCXu/lvf9DTDNVt?=
 =?us-ascii?Q?7nlBYUWnIR7/WbI8s7WTnDsVAi/h05/DMUkm8dvkWpPnpJP4uq1m1AdBTfty?=
 =?us-ascii?Q?X1IGjKMcfwWyL2Il+09KFCx0ZDhzyTxKAarlND7UwC37HIoj2eK5hieIwKOd?=
 =?us-ascii?Q?IWl4sFfJx1Qkpi6tvkF2nmuZs6D/rSYygHRp/bL7sUTK1QylfjCus3MMBwHl?=
 =?us-ascii?Q?w24u+mWefs+9/8wI7Hbg7+hl2EJD6DlZuW8W4CsaRpgP6ZMLD1bD7K1KNtkD?=
 =?us-ascii?Q?5+mvgXgG6acN9s+s4Fec2kt6rNUSjKpf9NSbkv/255VnHS2PsFUQffeQoDLq?=
 =?us-ascii?Q?cvUjZo/FbxCiR8wOO2QoMuj1wGpZBzw7mUZQHffgqwhloZL+ZFYVtRWOmuzX?=
 =?us-ascii?Q?da4/tmu9PUfrTe/7jmFicWdWC2UuUv7Qu6aPvnzZuvwhpgiv9eiqZUhh1LSG?=
 =?us-ascii?Q?wECCQ57+2vko+YCR0LmFM0xb7EoKOWRYm3x6djb8oKA+2G2kInN1KFYbh5B/?=
 =?us-ascii?Q?GIOhL4d9tHIeb73PBOgXLQyMfJCcuv1Yt8ISFVTmOYdE7xpFxEOj9daIiN0t?=
 =?us-ascii?Q?T7f8ECxPsF9B97hpFk1RtcugSFe1FBbxGIw08tx7d+E9dSzSSnFukSEVLck9?=
 =?us-ascii?Q?b7UcOFBOjAxdu+I8TWshIs5FXA7gKGrk5PTZFnIpeHk2+d6ZPU2Iesmr27z+?=
 =?us-ascii?Q?46PtCs1dfxvwFTturZbyBhOXHkeooggkr7vrmmBu5T7rK8MODJL0/zYjAWJP?=
 =?us-ascii?Q?hKJLWQF7ICfNh/iCsFHURAe7/Pdupj+pIWFV2VCB0U32MBEFMckNwk94wEnJ?=
 =?us-ascii?Q?AfHWRWpymVIhVWzO993Z55TzSOoMWC5i4SnS8e+TMstdZ8aWm3tdMFkkXkom?=
 =?us-ascii?Q?i8/nr6+lXSL/lSwhsFDliROsywzoxWDovNdNi1UjtqBh9745vXB4TCANEy0z?=
 =?us-ascii?Q?zV7vHlzIjj1SfNufu06KmgWHAEQyLgJgal6qjxmhSIPjMktuZqC1TMFaw7v2?=
 =?us-ascii?Q?m5LUPCLLJhMF54wR8yNvaatChFcnWym6ZP5vv7YcoJypxpnaltQT5d0y5SsE?=
 =?us-ascii?Q?8yYoxR2VHNN9fpGC/XLr70Li/dg6ScNco7qG8zh8edz2cIperFi6Dc/1FmNT?=
 =?us-ascii?Q?CIf0HvJFP4jpMDYodi8TLJ3rjRQe3yH+XnX7r7zBWvcTqtsxHlWHsHeUm4kb?=
 =?us-ascii?Q?X4DOh/rI6w7ZsLLoIcUeGFi+1H6CTFtG67cjCqI6ZM0mmKL5usRc6AXmui4Y?=
 =?us-ascii?Q?qxUNhIoXrj6T+w7JorO1Q9+x18RtFTdddzkHi1zIUkHGQI4XHiBYrXtaErdB?=
 =?us-ascii?Q?oc9bEyjkL1HTtUJOd7mC+9HYY39NW5sNUrvjvHuamNs4/dX6TBSmFIYSN5XY?=
 =?us-ascii?Q?MJbjRz4hsqhO2WeN5XilpXyMBRvNittiWPpBo/3WNI8adCyMgQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400017)(36860700004)(1800799015)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2024 06:02:46.7120 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4668cff2-c7bd-4774-da0b-08dc86b77449
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000468D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7309
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

Currently, amdgpu will always set up the brightness at 100% when it
loads.  However this is jarring when the BIOS has it previously
programmed to a much lower value.

The ACPI ATIF method includes two members for "ac_level" and "dc_level".
These represent the default values that should be used if the system is
brought up in AC and DC respectively.

Use these values to set up the default brightness when the backlight
device is registered.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c          |  4 ++++
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 12 +++++++++++-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  8 ++++++++
 3 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
index 7099ff9cf8c5..f85ace0384d2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
@@ -383,6 +383,8 @@ static int amdgpu_atif_query_backlight_caps(struct amdgpu_atif *atif)
 			characteristics.min_input_signal;
 	atif->backlight_caps.max_input_signal =
 			characteristics.max_input_signal;
+	atif->backlight_caps.ac_level = characteristics.ac_level;
+	atif->backlight_caps.dc_level = characteristics.dc_level;
 out:
 	kfree(info);
 	return err;
@@ -1268,6 +1270,8 @@ void amdgpu_acpi_get_backlight_caps(struct amdgpu_dm_backlight_caps *caps)
 	caps->caps_valid = atif->backlight_caps.caps_valid;
 	caps->min_input_signal = atif->backlight_caps.min_input_signal;
 	caps->max_input_signal = atif->backlight_caps.max_input_signal;
+	caps->ac_level = atif->backlight_caps.ac_level;
+	caps->dc_level = atif->backlight_caps.dc_level;
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 5fd7210b2479..71aa0c518951 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -77,6 +77,7 @@
 #include <linux/types.h>
 #include <linux/pm_runtime.h>
 #include <linux/pci.h>
+#include <linux/power_supply.h>
 #include <linux/firmware.h>
 #include <linux/component.h>
 #include <linux/dmi.h>
@@ -4321,6 +4322,7 @@ amdgpu_dm_register_backlight_device(struct amdgpu_dm_connector *aconnector)
 	struct drm_device *drm = aconnector->base.dev;
 	struct amdgpu_display_manager *dm = &drm_to_adev(drm)->dm;
 	struct backlight_properties props = { 0 };
+	struct amdgpu_dm_backlight_caps caps = { 0 };
 	char bl_name[16];
 
 	if (aconnector->bl_idx == -1)
@@ -4333,8 +4335,16 @@ amdgpu_dm_register_backlight_device(struct amdgpu_dm_connector *aconnector)
 		return;
 	}
 
+	amdgpu_acpi_get_backlight_caps(&caps);
+	if (caps.caps_valid) {
+		if (power_supply_is_system_supplied() > 0)
+			props.brightness = caps.ac_level;
+		else
+			props.brightness = caps.dc_level;
+	} else
+		props.brightness = AMDGPU_MAX_BL_LEVEL;
+
 	props.max_brightness = AMDGPU_MAX_BL_LEVEL;
-	props.brightness = AMDGPU_MAX_BL_LEVEL;
 	props.type = BACKLIGHT_RAW;
 
 	snprintf(bl_name, sizeof(bl_name), "amdgpu_bl%d",
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index b246e82f5b0d..df72cb71e95a 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -173,6 +173,14 @@ struct amdgpu_dm_backlight_caps {
 	 * @aux_support: Describes if the display supports AUX backlight.
 	 */
 	bool aux_support;
+	/**
+	 * @ac_level: the default brightness if booted on AC
+	 */
+	u8 ac_level;
+	/**
+	 * @dc_level: the default brightness if booted on DC
+	 */
+	u8 dc_level;
 };
 
 /**
-- 
2.43.0

