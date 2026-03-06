Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC57CFCB61A
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Mar 2026 15:38:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5531B10ED5A;
	Fri,  6 Mar 2026 15:38:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZBxMAkCE";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012020.outbound.protection.outlook.com [40.107.209.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B9E6A10ED5A
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Mar 2026 15:38:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UpjFc61f+5WJWC/JgP4GaUyjGJwhOZJ5g8PZfC1RIY6cQU8DTPVjMU0GEBiSJUuUeLpqt4MDtnSA5np0nkHmNAkQHsMugNjmYJDbZVrKeGA9ORrML4dxenhlzSmiYP+S8T1hxDJjxnAlHFdw11YtGQ37rM2tvJ58DxSOP/5HJYxXfLjoiM0X1iAWP38Ee/1rzqEXxDSt0Bv4WHkSilTF5Dj+OX9Ni/7hJ6fHnYxy3tfHz+WNR66QxZNWYQGeKUs/o1jCbBcQcqOxobL3SHsz4SWNy80AbPbeRyCeW7Ofyvfyjs9uUiSzPpMdL6JHFQ1A4p+lH7h9Qk1AucjPc7FDGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ViUpdsyoRhu7Eg1wgELiEx41P6ZyAc6CNaZY3UA3qY0=;
 b=FTW5+muF23YuYAzkI5VpAa7qwePUDuU7yF8HkkkCTD11qQ7csRSL6V55X9PqdoZna8ZKAbDLRquGHq+zMledZ3RVyqK7kaurf3oNLbrWtpBDVwS0wXGEZWVF22qWFlxQ7/KSaVjH4umx1Sa20iOu8pXog36VNOdqn6LvILJufIVHAJ2W5cJPUB95jqlbroFiMf8KRkWsB6rZSuKqq/DmBBu2M/8ILb4XfAAH4y0qS7UXF2vhmfOEY+HED5o4wHuse9z6gRbDyOBFiKLYidvkbFtNsffwE4zpVnut6MvhHE5/AGewv8qBNCo0Bi2bgeNhn0DdeAMnB+E1SIqdDqJrQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ViUpdsyoRhu7Eg1wgELiEx41P6ZyAc6CNaZY3UA3qY0=;
 b=ZBxMAkCEw+xNsOvgrn02VfwiCGuzl6cqz9NiCYUs3ktzyRRdPuBNiHpbiZ1ykntgH+bSkQxP0iFSkqHAwB5id9Tn518Jz/mWOLEqYT8nizBRTTp9GfC24rYhtbPPHLDDwLuHQAdFp8UP5o04iJpuaG8SnA42svdwTEJ5UJZBq5Q=
