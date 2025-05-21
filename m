Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A28F7C54E65
	for <amd-gfx@archiver.kernel.org>; Wed, 21 May 2025 20:59:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4826F10E6F6;
	Wed, 21 May 2025 20:59:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fhx5dMi/";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2087.outbound.protection.outlook.com [40.107.92.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE37710E6F6
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 May 2025 20:59:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N9d3WWdMVZA5TLWT/BfiyxcI1Z3Rnw9x7DbF0KZgWTCaqVwnhxJyoVIY3zCYuhCGxXoBUE90mo20lM3yR/U4HfLNRMZHu5gHrkIWYnsajijZij5ztcSH3w7A5l7vs7h7ND3rxL0jf82mbo3qbyTqZdmFz36Un7Mzch0bkE1pEbZz0B7WuFimy9rd3zSHFrk6fd6y3asX8Rt3aSAoIYSf0IcnVXQ+uQxCsKeV2PQnZ0EtWh6eQFKqpq3PkJ3b0NNDxp+5GMlWnvhOCT/t5NKmJZVQA2lS23Z1Khm+XhVrBQlMovQt2T2GqpLHGRmLeQQh8QjPQt6kNB1umDCSDRHCBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oGwvbSNpqKG+mucFw0qOAdsadjUFX0fv74o1QrL/qp4=;
 b=WwOyXVBPAd2AfBdfHa6049iqipFv/PeKG6BzaIcOh9f7hYY2k9r5MUcKMqFohig+gTgOh+3tIwI8GWG43ILqIbGs2Eofhf0zvwnAd5r1GQwu64FILRDIoTOO4ltrOseHfDYeP7Vwg4+6hVXS9mCTTQtMK/hM08oWQ2vKZMleRlP15EMfW2W7qUF8c/TR+8G/LkdZb83/mb5TArFhfogk9P/jTSg3eVHTEwCq+sV9DDGRU9fB+lpkxQ0FU4u0WRvDOUoJwe+cJRX5MikHe5jKOsfXxjVIlUTSLXUaLhXpO8Oys5wNDnAA++jTNX2rZBR4wd8QGvQLS5Mut/4dJTSkHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oGwvbSNpqKG+mucFw0qOAdsadjUFX0fv74o1QrL/qp4=;
 b=fhx5dMi/BzgNtVkcnIAPA5bx3gA10QbzfS+Y3OqtEAXWtLb1QCFEQQUsAS+8jxTO6SmbNDiEO+OgJI4sjRCktfDlp3X70VWf0+7DBfCMfVPspXJmvREyLlmFqpJZaORib3gjDYAAo5DqZ3ayy8KbRPr4bl3eZi5OYEaJXRCDsns=
