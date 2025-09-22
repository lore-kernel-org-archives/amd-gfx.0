Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AA04CAC59A
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Sep 2025 02:39:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 967DB10E08C;
	Mon, 22 Sep 2025 02:39:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2AQPq0Z2";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011012.outbound.protection.outlook.com [52.101.62.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 18A7B10E08C
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Sep 2025 02:39:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LJSKNTy13uVzAUaI+La1wY0E8zIgRu++Cd/1K+cjB3vDi7TNvw34w4HoeA4LLi8mzQTKHW1e6ajHGtPQb1T08yQEEcdPTLugRugdcAkxguDiwhvVBhouVVX9aFUf0nkWqgtdBLpu7MzD40Fx5nGdpsdRP/Mr6zg4gYeXQNiW8Z9VJ6m4AaJQrxCF39LXMsij1SL2DAteTGNWZwISE8wOA5ekb6wC3A9Iv/toR5mNXUTcNyBqPSL05Gw1yQdWu62hVCj9Oh5RgcDwROoE8hhkQrLRheki2fFStzOHOfdjUI5MMn5+sHkTM8gY5WdyI8mtMx43kovEPiaJ+WlzHEJW+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/FbeFbGC0jdkJMgb3afxMJEx6Todu7W/WNOEUuaiZ1Y=;
 b=EsvMZvjPBGggMLSevu25QYRFxpAdc/bmZnCGID147WuaWj0NLNX2uleFFhI5swHXUxMHF3dnn4Q1MyNZ5RGklF1XK/DIJN2hyBH8y7z1IZee28BcPaNyCNynI9R9i3MSk0jkQSJFpKbLWF+TKLxkrgIjDrx3lRkwCqf9y9C8dcrAWbitGzSDpO8obTYjWj/dUJ3QH0jsZh+6/7q/KqnQ+XA1JSX8qBCbKSkVxEEgBJUJ+f4DNLFcBGIlo9gsf5KmZ6CJpwSEfQNbR5kSBt8HoON7MNgx3gQgd5aBfQytGblX104/onm3LIr1mJ53zNLbgFqOhOL6XjOZwI7AYZg2Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/FbeFbGC0jdkJMgb3afxMJEx6Todu7W/WNOEUuaiZ1Y=;
 b=2AQPq0Z2erWvmlh4rJebmXeWdt5dXZDN9+4ArGBLbggXo43kQdEU3OTdDzCCnjBP0KZEA4RkRsTYt8unpwvW8LnxOOwPLUQfCpipy5xD8M6LHPnFdmguHGeP8kTmsXTVkAEJ7tQibIF4+l6jMgzs82SsHQeFLj+kSXoHSZGUTKY=
