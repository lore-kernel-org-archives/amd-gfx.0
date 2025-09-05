Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BDB8CA0FED
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Sep 2025 04:43:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC25510E2BB;
	Fri,  5 Sep 2025 04:43:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QdwqvKlq";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2061.outbound.protection.outlook.com [40.107.237.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE06F10E2BB
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Sep 2025 04:43:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=omWYD7MYbhNhH+FXQ8UEEQRiSIXK0DXjogN1Hr95C+2EB9d0UwedSNDjGptk18s2BqxQ5/f7qMLkP2i/FvPj4jKMck8YpEeu48hCQiHUqm8ti8ZKC0jTb2w0F2rofI2MgIhuqMWfUfzpKJ8mffZEj7Hl6kj2muj/ot/F0H+U+BwpK00EdrM7emqE5ET6Dn5h05AfDTRh4KENkkPeA2lsGUdCnPgOEu4Wf1XhXakWIfkN6E6ocBwYtYDTy0bJh0/zSIxUkih29D/W+QJGW/H1bFE3WkJGfNrSwT/wFKBtkoS6XGk5FbXwxQ3nptWaHY7qR5P3IcLNTd0Hf3Y1/677Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VkuAgAcNmt7x/fU3/FnXuSBVa5DrcI7+/bHAoIU77Ec=;
 b=PPJhboPyjfaWBax0y9QFDA8Di3nsGxwlkJfPElhEkMXB6Bw+lxZ2dsj502RCEatpaEXLC3I7sFi80wsZlVdsdA30e38vP1UwNtJdR0Gx0PDGZgC30aARvE4PloL046kvr6SoEqq8agfA5g9COaFLLciXXpFfe5kcVQyPqn6iCkEe1FaoRZFNEUJtGHZRRqZuiIAmZW3w0ZUdYTAKOdbwyx/5qSlmKl03pZUfZiOOD7O7bZ2G5mbsX4b9tGGi99RbjvOTyY5y0pJzYDxV7YIcfTSMIyz/wztUAkH/CChyHnVDk71fezYhKwERYi4VXRbU3xpWR/r+274WZMNeL07aIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VkuAgAcNmt7x/fU3/FnXuSBVa5DrcI7+/bHAoIU77Ec=;
 b=QdwqvKlqkUioa32LHeaMiKy8j705uhkCz/3Y1/NzjH8QmzbLxqh7/ep1QH01v7M6DcRFTqGSu0V7YfdZPDJeq53zC8fPTQisdycm/rRTlXaGM8jEn13Vc/eTl6M3RmEESc2Rm5SvzOZKIvTJlApv9mcPEcQaGlPXJctDm/njCWg=
