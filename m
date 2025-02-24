Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93B7FC021A4
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Feb 2025 22:54:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1798510E069;
	Mon, 24 Feb 2025 22:54:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="T2RB3zFq";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2043.outbound.protection.outlook.com [40.107.223.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3213610E069
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Feb 2025 22:53:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TT6ZdKuR4djwlOzEQoYS2fDSlfl+bC6wBtBsqZNW1eQOQPKBPdWPTu0Dg4bS2SlGnffKZiTrAF7eooDsf2akMDU8RhGtNfVU+AjXTUhmAyhMdhvdhkpYl9hSqEWBFBeHUNbgHLbWn+OP9nHG4utMWodOPO31zqhjIQEYQw9jS1EN43wytaD/N/T7vT0dtOb78zXXUT2dQfwbviQHt4zQd0lR48iuGop55m8yYneGrH7CUIlBy+bmDJA/eIK7fLJ0nNsW125k+qOmMsCIwEZf/Mk5hBtY/+r/jKxtrSJcQJeZ0rd1sg5iXxjWqq15k+BYSlsFUneyWcr6PIfIJXauYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TyWflN35yqKO0VJ7PAWz1Q4YYe+i9vBfeOGhbGMnxOE=;
 b=qC3F/6QnUZV2Jszao/25AdnFDiV0Vu4NySranRlyF8qMuD9ETDybruoJsHsB51jJMlVIdGtZYMUdC1yncsUgHoCO2OWdQYU6k9nTjMevXsD/ClNSWf3jpzmskgj3tc4zxHo2LxTJVK2RYIJ6GaoLKyRT7MmArO9DVaAO6WThpm7vOmWHkn/Hax5SFYq/6/ZUtoklylXdHVZTK12ISX6J2LQFJywNz7uH4n1W2boSW26XbC+Nqojtnr4uZlGTOhG2M+0SY05PV42wAZajayT44XVmdz13D0tt0+xS6JKInBS9k+psPFgXLVhRSwWdgjoZ5hPkC4g/QsG4vmEy4oJJbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TyWflN35yqKO0VJ7PAWz1Q4YYe+i9vBfeOGhbGMnxOE=;
 b=T2RB3zFqpkDnFrdgp8XWPDe7Akb6FgOqJpD+np3wUGwU1gqNhecq/j291cM6Yb3fv/OSpVoKuv3UUBTXzCarsezP78bq/IEGgdTXiRhHpzfvt/8ze31GWrhZM/TX++LQt/Yllozur0SZRYhYG/I8Egw0NhSee14xiSuLoajnuFo=
Received: from CH0PR13CA0001.namprd13.prod.outlook.com (2603:10b6:610:b1::6)
 by PH7PR12MB9065.namprd12.prod.outlook.com (2603:10b6:510:1f7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Mon, 24 Feb
 2025 22:53:45 +0000
Received: from CH3PEPF0000000A.namprd04.prod.outlook.com
 (2603:10b6:610:b1:cafe::a8) by CH0PR13CA0001.outlook.office365.com
 (2603:10b6:610:b1::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.16 via Frontend Transport; Mon,
 24 Feb 2025 22:53:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH3PEPF0000000A.mail.protection.outlook.com (10.167.244.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8489.16 via Frontend Transport; Mon, 24 Feb 2025 22:53:44 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 24 Feb
 2025 16:53:44 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 24 Feb
 2025 16:53:44 -0600
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 24 Feb 2025 16:53:43 -0600
From: Xiaogang.Chen <xiaogang.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <felix.kuehling@amd.com>, Xiaogang Chen <xiaogang.chen@amd.com>
Subject: [PATCH] drm/amdkfd: remove kfd_pasid.c from amdgpu driver build
Date: Mon, 24 Feb 2025 16:59:42 -0600
Message-ID: <20250224225942.278208-1-xiaogang.chen@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000A:EE_|PH7PR12MB9065:EE_
X-MS-Office365-Filtering-Correlation-Id: 009a42ea-8a47-42e7-7350-08dd552617a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Tj4AeNPEMwrh1hMbqh5T23Kym9SZ0zbWFNzVnjDXM1zeDMrWfX10Wk1xN/cz?=
 =?us-ascii?Q?OYcGFh9BtrTpRU3S8Pyj7KmTYQi75UetWq1yON2tCjdDeSA6KwHD7dBhcspa?=
 =?us-ascii?Q?nKQ51dwBGCoqIWHzlDvvm6AvjAU8NICEOXxO+CTDyT73ePCOONOTzV+HRYvZ?=
 =?us-ascii?Q?YDyrqgkfLQPyv62s8+LT8pnlyErcedF9dYkfh87un+OtgtumloU3VLhTo/Rz?=
 =?us-ascii?Q?/hZK8jpOa1yzO4ac/EtXNaLrg7BjJfJlxDeS7F1psM5acS9VCx3EixCGxwvT?=
 =?us-ascii?Q?o02QMpg+xG7ySX+ArNEVzVMRi1/FGRjyu/gZShY0F6uFeksMbHD2qL51TsRe?=
 =?us-ascii?Q?xJAbFz53of7QKT5EOepE2PFYO4blpBo/jqc58YqTyk725dPdwuntKyhhSSK+?=
 =?us-ascii?Q?qnEZmLliY4lkXWXS/0FM8yzazLZjuDV7NAru6MCkQoFqtp0tO3am00NX1mEY?=
 =?us-ascii?Q?zBp2snA3beXa0VHh9GaffbXPiXbre9t96NBUAmaKk1VIDX0dz040h8O4lzP4?=
 =?us-ascii?Q?/iTIt1TivgnC42giEMnBBTDLTIppw5/AUKedz5HvAAv/vODcq6hhJaSCPIxF?=
 =?us-ascii?Q?fOppnhu7wJW04tOpPa200Z4ur/kdQIi5GtL/McSG+eewKMMIea47hRiq2RJQ?=
 =?us-ascii?Q?AQH9FK7lktMOLBvjipM5XZtTzigUEg7ESei+814bm/4TBCFZZsBZeZUjZxtv?=
 =?us-ascii?Q?wmIqx1V9NgCYkiP8OH5wEcP98kv/Tu9Iay8umRNFxYCyzHWNJCM8ABOjtQzu?=
 =?us-ascii?Q?TG8Oc6MQKqAL8bANBhT4XaulOH1egtqBM4HCAUykVcmzPHPzW0zGESKPHY9F?=
 =?us-ascii?Q?/KqbDr5XvsornuFc8C2o/A2bD77FgeOMwJpzOFUz5CtFT6Cheu7pqB6W9guf?=
 =?us-ascii?Q?YumGsOIqpG/FSoC8sUtVaUBU2WKBqQskGbZOPGertRxRTxsRxHuljchsaWc+?=
 =?us-ascii?Q?CRiei3FyoMVH2imBQjpGLi9j6C9jPzSxFEJa/I7zh2iS13kf8R7AlajW6jQp?=
 =?us-ascii?Q?WWW4kuofaldef6G+q2kXJ1wN/FxoQCnH5iACaR8yFfRm6TGtNN/Vu2iE9ks0?=
 =?us-ascii?Q?TVQu9nNl73aHcAsen2TMI6Hzb4Xx37W1vS/s3zBrkN3Tercr7of2YlTtXqXK?=
 =?us-ascii?Q?MzIg1TwTMXh1Cyj4Kk5zKDrcrvO5E2K0BLU+4SSRPGEH2VM+O/Uw1YL/AP8Q?=
 =?us-ascii?Q?QuF9HXF7Ev4VT4RR4Eq+QisO2aACzf5sw3vf56vhMpstXv4s2OgutoKWnQIr?=
 =?us-ascii?Q?sYRuwPzPfdZPmXN1yYMhpJCVpZWjjV/PxfEuRMVQuAFGKXVDnY7eC7OZ/3WF?=
 =?us-ascii?Q?S+mUI+Rn1i3uPIPJDjMnpDL6g4qCCodV2Oe5RgpsSfk4zPp61ON/6A0FfUXf?=
 =?us-ascii?Q?SeG7AoXImzbzDPQYlhwjsWmXFmohUjjqLDzIP8HxYfioha+F7+w2X+6DF4sP?=
 =?us-ascii?Q?9jsS3Q1o44enT2mLP+W4kN2pQTCIMWMcLrwXEFO5O5QgBTRUFg956/g8qKpJ?=
 =?us-ascii?Q?/wkev31mnZ7Y6P0=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2025 22:53:44.9821 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 009a42ea-8a47-42e7-7350-08dd552617a7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9065
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

From: Xiaogang Chen <xiaogang.chen@amd.com>

Since kfd uses pasid values from graphic driver now do not need use kfd pasid
fucntions.

Signed-off-by: Xiaogang Chen <xiaogang.chen@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/Makefile    |  1 -
 drivers/gpu/drm/amd/amdkfd/kfd_pasid.c | 46 --------------------------
 2 files changed, 47 deletions(-)
 delete mode 100644 drivers/gpu/drm/amd/amdkfd/kfd_pasid.c

diff --git a/drivers/gpu/drm/amd/amdkfd/Makefile b/drivers/gpu/drm/amd/amdkfd/Makefile
index 0d3d8972240d..0ce08113c9f0 100644
--- a/drivers/gpu/drm/amd/amdkfd/Makefile
+++ b/drivers/gpu/drm/amd/amdkfd/Makefile
@@ -27,7 +27,6 @@ AMDKFD_FILES	:= $(AMDKFD_PATH)/kfd_module.o \
 		$(AMDKFD_PATH)/kfd_device.o \
 		$(AMDKFD_PATH)/kfd_chardev.o \
 		$(AMDKFD_PATH)/kfd_topology.o \
-		$(AMDKFD_PATH)/kfd_pasid.o \
 		$(AMDKFD_PATH)/kfd_doorbell.o \
 		$(AMDKFD_PATH)/kfd_flat_memory.o \
 		$(AMDKFD_PATH)/kfd_process.o \
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_pasid.c b/drivers/gpu/drm/amd/amdkfd/kfd_pasid.c
deleted file mode 100644
index 8896426e0556..000000000000
--- a/drivers/gpu/drm/amd/amdkfd/kfd_pasid.c
+++ /dev/null
@@ -1,46 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0 OR MIT
-/*
- * Copyright 2014-2022 Advanced Micro Devices, Inc.
- *
- * Permission is hereby granted, free of charge, to any person obtaining a
- * copy of this software and associated documentation files (the "Software"),
- * to deal in the Software without restriction, including without limitation
- * the rights to use, copy, modify, merge, publish, distribute, sublicense,
- * and/or sell copies of the Software, and to permit persons to whom the
- * Software is furnished to do so, subject to the following conditions:
- *
- * The above copyright notice and this permission notice shall be included in
- * all copies or substantial portions of the Software.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
- * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
- * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
- * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
- * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
- * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
- * OTHER DEALINGS IN THE SOFTWARE.
- */
-
-#include <linux/types.h>
-#include "kfd_priv.h"
-#include "amdgpu_ids.h"
-
-static unsigned int pasid_bits = 16;
-static bool pasids_allocated; /* = false */
-
-u32 kfd_pasid_alloc(void)
-{
-	int r = amdgpu_pasid_alloc(pasid_bits);
-
-	if (r > 0) {
-		pasids_allocated = true;
-		return r;
-	}
-
-	return 0;
-}
-
-void kfd_pasid_free(u32 pasid)
-{
-	amdgpu_pasid_free(pasid);
-}
-- 
2.25.1

