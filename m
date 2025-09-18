Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADBCBCAC59A
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Sep 2025 01:33:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5185F10E5F4;
	Thu, 18 Sep 2025 01:33:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gTxWTL7q";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011041.outbound.protection.outlook.com [40.107.208.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 26DD410E5F2
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Sep 2025 01:33:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NjDaLoHMkwq9wEjGiPtjDsPxeSXn6wegmfILtbtmHpTiXw/Ow0mYuCQomPYPuJevLbIt8yryo6pxvC1zWTeQjdd7fJv3WpUkXJf/76WCUC1nADVftoRpfAEun5i+ceggCy3fdGnpv4BdDrzFg0df2VupMugTIcAHHPvU5h+KW4mLEeqX0tfpo4fRVFvV/G7BSBa67vUqLf+GwynlHz1GkBTWt2F75E4L0XVMTeZIOHbxdFxD2ZJVQzIhljoLpVc1VTAYjdDIpI/38FaxxSaUlwKmQNy+iqLYQU+l3pz6yBXxr39RJf2aYRhZyZ3KtxsF4FMfvXhnLlOqaSEJJzQiQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ha+Ez3KxDSx4kzncQOdoEa4piaT5nOxegITVuxjbXSM=;
 b=Wb3YXTLT1zmVYyB1lNLGHCP5fekNiQGQFy+4s56WcOmBMy5eXVpopv1dSjf1EbdN42XirOt1RMXipcxXhTQ/w4TExAdVXIGvbeonBKytz3Q7DDZ5AoFRJArO0fCj2gagkAtmwwG4pBjB+5/SU2+M7WlRal5mR8G3PS5FAzkxVlKaKJ8QmU2m87IkyEMyjbXEBmAyrbP6HLU6qKIfYakedHDSQa4sCrgFQWqZDK1Gk+0EOa7HuH3GZyrS6rQiRy5WJ99fd96eAbqzvMYisRzsBTlZLBv7SZqVVeLfmcsI0qGLTQR0WFPD0CkOuza6Gv5WZx+yUDN0iK+GFgKhs8Nm2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ha+Ez3KxDSx4kzncQOdoEa4piaT5nOxegITVuxjbXSM=;
 b=gTxWTL7qvQvkt6+qhIoYDgT1eKJDVTh9y+riQTE543uTRpd/thsnOEJVpuSvX78wnBCfHqITxGfOwyYQpYwDdHE/JVoB3tU4ItVPPjWgYk4uE43c4LHpi4RM8eiz4k4xvdCKTwHPfA9Jg4dMUPzARXow+/RUtrxEOwA85bq9RLo=
