Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0BBFCD8CA8
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Jun 2026 10:03:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5451710F3E5;
	Fri, 12 Jun 2026 10:03:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mWRbt9e+";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010017.outbound.protection.outlook.com [52.101.85.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C91710E9B7
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Jun 2026 10:03:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DZjgz8wI2NGsVOvHP0N731bJjvIJd26SNqOawmEGRfsE0rJ6NX2pRBZf3586fwfXsF8bdLKG+UmeTu0R3/gNAZ7I0BL2oBi+0K55CoSZXdCRBtklsZ7WU+OczvNmKRppTR3oIR2yTtkVq0OAX9Wy5BprM2P/XifQNfRTg1ssp2X1G6cWkZ4FKFplwCvjA3Snm7VLGBubIZo9L4Jea8n+lv6BY9r1KZCB5/O1E5MSkMIBIRYKvNz3BMMZk/zbUQdtKXqjAti1A+ItdQo5n+oDk97bUaVu5je4Y6s3WpymtYVvLtdPc6bJPclqqOcWninlDzT2DgoobjcB73btVZYx5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RicaJ6k8KPL2kHRBFHcKuSz2jUeKyCfTvro+GFZkz6g=;
 b=mnVVF1SiLXNrSOzkQrl2mNinYvUsMshswYcY6rlBHnkBHCi4B/bpEVWaxap8pISz2GcsSg2x0ZoOgvhZf8tAChY4RevDrep0SASLIHVCUMLYaIzb5I/KYdB4jT3DR5/8pkqywlK1sJlYLvU7gSLH+fI4+OHb1hOjgepm1YmnP2jTkPfIJIRYEh7/sDkRwp7Rh/lllrgV9I1b3nEVePTDxkMyXucOHsHtA7k36BznK+tUfIza61bWMRDwOzY4qVXo5nXLrYyJRtLRmPl5qJtjKyOcR418Elxg5Pu7dJkG7zUfMfFeb2HjHcNWXfLoT/5F55JoBN3/Q8a1MoT6W6K/wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RicaJ6k8KPL2kHRBFHcKuSz2jUeKyCfTvro+GFZkz6g=;
 b=mWRbt9e+WB5uUPwj4n0Vg4zcuNV0SJCijTgAHhBEaPfT+pdfI8r4tR4nJ8Np7zY+f+s6KG0HA0E/6N9FCTB+GHWNdkEp/qC31bWwpOH1APZ+fwaHu6ydrc4Zko/gZl5s7zYmXpY1kDgkBYnB7kMEoaSFylFyQCEIglEu687XIYk=