Received: from BYAPR08CA0008.namprd08.prod.outlook.com (2603:10b6:a03:100::21)
 by LV3PR12MB9185.namprd12.prod.outlook.com (2603:10b6:408:199::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Mon, 22 Sep
 2025 02:39:23 +0000
Received: from CO1PEPF000044FC.namprd21.prod.outlook.com
 (2603:10b6:a03:100:cafe::2d) by BYAPR08CA0008.outlook.office365.com
 (2603:10b6:a03:100::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.20 via Frontend Transport; Mon,
 22 Sep 2025 02:39:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000044FC.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9182.0 via Frontend Transport; Mon, 22 Sep 2025 02:39:23 +0000
Received: from amd-02.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sun, 21 Sep
 2025 19:39:20 -0700
From: YiPeng Chai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <yipechai@amd.com>, <Hawking.Zhang@amd.com>, <Tao.Zhou1@amd.com>,
 <Stanley.Yang@amd.com>, YiPeng Chai <YiPeng.Chai@amd.com>, Tao Zhou
 <tao.zhou1@amd.com>
Subject: [PATCH V5 01/20] drm/amd/ras: Add rascore status definition
Date: Mon, 22 Sep 2025 10:38:25 +0800
Message-ID: <20250922023844.3108065-1-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FC:EE_|LV3PR12MB9185:EE_
X-MS-Office365-Filtering-Correlation-Id: d9da9201-f33f-47b9-5afb-08ddf9813d70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+5kDyK8pz4iVBWlfxy2OQo2N+RVyZ/+hHxE+1Pg1WIsRxLL1nbl5mZNRpp2/?=
 =?us-ascii?Q?VC0tpQUBTs0n924D5nBpZP3XJVlQNaYM+rU/anZfauOkqCMp65qq35PdPeBv?=
 =?us-ascii?Q?bxDt/agV4EJPl4A+61mVQI5syKM8AaCsYAlel03XaDIxgGt4lFqkj91Juk5c?=
 =?us-ascii?Q?BrJKBpUdHyzuOGINKevS008wAy7Q1KkOAakgzw4jVZX0hNfCuT5l4RetWVTU?=
 =?us-ascii?Q?O5RTN1rkgiaCXmXZBJQhm6Bc82Js4y2YvwsJHdyVkOghg7iITeEHsMShnwiH?=
 =?us-ascii?Q?/7km/UxuACLRc2F92Dn6CuhzCNGjcpFHPj7ZeULsq4Nd0zh+EW4jzuP/Q9Zo?=
 =?us-ascii?Q?7RW/Y5SoUqrWbxZls08y9cNuu6NV09YQN7iPcogr1Pu2xfvMPfy5kY0MAQfW?=
 =?us-ascii?Q?KEOEKks7/A3tI4jHu/BkBYdSkA3vnh2LJcsSB6v0NMJaXgzji0IB1P3Th7/c?=
 =?us-ascii?Q?SWqNIqtSVzh0xUr9VVXBdV9dZvWV1qJaIogC+XIIu1Sl2n/RWgccAJXbVd4C?=
 =?us-ascii?Q?hhdohfr2v3Q/frMaHEOb0vBMsj36BnhvJSHaYGYGboQtvj6XfZZFEJpB+VFC?=
 =?us-ascii?Q?wUCWlg8NmsBPzFBgFCXw1iguq141o9Ty7Zkr7dogvPKgICs6K0uvHfX18K20?=
 =?us-ascii?Q?F4vSYTOogyTf2dqShuY6mPxH7M8rGk+fiXaZVUPvr1BNW4iIm7cmZlRQNUBa?=
 =?us-ascii?Q?VHq10OIXcX5O2+dlt0hBMkx7eBe5Cn7BK4o8UaqbXPOp2CmDTLSMn1m/37gb?=
 =?us-ascii?Q?7zhlQq3W6taZQkthlYRXGLTDuoS6JP8IAJEm17V10u4mC83So+zPT39qwzc6?=
 =?us-ascii?Q?1V2RiFkdO8xDDUXDuD78l4elmcdU0r5qzo7YmX+XzzdxLvNQnApU4L73Yc5H?=
 =?us-ascii?Q?AMDtqKaw64YaRyCrLR8UF4+fWL1e1HoHqSGG1ih6WuEfSgpqu3l4Ww2KZAIV?=
 =?us-ascii?Q?YnlEv8/tk0HdCtwSewoM0a8vYCoik71QztvW5DmuPM6BgmmK3wXuyRtEcrRh?=
 =?us-ascii?Q?+50jYqApbqXm2GnwxTWiy3Er/xSr6FETKugcCNedE+KUeHbQ3NZz73oX9cmU?=
 =?us-ascii?Q?c0lXqPkyypfKVaCnBoVMNzsHXykkn9qgMHmp3VHGyEqrLKL10hZuz/C1Zp2G?=
 =?us-ascii?Q?U9svxXJ+zkSkXKyPDPDenkvHiI9m4HgPhj8laqkAJ+B77RQNZQGVPawdEP7d?=
 =?us-ascii?Q?vCzC2puyFOWeIUT+Pc/BKkzhCkonKSrtBerZ9ICV31SVbJhH07etEm4yhJEF?=
 =?us-ascii?Q?VbYvbjI3NFdi095eIEBZ5mIScbd1SLJqDSPq1+q6eUzn+jIlpI5YWDFlLjZH?=
 =?us-ascii?Q?j1SvDSK8yEFM2+yRJ/22vFw3dwatMi6LIMPZtP6tQu1f4Baj8YYDu93dIfI1?=
 =?us-ascii?Q?OOCdt3yqNkJc8IJxqxK5q+Ctsq370c26UmwQiVh6WFGxQpcNp9Ez/na/vULm?=
 =?us-ascii?Q?FeUeVHB6xRFPFqJurL+P/rBO8mjjvYayzXmkSaadLFfAzCfemx6Rns7t+OGj?=
 =?us-ascii?Q?hsygCSlA55Vzg/EWJGSqCRz/4O56LU88lZwG?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2025 02:39:23.2012 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d9da9201-f33f-47b9-5afb-08ddf9813d70
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044FC.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9185
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

Add rascore status definition.

V5:
  Merge the previous empty files.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/ras/rascore/Makefile      |  0
 .../gpu/drm/amd/ras/rascore/ras_core_status.h | 37 +++++++++++++++++++
 2 files changed, 37 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/ras/rascore/Makefile
 create mode 100644 drivers/gpu/drm/amd/ras/rascore/ras_core_status.h

diff --git a/drivers/gpu/drm/amd/ras/rascore/Makefile b/drivers/gpu/drm/amd/ras/rascore/Makefile
new file mode 100644
index 000000000000..e69de29bb2d1
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_core_status.h b/drivers/gpu/drm/amd/ras/rascore/ras_core_status.h
new file mode 100644
index 000000000000..144fbe4ceb9a
--- /dev/null
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_core_status.h
@@ -0,0 +1,37 @@
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
+#ifndef __RAS_CORE_STATUS_H__
+#define __RAS_CORE_STATUS_H__
+
+#define RAS_CORE_OK                       0
+#define RAS_CORE_NOT_SUPPORTED            248
+#define RAS_CORE_FAIL_ERROR_QUERY         249
+#define RAS_CORE_FAIL_ERROR_INJECTION     250
+#define RAS_CORE_FAIL_FATAL_RECOVERY      251
+#define RAS_CORE_FAIL_POISON_CONSUMPTION  252
+#define RAS_CORE_FAIL_POISON_CREATION     253
+#define RAS_CORE_FAIL_NO_VALID_BANKS      254
+#define RAS_CORE_GPU_IN_MODE1_RESET       255
+#endif
-- 
2.34.1

