Return-Path: <SRS0=QW4G=K4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B37C7C4709A
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 16:49:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F76361C2E
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 16:49:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F76361C2E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A69506ED93;
	Wed,  2 Jun 2021 16:49:48 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2071.outbound.protection.outlook.com [40.107.220.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA1B46ED1A
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Jun 2021 16:49:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L5WCT0dz1CI+QoiAyYWpNWRUipy+uKZ/Du1GwNnohSYDsNS1G6AZCesLa47icaaQaPEyJlv5niJbTG/sUdvqO3MBEWxmIOJtDVyoKlsIgkOqwX+7ioTcNlU7if6B/+ASP5EXe9VtnO3XQLv053hopDFgtUau7+AXdYMfI6LHd67rtoGbIBWLcXXBQCLKODqalyTr3/mjdsI55nrKajJbqeRQ+Mqic2uiHAfrwDyzssZsnAYsy0eju52YakIQNLq7dlqm+8jo6YxLNAalTGlzF+MnVVrX9z9SsZSqBmNG/FYPLAfe269b54IxVYR39Zp/JtjKpWFcByEtp1gFxRG2Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+4oinhi52japCA+raRkdQ11om6+nYiffIKBiH1rJ+kw=;
 b=auZsr83qZthvgx30lLvoFMvzt7u9qs78bW8p2sgGyhv/4WTJpheD2yKCYX4lZnGJIZK3Gpg4a+RsqMy8ldeA6VL5/+1MM1K1TMuycZnSsxYR8iuL8/wpJZiB5btfP4Qzg6QOETXAwdtvqP7szq81HJpeCgicCafH7Cq94DZiHyYHrS6351/FggyoSKehwbdVmfxnlRGHKEY7+6hCUWPN+X2NtfHNvbb35NVEMsnugb6tUaPNjtOypidF3oPp8DPpsz2ISVt2CFM7V+BTyC0+wuNS3P9MnJtqKdkUGQDTJ9ikHJwP5Atxzw97DPkhyNU1/dAy7/zb3iHSqDqfVEHwiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+4oinhi52japCA+raRkdQ11om6+nYiffIKBiH1rJ+kw=;
 b=zdqXzAmC8uQjU0U8kKFaYgQ1n4iFaPRDY0UX6wZQZ+q3QNQC2KvurB9XEd5wxadC9Bxm0Bw8rfPjrDyTAcmVhewrHj+qpXT5oAG6WZ7oljx+6YUNSM4esjZz/NTqDG8lL5DZyXLb4urMNMDooRCw0H/FitNP2cXsTwxMWyYWN4A=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4077.namprd12.prod.outlook.com (2603:10b6:208:1da::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.21; Wed, 2 Jun
 2021 16:49:40 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::25f7:664:3a8f:25b6]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::25f7:664:3a8f:25b6%7]) with mapi id 15.20.4173.030; Wed, 2 Jun 2021
 16:49:40 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 18/89] drm/amd/pm: add smu13 ip support for moment(V3)
