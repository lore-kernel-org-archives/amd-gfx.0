Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F8DDC25B79
	for <amd-gfx@archiver.kernel.org>; Thu, 23 May 2024 09:19:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 249EF10E21D;
	Thu, 23 May 2024 09:19:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Ssy0+jyn";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2070.outbound.protection.outlook.com [40.107.220.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A13D10E21D
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 May 2024 09:19:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NuQvngCS3KW9Mke+JzAkcIBi6YfzR8igc+R99NbeBAzDJG5Pq2/irBJinhHeOSXMjadgeE5Rxn/C74cryB/zLCsZbyEVJLmB/adobj2aH3LdkvbJ9VVqWOeyNm0dnUo0ux/ILl4eLFx9IhG91fb0qVZcaBq/kpz2nrb56ZbbD8Rs4rOfFgy/yB/CzEjAVgTKyEp9d8pW8qeh/ftH+lAzYZzaEvDqK+4aGj3mtnhvB+UlHnEUBICuH95RroLnYPlSnMLMrxw29c8dMOeUnpsDI1PBzK5Hp1s3ZkwrszLPMqkRz0MttVz7vU1TVrvkR1/2YH8XRQ/D8UytRcVcT6c1Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DprVH2ePwmKuZfQpDiSuK3YHjtZuftC9y1Y02z11pRA=;
 b=L3I/ZSNzuRZwy5vZyoabv4/f7OfW3zmOvDKlW6mMagLiTJdp03VuLatBBigN71IGCHVc7RVa2dN5/FcAGUBqXeRVJf7eeVKFaMLCBFNP4mSbGnKHU36omKHAwYbDqQWyTvpGOGRocwLqU9IUKXNy2nY1YLcJ1Y/rUyFqTLH1gtBwrbgDJQcbKx53h85fs0rpzccpMCs3pb0eIlok1XdOXOM36mxQ18QJ9diwHoxkFRRRiutL69F57lWSDE9ExjJc2imMhfubWttTCJOU7ljU8OWcZtcW0b0O5eUAKH4FPVFyDWu4gCX099tsbMAXauYXL4fSI87/beqtTrd4T35izw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DprVH2ePwmKuZfQpDiSuK3YHjtZuftC9y1Y02z11pRA=;
 b=Ssy0+jyndNJ3dGB6GzV79+uXvhWjtAbhzEjXX4foiQ67RZB2mTn/iJpZX0QEv2rFSRjY9Eun7TaINrZ6wXzPnGtaBWB+de8aiBLzUDwwt9jWLw1QWAhK2nowx9iYHJ54g2GVPr6ufGBp8vne3UMLhPUFfdaT18ZxIQ4BQvJUp2Y=