Received: from MW4PR03CA0320.namprd03.prod.outlook.com (2603:10b6:303:dd::25)
 by BY5PR12MB4161.namprd12.prod.outlook.com (2603:10b6:a03:209::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Wed, 21 May
 2025 20:59:23 +0000
Received: from CO1PEPF000075EF.namprd03.prod.outlook.com
 (2603:10b6:303:dd:cafe::d8) by MW4PR03CA0320.outlook.office365.com
 (2603:10b6:303:dd::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.24 via Frontend Transport; Wed,
 21 May 2025 20:59:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000075EF.mail.protection.outlook.com (10.167.249.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Wed, 21 May 2025 20:59:22 +0000
Received: from maple-stxh-linux-10.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 21 May 2025 15:59:21 -0500
From: Pratap Nirujogi <pratap.nirujogi@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>,
 <christian.koenig@amd.com>, <mlimonci@amd.com>
CC: <benjamin.chan@amd.com>, <bin.du@amd.com>, <gjorgji.rosikopulos@amd.com>, 
 <king.li@amd.com>, <dantony@amd.com>, Pratap Nirujogi
 <pratap.nirujogi@amd.com>, Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v5] drm/amd/amdgpu: Add GPIO resources required for amdisp
Date: Wed, 21 May 2025 16:49:28 -0400
Message-ID: <20250521205906.639718-1-pratap.nirujogi@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075EF:EE_|BY5PR12MB4161:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b7a6671-d6b2-4837-83b1-08dd98aa5cfd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?xjnaEdZog7IM8LkLUOwKDIWMZ2/XYrxUrD/eTje0besBTQMS95wh9v3tyzKx?=
 =?us-ascii?Q?/ttJa6npHHKVR9g4eSrzKyPQZvVHjN//P0ghnqB03G9xTPV03fv5UX22OYgC?=
 =?us-ascii?Q?3tZiZeIbwGKvoTGNzHwo2SxRR0NsKj+s+U86mtKu9talh+Vc4beYMc3Q0b5u?=
 =?us-ascii?Q?jhmvsnTmFLN0V5/uZfijHcihEPKk3dmnGud8xt01sNEv8+Z8xHx1+jO+axRJ?=
 =?us-ascii?Q?Q8KORgRMi0QG1JW2bqEclxgj5xkddvSiPcItDicm0NXSS56RSrwJMPsFW8AL?=
 =?us-ascii?Q?HsSj/gZskKAq6uji5i4KiJAI7l6lzUXMpAmzeriluQiOh5fSHiJVH6GP6IpD?=
 =?us-ascii?Q?F2Fk9i/zuKgpFL2+yDgexn6AfnLnGzUCRaAFOnrvlrGhaecp4lf9Rz2VAOmF?=
 =?us-ascii?Q?3oa46vQf8INoaQ6kt6PRoH6/Ib87V8HwP9KtdyNwvHo8YDTYHi5nDDSxDEt/?=
 =?us-ascii?Q?tAPCos1tP2xxck3DComvIXAFfkKbZx555glp9Wc1mccXkA526RfanAwORPFI?=
 =?us-ascii?Q?RmyQftUowt6WGrphaFYHw8BkC2776X/VUo7sWjlT4NKYgFN0OU8bCLcQqmEE?=
 =?us-ascii?Q?sz0VJj7GXFzPISLf4+BDt0TlLOaMhUqElpFEpaloTb16VhEvsE1AcPqNCxih?=
 =?us-ascii?Q?intrWH2ot8S5ICexz84EmHcFrbtgEZZaknzv7w1YSC/hUm45OwXkR0UajVxs?=
 =?us-ascii?Q?e2fysvUa6rGSxE1h1j3k0P4iIMSPpznZMW2A6DgoFsvicVwRoaPsRfMn2wCv?=
 =?us-ascii?Q?s1Tl/cWsCEcEhrtMEhO0W22X6W4avbIn6p8ZgKsro0Ki9xKJhpXOQu+ikzR5?=
 =?us-ascii?Q?tS5clj5riKDQiHM9jJg10eRa56zo5HVOuo/8xkbrLLfaWR5r7YT6RJXdMdrv?=
 =?us-ascii?Q?Zl62GAVen8sM3l0R98ZWrFvJyJXVirSVVaARzt8BYdM2td0n+gU085wKfYp8?=
 =?us-ascii?Q?irVQjrZLb2ClHsC1DhA1/Vfru8mjs/IiQADOprZaaX8N9WzN1LXGT8NO6H8y?=
 =?us-ascii?Q?8nS451PDfK5sL2K9vt5MPfdaH4xzpv3l5BHJLYPM4teaZ7smAII2cDVAQnHL?=
 =?us-ascii?Q?EgcLI9MmTeHKp0yUr8ojDl+glpSZMn+nN46udC+HYGh7a4c6W2+CoYNgbhxs?=
 =?us-ascii?Q?Tae88uTPdUHbyZmmWw7kobb5YBimy9l8mKvZU6f2jIEbQR8oXJnwYYO0VBaR?=
 =?us-ascii?Q?HetFytwL0G81yyta/Q2SWmvYmAIS0bwgG6+KhBgi9HdlXHWd5s/EeYofglwe?=
 =?us-ascii?Q?Zchva/lYP+BhZwEfvN2aTcbCD8+kc9sFzKSWfkYSt9RVhG02PfDhbrCDD6N1?=
 =?us-ascii?Q?kcVApmf8h135PTg2Pmpy3vRENlcO68HJPkLX7B3I3RB6HAgZVsEriVjWDbGr?=
 =?us-ascii?Q?vcDZRAQbH6vcwEPOBxjfm3SSHnfwQbhqaJ/p0yqgdP2F6T6Bf1KFctkXQ6jG?=
 =?us-ascii?Q?Hy9NmlyeOvQfr6XQf2gtXoIvw6pdFn6O1SJPNAKLeOSkuJcEcR/m1cair2h9?=
 =?us-ascii?Q?3zG7dgqyZZAC9qEvUi5VBt6J/KXCRIYwkrXo?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2025 20:59:22.6996 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b7a6671-d6b2-4837-83b1-08dd98aa5cfd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075EF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4161
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
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
---
Changes v4 -> v5:

* Build errors reported on the platform that doesn't enable CONFIG_ACPI
or CONFIG_SUSPEND. Include amdgpu_acpi_get_isp4_dev_hid() only when both
CONFIG_DRM_AMD_ISP and ACPI are enabled to fix the build errors.


 drivers/gpu/drm/amd/amdgpu/Kconfig       |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu.h      |  4 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 32 +++++++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c  | 31 +++++++++++++++++++++++
 4 files changed, 67 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/Kconfig b/drivers/gpu/drm/amd/amdgpu/Kconfig
index 1a11cab741ac..6bd9aa5dbef7 100644
--- a/drivers/gpu/drm/amd/amdgpu/Kconfig
+++ b/drivers/gpu/drm/amd/amdgpu/Kconfig
@@ -77,7 +77,7 @@ config DRM_AMDGPU_USERPTR
 
 config DRM_AMD_ISP
 	bool "Enable AMD Image Signal Processor IP support"
-	depends on DRM_AMDGPU
+	depends on DRM_AMDGPU && ACPI
 	select MFD_CORE
 	select PM_GENERIC_DOMAINS if PM
 	help
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 836ea081088a..a5ccd0ada16a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1713,6 +1713,10 @@ static inline bool amdgpu_acpi_is_s0ix_active(struct amdgpu_device *adev) { retu
 static inline bool amdgpu_acpi_is_s3_active(struct amdgpu_device *adev) { return false; }
 #endif
 
+#if defined(CONFIG_DRM_AMD_ISP)
+int amdgpu_acpi_get_isp4_dev_hid(u8 (*hid)[ACPI_ID_LEN]);
+#endif
+
 void amdgpu_register_gpu_instance(struct amdgpu_device *adev);
 void amdgpu_unregister_gpu_instance(struct amdgpu_device *adev);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
index 707e131f89d2..f5466c592d94 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
@@ -1532,5 +1532,35 @@ bool amdgpu_acpi_is_s0ix_active(struct amdgpu_device *adev)
 	return true;
 #endif /* CONFIG_AMD_PMC */
 }
-
 #endif /* CONFIG_SUSPEND */
+
+#if IS_ENABLED(CONFIG_DRM_AMD_ISP)
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
+	struct device *pdev __free(put_device) = NULL;
+	struct acpi_device *acpi_pdev;
+
+	pdev = bus_find_device(&platform_bus_type, NULL, isp_sensor_ids,
+			       isp_match_acpi_device_ids);
+	if (!pdev)
+		return -EINVAL;
+
+	acpi_pdev = ACPI_COMPANION(pdev);
+	if (!acpi_pdev)
+		return -ENODEV;
+
+	strscpy(*hid, acpi_device_hid(acpi_pdev));
+
+	return 0;
+}
+#endif /* CONFIG_DRM_AMD_ISP */
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

