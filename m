Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 514CEC3ABBC
	for <amd-gfx@archiver.kernel.org>; Wed,  7 May 2025 02:43:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ECB2510E739;
	Wed,  7 May 2025 02:43:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XgL7a4ej";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2064.outbound.protection.outlook.com [40.107.95.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA01910E736
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 May 2025 02:43:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=es/xF3cJDUGtITfTMQttzHIn845vJ+FJ0U4JaaKYC2raQNha6RXev8lYyBIe9eH6tjumSvbs+tW5XWF6jZ/Dj49ZYvTE9iZZ6aBxnezbKMT/KKdX7x/6EpWB0uU06DsE4Yh8ypAFAY6hskIY2hS0Dvt9wyVmW5QISgMLC8jWdMF+5MySX7+gMpC0ilKkeRBSaJAlVfN0UKcoKtKlXPSEjDO5XqcVGnI4LJl6G3SrVnDHbyWEBAQQ5X77CTlIJFthbWKvggPN+An1Z6IQxEz9bkr7YbZ7mkcZO7O7r67vMo5M+wwrQtSAJ0pOvCJXtNLqe1EgC94g0ikIDr+Y05SKsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U3bYyDJ7e64qStZU35PA6mJo1iTaGjDjcFlbTs4y6+k=;
 b=vK+i2KJDuTnU4zhR0yZFFi9w3pzowAfPC8aAxN8ULQI0hpEmU8hSGVUTLTKDEk0u0NQBONVzwevQYRBG01qqqKZXCOBhMKwHBh8s32OL1+6Q05jkvFtXVLtIrTiXw/uG7KjuAQk5XMx8M1DxN06rdnqirA4uDbG0jiJt17Z8tdkTENDgMtWPjoyHQTJoKliE2lIXxLRx1nmyfsNe+iNmhcKyoUeTyAtDWX6gFTG9FlVkBl3fZMGnGv1SPd+8Mc7AYuW96wuEu4G24mjw239iA9HygHFQ1A0UN+DCB510czHiNH3mWlLVDR2qagKy/WJyAX4CQu92+3e+xREUMJLTwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U3bYyDJ7e64qStZU35PA6mJo1iTaGjDjcFlbTs4y6+k=;
 b=XgL7a4ejCAcQXJjHWWpU9Yy28a7XE3qhoJc1uB0mskczcFhOMcVGT2i5YAshdj0pKAHf4Y+IogfD94Fu0qY+A+GU1DPRE954pR8TcRetCL0fMTEylCEjEkQUqKa71PSwLhdVu20c5KxFYBlxvqlImti7ZoZ7oYLgLI84csq0My4=
