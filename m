Return-Path: <SRS0=mcQQ=MM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AC7FC636C9
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Jul 2021 15:44:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2DA31601FC
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Jul 2021 15:44:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DA31601FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CEAC66E43F;
	Tue, 20 Jul 2021 15:44:29 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2054.outbound.protection.outlook.com [40.107.100.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A3BF96E444
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Jul 2021 15:44:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qz7S4UBwvmbG04s43uqwjOII+lZlhj1bEScl84O3ckLwoojSxREHKKu7wdnvVeFdghsZXuDvBN0RNT7c0dJRCx4I9wCS/ZrXa+g8cn/mc8RZSstbBaY4p/+Q2VJAXr+bSOQwxnURVpEAyg7jyp0QE/LbZRPgKFUs0DoXhadqHld4F5AG8ihWEN9z5loD1PDlusZnR+DGbi8JMm8FYbSzer+J9lbnIC9B2poDxEJDAPb0O9E270v6DEZQDEzGCDqHonuwNtdAo9vv+qe0bIeSTJa2zl25QET4X8+2IiZNjn67PJyd4WD/qv692+R0C8N0QdUjqtABlE/PRrExEl3zoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rk1Bz/EAZJbr6aIPBvHwJ+ZY/9cm+LOxRw632n/LYsw=;
 b=TsNFiAN12/tfsQTfycM6ALk/YY75CqrA+B1myxo0cEPegmAqsdSl44ry8qAYVSne5kSsoaTAa3VRCCR/cM9eIz+0Uhquv/JXbgxOKwm+gu0lLtZ9HbaFfnEqrPZGxcm5FFFxGtMccSp1SECc6vUhQZNATe/O3XRIk8APmQ4XkZ7c34hrVik0n6nIGLatUeI8V6hEoIvCbcqenIeqlYXyRSZIH3s1goeMH4w92vlimIdOM/U0NX+rKJiQsmUZKRsiBmVQNBRE7wlRJdnFm0bKz7I1Vq9iGIgZ9QU7MuqWG8oPeIjWmzUgsfhj70N8IsCiUZR9cjAmhyycdlPGEHuoSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rk1Bz/EAZJbr6aIPBvHwJ+ZY/9cm+LOxRw632n/LYsw=;
 b=tHPJYMGvrWsHWX2d5SWJ/5qikqQ2qi662dHUDejgxXCg2pKi1ftxer0x7heBVT9YbwgNnlCKo+OoWw6FMxORaqJTkc5gcksvBwipvHexnvOHY1kum4FfmQJguFrHPKS3I2Wws2nbIsBwK7aR3AYWq8a4MVaXrjAzGNLl/LuaB5c=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by BL0PR12MB5538.namprd12.prod.outlook.com (2603:10b6:208:1c9::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21; Tue, 20 Jul
 2021 15:44:27 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::8cb6:59d6:24d0:4dc3]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::8cb6:59d6:24d0:4dc3%9]) with mapi id 15.20.4331.034; Tue, 20 Jul 2021
 15:44:26 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 25/29] drm/amdgpu: add basic ppt functions for cyan_skilfish
