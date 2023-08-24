Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D703C71153
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Aug 2023 15:10:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B1E5D10E575;
	Thu, 24 Aug 2023 15:10:37 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20609.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::609])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E4C410E575
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Aug 2023 15:10:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZFNOrLuPmepDbHTlAl4Ik8RWaL0bKwyNxxw7bVdMvyl9Q4N86dVm1QLFjRyboX9MzPxtDDC3gv3VALzkGpYPCujg1GW/TtfAOi5hUSRc1d96gRqXzsAnIde/GulytDCiBWRCEaMkKv6kYyjGNA2vwgceY9tlqwGG5NcODj5L4POBEhtDxyKnIMjyZilIcRgyjbsYLCIE/ACqtUcaKxX21K3BY38ulMdG3KJDUcQzfzKIk0PM4TsCSifwGzki5yZ1WUgJZQFXqpz4lPd+KY684oJhhIpa7IbvAgY5JtC3ed3A2yMOZSss2J5IhNWDFx7yxKkYxZfY5AiCk0Bm5b71yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BGPnSQfDCdnFJOKmflCxx0NncFLuhrmr3awAPxX7u/c=;
 b=RRl02OyL/ChkIbDCm3SdZx7VwTm/uytx/YQKBolfeRiD0oTrkWTVTfve2gGLl+FjKC1ttB43tz08nIcl4XRC917wFEvEDj+8cS3DXvTIJfpmJQv53LN8U1W26aSyz39WtjDpOrrSxDHhZHl/2//bmn12rIgLv7iNStlLPDwXRiCfzgIOatg4jqlrw/OM75eli3TVmf8VZ7ibFqDYOlw8mL6K7Co8cYD+nLT9J5pmH3LOtOZq4eFFzhf41eM9f11mb4nBm/o5356oykiWmTS6a7V5NsUb+kL1C+KRoyblxh+QqYWuen3mI5iOJB1yQ7j4iGMqxZBYY/MBExjw6Zc2OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 165.204.84.17)
 smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=temperror action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BGPnSQfDCdnFJOKmflCxx0NncFLuhrmr3awAPxX7u/c=;
 b=rWf9sFzPBPCkSzy4r6xCWqSJV0UB10ROdieBQJkPfN8wpHHo/hUTWtXpjUuDn3Dtr7YLtA3sx4lWlkBwUzoMb+GbBLkTXAMVjA0LV3RHyJje5/lQCrLNrflYCdaL++lr9BjzaLaRxftOI8uFleht4wqbdWnGh3TeRTD9D9Gj4lc=
