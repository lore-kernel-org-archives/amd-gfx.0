Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E077E8304D
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Feb 2026 04:12:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2415310E4E8;
	Tue,  3 Feb 2026 04:12:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BQ5spd5e";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012021.outbound.protection.outlook.com [52.101.48.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3226A10E4E6
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Feb 2026 04:12:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J1jDqLTIzie2dqcx2E/q7UIRbLTbxGub3a1y7uskLZ2cr3Ao0F1iFsFyTc4Rzocn5PH8rSYc8FqulZv6/CjcgbaicwAqcTIPooKWo1PLxOZGLH3qXW+IBM9Vyp7j3RCUXcd0xwXFarmuOSE7HnP6XiGwTloyxMl2rCTnd20o5X/pbsE6n5kDENqpYKVRJpLcc4XiAMjG8ZEMH9s0yLdZQDaeRRdiD6VE0NNxyXw4+zVy/cnijIEqEMCE4ojOaO8AB6VjktL7GYHKrAe8gGRm3mH7CdtWqa7t6wNyXTytXedXrx7e+zOXoE9x3k3tvGqUOKJ6iXenFSiPK9QryMnTaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PhWIniLCbxTr3fU85xt9SzwtaaaYgjrwFhYzRRX4los=;
 b=Y2RWf9SQp57PX2bM0NiDwMQoNJoFMlJEKmyFqsESshAC8alz4V1+hS/GbdefvFagqG1xzH8QAmTu8P9iYvHrekBIXBkIoFsgZ+OnSDYefsKP6delPG26mrfMQEB01xV5DZOeG0I3fknKkBetEh+dElh+S7Or7JXfRuXJQ6jwRP1DIhFdaul1iJHpXi39ieVQ5xJYQuRmvJyT4na78xTVFlBKYgquQuxZJ9wyLoV12l+Npc+auYd3JkgdZhC03FF24x1pLQYop/P7r0TctqhMGWUzIZcqMLYXlHvqV9o11DI0MUfQfMXX6JlS9QyybdBSfnKX6tmmVbU0h+GA3iCXtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PhWIniLCbxTr3fU85xt9SzwtaaaYgjrwFhYzRRX4los=;
 b=BQ5spd5e/u9/BkK9IOFFiQPTywUiXspb6q3igSYTgoI+No7jlRx4B1zK1aMn2a1CL4Z7Dtpb91RWijWciy7yhagWTekTLIp369gatHc2ZoJ4y01zW0HWRair+nMJytEPNHyTgpNQ9a2TzGtXV7qsrWt5G93dGCoFLEumtBFKGpo=
