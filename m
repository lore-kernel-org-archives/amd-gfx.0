Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D16CCD6E7D
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Jun 2026 13:44:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3AB6210E636;
	Fri,  5 Jun 2026 13:44:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1ZeXVRMH";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010008.outbound.protection.outlook.com [52.101.61.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 648BF10E675
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Jun 2026 13:44:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=afHhNl4tQ4MLt+b8S8/hY5QVs1JcWH7Mz8NNMVeR5ll1GQRSboHhElOzC5k6cdeSQqAUp9GpzmLIJ/ymU49Xqeqjn8t5fJfM9NM/CO4QzGS5h294G2O2SDf6sZGJbU+T1YNaUeYi7r6a3X4eTGb+9J3twQU/abPudbIqVLTuLaglH/boM9jSlfNFzOvwFD16EFrKdA7y/eS4j8oE31ZztA8loOTbQXPzzpV7M3XkBzCLfCWzqLqheukmwPqLs38i35DC78aVHV5f7ulCcAEWqBaBvUrq8LG82RC2iNeYMxon2vZTFF1ghaJiFqXhg6uipylqiQwQfnvYnwVs7PT7lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TYdKW4495CwjK76ElFLck9YMax6g//KZsGsK0l+qLes=;
 b=brjBrcLuVm5U5wKKzkIYgiR4nlsmlkD8VfX11fYcNIIoQVXd6JJ7PXyU7MKieKjSSqDtsCteK4LkK7ZXZQzo4hOnDrBJ+/wqqxlGCMliipEPCv6uVDZPcWJm+0yaupvM8vGcd3p1ec3oeKhWe+qGNFA31GOH/msfhIWtuiuqGD9LUjInZI5oIOcPbd/N2NsWOp47xAgTHwTk4QrNgSjd9zoaNgXKxA4GbxCZNPWHKaeIDXaMCYxS6bdYBldTlWW0cc1KoYmVIMc+5qBiDWHLQRz1R3RSKGjqgjvYod4NFbrd/L6RQanWEqLO2yLociV5x6kYRabU8JM/ZR0UbDELfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TYdKW4495CwjK76ElFLck9YMax6g//KZsGsK0l+qLes=;
 b=1ZeXVRMHuSp9c4XvhyOSMrcOId21OLrTFoW/HZ4jhvUor/y5l47uahrDrEEVk/Suro0nhsxKsawSzWy/TM9e40S4joRTftcmaZ982+2AzqAIJ78bluZKjll+urJwGUFe6aTjuxkKivdJgXRkAnpIa53Cnr89CsD3N/JQ017E7fI=
