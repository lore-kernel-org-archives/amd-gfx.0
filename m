Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3035CC3ABD8
	for <amd-gfx@archiver.kernel.org>; Fri, 16 May 2025 22:26:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C13A210E0B8;
	Fri, 16 May 2025 22:26:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sxU70RDi";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2083.outbound.protection.outlook.com [40.107.95.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F065110E0B8
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 May 2025 22:26:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=su0+N37d8+fS9X60/9OeLrUzC6be96UwHcwIWu/n0AP0X9r57doMDyrZYnEwpRUkdr19d2t+cx5/SgZJdQqcm3RCZsI2Txle6OqaSS51TuL/MapJhIko3fLEl0PikRw/0Xk4rIKnRtUV/b1mgyZ6nW47nCq9nfoi+rS2xFcODFQXp05vJFILsi//ss7Z6Dtq5tZv/ajUoH9o5eQ2OqUH7ApPXf7GTmHpvM03v8NEEIFmYEqp/PsyCKdlpHZYlPC9RZ1krLoS5JLE4MTJk3dfIS6tSuqtURR0m/M2lnW1jHwo36v5TPVaYGNmME5WJeFdPZRLoZ/owBEcm+80j9lu/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AIm8QhdyZNxQP8bvhp12Zikjfb42HoDgSjo8s5TXWM4=;
 b=wXPZJ40yYJoL8JLafuQzQ4F1A1RkIn/T/dv3i+OzYGug6i9GeMn52Uu7ZRErAbn8NA1bx9XkoSElfZHNr3Se9vp6laEMChISmQZ45H3/768G+lWN2XwlST/zpcto2p3DkUprmRZoq0YYtXZK+zwebbv0r7+c7CzpsDl0c7niOyp/IQgXW8lpeAtQPL3VKZ6bAZYP6Qk4CCdgvsUGD0L4tY5gcG5BkamusSAsqGLkNHKMVUz8knWz4HAUehAV5AjrFt63fuEfB4wNzFGqbIxqG8eAChUbSj8Ia0OYX0tT3YHw7mNJiiH0/v4A2c+hX0kb4SDi19csvWlEimFggcRBpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AIm8QhdyZNxQP8bvhp12Zikjfb42HoDgSjo8s5TXWM4=;
 b=sxU70RDiiQbwZ4kyW2bahgnvS57QeltPLmBGgKgIMbEPxpVoPmS8XJicI+CT5PeqsTUmEa+kETErenOFa4bjp2MZvtvy3jxaFbzpfUbAp674TH2dAgx0hpFThFyM2/ho3gecA/puuwH/2nd5H9l+0UOdlS6X6dOYZS9GwHdv1sA=
