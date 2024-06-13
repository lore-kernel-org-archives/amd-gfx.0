Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7864CC27C6E
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Jun 2024 02:27:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D43C10E95B;
	Thu, 13 Jun 2024 02:27:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="h/DdxKSk";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2060.outbound.protection.outlook.com [40.107.243.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C5AB710E957
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Jun 2024 02:27:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KadaEVnI+zPziGKd1eTMPkYkZCU+KwmoBDzoidmSeCAxTJ1G/9KSWDj9kYb72VrRSCZaYlIo+lHE9xrAciWmXNTbxUB+fmC7Tjr4d5u8jbZspeUxoTqWsY8gam6CbixXJVQ1fytl5bHzzCp0pbp+PbeL1XdzNsymVZqMVXqnelwgmg8ZqLNpE/C4hmWTv9o+4H+nTlRH77fGV0i/JpF+rpUgxZqT6c3b3UqPuI+06ar56OaAAS3HQp1FkZnQTGcP0tDXqQZmpJtgLDcmCN+/z6SPhzXg3fEiSpspTK4aZ3fJk3p0TZBK8fuQeG4svWFeJotDB8cun59rmKNdhi2lfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hv2aXKz3Xp/bWUy4T8r4h42T7JIqbtj76/7LZ9q2Feg=;
 b=JbvjV3Bjm5abVUrI8yyFADj33R7nKZNhD+1p/OfzWA50FBHgCx30xnZRioaNqRDlSUbLqPe4LNAHlTmZyc5OxxpXAyq13S/B7hz9AACDIJIhXf1Dm/7lDXOolJXgcj5pC3v2rocQinfgIgTfCMMQV4kVyGsGCokh3TfW07TGlJyn7aFN6KV0roBoAFXylN9iRGbSgk+ZwtYmA9xbARLeh9Z+n12+x5gDe/T/aH4i/BLmvA/dfTn6qHR3bxk6jNmBPV/NmQhFFWqEtBoITFgi65X+geZhRV+tpJFVSxV22Z4PbVA2zmKW1zYi+HfNim8NXx6ObSMjrMt2OnEx9DU38A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hv2aXKz3Xp/bWUy4T8r4h42T7JIqbtj76/7LZ9q2Feg=;
 b=h/DdxKSk5Cw1uMaak/7YafNu8+ZqiU2mpkeQPps8yUdfMrb/CP9Mzr8++KtuM1nzHv6ZUwCTQbwev3V0t1r2x3Usw4l/MJLKFMMiqE95H91ngOFV1nx0bljnswav8EN4NGNBXTsgK0OXzfqUnqx5BMdkMZ4fdRz9WgEzGj2q0Zw=
Received: from CYZPR05CA0045.namprd05.prod.outlook.com (2603:10b6:930:a3::19)
 by MW4PR12MB7311.namprd12.prod.outlook.com (2603:10b6:303:227::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Thu, 13 Jun
 2024 02:27:04 +0000
Received: from CY4PEPF0000E9CD.namprd03.prod.outlook.com
 (2603:10b6:930:a3:cafe::32) by CYZPR05CA0045.outlook.office365.com
 (2603:10b6:930:a3::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.21 via Frontend
 Transport; Thu, 13 Jun 2024 02:27:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9CD.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Thu, 13 Jun 2024 02:27:03 +0000
Received: from amd-02.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 12 Jun
 2024 21:27:00 -0500
From: YiPeng Chai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Tao.Zhou1@amd.com>, <Candice.Li@amd.com>,
 <KevinYang.Wang@amd.com>, <Stanley.Yang@amd.com>, YiPeng Chai
 <YiPeng.Chai@amd.com>
Subject: [PATCH 3/5] drm/amdgpu: clear all messages reset flags in fifo before
 gpu reset
Date: Thu, 13 Jun 2024 10:25:02 +0800
Message-ID: <20240613022504.81787-3-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240613022504.81787-1-YiPeng.Chai@amd.com>
References: <20240613022504.81787-1-YiPeng.Chai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CD:EE_|MW4PR12MB7311:EE_
X-MS-Office365-Filtering-Correlation-Id: ec3d4fb3-e2a7-4839-f6d3-08dc8b505019
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230034|36860700007|376008|1800799018|82310400020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?QgvVPmOoD2MmK6WNjG2ysRRCjfLH26+IPxkQdKTh+uzy0UNo63ZuNiAb1ymn?=
 =?us-ascii?Q?IkTHy4vGVOOJerMU1XD4SkjYXcARWlMOSLWrEONk1t6VxupCTVzcChHq3iUN?=
 =?us-ascii?Q?jVsitpH+A5HDGe7gSorGag3fstwzqIs21o6GKTdN255ImnPUFBGgASth84Mi?=
 =?us-ascii?Q?ESGq8CZmIUWMvyMxwnB9lVVtFk5dwP6AKCSGKBA68LM6wZZbgrO2ZYcEBgBz?=
 =?us-ascii?Q?lXjxPlbgqDsbbarE9eZlRorHWZ5iZd41eGaFMIUdU29JnFqRs2fm4yKFzNHq?=
 =?us-ascii?Q?Ddx4qPx1jdOFs5pAlBqTEj6H7aZ7TVpcaxPx/BP5kNrUAFBKBIkpilQXCiyP?=
 =?us-ascii?Q?zhbKjgBVJAgUfgWhXnPfHY2Ks4ARyUuTUi3U6l9nP8QMo7i4ji7StFZumtjK?=
 =?us-ascii?Q?9QaEpEkSttF9kTP6X1ycKWor6wdKFIOOZcg29476T1cS1HeyzyV4IWlDEfzc?=
 =?us-ascii?Q?vcVUeaflr69irV9oI/L4nZ039wcFi4DP9RYT4phaCkzhWfEmwaME1jMdzu4K?=
 =?us-ascii?Q?n5T46RuISCtfqmxcpt1ILDVwxEhFRNpxhDvUn0+F/K6yaoQnJfAR4X8m0ujY?=
 =?us-ascii?Q?L/Dp1VQG+VttHp7ezAlWtXJRdHOtYZtqMKsYENup/jFpjU/JTRlnI0534veH?=
 =?us-ascii?Q?pD3triyITYu295FtCo5jTotVHcQb5n6cG+BA2dob8UKEnK3ydGv2xk+ObM5s?=
 =?us-ascii?Q?vaboSFkvYVI4G/vXKDQxQs2F5rFEzmzUMS6lkCED3bpknU/YLJPrT26vpDY0?=
 =?us-ascii?Q?oXG15RqSFrzXJBWTEqyabICqpCOTnIG1sx2yaGTJgy8OJ2M9SmXi5cRjtX+0?=
 =?us-ascii?Q?lZSOvux/caQHvn+dfMr2nQvcrmYUDIbP1WRrPFCsUNreiic2/6cU6XlWr/Nl?=
 =?us-ascii?Q?lfJhwrQ4qtja2ijB8EWFrQCmVB2yWwVfuWvxkLbR00corNRVtRRcEdCvXYOX?=
 =?us-ascii?Q?1E1ssG2z4lSAp84EL+HPkTgyVUO+29cVlRmnzc8J//fWXtYDRfZk1pMC40lO?=
 =?us-ascii?Q?tc7RP4aKbKAcI8XZcaHeOO5ZCNgDHwRJKG7LLNp+yyK1kvzYjwva+scUgzVF?=
 =?us-ascii?Q?8SkFvdkoOAtoea2m8zhPDj83s7w/+sVwn0cQByIblznfsBbZvXRBeGXBCfPv?=
 =?us-ascii?Q?ncJt4gLAaq3bDQtVeADfOQnfK3E2Wr2exyjV5oct1rW3gOPmI3HC2D0j0Uc4?=
 =?us-ascii?Q?AcXXGNBQUf3eHw1nJ5wsfBPE8DWdGLIgiNGFNmwDXiMjJ7ua0EZ0o304J21M?=
 =?us-ascii?Q?ERV6Z5iERfDevz1Q2pC0w2ZcA132zO99qQTXTID3/UUcaeCYwqMDEubfbrwR?=
 =?us-ascii?Q?tDVyXMTWoHB8Fg1qXL22aVTOAnwpnRlSREdBWYWPJ6jd5/aJ63mrTRSqL2/a?=
 =?us-ascii?Q?s4e12htd5ixqmxoCl9dX1K7GbdzFRKOcfWShTXX39EflsG+bhg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230034)(36860700007)(376008)(1800799018)(82310400020); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2024 02:27:03.4166 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ec3d4fb3-e2a7-4839-f6d3-08dc8b505019
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9CD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7311
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

To avoid resetting the gpu repeatedly, clear all
message reset flags in the fifo before the first
gpu reset.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 59 ++++++++++++++++++++++++-
 1 file changed, 58 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 1e6e06009577..7dfb2e548d70 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2768,6 +2768,49 @@ static int amdgpu_ras_get_poison_req(struct amdgpu_device *adev,
 
 	return kfifo_get(&con->poison_fifo, poison_msg);
 }
+
+static void amdgpu_ras_clear_poison_fifo_msg_reset_flag(struct amdgpu_device *adev,
+			uint32_t *cached_reset)
+{
+	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
+	struct ras_poison_msg msg;
+	uint32_t cached_msg_count;
+	uint32_t reset = 0;
+	int i, ret;
+
+	cached_msg_count = kfifo_len(&con->poison_fifo);
+
+	for (i = 0; i < cached_msg_count; i++) {
+		ret = kfifo_get(&con->poison_fifo, &msg);
+		if (!ret)
+			continue;
+
+		if (msg.block != AMDGPU_RAS_BLOCK__UMC) {
+			reset |= msg.reset;
+
+			/* Clear reset flag */
+			msg.reset = 0;
+		}
+
+		/* add message back to fifo */
+		ret = kfifo_put(&con->poison_fifo, msg);
+		if (!ret)
+			dev_info(adev->dev, "Poison fifo drop message!\n");
+	}
+	*cached_reset = reset;
+}
+
+static void amdgpu_ras_clear_poison_fifo(struct amdgpu_device *adev)
+{
+	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
+	struct ras_poison_msg msg;
+	int ret;
+
+	do {
+		ret = kfifo_get(&con->poison_fifo, &msg);
+	} while (ret);
+
+}
 #endif
 
 #ifdef HAVE_RADIX_TREE_ITER_DELETE
@@ -2886,9 +2929,23 @@ static int amdgpu_ras_poison_consumption_handler(struct amdgpu_device *adev,
 		poison_msg->pasid_fn(adev, pasid, poison_msg->data);
 
 	if (reset) {
+		uint32_t fifo_cached_reset = 0;
+
 		flush_delayed_work(&con->page_retirement_dwork);
 
-		con->gpu_reset_flags |= reset;
+		amdgpu_ras_clear_poison_fifo_msg_reset_flag(adev, &fifo_cached_reset);
+
+		reset |= fifo_cached_reset;
+
+		if (reset & AMDGPU_RAS_GPU_RESET_MODE1_RESET) {
+			con->gpu_reset_flags |= AMDGPU_RAS_GPU_RESET_MODE1_RESET;
+			amdgpu_ras_clear_poison_fifo(adev);
+		} else if (reset & AMDGPU_RAS_GPU_RESET_MODE2_RESET) {
+			con->gpu_reset_flags |= AMDGPU_RAS_GPU_RESET_MODE2_RESET;
+		} else {
+			con->gpu_reset_flags |= reset;
+		}
+
 		amdgpu_ras_reset_gpu(adev);
 	}
 
-- 
2.34.1

