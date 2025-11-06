Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 680DCCCFA03
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Nov 2025 11:44:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E432A10E8AA;
	Thu,  6 Nov 2025 11:44:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tGC14NiY";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011002.outbound.protection.outlook.com [40.107.208.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E382710E8A7
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Nov 2025 11:44:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rX0xUqV4kftbON32dqnLF4usf+XBtUIXXVU2s/An/UiVmOhmraP2Y6bXA/TE5zp2zuEVKvhFoRc7Q2QGUFV+cJ/nmyCuDymWKaonRNBfU5dLrcKT/Gw+b2G5q/7ap45+ot//FzPyU0UQiSF4K4E+zwHx4QB/vAi8/QsLE7Q4BAyYLWx0zh94/1dIzQ+NxCr2cAO6MpcO28tmC9PDvTzjgJzxMLsYzw5aaObqbJJzc9SdMVfqbkJwcesWeAkuKn7QqhQ9wsqSvOfbQIkfiFfetCAirLav0pOch6tBEGQvypS9mYACZZ+8eC8pC+Nsr99Upz02J7LOCFH2XA0YAQkFPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o9J+CZl1ePeio+xhyHLgzwrHvgRVsLvPTb18OLlvMiU=;
 b=Q/U0v+0HBq2I6ZYpqLwEJhmAIaINf5Yojoxt6Lpjs5a4X4VHlEsrwtjRwEDkMhN4mFy4SDY8uXhYMU8in/R2xyjYZn3szsywi5MKe2R2vPzRudTTy8UjbuC/lDHn9m5RM+ivVx5mbzJQkvv1uBqE2TgtecQuIDg19w39h3LL8WfO1nh+2KO2DwSVZdjWDJQ6vaKy3PDQ2aogUpwDJSHWGeHyfqTk77rp1pZkrdAacaC/MOvr/JBQNP7WY1AeStM4I/OX8IqCa+Fa3RZle7pSHacQPwtN/BCAyUgOh/i1sYR3kB/R2+btf8ZSTHzxt8iolVu23GzBK/AHbu4CPdAerw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o9J+CZl1ePeio+xhyHLgzwrHvgRVsLvPTb18OLlvMiU=;
 b=tGC14NiYbdIRjswX6+hDZURyo4Z8DV5z5xbqmL+GysQA2gpya7MKjQEEeVz0G3iuDC1MJlc9SnfFnBuGV5Ia2y8ezhTiqGLamOLtL/rFnc9F2FJ9B1gt0aUPvo1JUxmz59AdW46U9OIfil0DzDf9+sC5GOBYsTjULQ9zJW0VcGs=