Received: from BY5PR13CA0009.namprd13.prod.outlook.com (2603:10b6:a03:180::22)
 by SA1PR12MB8967.namprd12.prod.outlook.com (2603:10b6:806:38b::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Fri, 5 Sep
 2025 04:43:22 +0000
Received: from CY4PEPF0000EDD5.namprd03.prod.outlook.com
 (2603:10b6:a03:180:cafe::f6) by BY5PR13CA0009.outlook.office365.com
 (2603:10b6:a03:180::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.8 via Frontend Transport; Fri, 5
 Sep 2025 04:43:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000EDD5.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9094.14 via Frontend Transport; Fri, 5 Sep 2025 04:43:21 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 4 Sep
 2025 23:43:20 -0500
Received: from asad-mlse-vm.amd.com (10.180.168.240) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Thu, 4 Sep
 2025 21:43:18 -0700
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <lijo.lazar@amd.com>
CC: <hawking.zhang@amd.com>, <le.ma@amd.com>, <shiwu.zhang@amd.com>,
 <asad.kamal@amd.com>, <alexander.deucher@amd.com>
Subject: [PATCH 1/3] drm/amdgpu: Add generic capability class
Date: Fri, 5 Sep 2025 12:42:39 +0800
Message-ID: <20250905044301.1947978-1-asad.kamal@amd.com>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD5:EE_|SA1PR12MB8967:EE_
X-MS-Office365-Filtering-Correlation-Id: 9714fc5c-5374-4689-1811-08ddec36bdec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Tk45VHdieXVnSms5OGV5Q0Z2RzZVa2ZESWRIV1haNHZwMmpWU1M5NHF5SU1U?=
 =?utf-8?B?dlpzaGpUdXpmazNHbFkwMTZOMVVnQUpITnpQQmdHUUFIZ1VrcDFvbC9PdGtY?=
 =?utf-8?B?cjIyaUdZYUJuZGxoY0liMUVrcDVaWVpDMWRJU0NVeW9rQU1uQ3pXMWZKT3ND?=
 =?utf-8?B?czlSaTNpaUpqNjI4V25QMmNDclcxUGFuajhhK1hiUDlzakQ2NnRhbjRkc3pt?=
 =?utf-8?B?ZC9BWXpyT2VIVngzeVB3UEFNTThjTS9GK3R0eTh5U1pzN1RTT3d4cHB4elJr?=
 =?utf-8?B?ZFJpRDFtZTRPYnJKMHorcUpvZFRYZXZvdGpoSzVOMStzTjhUVFNmbDFhNG5T?=
 =?utf-8?B?WkxIZ2I3V1JsRTdONUIxeDlpTDBnb2xxTlpUZFFCcHAycEZkRU93M1RpL1NP?=
 =?utf-8?B?cytXLzhNTnZqQk1vZTFXbWdQTndjdWhMRFJkZ1draTU3M1hTbXBMNDQwMUFi?=
 =?utf-8?B?R3BlVUpRN29GdnVTaFVBeVdtUjRMMGc5TWJTd3NyTU9ScFhyYjNYQkV6MzNx?=
 =?utf-8?B?SGlZbFJaUkRTdkJIemxlclp5S3RMZTQ4M2ptbWx3WXRMM2pvOWhyRFRrNWFu?=
 =?utf-8?B?eTl3dHoxRWVwNzV0cmxzcy9iQ2ZVeW0rNTIxZW9jaDJHRlU4NmRINys3cWVi?=
 =?utf-8?B?SXJoYjZ3end5TS91cWgzMU5uZnFUUHVpNk9QSnhyRVlmNHdwSVJTcC92NktZ?=
 =?utf-8?B?eWFMcWkzQ1d1ME9FRFBINUtYdllBLzI4MHZFNHVsUWVKWHZkS2xTdUNoSVVs?=
 =?utf-8?B?Zmo4MGVyUW83YkhtRDByaCsvUDQxUEZWRy9nVjhKL1ZxbFBuOFNBdmw4KzhI?=
 =?utf-8?B?b1JxQ1NJbENTc0N0aitHM2oySVRlY250QW9HeWJ3dEVmK3lTNzJCTVVKcndt?=
 =?utf-8?B?YkFwYktyWE04YkZ1TS9xQW5JS1lLdU95T3dENUNrRUhpTDY1RERtby9PZGFP?=
 =?utf-8?B?eTFLQXJ4WEZueUw0WCtZUjdZN3VoYkVSdk5GT1BsbjZJcGxWYWdEWGJMcFBT?=
 =?utf-8?B?OTYyTUhKQWpQMWRYVXNpdUxmQ1RDdG1jMk10U3hpVzY3ZElNakJXZEFJNVVM?=
 =?utf-8?B?TGV6L2RIcDVSVElCZVg0QVhjVWJEQ0pFZ2VSVTczMEd3Rmw3WTJVTytVRlV2?=
 =?utf-8?B?STRQWDBNb0tBdlpKOVlmUk9Gd3czSG1VS1dncFZUblptL3lJZjdZS2NHNFIw?=
 =?utf-8?B?Z2haWlRWRjVXVjgvRlpzUWYyalQ0OHhnYXc4elNRQVowQWswUnFjajBkOUsz?=
 =?utf-8?B?eHc5dUFVcC9JSFhzT2JGVUgxUGZJdW9zMkRITE9Mb3A4anczQnVLM2EyUHVI?=
 =?utf-8?B?aW5TNTFXQkxRU0VuWjEzRVBkUit4MG9LMm1QZnhmVUk5eU85UXhTdVgwRU9o?=
 =?utf-8?B?UUZqU2d6UG1DcSt1MEdRRFA3NTZ4Y1VUYnBpNTFEK1lZZXpQZzN1QWtXaWV1?=
 =?utf-8?B?OTlSUk5HNFZUeWlnNlZvOTlLMW16R3k3Ym1hZllyTVBoVzNwNDRlUndXZjBL?=
 =?utf-8?B?NFdHamxkUWtuZDdBTkxQdlpySXRqTnpLOCt2RXk3ekFBamp1SktNWkExMmxq?=
 =?utf-8?B?USt5Y09LK25SdGtwa3U5SkZJUnZmRTZGTkQ0YVZ2bWZuWEtGL09SazhUUUpv?=
 =?utf-8?B?WEFzcE1lalJlRWFLeXAvVkliajhmekZDTVgxUUh6clNCdUl3bC9PMEFFVzNn?=
 =?utf-8?B?eXh4aUhCam1rYXFIK2F3cGFkQm9iYTlDNFI2NUpkMnVOWDhvVVVONXZtZWdF?=
 =?utf-8?B?TzJVNHFsb1BJT2pxbUNpMnY4OXhUbk1neEdZZ1JmcFoxRVVjNzRDQndacDEw?=
 =?utf-8?B?SmprczNhMW93bjFIS0RJaEQ5enpKRTY3NW5uWkl0Q3lxd1JQbVR5UzQxWHZ0?=
 =?utf-8?B?NFY4S094R2kxeXRwRWVpaHFpOEU0Y0dCT0M4OFd0anhJejE2RzdISjduTklm?=
 =?utf-8?B?Q0hOR1JBeC9PWk00UVFGMGZJUmRGZXVqQXdWRzNBOTlXRWtNT2lONGltaEs2?=
 =?utf-8?B?eGs5aUc1M3RlYU1VWnZhNWdpdkJHNGNLTHJscHpYTTdVS0ZHQWRRYmxUdVhD?=
 =?utf-8?Q?1v1/kN?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2025 04:43:21.4354 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9714fc5c-5374-4689-1811-08ddec36bdec
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8967
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

From: Lijo Lazar <lijo.lazar@amd.com>

Define a utility macro for defining capabilities and their attributes.
Capability attributes are read-only, write-only, read-write.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h       |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_utils.h | 91 +++++++++++++++++++++++
 2 files changed, 92 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_utils.h

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 17848ce65d1f..a06e69681ff6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -63,6 +63,7 @@
 #include "kgd_pp_interface.h"
 
 #include "amd_shared.h"
+#include "amdgpu_utils.h"
 #include "amdgpu_mode.h"
 #include "amdgpu_ih.h"
 #include "amdgpu_irq.h"
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_utils.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_utils.h
new file mode 100644
index 000000000000..1e40ca3b1584
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_utils.h
@@ -0,0 +1,91 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ * Copyright 2025 Advanced Micro Devices, Inc.
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
+#ifndef AMDGPU_UTILS_H_
+#define AMDGPU_UTILS_H_
+
+/* ---------- Generic 2‑bit capability attribute encoding ----------
+ * 00 INVALID, 01 RO, 10 WO, 11 RW
+ */
+enum amdgpu_cap_attr {
+	AMDGPU_CAP_ATTR_INVALID = 0,
+	AMDGPU_CAP_ATTR_RO      = 1 << 0,
+	AMDGPU_CAP_ATTR_WO      = 1 << 1,
+	AMDGPU_CAP_ATTR_RW      = (AMDGPU_CAP_ATTR_RO | AMDGPU_CAP_ATTR_WO),
+};
+
+#define AMDGPU_CAP_ATTR_BITS 2
+#define AMDGPU_CAP_ATTR_MAX  ((1U << AMDGPU_CAP_ATTR_BITS) - 1)
+
+/* Internal helper to build helpers for a given enum NAME */
+#define DECLARE_ATTR_CAP_CLASS_HELPERS(NAME)							\
+enum { NAME##_BITMAP_BITS = NAME##_COUNT * AMDGPU_CAP_ATTR_BITS };				\
+struct NAME##_caps {										\
+	DECLARE_BITMAP(bmap, NAME##_BITMAP_BITS);						\
+};												\
+static inline unsigned int NAME##_ATTR_START(enum NAME##_cap_id cap)				\
+{ return (unsigned int)cap * AMDGPU_CAP_ATTR_BITS; }						\
+static inline void NAME##_attr_init(struct NAME##_caps *c)					\
+{ if (c) bitmap_zero(c->bmap, NAME##_BITMAP_BITS); }						\
+static inline int NAME##_attr_set(struct NAME##_caps *c,					\
+				  enum NAME##_cap_id cap, enum amdgpu_cap_attr attr)		\
+{												\
+	if (!c)											\
+		return -EINVAL;									\
+	if (cap >= NAME##_COUNT)								\
+		return -EINVAL;									\
+	if ((unsigned int)attr > AMDGPU_CAP_ATTR_MAX)						\
+		return -EINVAL;									\
+	bitmap_write(c->bmap, (unsigned long)attr,						\
+			NAME##_ATTR_START(cap), AMDGPU_CAP_ATTR_BITS);				\
+	return 0;										\
+}												\
+static inline int NAME##_attr_get(const struct NAME##_caps *c,					\
+				  enum NAME##_cap_id cap, enum amdgpu_cap_attr *out)		\
+{												\
+	unsigned long v;									\
+	if (!c || !out)										\
+		return -EINVAL;									\
+	if (cap >= NAME##_COUNT)								\
+		return -EINVAL;									\
+	v = bitmap_read(c->bmap, NAME##_ATTR_START(cap), AMDGPU_CAP_ATTR_BITS);			\
+	*out = (enum amdgpu_cap_attr)v;								\
+	return 0;										\
+}												\
+static inline bool NAME##_cap_is_ro(const struct NAME##_caps *c, enum NAME##_cap_id id)		\
+{ enum amdgpu_cap_attr a; return !NAME##_attr_get(c, id, &a) && a == AMDGPU_CAP_ATTR_RO; }	\
+static inline bool NAME##_cap_is_wo(const struct NAME##_caps *c, enum NAME##_cap_id id)		\
+{ enum amdgpu_cap_attr a; return !NAME##_attr_get(c, id, &a) && a == AMDGPU_CAP_ATTR_WO; }	\
+static inline bool NAME##_cap_is_rw(const struct NAME##_caps *c, enum NAME##_cap_id id)		\
+{ enum amdgpu_cap_attr a; return !NAME##_attr_get(c, id, &a) && a == AMDGPU_CAP_ATTR_RW; }
+
+/* Element expander for enum creation */
+#define _CAP_ENUM_ELEM(x) x,
+
+/* Public macro: declare enum + helpers from an X‑macro list */
+#define DECLARE_ATTR_CAP_CLASS(NAME, LIST_MACRO)						\
+	enum NAME##_cap_id { LIST_MACRO(_CAP_ENUM_ELEM) NAME##_COUNT };				\
+	DECLARE_ATTR_CAP_CLASS_HELPERS(NAME)
+
+#endif /* AMDGPU_UTILS_H_ */
-- 
2.46.0

