Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F088DC0015E
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Jul 2023 15:59:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D4C510E278;
	Mon, 17 Jul 2023 15:59:11 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 678D310E278
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Jul 2023 15:59:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UM0YCz+lGOSJTY6A+3uTTcSsInC2/Y5UKI7SbXQuW3TCyHxY/ic34LkAZ9tERE1HxbSuKAJgVO8z7sp9z41rKN6oKpJM8teJriUOoT0tSTVHiJUCk08VwGSolX87lDHIzzV6ZL4frutJ98C9wPO8cIH3BH+7VaM4VfNDzB4hC248yx7KxvkjZhqHu6dYtPFrlXH1Rn9Ot6+FjJ3uobv2qUv4KDI3UUrxAeSdHSBlexGnJirrJpn8BOoINDHLXaOcWD2SJgsDtCbS2/c5hYommuoqctQxjiecHURAe+mSQW/eIcMIdKFukTLfwqF+NfAClmKYzLFM3XUcZLIuxmaRww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LApHQApn0slUz3hds8ASbcNrHj//ms72VzQb2Xf8ctU=;
 b=ZSYtZseETC9CJmteC/qv9lS8vDZ9HwOyqsF6H5c7fH+/VKoj97+lLWrGGpUshHB0lY0oPoxqTkiw3AgEGCgV4kVce0uye3mSwNnJX5NTr1aFHIMjS+J8wvBkt0zEWb3KxT6SqBTM9VYfQSqOIF2jTXQ8NqzgtS4KVbyYxr6ex9KvaUrHnQu4iNciOitGjvS0+dtRQYui7UWGZb27QbA98FV/A+ZnxB1eLtCdyzwRUeRNz7EcN3HxfK1MYAJNe34Yi+Ba30vfP964fnnCNDxb5svOQA1czI5beSSmbRyFJZjjY8yC0mYcCH0+RNWqxMd8y1XNLTahVZdzVCSyvACLBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LApHQApn0slUz3hds8ASbcNrHj//ms72VzQb2Xf8ctU=;
 b=dLWGmjZ77/IaKfydR/3q+g3xCYIkKgVWtO0ardzMfFhDyi9Lb0zvnJgspTDLjt+hkh2Y29iC2lALNjeK0QIFeYId/zqHx9c0Ns2qqS7YBKZQSJ7hrSfMR8zpeLYPrIc0mRV6C5VRPmjgBdMV9smfYVnOLAq33GW/S7KhkaU8La8=
Received: from MW4P221CA0016.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::21)
 by CH2PR12MB4939.namprd12.prod.outlook.com (2603:10b6:610:61::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Mon, 17 Jul
 2023 15:59:07 +0000
Received: from CO1NAM11FT006.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8b:cafe::11) by MW4P221CA0016.outlook.office365.com
 (2603:10b6:303:8b::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.32 via Frontend
 Transport; Mon, 17 Jul 2023 15:59:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT006.mail.protection.outlook.com (10.13.174.246) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.33 via Frontend Transport; Mon, 17 Jul 2023 15:59:06 +0000
Received: from sdhume-SYS-7049GP-TRT.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 17 Jul 2023 10:59:03 -0500
From: Samir Dhume <samir.dhume@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/7] drm/amdgpu/vcn: Add MMSCH v4_0_3 support for sriov
Date: Mon, 17 Jul 2023 11:58:35 -0400
Message-ID: <20230717155841.758516-1-samir.dhume@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT006:EE_|CH2PR12MB4939:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e6615dc-45fe-4b28-2398-08db86dec03d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LvWLuEPkshNuB5wWv75O7a34zZGLQW6RFkKABwbFlpU+5+CwjvPu+aXye6+mQdYnKt/YVAMiLjh1rwl5rWJ/zXLVoaweK3Si8YzK3MTubCs/zJkBjX33K/DGm5gRpb5sr5doKEGcTkiTezS70cgW/bPMWAwDzpq3q8UoxgMzpLtJjeC1GJRNwkt//rPtLVVWws3KIu1IagJza1o1b0yA+RqEcUpbyWbljfMEGBOQg/SAGEF65fxienxrSgw9T6y4QXEy46Lqx/K1vPjZoHRTlyZZueI4ttvCv8BHLfZIW0x26db5EZm5FitMkI8oHp9jWtrEEw2fAJxyAz4gVz+JG8sConBRREQGtILPacpm/5r/RnhBGu9ETVXzG2gwuv+fXN9XALqVDXSGvrjc1aeTtdbeKhWuedm4hNGPWTWZOxGbQciG8BMbx8lnT0fv5EcEZ7N5AVIXvmshYwUzuboKK/M7PdHKcY+jiOJV40N5HDPTsARUBnw9fE5vkked+sLkSFtcUB2Yh+A7i4auAo1NUZ5b4t1EUs3tSm7zUSqPdQtQ+Gd9hdE16fUA19sjaqBMPgS+buOo4uUXHwlJ7wWxzvoU0q7uNJbv7htQcXMLINjoSuklLvdnCvWZfmKEEARhOTM4ATezuqdwXFpqkvLpGyXmzaum+xsa3WfyyD5FDKP8bwQcnu6SMAEcUmxBW1szw0KAcqjifTtHKd+Sdz9Tg5PIPxVn2rSHYpv86cXlIt20GHO5wtZVMCf1yPT1IQ6nhegSLiDp0wXhscU0F7zOGg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(396003)(39860400002)(376002)(346002)(451199021)(82310400008)(46966006)(36840700001)(40470700004)(478600001)(7696005)(6666004)(1076003)(336012)(186003)(26005)(36756003)(16526019)(70586007)(2906002)(41300700001)(44832011)(6916009)(70206006)(316002)(5660300002)(8676002)(8936002)(82740400003)(356005)(81166007)(4326008)(86362001)(47076005)(36860700001)(426003)(83380400001)(40480700001)(2616005)(40460700003)(66899021)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2023 15:59:06.6651 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e6615dc-45fe-4b28-2398-08db86dec03d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT006.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4939
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
Cc: Samir Dhume <samir.dhume@amd.com>
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

