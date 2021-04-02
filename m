Return-Path: <SRS0=/zhQ=I7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6629EC43460
	for <amd-gfx@archiver.kernel.org>; Fri,  2 Apr 2021 06:43:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14BB3610CB
	for <amd-gfx@archiver.kernel.org>; Fri,  2 Apr 2021 06:43:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14BB3610CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6CD416EE05;
	Fri,  2 Apr 2021 06:43:58 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2048.outbound.protection.outlook.com [40.107.244.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A27856EE05
 for <amd-gfx@lists.freedesktop.org>; Fri,  2 Apr 2021 06:43:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HEzD4sIFn5Lm9HLpM+F/Z5+jDOcvhor2qbdCEHYGoFIbnOBggVoHwxKWJQnaEoWB6nY1HdpufNNCT18Xo7nX0jtQB1K2Jlc/BhV2pYWGUkJuGYYcXEwgf/L8WZEZO3b9o84qa0QXi18yU2E+udmCeRfc/SX1DsFLNwBYo4U3/aUbk04DEHNxYat+QCqpZ0YEXNLHfHWBgfHfzgUxgWHP8c5PfheUMw+/7FnxrgVTWyU3wcuYItccNL6msOygEd+fOcB0gn3lcF29fl94HtOXl/noNK9Q+Kgjmo2BI9LRNmWT2RVp6fMRPI0drdrspCd/4H5JJCjHQJmm2KiV+6qTmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O1bTRsYdh2waVpZdWlD76TYncAJtBn5ToGprwket1IM=;
 b=HrUEVlGbsxfwKw2ak78+bTowagOv10F+TNWREDW7MqekJ21wAWrWLe7dwwcvnt3J6KQs5/0SQlDoEH5Wf/vtPTUJyZBQmtOnJ/mGTeztA80t6SVXdqutpARuWqaKrSXpXqaQpOwWt7AYvkZnNi6fkc8Pn6Q8uDbNZX8vDzQmN4TKil8UOFT6qSvgqDSKS+VCoyPOEapKQtLE83TTGd4coFd4QQkOB7LvBSzYJrqvJZ+xu/LltyPWPGTkSM0FN/Ri5VZlUho5uLR7jiVO4lIaeKznYLxnP6IjW6WQUYjJogIG+36UrzHgbpCkNJ5Xa0sx53dMkGKULn4eh/8NwDb3kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O1bTRsYdh2waVpZdWlD76TYncAJtBn5ToGprwket1IM=;
 b=IH7ES2O7g4mILLdru8URu69ynmRXJF5iBTr5G3LU+2W6PgFY92fqhQLeTlDby7kY6GLFneCY7mLBNI4nB41H3ScHuCdfb0h1tMxC9/FIm8jkRbdURPogIc8KCajghluTyfVFpX8rgYRNNpkzFJEgFWlqFsQQnyvqqbM8fd4Kz78=
Received: from DM6PR13CA0072.namprd13.prod.outlook.com (2603:10b6:5:134::49)
 by DM6PR12MB3020.namprd12.prod.outlook.com (2603:10b6:5:11f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.29; Fri, 2 Apr
 2021 06:43:55 +0000
Received: from DM6NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:134:cafe::8b) by DM6PR13CA0072.outlook.office365.com
 (2603:10b6:5:134::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.8 via Frontend
 Transport; Fri, 2 Apr 2021 06:43:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT018.mail.protection.outlook.com (10.13.172.110) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3999.28 via Frontend Transport; Fri, 2 Apr 2021 06:43:55 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Fri, 2 Apr 2021
 01:43:54 -0500
Received: from hawzhang-System-Product-Dev.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2106.2
 via Frontend Transport; Fri, 2 Apr 2021 01:43:53 -0500
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, John Clements <John.Clements@amd.com>,
 Dennis Li <Dennis.Li@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 02/11] drm/amdgpu: create umc_v6_7_funcs for aldebaran
Date: Fri, 2 Apr 2021 14:43:36 +0800
Message-ID: <20210402064345.14093-2-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210402064345.14093-1-Hawking.Zhang@amd.com>
References: <20210402064345.14093-1-Hawking.Zhang@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 75db7048-1ccc-4e05-d707-08d8f5a2afd6
X-MS-TrafficTypeDiagnostic: DM6PR12MB3020:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3020BD09A0CEA3EA4FA66A71FC7A9@DM6PR12MB3020.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PIo8JesqbFtbIA19H7XQU982iWmD4HpQUCVumYvvx3d0xUyN64QRoYlWD48zb+d3MoNnNTZ0xtqDKpFM6q4gKT7paS5ZQmlkiTq74DWpr/nC4+VuXf/XAs2MRH/xzvHegVCbUmTro9ZA9qi9k2gqiIG66TOzBv8q88Xrj75qXgXTduLJj3If1XQo9gLgAU5lg0QycJfhZ0muPFobSddq3kkBMt9PqBif/NYzboRtYf+Z7nj5fj7i3i2RpjxxFvUrF6+LU/WRfOTNXnvxAzsTsxdfm+TDcadmC5K44AH210IUuzjMJNoiAJ+UXx8xkKJHNtV9K1kJ15XOlhQ/fCv3quIMv3zb67/weC/EORk2bcSqvdBQU5f+Yr8graAf4gcd7RCOZ3CdKXR4lDvwBM1JdcSnxE5ejyGzBfXgobJLv180pfwfm8SI81WV26ofp0/8Xi+vGE7PFqJbx2gmu0B3URQvF+cLEgkM1UiPpvC94fEoP3JfiF1GCotntQLQ7+BQZ+NR7rU2WeWewcxnt2DNDlzgHp0BgN07EOL43r2M88QFZgmgiFjKrkbJaFTGddEoPaKm1o2TghoBQ8olKQUu+tAINQBD0WjqbPbpS0UBhIq+tgRO7IPZpPRcYp0C0TssT6juPecAL/nUhz9FfG1hXFynZr8fDYuD6zNRRPmvG5x9GtrTNPaeNPk+lOj3xZ/0
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(376002)(39860400002)(136003)(396003)(36840700001)(46966006)(5660300002)(8936002)(2616005)(36756003)(70586007)(426003)(110136005)(7696005)(316002)(70206006)(478600001)(26005)(47076005)(4326008)(336012)(82740400003)(81166007)(2906002)(8676002)(86362001)(1076003)(83380400001)(82310400003)(186003)(36860700001)(6666004)(6636002)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2021 06:43:55.5565 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 75db7048-1ccc-4e05-d707-08d8f5a2afd6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3020
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
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

umc_v6_7_funcs are callbacks to support umc ras
functionalities in aldebaran

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: John Clements <John.Clements@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Makefile   |  2 +-
 drivers/gpu/drm/amd/amdgpu/umc_v6_7.c | 29 +++++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/umc_v6_7.h | 28 ++++++++++++++++++++++++++
 3 files changed, 58 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/umc_v6_7.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/umc_v6_7.h

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index 42153638a55c..ee85e8aba636 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -88,7 +88,7 @@ amdgpu-y += \
 
 # add UMC block
 amdgpu-y += \
-	umc_v6_1.o umc_v6_0.o umc_v8_7.o
+	umc_v6_0.o umc_v6_1.o umc_v6_7.o umc_v8_7.o
 
 # add IH block
 amdgpu-y += \
diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c b/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c
new file mode 100644
index 000000000000..37aa1cf6b2ef
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c
@@ -0,0 +1,29 @@
+/*
+ * Copyright 2021 Advanced Micro Devices, Inc.
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
+#include "umc_v6_7.h"
+#include "amdgpu_ras.h"
+#include "amdgpu.h"
+
+const struct amdgpu_umc_funcs umc_v6_7_funcs = {
+	.ras_late_init = amdgpu_umc_ras_late_init,
+};
diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v6_7.h b/drivers/gpu/drm/amd/amdgpu/umc_v6_7.h
new file mode 100644
index 000000000000..8c2ce694ec89
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v6_7.h
@@ -0,0 +1,28 @@
+/*
+ * Copyright 2021 Advanced Micro Devices, Inc.
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
+#ifndef __UMC_V6_7_H__
+#define __UMC_V6_7_H__
+
+extern const struct amdgpu_umc_funcs umc_v6_7_funcs;
+
+#endif
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
