Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E758C433FE
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Apr 2022 15:28:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 917BE10F5DD;
	Wed, 27 Apr 2022 15:28:12 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2077.outbound.protection.outlook.com [40.107.243.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 66FC110F5DD
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Apr 2022 15:28:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kJ1PHmTKd06DcXqeG1a2N1dYQf04UMcwZt5V7Xz5npxbvBFcj2nnu45zznbC5sCyrDeJIbUyXTLkBikLzmRxVwG2duMMNbfmvUT5Ku7Tv2uvCCPeUSshcaNTv6HmXFYw4yj/kiBA4V7r4GEHP65QxT8UjNvy5k0ejMetrcn1ZG5ZlVwPMwZV9FLAsAQnhbh79+mufi6eL9NZo7oCK4kO8ziq7cMSYdGFK6Raa3eD+2a+oMfEd0vrpBQev1ek2uWYJkdnFoWFw89sp5IO4E9iiQethdSQ/iLzdumyGKiBhkoOUAac8oSoFbYx8+MRk2w6sjSXg/mUw/cphMDleimquw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sLLwl86OlXm4FpL1bGkwX5XcDfvJWdsKcjZBxudw8TM=;
 b=baHEdslqD59JTLRQY5i1iru1uIkw8rgIkP0I1EDYJjdoa2C5Nk7fnK1L+k9J6o3X/pOsUfrJeQx2nxY/BKEkcZuXzBM7Ql83xc3Yv5628I3DVFlpxaZzApnmD5eO/MUZA4V6fFIEWn634JRRhbQ7KTfPr+gOVkggd4JSB9YveI080nIKvzzJWGgsUo+A1Gxzmteu7dEZ/BRJPfEtGAnJmTQhpK45rCVoMqY4IujmEw6eB6SMjQs4lcyPv4Tn2YqsPwA8rLjMwp+XKVKM7vjUa4e80yrefZ1RwsFVOzcwfadYtGLJA0iSHm3VWaGtg/XoeOU0fWKYrCHy3te3SGPccQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sLLwl86OlXm4FpL1bGkwX5XcDfvJWdsKcjZBxudw8TM=;
 b=5ukz+fatQCHjmnSrWlzSvRzc4Lpfw1Y/5X8u+mgEouaL3MEteDhdWLRAT1fdF9uslOJoJJ1pX3Bk0j8+tOdnimQv0Ou9O9lpBFTUXyyN1E2PbUSvy6TMH1QKYXpD1x5yTIRbax6JgM4b0UXpX8a3IJaGYGprCcDNj3z7L5Njr5o=
Received: from MW4PR04CA0227.namprd04.prod.outlook.com (2603:10b6:303:87::22)
 by DS7PR12MB6142.namprd12.prod.outlook.com (2603:10b6:8:9a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.18; Wed, 27 Apr
 2022 15:28:07 +0000
Received: from CO1NAM11FT063.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:87:cafe::69) by MW4PR04CA0227.outlook.office365.com
 (2603:10b6:303:87::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15 via Frontend
 Transport; Wed, 27 Apr 2022 15:28:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT063.mail.protection.outlook.com (10.13.175.37) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Wed, 27 Apr 2022 15:28:07 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 27 Apr
 2022 10:28:05 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/3] drm/amdgpu: add smuio v13_0_6 support
Date: Wed, 27 Apr 2022 11:27:52 -0400
Message-ID: <20220427152753.3107794-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220427152753.3107794-1-alexander.deucher@amd.com>
References: <20220427152753.3107794-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d0e915bf-2e48-4385-a5cd-08da286287d1
X-MS-TrafficTypeDiagnostic: DS7PR12MB6142:EE_
X-Microsoft-Antispam-PRVS: <DS7PR12MB61423ED33027D1E1DF6CD8FCF7FA9@DS7PR12MB6142.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G30t3+eIM8OHEke1EwxGNVJZ318ZvE6BB+J+vi2doNwD1CZBNn9vLWOlWPK8OMSdoLEwu25jI5YTarp3Dg/RtAyN8TEUfXgE9m1muRhSeBrx5JHv2vu3CXNuUOU6yIMCtZiN50Ui1S8niNcvJ2z75YmokfifsmNQVQBBobtz/sLN6IKleow+0rt9QAWvh6+hReVHIPw0XbEMcm7TRTf6E1HyxP1XFpVWuBz9GY/a7FJZtc6KTSfcg8fgDMqqqT/Jw2B/SHGpG55XfP3WOhJpkFx6xAgxH/IETSNdAdqqFKu1CNkVgg/3kmXoleVNYCPkJtfJyEODodZDkyN/i/CE0T26IkmorfhLmGPNyrFMr/OJVWzhhfzQwBXxw8KpyuJlPaQL5YSW9/pkVNOQ6Q9QRu6zHZbzosRKpKVUeKW2i8NYwZkjv6w8FS7SF6sTnsgC7taNGRVkMzSzzH1xYjuQaoicgBqgVJgUkGdhBqqzql0gIb3/C3yef7hUIBP3AkzjWhAIw43Ro8U1+KZbUq253SdrBlJxiGR/MoVsLJu8u+jCRoouc7Heg38rBX9S6ojn8chbGxdV92S7waII9/m+nJktBPTTeC3JgaBO200IEoZJxxY5QaZYl9Soq2FTz+TpgS2Hk7+sz+DMQwcwyNWQ81rKpBwIQBIt01JQ8oi0zZ7bRqR9BPA740SIX5BcHK0+XA261Qz9uzHnINK03VbSNQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(16526019)(6666004)(2906002)(83380400001)(336012)(508600001)(86362001)(1076003)(36756003)(26005)(186003)(426003)(2616005)(70206006)(82310400005)(4326008)(8676002)(81166007)(36860700001)(356005)(40460700003)(7696005)(54906003)(8936002)(6916009)(316002)(5660300002)(47076005)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2022 15:28:07.5197 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d0e915bf-2e48-4385-a5cd-08da286287d1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT063.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6142
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Lijo Lazar <lijo.lazar@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Hawking Zhang <Hawking.Zhang@amd.com>

add smuio v13_0_6 callbacks to support read
rom image

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Makefile        |  3 +-
 drivers/gpu/drm/amd/amdgpu/smuio_v13_0_6.c | 41 ++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/smuio_v13_0_6.h | 30 ++++++++++++++++
 3 files changed, 73 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/smuio_v13_0_6.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/smuio_v13_0_6.h

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index b10ba2b36ca9..6097ad614937 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -183,7 +183,8 @@ amdgpu-y += \
 	smuio_v9_0.o \
 	smuio_v11_0.o \
 	smuio_v11_0_6.o \
-	smuio_v13_0.o
+	smuio_v13_0.o \
+	smuio_v13_0_6.o
 
 # add reset block
 amdgpu-y += \
diff --git a/drivers/gpu/drm/amd/amdgpu/smuio_v13_0_6.c b/drivers/gpu/drm/amd/amdgpu/smuio_v13_0_6.c
new file mode 100644
index 000000000000..de998e328b08
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/smuio_v13_0_6.c
@@ -0,0 +1,41 @@
+/*
+ * Copyright 2022 Advanced Micro Devices, Inc.
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
+#include "smuio_v13_0_6.h"
+#include "smuio/smuio_13_0_6_offset.h"
+#include "smuio/smuio_13_0_6_sh_mask.h"
+
+static u32 smuio_v13_0_6_get_rom_index_offset(struct amdgpu_device *adev)
+{
+	return SOC15_REG_OFFSET(SMUIO, 0, regROM_INDEX);
+}
+
+static u32 smuio_v13_0_6_get_rom_data_offset(struct amdgpu_device *adev)
+{
+	return SOC15_REG_OFFSET(SMUIO, 0, regROM_DATA);
+}
+
+const struct amdgpu_smuio_funcs smuio_v13_0_6_funcs = {
+	.get_rom_index_offset = smuio_v13_0_6_get_rom_index_offset,
+	.get_rom_data_offset = smuio_v13_0_6_get_rom_data_offset,
+};
diff --git a/drivers/gpu/drm/amd/amdgpu/smuio_v13_0_6.h b/drivers/gpu/drm/amd/amdgpu/smuio_v13_0_6.h
new file mode 100644
index 000000000000..c75621de5ab5
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/smuio_v13_0_6.h
@@ -0,0 +1,30 @@
+/*
+ * Copyright 2022 Advanced Micro Devices, Inc.
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
+#ifndef __SMUIO_V13_0_6_H__
+#define __SMUIO_V13_0_6_H__
+
+#include "soc15_common.h"
+
+extern const struct amdgpu_smuio_funcs smuio_v13_0_6_funcs;
+
+#endif /* __SMUIO_V13_0_6_H__ */
-- 
2.35.1

