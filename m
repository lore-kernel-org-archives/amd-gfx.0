Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71F18E7716E
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Dec 2024 17:36:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E79A10E011;
	Thu,  5 Dec 2024 17:36:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AwrHg3x6";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2079.outbound.protection.outlook.com [40.107.244.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 41F4210E011
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Dec 2024 17:36:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O4yYXkGTBazNWeY/v5TvUQOjUeR7k7cipKWLVWR4gL0Z9y5ykqpf4XoMaBtp8xRKgIq+dLbMrIr7MWHKzV3zkmNtC1/Njy7wOg2jqrB+7CkAdpO5K5I+Q6FYLYIzaTfmYVL/TF1PHp3DLF4+BCW3XEPbg+zNsIgY1W8nKEoV1ZJvEJDOcxPEHlCtNG3i0qZelOb45PGnrx/GCqoocUOSbrBQhle377PHLRpZcH7IMPu5+Eh19rb6UZPRXExgvUbvO6/AaIqAMmR0E3tmooalnP+b+SQPvAYONiQtPn0kzn5oOSD6ADOF7R3yOX3P5liXm1kifenjoHEqZp+mpSw/HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Iw+98apAUYSafQgY4J1RoLCKFBc5mwCoSnJUn+3Nk08=;
 b=dD1fHidJ1l9pBX2d/X1FIt7y1OrT3MFPpdybC1Ga4AGzUW4buk5HZlUAXebycgE4hhTmVkWgN7/Km9o3Vch9TIvEXxdxt5DarDjTcmAkFnZKRW969iFPcXpy/gwcYIMEhx3S6NOhjFPywwB6fCGrYXSRoI9nA0AXs/0OMn+eVQ03UHOTdZxfGLt0EHyDmHuZp5C+xs6x7ooEwPPPi4AkbzhR9xXzRsaKyueocpR3pQc8dhL3XxS0Qax4NKTmmO+a6tQ7mY7yuk7PgVnXZtjjMHg296x7yMRRLAilFocfUxWm075H4i7+mSVMoRJlAwLlBnxSPCu/jFJALtwcj7hiXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Iw+98apAUYSafQgY4J1RoLCKFBc5mwCoSnJUn+3Nk08=;
 b=AwrHg3x6FQM173lPczlcNQGoVIGnHJo91vvNoa9RNjZ6o144iBM2pNzDWvWPkUHuFRzhDok7HDUldU8pPdgcoUiFg0HhiX9+qQfqvl2xHK5nRWyn01+3ZCUI6vG9D2dskykG8UyyPSS5+lDnsMOyHI6K1lU85vOGEPIcJpo+vAA=
