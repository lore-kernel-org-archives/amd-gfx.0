Return-Path: <SRS0=QW4G=K4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0D77C47099
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 16:49:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C194561C2E
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 16:49:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C194561C2E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9472F6ED87;
	Wed,  2 Jun 2021 16:49:46 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2049.outbound.protection.outlook.com [40.107.220.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 913E96ED7E
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Jun 2021 16:49:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YZ4oLof1Qv9lgRoZVnw1akSbZ43Vk9s58XhPYat6U2hnFoB8ypeArG/MULRIknJ9iqtBHjOl+4TiNJ2irQnhxTVxb3M1+VtjXbNNcvvpuwnCAaxlAti21zTL0vtoWNMVcOw7YHiLARCFecdxoiEuGQGlNJAorGf5Ng8GsXSFt0eWvrvmURH+2ARgIpGIepR0YuN3T6nZGEXs/WlF1LshkMCcQVTEGYmaextrcSBzxbhBXZS6FTTpJauVtDk8bPfU3XWbNueHLmOhGOD/4XzTLIqiiS/rLNUXOBXpvn8zoOoNqcdUBeL3Vjrrh4alQPzLix0ebWF2os9zH2gZOzb/Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mB+jYG4GpaQQNsVLVaArJ5QLo8eBrXsAJ8uQmZbETrI=;
 b=k+2PVkjHVek35ECrEkDXsNr7Dy+izqmLkXh1zlCU944+hXNTEhajLB3jU1hiQtPcW8K/6sY+yG22K5wPclAZUtd8prW0TfqowgOSDJSNexSvRjgmjdAKKt1RG7igeMeGdos5C+Hjfd28q/oGMlyy0YmvJK0zimaZfFKiOdeTF9SmUpO903uDmWkAfi7rjoef+1fHWwTYtUyQI1zhONEVwgAy2rM/0/0RLcNRlAcXWv6B/BYqE8BBbCoMrf62+wCQVlGzVrrofuv9kgU2PPRB0TREUkF0QPZCW3rCE2eQNaaMnvOgh9EiAiC22OaTZ3J4yPgWXw887rQY1t+zG58bjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mB+jYG4GpaQQNsVLVaArJ5QLo8eBrXsAJ8uQmZbETrI=;
 b=Q6Yqk5ECRqurjbYCr2880JCExdj3FtoNA/mR1y1ege9hfCwKqIh5FgsDICX7Zb9mJ47SLgCr5YK1n3DTtOS9UPBlCRRbwRiCleHjfrUYvIHVxrrS8JF/q5eAKbvWkQEqRmfEs2Gw7sgZjcV0d0VNtj3AATiJfGcxxo6ACarRDgA=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4077.namprd12.prod.outlook.com (2603:10b6:208:1da::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.21; Wed, 2 Jun
 2021 16:49:41 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::25f7:664:3a8f:25b6]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::25f7:664:3a8f:25b6%7]) with mapi id 15.20.4173.030; Wed, 2 Jun 2021
 16:49:41 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 19/89] drm/amd/pm: add yellow_carp_ppt implementation(V3)
