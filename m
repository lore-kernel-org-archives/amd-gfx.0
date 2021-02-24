Return-Path: <SRS0=z84W=H2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 152CCC43381
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:21:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBF7864ED6
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:21:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBF7864ED6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 386746EB5D;
	Wed, 24 Feb 2021 22:21:07 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2077.outbound.protection.outlook.com [40.107.93.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C3976EB58
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Feb 2021 22:21:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jvc3xUsdF9hY5axqbYD4aFcyrXhhNRu9HnsAnpsgBMgUEVBMoVPUDKHvhzVx6nQRsRpShSf2xp2+W0NhoYXY/cVVCl2cNSrgBVw3Mnuevu39kSAqRgYOM6EERTDtSxWmEk2OA4pXmkCb5+fRdqdgXz0X8Jzl9T9iEnXVlfrIYH4U1Z8olwpkc0oSW6eXOxrsfKwMyqOYo2xdYm/iZnOwpttLhzFlSK0Bh8hJh8IAh9qjaG1+gt7CqGHuzIs9oIChqhGR7kDp/STTJkIOg1zlgQtfD/pKejYALbRNkeCyGKOM9NfQ6UMcZP7iMq327YiM1Op2KerqDvx0bZAW28vTCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TS9jI/2mvCWlDsrflGtx6+VUiCTKmruKlQMNHyYeA2c=;
 b=CFjfNxhgYOtCMvRgsAomE25Ocgj7iwarJ/CTKAvZhm/3GYXiKcV1IMTyQALFd1AHuLZYjrY2MB2mHqWg/t3wD+1AHze7nMQMj8XW51FAcHftk4lvgJT67h+R5naKvtpb/CSAs2+9eviiqHMssZiPZsBrbDa+ksrOYDMxYe1TG/qwUZXzU1M9DsjPqczhV6VBLfFAf7FzZY4Km4L336SxIFQLcRqrVFSElz1WS+fADurhLOKsoDEVHNxbcpmnzfW546wXfF7L6p4Fpoke+FK7kAFSkqYiuGDlePJCp0gWvJudALNGB1yFklINyX+JrKvaRYgF3Ja99kLJ6G+7L+6KgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TS9jI/2mvCWlDsrflGtx6+VUiCTKmruKlQMNHyYeA2c=;
 b=RA/C2wGxVFusdQPKO1j0PEYXT1som226YWkSnYnRkv/Dx17LHlJL0nxcFZ9x5cYIXI/8BwhuApjKqJHrA/2WoDzDz4wCxZsA1UkYBjPFx40ehFpHKDlweATHEa6x4ynlQdGkPyv5lTpMWG4FEDPFJcjPXblZS6yp7xCWxdJnor8=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by BL0PR12MB2497.namprd12.prod.outlook.com (2603:10b6:207:4c::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Wed, 24 Feb
 2021 22:21:04 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af%7]) with mapi id 15.20.3868.033; Wed, 24 Feb 2021
 22:21:04 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 076/159] drm/amdgpu: add sdma v4_4 ras function
Date: Wed, 24 Feb 2021 17:17:36 -0500
Message-Id: <20210224221859.3068810-69-alexander.deucher@amd.com>
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
 Transport; Wed, 24 Feb 2021 22:20:11 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 30256d7e-ba86-45a2-2cb2-08d8d9125a49
