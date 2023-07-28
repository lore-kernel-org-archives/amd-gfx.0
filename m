Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8831C001DF
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Jul 2023 19:16:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 662BE10E11B;
	Fri, 28 Jul 2023 19:16:04 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2048.outbound.protection.outlook.com [40.107.223.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B23710E11B
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Jul 2023 19:16:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cNBafR1wdOxFTDr9ugFQ9HLTBszep2tRlylpR3GPwGJjfDwUQmkCUUpZXw86tpJ3wTCyIuAItU9CtXaDEuYrEH3WyWHx/r4kxP/LmzwrRF5Kk+x9c87lVY5+qIsq6JI3/G59ZpOYZQgOKRFKWP6yVwYj9lUbDQ5nzn20YtJn3Kzv8Lo48hNjshqyLViMR+mzzw2byA6Gg175T+86X8PZuAp7Oh7vHmj0OCA/4J92OM56/wq710YFIiIY86dK1Qo1q7xCRmYk8Zudqqa+2gePr9Jkk/VlQuBfzoOiuegUSyVzLH19Yw7bR5ExEszEIH9W4bDMLEDlxzg256Xtkdvxww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LApHQApn0slUz3hds8ASbcNrHj//ms72VzQb2Xf8ctU=;
 b=HJR7y+m+erzav8KRb8oVcqBBw5s4mEz//j37MXC0YWNL0p366gS7czfvTfSpveXuXyQNbGL8T4v1VYABJRdDroYlG9ArLb9GOoKcbkr6R4ivvEH5YV9VafoYe5ng+9Cn+NJEoZMjFCcTU9wc9pAxePRE2YwNuW0K/nnYNicM/jJkF2h8BruLrdFuHTWQ5U3pflBgIq3Zsr8PHPNchg13DSoUVa9erACgs1sQ6Dg5wxSYb1oMhX4K2riAouA+VkkQWPZ4JOFGnVLWIVtwrULB/INYcCgDcu0ztSKluqXIiH71tP8O1rDxzzkl6AeKo1JozdzeRG8OYwDJ97WELC1Ckg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LApHQApn0slUz3hds8ASbcNrHj//ms72VzQb2Xf8ctU=;
 b=RaA6W8tMNcD2PB4p+iZhIFTW0n63yqYfppXf4v/al1BfK/oy0Twj/AxIiOonuWiEDQgt4WTqg0ESNiUF1Pmz1GveBB/8jYmTQ8njQb0gQHK9OUuGCtxTU0/mIi2/tLH0WWWcK19OXIeHzXR1+U5FDRJu6vU8RYBC9pSgRw7tdxw=
Received: from DS7PR03CA0312.namprd03.prod.outlook.com (2603:10b6:8:2b::21) by
 DS0PR12MB7631.namprd12.prod.outlook.com (2603:10b6:8:11e::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.29; Fri, 28 Jul 2023 19:16:00 +0000
Received: from DM6NAM11FT024.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2b:cafe::2d) by DS7PR03CA0312.outlook.office365.com
 (2603:10b6:8:2b::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29 via Frontend
 Transport; Fri, 28 Jul 2023 19:16:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT024.mail.protection.outlook.com (10.13.172.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6631.35 via Frontend Transport; Fri, 28 Jul 2023 19:16:00 +0000
Received: from sdhume-SYS-7049GP-TRT.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 28 Jul 2023 14:15:58 -0500
From: Samir Dhume <samir.dhume@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3 1/7] drm/amdgpu/vcn: Add MMSCH v4_0_3 support for sriov
Date: Fri, 28 Jul 2023 15:15:35 -0400
Message-ID: <20230728191541.1778424-1-samir.dhume@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT024:EE_|DS0PR12MB7631:EE_
X-MS-Office365-Filtering-Correlation-Id: c6ef644d-5473-4dd1-655a-08db8f9f1423
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ftKaPYqUL9TkMVflqfbtZ8/tuyfO4dwGnvZ//H6XLfg63hoeMzE0r0d9Td3fgxYU8Di067sscYzkr4rIZ02CC/TC4txVLcveTzEBEP5k4DOAbJg0nTgeGfl4HgtPZDwGq+BVtUmJ3lq0OLoZG9Ux5nfDJrmB1CGWy0oIikyUXODSvm2MWq0BrCdCpkxuemoplTOxBmWvU5XJ8qVS9qw3y5rml1nnlMhJghW6ojRBylUtfr/FTSK/I/H+iwntqfOL7LogLRPSm/Ss9BZu8l/lw0ZTiBHUKXthRjkv9fm5mtxYkBgX1Dswin3+gNaTrWimAp60+7ZKx6W8I96r3D/6e+6nM+k/cw6Ilwa0SREoxHlETVQWQMWHvVRkCO9Vf+HfXRqhKJdxFr8EQ/qZPpEZurV2F4DusDy7aLErcywLyin1isu4LRquqrex7tJ28mI0MIpE1iYXkB5AQ3CCbrwd4ExCtVVkC/kUCPD9tdJN+MC6oZnCD9OPXHzlqahkgHesRMMFF83ZHqN3YKCqYT/ZX1Fj0yz+/AsrWYrz7aq6x2KOcTE3AMQLCcS49PUo5lZeLsgg1xD5Xy4uC57QMDMlcIhyxdao3IGH/lhW/CVdUDCrrv7jV1tbugr/xQqwuyj4EY0dioZWDxRC0YoxRLu/VyxQ5hqRyBAM1bBRxcJc6uWyl4wWrCJd9z4PH4Plll4pX6mZoohR3VPUerPcG6rCuN2GV751WICg6fgcYileP+3vj3YJtKq1iUZrdeHQC4jaHStrGNlbeCKFHHFiCUhsKg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(346002)(396003)(39860400002)(376002)(82310400008)(451199021)(36840700001)(40470700004)(46966006)(8936002)(8676002)(1076003)(26005)(54906003)(41300700001)(82740400003)(4326008)(6916009)(316002)(16526019)(66899021)(5660300002)(336012)(186003)(6666004)(7696005)(478600001)(70206006)(70586007)(44832011)(86362001)(2616005)(36756003)(426003)(83380400001)(47076005)(40460700003)(36860700001)(2906002)(81166007)(356005)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2023 19:16:00.2712 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c6ef644d-5473-4dd1-655a-08db8f9f1423
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT024.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7631
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
Cc: zhigang.luo@amd.com, guchun.chen@amd.com, gavin.wan@amd.com,
 lijo.lazar@amd.com, Samir Dhume <samir.dhume@amd.com>, frank.min@amd.com,
 hawking.zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

    The structures are the same as v4_0 except for the
    init header

Signed-off-by: Samir Dhume <samir.dhume@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mmsch_v4_0_3.h | 37 +++++++++++++++++++++++
 1 file changed, 37 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/mmsch_v4_0_3.h

diff --git a/drivers/gpu/drm/amd/amdgpu/mmsch_v4_0_3.h b/drivers/gpu/drm/amd/amdgpu/mmsch_v4_0_3.h
new file mode 100644
index 000000000000..db7eb5260295
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/mmsch_v4_0_3.h
@@ -0,0 +1,37 @@
+/*
+ * Copyright 2023 Advanced Micro Devices, Inc.
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
+#ifndef __MMSCH_V4_0_3_H__
+#define __MMSCH_V4_0_3_H__
+
+#include "amdgpu_vcn.h"
+#include "mmsch_v4_0.h"
+
+struct mmsch_v4_0_3_init_header {
+	uint32_t version;
+	uint32_t total_size;
+	struct mmsch_v4_0_table_info vcn0;
+	struct mmsch_v4_0_table_info mjpegdec0[4];
+	struct mmsch_v4_0_table_info mjpegdec1[4];
+};
+#endif
-- 
2.34.1

