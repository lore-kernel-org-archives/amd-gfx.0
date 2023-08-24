Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39464C83003
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Aug 2023 21:32:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9435A10E5D5;
	Thu, 24 Aug 2023 21:32:01 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20611.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::611])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C5DC10E153
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Aug 2023 21:31:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BrtJ0BrUxyupPpulOYaPDY9RKfjHkpOkT0dfhu85GjXmPCv/mXeoI7z+blFzYr3qFEpnAhRNI2WRg0Z9XKZ1l2FT4/BXQWECjGPXDcqbCGLFfjXiEQ789fTYv6nWu1DK3wd5rM6GYZb+6Vdxa+3kFpR8nGk8MNd77CL45qWhfAnsAohW2rXQR7O95qXtW+ZoRzJS6/Xa06ncab4YcqfjYXz6cAzELA08TMhAU4PTMd/gp6zGRpwB5R3YEVu01vGC1BzDxzu6P551LERqJaYJbeiD75SinxphKkZ+o/9W0QfnJrdV1wq6Z5o9bN9gKYceWFQ9TEQ3c2wKFeySha1byw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KokyV2o+yMDDijssKMedxrpjnFjuS/Gi5lGegWZjQ/4=;
 b=KEw9mGoah/qgwSnvxMGhpaiN5b1cueIrfgvC+4LbO0+fwsoNnKZ5yAU8H7MP7/m0BxzuNwFdDEP62wYKIwAmk/C1nwicVE4g1H/mwdnBIy6ArOr9sufuvoh2R/+o5Pz0GafxP1YhUX1gE6I53RtiiSSMM5F/5GQs6AfTrsuBnloXrEQ+/6rGeO+IXH4xLdFa9GkTPIFo07mA5475q3pDotzPhGZwsu57Hb1PYTQBKw/gSEtx3l1QeWUTDiIjb/p6heQIpfRardEQSxgue21eUytmpEGcfpYfyZHP2vXvjA4o7Oqo1SAKmJpOEp08NWDVC6ONkMYanuqVkFsbDX0ZcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KokyV2o+yMDDijssKMedxrpjnFjuS/Gi5lGegWZjQ/4=;
 b=W4W8QeZzAoJ6EtIZyXZW/F3ZybsXecEZ5cUifKauzPA6B/TwbnRRwIjYTWHQfHNkvxheDNwtV7I2S1FqxFp7jMCx38WgThTz7lRy3Jx89A73fG75fM5fwYVl3ImpgZqO+nhRqK0emjM1RNYkNG6J7URBzQyBz1T9pUTxbhNynLc=
