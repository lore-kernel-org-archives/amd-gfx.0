Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6EC4C61DD3
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Aug 2026 18:28:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 40B7410E70D;
	Mon, 31 Aug 2026 18:28:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OM8eVwfs";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010039.outbound.protection.outlook.com [52.101.56.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B12D10E50F
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Aug 2026 18:28:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e8TP/EfH7gHD47ISHaEXwYcqcDyzb95IbWh8XONMUgmd0ibdMCt3/7w+qca39GCClxtCGLwUEXaYZPH3AOwf2BKQjFEn14OF0d1VsqNWfku/9/s2tFqsBQUrpIJgSOLgLkanWg+6yc/u2l5MOpZc3jhD0khC3s0stKPpA5xzjjMI2YPxggqZNmRW0sgPPI2OeI2GM5VMB+ATYvqxL4PUgQ8PVTQH5rmWRqMiKRe/8saBUZF2YftKRqRix2SN3rGfD2Wn6oO+yh7PcHufiyLY1m1qKAjmFgtjrs+MkxcTbh0fIwVcfkBP41drKJqhVhhB+l+o32OXnb1h+DUYnrxEqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UrTS30EUv84idFiaaXQbD36fBtdE5RPvPRp7S6gFmHM=;
 b=Cwu4yUEmm7T3McpfbtZ5zf4Ovvo6zH5KuFyosGYm6qs8AKt5gI7zLV3jOsbpanQ6dHJq7IhBZYtiACOPpvXqtx1wccF1TVahVcditg3C5o5Ha6YwSj0yiB1TzVrijWD7tpdqZJ3STfi1agkyuhrCSf4BiBDFV/Niack5MCgX+LbCnbcEj+37nIhFIi8KNvh3q00gaCmJKr58ClrXRDwXjXV44kj0Y66AFKkxRdbnuVO4lCwXKRVC02DTQNyKfoLKvpYPXJIGPqQtoEI2cAAv+Sv4XtIrRucjorlHJ3zLX28QOotV8Quv8gDqHuxXfMziiq0CCVCvHC8jgWddIFnFDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UrTS30EUv84idFiaaXQbD36fBtdE5RPvPRp7S6gFmHM=;
 b=OM8eVwfsPANvHKoHsCuEPDly2h6zMEG35Zj0bcJ287UJvLnEFKZWxA/O4VydbzzL+abUwuJFQgNieLaDsWpMqFOpsEEQgcbQWnG7Nt9X6RqgACmVDy8Yd+P719txuqGf4zQiwkb2GRhUPwThTWOwpBX/0KrTkQQo1K226VadfwM=
