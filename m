Return-Path: <SRS0=Seja=5K=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACB5CC2D0E5
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Mar 2020 18:08:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E57320774
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Mar 2020 18:08:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="hiIqCwjB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E57320774
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A2CA6E7E5;
	Wed, 25 Mar 2020 18:08:52 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2085.outbound.protection.outlook.com [40.107.237.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E0EC26E7E5
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Mar 2020 18:08:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aAd4jmvmC//YnWH1MgT/ShruaqSvJ7ej/GYGhaj81o01Ln1EBe8HoylkHZUvrTc93k14pbEdg/imesZ2c4ik9OWqK6OGYt+hvgbzWDzwYEJ3FFZCMyCfTjDQtf3BAJnRTK95Drz4ipwwrs2r1ZEjAJgUqhyWTn+vWVLNinAczwZFc9iz0iT41IGDfjr0tDGIsN+x443p1e2u6+4cOv0oZQVAOdWDwkAQ8VH9fm+Q7ZUKgbBj3ANKI6r5dI9MTJ44YQiHxKYMYs2WKb02QidcnVCH0cZFKDP0YLOLEISlA0omRWSblzupLjaGW9VsorK2YjVNfOO6VnHsXQ/tqkTFhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JOsQSNyTiQx/5g6CvNApmuOVoq5mnw4lK49c100lqF0=;
 b=nqqDb13B66SY4jc8pngyyBBs5zmdyhmhcLTqiM1wkNqCCTsZ3Ef0hR2KUmJn62KJfux+Gfk1Pv6AfvnGH/3XwqbnM2IFAI/N6daLI5ZbUrWNShC1/+O1y8a3gb/Dnl9wFLX5vjFPckx0BCcFQOOimUQ0u8oOIOMMeSExA/SJhmbht+bm37PEFJpE58lL3hDRC9ssAi4+jUkG6p+usiZPbnLN3wrFGuFm5emzggZkHFdaDB5FmzVPgTGJl9Z/p8EOD4dAp6gCUYVwCJwbKjwkMQCHUQC0QK0KU/vYoJiEBwH57P3S/zo5c1yV9ILVdXr1D89970W0ZsT2Li9w/i9w6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JOsQSNyTiQx/5g6CvNApmuOVoq5mnw4lK49c100lqF0=;
 b=hiIqCwjB1C/8LnUUzBdvguj3++77GNTMq2DF85bSMuS+8P2QWYxsJkFu/V9TGdrvXfHyJHIDM++IbOYNDS3I339Yl12paLFMnIfwR7R8mJ7amp+p27SaNeRWpNvnNOUsObp57tUEzVzhYwSf9bDyWhRtz6SAWeLSldipw+JK/Zk=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Tom.StDenis@amd.com; 
Received: from DM5PR12MB1674.namprd12.prod.outlook.com (2603:10b6:4:11::15) by
 DM5PR12MB1148.namprd12.prod.outlook.com (2603:10b6:3:74::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.18; Wed, 25 Mar 2020 18:08:49 +0000
Received: from DM5PR12MB1674.namprd12.prod.outlook.com
 ([fe80::c0af:ab9b:b8de:7c4d]) by DM5PR12MB1674.namprd12.prod.outlook.com
 ([fe80::c0af:ab9b:b8de:7c4d%4]) with mapi id 15.20.2835.023; Wed, 25 Mar 2020
 18:08:49 +0000
From: Tom St Denis <tom.stdenis@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/2] drm/amd/amdgpu: Add missing SMUIO v12 register to headers
Date: Wed, 25 Mar 2020 14:08:38 -0400
Message-Id: <20200325180839.469615-1-tom.stdenis@amd.com>
X-Mailer: git-send-email 2.25.1
X-ClientProxiedBy: BN6PR19CA0055.namprd19.prod.outlook.com
 (2603:10b6:404:e3::17) To DM5PR12MB1674.namprd12.prod.outlook.com
 (2603:10b6:4:11::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain.amd.com (165.204.84.11) by
 BN6PR19CA0055.namprd19.prod.outlook.com (2603:10b6:404:e3::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.18 via Frontend Transport; Wed, 25 Mar 2020 18:08:48 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [165.204.84.11]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: df0eded1-12d8-42dc-030a-08d7d0e7911e
X-MS-TrafficTypeDiagnostic: DM5PR12MB1148:|DM5PR12MB1148:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1148547908E9BC71E7F405B4F7CE0@DM5PR12MB1148.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 0353563E2B
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(376002)(346002)(136003)(396003)(39860400002)(6916009)(6486002)(81156014)(81166006)(66946007)(5660300002)(1076003)(66556008)(66476007)(8676002)(478600001)(8936002)(36756003)(2906002)(16526019)(6666004)(956004)(86362001)(186003)(316002)(2616005)(7696005)(52116002)(4326008)(26005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1148;
 H:DM5PR12MB1674.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UrhKV1XRVMK2dj7rSseAEW66QEUqsNxAB+qcvyH/0TEaVFu3QFDNeQbFsFmQDfYxM/MIhKLTsKxgeMUdwLqDcpu4ogryPoHTqVH2OptZb+QRVWjQvNEOgj9EwPRccvbN8/7PikyW+px1lw/06mLlW8boc5FNaTWOK8RkW+rz6BY+L1socqczJHXa49fpR3+mmiGnIIKD4P/BH1AHmAmZPst+zaX4hQFLMjpDdeiqSK58tEfEPPG2XYZJaly7ieXbZBvA4t/bsHbbamvm0M6bLxZR1SPzZwBp88rqOmOjh120cNCv/EYgAFHBmUh6YUmMvUSzIl2IcYontYK5XjV+V0bmBP+0XVGERuxQzmT8O9gefhQDLssZ06/E7SiFJ6/p8l9+iQJj3cWZVS07vpPtpI/Oen+p7IYN6+WgDgZTmbCojoNvxnFDEizokwskFeHK
X-MS-Exchange-AntiSpam-MessageData: QZGCzM24Ti1mu1Nceas8gfhtRiIlan6bjNiCG/GN1fqlnMQgmcVQJ5N5q+lB1+/z15S0/v0wx0pnNOpANeXL35z9VD9fhngKA8JumgwfwpgZXRVhe/PkCwgSoUzLKuusvnInw0Yh2yy4/5fr7VDhVQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df0eded1-12d8-42dc-030a-08d7d0e7911e
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2020 18:08:49.1488 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YTCUEgr6pJXRGthg0Fiujdo5VkGlt0JpgCldMt374oYvR4jhZXFv3i4mxLhmpYWX0u4K5ZrZEYO9pBvVRx0O5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1148
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
Cc: Tom St Denis <tom.stdenis@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This register is needed by umr.

Signed-off-by: Tom St Denis <tom.stdenis@amd.com>
---
 .../asic_reg/smuio/smuio_12_0_0_offset.h      | 27 ++++++++++++++++++
 .../asic_reg/smuio/smuio_12_0_0_sh_mask.h     | 28 +++++++++++++++++++
 2 files changed, 55 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/smuio/smuio_12_0_0_offset.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/smuio/smuio_12_0_0_sh_mask.h

diff --git a/drivers/gpu/drm/amd/include/asic_reg/smuio/smuio_12_0_0_offset.h b/drivers/gpu/drm/amd/include/asic_reg/smuio/smuio_12_0_0_offset.h
new file mode 100644
index 000000000000..327b4d09f66d
--- /dev/null
+++ b/drivers/gpu/drm/amd/include/asic_reg/smuio/smuio_12_0_0_offset.h
@@ -0,0 +1,27 @@
+/*
+ * Copyright (C) 2020  Advanced Micro Devices, Inc.
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
+#ifndef _smuio_12_0_0_OFFSET_HEADER
+#define _smuio_12_0_0_OFFSET_HEADER
+
+#define mmSMUIO_GFX_MISC_CNTL                                                                          0x00c8
+#define mmSMUIO_GFX_MISC_CNTL_BASE_IDX                                                                 0
+
+#endif
diff --git a/drivers/gpu/drm/amd/include/asic_reg/smuio/smuio_12_0_0_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/smuio/smuio_12_0_0_sh_mask.h
new file mode 100644
index 000000000000..d815452cfd15
--- /dev/null
+++ b/drivers/gpu/drm/amd/include/asic_reg/smuio/smuio_12_0_0_sh_mask.h
@@ -0,0 +1,28 @@
+/*
+ * Copyright (C) 2020  Advanced Micro Devices, Inc.
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
+#ifndef _smuio_12_0_0_SH_MASK_HEADER
+#define _smuio_12_0_0_SH_MASK_HEADER
+
+//SMUIO_GFX_MISC_CNTL
+#define SMUIO_GFX_MISC_CNTL__PWR_GFXOFF_STATUS_MASK                                                           0x00000006L
+#define SMUIO_GFX_MISC_CNTL__PWR_GFXOFF_STATUS__SHIFT                                                         0x1
+
+#endif
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