Received: from BN9PR03CA0455.namprd03.prod.outlook.com (2603:10b6:408:139::10)
 by IA0PR12MB7674.namprd12.prod.outlook.com (2603:10b6:208:434::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Thu, 5 Dec
 2024 17:36:24 +0000
Received: from BL02EPF00021F6C.namprd02.prod.outlook.com
 (2603:10b6:408:139:cafe::62) by BN9PR03CA0455.outlook.office365.com
 (2603:10b6:408:139::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.11 via Frontend Transport; Thu,
 5 Dec 2024 17:36:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00021F6C.mail.protection.outlook.com (10.167.249.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Thu, 5 Dec 2024 17:36:24 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 5 Dec
 2024 11:36:23 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Sathishkumar S <sathishkumar.sundararaju@amd.com>, Leo Liu
 <leo.liu@amd.com>, Sonny Jiang <sonjiang@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH 01/10] drm/amdgpu: add irq source ids for VCN5_0/JPEG5_0
Date: Thu, 5 Dec 2024 12:36:01 -0500
Message-ID: <20241205173610.334358-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6C:EE_|IA0PR12MB7674:EE_
X-MS-Office365-Filtering-Correlation-Id: 1cba1015-200d-4cba-351b-08dd1553574a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?coQ0C3wa1LRSK6vlcHUMsEXZ0kpi0j4WBjibBrFGIHHfEy15ZwUvsIqVFEOc?=
 =?us-ascii?Q?hkcfM99/zJQDaqZJcDtzvWhSb3+zvG28x8WGabw/SBb0H85XGi6Z+/3K0nUC?=
 =?us-ascii?Q?oIUKqlin4oNwG5C4jwNVOteJu1imN7yVy0kZ4Jy4ipbLXmI86WCH7hKb5XVL?=
 =?us-ascii?Q?/+XnnfkuLZxF95ViYGrzG3Aoxfjf88ZT+bZO2CcfRYWqyZi3+Ml/s+MPBMGl?=
 =?us-ascii?Q?aDXhxA/ZBECPyMDz8guD+baXcRJazMUOT4ezKS3KvjGMg5+BXSZr2fKDcTb6?=
 =?us-ascii?Q?q3wxelcvpSakew6BoMKGX+QWwaodjhhAzUDBO7EIpH065DJVudRY8MPd/B2Z?=
 =?us-ascii?Q?bqbp+yAY1wUAn/bbtxD3TzO/IFOFqg4zCZ/axKb0RmCm/nArESlNe0MsFGMl?=
 =?us-ascii?Q?y0JAWkk7+F5BG7l0KyX3ezSPpxpzqJ1jGbgHoBKFtcqHuU0K9oOQvsoeWPzK?=
 =?us-ascii?Q?J7qvOCV3XRZoLMGBQ5cEla3Laufhu5y+Xywv1Hqer1kfQIj/Pf/Hs/uj9hJC?=
 =?us-ascii?Q?85DD1mumWTD0lmnM5QX8mFmX0XigPKAFWkqpJxlEfXwNJp2Eqg1e+RE2BT9F?=
 =?us-ascii?Q?vGFWG8VsvdWCdN18OOQVMGFipzr8jV2D/R532VoPa/lxCKwRk/CWdW+xdsDn?=
 =?us-ascii?Q?hg3DKL5bktlFIQA6RW3YU5d9xtDxDLZ6Q9gSjcsf8cwvQZlDg7JCjQK8/rIj?=
 =?us-ascii?Q?cq2AsN9HefI15n3Pup53UHGoVWwyrnKU7Ukach2Z7C2JK3/9jmKYYzO2w6eX?=
 =?us-ascii?Q?/qED170nMErTP8MGeH3bAnqZt8+XkfOigC0dQ5r8br2V7wMYShCJk9wzpM69?=
 =?us-ascii?Q?aeWAZe5zaey3WNVs6zgVuIzCf1hrOaC5i5PT8TfhJ4mw7Hl+6FB55a4qTHcm?=
 =?us-ascii?Q?32O/ZVzk/MkX21LkudorcfSUd7NwFNCdYdr0FqHnuwrEMwoAB2Kv69IfQai4?=
 =?us-ascii?Q?crcPYLuO1rhfRkVr5M36ml3hNyIKuv3icr1I7sHwg6p7FJAfM+isR1f0GiEx?=
 =?us-ascii?Q?5M0ylRwBzUKIBWdOoJAgKtuFv7ojvQ5TQeJh23luA1VhVQ1z3TaJk4vbyQPh?=
 =?us-ascii?Q?rb3FkwrYC1kwqNn8oRP2xTjsikWBH6Re3voSviIUSyRLJUfYxhWNb4YSbaVk?=
 =?us-ascii?Q?b9H9E6blzWeCvmR/K5CsaSidfH7qpO0+O5eMh1/+wn6I06Ud6jMzLxfI2WvA?=
 =?us-ascii?Q?LkR6xtSdXGTFPAVsadhUjhIDEQgyE1HgZBjysne8d1Gbhx2tnyp1NihvDEqt?=
 =?us-ascii?Q?CWtg3/hMs0CmFRhPdWhGxsWl1ZpjcdRobTY8UzbNPEVEf/qSNrZLK4QAJgNc?=
 =?us-ascii?Q?e8PoCIpjajy2Ohfrf5kj4CE22O2FE4REyy2J/6DmdknwiI55cNlR3LVBmI3/?=
 =?us-ascii?Q?AoQn80saVjScdZVVPW1UVG1wCCFqLTRtMwj+Filk/RlCvUOZ5dwxWyx3jfik?=
 =?us-ascii?Q?WikThPfRvOWyRx/XmHynlSB9MCcgVGjE?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2024 17:36:24.6803 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cba1015-200d-4cba-351b-08dd1553574a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F6C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7674
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

From: Sathishkumar S <sathishkumar.sundararaju@amd.com>

Add interrupt source id macros for VCN5 and JPEG5

V2: Update copyright year (Sonny)

Signed-off-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
Acked-by: Leo Liu <leo.liu@amd.com>
Reviewed-by: Sonny Jiang <sonjiang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../amd/include/ivsrcid/vcn/irqsrcs_vcn_5_0.h | 47 +++++++++++++++++++
 1 file changed, 47 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/include/ivsrcid/vcn/irqsrcs_vcn_5_0.h

diff --git a/drivers/gpu/drm/amd/include/ivsrcid/vcn/irqsrcs_vcn_5_0.h b/drivers/gpu/drm/amd/include/ivsrcid/vcn/irqsrcs_vcn_5_0.h
new file mode 100644
index 0000000000000..64b553e7de1ae
--- /dev/null
+++ b/drivers/gpu/drm/amd/include/ivsrcid/vcn/irqsrcs_vcn_5_0.h
@@ -0,0 +1,47 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/*
+ * Copyright 2024 Advanced Micro Devices, Inc. All rights reserved.
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
+#ifndef __IRQSRCS_VCN_5_0_H__
+#define __IRQSRCS_VCN_5_0_H__
+
+#define VCN_5_0__SRCID__UVD_TRAP                        114	// 0x72 UVD_TRAP
+#define VCN_5_0__SRCID__UVD_ENC_GENERAL_PURPOSE         119	// 0x77 Encoder General Purpose
+#define VCN_5_0__SRCID__UVD_ENC_LOW_LATENCY             120	// 0x78 Encoder Low Latency
+#define VCN_5_0__SRCID__UVD_SYSTEM_MESSAGE_INTERRUPT    124	// 0x7c UVD system message interrupt
+#define VCN_5_0__SRCID__JPEG_ENCODE                     151	// 0x97 JRBC Encode interrupt
+#define VCN_5_0__SRCID__JPEG_DECODE                     153	// 0x99 JRBC Decode interrupt
+#define VCN_5_0__SRCID__JPEG1_DECODE                    149	// 0x95 JRBC1 Decode interrupt
+#define VCN_5_0__SRCID__JPEG2_DECODE                    151	// 0x97 JRBC2 Decode interrupt
+#define VCN_5_0__SRCID__JPEG3_DECODE                    171	// 0xab JRBC3 Decode interrupt
+#define VCN_5_0__SRCID__JPEG4_DECODE                    172	// 0xac JRBC4 Decode interrupt
+#define VCN_5_0__SRCID__JPEG5_DECODE                    173	// 0xad JRBC5 Decode interrupt
+#define VCN_5_0__SRCID__JPEG6_DECODE                    174	// 0xae JRBC6 Decode interrupt
+#define VCN_5_0__SRCID__JPEG7_DECODE                    175	// 0xaf JRBC7 Decode interrupt
+#define VCN_5_0__SRCID__JPEG8_DECODE                    177	// 0xb1 JRBC8 Decode interrupt
+#define VCN_5_0__SRCID__JPEG9_DECODE                    178	// 0xb2 JRBC9 Decode interrupt
+
+#define VCN_5_0__SRCID_UVD_POISON                       160
+#define VCN_5_0__SRCID_DJPEG0_POISON                    161
+#define VCN_5_0__SRCID_EJPEG0_POISON                    162
+#endif
-- 
2.47.0

