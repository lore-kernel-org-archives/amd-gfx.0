Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 487ADC83F3F
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Sep 2023 07:20:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 79D6310E2A5;
	Mon,  4 Sep 2023 07:20:31 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2044.outbound.protection.outlook.com [40.107.94.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3687810E2A6
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Sep 2023 07:20:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ww+d9BL4Ffe6OYcpSFn7HK/x4z0TzRvw0D3fpiu/B69VRdIYrvhUp645X5i26dbScmxkhcozsXitfS1SvlLpKjp0P2jbj7plRWNmCw3aH1pdSC9Q5SYg1fKl3waBsKz/C99F1sa6CoLEeSziRP6wqkVpdAt8wsV3C1glij1hxPs1lJvQCJorDGckvGs4AowjPVdUVJebY0vkTwxaFi460VAAsohd58YjMvLs37YmpKi0HkzD/hRAC/eGM+FoVMLyIRe7mrrUa3T7iVgNqQxDYekgb1jEt4F9moYWvFPMsLYvk4WhHoEOQuv83jswm3pXMO6FWSPjwmRd9bwwPCA8Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TJCXrjPqZNHnVBUoc3Usyg/P5zRsogSlBR0nSoFJruE=;
 b=dob1+Ur+wyWgv5fpJmO21q+NyRUAW3VyXqBq/K33DdzV33FWYkfFW0dULp+yetyzUKAqHHs3/jvhbiIb9ijjWG+fUsI86XgVfoJW10UK3wH09U8rc05qkSLX3MnXQIV5cyvA+zQmnVZgmB0A2wv/6SyOUZ8E/quXV+idFr515CNkBCOJoLnnbbQY8awjdeQRkT99jCGoK0YcJmtvZvFz0761iCi9ChuGKXHsMzhfDsVyDcIZvsH0tu6rqYDzVWb70pfKAzQ0+zKgcQE1uMGHc+TUyHzjUWyYVp52dp82OkGyIq9fRpf7kywz5YkSDrRpQ02OaS+PTgbjT1KMvuSgCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TJCXrjPqZNHnVBUoc3Usyg/P5zRsogSlBR0nSoFJruE=;
 b=RrX5IbdWkmktSI9xmnJk/UCjwbNsk3LVBNqKEKoC6Lhj7nhlLJO4Te4cScCIy7RZA+MAwpaOmIDmnEKzhLnb1sMhQnhWNfyBa28C1VJ6XwEgG6A5l7+3lRdHMjf6WknOyxY8HPJoOiLXJTeqyfaPJTAhxD04n4WupP3oC0w9YM4=
Received: from DM6PR03CA0032.namprd03.prod.outlook.com (2603:10b6:5:40::45) by
 PH7PR12MB8038.namprd12.prod.outlook.com (2603:10b6:510:27c::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6745.33; Mon, 4 Sep 2023 07:20:15 +0000
Received: from CY4PEPF0000EE3B.namprd03.prod.outlook.com
 (2603:10b6:5:40:cafe::e3) by DM6PR03CA0032.outlook.office365.com
 (2603:10b6:5:40::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33 via Frontend
 Transport; Mon, 4 Sep 2023 07:20:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3B.mail.protection.outlook.com (10.167.242.15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6768.25 via Frontend Transport; Mon, 4 Sep 2023 07:20:14 +0000
Received: from canli-build.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 4 Sep
 2023 02:20:12 -0500
From: Candice Li <candice.li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/3] drm/amd: Add umc v12_0_0 ip headers
Date: Mon, 4 Sep 2023 15:20:00 +0800
Message-ID: <20230904072000.59097-1-candice.li@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3B:EE_|PH7PR12MB8038:EE_
X-MS-Office365-Filtering-Correlation-Id: 65a52825-cd63-4d8d-960a-08dbad176257
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XUneRBk5axqHkz8dc1NyBPFnwXSU6rTuMYH+FsLbmuP2WOh1dhe+JAu/gejNmHmY0wkldUTngGIz3fFVJw0cwwRzzFI8p5pqAUs9o3/4HKwEWleNeBn4VGomq6b9q5kFItBWqlHm+s+bFpgaC7UuUzEK+JGgohPcDkZE37Wu0T5dcMmhQAejTLN9O8kZEL5lcGtYlNzB7QEe8cc5byzzuh5NMGft31TzldXCAmp1nMfEXgGA8wee0BciLFbUdFvlgjkRiWJchgnmBbA4l8cp7JtKvn2iR5BIO5mtVc9574PUmay+zjpshxFGQUvyQSKzuwqkhIB/YNis2v0Ww+L5o/VENf/+WTDNTT24mf5ooDIrjN5jYPr4fyLcMwcSPQkpBHZNw+wG9M4l9dMa1Ak8g3ZpaBxBO4s8NVlHmRBDBxa18tRUxEg1uTw/46H2AuT+ani3O5333R6CQIXKLD1oM0QzjDdfGxa0TfbjCgSa3BTbicV7StG1be/WF8oRBHCrdUnp2g9xTwhWxJSVMhI097567PAqrQzPylEj30cDWuwe0kwwa/UFJS9V9Xk/SVho7I3Wdz7WmKA0r7QKZg+ZsGbjkIUABfuA31jIKCy9ehOOFHAkKwnHd48Fc1rLIY2iyS+HUiXuG3UiNHLy4jeBJfA+FhN4dWESAlCYKweasoaZfJVrQxIEj4WX9ZzUw0vcvTjROEoOnNuI77aN6ghU3xAKTvJr1k13fFBThG1on1+bSampmU6yVOkjSJ2qSKtamhlRTe8a4GY3Ap4wVuO3zg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(346002)(136003)(376002)(396003)(451199024)(1800799009)(186009)(82310400011)(36840700001)(46966006)(40470700004)(8936002)(41300700001)(40480700001)(83380400001)(19627235002)(44832011)(478600001)(6666004)(2906002)(70206006)(70586007)(5660300002)(8676002)(54906003)(6916009)(316002)(4326008)(2616005)(1076003)(7696005)(40460700003)(16526019)(26005)(36860700001)(336012)(426003)(66899024)(36756003)(82740400003)(356005)(81166007)(86362001)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2023 07:20:14.7723 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 65a52825-cd63-4d8d-960a-08dbad176257
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8038
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
Cc: Tao Zhou <tao.zhou1@amd.com>, Candice Li <candice.li@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add umc v12_0_0 ip headers.

Signed-off-by: Candice Li <candice.li@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
---
 .../include/asic_reg/umc/umc_12_0_0_offset.h  | 33 +++++++
 .../include/asic_reg/umc/umc_12_0_0_sh_mask.h | 95 +++++++++++++++++++
 2 files changed, 128 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/umc/umc_12_0_0_offset.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/umc/umc_12_0_0_sh_mask.h

diff --git a/drivers/gpu/drm/amd/include/asic_reg/umc/umc_12_0_0_offset.h b/drivers/gpu/drm/amd/include/asic_reg/umc/umc_12_0_0_offset.h
new file mode 100644
index 00000000000000..2913127c03d52b
--- /dev/null
+++ b/drivers/gpu/drm/amd/include/asic_reg/umc/umc_12_0_0_offset.h
@@ -0,0 +1,33 @@
+/*
+ * Copyright (C) 2023  Advanced Micro Devices, Inc.
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
+#ifndef _umc_12_0_0_OFFSET_HEADER
+#define _umc_12_0_0_OFFSET_HEADER
+
+#define regUMCCH0_OdEccCntSel                                                   0x032c
+#define regUMCCH0_OdEccCntSel_BASE_IDX                                          0
+#define regUMCCH0_OdEccErrCnt                                                   0x032d
+#define regUMCCH0_OdEccErrCnt_BASE_IDX                                          0
+#define regMCA_UMC_UMC0_MCUMC_STATUST0                                          0x03c2
+#define regMCA_UMC_UMC0_MCUMC_STATUST0_BASE_IDX                                 0
+#define regMCA_UMC_UMC0_MCUMC_ADDRT0                                            0x03c4
+#define regMCA_UMC_UMC0_MCUMC_ADDRT0_BASE_IDX                                   0
+
+#endif
diff --git a/drivers/gpu/drm/amd/include/asic_reg/umc/umc_12_0_0_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/umc/umc_12_0_0_sh_mask.h
new file mode 100644
index 00000000000000..14bbee775032ab
--- /dev/null
+++ b/drivers/gpu/drm/amd/include/asic_reg/umc/umc_12_0_0_sh_mask.h
@@ -0,0 +1,95 @@
+/*
+ * Copyright (C) 2023  Advanced Micro Devices, Inc.
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
+#ifndef _umc_12_0_0_SH_MASK_HEADER
+#define _umc_12_0_0_SH_MASK_HEADER
+
+//UMCCH0_OdEccCntSel
+#define UMCCH0_OdEccCntSel__OdEccCntSel__SHIFT                                 0x0
+#define UMCCH0_OdEccCntSel__OdEccErrInt__SHIFT                                 0x4
+#define UMCCH0_OdEccCntSel__OdEccCntSel_MASK                                   0x00000007L
+#define UMCCH0_OdEccCntSel__OdEccErrInt_MASK                                   0x00000030L
+//UMCCH0_OdEccErrCnt
+#define UMCCH0_OdEccErrCnt__Cnt__SHIFT                                         0x0
+#define UMCCH0_OdEccErrCnt__CntOvr__SHIFT                                      0x10
+#define UMCCH0_OdEccErrCnt__OvrClr__SHIFT                                      0x11
+#define UMCCH0_OdEccErrCnt__Cnt_MASK                                           0x0000FFFFL
+#define UMCCH0_OdEccErrCnt__CntOvr_MASK                                        0x00010000L
+#define UMCCH0_OdEccErrCnt__OvrClr_MASK                                        0x00020000L
+//MCA_UMC_UMC0_MCUMC_STATUST0
+#define MCA_UMC_UMC0_MCUMC_STATUST0__ErrorCode__SHIFT                          0x0
+#define MCA_UMC_UMC0_MCUMC_STATUST0__ErrorCodeExt__SHIFT                       0x10
+#define MCA_UMC_UMC0_MCUMC_STATUST0__RESERV22__SHIFT                           0x16
+#define MCA_UMC_UMC0_MCUMC_STATUST0__AddrLsb__SHIFT                            0x18
+#define MCA_UMC_UMC0_MCUMC_STATUST0__RESERV30__SHIFT                           0x1e
+#define MCA_UMC_UMC0_MCUMC_STATUST0__ErrCoreId__SHIFT                          0x20
+#define MCA_UMC_UMC0_MCUMC_STATUST0__RESERV38__SHIFT                           0x26
+#define MCA_UMC_UMC0_MCUMC_STATUST0__Scrub__SHIFT                              0x28
+#define MCA_UMC_UMC0_MCUMC_STATUST0__RESERV41__SHIFT                           0x29
+#define MCA_UMC_UMC0_MCUMC_STATUST0__Poison__SHIFT                             0x2b
+#define MCA_UMC_UMC0_MCUMC_STATUST0__Deferred__SHIFT                           0x2c
+#define MCA_UMC_UMC0_MCUMC_STATUST0__UECC__SHIFT                               0x2d
+#define MCA_UMC_UMC0_MCUMC_STATUST0__CECC__SHIFT                               0x2e
+#define MCA_UMC_UMC0_MCUMC_STATUST0__RESERV47__SHIFT                           0x2f
+#define MCA_UMC_UMC0_MCUMC_STATUST0__Transparent__SHIFT                        0x34
+#define MCA_UMC_UMC0_MCUMC_STATUST0__SyndV__SHIFT                              0x35
+#define MCA_UMC_UMC0_MCUMC_STATUST0__RESERV54__SHIFT                           0x36
+#define MCA_UMC_UMC0_MCUMC_STATUST0__TCC__SHIFT                                0x37
+#define MCA_UMC_UMC0_MCUMC_STATUST0__ErrCoreIdVal__SHIFT                       0x38
+#define MCA_UMC_UMC0_MCUMC_STATUST0__PCC__SHIFT                                0x39
+#define MCA_UMC_UMC0_MCUMC_STATUST0__AddrV__SHIFT                              0x3a
+#define MCA_UMC_UMC0_MCUMC_STATUST0__MiscV__SHIFT                              0x3b
+#define MCA_UMC_UMC0_MCUMC_STATUST0__En__SHIFT                                 0x3c
+#define MCA_UMC_UMC0_MCUMC_STATUST0__UC__SHIFT                                 0x3d
+#define MCA_UMC_UMC0_MCUMC_STATUST0__Overflow__SHIFT                           0x3e
+#define MCA_UMC_UMC0_MCUMC_STATUST0__Val__SHIFT                                0x3f
+#define MCA_UMC_UMC0_MCUMC_STATUST0__ErrorCode_MASK                            0x000000000000FFFFL
+#define MCA_UMC_UMC0_MCUMC_STATUST0__ErrorCodeExt_MASK                         0x00000000003F0000L
+#define MCA_UMC_UMC0_MCUMC_STATUST0__RESERV22_MASK                             0x0000000000C00000L
+#define MCA_UMC_UMC0_MCUMC_STATUST0__AddrLsb_MASK                              0x000000003F000000L
+#define MCA_UMC_UMC0_MCUMC_STATUST0__RESERV30_MASK                             0x00000000C0000000L
+#define MCA_UMC_UMC0_MCUMC_STATUST0__ErrCoreId_MASK                            0x0000003F00000000L
+#define MCA_UMC_UMC0_MCUMC_STATUST0__RESERV38_MASK                             0x000000C000000000L
+#define MCA_UMC_UMC0_MCUMC_STATUST0__Scrub_MASK                                0x0000010000000000L
+#define MCA_UMC_UMC0_MCUMC_STATUST0__RESERV41_MASK                             0x0000060000000000L
+#define MCA_UMC_UMC0_MCUMC_STATUST0__Poison_MASK                               0x0000080000000000L
+#define MCA_UMC_UMC0_MCUMC_STATUST0__Deferred_MASK                             0x0000100000000000L
+#define MCA_UMC_UMC0_MCUMC_STATUST0__UECC_MASK                                 0x0000200000000000L
+#define MCA_UMC_UMC0_MCUMC_STATUST0__CECC_MASK                                 0x0000400000000000L
+#define MCA_UMC_UMC0_MCUMC_STATUST0__RESERV47_MASK                             0x000F800000000000L
+#define MCA_UMC_UMC0_MCUMC_STATUST0__Transparent_MASK                          0x0010000000000000L
+#define MCA_UMC_UMC0_MCUMC_STATUST0__SyndV_MASK                                0x0020000000000000L
+#define MCA_UMC_UMC0_MCUMC_STATUST0__RESERV54_MASK                             0x0040000000000000L
+#define MCA_UMC_UMC0_MCUMC_STATUST0__TCC_MASK                                  0x0080000000000000L
+#define MCA_UMC_UMC0_MCUMC_STATUST0__ErrCoreIdVal_MASK                         0x0100000000000000L
+#define MCA_UMC_UMC0_MCUMC_STATUST0__PCC_MASK                                  0x0200000000000000L
+#define MCA_UMC_UMC0_MCUMC_STATUST0__AddrV_MASK                                0x0400000000000000L
+#define MCA_UMC_UMC0_MCUMC_STATUST0__MiscV_MASK                                0x0800000000000000L
+#define MCA_UMC_UMC0_MCUMC_STATUST0__En_MASK                                   0x1000000000000000L
+#define MCA_UMC_UMC0_MCUMC_STATUST0__UC_MASK                                   0x2000000000000000L
+#define MCA_UMC_UMC0_MCUMC_STATUST0__Overflow_MASK                             0x4000000000000000L
+#define MCA_UMC_UMC0_MCUMC_STATUST0__Val_MASK                                  0x8000000000000000L
+//MCA_UMC_UMC0_MCUMC_ADDRT0
+#define MCA_UMC_UMC0_MCUMC_ADDRT0__ErrorAddr__SHIFT                            0x0
+#define MCA_UMC_UMC0_MCUMC_ADDRT0__Reserved__SHIFT                             0x38
+#define MCA_UMC_UMC0_MCUMC_ADDRT0__ErrorAddr_MASK                              0x00FFFFFFFFFFFFFFL
+#define MCA_UMC_UMC0_MCUMC_ADDRT0__Reserved_MASK                               0xFF00000000000000L
+
+#endif
-- 
2.25.1