Received: from SJ0P220CA0026.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:41b::30)
 by BY5PR12MB4033.namprd12.prod.outlook.com (2603:10b6:a03:213::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Thu, 24 Aug
 2023 21:31:48 +0000
Received: from MWH0EPF000989EA.namprd02.prod.outlook.com
 (2603:10b6:a03:41b:cafe::d6) by SJ0P220CA0026.outlook.office365.com
 (2603:10b6:a03:41b::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27 via Frontend
 Transport; Thu, 24 Aug 2023 21:31:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989EA.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Thu, 24 Aug 2023 21:31:48 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 24 Aug
 2023 16:31:45 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 07/21] drm/amdgpu: add VPE firmware interface
Date: Thu, 24 Aug 2023 17:31:13 -0400
Message-ID: <20230824213127.2725850-7-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230824213127.2725850-1-alexander.deucher@amd.com>
References: <20230824213127.2725850-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EA:EE_|BY5PR12MB4033:EE_
X-MS-Office365-Filtering-Correlation-Id: b542571a-ab24-4910-c7d7-08dba4e985d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r/rrsifhQU8UKmQ1wBnFMnHgbZigSAs+5jq4gFI0cEpz5QxnB9UtGP8W/zf/bfbeEKFPlvQMMc1PClsuePMIMCJvDEKavbVX8PtDf3SIdqwadELe2ff6AafXAftXlXXhiJvWPbgFRVWgW5SATKj8hAxnISNiWWh5k3g3QN+WIAZdStooJyYbvhgLHnJ+8q09BqQPUlmWSdlgZgUVEoz8Mmt8n1AzvHiDuMaPnpwxz02sCyk7X15/KYgt+YU8Ke4xGUXQ+bqYxTOqhZXxkjeaxn/+SGqIpqx1R7ahrbkLV7smY2BA04wVsXDhXejQXAEk+5AdPmZOyYXfrot7qy91a+8L68g785FvcKVNKEOVOVOHP0OimRKFQOTwWqPzKu9SiZW8gf3EVPF7Q1Xx34cXmfJBqEFO2afyxKYWhq8e4eiZfSawZ5rWXxo3/9Z0xWseQ0B3dBAJ3onIkjuFAR9cGl5VozApOEPXMvNoQIOZm18fPoRGu/oP12CIR0h1k4XqwwR4cRFaT8JIsfmqwa0FLz29s3v+UbpuQJddtKDSejXKplc45uoOjTscEKSxn9c+N/s0cOLHP9arLH7MLqD+Uh9EILbEFElFTh2Cu+lRdFd/7XmS1TGGt3McxU2bcqDA9NhwKkKhUmJKdR6Dw6J1hxpxAx1gNGNB+Vz9QwkwttXVisYfgIcEe4l/bRJbOfhEOHnNg5qJcKKevgLrGHOSTGlIVZUC4zSU7x76e4J0rZqJbMjkLuqRIIzYfcECmjICDPWIFK9Kh+e0UIblx790DA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(39860400002)(396003)(136003)(346002)(82310400011)(186009)(1800799009)(451199024)(36840700001)(40470700004)(46966006)(1076003)(40460700003)(2616005)(66899024)(5660300002)(4326008)(8676002)(8936002)(336012)(47076005)(426003)(36756003)(83380400001)(7696005)(36860700001)(26005)(40480700001)(16526019)(82740400003)(356005)(6666004)(81166007)(70586007)(70206006)(54906003)(6916009)(316002)(478600001)(41300700001)(2906002)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2023 21:31:48.1275 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b542571a-ab24-4910-c7d7-08dba4e985d6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989EA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4033
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Huang Rui <ray.huang@amd.com>,
 Lang Yu <Lang.Yu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Lang Yu <Lang.Yu@amd.com>

Add initial firmware interface. (Ray)
Add more opcodes and rename to vpe_v6_1. (Lang)

v2: Update copyright date (Alex)

Signed-off-by: Huang Rui <ray.huang@amd.com>
Signed-off-by: Lang Yu <Lang.Yu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vpe_6_1_fw_if.h | 217 +++++++++++++++++++++
 1 file changed, 217 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/vpe_6_1_fw_if.h

diff --git a/drivers/gpu/drm/amd/amdgpu/vpe_6_1_fw_if.h b/drivers/gpu/drm/amd/amdgpu/vpe_6_1_fw_if.h
new file mode 100644
index 000000000000..9b550deb48d3
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/vpe_6_1_fw_if.h
@@ -0,0 +1,217 @@
+/* Copyright 2023 Advanced Micro Devices, Inc.
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
+#ifndef __VPE_6_1_FW_IF_H_
+#define __VPE_6_1_FW_IF_H_
+
+/****************
+ * VPE OP Codes
+ ****************/
+enum VPE_CMD_OPCODE {
+    VPE_CMD_OPCODE_NOP          = 0x0,
+    VPE_CMD_OPCODE_VPE_DESC     = 0x1,
+    VPE_CMD_OPCODE_PLANE_CFG    = 0x2,
+    VPE_CMD_OPCODE_VPEP_CFG     = 0x3,
+    VPE_CMD_OPCODE_INDIRECT     = 0x4,
+    VPE_CMD_OPCODE_FENCE        = 0x5,
+    VPE_CMD_OPCODE_TRAP         = 0x6,
+    VPE_CMD_OPCODE_REG_WRITE    = 0x7,
+    VPE_CMD_OPCODE_POLL_REGMEM  = 0x8,
+    VPE_CMD_OPCODE_COND_EXE     = 0x9,
+    VPE_CMD_OPCODE_ATOMIC       = 0xA,
+    VPE_CMD_OPCODE_PLANE_FILL   = 0xB,
+    VPE_CMD_OPCODE_TIMESTAMP    = 0xD
+};
+
+/** Generic Command Header
+ * Generic Commands include:
+ *  Noop, Fence, Trap,
+ *  RegisterWrite, PollRegisterWriteMemory,
+ *  SetLocalTimestamp, GetLocalTimestamp
+ *  GetGlobalGPUTimestamp */
+#define VPE_HEADER_SUB_OPCODE__SHIFT    8
+#define VPE_HEADER_SUB_OPCODE_MASK      0x0000FF00
+#define VPE_HEADER_OPCODE__SHIFT        0
+#define VPE_HEADER_OPCODE_MASK          0x000000FF
+
+#define VPE_CMD_HEADER(op, subop) \
+    (((subop << VPE_HEADER_SUB_OPCODE__SHIFT) & VPE_HEADER_SUB_OPCODE_MASK) | \
+     ((op << VPE_HEADER_OPCODE__SHIFT) & VPE_HEADER_OPCODE_MASK))
+
+
+ /***************************
+  * VPE NOP
+  ***************************/
+#define VPE_CMD_NOP_HEADER_COUNT__SHIFT    16
+#define VPE_CMD_NOP_HEADER_COUNT_MASK      0x00003FFF
+
+#define VPE_CMD_NOP_HEADER_COUNT(count) \
+     (((count) & VPE_CMD_NOP_HEADER_COUNT_MASK) << VPE_CMD_NOP_HEADER_COUNT__SHIFT)
+
+ /***************************
+  * VPE Descriptor
+  ***************************/
+#define VPE_DESC_CD__SHIFT          16
+#define VPE_DESC_CD_MASK            0x000F0000
+
+#define VPE_DESC_CMD_HEADER(cd) \
+    (VPE_CMD_HEADER(VPE_CMD_OPCODE_VPE_DESC, 0) | \
+     (((cd) << VPE_DESC_CD__SHIFT) & VPE_DESC_CD_MASK))
+
+ /***************************
+  * VPE Plane Config
+  ***************************/
+enum VPE_PLANE_CFG_SUBOP {
+    VPE_PLANE_CFG_SUBOP_1_TO_1 = 0x0,
+    VPE_PLANE_CFG_SUBOP_2_TO_1 = 0x1,
+    VPE_PLANE_CFG_SUBOP_2_TO_2 = 0x2
+};
+
+#define VPE_PLANE_CFG_ONE_PLANE     0
+#define VPE_PLANE_CFG_TWO_PLANES    1
+
+#define VPE_PLANE_CFG_NPS0__SHIFT   16
+#define VPE_PLANE_CFG_NPS0_MASK     0x00030000
+
+#define VPE_PLANE_CFG_NPD0__SHIFT   18
+#define VPE_PLANE_CFG_NPD0_MASK     0x000C0000
+
+#define VPE_PLANE_CFG_NPS1__SHIFT   20
+#define VPE_PLANE_CFG_NPS1_MASK     0x00300000
+
+#define VPE_PLANE_CFG_NPD1__SHIFT   22
+#define VPE_PLANE_CFG_NPD1_MASK     0x00C00000
+
+#define VPE_PLANE_CFG_TMZ__SHIFT    16
+#define VPE_PLANE_CFG_TMZ_MASK      0x00010000
+
+#define VPE_PLANE_CFG_SWIZZLE_MODE__SHIFT   3
+#define VPE_PLANE_CFG_SWIZZLE_MODE_MASK     0x000000F8
+
+#define VPE_PLANE_CFG_ROTATION__SHIFT       0
+#define VPE_PLANE_CFG_ROTATION_MASK         0x00000003
+
+#define VPE_PLANE_ADDR_LO__SHIFT        0
+#define VPE_PLANE_ADDR_LO_MASK          0xFFFFFF00
+
+#define VPE_PLANE_CFG_PITCH__SHIFT      0
+#define VPE_PLANE_CFG_PITCH_MASK        0x00003FFF
+
+#define VPE_PLANE_CFG_VIEWPORT_Y__SHIFT 16
+#define VPE_PLANE_CFG_VIEWPORT_Y_MASK   0x3FFF0000
+#define VPE_PLANE_CFG_VIEWPORT_X__SHIFT 0
+#define VPE_PLANE_CFG_VIEWPORT_X_MASK   0x00003FFF
+
+
+#define VPE_PLANE_CFG_VIEWPORT_HEIGHT__SHIFT 16
+#define VPE_PLANE_CFG_VIEWPORT_HEIGHT_MASK   0x1FFF0000
+#define VPE_PLANE_CFG_VIEWPORT_ELEMENT_SIZE__SHIFT  13
+#define VPE_PLANE_CFG_VIEWPORT_ELEMENT_SIZE_MASK    0x0000E000
+#define VPE_PLANE_CFG_VIEWPORT_WIDTH__SHIFT 0
+#define VPE_PLANE_CFG_VIEWPORT_WIDTH_MASK   0x00001FFF
+
+enum VPE_PLANE_CFG_ELEMENT_SIZE {
+    VPE_PLANE_CFG_ELEMENT_SIZE_8BPE     = 0,
+    VPE_PLANE_CFG_ELEMENT_SIZE_16BPE    = 1,
+    VPE_PLANE_CFG_ELEMENT_SIZE_32BPE    = 2,
+    VPE_PLANE_CFG_ELEMENT_SIZE_64BPE    = 3
+};
+
+#define VPE_PLANE_CFG_CMD_HEADER(subop, nps0, npd0, nps1, npd1) \
+    (VPE_CMD_HEADER(VPE_CMD_OPCODE_PLANE_CFG, subop) | \
+     (((nps0) << VPE_PLANE_CFG_NPS0__SHIFT) & VPE_PLANE_CFG_NPS0_MASK) | \
+     (((npd0) << VPE_PLANE_CFG_NPD0__SHIFT) & VPE_PLANE_CFG_NPD0_MASK) | \
+     (((nps1) << VPE_PLANE_CFG_NPS1__SHIFT) & VPE_PLANE_CFG_NPS1_MASK) | \
+     (((npd0) << VPE_PLANE_CFG_NPD1__SHIFT) & VPE_PLANE_CFG_NPD1_MASK))
+
+
+/************************
+ * VPEP Config
+ ************************/
+enum VPE_VPEP_CFG_SUBOP {
+    VPE_VPEP_CFG_SUBOP_DIR_CFG = 0x0,
+    VPE_VPEP_CFG_SUBOP_IND_CFG = 0x1
+};
+
+
+// Direct Config Command Header
+#define VPE_DIR_CFG_HEADER_ARRAY_SIZE__SHIFT    16
+#define VPE_DIR_CFG_HEADER_ARRAY_SIZE_MASK      0xFFFF0000
+
+#define VPE_DIR_CFG_CMD_HEADER(subop, arr_sz) \
+    (VPE_CMD_HEADER(VPE_CMD_OPCODE_VPEP_CFG, subop) | \
+     (((arr_sz) << VPE_DIR_CFG_HEADER_ARRAY_SIZE__SHIFT) & VPE_DIR_CFG_HEADER_ARRAY_SIZE_MASK))
+
+
+#define VPE_DIR_CFG_PKT_REGISTER_OFFSET__SHIFT  2
+#define VPE_DIR_CFG_PKT_REGISTER_OFFSET_MASK    0x000FFFFC
+
+#define VPE_DIR_CFG_PKT_DATA_SIZE__SHIFT        20
+#define VPE_DIR_CFG_PKT_DATA_SIZE_MASK          0xFFF00000
+
+
+// InDirect Config Command Header
+#define VPE_IND_CFG_HEADER_NUM_DST__SHIFT   28
+#define VPE_IND_CFG_HEADER_NUM_DST_MASK     0xF0000000
+
+#define VPE_IND_CFG_CMD_HEADER(subop, num_dst) \
+    (VPE_CMD_HEADER(VPE_CMD_OPCODE_VPEP_CFG, subop) | \
+     (((num_dst) << VPE_IND_CFG_HEADER_NUM_DST__SHIFT) & VPE_IND_CFG_HEADER_NUM_DST_MASK))
+
+// Indirect Buffer Command Header
+#define VPE_CMD_INDIRECT_HEADER_VMID__SHIFT   16
+#define VPE_CMD_INDIRECT_HEADER_VMID_MASK     0x0000000F
+#define VPE_CMD_INDIRECT_HEADER_VMID(vmid) \
+     (((vmid) & VPE_CMD_INDIRECT_HEADER_VMID_MASK) << VPE_CMD_INDIRECT_HEADER_VMID__SHIFT)
+
+
+/**************************
+ * Poll Reg/Mem Sub-OpCode
+ **************************/
+enum VPE_POLL_REGMEM_SUBOP {
+    VPE_POLL_REGMEM_SUBOP_REGMEM = 0x0,
+    VPE_POLL_REGMEM_SUBOP_REGMEM_WRITE = 0x1
+};
+
+#define VPE_CMD_POLL_REGMEM_HEADER_FUNC__SHIFT   28
+#define VPE_CMD_POLL_REGMEM_HEADER_FUNC_MASK     0x00000007
+#define VPE_CMD_POLL_REGMEM_HEADER_FUNC(func) \
+     (((func) & VPE_CMD_POLL_REGMEM_HEADER_FUNC_MASK) << VPE_CMD_POLL_REGMEM_HEADER_FUNC__SHIFT)
+
+#define VPE_CMD_POLL_REGMEM_HEADER_MEM__SHIFT   31
+#define VPE_CMD_POLL_REGMEM_HEADER_MEM_MASK     0x00000001
+#define VPE_CMD_POLL_REGMEM_HEADER_MEM(mem) \
+     (((mem) & VPE_CMD_POLL_REGMEM_HEADER_MEM_MASK) << VPE_CMD_POLL_REGMEM_HEADER_MEM__SHIFT)
+
+#define VPE_CMD_POLL_REGMEM_DW5_INTERVAL__SHIFT   0
+#define VPE_CMD_POLL_REGMEM_DW5_INTERVAL_MASK     0x0000FFFF
+#define VPE_CMD_POLL_REGMEM_DW5_INTERVAL(interval) \
+     (((interval) & VPE_CMD_POLL_REGMEM_DW5_INTERVAL_MASK) << VPE_CMD_POLL_REGMEM_DW5_INTERVAL__SHIFT)
+
+#define VPE_CMD_POLL_REGMEM_DW5_RETRY_COUNT__SHIFT   16
+#define VPE_CMD_POLL_REGMEM_DW5_RETRY_COUNT_MASK     0x00000FFF
+#define VPE_CMD_POLL_REGMEM_DW5_RETRY_COUNT(count) \
+     (((count) & VPE_CMD_POLL_REGMEM_DW5_RETRY_COUNT_MASK) << VPE_CMD_POLL_REGMEM_DW5_RETRY_COUNT__SHIFT)
+
+#endif
-- 
2.41.0