Date: Tue, 20 Jul 2021 11:43:45 -0400
Message-Id: <20210720154349.1599827-26-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210720154349.1599827-1-alexander.deucher@amd.com>
References: <20210720154349.1599827-1-alexander.deucher@amd.com>
X-ClientProxiedBy: MN2PR01CA0024.prod.exchangelabs.com (2603:10b6:208:10c::37)
 To BL1PR12MB5144.namprd12.prod.outlook.com
 (2603:10b6:208:316::6)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from tr4.amd.com (165.204.84.11) by
 MN2PR01CA0024.prod.exchangelabs.com (2603:10b6:208:10c::37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4331.22 via Frontend Transport; Tue, 20 Jul 2021 15:44:26 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f9e0dd8f-19d5-4e04-97b7-08d94b954131
X-MS-TrafficTypeDiagnostic: BL0PR12MB5538:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB5538EC272B053CC77B290686F7E29@BL0PR12MB5538.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QBqJ/PpdbX5eTdlTcSkjKeBUH0VJbvAEngh62rmlCF203idFT17WOAarjcM8Rdpiq3RsgICfmziX3gGXumAASMVPu9YyZkjBesurW1Za5NNjcLilPTa/P9G9roSsWM0DvfpFqrAjwfKNYz261gYgFGSeBMhbD1agit4xPMBh+on41+N7SddvUvvgZmIpaq8io6KQvHbsVeRqXAe4Gx7b1fVoOdreft9GLa8RoPEnHLbFUSF1y6DlZnp8psmGpkDG6JC8SZbvPO+vyt4vjXh3iEwjnxju/usBpSkYgJl42eHRQMqUhJLDmw1uuwY5vscyQQqpaOmBpjxORHqFnWvNMvfDTWiU+7oJ7HKugwGexrqP93XDnXNWtyG2Vl1AK2XKK0R84ui9yF2Yx8EuSVSC4yQSu/2oP/shS3jGl9nMa0a/oqcVeiDJyQb5eeZ7Zb+ahwydRgdqpfXbP8Ef4EbD7lbTU11OPr6ViVrYLpb3uNz2NY4vcEqCHRs1pEkOYGg/b4/wn+dr8soRfYLUxo+1KKMZWNDd5w2TmKurQJQjNXxLJoOo9bQD7y5I8TPyMR7/kAvPmzuw/9ih8fQzZtnMImwfB/4v/V0qqSemnXE8TUx1d/MmR566rtnKt7VjXZ0uHE60WltIodA6ms2I5WeFxRgOZShhjAFIUof+kHIHnEvvdS8Rq3CYqSzjU9QVgapr8OBSjPp1jWqJ56c9O3/WJQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(396003)(136003)(366004)(39860400002)(186003)(4326008)(956004)(6916009)(478600001)(36756003)(5660300002)(52116002)(7696005)(6486002)(1076003)(6666004)(2616005)(2906002)(8936002)(38350700002)(38100700002)(66946007)(316002)(66476007)(66556008)(26005)(54906003)(83380400001)(8676002)(86362001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ymL5KIxzmRCcCf54Mh9yae/KztaL+JTklxHLrxpe7QDUy4D7sgXChVyzoyrE?=
 =?us-ascii?Q?gx1UWBjKAODL/2lPo7kJzvWGBxiarCRl2nu8wd4GCL8xIq8CC4k8H0+BTyFF?=
 =?us-ascii?Q?QGqtmsYGOJCuz7DbZqCHT+o/TzR7r8HBPVDddeAM9+LrIYtDonHwEip0H8mp?=
 =?us-ascii?Q?RiNCQZSejY5zmYZG+D86GepzVF84W/i5/HLnhm3VQBm/hy6wjIfAsgU2+YH+?=
 =?us-ascii?Q?XSJVvQsVbBIZPpvqt+7i5t09TGPHmM+E01DrwZ1PPUjRfp7k8Ob8KKZqhkJ0?=
 =?us-ascii?Q?yPXhX0VV9A8Pzuguniq/+7T2m89jOqkjMiLMlz5tF4OB9UdxnR2e7WG/02/E?=
 =?us-ascii?Q?7UIW0UzQhATy9sd5vY3+JQn0l1viNf4B38QnNaVTqa3P+/f+U/FyQUegdl3O?=
 =?us-ascii?Q?7TlEPf9r/Nx+MsZ0uZmy1xzHrEJ182KZ35VTY2RsVFHjNo4nRKS2R1IpjWlV?=
 =?us-ascii?Q?ww5z60M+kiRQqOHF/PO45x5vawj1rOzKTbqIBQoosbKh7rQ1//WCiXDRnObY?=
 =?us-ascii?Q?bpo3sddH0/tVx1eVMX/0FkuuAlFFZzJcRYWdooMYbpwfEK6TuvQdXTIceRqy?=
 =?us-ascii?Q?hwpqN9WuZy7EcYEUCx9/yEnUt+u6vPp0UeqBW/IU+t/qj0wjPknspPzjAyaw?=
 =?us-ascii?Q?/YXp+FNhHFC2ysESokCjyG5VTf+nVoOEKiSNShHLUmGUNCc8othSuW5GYEKK?=
 =?us-ascii?Q?P1nyt+r3VLffI2FHGxFbpJ59BUWLpISrNEnZ7d68hCe/bZzfRdpIdtkKLinf?=
 =?us-ascii?Q?+RVQ5/Yuo5/kDi9QSchIidxE3QQG5JDd8WN7w69P7T4/VEBEhsMu7y6AosRU?=
 =?us-ascii?Q?gMg4tOI54JlucxdZkeLwh08ZNm7B8dtgJo8RUm13RlKqgc6TzFn7lyLKh8cw?=
 =?us-ascii?Q?4cPJdIj0mioLfpUOQWfeAg7xmru7iaUr93x3Hlx/iD6poCeP6HkLKFmy6PwA?=
 =?us-ascii?Q?wWLzfCa4m+72Dfr9VgExkxdF3X+h0OK/GL2RZfHprAGh6whG23ExGh4k3zOS?=
 =?us-ascii?Q?bby8xQY4g/J5JrhHahdzDDeIQJWnkHMGcRWrWzho1xHia2Sh09L0j6IFAfnR?=
 =?us-ascii?Q?encT7FYwo+YrWFStu55yjKPhrMEmDEdkLOy4Z6DuJQ2VbspeljKVDQ1n/bJI?=
 =?us-ascii?Q?uagvVAy3jMELSQYwjZy+toFNlACw5j/TXjImj4J/05//FY9JHMO8xPG1hn7Y?=
 =?us-ascii?Q?83qIS7Zy46qU7+8bQqAenOPZ5dZnKOjIKPa9J6psN2ZZdcEftLGI1UPJNSko?=
 =?us-ascii?Q?SG/nque2p/0EgAcEOxDXdWcqcbSdOOppg2q8rd4/BF+zIfsFfHQbL4TEtXaa?=
 =?us-ascii?Q?TIzdAJIAY4pSazueS0DnUxRQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9e0dd8f-19d5-4e04-97b7-08d94b954131
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2021 15:44:26.8164 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bhT5EvJESqcxQ8xKiRJTJRntquy7y8qLXLJMbYAtDEYTErkB1sNAv43sdENYnzqD5PfHq+G8VKVk/3i4TasbTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5538
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Lang Yu <Lang.Yu@amd.com>

Add basic ppt funcs support or cyan_skilfish.

Signed-off-by: Lang Yu <Lang.Yu@amd.com>
Reviewed-by: Huang Rui <ray.huang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/Makefile   |  1 +
 .../amd/pm/swsmu/smu11/cyan_skillfish_ppt.c   | 75 +++++++++++++++++++
 .../amd/pm/swsmu/smu11/cyan_skillfish_ppt.h   | 29 +++++++
 3 files changed, 105 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c
 create mode 100644 drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.h

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/Makefile b/drivers/gpu/drm/amd/pm/swsmu/smu11/Makefile
index 0138c982dfd3..f9b2e16f6431 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/Makefile
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/Makefile
@@ -27,6 +27,7 @@ SMU11_MGR = arcturus_ppt.o \
 	    navi10_ppt.o \
 	    sienna_cichlid_ppt.o \
 	    vangogh_ppt.o \
+	    cyan_skillfish_ppt.o \
 	    smu_v11_0.o
 
 AMD_SWSMU_SMU11MGR = $(addprefix $(AMD_SWSMU_PATH)/smu11/,$(SMU11_MGR))
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c
new file mode 100644
index 000000000000..4fbffc14021c
--- /dev/null
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c
@@ -0,0 +1,75 @@
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
+ */
+
+#define SWSMU_CODE_LAYER_L2
+
+#include "amdgpu.h"
+#include "amdgpu_smu.h"
+#include "smu_v11_0.h"
+#include "smu11_driver_if_cyan_skillfish.h"
+#include "cyan_skillfish_ppt.h"
+#include "smu_v11_8_ppsmc.h"
+#include "smu_v11_8_pmfw.h"
+#include "smu_cmn.h"
+#include "soc15_common.h"
+
+/*
+ * DO NOT use these for err/warn/info/debug messages.
+ * Use dev_err, dev_warn, dev_info and dev_dbg instead.
+ * They are more MGPU friendly.
+ */
+
+#undef pr_err
+#undef pr_warn
+#undef pr_info
+#undef pr_debug
+
+static struct cmn2asic_msg_mapping cyan_skillfish_message_map[SMU_MSG_MAX_COUNT] = {
+	MSG_MAP(TestMessage,                    PPSMC_MSG_TestMessage,			0),
+	MSG_MAP(GetSmuVersion,                  PPSMC_MSG_GetSmuVersion,		0),
+	MSG_MAP(GetDriverIfVersion,             PPSMC_MSG_GetDriverIfVersion,		0),
+	MSG_MAP(SetDriverDramAddrHigh,          PPSMC_MSG_SetDriverTableDramAddrHigh,	0),
+	MSG_MAP(SetDriverDramAddrLow,           PPSMC_MSG_SetDriverTableDramAddrLow,	0),
+	MSG_MAP(TransferTableSmu2Dram,          PPSMC_MSG_TransferTableSmu2Dram,	0),
+	MSG_MAP(TransferTableDram2Smu,          PPSMC_MSG_TransferTableDram2Smu,	0),
+};
+
+static const struct pptable_funcs cyan_skillfish_ppt_funcs = {
+
+	.check_fw_status = smu_v11_0_check_fw_status,
+	.init_power = smu_v11_0_init_power,
+	.fini_power = smu_v11_0_fini_power,
+	.register_irq_handler = smu_v11_0_register_irq_handler,
+	.notify_memory_pool_location = smu_v11_0_notify_memory_pool_location,
+	.send_smc_msg_with_param = smu_cmn_send_smc_msg_with_param,
+	.send_smc_msg = smu_cmn_send_smc_msg,
+	.set_driver_table_location = smu_v11_0_set_driver_table_location,
+	.interrupt_work = smu_v11_0_interrupt_work,
+};
+
+void cyan_skillfish_set_ppt_funcs(struct smu_context *smu)
+{
+	smu->ppt_funcs = &cyan_skillfish_ppt_funcs;
+	smu->message_map = cyan_skillfish_message_map;
+	smu->is_apu = true;
+}
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.h b/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.h
new file mode 100644
index 000000000000..76cd7229e383
--- /dev/null
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.h
@@ -0,0 +1,29 @@
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
+ */
+
+#ifndef __CYAN_SKILLFISH_PPT_H__
+#define __CYAN_SKILLFISH_PPT_H__
+
+extern void cyan_skillfish_set_ppt_funcs(struct smu_context *smu);
+
+#endif
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