Received: from PH1PEPF0001330A.namprd07.prod.outlook.com (2603:10b6:518:1::19)
 by MW4PR12MB6923.namprd12.prod.outlook.com (2603:10b6:303:208::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 18:28:17 +0000
Received: from SA2PEPF00001507.namprd04.prod.outlook.com
 (2a01:111:f403:c801::2) by PH1PEPF0001330A.outlook.office365.com
 (2603:1036:903:47::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Mon,
 31 Aug 2026 18:28:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SA2PEPF00001507.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Mon, 31 Aug 2026 18:28:16 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 31 Aug
 2026 13:28:08 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 31 Aug
 2026 13:28:08 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Mon, 31 Aug 2026 13:28:07 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Felix Kuehling <felix.kuehling@amd.com>, Mukul Joshi
 <mukul.joshi@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 03/95] drm/amdgpu: Add sysfs API for UALink information
Date: Mon, 31 Aug 2026 14:26:22 -0400
Message-ID: <20260831182754.1089811-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260831182754.1089811-1-alexander.deucher@amd.com>
References: <20260831182754.1089811-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001507:EE_|MW4PR12MB6923:EE_
X-MS-Office365-Filtering-Correlation-Id: 639d2e52-49b5-4eb0-cb24-08df078da03e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700016|23010399003|6133799003|3023799007|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: qyhQhK2LfJcpkZAzwPY3JtuB/E3RSAa00YIQKPyGFIY4OwGRbcgDh1+29DxEd4ju5vE5Pik8aB7GPDTToWnR9WGPhJIGo++MuXlfpSMpDkl8QJPE5o40CzE7q1C/54v7O9V1gQ94LVWmzZfj7ICy1qrbq785ZLjdmEKnpogLjY0z0kkG4cWVI0l8u62CQ3U10Qk6I9id8JnQ6MoYwwRnttfPgOpI0sABAZMStLG9bDYnI8frAS35flzCEUUK5fcjzUBwIo4LcC1AnsvSoAstU96fVppu7/x0Pg+j/S34+k84QFxZNWalMfeD05i/0ZCbvcUaM/JPewmIXWNXcNlD5OPq7NWiEUGbc8Wt9edIL2E9kLTu8vz0I+YOZL1l627WukPLdkeORd3rnAplSQFgAvMr1Be0ybmqVOlv4vG590feJPcpLb4Mx7HRODy5Y1olxxBB9K5dc87brQfl58U+fOtz7abYpN2CHGlrAonQ0y6W87nBzjhU8GXURjEHhOOPXkKCzWG+gg9Wchx/Xx92qffQL17cvLkAJnfsszyA2RQrEZReP1zt6/SHWwJgGCu0SY+yX33eypI8WkGsMLRbn5X56dscLcKkzWHkOWGifjLGZGTGsoSYWMdfDwGDeGn7guOVeu8gA2jjdIkdKJXPNLYuJuoql6JsFB4cz8gSEkjlia6cEcCJpNBnYE2vIf4+Edh7b+aoiry4M9H6kEPvog==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700016)(23010399003)(6133799003)(3023799007)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: qd98ArjZvaRF+A8qXSCkJa7I/KSeqO8J/wsgH9pHdrKyvIqcKwtb0tvWmWDbcL8DcMSsUVABq7JoNzFXRXNjh3wwLjg+GZZKL7RQgNYsTt1z9ZuURficjoqiHPKpBqv0UjVU1HKxgg2/vhuanvcrLtU9eGODlCkFD9ny3x2L+Bo1IRati2kFQKxxRWx7zPR7vh0yj6spp+TAT30kQQo7eoVW/YomDKRGp3ZNgRIEWG3d/g3Mo0a5gYhKIQyIZRl1pXGuRgAv9rJeVoNWA3+H5szzwcBHbeCPw4rwOQqNoIrdY+rcH7y6b4YcuMZV5FtM8PyNKUxVu8nUKDUTBUxCMcK/ZaXZaHW2BZgXmx4ez38gc6sZ2czx+PLxAYvShTexUuDLhjarPKMmRE9zzo3RSm0cnm8QUFJ23kxs/i2/BC0o2QT/FE8szWRutRz71Oz+
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 18:28:16.9538 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 639d2e52-49b5-4eb0-cb24-08df078da03e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001507.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6923
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

From: Felix Kuehling <felix.kuehling@amd.com>

<device>/ualink/info: Directory contains current UALink attributes
- link_type: UALoE of UALink
- accel_state: unconfigured, configured, ready, active, error
- accel_id: Accelerator ID
- ppod_id: Physical pod ID (UUID)
- ppod_size: Number of accelerators in physical pod
- bandwidth: Estimated total bandwidth between pairs of accelerators
- latency: Estimated latency between pairs of accelerators
- vpod_id: Virtual pod ID
- vpod_size: Number of accelerators in virtual pod
- vpod_active_accels: List of all accelerator IDs in vpod
- local_accels: List of local accelerator IDs in vpod
- addr_mode: source-aliasing or source-identification

Signed-off-by: Felix Kuehling <felix.kuehling@amd.com>
Reviewed-by: Mukul Joshi <mukul.joshi@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Makefile        |   3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |   4 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 226 +++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h |  97 +++++++++
 drivers/gpu/drm/amd/amdgpu/soc_v1_0.c      |  12 ++
 5 files changed, 342 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index ffb725fb10842..bb33119608a06 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -278,6 +278,9 @@ amdgpu-y += amdgpu_amdkfd.o
 # add gfx usermode queue
 amdgpu-y += amdgpu_userq.o
 
+# add UALink manager support
+amdgpu-y += amdgpu_ualink.o
+
 ifneq ($(CONFIG_HSA_AMD),)
 AMDKFD_PATH := ../amdkfd
 include $(FULL_AMD_PATH)/amdkfd/Makefile
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 8a7c89afc88e1..f619d95a5ccfe 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -116,6 +116,7 @@
 #include "amdgpu_mes.h"
 #include "amdgpu_sa.h"
 #include "amdgpu_acpi.h"
+#include "amdgpu_ualink.h"
 #if defined(CONFIG_DRM_AMD_ISP)
 #include "amdgpu_isp.h"
 #endif
