Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3D8BC43217
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Feb 2022 16:59:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E22B710E2BC;
	Fri, 18 Feb 2022 16:59:23 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2046.outbound.protection.outlook.com [40.107.93.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8238510EE72
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Feb 2022 16:59:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AYHW2nLTngLK28YJOu8LSbPCGOiEORNFyRW23SJ7bTZRdocKe/XlbIwumN8F/AJo4PtrQz3hnvHH/2jt886w6Lc4LOFwqfhdRWIzYaL8AjLqnmcU9or3oR9zZjO/l7HaDeiMASBLJS30+jI1ETqKFfGXEo3XEouzRaCRcH1Ef8kjmXWMpnDgf4BglSoaWq3Oi8L1N/XbSSuJlqQYxEhMigmTs3h5H8zHRT5B5d18AGHUXvxJzWqUDE/MNb8asucWb4b1bfQMjByJEhJ5Cc0Uuu5jB6y5M7KLd2+A7q0h+KvcRPFNVUPIPA1kvH+X473oQSy9KHn78zDE4N8QKZuS7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iMaSdG0rqa28iWQY+WQ8s+GjbUNUt6ZlkPm1mrtR2A0=;
 b=bZlXTNtjR5iaN4fPP7dEnBlZ/Ti0fLsDxj9BSKL6yNXnobxKnNWEjtRffKi3dMCQxr8EuzTxyf1c7ms8q+gIG+Z1F1O+hQBo9M0hCuR8O2BrvhFrfL/3YLTyqv9LETjbd0AdpBGr62CKKj0DaUBq+tcDH1lqrXbuR0Kx5/bJOWzZRiLvhSttifoOugfjLX4/+y06y43sQ5eV/p5BlUnOCLrdiDDlwCVDYVEssER7SukBOhD5ckRCT16jPj/lxIgojw8hYzlRArW7KJBQR/RuO08nx+Dz+07g/OKa5aBdOWRuvzmfNw1BGqroyPOwEiM9Xg9Ipe/tpYUDuxe3Ef+dfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iMaSdG0rqa28iWQY+WQ8s+GjbUNUt6ZlkPm1mrtR2A0=;
 b=DNpXwC9K7TdzcHBF15sP5LCLGXLjrRyBNsmVcbQMVXmEWIBif86xhCV/xm6qUhdVLOQOCYyec0ikPxA/1TVkO/WNJZXnBUqcWKjtKgctiOvHJNP+4c+cUyw8WwHh3650OJa2zFzm4jK6S+OJ+5ectdKHeT+AuB6RtpzQWeACaXw=
Received: from MW4PR04CA0335.namprd04.prod.outlook.com (2603:10b6:303:8a::10)
 by BYAPR12MB3095.namprd12.prod.outlook.com (2603:10b6:a03:a9::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.15; Fri, 18 Feb
 2022 16:59:13 +0000
Received: from CO1NAM11FT019.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8a:cafe::f8) by MW4PR04CA0335.outlook.office365.com
 (2603:10b6:303:8a::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16 via Frontend
 Transport; Fri, 18 Feb 2022 16:59:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT019.mail.protection.outlook.com (10.13.175.57) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4995.15 via Frontend Transport; Fri, 18 Feb 2022 16:59:13 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 18 Feb
 2022 10:59:10 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 07/13] drm/amd/display: Add DCN315 DMUB
Date: Fri, 18 Feb 2022 11:58:48 -0500
Message-ID: <20220218165854.1417733-6-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220218165854.1417733-1-alexander.deucher@amd.com>
References: <20220218165854.1417733-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8dc32445-86d2-4115-7f71-08d9f2fffdb3
X-MS-TrafficTypeDiagnostic: BYAPR12MB3095:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB309599119B2D20966401DD55F7379@BYAPR12MB3095.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Cjpd5RyYIEIHyq3+KP3dWsdkMe3TJNxjYSWFqbKZvsPvCR1Ah34G9I41+plJnsPUAquMAzZE0nV+8iPtB+P6FOUgTCAsHAcawS7xV/nVeUPubXo3DbfaufbUy67tfO3bDd9WKprTXVWj7mdLWzMwxRoisgzlSPBkwR8otFxCFLf8NpR/tnk2BRILscRNtt+I7EzGd8MJBqbcCbHooTnOkNAl6wphSnmK7gQY7VORyF1rV6OdcEccH6gt/gKJ3pwNiKdh3PW00V+IFCPlwNaV4JWlKusFd50XBZfIa7weP50lzATIzAolPRQEggqZSVz3dCRGEJn7XCm7gjbj/az5udKrn3YdaHldCHUrsAVULlhSTILgmB45NmELZBR84Nc2TJvMYS20DogML1bM6JiQ90vzFA5ORCjCUj/TiVpKu4Xl0xQ3+h7cOZaeMSK4Iow/rWrOHAbprew7zZyiD6za1CLAXnwOQWmldDAsSFbdR6s2pT3sZCF8Vblb1MTSWtlx+fL2Ln2+O9sw4kgS+4Mh8RJyvRr4XhAeyzwOjn2TlmgBa8Vc5V4BWcjxJZpcRLcNjeS9pY3P5NEz97c2YtfkdIZBbmvtxYlevqbWyCXqlLkaqbUYdIOeT+JLTpLQ+TnlFPfObFfHXDd9iDOVe882AgdjYu9QYthLnFrITV0siF2lhhw3fpc2cY3NJwUMCopSB6X3AeoTGSZEqRdx5rHsRg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(356005)(36860700001)(47076005)(81166007)(82310400004)(7696005)(6666004)(8936002)(36756003)(508600001)(2906002)(316002)(54906003)(426003)(4326008)(8676002)(186003)(16526019)(1076003)(86362001)(83380400001)(40460700003)(70206006)(26005)(2616005)(6916009)(5660300002)(336012)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2022 16:59:13.4742 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dc32445-86d2-4115-7f71-08d9f2fffdb3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT019.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3095
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Qingqing Zhuo <qingqing.zhuo@amd.com>, Harry Wentland <Harry.Wentland@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Qingqing Zhuo <qingqing.zhuo@amd.com>

Add support for the DMUB firmware for DCN 3.1.5.

Signed-off-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Acked-by: Harry Wentland <Harry.Wentland@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h   |  1 +
 drivers/gpu/drm/amd/display/dmub/src/Makefile |  4 +-
 .../drm/amd/display/dmub/src/dmub_dcn315.c    | 62 +++++++++++++++++
 .../drm/amd/display/dmub/src/dmub_dcn315.h    | 68 +++++++++++++++++++
 .../gpu/drm/amd/display/dmub/src/dmub_srv.c   |  9 ++-
 5 files changed, 139 insertions(+), 5 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn315.c
 create mode 100644 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn315.h

diff --git a/drivers/gpu/drm/amd/display/dmub/dmub_srv.h b/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
index 821d3fb1f824..56757a286a03 100644
--- a/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
+++ b/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
@@ -98,6 +98,7 @@ enum dmub_asic {
 	DMUB_ASIC_DCN303,
 	DMUB_ASIC_DCN31,
 	DMUB_ASIC_DCN31B,
+	DMUB_ASIC_DCN315,
 	DMUB_ASIC_DCN316,
 	DMUB_ASIC_MAX,
 };
diff --git a/drivers/gpu/drm/amd/display/dmub/src/Makefile b/drivers/gpu/drm/amd/display/dmub/src/Makefile
index 21e818862072..856c7f48de7a 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/Makefile
+++ b/drivers/gpu/drm/amd/display/dmub/src/Makefile
@@ -22,9 +22,7 @@
 
 DMUB = dmub_srv.o dmub_srv_stat.o dmub_reg.o dmub_dcn20.o dmub_dcn21.o
 DMUB += dmub_dcn30.o dmub_dcn301.o dmub_dcn302.o dmub_dcn303.o
-
-DMUB += dmub_dcn31.o
-DMUB += dmub_dcn316.o
+DMUB += dmub_dcn31.o dmub_dcn315.o dmub_dcn316.o
 
 AMD_DAL_DMUB = $(addprefix $(AMDDALPATH)/dmub/src/,$(DMUB))
 
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn315.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn315.c
new file mode 100644
index 000000000000..4dbb15c898aa
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn315.c
@@ -0,0 +1,62 @@
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
+ * Authors: AMD
+ *
+ */
+
+#include "../dmub_srv.h"
+#include "dmub_reg.h"
+#include "dmub_dcn315.h"
+
+#include "dcn/dcn_3_1_5_offset.h"
+#include "dcn/dcn_3_1_5_sh_mask.h"
+
+#define DCN_BASE__INST0_SEG0                       0x00000012
+#define DCN_BASE__INST0_SEG1                       0x000000C0
+#define DCN_BASE__INST0_SEG2                       0x000034C0
+#define DCN_BASE__INST0_SEG3                       0x00009000
+#define DCN_BASE__INST0_SEG4                       0x02403C00
+#define DCN_BASE__INST0_SEG5                       0
+
+#define BASE_INNER(seg) DCN_BASE__INST0_SEG##seg
+#define CTX dmub
+#define REGS dmub->regs_dcn31
+#define REG_OFFSET_EXP(reg_name) (BASE(reg##reg_name##_BASE_IDX) + reg##reg_name)
+
+/* Registers. */
+
+const struct dmub_srv_dcn31_regs dmub_srv_dcn315_regs = {
+#define DMUB_SR(reg) REG_OFFSET_EXP(reg),
+	{
+		DMUB_DCN31_REGS()
+		DMCUB_INTERNAL_REGS()
+	},
+#undef DMUB_SR
+
+#define DMUB_SF(reg, field) FD_MASK(reg, field),
+	{ DMUB_DCN315_FIELDS() },
+#undef DMUB_SF
+
+#define DMUB_SF(reg, field) FD_SHIFT(reg, field),
+	{ DMUB_DCN315_FIELDS() },
+#undef DMUB_SF
+};
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn315.h b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn315.h
new file mode 100644
index 000000000000..0049ae96aa7e
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn315.h
@@ -0,0 +1,68 @@
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
+ * Authors: AMD
+ *
+ */
+
+#ifndef _DMUB_DCN315_H_
+#define _DMUB_DCN315_H_
+
+#include "dmub_dcn31.h"
+
+#define DMUB_DCN315_FIELDS() \
+	DMUB_SF(DMCUB_CNTL, DMCUB_ENABLE) \
+	DMUB_SF(DMCUB_CNTL, DMCUB_TRACEPORT_EN) \
+	DMUB_SF(DMCUB_CNTL2, DMCUB_SOFT_RESET) \
+	DMUB_SF(DMCUB_SEC_CNTL, DMCUB_SEC_RESET) \
+	DMUB_SF(DMCUB_SEC_CNTL, DMCUB_MEM_UNIT_ID) \
+	DMUB_SF(DMCUB_SEC_CNTL, DMCUB_SEC_RESET_STATUS) \
+	DMUB_SF(DMCUB_REGION3_CW0_TOP_ADDRESS, DMCUB_REGION3_CW0_TOP_ADDRESS) \
+	DMUB_SF(DMCUB_REGION3_CW0_TOP_ADDRESS, DMCUB_REGION3_CW0_ENABLE) \
+	DMUB_SF(DMCUB_REGION3_CW1_TOP_ADDRESS, DMCUB_REGION3_CW1_TOP_ADDRESS) \
+	DMUB_SF(DMCUB_REGION3_CW1_TOP_ADDRESS, DMCUB_REGION3_CW1_ENABLE) \
+	DMUB_SF(DMCUB_REGION3_CW2_TOP_ADDRESS, DMCUB_REGION3_CW2_TOP_ADDRESS) \
+	DMUB_SF(DMCUB_REGION3_CW2_TOP_ADDRESS, DMCUB_REGION3_CW2_ENABLE) \
+	DMUB_SF(DMCUB_REGION3_CW3_TOP_ADDRESS, DMCUB_REGION3_CW3_TOP_ADDRESS) \
+	DMUB_SF(DMCUB_REGION3_CW3_TOP_ADDRESS, DMCUB_REGION3_CW3_ENABLE) \
+	DMUB_SF(DMCUB_REGION3_CW4_TOP_ADDRESS, DMCUB_REGION3_CW4_TOP_ADDRESS) \
+	DMUB_SF(DMCUB_REGION3_CW4_TOP_ADDRESS, DMCUB_REGION3_CW4_ENABLE) \
+	DMUB_SF(DMCUB_REGION3_CW5_TOP_ADDRESS, DMCUB_REGION3_CW5_TOP_ADDRESS) \
+	DMUB_SF(DMCUB_REGION3_CW5_TOP_ADDRESS, DMCUB_REGION3_CW5_ENABLE) \
+	DMUB_SF(DMCUB_REGION3_CW6_TOP_ADDRESS, DMCUB_REGION3_CW6_TOP_ADDRESS) \
+	DMUB_SF(DMCUB_REGION3_CW6_TOP_ADDRESS, DMCUB_REGION3_CW6_ENABLE) \
+	DMUB_SF(DMCUB_REGION3_CW7_TOP_ADDRESS, DMCUB_REGION3_CW7_TOP_ADDRESS) \
+	DMUB_SF(DMCUB_REGION3_CW7_TOP_ADDRESS, DMCUB_REGION3_CW7_ENABLE) \
+	DMUB_SF(DMCUB_REGION4_TOP_ADDRESS, DMCUB_REGION4_TOP_ADDRESS) \
+	DMUB_SF(DMCUB_REGION4_TOP_ADDRESS, DMCUB_REGION4_ENABLE) \
+	DMUB_SF(DMCUB_REGION5_TOP_ADDRESS, DMCUB_REGION5_TOP_ADDRESS) \
+	DMUB_SF(DMCUB_REGION5_TOP_ADDRESS, DMCUB_REGION5_ENABLE) \
+	DMUB_SF(CC_DC_PIPE_DIS, DC_DMCUB_ENABLE) \
+	DMUB_SF(MMHUBBUB_SOFT_RESET, DMUIF_SOFT_RESET) \
+	DMUB_SF(DCN_VM_FB_LOCATION_BASE, FB_BASE) \
+	DMUB_SF(DCN_VM_FB_OFFSET, FB_OFFSET) \
+	DMUB_SF(DMCUB_INBOX0_WPTR, DMCUB_INBOX0_WPTR) \
+	DMUB_SF(DMCUB_INTERRUPT_ENABLE, DMCUB_GPINT2_INT_EN) \
+	DMUB_SF(DMCUB_INTERRUPT_ACK, DMCUB_GPINT2_INT_ACK)
+
+extern const struct dmub_srv_dcn31_regs dmub_srv_dcn315_regs;
+
+#endif /* _DMUB_DCN315_H_ */
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
index db2802a14f95..66db5e538c7f 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
@@ -32,6 +32,7 @@
 #include "dmub_dcn302.h"
 #include "dmub_dcn303.h"
 #include "dmub_dcn31.h"
+#include "dmub_dcn315.h"
 #include "dmub_dcn316.h"
 #include "os_types.h"
 /*
@@ -221,10 +222,14 @@ static bool dmub_srv_hw_setup(struct dmub_srv *dmub, enum dmub_asic asic)
 
 	case DMUB_ASIC_DCN31:
 	case DMUB_ASIC_DCN31B:
+	case DMUB_ASIC_DCN315:
 	case DMUB_ASIC_DCN316:
-		dmub->regs_dcn31 = &dmub_srv_dcn31_regs;
-		if (asic == DMUB_ASIC_DCN316)
+		if (asic == DMUB_ASIC_DCN315)
+			dmub->regs_dcn31 = &dmub_srv_dcn315_regs;
+		else if (asic == DMUB_ASIC_DCN316)
 			dmub->regs_dcn31 = &dmub_srv_dcn316_regs;
+		else
+			dmub->regs_dcn31 = &dmub_srv_dcn31_regs;
 		funcs->reset = dmub_dcn31_reset;
 		funcs->reset_release = dmub_dcn31_reset_release;
 		funcs->backdoor_load = dmub_dcn31_backdoor_load;
-- 
2.35.1

