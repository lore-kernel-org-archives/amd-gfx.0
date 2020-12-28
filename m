Return-Path: <SRS0=oLN9=GA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFBA1C433DB
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Dec 2020 07:03:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5C3F207D1
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Dec 2020 07:03:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5C3F207D1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E0180898CE;
	Mon, 28 Dec 2020 07:03:07 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2056.outbound.protection.outlook.com [40.107.102.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8068A898CE
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Dec 2020 07:03:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n3HLrtNn66adFTaiUDsPwYsDPwJF2zDyEXY1wirRZ9VGoxaH4TEXx0qE0S2amI4+Z9WLa0guELX+PUsBIZvheUfCwztNyJPYaxGFwnMPhBCNZ461dp6N/7SnSvQjENFdakSl/zUO4l13Glm8q+P45KEgsJhoyExq9YpqUolSpXiStV/XegtsWSkqt4KiAcS554rwrzl1+qyIWkvYiGX4xNjVp0h5ukVRA5invXya49ghgkPQ0riuEjTtfj8tUEmRc1DT6R5X0Pgy+BzioTkW68OTvPTm9OSKhOk4aVba3p2Yd1x9sg2WvEbrUy3SdLb1rggG7a/KVjMgbTeX6+MiGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KD9m1jJQ2030H0N6c0yWUS0KKpWzNVcUBswVjqqr/30=;
 b=LIVcV3dc7I/72yTmKHPuPU+ngM1ctyfCoiN8uEotM3fFT+vslzM1eTB7QPCelt9B+Z/ww9xhST5au+KPsDUT/a40FOFpQWl3BjXF4KHjfHLQtivQYe20GRYtg5lwZBI8TDOGWCCbVthPoYcObo6ANBtsexblCJ02KSaGkV7nVYQyzTAD0nzkB+IoG2c3PwjX5upb09+mBEkx1oePTSL0YYdB7/NXBZ80V1xOqCPp2Ce4W5qTrFIxKcxKzvMitTK0++73B7tG9MBCnmQVIGZmZl/HWXdwOYM7yfLxWEgg1/afrH6lD24Vqw2HR/Ys4Hay8/weLQvCilbY7+/WvQSniw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KD9m1jJQ2030H0N6c0yWUS0KKpWzNVcUBswVjqqr/30=;
 b=a+2MoLJYfMOTM4ApnzJRowp0vJByPuuoQKT2/QPKVLngexKYUa+5V8tt2UKPR7YPYHF4ZxH1nKN9N29FFSXBImFsc1LjmhV58mc23TOe9HOfT2lCD6BM8FXOTWXlVwN5kBQc00uyYWvdF8omtpfBYFrcQjVkqm9b1NXfohNA6iM=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MWHPR12MB1854.namprd12.prod.outlook.com (2603:10b6:300:114::19)
 by MWHPR1201MB2542.namprd12.prod.outlook.com (2603:10b6:300:e8::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3700.27; Mon, 28 Dec
 2020 07:03:04 +0000
Received: from MWHPR12MB1854.namprd12.prod.outlook.com
 ([fe80::38a7:197b:75f0:6030]) by MWHPR12MB1854.namprd12.prod.outlook.com
 ([fe80::38a7:197b:75f0:6030%12]) with mapi id 15.20.3700.031; Mon, 28 Dec
 2020 07:03:04 +0000
From: Likun Gao <likun.gao@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/2] drm/amdgpu: add amdgpu_hdp structure
Date: Mon, 28 Dec 2020 15:02:47 +0800
Message-Id: <20201228070248.2867202-1-likun.gao@amd.com>
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [180.167.199.189]
X-ClientProxiedBy: HKAPR04CA0001.apcprd04.prod.outlook.com
 (2603:1096:203:d0::11) To MWHPR12MB1854.namprd12.prod.outlook.com
 (2603:10b6:300:114::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from lnx-glk.amd.com (180.167.199.189) by
 HKAPR04CA0001.apcprd04.prod.outlook.com (2603:1096:203:d0::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3700.27 via Frontend Transport; Mon, 28 Dec 2020 07:03:03 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: fbb48caf-6a4d-4ff8-07ad-08d8aafe9f80
X-MS-TrafficTypeDiagnostic: MWHPR1201MB2542:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR1201MB2542FAB743446943E0E2C478EFD90@MWHPR1201MB2542.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1Zz/qCDO6RqNvp4EicRB6Xzz82gtVMl9AObnxvMTtRBrIcN1I5I0GvlyEvPStKyCPlJHrVGXbUBAuT9RQi0mS/gQH1uoYuh/tNjaQyWH2AGC3aPvhQkyDbliCnCc756PZFXAGpH4dOpCpRJkCvnk7C6KXa5QODg6TPr5J2V5uWTBy/dYRQDJa8oQKEJ6zYh+jIb678ZYRRawl1Dp+lLn3Cgmg9LbEuzPHlijYEapGW813JfZ/c9/kEHrYcNSWUlF60yfxLVH6QLztPP6sB4q1dpGcsaKtfynQtz5ZVFX0oeAi9oud0wR1NwJFUGLBBApK7JA/n3Y6t3U0m5lec9DfzzbooOwCy5vVuUIdJMwbJxAgBUUsRShkPQ3xIKPpFrhF89qqGgzuP2ZLK9RHmtAgg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR12MB1854.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(376002)(366004)(346002)(39860400002)(396003)(6666004)(5660300002)(6916009)(4326008)(186003)(54906003)(83380400001)(36756003)(2906002)(66946007)(86362001)(2616005)(52116002)(66476007)(44832011)(956004)(6486002)(7696005)(66556008)(16526019)(8676002)(478600001)(8936002)(1076003)(26005)(316002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?Qrnjtmra3QLVeE9wiZrTnw3lq2kIMzgeE6p8/ufCzjB7BlhIZ/s+SdbwbX1r?=
 =?us-ascii?Q?PR6opiL77nEH05QewcewuokCOA3+EhDhW/D/eXL9H6JPn6Yxnr6n9qVO80yF?=
 =?us-ascii?Q?wqDEQdvCyDk1sIKUZY3+i6qYpGSR16hOaSM7EVy0r3fxEkkZXpGaLhNudwMs?=
 =?us-ascii?Q?QqjzQl2/aosQQXdSspwOoq7XTlkbQXdEUgpnoIPW9jSofrlndLonArFpzU+E?=
 =?us-ascii?Q?laod5h9S2YtznvJ2FBn3LoZeMm9MmFGtRotWrXXBhtU+6hT3sPTMQTz/D7EZ?=
 =?us-ascii?Q?rhajzcD1MDnjgbHt1AXVwXe37TNBBsnztGxuylBpSzcG40W3EBIkKSRkx+nF?=
 =?us-ascii?Q?F5kIb5nB4jsJzn/2zYJg4xgTgrJ0NFTLw0pxwTdMFt+5OeUy13ca7nPhrOhF?=
 =?us-ascii?Q?YYeHn2utmO3RGTKJQXODyb9qvZJsGJvhfTXU+uN5o5DnEO+ggU0i+QxuUlt9?=
 =?us-ascii?Q?aNV77S2k7SeL2+LITSY+iBf64JsjW8Novl1pjfdiepbosVzAXn+oNWFGVnbL?=
 =?us-ascii?Q?H2Z9zdmGDLyMd++yAHQ8GHpKJoHotJQODKFghq2g0VoClVENRxbqlJa/Rogc?=
 =?us-ascii?Q?DFTR1L/7ULcCb++O9I7JYey4q9SBfQrxQ4AMUUQ8fNPZmOepfLt9eEtUDdS3?=
 =?us-ascii?Q?SWpFdGWrRFua2Uwc7DDUg4lNgNq3bgtcmx4WN7budf42sQGdICqwSrQtL5TA?=
 =?us-ascii?Q?uJlpKO+3ppkKRTIrjWGzpK/dpnlhjpbIL4u8pJ1raOsnxWSCL7eWYH3k/kJa?=
 =?us-ascii?Q?eKEDarea5pcykyxpmK+ih8kyibsaB4GTRFckgkpjEjkI2TS6rZMlJNwxskL6?=
 =?us-ascii?Q?utXidwNYPd8u8e8FVBHKZXxInu1tlcn/uDKsrAsMAX9nP6QTc0bPA3dkmWzF?=
 =?us-ascii?Q?kIG7APPieTDq/Ky89TqDVCSVv/QfoeWOrKYEeZVuVS80EZ7+VTlVntjIs+uT?=
 =?us-ascii?Q?J8NZMTFhjzL8W3ZjrXWFnJgsYt7DXEA14L4Zb+NQpqk/K0w5TEaDnaSLTn54?=
 =?us-ascii?Q?AMsE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: MWHPR12MB1854.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Dec 2020 07:03:04.6318 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: fbb48caf-6a4d-4ff8-07ad-08d8aafe9f80
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +yYF67SuDMnNAwzJiccl/8Raf8K2g2kwwmhTU3GYUcrAjvVf3vuhvPmPrMk5Yi/1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB2542
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
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Hawking Zhang <Hawking.Zhang@amd.com>

amdgpu_hdp hold all the callbacks for hdp

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h     |  4 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.h | 40 +++++++++++++++++++++++++
 2 files changed, 44 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.h

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 100a431f0792..92e9d1f1207b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -107,6 +107,7 @@
 #include "amdgpu_gfxhub.h"
 #include "amdgpu_df.h"
 #include "amdgpu_smuio.h"
+#include "amdgpu_hdp.h"
 
 #define MAX_GPU_INSTANCE		16
 
@@ -924,6 +925,9 @@ struct amdgpu_device {
 	/* nbio */
 	struct amdgpu_nbio		nbio;
 
+	/* hdp */
+	struct amdgpu_hdp		hdp;
+
 	/* smuio */
 	struct amdgpu_smuio		smuio;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.h
new file mode 100644
index 000000000000..43caf9f8cc11
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.h
@@ -0,0 +1,40 @@
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
+#ifndef __AMDGPU_HDP_H__
+#define __AMDGPU_HDP_H__
+
+struct amdgpu_hdp_funcs {
+	void (*flush_hdp)(struct amdgpu_device *adev, struct amdgpu_ring *ring);
+	void (*invalidate_hdp)(struct amdgpu_device *adev,
+			       struct amdgpu_ring *ring);
+	void (*reset_ras_error_count)(struct amdgpu_device *adev);
+	void (*update_clock_gating)(struct amdgpu_device *adev, bool enable);
+	void (*get_clock_gating_state)(struct amdgpu_device *adev, u32 *flags);
+	void (*init_registers)(struct amdgpu_device *adev);
+};
+
+struct amdgpu_hdp {
+	const struct amdgpu_hdp_funcs		*funcs;
+};
+
+#endif /* __AMDGPU_HDP_H__ */
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
