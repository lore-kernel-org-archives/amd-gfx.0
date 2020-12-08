Return-Path: <SRS0=uNpP=FM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12F92C433FE
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Dec 2020 06:26:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FFC823A63
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Dec 2020 06:26:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FFC823A63
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 29E676E94A;
	Tue,  8 Dec 2020 06:26:22 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2084.outbound.protection.outlook.com [40.107.92.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E3F56E94A
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Dec 2020 06:26:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P3ESMSKj0U/nDUih53SJ6kb0DoK4F7MJhwW2NfLi5ntuxgqmi/m0mflFDCVY6F1BIyQ4kbE0AzrbC83vYGJnhpibBdjvFOOkWcxWzTu6AhX/MFSJ8wD9Wrd3bwDAxcEtuGSbCKjUPslzMnDALtd0fozt2mv687T/Tb/j+QHCBG9b7Srgy2XK2wT900myGeyjmaPgwd1+bergRIoU3erGuGLnGjRSJgJdCVklNXwA8rQH+Sdy+QJ87oVpAJBnsU8bYckOPU3o6RgmKcwFnTBYIPlXJWeYWRMptSatRgfovllLtvFHRNe/PoV8DexKQYLnJb62TxC/MQbV0vForT8FEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HvfEuQv3767PmWKiAjnB1OpQYyHAsxbRKTRvY2PUB6A=;
 b=TTOzDZFOMGwXZjmoiqcOnTLWtmuKOIKlpXMqXw34W+fqN4GZY8gMkNbbYKjFOFvqgofqDB8cHJ7JfMXgE1cvo5xW2op8n22c1sNhJUAZpQw3+r0x/zZPVumNGUPYmvp+XE/sInFdbUZL6Wd6mG5pUCEvwfVHHyGzU4CXHDBNsY0mcHlxU8CTPgfHOOEvoMXjqO6Dj/4VKcmTkcaQFyhsl14/jxNY2Xkgp7HvHy+fQXdFHweN5e2d0lVcZu0oVvIkJwg7/yFMLZc1kXD14j1Rn1kM3zMu+8b56yBrdaowDWSSfqyTiJBgELy9K4foX+yax1sNS52uMZmPIHbzNO+dSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HvfEuQv3767PmWKiAjnB1OpQYyHAsxbRKTRvY2PUB6A=;
 b=LuKe5P3AnysIiTnsITWea5dW0//Rww/u2yGkHVES7J0pzFhDcYC8857pEd0k1NA8IOwoKqzmHwuSTBaQnH8kByJDCDz7hln5b/HTjfyzcFeWbtdHplD5QAYJkcddjwB299r3+4v1rlhLPkv+CFA8tfax1boaTEwJ4PL0c7vLBAE=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4940.namprd12.prod.outlook.com (2603:10b6:610:65::10)
 by CH2PR12MB4021.namprd12.prod.outlook.com (2603:10b6:610:2b::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17; Tue, 8 Dec
 2020 06:26:17 +0000
Received: from CH2PR12MB4940.namprd12.prod.outlook.com
 ([fe80::350b:2673:2db7:8696]) by CH2PR12MB4940.namprd12.prod.outlook.com
 ([fe80::350b:2673:2db7:8696%9]) with mapi id 15.20.3632.021; Tue, 8 Dec 2020
 06:26:17 +0000
From: Aaron Liu <aaron.liu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 6/8] drm/amd/pm: add yellow_carp_ppt implementation(V3)
Date: Tue,  8 Dec 2020 14:26:00 +0800
Message-Id: <20201208062600.23443-1-aaron.liu@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [180.167.199.189]
X-ClientProxiedBy: HK0PR01CA0071.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::35) To CH2PR12MB4940.namprd12.prod.outlook.com
 (2603:10b6:610:65::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from aaliu.amd.com (180.167.199.189) by
 HK0PR01CA0071.apcprd01.prod.exchangelabs.com (2603:1096:203:a6::35) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17 via Frontend
 Transport; Tue, 8 Dec 2020 06:26:16 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 50e39585-7edd-477f-469c-08d89b422bc1
X-MS-TrafficTypeDiagnostic: CH2PR12MB4021:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB40211B57234E4587CA38F262F0CD0@CH2PR12MB4021.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zTTu9ZQ//WHSS5IOXFigsR4LRVxoaQR0orHCjj17ZzjvPBLgNzzLeg7HV54JUgTeBVA+KeyJbwFszXt3l4+5VEFUdy2BbaCmLhrI4+CT6ZgATGc7ygWjMV5+HGGvhhNsu8fNdI7Vyhp4QFZRl4NgguVuFm10b/8l9W0g32VGuWlwtN+GBWo6kg3J7bb9K5mx0TagQi8XP/aJ7MFgp23+JIYJKJTQ/5cTJsdIRNMLhqfmIfUuKDgLXxchoaB9zKs91wKFFEUI6yyGl5kW4wfedKxTXKeamouvRCu9Iolq/ZIIx6Hr9CKt9UDgpYpHUjp3npngT6YyIYc8zyrhRR/Y2Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4940.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(376002)(346002)(39860400002)(366004)(136003)(36756003)(1076003)(186003)(478600001)(86362001)(52116002)(16526019)(8676002)(316002)(8936002)(26005)(2906002)(6666004)(66946007)(5660300002)(83380400001)(2616005)(6486002)(44832011)(7696005)(4326008)(6916009)(66556008)(956004)(66476007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?fKHGr8xYevBSDJ2A0ZTFAslHgPuZCY7VK7tYOmfvOUQs6ycAbRzcUOnh7f75?=
 =?us-ascii?Q?3q+S7SJ2GAlgNXvX5bM2kiqafYrKccdNn51/edT9a5JxQebSQuJHCuwij6A4?=
 =?us-ascii?Q?I4iuTp5aR6lBQ5nFIRNpMk118I//YF4M9TRArgS+sfMuSMWrtkfYMJKUUHgu?=
 =?us-ascii?Q?Eq9ZJRk/QSFtD2Mk4nFb331eBPy/ou1VaQhC2UT4h9NFYQlBFQ8sdgTPmwUt?=
 =?us-ascii?Q?n8tJQxgO3MmeUX0o8vpL53LLAZClnjnBhB0RdI3wLNbIWJF9bbAnEUoTiDLC?=
 =?us-ascii?Q?u2w8U5RriMyRRJQgShuNdEA7oCHM8FKF7kgG/HbSRMpt2mkTfS8VsxoYc18x?=
 =?us-ascii?Q?0QkXfwAdK1Ko/NFnOAVGn8jyGFk42ttQH3U0O1/24gudZCLzNpGsFkr5BcTa?=
 =?us-ascii?Q?Me1ocWnMrUX2M352GMcI1H5M/FhmiJMg44++0T8T23asAvYMxjJXqOaEQzps?=
 =?us-ascii?Q?O4ytvKDhgsagiYVSK+DvGzSJAmgeCusBGbc+/syEfjNhIlX9mJ7DyjNo6Hy5?=
 =?us-ascii?Q?CxHjPqcEOuBdk27yMNJlH4g18T+mOKc560lggxtP+6QNL/Cvjj/g7fI0FNN6?=
 =?us-ascii?Q?HKRZwj8dtHGlUkrhoVPslXrMe9ihzHQD67lSFZts6kSHvNLUOsD9WweAfwp6?=
 =?us-ascii?Q?WTm6X4oXE5vsHo+YHSq/nt12LYbx0TRyu/8yktckFZqtcR5h822eDOG7nHMX?=
 =?us-ascii?Q?NI2fRSTua9JyQjHqEFCfYgfP5m51OcZoLztMbOHDibqyb1vCQ7wr5HKAAIj7?=
 =?us-ascii?Q?bRbNF9SEH8FpDTylbHDRwOZcQhwranFdOYlLbEDZhpVkQ+K+BkPHOqjc6hGk?=
 =?us-ascii?Q?70MNfo4EjXp39V9gJ3lreY2GLjy45Fn6HN4IkvywswRTt6rqFWx9/IS/ePGA?=
 =?us-ascii?Q?E+Vu4eq8QGWrkOOkS/3ll1VxjpA2JqVrnn1SYcRoii0pjRqRVIqgfKR1AjpS?=
 =?us-ascii?Q?89bzhQ2Fp3xJPIMTi+TDiyYv64EZLqx+cGw2pGEl7+pfGmXPD+3ZBhS6Hbst?=
 =?us-ascii?Q?SP/Y?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4940.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2020 06:26:17.5715 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: 50e39585-7edd-477f-469c-08d89b422bc1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oucA1yy8we0hY0ZQhhyMvBMF5GD5Jp8GX7ehYUqPCzO5EyXFs+MeXDe9MVZWsEz6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4021
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
Cc: lijo.lazar@amd.com, Aaron Liu <aaron.liu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

yellow_carp_ppt is swsmu layer 2 code for yellow carp.
V2: rename smu_v13_0 to smu_v13_0_1
V3: cleanup code.

Signed-off-by: Aaron Liu <aaron.liu@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Huang Rui <ray.huang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/Makefile   |   2 +-
 .../drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c  | 166 ++++++++++++++++++
 .../drm/amd/pm/swsmu/smu13/yellow_carp_ppt.h  |  28 +++
 3 files changed, 195 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
 create mode 100644 drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.h

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/Makefile b/drivers/gpu/drm/amd/pm/swsmu/smu13/Makefile
index 61ac864ac948..2c7f4f0d5b7e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/Makefile
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/Makefile
@@ -23,7 +23,7 @@
 # Makefile for the 'smu manager' sub-component of powerplay.
 # It provides the smu management services for the driver.
 
-SMU13_MGR = smu_v13_0_1.o
+SMU13_MGR = smu_v13_0_1.o yellow_carp_ppt.o
 
 AMD_SWSMU_SMU13MGR = $(addprefix $(AMD_SWSMU_PATH)/smu13/,$(SMU13_MGR))
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
new file mode 100644
index 000000000000..d6686c0e62e5
--- /dev/null
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
@@ -0,0 +1,166 @@
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
+	MSG_MAP(DisableGfxOff,                  PPSMC_MSG_DisableGfxOff,		1),
+	MSG_MAP(AllowGfxOff,                    PPSMC_MSG_AllowGfxOff,			1),
+	MSG_MAP(DisallowGfxOff,                 PPSMC_MSG_DisallowGfxOff,		1),
+	MSG_MAP(PowerDownVcn,                   PPSMC_MSG_PowerDownVcn,			1),
+	MSG_MAP(PowerUpVcn,                     PPSMC_MSG_PowerUpVcn,			1),
+	MSG_MAP(Spare,                          PPSMC_MSG_SPARE0,			1),
+	MSG_MAP(SetHardMinVcn,                  PPSMC_MSG_SetHardMinVcn,		1),
+	MSG_MAP(ActiveProcessNotify,            PPSMC_MSG_ActiveProcessNotify,		1),
+	MSG_MAP(SetDriverDramAddrHigh,          PPSMC_MSG_SetDriverDramAddrHigh,	1),
+	MSG_MAP(SetDriverDramAddrLow,           PPSMC_MSG_SetDriverDramAddrLow,		1),
+	MSG_MAP(TransferTableSmu2Dram,          PPSMC_MSG_TransferTableSmu2Dram,	1),
+	MSG_MAP(TransferTableDram2Smu,          PPSMC_MSG_TransferTableDram2Smu,	1),
+	MSG_MAP(GfxDeviceDriverReset,           PPSMC_MSG_GfxDeviceDriverReset,		1),
+	MSG_MAP(GetEnabledSmuFeatures,          PPSMC_MSG_GetEnabledSmuFeatures,	1),
+	MSG_MAP(Spare1,                         PPSMC_MSG_SPARE1,			1),
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
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
