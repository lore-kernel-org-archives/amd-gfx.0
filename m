Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCD03C2D0CD
	for <amd-gfx@archiver.kernel.org>; Thu, 15 May 2025 19:55:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 677BA10E94C;
	Thu, 15 May 2025 19:55:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="suTsjitX";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2089.outbound.protection.outlook.com [40.107.212.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B3C610E94C
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 May 2025 19:55:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R8SjRRrf6hEkSoCLnfjDn/+woIg67xvGBAE+LJq+MFkGz54njea9iC2+txMH/KdF7jyUdTzh55JvMeXYSL0l4/+j/gCycYFaWcDP4WirJBs5i/a1yLr7rJeTNkr5uDJNO36ZSQqRKehmMwXVnH2D3cDfhlYOh4NNeXIjjGDqV7z6ssFGQtlaW3zjjk9e3yH1R9TMLHuYMvEARcs70BMHR/ZoEbmslr0AABI+eYXPAncLaPBuzByTPTogqiRf1mmNzo3EzzckWQ/E/x+t5djpsMp9V4DHutjZGYhUsO1UHzOYwLxHaCpLCazBHU/u7BLo7EQYTJk/bIljyJRRXu+VWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=59U8Cd8lb0lkIHiTmmL1meY7LBS+D6CbuHp+ZrIl+hI=;
 b=nRSQ+QAuNiEBGWHRnI36BjQwWazM1ZWA2HaOB54cUNSBhJ3ey46h9dyH9MbvXZUo+3QpZNQSS9B5uRc85brkF0viZvF7CODdxbwZ6EKZXtnun/jziGRx4RNfKlQL9sxqUVrZb2C7SPyzSWT7iLI0mA+VJMZbyQsySQL9Tl7tZPX7tho46jqBPPbvQXKEWbLMxIYlSvnJJpzzfvtF1aDWCrz37X7r3wJ+cWU1ZyG8eSt1F2H+EaHXufB0gkjuYdphYsPTyP7T51apqws8j2iklolFOpYCq2iTceoBsn7q+4p+nAXGV/6pdlfLj7pnoT9oQgowgv1Z02npz0jC3XJo5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=59U8Cd8lb0lkIHiTmmL1meY7LBS+D6CbuHp+ZrIl+hI=;
 b=suTsjitXAS5VG2n9hzNVa4dD7P7mUwcHb8iLLU+0aYAMpBf349ThzP5hhmYAu5oNujD3qqY+B1sdZzJv2ObTL8u6WDX3oxTzYRmxvbopg7uFISHu59pNPUvOaR89wxyG12gjSfvdfBa+7IZ5QDkXskgOMT46Qoo/45nue7VbYvU=
Received: from MW4PR03CA0164.namprd03.prod.outlook.com (2603:10b6:303:8d::19)
 by PH7PR12MB8056.namprd12.prod.outlook.com (2603:10b6:510:269::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.32; Thu, 15 May
 2025 19:55:20 +0000
Received: from SJ1PEPF00001CE3.namprd05.prod.outlook.com
 (2603:10b6:303:8d:cafe::88) by MW4PR03CA0164.outlook.office365.com
 (2603:10b6:303:8d::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.41 via Frontend Transport; Thu,
 15 May 2025 19:55:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE3.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Thu, 15 May 2025 19:55:18 +0000
Received: from maple-stxh-linux-10.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 15 May 2025 14:55:17 -0500
From: Pratap Nirujogi <pratap.nirujogi@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>,
 <christian.koenig@amd.com>, <mlimonci@amd.com>
CC: <benjamin.chan@amd.com>, <bin.du@amd.com>, <gjorgji.rosikopulos@amd.com>, 
 <king.li@amd.com>, <dantony@amd.com>, Pratap Nirujogi
 <pratap.nirujogi@amd.com>
Subject: [PATCH v1] drm/amd/amdgpu: Add GPIO resources required for amdisp
Date: Thu, 15 May 2025 15:54:01 -0400
Message-ID: <20250515195504.1099467-1-pratap.nirujogi@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE3:EE_|PH7PR12MB8056:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e7c4826-9ec2-4b4d-38dd-08dd93ea6b43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?WbwarZ/I6b+X3fp5cpNDHm1EeiWA31oCjHccvm0eQO6kvkdvZ92D8373Ht/p?=
 =?us-ascii?Q?7uptjcLzwnR0ueqHAnKmioKgceWWUso9cziGmEGkSXzwLw6Utf6OBa3V3izE?=
 =?us-ascii?Q?VL6TfLn3f0xyeftaGsUHVO6By+NwTiKEtYe25rREvGsr0Eq149BoSoqXIYjH?=
 =?us-ascii?Q?7VZII1lx7cgZ2750QzCgflIpcfAXtPzYpsYwf/65VKsRplC1WJIrSP2oWFtG?=
 =?us-ascii?Q?csNCOa55BGSzQ9ksB3Eufr8em1MWC0/HIVALROMe8qsHG0lNk2kBhkFr27Bv?=
 =?us-ascii?Q?6c/N7BCuYE7GiWlETJCf48GC2S0pDve02nWKLiBMoZwzcFA+Qwo4Z9UgDAZ1?=
 =?us-ascii?Q?L0edHlPgNpdaWNhBoSu1ob4EMay1DFnaVP7F5JzARamoJBpSZcitzz6s3v/v?=
 =?us-ascii?Q?a/zYySNgRVCVeSJL2Z3lsHPANaLRmqY4nv421q35fF2qEHR7Ld2I/H6ocrpn?=
 =?us-ascii?Q?L0xWgmhmFbohEmFjQJbbqIRPXYtB3zeTyz7ZnAok/qEc3YK/PuxHBxz1IZ5r?=
 =?us-ascii?Q?n4k7E+6lb6BpQWZmhjWAwEvJ8Pm/YOHB2w8L+kzh3LfXRzjlhXwRm0hdYAU5?=
 =?us-ascii?Q?woY6iIYohcn2O/0KY+nHFtWm0m9e7JLGJcWk1JTTRkvgBZ6yENN9JEFXuae1?=
 =?us-ascii?Q?6l/3CD0LMTVu6hIF4zWv5J7u3n4xpSgCtzuvkd3H/+9q+XYAJ11rB8KhCkYV?=
 =?us-ascii?Q?/x5wpJhd2WYgOBC3QC/YGbwM2/F8A1iE8lzM8HR0sYNfitMgSyuRdFBGoC5I?=
 =?us-ascii?Q?OiqTt9Y45pREyyWjWbFwnGNeLF4Ose1zJplWlsUNsX9u9xkyKk2sdqC0cEZq?=
 =?us-ascii?Q?GnCeFysvpF/qZARqlLfDiNzOMzjwvNUtfXm7zlLEGUBdxYMPKjcGRT/jvnIX?=
 =?us-ascii?Q?Qiyw5LN7blRrE//vYiClV9Fia651IGmwdJ2a1JB6Kze5z8IT5FYkiZgU327l?=
 =?us-ascii?Q?9daArtylP0/lyTCENxsFrf1VY6hvMamhciAHFATsXVnRujDWtlDFTsyrRtpU?=
 =?us-ascii?Q?rxc3Kxjm0tT+OJi4Zs/MKzoCnEMcgtxe1/jOxruNMQjnmacIbmJ6G5K8FvWt?=
 =?us-ascii?Q?PdyKvbYTlrwv0XI8WHskDV7LOieTZg5qKe0v9Y1nEFrFoxG3p6FQppOX3yFK?=
 =?us-ascii?Q?+iAJq0ydJYWPig+g24a8DQdx5M+pUJH6nUioCS6cKyud768YgMZKlSV0fu6N?=
 =?us-ascii?Q?DgnVsuPCuEXhvh5SnfXZYaAetuv+lqlNdfRR70GyNcCU8qkhk1J7H9Zp03Y2?=
 =?us-ascii?Q?WzyLddFPPw1I1AcYIkk6ztZUaE3slNuiVbAKcV0sdK6Vx+9Cdz3m4/i/iBmR?=
 =?us-ascii?Q?QhWcj7h0ltF8FdyCiKtdYsStBSyXbZsY+KB9YdWn/cwLkehgEvW+pbwtqk0J?=
 =?us-ascii?Q?wN+/Id9bbskrXgRYbDc2f4E6lqNz17NfkWmqAAbKNZZnvG6hkuO/OeuEh27D?=
 =?us-ascii?Q?eKhi6kdreyw8N4k6huAqTLftayNzFY9He6q71oj6jxKy4RfcLdE6YZklBSIh?=
 =?us-ascii?Q?vUlcyjkFF8lBQEO4ORtPc53Q7sgYendL3NwN?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2025 19:55:18.6404 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e7c4826-9ec2-4b4d-38dd-08dd93ea6b43
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8056
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
Changes v0 -> v1:

* Add amdgpu_acpi_get_isp4_dev_hid() utility to retrieve isp4
platform device hid.

 drivers/gpu/drm/amd/amdgpu/amdgpu.h      |  2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 29 ++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c  | 35 ++++++++++++++++++++++++
 3 files changed, 66 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index cc26cf1bd843..b63ceead2499 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1657,10 +1657,12 @@ static inline void amdgpu_acpi_get_backlight_caps(struct amdgpu_dm_backlight_cap
 bool amdgpu_acpi_is_s3_active(struct amdgpu_device *adev);
 bool amdgpu_acpi_is_s0ix_active(struct amdgpu_device *adev);
 void amdgpu_choose_low_power_state(struct amdgpu_device *adev);
+int amdgpu_acpi_get_isp4_dev_hid(char **hid);
 #else
 static inline bool amdgpu_acpi_is_s0ix_active(struct amdgpu_device *adev) { return false; }
 static inline bool amdgpu_acpi_is_s3_active(struct amdgpu_device *adev) { return false; }
 static inline void amdgpu_choose_low_power_state(struct amdgpu_device *adev) { }
+static int amdgpu_acpi_get_isp4_dev_hid(char **hid) { }
 #endif
 
 void amdgpu_register_gpu_instance(struct amdgpu_device *adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
index b7f8f2ff143d..5e04f4b7d0ea 100644
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
+int amdgpu_acpi_get_isp4_dev_hid(char **hid)
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
+		strscpy(*hid, acpi_device_hid(acpi_pdev), ACPI_ID_LEN);
+
+	put_device(pdev);
+
+	return 0;
+}
+
 #endif /* CONFIG_SUSPEND */
diff --git a/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c b/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c
index 69dd92f6e86d..1bb927428847 100644
--- a/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c
@@ -25,6 +25,7 @@
  *
  */
 
+#include <linux/gpio/machine.h>
 #include "amdgpu.h"
 #include "isp_v4_1_1.h"
 
@@ -39,15 +40,49 @@ static const unsigned int isp_4_1_1_int_srcid[MAX_ISP411_INT_SRC] = {
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
+	char *isp_dev_uid;
 	u64 isp_base;
 
 	if (adev->rmmio_size == 0 || adev->rmmio_size < 0x5289)
 		return -EINVAL;
 
+	isp_dev_uid = devm_kzalloc(adev->dev, ACPI_ID_LEN, GFP_KERNEL);
+	if (!isp_dev_uid)
+		return -ENOMEM;
+
+	r = amdgpu_acpi_get_isp4_dev_hid(&isp_dev_uid);
+	if (r) {
+		drm_dbg(&adev->ddev, "Invalid isp platform detected");
+		/* allow GPU init to progress */
+		return 0;
+	}
+
+	/* add GPIO resources required for OMNI5C10 sensor */
+	if (!strcmp("OMNI5C10", isp_dev_uid)) {
+		gpiod_add_lookup_table(&isp_gpio_table);
+		gpiod_add_lookup_table(&isp_sensor_gpio_table);
+	}
+
 	isp_base = adev->rmmio_base;
 
 	isp->isp_cell = kcalloc(3, sizeof(struct mfd_cell), GFP_KERNEL);
-- 
2.43.0

