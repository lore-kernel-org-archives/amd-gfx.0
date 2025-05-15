Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 719B1C2D0CD
	for <amd-gfx@archiver.kernel.org>; Thu, 15 May 2025 22:17:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B88CB10E973;
	Thu, 15 May 2025 22:17:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Yuh9Ihgn";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2081.outbound.protection.outlook.com [40.107.237.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A94FC10E975
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 May 2025 22:17:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hUL63FHtM0jOlKAzET1xSANH9prP8rfBvGn/OV4CGOizzoQywCxzW9AD0zSnIlNwei6cdb5sEnBLcaSAec6eWyWjPvntZ+ovVocU28IiPUcgKAbOE7Q9x6tqdqwZGUudhGkgcMxtBJelXGbt+yM2VBK/sZPLNuKbbHsmTzorda4UwUuc6Oo7wXGz2NmJhJwwuLuOrmcRVaGJE1HzfLzLhWTCy1jK4BocHnKkn0QYEJdEX3GJrI7VSdzIAyLBr5YnvS8TL53uoiXsvIDUCVpF1g/r7uNecA1CxYBYOjmW/oK0X+rF41OqQZXdhDk1FPsyl2bDfSTIAD+hBV4IUqnaRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W6vUdbi5FpRF1LXmMRwZFiIXCue0QmG7emPoEPBARDs=;
 b=Ydu5AZIl1qthMo02d7NeluRw4rjBMinAq/cdZofLxd+n5sqXV1ur2Mv1PlPtmpffVknuoCSK4IWEtmnoRUA3NBDPIkMCcu4E6tXG09VfWzzY6qkbfhxd0AXCgLamZiGndNJIupwZuYpxisWYu/7mFcorRYQcADX+sC9jxzVVfS9TAfLAlSSMDemDqU4NynRZUp7yCiiFT0hfwKVqmGXodwSAYMsYp3gyK7s0sGAhsSPTyoQsn+qXfDOwn3iIJ0N0tmuE+PQUDVq2K7sdsmD3Z1h/C2PFRV8Tqkfd08Z295yHG3t0D2nOKDb1h0HT0wGODVNu/fqLUrdXj82zmMhgow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W6vUdbi5FpRF1LXmMRwZFiIXCue0QmG7emPoEPBARDs=;
 b=Yuh9IhgnZlb3EAk+IdepusTVx/cIj9Yuy4iRi7GBVdO30+PlAm/wtCjWTsycCvVootthlzTxi7ZiHn0apVNSVDa0j2ghMydNCHMp78bigUBZTsurT5GnIDJUAaGoHkh2nmA6NkrGNvPGNH0UzfNl3k0XVTvDZEBwIZeo4w+PX/U=