Received: from BY3PR05CA0014.namprd05.prod.outlook.com (2603:10b6:a03:254::19)
 by MN0PR12MB6126.namprd12.prod.outlook.com (2603:10b6:208:3c6::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.18; Fri, 6 Mar
 2026 15:38:02 +0000
Received: from BY1PEPF0001AE1C.namprd04.prod.outlook.com
 (2603:10b6:a03:254:cafe::4b) by BY3PR05CA0014.outlook.office365.com
 (2603:10b6:a03:254::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.19 via Frontend Transport; Fri,
 6 Mar 2026 15:38:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BY1PEPF0001AE1C.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Fri, 6 Mar 2026 15:38:01 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 6 Mar
 2026 09:37:55 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 6 Mar
 2026 09:37:34 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Fri, 6 Mar 2026 09:37:34 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Likun Gao <Likun.Gao@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>, Alex
 Deucher <alexander.deucher@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: Add lsdma v7_1_0 ip headers
Date: Fri, 6 Mar 2026 10:37:26 -0500
Message-ID: <20260306153728.22079-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE1C:EE_|MN0PR12MB6126:EE_
X-MS-Office365-Filtering-Correlation-Id: 35714d47-b747-4075-b4e6-08de7b965a08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700016; 
X-Microsoft-Antispam-Message-Info: BSnqaYqdh/UVZDmAWwLnWDQPsUfXc9eW1KaW/5k2ryFsIRag4IloivLCRFqgiGdzODGjr2H1nB6U/canr/WTfEfh8stZBWuEfH/aa8e0z4mM/TY5C90AKKc3cvSWRk9wi9uYA3QtHbKjw5Y5pyF3qP6lNmnmyQHBaB6qyZQFOhgKHvchs6PteaHiTfhcSVIZTQ1/fgTyuSBgxPFX2U8nw2ut1ZVFOJDOAxyIneHu2ZVTJeeFGpSmJueLwjwdYvlN7y8U+7Nx6JOLgC5nK+IV1uThyZ6HM/w6m9e0fcf1fRZhn7CKoqzIs4zY1XXuD9USQ2KtvAvQrEuy9q6o9aZEYn7m3h+hgxaxrwnnwC8Nohrw/L4uTe9hurgp2Q1UZLtz23+jvcm+7JgVgzLUZmaYZyIZr9mcPuZu9V58Ku0nbg7uPv5fgZ7ZrsUdo0/Apm7J5gqUP21xwff3bPqBVd/s/eqmUqCj/5zgYYXmgxf0bKFU2rTTZuWU+NTkkBXL5teyrFvMmsiaKCfiK2vFRJLnlv7NoV40a46sg4fyKYqpuaF4f5OjW2FOddndDDoN/O0y5ySGTs1xN9H00+T3FKwVswtwfF8qn2+3kmoi/pGAkbZG2CsEqZmLlTZFSUxcSfAOyI0cxfRlB1BizjmCbQ54jIXvbVsr+TysFlshNEaMpoq1h/4ixFwlM1EOXtLIA8UMMCrO2omwBluWRisgMsswFNRDOrNrXAtXiGFOnLAcubSJZXwE98X6K6CNHTIbUy3etwkPRok2i7zFUZYlN0kh+Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: rtcf7CcS47ASNKGurslwBKByH4j9Qgiuyw+e0HsoqaQ9Ljywv6JBF12/6GLes1UWmgeTqxyKAS6F8B9KlbatqeD0UlSPIWy2qoMpjXTMXSsnE5aaVUj+wiIVUuDoh3l6XD7Np9S7dUFXfsCpUGKehK7jHFrpfRo9aBAdqVcKfu2ic7rMh/Bk/cyiB7pckaYR5Tq3xB+UTloChVWePhjaYR6W+1xh4SmusqtbEtBMpIRjL4Laj2Avq4W6I27ErKomvKfcSszCHcSj8AjKAGc6MoC3yNxPZwU1gxUJIxX2eeA8wlPdBGmHp4AnhaWxrkyJyajfWyPAImRvY7zADN8bNgSsikXS+wxUuhmp4Bw2LSely6n/nt+Q20+f/2ogrKyF1pB30YCJfY65bGryBxFjP/G+gy70XS0v1RfvhwJkxKRADLFMlqqi11SxI4zRPh9t
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 15:38:01.7675 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 35714d47-b747-4075-b4e6-08de7b965a08
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF0001AE1C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6126
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

Add header files for lsdma v7_1_0 register offsets
and shift masks

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../asic_reg/lsdma/lsdma_7_1_0_offset.h       |  44 ++++++++
 .../asic_reg/lsdma/lsdma_7_1_0_sh_mask.h      | 105 ++++++++++++++++++
 2 files changed, 149 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/lsdma/lsdma_7_1_0_offset.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/lsdma/lsdma_7_1_0_sh_mask.h

diff --git a/drivers/gpu/drm/amd/include/asic_reg/lsdma/lsdma_7_1_0_offset.h b/drivers/gpu/drm/amd/include/asic_reg/lsdma/lsdma_7_1_0_offset.h
new file mode 100644
index 0000000000000..fa4e42a3ae9fc
--- /dev/null
+++ b/drivers/gpu/drm/amd/include/asic_reg/lsdma/lsdma_7_1_0_offset.h
@@ -0,0 +1,44 @@
+/*
+ * Copyright 2026 Advanced Micro Devices, Inc.
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
+#ifndef _lsdma_7_1_0_OFFSET_HEADER
+#define _lsdma_7_1_0_OFFSET_HEADER
+
+#define regLSDMA_PIO_SRC_ADDR_LO                                                                        0x0080
+#define regLSDMA_PIO_SRC_ADDR_LO_BASE_IDX                                                               0
+#define regLSDMA_PIO_SRC_ADDR_HI                                                                        0x0081
+#define regLSDMA_PIO_SRC_ADDR_HI_BASE_IDX                                                               0
+#define regLSDMA_PIO_DST_ADDR_LO                                                                        0x0082
+#define regLSDMA_PIO_DST_ADDR_LO_BASE_IDX                                                               0
+#define regLSDMA_PIO_DST_ADDR_HI                                                                        0x0083
+#define regLSDMA_PIO_DST_ADDR_HI_BASE_IDX                                                               0
+#define regLSDMA_PIO_COMMAND                                                                            0x0084
+#define regLSDMA_PIO_COMMAND_BASE_IDX                                                                   0
+#define regLSDMA_PIO_CONSTFILL_DATA                                                                     0x0085
+#define regLSDMA_PIO_CONSTFILL_DATA_BASE_IDX                                                            0
+#define regLSDMA_PIO_CONTROL                                                                            0x0086
+#define regLSDMA_PIO_CONTROL_BASE_IDX                                                                   0
+
+#define regLSDMA_PIO_STATUS                                                                             0x008a
+#define regLSDMA_PIO_STATUS_BASE_IDX                                                                    0
+
+#endif
diff --git a/drivers/gpu/drm/amd/include/asic_reg/lsdma/lsdma_7_1_0_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/lsdma/lsdma_7_1_0_sh_mask.h
new file mode 100644
index 0000000000000..cf83dacf4acf5
--- /dev/null
+++ b/drivers/gpu/drm/amd/include/asic_reg/lsdma/lsdma_7_1_0_sh_mask.h
@@ -0,0 +1,105 @@
+/*
+ * Copyright 2026 Advanced Micro Devices, Inc.
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
+#ifndef _lsdma_7_1_0_SH_MASK_HEADER
+#define _lsdma_7_1_0_SH_MASK_HEADER
+
+
+// addressBlock: lsdma0_lsdma0dec
+//LSDMA_PIO_STATUS
+#define LSDMA_PIO_STATUS__CMD_IN_FIFO__SHIFT                                                                  0x0
+#define LSDMA_PIO_STATUS__CMD_PROCESSING__SHIFT                                                               0x3
+#define LSDMA_PIO_STATUS__ERROR_INVALID_ADDR__SHIFT                                                           0xb
+#define LSDMA_PIO_STATUS__ERROR_ZERO_COUNT__SHIFT                                                             0xc
+#define LSDMA_PIO_STATUS__ERROR_DRAM_ECC__SHIFT                                                               0xd
+#define LSDMA_PIO_STATUS__ERROR_SRAM_ECC__SHIFT                                                               0xe
+#define LSDMA_PIO_STATUS__ERROR_WRRET_NACK_GEN_ERR__SHIFT                                                     0xf
+#define LSDMA_PIO_STATUS__ERROR_RDRET_NACK_GEN_ERR__SHIFT                                                     0x10
+#define LSDMA_PIO_STATUS__ERROR_WRRET_NACK_PRT__SHIFT                                                         0x11
+#define LSDMA_PIO_STATUS__ERROR_RDRET_NACK_PRT__SHIFT                                                         0x12
+#define LSDMA_PIO_STATUS__ERROR_REQ_DROP__SHIFT                                                               0x13
+#define LSDMA_PIO_STATUS__PIO_FIFO_EMPTY__SHIFT                                                               0x1c
+#define LSDMA_PIO_STATUS__PIO_FIFO_FULL__SHIFT                                                                0x1d
+#define LSDMA_PIO_STATUS__PIO_IDLE__SHIFT                                                                     0x1f
+#define LSDMA_PIO_STATUS__CMD_IN_FIFO_MASK                                                                    0x00000007L
+#define LSDMA_PIO_STATUS__CMD_PROCESSING_MASK                                                                 0x000003F8L
+#define LSDMA_PIO_STATUS__ERROR_INVALID_ADDR_MASK                                                             0x00000800L
+#define LSDMA_PIO_STATUS__ERROR_ZERO_COUNT_MASK                                                               0x00001000L
+#define LSDMA_PIO_STATUS__ERROR_DRAM_ECC_MASK                                                                 0x00002000L
+#define LSDMA_PIO_STATUS__ERROR_SRAM_ECC_MASK                                                                 0x00004000L
+#define LSDMA_PIO_STATUS__ERROR_WRRET_NACK_GEN_ERR_MASK                                                       0x00008000L
+#define LSDMA_PIO_STATUS__ERROR_RDRET_NACK_GEN_ERR_MASK                                                       0x00010000L
+#define LSDMA_PIO_STATUS__ERROR_WRRET_NACK_PRT_MASK                                                           0x00020000L
+#define LSDMA_PIO_STATUS__ERROR_RDRET_NACK_PRT_MASK                                                           0x00040000L
+#define LSDMA_PIO_STATUS__ERROR_REQ_DROP_MASK                                                                 0x00080000L
+#define LSDMA_PIO_STATUS__PIO_FIFO_EMPTY_MASK                                                                 0x10000000L
+#define LSDMA_PIO_STATUS__PIO_FIFO_FULL_MASK                                                                  0x20000000L
+#define LSDMA_PIO_STATUS__PIO_IDLE_MASK                                                                       0x80000000L
+//LSDMA_PIO_SRC_ADDR_LO
+#define LSDMA_PIO_SRC_ADDR_LO__SRC_ADDR_LO__SHIFT                                                             0x0
+#define LSDMA_PIO_SRC_ADDR_LO__SRC_ADDR_LO_MASK                                                               0xFFFFFFFFL
+//LSDMA_PIO_SRC_ADDR_HI
+#define LSDMA_PIO_SRC_ADDR_HI__SRC_ADDR_HI__SHIFT                                                             0x0
+#define LSDMA_PIO_SRC_ADDR_HI__SRC_ADDR_HI_MASK                                                               0xFFFFFFFFL
+//LSDMA_PIO_DST_ADDR_LO
+#define LSDMA_PIO_DST_ADDR_LO__DST_ADDR_LO__SHIFT                                                             0x0
+#define LSDMA_PIO_DST_ADDR_LO__DST_ADDR_LO_MASK                                                               0xFFFFFFFFL
+//LSDMA_PIO_DST_ADDR_HI
+#define LSDMA_PIO_DST_ADDR_HI__DST_ADDR_HI__SHIFT                                                             0x0
+#define LSDMA_PIO_DST_ADDR_HI__DST_ADDR_HI_MASK                                                               0xFFFFFFFFL
+//LSDMA_PIO_CONTROL
+#define LSDMA_PIO_CONTROL__VMID__SHIFT                                                                        0x0
+#define LSDMA_PIO_CONTROL__DST_GPA__SHIFT                                                                     0x4
+#define LSDMA_PIO_CONTROL__DST_SYS__SHIFT                                                                     0x5
+#define LSDMA_PIO_CONTROL__DST_GCC__SHIFT                                                                     0x6
+#define LSDMA_PIO_CONTROL__DST_SNOOP__SHIFT                                                                   0x7
+#define LSDMA_PIO_CONTROL__DST_REUSE_HINT__SHIFT                                                              0x8
+#define LSDMA_PIO_CONTROL__DST_COMP_EN__SHIFT                                                                 0xa
+#define LSDMA_PIO_CONTROL__SRC_GPA__SHIFT                                                                     0x14
+#define LSDMA_PIO_CONTROL__SRC_SYS__SHIFT                                                                     0x15
+#define LSDMA_PIO_CONTROL__SRC_SNOOP__SHIFT                                                                   0x17
+#define LSDMA_PIO_CONTROL__SRC_REUSE_HINT__SHIFT                                                              0x18
+#define LSDMA_PIO_CONTROL__SRC_COMP_EN__SHIFT                                                                 0x1a
+#define LSDMA_PIO_CONTROL__VMID_MASK                                                                          0x0000000FL
+#define LSDMA_PIO_CONTROL__DST_GPA_MASK                                                                       0x00000010L
+#define LSDMA_PIO_CONTROL__DST_SYS_MASK                                                                       0x00000020L
+#define LSDMA_PIO_CONTROL__DST_GCC_MASK                                                                       0x00000040L
+#define LSDMA_PIO_CONTROL__DST_SNOOP_MASK                                                                     0x00000080L
+#define LSDMA_PIO_CONTROL__DST_REUSE_HINT_MASK                                                                0x00000300L
+#define LSDMA_PIO_CONTROL__DST_COMP_EN_MASK                                                                   0x00000400L
+#define LSDMA_PIO_CONTROL__SRC_GPA_MASK                                                                       0x00100000L
+#define LSDMA_PIO_CONTROL__SRC_SYS_MASK                                                                       0x00200000L
+#define LSDMA_PIO_CONTROL__SRC_SNOOP_MASK                                                                     0x00800000L
+#define LSDMA_PIO_CONTROL__SRC_REUSE_HINT_MASK                                                                0x03000000L
+#define LSDMA_PIO_CONTROL__SRC_COMP_EN_MASK                                                                   0x04000000L
+//LSDMA_PIO_COMMAND
+#define LSDMA_PIO_COMMAND__COUNT__SHIFT                                                                       0x0
+#define LSDMA_PIO_COMMAND__RAW_WAIT__SHIFT                                                                    0x1e
+#define LSDMA_PIO_COMMAND__CONSTANT_FILL__SHIFT                                                               0x1f
+#define LSDMA_PIO_COMMAND__COUNT_MASK                                                                         0x03FFFFFFL
+#define LSDMA_PIO_COMMAND__RAW_WAIT_MASK                                                                      0x40000000L
+#define LSDMA_PIO_COMMAND__CONSTANT_FILL_MASK                                                                 0x80000000L
+//LSDMA_PIO_CONSTFILL_DATA
+#define LSDMA_PIO_CONSTFILL_DATA__DATA__SHIFT                                                                 0x0
+#define LSDMA_PIO_CONSTFILL_DATA__DATA_MASK                                                                   0xFFFFFFFFL
+
+#endif
-- 
2.53.0

