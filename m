Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52486C3ABD8
	for <amd-gfx@archiver.kernel.org>; Fri, 16 May 2025 21:32:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E1D9C10EB9C;
	Fri, 16 May 2025 21:32:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="b2NJHb/J";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2052.outbound.protection.outlook.com [40.107.237.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B27FE10EB9B
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 May 2025 21:32:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PTW68dpaSOiHVfyitu4TV8igwYCKtrSkpOQdM8xhfEkV+htsoyIKSUOj5LHArv+HT54oaA98eWabVLuCl8Y5htkvMd/oaw4qs9d9az+bhNXxhcB0yCTfqa7TJNm0nJmZ8QgFVyc1dOvs/nul1LUgJ8v3kDo5Fwd38Q+VF3C+ZgZvy85chDX4sO1R//xHPiAmzR/ylx/0fxjQmItUfSpGHG+kQYRKMJKECIJgm5hOzl/5b/qOUvBaOOqST9QrKVaNzYUEHJ26bH9nWeEUgo24m9gDsdKHHhZYrGjZt8Et6uegoE8765ddnTPkjn4qB5D7Te4vuwnaqNnkIlTLTuO5gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FeCz8tds6NtDIh6fsmD7YbPs2KhRApukY/o0VFGdmlA=;
 b=NzYSBfEX43IP/HdkQoWxThiBBXlts1XMktoiZMSfwel72315oQZJ9rTj9C/W/aVxZg4Ppvr1QySb6Ggy2UTbIXkTFd8/pDuf9OYQ70sgU0awcg3eoyxsp1tWUGsM1BliG9vxKIbOTSWCDEX5GNeRKRhdia/FmJBesUkXTafZUhNeo0/QYTBsX0nLsB8z6zNT8IBey18CHscgw1bv+l6gnWxwsw6g4vFJy/45nxNDPlyEF7zDnScCiek5erZ0F8FztRcAgwVQJlz3uCZi0dD8+zlLQGD3+LTSGtwjmiibSLKF0VUXWhwf0g/jMYb770mj4m3nqP7Qw1YlVJyPbo8gng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FeCz8tds6NtDIh6fsmD7YbPs2KhRApukY/o0VFGdmlA=;
 b=b2NJHb/JMKwE3JnVOon9fUwCbXB+xnOUb7WcrQiRCurC2aR1hEx9Htk8/qazclWuyLNZGRxTNvAxpQ1EI1/sWUDWN8b0vztLmDq3npDzk+NcsQkRkNAXoWRV+C8ky9/5QrDSjCJeIBrw6oPoT4ti6CPWVptuYMIb3u2pZQ9Fq0M=
Received: from BYAPR07CA0021.namprd07.prod.outlook.com (2603:10b6:a02:bc::34)
 by PH7PR12MB6935.namprd12.prod.outlook.com (2603:10b6:510:1b9::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.24; Fri, 16 May
 2025 21:31:57 +0000
Received: from SJ5PEPF000001D5.namprd05.prod.outlook.com
 (2603:10b6:a02:bc:cafe::eb) by BYAPR07CA0021.outlook.office365.com
 (2603:10b6:a02:bc::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.33 via Frontend Transport; Fri,
 16 May 2025 21:31:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001D5.mail.protection.outlook.com (10.167.242.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8746.27 via Frontend Transport; Fri, 16 May 2025 21:31:57 +0000
Received: from maple-stxh-linux-10.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 16 May 2025 16:31:55 -0500
From: Pratap Nirujogi <pratap.nirujogi@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>,
 <christian.koenig@amd.com>, <mlimonci@amd.com>
CC: <benjamin.chan@amd.com>, <bin.du@amd.com>, <gjorgji.rosikopulos@amd.com>, 
 <king.li@amd.com>, <dantony@amd.com>, Pratap Nirujogi
 <pratap.nirujogi@amd.com>
Subject: [PATCH v3] drm/amd/amdgpu: Add GPIO resources required for amdisp
Date: Fri, 16 May 2025 17:31:01 -0400
Message-ID: <20250516213126.1830572-1-pratap.nirujogi@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D5:EE_|PH7PR12MB6935:EE_
X-MS-Office365-Filtering-Correlation-Id: 9645ccf0-a1a6-49c2-85f9-08dd94c115cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?yRM7c+2/FCDoaPjkgwCbAwqDOsZ2nploPYziIggen+wb+RKBJWoRklogAosJ?=
 =?us-ascii?Q?PmMcShSR4GlNAzcZ/HDXzY7aSa78PypFShwOd4JaXLGkhW/pYunuiIgLbb+m?=
 =?us-ascii?Q?uhaiqtuwMm+crIW1H2nh1hWyJ1ede9AS/Mai5MoeMB4yvln3oBKV3dmujEgI?=
 =?us-ascii?Q?YHb/2Or3wLFO+nIKlGy0yx0sz2t0Eec5M8QohQ+Z3K65Wctevyj2lbGvqYDI?=
 =?us-ascii?Q?ec1wu+ACzV1fmJ2UI8iLCOqHCgyLym2i8T+bfUfaZo0czLQES1tc0zihaxw2?=
 =?us-ascii?Q?CmbWg53hhZZkM3jHV4E8s6QqmX4YEiR8frm69AboJJ/y5nNPxyEgLNmeiCcE?=
 =?us-ascii?Q?vmX2CpDj03z+lRMnB00U66lOYK+49DFzGopaFDapbja2GejYFiYCz2ZQLexE?=
 =?us-ascii?Q?X5H/8RrviTTo0FmKiZsS9+FX0FbFAK+bj53fr/uMG3PXORHzp3LvcXXAo4fC?=
 =?us-ascii?Q?qED0ZQdwnSiszOBjDL5YaiqXreI/MsUMLErXmgzr1gxjXH+NJ0sHrmxpuflr?=
 =?us-ascii?Q?8G1b7CZwFHpUtNDzlVujYuRbtPAI3XVZULJ6X05ycVZZ59M1jHRTkCgv05G0?=
 =?us-ascii?Q?YXzTZ+2PJ7Cb+zEbWbY3cJfs6XJrsZAoi5PjEja6X/82ueT+rNvhl91UuVs1?=
 =?us-ascii?Q?c7WmAvMs1/PLfl7EGv3iajR/S+y9omSq7UKD961F73XN4c48PsWQSSwkl9Y/?=
 =?us-ascii?Q?JPedzhEZ7DsMoZBQet+FkFk3/+3kw30HuZd2wXzHtM9yx5rQOkQNMGq3Vh6j?=
 =?us-ascii?Q?ye04joTIfsKGFMKnwwuQJODfgSFXIdnSK6UMrkoVbYolrBzxx0M9HMWp3B64?=
 =?us-ascii?Q?flTj8GsV83nkrDqK66oHmG+HKaugZ55zT9A3mzmXIgMBGVo5X+H1yGOzbgZT?=
 =?us-ascii?Q?zHPYAKbfWeAl8Nvg1U/Z5VQNfykEPHykdQkJyvaoQh2d0sz17TNhq2DQvfqK?=
 =?us-ascii?Q?HvS4OL0bPMm0VxMSGZuXL/gmwk7QqZrCchoQxLolRunIlt1uKIKVTAVtlFGn?=
 =?us-ascii?Q?OmfqZFmIdXFtd072qKWCp7LgkNv/Ur2LAnMaDKgidDg+IjeWX6tbbuSIJdIp?=
 =?us-ascii?Q?X1AaE9RUSTSG6eoprDQb18x68krWcQ/eja7IeVEa0DO2DYWCvr75NgKab516?=
 =?us-ascii?Q?RVNIcY5ncVJyeAPamNpRIQvxaxGeqIrzvwMN31FN+rwpzTs+UwjWGV3MmlFy?=
 =?us-ascii?Q?M2ul9zq38rNFy/vzFkKcw9OSyVuKDENDNzWCssd5VwdAeq4ImF1ilVqtO6BW?=
 =?us-ascii?Q?Z0EgWslHR9wr7nbCLOhqg9zDceNfOOX+QBhOOPvg+dZrjz/vzmHrYIrTvvC/?=
 =?us-ascii?Q?Ty3wc6rT/4cAn0G9K5mpzRR+B7IVimiZl3Kqln34+3EBb+W4CO3lzDHFvpJj?=
 =?us-ascii?Q?pmahQwQTW88dd38y67cGJaEGnGD4L+7JNIk+qTvFWxrmPXRHKbCEyIJjhrQE?=
 =?us-ascii?Q?do4ByT6FDumzFZm85ATcVXMtvN4/ob/rQESg1dUFyQWldla102a+vExZJ3El?=
 =?us-ascii?Q?iii/XZ44YOZe42WrPAgk0x01vBLWjHfAo+2Y?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2025 21:31:57.0388 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9645ccf0-a1a6-49c2-85f9-08dd94c115cb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6935
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
Changes v2 -> v3:

* Add NULL check for acpi_device handle in amdgpu_acpi_get_isp4_dev_hid()

 drivers/gpu/drm/amd/amdgpu/amdgpu.h      |  2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 31 ++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c  | 31 ++++++++++++++++++++++++
 3 files changed, 64 insertions(+)

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
index b7f8f2ff143d..78441d5f3231 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
@@ -1551,4 +1551,35 @@ void amdgpu_choose_low_power_state(struct amdgpu_device *adev)
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
+	if (!acpi_pdev)
+		return -ENODEV;
+
+	strscpy(*hid, acpi_device_hid(acpi_pdev));
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

