Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30E9DC54E5D
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Mar 2024 20:43:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D7551120A2;
	Mon, 18 Mar 2024 20:43:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UvWqtKxG";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2073.outbound.protection.outlook.com [40.107.223.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C9B3E11209D
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Mar 2024 20:43:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N9TQIKKVW+X1Ri2DMoe+9/irLc9P5F1yy2fqh6bux8A7sfXPVXaiNBTLXXRwf4UgyAZ+xEuLdMDCKyR7pqO1WhW4k038uZmU3PJQGkDHQBE7qOhtXv4UGwJ8caXOiOJdPwG0q4o5X8lPVY1buBOk/fIgGsihkxeZaLIikbntPRwgQxSnatvDhKRz4bmIOchK+O95ZLWDnzQr9kZZ4ktOM2enCGRZFjKb8ROnZty0Sl4ojvCbnemDTEshpbKpq9hbufCTxwSnn7LhmbnlxSGvTFdbj+TARVQFbU8Fgcgo0+HEFy7a9QPOZzqiULn0W86Qb1ADVKDgunI++oKYUw2ypw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MTLaVSFKC1fFxWDzI+rktWO35S4nSNEMMhIGM8lV9l8=;
 b=SLQJjbAlIFtUhst+lH2kayYA5/mAcc+MAN+TEcJBM5YSL6K6IWMC0w8J7O9OKnRKkVrj6zb1hFfLH1zJbjKSfTkcU/cCAtpIv8GzMfFyBImBHQ87GpcXDutlFycoApTph8Fa1kaN4/kF95CMnH/ZfVHiMZn+8wg/MC4dSXl9IHk6u8J8h/HBH1TTX1uG1zxSGi6efkLWIipjR4RY1kz9td3Dfj4/AIsh/+znFo5a5ky4Q6zjli2C0SwLKOgZMyAfdInmvlSjuncAIPdhNYtqyEtL6CX6r5HG3JRLiCmSpRGBX8FyqKOl8fZZymfIKdri03Pvdt0D0Bxwt/ID8TmTkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MTLaVSFKC1fFxWDzI+rktWO35S4nSNEMMhIGM8lV9l8=;
 b=UvWqtKxG5i01bC6YvHwTMF93KOjDFqRlSYlytaUH9g32Qa+Gk6ClqWz6NUO+xXAVQd3pMSMr8IaI4HFiV6YdBAfuY6LeETFBe3Abl0nPQwRSIK1mVmXxEt0TlOO7qGTnJApapeh5DqNjsY6VRUDs09RvaNPNYKHwzx6LdLQUUyc=