Received: from MW2PR2101CA0032.namprd21.prod.outlook.com (2603:10b6:302:1::45)
 by CY5PR12MB6479.namprd12.prod.outlook.com (2603:10b6:930:34::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.18; Thu, 18 Sep
 2025 01:33:22 +0000
Received: from CO1PEPF000044F0.namprd05.prod.outlook.com
 (2603:10b6:302:1:cafe::b7) by MW2PR2101CA0032.outlook.office365.com
 (2603:10b6:302:1::45) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.3 via Frontend Transport; Thu,
 18 Sep 2025 01:33:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000044F0.mail.protection.outlook.com (10.167.241.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Thu, 18 Sep 2025 01:33:22 +0000
Received: from amd-02.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 17 Sep
 2025 18:33:19 -0700
From: YiPeng Chai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Tao.Zhou1@amd.com>, <Candice.Li@amd.com>,
 <Stanley.Yang@amd.com>, YiPeng Chai <YiPeng.Chai@amd.com>, Tao Zhou
 <tao.zhou1@amd.com>
Subject: [PATCH 08/21] drm/amd/ras: Add nbio common ras functions
Date: Thu, 18 Sep 2025 09:32:19 +0800
Message-ID: <20250918013232.2629215-8-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250918013232.2629215-1-YiPeng.Chai@amd.com>
References: <20250918013232.2629215-1-YiPeng.Chai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F0:EE_|CY5PR12MB6479:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ea4ab36-9837-445a-fad8-08ddf6535ada
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?eY3rJ8JCyq4Q+79kRgYTMglAVec4zKsl1Q8rOv9y+6ARBrB94pjtJBbpZ+sw?=
 =?us-ascii?Q?+2/i9zlEgW2WLT6gsOBzY3FrIQxfxJuP4lG93Fs71swssGyK3flQ1Vglt0nV?=
 =?us-ascii?Q?0znuWxBtOVaKuJAxaCKX2vaKAtCivy9X/muBzAufU0tH4959xBAz9VmVf6B5?=
 =?us-ascii?Q?9JNvRh7lOLHHE/Q+oSJgwThZa/kaQr0CMlBUNKsLe9GrQnIKeLSwHNMmX64H?=
 =?us-ascii?Q?p0Sl8mLlj0g1mt/5dmq38PASY4dPshFIJiUWnyLmb0mD8lgLS6YopclS8lBR?=
 =?us-ascii?Q?9ar637nXPmQIp8iF9eVbWRLGKZiajRGibdzTCsJMdR5XrOEy3jKEffbJxyqs?=
 =?us-ascii?Q?yocaTiSqAgA1OuYl3owR8XSPg/2zHZ5Bplcvhz4IiBj9qZIlJ7/bo6E2vryd?=
 =?us-ascii?Q?OgaqqWS8fYaXX+VXGVHxIwWoBwlSkU+KTOalCm/wNii00yQu9uxlHghSizwu?=
 =?us-ascii?Q?St4Si68sAzEwPjOFoR9EpynLe1abotIZsPXJ52KQdhuFcDDyajkv/1na4eUp?=
 =?us-ascii?Q?nMKx9uPtoYrmHpgnAMvthLsRenuaVD8aJZUnZ/3QGiM+Dej6vCkk7SZU+qSb?=
 =?us-ascii?Q?0j7AD1G/aQbvisgwAoIqNkmvYFZQf1PZ3RlBIsHaedHFby6AH4dYReHeV/v8?=
 =?us-ascii?Q?CaXkeCGlrmWBar1IQcXrcZ2jwDR9iD83AL1wgbpOZyVGP2ZsawCa0dbQgr01?=
 =?us-ascii?Q?zbUQxD4ebFRhQN6w8heDhj4vwGX4cXIyL93GmrpChow0/DOvwa5uMrD+FnLi?=
 =?us-ascii?Q?2ay+tuHLpscy8r0PAT3sZZP+rvI3SkZG8dWbvGJEl1CBJGrvLMzp2XfSfeIn?=
 =?us-ascii?Q?WDf8YxbxW+Bpp2G+0KXZ+nxic2C/h7VAy0xZcvFIxEBcZUX7C7mGmYgJ6kgX?=
 =?us-ascii?Q?M8716d9Sz9C1RVIKK+hJaSk74mFjpK5DQBtPzMfmOoSJsFrEW5dCy/LZBEKo?=
 =?us-ascii?Q?y1XCGEvxsVoULRytAjZGDxRIrWnmZGYtFLrdleZ/8YB8U3AKW/gfSMq9sQtI?=
 =?us-ascii?Q?f2eRhK0ztpmcvEhkARU2TN1vWgIfgxZcBDNQf8JEDCFXLQcpMeErqNaBYQlo?=
 =?us-ascii?Q?BPeg9qVvpZa+kFY+0s/JuD80j3Smw306+JH/5BvjuSV7vUPDeiyQGKEK6kxT?=
 =?us-ascii?Q?2F6a5uex2uVi3YFzRUAsmUruQHlPDb4iVyXsq7+h/az4KphAIDNnO8sh67o9?=
 =?us-ascii?Q?pVMux9f1QOLpafEg8+loROF+ovaMhUkffJ9bYjcCzC/8JL1ryBQ7zyVqbDNj?=
 =?us-ascii?Q?OvupJwhiODbPBiy6lz5DR2saHTllNGQ6+DJZTUEtjlkGgaztAyzfwHhbzHgG?=
 =?us-ascii?Q?yXeDYjzqCHiUb8ZAEJEACinKxiPvmihACmX0/VqpPuHNzSSEbw6w3TCct640?=
 =?us-ascii?Q?A4NavOHrc0OOV6PsJvJaYcH5ofgTrQ8gX2LH3aos8tjGs+Y5ugdS9EdZvNks?=
 =?us-ascii?Q?uiUKBTvQSmReDezYpoAD+z93RCIq7eOQwegDIcp2MwZi2YmupPARGrKY03/J?=
 =?us-ascii?Q?LiCY1HWkOpD9yrGft8t/cP8T3sCrIphvbjzA?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 01:33:22.2173 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ea4ab36-9837-445a-fad8-08ddf6535ada
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6479
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

Add nbio common ras functions.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/ras/rascore/ras_nbio.c | 95 ++++++++++++++++++++++
 drivers/gpu/drm/amd/ras/rascore/ras_nbio.h | 46 +++++++++++
 2 files changed, 141 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/ras/rascore/ras_nbio.c
 create mode 100644 drivers/gpu/drm/amd/ras/rascore/ras_nbio.h

diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_nbio.c b/drivers/gpu/drm/amd/ras/rascore/ras_nbio.c
new file mode 100644
index 000000000000..8bf1f35d595e
--- /dev/null
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_nbio.c
@@ -0,0 +1,95 @@
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
+#include "ras_nbio.h"
+#include "ras_nbio_v7_9.h"
+
+static const struct ras_nbio_ip_func *ras_nbio_get_ip_funcs(
+				struct ras_core_context *ras_core, uint32_t ip_version)
+{
+	switch (ip_version) {
+	case IP_VERSION(7, 9, 0):
+		return &ras_nbio_v7_9;
+	default:
+		RAS_DEV_ERR(ras_core->dev,
+			"NBIO ip version(0x%x) is not supported!\n", ip_version);
+		break;
+	}
+
+	return NULL;
+}
+
+int ras_nbio_hw_init(struct ras_core_context *ras_core)
+{
+	struct ras_nbio *nbio = &ras_core->ras_nbio;
+
+	nbio->nbio_ip_version = ras_core->config->nbio_ip_version;
+	nbio->sys_func = ras_core->config->nbio_cfg.nbio_sys_fn;
+	if (!nbio->sys_func) {
+		RAS_DEV_ERR(ras_core->dev, "RAS nbio sys function not configured!\n");
+		return -EINVAL;
+	}
+
+	nbio->ip_func = ras_nbio_get_ip_funcs(ras_core, nbio->nbio_ip_version);
+	if (!nbio->ip_func)
+		return -EINVAL;
+
+	if (nbio->sys_func) {
+		if (nbio->sys_func->set_ras_controller_irq_state)
+			nbio->sys_func->set_ras_controller_irq_state(ras_core, true);
+		if (nbio->sys_func->set_ras_err_event_athub_irq_state)
+			nbio->sys_func->set_ras_err_event_athub_irq_state(ras_core, true);
+	}
+
+	return 0;
+}
+
+int ras_nbio_hw_fini(struct ras_core_context *ras_core)
+{
+	struct ras_nbio *nbio = &ras_core->ras_nbio;
+
+	if (nbio->sys_func) {
+		if (nbio->sys_func->set_ras_controller_irq_state)
+			nbio->sys_func->set_ras_controller_irq_state(ras_core, false);
+		if (nbio->sys_func->set_ras_err_event_athub_irq_state)
+			nbio->sys_func->set_ras_err_event_athub_irq_state(ras_core, false);
+	}
+
+	return 0;
+}
+
+bool ras_nbio_handle_irq_error(struct ras_core_context *ras_core, void *data)
+{
+	struct ras_nbio *nbio = &ras_core->ras_nbio;
+
+	if (nbio->ip_func) {
+		if (nbio->ip_func->handle_ras_controller_intr_no_bifring)
+			nbio->ip_func->handle_ras_controller_intr_no_bifring(ras_core);
+		if (nbio->ip_func->handle_ras_err_event_athub_intr_no_bifring)
+			nbio->ip_func->handle_ras_err_event_athub_intr_no_bifring(ras_core);
+	}
+
+	return true;
+}
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_nbio.h b/drivers/gpu/drm/amd/ras/rascore/ras_nbio.h
new file mode 100644
index 000000000000..0a1313e59a02
--- /dev/null
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_nbio.h
@@ -0,0 +1,46 @@
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
+#ifndef __RAS_NBIO_H__
+#define __RAS_NBIO_H__
+#include "ras.h"
+
+struct ras_core_context;
+
+struct ras_nbio_ip_func {
+	int (*handle_ras_controller_intr_no_bifring)(struct ras_core_context *ras_core);
+	int (*handle_ras_err_event_athub_intr_no_bifring)(struct ras_core_context *ras_core);
+	uint32_t (*get_memory_partition_mode)(struct ras_core_context *ras_core);
+};
+
+struct ras_nbio {
+	uint32_t nbio_ip_version;
+	const struct ras_nbio_ip_func *ip_func;
+	const struct ras_nbio_sys_func *sys_func;
+};
+
+int ras_nbio_hw_init(struct ras_core_context *ras_core);
+int ras_nbio_hw_fini(struct ras_core_context *ras_core);
+bool ras_nbio_handle_irq_error(struct ras_core_context *ras_core, void *data);
+#endif
-- 
2.34.1