Received: from BN9PR03CA0717.namprd03.prod.outlook.com (2603:10b6:408:ef::32)
 by PH7PR12MB8793.namprd12.prod.outlook.com (2603:10b6:510:27a::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22; Thu, 23 May
 2024 09:19:00 +0000
Received: from BN2PEPF00004FBE.namprd04.prod.outlook.com
 (2603:10b6:408:ef:cafe::b1) by BN9PR03CA0717.outlook.office365.com
 (2603:10b6:408:ef::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36 via Frontend
 Transport; Thu, 23 May 2024 09:19:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF00004FBE.mail.protection.outlook.com (10.167.243.184) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7611.14 via Frontend Transport; Thu, 23 May 2024 09:19:00 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 23 May 2024 04:18:58 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Lijo Lazar <lijo.lazar@amd.com>
Subject: [RFC PATCH] drm/amdgpu: Refactor sysfs attr functions in AMDGPU for
 reusability
Date: Thu, 23 May 2024 14:48:40 +0530
Message-ID: <20240523091840.714634-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBE:EE_|PH7PR12MB8793:EE_
X-MS-Office365-Filtering-Correlation-Id: 3bb6dc6c-8f3a-4632-1be8-08dc7b0961b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|376005|82310400017|36860700004; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cmRlMEl1YWZBRmVaR1hlWVY4RmtnSUtOeVBLb0VYNFljMDRmQ2dIaGVkaW1z?=
 =?utf-8?B?S3NyVk8rVExXV3JtVEVWa3NWOVNXN2RUTDY1dXJ0dW9sYmVGaDJUbTdmeUVT?=
 =?utf-8?B?dlRvYTVkNmJsS1NtVjhSN3Qvc3RGTUQ2cmxuWmE2azZCREltYlVYY014Nmlz?=
 =?utf-8?B?WTlYS0orZVJhNUV0R0Q5NFBvZXZUaFo2NmJicjM4amxCRGltVXVZVmhHSDJz?=
 =?utf-8?B?MGlLd0pXRHpOakx5OGgvWTUyMlMrWVpMdjg3SzlqZUVDUDJyQ3hWVmpFdEMy?=
 =?utf-8?B?SEVKQUlzRmVFcmowTVBPMlVUczlKOHBVMXJ2MkZQNVNJS2lQTnRGdDFVVURS?=
 =?utf-8?B?TzdETzUxZnZNd2RlRmJHZ2pPNGFGdXZEeVlGVzFHN1piZGRlRDhFbWIvTXRO?=
 =?utf-8?B?ZzVaQjdsTEtsMUdUVXQvY010V3ZrN0kwTzN2NURFUXNpcmNzN3AycGhCbDFQ?=
 =?utf-8?B?Q3Zqc01rRFFxVDlvdFpXSkxOcVp6QzMwaHVTNUNJWWFzdnEyaStjYlFlbTdU?=
 =?utf-8?B?S3ZIaXVWN29FNVZ5dDFlV3o1eG5HN0tGemhlTU45alB0MEQ5MnErTU8yN3V4?=
 =?utf-8?B?eU5kQW5peDA1V2RYdlpXRXpMSkFyQ04xMWdLdXBrVFF2dHFzZnc4OGZabUhw?=
 =?utf-8?B?M0srbEdqUlJPTWEzVVlGeE5jYlAzQllvaVQzZmN1SkNlVjRNOE5IYkp2ZFlp?=
 =?utf-8?B?UWZvdWZHNG16aTRXU0NJSjVCMHV0akQ5MmRmZmNkR1JNa1ptSkZabkltM3FG?=
 =?utf-8?B?YTZ0dHhBbzFOUXZCZjh0WFFGZzFDYUZoeVNqWG1oWEk3N05qRC9pWEJXc1gz?=
 =?utf-8?B?dFoxb0RiUWRxbnYrMUpKRlU3aWw3QkIzVzB0czdsNmJrVkRCblB6RmFrUzhK?=
 =?utf-8?B?NlpMUHpyWlVSazZkdXBDbnovZUx4R2l3V1Mrc2RlV0x3eWh4R0FrTVZnSHNB?=
 =?utf-8?B?b1FaTHA3OTFER3B3bnpuYWJMN1ZqQ0d5ZEY3RUFaeUJja3MyRVgxUGZrYjlR?=
 =?utf-8?B?V01SNG1wOXBYQ1pIZ1lLQ1V1NTJIdW9PZ1FPbjZyTStmdDhkSHkzUlhoQjli?=
 =?utf-8?B?b2IrQ1lwNk1nbko2bnBhTVBlMDg5WUJ0S1RWQ1dITEFOMmo2MW1oNjd6RHgx?=
 =?utf-8?B?STBQU0NPVUt4blYwc2JObTRtd0sxcFFlREF1Z0cwd1R3cHFzczBnM1NyazdF?=
 =?utf-8?B?NUZXUnczWDIzdnZQUTVnWFFNS3lQUG9nVmZpVjYxM2h1aGQ0V3BGRFZlWVd2?=
 =?utf-8?B?YXd4TzJuaExRbENXSFNtT3Z2UHRwK3d2N0tBYmhDR3BBbmdZdFVudTRtM29F?=
 =?utf-8?B?dGNGYm9uZ3IvWVVXN1VaSlRMYzJzRzc1Y0djOHlaYW5ZR3JKT0M2Zk03eEc3?=
 =?utf-8?B?UDNZQVE4cGp2azBubkdrZEV5bVo4dU9DQi90NU9vSEY3NEkwQWlrL3RFYlk4?=
 =?utf-8?B?a3FxWjViUkJKSFJaR1ppVWgyYmk3U1prMmNyWlNhcnM4blJkS2g0OENqbjFa?=
 =?utf-8?B?UHBUbHp6WFVGNHIxZXNmeURQMzRrVU1ReW5MUnpmZXQyOGhOUFowUVA3UzY2?=
 =?utf-8?B?ODBwNzdtMEpaUjFZaG1oekx0VXd0MkhOd3NWRmc3Z2E1UTY0VUpRMkd0bU1x?=
 =?utf-8?B?Q2pXQjVVUkZYZHcrQ0lFYldwZWRnU1BOREwyVWZNUzc0MWlTUHQ4R3B0QytY?=
 =?utf-8?B?VGhoeWMzN2s4ZURUOFNaSGUzMjFnL1NhUDI1UFZlNWowQ0p2WkxnRVh1UjZs?=
 =?utf-8?B?VFFWWk5xaGhPa0tWQ1VMSGxjYy9ZOHdsR094c0VpRm03Z0lnd0w2NjgyNk9M?=
 =?utf-8?B?MFpjR1FqMlppZi9yRnVPMUwzU0Ewa3BiNE9nZmtDNm9TTE5FUDJNLzRJbU82?=
 =?utf-8?Q?jEzXw1ozWRhLo?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(82310400017)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2024 09:19:00.3218 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bb6dc6c-8f3a-4632-1be8-08dc7b0961b1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FBE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8793
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

This commit refactors the sysfs attribute management functions
(`amdgpu_device_attr_create`, `amdgpu_device_attr_remove`,
`amdgpu_device_attr_create_groups`, `amdgpu_device_attr_remove_groups`)
into `amdgpu_sysfs.c`, which were originally in `amdgpu_pm.c`. This
change allows these functions to be reused by other modules like gfx,
pm, etc.

Additionally, the attribute update logic is now encapsulated in the
`pm_update_sysfs_attr` function, which is located in amdgpu_pm.c. This
function is specific to the pm module and is invoked by
amdgpu_device_attr_create for each attribute before the attribute is
created.

The `amdgpu_device_attr_create_groups` function has also been updated to
use `pm_update_syfs_attr`. This ensures that the attribute update logic
is consistently applied to all attributes.

This refactoring enhances the modularity and maintainability of the
code. It also increases the reusability of the attribute management
functions, allowing them to be used by multiple modules.

Cc: Lijo Lazar <lijo.lazar@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Suggested-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Makefile       |   3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_sysfs.c | 112 ++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_sysfs.h |  99 ++++++++++++++
 drivers/gpu/drm/amd/pm/amdgpu_pm.c        | 150 +++++++---------------
 drivers/gpu/drm/amd/pm/inc/amdgpu_pm.h    |  59 ---------
 5 files changed, 256 insertions(+), 167 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_sysfs.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_sysfs.h

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index 1f6b56ec99f6..8c782e26dfcb 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -81,7 +81,8 @@ amdgpu-y += amdgpu_device.o amdgpu_doorbell_mgr.o amdgpu_kms.o \
 	amdgpu_umc.o smu_v11_0_i2c.o amdgpu_fru_eeprom.o amdgpu_rap.o \
 	amdgpu_fw_attestation.o amdgpu_securedisplay.o \
 	amdgpu_eeprom.o amdgpu_mca.o amdgpu_psp_ta.o amdgpu_lsdma.o \
-	amdgpu_ring_mux.o amdgpu_xcp.o amdgpu_seq64.o amdgpu_aca.o amdgpu_dev_coredump.o
+	amdgpu_ring_mux.o amdgpu_xcp.o amdgpu_seq64.o amdgpu_aca.o amdgpu_dev_coredump.o \
+	amdgpu_sysfs.o
 
 amdgpu-$(CONFIG_PROC_FS) += amdgpu_fdinfo.o
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sysfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sysfs.c
new file mode 100644
index 000000000000..bbdf3e8966d5
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sysfs.c
@@ -0,0 +1,112 @@
+// SPDX-License-Identifier: MIT
+/*
+ * Copyright 2017 Advanced Micro Devices, Inc.
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
+
+#include "amdgpu.h"
+#include "amdgpu_dpm.h"
+#include "amdgpu_drv.h"
+#include "amdgpu_reset.h"
+#include "amdgpu_sysfs.h"
+#include "atom.h"
+#include <linux/pci.h>
+#include <linux/hwmon.h>
+#include <linux/hwmon-sysfs.h>
+#include <linux/nospec.h>
+#include <linux/pm_runtime.h>
+#include <asm/processor.h>
+
+int amdgpu_sysfs_attr_create(struct amdgpu_device *adev,
+			     struct amdgpu_device_attr *attr,
+			     u32 mask, struct list_head *attr_list)
+{
+	int ret;
+	struct amdgpu_device_attr_entry *attr_entry;
+	struct device_attribute *dev_attr;
+	const char *name;
+
+	if (!attr)
+		return -EINVAL;
+
+	dev_attr = &attr->dev_attr;
+	name = dev_attr->attr.name;
+
+	ret = device_create_file(adev->dev, dev_attr);
+	if (ret) {
+		dev_err(adev->dev, "failed to create device file %s, ret = %d\n",
+			name, ret);
+	}
+
+	attr_entry = kmalloc(sizeof(*attr_entry), GFP_KERNEL);
+	if (!attr_entry)
+		return -ENOMEM;
+
+	attr_entry->attr = attr;
+	INIT_LIST_HEAD(&attr_entry->entry);
+
+	list_add_tail(&attr_entry->entry, attr_list);
+
+	return ret;
+}
+
+int amdgpu_sysfs_attr_create_groups(struct amdgpu_device *adev,
+				    struct amdgpu_device_attr *attrs,
+				    u32 counts, u32 mask,
+				    struct list_head *attr_list)
+{
+	int ret = 0;
+	u32 i = 0;
+
+	for (i = 0; i < counts; i++) {
+		ret = amdgpu_sysfs_attr_create(adev, &attrs[i], mask, attr_list);
+		if (ret)
+			goto failed;
+	}
+
+	return 0;
+
+failed:
+	amdgpu_sysfs_attr_remove_groups(adev, attr_list);
+
+	return ret;
+}
+
+void amdgpu_sysfs_attr_remove(struct amdgpu_device *adev, struct amdgpu_device_attr *attr)
+{
+	struct device_attribute *dev_attr = &attr->dev_attr;
+
+	device_remove_file(adev->dev, dev_attr);
+}
+
+void amdgpu_sysfs_attr_remove_groups(struct amdgpu_device *adev,
+				     struct list_head *attr_list)
+{
+	struct amdgpu_device_attr_entry *entry, *entry_tmp;
+
+	if (list_empty(attr_list))
+		return;
+
+	list_for_each_entry_safe(entry, entry_tmp, attr_list, entry) {
+		amdgpu_sysfs_attr_remove(adev, entry->attr);
+		list_del(&entry->entry);
+		kfree(entry);
+	}
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sysfs.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_sysfs.h
new file mode 100644
index 000000000000..ab2fa7070941
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sysfs.h
@@ -0,0 +1,99 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ * Copyright 2014 Advanced Micro Devices, Inc.
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
+#ifndef __AMDGPU_SYSFS_H__
+#define __AMDGPU_SYSFS_H__
+
+#define to_amdgpu_device_attr(_dev_attr) \
+	container_of(_dev_attr, struct amdgpu_device_attr, dev_attr)
+
+#define __AMDGPU_DEVICE_ATTR(_name, _mode, _show, _store, _flags, ...)	\
+	{ .dev_attr = __ATTR(_name, _mode, _show, _store),		\
+	  .flags = _flags,						\
+	  ##__VA_ARGS__, }
+
+#define AMDGPU_DEVICE_ATTR(_name, _mode, _flags, ...)			\
+	__AMDGPU_DEVICE_ATTR(_name, _mode,				\
+			     amdgpu_get_##_name, amdgpu_set_##_name,	\
+			     _flags, ##__VA_ARGS__)
+
+#define AMDGPU_DEVICE_ATTR_RW(_name, _flags, ...)			\
+	AMDGPU_DEVICE_ATTR(_name, 0644,			\
+			   _flags, ##__VA_ARGS__)
+
+#define AMDGPU_DEVICE_ATTR_RO(_name, _flags, ...)			\
+	__AMDGPU_DEVICE_ATTR(_name, 0444,				\
+			     amdgpu_get_##_name, NULL,			\
+			     _flags, ##__VA_ARGS__)
+
+#define AMDGPU_DEVICE_ATTR_WO(_name, _flags, ...)			\
+	__AMDGPU_DEVICE_ATTR(_name, 0200,				\
+			     NULL, amdgpu_set_##_name,			\
+			     _flags, ##__VA_ARGS__)
+
+struct cg_flag_name {
+	u64 flag;
+	const char *name;
+};
+
+enum amdgpu_device_attr_flags {
+	ATTR_FLAG_BASIC = (1 << 0),
+	ATTR_FLAG_ONEVF = (1 << 16),
+};
+
+#define ATTR_FLAG_TYPE_MASK	(0x0000ffff)
+#define ATTR_FLAG_MODE_MASK	(0xffff0000)
+#define ATTR_FLAG_MASK_ALL	(0xffffffff)
+
+enum amdgpu_device_attr_states {
+	ATTR_STATE_UNSUPPORTED = 0,
+	ATTR_STATE_SUPPORTED,
+};
+
+struct amdgpu_device_attr {
+	struct device_attribute dev_attr;
+	enum amdgpu_device_attr_flags flags;
+	int (*attr_update)(struct amdgpu_device *adev, struct amdgpu_device_attr *attr,
+			   u32 mask, enum amdgpu_device_attr_states *states);
+
+};
+
+struct amdgpu_device_attr_entry {
+	struct list_head entry;
+	struct amdgpu_device_attr *attr;
+};
+
+int amdgpu_sysfs_attr_create(struct amdgpu_device *adev,
+			     struct amdgpu_device_attr *attr,
+			     u32 mask, struct list_head *attr_list);
+int amdgpu_sysfs_attr_create_groups(struct amdgpu_device *adev,
+				    struct amdgpu_device_attr *attrs,
+				    u32 counts,
+				    u32 mask,
+				    struct list_head *attr_list);
+void amdgpu_sysfs_attr_remove_groups(struct amdgpu_device *adev,
+				     struct list_head *attr_list);
+void amdgpu_sysfs_attr_remove(struct amdgpu_device *adev,
+			      struct amdgpu_device_attr *attr);
+#endif
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 57e449bc2379..c16748f5baff 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -28,6 +28,7 @@
 #include "amdgpu_pm.h"
 #include "amdgpu_reset.h"
 #include "amdgpu_dpm.h"
+#include "amdgpu_sysfs.h"
 #include "atom.h"
 #include <linux/pci.h>
 #include <linux/hwmon.h>
@@ -2368,7 +2369,7 @@ static ssize_t amdgpu_set_xgmi_plpd_policy(struct device *dev,
 	return count;
 }
 
-static struct amdgpu_device_attr amdgpu_device_attrs[] = {
+static struct amdgpu_device_attr amdgpu_pm_device_attrs[] = {
 	AMDGPU_DEVICE_ATTR_RW(power_dpm_state,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
 	AMDGPU_DEVICE_ATTR_RW(power_dpm_force_performance_level,	ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
 	AMDGPU_DEVICE_ATTR_RO(pp_num_states,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
@@ -2594,104 +2595,6 @@ static int default_attr_update(struct amdgpu_device *adev, struct amdgpu_device_
 	return 0;
 }
 
-
-static int amdgpu_device_attr_create(struct amdgpu_device *adev,
-				     struct amdgpu_device_attr *attr,
-				     uint32_t mask, struct list_head *attr_list)
-{
-	int ret = 0;
-	enum amdgpu_device_attr_states attr_states = ATTR_STATE_SUPPORTED;
-	struct amdgpu_device_attr_entry *attr_entry;
-	struct device_attribute *dev_attr;
-	const char *name;
-
-	int (*attr_update)(struct amdgpu_device *adev, struct amdgpu_device_attr *attr,
-			   uint32_t mask, enum amdgpu_device_attr_states *states) = default_attr_update;
-
-	if (!attr)
-		return -EINVAL;
-
-	dev_attr = &attr->dev_attr;
-	name = dev_attr->attr.name;
-
-	attr_update = attr->attr_update ? attr->attr_update : default_attr_update;
-
-	ret = attr_update(adev, attr, mask, &attr_states);
-	if (ret) {
-		dev_err(adev->dev, "failed to update device file %s, ret = %d\n",
-			name, ret);
-		return ret;
-	}
-
-	if (attr_states == ATTR_STATE_UNSUPPORTED)
-		return 0;
-
-	ret = device_create_file(adev->dev, dev_attr);
-	if (ret) {
-		dev_err(adev->dev, "failed to create device file %s, ret = %d\n",
-			name, ret);
-	}
-
-	attr_entry = kmalloc(sizeof(*attr_entry), GFP_KERNEL);
-	if (!attr_entry)
-		return -ENOMEM;
-
-	attr_entry->attr = attr;
-	INIT_LIST_HEAD(&attr_entry->entry);
-
-	list_add_tail(&attr_entry->entry, attr_list);
-
-	return ret;
-}
-
-static void amdgpu_device_attr_remove(struct amdgpu_device *adev, struct amdgpu_device_attr *attr)
-{
-	struct device_attribute *dev_attr = &attr->dev_attr;
-
-	device_remove_file(adev->dev, dev_attr);
-}
-
-static void amdgpu_device_attr_remove_groups(struct amdgpu_device *adev,
-					     struct list_head *attr_list);
-
-static int amdgpu_device_attr_create_groups(struct amdgpu_device *adev,
-					    struct amdgpu_device_attr *attrs,
-					    uint32_t counts,
-					    uint32_t mask,
-					    struct list_head *attr_list)
-{
-	int ret = 0;
-	uint32_t i = 0;
-
-	for (i = 0; i < counts; i++) {
-		ret = amdgpu_device_attr_create(adev, &attrs[i], mask, attr_list);
-		if (ret)
-			goto failed;
-	}
-
-	return 0;
-
-failed:
-	amdgpu_device_attr_remove_groups(adev, attr_list);
-
-	return ret;
-}
-
-static void amdgpu_device_attr_remove_groups(struct amdgpu_device *adev,
-					     struct list_head *attr_list)
-{
-	struct amdgpu_device_attr_entry *entry, *entry_tmp;
-
-	if (list_empty(attr_list))
-		return ;
-
-	list_for_each_entry_safe(entry, entry_tmp, attr_list, entry) {
-		amdgpu_device_attr_remove(adev, entry->attr);
-		list_del(&entry->entry);
-		kfree(entry);
-	}
-}
-
 static ssize_t amdgpu_hwmon_show_temp(struct device *dev,
 				      struct device_attribute *attr,
 				      char *buf)
@@ -4520,11 +4423,36 @@ static int amdgpu_od_set_init(struct amdgpu_device *adev)
 	return ret;
 }
 
+static int pm_update_sysfs_attr(struct amdgpu_device *adev, struct amdgpu_device_attr *attr,
+				u32 mask, enum amdgpu_device_attr_states *states)
+{
+	int ret;
+	struct device_attribute *dev_attr = &attr->dev_attr;
+	const char *name = dev_attr->attr.name;
+
+	int (*attr_update)(struct amdgpu_device *adev, struct amdgpu_device_attr *attr,
+			   u32 mask, enum amdgpu_device_attr_states *states) = default_attr_update;
+
+	attr_update = attr->attr_update ? attr->attr_update : default_attr_update;
+
+	ret = attr_update(adev, attr, mask, states);
+	if (ret) {
+		dev_err(adev->dev, "failed to update device file %s, ret = %d\n",
+			name, ret);
+		return ret;
+	}
+
+	if (*states == ATTR_STATE_UNSUPPORTED)
+		return 0;
+
+	return ret;
+}
+
 int amdgpu_pm_sysfs_init(struct amdgpu_device *adev)
 {
 	enum amdgpu_sriov_vf_mode mode;
 	uint32_t mask = 0;
-	int ret;
+	int ret, i;
 
 	if (adev->pm.sysfs_initialized)
 		return 0;
@@ -4561,11 +4489,19 @@ int amdgpu_pm_sysfs_init(struct amdgpu_device *adev)
 		break;
 	}
 
-	ret = amdgpu_device_attr_create_groups(adev,
-					       amdgpu_device_attrs,
-					       ARRAY_SIZE(amdgpu_device_attrs),
-					       mask,
-					       &adev->pm.pm_attr_list);
+	for (i = 0; i < ARRAY_SIZE(amdgpu_pm_device_attrs); i++) {
+		enum amdgpu_device_attr_states attr_states = ATTR_STATE_SUPPORTED;
+
+		ret = pm_update_sysfs_attr(adev, &amdgpu_pm_device_attrs[i], mask, &attr_states);
+		if (ret)
+			return ret;
+	}
+
+	ret = amdgpu_sysfs_attr_create_groups(adev,
+					      amdgpu_pm_device_attrs,
+					      ARRAY_SIZE(amdgpu_pm_device_attrs),
+					      mask,
+					      &adev->pm.pm_attr_list);
 	if (ret)
 		goto err_out0;
 
@@ -4580,7 +4516,7 @@ int amdgpu_pm_sysfs_init(struct amdgpu_device *adev)
 	return 0;
 
 err_out1:
-	amdgpu_device_attr_remove_groups(adev, &adev->pm.pm_attr_list);
+	amdgpu_sysfs_attr_remove_groups(adev, &adev->pm.pm_attr_list);
 err_out0:
 	if (adev->pm.int_hwmon_dev)
 		hwmon_device_unregister(adev->pm.int_hwmon_dev);
@@ -4595,7 +4531,7 @@ void amdgpu_pm_sysfs_fini(struct amdgpu_device *adev)
 	if (adev->pm.int_hwmon_dev)
 		hwmon_device_unregister(adev->pm.int_hwmon_dev);
 
-	amdgpu_device_attr_remove_groups(adev, &adev->pm.pm_attr_list);
+	amdgpu_sysfs_attr_remove_groups(adev, &adev->pm.pm_attr_list);
 }
 
 /*
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_pm.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_pm.h
index 3810fedba609..093c39a5d715 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_pm.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_pm.h
@@ -24,65 +24,6 @@
 #ifndef __AMDGPU_PM_H__
 #define __AMDGPU_PM_H__
 
-struct cg_flag_name {
-	u64 flag;
-	const char *name;
-};
-
-enum amdgpu_device_attr_flags {
-	ATTR_FLAG_BASIC = (1 << 0),
-	ATTR_FLAG_ONEVF = (1 << 16),
-};
-
-#define ATTR_FLAG_TYPE_MASK	(0x0000ffff)
-#define ATTR_FLAG_MODE_MASK	(0xffff0000)
-#define ATTR_FLAG_MASK_ALL	(0xffffffff)
-
-enum amdgpu_device_attr_states {
-	ATTR_STATE_UNSUPPORTED = 0,
-	ATTR_STATE_SUPPORTED,
-};
-
-struct amdgpu_device_attr {
-	struct device_attribute dev_attr;
-	enum amdgpu_device_attr_flags flags;
-	int (*attr_update)(struct amdgpu_device *adev, struct amdgpu_device_attr *attr,
-			   uint32_t mask, enum amdgpu_device_attr_states *states);
-
-};
-
-struct amdgpu_device_attr_entry {
-	struct list_head entry;
-	struct amdgpu_device_attr *attr;
-};
-
-#define to_amdgpu_device_attr(_dev_attr) \
-	container_of(_dev_attr, struct amdgpu_device_attr, dev_attr)
-
-#define __AMDGPU_DEVICE_ATTR(_name, _mode, _show, _store, _flags, ...)	\
-	{ .dev_attr = __ATTR(_name, _mode, _show, _store),		\
-	  .flags = _flags,						\
-	  ##__VA_ARGS__, }
-
-#define AMDGPU_DEVICE_ATTR(_name, _mode, _flags, ...)			\
-	__AMDGPU_DEVICE_ATTR(_name, _mode,				\
-			     amdgpu_get_##_name, amdgpu_set_##_name,	\
-			     _flags, ##__VA_ARGS__)
-
-#define AMDGPU_DEVICE_ATTR_RW(_name, _flags, ...)			\
-	AMDGPU_DEVICE_ATTR(_name, S_IRUGO | S_IWUSR,			\
-			   _flags, ##__VA_ARGS__)
-
-#define AMDGPU_DEVICE_ATTR_RO(_name, _flags, ...)			\
-	__AMDGPU_DEVICE_ATTR(_name, S_IRUGO,				\
-			     amdgpu_get_##_name, NULL,			\
-			     _flags, ##__VA_ARGS__)
-
-#define AMDGPU_DEVICE_ATTR_WO(_name, _flags, ...)			\
-	__AMDGPU_DEVICE_ATTR(_name, 0200,				\
-			     NULL, amdgpu_set_##_name,			\
-			     _flags, ##__VA_ARGS__)
-
 int amdgpu_pm_sysfs_init(struct amdgpu_device *adev);
 int amdgpu_pm_virt_sysfs_init(struct amdgpu_device *adev);
 void amdgpu_pm_sysfs_fini(struct amdgpu_device *adev);
-- 
2.34.1