Received: from BN9PR03CA0216.namprd03.prod.outlook.com (2603:10b6:408:f8::11)
 by CY5PR12MB6204.namprd12.prod.outlook.com (2603:10b6:930:23::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26; Mon, 18 Mar
 2024 20:43:14 +0000
Received: from BN2PEPF0000449F.namprd02.prod.outlook.com
 (2603:10b6:408:f8:cafe::cd) by BN9PR03CA0216.outlook.office365.com
 (2603:10b6:408:f8::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.27 via Frontend
 Transport; Mon, 18 Mar 2024 20:43:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF0000449F.mail.protection.outlook.com (10.167.243.150) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Mon, 18 Mar 2024 20:43:13 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 18 Mar
 2024 15:43:12 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Hawking Zhang <Hawking.Zhang@amd.com>, Likun Gao <Likun.Gao@amd.com>,
 "Alex Deucher" <alexander.deucher@amd.com>
Subject: [PATCH 2/4] drm/amdgpu: Add smuio v14_0_2 ip block support
Date: Mon, 18 Mar 2024 16:42:50 -0400
Message-ID: <20240318204252.144624-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240318204252.144624-1-alexander.deucher@amd.com>
References: <20240318204252.144624-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449F:EE_|CY5PR12MB6204:EE_
X-MS-Office365-Filtering-Correlation-Id: 11c72720-e1b9-4646-c806-08dc478c0831
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PAKW6dHkMRQj9E85Yv3pseXrpkt1davc5V6YEytB68N5RZcw+VHbCH1Fns62zm6pymEyKhGZeqVhhqFRidTdtczngE0XzE+pj8LDRJnpribrkO0PV18+v/9qHdimnORS3cFoFr47NffU0ZGzhb0HBn6iE2twJj+xUtCkElBwLZdfr98ay+suSpoS6DetTL7bi3ytesKQvLnv8h3f/HgmfQaVQ3Eq9wO6qkHvDN2DdjhMwftVsfFQrgIYnlfaB57jnJl1/tJ/UlNsM0l/1RpXPZaierfrB/PfVTKm+WPXaZCpyX7SxZKojN2i2rbmXafghKgdz7pgnoIXciUb8j+ZTr0oIQOknQrSNKdWXH95NAViJ8ZJClzcBKwBeAfr2ciBo8slqoj5at3b2p+lS7KUsXO34Ll255QQfffEeaslbJ42PwsnGey4yeywUlEsYuXT+IXmjMsOnutSKinXbE4rL6m5sCNMMwdWoNn1FSehcsVkoPlhefq+Md/9euX1vIlb/7BjDCfTxxYeLaRft+zYeP6fzxpQtqR2H+RE2c2CwezAX4urdoojGboOUWJr2ZX4Y/kgXihNEOcciWKT5a0yxHEOCf50Tvx9b9kDtum+JHIeDwAqY2LbCQRl/VpQpMwI00yDm3NCcCM1vfIR9rxHq85kXbC3bhPjQ8sHGTepDw+g438XFiq+c4sQlZ9dwt5dBogxaU13NDQuZ+KNWzRKaS5Fpjs0q1MbfrJX6ygY0wKCg5EweCb2yqmDUlJdL2Ed
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(1800799015)(36860700004)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2024 20:43:13.6991 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 11c72720-e1b9-4646-c806-08dc478c0831
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000449F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6204
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

From: Hawking Zhang <Hawking.Zhang@amd.com>

Add smuio v14_0_2 ip block support

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Likun Gao <Likun.Gao@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Makefile        |  3 +-
 drivers/gpu/drm/amd/amdgpu/smuio_v14_0_2.c | 41 ++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/smuio_v14_0_2.h | 30 ++++++++++++++++
 3 files changed, 73 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/smuio_v14_0_2.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/smuio_v14_0_2.h

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index 4536c8ad0e11..61237f50893b 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -247,7 +247,8 @@ amdgpu-y += \
 	smuio_v11_0_6.o \
 	smuio_v13_0.o \
 	smuio_v13_0_3.o \
-	smuio_v13_0_6.o
+	smuio_v13_0_6.o \
+	smuio_v14_0_2.o
 
 # add reset block
 amdgpu-y += \
diff --git a/drivers/gpu/drm/amd/amdgpu/smuio_v14_0_2.c b/drivers/gpu/drm/amd/amdgpu/smuio_v14_0_2.c
new file mode 100644
index 000000000000..7b7cca220b26
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/smuio_v14_0_2.c
@@ -0,0 +1,41 @@
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
+#include "amdgpu.h"
+#include "smuio_v14_0_2.h"
+#include "smuio/smuio_14_0_2_offset.h"
+#include "smuio/smuio_14_0_2_sh_mask.h"
+
+static u32 smuio_v14_0_2_get_rom_index_offset(struct amdgpu_device *adev)
+{
+	return SOC15_REG_OFFSET(SMUIO, 0, regROM_INDEX);
+}
+
+static u32 smuio_v14_0_2_get_rom_data_offset(struct amdgpu_device *adev)
+{
+	return SOC15_REG_OFFSET(SMUIO, 0, regROM_DATA);
+}
+
+const struct amdgpu_smuio_funcs smuio_v14_0_2_funcs = {
+	.get_rom_index_offset = smuio_v14_0_2_get_rom_index_offset,
+	.get_rom_data_offset = smuio_v14_0_2_get_rom_data_offset,
+};
diff --git a/drivers/gpu/drm/amd/amdgpu/smuio_v14_0_2.h b/drivers/gpu/drm/amd/amdgpu/smuio_v14_0_2.h
new file mode 100644
index 000000000000..6e617f832d90
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/smuio_v14_0_2.h
@@ -0,0 +1,30 @@
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
+#ifndef __SMUIO_V14_0_2_H__
+#define __SMUIO_V14_0_2_H__
+
+#include "soc15_common.h"
+
+extern const struct amdgpu_smuio_funcs smuio_v14_0_2_funcs;
+
+#endif /* __SMUIO_V14_0_2_H__ */
-- 
2.44.0