Received: from CH2PR18CA0043.namprd18.prod.outlook.com (2603:10b6:610:55::23)
 by PH8PR12MB8432.namprd12.prod.outlook.com (2603:10b6:510:25b::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.29; Fri, 16 May
 2025 22:26:31 +0000
Received: from DS2PEPF0000343A.namprd02.prod.outlook.com
 (2603:10b6:610:55:cafe::28) by CH2PR18CA0043.outlook.office365.com
 (2603:10b6:610:55::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.33 via Frontend Transport; Fri,
 16 May 2025 22:26:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343A.mail.protection.outlook.com (10.167.18.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8746.27 via Frontend Transport; Fri, 16 May 2025 22:26:30 +0000
Received: from maple-stxh-linux-10.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 16 May 2025 17:26:29 -0500
From: Pratap Nirujogi <pratap.nirujogi@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>,
 <christian.koenig@amd.com>, <mlimonci@amd.com>
CC: <benjamin.chan@amd.com>, <bin.du@amd.com>, <gjorgji.rosikopulos@amd.com>, 
 <king.li@amd.com>, <dantony@amd.com>, Pratap Nirujogi
 <pratap.nirujogi@amd.com>
Subject: [PATCH v4] drm/amd/amdgpu: Add GPIO resources required for amdisp
Date: Fri, 16 May 2025 18:25:52 -0400
Message-ID: <20250516222611.1966604-1-pratap.nirujogi@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343A:EE_|PH8PR12MB8432:EE_
X-MS-Office365-Filtering-Correlation-Id: 61d886ca-35a9-42ff-f2d1-08dd94c8b512
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?XVMbumm6/BSXxWJB985H5Yj11m5oMprmDz7UYFtMnoO/3vKYqXWRKfWz6DIS?=
 =?us-ascii?Q?6B4ZKJcISaHUJLjOy/Gb3WvHbKMh6ZjGLwJsL4GITUGwFZiakLjGncNgMrwT?=
 =?us-ascii?Q?NrPD05k5eLWDgHOYYyj8PwRoFEV63aeGbMniYEoL235auFsbz4zauU3yR7jL?=
 =?us-ascii?Q?8kPvtIxixgNvgVR8xC/H72IbWUoVxeITS25e9Gdu206v0DeDJrThdfEQgnUQ?=
 =?us-ascii?Q?5kSAa+0GVj+M+xJQygaBy4mc7Mzl3KYlXVepMJSRF+HNT+6XjPJNipJL/7ts?=
 =?us-ascii?Q?xrc/LWfe9wBNgCtDXWUyXkimB1JLEUE9ND/HjzOXtO+4sCF/JzA0vn/gRLBA?=
 =?us-ascii?Q?eZWhI1sho3EKTs8kTE11dgjvy2s9dJ8bAszePIASoEBDQhsaNB3KZQRmEuf2?=
 =?us-ascii?Q?YqXXdmvoWGeMKd+jTJKtTeWYimVfSz4dLcDm4adJTOsHl7PXX6ZRTbpsGpzO?=
 =?us-ascii?Q?qJvBCeiFzNGNojy8WFHUJnWiScOsiiqzsTfIKNgWKygN5f1cjk3n4GUOPf+3?=
 =?us-ascii?Q?zGvITZoXI22pO6gjC+Djg05QLLEhCm1N32R/oiZ2lV7KoJiOCy/PppkZYbL9?=
 =?us-ascii?Q?b+tt++YuqHp95C9dA8Se2TBL2uNF5hR9YN3tdeQmu989WtczgKxu7XA1jXsw?=
 =?us-ascii?Q?6P05LG0jkw/xNsNEpqlqjBfSFxFWzambnI1aUxNVO4wZDn/FVDs54kMhUeG5?=
 =?us-ascii?Q?5MkNUFEjMcGBVRrLJOVHmOfmKlk4ObUzno4S8eltUwU2+I79VWk51UpavhVp?=
 =?us-ascii?Q?uMG1UcEuCJv6KfaEJA9otb3M0w6bTjZIKhVP3FT3GMRRK1cVbKcbxbXvesWa?=
 =?us-ascii?Q?oQJMANpy4XZ2VCIDOF2nFFnMBzuI+Zb9QYkuiHTuZ2tWCGE2RdG+8suRHGlf?=
 =?us-ascii?Q?vhbdCeVzO0U3rP/yvuyMoAk1TwxX+uYhT2lk+leKKXRuDQ8aV7OaGgj0t0Ma?=
 =?us-ascii?Q?+Ega1V1GRFuSWwW3QTmuj87YiLmxcT/MpMc7AX6iE6ZNsBC8NEbLDAl7+vKb?=
 =?us-ascii?Q?23HXY5apGlMvj1jETZhftl7RaNOii5UsBJ+b1vJNT+2pcNR0ARWliS4me5c4?=
 =?us-ascii?Q?ogkBr1TMO+3YmMS2KOFKt3DQuJMVvKvU28KENJNFnmc1ANlRh7l614YSVWyA?=
 =?us-ascii?Q?C3axRkvflZeoAFWLqLRRgn8ylhjGgzkPWCN/FP+9V9lme/SvsJs2Tr2rxqmO?=
 =?us-ascii?Q?irXnu/PuK2GiIt61VldrLmaM1kYs2wFxcZwYW0LUx4/+SwF1FpUu66wZetAV?=
 =?us-ascii?Q?SOxBDJfiF31x2dH6eyXVuDUldRHlMvktHZW03kTvNi/rUjmCpOu65WLYSDjb?=
 =?us-ascii?Q?mnoBAaKFzxZH9lBgdJoqE1lNCGAhcw2F6ju+hqXM2xNtnMPpHw/V+Rf6kdzz?=
 =?us-ascii?Q?fKbLFuxpRsD4UJzpzEKBKPMAqOPgW0bvUI+WNXezDaTDWfVXHJ8VuWlUbz72?=
 =?us-ascii?Q?eQBxIpJdpuWD5QFMdubhj0Vl/mEXXHJFehVI+oJv2cHDTFK1Po9WxWCJ9mCC?=
 =?us-ascii?Q?EcEXpE1gExtjtC0ug3qpSIlr2ICPy+Q0Aedb?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2025 22:26:30.7950 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 61d886ca-35a9-42ff-f2d1-08dd94c8b512
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB8432
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
Changes v3 -> v4:

* Use __free() macro to call put_device on exit in amdgpu_acpi_get_isp4_dev_hid()

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
index b7f8f2ff143d..daef8b912277 100644
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