Date: Wed,  2 Jun 2021 12:47:57 -0400
Message-Id: <20210602164908.2848791-18-alexander.deucher@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 3e6bb729-7f05-43e4-d8dc-08d925e66a29
X-MS-TrafficTypeDiagnostic: MN2PR12MB4077:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4077B5761EF1559ABFEB32ABF73D9@MN2PR12MB4077.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lUbzRJab6cmXYwjdZ7V1vBax8/vc4zdYZHDFAhpfSpQVw+ZD6xRgFbw5YQHkD2yg06TmXVpeOd/6P2icrJ3Ir/4ND2OPC7gZ9nV6jGatbZWYI+bscUDHy82I4lY1ophnU6u7HWqpQbpniOelI+ajdZqeUOpErJNrTk2L+jiC/bUxjhB4k/nZtWnIf6+ipn6TsW/WCXfkhzu5Md29y/lxExO11rK/z2mlpKLhLHgI6hKJplyxAz8iNFfT+CgBCdD+e8xrH74Ui2k0uKzaQU3Nb7wPFYk6KD8/BkaVp+Fm/CpYPpVfGI6P0SU+YRmPhi2BG/CA7g+7EoxEEv5U3+0XdHLG+DCxIUrfJvS3/WbgCZu5HWoCKb13m4KmxL2SQlN3Lq+ziiP9i5M0/VHPZWKAlaQ1bOWExeiPP/ccZQsLgVNUV+4UsGHmRQX++BZTW3B5Y3VAZKngWHb8sKJ9GPc08lM8OJQ7qINZhRLPUXOY5g70/XUI7I37JEYvzg3BAm5GNcqSs28i8+fK4f3uEsWnV8hFp6uOlhX/T/awrgJh//bypDuqovqRqte4qpY8uAMlfMNJAjehYkq62NCWaD/NxXaij6IGwJRqyy65TCm4dzx5Z2X+k5x3w2D54WZ+2T/LSzmtBl0waUjKld+OI/dpbQoTOvm3F6jH5dDqX25VxR+u7u/VngwdcJVkqIJkqGu0
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(376002)(346002)(396003)(39850400004)(8676002)(54906003)(4326008)(5660300002)(8936002)(6666004)(478600001)(316002)(83380400001)(16526019)(1076003)(6506007)(956004)(2616005)(52116002)(66946007)(26005)(66476007)(66556008)(2906002)(6916009)(38100700002)(38350700002)(36756003)(86362001)(6512007)(186003)(6486002)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?PF0CUk2p1tufUajlKH7D9LqO9Qd08eWCnJbDXhXQLKZoeMFhkBpay9H0pB66?=
 =?us-ascii?Q?BY+6z0Glqq3dtzvO26UCXWTMeUJjaLbI7JU/hRjC0Qq/Idudz1GgtyCZNJl4?=
 =?us-ascii?Q?wDLYu98e3ef2U0sX7cnq3KCSueDWzv+FJuxYzzf8+vSXf0TN2ap092Cz16I6?=
 =?us-ascii?Q?kGInqDnnJRDMClrWZifi8jzX5KTS8LwuKbnE5Q+6N53xzN7ZBxuMI1Y5JY6i?=
 =?us-ascii?Q?qB/n8LzWW0okaIhKhipS2QYEu5DMLhk0OgHCTz9jDeQF0tYXj7C99zjzWepu?=
 =?us-ascii?Q?2HcEc1OuiuDE/2doWtGx7u6IQAten/ob9vZ5L9fPSwY3HlY2Yq+BcL4+HDQ9?=
 =?us-ascii?Q?3ewfXcVgJvCrBnDhww41b7UA0WasX+CjX8TkMCtlPJ3UvqOmaWz0Zojf6m5E?=
 =?us-ascii?Q?OXlS73PFUH7Fo8F6fhnDQMjBBGfHFsymtFmd/sR7HxSQFEkOP4VDnqg3s9Zr?=
 =?us-ascii?Q?GNfQsFh6/tGZdMymdcyxPNr8EHYTepbHvqrDzSP13rYbOKrt5/BGA4t+3UFs?=
 =?us-ascii?Q?lrBaQHhZmWiHsbofW1ZdE+b3rydSY8Xsf9WG2lhExvX1GD/e6PAdqgq2A95g?=
 =?us-ascii?Q?7insUA02A04xDLP597aobKCeBRlk0az2qWrIbP9FOEgjC68vv5p9heKKWGfG?=
 =?us-ascii?Q?C6s77lD/Cq1HkTg6ab2yZPuiNu9g391Yf1DGem+ST1uIEwXD3i9X6nnQsVfY?=
 =?us-ascii?Q?STC2L0DT3icCNj6x6RYgBEunuo3HEMohf2juHvTkzjgdhOlUYPERdbxDRBtc?=
 =?us-ascii?Q?unD0+5i0auWv4WcfQzwoJG3XGiDJzmLXh1kacNszlSOgrN8c3raSODBpY+TO?=
 =?us-ascii?Q?KaV4WD9l4BARKP6IMSBLoYoECRJYW4Ji6CY815RQJPriNw3z+s6tOCP3MoDX?=
 =?us-ascii?Q?qXDfsDwbKZN3VryR0UWUQ1Zompgm2w/KARSK/M29kXp3eiYSeTZ5bCbyWxiS?=
 =?us-ascii?Q?IH0dOjB9YHJcJaSHDgVgJYAvTQ6EgvB4vLH0HkfUvv4JU6dpU3P0MufctLvU?=
 =?us-ascii?Q?ZD1UPX20/3Z+miPrbEkmbg1QYe5bo22Oh7LQF6/HrCiDxLVprclIRBcvr3ld?=
 =?us-ascii?Q?dxQcdSdzkH2t10kgYgzejwiRiTDiBp04+hQbpFJUcj43nBpbwD3hXeMcwrJ5?=
 =?us-ascii?Q?oWWmKlCQCT3gz2Jq8PoeotM0phRLM2UoTADBlfW6URbr3aUb8YdPG8FCnlML?=
 =?us-ascii?Q?85C1WyWkV+E4i1U6I6D/5iw7SqpRYbq+mx1rAmIN1ZV8g9DMNbAv2d495wZZ?=
 =?us-ascii?Q?pzIDkTG2uDhlHx1PWrQN5/U2dup3IyqRRkuH3bzskLM8ijmCZ1dG9yl2NzBh?=
 =?us-ascii?Q?z6D7MV31C6M2YFLLIUexxfkx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e6bb729-7f05-43e4-d8dc-08d925e66a29
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2021 16:49:40.6286 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xjNCJBAAHCWYSqVG/3RWsmBECGQ7t9DHPCRkOCs7Y1AhG5A+sIJToctsg4BPDkiQKTAy5qVoop49G46LfFlCaw==
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

