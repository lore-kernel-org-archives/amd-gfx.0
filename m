Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 579CEC88E43
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Jan 2026 03:56:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F1C8510E38F;
	Mon, 26 Jan 2026 03:55:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3dOST6J4";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010005.outbound.protection.outlook.com [52.101.46.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4ED5010E390
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Jan 2026 03:55:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qMwQtPZE0NwOwrmoQPJQlCB3QEft6jzUp+STFO+22bsAe1ZstkrwMHFgKr/CY5/GMWscwanowM216hD2t1x8Oo+epyCDMmSTDGKNLLMDGM/NwhYKV3HjzF9dkFlCFejEFYjyMV/nCLAacK6QoXynCuBA7K1juTJbD69Pf52Dkt61hdVhoqnhAXOAWRb2AOIM4Jtdnk/HKKw94U56U1YNHCi9qcmLP4ASVsBWM7r1A3v1jYz34EESD32YKR7NooI27JNGiTgueat22ldLbHsy1NZC81K8Z3wtDpHP2n8lp5XgzaKM/buNqHRfZkXW1crIp3WEuzucClboNfiXebp1rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O48bkv2KUNvztAbyFSnNl1QF23WsgoWMYSZ1T6ANCN0=;
 b=AeY2kT0Esh+rKpMcG6kE+BvYFzTLkERLHSDjf0ie6NiEiH3biKBtWXx7D3pvHJBder+v6KDrUnoQioBWol/GoC8zmHf/9CD32GmfNkx+CJuk3ErzUUuCGBh9RIXIC9yohlpH6mKJIhp75VvQd3ftLq//ionOwoOtYBKiKGuUPd0MucB2BND9cM0PIYYk4dNdUDRQJZn+MNuUA6bN4KxLjzT3AuZZYmHgA0fC1Ja2Ze9bL6u8fzd9koXgkNtnACE7mJwDdChSsA06cmCPfNLr+qzjCJPBuLGgzgjuA/pgCoFBVtymhOKUNbGb/96M8zQ1iDDTOVOOcuWdbJzAl4Rb9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O48bkv2KUNvztAbyFSnNl1QF23WsgoWMYSZ1T6ANCN0=;
 b=3dOST6J4lFuueuGRmvrmPvV/x0eCCufYczK7dWhxjt4iqsWO/KcOHPQ4to+py44qijmupZyb9Ng+Pf36nsv73gy+hsvWSnWJebETTVDxa2rI0PYwAQfr4d4776Mo6dMtF17+/bYrDdLo04LAh2n8lBq1+DZBtc6ZRsEoMh79QXw=
