Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A840CAC59A
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Sep 2025 01:37:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4452310E629;
	Thu, 18 Sep 2025 01:37:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="X9IkplOr";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011038.outbound.protection.outlook.com [52.101.57.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E898B10E629
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Sep 2025 01:37:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E/NJ49nPLuoX5arV/IsU4NSHdcyMCJXR289tMiQWdfm2quEVBzByMGX/lfLEb4Psxb0ybImwrU2LpEBlw7+0k0ORPaMm9FYdu6suoHF7E+oix9sUtnrKXBofurO78ACIIMj/kdW45iOK+lqHHU6fslfgFgzF68ezfAEhJAbAEzAo8iAlpqv4dFW/AFyFoCgzB/GNSdFLDrz1vWvTgCrf34qhkjZZdEkwMGr50Kue4ajJieDAZQ4bSoqcmTt95l7XjWH6H0BIytKyAbRZdu3+CABmdZIMQOK8Qs7mOZlhzMMvhASTHFl1x0ZhLtmPOH4uFN7sfUGy9TBXlZVIi4ting==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f8Zk8gj2O00fjVUzKbUMPfbAhZZ3V1xMN89SDHLvfOg=;
 b=qOXMUEpOegawd0oGWxBDt3BATIL8uFGGqDkiP8z+BU8ir+YRuxpT26gnDcJW8IaygggIA3AjAoBpa6UYfZhzD7htonrGC+8nu52+Kmj+RYP8oc5DKIcfp3bk0Vsgslpzw7oVu8OJ2sxGGFStAR0pb4te6uvuMyi45Eo3MqTcAzjKx+8fiNRLRDWrJ0IYYG7iEp31D8ACbp/Ce3afrkY5XfAuUyZsv1pVsgAAMJufq6V7pb0F41YkXTqW5PnZhZ5qwtl4nIUG2NfVEscylZOhlY37jna3a4yEPnCPp9pxa64tnlwnkzHuaxWsCwXO3aYvV19VP47SrgZIQDZpVjyibA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f8Zk8gj2O00fjVUzKbUMPfbAhZZ3V1xMN89SDHLvfOg=;
 b=X9IkplOrDXe64XPfTxdlGWKlEWKULWThrssigi6fNnTdgw6aEx0e6X1fOro+jyBI4rW4Nlhp42uZYLqE1RmqrecmGtJhaHULao7n3AOfBY88b3YOXnmcUxWrjoZmajr15OrEZtRopVdruMrx1+IUSbR1XVXyQsXojSG4g42IwSo=
Received: from SN6PR2101CA0019.namprd21.prod.outlook.com
 (2603:10b6:805:106::29) by MN2PR12MB4127.namprd12.prod.outlook.com
 (2603:10b6:208:1d1::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.14; Thu, 18 Sep
 2025 01:37:05 +0000
Received: from SA2PEPF00001509.namprd04.prod.outlook.com
 (2603:10b6:805:106:cafe::90) by SN6PR2101CA0019.outlook.office365.com
 (2603:10b6:805:106::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.2 via Frontend Transport; Thu,
 18 Sep 2025 01:37:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00001509.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Thu, 18 Sep 2025 01:37:05 +0000
Received: from amd-02.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 17 Sep
 2025 18:37:00 -0700
From: YiPeng Chai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Tao.Zhou1@amd.com>, <Candice.Li@amd.com>,
 <Stanley.Yang@amd.com>, YiPeng Chai <YiPeng.Chai@amd.com>, Tao Zhou
 <tao.zhou1@amd.com>
Subject: [PATCH 10/10] drm/amd/ras: Add unified ras module top-level makefile
Date: Thu, 18 Sep 2025 09:35:07 +0800
Message-ID: <20250918013507.2629620-10-YiPeng.Chai@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00001509:EE_|MN2PR12MB4127:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f19661a-5831-4ea7-aa28-08ddf653df9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?bOe0OhB6TtKKNT33I7jIe0oIQTisGC1E7yFhJJnOWS3tzgxOuVoI1XCMvEEh?=
 =?us-ascii?Q?kYI9PIScIKuOQ/vePwgrGmx7C60CmZ/8tBEvYdT5X2KyS9ubpp1TNgVetaOb?=
 =?us-ascii?Q?o4XbS+ruggLuM66X7WPkPRE1/8CfuRzI15HZhi+xhRE39PrRrZsH33ZVPADE?=
 =?us-ascii?Q?6j3CHSlZd3boqg1n/yInMTmXNYJ7uLHC/f1MryTmN0kTmc8VKVD04/uM7nbQ?=
 =?us-ascii?Q?rtAVdsdDQ61JzvqkCzDLifJdqQKIzrUGlfCNZdjSsd1HSPkW80cCoG4gjvlf?=
 =?us-ascii?Q?0Qwz3iCDC3QLFiVUIwOhBirJ68bHpJrGqDAt6QWQNO4kGmFGR4aCu1ZZeeF7?=
 =?us-ascii?Q?L8HKOdSpvunI8VBKPBi36zEi3MrX7JriQ7pLAgO8qHGOkL1LPzcw/V0h4uAo?=
 =?us-ascii?Q?W9MzA4xRmNiZNQvfhldUbWo/0bVPfb8z7I2YryzKN3CS0qrnGgQt9yYrqPje?=
 =?us-ascii?Q?NKGiioRVnmf6od6K5L5l7T4c4ItUBDEqDMBUKoVCwu662oYgSGAgUxCAhBjg?=
 =?us-ascii?Q?RYQFzSXlWUzywxXSChSGPoLsN+IMV1bdmmllI/+q/R/meyPAGMUZniILZKHd?=
 =?us-ascii?Q?uSjafQZ/Tdek06azqNHBoVvSVTgbMRQuQ0yY8XM4w8y6vsO7DDfwDONiXBw4?=
 =?us-ascii?Q?04cEjz6q0T2UpxCg6Dkw+iv9rECyQDM5YMf8DYjdymzlo++FjW9q4EslI/qk?=
 =?us-ascii?Q?M6OncQGfztAJLKz8jdLtXbeyGBatRT8DJNmdxuvDECPbzQzAiLIs5Q+6euLE?=
 =?us-ascii?Q?kHpGzns7C1tgkHcyj5jG0GUVpL3Jgq/cLjRa9KxmN9ow/2KoPacGedWsUujW?=
 =?us-ascii?Q?kMATVbor74IgMwUIDid287+3iH2ukbWvdKwZrgrvZlpCeAr0sbM64LnT/skr?=
 =?us-ascii?Q?8pZXAJCHund0RFLK3aCuZvsWpygk0FOhsF2Z0WeGcDBE4E7dWaeDnzevWKiN?=
 =?us-ascii?Q?fZc8jC6l+a0UyIOc+rwUsRpZL7Lbmn6SjxtXqC6tBvxtci0NRCgOkftdnKiT?=
 =?us-ascii?Q?04CnDLiIlM2tjSPSagQOfSXSAMVhWCT5+W6CUe3dJ0U1JQBRPzAFVnGQHt86?=
 =?us-ascii?Q?jz+asQlGRVxr+fK0fRuxay96YtbT1cD9sVQ5fZ6hiV8RDYCbMlrwaJsnAR2f?=
 =?us-ascii?Q?aO8T4ttKScoYWg6p7PuMzHVrTtXhiOw/GyBwoe8tZYy9cJgj5main3GsrCGL?=
 =?us-ascii?Q?2z+V/eYbX7IhpfXYD0dVotGc2KjA1Pe0GkBOM4wS1saPaaIwPjINJr94VSQy?=
 =?us-ascii?Q?lUGBgbm0rsNJCRTX6vKfnKpXwbm9w0jilSeGGD50K7xLqAR+9P7DDb8kcCty?=
 =?us-ascii?Q?zWcrMdXrD9/5Pqd2GZumEv9WuL8x8qU6pIEXAScGyUuuPkZkqba866i7El6u?=
 =?us-ascii?Q?JK37P+Q27jg5atjNZIA/WG/P3UgeLJbiQvd6Gq963AXRmRFDPofrFGSm0ExI?=
 =?us-ascii?Q?BqMKsFG7JvDX2J9efj8VFNYZ7QvXOQ7e8UCYYpEuJDabbcnHZJ3VREMFD5eL?=
 =?us-ascii?Q?CTT0kEXk5nZAEpd273CsmQ6NwXO2nrsqanKI?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 01:37:05.0258 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f19661a-5831-4ea7-aa28-08ddf653df9e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001509.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4127
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

Add unified ras module top-level makefile.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/ras/Makefile | 34 ++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/ras/Makefile

diff --git a/drivers/gpu/drm/amd/ras/Makefile b/drivers/gpu/drm/amd/ras/Makefile
new file mode 100644
index 000000000000..bbdaba811d34
--- /dev/null
+++ b/drivers/gpu/drm/amd/ras/Makefile
@@ -0,0 +1,34 @@
+#
+# Copyright (c) 2025 Advanced Micro Devices, Inc. All rights reserved.
+#
+# Permission is hereby granted, free of charge, to any person obtaining a copy
+# of this software and associated documentation files (the "Software"), to deal
+# in the Software without restriction, including without limitation the rights
+# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+# copies of the Software, and to permit persons to whom the Software is
+# furnished to do so, subject to the following conditions:
+#
+# The above copyright notice and this permission notice shall be included in
+# all copies or substantial portions of the Software.
+#
+# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL THE
+# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+# THE SOFTWARE.
+
+ifeq ($(AMD_GPU_RAS_MGR),)
+	AMD_GPU_RAS_MGR := ras_mgr
+endif
+
+subdir-ccflags-y += -I$(AMD_GPU_RAS_FULL_PATH)/rascore
+subdir-ccflags-y += -I$(AMD_GPU_RAS_FULL_PATH)/$(AMD_GPU_RAS_MGR)
+
+RAS_LIBS = $(AMD_GPU_RAS_MGR) rascore
+
+AMD_RAS = $(addsuffix /Makefile, $(addprefix $(AMD_GPU_RAS_FULL_PATH)/,$(RAS_LIBS)))
+
+include $(AMD_RAS)
+
-- 
2.34.1