@@ -799,6 +800,9 @@ struct amdgpu_device {
 	/* display related functionality */
 	struct amdgpu_display_manager dm;
 
+	/* UALink manager */
+	struct amdgpu_ualink_mgr	ualink;
+
 #if defined(CONFIG_DRM_AMD_ISP)
 	/* isp */
 	struct amdgpu_isp		isp;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
new file mode 100644
index 0000000000000..374242372eab7
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
@@ -0,0 +1,226 @@
+// SPDX-License-Identifier: GPL-2.0 OR MIT
+/*
+ * Copyright 2026 Advanced Micro Devices, Inc.
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
+#include "amdgpu_ualink.h"
+#include "amdgpu_xgmi.h"
+#include "amdgpu.h"
+#include <linux/sysfs.h>
+#include <linux/string.h>
+
+
+/****************************************************************************
+ * UALink info and configuration in sysfs
+ *
+ * Using kobj_attribute and not device_attribute here because the UALink
+ * attributes are part of their own nested kobjects and not the amdgpu
+ * device itself or a subdevice.
+ ****************************************************************************/
+
+#define UALINK_VALUE_SHOW(prefix, name, field, format)			\
+static ssize_t ualink_##prefix##_##name##_show(struct kobject *kobj,	\
+					       struct kobj_attribute *attr,\
+					       char *buf)		\
+{									\
+	struct amdgpu_ualink_##prefix *info = to_ualink_##prefix(kobj);	\
+									\
+	return sysfs_emit(buf, format"\n", info->field);		\
+}
+
+static ssize_t show_idbits(unsigned long *bits, unsigned int nbits, char *buf)
+{
+	ssize_t len = 0;
+	unsigned int id;
+
+	for_each_set_bit(id, bits, nbits)
+		len += sysfs_emit_at(buf, len, "%u ", id);
+	if (len)
+		len--;
+	return len + sysfs_emit_at(buf, len, "\n");
+}
+#define UALINK_IDBITS_SHOW(prefix, name, field)				\
+static ssize_t ualink_##prefix##_##name##_show(struct kobject *kobj,	\
+					       struct kobj_attribute *attr,\
+					       char *buf)		\
+{									\
+	struct amdgpu_ualink_##prefix *info = to_ualink_##prefix(kobj);	\
+									\
+	return show_idbits(info->field, sizeof(info->field)*8, buf);	\
+}
+
+static ssize_t show_idarray(const u32 *array, u32 size, char *buf)
+{
+	ssize_t len = 0;
+	unsigned int i;
+
+	for (i = 0; i < size; i++)
+		len += sysfs_emit_at(buf, len, "%u ", array[i]);
+	if (len)
+		len--;
+	return len + sysfs_emit_at(buf, len, "\n");
+}
+#define UALINK_IDARRAY_SHOW(prefix, name, field, size)			\
+static ssize_t ualink_##prefix##_##name##_show(struct kobject *kobj,	\
+					       struct kobj_attribute *attr,\
+					       char *buf)		\
+{									\
+	struct amdgpu_ualink_##prefix *info = to_ualink_##prefix(kobj);	\
+									\
+	return show_idarray(info->field, info->size, buf);		\
+}
+
+#define UALINK_UUID_SHOW(prefix, name, field)				\
+static ssize_t ualink_##prefix##_##name##_show(struct kobject *kobj,	\
+					       struct kobj_attribute *attr,\
+					       char *buf)		\
+{									\
+	struct amdgpu_ualink_##prefix *info = to_ualink_##prefix(kobj);	\
+									\
+	return sysfs_emit(buf, "%pU\n", &info->field);			\
+}
+
+static ssize_t show_enum(u32 x, const char * const values[], unsigned int n,
+			 char *buf)
+{
+	return sysfs_emit(buf, "%s\n", x < n && values[x] ? values[x] : "invalid");
+}
+#define UALINK_ENUM_SHOW(prefix, name, field)				\
+static ssize_t ualink_##prefix##_##name##_show(struct kobject *kobj,	\
+					       struct kobj_attribute *attr,\
+					       char *buf)		\
+{									\
+	struct amdgpu_ualink_##prefix *info = to_ualink_##prefix(kobj);	\
+									\
+	return show_enum(info->field, ualink_##name##_values,		\
+			 ARRAY_SIZE(ualink_##name##_values), buf);	\
+}
+
+static const char * const ualink_link_type_values[] = {
+	"UALoE", "UALink"
+};
+static const char * const ualink_addr_mode_values[] = {
+	"source-aliasing", "source-identification"
+};
+static const char * const ualink_accel_state_values[] = {
+	"unconfigured", "configured", "ready", "active", "error"
+};
+
+UALINK_ENUM_SHOW(info, link_type, link_type);
+UALINK_VALUE_SHOW(info, accel_id,  ppod.accel_id,  "%u");
+UALINK_VALUE_SHOW(info, bandwidth, ppod.bandwidth, "%u");
+UALINK_VALUE_SHOW(info, latency,   ppod.latency,   "%u");
+UALINK_UUID_SHOW(info, ppod_id, ppod.id);
+UALINK_VALUE_SHOW(info, ppod_size, ppod.size,      "%u");
+UALINK_VALUE_SHOW(info, vpod_id,   vpod.id,        "%u");
+UALINK_VALUE_SHOW(info, vpod_size, vpod.size,      "%u");
+UALINK_IDBITS_SHOW(info, vpod_active_accels, vpod.active_accel_bits);
+UALINK_ENUM_SHOW(info, addr_mode, vpod.addr_mode);
+UALINK_ENUM_SHOW(info, accel_state, accel_state);
+UALINK_IDARRAY_SHOW(info, local_accels, local_accels, n_local_accels);
+
+#define UALINK_INFO_ATTR(name) __ATTR(name, 0444, ualink_info_##name##_show, NULL)
+static struct kobj_attribute ualink_info_link_type = UALINK_INFO_ATTR(link_type);
+static struct kobj_attribute ualink_info_accel_id  = UALINK_INFO_ATTR(accel_id);
+static struct kobj_attribute ualink_info_bandwidth = UALINK_INFO_ATTR(bandwidth);
+static struct kobj_attribute ualink_info_latency   = UALINK_INFO_ATTR(latency);
+static struct kobj_attribute ualink_info_ppod_id   = UALINK_INFO_ATTR(ppod_id);
+static struct kobj_attribute ualink_info_ppod_size = UALINK_INFO_ATTR(ppod_size);
+static struct kobj_attribute ualink_info_vpod_id   = UALINK_INFO_ATTR(vpod_id);
+static struct kobj_attribute ualink_info_vpod_size = UALINK_INFO_ATTR(vpod_size);
+static struct kobj_attribute ualink_info_vpod_active_accels = UALINK_INFO_ATTR(vpod_active_accels);
+static struct kobj_attribute ualink_info_addr_mode = UALINK_INFO_ATTR(addr_mode);
+static struct kobj_attribute ualink_info_accel_state = UALINK_INFO_ATTR(accel_state);
+static struct kobj_attribute ualink_info_local_accels = UALINK_INFO_ATTR(local_accels);
+
+static const struct attribute *ualink_info_attrs[] = {
+	&ualink_info_link_type.attr,
+	&ualink_info_accel_id.attr,
+	&ualink_info_bandwidth.attr,
+	&ualink_info_latency.attr,
+	&ualink_info_ppod_id.attr,
+	&ualink_info_ppod_size.attr,
+	&ualink_info_vpod_id.attr,
+	&ualink_info_vpod_size.attr,
+	&ualink_info_vpod_active_accels.attr,
+	&ualink_info_addr_mode.attr,
+	&ualink_info_accel_state.attr,
+	&ualink_info_local_accels.attr,
+	NULL
+};
+
+static void ualink_info_release(struct kobject *kobj)
+{
+	struct amdgpu_ualink_info *info = to_ualink_info(kobj);
+
+	kfree(info);
+}
+
+static const struct kobj_type ualink_info_ktype = {
+	.release = ualink_info_release,
+	.sysfs_ops = &kobj_sysfs_ops
+};
+
+int amdgpu_ualink_sysfs_init(struct amdgpu_device *adev)
+{
+	struct amdgpu_ualink_info *info = NULL;
+	int r;
+
+	info = kzalloc(sizeof(*info), GFP_KERNEL);
+	if (!info)
+		return -ENOMEM;
+
+	info->ppod.accel_id = 0xffffffff;
+	info->ppod.bandwidth = 0xffffffff;
+	info->ppod.latency = 0xffffffff;
+	info->vpod.id = 0xffffffff;
+	info->vpod.addr_mode = AMDGPU_UALINK_ADDR_MODE_MAX;
+
+	r = kobject_init_and_add(&info->kobj, &ualink_info_ktype,
+				 &adev->dev->kobj, "ualink");
+	if (r)
+		goto err_put_info;
+	r = sysfs_create_files(&info->kobj, ualink_info_attrs);
+	if (r)
+		goto err_del_info;
+
+	adev->ualink.info = info;
+
+	return r;
+
+err_del_info:
+	kobject_del(&info->kobj);
+err_put_info:
+	kobject_put(&info->kobj);
+	return r;
+}
+
+void amdgpu_ualink_sysfs_fini(struct amdgpu_device *adev)
+{
+	if (adev->ualink.info) {
+		sysfs_remove_files(&adev->ualink.info->kobj,
+				   ualink_info_attrs);
+		kobject_del(&adev->ualink.info->kobj);
+		kobject_put(&adev->ualink.info->kobj);
+		adev->ualink.info = NULL;
+	}
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
new file mode 100644
index 0000000000000..9c492e7518d9f
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
@@ -0,0 +1,97 @@
+/* SPDX-License-Identifier: GPL-2.0 OR MIT */
+/*
+ * Copyright 2026 Advanced Micro Devices, Inc.
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
+#ifndef AMDGPU_UALINK_H
+#define AMDGPU_UALINK_H
+
+#include <linux/uuid.h>
+#include <linux/bitmap.h>
+#include <linux/kobject.h>
+
+struct amdgpu_device;
+
+#define AMDGPU_UALINK_ACCEL_MAX 256
+#define AMDGPU_UALINK_LOCAL_ACCELS_MAX 8
+
+enum amdgpu_ualink_type {
+	AMDGPU_UALINK_TYPE_UALOE = 0,
+	AMDGPU_UALINK_TYPE_UALINK = 1,
+	AMDGPU_UALINK_TYPE_MAX
+};
+
+enum amdgpu_ualink_accel_state {
+	AMDGPU_UALINK_ACCEL_STATE_UNCONFIGURED = 0,
+	AMDGPU_UALINK_ACCEL_STATE_CONFIGURED,
+	AMDGPU_UALINK_ACCEL_STATE_READY,
+	AMDGPU_UALINK_ACCEL_STATE_ACTIVE,
+	AMDGPU_UALINK_ACCEL_STATE_ERROR,
+	AMDGPU_UALINK_ACCEL_STATE_MAX
+};
+
+enum amdgpu_ualink_addr_mode {
+	AMDGPU_UALINK_ADDR_MODE_SOURCE_ALIAS = 0,
+	AMDGPU_UALINK_ADDR_MODE_SOURCE_IDENT = 1,
+	AMDGPU_UALINK_ADDR_MODE_MAX
+};
+
+/* Physical pod info shared between query and setup API */
+struct amdgpu_ualink_ppod_info {
+	u32 accel_id;
+	u32 bandwidth;
+	u32 latency;
+	u32 size;
+	uuid_t id;
+};
+
+/* Virtual pod info shared between query and config API */
+struct amdgpu_ualink_vpod_info {
+	u32 id;
+	u32 size;
+	u32 addr_mode;
+	DECLARE_BITMAP(active_accel_bits, AMDGPU_UALINK_ACCEL_MAX);
+};
+
+/* Query current UALink physical and virtual pod info */
+struct amdgpu_ualink_info {
+	struct kobject kobj;
+	enum amdgpu_ualink_type link_type;
+	enum amdgpu_ualink_accel_state accel_state;
+	struct amdgpu_ualink_ppod_info ppod;
+	struct amdgpu_ualink_vpod_info vpod;
+	/* Local accelerator array in the vpod derived from
+	 * vpod.active_accel_bits, in arbitrary order
+	 */
+	u32 n_local_accels;
+	u32 local_accels[AMDGPU_UALINK_LOCAL_ACCELS_MAX];
+};
+#define to_ualink_info(ko) container_of(ko, struct amdgpu_ualink_info, kobj)
+
+struct amdgpu_ualink_mgr {
+	struct amdgpu_ualink_info *info;
+};
+
+int amdgpu_ualink_sysfs_init(struct amdgpu_device *adev);
+void amdgpu_ualink_sysfs_fini(struct amdgpu_device *adev);
+
+#endif
diff --git a/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c b/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
index ac4a4de9c932a..d5f945617f488 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
@@ -444,6 +444,17 @@ static int soc_v1_0_common_late_init(struct amdgpu_ip_block *ip_block)
 
 static int soc_v1_0_common_sw_init(struct amdgpu_ip_block *ip_block)
 {
+	struct amdgpu_device *adev = ip_block->adev;
+
+	return amdgpu_ualink_sysfs_init(adev);
+}
+
+static int soc_v1_0_common_sw_fini(struct amdgpu_ip_block *ip_block)
+{
+	struct amdgpu_device *adev = ip_block->adev;
+
+	amdgpu_ualink_sysfs_fini(adev);
+
 	return 0;
 }
 
@@ -500,6 +511,7 @@ static const struct amd_ip_funcs soc_v1_0_common_ip_funcs = {
 	.early_init = soc_v1_0_common_early_init,
 	.late_init = soc_v1_0_common_late_init,
 	.sw_init = soc_v1_0_common_sw_init,
+	.sw_fini = soc_v1_0_common_sw_fini,
 	.hw_init = soc_v1_0_common_hw_init,
 	.hw_fini = soc_v1_0_common_hw_fini,
 	.suspend = soc_v1_0_common_suspend,
-- 
2.55.0

