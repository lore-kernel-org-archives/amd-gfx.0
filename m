Return-Path: <SRS0=uNpP=FM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAA36C4361B
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Dec 2020 06:21:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71C7723A63
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Dec 2020 06:21:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71C7723A63
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E0F486E94A;
	Tue,  8 Dec 2020 06:21:36 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2061.outbound.protection.outlook.com [40.107.220.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D5306E94A
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Dec 2020 06:21:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O3W7H/wczKVueoLaRkt9smKkWX+ZvgNX5I1OpJbMjBSuICiYVUbDlso2NvBqfccYfwj7JgjXSH/iaNb869TFFK6wA8ZBD5bhLw336snjdHMpS9Uaxb32rusuSUwGYtnDPHwLpOTv+I9ONP0tAvKfYoXai1ERelrctIQrL+6Mc4BVofWxGo0XBOzL8vOMm/WQUyr3qUbC2oGTc2VO/M3heillVUcSIdyz49tdrtf8fyZS4xDPX1i4f1jrby7MjkDZW2PuYzKsv4vNpi7WZIay6TIaY3KgoyZBUhfibkLA2iKfqBrSVubw6Ld/5jsjrQQnnsIPisL9NFRyFFHktLiN+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4U9FV6DGg3LObpn/T3R8nYByfDDBeU9ZCW4YZo8n3R4=;
 b=nHZkcr7k5ZKEJAU8mwdvYHs5kjefHSrqTmBVobUJMXvPHSWeI1kAb+pe2ANXTy++qbXOoBUHSQ/C+oHNJch/MvDQKDgrf5vGxXkCb1aHGyGS5RQ/cPF1ZbUTNvOBqyyjtDn2cHY0s8gBuK9I0pFh3Fo7yvVefaWlUQxFWGiXFEaWsTeuOaV5JDsxMuXfrhRD8kBdojfnolY8py3y7bRqA7WUH9v3GLuUFWJbMregm5pE2fZcJRiSj1atEyye82nL1HunhFNcVbpPrmsbfFqbE2+EEDrWIR+qtNvBXtaiSOA2A7ynv1ZnGlef8YpJajt/5Lvj/qTpbx3D8LiJPze+wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4U9FV6DGg3LObpn/T3R8nYByfDDBeU9ZCW4YZo8n3R4=;
 b=paHekM1cKrf6/r2OOojxwoQHFoMs8Edm1SdYRp5JLZ+l/7I7UOZs+Gk6yUvcET9leKU+F7QsoCElklXiFP4kaUNjIT/caG1+adWKi7CGa36mdjDswiKg5lqVdZVkMq4iXNZqa1D7+OaW+EcBJbNjO3wXGlzhlVjtv+oaCJfDoe0=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4940.namprd12.prod.outlook.com (2603:10b6:610:65::10)
 by CH2PR12MB4971.namprd12.prod.outlook.com (2603:10b6:610:6b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12; Tue, 8 Dec
 2020 06:21:28 +0000
Received: from CH2PR12MB4940.namprd12.prod.outlook.com
 ([fe80::350b:2673:2db7:8696]) by CH2PR12MB4940.namprd12.prod.outlook.com
 ([fe80::350b:2673:2db7:8696%9]) with mapi id 15.20.3632.021; Tue, 8 Dec 2020
 06:21:28 +0000
From: Aaron Liu <aaron.liu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 5/8] drm/amd/pm: add smu13 ip support for moment(V3)
Date: Tue,  8 Dec 2020 14:21:11 +0800
Message-Id: <20201208062111.23346-1-aaron.liu@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [180.167.199.189]
X-ClientProxiedBy: HK2PR0302CA0004.apcprd03.prod.outlook.com
 (2603:1096:202::14) To CH2PR12MB4940.namprd12.prod.outlook.com
 (2603:10b6:610:65::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from aaliu.amd.com (180.167.199.189) by
 HK2PR0302CA0004.apcprd03.prod.outlook.com (2603:1096:202::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3654.7 via Frontend Transport; Tue, 8 Dec 2020 06:21:26 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5288f8b1-1e50-4034-bb50-08d89b417f49
X-MS-TrafficTypeDiagnostic: CH2PR12MB4971:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB4971DF3F9757142739898402F0CD0@CH2PR12MB4971.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YGqJ6HSU4mZqFrmM5my0kCLAwtnorEVXifUETDMmTmC26KHcZy5oURxgDO7abzLrRf33Qz5tF/CLsDlnkPV126azTvokojVmW1jaqKbLlFJUrMXLdWygOwQSwJWxN2KV8QGT0Nsc4jYPnU/Mn12VjjAIpJAD6pxkq9wbNs5O02b8HDpz1oZou/cr9zjFxzkapnasWZOuZFRN926J2IpJkcRIzIDqg3xRB4o2OjEg2Bcj5ZHeUl3mkgP0RlWTCpzbg76moIj4OcNaCTgHc0Xa1Eoa/aBdR0vIzHOEDbskYWirfParLEcPjIl5CHlCJDj9Lzv6iMa8hZMv4/38+m0U5w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4940.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39860400002)(346002)(136003)(376002)(396003)(7696005)(1076003)(26005)(6666004)(8936002)(186003)(2616005)(66476007)(66946007)(66556008)(86362001)(6916009)(5660300002)(16526019)(30864003)(52116002)(6486002)(36756003)(8676002)(956004)(316002)(4326008)(83380400001)(2906002)(478600001)(44832011);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?kLwv4CMpYIke8nyOWbWWUJXV00gOMGRkBgEUUra81cyVo+XlG/TlO3fJmT2L?=
 =?us-ascii?Q?9AkP0gLf3KlkkYSxONJBPa30DHFBIH65zVrOF65f9DIoYfF+yVMwJcX2HxlB?=
 =?us-ascii?Q?PGqz7Tj6R/ZWYWDRxAE8JF7szOh8ldVFXlwNSH4H6zFmFkiTEGpEpMu57Pdd?=
 =?us-ascii?Q?DRKetdyR2Nok6tHof0HK+5H/fJKG4vlVLi2uIKR/yAwyuhS9TmZ7+bzhECou?=
 =?us-ascii?Q?lmCMTPiuxh08/sUdmvVJvOi8sxhnJ08NFIiCdXDNXYcRDzOVdHe9HWLar8G1?=
 =?us-ascii?Q?DklHCDAajD0qi++GTJzRsViCXHBLpeEVMOmXjnMcEDlEeWYqTzjh0PDDwoTh?=
 =?us-ascii?Q?Dr2Sbf3FNNUL1hxrN8fYsNHYOS6Dm4a0AouIDipOJZVjilVJeUZqEUK48B1E?=
 =?us-ascii?Q?4n+ogrtX9AT2Cs720lsvP7M+aWud2XI+8t3X5a2EsbrjnxJMKtxeOmE9TsJD?=
 =?us-ascii?Q?Me4P8OvdQGRinS/arAEMbYcyb+DtJ3k9OM1t3IIGodxJchB/4NdEuXXSYEzf?=
 =?us-ascii?Q?9YYfQ6JG6mafhcU9B0pyX59VO1NfYgx0Vk+n1Z2D/5ZrqZpO733M+F1kIhxF?=
 =?us-ascii?Q?aF7qN9Y2JzVcPmGTq1YTRu1KZUXptI6DW81EQCWb4diDr/pz75vRsaUejQxc?=
 =?us-ascii?Q?jc8ybaJpD2xjznniWGznthjQl6hIsw0GVPPFhRIZBym43Joo/8gZYw68qpd6?=
 =?us-ascii?Q?aYTsTl/TkAznTyCOLEDYRiEI1qU8sN0jrsecYIDSgGyWUs2IZO3tBBg4AirT?=
 =?us-ascii?Q?KTTFGW+u5z7ZcvzIGelbZjAXE+BXT+rxCTnBLbAVBy43H019atRXj3Y9Fvq9?=
 =?us-ascii?Q?EFztPIkYfR95bkR62QY6krFOd8lKk/531f8bn5t315Yqi9AcpVZLZ2spblzF?=
 =?us-ascii?Q?ZMBX8JVup57r8RmnxqLxVUdxCRTCEtCgCSwh9GZq9TnErpGACkDxWVR6J7H9?=
 =?us-ascii?Q?0yrRSayz4+P1X8e3FaymJMHDTPP5Eq0ia3hIMOrNXiIxm6XBQLabMJ/TOj+S?=
 =?us-ascii?Q?8vwG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4940.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2020 06:21:28.2896 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: 5288f8b1-1e50-4034-bb50-08d89b417f49
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L2YLh107OZECKZ10Tmjnte71nd8O7SN2AZV7WX0NukqCsBn1wsquRsZAP7Jq44gQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4971
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

For supporting yellow carp, we need to add smu13 ip
support for the moment.

V2: add smu_v13_0_1.c|h dedicated for apu.
V3: cleanup code.

Signed-off-by: Aaron Liu <aaron.liu@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Huang Rui <ray.huang@amd.com>
---
 drivers/gpu/drm/amd/pm/Makefile               |   1 +
 drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h       |   1 +
 drivers/gpu/drm/amd/pm/inc/smu_v13_0_1.h      |  52 +++++++
 drivers/gpu/drm/amd/pm/swsmu/Makefile         |   2 +-
 drivers/gpu/drm/amd/pm/swsmu/smu13/Makefile   |  30 ++++
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_1.c  | 131 ++++++++++++++++++
 6 files changed, 216 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/amd/pm/inc/smu_v13_0_1.h
 create mode 100644 drivers/gpu/drm/amd/pm/swsmu/smu13/Makefile
 create mode 100644 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_1.c

diff --git a/drivers/gpu/drm/amd/pm/Makefile b/drivers/gpu/drm/amd/pm/Makefile
index f01e86030cd1..8cf6eff1ea93 100644
--- a/drivers/gpu/drm/amd/pm/Makefile
+++ b/drivers/gpu/drm/amd/pm/Makefile
@@ -27,6 +27,7 @@ subdir-ccflags-y += \
 		-I$(FULL_AMD_PATH)/pm/swsmu \
 		-I$(FULL_AMD_PATH)/pm/swsmu/smu11 \
 		-I$(FULL_AMD_PATH)/pm/swsmu/smu12 \
+		-I$(FULL_AMD_PATH)/pm/swsmu/smu13 \
 		-I$(FULL_AMD_PATH)/pm/powerplay \
 		-I$(FULL_AMD_PATH)/pm/powerplay/smumgr\
 		-I$(FULL_AMD_PATH)/pm/powerplay/hwmgr
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
index 9724d6fd82f4..7c49b046c6fa 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
@@ -706,6 +706,7 @@ extern const struct amd_ip_funcs smu_ip_funcs;
 
 extern const struct amdgpu_ip_block_version smu_v11_0_ip_block;
 extern const struct amdgpu_ip_block_version smu_v12_0_ip_block;
+extern const struct amdgpu_ip_block_version smu_v13_0_1_ip_block;
 
 bool is_support_sw_smu(struct amdgpu_device *adev);
 int smu_reset(struct smu_context *smu);
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
diff --git a/drivers/gpu/drm/amd/pm/swsmu/Makefile b/drivers/gpu/drm/amd/pm/swsmu/Makefile
index 6f281990b7b4..7987c6cf849d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/Makefile
+++ b/drivers/gpu/drm/amd/pm/swsmu/Makefile
@@ -22,7 +22,7 @@
 
 AMD_SWSMU_PATH = ../pm/swsmu
 
-SWSMU_LIBS = smu11 smu12
+SWSMU_LIBS = smu11 smu12 smu13
 
 AMD_SWSMU = $(addsuffix /Makefile,$(addprefix $(FULL_AMD_PATH)/pm/swsmu/,$(SWSMU_LIBS)))
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/Makefile b/drivers/gpu/drm/amd/pm/swsmu/smu13/Makefile
new file mode 100644
index 000000000000..61ac864ac948
--- /dev/null
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/Makefile
@@ -0,0 +1,30 @@
+#
+# Copyright 2020 Advanced Micro Devices, Inc.
+#
+# Permission is hereby granted, free of charge, to any person obtaining a
+# copy of this software and associated documentation files (the "Software"),
+# to deal in the Software without restriction, including without limitation
+# the rights to use, copy, modify, merge, publish, distribute, sublicense,
+# and/or sell copies of the Software, and to permit persons to whom the
+# Software is furnished to do so, subject to the following conditions:
+#
+# The above copyright notice and this permission notice shall be included in
+# all copies or substantial portions of the Software.
+#
+# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+# THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+# OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+# ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+# OTHER DEALINGS IN THE SOFTWARE.
+#
+#
+# Makefile for the 'smu manager' sub-component of powerplay.
+# It provides the smu management services for the driver.
+
+SMU13_MGR = smu_v13_0_1.o
+
+AMD_SWSMU_SMU13MGR = $(addprefix $(AMD_SWSMU_PATH)/smu13/,$(SMU13_MGR))
+
+AMD_POWERPLAY_FILES += $(AMD_SWSMU_SMU13MGR)
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
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