Received: from SJ0PR03CA0298.namprd03.prod.outlook.com (2603:10b6:a03:39e::33)
 by MN2PR12MB4270.namprd12.prod.outlook.com (2603:10b6:208:1d9::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Thu, 24 Aug
 2023 15:10:30 +0000
Received: from MWH0EPF000971E2.namprd02.prod.outlook.com
 (2603:10b6:a03:39e:cafe::65) by SJ0PR03CA0298.outlook.office365.com
 (2603:10b6:a03:39e::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20 via Frontend
 Transport; Thu, 24 Aug 2023 15:10:30 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=temperror action=none header.from=amd.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of amd.com: DNS Timeout)
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E2.mail.protection.outlook.com (10.167.243.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.15 via Frontend Transport; Thu, 24 Aug 2023 15:10:28 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 24 Aug
 2023 10:10:26 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: add header files for MP 14.0.0
Date: Thu, 24 Aug 2023 11:09:43 -0400
Message-ID: <20230824150943.2651472-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E2:EE_|MN2PR12MB4270:EE_
X-MS-Office365-Filtering-Correlation-Id: d360268f-6309-48dc-fc87-08dba4b44073
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VrlFc+47C92dS7fkTfU3eq/hSJ5EcjPIC8GjFk+PhK8BwH+2YaW26yaxgini37gPS6cNycVnDYNiKfMnAd6g3RbjaFnhaQ3IzZqk+5KY0VVpOsHp04u+4RBY4YeQ7EZ1Adm87ej0ZvKWrjsopWDzN3dEPAWxRVy1Qwa5soXlXBuaSuRbFwkQZRodB0GnDvuARfB96mwsXid/StqGIbismgBVjuLYxOmR/CSbmr/02foF1KF8eKq3lpjW/pILmgZ+nrnZKu9uCjurvYdNBkUO3UTmjPR6eNT8eiq1ZWAJ+gWSGIpJYY41KB91ntzTjhMkhE1l91qC8TQTMpK7QRA1S/E5p4t2dqkGgUDJZrPLSOTNBWetW0X2J+b2tG0p5I6TiqM6p+1EkHD07G5zTZdMudUPWVaX7qv5ZSoBKIVKV8a5sxxERStad/ipwjENkG2lyCvxB7TqSA1dAwoKzkbauCpOr1Z+VNnPP4LK5jr7OpaBtOX2uJ3tCN1cxeLT6d340RaJHYZmbsE2fQ0c95Fj3CCkRHlewnU1KgNR6GFUPTNvFv8AZDGO6VIUN75WR7T5e6/qSrP7scstaaoFuxyD/nHJee25Bi1xtFSuwZ2X6iOY3VhJzwzcF0cHqeBAxQJpQn68DfDshyYXNlT5jtvl79/TleN2bmS0SGDow0QUPO7KJ6EGNMhVk+mYXPPPZ4q9DM632JxNqdal8VCtn/0szUtISpUyrDPecVKsTj8KQ90+UJZFRaE1e16tfq0RVqWO/KpJ5xVwxrEqOl0l3l4E3g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(346002)(136003)(396003)(376002)(1800799009)(82310400011)(451199024)(186009)(40470700004)(36840700001)(46966006)(336012)(40480700001)(66899024)(2616005)(6916009)(54906003)(41300700001)(81166007)(70586007)(70206006)(40460700003)(6666004)(316002)(82740400003)(7696005)(356005)(1076003)(26005)(16526019)(8676002)(63350400001)(8936002)(5660300002)(36860700001)(4326008)(426003)(47076005)(83380400001)(30864003)(2906002)(63370400001)(19627235002)(86362001)(36756003)(478600001)(36900700001)(559001)(579004);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2023 15:10:28.4062 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d360268f-6309-48dc-fc87-08dba4b44073
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4270
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Li Ma <li.ma@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Li Ma <li.ma@amd.com>

This patch will add header files for MP 14.0.0.

v2: updates (Alex)

Signed-off-by: Li Ma <li.ma@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../include/asic_reg/mp/mp_14_0_0_offset.h    | 359 ++++++++++++
 .../include/asic_reg/mp/mp_14_0_0_sh_mask.h   | 534 ++++++++++++++++++
 2 files changed, 893 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/mp/mp_14_0_0_offset.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/mp/mp_14_0_0_sh_mask.h

diff --git a/drivers/gpu/drm/amd/include/asic_reg/mp/mp_14_0_0_offset.h b/drivers/gpu/drm/amd/include/asic_reg/mp/mp_14_0_0_offset.h
new file mode 100644
index 000000000000..920de67dd1e8
--- /dev/null
+++ b/drivers/gpu/drm/amd/include/asic_reg/mp/mp_14_0_0_offset.h
@@ -0,0 +1,359 @@
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
+ *
+ */
+#ifndef _mp_14_0_0_OFFSET_HEADER
+#define _mp_14_0_0_OFFSET_HEADER
+
+// addressBlock: mp_SmuMp1_SmnDec
+// base address: 0x0
+#define regMP1_SMN_C2PMSG_0                                                                             0x0240
+#define regMP1_SMN_C2PMSG_0_BASE_IDX                                                                    0
+#define regMP1_SMN_C2PMSG_1                                                                             0x0241
+#define regMP1_SMN_C2PMSG_1_BASE_IDX                                                                    0
+#define regMP1_SMN_C2PMSG_2                                                                             0x0242
+#define regMP1_SMN_C2PMSG_2_BASE_IDX                                                                    0
+#define regMP1_SMN_C2PMSG_3                                                                             0x0243
+#define regMP1_SMN_C2PMSG_3_BASE_IDX                                                                    0
+#define regMP1_SMN_C2PMSG_4                                                                             0x0244
+#define regMP1_SMN_C2PMSG_4_BASE_IDX                                                                    0
+#define regMP1_SMN_C2PMSG_5                                                                             0x0245
+#define regMP1_SMN_C2PMSG_5_BASE_IDX                                                                    0
+#define regMP1_SMN_C2PMSG_6                                                                             0x0246
+#define regMP1_SMN_C2PMSG_6_BASE_IDX                                                                    0
+#define regMP1_SMN_C2PMSG_7                                                                             0x0247
+#define regMP1_SMN_C2PMSG_7_BASE_IDX                                                                    0
+#define regMP1_SMN_C2PMSG_8                                                                             0x0248
+#define regMP1_SMN_C2PMSG_8_BASE_IDX                                                                    0
+#define regMP1_SMN_C2PMSG_9                                                                             0x0249
+#define regMP1_SMN_C2PMSG_9_BASE_IDX                                                                    0
+#define regMP1_SMN_C2PMSG_10                                                                            0x024a
+#define regMP1_SMN_C2PMSG_10_BASE_IDX                                                                   0
+#define regMP1_SMN_C2PMSG_11                                                                            0x024b
+#define regMP1_SMN_C2PMSG_11_BASE_IDX                                                                   0
+#define regMP1_SMN_C2PMSG_12                                                                            0x024c
+#define regMP1_SMN_C2PMSG_12_BASE_IDX                                                                   0
+#define regMP1_SMN_C2PMSG_13                                                                            0x024d
+#define regMP1_SMN_C2PMSG_13_BASE_IDX                                                                   0
+#define regMP1_SMN_C2PMSG_14                                                                            0x024e
+#define regMP1_SMN_C2PMSG_14_BASE_IDX                                                                   0
+#define regMP1_SMN_C2PMSG_15                                                                            0x024f
+#define regMP1_SMN_C2PMSG_15_BASE_IDX                                                                   0
+#define regMP1_SMN_C2PMSG_16                                                                            0x0250
+#define regMP1_SMN_C2PMSG_16_BASE_IDX                                                                   0
+#define regMP1_SMN_C2PMSG_17                                                                            0x0251
+#define regMP1_SMN_C2PMSG_17_BASE_IDX                                                                   0
+#define regMP1_SMN_C2PMSG_18                                                                            0x0252
+#define regMP1_SMN_C2PMSG_18_BASE_IDX                                                                   0
+#define regMP1_SMN_C2PMSG_19                                                                            0x0253
+#define regMP1_SMN_C2PMSG_19_BASE_IDX                                                                   0
+#define regMP1_SMN_C2PMSG_20                                                                            0x0254
+#define regMP1_SMN_C2PMSG_20_BASE_IDX                                                                   0
+#define regMP1_SMN_C2PMSG_21                                                                            0x0255
+#define regMP1_SMN_C2PMSG_21_BASE_IDX                                                                   0
+#define regMP1_SMN_C2PMSG_22                                                                            0x0256
+#define regMP1_SMN_C2PMSG_22_BASE_IDX                                                                   0
+#define regMP1_SMN_C2PMSG_23                                                                            0x0257
+#define regMP1_SMN_C2PMSG_23_BASE_IDX                                                                   0
+#define regMP1_SMN_C2PMSG_24                                                                            0x0258
+#define regMP1_SMN_C2PMSG_24_BASE_IDX                                                                   0
+#define regMP1_SMN_C2PMSG_25                                                                            0x0259
+#define regMP1_SMN_C2PMSG_25_BASE_IDX                                                                   0
+#define regMP1_SMN_C2PMSG_26                                                                            0x025a
+#define regMP1_SMN_C2PMSG_26_BASE_IDX                                                                   0
+#define regMP1_SMN_C2PMSG_27                                                                            0x025b
+#define regMP1_SMN_C2PMSG_27_BASE_IDX                                                                   0
+#define regMP1_SMN_C2PMSG_28                                                                            0x025c
+#define regMP1_SMN_C2PMSG_28_BASE_IDX                                                                   0
+#define regMP1_SMN_C2PMSG_29                                                                            0x025d
+#define regMP1_SMN_C2PMSG_29_BASE_IDX                                                                   0
+#define regMP1_SMN_C2PMSG_30                                                                            0x025e
+#define regMP1_SMN_C2PMSG_30_BASE_IDX                                                                   0
+#define regMP1_SMN_C2PMSG_31                                                                            0x025f
+#define regMP1_SMN_C2PMSG_31_BASE_IDX                                                                   0
+#define regMP1_SMN_C2PMSG_32                                                                            0x0260
+#define regMP1_SMN_C2PMSG_32_BASE_IDX                                                                   0
+#define regMP1_SMN_C2PMSG_33                                                                            0x0261
+#define regMP1_SMN_C2PMSG_33_BASE_IDX                                                                   0
+#define regMP1_SMN_C2PMSG_34                                                                            0x0262
+#define regMP1_SMN_C2PMSG_34_BASE_IDX                                                                   0
+#define regMP1_SMN_C2PMSG_35                                                                            0x0263
+#define regMP1_SMN_C2PMSG_35_BASE_IDX                                                                   0
+#define regMP1_SMN_C2PMSG_36                                                                            0x0264
+#define regMP1_SMN_C2PMSG_36_BASE_IDX                                                                   0
+#define regMP1_SMN_C2PMSG_37                                                                            0x0265
+#define regMP1_SMN_C2PMSG_37_BASE_IDX                                                                   0
+#define regMP1_SMN_C2PMSG_38                                                                            0x0266
+#define regMP1_SMN_C2PMSG_38_BASE_IDX                                                                   0
+#define regMP1_SMN_C2PMSG_39                                                                            0x0267
+#define regMP1_SMN_C2PMSG_39_BASE_IDX                                                                   0
+#define regMP1_SMN_C2PMSG_40                                                                            0x0268
+#define regMP1_SMN_C2PMSG_40_BASE_IDX                                                                   0
+#define regMP1_SMN_C2PMSG_41                                                                            0x0269
+#define regMP1_SMN_C2PMSG_41_BASE_IDX                                                                   0
+#define regMP1_SMN_C2PMSG_42                                                                            0x026a
+#define regMP1_SMN_C2PMSG_42_BASE_IDX                                                                   0
+#define regMP1_SMN_C2PMSG_43                                                                            0x026b
+#define regMP1_SMN_C2PMSG_43_BASE_IDX                                                                   0
+#define regMP1_SMN_C2PMSG_44                                                                            0x026c
+#define regMP1_SMN_C2PMSG_44_BASE_IDX                                                                   0
+#define regMP1_SMN_C2PMSG_45                                                                            0x026d
+#define regMP1_SMN_C2PMSG_45_BASE_IDX                                                                   0
+#define regMP1_SMN_C2PMSG_46                                                                            0x026e
+#define regMP1_SMN_C2PMSG_46_BASE_IDX                                                                   0
+#define regMP1_SMN_C2PMSG_47                                                                            0x026f
+#define regMP1_SMN_C2PMSG_47_BASE_IDX                                                                   0
+#define regMP1_SMN_C2PMSG_48                                                                            0x0270
+#define regMP1_SMN_C2PMSG_48_BASE_IDX                                                                   0
+#define regMP1_SMN_C2PMSG_49                                                                            0x0271
+#define regMP1_SMN_C2PMSG_49_BASE_IDX                                                                   0
+#define regMP1_SMN_C2PMSG_50                                                                            0x0272
+#define regMP1_SMN_C2PMSG_50_BASE_IDX                                                                   0
+#define regMP1_SMN_C2PMSG_51                                                                            0x0273
+#define regMP1_SMN_C2PMSG_51_BASE_IDX                                                                   0
+#define regMP1_SMN_C2PMSG_52                                                                            0x0274
+#define regMP1_SMN_C2PMSG_52_BASE_IDX                                                                   0
+#define regMP1_SMN_C2PMSG_53                                                                            0x0275
+#define regMP1_SMN_C2PMSG_53_BASE_IDX                                                                   0
+#define regMP1_SMN_C2PMSG_54                                                                            0x0276
+#define regMP1_SMN_C2PMSG_54_BASE_IDX                                                                   0
+#define regMP1_SMN_C2PMSG_55                                                                            0x0277
+#define regMP1_SMN_C2PMSG_55_BASE_IDX                                                                   0
+#define regMP1_SMN_C2PMSG_56                                                                            0x0278
+#define regMP1_SMN_C2PMSG_56_BASE_IDX                                                                   0
+#define regMP1_SMN_C2PMSG_57                                                                            0x0279
+#define regMP1_SMN_C2PMSG_57_BASE_IDX                                                                   0
+#define regMP1_SMN_C2PMSG_58                                                                            0x027a
+#define regMP1_SMN_C2PMSG_58_BASE_IDX                                                                   0
+#define regMP1_SMN_C2PMSG_59                                                                            0x027b
+#define regMP1_SMN_C2PMSG_59_BASE_IDX                                                                   0
+#define regMP1_SMN_C2PMSG_60                                                                            0x027c
+#define regMP1_SMN_C2PMSG_60_BASE_IDX                                                                   0
+#define regMP1_SMN_C2PMSG_61                                                                            0x027d
+#define regMP1_SMN_C2PMSG_61_BASE_IDX                                                                   0
+#define regMP1_SMN_C2PMSG_62                                                                            0x027e
+#define regMP1_SMN_C2PMSG_62_BASE_IDX                                                                   0
+#define regMP1_SMN_C2PMSG_63                                                                            0x027f
+#define regMP1_SMN_C2PMSG_63_BASE_IDX                                                                   0
+#define regMP1_SMN_C2PMSG_64                                                                            0x0280
+#define regMP1_SMN_C2PMSG_64_BASE_IDX                                                                   0
+#define regMP1_SMN_C2PMSG_65                                                                            0x0281
+#define regMP1_SMN_C2PMSG_65_BASE_IDX                                                                   0
+#define regMP1_SMN_C2PMSG_66                                                                            0x0282
+#define regMP1_SMN_C2PMSG_66_BASE_IDX                                                                   0
+#define regMP1_SMN_C2PMSG_67                                                                            0x0283
+#define regMP1_SMN_C2PMSG_67_BASE_IDX                                                                   0
+#define regMP1_SMN_C2PMSG_68                                                                            0x0284
+#define regMP1_SMN_C2PMSG_68_BASE_IDX                                                                   0
+#define regMP1_SMN_C2PMSG_69                                                                            0x0285
+#define regMP1_SMN_C2PMSG_69_BASE_IDX                                                                   0
+#define regMP1_SMN_C2PMSG_70                                                                            0x0286
+#define regMP1_SMN_C2PMSG_70_BASE_IDX                                                                   0
+#define regMP1_SMN_C2PMSG_71                                                                            0x0287
+#define regMP1_SMN_C2PMSG_71_BASE_IDX                                                                   0
+#define regMP1_SMN_C2PMSG_72                                                                            0x0288
+#define regMP1_SMN_C2PMSG_72_BASE_IDX                                                                   0
+#define regMP1_SMN_C2PMSG_73                                                                            0x0289
+#define regMP1_SMN_C2PMSG_73_BASE_IDX                                                                   0
+#define regMP1_SMN_C2PMSG_74                                                                            0x028a
+#define regMP1_SMN_C2PMSG_74_BASE_IDX                                                                   0
+#define regMP1_SMN_C2PMSG_75                                                                            0x028b
+#define regMP1_SMN_C2PMSG_75_BASE_IDX                                                                   0
+#define regMP1_SMN_C2PMSG_76                                                                            0x028c
+#define regMP1_SMN_C2PMSG_76_BASE_IDX                                                                   0
+#define regMP1_SMN_C2PMSG_77                                                                            0x028d
+#define regMP1_SMN_C2PMSG_77_BASE_IDX                                                                   0
+#define regMP1_SMN_C2PMSG_78                                                                            0x028e
+#define regMP1_SMN_C2PMSG_78_BASE_IDX                                                                   0
+#define regMP1_SMN_C2PMSG_79                                                                            0x028f
+#define regMP1_SMN_C2PMSG_79_BASE_IDX                                                                   0
+#define regMP1_SMN_C2PMSG_80                                                                            0x0290
+#define regMP1_SMN_C2PMSG_80_BASE_IDX                                                                   0
+#define regMP1_SMN_C2PMSG_81                                                                            0x0291
+#define regMP1_SMN_C2PMSG_81_BASE_IDX                                                                   0
+#define regMP1_SMN_C2PMSG_82                                                                            0x0292
+#define regMP1_SMN_C2PMSG_82_BASE_IDX                                                                   0
+#define regMP1_SMN_C2PMSG_83                                                                            0x0293
+#define regMP1_SMN_C2PMSG_83_BASE_IDX                                                                   0
+#define regMP1_SMN_C2PMSG_84                                                                            0x0294
+#define regMP1_SMN_C2PMSG_84_BASE_IDX                                                                   0
+#define regMP1_SMN_C2PMSG_85                                                                            0x0295
+#define regMP1_SMN_C2PMSG_85_BASE_IDX                                                                   0
+#define regMP1_SMN_C2PMSG_86                                                                            0x0296
+#define regMP1_SMN_C2PMSG_86_BASE_IDX                                                                   0
+#define regMP1_SMN_C2PMSG_87                                                                            0x0297
+#define regMP1_SMN_C2PMSG_87_BASE_IDX                                                                   0
+#define regMP1_SMN_C2PMSG_88                                                                            0x0298
+#define regMP1_SMN_C2PMSG_88_BASE_IDX                                                                   0
+#define regMP1_SMN_C2PMSG_89                                                                            0x0299
+#define regMP1_SMN_C2PMSG_89_BASE_IDX                                                                   0
+#define regMP1_SMN_C2PMSG_90                                                                            0x029a
+#define regMP1_SMN_C2PMSG_90_BASE_IDX                                                                   0
+#define regMP1_SMN_C2PMSG_91                                                                            0x029b
+#define regMP1_SMN_C2PMSG_91_BASE_IDX                                                                   0
+#define regMP1_SMN_C2PMSG_92                                                                            0x029c
+#define regMP1_SMN_C2PMSG_92_BASE_IDX                                                                   0
+#define regMP1_SMN_C2PMSG_93                                                                            0x029d
+#define regMP1_SMN_C2PMSG_93_BASE_IDX                                                                   0
+#define regMP1_SMN_C2PMSG_94                                                                            0x029e
+#define regMP1_SMN_C2PMSG_94_BASE_IDX                                                                   0
+#define regMP1_SMN_C2PMSG_95                                                                            0x029f
+#define regMP1_SMN_C2PMSG_95_BASE_IDX                                                                   0
+#define regMP1_SMN_C2PMSG_96                                                                            0x02a0
+#define regMP1_SMN_C2PMSG_96_BASE_IDX                                                                   0
+#define regMP1_SMN_C2PMSG_97                                                                            0x02a1
+#define regMP1_SMN_C2PMSG_97_BASE_IDX                                                                   0
+#define regMP1_SMN_C2PMSG_98                                                                            0x02a2
+#define regMP1_SMN_C2PMSG_98_BASE_IDX                                                                   0
+#define regMP1_SMN_C2PMSG_99                                                                            0x02a3
+#define regMP1_SMN_C2PMSG_99_BASE_IDX                                                                   0
+#define regMP1_SMN_C2PMSG_100                                                                           0x02a4
+#define regMP1_SMN_C2PMSG_100_BASE_IDX                                                                  0
+#define regMP1_SMN_C2PMSG_101                                                                           0x02a5
+#define regMP1_SMN_C2PMSG_101_BASE_IDX                                                                  0
+#define regMP1_SMN_C2PMSG_102                                                                           0x02a6
+#define regMP1_SMN_C2PMSG_102_BASE_IDX                                                                  0
+#define regMP1_SMN_C2PMSG_103                                                                           0x02a7
+#define regMP1_SMN_C2PMSG_103_BASE_IDX                                                                  0
+#define regMP1_SMN_C2PMSG_104                                                                           0x02a8
+#define regMP1_SMN_C2PMSG_104_BASE_IDX                                                                  0
+#define regMP1_SMN_C2PMSG_105                                                                           0x02a9
+#define regMP1_SMN_C2PMSG_105_BASE_IDX                                                                  0
+#define regMP1_SMN_C2PMSG_106                                                                           0x02aa
+#define regMP1_SMN_C2PMSG_106_BASE_IDX                                                                  0
+#define regMP1_SMN_C2PMSG_107                                                                           0x02ab
+#define regMP1_SMN_C2PMSG_107_BASE_IDX                                                                  0
+#define regMP1_SMN_C2PMSG_108                                                                           0x02ac
+#define regMP1_SMN_C2PMSG_108_BASE_IDX                                                                  0
+#define regMP1_SMN_C2PMSG_109                                                                           0x02ad
+#define regMP1_SMN_C2PMSG_109_BASE_IDX                                                                  0
+#define regMP1_SMN_C2PMSG_110                                                                           0x02ae
+#define regMP1_SMN_C2PMSG_110_BASE_IDX                                                                  0
+#define regMP1_SMN_C2PMSG_111                                                                           0x02af
+#define regMP1_SMN_C2PMSG_111_BASE_IDX                                                                  0
+#define regMP1_SMN_C2PMSG_112                                                                           0x02b0
+#define regMP1_SMN_C2PMSG_112_BASE_IDX                                                                  0
+#define regMP1_SMN_C2PMSG_113                                                                           0x02b1
+#define regMP1_SMN_C2PMSG_113_BASE_IDX                                                                  0
+#define regMP1_SMN_C2PMSG_114                                                                           0x02b2
+#define regMP1_SMN_C2PMSG_114_BASE_IDX                                                                  0
+#define regMP1_SMN_C2PMSG_115                                                                           0x02b3
+#define regMP1_SMN_C2PMSG_115_BASE_IDX                                                                  0
+#define regMP1_SMN_C2PMSG_116                                                                           0x02b4
+#define regMP1_SMN_C2PMSG_116_BASE_IDX                                                                  0
+#define regMP1_SMN_C2PMSG_117                                                                           0x02b5
+#define regMP1_SMN_C2PMSG_117_BASE_IDX                                                                  0
+#define regMP1_SMN_C2PMSG_118                                                                           0x02b6
+#define regMP1_SMN_C2PMSG_118_BASE_IDX                                                                  0
+#define regMP1_SMN_C2PMSG_119                                                                           0x02b7
+#define regMP1_SMN_C2PMSG_119_BASE_IDX                                                                  0
+#define regMP1_SMN_C2PMSG_120                                                                           0x02b8
+#define regMP1_SMN_C2PMSG_120_BASE_IDX                                                                  0
+#define regMP1_SMN_C2PMSG_121                                                                           0x02b9
+#define regMP1_SMN_C2PMSG_121_BASE_IDX                                                                  0
+#define regMP1_SMN_C2PMSG_122                                                                           0x02ba
+#define regMP1_SMN_C2PMSG_122_BASE_IDX                                                                  0
+#define regMP1_SMN_C2PMSG_123                                                                           0x02bb
+#define regMP1_SMN_C2PMSG_123_BASE_IDX                                                                  0
+#define regMP1_SMN_C2PMSG_124                                                                           0x02bc
+#define regMP1_SMN_C2PMSG_124_BASE_IDX                                                                  0
+#define regMP1_SMN_C2PMSG_125                                                                           0x02bd
+#define regMP1_SMN_C2PMSG_125_BASE_IDX                                                                  0
+#define regMP1_SMN_C2PMSG_126                                                                           0x02be
+#define regMP1_SMN_C2PMSG_126_BASE_IDX                                                                  0
+#define regMP1_SMN_C2PMSG_127                                                                           0x02bf
+#define regMP1_SMN_C2PMSG_127_BASE_IDX                                                                  0
+#define regMP1_SMN_IH_CREDIT                                                                            0x0340
+#define regMP1_SMN_IH_CREDIT_BASE_IDX                                                                   0
+#define regMP1_SMN_IH_SW_INT                                                                            0x0341
+#define regMP1_SMN_IH_SW_INT_BASE_IDX                                                                   0
+#define regMP1_SMN_IH_SW_INT_CTRL                                                                       0x0342
+#define regMP1_SMN_IH_SW_INT_CTRL_BASE_IDX                                                              0
+#define regMP1_SMN_FPS_CNT                                                                              0x0343
+#define regMP1_SMN_FPS_CNT_BASE_IDX                                                                     0
+#define regMP1_SMN_EXT_SCRATCH0                                                                         0x03c0
+#define regMP1_SMN_EXT_SCRATCH0_BASE_IDX                                                                0
+#define regMP1_SMN_EXT_SCRATCH1                                                                         0x03c1
+#define regMP1_SMN_EXT_SCRATCH1_BASE_IDX                                                                0
+#define regMP1_SMN_EXT_SCRATCH2                                                                         0x03c2
+#define regMP1_SMN_EXT_SCRATCH2_BASE_IDX                                                                0
+#define regMP1_SMN_EXT_SCRATCH3                                                                         0x03c3
+#define regMP1_SMN_EXT_SCRATCH3_BASE_IDX                                                                0
+#define regMP1_SMN_EXT_SCRATCH4                                                                         0x03c4
+#define regMP1_SMN_EXT_SCRATCH4_BASE_IDX                                                                0
+#define regMP1_SMN_EXT_SCRATCH5                                                                         0x03c5
+#define regMP1_SMN_EXT_SCRATCH5_BASE_IDX                                                                0
+#define regMP1_SMN_EXT_SCRATCH6                                                                         0x03c6
+#define regMP1_SMN_EXT_SCRATCH6_BASE_IDX                                                                0
+#define regMP1_SMN_EXT_SCRATCH7                                                                         0x03c7
+#define regMP1_SMN_EXT_SCRATCH7_BASE_IDX                                                                0
+#define regMP1_SMN_EXT_SCRATCH8                                                                         0x03c8
+#define regMP1_SMN_EXT_SCRATCH8_BASE_IDX                                                                0
+#define regMP1_SMN_EXT_SCRATCH9                                                                         0x03c9
+#define regMP1_SMN_EXT_SCRATCH9_BASE_IDX                                                                0
+#define regMP1_SMN_EXT_SCRATCH10                                                                        0x03ca
+#define regMP1_SMN_EXT_SCRATCH10_BASE_IDX                                                               0
+#define regMP1_SMN_EXT_SCRATCH11                                                                        0x03cb
+#define regMP1_SMN_EXT_SCRATCH11_BASE_IDX                                                               0
+#define regMP1_SMN_EXT_SCRATCH12                                                                        0x03cc
+#define regMP1_SMN_EXT_SCRATCH12_BASE_IDX                                                               0
+#define regMP1_SMN_EXT_SCRATCH13                                                                        0x03cd
+#define regMP1_SMN_EXT_SCRATCH13_BASE_IDX                                                               0
+#define regMP1_SMN_EXT_SCRATCH14                                                                        0x03ce
+#define regMP1_SMN_EXT_SCRATCH14_BASE_IDX                                                               0
+#define regMP1_SMN_EXT_SCRATCH15                                                                        0x03cf
+#define regMP1_SMN_EXT_SCRATCH15_BASE_IDX                                                               0
+#define regMP1_SMN_EXT_SCRATCH16                                                                        0x03d0
+#define regMP1_SMN_EXT_SCRATCH16_BASE_IDX                                                               0
+#define regMP1_SMN_EXT_SCRATCH17                                                                        0x03d1
+#define regMP1_SMN_EXT_SCRATCH17_BASE_IDX                                                               0
+#define regMP1_SMN_EXT_SCRATCH18                                                                        0x03d2
+#define regMP1_SMN_EXT_SCRATCH18_BASE_IDX                                                               0
+#define regMP1_SMN_EXT_SCRATCH19                                                                        0x03d3
+#define regMP1_SMN_EXT_SCRATCH19_BASE_IDX                                                               0
+#define regMP1_SMN_EXT_SCRATCH20                                                                        0x03d4
+#define regMP1_SMN_EXT_SCRATCH20_BASE_IDX                                                               0
+#define regMP1_SMN_EXT_SCRATCH21                                                                        0x03d5
+#define regMP1_SMN_EXT_SCRATCH21_BASE_IDX                                                               0
+#define regMP1_SMN_EXT_SCRATCH22                                                                        0x03d6
+#define regMP1_SMN_EXT_SCRATCH22_BASE_IDX                                                               0
+#define regMP1_SMN_EXT_SCRATCH23                                                                        0x03d7
+#define regMP1_SMN_EXT_SCRATCH23_BASE_IDX                                                               0
+#define regMP1_SMN_EXT_SCRATCH24                                                                        0x03d8
+#define regMP1_SMN_EXT_SCRATCH24_BASE_IDX                                                               0
+#define regMP1_SMN_EXT_SCRATCH25                                                                        0x03d9
+#define regMP1_SMN_EXT_SCRATCH25_BASE_IDX                                                               0
+#define regMP1_SMN_EXT_SCRATCH26                                                                        0x03da
+#define regMP1_SMN_EXT_SCRATCH26_BASE_IDX                                                               0
+#define regMP1_SMN_EXT_SCRATCH27                                                                        0x03db
+#define regMP1_SMN_EXT_SCRATCH27_BASE_IDX                                                               0
+#define regMP1_SMN_EXT_SCRATCH28                                                                        0x03dc
+#define regMP1_SMN_EXT_SCRATCH28_BASE_IDX                                                               0
+#define regMP1_SMN_EXT_SCRATCH29                                                                        0x03dd
+#define regMP1_SMN_EXT_SCRATCH29_BASE_IDX                                                               0
+#define regMP1_SMN_EXT_SCRATCH30                                                                        0x03de
+#define regMP1_SMN_EXT_SCRATCH30_BASE_IDX                                                               0
+#define regMP1_SMN_EXT_SCRATCH31                                                                        0x03df
+#define regMP1_SMN_EXT_SCRATCH31_BASE_IDX                                                               0
+
+
+#endif
diff --git a/drivers/gpu/drm/amd/include/asic_reg/mp/mp_14_0_0_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/mp/mp_14_0_0_sh_mask.h
new file mode 100644
index 000000000000..347294482eec
--- /dev/null
+++ b/drivers/gpu/drm/amd/include/asic_reg/mp/mp_14_0_0_sh_mask.h
@@ -0,0 +1,534 @@
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
+#ifndef _mp_14_0_0_SH_MASK_HEADER
+#define _mp_14_0_0_SH_MASK_HEADER
+
+// addressBlock: mp_SmuMp1Pub_CruDec
+//MP1_CRU1_MP1_FIRMWARE_FLAGS
+#define MP1_CRU1_MP1_FIRMWARE_FLAGS__INTERRUPTS_ENABLED__SHIFT                                                0x0
+#define MP1_CRU1_MP1_FIRMWARE_FLAGS__RESERVED__SHIFT                                                          0x1
+#define MP1_CRU1_MP1_FIRMWARE_FLAGS__INTERRUPTS_ENABLED_MASK                                                  0x00000001L
+#define MP1_CRU1_MP1_FIRMWARE_FLAGS__RESERVED_MASK                                                            0xFFFFFFFEL
+
+
+// addressBlock: mp_SmuMp1_SmnDec
+//MP1_SMN_C2PMSG_0
+#define MP1_SMN_C2PMSG_0__CONTENT__SHIFT                                                                      0x0
+#define MP1_SMN_C2PMSG_0__CONTENT_MASK                                                                        0xFFFFFFFFL
+//MP1_SMN_C2PMSG_1
+#define MP1_SMN_C2PMSG_1__CONTENT__SHIFT                                                                      0x0
+#define MP1_SMN_C2PMSG_1__CONTENT_MASK                                                                        0xFFFFFFFFL
+//MP1_SMN_C2PMSG_2
+#define MP1_SMN_C2PMSG_2__CONTENT__SHIFT                                                                      0x0
+#define MP1_SMN_C2PMSG_2__CONTENT_MASK                                                                        0xFFFFFFFFL
+//MP1_SMN_C2PMSG_3
+#define MP1_SMN_C2PMSG_3__CONTENT__SHIFT                                                                      0x0
+#define MP1_SMN_C2PMSG_3__CONTENT_MASK                                                                        0xFFFFFFFFL
+//MP1_SMN_C2PMSG_4
+#define MP1_SMN_C2PMSG_4__CONTENT__SHIFT                                                                      0x0
+#define MP1_SMN_C2PMSG_4__CONTENT_MASK                                                                        0xFFFFFFFFL
+//MP1_SMN_C2PMSG_5
+#define MP1_SMN_C2PMSG_5__CONTENT__SHIFT                                                                      0x0
+#define MP1_SMN_C2PMSG_5__CONTENT_MASK                                                                        0xFFFFFFFFL
+//MP1_SMN_C2PMSG_6
+#define MP1_SMN_C2PMSG_6__CONTENT__SHIFT                                                                      0x0
+#define MP1_SMN_C2PMSG_6__CONTENT_MASK                                                                        0xFFFFFFFFL
+//MP1_SMN_C2PMSG_7
+#define MP1_SMN_C2PMSG_7__CONTENT__SHIFT                                                                      0x0
+#define MP1_SMN_C2PMSG_7__CONTENT_MASK                                                                        0xFFFFFFFFL
+//MP1_SMN_C2PMSG_8
+#define MP1_SMN_C2PMSG_8__CONTENT__SHIFT                                                                      0x0
+#define MP1_SMN_C2PMSG_8__CONTENT_MASK                                                                        0xFFFFFFFFL
+//MP1_SMN_C2PMSG_9
+#define MP1_SMN_C2PMSG_9__CONTENT__SHIFT                                                                      0x0
+#define MP1_SMN_C2PMSG_9__CONTENT_MASK                                                                        0xFFFFFFFFL
+//MP1_SMN_C2PMSG_10
+#define MP1_SMN_C2PMSG_10__CONTENT__SHIFT                                                                     0x0
+#define MP1_SMN_C2PMSG_10__CONTENT_MASK                                                                       0xFFFFFFFFL
+//MP1_SMN_C2PMSG_11
+#define MP1_SMN_C2PMSG_11__CONTENT__SHIFT                                                                     0x0
+#define MP1_SMN_C2PMSG_11__CONTENT_MASK                                                                       0xFFFFFFFFL
+//MP1_SMN_C2PMSG_12
+#define MP1_SMN_C2PMSG_12__CONTENT__SHIFT                                                                     0x0
+#define MP1_SMN_C2PMSG_12__CONTENT_MASK                                                                       0xFFFFFFFFL
+//MP1_SMN_C2PMSG_13
+#define MP1_SMN_C2PMSG_13__CONTENT__SHIFT                                                                     0x0
+#define MP1_SMN_C2PMSG_13__CONTENT_MASK                                                                       0xFFFFFFFFL
+//MP1_SMN_C2PMSG_14
+#define MP1_SMN_C2PMSG_14__CONTENT__SHIFT                                                                     0x0
+#define MP1_SMN_C2PMSG_14__CONTENT_MASK                                                                       0xFFFFFFFFL
+//MP1_SMN_C2PMSG_15
+#define MP1_SMN_C2PMSG_15__CONTENT__SHIFT                                                                     0x0
+#define MP1_SMN_C2PMSG_15__CONTENT_MASK                                                                       0xFFFFFFFFL
+//MP1_SMN_C2PMSG_16
+#define MP1_SMN_C2PMSG_16__CONTENT__SHIFT                                                                     0x0
+#define MP1_SMN_C2PMSG_16__CONTENT_MASK                                                                       0xFFFFFFFFL
+//MP1_SMN_C2PMSG_17
+#define MP1_SMN_C2PMSG_17__CONTENT__SHIFT                                                                     0x0
+#define MP1_SMN_C2PMSG_17__CONTENT_MASK                                                                       0xFFFFFFFFL
+//MP1_SMN_C2PMSG_18
+#define MP1_SMN_C2PMSG_18__CONTENT__SHIFT                                                                     0x0
+#define MP1_SMN_C2PMSG_18__CONTENT_MASK                                                                       0xFFFFFFFFL
+//MP1_SMN_C2PMSG_19
+#define MP1_SMN_C2PMSG_19__CONTENT__SHIFT                                                                     0x0
+#define MP1_SMN_C2PMSG_19__CONTENT_MASK                                                                       0xFFFFFFFFL
+//MP1_SMN_C2PMSG_20
+#define MP1_SMN_C2PMSG_20__CONTENT__SHIFT                                                                     0x0
+#define MP1_SMN_C2PMSG_20__CONTENT_MASK                                                                       0xFFFFFFFFL
+//MP1_SMN_C2PMSG_21
+#define MP1_SMN_C2PMSG_21__CONTENT__SHIFT                                                                     0x0
+#define MP1_SMN_C2PMSG_21__CONTENT_MASK                                                                       0xFFFFFFFFL
+//MP1_SMN_C2PMSG_22
+#define MP1_SMN_C2PMSG_22__CONTENT__SHIFT                                                                     0x0
+#define MP1_SMN_C2PMSG_22__CONTENT_MASK                                                                       0xFFFFFFFFL
+//MP1_SMN_C2PMSG_23
+#define MP1_SMN_C2PMSG_23__CONTENT__SHIFT                                                                     0x0
+#define MP1_SMN_C2PMSG_23__CONTENT_MASK                                                                       0xFFFFFFFFL
+//MP1_SMN_C2PMSG_24
+#define MP1_SMN_C2PMSG_24__CONTENT__SHIFT                                                                     0x0
+#define MP1_SMN_C2PMSG_24__CONTENT_MASK                                                                       0xFFFFFFFFL
+//MP1_SMN_C2PMSG_25
+#define MP1_SMN_C2PMSG_25__CONTENT__SHIFT                                                                     0x0
+#define MP1_SMN_C2PMSG_25__CONTENT_MASK                                                                       0xFFFFFFFFL
+//MP1_SMN_C2PMSG_26
+#define MP1_SMN_C2PMSG_26__CONTENT__SHIFT                                                                     0x0
+#define MP1_SMN_C2PMSG_26__CONTENT_MASK                                                                       0xFFFFFFFFL
+//MP1_SMN_C2PMSG_27
+#define MP1_SMN_C2PMSG_27__CONTENT__SHIFT                                                                     0x0
+#define MP1_SMN_C2PMSG_27__CONTENT_MASK                                                                       0xFFFFFFFFL
+//MP1_SMN_C2PMSG_28
+#define MP1_SMN_C2PMSG_28__CONTENT__SHIFT                                                                     0x0
+#define MP1_SMN_C2PMSG_28__CONTENT_MASK                                                                       0xFFFFFFFFL
+//MP1_SMN_C2PMSG_29
+#define MP1_SMN_C2PMSG_29__CONTENT__SHIFT                                                                     0x0
+#define MP1_SMN_C2PMSG_29__CONTENT_MASK                                                                       0xFFFFFFFFL
+//MP1_SMN_C2PMSG_30
+#define MP1_SMN_C2PMSG_30__CONTENT__SHIFT                                                                     0x0
+#define MP1_SMN_C2PMSG_30__CONTENT_MASK                                                                       0xFFFFFFFFL
+//MP1_SMN_C2PMSG_31
+#define MP1_SMN_C2PMSG_31__CONTENT__SHIFT                                                                     0x0
+#define MP1_SMN_C2PMSG_31__CONTENT_MASK                                                                       0xFFFFFFFFL
+//MP1_SMN_C2PMSG_32
+#define MP1_SMN_C2PMSG_32__CONTENT__SHIFT                                                                     0x0
+#define MP1_SMN_C2PMSG_32__CONTENT_MASK                                                                       0xFFFFFFFFL
+//MP1_SMN_C2PMSG_33
+#define MP1_SMN_C2PMSG_33__CONTENT__SHIFT                                                                     0x0
+#define MP1_SMN_C2PMSG_33__CONTENT_MASK                                                                       0xFFFFFFFFL
+//MP1_SMN_C2PMSG_34
+#define MP1_SMN_C2PMSG_34__CONTENT__SHIFT                                                                     0x0
+#define MP1_SMN_C2PMSG_34__CONTENT_MASK                                                                       0xFFFFFFFFL
+//MP1_SMN_C2PMSG_35
+#define MP1_SMN_C2PMSG_35__CONTENT__SHIFT                                                                     0x0
+#define MP1_SMN_C2PMSG_35__CONTENT_MASK                                                                       0xFFFFFFFFL
+//MP1_SMN_C2PMSG_36
+#define MP1_SMN_C2PMSG_36__CONTENT__SHIFT                                                                     0x0
+#define MP1_SMN_C2PMSG_36__CONTENT_MASK                                                                       0xFFFFFFFFL
+//MP1_SMN_C2PMSG_37
+#define MP1_SMN_C2PMSG_37__CONTENT__SHIFT                                                                     0x0
+#define MP1_SMN_C2PMSG_37__CONTENT_MASK                                                                       0xFFFFFFFFL
+//MP1_SMN_C2PMSG_38
+#define MP1_SMN_C2PMSG_38__CONTENT__SHIFT                                                                     0x0
+#define MP1_SMN_C2PMSG_38__CONTENT_MASK                                                                       0xFFFFFFFFL
+//MP1_SMN_C2PMSG_39
+#define MP1_SMN_C2PMSG_39__CONTENT__SHIFT                                                                     0x0
+#define MP1_SMN_C2PMSG_39__CONTENT_MASK                                                                       0xFFFFFFFFL
+//MP1_SMN_C2PMSG_40
+#define MP1_SMN_C2PMSG_40__CONTENT__SHIFT                                                                     0x0
+#define MP1_SMN_C2PMSG_40__CONTENT_MASK                                                                       0xFFFFFFFFL
+//MP1_SMN_C2PMSG_41
+#define MP1_SMN_C2PMSG_41__CONTENT__SHIFT                                                                     0x0
+#define MP1_SMN_C2PMSG_41__CONTENT_MASK                                                                       0xFFFFFFFFL
+//MP1_SMN_C2PMSG_42
+#define MP1_SMN_C2PMSG_42__CONTENT__SHIFT                                                                     0x0
+#define MP1_SMN_C2PMSG_42__CONTENT_MASK                                                                       0xFFFFFFFFL
+//MP1_SMN_C2PMSG_43
+#define MP1_SMN_C2PMSG_43__CONTENT__SHIFT                                                                     0x0
+#define MP1_SMN_C2PMSG_43__CONTENT_MASK                                                                       0xFFFFFFFFL
+//MP1_SMN_C2PMSG_44
+#define MP1_SMN_C2PMSG_44__CONTENT__SHIFT                                                                     0x0
+#define MP1_SMN_C2PMSG_44__CONTENT_MASK                                                                       0xFFFFFFFFL
+//MP1_SMN_C2PMSG_45
+#define MP1_SMN_C2PMSG_45__CONTENT__SHIFT                                                                     0x0
+#define MP1_SMN_C2PMSG_45__CONTENT_MASK                                                                       0xFFFFFFFFL
+//MP1_SMN_C2PMSG_46
+#define MP1_SMN_C2PMSG_46__CONTENT__SHIFT                                                                     0x0
+#define MP1_SMN_C2PMSG_46__CONTENT_MASK                                                                       0xFFFFFFFFL
+//MP1_SMN_C2PMSG_47
+#define MP1_SMN_C2PMSG_47__CONTENT__SHIFT                                                                     0x0
+#define MP1_SMN_C2PMSG_47__CONTENT_MASK                                                                       0xFFFFFFFFL
+//MP1_SMN_C2PMSG_48
+#define MP1_SMN_C2PMSG_48__CONTENT__SHIFT                                                                     0x0
+#define MP1_SMN_C2PMSG_48__CONTENT_MASK                                                                       0xFFFFFFFFL
+//MP1_SMN_C2PMSG_49
+#define MP1_SMN_C2PMSG_49__CONTENT__SHIFT                                                                     0x0
+#define MP1_SMN_C2PMSG_49__CONTENT_MASK                                                                       0xFFFFFFFFL
+//MP1_SMN_C2PMSG_50
+#define MP1_SMN_C2PMSG_50__CONTENT__SHIFT                                                                     0x0
+#define MP1_SMN_C2PMSG_50__CONTENT_MASK                                                                       0xFFFFFFFFL
+//MP1_SMN_C2PMSG_51
+#define MP1_SMN_C2PMSG_51__CONTENT__SHIFT                                                                     0x0
+#define MP1_SMN_C2PMSG_51__CONTENT_MASK                                                                       0xFFFFFFFFL
+//MP1_SMN_C2PMSG_52
+#define MP1_SMN_C2PMSG_52__CONTENT__SHIFT                                                                     0x0
+#define MP1_SMN_C2PMSG_52__CONTENT_MASK                                                                       0xFFFFFFFFL
+//MP1_SMN_C2PMSG_53
+#define MP1_SMN_C2PMSG_53__CONTENT__SHIFT                                                                     0x0
+#define MP1_SMN_C2PMSG_53__CONTENT_MASK                                                                       0xFFFFFFFFL
+//MP1_SMN_C2PMSG_54
+#define MP1_SMN_C2PMSG_54__CONTENT__SHIFT                                                                     0x0
+#define MP1_SMN_C2PMSG_54__CONTENT_MASK                                                                       0xFFFFFFFFL
+//MP1_SMN_C2PMSG_55
+#define MP1_SMN_C2PMSG_55__CONTENT__SHIFT                                                                     0x0
+#define MP1_SMN_C2PMSG_55__CONTENT_MASK                                                                       0xFFFFFFFFL
+//MP1_SMN_C2PMSG_56
+#define MP1_SMN_C2PMSG_56__CONTENT__SHIFT                                                                     0x0
+#define MP1_SMN_C2PMSG_56__CONTENT_MASK                                                                       0xFFFFFFFFL
+//MP1_SMN_C2PMSG_57
+#define MP1_SMN_C2PMSG_57__CONTENT__SHIFT                                                                     0x0
+#define MP1_SMN_C2PMSG_57__CONTENT_MASK                                                                       0xFFFFFFFFL
+//MP1_SMN_C2PMSG_58
+#define MP1_SMN_C2PMSG_58__CONTENT__SHIFT                                                                     0x0
+#define MP1_SMN_C2PMSG_58__CONTENT_MASK                                                                       0xFFFFFFFFL
+//MP1_SMN_C2PMSG_59
+#define MP1_SMN_C2PMSG_59__CONTENT__SHIFT                                                                     0x0
+#define MP1_SMN_C2PMSG_59__CONTENT_MASK                                                                       0xFFFFFFFFL
+//MP1_SMN_C2PMSG_60
+#define MP1_SMN_C2PMSG_60__CONTENT__SHIFT                                                                     0x0
+#define MP1_SMN_C2PMSG_60__CONTENT_MASK                                                                       0xFFFFFFFFL
+//MP1_SMN_C2PMSG_61
+#define MP1_SMN_C2PMSG_61__CONTENT__SHIFT                                                                     0x0
+#define MP1_SMN_C2PMSG_61__CONTENT_MASK                                                                       0xFFFFFFFFL
+//MP1_SMN_C2PMSG_62
+#define MP1_SMN_C2PMSG_62__CONTENT__SHIFT                                                                     0x0
+#define MP1_SMN_C2PMSG_62__CONTENT_MASK                                                                       0xFFFFFFFFL
+//MP1_SMN_C2PMSG_63
+#define MP1_SMN_C2PMSG_63__CONTENT__SHIFT                                                                     0x0
+#define MP1_SMN_C2PMSG_63__CONTENT_MASK                                                                       0xFFFFFFFFL
+//MP1_SMN_C2PMSG_64
+#define MP1_SMN_C2PMSG_64__CONTENT__SHIFT                                                                     0x0
+#define MP1_SMN_C2PMSG_64__CONTENT_MASK                                                                       0xFFFFFFFFL
+//MP1_SMN_C2PMSG_65
+#define MP1_SMN_C2PMSG_65__CONTENT__SHIFT                                                                     0x0
+#define MP1_SMN_C2PMSG_65__CONTENT_MASK                                                                       0xFFFFFFFFL
+//MP1_SMN_C2PMSG_66
+#define MP1_SMN_C2PMSG_66__CONTENT__SHIFT                                                                     0x0
+#define MP1_SMN_C2PMSG_66__CONTENT_MASK                                                                       0xFFFFFFFFL
+//MP1_SMN_C2PMSG_67
+#define MP1_SMN_C2PMSG_67__CONTENT__SHIFT                                                                     0x0
+#define MP1_SMN_C2PMSG_67__CONTENT_MASK                                                                       0xFFFFFFFFL
+//MP1_SMN_C2PMSG_68
+#define MP1_SMN_C2PMSG_68__CONTENT__SHIFT                                                                     0x0
+#define MP1_SMN_C2PMSG_68__CONTENT_MASK                                                                       0xFFFFFFFFL
+//MP1_SMN_C2PMSG_69
+#define MP1_SMN_C2PMSG_69__CONTENT__SHIFT                                                                     0x0
+#define MP1_SMN_C2PMSG_69__CONTENT_MASK                                                                       0xFFFFFFFFL
+//MP1_SMN_C2PMSG_70
+#define MP1_SMN_C2PMSG_70__CONTENT__SHIFT                                                                     0x0
+#define MP1_SMN_C2PMSG_70__CONTENT_MASK                                                                       0xFFFFFFFFL
+//MP1_SMN_C2PMSG_71
+#define MP1_SMN_C2PMSG_71__CONTENT__SHIFT                                                                     0x0
+#define MP1_SMN_C2PMSG_71__CONTENT_MASK                                                                       0xFFFFFFFFL
+//MP1_SMN_C2PMSG_72
+#define MP1_SMN_C2PMSG_72__CONTENT__SHIFT                                                                     0x0
+#define MP1_SMN_C2PMSG_72__CONTENT_MASK                                                                       0xFFFFFFFFL
+//MP1_SMN_C2PMSG_73
+#define MP1_SMN_C2PMSG_73__CONTENT__SHIFT                                                                     0x0
+#define MP1_SMN_C2PMSG_73__CONTENT_MASK                                                                       0xFFFFFFFFL
+//MP1_SMN_C2PMSG_74
+#define MP1_SMN_C2PMSG_74__CONTENT__SHIFT                                                                     0x0
+#define MP1_SMN_C2PMSG_74__CONTENT_MASK                                                                       0xFFFFFFFFL
+//MP1_SMN_C2PMSG_75
+#define MP1_SMN_C2PMSG_75__CONTENT__SHIFT                                                                     0x0
+#define MP1_SMN_C2PMSG_75__CONTENT_MASK                                                                       0xFFFFFFFFL
+//MP1_SMN_C2PMSG_76
+#define MP1_SMN_C2PMSG_76__CONTENT__SHIFT                                                                     0x0
+#define MP1_SMN_C2PMSG_76__CONTENT_MASK                                                                       0xFFFFFFFFL
+//MP1_SMN_C2PMSG_77
+#define MP1_SMN_C2PMSG_77__CONTENT__SHIFT                                                                     0x0
+#define MP1_SMN_C2PMSG_77__CONTENT_MASK                                                                       0xFFFFFFFFL
+//MP1_SMN_C2PMSG_78
+#define MP1_SMN_C2PMSG_78__CONTENT__SHIFT                                                                     0x0
+#define MP1_SMN_C2PMSG_78__CONTENT_MASK                                                                       0xFFFFFFFFL
+//MP1_SMN_C2PMSG_79
+#define MP1_SMN_C2PMSG_79__CONTENT__SHIFT                                                                     0x0
+#define MP1_SMN_C2PMSG_79__CONTENT_MASK                                                                       0xFFFFFFFFL
+//MP1_SMN_C2PMSG_80
+#define MP1_SMN_C2PMSG_80__CONTENT__SHIFT                                                                     0x0
+#define MP1_SMN_C2PMSG_80__CONTENT_MASK                                                                       0xFFFFFFFFL
+//MP1_SMN_C2PMSG_81
+#define MP1_SMN_C2PMSG_81__CONTENT__SHIFT                                                                     0x0
+#define MP1_SMN_C2PMSG_81__CONTENT_MASK                                                                       0xFFFFFFFFL
+//MP1_SMN_C2PMSG_82
+#define MP1_SMN_C2PMSG_82__CONTENT__SHIFT                                                                     0x0
+#define MP1_SMN_C2PMSG_82__CONTENT_MASK                                                                       0xFFFFFFFFL
+//MP1_SMN_C2PMSG_83
+#define MP1_SMN_C2PMSG_83__CONTENT__SHIFT                                                                     0x0
+#define MP1_SMN_C2PMSG_83__CONTENT_MASK                                                                       0xFFFFFFFFL
+//MP1_SMN_C2PMSG_84
+#define MP1_SMN_C2PMSG_84__CONTENT__SHIFT                                                                     0x0
+#define MP1_SMN_C2PMSG_84__CONTENT_MASK                                                                       0xFFFFFFFFL
+//MP1_SMN_C2PMSG_85
+#define MP1_SMN_C2PMSG_85__CONTENT__SHIFT                                                                     0x0
+#define MP1_SMN_C2PMSG_85__CONTENT_MASK                                                                       0xFFFFFFFFL
+//MP1_SMN_C2PMSG_86
+#define MP1_SMN_C2PMSG_86__CONTENT__SHIFT                                                                     0x0
+#define MP1_SMN_C2PMSG_86__CONTENT_MASK                                                                       0xFFFFFFFFL
+//MP1_SMN_C2PMSG_87
+#define MP1_SMN_C2PMSG_87__CONTENT__SHIFT                                                                     0x0
+#define MP1_SMN_C2PMSG_87__CONTENT_MASK                                                                       0xFFFFFFFFL
+//MP1_SMN_C2PMSG_88
+#define MP1_SMN_C2PMSG_88__CONTENT__SHIFT                                                                     0x0
+#define MP1_SMN_C2PMSG_88__CONTENT_MASK                                                                       0xFFFFFFFFL
+//MP1_SMN_C2PMSG_89
+#define MP1_SMN_C2PMSG_89__CONTENT__SHIFT                                                                     0x0
+#define MP1_SMN_C2PMSG_89__CONTENT_MASK                                                                       0xFFFFFFFFL
+//MP1_SMN_C2PMSG_90
+#define MP1_SMN_C2PMSG_90__CONTENT__SHIFT                                                                     0x0
+#define MP1_SMN_C2PMSG_90__CONTENT_MASK                                                                       0xFFFFFFFFL
+//MP1_SMN_C2PMSG_91
+#define MP1_SMN_C2PMSG_91__CONTENT__SHIFT                                                                     0x0
+#define MP1_SMN_C2PMSG_91__CONTENT_MASK                                                                       0xFFFFFFFFL
+//MP1_SMN_C2PMSG_92
+#define MP1_SMN_C2PMSG_92__CONTENT__SHIFT                                                                     0x0
+#define MP1_SMN_C2PMSG_92__CONTENT_MASK                                                                       0xFFFFFFFFL
+//MP1_SMN_C2PMSG_93
+#define MP1_SMN_C2PMSG_93__CONTENT__SHIFT                                                                     0x0
+#define MP1_SMN_C2PMSG_93__CONTENT_MASK                                                                       0xFFFFFFFFL
+//MP1_SMN_C2PMSG_94
+#define MP1_SMN_C2PMSG_94__CONTENT__SHIFT                                                                     0x0
+#define MP1_SMN_C2PMSG_94__CONTENT_MASK                                                                       0xFFFFFFFFL
+//MP1_SMN_C2PMSG_95
+#define MP1_SMN_C2PMSG_95__CONTENT__SHIFT                                                                     0x0
+#define MP1_SMN_C2PMSG_95__CONTENT_MASK                                                                       0xFFFFFFFFL
+//MP1_SMN_C2PMSG_96
+#define MP1_SMN_C2PMSG_96__CONTENT__SHIFT                                                                     0x0
+#define MP1_SMN_C2PMSG_96__CONTENT_MASK                                                                       0xFFFFFFFFL
+//MP1_SMN_C2PMSG_97
+#define MP1_SMN_C2PMSG_97__CONTENT__SHIFT                                                                     0x0
+#define MP1_SMN_C2PMSG_97__CONTENT_MASK                                                                       0xFFFFFFFFL
+//MP1_SMN_C2PMSG_98
+#define MP1_SMN_C2PMSG_98__CONTENT__SHIFT                                                                     0x0
+#define MP1_SMN_C2PMSG_98__CONTENT_MASK                                                                       0xFFFFFFFFL
+//MP1_SMN_C2PMSG_99
+#define MP1_SMN_C2PMSG_99__CONTENT__SHIFT                                                                     0x0
+#define MP1_SMN_C2PMSG_99__CONTENT_MASK                                                                       0xFFFFFFFFL
+//MP1_SMN_C2PMSG_100
+#define MP1_SMN_C2PMSG_100__CONTENT__SHIFT                                                                    0x0
+#define MP1_SMN_C2PMSG_100__CONTENT_MASK                                                                      0xFFFFFFFFL
+//MP1_SMN_C2PMSG_101
+#define MP1_SMN_C2PMSG_101__CONTENT__SHIFT                                                                    0x0
+#define MP1_SMN_C2PMSG_101__CONTENT_MASK                                                                      0xFFFFFFFFL
+//MP1_SMN_C2PMSG_102
+#define MP1_SMN_C2PMSG_102__CONTENT__SHIFT                                                                    0x0
+#define MP1_SMN_C2PMSG_102__CONTENT_MASK                                                                      0xFFFFFFFFL
+//MP1_SMN_C2PMSG_103
+#define MP1_SMN_C2PMSG_103__CONTENT__SHIFT                                                                    0x0
+#define MP1_SMN_C2PMSG_103__CONTENT_MASK                                                                      0xFFFFFFFFL
+//MP1_SMN_C2PMSG_104
+#define MP1_SMN_C2PMSG_104__CONTENT__SHIFT                                                                    0x0
+#define MP1_SMN_C2PMSG_104__CONTENT_MASK                                                                      0xFFFFFFFFL
+//MP1_SMN_C2PMSG_105
+#define MP1_SMN_C2PMSG_105__CONTENT__SHIFT                                                                    0x0
+#define MP1_SMN_C2PMSG_105__CONTENT_MASK                                                                      0xFFFFFFFFL
+//MP1_SMN_C2PMSG_106
+#define MP1_SMN_C2PMSG_106__CONTENT__SHIFT                                                                    0x0
+#define MP1_SMN_C2PMSG_106__CONTENT_MASK                                                                      0xFFFFFFFFL
+//MP1_SMN_C2PMSG_107
+#define MP1_SMN_C2PMSG_107__CONTENT__SHIFT                                                                    0x0
+#define MP1_SMN_C2PMSG_107__CONTENT_MASK                                                                      0xFFFFFFFFL
+//MP1_SMN_C2PMSG_108
+#define MP1_SMN_C2PMSG_108__CONTENT__SHIFT                                                                    0x0
+#define MP1_SMN_C2PMSG_108__CONTENT_MASK                                                                      0xFFFFFFFFL
+//MP1_SMN_C2PMSG_109
+#define MP1_SMN_C2PMSG_109__CONTENT__SHIFT                                                                    0x0
+#define MP1_SMN_C2PMSG_109__CONTENT_MASK                                                                      0xFFFFFFFFL
+//MP1_SMN_C2PMSG_110
+#define MP1_SMN_C2PMSG_110__CONTENT__SHIFT                                                                    0x0
+#define MP1_SMN_C2PMSG_110__CONTENT_MASK                                                                      0xFFFFFFFFL
+//MP1_SMN_C2PMSG_111
+#define MP1_SMN_C2PMSG_111__CONTENT__SHIFT                                                                    0x0
+#define MP1_SMN_C2PMSG_111__CONTENT_MASK                                                                      0xFFFFFFFFL
+//MP1_SMN_C2PMSG_112
+#define MP1_SMN_C2PMSG_112__CONTENT__SHIFT                                                                    0x0
+#define MP1_SMN_C2PMSG_112__CONTENT_MASK                                                                      0xFFFFFFFFL
+//MP1_SMN_C2PMSG_113
+#define MP1_SMN_C2PMSG_113__CONTENT__SHIFT                                                                    0x0
+#define MP1_SMN_C2PMSG_113__CONTENT_MASK                                                                      0xFFFFFFFFL
+//MP1_SMN_C2PMSG_114
+#define MP1_SMN_C2PMSG_114__CONTENT__SHIFT                                                                    0x0
+#define MP1_SMN_C2PMSG_114__CONTENT_MASK                                                                      0xFFFFFFFFL
+//MP1_SMN_C2PMSG_115
+#define MP1_SMN_C2PMSG_115__CONTENT__SHIFT                                                                    0x0
+#define MP1_SMN_C2PMSG_115__CONTENT_MASK                                                                      0xFFFFFFFFL
+//MP1_SMN_C2PMSG_116
+#define MP1_SMN_C2PMSG_116__CONTENT__SHIFT                                                                    0x0
+#define MP1_SMN_C2PMSG_116__CONTENT_MASK                                                                      0xFFFFFFFFL
+//MP1_SMN_C2PMSG_117
+#define MP1_SMN_C2PMSG_117__CONTENT__SHIFT                                                                    0x0
+#define MP1_SMN_C2PMSG_117__CONTENT_MASK                                                                      0xFFFFFFFFL
+//MP1_SMN_C2PMSG_118
+#define MP1_SMN_C2PMSG_118__CONTENT__SHIFT                                                                    0x0
+#define MP1_SMN_C2PMSG_118__CONTENT_MASK                                                                      0xFFFFFFFFL
+//MP1_SMN_C2PMSG_119
+#define MP1_SMN_C2PMSG_119__CONTENT__SHIFT                                                                    0x0
+#define MP1_SMN_C2PMSG_119__CONTENT_MASK                                                                      0xFFFFFFFFL
+//MP1_SMN_C2PMSG_120
+#define MP1_SMN_C2PMSG_120__CONTENT__SHIFT                                                                    0x0
+#define MP1_SMN_C2PMSG_120__CONTENT_MASK                                                                      0xFFFFFFFFL
+//MP1_SMN_C2PMSG_121
+#define MP1_SMN_C2PMSG_121__CONTENT__SHIFT                                                                    0x0
+#define MP1_SMN_C2PMSG_121__CONTENT_MASK                                                                      0xFFFFFFFFL
+//MP1_SMN_C2PMSG_122
+#define MP1_SMN_C2PMSG_122__CONTENT__SHIFT                                                                    0x0
+#define MP1_SMN_C2PMSG_122__CONTENT_MASK                                                                      0xFFFFFFFFL
+//MP1_SMN_C2PMSG_123
+#define MP1_SMN_C2PMSG_123__CONTENT__SHIFT                                                                    0x0
+#define MP1_SMN_C2PMSG_123__CONTENT_MASK                                                                      0xFFFFFFFFL
+//MP1_SMN_C2PMSG_124
+#define MP1_SMN_C2PMSG_124__CONTENT__SHIFT                                                                    0x0
+#define MP1_SMN_C2PMSG_124__CONTENT_MASK                                                                      0xFFFFFFFFL
+//MP1_SMN_C2PMSG_125
+#define MP1_SMN_C2PMSG_125__CONTENT__SHIFT                                                                    0x0
+#define MP1_SMN_C2PMSG_125__CONTENT_MASK                                                                      0xFFFFFFFFL
+//MP1_SMN_C2PMSG_126
+#define MP1_SMN_C2PMSG_126__CONTENT__SHIFT                                                                    0x0
+#define MP1_SMN_C2PMSG_126__CONTENT_MASK                                                                      0xFFFFFFFFL
+//MP1_SMN_C2PMSG_127
+#define MP1_SMN_C2PMSG_127__CONTENT__SHIFT                                                                    0x0
+#define MP1_SMN_C2PMSG_127__CONTENT_MASK                                                                      0xFFFFFFFFL
+//MP1_SMN_IH_CREDIT
+#define MP1_SMN_IH_CREDIT__CREDIT_VALUE__SHIFT                                                                0x0
+#define MP1_SMN_IH_CREDIT__CLIENT_ID__SHIFT                                                                   0x10
+#define MP1_SMN_IH_CREDIT__CREDIT_VALUE_MASK                                                                  0x00000003L
+#define MP1_SMN_IH_CREDIT__CLIENT_ID_MASK                                                                     0x00FF0000L
+//MP1_SMN_IH_SW_INT
+#define MP1_SMN_IH_SW_INT__ID__SHIFT                                                                          0x0
+#define MP1_SMN_IH_SW_INT__VALID__SHIFT                                                                       0x8
+#define MP1_SMN_IH_SW_INT__ID_MASK                                                                            0x000000FFL
+#define MP1_SMN_IH_SW_INT__VALID_MASK                                                                         0x00000100L
+//MP1_SMN_IH_SW_INT_CTRL
+#define MP1_SMN_IH_SW_INT_CTRL__INT_MASK__SHIFT                                                               0x0
+#define MP1_SMN_IH_SW_INT_CTRL__INT_ACK__SHIFT                                                                0x8
+#define MP1_SMN_IH_SW_INT_CTRL__INT_MASK_MASK                                                                 0x00000001L
+#define MP1_SMN_IH_SW_INT_CTRL__INT_ACK_MASK                                                                  0x00000100L
+//MP1_SMN_FPS_CNT
+#define MP1_SMN_FPS_CNT__COUNT__SHIFT                                                                         0x0
+#define MP1_SMN_FPS_CNT__COUNT_MASK                                                                           0xFFFFFFFFL
+//MP1_SMN_EXT_SCRATCH0
+#define MP1_SMN_EXT_SCRATCH0__DATA__SHIFT                                                                     0x0
+#define MP1_SMN_EXT_SCRATCH0__DATA_MASK                                                                       0xFFFFFFFFL
+//MP1_SMN_EXT_SCRATCH1
+#define MP1_SMN_EXT_SCRATCH1__DATA__SHIFT                                                                     0x0
+#define MP1_SMN_EXT_SCRATCH1__DATA_MASK                                                                       0xFFFFFFFFL
+//MP1_SMN_EXT_SCRATCH2
+#define MP1_SMN_EXT_SCRATCH2__DATA__SHIFT                                                                     0x0
+#define MP1_SMN_EXT_SCRATCH2__DATA_MASK                                                                       0xFFFFFFFFL
+//MP1_SMN_EXT_SCRATCH3
+#define MP1_SMN_EXT_SCRATCH3__DATA__SHIFT                                                                     0x0
+#define MP1_SMN_EXT_SCRATCH3__DATA_MASK                                                                       0xFFFFFFFFL
+//MP1_SMN_EXT_SCRATCH4
+#define MP1_SMN_EXT_SCRATCH4__DATA__SHIFT                                                                     0x0
+#define MP1_SMN_EXT_SCRATCH4__DATA_MASK                                                                       0xFFFFFFFFL
+//MP1_SMN_EXT_SCRATCH5
+#define MP1_SMN_EXT_SCRATCH5__DATA__SHIFT                                                                     0x0
+#define MP1_SMN_EXT_SCRATCH5__DATA_MASK                                                                       0xFFFFFFFFL
+//MP1_SMN_EXT_SCRATCH6
+#define MP1_SMN_EXT_SCRATCH6__DATA__SHIFT                                                                     0x0
+#define MP1_SMN_EXT_SCRATCH6__DATA_MASK                                                                       0xFFFFFFFFL
+//MP1_SMN_EXT_SCRATCH7
+#define MP1_SMN_EXT_SCRATCH7__DATA__SHIFT                                                                     0x0
+#define MP1_SMN_EXT_SCRATCH7__DATA_MASK                                                                       0xFFFFFFFFL
+//MP1_SMN_EXT_SCRATCH8
+#define MP1_SMN_EXT_SCRATCH8__DATA__SHIFT                                                                     0x0
+#define MP1_SMN_EXT_SCRATCH8__DATA_MASK                                                                       0xFFFFFFFFL
+//MP1_SMN_EXT_SCRATCH9
+#define MP1_SMN_EXT_SCRATCH9__DATA__SHIFT                                                                     0x0
+#define MP1_SMN_EXT_SCRATCH9__DATA_MASK                                                                       0xFFFFFFFFL
+//MP1_SMN_EXT_SCRATCH10
+#define MP1_SMN_EXT_SCRATCH10__DATA__SHIFT                                                                    0x0
+#define MP1_SMN_EXT_SCRATCH10__DATA_MASK                                                                      0xFFFFFFFFL
+//MP1_SMN_EXT_SCRATCH11
+#define MP1_SMN_EXT_SCRATCH11__DATA__SHIFT                                                                    0x0
+#define MP1_SMN_EXT_SCRATCH11__DATA_MASK                                                                      0xFFFFFFFFL
+//MP1_SMN_EXT_SCRATCH12
+#define MP1_SMN_EXT_SCRATCH12__DATA__SHIFT                                                                    0x0
+#define MP1_SMN_EXT_SCRATCH12__DATA_MASK                                                                      0xFFFFFFFFL
+//MP1_SMN_EXT_SCRATCH13
+#define MP1_SMN_EXT_SCRATCH13__DATA__SHIFT                                                                    0x0
+#define MP1_SMN_EXT_SCRATCH13__DATA_MASK                                                                      0xFFFFFFFFL
+//MP1_SMN_EXT_SCRATCH14
+#define MP1_SMN_EXT_SCRATCH14__DATA__SHIFT                                                                    0x0
+#define MP1_SMN_EXT_SCRATCH14__DATA_MASK                                                                      0xFFFFFFFFL
+//MP1_SMN_EXT_SCRATCH15
+#define MP1_SMN_EXT_SCRATCH15__DATA__SHIFT                                                                    0x0
+#define MP1_SMN_EXT_SCRATCH15__DATA_MASK                                                                      0xFFFFFFFFL
+//MP1_SMN_EXT_SCRATCH16
+#define MP1_SMN_EXT_SCRATCH16__DATA__SHIFT                                                                    0x0
+#define MP1_SMN_EXT_SCRATCH16__DATA_MASK                                                                      0xFFFFFFFFL
+//MP1_SMN_EXT_SCRATCH17
+#define MP1_SMN_EXT_SCRATCH17__DATA__SHIFT                                                                    0x0
+#define MP1_SMN_EXT_SCRATCH17__DATA_MASK                                                                      0xFFFFFFFFL
+//MP1_SMN_EXT_SCRATCH18
+#define MP1_SMN_EXT_SCRATCH18__DATA__SHIFT                                                                    0x0
+#define MP1_SMN_EXT_SCRATCH18__DATA_MASK                                                                      0xFFFFFFFFL
+//MP1_SMN_EXT_SCRATCH19
+#define MP1_SMN_EXT_SCRATCH19__DATA__SHIFT                                                                    0x0
+#define MP1_SMN_EXT_SCRATCH19__DATA_MASK                                                                      0xFFFFFFFFL
+//MP1_SMN_EXT_SCRATCH20
+#define MP1_SMN_EXT_SCRATCH20__DATA__SHIFT                                                                    0x0
+#define MP1_SMN_EXT_SCRATCH20__DATA_MASK                                                                      0xFFFFFFFFL
+//MP1_SMN_EXT_SCRATCH21
+#define MP1_SMN_EXT_SCRATCH21__DATA__SHIFT                                                                    0x0
+#define MP1_SMN_EXT_SCRATCH21__DATA_MASK                                                                      0xFFFFFFFFL
+//MP1_SMN_EXT_SCRATCH22
+#define MP1_SMN_EXT_SCRATCH22__DATA__SHIFT                                                                    0x0
+#define MP1_SMN_EXT_SCRATCH22__DATA_MASK                                                                      0xFFFFFFFFL
+//MP1_SMN_EXT_SCRATCH23
+#define MP1_SMN_EXT_SCRATCH23__DATA__SHIFT                                                                    0x0
+#define MP1_SMN_EXT_SCRATCH23__DATA_MASK                                                                      0xFFFFFFFFL
+//MP1_SMN_EXT_SCRATCH24
+#define MP1_SMN_EXT_SCRATCH24__DATA__SHIFT                                                                    0x0
+#define MP1_SMN_EXT_SCRATCH24__DATA_MASK                                                                      0xFFFFFFFFL
+//MP1_SMN_EXT_SCRATCH25
+#define MP1_SMN_EXT_SCRATCH25__DATA__SHIFT                                                                    0x0
+#define MP1_SMN_EXT_SCRATCH25__DATA_MASK                                                                      0xFFFFFFFFL
+//MP1_SMN_EXT_SCRATCH26
+#define MP1_SMN_EXT_SCRATCH26__DATA__SHIFT                                                                    0x0
+#define MP1_SMN_EXT_SCRATCH26__DATA_MASK                                                                      0xFFFFFFFFL
+//MP1_SMN_EXT_SCRATCH27
+#define MP1_SMN_EXT_SCRATCH27__DATA__SHIFT                                                                    0x0
+#define MP1_SMN_EXT_SCRATCH27__DATA_MASK                                                                      0xFFFFFFFFL
+//MP1_SMN_EXT_SCRATCH28
+#define MP1_SMN_EXT_SCRATCH28__DATA__SHIFT                                                                    0x0
+#define MP1_SMN_EXT_SCRATCH28__DATA_MASK                                                                      0xFFFFFFFFL
+//MP1_SMN_EXT_SCRATCH29
+#define MP1_SMN_EXT_SCRATCH29__DATA__SHIFT                                                                    0x0
+#define MP1_SMN_EXT_SCRATCH29__DATA_MASK                                                                      0xFFFFFFFFL
+//MP1_SMN_EXT_SCRATCH30
+#define MP1_SMN_EXT_SCRATCH30__DATA__SHIFT                                                                    0x0
+#define MP1_SMN_EXT_SCRATCH30__DATA_MASK                                                                      0xFFFFFFFFL
+//MP1_SMN_EXT_SCRATCH31
+#define MP1_SMN_EXT_SCRATCH31__DATA__SHIFT                                                                    0x0
+#define MP1_SMN_EXT_SCRATCH31__DATA_MASK                                                                      0xFFFFFFFFL
+
+#endif
-- 
2.41.0

