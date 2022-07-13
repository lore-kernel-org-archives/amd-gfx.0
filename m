Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CE7FC43334
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Jul 2022 03:25:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 91CBA112AFE;
	Wed, 13 Jul 2022 03:25:52 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2047.outbound.protection.outlook.com [40.107.237.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF64C112AFE
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Jul 2022 03:25:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fb2+VTjBzKQWs1k1LFQJ40I4bR8Q0k8E2iDnuGq0z7S6dob1ecjaWcmYlRI+e0A8KHL/RlB3fBJcigNHZkW3paUU6PdxIAyolOOoC822viqTEGNLVkZ0vtxeCTaNOGYyF1iMTEUizNTyqYN2jB98d7okURXs4EJiri9vU5Y/jNDZsiNSfzo9k0BmL99frOEACuJV3s9deYuDbClcSCw+IG+lYlv7iH4VS9R8sZSauW6LIca0pBKEY5XvvDzNLNNJseBqwjWNcgS8IbL4T7WE0k5YOh07Am44jo+9vLxXiHTqkCWosYHd8MDddty8ks66mWvpXW1m2pI4K+9pAUSW2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PEzh9EDOy3eNaxUQ68haeLMmOfEcBFnj+H7W5kGB3D4=;
 b=Abr+hkglukMOXfJNO6PvcfdAZP5W8f0G6ZewhIprPyUhiS0pOVpqX4HVBbixsVNyvGADIrrXCLJkYeIZrReZ/TmOjvYF516Tz48O1BqevLbrwcEDP4XlcUPSHGfPiA6gmfzPUSnqF6A7hfz06CYICc6fNYGa+UqV3uHzLInFZQGN2eV/FSdLRb4MhozbYNqCoeRAWshzaij8apcNulPJfi+aUCnQ/FNoNlRd41kcloZeWFOJCJRDlFFeTLKCucE05Il9adyb68vIjXFQdsDJY0US4QCkBuFHDy94jJbk9dNeH04SFgr+8147wHlA8TnANnaONXmUHLutIQq0PLvrDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PEzh9EDOy3eNaxUQ68haeLMmOfEcBFnj+H7W5kGB3D4=;
 b=5HxJ2j0JgLi9EClKzUIKY+NfVbVoB6gI3ufqzRd9OftQJgnID0Kk5Z3saVlq93jEnBvzAW6rsTP0RTv9NZW2YCchYUOa0d0FIqreawvv9+0tby3/Qno/5qradZHtfkcpc9d+FEvfqQnHHKt8w9ajymozG6U/kczMelFdRdnJshU=
Received: from MW4PR03CA0092.namprd03.prod.outlook.com (2603:10b6:303:b7::7)
 by BYAPR12MB2695.namprd12.prod.outlook.com (2603:10b6:a03:71::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.26; Wed, 13 Jul
 2022 03:25:47 +0000
Received: from CO1NAM11FT066.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b7:cafe::e1) by MW4PR03CA0092.outlook.office365.com
 (2603:10b6:303:b7::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.26 via Frontend
 Transport; Wed, 13 Jul 2022 03:25:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT066.mail.protection.outlook.com (10.13.175.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5438.12 via Frontend Transport; Wed, 13 Jul 2022 03:25:47 +0000
Received: from thomas-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 12 Jul
 2022 22:25:43 -0500
From: YiPeng Chai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amdgpu: add umc v8_10_0 ip headers
Date: Wed, 13 Jul 2022 11:25:08 +0800
Message-ID: <20220713032509.293402-1-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5212b00f-3d47-4001-c176-08da647f60bb
X-MS-TrafficTypeDiagnostic: BYAPR12MB2695:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W6DvZtkR7KZkwNyGuF/URInN6aLcw0lijMGL4rHlTPkcjYsM8yRo4VgNXsxi2CnEJ7n6HlyhQUd7+4MPv+bevbZnlfksLyE7+4v5pPyK77t2dawahSYX27VyV88JgJo4WXJleCQHHlFiq7onWJJJ+AmeLIemXubxacMIt9U8BShW3VkHoDgfH7dMDPPJxPgof9z98cwRwR07sKaIwvjVDwxEPg4Dxgwvz6YDC6xXJkqoTYnWiFK1tEoUbHPQBlWs43hHImrf+BTSCiLLgy4RIdi2PJY12iun6sXnrx6q5QWzuSs+4b2a9XPzlngc5u9xSRWscgTXxSOEHnP4uVb7p2p3OLhTK0rCzPcAEdGvz2kKaST6ASLKJQkvU8DnBexl5bxP/OOoXW8hGXx8BNRhi13BXmT53U9WAewgKnkJjyX7jFCkS9E2w+w3fw0oBwA52XrIQN1z6gScTp0PzsNiEi75ENXoz/hX4qeLTvfgNHocB5Be4p+n/G3L7IhXfKUJfXKlNMsxlO8QyJeYPMqsC7wIKrS8jvlFvrsTGS38tpzYY1/q4H/v17Fx9MG8MXsuJxWvDElLCC5uGtnLl+yTz3lqgwgp4kHWNYjvbE627uEbXvMNOTG+2XspaLH6tJL5j6i25qUgMd4YD1qc4ZLivfi/4Gq7ARZCf72q/m4DQ+jfLCUfMp6zgcLknFF4dSk4v2Ku1e2DScg4ADpsMOQfHbAbVKJI9Jjq5S45jaCvBQVKoYBS+tOHSE4uBA3zvDJW2bzGnhixfwYwt0TLT5pcrYe/axC2yzzRdZrlszme4h+mg9/qRhfS31xlbzt3B+Xd+ILxFAJ/wi4gOHHQk3gsFaq2G0hKxdSlfY76iftb/II=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(136003)(376002)(39860400002)(346002)(36840700001)(46966006)(40470700004)(8936002)(40480700001)(36756003)(82310400005)(4326008)(2906002)(8676002)(86362001)(36860700001)(70586007)(40460700003)(54906003)(5660300002)(6916009)(316002)(19627235002)(26005)(6666004)(47076005)(7696005)(426003)(478600001)(82740400003)(2616005)(70206006)(41300700001)(356005)(83380400001)(336012)(186003)(16526019)(1076003)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2022 03:25:47.1013 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5212b00f-3d47-4001-c176-08da647f60bb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT066.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2695
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
Cc: Tao
 Zhou <tao.zhou1@amd.com>, YiPeng Chai <YiPeng.Chai@amd.com>, yipechai@amd.com,
 Alexander Deucher <Alexander.Deucher@amd.com>, Candice.Li@amd.com,
 John.Clements@amd.com, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add umc v8_10_0 register offset and shift masks
header files

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
Reviewed-by: Alexander Deucher <Alexander.Deucher@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
---
 .../include/asic_reg/umc/umc_8_10_0_offset.h  | 33 +++++++
 .../include/asic_reg/umc/umc_8_10_0_sh_mask.h | 94 +++++++++++++++++++
 2 files changed, 127 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/umc/umc_8_10_0_offset.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/umc/umc_8_10_0_sh_mask.h

diff --git a/drivers/gpu/drm/amd/include/asic_reg/umc/umc_8_10_0_offset.h b/drivers/gpu/drm/amd/include/asic_reg/umc/umc_8_10_0_offset.h
new file mode 100644
index 000000000000..b798cf5a2c39
--- /dev/null
+++ b/drivers/gpu/drm/amd/include/asic_reg/umc/umc_8_10_0_offset.h
@@ -0,0 +1,33 @@
+/*
+ * Copyright (C) 2022  Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included
+ * in all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
+ * OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN
+ * AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
+ * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
+ */
+#ifndef _umc_8_10_0_OFFSET_HEADER
+#define _umc_8_10_0_OFFSET_HEADER
+
+#define regUMCCH0_0_GeccErrCntSel                0x0328
+#define regUMCCH0_0_GeccErrCntSel_BASE_IDX       2
+#define regUMCCH0_0_GeccErrCnt                   0x0329
+#define regUMCCH0_0_GeccErrCnt_BASE_IDX          2
+#define regMCA_UMC_UMC0_MCUMC_STATUST0           0x03c2
+#define regMCA_UMC_UMC0_MCUMC_STATUST0_BASE_IDX  2
+#define regMCA_UMC_UMC0_MCUMC_ADDRT0             0x03c4
+#define regMCA_UMC_UMC0_MCUMC_ADDRT0_BASE_IDX    2
+
+#endif
diff --git a/drivers/gpu/drm/amd/include/asic_reg/umc/umc_8_10_0_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/umc/umc_8_10_0_sh_mask.h
new file mode 100644
index 000000000000..bd99b431247f
--- /dev/null
+++ b/drivers/gpu/drm/amd/include/asic_reg/umc/umc_8_10_0_sh_mask.h
@@ -0,0 +1,94 @@
+/*
+ * Copyright (C) 2022  Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included
+ * in all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
+ * OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN
+ * AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
+ * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
+ */
+#ifndef _umc_8_10_0_SH_MASK_HEADER
+#define _umc_8_10_0_SH_MASK_HEADER
+
+//UMCCH0_0_GeccErrCntSel
+#define UMCCH0_0_GeccErrCntSel__GeccErrInt__SHIFT    0xc
+#define UMCCH0_0_GeccErrCntSel__GeccErrCntEn__SHIFT  0xf
+#define UMCCH0_0_GeccErrCntSel__PoisonCntEn__SHIFT   0x10
+#define UMCCH0_0_GeccErrCntSel__GeccErrInt_MASK      0x00003000L
+#define UMCCH0_0_GeccErrCntSel__GeccErrCntEn_MASK    0x00008000L
+#define UMCCH0_0_GeccErrCntSel__PoisonCntEn_MASK     0x00030000L
+//UMCCH0_0_GeccErrCnt
+#define UMCCH0_0_GeccErrCnt__GeccErrCnt__SHIFT       0x0
+#define UMCCH0_0_GeccErrCnt__GeccUnCorrErrCnt__SHIFT 0x10
+#define UMCCH0_0_GeccErrCnt__GeccErrCnt_MASK         0x0000FFFFL
+#define UMCCH0_0_GeccErrCnt__GeccUnCorrErrCnt_MASK   0xFFFF0000L
+//MCA_UMC_UMC0_MCUMC_STATUST0
+#define MCA_UMC_UMC0_MCUMC_STATUST0__ErrorCode__SHIFT      0x0
+#define MCA_UMC_UMC0_MCUMC_STATUST0__ErrorCodeExt__SHIFT   0x10
+#define MCA_UMC_UMC0_MCUMC_STATUST0__RESERV22__SHIFT       0x16
+#define MCA_UMC_UMC0_MCUMC_STATUST0__AddrLsb__SHIFT        0x18
+#define MCA_UMC_UMC0_MCUMC_STATUST0__RESERV30__SHIFT       0x1e
+#define MCA_UMC_UMC0_MCUMC_STATUST0__ErrCoreId__SHIFT      0x20
+#define MCA_UMC_UMC0_MCUMC_STATUST0__RESERV38__SHIFT       0x26
+#define MCA_UMC_UMC0_MCUMC_STATUST0__Scrub__SHIFT          0x28
+#define MCA_UMC_UMC0_MCUMC_STATUST0__RESERV41__SHIFT       0x29
+#define MCA_UMC_UMC0_MCUMC_STATUST0__Poison__SHIFT         0x2b
+#define MCA_UMC_UMC0_MCUMC_STATUST0__Deferred__SHIFT       0x2c
+#define MCA_UMC_UMC0_MCUMC_STATUST0__UECC__SHIFT           0x2d
+#define MCA_UMC_UMC0_MCUMC_STATUST0__CECC__SHIFT           0x2e
+#define MCA_UMC_UMC0_MCUMC_STATUST0__RESERV47__SHIFT       0x2f
+#define MCA_UMC_UMC0_MCUMC_STATUST0__Transparent__SHIFT    0x34
+#define MCA_UMC_UMC0_MCUMC_STATUST0__SyndV__SHIFT          0x35
+#define MCA_UMC_UMC0_MCUMC_STATUST0__RESERV54__SHIFT       0x36
+#define MCA_UMC_UMC0_MCUMC_STATUST0__TCC__SHIFT            0x37
+#define MCA_UMC_UMC0_MCUMC_STATUST0__ErrCoreIdVal__SHIFT   0x38
+#define MCA_UMC_UMC0_MCUMC_STATUST0__PCC__SHIFT            0x39
+#define MCA_UMC_UMC0_MCUMC_STATUST0__AddrV__SHIFT          0x3a
+#define MCA_UMC_UMC0_MCUMC_STATUST0__MiscV__SHIFT          0x3b
+#define MCA_UMC_UMC0_MCUMC_STATUST0__En__SHIFT             0x3c
+#define MCA_UMC_UMC0_MCUMC_STATUST0__UC__SHIFT             0x3d
+#define MCA_UMC_UMC0_MCUMC_STATUST0__Overflow__SHIFT       0x3e
+#define MCA_UMC_UMC0_MCUMC_STATUST0__Val__SHIFT            0x3f
+#define MCA_UMC_UMC0_MCUMC_STATUST0__ErrorCode_MASK        0x000000000000FFFFL
+#define MCA_UMC_UMC0_MCUMC_STATUST0__ErrorCodeExt_MASK     0x00000000003F0000L
+#define MCA_UMC_UMC0_MCUMC_STATUST0__RESERV22_MASK         0x0000000000C00000L
+#define MCA_UMC_UMC0_MCUMC_STATUST0__AddrLsb_MASK          0x000000003F000000L
+#define MCA_UMC_UMC0_MCUMC_STATUST0__RESERV30_MASK         0x00000000C0000000L
+#define MCA_UMC_UMC0_MCUMC_STATUST0__ErrCoreId_MASK        0x0000003F00000000L
+#define MCA_UMC_UMC0_MCUMC_STATUST0__RESERV38_MASK         0x000000C000000000L
+#define MCA_UMC_UMC0_MCUMC_STATUST0__Scrub_MASK            0x0000010000000000L
+#define MCA_UMC_UMC0_MCUMC_STATUST0__RESERV41_MASK         0x0000060000000000L
+#define MCA_UMC_UMC0_MCUMC_STATUST0__Poison_MASK           0x0000080000000000L
+#define MCA_UMC_UMC0_MCUMC_STATUST0__Deferred_MASK         0x0000100000000000L
+#define MCA_UMC_UMC0_MCUMC_STATUST0__UECC_MASK             0x0000200000000000L
+#define MCA_UMC_UMC0_MCUMC_STATUST0__CECC_MASK             0x0000400000000000L
+#define MCA_UMC_UMC0_MCUMC_STATUST0__RESERV47_MASK         0x000F800000000000L
+#define MCA_UMC_UMC0_MCUMC_STATUST0__Transparent_MASK      0x0010000000000000L
+#define MCA_UMC_UMC0_MCUMC_STATUST0__SyndV_MASK            0x0020000000000000L
+#define MCA_UMC_UMC0_MCUMC_STATUST0__RESERV54_MASK         0x0040000000000000L
+#define MCA_UMC_UMC0_MCUMC_STATUST0__TCC_MASK              0x0080000000000000L
+#define MCA_UMC_UMC0_MCUMC_STATUST0__ErrCoreIdVal_MASK     0x0100000000000000L
+#define MCA_UMC_UMC0_MCUMC_STATUST0__PCC_MASK              0x0200000000000000L
+#define MCA_UMC_UMC0_MCUMC_STATUST0__AddrV_MASK            0x0400000000000000L
+#define MCA_UMC_UMC0_MCUMC_STATUST0__MiscV_MASK            0x0800000000000000L
+#define MCA_UMC_UMC0_MCUMC_STATUST0__En_MASK               0x1000000000000000L
+#define MCA_UMC_UMC0_MCUMC_STATUST0__UC_MASK               0x2000000000000000L
+#define MCA_UMC_UMC0_MCUMC_STATUST0__Overflow_MASK         0x4000000000000000L
+#define MCA_UMC_UMC0_MCUMC_STATUST0__Val_MASK              0x8000000000000000L
+//MCA_UMC_UMC0_MCUMC_ADDRT0
+#define MCA_UMC_UMC0_MCUMC_ADDRT0__ErrorAddr__SHIFT        0x0
+#define MCA_UMC_UMC0_MCUMC_ADDRT0__Reserved__SHIFT         0x38
+#define MCA_UMC_UMC0_MCUMC_ADDRT0__ErrorAddr_MASK          0x00FFFFFFFFFFFFFFL
+
+#endif
-- 
2.25.1

