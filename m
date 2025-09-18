Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EAB8CAC59F
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Sep 2025 01:36:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8273E10E60A;
	Thu, 18 Sep 2025 01:36:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sHnMDDfV";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013021.outbound.protection.outlook.com
 [40.93.201.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D15310E5FB
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Sep 2025 01:36:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MN+QrEIVP8HePwqxJFc7pPm07z8rvHgwg6wWwcDgAKiu2/NogalWTwhk1JXDlM3CVPRufD7baqPhbszJM9Y3z9yWYAvCrPZD7HKKsLnv1Ml7IFyzBf6FNZgsHuVfWgP335OVHCL3Kh4oylbmf3lxcdMgISQynDBnJUeg/+U1A3QpK7u6aNFEL2vLrGWhr4fMgroM6uRsQsqENFkXb9LgqyKjsaJcvrkAGlaPiuY0sA7tYv568bmrzjAYEbFk3bk9QH7qMXz08+F/+YzQZI7FycWQmUH0guLGOW7jHnHgPge/dA3ao8Wc32I4Ok7ZRBCRZzpv0KhdtS8/TmvT4pjghw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zPl8Lnn9/FXQ9aZfblbUC47QpT5QGhllwb3fKvQTu5M=;
 b=lpwWrbFdZY4J2BjT9iReKM7h+gTg4Ak6DieAtk+nG3Fv7lAc5+dsKrXqnisgg/4BKepi8EjEGCGZfc3Vqv6DktlMovx0M6CzhT0yIb+5v3g5iiLmOYNmLNmWhFs+ICBpjkGDDgQfyeezP+ds/YTo5DYCvIlTXEWwJl3Ake6e2pmpdiqVZCu3Uod3BR5JyQuzCmYkx2acmQ1MrIFKKy7ZLYTXhT9+QLv7RwQVspVjYUvunSqdTmEjBjfs3QFWvlvHDyyqRAoxpZYlTu0UHEqYPgltgXeua75L6xLeR74EApxajWCD+V4O78Ic/qUQ42iEqhmz6Rmcb3FPEX/in0z+xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zPl8Lnn9/FXQ9aZfblbUC47QpT5QGhllwb3fKvQTu5M=;
 b=sHnMDDfV8AOhrwc2v/2NjjIz3HKJ9+UvW+Ng4G+cWDfih1ytA7VodzCX/8BRU6tojVoryKdb8ZXFDiYe03/Nz3Tu8rHssgZJPYl9WK8CGmwwwsoRVFT45b3Z8YrSLcfilNAJ88gt+fJQbhmk3ZpnKkOnbebJuB0AjliYZmO8nYs=
Received: from SN6PR08CA0003.namprd08.prod.outlook.com (2603:10b6:805:66::16)
 by DM6PR12MB4250.namprd12.prod.outlook.com (2603:10b6:5:21a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Thu, 18 Sep
 2025 01:36:46 +0000
Received: from SA2PEPF00001506.namprd04.prod.outlook.com
 (2603:10b6:805:66:cafe::3) by SN6PR08CA0003.outlook.office365.com
 (2603:10b6:805:66::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.22 via Frontend Transport; Thu,
 18 Sep 2025 01:36:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00001506.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Thu, 18 Sep 2025 01:36:46 +0000
Received: from amd-02.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 17 Sep
 2025 18:36:43 -0700
From: YiPeng Chai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Tao.Zhou1@amd.com>, <Candice.Li@amd.com>,
 <Stanley.Yang@amd.com>, YiPeng Chai <YiPeng.Chai@amd.com>, Tao Zhou
 <tao.zhou1@amd.com>
Subject: [PATCH 02/10] drm/amd/ras: Add amdgpu nbio v7_9 configuration function
Date: Thu, 18 Sep 2025 09:34:59 +0800
Message-ID: <20250918013507.2629620-2-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250918013507.2629620-1-YiPeng.Chai@amd.com>
References: <20250918013507.2629620-1-YiPeng.Chai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001506:EE_|DM6PR12MB4250:EE_
X-MS-Office365-Filtering-Correlation-Id: d67aac1b-ac32-4d7c-3023-08ddf653d451
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024|30052699003; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?7Uksz6XDlawT1iVl6ogt936bR4VUii/HuG529wKZi7iHORet4c8YAdb4yvht?=
 =?us-ascii?Q?5hSfO/okzIvx8To2BV6hx+PP2+TPTR1yc73q4ukXfY75BiSz/fM9ppUowPkM?=
 =?us-ascii?Q?zKkIMo1KEbmO1WrlLzPtXW+vt8dp+jUQtOb8qRw2Z8YG+OKge76ylEGn7xba?=
 =?us-ascii?Q?zTAhX98RyBFf+wGTqaJcc+aCuKhnu2HthJGize00xYdDJL3ZY2/U01XLPxxx?=
 =?us-ascii?Q?67vFP40PBG8hWQrQJkPAUobFROukCH1fUG8EkowBB+qhPUYtpXXoLqVDtbwO?=
 =?us-ascii?Q?Ow+tJGl5ub1UZW2aqQ5Hleur/FHy/AYi8KEl4zunPezMfp3apAoepD1g08G+?=
 =?us-ascii?Q?UAyyxxmU2vsmDzfeAmR015oISeXyXt5oNDknWkLMplVIpCXvEzakgIrN4med?=
 =?us-ascii?Q?cczvcOXZl3TMUb46VaikIJwAOgxIUmCONgkdyH27S2iIY1csm/JOJl+ZJ4jV?=
 =?us-ascii?Q?2MgaB2JMZ9w8VyPDGAGe893eTUAKFAxDfLO/Jp75dkbPqmgeRAoHfrIeNN/f?=
 =?us-ascii?Q?4qn9Io6kzxsPh3KRDuHkmuvYLEOp4OJuehF3LHZ9YxzIgEurq+rpf4ZZDVKI?=
 =?us-ascii?Q?zMwiNVB5zqoLgseSv5h7hZ9gjLdskhQrx9f0zaG1H23R5ROn6F8J892FRsGP?=
 =?us-ascii?Q?om1l4WC+hgmx95JsuXCYtuE8f33CzTTotsh1cdEtT/xZhYjIBR4Rz1a2XqSR?=
 =?us-ascii?Q?nGJPCTONquvE+LHIBl727bxvCyPCzLPm9fK8T3yjGn0POFIlBkFHywdmbKZs?=
 =?us-ascii?Q?mPgoIlURyINjj+ugJ3/jKX9eOTphoSwqyMAceSmLB3kRbEQUTzgTilPK6DUm?=
 =?us-ascii?Q?B3Iomj5HlpFc+qOwZtkxa2q/nVVKdAxJaD4u7eppXEtI2a5JJfJP0JZrrMFE?=
 =?us-ascii?Q?rgZtmzaR1UmKomF+NyvHf0D7kK1H0ZprUv9CQ0nvmP0vCY+lL39VpBo94j/j?=
 =?us-ascii?Q?u+EjTE51/cgVSM47LFEItmCbI+lyFPnKC6J4HYpvxY2DXG8TIzKxmFOavWtp?=
 =?us-ascii?Q?xiD4zDEghQDlprYruH/yF4O6cARkU1BJwvY4vCZFUhfDDe7qPXwRdne46j1l?=
 =?us-ascii?Q?C+CvEkf+7C1vlEIdtsHnzZYYvRZAxAhM7ZgVeaV6PBvlI/vHHtAlJjrBNuQP?=
 =?us-ascii?Q?Zl84WtoPjJ+fBvcCv43lkMHgXOTTCr+8YEApL1Zmiku8N/BgSubI4dbjxuho?=
 =?us-ascii?Q?D94Pe8K7xDQwkewNRHhPYTERczjkC9cDfj+LEo2/qeDD9rnMo4AEzuADJCNi?=
 =?us-ascii?Q?EHVMD4c50kSKe+N2HwELUO1yb+Lh067UzYEV/buV8Io44ynLdMnDI0sIeTKF?=
 =?us-ascii?Q?DeNR7Uh+dDy9lYQbLiCx/dRRww3/8Q7pEHf8oz/+Nwb7l32L0AQNfM3yvg2c?=
 =?us-ascii?Q?mPaaQvXpho8jGHCrlnEAP5XVXL7eQAWxKcgo1C7HgVKRJRlCADzv/iLFb4cm?=
 =?us-ascii?Q?cP6t1MxL0cHv33SkDqM/K8obhPB+opVY0w3HiGHGgv69Sl/rpMC+BO+3KMJX?=
 =?us-ascii?Q?yTiGfHYHyr+FmYwHd3+IDwBmIGIlEAxF1KqJ?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024)(30052699003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 01:36:46.0695 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d67aac1b-ac32-4d7c-3023-08ddf653d451
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001506.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4250
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

Add amdgpu nbio v7_9 configuration function.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
---
 .../amd/ras/ras_mgr/amdgpu_ras_nbio_v7_9.c    | 125 ++++++++++++++++++
 .../amd/ras/ras_mgr/amdgpu_ras_nbio_v7_9.h    |  30 +++++
 2 files changed, 155 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_nbio_v7_9.c
 create mode 100644 drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_nbio_v7_9.h

diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_nbio_v7_9.c b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_nbio_v7_9.c
new file mode 100644
index 000000000000..2783f5875c7c
--- /dev/null
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_nbio_v7_9.c
@@ -0,0 +1,125 @@
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
+#include "amdgpu_ras_mgr.h"
+#include "amdgpu_ras_nbio_v7_9.h"
+#include "nbio/nbio_7_9_0_offset.h"
+#include "nbio/nbio_7_9_0_sh_mask.h"
+#include "ivsrcid/nbio/irqsrcs_nbif_7_4.h"
+
+static int nbio_v7_9_set_ras_controller_irq_state(struct amdgpu_device *adev,
+						  struct amdgpu_irq_src *src,
+						  unsigned int type,
+						  enum amdgpu_interrupt_state state)
+{
+	/* Dummy function, there is no initialization operation in driver */
+
+	return 0;
+}
+
+static int nbio_v7_9_process_ras_controller_irq(struct amdgpu_device *adev,
+						struct amdgpu_irq_src *source,
+						struct amdgpu_iv_entry *entry)
+{
+	/* By design, the ih cookie for ras_controller_irq should be written
+	 * to BIFring instead of general iv ring. However, due to known bif ring
+	 * hw bug, it has to be disabled. There is no chance the process function
+	 * will be involked. Just left it as a dummy one.
+	 */
+	return 0;
+}
+
+static int nbio_v7_9_set_ras_err_event_athub_irq_state(struct amdgpu_device *adev,
+						       struct amdgpu_irq_src *src,
+						       unsigned int type,
+						       enum amdgpu_interrupt_state state)
+{
+	/* Dummy function, there is no initialization operation in driver */
+
+	return 0;
+}
+
+static int nbio_v7_9_process_err_event_athub_irq(struct amdgpu_device *adev,
+						 struct amdgpu_irq_src *source,
+						 struct amdgpu_iv_entry *entry)
+{
+	/* By design, the ih cookie for err_event_athub_irq should be written
+	 * to BIFring instead of general iv ring. However, due to known bif ring
+	 * hw bug, it has to be disabled. There is no chance the process function
+	 * will be involked. Just left it as a dummy one.
+	 */
+	return 0;
+}
+
+static const struct amdgpu_irq_src_funcs nbio_v7_9_ras_controller_irq_funcs = {
+	.set = nbio_v7_9_set_ras_controller_irq_state,
+	.process = nbio_v7_9_process_ras_controller_irq,
+};
+
+static const struct amdgpu_irq_src_funcs nbio_v7_9_ras_err_event_athub_irq_funcs = {
+	.set = nbio_v7_9_set_ras_err_event_athub_irq_state,
+	.process = nbio_v7_9_process_err_event_athub_irq,
+};
+
+static int nbio_v7_9_init_ras_controller_interrupt(struct ras_core_context *ras_core, bool state)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)ras_core->dev;
+	int r;
+
+	/* init the irq funcs */
+	adev->nbio.ras_controller_irq.funcs =
+		&nbio_v7_9_ras_controller_irq_funcs;
+	adev->nbio.ras_controller_irq.num_types = 1;
+
+	/* register ras controller interrupt */
+	r = amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_BIF,
+			      NBIF_7_4__SRCID__RAS_CONTROLLER_INTERRUPT,
+			      &adev->nbio.ras_controller_irq);
+
+	return r;
+}
+
+static int nbio_v7_9_init_ras_err_event_athub_interrupt(struct ras_core_context *ras_core,
+			bool state)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)ras_core->dev;
+	int r;
+
+	/* init the irq funcs */
+	adev->nbio.ras_err_event_athub_irq.funcs =
+		&nbio_v7_9_ras_err_event_athub_irq_funcs;
+	adev->nbio.ras_err_event_athub_irq.num_types = 1;
+
+	/* register ras err event athub interrupt */
+	r = amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_BIF,
+			      NBIF_7_4__SRCID__ERREVENT_ATHUB_INTERRUPT,
+			      &adev->nbio.ras_err_event_athub_irq);
+
+	return r;
+}
+
+const struct ras_nbio_sys_func amdgpu_ras_nbio_sys_func_v7_9 = {
+	.set_ras_controller_irq_state = nbio_v7_9_init_ras_controller_interrupt,
+	.set_ras_err_event_athub_irq_state = nbio_v7_9_init_ras_err_event_athub_interrupt,
+};
diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_nbio_v7_9.h b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_nbio_v7_9.h
new file mode 100644
index 000000000000..272259e9a0e7
--- /dev/null
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_nbio_v7_9.h
@@ -0,0 +1,30 @@
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
+#ifndef __AMDGPU_RAS_NBIO_V7_9_H__
+#define __AMDGPU_RAS_NBIO_V7_9_H__
+
+extern const struct ras_nbio_sys_func amdgpu_ras_nbio_sys_func_v7_9;
+
+#endif
-- 
2.34.1