Received: from SA1P222CA0193.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c4::10)
 by MN2PR12MB4206.namprd12.prod.outlook.com (2603:10b6:208:1d5::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.17; Fri, 12 Jun
 2026 10:03:34 +0000
Received: from SN1PEPF000397AF.namprd05.prod.outlook.com
 (2603:10b6:806:3c4:cafe::a7) by SA1P222CA0193.outlook.office365.com
 (2603:10b6:806:3c4::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.15 via Frontend Transport; Fri,
 12 Jun 2026 10:03:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000397AF.mail.protection.outlook.com (10.167.248.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Fri, 12 Jun 2026 10:03:34 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 12 Jun
 2026 05:03:32 -0500
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <hawking.zhang@amd.com>,
 <christian.koenig@amd.com>
Subject: [PATCH] drm/amdgpu: add parameter to allow skip specified PCI devices
Date: Fri, 12 Jun 2026 18:03:21 +0800
Message-ID: <20260612100321.452007-1-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397AF:EE_|MN2PR12MB4206:EE_
X-MS-Office365-Filtering-Correlation-Id: 3daf8156-7e53-4132-5a08-08dec869dd2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700016|23010399003|6133799003|18002099003|3023799007|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: jf+j2gv3HJZ7fLy7pEY6aH6BHJ+IyQVE/jYmOnW98Ljxr7118qSg1I7tIhIxDy9RY8UJswkctUtJmijVptvVxb5aBZNMvXISyCcPVoCe/Ab+rb4KafquFqz0ys0ayJMbagewceFKoXlFe/f8YxxVStCaxLlbcmhd3OB+e0BQbI9adwfHhKvdco088LDqOXBr8RoVzMxJav295YCB28V9V5Iz/DfF3pFRxLCt15j//gFgvtaAmGlmu9nEq/0rrZ2twBqEZDEpQrlOQzyY1wcMb4lEWVnhfQfnkUIPCVu5qStGjr7cpHjYQlulRL5GUCWkcyeHEv1OV2g77Do32cgFw1xHd5M5QSC4We0Qts9MHsWjSf/bLz5CkLGIjBggVyfsBpcTi8JhxO4qA1dSP7KxosNu0yixJ2ukqT1o/dYAu2iel3E8k5//p5vMVRZlP819NkAb0vHNlNvGcPoQ5o2HVafiwZYWfQ5Z59RyRfpWmAMPxNGmR3izK/4Ln222bUBSMKvSJrNESxNfESnuzKkIZ8BzKHkMhmeH3XesFDhMjUObM+HerHvcsqQUrHVA+8uwHV2Hrywpa47+rrpYzCu6YH5PzHOtc4b2g04IC5lZ+oNoISOf1rDSIM9awJG6+YAg/VmnGR4Ywu7uQXbdTkn9ntyZh8zxRlyNC7cT9xcqk53XQ3t2ZcLjKuONW4i4uN3cvtfu3LWb9k17GGTBWJcgb5Rc9yuAMTnuxigZRlsUD7c=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700016)(23010399003)(6133799003)(18002099003)(3023799007)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: iajn6/yLTvxgV+ILpAdkiIHnQ+VCpYoxrIVYG+8GIM9j1RFjuCoMIpb5zgKVuSIUakJxxgbIdKMoh5Rbm58on5sEbRDsZXV/pUQ+IqHWaZa6KAxJ2DOLxVaTWSDAyqnNT+S4ntQPx0BR5Era8djrMPzDA8OAr6ZyV1i6c6bO319THWvU3rq30V47+m2YEavY9HXxyVISO4Ao+yNt12Q6L/oelyIoyvqnjAYszr1ocf83kCqtnczSEaUQfYBk8yvwc8q/4Fzd5rb075lJyOAjxWLBXENTPsDajSx8y185Urrk6dLOYicxcxoDHUdToyL+TXRiCAQOlV4VQ1uK7XOTd3sAiTVPmhqYJVtfqE3zXZP/HSHkcTCN/0AivJ0GFsfderkkde3QQAyRkVaHYbSp0KfkZuTTVQ3DNiToMDCntaSblsPbxc4Xw34J0Vepjbli
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2026 10:03:34.0524 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3daf8156-7e53-4132-5a08-08dec869dd2f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397AF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4206
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

Add the disable_pci_ids module parameter to let amdgpu skip selected
PCI devices before normal device initialization starts.

This is useful on multi-GPU systems where only a subset of devices should
be claimed by amdgpu, and for bring-up or debug cases where early probe of
specific devices needs to be avoided.

The parameter accepts a comma-separated list of hex PCI IDs. The device
ID is required, while the vendor ID and revision ID are optional:

  device ID
  vendor ID:device ID
  vendor ID:device ID:revision ID

For example:
  # cat /proc/cmdline
  amdgpu.disable_pci_ids=73bf,1002:7550:c0

Kernel log:
[ 3327.298156] amdgpu 0000:63:00.0: skipping PCI device [1002:7550] (rev c0) by module parameter

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 175 ++++++++++++++++++++++++
 1 file changed, 175 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 503bb64c1e55..48aded458987 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -35,9 +35,11 @@
 #include <linux/cc_platform.h>
 #include <linux/console.h>
 #include <linux/dynamic_debug.h>
+#include <linux/kstrtox.h>
 #include <linux/module.h>
 #include <linux/mmu_notifier.h>
 #include <linux/pm_runtime.h>
+#include <linux/string.h>
 #include <linux/suspend.h>
 #include <linux/vga_switcheroo.h>
 
@@ -183,6 +185,7 @@ uint amdgpu_pg_mask = 0xffffffff;
 uint amdgpu_sdma_phase_quantum = 32;
 char *amdgpu_disable_cu;
 char *amdgpu_virtual_display;
+char amdgpu_disable_pci_ids[256];
 int amdgpu_enforce_isolation = -1;
 int amdgpu_modeset = -1;
 
@@ -564,6 +567,28 @@ MODULE_PARM_DESC(virtual_display,
 		 "Enable virtual display feature (the virtual_display will be set like xxxx:xx:xx.x,x;xxxx:xx:xx.x,x)");
 module_param_named(virtual_display, amdgpu_virtual_display, charp, 0444);
 
+/**
+ * DOC: disable_pci_ids (string)
+ * Comma separated list of PCI IDs to skip during probe.
+ *
+ * This can be useful on multi-GPU systems where only a subset of devices
+ * should be claimed by amdgpu, or for bring-up and debug cases where early
+ * probe of specific devices needs to be avoided.
+ *
+ * The device ID is required. Vendor ID and revision ID are optional. Hex IDs
+ * with or without a 0x prefix are accepted. Valid formats are:
+ *
+ * - device ID
+ * - vendor ID:device ID
+ * - vendor ID:device ID:revision ID
+ *
+ * For example: disable_pci_ids=73bf,1002:73df:01.
+ */
+MODULE_PARM_DESC(disable_pci_ids,
+		 "Skip probing devices matching PCI ID patterns: device ID, vendor ID:device ID, or vendor ID:device ID:revision ID");
+module_param_string(disable_pci_ids, amdgpu_disable_pci_ids,
+		    sizeof(amdgpu_disable_pci_ids), 0444);
+
 /**
  * DOC: lbpw (int)
  * Override Load Balancing Per Watt (LBPW) support (1 = enable, 0 = disable). The default is -1 (auto, enabled).
@@ -2216,6 +2241,149 @@ static const struct amdgpu_asic_type_quirk asic_type_quirks[] = {
 
 static const struct drm_driver amdgpu_kms_driver;
 
+struct amdgpu_disabled_pci_id {
+	u16 vendor;
+	u16 device;
+	u8 revision;
+	bool has_vendor;
+	bool has_revision;
+};
+
+static int amdgpu_parse_disabled_pci_id_field(const char *str, u16 *id)
+{
+	if (!strncasecmp(str, "0x", 2))
+		str += 2;
+
+	return kstrtou16(str, 16, id);
+}
+
+static int amdgpu_parse_disabled_pci_revision(const char *str, u8 *revision)
+{
+	if (!strncasecmp(str, "0x", 2))
+		str += 2;
+
+	return kstrtou8(str, 16, revision);
+}
+
+static int amdgpu_parse_disabled_pci_id(const char *str,
+					struct amdgpu_disabled_pci_id *id)
+{
+	char pci_id[32], *fields[3], *tmp;
+	int count = 0;
+
+	strscpy(pci_id, str, sizeof(pci_id));
+	tmp = pci_id;
+
+	while (tmp && count < ARRAY_SIZE(fields))
+		fields[count++] = strsep(&tmp, ":");
+
+	if (tmp || !count)
+		return -EINVAL;
+
+	id->has_vendor = false;
+	id->has_revision = false;
+
+	switch (count) {
+	case 1:
+		if (!fields[0][0])
+			return -EINVAL;
+
+		return amdgpu_parse_disabled_pci_id_field(fields[0],
+							  &id->device);
+	case 2:
+		if (!fields[0][0] || !fields[1][0])
+			return -EINVAL;
+
+		if (amdgpu_parse_disabled_pci_id_field(fields[0],
+						       &id->vendor))
+			return -EINVAL;
+
+		if (amdgpu_parse_disabled_pci_id_field(fields[1],
+						       &id->device))
+			return -EINVAL;
+
+		id->has_vendor = true;
+		return 0;
+	case 3:
+		if (!fields[0][0] || !fields[1][0] || !fields[2][0])
+			return -EINVAL;
+
+		if (amdgpu_parse_disabled_pci_id_field(fields[0],
+						       &id->vendor))
+			return -EINVAL;
+
+		if (amdgpu_parse_disabled_pci_id_field(fields[1],
+						       &id->device))
+			return -EINVAL;
+
+		if (amdgpu_parse_disabled_pci_revision(fields[2],
+						       &id->revision))
+			return -EINVAL;
+
+		id->has_vendor = true;
+		id->has_revision = true;
+		return 0;
+	default:
+		return -EINVAL;
+	}
+}
+
+static bool amdgpu_disabled_pci_id_match(struct pci_dev *pdev,
+					 const struct amdgpu_disabled_pci_id *id)
+{
+	if (id->device != pdev->device)
+		return false;
+
+	if (id->has_vendor && id->vendor != pdev->vendor)
+		return false;
+
+	if (id->has_revision && id->revision != pdev->revision)
+		return false;
+
+	return true;
+}
+
+static bool amdgpu_device_id_disabled(struct pci_dev *pdev)
+{
+	const char *ids = amdgpu_disable_pci_ids;
+	char id[32];
+	struct amdgpu_disabled_pci_id pci_id;
+	size_t len;
+
+	while (*ids) {
+		ids += strspn(ids, ",; \t\n");
+		if (!*ids)
+			break;
+
+		len = strcspn(ids, ",; \t\n");
+
+		if (len >= sizeof(id)) {
+			dev_warn(&pdev->dev,
+				 "invalid disabled PCI id '%.*s'\n",
+				 (int)len, ids);
+			ids += len;
+			continue;
+		}
+
+		memcpy(id, ids, len);
+		id[len] = '\0';
+
+		if (amdgpu_parse_disabled_pci_id(id, &pci_id)) {
+			dev_warn(&pdev->dev,
+				 "invalid disabled PCI id '%s'\n", id);
+			ids += len;
+			continue;
+		}
+
+		if (amdgpu_disabled_pci_id_match(pdev, &pci_id))
+			return true;
+
+		ids += len;
+	}
+
+	return false;
+}
+
 static void amdgpu_get_secondary_funcs(struct amdgpu_device *adev)
 {
 	struct pci_dev *p = NULL;
@@ -2389,6 +2557,13 @@ static int amdgpu_pci_probe(struct pci_dev *pdev,
 			return -EINVAL;
 	}
 
+	if (amdgpu_device_id_disabled(pdev)) {
+		dev_info(&pdev->dev,
+			 "skipping PCI device [%04x:%04x] (rev %02x) by module parameter\n",
+			  pdev->vendor, pdev->device, pdev->revision);
+		return -ENODEV;
+	}
+
 	/* skip devices which are owned by radeon */
 	for (i = 0; i < ARRAY_SIZE(amdgpu_unsupported_pciidlist); i++) {
 		if (amdgpu_unsupported_pciidlist[i] == pdev->device)
-- 
2.47.3

