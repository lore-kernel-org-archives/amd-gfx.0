Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE172D3B9A9
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Dec 2025 07:14:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5276310E680;
	Wed, 10 Dec 2025 07:14:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2/dXOirJ";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010024.outbound.protection.outlook.com [52.101.85.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A7CAC10E67C
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Dec 2025 07:14:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DqMdVdpgG2D2zvVhwzR+WJz4RJeXsRvFTg0qvxU3fxCr/FTkxLmfRt3hp05p+CXg/adQ6RzDp0//i6ujtEOQTyOBnFeTLeNBOO+b/LWAUsQYONDsomn1a2zW+/Ws7Xm04DtOSKFvjwP5omOk2R0SKkGGVxuqUBhUGoQkPj+rPGh6yvliYEc7/xz6fcfN+dhyd52pQlGKvNolr38FsJw8w6jOYsCPLbYEdytFg++6SOP+kZp6Nnfz3xcMS9YZgNnlyY0ZXF4XrQS9uZajXCWgvOQ7HVJiAJIz3V4EGY3PQ7KZ2KJp0vW6GrXuw23Rdx1sNf4y7lIF8E2UvSe6lS52UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6mm8xKKzh8w37fNbYctu8jj6mNPewqV4IF4R3nV8Hns=;
 b=rkD5bOqD3VB+j3RC3v4Rm3zvJz4TzZUGz4IrgCOLde37NJP9YsEN3VwFuQ6e+u0zzsfFOptVqwT3Rt/N4ifaMb9jzZzmL+1lzA33Z91SUuO6TaBGQ66uCjIfOve3QqXxi1ghrAU00y0ps1ztwt/iZYChMgz+gev0U98raoqvQ+nCrGFyoxzxsT2Xc/lLAyzWeqOeQabKaad6BLnpR6iAwomgcAEY0FNxeRzIAZXNwBcRkMs2RvDSnKH4Li1H4tt9A+Ri0kcF/ZUSMbtV6sQDgEZ0ph6rgB6eNmdAnY7URBP8QCYdT0wTane81E8kFa56+QxiRilVJYnltO8xCPKw6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6mm8xKKzh8w37fNbYctu8jj6mNPewqV4IF4R3nV8Hns=;
 b=2/dXOirJTl0m0Qr8QC8IRkYuv76K/orudOyCdpEgPchFpxnnAXp/eeLVWT3+LytQqOA9cG3zAX1cDg9vwBsYZHP6GrjxeLUYAa64BlvfT0zjYCIwm1/lgOYnirQ6KUp5ctjnDcDxrXXsrMb5WVXD2LOXwealo+SdBJkB6cHqIhc=