X-MS-TrafficTypeDiagnostic: BL0PR12MB2497:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB249740504D493AEF7C3BFD14F79F9@BL0PR12MB2497.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CLGzIDzMymbrNyfKkJSD7GJ4Fa65+/sE2IfkYZrMFPQguFEG0qkq3gMIhi+ig2CA78STUEQqwty5LEZanM18ZUKCPRym7LwQuP3YzvPC71O3VqZE5sX8h4ecSAtbYIGX3DIwlmuQ77PqZS4fQJINnpyjDYrYX3uY3xH55Jyn1jsfT345PUj2HjLCuFoho9DgE4M5euNtA4Z21UovZC73ceez6ijQKSHP29uXA7DH75d7RQRbQuJFUGSOSTE8tW0THRRHM/K3IfjfdDZ/vgu4rYH7nCp0fujjbrhT4pcKp+JXDs9cuE1wDV+MW81QYR5HDW4rXphd7d/Gw1ftdZ2ekNlI1QpiWTr3FsiRXPtHI3TmIuvWQhLVQjedNnuQsId2Z7g7pb/3dy2dtvZTWfpJov9n3XCzPEryfwluNdwALIkyojnJ+vA2wkFhv8k5nUeJiTzflKyjA/ueQp5A3NvJimf9QUaOjvaB71AnrPpyza0oBYy6Sr4t2En9UMojLybPk9CuRkL72ZlVn5r5DNIU6u3g90rRzkkHzKVmrwuWtJngxW7ZQ9nTIiIZy59FH03r0zqOSLFcWmcj0npvrcvygg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(366004)(346002)(396003)(39860400002)(136003)(4326008)(69590400012)(8936002)(6512007)(54906003)(6916009)(26005)(956004)(6486002)(316002)(2616005)(52116002)(8676002)(6506007)(2906002)(86362001)(186003)(16526019)(36756003)(6666004)(478600001)(83380400001)(66946007)(66556008)(66476007)(1076003)(5660300002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?Xvfog0AozJD560GDAI+emTFBJACEHXVYjuElIQAW+gJC5wacfvuFf9gubI46?=
 =?us-ascii?Q?jWoKLNMZleC/SJlTKAxHAGOW55msdIUdVT7huDIQ2oKRLnWI6UsnjCnCxS97?=
 =?us-ascii?Q?MKGbZTbuHsb44c7tZKtP4NSTukgBP1SXI99eeaJSjtb8BiaTGsyXf87+LVP5?=
 =?us-ascii?Q?6iL2opLNnJFgRhTyAupaEuAYHgsZplrjrLnDmvyo7dsZppf57j/9UDAIfACG?=
 =?us-ascii?Q?jDF/3T5/Dpsh4gBV7cuhUXcJu456RMCx6o4/bPBwJbr5c3Gjzj35+ZDFypHS?=
 =?us-ascii?Q?7jdkn/VdKcGZcVzJ6c7oSakdxDYFVzfSwiNVd5ddYdzT2k2HRmSISF6pNU8P?=
 =?us-ascii?Q?2hinkBuYZjdLvdvZVvdKzyk4bz8RvYXUrI8bPQcBCktX2fjln0tnhdWRNWp3?=
 =?us-ascii?Q?OvYXWWU+PJkwwlxY1d9yxDlRchU7kllrjspU7kEpOkdn0sEQFKMehLD98NwD?=
 =?us-ascii?Q?n2wVQQVF7OiN+mej5IVFHlmVdhjzsQEZL0kE6IpDVCnkS2DraXYPdSJYGkPq?=
 =?us-ascii?Q?q03hBOoE/g44HsjdahzTe15a+C8Q7Z4oARMHp7XWARPu6yyMop5fyVGLxjcM?=
 =?us-ascii?Q?akiV+IZdrGVH8LucJkZvCnidnRC2pgHFnMwzHvzf06aY80OCDp0754+g9mQs?=
 =?us-ascii?Q?PtgPrHsVyamFuskSb+WdMtsNwg4OVWf34U4jxgT9EPF6N3kPfv8VVxgw/KgE?=
 =?us-ascii?Q?6GZ1Tw6DMvafxhzzPR0ufOPRMrS6kUCiHy4yYF5X0o6wX5wsbFDDy0mD2o3V?=
 =?us-ascii?Q?HMQSyjZcfkV8oEC2MOqFY1uaFO4jKQaHHI5lKzLxZgOXzCsDbnMuyWz204ZN?=
 =?us-ascii?Q?NvYhK6M0PHFfEPSzybixIguK94lo4tgYiRORQmeiEVExNiP0a3G5f9jjuDwA?=
 =?us-ascii?Q?Db1eX/WweIsCgx5oOY0XHE7fJtwgL6BMwh6hYc54mSz5Yo5vWQcGps0SCVqC?=
 =?us-ascii?Q?5NVTJI4fQ+elZz8Q7GDt6WnH3o2HeCIJVGjUC46jwOZT0uU42oKYvkBrxc98?=
 =?us-ascii?Q?xPnQNPaZgJXbejVFNG82J8I6jzcj2vJhbFHya63zqEHZwgSh2Ht0H0IrSHeV?=
 =?us-ascii?Q?hKb9jn/Ypqgj5RxA/2I9rY1UsXeQ4B6VkIQvAlCnYKv9/kLe1u+mSmADBln7?=
 =?us-ascii?Q?XjvYlRE7RMZB90nSF6I0+Uhmznl2oqEspGiRfzSMdiKZy3UNsZUQHkKj1+3Y?=
 =?us-ascii?Q?/+5ThseSTwYdKZuGT5Y2PGkBo2jzzLJSmmcU9QzhYcse1p+J4UqjcD5mU5h9?=
 =?us-ascii?Q?HXVOEXbp23sr8+QZINz0TGd1IicxoFdRFVsAilsq9QXaPi58h49Uo8MS+mAQ?=
 =?us-ascii?Q?BvlSMpan6bzgxyMQlha9OVvo?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30256d7e-ba86-45a2-2cb2-08d8d9125a49
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2021 22:20:12.2180 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D70hFR8W1PO8AkRG+m5/9HLzoqxBZO1KudxnYl61moqqxTgkHynw9J9hpEUOMuLmqaA2Wzk6UzCfzYaGH6N+5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2497
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Dennis Li <Dennis.Li@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Hawking Zhang <Hawking.Zhang@amd.com>

sdma ras function is the main structure to support
sdma ras on aldebaran. the patch initializes late_init
late_fini callbacks.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Dennis Li<Dennis.Li@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Makefile    |  1 +
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c |  4 ++++
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4.c | 28 ++++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4.h | 28 ++++++++++++++++++++++++++
 4 files changed, 61 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/sdma_v4_4.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/sdma_v4_4.h

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index 82a99dd2df4b..17d9a3e798e2 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -131,6 +131,7 @@ amdgpu-y += \
 	sdma_v2_4.o \
 	sdma_v3_0.o \
 	sdma_v4_0.o \
+	sdma_v4_4.o \
 	sdma_v5_0.o \
 	sdma_v5_2.o
 
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
index 783f8dba085a..b2146b4a7682 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
@@ -56,6 +56,7 @@
 #include "ivsrcid/sdma1/irqsrcs_sdma1_4_0.h"
 
 #include "amdgpu_ras.h"
+#include "sdma_v4_4.h"
 
 MODULE_FIRMWARE("amdgpu/vega10_sdma.bin");
 MODULE_FIRMWARE("amdgpu/vega10_sdma1.bin");
@@ -2685,6 +2686,9 @@ static void sdma_v4_0_set_ras_funcs(struct amdgpu_device *adev)
 	case CHIP_ARCTURUS:
 		adev->sdma.funcs = &sdma_v4_0_ras_funcs;
 		break;
+	case CHIP_ALDEBARAN:
+		adev->sdma.funcs = &sdma_v4_4_ras_funcs;
+		break;
 	default:
 		break;
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4.c
new file mode 100644
index 000000000000..8f5bbc0d6630
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4.c
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
+#include "amdgpu.h"
+
+const struct amdgpu_sdma_ras_funcs sdma_v4_4_ras_funcs = {
+	.ras_late_init = amdgpu_sdma_ras_late_init,
+	.ras_fini = amdgpu_sdma_ras_fini,
+};
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4.h b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4.h
new file mode 100644
index 000000000000..74a6e5b5e949
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4.h
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
+#ifndef __SDMA_V4_4_H__
+#define __SDMA_V4_4_H__
+
+extern const struct amdgpu_sdma_ras_funcs sdma_v4_4_ras_funcs;
+
+#endif
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
