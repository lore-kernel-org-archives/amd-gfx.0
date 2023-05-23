Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17AF9C7EE23
	for <amd-gfx@archiver.kernel.org>; Tue, 23 May 2023 13:29:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9820010E43F;
	Tue, 23 May 2023 13:29:32 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2086.outbound.protection.outlook.com [40.107.244.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E496A10E449
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 May 2023 13:29:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lW65x9SltbjKculvuOSgSmhUXl1V8TpqHrjxBIRnDt6rnEXB5quRi4oiVFvf+8qBdJWiz12GmZZdZFNtvBplu/kbPs0bRAW599PQ7g11OH3mHzbFIWvVRRIsXweVybfrVjb6GJWPnGYoBfQxoLxOyueorTn3HagFPvCOO+qzJLsXpVDkDIVS5iLwavIJmgZNUG5ZOVboAMBbyIuK6oe+dfC6B29TgoeIvjA4deir5ae0d3ly1UnLKXGmmSDc7KSGfZppgLRGu4oIK8m2FdTo3D2FEP7H4O1F0TmoHxOku8mi8ZJoC6SWR3w3EXzBCvtpogankT8T9ex5jcjhAXugCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nzET02i91aB3AW3f18NEF65FwgPDcSjjWy1BBJhCZYo=;
 b=oZsjmAeUJuWrYNpo+pRqS1ndEkg1wHRv6qrtzzXM1oQNKkg0LHWXbl6650Jh7tHcdmMjttVthHvEERrVhmUe/Whau892fhRgshnbFFamFUCrSCFQ0WJPD7pkY3Gp4mmAGKTTcdv8C+k/KwyGKQP2MjemCla/iU/kQGnfq4hedquA8FZ/gjngZl9e3a+NKJqLQDdGeGB4qO6EM0pPAN3pg16XQk297cIdPowfQYyVoI4hvyZqETBwBx0pTrQ12peJnUX1iih73kM3stv6CCVNePiyFbsgHo3FppYbsTWl6t5SF8M5yhU9GuOyPe9PgLx38FDbr36o4Z8nGjdrsjbVKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nzET02i91aB3AW3f18NEF65FwgPDcSjjWy1BBJhCZYo=;
 b=fKaaq5JQ9L+tsqcrxP1ENHvLsYON9CmpAt20CS4CxBr25wgNilB6Vl4T7WSxZnm2Rpo7uO1+Enxcp86GxsdPKZ1GkKodPUPDs/AQlzvKwSpFEjlKpnUG+1QIuedfA1zN/5AwZgGotTCteK5B6WOanK90FgXb8V3ikrG4o9TY9L0=
Received: from BN0PR03CA0054.namprd03.prod.outlook.com (2603:10b6:408:e7::29)
 by PH8PR12MB7277.namprd12.prod.outlook.com (2603:10b6:510:223::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Tue, 23 May
 2023 13:29:26 +0000
Received: from BN8NAM11FT090.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e7:cafe::e4) by BN0PR03CA0054.outlook.office365.com
 (2603:10b6:408:e7::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.14 via Frontend
 Transport; Tue, 23 May 2023 13:29:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT090.mail.protection.outlook.com (10.13.177.105) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.29 via Frontend Transport; Tue, 23 May 2023 13:29:26 +0000
Received: from jz-tester2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 23 May
 2023 08:29:25 -0500
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Alexander.Deucher@amd.com>
Subject: [PATCH 2/3] drm/amdxcp: add platform device driver for amdxcp
Date: Tue, 23 May 2023 09:29:13 -0400
Message-ID: <20230523132914.3144843-2-James.Zhu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230523132914.3144843-1-James.Zhu@amd.com>
References: <20230523132914.3144843-1-James.Zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT090:EE_|PH8PR12MB7277:EE_
X-MS-Office365-Filtering-Correlation-Id: 13854693-3c35-41bf-8c17-08db5b91bad8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5+jPANnTLy1Ek1mwnKcwZFqXbG17FnU9xl9WSHuhLrPaXfynRZ8KDF345VEImjd8B3GzLstkSPCIsMKXipZix1HrcoVrZxNT+fMOV8y6DPKXEEXJ1pyVMVlUCz6UxqJlqWep0pwoJKDLRe26vFQu1ZcMNTI8NXIdE1ZitaXbT1Z8ovynpFocMVj5pqsezly1MBixy0marfOJOC+QpoWCRqaevmhGy7iu/14L6vkdbiEMAniGDS3LtDKGsQ0o7jq6ysZI5YtjmWqKhGWyluoV2Z8YexHEItioSK1Ua7oWB0S4tK3Mhm4PJgdZIrf9B2+nW7v5ow8JXUUSXqDqxkNloWUnkwFxbJdXTzpLexCWReG28l22nfmN4zs0UKaEklo2/5LX1S6GnxJIVUMahA+qsnT569JB7AE2mNFJYc2xZEnx+KQi/0vFlXvhqUhHlr/QeE/SJgPiTLjyYDMokW/dEf5xiFvLfE2VY8rvIVuZ4tBY2ttoB5YtdBjLIVRLuTvCT1Il5JyoY6PTU9o9Pd4cPvzjctUr+HbdNzkeTnW12yxkCOvahkdIrppeZJxeN2El4cDzQ40uSqm07LXhjyWyX7+08vXLssWTHlospmBDojNyw+lvgVOopTMYxN0Bsh/vRHm09QozBf0aALYqWYp1wHwwjL1ixnfxBaL8yd+nWmYv7b00JZm3XEuE51/yeXtwrHQgMn/+XgaJ2cyb0t+VflMDoflUHxtDZdPFHUH2XxUF8erS1n2DfGWROZSFTRylbqNojl/Tf88OGPMEdQYiiuxpJ4/P7Pm68epRnUwdyP0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(376002)(396003)(136003)(346002)(451199021)(40470700004)(36840700001)(46966006)(316002)(82740400003)(81166007)(356005)(478600001)(110136005)(6666004)(70586007)(70206006)(6636002)(4326008)(66899021)(41300700001)(82310400005)(7696005)(86362001)(8936002)(8676002)(40460700003)(5660300002)(186003)(36860700001)(40480700001)(1076003)(26005)(47076005)(336012)(426003)(16526019)(36756003)(83380400001)(2616005)(2906002)(2101003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2023 13:29:26.5884 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 13854693-3c35-41bf-8c17-08db5b91bad8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT090.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7277
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
Cc: jamesz@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add platform device driver for amdxcp to support
amdgpu spatial partition.

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 drivers/gpu/drm/Makefile                    |   1 +
 drivers/gpu/drm/amd/amdxcp/Makefile         |  25 +++++
 drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.c | 108 ++++++++++++++++++++
 drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.h |  29 ++++++
 4 files changed, 163 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/amdxcp/Makefile
 create mode 100644 drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.c
 create mode 100644 drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.h

diff --git a/drivers/gpu/drm/Makefile b/drivers/gpu/drm/Makefile
index cc637343d87b..a74789eb2fd0 100644
--- a/drivers/gpu/drm/Makefile
+++ b/drivers/gpu/drm/Makefile
@@ -138,6 +138,7 @@ obj-$(CONFIG_DRM_TDFX)	+= tdfx/
 obj-$(CONFIG_DRM_R128)	+= r128/
 obj-$(CONFIG_DRM_RADEON)+= radeon/
 obj-$(CONFIG_DRM_AMDGPU)+= amd/amdgpu/
+obj-$(CONFIG_DRM_AMDGPU)+= amd/amdxcp/
 obj-$(CONFIG_DRM_MGA)	+= mga/
 obj-$(CONFIG_DRM_I810)	+= i810/
 obj-$(CONFIG_DRM_I915)	+= i915/
diff --git a/drivers/gpu/drm/amd/amdxcp/Makefile b/drivers/gpu/drm/amd/amdxcp/Makefile
new file mode 100644
index 000000000000..5e1bd70748d4
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdxcp/Makefile
@@ -0,0 +1,25 @@
+#
+# Copyright 2023 Advanced Micro Devices, Inc.
+#
+# Permission is hereby granted, free of charge, to any person obtaining a
+# copy of this software and associated documentation files (the "Software"),
+# to deal in the Software without restriction, including without limitation
+# the rights to use, copy, modify, merge, publish, distribute, sublicense,
+# and/or sell copies of the Software, and to permit persons to whom the
+# Software is furnished to do so, subject to the following conditions:
+#
+# The above copyright notice and this permission notice shall be included in
+# all copies or substantial portions of the Software.
+#
+# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+# THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+# OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+# ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+# OTHER DEALINGS IN THE SOFTWARE.
+#
+
+amdgpu-y := amdgpu_xcp_drv.o
+
+obj-$(CONFIG_DRM_AMDGPU) += amdgpu_xcp_drv.o
diff --git a/drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.c b/drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.c
new file mode 100644
index 000000000000..d975160c0fa4
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.c
@@ -0,0 +1,108 @@
+/*
+ * Copyright 2023 Advanced Micro Devices, Inc.
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
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+
+#include <drm/drm_drv.h>
+
+#define MAX_XCP_PLATFORM_DEVICE 64
+
+struct xcp_device {
+	struct drm_device drm;
+	struct platform_device *pdev;
+};
+
+static const struct drm_driver amdgpu_xcp_driver = {
+	.driver_features = DRIVER_GEM | DRIVER_RENDER,
+	.name = "amdgpu_xcp_drv",
+	.major = 1,
+	.minor = 0,
+};
+
+static int pdev_num;
+static struct xcp_device *xcp_dev[MAX_XCP_PLATFORM_DEVICE];
+
+int amdgpu_xcp_drm_dev_alloc(struct drm_device **ddev)
+{
+	struct platform_device *pdev;
+	struct xcp_device *pxcp_dev;
+	int ret;
+
+	if (pdev_num >= MAX_XCP_PLATFORM_DEVICE)
+		return -ENODEV;
+
+	pdev = platform_device_register_simple("amdgpu_xcp", pdev_num, NULL, 0);
+	if (IS_ERR(pdev))
+		return PTR_ERR(pdev);
+
+	if (!devres_open_group(&pdev->dev, NULL, GFP_KERNEL)) {
+		ret = -ENOMEM;
+		goto out_unregister;
+	}
+
+	pxcp_dev = devm_drm_dev_alloc(&pdev->dev, &amdgpu_xcp_driver, struct xcp_device, drm);
+	if (IS_ERR(pxcp_dev)) {
+		ret = PTR_ERR(pxcp_dev);
+		goto out_devres;
+	}
+
+	xcp_dev[pdev_num] = pxcp_dev;
+	xcp_dev[pdev_num]->pdev = pdev;
+	*ddev = &pxcp_dev->drm;
+	pdev_num++;
+
+	return 0;
+
+out_devres:
+	devres_release_group(&pdev->dev, NULL);
+out_unregister:
+	platform_device_unregister(pdev);
+
+	return ret;
+}
+EXPORT_SYMBOL(amdgpu_xcp_drm_dev_alloc);
+
+void amdgpu_xcp_drv_release(void)
+{
+	for (--pdev_num; pdev_num >= 0; --pdev_num) {
+		devres_release_group(&xcp_dev[pdev_num]->pdev->dev, NULL);
+		platform_device_unregister(xcp_dev[pdev_num]->pdev);
+		xcp_dev[pdev_num]->pdev = NULL;
+		xcp_dev[pdev_num] = NULL;
+	}
+	pdev_num = 0;
+}
+EXPORT_SYMBOL(amdgpu_xcp_drv_release);
+
+static void __exit amdgpu_xcp_drv_exit(void)
+{
+	amdgpu_xcp_drv_release();
+}
+
+module_exit(amdgpu_xcp_drv_exit);
+
+MODULE_AUTHOR("AMD linux driver team");
+MODULE_DESCRIPTION("AMD XCP PLATFORM DEVICES");
+MODULE_LICENSE("GPL and additional rights");
diff --git a/drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.h b/drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.h
new file mode 100644
index 000000000000..c1c4b679bf95
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.h
@@ -0,0 +1,29 @@
+/*
+ * Copyright 2023 Advanced Micro Devices, Inc.
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
+#ifndef _AMDGPU_XCP_DRV_H_
+#define _AMDGPU_XCP_DRV_H_
+
+int amdgpu_xcp_drm_dev_alloc(struct drm_device **ddev);
+void amdgpu_xcp_drv_release(void);
+#endif /* _AMDGPU_XCP_DRV_H_ */
-- 
2.34.1