Date: Wed,  2 Jun 2021 12:47:58 -0400
Message-Id: <20210602164908.2848791-19-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210602164908.2848791-1-alexander.deucher@amd.com>
References: <20210602164908.2848791-1-alexander.deucher@amd.com>
X-Originating-IP: [192.161.79.207]
X-ClientProxiedBy: MN2PR13CA0007.namprd13.prod.outlook.com
 (2603:10b6:208:160::20) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.207) by
 MN2PR13CA0007.namprd13.prod.outlook.com (2603:10b6:208:160::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.9 via Frontend
 Transport; Wed, 2 Jun 2021 16:49:40 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fd4c3690-873c-4d35-e044-08d925e66a9a
X-MS-TrafficTypeDiagnostic: MN2PR12MB4077:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4077F3C13F23ADD175EB00B7F73D9@MN2PR12MB4077.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CixgHdaz+lVCVrEIOoBlUBqGkPQwo2hvMIsFOnwiT34pFbKdddN9va00l7MK0z1o/CXrI5HjZ8a5UjUhDMU6xMK7qp4qi6LqcP3v8FDTC2iBBLSE64eYPkkQqzE7TlCYRyyZU6hAESSXge5pGSrv3Iupb+1omLpM14g+lieq8TUog25yFIrjmNzoV9E9hcr5Tv0SMQu/QL2OPYaWY3NFmiqVYXTpWMLabl3ySMVT+7zWXGSaDSo2bqaUIsm3TknVCi25HjtDU91N4LtaA02wtMFcapQHrnoYVvWtWJMPhpOBz6vc4iwcrrQ9XcUqW0VpKfe3dbpt2Kc0EOLxp+kgRjv+LO+z5QTpt+oLedJi8rIBq00uYSjT3BH0FaFb1hYKI1vHNFdaG39sG4tYq8Om1ZYLNTAUoGTOMrb7r0YqrIfoWPxY79NnMwkbctPqNRSMQSaTbEDkNbrT3t8gALl9IsB3p0ILj80/1WZEqtkHDeo/+dksh9pxtJy5w38oxTHIBRXGDskG83LGBZO8uzxlQWpIFcaUCEk42lHHdGubkUtgsk/Y8cohrZOBjWvPeH6pvoBDoPcvFulAnqQLqNxBEbAQzV4Z4sbYQzSyYdJQbSW/60Fknf+M4MKNC+k3XxC2Z5yy1W9dHBQLMi1SKVWrwSt++MyiUvx5YdC4jmX3zNbuMPkLK9kjAimyRKbKOvrD
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(376002)(346002)(396003)(39850400004)(8676002)(54906003)(4326008)(5660300002)(8936002)(6666004)(478600001)(316002)(83380400001)(16526019)(1076003)(6506007)(956004)(2616005)(52116002)(66946007)(26005)(66476007)(66556008)(2906002)(6916009)(38100700002)(38350700002)(36756003)(86362001)(6512007)(186003)(6486002)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?0WHhlgaNtXbR3EsMY6yI6nguzZCSKUXUhzPUPMYrUU8JTKknU0QS4kiAE4+c?=
 =?us-ascii?Q?WvqXxW8i+he/iRIMhAa/cArkKYv1+wi+ZqZzfXek4WbaHciW9wcBcuXtuSXK?=
 =?us-ascii?Q?iQ7HCYAkeNlNu3PhVzi7Wef4/oBoK+sNq42K0wtQ4OIJFj0pfepV2RH2O+oo?=
 =?us-ascii?Q?5gmnkgb2ZkVA1+7JJXNDYLyFuXl5iHdY7aWqTaGDU2OMFjIHent6lgIkcGdw?=
 =?us-ascii?Q?8buZKla94cE5yXbOLg8OXOrf2+UyUL9NpgKU9FtWqlBEL6UG0h91XxT/8rVn?=
 =?us-ascii?Q?X3dxFr5VN8meaHOCatn3m/21/iCmXVD4jiByVhjO8sALxeK7uYR602Rg5dTf?=
 =?us-ascii?Q?t8XscLtVK42ntC1IOk3Rc64XBubrD8QJm8TujCpewqck/L8lQw2se15V5YoC?=
 =?us-ascii?Q?3kadkvZWg3Z/LbYtOHH7cITDbtBGjR7W6ZsPspAzVcHz7SZMLe3Tzs6uo/ou?=
 =?us-ascii?Q?3RoGe+YjNpyK9TZ7LX3y2KDc10zalkbcpe9g7ATFiSScxXtpx0UYoHbQe6Fk?=
 =?us-ascii?Q?FCciwqjpdxO/L3xvMOoUKWQRIvLFFazFx+dHZXEHICoWVOhg2ZIWisA7ogqX?=
 =?us-ascii?Q?NQxfVKrIsGaXPWvyDCJV1LGdTbfTRgpGmI/w+M0z8Vg3BOO6bjB1HbrNlFeP?=
 =?us-ascii?Q?mWhJqZD5vZV368aa7Tw93WFzgu0WhotJxVoLiUl9zGIcINTJo2YRQbWYCRuw?=
 =?us-ascii?Q?tHfYu2pdQg0Rfdto07Kc22mE90TEhWw6xJgUPWxS9KXl0EPmSOmVg3yJ89Ey?=
 =?us-ascii?Q?ZWqqVawvsU+vz4+VKwL1TswBtbMr6hzQ3uhA0MHDMTqBzmyuN6IXiJr9+pXf?=
 =?us-ascii?Q?rY44iWTG9r6rrqcAyoT/r0esXKunHvGLBeRRfXBq5TYtVTEBP/nZctnyxbyf?=
 =?us-ascii?Q?oXIOea/I0OUB+qiqB3RRPp4gSJpQXag3Am7Zxhk0CZfx/lDXhCOwDWyb4A1L?=
 =?us-ascii?Q?j3TBj75VOBcSXNucMtrPoQHfH5sZ0C/eEDfmkj+psUNjpdbXMf+4OTjQkQdp?=
 =?us-ascii?Q?SkKM8He3xUt1q1zI1b4L0Tr0nlSrPq0vkTjvHCjFdRUKGK/BRH4PZTrBQsDY?=
 =?us-ascii?Q?2LE2YZJLApZGYv4Dh6qnbzzezP1tfsmibp3+rFCnzbWxR6uS2l/7UMSaDrMO?=
 =?us-ascii?Q?+uRWoIuVyTUOypLXKFqSfxVgfw1FwUWWsONKPItClIk6ne4gQN/57MPO/qea?=
 =?us-ascii?Q?4jiIFHcYJyrQAI8C5aPwSLXyhbH8qwI/oFtypyUCQp9lke7B3D5aJGA50XnA?=
 =?us-ascii?Q?W5lcBHrD3VyiehiSzITh6V9PL1JTpn0j4TMuiHaHPemSY0lOfuP/TaSmDmtY?=
 =?us-ascii?Q?RHtFnxtzlTRDK/jynX0AdoA7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd4c3690-873c-4d35-e044-08d925e66a9a
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2021 16:49:41.2419 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eDv5tDdQKRP0A9CW1KrZABUdGOtlA+QyD8Tlf3RrOs4WAH63WJnXcG6L3BSxB2OWumJTn3QJ058k37wEq77vFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4077
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
 Huang Rui <ray.huang@amd.com>, Aaron Liu <aaron.liu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aaron Liu <aaron.liu@amd.com>

yellow_carp_ppt is swsmu layer 2 code for yellow carp.
V2: rename smu_v13_0 to smu_v13_0_1
V3: cleanup code.

Signed-off-by: Aaron Liu <aaron.liu@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Huang Rui <ray.huang@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/Makefile   |   2 +-
 .../drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c  | 163 ++++++++++++++++++
 .../drm/amd/pm/swsmu/smu13/yellow_carp_ppt.h  |  28 +++
 3 files changed, 192 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
 create mode 100644 drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.h

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/Makefile b/drivers/gpu/drm/amd/pm/swsmu/smu13/Makefile
index 0fb3ddc251e4..9b3a8503f5cd 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/Makefile
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/Makefile
@@ -23,7 +23,7 @@
 # Makefile for the 'smu manager' sub-component of powerplay.
 # It provides the smu management services for the driver.
 
-SMU13_MGR = smu_v13_0.o aldebaran_ppt.o smu_v13_0_1.o
+SMU13_MGR = smu_v13_0.o aldebaran_ppt.o smu_v13_0_1.o yellow_carp_ppt.o
 
 AMD_SWSMU_SMU13MGR = $(addprefix $(AMD_SWSMU_PATH)/smu13/,$(SMU13_MGR))
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
new file mode 100644
index 000000000000..fd6b3f043efb
--- /dev/null
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
@@ -0,0 +1,163 @@
+/*
+ * Copyright 2020 Advanced Micro Devices, Inc.
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
+#define SWSMU_CODE_LAYER_L2
+
+#include "amdgpu.h"
+#include "amdgpu_smu.h"
+#include "smu_v13_0_1.h"
+#include "smu13_driver_if_yellow_carp.h"
+#include "yellow_carp_ppt.h"
+#include "smu_v13_0_1_ppsmc.h"
+#include "smu_v13_0_1_pmfw.h"
+#include "smu_cmn.h"
+
+/*
+ * DO NOT use these for err/warn/info/debug messages.
+ * Use dev_err, dev_warn, dev_info and dev_dbg instead.
+ * They are more MGPU friendly.
+ */
+#undef pr_err
+#undef pr_warn
+#undef pr_info
+#undef pr_debug
+
+static struct cmn2asic_msg_mapping yellow_carp_message_map[SMU_MSG_MAX_COUNT] = {
+	MSG_MAP(TestMessage,                    PPSMC_MSG_TestMessage,			1),
+	MSG_MAP(GetSmuVersion,                  PPSMC_MSG_GetSmuVersion,		1),
+	MSG_MAP(GetDriverIfVersion,             PPSMC_MSG_GetDriverIfVersion,		1),
+	MSG_MAP(EnableGfxOff,                   PPSMC_MSG_EnableGfxOff,			1),
+	MSG_MAP(AllowGfxOff,                    PPSMC_MSG_AllowGfxOff,			1),
+	MSG_MAP(DisallowGfxOff,                 PPSMC_MSG_DisallowGfxOff,		1),
+	MSG_MAP(PowerDownVcn,                   PPSMC_MSG_PowerDownVcn,			1),
+	MSG_MAP(PowerUpVcn,                     PPSMC_MSG_PowerUpVcn,			1),
+	MSG_MAP(SetHardMinVcn,                  PPSMC_MSG_SetHardMinVcn,		1),
+	MSG_MAP(ActiveProcessNotify,            PPSMC_MSG_ActiveProcessNotify,		1),
+	MSG_MAP(SetDriverDramAddrHigh,          PPSMC_MSG_SetDriverDramAddrHigh,	1),
+	MSG_MAP(SetDriverDramAddrLow,           PPSMC_MSG_SetDriverDramAddrLow,		1),
+	MSG_MAP(TransferTableSmu2Dram,          PPSMC_MSG_TransferTableSmu2Dram,	1),
+	MSG_MAP(TransferTableDram2Smu,          PPSMC_MSG_TransferTableDram2Smu,	1),
+	MSG_MAP(GfxDeviceDriverReset,           PPSMC_MSG_GfxDeviceDriverReset,		1),
+	MSG_MAP(GetEnabledSmuFeatures,          PPSMC_MSG_GetEnabledSmuFeatures,	1),
+	MSG_MAP(SetHardMinSocclkByFreq,         PPSMC_MSG_SetHardMinSocclkByFreq,	1),
+	MSG_MAP(SetSoftMinVcn,                  PPSMC_MSG_SetSoftMinVcn,		1),
+	MSG_MAP(GetGfxclkFrequency,             PPSMC_MSG_GetGfxclkFrequency,		1),
+	MSG_MAP(GetFclkFrequency,               PPSMC_MSG_GetFclkFrequency,		1),
+	MSG_MAP(SetSoftMaxGfxClk,               PPSMC_MSG_SetSoftMaxGfxClk,		1),
+	MSG_MAP(SetHardMinGfxClk,               PPSMC_MSG_SetHardMinGfxClk,		1),
+	MSG_MAP(SetSoftMaxSocclkByFreq,         PPSMC_MSG_SetSoftMaxSocclkByFreq,	1),
+	MSG_MAP(SetSoftMaxFclkByFreq,           PPSMC_MSG_SetSoftMaxFclkByFreq,		1),
+	MSG_MAP(SetSoftMaxVcn,                  PPSMC_MSG_SetSoftMaxVcn,		1),
+	MSG_MAP(SetPowerLimitPercentage,        PPSMC_MSG_SetPowerLimitPercentage,	1),
+	MSG_MAP(PowerDownJpeg,                  PPSMC_MSG_PowerDownJpeg,		1),
+	MSG_MAP(PowerUpJpeg,                    PPSMC_MSG_PowerUpJpeg,			1),
+	MSG_MAP(SetHardMinFclkByFreq,           PPSMC_MSG_SetHardMinFclkByFreq,		1),
+	MSG_MAP(SetSoftMinSocclkByFreq,         PPSMC_MSG_SetSoftMinSocclkByFreq,	1),
+};
+
+static struct cmn2asic_mapping yellow_carp_table_map[SMU_TABLE_COUNT] = {
+	TAB_MAP_VALID(WATERMARKS),
+	TAB_MAP_VALID(SMU_METRICS),
+	TAB_MAP_VALID(CUSTOM_DPM),
+	TAB_MAP_VALID(DPMCLOCKS),
+};
+	
+static int yellow_carp_init_smc_tables(struct smu_context *smu)
+{
+	struct smu_table_context *smu_table = &smu->smu_table;
+	struct smu_table *tables = smu_table->tables;
+
+	SMU_TABLE_INIT(tables, SMU_TABLE_WATERMARKS, sizeof(Watermarks_t),
+		PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
+	SMU_TABLE_INIT(tables, SMU_TABLE_DPMCLOCKS, sizeof(DpmClocks_t),
+		PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
+	SMU_TABLE_INIT(tables, SMU_TABLE_SMU_METRICS, sizeof(SmuMetrics_t),
+		PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
+
+	smu_table->clocks_table = kzalloc(sizeof(DpmClocks_t), GFP_KERNEL);
+	if (!smu_table->clocks_table)
+		goto err0_out;
+
+	smu_table->metrics_table = kzalloc(sizeof(SmuMetrics_t), GFP_KERNEL);
+	if (!smu_table->metrics_table)
+		goto err1_out;
+	smu_table->metrics_time = 0;
+
+	smu_table->watermarks_table = kzalloc(sizeof(Watermarks_t), GFP_KERNEL);
+	if (!smu_table->watermarks_table)
+		goto err2_out;
+
+	smu_table->gpu_metrics_table_size = sizeof(struct gpu_metrics_v2_0);
+	smu_table->gpu_metrics_table = kzalloc(smu_table->gpu_metrics_table_size, GFP_KERNEL);
+	if (!smu_table->gpu_metrics_table)
+		goto err3_out;
+
+	return 0;
+
+err3_out:
+	kfree(smu_table->watermarks_table);
+err2_out:
+	kfree(smu_table->metrics_table);
+err1_out:
+	kfree(smu_table->clocks_table);
+err0_out:
+	return -ENOMEM;
+}
+
+static bool yellow_carp_is_dpm_running(struct smu_context *smu)
+{
+	struct amdgpu_device *adev = smu->adev;
+
+	/*
+	 * Until now, the pmfw hasn't exported the interface of SMU
+	 * feature mask to APU SKU so just force on all the feature
+	 * at early initial stage.
+	 */
+	if (adev->in_suspend)
+		return false;
+	else
+		return true;
+
+}
+
+static const struct pptable_funcs yellow_carp_ppt_funcs = {
+	.check_fw_status = smu_v13_0_1_check_fw_status,
+	.check_fw_version = smu_v13_0_1_check_fw_version,
+	.init_smc_tables = yellow_carp_init_smc_tables,
+	.fini_smc_tables = smu_v13_0_1_fini_smc_tables,
+	.send_smc_msg_with_param = smu_cmn_send_smc_msg_with_param,
+	.send_smc_msg = smu_cmn_send_smc_msg,
+	.set_default_dpm_table = smu_v13_0_1_set_default_dpm_tables,
+	.is_dpm_running = yellow_carp_is_dpm_running,
+	.get_pp_feature_mask = smu_cmn_get_pp_feature_mask,
+	.set_pp_feature_mask = smu_cmn_set_pp_feature_mask,
+	.disable_all_features_with_exception = smu_cmn_disable_all_features_with_exception,
+};
+
+void yellow_carp_set_ppt_funcs(struct smu_context *smu)
+{
+	smu->ppt_funcs = &yellow_carp_ppt_funcs;
+	smu->message_map = yellow_carp_message_map;
+	smu->table_map = yellow_carp_table_map;
+	smu->is_apu = true;
+}
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.h b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.h
new file mode 100644
index 000000000000..b3ad8352c68a
--- /dev/null
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.h
@@ -0,0 +1,28 @@
+/*
+ * Copyright 2020 Advanced Micro Devices, Inc.
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
+#ifndef __YELLOW_CARP_PPT_H__
+#define __YELLOW_CARP_PPT_H__
+
+extern void yellow_carp_set_ppt_funcs(struct smu_context *smu);
+
+#endif
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
