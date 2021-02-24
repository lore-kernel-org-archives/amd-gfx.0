Return-Path: <SRS0=z84W=H2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2914EC4332D
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:19:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E767F64F03
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:19:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E767F64F03
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C1F466EB33;
	Wed, 24 Feb 2021 22:19:42 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2049.outbound.protection.outlook.com [40.107.92.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 249BF89DD5
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Feb 2021 22:19:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qtz6Kn9Lm6JCM3692C0KtZ1GAb9aNkYQ+BYvPNYLjOkuX14uF0XPoMtGogipUpEzziGO/4yFzSpTQXtYPzW+sFR4k+4AwhZmJsQzSryaLjlCxLgjMW+kHsjMXoZc1qokvFONaBzdGlADmCpeAHZajoDqxUNKD5Xpbx94obZNAhYsixq2XT/x0Vk79gZrWIxXKsumMPtZapbTOUVZVYaHw+QtLtKdIyWh4+1VLv0DKte6YdHQmaWebD88juKQtaMKx2BWDK1inFTHiv6YF5bVItgNQmzJpITJM7MJW+njH2iFk194aPyGCey4M1X/9GjTvhxFtY9SZVo2m1c+eaXRpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TTOS8WGtTT4K0XO4QAmqTuAeKW0bvj0Jao0ag3RzsNI=;
 b=RGo4DSlVXcoT8XzFzukwj+y57XAn40FKzDBIuGBmLgAAp5HsKtIKBCBgciCw+90DSc5DQx0GDBHJGmgOJ8f+9B6ZRJ9qMxjP7iEWFEMwKaZ5xjWHuExO3OBixqqvRiz/xZXbNECH97MPnxD+O7sBgj81AhM1T4o3Fc1Lht8qB4udho6c2p0DUMoyRcl/HNvwCngREdx65xzB4iITm60WwCDSHhHGS6IX11GZLR8aLd/QsiA1HIuVlF7/EnxR0VZBJGxJsFgCWsVbKTKeYK2aBExS2gOeGzSExt+iKCKv3rOkl8JM6vCBYqQCwIksX0uz25cX/TfSuszyC/K0br5Orw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TTOS8WGtTT4K0XO4QAmqTuAeKW0bvj0Jao0ag3RzsNI=;
 b=DbEH3498vj8GzJFPWpw5t753DxUQzawIM8HllzoNejiWT5GGR02YeqwblwaeCJqcSpYjutor8H5SFGyWtBb/XaLbQ4Fw2iyJoRlCrMXFc2ng8VVMYgurmv3w351T0tEkQEbPhPP1pc9naZuoWN6tUMzEoBr1X36Ec5Tq02NOlFg=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4174.namprd12.prod.outlook.com (2603:10b6:208:15f::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.27; Wed, 24 Feb
 2021 22:19:36 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af%7]) with mapi id 15.20.3868.033; Wed, 24 Feb 2021
 22:19:36 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 025/159] drm/amdgpu: init sos microcode for psp v13