For supporting yellow carp, we need to add smu13 ip
support for the moment.

V2: add smu_v13_0_1.c|h dedicated for apu.
V3: cleanup code.

Signed-off-by: Aaron Liu <aaron.liu@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Huang Rui <ray.huang@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h       |   1 +
 drivers/gpu/drm/amd/pm/inc/smu_v13_0_1.h      |  52 +++++++
 drivers/gpu/drm/amd/pm/swsmu/smu13/Makefile   |   2 +-
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_1.c  | 131 ++++++++++++++++++
 4 files changed, 185 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/amd/pm/inc/smu_v13_0_1.h
 create mode 100644 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_1.c

diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
index 71adb9e76a95..bc55af477d1c 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
@@ -1275,6 +1275,7 @@ extern const struct amd_ip_funcs smu_ip_funcs;
 extern const struct amdgpu_ip_block_version smu_v11_0_ip_block;
 extern const struct amdgpu_ip_block_version smu_v12_0_ip_block;
 extern const struct amdgpu_ip_block_version smu_v13_0_ip_block;
+extern const struct amdgpu_ip_block_version smu_v13_0_1_ip_block;
 
 bool is_support_sw_smu(struct amdgpu_device *adev);
 bool is_support_cclk_dpm(struct amdgpu_device *adev);
diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v13_0_1.h b/drivers/gpu/drm/amd/pm/inc/smu_v13_0_1.h
new file mode 100644
index 000000000000..b2e9258dc06c
--- /dev/null
+++ b/drivers/gpu/drm/amd/pm/inc/smu_v13_0_1.h
@@ -0,0 +1,52 @@
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
+#ifndef __SMU_V13_0_1_H__
+#define __SMU_V13_0_1_H__
+
+#include "amdgpu_smu.h"
+
+#define SMU13_0_1_DRIVER_IF_VERSION_INV 0xFFFFFFFF
+#define SMU13_0_1_DRIVER_IF_VERSION_YELLOW_CARP 0x3
+
+/* MP Apertures */
+#define MP0_Public			0x03800000
+#define MP0_SRAM			0x03900000
+#define MP1_Public			0x03b00000
+#define MP1_SRAM			0x03c00004
+
+/* address block */
+#define smnMP1_FIRMWARE_FLAGS		0x3010024
+
+
+#if defined(SWSMU_CODE_LAYER_L2) || defined(SWSMU_CODE_LAYER_L3)
+
+int smu_v13_0_1_check_fw_status(struct smu_context *smu);
+
+int smu_v13_0_1_check_fw_version(struct smu_context *smu);
+
+int smu_v13_0_1_fini_smc_tables(struct smu_context *smu);
+
+int smu_v13_0_1_set_default_dpm_tables(struct smu_context *smu);
+
+#endif
+#endif
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/Makefile b/drivers/gpu/drm/amd/pm/swsmu/smu13/Makefile
index 652b4e554378..0fb3ddc251e4 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/Makefile
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/Makefile
@@ -23,7 +23,7 @@
 # Makefile for the 'smu manager' sub-component of powerplay.
 # It provides the smu management services for the driver.
 
