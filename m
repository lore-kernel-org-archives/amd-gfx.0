Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35F4EC5DF7D
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2026 19:54:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C516010F4E1;
	Fri, 21 Aug 2026 19:54:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="s0fXRRWm";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010054.outbound.protection.outlook.com [52.101.56.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CAA6B10F4E1
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2026 19:54:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SRQu1nxYGaLdenq6dtWhUQcbx5ZcsHZ8NxCV47v7HaJzw2JBzIsWN670xxZSXW9uGI/MrpJekxgauVHKbP1wMvhC8yUW9P5yDNoeMckAsPzv7ek6Gj226NcZAljeKmdXFl4MOMGndB7R4W7Qwfy8IjUcy/tz22LS+9klFGB2EWQAG2afrHmbg8LwAyIzCGIctFbCy7d1nyaU+qZZoG8Cq5Llttz0WQpQgWNgSqWqK/yeA9nPhAocz8ySaM397sozQMwOdmpN72F1Xti5zRit7dmh2ljBruU5HkC0c/Hi0uQDlWcQkNvhqQa1WxUpR/pqTau9SyJltNVEZiSDE5baeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yt9evugY6Cbv+sC9bkcb9Jp6ORlYAMj76/pVsj1Bprg=;
 b=xZ0EamulY15d5KGoqGuc8C6GF7WxfetOToIpFKHuIyFgUQjdHfHBg2Y5/15zmer2R3T3HroVRNQJ/9o5HSCpLADshOGFmYvTjnYU1EOPA2zmpKUchTeCTexeIBkSjbnzHh36rF4QAzkK13qUUQSqbR7wPYNusQuNmPvvuoq9d2VDK8DKwZz/Lr3X6lk/RWP4D1bxuOKkr3u5HrJtU1QLLj/ySs9Wy9hQXf/4Pp4MMOiUu/HhDw2Iix2VzxZl8d+z+Iwnx0eVQec9aN3X+nQg3ZgNnDpVqB0eyrI4mQp1s9ACRVa0BL9rVIzBXEVQXZCHrgjm3IhcdKZ+W7+7NJk35Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yt9evugY6Cbv+sC9bkcb9Jp6ORlYAMj76/pVsj1Bprg=;
 b=s0fXRRWmhVxmgI0oNhWdB8qcB4311RQY1eTo4Z0VE2ew6FNtb+9XgeZfL5J4N678m/GWDx+P7365wDRAZtRcESNIAMBTJ3lApwB7/UtN4QmTDFyLf/nFJC0O7l8298rDBASM/c6plWXOpdh9I99c6KmSNHgaTjn2fmhbPdCdHZQ=
Received: from CH0PR03CA0071.namprd03.prod.outlook.com (2603:10b6:610:cc::16)
 by SJ2PR12MB8876.namprd12.prod.outlook.com (2603:10b6:a03:539::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.10; Fri, 21 Aug
 2026 19:35:19 +0000
Received: from CH1PEPF0000AD82.namprd04.prod.outlook.com
 (2603:10b6:610:cc:cafe::34) by CH0PR03CA0071.outlook.office365.com
 (2603:10b6:610:cc::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.11 via Frontend Transport; Fri,
 21 Aug 2026 19:35:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD82.mail.protection.outlook.com (10.167.244.91) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 19:35:17 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 14:35:13 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 21 Aug 2026 14:35:13 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Felix Kuehling <felix.kuehling@amd.com>, Mukul Joshi
 <mukul.joshi@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 03/95] drm/amdgpu: Add sysfs API for UALink information
Date: Fri, 21 Aug 2026 15:33:26 -0400
Message-ID: <20260821193458.808626-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821193458.808626-1-alexander.deucher@amd.com>
References: <20260821193458.808626-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD82:EE_|SJ2PR12MB8876:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f87155e-2209-497c-a1ad-08deffbb54ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|36860700016|82310400026|1800799024|6133799003|10067099003|11063799006|56012099006|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: KTD0mAle/nm85u8tLpVlUbxyursjywCjlVQ5jyVoY0LzJNq0ZvBTUNWTPC48MoKokd4mrollqxc1+jD5M14t1hqfAs5AvvlPn8ad+16Md0DRRxNLXGn9FdfU2qbIxkXis+uJUK3HAoQH5vCwVQTSrM4P+U5Nrgkrbr446M37/8rPpavFd7XHaTazMtqUqKHMev8YJ06zKS92Wzc05EDoS7cTQqs5tj90KHZHeDcS7cBGUHk+kw4eVgMDKfAY8xaNXS/Uj5hHs9g8w3KabXZY0M5GiG0or5cTW+1ePOAd+1rWcZaaf9q+v0tISQ07Ca1R3LTy4XfqptONMNb0jdexQhcTirSKk9c0z3kO4+KsrBjR3Qh9G1/2XMR4YcPh1fHMPAsPxR8teTeqtTlUuxhCKfkUXVgTVVeFeH5RToT1Edf5ED898IvHKLFCFGhEVkjklsPM2u3e8v6rmK/Bi9IVAOcQpW3v9jjKbf4sRraINi8Q9ixIYioVJd2aU0AiLfXdx3430DS5JJTdSLYoSP1P7/qhzzot1bTohmX09gEQNY5hsPY2HSjF11GODXq40Mz5KfJkiU46R+cLuTOUGIwnnVxcJV3PDrX79zKca4Ee43I4aN6mgpI/A7oa1qU+ss62AGn5Li1K0AmBfCp718UyuAalpcr9Iuy3RhgPs29c/uFLjxM6iZ0x7hW5t0hrpGqRwoUYgHjANthzHiuG9dgDdw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(36860700016)(82310400026)(1800799024)(6133799003)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: iEfx5buAoa8yJCpvcHVefTWfuqtzH8KIWM1pcV+g1gTpXX7NdYqCE9NIq9JS/XVrLlCRwtDF4ba8j4ZWX7gaQCJYOpD+Mi0Q8HPmevE43RR78Lkq/BUyGs2INIaKX9+F1DYxl0E3X8N0goWXBOM4mfo3BtN1+S7A2abMq1lTftP1xiUEH/K8MSPShd2d5ZWcB64hMO+fRnlkMWjbqx85M0+ET7bvzS0BI6GevbW+JE/OGp6lq5KVJTnNiqXwYHf81ErReUFaryhxlWL0i/2eJKng0VZ9N3fLqJZBu3qyeLRHqEABBNZ/gLkJBft7wpgB/abNsHxZ5Tm1cgAWuK2ygf6hjF+i2SXmAchMW0eGUKM3qhhECsvCXmOdYBlKpD04adKy2a0bdBC0G/YrcXchmccmNt37NUI3E3BJ2LXrdv+WgeEsju1E4Z1O9aOhXJuy
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 19:35:17.7121 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f87155e-2209-497c-a1ad-08deffbb54ab
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD82.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8876
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h |  93 +++++++++
 drivers/gpu/drm/amd/amdgpu/soc_v1_0.c      |  12 ++
 5 files changed, 338 insertions(+)
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
index 0000000000000..390fb5653aaf5
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
@@ -0,0 +1,93 @@
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

