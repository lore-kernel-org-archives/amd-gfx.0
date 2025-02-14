Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ABACC02198
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Feb 2025 08:08:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1DD2A10EBEC;
	Fri, 14 Feb 2025 08:08:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QbLIlkbw";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2082.outbound.protection.outlook.com [40.107.223.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D3E0A10E48B
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Feb 2025 08:07:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GIeF5sNLuVfB8ggS1Nyi8N98KfF2i4Ur8jWbqcts4B3yMbgVeYmTvMyIFWaDzGs3PXTbJydZsN2FzZrqBU+/5MzCxm9YZYfdN77htt6FhSj+iI3hRQ04Arr3CI/y9jAr6JG8uDYJ8v7DDjpLQT03PuddJQRNzULOjNW/Jq6Op4EYY+q3lldla16M17gKY4k963vBXSmsEUDX10BUyTYTeNtuKeVXOS/jJlijVXstqIdWFHjlGAwEixqKVhPvk00GqXxzM9vKlLOf3U+ei6voTMX1P9xRfxsv4g2sojXDru0FGRgC3pr+37JpgR1wgc9oSdgQkX7Vhq6tQCw/wBDxMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bo4VA16BcuQoxJlrgtIeuiJQOa0PQNQCVMP27DfxwZM=;
 b=k0z2VM9T6M7JN+mPDiOLENXdl4HcNgWpen7T55dRS5dvGEvHJvsFK9mRwYtYVTglxauPED+Os1oTrMWzmmHOVhLWbJHKh9s4qdIlzUlmZWCycSKbKaY9EVWxJJN6lrYpToP6rJ2xZaG2SzIWyIWqIx68+NznYLtOLfKa6nE2xXUwVsUXk/G9kdKFWNpNx+jzkPv7nLfevXDd0vm2xs5O6hctGD74y5I04FC2hhIk9ccrMdwd8O+g87fd6SbSCVfIxalehqSta+iQ/UlTsBgLTB0y1vmQInoStfkK1x+G9BOLFvhMkmw3mh+HQzv9VqPTOKvv7tRcH1k8K2YtI8Iftg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bo4VA16BcuQoxJlrgtIeuiJQOa0PQNQCVMP27DfxwZM=;
 b=QbLIlkbwkIGzaqopiBuapgYbQMqazuB/rz9JpUzrFKDCyPaIgwKmqUrf0HMjdsWz3l2kw6nErcfZRVO9NyTg2RGBUNwJ6Qah3leV3z5gKaWX4b7pgwd3xcrhEM/s8xpRmtM237zg4IXOCELh5eS4s8NehnZ8YUoQkr6CxOrGc9U=