-SMU13_MGR = smu_v13_0.o aldebaran_ppt.o
+SMU13_MGR = smu_v13_0.o aldebaran_ppt.o smu_v13_0_1.o
 
 AMD_SWSMU_SMU13MGR = $(addprefix $(AMD_SWSMU_PATH)/smu13/,$(SMU13_MGR))
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_1.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_1.c
new file mode 100644
index 000000000000..6ad2fcb2af2f
--- /dev/null
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_1.c
@@ -0,0 +1,131 @@
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
+ */
+
+//#include <linux/reboot.h>
+
+#define SWSMU_CODE_LAYER_L3
+
+#include "amdgpu.h"
+#include "amdgpu_smu.h"
+#include "smu_v13_0_1.h"
+#include "soc15_common.h"
+#include "smu_cmn.h"
+
+#include "asic_reg/mp/mp_13_0_1_offset.h"
+#include "asic_reg/mp/mp_13_0_1_sh_mask.h"
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
+int smu_v13_0_1_check_fw_status(struct smu_context *smu)
+{
+	struct amdgpu_device *adev = smu->adev;
+	uint32_t mp1_fw_flags;
+
+	mp1_fw_flags = RREG32_PCIE(MP1_Public |
+				   (smnMP1_FIRMWARE_FLAGS & 0xffffffff));
+
+	if ((mp1_fw_flags & MP1_FIRMWARE_FLAGS__INTERRUPTS_ENABLED_MASK) >>
+	    MP1_FIRMWARE_FLAGS__INTERRUPTS_ENABLED__SHIFT)
+		return 0;
+
+	return -EIO;
+}
+
+int smu_v13_0_1_check_fw_version(struct smu_context *smu)
+{
+	uint32_t if_version = 0xff, smu_version = 0xff;
+	uint16_t smu_major;
+	uint8_t smu_minor, smu_debug;
+	int ret = 0;
+
+	ret = smu_cmn_get_smc_version(smu, &if_version, &smu_version);
+	if (ret)
+		return ret;
+
+	smu_major = (smu_version >> 16) & 0xffff;
+	smu_minor = (smu_version >> 8) & 0xff;
+	smu_debug = (smu_version >> 0) & 0xff;
+
+	switch (smu->adev->asic_type) {
+	case CHIP_YELLOW_CARP:
+		smu->smc_driver_if_version = SMU13_0_1_DRIVER_IF_VERSION_YELLOW_CARP;
+		break;
+
+	default:
+		dev_err(smu->adev->dev, "smu unsupported asic type:%d.\n", smu->adev->asic_type);
+		smu->smc_driver_if_version = SMU13_0_1_DRIVER_IF_VERSION_INV;
+		break;
+	}
+
+	dev_info(smu->adev->dev, "smu fw reported version = 0x%08x (%d.%d.%d)\n",
+			 smu_version, smu_major, smu_minor, smu_debug);
+
+	/*
+	 * 1. if_version mismatch is not critical as our fw is designed
+	 * to be backward compatible.
+	 * 2. New fw usually brings some optimizations. But that's visible
+	 * only on the paired driver.
+	 * Considering above, we just leave user a warning message instead
+	 * of halt driver loading.
+	 */
+	if (if_version != smu->smc_driver_if_version) {
+		dev_info(smu->adev->dev, "smu driver if version = 0x%08x, smu fw if version = 0x%08x, "
+			 "smu fw version = 0x%08x (%d.%d.%d)\n",
+			 smu->smc_driver_if_version, if_version,
+			 smu_version, smu_major, smu_minor, smu_debug);
+		dev_warn(smu->adev->dev, "SMU driver if version not matched\n");
+	}
+
+	return ret;
+}
+
+int smu_v13_0_1_fini_smc_tables(struct smu_context *smu)
+{
+	struct smu_table_context *smu_table = &smu->smu_table;
+
+	kfree(smu_table->clocks_table);
+	smu_table->clocks_table = NULL;
+
+	kfree(smu_table->metrics_table);
+	smu_table->metrics_table = NULL;
+
+	kfree(smu_table->watermarks_table);
+	smu_table->watermarks_table = NULL;
+
+	return 0;
+}
+
+int smu_v13_0_1_set_default_dpm_tables(struct smu_context *smu)
+{
+	struct smu_table_context *smu_table = &smu->smu_table;
+
+	return smu_cmn_update_table(smu, SMU_TABLE_DPMCLOCKS, 0, smu_table->clocks_table, false);
+}
+
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
