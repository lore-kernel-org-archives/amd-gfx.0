Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B70C3C001B0
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Aug 2023 16:27:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A5E310E1CC;
	Tue,  8 Aug 2023 16:27:04 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2066.outbound.protection.outlook.com [40.107.94.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 497F010E15B
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Aug 2023 16:27:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LUO+mDGJWS8KSEF6VcrZ+o8OtzlQbQ9bRDoARYj3gVMbu/t4645XXLuL9zAJjl/rrTY5/u7c0Qtez5oP+OB96oOPsSlldhUvEKOnXZw0VTs3JRPXGZqDKdYQ1wOGwNRmTXvvX7T8xP8MgfHCQc1c0cLffkponfqWAwIXo9c7GU3zu2yZpE8MUu9Uf7Nq10sZR/9rnySsUsMgqrJG5UegafCBln1zergaj2rEwQB2sHZM9QZEgeOXTm5PARXoG8m3WO9XIVQ8DwjJu7VkUt3xuvk71kYB6IjXudnn2fbKcFffHRD5+CBUTojWhhhkmH1gxHPNR2vtE2XxjGxkrO7Zcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LApHQApn0slUz3hds8ASbcNrHj//ms72VzQb2Xf8ctU=;
 b=AvTLVYPvpW6TA6p8F5vnt6LF02dPf9rBymToN35pwM+VDk6IR2NO0QMdK1Hj6iNKBEiI8s25ZKaww/gp95weOr4Zwc3mUeqzylX7km78HjE1fhvrndgaPFyvASaPgDIGiS6IX8e/Q3oGD2N+9iaAwIxNrREKUNBal49BI9Gl2UdBTJHtBiwcDSWijLwDO0Z82A5veo/2k3K+MnpZabi75BSTDA+chcd/HxwvfRy+mar/eHKmlpLmbHRF7tTXX5FwWqrbKNedZnlMX/4iNW9C/JAr5DdPngyNOTBrGxIbZH82/dXRuuTf1ALCKBEIZKUf6XdbNeuCl7CRb4/ZX4zXyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LApHQApn0slUz3hds8ASbcNrHj//ms72VzQb2Xf8ctU=;
 b=sDkJf2icNAeNsDZtPv/V7c+t9Y66i1NRKmG+jll4CDJ68VJ4iiL64vMxvQQWP5EOpgC+B0WZNPVuo8bTmCMYWYYWFBaipE7zQrNCM7ytmanxUGBwdm8LNnzBXRqrtubTSwN58+1jwqQiIucmo15Py0E7a7umE8H05OoXrOzNgfY=
Received: from SA0PR11CA0004.namprd11.prod.outlook.com (2603:10b6:806:d3::9)
 by MN2PR12MB4565.namprd12.prod.outlook.com (2603:10b6:208:26b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Tue, 8 Aug
 2023 16:26:57 +0000
Received: from SN1PEPF00026369.namprd02.prod.outlook.com
 (2603:10b6:806:d3:cafe::d7) by SA0PR11CA0004.outlook.office365.com
 (2603:10b6:806:d3::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27 via Frontend
 Transport; Tue, 8 Aug 2023 16:26:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00026369.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Tue, 8 Aug 2023 16:26:56 +0000
Received: from sdhume-SYS-7049GP-TRT.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 8 Aug 2023 11:26:55 -0500
From: Samir Dhume <samir.dhume@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v4 1/7] drm/amdgpu/vcn: Add MMSCH v4_0_3 support for sriov
Date: Tue, 8 Aug 2023 12:26:16 -0400
Message-ID: <20230808162622.74937-1-samir.dhume@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00026369:EE_|MN2PR12MB4565:EE_
X-MS-Office365-Filtering-Correlation-Id: 80f574de-d605-42f5-7369-08db982c4894
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BNOw8Wl+J0gmXVPyySt073Gi6r5lcEgOln/FesHaBkqV3Gln/9oKBI17C9aR8r9rU69rpuQzgJeuN9tcOrsvAVfIXN5WAph+/DrDzVGuV5mGUXps2Z0DVWKg2haSXUQDj51eoq+2Shxqe4KugGZs9Fgac/+Z1ZV2zC2aNZH86sZa00obc558iZCwJS2naC9wpnkbvkl3eyoEED5s83pan0EWVuGHU0ZYjriNUBnBIPZCnJcOOpM7q/EBBizj6kYqEDkUR4LcPFu8JrxRl5f2z5AwPzG5oTImgK7IiRe6KY0+Muld1x0XlnEd2HOezWhSkQfn02w7X5+l26OZYulVmL+3Y3TlzlcChVc0pS5oXW8xIvg1aPF8Q/MfmTf5bco210biMReEVklhJpAwuaEu+GvwJUmkn6gp8ea1ciY0s9bc/k8djcT70v4cXZdafbrUuRQYtg0OBsmPpPbqjwzTlYGvRubFLxh58E0H0bYFyV1QqskiUt+6+RLCI6qz9rcFjKi9nDyf3aOQqpgtQl8npZdIEzQf9W9KJaHLWWlor9S9hGhQFpzpVWpBQqQw9EYSn6xzYx0wRmatG4h4/m0EG9dog4RaJQwrOLSjXqS9/aQ94x2vkp9hAHvWat2LBiWBIAO2iH3ZtOhTLUfwmtEvlKL7Ric0ShTIIp54hDg8rsLPBWwxxntLag39FCUoMxg1tU6VxTOu+o6hpmkUDpt7UrO+4w4M3VBkau2KUkoUmJ8rowYRZsnBumy+3YwmhkEfVoCdaaIDZMQwbKEnCSaXXA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(376002)(136003)(396003)(39860400002)(186006)(1800799003)(451199021)(82310400008)(40470700004)(36840700001)(46966006)(2616005)(36756003)(26005)(1076003)(7696005)(6666004)(81166007)(478600001)(356005)(54906003)(82740400003)(336012)(16526019)(70586007)(70206006)(6916009)(4326008)(316002)(66899021)(41300700001)(426003)(8936002)(8676002)(5660300002)(44832011)(40460700003)(2906002)(36860700001)(83380400001)(86362001)(47076005)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2023 16:26:56.6103 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 80f574de-d605-42f5-7369-08db982c4894
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00026369.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4565
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
 lijo.lazar@amd.com, emily.deng@amd.com, frank.min@amd.com,
 alexander.deucher@amd.com, Samir
 Dhume <samir.dhume@amd.com>, leo.liu@amd.com, monk.liu@amd.com
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

