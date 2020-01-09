Return-Path: <SRS0=R6+d=26=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D885CC282DD
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jan 2020 15:40:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC1552067D
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jan 2020 15:40:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="McnClWZT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC1552067D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 48E556E440;
	Thu,  9 Jan 2020 15:40:52 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770043.outbound.protection.outlook.com [40.107.77.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EDDC46E440
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Jan 2020 15:40:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b9O/n353Ih9xrxFbJNiHlDtCwW6ktvVyMxyETKqlgdmAL/ITfDHhT6Iv6oS8uC3A/yZzK05fjuLAdDyPPr0m3IXEyGTqxZ+ESsiY4IOCeddd/kyc91AsPtM/h8jgYI218eTlKvj9tBUoOZ05mdVQfrRFdbNAfxkLpF42E1beBcUau9w3sFC0XkFYvs0SS6zDNDUFfD6pdLFYSDvOoEVy3+et4VXvSzbNvLDpmLgsF7rP0yNZJtv2WT5buy19IFZ0/Y+boPYnVJQCarlsLRz8xH0v3bW2zHEE+1H2eqvV05i18far+kskg5yZGlmEOzCYLUUJqVaKiVk+7cBqihHpMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VH8G5JgZN93qwxuDoYR41OeAfVFc4eh8Eq8IwyMo/Tk=;
 b=BSg46snfu+bVVfGmC7sypYOdY5ov+BxTG0/i/SWcJLkY81VCGtBwqoTPC/u/Io/GWdDW3nkIBxqVhrA1wuUG8q9iFiArA4DcOWJaS3S12Iymx930Z2yExY1I4BgQpYjrrIjrW/00r3KpZcYoSThKRJu/1CX+/yqm0Svllru+4EopgzxheaTVcG68g4JE+YeUbQPc8EdjyPm/mfA1S79hRFc6rYnexdw9BrrL6E2gJNCPqaEKRnhBHagGSzzuQlGuzvvUcHSpxNofXWL3N7sauhAuYjXgnEwf85WWZsypgvJNdWe8eqmkbFOahdmI/XIuG61wIzUjuDfr+cEJ9tIx2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VH8G5JgZN93qwxuDoYR41OeAfVFc4eh8Eq8IwyMo/Tk=;
 b=McnClWZT9H6zZWl1Ge4vPfTtmqZ3BVOlQwb/ng0uIvY1rgO5strmnwv8w0K1xHuQDv/7D31smYKbqzzIwa4aKeSO2aQhMzcFchmcmcXSjnfWJnOlR9DeS1iljmD5dwvZ/w4942AOYG+yBq2gx/I6Lpxijo4JNd7s6+B3d9h87Do=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Tom.StDenis@amd.com; 
Received: from MN2PR12MB3935.namprd12.prod.outlook.com (10.255.237.223) by
 MN2PR12MB3231.namprd12.prod.outlook.com (20.179.83.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.10; Thu, 9 Jan 2020 15:40:49 +0000
Received: from MN2PR12MB3935.namprd12.prod.outlook.com
 ([fe80::802e:382b:9d26:d2b9]) by MN2PR12MB3935.namprd12.prod.outlook.com
 ([fe80::802e:382b:9d26:d2b9%6]) with mapi id 15.20.2602.018; Thu, 9 Jan 2020
 15:40:49 +0000
From: Tom St Denis <tom.stdenis@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/amdgpu: add missing umc_6_1_2_sh_mask.h header file
Date: Thu,  9 Jan 2020 10:40:35 -0500
Message-Id: <20200109154035.847890-1-tom.stdenis@amd.com>
X-Mailer: git-send-email 2.24.1
X-ClientProxiedBy: MN2PR19CA0052.namprd19.prod.outlook.com
 (2603:10b6:208:19b::29) To MN2PR12MB3935.namprd12.prod.outlook.com
 (2603:10b6:208:168::31)
MIME-Version: 1.0
Received: from localhost.localdomain.amd.com (165.204.84.11) by
 MN2PR19CA0052.namprd19.prod.outlook.com (2603:10b6:208:19b::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2623.9 via Frontend
 Transport; Thu, 9 Jan 2020 15:40:49 +0000
X-Mailer: git-send-email 2.24.1
X-Originating-IP: [165.204.84.11]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f0536125-0816-47ef-198f-08d7951a4d36
X-MS-TrafficTypeDiagnostic: MN2PR12MB3231:|MN2PR12MB3231:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB3231E4066DD2F620EF25C2ACF7390@MN2PR12MB3231.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 02778BF158
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(39860400002)(136003)(366004)(346002)(376002)(189003)(199004)(16526019)(36756003)(81156014)(86362001)(8676002)(81166006)(19627235002)(4326008)(66946007)(5660300002)(1076003)(2906002)(66556008)(66476007)(186003)(26005)(6666004)(316002)(6486002)(52116002)(7696005)(6916009)(2616005)(956004)(478600001)(8936002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3231;
 H:MN2PR12MB3935.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ylW1iu9eNgknWvqAk8bYhAnIqGtyOjHXkUhw9sU34ROBKav1JYmJiDbA0h8WVjX4v9ZGhzG3841m/AgbV8Fbm6QoFvvg9w6f2Gjxj01R3KOvUqokn/x93/NQjkIySN1qO14jKMYMThfIWBVlMfeFNG/DNeiT9V02OB+81C6L4utwfSkGT6OFhKzwvL4bzVT6foo8Jo4/TnPPAcwTLQL88c0uE/AqJC0waii2HkEitDu3qJaJetIPZpzgJfbwjX5Id/RscLeZbbpgOhAclQwzvAOmwovujDSatdCt7EUC8+h7Vy2kHtGKC3/Pg+WL23zFzLY11JEl4l59gc2ULqC+2F4itrKG6azcoth4sh/x/v3OtftCuYZdsmUOqnFrXlh1Oe0O2zJqeg/QdCrhtAZcVFzZeQ/FWNUZkMiB49RzN7pPuW4exH+4Ps7nOWhsM/Bi
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0536125-0816-47ef-198f-08d7951a4d36
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2020 15:40:49.5502 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mwpBJAoP71wWacPNK961QbVCintHzo36azIIF9Mkk09dqCQOYkHuxwLPgGSqqaSbNBNGchPjIushWdmfSzCHDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3231
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

Signed-off-by: Tom St Denis <tom.stdenis@amd.com>
---
 .../include/asic_reg/umc/umc_6_1_2_sh_mask.h  | 91 +++++++++++++++++++
 1 file changed, 91 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/umc/umc_6_1_2_sh_mask.h

diff --git a/drivers/gpu/drm/amd/include/asic_reg/umc/umc_6_1_2_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/umc/umc_6_1_2_sh_mask.h
new file mode 100644
index 000000000000..7c3c6d405259
--- /dev/null
+++ b/drivers/gpu/drm/amd/include/asic_reg/umc/umc_6_1_2_sh_mask.h
@@ -0,0 +1,91 @@
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
+#ifndef _umc_6_1_1_SH_MASK_HEADER
+#define _umc_6_1_1_SH_MASK_HEADER
+
+//UMCCH0_0_EccErrCntSel_ARCT
+#define UMCCH0_0_EccErrCntSel_ARCT__EccErrCntCsSel__SHIFT                                                          0x0
+#define UMCCH0_0_EccErrCntSel_ARCT__EccErrInt__SHIFT                                                               0xc
+#define UMCCH0_0_EccErrCntSel_ARCT__EccErrCntEn__SHIFT                                                             0xf
+#define UMCCH0_0_EccErrCntSel_ARCT__EccErrCntCsSel_MASK                                                            0x0000000FL
+#define UMCCH0_0_EccErrCntSel_ARCT__EccErrInt_MASK                                                                 0x00003000L
+#define UMCCH0_0_EccErrCntSel_ARCT__EccErrCntEn_MASK                                                               0x00008000L
+//UMCCH0_0_EccErrCnt_ARCT
+#define UMCCH0_0_EccErrCnt_ARCT__EccErrCnt__SHIFT                                                                  0x0
+#define UMCCH0_0_EccErrCnt_ARCT__EccErrCnt_MASK                                                                    0x0000FFFFL
+//MCA_UMC_UMC0_MCUMC_STATUST0_ARCT
+#define MCA_UMC_UMC0_MCUMC_STATUST0_ARCT__ErrorCode__SHIFT                                                         0x0
+#define MCA_UMC_UMC0_MCUMC_STATUST0_ARCT__ErrorCodeExt__SHIFT                                                      0x10
+#define MCA_UMC_UMC0_MCUMC_STATUST0_ARCT__RESERV0__SHIFT                                                           0x16
+#define MCA_UMC_UMC0_MCUMC_STATUST0_ARCT__ErrCoreId__SHIFT                                                         0x20
+#define MCA_UMC_UMC0_MCUMC_STATUST0_ARCT__RESERV1__SHIFT                                                           0x26
+#define MCA_UMC_UMC0_MCUMC_STATUST0_ARCT__Scrub__SHIFT                                                             0x28
+#define MCA_UMC_UMC0_MCUMC_STATUST0_ARCT__RESERV2__SHIFT                                                           0x29
+#define MCA_UMC_UMC0_MCUMC_STATUST0_ARCT__Poison__SHIFT                                                            0x2b
+#define MCA_UMC_UMC0_MCUMC_STATUST0_ARCT__Deferred__SHIFT                                                          0x2c
+#define MCA_UMC_UMC0_MCUMC_STATUST0_ARCT__UECC__SHIFT                                                              0x2d
+#define MCA_UMC_UMC0_MCUMC_STATUST0_ARCT__CECC__SHIFT                                                              0x2e
+#define MCA_UMC_UMC0_MCUMC_STATUST0_ARCT__RESERV3__SHIFT                                                           0x2f
+#define MCA_UMC_UMC0_MCUMC_STATUST0_ARCT__Transparent__SHIFT                                                       0x34
+#define MCA_UMC_UMC0_MCUMC_STATUST0_ARCT__SyndV__SHIFT                                                             0x35
+#define MCA_UMC_UMC0_MCUMC_STATUST0_ARCT__RESERV4__SHIFT                                                           0x36
+#define MCA_UMC_UMC0_MCUMC_STATUST0_ARCT__TCC__SHIFT                                                               0x37
+#define MCA_UMC_UMC0_MCUMC_STATUST0_ARCT__ErrCoreIdVal__SHIFT                                                      0x38
+#define MCA_UMC_UMC0_MCUMC_STATUST0_ARCT__PCC__SHIFT                                                               0x39
+#define MCA_UMC_UMC0_MCUMC_STATUST0_ARCT__AddrV__SHIFT                                                             0x3a
+#define MCA_UMC_UMC0_MCUMC_STATUST0_ARCT__MiscV__SHIFT                                                             0x3b
+#define MCA_UMC_UMC0_MCUMC_STATUST0_ARCT__En__SHIFT                                                                0x3c
+#define MCA_UMC_UMC0_MCUMC_STATUST0_ARCT__UC__SHIFT                                                                0x3d
+#define MCA_UMC_UMC0_MCUMC_STATUST0_ARCT__Overflow__SHIFT                                                          0x3e
+#define MCA_UMC_UMC0_MCUMC_STATUST0_ARCT__Val__SHIFT                                                               0x3f
+#define MCA_UMC_UMC0_MCUMC_STATUST0_ARCT__ErrorCode_MASK                                                           0x000000000000FFFFL
+#define MCA_UMC_UMC0_MCUMC_STATUST0_ARCT__ErrorCodeExt_MASK                                                        0x00000000003F0000L
+#define MCA_UMC_UMC0_MCUMC_STATUST0_ARCT__RESERV0_MASK                                                             0x00000000FFC00000L
+#define MCA_UMC_UMC0_MCUMC_STATUST0_ARCT__ErrCoreId_MASK                                                           0x0000003F00000000L
+#define MCA_UMC_UMC0_MCUMC_STATUST0_ARCT__RESERV1_MASK                                                             0x000000C000000000L
+#define MCA_UMC_UMC0_MCUMC_STATUST0_ARCT__Scrub_MASK                                                               0x0000010000000000L
+#define MCA_UMC_UMC0_MCUMC_STATUST0_ARCT__RESERV2_MASK                                                             0x0000060000000000L
+#define MCA_UMC_UMC0_MCUMC_STATUST0_ARCT__Poison_MASK                                                              0x0000080000000000L
+#define MCA_UMC_UMC0_MCUMC_STATUST0_ARCT__Deferred_MASK                                                            0x0000100000000000L
+#define MCA_UMC_UMC0_MCUMC_STATUST0_ARCT__UECC_MASK                                                                0x0000200000000000L
+#define MCA_UMC_UMC0_MCUMC_STATUST0_ARCT__CECC_MASK                                                                0x0000400000000000L
+#define MCA_UMC_UMC0_MCUMC_STATUST0_ARCT__RESERV3_MASK                                                             0x000F800000000000L
+#define MCA_UMC_UMC0_MCUMC_STATUST0_ARCT__Transparent_MASK                                                         0x0010000000000000L
+#define MCA_UMC_UMC0_MCUMC_STATUST0_ARCT__SyndV_MASK                                                               0x0020000000000000L
+#define MCA_UMC_UMC0_MCUMC_STATUST0_ARCT__RESERV4_MASK                                                             0x0040000000000000L
+#define MCA_UMC_UMC0_MCUMC_STATUST0_ARCT__TCC_MASK                                                                 0x0080000000000000L
+#define MCA_UMC_UMC0_MCUMC_STATUST0_ARCT__ErrCoreIdVal_MASK                                                        0x0100000000000000L
+#define MCA_UMC_UMC0_MCUMC_STATUST0_ARCT__PCC_MASK                                                                 0x0200000000000000L
+#define MCA_UMC_UMC0_MCUMC_STATUST0_ARCT__AddrV_MASK                                                               0x0400000000000000L
+#define MCA_UMC_UMC0_MCUMC_STATUST0_ARCT__MiscV_MASK                                                               0x0800000000000000L
+#define MCA_UMC_UMC0_MCUMC_STATUST0_ARCT__En_MASK                                                                  0x1000000000000000L
+#define MCA_UMC_UMC0_MCUMC_STATUST0_ARCT__UC_MASK                                                                  0x2000000000000000L
+#define MCA_UMC_UMC0_MCUMC_STATUST0_ARCT__Overflow_MASK                                                            0x4000000000000000L
+#define MCA_UMC_UMC0_MCUMC_STATUST0_ARCT__Val_MASK                                                                 0x8000000000000000L
+//MCA_UMC_UMC0_MCUMC_ADDRT0_ARCT
+#define MCA_UMC_UMC0_MCUMC_ADDRT0_ARCT__ErrorAddr__SHIFT                                                           0x0
+#define MCA_UMC_UMC0_MCUMC_ADDRT0_ARCT__LSB__SHIFT                                                                 0x38
+#define MCA_UMC_UMC0_MCUMC_ADDRT0_ARCT__Reserved__SHIFT                                                            0x3e
+#define MCA_UMC_UMC0_MCUMC_ADDRT0_ARCT__ErrorAddr_MASK                                                             0x00FFFFFFFFFFFFFFL
+#define MCA_UMC_UMC0_MCUMC_ADDRT0_ARCT__LSB_MASK                                                                   0x3F00000000000000L
+#define MCA_UMC_UMC0_MCUMC_ADDRT0_ARCT__Reserved_MASK                                                              0xC000000000000000L
+
+#endif
-- 
2.24.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
