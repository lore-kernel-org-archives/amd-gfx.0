Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EA6ECFA466
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Nov 2025 15:23:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D14D10E2EB;
	Mon, 24 Nov 2025 15:23:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="a78I8zi3";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012051.outbound.protection.outlook.com
 [40.107.200.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 44EFF10E2EB
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Nov 2025 15:23:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Eb7q7SgxtMc1iCpiaGzIFaPIqG/HFgKZWpRdozZG3/bjUGBqglWTJEs8E8L8NFQDir/sHAYeQVpPJj3Xi8JnIUIHmdifwQ7lwsK0QKHAUi3N3l94fFrb+WeWFooangjHUs6hbxuTuHfE59efPMbjOJwHbCn+qC1J4Zh7LsUzE0A+IiwWsHgscfxsK17HSSl9qV4vXE5G8Lkz+lUtZ7wJePV596vU7H5inj5nV3Lg1u4uxIGblHmdeQGtO0m34op2dJMoTvrGG+oTIlTEQQ4MEu4T0FVy5QXuBBNc9WXawAtjkNUuZgMbZTCRRXwZVMXF4DuW+l4zp+HpUtjsPgaDnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wGKHBhs+qpUIBkLf45vJKWhD7C3FOz3XeHnYY2oTAOU=;
 b=HgVxxEWXXCiR/Klw5kd/dudCUJhd0xmpGpR4vJH0Cr10xJSMv+Oe1Q2N6ULr4B8ublB1ZTTWKRSMbhfrHZBxo2d7KZp8ixjEYxnNpjkjcXP0HS0V9iML2oc2lP3k2vyZCJFVkHbK1P3K16dTP3/Xm2g2NsjorRfjvOh1Nxd+7EoP8rhbGaFvVmyL5LXxFXWMndI6Gwio0KHUudf1qISQT8Gq11yEvjk4p512XffjuY7VyElxolylhKwHs72uGTvfwcjO/2512Rqjvka+MSDRYtbmAZcSZSylZVd+iJDkB3agUz3S7tJfOV17pdFYZhTOHO/heP74ZcobpYCbhq2mfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wGKHBhs+qpUIBkLf45vJKWhD7C3FOz3XeHnYY2oTAOU=;
 b=a78I8zi34vsu0YTfwyH5sUCUiOTKJyiJWssb2CFD5ZsHQJwMtCy3aNjEZ/gcAQ0dtuNHu3Y21V6NAHmU8b3u0jbJ4AoYtPrQzcaSVfLEn3zs3ZtBGr28uh9Rd10wYtD/cLr+0S9wDkyqjfe0b8pJaiSSlGq96BQIRyC/bbPV2kM=
Received: from LV3P220CA0008.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:234::31)
 by DS2PR12MB9592.namprd12.prod.outlook.com (2603:10b6:8:27c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Mon, 24 Nov
 2025 15:23:22 +0000
Received: from BL02EPF00021F68.namprd02.prod.outlook.com
 (2603:10b6:408:234:cafe::3d) by LV3P220CA0008.outlook.office365.com
 (2603:10b6:408:234::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.17 via Frontend Transport; Mon,
 24 Nov 2025 15:23:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF00021F68.mail.protection.outlook.com (10.167.249.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Mon, 24 Nov 2025 15:23:21 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 24 Nov
 2025 09:23:20 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Likun Gao <Likun.Gao@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>,
 Mukul Joshi <mukul.joshi@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: create pm4 header for gc v12_1
Date: Mon, 24 Nov 2025 10:23:08 -0500
Message-ID: <20251124152308.428908-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.51.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F68:EE_|DS2PR12MB9592:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ce5fa05-0bfe-4a14-67b4-08de2b6d673f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?GXn2BjHcDuGJVzzcAnnyMGRZ7q4A9kvD0CSZeb5fLy4ScdvNWjH+3iT4rt1B?=
 =?us-ascii?Q?94ohC4edSHpzEeNtCOqJNqy4yqKx0PLuZ7OJYxCIZfD3N3Nu9Sr5bzC2C1Fc?=
 =?us-ascii?Q?FSa0KxAzGjynLLhdrls12ICjX0Qc1+h4hOXMXH5m9taL8n2pWYtYIaHQSl/Y?=
 =?us-ascii?Q?HIriNZBFfmwYeqjX4mWgtaR7Lrj/tioyPAjlJfCvgczYw987nW/F1NK17klO?=
 =?us-ascii?Q?4XBKapRc8vaUR2uBKXmKsp+lEqI1ZS5KPRsoW1k6OElhopyeY9Q4xhi7T3IH?=
 =?us-ascii?Q?4Tig/Yfvi4iPMjwVGJP+3inDmnJWU1dqe7G/64o9qQB6Aexrca71yfQx9SDc?=
 =?us-ascii?Q?ZWpHnB7CtGPmzZwcPfEbjsGgTp2G2FkEoAPLl92AjH9yqda9AEXGtLT344M/?=
 =?us-ascii?Q?o250RJGEqeoAVGTV5V/w9OPImMhukhPWFPHIp9yBFLtL+Zx/V8L3UKQxYWZ0?=
 =?us-ascii?Q?/4rLKOjEZt3uSFdVmHqZELvJRRg/4aQeLx3JrVBJQ0ODdbO1az8NZfmwqpaQ?=
 =?us-ascii?Q?zHP088pT2W+057KU98QIqk8r6ek7bz2PGc7Jw93r4aoNRL67CSDKvHPmsTrf?=
 =?us-ascii?Q?MbmKjVB2gldVUZft+/Eh1mK9xwgYwgIEA5KDGMcIXyPXESAvWnXPFL7UZQV8?=
 =?us-ascii?Q?WgZ1BqihH+mwEn1lN6orpBNpEK7B511SDFJZkuQqABRu1QPYQuxuokknUb86?=
 =?us-ascii?Q?ElMs48voh/ySbVK/D9IdGq80Lq++VfYAdxU0cBwg5XPsJqhDd4cbde5vpAXo?=
 =?us-ascii?Q?vxrPcQ47hOTbcef34YM/ve8HFBMPFcD7/jAZYzzUf4feJ8zZNzbWMaqP9Raf?=
 =?us-ascii?Q?JBHf+PVMsgLaU2UEPcbTilKZ+Ow9THXJK4qZPFmGNB2WSMf+JFOAsManGvDT?=
 =?us-ascii?Q?X6M0gJ4jw/P/nhlnNSv9rgxV47nY8LVExuVoXT7WZdBvofgna67M78EWfOKn?=
 =?us-ascii?Q?n/4FmXscT0S3jTLOTFHC+RLgEf8QZAvVuxK1aGfSzlpnrD+90TWaHhBOf8nO?=
 =?us-ascii?Q?bQoBAfsK/qPZL3QWBzRo0uW7+fEXDlXLIBEqAJPpxZvr7FkOuMEM0cC8Lv6F?=
 =?us-ascii?Q?MJ9xF9+9WFIRwm544RUtXPWVt3ff6z4h8BrvlOGtvpAHuIz3Sbi1ARvDDm35?=
 =?us-ascii?Q?+62ghC6XpuMXzDjwV5mR3CV7dm8TsVGoXjVp6GcJnAspFHinGufLFlbl1gmy?=
 =?us-ascii?Q?/MhDF42IzFVVf14vwvErNnuqMpd96xHIwu9pms0fGgpsVF4AkTRDvWtct13l?=
 =?us-ascii?Q?QppI4yQcfdFCttxZbkMI4DGxHBD47RODPTZTT/qfHrd3nKyudouKuGsGd9zq?=
 =?us-ascii?Q?FpVySQsVQIUaLkPVto9dpDPrgX7NnPe+/MDa3zdBCZyy31sb43Bijtgd/hXD?=
 =?us-ascii?Q?kIr+upt3P+rgf46BqeYJZdN3AOU4S4xP41w/rcKrL4hJgNUNz5bV2Qlen2SL?=
 =?us-ascii?Q?t+KtdmY2wJUZcrGoeuyA6vHQsGIDFwDkxvSSr2tA9W2+Kx2tvOm+EdKogtVu?=
 =?us-ascii?Q?itT1tJGGOvzqSeLMucdjQPzahqzx8Pdr87CB/9AGCsvDjbLLx8wTHk4gJizZ?=
 =?us-ascii?Q?eAJJjzQlgCQNkx3nm6w=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2025 15:23:21.6393 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ce5fa05-0bfe-4a14-67b4-08de2b6d673f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F68.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9592
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

From: Likun Gao <Likun.Gao@amd.com>

Duplicated from nvd.h.
Update Release MEM and Acquire MEM pkt header.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Mukul Joshi <mukul.joshi@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1_pkt.h | 473 +++++++++++++++++++++
 1 file changed, 473 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/gfx_v12_1_pkt.h

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1_pkt.h b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1_pkt.h
new file mode 100644
index 0000000000000..f58ce882f2ae3
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1_pkt.h
@@ -0,0 +1,473 @@
+/*
+ * Copyright 2025 Advanced Micro Devices, Inc.
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
+#ifndef GFX_V12_1_PKT_H
+#define GFX_V12_1_PKT_H
+
+/**
+ * PM4 definitions
+ */
+#define	PACKET_TYPE0	0
+#define	PACKET_TYPE1	1
+#define	PACKET_TYPE2	2
+#define	PACKET_TYPE3	3
+
+#define CP_PACKET_GET_TYPE(h) (((h) >> 30) & 3)
+#define CP_PACKET_GET_COUNT(h) (((h) >> 16) & 0x3FFF)
+#define CP_PACKET0_GET_REG(h) ((h) & 0xFFFF)
+#define CP_PACKET3_GET_OPCODE(h) (((h) >> 8) & 0xFF)
+#define PACKET0(reg, n)	((PACKET_TYPE0 << 30) |				\
+			 ((reg) & 0xFFFF) |			\
+			 ((n) & 0x3FFF) << 16)
+#define CP_PACKET2			0x80000000
+#define		PACKET2_PAD_SHIFT		0
+#define		PACKET2_PAD_MASK		(0x3fffffff << 0)
+
+#define PACKET2(v)	(CP_PACKET2 | REG_SET(PACKET2_PAD, (v)))
+
+#define PACKET3(op, n)	((PACKET_TYPE3 << 30) |				\
+			 (((op) & 0xFF) << 8) |				\
+			 ((n) & 0x3FFF) << 16)
+
+#define PACKET3_COMPUTE(op, n) (PACKET3(op, n) | 1 << 1)
+
+/* Packet 3 types */
+#define	PACKET3_NOP					0x10
+#define	PACKET3_SET_BASE				0x11
+#define		PACKET3_BASE_INDEX(x)                  ((x) << 0)
+#define			CE_PARTITION_BASE		3
+#define	PACKET3_CLEAR_STATE				0x12
+#define	PACKET3_INDEX_BUFFER_SIZE			0x13
+#define	PACKET3_DISPATCH_DIRECT				0x15
+#define	PACKET3_DISPATCH_INDIRECT			0x16
+#define	PACKET3_INDIRECT_BUFFER_END			0x17
+#define	PACKET3_INDIRECT_BUFFER_CNST_END		0x19
+#define	PACKET3_ATOMIC_GDS				0x1D
+#define	PACKET3_ATOMIC_MEM				0x1E
+#define	PACKET3_OCCLUSION_QUERY				0x1F
+#define	PACKET3_SET_PREDICATION				0x20
+#define	PACKET3_REG_RMW					0x21
+#define	PACKET3_COND_EXEC				0x22
+#define	PACKET3_PRED_EXEC				0x23
+#define	PACKET3_DRAW_INDIRECT				0x24
+#define	PACKET3_DRAW_INDEX_INDIRECT			0x25
+#define	PACKET3_INDEX_BASE				0x26
+#define	PACKET3_DRAW_INDEX_2				0x27
+#define	PACKET3_CONTEXT_CONTROL				0x28
+#define	PACKET3_INDEX_TYPE				0x2A
+#define	PACKET3_DRAW_INDIRECT_MULTI			0x2C
+#define	PACKET3_DRAW_INDEX_AUTO				0x2D
+#define	PACKET3_NUM_INSTANCES				0x2F
+#define	PACKET3_DRAW_INDEX_MULTI_AUTO			0x30
+#define	PACKET3_INDIRECT_BUFFER_PRIV			0x32
+#define	PACKET3_INDIRECT_BUFFER_CNST			0x33
+#define	PACKET3_COND_INDIRECT_BUFFER_CNST		0x33
+#define	PACKET3_STRMOUT_BUFFER_UPDATE			0x34
+#define	PACKET3_DRAW_INDEX_OFFSET_2			0x35
+#define	PACKET3_DRAW_PREAMBLE				0x36
+#define	PACKET3_WRITE_DATA				0x37
+#define		WRITE_DATA_DST_SEL(x)                   ((x) << 8)
+		/* 0 - register
+		 * 1 - memory (sync - via GRBM)
+		 * 2 - gl2
+		 * 3 - gds
+		 * 4 - reserved
+		 * 5 - memory (async - direct)
+		 */
+#define		WR_ONE_ADDR                             (1 << 16)
+#define		WR_CONFIRM                              (1 << 20)
+#define		WRITE_DATA_CACHE_POLICY(x)              ((x) << 25)
+		/* 0 - LRU
+		 * 1 - Stream
+		 */
+#define		WRITE_DATA_ENGINE_SEL(x)                ((x) << 30)
+		/* 0 - me
+		 * 1 - pfp
+		 * 2 - ce
+		 */
+#define	PACKET3_DRAW_INDEX_INDIRECT_MULTI		0x38
+#define	PACKET3_MEM_SEMAPHORE				0x39
+#              define PACKET3_SEM_USE_MAILBOX       (0x1 << 16)
+#              define PACKET3_SEM_SEL_SIGNAL_TYPE   (0x1 << 20) /* 0 = increment, 1 = write 1 */
+#              define PACKET3_SEM_SEL_SIGNAL	    (0x6 << 29)
+#              define PACKET3_SEM_SEL_WAIT	    (0x7 << 29)
+#define	PACKET3_DRAW_INDEX_MULTI_INST			0x3A
+#define	PACKET3_COPY_DW					0x3B
+#define	PACKET3_WAIT_REG_MEM				0x3C
+#define		WAIT_REG_MEM_FUNCTION(x)                ((x) << 0)
+		/* 0 - always
+		 * 1 - <
+		 * 2 - <=
+		 * 3 - ==
+		 * 4 - !=
+		 * 5 - >=
+		 * 6 - >
+		 */
+#define		WAIT_REG_MEM_MEM_SPACE(x)               ((x) << 4)
+		/* 0 - reg
+		 * 1 - mem
+		 */
+#define		WAIT_REG_MEM_OPERATION(x)               ((x) << 6)
+		/* 0 - wait_reg_mem
+		 * 1 - wr_wait_wr_reg
+		 */
+#define		WAIT_REG_MEM_ENGINE(x)                  ((x) << 8)
+		/* 0 - me
+		 * 1 - pfp
+		 */
+#define	PACKET3_INDIRECT_BUFFER				0x3F
+#define		INDIRECT_BUFFER_VALID                   (1 << 23)
+#define		INDIRECT_BUFFER_CACHE_POLICY(x)         ((x) << 28)
+		/* 0 - LRU
+		 * 1 - Stream
+		 * 2 - Bypass
+		 */
+#define		INDIRECT_BUFFER_PRE_ENB(x)		((x) << 21)
+#define		INDIRECT_BUFFER_PRE_RESUME(x)           ((x) << 30)
+#define	PACKET3_COND_INDIRECT_BUFFER			0x3F
+#define	PACKET3_COPY_DATA				0x40
+#define	PACKET3_CP_DMA					0x41
+#define	PACKET3_PFP_SYNC_ME				0x42
+#define	PACKET3_SURFACE_SYNC				0x43
+#define	PACKET3_ME_INITIALIZE				0x44
+#define	PACKET3_COND_WRITE				0x45
+#define	PACKET3_EVENT_WRITE				0x46
+#define		EVENT_TYPE(x)                           ((x) << 0)
+#define		EVENT_INDEX(x)                          ((x) << 8)
+		/* 0 - any non-TS event
+		 * 1 - ZPASS_DONE, PIXEL_PIPE_STAT_*
+		 * 2 - SAMPLE_PIPELINESTAT
+		 * 3 - SAMPLE_STREAMOUTSTAT*
+		 * 4 - *S_PARTIAL_FLUSH
+		 */
+#define	PACKET3_EVENT_WRITE_EOP				0x47
+#define	PACKET3_EVENT_WRITE_EOS				0x48
+#define	PACKET3_RELEASE_MEM				0x49
+#define		PACKET3_RELEASE_MEM_EVENT_TYPE(x)	    ((x) << 0)
+#define		PACKET3_RELEASE_MEM_EVENT_INDEX(x)	    ((x) << 8)
+#define		PACKET3_RELEASE_MEM_GCR_GL2_SCOPE(x)	((x) << 12)
+#define		PACKET3_RELEASE_MEM_GCR_GLV_INV		    (1 << 14)
+#define		PACKET3_RELEASE_MEM_GCR_GL2_US		    (1 << 16)
+#define		PACKET3_RELEASE_MEM_GCR_GL2_RANGE(x)	((x) << 17)
+#define		PACKET3_RELEASE_MEM_GCR_GL2_DISCARD	    (1 << 19)
+#define		PACKET3_RELEASE_MEM_GCR_GL2_INV		    (1 << 20)
+#define		PACKET3_RELEASE_MEM_GCR_GL2_WB		    (1 << 21)
+#define		PACKET3_RELEASE_MEM_GCR_SEQ(x)		    ((x) << 22)
+#define		PACKET3_RELEASE_MEM_GCR_GLV_WB		    (1 << 24)
+#define		PACKET3_RELEASE_MEM_TEMPORAL(x)	        ((x) << 25)
+		/* 0 - temporal__release_mem__rt
+		 * 1 - temporal__release_mem__nt
+		 * 2 - temporal__release_mem__ht
+		 * 3 - temporal__release_mem__lu
+		 */
+#define		PACKET3_RELEASE_MEM_EXECUTE		(1 << 28)
+
+#define		PACKET3_RELEASE_MEM_DATA_SEL(x)		((x) << 29)
+		/* 0 - discard
+		 * 1 - send low 32bit data
+		 * 2 - send 64bit data
+		 * 3 - send 64bit GPU counter value
+		 * 4 - send 64bit sys counter value
+		 */
+#define		PACKET3_RELEASE_MEM_INT_SEL(x)		((x) << 24)
+		/* 0 - none
+		 * 1 - interrupt only (DATA_SEL = 0)
+		 * 2 - interrupt when data write is confirmed
+		 */
+#define		PACKET3_RELEASE_MEM_DST_SEL(x)		((x) << 16)
+		/* 0 - MC
+		 * 1 - TC/L2
+		 */
+
+
+
+#define	PACKET3_PREAMBLE_CNTL				0x4A
+#              define PACKET3_PREAMBLE_BEGIN_CLEAR_STATE     (2 << 28)
+#              define PACKET3_PREAMBLE_END_CLEAR_STATE       (3 << 28)
+#define	PACKET3_DMA_DATA				0x50
+/* 1. header
+ * 2. CONTROL
+ * 3. SRC_ADDR_LO or DATA [31:0]
+ * 4. SRC_ADDR_HI [31:0]
+ * 5. DST_ADDR_LO [31:0]
+ * 6. DST_ADDR_HI [7:0]
+ * 7. COMMAND [31:26] | BYTE_COUNT [25:0]
+ */
+/* CONTROL */
+#              define PACKET3_DMA_DATA_ENGINE(x)     ((x) << 0)
+		/* 0 - ME
+		 * 1 - PFP
+		 */
+#              define PACKET3_DMA_DATA_SRC_CACHE_POLICY(x) ((x) << 13)
+		/* 0 - LRU
+		 * 1 - Stream
+		 */
+#              define PACKET3_DMA_DATA_DST_SEL(x)  ((x) << 20)
+		/* 0 - DST_ADDR using DAS
+		 * 1 - GDS
+		 * 3 - DST_ADDR using L2
+		 */
+#              define PACKET3_DMA_DATA_DST_CACHE_POLICY(x) ((x) << 25)
+		/* 0 - LRU
+		 * 1 - Stream
+		 */
+#              define PACKET3_DMA_DATA_SRC_SEL(x)  ((x) << 29)
+		/* 0 - SRC_ADDR using SAS
+		 * 1 - GDS
+		 * 2 - DATA
+		 * 3 - SRC_ADDR using L2
+		 */
+#              define PACKET3_DMA_DATA_CP_SYNC     (1 << 31)
+/* COMMAND */
+#              define PACKET3_DMA_DATA_CMD_SAS     (1 << 26)
+		/* 0 - memory
+		 * 1 - register
+		 */
+#              define PACKET3_DMA_DATA_CMD_DAS     (1 << 27)
+		/* 0 - memory
+		 * 1 - register
+		 */
+#              define PACKET3_DMA_DATA_CMD_SAIC    (1 << 28)
+#              define PACKET3_DMA_DATA_CMD_DAIC    (1 << 29)
+#              define PACKET3_DMA_DATA_CMD_RAW_WAIT  (1 << 30)
+#define	PACKET3_CONTEXT_REG_RMW				0x51
+#define	PACKET3_GFX_CNTX_UPDATE				0x52
+#define	PACKET3_BLK_CNTX_UPDATE				0x53
+#define	PACKET3_INCR_UPDT_STATE				0x55
+#define	PACKET3_ACQUIRE_MEM				0x58
+/* 1.  HEADER
+ * 2.  COHER_CNTL [30:0]
+ * 2.1 ENGINE_SEL [31:31]
+ * 2.  COHER_SIZE [31:0]
+ * 3.  COHER_SIZE_HI [7:0]
+ * 4.  COHER_BASE_LO [31:0]
+ * 5.  COHER_BASE_HI [23:0]
+ * 7.  POLL_INTERVAL [15:0]
+ * 8.  GCR_CNTL [18:0]
+ */
+#define 	PACKET3_ACQUIRE_MEM_GCR_CNTL_GLI_INV(x) ((x) << 0)
+		/*
+		 * 0:NOP
+		 * 1:ALL
+		 * 2:RANGE
+		 * 3:FIRST_LAST
+		 */
+#define 	PACKET3_ACQUIRE_MEM_GCR_CNTL_GL1_RANGE(x) ((x) << 2)
+		/*
+		 * 0:ALL
+		 * 1:reserved
+		 * 2:RANGE
+		 * 3:FIRST_LAST
+		 */
+#define 	PACKET3_ACQUIRE_MEM_GCR_CNTL_GL2_SCOPE(x) ((x) << 4)
+        /*
+         * 0:Device scope
+         * 1:System scope
+         * 2:Force INV/WB all
+         * 3:Reserved
+         */
+#define 	PACKET3_ACQUIRE_MEM_GCR_CNTL_GLV_WB(x) ((x) << 6)
+#define 	PACKET3_ACQUIRE_MEM_GCR_CNTL_GLK_INV(x) ((x) << 7)
+#define 	PACKET3_ACQUIRE_MEM_GCR_CNTL_GLV_INV(x) ((x) << 8)
+#define 	PACKET3_ACQUIRE_MEM_GCR_CNTL_GL2_US(x) ((x) << 10)
+#define 	PACKET3_ACQUIRE_MEM_GCR_CNTL_GL2_RANGE(x) ((x) << 11)
+		/*
+		 * 0:ALL
+		 * 1:VOL
+		 * 2:RANGE
+		 * 3:FIRST_LAST
+		 */
+#define 	PACKET3_ACQUIRE_MEM_GCR_CNTL_GL2_DISCARD(x)  ((x) << 13)
+#define 	PACKET3_ACQUIRE_MEM_GCR_CNTL_GL2_INV(x) ((x) << 14)
+#define 	PACKET3_ACQUIRE_MEM_GCR_CNTL_GL2_WB(x) ((x) << 15)
+#define 	PACKET3_ACQUIRE_MEM_GCR_CNTL_SEQ(x) ((x) << 16)
+		/*
+		 * 0: PARALLEL
+		 * 1: FORWARD
+		 * 2: REVERSE
+		 */
+#define 	PACKET3_ACQUIRE_MEM_GCR_RANGE_IS_PA  (1 << 18)
+#define	PACKET3_REWIND					0x59
+#define	PACKET3_INTERRUPT				0x5A
+#define	PACKET3_GEN_PDEPTE				0x5B
+#define	PACKET3_INDIRECT_BUFFER_PASID			0x5C
+#define	PACKET3_PRIME_UTCL2				0x5D
+#define	PACKET3_LOAD_UCONFIG_REG			0x5E
+#define	PACKET3_LOAD_SH_REG				0x5F
+#define	PACKET3_LOAD_CONFIG_REG				0x60
+#define	PACKET3_LOAD_CONTEXT_REG			0x61
+#define	PACKET3_LOAD_COMPUTE_STATE			0x62
+#define	PACKET3_LOAD_SH_REG_INDEX			0x63
+#define	PACKET3_SET_CONFIG_REG				0x68
+#define		PACKET3_SET_CONFIG_REG_START			0x00002000
+#define		PACKET3_SET_CONFIG_REG_END			0x00002c00
+#define	PACKET3_SET_CONTEXT_REG				0x69
+#define		PACKET3_SET_CONTEXT_REG_START			0x0000a000
+#define		PACKET3_SET_CONTEXT_REG_END			0x0000a400
+#define	PACKET3_SET_CONTEXT_REG_INDEX			0x6A
+#define	PACKET3_SET_VGPR_REG_DI_MULTI			0x71
+#define	PACKET3_SET_SH_REG_DI				0x72
+#define	PACKET3_SET_CONTEXT_REG_INDIRECT		0x73
+#define	PACKET3_SET_SH_REG_DI_MULTI			0x74
+#define	PACKET3_GFX_PIPE_LOCK				0x75
+#define	PACKET3_SET_SH_REG				0x76
+#define		PACKET3_SET_SH_REG_START			0x00002c00
+#define		PACKET3_SET_SH_REG_END				0x00003000
+#define	PACKET3_SET_SH_REG_OFFSET			0x77
+#define	PACKET3_SET_QUEUE_REG				0x78
+#define	PACKET3_SET_UCONFIG_REG				0x79
+#define		PACKET3_SET_UCONFIG_REG_START			0x0000c000
+#define		PACKET3_SET_UCONFIG_REG_END			0x0000c400
+#define	PACKET3_SET_UCONFIG_REG_INDEX			0x7A
+#define	PACKET3_FORWARD_HEADER				0x7C
+#define	PACKET3_SCRATCH_RAM_WRITE			0x7D
+#define	PACKET3_SCRATCH_RAM_READ			0x7E
+#define	PACKET3_LOAD_CONST_RAM				0x80
+#define	PACKET3_WRITE_CONST_RAM				0x81
+#define	PACKET3_DUMP_CONST_RAM				0x83
+#define	PACKET3_INCREMENT_CE_COUNTER			0x84
+#define	PACKET3_INCREMENT_DE_COUNTER			0x85
+#define	PACKET3_WAIT_ON_CE_COUNTER			0x86
+#define	PACKET3_WAIT_ON_DE_COUNTER_DIFF			0x88
+#define	PACKET3_SWITCH_BUFFER				0x8B
+#define	PACKET3_DISPATCH_DRAW_PREAMBLE			0x8C
+#define	PACKET3_DISPATCH_DRAW_PREAMBLE_ACE		0x8C
+#define	PACKET3_DISPATCH_DRAW				0x8D
+#define	PACKET3_DISPATCH_DRAW_ACE			0x8D
+#define	PACKET3_GET_LOD_STATS				0x8E
+#define	PACKET3_DRAW_MULTI_PREAMBLE			0x8F
+#define	PACKET3_FRAME_CONTROL				0x90
+#			define FRAME_TMZ	(1 << 0)
+#			define FRAME_CMD(x) ((x) << 28)
+			/*
+			 * x=0: tmz_begin
+			 * x=1: tmz_end
+			 */
+#define	PACKET3_INDEX_ATTRIBUTES_INDIRECT		0x91
+#define	PACKET3_WAIT_REG_MEM64				0x93
+#define	PACKET3_COND_PREEMPT				0x94
+#define	PACKET3_HDP_FLUSH				0x95
+#define	PACKET3_COPY_DATA_RB				0x96
+#define	PACKET3_INVALIDATE_TLBS				0x98
+#              define PACKET3_INVALIDATE_TLBS_DST_SEL(x)     ((x) << 0)
+#              define PACKET3_INVALIDATE_TLBS_ALL_HUB(x)     ((x) << 4)
+#              define PACKET3_INVALIDATE_TLBS_PASID(x)       ((x) << 5)
+#define	PACKET3_AQL_PACKET				0x99
+#define	PACKET3_DMA_DATA_FILL_MULTI			0x9A
+#define	PACKET3_SET_SH_REG_INDEX			0x9B
+#define	PACKET3_DRAW_INDIRECT_COUNT_MULTI		0x9C
+#define	PACKET3_DRAW_INDEX_INDIRECT_COUNT_MULTI		0x9D
+#define	PACKET3_DUMP_CONST_RAM_OFFSET			0x9E
+#define	PACKET3_LOAD_CONTEXT_REG_INDEX			0x9F
+#define	PACKET3_SET_RESOURCES				0xA0
+/* 1. header
+ * 2. CONTROL
+ * 3. QUEUE_MASK_LO [31:0]
+ * 4. QUEUE_MASK_HI [31:0]
+ * 5. GWS_MASK_LO [31:0]
+ * 6. GWS_MASK_HI [31:0]
+ * 7. OAC_MASK [15:0]
+ * 8. GDS_HEAP_SIZE [16:11] | GDS_HEAP_BASE [5:0]
+ */
+#              define PACKET3_SET_RESOURCES_VMID_MASK(x)     ((x) << 0)
+#              define PACKET3_SET_RESOURCES_UNMAP_LATENTY(x) ((x) << 16)
+#              define PACKET3_SET_RESOURCES_QUEUE_TYPE(x)    ((x) << 29)
+#define PACKET3_MAP_PROCESS				0xA1
+#define PACKET3_MAP_QUEUES				0xA2
+/* 1. header
+ * 2. CONTROL
+ * 3. CONTROL2
+ * 4. MQD_ADDR_LO [31:0]
+ * 5. MQD_ADDR_HI [31:0]
+ * 6. WPTR_ADDR_LO [31:0]
+ * 7. WPTR_ADDR_HI [31:0]
+ */
+/* CONTROL */
+#              define PACKET3_MAP_QUEUES_QUEUE_SEL(x)       ((x) << 4)
+#              define PACKET3_MAP_QUEUES_VMID(x)            ((x) << 8)
+#              define PACKET3_MAP_QUEUES_QUEUE(x)           ((x) << 13)
+#              define PACKET3_MAP_QUEUES_PIPE(x)            ((x) << 16)
+#              define PACKET3_MAP_QUEUES_ME(x)              ((x) << 18)
+#              define PACKET3_MAP_QUEUES_QUEUE_TYPE(x)      ((x) << 21)
+#              define PACKET3_MAP_QUEUES_ALLOC_FORMAT(x)    ((x) << 24)
+#              define PACKET3_MAP_QUEUES_ENGINE_SEL(x)      ((x) << 26)
+#              define PACKET3_MAP_QUEUES_NUM_QUEUES(x)      ((x) << 29)
+/* CONTROL2 */
+#              define PACKET3_MAP_QUEUES_CHECK_DISABLE(x)   ((x) << 1)
+#              define PACKET3_MAP_QUEUES_DOORBELL_OFFSET(x) ((x) << 2)
+#define	PACKET3_UNMAP_QUEUES				0xA3
+/* 1. header
+ * 2. CONTROL
+ * 3. CONTROL2
+ * 4. CONTROL3
+ * 5. CONTROL4
+ * 6. CONTROL5
+ */
+/* CONTROL */
+#              define PACKET3_UNMAP_QUEUES_ACTION(x)           ((x) << 0)
+		/* 0 - PREEMPT_QUEUES
+		 * 1 - RESET_QUEUES
+		 * 2 - DISABLE_PROCESS_QUEUES
+		 * 3 - PREEMPT_QUEUES_NO_UNMAP
+		 */
+#              define PACKET3_UNMAP_QUEUES_QUEUE_SEL(x)        ((x) << 4)
+#              define PACKET3_UNMAP_QUEUES_ENGINE_SEL(x)       ((x) << 26)
+#              define PACKET3_UNMAP_QUEUES_NUM_QUEUES(x)       ((x) << 29)
+/* CONTROL2a */
+#              define PACKET3_UNMAP_QUEUES_PASID(x)            ((x) << 0)
+/* CONTROL2b */
+#              define PACKET3_UNMAP_QUEUES_DOORBELL_OFFSET0(x) ((x) << 2)
+/* CONTROL3a */
+#              define PACKET3_UNMAP_QUEUES_DOORBELL_OFFSET1(x) ((x) << 2)
+/* CONTROL3b */
+#              define PACKET3_UNMAP_QUEUES_RB_WPTR(x)          ((x) << 0)
+/* CONTROL4 */
+#              define PACKET3_UNMAP_QUEUES_DOORBELL_OFFSET2(x) ((x) << 2)
+/* CONTROL5 */
+#              define PACKET3_UNMAP_QUEUES_DOORBELL_OFFSET3(x) ((x) << 2)
+#define	PACKET3_QUERY_STATUS				0xA4
+/* 1. header
+ * 2. CONTROL
+ * 3. CONTROL2
+ * 4. ADDR_LO [31:0]
+ * 5. ADDR_HI [31:0]
+ * 6. DATA_LO [31:0]
+ * 7. DATA_HI [31:0]
+ */
+/* CONTROL */
+#              define PACKET3_QUERY_STATUS_CONTEXT_ID(x)       ((x) << 0)
+#              define PACKET3_QUERY_STATUS_INTERRUPT_SEL(x)    ((x) << 28)
+#              define PACKET3_QUERY_STATUS_COMMAND(x)          ((x) << 30)
+/* CONTROL2a */
+#              define PACKET3_QUERY_STATUS_PASID(x)            ((x) << 0)
+/* CONTROL2b */
+#              define PACKET3_QUERY_STATUS_DOORBELL_OFFSET(x)  ((x) << 2)
+#              define PACKET3_QUERY_STATUS_ENG_SEL(x)          ((x) << 25)
+#define	PACKET3_RUN_LIST				0xA5
+#define	PACKET3_MAP_PROCESS_VM				0xA6
+/* GFX11 */
+#define	PACKET3_SET_Q_PREEMPTION_MODE			0xF0
+#              define PACKET3_SET_Q_PREEMPTION_MODE_IB_VMID(x)  ((x) << 0)
+#              define PACKET3_SET_Q_PREEMPTION_MODE_INIT_SHADOW_MEM    (1 << 0)
+
+#endif
-- 
2.51.1

