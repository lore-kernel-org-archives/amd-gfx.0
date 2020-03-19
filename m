Return-Path: <SRS0=hs5v=5E=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73E49C4332D
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Mar 2020 14:16:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46F7D2080C
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Mar 2020 14:16:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="RPz7A3q0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46F7D2080C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E86F98914D;
	Thu, 19 Mar 2020 14:16:12 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690081.outbound.protection.outlook.com [40.107.69.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD12088E56
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Mar 2020 14:16:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GQoGQU4UTXE6wIZFNWPH5JVYdt+ABrw+hFRekYmhmHIkDNlVC+ZXg4PpBAaBTTgLuWqhStDUnCEkWbUY1olIVSa5kjrBl9sgXuoMPTaEIBK39ldOHzDJiuxv4gRLJGBpJbzFkIEqClKlXjHbmLf/ry+KtYFXhD9I3WvAcvWLXpd3ySUNPvyETeQuvUTVyBnN2XsPhpIK+EYZXPW6Zy6xN6nxQt43ovFiXEhaBQVQbpKhJytKFxDj0DuKbLuUK8yMy0N7/mS7TJq8cnlBIun3wxJDTPlnYvdX0En25lCKnzfJE5Zh/1gYMdUa2YQVDmpUAFCdQXSGz+tTTvrgUolyyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2DNCUVrpdCtuGN0FHCp+1aBB7vIP3Qb5Sn6UephOgV4=;
 b=SL4CWQNwtXXrb5I/KXaeoGDgweI1hM/MEGFJuC0XoJTiacva/eJIp/bEvgrAfbP9+cheVFVayVYN879OfW7vPdb7Vj7jemFAgiqiRrpJtwhboe9yqEXRFT4CZ/h3F5If8q2WMghMPRVTmhW3NJWJTU8oD1IxsK8/agT3jLjovSKVhGPFw85mFxTs5gV1G+962ifgno/2Z0WHVjcGLB94e6xPFWmEdhqgH1JCVPwg3oErm4OOblDeCWADKr+UWD9DiTCIsV5Bh5aMQonF/ayQhDZrc7ts0dj6Ib0b1VrAyBuffCjTEcKkQE9RhgP7oljRCLVeul52c+R9sYa3RQKasg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2DNCUVrpdCtuGN0FHCp+1aBB7vIP3Qb5Sn6UephOgV4=;
 b=RPz7A3q0/EUZXE2NUOpUmV/GHlOJDl1n1/axziKbKtXMP6fQ/eblkz1i/tyJJHkF9FZtm5tlKw7qmNgTCViSY3kT8nKwp9k8yZAOsTFjrXOFYiPdsnZ6JeEAkF1ZYxCyJKcnCdKb91cIddhHvxH3ueNLO5TeFYmwlyua2IrcfTk=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Kent.Russell@amd.com; 
Received: from DM6PR12MB3721.namprd12.prod.outlook.com (2603:10b6:5:1c2::18)
 by DM6PR12MB4204.namprd12.prod.outlook.com (2603:10b6:5:212::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.18; Thu, 19 Mar
 2020 14:16:10 +0000
Received: from DM6PR12MB3721.namprd12.prod.outlook.com
 ([fe80::f8bd:4765:eb5b:a7a5]) by DM6PR12MB3721.namprd12.prod.outlook.com
 ([fe80::f8bd:4765:eb5b:a7a5%2]) with mapi id 15.20.2814.021; Thu, 19 Mar 2020
 14:16:10 +0000
From: Kent Russell <kent.russell@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] Enable reading FRU chip via I2C v3
Date: Thu, 19 Mar 2020 10:16:00 -0400
Message-Id: <20200319141600.29898-1-kent.russell@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: YTOPR0101CA0033.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::46) To DM6PR12MB3721.namprd12.prod.outlook.com
 (2603:10b6:5:1c2::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from krussell.amd.com (165.204.55.251) by
 YTOPR0101CA0033.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.17 via Frontend
 Transport; Thu, 19 Mar 2020 14:16:09 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8ac67289-c993-47bd-77f8-08d7cc101282
X-MS-TrafficTypeDiagnostic: DM6PR12MB4204:|DM6PR12MB4204:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4204A05C5A88E2F98E48893885F40@DM6PR12MB4204.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 0347410860
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(136003)(366004)(376002)(39860400002)(346002)(199004)(1076003)(52116002)(66946007)(316002)(66476007)(66556008)(4326008)(86362001)(8936002)(7696005)(6666004)(2906002)(6486002)(478600001)(2616005)(44832011)(956004)(36756003)(8676002)(16526019)(186003)(6916009)(5660300002)(26005)(30864003)(81166006)(81156014);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB4204;
 H:DM6PR12MB3721.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9jDK5tos8edmB15ZZAb0dY71TLQyqard3x4WZadH3KQL10fzAnR2gqV8rglnUYCpHW6JlTH5oTKG93Kytr+0K4TSeJo6QF77e91zTD6rasSt3wts5mv/ipEHyJNlAsst3fvK9FHJnoapXLGt3GyZgrg3DaINepFvkeHoK2njE8K7nit9K0JIP+gBF7cW3z40jqMCJpkpNNPADluapAx8TIMfqxqwdk+N2zQFI1Guq4ubQIk3X59GrRbOb3rFqOhqlwoWmq4Mx7+ErxQ6m35Vg59MgstkzXb6/SrUy0AGgr0Po8wuat2+iYX2gbMI6dqh6F/WxAdFjebBsDEshaBHK6yGQcTywCx5BR4iaSNyvR/9ZAfSCGBaT4BuyEKoz/r/CNMrqKBR/gV2E0SnOdk6pj8AQXZV5WQLUhk00KEo3c497fTjhY7dyZeBBZStGvlW
X-MS-Exchange-AntiSpam-MessageData: wHQa3HSaszXBhEM4c7Zv8b5gxKYp+JOcnWr5KgIo7xGJobpXxPKTPA9L0nhZr45qUzCNgWL/tmSYQNpT46UqhwlYZ9eC62VhEAoa3KcZmt3EmQN1HVIgiIhKHyHrojR3vUfkfRF7ZrtXg1bkHBt2oQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ac67289-c993-47bd-77f8-08d7cc101282
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2020 14:16:10.2175 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dvsGVVgdDw5vSU6YoXhCLIDTvVbec1jIZDo/v5/mj1SF59AqivcYkyalsj/QTg9EkmqcTxeTP8BEbv/sXBfv+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4204
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
Cc: Kent Russell <kent.russell@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Allow for reading of information like manufacturer, product number
and serial number from the FRU chip. Report the serial number as
the new sysfs file serial_number. Note that this only works on
server cards, as consumer cards do not feature the FRU chip, which
contains this information.

v2: Add documentation to amdgpu.rst, add helper functions,
    rename functions for consistency, fix bad starting offset
v3: Remove testing definitions

Signed-off-by: Kent Russell <kent.russell@amd.com>
---
 Documentation/gpu/amdgpu.rst                  |  24 +++
 drivers/gpu/drm/amd/amdgpu/Makefile           |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |   5 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  90 +++++++++++
 .../gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c    | 143 ++++++++++++++++++
 .../gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.h    |  29 ++++
 6 files changed, 292 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.h

diff --git a/Documentation/gpu/amdgpu.rst b/Documentation/gpu/amdgpu.rst
index 0efede580039..d9ea09ec8e24 100644
--- a/Documentation/gpu/amdgpu.rst
+++ b/Documentation/gpu/amdgpu.rst
@@ -202,3 +202,27 @@ busy_percent
 
 .. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
    :doc: busy_percent
+
+GPU Product Information
+=======================
+
+Information about the GPU can be obtained on certain cards
+via sysfs
+
+product_name
+------------
+
+.. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+   :doc: product_name
+
+product_number
+--------------
+
+.. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+   :doc: product_name
+
+serial_number
+-------------
+
+.. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+   :doc: serial_number
diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index c2bbcdd9c875..210d57a4afc8 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -55,7 +55,7 @@ amdgpu-y += amdgpu_device.o amdgpu_kms.o \
 	amdgpu_vf_error.o amdgpu_sched.o amdgpu_debugfs.o amdgpu_ids.o \
 	amdgpu_gmc.o amdgpu_mmhub.o amdgpu_xgmi.o amdgpu_csa.o amdgpu_ras.o amdgpu_vm_cpu.o \
 	amdgpu_vm_sdma.o amdgpu_discovery.o amdgpu_ras_eeprom.o amdgpu_nbio.o \
-	amdgpu_umc.o smu_v11_0_i2c.o
+	amdgpu_umc.o smu_v11_0_i2c.o amdgpu_fru_eeprom.o
 
 amdgpu-$(CONFIG_PERF_EVENTS) += amdgpu_pmu.o
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 87c2523076af..7dd74253e7b6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -979,6 +979,11 @@ struct amdgpu_device {
 
 	bool                            pm_sysfs_en;
 	bool                            ucode_sysfs_en;
+
+	/* Chip product information */
+	char				product_number[16];
+	char				product_name[32];
+	char				serial[16];
 };
 
 static inline struct amdgpu_device *amdgpu_ttm_adev(struct ttm_bo_device *bdev)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 729565f79cfe..80a654326190 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -64,6 +64,7 @@
 #include "amdgpu_xgmi.h"
 #include "amdgpu_ras.h"
 #include "amdgpu_pmu.h"
+#include "amdgpu_fru_eeprom.h"
 
 #include <linux/suspend.h>
 #include <drm/task_barrier.h>
@@ -137,6 +138,72 @@ static DEVICE_ATTR(pcie_replay_count, S_IRUGO,
 
 static void amdgpu_device_get_pcie_info(struct amdgpu_device *adev);
 
+/**
+ * DOC: product_name
+ *
+ * The amdgpu driver provides a sysfs API for reporting the product name
+ * for the device
+ * The file serial_number is used for this and returns the product name
+ * as returned from the FRU.
+ * NOTE: This is only available for certain server cards
+ */
+
+static ssize_t amdgpu_device_get_product_name(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct drm_device *ddev = dev_get_drvdata(dev);
+	struct amdgpu_device *adev = ddev->dev_private;
+
+	return snprintf(buf, PAGE_SIZE, "%s\n", adev->product_name);
+}
+
+static DEVICE_ATTR(product_name, S_IRUGO,
+		amdgpu_device_get_product_name, NULL);
+
+/**
+ * DOC: product_number
+ *
+ * The amdgpu driver provides a sysfs API for reporting the part number
+ * for the device
+ * The file serial_number is used for this and returns the part number
+ * as returned from the FRU.
+ * NOTE: This is only available for certain server cards
+ */
+
+static ssize_t amdgpu_device_get_product_number(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct drm_device *ddev = dev_get_drvdata(dev);
+	struct amdgpu_device *adev = ddev->dev_private;
+
+	return snprintf(buf, PAGE_SIZE, "%s\n", adev->product_number);
+}
+
+static DEVICE_ATTR(product_number, S_IRUGO,
+		amdgpu_device_get_product_number, NULL);
+
+/**
+ * DOC: serial_number
+ *
+ * The amdgpu driver provides a sysfs API for reporting the serial number
+ * for the device
+ * The file serial_number is used for this and returns the serial number
+ * as returned from the FRU.
+ * NOTE: This is only available for certain server cards
+ */
+
+static ssize_t amdgpu_device_get_serial_number(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct drm_device *ddev = dev_get_drvdata(dev);
+	struct amdgpu_device *adev = ddev->dev_private;
+
+	return snprintf(buf, PAGE_SIZE, "%s\n", adev->serial);
+}
+
+static DEVICE_ATTR(serial_number, S_IRUGO,
+		amdgpu_device_get_serial_number, NULL);
+
 /**
  * amdgpu_device_supports_boco - Is the device a dGPU with HG/PX power control
  *
@@ -1977,6 +2044,8 @@ static int amdgpu_device_ip_init(struct amdgpu_device *adev)
 		amdgpu_xgmi_add_device(adev);
 	amdgpu_amdkfd_device_init(adev);
 
+	amdgpu_fru_get_product_info(adev);
+
 init_failed:
 	if (amdgpu_sriov_vf(adev))
 		amdgpu_virt_release_full_gpu(adev, true);
@@ -3188,6 +3257,24 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 		return r;
 	}
 
+	r = device_create_file(adev->dev, &dev_attr_product_name);
+	if (r) {
+		dev_err(adev->dev, "Could not create product_name");
+		return r;
+	}
+
+	r = device_create_file(adev->dev, &dev_attr_product_number);
+	if (r) {
+		dev_err(adev->dev, "Could not create product_number");
+		return r;
+	}
+
+	r = device_create_file(adev->dev, &dev_attr_serial_number);
+	if (r) {
+		dev_err(adev->dev, "Could not create serial_number");
+		return r;
+	}
+
 	if (IS_ENABLED(CONFIG_PERF_EVENTS))
 		r = amdgpu_pmu_init(adev);
 	if (r)
@@ -3270,6 +3357,9 @@ void amdgpu_device_fini(struct amdgpu_device *adev)
 	device_remove_file(adev->dev, &dev_attr_pcie_replay_count);
 	if (adev->ucode_sysfs_en)
 		amdgpu_ucode_sysfs_fini(adev);
+	device_remove_file(adev->dev, &dev_attr_product_name);
+	device_remove_file(adev->dev, &dev_attr_product_number);
+	device_remove_file(adev->dev, &dev_attr_serial_number);
 	if (IS_ENABLED(CONFIG_PERF_EVENTS))
 		amdgpu_pmu_fini(adev);
 	if (amdgpu_discovery && adev->asic_type >= CHIP_NAVI10)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
new file mode 100644
index 000000000000..990dee6e22d5
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
@@ -0,0 +1,143 @@
+/*
+ * Copyright 2019 Advanced Micro Devices, Inc.
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
+ */
+#include "amdgpu.h"
+#include "amdgpu_i2c.h"
+#include "smu_v11_0_i2c.h"
+#include "atom.h"
+
+#define I2C_PRODUCT_INFO_ADDR		0xAC
+#define I2C_PRODUCT_INFO_ADDR_SIZE	0x2
+#define I2C_PRODUCT_INFO_OFFSET		0xC0
+
+int amdgpu_fru_read_eeprom(struct amdgpu_device *adev, uint32_t addrptr,
+			   unsigned char *buff)
+{
+	int ret, size;
+	struct i2c_msg msg = {
+			.addr   = I2C_PRODUCT_INFO_ADDR,
+			.flags  = I2C_M_RD,
+			.buf    = buff,
+	};
+	buff[0] = 0;
+	buff[1] = addrptr;
+	msg.len = I2C_PRODUCT_INFO_ADDR_SIZE + 1;
+	ret = i2c_transfer(&adev->pm.smu_i2c, &msg, 1);
+
+	if (ret < 1) {
+		DRM_WARN("FRU: Failed to get size field");
+		return ret;
+	}
+
+	/* The size returned by the i2c requires subtraction of 0xC0 since the
+	 * size apparently always reports as 0xC0+actual size.
+	 */
+	size = buff[2] - I2C_PRODUCT_INFO_OFFSET;
+	/* Add 1 since address field was 1 byte */
+	buff[1] = addrptr + 1;
+
+	msg.len = I2C_PRODUCT_INFO_ADDR_SIZE + size;
+	ret = i2c_transfer(&adev->pm.smu_i2c, &msg, 1);
+
+	if (ret < 1) {
+		DRM_WARN("FRU: Failed to get data field");
+		return ret;
+	}
+
+	return size;
+}
+
+int amdgpu_fru_get_product_info(struct amdgpu_device *adev)
+{
+	unsigned char buff[32];
+	int addrptr = 0, size = 0;
+
+	/* If algo exists, it means that the i2c_adapter's initialized */
+	if (!adev->pm.smu_i2c.algo) {
+		DRM_WARN("Cannot access FRU, EEPROM accessor not initialized");
+		return 0;
+	}
+
+	/* There's a lot of repetition here. This is due to the FRU having
+	 * variable-length fields. To get the information, we have to find the
+	 * size of each field, and then keep reading along and reading along
+	 * until we get all of the data that we want. We use addrptr to track
+	 * the address as we go
+	 */
+
+	/* The first fields are all of size 1-byte, from 0-7 are offsets that
+	 * contain information that isn't useful to us.
+	 * Bytes 8-a are all 1-byte and refer to the size of the entire struct,
+	 * and the language field, so just start from 0xb, manufacturer size
+	 */
+	addrptr = 0xb;
+	size = amdgpu_fru_read_eeprom(adev, addrptr, buff);
+	if (size < 1) {
+		DRM_ERROR("Failed to read FRU Manufacturer, ret:%d", size);
+		return size;
+	}
+
+	/* Increment the addrptr by the size of the field, and 1 due to the
+	 * size field being 1 byte. This pattern continues below.
+	 */
+	addrptr += size + 1;
+	size = amdgpu_fru_read_eeprom(adev, addrptr, buff);
+	if (size < 1) {
+		DRM_ERROR("Failed to read FRU product name, ret:%d", size);
+		return size;
+	}
+
+	/* Start at 2 due to buff using fields 0 and 1 for the address */
+	memcpy(adev->product_name, &buff[2], size);
+	adev->product_name[size] = '\0';
+
+	addrptr += size + 1;
+	size = amdgpu_fru_read_eeprom(adev, addrptr, buff);
+	if (size < 1) {
+		DRM_ERROR("Failed to read FRU product number, ret:%d", size);
+		return size;
+	}
+
+	memcpy(adev->product_number, &buff[2], size);
+	adev->product_number[size] = '\0';
+
+	addrptr += size + 1;
+	size = amdgpu_fru_read_eeprom(adev, addrptr, buff);
+
+	if (size < 1) {
+		DRM_ERROR("Failed to read FRU product version, ret:%d", size);
+		return size;
+	}
+
+	addrptr += size + 1;
+	size = amdgpu_fru_read_eeprom(adev, addrptr, buff);
+
+	if (size < 1) {
+		DRM_ERROR("Failed to read FRU serial number, ret:%d", size);
+		return size;
+	}
+
+	memcpy(adev->serial, &buff[2], size);
+	adev->serial[size] = '\0';
+
+	return 0;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.h
new file mode 100644
index 000000000000..968115c97e33
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.h
@@ -0,0 +1,29 @@
+/*
+ * Copyright 2020 Advanced Micro Devices, Inc.
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
+ */
+
+#ifndef __AMDGPU_PRODINFO_H__
+#define __AMDGPU_PRODINFO_H__
+
+int amdgpu_fru_get_product_info(struct amdgpu_device *adev);
+
+#endif  // __AMDGPU_PRODINFO_H__
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
