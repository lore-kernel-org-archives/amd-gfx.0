Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D649CAC59A
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Sep 2025 01:33:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3548510E5D8;
	Thu, 18 Sep 2025 01:33:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VAkPiTCN";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010020.outbound.protection.outlook.com [52.101.85.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 859A210E1D9
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Sep 2025 01:33:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R+sP2Smw8PxJ3xWNBsCBgPeJgH6Cad/A++4NlkxZzPyqAfiw9Bn02n5YvHWDpyKIS5hbhAH2vF8f91VCWRwgpyv/iyYQDY0Cb6W46UMEkEpy7KDrh0x86A61DbAaPJMPjD/32qq11Y6qdcQ93rafY1bLcTLvdpRTTlK11WjGhzjjtdvuXsmk9TOTISie6+QPAdCMEya8vJglkgGr0mjFVoQKK3N72fQtYTS3Gdac75p+akjnDNYLx9PyzxveEvojI3dzpp2Sr4Ojq1YwjLPbD5fvwbqTiumlwimotatWXjn/JOWVPub0D6jtMrmMJo2ZudVsYCwvOdLiE58LvmAqgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j+rPUaJ04TiSE4td0HJ83oirUjc2L7+/4xX3WatSosg=;
 b=MGDn9IVRN1fcGJ/7sdbh7ZQBp54GdNhwcMQs8dfpdS3/FxrQ240/eiLdhXAbK8nQhXJrShQ8oVfTNYR4GboxlzwnCjA2slVcv1145UzO0RWjBEvoXgFkBvuZjqci8reat8EQugjdlTEPBbG+mf3JnVlT2/Ul2JgbLWqFPv0CUzz/e2j0/rYjz7EP4ux+uTwtltPAJosUu455Q1zsQT6pJ6YmjfZffML7SF2DUHfgmy+UC2eAPhdewfPY3Y1BxrENvVx+RHqLTvtBMoDMatQ9sLRhm1sBgUPPvkQ05RAroowXG/38XZvpPxZ/9PGr0AHXRunfqL5XoeKCh/xOUnaBIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j+rPUaJ04TiSE4td0HJ83oirUjc2L7+/4xX3WatSosg=;
 b=VAkPiTCN9+LBRp4Oc6p1iFJI3/O2rq/2z1MbGayxWKg9hnGMbmEV09eLS2YtFCfcoxEGI5opgbt/RwVZdK1YWoqiMqKJC+BQ2poATe8oQlhkLNsYqFl7sepACqDu+GtZ3hfehFyx2FrZ+2ofUk6USY3No5Q7rGPXIFOUeXY1MNI=