Received: from BN0PR03CA0056.namprd03.prod.outlook.com (2603:10b6:408:e7::31)
 by CYXPR12MB9339.namprd12.prod.outlook.com (2603:10b6:930:d5::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 04:12:49 +0000
Received: from BN1PEPF00006000.namprd05.prod.outlook.com
 (2603:10b6:408:e7:cafe::e2) by BN0PR03CA0056.outlook.office365.com
 (2603:10b6:408:e7::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.16 via Frontend Transport; Tue,
 3 Feb 2026 04:12:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00006000.mail.protection.outlook.com (10.167.243.232) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Tue, 3 Feb 2026 04:12:48 +0000
Received: from gangliang-mlse-vm.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 2 Feb 2026 22:12:46 -0600
From: Gangliang Xie <ganglxie@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <tao.zhou1@amd.com>, <YiPeng.Chai@amd.com>, <KevinYang.Wang@amd.com>,
 Gangliang Xie <ganglxie@amd.com>
Subject: [PATCH V2 04/14] drm/amd/ras: add uniras smu feature flag init func
Date: Tue, 3 Feb 2026 12:11:56 +0800
Message-ID: <20260203041206.1299104-4-ganglxie@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260203041206.1299104-1-ganglxie@amd.com>
References: <20260203041206.1299104-1-ganglxie@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00006000:EE_|CYXPR12MB9339:EE_
X-MS-Office365-Filtering-Correlation-Id: ccade6cd-a0e9-4481-16a6-08de62da7d95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?u3FKiJbPRBAFceeIOSWM+cwcN1Kjyvjrok0ZJ1dhuRjhcnf+uiMrzxiIO1VS?=
 =?us-ascii?Q?mCXwE+xxP0egWcDn/bQUkRJOWHTIZehoMTf+MRMJdmBL4Hxxi+9dcBmND8WH?=
 =?us-ascii?Q?uwWriNnu+i2WfuUf8Vc5Q1UR0XsWNipp0pimKtGTh3ZlrYlUX7FtXDfPAVol?=
 =?us-ascii?Q?UfJ4NEw9OAhcnNERG5Ho520bTTLnbdMWdOgsRyKXmUgZr4MczLO2bIBR23z9?=
 =?us-ascii?Q?mh9gwgE1m7ie13+41ZLqMzJrQaDv4beb26bwCgJJpVY2LnQC65ISUt3+1yZm?=
 =?us-ascii?Q?kCbpm8/W9/APv5TBNobmy9yIU3yvZW0WhL87GUfa01IR1GzjHKgO47C+v2V/?=
 =?us-ascii?Q?/+cR62t7aSdIgv9dO9V0ZM+I2HwJAwNfFgWJ1vavGHmojiXt9u9qeX9ZahYN?=
 =?us-ascii?Q?C0sHetTIgq1bglxSXcOQlWL7JeS6sgM+fVTUPRK686rrDFHtgWGnbXkVJ0z4?=
 =?us-ascii?Q?5JdwS7X4m1BzfmoYMSN3mdjGJQiaOw2ME2KnjeRlU2of/oPxzbRBylzkL2jw?=
 =?us-ascii?Q?562pk4+TPOvFXu9wwl+4QGTyW4PynbjF6yYeP62qWqDlLbpIWRJwQKNMR4Sa?=
 =?us-ascii?Q?Q6N3uMRwz8ODyU/tAqqtAO1aGdjZtIJ27woyDQqYLEelABS8tI0gL1vPzJ0D?=
 =?us-ascii?Q?sfgcqap9o8deNnoQnSzFdRoQ1yPnmp6fNznRyxRZ3yi4wPenkjtt2WkGy9C9?=
 =?us-ascii?Q?cj0oGbyLJcX6ui2oaCrp7p40kEnzd0yCFkMc+BTDhUP2NNNDds/wu0IHkW+s?=
 =?us-ascii?Q?ZdRNQ9te+0TaSs6UqXlcjK7ihCzSa3gKd96w8Geipp0XKI54oVlU5yOa3Zx3?=
 =?us-ascii?Q?OBrT2JssXE/XaLwyq6JoyTZxKSEKhdOhFCo5PRWVq/MwDYatUhb3aMPaZo95?=
 =?us-ascii?Q?bC3yNd2gUpleNLftMo/lV7tWAe8p4ZEaucPu2ffKnOW0g6PjgUfu7z7oXXcu?=
 =?us-ascii?Q?kMRVms6FMNFobmiUep0HKnekaaTHPA5Bpy1Cszbo+jIjmemP9z58jXpMs9iO?=
 =?us-ascii?Q?Kw2MI+1YEnzUDdQntdwpTV0e52fDa54criWIXT9akEgdUmlq/12n0B/6IQNg?=
 =?us-ascii?Q?zzCj7Slv6AzVFH0Sr8OxOcgPapdVpGdP9AskHrjKOmQ8KANAbprs4hi5ykNh?=
 =?us-ascii?Q?9wBzqrnsOa/CvzZxSbJafFfdR+yeDTmhat2gOGGU31Y2Zrl8jA9IhMejBxT6?=
 =?us-ascii?Q?8E2U67w/uShUs+eQ3qyFP2pHAjDwhanjTA/U93ufHL4u6cgwGvUt3Ad5Zj3J?=
 =?us-ascii?Q?I4qpMOAV/oQ2OLz4WSTkXJIURQGvyNHWLXe9uGSFa48Djwy/qaL5eJZYTS/P?=
 =?us-ascii?Q?rpWpRrs8L+MILeL+7UIar+EcfZAhYzg9veCfgGK9TxbA+uY8LaNYoAk8xPfW?=
 =?us-ascii?Q?+t6YNt+oX10q5zobIT7/5vyMwKsHAUXdjlQ0HRQvCAEJ8luerApPQbmzEitE?=
 =?us-ascii?Q?z2XGvEYUmDV7tAri8LOVcsq5AxB5AY4lL00hmLGt8STGoaRaZGPjLkFoNK5g?=
 =?us-ascii?Q?B0c/WL1ELNyFlJYU0byCIKLwf06JOlM+bBxt1CScpafZBJc1TuznqFIjNPvz?=
 =?us-ascii?Q?iO9QajQicHxdOHgdLlfXtrs2CpXuZKe3IvUKIy8Rf97/mZViBFBcHHFjJk16?=
 =?us-ascii?Q?oNSUqUWq1Clf0YWaNeJJvPz31fBue5Fkgo6UqpaSy+NJ0Nk4GeBFfy0nVzV2?=
 =?us-ascii?Q?ssFyjw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: HmmR1uobK7LabQ1M2eVs1aaqKDR9S6Z/HqqnzGQYGWRJbKAl9p2k82yYEO7Ku4c7brR1TXdUfNj3AeMdThjcfzuVex6YEMwATp6L7lGeo7W0S9zbNk1SZNeehLhFwA6GW1OOQQ03eouebomuMJwgTlS8hSXi6O77RtRlbtoNFHAjS+LbHsCf7cPtKPCYU5DUmPZLR8CERW3bmKkjH9KiiHvqG/SYP70lO5ic07mM1qOP8Jktlf0K73EFJaYpkehHRd7160er+qZ+Kea8LjKuV/pi2WyqvQg+h4Q+n017YyjhoZN7y3TOQpELdOmCKptVvHaRQNTkTK7fHzFsvwHfxUNZuhbYyxOCT0kfGgPSPw1yw3xkCJTo1UNyKi9cvgYGei6s6+fbWoG/4TYfFR/E6cbDUl39XKStgKFXdE+LC0nQfLx9kYLzSJ8kdFa2aFV8
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 04:12:48.2077 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ccade6cd-a0e9-4481-16a6-08de62da7d95
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00006000.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9339
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

add flag to indicate if pmfw eeprom is supported or
not, and initialize it

v2: change copyright from 2025 to 2026

Signed-off-by: Gangliang Xie <ganglxie@amd.com>
---
 drivers/gpu/drm/amd/ras/rascore/Makefile      |  3 +-
 drivers/gpu/drm/amd/ras/rascore/ras.h         |  3 ++
 drivers/gpu/drm/amd/ras/rascore/ras_core.c    |  2 +
 .../gpu/drm/amd/ras/rascore/ras_eeprom_fw.c   | 38 +++++++++++++++++++
 .../gpu/drm/amd/ras/rascore/ras_eeprom_fw.h   | 29 ++++++++++++++
 5 files changed, 74 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.c
 create mode 100644 drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.h

diff --git a/drivers/gpu/drm/amd/ras/rascore/Makefile b/drivers/gpu/drm/amd/ras/rascore/Makefile
index e826a1f86424..06b265ec1cde 100644
--- a/drivers/gpu/drm/amd/ras/rascore/Makefile
+++ b/drivers/gpu/drm/amd/ras/rascore/Makefile
@@ -36,7 +36,8 @@ RAS_CORE_FILES = ras_core.o \
 			ras_log_ring.o \
 			ras_cper.o \
 			ras_psp.o \
-			ras_psp_v13_0.o
+			ras_psp_v13_0.o \
+			ras_eeprom_fw.o
 
 
 RAS_CORE = $(addprefix $(AMD_GPU_RAS_PATH)/rascore/,$(RAS_CORE_FILES))
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras.h b/drivers/gpu/drm/amd/ras/rascore/ras.h
index 2db838c444f1..6e223eff522c 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras.h
+++ b/drivers/gpu/drm/amd/ras/rascore/ras.h
@@ -36,6 +36,7 @@
 #include "ras_mp1.h"
 #include "ras_psp.h"
 #include "ras_log_ring.h"
+#include "ras_eeprom_fw.h"
 
 #define RAS_HW_ERR		"[Hardware Error]: "
 
@@ -335,6 +336,8 @@ struct ras_core_context {
 	spinlock_t seqno_lock;
 
 	bool ras_core_enabled;
+
+	u64 ras_fw_features;
 };
 
 struct ras_core_context *ras_core_create(struct ras_core_config *init_config);
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_core.c b/drivers/gpu/drm/amd/ras/rascore/ras_core.c
index 01122b55c98a..91c883f16ae5 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_core.c
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_core.c
@@ -382,6 +382,8 @@ int ras_core_hw_init(struct ras_core_context *ras_core)
 	if (ret)
 		goto init_err5;
 
+	ras_fw_init_feature_flags(ras_core);
+
 	ret = ras_eeprom_hw_init(ras_core);
 	if (ret)
 		goto init_err6;
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.c b/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.c
new file mode 100644
index 000000000000..e94c368c3159
--- /dev/null
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.c
@@ -0,0 +1,38 @@
+// SPDX-License-Identifier: MIT
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
+#include "ras.h"
+
+void ras_fw_init_feature_flags(struct ras_core_context *ras_core)
+{
+	struct ras_mp1 *mp1 = &ras_core->ras_mp1;
+	const struct ras_mp1_sys_func *sys_func = mp1->sys_func;
+	uint64_t flags = 0ULL;
+
+	if (!sys_func || !sys_func->mp1_get_ras_enabled_mask)
+		return;
+
+	if (!sys_func->mp1_get_ras_enabled_mask(ras_core, &flags))
+		ras_core->ras_fw_features = flags;
+}
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.h b/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.h
new file mode 100644
index 000000000000..b41665467368
--- /dev/null
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.h
@@ -0,0 +1,29 @@
+/* SPDX-License-Identifier: MIT */
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
+#ifndef __RAS_EEPROM_FW_H__
+#define __RAS_EEPROM_FW_H__
+
+void ras_fw_init_feature_flags(struct ras_core_context *ras_core);
+
+#endif
-- 
2.34.1