Received: from BN0PR02CA0049.namprd02.prod.outlook.com (2603:10b6:408:e5::24)
 by SJ2PR12MB7895.namprd12.prod.outlook.com (2603:10b6:a03:4c6::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.31; Thu, 15 May
 2025 22:17:14 +0000
Received: from BL6PEPF00020E66.namprd04.prod.outlook.com
 (2603:10b6:408:e5:cafe::f6) by BN0PR02CA0049.outlook.office365.com
 (2603:10b6:408:e5::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.33 via Frontend Transport; Thu,
 15 May 2025 22:17:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00020E66.mail.protection.outlook.com (10.167.249.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Thu, 15 May 2025 22:17:13 +0000
Received: from maple-stxh-linux-10.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 15 May 2025 17:17:08 -0500
From: Pratap Nirujogi <pratap.nirujogi@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>,
 <christian.koenig@amd.com>, <mlimonci@amd.com>
CC: <benjamin.chan@amd.com>, <bin.du@amd.com>, <gjorgji.rosikopulos@amd.com>, 
 <king.li@amd.com>, <dantony@amd.com>, Pratap Nirujogi
 <pratap.nirujogi@amd.com>
Subject: [PATCH v2] drm/amd/amdgpu: Add GPIO resources required for amdisp
Date: Thu, 15 May 2025 18:16:02 -0400
Message-ID: <20250515221656.1516157-1-pratap.nirujogi@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E66:EE_|SJ2PR12MB7895:EE_
X-MS-Office365-Filtering-Correlation-Id: f512be8f-4659-46cd-ad49-08dd93fe3eb0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?PvKW9USeGmu+UVDjQ/SfRUqNccjFOi6XqBWroX5cejrVkqw+9qx0Y0C6LP1E?=
 =?us-ascii?Q?Xjelbk0ofX/1lISxhetA4pQRj9XN10rMabTXSqETAo1BRmczQCnhNaqZu9Is?=
 =?us-ascii?Q?XksHRnKX2R+1CVIneollylCHgCby19wsP3IO5kVgq+OqmolFN1ihmCo7P4oK?=
 =?us-ascii?Q?NGf7qe+ZHte6CydKxvOdOPrrJ2Ap0CQzt7/vWO/seIlKgcqKcbi8qfKN1uDI?=
 =?us-ascii?Q?xfThHR2+cTK1qysztsGb99T4jB3g35Eta0V4luH2DWr6E5ATClbEiAreMHiy?=
 =?us-ascii?Q?2fVOP+fj+J+bfl6nEp8G+H20eXk+V9vp6zslLyBbHrcSBU2MzphfH4vEOK/O?=
 =?us-ascii?Q?CUJy++n9vPJBe9A5ki0DYZz0eGMnixSGcE7+bErk9JZFE9sE6A6CsMZy4rt7?=
 =?us-ascii?Q?YCUnEnwS3oB/gwKi+/FhX0Kd93Fv8qbW/KFQpqZ0+VCoSEAEHw4b5FVYnNyw?=
 =?us-ascii?Q?JbUmETie3B/AqjNJ/ORVmyQ+/vxtu2vlPmFaAqvYT5cO8AX5kJBPf9eZWJN9?=
 =?us-ascii?Q?Wgnz1XDuhpm3Fy7H/r93JhttHfK0oon61WFNLlc2LtUSwahMp7xqLo3s1F7S?=
 =?us-ascii?Q?lM9v6bMJU2qJItA7J6xyAOESKx1AOim6aorlwSyjRY0Icw+fP96fEn8jU+/b?=
 =?us-ascii?Q?F2z3yk1e0w4Sov3/tRe/QN34HQ7UvD3Jvmj4cy+HS0aEe5+ntcZt3bW5rerp?=
 =?us-ascii?Q?fl2nbnMc2/rJ8bdbSG/HQgsBtFsw8uzWE8tXq79om7fjviM2I006hN8L2riP?=
 =?us-ascii?Q?WsZTrcf8cSwAYyvVV6+dX9VsjDhXNQcdHei4iBCkWlGPbeSZDEYhTJoNd29t?=
 =?us-ascii?Q?kO7VJ+zaYJpDtbivFJCgt95/Bobmnrq2tc+XK1bJIS7wHKEbVJd6F4TVLQlV?=
 =?us-ascii?Q?aFeQAAOb/aq66eza/T4etWWckTkKp7Fnb620NeK6riu2kl5u7J5m8oV9w+9r?=
 =?us-ascii?Q?iIsd3ubuC351inRqCwT/5+kKP7WNC2qj3hBYil12SzFozSPRSoeu1svWde7U?=
 =?us-ascii?Q?v7kvA2Pz7ebUnbayGWoRVn7GgVRK0x6D6cMis+2Yho1JsYfedGOG6Bo/JFUQ?=
 =?us-ascii?Q?OnFs0Wg9debmRs+tdakbXEZPLN9A8HirDLGOF0wXL1tDRlyTxG1pJ2wtrApj?=
 =?us-ascii?Q?ixU7HWCXbeq4nLejju5u2bAqa1Bv6ZeO5JY1t4e5J0NXjG4ySuenQCKKKGfR?=
 =?us-ascii?Q?KCHc4SP9SteTKQ7itdfB3YzXY/ByuuRLrU9f/fcdD4mwEPbQyGG2dnmWfiSv?=
 =?us-ascii?Q?nJbvuyV4cV/SnhsnunZ6uvAgHqcUWftUleYrm2m6Uf+yLdAO87Q7tyNfnGea?=
 =?us-ascii?Q?iqC9OUh8ipK/MSVo0enZ2yByV80QpnflURaRL3wNAmgTUMvRaNnQZstQZZq6?=
 =?us-ascii?Q?jQNAo3WX9vheVUBbXvu+oOlXBf9qy0M1uPuIjwLg4SCnHOu4UeIrQLwmyJyP?=
 =?us-ascii?Q?YoNuRCh2klsYDngjJEaph+ieYvSWoe4x36XjIZX4cYPCU2voL8z6qq0nLacr?=
 =?us-ascii?Q?k8WkT/HPMEXup+0G6meDQEiNcpwjOXZZ7TSE?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2025 22:17:13.8791 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f512be8f-4659-46cd-ad49-08dd93fe3eb0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E66.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7895
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

ISP is a child device to GFX, and its device specific information
is not available in ACPI. Adding the 2 GPIO resources required for
ISP_v4_1_1 in amdgpu_isp driver.

- GPIO 0 to allow sensor driver to enable and disable sensor module.
- GPIO 85 to allow ISP driver to enable and disable ISP RGB streaming mode.

Signed-off-by: Pratap Nirujogi <pratap.nirujogi@amd.com>
---
Changes v1 -> v2:

* Use fixed "isp_dev_hid[ACPI_ID_LEN]" instead of allocating using devm_kzalloc()
* Instead of "pointer to pointer" use "pointer to array" type arg in amdgpu_acpi_get_isp4_dev_hid()
* Include error code in the debug statement

 drivers/gpu/drm/amd/amdgpu/amdgpu.h      |  2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 29 ++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c  | 31 ++++++++++++++++++++++++
 3 files changed, 62 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index cc26cf1bd843..2aa7e89a190e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1657,10 +1657,12 @@ static inline void amdgpu_acpi_get_backlight_caps(struct amdgpu_dm_backlight_cap
 bool amdgpu_acpi_is_s3_active(struct amdgpu_device *adev);
 bool amdgpu_acpi_is_s0ix_active(struct amdgpu_device *adev);
 void amdgpu_choose_low_power_state(struct amdgpu_device *adev);
+int amdgpu_acpi_get_isp4_dev_hid(u8 (*hid)[ACPI_ID_LEN]);
 #else
 static inline bool amdgpu_acpi_is_s0ix_active(struct amdgpu_device *adev) { return false; }
 static inline bool amdgpu_acpi_is_s3_active(struct amdgpu_device *adev) { return false; }
 static inline void amdgpu_choose_low_power_state(struct amdgpu_device *adev) { }
+static int amdgpu_acpi_get_isp4_dev_hid(u8 (*hid)[ACPI_ID_LEN]) { }
 #endif
 
 void amdgpu_register_gpu_instance(struct amdgpu_device *adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
index b7f8f2ff143d..c39d3a09cd04 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
@@ -1551,4 +1551,33 @@ void amdgpu_choose_low_power_state(struct amdgpu_device *adev)
 		adev->in_s3 = true;
 }
 
+static const struct acpi_device_id isp_sensor_ids[] = {
+	{ "OMNI5C10" },
+	{ }
+};
+
+static int isp_match_acpi_device_ids(struct device *dev, const void *data)
+{
+	return acpi_match_device(data, dev) ? 1 : 0;
+}
+
+int amdgpu_acpi_get_isp4_dev_hid(u8 (*hid)[ACPI_ID_LEN])
+{
+	struct acpi_device *acpi_pdev;
+	struct device *pdev;
+
+	pdev = bus_find_device(&platform_bus_type, NULL, isp_sensor_ids,
+			       isp_match_acpi_device_ids);
+	if (!pdev)
+		return -EINVAL;
+
+	acpi_pdev = ACPI_COMPANION(pdev);
+	if (acpi_pdev)
+		strscpy(*hid, acpi_device_hid(acpi_pdev));
+
+	put_device(pdev);
+
+	return 0;
+}
+
 #endif /* CONFIG_SUSPEND */
diff --git a/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c b/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c
index 69dd92f6e86d..574880d67009 100644
--- a/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c
@@ -25,6 +25,7 @@
  *
  */
 
+#include <linux/gpio/machine.h>
 #include "amdgpu.h"
 #include "isp_v4_1_1.h"
 
@@ -39,15 +40,45 @@ static const unsigned int isp_4_1_1_int_srcid[MAX_ISP411_INT_SRC] = {
 	ISP_4_1__SRCID__ISP_RINGBUFFER_WPT16
 };
 
+static struct gpiod_lookup_table isp_gpio_table = {
+	.dev_id = "amd_isp_capture",
+	.table = {
+		GPIO_LOOKUP("AMDI0030:00", 85, "enable_isp", GPIO_ACTIVE_HIGH),
+		{ }
+	},
+};
+
+static struct gpiod_lookup_table isp_sensor_gpio_table = {
+	.dev_id = "i2c-ov05c10",
+	.table = {
+		GPIO_LOOKUP("amdisp-pinctrl", 0, "enable", GPIO_ACTIVE_HIGH),
+		{ }
+	},
+};
+
 static int isp_v4_1_1_hw_init(struct amdgpu_isp *isp)
 {
 	struct amdgpu_device *adev = isp->adev;
 	int idx, int_idx, num_res, r;
+	u8 isp_dev_hid[ACPI_ID_LEN];
 	u64 isp_base;
 
 	if (adev->rmmio_size == 0 || adev->rmmio_size < 0x5289)
 		return -EINVAL;
 
+	r = amdgpu_acpi_get_isp4_dev_hid(&isp_dev_hid);
+	if (r) {
+		drm_dbg(&adev->ddev, "Invalid isp platform detected (%d)", r);
+		/* allow GPU init to progress */
+		return 0;
+	}
+
+	/* add GPIO resources required for OMNI5C10 sensor */
+	if (!strcmp("OMNI5C10", isp_dev_hid)) {
+		gpiod_add_lookup_table(&isp_gpio_table);
+		gpiod_add_lookup_table(&isp_sensor_gpio_table);
+	}
+
 	isp_base = adev->rmmio_base;
 
 	isp->isp_cell = kcalloc(3, sizeof(struct mfd_cell), GFP_KERNEL);
-- 
2.43.0