Received: from MW2PR2101CA0015.namprd21.prod.outlook.com (2603:10b6:302:1::28)
 by DS0PR12MB8574.namprd12.prod.outlook.com (2603:10b6:8:166::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Thu, 18 Sep
 2025 01:33:10 +0000
Received: from CO1PEPF000044F0.namprd05.prod.outlook.com
 (2603:10b6:302:1:cafe::7a) by MW2PR2101CA0015.outlook.office365.com
 (2603:10b6:302:1::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.3 via Frontend Transport; Thu,
 18 Sep 2025 01:33:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000044F0.mail.protection.outlook.com (10.167.241.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Thu, 18 Sep 2025 01:33:08 +0000
Received: from amd-02.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 17 Sep
 2025 18:33:06 -0700
From: YiPeng Chai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Tao.Zhou1@amd.com>, <Candice.Li@amd.com>,
 <Stanley.Yang@amd.com>, YiPeng Chai <YiPeng.Chai@amd.com>, Tao Zhou
 <tao.zhou1@amd.com>
Subject: [PATCH 02/21] drm/amd/ras: Add rascore status definition
Date: Thu, 18 Sep 2025 09:32:13 +0800
Message-ID: <20250918013232.2629215-2-YiPeng.Chai@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F0:EE_|DS0PR12MB8574:EE_
X-MS-Office365-Filtering-Correlation-Id: 41b4f44b-acbe-4ab5-fbd0-08ddf65352f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?zxGnRt4NNfkAILH0Pu2p+4FP2vvOzUYnkZIqiUTAaB0WXUk9uXfMrZmDNxkn?=
 =?us-ascii?Q?ofLNwtuVCmDdR1qf+WTDgiULpCehBtACqIt/z0R8ALijqiO+FDH0D7JtHzo6?=
 =?us-ascii?Q?HYONsifHBdwMZlkA+qqN/rloQNY6tBZjXR+p1VffxnG1JkmPkTe9KsFZVLOR?=
 =?us-ascii?Q?BoDMqyTsjRbBmPyFZpXnF6Uu9yfiWZDj3yCWRrMhe048cTGV2mkCyuC9b5aK?=
 =?us-ascii?Q?9BkFNZ3pSX514v15z2peEVoXYMMe09XLvYIeJhy+afISBKiEMEPyf1RyfMZH?=
 =?us-ascii?Q?dqWPCSb4IdetcS4vqpsfg8XfRjfR6iLDwBFF8hU1vXF54XahD1Q261gTnLHa?=
 =?us-ascii?Q?/gB7xyIt7UjZFOFPQoPvh9r0PGcMELDLsEGyxYraVm31DyztS9Fe13oTPYaC?=
 =?us-ascii?Q?yZreiUgd0aWZ7M6uvplOaU3VHY/6z1C/wnRh99Oo0cWNN4jILCN0Qo6rJzq1?=
 =?us-ascii?Q?wQ4W2iVtW594KMcAzDsNpWYI10YkoygAzqUKm5O0kuAc+L1vVHjZsA42KR64?=
 =?us-ascii?Q?HaJMsYT6aLReyrCmikSQRcqQs9Is46rpr+ZOQOirOVhMPhh1yDg93z11bmh7?=
 =?us-ascii?Q?lZH+zQfxb0CfTeKwoyCAYifzavoHY2yUsdIEs5X1uq5XkSWk3B+rUNr0SAC9?=
 =?us-ascii?Q?uP+40tkbHi8S0W69b+JuSOjMO9KWB6WtpfG1TRVJU31b6tJ/ktxHNT4VgLpJ?=
 =?us-ascii?Q?Ap8KRbJSNrt+7K0GNWC0i46v9A63iT3opvAJAnAsjWsO4Fer7mTb7lejoGvT?=
 =?us-ascii?Q?jmB6CkKJyIh0X4yBKSdvfvqduMQRKRvpFgZlkAtp5JeV7z80slJkhK534iXS?=
 =?us-ascii?Q?BS3BZTu+5EfiI69O+e2ZOJcJ45VoQlGJdtt8p1FB2afhKIsgxiv/vjAfihE0?=
 =?us-ascii?Q?GuldyAvLk6sa7FTPZEN8HPSo4zfdpX49j4bUPEvVCf4dumt1Uh3Sz1DPuoWa?=
 =?us-ascii?Q?OCbT4dFb+BLSrHEmtOwq9RXFcADgSdk/nIexvM+I305MCIqnJkWOHkA7H3gR?=
 =?us-ascii?Q?Htjw5pbiilJzDqhk0QXAcr0ratmOyuAP4IZvYn2vsriS/aXgUPDu+mjYjvKv?=
 =?us-ascii?Q?vscmAfPbljE1EKC2mM9ym120f2kZZr11x461q6y8T9iTA/mqYbKF9WN3f/G0?=
 =?us-ascii?Q?y68emjbO5kz8r+uTZ1qr7c6jFgrdHsI8e95sh638zzSPid3XvGNQK4HZgmA+?=
 =?us-ascii?Q?IFFvN1nVm56hejjLoHOSdwGQK8c0x60dwtQuarlcuC8MwHqkH+0839/sDBDQ?=
 =?us-ascii?Q?Z3KVOjct4N8oeOKy6kjSK4O+cgN/vFq76FbN9qeIm5GxIZbN1ver725euG76?=
 =?us-ascii?Q?zkH+Z8XhbzqI8DL3AdVUjb6fODvB7tz8TRwoLKlgqLFQ4gREs6dnpVojFYUk?=
 =?us-ascii?Q?ivcsWw96sZGXALPkl0G59w1ULs21S6fXmQgxgd8HAFVQ8VJkRU0xqoZ9czc0?=
 =?us-ascii?Q?+b8UpYZ1HwWlZD6QkKa/Rto0/TwzRkeVADROnMpPKK1AxcKnn6NoxK60ipCK?=
 =?us-ascii?Q?e3RbY14l8qhNHRF4P0GjR3Ert7EK19BCBta9?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 01:33:08.9512 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 41b4f44b-acbe-4ab5-fbd0-08ddf65352f2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8574
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

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
---
 .../gpu/drm/amd/ras/rascore/ras_core_status.h | 37 +++++++++++++++++++
 1 file changed, 37 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/ras/rascore/ras_core_status.h

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