Received: from BN1PR14CA0023.namprd14.prod.outlook.com (2603:10b6:408:e3::28)
 by PH0PR12MB5630.namprd12.prod.outlook.com (2603:10b6:510:146::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.16; Fri, 14 Feb
 2025 08:07:54 +0000
Received: from BN2PEPF000055DE.namprd21.prod.outlook.com
 (2603:10b6:408:e3:cafe::de) by BN1PR14CA0023.outlook.office365.com
 (2603:10b6:408:e3::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.16 via Frontend Transport; Fri,
 14 Feb 2025 08:07:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000055DE.mail.protection.outlook.com (10.167.245.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.0 via Frontend Transport; Fri, 14 Feb 2025 08:07:53 +0000
Received: from liuxiang-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 14 Feb
 2025 02:07:48 -0600
From: Xiang Liu <xiang.liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <tao.zhou1@amd.com>, Xiang Liu <xiang.liu@amd.com>
Subject: [PATCH v2 01/12] drm/amd/include: Add amd cper header
Date: Fri, 14 Feb 2025 16:07:08 +0800
Message-ID: <2464f14f61d02282ae086a16876f6e86de8eb68c.1739519672.git.xiang.liu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1739519672.git.xiang.liu@amd.com>
References: <cover.1739519672.git.xiang.liu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DE:EE_|PH0PR12MB5630:EE_
X-MS-Office365-Filtering-Correlation-Id: e2c9a775-174f-40bd-26b5-08dd4cceaedd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?wyOMgV52FGexHnM52TrF1OYDQW8Q+gMrzh5sgmhZx6qbcIxS9dXiQzpPbRX2?=
 =?us-ascii?Q?Nd9A+23eznCxiOUYNwo4S5HwxI+VP/ZQYkx3qigKVM+Zghk6zp9stBBngsU6?=
 =?us-ascii?Q?8GbSMjPkaazdeVHQtHC2PEy+4NRq8Gr3K/gI60vR2fsK8pc30FzuthyS42Ur?=
 =?us-ascii?Q?Bfh1kLIsvLjHvCRDFWFauwJN2knhZNdnP6ZUOLIwwHnG6/oppJmhAxgN7xKL?=
 =?us-ascii?Q?k1nXmOPor9S6d7J3f1Xngj4Mg+3JXh9MMhOZbsI1Tthk2iaH38i82+XXSlED?=
 =?us-ascii?Q?zmSjthSGLmpzlKs6juRrW+wCY6MWCIvCqk+jUmaVTcL5mE5s1ZXERnWh2oKb?=
 =?us-ascii?Q?hwhIKf0h+PWDvxkJAbdvOGEGex11QWr6Tx99DEsNV2B/ZGP//QJgQHn++Qba?=
 =?us-ascii?Q?mWx+Jk+UzfkWcuntJxZvoGg9o2rOfDgE81Le7Wmx1TLG9qC7aWDWgCFs0kmV?=
 =?us-ascii?Q?qmkiq1O4lFhjgBFrhdjGMeKpxxQwi7L1aU8U6IcUCWcm77OvcfwPLbeHMA4B?=
 =?us-ascii?Q?zUTTdy+lzbS2+YDyBksK5/hlwwEeUNNBC/xOJk137GshnA8f15vucPLtt5TK?=
 =?us-ascii?Q?CjR7y2G0nhhrzRwuw1v12uH85tZdI4acBFsSFqcP6NFAi6KHMvuxmZ+t0wDB?=
 =?us-ascii?Q?02Y/ApTu2iYKgfWxAriYZviQsO5QLL2L78FKWTQpohpnubPxuHADhqEx6wci?=
 =?us-ascii?Q?Os8Yod1Qnto9xW1/rFNXnuQ/zSdpJBe0dO8bnIgRDPViZWM4VCNekMjk6CII?=
 =?us-ascii?Q?MU9BLhL40I5yyJCXOWQsQK82bClYb0o0/z7IWrerEmIo1zEVJGHWuLySDXSW?=
 =?us-ascii?Q?nx0KjR7gL+hC6fPdQXJ35MSH4e0h0GsGSi1e0sbSRAKqNCRcdnYhhNtR5Wu1?=
 =?us-ascii?Q?lu6AgUr4b+pr4EfXr1iJYECgGq4+rYKulXGVur1fLK8SarbOKkGc8USbic07?=
 =?us-ascii?Q?EiPALoRyJTw9+Z68mXi/xY8iTTC8F4opkLLy3tFnlsikRDY857JU2rBrz9mU?=
 =?us-ascii?Q?117bO8JCd7XUEni6bax5FhsTdAYV8dnUKnBi5/zvdHmWIyFloWdwO/p3p/0D?=
 =?us-ascii?Q?UATQV7+36iFeZea0SgajJAkhVjmGir1Hf/f4Ya0xunZ1PfKur4udFU7BlHfq?=
 =?us-ascii?Q?TS1tnPLSSMDt2dsQkNnZsrv3dFFYbbQA3Ai9hS4MX8OZU9EO4xAu3L2zuSkF?=
 =?us-ascii?Q?OKAYTM8rpD8pgazsLYHpkUlJf3i2vREGgdJP2xR1/zOxiD2V/ge5wrniZh4G?=
 =?us-ascii?Q?iQ0S3QJ/CH4rWQJwG3sJMbni6Ajc7tPbke2QeDHy3qSteBra5XVShuSGkqUV?=
 =?us-ascii?Q?S1RK3NmPWMOiVi/A8vJEMeov09zrXKx6sD0vaTBElFz8DZfK35Muo26O/aER?=
 =?us-ascii?Q?loCvWNVDXGfsjB36EXkyk9cbQT8kOFJoNDjyllhCz329seOxn2oY/XkAynIq?=
 =?us-ascii?Q?IDxm9q3sC34OFQx4xyvv9VZMbTkOpgwT7Hj1GXVSJeP661aowcI++pRyS1ZG?=
 =?us-ascii?Q?ziiTEsZ2X94pknk=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2025 08:07:53.6400 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e2c9a775-174f-40bd-26b5-08dd4cceaedd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055DE.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5630
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

AMD is using Common Platform Error Record (CPER) format
to report all gpu hardware errors.

v2: add program attribute

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Xiang Liu <xiang.liu@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/include/amd_cper.h | 269 +++++++++++++++++++++++++
 1 file changed, 269 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/include/amd_cper.h

diff --git a/drivers/gpu/drm/amd/include/amd_cper.h b/drivers/gpu/drm/amd/include/amd_cper.h
new file mode 100644
index 000000000000..086869264425
--- /dev/null
+++ b/drivers/gpu/drm/amd/include/amd_cper.h
@@ -0,0 +1,269 @@
+/* SPDX-License-Identifier: GPL-2.0 */
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
+#ifndef __AMD_CPER_H__
+#define __AMD_CPER_H__
+
+#include <linux/uuid.h>
+
+#define CPER_HDR_REV_1          (0x100)
+#define CPER_SEC_MINOR_REV_1    (0x01)
+#define CPER_SEC_MAJOR_REV_22   (0x22)
+#define CPER_MAX_OAM_COUNT      (8)
+
+#define CPER_CTX_TYPE_CRASH     (1)
+#define CPER_CTX_TYPE_BOOT      (9)
+
+#define CPER_CREATOR_ID_AMDGPU	"amdgpu"
+
+#define CPER_NOTIFY_MCE                                               \
+	GUID_INIT(0xE8F56FFE, 0x919C, 0x4cc5, 0xBA, 0x88, 0x65, 0xAB, \
+		  0xE1, 0x49, 0x13, 0xBB)
+#define CPER_NOTIFY_CMC                                               \
+	GUID_INIT(0x2DCE8BB1, 0xBDD7, 0x450e, 0xB9, 0xAD, 0x9C, 0xF4, \
+		  0xEB, 0xD4, 0xF8, 0x90)
+#define BOOT_TYPE                                                     \
+	GUID_INIT(0x3D61A466, 0xAB40, 0x409a, 0xA6, 0x98, 0xF3, 0x62, \
+		  0xD4, 0x64, 0xB3, 0x8F)
+
+#define AMD_CRASHDUMP                                                 \
+	GUID_INIT(0x32AC0C78, 0x2623, 0x48F6, 0xB0, 0xD0, 0x73, 0x65, \
+		  0x72, 0x5F, 0xD6, 0xAE)
+#define AMD_GPU_NONSTANDARD_ERROR                                     \
+	GUID_INIT(0x32AC0C78, 0x2623, 0x48F6, 0x81, 0xA2, 0xAC, 0x69, \
+		  0x17, 0x80, 0x55, 0x1D)
+#define PROC_ERR_SECTION_TYPE                                         \
+	GUID_INIT(0xDC3EA0B0, 0xA144, 0x4797, 0xB9, 0x5B, 0x53, 0xFA, \
+		  0x24, 0x2B, 0x6E, 0x1D)
+
+enum cper_error_severity {
+	CPER_SEV_NON_FATAL_UNCORRECTED = 0,
+	CPER_SEV_FATAL                 = 1,
+	CPER_SEV_NON_FATAL_CORRECTED   = 2,
+	CPER_SEV_NUM                   = 3,
+
+	CPER_SEV_UNUSED = 10,
+};
+
+enum cper_aca_reg {
+	CPER_ACA_REG_CTL_LO    = 0,
+	CPER_ACA_REG_CTL_HI    = 1,
+	CPER_ACA_REG_STATUS_LO = 2,
+	CPER_ACA_REG_STATUS_HI = 3,
+	CPER_ACA_REG_ADDR_LO   = 4,
+	CPER_ACA_REG_ADDR_HI   = 5,
+	CPER_ACA_REG_MISC0_LO  = 6,
+	CPER_ACA_REG_MISC0_HI  = 7,
+	CPER_ACA_REG_CONFIG_LO = 8,
+	CPER_ACA_REG_CONFIG_HI = 9,
+	CPER_ACA_REG_IPID_LO   = 10,
+	CPER_ACA_REG_IPID_HI   = 11,
+	CPER_ACA_REG_SYND_LO   = 12,
+	CPER_ACA_REG_SYND_HI   = 13,
+
+	CPER_ACA_REG_COUNT     = 32,
+};
+
+#pragma pack(push, 1)
+
+struct cper_timestamp {
+	uint8_t seconds;
+	uint8_t minutes;
+	uint8_t hours;
+	uint8_t flag;
+	uint8_t day;
+	uint8_t month;
+	uint8_t year;
+	uint8_t century;
+};
+
+struct cper_hdr {
+	char                     signature[4];  /* "CPER"  */
+	uint16_t                 revision;
+	uint32_t                 signature_end; /* 0xFFFFFFFF */
+	uint16_t                 sec_cnt;
+	enum cper_error_severity error_severity;
+	union {
+		struct {
+			uint32_t platform_id	: 1;
+			uint32_t timestamp	: 1;
+			uint32_t partition_id	: 1;
+			uint32_t reserved	: 29;
+		} valid_bits;
+		uint32_t valid_mask;
+	};
+	uint32_t		record_length;    /* Total size of CPER Entry */
+	struct cper_timestamp	timestamp;
+	char			platform_id[16];
+	guid_t			partition_id;     /* Reserved */
+	char			creator_id[16];
+	guid_t			notify_type;      /* CMC, MCE */
+	char			record_id[8];     /* Unique CPER Entry ID */
+	uint32_t		flags;            /* Reserved */
+	uint64_t		persistence_info; /* Reserved */
+	uint8_t			reserved[12];     /* Reserved */
+};
+
+struct cper_sec_desc {
+	uint32_t sec_offset;     /* Offset from the start of CPER entry */
+	uint32_t sec_length;
+	uint8_t  revision_minor; /* CPER_SEC_MINOR_REV_1 */
+	uint8_t  revision_major; /* CPER_SEC_MAJOR_REV_22 */
+	union {
+		struct {
+			uint8_t fru_id		: 1;
+			uint8_t fru_text	: 1;
+			uint8_t reserved	: 6;
+		} valid_bits;
+		uint8_t valid_mask;
+	};
+	uint8_t reserved;
+	union {
+		struct {
+			uint32_t primary		: 1;
+			uint32_t reserved1		: 2;
+			uint32_t exceed_err_threshold	: 1;
+			uint32_t latent_err		: 1;
+			uint32_t reserved2		: 27;
+		} flag_bits;
+		uint32_t flag_mask;
+	};
+	guid_t				sec_type;
+	char				fru_id[16];
+	enum cper_error_severity	severity;
+	char				fru_text[20];
+};
+
+struct cper_sec_nonstd_err_hdr {
+	union {
+		struct {
+			uint64_t apic_id		: 1;
+			uint64_t fw_id			: 1;
+			uint64_t err_info_cnt		: 6;
+			uint64_t err_context_cnt	: 6;
+		} valid_bits;
+		uint64_t valid_mask;
+	};
+	uint64_t apic_id;
+	char     fw_id[48];
+};
+
+struct cper_sec_nonstd_err_info {
+	guid_t error_type;
+	union {
+		struct {
+			uint64_t ms_chk			: 1;
+			uint64_t target_addr_id		: 1;
+			uint64_t req_id			: 1;
+			uint64_t resp_id		: 1;
+			uint64_t instr_ptr		: 1;
+			uint64_t reserved		: 59;
+		} valid_bits;
+		uint64_t        valid_mask;
+	};
+	union {
+		struct {
+			uint64_t err_type_valid		: 1;
+			uint64_t pcc_valid		: 1;
+			uint64_t uncorr_valid		: 1;
+			uint64_t precise_ip_valid	: 1;
+			uint64_t restartable_ip_valid	: 1;
+			uint64_t overflow_valid		: 1;
+			uint64_t reserved1		: 10;
+			uint64_t err_type		: 2;
+			uint64_t pcc			: 1;
+			uint64_t uncorr			: 1;
+			uint64_t precised_ip		: 1;
+			uint64_t restartable_ip		: 1;
+			uint64_t overflow		: 1;
+			uint64_t reserved2		: 41;
+		} ms_chk_bits;
+		uint64_t ms_chk_mask;
+	};
+	uint64_t target_addr_id;
+	uint64_t req_id;
+	uint64_t resp_id;
+	uint64_t instr_ptr;
+};
+
+struct cper_sec_nonstd_err_ctx {
+	uint16_t reg_ctx_type;
+	uint16_t reg_arr_size;
+	uint32_t msr_addr;
+	uint64_t mm_reg_addr;
+	uint32_t reg_dump[CPER_ACA_REG_COUNT];
+};
+
+struct cper_sec_nonstd_err {
+	struct cper_sec_nonstd_err_hdr  hdr;
+	struct cper_sec_nonstd_err_info info;
+	struct cper_sec_nonstd_err_ctx  ctx;
+};
+
+struct cper_sec_crashdump_hdr {
+	uint64_t reserved1;
+	uint64_t reserved2;
+	char     fw_id[48];
+	uint64_t reserved3[8];
+};
+
+struct cper_sec_crashdump_reg_data {
+	uint32_t status_lo;
+	uint32_t status_hi;
+	uint32_t addr_lo;
+	uint32_t addr_hi;
+	uint32_t ipid_lo;
+	uint32_t ipid_hi;
+	uint32_t synd_lo;
+	uint32_t synd_hi;
+};
+
+struct cper_sec_crashdump_body_fatal {
+	uint16_t                           reg_ctx_type;
+	uint16_t                           reg_arr_size;
+	uint32_t                           reserved1;
+	uint64_t                           reserved2;
+	struct cper_sec_crashdump_reg_data data;
+};
+
+struct cper_sec_crashdump_body_boot {
+	uint16_t reg_ctx_type;
+	uint16_t reg_arr_size;
+	uint32_t reserved1;
+	uint64_t reserved2;
+	uint64_t msg[CPER_MAX_OAM_COUNT];
+};
+
+struct cper_sec_crashdump_fatal {
+	struct cper_sec_crashdump_hdr        hdr;
+	struct cper_sec_crashdump_body_fatal body;
+};
+
+struct cper_sec_crashdump_boot {
+	struct cper_sec_crashdump_hdr       hdr;
+	struct cper_sec_crashdump_body_boot body;
+};
+
+#pragma pack(pop)
+
+#endif
-- 
2.34.1