Received: from SA1P222CA0176.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c4::12)
 by PH7PR12MB6739.namprd12.prod.outlook.com (2603:10b6:510:1aa::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.8; Wed, 10 Dec
 2025 07:14:43 +0000
Received: from SN1PEPF000252A2.namprd05.prod.outlook.com
 (2603:10b6:806:3c4:cafe::67) by SA1P222CA0176.outlook.office365.com
 (2603:10b6:806:3c4::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.8 via Frontend Transport; Wed,
 10 Dec 2025 07:14:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000252A2.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Wed, 10 Dec 2025 07:14:43 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 10 Dec
 2025 01:14:37 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Hawking Zhang <Hawking.Zhang@amd.com>, Likun Gao <Likun.Gao@amd.com>,
 "Alex Deucher" <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: Add gfx v12_1 interrupt source header
Date: Wed, 10 Dec 2025 02:14:14 -0500
Message-ID: <20251210071415.19983-20-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251210071415.19983-1-alexander.deucher@amd.com>
References: <20251210071415.19983-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A2:EE_|PH7PR12MB6739:EE_
X-MS-Office365-Filtering-Correlation-Id: 81fa37be-614e-49ab-d1d6-08de37bbcaff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Xxqm8HNCQC4NJoG5sHG3RG7MbnmpdBWRzW0BidmxS3DkEFmENOo3QMTzm+t9?=
 =?us-ascii?Q?g4HHuUrSvU9L5zFPZyJui3IM8VHoT5vi/HzERD7TkEKABFr3WJZAiATDZGYI?=
 =?us-ascii?Q?+9EbgUrus2vg17HhOp5jZPHWYmQG9QPlS+He5Kz+Q4As+3kEUNRgVIW6AShb?=
 =?us-ascii?Q?Vr5/JLz+pigw8nx5wP/WkFAooWerLKMoP9McT/xTvqavru8K1skquymIwJB9?=
 =?us-ascii?Q?/MLa/enVowHDwQCu9an2xD5ZYsb7PBStVu6LONwTHsc0LX7tu0/Jb6kbueI5?=
 =?us-ascii?Q?POjWC14v1c9YP8p4wsBF868DrAkahpFcHVnqjFhqJ4d72xhVDeDKr0I0I5FG?=
 =?us-ascii?Q?ZKYM0d3ngXbgPRWyoXn0asA8BZUB5EWi9Nk7Hn45wXdD1mziHH/kIcrDDKrA?=
 =?us-ascii?Q?8Ui9o4hojbir/1hbn17XQtoFCuWkX1jfVJd1lZz2OPGSBqHe38chY6Qf4JUy?=
 =?us-ascii?Q?YJt3xYWjXoMgRS/hTmP14RiemFA5N4/qip25oFGZYxa+h7LkWBtqZ7czLb+t?=
 =?us-ascii?Q?tVSg0dcKq1ijlGug4RK6DA4JYOLJkqDZP3R8kN5+GDdyD8RLYEF2O0Rds4KT?=
 =?us-ascii?Q?SbcaCDKkn0YUEmnEquMraDmGLRCOBfgMsDM0wErbtU8WX2H3E8blx+zzh8Lm?=
 =?us-ascii?Q?zz70QhB8olGH+SIlYPRoaB9odN/IvissT1/aMRCiN2mqdnv8sa5P0tgp44MF?=
 =?us-ascii?Q?uxP1eF8Ser1tVBB5GbYDRfgSAcwNdQg9hEt3eiWKitXJziJLSQSCy7Gt86m6?=
 =?us-ascii?Q?a0fqk8TviP+WhXU2a7qU4fkqU4RWNXbe9DrHPQKVb13VvH6im8PMKtDKvBxs?=
 =?us-ascii?Q?SggTvdFKzF+GeTUchCKzxz2rma08xD1JXZkNccktDRal8L050EWBxe1weBxC?=
 =?us-ascii?Q?CCGnqNmNRXjub8Jb1aJM9wfwkatKQIBSLSXopf6Ce5aA8hDMQB8SvNlbebYn?=
 =?us-ascii?Q?0Ub7n/HhQZKI0XWXV3b6gAAi1Om7KBdkIHXzQaexW+B9kwIzJoE2KKhzZQPi?=
 =?us-ascii?Q?cIZZnVSFjBLvItX6F/5w1l2sqI5NIfdXPK4dA+zECiUDq5OwqsgSYhwyV5xE?=
 =?us-ascii?Q?Ys+n47E3YvCIkmNivGE+0mtxOU9bR95AIdHZKOnxhKGnCmdW5ojDGby/SIvR?=
 =?us-ascii?Q?WBF0pd4pAfQNGNbfXU4kGM4kOB0PrgOztJ+Oh0Gaw+ax1ku6jGZvDNMcgrJi?=
 =?us-ascii?Q?rWupDsk3xhSVR5s3ArLL1OXhJEt8kUtXX4qLyvuxUg1h8hhv8/IvfwKKxXks?=
 =?us-ascii?Q?DQrBmqhXDk8xu79N6L4rnKK6AKWBj8sjxo1flPSyc1Qhdv75t6e02CGv4ccF?=
 =?us-ascii?Q?Lqo4BeNUEs++pOtGjxc0l6xj1RXDgfV6Et1gIIxEeIXa9gujk5XTfSEWYRz2?=
 =?us-ascii?Q?wedYX0GHfrCkF8ifqZ2pyH7TghXUCwvhL5MK+feF5I4fZNdVrEEgDYtzWocf?=
 =?us-ascii?Q?mDbjmeMpqcpsFzwngZvYHA5wyCvXnaB7hIZU/NzjOuo4E0vJ70rB570hO34U?=
 =?us-ascii?Q?QfTec3A83AEebBquU6ipo3c9SmFpULM3dNKjdOC31ClWFYJVFHH1Svzzfnfo?=
 =?us-ascii?Q?LH9E3TyqSvI9fvs92lg=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2025 07:14:43.6742 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 81fa37be-614e-49ab-d1d6-08de37bbcaff
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6739
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

From: Hawking Zhang <Hawking.Zhang@amd.com>

To acommandate specific interrupt source for gfx v12_1

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Likun Gao <Likun.Gao@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c        |   8 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c        |   4 +-
 .../include/ivsrcid/gfx/irqsrcs_gfx_12_1_0.h  | 136 ++++++++++++++++++
 3 files changed, 142 insertions(+), 6 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/include/ivsrcid/gfx/irqsrcs_gfx_12_1_0.h

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
index 96ca3648205d6..6a4ecded103aa 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
@@ -37,7 +37,7 @@
 #include "gc/gc_12_1_0_offset.h"
 #include "gc/gc_12_1_0_sh_mask.h"
 #include "soc24_enum.h"
-#include "ivsrcid/gfx/irqsrcs_gfx_11_0_0.h"
+#include "ivsrcid/gfx/irqsrcs_gfx_12_1_0.h"
 
 #include "soc15.h"
 #include "clearstate_gfx12.h"
@@ -1170,21 +1170,21 @@ static int gfx_v12_1_sw_init(struct amdgpu_ip_block *ip_block)
 
 	/* EOP Event */
 	r = amdgpu_irq_add_id(adev, SOC_V1_0_IH_CLIENTID_GRBM_CP,
-			      GFX_11_0_0__SRCID__CP_EOP_INTERRUPT,
+			      GFX_12_1_0__SRCID__CP_EOP_INTERRUPT,
 			      &adev->gfx.eop_irq);
 	if (r)
 		return r;
 
 	/* Privileged reg */
 	r = amdgpu_irq_add_id(adev, SOC_V1_0_IH_CLIENTID_GRBM_CP,
-			      GFX_11_0_0__SRCID__CP_PRIV_REG_FAULT,
+			      GFX_12_1_0__SRCID__CP_PRIV_REG_FAULT,
 			      &adev->gfx.priv_reg_irq);
 	if (r)
 		return r;
 
 	/* Privileged inst */
 	r = amdgpu_irq_add_id(adev, SOC_V1_0_IH_CLIENTID_GRBM_CP,
-			      GFX_11_0_0__SRCID__CP_PRIV_INSTR_FAULT,
+			      GFX_12_1_0__SRCID__CP_PRIV_INSTR_FAULT,
 			      &adev->gfx.priv_inst_irq);
 	if (r)
 		return r;
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c
index e3963675bfac0..fe0e84b45cf4b 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c
@@ -32,7 +32,7 @@
 
 #include "gc/gc_12_1_0_offset.h"
 #include "gc/gc_12_1_0_sh_mask.h"
-#include "ivsrcid/gfx/irqsrcs_gfx_11_0_0.h"
+#include "ivsrcid/gfx/irqsrcs_gfx_12_1_0.h"
 
 #include "soc15_common.h"
 #include "soc15.h"
@@ -1278,7 +1278,7 @@ static int sdma_v7_1_sw_init(struct amdgpu_ip_block *ip_block)
 
 	/* SDMA trap event */
 	r = amdgpu_irq_add_id(adev, SOC_V1_0_IH_CLIENTID_GFX,
-			      GFX_11_0_0__SRCID__SDMA_TRAP,
+			      GFX_12_1_0__SRCID__SDMA_TRAP,
 			      &adev->sdma.trap_irq);
 	if (r)
 		return r;
diff --git a/drivers/gpu/drm/amd/include/ivsrcid/gfx/irqsrcs_gfx_12_1_0.h b/drivers/gpu/drm/amd/include/ivsrcid/gfx/irqsrcs_gfx_12_1_0.h
new file mode 100644
index 0000000000000..9fe5466e94183
--- /dev/null
+++ b/drivers/gpu/drm/amd/include/ivsrcid/gfx/irqsrcs_gfx_12_1_0.h
@@ -0,0 +1,136 @@
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
+#ifndef __IRQSRCS_GFX_12_1_0_H__
+#define __IRQSRCS_GFX_12_1_0_H__
+
+/* 0x0 UTCL2 has encountered a fault scenario */
+#define GFX_12_1_0__SRCID__UTCL2_FAULT				0
+/* 0x1 UTCL2 has encountered a retry scenario */
+#define GFX_12_1_0__SRCID__UTCL2_RETRY				1
+/* 0x2 UTCL2 for data poisoning */
+#define GFX_12_1_0__SRCID__UTCL2_DATA_POISONING			2
+/* 0x30 SDMA atomic*_rtn ops complete */
+#define GFX_12_1_0__SRCID__SDMA_ATOMIC_RTN_DONE			48
+/* 0x31 Trap */
+#define GFX_12_1_0__SRCID__SDMA_TRAP				49
+/* 0x32 SRBM write Protection */
+#define GFX_12_1_0__SRCID__SDMA_SRBMWRITE			50
+/* 0x33 Context Empty */
+#define GFX_12_1_0__SRCID__SDMA_CTXEMPTY			51
+/* 0x34 SDMA New Run List */
+#define GFX_12_1_0__SRCID__SDMA_PREEMPT				52
+/* 0x35 sdma mid - command buffer preempt interrupt */
+#define GFX_12_1_0__SRCID__SDMA_IB_PREEMPT			53
+/* 0x36 Doorbell BE invalid */
+#define GFX_12_1_0__SRCID__SDMA_DOORBELL_INVALID		54
+/* 0x37 Queue hang or Command timeout */
+#define GFX_12_1_0__SRCID__SDMA_QUEUE_HANG			55
+/* 0x38 SDMA atomic CMPSWAP loop timeout */
+#define GFX_12_1_0__SRCID__SDMA_ATOMIC_TIMEOUT			56
+/* 0x39 SRBM read poll timeout */
+#define GFX_12_1_0__SRCID__SDMA_POLL_TIMEOUT			57
+/* 0x3A Page retry  timeout after UTCL2 return nack = 1 */
+#define GFX_12_1_0__SRCID__SDMA_PAGE_TIMEOUT			58
+/* 0x3B Page Null from UTCL2 when nack = 2 */
+#define GFX_12_1_0__SRCID__SDMA_PAGE_NULL			59
+/* 0x3C Page Fault Error from UTCL2 when nack = 3 */
+#define GFX_12_1_0__SRCID__SDMA_PAGE_FAULT			60
+/* 0x3D MC or SEM address in VM hole */
+#define GFX_12_1_0__SRCID__SDMA_INVALID_ADDR 			61
+/* 0x3E ECC Error */
+#define GFX_12_1_0__SRCID__SDMA_ECC				62
+/* 0x3F SDMA Frozen */
+#define GFX_12_1_0__SRCID__SDMA_FROZEN				63
+/* 0x40 SRAM ECC Error */
+#define GFX_12_1_0__SRCID__SDMA_SRAM_ECC			64
+/* 0x41 GPF(Sem incomplete timeout) */
+#define GFX_12_1_0__SRCID__SDMA_SEM_INCOMPLETE_TIMEOUT		65
+/* 0x42 Semaphore wait fail timeout */
+#define GFX_12_1_0__SRCID__SDMA_SEM_WAIT_FAIL_TIMEOUT		66
+/* 0x43 Wptr less than Rptr in active queue */
+#define GFX_12_1_0__SRCID__SDMA_INVALID_RB_PTR 			67
+/* 0x44 BE command exception */
+#define GFX_12_1_0__SRCID__SDMA_BE_EXCEPTION 			68
+/* 0x46 User fence. inherit from gfx v12_0 for gfx user queue */
+#define GFX_12_1_0__SRCID__SDMA_FENCE				70
+/* 0xB0 CP_INTERRUPT pkt in RB */
+#define GFX_12_1_0__SRCID__CP_RB_INT_PKT 			176
+/* 0xB1 CP_INTERRUPT pkt in IB1 */
+#define GFX_12_1_0__SRCID__CP_IB1_INT_PKT			177
+/* 0xB2 CP_INTERRUPT pkt in IB2 */
+#define GFX_12_1_0__SRCID__CP_IB2_INT_PKT			178
+/* 0xB3 DMA Watch Interrupt */
+#define GFX_12_1_0__SRCID__CP_DMA_WATCH_INTERRUPT 		179
+/* 0xB4 PM4 Pkt Rsvd Bits Error */
+#define GFX_12_1_0__SRCID__CP_PM4_PKT_RSVD_BIT_ERROR		180
+/* 0xB5 End-of-Pipe Interrupt */
+#define GFX_12_1_0__SRCID__CP_EOP_INTERRUPT			181
+/* 0xB7 Bad Opcode Error */
+#define GFX_12_1_0__SRCID__CP_BAD_OPCODE_ERROR			183
+/* 0xB8 Privileged Register Fault */
+#define GFX_12_1_0__SRCID__CP_PRIV_REG_FAULT			184
+/* 0xB9 Privileged Instr Fault */
+#define GFX_12_1_0__SRCID__CP_PRIV_INSTR_FAULT			185
+/* 0xBA Wait Memory Semaphore Fault (Sync Object Fault) */
+#define GFX_12_1_0__SRCID__CP_WAIT_MEM_SEM_FAULT		186
+/* 0xBB Context Empty Interrupt */
+#define GFX_12_1_0__SRCID__CP_CTX_EMPTY_INTERRUPT		187
+/* 0xBC Context Busy Interrupt */
+#define GFX_12_1_0__SRCID__CP_CTX_BUSY_INTERRUPT		188
+/* 0xC0 CP.ME Wait_Reg_Mem Poll Timeout */
+#define GFX_12_1_0__SRCID__CP_ME_WAIT_REG_MEM_POLL_TIMEOUT	192
+/* 0xC1 Surface Probe Fault Signal Incomplete */
+#define GFX_12_1_0__SRCID__CP_SIG_INCOMPLETE			193
+/* 0xC2 Preemption Ack-wledge */
+#define GFX_12_1_0__SRCID__CP_PREEMPT_ACK			194
+/* 0xC3 General Protection Fault (GPF) */
+#define GFX_12_1_0__SRCID__CP_GPF				195
+/* 0xC4 GDS Alloc Error */
+#define GFX_12_1_0__SRCID__CP_GDS_ALLOC_ERROR			196
+/* 0xC5 ECC Error */
+#define GFX_12_1_0__SRCID__CP_ECC_ERROR				197
+/* 0xC8 Unattached VM Doorbell Received */
+#define GFX_12_1_0__SRCID__CP_VM_DOORBELL			200
+/* 0xC9 ECC FUE Error */
+#define GFX_12_1_0__SRCID__CP_FUE_ERROR				201
+/* 0xCA Suspend Completion Interrupt */
+#define GFX_12_1_0__SRCID__CP_SUSPEAND_REQ_INTERRUPT 		202
+/* 0xCB Resume Completion Interrupt */
+#define GFX_12_1_0__SRCID__CP_RESUME_REQ_INTERRUPT 		203
+/* 0xCA RLC Streaming Perf Monitor Interrupt
+ * ContextID[15:0] each bit indicates poison is seen on respecive indexed VMID
+ * Ex: ContextID[3] == 1 means VMID-3 encountered poison consumption
+ * ContextID[16] == 1 indicates that complete VF need to reset with FLR */
+#define GFX_12_1_0__SRCID__RLC_STRM_PERF_MONITOR_INTERRUPT 	202
+/* 0xCB RLC Poison Interrupt */
+#define GFX_12_1_0__SRCID__RLC_POISON_INTERRUPT 		203
+/* 0xE7 High on ContextID[0] - nHT Error;  ContextID[1] - illegal Opcode Error */
+#define GFX_12_1_0__SRCID__PMR_EA_ERROR_INTERRUPT 		231
+/* 0xE8 CRead timeout error */
+#define GFX_12_1_0__SRCID__GRBM_RD_TIMEOUT_ERROR		232
+/* 0xE9 Register GUI Idle */
+#define GFX_12_1_0__SRCID__GRBM_REG_GUI_IDLE			233
+/* 0xEF SQ Interrupt (ttrace wrap, errors) */
+#define GFX_12_1_0__SRCID__SQ_INTERRUPT_ID			239
+
+#endif
-- 
2.52.0