Received: from DS7PR03CA0186.namprd03.prod.outlook.com (2603:10b6:5:3b6::11)
 by CH2PR12MB4309.namprd12.prod.outlook.com (2603:10b6:610:a4::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Mon, 26 Jan
 2026 03:55:52 +0000
Received: from DS3PEPF000099D7.namprd04.prod.outlook.com
 (2603:10b6:5:3b6:cafe::fc) by DS7PR03CA0186.outlook.office365.com
 (2603:10b6:5:3b6::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.4 via Frontend Transport; Mon,
 26 Jan 2026 03:55:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF000099D7.mail.protection.outlook.com (10.167.17.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Mon, 26 Jan 2026 03:55:52 +0000
Received: from gangliang-mlse-vm.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Sun, 25 Jan 2026 21:55:51 -0600
From: Gangliang Xie <ganglxie@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <tao.zhou1@amd.com>, <YiPeng.Chai@amd.com>, Gangliang Xie
 <ganglxie@amd.com>
Subject: [PATCH 04/14] drm/amd/ras: add uniras smu feature flag init func
Date: Mon, 26 Jan 2026 11:55:17 +0800
Message-ID: <20260126035527.1108488-4-ganglxie@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260126035527.1108488-1-ganglxie@amd.com>
References: <20260126035527.1108488-1-ganglxie@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D7:EE_|CH2PR12MB4309:EE_
X-MS-Office365-Filtering-Correlation-Id: 569921f2-0aea-47b8-043f-08de5c8ecd0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?I54aXduxs0aP+OMw7slptM3+hNm4kA3l+RG5oQSxRgDN+rbRSx5LyEsjSkEO?=
 =?us-ascii?Q?BjE4HbRppDn3dXPQVkF4RIQEcaMpOH6YjyqbwFdCd4aPPiRiP3rpAX42UTwn?=
 =?us-ascii?Q?oCE8oc1JTsPBUlVOZqAxSeJG/2j3aFO1cadpetO86ToONvI1JKjGPEpJpCCa?=
 =?us-ascii?Q?qCNzBLC7SHIIMR/RNw07Rjv9XVywOLglr1LPV73vKD8v0E+ynIAgopeKMTfh?=
 =?us-ascii?Q?S0A5rEtIQpGSpC7kQFqCt294jQ8lwjMzYOCjZ73YVgKVg9itsAS8kxWBlGtL?=
 =?us-ascii?Q?xesEu5PTH4gkdZzwnP8I8PAjuljG7vkzcw7s6TJjTGEbCmKtbP4xhd7R4BLr?=
 =?us-ascii?Q?yuer45wC7cxb/Rghv5xvZ9vxa/Y9TMJwp3R01r6kgcLl8oYbRi8zf2g5Zy36?=
 =?us-ascii?Q?QMFXL/Xw3sRwuS2zHnpBLz1tH36ApleeaEHfT1GYoA948WMB1qFJVRi6x+m2?=
 =?us-ascii?Q?sOWxC4gIVa+Vz0nbjfc6Et3isNpXNIpk3gx+CP57GBTLKq/kOak1orgVHGXF?=
 =?us-ascii?Q?COzIN6J5b7JFzmCvkBd4CaVcFgirE5eMoQfJ/mPk7MQJvBv4I6XhFxGt1e0s?=
 =?us-ascii?Q?M4uoj21emHFjmVd6GYIMv4LxLGTlucKT0cJ9UW/ThZ4vY7sEBFQmBhFMNlzi?=
 =?us-ascii?Q?az/5vguhO4lOJSoMt2zah+AQIGsdu7GLXbGUP57rojSOWox/j57VtHZjPQDv?=
 =?us-ascii?Q?n8YwT652X5VOHggvlfHaw5AQ4vVc8mQD83IiX0FqBrpyYN1eKN+Ub4TDLcfa?=
 =?us-ascii?Q?RwPuVeMsUPbSuQ79V0cUdFelCYz0KYVL11iQ/YrCiOy5JCnapyJCn6PmaoWC?=
 =?us-ascii?Q?KfGZl25E3OEiC963nRdd5qeQnriSbuSDaTqEf1EpcAte1lnMcmNWew3Ajx4J?=
 =?us-ascii?Q?zO1dyT7WnQzQQ/DLOBocWcQLCUJPP7nFP7atniz+H60Zn0pyEuLkuExXzLfg?=
 =?us-ascii?Q?/7qrrJBghACuh4mwLqdEjCYdVzujGSUd2kJy2rkJMDAjWoZxqEpgmbnp4KM3?=
 =?us-ascii?Q?CGaJLWz4eWagcq9+qChFBuzlBgUQWp+jxgf2SKI64VO5M64aT/I1eFObKUS6?=
 =?us-ascii?Q?nKJ+qGonX4bUuz7yE+mfjEQwVVDfhLZuvaxCwCludnWDNmJZgJj5BHyRZ3iU?=
 =?us-ascii?Q?dEUyMMsbJLm1XmK60GUKx4ZrZT8APqXAZ2qfOqQo/bdaCbrEaxC+498FcR/t?=
 =?us-ascii?Q?pCDTtJ2DU56CdxjqVFN4GOQOfbnSgAbdKMRYRup4NnRBDTF/SZHTKo4JLthI?=
 =?us-ascii?Q?8SYXgK0IsZU9dCnrumaeK/GD0/D2nbx6O5mWOXvDdKyjHAZ5L2zwHPHrplvK?=
 =?us-ascii?Q?gHp0jweo2JDbyeK7vfYgs2qOSgGViargE/awDbbaSVjsK4evq5ehC6ETFQ/9?=
 =?us-ascii?Q?B3GmRfB1ptjWjiM2bcyvNAwb97+Bj6VcEa84zE4DuM6IASgszWWnLd3suFKV?=
 =?us-ascii?Q?Xvm9OYTQOe5TB2FCDQx4J5zcVvizQI8hE6g9NFNB0wqhYCke8xIBQlIDcftK?=
 =?us-ascii?Q?JngPzo28LddKHilqZHgrSqi2V5+B9+brg+SelS3vSW/E+17QbN2Acu4iv2iB?=
 =?us-ascii?Q?e4UG7Ba1eo/0Zvi8humBwXcYsM1yDayhWk5QynX3AlqSAcjHWZwveoienxTn?=
 =?us-ascii?Q?kczoNOhrzbzbDsCPxzPfp3CiJl0nHTW2PBsVyYZ1+BSG9Fr4LVMNnTIkarw1?=
 =?us-ascii?Q?nMajKw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 03:55:52.7753 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 569921f2-0aea-47b8-043f-08de5c8ecd0e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4309
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
index 000000000000..4a65351569e8
--- /dev/null
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.c
@@ -0,0 +1,38 @@
+// SPDX-License-Identifier: MIT
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
index 000000000000..58472e459470
--- /dev/null
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.h
@@ -0,0 +1,29 @@
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
+#ifndef __RAS_EEPROM_FW_H__
+#define __RAS_EEPROM_FW_H__
+
+void ras_fw_init_feature_flags(struct ras_core_context *ras_core);
+
+#endif
-- 
2.34.1

