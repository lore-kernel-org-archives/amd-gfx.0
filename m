Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D0F9EB64DA
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Jul 2023 19:20:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8416B10E177;
	Thu, 20 Jul 2023 19:20:25 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2065.outbound.protection.outlook.com [40.107.237.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0607210E119
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Jul 2023 19:20:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GIjMLO7LTY0IYaMVd67bgXIYQXK9CrDHOd7vaiTJdCb+9S+FII0ni1dc7Z5pRm7zUkYOkrMY40UO+Db7Qdnpd7v2w7yZT9m+tU9+HHtIBhNKbg9K8clyzOKNvEKhaN9q7Jfmoz3orCX06KhWUtQjWjnkv9xwDEf4oox60j4Y6XMOyqu8hOYbPIdn1y38BgvH6BmBx0j+1wjViLWOSFKcNNShjLERTtmS4PC6sAe21lyCdthIppo6NKsGkwz9sC5PHjuBKYAN8hAC+LGz+fpWePf2TF3Q/dmxbeF2O6OGh/uWR1dmUoabZn0jfTUSlZsIrpNKv2DrzdyFbTyQ8JeJpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LApHQApn0slUz3hds8ASbcNrHj//ms72VzQb2Xf8ctU=;
 b=EI6qH2qXm3si4KBzOgDPA5guK0K9zUqTe1Y2Wyvlvk7hY32fVrwxwJo7BZc8q06c/8tMr2MVavnG9L/bf37L57kiTPBuT2Jh3k0bfjMHTG3XofKidkLx9bvg3zkjp2cfY9q5+1eZSvu/dM7NyvXGJV9mm/nO6MySxAP6OvT8Bdp/NGhV+TkWQPs1RjEJr81zEyHhvAqgHVSW0uF04KlaakDQKe/CB3NT0JLrmWY86/0buLoVKx8ZISKw1Vq5qpvgCqHO96bTCQZT4Fy8t1Lo/VU/Axokfa7lFPhwazmu7Qa87eAnTrEmgofT276S4mVuN8oSxo5toIM4BPqzrkZqag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LApHQApn0slUz3hds8ASbcNrHj//ms72VzQb2Xf8ctU=;
 b=RxzRgzMOY9Z7P1FdqVF73e4zT9MOTuh/pkOX65zb7g8kKRohcQEd5AwfMqTK1rZ5Mpb0n94051+sUPbei4DGrdcgkhibCcUH1aSwavayPPzKkod7VNI7w6/yCr5TLJpLCmXVRGXVeIRynArp0tzJ1PrB9OVEQqT94EMvaUda0zA=
Received: from DM6PR10CA0009.namprd10.prod.outlook.com (2603:10b6:5:60::22) by
 SA0PR12MB7480.namprd12.prod.outlook.com (2603:10b6:806:24b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.25; Thu, 20 Jul
 2023 19:20:20 +0000
Received: from DM6NAM11FT044.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:60:cafe::e4) by DM6PR10CA0009.outlook.office365.com
 (2603:10b6:5:60::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.28 via Frontend
 Transport; Thu, 20 Jul 2023 19:20:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT044.mail.protection.outlook.com (10.13.173.185) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.35 via Frontend Transport; Thu, 20 Jul 2023 19:20:19 +0000
Received: from sdhume-SYS-7049GP-TRT.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 20 Jul 2023 14:20:08 -0500
From: Samir Dhume <samir.dhume@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/7] drm/amdgpu/vcn: Add MMSCH v4_0_3 support for sriov
Date: Thu, 20 Jul 2023 15:19:34 -0400
Message-ID: <20230720191940.780187-1-samir.dhume@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT044:EE_|SA0PR12MB7480:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ad9cdcb-04d7-4967-4072-08db89565b7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SLBBLNOPJbGkyc6QuhKnCtGEKiI0NUQjxWQzJ0EtghLWOXceMmrqxF0LOkaEc1Mg6hBM38Lhn8iPr5WF8bOiI9LKEHYjW1tJsSjzCH/rnJ1DGF/4L6nqlcsWhU7XldaK8u/0DpmP+5OtJ/R00VRJrKKUppshOBuEJTUais59y6ARqt1PhGAfqOg9dLNH5MxzvdTxVvizsq4h5skPD+40bTi6h8tj+HpWQqw/09mrNzAQppLhtclghBvqTVofKwuIC7c4GVG1TFNDMRs3VMe3w4F4MBzg1qxKS4H7wGunUBMisznRYCa5rsidpq94II7Xk+Dv70LaIlGlgEVCod89pJNDvfR2xZAKpIL3Q2UyXirMYg8ke3s4DLOKgk2i6tc558RtrdCx1EmTBsDvYcICApYYce/QQJrYFN2XBjBVs2FM/V4d9yZ6zv9h9ZCkhI2L8ygryDsE1rqY973yEqKyIsTsr3lKqthSsiYjuhH26SE2EScX0Mb3ZUtXrsTXCXvPbz7aeWiDOYVKdcganPxTSBzj3M8tHWSPdWVxjVN+Lhn1SiB04xEhinKhr9THyW6HBZYI/FmmMFUqZPxkV4dXxjEsUnsFeyFmfVsCF+tJMXPdkJeKQ6BR6OlW4SqtfugEicdLKTWmW09ibTuVqAtzJJ69ucSEh2tayfD3ZVlqiKBZUfGFC0Bcd2/sWg00cO8h2aiclpvdP0idiO+U9BjG/zXpyEy1UYU7hGdfv8+6C4tkqMbuHJRSYhrt7J9TVBPBJyfvzgUDY/G/Lyp6eyslyw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(136003)(376002)(396003)(39860400002)(451199021)(82310400008)(40470700004)(46966006)(36840700001)(47076005)(426003)(81166007)(2616005)(66899021)(83380400001)(356005)(36860700001)(2906002)(40480700001)(40460700003)(70206006)(70586007)(316002)(82740400003)(6916009)(4326008)(7696005)(6666004)(36756003)(86362001)(478600001)(44832011)(54906003)(8936002)(8676002)(1076003)(26005)(336012)(41300700001)(16526019)(186003)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2023 19:20:19.7429 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ad9cdcb-04d7-4967-4072-08db89565b7b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT044.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7480
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
 lijo.lazar@amd.com, Samir Dhume <samir.dhume@amd.com>, hawking.zhang@amd.com
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

