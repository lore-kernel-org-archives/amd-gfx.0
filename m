Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83928C6FD18
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Mar 2023 20:31:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 24E5A10EC5B;
	Wed, 29 Mar 2023 20:31:20 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2045.outbound.protection.outlook.com [40.107.94.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 652DB10E1B3
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Mar 2023 20:31:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jfzZLRsYGNuqwDTy/vZ2JncjFOvoLZUlv57wtFSwrrMwKqHanzbv+VmNI2Cp/IYf9BpGp2WfYLjofmtXwnyHHMlhuYWWpq1h0Nftw/zr3cRrdqoIf4CW7A6kSNBFAQ0dQlHg2rYl5rOywC5Yw+MMzqGndwSpYvlZG5l2PaOvf039fIvTKIL/R6b9q9O9UeTL3ZZQU98wCRuFjmEcAH3ko/ShiwqxDe636GqL8GNDmu/SrMtefcPxqkDNjn1KC/P8vFXGdfGeSp+KAIE9eN9J3McfKr0rBthAlCkeXz1XS4iuqFqepqtHcmdayAKTKTi7nnppCXN6yMimNtUY515tpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zZnZmu+p0mCSBbd/spQmKfBMUpcV5GJhpKNQWDpnzrE=;
 b=ljv1f1RvxCTsos3Tz4ELlKGd0DZAoVCkCmAfDr0Pe8/sLez7oQ+hThWC/mDOaQ6AbcGzZMi7+h8BRGM69bfTTq4NfsiQqSL/UBKQku5Bh1oFJ6kjZrGSSFq//9eKyOVfLN0tB5MvwH6P1TkRdX5I5Nmf7uvlxXcCWmwmIBWIbk8Jnf24oLspEMZvQxVviFxOjQZ2xcs6i7foohtLwMxoIuZDrQZsMtRQXn/V/aHjUJP5w5GUNQ6KqvtniU4ICMe5W152lAuKDVwXnCnC1exzJ/F9ycGqTzGAAfQxx/XcOql29nD5wwfrqz8Qu9P0xdbrX4BDhe1AQHI6BPQgw8Hagw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zZnZmu+p0mCSBbd/spQmKfBMUpcV5GJhpKNQWDpnzrE=;
 b=bWrgnT2Xpl37Y+PCd1BrVe5zuav1FortVLCQiWK6LYEM6t5Ufhk4dhv5RZMqhkKjHuwcmAuGjIx6JtwJnuNpZ2uQ7ayKSqjFmIdZH/tKErouhoIztmWhBf8Wo0ny3lQaTDIuqFdu5A+WiiRaJp4m8hZvsPc/EfuQqqPpSzPGDPM=
Received: from CY5PR13CA0024.namprd13.prod.outlook.com (2603:10b6:930::14) by
 BL0PR12MB4932.namprd12.prod.outlook.com (2603:10b6:208:1c2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.33; Wed, 29 Mar
 2023 20:31:11 +0000
Received: from CY4PEPF0000B8E8.namprd05.prod.outlook.com
 (2603:10b6:930:0:cafe::cf) by CY5PR13CA0024.outlook.office365.com
 (2603:10b6:930::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.18 via Frontend
 Transport; Wed, 29 Mar 2023 20:31:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000B8E8.mail.protection.outlook.com (10.167.241.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6277.7 via Frontend Transport; Wed, 29 Mar 2023 20:31:11 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 29 Mar
 2023 15:31:10 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/3] drm/amdgpu: implement smuio v13_0_3 callbacks
Date: Wed, 29 Mar 2023 16:30:08 -0400
Message-ID: <20230329203009.1983616-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230329203009.1983616-1-alexander.deucher@amd.com>
References: <20230329203009.1983616-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000B8E8:EE_|BL0PR12MB4932:EE_
X-MS-Office365-Filtering-Correlation-Id: bddc85a1-cd8a-40b2-266c-08db309488f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: saKdfdkkY8JZ7/prt/smbaXfkVo/mAGeyt84eAFJCyKzYd0v8++rH7FdAYLmtGMJXdPjttqOMuhr70VXNUhSfbNcUfG3PK3g0a+E4/fsyXJZ5G2hS+RfIfWNBkCWC3UmjOsYJubqtfNkUFjUedFiAnaL/VWDK5DzE7Ut8E/ZwSkabB2mF44VhgsgJ+jA6dQBRBiNE7Bn8B1Pea6zX7cOIb1t7sVE76M+sL4pNi1lwgA2K7l0Zod5TuCq6QOqznxRA5tVSm2DHipsRnPgnegMNkzOywOz60CwEroxHLJImUq6a7pMd8gF1bA+AoJhrIzgHpmvoXopQvXnQ7vvMnBLB2MS1+MJ/hyZZky6Z7qFonH2bp1yu5ura6rNmos5C960RHXF/qrOJl8wW2EXJ0QtQQVKnpswWHXL9tGCwqHs6l96yoyk+DO9M8fDIqznPdWz+qcgrLkakWZeLWO1nq2yBB2sqIWSyxZNiriei8/1U6u/JIfvVQzmUCyfJnesf6RipMUh2eYT9ZNuLeTI/dzQAG9LOgOqkkc9l+R0tNHg39xanJP4C3m+Phx6dUNzMU9l22RQbkYqCNR6Jp7EYE+nHtMLRLm88yt8fKUwGK2CAh7jBj1Jhx5ZWdIL1OMIPXir1lIvzCHf5rlAm3NL+33lULXWPXjgoOQ3qyzqh7YS6ZTfEWe50+G6sOhac+FI0bsFRzKGs/5yQqYIVDsuVSh8OR8N1O/yCzupVnjwlNV5qXw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(136003)(346002)(39860400002)(376002)(451199021)(40470700004)(36840700001)(46966006)(41300700001)(40460700003)(8676002)(70206006)(2906002)(6916009)(4326008)(16526019)(186003)(70586007)(36756003)(81166007)(426003)(82310400005)(336012)(47076005)(83380400001)(5660300002)(86362001)(82740400003)(356005)(36860700001)(40480700001)(2616005)(8936002)(478600001)(54906003)(7696005)(66899021)(26005)(1076003)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2023 20:31:11.2761 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bddc85a1-cd8a-40b2-266c-08db309488f1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000B8E8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4932
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
 Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>,
 Ori Messinger <Ori.Messinger@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>

Add smuio v13_0_3 callbacks for SMUIO.

Tested-by: Ori Messinger <Ori.Messinger@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Makefile        |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h    |   5 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_smuio.h  |   1 +
 drivers/gpu/drm/amd/amdgpu/smuio_v13_0_3.c | 103 +++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/smuio_v13_0_3.h |  28 ++++++
 5 files changed, 138 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/smuio_v13_0_3.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/smuio_v13_0_3.h

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index 90f771423c94..8418a90df493 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -205,6 +205,7 @@ amdgpu-y += \
 	smuio_v11_0.o \
 	smuio_v11_0_6.o \
 	smuio_v13_0.o \
+	smuio_v13_0_3.o \
 	smuio_v13_0_6.o
 
 # add reset block
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index 9c21792fbfc9..4995d9e16ee0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -66,6 +66,11 @@ enum amdgpu_gfx_partition {
 
 #define NUM_XCC(x) hweight16(x)
 
+enum amdgpu_pkg_type {
+	AMDGPU_PKG_TYPE_APU = 2,
+	AMDGPU_PKG_TYPE_UNKNOWN,
+};
+
 struct amdgpu_mec {
 	struct amdgpu_bo	*hpd_eop_obj;
 	u64			hpd_eop_gpu_addr;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_smuio.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_smuio.h
index c7a823f3f2c5..89c38d864471 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_smuio.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_smuio.h
@@ -30,6 +30,7 @@ struct amdgpu_smuio_funcs {
 	void (*get_clock_gating_state)(struct amdgpu_device *adev, u64 *flags);
 	u32 (*get_die_id)(struct amdgpu_device *adev);
 	u32 (*get_socket_id)(struct amdgpu_device *adev);
+	enum amdgpu_pkg_type (*get_pkg_type)(struct amdgpu_device *adev);
 	bool (*is_host_gpu_xgmi_supported)(struct amdgpu_device *adev);
 };
 
diff --git a/drivers/gpu/drm/amd/amdgpu/smuio_v13_0_3.c b/drivers/gpu/drm/amd/amdgpu/smuio_v13_0_3.c
new file mode 100644
index 000000000000..4368a5891eeb
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/smuio_v13_0_3.c
@@ -0,0 +1,103 @@
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
+#include "smuio_v13_0_3.h"
+#include "soc15_common.h"
+#include "smuio/smuio_13_0_3_offset.h"
+#include "smuio/smuio_13_0_3_sh_mask.h"
+
+#define PKG_TYPE_MASK		0x00000003L
+
+/**
+ * smuio_v13_0_3_get_die_id - query die id from FCH.
+ *
+ * @adev: amdgpu device pointer
+ *
+ * Returns die id
+ */
+static u32 smuio_v13_0_3_get_die_id(struct amdgpu_device *adev)
+{
+	u32 data, die_id;
+
+	data = RREG32_SOC15(SMUIO, 0, regSMUIO_MCM_CONFIG);
+	die_id = REG_GET_FIELD(data, SMUIO_MCM_CONFIG, DIE_ID);
+
+	return die_id;
+}
+
+/**
+ * smuio_v13_0_3_get_socket_id - query socket id from FCH
+ *
+ * @adev: amdgpu device pointer
+ *
+ * Returns socket id
+ */
+static u32 smuio_v13_0_3_get_socket_id(struct amdgpu_device *adev)
+{
+	u32 data, socket_id;
+
+	data = RREG32_SOC15(SMUIO, 0, regSMUIO_MCM_CONFIG);
+	socket_id = REG_GET_FIELD(data, SMUIO_MCM_CONFIG, SOCKET_ID);
+
+	return socket_id;
+}
+
+/**
+ * smuio_v13_0_3_get_pkg_type - query package type set by MP1/bootcode
+ *
+ * @adev: amdgpu device pointer
+ *
+ * Returns package type
+ */
+
+static enum amdgpu_pkg_type smuio_v13_0_3_get_pkg_type(struct amdgpu_device *adev)
+{
+	enum amdgpu_pkg_type pkg_type;
+	u32 data;
+
+	data = RREG32_SOC15(SMUIO, 0, regSMUIO_MCM_CONFIG);
+	data = REG_GET_FIELD(data, SMUIO_MCM_CONFIG, PKG_TYPE);
+	/* pkg_type[4:0]
+	 *
+	 * bit 1 == 1 APU form factor
+	 *
+	 * b0100 - b1111 - Reserved
+	 */
+	switch (data & PKG_TYPE_MASK) {
+	case 0x2:
+		pkg_type = AMDGPU_PKG_TYPE_APU;
+		break;
+	default:
+		pkg_type = AMDGPU_PKG_TYPE_UNKNOWN;
+		break;
+	}
+
+	return pkg_type;
+}
+
+
+const struct amdgpu_smuio_funcs smuio_v13_0_3_funcs = {
+	.get_die_id = smuio_v13_0_3_get_die_id,
+	.get_socket_id = smuio_v13_0_3_get_socket_id,
+	.get_pkg_type = smuio_v13_0_3_get_pkg_type,
+};
diff --git a/drivers/gpu/drm/amd/amdgpu/smuio_v13_0_3.h b/drivers/gpu/drm/amd/amdgpu/smuio_v13_0_3.h
new file mode 100644
index 000000000000..aec35f7efb58
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/smuio_v13_0_3.h
@@ -0,0 +1,28 @@
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
+#ifndef __SMUIO_V13_0_3_H__
+#define __SMUIO_V13_0_3_H__
+
+extern const struct amdgpu_smuio_funcs smuio_v13_0_3_funcs;
+
+#endif /* __SMUIO_V13_0_3_H__ */
-- 
2.39.2

