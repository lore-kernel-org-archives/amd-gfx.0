Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B3DBC07545
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Oct 2023 06:42:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 253AD10E2E0;
	Tue, 24 Oct 2023 06:42:06 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2061b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::61b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C789F10E2E0
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Oct 2023 06:42:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aFqQxW8CuI0Vj+18GukJzRCdj318GXmNyjKcK+iXOe2th7XKyLgHT9F11OKe/vpbBke5+PzphlK0/OsGOADV1SQEe9SsapKBnaGAAfP3J9q50lbCw0Lf8efP2efgIU7OxxqKUwdQn+MOwsau04pZLNNkBUcJxLXoTpR1qzz/nv7AhjZSyZQ6lPzCszNJ/QzjVSDuPCXLVTE/7XkASh69bEOW9E2iAH2rd5lTqAAIk9Tl+PP3DYjGrPki9fwWhs9wbq2FDiomxecC867e7bqFc7eu+IMbVJCsiaOUH0bC4pKXYRp8KuBDWGOFfHN5srT+yt53PBUDE2EvBmU8ElaHZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UXOCE6s6A7xnhwkR7OiKB42ZCp5LmtvrIL1JLD/baB4=;
 b=cvoC19UppVWiJpS4PALBiPGOm13xSZEA5J/0w2l03dsKLFILPNzhwLDUoC/WriMYteTh6QT6sv16kByji9US520GWp3XiCJaRzuGtdFNpeHqYpPMfgTVEsNJBEGqPSA1zXsZzVYRwJ4uZGuUxIxfFSJ0VEdp087cNXy3gBJVhieHw2123ErDTQ0PUpjlu4NBoHeDelmYhQE/tR6HLo7ew6H1N07ZyOBSadpIQ4jUaxbDG3hmFLtheHnFQXOP/Iaae8BSygIHP2WNHjQMsOxlag/nXos94Idsa1oWfrrZx0axkOt6drS+yBdyqm2L+ts3rUwyOfGrPHE5daU8Y7zSFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UXOCE6s6A7xnhwkR7OiKB42ZCp5LmtvrIL1JLD/baB4=;
 b=WsWF4IU+K64Woi+6vuLxSIEPcZ0JzguC7oPdwEMuLt4VG+2K1rTOizebM/Vxvt+MvxzAv4SZZe+58Z5QKV8chYTGETD5Asl4dUwF6s5I/cMMMhiv4kR8HNjZ9sMnDh1dxXWO900i/796Xw6y7tNcNouPjY5l2wZdB5E49Zwq8e4=