Received: from BL1P223CA0012.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:2c4::17)
 by DM4PR12MB7574.namprd12.prod.outlook.com (2603:10b6:8:10e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Thu, 6 Nov
 2025 11:44:43 +0000
Received: from BL6PEPF0001AB58.namprd02.prod.outlook.com
 (2603:10b6:208:2c4:cafe::4) by BL1P223CA0012.outlook.office365.com
 (2603:10b6:208:2c4::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.16 via Frontend Transport; Thu,
 6 Nov 2025 11:44:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB58.mail.protection.outlook.com (10.167.241.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Thu, 6 Nov 2025 11:44:42 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 6 Nov
 2025 03:44:40 -0800
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <lijo.lazar@amd.com>, <hawking.zhang@amd.com>, <le.ma@amd.com>,
 <shiwu.zhang@amd.com>, <alexander.deucher@amd.com>, <asad.kamal@amd.com>,
 <KevinYang.Wang@amd.com>
Subject: [PATCH v2 4/4] drm/amd/pm: Enable ppt1 caps for smu_v13_0_12
Date: Thu, 6 Nov 2025 19:44:21 +0800
Message-ID: <20251106114421.3770378-4-asad.kamal@amd.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20251106114421.3770378-1-asad.kamal@amd.com>
References: <20251106114421.3770378-1-asad.kamal@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB58:EE_|DM4PR12MB7574:EE_
X-MS-Office365-Filtering-Correlation-Id: c1e35db8-d78d-4b36-ba29-08de1d29e050
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?l2MQVgJdXaQFygwl+jhbXg2W9LLEq1y7+S0wYG0ovyGf0tn2aRvtbN2JFqpR?=
 =?us-ascii?Q?D27jkL+Jbd0Ic6xMLjU8q/JDp0TqlUxVZHH4WnNI0zgHSC3ywShUYpv9L5ia?=
 =?us-ascii?Q?O3c7eFBI9O0N0Stz6Ma8RgITqvBSU6IiXr4KzFKmVfteSP++oh+zHG2PQ+Kj?=
 =?us-ascii?Q?/pCfrMMeXiBrRSQbKaXKbh4RVZB/dl99sg/A0kALFKsEHHB8Ff0c8Nnqp+Ir?=
 =?us-ascii?Q?lPnrov4gDXo60F8O+z3pZIPaj2iIih3M0DgHuKI+E1x9yRp1E2Jrlgd4KBEM?=
 =?us-ascii?Q?OulRhs/KXB55MAMGtFf9VUAD5ZCHNJ9A3K8NpHojDDAffpDCR3x+K7bNv9jR?=
 =?us-ascii?Q?hVfVVUUIN3RyKc8F3GdrK/03qS1EwC/2LIMIdlUE7R67Lreb6XXZNP1G3Q07?=
 =?us-ascii?Q?FHOFogJnWkN8U+1hVli54FyDimzNzVoakYrnbg2B07zgUH5uXr+rJtu2GAVS?=
 =?us-ascii?Q?v8+TqaRfmubfN4cqd8sJdmYaZxnz9tmMoffdTKSICHMrusDW7LnbDB0PsiBL?=
 =?us-ascii?Q?zYtSAEMpNvSR9FV/ULVki3sGGNQnROduOwZD3oOqne0f6He4sGgkpgFvJy9f?=
 =?us-ascii?Q?p9GLuEehg/s1Lb958e3grl66ZYTgtyd54cQ1/ZqV7y+hRCaXzdGz/G1i6yVb?=
 =?us-ascii?Q?K2PprVsMkdj2ySTHJTmKbffa9Aoq04l+B2+ReexeOednBtYV2XGmxsuMsaYc?=
 =?us-ascii?Q?3QEtqb2nDRP58cpX/voKpZ8mF7IGDQEjUzrZwnICUehI+J5kn1JQe3N0Btch?=
 =?us-ascii?Q?Vx6fbVtYY4mLtEMZ+W8fZKv880nfkOTTrkDpJyypJ8Bj8ZtlvLD8jqfXbzGd?=
 =?us-ascii?Q?jNUwAgFKoJPYsVaXI9dnuFBuTK0LsZErGcGUFAngscQIKOTwB/FQiZyazcRi?=
 =?us-ascii?Q?JmBwZAmhMao71gvR0HssIbaqLNU/bjdZ0DPW+whYhm5Xuw/gLmQtBEVaFRKx?=
 =?us-ascii?Q?UNF8WMEdsPesg2qAUyoyuy/iSU5xCkpqp708bnO/2OhorPxYEo4R+ZF0qkW5?=
 =?us-ascii?Q?VhNNbcGm8TfKefadZPulJnldq5KC7/wmo+rHXDC5z3L3qrKezjZ5zFdlpCdh?=
 =?us-ascii?Q?449v20hmTqbIhccR0J7YnsO3ZDQB+e0B29wmdCEqtQrx5UPBcZWOWzktv48B?=
 =?us-ascii?Q?Jx1xAb0vbCKjvyKmmt5mDcWbJdWsnFRZ1048a67mc945klYXcib4nrvWH8LO?=
 =?us-ascii?Q?lXbXEsguXdxVj2jymWR0rJZNU9qOHKd7e4jSsAb6SQzEUDNmCbSCoAltCqqP?=
 =?us-ascii?Q?P/fajItarYUmI1mnBvwpQH8tQC0PyX0aE+l3DYtrBz8iZXpagwDTaOYzLGVg?=
 =?us-ascii?Q?6nrz9Jyl2a0iB67quedajn7Pxa6qrNoJX7kpX8NeV6ucCVtYiETNdRfww3c7?=
 =?us-ascii?Q?YDzuV0pf742cK06j7N1BL0XUyjbF/LC6h6gWgcGerdvPYhaAttOq3VHsAMAc?=
 =?us-ascii?Q?6QXMXcyxbiQOzXcDF4x2NcXnUEFLA9FuZmd0nixhB4wDwQc7CHu+z0K6vZsD?=
 =?us-ascii?Q?eI2hJKa65a7lmwXDSlWxI/9W+ivMS/aSYxJW4N4ujlavCVVSdChUzwXt6F6Y?=
 =?us-ascii?Q?UcfhuEOUhZS2sCaemps=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 11:44:42.7010 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c1e35db8-d78d-4b36-ba29-08de1d29e050
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB58.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7574
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

Enable ppt1 caps to fetch and configure ppt1 for smu_v13_0_12

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 282bd00a909c..81d8fc51a5de 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -356,6 +356,9 @@ static void smu_v13_0_12_init_caps(struct smu_context *smu)
 	if (fw_ver > 0x04560900)
 		smu_v13_0_6_cap_set(smu, SMU_CAP(VCN_RESET));
 
+	if (fw_ver >= 0x04560D00)
+		smu_v13_0_6_cap_set(smu, SMU_CAP(FAST_PPT));
+
 	if (fw_ver >= 0x04560700) {
 		if (fw_ver >= 0x04560900) {
 			smu_v13_0_6_cap_set(smu, SMU_CAP(TEMP_METRICS));
-- 
2.46.0