Date: Wed, 24 Feb 2021 17:16:45 -0500
Message-Id: <20210224221859.3068810-18-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210224221859.3068810-1-alexander.deucher@amd.com>
References: <20210224221859.3068810-1-alexander.deucher@amd.com>
X-Originating-IP: [192.161.79.246]
X-ClientProxiedBy: BLAPR03CA0027.namprd03.prod.outlook.com
 (2603:10b6:208:32b::32) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.246) by
 BLAPR03CA0027.namprd03.prod.outlook.com (2603:10b6:208:32b::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19 via Frontend
 Transport; Wed, 24 Feb 2021 22:19:35 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e05f4d21-65c5-4b0b-ab62-08d8d91244a0
X-MS-TrafficTypeDiagnostic: MN2PR12MB4174:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB41745152272BF569F1B8CA02F79F9@MN2PR12MB4174.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QufmrO9aRrumSRm7eRMK/Fh8hkV6TgK2HsLLPy7YtPo4iro2c5uyNzqB0PmyP+y8Kp91Fyn6Ej3Kba5ABijltZ7ByyNHffPgWo/OzV+zRUwKBVfstVfCs8gJzoDa8h16e79KIjz/zRYvVv6u7V5YQXOo4DddevqQV+n2eabRu/pTSl5JCedJu0yD61tiHzK3fIiQoiPU779wegvvllW2s/zZ+D1dgj9rKrM+w6nXJm8TQTQn3DiVjeByx5y2Oyeviokk+QyqEOoaLiF9lzyuhJDYhBF6TQ6LvEL1NE6vD5vf1vJr1ZD1oNY/77Bn0LZFMXl5M7f2MpTmG9IXP/jBWXy2S0ww6+mcUDWqzTOrO7HLtOpooRBEmPLJXX/u/IfnsFmBZrfDZqRiw4Ja6lYvpicmB0t6iVsPHZ4E3b2Be4/DDLwJ1oSqOJlsZGMS81ckotHBu5tuVFfU38Yc4oEfykrcRsGA0us5ybs4js83efT24xhq/UoOczirlmrCBmQVa9/BgBX2OYbzNtCntjYvpiI+tSQmz8m7A45nil78R/ZkVGhONx7MXylBUESfDr0m56hMJg3K93MLTjc8RYtFnA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(396003)(39860400002)(376002)(366004)(346002)(8936002)(52116002)(4326008)(186003)(2616005)(83380400001)(1076003)(956004)(6506007)(26005)(6486002)(6512007)(54906003)(66556008)(316002)(2906002)(86362001)(66476007)(66946007)(6916009)(16526019)(6666004)(69590400012)(36756003)(5660300002)(478600001)(8676002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?UGGPgwIsuEsNPPdZNcQsuOLODy7rcN8WaRRq0lMHzliHWeL6Pu/o0Blr3Z9Q?=
 =?us-ascii?Q?2JDhgmOL/zuYOpRRmZZP00NRMJg3XLbrBxs6cybd+uHLAxocRXwc/5r4tZlO?=
 =?us-ascii?Q?ZttUYmfH1Bk+qZt/BI0Ldp3+M01WrrZPkACCHEN4FjeKkctaGCWIhx4y9GJ5?=
 =?us-ascii?Q?F07Chc73XyN9CZHxWw694UL9KrsEEV3zQVh8J5I4GBE3umbpCwWAsYhGrQu8?=
 =?us-ascii?Q?vQfNBuoox9fbE5KiHMokB8pUKoWwoADmBUVfz5+GDJGlWe6FWzSEsAnof+X9?=
 =?us-ascii?Q?CLb0kQ9HxbV92xzQK57a1+PBZNTzGZKgToWNADDJ+YWhu0vtWlpAg1hkBX/Q?=
 =?us-ascii?Q?QmYB4kWB/EjPSjf74ePxRYMgPiMGlohIga9qpEX8UMgt0viFmABpKaBRawli?=
 =?us-ascii?Q?ssyuAD4AOKveOdRYOP+eWnaPkNkNpQkbuUORmCU/5tppV1x+wDReuaaJh/wE?=
 =?us-ascii?Q?7UQgnQTTjvCG4yggIreayb1UZ57SE5i1+k6gkbQ9jsvUVEYBliPVRWsP4x4B?=
 =?us-ascii?Q?kBvCmAaK+Dtk3SJpiaSqjBaCxnkriUHQ9q6H77j3L6S0RKnKVF8l8IwHb3df?=
 =?us-ascii?Q?+y7CP/ScKeJTBQOyHyjWnGBwl9uIYvScF68+PL3ZEWoK5wNJ7Xn8ev+yt9eT?=
 =?us-ascii?Q?345bmd4+pc4hW3THEr4+Qoax+ntNIlcGXkG9pLymPSyMk11VKgf18s2NLmTu?=
 =?us-ascii?Q?BiRFCGWlgvmhv9rX63bPZz/Y5zi4/yJL4xJ2xtvZWXDhy2hkk3PammJnlDJW?=
 =?us-ascii?Q?TUkkVzYK3X0fNz7qPMtV/1/WA9Up759gNHfUNSlfor46IHzWt9Qyh8GWpKiW?=
 =?us-ascii?Q?QTmAtrek8KjOyErHXCP3Worm7sK1Qjy97PbKxqMH+MXmZQfgMTssh/rcXM6j?=
 =?us-ascii?Q?ffd1ZPLf/svZle6o3Bdz9KaAo4mm5U+6mThW+ACIhe/lvxlIOJV4oVeG1T1Z?=
 =?us-ascii?Q?bAS4wLQJlsaVP9vG37Lp73j3JR4t3irSgv43UUUuo5FUP7fKz3RsrFFYWPrN?=
 =?us-ascii?Q?tNNIU4sZEqtmEMpPsPcGzgwHDkd+w8jemmAY77BjNRHI2FdZp4wdrckjLrMa?=
 =?us-ascii?Q?DRxyiOt92ra8y33xXHj2MM4cUxYxA7Iy01UT+MQhYFPDKIYcDnvDPSqPQow1?=
 =?us-ascii?Q?Zp1nMhnGWMQUxw3qAZkRKhDSRZ9xmOhZV4NAqTmYvpKM/a47GC4+tBKiZVuE?=
 =?us-ascii?Q?hQGoH6hz80padtig2hgCkihywRMJ8xaX+lJGYNQiZGvcunuEW476rdb6GnFn?=
 =?us-ascii?Q?HdwtTS9PArpsHX9BMB0IG9dh08E7La87P9tz7owKYakvThYHVQP/Vt12EcbU?=
 =?us-ascii?Q?iT+3vFQ9uRw2h26MBGENoIqN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e05f4d21-65c5-4b0b-ab62-08d8d91244a0
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2021 22:19:35.9313 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MQKHuVPu8oPtm+XFcMzVax3f08WFGWNwr6nLSOfY6B000+DfvKP2W/VF1GlPrTbtTc4Ke3oze2YbGtI+beSCig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4174
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Le Ma <Le.Ma@amd.com>,
 Kevin Wang <kevin1.wang@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Hawking Zhang <Hawking.Zhang@amd.com>

Initialize sos microcode for aldebaran

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Le Ma <Le.Ma@amd.com>
Reviewed-by: Kevin Wang <kevin1.wang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Makefile    |  3 +-
 drivers/gpu/drm/amd/amdgpu/psp_v13_0.c | 57 ++++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/psp_v13_0.h | 30 ++++++++++++++
 3 files changed, 89 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/psp_v13_0.h

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index 95afdbda0b44..5c9279b15ada 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -107,7 +107,8 @@ amdgpu-y += \
 	psp_v3_1.o \
 	psp_v10_0.o \
 	psp_v11_0.o \
-	psp_v12_0.o
+	psp_v12_0.o \
+	psp_v13_0.o
 
 # add DCE block
 amdgpu-y += \
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
new file mode 100644
index 000000000000..ad0328fc640c
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
@@ -0,0 +1,57 @@
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
+#include "amdgpu.h"
+#include "amdgpu_psp.h"
+#include "amdgpu_ucode.h"
+#include "soc15_common.h"
+#include "psp_v13_0.h"
+
+MODULE_FIRMWARE("amdgpu/aldebaran_sos.bin");
+
+static int psp_v13_0_init_microcode(struct psp_context *psp)
+{
+	struct amdgpu_device *adev = psp->adev;
+	const char *chip_name;
+	int err = 0;
+
+	switch (adev->asic_type) {
+	case CHIP_ALDEBARAN:
+		chip_name = "aldebaran";
+		break;
+	default:
+		BUG();
+	}
+
+	err = psp_init_sos_microcode(psp, chip_name);
+
+	return err;
+}
+
+static const struct psp_funcs psp_v13_0_funcs = {
+	.init_microcode = psp_v13_0_init_microcode,
+};
+
+void psp_v13_0_set_psp_funcs(struct psp_context *psp)
+{
+	psp->funcs = &psp_v13_0_funcs;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.h b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.h
new file mode 100644
index 000000000000..b2414a729ca1
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.h
@@ -0,0 +1,30 @@
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
+#ifndef __PSP_V13_0_H__
+#define __PSP_V13_0_H__
+
+#include "amdgpu_psp.h"
+
+void psp_v13_0_set_psp_funcs(struct psp_context *psp);
+
+#endif
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