Received: from CY5PR19CA0073.namprd19.prod.outlook.com (2603:10b6:930:69::18)
 by DM4PR12MB5913.namprd12.prod.outlook.com (2603:10b6:8:66::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Tue, 24 Oct
 2023 06:41:57 +0000
Received: from CY4PEPF0000E9D1.namprd03.prod.outlook.com
 (2603:10b6:930:69:cafe::9) by CY5PR19CA0073.outlook.office365.com
 (2603:10b6:930:69::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.34 via Frontend
 Transport; Tue, 24 Oct 2023 06:41:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D1.mail.protection.outlook.com (10.167.241.144) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6933.15 via Frontend Transport; Tue, 24 Oct 2023 06:41:57 +0000
Received: from taozhou1u2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 24 Oct
 2023 01:41:55 -0500
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: get RAS poison status from DF v4_6_2
Date: Tue, 24 Oct 2023 14:41:35 +0800
Message-ID: <20231024064135.2070-1-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D1:EE_|DM4PR12MB5913:EE_
X-MS-Office365-Filtering-Correlation-Id: de2f5d22-7619-4c99-5179-08dbd45c5176
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YP7G2Jihmmgnn8g+z4425ehfntCU7NU2tWRcLbT+xDrE1ue4xJ5u/52MyyJILqKtKAVS10r5wg3CZdQH7jeKZXWu41OB0Tt5NwJ7txHADUzVYN5W8sPMllXoxuD+PhWDmvFWBetaupn34S4ARbZ+OkZpmLdmm5PrSQqADcdpMBWUBedIeWQ4OGgW+KwPLEkz98woAlG+plmPrwVdSK0O4vZpz1TZ+8aFUD36OD+ltpaf/fT+E/WXO+k//AIlrU5F1X42x8VkwQZRsIVM8ZgEqrIJEhevIo+bSfRBSMWc1dtXPtUYSxTjcy/PUD2IjyD+xZiTdN4htXrQ5dTL8GSCRwcSYQ8gwLDyAqb+RW3l2RbfkgEUKCE2cpoofFlcK0EvGc3rVCL71b8PeUQGAMuWpOupqVGXZUGNEzpl0Lw1NQMZC7vnsiEel8nOqgvLwKOd3Gur6YtE1SgCtFhedakNjllEjKS8rP6ICM+Jg1lPKvprQsO8dzbiwJ0YH5RCwJ9yi+T+HxBDK7PvDtx5qGFssR1IkeDeI0lOJMR7/B6FKkiMwCVteOBpBRe55ued9s0phC5AJrt6caa2ledDNLhd6s8lrZKZn71HZQnXxuBA+Ii07TtckHGfKXK2umTfE7FU/64nKO6wJO6nsJmPRA0vsu5BAXfNUVTb7Nlej7/xxdQnNV8b0/GRuqttOY7GKnWfoPilPcxrFjy0bH2eqecQ/N/vbiWzFtnV9FDbFSthP+XakN9RNPG+LApX/bI/T7zfm/tjIj9pLtueK043f8S9Og==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(39860400002)(346002)(396003)(136003)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(82310400011)(36840700001)(46966006)(40470700004)(86362001)(40460700003)(2906002)(36860700001)(70206006)(54906003)(81166007)(70586007)(316002)(6916009)(82740400003)(7696005)(16526019)(478600001)(2616005)(1076003)(356005)(47076005)(40480700001)(336012)(426003)(83380400001)(4326008)(41300700001)(36756003)(5660300002)(8676002)(6666004)(8936002)(26005)(66899024)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2023 06:41:57.0908 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: de2f5d22-7619-4c99-5179-08dbd45c5176
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5913
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
Cc: Tao Zhou <tao.zhou1@amd.com>, "Stanley . Yang" <Stanley.Yang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add DF block and RAS poison mode query for DF v4_6_2.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
Reviewed-by: Stanley.Yang <Stanley.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Makefile           |  3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |  4 +++
 drivers/gpu/drm/amd/amdgpu/df_v4_6_2.c        | 34 +++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/df_v4_6_2.h        | 31 +++++++++++++++++
 4 files changed, 71 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/df_v4_6_2.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/df_v4_6_2.h

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index ec1daf7112a9..260e32ef7bae 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -104,7 +104,8 @@ amdgpu-y += \
 amdgpu-y += \
 	df_v1_7.o \
 	df_v3_6.o \
-	df_v4_3.o
+	df_v4_3.o \
+	df_v4_6_2.o
 
 # add GMC block
 amdgpu-y += \
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 17d4311e22d5..8d3681172cea 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -35,6 +35,7 @@
 #include "df_v1_7.h"
 #include "df_v3_6.h"
 #include "df_v4_3.h"
+#include "df_v4_6_2.h"
 #include "nbio_v6_1.h"
 #include "nbio_v7_0.h"
 #include "nbio_v7_4.h"
@@ -2557,6 +2558,9 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 	case IP_VERSION(4, 3, 0):
 		adev->df.funcs = &df_v4_3_funcs;
 		break;
+	case IP_VERSION(4, 6, 2):
+		adev->df.funcs = &df_v4_6_2_funcs;
+		break;
 	default:
 		break;
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/df_v4_6_2.c b/drivers/gpu/drm/amd/amdgpu/df_v4_6_2.c
new file mode 100644
index 000000000000..a47960a0babd
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/df_v4_6_2.c
@@ -0,0 +1,34 @@
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
+#include "df_v4_6_2.h"
+
+static bool df_v4_6_2_query_ras_poison_mode(struct amdgpu_device *adev)
+{
+	/* return true since related regs are inaccessible */
+	return true;
+}
+
+const struct amdgpu_df_funcs df_v4_6_2_funcs = {
+	.query_ras_poison_mode = df_v4_6_2_query_ras_poison_mode,
+};
diff --git a/drivers/gpu/drm/amd/amdgpu/df_v4_6_2.h b/drivers/gpu/drm/amd/amdgpu/df_v4_6_2.h
new file mode 100644
index 000000000000..3bc3e6d216e2
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/df_v4_6_2.h
@@ -0,0 +1,31 @@
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
+#ifndef __DF_V4_6_2_H__
+#define __DF_V4_6_2_H__
+
+#include "soc15_common.h"
+
+extern const struct amdgpu_df_funcs df_v4_6_2_funcs;
+
+#endif
-- 
2.35.1