Received: from CH0P221CA0040.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11d::20)
 by DS0PR12MB7702.namprd12.prod.outlook.com (2603:10b6:8:130::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Fri, 5 Jun 2026
 13:44:19 +0000
Received: from DS3PEPF0000C37A.namprd04.prod.outlook.com
 (2603:10b6:610:11d:cafe::83) by CH0P221CA0040.outlook.office365.com
 (2603:10b6:610:11d::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.9 via Frontend Transport; Fri, 5
 Jun 2026 13:44:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF0000C37A.mail.protection.outlook.com (10.167.23.4) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Fri, 5 Jun 2026 13:44:18 +0000
Received: from amd-desktop.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 5 Jun
 2026 08:44:14 -0500
From: Shahyan Soltani <shahyan.soltani@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Shahyan Soltani <shahyan.soltani@amd.com>
Subject: [PATCH 03/11] drm/amdgpu: move struct amdgpu_uid and helpers into
 header file
Date: Fri, 5 Jun 2026 09:43:15 -0400
Message-ID: <20260605134400.956791-4-shahyan.soltani@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260605134400.956791-1-shahyan.soltani@amd.com>
References: <20260605134400.956791-1-shahyan.soltani@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37A:EE_|DS0PR12MB7702:EE_
X-MS-Office365-Filtering-Correlation-Id: 9acd39df-1be1-4b4a-4ee6-08dec3088ade
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|1800799024|56012099006|11063799006|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: Cqr9lExPMliyJGWD7Mrl5IbzE6mhbJSOWtzLY/NcK/KHrrbG1mzxorxnfLJHCMOJk3KQlCwwF7Ia1eYFc6dKWHwsMP4s/pIw2anm7zC2GFfkvmDR4k9BuSUV0DqG/RLu14JdWyh4qUN1tPZC6Jvo16PIHNLI9fooMP+BdaJmuNyjdWrVob04orpTDv4pEHtPkUVGNzq8Wd+A8Vj7R7yevUglPcJQmJO0cKIwfqvcJEqeyxW5UUbq+jfeN8SIccAmsmk+dItjrooFYfORp6J7whtpogffkfIFaZo/db4Y0MJR6kDVLO/a2DktQWXdRNVCEXlew8X9mLhdph4vBdez59JaV5kzaiwpwussPuiA7Qnhm70QmbHq70i/Df5Tj3nbtdmWPKz9cGK5d4NdEGHzJ/HfAleh0nUzuEpdZxwbDOuqx8NewGb77bPZ99oML6ohHhwGTH23nu1BAoz69DlUBseL/dTG/h9EYqtCYMy/B5KH9FYEI8xACL34f9kMY92761zCEQiVlomrHvuCxMgMW+Oe6wpCxB4y8Ncv36rrg9OMl/kbTGum5Fyt3b3XOcOJoq7jpncecEsQHrmyacXo4/SniOglCCejYsSGI0ZR0khl2BdY8H4+k6qKt1R4iouunF6g5lp1ebiuGwvpI3M5d5UXAyfX87z/EYvXK+tLDrQKGvafmvK83pb4l4rqgRJKf0MhINwaggd+XZPBT2/7tBe9jH0IJOT7s+fqhJz/LGs=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(56012099006)(11063799006)(22082099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: zi47gzS0r3tbuDXwfCQbNtU5B/0PtGqo9nanamXtfdxD/Px5lHyY7c5iOREt8k3ZzhZX/y/9uExxrTv6qFSDSGZTgWazq8e+xnB5OYIl2HsD7VI17LV+ng8zBbKS+IyiBJyGWgg+SWFAApV6PgVXB0NBKO5u7HDqbIUJe4TcixqCVkF1PDzbtqNVyh29if78Q5LNwll7/9UZR3TTb8SYxRiLCFzvy/2faGAykgNICdgce1iKsttXK/lGtbrO/4btqgTpMvv5LklEYEYWbKBNVG7v0mjX9SBcIzzrkabmVi9AoERSPLhHqkgvD2k/Yk4o2BFYo9aVedyG64ZGL7NIR3DFsWy0z0qWLCQS4HPt2/uV8u/r/9fSG9WYj7PqS71i6WzEtvKbUgXXp7wLCFdRBJp091LKrIhv2eiCxvPaViCTk47LxvD9vwq5x8Tu5CGp
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 13:44:18.9650 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9acd39df-1be1-4b4a-4ee6-08dec3088ade
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C37A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7702
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

Move struct amdgpu_uid and helpers from the monolithic amdgpu.h file into a new amdgpu_uid.h file.

This is part of the ongoing effort to reduce the size of amdgpu.h into their own respective
separate headers.

Signed-off-by: Shahyan Soltani <shahyan.soltani@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h     | 22 +----------
 drivers/gpu/drm/amd/amdgpu/amdgpu_uid.h | 50 +++++++++++++++++++++++++
 2 files changed, 51 insertions(+), 21 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_uid.h

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 9a714b4b59bc..0f8743254fe6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -114,6 +114,7 @@
 #include "amdgpu_sa.h"
 #include "amdgpu_wb.h"
 #include "amdgpu_ip.h"
+#include "amdgpu_uid.h"
 #if defined(CONFIG_DRM_AMD_ISP)
 #include "amdgpu_isp.h"
 #endif
@@ -553,21 +554,6 @@ struct amdgpu_mmio_remap {
 	struct amdgpu_bo *bo;
 };
 
-enum amdgpu_uid_type {
-	AMDGPU_UID_TYPE_XCD,
-	AMDGPU_UID_TYPE_AID,
-	AMDGPU_UID_TYPE_SOC,
-	AMDGPU_UID_TYPE_MID,
-	AMDGPU_UID_TYPE_MAX
-};
-
-#define AMDGPU_UID_INST_MAX 8 /* max number of instances for each UID type */
-
-struct amdgpu_uid {
-	uint64_t uid[AMDGPU_UID_TYPE_MAX][AMDGPU_UID_INST_MAX];
-	struct amdgpu_device *adev;
-};
-
 #define MAX_UMA_OPTION_NAME	28
 #define MAX_UMA_OPTION_ENTRIES	19
 
@@ -1530,10 +1516,4 @@ static inline int amdgpu_device_bus_status_check(struct amdgpu_device *adev)
 
        return 0;
 }
-
-void amdgpu_device_set_uid(struct amdgpu_uid *uid_info,
-			   enum amdgpu_uid_type type, uint8_t inst,
-			   uint64_t uid);
-uint64_t amdgpu_device_get_uid(struct amdgpu_uid *uid_info,
-			       enum amdgpu_uid_type type, uint8_t inst);
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_uid.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_uid.h
new file mode 100644
index 000000000000..d92ddcce9f58
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_uid.h
@@ -0,0 +1,50 @@
+/* SPDX-License-Identifier: GPL-2.0 OR MIT
+ *
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
+ */
+#ifndef __AMDGPU_UID_H__
+#define __AMDGPU_UID_H__
+
+#include <linux/types.h>
+
+#define AMDGPU_UID_INST_MAX 8 /* max number of instances for each UID type */
+
+struct amdgpu_device;
+
+enum amdgpu_uid_type {
+	AMDGPU_UID_TYPE_XCD,
+	AMDGPU_UID_TYPE_AID,
+	AMDGPU_UID_TYPE_SOC,
+	AMDGPU_UID_TYPE_MID,
+	AMDGPU_UID_TYPE_MAX
+};
+
+struct amdgpu_uid {
+	uint64_t uid[AMDGPU_UID_TYPE_MAX][AMDGPU_UID_INST_MAX];
+	struct amdgpu_device *adev;
+};
+
+void amdgpu_device_set_uid(struct amdgpu_uid *uid_info,
+			   enum amdgpu_uid_type type, uint8_t inst,
+			   uint64_t uid);
+uint64_t amdgpu_device_get_uid(struct amdgpu_uid *uid_info,
+			       enum amdgpu_uid_type type, uint8_t inst);
+#endif
-- 
2.54.0