Received: from MW4P221CA0021.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::26)
 by MN2PR12MB4175.namprd12.prod.outlook.com (2603:10b6:208:1d3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Wed, 7 May
 2025 02:43:44 +0000
Received: from SJ5PEPF000001EA.namprd05.prod.outlook.com
 (2603:10b6:303:8b:cafe::84) by MW4P221CA0021.outlook.office365.com
 (2603:10b6:303:8b::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.31 via Frontend Transport; Wed,
 7 May 2025 02:43:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ5PEPF000001EA.mail.protection.outlook.com (10.167.242.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Wed, 7 May 2025 02:43:43 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 6 May
 2025 21:43:41 -0500
Received: from ray-Ubuntu.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 6 May 2025 21:43:38 -0500
From: Ray Wu <ray.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, "Daniel
 Wheeler" <daniel.wheeler@amd.com>, Alex Hung <alex.hung@amd.com>, "Mario
 Limonciello" <mario.limonciello@amd.com>, Ray Wu <ray.wu@amd.com>
Subject: [PATCH 08/14] drm/amd/display: Restructure DMI quirks
Date: Wed, 7 May 2025 10:34:52 +0800
Message-ID: <20250507024242.1928299-9-ray.wu@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250507024242.1928299-1-ray.wu@amd.com>
References: <20250507024242.1928299-1-ray.wu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: ray.wu@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EA:EE_|MN2PR12MB4175:EE_
X-MS-Office365-Filtering-Correlation-Id: 896e8cf5-1323-4821-9420-08dd8d10fb7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?T7y6h2zEcq0C5hCK3WodX3hzu3sv8CRixtoAzlsAJnOl94ln7OjHARKEkDMW?=
 =?us-ascii?Q?QRQqugfxql30tRxgH96U+C0b9QIqBEn885lS39tTL2sXY4O2XJ1E+iOrAqUz?=
 =?us-ascii?Q?53O2QkaOHAcCljt1fOWocD2o2SsC8ry1Wxz2ZjB6LbnQ1kqHLypGsYSUFDG+?=
 =?us-ascii?Q?XeYQcOHm2QBpt5BJNZXm2sCSlPSUDuFPsfOFX3kd8Hq6CNPG91nkPecFOHIx?=
 =?us-ascii?Q?fohEAIdX3Ed7Pa2lixweQRRKb+CmtyqggKWxpdxrOfWai3lK6AjxVuG5C4LH?=
 =?us-ascii?Q?XGw+NNnShSyUdpPr5opIENEI/ol78oOsQ0CN9yLntU5f2bpPFZqpAoCjl5fv?=
 =?us-ascii?Q?H5lBpPrMlqbcBQrp1ZrrePv6JIdYF79RArnrAFORsN5D6Cs+zUrhC49Ra5AI?=
 =?us-ascii?Q?ySSjX53BjQNgYsbj0BV497Y7LTmK36SYMSiyiN5pFTOgPSzuje7gYUowxJ7y?=
 =?us-ascii?Q?tv9jFySCRHd/XR3j//8szrCjQjHNfBaypJy4ai8qGc6RsJflc0bTMZfuFC2B?=
 =?us-ascii?Q?uJOR66IjnjGrupRBt9i7m0kn7/yEibhCFzR8blrWFgfI7EQx0SzOmlG27W+w?=
 =?us-ascii?Q?JwFpzS8K3V8/WW03SUjrcIZHRb08w1uNx7Els/Au4hfrRRre0xcjJTG11zeK?=
 =?us-ascii?Q?66fr6Aoj2BBhNtUhQSNbBtwB2PPEHVnlJiPdFuh30D6EN9k0tsIg8pyqLIQv?=
 =?us-ascii?Q?TQTssXvCJFCsnaB+aYxFUkln98ARg7ePEbzrxY8dLHVqvD+/SgAj8xG5Z/hJ?=
 =?us-ascii?Q?jhcttdCy1QO4RrwgreDdGqPMwUJ8HlkWlvEqZ6VvhRUazgoR9+2/fBI91lmV?=
 =?us-ascii?Q?k3OtQUN4Q+TDCZEr0rf1khWWISPWAkJmjmFnRdE1k34zhE+mUg2HZHkVXi8K?=
 =?us-ascii?Q?is6rvfpTu9G+MTkSFA2bU2xXbQbjdk4iHD6AaiqsflAr/bBZtVf4EEAhbLIF?=
 =?us-ascii?Q?zzn0+RWk72x78vNn4jqKGjL5Te4xq0n4Zx+qA8EpWhyfTLkUx5g1FPJOIQpP?=
 =?us-ascii?Q?gG/CqcqibHY4Jrhk9ntJIeKxRgB13IRLtzEkzOTHDIm9XY5b5MXY8+n9FQbU?=
 =?us-ascii?Q?bpeSUxhcVQWsoRDRVPi+mhPBzYAmbkKHcRx1SjN53pAho7OhqgA1ibGaw6VS?=
 =?us-ascii?Q?J4Eac8w2/HfSoLayCh6MmQ5fXhn3HSIJZGlTZbCPkcIcQ120Pgk/+8QHEEdW?=
 =?us-ascii?Q?SSdLzpREEGNBklp3QjcHR0xybZx1W+6JWoRVoJVqLJlpM8jXq+VYesMnMGlu?=
 =?us-ascii?Q?2F2wCteQxul26Xhm7ieN+BP/wY+ml+xwLUYJdUU+iPecf7Yeklrv9UYW1Ok7?=
 =?us-ascii?Q?QRTMUd2t0atgmwtcegPYw6lwXoPD7bnsgmYKECgdPLkmhq9WqK84Ca/Kvbh2?=
 =?us-ascii?Q?Rd+QFjGtcLYLHGmsHym+KnnxFKV/In5RHmi7VyOh/YZ3OHZW69XR7Q4cx9Lg?=
 =?us-ascii?Q?2PErOm0J9pHdYdEbbfvLl+9z36/2qXpMZSkjP9XU/Qc5c71SfIfA8/76DKQp?=
 =?us-ascii?Q?l+vY6R225wIugAbGme6T4Wr5/QDjQG51BWV2?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2025 02:43:43.3303 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 896e8cf5-1323-4821-9420-08dd8d10fb7c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001EA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4175
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

From: Mario Limonciello <mario.limonciello@amd.com>

[Why]
DMI quirks are relatively big code that makes amdgpu_dm 200 lines
larger.

[How]
Move DMI quirks into a dedicated source file and make all quirks
variables for `struct amdgpu_display_manager`.

Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/Makefile    |   1 +
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 152 +--------------
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |   9 +
 .../amd/display/amdgpu_dm/amdgpu_dm_quirks.c  | 178 ++++++++++++++++++
 4 files changed, 191 insertions(+), 149 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_quirks.c

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/Makefile b/drivers/gpu/drm/amd/display/amdgpu_dm/Makefile
index ab2a97e354da..7329b8cc2576 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/Makefile
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/Makefile
@@ -38,6 +38,7 @@ AMDGPUDM = \
 	amdgpu_dm_pp_smu.o \
 	amdgpu_dm_psr.o \
 	amdgpu_dm_replay.o \
+	amdgpu_dm_quirks.o \
 	amdgpu_dm_wb.o
 
 ifdef CONFIG_DRM_AMD_DC_FP
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 5a38748703b3..6894028a3d21 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -80,7 +80,6 @@
 #include <linux/power_supply.h>
 #include <linux/firmware.h>
 #include <linux/component.h>
-#include <linux/dmi.h>
 #include <linux/sort.h>
 
 #include <drm/display/drm_dp_mst_helper.h>
@@ -1679,153 +1678,6 @@ static bool dm_should_disable_stutter(struct pci_dev *pdev)
 	return false;
 }
 
-struct amdgpu_dm_quirks {
-	bool aux_hpd_discon;
-	bool support_edp0_on_dp1;
-};
-
-static struct amdgpu_dm_quirks quirk_entries = {
-	.aux_hpd_discon = false,
-	.support_edp0_on_dp1 = false
-};
-
-static int edp0_on_dp1_callback(const struct dmi_system_id *id)
-{
-	quirk_entries.support_edp0_on_dp1 = true;
-	return 0;
-}
-
-static int aux_hpd_discon_callback(const struct dmi_system_id *id)
-{
-	quirk_entries.aux_hpd_discon = true;
-	return 0;
-}
-
-static const struct dmi_system_id dmi_quirk_table[] = {
-	{
-		.callback = aux_hpd_discon_callback,
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
-			DMI_MATCH(DMI_PRODUCT_NAME, "Precision 3660"),
-		},
-	},
-	{
-		.callback = aux_hpd_discon_callback,
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
-			DMI_MATCH(DMI_PRODUCT_NAME, "Precision 3260"),
-		},
-	},
-	{
-		.callback = aux_hpd_discon_callback,
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
-			DMI_MATCH(DMI_PRODUCT_NAME, "Precision 3460"),
-		},
-	},
-	{
-		.callback = aux_hpd_discon_callback,
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
-			DMI_MATCH(DMI_PRODUCT_NAME, "OptiPlex Tower Plus 7010"),
-		},
-	},
-	{
-		.callback = aux_hpd_discon_callback,
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
-			DMI_MATCH(DMI_PRODUCT_NAME, "OptiPlex Tower 7010"),
-		},
-	},
-	{
-		.callback = aux_hpd_discon_callback,
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
-			DMI_MATCH(DMI_PRODUCT_NAME, "OptiPlex SFF Plus 7010"),
-		},
-	},
-	{
-		.callback = aux_hpd_discon_callback,
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
-			DMI_MATCH(DMI_PRODUCT_NAME, "OptiPlex SFF 7010"),
-		},
-	},
-	{
-		.callback = aux_hpd_discon_callback,
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
-			DMI_MATCH(DMI_PRODUCT_NAME, "OptiPlex Micro Plus 7010"),
-		},
-	},
-	{
-		.callback = aux_hpd_discon_callback,
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
-			DMI_MATCH(DMI_PRODUCT_NAME, "OptiPlex Micro 7010"),
-		},
-	},
-	{
-		.callback = edp0_on_dp1_callback,
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "HP"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "HP Elite mt645 G8 Mobile Thin Client"),
-		},
-	},
-	{
-		.callback = edp0_on_dp1_callback,
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "HP"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "HP EliteBook 645 14 inch G11 Notebook PC"),
-		},
-	},
-	{
-		.callback = edp0_on_dp1_callback,
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "HP"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "HP EliteBook 665 16 inch G11 Notebook PC"),
-		},
-	},
-	{
-		.callback = edp0_on_dp1_callback,
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "HP"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "HP ProBook 445 14 inch G11 Notebook PC"),
-		},
-	},
-	{
-		.callback = edp0_on_dp1_callback,
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "HP"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "HP ProBook 465 16 inch G11 Notebook PC"),
-		},
-	},
-	{}
-	/* TODO: refactor this from a fixed table to a dynamic option */
-};
-
-static void retrieve_dmi_info(struct amdgpu_display_manager *dm, struct dc_init_data *init_data)
-{
-	int dmi_id;
-	struct drm_device *dev = dm->ddev;
-
-	dm->aux_hpd_discon_quirk = false;
-	init_data->flags.support_edp0_on_dp1 = false;
-
-	dmi_id = dmi_check_system(dmi_quirk_table);
-
-	if (!dmi_id)
-		return;
-
-	if (quirk_entries.aux_hpd_discon) {
-		dm->aux_hpd_discon_quirk = true;
-		drm_info(dev, "aux_hpd_discon_quirk attached\n");
-	}
-	if (quirk_entries.support_edp0_on_dp1) {
-		init_data->flags.support_edp0_on_dp1 = true;
-		drm_info(dev, "support_edp0_on_dp1 attached\n");
-	}
-}
 
 void*
 dm_allocate_gpu_mem(
@@ -2112,7 +1964,9 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 	if (amdgpu_ip_version(adev, DCE_HWIP, 0) >= IP_VERSION(3, 0, 0))
 		init_data.num_virtual_links = 1;
 
-	retrieve_dmi_info(&adev->dm, &init_data);
+	retrieve_dmi_info(&adev->dm);
+	if (adev->dm.edp0_on_dp1_quirk)
+		init_data.flags.support_edp0_on_dp1 = true;
 
 	if (adev->dm.bb_from_dmub)
 		init_data.bb_from_dmub = adev->dm.bb_from_dmub;
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index 4b615071e93b..d7d92f9911e4 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -618,6 +618,13 @@ struct amdgpu_display_manager {
 	 */
 	bool aux_hpd_discon_quirk;
 
+	/**
+	 * @edp0_on_dp1_quirk:
+	 *
+	 * quirk for platforms that put edp0 on DP1.
+	 */
+	bool edp0_on_dp1_quirk;
+
 	/**
 	 * @dpia_aux_lock:
 	 *
@@ -1068,4 +1075,6 @@ void hdmi_cec_set_edid(struct amdgpu_dm_connector *aconnector);
 void hdmi_cec_unset_edid(struct amdgpu_dm_connector *aconnector);
 int amdgpu_dm_initialize_hdmi_connector(struct amdgpu_dm_connector *aconnector);
 
+void retrieve_dmi_info(struct amdgpu_display_manager *dm);
+
 #endif /* __AMDGPU_DM_H__ */
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_quirks.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_quirks.c
new file mode 100644
index 000000000000..1da07ebf9217
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_quirks.c
@@ -0,0 +1,178 @@
+// SPDX-License-Identifier: MIT
+/*
+ * Copyright 2025 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ * Authors: AMD
+ *
+ */
+
+#include <linux/dmi.h>
+
+#include "amdgpu.h"
+#include "amdgpu_dm.h"
+
+struct amdgpu_dm_quirks {
+	bool aux_hpd_discon;
+	bool support_edp0_on_dp1;
+};
+
+static struct amdgpu_dm_quirks quirk_entries = {
+	.aux_hpd_discon = false,
+	.support_edp0_on_dp1 = false
+};
+
+static int edp0_on_dp1_callback(const struct dmi_system_id *id)
+{
+	quirk_entries.support_edp0_on_dp1 = true;
+	return 0;
+}
+
+static int aux_hpd_discon_callback(const struct dmi_system_id *id)
+{
+	quirk_entries.aux_hpd_discon = true;
+	return 0;
+}
+
+static const struct dmi_system_id dmi_quirk_table[] = {
+	{
+		.callback = aux_hpd_discon_callback,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Precision 3660"),
+		},
+	},
+	{
+		.callback = aux_hpd_discon_callback,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Precision 3260"),
+		},
+	},
+	{
+		.callback = aux_hpd_discon_callback,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Precision 3460"),
+		},
+	},
+	{
+		.callback = aux_hpd_discon_callback,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "OptiPlex Tower Plus 7010"),
+		},
+	},
+	{
+		.callback = aux_hpd_discon_callback,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "OptiPlex Tower 7010"),
+		},
+	},
+	{
+		.callback = aux_hpd_discon_callback,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "OptiPlex SFF Plus 7010"),
+		},
+	},
+	{
+		.callback = aux_hpd_discon_callback,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "OptiPlex SFF 7010"),
+		},
+	},
+	{
+		.callback = aux_hpd_discon_callback,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "OptiPlex Micro Plus 7010"),
+		},
+	},
+	{
+		.callback = aux_hpd_discon_callback,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "OptiPlex Micro 7010"),
+		},
+	},
+	{
+		.callback = edp0_on_dp1_callback,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "HP"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "HP Elite mt645 G8 Mobile Thin Client"),
+		},
+	},
+	{
+		.callback = edp0_on_dp1_callback,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "HP"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "HP EliteBook 645 14 inch G11 Notebook PC"),
+		},
+	},
+	{
+		.callback = edp0_on_dp1_callback,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "HP"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "HP EliteBook 665 16 inch G11 Notebook PC"),
+		},
+	},
+	{
+		.callback = edp0_on_dp1_callback,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "HP"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "HP ProBook 445 14 inch G11 Notebook PC"),
+		},
+	},
+	{
+		.callback = edp0_on_dp1_callback,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "HP"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "HP ProBook 465 16 inch G11 Notebook PC"),
+		},
+	},
+	{}
+	/* TODO: refactor this from a fixed table to a dynamic option */
+};
+
+void retrieve_dmi_info(struct amdgpu_display_manager *dm)
+{
+	struct drm_device *dev = dm->ddev;
+	int dmi_id;
+
+	dm->aux_hpd_discon_quirk = false;
+	dm->edp0_on_dp1_quirk = false;
+
+	dmi_id = dmi_check_system(dmi_quirk_table);
+
+	if (!dmi_id)
+		return;
+
+	if (quirk_entries.aux_hpd_discon) {
+		dm->aux_hpd_discon_quirk = true;
+		drm_info(dev, "aux_hpd_discon_quirk attached\n");
+	}
+	if (quirk_entries.support_edp0_on_dp1) {
+		dm->edp0_on_dp1_quirk = true;
+		drm_info(dev, "support_edp0_on_dp1 attached\n");
+	}
+}
-- 
2.43.0

